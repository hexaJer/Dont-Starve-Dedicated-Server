#!/bin/bash

steamcmd_dir="$HOME/steamcmd"
install_dir="$HOME/Steam/steamapps/DoNotStarveTogetherDedicatedServer"
persistent_storage_root="$HOME/Klei"
cluster_name="MyDediServer"
dontstarve_dir="$persistent_storage_root/DoNotStarveTogether"

find "$dontstarve_dir" -name "save" -type d -exec rm -rfv {} \;

cd "$steamcmd_dir"
./steamcmd.sh +force_install_dir "$install_dir" +login anonymous +app_update 343050 validate +quit

cp -fv "$HOME/dedicated_server_mods_setup.lua" "$install_dir/mods/"
