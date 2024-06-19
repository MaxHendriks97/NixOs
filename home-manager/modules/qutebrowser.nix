{ config, lib, pkgs, ... }: {
  config = {
    programs.qutebrowser = {
      enable = true;

      keyBindings = {
        normal = {
          "gt" = "tab-next";
          "gT" = "tab-prev";
        };
      };

      searchEngines = {
        DEFAULT = "https://www.ecosia.org/search?method=index&q={}";
        w = "https://en.wikipedia.org/wiki/Special:Search?search={}&go=Go&ns0=1";
        g = "https://www.google.com/search?hl=en&q={}";
      };

      settings = {
        colors = {
          completion = {
            fg = "#${config.colorScheme.palette.base05}";
            odd.bg = "#${config.colorScheme.palette.base01}";
            even.bg = "#${config.colorScheme.palette.base00}";
            match.fg = "#${config.colorScheme.palette.base0B}";

            category = {
              fg = "#${config.colorScheme.palette.base0A}";
              bg = "#${config.colorScheme.palette.base00}";

              border = {
                top = "#${config.colorScheme.palette.base00}";
                bottom = "#${config.colorScheme.palette.base00}";
              };
            };

            item = {
              selected = {
                fg = "#${config.colorScheme.palette.base05}";
                bg = "#${config.colorScheme.palette.base02}";
                match.fg = "#${config.colorScheme.palette.base0B}";

                border = {
                  top = "#${config.colorScheme.palette.base02}";
                  bottom = "#${config.colorScheme.palette.base02}";
                };
              };
            };

            scrollbar = {
              fg = "#${config.colorScheme.palette.base05}";
              bg = "#${config.colorScheme.palette.base00}";
            };
          };

          contextmenu = {
            disabled = {
              fg = "#${config.colorScheme.palette.base04}";
              bg = "#${config.colorScheme.palette.base01}";
            };

            menu = {
              fg = "#${config.colorScheme.palette.base05}";
              bg = "#${config.colorScheme.palette.base02}";
            };

            selected = {
              fg = "#${config.colorScheme.palette.base05}";
              bg = "#${config.colorScheme.palette.base02}";
            };
          };

          downloads = {
            bar.bg = "#${config.colorScheme.palette.base00}"; 
            error.fg = "#${config.colorScheme.palette.base08}"; 

            start = {
              fg = "#${config.colorScheme.palette.base00}"; 
              bg = "#${config.colorScheme.palette.base0D}"; 
            };

            stop = {
              fg = "#${config.colorScheme.palette.base00}"; 
              bg = "#${config.colorScheme.palette.base0D}"; 
            };
          };

          hints = {
            fg = "#${config.colorScheme.palette.base00}";
            bg = "#${config.colorScheme.palette.base0A}";
            match.fg = "#${config.colorScheme.palette.base05}";
          };

          keyhint = {
            fg = "#${config.colorScheme.palette.base05}";
            bg = "#${config.colorScheme.palette.base00}";
            suffix.fg = "#${config.colorScheme.palette.base05}";
          };

          messages = {
            error = {
              fg = "#${config.colorScheme.palette.base00}";
              bg = "#${config.colorScheme.palette.base08}";
              border = "#${config.colorScheme.palette.base08}";
            };

            warning = {
              fg = "#${config.colorScheme.palette.base00}";
              bg = "#${config.colorScheme.palette.base0E}";
              border = "#${config.colorScheme.palette.base0E}";
            };

            info = {
              fg = "#${config.colorScheme.palette.base05}";
              bg = "#${config.colorScheme.palette.base00}";
              border = "#${config.colorScheme.palette.base00}";
            };
          };

          prompts = {
            fg = "#${config.colorScheme.palette.base05}";
            bg = "#${config.colorScheme.palette.base00}";
            border = "#${config.colorScheme.palette.base00}";

            selected = {
              fg = "#${config.colorScheme.palette.base02}";
              bg = "#${config.colorScheme.palette.base05}";
            };
          };

          statusbar = {
            progress.bg = "#${config.colorScheme.palette.base0D}";

            normal = {
              fg = "#${config.colorScheme.palette.base08}";
              bg = "#${config.colorScheme.palette.base00}";
            };

            insert = {
              fg = "#${config.colorScheme.palette.base00}";
              bg = "#${config.colorScheme.palette.base0D}";
            };

            passthrough = {
              fg = "#${config.colorScheme.palette.base00}";
              bg = "#${config.colorScheme.palette.base0C}";
            };

            private = {
              fg = "#${config.colorScheme.palette.base00}";
              bg = "#${config.colorScheme.palette.base01}";
            };

            command = {
              fg = "#${config.colorScheme.palette.base05}";
              bg = "#${config.colorScheme.palette.base00}";

              private = {
                fg = "#${config.colorScheme.palette.base05}";
                bg = "#${config.colorScheme.palette.base00}";
              };
            };

            caret = {
              fg = "#${config.colorScheme.palette.base00}";
              bg = "#${config.colorScheme.palette.base0E}";

              selection = {
                fg = "#${config.colorScheme.palette.base00}";
                bg = "#${config.colorScheme.palette.base0D}";
              };
            };

            url = {
              fg = "#${config.colorScheme.palette.base05}";
              error.fg = "#${config.colorScheme.palette.base08}";
              hover.fg = "#${config.colorScheme.palette.base05}";
              warn.fg = "#${config.colorScheme.palette.base0E}";

              success = {
                http.fg = "#${config.colorScheme.palette.base0C}";
                https.fg = "#${config.colorScheme.palette.base0B}";
              };
            };
          };

          tabs = {
            bar.bg = "#${config.colorScheme.palette.base00}";

            indicator = {
              start = "#${config.colorScheme.palette.base0D}";
              stop = "#${config.colorScheme.palette.base0C}";
              error = "#${config.colorScheme.palette.base08}";
            };

            odd = {
              fg = "#${config.colorScheme.palette.base05}";
              bg = "#${config.colorScheme.palette.base02}";
            };

            even = {
              fg = "#${config.colorScheme.palette.base05}";
              bg = "#${config.colorScheme.palette.base00}";
            };

            selected = {
              odd = {
                fg = "#${config.colorScheme.palette.base05}";
                bg = "#${config.colorScheme.palette.base03}";
              };

              even = {
                fg = "#${config.colorScheme.palette.base05}";
                bg = "#${config.colorScheme.palette.base03}";
              };
            };

            pinned = {
              odd = {
                fg = "#${config.colorScheme.palette.base07}";
                bg = "#${config.colorScheme.palette.base0B}";
              };

              even = {
                fg = "#${config.colorScheme.palette.base07}";
                bg = "#${config.colorScheme.palette.base0C}";
              };

              selected = {
                odd = {
                  fg = "#${config.colorScheme.palette.base05}";
                  bg = "#${config.colorScheme.palette.base03}";
                };

                even = {
                  fg = "#${config.colorScheme.palette.base05}";
                  bg = "#${config.colorScheme.palette.base03}";
                };
              };
            };
          };

          webpage = {
            preferred_color_scheme = "dark";
          };
        };
      };
    };
  };
}
