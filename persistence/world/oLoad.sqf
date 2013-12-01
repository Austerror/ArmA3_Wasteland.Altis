// WARNING! This is a modified version for use with the GoT Wasteland v2 missionfile!
// This is NOT a default persistantdb script!
// changes by: JoSchaap (GoT2DayZ.nl)

sleep 10;
_check = ("Objects" call PDB_databaseNameCompiler) call iniDB_exists;
if (!_check) exitWith {};
_objectscount = ["Objects" call PDB_databaseNameCompiler, "Count", "Count", "NUMBER"] call iniDB_read;
if (isNil "_objectscount") exitWith {};
for "_i" from 0 to (_objectscount - 1) do
{
	_objSaveName = format["obj%1", _i];
	_class = ["Objects" call PDB_databaseNameCompiler, _objSaveName, "classname", "STRING"] call iniDB_read;
	_pos = ["Objects" call PDB_databaseNameCompiler, _objSaveName, "pos", "ARRAY"] call iniDB_read;
	_dir = ["Objects" call PDB_databaseNameCompiler, _objSaveName, "dir", "ARRAY"] call iniDB_read;
	_supplyleft = ["Objects" call PDB_databaseNameCompiler, _objSaveName, "supplyleft", "NUMBER"] call iniDB_read;
	_weapons = ["Objects" call PDB_databaseNameCompiler, _objSaveName, "weapons", "ARRAY"] call iniDB_read;
	_magazines = ["Objects" call PDB_databaseNameCompiler, _objSaveName, "magazines", "ARRAY"] call iniDB_read;
	_ownerId = ["Objects" call PDB_databaseNameCompiler, _objSaveName, "owner", "STRING"] call iniDB_read;
	_lockDate = ["Objects" call PDB_databaseNameCompiler, _objSaveName, "lockdate", "ARRAY"] call iniDB_read;
	if (isnil "_lockDate") then {
		_lockDate = date;
	} else {
		if (count _lockDate == 0) then {
			_lockDate = date;
		};
	}; 
	// to do! check if vehicle _lockDate is > 5 days (or whatever time limit it should be).
	if(!isNil "_objSaveName" && !isNil "_class" && !isNil "_pos" && !isNil "_dir" && !isNil "_supplyleft" && (_ownerId != "")) then 
	{
		if ((dateToNumber date - dateToNumber _lockDate) < 0.02) then { // approx 7 days (just over)
			_obj = createVehicle [_class,_pos, [], 0, "CAN COLLIDE"];
			_obj setPosASL _pos;
			_obj setVectorDirAndUp _dir;

			if(_class == "Land_Sacks_goods_F") then 
			{
				_obj setVariable["food",_supplyleft,true];
			};

			if(_class == "Land_WaterBarrel_F") then 
			{
				_obj setVariable["water",_supplyleft,true];
			};

			clearWeaponCargoGlobal _obj;
			clearMagazineCargoGlobal _obj;

			for[{_ii = 0}, {_ii < (count (_weapons select 0))}, {_ii = _ii + 1}] do {
				_obj addWeaponCargoGlobal [(_weapons select 0) select _ii, (_weapons select 1) select _ii];
			};

			for[{_ii = 0}, {_ii < (count (_magazines select 0))}, {_ii = _ii + 1}] do {
				_obj addMagazineCargoGlobal [(_magazines select 0) select _ii, (_magazines select 1) select _ii];
			};
			_obj setVariable ["objectLocked", true, true]; //force lock
			_obj setVariable ["ownerId", _ownerId, true]; // Set owner id
			_obj setVariable ["lockDate", _lockDate, true]; // Set lock date
		};
	};
};

diag_log format["GoT Wasteland - baseSaving loaded %1 parts from iniDB", _objectscount];
execVM "persistence\world\oSave.sqf";