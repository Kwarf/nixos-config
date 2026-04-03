{ den, ... }:
{
  den.aspects.software.provides.obsidian = {
    includes = [
      (den.provides.unfree [ "obsidian" ])
    ];

    homeManager.programs.obsidian = {
      enable = true;
      vaults.notes = {
        target = "Notes";
        settings = {
          corePlugins = [
            "backlink"
            "bases"
            "bookmarks"
            "command-palette"
            "daily-notes"
            "editor-status"
            "file-explorer"
            "global-search"
            "graph"
            "markdown-importer"
            "note-composer"
            "outgoing-link"
            "outline"
            "page-preview"
            "properties"
            "slash-command"
            "switcher"
            "tag-pane"
            "templates"
          ];
        };
      };
    };
  };
}
