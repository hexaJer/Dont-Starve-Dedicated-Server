#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

steamcmd="$(which steamcmd)"
install_dir="/opt/steamapps/DoNotStarveTogetherDedicatedServer"
dst_bin="$install_dir/bin/dontstarve_dedicated_server_nullrenderer"
persistent_storage_root="$DIR/Klei"
cluster_name="MyDediServer"
dontstarve_dir="$persistent_storage_root/DoNotStarveTogether"
dedicated_server_mods_setup="$DIR/dedicated_server_mods_setup.lua"

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

check_for_file "$dedicated_server_mods_setup"
check_for_file "$dontstarve_dir/$cluster_name/cluster.ini"
check_for_file "$dontstarve_dir/$cluster_name/cluster_token.txt"
check_for_file "$dontstarve_dir/$cluster_name/Master/server.ini"
check_for_file "$dontstarve_dir/$cluster_name/Caves/server.ini"

$steamcmd +force_install_dir "$install_dir" +login anonymous +app_update 343050 +quit

cp -fv "$dedicated_server_mods_setup" "$install_dir/mods/"

check_for_file "$dst_bin" 
cd "$install_dir/bin" || fail "Unable to change dir to $install_dir/bin"

run_shared=("$dst_bin")
#run_shared+=(-console)
run_shared+=(-persistent_storage_root "$persistent_storage_root")
run_shared+=(-cluster "$cluster_name")
run_shared+=(-monitor_parent_process $$)

"${run_shared[@]}" -shard Caves  | sed 's/^/Caves:  /' &
"${run_shared[@]}" -shard Master | sed 's/^/Master: /'

