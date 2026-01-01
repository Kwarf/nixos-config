{config, ...}: {
  config.environment.persistence."/persisted" = {
    enable = true;
    hideMounts = true;
    directories = [
      "/var/lib/nixos"
    ];
    files = [
      "/etc/machine-id"
    ];
  };
}
