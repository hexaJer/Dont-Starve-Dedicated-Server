#!/bin/bash

steamcmd_dir="$HOME/steamcmd"
install_dir="$HOME/Steam/steamapps/DoNotStarveTogetherDedicatedServer"
persistent_storage_root="$HOME/Klei"
cluster_name="MyDediServer"
dontstarve_dir="$persistent_storage_root/DoNotStarveTogether"
dedicated_server_mods_setup="dedicated_server_mods_setup.lua"

function fail()
{
        echo Error: "$@" >&2
        exit 1
}

function check_for_file()
{
    if [ ! -e "$1" ]; then
            fail "Missing file: $1"
    fi
}

cd "$steamcmd_dir" || fail "Missing $steamcmd_dir directory!"

check_for_file "steamcmd.sh"
check_for_file "$dontstarve_dir/$cluster_name/cluster.ini"
check_for_file "$dontstarve_dir/$cluster_name/cluster_token.txt"
check_for_file "$dontstarve_dir/$cluster_name/Master/server.ini"
check_for_file "$dontstarve_dir/$cluster_name/Caves/server.ini"

./steamcmd.sh +force_install_dir "$install_dir" +login anonymous +app_update 343050 +quit

cp -fv "$HOME/dedicated_server_mods_setup.lua" "$install_dir/mods/"

check_for_file "$install_dir/bin"

cd "$install_dir/bin" || fail 

run_shared=(./dontstarve_dedicated_server_nullrenderer)
run_shared+=(-console)
run_shared+=(-persistent_storage_root "$persistent_storage_root")
run_shared+=(-cluster "$cluster_name")
run_shared+=(-monitor_parent_process $$)

echo " "
echo "Run Don't Starve Dedicated Servers with command: ${run_shared[@]}"
echo " servers log files generated at \"$dontstarve_dir/$cluster_name/<shard>/server_log.txt\""
echo " "

"${run_shared[@]}" -shard Caves  | sed 's/^/Caves:  /' >/dev/null &
"${run_shared[@]}" -shard Master | sed 's/^/Master: /' >/dev/null
