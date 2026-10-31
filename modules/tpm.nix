{ pkgs, ... }:
{
  security.tpm2.enable = true;
  security.tpm2.pkcs11.enable = true; # Exposes /run/current-system/sw/lib/libtpm2_pkcs11.so
  security.tpm2.tctiEnvironment.enable = true; # Sets TPM2TOOLS_TCTI and TPM2_PKCS11_TCTI

  users.users.kwarf.extraGroups = [ "tss" ];

  environment.systemPackages = [ pkgs.ssh-tpm-agent ];
}
