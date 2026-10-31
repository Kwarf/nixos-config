{
  fonts.fontconfig = {
    defaultFonts = {
      emoji = [ "Noto Color Emoji" ];
      monospace = [ "Adwaita Mono" ];
      sansSerif = [ "Adwaita Sans" ];
      serif = [ "DejaVu Serif" ];
    };

    localConf = ''
      <?xml version="1.0"?>
      <!DOCTYPE fontconfig SYSTEM "urn:fontconfig:fonts.dtd">
      <fontconfig>
        <match target="pattern">
          <test qual="any" name="family" compare="eq"><string>Helvetica</string></test>
          <edit name="family" mode="assign" binding="same"><string>Adwaita Sans</string></edit>
        </match>
      </fontconfig>
    '';
  };
}
