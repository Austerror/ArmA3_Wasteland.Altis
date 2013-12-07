// WARNING! This is a modified version for use with the GoT Wasteland v2 missionfile!
// This is NOT a default persistantdb script!
// changes by: JoSchaap (GoT2DayZ.nl)
sleep 5;
while {true} do {
	//player groupchat "hey";
	PersistentDB_ObjCount = 0;
	{
		_var = _x getVariable "objectLocked";
		_ownerId = _x getVariable "ownerId";
		_lockDate = _x getVariable "lockDate";
		_vDamage = damage _x;
		if (isnil "_lockDate") then {
			_lockDate = date;
		} else {
			if (count _lockDate < 5) then {
				_lockDate = date;
			};
		}; 
		if(!isNil "_ownerId" && (alive _x)) then {
			_classname = typeOf _x;
			// addition to check if the classname matches the building parts
			//if(!isNil "_ownerId") then {
				_pos = getPosASL _x;
				_dir = [vectorDir _x] + [vectorUp _x];

				_supplyleft = 0;

				if(_x isKindOf "Land_Sacks_goods_F") then {
					_supplyleft = _x getVariable "food";
					if(isNil "_supplyleft") then
					{
						_supplyleft = 20;
					};
				};

				if(_x isKindOf "Land_WaterBarrel_F") then { 
					_supplyleft = _x getVariable "water";
					if(isNil "_supplyleft") then
					{
						_supplyleft = 20;
					};
				};

				_weapons = getWeaponCargo _x;
				_magazines = getMagazineCargo _x;
				_objSaveName = format["obj%1", PersistentDB_ObjCount];

				["Objects" call PDB_databaseNameCompiler, _objSaveName, "classname", _classname] call iniDB_write;
				["Objects" call PDB_databaseNameCompiler, _objSaveName, "pos", _pos] call iniDB_write;
				["Objects" call PDB_databaseNameCompiler, _objSaveName, "dir", _dir] call iniDB_write;
				["Objects" call PDB_databaseNameCompiler, _objSaveName, "supplyleft", _supplyleft] call iniDB_write;
				["Objects" call PDB_databaseNameCompiler, _objSaveName, "weapons", _weapons] call iniDB_write;
				["Objects" call PDB_databaseNameCompiler, _objSaveName, "magazines", _magazines] call iniDB_write;
				["Objects" call PDB_databaseNameCompiler, _objSaveName, "owner", _ownerId] call iniDB_write;
				["Objects" call PDB_databaseNameCompiler, _objSaveName, "lockdate", _lockDate] call iniDB_write;
				["Objects" call PDB_databaseNameCompiler, _objSaveName, "damage", _vDamage] call iniDB_write;

				PersistentDB_ObjCount = PersistentDB_ObjCount + 1;
			//};
		};
	} forEach allMissionObjects "All";
	["Objects" call PDB_databaseNameCompiler, "Count", "Count", PersistentDB_ObjCount] call iniDB_write;
	diag_log format["A3W - Base saving has saved %1 parts to iniDB", PersistentDB_ObjCount];
	sleep 120;
};
