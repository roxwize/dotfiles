{ pkgs, ... }: {
	programs = rec {
		firefox = {
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
					Pocket = false; # rip bozo
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
					catppuccin-web-file-icons
					indie-wiki-buddy
					privacy-badger
					simple-tab-groups
					stylus
					tabliss
					ublock-origin
					user-agent-string-switcher
					violentmonkey
				];
				settings = {
					"browser.aboutConfig.showWarning" = false;
					"browser.ml.chat.enabled" = false;
					"browser.ml.enable" = false;
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
					"browser.startup.page" = 3;
					"browser.tabs.closeWindowWithLastTab" = false;
					"browser.tabs.insertAfterCurrent" = true;
					"browser.urlbar.suggest.quicksuggest.sponsored" = false;
					"devtools.editor.tabsize" = 4;
					"datareporting.healthreport.uploadEnabled" = false;
					"extensions.pocket.enabled" = false;
					"extensions.pocket.showHome" = false;
					"extensions.webextensions.restrictedDomains" = "";
					"font.name.monospace.x-western" = "Fira Code";
					"general.autoScroll" = true;
					"layout.css.prefers-color-scheme.content-override" = 0;
					"sidebar.visibility" = "hide-sidebar";
					"svg.context-properties.content.enabled" = true;
				};
				bookmarks = [
					{
						name = "Toolbar";
						toolbar = true;
						bookmarks = [
							{
								name = "CUPS interface";
								url = "http://127.0.0.1:631/";
							}
							{
								name = "Battle of the Bits";
								url = "https://battleofthebits.com/";
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
								url = "https://wiki.nixos.org/";
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
						"Noogle" = {
							urls = [{
								template = "https://noogle.dev/q";
								params = [
									{ name = "term"; value = "{searchTerms}"; }
								];
							}];
						};
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
						"ArchWiki" = {
							urls = [{
								template = "https://wiki.archlinux.org/index.php?title=Special:Search&search={searchTerms}";
							}];
						};

						"Bing".metaData.hidden = true;
						"Google".metaData.hidden = true;
					};
					order = [ "DuckDuckGo" "Noogle" "Nix packages" ];
					force = true;
				};
			};
		};
		thunderbird = {
			enable = true;
			profiles.default = {
				isDefault = true;
				search = firefox.profiles.default.search;
				settings = {
					"mail.show_headers" = 2;
					"mail.spellcheck.inline" = false;
				};
			};
		};
	};
}
