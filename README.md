# control_screen
Control screen for Omega Onion2 to show some system information like IP etc.
Pure shell scripts

1. Connect OLED display Power, Ground, SDA and SCL to Omega
2. Connect pushbutton to GPIO18 and +3.3. Additionally I connected 10K resistor to GPIO18 and Ground
3. Connect LED to GPIO19 and Ground
4. Copy `control_screen.sh` to `/root`
5. Copy `control_screen` to `/etc/init.d`
6. Enable it `/etc/init.d/control_screen enable`
7. Run it `/etc/init.d/control_screen start`
8. Press button for a second to see IP. Screen will be turned off after 10 seconds
