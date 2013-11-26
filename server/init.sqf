if (!isServer) exitWith {};

vChecksum = compileFinal format ["'%1'", call generateKey];

//Execute Server Side Scripts.
_serverCompiledScripts = [] execVM "server\antihack\setup.sqf";
waitUntil {scriptDone _serverCompiledScripts};
[] execVM "server\admins.sqf";
[] execVM "server\functions\serverVars.sqf";
_serverCompiledScripts = [] execVM "server\functions\serverCompile.sqf";
[] execVM "server\functions\broadcaster.sqf";
[] execVM "server\functions\relations.sqf";

call compile preProcessFile "persistence\fn_inidb_custom.sqf";
execVM "persistence\players\s_serverGather.sqf";

PDB_ServerID = "any";
execVM "persistence\world\init.sqf";

execVM "server\spawning\playerSpawnLoot.sqf";

[] execVM "server\functions\serverTimeSync.sqf";

diag_log "WASTELAND SERVER - Initializing Missions";
[] execVM "server\missions\sideMissionController.sqf";
sleep 5;
[] execVM "server\missions\mainMissionController.sqf";

_heliSpawn = [] execVM "server\functions\staticHeliSpawning.sqf";
waitUntil {sleep 0.1; scriptDone _heliSpawn};


_vehSpawn = [] execVM "server\functions\vehicleSpawning.sqf";
waitUntil {sleep 0.1; scriptDone _vehSpawn};

_planeSpawn = [] execVM "server\functions\planeSpawning.sqf";
waitUntil {sleep 0.1; scriptDone _planeSpawn};

_boatSpawn = [] execVM "server\functions\boatSpawning.sqf";
waitUntil {sleep 0.1; scriptDone _boatSpawn};

_objSpawn = [] execVM "server\functions\objectsSpawning.sqf";
waitUntil {sleep 0.1; scriptDone _objSpawn};

_boxSpawn = [] execVM "server\functions\boxSpawning.sqf";
waitUntil {sleep 0.1; scriptDone _boxSpawn};

// Hooks for new players connecting, in case we need to manually update state
onPlayerConnected "[_id, _name] execVM 'server\functions\onPlayerConnected.sqf'";

[] execVM "server\WastelandServClean.sqf";