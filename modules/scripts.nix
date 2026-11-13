{ lib, pkgs, ... }:
{
  # Personal scripts, kept as plain files in ./scripts. Each one lists the tools it needs on its PATH.
  environment.systemPackages = [
    # Also on the PATH directly, to set up the remote and manage uploaded files by hand
    pkgs.rustfs-cli

    # Uploads OBS replays and copies their URLs. Expects an rc remote named `captures`, set up by hand since it holds the access keys.
    (pkgs.writers.writeFishBin "upload-gameplay" {
      makeWrapperArgs = [
        "--prefix"
        "PATH"
        ":"
        (lib.makeBinPath [
          pkgs.rustfs-cli
          pkgs.wl-clipboard
        ])
      ];
    } ./scripts/upload-gameplay.fish)
  ];
}
