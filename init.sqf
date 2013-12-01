																																																												asaerw3rw3r4 = 1; Menu_Init_Lol = 1;
//	@file Version: 1.2
//	@file Name: init.sqf
//	@file Author: [404] Deadbeat, [GoT] JoSchaap
//	@file Description: The main init.

#define DEBUG false

StartProgress = false;
enableSaving [false, false];

X_Server = false;
X_Client = false;
X_JIP = false;
hitStateVar = false;

// **********
if (isServer) then {
	X_Server = true;
	[] execVM "server\functions\realTimeSync.sqf";
};
if (!isDedicated) then { X_Client = true };
if (isNull player) then { X_JIP = true };

_globalCompile = [DEBUG] execVM "globalCompile.sqf";
waitUntil {scriptDone _globalCompile};

[] spawn
{
	if (!isDedicated) then
	{
		titleText ["Welcome to Austerror. Please wait for your account to load.", "BLACK", 0];
		waitUntil {!isNull player};
		client_initEH = player addEventHandler ["Respawn", {removeAllWeapons (_this select 0)}];
	};
};

//init Wasteland Core
[] execVM "config.sqf";
[] execVM "briefing.sqf";

if (!isDedicated) then
{
	waitUntil {!isNull player};

	//Wipe Group.
	if (count units player > 1) then
	{  
		diag_log "Player Group Wiped";
		[player] join grpNull;
	};

	[] execVM "client\init.sqf";
};

if (isServer) then
{
	diag_log format ["############################# %1 #############################", missionName];
	diag_log "WASTELAND SERVER - Initializing Server";
	[] execVM "server\init.sqf";
};

[] execVM "custom\checkVehicleLock.sqf";
[] execVM "custom\checkVehicleLock2.sqf";
[] execVM "addons\R3F_ARTY_AND_LOG\init.sqf";
[] execVM "addons\proving_Ground\init.sqf";
[] execVM "addons\scripts\DynamicWeatherEffects.sqf";
//[] execVM "addons\JumpMF\init.sqf";