//	@file Name: admins.sqf

if (!isServer) exitWith {};

// Admin menu (U key) access levels

/*******************************************************
 Player UID examples :

	"76561198071564585" // Menthol

 Important: Don't put a comma (,) at the end of the last one
********************************************************/

// Low Administrators: manage & spectate players, remove hacked vehicles
lowAdmins = compileFinal str
[
	// Put player UIDs here
];

// High Administrators: manage & spectate players, remove hacked vehicles, show player tags
highAdmins = compileFinal str
[
	// Put player UIDs here
];

// Server Owners: access to everything
serverOwners = compileFinal str
[
	// Put player UIDs here
	"76561198071564585",
	"76561198088269235"
];

/********************************************************/

if (typeName lowAdmins == "ARRAY") then { lowAdmins = compileFinal str lowAdmins };
if (typeName highAdmins == "ARRAY") then { highAdmins = compileFinal str highAdmins };
if (typeName serverOwners == "ARRAY") then { serverOwners = compileFinal str serverOwners };

publicVariable "lowAdmins";
publicVariable "highAdmins";
publicVariable "serverOwners";
