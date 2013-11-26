//	@file Version: 1.0
//	@file Name: spawnAction.sqf
//	@file Author: [404] Deadbeat, [KoS] Bewilderbeest
//	@file Created: 20/11/2012 05:19
//	@file Args: [int(type of spawn)]

disableSerialization;

	_buttonText = _this select 0;
	_switch = _this select 1;

	player allowDamage true;

	player setVariable["cmoney",0,true];


	[MF_ITEMS_CANNED_FOOD, 1] call mf_inventory_add;
	[MF_ITEMS_WATER, 1] call mf_inventory_add;
	[MF_ITEMS_REPAIR_KIT, 1] call mf_inventory_add;

	// Remove unrealistic blur effects
	ppEffectDestroy BIS_fnc_feedback_fatigueBlur;
	ppEffectDestroy BIS_fnc_feedback_damageBlur; 

	_scriptHandle = [] execVM "client\functions\spawnRandom.sqf";
	waitUntil {scriptDone _scriptHandle};


	if(isNil{client_firstSpawn}) then {
		client_firstSpawn = true;
		//[] execVM "client\functions\welcomeMessage.sqf";
		
		player addEventHandler ["Take",
		{
			private "_vehicle";
			_vehicle = _this select 1;
			
			if (_vehicle isKindOf "Car" && {!(_vehicle getVariable ["itemTakenFromVehicle", false])}) then
			{
				_vehicle setVariable ["itemTakenFromVehicle", true, true];
			};
		}];
		
		true spawn {      
			_startTime = floor(time);
			_result = 0;
			waitUntil
			{ 
				_currTime = floor(time);
				if(_currTime - _startTime >= 180) then 
				{
					_result = 1;    
				};
				(_result == 1)
			};
		};
	};
};
