# Live environment verification
- Check modules and blacklist:
  - `lsmod | grep -E 'wl|b43|brcmsmac|brcmfmac'`
  - `modinfo -k "$(uname -r)" wl`
  - `cat /etc/modprobe.d/broadcom-wl.conf`
- Confirm DKMS hook and service are present/enabled:
  - `systemctl status broadcom-wl-dkms.service`
  - `pacman -Q dkms broadcom-wl-dkms`
- Validate NetworkManager is active and wl loaded:
  - `systemctl status NetworkManager.service`
  - `nmcli device status`

# Installed system verification
- Ensure service and module are present:
  - `sudo systemctl status broadcom-wl-dkms.service`
  - `sudo modinfo -k "$(uname -r)" wl`
  - `sudo lsmod | grep wl`
- Validate DKMS cache used and hook available:
  - `sudo grep -A3 '\\[Trigger\\]' /etc/pacman.d/hooks/95-broadcom-wl-dkms.hook`
  - `sudo pacman -Qi broadcom-wl-dkms dkms`
- Network and autoload checks:
  - `sudo systemctl status NetworkManager.service`
  - `sudo ls /etc/modules-load.d/wl.conf`
  - `sudo journalctl -u broadcom-wl-dkms.service -b`
