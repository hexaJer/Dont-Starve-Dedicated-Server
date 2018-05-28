#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

steamcmd="$(which steamcmd)"
install_dir="/opt/steamapps/DoNotStarveTogetherDedicatedServer"
persistent_storage_root="$DIR/Klei"
dontstarve_dir="$persistent_storage_root/DoNotStarveTogether"
dedicated_server_mods_setup="$DIR/dedicated_server_mods_setup.lua"

find "$dontstarve_dir" -name "save" -type d -exec rm -rfv {} \;

cd "$steamcmd_dir"
./steamcmd.sh +force_install_dir "$install_dir" +login anonymous +app_update 343050 validate +quit

cp -fv "$dedicated_server_mods_setup" "$install_dir/mods/"
