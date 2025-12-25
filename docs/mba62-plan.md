# Recon notes (task A)

- **Package lists**
  - `archiso/Packages/*.txt` holds group-specific package sets merged into `archiso/packages.x86_64` by `buildiso.sh`. `archiso/Packages/AUR/` contains AUR helper scripts (e.g., `makepkg_paru`).
  - `archiso/bootstrap_packages.x86_64` provides the minimal bootstrap package set for mkarchiso.
- **airootfs overlay**
  - Live filesystem overlay resides in `archiso/airootfs/`; contents are copied into the ISO and installed system. Existing service symlinks live under `archiso/airootfs/etc/systemd/system/` and its `*.wants` targets.
  - Broadcom tweaks added under `archiso/airootfs/etc/modprobe.d/`, `archiso/airootfs/etc/modules-load.d/`, and `archiso/airootfs/etc/systemd/system/broadcom-wl-dkms.service` (enabled via `multi-user.target.wants`).
- **Pacman hooks**
  - DKMS autoinstall hook for Broadcom wl lives at `archiso/airootfs/etc/pacman.d/hooks/95-broadcom-wl-dkms.hook`.
- **Offline installer hooks**
  - Launchers for Calamares live in `archiso/airootfs/usr/local/bin/`, including `calamares-offline.sh` (copies `/usr/share/calamares/settings_offline.conf` to `/etc/calamares/settings.conf` before starting Calamares) and `calamares-online.sh`.
- **Service enablement**
  - Services are pre-enabled via symlinks under `archiso/airootfs/etc/systemd/system/`, e.g., `multi-user.target.wants/NetworkManager.service`, `wpa_supplicant.service`, `systemd-resolved.service`, and virtualization helpers. Default target override at `archiso/airootfs/etc/systemd/system/default.target`.
- **Pacman configuration**
  - ISO pacman config resides at `archiso/pacman.conf`; additional mirrorlist fetched into `archiso/airootfs/etc/pacman.d/` by `util-iso.sh`.
- **Build orchestration**
  - `buildiso.sh` drives the build, concatenating `archiso/Packages/*.txt` and `archiso/Packages/AUR/aur.txt` into `archiso/packages.x86_64` before mkarchiso runs.

