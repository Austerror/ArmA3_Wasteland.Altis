//	@file Version: 1.0
//	@file Name: playerSpawn.sqf
//	@file Author: [404] Deadbeat
//	@file Created: 20/11/2012 05:19
//	@file Args:

private ["_side"];

playerSpawning = true;
playerUID = getPlayerUID(player);
townSearch = 0;
beaconSearch = 0;

//Send player to debug zone to stop fake spawn locations.
player setPosATL [7837.37,7627.14,0.00230217];
player setDir 333.429;
//             

[] execVM 'client\functions\spawnAction.sqf'";

sleep 0.1;
playerSpawning = false;