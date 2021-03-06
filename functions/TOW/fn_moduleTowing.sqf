private ["_logic", "_units", "_activated", "_debug"];

// Argument 0 is module logic
//_logic = [_this,0,objNull,[objNull]] call BIS_fnc_param;
// Argument 1 is list of affected units (affected by value selected in the 'class Units' argument))
_units = [_this,0,[],[[]]] call BIS_fnc_param;
// True when the module was activated, false when it's deactivated (i.e., synced triggers are no longer active)
_activated = [_this,2,true,[true]] call BIS_fnc_param;

_debug = true;//_logic getVariable "Debug";
_debug call BIS_fnc_log;

// Module specific behavior. Function can extract arguments from logic and use them.
if (_activated) then {
  "Towing activated" call BIS_fnc_log;
  // setting some globals
  dll_tow_debug = _debug;
  call DLL_fnc_config;
  {
    if (!(isNull _x)) then {
      _v = vehicle _x;
      if (_v != _x) then {
        [_v] call DLL_fnc_syncTowing;
      } else {
        [_x] call DLL_fnc_syncTowing;
      };
    };
  } forEach _units;
};

// Module function is executed by spawn command, so returned value is not necessary.
// However, it's a good practice to include one.
true;
