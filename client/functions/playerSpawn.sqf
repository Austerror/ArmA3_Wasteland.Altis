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

titleText ["Loading...", "BLACK OUT", 0.00001];

private ["_handle"];
true spawn client_respawnDialog;

waitUntil {respawnDialogActive};

while {respawnDialogActive} do {
	titleText ["", "BLACK OUT", 0.00001];
};
sleep 0.1;
titleText ["", "BLACK IN", 0.00001];
playerSpawning = false;