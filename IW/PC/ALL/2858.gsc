/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 2858.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 17
 * Decompile Time: 7 ms
 * Timestamp: 10/27/2023 12:24:19 AM
*******************************************************************/

//Function Number: 1
func_B9D3()
{
	scripts\common\utility::flag_init("primary_equipment_input_down");
	scripts\common\utility::flag_init("secondary_equipment_input_down");
	scripts\common\utility::flag_init("primary_equipment_in_use");
	scripts\common\utility::flag_init("secondary_equipment_in_use");
	scripts\common\utility::flag_init("equipment_switching_disabled");
	thread func_B998();
	thread func_B9A1();
	thread func_6697();
	thread func_61F4();
}

//Function Number: 2
func_6240(param_00)
{
	level.player.var_110C0 = param_00;
}

//Function Number: 3
func_B998()
{
	self endon("death");
	for(;;)
	{
		self waittill("primary_equipment_change",var_00);
		switch(var_00)
		{
			case "emp":
				level.player thread lib_0E25::func_618D();
				break;
	
			case "seeker":
				thread lib_0E26::func_F162();
				break;
	
			default:
				break;
		}
	}
}

//Function Number: 4
func_B9A1()
{
	self endon("death");
	for(;;)
	{
		self waittill("secondary_equipment_change",var_00);
		switch(var_00)
		{
			case "offhandshield_up1":
			case "offhandshield":
				thread lib_0E2B::func_C334();
				break;
	
			case "hackingdevice":
				thread lib_0E29::func_8836();
				break;
	
			case "supportdrone_up2":
			case "supportdrone":
				thread lib_0E2D::func_112BB();
				break;
	
			default:
				break;
		}
	}
}

//Function Number: 5
func_6697()
{
	self endon("death");
	var_00 = 0;
	var_01 = 0;
	for(;;)
	{
		if(self fragbuttonpressed() && !var_00)
		{
			scripts\common\utility::flag_set("primary_equipment_input_down");
			level.player notify("primary_equipment_pressed");
			var_00 = 1;
		}
		else if(!self fragbuttonpressed() && var_00)
		{
			scripts\common\utility::func_6E2A("primary_equipment_input_down");
			level.player notify("primary_equipment_released");
			var_00 = 0;
		}

		if(self secondaryoffhandbuttonpressed() && !var_01)
		{
			scripts\common\utility::flag_set("secondary_equipment_input_down");
			level.player notify("secondary_equipment_pressed");
			var_01 = 1;
		}
		else if(!self secondaryoffhandbuttonpressed() && var_01)
		{
			scripts\common\utility::func_6E2A("secondary_equipment_input_down");
			level.player notify("secondary_equipment_released");
			var_01 = 0;
		}

		wait(0.05);
	}
}

//Function Number: 6
func_61F4()
{
	thread func_D8CF();
	thread func_F0B5();
}

//Function Number: 7
func_5527()
{
	level.player notify("disable_equipment_autoswitch");
}

//Function Number: 8
func_D8CF()
{
	self endon("death");
	self endon("disable_equipment_autoswitch");
	while(!isdefined(level.player.var_4B2B))
	{
		wait(0.05);
	}

	thread func_D8CE();
	for(;;)
	{
		var_00 = scripts\sp\_utility::func_7BD6();
		if(!isdefined(var_00))
		{
			level.player waittill("primary_equipment_change");
			continue;
		}

		var_01 = scripts\sp\_utility::func_7BD7();
		self waittill("offhand_fired");
		if(!isdefined(scripts\sp\_utility::func_7BD6()) || var_00 != scripts\sp\_utility::func_7BD6())
		{
			continue;
		}

		if(var_01 == scripts\sp\_utility::func_7BD7())
		{
			continue;
		}

		if(isdefined(scripts\sp\_utility::func_7BD6()) && scripts\sp\_utility::func_7BD7() <= 0)
		{
			if(isdefined(scripts\sp\_utility::func_7CAF()) && scripts\sp\_utility::func_7CB0() > 0)
			{
				func_1418();
			}
		}
	}
}

//Function Number: 9
func_D8CE()
{
	self endon("death");
	self endon("disable_equipment_autoswitch");
	for(;;)
	{
		var_00 = scripts\sp\_utility::func_7BD6();
		if(!isdefined(var_00))
		{
			level.player waittill("primary_equipment_change");
			continue;
		}

		var_01 = scripts\sp\_utility::func_7BD7();
		if(var_01 != 0)
		{
			level.player scripts\common\utility::waittill_any_3("primary_equipment_change","offhand_fired");
			continue;
		}

		scripts\sp\_utility::func_13656();
		if(!isdefined(scripts\sp\_utility::func_7BD6()) || var_00 != scripts\sp\_utility::func_7BD6())
		{
			continue;
		}

		if(scripts\sp\_utility::func_7BD7() > 0)
		{
			continue;
		}

		if(scripts\common\utility::flag("primary_equipment_in_use"))
		{
			scripts\common\utility::func_6E5A("primary_equipment_in_use");
		}

		if(var_00 != scripts\sp\_utility::func_7BD6())
		{
			continue;
		}

		if(isdefined(scripts\sp\_utility::func_7CAF()) && scripts\sp\_utility::func_7CB0() > 0)
		{
			func_1418();
		}
	}
}

//Function Number: 10
func_F0B5()
{
	self endon("death");
	self endon("disable_equipment_autoswitch");
	while(!isdefined(level.player.var_4B21))
	{
		wait(0.05);
	}

	thread func_F0B4();
	for(;;)
	{
		var_00 = scripts\sp\_utility::func_7C3D();
		if(!isdefined(var_00))
		{
			level.player waittill("secondary_equipment_change");
			continue;
		}

		var_01 = scripts\sp\_utility::func_7C3E();
		var_02 = scripts\common\utility::func_13734("offhand_fired","secondary_equipment_change");
		if(var_02 == "secondary_equipment_change")
		{
			continue;
		}

		if(!isdefined(scripts\sp\_utility::func_7C3D()) || var_00 != scripts\sp\_utility::func_7C3D())
		{
			continue;
		}

		if(var_01 == scripts\sp\_utility::func_7C3E())
		{
			continue;
		}

		if(scripts\common\utility::flag("secondary_equipment_in_use"))
		{
			scripts\common\utility::func_6E5A("secondary_equipment_in_use");
		}

		while(level.player method_81C6())
		{
			wait(0.05);
		}

		if(!isdefined(scripts\sp\_utility::func_7C3D()) || var_00 != scripts\sp\_utility::func_7C3D())
		{
			continue;
		}

		if(isdefined(scripts\sp\_utility::func_7C3D()) && scripts\sp\_utility::func_7C3E() <= 0)
		{
			if(isdefined(scripts\sp\_utility::func_7CB1()) && scripts\sp\_utility::func_7CB2() > 0)
			{
				func_1419();
			}
		}
	}
}

//Function Number: 11
func_F0B4()
{
	self endon("death");
	self endon("disable_equipment_autoswitch");
	for(;;)
	{
		var_00 = scripts\sp\_utility::func_7C3D();
		if(!isdefined(var_00))
		{
			level.player waittill("secondary_equipment_change");
			continue;
		}

		var_01 = scripts\sp\_utility::func_7C3E();
		if(var_01 != 0)
		{
			level.player scripts\common\utility::waittill_any_3("secondary_equipment_change","offhand_fired");
			continue;
		}

		scripts\sp\_utility::func_13661();
		if(!isdefined(scripts\sp\_utility::func_7C3D()) || var_00 != scripts\sp\_utility::func_7C3D())
		{
			continue;
		}

		if(scripts\sp\_utility::func_7C3E() > 0)
		{
			continue;
		}

		if(scripts\common\utility::flag("secondary_equipment_in_use"))
		{
			scripts\common\utility::func_6E5A("secondary_equipment_in_use");
		}

		if(var_00 != scripts\sp\_utility::func_7C3D())
		{
			continue;
		}

		if(isdefined(scripts\sp\_utility::func_7CB1()) && scripts\sp\_utility::func_7CB2() > 0)
		{
			func_1419();
		}
	}
}

//Function Number: 12
func_66A1()
{
	level.player notifyonplayercommand("secondary_equipment_switch_input","+actionslot 3");
	level.player notifyonplayercommand("primary_equipment_switch_input","+actionslot 4");
	level.player thread func_66A2();
}

//Function Number: 13
func_66A2()
{
	self endon("death");
	for(;;)
	{
		var_00 = scripts\common\utility::func_13734("secondary_equipment_switch_input","primary_equipment_switch_input");
		if(var_00 == "primary_equipment_switch_input" && level.player.var_110BD != "" && !scripts\sp\_utility::func_9C8E() && !scripts\sp\_utility::func_9CB6())
		{
			func_1418();
			continue;
		}

		if(var_00 == "secondary_equipment_switch_input" && level.player.var_110BA != "" && !scripts\sp\_utility::func_9C8E() && !scripts\sp\_utility::func_9CB6())
		{
			func_1419();
		}
	}
}

//Function Number: 14
func_1418()
{
	var_00 = level.player.var_110BD;
	self giveweapon(var_00);
	self setweaponammoclip(var_00,level.player.var_110BE);
	self playsound("plr_switch_equipment");
	level.player notify("primary_equipment_switch");
}

//Function Number: 15
func_1419()
{
	var_00 = level.player.var_110BA;
	self giveweapon(var_00);
	self setweaponammoclip(var_00,level.player.var_110BB);
	self playsound("plr_switch_equipment");
	level.player notify("secondary_equipment_switch");
	if(var_00 == "offhandshield" && scripts\sp\_utility::func_9CB5())
	{
		scripts\common\utility::func_1C56(0);
		scripts\sp\_utility::func_13662();
		scripts\common\utility::func_1C56(1);
	}
}

//Function Number: 16
func_11429()
{
	level.player.var_C399 = undefined;
	level.player.var_C397 = undefined;
	level.player.var_C39A = undefined;
	level.player.var_C398 = undefined;
	level.player.var_C38D = undefined;
	level.player.var_C386 = undefined;
	level.player.var_C38E = undefined;
	level.player.var_C387 = undefined;
	if(isdefined(level.player.var_110BD))
	{
		if(!scripts\sp\_utility::func_93A6() || !scripts\sp\_utility::func_93AC() || level.player.var_110BD != "nanoshot")
		{
			level.player.var_C399 = level.player.var_110BD;
			level.player.var_C39A = level.player.var_110BE;
			level.player.var_110BD = "";
			level.player.var_110BE = 0;
		}
	}

	if(isdefined(level.player.var_110BA))
	{
		if(!scripts\sp\_utility::func_93A6() || !scripts\sp\_utility::func_93AC() || level.player.var_110BA != "helmet")
		{
			level.player.var_C397 = level.player.var_110BA;
			level.player.var_C398 = level.player.var_110BB;
			level.player.var_110BA = "";
			level.player.var_110BB = 0;
		}
	}

	var_00 = level.player getweaponslistoffhands();
	var_01 = undefined;
	var_02 = undefined;
	for(var_03 = 0;var_03 < var_00.size;var_03++)
	{
		if(scripts\sp\_utility::func_93A6() && scripts\sp\_utility::func_93AC())
		{
			if(var_00[var_03] == "nanoshot" || var_00[var_03] == "helmet")
			{
				continue;
			}
		}

		if(lib_0B29::func_12F5(var_00[var_03]))
		{
			var_01 = var_00[var_03];
		}

		if(lib_0B29::func_12F1(var_00[var_03]))
		{
			var_02 = var_00[var_03];
		}
	}

	if(isdefined(var_01))
	{
		level.player.var_C38D = var_01;
		level.player.var_C38E = level.player method_80FB(var_01);
		level.player takeweapon(var_01);
	}

	if(isdefined(var_02))
	{
		level.player.var_C386 = var_02;
		level.player.var_C387 = level.player method_80FB(var_02);
		level.player takeweapon(var_02);
	}
}

//Function Number: 17
func_E2C0()
{
	if(isdefined(level.player.var_C38D) && level.player.var_C38D != "")
	{
		level.player giveweapon(level.player.var_C38D);
		level.player setweaponammoclip(level.player.var_C38D,level.player.var_C38E);
	}

	if(isdefined(level.player.var_C386) && level.player.var_C386 != "")
	{
		level.player giveweapon(level.player.var_C386);
		level.player setweaponammoclip(level.player.var_C386,level.player.var_C387);
	}

	if(isdefined(level.player.var_C399) && level.player.var_C399 != "")
	{
		level.player giveweapon(level.player.var_C399);
		level.player setweaponammoclip(level.player.var_C399,level.player.var_C39A);
	}

	if(isdefined(level.player.var_C397) && level.player.var_C397 != "")
	{
		level.player giveweapon(level.player.var_C397);
		level.player setweaponammoclip(level.player.var_C397,level.player.var_C398);
	}

	level.player.var_C399 = undefined;
	level.player.var_C397 = undefined;
	level.player.var_C39A = undefined;
	level.player.var_C398 = undefined;
	level.player.var_C38D = undefined;
	level.player.var_C386 = undefined;
	level.player.var_C38E = undefined;
	level.player.var_C387 = undefined;
}