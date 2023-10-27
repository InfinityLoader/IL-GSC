/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3659.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 18
 * Decompile Time: 7 ms
 * Timestamp: 10/27/2023 12:31:01 AM
*******************************************************************/

//Function Number: 1
func_10730(param_00,param_01,param_02)
{
	var_03 = spawn("script_model",level.player.origin);
	if(isdefined(param_00))
	{
		var_03 setmodel(param_00);
	}
	else if(isdefined(level.var_8E10) && level.var_8E10 == "none")
	{
		return undefined;
	}
	else if(isdefined(level.var_8E10))
	{
		var_03 setmodel(level.var_8E10);
	}
	else
	{
		var_03 setmodel("hero_jackal_helmet_a");
	}

	var_03 method_83D0(#animtree);
	if(isdefined(param_01))
	{
		var_03 linkto(param_01,param_02,(0,0,0),(0,0,0));
	}
	else if(self != level && self != level.player && isdefined(self.model))
	{
		var_03 linkto(self,"tag_playerhelmet",(0,0,0),(0,0,0));
	}

	if(!isdefined(level.player.var_8DDA))
	{
		level.player.var_8DDA = var_03;
	}

	return var_03;
}

//Function Number: 2
func_1072F(param_00)
{
	var_01 = spawn("script_model",level.player.origin);
	if(isdefined(param_00))
	{
		var_01 setmodel(param_00);
	}
	else if(isdefined(level.var_8E0E))
	{
		var_01 setmodel(level.var_8E0E);
	}
	else
	{
		var_01 setmodel("vm_hero_protagonist_helmet");
	}

	var_01 method_83D0(#animtree);
	level.player.var_8DDA = var_01;
	return var_01;
}

//Function Number: 3
func_8E06(param_00)
{
	if(scripts\sp\_utility::func_93A6() && level.var_10964.ignorehelmetfuncs)
	{
		return;
	}

	if(!isdefined(level.player.var_8DDA))
	{
		level.player.var_8DDA = func_1072F();
	}

	level.player.var_8DDA method_81E2(level.player,"tag_playerhelmet",(0,0,0),(0,0,0),1,"view_jostle");
	level.player.var_8DDA.var_13487 = "down";
	if(isdefined(param_00) && param_00)
	{
		thread func_1348D(1);
		return;
	}

	scripts\common\utility::func_5127(0,::helmethud_on);
}

//Function Number: 4
func_8E04(param_00)
{
	if(scripts\sp\_utility::func_93A6() && level.var_10964.ignorehelmetfuncs)
	{
		return;
	}

	level.player.var_8DDA method_83CB(level.player);
	if(!isdefined(param_00) || !param_00)
	{
		level.player.var_8DDA delete();
	}
}

//Function Number: 5
func_1348D(param_00,param_01)
{
	if(scripts\sp\_utility::func_93A6() && level.var_10964.ignorehelmetfuncs)
	{
		return;
	}

	if(!isdefined(param_00))
	{
		param_00 = 0;
	}

	if(level.player.var_8DDA.var_13487 == "up")
	{
		return;
	}

	if(level.player scripts\sp\_utility::func_65DB("visor_active"))
	{
		return;
	}

	level.player scripts\sp\_utility::func_65E1("visor_active");
	level.player notify("putting_visor_up");
	if(!param_00)
	{
		func_D5DF(0);
		scripts\common\utility::func_5127(0.2,::helmethud_off);
		thread func_8DE2();
	}
	else
	{
		scripts\common\utility::func_5127(0,::helmethud_off);
	}

	level.player method_8024(0.25,0);
	level.player.var_8DDA method_806F(%vm_gesture_visor_down_visor,0);
	level.player.var_8DDA method_82A2(%vm_gesture_visor_up_visor);
	if(!param_00)
	{
		if(self == level.player)
		{
			level.player playsound("plr_helmet_visor_pull_up_w_air_lr");
		}

		var_02 = "ges_visor_up";
		if(isdefined(param_01))
		{
			var_02 = param_01;
		}

		level.player method_846F(var_02,undefined,undefined,undefined,1);
		wait(getanimlength(%vm_gesture_visor_up_visor));
	}
	else
	{
		level.player.var_8DDA method_82B0(%vm_gesture_visor_up_visor,1);
	}

	if(!param_00)
	{
		func_D5DF(1);
	}

	level.player method_8024(0.25,1);
	level.player.var_8DDA.var_13487 = "up";
	level.player notify("visor_up_end");
	level.player scripts\sp\_utility::func_65DD("visor_active");
}

//Function Number: 6
func_8DE2(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 0.2;
	}

	if(scripts\sp\_art::is_dof_script_enabled())
	{
		return;
	}

	scripts\sp\_art::func_583F(0,1000,6,0,100,3,0.2);
	wait(param_00);
	scripts\sp\_art::func_583D(1.5);
}

//Function Number: 7
func_13485(param_00,param_01,param_02)
{
	if(scripts\sp\_utility::func_93A6() && level.var_10964.ignorehelmetfuncs)
	{
		return;
	}

	if(!isdefined(param_00))
	{
		param_00 = 0;
	}

	if(level.player.var_8DDA.var_13487 == "down")
	{
		return;
	}

	if(level.player scripts\sp\_utility::func_65DB("visor_active"))
	{
		return;
	}

	level.player scripts\sp\_utility::func_65E1("visor_active");
	level.player notify("putting_visor_down");
	if(!param_00)
	{
		func_D5DF(0);
		thread func_8DE2();
		if(!isdefined(param_02) || !param_02)
		{
			scripts\common\utility::func_5127(0.5,::helmethud_on);
		}
	}
	else if(!isdefined(param_02) || !param_02)
	{
		scripts\common\utility::func_5127(0,::helmethud_on);
	}

	level.player method_8024(0.25,0);
	level.player.var_8DDA method_806F(%vm_gesture_visor_up_visor,0);
	level.player.var_8DDA method_82A2(%vm_gesture_visor_down_visor);
	if(!param_00)
	{
		var_03 = "ges_visor_down";
		if(isdefined(param_01))
		{
			var_03 = param_01;
		}

		if(self == level.player)
		{
		}

		level.player method_846F(var_03,undefined,undefined,undefined,1);
		wait(getanimlength(%vm_gesture_visor_down_visor));
	}
	else
	{
		if(self == level.player)
		{
		}

		level.player.var_8DDA method_82B0(%vm_gesture_visor_down_visor,1);
	}

	if(!param_00)
	{
		func_D5DF(1);
	}

	level.player method_8024(0.25,1);
	level.player.var_8DDA.var_13487 = "down";
	level.player notify("visor_down_end");
	level.player scripts\sp\_utility::func_65DD("visor_active");
}

//Function Number: 8
func_8E05(param_00,param_01,param_02)
{
	if(scripts\sp\_utility::func_93A6() && level.var_10964.ignorehelmetfuncs)
	{
		return;
	}

	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	if(level.player scripts\sp\_utility::func_65DB("helmet_active"))
	{
		return;
	}

	level.player scripts\sp\_utility::func_65E1("helmet_active");
	var_03 = undefined;
	if(isdefined(param_01))
	{
		var_03 = param_01;
	}
	else if(isdefined(level.var_CF58))
	{
		var_03 = level.var_CF58;
	}
	else
	{
		var_03 = %shipcrib_dropship_plr_getin_helmetvm;
	}

	if(isdefined(level.player.var_8DDA))
	{
		level.player.var_8DDA delete();
	}

	level.player.var_8DDA = func_1072F();
	level.player.var_8DDA method_81E2(level.player,"tag_playerhelmet",(0,0,0),(0,0,0),1,"view_jostle");
	if(isdefined(param_00) && param_00)
	{
		level.player.var_8DDA.var_13487 = "none";
		level.player thread func_1348D(1);
	}
	else
	{
		level.player.var_8DDA.var_13487 = "none";
		level.player thread func_13485(1,undefined,1);
		scripts\common\utility::func_5127(0.8,::helmethud_on);
	}

	func_D5DF(0);
	level.player method_8024(0.25,0);
	level.player.var_8DDA method_82A2(var_03);
	wait(getanimlength(var_03));
	level.player.var_8DDA method_806F(var_03,0);
	level.player method_8024(0.25,1);
	func_D5DF(1);
	level.player notify("helmet_on_end");
	level.player scripts\sp\_utility::func_65DD("helmet_active");
}

//Function Number: 9
func_8E02(param_00)
{
	if(scripts\sp\_utility::func_93A6() && level.var_10964.ignorehelmetfuncs)
	{
		return;
	}

	if(level.player scripts\sp\_utility::func_65DB("helmet_active"))
	{
		return;
	}

	level.player scripts\sp\_utility::func_65E1("helmet_active");
	var_01 = undefined;
	if(isdefined(param_00))
	{
		var_01 = param_00;
	}
	else if(isdefined(level.var_CF57))
	{
		var_01 = level.var_CF57;
	}
	else
	{
		var_01 = %vm_default_helmet_off;
	}

	func_D5DF(0);
	scripts\common\utility::func_5127(0.2,::helmethud_off);
	thread scripts\sp\_audio::func_25BE();
	level.player method_8024(0.25,0);
	level.player.var_8DDA method_82A2(var_01);
	wait(getanimlength(var_01));
	level.player.var_8DDA method_806F(var_01,0);
	level.player method_8024(0.25,1);
	level.player.var_8DDA method_83CB(level.player);
	level.player.var_8DDA delete();
	if(self != level && self != level.player && isdefined(self.model))
	{
		level.player.var_8DDA = func_10730();
		if(isdefined(level.player.var_8DDA))
		{
			level.player.var_8DDA linkto(self,"tag_playerhelmet",(0,0,0),(0,0,0));
		}
	}

	func_D5DF(1);
	level.player notify("helmet_off_end");
	level.player scripts\sp\_utility::func_65DD("helmet_active");
}

//Function Number: 10
func_8DEA(param_00)
{
	if(!isdefined(param_00))
	{
		scripts\common\utility::func_6E2A("helmet_script_visible");
	}

	if(scripts\sp\_utility::func_93A6())
	{
		lib_0B78::func_F52F(0);
		return;
	}

	if(isdefined(level.player.var_8DDA))
	{
		level.player.var_8DDA hide();
	}
}

//Function Number: 11
func_8E0A(param_00)
{
	if(!isdefined(param_00))
	{
		scripts\common\utility::flag_set("helmet_script_visible");
	}

	if(!scripts\common\utility::flag("helmet_FOV_disallow"))
	{
		if(scripts\sp\_utility::func_93A6())
		{
			lib_0B78::func_F52F(1);
			return;
		}

		if(isdefined(level.player.var_8DDA))
		{
			level.player.var_8DDA show();
			return;
		}
	}
}

//Function Number: 12
func_D5E3()
{
	scripts\common\utility::flag_init("helmet_FOV_disallow");
	scripts\common\utility::flag_init("helmet_script_visible");
	scripts\common\utility::flag_set("helmet_script_visible");
	scripts\sp\_utility::func_F305();
	if(!level.console)
	{
		thread func_D5E2();
	}

	level.player scripts\sp\_utility::func_65E0("helmet_active");
	level.player scripts\sp\_utility::func_65E0("visor_active");
	level.player scripts\sp\_utility::func_65E0("!allow_offhand_weapons");
	level.player scripts\sp\_utility::func_65E0("!allow_offhand_primary_weapons");
	level.player scripts\sp\_utility::func_65E0("!allow_offhand_secondary_weapons");
}

//Function Number: 13
func_CFD4()
{
	var_00 = [];
	var_00["offhandWeapons"] = func_3BE8("offhandWeapons",::scripts\common\utility::func_1C58,::scripts\common\utility::func_9EC1,"!allow_offhand_weapons");
	var_00["offhandPrimaryWeapons"] = func_3BE8("offhandPrimaryWeapons",::scripts\common\utility::func_1C55,::scripts\common\utility::func_9EBE,"!allow_offhand_primary_weapons");
	var_00["offhandSecondaryWeapons"] = func_3BE8("offhandSecondaryWeapons",::scripts\common\utility::func_1C56,::scripts\common\utility::func_9EBF,"!allow_offhand_secondary_weapons");
	var_00["reload"] = func_3BE8("reload",::scripts\common\utility::func_1C62);
	level.player.var_1C69 = var_00;
}

//Function Number: 14
func_D5DF(param_00)
{
	if(!isdefined(level.player.var_1C69))
	{
		func_CFD4();
	}

	if((isdefined(level.player.var_8DDA.var_55BA) && param_00) || !level.player islinked() && !param_00)
	{
		foreach(var_02 in level.player.var_1C69)
		{
			if(!isdefined(var_02.var_C025) || !level.player scripts\sp\_utility::func_65DB(var_02.var_C025))
			{
				level.player [[ var_02.var_F3C3 ]](param_00);
			}
		}

		if(param_00)
		{
			level.player.var_8DDA.var_55BA = undefined;
		}
		else
		{
			level.player.var_8DDA.var_55BA = 1;
		}

		scripts\common\utility::func_6E5A("secondary_equipment_in_use");
	}

	return 1;
}

//Function Number: 15
func_3BE8(param_00,param_01,param_02,param_03)
{
	var_04 = spawnstruct();
	var_04.name = param_00;
	var_04.var_F3C3 = param_01;
	var_04.var_3DA0 = param_02;
	var_04.var_C025 = param_03;
	return var_04;
}

//Function Number: 16
func_D5E2()
{
	if(level.console)
	{
		return;
	}

	while(!isdefined(level.player.var_8DDA))
	{
		wait(0.05);
	}

	var_00 = 70;
	var_01 = var_00 / 65;
	for(;;)
	{
		while(!scripts\common\utility::flag("helmet_FOV_disallow"))
		{
			var_02 = getdvarfloat("com_fovUserScale");
			if(var_02 > var_01)
			{
				scripts\common\utility::flag_set("helmet_FOV_disallow");
				if(scripts\common\utility::flag("helmet_script_visible"))
				{
					thread func_8DEA(1);
				}
			}

			wait(1);
		}

		while(scripts\common\utility::flag("helmet_FOV_disallow"))
		{
			var_02 = getdvarfloat("com_fovUserScale");
			if(var_02 < var_01)
			{
				scripts\common\utility::func_6E2A("helmet_FOV_disallow");
				if(scripts\common\utility::flag("helmet_script_visible"))
				{
					thread func_8E0A(1);
				}
			}

			wait(1);
		}

		wait(0.1);
	}
}

//Function Number: 17
helmethud_on()
{
	if(getomnvar("ui_helmet_state") == 1)
	{
		return;
	}

	setomnvar("ui_helmet_state",1);
}

//Function Number: 18
helmethud_off()
{
	if(getomnvar("ui_helmet_state") == 0)
	{
		return;
	}

	level.player setclientomnvar("ui_helmet_state",0);
}