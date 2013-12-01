//	@file Version: 1.0
//	@file Name: realTimeSync.sqf
//	@file Author: Caffeind [Austerror]
//	@file Created: 27/11/2013 16:04

_timeDiff = -5;  // Time difference between the hosts actual time and the intended in game time.

if (!isServer) exitWith {};

while {true} do
{
	_dateTime = "Arma2Net.Unmanaged" callExtension "DateTime ['now', 'HH:mm:ss dd MM yyyy']";
	_timeArray = toArray _dateTime;
	_hour = parseNumber format["%1%2",toString [_timeArray select 1], toString [_timeArray select 2]];
	_min = parseNumber format["%1%2",toString [_timeArray select 4], toString [_timeArray select 5]];
	_sec = parseNumber format["%1%2",toString [_timeArray select 7], toString [_timeArray select 8]];
	_day = parseNumber format["%1%2",toString [_timeArray select 10], toString [_timeArray select 11]];
	_month = parseNumber format["%1%2",toString [_timeArray select 13], toString [_timeArray select 14]];
	_year = parseNumber format["%1%2%3%4",toString [_timeArray select 16], toString [_timeArray select 17], toString [_timeArray select 18], toString [_timeArray select 19]];
	diag_log format ["setDate [%1,%2,%3,%4,%5]",_year,_month,_day,_hour,_min];
	setDate [_year,_month,_day,(_hour + _timeDiff),_min];
	sleep 600;
};