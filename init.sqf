#define DEBUG false

diag_log format ["##System Date## %1", date];

StartProgress = false;
enableSaving [false, false];

X_Server = false;
X_Client = false;
X_JIP = false;
// Other vars
A3W_missionsDifficulty = 0;  // Missions difficulty (0 = normal, 1 = hard)
// **********
if (isServer) then {
	X_Server = true;
	_dateTime = "Arma2Net.Unmanaged" callExtension "DateTime ['now', 'HH:mm:ss dd']";
	_timeArray = toArray _dateTime;
	_hour = parseNumber format["%1%2",toString [_timeArray select 1], toString [_timeArray select 2]];
	_min = parseNumber format["%1%2",toString [_timeArray select 4], toString [_timeArray select 5]];
	_sec = parseNumber format["%1%2",toString [_timeArray select 7], toString [_timeArray select 8]];
	_day = parseNumber format["%1%2",toString [_timeArray select 10], toString [_timeArray select 11]];
	diag_log format ["setDate [3035,10,10,%1,%2]",_hour,_min];
	setDate [3035,10,10,(_hour - 5),_min];
};
if (!isDedicated) then { X_Client = true };
if (isNull player) then { X_JIP = true };

_globalCompile = [DEBUG] execVM "globalCompile.sqf";
waitUntil {scriptDone _globalCompile};

[] spawn
{
	if (X_Client) then
	{
		titleText ["Welcome to Austerror. Please wait for your account to load.", "BLACK", 0];
		waitUntil {!isNull player};
		client_initEH = player addEventHandler ["Respawn", {removeAllWeapons (_this select 0)}];
	};
};

//init Wasteland Core
[] execVM "config.sqf";
[] execVM "briefing.sqf";

if (X_Client) then
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

if (X_Server) then
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