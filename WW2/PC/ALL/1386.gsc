/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 1386.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 75
 * Decompile Time: 98 ms
 * Timestamp: 10/27/2023 3:25:57 AM
*******************************************************************/

//Function Number: 1
func_00D5()
{
	if(isdefined(level.var_6F5C))
	{
		return;
	}

	level.var_6F5C = [];
	func_532B("fastreload",3000,"reload_speed_buy",&"ZOMBIES_BUY_PERK_SPEEDY_RELOAD",::func_47B5,::func_95F1,"ui_zm_fastreload",undefined,undefined,&"ZOMBIES_HINT_PERK_SPEEDY_RELOAD",1);
	func_532B("punchperk",2000,"punch_perk_buy",&"ZOMBIES_BUY_PERK_PUNCH",::func_47B0,::func_95EF,"ui_zm_punchperk",undefined,undefined,&"ZOMBIES_HINT_PERK_PUNCH",2);
	func_532B("runperk",2000,"run_perk_buy",&"ZOMBIES_BUY_PERK_RUN",::func_47B8,::func_95F3,"ui_zm_runperk",undefined,undefined,&"ZOMBIES_HINT_PERK_RUN",3);
	func_532B("quickrevive",1500,"quickrevive_buy",&"ZOMBIES_BUY_PERK_REVIVE",::func_47B1,::func_95F0,"ui_zm_quickrevive",3,500,&"ZOMBIES_HINT_PERK_REVIVE",4);
	func_532B("electriccherry",2000,"electriccherry_buy",&"ZOMBIES_BUY_PERK_ELECTRIC_CHERRY",::func_4785,::func_95D5,"ui_zm_electriccherry",undefined,undefined,&"ZOMBIES_HINT_PERK_ELECTRIC_CHERRY",5);
	func_532B("doubletap",2000,"doubletap_buy",&"ZOMBIES_BUY_PERK_DOUBLE_TAP",::func_4784,::func_95D3,"ui_zm_doubletap",undefined,undefined,&"ZOMBIES_HINT_PERK_DOUBLE_TAP",6);
	func_532B("armor",500,"armor_buy",&"ZOMBIES_BUY_ARMOR",::cp_zmb_escape_init,::func_95D2,undefined,undefined,undefined,&"ZOMBIES_HINT_ARMOR");
	func_532B("perk_random",2000,"random_perk_buy",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	func_532B("perk_all",0,"all_perk_buy",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	func_532C("fastreload");
	func_532C("punchperk");
	func_532C("runperk");
	func_532C("quickrevive");
	func_532C("electriccherry");
	func_532C("doubletap");
	func_5295("armor");
	func_532C("perk_random");
	func_532C("perk_all");
	thread func_5F1E();
	level.var_611["care_package_allies_beacon"] = loadfx("vfx/lights/usa_carepackage_beacon");
	level.var_611["zmb_elec_cherry_zombie"] = loadfx("vfx/gameplay/mp/zombie/zmb_elec_cherry_zombie");
	level.var_611["zmb_elec_cherry_player"] = loadfx("vfx/gameplay/mp/zombie/zmb_elec_cherry_player");
	level.var_611["zmb_elec_cherry_wv"] = loadfx("vfx/gameplay/mp/zombie/zmb_elec_cherry_wv");
	level.var_611["zmb_pm_armor_use"] = loadfx("vfx/zombie/perk_machines/zmb_pm_armor_use");
	level.var_611["zmb_hand_blood"] = loadfx("vfx/zombie/perk_machines/zmb_hand_blood");
	level.var_611["zmb_pm_random_use"] = loadfx("vfx/zombie/perk_machines/zmb_pm_random_use");
	level thread maps\mp\_utility::func_6F74(::restore_tactical_usage_on_spawn);
}

//Function Number: 2
restore_tactical_usage_on_spawn()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("spectator_revive");
		if(!isdefined(self.zmb_plr_tactical))
		{
			continue;
		}

		if(lib_0547::func_5866(self.zmb_plr_tactical))
		{
			self method_831E(self.zmb_plr_tactical);
			if(!self hasweapon(self.zmb_plr_tactical))
			{
				lib_0586::func_78C(self.zmb_plr_tactical);
			}

			var_00 = 0;
			if(isdefined(level.persistent_ammo_tacticals) && common_scripts\utility::func_F79(level.persistent_ammo_tacticals,self.zmb_plr_tactical))
			{
				var_00 = 1;
			}

			self method_82FA(self.zmb_plr_tactical,var_00);
		}
	}
}

//Function Number: 3
func_420E(param_00)
{
	if(!common_scripts\utility::func_562E(level.var_5F5A))
	{
		if(param_00)
		{
			return 5;
		}

		return 4;
	}

	return 6;
}

//Function Number: 4
func_4506()
{
	return 200;
}

//Function Number: 5
func_6B6C()
{
	self.var_6F66 = [];
	self.var_6F67 = [];
	self.var_F60 = 0;
	var_00 = func_420E(lib_0547::func_4BA7("specialty_class_hoarder_zm"));
	self setclientomnvar("zm_blitz_items_limit",var_00);
}

//Function Number: 6
func_86E9(param_00)
{
	level.var_5F5A = param_00;
	foreach(var_02 in level.var_744A)
	{
		var_03 = func_420E(lib_0547::func_4BA7("specialty_class_hoarder_zm"));
		var_02 setclientomnvar("zm_blitz_items_limit",var_03);
	}
}

//Function Number: 7
func_532B(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A)
{
	var_0B = spawnstruct();
	var_0B.var_109 = param_00;
	var_0B.var_64F7 = param_01;
	var_0B.var_267B = param_01;
	var_0B.var_1A5 = param_02;
	var_0B.var_868B = param_04;
	var_0B.var_A067 = param_05;
	var_0B.var_537C = 0;
	var_0B.var_6078 = -1;
	var_0B.var_8F63 = undefined;
	var_0B.var_6731 = 0;
	var_0B.var_8C82 = 0;
	var_0B.var_6A6E = param_06;
	var_0B.perkid = param_0A;
	if(isdefined(param_07) && param_07 > -1)
	{
		var_0B.var_6078 = param_07;
		var_0B.var_6731 = 0;
	}

	if(isdefined(param_08))
	{
		var_0B.var_8F63 = param_08;
		var_0B.var_267B = param_08;
	}

	level.var_6F5C[param_00] = var_0B;
}

//Function Number: 8
func_5295(param_00)
{
	var_01 = level.var_6F5C[param_00];
	var_02 = common_scripts\utility::func_46B7(var_01.var_1A5,"targetname");
	foreach(var_04 in var_02)
	{
		var_01.var_537C = 1;
		var_04.var_9DC2 = [];
		var_05 = getentarray(var_04.var_1A2,"targetname");
		foreach(var_07 in var_05)
		{
			var_08 = var_07.var_165;
			if(!isdefined(var_08))
			{
				continue;
			}

			switch(var_08)
			{
				case "armor_buy_trig":
					var_04.var_9DC2[var_04.var_9DC2.size] = var_07;
					break;

				case "armor_model":
					var_04.var_F5F = var_07;
					break;
			}
		}

		foreach(var_0B in var_04.var_9DC2)
		{
			var_0B usetouchtriggerrequirefacingposition(1,var_04.var_F5F.var_116 + (0,0,48));
			var_0B.var_8C82 = 1;
			var_0B.var_6F63 = param_00;
			lib_0547::func_8A4F(var_0B,::func_0F66);
			var_0B thread func_6F61(param_00,var_04.var_F5F);
		}
	}
}

//Function Number: 9
func_532C(param_00,param_01)
{
	var_02 = level.var_6F5C[param_00];
	var_03 = getentarray(var_02.var_1A5,"targetname");
	var_04 = undefined;
	if(var_03.size == 4)
	{
		if(var_02.var_109 == "perk_all")
		{
			var_05 = common_scripts\utility::func_46B7("perkmachine_look_at_loc","targetname");
			var_06 = common_scripts\utility::func_4461(var_03[0].var_116,var_05);
			var_07 = common_scripts\utility::func_46B5(var_06.var_1A2,"targetname");
			for(var_08 = 0;var_08 < 4;var_08++)
			{
				var_03[var_08].var_81E1 = var_08;
				var_03[var_08].look_at_loc = var_06;
				var_03[var_08].fake_scriptable = var_07;
			}
		}
		else
		{
			var_09 = function_021F("perkmachine_scriptable_ent","targetname");
			var_09 = var_03[0] func_45A0(var_09,4);
			for(var_08 = 0;var_08 < 4;var_08++)
			{
				var_03[var_08].var_81E1 = var_08;
				var_03[var_08].var_82EF = var_09[var_08];
				var_03[var_08].var_82EF setscriptablepartstate("machine_main","closed");
			}
		}
	}

	var_0A = common_scripts\utility::func_46B7("playerLerpPos","targetname");
	foreach(var_0C in var_03)
	{
		var_0D = common_scripts\utility::func_4461(var_0C.var_116,var_0A,100);
		var_0C.var_741E = var_0D;
		var_0C.var_6F63 = var_02.var_109;
		var_02.var_537C = 1;
		if(var_02.var_109 == "perk_all" && isdefined(var_0C.look_at_loc))
		{
			var_0C usetouchtriggerrequirefacingposition(1,var_0C.look_at_loc.var_116);
		}
		else
		{
			var_0C usetouchtriggerrequirefacingposition(1,var_0C.var_82EF.var_116 + (0,0,52));
		}

		var_0C.var_8C82 = param_01;
		if(lib_0547::func_5819(var_0C))
		{
			if(var_02.var_109 == "perk_all")
			{
				lib_0547::func_8A4F(var_0C,::assignperkallmachinetoplayer);
			}
			else
			{
				lib_0547::func_8A4F(var_0C,::func_10E2,::func_4D16);
			}
		}
		else
		{
		}

		if(var_02.var_109 == "perk_random")
		{
			var_0C thread func_7A5A(var_02.var_109);
			continue;
		}

		if(var_02.var_109 == "perk_all")
		{
			var_0C thread allperkmachinethink(var_02.var_109);
			continue;
		}

		var_0C thread func_6F61(var_02.var_109);
	}
}

//Function Number: 10
func_45A0(param_00,param_01)
{
	var_02 = function_01AC(param_00,self.var_116);
	var_03 = [];
	for(var_04 = 0;var_04 < param_01;var_04++)
	{
		var_03[var_04] = var_02[var_04];
	}

	return var_03;
}

//Function Number: 11
assignperkallmachinetoplayer(param_00)
{
	param_00 endon("disconnect");
	if(1)
	{
		self.var_65DC = lib_0552::func_7BE1(param_00,self,1,self.look_at_loc.var_116);
		self.var_65DC.var_4028 = lib_0552::func_44FF("perk_all");
		var_01 = level.var_6F5C["perk_all"];
	}

	thread func_A149(param_00,1);
}

//Function Number: 12
func_10E2(param_00)
{
	param_00 endon("disconnect");
	if(1)
	{
		self.var_65DC = lib_0552::func_7BF3(param_00,self,1,self.var_82EF.var_116 + (0,0,52));
	}

	thread func_8C11(param_00);
	thread func_6F62(param_00);
	thread func_A149(param_00,0);
	lib_0559::func_7BE2(param_00,self,self.var_6F63);
}

//Function Number: 13
func_6F5E(param_00,param_01)
{
	var_02 = self;
	var_03 = level.var_6F5C[var_02.var_6F63];
	var_04 = func_4602(param_00,var_02);
	if(1)
	{
		var_05 = var_02.var_6F63;
		var_06 = var_04;
		if(common_scripts\utility::func_562E(param_01))
		{
			if(!common_scripts\utility::func_562E(var_02.var_65DC.interact_disabled))
			{
				var_02.var_65DC.var_6642 = 1;
				var_02.var_65DC.require_standing = 1;
			}
		}
		else
		{
			var_07 = param_00 func_4B7E(var_05);
			if(var_03.var_6078 > -1)
			{
				if(var_03.var_6731 >= var_03.var_6078 && level.var_744A.size == 1)
				{
					var_05 = "sold_out";
					var_06 = 0;
					var_02.var_65DC.interact_disabled = 1;
				}
			}

			var_02.var_65DC.var_6F58 = var_05;
			var_02.var_65DC.var_6F56 = var_06;
			var_02.var_65DC.var_6642 = 1;
			var_02.var_65DC.require_standing = 1;
		}
	}

	if(!common_scripts\utility::func_562E(param_01))
	{
		var_02 func_8719(param_00);
	}
}

//Function Number: 14
func_A149(param_00,param_01)
{
	param_00 endon("disconnect");
	var_02 = self;
	for(;;)
	{
		var_02 func_6F5E(param_00,param_01);
		param_00 common_scripts\utility::knock_off_battery("perk_discount_applied","used_vending_machine_discount","update_trigger_cost","perkmachine_activated","take_perk");
	}
}

//Function Number: 15
func_6F62(param_00)
{
	var_01 = self;
	param_00 endon("disconnect");
	var_02 = 0;
	var_03 = 250000;
	if(isdefined(level.blitz_react_dist_override))
	{
		var_03 = level.blitz_react_dist_override;
	}

	if(common_scripts\utility::func_562E(level.blitz_always_open))
	{
		wait(0.25);
		self.var_82EF setscriptablepartstate("machine_main","opening");
		wait(getanimlength(%zmb_perk_machine_open));
		self.var_82EF setscriptablepartstate("machine_main","opened");
		return;
	}

	for(;;)
	{
		wait(0.25);
		var_04 = (!param_00 func_4B7E(self.var_6F63) && should_open_based_on_distance(param_00,var_03) && param_00.var_62D6 >= func_4602(param_00,var_01) || common_scripts\utility::func_562E(param_00.var_5799)) || isdefined(level.perk_machine_should_open) && [[ level.perk_machine_should_open ]](self);
		if(var_02 == var_04)
		{
			continue;
		}

		if(var_04)
		{
			param_00.wasperkgreeted = 1;
			var_05 = lib_0380::func_2889("zmb_perk_machine_open",undefined,self.var_116 + (0,0,100));
			lib_0378::func_8D14(var_05);
			self.var_82EF setscriptablepartstate("machine_main","opening");
			wait(getanimlength(%zmb_perk_machine_open));
			self.var_82EF setscriptablepartstate("machine_main","opened");
		}
		else
		{
			var_06 = lib_0380::func_2889("zmb_perk_machine_close",undefined,self.var_116 + (0,0,100));
			lib_0378::func_8D14(var_06);
			self.var_82EF setscriptablepartstate("machine_main","closing");
			wait(getanimlength(%zmb_perk_machine_reverse));
			self.var_82EF setscriptablepartstate("machine_main","closed");
		}

		var_02 = var_04;
	}
}

//Function Number: 16
should_open_based_on_distance(param_00,param_01)
{
	if(common_scripts\utility::func_562E(param_00.wasperkgreeted))
	{
		return 1;
	}

	return distancesquared(param_00.var_116,self.var_116) < param_01;
}

//Function Number: 17
func_8719(param_00)
{
	var_01 = self;
	var_02 = 5;
	for(var_03 = "" + func_4602(param_00,var_01);var_03.size < var_02;var_03 = "0" + var_03)
	{
	}

	for(var_04 = 0;var_04 < var_02;var_04++)
	{
		var_05 = "gears_0" + var_04 + 1;
		var_06 = "idle_" + int(var_03[var_04]);
		var_01.var_82EF setscriptablepartstate(var_05,var_06);
	}
}

//Function Number: 18
func_4D16(param_00)
{
	self.var_82EF hidefromclient(param_00);
}

//Function Number: 19
func_8C11(param_00)
{
	self.var_82EF showtoclient(param_00);
}

//Function Number: 20
func_6F61(param_00,param_01)
{
	var_02 = self;
	level endon("game_over");
	var_03 = level.var_6F5C[param_00];
	if(isdefined(var_03.var_8F63) && var_03.var_267B == var_03.var_8F63)
	{
		thread func_A183(param_00);
	}

	for(;;)
	{
		var_04 = lib_0547::func_A795();
		var_05 = var_04[0];
		var_06 = var_04[1];
		if((var_05 getstance() == "crouch" || var_05 getstance() == "prone") && param_00 != "armor")
		{
			continue;
		}

		if(var_03.var_6078 > -1 && var_03.var_6731 >= var_03.var_6078 && level.var_744A.size == 1)
		{
			lib_0555::func_83DD("blitz_soldout",var_05);
			continue;
		}

		var_07 = func_4602(var_05,var_02);
		if(var_05 func_4B7E(param_00))
		{
			lib_0555::func_83DD("blitz_owned",var_05);
			continue;
		}
		else if(param_00 == "armor" && var_05 func_4B53())
		{
			lib_0555::func_83DD("armor_full",var_05);
			continue;
		}
		else if(var_05 maps/mp/gametypes/zombies::func_11C2(var_07))
		{
			if(var_05 lib_056B::func_9D19(self.var_6F63))
			{
				var_05 lib_056B::func_9D1A(self.var_6F63);
			}
			else
			{
				var_05 lib_0578::func_A245();
			}

			if(!isdefined(self.var_8C82))
			{
				func_6F5D(var_05);
			}

			if(isdefined(var_03.var_868B))
			{
				var_05 [[ var_03.var_868B ]]();
			}

			var_05.var_6F5F++;
			if(param_00 == "armor")
			{
				if(!isdefined(var_05.var_F60))
				{
					var_05.var_F60 = 0;
				}

				var_05.var_F60++;
				if(isdefined(param_01))
				{
					playfx(level.var_611["zmb_pm_armor_use"],param_01.var_116,anglestoforward(param_01.var_1D));
				}

				param_01 lib_0378::func_8D74("aud_use_armor_machine");
				lib_0547::func_4AE4(var_05,"armor_booth",var_07,"none","none");
			}
			else
			{
				lib_0547::func_4AE4(var_05,"perk_machine",var_07,"none","none");
				var_05 thread lib_054E::func_73B9(param_00,var_05.var_6F5F == 1);
				level.var_400E[level.var_400E.size] = ["assassin_set 2 -1",var_05];
				level.var_400E[level.var_400E.size] = ["survivalist_set 1 -1",var_05];
			}

			self notify("perkmachine_activated");
			var_05 notify("perkmachine_activated",var_03);
			level notify("perkmachine_activated",var_03);
			level notify("perkmachine_player",var_03,self.var_116,var_05);
			var_05 lib_0547::func_7ACD();
			if(isdefined(var_03.var_8F63) && var_03.var_267B == var_03.var_8F63)
			{
				if(!isdefined(var_05.numperkbuys))
				{
					var_05.numperkbuys = [];
				}

				if(!isdefined(var_05.numperkbuys[param_00]))
				{
					var_05.numperkbuys[param_00] = 0;
				}

				var_05.numperkbuys[param_00]++;
				var_03.var_6731++;
			}
		}
	}
}

//Function Number: 21
allperkmachinethink(param_00)
{
	level endon("game_over");
	var_01 = self;
	var_02 = level.var_6F5C[param_00];
	for(;;)
	{
		var_03 = lib_0547::func_A795();
		var_04 = var_03[0];
		var_05 = var_03[1];
		if(var_04 getstance() == "crouch" || var_04 getstance() == "prone")
		{
			continue;
		}

		var_06 = func_4602(var_04,var_01);
		var_07 = 0;
		if(var_04 maps/mp/gametypes/zombies::func_11C2(var_06))
		{
			if(!isdefined(self.var_8C82))
			{
				func_6F5D(var_04,1);
			}

			var_04 func_4772();
			var_04.var_6F5F++;
			lib_0547::func_4AE4(var_04,"perk_machine",var_06,"none","none");
			self notify("perkmachine_activated");
			var_04 notify("perkmachine_activated");
			level notify("all_perkmachine_activated",var_04);
			var_04 lib_0547::func_7ACD();
			break;
		}
	}

	wait 0.05;
	var_01.var_65DC.interact_disabled = 1;
	var_01.var_65DC.var_6642 = 1;
	var_01.var_65DC.var_2F74 = 1;
}

//Function Number: 22
func_7A5A(param_00)
{
	level endon("game_over");
	var_01 = self;
	var_02 = level.var_6F5C[param_00];
	for(;;)
	{
		var_03 = lib_0547::func_A795();
		var_04 = var_03[0];
		var_05 = var_03[1];
		if(var_04 getstance() == "crouch" || var_04 getstance() == "prone")
		{
			continue;
		}

		if(common_scripts\utility::func_562E(var_04.random_blitz_resetting))
		{
			lib_0555::func_83DD("machine_reset",var_04);
			continue;
		}

		var_06 = ["quickrevive","doubletap","fastreload","punchperk","runperk","electriccherry"];
		if(level.var_6F5C["quickrevive"].var_6078 > -1)
		{
			if(!isdefined(var_04.numperkbuys))
			{
				var_04.numperkbuys = [];
			}

			if(!isdefined(var_04.numperkbuys["quickrevive"]))
			{
				var_04.numperkbuys["quickrevive"] = 0;
			}

			if(isdefined(var_04.numselfrevivedowns) && var_04.numselfrevivedowns >= level.var_6F5C["quickrevive"].var_6078 && level.var_744A.size == 1)
			{
				var_06 = common_scripts\utility::func_F93(var_06,"quickrevive");
			}
		}

		var_07 = common_scripts\utility::func_7A33(var_06);
		var_08 = func_4602(var_04,var_01);
		var_09 = 0;
		while(var_04 func_4B7E(var_07))
		{
			var_06 = common_scripts\utility::func_F93(var_06,var_07);
			if(var_06.size <= 0)
			{
				lib_0555::func_83DD("blitz_owned",var_04);
				var_09 = 1;
				break;
			}

			var_07 = common_scripts\utility::func_7A33(var_06);
		}

		if(var_09 == 1)
		{
			continue;
		}

		if(var_04 maps/mp/gametypes/zombies::func_11C2(var_08))
		{
			var_04 lib_0578::func_A245();
			if(!isdefined(self.var_8C82))
			{
				func_6F5D(var_04);
			}

			var_04 [[ level.var_6F5C[var_07].var_868B ]]();
			var_04.var_6F5F++;
			lib_0547::func_4AE4(var_04,"perk_machine",var_08,"none","none");
			var_04 thread lib_054E::func_73B9(var_07,var_04.var_6F5F == 1);
			self notify("perkmachine_activated");
			var_04 notify("perkmachine_activated",level.var_6F5C[var_07]);
			level notify("perkmachine_activated",level.var_6F5C[var_07]);
			level notify("perkmachine_player",level.var_6F5C[var_07],self.var_116,var_04);
			var_04 lib_0547::func_7ACD();
			if(level.var_6F5C[var_07].var_6078 > -1 && level.var_744A.size == 1)
			{
				level.var_6F5C[var_07].var_6731++;
				if(!isdefined(var_04.numperkbuys))
				{
					var_04.numperkbuys = [];
				}

				if(!isdefined(var_04.numperkbuys[level.var_6F5C[var_07].var_109]))
				{
					var_04.numperkbuys[level.var_6F5C[var_07].var_109] = 0;
				}

				var_04.numperkbuys[level.var_6F5C[var_07].var_109]++;
			}

			var_04.random_blitz_resetting = 1;
			thread func_7A59(var_04);
		}
	}
}

//Function Number: 23
func_7A59(param_00)
{
	param_00 endon("death");
	wait(120);
	if(isdefined(param_00))
	{
		param_00.random_blitz_resetting = 0;
	}
}

//Function Number: 24
func_6F5D(param_00,param_01)
{
	var_02 = spawn("script_model",param_00.var_116);
	var_02 setmodel("tag_origin");
	var_03 = self.var_741E.var_1D * (1,0,0) + param_00.var_1D * (0,1,0);
	var_02.var_1D = var_03;
	param_00 playerlinktoblend(var_02,"tag_origin",0.25);
	var_02 moveto(self.var_741E.var_116,0.25);
	var_02 rotateto(self.var_741E.var_1D,0.25);
	param_00 common_scripts\utility::func_603();
	param_00 common_scripts\utility::func_600();
	param_00 maps\mp\_utility::func_3E8E(1);
	param_00.var_5799 = 1;
	param_00 notify("can_use_consumable");
	wait(0.25);
	var_04 = (isdefined(param_00.has_purchased_any_blitz) && param_00.has_purchased_any_blitz) || common_scripts\utility::func_562E(level.iszombiesshotgun);
	if(common_scripts\utility::func_562E(param_01))
	{
		var_04 = 1;
	}

	param_00 lib_0586::func_78C("unarmed_perk_machine_zm");
	param_00 lib_0586::func_78E("unarmed_perk_machine_zm",0,var_04);
	param_00 lib_0547::func_7ACD();
	var_05 = 0;
	while(!param_00 isswitchingweapon() && var_05 < 3)
	{
		var_05 = var_05 + 0.05;
		wait 0.05;
	}

	var_06 = 4.1;
	if(var_04)
	{
		var_06 = 2.1;
	}

	param_00 thread func_2CE0(var_06);
	if(common_scripts\utility::func_562E(param_01))
	{
		playfx(common_scripts\utility::func_44F5("zmb_pm_random_use"),self.fake_scriptable.var_116,anglestoforward(self.fake_scriptable.var_1D),anglestoup(self.fake_scriptable.var_1D));
	}
	else
	{
		self.var_82EF setscriptablepartstate("machine_main","use");
	}

	var_07 = undefined;
	if(isdefined(level.groundrefent))
	{
		var_07 = spawn("script_model",(0,0,0));
		var_07.var_1D = level.groundrefent.var_1D;
		param_00 playersetgroundreferenceent(var_07);
		var_07 rotateto((0,0,0),0.3325);
	}

	wait(1.33);
	if(isdefined(level.groundrefent))
	{
		param_00 playersetgroundreferenceent(level.groundrefent);
		if(isdefined(var_07))
		{
			var_07 delete();
		}
	}

	param_00 maps\mp\_utility::func_3E8E(0);
	param_00 unlink(var_02);
	var_02 delete();
	param_00.var_5799 = 0;
	param_00.has_purchased_any_blitz = 1;
	if(common_scripts\utility::func_562E(level.zmb_player_safe_teleport_on_perk_buy))
	{
		param_00 setorigin(getclosestpointonnavmesh(self.var_741E.var_116,param_00) + (0,0,1));
	}
}

//Function Number: 25
func_0F62()
{
	if(!isdefined(self.var_82EF))
	{
		return;
	}

	if(!common_scripts\utility::func_562E(self.var_82FE))
	{
		self.var_82FE = 1;
		var_00 = 2.866667;
		self.var_82EF setscriptablepartstate("machine_main","working");
		wait(var_00 * 0.3333);
		self.var_82EF setscriptablepartstate("machine_main","idle");
		self.var_82FE = 0;
	}
}

//Function Number: 26
func_2CE0(param_00)
{
	wait(param_00);
	lib_0586::func_78E(lib_0547::func_AB2B());
	common_scripts\utility::func_617();
	common_scripts\utility::func_614();
	self notify("can_use_consumable");
	if(self hasweapon("unarmed_perk_machine_zm"))
	{
		lib_0586::func_790("unarmed_perk_machine_zm");
	}
}

//Function Number: 27
isusingperkmachine()
{
	return common_scripts\utility::func_562E(self.var_5799) || self hasweapon("unarmed_perk_machine_zm");
}

//Function Number: 28
func_4B7E(param_00)
{
	if(!isdefined(self.var_6F66))
	{
		self.var_6F66 = [];
	}

	if(param_00 == "perk_random")
	{
		return 0;
	}

	if(param_00 == "perk_all")
	{
		return 0;
	}

	if(isdefined(self.var_6F66[param_00]))
	{
		return 1;
	}

	return 0;
}

//Function Number: 29
func_A183(param_00)
{
	level endon("game_over");
	for(;;)
	{
		level common_scripts\utility::knock_off_battery("player_spawned","player_disconnected");
		if(level.var_744A.size > 1)
		{
			var_01 = level.var_6F5C[param_00];
			if(var_01.var_267B != var_01.var_64F7)
			{
				var_01.var_267B = var_01.var_64F7;
				foreach(var_03 in level.var_744A)
				{
					if(!isdefined(var_03.numperkbuys))
					{
						var_03.numperkbuys = [];
					}

					if(!isdefined(var_03.numperkbuys[param_00]))
					{
						var_03.numperkbuys[param_00] = 0;
					}

					var_03 notify("update_trigger_cost");
				}
			}

			continue;
		}

		var_01 = level.var_6F5C[param_00];
		if(isdefined(var_01.var_8F63) && var_01.var_267B != var_01.var_8F63)
		{
			var_01.var_267B = var_01.var_8F63;
			foreach(var_03 in level.var_744A)
			{
				var_03 notify("update_trigger_cost");
				if(param_00 == "quickrevive")
				{
					if(isdefined(var_03.numselfrevivedowns) && var_03.numselfrevivedowns >= var_01.var_6078 && var_03 func_4B7E(param_00))
					{
						var_03 func_95D7(param_00);
					}
				}
			}
		}
	}
}

//Function Number: 30
func_4772(param_00)
{
	if(lib_0547::func_577E(self))
	{
		return;
	}

	if(lib_0547::func_57E1(self))
	{
		return 0;
	}

	if(self.var_178 == "spectator")
	{
		return 0;
	}

	level.var_5F5A = 1;
	var_01 = 0;
	if(!isdefined(param_00))
	{
		param_00 = 1;
	}

	foreach(var_03 in level.var_6F5C)
	{
		if(param_00 == 0 || common_scripts\utility::func_562E(var_03.var_537C))
		{
			if(var_03.var_109 != "armor" && var_03.var_109 != "perk_random" && var_03.var_109 != "perk_all")
			{
				func_4792(var_03.var_109);
				var_01++;
			}
		}
	}

	self setclientomnvar("zm_blitz_items_limit",var_01);
}

//Function Number: 31
givefreemachineperks(param_00,param_01,param_02)
{
	level.var_5F5A = 1;
	var_03 = 0;
	if(!isdefined(param_00))
	{
		param_00 = 1;
	}

	var_04 = [];
	var_05 = [];
	foreach(var_07 in level.var_6F5C)
	{
		var_05 = common_scripts\utility::func_F6F(var_05,var_07.var_109);
	}

	if(isdefined(param_02))
	{
		var_05 = param_02;
	}

	foreach(var_07 in var_05)
	{
		if(var_07 != "armor" && var_07 != "perk_random" && var_07 != "perk_all" && !func_4B7E(var_07))
		{
			var_04 = common_scripts\utility::func_F6F(var_04,var_07);
			func_4792(var_07);
			var_03++;
			if(var_03 == param_01)
			{
				break;
			}
		}
	}

	self setclientomnvar("zm_blitz_items_limit",var_03);
	return var_04;
}

//Function Number: 32
func_95D0(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 1;
	}

	foreach(var_02 in level.var_6F5C)
	{
		if(param_00 == 0 || common_scripts\utility::func_562E(var_02.var_537C))
		{
			if(var_02.var_109 != "armor" && var_02.var_109 != "perk_random" && var_02.var_109 != "perk_all")
			{
				func_95D7(var_02.var_109);
			}
		}
	}
}

//Function Number: 33
func_4603(param_00)
{
	var_01 = level.var_6F5C[param_00];
	return var_01.var_6A6E;
}

//Function Number: 34
func_4792(param_00)
{
	var_01 = level.var_6F5C[param_00];
	self [[ var_01.var_868B ]]();
}

//Function Number: 35
func_95D7(param_00)
{
	var_01 = level.var_6F5C[param_00];
	if(isdefined(var_01.var_A067))
	{
		self [[ var_01.var_A067 ]]();
	}
}

//Function Number: 36
func_95D8(param_00)
{
	var_01 = self.var_6F66[param_00];
	self.var_6F66[param_00] = undefined;
	self.var_6F67 = common_scripts\utility::func_F93(self.var_6F67,var_01);
	for(var_02 = 0;var_02 < self.var_6F67.size;var_02++)
	{
		var_03 = self.var_6F67[var_02];
		var_03.var_D4 = var_02;
		self setclientomnvar(func_4603(var_03.var_109),var_02);
	}

	if(isdefined(self.characterclientindex))
	{
		var_04 = 0;
		foreach(var_06 in self.var_6F67)
		{
			var_07 = var_06.var_D4;
			var_08 = level.var_6F5C[var_06.var_109].perkid;
			if(isdefined(var_08))
			{
				var_04 = var_04 << 3 | var_08;
			}
		}

		var_0A = "ui_zm_blitz_" + self.characterclientindex;
		setomnvar(var_0A,var_04);
	}

	self notify("take_perk",param_00);
	self setclientomnvar(func_4603(param_00),-1);
}

//Function Number: 37
func_4793(param_00,param_01)
{
	var_02 = spawnstruct();
	var_02.var_109 = param_00;
	var_02.var_D4 = self.var_6F67.size;
	self.var_6F66[param_00] = var_02;
	self.var_6F67[var_02.var_D4] = var_02;
	self setclientomnvar(func_4603(param_00),var_02.var_D4);
	var_03 = undefined;
	var_04 = func_420E(lib_0547::func_4BA7("specialty_class_hoarder_zm"));
	while(self.var_6F67.size > var_04)
	{
		var_03 = self.var_6F67[0].var_109;
		func_95D7(self.var_6F67[0].var_109);
	}

	if(isdefined(self.characterclientindex))
	{
		var_05 = 0;
		foreach(var_07 in self.var_6F67)
		{
			var_08 = var_07.var_D4;
			var_09 = level.var_6F5C[var_07.var_109].perkid;
			if(isdefined(var_09))
			{
				var_05 = var_05 << 3 | var_09;
			}
		}

		var_0B = "ui_zm_blitz_" + self.characterclientindex;
		setomnvar(var_0B,var_05);
	}

	if(isdefined(var_03))
	{
		lib_0555::func_83DD("biltz_replaced",self,param_00,var_03);
		return;
	}

	lib_0555::func_83DD("buy_blitz",self,param_00);
}

//Function Number: 38
func_47B5()
{
	if(func_4B7E("fastreload"))
	{
		return;
	}

	func_4793("fastreload",(0,1,0));
	maps\mp\_utility::func_47A2("specialty_fastreload");
}

//Function Number: 39
func_95F1()
{
	if(!func_4B7E("fastreload"))
	{
		return;
	}

	if(maps\mp\_utility::func_649("specialty_fastreload"))
	{
		maps\mp\_utility::func_735("specialty_fastreload");
	}

	func_95D8("fastreload");
}

//Function Number: 40
func_47B0()
{
	if(func_4B7E("punchperk"))
	{
		return;
	}

	func_4793("punchperk",(1,1,1));
}

//Function Number: 41
func_95EF()
{
	if(!func_4B7E("punchperk"))
	{
		return;
	}

	func_95D8("punchperk");
}

//Function Number: 42
func_4B85()
{
	return func_4B7E("punchperk");
}

//Function Number: 43
func_47B8()
{
	if(func_4B7E("runperk"))
	{
		return;
	}

	func_4793("runperk",(1,1,0));
	maps\mp\_utility::func_47A2("specialty_lightweight");
	maps\mp\_utility::func_47A2("specialty_marathon");
	lib_0547::func_7ACD();
}

//Function Number: 44
func_95F3()
{
	if(!func_4B7E("runperk"))
	{
		return;
	}

	if(maps\mp\_utility::func_649("specialty_lightweight"))
	{
		maps\mp\_utility::func_735("specialty_lightweight");
	}

	if(maps\mp\_utility::func_649("specialty_marathon"))
	{
		maps\mp\_utility::func_735("specialty_marathon");
	}

	lib_0547::func_7ACD();
	func_95D8("runperk");
}

//Function Number: 45
func_47B1()
{
	if(func_4B7E("quickrevive"))
	{
		return;
	}

	func_4793("quickrevive",(0,1,1));
}

//Function Number: 46
func_95F0()
{
	if(!func_4B7E("quickrevive"))
	{
		return;
	}

	func_95D8("quickrevive");
}

//Function Number: 47
func_4785()
{
	if(func_4B7E("electriccherry"))
	{
		return;
	}

	func_4793("electriccherry",(0,0,1));
	thread func_35B0();
}

//Function Number: 48
func_95D5()
{
	if(!func_4B7E("electriccherry"))
	{
		return;
	}

	self notify("take_electriccherry");
	if(isdefined(self.var_6F66["electriccherry"].var_AAC0))
	{
		self.var_6F66["electriccherry"].var_AAC0 delete();
	}

	if(isdefined(self.var_6F66["electriccherry"].var_AAC1))
	{
		self.var_6F66["electriccherry"].var_AAC1 delete();
	}

	func_95D8("electriccherry");
}

//Function Number: 49
func_35B0()
{
	self endon("death");
	self endon("disconnect");
	self endon("take_electriccherry");
	var_00 = self;
	var_01 = self.var_6F66["electriccherry"];
	var_01.var_A66D = [];
	var_01.var_258C = 0;
	var_01.var_AAC1 = spawn("script_model",(0,0,0));
	var_01.var_AAC1 setmodel("tag_origin");
	var_01.var_AAC1 linkto(var_00,"tag_origin",(0,0,0),(0,0,0));
	var_00 thread maps\mp\gametypes\_playerlogic::deleteentonplayerdisconnect(var_01.var_AAC1);
	var_01.var_AAC0 = spawnlinkedfx(common_scripts\utility::func_44F5("zmb_elec_cherry_wv"),var_01.var_AAC1,"tag_origin");
	var_01.var_AAC0 hidefromclient(var_00);
	var_00 thread maps\mp\gametypes\_playerlogic::deleteentonplayerdisconnect(var_01.var_AAC0);
	for(;;)
	{
		var_00 waittill("reload_start");
		var_02 = var_00 getcurrentweapon();
		if(common_scripts\utility::func_F79(var_01.var_A66D,var_02))
		{
			continue;
		}

		var_01.var_A66D[var_01.var_A66D.size] = var_02;
		var_01.var_258C++;
		var_03 = var_00 getweaponammoclip(var_02);
		var_04 = weaponclipsize(var_02);
		var_05 = 1 - var_03 / var_04;
		var_06 = common_scripts\utility::func_5D92(var_05,0,1,1,1045);
		var_07 = common_scripts\utility::func_5D92(var_05,0,1,32,128);
		var_00 thread func_2161(var_02);
		switch(var_01.var_258C)
		{
			case 1:
			case 0:
				var_08 = undefined;
				break;
	
			case 2:
				var_08 = 8;
				break;
	
			case 3:
				var_08 = 4;
				break;
	
			case 4:
				var_08 = 2;
				break;
	
			default:
				var_08 = 0;
				break;
		}

		var_00 thread func_35AD(var_02);
		if(isdefined(var_08) && var_08 == 0)
		{
			continue;
		}

		triggerfx(var_01.var_AAC0);
		var_00 lib_0378::func_8D74("electric_cherry_vfx");
		playfxontagforclients(common_scripts\utility::func_44F5("zmb_elec_cherry_player"),var_00,"J_Spine4",var_00);
		var_09 = maps/mp/agents/_agent_utility::func_43FD("all");
		var_09 = common_scripts\utility::func_40B0(var_00.var_116,var_09,undefined,var_08,var_07);
		foreach(var_0B in var_09)
		{
			var_0B maps\mp\zombies\_zombies_traps::mark_electrified();
			var_0B dodamage(var_06,var_0B.var_116,var_00,var_00,"MOD_MELEE","electric_cherry_zm");
			playfx(common_scripts\utility::func_44F5("zmb_elec_cherry_zombie"),var_0B.var_116 + (0,0,40));
		}
	}
}

//Function Number: 50
func_2161(param_00)
{
	self endon("death");
	self endon("disconnect");
	self endon("take_electriccherry");
	self endon("player_lost_weapon_" + param_00);
	thread func_A9B5(param_00);
	for(;;)
	{
		self waittill("reload");
		var_01 = self getcurrentweapon();
		if(var_01 == param_00)
		{
			self.var_6F66["electriccherry"].var_A66D = common_scripts\utility::func_F93(self.var_6F66["electriccherry"].var_A66D,param_00);
			self notify("weapon_reload_complete_" + param_00);
			break;
		}
	}
}

//Function Number: 51
func_A9B5(param_00)
{
	self endon("death");
	self endon("disconnect");
	self endon("take_electriccherry");
	self endon("weapon_reload_complete_" + param_00);
	for(;;)
	{
		self waittill("weapon_change");
		var_01 = self getweaponslistprimaries();
		if(!common_scripts\utility::func_F79(var_01,param_00))
		{
			self notify("player_lost_weapon_" + param_00);
			self.var_6F66["electriccherry"].var_A66D = common_scripts\utility::func_F93(self.var_6F66["electriccherry"].var_A66D,param_00);
			break;
		}
	}
}

//Function Number: 52
func_35AD(param_00)
{
	self notify("electric_cherry_cooldown_started");
	self endon("electric_cherry_cooldown_started");
	self endon("death");
	self endon("disconnect");
	self endon("take_electriccherry");
	var_01 = 0.25;
	if(maps\mp\_utility::func_649("specialty_fastreload"))
	{
		var_01 = var_01 * 0.5;
	}

	var_02 = var_01 + 3;
	wait(var_02);
	self.var_6F66["electriccherry"].var_258C = 0;
}

//Function Number: 53
func_4784()
{
	if(func_4B7E("doubletap"))
	{
		return;
	}

	maps\mp\_utility::func_47A2("specialty_rof");
	func_4793("doubletap",(1,0,1));
}

//Function Number: 54
func_95D3()
{
	if(!func_4B7E("doubletap"))
	{
		return;
	}

	if(maps\mp\_utility::func_649("specialty_rof"))
	{
		maps\mp\_utility::func_735("specialty_rof");
	}

	func_95D8("doubletap");
}

//Function Number: 55
func_5F1E()
{
	level endon("game_over");
	level.var_5F20 = ::func_5F20;
	level.var_5F1D = ::func_5F1D;
	var_00 = getentarray("photobooth_buy","targetname");
	if(!isdefined(var_00))
	{
		return;
	}

	foreach(var_02 in var_00)
	{
		var_03 = undefined;
		if(isdefined(var_02.var_1A2))
		{
			var_03 = common_scripts\utility::func_46B5(var_02.var_1A2,"targetname");
			if(isdefined(var_03))
			{
				var_02 usetouchtriggerrequirefacingposition(1,var_03.var_116);
			}
			else
			{
				var_02 usetriggerrequirelookat(1);
			}
		}

		if(isdefined(var_03) && isdefined(var_03.var_1A2))
		{
			var_02.var_191E = getent(var_03.var_1A2,"targetname");
		}

		lib_0547::func_8A4F(var_02,::func_5F22);
	}
}

//Function Number: 56
func_5F22(param_00)
{
	param_00 endon("disconnect");
	param_00.var_6F93 = 0;
	childthread func_5F23(param_00);
	childthread func_5F21(param_00);
}

//Function Number: 57
func_5F23(param_00)
{
	var_01 = 2000;
	lib_0559::func_7BE2(param_00,self,"photo");
	var_02 = undefined;
	if(1)
	{
		var_02 = lib_0552::func_7BF3(param_00,self);
		var_02.var_6F58 = "lost_and_found_empty";
		var_02.var_6F56 = 0;
		var_02.require_standing = 0;
	}

	for(;;)
	{
		waittillframeend;
		if(param_00.var_6F93)
		{
			var_03 = distance2d(self.var_116,param_00.var_116);
			if(!lib_0547::func_577E(param_00) && !lib_0547::func_57E1(param_00) || param_00.var_178 == "spectator")
			{
				if(!common_scripts\utility::func_562E(self.var_5594) && var_03 <= var_01)
				{
					self.var_5594 = 1;
					self.var_191E hudoutlineenableforclient(param_00,0,0);
					thread lostandfoundcountdown(param_00);
				}

				if(1)
				{
					var_02.var_6F58 = "lost_and_found_restore";
					var_02.var_6F56 = 500;
					var_02.var_6642 = 1;
					var_02.interact_disabled = undefined;
					var_02.require_standing = 0;
				}
			}
		}
		else
		{
			if(!isdefined(self.var_5594) || common_scripts\utility::func_562E(self.var_5594))
			{
				self.var_191E hudoutlinedisableforclient(param_00);
				self.var_5594 = 0;
			}

			if(1)
			{
				var_02.var_6F58 = "lost_and_found_empty";
				var_02.var_6F56 = 0;
				var_02.var_6642 = 1;
				var_02.interact_disabled = 1;
				var_02.require_standing = 0;
			}
		}

		common_scripts\utility::func_A70C(param_00,"perk_discount_applied",param_00,"update_lost_and_found_hint",level,"zombie_wave_started",param_00,"spawned");
	}
}

//Function Number: 58
lostandfoundcountdown(param_00)
{
	param_00 endon("death");
	param_00 endon("disconnect");
	param_00 endon("lost_and_found_restored");
	wait(45);
	self.var_191E hudoutlineenableforclient(param_00,1,0);
	wait(15);
	if(common_scripts\utility::func_562E(param_00.var_6F93))
	{
		if(isdefined(level.var_5F1D))
		{
			param_00 [[ level.var_5F1D ]]();
		}
	}
}

//Function Number: 59
func_5F21(param_00)
{
	for(;;)
	{
		var_01 = lib_0547::func_A795();
		var_02 = var_01[0];
		var_03 = var_01[1];
		if(var_02.var_6F93)
		{
			var_04 = 500;
			if(var_02 maps/mp/gametypes/zombies::func_11C2(var_04))
			{
				lib_0555::func_83DD("photo",var_02);
				lib_0547::func_4AE4(var_02,"photo_booth",var_04,"none","none");
				var_02 func_5F1F();
				var_02 thread lib_054E::playeruselostandfound();
				var_02 notify("lost_and_found_restored");
				if(isdefined(level.var_5F1D))
				{
					var_02 [[ level.var_5F1D ]]();
				}
			}
		}
	}
}

//Function Number: 60
lostandfoundsaveweapon(param_00)
{
	var_01 = self;
	var_02 = spawnstruct();
	var_02.var_A9E0 = param_00;
	var_02.ammoinfo = var_01 lib_0586::func_4129(param_00);
	if(!isdefined(var_01.lostandfoundinfos))
	{
		var_01.lostandfoundinfos = [];
	}

	var_01.lostandfoundinfos[var_01.lostandfoundinfos.size] = var_02;
}

//Function Number: 61
lostandfoundgetbackupweapon(param_00)
{
	var_01 = self;
	if(!isdefined(var_01.lostandfoundinfos))
	{
		return;
	}

	foreach(var_03 in var_01.lostandfoundinfos)
	{
		if(function_01D4(var_03.var_A9E0) == param_00)
		{
			return var_03.var_A9E0;
		}
	}
}

//Function Number: 62
func_5F20()
{
	var_00 = self;
	var_00.lostandfoundinfos = [];
	var_01 = self getweaponslistprimaries();
	foreach(var_03 in var_01)
	{
		var_04 = lib_0586::func_632(var_03);
		if(issubstr(var_04,"tesla"))
		{
			continue;
		}

		if(isdefined(level.dlc4specialweapons) && common_scripts\utility::func_F79(level.dlc4specialweapons,var_03))
		{
			continue;
		}

		if(lib_0547::iszombieconsumableweapon(var_04) || lib_0547::func_5865(var_04) || lib_0547::func_585B(var_04))
		{
			continue;
		}

		var_00 lostandfoundsaveweapon(var_04);
	}

	var_06 = self getweaponslistoffhands();
	foreach(var_03 in var_06)
	{
		var_00 lostandfoundsaveweapon(var_03);
	}

	var_09 = self getweaponslistitems();
	foreach(var_0B in var_09)
	{
		var_0C = lib_0586::func_632(var_0B);
		if(!isdefined(var_0C) || !lib_0547::func_5836(var_0C))
		{
			continue;
		}

		var_00 lostandfoundsaveweapon(var_0C);
	}

	var_0E = self getcurrentprimaryweapon();
	var_0E = lib_0586::func_632(var_0E);
	if(lib_0547::iszombieconsumableweapon(var_0E) || lib_0547::func_5865(var_0E) || lib_0547::func_585B(var_0E) || lib_0547::func_5864(var_0E) || issubstr(var_0E,"tesla"))
	{
		var_0F = lostandfoundgetbackupweapon("primary");
		var_10 = lostandfoundgetbackupweapon("offhand");
		if(isdefined(var_0F))
		{
			self.var_6F94 = var_0F;
		}
		else if(isdefined(var_10))
		{
			self.var_6F94 = var_10;
		}
		else
		{
			var_11 = maps\mp\zombies\_zombies_magicbox::func_454B(self,"shovel_zm");
			self.var_6F94 = var_11;
		}
	}
	else
	{
		self.var_6F94 = var_0E;
	}

	self.var_6F93 = 1;
	self notify("update_lost_and_found_hint");
}

//Function Number: 63
func_5F1D()
{
	self.var_6F93 = 0;
	self.lostandfoundinfos = undefined;
	self.var_6F94 = undefined;
	self notify("update_lost_and_found_hint");
}

//Function Number: 64
func_5F1F()
{
	var_00 = self;
	var_01 = self getweaponslistprimaries();
	foreach(var_03 in var_01)
	{
		if(isdefined(level.dlc4specialweapons) && common_scripts\utility::func_F79(level.dlc4specialweapons,var_03))
		{
			continue;
		}

		lib_0586::func_790(var_03);
	}

	var_05 = self getweaponslistitems();
	foreach(var_07 in var_05)
	{
		if(!lib_0547::func_5836(var_07))
		{
			continue;
		}

		if(isdefined(level.dlc4specialweapons) && common_scripts\utility::func_F79(level.dlc4specialweapons,var_07))
		{
			continue;
		}

		var_00 lib_0586::func_790(var_07);
	}

	var_09 = self.var_6F94;
	if(isdefined(var_00.lostandfoundinfos))
	{
		foreach(var_0B in var_00.lostandfoundinfos)
		{
			var_0C = var_0B.var_A9E0;
			var_00 lib_0586::func_78C(var_0C);
			var_00 lib_0586::func_F21(var_0C,var_0B.ammoinfo);
		}
	}

	if(var_09 != "none")
	{
		lib_0586::func_78E(var_09,1);
	}
}

//Function Number: 65
func_5BFE()
{
	self endon("disconnect");
	self endon("revive");
	if(lib_0553::func_581E())
	{
		return;
	}

	if(lib_0547::func_4BA7("specialty_class_aftertaste_zm") && self.var_6882 <= 1)
	{
		self waittill("death");
		func_95D0(0);
		return;
	}

	var_00 = self.var_6F66.size;
	var_01 = lib_0553::func_634() / var_00 + 1;
	self endon("death");
	for(var_02 = 0;var_02 < var_00;var_02++)
	{
		wait(var_01);
		var_03 = self.var_6F67[0];
		func_95D7(var_03.var_109);
		lib_0380::func_2888("zmb_ui_bleed_out_perk_loss",self);
	}
}

//Function Number: 66
func_09DF(param_00,param_01)
{
	if(!isdefined(self.var_6F66) || !isdefined(self.var_6F66[param_00]))
	{
		return;
	}

	var_02 = newclienthudelem(self);
	var_02.maxsightdistsqrd = 8 + self.var_6F66.size - 1 * 16;
	var_02.var_1D7 = -32;
	var_02 setshader("objpoint_default",16,16);
	var_02.accuracy = "left";
	var_02.var_11 = "bottom";
	var_02.var_C6 = "left";
	var_02.var_1CA = "bottom";
	var_02.var_18 = 1;
	var_02.var_56 = param_01;
	self.var_6F66[param_00].var_6F6B = var_02;
}

//Function Number: 67
func_A148()
{
	var_00 = 0;
	foreach(var_02 in self.var_6F66)
	{
		var_02.var_6F6B.maxsightdistsqrd = 8 + var_00 * 16;
		var_00++;
	}
}

//Function Number: 68
func_7CEC(param_00)
{
	self.var_6F66[param_00].var_6F6B destroy();
}

//Function Number: 69
func_4602(param_00,param_01)
{
	var_02 = level.var_6F5C[param_01.var_6F63];
	var_03 = var_02.var_267B;
	if(param_01.var_6F63 == "perk_all")
	{
		return var_03;
	}

	if(isdefined(var_02.var_8F63) && level.var_744A.size == 1)
	{
		var_03 = var_02.var_8F63;
	}

	if(param_01.var_6F63 == "armor" && isdefined(param_00.var_F60))
	{
		for(var_04 = 0;var_04 < param_00.var_F60;var_04++)
		{
			var_03 = lib_0547::func_4522(var_03);
		}
	}

	var_05 = param_00 lib_0578::func_4717(param_01);
	var_06 = int(var_03 * var_05);
	return var_06;
}

//Function Number: 70
func_0F66(param_00)
{
	var_01 = self;
	param_00 endon("disconnect");
	lib_0559::func_7BE2(param_00,self,"armor");
	var_02 = undefined;
	if(1)
	{
		var_02 = lib_0552::func_7BF3(param_00,self);
	}

	for(;;)
	{
		waittillframeend;
		var_03 = func_4602(param_00,var_01);
		if(1)
		{
			var_04 = param_00 func_4B53();
			var_02.var_6F58 = "armor";
			var_02.var_6F56 = var_03;
			var_02.var_6642 = 1;
			var_02.require_standing = 0;
		}

		param_00 common_scripts\utility::knock_off_battery("perkmachine_activated","take_armor","take_perk","perk_discount_applied","update_armor_hints");
	}
}

//Function Number: 71
func_0F65(param_00)
{
	if(!param_00 func_4B53())
	{
		return level.var_6F5C["armor"].var_C5;
	}

	return &"ZOMBIES_EMPTY_STRING";
}

//Function Number: 72
func_4B53()
{
	var_00 = lib_0547::func_73E9();
	return var_00 > 0 && var_00 == 3;
}

//Function Number: 73
cp_zmb_escape_init()
{
	lib_0547::func_7454(3);
	thread func_0F69();
}

//Function Number: 74
func_95D2()
{
	lib_0547::func_7454(0);
}

//Function Number: 75
func_0F69(param_00,param_01,param_02)
{
	self endon("disconnect");
	self waittill("take_armor");
	self notify("lost_armor");
	self notify("take_perk","armor");
	func_95D2();
}