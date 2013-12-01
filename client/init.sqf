//@file Version: 1.1
//@file Name: init.sqf
//@file Author: [404] Deadbeat, [GoT] JoSchaap, AgentRev, [KoS] Bewilderbeest
//@file Created: 20/11/2012 05:19
//@file Description: The client init.

if (isDedicated) exitWith {};

[] execVM "client\functions\bannedNames.sqf";

showPlayerIcons = true;
mutexScriptInProgress = false;
respawnDialogActive = false;
groupManagmentActive = false;
pvar_PlayerTeamKiller = objNull;
doCancelAction = false;
currentMissionsMarkers = [];
currentRadarMarkers = [];

//Initialization Variables
playerCompiledScripts = false;
playerSetupComplete = false;

waitUntil {!isNull player};
waitUntil {time > 0.1};

removeAllWeapons player;
player switchMove "";

//Stop people being civ's.
if(!(playerSide in [WEST])) then {
	endMission "LOSER";
};

// initialize actions and inventory
"client\actions" call mf_init;
"client\inventory" call mf_init;
"client\items" call mf_init;

//Call client compile list.
player call compile preprocessFileLineNumbers "client\functions\clientCompile.sqf";

//Player setup
player call playerSetup;

// Player saving - Load from iniDB

positionLoaded = 0;
[] execVM "persistence\players\c_serverSaveRelay.sqf";
waitUntil {!isNil "fn_SaveToServer"};
[] execVM "persistence\players\c_playerDBSetup.sqf";
waitUntil {!isNil "statFunctionsLoaded"};
_loadPlayerAccount = [] execVM "persistence\players\c_loadAccount.sqf";
waitUntil {scriptDone _loadPlayerAccount};
waitUntil {positionLoaded == 1};

// iniDB stuff end

// Find out if the player has been moved by the persistence system
_playerWasMoved = player getVariable ["playerWasMoved", 0];

//Setup player events.
if(!isNil "client_initEH") then {player removeEventHandler ["Respawn", client_initEH];};
player addEventHandler ["Respawn", { _this spawn onRespawn }];
player addEventHandler ["Killed", { _this spawn onKilled }];

//Setup player menu scroll action.
[] execVM "client\clientEvents\onMouseWheel.sqf";

//Setup Key Handler
waituntil {!(IsNull (findDisplay 46))};
(findDisplay 46) displaySetEventHandler ["KeyDown", "_this call onKeyPress"];

"currentDate" addPublicVariableEventHandler {[] call timeSync};
"messageSystem" addPublicVariableEventHandler {[] call serverMessage};
"clientMissionMarkers" addPublicVariableEventHandler {[] call updateMissionsMarkers};
"clientRadarMarkers" addPublicVariableEventHandler {[] call updateRadarMarkers};
"compensateNegativeScore" addPublicVariableEventHandler { (_this select 1) call removeNegativeScore };

//client Executes
[] execVM "client\functions\initSurvival.sqf";
[] execVM "client\systems\hud\playerHud.sqf";
[] execVM "client\functions\createTownMarkers.sqf";
[] execVM "client\functions\playerTags.sqf";
[] execVM "client\functions\groupTags.sqf";
[] call updateMissionsMarkers;
[] call updateRadarMarkers;
if (isNil "FZF_IC_INIT") then
{
	call compile preprocessFileLineNumbers "client\functions\newPlayerIcons.sqf";
};

// If we've got a position from the player save system, don't go through playerSpawn
if (_playerWasMoved == 0) then {
	thirstLevel = 100;
	hungerLevel = 100;
	true spawn playerSpawn;
} else {
	player switchMove "";
	deleteDBFile = false;
	doPlayerSaves = true;
};

[] spawn FZF_IC_INIT;

// Load Player Saves.
execVM "server\functions\playerSaves.sqf";
player allowDamage true;

// Prevent quick logging
[] execVM "custom\preventLog.sqf";

{
	if (isPlayer _x && {!isNil ("addScore_" + (getPlayerUID _x))}) then
	{
		_x spawn removeNegativeScore;
	};
} forEach playableUnits;

player allowDamage true;
[] execVM "addons\fpsFix\vehicleManager.sqf";