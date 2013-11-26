//	Random weapons and items spawning script for wasteland missions.
//	Authors: 
//	original: Ed! (404Forums)
//	Adjusted for Arma3 Wasteland use by: [GoT] JoSchaap (GoT2DayZ.nl), 
//	Player near town spawning concept by: Na_Palm (BIS-Forums)

_odd1 = 80;					//The odds that a building is selected to place loot.
_odd2 = 25;					//The odds that the selected building's spots will have loot(almost like odds per room).
_uncommonChance = 30;		// Odds of uncommon loot (does not include custom wasteland items like food, water, first aid kits etc).
_rareChance = 10;			// Odds of rare loot (does not include custom wasteland items like food, water, first aid kits etc).
_odditem = 33;				// Odds of an item instead of 'weapon' loot.
_odditemrare = 20;			// Odds that it will be a rare item when item is selected.
_oddfuelcan = 35;				//Chance of a spawned fuelcan to be full instead of empty
_spawnradius = 75;				//Distance around the player in which to look for buildings to spawn loot in.
_interval = 180;				//Time (in sec.) to pass before a new loot spawn.
randomweapontestint = 0.1;			//Sets the intervals in which weaponpositions are tested. (Lower = slower, but more accurate. Higher = faster, but less accurate.)

// Buildings that can spawn loot.
#include "lootBuildings.sqf"
//Loot tables
#include "lootLists.sqf"
//The allbuildings, allweapons check.
#include "lootChecks.sqf"

//-------------------------------------------------------------------------------------
    spawnLoot = 
	{
		_position = _this select 0;
		lootType = _this select 1;
		_lType = [];
		{
			_spawned = _x getVariable "spawned";
			_lootAge = time - _spawned; // Age of loot in seconds.
			if (_lootAge > 1800) then {
				deleteVehicle _x;
				diag_log format ["##Loot Spawning Debug## Deleted loot pile %1",_x];
			}
		} forEach nearestObjects [_position,["groundWeaponHolder"],1];   // removes loot pile over 1 hour old.
		
		_existingSpawns = count (nearestObjects [_position,["groundWeaponHolder"],1]);
		//diag_log format ["##Loot Spawning Debug## exisitingSpawns = %1, lootType = %2", _existingSpawns, lootType];
		if (_existingSpawns < 1) then {
			_weaponholder = createVehicle ["groundWeaponHolder", _position, [], 0, "CAN_COLLIDE"];
			for[{_pc = 0}, {_pc < (3 + floor(random(2)))}, {_pc = _pc + 1}] do {
				switch (lootType) do
				{
					case 'comLoot':	{
						//diag_log format ["##Loot Spawning Debug## case comLoot (%1)",lootType];
						_lootChance = (random 100);
						if (_lootChance < _rareChance) then {
							_lType = comLootR;
						} else {
							if (_lootChance < _uncommonChance) then {
								_lType = comLootU;
							} else {
								_lType = comLootC;
							};
						};
					};
					case 'milLoot':	{
						_lootChance = (random 100);
						if (_lootChance < _rareChance) then {
							_lType = milLootR;
						} else {
							if (_lootChance < _uncommonChance) then {
								_lType = milLootU;
							} else {
								_lType = milLootC;
							};
						};
					};
					case 'civLoot':	{
						_lootChance = (random 100);
						if (_lootChance < _rareChance) then {
							_lType = civLootR;
						} else {
							if (_lootChance < _uncommonChance) then {
								_lType = civLootU;
							} else {
								_lType = civLootC;
							};
						};
					};
					case 'medLoot':	{
						_lootChance = (random 100);
						if (_lootChance < _rareChance) then {
							_lType = medLootR;
						} else {
							if (_lootChance < _uncommonChance) then {
								_lType = medLootU;
							} else {
								_lType = medLootC;
							};
						};
					};
					case 'indLoot':	{
						_lootChance = (random 100);
						if (_lootChance < _rareChance) then {
							_lType = indLootR;
						} else {
							if (_lootChance < _uncommonChance) then {
								_lType = indLootU;
							} else {
								_lType = indLootC;
							};
						};
					};
				};
				//diag_log format ["##Loot Spawning Debug## _lType = %1",_lType];
				_selectedgroup = (floor(random(count _lType)));
				_weapon = _lType select _selectedgroup select 0;
				//diag_log format ["##Loot Spawning Debug## _weapon = %1", _weapon];
				if (_weapon in _allBackpacks) then {
					_weaponholder addBackpackCargoGlobal [_weapon, 1];
				} else {
					if (_weapon in _allWeapons) then {
						_weaponholder addWeaponCargoGlobal [_weapon, 1];
						for[{_rm = 0}, {_rm < (1 + floor(random(2)))}, {_rm = _rm + 1}] do {
							_mag = ((getArray (configFile >> "CfgWeapons" >> _weapon >> "magazines")) select 0) call getBallMagazine;
							_weaponholder addMagazineCargoGlobal [_mag, 1];
						};
					} else {
						_weaponholder addItemCargoGlobal [_weapon, 1];					
					};
				};
			};
			_weaponholder setPos _position;
			_weaponholder setVariable ["spawned", time];
		};
    };
	
    spawnItem = 
	{
		_position = _this;
		_numf = 0;
		_selectedgroup = (floor(random(count randomweapon_itemlist)));
		_class = randomweapon_itemlist select _selectedgroup;
		{ deleteVehicle _x; } forEach nearestObjects [_position,randomweapon_itemlist,0.3];   //dirty fix for piling loot after 12hours
		existingSpawns = count (nearestObjects [_position,["groundWeaponHolder"],0.3]);
		if (existingSpawns < 1) then {
			_item = createVehicle [_class, _position, [], 0, "CAN_COLLIDE"];
			if(_class == "Land_CanisterFuel_F") then {
				_numf = (random 100);
				if (_numf < _oddfuelcan) then {
					_item setVariable["mf_item_id", "jerrycanfull", true];
				} else {
					_item setVariable["mf_item_id", "jerrycanempty", true];
				};
			};
			if(_class == "Land_CanisterOil_F")then {
				_item setVariable["mf_item_id", "syphonhose", true];
			};
			if(_class == "Land_Can_V3_F")then {
				_item setVariable["mf_item_id", "energydrink", true];
			};
			if(_class == "Land_BakedBeans_F") then {
				_item setVariable["mf_item_id", "cannedfood", true];
			};
			if(_class == "Land_BottlePlastic_V2_F") then {
				_item setVariable["mf_item_id", "water", true];
			};
			if(_class == "Land_Suitcase_F") then {
				_item setVariable["mf_item_id", "repairkit", true];
			};
			_item setPos _position;
		};
    };

    spawnItemRare = 
	{
		_position = _this;
		_numf = 0;
		_selectedgroup = (floor(random(count randomweapon_itemlistrare)));
		_class = randomweapon_itemlistrare select _selectedgroup;
		{ deleteVehicle _x; } forEach nearestObjects [_position,randomweapon_itemlistrare,0.3];   //dirty fix for piling loot after 12hours
		existingSpawns = count (nearestObjects [_position,["groundWeaponHolder"],0.3]);
		if (existingSpawns < 1) then {
			_item = createVehicle [_class, _position, [], 0, "CAN_COLLIDE"];
			if(_class == "Land_CanisterFuel_F") then {
				_numf = (random 100);
				if (_numf < _oddfuelcan) then {
					_item setVariable["mf_item_id", "jerrycanfull", true];
				} else {
					_item setVariable["mf_item_id", "jerrycanempty", true];
				};
			};
			if(_class == "Land_CanisterOil_F")then {
				_item setVariable["mf_item_id", "syphonhose", true];
			};
			if(_class == "Land_Can_V3_F")then {
				_item setVariable["mf_item_id", "energydrink", true];
			};
			if(_class == "Land_BakedBeans_F") then {
				_item setVariable["mf_item_id", "cannedfood", true];
			};
			if(_class == "Land_BottlePlastic_V2_F") then {
				_item setVariable["mf_item_id", "water", true];
			};
			if(_class == "Land_Suitcase_F") then {
				_item setVariable["mf_item_id", "repairkit", true];
			};
			_item setPos _position;
		};
    };
//-------------------------------------------------------------------------------------
	
spawnlootintown = {
    _pos = _this;
    allBuildings = nearestObjects [_pos, _allBuildings, _spawnradius];
    sleep 10;
	{
		_building = _x;
		_buildingName = typeOf _building;
		_buildingpos = [];
		_endloop = false;
		_poscount = 0;
		while {!_endloop} do {
			if(((_building buildingPos _poscount) select 0) != 0 && ((_building buildingPos _poscount) select 1) != 0) then {
				_buildingpos = _buildingpos + [_building buildingPos _poscount];
				_poscount = _poscount + 1;
			} else {
				_endloop = true;
			};
		};
		_num = (random 100);
		if (_num < _odd1) then {
			if (count _buildingpos > 0) then {  
				for[{_r = 0}, {_r < count _buildingpos}, {_r = _r + 1}] do
				{
					_num2 = (random 100);
					if (_num2 < _odd2) then {
						_pos = _buildingpos select _r;
						_posnew = _pos;
						if(_pos select 2 < 0) then {
							_pos = [_pos select 0, _pos select 1, 1];
						};
						_z = 0;
						_testpos = true;
						while {_testpos} do 
						{
							if((!lineIntersects[ATLtoASL(_pos), ATLtoASL([_pos select 0, _pos select 1, (_pos select 2) - (randomweapontestint * _z)])]) && (!terrainIntersect[(_pos), ([_pos select 0, _pos select 1, (_pos select 2) - (randomweapontestint * _z)])]) && (_pos select 2 > 0)) then {
								_posnew = [_pos select 0, _pos select 1, (_pos select 2) - (randomweapontestint * _z)];
								_z = _z + 1;
							} else {
								_testpos = false;
							};
						};
						_posnew = [_posnew select 0,_posnew select 1,(_posnew select 2) + 0.05];
						_woi = floor(random(100));
						//_selectedgroup = (floor(random(count comLoot)));
						if (_woi < _odditem) then {
							_woi = floor(random(100));
							if (_woi < _odditemrare) then {
								_posnew call spawnItemRare;
							} else {
								_posnew call spawnItem;
							};
						} else {
							if (_buildingName in _buildCOM) then { // Commercial Building
								[_posnew,"comLoot"] call spawnLoot;
							} else {
								if (_buildingName in _buildIND) then { // Industrial Building
									[_posnew,"indLoot"] call spawnLoot;
								} else {
									if (_buildingName in _buildMED) then { // Medical Building
										[_posnew,"medLoot"] call spawnLoot;
									} else {
										if (_buildingName in _buildCIV) then { // Civilian Building
											[_posnew,"civLoot"] call spawnLoot;
										} else {
											if (_buildingName in _buildMIL) then { // Military Building
												[_posnew,"milLoot"] call spawnLoot;
											};
										};
									};
								};
							};
						};
					};
				};
			};    
		};
    }foreach allBuildings;
};

//-------------------------------------------------------------------------------------

	townarea_list = [];
	_posPlayer = [];
	_posTown = [];
	_tradius = 0;
	_lastSpawned = 0;
	while {true} do {
		{
			diag_log format ["##Loot Spawning Debug## playableUnit = %1 (%2) [isPlayer = %3, alive = %4, vehicle _x = %5]", _x,(name _x),(isPlayer _x),(alive _x),(name vehicle _x)];
			if ((isPlayer _x) && (alive _x) && (vehicle _x == _x)) then {
				_posPlayer = getPos _x;
				_posPlayer call spawnlootintown;
			};		
		}forEach playableUnits;
		sleep _interval;
	};
