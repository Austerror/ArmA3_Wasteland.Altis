//	Random weapons and items spawning script for wasteland missions.
//	Authors: 
//	original: Ed! (404Forums)
//	Adjusted for Arma3 Wasteland use by: [GoT] JoSchaap (GoT2DayZ.nl), 
//	Player near town spawning concept by: Na_Palm (BIS-Forums)

_odd1 = 75;					//The odds that a building is selected to place loot.
_odd2 = 25;					//The odds that the selected building's spots will have loot(almost like odds per room).
_odditem = 65;
_oddcustom = 70;				//Chance of custom item instead of weapon
_oddweapitem = 45;				//instead of the weapon picked in above declared chance above there's also a chance to spawn other items instead of a rifle like medkits,toolkits,optics,silencers etc.
_oddfuelcan = 35;				//Chance of a spawned fuelcan to be full instead of empty
_spawnradius = 25;				//Distance added to the radius around city's original marker to spawn loot (expands the radius with this value)
_interval = 5400;				//Time (in sec.) to pass before a city spawns new loot (5400 - 1,5 hr)
randomweapontestint = 0.05;			//Sets the intervals in which weaponpositions are tested. (Lower = slower, but more accurate. Higher = faster, but less accurate.)
									
//Array of buildings that are eligible to spawn loot in :)
_buildCIV = 
[
	"Land_Airport_center_F",
	"Land_Airport_left_F",
	"Land_Airport_right_F",
	"Land_Airport_Tower_F",
	"Land_CarService_F",
	"Land_Castle_01_tower_F",
	"Land_Chapel_Small_V1_F",
	"Land_Chapel_Small_V2_F",
	"Land_Chapel_V1_F",
	"Land_Chapel_V2_F",
	"Land_dp_bigTank_F",
	"Land_dp_mainFactory_F",
	"Land_Hospital_main_F",
	"Land_Hospital_side1_F",
	"Land_Hospital_side2_F",
	"Land_i_Addon_02_V1_F",
	"Land_i_Addon_03_V1_F",
	"Land_i_Garage_V1_F",
	"Land_i_Garage_V2_F",
	"Land_i_House_Big_01_V1_F",
	"Land_i_House_Big_01_V2_F",
	"Land_i_House_Big_01_V3_F",
	"Land_i_House_Big_02_V1_F",
	"Land_i_House_Big_02_V2_F",
	"Land_i_House_Big_02_V3_F",
	"Land_i_House_Small_01_V1_F",
	"Land_i_House_Small_01_V2_F",
	"Land_i_House_Small_01_V3_F",
	"Land_i_House_Small_02_V1_F",
	"Land_i_House_Small_02_V2_F",
	"Land_i_House_Small_02_V3_F",
	"Land_i_House_Small_03_V1_F",
	"Land_i_Shed_Ind_F",
	"Land_i_Shop_01_V1_F",
	"Land_i_Shop_01_V2_F",
	"Land_i_Shop_01_V3_F",
	"Land_i_Shop_02_V1_F",
	"Land_i_Shop_02_V2_F",
	"Land_i_Shop_02_V3_F",
	"Land_i_Stone_HouseBig_V1_F",
	"Land_i_Stone_HouseBig_V2_F",
	"Land_i_Stone_HouseBig_V3_F",
	"Land_i_Stone_HouseSmall_V1_F",
	"Land_i_Stone_HouseSmall_V2_F",
	"Land_i_Stone_HouseSmall_V3_F",
	"Land_i_Stone_Shed_V1_F",
	"Land_i_Stone_Shed_V2_F",
	"Land_i_Stone_Shed_V3_F",
	"Land_i_Windmill01_F",
	"Land_Metal_Shed_F",
	"Land_Offices_01_V1_F",
	"Land_Slum_House01_F",
	"Land_Slum_House02_F",
	"Land_Slum_House03_F",
	"Land_spp_Tower_F",
	"Land_u_Addon_01_V1_F",
	"Land_u_Addon_02_V1_F",
	"Land_u_House_Small_01_V1_F",
	"Land_u_House_Small_02_V1_F",
	"Land_u_Shop_01_V1_F",
	"Land_u_Shop_02_V1_F",
	"Land_WIP_F"
];

_buildMIL = 
[
	"Land_MilOffices_V1_F",
	"Land_i_Barracks_V1_F",
	"Cargo_House_base_F",
	"Cargo_Patrol_base_F",
	"Cargo_HQ_base_F"
	//"Land_Hangar_F",
	//"Cargo_Tower_base_F",
	//"Land_Dome_Big_F",
	//"Land_Dome_Small_F"
];

// weapons to be found in civilian buildings aside from items
randomweapon_weaponlist = 
[
	["SMG_01_F"],
	["SMG_02_F"],
	["hgun_PDW2000_F"],
	["arifle_MK20C_F"],
	["arifle_MK20_F"],
	["arifle_TRG20_ACO_F"],
	["arifle_TRG21_ACO_pointer_F"]
];

// random weaponitems/ammo to be found in civillian buildings aside from items
randomweapon_weaponitemlist =
[
	["ItemGPS"],
	["Medikit"],
	["ToolKit"],
	["FirstAidKit"],
	["muzzle_snds_M"],
	["muzzle_snds_H"],
	["muzzle_snds_acp"],
	["optic_Aco"],
	["optic_ACO_grn"],
	["optic_aco_smg"],
	["optic_Holosight"],
	["optic_Holosight_smg"]
];

// weapons to be found in military buildings
randomweapon_milweaponlist = 
[
	["arifle_TRG20_F"],
	["arifle_TRG21_F"],
	["arifle_TRG21_GL_F"],
	["arifle_Katiba_C_F"],
	["arifle_Katiba_F"],
	["arifle_Katiba_GL_F"],
	["arifle_MXC_F"],
	["arifle_MX_F"],
	["arifle_MX_GL_F"],
	["arifle_MXM_F"]
];


randomweapon_itemlist = 
[
	"Land_Basket_F", // Food
	"Land_CanisterPlastic_F", // Water
	"Land_Suitcase_F",
	"Land_CanisterFuel_F", //fuelcan
	"Land_Can_V3_F", //energydrink redgull gives you stamina!
	"Land_CanisterOil_F" // syphon hose
];

randomweapon_customlist = 
[
	// Headgear
	// // Bandanas
	["H_Bandanna_camo"], // Bandanna (Camo)
	["H_Bandanna_cbr"], // Bandana (Coyote)
	["H_Bandanna_gry"], // Bandana (Gray)
	["H_Bandanna_khk"], // Bandana (Khaki)
	["H_Bandanna_mcamo"], // Bandana (MTP)
	["H_Bandanna_sgg"], // Bandana (Sage)
	["H_Bandanna_surfer"], // Bandana (Surfer)
	// // Bandana Masks
	["H_BandMask_blk"], // Bandanna Mask (Black)
	["H_BandMask_demon"], // Bandanna Mask (Demon)
	["H_BandMask_khk"], // Bandanna Mask (Khaki)
	["H_BandMask_reaper"], // Bandanna Mask (Reaper)
	// // Berets
	["H_Beret_blk"], // Beret (Black)
	["H_Beret_blk_POLICE"], // Beret (Police)
	["H_Beret_brn_SF"], // Beret (SAS)
	["H_Beret_grn"], // Beret (Green)
	["H_Beret_grn_SF"], // Beret (SF)
	["H_Beret_ocamo"], // Beret (CSAT)
	["H_Beret_red"], // Beret (Red)
	// // Boonie Hats
	["H_Booniehat_dgtl"], // Boonie Hat (AAF)
	["H_Booniehat_dirty"], // Boonie Hat (Dirty)
	["H_Booniehat_grn"], // Boonie Hat (Green)
	["H_Booniehat_indp"], // Boonie Hat (Khaki)
	["H_Booniehat_khk"], // Boonie Hat (Hex)
	["H_Booniehat_mcamo"], // Boonie Hat (MTP)
	["H_Booniehat_tan"], // Boonie Hat (Tan)
	// // Caps
	["H_Cap_blk"], // Cap (Black)
	["H_Cap_blk_ION"], // Cap (ION)
	["H_Cap_blk_Raven"], // Cap (Raven Security)
	["H_Cap_blu"], // Cap (Blue)
	["H_Cap_brn_SPECOPS"], // Cap (SPECOPS)
	["H_Cap_grn"], // Cap (Green)
	["H_Cap_grn_BI"], // Cap (BI)
	["H_Cap_headphones"], // Cap (Rangemaster)
	["H_Cap_khaki_specops_UK"], // Cap (SAS)
	["H_Cap_oli"], // Cap (Green)
	["H_Cap_red"], // Cap (Red)
	["H_Cap_tan"], // Cap (Tan)
	["H_Cap_tan_specops_US"], // Cap (SF)
	// // Heli Crew Helmets
	["H_CrewHelmetHeli_B"], // Heli Crew Helmet (NATO)
	["H_CrewHelmetHeli_I"], // Heli Crew Helmet (AAF)
	["H_CrewHelmetHeli_O"], // Heli Crew Helmet (CSAT)
	// // Hats
	["H_Hat_blue"], // Hat (Blue)
	["H_Hat_brown"], // Hat (Brown)
	["H_Hat_camo"], // Hat (Camo)
	["H_Hat_checker"], // Hat (Checker)
	["H_Hat_grey"], // Hat (Gray)
	["H_Hat_tan"], // Hat (Tan)

	// // Shemags
	["H_Shemag_khk"], // Shemag mask (Khaki)
	["H_Shemag_olive"], // Shemag mask (Olive)
	["H_Shemag_tan"], // Shemag mask (Tan)
	
	// // Turbans
	["H_TurbanO_blk"], // Black Turban
	// Uniforms
	["U_B_CombatUniform_mcam"], // Combat Fatigues (MTP)
	["U_B_CombatUniform_mcam_tshirt"], // Combat Fatigues (MTP - Tee)
	["U_B_CombatUniform_mcam_vest"], // Recon Fatigues (MTP)
	["U_B_CombatUniform_mcam_worn"], // Worn Combat Fatigues (MTP)
	["U_B_GhillieSuit"], // Ghillie Suit (NATO)
	["U_B_HeliPilotCoveralls"], // Heli Pilot Coveralls
	["U_B_SpecopsUniform_sgg"], // Specop Fatigues (Sage)
	["U_B_Wetsuit"], // Westuit (NATO)
	["U_Rangemaster"], // Rangemaster
	// Vests
	// // Slash Bandoliers
	["V_BandollierB_blk"], // Slash Bandolier (Black)
	["V_BandollierB_cbr"], // Slash Bandolier (Coyote)
	["V_BandollierB_khk"], // Slash Bandolier (Khaki)
	["V_BandollierB_oli"], // Slash Bandolier (Olive)
	["V_BandollierB_rgr"], // Slash Bandolier (Green)
	// // Chestrigs
	["V_Chestrig_blk"], // Fighter Chestrig (Black)
	["V_Chestrig_khk"], // Chestrig (Khaki)
	["V_Chestrig_oli"], // Fighter Chestrig (Olive)
	["V_Chestrig_rgr"], // Chestrig (Khaki)
	// Backpacks
	["B_AssaultPack_blk"],
	["B_AssaultPack_cbr"],
	["B_AssaultPack_dgtl"],
	["B_AssaultPack_rgr"],
	["B_AssaultPack_khk"],
	["B_AssaultPack_mcamo"],
			
	["B_FieldPack_blk"],
	["B_FieldPack_cbr"],
	["B_FieldPack_ocamo"],
	["B_FieldPack_khk"],
	["B_FieldPack_oli"],
	["B_FieldPack_oucamo"],
		
	["B_Kitbag_Base"],
	["B_Kitbag_cbr"],
	["B_Kitbag_mcamo"],
	["B_Kitbag_sgg"],
		
	["B_Bergen_blk"],
	["B_Bergen_rgr"],
	["B_Bergen_mcamo"],
	["B_Bergen_sgg"],
		
	["B_Carryall_cbr"],
	["B_Carryall_ocamo"],
	["B_Carryall_khk"],
	["B_Carryall_mcamo"],
	["B_Carryall_oli"],
	["B_Carryall_oucamo"]
];
//-------------------------------------------------------------------------------------
    randomweaponspawncustom = 
	{
		_position = _this;
		_selectedgroup = (floor(random(count randomweapon_customlist)));
		_weapon = randomweapon_customlist select _selectedgroup select 0;
		{ deleteVehicle _x; } forEach nearestObjects [_position,["groundWeaponHolder"],0.3];   //dirty fix for piling loot after 12hours
		_weaponholder = createVehicle ["groundWeaponHolder", _position, [], 0, "CAN_COLLIDE"];
		_weaponholder addItemCargoGlobal [_weapon, 1];
		_weaponholder setPos _position;
    };

    randomweaponspawnweapon = 
	{
		_position = _this;
		_selectedgroup = (floor(random(count randomweapon_weaponlist)));
		_weapon = randomweapon_weaponlist select _selectedgroup select 0;
		{ deleteVehicle _x; } forEach nearestObjects [_position,["groundWeaponHolder"],0.3];   //dirty fix for piling loot after 12hours
		_weaponholder = createVehicle ["groundWeaponHolder", _position, [], 0, "CAN_COLLIDE"];
		_weaponholder addWeaponCargoGlobal [_weapon, 1];
		//if((count((randomweapon_weaponlist) select _selectedgroup)) > 1) then {
			for[{_rm = 0}, {_rm < (2 + floor(random(3)))}, {_rm = _rm + 1}] do {
				_mag = ((getArray (configFile >> "CfgWeapons" >> _weapon >> "magazines")) select 0) call getBallMagazine;
				_weaponholder addMagazineCargoGlobal [_mag, 1]; 
			};
		//};
		_weaponholder setPos _position;
    };
	
	randomweaponspawnweaponitem = 
	{
		_position = _this;
		_selectedgroup = (floor(random(count randomweapon_weaponitemlist)));
		_weapon = randomweapon_weaponitemlist select _selectedgroup select 0;
		{ deleteVehicle _x; } forEach nearestObjects [_position,["groundWeaponHolder"],0.3];   //dirty fix for piling loot after 12hours
		_weaponholder = createVehicle ["groundWeaponHolder", _position, [], 0, "CAN_COLLIDE"];
		_weaponholder addItemCargoGlobal [_weapon, 1];
		if((count((randomweapon_weaponitemlist) select _selectedgroup)) > 1) then {
			_mag = randomweapon_weaponitemlist select _selectedgroup select ((floor(random((count(randomweapon_weaponitemlist select _selectedgroup) - 1)))) + 1);
			_weaponholder addMagazineCargoGlobal [_mag, 1]; 
		};
		_weaponholder setPos _position;
    };
	
	randomweaponspawnmilweapon = 
	{
		_position = _this;
		_selectedgroup = (floor(random(count randomweapon_milweaponlist)));
		_weapon = randomweapon_milweaponlist select _selectedgroup select 0;
		{ deleteVehicle _x; } forEach nearestObjects [_position,["groundWeaponHolder"],0.3];   //dirty fix for piling loot after 12hours
		_weaponholder = createVehicle ["groundWeaponHolder", _position, [], 0, "CAN_COLLIDE"];
		_weaponholder addWeaponCargoGlobal [_weapon, 1];
		//if((count((randomweapon_milweaponlist) select _selectedgroup)) > 1) then {
			for[{_rm = 0}, {_rm < (2 + floor(random(3)))}, {_rm = _rm + 1}] do {
				_mag = ((getArray (configFile >> "CfgWeapons" >> _weapon >> "magazines")) select 0) call getBallMagazine;
				_weaponholder addMagazineCargoGlobal [_mag, 1]; 
			};
		//};
		_weaponholder setPos _position;
    };

	
    randomweaponspawnitem = 
	{
		_position = _this;
		_numf = 0;
		_selectedgroup = (floor(random(count randomweapon_itemlist)));
		_class = randomweapon_itemlist select _selectedgroup;
		{ deleteVehicle _x; } forEach nearestObjects [_position,randomweapon_itemlist,0.3];   //dirty fix for piling loot after 12hours
		_item = createVehicle [_class, _position, [], 0, "CAN_COLLIDE"];
		if(_class == "Land_CanisterFuel_F") then {
			_numf = (random 100);
			if (_numf < _oddfuelcan) then {
				//_item setVariable["fuel", true, true];
				_item setVariable["mf_item_id", "jerrycanfull", true];
			} else {
				//_item setVariable["fuel", false, true];
				_item setVariable["mf_item_id", "jerrycanempty", true];
			};
		};
		if(_class == "Land_CanisterOil_F")then {
			_item setVariable["mf_item_id", "syphonhose", true];
		};
		if(_class == "Land_Can_V3_F")then {
			_item setVariable["mf_item_id", "energydrink", true];
		};
		if(_class == "Land_Basket_F") then {
			_item setVariable["mf_item_id", "cannedfood", true];
		};
		if(_class == "Land_CanisterPlastic_F") then {
			_item setVariable["mf_item_id", "water", true];
		};
		if(_class == "Land_Suitcase_F") then {
			_item setVariable["mf_item_id", "repairkit", true];
		};
		_item setPos _position;
    };

//-------------------------------------------------------------------------------------
	
spawnlootintown = {
    _pos = _this;
    randomweapon_buildings = nearestObjects [_pos, _buildCIV, _dospawnradius];
    sleep 10;
	{
		_building = _x;
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
						if(_woi < _odditem) then {
							_posnew call randomweaponspawnitem;
						} else {
							_woi2 = floor(random(100));
							if(_woi2 < _oddweapitem) then {
								_posnew call randomweaponspawnweaponitem;
							} else {
								_woi3 = floor(random(100));
								if(_woi3 < _oddcustom) then {
									_posnew call randomweaponspawncustom;
								} else {
									_posnew call randomweaponspawnweapon;
								};
							};
						};
					};
				};
			};    
		};
    }foreach randomweapon_buildings;
	randomweapon_milbuildings = nearestObjects [_pos, _buildMIL, _dospawnradius];
	sleep 10;
	{
		_building = _x;
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
						_posnew call randomweaponspawnmilweapon;
					};
				};
			};    
		};
    }foreach randomweapon_milbuildings;
};

//-------------------------------------------------------------------------------------

	townarea_list = [];
	_posPlayer = [];
	_posTown = [];
	_tradius = 0;
	_lastSpawned = 0;
	{
		_pos = getMarkerPos (_x select 0);
		_tradius = (_x select 1);
		townarea_list set [count townarea_list, [_pos, _lastSpawned]];
	}forEach (call citylist);
	{
		_pos = getMarkerPos (_x select 0);
		_tradius = 200;
		townarea_list set [count townarea_list, [_pos, _lastSpawned]];
	}forEach (call militarylist);
	while {true} do {
		{
			if ((isPlayer _x) && (alive _x) && (vehicle _x == _x)) then {
				_posPlayer = getPos _x;
				usedtown_list = [];
				{
					_posTown = (_x select 0);
					_lastSpawned = (_x select 1);
					_dospawnradius = (_tradius + _spawnradius);
					if (((_posTown distance _posPlayer) < _dospawnradius) && ((_interval < (time - _lastSpawned)) || (_lastSpawned == 0))) then {
						_posTown call spawnlootintown;
						usedtown_list set [count usedtown_list, [_forEachIndex, time]];
					};
				}forEach townarea_list;
				{
					(townarea_list select (_x select 0)) set [1,(_x select 1)];
				}forEach usedtown_list;
			};		
		}forEach playableUnits;
		sleep 10;
	};
