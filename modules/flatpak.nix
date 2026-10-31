{ inputs, ... }:
{
  imports = [ inputs.nix-flatpak.nixosModules.nix-flatpak ];

  services.flatpak = {
    enable = true;
    uninstallUnmanaged = true;
    uninstallUnused = true;
    update.onActivation = true;

    packages = [
      "com.obsproject.Studio"
      "com.obsproject.Studio.Plugin.OBSVkCapture"
      "com.valvesoftware.Steam"
      "org.freedesktop.Platform.VulkanLayer.OBSVkCapture/x86_64/26.08"
    ];
  };

  # Installed apps and runtimes, these are far too large for the tmpfs root
  preservation.preserveAt."/persistent".directories = [ "/var/lib/flatpak" ];
}
