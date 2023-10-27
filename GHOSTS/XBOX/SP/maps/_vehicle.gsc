/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_vehicle.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 92
 * Decompile Time: 1532 ms
 * Timestamp: 10/27/2023 1:37:58 AM
*******************************************************************/

//Function Number: 1
init_vehicles()
{
	if(isdefined(level.disablevehiclescripts) && level.disablevehiclescripts)
	{
		return;
	}

	maps\_vehicle_code::func_7182();
	level.var_4149 = common_scripts\utility::array_combine(level.var_4149,maps\_utility::func_3C1B("helicopter_crash_location","targetname"));
	maps\_vehicle_code::func_71DF();
	common_scripts\utility::func_F1B(getentarray("truckjunk","targetname"),::maps\_vehicle_code::func_83E0);
	common_scripts\utility::func_F1B(getentarray("truckjunk","script_noteworthy"),::maps\_vehicle_code::func_83E0);
	common_scripts\utility::func_F1B(common_scripts\utility::func_3C1A("truckjunk","targetname"),::maps\_vehicle_code::func_83E0);
	common_scripts\utility::func_F1B(common_scripts\utility::func_3C1A("truckjunk","script_noteworthy"),::maps\_vehicle_code::func_83E0);
	maps\_vehicle_code::setup_ai();
	maps\_vehicle_code::func_71D8();
	var_00 = maps\_vehicle_code::precache_scripts();
	maps\_vehicle_code::func_71E0(var_00);
	if(isdefined(level.var_59CE))
	{
		common_scripts\utility::array_levelthread(level.var_890D,::func_8389);
	}
	else
	{
		common_scripts\utility::array_levelthread(level.var_890D,::maps\_vehicle_code::func_8387);
	}

	level.var_890D = undefined;
	level.levelhasvehicles = getentarray("script_vehicle","code_classname").size > 0;
	maps\_utility::add_hint_string("invulerable_frags",&"SCRIPT_INVULERABLE_FRAGS",undefined);
	maps\_utility::add_hint_string("invulerable_bullets",&"SCRIPT_INVULERABLE_BULLETS",undefined);
	common_scripts\utility::create_lock("aircraft_wash_math");
}

//Function Number: 2
func_8389(param_00)
{
	param_00.var_59CD = 1;
}

//Function Number: 3
func_8902(param_00,param_01,param_02)
{
	return maps\_vehicle_code::_vehicle_paths(param_00,param_01,param_02);
}

//Function Number: 4
func_20BC(param_00)
{
	var_01 = func_6D12(param_00);
	foreach(var_03 in var_01)
	{
		level thread gopath(var_03);
	}

	return var_01;
}

//Function Number: 5
gopath(param_00)
{
	return maps\_vehicle_code::_gopath(param_00);
}

//Function Number: 6
func_6D12(param_00)
{
	var_01 = maps\_vehicle_code::_getvehiclespawnerarray_by_spawngroup(param_00);
	var_02 = [];
	foreach(var_04 in var_01)
	{
		var_02[var_02.size] = func_8927(var_04);
	}

	return var_02;
}

//Function Number: 7
func_8927(param_00)
{
	return maps\_vehicle_code::_vehicle_spawn(param_00);
}

//Function Number: 8
kill_fx(param_00,param_01)
{
	return maps\_vehicle_code::_kill_fx(param_00,param_01);
}

//Function Number: 9
build_radiusdamage(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(!isdefined(level.var_88A7))
	{
		level.var_88A7 = [];
	}

	if(!isdefined(param_04))
	{
		param_04 = 0;
	}

	if(!isdefined(param_00))
	{
		param_00 = (0,0,0);
	}

	var_06 = addstruct();
	var_06.offset = param_00;
	var_06.var_6345 = param_01;
	var_06.maxdamage = param_02;
	var_06.mindamage = param_03;
	var_06.bkillplayer = param_04;
	var_06.delay = param_05;
	level.var_88A7[level.var_8A54] = var_06;
}

//Function Number: 10
func_1842(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(!isdefined(level.var_8917))
	{
		level.var_8917 = [];
	}

	var_06 = build_quake(param_01,param_02,param_03,param_04,param_05);
	precacherumble(param_00);
	var_06.rumble = param_00;
	level.var_8917[level.var_8A54] = var_06;
}

//Function Number: 11
func_1843(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	if(!isdefined(level.vehicle_rumble_override))
	{
		level.vehicle_rumble_override = [];
	}

	var_07 = build_quake(param_02,param_03,param_04,param_05,param_06);
	precacherumble(param_01);
	var_07.rumble = param_01;
	level.vehicle_rumble_override[param_00] = var_07;
}

//Function Number: 12
build_rumble_unique(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = build_quake(param_01,param_02,param_03,param_04,param_05);
	var_06.rumble = param_00;
	self.var_891A = var_06;
	func_88E3();
	thread maps\_vehicle_code::func_8917();
}

//Function Number: 13
func_1825(param_00,param_01,param_02)
{
	var_03 = level.var_8A54;
	if(!isdefined(level.var_88A3))
	{
		level.var_88A3 = [];
	}

	level.var_88A3[var_03] = build_quake(param_00,param_01,param_02);
}

//Function Number: 14
build_quake(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = addstruct();
	var_05.scale = param_00;
	var_05.duration = param_01;
	var_05.radius = param_02;
	if(isdefined(param_03))
	{
		var_05.basetime = param_03;
	}

	if(isdefined(param_04))
	{
		var_05.randomaditionaltime = param_04;
	}

	return var_05;
}

//Function Number: 15
build_fx(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A)
{
	if(!isdefined(param_05))
	{
		param_05 = 0;
	}

	if(!isdefined(param_03))
	{
		param_03 = 0;
	}

	if(!isdefined(param_04))
	{
		param_04 = 1;
	}

	var_0B = addstruct();
	var_0B.effect = loadfx(param_00);
	var_0B.tag = param_01;
	var_0B.sound = param_02;
	var_0B.bsoundlooping = param_05;
	var_0B.delay = param_04;
	var_0B.var_8AD2 = param_06;
	var_0B.var_7B2F = param_07;
	var_0B.notifystring = param_08;
	var_0B.var_13B2 = param_03;
	var_0B.var_6D8A = param_09;
	var_0B.var_651B = param_0A;
	return var_0B;
}

//Function Number: 16
build_deathfx_override(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B,param_0C)
{
	if(!isdefined(level.script))
	{
		level.script = tolower(getdvar("mapname"));
	}

	level.vttype = param_01;
	level.var_8A55 = param_02;
	level.var_8A56 = 1;
	level.var_8A54 = param_00;
	if(!isdefined(level.var_88A4))
	{
		level.var_88A4 = [];
	}

	if(!is_overrode(param_00))
	{
		level.var_88A4[param_00] = [];
	}

	level.var_88A5[param_00] = 1;
	if(!isdefined(level.var_88A4[param_00]))
	{
		level.var_88A4[param_00] = [];
	}

	level.var_88A4[param_00][level.var_88A4[param_00].size] = build_fx(param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B,param_0C);
	level.var_8A56 = undefined;
}

//Function Number: 17
build_deathfx(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A)
{
	var_0B = level.var_8A54;
	if(is_overrode(var_0B))
	{
	}

	if(!isdefined(level.var_88A4[var_0B]))
	{
		level.var_88A4[var_0B] = [];
	}

	level.var_88A4[var_0B][level.var_88A4[var_0B].size] = build_fx(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A);
}

//Function Number: 18
build_deathanim(param_00)
{
	var_01 = level.var_8A54;
	if(!isdefined(level.vehicle_death_anim[var_01]))
	{
		level.vehicle_death_anim[var_01] = [];
	}

	level.vehicle_death_anim[var_01] = param_00;
}

//Function Number: 19
is_overrode(param_00)
{
	if(!isdefined(level.var_88A5))
	{
		return 0;
	}

	if(!isdefined(level.var_88A5[param_00]))
	{
		return 0;
	}

	if(isdefined(level.var_8A56))
	{
		return 1;
	}

	return level.var_88A5[param_00];
}

//Function Number: 20
build_rocket_deathfx(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A)
{
	var_0B = level.var_8A54;
	level.var_8A54 = "rocket_death" + var_0B;
	build_deathfx(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A);
	level.var_8A54 = var_0B;
}

//Function Number: 21
func_34B4()
{
	return maps\_vehicle_code::_force_kill();
}

//Function Number: 22
godon()
{
	self.godmode = 1;
}

//Function Number: 23
godoff()
{
	self.godmode = 0;
}

//Function Number: 24
func_5208()
{
	return maps\_vehicle_code::_mgoff();
}

//Function Number: 25
mgon()
{
	return maps\_vehicle_code::func_6C4();
}

//Function Number: 26
isvehicle()
{
	return isdefined(self.vehicletype);
}

//Function Number: 27
build_turret(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	if(!isdefined(level.var_88FD))
	{
		level.var_88FD = [];
	}

	var_09 = level.var_8A54;
	if(!isdefined(level.var_88FD[var_09]))
	{
		level.var_88FD[var_09] = [];
	}

	precachemodel(param_02);
	precacheturret(param_00);
	var_0A = addstruct();
	var_0A.var_44D2 = param_00;
	var_0A.tag = param_01;
	var_0A.model = param_02;
	var_0A.maxrange = param_03;
	var_0A.defaultonmode = param_04;
	var_0A.var_2586 = param_05;
	var_0A.defaultdroppitch = param_06;
	var_0A.defaultdropyaw = param_07;
	if(isdefined(param_08))
	{
		var_0A.var_586A = param_08;
	}

	level.var_88FD[var_09][level.var_88FD[var_09].size] = var_0A;
}

//Function Number: 28
func_88DE()
{
	return maps\_vehicle_code::_vehicle_is_crashing();
}

//Function Number: 29
is_godmode()
{
	return maps\_vehicle_code::func_6B6();
}

//Function Number: 30
func_88E3()
{
	self notify("kill_rumble_forever");
}

//Function Number: 31
func_5469(param_00)
{
	if(!isdefined(self.var_83E0))
	{
	}

	foreach(var_02 in self.var_83E0)
	{
		if(var_02 == param_00)
		{
			continue;
		}

		var_02 unlink();
		if(isdefined(var_02.script_ghettotag))
		{
			var_02 linkto(param_00,var_02.script_ghettotag,var_02.base_origin,var_02.var_12C8);
			continue;
		}

		var_02 linkto(param_00);
	}
}

//Function Number: 32
dummy_to_vehicle()
{
	if(ishelicopter())
	{
		self.modeldummy.origin = self gettagorigin("tag_ground");
	}
	else
	{
		self.modeldummy.origin = self.origin;
		self.modeldummy.angles = self.angles;
	}

	self show();
	func_544C(self);
	maps\_vehicle_code::func_546A(self);
	thread maps\_vehicle_code::func_5444(self);
	maps\_vehicle_code::func_543E(self);
	self.modeldummyon = 0;
	self.modeldummy delete();
	self.modeldummy = undefined;
	if(maps\_vehicle_code::hashelicopterdustkickup())
	{
		self notify("stop_kicking_up_dust");
		thread maps\_vehicle_code::func_A84();
	}

	return self.modeldummy;
}

//Function Number: 33
func_544C(param_00)
{
	if(!isdefined(self.var_66A8))
	{
	}

	var_01 = self.var_66A8;
	foreach(var_03 in var_01)
	{
		if(!isdefined(var_03))
		{
			continue;
		}

		var_04 = maps\_vehicle_aianim::func_D88(self,var_03.var_890C);
		if(isdefined(var_04.var_5B14))
		{
			continue;
		}

		var_03 unlink();
		var_03 linkto(param_00,var_04.var_7573,(0,0,0),(0,0,0));
		if(isai(var_03))
		{
			var_03 method_81FA(param_00 gettagorigin(var_04.var_7573));
			continue;
		}

		var_03.origin = param_00 gettagorigin(var_04.var_7573);
	}
}

//Function Number: 34
spawn_vehicles_from_targetname(param_00)
{
	var_01 = [];
	var_01 = maps\_vehicle_code::func_7852(param_00);
	return var_01;
}

//Function Number: 35
func_784E(param_00)
{
	var_01 = spawn_vehicles_from_targetname(param_00);
	return var_01[0];
}

//Function Number: 36
func_784F(param_00)
{
	var_01 = spawn_vehicles_from_targetname(param_00);
	thread gopath(var_01[0]);
	return var_01[0];
}

//Function Number: 37
func_7851(param_00)
{
	var_01 = spawn_vehicles_from_targetname(param_00);
	foreach(var_03 in var_01)
	{
		thread gopath(var_03);
	}

	return var_01;
}

//Function Number: 38
aircraft_wash(param_00)
{
	thread maps\_vehicle_code::func_A84(param_00);
}

//Function Number: 39
func_894A()
{
	maps\_vehicle_code::func_8DE3(1);
}

//Function Number: 40
func_8949()
{
	maps\_vehicle_code::func_8DE3(0);
}

//Function Number: 41
func_1836(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(!isdefined(level.vehicle_lights))
	{
		level.vehicle_lights = [];
	}

	if(!isdefined(level.var_88F1))
	{
		level.var_88F1 = [];
	}

	if(isdefined(level.var_88F1[param_04]) && !level.var_8A56)
	{
	}

	var_06 = addstruct();
	var_06.name = param_01;
	var_06.tag = param_02;
	var_06.delay = param_05;
	var_06.effect = loadfx(param_03);
	level.vehicle_lights[param_00][param_01] = var_06;
	maps\_vehicle_code::func_3DD8(param_00,param_01,"all");
	if(isdefined(param_04))
	{
		maps\_vehicle_code::func_3DD8(param_00,param_01,param_04);
	}
}

//Function Number: 42
build_light_override(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(!isdefined(level.script))
	{
		level.script = tolower(getdvar("mapname"));
	}

	level.var_8A54 = param_00;
	func_1836(param_00,param_01,param_02,param_03,param_04,param_05);
	level.var_8A56 = 0;
	level.var_88F1[param_04] = 1;
}

//Function Number: 43
build_hideparts(param_00,param_01)
{
	if(!isdefined(level.var_88D7))
	{
		level.var_88D7 = [];
	}

	level.var_88D7[param_00] = param_01;
}

//Function Number: 44
build_deathmodel(param_00,param_01,param_02,param_03)
{
	if(param_00 != level.var_8A55)
	{
	}

	if(!isdefined(param_01))
	{
		param_01 = param_00;
	}

	precachemodel(param_00);
	precachemodel(param_01);
	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	if(!isdefined(param_03))
	{
		level.var_88AA[param_00] = param_01;
		level.vehicle_deathmodel_delay[param_00] = param_02;
	}

	level.var_88AA[param_03] = param_01;
	level.vehicle_deathmodel_delay[param_03] = param_02;
}

//Function Number: 45
build_shoot_shock(param_00)
{
	precachematerial("black");
	precacheshellshock(param_00);
	level.var_8921[level.var_8A54] = param_00;
}

//Function Number: 46
func_1832(param_00)
{
	if(!isdefined(level.var_88DB))
	{
		level.var_88DB = [];
	}

	if(!isdefined(level.var_88DB[level.var_8A55]))
	{
		level.var_88DB[level.var_8A55] = [];
	}

	level.var_88DB[level.var_8A55][level.var_88DB[level.var_8A55].size] = param_00;
}

//Function Number: 47
func_1828(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_02))
	{
		param_02 = 10;
	}

	level.var_88B4[level.var_8A55] = param_00;
	if(isdefined(param_01))
	{
		level.var_88B7[level.var_8A55] = param_01;
	}

	level.var_88B6[level.var_8A55] = param_02;
	if(isdefined(param_03))
	{
		level.var_88B5[level.var_8A55] = param_03;
	}
}

//Function Number: 48
build_template(param_00,param_01,param_02,param_03)
{
	if(!isdefined(level.script))
	{
		level.script = tolower(getdvar("mapname"));
	}

	if(isdefined(param_02))
	{
		param_00 = param_02;
	}

	precache(param_00);
	if(!isdefined(level.var_88A4))
	{
		level.var_88A4 = [];
	}

	if(!isdefined(level.vehicle_death_anim))
	{
		level.vehicle_death_anim = [];
	}

	if(!isdefined(level.var_88A4[param_03]))
	{
		level.var_88A4[param_03] = [];
	}

	level.var_8937[param_03] = "axis";
	level.var_88EA[param_03] = 999;
	level.var_88D5[param_01] = 0;
	level.vehicle_mainturrets[param_01] = [];
	level.var_8A55 = param_01;
	level.vttype = param_00;
	level.var_8A54 = param_03;
}

//Function Number: 49
build_exhaust(param_00)
{
	level.var_88BA[level.var_8A55] = loadfx(param_00);
}

//Function Number: 50
build_treadfx(param_00,param_01,param_02,param_03)
{
	if(isdefined(param_00))
	{
		func_6FBC(param_00,param_01,param_02);
		if(isdefined(param_03) && param_03)
		{
			func_6FBC(param_00,param_01,param_02,"_bank");
			func_6FBC(param_00,param_01,param_02,"_bank_lg");
		}
	}

	param_00 = level.var_8A54;
	maps\_treadfx::func_4FDD(param_00);
}

//Function Number: 51
build_all_treadfx(param_00,param_01)
{
	var_02 = get_surface_types();
	foreach(var_04 in var_02)
	{
		func_6FBC(param_00,var_04);
	}
}

//Function Number: 52
func_6FBC(param_00,param_01,param_02,param_03)
{
	if(!isdefined(level._vehicle_effect))
	{
		level._vehicle_effect = [];
	}

	if(isdefined(param_03))
	{
		param_01 = param_01 + param_03;
		param_02 = param_02 + param_03;
	}

	if(isdefined(param_02))
	{
		level._vehicle_effect[param_00][param_01] = loadfx(param_02);
	}

	if(isdefined(level._vehicle_effect[param_00]) && isdefined(level._vehicle_effect[param_00][param_01]))
	{
		level._vehicle_effect[param_00][param_01] = undefined;
	}
}

//Function Number: 53
get_surface_types()
{
	var_00 = [];
	var_00[var_00.size] = "brick";
	var_00[var_00.size] = "bark";
	var_00[var_00.size] = "carpet";
	var_00[var_00.size] = "cloth";
	var_00[var_00.size] = "concrete";
	var_00[var_00.size] = "dirt";
	var_00[var_00.size] = "flesh";
	var_00[var_00.size] = "foliage";
	var_00[var_00.size] = "glass";
	var_00[var_00.size] = "grass";
	var_00[var_00.size] = "gravel";
	var_00[var_00.size] = "ice";
	var_00[var_00.size] = "metal";
	var_00[var_00.size] = "mud";
	var_00[var_00.size] = "paper";
	var_00[var_00.size] = "plaster";
	var_00[var_00.size] = "rock";
	var_00[var_00.size] = "sand";
	var_00[var_00.size] = "snow";
	var_00[var_00.size] = "water";
	var_00[var_00.size] = "wood";
	var_00[var_00.size] = "asphalt";
	var_00[var_00.size] = "ceramic";
	var_00[var_00.size] = "plastic";
	var_00[var_00.size] = "rubber";
	var_00[var_00.size] = "cushion";
	var_00[var_00.size] = "fruit";
	var_00[var_00.size] = "paintedmetal";
	var_00[var_00.size] = "riotshield";
	var_00[var_00.size] = "slush";
	var_00[var_00.size] = "default";
	return var_00;
}

//Function Number: 54
func_1848(param_00)
{
	level.var_8937[level.var_8A54] = param_00;
}

//Function Number: 55
func_183A(param_00,param_01,param_02,param_03)
{
	level.var_88D5[level.var_8A55] = 1;
	if(isdefined(param_00))
	{
		level.vehicle_mainturrets[level.var_8A55][param_00] = 1;
	}

	if(isdefined(param_01))
	{
		level.vehicle_mainturrets[level.var_8A55][param_01] = 1;
	}

	if(isdefined(param_02))
	{
		level.vehicle_mainturrets[level.var_8A55][param_02] = 1;
	}

	if(isdefined(param_03))
	{
		level.vehicle_mainturrets[level.var_8A55][param_03] = 1;
	}
}

//Function Number: 56
build_bulletshield(param_00)
{
	level.var_8899[level.var_8A54] = param_00;
}

//Function Number: 57
build_grenadeshield(param_00)
{
	level.vehicle_grenadeshield[level.var_8A54] = param_00;
}

//Function Number: 58
build_aianims(param_00,param_01)
{
	var_02 = level.var_8A54;
	level.var_888A[var_02] = [[ param_00 ]]();
	if(isdefined(param_01))
	{
		level.var_888A[var_02] = [[ param_01 ]](level.var_888A[var_02]);
	}
}

//Function Number: 59
build_frontarmor(param_00)
{
	level.vehicle_frontarmor[level.var_8A54] = param_00;
}

//Function Number: 60
func_1819(param_00)
{
	level.var_8892[level.var_8A54] = [[ param_00 ]]();
}

//Function Number: 61
func_184E(param_00)
{
	level.vehicle_unloadgroups[level.var_8A54] = [[ param_00 ]]();
}

//Function Number: 62
build_life(param_00,param_01,param_02)
{
	var_03 = level.var_8A54;
	level.var_88EA[var_03] = param_00;
	level.var_88EC[var_03] = param_01;
	level.var_88EB[var_03] = param_02;
}

//Function Number: 63
func_1826(param_00)
{
	level.var_88AD[level.var_8A55] = loadfx(param_00);
}

//Function Number: 64
func_1827(param_00,param_01)
{
	if(isdefined(level.var_889E))
	{
	}

	if(param_00 != level.var_8A55)
	{
	}

	var_02 = addstruct();
	var_02.model = param_00;
	var_02 maps\_utility::func_6104(param_01);
	level.var_2687[level.var_8A55] = param_01;
}

//Function Number: 65
func_1838(param_00)
{
	level.var_8954[level.vttype][level.var_8A54] = param_00;
}

//Function Number: 66
func_47E3()
{
	return self.modeldummyon;
}

//Function Number: 67
func_88F7(param_00,param_01,param_02)
{
	maps\_vehicle_aianim::func_4E80(param_00,undefined,param_02);
}

//Function Number: 68
func_88F8(param_00,param_01,param_02)
{
	var_03 = [];
	var_03[0] = param_00;
	maps\_vehicle_aianim::func_4E80(var_03,param_01,param_02);
}

//Function Number: 69
build_death_badplace(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(!isdefined(level.var_88A1))
	{
		level.var_88A1 = [];
	}

	var_06 = addstruct();
	var_06.delay = param_00;
	var_06.duration = param_01;
	var_06.height = param_02;
	var_06.radius = param_03;
	var_06.team1 = param_04;
	var_06.var_7F79 = param_05;
	level.var_88A1[level.var_8A54] = var_06;
}

//Function Number: 70
func_540C(param_00,param_01)
{
	return maps\_vehicle_code::_mount_snowmobile(param_00,param_01);
}

//Function Number: 71
func_784D()
{
	var_00 = maps\_utility::func_784B();
	if(isdefined(self.var_6CB4))
	{
		if(!ishelicopter())
		{
			var_00 setspeed(self.var_6CB4);
		}
	}

	var_00 thread gopath(var_00);
	return var_00;
}

//Function Number: 72
func_88C6(param_00)
{
	var_01 = [];
	var_02 = self.classname;
	if(!isdefined(level.vehicle_unloadgroups[var_02]))
	{
		return var_01;
	}

	var_03 = level.vehicle_unloadgroups[var_02];
	if(!isdefined(param_00))
	{
		return var_01;
	}

	foreach(var_05 in self.var_66A8)
	{
		foreach(var_07 in var_03[param_00])
		{
			if(var_05.var_890C == var_07)
			{
				var_01[var_01.size] = var_05;
			}
		}
	}

	return var_01;
}

//Function Number: 73
func_887F(param_00)
{
	return maps\_vehicle_aianim::animate_guys(param_00);
}

//Function Number: 74
func_8942(param_00)
{
	return maps\_vehicle_code::_vehicle_unload(param_00);
}

//Function Number: 75
func_8940()
{
	self endon("death");
	self endon("stop_scanning_turret");
	var_00 = randomint(2);
	while(isdefined(self))
	{
		if(common_scripts\utility::func_1DE9())
		{
			maps\_vehicle_code::func_888C(0);
			wait(randomfloatrange(2,10));
		}

		if(var_00 == 0)
		{
			var_01 = randomintrange(10,30);
			var_00 = 1;
		}
		else
		{
			var_01 = randomintrange(-30,-10);
			var_00 = 0;
		}

		maps\_vehicle_code::func_888C(var_01);
		wait(randomfloatrange(2,10));
	}
}

//Function Number: 76
func_893F()
{
	self notify("stop_scanning_turret");
}

//Function Number: 77
func_88C4()
{
	self endon("death");
	var_00 = [];
	var_01 = self.attachedpath;
	if(!isdefined(self.attachedpath))
	{
		return var_00;
	}

	var_02 = var_01;
	var_02.counted = 0;
	while(isdefined(var_02))
	{
		if(isdefined(var_02.counted) && var_02.counted == 1)
		{
			break;
		}

		var_00 = common_scripts\utility::array_add(var_00,var_02);
		var_02.counted = 1;
		if(!isdefined(var_02.target))
		{
			break;
		}

		if(!ishelicopter())
		{
			var_02 = getnode(var_02.target,"targetname");
			continue;
		}

		var_02 = maps\_utility::getent_or_struct(var_02.target,"targetname");
	}

	return var_00;
}

//Function Number: 78
func_88F3(param_00,param_01)
{
	if(!isdefined(param_00))
	{
		param_00 = "all";
	}

	maps\_vehicle_code::lights_on(param_00,param_01);
}

//Function Number: 79
vehicle_lights_off(param_00,param_01)
{
	maps\_vehicle_code::lights_off(param_00,param_01);
}

//Function Number: 80
func_8936(param_00,param_01)
{
	self setswitchnode(param_00,param_01);
	self.attachedpath = param_01;
	thread func_8902();
}

//Function Number: 81
func_8935(param_00,param_01,param_02)
{
	return maps\_vehicle_code::_vehicle_stop_named(param_00,param_01,param_02);
}

//Function Number: 82
vehicle_resume_named(param_00)
{
	return maps\_vehicle_code::_vehicle_resume_named(param_00);
}

//Function Number: 83
build_is_helicopter(param_00)
{
	if(!isdefined(level.var_4152))
	{
		level.var_4152 = [];
	}

	if(!isdefined(param_00))
	{
		param_00 = level.vttype;
	}

	level.var_4152[param_00] = 1;
}

//Function Number: 84
build_is_airplane(param_00)
{
	if(!isdefined(level.airplane_list))
	{
		level.airplane_list = [];
	}

	if(!isdefined(param_00))
	{
		param_00 = level.vttype;
	}

	level.airplane_list[param_00] = 1;
}

//Function Number: 85
build_single_tread(param_00)
{
	if(!isdefined(level.var_8926))
	{
		level.var_8926 = [];
	}

	if(!isdefined(param_00))
	{
		param_00 = level.vttype;
	}

	level.var_8926[param_00] = 1;
}

//Function Number: 86
build_rider_death_func(param_00)
{
	if(!isdefined(level.var_8915))
	{
		level.var_8915 = [];
	}

	level.var_8915[level.var_8A54] = param_00;
}

//Function Number: 87
ishelicopter()
{
	return maps\_vehicle_code::_ishelicopter();
}

//Function Number: 88
isairplane()
{
	return maps\_vehicle_code::func_6B7();
}

//Function Number: 89
func_3863()
{
	return maps\_vehicle_code::_get_dummy();
}

//Function Number: 90
func_8938()
{
	self.modeldummy = spawn("script_model",self.origin);
	self.modeldummy setmodel(self.model);
	self.modeldummy.origin = self.origin;
	self.modeldummy.angles = self.angles;
	self.modeldummy method_826D(#animtree);
	self hide();
	thread lib_2C53::func_E04();
	func_544C(self.modeldummy);
	lib_2C54::sam_reload_missile(self.modeldummy);
	func_5469(self.modeldummy);
	thread lib_2C54::func_4404(self.modeldummy);
	lib_2C54::func_3E04(self.modeldummy);
	lib_2C1F::func_3A04(self.modeldummy);
	self.modeldummyon = 1;
	if(lib_2C40::apache_hints_factory())
	{
		self notify("top_kicking_up_dust");
		thread maps\_vehicle_code::func_A84(self.modeldummy);
	}

	return self.modeldummy;
}

//Function Number: 91
build_death_jolt_delay(param_00)
{
	if(!isdefined(level.vehicle_death_jolt))
	{
		level.vehicle_death_jolt = [];
	}

	var_01 = addstruct();
	var_01.delay = param_00;
	level.vehicle_death_jolt[level.var_8A54] = var_01;
}

//Function Number: 92
enable_global_vehicle_spawn_functions()
{
	level.var_8928 = 1;
}