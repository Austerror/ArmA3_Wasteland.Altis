while {true} do {

	_chance = 90;
	_rndNum = (random 100);
	if (_rndNum < _chance) then {
		//_x globalchat "Caution!";
		nul = [250,1000,10,30,6,[0,1,.5],player,[0.2,0.3,0.1,0.55,0.25,1,1,0.25,1,1],1,2000,nil,["AWARE","SAD"],true] execVM "LV\ambientCombat.sqf";
	};		

	sleep 180;
};