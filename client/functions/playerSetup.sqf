//	@file Name: playerSetup.sqf
//	@file Author: [GoT] JoSchaap
player groupChat "Player Setup.";
_player = _this;
_player setskill 0;
{_player disableAI _x} foreach ["move","anim","target","autotarget"];
_player setVariable ["BIS_noCoreConversations", true];
_player allowDamage false;

enableSentences false;

// # Setup Random Clothing Arrays ##########
random_hatlist = 
[
	"H_Cap_blk",
	"H_Cap_grn",
	"H_Cap_tan",
	"H_Cap_red",
	"H_Hat_tan",
	"H_Hat_grey",
	"H_StrawHat",
	"H_Watchcap_blk"
];
random_uniformlist = 
[
	"U_C_Commoner1_1",			// Viable
	"U_C_Commoner1_2",			// Viable
	"U_C_Commoner1_3",			// Viable
	"U_C_HunterBody_grn",
	"U_C_Poloshirt_blue",
	"U_C_Poloshirt_burgundy",
	"U_C_Poloshirt_redwhite",
	"U_C_Poloshirt_salmon",
	"U_C_Poloshirt_stripped",
	"U_C_Poloshirt_tricolour",
	"U_C_Poor_1",
	"U_C_Poor_2",
	"U_C_ShirtSurfer_shorts",
	"U_C_TeeSurfer_shorts_1",
	"U_C_TeeSurfer_shorts_2",
	"U_C_WorkerCoveralls",
	"U_Competitor"				// Viable
];

// # Remove players default items ##########
removeAllWeapons _player;
removeUniform _player;
removeVest _player;
removeBackpack _player;
removeHeadgear _player;
removeGoggles _player;
_player unassignItem "ItemGPS";
_player removeItem "ItemGPS";
private "_nvgClass";
_nvgClass = "NVGoggles";
{
	if (["NVGoggles", _x] call fn_findString != -1) then
	{
		_player unassignItem _x;
		_player removeItem _x;
	};
} forEach assignedItems _player;

// # Select Random Clothing ################
_uniform = random_uniformlist select (round (random ((count random_uniformlist) - 1)));
_hat = random_hatlist select (round (random ((count random_hatlist) - 1)));

// # Add new default items to player #######
_player addUniform _uniform;
_player addHeadgear _hat;
_player addBackpack "B_AssaultPack_blk";

sleep 0.1;

_player addMagazine "16Rnd_9x21_Mag";
_player addWeapon "hgun_P07_F";
_player addMagazine "16Rnd_9x21_Mag";
_player addItem "FirstAidKit";
_player selectWeapon "hgun_P07_F";
_player addrating 9999999;

//sleep 2;

// # Setup defualt player variables ########
thirstLevel = 100;
hungerLevel = 100;
_player setVariable ["thirstLevel", 100, true];
_player setVariable ["hungerLevel", 100, true];
_player setVariable ["cmoney",100,true];
[objNull, _player] call mf_player_actions_refresh;
[] execVM "client\functions\playerActions.sqf";

_player groupChat format["Wasteland - Initialization Complete"];
playerSetupComplete = true;
