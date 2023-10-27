/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\killstreaks\_airdrop.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 112
 * Decompile Time: 5067 ms
 * Timestamp: 10/27/2023 12:28:06 AM
*******************************************************************/

//Function Number: 1
init()
{
	level._effect["airdrop_crate_destroy"] = loadfx("vfx/iw7/core/mp/killstreaks/vfx_dp_pickup_dust.vfx");
	level._effect["airdrop_dust_kickup"] = loadfx("vfx/iw7/core/mp/killstreaks/vfx_dp_pickup_dust.vfx");
	level._effect["drone_explode"] = loadfx("vfx/iw7/core/mp/killstreaks/vfx_dp_exp.vfx");
	level._effect["crate_explode"] = loadfx("vfx/iw7/_requests/mp/killstreak/vfx_drone_pkg_exp_vari.vfx");
	precachempanim("juggernaut_carepackage");
	func_F638("airdrop_crate");
	func_F638("care_package");
	scripts\mp\killstreaks\_killstreaks::func_DEFB("dronedrop",::func_1AA2,undefined,undefined,::func_1288F,undefined,::func_1A9F);
	var_00 = ["passive_bomb_trap","passive_decreased_cost","passive_increased_cost","passive_reroll","passive_high_roller","passive_low_roller"];
	scripts\mp\_killstreak_loot::func_DF07("dronedrop",var_00);
	level.var_C223 = 0;
	level.var_AD8B = [];
	level.var_4860 = [];
	level.var_4855 = [];
	func_17BF("dronedrop","venom",85,::func_A693,"care_package_iw7_un_wm","care_package_iw7_ca_wm",&"KILLSTREAKS_HINTS_VENOM_PICKUP",undefined,"care_package_iw7_dummy");
	func_17BF("dronedrop","uav",85,::func_A693,"care_package_iw7_un_wm","care_package_iw7_ca_wm",&"KILLSTREAKS_HINTS_UAV_PICKUP",undefined,"care_package_iw7_dummy");
	func_17BF("dronedrop","counter_uav",70,::func_A693,"care_package_iw7_un_wm","care_package_iw7_ca_wm",&"KILLSTREAKS_HINTS_COUNTER_UAV_PICKUP",undefined,"care_package_iw7_dummy");
	func_17BF("dronedrop","drone_hive",70,::func_A693,"care_package_iw7_un_wm","care_package_iw7_ca_wm",&"KILLSTREAKS_HINTS_ORBITAL_DEPLOYMENT_PICKUP",undefined,"care_package_iw7_dummy");
	func_17BF("dronedrop","ball_drone_backup",65,::func_A693,"care_package_iw7_un_wm","care_package_iw7_ca_wm",&"KILLSTREAKS_HINTS_BALL_DRONE_BACKUP_PICKUP",undefined,"care_package_iw7_dummy");
	func_17BF("dronedrop","bombardment",65,::func_A693,"care_package_iw7_un_wm","care_package_iw7_ca_wm",&"KILLSTREAKS_HINTS_BOMBARDMENT_PICKUP",undefined,"care_package_iw7_dummy");
	func_17BF("dronedrop","precision_airstrike",65,::func_A693,"care_package_iw7_un_wm","care_package_iw7_ca_wm",&"KILLSTREAKS_HINTS_PRECISION_AIRSTRIKE_PICKUP",undefined,"care_package_iw7_dummy");
	func_17BF("dronedrop","sentry_shock",45,::func_A693,"care_package_iw7_un_wm","care_package_iw7_ca_wm",&"KILLSTREAKS_HINTS_SENTRY_SHOCK_PICKUP",undefined,"care_package_iw7_dummy");
	func_17BF("dronedrop","jackal",25,::func_A693,"care_package_iw7_un_wm","care_package_iw7_ca_wm",&"KILLSTREAKS_HINTS_JACKAL_PICKUP",undefined,"care_package_iw7_dummy");
	func_17BF("dronedrop","thor",10,::func_A693,"care_package_iw7_un_wm","care_package_iw7_ca_wm",&"KILLSTREAKS_HINTS_THOR_PICKUP",undefined,"care_package_iw7_dummy");
	func_17BF("dronedrop","directional_uav",5,::func_A693,"care_package_iw7_un_wm","care_package_iw7_ca_wm",&"KILLSTREAKS_HINTS_DIRECTIONAL_UAV_PICKUP",undefined,"care_package_iw7_dummy");
	func_17BF("dronedrop","remote_c8",5,::func_A693,"care_package_iw7_un_wm","care_package_iw7_ca_wm",&"KILLSTREAKS_HINTS_RC8_PICKUP",undefined,"care_package_iw7_dummy");
	func_17BF("dronedrop","minijackal",5,::func_A693,"care_package_iw7_un_wm","care_package_iw7_ca_wm",&"KILLSTREAKS_HINTS_MINI_JACKAL_PICKUP",undefined,"care_package_iw7_dummy");
	func_17BF("dronedrop_grnd","venom",35,::func_A693,"care_package_iw7_un_wm","care_package_iw7_ca_wm",&"KILLSTREAKS_HINTS_VENOM_PICKUP",undefined,"care_package_iw7_dummy");
	func_17BF("dronedrop_grnd","uav",30,::func_A693,"care_package_iw7_un_wm","care_package_iw7_ca_wm",&"KILLSTREAKS_HINTS_UAV_PICKUP",undefined,"care_package_iw7_dummy");
	func_17BF("dronedrop_grnd","counter_uav",25,::func_A693,"care_package_iw7_un_wm","care_package_iw7_ca_wm",&"KILLSTREAKS_HINTS_COUNTER_UAV_PICKUP",undefined,"care_package_iw7_dummy");
	func_17BF("dronedrop_grnd","drone_hive",25,::func_A693,"care_package_iw7_un_wm","care_package_iw7_ca_wm",&"KILLSTREAKS_HINTS_ORBITAL_DEPLOYMENT_PICKUP",undefined,"care_package_iw7_dummy");
	func_17BF("dronedrop_grnd","ball_drone_backup",25,::func_A693,"care_package_iw7_un_wm","care_package_iw7_ca_wm",&"KILLSTREAKS_HINTS_BALL_DRONE_BACKUP_PICKUP",undefined,"care_package_iw7_dummy");
	func_17BF("dronedrop_grnd","bombardment",20,::func_A693,"care_package_iw7_un_wm","care_package_iw7_ca_wm",&"KILLSTREAKS_HINTS_BOMBARDMENT_PICKUP",undefined,"care_package_iw7_dummy");
	func_17BF("dronedrop_grnd","precision_airstrike",20,::func_A693,"care_package_iw7_un_wm","care_package_iw7_ca_wm",&"KILLSTREAKS_HINTS_PRECISION_AIRSTRIKE_PICKUP",undefined,"care_package_iw7_dummy");
	func_17BF("dronedrop_grnd","sentry_shock",15,::func_A693,"care_package_iw7_un_wm","care_package_iw7_ca_wm",&"KILLSTREAKS_HINTS_SENTRY_SHOCK_PICKUP",undefined,"care_package_iw7_dummy");
	func_17BF("dronedrop_trap","bomb_trap",100,::killstreakbombcratethink,"care_package_iw7_un_wm","care_package_iw7_ca_wm",undefined,undefined,"care_package_iw7_dummy");
	func_17BF("dronedrop_reroll","venom",85,::func_A693,"care_package_iw7_un_wm","care_package_iw7_ca_wm",undefined,&"KILLSTREAKS_HINTS_VENOM_REROLL","care_package_iw7_dummy");
	func_17BF("dronedrop_reroll","uav",85,::func_A693,"care_package_iw7_un_wm","care_package_iw7_ca_wm",undefined,&"KILLSTREAKS_HINTS_UAV_REROLL","care_package_iw7_dummy");
	func_17BF("dronedrop_reroll","counter_uav",70,::func_A693,"care_package_iw7_un_wm","care_package_iw7_ca_wm",undefined,&"KILLSTREAKS_HINTS_COUNTER_UAV_REROLL","care_package_iw7_dummy");
	func_17BF("dronedrop_reroll","drone_hive",70,::func_A693,"care_package_iw7_un_wm","care_package_iw7_ca_wm",undefined,&"KILLSTREAKS_HINTS_ORBITAL_DEPLOYMENT_REROLL","care_package_iw7_dummy");
	func_17BF("dronedrop_reroll","ball_drone_backup",65,::func_A693,"care_package_iw7_un_wm","care_package_iw7_ca_wm",undefined,&"KILLSTREAKS_HINTS_BALL_DRONE_BACKUP_REROLL","care_package_iw7_dummy");
	func_17BF("dronedrop_reroll","bombardment",65,::func_A693,"care_package_iw7_un_wm","care_package_iw7_ca_wm",undefined,&"KILLSTREAKS_HINTS_BOMBARDMENT_REROLL","care_package_iw7_dummy");
	func_17BF("dronedrop_reroll","precision_airstrike",65,::func_A693,"care_package_iw7_un_wm","care_package_iw7_ca_wm",undefined,&"KILLSTREAKS_HINTS_PRECISION_AIRSTRIKE_REROLL","care_package_iw7_dummy");
	func_17BF("dronedrop_reroll","sentry_shock",5,::func_A693,"care_package_iw7_un_wm","care_package_iw7_ca_wm",undefined,&"KILLSTREAKS_HINTS_SENTRY_SHOCK_REROLL","care_package_iw7_dummy");
	func_17BF("dronedrop_reroll","jackal",5,::func_A693,"care_package_iw7_un_wm","care_package_iw7_ca_wm",undefined,&"KILLSTREAKS_HINTS_JACKAL_REROLL","care_package_iw7_dummy");
	func_17BF("dronedrop_reroll","thor",5,::func_A693,"care_package_iw7_un_wm","care_package_iw7_ca_wm",undefined,&"KILLSTREAKS_HINTS_THOR_REROLL","care_package_iw7_dummy");
	func_17BF("dronedrop_reroll","directional_uav",1,::func_A693,"care_package_iw7_un_wm","care_package_iw7_ca_wm",undefined,&"KILLSTREAKS_HINTS_DIRECTIONAL_UAV_REROLL","care_package_iw7_dummy");
	func_17BF("dronedrop_reroll","remote_c8",1,::func_A693,"care_package_iw7_un_wm","care_package_iw7_ca_wm",undefined,&"KILLSTREAKS_HINTS_RC8_REROLL","care_package_iw7_dummy");
	func_17BF("dronedrop_reroll","minijackal",1,::func_A693,"care_package_iw7_un_wm","care_package_iw7_ca_wm",undefined,&"KILLSTREAKS_HINTS_MINI_JACKAL_REROLL","care_package_iw7_dummy");
	func_17BF("dronedrop_highroll","sentry_shock",15,::func_A693,"care_package_iw7_un_wm","care_package_iw7_ca_wm",&"KILLSTREAKS_HINTS_SENTRY_SHOCK_PICKUP",undefined,"care_package_iw7_dummy");
	func_17BF("dronedrop_highroll","jackal",15,::func_A693,"care_package_iw7_un_wm","care_package_iw7_ca_wm",&"KILLSTREAKS_HINTS_JACKAL_PICKUP",undefined,"care_package_iw7_dummy");
	func_17BF("dronedrop_highroll","thor",10,::func_A693,"care_package_iw7_un_wm","care_package_iw7_ca_wm",&"KILLSTREAKS_HINTS_THOR_PICKUP",undefined,"care_package_iw7_dummy");
	func_17BF("dronedrop_highroll","directional_uav",10,::func_A693,"care_package_iw7_un_wm","care_package_iw7_ca_wm",&"KILLSTREAKS_HINTS_DIRECTIONAL_UAV_PICKUP",undefined,"care_package_iw7_dummy");
	func_17BF("dronedrop_highroll","remote_c8",5,::func_A693,"care_package_iw7_un_wm","care_package_iw7_ca_wm",&"KILLSTREAKS_HINTS_RC8_PICKUP",undefined,"care_package_iw7_dummy");
	func_17BF("dronedrop_highroll","minijackal",5,::func_A693,"care_package_iw7_un_wm","care_package_iw7_ca_wm",&"KILLSTREAKS_HINTS_MINI_JACKAL_PICKUP",undefined,"care_package_iw7_dummy");
	func_17BF("jackaldrop","venom",85,::func_A693,"care_package_iw7_un_wm","care_package_iw7_ca_wm",&"KILLSTREAKS_HINTS_VENOM_PICKUP",undefined,"care_package_iw7_dummy");
	func_17BF("jackaldrop","uav",85,::func_A693,"care_package_iw7_un_wm","care_package_iw7_ca_wm",&"KILLSTREAKS_HINTS_UAV_PICKUP",undefined,"care_package_iw7_dummy");
	func_17BF("jackaldrop","counter_uav",70,::func_A693,"care_package_iw7_un_wm","care_package_iw7_ca_wm",&"KILLSTREAKS_HINTS_COUNTER_UAV_PICKUP",undefined,"care_package_iw7_dummy");
	func_17BF("jackaldrop","drone_hive",70,::func_A693,"care_package_iw7_un_wm","care_package_iw7_ca_wm",&"KILLSTREAKS_HINTS_ORBITAL_DEPLOYMENT_PICKUP",undefined,"care_package_iw7_dummy");
	func_17BF("jackaldrop","ball_drone_backup",65,::func_A693,"care_package_iw7_un_wm","care_package_iw7_ca_wm",&"KILLSTREAKS_HINTS_BALL_DRONE_BACKUP_PICKUP",undefined,"care_package_iw7_dummy");
	func_17BF("jackaldrop","bombardment",65,::func_A693,"care_package_iw7_un_wm","care_package_iw7_ca_wm",&"KILLSTREAKS_HINTS_BOMBARDMENT_PICKUP",undefined,"care_package_iw7_dummy");
	func_17BF("jackaldrop","precision_airstrike",65,::func_A693,"care_package_iw7_un_wm","care_package_iw7_ca_wm",&"KILLSTREAKS_HINTS_PRECISION_AIRSTRIKE_PICKUP",undefined,"care_package_iw7_dummy");
	func_17BF("jackaldrop","sentry_shock",5,::func_A693,"care_package_iw7_un_wm","care_package_iw7_ca_wm",&"KILLSTREAKS_HINTS_SENTRY_SHOCK_PICKUP",undefined,"care_package_iw7_dummy");
	func_17BF("jackaldrop","jackal",5,::func_A693,"care_package_iw7_un_wm","care_package_iw7_ca_wm",&"KILLSTREAKS_HINTS_JACKAL_PICKUP",undefined,"care_package_iw7_dummy");
	func_17BF("jackaldrop","thor",5,::func_A693,"care_package_iw7_un_wm","care_package_iw7_ca_wm",&"KILLSTREAKS_HINTS_THOR_PICKUP",undefined,"care_package_iw7_dummy");
	func_17BF("jackaldrop","directional_uav",1,::func_A693,"care_package_iw7_un_wm","care_package_iw7_ca_wm",&"KILLSTREAKS_HINTS_DIRECTIONAL_UAV_PICKUP",undefined,"care_package_iw7_dummy");
	func_17BF("jackaldrop","remote_c8",1,::func_A693,"care_package_iw7_un_wm","care_package_iw7_ca_wm",&"KILLSTREAKS_HINTS_RC8_PICKUP",undefined,"care_package_iw7_dummy");
	func_17BF("jackaldrop","minijackal",1,::func_A693,"care_package_iw7_un_wm","care_package_iw7_ca_wm",&"KILLSTREAKS_HINTS_MINI_JACKAL_PICKUP",undefined,"care_package_iw7_dummy");
	if(isdefined(level.var_4C85))
	{
		[[ level.var_4C85 ]]("care_package_iw7_un_wm","care_package_iw7_ca_wm");
	}

	if(isdefined(level.var_B330))
	{
		[[ level.var_B330 ]]();
	}

	func_7730();
	var_01 = spawnstruct();
	var_01.var_EC44 = "destroyed_airdrop";
	var_01.var_13523 = "dronedrop_destroyed";
	var_01.var_3774 = "callout_destroyed_airdrop";
	var_01.var_EB11 = 0.09;
	level.var_8DA6["airdrop"] = var_01;
	scripts\mp\_rank::func_DF0A("little_bird","value",200);
	level func_FA9A();
	level.var_3A58 = getentarray("carepackage_drop_area","targetname");
}

//Function Number: 2
func_7730()
{
	foreach(var_06, var_01 in level.var_4860)
	{
		level.var_4855[var_06] = 0;
		foreach(var_03 in var_01)
		{
			var_04 = var_03.type;
			if(!level.var_4860[var_06][var_04].var_DCEC)
			{
				level.var_4860[var_06][var_04].var_13CE8 = level.var_4860[var_06][var_04].var_DCEC;
				continue;
			}

			level.var_4855[var_06] = level.var_4855[var_06] + level.var_4860[var_06][var_04].var_DCEC;
			level.var_4860[var_06][var_04].var_13CE8 = level.var_4855[var_06];
		}
	}
}

//Function Number: 3
func_3C54(param_00,param_01,param_02)
{
	if(!isdefined(level.var_4860[param_00]) || !isdefined(level.var_4860[param_00][param_01]))
	{
		return;
	}

	level.var_4860[param_00][param_01].var_DCEC = param_02;
	func_7730();
}

//Function Number: 4
func_F638(param_00)
{
	var_01 = getentarray(param_00,"targetname");
	if(!isdefined(var_01) || var_01.size == 0)
	{
		return;
	}

	level.var_1A9B = getent(var_01[0].target,"targetname");
	foreach(var_03 in var_01)
	{
		var_03 func_51AA();
	}
}

//Function Number: 5
func_17BF(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	if(!isdefined(param_04))
	{
		param_04 = "care_package_iw7_un_wm";
	}

	if(!isdefined(param_05))
	{
		param_05 = "care_package_iw7_ca_wm";
	}

	if(!isdefined(param_08))
	{
		param_08 = "care_package_iw7_dummy";
	}

	level.var_4860[param_00][param_01] = spawnstruct();
	level.var_4860[param_00][param_01].var_5EF1 = param_00;
	level.var_4860[param_00][param_01].type = param_01;
	level.var_4860[param_00][param_01].var_DCEC = param_02;
	level.var_4860[param_00][param_01].var_13CE8 = param_02;
	level.var_4860[param_00][param_01].var_74C2 = param_03;
	level.var_4860[param_00][param_01].var_B916 = param_04;
	level.var_4860[param_00][param_01].var_B915 = param_05;
	level.var_4860[param_00][param_01].var_B914 = param_08;
	if(isdefined(param_06))
	{
		game["strings"][param_01 + "_hint"] = param_06;
	}

	if(isdefined(param_07))
	{
		game["strings"][param_01 + "_rerollHint"] = param_07;
	}
}

//Function Number: 6
func_80B6(param_00)
{
	var_01 = randomint(level.var_4855[param_00]);
	var_02 = undefined;
	foreach(var_04 in level.var_4860[param_00])
	{
		var_05 = var_04.type;
		if(!level.var_4860[param_00][var_05].var_13CE8)
		{
			continue;
		}

		var_02 = var_05;
		if(level.var_4860[param_00][var_05].var_13CE8 > var_01)
		{
			break;
		}
	}

	return var_02;
}

//Function Number: 7
func_7E43(param_00)
{
	switch(param_00)
	{
		case "airdrop_sentry_minigun":
			return "sentry";

		case "airdrop_predator_missile":
			return "predator_missile";

		case "airdrop_juggernaut":
			return "airdrop_juggernaut";

		case "airdrop_juggernaut_def":
			return "airdrop_juggernaut_def";

		case "airdrop_juggernaut_gl":
			return "airdrop_juggernaut_gl";

		case "airdrop_juggernaut_recon":
			return "airdrop_juggernaut_recon";

		case "airdrop_juggernaut_maniac":
			return "airdrop_juggernaut_maniac";

		case "airdrop_remote_tank":
			return "remote_tank";

		case "airdrop_lase":
			return "lasedStrike";

		case "dronedrop_trap":
			return "bomb_trap";

		case "airdrop_sotf":
		case "airdrop_grnd_mega":
		case "airdrop_grnd":
		case "airdrop_mega":
		case "airdrop_escort":
		case "airdrop_support":
		case "dronedrop_highroll":
		case "jackaldrop":
		case "dronedrop_reroll":
		case "dronedrop_grnd":
		case "airdrop_assault":
		case "airdrop":
		case "dronedrop":
		default:
			if(isdefined(level.var_80B7))
			{
				return [[ level.var_80B7 ]](param_00);
			}
			return func_80B6(param_00);
	}
}

//Function Number: 8
func_1288F(param_00)
{
	var_01 = param_00.var_110EA;
	var_02 = var_01;
	var_03 = undefined;
	if(!isdefined(var_02))
	{
		var_02 = "airdrop";
	}

	var_04 = 1;
	if((level.var_AD8B.size >= 4 || level.var_6BAA >= 4) && var_02 != "airdrop_mega" && !issubstr(tolower(var_02),"juggernaut"))
	{
		scripts\mp\_hud_message::func_10122("KILLSTREAKS_AIR_SPACE_TOO_CROWDED");
		return 0;
	}
	else if(scripts\mp\_utility::func_4BD7() >= scripts\mp\_utility::func_B4D2() || level.var_6BAA + var_04 >= scripts\mp\_utility::func_B4D2())
	{
		scripts\mp\_hud_message::func_10122("KILLSTREAKS_TOO_MANY_VEHICLES");
		return 0;
	}
	else if(var_02 == "airdrop_lase" && isdefined(level.var_A85F) && level.var_A85F)
	{
		scripts\mp\_hud_message::func_10122("KILLSTREAKS_AIR_SPACE_TOO_CROWDED");
		return 0;
	}

	return 1;
}

//Function Number: 9
func_1AA2(param_00)
{
	param_00.var_1AA0 = param_00.var_110EA;
	scripts\mp\_utility::func_93FA();
	var_01 = scripts\mp\killstreaks\_target_marker::func_819B(param_00);
	if(!isdefined(var_01.var_AEC4))
	{
		scripts\mp\_utility::func_4FC1();
		return 0;
	}

	scripts\mp\_matchdata::func_AFC9(param_00.var_1AA0,self.origin);
	func_1AA1(var_01,param_00.var_1AA0,param_00);
	return 1;
}

//Function Number: 10
func_1AA1(param_00,param_01,param_02)
{
	switch(param_01)
	{
		case "dronedrop":
			level func_581F(self,param_00,randomfloat(360),param_01,param_02);
			break;
	}
}

//Function Number: 11
func_1A9E(param_00,param_01)
{
	param_01 thread func_1A9C();
	param_01.var_222 = self;
	param_00.var_1AA0 = param_00.var_110EA;
	scripts\mp\_utility::func_93FA();
	thread func_4FC3();
	param_01 thread func_1A9D(param_00.var_1AA0);
	scripts\mp\_matchdata::func_AFC9(param_00.var_1AA0,self.origin);
	param_00.var_1A9E = 1;
	return 1;
}

//Function Number: 12
func_1A9D(param_00,param_01)
{
	level endon("game_ended");
	self notify("airDropMarkerActivate");
	self endon("airDropMarkerActivate");
	self waittill("explode",var_02);
	var_03 = self.var_222;
	if(!isdefined(var_03))
	{
		return;
	}

	if(var_03 scripts\mp\_utility::func_9E68())
	{
		return;
	}

	if(issubstr(tolower(param_00),"escort_airdrop") && isdefined(level.var_3F14))
	{
		return;
	}

	wait(0.05);
	if(issubstr(tolower(param_00),"juggernaut"))
	{
		level func_57EF(var_03,var_02,randomfloat(360),param_00);
		return;
	}

	if(issubstr(tolower(param_00),"escort_airdrop"))
	{
		var_03 scripts\mp\killstreaks\_escortairdrop::func_6CE4(param_01,var_02,randomfloat(360),"escort_airdrop");
		return;
	}

	if(param_00 == "dronedrop")
	{
		level func_581F(var_03,var_02,randomfloat(360),param_00);
		return;
	}

	level func_5857(var_03,var_02,randomfloat(360),param_00);
}

//Function Number: 13
func_1A9F(param_00)
{
	if(isdefined(param_00.var_1AA0) && !issubstr(param_00.var_1AA0,"juggernaut") && !scripts\mp\_utility::func_9FB3(param_00.var_1A9E))
	{
		scripts\mp\_utility::func_4FC1();
	}
}

//Function Number: 14
func_4FC3()
{
	self endon("airDropMarkerActivate");
	self waittill("death");
	scripts\mp\_utility::func_4FC1();
}

//Function Number: 15
func_97C4()
{
	self.var_9B04 = 0;
	self hide();
	if(isdefined(self.target))
	{
		self.var_4381 = getent(self.target,"targetname");
		self.var_4381 notsolid();
		return;
	}

	self.var_4381 = undefined;
}

//Function Number: 16
func_51C5(param_00)
{
	wait(0.25);
	self linkto(param_00,"tag_origin",(0,0,0),(0,0,0));
	param_00 waittill("death");
	self delete();
}

//Function Number: 17
func_485E()
{
	self endon("death");
	self hide();
	foreach(var_01 in level.players)
	{
		if(var_01.team != "spectator")
		{
			self showtoplayer(var_01);
		}
	}

	for(;;)
	{
		level waittill("joined_team");
		self hide();
		foreach(var_01 in level.players)
		{
			if(var_01.team != "spectator")
			{
				self showtoplayer(var_01);
			}
		}
	}
}

//Function Number: 18
func_4858(param_00)
{
	self endon("death");
	self hide();
	foreach(var_02 in level.players)
	{
		if(var_02.team == "spectator")
		{
			if(param_00 == "allies")
			{
				self showtoplayer(var_02);
			}

			continue;
		}

		if(var_02.team == param_00)
		{
			self showtoplayer(var_02);
		}
	}

	for(;;)
	{
		level waittill("joined_team");
		self hide();
		foreach(var_02 in level.players)
		{
			if(var_02.team == "spectator")
			{
				if(param_00 == "allies")
				{
					self showtoplayer(var_02);
				}

				continue;
			}

			if(var_02.team == param_00)
			{
				self showtoplayer(var_02);
			}
		}
	}
}

//Function Number: 19
func_4856(param_00)
{
	self endon("death");
	self hide();
	foreach(var_02 in level.players)
	{
		if(var_02.team != param_00)
		{
			self showtoplayer(var_02);
		}
	}

	for(;;)
	{
		level waittill("joined_team");
		self hide();
		foreach(var_02 in level.players)
		{
			if(var_02.team != param_00)
			{
				self showtoplayer(var_02);
			}
		}
	}
}

//Function Number: 20
func_4857(param_00,param_01)
{
	self endon("death");
	self hide();
	foreach(var_03 in level.players)
	{
		if(param_01 && isdefined(param_00) && var_03 != param_00)
		{
			continue;
		}

		if(!param_01 && isdefined(param_00) && var_03 == param_00)
		{
			continue;
		}

		self showtoplayer(var_03);
	}

	for(;;)
	{
		level waittill("joined_team");
		self hide();
		foreach(var_03 in level.players)
		{
			if(param_01 && isdefined(param_00) && var_03 != param_00)
			{
				continue;
			}

			if(!param_01 && isdefined(param_00) && var_03 == param_00)
			{
				continue;
			}

			self showtoplayer(var_03);
		}
	}
}

//Function Number: 21
func_4864(param_00)
{
	self endon("death");
	for(;;)
	{
		func_FB03(param_00);
		level waittill("joined_team");
	}
}

//Function Number: 22
func_4865(param_00)
{
	self endon("death");
	for(;;)
	{
		func_FB02(param_00);
		level waittill("joined_team");
	}
}

//Function Number: 23
func_4862()
{
	if(!issubstr(self.var_485F,"juggernaut"))
	{
		return;
	}

	self endon("death");
	level endon("game_ended");
	for(;;)
	{
		level waittill("juggernaut_equipped",var_00);
		self disableplayeruse(var_00);
		thread func_4863(var_00);
	}
}

//Function Number: 24
func_4863(param_00)
{
	self endon("death");
	level endon("game_ended");
	param_00 endon("disconnect");
	param_00 waittill("death");
	self enableplayeruse(param_00);
}

//Function Number: 25
func_4982(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = spawn("script_model",param_03);
	var_06.var_4B30 = 0;
	var_06.var_130EE = 0;
	var_06.userate = 0;
	var_06.team = self.team;
	var_06.var_5293 = param_04;
	var_06.var_92B8 = "care_package";
	var_06 method_8317(1);
	if(isdefined(param_00))
	{
		var_06.var_222 = param_00;
		var_06 method_831F(param_00);
	}
	else
	{
		var_06.var_222 = undefined;
	}

	var_06.var_485F = param_02;
	var_06.var_5EF1 = param_01;
	var_06.var_336 = "care_package";
	var_06 method_85C8(1);
	var_07 = "care_package_iw7_dummy";
	if(isdefined(level.var_4C4D))
	{
		var_07 = level.var_4C4D;
	}

	var_06 setmodel(var_07);
	if(param_02 == "airdrop_jackpot")
	{
		var_06.var_741D = spawn("script_model",param_03);
		var_06.var_741D setmodel(level.var_4860[param_01][param_02].var_B916);
		var_06.var_741D thread func_51C5(var_06);
	}
	else
	{
		var_06.var_741D = spawn("script_model",param_03);
		var_06.var_741D setmodel(level.var_4860[param_01][param_02].var_B916);
		if(isdefined(level.var_8EF3) && level.var_8EF3)
		{
			if(!isdefined(param_05))
			{
				param_05 = 2;
			}

			var_06.var_741D method_818E(param_05,0,0);
			var_06.var_C789 = param_05;
		}

		var_06.var_6564 = spawn("script_model",param_03);
		var_06.var_6564 setmodel(level.var_4860[param_01][param_02].var_B915);
		var_06.var_741D method_82DD(var_06);
		var_06.var_6564 method_82DD(var_06);
		var_06.var_741D thread func_51C5(var_06);
		if(level.teambased)
		{
			var_06.var_741D thread func_4858(var_06.team);
		}
		else
		{
			var_06.var_741D thread func_4857(param_00,1);
		}

		var_06.var_6564 thread func_51C5(var_06);
		if(level.multiteambased)
		{
			var_06.var_6564 thread func_4856(var_06.team);
		}
		else if(level.teambased)
		{
			var_06.var_6564 thread func_4858(level.var_C74B[var_06.team]);
		}
		else
		{
			var_06.var_6564 thread func_4857(param_00,0);
		}
	}

	var_06.var_9B04 = 0;
	var_06.var_A63A = spawn("script_model",var_06.origin + (0,0,300),0,1);
	var_06.var_A63A setscriptmoverkillcam("explosive");
	var_06.var_A63A linkto(var_06);
	level.var_C223++;
	var_06 thread func_5D27(param_04);
	level notify("createAirDropCrate",var_06);
	return var_06;
}

//Function Number: 26
func_5D27(param_00)
{
	level endon("game_ended");
	self waittill("death");
	if(isdefined(level.var_4854))
	{
		[[ level.var_4854 ]](param_00);
	}

	level.var_C223--;
}

//Function Number: 27
func_485D(param_00,param_01,param_02,param_03)
{
	self setcursorhint("HINT_NOICON");
	self sethintstring(param_00);
	self method_84A7("none");
	self makeusable();
	if(isdefined(param_03))
	{
		self method_835F(param_03);
	}

	if(scripts\mp\_utility::func_9FB3(param_02))
	{
		thread watchcratereroll(self.var_222);
		thread watchcratererollcommand(self.var_222);
		thread fakererollcratesetupforuse(self.var_222,param_03);
	}

	var_04 = "icon_minimap_drone_package_friendly";
	if(isdefined(level.var_C2C6))
	{
		var_05 = "icon_minimap_drone_package_friendly";
	}

	if(!isdefined(self.minimapid))
	{
		self.minimapid = func_49F7(var_04,undefined,1,1,0);
	}

	thread func_4864();
	thread func_4862();
	if(issubstr(self.var_485F,"juggernaut"))
	{
		foreach(var_07 in level.players)
		{
			if(var_07 scripts\mp\_utility::func_9E59())
			{
				thread func_4863(var_07);
			}
		}
	}

	var_09 = undefined;
	if(level.teambased)
	{
		var_09 = scripts\mp\_entityheadicons::func_F73D(self.team,param_01,(0,0,24),14,14,0,undefined,undefined,undefined,undefined,0);
	}
	else if(isdefined(self.var_222))
	{
		var_09 = scripts\mp\_entityheadicons::func_F73D(self.var_222,param_01,(0,0,24),14,14,0,undefined,undefined,undefined,undefined,0);
	}

	if(isdefined(var_09))
	{
		var_09.showinkillcam = 0;
	}

	if(isdefined(level.var_92B5))
	{
		[[ level.var_92B5 ]](self,param_01);
		return;
	}

	foreach(var_07 in level.players)
	{
		if(var_07.team == "spectator")
		{
			var_09 = scripts\mp\_entityheadicons::func_F73D(var_07,param_01,(0,0,24),14,14,0,undefined,undefined,undefined,undefined,0);
		}
	}
}

//Function Number: 28
fakererollcratesetupforuse(param_00,param_01)
{
	var_02 = &"PLATFORM_GET_KILLSTREAK";
	if(isdefined(game["strings"][self.var_485F + "_hint"]))
	{
		var_02 = game["strings"][self.var_485F + "_hint"];
	}

	var_03 = 128;
	var_04 = 360;
	var_05 = 128;
	var_06 = 360;
	var_07 = -10000;
	if(isdefined(param_01))
	{
		var_07 = param_01;
	}

	var_08 = spawn("script_model",self.origin);
	var_08.var_4B30 = 0;
	var_08.var_130EE = 0;
	var_08.userate = 3000;
	var_08.var_9B04 = 0;
	var_08.var_92B8 = self.var_92B8;
	var_08 linkto(self);
	var_08 makeusable();
	var_08 disableplayeruse(param_00);
	var_08 setcursorhint("HINT_NOICON");
	var_08 method_84A9("show");
	var_08 sethintstring(var_02);
	var_08 method_84A6(var_04);
	var_08 method_84A5(var_06);
	var_08 method_84A4(var_03);
	var_08 method_84A2(var_05);
	var_08 method_835F(var_07);
	var_08 thread func_51D9(self);
	self.fakeuseobj = var_08;
}

//Function Number: 29
watchcratereroll(param_00)
{
	self endon("death");
	param_00 endon("disconnect");
	self waittill("crate_reroll");
	param_00 playlocalsound("mp_killconfirm_tags_drop");
	var_01 = level.var_4860[self.var_5EF1][self.var_485F].var_DCEC;
	func_3C54(self.var_5EF1,self.var_485F,0);
	var_02 = func_7E43(self.var_5EF1);
	func_3C54(self.var_5EF1,self.var_485F,var_01);
	self.var_485F = var_02;
	var_03 = &"PLATFORM_GET_KILLSTREAK";
	if(isdefined(game["strings"][self.var_485F + "_hint"]))
	{
		var_03 = game["strings"][self.var_485F + "_hint"];
	}

	self sethintstring(var_03);
	if(isdefined(self.fakeuseobj))
	{
		self.fakeuseobj sethintstring(var_03);
	}

	var_04 = scripts\mp\_utility::func_7F49(self.var_485F);
	var_05 = undefined;
	if(level.teambased)
	{
		var_05 = scripts\mp\_entityheadicons::func_F73D(self.team,var_04,(0,0,24),14,14,0,undefined,undefined,undefined,undefined,0);
	}
	else if(isdefined(self.var_222))
	{
		var_05 = scripts\mp\_entityheadicons::func_F73D(self.var_222,var_04,(0,0,24),14,14,0,undefined,undefined,undefined,undefined,0);
	}

	if(isdefined(var_05))
	{
		var_05.showinkillcam = 0;
	}

	if(isdefined(level.var_92B5))
	{
		[[ level.var_92B5 ]](self,var_04);
		return;
	}

	foreach(var_07 in level.players)
	{
		if(var_07.team == "spectator")
		{
			var_05 = scripts\mp\_entityheadicons::func_F73D(var_07,var_04,(0,0,24),14,14,0,undefined,undefined,undefined,undefined,0);
		}
	}
}

//Function Number: 30
watchcratererollcommand(param_00)
{
	self endon("death");
	param_00 endon("disconnect");
	var_01 = 0;
	var_02 = 16384;
	for(;;)
	{
		if(param_00 usebuttonpressed())
		{
			var_01 = 0;
			while(param_00 usebuttonpressed())
			{
				var_01 = var_01 + 0.05;
				wait(0.05);
			}

			if(var_01 >= 0.5)
			{
				continue;
			}

			var_01 = 0;
			while(!param_00 usebuttonpressed() && var_01 < 0.5)
			{
				var_01 = var_01 + 0.05;
				wait(0.05);
			}

			if(var_01 >= 0.5)
			{
				continue;
			}

			if(!scripts\mp\_utility::func_9F19(param_00))
			{
				continue;
			}

			if(distance2dsquared(param_00.origin,self.origin) > var_02)
			{
				continue;
			}

			self notify("crate_reroll");
		}

		wait(0.05);
	}
}

//Function Number: 31
func_49F7(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = scripts\mp\objidpoolmanager::requestminimapid(10);
	if(var_05 == -1)
	{
		return -1;
	}

	scripts\mp\objidpoolmanager::minimap_objective_add(var_05,"invisible",(0,0,0));
	if(!isdefined(self getlinkedparent()) && !scripts\mp\_utility::func_9FB3(param_03))
	{
		scripts\mp\objidpoolmanager::minimap_objective_position(var_05,self.origin);
	}
	else if(scripts\mp\_utility::func_9FB3(param_03) && scripts\mp\_utility::func_9FB3(param_04))
	{
		scripts\mp\objidpoolmanager::minimap_objective_onentitywithrotation(var_05,self);
	}
	else
	{
		scripts\mp\objidpoolmanager::minimap_objective_onentity(var_05,self);
	}

	scripts\mp\objidpoolmanager::minimap_objective_state(var_05,"active");
	scripts\mp\objidpoolmanager::minimap_objective_icon(var_05,param_00);
	if(isdefined(param_01))
	{
		if(!level.teambased && isdefined(self.var_222))
		{
			if(scripts\mp\_utility::func_9FB3(param_02))
			{
				scripts\mp\objidpoolmanager::minimap_objective_playerteam(var_05,self.var_222 getentitynumber());
			}
			else
			{
				scripts\mp\objidpoolmanager::minimap_objective_playerenemyteam(var_05,self.var_222 getentitynumber());
			}
		}
		else
		{
			scripts\mp\objidpoolmanager::minimap_objective_team(var_05,param_01);
		}
	}
	else
	{
		scripts\mp\objidpoolmanager::minimap_objective_playermask_showtoall(var_05);
	}

	if(isdefined(level.var_C2C6))
	{
		[[ level.var_C2C6 ]](var_05);
	}

	return var_05;
}

//Function Number: 32
func_49F8(param_00,param_01,param_02)
{
	var_03 = scripts\mp\objidpoolmanager::requestminimapid(10);
	if(var_03 == -1)
	{
		return -1;
	}

	scripts\mp\objidpoolmanager::minimap_objective_add(var_03,"invisible",(0,0,0));
	if(!isdefined(self getlinkedparent()) && !scripts\mp\_utility::func_9FB3(param_01))
	{
		scripts\mp\objidpoolmanager::minimap_objective_position(var_03,self.origin);
	}
	else if(scripts\mp\_utility::func_9FB3(param_01) && scripts\mp\_utility::func_9FB3(param_02))
	{
		scripts\mp\objidpoolmanager::minimap_objective_onentitywithrotation(var_03,self);
	}
	else
	{
		scripts\mp\objidpoolmanager::minimap_objective_onentity(var_03,self);
	}

	scripts\mp\objidpoolmanager::minimap_objective_state(var_03,"active");
	scripts\mp\objidpoolmanager::minimap_objective_icon(var_03,param_00);
	scripts\mp\objidpoolmanager::minimap_objective_playermask_hidefromall(var_03);
	return var_03;
}

//Function Number: 33
func_FB03(param_00)
{
	foreach(var_02 in level.players)
	{
		if(issubstr(self.var_485F,"juggernaut") && var_02 scripts\mp\_utility::func_9E59())
		{
			self disableplayeruse(var_02);
			continue;
		}

		if(issubstr(self.var_485F,"lased") && isdefined(var_02.var_8C29) && var_02.var_8C29)
		{
			self disableplayeruse(var_02);
			continue;
		}

		if(issubstr(self.var_485F,"trap") && scripts\mp\_utility::func_9FB3(level.teambased) && var_02.team == self.var_222.team)
		{
			self disableplayeruse(var_02);
			continue;
		}

		if(issubstr(self.var_485F,"trap") && !scripts\mp\_utility::func_9FB3(level.teambased) && var_02 == self.var_222)
		{
			self disableplayeruse(var_02);
			continue;
		}

		if(issubstr(self.var_5EF1,"reroll") && var_02 != self.var_222)
		{
			self disableplayeruse(var_02);
			continue;
		}

		if(!isdefined(param_00) || param_00 == var_02.team)
		{
			self enableplayeruse(var_02);
			continue;
		}

		self disableplayeruse(var_02);
	}
}

//Function Number: 34
func_FB02(param_00)
{
	foreach(var_02 in level.players)
	{
		if(issubstr(self.var_485F,"juggernaut") && var_02 scripts\mp\_utility::func_9E59())
		{
			self disableplayeruse(var_02);
			continue;
		}

		if(!isdefined(param_00) || param_00 != var_02.team)
		{
			self enableplayeruse(var_02);
			continue;
		}

		self disableplayeruse(var_02);
	}
}

//Function Number: 35
func_5EEC(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	var_09 = [];
	self.var_222 endon("disconnect");
	if(!isdefined(param_04))
	{
		if(isdefined(param_07))
		{
			var_0A = undefined;
			var_0B = undefined;
			for(var_0C = 0;var_0C < 100;var_0C++)
			{
				var_0B = func_7E43(param_01);
				var_0A = 0;
				for(var_0D = 0;var_0D < param_07.size;var_0D++)
				{
					if(var_0B == param_07[var_0D])
					{
						var_0A = 1;
						break;
					}
				}

				if(var_0A == 0)
				{
					break;
				}
			}

			if(var_0A == 1)
			{
				var_0B = func_7E43(param_01);
			}
		}
		else
		{
			var_0B = func_7E43(param_02);
		}
	}
	else
	{
		var_0B = param_05;
	}

	param_06 = (0,0,0);
	if(!isdefined(param_06))
	{
		param_06 = (randomint(5),randomint(5),randomint(5));
	}

	var_09 = func_4982(self.var_222,param_01,var_0B,param_05,param_00);
	switch(param_01)
	{
		case "nuke_drop":
		case "airdrop_mega":
		case "airdrop_juggernaut_maniac":
		case "airdrop_juggernaut_recon":
		case "airdrop_juggernaut":
			var_09 linkto(self,"tag_ground",(64,32,-128),(0,0,0));
			break;

		case "airdrop_osprey_gunner":
		case "airdrop_escort":
			var_09 linkto(self,param_08,(0,0,0),(0,0,0));
			break;

		default:
			var_09 linkto(self,"tag_ground",(32,0,5),(0,0,0));
			break;
	}

	var_09.angles = (0,0,0);
	var_09 show();
	var_0E = self.var_37A;
	if(issubstr(var_0B,"juggernaut"))
	{
		param_06 = (0,0,0);
	}

	thread func_136BB(var_09,param_06,param_01,var_0B);
	var_09.var_5D44 = 1;
	return var_0B;
}

//Function Number: 36
func_A66D(param_00)
{
	if(!scripts\mp\_utility::func_9FB3(level.var_C020))
	{
		param_00 dodamage(1000,param_00.origin,self,self,"MOD_CRUSH");
	}

	self endon("death");
	param_00 endon("death");
	param_00 endon("disconnect");
	if(scripts\mp\_utility::func_9F19(param_00))
	{
		childthread scripts\mp\_movers::func_12BEA(param_00,undefined,self);
	}
}

//Function Number: 37
func_A66E()
{
	self endon("death");
	for(;;)
	{
		self waittill("player_pushed",var_00,var_01);
		if(isplayer(var_00) || isagent(var_00))
		{
			if(var_01[2] < -20)
			{
				func_A66D(var_00);
			}
		}

		wait(0.05);
	}
}

//Function Number: 38
func_1A98(param_00)
{
	if(isdefined(param_00.var_AA33.var_52CB) && param_00.var_AA33.var_52CB)
	{
		playfx(scripts\common\utility::getfx("airdrop_crate_destroy"),self.origin);
		func_51AA();
	}
}

//Function Number: 39
func_4066()
{
	var_00 = self getlinkedchildren(1);
	if(!isdefined(var_00))
	{
		return;
	}

	foreach(var_02 in var_00)
	{
		if(!isplayer(var_02))
		{
			continue;
		}

		if(isdefined(var_02.var_9D7F) && var_02.var_9D7F)
		{
			var_03 = var_02 getlinkedparent();
			if(isdefined(var_03))
			{
				var_02 scripts\mp\_gameobjects::func_12F53(var_03,0);
				var_02 unlink();
			}

			if(isalive(var_02))
			{
				var_02 scripts\common\utility::allow_weapon(1);
			}

			var_02.var_9D7F = 0;
		}
	}
}

//Function Number: 40
func_1A99(param_00)
{
	wait(0.05);
	self notify("restarting_physics");
	func_4066();
	self physicslaunchserver((0,0,0),param_00.var_5D2A,param_00.var_1A97);
	thread func_CB14(param_00.var_5EF1,param_00.var_485F,param_00.var_5D2A,param_00.var_1A97);
}

//Function Number: 41
func_136BB(param_00,param_01,param_02,param_03,param_04,param_05)
{
	param_00 endon("death");
	if(!isdefined(param_05) || !param_05)
	{
		self waittill("drop_crate");
	}

	var_06 = 1200;
	if(isdefined(param_04))
	{
		var_06 = param_04;
	}

	param_00 unlink();
	param_00 physicslaunchserver((0,0,0),param_01,var_06);
	param_00 thread func_CB14(param_02,param_03,param_01,var_06);
	param_00 thread func_A66E();
	param_00.var_12BE7 = ::func_A66D;
	if(isdefined(param_00.var_A63A))
	{
		if(isdefined(param_00.var_3A5A))
		{
			var_07 = -2100;
		}
		else
		{
			var_07 = 0;
		}

		param_00.var_A63A unlink();
		var_08 = bullettrace(param_00.origin,param_00.origin + (0,0,-10000),0,param_00);
		var_09 = distance(param_00.origin,var_08["position"]);
		var_0A = var_09 / 800;
		param_00.var_A63A moveto(var_08["position"] + (0,0,300) + (var_07,0,0),var_0A);
	}
}

//Function Number: 42
func_13698()
{
	self endon("death");
	wait(0.035);
	playfx(level._effect["airdrop_dust_kickup"],self.origin + (0,0,5),(0,0,1));
	self.var_741D scriptmodelplayanim("juggernaut_carepackage");
	self.var_6564 scriptmodelplayanim("juggernaut_carepackage");
}

//Function Number: 43
func_CB14(param_00,param_01,param_02,param_03,param_04)
{
	if(scripts\mp\_utility::func_9FB3(param_04))
	{
		self endon("death");
	}

	self endon("restarting_physics");
	func_136A7();
	self.var_5D44 = 0;
	self thread [[ level.var_4860[param_00][param_01].var_74C2 ]](param_00);
	level thread func_5EEE(self,self.var_222,param_01);
	var_05 = spawnstruct();
	var_05.var_6371 = "restarting_physics";
	var_05.var_4E53 = ::func_1A98;
	var_05.var_9B11 = ::func_1A99;
	var_05.var_5EF1 = param_00;
	var_05.var_485F = param_01;
	var_05.var_5D2A = param_02;
	var_05.var_1A97 = param_03;
	thread scripts\mp\_movers::func_892F(var_05);
	if(self.var_741D scripts\mp\_utility::touchingbadtrigger())
	{
		func_51AA();
		return;
	}

	if(isdefined(self.var_222) && abs(self.origin[2] - self.var_222.origin[2]) > 3000)
	{
		func_51AA();
	}
}

//Function Number: 44
func_136A7()
{
	wait(0.5);
	for(;;)
	{
		var_00 = self method_8419(0);
		var_01 = function_026E(var_00);
		if(lengthsquared(var_01) > 0.5)
		{
			wait(0.1);
			continue;
		}

		break;
	}
}

//Function Number: 45
func_5EEE(param_00,param_01,param_02)
{
	if(isdefined(level.var_C028) && level.var_C028)
	{
		return;
	}

	level endon("game_ended");
	param_00 endon("death");
	if(param_00.var_5EF1 == "nuke_drop")
	{
		return;
	}

	var_03 = 90;
	if(param_02 == "supply")
	{
		var_03 = 20;
	}
	else if(param_02 == "bomb_trap")
	{
		var_03 = 60;
	}

	scripts\mp\_hostmigration::func_13708(var_03);
	while(param_00.var_4B30 != 0)
	{
		wait(1);
	}

	param_00 func_51AA();
}

//Function Number: 46
func_8054(param_00,param_01)
{
	var_02 = 100;
	var_03 = 15000;
	var_04 = (0,param_01,0);
	var_05 = param_00 + anglestoforward(var_04) * -1 * var_03;
	var_05 = var_05 + (randomfloat(2) - 1 * var_02,randomfloat(2) - 1 * var_02,0);
	return var_05;
}

//Function Number: 47
func_8051(param_00,param_01)
{
	var_02 = 150;
	var_03 = 15000;
	var_04 = (0,param_01,0);
	var_05 = param_00 + anglestoforward(var_04 + (0,90,0)) * var_03;
	var_05 = var_05 + (randomfloat(2) - 1 * var_02,randomfloat(2) - 1 * var_02,0);
	return var_05;
}

//Function Number: 48
func_7EC0(param_00)
{
	var_01 = 850;
	var_02 = getent("airstrikeheight","targetname");
	if(!isdefined(var_02))
	{
		if(isdefined(level.var_1AF8))
		{
			if(level.var_1AF8 > 2)
			{
				var_01 = 1500;
				return var_01 * level.var_1AF8;
			}

			return var_01 * level.var_1AF8 + 256 + param_00[2];
		}

		return var_01 + param_00[2];
	}

	return var_02.origin[2];
}

//Function Number: 49
func_581F(param_00,param_01,param_02,param_03,param_04)
{
	if(!isdefined(param_00))
	{
		return;
	}

	if(scripts\mp\_utility::func_4BD7() >= scripts\mp\_utility::func_B4D2())
	{
		return;
	}

	if(param_03 == "dronedrop_grnd")
	{
		var_05 = param_01.droporigin;
	}
	else
	{
		var_05 = param_02.var_AEC4;
	}

	var_06 = func_7EC0(var_05);
	var_07 = var_05 * (1,1,0) + (0,0,var_06);
	var_08 = func_8054(var_07,param_02);
	var_09 = func_8051(var_07,param_02);
	var_07 = var_07 + anglestoforward((0,param_02,0)) * -50;
	var_0A = func_5CC7(param_00,var_08,var_07,param_03,param_01,param_04);
	var_0B = undefined;
	var_0C = 999999;
	var_0D = scripts\common\trace::func_DCED(var_05,var_05 + (0,0,10000),level.var_3CB5,scripts\common\trace::func_48BC(0,1,0,1,0,1,0));
	var_0E = undefined;
	var_0F = 0;
	if(var_0D["hittype"] == "hittype_none")
	{
		var_0E = var_05 * (1,1,0) + (0,0,var_06);
		var_0F = 1;
	}
	else
	{
		if(isdefined(level.var_3A58) && level.var_3A58.size > 0)
		{
			foreach(var_11 in level.var_3A58)
			{
				var_12 = distance(var_11.origin,var_05);
				if(var_12 < var_0C)
				{
					var_0B = var_11;
					var_0C = var_12;
				}
			}
		}
		else
		{
		}

		var_0E = var_0B.origin * (1,1,0) + (0,0,var_06);
	}

	var_14 = "";
	var_15 = "used_dronedrop";
	if(isdefined(param_04))
	{
		var_14 = scripts\mp\_killstreak_loot::getrarityforlootitem(param_04.var_1318B);
		var_15 = "used_" + param_04.var_110EA;
	}

	if(var_14 != "" && var_14 != "rare")
	{
		var_15 = var_15 + "_" + var_14;
	}

	if(level.gametype != "grnd")
	{
		level thread scripts\mp\_utility::func_115DE(var_15,param_00);
	}

	var_0A method_8362(var_0E,1);
	var_0A setscriptablepartstate("lights","idle");
	var_0A setscriptablepartstate("thrusters","fly",0);
	var_0A thread func_13A04(var_0E,var_05,var_0F);
}

//Function Number: 50
func_5CC7(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = vectortoangles(param_02 - param_01);
	var_07 = "veh_mil_air_un_delivery_drone";
	var_08 = "";
	if(isdefined(param_05))
	{
		var_08 = scripts\mp\_killstreak_loot::getrarityforlootitem(param_05.var_1318B);
	}

	if(var_08 != "")
	{
		var_07 = var_07 + "_" + var_08;
	}

	if(isdefined(param_05))
	{
		if(scripts\mp\killstreaks\_utility::func_A69F(param_05,"passive_bomb_trap"))
		{
			param_03 = "dronedrop_trap";
		}

		if(scripts\mp\killstreaks\_utility::func_A69F(param_05,"passive_reroll"))
		{
			param_03 = "dronedrop_reroll";
		}

		if(scripts\mp\killstreaks\_utility::func_A69F(param_05,"passive_high_roller"))
		{
			param_03 = "dronedrop_highroll";
		}
	}

	var_09 = spawnhelicopter(param_00,param_01,var_06,"delivery_drone_mp",var_07);
	if(!isdefined(var_09))
	{
		return;
	}

	var_09.maxhealth = 100;
	var_09.var_222 = param_00;
	var_09.team = param_00.team;
	var_09.var_9D32 = 1;
	var_09 method_830A(35,35);
	var_09 method_83E5(1600,200,200);
	var_09 method_8378(250,100);
	var_09 method_8316(1000);
	var_09 method_82F6(5,5,2);
	var_09 setcandamage(1);
	var_09 method_8354(1);
	var_09 method_84E1(1);
	var_09 method_84E0(1);
	var_09.var_110E8 = param_05;
	var_09.var_8DD9 = "dronedrop";
	var_09 scripts\mp\killstreaks\_utility::func_1843(var_09.var_8DD9,"Killstreak_Air",param_00,1);
	var_0A = func_7E43(param_03);
	var_0B = var_09 func_4982(param_00,param_03,var_0A,var_09.origin);
	var_0B linkto(var_09,"tag_origin",(0,0,5),(0,0,0));
	var_0B.var_110E8 = param_05;
	var_09.var_5D26 = var_0B;
	var_09 thread func_13B7E(60);
	var_09 thread func_13A01(var_0B,param_03,var_0A,param_04);
	var_09 thread scripts\mp\killstreaks\_helicopter::func_8D40("dronedrop",undefined,1);
	var_09 thread func_13A10();
	if(param_03 == "dronedrop_trap")
	{
		var_09 thread watchownerdisconnect(var_0B,param_04);
	}

	var_09 setscriptablepartstate("dust","active",0);
	var_09 thread dronewatchgameover();
	return var_09;
}

//Function Number: 51
func_13A01(param_00,param_01,param_02,param_03)
{
	self waittill("death");
	if(!isdefined(param_00))
	{
		return;
	}

	var_04 = (0,0,0);
	var_05 = 1200;
	var_06 = undefined;
	if(param_01 == "dronedrop_trap")
	{
		var_06 = 1;
	}

	param_00 unlink();
	param_00 physicslaunchserver((0,0,0),var_04,var_05);
	param_00 thread func_CB14(param_01,param_02,var_04,var_05,var_06);
	param_00 thread func_A66E();
	param_00.var_12BE7 = ::func_A66D;
	if(isdefined(param_00.var_A63A))
	{
		param_00.var_A63A unlink();
	}

	if(isdefined(param_03.var_1349C))
	{
		param_03.var_1349C delete();
	}

	param_00 thread handlenavobstacle();
	func_5CAC();
	scripts\mp\_utility::func_D915("killstreak ended - dronedrop",self.var_222);
}

//Function Number: 52
handlenavobstacle()
{
	self endon("death");
	self endon("nav_obstacle_destroyed");
	wait(1);
	self.var_BE6F = function_027A(self.origin,(30,10,64),self.angles);
	var_00 = self.origin;
	while(isdefined(self) && isdefined(self.var_BE6F))
	{
		if(distance2dsquared(var_00,self.origin) > 64)
		{
			destroynavobstacle(self.var_BE6F);
			self.var_BE6F = function_027A(self.origin,(30,10,64),self.angles);
			var_00 = self.origin;
		}

		wait(1);
	}
}

//Function Number: 53
func_13A10()
{
	self endon("death");
	level endon("game_ended");
	for(;;)
	{
		self waittill("emp_damage",var_00,var_01,var_02,var_03,var_04);
		if(isdefined(var_03) && var_03 == "concussion_grenade_mp")
		{
			if(scripts\mp\_utility::func_9FB3(scripts\mp\_utility::playersareenemies(self.var_222,var_00)))
			{
				var_00 scripts\mp\_missions::func_D991("ch_tactical_emp_eqp");
			}
		}

		scripts\mp\killstreaks\_utility::dodamagetokillstreak(100,var_00,var_00,self.team,var_02,var_04,var_03);
	}
}

//Function Number: 54
watchownerdisconnect(param_00,param_01)
{
	self endon("death");
	self.var_222 waittill("disconnect");
	if(isdefined(param_01.var_1349C))
	{
		param_01.var_1349C delete();
	}

	param_00 func_51AA();
	func_5CAC();
}

//Function Number: 55
func_5CAC()
{
	playfx(scripts\common\utility::getfx("drone_explode"),self.origin);
	self playsound("sentry_explode");
	scripts\mp\_utility::func_4FC1();
	self delete();
}

//Function Number: 56
func_13A04(param_00,param_01,param_02)
{
	self endon("death");
	self waittill("goal");
	thread watchmantledisable();
	var_03 = (0,0,-30);
	var_04 = (0,0,12);
	self setscriptablepartstate("thrusters","descend",0);
	thread watchfailsafe(param_00);
	var_05 = undefined;
	if(!scripts\mp\_utility::func_9FB3(param_02))
	{
		if(areanynavvolumesloaded())
		{
			var_06 = param_01 + (0,0,12);
			var_05 = findpath3d(self.origin,var_06);
		}
		else
		{
			var_07 = scripts\common\trace::func_4956();
			var_08 = scripts\common\trace::func_DCED(self.origin,self.origin - (0,0,500),self,var_07);
			var_09 = getclosestpointonnavmesh(var_08["position"],self);
			var_05 = self.var_222 method_8428(var_09,param_01);
			self.var_222 iprintlnbold("3D Nav Volume is not present, using 2D path instead");
		}
	}
	else
	{
		var_05 = [param_01 + (0,0,12)];
	}

	var_0A = 0;
	var_0B = self.origin;
	foreach(var_10, var_0D in var_05)
	{
		if(var_10 == var_05.size - 1)
		{
			var_0A = 1;
		}

		if(var_0A)
		{
			var_0E = var_04;
		}
		else
		{
			var_0E = var_03;
		}

		var_0F = 50;
		self method_8316(var_0F);
		var_0B = var_0D;
		if(!var_0A)
		{
			thread func_BA1C(var_0D + var_0E,var_05[var_10 + 1] + var_0E);
		}
		else
		{
			thread func_BA1D(var_0D + var_0E);
		}

		self setscriptablepartstate("thrusters","navigate",0);
		self method_8362(var_0D + var_0E,var_0A);
		if(!var_0A || scripts\mp\_utility::func_9FB3(param_02))
		{
			self waittill("near_goal");
			continue;
		}

		self waittill("goal");
	}

	self notify("death");
}

//Function Number: 57
watchmantledisable()
{
	self endon("death");
	for(;;)
	{
		foreach(var_01 in level.players)
		{
			if(!scripts\mp\_utility::func_9F19(var_01))
			{
				continue;
			}

			if(distancesquared(self.origin,var_01.origin) <= 10000 && !isdefined(var_01.cratemantle))
			{
				var_01.cratemantle = 0;
				var_01 scripts\common\utility::func_1C52(0);
				var_01 thread watchdistancefromcrate(self);
			}
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 58
watchdistancefromcrate(param_00)
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	while(isdefined(param_00))
	{
		if(distancesquared(param_00.origin,self.origin) > 10000)
		{
			break;
		}

		scripts\common\utility::func_136F7();
	}

	self.cratemantle = undefined;
	scripts\common\utility::func_1C52(1);
}

//Function Number: 59
watchfailsafe(param_00)
{
	self endon("death");
	self endon("near_goal");
	var_01 = 3;
	scripts\mp\_hostmigration::func_13708(var_01);
	if(distancesquared(self.origin,param_00) < 2500)
	{
		self notify("death");
	}
}

//Function Number: 60
func_7E84(param_00)
{
	var_01 = abs(param_00[0]);
	var_02 = abs(param_00[1]);
	var_03 = abs(param_00[2]);
	return int(max(var_03,max(var_01,var_02)));
}

//Function Number: 61
func_BA00(param_00,param_01)
{
	self notify("stop_MonitorPath");
	self endon("death");
	self endon("stop_MonitorPath");
	self endon("goal");
	self endon("near_goal");
	var_02[0] = self;
	var_02[1] = self.var_5D26;
	for(;;)
	{
		var_03 = scripts\common\trace::func_109DD(self.origin,param_01,16,var_02);
		if(var_03["fraction"] == 1)
		{
			self notify("near_goal");
		}

		wait(0.25);
	}
}

//Function Number: 62
func_FA9B(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = spawnstruct();
	var_06.var_B75B = param_01;
	var_06.var_B491 = param_02;
	var_06.var_B7CB = param_03;
	var_06.var_B4C9 = param_04;
	var_06.var_1545 = param_05;
	level.var_109C4[param_00] = var_06;
}

//Function Number: 63
func_FA9A()
{
	func_FA9B("far",500,750,45,70,100);
	func_FA9B("medium",250,500,35,45,100);
	func_FA9B("near",50,250,15,30,100);
	func_FA9B("medium_sharpturn",250,500,10,30,100);
	func_FA9B("near_sharpturn",50,250,10,20,100);
	func_FA9B("final",50,1000,10,45,100);
}

//Function Number: 64
func_12F22(param_00,param_01)
{
	var_02 = 9999;
	var_03 = level.var_109C4[param_00];
	if(param_01 < var_03.var_B75B)
	{
		param_01 = var_03.var_B75B;
	}

	if(param_01 > var_03.var_B491)
	{
		param_01 = var_03.var_B491;
	}

	var_04 = param_01 - var_03.var_B75B / var_03.var_B491 - var_03.var_B75B;
	var_05 = var_03.var_B7CB + var_04 * var_03.var_B4C9 - var_03.var_B7CB;
	var_06 = var_03.var_1545;
	if(var_06 > var_05)
	{
		var_06 = var_05;
	}

	self method_83E5(var_05,var_06,var_02);
}

//Function Number: 65
func_BA1D(param_00)
{
	self notify("stop_MonitorSpeed");
	self endon("death");
	self endon("stop_MonitorSpeed");
	self endon("goal");
	var_01 = "none";
	for(;;)
	{
		var_02 = distance(self.origin,param_00);
		func_12F22("final",var_02);
		scripts\common\utility::func_136F7();
	}
}

//Function Number: 66
func_BA1C(param_00,param_01)
{
	self notify("stop_MonitorSpeed");
	self endon("death");
	self endon("stop_MonitorSpeed");
	var_02 = "none";
	var_03 = vectornormalize(param_01 - param_00);
	var_04 = distance(param_00,param_01);
	for(;;)
	{
		var_05 = distance(self.origin,param_00);
		var_06 = vectornormalize(param_00 - self.origin);
		var_07 = vectordot(var_03,var_06);
		var_08 = 0;
		if(var_07 < 0.707 || var_04 < 300)
		{
			var_08 = 1;
		}

		if(var_08)
		{
			if(var_05 < level.var_109C4["medium_sharpturn"].var_B75B)
			{
				func_12F22("near_sharpturn",var_05);
			}
			else
			{
				func_12F22("medium_sharpturn",var_05);
			}
		}
		else if(var_05 < level.var_109C4["near"].var_B491)
		{
			func_12F22("near",var_05);
		}
		else if(var_05 < level.var_109C4["medium"].var_B491)
		{
			func_12F22("medium",var_05);
		}
		else
		{
			func_12F22("far",var_05);
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 67
func_5857(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(!isdefined(param_00))
	{
		return;
	}

	if(scripts\mp\_utility::func_4BD7() >= scripts\mp\_utility::func_B4D2())
	{
		return;
	}

	var_06 = func_7EC0(param_01);
	if(isdefined(param_04))
	{
		var_06 = var_06 + param_04;
	}

	foreach(var_08 in level.var_AD8B)
	{
		if(isdefined(var_08.var_5EF1))
		{
			var_06 = var_06 + 128;
		}
	}

	var_0A = param_01 * (1,1,0) + (0,0,var_06);
	var_0B = func_8054(var_0A,param_02);
	var_0C = func_8051(var_0A,param_02);
	var_0A = var_0A + anglestoforward((0,param_02,0)) * -50;
	var_0D = func_8DD4(param_00,var_0B,var_0A);
	if(isdefined(level.var_8EF3) && level.var_8EF3)
	{
		var_0D method_818E(3,0,0);
	}

	var_0D endon("death");
	var_0D thread func_4FC2();
	var_0D.var_5EF1 = param_03;
	var_0D method_8362(var_0A,1);
	var_0D thread func_5EEC(param_01,param_03,var_06,0,param_05,var_0B);
	wait(2);
	var_0D method_83E5(75,40);
	var_0D method_8378(180,180,180,0.3);
	var_0D waittill("goal");
	wait(0.1);
	var_0D notify("drop_crate");
	var_0D method_8362(var_0C,1);
	var_0D method_83E5(300,75);
	var_0D.var_AB32 = 1;
	var_0D waittill("goal");
	var_0D notify("leaving");
	var_0D notify("delete");
	var_0D delete();
}

//Function Number: 68
func_4FC2()
{
	self waittill("death");
	waittillframeend;
	scripts\mp\_utility::func_4FC1();
}

//Function Number: 69
func_58FC(param_00,param_01,param_02,param_03)
{
	level thread func_5857(param_00,param_01,param_02,param_03,0);
	wait(randomintrange(1,2));
	level thread func_5857(param_00,param_01 + (128,128,0),param_02,param_03,128);
	wait(randomintrange(1,2));
	level thread func_5857(param_00,param_01 + (172,256,0),param_02,param_03,256);
	wait(randomintrange(1,2));
	level thread func_5857(param_00,param_01 + (64,0,0),param_02,param_03,0);
}

//Function Number: 70
func_57EF(param_00,param_01,param_02,param_03)
{
	var_04 = 18000;
	var_05 = 3000;
	var_06 = vectortoyaw(param_01 - param_00.origin);
	var_07 = (0,var_06,0);
	var_08 = func_7EC0(param_01);
	var_09 = param_01 + anglestoforward(var_07) * -1 * var_04;
	var_09 = var_09 * (1,1,0) + (0,0,var_08);
	var_0A = param_01 + anglestoforward(var_07) * var_04;
	var_0A = var_0A * (1,1,0) + (0,0,var_08);
	var_0B = length(var_09 - var_0A);
	var_0C = var_0B / var_05;
	var_0D = func_365E(param_00,var_09,var_0A);
	var_0D.var_37A = var_05;
	var_0D.var_5EF1 = param_03;
	var_0D playloopsound("veh_ac130_dist_loop");
	var_0D.angles = var_07;
	var_0E = anglestoforward(var_07);
	var_0D moveto(var_0A,var_0C,0,0);
	var_0F = distance2d(var_0D.origin,param_01);
	var_10 = 0;
	for(;;)
	{
		var_11 = distance2d(var_0D.origin,param_01);
		if(var_11 < var_0F)
		{
			var_0F = var_11;
		}
		else if(var_11 > var_0F)
		{
			break;
		}

		if(var_11 < 320)
		{
			break;
		}
		else if(var_11 < 768)
		{
			scripts\mp\_shellshock::func_1245(0.15,1.5,param_01,1500);
			if(!var_10)
			{
				var_0D playsound("veh_ac130_sonic_boom");
				var_10 = 1;
			}
		}

		wait(0.05);
	}

	wait(0.05);
	var_12 = (0,0,0);
	var_13[0] = var_0D thread func_5EEC(param_01,param_03,var_08,0,undefined,var_09,var_12);
	wait(0.05);
	var_0D notify("drop_crate");
	var_14 = param_01 + anglestoforward(var_07) * var_04 * 1.5;
	var_0D moveto(var_14,var_0C / 2,0,0);
	wait(6);
	var_0D delete();
}

//Function Number: 71
func_58FB(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = 24000;
	var_06 = 2000;
	var_07 = vectortoyaw(param_01 - param_00.origin);
	var_08 = (0,var_07,0);
	var_09 = anglestoforward(var_08);
	if(isdefined(param_04))
	{
		param_01 = param_01 + var_09 * param_04;
	}

	var_0A = func_7EC0(param_01);
	var_0B = param_01 + anglestoforward(var_08) * -1 * var_05;
	var_0B = var_0B * (1,1,0) + (0,0,var_0A);
	var_0C = param_01 + anglestoforward(var_08) * var_05;
	var_0C = var_0C * (1,1,0) + (0,0,var_0A);
	var_0D = length(var_0B - var_0C);
	var_0E = var_0D / var_06;
	var_0F = func_365E(param_00,var_0B,var_0C);
	var_0F.var_37A = var_06;
	var_0F.var_5EF1 = param_03;
	var_0F playloopsound("veh_ac130_dist_loop");
	var_0F.angles = var_08;
	var_09 = anglestoforward(var_08);
	var_0F moveto(var_0C,var_0E,0,0);
	var_10 = distance2d(var_0F.origin,param_01);
	var_11 = 0;
	for(;;)
	{
		var_12 = distance2d(var_0F.origin,param_01);
		if(var_12 < var_10)
		{
			var_10 = var_12;
		}
		else if(var_12 > var_10)
		{
			break;
		}

		if(var_12 < 256)
		{
			break;
		}
		else if(var_12 < 768)
		{
			scripts\mp\_shellshock::func_1245(0.15,1.5,param_01,1500);
			if(!var_11)
			{
				var_0F playsound("veh_ac130_sonic_boom");
				var_11 = 1;
			}
		}

		wait(0.05);
	}

	wait(0.05);
	var_13[0] = var_0F thread func_5EEC(param_01,param_03,var_0A,0,undefined,var_0B);
	wait(0.05);
	var_0F notify("drop_crate");
	wait(0.05);
	var_13[1] = var_0F thread func_5EEC(param_01,param_03,var_0A,0,undefined,var_0B,undefined,var_13);
	wait(0.05);
	var_0F notify("drop_crate");
	wait(0.05);
	var_13[2] = var_0F thread func_5EEC(param_01,param_03,var_0A,0,undefined,var_0B,undefined,var_13);
	wait(0.05);
	var_0F notify("drop_crate");
	wait(0.05);
	var_13[3] = var_0F thread func_5EEC(param_01,param_03,var_0A,0,undefined,var_0B,undefined,var_13);
	wait(0.05);
	var_0F notify("drop_crate");
	wait(4);
	var_0F delete();
}

//Function Number: 72
func_5D2D(param_00,param_01,param_02)
{
	var_03 = 24000;
	var_04 = 2000;
	var_05 = randomint(360);
	var_06 = (0,var_05,0);
	var_07 = func_7EC0(param_00);
	var_08 = param_00 + anglestoforward(var_06) * -1 * var_03;
	var_08 = var_08 * (1,1,0) + (0,0,var_07);
	var_09 = param_00 + anglestoforward(var_06) * var_03;
	var_09 = var_09 * (1,1,0) + (0,0,var_07);
	var_0A = length(var_08 - var_09);
	var_0B = var_0A / var_04;
	var_0C = func_365E(param_01,var_08,var_09);
	var_0C.var_37A = var_04;
	var_0C.var_5EF1 = param_02;
	var_0C playloopsound("veh_ac130_dist_loop");
	var_0C.angles = var_06;
	var_0D = anglestoforward(var_06);
	var_0C moveto(var_09,var_0B,0,0);
	var_0E = 0;
	var_0F = distance2d(var_0C.origin,param_00);
	for(;;)
	{
		var_10 = distance2d(var_0C.origin,param_00);
		if(var_10 < var_0F)
		{
			var_0F = var_10;
		}
		else if(var_10 > var_0F)
		{
			break;
		}

		if(var_10 < 256)
		{
			break;
		}
		else if(var_10 < 768)
		{
			scripts\mp\_shellshock::func_1245(0.15,1.5,param_00,1500);
			if(!var_0E)
			{
				var_0C playsound("veh_ac130_sonic_boom");
				var_0E = 1;
			}
		}

		wait(0.05);
	}

	var_0C thread func_5EEC(param_00,param_02,var_07,0,"nuke",var_08);
	wait(0.05);
	var_0C notify("drop_crate");
	wait(4);
	var_0C delete();
}

//Function Number: 73
func_1107A(param_00)
{
	self endon("death");
	wait(param_00);
	self stoploopsound();
}

//Function Number: 74
func_D4C7(param_00)
{
	var_01 = spawn("script_origin",(0,0,0));
	var_01 hide();
	var_01 endon("death");
	thread scripts\common\utility::func_5179(var_01);
	var_01.origin = self.origin;
	var_01.angles = self.angles;
	var_01 linkto(self);
	var_01 playloopsound(param_00);
	self waittill("stop sound" + param_00);
	var_01 stoploopsound(param_00);
	var_01 delete();
}

//Function Number: 75
func_365E(param_00,param_01,param_02)
{
	var_03 = vectortoangles(param_02 - param_01);
	var_04 = spawnplane(param_00,"script_model",param_01,"compass_objpoint_c130_friendly","compass_objpoint_c130_enemy");
	var_04 setmodel("vehicle_ac130_low_mp");
	if(!isdefined(var_04))
	{
		return;
	}

	var_04.var_222 = param_00;
	var_04.team = param_00.team;
	level.var_365D = var_04;
	return var_04;
}

//Function Number: 76
func_8DD4(param_00,param_01,param_02)
{
	var_03 = vectortoangles(param_02 - param_01);
	var_04 = "littlebird_mp";
	if(isdefined(level.var_13264))
	{
		var_04 = level.var_13264;
	}

	var_05 = spawnhelicopter(param_00,param_01,var_03,var_04,"vehicle_aas_72x_killstreak");
	if(!isdefined(var_05))
	{
		return;
	}

	var_05.maxhealth = 500;
	var_05.var_222 = param_00;
	var_05.team = param_00.team;
	var_05.var_9D32 = 1;
	var_05 thread func_13B7E();
	var_05 thread func_8D4A();
	var_05 thread func_8DB5();
	var_05 thread scripts\mp\killstreaks\_helicopter::func_8D40("airdrop");
	var_05 method_830A(45,85);
	var_05 method_83E5(250,175);
	var_05.var_8DD9 = "airdrop";
	var_05 scripts\mp\killstreaks\_utility::func_1843(var_05.var_8DD9,"Killstreak_Air",param_00,1);
	var_05 method_8187("tag_wings");
	return var_05;
}

//Function Number: 77
func_13B7E(param_00)
{
	level endon("game_ended");
	self endon("leaving");
	self endon("helicopter_gone");
	self endon("death");
	var_01 = 25;
	if(isdefined(param_00))
	{
		var_01 = param_00;
	}

	scripts\mp\_hostmigration::func_13708(var_01);
	self notify("death");
}

//Function Number: 78
func_8D4A()
{
	scripts\common\utility::waittill_any_3("crashing","leaving");
	self notify("helicopter_gone");
}

//Function Number: 79
func_8DB5()
{
	self endon("leaving");
	self endon("helicopter_gone");
	self waittill("death");
	if(!isdefined(self))
	{
		return;
	}

	self method_83E5(25,5);
	thread func_AAC9(randomintrange(180,220));
	wait(randomfloatrange(0.5,1.5));
	self notify("drop_crate");
	func_AAC6();
}

//Function Number: 80
func_AAC6()
{
	var_00 = self.origin + (0,0,1) - self.origin;
	playfx(level.var_3F19["explode"]["death"]["cobra"],self.origin,var_00);
	self playsound("exp_helicopter_fuel");
	self notify("explode");
	scripts\mp\_utility::func_4FC1();
	self delete();
}

//Function Number: 81
func_AAC9(param_00)
{
	self endon("explode");
	playfxontag(level.var_3F19["explode"]["medium"],self,"tail_rotor_jnt");
	playfxontag(level.var_3F19["fire"]["trail"]["medium"],self,"tail_rotor_jnt");
	self method_8378(param_00,param_00,param_00);
	while(isdefined(self))
	{
		self method_8348(self.angles[1] + param_00 * 0.9);
		wait(1);
	}
}

//Function Number: 82
func_C1B4()
{
	while(isdefined(self))
	{
		self waittill("trigger",var_00);
		if(!var_00 isonground())
		{
			continue;
		}

		if(!func_13093(var_00))
		{
			continue;
		}

		self notify("captured",var_00);
	}
}

//Function Number: 83
func_485A(param_00,param_01)
{
	self endon("restarting_physics");
	var_02 = self;
	var_03 = undefined;
	if(scripts\mp\_utility::func_9FB3(param_01))
	{
		var_02 = self.fakeuseobj;
		var_03 = self.fakeuseobj;
	}

	while(isdefined(self))
	{
		var_02 waittill("trigger",var_04);
		if(isdefined(self.var_222) && var_04 == self.var_222)
		{
			continue;
		}

		if(!func_13143(var_04))
		{
			continue;
		}

		if(isdefined(level.var_C81E))
		{
			var_05 = level.var_C81E;
		}
		else
		{
			var_05 = undefined;
		}

		var_04.var_9D7F = 1;
		if(!scripts\mp\_utility::func_9FB3(param_01))
		{
			var_03 = func_4A2D();
		}

		var_06 = var_03 func_13093(var_04,var_05,param_00);
		if(!scripts\mp\_utility::func_9FB3(param_01))
		{
			if(isdefined(var_03))
			{
				var_03 delete();
			}
		}

		if(!isdefined(var_04))
		{
			return;
		}

		if(!var_06)
		{
			var_04.var_9D7F = 0;
			continue;
		}

		var_04.var_9D7F = 0;
		self notify("captured",var_04);
	}
}

//Function Number: 84
func_485B(param_00)
{
	self endon("restarting_physics");
	while(isdefined(self))
	{
		self waittill("trigger",var_01);
		if(isdefined(self.var_222) && var_01 != self.var_222)
		{
			continue;
		}

		if(!func_13143(var_01))
		{
			continue;
		}

		var_01.var_9D7F = 1;
		if(!func_13093(var_01,500,param_00))
		{
			var_01.var_9D7F = 0;
			continue;
		}

		var_01.var_9D7F = 0;
		self notify("captured",var_01);
	}
}

//Function Number: 85
func_484E(param_00)
{
	self endon("restarting_physics");
	self.var_4861 = [];
	while(isdefined(self))
	{
		self waittill("trigger",var_01);
		if(!func_13143(var_01))
		{
			continue;
		}

		if(isdefined(level.var_C81E))
		{
			var_02 = level.var_C81E;
			continue;
		}

		var_02 = undefined;
		childthread func_4850(var_01,var_02,param_00);
	}
}

//Function Number: 86
func_4850(param_00,param_01,param_02)
{
	param_00.var_9D7F = 1;
	self.var_4861[param_00.name] = func_4A2D();
	var_03 = self.var_4861[param_00.name];
	var_04 = self.var_4861[param_00.name] func_13093(param_00,param_01,param_02,self);
	if(isdefined(self.var_4861) && isdefined(var_03))
	{
		self.var_4861 = scripts\mp\_utility::func_22B1(self.var_4861,var_03);
		var_03 delete();
	}

	if(!isdefined(param_00))
	{
		return;
	}

	param_00.var_9D7F = 0;
	if(var_04)
	{
		self notify("captured",param_00);
	}
}

//Function Number: 87
func_12E80()
{
	self.var_9B04 = 0;
	foreach(var_01 in self.var_4861)
	{
		if(var_01.var_9B04)
		{
			self.var_9B04 = 1;
			break;
		}
	}
}

//Function Number: 88
func_13143(param_00)
{
	if((self.var_485F == "airdrop_juggernaut_recon" || self.var_485F == "airdrop_juggernaut" || self.var_485F == "airdrop_juggernaut_maniac") && param_00 scripts\mp\_utility::func_9E59())
	{
		return 0;
	}

	if(isdefined(param_00.var_C53B) && param_00.var_C53B)
	{
		return 0;
	}

	var_01 = param_00 getcurrentweapon();
	if(scripts\mp\_utility::func_9E6C(var_01) && !scripts\mp\_utility::func_9E60(var_01))
	{
		return 0;
	}

	if(isbot(param_00))
	{
		if(level.gametype != "grnd" && !scripts\mp\bots\_bots_killstreaks::func_2DDB(self.var_485F))
		{
			return 0;
		}

		if(scripts\mp\bots\_bots_killstreaks::func_9E66(self.var_485F))
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 89
func_A693(param_00)
{
	self endon("restarting_physics");
	self endon("death");
	if(isdefined(game["strings"][self.var_485F + "_hint"]))
	{
		var_01 = game["strings"][self.var_485F + "_hint"];
	}
	else
	{
		var_01 = &"PLATFORM_GET_KILLSTREAK";
	}

	var_02 = -10000;
	var_03 = undefined;
	if(!scripts\mp\_utility::func_9FB3(level.var_7669))
	{
		if(param_00 == "dronedrop_reroll")
		{
			var_03 = 1;
			if(isdefined(game["strings"][self.var_485F + "_rerollHint"]))
			{
				var_01 = game["strings"][self.var_485F + "_rerollHint"];
			}
		}

		func_485D(var_01,scripts\mp\_utility::func_7F49(self.var_485F),var_03,var_02);
	}

	thread func_485A(undefined,var_03);
	thread func_485B();
	thread cratewatchgameover();
	for(;;)
	{
		self waittill("captured",var_04);
		if(isplayer(var_04))
		{
			var_04 setclientomnvar("ui_securing",0);
			var_04.var_12B26 = undefined;
		}

		if(isdefined(self.var_222))
		{
			if(var_04 == self.var_222)
			{
				var_04 thread scripts\mp\_missions::func_D991("ch_scorestreak_uses_dronepackage");
			}
			else if(!level.teambased || var_04.team != self.team)
			{
				switch(param_00)
				{
					case "airdrop_osprey_gunner":
					case "airdrop_escort":
					case "airdrop_support":
					case "airdrop_assault":
						var_04 thread scripts\mp\_missions::func_D992("hijacker_airdrop");
						var_04 thread func_8EFC(self,"airdrop");
						break;

					case "airdrop_sentry_minigun":
						var_04 thread scripts\mp\_missions::func_D992("hijacker_airdrop");
						var_04 thread func_8EFC(self,"sentry");
						break;

					case "airdrop_remote_tank":
						var_04 thread scripts\mp\_missions::func_D992("hijacker_airdrop");
						var_04 thread func_8EFC(self,"remote_tank");
						break;

					case "airdrop_mega":
						var_04 thread scripts\mp\_missions::func_D992("hijacker_airdrop_mega");
						var_04 thread func_8EFC(self,"emergency_airdrop");
						break;

					case "dronedrop_highroll":
					case "jackaldrop":
					case "dronedrop_reroll":
					case "dronedrop":
						var_04 thread func_8EFC(self,"dronedrop");
						var_04 thread scripts\mp\_missions::func_D991("ch_hijack");
						break;
				}
			}
			else if(level.gametype != "grnd")
			{
				self.var_222 thread scripts\mp\_awards::func_8380("ss_use_dronedrop");
				self.var_222 thread scripts\mp\_missions::func_D991("ch_package_share");
			}
		}

		var_04 playlocalsound("ammo_crate_use");
		var_05 = undefined;
		if(scripts\mp\_utility::func_9FB3(level.enablevariantdrops))
		{
			var_05 = scripts\mp\_killstreak_loot::getrandomvariantfrombaseref(self.var_485F);
		}

		if(isdefined(var_05))
		{
			var_06 = scripts\mp\_killstreak_loot::func_804B(var_05);
			var_04 thread scripts\mp\killstreaks\_killstreaks::func_26D4(self.var_485F,self.var_222,var_06,var_05);
			var_07 = scripts\mp\_killstreak_loot::getrarityforlootitem(var_05);
			var_08 = self.var_485F + "_" + var_07;
			var_04 scripts\mp\_hud_message::func_10134(var_08,undefined,1);
		}
		else
		{
			var_04 thread scripts\mp\killstreaks\_killstreaks::func_8374(self.var_485F,0,0,self.var_222);
			var_04 scripts\mp\_hud_message::func_10134(self.var_485F,undefined,1);
		}

		if(scripts\mp\killstreaks\_killstreaks::func_817B(self.var_485F) > 1000)
		{
			var_04 thread scripts\mp\_missions::func_D991("ch_dronepackage_jackpot");
		}

		func_51AA();
	}
}

//Function Number: 90
killstreakbombcratethink(param_00)
{
	self endon("restarting_physics");
	self endon("death");
	if(isdefined(self.var_222))
	{
		self.var_222 endon("disconnect");
	}

	var_01 = [&"KILLSTREAKS_HINTS_SENTRY_SHOCK_PICKUP",&"KILLSTREAKS_HINTS_JACKAL_PICKUP",&"KILLSTREAKS_HINTS_THOR_PICKUP",&"KILLSTREAKS_HINTS_RC8_PICKUP",&"KILLSTREAKS_HINTS_MINI_JACKAL_PICKUP"];
	var_02 = scripts\common\utility::random(var_01);
	var_03 = undefined;
	if(level.gametype == "grnd")
	{
		var_03 = -10000;
	}

	if(!scripts\mp\_utility::func_9FB3(level.var_7669))
	{
		func_485D(var_02,"hud_icon_trap_package",0,var_03);
	}

	thread func_485A();
	thread cratewatchgameover();
	thread cratewatchownerdisconnect();
	if(isdefined(self.var_A63A))
	{
		self.var_A63A unlink();
		self.var_A63A moveto(self.origin + (0,0,30),0.05);
	}

	self waittill("captured",var_04);
	if(isplayer(var_04))
	{
		var_04 setclientomnvar("ui_securing",0);
		var_04.var_12B26 = undefined;
	}

	var_04 playlocalsound("ammo_crate_use");
	var_05 = self.var_222 scripts\mp\_utility::func_1302("dummy_spike_mp",self.origin,self.origin,2);
	if(!isdefined(var_05.var_13C2E))
	{
		var_05.var_13C2E = "dummy_spike_mp";
	}

	var_05 linkto(self);
	var_06 = 0.1;
	var_07 = 0;
	while(var_07 < 0.8)
	{
		playsoundatpos(self.origin + (0,0,10),"mp_dronepackage_trap_warning");
		var_07 = var_07 + var_06;
		wait(var_06);
	}

	playfx(scripts\common\utility::getfx("crate_explode"),self.origin);
	playsoundatpos(self.origin,"mp_equip_destroyed");
	scripts\mp\_shellshock::func_22FF(1,0.7,800);
	if(isdefined(self.var_222))
	{
		self radiusdamage(self.origin,256,200,100,self.var_222,"MOD_EXPLOSIVE","jackal_fast_cannon_mp");
	}

	func_51AA();
}

//Function Number: 91
cratewatchownerdisconnect()
{
	self endon("death");
	self.var_222 waittill("disconnect");
	func_51AA();
}

//Function Number: 92
cratewatchgameover()
{
	self endon("death");
	level scripts\common\utility::waittill_any_3("bro_shot_start","game_ended");
	if(isdefined(self))
	{
		func_51AA();
	}
}

//Function Number: 93
dronewatchgameover()
{
	self endon("death");
	level scripts\common\utility::waittill_any_3("bro_shot_start","game_ended");
	if(isdefined(self))
	{
		self notify("death");
	}
}

//Function Number: 94
func_C1B6(param_00)
{
	self endon("restarting_physics");
	self endon("death");
	func_485D(&"PLATFORM_CALL_NUKE",scripts\mp\_utility::func_7F49(self.var_485F));
	thread func_C1B4();
	for(;;)
	{
		self waittill("captured",var_01);
		var_01 thread scripts\mp\killstreaks\_killstreaks::func_729F(self.var_485F);
		level notify("nukeCaptured",var_01);
		if(isdefined(level.var_86AD) && level.var_86AD)
		{
			var_01.var_3A3E = 1;
		}

		var_01 playlocalsound("ammo_crate_use");
		func_51AA();
	}
}

//Function Number: 95
func_A4A5(param_00)
{
	self endon("restarting_physics");
	self endon("death");
	func_485D(game["strings"][self.var_485F + "_hint"],scripts\mp\_utility::func_7F49(self.var_485F));
	thread func_485A();
	thread func_485B();
	for(;;)
	{
		self waittill("captured",var_01);
		if(isdefined(self.var_222) && var_01 != self.var_222)
		{
			if(!level.teambased || var_01.team != self.team)
			{
				if(self.var_485F == "airdrop_juggernaut_maniac")
				{
					var_01 thread func_8EFC(self,"maniac");
				}
				else if(scripts\mp\_utility::isstrstart(self.var_485F,"juggernaut_"))
				{
					var_01 thread func_8EFC(self,self.var_485F);
				}
				else
				{
					var_01 thread func_8EFC(self,"juggernaut");
				}
			}
			else if(self.var_485F == "airdrop_juggernaut_maniac")
			{
				self.var_222 scripts\mp\_hud_message::func_10151("giveaway_juggernaut_maniac",undefined,var_01);
			}
			else if(scripts\mp\_utility::isstrstart(self.var_485F,"juggernaut_"))
			{
				self.var_222 scripts\mp\_hud_message::func_10151("giveaway_" + self.var_485F,undefined,var_01);
			}
			else
			{
				self.var_222 scripts\mp\_hud_message::func_10151("giveaway_juggernaut",undefined,var_01);
			}
		}

		var_01 playlocalsound("ammo_crate_use");
		var_02 = "juggernaut";
		switch(self.var_485F)
		{
			case "airdrop_juggernaut":
				var_02 = "juggernaut";
				break;
	
			case "airdrop_juggernaut_recon":
				var_02 = "juggernaut_recon";
				break;
	
			case "airdrop_juggernaut_maniac":
				var_02 = "juggernaut_maniac";
				break;
	
			default:
				if(scripts\mp\_utility::isstrstart(self.var_485F,"juggernaut_"))
				{
					var_02 = self.var_485F;
				}
				break;
		}

		var_01 thread scripts\mp\killstreaks\_juggernaut::func_8371(var_02);
		func_51AA();
	}
}

//Function Number: 96
func_F264(param_00)
{
	self endon("death");
	func_485D(game["strings"]["sentry_hint"],scripts\mp\_utility::func_7F49(self.var_485F));
	thread func_485A();
	thread func_485B();
	for(;;)
	{
		self waittill("captured",var_01);
		if(isdefined(self.var_222) && var_01 != self.var_222)
		{
			if(!level.teambased || var_01.team != self.team)
			{
				if(issubstr(param_00,"airdrop_sentry"))
				{
					var_01 thread func_8EFC(self,"sentry");
				}
				else
				{
					var_01 thread func_8EFC(self,"emergency_airdrop");
				}
			}
			else
			{
				self.var_222 thread scripts\mp\_utility::func_83B4("killstreak_giveaway",undefined,int(scripts\mp\killstreaks\_killstreaks::func_817B("sentry") / 10) * 50);
				self.var_222 scripts\mp\_hud_message::func_10151("giveaway_sentry",undefined,var_01);
			}
		}

		var_01 playlocalsound("ammo_crate_use");
		var_01 thread func_F26F();
		func_51AA();
	}
}

//Function Number: 97
func_51AA()
{
	self notify("crate_deleting");
	if(isdefined(self.var_13074))
	{
		foreach(var_01 in self.var_13074)
		{
			var_01 setclientomnvar("ui_securing",0);
			var_01.var_12B26 = undefined;
		}
	}

	if(isdefined(self.minimapid))
	{
		scripts\mp\objidpoolmanager::returnminimapid(self.minimapid);
	}

	if(isdefined(self.var_2C43) && isdefined(self.var_2C43.var_A63A))
	{
		self.var_2C43.var_A63A delete();
	}

	if(isdefined(self.var_2C43))
	{
		self.var_2C43 delete();
	}

	if(isdefined(self.var_A63A))
	{
		self.var_A63A delete();
	}

	if(isdefined(self.var_5EF1))
	{
		playfx(scripts\common\utility::getfx("airdrop_crate_destroy"),self.origin);
	}

	if(isdefined(self.var_BE6F))
	{
		self notify("nav_obstacle_destroyed");
		destroynavobstacle(self.var_BE6F);
		self.var_BE6F = undefined;
	}

	self delete();
}

//Function Number: 98
func_F26F()
{
	if(!scripts\mp\killstreaks\_autosentry::func_83A3("sentry_minigun",0,0))
	{
		scripts\mp\killstreaks\_killstreaks::func_8374("sentry");
	}
}

//Function Number: 99
func_8EFC(param_00,param_01)
{
	self notify("hijacker",param_01,param_00.var_222);
}

//Function Number: 100
func_DE4B(param_00)
{
	var_01 = self getweaponslistall();
	if(param_00)
	{
	}

	foreach(var_03 in var_01)
	{
		if(issubstr(var_03,"grenade") || getsubstr(var_03,0,2) == "gl")
		{
			if(!param_00 || self method_80FB(var_03) >= 1)
			{
				continue;
			}
		}

		self givemaxammo(var_03);
	}
}

//Function Number: 101
func_13093(param_00,param_01,param_02,param_03)
{
	scripts\mp\_movers::func_EE3E(param_00);
	param_00 scripts\common\utility::allow_weapon(0);
	self.var_4B30 = 0;
	self.var_9B04 = 1;
	self.userate = 0;
	if(isdefined(param_03))
	{
		param_03 func_12E80();
	}

	if(isdefined(param_01))
	{
		self.var_130EE = param_01;
	}
	else
	{
		self.var_130EE = 3000;
	}

	var_04 = func_13094(param_00);
	if(isalive(param_00))
	{
		param_00 scripts\common\utility::allow_weapon(1);
	}

	if(isdefined(param_00))
	{
		scripts\mp\_movers::func_EE4D(param_00);
	}

	if(!isdefined(self))
	{
		return 0;
	}

	self.var_9B04 = 0;
	self.var_4B30 = 0;
	if(isdefined(param_03))
	{
		param_03 func_12E80();
	}

	return var_04;
}

//Function Number: 102
func_13094(param_00)
{
	while(param_00 scripts\mp\killstreaks\_deployablebox::func_9EFD(self))
	{
		if(!param_00 scripts\mp\_movers::func_EE4E(self))
		{
			param_00 scripts\mp\_gameobjects::func_12F53(self,0);
			return 0;
		}

		self.var_4B30 = self.var_4B30 + 50 * self.userate;
		if(isdefined(self.var_C2AD))
		{
			self.userate = 1 * self.var_C2AD;
		}
		else
		{
			self.userate = 1;
		}

		param_00 scripts\mp\_gameobjects::func_12F53(self,1);
		if(self.var_4B30 >= self.var_130EE)
		{
			param_00 scripts\mp\_gameobjects::func_12F53(self,0);
			return scripts\mp\_utility::func_9F19(param_00);
		}

		wait(0.05);
	}

	if(isdefined(self))
	{
		param_00 scripts\mp\_gameobjects::func_12F53(self,0);
	}

	return 0;
}

//Function Number: 103
func_4A2D()
{
	var_00 = spawn("script_origin",self.origin);
	var_00.var_4B30 = 0;
	var_00.var_130EE = 0;
	var_00.userate = 3000;
	var_00.var_9B04 = 0;
	var_00.var_92B8 = self.var_92B8;
	var_00 linkto(self);
	var_00 thread func_51D9(self);
	return var_00;
}

//Function Number: 104
func_51D9(param_00)
{
	self endon("death");
	param_00 waittill("death");
	if(isdefined(self.var_13074))
	{
		foreach(var_02 in self.var_13074)
		{
			var_02 setclientomnvar("ui_securing",0);
			var_02.var_12B26 = undefined;
		}
	}

	self delete();
}

//Function Number: 105
func_1A9C()
{
	self endon("death");
	self waittill("missile_stuck");
	self method_8099();
}

//Function Number: 106
func_117FE(param_00,param_01,param_02,param_03)
{
	if(isdefined(level.var_3A59))
	{
		foreach(var_05 in level.var_3A59)
		{
			if(isdefined(var_05.var_9B04) && var_05.var_9B04)
			{
				continue;
			}

			var_06 = var_05 getlinkedparent();
			if(isdefined(var_06) && var_06 == param_00)
			{
				thread func_1077C(var_05,param_01,param_02);
				if(isdefined(param_03))
				{
					scripts\common\utility::func_5127(1,::func_DFD5,param_03);
				}
			}
		}
	}
}

//Function Number: 107
func_1077C(param_00,param_01,param_02)
{
	var_03 = param_00.var_222;
	var_04 = param_00.var_5EF1;
	var_05 = param_00.var_485F;
	var_06 = param_00.origin;
	param_00 func_51AA();
	var_07 = var_03 func_4982(var_03,var_04,var_05,var_06 + param_01,var_06 + param_01);
	var_07.var_5D44 = 1;
	var_07 thread [[ level.var_4860[var_07.var_5EF1][var_07.var_485F].var_74C2 ]](var_07.var_5EF1);
	scripts\common\utility::func_136F7();
	var_07 physicslaunchserver(var_07.origin,param_02);
	if(isbot(var_07.var_222))
	{
		wait(0.1);
		var_07.var_222 notify("new_crate_to_take");
	}
}

//Function Number: 108
func_DFD5(param_00)
{
	if(isdefined(level.var_3A59))
	{
		foreach(var_02 in level.var_3A59)
		{
			if(isdefined(var_02) && isdefined(var_02.var_741D) && var_02.var_741D istouching(param_00))
			{
				var_02 func_51AA();
			}
		}
	}
}

//Function Number: 109
func_7971()
{
	return "care_package_iw7_dummy";
}

//Function Number: 110
func_797B()
{
	return "care_package_iw7_ca_wm";
}

//Function Number: 111
func_79D1()
{
	return "care_package_iw7_un_wm";
}

//Function Number: 112
dropzoneaddcratetypes()
{
	func_17BF("dronedrop_grnd","jackal",15,::func_A693,"care_package_iw7_un_wm","care_package_iw7_ca_wm",&"KILLSTREAKS_HINTS_JACKAL_PICKUP",undefined,"care_package_iw7_dummy");
	func_17BF("dronedrop_grnd","thor",10,::func_A693,"care_package_iw7_un_wm","care_package_iw7_ca_wm",&"KILLSTREAKS_HINTS_THOR_PICKUP",undefined,"care_package_iw7_dummy");
	func_17BF("dronedrop_grnd","directional_uav",10,::func_A693,"care_package_iw7_un_wm","care_package_iw7_ca_wm",&"KILLSTREAKS_HINTS_DIRECTIONAL_UAV_PICKUP",undefined,"care_package_iw7_dummy");
	func_17BF("dronedrop_grnd","remote_c8",5,::func_A693,"care_package_iw7_un_wm","care_package_iw7_ca_wm",&"KILLSTREAKS_HINTS_RC8_PICKUP",undefined,"care_package_iw7_dummy");
	func_17BF("dronedrop_grnd","minijackal",5,::func_A693,"care_package_iw7_un_wm","care_package_iw7_ca_wm",&"KILLSTREAKS_HINTS_MINI_JACKAL_PICKUP",undefined,"care_package_iw7_dummy");
	func_7730();
}