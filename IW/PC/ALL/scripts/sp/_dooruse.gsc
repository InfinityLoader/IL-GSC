/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\sp\_dooruse.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 69
 * Decompile Time: 3224 ms
 * Timestamp: 10/27/2023 12:24:13 AM
*******************************************************************/

//Function Number: 1
func_95B6()
{
	level.var_5A2B = [];
	func_5983();
	func_1AC1();
	var_00 = getentarray("generic_door","script_noteworthy");
	foreach(var_02 in var_00)
	{
		if(isdefined(var_02.var_336) && isdefined(level.var_5A2B[var_02.var_336]))
		{
			if(!isdefined(level.var_FCD6) || level.var_FCD6 != 1)
			{
				continue;
			}
		}

		if(var_02.classname == "script_origin")
		{
			var_03 = var_02 scripts\common\utility::spawn_tag_origin();
			var_03.var_336 = var_02.var_336;
			var_03.var_EE79 = var_02.var_EE79;
			var_03.var_EDA0 = var_02.var_EDA0;
			var_02 = var_03;
		}

		if(isdefined(var_02.var_336))
		{
			level.var_5A2B[var_02.var_336] = var_02;
			var_04 = getentarray(var_02.var_336,"targetname");
			foreach(var_06 in var_04)
			{
				if(var_06.classname == "script_brushmodel")
				{
					var_02.var_4381 = var_06;
				}
			}
		}

		var_02.var_5A18 = var_02.var_336;
		var_02.var_5A57 = var_02.var_EE79;
		var_02.var_1FBB = "door";
		var_02 method_83D0(#animtree);
		var_02 scripts\sp\_utility::func_65E0("player_used_door");
		var_02 scripts\sp\_utility::func_65E0("player_at_door");
		var_02 scripts\sp\_utility::func_65E0("actor_at_door");
		var_02 scripts\sp\_utility::func_65E0("begin_opening");
		var_02 scripts\sp\_utility::func_65E0("door_opened");
		var_02 scripts\sp\_utility::func_65E0("door_sequence_complete");
		var_02 scripts\sp\_utility::func_65E0("no_anim_reach");
		var_02 scripts\sp\_utility::func_65E0("skip_reach_on_use");
		if(isdefined(var_02.var_EDA0))
		{
			var_02 scripts\sp\_utility::func_65E0(var_02.var_EDA0);
		}

		var_02 scripts\sp\_utility::func_65E0("locked");
		var_02 thread func_59F7();
	}

	thread func_9530("door_peek_armory");
}

//Function Number: 2
func_59F7()
{
	if(self.var_5A57 == "airlock" && self.model == "sdf_door_airlock_01")
	{
		lib_0B06::func_1EC3(self,"airlock_open_player");
	}

	if(isdefined(self.var_EDA0))
	{
		scripts\sp\_utility::func_65E3(self.var_EDA0);
	}

	switch(self.var_5A57)
	{
		case "no_power":
			thread func_315D();
			break;

		case "large_buddy":
			thread func_A852();
			break;

		case "armory":
			self.var_245 = "closed";
			thread func_21E0();
			break;

		case "armory_door_peek":
			self.var_245 = "closed";
			thread func_21E0();
			break;

		case "airlock":
			thread func_1AB0();
			break;

		case "bulkhead_door":
			thread func_3232();
			break;
	}
}

//Function Number: 3
func_168A(param_00)
{
	self.var_1684 = param_00;
	switch(self.var_5A57)
	{
		case "no_power":
			func_3156(param_00);
			break;

		case "airlock":
			break;
	}
}

//Function Number: 4
func_AED6()
{
	if(!scripts\sp\_utility::func_65DB("locked"))
	{
		scripts\sp\_utility::func_65E1("locked");
		lib_0E46::func_DFE3();
	}
}

//Function Number: 5
func_12BD3()
{
	if(scripts\sp\_utility::func_65DB("locked"))
	{
		scripts\sp\_utility::func_65DD("locked");
		lib_0E46::func_48C4("tag_ui_front",(0,0,-2));
	}
}

//Function Number: 6
func_599E()
{
	return scripts\sp\_utility::func_65DB("locked");
}

//Function Number: 7
func_1AB0()
{
	var_00 = scripts\sp\_utility::func_7A8F();
	scripts\common\utility::func_227D(var_00,::linkto,self,"door_jnt");
	foreach(var_02 in var_00)
	{
		if(isdefined(var_02.script_noteworthy) && var_02.script_noteworthy == "player_clip")
		{
			continue;
		}

		self.var_C969 = var_02;
	}

	if(isdefined(self.var_EF20) && self.var_EF20 == "notplayer")
	{
		return;
	}

	self.var_DF3A = 1;
	lib_0E46::func_48C4("tag_ui_front");
	self waittill("trigger",var_04);
	scripts\sp\_utility::func_65E1("player_at_door");
	var_05 = func_D0A6("airlock_open_player");
	scripts\sp\_utility::func_65E1("begin_opening");
	var_06 = [self,var_05];
	if(soundexists("airlock_exit_door_open"))
	{
		level.player thread scripts\sp\_utility::func_CE2F("airlock_exit_door_open");
	}

	lib_0B06::func_1F2C(var_06,"airlock_open_player");
	if(scripts\common\utility::istrue(self.var_DF3A))
	{
		level.player func_5990();
		level.player unlink();
		var_05 delete();
	}

	self.var_C969 connectpaths();
	self.var_C969 disconnectpaths();
	scripts\sp\_utility::func_65E1("door_sequence_complete");
}

//Function Number: 8
func_1AC1()
{
	level.var_1AE3 = [];
	scripts\common\utility::flag_init("airlocks_setup");
	level._effect["vfx_airlock_light_green"] = loadfx("vfx/iw7/_requests/airlock/vfx_light_green.vfx");
	level._effect["vfx_airlock_light_orange"] = loadfx("vfx/iw7/_requests/airlock/vfx_light_orange.vfx");
	level._effect["vfx_airlock_light_red"] = loadfx("vfx/iw7/_requests/airlock/vfx_light_red.vfx");
	level._effect["vfx_airlock_vent_xtrlrg_press"] = loadfx("vfx/iw7/core/mechanics/airlock/vfx_airlock_vent_xtrlrg_press.vfx");
	level._effect["vfx_airlock_vents_air"] = loadfx("vfx/iw7/core/mechanics/airlock/vfx_airlock_vent_lrg_press.vfx");
	level._effect["vfx_airlock_air_fill"] = loadfx("vfx/iw7/core/mechanics/airlock/vfx_airlock_roomcenter_press.vfx");
	level._effect["vfx_airlock_camcentr_depress"] = loadfx("vfx/iw7/core/mechanics/airlock/vfx_airlock_camcentr_depress.vfx");
	level._effect["vfx_airlock_vent_lrg_depress"] = loadfx("vfx/iw7/core/mechanics/airlock/vfx_airlock_vent_lrg_depress.vfx");
	func_1ACF();
	func_1AAF();
	thread func_1AD9();
}

//Function Number: 9
func_1AD9()
{
	scripts\common\utility::func_136F7();
	var_00 = scripts\common\utility::getstructarray("generic_airlock_assets","script_noteworthy");
	foreach(var_02 in var_00)
	{
		if(!isdefined(var_02.var_336))
		{
			continue;
		}

		var_02.var_ECCE = [];
		var_02.var_ECCE["front"] = [];
		var_02.var_ECCE["back"] = [];
		var_03 = getscriptablearray(var_02.var_336,"targetname");
		foreach(var_05 in var_03)
		{
			var_06 = "back";
			if(isdefined(var_05.script_noteworthy) && var_05.script_noteworthy == "forward")
			{
				var_06 = "front";
			}

			var_02.var_ECCE[var_06] = scripts\common\utility::array_add(var_02.var_ECCE[var_06],var_05);
			if(var_06 == "front")
			{
				var_05 setscriptablepartstate("root","0");
				continue;
			}

			var_05 setscriptablepartstate("root","12");
		}

		var_02 func_1AAE();
		var_02 scripts\sp\_utility::func_65E0("cycling");
		var_02 scripts\sp\_utility::func_65E0("cycling_complete");
		thread scripts\common\utility::play_loopsound_in_space("airlock_light_hum",var_02.origin);
		if(isdefined(var_02.var_336))
		{
			level.var_1AE3[var_02.var_336] = var_02;
		}
	}

	scripts\common\utility::flag_set("airlocks_setup");
}

//Function Number: 10
func_1AAE()
{
	var_00 = "airlock_cycling_pressurize";
	var_01 = "airlock_cycling_depressurize";
	var_02 = [];
	var_02["pressurize"] = [];
	var_02["depressurize"] = [];
	foreach(var_04 in level.var_49C9)
	{
		if(isdefined(var_04.var_13125["exploder"]))
		{
			if(var_04.var_13125["exploder"] == var_00)
			{
				var_02["pressurize"] = scripts\common\utility::array_add(var_02["pressurize"],var_04);
				continue;
			}

			if(var_04.var_13125["exploder"] == var_01)
			{
				var_02["depressurize"] = scripts\common\utility::array_add(var_02["depressurize"],var_04);
			}
		}
	}

	self.var_4CD3["pressurize"] = [];
	self.var_4CD3["depressurize"] = [];
	var_06 = ["pressurize","depressurize"];
	foreach(var_08 in var_06)
	{
		foreach(var_04 in var_02[var_08])
		{
			var_0A = var_04.var_13125["fxid"];
			var_0B = var_04.var_13125["origin"];
			var_0C = var_04.var_13125["angles"];
			var_0D = var_04.var_13125["delay"];
			var_0E = spawnstruct();
			var_0E.var_762C = var_04.var_13125["fxid"];
			var_0E.origin = var_04.var_13125["origin"];
			var_0E.angles = var_04.var_13125["angles"];
			var_0E.var_50AE = var_04.var_13125["delay"];
			self.var_4CD3[var_08] = scripts\common\utility::array_add(self.var_4CD3[var_08],var_0E);
		}
	}
}

//Function Number: 11
func_1ACF()
{
	var_00 = scripts\common\createfx::func_49AF("vfx_airlock_air_fill","airlock_cycling_pressurize");
	var_00 scripts\common\createfx::func_F4AD((-2.34019,-5.35077,10.1119),(270,0,0));
	var_00 = scripts\common\createfx::func_49AF("vfx_airlock_vent_xtrlrg_press","airlock_cycling_pressurize");
	var_00 scripts\common\createfx::func_F4AD((71.5714,90.1929,22.4209),(327.999,271.999,0));
	var_00 = scripts\common\createfx::func_49AF("vfx_airlock_vents_air","airlock_cycling");
	var_00 scripts\common\createfx::func_F4AD((71.7566,-88.0884,130.896),(30.9999,89.9989,0));
	var_00.var_13125["delay"] = 0.1;
	var_00 = scripts\common\createfx::func_49AF("vfx_airlock_vents_air","airlock_cycling_pressurize");
	var_00 scripts\common\createfx::func_F4AD((23.7468,-91.7748,133.02),(30.9999,89.9989,0));
	var_00 = scripts\common\createfx::func_49AF("vfx_airlock_vents_air","airlock_cycling_pressurize");
	var_00 scripts\common\createfx::func_F4AD((-24.1032,-92.3938,133.065),(30.9999,89.9989,0));
	var_00.var_13125["delay"] = 0.9;
	var_00 = scripts\common\createfx::func_49AF("vfx_airlock_vents_air","airlock_cycling_pressurize");
	var_00 scripts\common\createfx::func_F4AD((-67.9505,-94.0097,132.632),(30.9999,89.9989,0));
	var_00.var_13125["delay"] = 0.15;
	var_00 = scripts\common\createfx::func_49AF("vfx_airlock_vents_air","airlock_cycling_pressurize");
	var_00 scripts\common\createfx::func_F4AD((-72.8097,87.5459,131.168),(34.9998,273.999,0));
	var_00.var_13125["delay"] = 0.1;
	var_00 = scripts\common\createfx::func_49AF("vfx_airlock_vents_air","airlock_cycling_pressurize");
	var_00 scripts\common\createfx::func_F4AD((-25.4342,86.8056,129.173),(34.9998,273.999,0));
	var_00.var_13125["delay"] = 0.75;
	var_00 = scripts\common\createfx::func_49AF("vfx_airlock_vents_air","airlock_cycling_pressurize");
	var_00 scripts\common\createfx::func_F4AD((25.3645,88.4423,130.479),(34.9998,273.999,0));
	var_00.var_13125["delay"] = 0.05;
	var_00 = scripts\common\createfx::func_49AF("vfx_airlock_vents_air","airlock_cycling_pressurize");
	var_00 scripts\common\createfx::func_F4AD((73.602,88.8602,130.599),(34.9998,273.999,0));
	var_00.var_13125["delay"] = 0.1;
	var_00 = scripts\common\createfx::func_49AF("vfx_airlock_vent_xtrlrg_press","airlock_cycling_pressurize");
	var_00 scripts\common\createfx::func_F4AD((23.2354,93.3036,20.1975),(327.999,271.999,0));
	var_00.var_13125["delay"] = 0.4;
	var_00 = scripts\common\createfx::func_49AF("vfx_airlock_vent_xtrlrg_press","airlock_cycling_pressurize");
	var_00 scripts\common\createfx::func_F4AD((-21.9721,93.4224,21.0276),(327.999,271.999,0));
	var_00.var_13125["delay"] = 1;
	var_00 = scripts\common\createfx::func_49AF("vfx_airlock_vent_xtrlrg_press","airlock_cycling_pressurize");
	var_00 scripts\common\createfx::func_F4AD((-72.7803,94.2712,19.7878),(327.999,271.999,0));
}

//Function Number: 12
func_1AAF()
{
	var_00 = scripts\common\createfx::func_49AF("vfx_airlock_vent_lrg_depress","airlock_cycling_depressurize");
	var_00 scripts\common\createfx::func_F4AD((73.2631,-85.4638,129.046),(34.9998,93.9989,0));
	var_00 = scripts\common\createfx::func_49AF("vfx_airlock_vent_lrg_depress","airlock_cycling_depressurize");
	var_00 scripts\common\createfx::func_F4AD((23.5765,-91.5693,131.861),(34.9998,93.9989,0));
	var_00.var_13125["delay"] = 0.2;
	var_00 = scripts\common\createfx::func_49AF("vfx_airlock_vent_lrg_depress","airlock_cycling_depressurize");
	var_00 scripts\common\createfx::func_F4AD((-24.8883,-89.9546,130.099),(34.9998,93.9989,0));
	var_00.var_13125["delay"] = 0.3;
	var_00 = scripts\common\createfx::func_49AF("vfx_airlock_vent_lrg_depress","airlock_cycling_depressurize");
	var_00 scripts\common\createfx::func_F4AD((-71.6661,-90.0395,132.764),(34.9998,93.9989,0));
	var_00 = scripts\common\createfx::func_49AF("vfx_airlock_vent_lrg_depress","airlock_cycling_depressurize");
	var_00 scripts\common\createfx::func_F4AD((-21.3988,84.8157,127.166),(35.9998,267.999,0));
	var_00 = scripts\common\createfx::func_49AF("vfx_airlock_vent_lrg_depress","airlock_cycling_depressurize");
	var_00 scripts\common\createfx::func_F4AD((-72.5438,88.4987,130.708),(39.9702,273.609,1.67727));
	var_00.var_13125["delay"] = 0.2;
	var_00 = scripts\common\createfx::func_49AF("vfx_airlock_vent_lrg_depress","airlock_cycling_depressurize");
	var_00 scripts\common\createfx::func_F4AD((73.4549,86.6092,129.863),(39.8823,264.784,-3.34982));
	var_00.var_13125["delay"] = 0.1;
	var_00 = scripts\common\createfx::func_49AF("vfx_airlock_vent_lrg_depress","airlock_cycling_depressurize");
	var_00 scripts\common\createfx::func_F4AD((25.3469,86.5301,129.677),(39.9457,271.876,2.07295));
	var_00.var_13125["delay"] = 0.3;
	var_00 = scripts\common\createfx::func_49AF("vfx_airlock_vent_lrg_depress","airlock_cycling_depressurize");
	var_00 scripts\common\createfx::func_F4AD((-23.1415,99.9688,14.9828),(317.999,267.999,0));
	var_00 = scripts\common\createfx::func_49AF("vfx_airlock_vent_lrg_depress","airlock_cycling_depressurize");
	var_00 scripts\common\createfx::func_F4AD((24.8086,-96.6052,16.5775),(323.999,90.9985,0));
	var_00.var_13125["delay"] = 0.3;
	var_00 = scripts\common\createfx::func_49AF("vfx_airlock_camcentr_depress","airlock_cycling_depressurize");
	var_00 scripts\common\createfx::func_F4AD((7.92258,-4.8918,18.4052),(270,0,0));
}

//Function Number: 13
func_1AB7(param_00,param_01,param_02)
{
	var_03 = "back";
	if(param_00)
	{
		var_03 = "front";
	}

	if(var_03 == "front")
	{
		if(isdefined(param_01))
		{
			param_01 func_1AB5(1);
		}

		if(isdefined(param_02))
		{
			param_02 func_1AB5(0);
			return;
		}

		return;
	}

	if(isdefined(param_01))
	{
		param_01 func_1AB5(0);
	}

	if(isdefined(param_02))
	{
		param_02 func_1AB5(1);
	}
}

//Function Number: 14
func_1AB5(param_00)
{
	if(self.model != "sdf_door_airlock_01")
	{
		if(!isdefined(self.var_ACD5))
		{
			self.var_ACD5 = [];
			var_01 = [15,-7];
			foreach(var_03 in var_01)
			{
				var_04 = scripts\common\utility::spawn_tag_origin();
				var_04 linkto(self,"door_jnt",(38.5,var_03,16),(0,0,0));
				self.var_ACD5[self.var_ACD5.size] = var_04;
			}
		}
	}

	if(param_00)
	{
		func_1AB6("unlocked");
		return;
	}

	func_1AB6("locked");
}

//Function Number: 15
func_1AB2(param_00)
{
	if(isdefined(param_00.var_ACD5))
	{
		foreach(var_02 in param_00.var_ACD5)
		{
			var_02 delete();
		}
	}

	param_00 delete();
}

//Function Number: 16
func_1AA9(param_00,param_01,param_02,param_03,param_04)
{
	scripts\common\utility::flag_wait("airlocks_setup");
	var_05 = scripts\common\utility::getstruct(param_00,"targetname");
	var_05 scripts\sp\_utility::func_65DD("cycling_complete");
	var_05 scripts\sp\_utility::func_65E1("cycling");
	var_06 = [];
	if(isdefined(param_02))
	{
		var_06 = scripts\common\utility::array_add(var_06,param_02);
	}

	if(isdefined(param_03))
	{
		var_06 = scripts\common\utility::array_add(var_06,param_03);
	}

	foreach(var_08 in var_06)
	{
		if(isdefined(var_08) && !isdefined(var_08.var_ACD5))
		{
			var_08.var_ACD5 = [];
			var_09 = [15,-7];
			foreach(var_0B in var_09)
			{
				var_0C = var_08 scripts\common\utility::spawn_tag_origin();
				var_0C linkto(var_08,"door_jnt",(38.5,var_0B,16),(0,0,0));
				var_08.var_ACD5[var_08.var_ACD5.size] = var_0C;
			}
		}
	}

	var_0F = "airlock_pressurize_lr";
	if(!isdefined(param_04) || param_04)
	{
		function_02A9("atmosphere","",2);
	}
	else
	{
		var_0F = "airlock_depressurize_lr";
		function_02A9("atmosphere","space",2);
	}

	var_10 = lookupsoundlength(var_0F);
	var_05.var_4CD5 = 1;
	var_05 thread func_1AD7(var_10,param_04);
	scripts\common\utility::array_thread(var_06,::func_1AB1,var_05,"cycling");
	if(!isdefined(param_04))
	{
		param_04 = 1;
	}

	var_05 thread func_1AAD(param_04);
	level.player scripts\sp\_utility::func_CE2F(var_0F);
	var_05.var_4CD5 = 0;
	var_11 = "back";
	if(param_01)
	{
		var_11 = "front";
	}

	var_12 = ["front","back"];
	foreach(var_14 in var_12)
	{
		if(var_14 == var_11)
		{
			foreach(var_16 in var_05.var_ECCE[var_14])
			{
				var_16 setscriptablepartstate("root",12);
			}

			continue;
		}

		foreach(var_16 in var_05.var_ECCE[var_14])
		{
			var_16 setscriptablepartstate("root",0);
		}
	}

	if(var_11 == "front")
	{
		if(isdefined(param_02))
		{
			param_02 func_1AB6("locked");
		}

		if(isdefined(param_03))
		{
			param_03 func_1AB6("unlocked");
			param_03 playsound("airlock_light_on");
		}
	}
	else
	{
		if(isdefined(param_02))
		{
			param_02 func_1AB6("unlocked");
			param_02 playsound("airlock_light_on");
		}

		if(isdefined(param_03))
		{
			param_03 func_1AB6("locked");
		}
	}

	var_05 scripts\sp\_utility::func_65E1("cycling_complete");
	var_05 scripts\sp\_utility::func_65DD("cycling");
}

//Function Number: 17
func_1AAB(param_00,param_01,param_02,param_03)
{
	var_04 = level.var_1AE3[param_00];
	var_04 scripts\sp\_utility::func_65DD("cycling_complete");
	var_04 scripts\sp\_utility::func_65E1("cycling");
	var_05 = [];
	if(isdefined(param_02))
	{
		var_05 = scripts\common\utility::array_add(var_05,param_02);
	}

	if(isdefined(param_03))
	{
		var_05 = scripts\common\utility::array_add(var_05,param_03);
	}

	var_04.var_4CD5 = 1;
	scripts\common\utility::array_thread(var_05,::func_1AB1,var_04,"cycling");
	scripts\common\utility::play_sound_in_space("airlock_ext",var_04.origin);
	wait(8.408);
	var_04.var_4CD5 = 0;
	func_1AD8(param_00,0,param_02,param_03);
	var_04 scripts\sp\_utility::func_65E1("cycling_complete");
	var_04 scripts\sp\_utility::func_65DD("cycling");
}

//Function Number: 18
func_1374E(param_00)
{
	scripts\common\utility::flag_wait("airlocks_setup");
	var_01 = level.var_1AE3[param_00];
	var_01 scripts\sp\_utility::func_65E3("cycling_complete");
}

//Function Number: 19
func_1AAD(param_00)
{
	var_01 = "pressurize";
	if(!param_00)
	{
		var_01 = "depressurize";
	}

	foreach(var_03 in self.var_4CD3[var_01])
	{
		var_04 = var_03.var_762C;
		var_05 = 0;
		if(isdefined(var_03.var_50AE))
		{
			var_05 = var_03.var_50AE;
		}

		var_06 = var_03.origin;
		var_07 = rotatepointaroundvector(anglestoup(self.angles),var_06,self.angles[1]);
		var_06 = var_07 + self.origin;
		var_08 = combineangles(var_03.angles,self.angles);
		var_09 = spawnstruct();
		var_09.origin = var_06;
		var_09.angles = var_08;
		scripts\common\utility::func_C0A6(var_05,::playfx,scripts\common\utility::getfx(var_04),var_06,anglestoforward(var_08),anglestoup(var_08));
	}
}

//Function Number: 20
func_1AAA(param_00)
{
	scripts\common\utility::flag_wait("airlocks_setup");
	var_01 = level.var_1AE3[param_00];
	var_02 = ["front","back"];
	foreach(var_04 in var_02)
	{
		foreach(var_06 in var_01.var_ECCE[var_04])
		{
			var_06 setscriptablepartstate("root",13);
		}
	}
}

//Function Number: 21
func_1AD6(param_00)
{
	var_01 = ["front","back"];
	var_02 = 0.75;
	while(self.var_4CD5)
	{
		foreach(var_04 in var_01)
		{
			foreach(var_06 in self.var_ECCE[var_04][param_00])
			{
				var_06 show();
			}
		}

		wait(var_02);
		foreach(var_04 in var_01)
		{
			foreach(var_06 in self.var_ECCE[var_04][param_00])
			{
				var_06 hide();
			}
		}

		wait(var_02);
	}

	self notify("blinking_complete");
}

//Function Number: 22
func_1AD7(param_00,param_01)
{
	var_02 = param_00 / 1000 / 10;
	var_03 = 1;
	var_04 = 12;
	if(isdefined(param_01) && !param_01)
	{
		var_03 = 11;
		var_04 = 1;
	}

	var_05 = var_03;
	var_06 = ["front","back"];
	while(var_05 != var_04)
	{
		foreach(var_08 in var_06)
		{
			foreach(var_0A in self.var_ECCE[var_08])
			{
				var_0A setscriptablepartstate("root",var_05);
			}
		}

		if(isdefined(param_01) && !param_01)
		{
			var_05 = var_05 - 1;
			continue;
		}

		var_05++;
		wait(var_02);
	}
}

//Function Number: 23
func_1AB1(param_00,param_01)
{
	self endon("death");
	func_1AB6("off");
	var_02 = 0.75;
	while(param_00.var_4CD5)
	{
		func_1AB6(param_01);
		wait(var_02);
		func_1AB6("off");
		wait(var_02);
	}
}

//Function Number: 24
func_1AD8(param_00,param_01,param_02,param_03)
{
	scripts\common\utility::flag_wait("airlocks_setup");
	var_04 = level.var_1AE3[param_00];
	var_05 = "back";
	if(param_01)
	{
		var_05 = "front";
	}

	var_06 = ["front","back"];
	foreach(var_08 in var_06)
	{
		if(var_08 == var_05)
		{
			foreach(var_0A in var_04.var_ECCE[var_08])
			{
				var_0A setscriptablepartstate("root",12);
			}

			continue;
		}

		foreach(var_0A in var_04.var_ECCE[var_08])
		{
			var_0A setscriptablepartstate("root",0);
		}
	}

	if(isdefined(param_02))
	{
		param_02 func_1AB6("unlocked");
	}

	if(isdefined(param_03))
	{
		param_03 func_1AB6("locked");
	}
}

//Function Number: 25
func_1AB6(param_00)
{
	if(self.model != "sdf_door_airlock_01")
	{
		if(isdefined(self.var_4C07))
		{
			foreach(var_02 in self.var_ACD5)
			{
				var_03 = func_1AB4(self.var_4C07);
				if(isdefined(var_03))
				{
					killfxontag(scripts\common\utility::getfx(var_03),var_02,"tag_origin");
				}
			}
		}

		foreach(var_02 in self.var_ACD5)
		{
			var_03 = func_1AB4(param_00);
			if(isdefined(var_03))
			{
				playfxontag(scripts\common\utility::getfx(var_03),var_02,"tag_origin");
			}
		}
	}
	else if(param_00 != "unlocked")
	{
		if(scripts\sp\_utility::func_8C32(self.model,"tag_screen_locked"))
		{
			self method_8387("tag_screen_locked",self.model);
		}

		if(scripts\sp\_utility::func_8C32(self.model,"tag_screen_open"))
		{
			self method_8187("tag_screen_open",self.model);
		}
	}
	else
	{
		if(scripts\sp\_utility::func_8C32(self.model,"tag_screen_locked"))
		{
			self method_8187("tag_screen_locked",self.model);
		}

		if(scripts\sp\_utility::func_8C32(self.model,"tag_screen_open"))
		{
			self method_8387("tag_screen_open",self.model);
		}
	}

	self.var_4C07 = param_00;
}

//Function Number: 26
func_1AB4(param_00)
{
	if(param_00 == "unlocked")
	{
		return "vfx_airlock_light_green";
	}
	else if(param_00 == "locked")
	{
		return "vfx_airlock_light_red";
	}
	else if(param_00 == "cycling")
	{
		return "vfx_airlock_light_orange";
	}
	else if(param_00 == "error")
	{
		return undefined;
	}
	else if(param_00 == "off")
	{
		return undefined;
	}
}

//Function Number: 27
func_A852()
{
	var_00 = undefined;
	var_01 = [];
	var_02 = scripts\sp\_utility::func_7A8F();
	foreach(var_04 in var_02)
	{
		if(var_04.classname == "script_model")
		{
			if(isdefined(var_04.script_noteworthy) && var_04.script_noteworthy == "player")
			{
				self.var_D45A = 1;
				var_01["player"] = var_04;
			}
			else
			{
				if(!isdefined(var_01["ai"]))
				{
					var_01["ai"] = [];
				}

				var_01["ai"] = scripts\common\utility::array_add(var_01["ai"],var_04);
			}

			var_04 method_83D0(#animtree);
			continue;
		}

		var_00 = var_04;
	}

	self.var_454F = var_01;
	if(isdefined(var_00))
	{
		var_00 waittill("trigger");
	}

	if(isdefined(var_01["player"]))
	{
		thread func_A855();
	}

	scripts\sp\_utility::func_65E3("door_sequence_complete");
}

//Function Number: 28
func_A855()
{
	var_00 = self.var_454F;
	var_00["player"].var_1FBB = "console_plr";
	var_00["player"] lib_0E46::func_48C4("override_box_jt",undefined,undefined,undefined,5000,undefined,0);
	var_00["player"] waittill("trigger",var_01);
	var_02 = var_00["player"] func_D0A6("large_door_open_arrive");
	var_03 = [var_00["player"],var_02];
	var_00["player"] lib_0B06::func_1F2C(var_03,"large_door_open_arrive");
	scripts\sp\_utility::func_65E1("player_at_door");
	var_00["player"] thread lib_0B06::func_1EE7(var_03,"large_door_open_idle");
	scripts\sp\_utility::func_65E3("begin_opening");
	var_00["player"] notify("stop_loop");
	var_00["player"] lib_0B06::func_1F2C(var_03,"large_door_open");
	var_01 func_5990();
	var_01 unlink();
	var_02 delete();
}

//Function Number: 29
func_A854(param_00,param_01)
{
	var_02 = [param_00];
	if(isdefined(param_01))
	{
		if(param_01.size > 1)
		{
		}
		else
		{
			param_01 = param_01[0];
		}

		var_02 = scripts\common\utility::array_add(var_02,param_01);
	}

	foreach(var_06, var_04 in var_02)
	{
		var_05 = self.var_454F["ai"][var_06];
		var_05.var_1FBB = "console_ai";
		var_04.var_A93B = var_04.var_1FBB;
		var_04.var_1FBB = "main";
		var_04 scripts\sp\_utility::func_178D(::scripts\sp\_utility::func_137AA,"actor_at_door");
		thread func_A853(var_04,var_05);
	}

	if(isdefined(self.var_454F["player"]))
	{
		scripts\sp\_utility::func_178D(::scripts\sp\_utility::func_65E3,"player_at_door");
	}

	scripts\sp\_utility::func_57D5();
	scripts\sp\_utility::func_65E1("actor_at_door");
	if(isdefined(self.var_D45A))
	{
		scripts\sp\_utility::func_65E3("player_at_door");
	}

	scripts\sp\_utility::func_65E1("begin_opening");
	wait(getanimlength(param_00 scripts\sp\_utility::func_7DC1("large_door_open")));
	foreach(var_04 in var_02)
	{
		var_04.var_1FBB = var_04.var_A93B;
	}

	scripts\sp\_utility::func_65E1("door_sequence_complete");
}

//Function Number: 30
func_A853(param_00,param_01)
{
	var_02 = [param_00,param_01];
	param_01 lib_0B06::func_1F17(param_00,"large_door_open_arrive");
	param_01 lib_0B06::func_1F2C(var_02,"large_door_open_arrive");
	param_01 thread lib_0B06::func_1EE7(var_02,"large_door_open_idle");
	param_00 notify("actor_at_door");
	scripts\sp\_utility::func_65E3("begin_opening");
	param_01 notify("stop_loop");
	param_00 lib_0A1E::func_2386();
	param_01 thread lib_0B06::func_1F2C(var_02,"large_door_open");
}

//Function Number: 31
func_315D()
{
	scripts\sp\_utility::func_65E0("secondary_actors_going_through");
	scripts\sp\_utility::func_65E0("player_prying_open_door");
	thread func_3160();
}

//Function Number: 32
func_3160()
{
	var_00 = "tag_ui_back";
	if(isdefined(self.var_9027))
	{
		var_00 = self.var_9027;
	}

	self.var_9027 = var_00;
	var_01 = undefined;
	if(isdefined(self.var_901E))
	{
		var_01 = self.var_901E;
	}

	self.var_10247 = isdefined(self.var_10247);
	var_02 = undefined;
	if(isdefined(self.var_9333))
	{
		var_02 = self.var_9333;
	}

	lib_0E46::func_48C4(var_00,var_01,undefined,undefined,undefined,undefined,var_02);
	self method_84A5(180);
	lib_0E46::func_9016();
	scripts\sp\_utility::func_65E1("player_used_door");
	var_03 = func_D0A6(func_5997("intro"));
	if(isdefined(self.var_9AEF))
	{
		level.player thread scripts\sp\_utility::func_CE2F(self.var_9AEF);
	}

	level notify("buddydoor_player_intro");
	func_59DE([self,var_03],func_5997("intro"));
	level notify("buddydoor_player_idle");
	thread func_59DE([self,var_03],func_5997("idle"),1);
	scripts\sp\_utility::func_65E1("player_at_door");
	scripts\sp\_utility::func_65E3("actor_at_door");
	scripts\sp\_utility::func_65E1("begin_opening");
	var_04 = [self,var_03];
	foreach(var_06 in self.var_1684)
	{
		if(!var_06 func_1FA3(func_5997("pull")))
		{
			continue;
		}

		var_04 = scripts\common\utility::array_add(var_04,var_06);
	}

	level notify("buddydoor_player_pry_open");
	func_3161(var_04);
	scripts\sp\_utility::func_65E1("door_opened");
	level notify("buddydoor_player_outro");
	self notify("buddydoor_outro");
	if(isdefined(self.var_427C))
	{
		level.player thread scripts\sp\_utility::func_CE2F(self.var_427C);
	}

	var_04 = [self,var_03];
	func_59DE(var_04,func_5997("outro"));
	level.player func_5990();
	level.player unlink();
	var_03 delete();
	scripts\sp\_utility::func_65E1("door_sequence_complete");
	level notify("buddydoor_player_done");
}

//Function Number: 33
func_3161(param_00)
{
	level.player notifyonplayercommand("bash_pressed","+usereload");
	level.player notifyonplayercommand("bash_pressed","+activate");
	thread func_315B();
	if(!isdefined(self.var_C633))
	{
		self.var_C633 = 1;
	}

	var_01 = getanimlength(param_00[0] scripts\sp\_utility::func_7DC1(func_5997("pull")));
	var_02 = var_01 / self.var_C633;
	if(self.var_10247)
	{
		thread func_2643();
	}

	for(;;)
	{
		level.player waittill("bash_pressed");
		level notify("buddydoor_pry_open_start");
		scripts\sp\_utility::func_65E1("player_prying_open_door");
		level.player.var_2704 = 1;
		thread func_3163();
		var_03 = func_315A(0.5,1);
		if(isdefined(var_03))
		{
			continue;
		}

		scripts\common\utility::array_thread(param_00,::func_59F3,self);
		foreach(var_05 in param_00)
		{
			var_05 method_83A1();
		}

		lib_0B06::func_1EC1(param_00,func_5997("pull"));
		foreach(var_05 in param_00)
		{
			if(isai(var_05))
			{
				var_05 lib_0A1E::func_2307(::func_3162,::lib_0A1E::func_2385);
				continue;
			}

			var_08 = var_05 scripts\sp\_utility::func_7DC1(func_5997("pull"));
			var_05 method_82A2(var_08,1,0.2,self.var_C633);
		}

		thread func_3159(var_02);
		var_03 = func_315A(var_02);
		if(!isdefined(var_03))
		{
			level notify("buddydoor_pry_open_success");
			break;
		}

		level notify("buddydoor_pry_open_failed");
		if(isdefined(self.var_C62B))
		{
			level.player thread scripts\sp\_utility::func_CE2F(self.var_C62B);
		}

		var_0A = 5;
		var_0B = param_00[0] method_8102(param_00[0] scripts\sp\_utility::func_7DC1(func_5997("pull")));
		var_0C = var_01 * var_0B;
		var_0C = var_0C / var_0A;
		foreach(var_05 in param_00)
		{
			var_05 method_82B1(var_05 scripts\sp\_utility::func_7DC1(func_5997("pull")),var_0A * -1);
		}

		wait(var_0C);
		level.player playrumbleonentity("damage_heavy");
		self notify("stop_pry_anim");
		scripts\sp\_utility::func_65DD("player_prying_open_door");
		level.player.var_2704 = 0;
		thread func_59DE(param_00,func_5997("idle"),1);
	}

	if(isdefined(self.var_C62F))
	{
		scripts\common\utility::func_11018(self.var_C62F);
	}

	if(isdefined(self.var_C634))
	{
		thread scripts\sp\_utility::func_CE2F(self.var_C634);
	}
}

//Function Number: 34
func_2643()
{
	while(!scripts\sp\_utility::func_65DB("door_opened"))
	{
		level.player notify("bash_pressed");
		wait(0.05);
	}
}

//Function Number: 35
func_3162()
{
	self endon("stop_pry_anim");
	self endon("buddydoor_pull_complete");
	var_00 = scripts\sp\_utility::func_7DC1(self.var_130FF func_5997("pull"));
	var_01 = lib_0A1E::func_2356("Knobs","body");
	self method_806F(var_01,0);
	self method_8016("noclip");
	self method_82A2(var_00,1,0.2,self.var_130FF.var_C633);
	level waittill("ever");
}

//Function Number: 36
func_3163()
{
	self endon("buddydoor_pull_complete");
	if(isdefined(self.var_C625))
	{
		self playsound(self.var_C625);
	}

	wait(0.3);
	if(isdefined(self.var_C62F))
	{
		thread scripts\common\utility::func_CD7F(self.var_C62F);
	}

	self waittill("buddydoor_pull_failed");
	if(isdefined(self.var_C62F))
	{
		thread scripts\common\utility::func_11018(self.var_C62F);
	}

	if(isdefined(self.var_C625))
	{
		self method_83AD();
	}
}

//Function Number: 37
func_315A(param_00,param_01)
{
	self endon("buddydoor_pull_complete");
	if(!isdefined(param_01))
	{
		thread func_315C();
	}

	param_00 = param_00 * 1000;
	var_02 = gettime();
	for(;;)
	{
		if(gettime() - var_02 > param_00)
		{
			return;
		}

		var_03 = level.player scripts\common\utility::waittill_notify_or_timeout_return("bash_pressed",0.4);
		if(isdefined(var_03))
		{
			break;
		}
	}

	self notify("buddydoor_pull_failed");
	return 1;
}

//Function Number: 38
func_315C()
{
	self endon("buddydoor_pull_complete");
	self endon("buddydoor_pull_failed");
	for(;;)
	{
		level.player playrumbleonentity("damage_light");
		earthquake(0.15,0.1,level.player.origin,5000);
		wait(0.05);
	}
}

//Function Number: 39
func_315B()
{
	if(self.var_10247)
	{
		return;
	}

	var_00 = scripts\common\utility::spawn_tag_origin();
	var_01 = "left_door_01";
	if(isdefined(self.var_28B6))
	{
		var_01 = self.var_28B6;
	}

	var_00.origin = self gettagorigin(var_01);
	var_00 linkto(self,var_01);
	var_00 lib_0E46::func_48C4(undefined,undefined,"",undefined,1000,1000,1,1);
	self waittill("buddydoor_pull_complete");
	var_00 lib_0E46::func_DFE3();
}

//Function Number: 40
func_3159(param_00)
{
	self endon("buddydoor_pull_failed");
	wait(param_00);
	self notify("buddydoor_pull_complete");
}

//Function Number: 41
func_3156(param_00)
{
	foreach(var_02 in param_00)
	{
		var_02.var_130FF = self;
		var_03 = var_02.var_1FBB + "_door_sequence_complete";
		var_04 = var_02.var_1FBB + "_at_door";
		scripts\sp\_utility::func_65E0(var_04);
		scripts\sp\_utility::func_65E0(var_03);
	}

	scripts\common\utility::array_thread(param_00,::func_598C);
	var_06 = [];
	foreach(var_02 in param_00)
	{
		if(!var_02 func_1FA3(func_5997("intro")))
		{
			continue;
		}

		var_06 = scripts\common\utility::array_add(var_06,var_02);
	}

	scripts\common\utility::array_thread(var_06,::func_3157,self,var_06);
	self waittill("buddydoor_outro");
	scripts\common\utility::array_thread(param_00,::func_59F3,self);
	foreach(var_02 in param_00)
	{
		thread func_3158(var_02);
	}
}

//Function Number: 42
func_3157(param_00,param_01)
{
	level notify("buddydoor_actors_intro");
	param_00 thread func_1162A(self);
	if(param_00 scripts\sp\_utility::func_65DB("skip_reach_on_use"))
	{
		func_E9FF(param_00);
	}
	else if(!param_00 scripts\sp\_utility::func_65DB("no_anim_reach"))
	{
		param_00 lib_0B06::func_1F17(self,param_00 func_5997("intro"));
	}

	if(param_00 scripts\sp\_utility::func_65DB("skip_reach_on_use"))
	{
		func_E9FE(param_00);
		param_00 thread func_59DE(self,param_00 func_5997("idle"),1);
	}
	else
	{
		param_00 func_59DE(self,param_00 func_5997("intro"));
		param_00 thread func_59DE(self,param_00 func_5997("idle"),1);
	}

	self.var_2412 = 1;
	param_00 scripts\sp\_utility::func_65E1(self.var_1FBB + "_at_door");
	foreach(var_03 in param_01)
	{
		if(!isdefined(var_03.var_2412))
		{
			return;
		}
	}

	param_00 scripts\sp\_utility::func_65E1("actor_at_door");
}

//Function Number: 43
func_E9FF(param_00)
{
	level.player endon("player_attached_to_door");
	param_00 lib_0B06::func_1F17(self,param_00 func_5997("intro"));
}

//Function Number: 44
func_E9FE(param_00)
{
	level.player endon("player_attached_to_door");
	param_00 func_59DE(self,param_00 func_5997("intro"));
}

//Function Number: 45
func_3158(param_00)
{
	param_00 endon("death");
	self endon("death");
	level notify("buddydoor_actors_outro");
	thread func_59DE(param_00,func_5997("outro"));
	param_00 waittill(func_5997("outro"));
	param_00.var_130FF = undefined;
	param_00.var_2412 = undefined;
	param_00 func_598F();
	var_01 = param_00.var_1FBB + "_door_sequence_complete";
	scripts\sp\_utility::func_65E1(var_01);
	level notify("buddydoor_actors_outro_done");
}

//Function Number: 46
func_21E0()
{
	var_00 = scripts\sp\_utility::func_7A97();
	if(isdefined(var_00))
	{
		foreach(var_02 in var_00)
		{
			if(isdefined(var_02.var_336) && var_02.var_336 == "loot_hint_struct")
			{
				self.var_9026 = var_02;
			}
		}
	}

	self.var_4381 = scripts\sp\_utility::func_7A8E();
	if(!isdefined(level.var_21E2))
	{
		level.var_21E2 = 0;
	}

	thread func_21E9(level.var_21E2);
	level.var_21E2++;
}

//Function Number: 47
func_21E9(param_00)
{
	self endon("stop_door");
	if(isdefined(level.var_21E4))
	{
		self [[ level.var_21E4 ]]();
	}

	self.var_9026 lib_0E46::func_48C4();
	self.var_9026 lib_0E46::func_9016();
	level notify("armory_door_start_open");
	scripts\sp\_utility::func_65E1("player_at_door");
	scripts\sp\_utility::func_65E1("begin_opening");
	self notify("stop_loop");
	thread func_21E5();
	wait(0.7);
	thread scripts\sp\_utility::func_CE2F("armory_door_open");
	scripts\sp\_armoury::func_489F(param_00);
	if(!lib_0A2F::func_D9ED(param_00))
	{
		lib_0A2F::func_DA49(param_00,1);
		scripts\sp\_utility::func_9145("fluff_messages_loot_room");
	}
}

//Function Number: 48
func_21E5()
{
	var_00 = self;
	var_00.var_1FBB = "loot_door";
	if(isdefined(self.var_4386))
	{
		self.var_4381 linkto(self,self.var_4386);
	}
	else
	{
		self.var_4381 linkto(self,"j_handle");
	}

	if(scripts\common\utility::istrue(self.var_72D1))
	{
		self notify("stop_door");
		lib_0E46::func_DFE3();
		self notify("stop_loop");
		var_00 lib_0B06::func_1EE0(var_00,"open_loot_door");
		self.var_4381 connectpaths();
		self.var_245 = "open";
		if(scripts\sp\_utility::func_8C32(self.model,"tag_locked"))
		{
			self method_8187("tag_locked",self.model);
		}

		if(scripts\sp\_utility::func_8C32(self.model,"tag_unlocked"))
		{
			self method_8387("tag_unlocked",self.model);
		}
	}
	else
	{
		var_01 = var_00 func_FA17("open_loot_door");
		var_00 thread lib_0B06::func_1F35(var_01,"open_loot_door","tag_origin");
		var_00 lib_0B06::func_1F35(var_00,"open_loot_door","tag_origin");
		self.var_4381 connectpaths();
		var_01 delete();
		level.player func_5990();
		level.player unlink();
		self.var_245 = "open";
	}

	level notify("armory_door_open");
	if(isdefined(self.var_21E6))
	{
		self thread [[ self.var_21E6 ]]();
	}
}

//Function Number: 49
func_9530(param_00)
{
	var_01 = scripts\common\utility::getstructarray("door_peek_struct","script_noteworthy");
	if(var_01.size > 0)
	{
		foreach(var_03 in var_01)
		{
			if(var_03.var_336 == param_00)
			{
				var_03 thread func_13684(var_03.var_336);
			}
		}
	}
}

//Function Number: 50
func_13684(param_00)
{
	var_01 = self;
	level waittill(param_00 + "door_peek_start");
	var_01 thread scripts\sp\_armoury::func_489F(0);
}

//Function Number: 51
func_FA17(param_00)
{
	if(isdefined(level.var_E982) && level.var_E982 == 1)
	{
		var_01 = scripts\sp\_utility::func_10639("player_rig_disguise");
	}
	else
	{
		var_01 = scripts\sp\_utility::func_10639("player_arms");
		var_02 = level.player method_84C6("currentViewModel");
		if(isdefined(var_02))
		{
			var_01 setmodel(var_02);
		}
	}

	var_01 hide();
	level.player method_80AA();
	level.player func_598D();
	var_03 = [var_01,self];
	thread lib_0B06::func_1EC3(var_01,param_00);
	var_04 = 0.4;
	level.player playerlinktoblend(var_01,"tag_player",var_04,0.15,0.15);
	wait(var_04);
	var_01 show();
	return var_01;
}

//Function Number: 52
func_3232()
{
	var_00 = scripts\sp\_utility::func_7A8F();
	scripts\common\utility::func_227D(var_00,::linkto,self,"j_hinge2");
	foreach(var_02 in var_00)
	{
		if(isdefined(var_02.script_noteworthy) && var_02.script_noteworthy == "player_clip")
		{
			continue;
		}

		self.var_C969 = var_02;
	}

	if(isdefined(self.var_EF20) && self.var_EF20 == "notplayer")
	{
		return;
	}

	lib_0E46::func_48C4(undefined,(20,-50,55));
	self waittill("trigger",var_04);
	scripts\sp\_utility::func_65E1("player_at_door");
	self.var_C969 connectpaths();
	var_05 = scripts\common\utility::spawn_tag_origin(self.origin,self.angles + (0,180,0));
	var_06 = var_05 func_D0A6("bulkhead_open");
	scripts\sp\_utility::func_65E1("begin_opening");
	var_07 = [self,var_06];
	if(soundexists("airlock_exit_door_open"))
	{
		level.player thread scripts\sp\_utility::func_CE2F("airlock_exit_door_open");
	}

	var_05 lib_0B06::func_1F2C(var_07,"bulkhead_open");
	var_05 thread lib_0B06::func_1F35(self,"bulkhead_open");
	var_05 lib_0B06::func_1F2A([self],"bulkhead_open",0.99);
	var_05 lib_0B06::func_1F27([self],"bulkhead_open",0);
	level.player func_5990();
	level.player unlink();
	var_06 delete();
	scripts\sp\_utility::func_65E1("door_sequence_complete");
}

//Function Number: 53
func_5982(param_00,param_01,param_02)
{
	var_03 = self.var_5A18 + "_";
	var_04 = [[ param_00 ]]();
	var_05 = [[ param_01 ]]();
	var_06 = [[ param_02 ]]();
	var_07 = [var_04,var_05,var_06];
	foreach(var_09 in var_07)
	{
		foreach(var_12, var_0B in var_09)
		{
			var_0C = 0;
			foreach(var_0E in var_0B)
			{
				var_0F = getarraykeys(var_0B)[var_0C];
				var_10 = var_03 + var_0F;
				if(var_0F == "idle")
				{
					level.var_EC85[var_12][var_10][0] = var_0B[var_0F];
				}
				else
				{
					level.var_EC85[var_12][var_10] = var_0B[var_0F];
				}

				var_0C++;
			}
		}
	}
}

//Function Number: 54
func_59EB(param_00,param_01,param_02,param_03,param_04)
{
	self.var_9AEF = param_00;
	self.var_C625 = param_01;
	self.var_C62F = param_02;
	self.var_C62B = param_03;
	self.var_C634 = param_04;
}

//Function Number: 55
func_598C()
{
	if(isdefined(self.var_598E))
	{
		scripts\sp\_utility::func_61C7();
		self.var_598E = undefined;
	}
}

//Function Number: 56
func_598F()
{
	if(isdefined(self.var_EDAD))
	{
		self.var_598E = 1;
	}
}

//Function Number: 57
func_D0A6(param_00)
{
	var_01 = scripts\sp\_utility::func_10639("door_player_rig");
	if(var_01.model == "viewmodel_base_viewhands_iw7")
	{
		var_02 = level.player method_84C6("currentViewModel");
		if(isdefined(var_02))
		{
			var_01 setmodel(var_02);
		}
	}

	var_01 hide();
	level.player.var_59E1 = var_01;
	var_03 = [var_01,self];
	foreach(var_05 in var_03)
	{
		if(!isdefined(var_05.var_1FBB))
		{
			continue;
		}

		if(!var_05 func_1FA3(param_00))
		{
			continue;
		}

		thread lib_0B06::func_1EC3(var_05,param_00);
	}

	var_07 = level.player scripts\common\utility::spawn_tag_origin();
	var_07.origin = level.player.origin;
	var_07.angles = level.player getplayerangles();
	level.player playerlinkto(var_07,"tag_origin",1,0,0,0,0,0);
	var_08 = 0.45;
	if(isdefined(self.var_8483))
	{
		var_08 = self.var_8483;
	}

	if(length(level.player getvelocity()) > 200)
	{
		var_08 = 0.25;
	}

	var_09 = var_08 / 4;
	var_0A = var_09;
	level.player func_598D();
	wait(0.3);
	level.player playerlinktoblend(var_01,"tag_player",var_08,var_09,var_0A);
	wait(var_08);
	level.player notify("player_attached_to_door");
	level.player playerlinktodelta(var_01,"tag_player",1,5,5,5,5,1);
	level.player method_8367(30,30,30,30);
	var_01 show();
	var_07 delete();
	return var_01;
}

//Function Number: 58
func_1162A(param_00)
{
	param_00 endon("anim_reach_complete");
	scripts\sp\_utility::func_65E3("player_at_door");
	if(isdefined(self.var_D83A))
	{
		var_01 = self.var_D83A;
	}
	else
	{
		var_01 = 200;
	}

	if(distance(param_00.origin,self.origin) >= 200)
	{
		var_02 = undefined;
		if(isdefined(self.var_D83B))
		{
			var_02 = self.var_D83B;
		}
		else
		{
			var_03 = anglestoforward(self.angles);
			var_03 = var_03 * -1;
			var_02 = self.origin + var_03 * var_01;
		}

		param_00 method_80F1(var_02,self.angles,10000);
	}
}

//Function Number: 59
func_598D()
{
	level.player method_84FE();
	level.player method_80AA();
	level.player freezecontrols(1);
	level.player setstance("stand");
	level.player scripts\common\utility::func_1C60(0);
	level.player scripts\common\utility::func_1C40(0);
	level.player method_8012(0);
	level.player method_80D1();
}

//Function Number: 60
func_5990()
{
	level.player enableweapons();
	level.player method_8012(1);
	level.player freezecontrols(0);
	level.player scripts\common\utility::func_1C60(1);
	level.player scripts\common\utility::func_1C40(1);
	level.player method_80A1();
	level.player method_84FD();
}

//Function Number: 61
func_5997(param_00)
{
	return self.var_5A18 + "_" + param_00;
}

//Function Number: 62
func_59DE(param_00,param_01,param_02)
{
	if(!isarray(param_00))
	{
		param_00 = [param_00];
	}

	var_03 = [];
	foreach(var_05 in param_00)
	{
		if(!var_05 func_1FA3(param_01))
		{
			continue;
		}

		if(isdefined(param_02))
		{
			thread lib_0B06::func_1EEA(var_05,param_01,"stop_loop_" + var_05.var_1FBB);
		}
		else
		{
			thread func_5981(var_05,param_01);
		}

		var_03[var_03.size] = var_05;
	}

	if(!isdefined(param_02) && var_03.size > 0)
	{
		foreach(var_05 in var_03)
		{
			var_05 scripts\sp\_utility::func_178D(::scripts\sp\_utility::func_137AA,param_01);
		}

		scripts\sp\_utility::func_57D5();
	}
}

//Function Number: 63
func_5981(param_00,param_01)
{
	lib_0B06::func_1F35(param_00,param_01);
	param_00 notify(param_01);
}

//Function Number: 64
func_59F3(param_00)
{
	param_00 notify("stop_loop_" + self.var_1FBB);
}

//Function Number: 65
func_1FA3(param_00)
{
	var_01 = level.var_EC85[self.var_1FBB][param_00];
	if(isdefined(var_01))
	{
		return 1;
	}

	return 0;
}

//Function Number: 66
func_5983()
{
	level.var_EC85["door"]["airlock_open_player"] = %airlock_open_door;
	level.var_EC85["door"]["bulkhead_open"] = %moon_2_31_secure_hangar_door;
	level.var_EC85["door"]["large_ally_door"] = %europa_armory_door_metal_bulkhead_double_01_open;
	level.var_EC85["console_plr"]["large_door_open_arrive"] = %europa_armory_override_l_plr_intro;
	level.var_EC85["console_plr"]["large_door_open_idle"][0] = %europa_armory_override_l_plr_idle;
	level.var_EC85["console_plr"]["large_door_open"] = %europa_armory_override_l_plr_pull_handle;
	level.var_EC85["console_ai"]["large_door_open_arrive"] = %europa_armory_override_r_str_intro;
	level.var_EC85["console_ai"]["large_door_open_idle"][0] = %europa_armory_override_r_str_idle;
	level.var_EC85["console_ai"]["large_door_open"] = %europa_armory_override_r_str_pull_handle;
	func_599C();
	func_59DF();
}

//Function Number: 67
func_599C()
{
	level.var_EC85["main"]["large_door_open_arrive"] = %europa_armory_str_override_r_intro;
	level.var_EC85["main"]["large_door_open_idle"][0] = %europa_armory_str_override_r_idle;
	level.var_EC85["main"]["large_door_open"] = %europa_armory_str_override_r_pull_handle;
}

//Function Number: 68
func_59DF()
{
	level.var_EC87["door_player_rig"] = #animtree;
	level.var_EC8C["door_player_rig"] = "viewmodel_base_viewhands_iw7";
	level.var_EC85["door_player_rig"]["airlock_open_player"] = %airlock_open_player;
	level.var_EC85["door_player_rig"]["large_door_open_arrive"] = %europa_armory_plr_override_l_intro;
	level.var_EC85["door_player_rig"]["large_door_open_idle"][0] = %europa_armory_plr_override_l_idle;
	level.var_EC85["door_player_rig"]["large_door_open"] = %europa_armory_plr_override_l_pull_handle;
	level.var_EC85["door_player_rig"]["bulkhead_open"] = %moon_2_31_secure_hangar_plr;
}

//Function Number: 69
func_5A4B()
{
	if(!isdefined(level.var_5A2B))
	{
		level.var_5A2B = spawnstruct();
	}

	return level.var_5A2B;
}