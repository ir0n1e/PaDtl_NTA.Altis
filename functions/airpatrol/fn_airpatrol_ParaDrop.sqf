_this spawn {
	_veh 		= _this select 0;
	_infgrp 	= _this select 1;
	_users 		= _this select 2;
	_targetPos 	= _this select 3;
	_survivors 	= [_this, 4, count (units _infgrp)] call bis_fnc_param;
	_height		= _this select 5;
	_door 		= "door_rear_source";

	waituntil {alive _veh && {speed _veh > 50}};



	waituntil {!alive _veh || {((_veh distance [_targetPos select 0, _targetPos select 1, _height]) / (speed _veh) * 3.6) <= 60}};
	[_veh] call IL_fnc_switchOn;
	//playsound "ap_makeReady";
	{
		["ap_getReady","playsound", _x] call BIS_fnc_MP;
	} foreach _users;

	_veh setvariable ["airpatrol_mission", "ParaDrop", true];

	waituntil {sleep 10; !alive _veh || {((_veh distance [_targetPos select 0, _targetPos select 1, _height]) / (speed _veh) * 3.6) <= 30}};

	if (typeof _veh iskindof "c130J_base" ||  {typeof _veh iskindof "sab_C130_J_Base"}) then {
		_veh animate ["door_2_1", 1];
	} else {
		_veh animatedoor ["door_rear_source", 1];
	};

	waituntil {!alive _veh || {((_veh distance [_targetPos select 0, _targetPos select 1, _height]) / (speed _veh) * 3.6) <= 5}};
	[_veh] call IL_fnc_switchGreen;
	{
		if (isplayer _x && {vehicle _x == _veh}) then {
			["ap_gogogo","playsound", _x] call BIS_fnc_MP;
		};
	} foreach _users;


	//_dir = (direction _veh) + 180;
	_count = 0;
	_max = (count (units _infgrp)) - (count _users);

	{
		[_x,_count, _survivors, _max, _veh] spawn {
			_u = _this select 0;
			_c = (_this select 1) -1;
			_s = _this select 2;
			_m = _this select 3;
			_veh = _this select 4;

			if (!isplayer _u) then {
				_u allowDamage false;
				moveOut _u;
				unassignVehicle _u;
			} else {
				_time = time;
				waituntil {vehicle _u != _veh || {time >= (_time + 90)} || {!alive _u}};
				if (!alive _u) exitwith {_u allowDamage true;};

				if (vehicle _u == _veh) then {
					moveOut _u;
					unassignVehicle _u;
				};
			};

			sleep 2;
			_u allowDamage true;
			/*
			_dir = (getdir _u) + 180;
			sleep 2;
			_chute = createVehicle ["O_Parachute_02_F", position _u, [], 0, 'NONE'];
			_chute setPos (getPos _u);
			_chute setDir ((_dir)-5+(random 10));
			_u setDir ( direction _chute );
			_chute setPos (getPos _u);
			(vehicle _u) setDir ((_dir)-5+(random 10));
			_chute attachTo [_u, [0, 0, 0]];
			detach _chute;


			[[_u, "Para_pilot"], "fnc_getout", _u] call bis_fnc_MP;
			_u attachTo [_chute, [0, 0, -1.8]];


			[[_u, "getoutpara"], "fnc_getout",_u] call bis_fnc_MP;
			detach _u;

			*/
			waitUntil {isTouchingGround _u || {!alive _u}};

			if (NTA_Airpatrol_removeItems) then {
				_item = (assignedItems _u) call nta_fnc_getrandarraypos;
				if (floor (random 3) == 1) then {
					_u unassignItem _item;
					_u removeItem _item;
				};
			};

			if (_c  < (_m - _s) && {!isplayer _u}) then {
				sleep 5;
				deletevehicle _u;
			};
		};

		if (!isplayer _x) then {
			_count = _count + 1;
		};

		sleep 0.8;

	} forEach _users + (units _infgrp);
	_veh setvariable ["airpatrol_mission", "MovingHome", true];
};
