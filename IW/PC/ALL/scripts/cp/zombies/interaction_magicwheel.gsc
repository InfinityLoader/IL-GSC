/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\cp\zombies\interaction_magicwheel.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 40
 * Decompile Time: 1888 ms
 * Timestamp: 10/27/2023 12:26:52 AM
*******************************************************************/

//Function Number: 1
set_magic_wheel_starting_location(param_00)
{
	level.var_B161 = param_00;
	level.var_A8E2 = param_00;
}

//Function Number: 2
func_94EF()
{
	wait(2);
	level.currentweaponlist = [];
	level.activewheels = 0;
	level.current_active_wheel = undefined;
	level.var_13D01 = 0;
	level.var_B162 = 0;
	level.var_B160 = [];
	level.var_6D28 = ::func_10C4D;
	level.var_B163 = getentarray("magic_wheel","script_noteworthy");
	foreach(var_01 in level.var_B163)
	{
		var_01.origin = var_01.origin + (0,0,0.15);
		var_01.var_2135 = func_7828(var_01);
		if(isdefined(var_01.var_2135))
		{
			level.var_B160[level.var_B160.size] = var_01.var_2135;
		}

		var_01.var_E74A = func_7C20();
		var_01.var_13C25 = func_7ABF();
		var_02 = scripts\common\utility::getclosest(var_01.origin,scripts\common\utility::getstructarray("spinner","script_noteworthy"));
		var_03 = spawn("script_model",var_02.origin + (0,0,0.15));
		if(!isdefined(var_02.angles))
		{
			var_02.angles = (0,0,0);
		}

		var_03.angles = var_02.angles;
		var_03 setmodel("zmb_magic_wheel_spinner");
		var_01.var_10A03 = var_03;
		var_01 method_8318(1);
		level thread init_magic_wheel(var_01);
		var_01 thread func_13643();
		scripts\common\utility::func_136F7();
	}
}

//Function Number: 3
magic_wheel_tutorial()
{
	self endon("death");
	self endon("disconnect");
	self endon("saw_wheel_tutorial");
	wait(5);
	var_00 = cos(65);
	for(;;)
	{
		var_01 = level.var_B163;
		var_02 = sortbydistance(var_01,self.origin);
		if(!self.var_8EB0 && var_02.size > 0)
		{
			if(distancesquared(var_02[0].origin,self.origin) < 9216 && scripts\common\utility::func_13D90(self.origin,self.angles,var_02[0].origin,var_00))
			{
				thread scripts\cp\_hud_message::func_12AAE("magic_wheel");
				wait(1);
				self notify("saw_wheel_tutorial");
			}
		}

		wait(0.25);
	}
}

//Function Number: 4
func_7ABF()
{
	return scripts\common\utility::func_22A8(level.var_B15E);
}

//Function Number: 5
func_13643()
{
	self endon("delete_wheel");
	for(;;)
	{
		self waittill("trigger",var_00);
		if(!var_00 scripts\cp\_utility::is_valid_player())
		{
			continue;
		}

		var_01 = scripts\common\utility::istrue(self.var_8B7D);
		if(var_01)
		{
			level thread func_51EB(self,var_00,1);
			continue;
		}

		if(isdefined(level.wheel_purchase_check))
		{
			var_01 = [[ level.wheel_purchase_check ]](self,var_00);
			if(var_01)
			{
				level thread [[ level.wheel_hint_func ]](self,var_00,1);
				continue;
			}
		}

		if(scripts\common\utility::func_6E34("fire_sale") && scripts\common\utility::flag("fire_sale"))
		{
			var_02 = 10;
		}
		else
		{
			var_02 = 950;
		}

		if(isdefined(level.meph_fight_started))
		{
			var_02 = 0;
		}

		if(var_00 scripts\cp\_persistence::func_D0BB(var_02))
		{
			var_00 scripts\cp\_persistence::func_11445(var_02,1,"magic_wheel");
			func_12FFA(var_00,self,var_02);
			var_00 notify("magic_wheel_used");
			continue;
		}

		level thread func_51EB(self,var_00);
	}
}

//Function Number: 6
func_51EB(param_00,param_01,param_02)
{
	param_01 endon("disconnect");
	param_01 playlocalsound("purchase_deny");
	if(isdefined(param_02))
	{
		param_01 method_80F4(&"COOP_INTERACTIONS_CANNOT_BUY");
	}
	else
	{
		param_01 thread scripts\cp\_vo::try_to_play_vo("no_cash","zmb_comment_vo","high",30,0,0,1,50);
		param_01 method_80F4(&"COOP_INTERACTIONS_NEED_MONEY");
	}

	wait(1);
	param_01 method_80F3();
}

//Function Number: 7
func_BC3F()
{
	for(;;)
	{
		var_00 = scripts\common\utility::random(level.var_B160);
		if(var_00 != level.var_A8E2)
		{
			func_BC3E(var_00);
			return;
		}
	}
}

//Function Number: 8
func_BC3E(param_00)
{
	level.var_A8E2 = param_00;
	if(isdefined(level.show_wheel_location_func))
	{
		level thread [[ level.show_wheel_location_func ]](param_00);
	}

	foreach(var_02 in level.var_B163)
	{
		if(!isdefined(var_02.var_2135))
		{
			continue;
		}

		if(var_02.var_2135 == param_00)
		{
			func_100ED(var_02);
			level.current_active_wheel = var_02;
			continue;
		}

		func_8E95(var_02);
	}
}

//Function Number: 9
init_magic_wheel(param_00)
{
	if(!isdefined(param_00.var_2135))
	{
		return;
	}

	if(param_00.var_2135 != level.var_B161)
	{
		level thread func_8E95(param_00);
		return;
	}

	param_00 setscriptablepartstate("base","on");
	param_00 setscriptablepartstate("fx",get_default_fx_state());
	param_00.var_10A03 setscriptablepartstate("spinner","idle");
	var_01 = getentarray("out_of_order","script_noteworthy");
	var_02 = scripts\common\utility::getclosest(param_00.origin,var_01);
	var_02 hide();
	param_00 makeusable();
	param_00 method_84A7("tag_use");
	param_00 method_84A5(60);
	param_00 method_84A2(72);
	level.current_active_wheel = param_00;
	if(isdefined(level.magic_wheel_spin_hint))
	{
		param_00 sethintstring(level.magic_wheel_spin_hint);
		return;
	}

	param_00 sethintstring(&"CP_ZMB_INTERACTIONS_SPIN_WHEEL");
}

//Function Number: 10
func_8E95(param_00)
{
	while(scripts\common\utility::istrue(param_00.var_9B04))
	{
		wait(0.05);
	}

	param_00 makeunusable();
	param_00 setscriptablepartstate("base","off");
	param_00 setscriptablepartstate("fx","off");
	param_00.var_10A03 setscriptablepartstate("spinner","off");
	var_01 = getentarray("out_of_order","script_noteworthy");
	var_02 = scripts\common\utility::getclosest(param_00.origin,var_01);
	playfx(level._effect["vfx_magicwheel_fire"],var_02.origin);
	wait(0.5);
	var_02 show();
}

//Function Number: 11
func_100ED(param_00)
{
	param_00 setscriptablepartstate("fx","hideshow");
	param_00 setscriptablepartstate("base","on");
	param_00.var_10A03 setscriptablepartstate("spinner","activate");
	var_01 = getentarray("out_of_order","script_noteworthy");
	var_02 = scripts\common\utility::getclosest(param_00.origin,var_01);
	playfx(level._effect["vfx_magicwheel_fire"],var_02.origin);
	wait(0.5);
	var_02 hide();
	var_03 = get_default_fx_state();
	if(scripts\common\utility::flag("fire_sale"))
	{
		var_03 = "firesale";
	}

	param_00 setscriptablepartstate("fx",var_03);
	wait(1);
	param_00.var_10A03 setscriptablepartstate("spinner","idle");
	param_00 makeusable();
	param_00 method_84A7("tag_use");
	param_00 method_84A5(60);
	param_00 method_84A2(72);
	if(scripts\common\utility::func_6E34("fire_sale") && scripts\common\utility::flag("fire_sale"))
	{
		param_00 sethintstring(&"COOP_INTERACTIONS_SPIN_WHEEL_FIRE_SALE");
		return;
	}

	if(isdefined(level.magic_wheel_spin_hint))
	{
		param_00 sethintstring(level.magic_wheel_spin_hint);
		return;
	}

	param_00 sethintstring(&"CP_ZMB_INTERACTIONS_SPIN_WHEEL");
}

//Function Number: 12
get_default_fx_state()
{
	if(scripts\common\utility::istrue(level.magic_wheel_upgraded_pap1) && should_play_upgraded_magic_wheel_vfx())
	{
		return "upgrade";
	}

	if(scripts\common\utility::istrue(level.magic_wheel_upgraded_pap2) && should_play_upgraded_magic_wheel_vfx())
	{
		return "upgrade";
	}

	return "normal";
}

//Function Number: 13
should_play_upgraded_magic_wheel_vfx()
{
	switch(level.script)
	{
		case "cp_disco":
			if(scripts\common\utility::istrue(level.complete_skull_buster))
			{
				return 1;
			}
			else
			{
				return 0;
			}
	
			break;

		default:
			return 0;
	}
}

//Function Number: 14
func_7828(param_00)
{
	var_01 = getentarray("spawn_volume","targetname");
	foreach(var_03 in var_01)
	{
		if(function_010F(param_00.origin + (0,0,50),var_03))
		{
			if(isdefined(var_03.var_28AB))
			{
				return var_03.var_28AB;
			}
		}
	}

	return undefined;
}

//Function Number: 15
func_12FFA(param_00,param_01,param_02)
{
	level notify("magicWheelUsed");
	param_01 makeunusable();
	param_00.var_13103 = 1;
	param_01.var_10A05 = 1;
	param_01.var_9B04 = 1;
	param_00 playlocalsound("zmb_wheel_spin_buy");
	var_03 = scripts\common\utility::getclosest(param_01.origin,scripts\common\utility::getstructarray("wheel_fx_spot","targetname"));
	param_01 setscriptablepartstate("spin_light","on");
	scripts\common\utility::func_136F7();
	var_04 = param_00 getweaponslistall();
	var_05 = [];
	foreach(var_07 in param_01.var_13C25)
	{
		var_08 = scripts\cp\_utility::func_7DF7(var_07);
		var_09 = 0;
		foreach(var_0B in var_04)
		{
			var_0C = scripts\cp\_utility::func_7DF7(var_0B);
			if(var_0C == var_08 || issubstr(var_0C,var_08))
			{
				var_09 = 1;
				break;
			}
		}

		if(!var_09)
		{
			var_0E = var_07;
			var_0F = scripts\cp\_utility::func_80D8(var_07);
			if(isdefined(param_00.var_13C00[var_0F]))
			{
				var_0E = param_00.var_13C00[var_0F];
			}

			var_05[var_05.size] = var_0E;
		}
	}

	scripts\cp\zombies\zombie_analytics::func_AF79(level.wave_num);
	param_01.var_13C25 = var_05;
	level thread func_1010C(param_01,param_00);
	level thread func_13D00(param_01);
	param_01.var_10A03 setscriptablepartstate("spinner","spinning");
	param_01.var_10A03 rotatepitch(param_01.var_E74A,5,1,4);
	param_01.var_10A03 waittill("rotatedone");
	param_01.var_10A05 = 0;
	param_01 waittill("ready");
	if(!level.var_B162)
	{
		param_01.var_10A03 setscriptablepartstate("spinner","idle");
	}

	param_01.var_9B04 = 0;
	param_01 setscriptablepartstate("spin_light","off");
	if(!scripts\common\utility::func_6E34("fire_sale") || !scripts\common\utility::flag("fire_sale"))
	{
		if(level.var_B162)
		{
			if(isdefined(param_00))
			{
				param_00 scripts\cp\_persistence::func_82F9(param_02,undefined,undefined,1,"magicWheelRefund");
			}

			level.var_B162 = 0;
			wait(0.5);
			if(isdefined(param_01.var_394))
			{
				param_01.var_394 delete();
			}

			func_BC3F();
			return;
		}

		wait(0.5);
		if(param_01 != level.current_active_wheel)
		{
			level thread func_8E95(param_01);
			return;
		}

		param_01 makeusable();
		param_01 method_84A7("tag_use");
		param_01 method_84A5(60);
		param_01 method_84A2(72);
		return;
	}

	wait(0.5);
	param_01 makeusable();
	param_01 method_84A7("tag_use");
	param_01 method_84A5(60);
	param_01 method_84A2(72);
}

//Function Number: 16
func_13D00(param_00)
{
	while(!isdefined(param_00.var_394))
	{
		wait(0.05);
	}

	while(param_00.var_10A05)
	{
		var_01 = param_00.var_394.var_8293;
		wait(0.05);
	}
}

//Function Number: 17
func_7B18(param_00)
{
	var_01 = 21 / param_00.var_E74A / 5 * 0.05;
	if(var_01 - int(var_01) > 0)
	{
		var_01 = int(var_01) + 1;
	}
	else
	{
		var_01 = int(var_01);
	}

	param_00.var_E74D = var_01 * 0.05;
	var_02 = randomint(param_00.var_13C25.size);
	return param_00.var_13C25[var_02];
}

//Function Number: 18
can_have_nunchucks(param_00)
{
	if(param_00.var_134FD != "p5_")
	{
		return 0;
	}

	var_01 = param_00 getplayerdata("cp","alienSession","escapedRank0");
	var_02 = param_00 getplayerdata("cp","alienSession","escapedRank1");
	var_03 = param_00 getplayerdata("cp","alienSession","escapedRank2");
	var_04 = param_00 getplayerdata("cp","alienSession","escapedRank3");
	if(isdefined(var_01) && var_01 == 1)
	{
		return 1;
	}

	if(isdefined(var_02) && var_02 == 1)
	{
		return 1;
	}

	if(isdefined(var_03) && var_03 == 1)
	{
		return 1;
	}

	if(isdefined(var_04) && var_04 == 1)
	{
		return 1;
	}

	return 0;
}

//Function Number: 19
get_weapon_with_new_camo(param_00,param_01,param_02)
{
	var_03 = getweaponbasename(param_01);
	var_04 = function_00E3(param_01);
	if(issubstr(var_03,"nunchucks") || issubstr(var_03,"venomx"))
	{
	}

	return param_00 scripts\cp\_weapon::func_E469(var_03,undefined,var_04,undefined,param_02);
}

//Function Number: 20
func_1010C(param_00,param_01)
{
	if(scripts\common\utility::flag("fire_sale"))
	{
		param_00.fire_sale_spin = 1;
	}

	var_02 = undefined;
	param_00.var_BF6D = func_7B18(param_00);
	if(isdefined(level.nextwheelweaponfunc))
	{
		param_00.var_BF6D = [[ level.nextwheelweaponfunc ]](param_00,param_00.var_BF6D,param_01);
	}

	if(level.script == "cp_disco")
	{
		if(scripts\common\utility::istrue(param_01.finished_backstory) && !scripts\common\utility::istrue(param_01.given_nunchucks))
		{
			var_03 = "";
			if(scripts\common\utility::istrue(level.magic_wheel_upgraded_pap2))
			{
				param_00.var_13C25 = scripts\common\utility::array_add(param_00.var_13C25,"iw7_nunchucks_zm_pap2");
				var_03 = "iw7_nunchucks_zm_pap2";
			}
			else if(scripts\common\utility::istrue(level.magic_wheel_upgraded_pap1) && !param_01 scripts\cp\_utility::func_9BA0("magic_wheel_upgrade"))
			{
				var_03 = "iw7_nunchucks_zm_pap1";
				param_00.var_13C25 = scripts\common\utility::array_add(param_00.var_13C25,"iw7_nunchucks_zm_pap1");
			}
			else if(!scripts\common\utility::istrue(level.magic_wheel_upgraded_pap1) && param_01 scripts\cp\_utility::func_9BA0("magic_wheel_upgrade"))
			{
				var_03 = "iw7_nunchucks_zm_pap1";
			}
			else if(scripts\common\utility::istrue(level.magic_wheel_upgraded_pap1) && param_01 scripts\cp\_utility::func_9BA0("magic_wheel_upgrade"))
			{
				param_00.var_13C25 = scripts\common\utility::array_add(param_00.var_13C25,"iw7_nunchucks_zm_pap2");
				var_03 = "iw7_nunchucks_zm_pap2";
			}

			if(var_03 != "")
			{
				param_00.var_BF6D = var_03;
			}
			else
			{
				param_00.var_13C25 = scripts\common\utility::array_add(param_00.var_13C25,"iw7_nunchucks_zm");
				param_00.var_BF6D = "iw7_nunchucks_zm";
			}

			param_01.given_nunchucks = 1;
		}
		else if(randomint(100) > 95 || getdvar("debug_gns_reward") != "")
		{
			if(!has_nunchucks_in_loadout(param_01) && scripts\cp\zombies\directors_cut::directors_cut_is_activated() || can_have_nunchucks(param_01))
			{
				var_03 = "";
				if(scripts\common\utility::istrue(level.magic_wheel_upgraded_pap2))
				{
					param_00.var_13C25 = scripts\common\utility::array_add(param_00.var_13C25,"iw7_nunchucks_zm_pap2");
					var_03 = "iw7_nunchucks_zm_pap2";
				}
				else if(scripts\cp\zombies\directors_cut::directors_cut_is_activated())
				{
					if(param_01 scripts\cp\_utility::func_9BA0("magic_wheel_upgrade") && scripts\common\utility::istrue(level.magic_wheel_upgraded_pap1))
					{
						var_03 = "iw7_nunchucks_zm_pap2";
						param_00.var_13C25 = scripts\common\utility::array_add(param_00.var_13C25,var_03);
					}
					else
					{
						var_03 = "iw7_nunchucks_zm_pap1";
					}
				}
				else if(scripts\common\utility::istrue(level.magic_wheel_upgraded_pap1) && !param_01 scripts\cp\_utility::func_9BA0("magic_wheel_upgrade"))
				{
					var_03 = "iw7_nunchucks_zm_pap1";
					param_00.var_13C25 = scripts\common\utility::array_add(param_00.var_13C25,"iw7_nunchucks_zm_pap1");
				}
				else if(!scripts\common\utility::istrue(level.magic_wheel_upgraded_pap1) && param_01 scripts\cp\_utility::func_9BA0("magic_wheel_upgrade"))
				{
					var_03 = "iw7_nunchucks_zm_pap1";
				}
				else if(scripts\common\utility::istrue(level.magic_wheel_upgraded_pap1) && param_01 scripts\cp\_utility::func_9BA0("magic_wheel_upgrade"))
				{
					param_00.var_13C25 = scripts\common\utility::array_add(param_00.var_13C25,"iw7_nunchucks_zm_pap2");
					var_03 = "iw7_nunchucks_zm_pap2";
				}

				if(var_03 != "")
				{
					param_00.var_BF6D = var_03;
				}
				else
				{
					param_00.var_13C25 = scripts\common\utility::array_add(param_00.var_13C25,"iw7_nunchucks_zm");
					param_00.var_BF6D = "iw7_nunchucks_zm";
				}
			}
		}
	}

	if(level.script == "cp_final")
	{
		if(randomint(100) > 95)
		{
			if(!has_venomx_in_loadout(param_01) && scripts\cp\zombies\directors_cut::directors_cut_is_activated() || can_have_venomx(param_01))
			{
				var_03 = "";
				if(scripts\common\utility::istrue(level.magic_wheel_upgraded_pap2))
				{
					param_00.var_13C25 = scripts\common\utility::array_add(param_00.var_13C25,"iw7_venomx_zm_pap2+camo34");
					var_03 = "iw7_venomx_zm_pap2+camo34";
				}
				else if(scripts\cp\zombies\directors_cut::directors_cut_is_activated())
				{
					if(param_01 scripts\cp\_utility::func_9BA0("magic_wheel_upgrade"))
					{
						var_03 = "iw7_venomx_zm_pap2+camo34";
					}
					else
					{
						var_03 = "iw7_venomx_zm_pap1+camo32";
					}
				}
				else if(scripts\common\utility::istrue(level.magic_wheel_upgraded_pap1) && !param_01 scripts\cp\_utility::func_9BA0("magic_wheel_upgrade"))
				{
					var_03 = "iw7_venomx_zm_pap1+camo32";
					param_00.var_13C25 = scripts\common\utility::array_add(param_00.var_13C25,"iw7_venomx_zm_pap1+camo32");
				}
				else if(!scripts\common\utility::istrue(level.magic_wheel_upgraded_pap1) && param_01 scripts\cp\_utility::func_9BA0("magic_wheel_upgrade"))
				{
					var_03 = "iw7_venomx_zm_pap1+camo32";
				}
				else if(scripts\common\utility::istrue(level.magic_wheel_upgraded_pap1) && param_01 scripts\cp\_utility::func_9BA0("magic_wheel_upgrade"))
				{
					param_00.var_13C25 = scripts\common\utility::func_22A9(param_00.var_13C25,"iw7_venomx_zm_pap1+camo32");
					param_00.var_13C25 = scripts\common\utility::array_add(param_00.var_13C25,"iw7_venomx_zm_pap2+camo34");
					var_03 = "iw7_venomx_zm_pap2+camo34";
				}

				if(var_03 != "")
				{
					param_00.var_BF6D = var_03;
					param_00.var_13C25 = scripts\common\utility::array_add(param_00.var_13C25,var_03);
				}
				else
				{
					param_00.var_13C25 = scripts\common\utility::array_add(param_00.var_13C25,"iw7_venomx_zm");
					param_00.var_BF6D = "iw7_venomx_zm";
				}
			}
		}
	}

	var_04 = getweaponindexfromlist(param_00.var_BF6D,param_00.var_13C25);
	if(scripts\common\utility::func_2286(param_00.var_13C25,"iw7_forgefreeze_zm+forgefreezealtfire"))
	{
		param_00.var_13C25 = scripts\common\utility::func_22A9(param_00.var_13C25,"iw7_forgefreeze_zm+forgefreezealtfire");
	}

	param_01 loadweaponsforplayer([param_00.var_BF6D],1);
	if(level.currentweaponlist.size > 0)
	{
		var_05 = level.currentweaponlist;
	}
	else
	{
		var_05 = getrotationlist(param_01.var_13C25);
	}

	if(scripts\common\utility::istrue(level.magic_wheel_upgraded_pap1) || scripts\common\utility::istrue(level.magic_wheel_upgraded_pap2))
	{
		foreach(var_08, var_07 in var_05)
		{
			var_05[var_08] = get_weapon_with_new_camo(param_01,var_07,get_camo_for_upgraded_weapon(getweaponbasename(var_07),param_01));
		}
	}

	level.activewheels++;
	level.currentweaponlist = var_05;
	loadworldweapons(var_05);
	var_09 = -1;
	var_0A = 0;
	var_0B = scripts\common\utility::getclosest(param_00.origin,scripts\common\utility::getstructarray("wheel_fx_spot","targetname"));
	param_00.var_394 = undefined;
	while(param_00.var_10A05)
	{
		wait(param_00.var_E74D);
		param_00 playsound("zmb_wheel_spin_tick");
		var_09++;
		if(isdefined(param_00.var_394))
		{
			param_00.var_394 method_8536(var_05[var_09]);
		}
		else
		{
			param_00.var_394 = spawn("script_weapon",var_0B.origin,0,0,var_05[var_09]);
			if(isdefined(var_0B.angles))
			{
				param_00.var_394.angles = var_0B.angles;
			}
			else
			{
				param_00.var_394.angles = (0,0,0);
			}
		}

		param_00.var_394.var_8293 = var_05[var_09];
		if(var_09 >= var_05.size - 1)
		{
			var_09 = -1;
		}

		var_0A++;
	}

	param_00.var_394.var_8293 = param_00.var_13C25[var_04];
	if((isdefined(param_01) && isplayer(param_01) && scripts\common\utility::istrue(level.magic_wheel_upgraded_pap1)) || scripts\common\utility::istrue(level.magic_wheel_upgraded_pap2))
	{
		param_00.var_394 method_8536(get_weapon_with_new_camo(param_01,param_00.var_394.var_8293,get_camo_for_upgraded_weapon(getweaponbasename(param_00.var_394.var_8293),param_01)));
	}
	else
	{
		param_00.var_394 method_8536(param_00.var_394.var_8293);
	}

	level.activewheels--;
	if(level.activewheels < 0)
	{
		level.activewheels = 0;
	}

	if(!level.activewheels)
	{
		function_02EB();
		level.currentweaponlist = [];
	}

	var_0E = lib_0D41::func_801F(param_00.var_13C25[var_04]);
	param_00.var_394.origin = var_0B.origin + var_0E;
	playsoundatpos(param_00.origin,"zmb_wheel_spin_end");
	if(!isdefined(param_00.fire_sale_spin) && !scripts\common\utility::func_6E34("fire_sale") || !scripts\common\utility::flag("fire_sale"))
	{
		level.var_13D01++;
		var_0F = randomint(100);
		if(scripts\common\utility::istrue(level.meph_fight_started))
		{
			level.var_13D01 = 0;
		}

		if(level.var_13D01 == 7)
		{
			var_0F = 100;
		}

		if(var_0F > 50 && level.var_13D01 > 4)
		{
			level.var_B162 = 1;
			var_10 = param_00.var_394.origin;
			if(isdefined(param_00.var_394))
			{
				param_00.var_394 delete();
			}

			var_11 = spawn("script_model",var_10);
			var_11 setmodel("zmb_arcade_toy_astronaut_blue");
			var_11.angles = param_00.angles;
			var_11 thread func_BC9C();
			param_00.var_10A03 setscriptablepartstate("spinner","timetomove");
			level thread func_B16B(param_01);
			wait(3);
			param_00.var_10A03 setscriptablepartstate("spinner","deactivate");
			param_00 setscriptablepartstate("base","off");
			wait(2);
			level.var_13D01 = 0;
			param_00 setscriptablepartstate("fx","hideshow");
			param_00 setscriptablepartstate("spin_light","off");
			param_01.var_13103 = undefined;
			param_00 notify("ready");
			return;
		}
	}

	var_02.fire_sale_spin = undefined;
	var_02.var_394 makeusable();
	foreach(var_13 in level.players)
	{
		if(var_13 == var_04)
		{
			var_02.var_394 enableplayeruse(var_13);
			continue;
		}

		var_02.var_394 disableplayeruse(var_13);
	}

	var_02.var_394 thread func_1360B(var_02);
	var_02.var_394 scripts\common\utility::waittill_any_timeout_1(12,"weapon_taken");
	var_02.var_394 delete();
	if(scripts\common\utility::func_2286(var_02.var_13C25,"iw7_nunchucks_zm"))
	{
		var_02.var_13C25 = scripts\common\utility::func_22A9(var_02.var_13C25,"iw7_nunchucks_zm");
	}
	else if(scripts\common\utility::func_2286(var_02.var_13C25,"iw7_nunchucks_zm_pap2"))
	{
		var_02.var_13C25 = scripts\common\utility::func_22A9(var_02.var_13C25,"iw7_nunchucks_zm_pap2");
	}

	if(scripts\common\utility::func_2286(var_02.var_13C25,"iw7_venomx_zm_pap1+camo32"))
	{
		var_02.var_13C25 = scripts\common\utility::func_22A9(var_02.var_13C25,"iw7_venomx_zm_pap1+camo32");
	}
	else if(scripts\common\utility::func_2286(var_02.var_13C25,"iw7_venomx_zm_pap2+camo34"))
	{
		var_02.var_13C25 = scripts\common\utility::func_22A9(var_02.var_13C25,"iw7_venomx_zm_pap2+camo34");
	}

	var_02 setscriptablepartstate("spin_light","off");
	var_02.var_13C25 = func_7ABF();
	var_02.var_E74A = func_7C20();
	var_04.var_13103 = undefined;
	var_02 notify("ready");
}

//Function Number: 21
can_have_venomx(param_00)
{
	if(scripts\common\utility::func_6E34("completepuzzles_step4") && scripts\common\utility::flag("completepuzzles_step4"))
	{
		if(!has_venomx_in_loadout(param_00))
		{
			return 1;
		}

		return 0;
	}

	return 0;
}

//Function Number: 22
has_venomx_in_loadout(param_00)
{
	var_01 = param_00 getweaponslistall();
	foreach(var_03 in var_01)
	{
		if(issubstr(var_03,"venomx"))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 23
has_nunchucks_in_loadout(param_00)
{
	var_01 = param_00 getweaponslistall();
	foreach(var_03 in var_01)
	{
		if(issubstr(var_03,"nunchucks"))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 24
getrotationlist(param_00)
{
	var_01 = [];
	for(var_02 = 0;var_02 < 8;var_02++)
	{
		var_01[var_02] = param_00[var_02];
	}

	return var_01;
}

//Function Number: 25
getweaponindexfromlist(param_00,param_01)
{
	for(var_02 = 0;var_02 < param_01.size;var_02++)
	{
		if(param_00 == param_01[var_02])
		{
			return var_02;
		}
	}

	return 0;
}

//Function Number: 26
func_B16B(param_00)
{
	param_00 endon("disconnect");
	level endon("game_ended");
	level thread scripts\cp\_vo::try_to_play_vo("ww_magicbox_laughter","zmb_announcer_vo","highest",5,0,0,1);
	wait(4);
	param_00 thread scripts\cp\_vo::try_to_play_vo("magicwheel_badspin","zmb_comment_vo","low",30,0,0,1);
}

//Function Number: 27
func_7C20()
{
	var_00 = 1440;
	if(randomint(100) > 50)
	{
		var_00 = 1080;
	}

	return var_00;
}

//Function Number: 28
func_BC9C()
{
	self movez(50,3,2,1);
	self rotateroll(-10,1);
	wait(1);
	self rotateroll(10,1);
	wait(1);
	self rotateroll(-10,0.5);
	wait(0.5);
	self rotateroll(10,0.5);
	wait(0.5);
	playfx(level._effect["vfx_magicwheel_toy_pop"],self.origin);
	self delete();
}

//Function Number: 29
func_45FC(param_00)
{
}

//Function Number: 30
func_7A37(param_00,param_01)
{
	var_02 = getarraykeys(param_00);
	for(var_03 = 0;var_03 < var_02.size;var_03++)
	{
		if(var_02[var_03] == param_01)
		{
			return var_03;
		}
	}
}

//Function Number: 31
func_782E(param_00,param_01)
{
	var_02 = getarraykeys(param_00);
	return param_00[var_02[param_01]];
}

//Function Number: 32
func_7D60(param_00)
{
	if(isdefined(level.coop_weapontable))
	{
		var_01 = level.coop_weapontable;
	}
	else
	{
		var_01 = "cp/cp_weapontable.csv";
	}

	return tablelookup(var_01,2,param_00,1);
}

//Function Number: 33
func_1360B(param_00)
{
	self endon("death");
	for(;;)
	{
		self waittill("trigger",var_01);
		if(var_01 ismeleeing() || var_01 meleebuttonpressed() || scripts\common\utility::istrue(var_01.var_9FCB))
		{
			continue;
		}

		if(isdefined(level.magicwheel_weapon_take_check))
		{
			if([[ level.magicwheel_weapon_take_check ]](param_00,var_01,self))
			{
				break;
			}
			else
			{
				continue;
			}
		}

		break;
	}

	if(isdefined(self.var_8293) && getsubstr(self.var_8293,0,5) == "power")
	{
		if(level.var_D782[self.var_8293].var_504B == "secondary")
		{
			var_01 scripts\cp\powers\coop_powers::func_8397(self.var_8293,level.var_D782[self.var_8293].var_504B,undefined,undefined,undefined,0,0);
		}
		else
		{
			var_01 scripts\cp\powers\coop_powers::func_8397(self.var_8293,level.var_D782[self.var_8293].var_504B,undefined,undefined,undefined,0,1);
		}
	}
	else
	{
		var_02 = self.var_8293;
		func_B16A(var_01,var_02);
		var_03 = scripts\cp\_utility::func_80D8(var_02);
		switch(var_03)
		{
			case "lmg03":
			case "sdflmg":
			case "mauler":
				var_01 thread scripts\cp\_vo::try_to_play_vo("magicwheel_weapon","zmb_comment_vo","low",10,0,1,0,25);
				break;

			case "katana":
				var_01 thread scripts\cp\_vo::try_to_play_vo("magicwheel_katana","zmb_comment_vo","low",10,0,1,0);
				break;

			case "venomx":
				var_01 thread scripts\cp\_vo::try_to_play_vo("magicwheel_venx","zmb_comment_vo","low",10,0,1,1,50);
				break;

			case "nunchucks":
				var_01 thread scripts\cp\_vo::try_to_play_vo("magicwheel_nunchucks","zmb_comment_vo","low",10,0,1,0);
				break;

			case "forgefreeze":
				var_01 thread scripts\cp\_vo::try_to_play_vo("magicwheel_weapon","zmb_comment_vo","low",10,0,1,0);
				break;

			case "glprox":
			case "chargeshot":
				var_01 thread scripts\cp\_vo::try_to_play_vo("magicwheel_weapon","zmb_comment_vo","low",10,0,1,0,40);
				break;

			case "cheytac":
			case "kbs":
				var_01 thread scripts\cp\_vo::try_to_play_vo("magicwheel_weapon","zmb_comment_vo","low",10,0,1,0,40);
				break;

			default:
				var_01 thread scripts\cp\_vo::try_to_play_vo("magicwheel_weapon","zmb_comment_vo","low",10,0,1,0,25);
				break;
		}
	}

	self notify("weapon_taken");
	param_00 notify("weapon_taken");
	param_00.var_BF6D = undefined;
	playsoundatpos(self.origin,"zmb_wheel_wpn_acquired");
}

//Function Number: 34
func_B16A(param_00,param_01)
{
	param_00 notify("weapon_purchased");
	if(scripts\common\utility::istrue(param_00.var_9FCB))
	{
		wait(0.5);
	}

	var_02 = undefined;
	if(scripts\cp\zombies\zmb_zombies_weapons::func_FFA6(param_00))
	{
		var_03 = param_00 scripts\cp\_utility::getvalidtakeweapon();
		var_04 = scripts\cp\_utility::func_80D8(var_03);
		param_00 takeweapon(var_03);
		if(isdefined(param_00.var_C8A2[var_04]))
		{
			param_00.var_C8A2[var_04] = undefined;
			param_00 notify("weapon_level_changed");
		}
	}

	var_05 = scripts\cp\_utility::func_80D8(param_01);
	param_00 scripts\cp\_utility::take_fists_weapon(param_00);
	if(isdefined(param_00.var_13C00[var_05]))
	{
		param_01 = param_00.var_13C00[var_05];
	}

	if(param_00 scripts\cp\_weapon::func_385F(param_01) && is_magic_wheel_upgrades(param_00))
	{
		var_02 = get_camo_for_upgraded_weapon(var_05,param_00);
		var_06 = scripts\common\utility::array_combine(function_00E3(param_01),[get_attachment_for_upgraded_weapon(param_01,param_00)]);
		param_01 = param_00 scripts\cp\_weapon::func_E469(param_01,undefined,var_06,undefined,var_02);
		param_01 = param_00 scripts\cp\_utility::func_12C6(param_01,undefined,undefined,1);
		var_07 = scripts\cp\_utility::func_80D8(param_01);
		var_08 = spawnstruct();
		var_08.var_B111 = 2;
		if(scripts\common\utility::istrue(level.magic_wheel_upgraded_pap2))
		{
			var_08.var_B111 = 3;
		}

		param_00.var_C8A2[var_07] = var_08;
		param_00 notify("weapon_level_changed");
		param_00 scripts\cp\_merits::func_D9AD("mt_purchased_weapon");
		if(param_00 scripts\cp\_utility::func_9BA0("magic_wheel_upgrade"))
		{
			param_00 scripts\cp\_utility::func_C151("magic_wheel_upgrade");
		}
	}
	else
	{
		var_06 = function_00E3(var_05);
		var_02 = param_01 scripts\cp\_weapon::func_E469(var_02,undefined,var_08,undefined,undefined);
		var_02 = param_01 scripts\cp\_utility::func_12C6(var_02,undefined,undefined,0);
		var_08 = spawnstruct();
		var_08.var_B111 = 1;
		param_00.var_C8A2[var_05] = var_08;
		param_00 scripts\cp\_merits::func_D9AD("mt_purchased_weapon");
		param_00 notify("weapon_level_changed");
	}

	if(issubstr(param_01,"g18_") || level.script == "cp_final" && issubstr(param_01,"iw7_arclassic"))
	{
		param_00.var_8BA0 = 1;
	}

	if(issubstr(param_01,"udm45_"))
	{
		param_00 scripts\cp\_merits::func_D9AD("mt_udm_unlock");
	}

	if(issubstr(param_01,"rvn_"))
	{
		param_00 scripts\cp\_merits::func_D9AD("mt_rvn_unlock");
	}

	if(issubstr(param_01,"crdb_"))
	{
		param_00 scripts\cp\_merits::func_D9AD("mt_crdb_unlock");
	}

	if(issubstr(param_01,"vr_"))
	{
		param_00 scripts\cp\_merits::func_D9AD("mt_vr_unlock");
	}

	if(issubstr(param_01,"mp28_"))
	{
		param_00 scripts\cp\_merits::func_D9AD("mt_mp28_unlock");
	}

	if(issubstr(param_01,"minilmg_"))
	{
		param_00 scripts\cp\_merits::func_D9AD("mt_minilmg_unlock");
	}

	if(issubstr(param_01,"ba50cal_"))
	{
		param_00 scripts\cp\_merits::func_D9AD("mt_ba50cal_unlock");
	}

	if(issubstr(param_01,"mod2187_"))
	{
		param_00 scripts\cp\_merits::func_D9AD("mt_mod2187_unlock");
	}

	if(issubstr(param_01,"longshot_"))
	{
		param_00 scripts\cp\_merits::func_D9AD("mt_longshot_unlock");
	}

	if(issubstr(param_01,"gauss_"))
	{
		param_00 scripts\cp\_merits::func_D9AD("mt_gauss_unlock");
	}

	if(issubstr(param_01,"mag_"))
	{
		param_00 scripts\cp\_merits::func_D9AD("mt_mag_unlock");
	}

	if(issubstr(param_01,"unsalmg_"))
	{
		param_00 scripts\cp\_merits::func_D9AD("mt_unsalmg_unlock");
	}

	if(issubstr(param_01,"tacburst_"))
	{
		param_00 scripts\cp\_merits::func_D9AD("mt_tacburst_unlock");
	}

	param_00 notify("wor_item_pickup",param_01);
	param_00 givemaxammo(param_01);
	param_00 switchtoweapon(param_01);
}

//Function Number: 35
get_camo_for_upgraded_weapon(param_00,param_01)
{
	var_02 = undefined;
	if(isdefined(level.no_pap_camos) && scripts\common\utility::func_2286(level.no_pap_camos,param_00))
	{
		var_02 = undefined;
	}
	else if(scripts\common\utility::istrue(level.magic_wheel_upgraded_pap2) && isdefined(level.pap_2_camo))
	{
		var_02 = level.pap_2_camo;
	}
	else if(scripts\common\utility::istrue(level.magic_wheel_upgraded_pap1) && param_01 scripts\cp\_utility::func_9BA0("magic_wheel_upgrade") && isdefined(level.pap_2_camo))
	{
		var_02 = level.pap_2_camo;
	}
	else if(isdefined(level.pap_1_camo))
	{
		var_02 = level.pap_1_camo;
	}

	switch(param_00)
	{
		case "dischord":
		case "iw7_dischord_zm_pap1":
			var_02 = "camo20";
			break;

		case "facemelter":
		case "iw7_facemelter_zm_pap1":
			var_02 = "camo22";
			break;

		case "headcutter":
		case "iw7_headcutter_zm_pap1":
			var_02 = "camo21";
			break;

		case "shredder":
		case "iw7_shredder_zm_pap1":
			var_02 = "camo23";
			break;

		case "nunchucks":
			var_02 = "camo222";
			break;

		case "iw7_cutie_zm":
			var_02 = undefined;
			break;
	}

	return var_02;
}

//Function Number: 36
get_attachment_for_upgraded_weapon(param_00,param_01)
{
	if(issubstr(param_00,"venomx"))
	{
		return undefined;
	}

	if(issubstr(param_00,"nunchucks"))
	{
		return undefined;
	}

	if(issubstr(param_00,"dischord") || issubstr(param_00,"facemelter") || issubstr(param_00,"headcutter") || issubstr(param_00,"shredder"))
	{
		return "pap1";
	}

	if(scripts\common\utility::istrue(level.magic_wheel_upgraded_pap2))
	{
		return "pap2";
	}

	if(scripts\common\utility::istrue(level.magic_wheel_upgraded_pap1) && param_01 scripts\cp\_utility::func_9BA0("magic_wheel_upgrade"))
	{
		return "pap2";
	}

	return "pap1";
}

//Function Number: 37
is_magic_wheel_upgrades(param_00)
{
	if(param_00 scripts\cp\_utility::func_9BA0("magic_wheel_upgrade"))
	{
		return 1;
	}

	if(scripts\common\utility::istrue(level.magic_wheel_upgraded_pap2))
	{
		return 1;
	}

	if(scripts\common\utility::istrue(level.magic_wheel_upgraded_pap1))
	{
		return 1;
	}

	return 0;
}

//Function Number: 38
func_10C4D(param_00,param_01,param_02)
{
	level notify("activated" + param_00);
	level endon("activated" + param_00);
	level endon("deactivated" + param_00);
	level endon("game_ended");
	var_03 = undefined;
	level.var_163F["fire_sale"] = 1;
	scripts\common\utility::flag_set("fire_sale");
	foreach(var_05 in level.var_B163)
	{
		if(!isdefined(var_05.var_2135))
		{
			continue;
		}

		if(var_05.var_2135 == level.var_A8E2)
		{
			var_05 sethintstring(&"COOP_INTERACTIONS_SPIN_WHEEL_FIRE_SALE");
			var_03 = var_05;
			continue;
		}

		thread func_100ED(var_05);
	}

	level thread func_4DB4(param_00,param_01,var_03);
	foreach(var_08 in level.players)
	{
		if(isdefined(level.temporal_increase))
		{
			var_08 thread scripts\cp\zombies\_powerups::func_D73B(30 * level.temporal_increase,"fire_30");
			continue;
		}

		var_08 thread scripts\cp\zombies\_powerups::func_D73B(30,"fire_30");
	}
}

//Function Number: 39
func_4DB4(param_00,param_01,param_02)
{
	level endon("game_ended");
	var_03 = scripts\common\utility::waittill_any_timeout_1(param_01,"deactivated" + param_00,"activated" + param_00);
	if(var_03 != "activated" + param_00)
	{
		level.var_163F["fire_sale"] = 0;
		scripts\common\utility::func_6E2A("fire_sale");
		foreach(var_05 in level.var_B163)
		{
			if(!isdefined(var_05.var_2135))
			{
				continue;
			}

			if(!isdefined(param_02))
			{
				func_BC3F();
			}
			else if(var_05 == param_02)
			{
				if(isdefined(level.magic_wheel_spin_hint))
				{
					var_05 sethintstring(level.magic_wheel_spin_hint);
				}
				else
				{
					var_05 sethintstring(&"CP_ZMB_INTERACTIONS_SPIN_WHEEL");
				}

				continue;
			}

			var_05 makeunusable();
			thread func_8E95(var_05);
		}

		foreach(var_08 in level.players)
		{
			var_08.var_8B7B = undefined;
		}

		level notify("deactivated" + param_00);
		var_0A = 1;
		while(var_0A)
		{
			var_0B = 0;
			foreach(var_08 in level.players)
			{
				if(scripts\common\utility::istrue(var_08.var_13103))
				{
					wait(0.25);
					var_0B = 1;
					continue;
				}
			}

			if(!var_0B)
			{
				var_0A = 0;
			}
		}

		wait(0.25);
	}
}

//Function Number: 40
func_50DA(param_00)
{
	level endon("game_ended");
	param_00 scripts\common\utility::waittill_any_3("ready","weapon_taken");
	func_8E95(param_00);
}