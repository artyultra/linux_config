# Hypridle Troubleshooting Recommendations

## Current Issue
Your hypridle is freezing the machine after 30 seconds instead of properly sending you to the hyprlock screen.

## Recommended Changes

### 1. Simplify the lock command in hypridle.conf

**Current configuration:**
```
general {
  lock_cmd = pidof hyprlock || hyprlock
  on-lock-cmd = sleep 10 && hyprctl dispatch dpms off
}
```

**Recommended change:**
```
general {
  lock_cmd = hyprlock
  on-lock-cmd = hyprctl dispatch dpms off
}
```

**Rationale:**
- The current command tries to check if hyprlock is already running before launching it
- This complex command might not be executing properly in the hypridle context
- The `pidof` check might be hanging or timing out
- Removing the `sleep 10` delay eliminates a potential source of freezing

### 2. Alternative fix if the above doesn't work

If the first change doesn't resolve the issue, consider:

```
general {
  lock_cmd = killall -q hyprlock; hyprlock
  on-lock-cmd = hyprctl dispatch dpms off
}
```

This ensures any existing hyprlock processes are terminated before starting a new one.

### 3. Check for conflicts between hyprlock and swaylock

Your configuration has scripts in the default directory using swaylockd, but hypridle is configured to use hyprlock. Ensure you're consistently using one lock screen solution.

### 4. Increase timeouts

If freezing continues, try increasing the timeouts slightly:

```
listener {
  timeout = 45                          # 45 seconds instead of 30
  on-timeout = loginctl lock-session
}

listener {
  timeout = 50                         # 50 seconds
  on-timeout = hyprctl dispatch dpms off
  on-resume = hyprctl dispatch dpms on
}
```

### 5. Add debug logging

To help troubleshoot, you can add logging to see what's happening:

```
general {
  lock_cmd = hyprlock > /tmp/hyprlock.log 2>&1
  on-lock-cmd = hyprctl dispatch dpms off
}
```

This will capture any errors from hyprlock in the log file.