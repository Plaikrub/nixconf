{
    flake.wrappers.noctalia-shell = { wlib, pkgs, ... }: {
        imports = [wlib.wrapperModules.noctalia-shell];
        package = pkgs.noctalia-shell.overrideAttrs {
            name = "pknoctalia";
        };
        env."NOCTALIA_CACHE_DIR" = "/tmp/pk-noctalia-cache/";
        colors = {
            mError = "#ff5555";
            mHover = "#8be9fd";
            mOnError = "#282a36";
            mOnHover = "#282a36";
            mOnPrimary = "#282a36";
            mOnSecondary = "#282a36";
            mOnSurface = "#f8f8f2";
            mOnSurfaceVariant = "#bfbfbf";
            mOnTertiary = "#282a36";
            mOutline = "#44475a";
            mPrimary = "#bd93f9";
            mSecondary = "#ffb86c";
            mShadow = "#282a36";
            mSurface = "#282a36";
            mSurfaceVariant = "#44475a";
            mTertiary = "#8be9fd";
        };
        settings = {
            appLauncher = {
                customLaunchPrefix = "";
                customLaunchPrefixEnabled = false;
                enableClipPreview = false;
                enableClipboardHistory = false;
                iconMode = "tabler";
                pinnedExecs = [];
                position = "center";
                showCategories = true;
                sortByMostUsed = true;
                terminalCommand = "kitty -e";
                useApp2Unit = false;
                viewMode = "grid";
            };
            audio = {
                cavaFrameRate = 30;
                externalMixer = "pwvucontrol || pavucontrol";
                mprisBlacklist = [];
                preferredPlayer = "";
                visualizerType = "linear";
                volumeOverdrive = false;
                volumeStep = 5;
            };
            bar = {
                capsuleOpacity = 1;
                density = "comfortable";
                exclusive = true;
                floating = false;
                marginHorizontal = 0;
                marginVertical = 0;
                monitors = [];
                outerCorners = false;
                position = "top";
                showCapsule = false;
                showOutline = false;
                transparent = false;
                widgets = {
                    center = [];
                    left = [
                    {
                        colorizeDistroLogo = true;
                        colorizeSystemIcon = "tertiary";
                        customIconPath = "";
                        enableColorization = true;
                        id = "ControlCenter";
                        useDistroLogo = true;
                    }
                    {
                        characterCount = 2;
                        colorizeIcons = false;
                        enableScrollWheel = true;
                        followFocusedScreen = false;
                        hideUnoccupied = true;
                        id = "Workspace";
                        labelMode = "none";
                        showApplications = false;
                        showLabelsOnlyWhenOccupied = true;
                    }
                    ];
                    right = [
                    {
                        hideWhenZero = false;
                        id = "NotificationHistory";
                        showUnreadBadge = true;
                    }
                    {
                        id = "PowerProfile";
                    }
                    {
                        displayMode = "alwaysHide";
                        id = "Volume";
                    }
                    {
                        deviceNativePath = "";
                        displayMode = "alwaysShow";
                        hideIfNotDetected = true;
                        id = "Battery";
                        showNoctaliaPerformance = false;
                        showPowerProfiles = false;
                        warningThreshold = 20;
                    }
                    {
                        displayMode = "alwaysHide";
                        id = "Microphone";
                    }
                    {
                        displayMode = "forceOpen";
                        id = "KeyboardLayout";
                    }
                    {
                        customFont = "";
                        formatHorizontal = "HH:mm ddd, MMM dd";
                        formatVertical = "HH mm - dd MM";
                        id = "Clock";
                        useCustomFont = false;
                        usePrimaryColor = true;
                    }
                    {
                        blacklist = [];
                        colorizeIcons = false;
                        drawerEnabled = true;
                        hidePassive = false;
                        id = "Tray";
                        pinned = [];
                    }
                    ];
                };
            };
            brightness = {
                brightnessStep = 5;
                enableDdcSupport = false;
                enforceMinimum = true;
            };
            calendar = {
                cards = [
                    {
                        enabled = true;
                        id = "calendar-header-card";
                    }
                    {
                        enabled = true;
                        id = "calendar-month-card";
                    }
                    {
                        enabled = true;
                        id = "timer-card";
                    }
                    {
                        enabled = true;
                        id = "weather-card";
                    }
                ];
            };
            controlCenter = {
                cards = [
                {
                    enabled = true;
                    id = "profile-card";
                }
                {
                    enabled = true;
                    id = "shortcuts-card";
                }
                {
                    enabled = true;
                    id = "audio-card";
                }
                {
                    enabled = true;
                    id = "brightness-card";
                }
                {
                    enabled = true;
                    id = "weather-card";
                }
                {
                    enabled = true;
                    id = "media-sysmon-card";
                }
                ];
                position = "close_to_bar_button";
                shortcuts = {
                    left = [
                        {id = "WiFi";}
                        {id = "Bluetooth";}
                        {id = "ScreenRecorder";}
                    ];
                    right = [
                        {id = "Notifications";}
                        {id = "PowerProfile";}
                    ];
                };
            };
            desktopWidgets = {
                enabled = false;
                gridSnap = false;
                monitorWidgets = [];
            };
            dock = {
                animationSpeed = 2;
                backgroundOpacity = 1;
                colorizeIcons = false;
                deadOpacity = 0.6;
                displayMode = "always_show";
                enabled = true;
                floatingRatio = 1;
                inactiveIndicators = false;
                monitors = [];
                onlySameOutput = true;
                launcherPosition = "start";
                launcherIcon = "apps";
                pinnedApps = [
                    "brave --profile-directory=Default"
                    "brave --profile-directory=Profile\\ 1"
                    "vesktop"
                    "thunderbird"
                    "bitwarden-desktop"
                    "kitty"
                    "steam"
                ];
                pinnedStatic = true;
                size = 1;
            };
            general = {
                allowPanelsOnScreenWithoutBar = true;
                animationDisabled = false;
                animationSpeed = 1;
                boxRadiusRatio = 0;
                compactLockScreen = false;
                dimmerOpacity = 0.15;
                enableShadows = false;
                forceBlackScreenCorners = true;
                iRadiusRatio = 0;
                language = "";
                lockOnSuspend = true;
                radiusRatio = 0;
                scaleRatio = 1;
                screenRadiusRatio = 0;
                shadowDirection = "bottom_right";
                shadowOffsetX = 0;
                shadowOffsetY = 0;
                showHibernateOnLockScreen = false;
                showScreenCorners = false;
                showSessionButtonsOnLockScreen = true;
            };
            hooks = {
                darkModeChange = "";
                enabled = false;
                performanceModeDisabled = "";
                performanceModeEnabled = "";
                screenLock = "";
                screenUnlock = "";
                wallpaperChange = "";
            };
            location = {
                analogClockInCalendar = false;
                firstDayOfWeek = -1;
                showCalendarEvents = true;
                showCalendarWeather = true;
                showWeekNumberInCalendar = false;
                use12hourFormat = false;
                useFahrenheit = false;
                weatherEnabled = true;
                weatherShowEffects = true;
            };
            network = {wifiEnabled = true;};
            nightLight = {
                autoSchedule = true;
                dayTemp = "6500";
                enabled = false;
                forced = false;
                manualSunrise = "06:30";
                manualSunset = "18:30";
                nightTemp = "4000";
            };
            notifications = {
                backgroundOpacity = 1;
                criticalUrgencyDuration = 15;
                enableKeyboardLayoutToast = true;
                enabled = true;
                location = "bottom_right";
                lowUrgencyDuration = 8;
                monitors = [];
                normalUrgencyDuration = 8;
                overlayLayer = true;
                respectExpireTimeout = false;
                sounds = {
                criticalSoundFile = "";
                enabled = false;
                excludedApps = "discord,firefox,chrome,chromium,edge";
                lowSoundFile = "";
                normalSoundFile = "";
                separateSounds = false;
                volume = 0.5;
                };
            };
            osd = {
                autoHideMs = 3000;
                backgroundOpacity = 1;
                enabled = true;
                enabledTypes = [0 1 2 4];
                location = "bottom";
                monitors = [];
                overlayLayer = true;
            };
            screenRecorder = {
                audioCodec = "opus";
                audioSource = "default_output";
                colorRange = "limited";
                directory = "$HOME/media/videos";
                frameRate = 60;
                quality = "very_high";
                showCursor = true;
                videoCodec = "h264";
                videoSource = "portal";
            };
            sessionMenu = {
                countdownDuration = 10000;
                enableCountdown = true;
                largeButtonsStyle = false;
                position = "center";
                powerOptions = [
                {
                    action = "lock";
                    command = "";
                    countdownEnabled = true;
                    enabled = true;
                }
                {
                    action = "suspend";
                    command = "";
                    countdownEnabled = true;
                    enabled = true;
                }
                {
                    action = "hibernate";
                    command = "";
                    countdownEnabled = true;
                    enabled = true;
                }
                {
                    action = "reboot";
                    command = "";
                    countdownEnabled = true;
                    enabled = true;
                }
                {
                    action = "logout";
                    command = "";
                    countdownEnabled = true;
                    enabled = true;
                }
                {
                    action = "shutdown";
                    command = "";
                    countdownEnabled = true;
                    enabled = true;
                }
                ];
                showHeader = true;
            };
            settingsVersion = 32;
            systemMonitor = {
                cpuCriticalThreshold = 90;
                cpuPollingInterval = 3000;
                cpuWarningThreshold = 80;
                criticalColor = "";
                diskCriticalThreshold = 90;
                diskPollingInterval = 3000;
                diskWarningThreshold = 80;
                enableDgpuMonitoring = false;
                gpuCriticalThreshold = 90;
                gpuPollingInterval = 3000;
                gpuWarningThreshold = 80;
                memCriticalThreshold = 90;
                memPollingInterval = 3000;
                memWarningThreshold = 80;
                networkPollingInterval = 3000;
                tempCriticalThreshold = 90;
                tempPollingInterval = 3000;
                tempWarningThreshold = 80;
                useCustomColors = false;
                warningColor = "";
            };
            templates = {
                alacritty = false;
                cava = false;
                code = false;
                discord = false;
                emacs = false;
                enableUserTemplates = false;
                foot = false;
                fuzzel = false;
                ghostty = false;
                gtk = false;
                helix = false;
                hyprland = false;
                kcolorscheme = false;
                kitty = false;
                mango = false;
                niri = false;
                pywalfox = false;
                qt = false;
                spicetify = false;
                telegram = false;
                vicinae = false;
                walker = false;
                wezterm = false;
                yazi = false;
                zed = false;
            };
            ui = {
                bluetoothDetailsViewMode = "grid";
                bluetoothHideUnnamedDevices = false;
                fontDefault = "Sans Serif";
                fontDefaultScale = 1;
                fontFixed = "monospace";
                fontFixedScale = 1;
                panelBackgroundOpacity = 1;
                panelsAttachedToBar = true;
                settingsPanelMode = "attached";
                tooltipsEnabled = true;
                wifiDetailsViewMode = "grid";
            };
            wallpaper = {enabled = false;};
        };
    };
}