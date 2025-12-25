#!/bin/bash

Main() {
    local mode=offline
    local progname=""
    progname="$(basename "$0")"
    local log=/home/liveuser/cachy-install.log

    cat <<EOF > $log
########## $log by $progname
########## Started (UTC): $(date -u "+%x %X")
########## Install mode: $mode

EOF
    RunInTerminal "tail -f $log" &

    sudo cp /usr/share/calamares/settings_${mode}.conf /etc/calamares/settings.conf
    sudo -E dbus-launch calamares -D6 >> $log

    # After Calamares finishes, enable required services inside the installed system.
    local target_root="$(ls -dt /tmp/calamares-root-*/ 2>/dev/null | head -n 1)"
    if [[ -d "$target_root" ]]; then
        {
            echo "Enabling NetworkManager and broadcom-wl-dkms.service in target root: $target_root"
            sudo arch-chroot "$target_root" systemctl enable NetworkManager
            sudo arch-chroot "$target_root" systemctl enable broadcom-wl-dkms.service
        } >> $log 2>&1
    else
        echo "Calamares target root not found; skipping service enable" >> $log
    fi
}

Main "$@"
