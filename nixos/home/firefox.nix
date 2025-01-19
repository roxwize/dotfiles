{ pkgs, ... }: {
    programs.firefox = {
        enable = true;
        policies = {
            DisableTelemetry = true;
            DisableFirefoxStudies = true;
            EnableTrackingProtection = {
                Value = true;
                Locked = true;
                Cryptomining = true;
                Fingerprinting = true;
            };
            DisablePocket = true;
            ExtensionUpdate = false;
            FirefoxHome = {
                SponsoredTopSites = false;
                Highlights = false;
                Pocket = false;
                SponsoredPocket = false;
            };
            FirefoxSuggest = {
                SponsoredSuggestions = false;
            };
        };
        profiles.default = {
            isDefault = true;
            extensions = with pkgs.nur.repos.rycee.firefox-addons; [
                canvasblocker
                catppuccin-gh-file-explorer
                indie-wiki-buddy
                privacy-badger
                stylus
                tabliss
                ublock-origin
                user-agent-string-switcher
                violentmonkey
            ];
            settings = {
                "browser.aboutConfig.showWarning" = false;
                "browser.newtabpage.activity-stream.default.sites" = "https://en.wikipedia.org/";
                "browser.newtabpage.activity-stream.discoverystream.enabled" = false;
                "browser.newtabpage.activity-stream.feeds.telemetry" = false;
                "browser.newtabpage.activity-stream.improvesearch.topSiteSearchShortcuts.havePinned" = "";
                "browser.newtabpage.activity-stream.newtabWallpapers.wallpaper" = "dark-beach";
                "browser.newtabpage.activity-stream.showSponsored" = false;
                "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
                "browser.newtabpage.activity-stream.telemetry" = false;
                "browser.newtabpage.activity-stream.topSitesRows" = 2;
                "browser.newtabpage.pinned" = [
                    {
                        url = "https://discord.com/app/";
                        label = "Discord";
                    }
                    {
                        url = "https://en.wikipedia.org/";
                        label = "Wikipedia";
                    }
                ];
                "datareporting.healthreport.uploadEnabled" = false;
                "font.name.monospace.x-western" = "Fira Code";
                "layout.css.prefers-color-scheme.content-override" = 0;
            };
            bookmarks = [
                {
                    name = "Toolbar";
                    toolbar = true;
                    bookmarks = [
                        {
                            name = "Pinky & Pepper Forever";
                            url = "https://www.silversprocket.net/2020/05/02/pinky-and-pepper-forever-by-eddy-atoms-part-1-of-2/";
                        }
                    ];
                }
                {
                    name = "Nix sites";
                    bookmarks = [
                        {
                            name = "NixOS search";
                            url = "https://search.nixos.org/packages";
                        }
                        {
                            name = "Home Manager search";
                            url = "https://home-manager-options.extranix.com/";
                        }
                        {
                            name = "NUR search";
                            url = "https://nur.nix-community.org/";
                        }
                        {
                            name = "NixOS wiki";
                            url = "https://nixos.wiki/";
                        }
                        {
                            name = "Nix functions";
                            url = "https://teu5us.github.io/nix-lib.html";
                        }
                    ];
                }
            ];
            search = {
                default = "DuckDuckGo";
                engines = {
                    "Nix packages" = {
                        urls = [{
                            template = "https://search.nixos.org/packages";
                            params = [
                                { name = "type"; value = "packages"; }
                                { name = "query"; value = "{searchTerms}"; }
                            ];
                        }];
                        icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                    };
                    "Home Manager options" = {
                        urls = [{
                            template = "https://home-manager-options.extranix.com/";
                            params = [
                                { name = "release"; value = "release-24.11"; }
                                { name = "query"; value = "{searchTerms}"; }
                            ];
                        }];
                    };
                    "Manpages" = {
                        urls = [{
                            template = "https://www.mankier.com/";
                            params = [
                                { name = "q"; value = "{searchTerms}"; }
                            ];
                        }];
                    };

                    "Bing".metaData.hidden = true;
                    "Google".metaData.hidden = true;
                };
                order = [ "DuckDuckGo" "Nix packages" ];
                force = true;
            };
        };
    };
}
