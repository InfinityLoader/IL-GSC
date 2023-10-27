/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 1351.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 452
 * Decompile Time: 340 ms
 * Timestamp: 10/27/2023 3:25:35 AM
*******************************************************************/

//Function Number: 1
get_zombies_mode_starter_weapons(param_00)
{
	var_01 = ["shovel_zm","m1911_zm","luger_zm","reich_zm","p38_zm","m712_zm","enfieldno2_zm","g43_zm","m1a1_zm","kar98_zm","model21_zm","m30_zm"];
	var_02 = [];
	if(common_scripts\utility::func_562E(param_00))
	{
		foreach(var_04 in var_01)
		{
			if(!func_5864(var_04))
			{
				var_02 = common_scripts\utility::func_F6F(var_02,lib_0586::func_78B(var_04,1,1));
			}
		}
	}

	return common_scripts\utility::func_F73(var_01,var_02);
}

//Function Number: 2
func_0A52(param_00,param_01)
{
	if(!isdefined(param_00.var_4C12))
	{
		param_00.var_4C12 = 1;
	}

	if(!isdefined(param_00.var_4C07))
	{
		var_02 = maps/mp/gametypes/zombies::getzombietotalhealthscale(param_00,4);
		var_03 = 1000000;
		var_04 = var_02 * var_03;
		param_00.var_4C07 = var_04;
	}

	if(!isdefined(level.var_A50))
	{
		level.var_A50 = [];
	}

	level.var_A50[param_01] = param_00;
}

//Function Number: 3
registeranimtree(param_00,param_01)
{
	if(!isdefined(level.animtree_lookup))
	{
		level.animtree_lookup = [];
	}

	level.animtree_lookup[param_00] = param_01;
}

//Function Number: 4
getanimtree(param_00)
{
	return level.animtree_lookup[param_00];
}

//Function Number: 5
func_0A51(param_00)
{
	return level.var_A50[param_00];
}

//Function Number: 6
func_7CE5(param_00,param_01,param_02)
{
	if(param_02 != 1)
	{
		var_03 = "ks_icon" + common_scripts\utility::func_9AAD(param_02);
		self setclientomnvar(var_03,0);
	}
}

//Function Number: 7
is_important_zombie()
{
	if(common_scripts\utility::func_562E(self.sgvip) || common_scripts\utility::func_562E(self.sgboss) || common_scripts\utility::func_562E(self.sgisdyingboss))
	{
		return 1;
	}

	return 0;
}

//Function Number: 8
remove_important_zombie_corpse_next_round(param_00)
{
	self endon("entitydeleted");
	self endon("death");
	if(param_00)
	{
		level waittill("waveupdate");
		level waittill("waveupdate");
	}
	else
	{
		while(!self method_81E0())
		{
			wait 0.05;
		}

		wait(3);
	}

	self method_86D3(0);
}

//Function Number: 9
func_AC51()
{
	self endon("death");
	self endon("zombies_make_unusable");
	while(isdefined(self))
	{
		self waittill("trigger",var_00);
		if(!isdefined(self))
		{
			continue;
		}

		self notify("player_used",var_00);
		if(isdefined(self.var_117))
		{
			self.var_117 notify("player_used",var_00);
		}
	}
}

//Function Number: 10
func_AC41(param_00,param_01,param_02)
{
	func_AC40();
	self.var_9D65 = spawn("script_model",self.var_116);
	self.var_9D65.var_117 = self;
	self.var_9D65 setmodel("tag_origin");
	if(isdefined(param_01))
	{
		self.var_9D65.var_116 = self.var_9D65.var_116 + param_01;
	}

	if(isdefined(param_02))
	{
		self.var_9D65.var_116 = param_02;
	}

	self.var_9D65 linkto(self);
	self.var_9D65 makeusable();
	if(isdefined(param_00))
	{
		self.var_9D65 sethintstring(param_00);
	}

	self.var_9D65 thread func_AC51();
}

//Function Number: 11
func_AC40()
{
	self notify("zombies_make_unusable");
	if(isdefined(self.var_9D65))
	{
		self.var_9D65 notify("zombies_make_unusable");
		self.var_9D65 delete();
	}

	self.var_9D65 = undefined;
}

//Function Number: 12
func_AC3F(param_00)
{
	func_AC3E();
	self.var_6989 = maps\mp\gametypes\_gameobjects::func_45A9();
	objective_add(self.var_6989,"invisible",(0,0,0));
	objective_position(self.var_6989,self.var_116);
	objective_state(self.var_6989,"active");
	function_01D1(self.var_6989,param_00);
	objective_team(self.var_6989,"allies");
	objective_onentity(self.var_6989,self);
}

//Function Number: 13
func_AC3E()
{
	if(isdefined(self.var_6989))
	{
		maps\mp\_utility::func_68B(self.var_6989);
		self.var_6989 = undefined;
	}
}

//Function Number: 14
func_40F0(param_00)
{
	var_01 = 0;
	foreach(var_03 in function_02D1())
	{
		if(!isalive(var_03))
		{
			continue;
		}

		if(isdefined(var_03.var_A4B) && var_03.var_A4B == param_00)
		{
			var_01++;
		}
	}

	return var_01;
}

//Function Number: 15
func_45C9()
{
	var_00 = 0;
	if(!isdefined(level.var_744A))
	{
		return 0;
	}

	foreach(var_02 in level.var_744A)
	{
		if(func_5767(var_02))
		{
			var_00++;
		}
	}

	return var_00;
}

//Function Number: 16
func_57E1(param_00)
{
	return func_5565(param_00.var_1A7,"spectator");
}

//Function Number: 17
func_5767(param_00)
{
	return func_5565(param_00.var_1A7,level.var_746E);
}

//Function Number: 18
func_5768(param_00)
{
	return func_5767(param_00) || func_57E1(param_00);
}

//Function Number: 19
func_585C(param_00)
{
	return func_5863(param_00) || func_5866(param_00);
}

//Function Number: 20
func_5863(param_00)
{
	var_01 = 0;
	switch(param_00)
	{
		case "scythe_shard_zm":
		case "zom_hammer_grenade_zm":
		case "zom_moonorb_grenade_emp_zm":
		case "zom_moonorb_grenade_zm":
		case "throwinghammer_rhand_zm":
		case "throwinghammer_lhand_zm":
		case "frag_grenade_funderbuss_zm":
		case "alt+wunderbuss_zm":
		case "throwingknife_zm":
		case "thermite_zm":
		case "semtex_zm":
		case "frag_grenade_zm":
		case "killstreak_carepackage_grenade_mp":
		case "bouncingbetty_zm":
		case "c4_zm":
		case "thermite_flames_mp":
			var_01 = 1;
			break;
	}

	if(common_scripts\utility::func_562E(level.zombielethalweapon[param_00]))
	{
		var_01 = 1;
	}

	return var_01;
}

//Function Number: 21
func_5866(param_00)
{
	var_01 = 0;
	switch(param_00)
	{
		case "island_grenade_hc_zm":
		case "jack_in_box_decoy_zm":
		case "zom_moonorb_grenade_emp_zm":
		case "zom_moonorb_grenade_zm":
			var_01 = 1;
			break;
	}

	if(common_scripts\utility::func_562E(level.zombietacticalweapon[param_00]))
	{
		var_01 = 1;
	}

	return var_01;
}

//Function Number: 22
func_73F9(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(param_00 hasweapon(param_01))
	{
		return 1;
	}

	if(!isdefined(param_02))
	{
		param_02 = 1;
	}

	if(!isdefined(param_03))
	{
		param_03 = 1;
	}

	if(!isdefined(param_04))
	{
		param_04 = 1;
	}

	if(!isdefined(param_05))
	{
		param_05 = 1;
	}

	var_06 = param_00 getweaponslistprimaries();
	foreach(var_08 in var_06)
	{
		if(lib_0586::func_791(param_01,var_08,param_02,param_03,param_04,param_05))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 23
func_5862(param_00)
{
	switch(param_00)
	{
		case "airdrop_sentry_marker_mp":
			return 1;

		default:
			break;
	}

	return 0;
}

//Function Number: 24
iszombieindirectweapon(param_00)
{
	switch(param_00)
	{
		case "electric_cherry_zm":
		case "dot_generic_zm":
		case "hitem_hard_zm":
			return 1;

		default:
			break;
	}

	return 0;
}

//Function Number: 25
func_5865(param_00)
{
	switch(param_00)
	{
		case "spine_inspect_depleted_zm":
		case "spine_inspect_zombie_zm":
		case "spine_inspect_assassin_zm":
		case "spine_inspect_wustling_zm":
		case "spine_inspect_pest_zm":
		case "training_unarmed_zm":
		case "hilt_inspect_hc_zm":
		case "hilt_inspect_zm":
		case "elec_inspect_zm":
		case "unarmed_perk_machine_zm":
			return 1;

		default:
			break;
	}

	return 0;
}

//Function Number: 26
func_5864(param_00)
{
	param_00 = func_AAF9(param_00,0,0);
	switch(param_00)
	{
		case "zom_dlc4_scythe_emp_zm":
		case "zom_dlc4_scythe_zm":
		case "zom_dlc4_shield_emp_zm":
		case "zom_dlc4_shield_zm":
		case "zom_dlc4_spike_emp_zm":
		case "zom_dlc4_spike_zm":
		case "zom_dlc4_hammer_emp_zm":
		case "zom_dlc4_hammer_zm":
		case "razergun_melee_zm":
		case "shovel_zm":
		case "raven_sword_zm":
			return 1;

		default:
			break;
	}

	if(issubstr(param_00,"shovel"))
	{
		return 1;
	}

	if(issubstr(param_00,"razergun_zm"))
	{
		if(!common_scripts\utility::func_3C83("ripsaw_punch_active") || common_scripts\utility::func_3C83("ripsaw_punch_active") && !common_scripts\utility::func_3C77("ripsaw_punch_active"))
		{
			return 1;
		}
	}

	if(common_scripts\utility::func_562E(level.zombiemeleeweapon[param_00]))
	{
		return 1;
	}

	return 0;
}

//Function Number: 27
iszombieconsumableweapon(param_00)
{
	switch(param_00)
	{
		case "flamethrower_zm":
		case "panzerschreck_zm":
		case "bazooka_zm":
			return 1;

		default:
			break;
	}

	return 0;
}

//Function Number: 28
func_585B(param_00)
{
	if(maps\mp\_utility::func_4571() == "mp_zombie_island" && param_00 == "teslagun_zm")
	{
		return 1;
	}

	switch(param_00)
	{
		case "stone_baby_zm":
		case "sentryhead_zm":
		case "blimp_battery_zm":
			return 1;

		default:
			break;
	}

	return 0;
}

//Function Number: 29
func_462A(param_00)
{
	var_01 = param_00 getcurrentweapon();
	if(isdefined(param_00.var_20CC))
	{
		var_01 = param_00.var_20CC;
	}

	if(!param_00 hasweapon(var_01))
	{
		var_02 = param_00 getweaponslistprimaries();
		if(var_02.size > 0)
		{
			var_01 = var_02[0];
		}
	}

	return var_01;
}

//Function Number: 30
func_4747(param_00,param_01)
{
	var_02 = getweapondisplayname(param_01);
	if(func_5868(var_02))
	{
		return 1;
	}

	return 0;
}

//Function Number: 31
func_5868(param_00)
{
	return lib_0569::func_55D4(param_00);
}

//Function Number: 32
iszombieweaponamped(param_00)
{
	return issubstr(param_00,"zmb_amp");
}

//Function Number: 33
func_4BA8(param_00,param_01)
{
	return 0;
}

//Function Number: 34
func_7D1F(param_00,param_01)
{
	var_02 = undefined;
	for(;;)
	{
		var_02 = maps/mp/agents/_agent_common::func_2586(param_00,param_01);
		if(isdefined(var_02))
		{
			break;
		}

		wait(0.1);
	}

	return var_02;
}

//Function Number: 35
func_902E(param_00,param_01,param_02)
{
	if(!isdefined(param_00.var_1D))
	{
		param_00.var_1D = (0,0,0);
	}

	var_03 = func_7D1F(param_01.var_A4B,param_02);
	var_03 maps/mp/agents/_agents::func_8F70(param_00.var_116,param_00.var_1D);
	return var_03;
}

//Function Number: 36
func_6BAA(param_00,param_01,param_02)
{
	maps/mp/agents/humanoid/_humanoid::func_8FC9(self.var_EAE,param_00,param_01,param_02);
}

//Function Number: 37
func_90A0(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	if(!isdefined(param_00.var_1D))
	{
		param_00.var_1D = (0,0,0);
	}

	var_07 = func_7D1F(param_01.var_A4B,param_02);
	var_07.var_EAE = undefined;
	if(isdefined(param_01.var_EAE))
	{
		var_07.var_EAE = param_01.var_EAE;
	}

	var_07 common_scripts\utility::func_3799("zombie_passive");
	if(common_scripts\utility::func_562E(param_04))
	{
		var_07 common_scripts\utility::func_379A("zombie_passive");
	}

	var_07.var_901F = param_05;
	var_07.var_9024 = param_06;
	var_07 thread [[ var_07 maps/mp/agents/_agent_utility::func_A59("spawn") ]](param_00.var_116,param_00.var_1D);
	var_08 = undefined;
	if(param_00 should_play_spawn_vfx())
	{
		if(isdefined(level.var_902A))
		{
			var_08 = var_07 [[ level.var_902A ]](param_00);
		}
	}

	if(isdefined(param_00.var_8109))
	{
		var_09 = isdefined(param_00.var_81C7) && param_00.var_81C7 == "ignoreRealign";
		var_0A = var_07 maps/mp/agents/_scripted_agent_anim_util::func_434D(param_00.var_8109);
		if(isdefined(var_0A))
		{
			var_07 thread func_AC3A(param_00,var_0A,var_08,var_09);
		}
		else
		{
		}
	}

	if(isdefined(var_07) && isdefined(param_01))
	{
		if(isdefined(level.var_10E8) && var_07 [[ level.var_10E8 ]]())
		{
			return var_07;
		}

		if(isdefined(param_03))
		{
			var_0B = param_03;
		}
		else
		{
			var_0C = [];
			foreach(var_0F, var_0E in param_01.var_5ED2)
			{
				if(common_scripts\utility::func_562E(var_0E["request only"]))
				{
					continue;
				}

				var_0C[var_0C.size] = var_0F;
			}

			if(isdefined(level.zmb_additional_look_check))
			{
				var_0C = [[ level.zmb_additional_look_check ]](var_0C);
			}

			var_0B = common_scripts\utility::func_7A33(var_0C);
		}

		var_10 = param_01.var_5ED2[var_0B];
		var_07.var_18B0 = var_0B;
		var_07.var_2FDB = 0;
		if(isdefined(var_10["right_arm"]))
		{
			var_07.var_2FDB = var_07.var_2FDB | 1;
		}

		if(isdefined(var_10["left_arm"]))
		{
			var_07.var_2FDB = var_07.var_2FDB | 2;
		}

		if(isdefined(var_10["right_leg"]))
		{
			var_07.var_2FDB = var_07.var_2FDB | 4;
		}

		if(isdefined(var_10["left_leg"]))
		{
			var_07.var_2FDB = var_07.var_2FDB | 8;
		}

		if(isdefined(var_10["heads"]))
		{
			var_07.var_2FDB = var_07.var_2FDB | 16;
			var_07.var_4BF2 = common_scripts\utility::func_7A33(var_10["heads"]);
		}
		else
		{
			var_07.var_4BF2 = undefined;
		}

		var_07.var_4B5A = 0;
		var_07.var_4B6E = 0;
		var_07.var_4CAA = undefined;
		var_11 = randomint(100);
		if(var_11 < 33)
		{
		}
		else if(var_11 < 66)
		{
			if(isdefined(var_10["helmets"]))
			{
				var_07.var_4B6E = 1;
				var_07.var_4CAA = common_scripts\utility::func_7A33(var_10["helmets"]);
			}
		}
		else if(isdefined(var_10["caps"]))
		{
			var_07.var_4B5A = 1;
			var_07.var_4CAA = common_scripts\utility::func_7A33(var_10["caps"]);
		}

		if(isdefined(var_10["facegear"]))
		{
			var_07.var_399E = common_scripts\utility::func_7A33(var_10["facegear"]);
		}

		var_07.var_6250 = 0;
		var_07 func_A19E();
		var_12 = var_07 maps/mp/agents/_agent_utility::func_A59("post_model");
		if(isdefined(var_12))
		{
			var_07 thread [[ var_12 ]]();
		}

		if(isdefined(param_01.var_8303))
		{
			var_07.var_8303 = param_01.var_8303;
		}

		if(isdefined(param_01.var_8302))
		{
			var_07.var_8302 = param_01.var_8302;
		}
	}

	return var_07;
}

//Function Number: 38
should_play_spawn_vfx()
{
	return isdefined(self.var_8109) || func_5565(self.var_82EC,"spawn_fire");
}

//Function Number: 39
func_AC3A(param_00,param_01,param_02,param_03)
{
	param_00.var_50D5 = 1;
	var_04 = undefined;
	var_05 = [];
	if(isdefined(param_00.optional_script_anim_index))
	{
		var_06 = self method_83DB(param_01);
		var_04 = param_00.optional_script_anim_index;
		if(isdefined(param_00.optional_timeoffset))
		{
			var_05["timeOffset"] = param_00.optional_timeoffset;
		}
	}

	maps/mp/agents/humanoid/_humanoid_util::func_8318(param_00.var_116,param_00.var_1D,param_01,var_04,1,param_02,param_03,0,undefined,undefined,var_05);
	param_00.var_50D5 = 0;
}

//Function Number: 40
func_443A(param_00)
{
	switch(param_00)
	{
		case 1:
			return "right_arm";

		case 2:
			return "left_arm";

		case 4:
			return "right_leg";

		case 8:
			return "left_leg";

		default:
			break;
	}
}

//Function Number: 41
func_4744(param_00)
{
	var_01 = func_0A51(self.var_A4B);
	var_02 = var_01.var_5ED2[self.var_18B0];
	if(param_00 == 16)
	{
		return self.var_4BF2;
	}

	var_03 = func_443A(param_00);
	return var_02[var_03];
}

//Function Number: 42
func_A19E()
{
	var_00 = func_0A51(self.var_A4B);
	var_01 = var_00.var_5ED2[self.var_18B0];
	self detachall();
	if(self.var_6250 & ~16 == 0 && isdefined(var_01["whole_body"]))
	{
		self setmodel(var_01["whole_body"]);
	}
	else
	{
		self setmodel(var_01["torso"]);
		func_A19F(var_01,1);
		func_A19F(var_01,2);
		func_A19F(var_01,4);
		func_A19F(var_01,8);
	}

	var_02 = isdefined(self.var_4BF2) && self.var_6250 & 16 == 0;
	if(var_02)
	{
		self attach(self.var_4BF2);
	}

	if((var_02 && self.var_4B6E) || var_02 && self.var_4B5A)
	{
		self attach(self.var_4CAA);
	}

	if(var_02 && isdefined(self.var_399E))
	{
		self attach(self.var_399E);
	}
}

//Function Number: 43
func_A19F(param_00,param_01)
{
	var_02 = func_443A(param_01);
	var_03 = param_00[var_02];
	if(self.var_6250 & param_01 != 0)
	{
		var_04 = lib_0541::func_4559(param_01,var_03,"nub");
		if(isdefined(var_04))
		{
			self attach(var_04,"",1);
			return;
		}

		return;
	}

	self attach(var_03);
}

//Function Number: 44
func_2696(param_00)
{
	var_01 = 0;
	while(param_00 > 0)
	{
		var_01++;
		param_00 = param_00 - param_00 & 0 - param_00;
	}

	return var_01;
}

//Function Number: 45
func_4495()
{
	return "dismemberSound";
}

//Function Number: 46
func_647A(param_00)
{
	return getmovedelta(param_00,0,func_463F(param_00));
}

//Function Number: 47
func_2574(param_00)
{
	var_01 = func_463F(param_00);
	var_02 = getmovedelta(param_00,0,var_01);
	var_03 = getanimlength(param_00);
	if(var_03 == 0)
	{
		return 0;
	}

	return var_02 / var_01 * var_03;
}

//Function Number: 48
func_5E44(param_00)
{
	return self localtoworldcoords(param_00) - self.var_116;
}

//Function Number: 49
func_2204(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	var_09 = 2;
	var_0A = 100;
	var_0B = 3;
	var_0C = 50;
	var_0D = 600;
	var_0E = 1;
	if(!isdefined(param_07) || lengthsquared(param_07) < 0.1)
	{
		if(isdefined(param_02))
		{
			param_07 = self.var_116 - param_02.var_116;
		}
		else if(isdefined(param_03))
		{
			param_07 = self.var_116 - param_03.var_116;
		}
		else
		{
			param_07 = (0,0,0);
		}
	}

	param_07 = vectornormalize(common_scripts\utility::func_3D5D(param_07));
	var_0F = anglestoforward(self.var_1D);
	var_10 = var_0F * vectordot(var_0F,param_07);
	var_11 = param_07 - var_10;
	var_12 = var_11 * var_0B + var_10;
	var_13 = self method_83D8();
	var_14 = func_5E44(getmovedelta(var_13,0,1));
	var_15 = getanimlength(var_13);
	if(var_15 > 0)
	{
		var_16 = var_14 / var_15;
	}
	else
	{
		var_16 = (0,0,0);
	}

	var_17 = var_16 * var_09;
	var_18 = var_12 * param_04 * var_0C / self.var_FB;
	var_19 = var_17 + var_18;
	var_1B = undefined;
	var_1C = undefined;
	var_1D = self method_83DB(param_00);
	for(var_1F = 0;var_1F < var_1D;var_1F++)
	{
		var_20 = self method_83D8(param_00,var_1F);
		var_21 = func_463F(var_20);
		var_22 = getmovedelta(var_20,0,var_21);
		var_23 = getanimlength(var_20);
		if(var_23 == 0)
		{
			var_24 = 0;
		}
		else
		{
			var_24 = var_22 / var_21 * var_23;
		}

		var_25 = func_5E44(var_24);
		var_26 = (randomfloatrange(-1,1),randomfloatrange(-1,1),0) * var_0A;
		var_27 = var_25 + var_26;
		var_28 = 0 - distance(var_19,var_27);
		var_29 = self localtoworldcoords(var_22);
		if(navtrace(self.var_116,var_29,self,0))
		{
			var_28 = var_28 - 1000;
		}

		foreach(var_2B in level.var_744A)
		{
			if(distance(var_29,var_2B.var_116) < 32)
			{
				var_28 = var_28 - 500;
			}
		}

		if(!isdefined(var_1B) || var_28 > var_1B)
		{
			var_1B = var_28;
			var_1C = var_1F;
		}
	}

	var_2D = common_scripts\utility::func_5D93(var_1B,-30,-100,0.1,1);
	if(param_05 == "MOD_GRENADE" || param_05 == "MOD_GRENADE_SPLASH")
	{
		var_2D = 0.9;
	}

	if(isdefined(param_06) && function_01AA(param_06) == "spread")
	{
		var_2D = 0.5;
	}

	if(param_01 && randomfloat(1) < var_2D)
	{
		if(param_05 == "MOD_GRENADE" || param_05 == "MOD_GRENADE_SPLASH")
		{
			var_33 = 1;
		}
		else if(isdefined(param_07) && function_01AA(param_07) == "spread")
		{
			var_33 = 0.8;
		}
		else
		{
			var_33 = 0.4;
		}

		if(maps/mp/agents/_agent_utility::func_A5A("ragdoll_overrides"))
		{
			var_34 = [[ maps/mp/agents/_agent_utility::func_A59("ragdoll_overrides") ]]();
		}
		else
		{
			var_34 = 1;
		}

		var_35 = common_scripts\utility::func_5D93(param_04,0,self.var_FB,0.6,1);
		var_36 = 3500;
		var_37 = var_36 * var_33 * var_34 * var_35;
		var_38 = vectorcross((0,0,1),param_07);
		self.var_78D5 = param_07 + (0,0,0.3) + randomfloat(0.4) * var_38 * var_37;
		self.var_78D2 = 1;
		self.var_78D3 = param_08;
		if(self.var_78D3 == "none")
		{
			self.var_78D3 = "torso_upper";
		}
	}

	return var_1C;
}

//Function Number: 50
func_6B9E(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	self.var_565F = 0;
	self.var_4B60 = 0;
	if(isdefined(self.var_EAD.var_6B2F[self.var_BA4]))
	{
		self [[ self.var_EAD.var_6B2F[self.var_BA4] ]]();
	}

	var_09 = 1;
	var_0A = 0;
	var_0B = maps/mp/agents/humanoid/_humanoid::func_45FB(param_04,param_01);
	if(isdefined(self.var_2A9D))
	{
		var_0C = self.var_2A9D;
		var_09 = 0;
	}
	else if(self.var_90DC == "dog")
	{
		var_0C = "death";
	}
	else if(param_04 == "MOD_MELEE" && !common_scripts\utility::func_562E(self.nopairmelee))
	{
		var_0D = undefined;
		if(self method_864D(param_01) && (!maps/mp/agents/humanoid/_humanoid_util::func_56BC() || common_scripts\utility::func_562E(self.var_103)) && isdefined(var_0B))
		{
			if(!param_01 method_8661() || common_scripts\utility::func_562E(self.var_103))
			{
				var_0D = var_0B["fatal_zombie_action"];
			}
			else
			{
				var_0D = var_0B["hit_zombie_action"];
			}
		}

		if(isdefined(var_0D))
		{
			var_0A = 1;
			var_09 = 0;
			var_0C = var_0D;
			var_0E = var_0B["invalid_pair_distance"];
			if(isdefined(var_0E))
			{
				if(distance(self.var_116,param_01.var_116) > var_0E)
				{
					lib_0542::set_zombie_too_far_for_pairing(param_01);
					var_0F = 1;
				}
			}
		}
		else
		{
			var_0C = "death_melee_knife";
		}
	}
	else if(lib_0541::func_56FD())
	{
		if(self.var_108 == "run" || self.var_108 == "sprint")
		{
			var_0C = "death_full_body_run";
		}
		else
		{
			var_0C = "death_full_body_stand";
		}
	}
	else if(self.var_BA4 == "idle" || self.var_BA4 == "melee")
	{
		var_0C = "death_stand";
	}
	else
	{
		var_0C = "death_" + self.var_108;
	}

	var_10 = maps/mp/agents/_scripted_agent_anim_util::func_434D(var_0C);
	if(isdefined(self.var_9D07))
	{
		func_649D();
	}

	self method_839D("gravity");
	var_11 = func_2204(var_10,var_09,param_00,param_01,param_02,param_03,param_04,param_05,param_06);
	var_12 = self method_83D9(var_10,var_11);
	var_13 = self method_83D8(var_10,var_11);
	var_14 = 1;
	var_15 = 0;
	if(var_0A)
	{
		param_07 = param_07 - 1;
		if(param_07 < 0)
		{
			param_07 = 0;
		}

		var_15 = param_07 * 0.001;
		var_16 = 0.2;
		var_15 = var_15 - var_16;
		var_17 = maps/mp/agents/_scripted_agent_anim_util::func_45B9(var_13,"melee_sync",0) * getanimlength(var_13);
		var_15 = var_15 + var_17;
		if(var_15 < 0)
		{
			var_15 = 0;
		}
	}

	maps/mp/agents/_scripted_agent_anim_util::func_8415(var_10,var_11,var_14,var_15);
	var_18 = func_4488(var_13);
	if(isdefined(param_04) && param_04 == "zombie_vaporize_mp" && common_scripts\utility::func_3F6F("zombie_death_vaporize"))
	{
		self.var_1DEB = 1;
		playfx(common_scripts\utility::func_44F5("zombie_death_vaporize"),self.var_116 + (0,0,30));
	}

	if(!isdefined(self.var_1DEB) || !self.var_1DEB)
	{
		var_19 = is_important_zombie();
		var_1A = var_19 || var_0A;
		self.var_18A8 = self method_8392(var_18 - int(var_15 * 1000),var_1A);
		self.var_18A8.var_A4B = self.var_A4B;
		self.var_18A8.var_90AB = self.var_90AB;
		self.var_18A8.var_4BF2 = self.var_4BF2;
		self.var_18A8.var_4B6E = self.var_4B6E;
		self.var_18A8.var_4B5A = self.var_4B5A;
		self.var_18A8.var_4CAA = self.var_4CAA;
		self.var_18A8.var_18B0 = self.var_18B0;
		self.var_18A8.var_6250 = self.var_6250;
		self.var_18A8.var_2FDB = self.var_2FDB;
		self.var_18A8.var_2FE3 = self.var_2FE3;
		self.var_18A8.too_far_for_melee_pairing = self.too_far_for_melee_pairing;
		self notify("body_spawned",self.var_18A8);
		level notify("level_notify_body_spawned",self,self.var_18A8);
		var_1B = "zmb_jolts_out";
		if(should_play_zombie_fx() && common_scripts\utility::func_3F6F(var_1B))
		{
			var_1C = common_scripts\utility::func_44F5(var_1B);
			playfxontag(var_1C,self.var_18A8,"J_Head");
		}

		if(isdefined(param_04) && param_04 == "repulsor_zombie_mp" || param_04 == "zombie_water_trap_mp")
		{
			self.var_78D2 = 1;
		}

		var_1D = func_4640(var_18 * 0.001,var_0A);
		var_1D = max(0,var_1D - var_15);
		thread func_4AE8(self.var_18A8,var_1D,var_13,var_0A);
		if(var_1A)
		{
			self.var_18A8 thread remove_important_zombie_corpse_next_round(var_19);
		}

		if(var_0A)
		{
			thread lib_0542::func_4ADD(self.var_18A8,var_0B,var_13,var_15,param_00,param_01,param_02,param_03,param_04,param_05,param_06);
		}
	}

	maps/mp/agents/_agent_utility::func_2A73();
	self notify("killanimscript");
}

//Function Number: 51
should_play_zombie_fx()
{
	return !isdefined(level.zombie_prevent_fx_play_func) || !self [[ level.zombie_prevent_fx_play_func ]]();
}

//Function Number: 52
func_8B97()
{
	if(isdefined(self.var_2A9D))
	{
		return 0;
	}

	if(lib_0541::func_56FD())
	{
		return 1;
	}

	if(!self isonground() || common_scripts\utility::func_562E(self.var_50D9))
	{
		return 1;
	}

	if(isdefined(self.var_78D2) && self.var_78D2)
	{
		return 1;
	}

	if(self.var_BA4 == "traverse" || self.var_BA4 == "scripted")
	{
		return 1;
	}

	return 0;
}

//Function Number: 53
func_1F67(param_00)
{
	var_01 = getanimlength(param_00);
	var_02 = getnotetracktimes(param_00,"ignore_ragdoll");
	return var_02.size == 0;
}

//Function Number: 54
func_649D()
{
	var_00 = 20;
	var_01 = vectortoangles(self.var_9D07);
	var_02 = anglestoup(var_01);
	var_03 = self.var_116 + var_02 * var_00;
	self setorigin(var_03);
}

//Function Number: 55
func_463F(param_00)
{
	var_01 = getnotetracktimes(param_00,"start_ragdoll");
	if(var_01.size > 0)
	{
		return var_01[0];
	}

	return 0.5;
}

//Function Number: 56
func_4488(param_00)
{
	var_01 = getanimlength(param_00);
	var_01 = var_01 * func_463F(param_00);
	var_02 = int(var_01 * 1000);
	return var_02;
}

//Function Number: 57
func_5A85(param_00,param_01,param_02,param_03)
{
	self.var_78D5 = param_01;
	self.var_78D2 = 1;
	self.var_78D3 = param_00;
	self dodamage(self.var_BC * 2,self.var_116,undefined,param_02,"MOD_IMPACT",param_03);
}

//Function Number: 58
func_A69D(param_00,param_01)
{
	self endon("entitydeleted");
	self endon("waitForEarlyRagdollOrTimeout");
	childthread func_83D8("waitForEarlyRagdollOrTimeout",param_00);
	for(;;)
	{
		self waittill("start_ragdoll",var_02,var_03);
		if(!param_01 && var_02 < 0.5)
		{
			self startragdoll();
			break;
		}
	}
}

//Function Number: 59
func_83D8(param_00,param_01)
{
	wait(param_01);
	self notify(param_00);
}

//Function Number: 60
func_4AE8(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_00))
	{
		return;
	}

	if(!func_1F67(param_02))
	{
		return;
	}

	if(!param_03 && func_8B97())
	{
		if(isdefined(self.var_78D3))
		{
			param_00 method_8029(self.var_78D3,self.var_78D5);
		}
		else
		{
			param_00 startragdoll();
		}

		if(param_00 method_81E0())
		{
			return;
		}
	}

	param_00 func_A69D(param_01,param_03);
	if(!isdefined(param_00))
	{
		return;
	}

	param_00 startragdoll();
	if(param_00 method_81E0())
	{
		return;
	}

	var_04 = getanimlength(param_02);
	if(var_04 > param_01)
	{
		wait(var_04 - param_01);
		if(!isdefined(param_00))
		{
			return;
		}

		param_00 startragdoll();
	}

	if(!param_00 method_81E0())
	{
		param_00 delete();
	}
}

//Function Number: 61
func_4640(param_00,param_01)
{
	var_02 = 0.2;
	if(param_01)
	{
		return param_00;
	}

	if(self.var_BA4 == "traverse" || self.var_BA4 == "scripted" && !isdefined(self.var_2A9D))
	{
		return var_02;
	}

	return param_00;
}

//Function Number: 62
func_A692()
{
	self endon("death");
	level endon("game_ended");
	for(;;)
	{
		self waittill("bad_path");
		self.var_173E = 1;
		if(isdefined(self.var_3043))
		{
			self.var_3044++;
		}
	}
}

//Function Number: 63
func_8B95(param_00)
{
	if(common_scripts\utility::func_562E(level.zmb_lockdown_event_active) && !common_scripts\utility::func_562E(param_00.participatinginevent))
	{
		return 1;
	}

	if(isdefined(self.var_3043) && !common_scripts\utility::func_562E(self.has_lost_distractiondrone_interest))
	{
		return 1;
	}

	if(isdefined(self.my_ignore_players_list) && self.my_ignore_players_list.size > 0 && common_scripts\utility::func_F79(self.my_ignore_players_list,param_00))
	{
		return 1;
	}

	if(common_scripts\utility::func_562E(self.var_56EB) && common_scripts\utility::func_562E(param_00.var_7414))
	{
		return 1;
	}

	if(func_577E(param_00))
	{
		return 1;
	}

	if(func_5783(param_00))
	{
		return 1;
	}

	if(common_scripts\utility::func_562E(param_00.var_AC5B) && !common_scripts\utility::func_562E(self.ignorecamo))
	{
		return 1;
	}

	if(func_0796() && func_4253() <= 10 && func_4088() > 1 && common_scripts\utility::func_562E(param_00.var_5579))
	{
		return 1;
	}

	if(isdefined(level.var_8B96))
	{
		if([[ level.var_8B96 ]](param_00))
		{
			return 1;
		}
	}

	if(isdefined(level.shouldignoreplayerzombiecallback))
	{
		if([[ level.shouldignoreplayerzombiecallback ]](param_00,self))
		{
			return 1;
		}
	}

	if(common_scripts\utility::func_562E(param_00.var_5869) && func_580A())
	{
		return 1;
	}

	return 0;
}

//Function Number: 64
func_4253()
{
	var_00 = 0;
	if(!isdefined(level.var_8CB) || level.var_8CB.size == 0)
	{
		return 999;
	}

	var_01 = func_408F();
	foreach(var_03 in level.var_744A)
	{
		foreach(var_05 in var_01)
		{
			if(!isdefined(var_05.var_88))
			{
				continue;
			}

			foreach(var_07 in level.var_8CB)
			{
				if(distance(var_03.var_116,var_07.var_38B7) < var_07.var_38BA && var_05.var_88 == var_03)
				{
					var_00++;
				}
			}
		}
	}

	return var_00;
}

//Function Number: 65
func_4088()
{
	var_00 = 0;
	foreach(var_02 in level.var_744A)
	{
		if(isalive(var_02) && !common_scripts\utility::func_562E(var_02.var_5728))
		{
			var_00++;
		}
	}

	return var_00;
}

//Function Number: 66
func_0795()
{
	if(!isdefined(level.var_8CB) || level.var_8CB.size == 0)
	{
		return 0;
	}

	return 1;
}

//Function Number: 67
func_0BC7()
{
	var_00 = 0;
	if(!isdefined(level.var_8CB) || level.var_8CB.size == 0)
	{
		return 1;
	}

	foreach(var_02 in level.var_8CB)
	{
		if(!common_scripts\utility::func_562E(var_02.var_552B))
		{
			var_00++;
		}
	}

	return var_00 == level.var_8CB.size;
}

//Function Number: 68
func_0796()
{
	var_00 = 0;
	if(!isdefined(level.var_8CB) || level.var_8CB.size == 0)
	{
		return 0;
	}

	foreach(var_02 in level.var_8CB)
	{
		if(common_scripts\utility::func_562E(var_02.var_552B))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 69
func_4254()
{
	var_00 = 0;
	if(!isdefined(level.var_8CB) || level.var_8CB.size == 0)
	{
		return 0;
	}

	foreach(var_02 in level.var_8CB)
	{
		if(common_scripts\utility::func_562E(var_02.var_552B))
		{
			var_03 = func_408F();
			foreach(var_05 in var_03)
			{
				if(distance(var_05.var_116,var_02.var_38B7) < var_02.var_38BA)
				{
					var_00++;
				}
			}
		}
	}

	return var_00;
}

//Function Number: 70
func_7A37()
{
	var_00 = [];
	if(!isdefined(level.var_8CB) || level.var_8CB.size == 0)
	{
		return undefined;
	}

	foreach(var_02 in level.var_8CB)
	{
		if(common_scripts\utility::func_562E(var_02.var_552B))
		{
			var_00 = common_scripts\utility::func_F6F(var_00,var_02);
		}
	}

	return common_scripts\utility::func_7A33(var_00);
}

//Function Number: 71
func_5E54()
{
	self endon("death");
	level endon("game_ended");
	for(;;)
	{
		foreach(var_01 in level.var_6E97)
		{
			if(func_5767(var_01))
			{
				self getenemyinfo(var_01);
			}
		}

		wait(0.5);
	}
}

//Function Number: 72
func_0A58()
{
	self endon("death");
	level endon("game_ended");
	self endon("owner_disconnect");
	for(;;)
	{
		self method_8395(self.var_116);
		wait(0.5);
	}
}

//Function Number: 73
func_6AB7()
{
	self.var_9 = &"ZOMBIES_EMPTY_STRING";
}

//Function Number: 74
func_AC70()
{
	return isdefined(self.var_99A3);
}

//Function Number: 75
func_AC59(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	if(param_02 < self.var_FB)
	{
		return 0;
	}

	if(!isdefined(level.var_AB28) || level.var_AB28 != func_45A2())
	{
		level.var_AB28 = func_45A2();
		level.var_AB27 = 0;
	}

	if(!isdefined(level.var_AB29))
	{
		level.var_AB29 = 0;
	}

	if(isdefined(self.var_99A4))
	{
		self.var_99A4 = undefined;
		return 0;
	}
	else if(level.var_AB29 + level.var_AB27 + 1 > 4)
	{
		return 1;
	}

	level.var_AB27++;
	return 0;
}

//Function Number: 76
func_AC24()
{
	self endon("processDelayDeath");
	self waittill("death");
	level.var_AB29--;
}

//Function Number: 77
func_AC19(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	self endon("death");
	level.var_AB29++;
	self.var_6730 = gettime();
	self.var_99A3 = func_45A2() + int(ceil(level.var_AB29 / 4));
	thread func_AC24();
	while(func_45A2() < self.var_99A3)
	{
		func_A6F6();
	}

	if(level.var_AB28 != func_45A2())
	{
		level.var_AB28 = func_45A2();
		level.var_AB27 = 0;
	}

	self.var_99A3 = undefined;
	self.var_99A4 = 1;
	level.var_AB29--;
	level.var_AB27++;
	self notify("processDelayDeath");
	self dodamage(param_02,param_05,param_01,undefined,param_03,param_04);
}

//Function Number: 78
func_1F4C()
{
	if(gettime() - self.var_90AB <= 0.05)
	{
		return 0;
	}

	if(isdefined(self.poweredupfx))
	{
		return 0;
	}

	return 1;
}

//Function Number: 79
func_5774(param_00)
{
	return isdefined(self.var_6F44) && self.var_6F44;
}

//Function Number: 80
func_AC36(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	self notify("zombiePendingDeath");
	self endon("zombiePendingDeath");
	while(isdefined(self) && isalive(self))
	{
		self.var_6F44 = 1;
		if(!func_1F4C())
		{
			wait 0.05;
			continue;
		}

		self.var_6F44 = 0;
		lib_054D::func_6BD3(param_00,param_01,self.var_BC + 1,param_03,param_04,param_05,param_06,param_07,param_08,param_09,"");
	}
}

//Function Number: 81
func_376A(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	level.var_5B95 = self.var_116;
	if(!common_scripts\utility::func_562E(level.zmbdisablechancetospawnpickup))
	{
		level thread maps/mp/gametypes/zombies::func_20B0(param_01,self,param_03,param_04);
	}

	if(isdefined(param_01) && isplayer(param_01))
	{
		param_01 thread lib_054E::func_72D2(param_06,param_03,param_04,self);
		param_01 maps\mp\_utility::func_50EA("kills",1);
		param_01 maps\mp\_utility::func_50E9("kills",1);
		param_01.var_E3 = param_01 maps\mp\_utility::func_4607("kills");
		param_01 maps\mp\gametypes\_persistence::func_933A("round","kills",param_01.var_E3);
		level notify("zom_kill");
		if(maps\mp\_utility::func_4431(param_04) == param_01.var_76D8)
		{
			param_01.var_A9BA[param_01.var_76D9].var_E3 = param_01.var_A9BA[param_01.var_76D9].var_E3 + 1;
		}
		else
		{
			var_09 = func_4837(param_01,param_04);
			if(var_09 == -1)
			{
				param_01.var_76D8 = "";
				param_01.var_76D9 = -1;
			}
			else
			{
				param_01.var_A9BA[var_09].var_E3 = param_01.var_A9BA[var_09].var_E3 + 1;
				param_01.var_76D8 = maps\mp\_utility::func_4431(param_04);
				param_01.var_76D9 = var_09;
			}
		}
	}

	func_2157(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08);
}

//Function Number: 82
func_2157(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	if(!isdefined(level.var_376B))
	{
		if(isdefined(level.var_7756))
		{
			self thread [[ level.var_7756 ]](param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08);
		}
		else
		{
			return;
		}
	}

	for(var_09 = 0;var_09 < level.var_376B.size;var_09++)
	{
		self thread [[ level.var_376B[var_09] ]](param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08);
	}

	if(isdefined(level.postenemykilledfuncs))
	{
		for(var_09 = 0;var_09 < level.postenemykilledfuncs.size;var_09++)
		{
			self thread [[ level.postenemykilledfuncs[var_09] ]](param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08);
		}
	}
}

//Function Number: 83
register_postenemykilledfunc(param_00)
{
	if(!isdefined(level.postenemykilledfuncs))
	{
		level.postenemykilledfuncs = [];
	}

	level.postenemykilledfuncs[level.postenemykilledfuncs.size] = param_00;
}

//Function Number: 84
deregister_postenemykilledfunc(param_00)
{
	if(isdefined(level.postenemykilledfuncs))
	{
		level.postenemykilledfuncs = common_scripts\utility::func_F93(level.postenemykilledfuncs,param_00);
	}
}

//Function Number: 85
func_7BA9(param_00)
{
	if(!isdefined(level.var_376B))
	{
		level.var_376B = [];
	}

	level.var_376B[level.var_376B.size] = param_00;
}

//Function Number: 86
func_2D8C(param_00)
{
	if(isdefined(level.var_376B))
	{
		level.var_376B = common_scripts\utility::func_F93(level.var_376B,param_00);
	}
}

//Function Number: 87
check_allykilledfuncs(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	if(!isdefined(level.allykilledfuncs))
	{
		if(isdefined(level.processallykilledfunc))
		{
			self thread [[ level.processallykilledfunc ]](param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08);
		}
		else
		{
			return;
		}
	}

	for(var_09 = 0;var_09 < level.allykilledfuncs.size;var_09++)
	{
		self thread [[ level.allykilledfuncs[var_09] ]](param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08);
	}
}

//Function Number: 88
register_allykilledfunc(param_00)
{
	if(!isdefined(level.allykilledfuncs))
	{
		level.allykilledfuncs = [];
	}

	level.allykilledfuncs[level.allykilledfuncs.size] = param_00;
}

//Function Number: 89
deregister_allykilledfunc(param_00)
{
	if(isdefined(level.allykilledfuncs))
	{
		level.allykilledfuncs = common_scripts\utility::func_F93(level.allykilledfuncs,param_00);
	}
}

//Function Number: 90
func_AB18(param_00,param_01)
{
	self endon("death");
	if(isdefined(level.zmb_custom_crawl_rule))
	{
		param_00 = [[ level.zmb_custom_crawl_rule ]](param_00);
	}

	wait(param_00);
	if(isdefined(param_01))
	{
		self.var_1DEB = param_01;
	}

	self suicide();
}

//Function Number: 91
func_577A(param_00,param_01)
{
	if(!func_5767(param_00))
	{
		return 0;
	}

	if(func_577E(param_00) && !common_scripts\utility::func_562E(param_01) && param_00 func_73BF() && maps/mp/agents/_agent_utility::func_45C7(param_00) == 0)
	{
		return 0;
	}

	if(!isdefined(param_00.var_178) || param_00.var_178 != "playing")
	{
		return 0;
	}

	return 1;
}

//Function Number: 92
func_0F51(param_00,param_01)
{
	var_02 = 0;
	foreach(var_04 in level.var_744A)
	{
		if(isdefined(param_00) && param_00 == var_04)
		{
			continue;
		}

		var_02 = var_02 | func_577A(var_04,param_01);
	}

	return var_02;
}

//Function Number: 93
func_1F2C()
{
	foreach(var_01 in level.var_744A)
	{
		if(var_01 func_73BF())
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 94
func_73BF()
{
	if(func_83C0())
	{
		return 1;
	}

	if(self.var_178 != "playing")
	{
		return 0;
	}

	if(lib_0553::func_4B87())
	{
		return 1;
	}

	if(lib_0576::func_4B92() && !common_scripts\utility::func_562E(level.block_self_revive_use))
	{
		return 1;
	}

	if(common_scripts\utility::func_562E(self.mapreviveenabled))
	{
		return 1;
	}

	return 0;
}

//Function Number: 95
func_83C0()
{
	return 0;
}

//Function Number: 96
func_5731()
{
	var_00 = maps\mp\_utility::func_3FA0("insta_kill");
	return var_00;
}

//Function Number: 97
func_577E(param_00)
{
	return isdefined(param_00.var_E8) && param_00.var_E8;
}

//Function Number: 98
func_5783(param_00)
{
	return isdefined(param_00.var_53F0) && param_00.var_53F0;
}

//Function Number: 99
func_577D(param_00)
{
	return isdefined(param_00.var_5118) && param_00.var_5118;
}

//Function Number: 100
func_0F10()
{
	foreach(var_01 in level.var_744A)
	{
		if(func_577D(var_01))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 101
func_09E9(param_00,param_01)
{
	param_00.var_831B[param_01] = 1;
}

//Function Number: 102
func_7CF8(param_00,param_01)
{
	param_00.var_831B[param_01] = undefined;
}

//Function Number: 103
func_57C2(param_00)
{
	return param_00.var_831B.size > 0;
}

//Function Number: 104
func_8623(param_00)
{
	if(param_00)
	{
		self.var_CE = 1;
		if(!isdefined(self.var_509C) || self.var_509C < 0)
		{
			self.var_509C = 0;
		}

		self.var_509C++;
		return;
	}

	if(isdefined(self.var_509C) && self.var_509C > 0)
	{
		self.var_509C--;
		if(self.var_509C > 0)
		{
			return;
		}

		self.var_CE = 0;
	}
}

//Function Number: 105
func_8A6D(param_00)
{
	if(!isdefined(self.var_AC5C))
	{
		self.var_AC5C = 0;
		self.var_AC5B = 0;
	}

	var_01 = 0;
	if(param_00)
	{
		self.var_AC5C++;
		var_01 = self.var_AC5C == 1;
	}
	else if(self.var_AC5C > 0)
	{
		self.var_AC5C--;
		var_01 = self.var_AC5C == 0;
	}

	if(var_01)
	{
		self.var_AC5B = param_00;
		self notify("zombiesIgnoreMeChanged",param_00);
	}
}

//Function Number: 106
func_2306()
{
	return isdefined(level.var_AC52) && level.var_AC52;
}

//Function Number: 107
func_0C23(param_00)
{
	var_01 = "specialty_longersprint";
	if(param_00)
	{
		maps\mp\_utility::func_47A2(var_01);
		return;
	}

	if(maps\mp\_utility::func_649(var_01))
	{
		maps\mp\_utility::func_735(var_01);
	}
}

//Function Number: 108
func_73B0(param_00,param_01)
{
	maps\mp\_utility::func_693("extendedSprint",param_00,param_01,::func_0C23,0);
}

//Function Number: 109
func_0C26(param_00)
{
	var_01 = "specialty_lightweight";
	if(param_00)
	{
		maps\mp\_utility::func_47A2(var_01);
		return;
	}

	if(maps\mp\_utility::func_649(var_01))
	{
		maps\mp\_utility::func_735(var_01);
	}
}

//Function Number: 110
func_73B1(param_00,param_01)
{
	maps\mp\_utility::func_693("lightweight",param_00,param_01,::func_0C26,0);
}

//Function Number: 111
func_AC16(param_00,param_01)
{
	maps\mp\_utility::func_73AF(param_00,param_01);
	func_73B0(param_00,param_01);
	func_73B1(param_00,param_01);
}

//Function Number: 112
func_4474(param_00)
{
	return "" + param_00;
}

//Function Number: 113
func_4660(param_00)
{
	switch(param_00)
	{
		case 0:
			return 0;

		case 100:
			return 0;

		case 200:
			return 100;

		case 250:
			return 100;

		case 300:
			return 200;

		case 400:
			return 200;

		case 500:
			return 250;

		case 600:
			return 300;

		case 700:
			return 300;

		case 750:
			return 300;

		case 800:
			return 400;

		case 900:
			return 400;

		case 1000:
			return 500;

		case 1250:
			return 500;

		case 1500:
			return 750;

		case 1750:
			return 800;

		case 2000:
			return 1000;

		case 2500:
			return 1250;

		case 3000:
			return 1500;

		case 4000:
			return 2000;

		case 5000:
			return 2500;

		default:
			return 500;
	}
}

//Function Number: 114
func_4522(param_00)
{
	switch(param_00)
	{
		case 0:
			return 0;

		case 100:
			return 200;

		case 200:
			return 300;

		case 250:
			return 400;

		case 300:
			return 500;

		case 400:
			return 600;

		case 500:
			return 1000;

		case 600:
			return 1000;

		case 700:
			return 1000;

		case 750:
			return 1000;

		case 800:
			return 1250;

		case 900:
			return 1500;

		case 1000:
			return 1500;

		case 1250:
			return 1750;

		case 1500:
			return 2000;

		case 1750:
			return 2500;

		case 2000:
			return 2500;

		case 2500:
			return 3000;

		case 3000:
			return 4000;

		case 3750:
			return 4000;

		case 4000:
			return 5000;

		case 5000:
			return 7500;

		case 7500:
			return 10000;

		case 10000:
			return 10000;

		default:
			return 1000;
	}
}

//Function Number: 115
func_ABF1(param_00,param_01)
{
	if(getdvarint("spawnZombiesWithEyes",0) == 0)
	{
		return;
	}

	if(!isdefined(param_01))
	{
		param_01 = "tag_eye";
	}

	self.var_3998 = 1;
	func_74A5(common_scripts\utility::func_44F5(param_00),self,param_01);
	thread func_AC61(param_00,param_01,"humanoidPendingDeath");
}

//Function Number: 116
func_AC61(param_00,param_01,param_02)
{
	self notify("zombieStopEyeEffectsOnNotify");
	self endon("zombieStopEyeEffectsOnNotify");
	self endon("death");
	self waittill(param_02);
	func_9406(common_scripts\utility::func_44F5(param_00),self,param_01);
}

//Function Number: 117
func_2D19(param_00)
{
	if(function_01EF(param_00))
	{
		param_00 maps/mp/agents/_agent_utility::deleteentonagentdeath(self);
		return;
	}

	func_2D20(param_00,"death");
}

//Function Number: 118
func_2D20(param_00,param_01)
{
	self endon("death");
	param_00 waittill(param_01);
	if(isdefined(self))
	{
		self delete();
	}
}

//Function Number: 119
func_57DB(param_00)
{
	return !isdefined(level.var_62B2[param_00]);
}

//Function Number: 120
func_0FBF(param_00)
{
	var_01 = [];
	foreach(var_04, var_03 in param_00)
	{
		if(!isdefined(var_03))
		{
			continue;
		}

		if(function_02A2(var_04))
		{
			var_01[var_01.size] = var_03;
			continue;
		}

		var_01[var_04] = var_03;
	}

	return var_01;
}

//Function Number: 121
func_5702(param_00)
{
	if(!isdefined(param_00.var_A4B))
	{
		return 0;
	}

	if(param_00.var_A4B != "zombie_generic")
	{
		return 0;
	}

	return 1;
}

//Function Number: 122
func_4B4F(param_00)
{
	return isdefined(param_00.var_8D9);
}

//Function Number: 123
func_21AA(param_00)
{
	return isdefined(self.var_8D9) && isdefined(self.var_8D9[param_00]);
}

//Function Number: 124
resetcharacterclientindex(param_00)
{
	if(!isdefined(level.var_AB21))
	{
		return;
	}

	level.var_AB21[level.var_AB21.size] = param_00;
}

//Function Number: 125
selectcharacterclientindextouse()
{
	if(isdefined(level.var_AB21) && level.var_AB21.size == 0)
	{
		return -1;
	}

	var_00 = -1;
	if(!isdefined(level.var_AB21))
	{
		level.var_AB21 = [];
		level.var_AB21[level.var_AB21.size] = 3;
		level.var_AB21[level.var_AB21.size] = 2;
		level.var_AB21[level.var_AB21.size] = 1;
		level.var_AB21[level.var_AB21.size] = 0;
	}

	var_00 = level.var_AB21[level.var_AB21.size - 1];
	level.var_AB21[level.var_AB21.size - 1] = undefined;
	return var_00;
}

//Function Number: 126
func_839B(param_00)
{
	if(isdefined(param_00))
	{
		return param_00;
	}

	var_01 = self getrankedplayerdata(common_scripts\utility::func_46A8(),"activeCostume");
	var_02 = self getrankedplayerdata(common_scripts\utility::func_46A8(),"costumePrefZM");
	var_03 = [0,1,2,3];
	var_04 = [];
	var_05 = "mp/zombieDLC3MapInfoTable.csv";
	if(tableexists(var_05) && function_027A(var_05) > 0)
	{
		var_06 = tablelookup(var_05,0,maps\mp\_utility::func_4571(),2);
		if(isdefined(var_06) && var_06 != "")
		{
			var_07 = strtok(var_06," ,");
			foreach(var_09 in var_07)
			{
				var_04[var_04.size] = int(var_09);
			}
		}

		if(var_04.size >= 4)
		{
			var_03 = common_scripts\utility::func_F8C(var_03,var_04);
		}
		else
		{
			var_04 = var_03;
		}
	}

	var_0B = [];
	foreach(var_0D in level.var_744A)
	{
		var_0B[var_0D.var_20D8] = 1;
	}

	if((var_01 < 4 || !common_scripts\utility::func_562E(var_02)) && common_scripts\utility::func_562E(var_0B[var_01]) && common_scripts\utility::func_F79(var_03,var_01))
	{
		var_0F = [];
		foreach(var_09 in var_04)
		{
			if(!common_scripts\utility::func_562E(var_0B[var_09]))
			{
				var_0F[var_0F.size] = var_09;
			}
		}

		var_01 = common_scripts\utility::func_7A33(var_0F);
		self setrankedplayerdata(common_scripts\utility::func_46A8(),"activeCostume",var_01);
		self setrankedplayerdata(common_scripts\utility::func_46A8(),"costumePrefZM",0);
	}

	return var_01;
}

//Function Number: 127
func_0A00(param_00,param_01)
{
	var_02 = param_00.var_A9BB;
	var_03 = maps\mp\_utility::func_4431(param_01);
	if(var_02 == 0)
	{
		var_04 = spawnstruct();
		var_04.var_109 = var_03;
		var_04.var_4DDE = 0;
		var_04.var_32D0 = 0;
		var_04.var_4BF9 = 0;
		var_04.var_55D3 = func_5868(param_01);
		var_04.var_E3 = 0;
		var_04.var_72AC = param_00.var_2418;
		var_04.var_8B34 = 0;
		var_04.var_99E8 = 0;
		param_00.var_A9BA[var_02] = var_04;
		param_00.var_A9BB = param_00.var_A9BB + 1;
		return;
	}

	if(var_02 > 0 && var_02 < 10)
	{
		for(var_05 = 0;var_05 < var_02;var_05++)
		{
			if(param_00.var_A9BA[var_05].var_109 == var_03)
			{
				return;
			}
		}

		var_04 = spawnstruct();
		var_04.var_109 = var_03;
		var_04.var_4DDE = 0;
		var_04.var_32D0 = 0;
		var_04.var_4BF9 = 0;
		var_04.var_55D3 = func_5868(param_01);
		var_04.var_E3 = 0;
		var_04.var_72AC = param_00.var_2418;
		var_04.var_8B34 = 0;
		var_04.var_99E8 = 0;
		param_00.var_A9BA[var_02] = var_04;
		param_00.var_A9BB = param_00.var_A9BB + 1;
	}
}

//Function Number: 128
func_4837(param_00,param_01)
{
	var_02 = param_00.var_A9BB;
	var_03 = maps\mp\_utility::func_4431(param_01);
	for(var_04 = 0;var_04 < var_02;var_04++)
	{
		if(param_00.var_A9BA[var_04].var_109 == var_03)
		{
			return var_04;
		}
	}

	return -1;
}

//Function Number: 129
func_429D(param_00)
{
	return param_00.var_20D8;
}

//Function Number: 130
func_4309()
{
	var_00 = maps/mp/agents/_agent_utility::func_43FD("all");
	var_01 = [];
	foreach(var_03 in var_00)
	{
		if(var_03.var_1A7 == level.var_3772)
		{
			var_01[var_01.size] = var_03;
		}
	}

	return var_01;
}

//Function Number: 131
func_5565(param_00,param_01)
{
	return isdefined(param_00) && isdefined(param_01) && param_00 == param_01;
}

//Function Number: 132
func_8557(param_00)
{
	self.var_56EA = param_00;
}

//Function Number: 133
func_429E()
{
	return self.var_56EA;
}

//Function Number: 134
initializezmcostumemodels()
{
	level.zmcostumes = [];
	var_00 = function_027A("mp/zmCharacterIdTable.csv");
	for(var_01 = 0;var_01 < var_00;var_01++)
	{
		var_02 = [func_9470(tablelookupbyrow("mp/zmCharacterIdTable.csv",var_01,1)),func_9470(tablelookupbyrow("mp/zmCharacterIdTable.csv",var_01,2)),func_9470(tablelookupbyrow("mp/zmCharacterIdTable.csv",var_01,3)),func_9470(tablelookupbyrow("mp/zmCharacterIdTable.csv",var_01,4)),func_9470(tablelookupbyrow("mp/zmCharacterIdTable.csv",var_01,5)),func_9470(tablelookupbyrow("mp/zmCharacterIdTable.csv",var_01,6))];
		level.zmcostumes[level.zmcostumes.size] = var_02;
	}

	if(isdefined(level.zmcharactervariantid) && level.zmcharactervariantid > 0)
	{
		for(var_0A = function_027A("mp/zmCharacterVariantIdTable.csv") - 1;var_0A >= 0;var_0A = var_0B - 1)
		{
			var_0B = tablelookuprownum("mp/zmCharacterVariantIdTable.csv",7,level.zmcharactervariantid,var_0A);
			if(var_0B >= 0)
			{
				var_02 = [func_9470(tablelookupbyrow("mp/zmCharacterVariantIdTable.csv",var_0B,1)),func_9470(tablelookupbyrow("mp/zmCharacterVariantIdTable.csv",var_0B,2)),func_9470(tablelookupbyrow("mp/zmCharacterVariantIdTable.csv",var_0B,3)),func_9470(tablelookupbyrow("mp/zmCharacterVariantIdTable.csv",var_0B,4)),func_9470(tablelookupbyrow("mp/zmCharacterVariantIdTable.csv",var_0B,5)),func_9470(tablelookupbyrow("mp/zmCharacterVariantIdTable.csv",var_0B,6))];
				var_01 = func_9470(tablelookupbyrow("mp/zmCharacterVariantIdTable.csv",var_0B,0));
				level.zmcostumes[var_01] = var_02;
			}
		}
	}
}

//Function Number: 135
func_8648(param_00,param_01,param_02)
{
	if(!isdefined(param_01) || param_01 == 0)
	{
		self waittill("spawned_player");
	}

	if(!isdefined(level.zmcostumes) || !isdefined(level.zmcostumes[self.var_20D8]))
	{
		initializezmcostumemodels();
	}

	if(!isdefined(param_00))
	{
		param_00 = "sold";
		self.var_20D8 = 0;
	}

	if(self.var_20D8 < 0 || self.var_20D8 >= level.zmcostumes.size)
	{
		param_00 = "sold";
		self.var_20D8 = 0;
	}

	self.var_267E = level.zmcostumes[self.var_20D8];
	self setcostumemodels(self.var_267E);
	self.var_20DA = param_00;
	self.altchartypes = param_02;
}

//Function Number: 136
cp_zmb_should_allow_far_search_dist_func(param_00)
{
	var_01 = -1;
	if(!isdefined(self.characterclientindex))
	{
		var_01 = selectcharacterclientindextouse();
	}
	else
	{
		var_01 = self.characterclientindex;
	}

	var_02 = func_839B(param_00);
	var_03 = 1;
	if(var_02 == -1)
	{
		var_03 = 0;
		var_02 = 0;
	}

	if(var_03)
	{
		var_04 = "ui_zm_characterClient_" + var_01;
		setomnvar(var_04,self getentitynumber());
		var_05 = "ui_zm_character_" + var_01;
		setomnvar(var_05,var_02);
		var_06 = "ui_zm_character_" + var_01 + "_alive";
		setomnvar(var_06,0);
		thread func_7D59(var_04,var_05,var_06,var_01);
	}

	self.var_20D8 = var_02;
	self.characterclientindex = var_01;
	func_865A(self.var_20D8,0);
	func_8647(self.var_20D8);
}

//Function Number: 137
func_8647(param_00)
{
	self.var_3A63 = [];
	var_01 = lib_0378::dlg_get_char_name_callouts_from_index(self.var_20D8);
	var_01 = var_01 + "_";
	level.var_A62B lib_054E::func_AB1E("player",var_01,self,self.var_20D8);
	maps\mp\gametypes\_battlechatter_mp::func_2F72(self);
	if(param_00 == 39)
	{
		self.nobayocharge = 1;
	}
}

//Function Number: 138
func_865A(param_00,param_01)
{
	var_02 = undefined;
	var_03 = 0;
	if(!isdefined(level.charidtotype) || !isdefined(level.charidtogender) || !isdefined(level.charidtoalttypes))
	{
		level.charidtotype = [];
		level.charidtogender = [];
		level.charidtoalttypes = [];
		var_04 = function_027A("mp/zmCharacterIdTable.csv");
		for(var_05 = 0;var_05 < var_04;var_05++)
		{
			var_06 = tablelookupbyrow("mp/zmCharacterIdTable.csv",var_05,13);
			var_07 = func_9470(tablelookupbyrow("mp/zmCharacterIdTable.csv",var_05,14));
			var_08 = tablelookupbyrow("mp/zmCharacterIdTable.csv",var_05,15);
			level.charidtotype[var_05] = var_06;
			level.charidtogender[var_05] = var_07;
			level.charidtoalttypes[var_05] = var_08;
		}
	}

	if(!isdefined(param_00) || !isdefined(level.charidtotype[param_00]))
	{
		param_00 = 0;
	}

	var_02 = level.charidtotype[param_00];
	var_03 = level.charidtogender[param_00];
	var_09 = level.charidtoalttypes[param_00];
	if(isdefined(var_02))
	{
		thread func_8648(var_02,param_01,var_09);
		func_8557(var_03);
		lib_0378::func_8DDA(param_00);
	}
}

//Function Number: 139
func_7D59(param_00,param_01,param_02,param_03)
{
	self waittill("disconnect");
	setomnvar(param_00,-1);
	setomnvar(param_01,-1);
	setomnvar(param_02,0);
	setomnvar("ui_zm_points_" + param_03,0);
	resetcharacterclientindex(param_03);
}

//Function Number: 140
func_3C8A(param_00,param_01)
{
	level thread func_0628(param_00,param_01);
}

//Function Number: 141
func_0628(param_00,param_01)
{
	if(isarray(param_00))
	{
		common_scripts\utility::func_3CA1(param_00);
	}
	else
	{
		common_scripts\utility::func_3C9F(param_00);
	}

	common_scripts\utility::func_3C8F(param_01);
}

//Function Number: 142
func_45A2()
{
	return int(gettime() / 100);
}

//Function Number: 143
func_A6F6()
{
	wait 0.05;
	wait 0.05;
}

//Function Number: 144
func_74A5(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_01))
	{
		return;
	}

	if(!isdefined(param_03))
	{
		param_03 = 0;
	}

	thread func_069C(param_00,param_01,param_02,param_03);
}

//Function Number: 145
func_069C(param_00,param_01,param_02,param_03)
{
	param_01 endon("death");
	param_01 notify("StopFxOnTagNetwork_" + param_00 + param_02);
	param_01 endon("StopFxOnTagNetwork_" + param_00 + param_02);
	func_076F(param_01);
	if(!isdefined(param_01))
	{
		return;
	}

	if(!param_03 && !isdefined(level.var_37E6[param_01 getentitynumber()]))
	{
		level.var_37E6[param_01 getentitynumber()] = param_01;
	}

	playfxontag(param_00,param_01,param_02);
	param_01 func_061D();
	var_04 = spawnstruct();
	var_04.var_502A = param_00;
	var_04.var_95B9 = param_02;
	param_01.var_9BA5[param_01.var_9BA5.size] = var_04;
	param_01 thread func_0621(var_04);
}

//Function Number: 146
func_74A4(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_01))
	{
		return;
	}

	thread func_069B(param_00,param_01,param_02,param_03);
}

//Function Number: 147
func_069B(param_00,param_01,param_02,param_03)
{
	param_01 endon("death");
	param_01 endon("StopFxOnTagNetwork_" + param_00 + param_02);
	func_076F(param_01);
	playfxontagforclients(param_00,param_01,param_02,param_03);
	param_01 func_061D();
}

//Function Number: 148
func_9405(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_01))
	{
		return;
	}

	thread func_0724(param_00,param_01,param_02,param_03);
}

//Function Number: 149
func_0724(param_00,param_01,param_02,param_03)
{
	param_01 endon("death");
	param_01 endon("StopFxOnTagNetwork_" + param_00 + param_02);
	func_076F(param_01);
	function_0294(param_00,param_01,param_02,param_03);
	param_01 func_061D();
}

//Function Number: 150
func_9406(param_00,param_01,param_02)
{
	if(!isdefined(param_01))
	{
		return;
	}

	thread func_0725(param_00,param_01,param_02);
}

//Function Number: 151
func_0725(param_00,param_01,param_02)
{
	param_01 endon("death");
	param_01 notify("StopFxOnTagNetwork_" + param_00 + param_02);
	param_01 endon("StopFxOnTagNetwork_" + param_00 + param_02);
	func_076F(param_01);
	stopfxontag(param_00,param_01,param_02);
	param_01 func_061D();
}

//Function Number: 152
func_5A48(param_00,param_01,param_02)
{
	if(!isdefined(param_01))
	{
		return;
	}

	func_066B(param_00,param_01,param_02);
}

//Function Number: 153
func_066B(param_00,param_01,param_02)
{
	param_01 endon("death");
	param_01 notify("StopFxOnTagNetwork_" + param_00 + param_02);
	param_01 endon("StopFxOnTagNetwork_" + param_00 + param_02);
	func_076F(param_01);
	killfxontag(param_00,param_01,param_02);
	param_01 func_061D();
}

//Function Number: 154
func_076F(param_00)
{
	var_01 = 0;
	if(!isdefined(param_00.var_9BA6))
	{
		param_00 func_061F();
	}
	else if(func_45A2() > param_00.var_9BA6.var_666D)
	{
		param_00 func_061E();
	}

	while(param_00.var_9BA6.var_5C >= level.var_666C || isdefined(param_00.alignx) && param_00.alignx == gettime())
	{
		func_A6F6();
		var_01 = 1;
		if(!isdefined(param_00))
		{
			return var_01;
		}

		if(!isdefined(param_00.var_9BA6))
		{
			param_00 func_061F();
		}

		if(func_45A2() > param_00.var_9BA6.var_666D)
		{
			param_00 func_061E();
		}
	}

	return var_01;
}

//Function Number: 155
func_061F()
{
	self.var_9BA5 = [];
	self.var_9BA6 = spawnstruct();
	func_061E();
}

//Function Number: 156
func_061E()
{
	self.var_9BA6.var_5C = 0;
	self.var_9BA6.var_666D = func_45A2();
}

//Function Number: 157
func_061D()
{
	self.var_9BA6.var_5C++;
}

//Function Number: 158
func_0621(param_00)
{
	self endon("death");
	thread func_0620();
	self waittill("StopFxOnTagNetwork_" + param_00.var_502A + param_00.var_95B9);
	self.var_9BA5 = common_scripts\utility::func_F93(self.var_9BA5,param_00);
	if(self.var_9BA5.size == 0)
	{
		thread func_061C();
	}
}

//Function Number: 159
func_0620()
{
	self notify("_entityKillFXOnDeath");
	self endon("_entityKillFXOnDeath");
	var_00 = self getentitynumber();
	self waittill("death");
	level.var_37E6[var_00] = undefined;
	if(isdefined(self))
	{
		self.var_9BA5 = undefined;
		self.var_9BA6 = undefined;
	}
}

//Function Number: 160
func_061C()
{
	level.var_37E6[self getentitynumber()] = undefined;
	self.var_9BA5 = undefined;
	self.var_9BA6 = undefined;
}

//Function Number: 161
func_92D8(param_00)
{
	param_00 endon("disconnect");
	if(param_00 maps\mp\gametypes\_playerlogic::func_60B2())
	{
		param_00 waittill("spawned_player");
	}
	else
	{
		param_00 waittill("joined_spectators");
	}

	func_A78A(param_00);
	if(common_scripts\utility::func_562E(param_00.var_5C16))
	{
		return;
	}

	param_00.var_5C16 = 1;
	foreach(var_02 in level.var_37E6)
	{
		thread func_92D9(param_00,var_02);
	}
}

//Function Number: 162
func_92D9(param_00,param_01)
{
	param_01 endon("death");
	if(!isdefined(param_01) || !isdefined(param_01.var_9BA5))
	{
		return;
	}

	var_02 = [];
	var_03 = param_01.var_9BA5.size;
	for(var_04 = 0;var_04 < var_03;var_04++)
	{
		var_05 = param_01.var_9BA5[var_04];
		func_9405(var_05.var_502A,param_01,var_05.var_95B9,param_00);
		var_02[var_02.size] = var_05;
	}

	func_A78A(param_00);
	for(var_04 = 0;var_04 < var_02.size;var_04++)
	{
		var_05 = var_02[var_04];
		if(!isdefined(var_05) || !common_scripts\utility::func_F79(param_01.var_9BA5,var_05))
		{
			continue;
		}

		func_74A4(var_05.var_502A,param_01,var_05.var_95B9,param_00);
	}
}

//Function Number: 163
func_4AD7()
{
	thread func_6B6F();
	thread func_6B44();
}

//Function Number: 164
func_6B6F()
{
	if(!isdefined(level.var_37E6))
	{
		level.var_37E6 = [];
	}

	level.var_666C = 2;
	for(;;)
	{
		level waittill("connected",var_00);
		if(isbot(var_00))
		{
			continue;
		}

		level thread func_92D8(var_00);
	}
}

//Function Number: 165
func_6B44()
{
	for(;;)
	{
		level waittill("host_migration_begin");
		foreach(var_01 in level.var_37E6)
		{
			thread func_92D7(var_01);
		}
	}
}

//Function Number: 166
func_92D7(param_00)
{
	param_00 endon("death");
	if(!isdefined(param_00) || !isdefined(param_00.var_9BA5))
	{
		return;
	}

	waittillframeend;
	var_01 = [];
	var_02 = param_00.var_9BA5.size;
	for(var_03 = 0;var_03 < var_02;var_03++)
	{
		var_04 = param_00.var_9BA5[var_03];
		func_9406(var_04.var_502A,param_00,var_04.var_95B9);
		var_01[var_01.size] = var_04;
	}

	level waittill("host_migration_end");
	for(var_03 = 0;var_03 < var_01.size;var_03++)
	{
		var_04 = var_01[var_03];
		func_74A5(var_04.var_502A,param_00,var_04.var_95B9);
	}
}

//Function Number: 167
func_5752(param_00)
{
	if(isdefined(param_00))
	{
		var_01 = getweapondisplayname(param_00);
		if(!isdefined(var_01))
		{
			return 0;
		}

		switch(var_01)
		{
			case "electric_cherry_zm":
			case "raven_sword_tod_aoe_zm":
				return 1;
		}

		if(isdefined(level.meleeaoeweapons[var_01]))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 168
func_580B(param_00)
{
	if(isdefined(param_00))
	{
		switch(param_00)
		{
			case "zombie_trap_turret_mp":
			case "trap_sniper_zm_mp":
			case "trap_missile_zm_mp":
			case "trap_zm_mp":
			case "portaltrap_zm":
			case "zombie_water_trap_mp":
			case "zombie_vaporize_mp":
				return 1;

			default:
				return 0;
		}
	}

	return 0;
}

//Function Number: 169
func_57AC(param_00)
{
	if(isdefined(param_00))
	{
		switch(param_00)
		{
			case "portaltrap_zm":
				return 1;

			default:
				return 0;
		}
	}

	return 0;
}

//Function Number: 170
func_466A(param_00)
{
	switch(param_00)
	{
		case "zombie_dog":
			return 1;

		case "normal":
		default:
			return 0;
	}
}

//Function Number: 171
func_A737()
{
	while(!func_4B2C())
	{
		wait 0.05;
	}
}

//Function Number: 172
func_4B2C()
{
	return common_scripts\utility::func_562E(self.var_4BA0);
}

//Function Number: 173
func_84CB()
{
	if(!common_scripts\utility::func_562E(self.var_4BA0))
	{
		self.var_4BA0 = 1;
		self.var_37BB = self.var_116;
	}
}

//Function Number: 174
func_5819(param_00)
{
	return isdefined(param_00.var_81E1);
}

//Function Number: 175
func_581A(param_00)
{
	return !isdefined(param_00.var_81E1) || param_00.var_81E1 == 0;
}

//Function Number: 176
func_8A4F(param_00,param_01,param_02)
{
	if(!isdefined(param_00.var_81E1))
	{
		return;
	}

	param_00 common_scripts\utility::func_9D9F();
	param_00.var_2307 = 0;
	var_03 = [];
	var_03["trigger"] = param_00;
	var_03["updateFunc"] = param_01;
	var_03["otherClientsUpdateFunc"] = param_02;
	thread func_A243(var_03);
}

//Function Number: 177
func_A243(param_00)
{
	var_01 = param_00["trigger"];
	var_01 endon("death");
	maps\mp\_utility::func_6F74(::func_A242,param_00);
}

//Function Number: 178
func_A242(param_00)
{
	var_01 = param_00["trigger"];
	var_02 = param_00["otherClientsUpdateFunc"];
	if(func_0696(var_01))
	{
		thread func_0694(param_00);
		return;
	}

	if(isdefined(var_02))
	{
		var_01 thread [[ var_02 ]](self);
	}
}

//Function Number: 179
func_0696(param_00)
{
	return isdefined(param_00.var_81E1) && self getentitynumber() == param_00.var_81E1;
}

//Function Number: 180
func_0694(param_00)
{
	var_01 = param_00["trigger"];
	self clientclaimtrigger(var_01);
	var_01 common_scripts\utility::func_9DA3();
	var_01 notify("claimed");
	var_01.var_2307 = 1;
	var_01.var_230A = self;
	thread func_069A(param_00);
	var_02 = param_00["updateFunc"];
	var_01 thread [[ var_02 ]](self);
}

//Function Number: 181
func_069A(param_00)
{
	var_01 = param_00["trigger"];
	var_01 endon("death");
	self waittill("disconnect");
	if(isdefined(self))
	{
		self clientreleasetrigger(var_01);
	}

	var_01 common_scripts\utility::func_9D9F();
	var_01.var_2307 = 0;
	var_01.var_230A = undefined;
}

//Function Number: 182
func_57AF(param_00)
{
	return param_00 == "turretheadenergy_mp" || param_00 == "turretheadrocket_mp" || param_00 == "turretheadmg_mp";
}

//Function Number: 183
func_6C72(param_00)
{
	for(;;)
	{
		foreach(var_02 in level.var_744A)
		{
			if(!isdefined(var_02))
			{
				continue;
			}

			if(var_02.var_178 == "spectator" || var_02.var_178 == "intermission")
			{
				continue;
			}

			if(var_02 method_8552())
			{
				continue;
			}

			var_03 = var_02 lib_055A::func_462D();
			if(!isdefined(var_03))
			{
				var_04 = !param_00;
				if(var_04)
				{
					var_02 suicide();
				}
				else
				{
					iprintlnbold("Player out of bounds at " + var_02.var_116);
					wait(1);
				}
			}

			if(!param_00)
			{
				wait(0.5);
			}
		}

		wait 0.05;
	}
}

//Function Number: 184
func_A78A(param_00)
{
	param_00 endon("disconnect");
	var_01 = param_00 method_855E();
	if(!isdefined(var_01))
	{
		return;
	}

	for(;;)
	{
		wait 0.05;
		var_02 = param_00 method_855F();
		if(!isdefined(var_02))
		{
			return;
		}

		if(var_02 >= var_01)
		{
			break;
		}
	}
}

//Function Number: 185
func_A78B()
{
	while(!isdefined(level.var_744A) || level.var_744A.size <= 0)
	{
		wait 0.05;
	}
}

//Function Number: 186
trackzombiedvar(param_00)
{
	if(!isdefined(level.zombie_tracked_dvars))
	{
		level.zombie_tracked_dvars = [];
	}

	var_01 = spawnstruct();
	var_01.dvar_name = param_00;
	var_01.dvar_value = getdvar(param_00);
	level.zombie_tracked_dvars[level.zombie_tracked_dvars.size] = var_01;
	return var_01;
}

//Function Number: 187
func_585E()
{
	if(!isdefined(level.var_AC21))
	{
		return 0;
	}

	return level.var_AC21;
}

//Function Number: 188
func_4AE4(param_00,param_01,param_02,param_03,param_04)
{
	if(isdefined(level.zmb_events_purchase_callback))
	{
		level thread [[ level.zmb_events_purchase_callback ]](param_00,param_01,param_02);
	}

	if(isdefined(level.zmb_events_purchase_notify))
	{
		param_00 notify(level.zmb_events_purchase_notify + "_" + param_01);
	}

	param_03 = func_AAF9(param_03,1,0);
	var_05 = level.var_77B7;
	if(var_05 >= 500)
	{
		return;
	}

	var_06 = param_00 getentitynumber();
	var_07 = gettime();
	var_08 = param_00.var_116;
	var_09 = level.var_A980;
	setmatchdata("purchase_events",var_05,"purchase_type",param_01);
	setmatchdata("purchase_events",var_05,"player_index",var_06);
	setmatchdata("purchase_events",var_05,"game_time",int(var_07));
	setmatchdata("purchase_events",var_05,"round_index",var_09);
	setmatchdata("purchase_events",var_05,"pos",0,maps\mp\_utility::func_2315(var_08[0]));
	setmatchdata("purchase_events",var_05,"pos",1,maps\mp\_utility::func_2315(var_08[1]));
	setmatchdata("purchase_events",var_05,"pos",2,maps\mp\_utility::func_2315(var_08[2]));
	setmatchdata("purchase_events",var_05,"cost",param_02);
	if(function_012A("ZombieWeapon",param_03))
	{
		setmatchdata("purchase_events",var_05,"weapon",param_03);
	}
	else
	{
	}

	if(function_012A("ZombieDoors",param_04))
	{
		setmatchdata("purchase_events",var_05,"door",param_04);
	}
	else if(!common_scripts\utility::func_562E(level.door_data_out_of_date))
	{
	}

	level.var_77B7++;
}

//Function Number: 189
writeusedconsumable(param_00,param_01,param_02)
{
	if(!level.var_585D)
	{
		return;
	}

	var_03 = getmatchdata("consumable_count");
	setmatchdata("consumable_count",var_03 + 1);
	if(var_03 < 16)
	{
		var_04 = level.var_A980 - 1;
		setmatchdata("consumables",var_03,"guid",param_00);
		setmatchdata("consumables",var_03,"player_index",param_01);
		setmatchdata("consumables",var_03,"round_index",var_04);
		setmatchdata("consumables",var_03,"time_activated_ms",maps\mp\_utility::func_46E3());
		setmatchdata("consumables",var_03,"position",0,maps\mp\_utility::func_2315(param_02[0]));
		setmatchdata("consumables",var_03,"position",1,maps\mp\_utility::func_2315(param_02[1]));
		setmatchdata("consumables",var_03,"position",2,maps\mp\_utility::func_2315(param_02[2]));
	}
}

//Function Number: 190
func_AABF()
{
	var_00 = level.var_A980 - 1;
	func_AABD();
	if(var_00 >= 0 && var_00 < 75)
	{
		var_01 = maps\mp\_utility::func_2315(maps\mp\_utility::func_467B());
		setmatchdata("rounds",var_00,"endTime",var_01);
		var_02 = getmatchdata("rounds",var_00,"startTime");
		setmatchdata("rounds",var_00,"duration",maps\mp\_utility::func_2315(var_01 - var_02));
		setmatchdata("rounds",var_00,"round_players_total",maps\mp\_utility::func_2314(level.var_745F));
		foreach(var_05, var_04 in self.var_AC60)
		{
			setmatchdata("rounds",var_00,"zombies_spawned",var_05,var_04);
		}
	}

	foreach(var_07 in level.var_744A)
	{
		writezombieendgameplayerstats(var_07);
		if(var_00 >= 0 && var_00 < 75)
		{
			var_07 func_7B36(var_00);
			var_07 func_5292(var_00);
		}
	}
}

//Function Number: 191
func_AABD()
{
	foreach(var_01 in level.var_744A)
	{
		setmatchdata("players",var_01.var_2418,"end_assists",maps\mp\_utility::func_2315(var_01.var_21));
		setmatchdata("players",var_01.var_2418,"end_kills",maps\mp\_utility::func_2315(var_01.var_E3));
		setmatchdata("players",var_01.var_2418,"end_hits",var_01.var_8B33);
		setmatchdata("players",var_01.var_2418,"end_shots",var_01.var_8B3D);
		setmatchdata("players",var_01.var_2418,"end_money_earned",var_01.var_62D7);
		setmatchdata("players",var_01.var_2418,"end_money_spent",var_01.var_62D7 - var_01.var_62D6);
		setmatchdata("players",var_01.var_2418,"end_magic_box_uses",maps\mp\_utility::func_2315(var_01.var_5F7C));
		setmatchdata("players",var_01.var_2418,"end_trap_uses",maps\mp\_utility::func_2315(var_01.var_9CFF));
		setmatchdata("players",var_01.var_2418,"end_headshot_kills",maps\mp\_utility::func_2315(var_01.var_4BF7));
		setmatchdata("players",var_01.var_2418,"end_melee_kills",maps\mp\_utility::func_2315(var_01.var_60EC));
		setmatchdata("players",var_01.var_2418,"end_explosive_kills",maps\mp\_utility::func_2315(var_01.var_394C));
		setmatchdata("players",var_01.var_2418,"play_time",var_01.var_9A06["total"]);
		setmatchdata("players",var_01.var_2418,"end_total_downs",maps\mp\_utility::func_2315(var_01.var_6882));
		setmatchdata("players",var_01.var_2418,"end_total_rounds",maps\mp\_utility::func_2315(level.var_A980));
		setmatchdata("players",var_01.var_2418,"end_doors_opened",maps\mp\_utility::func_2315(var_01.var_3295));
		setmatchdata("players",var_01.var_2418,"present_at_end",var_01.var_2582);
		level.var_7F2B = [];
		level.var_7F2B["normal"] = 0;
		level.var_7F2B["zombie_dog"] = 1;
		level.var_7F2B["zombie_host"] = 2;
		level.var_7F2B["zombie_melee_goliath"] = 3;
		level.var_7F2B["civilian"] = 4;
		if(isdefined(level.var_7F2B[level.var_7F2A]))
		{
			setmatchdata("players",var_01.var_2418,"end_unlock_points",level.var_7F2B[level.var_7F2A]);
		}

		for(var_02 = 0;var_02 < var_01.var_A9BB;var_02++)
		{
			var_03 = func_AAF9(var_01.var_A9BA[var_02].var_109,1,0);
			if(!func_5844(var_03))
			{
				var_03 = "none";
			}

			setmatchdata("players",var_01.var_2418,"weapon_usage",var_02,"weapon_id",var_03);
			setmatchdata("players",var_01.var_2418,"weapon_usage",var_02,"hits",var_01.var_A9BA[var_02].var_4DDE);
			setmatchdata("players",var_01.var_2418,"weapon_usage",var_02,"downs",maps\mp\_utility::func_2314(var_01.var_A9BA[var_02].var_32D0));
			setmatchdata("players",var_01.var_2418,"weapon_usage",var_02,"headshots",maps\mp\_utility::func_2315(var_01.var_A9BA[var_02].var_4BF9));
			setmatchdata("players",var_01.var_2418,"weapon_usage",var_02,"is_pap_version",var_01.var_A9BA[var_02].var_55D3);
			setmatchdata("players",var_01.var_2418,"weapon_usage",var_02,"kills",maps\mp\_utility::func_2315(var_01.var_A9BA[var_02].var_E3));
			setmatchdata("players",var_01.var_2418,"weapon_usage",var_02,"player_index",maps\mp\_utility::func_2314(var_01.var_A9BA[var_02].var_72AC));
			setmatchdata("players",var_01.var_2418,"weapon_usage",var_02,"shots",var_01.var_A9BA[var_02].var_8B34);
			setmatchdata("players",var_01.var_2418,"weapon_usage",var_02,"time_used",var_01.var_A9BA[var_02].var_99E8);
		}
	}
}

//Function Number: 192
func_7B3A(param_00,param_01,param_02)
{
	var_03 = self getweaponslistprimaries();
	for(var_04 = 0;var_04 < var_03.size && var_04 < 4;var_04++)
	{
		if(common_scripts\utility::func_57E9(var_03[var_04],"alt+",0,4))
		{
			continue;
		}

		var_05 = func_AAF9(var_03[var_04],1,0);
		if(!func_5844(var_05))
		{
			continue;
		}

		if(function_012A("ZombieWeapon",var_05))
		{
			if(isdefined(param_02))
			{
				if(!param_02)
				{
					setmatchdata("rounds",param_00,"player_rounds",param_01,"start_weapons",var_04,var_05);
				}
				else
				{
					setmatchdata("rounds",param_00,"player_rounds",param_01,"end_weapons",var_04,var_05);
				}
			}

			continue;
		}
	}
}

//Function Number: 193
func_7B37(param_00)
{
	if(param_00 < 0 || param_00 >= 75)
	{
		return;
	}

	var_01 = self getentitynumber();
	var_02 = self.var_116;
	setmatchdata("rounds",param_00,"player_rounds",var_01,"player_index",maps\mp\_utility::func_2314(var_01));
	setmatchdata("rounds",param_00,"player_rounds",var_01,"round_index",maps\mp\_utility::func_2314(param_00));
	setmatchdata("rounds",param_00,"player_rounds",var_01,"startPos",0,int(var_02[0]));
	setmatchdata("rounds",param_00,"player_rounds",var_01,"startPos",1,int(var_02[1]));
	setmatchdata("rounds",param_00,"player_rounds",var_01,"startPos",2,int(var_02[2]));
	setmatchdata("rounds",param_00,"player_rounds",var_01,"start_score",int(self.var_62D7));
	if(!common_scripts\utility::func_562E(level.door_data_out_of_date))
	{
		setmatchdata("rounds",param_00,"player_rounds",var_01,"starting_zone",getplayerddlzonename());
	}

	func_7B3A(param_00,var_01,0);
	var_03 = self getweaponslistall();
	var_04 = 1;
	foreach(var_06 in var_03)
	{
		var_07 = getweapondisplayname(var_06);
		var_08 = level.var_A9E2[var_07];
		if(!isdefined(var_08))
		{
			continue;
		}

		if(func_5863(var_07))
		{
			setmatchdata("rounds",param_00,"player_rounds",var_01,"equipment",0,var_08);
			continue;
		}

		if(func_5866(var_07))
		{
			setmatchdata("rounds",param_00,"player_rounds",var_01,"equipment",1,var_08);
			continue;
		}

		var_09 = func_4747(self,var_07);
		if(var_04)
		{
			var_04 = 0;
			setmatchdata("rounds",param_00,"player_rounds",var_01,"weapons",0,var_08);
			setmatchdata("rounds",param_00,"player_rounds",var_01,"weaponLevels",0,var_09);
		}
		else
		{
			setmatchdata("rounds",param_00,"player_rounds",var_01,"weapons",1,var_08);
			setmatchdata("rounds",param_00,"player_rounds",var_01,"weaponLevels",1,var_09);
		}
	}
}

//Function Number: 194
func_7B36(param_00)
{
	if(param_00 < 0 || param_00 >= 75)
	{
		return;
	}

	var_01 = self getentitynumber();
	var_02 = self.var_116;
	setmatchdata("rounds",param_00,"player_rounds",var_01,"endPos",0,int(var_02[0]));
	setmatchdata("rounds",param_00,"player_rounds",var_01,"endPos",1,int(var_02[1]));
	setmatchdata("rounds",param_00,"player_rounds",var_01,"endPos",2,int(var_02[2]));
	setmatchdata("rounds",param_00,"player_rounds",var_01,"moneyEarned",maps\mp\_utility::func_2315(self.var_7F1D));
	setmatchdata("rounds",param_00,"player_rounds",var_01,"moneySpent",maps\mp\_utility::func_2315(self.var_7F1E));
	setmatchdata("rounds",param_00,"player_rounds",var_01,"kills",maps\mp\_utility::func_2315(self.var_E3 - self.var_5A52));
	setmatchdata("rounds",param_00,"player_rounds",var_01,"headshot_kills",maps\mp\_utility::func_2315(self.var_4BF7 - self.var_4BF8));
	setmatchdata("rounds",param_00,"player_rounds",var_01,"printerUses",maps\mp\_utility::func_2314(self.var_5F7C - self.var_5F7D));
	setmatchdata("rounds",param_00,"player_rounds",var_01,"perk_machines_used",maps\mp\_utility::func_2314(self.var_6F5F - self.var_6F60));
	setmatchdata("rounds",param_00,"player_rounds",var_01,"doors_purchased",maps\mp\_utility::func_2314(self.var_3295 - self.var_3296));
	setmatchdata("rounds",param_00,"player_rounds",var_01,"magic_box_uses",maps\mp\_utility::func_2314(self.var_5F7C - self.var_5F7D));
	setmatchdata("rounds",param_00,"player_rounds",var_01,"end_score",int(self.var_62D7));
	setmatchdata("rounds",param_00,"player_rounds",var_01,"special_ability_uses",maps\mp\_utility::func_2314(self.var_90CC - self.var_90CD));
	setmatchdata("rounds",param_00,"player_rounds",var_01,"revives",maps\mp\_utility::func_2314(self.var_21 - self.var_7E60));
	setmatchdata("rounds",param_00,"player_rounds",var_01,"jump_scares_triggered",maps\mp\_utility::func_2314(self.var_598C - self.var_598D));
	setmatchdata("rounds",param_00,"player_rounds",var_01,"pap_uses",maps\mp\_utility::func_2314(self.var_6E48 - self.var_6E49));
	setmatchdata("rounds",param_00,"player_rounds",var_01,"hints_used",maps\mp\_utility::func_2314(self.var_4DC4 - self.var_4DC5));
	self.var_4DC5 = self.var_4DC4;
	func_7B3A(param_00,var_01,1);
	foreach(var_05, var_04 in self.var_AC5D)
	{
		setmatchdata("rounds",param_00,"player_rounds",var_01,"zombies_killed",var_05,var_04);
	}

	if(self.var_178B != self.var_6881)
	{
		setmatchdata("rounds",param_00,"player_rounds",var_01,"died",1);
	}

	var_06 = getmatchdata("rounds",param_00,"startTime");
	var_07 = getmatchdata("rounds",param_00,"endTime");
	var_08 = var_07 - var_06;
	var_09 = self.var_6882 - self.var_32D1;
	setmatchdata("rounds",param_00,"player_rounds",var_01,"times_downed",maps\mp\_utility::func_2314(var_09));
	var_0A = var_08;
	var_0B = getmatchdata("rounds",param_00,"player_rounds",var_01,"died");
	if(var_0B)
	{
		var_0C = gettime();
		if(var_09 > 0 && func_577E(self))
		{
			self.var_32CD = self.var_32CD + int(var_0C - self.var_5BF3 / 1000);
		}
		else
		{
			self.var_32CD = self.var_32CD + int(var_0C - self.var_2AB8 / 1000);
		}

		self.var_99F8 = self.var_99F8 + self.var_32CD;
	}

	var_0A = var_0A - self.var_99F8;
	setmatchdata("rounds",param_00,"player_rounds",var_01,"time_alive_total",maps\mp\_utility::func_2315(var_0A));
	setmatchdata("rounds",param_00,"player_rounds",var_01,"windows_boarded",maps\mp\_utility::func_2314(self.var_7F11));
	setmatchdata("rounds",param_00,"player_rounds",var_01,"grenade_kills",maps\mp\_utility::func_2314(self.var_4868 - self.var_7F06));
	setmatchdata("rounds",param_00,"player_rounds",var_01,"ammo_purchased",maps\mp\_utility::func_2314(self.var_7EFE));
	setmatchdata("rounds",param_00,"player_rounds",var_01,"melee_kills",maps\mp\_utility::func_2314(self.var_7F09));
	setmatchdata("rounds",param_00,"player_rounds",var_01,"wallbuy_weapons_purchased",maps\mp\_utility::func_2314(self.var_7F10));
	setmatchdata("rounds",param_00,"player_rounds",var_01,"insta_kill_counter",maps\mp\_utility::func_2314(self.var_7F07));
	setmatchdata("rounds",param_00,"player_rounds",var_01,"double_points_counter",maps\mp\_utility::func_2314(self.var_7F04));
	setmatchdata("rounds",param_00,"player_rounds",var_01,"nuke_counter",maps\mp\_utility::func_2314(self.var_7F0B));
	setmatchdata("rounds",param_00,"player_rounds",var_01,"overcharge_counter",maps\mp\_utility::func_2314(self.var_7F0D));
	setmatchdata("rounds",param_00,"player_rounds",var_01,"max_ammo_counter",maps\mp\_utility::func_2314(self.var_7F08));
	setmatchdata("rounds",param_00,"player_rounds",var_01,"distance_travelled",int(self.var_3036 - self.var_3037));
	setmatchdata("rounds",param_00,"player_rounds",var_01,"distance_sprinted",int(self.var_3034 - self.var_3035));
	setmatchdata("rounds",param_00,"player_rounds",var_01,"total_shots",int(self.var_8B3D - self.var_8B39));
	setmatchdata("rounds",param_00,"player_rounds",var_01,"hits",int(self.var_8B33 - self.var_4DE1));
	setmatchdata("rounds",param_00,"player_rounds",var_01,"misses",int(self.var_8B3D - self.var_8B39 - self.var_8B33 - self.var_4DE1));
	if(!common_scripts\utility::func_562E(level.door_data_out_of_date))
	{
		setmatchdata("rounds",param_00,"player_rounds",var_01,"ending_zone",getplayerddlzonename());
	}

	setmatchdata("rounds",param_00,"player_rounds",var_01,"sacrifices",maps\mp\_utility::func_2314(self.var_801C - self.var_801D));
	setmatchdata("rounds",param_00,"player_rounds",var_01,"failed_sacrifices",maps\mp\_utility::func_2314(self.var_39E5 - self.var_39E6));
	setmatchdata("rounds",param_00,"player_rounds",var_01,"failed_assists",maps\mp\_utility::func_2314(self.var_39E3 - self.var_39E4));
	setmatchdata("rounds",param_00,"player_rounds",var_01,"explosive_kills",maps\mp\_utility::func_2315(self.var_394C - self.var_3963));
}

//Function Number: 195
func_5292(param_00)
{
	if(param_00 < 0 || param_00 >= 75)
	{
		return;
	}

	self.var_7F1D = 0;
	self.var_7F1E = 0;
	self.var_99F8 = 0;
	self.var_32CD = 0;
	self.var_5BF3 = 0;
	self.var_5A52 = self.var_E3;
	self.var_4BF8 = self.var_4BF7;
	self.var_3963 = self.var_394C;
	self.var_178B = self.var_6881;
	self.var_32D1 = self.var_6882;
	self.var_5F7D = self.var_5F7C;
	self.var_6F60 = self.var_6F5F;
	self.var_3296 = self.var_3295;
	self.var_5F7D = self.var_5F7C;
	self.var_90CD = self.var_90CC;
	self.var_7E60 = self.var_21;
	self.var_598D = self.var_598C;
	self.var_6E49 = self.var_6E48;
	self.var_3037 = self.var_3036;
	self.var_3035 = self.var_3034;
	self.var_4DE1 = self.var_8B33;
	self.var_8B39 = self.var_8B3D;
	self.var_801D = self.var_801C;
	self.var_39E6 = self.var_39E5;
	self.var_39E4 = self.var_39E3;
	level.var_745F = level.var_744A.size;
	self.var_7F11 = 0;
	self.var_7F06 = self.var_4868;
	self.var_7EFE = 0;
	self.var_7F09 = 0;
	self.var_7F10 = 0;
	self.var_7F07 = 0;
	self.var_7F04 = 0;
	self.var_7F0B = 0;
	self.var_7F0D = 0;
	self.var_7F08 = 0;
	var_01 = "mp/zombieTypeTable.csv";
	var_02 = function_027A(var_01);
	if(var_02 > 24)
	{
	}

	for(var_03 = 0;var_03 < var_02;var_03++)
	{
		var_04 = tablelookupbyrow(var_01,var_03,1);
		self.var_AC5D[var_04] = 0;
	}
}

//Function Number: 196
func_7B34(param_00)
{
	if(param_00 < 0 || param_00 >= 75)
	{
		return;
	}

	var_01 = maps\mp\_utility::func_2315(maps\mp\_utility::func_467B());
	setmatchdata("rounds",param_00,"startTime",var_01);
	foreach(var_03 in level.var_744A)
	{
		var_03 func_7B37(param_00);
	}

	level.var_7F25 = [];
	level.var_7F21 = [];
}

//Function Number: 197
func_7B33(param_00)
{
	foreach(var_02 in level.var_744A)
	{
		if(common_scripts\utility::func_562E(var_02.var_596A))
		{
			var_03 = param_00 + 1;
			switch(var_03)
			{
				case 10:
					var_02.besttimetrialtimes[0] = int(gettime() / 1000);
					break;

				case 25:
					var_02.besttimetrialtimes[1] = int(gettime() / 1000);
					break;

				case 50:
					var_02.besttimetrialtimes[2] = int(gettime() / 1000);
					break;

				case 100:
					var_02.besttimetrialtimes[3] = int(gettime() / 1000);
					break;
			}
		}
	}

	if(param_00 < 0 || param_00 >= 75)
	{
		return;
	}

	var_05 = maps\mp\_utility::func_2315(maps\mp\_utility::func_467B());
	setmatchdata("rounds",param_00,"endTime",var_05);
	var_06 = getmatchdata("rounds",param_00,"startTime");
	setmatchdata("rounds",param_00,"duration",maps\mp\_utility::func_2315(var_05 - var_06));
	setmatchdata("rounds",param_00,"round_players_total",maps\mp\_utility::func_2314(level.var_745F));
	foreach(var_09, var_08 in self.var_AC60)
	{
		setmatchdata("rounds",param_00,"zombies_spawned",var_09,var_08);
	}

	func_7D79();
	foreach(var_0B in level.var_7F21)
	{
		if(var_0B >= 0 && var_0B < 24)
		{
			setmatchdata("rounds",param_00,"powerStationActivated",var_0B,1);
		}
	}

	var_0D = 0;
	foreach(var_0F in level.var_7F25)
	{
		var_10 = 1;
		foreach(var_12 in level.var_275F["airdrop_assault"])
		{
			if(var_12.var_1B9 == var_0F)
			{
				setmatchdata("rounds",param_00,"supplyDrops",var_0D,maps\mp\_utility::func_2314(var_10));
				var_0D++;
				break;
			}

			var_10++;
		}

		if(var_0D >= 2)
		{
			break;
		}
	}

	foreach(var_02 in level.var_744A)
	{
		var_02 func_7B36(param_00);
		var_02 func_5292(param_00);
	}
}

//Function Number: 198
writezombieendgameplayerstats(param_00)
{
	var_01 = 0;
	if(isdefined(param_00.var_AB46["pendingXP"]) && param_00.var_AB46["pendingXP"] > 0)
	{
		var_01 = param_00.var_AB46["pendingXP"];
		param_00.var_AB46["pendingXP"] = 0;
	}

	if(var_01 > 0)
	{
		param_00 maps\mp\zombies\_zombies_rank::zombieupdateplayerxp(var_01,1);
	}

	param_00 maps\mp\zombies\_zombies_rank::zombiewritestats();
	func_8A6C(param_00,"totalGames",1,1);
	param_00 lib_0561::func_AABA();
	if(isdefined(level.var_AC2E) && level.var_AC2E != 0)
	{
		func_A19C(param_00);
	}
	else
	{
	}

	param_00 setrankedplayerdata(common_scripts\utility::func_46A8(),"zmShatteredRecord","prevMapEndTime",function_003E());
	if(isdefined(level.unlockzmshatteredmap))
	{
		param_00 [[ level.unlockzmshatteredmap ]]();
	}
}

//Function Number: 199
func_A19C(param_00)
{
	updatezombieleaderboardgameplaystatsformap(param_00,0);
	updatezombieleaderboardgameplaystatsformap(param_00,level.var_AC2E);
	if(common_scripts\utility::func_562E(param_00.var_596A))
	{
		func_A19D(param_00,level.var_AC2E,0);
		func_A19D(param_00,level.var_AC2E,level.var_744A.size);
	}
}

//Function Number: 200
updatezombieleaderboardgameplaystatsformap(param_00,param_01)
{
	inczombieleaderboardgameplaystat(param_00,param_01,"totalRounds",level.var_A980);
	inczombieleaderboardgameplaystat(param_00,param_01,"timePlayed",param_00.var_9A06["total"]);
	inczombieleaderboardgameplaystat(param_00,param_01,"gamesPlayed",1);
	inczombieleaderboardgameplaystat(param_00,param_01,"kills",param_00.var_E3);
	inczombieleaderboardgameplaystat(param_00,param_01,"headshots",param_00.var_90);
	inczombieleaderboardgameplaystat(param_00,param_01,"revives",param_00.var_21);
	inczombieleaderboardgameplaystat(param_00,param_01,"moneyEarned",param_00.var_62D7);
	inczombieleaderboardgameplaystat(param_00,param_01,"zombiePointsEarned",param_00.zombiepointsearned);
	inczombieleaderboardgameplaystat(param_00,param_01,"downs",param_00.var_6882);
	inczombieleaderboardgameplaystat(param_00,param_01,"shots",param_00.var_8B3D);
	inczombieleaderboardgameplaystat(param_00,param_01,"hits",param_00.var_8B33);
	inczombieleaderboardgameplaystat(param_00,param_01,"distanceTraveled",int(param_00.var_3036 * 0.00158));
	inczombieleaderboardgameplaystat(param_00,param_01,"doorsOpened",param_00.var_3295);
	inczombieleaderboardgameplaystat(param_00,param_01,"blitzUsed",param_00.var_6F5F);
	inczombieleaderboardgameplaystat(param_00,param_01,"explosiveKills",param_00.equipmentkills);
	inczombieleaderboardgameplaystat(param_00,param_01,"explosivesUsed",param_00.equipmentused);
}

//Function Number: 201
func_A19D(param_00,param_01,param_02)
{
	setbestroundzombieleaderboardstats(param_00,param_01,param_02);
	if(isdefined(param_00.besttimetrialtimes[0]))
	{
		var_03 = param_00 getrankedplayerdata(common_scripts\utility::func_46A8(),"leaderboardData",param_01,"leaderboardDataPerPlayerCount",param_02,"bestTimeTrialTimes",0);
		if(!isdefined(var_03) || isdefined(var_03) && param_00.besttimetrialtimes[0] < var_03 || var_03 == 0)
		{
			param_00 setrankedplayerdata(common_scripts\utility::func_46A8(),"leaderboardData",param_01,"leaderboardDataPerPlayerCount",param_02,"bestTimeTrialTimes",0,param_00.besttimetrialtimes[0]);
		}
	}

	if(isdefined(param_00.besttimetrialtimes[1]))
	{
		var_03 = param_00 getrankedplayerdata(common_scripts\utility::func_46A8(),"leaderboardData",param_01,"leaderboardDataPerPlayerCount",param_02,"bestTimeTrialTimes",1);
		if(!isdefined(var_03) || isdefined(var_03) && param_00.besttimetrialtimes[1] < var_03 || var_03 == 0)
		{
			param_00 setrankedplayerdata(common_scripts\utility::func_46A8(),"leaderboardData",param_01,"leaderboardDataPerPlayerCount",param_02,"bestTimeTrialTimes",1,param_00.besttimetrialtimes[1]);
		}
	}

	if(isdefined(param_00.besttimetrialtimes[2]))
	{
		var_03 = param_00 getrankedplayerdata(common_scripts\utility::func_46A8(),"leaderboardData",param_01,"leaderboardDataPerPlayerCount",param_02,"bestTimeTrialTimes",2);
		if(!isdefined(var_03) || isdefined(var_03) && param_00.besttimetrialtimes[2] < var_03 || var_03 == 0)
		{
			param_00 setrankedplayerdata(common_scripts\utility::func_46A8(),"leaderboardData",param_01,"leaderboardDataPerPlayerCount",param_02,"bestTimeTrialTimes",2,param_00.besttimetrialtimes[2]);
		}
	}

	if(isdefined(param_00.besttimetrialtimes[3]))
	{
		var_03 = param_00 getrankedplayerdata(common_scripts\utility::func_46A8(),"leaderboardData",param_01,"leaderboardDataPerPlayerCount",param_02,"bestTimeTrialTimes",3);
		if(!isdefined(var_03) || isdefined(var_03) && param_00.besttimetrialtimes[3] < var_03 || var_03 == 0)
		{
			param_00 setrankedplayerdata(common_scripts\utility::func_46A8(),"leaderboardData",param_01,"leaderboardDataPerPlayerCount",param_02,"bestTimeTrialTimes",3,param_00.besttimetrialtimes[3]);
		}
	}

	if(isdefined(param_00.besttimetrialtimes[4]))
	{
		var_03 = param_00 getrankedplayerdata(common_scripts\utility::func_46A8(),"leaderboardData",param_01,"leaderboardDataPerPlayerCount",param_02,"bestTimeTrialTimes",4);
		if(!isdefined(var_03) || isdefined(var_03) && param_00.besttimetrialtimes[4] < var_03 || var_03 == 0)
		{
			param_00 setrankedplayerdata(common_scripts\utility::func_46A8(),"leaderboardData",param_01,"leaderboardDataPerPlayerCount",param_02,"bestTimeTrialTimes",4,param_00.besttimetrialtimes[4]);
		}
	}
}

//Function Number: 202
inczombieleaderboardperplayerstat(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = param_00 getrankedplayerdata(common_scripts\utility::func_46A8(),"leaderboardData",param_01,"leaderboardDataPerPlayerCount",param_02,param_03);
	param_00 setrankedplayerdata(common_scripts\utility::func_46A8(),"leaderboardData",param_01,"leaderboardDataPerPlayerCount",param_02,param_03,var_05 + param_04);
}

//Function Number: 203
inczombieleaderboardgameplaystat(param_00,param_01,param_02,param_03)
{
	var_04 = param_00 getrankedplayerdata(common_scripts\utility::func_46A8(),"leaderboardData",param_01,"leaderboardDataGameplayStats",param_02);
	param_00 setrankedplayerdata(common_scripts\utility::func_46A8(),"leaderboardData",param_01,"leaderboardDataGameplayStats",param_02,var_04 + param_03);
}

//Function Number: 204
setbestroundzombieleaderboardstats(param_00,param_01,param_02)
{
	var_03 = param_00 getrankedplayerdata(common_scripts\utility::func_46A8(),"leaderboardData",param_01,"leaderboardDataPerPlayerCount",param_02,"bestRoundStats","round");
	if(level.var_A980 > var_03)
	{
		param_00 setrankedplayerdata(common_scripts\utility::func_46A8(),"leaderboardData",param_01,"leaderboardDataPerPlayerCount",param_02,"bestRoundStats","round",level.var_A980);
		param_00 setrankedplayerdata(common_scripts\utility::func_46A8(),"leaderboardData",param_01,"leaderboardDataPerPlayerCount",param_02,"bestRoundStats","kills",param_00.var_E3);
		param_00 setrankedplayerdata(common_scripts\utility::func_46A8(),"leaderboardData",param_01,"leaderboardDataPerPlayerCount",param_02,"bestRoundStats","revives",param_00.var_21);
		param_00 setrankedplayerdata(common_scripts\utility::func_46A8(),"leaderboardData",param_01,"leaderboardDataPerPlayerCount",param_02,"bestRoundStats","downs",param_00.var_6882);
	}
}

//Function Number: 205
func_4745(param_00,param_01)
{
	if(!isdefined(param_01) || !isplayer(param_00))
	{
		return;
	}

	var_02 = param_00 getrankedplayerdata(common_scripts\utility::func_46A8(),param_01);
	if(!isdefined(var_02))
	{
		var_02 = 0;
	}

	return var_02;
}

//Function Number: 206
func_8A6C(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_02))
	{
		return;
	}

	if(!isdefined(param_03))
	{
		param_03 = 0;
	}

	switch(param_03)
	{
		case 0:
			param_00 setrankedplayerdata(common_scripts\utility::func_46A8(),param_01,param_02);
			break;

		case 1:
			var_04 = param_00 getrankedplayerdata(common_scripts\utility::func_46A8(),param_01);
			var_05 = var_04 + param_02;
			param_00 setrankedplayerdata(common_scripts\utility::func_46A8(),param_01,var_05);
			break;

		case 2:
			var_04 = param_00 getrankedplayerdata(common_scripts\utility::func_46A8(),param_01);
			if(param_02 > var_04)
			{
				param_00 setrankedplayerdata(common_scripts\utility::func_46A8(),param_01,param_02);
			}
			break;
	}
}

//Function Number: 207
func_7D79()
{
	var_00 = "mp/zombieTypeTable.csv";
	var_01 = function_027A(var_00);
	if(var_01 > 24)
	{
	}

	for(var_02 = 0;var_02 < var_01;var_02++)
	{
		var_03 = tablelookupbyrow(var_00,var_02,1);
		self.var_AC60[var_03] = 0;
	}
}

//Function Number: 208
markmapcompleteforleaderboards()
{
	foreach(var_01 in level.var_744A)
	{
		if(common_scripts\utility::func_562E(var_01.var_596A))
		{
			var_01.besttimetrialtimes[4] = int(gettime() / 1000);
		}
	}
}

//Function Number: 209
func_86C8(param_00)
{
	self.var_60F0 = param_00;
	self.var_60F1 = squared(param_00);
}

//Function Number: 210
func_86C7(param_00)
{
	self.var_60EF = param_00;
	self.var_60F2 = param_00 * param_00;
}

//Function Number: 211
func_73EA()
{
	return self.var_12C["em1Ammo"].var_D95;
}

//Function Number: 212
func_743F(param_00)
{
	self.var_12C["em1Ammo"].var_D95 = param_00;
}

//Function Number: 213
func_73F7()
{
	return isdefined(self.var_12C["em1Ammo"]);
}

//Function Number: 214
func_73C6()
{
	self.var_12C["em1Ammo"] = undefined;
}

//Function Number: 215
func_208E(param_00)
{
	if(!isdefined(param_00.var_942B))
	{
		param_00.var_942B = param_00 maps\mp\gametypes\_hud_util::func_27ED("hudbig",0.75);
		param_00.var_942B maps\mp\gametypes\_hud_util::func_8707("BOTTOM",undefined,0,-120);
		param_00.var_942B settext("");
	}

	if(!isdefined(param_00.var_9423))
	{
		param_00.var_9423 = param_00 maps\mp\gametypes\_hud_util::func_27ED("hudbig",0.75);
		param_00.var_9423 maps\mp\gametypes\_hud_util::func_8707("BOTTOM",undefined,0,-95);
		param_00.var_9423 settext("");
	}
}

//Function Number: 216
func_A795()
{
	self endon("death");
	thread func_A951();
	thread func_A952();
	self waittill("used",var_00,var_01);
	return [var_00,var_01];
}

//Function Number: 217
func_A951()
{
	self endon("used");
	self endon("death");
	self waittill("trigger",var_00);
	self notify("used",var_00,"trigger");
}

//Function Number: 218
func_A952()
{
	self endon("used");
	self endon("death");
	if(!level.var_9A87)
	{
		return;
	}

	foreach(var_01 in level.var_744A)
	{
		thread func_A953(var_01);
	}

	for(;;)
	{
		level waittill("connected",var_01);
		thread func_A953(var_01);
	}
}

//Function Number: 219
func_A953(param_00)
{
	func_A954(param_00);
	if(isdefined(param_00))
	{
		param_00 func_2413();
	}
}

//Function Number: 220
func_A954(param_00)
{
	self endon("used");
	self endon("death");
	param_00 endon("disconnect");
	var_01 = undefined;
	for(;;)
	{
		if(common_scripts\utility::func_562E(param_00.var_9A83) && common_scripts\utility::func_562E(self.var_9A88) && func_5784(param_00,self) && param_00 maps/mp/gametypes/zombies::func_4B9D(self.var_9A84))
		{
			if(!isdefined(var_01))
			{
				var_01 = gettime() + param_00 maps/mp/gametypes/zombies::func_46E8();
				param_00 func_874C();
			}

			if(gettime() >= var_01)
			{
				param_00.var_9A83 = 0;
				self notify("used",param_00,"token");
			}
		}
		else if(isdefined(var_01))
		{
			var_01 = undefined;
			param_00 func_2413();
		}

		wait 0.05;
	}
}

//Function Number: 221
func_2413()
{
	self setclientomnvar("ui_use_bar_start_time",0);
	self setclientomnvar("ui_use_bar_end_time",0);
	self setclientomnvar("ui_use_bar_text",0);
}

//Function Number: 222
func_874C()
{
	self setclientomnvar("ui_use_bar_start_time",gettime());
	var_00 = gettime() + maps/mp/gametypes/zombies::func_46E8();
	self setclientomnvar("ui_use_bar_end_time",var_00);
	self setclientomnvar("ui_use_bar_text",5);
}

//Function Number: 223
func_874A(param_00)
{
	self.var_9A84 = param_00;
}

//Function Number: 224
func_9A85(param_00)
{
	self.var_9A88 = 0;
	self settertiaryhintstring("");
}

//Function Number: 225
func_3665()
{
	level.var_9A87 = getdvarint("5022",0);
}

//Function Number: 226
func_5784(param_00,param_01)
{
	var_02 = param_00 method_84D1(1);
	return isdefined(var_02) && var_02 == param_01;
}

//Function Number: 227
func_34A6(param_00,param_01,param_02)
{
	if(!isdefined(param_01))
	{
		param_01 = 18;
	}

	if(!isdefined(param_02))
	{
		param_02 = param_01;
	}

	var_03 = param_00 + (0,0,param_02);
	var_04 = param_00 + (0,0,param_01 * -1);
	var_05 = self method_83EB(var_03,var_04,self.var_14F,self.var_BD,1);
	if(abs(var_05[2] - var_03[2]) < 0.1)
	{
		return undefined;
	}

	if(abs(var_05[2] - var_04[2]) < 0.1)
	{
		return undefined;
	}

	return var_05;
}

//Function Number: 228
func_1F5B(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_02))
	{
		param_02 = 6;
	}

	if(!isdefined(param_03))
	{
		param_03 = self.var_14F;
	}

	var_04 = (0,0,1) * param_02;
	var_05 = param_00 + var_04;
	var_06 = param_01 + var_04;
	return self method_83EC(var_05,var_06,param_03,self.var_BD - param_02,1);
}

//Function Number: 229
func_6719(param_00)
{
	return !isdefined(param_00.var_AC66);
}

//Function Number: 230
func_0F52(param_00,param_01,param_02)
{
	return param_00[0] * param_01[1] - param_00[1] * param_01[0] + param_01[0] * param_02[1] - param_02[0] * param_01[1] + param_02[0] * param_00[1] - param_00[0] * param_02[1];
}

//Function Number: 231
func_0F53(param_00,param_01,param_02)
{
	return func_0F52(param_00,param_01,param_02) * 0.5;
}

//Function Number: 232
func_5F36(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_03))
	{
		param_03 = 0;
	}

	var_04 = func_0F52(param_01,param_02,param_00);
	if(var_04 > param_03)
	{
		return 1;
	}

	if(var_04 < param_03 * -1)
	{
		return 2;
	}

	return 3;
}

//Function Number: 233
func_776A(param_00,param_01)
{
	var_02 = vectordot(param_00,param_01) / lengthsquared(param_01);
	return [param_01 * var_02,var_02];
}

//Function Number: 234
func_7770(param_00,param_01,param_02)
{
	param_00 = param_00 - param_01;
	var_03 = func_776A(param_00,param_02 - param_01);
	param_00 = var_03[0];
	var_04 = var_03[1];
	param_00 = param_00 + param_01;
	return [param_00,var_04];
}

//Function Number: 235
func_7771(param_00,param_01,param_02)
{
	var_03 = func_7770(param_00,param_01,param_02);
	param_00 = var_03[0];
	var_04 = var_03[1];
	if(var_04 < 0)
	{
		param_00 = param_01;
	}
	else if(var_04 > 1)
	{
		param_00 = param_02;
	}

	return [param_00,var_04];
}

//Function Number: 236
func_3048(param_00,param_01,param_02)
{
	var_03 = func_7770(param_00,param_01,param_02);
	var_04 = var_03[0];
	var_05 = var_03[1];
	return distance(var_04,param_00);
}

//Function Number: 237
func_2DA3()
{
	self hudoutlinedisable();
	maps/mp/agents/_agent_utility::func_2A73();
	self notify("killanimscript");
	self notify("death");
	self waittill("disconnect");
	self method_8491();
}

//Function Number: 238
func_5844(param_00)
{
	return func_5836(param_00) || func_583A(param_00);
}

//Function Number: 239
isvalidequipmentzombies(param_00)
{
	var_01 = 0;
	switch(param_00)
	{
		case "jack_in_box_decoy_zm":
			var_01 = 1;
			break;
	}

	if(common_scripts\utility::func_562E(level.zombietacticalweapon[param_00]) || common_scripts\utility::func_562E(level.zombielethalweapon[param_00]))
	{
		var_01 = 1;
	}

	return var_01;
}

//Function Number: 240
func_5836(param_00)
{
	var_01 = func_AAF9(param_00,1,0);
	switch(var_01)
	{
		case "m712_pap_zm":
		case "ppsh41_classic_pap_zm":
		case "ppsh41_classic_zm":
		case "ppsh41_pap_zm":
		case "ppsh41_zm":
		case "greasegun_pap_zm":
		case "greasegun_zm":
		case "model21_pap_zm":
		case "springfield_pap_zm":
		case "springfield_zm":
		case "leeenfield_pap_zm":
		case "leeenfield_zm":
		case "bren_pap_zm":
		case "bren_zm":
		case "bar_pap_zm":
		case "bar_zm":
		case "svt40_pap_zm":
		case "svt40_zm":
		case "m1a1_pap_zm":
		case "winchester1897_pap_zm":
		case "winchester1897_zm":
		case "m1garand_pap_zm":
		case "m1garand_zm":
		case "type100_pap_zm":
		case "type100_zm":
		case "thompson_pap_zm":
		case "thompson_zm":
		case "karabin_pap_zm":
		case "karabin_zm":
		case "kar98_pap_zm":
		case "mp28_pap_zm":
		case "mp28_zm":
		case "mp40_pap_zm":
		case "mp40_zm":
		case "walther_pap_zm":
		case "walther_zm":
		case "m30_pap_zm":
		case "stg44_pap_zm":
		case "stg44_zm":
		case "m1941_pap_zm":
		case "m1941_zm":
		case "luger_auto_zm":
		case "luger_pap_zm":
		case "mg42_pap_zm":
		case "mg42_zm":
		case "mg15_pap_zm":
		case "mg15_zm":
		case "fg42_pap_zm":
		case "fg42_zm":
		case "lewis_pap_zm":
		case "lewis_zm":
		case "m1911_pap_zm":
		case "teslagun_pap_zm":
		case "teslagun_zm_death":
		case "teslagun_zm_moon":
		case "teslagun_zm_storm":
		case "teslagun_zm_blood":
		case "fliegerfaust_pap_zm":
		case "fliegerfaust_zm":
		case "type99_pap_zm":
		case "type99_zm":
		case "sentryhead_zm":
		case "flamethrower_zm":
		case "panzerschreck_zm":
		case "bazooka_zm":
		case "m30_zm":
		case "model21_zm":
		case "kar98_zm":
		case "m1a1_zm":
		case "m712_zm":
		case "luger_zm":
		case "m1911_zm":
		case "teslagun_zm":
			return 1;

		case "breda30_pap_zm":
		case "breda30_zm":
		case "sten_pap_zm":
		case "sten_zm":
		case "g43_pap_zm":
		case "g43_zm":
			return maps\mp\_utility::isproductionlevelactive(6);

		case "p38_pap_zm":
		case "beretta_pap_zm":
		case "beretta_zm":
		case "volk_pap_zm":
		case "volk_zm":
		case "p38_zm":
			return maps\mp\_utility::isproductionlevelactive(7);

		case "razergun_pap_zm":
		case "razergun_zm":
		case "razergun_melee_zm":
			return maps\mp\_utility::isproductionlevelactive(8);

		case "enfieldno2_pap_zm":
		case "reich_pap_zm":
		case "enfieldno2_zm":
		case "reich_zm":
			return maps\mp\_utility::isproductionlevelactive(9);

		case "mg81_pap_zm":
		case "mg81_zm":
		case "mas38_pap_zm":
		case "mas38_zm":
			return maps\mp\_utility::isproductionlevelactive(10);

		case "arisaka_pap_zm":
		case "arisaka_zm":
		case "m2carbine_pap_zm":
		case "m2carbine_zm":
		case "m1935_pap_zm":
		case "m1935_zm":
		case "sterling_pap_zm":
		case "sterling_zm":
		case "type5_pap_zm":
		case "type5_zm":
			return getdvarint("mtx4_killswitch",1) == 0;

		case "ptrs41_pap_zm":
		case "ptrs41_zm":
		case "blunderbuss_pap_zm":
		case "blunderbuss_zm":
		case "nambu_pap_zm":
		case "nambu_zm":
		case "m1919_pap_zm":
		case "m1919_zm":
		case "leveraction_pap_zm":
		case "leveraction_zm":
			return getdvarint("mtx5_killswitch",1) == 0;

		case "zk383_pap_zm":
		case "zk383_zm":
			return getdvarint("dlc3_killswitch",1) == 0;

		case "avs36_pap_zm":
		case "avs36_zm":
		case "delisle_pap_zm":
		case "delisle_zm":
			return getdvarint("mtx6_killswitch",1) == 0;

		case "ribeyrolles_pap_zm":
		case "ribeyrolles_zm":
		case "mosin_pap_zm":
		case "mosin_zm":
		case "federov_pap_zm":
		case "federov_zm":
			return getdvarint("mtx7_killswitch",1) == 0;

		case "sudaev_pap_zm":
		case "sudaev_zm":
		case "vmg1927_pap_zm":
		case "vmg1927_zm":
		case "tokyo_pap_zm":
		case "tokyo_zm":
			return getdvarint("mtx8_killswitch",1) == 0;

		case "raven_gun_pap_zm":
		case "raven_gun_zm":
		case "mg42_vintage_pap_zm":
		case "mg42_vintage_zm":
			return getdvarint("dlc4_killswitch",1) == 0;

		case "dp28_pap_zm":
		case "dp28_zm":
		case "emp44_pap_zm":
		case "emp44_zm":
		case "charlton_pap_zm":
		case "charlton_zm":
		case "sdk_pap_zm":
		case "sdk_zm":
			return getdvarint("mtx9_killswitch",1) == 0;

		case "lad_pap_zm":
		case "lad_zm":
		case "kgm21_pap_zm":
		case "kgm21_zm":
		case "erma_pap_zm":
		case "erma_zm":
		case "blyskawica_pap_zm":
		case "blyskawica_zm":
		case "wz35_pap_zm":
		case "wz35_zm":
			return getdvarint("mtx10_killswitch",1) == 0;

		case "chatelleroult_pap_zm":
		case "chatelleroult_zm":
		case "m2hyde_pap_zm":
		case "m2hyde_zm":
		case "austen_pap_zm":
		case "austen_zm":
		case "wimmer_pap_zm":
		case "wimmer_zm":
		case "mas36_pap_zm":
		case "mas36_zm":
			return getdvarint("mtx11_killswitch",1) == 0;

		case "bechowiec_pap_zm":
		case "bechowiec_zm":
		case "grofuss_pap_zm":
		case "grofuss_zm":
			return getdvarint("mtx12_killswitch",1) == 0;
	}

	if(isdefined(level.zombieprimaryweapon[param_00]))
	{
		return 1;
	}

	return 0;
}

//Function Number: 241
func_583A(param_00)
{
	switch(param_00)
	{
		case "combatknife_zm":
		case "shovel_zm":
		case "raven_sword_zm":
			return 1;

		case "razergun_zm":
		case "razergun_melee_zm":
			return maps\mp\_utility::isproductionlevelactive(8);

		case "zom_dlc2_1_zm":
		case "zom_dlc2_2_zm":
		case "zom_dlc2_3_zm":
		case "zom_dlc2_4_zm":
			return maps\mp\_utility::isproductionlevelactive(12);

		case "zom_dlc4_scythe_emp_zm":
		case "zom_dlc4_scythe_zm":
		case "zom_dlc4_shield_emp_zm":
		case "zom_dlc4_shield_zm":
		case "zom_dlc4_spike_emp_zm":
		case "zom_dlc4_spike_zm":
		case "zom_dlc4_hammer_emp_zm":
		case "zom_dlc4_hammer_zm":
			return getdvarint("dlc4_killswitch",1) == 0;

		default:
			break;
	}

	if(common_scripts\utility::func_562E(level.zombiemeleeweapon[param_00]))
	{
		return 1;
	}

	return 0;
}

//Function Number: 242
func_5823(param_00)
{
	switch(param_00)
	{
		case "role_ability_mad_minute_zm":
		case "role_ability_taunt_zm":
		case "role_ability_camo_zm":
		case "role_ability_stunning_burst_zm":
			return 1;

		case "role_ability_melee_frenzy_zm":
			var_01 = 0;
			return var_01;

		default:
			return 0;
	}
}

//Function Number: 243
func_6F28(param_00)
{
	if(!isdefined(level.var_ABE3))
	{
		level.var_ABE3 = 0;
	}

	if(param_00)
	{
		level.var_ABE3++;
	}
	else
	{
		level.var_ABE3--;
	}
}

//Function Number: 244
func_53DC()
{
	return common_scripts\utility::func_562E(self.var_55AB) || common_scripts\utility::func_562E(self.zmdemigod);
}

//Function Number: 245
func_6720()
{
	return common_scripts\utility::func_562E(self.var_66EC);
}

//Function Number: 246
func_56CF()
{
	return common_scripts\utility::func_562E(self.var_5569);
}

//Function Number: 247
func_580A()
{
	return common_scripts\utility::func_562E(self.var_562B);
}

//Function Number: 248
func_44B7()
{
	var_00 = [];
	var_01 = maps/mp/agents/_agent_utility::func_43FD("all");
	foreach(var_03 in var_01)
	{
		if(!isalliedsentient(self,var_03))
		{
			var_00[var_00.size] = var_03;
		}
	}

	return var_00;
}

//Function Number: 249
func_4422(param_00)
{
	var_01 = [];
	foreach(var_03 in level.var_744A)
	{
		if(isalive(var_03))
		{
			var_04 = var_03 getnearestnode();
			if(isdefined(var_04))
			{
				var_01[var_01.size] = var_04;
			}
		}
	}

	var_06 = [];
	foreach(var_08 in param_00)
	{
		if(var_08.var_A4B == "zombie_melee_goliath" || issubstr(var_08.var_A4B,"ranged_elite_soldier"))
		{
			continue;
		}

		var_09 = 1;
		var_0A = var_08 getnearestnode();
		if(isdefined(var_0A))
		{
			foreach(var_04 in var_01)
			{
				if(function_01F4(var_0A,var_04,1))
				{
					var_09 = 0;
					break;
				}
			}
		}

		if(var_09)
		{
			var_06[var_06.size] = var_08;
		}
	}

	return var_06;
}

//Function Number: 250
func_A718(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	var_08 = spawnstruct();
	if(isdefined(param_00))
	{
		childthread func_A760(param_00,var_08);
	}

	if(isdefined(param_01))
	{
		childthread func_A760(param_01,var_08);
	}

	if(isdefined(param_02))
	{
		childthread func_A760(param_02,var_08);
	}

	if(isdefined(param_03))
	{
		childthread func_A760(param_03,var_08);
	}

	if(isdefined(param_04))
	{
		childthread func_A760(param_04,var_08);
	}

	if(isdefined(param_05))
	{
		childthread func_A760(param_05,var_08);
	}

	if(isdefined(param_06))
	{
		childthread func_A760(param_06,var_08);
	}

	if(isdefined(param_07))
	{
		childthread func_A760(param_07,var_08);
	}

	var_08 waittill("returned",var_09);
	var_08 notify("die");
	return var_09;
}

//Function Number: 251
func_A760(param_00,param_01)
{
	param_01 endon("die");
	self waittill(param_00,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09,var_0A,var_0B);
	var_0C = [];
	var_0C[0] = param_00;
	if(isdefined(var_02))
	{
		var_0C[1] = var_02;
	}

	if(isdefined(var_03))
	{
		var_0C[2] = var_03;
	}

	if(isdefined(var_04))
	{
		var_0C[3] = var_04;
	}

	if(isdefined(var_05))
	{
		var_0C[4] = var_05;
	}

	if(isdefined(var_06))
	{
		var_0C[5] = var_06;
	}

	if(isdefined(var_07))
	{
		var_0C[6] = var_07;
	}

	if(isdefined(var_08))
	{
		var_0C[7] = var_08;
	}

	if(isdefined(var_09))
	{
		var_0C[8] = var_09;
	}

	if(isdefined(var_0A))
	{
		var_0C[9] = var_0A;
	}

	if(isdefined(var_0B))
	{
		var_0C[10] = var_0B;
	}

	param_01 notify("returned",var_0C);
}

//Function Number: 252
func_089A(param_00)
{
	level endon("exploderID_" + param_00);
	if(isdefined(level.var_744A))
	{
		foreach(var_02 in level.var_744A)
		{
			common_scripts\_exploder::func_88E(param_00,var_02);
		}
	}

	for(;;)
	{
		level waittill("connected",var_02);
		common_scripts\_exploder::func_88E(param_00,var_02);
	}
}

//Function Number: 253
func_93DF(param_00)
{
	level notify("exploderID_" + param_00);
	stopclientexploder(param_00);
}

//Function Number: 254
func_4B24()
{
	return isdefined(self.var_A08E) && self.var_A08E.var_15CB.var_17E9;
}

//Function Number: 255
func_562C(param_00)
{
	return isdefined(param_00.var_15CB) && param_00.var_15CB.var_17E9;
}

//Function Number: 256
get_zombies_touching_sphere(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = [];
	if(!isdefined(param_04))
	{
		param_04 = func_408F();
	}

	foreach(var_08 in param_04)
	{
		var_09 = var_08.var_116;
		var_0A = var_08.var_8302 * 0.5;
		var_09 = var_09 + (0,0,var_0A);
		var_0B = param_00 - var_09;
		if(abs(var_0B[2]) > var_0A + param_01)
		{
			continue;
		}

		if(length2d(var_0B) > var_08.var_8303 + param_01)
		{
			continue;
		}

		if(var_08 method_81D7(param_00,param_03) == 0)
		{
			continue;
		}

		var_05[var_05.size] = var_08;
	}

	return var_05;
}

//Function Number: 257
func_43F0(param_00,param_01,param_02,param_03)
{
	var_04 = [];
	var_05 = func_408F();
	var_06 = param_02 * param_02;
	var_07 = param_01 * 0.5;
	var_08 = param_00 + (0,0,var_07);
	foreach(var_0A in var_05)
	{
		var_0B = var_0A.var_116;
		var_0C = 0;
		if(param_03)
		{
			var_0C = var_0A.var_8302 * 0.5;
			var_0B = var_0B + (0,0,var_0C);
		}

		if(abs(var_08[2] - var_0B[2]) > var_0C + var_07)
		{
			continue;
		}

		var_0D = var_06;
		if(param_03)
		{
			var_0D = pow(param_02 + var_0A.var_8303,2);
		}

		if(distance2dsquared(var_0A.var_116,param_00) > var_0D)
		{
			continue;
		}

		var_04[var_04.size] = var_0A;
	}

	return var_04;
}

//Function Number: 258
func_55C2(param_00)
{
	if(!isdefined(param_00.var_1B9))
	{
		return 0;
	}

	var_01 = param_00.var_1B9 == "Begin" || param_00.var_1B9 == "Begin 3D";
	return var_01;
}

//Function Number: 259
func_AC0E(param_00,param_01,param_02,param_03)
{
	while(!isdefined(level.var_87B))
	{
		wait 0.05;
	}

	var_04 = common_scripts\utility::func_46B7(param_00,param_01);
	var_05 = param_01 + ": " + param_00;
	foreach(var_07 in var_04)
	{
		func_AC0F(var_07,var_05,param_03);
	}
}

//Function Number: 260
func_AC0D(param_00,param_01,param_02)
{
	while(!isdefined(level.var_87B))
	{
		wait 0.05;
	}

	foreach(var_04 in param_00)
	{
		func_AC0F(var_04,param_01,param_02);
	}
}

//Function Number: 261
func_AC0F(param_00,param_01,param_02,param_03)
{
	var_04 = undefined;
	if(isdefined(param_00.var_8C95) || isdefined(param_00.var_165) && param_00.var_165 == "zombie_sky_spawner")
	{
		var_04 = lib_0540::func_A26F(param_00,undefined,param_01);
	}
	else if(isdefined(param_00.var_8109))
	{
		var_08 = param_00.var_8109;
		var_09 = maps/mp/agents/_scripted_agent_anim_util::func_4081(var_08,"zombie_generic",#animtree);
		var_04 = var_09.size > 0;
		var_0A = "";
		foreach(var_0C in var_09)
		{
			var_0D = maps/mp/agents/_scripted_agent_anim_util::func_446A(var_0C);
			var_0E = getmovedelta(var_0C,0,var_0D);
			var_0F = transformmove(param_00.var_116,param_00.var_1D,(0,0,0),(0,0,0),var_0E,(0,0,0))["origin"];
			if(!isdefined(var_0F))
			{
				var_0F = param_00.var_116;
			}

			var_10 = [];
			if(isdefined(param_02))
			{
				foreach(var_12 in param_02)
				{
					if(!animhasnotetrack(var_0C,var_12))
					{
						var_10 = common_scripts\utility::func_F6F(var_10,var_12);
					}
				}
			}

			if(var_10.size > 0)
			{
				var_04 = 0;
			}

			var_17 = param_00 lib_054D::func_ABFD(var_0F,getanimname(var_0C),param_03,"animated");
			if(!var_17)
			{
			}

			var_04 = var_04 & var_17;
		}
	}
	else
	{
		var_19 = "Bad Spawner";
		if(isdefined(param_01))
		{
			var_19 = var_19 + ": " + param_01;
		}

		var_04 = param_00 lib_054D::func_ABFD(param_00.var_116,var_19,param_03,"closet");
	}

	param_00.validitytestresult = var_04;
	return var_04;
}

//Function Number: 262
func_4282(param_00)
{
	var_01 = [];
	if(isdefined(param_00.var_8260))
	{
		var_02 = strtok(param_00.var_8260,",");
		foreach(var_04 in var_02)
		{
			var_05 = strtok(var_04," ");
			if(var_05.size > 0)
			{
				var_06 = var_05[0];
				if(var_05.size == 1)
				{
					var_01[var_06] = 1;
				}
				else if(var_05.size == 2)
				{
					var_01[var_06] = var_05[1];
				}
				else
				{
					var_07 = common_scripts\utility::func_F9A(var_05,0);
					var_01[var_06] = var_07;
				}
			}
		}
	}

	return var_01;
}

//Function Number: 263
func_5637(param_00)
{
	if(isdefined(param_00.var_3B) && param_00.var_3B == "script_model")
	{
		if(func_6724(param_00.var_1A5) || func_6724(param_00.var_165) || func_6724(param_00.var_164))
		{
			return 0;
		}

		if(!isdefined(param_00.var_106) || !common_scripts\utility::func_9467(param_00.var_106,"destp_"))
		{
			return 0;
		}

		return 1;
	}

	return 0;
}

//Function Number: 264
func_5638(param_00)
{
	if(isdefined(param_00.var_3B) && param_00.var_3B == "script_model" && param_00.var_3A == "script_model")
	{
		if(func_6724(param_00.var_1A5) || func_6724(param_00.var_165) || func_6724(param_00.var_164))
		{
			return 0;
		}

		return 1;
	}

	return 0;
}

//Function Number: 265
func_6724(param_00)
{
	return isdefined(param_00) && isstring(param_00) && param_00 != "";
}

//Function Number: 266
func_8FBA(param_00,param_01,param_02)
{
	if(!isdefined(param_00.var_1D))
	{
		param_00.var_1D = (0,0,0);
	}

	if(isdefined(param_02))
	{
		return spawnfxforclient(common_scripts\utility::func_44F5(param_01),param_00.var_116,param_02,anglestoforward(param_00.var_1D),anglestoup(param_00.var_1D));
	}

	return spawnfx(common_scripts\utility::func_44F5(param_01),param_00.var_116,anglestoforward(param_00.var_1D),anglestoup(param_00.var_1D));
}

//Function Number: 267
playfxclient_for_player(param_00,param_01,param_02)
{
	var_03 = spawnstruct();
	var_03.var_116 = param_01;
	var_04 = func_8FBA(var_03,param_00,param_02);
	triggerfx(var_04);
	param_02 maps\mp\gametypes\_playerlogic::deleteentonplayerdisconnect(var_04);
}

//Function Number: 268
playfxclient(param_00,param_01,param_02,param_03)
{
	var_04 = spawnstruct();
	var_04.var_116 = param_01;
	var_05 = func_8FBA(var_04,param_00,param_02);
	triggerfx(var_05);
	param_02 maps\mp\gametypes\_playerlogic::deleteentonplayerdisconnect(var_05);
	if(isdefined(param_03))
	{
		level thread delete_fx_in_time(var_05,param_03);
	}
}

//Function Number: 269
delete_fx_in_time(param_00,param_01)
{
	wait(param_01);
	if(isdefined(param_00))
	{
		param_00 delete();
	}
}

//Function Number: 270
func_1DB3(param_00,param_01,param_02)
{
	param_00 endon("death");
	param_00 setonfire(0,param_01,1,"none",1);
	if(isdefined(param_01))
	{
		param_00 func_AB18(param_01);
	}
}

//Function Number: 271
func_AC38(param_00,param_01,param_02,param_03,param_04,param_05)
{
	level endon("game_ended");
	param_00 endon("death");
	if(!isdefined(param_01) || param_01 <= 0)
	{
		return;
	}

	if(!isdefined(param_03) || param_03 < 0)
	{
		param_03 = 1;
	}

	wait(0.25);
	var_06 = 0;
	for(;;)
	{
		param_00 dodamage(param_01,param_00.var_116,param_02,undefined,undefined,param_05);
		wait(param_03);
		if(isdefined(param_04) && param_04 > 0)
		{
			var_06 = var_06 + param_03;
			if(var_06 > param_04)
			{
				break;
			}
		}
	}
}

//Function Number: 272
func_2436(param_00,param_01,param_02,param_03)
{
	return distance2d(param_00,param_01) <= param_02 && abs(param_00[2] - param_01[2]) <= param_03;
}

//Function Number: 273
func_3151()
{
	return isdefined(self.var_A022) && self.var_A022.size;
}

//Function Number: 274
func_7458(param_00,param_01)
{
	if(!isdefined(self.var_A022))
	{
		self.var_A022 = [];
	}

	if(common_scripts\utility::func_562E(self.var_A022[param_01]) == common_scripts\utility::func_562E(param_00))
	{
		return;
	}

	if(common_scripts\utility::func_562E(param_00))
	{
		self.var_A022[param_01] = 1;
	}
	else
	{
		self.var_A022[param_01] = undefined;
	}

	if(self.var_A022.size > 0)
	{
		self setclientomnvar("zm_unlimited_ammo",1);
		return;
	}

	self setclientomnvar("zm_unlimited_ammo",0);
}

//Function Number: 275
func_73EC()
{
	self endon("death");
	self endon("disconnect");
	var_00 = self getweaponslistprimaries();
	foreach(var_02 in var_00)
	{
		if(issubstr(var_02,"em1"))
		{
			waittillframeend;
			var_03 = func_73EA();
			if(var_03 == 0)
			{
				func_743F(1);
				self method_812B(1);
			}

			continue;
		}

		var_03 = self getweaponammoclip(var_02,"right");
		if(var_03 == 0)
		{
			self method_82FA(var_02,1,"right");
		}

		if(issubstr(var_02,"akimbo"))
		{
			var_03 = self getweaponammoclip(var_02,"left");
			if(var_03 == 0)
			{
				self method_82FA(var_02,1,"left");
			}
		}
	}
}

//Function Number: 276
func_5816(param_00)
{
	return !isdefined(param_00) || param_00 == "";
}

//Function Number: 277
func_580D()
{
	return !common_scripts\utility::func_562E(self.var_9D9F);
}

//Function Number: 278
func_A28D(param_00,param_01)
{
	if(isdefined(param_00))
	{
		self.var_9D65.var_2984 = param_00;
	}

	if(isdefined(param_01))
	{
		self.var_9D65.var_2985 = param_01;
	}
}

//Function Number: 279
func_A286()
{
	return "valve_note";
}

//Function Number: 280
func_A28C(param_00,param_01,param_02)
{
	self.var_A29A = param_00;
	self.var_A29F = param_01;
	self.var_A29C = param_02;
	if(!isdefined(param_00))
	{
		self scriptmodelclearanim();
		return;
	}

	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	if(!isdefined(param_02))
	{
		param_02 = 1;
	}

	var_03 = "";
	if(isdefined(self.var_6766) && common_scripts\utility::func_F79(self.var_6766,param_00))
	{
		var_03 = func_A286();
	}

	self scriptmodelclearanim();
	self scriptmodelplayanim(param_00,var_03,param_01,param_02);
}

//Function Number: 281
func_A298(param_00)
{
	for(;;)
	{
		self waittill(func_A286(),var_01);
		self thread [[ param_00 ]](var_01);
	}
}

//Function Number: 282
clear_progressive_interact(param_00)
{
	common_scripts\utility::knock_off_battery("valve_complete","valve_turning_off");
	param_00.radial_interact_active = undefined;
	param_00 luinotifyeventextraplayer(&"stop_progressive_interact",0);
	param_00 luinotifyeventextraplayer(&"remove_progressive_interact",0);
}

//Function Number: 283
valve_check_progressive_interact_input(param_00,param_01)
{
	self endon("valve_complete");
	self endon("valve_turning_off");
	var_02 = 0;
	var_03 = 0;
	var_04 = 1;
	for(;;)
	{
		var_04 = param_00 usebuttonpressed();
		if(!var_03)
		{
			if(var_04)
			{
				var_05 = 1 - self.var_A2A5 * self.var_A2A4;
				param_00 luinotifyeventextraplayer(&"start_progressive_interact",1,var_05 * 1000);
				var_03 = 1;
				var_02 = 1;
			}
		}
		else if(!var_04)
		{
			param_00 luinotifyeventextraplayer(&"stop_progressive_interact",0);
			var_03 = 0;
		}

		wait 0.05;
	}
}

//Function Number: 284
func_A299()
{
	if(!self.var_9D65 method_8562())
	{
		self.var_9D65 makeusable();
	}
	else
	{
		if(isdefined(level.var_744A))
		{
			foreach(var_01 in level.var_744A)
			{
				if(!self.var_9D65 method_8691(var_01))
				{
					self.var_9D65 enableplayeruse(var_01);
				}
			}
		}

		if(isdefined(self.var_9D65.var_2984))
		{
			self.var_9D65 sethintstring(self.var_9D65.var_2984);
		}
		else
		{
			self.var_9D65 sethintstring(&"ZOMBIES_TURN_VALVE");
		}
	}

	self.var_9D65 usetriggerrequirelookat(1);
	while(!isdefined(self.var_721C))
	{
		self.var_9D65 waittill("trigger",var_03);
		if(isplayer(var_03))
		{
			self.var_721C = var_03;
		}
	}

	self.var_9D65 usetriggerrequirelookat(0);
	if(isdefined(self.var_9D65.var_2985))
	{
		self.var_9D65 sethintstring(self.var_9D65.var_2985);
		return;
	}

	if(isdefined(level.var_744A))
	{
		foreach(var_01 in level.var_744A)
		{
			if(isdefined(self.var_721C) && var_01 == self.var_721C)
			{
				if(!isdefined(self.var_721C.radial_interact_active))
				{
					childthread valve_check_progressive_interact_input(self.var_721C,self.var_9D65);
					childthread clear_progressive_interact(self.var_721C);
					self.var_721C.radial_interact_active = 1;
				}

				continue;
			}

			self.var_9D65 disableplayeruse(var_01);
		}
	}
}

//Function Number: 285
func_A284(param_00)
{
	if(!isdefined(param_00))
	{
		return;
	}

	self thread [[ param_00 ]]();
}

//Function Number: 286
func_A288(param_00)
{
	self.var_A2A5 = 0;
	func_A28C(self.var_5058);
	func_A284(self.var_5050);
	if(isdefined(self.var_6DFC))
	{
		self.var_6DFC func_A28C(self.var_6DFC.var_5058);
	}

	thread func_A299();
}

//Function Number: 287
func_A28A(param_00,param_01)
{
	return isdefined(self.var_721C);
}

//Function Number: 288
func_A289(param_00)
{
	if(!self.var_4B75)
	{
		lib_0378::func_8D74("gas_valve_state","start_opening",self.var_4B6B);
	}
}

//Function Number: 289
func_A294()
{
	self endon("sm_state_change");
	self.var_721C common_scripts\utility::knock_off_battery("disconnect","begin_last_stand");
	self.var_721C = undefined;
}

//Function Number: 290
func_A293(param_00)
{
	if(isdefined(self.var_5986))
	{
		self.var_5986 notify("valve_start",self.var_721C);
	}

	self.var_A29B = self.var_A2A5 * self.var_A2A4;
	self.var_A29D = 1 - self.var_A2A5 * self.var_A2A4;
	if(!self.var_4B75)
	{
		lib_0378::func_8D74("gas_valve_state","opening",self.var_4B6B);
	}

	func_A28C(self.var_9ED0,self.var_A29B);
	func_A284(self.var_9EC3);
	if(isdefined(self.valve_type) && isdefined(self.valve_type == "custom"))
	{
		var_01 = self.var_A2A5 * self.var_9ED7;
		var_02 = self.var_9ED7 / self.var_A2A4;
		func_A28C(self.var_9ED0,var_01,var_02);
	}

	if(isdefined(self.var_6DFC))
	{
		var_01 = self.var_A2A5 * self.var_6DFC.var_9ED7;
		var_02 = self.var_6DFC.var_9ED7 / self.var_A2A4;
		self.var_6DFC func_A28C(self.var_6DFC.var_9ED0,var_01,var_02);
	}

	thread func_A294();
}

//Function Number: 291
func_A297(param_00,param_01)
{
	var_02 = gettime() - param_01 / 1000;
	self.var_A2A5 = self.var_A29B + var_02 / self.var_A2A4;
	if(self.var_A2A5 > 1)
	{
		self.var_A2A5 = 1;
	}
}

//Function Number: 292
func_A296(param_00,param_01)
{
	if(common_scripts\utility::func_562E(self.var_137B))
	{
		return 0;
	}

	if(isdefined(self.var_721C) && isalive(self.var_721C) && self.var_721C usebuttonpressed() && self.var_721C istouching(self.var_9D65))
	{
		return 0;
	}

	self.var_721C = undefined;
	if(isdefined(self.var_5986))
	{
		self.var_5986 lib_055B::func_5989();
	}

	return 1;
}

//Function Number: 293
func_A295(param_00,param_01)
{
	return self.var_A2A5 >= 1;
}

//Function Number: 294
func_A28F(param_00)
{
	self endon("sm_state_change");
	self.var_A29D = self.var_A2A5 * self.var_A2A3;
	self.var_A29B = self.var_A2A3 - self.var_A29D;
	func_A28C(self.var_9ECA,self.var_A29B);
	func_A284(self.var_9EC2);
	self notify("valve_turning_off");
	if(isdefined(self.var_6DFC))
	{
		var_01 = 1 - self.var_A2A5 * self.var_6DFC.var_9ECE;
		var_02 = self.var_6DFC.var_9ECE / self.var_A2A3;
		self.var_6DFC func_A28C(self.var_6DFC.var_9ECA,var_01,var_02);
	}

	if(!self.var_4B75)
	{
		lib_0378::func_8D74("gas_valve_state","closing",self.var_4B6B);
	}

	thread func_A299();
}

//Function Number: 295
func_A292(param_00,param_01)
{
	var_02 = gettime() - param_01 / 1000;
	self.var_A2A5 = 1 - self.var_A29B + var_02 / self.var_A2A3;
	if(self.var_A2A5 < 0)
	{
		self.var_A2A5 = 0;
	}
}

//Function Number: 296
func_A290(param_00,param_01)
{
	if(self.var_A2A5 > 0)
	{
		return 0;
	}

	if(!self.var_4B75)
	{
		lib_0378::func_8D74("gas_valve_state","closed",self.var_4B6B);
	}

	return 1;
}

//Function Number: 297
func_A291(param_00,param_01)
{
	return isdefined(self.var_721C);
}

//Function Number: 298
func_A28B(param_00)
{
	func_A28C(self.var_5059);
	func_A284(self.var_5052);
	if(!self.var_4B75)
	{
		lib_0378::func_8D74("gas_valve_state","open",self.var_4B6B);
	}

	if(isdefined(self.var_819A))
	{
		common_scripts\utility::func_3C8F(self.var_819A);
	}

	self.var_9D65 makeunusable();
	self notify("valve_complete");
	if(isdefined(self.var_5986))
	{
		self.var_5986 notify("valve_complete");
	}

	self.var_2566 = 1;
	var_01 = func_AC4B(self.var_116,"valve");
	var_01 func_AC48("script_flag",self.var_819A);
	var_01 func_AC47(self.var_721C);
	var_01 func_AC4D();
}

//Function Number: 299
func_A287(param_00)
{
	switch(param_00)
	{
		case "s2_zmb_valve_turn_on":
			return %s2_zmb_valve_turn_on;

		case "s2_zmb_valve_turn_off":
			return %s2_zmb_valve_turn_off;

		case "zmb_com_crank_idle":
			return %zmb_com_crank_idle;

		case "zmb_com_crank_turn":
			return %zmb_com_crank_turn;

		case "zmb_com_crank_reverse":
			return %zmb_com_crank_reverse;

		case "s2_zom_shroud_cover_lift_stuck_idle":
			return %s2_zom_shroud_cover_lift_stuck_idle;

		case "s2_zom_shroud_cover_lift_open":
			return %s2_zom_shroud_cover_lift_open;

		case "s2_zom_shroud_cover_lift_close":
			return %s2_zom_shroud_cover_lift_close;
	}
}

//Function Number: 300
func_A285(param_00)
{
	var_01 = func_A287(param_00);
	return getanimlength(var_01);
}

//Function Number: 301
func_A283(param_00,param_01)
{
	self.var_6766 = param_00;
	thread func_A298(param_01);
}

//Function Number: 302
func_A2A1()
{
	level.var_A2A0 = getentarray("valve","script_noteworthy");
	var_00 = getentarray("valveTrigger","script_noteworthy");
	foreach(var_02 in level.var_A2A0)
	{
		if(isdefined(var_02.var_819A))
		{
			common_scripts\utility::func_3C87(var_02.var_819A);
		}

		var_03 = common_scripts\utility::func_4461(var_02.var_116,var_00,200);
		var_00 = common_scripts\utility::func_F93(var_00,var_03);
		var_02.var_9D65 = var_03;
		var_04 = var_02 func_4315();
		var_02.var_A2A4 = 4;
		var_02.var_9ED0 = var_04["turnOnAnim"];
		if(isdefined(var_02.var_9ED0))
		{
			var_02.var_A2A4 = func_A285(var_02.var_9ED0);
		}

		var_02.var_A2A3 = 2;
		var_02.var_9ECA = var_04["turnOffAnim"];
		if(isdefined(var_02.var_9ECA))
		{
			var_02.var_A2A3 = func_A285(var_02.var_9ECA);
		}

		var_02.var_5059 = var_04["idleOnAnim"];
		var_02.var_5058 = var_04["idleOffAnim"];
		var_02.var_4B6B = isdefined(var_04["hasGasSounds"]) && tolower(var_04["hasGasSounds"]) == "true";
		var_02.var_4B75 = isdefined(var_04["hasLiftSounds"]) && tolower(var_04["hasLiftSounds"]) == "true";
		var_02.var_A2A5 = 0;
	}

	var_06 = "idle off";
	var_07 = "idle on";
	var_08 = "turning off";
	var_09 = "turning on";
	var_0A = lib_02FE::func_8CBE("valve");
	var_0A lib_02FE::func_8CBB(var_06);
	var_0A lib_02FE::func_8CB9(var_06,::func_A288);
	var_0A lib_02FE::func_8CBA(var_06,::func_A289);
	var_0A lib_02FE::func_8CBC(var_06,var_09,::func_A28A);
	var_0A lib_02FE::func_8CBB(var_07);
	var_0A lib_02FE::func_8CB9(var_07,::func_A28B);
	var_0A lib_02FE::func_8CBB(var_08);
	var_0A lib_02FE::func_8CB9(var_08,::func_A28F);
	var_0A lib_02FE::func_8CBD(var_08,::func_A292);
	var_0A lib_02FE::func_8CBC(var_08,var_06,::func_A290);
	var_0A lib_02FE::func_8CBC(var_08,var_09,::func_A291);
	var_0A lib_02FE::func_8CBB(var_09);
	var_0A lib_02FE::func_8CB9(var_09,::func_A293);
	var_0A lib_02FE::func_8CBD(var_09,::func_A297);
	var_0A lib_02FE::func_8CBC(var_09,var_07,::func_A295);
	var_0A lib_02FE::func_8CBC(var_09,var_08,::func_A296);
}

//Function Number: 303
func_A2A2()
{
	foreach(var_01 in level.var_A2A0)
	{
		var_01 thread lib_02FE::func_8CBF("valve",1);
	}
}

//Function Number: 304
func_ABE5()
{
	if(!func_AC4C())
	{
		return;
	}

	level waittill("game_ended");
	var_00 = func_AC4B(undefined,"player_xp_summary");
	var_01 = [];
	var_02 = [];
	for(var_03 = 0;var_03 < 4;var_03++)
	{
		var_04 = 0;
		var_05 = 0;
		var_06 = level.var_744A[var_03];
		var_07 = "player_" + var_03 + 1;
		if(isdefined(var_06))
		{
			var_04 = var_06.var_AB46["xp"] - var_06.var_AB46["totalXP"];
			var_01 = common_scripts\utility::func_F6F(var_01,var_04);
			var_05 = var_06.var_E3;
			var_02 = common_scripts\utility::func_F6F(var_02,var_05);
		}

		var_00 func_AC44(var_07 + "_xp_gain",var_04);
		var_00 func_AC44(var_07 + "_kill_count",var_05);
	}

	var_08 = gettime() / 3600000;
	var_09 = common_scripts\utility::func_6880(var_01) / var_08;
	var_0A = common_scripts\utility::func_6880(var_02) / var_08;
	var_00 func_AC43("hrs",var_08);
	var_00 func_AC43("xp_per_player_per_hr",var_09);
	var_00 func_AC44("kills_per_player_per_hr",var_0A);
	var_00 func_AC4D();
}

//Function Number: 305
func_4315()
{
	var_00 = [];
	if(isdefined(self.var_8260))
	{
		var_01 = strtok(self.var_8260,",");
		foreach(var_03 in var_01)
		{
			var_04 = strtok(var_03,"=");
			var_00[var_04[0]] = var_04[1];
		}
	}

	return var_00;
}

//Function Number: 306
func_408F()
{
	var_00 = [];
	var_01 = maps/mp/agents/_agent_utility::func_43FD("all");
	foreach(var_03 in var_01)
	{
		if(isdefined(var_03.var_A) && var_03.var_A == level.var_746E)
		{
			continue;
		}

		var_00[var_00.size] = var_03;
	}

	return var_00;
}

//Function Number: 307
func_4090(param_00)
{
	var_01 = func_408F();
	var_02 = [];
	foreach(var_04 in var_01)
	{
		if(!func_5565(var_04.var_A4B,param_00))
		{
			continue;
		}

		var_02 = common_scripts\utility::func_F6F(var_02,var_04);
	}

	return var_02;
}

//Function Number: 308
func_9A6C(param_00)
{
	return param_00 * 57.29578;
}

//Function Number: 309
func_9A9E(param_00)
{
	return param_00 * 0.01745329;
}

//Function Number: 310
func_7BD0(param_00,param_01,param_02,param_03,param_04)
{
	if(!isdefined(level.var_80D5))
	{
		level.var_80D5 = [];
	}

	var_05 = spawnstruct();
	var_05.var_109 = param_00;
	var_05.var_7F63 = param_01;
	var_05.var_5426 = param_02;
	var_05.var_6AA1 = param_04;
	var_05.var_7734 = param_03;
	level.var_80D5[param_00] = var_05;
}

//Function Number: 311
func_38DD(param_00)
{
	var_01 = param_00.var_931E;
	param_00 endon("scripted_state_interrupt");
	common_scripts\utility::func_8133(var_01.var_7F63,param_00.var_6E59);
	if(isdefined(var_01.var_6AA1))
	{
		common_scripts\utility::func_8133(var_01.var_6AA1,param_00.var_6E59);
	}
}

//Function Number: 312
func_7D1A(param_00,param_01,param_02,param_03)
{
	self endon("death");
	var_04 = level.var_80D5[param_00];
	var_05 = spawnstruct();
	var_05.var_109 = param_00;
	var_05.var_9A01 = param_02;
	var_05.var_7734 = var_04.var_7734;
	var_05.var_6E59 = param_01;
	var_05.var_931E = var_04;
	var_05.var_1F36 = param_03;
	func_06A2(var_05);
	var_05 endon("scripted_state_cancel");
	wait(0);
	while(self.var_788D[0] != var_05 || !func_05DC())
	{
		var_05 waittill("scripted_state_try");
	}

	var_05 notify("scripted_state_begin");
	self.var_8E1 = var_05;
	func_38DD(var_05);
	self.var_8E1 = undefined;
	func_05FC(var_05);
	func_06B1();
}

//Function Number: 313
sorted_array_compare_func(param_00,param_01)
{
	return param_00 <= param_01;
}

//Function Number: 314
insert_into_sorted_array(param_00,param_01,param_02)
{
	if(!isdefined(param_02))
	{
		param_02 = ::sorted_array_compare_func;
	}

	if(!isdefined(param_00))
	{
		return;
	}

	var_03 = 0;
	for(var_03 = 0;var_03 < param_00.size;var_03++)
	{
		if([[ param_02 ]](param_01,param_00[var_03]))
		{
			break;
		}
	}

	return common_scripts\utility::func_F86(param_00,param_01,var_03);
}

//Function Number: 315
func_06A2(param_00)
{
	self.var_788D = insert_into_sorted_array(self.var_788D,param_00,::func_05EA);
	thread func_067D(param_00);
	func_06B1();
}

//Function Number: 316
func_05EA(param_00,param_01)
{
	return param_00.var_7734 >= param_01.var_7734;
}

//Function Number: 317
func_05FC(param_00)
{
	self.var_788D = common_scripts\utility::func_F93(self.var_788D,param_00);
}

//Function Number: 318
func_0660(param_00)
{
	self.var_8E1 = undefined;
	if(isdefined(param_00.var_931E.var_5426))
	{
		common_scripts\utility::func_8133(param_00.var_931E.var_5426,param_00.var_6E59);
	}

	if(isdefined(param_00.var_931E.var_6AA1))
	{
		common_scripts\utility::func_8133(param_00.var_931E.var_6AA1,param_00.var_6E59);
	}

	param_00 notify("scripted_state_interrupt");
}

//Function Number: 319
func_067D(param_00)
{
	param_00 endon("scripted_state_begin");
	param_00 endon("scripted_state_cancel");
	self endon("death");
	var_01 = [];
	if(isdefined(param_00.var_9A01))
	{
		var_01[0] = param_00.var_9A01;
	}

	if(isdefined(param_00.var_1F36))
	{
		var_01 = common_scripts\utility::func_F73(var_01,param_00.var_1F36);
	}

	if(isdefined(param_00.var_9A01))
	{
		if(var_01.size > 1)
		{
			common_scripts\utility::func_8133(::common_scripts\utility::func_A70D,var_01);
		}
		else
		{
			wait(param_00.var_9A01);
		}
	}
	else if(var_01.size > 0)
	{
		common_scripts\utility::func_8133(::common_scripts\utility::func_A70C,var_01);
	}
	else
	{
		return;
	}

	thread func_05DD(param_00);
}

//Function Number: 320
func_05DD(param_00)
{
	func_05FC(param_00);
	param_00 notify("scripted_state_cancel");
}

//Function Number: 321
func_06B1()
{
	var_00 = self.var_788D[0];
	if(isdefined(self.var_8E1))
	{
		if(self.var_8E1 != var_00)
		{
			func_0660(self.var_8E1);
		}
	}

	if(isdefined(var_00) && !isdefined(self.var_8E1))
	{
		var_00 notify("scripted_state_try");
	}
}

//Function Number: 322
func_05DC()
{
	if(self.var_BA4 == "traverse")
	{
		return 0;
	}

	if(maps/mp/agents/_scripted_agent_anim_util::func_57E2() && !isdefined(self.var_8E1) && !common_scripts\utility::func_562E(self.ispermanentlyscripted))
	{
		return 0;
	}

	return 1;
}

//Function Number: 323
func_4A58()
{
	self endon("death");
	self.var_788D = [];
	self.var_8E1 = undefined;
	for(;;)
	{
		common_scripts\utility::knock_off_battery("traverse_end","killanimscript");
		func_06B1();
	}
}

//Function Number: 324
has_scripted_state_queued(param_00)
{
	if(!isdefined(self.var_788D))
	{
		return 0;
	}

	param_00 = tolower(param_00);
	foreach(var_02 in self.var_788D)
	{
		if(tolower(var_02.var_109) == param_00)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 325
is_in_scripted_state(param_00)
{
	if(!isdefined(self.var_8E1))
	{
		return 0;
	}

	return self.var_8E1.var_109 == param_00;
}

//Function Number: 326
func_7419(param_00,param_01)
{
	var_02 = self.var_116 - param_00;
	var_03 = param_01 * vectornormalize(var_02);
	var_03 = (var_03[0],var_03[1],250);
	if(param_01 > 0)
	{
		self setvelocity(var_03);
	}
}

//Function Number: 327
playerarmornotifychanges()
{
	var_00 = self;
	var_01 = common_scripts\utility::func_98E7(isdefined(self.var_F6B),self.var_F6B,0);
	var_02 = common_scripts\utility::func_98E7(isdefined(self.armorvestpiececountold),self.armorvestpiececountold,0);
	var_03 = var_01 - var_02;
	if(var_03 > 0)
	{
		var_00 notify("give_armor",var_03);
	}
	else if(var_03 < 0)
	{
		if(var_01 == 0)
		{
			self notify("take_armor");
		}
	}

	func_747E();
}

//Function Number: 328
func_7454(param_00)
{
	param_00 = int(min(param_00,playergetmaxarmorcount()));
	if(func_5565(self.var_F6B,param_00))
	{
		return;
	}

	self.armorvestpiececountold = self.var_F6B;
	self.var_F6B = param_00;
	playerarmornotifychanges();
}

//Function Number: 329
func_73AC(param_00)
{
	param_00 = int(min(param_00,playergetmaxarmorcount() - self.var_F6B));
	self.armorvestpiececountold = self.var_F6B;
	self.var_F6B = self.var_F6B + param_00;
	playerarmornotifychanges();
}

//Function Number: 330
func_7442(param_00)
{
	self.armorvestpiececountold = self.var_F6B;
	self.var_F6B = int(max(0,self.var_F6B - param_00));
	playerarmornotifychanges();
}

//Function Number: 331
func_73E9()
{
	return common_scripts\utility::func_98E7(isdefined(self.var_F6B),self.var_F6B,0);
}

//Function Number: 332
playergetmaxarmorcount()
{
	if(!isdefined(self.armorvestmaxcount))
	{
		return 3;
	}

	return self.armorvestmaxcount;
}

//Function Number: 333
playersetmaxarmorcount(param_00)
{
	param_00 = int(max(0,min(param_00,3)));
	self.armorvestmaxcount = param_00;
	if(self.var_F6B > self.armorvestmaxcount)
	{
		func_7454(self.armorvestmaxcount);
		return;
	}

	playerarmornotifychanges();
}

//Function Number: 334
func_747E()
{
	var_00 = 0;
	if(isdefined(self.armorvestmaxcount))
	{
		var_00 = 3 - self.armorvestmaxcount;
	}

	self setclientomnvar("ui_zm_exo_health",self.var_F6B + var_00 * 10);
	self notify("update_armor_hints");
}

//Function Number: 335
clearrangedperk(param_00)
{
	if(isdefined(level.var_744A))
	{
		foreach(var_02 in level.var_744A)
		{
			var_02 luinotifyeventextraplayer(&"clear_teammate_mod_buffs",1,param_00);
		}
	}
}

//Function Number: 336
rangedperknotifyteammateui(param_00,param_01)
{
	self endon("death");
	self endon("disconnect");
	if(!isdefined(level.var_744A))
	{
		return;
	}

	var_02 = 1;
	while(var_02)
	{
		var_02 = 0;
		if(param_00 == "specialty_class_squad_tactics_zm")
		{
			var_02 = self.var_5F5C;
		}

		foreach(var_04 in level.var_744A)
		{
			if(!isdefined(var_04.rangeperkon))
			{
				var_04.rangeperkon = [];
			}

			if(var_04 == self || !isalive(var_04))
			{
				continue;
			}

			if(distancesquared(self.var_116,var_04.var_116) < param_01)
			{
				var_05 = 1;
				if(isdefined(var_04.rangeperkon))
				{
					for(var_06 = 0;var_06 < var_04.rangeperkon.size;var_06++)
					{
						if(var_04.rangeperkon[var_06].perkref == param_00 && var_04.rangeperkon[var_06].sendingplayer == self)
						{
							var_05 = 0;
						}
					}
				}

				if(var_05 == 1)
				{
					var_04 luinotifyeventextraplayer(&"add_teammate_mod_buffs",3,param_00,0,self);
					var_07 = spawnstruct();
					var_07.perkref = param_00;
					var_07.sendingplayer = self;
					var_04.rangeperkon[var_04.rangeperkon.size] = var_07;
				}

				continue;
			}

			if(distancesquared(self.var_116,var_04.var_116) >= param_01)
			{
				for(var_06 = 0;var_06 < var_04.rangeperkon.size;var_06++)
				{
					if(var_04.rangeperkon[var_06].perkref == param_00 && var_04.rangeperkon[var_06].sendingplayer == self)
					{
						var_04 luinotifyeventextraplayer(&"remove_teammate_mod_buffs",1,param_00);
						var_04.rangeperkon = common_scripts\utility::func_F9A(var_04.rangeperkon,var_06);
					}
				}
			}
		}

		wait(0.2);
	}

	foreach(var_04 in level.var_744A)
	{
		if(isdefined(var_04.rangeperkon))
		{
			for(var_06 = 0;var_06 < var_04.rangeperkon.size;var_06++)
			{
				if(var_04.rangeperkon[var_06].perkref == param_00 && var_04.rangeperkon[var_06].sendingplayer == self)
				{
					var_04 luinotifyeventextraplayer(&"remove_teammate_mod_buffs",1,param_00);
					var_04.rangeperkon = common_scripts\utility::func_F9A(var_04.rangeperkon,var_06);
				}
			}
		}
	}
}

//Function Number: 337
func_0F0F(param_00)
{
	if(!isdefined(level.var_744A))
	{
		return 0;
	}

	foreach(var_02 in level.var_744A)
	{
		if(var_02 func_4BA7(param_00))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 338
func_4BA7(param_00)
{
	return maps\mp\_utility::func_649(param_00);
}

//Function Number: 339
func_8A6B(param_00)
{
	maps\mp\_utility::func_47A2(param_00);
}

//Function Number: 340
func_A086(param_00)
{
	maps\mp\_utility::func_735(param_00);
}

//Function Number: 341
func_9470(param_00)
{
	var_01 = int(param_00);
	return var_01;
}

//Function Number: 342
func_7ACD()
{
	maps\mp\gametypes\_weapons::func_A13B();
}

//Function Number: 343
zombiesmovespeedscale()
{
	var_00 = 1;
	if(isdefined(self.var_5378) && self.var_5378 && isdefined(self.var_172C) && self.var_172C)
	{
		return 0;
	}

	if(isdefined(self.var_5799) && self.var_5799)
	{
		return 0;
	}

	if(func_4BA7("specialty_class_mobilization_zm") && isdefined(self.var_569F) && self.var_569F)
	{
		var_00 = var_00 * 1.5;
	}

	if(func_4BA7("specialty_class_charge_the_line_zm") && isdefined(self.var_60E8) && self.var_60E8)
	{
		var_00 = var_00 * 1.5;
	}

	if(isdefined(self.var_570B) && self.var_570B)
	{
		var_00 = var_00 * 0.9;
	}

	if(isdefined(self.var_570C) && self.var_570C)
	{
		var_00 = var_00 * 0.7;
	}

	if(isdefined(self.var_570D) && self.var_570D)
	{
		var_00 = var_00 * 0.5;
	}

	if(isdefined(self.bayonetboost) && self.bayonetboost && isdefined(self.var_165B) && self.var_165B)
	{
		var_00 = var_00 * 1.1;
	}

	if(isdefined(self.bayonetboosthc) && self.bayonetboosthc && isdefined(self.var_165B) && self.var_165B)
	{
		var_00 = var_00 * 1.25;
	}

	return var_00;
}

//Function Number: 344
func_AB2B()
{
	if(!isalive(self) && !func_73F9(self,common_scripts\utility::func_4550()))
	{
		return common_scripts\utility::func_4550();
	}

	if(!func_73F9(self,common_scripts\utility::func_4550()))
	{
		return maps\mp\_utility::func_44DD();
	}

	return common_scripts\utility::func_4550();
}

//Function Number: 345
func_52B0()
{
	level.var_32BC = [];
	func_7BDE("dot_generic_zm");
}

//Function Number: 346
func_7BDE(param_00)
{
	var_01 = spawnstruct();
	level.var_32BC[param_00] = var_01;
	var_01.var_109 = param_00;
}

//Function Number: 347
func_56D0(param_00)
{
	if(isdefined(param_00) && isdefined(level.var_32BC[param_00]))
	{
		return 1;
	}

	return 0;
}

//Function Number: 348
func_AAFA(param_00,param_01)
{
	var_02 = getent(param_00,param_01);
	if(!isdefined(var_02))
	{
		return;
	}

	for(;;)
	{
		var_02 waittill("trigger",var_03);
		if(!isplayer(var_03))
		{
			continue;
		}

		return var_03;
	}
}

//Function Number: 349
func_AAFB(param_00)
{
	return func_AAFA(param_00,"targetname");
}

//Function Number: 350
func_1E5F(param_00,param_01)
{
	switch(param_01.size)
	{
		case 0:
			return [[ param_00 ]]();

		case 1:
			return [[ param_00 ]](param_01[0]);

		case 2:
			return [[ param_00 ]](param_01[0],param_01[1]);

		case 3:
			return [[ param_00 ]](param_01[0],param_01[1],param_01[2]);

		case 4:
			return [[ param_00 ]](param_01[0],param_01[1],param_01[2],param_01[3]);

		case 5:
			return [[ param_00 ]](param_01[0],param_01[1],param_01[2],param_01[3],param_01[4]);

		case 6:
			return [[ param_00 ]](param_01[0],param_01[1],param_01[2],param_01[3],param_01[4],param_01[5]);

		case 7:
			return [[ param_00 ]](param_01[0],param_01[1],param_01[2],param_01[3],param_01[4],param_01[5],param_01[6]);

		case 8:
			return [[ param_00 ]](param_01[0],param_01[1],param_01[2],param_01[3],param_01[4],param_01[5],param_01[6],param_01[7]);

		case 9:
			return [[ param_00 ]](param_01[0],param_01[1],param_01[2],param_01[3],param_01[4],param_01[5],param_01[6],param_01[7],param_01[8]);

		case 10:
			return [[ param_00 ]](param_01[0],param_01[1],param_01[2],param_01[3],param_01[4],param_01[5],param_01[6],param_01[7],param_01[8],param_01[9]);

		case 11:
			return [[ param_00 ]](param_01[0],param_01[1],param_01[2],param_01[3],param_01[4],param_01[5],param_01[6],param_01[7],param_01[8],param_01[9],param_01[10]);

		case 12:
			return [[ param_00 ]](param_01[0],param_01[1],param_01[2],param_01[3],param_01[4],param_01[5],param_01[6],param_01[7],param_01[8],param_01[9],param_01[10],param_01[11]);

		case 13:
			return [[ param_00 ]](param_01[0],param_01[1],param_01[2],param_01[3],param_01[4],param_01[5],param_01[6],param_01[7],param_01[8],param_01[9],param_01[10],param_01[11],param_01[12]);

		case 14:
			return [[ param_00 ]](param_01[0],param_01[1],param_01[2],param_01[3],param_01[4],param_01[5],param_01[6],param_01[7],param_01[8],param_01[9],param_01[10],param_01[11],param_01[12],param_01[13]);

		case 15:
			return [[ param_00 ]](param_01[0],param_01[1],param_01[2],param_01[3],param_01[4],param_01[5],param_01[6],param_01[7],param_01[8],param_01[9],param_01[10],param_01[11],param_01[12],param_01[13],param_01[14]);

		case 16:
			return [[ param_00 ]](param_01[0],param_01[1],param_01[2],param_01[3],param_01[4],param_01[5],param_01[6],param_01[7],param_01[8],param_01[9],param_01[10],param_01[11],param_01[12],param_01[13],param_01[14],param_01[15]);

		case 17:
			return [[ param_00 ]](param_01[0],param_01[1],param_01[2],param_01[3],param_01[4],param_01[5],param_01[6],param_01[7],param_01[8],param_01[9],param_01[10],param_01[11],param_01[12],param_01[13],param_01[14],param_01[15],param_01[16]);

		case 18:
			return [[ param_00 ]](param_01[0],param_01[1],param_01[2],param_01[3],param_01[4],param_01[5],param_01[6],param_01[7],param_01[8],param_01[9],param_01[10],param_01[11],param_01[12],param_01[13],param_01[14],param_01[15],param_01[16],param_01[17]);

		case 19:
			return [[ param_00 ]](param_01[0],param_01[1],param_01[2],param_01[3],param_01[4],param_01[5],param_01[6],param_01[7],param_01[8],param_01[9],param_01[10],param_01[11],param_01[12],param_01[13],param_01[14],param_01[15],param_01[16],param_01[17],param_01[18]);

		case 20:
			return [[ param_00 ]](param_01[0],param_01[1],param_01[2],param_01[3],param_01[4],param_01[5],param_01[6],param_01[7],param_01[8],param_01[9],param_01[10],param_01[11],param_01[12],param_01[13],param_01[14],param_01[15],param_01[16],param_01[17],param_01[18],param_01[19]);

		case 21:
			return [[ param_00 ]](param_01[0],param_01[1],param_01[2],param_01[3],param_01[4],param_01[5],param_01[6],param_01[7],param_01[8],param_01[9],param_01[10],param_01[11],param_01[12],param_01[13],param_01[14],param_01[15],param_01[16],param_01[17],param_01[18],param_01[19],param_01[20]);

		case 22:
			return [[ param_00 ]](param_01[0],param_01[1],param_01[2],param_01[3],param_01[4],param_01[5],param_01[6],param_01[7],param_01[8],param_01[9],param_01[10],param_01[11],param_01[12],param_01[13],param_01[14],param_01[15],param_01[16],param_01[17],param_01[18],param_01[19],param_01[20],param_01[21]);

		case 23:
			return [[ param_00 ]](param_01[0],param_01[1],param_01[2],param_01[3],param_01[4],param_01[5],param_01[6],param_01[7],param_01[8],param_01[9],param_01[10],param_01[11],param_01[12],param_01[13],param_01[14],param_01[15],param_01[16],param_01[17],param_01[18],param_01[19],param_01[20],param_01[21],param_01[22]);

		case 24:
			return [[ param_00 ]](param_01[0],param_01[1],param_01[2],param_01[3],param_01[4],param_01[5],param_01[6],param_01[7],param_01[8],param_01[9],param_01[10],param_01[11],param_01[12],param_01[13],param_01[14],param_01[15],param_01[16],param_01[17],param_01[18],param_01[19],param_01[20],param_01[21],param_01[22],param_01[23]);

		case 25:
			return [[ param_00 ]](param_01[0],param_01[1],param_01[2],param_01[3],param_01[4],param_01[5],param_01[6],param_01[7],param_01[8],param_01[9],param_01[10],param_01[11],param_01[12],param_01[13],param_01[14],param_01[15],param_01[16],param_01[17],param_01[18],param_01[19],param_01[20],param_01[21],param_01[22],param_01[23],param_01[24]);

		case 26:
			return [[ param_00 ]](param_01[0],param_01[1],param_01[2],param_01[3],param_01[4],param_01[5],param_01[6],param_01[7],param_01[8],param_01[9],param_01[10],param_01[11],param_01[12],param_01[13],param_01[14],param_01[15],param_01[16],param_01[17],param_01[18],param_01[19],param_01[20],param_01[21],param_01[22],param_01[23],param_01[24],param_01[25]);

		case 27:
			return [[ param_00 ]](param_01[0],param_01[1],param_01[2],param_01[3],param_01[4],param_01[5],param_01[6],param_01[7],param_01[8],param_01[9],param_01[10],param_01[11],param_01[12],param_01[13],param_01[14],param_01[15],param_01[16],param_01[17],param_01[18],param_01[19],param_01[20],param_01[21],param_01[22],param_01[23],param_01[24],param_01[25],param_01[26]);

		case 28:
			return [[ param_00 ]](param_01[0],param_01[1],param_01[2],param_01[3],param_01[4],param_01[5],param_01[6],param_01[7],param_01[8],param_01[9],param_01[10],param_01[11],param_01[12],param_01[13],param_01[14],param_01[15],param_01[16],param_01[17],param_01[18],param_01[19],param_01[20],param_01[21],param_01[22],param_01[23],param_01[24],param_01[25],param_01[26],param_01[27]);

		case 29:
			return [[ param_00 ]](param_01[0],param_01[1],param_01[2],param_01[3],param_01[4],param_01[5],param_01[6],param_01[7],param_01[8],param_01[9],param_01[10],param_01[11],param_01[12],param_01[13],param_01[14],param_01[15],param_01[16],param_01[17],param_01[18],param_01[19],param_01[20],param_01[21],param_01[22],param_01[23],param_01[24],param_01[25],param_01[26],param_01[27],param_01[28]);

		case 30:
			return [[ param_00 ]](param_01[0],param_01[1],param_01[2],param_01[3],param_01[4],param_01[5],param_01[6],param_01[7],param_01[8],param_01[9],param_01[10],param_01[11],param_01[12],param_01[13],param_01[14],param_01[15],param_01[16],param_01[17],param_01[18],param_01[19],param_01[20],param_01[21],param_01[22],param_01[23],param_01[24],param_01[25],param_01[26],param_01[27],param_01[28],param_01[29]);

		default:
			break;
	}
}

//Function Number: 351
func_AC42(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	func_AC46(param_00,param_01,"%b");
}

//Function Number: 352
func_AC44(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	func_AC46(param_00,int(param_01),"%d");
}

//Function Number: 353
func_AC43(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	func_AC46(param_00,float(param_01),"%f");
}

//Function Number: 354
func_AC48(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = "";
	}

	func_AC46(param_00,param_01,"%s");
}

//Function Number: 355
func_AC45(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = &"ZOMBIES_EMPTY_STRING";
	}

	func_AC46(param_00,param_01,"%t");
}

//Function Number: 356
func_AC49(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = (0,0,0);
	}

	func_AC46(param_00,param_01,"%v");
}

//Function Number: 357
func_AC46(param_00,param_01,param_02)
{
	if(!func_AC4C())
	{
		return;
	}

	var_03 = spawnstruct();
	var_03.var_109 = param_00;
	var_03.var_A281 = param_01;
	var_03.var_1B9 = param_02;
	self.var_6E5C = common_scripts\utility::func_F6F(self.var_6E5C,var_03);
	var_04 = 48;
}

//Function Number: 358
func_AC4C()
{
	if(!isdefined(level.var_AC4C))
	{
		level.var_AC4C = getdvar("3038") != "";
	}

	return level.var_AC4C;
}

//Function Number: 359
func_AC4B(param_00,param_01)
{
	var_02 = spawnstruct();
	if(func_AC4C())
	{
		if(isdefined(param_00))
		{
			var_02.var_AC7C = lib_055A::func_4562(param_00);
			if(!isdefined(var_02.var_AC7C))
			{
				var_02.var_AC7C = "";
			}
		}

		var_03 = 0;
		if(!var_03 && !isdefined(param_00))
		{
			param_00 = (0,0,0);
		}

		var_02.var_116 = param_00;
		var_02.var_3E3D = "script_zombie_" + param_01 + ": ";
		var_02.var_6E5C = [];
	}

	return var_02;
}

//Function Number: 360
func_AC4D()
{
	if(!func_AC4C())
	{
		return;
	}

	func_AC44("game_time_ms",gettime());
	func_AC42("is_atvi_recon_playtest_build",0);
	var_00 = 4;
	var_01 = [];
	if(isdefined(level.var_744A))
	{
		foreach(var_03 in level.var_744A)
		{
			var_01 = common_scripts\utility::func_F6F(var_01,var_03.var_109);
		}
	}

	while(var_01.size < var_00)
	{
		var_01 = common_scripts\utility::func_F6F(var_01,"");
	}

	for(var_05 = 0;var_05 < var_00;var_05++)
	{
		func_AC48("player_" + var_05 + 1,var_01[var_05]);
	}

	if(isdefined(self.var_AC7C))
	{
		func_AC48("zone",self.var_AC7C);
	}

	func_AC48("quests",lib_0557::func_7837());
	func_AC44("zombies_wave",level.var_A980);
	var_06 = [];
	var_07 = "";
	foreach(var_09 in self.var_6E5C)
	{
		self.var_3E3D = self.var_3E3D + var_07 + var_09.var_109 + " " + var_09.var_1B9;
		var_07 = ", ";
		var_06 = common_scripts\utility::func_F6F(var_06,var_09.var_A281);
	}

	if(isdefined(self.var_116))
	{
		var_06 = common_scripts\utility::func_F73([self.var_116,self.var_3E3D],var_06);
		func_1E5F(::function_00F6,var_06);
		return;
	}

	var_06 = common_scripts\utility::func_F73([self.var_3E3D],var_06);
	func_1E5F(::function_00F5,var_06);
}

//Function Number: 361
func_AC4A()
{
	var_00 = -1;
	if(isdefined(level.var_7F23))
	{
		var_00 = maps\mp\gametypes\_gamelogic::func_44F8() - level.var_7F23;
	}

	func_AC43("zombies_wave_time",var_00);
}

//Function Number: 362
func_AC47(param_00)
{
	var_01 = "";
	if(isdefined(param_00))
	{
		var_01 = param_00.var_109;
	}

	func_AC48("player",var_01);
}

//Function Number: 363
func_1F54(param_00,param_01)
{
	var_02 = 0;
	switch(param_00.var_A4B)
	{
		case "zombie_sizzler":
		case "zombie_berserker":
		case "zombie_generic":
			var_02 = 1;
			break;
	}

	if(!var_02)
	{
		return 0;
	}

	if(common_scripts\utility::func_562E(param_00.var_2FDA))
	{
		return 0;
	}

	if(param_00 func_5774() || common_scripts\utility::func_562E(param_00.var_103) || param_00 func_AC70())
	{
		return 0;
	}

	if(common_scripts\utility::func_562E(param_00.nopairmelee))
	{
		return 0;
	}

	var_03 = level.var_A9C8[param_01];
	if(isdefined(var_03))
	{
		return self [[ var_03 ]](param_00);
	}

	return lib_0586::func_2BA2(param_00);
}

//Function Number: 364
currentplayersthread(param_00,param_01)
{
	if(!isdefined(level.var_744A))
	{
		return;
	}

	foreach(var_03 in level.var_744A)
	{
		var_03 thread common_scripts\utility::func_8133(param_00,param_01);
	}

	foreach(var_03 in level.var_596C)
	{
		var_03 thread common_scripts\utility::func_8133(param_00,param_01);
	}
}

//Function Number: 365
perzombiethread(param_00,param_01)
{
	foreach(var_03 in func_408F())
	{
		var_03 thread common_scripts\utility::func_8133(param_00,param_01);
	}

	for(;;)
	{
		level waittill("zombie_spawned",var_03);
		var_03 thread common_scripts\utility::func_8133(param_00,param_01);
	}
}

//Function Number: 366
func_ABCB(param_00,param_01)
{
	var_02 = param_00 getclientomnvar("ui_zm_hud_vis_bits");
	var_03 = 1 << param_01;
	var_04 = var_02 & var_03;
	var_05 = var_04 != 0;
	return var_05;
}

//Function Number: 367
func_ABCC(param_00,param_01,param_02)
{
	if(func_ABCB(param_00,param_01) == param_02)
	{
		return 0;
	}

	var_03 = param_00 getclientomnvar("ui_zm_hud_vis_bits");
	if(param_02)
	{
		var_03 = var_03 | 1 << param_01;
	}
	else
	{
		var_03 = var_03 & ~1 << param_01;
	}

	param_00 setclientomnvar("ui_zm_hud_vis_bits",var_03);
	return 1;
}

//Function Number: 368
func_ABCA(param_00,param_01)
{
	return func_ABCC(param_00,param_01,1);
}

//Function Number: 369
func_ABC9(param_00,param_01)
{
	return func_ABCC(param_00,param_01,0);
}

//Function Number: 370
func_9597()
{
	func_7BD0("tackle",::func_959B,undefined,4.5,::func_959A);
}

//Function Number: 371
func_43EF(param_00,param_01)
{
	var_02 = self;
	if(isdefined(var_02.var_A4B) && common_scripts\utility::func_F79(["zombie_generic","zombie_berserker"],var_02.var_A4B) && param_01 < param_00.var_2434)
	{
		return "close";
	}

	if(param_01 < param_00.var_60C1)
	{
		return "medium";
	}

	return "far";
}

//Function Number: 372
tackle_is_in_range(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = vectordot(param_00,param_01);
	if(var_05 < 0 || var_05 > param_03)
	{
		return 0;
	}

	var_06 = abs(vectordot(param_00,param_02));
	if(var_06 > param_04)
	{
		return 0;
	}

	return 1;
}

//Function Number: 373
tackle_thread(param_00,param_01,param_02)
{
	for(;;)
	{
		wait 0.05;
		if(common_scripts\utility::func_562E(param_00.var_2F74))
		{
			continue;
		}

		var_03 = anglestoright(param_00.var_1D);
		var_04 = anglestoforward(param_00.var_1D);
		var_05 = param_01;
		var_06 = var_05.var_2434;
		var_07 = var_05.var_60C1;
		var_08 = var_05.var_3A20;
		var_09 = var_05.var_1B70;
		var_0A = max(var_06,max(var_07,var_08)) / 2;
		var_0B = 0;
		var_0C = 0;
		foreach(var_0E in func_408F())
		{
			if(var_0E == self)
			{
				continue;
			}

			var_0F = func_0A51(var_0E.var_A4B);
			var_10 = isdefined(var_0F) && common_scripts\utility::func_562E(var_0F.tacklebycharge);
			if(!var_10)
			{
				continue;
			}

			var_11 = var_0E.var_116 - param_00.var_116;
			if(common_scripts\utility::func_562E(var_0E.immunetotackling))
			{
				continue;
			}

			if(!tackle_is_in_range(var_11,var_04,var_03,var_09,var_0A))
			{
				continue;
			}

			if(var_0E maps/mp/agents/humanoid/_humanoid_util::func_56BC())
			{
				maps/mp/agents/_agent_utility::func_5A28(var_0E);
				continue;
			}

			var_12 = abs(vectordot(var_11,var_03));
			var_13 = var_0E func_43EF(var_05,var_12);
			func_7D1B(param_00,var_0E,var_13,param_02);
		}

		if(common_scripts\utility::func_562E(var_05.tackleplayers))
		{
			var_1B = var_05.far_dist_p;
			var_1C = var_05.box_height_p;
			var_1D = gettime();
			var_1E = 2000;
			foreach(var_20 in level.var_744A)
			{
				if(isdefined(var_20.lasttackledtime) && var_1D - var_20.lasttackledtime <= var_1E)
				{
					continue;
				}

				var_21 = var_20.var_116 - param_00.var_116;
				if(!tackle_is_in_range(var_21,var_04,var_03,var_1C,var_1B))
				{
					continue;
				}

				var_20.lasttackledtime = var_1D;
				var_20 dodamage(var_05.tackle_dmg_p,param_00.var_116,param_00);
			}
		}
	}
}

//Function Number: 374
create_temp_tackler(param_00)
{
	var_01 = spawnstruct();
	var_01.var_116 = param_00.var_116;
	var_01.var_1D = param_00.var_1D;
	return var_01;
}

//Function Number: 375
func_7D1B(param_00,param_01,param_02,param_03)
{
	if(isdefined(param_01) && param_01 maps/mp/agents/humanoid/_humanoid_util::func_56BC())
	{
		return;
	}

	if(!isdefined(param_02))
	{
		param_02 = "medium";
	}

	var_04 = spawnstruct();
	var_04.var_959C = param_00;
	var_04.var_9598 = param_02;
	var_04.var_53E8 = param_03;
	param_01 thread func_7D1A("tackle",[var_04],0.05,[param_00,"death"]);
	param_00.var_5B55 = gettime();
}

//Function Number: 376
func_959B(param_00)
{
	var_01 = param_00.var_959C;
	var_02 = anglestoright(var_01.var_1D);
	var_03 = var_02 * common_scripts\utility::func_8C4F(vectordot(var_02,self.var_116 - var_01.var_116));
	var_04 = angleclamp180(vectortoyaw(var_03) - self.var_1D[1]);
	var_05 = [];
	var_06 = [];
	if(isdefined(var_01) && isdefined(var_01.var_117) && function_01EF(var_01.var_117))
	{
		set_tackled_by(var_01.var_117,1);
	}

	switch(param_00.var_9598)
	{
		case "close":
			var_05 = ["side_stumble_1_back_left","side_stumble_1_back_right","side_stumble_1_forward_left","side_stumble_1_forward_right"];
			var_06 = [135,-135,45,-45];
			break;

		case "medium":
			var_05 = ["side_stumble_2_left","side_stumble_2_right"];
			var_06 = [90,-90];
			break;

		case "far":
			var_05 = ["side_stumble_3_left","side_stumble_3_right"];
			var_06 = [90,-90];
			break;

		default:
			break;
	}

	var_07 = 180;
	var_08 = 0;
	for(var_09 = 0;var_09 < var_06.size;var_09++)
	{
		var_0A = var_06[var_09];
		var_0B = abs(angleclamp180(var_0A - var_04));
		if(var_0B > var_07)
		{
			continue;
		}

		var_07 = var_0B;
		var_08 = var_09;
	}

	var_0C = var_05[var_08];
	var_0D = maps/mp/agents/_scripted_agent_anim_util::func_434D(var_0C);
	var_0E = self method_83DB(var_0D);
	var_0F = randomint(var_0E);
	var_10 = 0.5;
	var_07 = angleclamp180(var_04 - var_06[var_08]);
	var_11 = (self.var_1D[0],self.var_1D[1] + var_07 * var_10,self.var_1D[2]);
	self scragentsetscripted(1);
	maps/mp/agents/_scripted_agent_anim_util::func_8732(1,"tackle");
	self method_839C("anim deltas");
	self scragentsetorientmode("face angle abs",var_11);
	maps/mp/agents/_scripted_agent_anim_util::func_71FA(var_0D,var_0F,1,"stun_anim");
	lib_054D::func_4788(param_00.var_959C,param_00.var_53E8);
}

//Function Number: 377
func_959A(param_00)
{
	if(isdefined(param_00.var_959C) && isdefined(param_00.var_959C.var_117) && function_01EF(param_00.var_959C.var_117))
	{
		set_tackled_by(param_00.var_959C.var_117,0);
	}

	self scragentsetscripted(0);
	maps/mp/agents/_scripted_agent_anim_util::func_8732(0,"tackle");
}

//Function Number: 378
set_tackled_by(param_00,param_01)
{
	if(!isdefined(param_00.tacklevictims))
	{
		param_00.tacklevictims = [];
	}

	if(!isdefined(self.tackleattackers))
	{
		self.tackleattackers = [];
	}

	var_02 = self getentitynumber();
	var_03 = param_00 getentitynumber();
	if(param_01)
	{
		param_00.tacklevictims[var_02] = self;
		self.tackleattackers[var_03] = param_00;
	}
	else
	{
		param_00.tacklevictims[var_02] = undefined;
		self.tackleattackers[var_03] = undefined;
	}

	update_tackle_status(self);
	update_tackle_status(param_00);
}

//Function Number: 379
tackle_system_handle_zombie_death(param_00)
{
	if(isdefined(self.tacklevictims))
	{
		foreach(var_02 in self.tacklevictims)
		{
			var_02 set_tackled_by(self,0);
		}
	}

	if(isdefined(self.tackleattackers))
	{
		foreach(var_05 in self.tackleattackers)
		{
			set_tackled_by(var_05,0);
		}
	}
}

//Function Number: 380
update_tackle_status(param_00)
{
	if(isdefined(self.tacklevictims) && self.tacklevictims.size > 0)
	{
		return;
	}

	if(isdefined(self.tackleattackers) && self.tackleattackers.size > 0)
	{
		return;
	}
}

//Function Number: 381
func_0619(param_00,param_01)
{
	if(common_scripts\utility::func_F79(param_00["attachments"],param_01))
	{
		return param_00;
	}

	return func_0593(param_00,param_01);
}

//Function Number: 382
func_0593(param_00,param_01)
{
	if(!isdefined(param_00["attachments"]))
	{
		param_00["attachments"] = [];
	}

	var_02 = common_scripts\utility::func_F6F(param_00["attachments"],param_01);
	param_00["attachments"] = common_scripts\utility::func_C9E(var_02);
	return param_00;
}

//Function Number: 383
func_6117(param_00,param_01)
{
	var_02 = [];
	var_03 = ["alt_mode","weapon","cond","camo","reticle","customization","model"];
	foreach(var_05 in var_03)
	{
		var_06 = undefined;
		var_07 = param_00[var_05];
		var_08 = param_01[var_05];
		if(isdefined(var_07))
		{
			var_06 = var_07;
		}
		else if(isdefined(var_08))
		{
			var_06 = var_08;
		}

		var_02[var_05] = var_06;
	}

	var_0A = common_scripts\utility::func_F73(param_00["attachments"],param_01["attachments"]);
	var_0A = common_scripts\utility::func_F97(var_0A);
	if(var_0A.size > 6)
	{
		var_0A = common_scripts\utility::func_FA3(var_0A,0,6);
	}

	var_02["attachments"] = common_scripts\utility::func_C9E(var_0A);
	return var_02;
}

//Function Number: 384
func_06AD(param_00,param_01)
{
	param_00["attachments"] = common_scripts\utility::func_F93(param_00["attachments"],param_01);
	return param_00;
}

//Function Number: 385
func_062F(param_00)
{
	var_01 = "";
	if(isdefined(param_00["alt_mode"]))
	{
		var_01 = var_01 + param_00["alt_mode"] + "+";
	}

	var_02 = param_00["weapon"];
	var_01 = var_01 + var_02;
	var_03 = param_00["attachments"];
	if(isdefined(var_03))
	{
		var_04 = maps\mp\gametypes\_class::func_774F(var_02,var_03);
		foreach(var_06 in var_04)
		{
			var_01 = var_01 + "+" + var_06;
		}
	}

	foreach(var_09 in ["cond","camo","reticle","customization","model"])
	{
		var_0A = param_00[var_09];
		var_01 = maps\mp\gametypes\_class::func_F1E(var_01,var_0A);
	}

	return var_01;
}

//Function Number: 386
func_AAFC(param_00)
{
	var_01 = function_01AA(param_00);
	return var_01;
}

//Function Number: 387
func_9469(param_00)
{
	if(!isdefined(level.var_946A))
	{
		level.var_946A = [];
	}

	var_01 = level.var_946A[param_00];
	if(!isdefined(var_01))
	{
		var_01 = func_946B(param_00);
		if(level.var_946A.size < 1000)
		{
			level.var_946A[param_00] = var_01;
		}
	}

	return var_01;
}

//Function Number: 388
func_946B(param_00)
{
	var_01 = "_loot";
	var_02 = common_scripts\utility::func_9462(param_00,var_01);
	if(var_02 == -1)
	{
		return param_00;
	}

	var_03 = var_02 + var_01.size;
	while(var_03 < param_00.size)
	{
		var_04 = param_00[var_03];
		if(var_04 != "_")
		{
			continue;
		}

		var_05 = getsubstr(param_00,0,var_02);
		var_06 = getsubstr(param_00,var_03);
		param_00 = var_05 + var_06;
		return param_00;
		var_05++;
	}

	return var_02;
}

//Function Number: 389
func_AAF9(param_00,param_01,param_02)
{
	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	var_03 = getweapondisplayname(param_00);
	if(!isdefined(var_03))
	{
		return "none";
	}

	param_00 = var_03;
	if(!param_01)
	{
		param_00 = lib_0569::func_40BD(param_00);
	}

	if(!param_02)
	{
		param_00 = func_9469(param_00);
	}

	return param_00;
}

//Function Number: 390
func_5843(param_00)
{
	var_01 = "none" != function_01AA(param_00);
	return var_01;
}

//Function Number: 391
func_9475(param_00)
{
	param_00 = function_02FF(param_00,"_zm");
	param_00 = function_02FF(param_00,"_mp");
	param_00 = function_02FF(param_00,"_raid");
	return param_00;
}

//Function Number: 392
func_0FB9(param_00)
{
	var_01 = [];
	foreach(var_03 in param_00)
	{
		if(!common_scripts\utility::func_F79(var_01,var_03))
		{
			var_01 = common_scripts\utility::func_F6F(var_01,var_03);
		}
	}

	return var_01;
}

//Function Number: 393
func_4584(param_00,param_01)
{
	if(!isdefined(param_00) || param_00 == "none")
	{
		return [undefined,undefined];
	}

	var_02 = getweapondisplayname(param_00);
	if(isplayer(param_01) && param_01 method_8661())
	{
		var_03 = "heavy";
	}
	else
	{
		var_03 = "default";
	}

	return [var_03,var_02];
}

//Function Number: 394
is_power_on(param_00)
{
	if(!common_scripts\utility::func_3C77("power_sz2"))
	{
		return 0;
	}

	return 1;
}

//Function Number: 395
getzombiemapsetting(param_00)
{
	if(!isdefined(level.zmutils))
	{
		level.zmutils = [];
		loadzombiemapsettings("default");
		loadzombiemapsettings(maps\mp\_utility::func_4571());
	}

	return level.zmutils[param_00];
}

//Function Number: 396
loadzombiemapsettings(param_00)
{
	var_01 = "mp/zombieSettingsSwitchTable.csv";
	var_02 = 0;
	var_03 = 1;
	if(!tableexists(var_01))
	{
		return;
	}

	var_04 = tablelookup(var_01,var_02,param_00,var_03);
	if(!tableexists(var_04))
	{
		return;
	}

	var_05 = function_027A(var_04);
	var_06 = 0;
	var_07 = 1;
	for(var_08 = 0;var_08 < var_05;var_08++)
	{
		var_09 = tablelookupbyrow(var_04,var_08,var_06);
		var_0A = tablelookupbyrow(var_04,var_08,var_07);
		level.zmutils[var_09] = var_0A;
	}
}

//Function Number: 397
localtoworldcoords_actual(param_00)
{
	return transformmove(self.var_116,self.var_1D,(0,0,0),(0,0,0),param_00,(0,0,0))["origin"];
}

//Function Number: 398
monitor_stick_input()
{
	thread managelocationselect();
	self endon("stop_using_station");
	self endon("confirm_location");
	self endon("cancel_location");
	self endon("disconnect");
	self endon("begin_last_stand");
	self.rightstickinput = 0;
	self.leftstickinput = 0;
	for(;;)
	{
		self waittill("radio_tuning",var_00,var_01);
		self.rightstickinput = var_00;
		self.leftstickinput = var_01;
		wait 0.05;
	}
}

//Function Number: 399
managelocationselect()
{
	self method_8320("map_artillery_selector",1,0.01,1);
	common_scripts\utility::knock_off_battery("confirm_location","cancel_location","begin_last_stand","disconnect","death");
	self notify("stop_using_station");
	self.rightstickinput = undefined;
	self.leftstickinput = undefined;
	self method_8321();
}

//Function Number: 400
get_right_stick_input()
{
	return self.rightstickinput;
}

//Function Number: 401
get_left_stick_input()
{
	return self.leftstickinput;
}

//Function Number: 402
milesperhour_to_inchespersec(param_00)
{
	var_01 = param_00 * 17.6;
	return var_01;
}

//Function Number: 403
zombie_charge_tackle_thread(param_00,param_01)
{
	self endon("attack_hit");
	self endon("attack_miss");
	childthread tackle_thread(self,param_01,param_00);
}

//Function Number: 404
zombie_charge_set_smooth_turn_speed(param_00,param_01)
{
	var_08 = func_9A9E(360 * param_00) * 0.05;
	self method_85DE(var_08);
}

//Function Number: 405
zombie_charge_turn_smoothing_thread(param_00)
{
	var_01 = param_00.initial_turn_deg;
	var_02 = param_00.initial_turn_secs;
	var_03 = param_00.initial_turn_speed;
	self method_85E0(1);
	self method_839C("code_move");
	self scragentsetorientmode("face motion");
	if(var_02 > 0)
	{
		var_04 = var_01 / 360 * var_02;
		zombie_charge_set_smooth_turn_speed(var_04,param_00.debug_dvar);
		wait(var_02);
	}

	zombie_charge_set_smooth_turn_speed(var_03,param_00.debug_dvar);
}

//Function Number: 406
zombie_monitor_ignored_stalkee(param_00)
{
	param_00 endon("disconnect");
	while(!func_8B95(param_00))
	{
		wait(0.2);
	}

	param_00 notify("shouldBeIgnored");
}

//Function Number: 407
zombie_charge_run_to_player(param_00)
{
	var_01 = param_00.var_721C;
	var_01 endon("zombiesIgnoreMeChanged");
	var_01 endon("death");
	var_01 endon("disconnect");
	var_01 endon("begin_last_stand");
	var_02 = param_00.var_7462;
	var_03 = common_scripts\utility::func_3D5C(vectortoangles(var_02 - self.var_116));
	var_04 = 0;
	var_05 = 0;
	var_06 = undefined;
	var_07 = 0;
	self method_839C("anim deltas");
	self scragentsetorientmode("face angle abs",var_03);
	self method_839A(1,1);
	var_08 = param_00.react_state_name;
	var_04 = 0;
	var_09 = param_00.react_anim_rate;
	var_0A = 0;
	maps/mp/agents/_scripted_agent_anim_util::func_8415(var_08,var_04,var_09,var_0A);
	var_0B = self method_83D8(var_08,var_04);
	var_0C = maps/mp/agents/_scripted_agent_anim_util::getnotetracktimeinsecs(var_0B,"start_run") / var_09;
	self.end_roar_secs = gettime() / 1000 + var_0C;
	wait(var_0C);
	childthread zombie_charge_tackle_thread(var_01,param_00);
	if(isdefined(param_00.turn_smoothing_thread))
	{
		childthread [[ param_00.turn_smoothing_thread ]](param_00);
	}

	var_08 = param_00.run_state_name;
	var_09 = 1;
	maps/mp/agents/_scripted_agent_anim_util::func_8415(var_08,var_04,var_09,var_0A);
	var_0B = self method_83D8(param_00.stop_run_state_name,0);
	if(animhasnotetrack(var_0B,"attack"))
	{
		var_0D = maps/mp/agents/_scripted_agent_anim_util::getnotetracktimeinsecs(var_0B,"attack");
		var_0E = getmovedelta(var_0B,0,var_0D);
		var_0F = length(var_0E);
		var_10 = param_00.extra_lunge_radius;
		self.var_5F49 = var_0F + var_10;
	}

	var_11 = 0;
	var_12 = (0.7843137,0.4745098,0.2235294);
	var_13 = (0.1607843,0.3176471,0.6235294);
	var_14 = 0;
	var_15 = 0;
	var_16 = 0;
	while(!var_15)
	{
		wait 0.05;
		var_14 = var_14 + 0.05;
		var_17 = getclosestpointonnavmesh(var_01.var_116);
		param_00.var_5B2E = var_17;
		self method_8395(var_17);
		var_18 = param_00.trigger_lerp_deg;
		var_19 = param_00.trigger_nolerp_deg;
		var_1A = param_00.var_9DAA;
		var_1B = var_18 / 2;
		var_1C = var_19 / 2;
		var_1D = maps\mp\_utility::func_3B8E(self,var_01,var_1B);
		var_1E = maps\mp\_utility::func_3B8E(self,var_01,var_1C);
		if(var_1D || var_1E)
		{
			var_1F = distance2d(self.var_116,var_01.var_116) < var_1A;
			if(var_1F)
			{
				var_11 = var_1D;
				var_20 = (0,1,0);
				var_15 = 1;
			}

			continue;
		}

		var_24 = 1;
		var_25 = isdefined(self.var_5B55) && gettime() - self.var_5B55 < var_24 * 1000;
		if(var_14 > 1 && !var_25)
		{
			var_15 = 1;
		}
	}

	self.var_20DD = var_11;
	self notify("commence_attack!");
}

//Function Number: 408
zombie_charge_run(param_00)
{
	self.var_645E = param_00;
	var_01 = param_00.var_721C;
	var_02 = self.var_116;
	if(!isalive(var_01))
	{
		return;
	}

	self endon(param_00.end_notify);
	self.var_5542 = 1;
	self scragentsetscripted(1);
	self.var_1BB = 1;
	maps/mp/agents/_scripted_agent_anim_util::func_8732(1,param_00.scripted_state);
	childthread zombie_monitor_ignored_stalkee(var_01);
	childthread zombie_charge_run_to_player(param_00);
	if(isalive(var_01) && self.var_A4B == "zombie_heavy")
	{
		var_01 thread lib_054E::func_73B3();
	}

	var_03 = common_scripts\utility::func_A70E(var_01,"zombiesIgnoreMeChanged",var_01,"shouldBeIngored",var_01,"death",var_01,"disconnect",var_01,"begin_last_stand",self,"commence_attack!");
	var_04 = var_03[0];
	var_05 = var_03[1];
	var_06 = param_00.stop_run_state_name;
	var_07 = 1;
	var_08 = self method_83D8(param_00.stop_run_state_name,0);
	if(var_04 == "commence_attack!" && animhasnotetrack(var_08,"attack") && isdefined(var_01))
	{
		var_09 = 1;
		var_0A = undefined;
		var_0B = 0;
		maps/mp/agents/humanoid/_humanoid_melee::func_3107(var_01,var_01.var_116,var_06,self.var_20DD,var_0A,var_07,var_0B,var_09);
	}
	else
	{
		var_0C = 0.2;
		var_0D = gettime() / 1000;
		if(isdefined(self.end_roar_secs) && self.end_roar_secs > var_0D)
		{
			var_0C = self.end_roar_secs - var_0D;
		}

		wait(var_0C);
		var_0E = maps/mp/agents/_scripted_agent_anim_util::func_7A35(var_06);
		var_0F = self method_83D8(var_06,var_0E);
		var_10 = getanimlength(var_0F);
		self scragentsetorientmode("face angle abs",self.var_1D);
		self method_839C("anim deltas");
		maps/mp/agents/_scripted_agent_anim_util::func_8415(var_06,var_0E,var_07);
		wait(var_10);
	}

	self.var_20ED = 0;
}

//Function Number: 409
zombie_charge_cleanup(param_00)
{
	self scragentsetscripted(0);
	self method_85E0(0);
	self method_839F(func_9A9E(10));
	self method_839D("gravity");
	self.var_5542 = 0;
	self.var_64AB = undefined;
	maps/mp/agents/_scripted_agent_anim_util::func_8732(0,param_00.scripted_state);
	self notify(param_00.end_notify);
}

//Function Number: 410
getplayerddlzonename()
{
	var_00 = self;
	if(isdefined(var_00.var_295A))
	{
		return var_00.var_295A;
	}

	return "none";
}

//Function Number: 411
zmcreatesustainedholdent()
{
	var_00 = spawn("script_origin",self.var_116);
	var_00.var_28D5 = 0;
	var_00.var_A22B = 0;
	var_00.var_54F5 = 0;
	var_00 thread zmdeletesustainedholdent(self);
	return var_00;
}

//Function Number: 412
zmdeletesustainedholdent(param_00)
{
	self endon("death");
	param_00 waittill("death");
	self delete();
}

//Function Number: 413
zmsustainedholdthink(param_00,param_01,param_02)
{
	if(isplayer(param_00))
	{
		param_00 playerlinkto(self);
	}
	else
	{
		param_00 linkto(self);
	}

	param_00 common_scripts\utility::func_602();
	thread zmsustainedholdthinkplayerreset(param_00,param_02);
	self.var_28D5 = 0;
	self.var_54F5 = 1;
	self.var_A22B = 0;
	var_03 = zmsustainedholdthinkloop(param_00,param_01);
	if(!isdefined(self))
	{
		return 0;
	}

	self notify("useHoldThinkLoopDone");
	self.var_54F5 = 0;
	self.var_28D5 = 0;
	return var_03;
}

//Function Number: 414
zmsustainedholdthinkplayerreset(param_00,param_01)
{
	param_00 endon("death");
	var_02 = ["death","useHoldThinkLoopDone"];
	if(isdefined(param_01))
	{
		if(isarray(param_01))
		{
			var_02 = maps\mp\_utility::array_combine_no_dupes(var_02,param_01);
		}
		else
		{
			var_02[var_02.size] = param_01;
		}
	}

	var_03 = common_scripts\utility::func_A712(var_02);
	if(isalive(param_00))
	{
		param_00 common_scripts\utility::func_616();
		if(param_00 islinked())
		{
			param_00 unlink();
		}

		param_00.radial_interact_active = undefined;
		param_00 luinotifyeventextraplayer(&"stop_progressive_interact",0);
		param_00 luinotifyeventextraplayer(&"remove_progressive_interact",0);
	}
}

//Function Number: 415
zmsustainedholdthinkloop(param_00,param_01)
{
	var_02 = 0;
	while(isdefined(self) && maps\mp\_utility::func_57A0(param_00) && param_00 usebuttonpressed())
	{
		self.var_28D5 = self.var_28D5 + self.var_A22B * 50;
		if(!common_scripts\utility::func_562E(param_00.radial_interact_active))
		{
			param_00.radial_interact_active = 1;
		}

		if(!self.var_A22B)
		{
			self.var_A22B = 1;
		}

		var_03 = param_01 - self.var_28D5;
		if(var_03 <= 0)
		{
			return 1;
		}
		else if(!var_02)
		{
			var_02 = 1;
			param_00 luinotifyeventextraplayer(&"start_progressive_interact",1,var_03);
			param_00.radial_interact_active = undefined;
		}

		wait 0.05;
	}

	return 0;
}

//Function Number: 416
playerspawneroverrideset(param_00)
{
	level.zombies_active_spawn_event = param_00;
}

//Function Number: 417
playerspawneroverrideclear()
{
	level.zombies_active_spawn_event = undefined;
}

//Function Number: 418
zm_util_create_client_overlay(param_00,param_01,param_02,param_03)
{
	if(isdefined(param_02))
	{
		var_04 = newclienthudelem(param_02);
	}
	else
	{
		var_04 = newhudelem();
	}

	var_04.maxsightdistsqrd = 0;
	var_04.var_1D7 = 0;
	var_04 setshader(param_00,640,480);
	var_04.accuracy = "left";
	var_04.var_11 = "top";
	var_04.ignoreme = 1;
	var_04.var_C6 = "fullscreen";
	var_04.var_1CA = "fullscreen";
	var_04.var_18 = param_01;
	var_04.var_A0 = 1;
	if(isdefined(param_03))
	{
		var_04.var_56 = param_03;
	}

	return var_04;
}

//Function Number: 419
zm_util_overlayfade(param_00,param_01,param_02)
{
	var_03 = self;
	var_03 endon("death");
	wait(param_00);
	var_03 fadeovertime(param_01);
	var_03.var_18 = param_02;
	wait(param_01);
}

//Function Number: 420
zm_util_run_outro_for_player(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = self;
	var_06 endon("disconnect");
	var_06 method_8003();
	var_06 method_8322();
	var_06 setclientomnvar("ui_hide_hud",1);
	var_06.var_324E = 1;
	var_06 func_8A6D(1);
	if(isdefined(param_05))
	{
		var_06 method_8626(param_05);
	}

	var_07 = param_02;
	var_08 = "black";
	if(!isdefined(var_06.var_1781))
	{
		var_06.var_1781 = zm_util_create_client_overlay(var_08,0,var_06,(1,1,1));
	}

	var_09 = var_06.var_1781;
	var_09 setshader(var_08,640,480);
	var_09 thread zm_util_overlayfade(0,var_07,1);
	wait(var_07);
	var_09 thread zm_util_overlayfade(0,var_07,0);
	function_0290(var_06,param_00,param_03,param_04);
	var_09 thread zm_util_overlayfade(param_01 - var_07,var_07,1);
	wait(param_01);
	function_0292(var_06);
	var_09 thread zm_util_overlayfade(0,var_07,0);
	var_06 method_8004();
	var_06 method_8323();
	var_06 setclientomnvar("ui_hide_hud",0);
	var_06.var_324E = 0;
	var_06 func_8A6D(0);
	if(isdefined(param_05))
	{
		var_06 method_8627(param_05);
	}
}

//Function Number: 421
zm_util_run_outro(param_00,param_01,param_02,param_03,param_04,param_05)
{
	level.var_AC21 = 1;
	if(!isdefined(param_03))
	{
		param_03 = 1;
	}

	if(!isdefined(param_04))
	{
		param_04 = 0;
	}

	if(!isdefined(param_02))
	{
		param_02 = 0.5;
	}

	foreach(var_07 in level.var_744A)
	{
		var_07 thread zm_util_run_outro_for_player(param_00,param_01,param_02,param_03,param_04,param_05);
	}

	wait(param_01 + param_02);
	level notify("outro_cinematic_finished");
	level.var_AC21 = 0;
}

//Function Number: 422
solo_challenge_safety_think()
{
	while(!isdefined(level.var_744A))
	{
		wait 0.05;
	}

	for(;;)
	{
		wait(1);
		if(level.var_744A.size == 0)
		{
			continue;
		}

		if(level.var_744A.size > 1)
		{
			level notify("zmb_solo_hc_challenges_invalid");
		}
	}
}

//Function Number: 423
solo_challenge_kill_think(param_00)
{
	level waittill("zmb_solo_hc_challenges_invalid");
	level notify(param_00);
}

//Function Number: 424
player_validate_is_in_zones(param_00)
{
	var_01 = get_volumes_by_targetname_array(param_00);
	var_02 = self;
	foreach(var_04 in var_01)
	{
		if(var_02 istouching(var_04))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 425
get_volumes_by_targetname_array(param_00)
{
	var_01 = [];
	foreach(var_03 in param_00)
	{
		var_04 = getentarray(var_03,"targetname");
		var_01 = common_scripts\utility::func_F73(var_04,var_01);
	}

	return var_01;
}

//Function Number: 426
zm_get_weapon_class(param_00)
{
	return maps\mp\_utility::func_472A(zombies_to_mp(param_00),1);
}

//Function Number: 427
zombies_to_mp(param_00)
{
	if(issubstr(param_00,"_pap"))
	{
		param_00 = function_0337(param_00,"_pap");
	}

	param_00 = maps\mp\_utility::func_9472(param_00,"_zm");
	param_00 = maps\mp\_utility::func_9472(param_00,"_mp");
	param_00 = param_00 + "_mp";
	return param_00;
}

//Function Number: 428
mp_to_zombies(param_00)
{
	if(issubstr(param_00,"_pap"))
	{
		param_00 = function_0337(param_00,"_pap");
	}

	param_00 = maps\mp\_utility::func_9472(param_00,"_zm");
	param_00 = maps\mp\_utility::func_9472(param_00,"_mp");
	param_00 = param_00 + "_zm";
	return param_00;
}

//Function Number: 429
obj_fall_onto_pos(param_00)
{
	self endon("entitydeleted");
	var_01 = param_00 - self.var_116;
	var_02 = sqrt(abs(var_01[2] * 2 / 800));
	var_03 = 1 / var_02;
	var_04 = var_01 * (var_03,var_03,0);
	self gravitymove(var_04,var_02);
	wait(var_02);
	self.var_116 = param_00;
}

//Function Number: 430
obj_fall_to_ent_location(param_00)
{
	var_01 = param_00.var_116 - self.var_116;
	var_02 = sqrt(abs(var_01[2] * 2 / 800));
	var_03 = 1 / var_02;
	var_04 = var_01 * (var_03,var_03,0);
	self gravitymove(var_04,var_02);
	self rotateto(param_00.var_1D,var_02,0,var_02);
	wait(var_02);
	self.var_116 = param_00.var_116;
}

//Function Number: 431
set_player_cinematic_mode(param_00,param_01)
{
	var_02 = self;
	var_02 endon("disconnect");
	var_02.incinematicmode = 1;
	if(common_scripts\utility::func_562E(param_00))
	{
		var_02 method_8003();
		var_02 method_8322();
	}

	var_02 method_812B(0);
	var_02 method_848D();
	var_02 setclientomnvar("ui_hide_hud",1);
	if(isdefined(param_01))
	{
		var_02 method_8626(param_01);
	}

	var_02.var_324E = 1;
	var_02 func_8A6D(1);
	var_02 freezecontrols(1);
}

//Function Number: 432
unset_player_cinematic_mode(param_00,param_01)
{
	var_02 = self;
	var_02 unlink();
	var_02 method_81E3();
	var_02 method_848C();
	var_02.incinematicmode = 0;
	if(common_scripts\utility::func_562E(param_00))
	{
		var_02 setorigin(getclosestpointonnavmesh(var_02.var_116));
		var_02 method_8004();
		var_02 method_8323();
	}

	var_02 method_812B(1);
	var_02 setclientomnvar("ui_hide_hud",0);
	var_02 freezecontrols(0);
	if(isdefined(param_01))
	{
		var_02 method_8627(param_01);
	}

	var_02.var_324E = 0;
	var_02 func_8A6D(0);
}

//Function Number: 433
init_damageable_script_model()
{
	self setcandamage(1);
	if(isdefined(self.var_29B5))
	{
		return;
	}

	self setdamagecallbackon(1);
	self.var_29B5 = ::damageable_script_model_ondamage;
}

//Function Number: 434
cleanup_damageable_script_model()
{
	self setcandamage(0);
	self.var_29B5 = undefined;
}

//Function Number: 435
damageable_script_model_ondamage(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B)
{
	if(isdefined(param_04) && maps\mp\_utility::func_5755(param_04) && !common_scripts\utility::func_562E(self.delayedmeleedamagewrapper))
	{
		thread damageable_script_model_delayed_damage(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B);
		return;
	}

	self finishentitydamage(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B);
}

//Function Number: 436
damageable_script_model_delayed_damage(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B)
{
	wait(0);
	self.delayedmeleedamagewrapper = 1;
	self dodamage(param_02,param_06,param_01,param_00,param_04,param_05,param_08);
	self.delayedmeleedamagewrapper = undefined;
}

//Function Number: 437
get_closest_spawn_by_type(param_00,param_01)
{
	var_02 = common_scripts\utility::func_46B7("zombie_spawner","script_noteworthy");
	var_03 = common_scripts\utility::func_40B0(param_00,var_02);
	foreach(var_05 in var_03)
	{
		if(!isdefined(var_05.var_8260) || issubstr(var_05.var_8260,param_01))
		{
			return var_05;
		}
	}
}

//Function Number: 438
force_use_hint_on(param_00,param_01)
{
	var_02 = self;
	if(!isdefined(param_01))
	{
		param_01 = "force_use_hint_on";
	}

	self.forceusehintreason = param_01;
	var_02 forceusehinton(param_00);
}

//Function Number: 439
force_use_hint_off(param_00)
{
	var_01 = self;
	if(!isdefined(param_00))
	{
		param_00 = "force_use_hint_on";
	}

	self.forceusehintreason = undefined;
	var_01 forceusehintoff();
}

//Function Number: 440
add_zombie_stun(param_00,param_01)
{
	if(!isdefined(self.zombiestuns))
	{
		self.zombiestuns = [];
	}

	self.zombiestuns[param_00] = param_01;
	self notify("zombie_stunned");
}

//Function Number: 441
remove_zombie_stun(param_00)
{
	if(isdefined(self.zombiestuns))
	{
		self.zombiestuns[param_00] = undefined;
	}
}

//Function Number: 442
is_zombie_stunned()
{
	if(lib_053A::func_AC2A())
	{
		return 1;
	}

	if(isdefined(self.zombiestuns))
	{
		return self.zombiestuns.size > 0;
	}

	return 0;
}

//Function Number: 443
can_pair_melee()
{
	var_00 = self;
	if(var_00 maps/mp/agents/_scripted_agent_anim_util::func_57E2())
	{
		return 0;
	}

	return 1;
}

//Function Number: 444
razergunmaxammo()
{
	var_00 = self;
	var_01 = "razergun";
	var_02 = var_00 getweaponslistall();
	foreach(var_04 in var_02)
	{
		if(isdefined(var_04) && issubstr(var_04,var_01))
		{
			var_00 givemaxammo(var_04);
			var_05 = weaponclipsize(var_04);
			var_00 method_82FA(var_04,var_05);
		}
	}
}

//Function Number: 445
zombie_shattered_get_map_number(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = maps\mp\_utility::func_4571();
	}

	var_01 = 0;
	if(tableexists("mp/zombieDLC3MapInfoTable.csv") && function_027A("mp/zombieDLC3MapInfoTable.csv") > 0)
	{
		var_02 = tablelookup("mp/zombieDLC3MapInfoTable.csv",0,param_00,1);
		if(isdefined(var_02) && var_02 != "")
		{
			var_01 = int(var_02);
		}
	}

	return var_01;
}

//Function Number: 446
is_zm_shattered_thule_map(param_00)
{
	var_01 = zombie_shattered_get_map_number(param_00);
	if(var_01 == 3)
	{
		return 1;
	}

	return 0;
}

//Function Number: 447
is_zm_shattered_dnk_map(param_00)
{
	var_01 = zombie_shattered_get_map_number(param_00);
	if(var_01 == 2)
	{
		return 1;
	}

	return 0;
}

//Function Number: 448
is_zm_shattered_windmill_map(param_00)
{
	var_01 = zombie_shattered_get_map_number(param_00);
	if(var_01 == 1)
	{
		return 1;
	}

	return 0;
}

//Function Number: 449
is_wet_zombie(param_00,param_01,param_02,param_03)
{
	return issubstr(param_01.var_106,"_wet_");
}

//Function Number: 450
is_jack_box(param_00,param_01,param_02,param_03)
{
	return issubstr(param_02,"jack_in_box");
}

//Function Number: 451
remove_wallbuys_from_box()
{
	var_00 = common_scripts\utility::func_46B7("wallbuy","targetname");
	var_01 = [];
	foreach(var_03 in var_00)
	{
		if(!isdefined(var_03.var_165))
		{
			continue;
		}

		var_01 = common_scripts\utility::func_F6F(var_01,var_03.var_165);
	}

	foreach(var_06 in var_01)
	{
		maps\mp\zombies\_zombies_magicbox::func_7CEA(var_06);
	}
}

//Function Number: 452
is_solo()
{
	if(level.var_744A.size == 1)
	{
		return 1;
	}

	return 0;
}