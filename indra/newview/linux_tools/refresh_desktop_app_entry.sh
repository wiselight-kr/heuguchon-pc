#!/bin/bash

SCRIPTSRC=`readlink -f "$0" || echo "$0"`
RUN_PATH=`dirname "${SCRIPTSRC}" || echo .`

install_prefix=${RUN_PATH}/..

function install_desktop_entry()
{
    local installation_prefix="$1"
    local desktop_entries_dir="$2"

    local desktop_entry="\
[Desktop Entry]\n\
Name=Heuguchon\n\
Comment=Client for accessing 3D virtual worlds\n\
Exec=${installation_prefix}/heuguchon\n\
Icon=${installation_prefix}/heuguchon_icon.png\n\
Terminal=false\n\
Type=Application\n\
Categories=Application;Internet;Network;\n\
StartupNotify=true\n\
X-Desktop-File-Install-Version=3.0\n
StartupWMClass=do-not-directly-run-heuguchon-bin"

    echo " - Installing menu entries in ${desktop_entries_dir}"
    mkdir -vp "${desktop_entries_dir}"
    echo -e $desktop_entry > "${desktop_entries_dir}/heuguchon.desktop" || "Failed to install application menu!"
}

if [ "$UID" == "0" ]; then
    # system-wide
    install_desktop_entry "$install_prefix" /usr/local/share/applications
else
    # user-specific
    install_desktop_entry "$install_prefix" "$HOME/.local/share/applications"
fi
