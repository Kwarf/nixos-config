let
  mkFontReplacement = from: to: ''
    <match target="pattern">
      <test qual="any" name="family" compare="eq"><string>${from}</string></test>
      <edit name="family" mode="assign" binding="same"><string>${to}</string></edit>
    </match>
  '';
in
{
  den.aspects.software.provides.fonts = {
    homeManager = {
      fonts.fontconfig = {
        enable = true;

        defaultFonts = {
          emoji = [ "Noto Color Emoji" ];
          monospace = [ "Adwaita Mono" ];
          sansSerif = [ "Adwaita Sans" ];
          serif = [ "DejaVu Serif" ];
        };

        configFile = {
          replacements = {
            enable = true;
            label = "replacements";
            text = ''
              <?xml version="1.0"?>
              <!DOCTYPE fontconfig SYSTEM "urn:fontconfig:fonts.dtd">
              <fontconfig>
              ${mkFontReplacement "Helvetica" "Adwaita Sans"}
              </fontconfig>
            '';
          };
        };
      };
    };
  };
}
