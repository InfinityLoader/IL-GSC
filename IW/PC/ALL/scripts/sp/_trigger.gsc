/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\sp\_trigger.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 87
 * Decompile Time: 3896 ms
 * Timestamp: 10/27/2023 12:25:03 AM
*******************************************************************/

//Function Number: 1
func_7AA4()
{
	var_00 = [];
	var_00["trigger_multiple_nobloodpool"] = ::func_12777;
	var_00["trigger_multiple_flag_set"] = ::func_1273F;
	var_00["trigger_multiple_flag_clear"] = ::func_1273D;
	var_00["trigger_multiple_sun_off"] = ::func_1279E;
	var_00["trigger_multiple_sun_on"] = ::func_1279F;
	var_00["trigger_use_flag_set"] = ::func_1273F;
	var_00["trigger_use_flag_clear"] = ::func_1273D;
	var_00["trigger_multiple_flag_set_touching"] = ::func_12744;
	var_00["trigger_multiple_flag_lookat"] = ::func_12760;
	var_00["trigger_multiple_flag_looking"] = ::func_12762;
	var_00["trigger_multiple_no_prone"] = ::func_12776;
	var_00["trigger_multiple_no_crouch_or_prone"] = ::func_12775;
	var_00["trigger_multiple_compass"] = ::func_12769;
	var_00["trigger_multiple_fx_volume"] = ::func_1276E;
	var_00["trigger_multiple_kleenex"] = ::func_12770;
	var_00["trigger_multiple_light_sunshadow"] = ::scripts\sp\_lights::func_11203;
	var_00["trigger_multiple_jackal_boundary_autoturn"] = ::func_12759;
	var_00["trigger_multiple_jackal_boundary_warning"] = ::func_1275B;
	var_00["trigger_multiple_jackal_boundary_push"] = ::func_1275A;
	var_00["trigger_multiple_jackal_speed_touching"] = ::func_1275C;
	var_00["trigger_multiple_landingzone"] = ::func_1275E;
	var_00["trigger_multiple_arbitrary_up"] = ::func_12723;
	var_00["trigger_multiple_spacejump"] = ::func_12794;
	if(!lib_0B79::func_9C4B())
	{
		var_00["trigger_multiple_autosave"] = ::scripts\sp\_autosave::func_12724;
		var_00["trigger_multiple_spawn"] = ::lib_0B77::func_12797;
		var_00["trigger_multiple_spawn_reinforcement"] = ::lib_0B77::func_12798;
	}

	var_00["trigger_multiple_slide"] = ::func_12792;
	var_00["trigger_multiple_depthoffield"] = ::func_1276A;
	var_00["trigger_multiple_tessellationcutoff"] = ::func_12772;
	var_00["trigger_damage_player_flag_set"] = ::func_1272F;
	var_00["trigger_multiple_sunflare"] = ::func_12771;
	var_00["trigger_multiple_glass_break"] = ::func_1274B;
	var_00["trigger_radius_glass_break"] = ::func_1274B;
	var_00["trigger_multiple_friendly_respawn"] = ::func_12747;
	var_00["trigger_multiple_friendly_stop_respawn"] = ::func_12748;
	var_00["trigger_multiple_physics"] = ::func_1277E;
	var_00["trigger_multiple_fx_watersheeting"] = ::func_1276F;
	var_00["trigger_multiple_fakeactor_move"] = ::lib_0B2B::func_12735;
	var_00["trigger_multiple_fakeactor_node_disable"] = ::lib_0B2B::func_12736;
	var_00["trigger_multiple_fakeactor_node_enable"] = ::lib_0B2B::func_12738;
	var_00["trigger_multiple_fakeactor_node_disablegroup"] = ::lib_0B2B::func_12737;
	var_00["trigger_multiple_fakeactor_node_enablegroup"] = ::lib_0B2B::func_12739;
	var_00["trigger_multiple_fakeactor_node_passthrough"] = ::lib_0B2B::func_1273B;
	var_00["trigger_multiple_fakeactor_node_lock"] = ::lib_0B2B::func_1273A;
	var_00["trigger_multiple_geo_mover"] = ::lib_0B36::func_12764;
	var_00["trigger_multiple_transient"] = ::func_12773;
	var_00["trigger_multiple_fire"] = ::func_1273C;
	var_00["trigger_radius_fire"] = ::func_1273C;
	return var_00;
}

//Function Number: 2
func_1276F(param_00)
{
	var_01 = 3;
	if(isdefined(param_00.var_ED75))
	{
		var_01 = param_00.var_ED75;
	}

	for(;;)
	{
		param_00 waittill("trigger",var_02);
		if(isplayer(var_02))
		{
			var_02 method_836F(1,var_01);
			wait(var_01 * 0.2);
		}
	}
}

//Function Number: 3
func_7AA5()
{
	var_00 = [];
	var_00["friendly_mgTurret"] = ::lib_0B77::func_73D9;
	if(!lib_0B79::func_9C4B())
	{
		var_00["camper_spawner"] = ::lib_0B77::func_37EC;
		var_00["flood_spawner"] = ::lib_0B77::func_6F5D;
		var_00["trigger_spawner"] = ::lib_0B77::func_12797;
		var_00["trigger_autosave"] = ::scripts\sp\_autosave::func_12724;
		var_00["trigger_spawngroup"] = ::func_1279A;
		var_00["trigger_vehicle_spline_spawn"] = ::func_127AC;
		var_00["trigger_vehicle_spawn"] = ::lib_0B77::func_12797;
		var_00["random_spawn"] = ::lib_0B77::func_DC9B;
	}

	var_00["autosave_now"] = ::scripts\sp\_autosave::func_2671;
	var_00["trigger_autosave_tactical"] = ::scripts\sp\_autosave::func_12727;
	var_00["trigger_autosave_stealth"] = ::scripts\sp\_autosave::func_12726;
	var_00["trigger_unlock"] = ::func_127A8;
	var_00["trigger_lookat"] = ::func_12760;
	var_00["trigger_looking"] = ::func_12762;
	var_00["trigger_cansee"] = ::func_1272B;
	var_00["flag_set"] = ::func_1273F;
	var_00["flag_set_player"] = ::func_12741;
	var_00["flag_unset"] = ::func_1273D;
	var_00["flag_clear"] = ::func_1273D;
	var_00["friendly_respawn_trigger"] = ::func_12747;
	var_00["radio_trigger"] = ::func_12787;
	var_00["trigger_ignore"] = ::func_12752;
	var_00["trigger_pacifist"] = ::func_1277C;
	var_00["trigger_delete"] = ::func_127A6;
	var_00["trigger_delete_on_touch"] = ::func_12731;
	var_00["trigger_off"] = ::func_127A6;
	var_00["trigger_outdoor"] = ::lib_0B77::func_C75A;
	var_00["trigger_indoor"] = ::lib_0B77::func_9409;
	var_00["trigger_hint"] = ::func_1274E;
	var_00["trigger_grenade_at_player"] = ::func_127A5;
	var_00["flag_on_cleared"] = ::func_1273E;
	var_00["flag_set_touching"] = ::func_12744;
	var_00["delete_link_chain"] = ::func_12730;
	var_00["trigger_slide"] = ::func_12792;
	var_00["trigger_dooropen"] = ::func_12734;
	var_00["stealth_shadow"] = ::func_1279C;
	var_00["geo_mover"] = ::lib_0B36::func_12764;
	var_00["no_crouch_or_prone"] = ::func_12775;
	var_00["no_prone"] = ::func_12776;
	return var_00;
}

//Function Number: 4
func_9726()
{
	scripts\sp\_colors::func_957F();
	scripts\sp\_audio::func_9539();
	scripts\sp\_utility::func_228A(getentarray("trigger_multiple_softlanding","classname"));
	var_00 = func_7AA4();
	var_01 = func_7AA5();
	foreach(var_05, var_03 in var_00)
	{
		var_04 = getentarray(var_05,"classname");
		scripts\common\utility::func_22A1(var_04,var_03);
	}

	var_06 = getentarray("trigger_multiple","classname");
	var_07 = getentarray("trigger_radius","classname");
	var_04 = scripts\sp\_utility::func_22A2(var_06,var_07);
	var_08 = getentarray("trigger_disk","classname");
	var_04 = scripts\sp\_utility::func_22A2(var_04,var_08);
	var_09 = getentarray("trigger_once","classname");
	var_04 = scripts\sp\_utility::func_22A2(var_04,var_09);
	if(!lib_0B79::func_9C4B())
	{
		for(var_0A = 0;var_0A < var_04.size;var_0A++)
		{
			if(var_04[var_0A].var_2AF & 32)
			{
				thread lib_0B77::func_12797(var_04[var_0A]);
			}
		}
	}

	var_0B = ["trigger_multiple","trigger_once","trigger_use","trigger_radius","trigger_lookat","trigger_disk","trigger_damage"];
	foreach(var_0D in var_0B)
	{
		var_04 = getentarray(var_0D,"code_classname");
		foreach(var_0F in var_04)
		{
			if(isdefined(var_0F.var_ED9F))
			{
				level thread func_1278F(var_0F);
			}

			if(isdefined(var_0F.var_ED9D))
			{
				level thread func_1278E(var_0F);
			}

			if(isdefined(var_0F.var_ED0E) || isdefined(var_0F.var_ED0D))
			{
				level thread scripts\sp\_autosave::func_268B(var_0F);
			}

			if(isdefined(var_0F.var_EE17))
			{
				level thread scripts\sp\_mgturret::func_B6BE(var_0F);
			}

			if(isdefined(var_0F.var_EDF7))
			{
				level thread lib_0B77::func_A617(var_0F);
			}

			if(isdefined(var_0F.var_EDF5))
			{
				level thread scripts\sp\_vehicle_code::func_A629(var_0F);
			}

			if(isdefined(var_0F.var_ED77))
			{
				level thread lib_0B77::func_61BD(var_0F);
			}

			if(isdefined(var_0F.var_EE89))
			{
				var_0F.var_ED84 = var_0F.var_EE89;
			}

			if(isdefined(var_0F.var_ED84))
			{
				level thread func_69AA(var_0F);
			}

			if(isdefined(var_0F.var_EEEF))
			{
				level thread func_12780(var_0F);
			}

			if(isdefined(var_0F.var_ED18))
			{
				level thread func_12729(var_0F);
			}

			if(isdefined(var_0F.var_EEEE))
			{
				var_0F thread func_1274C();
			}

			if(isdefined(var_0F.var_EE90))
			{
				level thread lib_0B77::func_DC8F(var_0F);
			}

			if(isdefined(var_0F.var_336))
			{
				var_10 = var_0F.var_336;
				if(isdefined(var_01[var_10]))
				{
					level thread [[ var_01[var_10] ]](var_0F);
				}
			}
		}
	}
}

//Function Number: 5
func_1272E(param_00)
{
	var_01 = 1;
	if(var_01)
	{
		param_00 delete();
	}
}

//Function Number: 6
func_4984()
{
}

//Function Number: 7
func_9CEA()
{
	if(getdvar("createfx") != "")
	{
		return 1;
	}

	if(getdvarint("scr_art_tweak") > 0)
	{
		return 1;
	}

	if(isdefined(level.var_10CDA) && level.var_10CDA == "no_game")
	{
		return 1;
	}

	return 0;
}

//Function Number: 8
func_12773(param_00)
{
	var_02 = undefined;
	var_03 = undefined;
	if(isdefined(param_00.var_EEE7))
	{
		var_02 = strtok(param_00.var_EEE7," ");
	}

	if(isdefined(param_00.var_EEE8))
	{
		var_03 = strtok(param_00.var_EEE8," ");
	}

	if(isdefined(var_02))
	{
		foreach(var_05 in var_02)
		{
			if(!scripts\common\utility::func_6E34(var_05 + "_loaded"))
			{
				scripts\common\utility::flag_init(var_05 + "_loaded");
			}
		}
	}

	if(isdefined(var_03))
	{
		foreach(var_05 in var_03)
		{
			if(!scripts\common\utility::func_6E34(var_05 + "_loaded"))
			{
				scripts\common\utility::flag_init(var_05 + "_loaded");
			}
		}
	}

	for(;;)
	{
		param_00 waittill("trigger");
		if(isdefined(var_03))
		{
			scripts\sp\_utility::func_12651(var_03);
		}

		if(isdefined(var_02))
		{
			scripts\sp\_utility::func_12643(var_02);
		}
	}
}

//Function Number: 9
func_1272F(param_00)
{
	var_01 = param_00 scripts\sp\_utility::func_7D1E();
	if(!isdefined(level.flag[var_01]))
	{
		scripts\common\utility::flag_init(var_01);
	}

	for(;;)
	{
		param_00 waittill("trigger",var_02);
		if(!isalive(var_02))
		{
			continue;
		}

		if(!isplayer(var_02))
		{
			continue;
		}

		param_00 scripts\sp\_utility::script_delay();
		scripts\common\utility::flag_set(var_01,var_02);
	}
}

//Function Number: 10
func_1273D(param_00)
{
	var_01 = param_00 scripts\sp\_utility::func_7D1E();
	if(!isdefined(level.flag[var_01]))
	{
		scripts\common\utility::flag_init(var_01);
	}

	for(;;)
	{
		param_00 waittill("trigger");
		param_00 scripts\sp\_utility::script_delay();
		scripts\common\utility::func_6E2A(var_01);
	}
}

//Function Number: 11
func_1273E(param_00)
{
	var_01 = param_00 scripts\sp\_utility::func_7D1E();
	if(!isdefined(level.flag[var_01]))
	{
		scripts\common\utility::flag_init(var_01);
	}

	for(;;)
	{
		param_00 waittill("trigger");
		wait(1);
		if(param_00 func_733E())
		{
			continue;
		}

		break;
	}

	scripts\common\utility::flag_set(var_01);
}

//Function Number: 12
func_733E()
{
	var_00 = function_0072("bad_guys");
	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		var_02 = var_00[var_01];
		if(!isalive(var_02))
		{
			continue;
		}

		if(var_02 istouching(self))
		{
			return 1;
		}

		wait(0.1);
	}

	var_00 = function_0072("bad_guys");
	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		var_02 = var_00[var_01];
		if(var_02 istouching(self))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 13
func_1273F(param_00)
{
	var_01 = param_00 scripts\sp\_utility::func_7D1E();
	if(!isdefined(level.flag[var_01]))
	{
		scripts\common\utility::flag_init(var_01);
	}

	for(;;)
	{
		param_00 waittill("trigger",var_02);
		param_00 scripts\sp\_utility::script_delay();
		scripts\common\utility::flag_set(var_01,var_02);
		if(!isdefined(param_00))
		{
			break;
		}
	}
}

//Function Number: 14
func_12747(param_00)
{
	param_00 endon("death");
	var_01 = getent(param_00.target,"targetname");
	var_02 = undefined;
	if(isdefined(var_01))
	{
		var_02 = var_01.origin;
		var_01 delete();
	}
	else
	{
		var_01 = scripts\common\utility::getstruct(param_00.target,"targetname");
		var_02 = var_01.origin;
	}

	for(;;)
	{
		param_00 waittill("trigger");
		level.var_E290 = var_02;
		scripts\common\utility::flag_set("respawn_friendlies");
		wait(0.5);
	}
}

//Function Number: 15
func_1275E(param_00)
{
	var_01 = param_00 scripts\sp\_utility::func_7D1E();
	if(!isdefined(level.flag[var_01]))
	{
		scripts\common\utility::flag_init(var_01);
	}

	if(!isdefined(level.var_A842))
	{
		level.var_A842 = [];
	}

	for(;;)
	{
		param_00 waittill("trigger",var_02);
		if(isalive(var_02) && isdefined(param_00) && var_02 istouching(param_00))
		{
			level.var_A842 = scripts\common\utility::array_add(level.var_A842,param_00);
		}

		while(isalive(var_02) && isdefined(param_00) && var_02 istouching(param_00))
		{
			if(!scripts\common\utility::flag(var_01))
			{
				thread func_1275F(var_01);
			}

			wait(0.25);
		}

		level.var_A842 = scripts\common\utility::func_22A9(level.var_A842,param_00);
	}
}

//Function Number: 16
func_1275F(param_00)
{
	scripts\common\utility::flag_set(param_00);
	for(;;)
	{
		level.var_A842 = scripts\common\utility::func_22BC(level.var_A842);
		if(level.var_A842.size == 0)
		{
			break;
		}

		wait(0.25);
	}

	scripts\common\utility::func_6E2A(param_00);
}

//Function Number: 17
func_12794(param_00)
{
	param_00 method_84C0(1);
	if(isdefined(param_00.target))
	{
		var_01 = getent(param_00.target,"targetname");
		param_00 enablelinkto();
		param_00 linkto(var_01);
	}
}

//Function Number: 18
func_12723(param_00)
{
	param_00 method_84C0(1);
	if(isdefined(param_00.target))
	{
		var_01 = getent(param_00.target,"targetname");
		param_00 enablelinkto();
		param_00 linkto(var_01);
	}
}

//Function Number: 19
func_12744(param_00)
{
	var_01 = param_00 scripts\sp\_utility::func_7D1E();
	if(!isdefined(level.flag[var_01]))
	{
		scripts\common\utility::flag_init(var_01);
	}

	for(;;)
	{
		param_00 waittill("trigger",var_02);
		param_00 scripts\sp\_utility::script_delay();
		if(isalive(var_02) && isdefined(param_00) && var_02 istouching(param_00))
		{
			scripts\common\utility::flag_set(var_01);
		}

		while(isalive(var_02) && isdefined(param_00) && var_02 istouching(param_00))
		{
			wait(0.25);
		}

		scripts\common\utility::func_6E2A(var_01);
	}
}

//Function Number: 20
func_12748(param_00)
{
	for(;;)
	{
		param_00 waittill("trigger");
		scripts\common\utility::func_6E2A("respawn_friendlies");
	}
}

//Function Number: 21
func_1274C()
{
	thread func_1274D();
	level endon("trigger_group_" + self.var_EEEE);
	self waittill("trigger");
	level notify("trigger_group_" + self.var_EEEE,self);
}

//Function Number: 22
func_1274D()
{
	level waittill("trigger_group_" + self.var_EEEE,var_00);
	if(self != var_00)
	{
		self delete();
	}
}

//Function Number: 23
func_12777(param_00)
{
	for(;;)
	{
		param_00 waittill("trigger",var_01);
		if(!isalive(var_01))
		{
			continue;
		}

		var_01.var_10264 = 1;
		var_01 thread func_F611();
	}
}

//Function Number: 24
func_F611()
{
	self notify("notify_wait_then_clear_skipBloodPool");
	self endon("notify_wait_then_clear_skipBloodPool");
	self endon("death");
	wait(2);
	self.var_10264 = undefined;
}

//Function Number: 25
func_1277E(param_00)
{
	var_01 = [];
	var_02 = scripts\common\utility::getstructarray(param_00.target,"targetname");
	var_03 = getentarray(param_00.target,"targetname");
	foreach(var_05 in var_03)
	{
		var_06 = spawnstruct();
		var_06.origin = var_05.origin;
		var_06.var_EE79 = var_05.var_EE79;
		var_06.var_ED41 = var_05.var_ED41;
		var_06.var_257 = var_05.var_257;
		var_02[var_02.size] = var_06;
		var_05 delete();
	}

	param_00.var_C6EA = var_02[0].origin;
	param_00 waittill("trigger");
	param_00 scripts\sp\_utility::script_delay();
	foreach(var_06 in var_02)
	{
		var_09 = var_06.var_257;
		var_0A = var_06.var_EE79;
		var_0B = var_06.var_ED41;
		if(!isdefined(var_09))
		{
			var_09 = 350;
		}

		if(!isdefined(var_0A))
		{
			var_0A = 0.25;
		}

		setdvar("tempdvar",var_0A);
		var_0A = getdvarfloat("tempdvar");
		if(isdefined(var_0B))
		{
			radiusdamage(var_06.origin,var_09,var_0B,var_0B * 0.5);
		}

		physicsexplosionsphere(var_06.origin,var_09,var_09 * 0.5,var_0A);
	}
}

//Function Number: 26
func_12780(param_00)
{
	var_01 = param_00.var_EEEF;
	param_00 waittill("trigger");
	var_02 = function_0072();
	for(var_03 = 0;var_03 < var_02.size;var_03++)
	{
		if(!isalive(var_02[var_03]))
		{
			continue;
		}

		if(isdefined(var_02[var_03].var_EEEF) && var_02[var_03].var_EEEF == var_01)
		{
			var_02[var_03].var_15C = 800;
			var_02[var_03] method_82ED(level.player);
			level thread lib_0B77::func_50F5(var_02[var_03]);
		}
	}
}

//Function Number: 27
func_1278E(param_00)
{
	var_01 = scripts\common\utility::func_48ED(param_00.var_ED9D);
	param_00 func_1786(var_01);
	param_00 scripts\common\utility::func_12E40();
}

//Function Number: 28
func_1278F(param_00)
{
	var_01 = scripts\common\utility::func_48ED(param_00.var_ED9F);
	param_00 func_1786(var_01);
	param_00 scripts\common\utility::func_12E40();
}

//Function Number: 29
func_1786(param_00)
{
	for(var_01 = 0;var_01 < param_00.size;var_01++)
	{
		var_02 = param_00[var_01];
		if(!isdefined(level.var_12745[var_02]))
		{
			level.var_12745[var_02] = [];
		}

		level.var_12745[var_02][level.var_12745[var_02].size] = self;
	}
}

//Function Number: 30
func_1279A(param_00)
{
	waittillframeend;
	var_01 = param_00.var_EEBA;
	if(!isdefined(level.var_10725) || !isdefined(level.var_10727[var_01]))
	{
		return;
	}

	param_00 waittill("trigger");
	var_02 = scripts\common\utility::random(level.var_10727[var_01]);
	foreach(var_04 in var_02)
	{
		var_04 scripts\sp\_utility::func_10619();
	}
}

//Function Number: 31
func_1279E(param_00)
{
	for(;;)
	{
		param_00 waittill("trigger",var_01);
		if(getdvarint("sm_sunenable") == 0)
		{
			continue;
		}

		function_01C5("sm_sunenable",0);
	}
}

//Function Number: 32
func_1279F(param_00)
{
	for(;;)
	{
		param_00 waittill("trigger",var_01);
		if(getdvarint("sm_sunenable") == 1)
		{
			continue;
		}

		function_01C5("sm_sunenable",1);
	}
}

//Function Number: 33
func_127AC(param_00)
{
	param_00 waittill("trigger");
	var_01 = getentarray(param_00.target,"targetname");
	foreach(var_03 in var_01)
	{
		var_03 thread scripts\sp\_vehicle_code::func_10809(70);
		wait(0.05);
	}
}

//Function Number: 34
func_7D1F()
{
	var_00 = [];
	var_01 = undefined;
	if(isdefined(self.target))
	{
		var_02 = getentarray(self.target,"targetname");
		var_03 = [];
		foreach(var_05 in var_02)
		{
			if(var_05.classname == "script_origin")
			{
				var_03[var_03.size] = var_05;
			}

			if(issubstr(var_05.classname,"trigger"))
			{
				var_00[var_00.size] = var_05;
			}
		}

		var_02 = scripts\common\utility::getstructarray(self.target,"targetname");
		foreach(var_05 in var_02)
		{
			var_03[var_03.size] = var_05;
		}

		if(var_03.size == 1)
		{
			var_09 = var_03[0];
			var_01 = var_09.origin;
			if(isdefined(var_09.var_9F))
			{
				var_09 delete();
			}
		}
	}

	var_0A = [];
	var_0A["triggers"] = var_00;
	var_0A["target_origin"] = var_01;
	return var_0A;
}

//Function Number: 35
func_12760(param_00)
{
	func_12761(param_00,1);
}

//Function Number: 36
func_12762(param_00)
{
	func_12761(param_00,0);
}

//Function Number: 37
func_12761(param_00,param_01)
{
	var_02 = 0.78;
	if(isdefined(param_00.var_ED6D))
	{
		var_02 = param_00.var_ED6D;
	}

	var_03 = param_00 func_7D1F();
	var_04 = var_03["triggers"];
	var_05 = var_03["target_origin"];
	var_06 = isdefined(param_00.var_ED9A) || isdefined(param_00.script_noteworthy);
	var_07 = undefined;
	if(var_06)
	{
		var_07 = param_00 scripts\sp\_utility::func_7D1E();
		if(!isdefined(level.flag[var_07]))
		{
			scripts\common\utility::flag_init(var_07);
		}
	}
	else if(!var_04.size)
	{
	}

	if(param_01 && var_06)
	{
		level endon(var_07);
	}

	param_00 endon("death");
	var_08 = 1;
	if(isdefined(param_00.var_EE61))
	{
		var_08 = param_00.var_EE61;
	}

	for(;;)
	{
		if(var_06)
		{
			scripts\common\utility::func_6E2A(var_07);
		}

		param_00 waittill("trigger",var_09);
		var_0A = [];
		while(var_09 istouching(param_00))
		{
			if(var_08 && !sighttracepassed(var_09 geteye(),var_05,0,undefined))
			{
				if(var_06)
				{
					scripts\common\utility::func_6E2A(var_07);
				}

				wait(0.5);
				continue;
			}

			var_0B = vectornormalize(var_05 - var_09.origin);
			var_0C = var_09 getplayerangles();
			var_0D = anglestoforward(var_0C);
			var_0E = vectordot(var_0D,var_0B);
			if(var_0E >= var_02)
			{
				scripts\common\utility::array_thread(var_04,::scripts\sp\_utility::func_F225,"trigger");
				if(var_06)
				{
					scripts\common\utility::flag_set(var_07,var_09);
				}

				if(param_01)
				{
					return;
				}

				wait(2);
			}
			else if(var_06)
			{
				scripts\common\utility::func_6E2A(var_07);
			}

			if(var_08)
			{
				wait(0.5);
				continue;
			}

			wait(0.05);
		}
	}
}

//Function Number: 38
func_1272B(param_00)
{
	var_01 = [];
	var_02 = undefined;
	var_03 = param_00 func_7D1F();
	var_01 = var_03["triggers"];
	var_02 = var_03["target_origin"];
	var_04 = isdefined(param_00.var_ED9A) || isdefined(param_00.script_noteworthy);
	var_05 = undefined;
	if(var_04)
	{
		var_05 = param_00 scripts\sp\_utility::func_7D1E();
		if(!isdefined(level.flag[var_05]))
		{
			scripts\common\utility::flag_init(var_05);
		}
	}
	else if(!var_01.size)
	{
	}

	param_00 endon("death");
	var_06 = 12;
	var_07 = [];
	var_07[var_07.size] = (0,0,0);
	var_07[var_07.size] = (var_06,0,0);
	var_07[var_07.size] = (var_06 * -1,0,0);
	var_07[var_07.size] = (0,var_06,0);
	var_07[var_07.size] = (0,var_06 * -1,0);
	var_07[var_07.size] = (0,0,var_06);
	for(;;)
	{
		if(var_04)
		{
			scripts\common\utility::func_6E2A(var_05);
		}

		param_00 waittill("trigger",var_08);
		while(level.player istouching(param_00))
		{
			if(!var_08 func_392A(var_02,var_07))
			{
				if(var_04)
				{
					scripts\common\utility::func_6E2A(var_05);
				}

				wait(0.1);
				continue;
			}

			if(var_04)
			{
				scripts\common\utility::flag_set(var_05);
			}

			scripts\common\utility::array_thread(var_01,::scripts\sp\_utility::func_F225,"trigger");
			wait(0.5);
		}
	}
}

//Function Number: 39
func_392A(param_00,param_01)
{
	for(var_02 = 0;var_02 < param_01.size;var_02++)
	{
		if(sighttracepassed(self geteye(),param_00 + param_01[var_02],1,self))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 40
func_127A8(param_00)
{
	var_01 = "not_set";
	if(isdefined(param_00.script_noteworthy))
	{
		var_01 = param_00.script_noteworthy;
	}

	var_02 = getentarray(param_00.target,"targetname");
	param_00 thread func_127A9(param_00.target);
	for(;;)
	{
		scripts\common\utility::array_thread(var_02,::scripts\common\utility::trigger_off);
		param_00 waittill("trigger");
		scripts\common\utility::array_thread(var_02,::scripts\common\utility::trigger_on);
		func_135AA(var_02,var_01);
		scripts\sp\_utility::func_22A4(var_02,"relock");
	}
}

//Function Number: 41
func_127A9(param_00)
{
	self waittill("death");
	var_01 = getentarray(param_00,"targetname");
	scripts\common\utility::array_thread(var_01,::scripts\common\utility::trigger_off);
}

//Function Number: 42
func_135AA(param_00,param_01)
{
	level endon("unlocked_trigger_hit" + param_01);
	var_02 = spawnstruct();
	for(var_03 = 0;var_03 < param_00.size;var_03++)
	{
		param_00[var_03] thread func_E1A0(var_02,param_01);
	}

	var_02 waittill("trigger");
	level notify("unlocked_trigger_hit" + param_01);
}

//Function Number: 43
func_E1A0(param_00,param_01)
{
	self endon("relock");
	level endon("unlocked_trigger_hit" + param_01);
	self waittill("trigger");
	param_00 notify("trigger");
}

//Function Number: 44
func_12729(param_00)
{
	var_01 = undefined;
	if(isdefined(param_00.target))
	{
		var_02 = getentarray(param_00.target,"targetname");
		if(issubstr(var_02[0].classname,"trigger"))
		{
			var_01 = var_02[0];
		}
	}

	if(isdefined(var_01))
	{
		var_01 waittill("trigger",var_03);
	}
	else
	{
		var_01 waittill("trigger",var_03);
	}

	var_04 = undefined;
	if(isdefined(var_01))
	{
		if(var_03.team != level.player.team && level.player istouching(param_00))
		{
			var_04 = level.player scripts\anim\battlechatter::func_7E32("custom");
		}
		else if(var_03.team == level.player.team)
		{
			var_05 = "axis";
			if(level.player.team == "axis")
			{
				var_05 = "allies";
			}

			var_06 = scripts\anim\battlechatter::func_8145("custom",var_05);
			var_06 = scripts\common\utility::func_7830(level.player.origin,var_06);
			foreach(var_08 in var_06)
			{
				if(var_08 istouching(param_00))
				{
					var_04 = var_08;
					if(func_28D5(var_08.origin))
					{
						break;
					}
				}
			}
		}
	}
	else if(isplayer(var_03))
	{
		var_04 = var_03 scripts\anim\battlechatter::func_7E32("custom");
	}
	else
	{
		var_04 = var_03;
	}

	if(!isdefined(var_04))
	{
		return;
	}

	if(func_28D5())
	{
		return;
	}

	var_0A = var_04 scripts\sp\_utility::func_4C39(param_00.var_ED18);
	if(!var_0A)
	{
		level scripts\common\utility::func_5127(0.25,::func_12729,param_00);
		return;
	}

	param_00 notify("custom_battlechatter_done");
}

//Function Number: 45
func_28D5(param_00)
{
	return distancesquared(param_00,level.player getorigin()) <= 262144;
}

//Function Number: 46
func_12734(param_00)
{
	param_00 waittill("trigger");
	var_01 = getentarray(param_00.target,"targetname");
	var_02 = [];
	var_02["left_door"] = -170;
	var_02["right_door"] = 170;
	foreach(var_04 in var_01)
	{
		var_05 = var_02[var_04.script_noteworthy];
		var_04 connectpaths();
		var_04 rotateyaw(var_05,1,0,0.5);
	}
}

//Function Number: 47
func_1274B(param_00)
{
	var_01 = getglassarray(param_00.target);
	if(!isdefined(var_01) || var_01.size == 0)
	{
		return;
	}

	for(;;)
	{
		level waittill("glass_break",var_02);
		if(var_02 istouching(param_00))
		{
			var_03 = var_02.origin;
			wait(0.05);
			var_04 = var_02.origin;
			var_05 = undefined;
			if(var_03 != var_04)
			{
				var_05 = var_04 - var_03;
			}

			if(isdefined(var_05))
			{
				foreach(var_07 in var_01)
				{
					destroyglass(var_07,var_05);
				}

				break;
			}
			else
			{
				foreach(var_07 in var_01)
				{
					destroyglass(var_07);
				}

				break;
			}
		}
	}

	param_00 delete();
}

//Function Number: 48
func_12730(param_00)
{
	param_00 waittill("trigger");
	var_01 = param_00 func_7C30();
	scripts\common\utility::array_thread(var_01,::func_5169);
}

//Function Number: 49
func_7C30()
{
	var_00 = [];
	if(!isdefined(self.var_EE01))
	{
		return var_00;
	}

	var_01 = strtok(self.var_EE01," ");
	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		var_03 = var_01[var_02];
		var_04 = getent(var_03,"script_linkname");
		if(isdefined(var_04))
		{
			var_00[var_00.size] = var_04;
		}
	}

	return var_00;
}

//Function Number: 50
func_5169()
{
	var_00 = func_7C30();
	scripts\common\utility::array_thread(var_00,::func_5169);
	self delete();
}

//Function Number: 51
func_127A5(param_00)
{
	param_00 endon("death");
	param_00 waittill("trigger");
	scripts\sp\_utility::func_11813();
}

//Function Number: 52
func_1274E(param_00)
{
	if(!isdefined(level.var_56D9))
	{
		level.var_56D9 = [];
	}

	waittillframeend;
	var_01 = param_00.var_EDDC;
	param_00 waittill("trigger",var_02);
	if(isdefined(level.var_56D9[var_01]))
	{
		return;
	}

	level.var_56D9[var_01] = 1;
	var_02 scripts\sp\_utility::func_56BA(var_01);
}

//Function Number: 53
func_12731(param_00)
{
	for(;;)
	{
		param_00 waittill("trigger",var_01);
		if(isdefined(var_01))
		{
			var_01 delete();
		}
	}
}

//Function Number: 54
func_127A6(param_00)
{
	param_00 waittill("trigger");
	param_00 scripts\common\utility::trigger_off();
	if(!isdefined(param_00.var_EE01))
	{
		return;
	}

	var_01 = strtok(param_00.var_EE01," ");
	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		scripts\common\utility::array_thread(getentarray(var_01[var_02],"script_linkname"),::scripts\common\utility::trigger_off);
	}
}

//Function Number: 55
func_12752(param_00)
{
	thread func_1278D(param_00,::scripts\sp\_utility::func_F416,::scripts\sp\_utility::func_7A31);
}

//Function Number: 56
func_1277C(param_00)
{
	thread func_1278D(param_00,::scripts\sp\_utility::func_F4B2,::scripts\sp\_utility::func_7B61);
}

//Function Number: 57
func_1278D(param_00,param_01,param_02)
{
	for(;;)
	{
		param_00 waittill("trigger",var_03);
		if(!isalive(var_03))
		{
			continue;
		}

		if(var_03 [[ param_02 ]]())
		{
			continue;
		}

		var_03 thread func_11A40(param_00,param_01);
	}
}

//Function Number: 58
func_11A40(param_00,param_01)
{
	self endon("death");
	self.ignoreme = 1;
	[[ param_01 ]](1);
	self.var_187 = 1;
	wait(1);
	self.var_187 = 0;
	while(self istouching(param_00))
	{
		wait(1);
	}

	[[ param_01 ]](0);
}

//Function Number: 59
func_12787(param_00)
{
	param_00 waittill("trigger");
	scripts\sp\_utility::func_DBEF(param_00.script_noteworthy);
}

//Function Number: 60
func_12741(param_00)
{
	var_01 = param_00 scripts\sp\_utility::func_7D1E();
	if(!isdefined(level.flag[var_01]))
	{
		scripts\common\utility::flag_init(var_01);
	}

	for(;;)
	{
		param_00 waittill("trigger",var_02);
		if(!isplayer(var_02))
		{
			continue;
		}

		param_00 scripts\sp\_utility::script_delay();
		scripts\common\utility::flag_set(var_01);
	}
}

//Function Number: 61
func_12771(param_00)
{
	for(;;)
	{
		param_00 waittill("trigger",var_01);
		if(isdefined(param_00.script_noteworthy))
		{
			var_01 scripts\sp\_art::func_1121E(param_00.script_noteworthy,param_00.script_delay);
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 62
func_1276A(param_00)
{
	waittillframeend;
	for(;;)
	{
		param_00 waittill("trigger",var_01);
		var_02 = param_00.var_ED68;
		var_03 = param_00.var_ED67;
		var_04 = param_00.var_ED66;
		var_05 = param_00.var_ED65;
		var_06 = param_00.var_ED64;
		var_07 = param_00.var_ED63;
		var_08 = param_00.script_delay;
		if(var_02 != level.var_5832["base"]["goal"]["nearStart"] || var_03 != level.var_5832["base"]["goal"]["nearEnd"] || var_04 != level.var_5832["base"]["goal"]["nearBlur"] || var_05 != level.var_5832["base"]["goal"]["farStart"] || var_06 != level.var_5832["base"]["goal"]["farEnd"] || var_07 != level.var_5832["base"]["goal"]["farBlur"])
		{
			scripts\sp\_art::func_5848(var_02,var_03,var_04,var_05,var_06,var_07,var_08);
			wait(var_08);
			continue;
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 63
func_12772(param_00)
{
	if(level.var_13E0F || level.var_DADB)
	{
		return;
	}

	waittillframeend;
	for(;;)
	{
		param_00 waittill("trigger",var_01);
		var_02 = param_00.var_EEDF;
		var_03 = param_00.var_EEE0;
		var_04 = param_00.script_delay;
		if(var_02 != level.var_11714.var_4CA6 || var_03 != level.var_11714.var_4CA8)
		{
			var_02 = max(0,var_02);
			var_02 = min(10000,var_02);
			var_03 = max(0,var_03);
			var_03 = min(10000,var_03);
			scripts\sp\_art::func_11716(var_02,var_03,var_04);
			continue;
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 64
func_12792(param_00)
{
	setdvarifuninitialized("use_legacy_slide",0);
	for(;;)
	{
		param_00 waittill("trigger",var_01);
		var_01 thread func_102ED(param_00);
	}
}

//Function Number: 65
func_102ED(param_00)
{
	if(isdefined(self.var_131A0))
	{
		return;
	}

	if(scripts\sp\_utility::func_9F59() || self isjumping() || scripts\sp\_utility::func_9C11() || lib_0E4F::func_9C7B())
	{
		return;
	}

	if(isdefined(self.var_D323))
	{
		return;
	}

	self endon("death");
	if(soundexists("SCN_cliffhanger_player_hillslide"))
	{
		self playsound("SCN_cliffhanger_player_hillslide");
	}

	var_01 = undefined;
	if(isdefined(param_00.var_ECE2))
	{
		var_01 = param_00.var_ECE2;
	}

	self endon("cancel_sliding");
	if(getdvarint("use_legacy_slide") > 0)
	{
		thread scripts\sp\_utility::func_2A76();
	}
	else
	{
		thread scripts\sp\_utility::func_2A75(undefined,var_01);
	}

	for(;;)
	{
		if(!self istouching(param_00))
		{
			break;
		}

		wait(0.05);
	}

	if(isdefined(level.var_62F7))
	{
		wait(level.var_62F7);
	}

	if(getdvarint("use_legacy_slide") > 0)
	{
		scripts\sp\_utility::func_638A();
		return;
	}

	scripts\sp\_utility::func_6389();
}

//Function Number: 66
func_1276E(param_00)
{
	var_01 = spawn("script_origin",(0,0,0));
	param_00.var_7542 = [];
	foreach(var_03 in level.var_49C9)
	{
		func_23C8(var_03,param_00,var_01);
	}

	var_01 delete();
	if(!isdefined(param_00.target))
	{
		return;
	}

	var_05 = getentarray(param_00.target,"targetname");
	param_00.var_75AD = 1;
	foreach(var_07 in var_05)
	{
		switch(var_07.classname)
		{
			case "trigger_multiple_fx_volume_on":
				var_07 thread func_1276D(param_00);
				break;

			case "trigger_multiple_fx_volume_off":
				var_07 thread func_1276C(param_00);
				break;

			default:
				break;
		}
	}
}

//Function Number: 67
func_1276D(param_00)
{
	for(;;)
	{
		self waittill("trigger");
		if(!param_00.var_75AD)
		{
			scripts\common\utility::array_thread(param_00.var_7542,::scripts\sp\_utility::func_E2B0);
		}

		wait(1);
	}
}

//Function Number: 68
func_1276C(param_00)
{
	for(;;)
	{
		self waittill("trigger");
		if(param_00.var_75AD)
		{
			scripts\common\utility::array_thread(param_00.var_7542,::scripts\common\utility::func_C9CF);
		}

		wait(1);
	}
}

//Function Number: 69
func_23C8(param_00,param_01,param_02)
{
	if(isdefined(param_00.var_13125["soundalias"]) && param_00.var_13125["soundalias"] != "nil")
	{
		if(!isdefined(param_00.var_13125["stopable"]) || !param_00.var_13125["stopable"])
		{
			return;
		}
	}

	param_02.origin = param_00.var_13125["origin"];
	if(param_02 istouching(param_01))
	{
		param_01.var_7542[param_01.var_7542.size] = param_00;
	}
}

//Function Number: 70
func_12769(param_00)
{
	var_01 = param_00.var_EE79;
	if(!isdefined(level.var_B7AE))
	{
		level.var_B7AE = "";
	}

	for(;;)
	{
		param_00 waittill("trigger");
		if(level.var_B7AE != var_01)
		{
			scripts\sp\_compass::func_FACD(var_01);
		}
	}
}

//Function Number: 71
func_12775(param_00)
{
	scripts\common\utility::array_thread(level.players,::func_BFE5,param_00);
}

//Function Number: 72
func_BFE5(param_00)
{
	for(;;)
	{
		param_00 waittill("trigger",var_01);
		if(!isdefined(var_01))
		{
			continue;
		}

		if(var_01 != self)
		{
			continue;
		}

		while(var_01 istouching(param_00))
		{
			var_01 allowprone(0);
			var_01 allowcrouch(0);
			wait(0.05);
		}

		var_01 allowprone(1);
		var_01 allowcrouch(1);
	}
}

//Function Number: 73
func_1275A(param_00)
{
	if(!isdefined(level.var_A0E4))
	{
		level.var_A0E4 = 0;
	}

	param_00.var_12751 = level.var_A0E4;
	level.var_A0E4++;
	param_00.var_C75B = scripts\common\utility::getstruct(param_00.target,"targetname");
	param_00.var_98F5 = scripts\common\utility::getstruct(param_00.var_C75B.target,"targetname");
	for(;;)
	{
		param_00 waittill("trigger",var_01);
		if(!isdefined(level.var_D127) || var_01 != level.var_D127)
		{
			continue;
		}

		if(level.player scripts\sp\_utility::func_65DB("disable_jackal_map_boundary_push"))
		{
			continue;
		}

		param_00 thread [[ level.var_A056.var_12749.var_A0E2 ]]();
		while(isalive(var_01) && isdefined(param_00) && var_01 istouching(param_00) && isdefined(level.var_D127))
		{
			wait(0.05);
		}

		param_00 thread [[ level.var_A056.var_12749.var_A0E3 ]]();
	}
}

//Function Number: 74
func_1275B(param_00)
{
	var_01 = "trigger_jackal_boundary_warning";
	if(!isdefined(level.var_A392))
	{
		level.var_A392 = [];
	}

	if(!scripts\common\utility::func_6E34(var_01))
	{
		scripts\common\utility::flag_init(var_01);
	}

	var_02 = scripts\common\utility::getstruct(param_00.target,"targetname");
	if(!isdefined(var_02))
	{
		var_02 = getent(param_00.target,"targetname");
		var_03 = 1;
	}
	else
	{
		var_03 = 0;
	}

	for(;;)
	{
		param_00 waittill("trigger",var_04);
		if(!isdefined(level.var_D127) || var_04 != level.var_D127)
		{
			continue;
		}

		if(level.player scripts\sp\_utility::func_65DB("disable_jackal_map_boundary_warning"))
		{
			while(isalive(var_04) && isdefined(param_00) && var_04 istouching(param_00) && isdefined(level.var_D127) && level.player scripts\sp\_utility::func_65DB("disable_jackal_map_boundary_warning"))
			{
				wait(0.05);
			}
		}

		if(level.player scripts\sp\_utility::func_65DB("disable_jackal_map_boundary_warning"))
		{
			continue;
		}

		if(!scripts\common\utility::flag(var_01))
		{
			scripts\common\utility::flag_set(var_01);
			var_02 thread func_A391(var_04,var_03,var_01);
			level.var_A392 = scripts\common\utility::array_add(level.var_A392,param_00);
		}

		while(isalive(var_04) && isdefined(param_00) && var_04 istouching(param_00) && isdefined(level.var_D127))
		{
			wait(0.05);
		}

		level.var_A392 = scripts\common\utility::func_22A9(level.var_A392,param_00);
		if(level.var_A392.size == 0)
		{
			scripts\common\utility::func_6E2A(var_01);
		}
	}
}

//Function Number: 75
func_A391(param_00,param_01,param_02)
{
	var_03 = scripts\common\utility::spawn_tag_origin();
	var_03.var_138F0 = 0;
	var_04 = 0;
	if(param_01)
	{
		var_05 = function_00BF(self.model,0);
		var_03 linkto(self,var_05,(0,0,0),(0,0,0));
	}
	else
	{
		var_03.origin = self.origin;
	}

	var_06 = 0;
	while(var_06 < 1)
	{
		if(scripts\common\utility::flag(param_02) || scripts\common\utility::flag("jackal_is_autoturning"))
		{
			var_06 = 0;
		}
		else
		{
			var_06++;
		}

		var_07 = vectornormalize(self.origin - level.var_D127.origin);
		var_08 = anglestoforward(level.var_D127.angles);
		var_09 = vectordot(var_07,var_08);
		var_0A = vectornormalize(level.var_D127.var_2AC);
		var_0B = vectordot(var_07,var_0A);
		if(var_09 > 0.1 && var_0B > 0.1)
		{
			if(var_04)
			{
				var_04 = 0;
				var_03 [[ level.var_A056.var_12749.var_A0E5 ]](var_04);
			}

			continue;
		}

		if(!var_04)
		{
			var_04 = 1;
			var_03 [[ level.var_A056.var_12749.var_A0E5 ]](var_04);
		}

		wait(0.05);
	}

	var_03 [[ level.var_A056.var_12749.var_A0E5 ]](0);
	var_03 delete();
}

//Function Number: 76
func_12759(param_00)
{
	var_01 = "trigger_jackal_boundary_autoturn";
	var_02 = "jackal_is_autoturning";
	if(!scripts\common\utility::func_6E34(var_01))
	{
		scripts\common\utility::flag_init(var_01);
	}

	if(!scripts\common\utility::func_6E34(var_02))
	{
		scripts\common\utility::flag_init(var_02);
	}

	var_03 = scripts\common\utility::getstruct(param_00.target,"targetname");
	for(;;)
	{
		param_00 waittill("trigger",var_04);
		if(!isdefined(level.var_D127) || var_04 != level.var_D127 || scripts\common\utility::flag(var_01))
		{
			continue;
		}

		if(level.player scripts\sp\_utility::func_65DB("disable_jackal_map_boundary_autoturn"))
		{
			while(isalive(var_04) && isdefined(param_00) && var_04 istouching(param_00) && isdefined(level.var_D127) && level.player scripts\sp\_utility::func_65DB("disable_jackal_map_boundary_autoturn"))
			{
				wait(0.05);
			}
		}

		if(level.player scripts\sp\_utility::func_65DB("disable_jackal_map_boundary_autoturn"))
		{
			continue;
		}

		if(!scripts\common\utility::flag(var_01))
		{
			scripts\common\utility::flag_set(var_01);
			if(!scripts\common\utility::flag(var_02))
			{
				var_03 thread [[ level.var_A056.var_12749.var_A0E1 ]](param_00,var_04,var_01,var_02);
			}

			level.var_A056.var_2698 = scripts\common\utility::array_add(level.var_A056.var_2698,param_00);
		}

		while(isalive(var_04) && isdefined(param_00) && var_04 istouching(param_00) && isdefined(level.var_D127))
		{
			wait(0.05);
		}

		level.var_A056.var_2698 = scripts\common\utility::func_22A9(level.var_A056.var_2698,param_00);
		if(level.var_A056.var_2698.size == 0)
		{
			scripts\common\utility::func_6E2A(var_01);
		}
	}
}

//Function Number: 77
func_1275C(param_00)
{
	for(;;)
	{
		param_00 waittill("trigger",var_01);
		if(!isdefined(level.var_D127) || var_01 != level.var_D127)
		{
			continue;
		}

		param_00 func_A2FF();
		while(isalive(var_01) && isdefined(param_00) && var_01 istouching(param_00) && isdefined(level.var_D127))
		{
			wait(0.25);
		}

		param_00 func_A300();
	}
}

//Function Number: 78
func_A2FF()
{
	if(!isdefined(level.var_A056) || !isdefined(level.var_A056.var_10991))
	{
		return;
	}

	level.var_A056.var_10991 = scripts\common\utility::array_add(level.var_A056.var_10991,self);
	level.var_A056.var_10991 = scripts\common\utility::func_22C3(level.var_A056.var_10991,::func_9C91);
	level notify("notify_new_jackal_speed_zone");
}

//Function Number: 79
func_A300()
{
	if(!isdefined(level.var_A056) || !isdefined(level.var_A056.var_10991))
	{
		return;
	}

	level.var_A056.var_10991 = scripts\common\utility::func_22A9(level.var_A056.var_10991,self);
	level notify("notify_new_jackal_speed_zone");
}

//Function Number: 80
func_9C91(param_00,param_01)
{
	return param_00.var_EE8C > param_01.var_EE8C;
}

//Function Number: 81
func_12776(param_00)
{
	scripts\common\utility::array_thread(level.players,::func_C00E,param_00);
}

//Function Number: 82
func_C00E(param_00)
{
	for(;;)
	{
		param_00 waittill("trigger",var_01);
		if(!isdefined(var_01))
		{
			continue;
		}

		if(var_01 != self)
		{
			continue;
		}

		while(var_01 istouching(param_00))
		{
			var_01 allowprone(0);
			wait(0.05);
		}

		var_01 allowprone(1);
	}
}

//Function Number: 83
func_69AA(param_00)
{
	level endon("killexplodertridgers" + param_00.var_ED84);
	param_00 waittill("trigger");
	if(isdefined(param_00.var_ED28) && randomfloat(1) > param_00.var_ED28)
	{
		if(!param_00 scripts\sp\_utility::script_delay())
		{
			wait(4);
		}

		level thread func_69AA(param_00);
		return;
	}

	if(!param_00 scripts\sp\_utility::script_delay() && isdefined(param_00.var_ED85))
	{
		wait(param_00.var_ED85);
	}

	scripts\common\utility::exploder(param_00.var_ED84);
	level notify("killexplodertridgers" + param_00.var_ED84);
}

//Function Number: 84
func_12770(param_00)
{
	if(getdvarint("kleenex") != 1)
	{
		return;
	}

	param_00 waittill("trigger");
	scripts\sp\_utility::func_A6F2();
}

//Function Number: 85
func_1279C(param_00)
{
	param_00 endon("death");
	var_01 = "stealth_in_shadow";
	for(;;)
	{
		param_00 waittill("trigger",var_02);
		if(!var_02 scripts\sp\_utility::func_65DF(var_01))
		{
			continue;
		}

		if(var_02 scripts\sp\_utility::func_65DB(var_01))
		{
			continue;
		}

		var_02 thread func_93A4(param_00,var_01);
	}
}

//Function Number: 86
func_93A4(param_00,param_01)
{
	self endon("death");
	scripts\sp\_utility::func_65E1(param_01);
	while(isdefined(param_00) && self istouching(param_00))
	{
		wait(0.05);
	}

	scripts\sp\_utility::func_65DD(param_01);
}

//Function Number: 87
func_1273C(param_00)
{
	param_00 endon("death");
	var_01 = 2;
	var_02 = 2;
	var_03 = 0;
	if(!isdefined(param_00.var_ED50) && !isdefined(param_00.var_ED4F))
	{
		param_00.var_ED50 = 0.3;
		param_00.var_ED4F = 0.9;
	}

	if(isdefined(param_00.var_ED41))
	{
		var_01 = param_00.var_ED41;
	}

	for(;;)
	{
		param_00 waittill("trigger",var_04);
		var_05 = param_00.origin;
		if(isplayer(var_04))
		{
			var_03 = var_01;
			if(param_00.classname == "trigger_radius_fire")
			{
				if(isdefined(param_00.var_EE8F))
				{
					if(distance2dsquared(var_04.origin,param_00.origin) <= squared(param_00.var_EE8F))
					{
						if(isdefined(param_00.var_EE51) && function_027D(param_00.var_EE51))
						{
							var_02 = param_00.var_EE51;
						}

						var_03 = var_03 * var_02;
					}
				}
			}
			else if(isdefined(param_00.target))
			{
				var_06 = scripts\common\utility::getstruct(param_00.target,"targetname");
				var_05 = var_06.origin;
				if(isdefined(var_06.var_EE8F))
				{
					if(distance2dsquared(var_04.origin,var_06.origin) <= squared(var_06.var_EE8F))
					{
						if(isdefined(param_00.var_EE51) && function_027D(param_00.var_EE51))
						{
							var_02 = param_00.var_EE51;
						}

						var_03 = var_03 * var_02;
					}
				}
			}
		}

		var_04 dodamage(var_03,var_05);
		if(var_03 < 6)
		{
			var_04 playrumbleonentity("damage_light");
		}
		else
		{
			var_04 playrumbleonentity("damage_heavy");
		}

		param_00 scripts\sp\_utility::script_delay();
	}
}