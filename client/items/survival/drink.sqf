//@file Version: 1.0
//@file Name: drink.sqf
//@file Author: MercyfulFate
//@file Created: 21/7/2013 16:00
//@file Description: Drink, and replenish your thrist
//@file Argument: The amount of thirst to replenish

#define ERR_CANCELLED "Drinking Cancelled";
#define ANIMATION "AinvPknlMstpSnonWnonDnon_healed_1"
private ["_checks", "_hasFailed"];
_hasFailed = {
	private ["_progress","_failed", "_text"];
	_progress = _this select 0;
	_text = "";
	_failed = true;
	switch (true) do {
		case not(alive player) : {}; // player is dead, not need for a error message
		case (doCancelAction): {doCancelAction = false; _text = ERR_CANCELLED;};
		default {
			_failed = false;
			_text = format["Drinking %1%2 Complete", round(100*_progress), "%"];
		};
	};
	[_failed, _text];
};
player setVariable["isDrinking", true, true];
_success = [5, ANIMATION, _hasFailed, []] call mf_util_playUntil;
if (_success) then {
	thirstLevel = (thirstLevel + _this) min 100;
	["Your thirst has eased", 5] call mf_notify_client;
};
player setVariable["isDrinking", false, true];
_success;