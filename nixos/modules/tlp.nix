{
  services.tlp = {
    enable = true;
    pd.enable = true;
    settings = {
      START_CHARGE_THRESH_BAT0 = 70;
      STOP_CHARGE_THRESH_BAT0 = 80;

      START_CHARGE_THRESH_BAT1 = 70;
      STOP_CHARGE_THRESH_BAT1 = 80;

      # CPU scaling governor
      # Controls how aggressively the CPU frequency is scaled.
      # On modern intel_pstate / amd_pstate (active mode) only
      # "performance" and "powersave" are available.
      # Default: powersave (both AC and BAT)
      # CPU_SCALING_GOVERNOR_ON_AC = "performance";
      # CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      # CPU Energy Performance Preference (EPP)
      # Most important modern setting. Tells the hardware how to balance
      # performance vs power (Intel HWP / AMD CPPC).
      # Values (most performance → most saving):
      #   performance | balance_performance | default | balance_power | power
      # Default: balance_performance (AC), balance_power (BAT)
      # CPU_ENERGY_PERF_POLICY_ON_AC = "balance_performance";
      # CPU_ENERGY_PERF_POLICY_ON_BAT = "power";

      # CPU Turbo Boost / Precision Boost
      # 1 = allow turbo, 0 = disable
      # Default: 1 (both AC and BAT)
      # CPU_BOOST_ON_AC = 1;
      # CPU_BOOST_ON_BAT = 0;

      # Platform Profile (firmware-level)
      # Controls overall system behaviour: performance, thermals, fan curves.
      # Common values: performance | balanced | low-power
      # Default: performance (AC), balanced (BAT)
      # PLATFORM_PROFILE_ON_AC = "performance";
      # PLATFORM_PROFILE_ON_BAT = "low-power";

      # Runtime Power Management for PCIe devices
      # "on"   = keep devices powered
      # "auto" = allow idle devices to suspend
      # Default: on (AC), auto (BAT)
      # RUNTIME_PM_ON_AC = "on";
      # RUNTIME_PM_ON_BAT = "auto";

      # PCIe Active State Power Management (ASPM)
      # Puts unused PCIe links into low-power states.
      # Values: default | performance | powersave | powersupersave
      # Default: default (both AC and BAT)
      # PCIE_ASPM_ON_AC = "default";
      # PCIE_ASPM_ON_BAT = "powersupersave";

      # Wi-Fi power saving
      # "off" = full performance, "on" = power-saving mode
      # Default: off (AC), on (BAT)
      # WIFI_PWR_ON_AC = "off";
      # WIFI_PWR_ON_BAT = "on";

      # USB autosuspend
      # 1 = enable, 0 = disable
      # (Input devices, audio, scanners are already excluded by default)
      # Default: 1
      # USB_AUTOSUSPEND = 1;
    };
  };
}
