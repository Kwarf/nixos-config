{ config, pkgs, ... }:
{
  security.tpm2.enable = true;
  security.tpm2.pkcs11.enable = true; # Exposes /run/current-system/sw/lib/libtpm2_pkcs11.so
  security.tpm2.tctiEnvironment.enable = true; # Sets TPM2TOOLS_TCTI and TPM2_PKCS11_TCTI

  users.users.kwarf.extraGroups = [ "tss" ];

  environment.systemPackages = [ pkgs.ssh-tpm-agent ];

  # Loads the TPM sealed keys in ~/.ssh. The package ships no units, these follow upstream's.
  systemd.user.services.ssh-tpm-agent = {
    description = "ssh-tpm-agent service";
    requires = [ "ssh-tpm-agent.socket" ];
    environment = {
      SSH_TPM_AUTH_SOCK = "%t/ssh-tpm-agent.sock";
      SSH_ASKPASS = config.programs.ssh.askPassword; # There's no terminal to ask for the key's PIN
    };
    serviceConfig = {
      ExecStart = "${pkgs.ssh-tpm-agent}/bin/ssh-tpm-agent";
      SuccessExitStatus = 2;
    };
  };
  systemd.user.sockets.ssh-tpm-agent = {
    description = "SSH TPM agent socket";
    wantedBy = [ "sockets.target" ];
    socketConfig = {
      ListenStream = "%t/ssh-tpm-agent.sock";
      SocketMode = "0600";
    };
  };

  # Only one agent can own SSH_AUTH_SOCK, and GNOME's can't use TPM sealed keys
  services.gnome.gcr-ssh-agent.enable = false;

  # A forwarded agent keeps priority over SSH
  environment.extraInit = ''
    if [ -z "$SSH_AUTH_SOCK" -a -n "$XDG_RUNTIME_DIR" ]; then
      export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-tpm-agent.sock"
    fi
  '';
}
