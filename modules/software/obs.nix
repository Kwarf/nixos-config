{ den, ... }:
{
  den.aspects.software.provides.obs = {
    includes = [
      (den.aspects.services._.flatpak._.addPackage "com.obsproject.Studio")
      (den.aspects.services._.flatpak._.addPackage "com.obsproject.Studio.Plugin.OBSVkCapture")
      (den.aspects.services._.flatpak._.addPackage "org.freedesktop.Platform.VulkanLayer.OBSVkCapture/x86_64/25.08")
    ];
  };
}
