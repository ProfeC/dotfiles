# vivaldi.nix
{ pkgs, lib, ... }:

{
  ########################################
  ## System-wide packages (Stage 1: now)
  ########################################
  environment.systemPackages = [
    (pkgs.stdenv.mkDerivation.wrapProgram pkgs.vivaldi {
      extraArgs = [
        # --- Memory / process management ---
        "--process-per-site" # Fewer renderer processes than the default (per-tab). Saves RAM, but slightly less isolation.
        # "--disable-renderer-backgrounding" # Prevents Chromium from throttling “background” tabs. May use more CPU but avoids reloads when tabbing back.
        "--disable-background-timer-throttling" # Keeps JS timers running at full speed in background tabs (helps web apps like Slack/Discord).
        "--disable-backgrounding-occluded-windows" # Stops Chromium from deprioritizing windows hidden behind others.

        # --- GPU acceleration ---
        "--enable-features=VaapiVideoDecoder,CanvasOopRasterization,AcceleratedVideoDecodeLinuxGL" # Enable VA-API and accelerated canvas for smoother video and rendering.
        "--enable-gpu-rasterization" # Moves more rendering work to GPU.
        "--enable-zero-copy" # Reduces copies when transferring video frames to GPU.
        "--use-gl=desktop" # Use system OpenGL instead of ANGLE (sometimes smoother on Mesa/AMD/Intel).
        "--ignore-gpu-blocklist" # Force-enable GPU features even if your card is blacklisted. (Good on Linux where blocklists can lag.)
        "--ozone-platform=wayland" # or `--ozone-platform-hint=auto` - Helps Chromium integrate properly under Wayland vs X11."

        # --- Privacy / noise reduction ---
        "--disable-background-networking" # Stops Chromium from prefetching/phone-home background requests.
        "--disable-breakpad" # Disables crash reporting to upstream.
        "--disable-domain-reliability" # Turns off reporting reliability pings to Google.
        "--no-first-run" # Skips first-run “welcome” UI overhead.

        # --- UX ---
        "--enable-features=WebUIDarkMode"
        "--use-system-theme"
      ];
    })
    pkgs.vivaldi-ffmpeg-codecs
  ];

  ########################################
  ## Extension policy (system-wide)
  ## NOTE: switch to xdg.configFile in HM later
  ########################################
  environment.etc."opt/vivaldi/policies/managed/extensions.json".text = ''
    {
      "ExtensionInstallForcelist": [
        "nngceckbapebfimnlniiiahkandclblb",  // Bitwarden
        "bfidboloedlamgdmenmlbipfnccokknp"   // PureVPN
      ]
    }
  '';

  ########################################
  ## Aliases for multiple profiles
  ## NOTE: migrate to programs.bash.shellAliases in HM
  ########################################
  programs.bash.shellAliases = {
    vivaldi-default = "vivaldi --user-data-dir=$HOME/.config/vivaldi-home --use-system-theme";
    vivaldi-testing = "vivaldi --user-data-dir=$HOME/.config/vivaldi-testing"; # extra testing profile
  };
}
