/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3835.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 87
 * Decompile Time: 32 ms
 * Timestamp: 10/27/2023 12:31:03 AM
*******************************************************************/

//Function Number: 1
func_FE05()
{
	if(!isdefined(level.var_FD6E))
	{
		level.var_FD6E = spawnstruct();
	}

	return level.var_FD6E;
}

//Function Number: 2
func_E3F7()
{
	if(!isdefined(level.var_E35D))
	{
		level.var_E35D = spawnstruct();
	}

	return level.var_E35D;
}

//Function Number: 3
func_118C1()
{
	if(!isdefined(level.var_118A8))
	{
		level.var_118A8 = spawnstruct();
	}

	return level.var_118A8;
}

//Function Number: 4
func_7D7A(param_00,param_01)
{
	if(!isdefined(level.var_877A))
	{
		var_02 = getallvehiclenodes();
		level.var_877A = [];
		foreach(var_04 in var_02)
		{
			if(isdefined(var_04.var_336))
			{
				level.var_877A = scripts\common\utility::array_add(level.var_877A,var_04.var_336);
			}
		}
	}

	if(function_02A5(param_00))
	{
		var_06 = scripts\common\utility::spawn_tag_origin();
		var_06.var_8779 = 1;
		var_06.origin = param_00;
		return var_06;
	}
	else if(isstring(param_01))
	{
		if(function_02A4(scripts\common\utility::getstruct(param_01,"targetname")))
		{
			return scripts\common\utility::getstruct(param_01,"targetname");
		}
		else if(function_02A6(getent(param_01,"targetname")))
		{
			return getent(param_01,"targetname");
		}
		else if(function_02A7(function_00B3(param_01,"targetname")))
		{
			return function_00B3(param_01,"targetname");
		}
		else if(getsubstr(param_01,0,2) == "**")
		{
			return getsubstr(param_01,2);
		}
		else if(isdefined(scripts\common\utility::func_2291(level.var_877A,param_01)))
		{
			return getvehiclenode(param_01,"targetname");
		}
		else if(isdefined(var_06) && var_06)
		{
			return undefined;
		}
		else
		{
			return;
		}
	}
	else
	{
		return param_01;
	}
}

//Function Number: 5
func_7CBB(param_00,param_01,param_02,param_03)
{
	var_04 = scripts\common\utility::getstructarray(param_00,param_01);
	foreach(var_06 in var_04)
	{
		if(isdefined(var_06.var_EE79))
		{
			if(var_06.var_EE79 == param_02)
			{
				return var_06;
			}
		}
	}
}

//Function Number: 6
func_798D(param_00,param_01,param_02)
{
	var_03 = getentarray(param_00,param_01);
	foreach(var_05 in var_03)
	{
		if(isdefined(var_05.script_noteworthy))
		{
			if(var_05.script_noteworthy == param_02)
			{
				return var_05;
			}
		}
	}
}

//Function Number: 7
func_798E(param_00,param_01,param_02)
{
	if(param_02 == "_ignore_last_sparam")
	{
		return getent(param_00,param_01);
	}

	var_03 = getentarray(param_00,param_01);
	foreach(var_05 in var_03)
	{
		if(isdefined(var_05.var_EE79))
		{
			if(var_05.var_EE79 == param_02)
			{
				return var_05;
			}
		}
	}
}

//Function Number: 8
func_7CBE(param_00,param_01,param_02)
{
	if(param_02 == "_ignore_last_sparam")
	{
		return scripts\common\utility::getstruct(param_00,param_01);
	}

	var_03 = scripts\common\utility::getstructarray(param_00,param_01);
	foreach(var_05 in var_03)
	{
		if(isdefined(var_05.var_EE79))
		{
			if(var_05.var_EE79 == param_02)
			{
				return var_05;
			}
		}
	}
}

//Function Number: 9
func_7CBC(param_00,param_01,param_02)
{
	var_03 = scripts\common\utility::getstructarray(param_00,param_01);
	foreach(var_05 in var_03)
	{
		if(isdefined(var_05.var_EE52))
		{
			if(var_05.var_EE52 == param_02)
			{
				return var_05;
			}
		}
	}
}

//Function Number: 10
func_798A(param_00,param_01,param_02)
{
	var_03 = getentarray(param_00,param_01);
	foreach(var_05 in var_03)
	{
		if(isdefined(var_05.var_EE52))
		{
			if(var_05.var_EE52 == param_02)
			{
				return var_05;
			}
		}
	}
}

//Function Number: 11
func_7CC0(param_00,param_01,param_02)
{
	var_03 = scripts\common\utility::getstructarray(param_00,param_01);
	foreach(var_05 in var_03)
	{
		if(isdefined(var_05.var_EE52))
		{
			if(var_05.var_EE52 != param_02)
			{
				var_03 = scripts\common\utility::func_22A9(var_03,var_05);
			}

			continue;
		}

		var_03 = scripts\common\utility::func_22A9(var_03,var_05);
	}

	return var_03;
}

//Function Number: 12
func_7991(param_00,param_01,param_02)
{
	var_03 = getentarray(param_00,param_01);
	foreach(var_05 in var_03)
	{
		if(isdefined(var_05.var_EE52))
		{
			if(var_05.var_EE52 != param_02)
			{
				var_03 = scripts\common\utility::func_22A9(var_03,var_05);
			}

			continue;
		}

		var_03 = scripts\common\utility::func_22A9(var_03,var_05);
	}

	return var_03;
}

//Function Number: 13
func_7992(param_00,param_01,param_02)
{
	if(param_01 == "script_parameters")
	{
		var_03 = getentarray();
		foreach(var_05 in var_03)
		{
			if(isdefined(var_05.var_EE79))
			{
				if(var_05.var_EE79 != param_00)
				{
					var_03 = scripts\common\utility::func_22A9(var_03,var_05);
				}

				continue;
			}

			var_03 = scripts\common\utility::func_22A9(var_03,var_05);
		}
	}
	else
	{
		var_03 = getentarray(param_01,param_02);
	}

	foreach(var_05 in var_03)
	{
		if(isdefined(var_05.script_noteworthy))
		{
			if(var_05.script_noteworthy != param_02)
			{
				var_03 = scripts\common\utility::func_22A9(var_03,var_05);
			}

			continue;
		}

		var_03 = scripts\common\utility::func_22A9(var_03,var_05);
	}

	return var_03;
}

//Function Number: 14
func_7994(param_00,param_01,param_02)
{
	if(param_02 == "_ignore_last_sparam")
	{
		return getentarray(param_00,param_01);
	}

	var_03 = getentarray(param_00,param_01);
	foreach(var_05 in var_03)
	{
		if(isdefined(var_05.var_EE79))
		{
			if(var_05.var_EE79 != param_02)
			{
				var_03 = scripts\common\utility::func_22A9(var_03,var_05);
			}

			continue;
		}

		var_03 = scripts\common\utility::func_22A9(var_03,var_05);
	}

	return var_03;
}

//Function Number: 15
func_7995(param_00,param_01,param_02)
{
	var_03 = getentarray(param_00,param_01);
	foreach(var_05 in var_03)
	{
		if(isdefined(var_05.var_280))
		{
			if(var_05.var_280 != param_02)
			{
				var_03 = scripts\common\utility::func_22A9(var_03,var_05);
			}

			continue;
		}

		var_03 = scripts\common\utility::func_22A9(var_03,var_05);
	}

	return var_03;
}

//Function Number: 16
func_7993(param_00,param_01,param_02)
{
	var_03 = getentarray(param_00,param_01);
	foreach(var_05 in var_03)
	{
		if(isdefined(var_05.var_EE79))
		{
			if(getsubstr(var_05.var_EE79,0,param_02.size) != param_02)
			{
				var_03 = scripts\common\utility::func_22A9(var_03,var_05);
			}

			continue;
		}

		var_03 = scripts\common\utility::func_22A9(var_03,var_05);
	}

	return var_03;
}

//Function Number: 17
func_799B(param_00,param_01)
{
	foreach(var_03 in param_00)
	{
		if(isdefined(var_03.script_noteworthy))
		{
			if(var_03.script_noteworthy != param_01)
			{
				param_00 = scripts\common\utility::func_22A9(param_00,var_03);
			}

			continue;
		}

		param_00 = scripts\common\utility::func_22A9(param_00,var_03);
	}

	return param_00;
}

//Function Number: 18
func_7990(param_00)
{
	var_01 = getentarray();
	foreach(var_03 in var_01)
	{
		if(isdefined(var_03.var_336))
		{
			if(getsubstr(var_03.var_336,0,param_00.size) != param_00)
			{
				var_01 = scripts\common\utility::func_22A9(var_01,var_03);
			}

			continue;
		}

		var_01 = scripts\common\utility::func_22A9(var_01,var_03);
	}

	return var_01;
}

//Function Number: 19
func_7CBF(param_00)
{
	var_01 = level.var_1115C["targetname"];
	var_02 = getarraykeys(level.var_1115C["targetname"]);
	foreach(var_04 in var_02)
	{
		if(getsubstr(var_04,0,param_00.size) != param_00)
		{
			var_01 = scripts\common\utility::func_22A9(var_01,var_01[var_04]);
		}
	}
}

//Function Number: 20
func_798C(param_00,param_01,param_02,param_03)
{
	var_04 = func_7991(param_00,param_01,param_02);
	foreach(var_06 in var_04)
	{
		if(isdefined(var_06.var_280) && var_06.var_280 == param_03)
		{
			return var_06;
		}
	}
}

//Function Number: 21
func_798B(param_00,param_01,param_02,param_03)
{
	if(param_03 == "_ignore_last_sparam")
	{
		return func_798A(param_00,param_01,param_02);
	}

	var_04 = func_7991(param_00,param_01,param_02);
	foreach(var_06 in var_04)
	{
		if(isdefined(var_06.var_EE79) && var_06.var_EE79 == param_03)
		{
			return var_06;
		}
	}
}

//Function Number: 22
func_7CBD(param_00,param_01,param_02,param_03)
{
	if(param_03 == "_ignore_last_sparam")
	{
		return func_7CBC(param_00,param_01,param_02);
	}

	var_04 = func_7CC0(param_00,param_01,param_02);
	foreach(var_06 in var_04)
	{
		if(isdefined(var_06.var_EE79) && var_06.var_EE79 == param_03)
		{
			return var_06;
		}
	}
}

//Function Number: 23
func_7CC1(param_00,param_01,param_02)
{
	if(param_02 == "_ignore_last_sparam")
	{
		return scripts\common\utility::getstructarray(param_00,param_01);
	}

	var_03 = scripts\common\utility::getstructarray(param_00,param_01);
	foreach(var_05 in var_03)
	{
		if(isdefined(var_05.var_EE79))
		{
			if(var_05.var_EE79 != param_02)
			{
				var_03 = scripts\common\utility::func_22A9(var_03,var_05);
			}

			continue;
		}

		var_03 = scripts\common\utility::func_22A9(var_03,var_05);
	}

	return var_03;
}

//Function Number: 24
func_7C34(param_00,param_01,param_02)
{
	var_03 = getscriptablearray(param_00,param_01);
	foreach(var_05 in var_03)
	{
		if(isdefined(var_05.var_EE52))
		{
			if(var_05.var_EE52 != param_02)
			{
				var_03 = scripts\common\utility::func_22A9(var_03,var_05);
			}

			continue;
		}

		var_03 = scripts\common\utility::func_22A9(var_03,var_05);
	}

	return var_03;
}

//Function Number: 25
func_FDE7(param_00)
{
	if(isdefined(param_00))
	{
		if(isai(param_00) || isdefined(param_00.var_9B89))
		{
			return;
		}

		if(isdefined(level.var_FD6E) && isdefined(level.var_FD6E.var_7316) && scripts\common\utility::func_2286(level.var_FD6E.var_7316,param_00))
		{
			param_00 func_7304();
		}
		else
		{
			if(isdefined(param_00.var_9A62))
			{
				scripts\common\utility::func_227D(param_00.var_9A62,::delete);
			}

			param_00 delete();
		}

		func_FE0C();
	}
}

//Function Number: 26
func_FDE8(param_00)
{
	if(!isdefined(param_00))
	{
		return;
	}

	foreach(var_02 in param_00)
	{
		func_FDE7(var_02);
	}
}

//Function Number: 27
func_7304()
{
	stopfxontag(scripts\common\utility::getfx("forklift_red_flash"),self,"tag_light_top_red");
	if(isdefined(self.var_5BC8))
	{
		self.var_5BC8 method_81D0();
		self.var_5BC8 delete();
	}

	self method_81D0();
	self delete();
}

//Function Number: 28
func_FE0C()
{
	if(!isdefined(level.var_FD6E))
	{
		return;
	}

	if(isdefined(level.var_FD6E.var_5EE3))
	{
		func_22B8(level.var_FD6E.var_5EE3);
	}

	if(isdefined(level.var_FD6E.var_A412))
	{
		func_22B8(level.var_FD6E.var_A412);
	}

	if(isdefined(level.var_FD6E.var_7316))
	{
		func_22B8(level.var_FD6E.var_7316);
	}

	if(isdefined(level.var_FD6E.var_11A55))
	{
		func_22B8(level.var_FD6E.var_11A55);
	}
}

//Function Number: 29
func_22B8(param_00)
{
	foreach(var_03, var_02 in param_00)
	{
		if(!isdefined(var_02))
		{
			param_00 = scripts\sp\_utility::func_22B2(param_00,var_03);
		}
	}
}

//Function Number: 30
func_EFDB(param_00)
{
	return level.var_FD6E.var_454F[param_00];
}

//Function Number: 31
func_FD9C(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = "all";
	}

	if(!isdefined(level.var_FD6E.var_1912[param_00]))
	{
		return [];
	}

	return level.var_FD6E.var_1912[param_00];
}

//Function Number: 32
func_FD72(param_00)
{
	param_00 endon("cleaned");
	param_00 waittill("death");
	level thread func_FD71();
}

//Function Number: 33
func_FD71()
{
	foreach(var_02, var_01 in level.var_FD6E.var_1912)
	{
		level.var_FD6E.var_1912[var_02] = scripts\common\utility::func_22BC(level.var_FD6E.var_1912[var_02]);
		level.var_FD6E.var_1912[var_02] = scripts\sp\_utility::func_22B9(level.var_FD6E.var_1912[var_02]);
	}
}

//Function Number: 34
func_FD6F(param_00)
{
	if(!isdefined(level.var_FD6E.var_1912[param_00]))
	{
		level.var_FD6E.var_1912[param_00] = [];
	}

	self.var_ECE7 = param_00;
	level.var_FD6E.var_1912[param_00] = scripts\common\utility::array_add_safe(level.var_FD6E.var_1912[param_00],self);
}

//Function Number: 35
func_FDBB(param_00)
{
	if(!isarray(param_00))
	{
		param_00 = [param_00];
	}

	foreach(var_02 in param_00)
	{
		var_03 = func_FD9C(var_02);
		foreach(var_05 in var_03)
		{
			var_05 notify("cleaned");
			func_FDBA(var_05);
		}
	}

	func_FD71();
}

//Function Number: 36
func_FDBA(param_00)
{
	if(!isdefined(param_00))
	{
		return;
	}

	param_00.var_EF = 1;
	param_00.var_C089 = 1;
	if(isdefined(param_00.var_1F1C))
	{
		param_00.var_1F1C notify("ambient_idle_scene_end");
	}

	if(isdefined(param_00.var_B14F))
	{
		param_00 scripts\sp\_utility::func_1101B();
	}

	if(isai(param_00))
	{
		param_00 method_81D0();
	}

	param_00 delete();
}

//Function Number: 37
func_FE0B()
{
	var_00 = getarraykeys(level.var_FD6E.var_10B32);
	if(scripts\common\utility::func_2286(var_00,self.var_1FBB))
	{
		self detach(self.var_8C98);
		self.var_10B31 = level.var_FD6E.var_10B32[self.var_1FBB];
		self attach(self.var_10B31);
	}
}

//Function Number: 38
func_FE0A()
{
	self detach(self.var_10B31);
	self attach(self.var_8C98);
}

//Function Number: 39
func_CD3F(param_00)
{
	func_11004();
	var_01 = level.var_C6AA["retribution"].var_EF67;
	while(!isdefined(var_01))
	{
		scripts\common\utility::func_136F7();
	}

	var_02 = undefined;
	if(issubstr(param_00,"nav") || issubstr(param_00,"gator"))
	{
		var_02 = level.var_C6AA["retribution"].var_454F["nav"];
	}
	else if(issubstr(param_00,"xo") || issubstr(param_00,"salter"))
	{
		var_02 = level.var_C6AA["retribution"].var_454F["xo"];
	}
	else if(issubstr(param_00,"drop") || issubstr(param_00,"do"))
	{
		var_02 = level.var_C6AA["retribution"].var_454F["drop"];
	}
	else if(issubstr(param_00,"conn") || issubstr(param_00,"captain"))
	{
		var_02 = level.var_C6AA["retribution"].var_454F["captain"];
	}

	thread lib_0B43::func_CD50(param_00,var_01,var_02);
}

//Function Number: 40
func_11004()
{
	if(scripts\sp\_utility::func_65DF("hold_simple_idles"))
	{
		scripts\sp\_utility::func_65DD("hold_simple_idles");
	}

	thread lib_0B43::func_9A0F();
	if(isdefined(self.var_C6B7))
	{
		if(isdefined(self.var_C6B7.var_4B31))
		{
			self.var_C6B7 method_806F(self.var_C6B7.var_4B31,0.2);
		}
	}

	self.var_C6B7 = undefined;
	self.var_C6B9 = undefined;
	self.var_C6B8 = undefined;
	thread lib_0C4C::func_19BE();
}

//Function Number: 41
func_906D()
{
	scripts\sp\_utility::func_65E1("hold_simple_idles");
}

//Function Number: 42
func_45A5()
{
	scripts\sp\_utility::func_65DD("hold_simple_idles");
}

//Function Number: 43
func_F59B(param_00)
{
	level.var_FDFA = param_00;
	lib_0B4A::func_F56D(level.var_FDFA);
	function_01C5("missionSelected","1");
	setomnvar("ui_opsmap_selected_mission",param_00);
}

//Function Number: 44
func_7C60()
{
	if(isdefined(level.var_FDFA))
	{
		return level.var_FDFA;
	}

	return undefined;
}

//Function Number: 45
func_7C5F()
{
	if(!isdefined(level.var_FDBC))
	{
		level.var_FDBC = level.player method_84C6("lastCompletedMission");
		if(!scripts\sp\_utility::func_9BB5())
		{
			if(isdefined(func_4EDF()))
			{
				level.var_FDBC = func_4EDF();
			}
		}
	}

	return level.var_FDBC;
}

//Function Number: 46
func_9DB9()
{
	var_00 = 0;
	switch(level.var_10CDA)
	{
		case "prisoner start":
		case "rogue start":
		case "titan start":
		case "europa start":
		case "moon start":
			var_00 = 1;
			break;
	}

	return var_00;
}

//Function Number: 47
func_4EDF()
{
	var_00 = func_4EE1();
	if(!isdefined(var_00))
	{
		var_00 = func_4EE0();
	}

	return var_00;
}

//Function Number: 48
func_4EE0()
{
	var_00 = undefined;
	switch(level.script)
	{
		case "shipcrib_europa":
			level.player method_84C7("lastCompletedMission","sa_moon");
			var_00 = "sa_moon";
			break;

		case "shipcrib_titan":
			level.player method_84C7("scTitanFirstPlay",0);
			level.player method_84C7("lastCompletedMission","sa_assassination");
			var_00 = "sa_assassination";
			break;

		case "shipcrib_rogue":
			level.player method_84C7("lastCompletedMission","titanjackal");
			var_00 = "titan";
			break;

		case "shipcrib_prisoner":
			level.player method_84C7("lastCompletedMission","rogue");
			var_00 = "rogue";
			break;
	}

	return var_00;
}

//Function Number: 49
func_4EE1()
{
	var_00 = undefined;
	switch(level.var_10CDA)
	{
		case "sc_sa_assa":
			var_00 = "sa_assassination";
			level.player method_84C7("scTitanFirstPlay",1);
			level.player method_84C7("lastCompletedMission","sa_assassination");
			break;

		case "sc_sa_emp":
			var_00 = "sa_empambush";
			level.player method_84C7("scTitanFirstPlay",1);
			level.player method_84C7("lastCompletedMission","sa_empambush");
			break;

		case "sc_sa_vips":
			var_00 = "sa_vips";
			level.player method_84C7("scTitanFirstPlay",1);
			level.player method_84C7("lastCompletedMission","sa_vips");
			break;

		case "sc_sa_wound":
			var_00 = "sa_wounded";
			level.player method_84C7("scTitanFirstPlay",1);
			level.player method_84C7("lastCompletedMission","sa_wounded");
			break;

		case "sc_ja_asteroid":
			var_00 = "ja_asteroid";
			level.player method_84C7("scTitanFirstPlay",1);
			level.player method_84C7("lastCompletedMission","ja_asteroid");
			break;

		case "sc_ja_mining":
			var_00 = "ja_mining";
			level.player method_84C7("scTitanFirstPlay",1);
			level.player method_84C7("lastCompletedMission","ja_mining");
			break;

		case "sc_ja_spacestation":
			var_00 = "ja_spacestation";
			level.player method_84C7("scTitanFirstPlay",1);
			level.player method_84C7("lastCompletedMission","ja_spacestation");
			break;

		case "sc_ja_titan":
			var_00 = "ja_titan";
			level.player method_84C7("scTitanFirstPlay",1);
			level.player method_84C7("lastCompletedMission","ja_titan");
			break;

		case "sc_ja_wreckage":
			var_00 = "ja_wreckage";
			level.player method_84C7("scTitanFirstPlay",1);
			level.player method_84C7("lastCompletedMission","ja_wreckage");
			break;
	}

	return var_00;
}

//Function Number: 50
func_7AF0()
{
	var_00 = func_7C60();
	if(!isdefined(var_00))
	{
		var_00 = func_7C5F();
	}

	var_01 = func_45F0(var_00);
	return var_01;
}

//Function Number: 51
func_7C51()
{
	var_00 = func_7C60();
	var_01 = func_45F0(var_00);
	return var_01;
}

//Function Number: 52
func_7A73()
{
	var_00 = func_7C5F();
	var_01 = func_45F0(var_00);
	return var_01;
}

//Function Number: 53
func_45F0(param_00)
{
	var_01 = undefined;
	if(isdefined(param_00))
	{
		switch(param_00)
		{
			case "sa_vips":
				var_01 = "sa_vips";
				break;

			case "sa_empambush":
				var_01 = "sa_empambush";
				break;

			case "sa_assassination":
				var_01 = "sa_assassination";
				break;

			case "sa_wounded":
				var_01 = "sa_wounded";
				break;

			case "sa_jackalarena":
				var_01 = "sa_jackalarena";
				break;

			case "sa_moon":
				var_01 = "ml_moon";
				break;

			case "titan":
				var_01 = "ml_titan";
				break;

			case "titanjackal":
				var_01 = "ml_titan";
				break;

			case "rogue":
				var_01 = "ml_rogue";
				break;

			case "prisoner":
				var_01 = "ml_prisoner";
				break;

			case "ja_asteroid":
				var_01 = "ja_asteroid";
				break;

			case "ja_mining":
				var_01 = "ja_mining";
				break;

			case "ja_spacestation":
				var_01 = "ja_spacestation";
				break;

			case "ja_titan":
				var_01 = "ja_titan";
				break;

			case "ja_wreckage":
				var_01 = "ja_wreckage";
				break;
		}
	}

	return var_01;
}

//Function Number: 54
func_9CB4()
{
	if(!isdefined(level.var_EFF6))
	{
		func_9870();
	}

	return level.var_EFF6;
}

//Function Number: 55
func_9870()
{
	var_00 = level.player method_84C6("scTitanFirstPlay");
	if((!isdefined(var_00) || var_00 == 0) && level.script == "shipcrib_titan")
	{
		var_01 = 1;
	}
	else
	{
		var_01 = 0;
	}

	level.var_EFF6 = var_01;
}

//Function Number: 56
func_986C()
{
	level.var_EFF2 = level.player method_84C6("scTaughtOpsmap");
}

//Function Number: 57
func_FD77(param_00)
{
	var_01 = [param_00 + "_prime_tr",param_00 + "_prime_in_tr",param_00 + "_bridge_tr",param_00 + "_bridgee_tr",param_00 + "_halore_tr",param_00 + "_exterior_tr"];
	if(param_00 != "shipcrib_moon" && param_00 != "shipcrib_europa")
	{
		var_02 = [param_00 + "_bridgem_tr"];
		var_01 = scripts\common\utility::array_combine(var_01,var_02);
	}

	func_FE05();
	level.var_FD6E.var_30B8 = var_01;
	return var_01;
}

//Function Number: 58
func_FD73(param_00)
{
	var_01 = [param_00 + "_prime_tr",param_00 + "_prime_in_tr",param_00 + "_hangar_tr",param_00 + "_halore_tr",param_00 + "_mezz_tr",param_00 + "_ambient_tr",param_00 + "_vr_tr"];
	if(param_00 != "shipcrib_moon")
	{
		var_02 = [param_00 + "_dropship_tr",param_00 + "_ambientml_tr"];
		var_01 = scripts\common\utility::array_combine(var_01,var_02);
	}

	func_FE05();
	level.var_FD6E.var_224C = var_01;
	return var_01;
}

//Function Number: 59
func_FDAE(param_00)
{
	var_01 = [param_00 + "_prime_tr",param_00 + "_prime_in_tr",param_00 + "_hangar_tr",param_00 + "_halore_tr",param_00 + "_mezz_tr",param_00 + "_ambient_tr"];
	if(param_00 != "shipcrib_moon")
	{
		var_02 = [param_00 + "_dropship_tr",param_00 + "_ambientml_tr"];
		var_01 = scripts\common\utility::array_combine(var_01,var_02);
	}

	func_FE05();
	level.var_FD6E.var_8ACB = var_01;
	return var_01;
}

//Function Number: 60
func_FDDC(param_00)
{
	var_01 = [param_00 + "_prime_tr",param_00 + "_prime_in_tr",param_00 + "_jackal_tr",param_00 + "_hangar_tr",param_00 + "_mezz_tr",param_00 + "_halore_tr",param_00 + "_ambient_tr"];
	if(param_00 != "shipcrib_moon")
	{
		var_02 = [param_00 + "_dropship_tr",param_00 + "_ambientmr_tr"];
		var_01 = scripts\common\utility::array_combine(var_01,var_02);
	}

	func_FE05();
	level.var_FD6E.var_E46F = var_01;
	return var_01;
}

//Function Number: 61
func_FDB2(param_00)
{
	var_01 = [param_00 + "_prime_tr",param_00 + "_prime_in_tr",param_00 + "_jackal_tr",param_00 + "_jackale_tr",param_00 + "_hangar_tr",param_00 + "_mezz_tr",param_00 + "_ambient_tr"];
	func_FE05();
	level.var_FD6E.var_A248 = var_01;
	return var_01;
}

//Function Number: 62
func_FDBD(param_00,param_01)
{
	func_FE05();
	if(!isdefined(level.var_FD6E.var_111D7))
	{
		level.var_FD6E.var_111D7 = function_00AC()[3];
	}

	var_02 = param_01 / 0.05;
	var_03 = param_00 - level.var_FD6E.var_111D7;
	var_04 = var_03 / var_02;
	for(var_05 = 0;var_05 < var_02;var_05++)
	{
		if(var_02 == 1)
		{
			break;
		}

		level.var_FD6E.var_111D7 = level.var_FD6E.var_111D7 + var_04;
		function_01CB(level.var_FD6E.var_111D7);
		scripts\common\utility::func_136F7();
	}

	function_01CB(param_00);
	level.var_FD6E.var_111D7 = param_00;
}

//Function Number: 63
func_FDCD()
{
	if(isdefined(level.var_C6AA) && isdefined(level.var_C6AA["retribution"]) && isdefined(level.var_C6AA["retribution"].var_BA11) && isdefined(level.var_C6AA["retribution"].var_BA11["nav_screen"]))
	{
		level.var_C6AA["retribution"].var_BA11["nav_screen"] unlink();
	}
}

//Function Number: 64
func_25ED()
{
	var_00 = randomintrange(0,3);
	if(var_00 == 0)
	{
		function_02A9("vr_fire_speed","",0);
	}

	if(var_00 == 1)
	{
		function_02A9("vr_fire_speed","1",0);
	}

	if(var_00 == 2)
	{
		function_02A9("vr_fire_speed","2",0);
	}
}

//Function Number: 65
func_EB8E(param_00,param_01,param_02)
{
	level notify("shipcrib_loadout_heroes");
	level endon("shipcrib_loadout_heroes");
	if(!isdefined(param_00))
	{
		param_00 = [level.var_EA2C,level.var_6754,level.var_C47F,level.var_30F6,level.var_A538];
	}

	param_00 = scripts\common\utility::func_22BC(param_00);
	scripts\common\utility::array_thread(param_00,::func_EB8D,param_01,param_02);
}

//Function Number: 66
func_EB8D(param_00,param_01)
{
	self notify("loadout_hero");
	self endon("loadout_hero");
	self endon("death");
	level endon("shipcrib_loadout_heroes");
	if(!isdefined(level.var_FDFA) && !isdefined(param_00))
	{
		return 0;
	}

	if(isdefined(level.var_FDFA))
	{
		param_00 = level.var_FDFA;
	}

	switch(self.var_1FBB)
	{
		case "salter":
			thread func_AE40(param_00,param_01);
			break;

		case "ethan":
			thread func_AE2D(param_00,param_01);
			break;

		case "omar":
			thread func_AE3C(param_00,param_01);
			break;

		case "brooks":
			thread func_AE25(param_00,param_01);
			break;

		case "kash":
			thread func_AE37(param_00,param_01);
			break;

		case "nunez":
			thread func_AE3B(param_00,param_01);
			break;

		case "goodwin":
			thread func_AE34(param_00,param_01);
			break;

		case "private":
			thread func_AE3D(param_00,param_01);
			break;

		case "admiral":
			thread func_AE22(param_00,param_01);
			break;

		case "sipes":
			thread func_AE43(param_00,param_01);
			break;

		default:
			scripts\sp\_utility::func_86E2();
			break;
	}

	if(isdefined(param_01) && param_01)
	{
		if(isdefined(self.var_13C4D))
		{
			self.var_13C4D delete();
		}

		scripts\sp\_utility::func_CC06(self.var_394,"back");
	}
}

//Function Number: 67
func_AE40(param_00,param_01)
{
	self endon("death");
	self endon("loadout_hero");
	level endon("shipcrib_loadout_heroes");
	var_02 = undefined;
	var_03 = undefined;
	switch(param_00)
	{
		case "phparade":
			var_02 = "iw7_m8";
			var_03 = "iw7_m4";
			break;

		case "moon_port":
			var_03 = "iw7_m4";
			break;

		case "sa_wounded":
			var_03 = "iw7_devastator";
			break;

		case "sa_empambush":
			var_03 = "iw7_m8+m8scope_sp+silencersniperhidee";
			break;

		case "sa_assassination":
			var_03 = "iw7_crb+silencersmg";
			break;

		case "sa_vips":
			var_02 = "iw7_m8+m8scope_sp+silencersniperhidee";
			var_03 = "iw7_m4+silencer";
			break;

		case "titan":
			var_03 = "iw7_devastator";
			break;

		case "rogue":
			var_03 = "iw7_devastator";
			break;

		case "heist":
			var_03 = "iw7_m4";
			break;

		case "prisoner":
			var_03 = "iw7_m4";
			break;
	}

	thread func_AE45(param_01,var_03);
}

//Function Number: 68
func_AE2D(param_00,param_01)
{
	self endon("death");
	self endon("loadout_hero");
	level endon("shipcrib_loadout_heroes");
	var_02 = undefined;
	var_03 = undefined;
	switch(param_00)
	{
		case "phparade":
			var_03 = "iw7_fhr";
			break;

		case "moon_port":
			var_03 = "iw7_m4";
			break;

		case "sa_vips":
			var_03 = "iw7_crb+silencersmg";
			break;

		case "titan":
			var_03 = "iw7_crb+silencersmg";
			break;

		case "prisoner":
			var_03 = "iw7_fhr";
			break;

		case "heist":
			var_03 = "iw7_fmg";
			break;
	}

	thread func_AE45(param_01,var_03);
}

//Function Number: 69
func_AE3C(param_00,param_01)
{
	self endon("death");
	self endon("loadout_hero");
	level endon("shipcrib_loadout_heroes");
	var_02 = undefined;
	var_03 = undefined;
	switch(param_00)
	{
		case "moon_port":
			var_03 = "iw7_m4";
			break;

		case "titan":
			var_03 = "iw7_fhr+silencersmg";
			break;

		case "rogue":
			var_03 = "iw7_sdfshotty";
			break;
	}

	thread func_AE45(param_01,var_03);
}

//Function Number: 70
func_AE25(param_00,param_01)
{
	self endon("death");
	self endon("loadout_hero");
	level endon("shipcrib_loadout_heroes");
	var_02 = undefined;
	var_03 = undefined;
	switch(param_00)
	{
		case "moon_port":
			var_03 = "iw7_m4";
			break;

		case "sa_wounded":
			var_03 = "iw7_erad";
			break;

		case "sa_empambush":
			var_03 = "iw7_kbs+kbsscope+silencersniperhide";
			break;

		case "sa_vips":
			var_03 = "iw7_m4+silencer";
			break;

		case "titan":
			var_03 = "iw7_ar57+silencer";
			break;

		case "rogue":
			var_03 = "iw7_ake";
			break;

		case "heist":
			var_03 = "iw7_ar57";
			break;

		case "prisoner":
			var_03 = "iw7_ar57";
			break;
	}

	thread func_AE45(param_01,var_03);
}

//Function Number: 71
func_AE37(param_00,param_01)
{
	self endon("death");
	self endon("loadout_hero");
	level endon("shipcrib_loadout_heroes");
	var_02 = undefined;
	var_03 = undefined;
	switch(param_00)
	{
		case "moon_port":
			var_03 = "iw7_m4";
			break;

		case "sa_empambush":
			var_03 = "iw7_kbs+kbsscope+silencersniperhide";
			break;

		case "sa_vips":
			var_03 = "iw7_erad+silencersmge";
			break;

		case "titan":
			var_03 = "iw7_fmg+silencerefmg";
			break;

		case "rogue":
			var_03 = "iw7_ripper";
			break;

		case "heist":
			var_03 = "iw7_erad";
			break;
	}

	thread func_AE45(param_01,var_03);
}

//Function Number: 72
func_AE3B(param_00,param_01)
{
	self endon("death");
	self endon("loadout_hero");
	level endon("shipcrib_loadout_heroes");
	var_02 = undefined;
	var_03 = undefined;
	switch(param_00)
	{
		case "moon_port":
			var_03 = "iw7_m4";
			break;
	}

	thread func_AE45(param_01,var_03);
}

//Function Number: 73
func_AE34(param_00,param_01)
{
	self endon("death");
	self endon("loadout_hero");
	level endon("shipcrib_loadout_heroes");
	var_02 = undefined;
	var_03 = undefined;
	switch(param_00)
	{
		case "moon_port":
			var_03 = "iw7_m4";
			break;
	}

	thread func_AE45(param_01,var_03);
}

//Function Number: 74
func_AE3D(param_00,param_01)
{
	self endon("death");
	self endon("loadout_hero");
	level endon("shipcrib_loadout_heroes");
	var_02 = undefined;
	var_03 = undefined;
	switch(param_00)
	{
		case "moon_port":
			var_03 = "iw7_m4";
			break;
	}

	thread func_AE45(param_01,var_03);
}

//Function Number: 75
func_AE22(param_00,param_01)
{
	self endon("death");
	self endon("loadout_hero");
	level endon("shipcrib_loadout_heroes");
	var_02 = undefined;
	var_03 = undefined;
	switch(param_00)
	{
		case "phparade":
			var_03 = "iw7_ake";
			break;
	}

	thread func_AE45(param_01,var_03);
}

//Function Number: 76
func_AE43(param_00,param_01)
{
	self endon("death");
	self endon("loadout_hero");
	level endon("shipcrib_loadout_heroes");
	var_02 = undefined;
	var_03 = undefined;
	switch(param_00)
	{
		case "europa":
			var_03 = "iw7_fhr+silencersmg";
			break;
	}

	thread func_AE45(param_01,var_03);
}

//Function Number: 77
func_AE45(param_00,param_01)
{
	self endon("death");
	if(isdefined(param_00))
	{
		level func_3DDE(param_01);
		scripts\sp\_utility::func_192C(param_01);
	}

	if(isdefined(param_01))
	{
		level func_3DDE(param_01);
		scripts\sp\_utility::func_72EC(param_01,"primary");
		return;
	}

	level func_3DDE(self.var_394);
	scripts\sp\_utility::func_86E2();
}

//Function Number: 78
func_3DDE(param_00,param_01)
{
	param_00 = getweaponbasename(param_00);
	var_02 = "weapon_" + param_00 + "_tr";
	if(!function_0119(var_02))
	{
		scripts\sp\_utility::func_13705();
		scripts\sp\_utility::func_12641(var_02);
		if(!scripts\common\utility::func_2286(level.var_D9E5["loaded_weapons"],param_00))
		{
			level.var_D9E5["loaded_weapons"] = scripts\common\utility::array_add(level.var_D9E5["loaded_weapons"],param_00);
			level.player method_84C7("weaponsLoaded",param_00,1);
		}
	}
}

//Function Number: 79
func_7B87(param_00)
{
	return level.var_EC85["player_rig"][param_00];
}

//Function Number: 80
func_FDD6(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = "Urban";
	}

	switch(param_01)
	{
		case "Urban":
			level thread func_37D0(param_00,param_01,"viewmodel_base_viewhands_iw7");
			level thread scripts\sp\_utility::func_9145("fluff_messages_camo_urban");
			break;

		case "Naval":
			level thread func_37D0(param_00,param_01,"viewmodel_base_viewhands_iw7_naval");
			level thread scripts\sp\_utility::func_9145("fluff_messages_camo_naval");
			break;

		case "Desert":
			level thread func_37D0(param_00,param_01,"viewmodel_base_viewhands_iw7_desert");
			level thread scripts\sp\_utility::func_9145("fluff_messages_camo_desert");
			break;
	}
}

//Function Number: 81
func_37D0(param_00,param_01,param_02)
{
	level.player playsound("sc_armory_player_hand_camo_change");
	param_00 method_831F(level.player);
	param_00 method_854E();
	var_03 = param_00 gettagorigin("j_elbow_le");
	var_04 = param_00 gettagangles("j_elbow_le");
	var_03 = var_03 + anglestoforward(var_04) * 8;
	var_05 = var_03 + anglestoforward(var_04) * -24;
	var_06 = scripts\common\utility::spawn_tag_origin(var_03,var_04);
	playfxontag(scripts\common\utility::getfx("vfx_sc_armory_terminal_camo_change_scan"),var_06,"tag_origin");
	var_06 moveto(var_05,1,0.125,0.125);
	var_06 scripts\common\utility::delaycall(1,::moveto,var_03,1,0.125,0.125);
	wait(0.5);
	param_00 setscriptablepartstate("camouflage","camouflageOn",1);
	wait(0.5);
	level.player method_84C7("currentViewModel",param_02);
	param_00 func_FDD7(1);
	param_00 setscriptablepartstate("camouflage","camouflageOnInstant",1);
	scripts\common\utility::func_136F7();
	param_00 setscriptablepartstate("camouflage","camouflageOff",1);
	wait(1.25);
	killfxontag(scripts\common\utility::getfx("vfx_sc_armory_terminal_camo_change_scan"),var_06,"tag_origin");
	var_06 delete();
}

//Function Number: 82
func_FDD7(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 0;
	}

	var_01 = func_FD9D();
	switch(var_01)
	{
		case "viewmodel_base_viewhands_iw7_naval":
			var_02 = "body_hero_protagonist_vm_legs_naval";
			break;

		case "viewmodel_base_viewhands_iw7_desert":
			var_02 = "body_hero_protagonist_vm_legs_desert";
			break;

		default:
			var_02 = "body_hero_protagonist_vm_legs";
			break;
	}

	if(param_00)
	{
		self setmodel(var_01);
	}

	level.player method_8369(var_01);
	level.player method_8574(var_02);
}

//Function Number: 83
func_FE02(param_00,param_01,param_02)
{
	var_03 = scripts\sp\_utility::func_10639(param_00,param_01,param_02);
	var_04 = func_FD9D();
	var_03 setmodel(var_04);
	return var_03;
}

//Function Number: 84
func_FD9D()
{
	var_00 = level.player method_84C6("currentViewModel");
	if(!isdefined(var_00))
	{
		var_00 = "viewmodel_base_viewhands_iw7";
	}
	else if(var_00 == "")
	{
		var_00 = "viewmodel_base_viewhands_iw7";
	}

	return var_00;
}

//Function Number: 85
func_FDD9()
{
	scripts\sp\_utility::func_13C3C(level.var_FDFA);
	scripts\sp\_utility::func_13C60();
}

//Function Number: 86
shipcrib_autosave_now_silent()
{
	level notify("try_new_autosave");
	for(;;)
	{
		var_00 = shipcrib_autosave_now_silent_internal();
		if(!isdefined(var_00))
		{
			if(scripts\common\utility::flag("game_saving"))
			{
				scripts\common\utility::func_6E2A("game_saving");
			}

			return;
		}

		if(var_00)
		{
			return;
		}
	}
}

//Function Number: 87
shipcrib_autosave_now_silent_internal()
{
	level endon("try_new_autosave");
	while(!scripts\sp\_autosave::func_1190(1,1))
	{
		wait(1);
	}

	return 1;
}