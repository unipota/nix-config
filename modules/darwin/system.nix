# macOS specific system settings
{ pkgs, ... }:

{
  # --- System Settings (macOS specific) ---
  system.stateVersion = 4;

  system.defaults = {
    WindowManager = {
      # Hide items on desktop
      StandardHideDesktopIcons = true;
    };
    controlcenter = {
      AirDrop = false;
      BatteryShowPercentage = false; # Shown in Status
      Bluetooth = true;
    };
    dock = {
      # App switcher on all displays
      appswitcher-all-displays = true;
      # Auto hide
      autohide = true;
      autohide-delay = 0.0;
      autohide-time-modifier = 0.2;
      # Group apps in Mission Control
      expose-group-apps = true;
      # Hover magnification
      magnification = true;
      largesize = 48;
      # Position
      orientation = "left";
      # Don't show recent apps
      show-recents = false;
      # Only show open apps
      static-only = true;
      # Icon size
      tilesize = 32;
      # Hot corners
      # Bottom Left: Launchpad
      wvous-bl-corner = 11;
      # Bottom Right: Application Windows
      wvous-br-corner = 3;
      # Top Left: Notification Center
      wvous-tl-corner = 12;
      # Top Right: Mission Control
      wvous-tr-corner = 2;
    };
    finder = {
      # Show all extensions
      AppleShowAllExtensions = true;
      # Show hidden files
      AppleShowAllFiles = true;
      # No desktop icons
      CreateDesktop = false;
      # No extension change warning
      FXEnableExtensionChangeWarning = false;
      # Default list view
      FXPreferredViewStyle = "Nlsv";
      # Default search scope to current folder
      FXDefaultSearchScope = "SCcf";
      # Keep folders on top when sorting by name
      _FXSortFoldersFirst = true;
      # No removable media on desktop
      ShowRemovableMediaOnDesktop = false;
      # Show status bar
      ShowStatusBar = true;
      # Show path bar
      ShowPathbar = true;
      # Show full path in title
      _FXShowPosixPathInTitle = true;
    };
    screencapture = {
      location = "~/Downloads";
      disable-shadow = true;
    };
    trackpad = {
      Clicking = true;
      TrackpadRightClick = true; # two-finger tap for right click
      TrackpadThreeFingerDrag = true; # Enable three finger drag
    };
    magicmouse = {
      MouseButtonMode = "TwoButton";
    };
    menuExtraClock = {
      Show24Hour = true;
      ShowDate = 0;
      ShowDayOfMonth = true;
      ShowDayOfWeek = true;
      ShowSeconds = false;
    };
    spaces = {
      spans-displays = false;
    };
    NSGlobalDomain = {
      AppleShowAllExtensions = true;
      AppleShowAllFiles = true;
      KeyRepeat = 1;
      InitialKeyRepeat = 10;
      "com.apple.mouse.tapBehavior" = 1;
      "com.apple.trackpad.scaling" = 1.5;

      # Disable auto-correction/typing substitutions
      NSAutomaticCapitalizationEnabled = false;
      NSAutomaticDashSubstitutionEnabled = false;
      NSAutomaticPeriodSubstitutionEnabled = false;
      NSAutomaticQuoteSubstitutionEnabled = false;
      NSAutomaticSpellingCorrectionEnabled = false;

      _HIHideMenuBar = true;
    };
    CustomUserPreferences = {
      "com.apple.desktopservices" = {
        DSDontWriteNetworkStores = true;
        DSDontWriteUSBStores = true;
      };
      "com.apple.CrashReporter" = {
        DialogType = "none";
      };
    };
  };

  system.keyboard = {
    enableKeyMapping = true;
    remapCapsLockToControl = true;
  };

  # Define user information
  users.users.unipota = rec {
    name = "unipota";
    home = "/Users/${name}";
  };

  system.primaryUser = "unipota";

  # --- Shell settings ---
  programs.zsh.enable = true; # Manage the default Zsh with Nix

  # Prevent conflicts with the Determinate installer, which manages Nix separately.
  nix.enable = false;

  fonts.packages = with pkgs; [
    maple-mono.NF
  ];
}
