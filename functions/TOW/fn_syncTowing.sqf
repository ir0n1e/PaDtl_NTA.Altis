private ["_unit", "_dll_tow_i", "_dll_tow_class", "_back_axis_offset"];

_unit = _this select 0;

// TS: converted enabletowing from dll towing

//try to find the class or a base of it in the deflist
_dll_tow_i = -1;
_dll_tow_class = typeOf(_unit);
//go trough config backwards
while {(_dll_tow_i < 0) && (_dll_tow_class != "All")} do {
	_dll_tow_i = dll_tow_classlist find _dll_tow_class;
	if(dll_tow_debug) then {
		hintsilent format["type: %1", _dll_tow_class];
		format["type: %1", _dll_tow_class] call BIS_fnc_log;
	};
	_dll_tow_class = configname (inheritsFrom (configFile >> "CfgVehicles" >> _dll_tow_class));
};


if(_dll_tow_i > -1) then{
	_def = dll_tow_defs select _dll_tow_i;
	_unit setVariable ["dll_tow_front_axis_offset", _def select 1, true];
	_unit setVariable ["dll_tow_wheel_offset", _def select 2, true];
	_unit setVariable ["dll_tow_back_axis_offset", _def select 3, true];
	_unit setVariable ["static", _def select 4, true];
	_back_axis_offset = _unit getvariable "dll_tow_back_axis_offset";
	if(dll_tow_debug) then {
		hintsilent format["%1 initialized", typeof(_unit)];
		format["%1 initialized", typeof(_unit)] call BIS_fnc_log;
		sleep 0.2;
		//[_unit] spawn dll_tow_bbox;
	};
	if(!isNil ("_back_axis_offset") ) then{
		[_unit] call DLL_fnc_initT;
	};
}
