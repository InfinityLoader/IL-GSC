/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\killstreaks\_killstreaks_init.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 22 ms
 * Timestamp: 10/27/2023 3:25:03 AM
*******************************************************************/

//Function Number: 1
func_00D5()
{
	if(isdefined(level.var_585D) && level.var_585D && !isdefined(level.zombiekillstreaksenabled) || isdefined(level.zombiekillstreaksenabled) && !level.zombiekillstreaksenabled)
	{
		return;
	}

	if(maps\mp\_utility::func_571D())
	{
		maps\mp\_utility::func_2F6D();
	}

	if(maps\mp\_utility::func_571D())
	{
		return;
	}

	level.var_5A70 = maps\mp\_utility::func_4529("scr_game_killstreakdelay",10);
	level.var_5A61 = [];
	level.var_5A75 = [];
	level.var_5A7D = [];
	if(maps\mp\_utility::func_585F() && isdefined(level.zombiekillstreaksenabled) && level.zombiekillstreaksenabled)
	{
		level thread lib_0527::func_52F7();
		return;
	}

	func_5312();
	level thread maps\mp\killstreaks\_killstreaks::func_6B6C();
	if(maps\mp\_utility::func_579B() || maps\mp\_utility::isprophuntgametype())
	{
		level thread lib_0527::func_52F7();
		level thread maps\mp\killstreaks\_paratroopers::func_D5();
		level thread maps/mp/killstreaks/_basic_training_serum::func_D5();
		return;
	}

	setdvar("scorestreak_enabled_uav",1);
	setdvar("scorestreak_enabled_carepackage",1);
	setdvar("scorestreak_enabled_counter_uav",1);
	setdvar("scorestreak_enabled_flamethrower",1);
	setdvar("scorestreak_enabled_fritzx",1);
	setdvar("scorestreak_enabled_mortar_strike",1);
	setdvar("scorestreak_enabled_missile_strike",1);
	setdvar("scorestreak_enabled_airstrike",1);
	setdvar("scorestreak_enabled_firebomb",1);
	setdvar("scorestreak_enabled_emergency_carepackage",1);
	setdvar("scorestreak_enabled_fighter_strike",1);
	setdvar("scorestreak_enabled_advanced_uav",0);
	setdvar("scorestreak_enabled_attack_dogs",1);
	setdvar("scorestreak_enabled_flak_gun",1);
	setdvar("scorestreak_enabled_v2_rocket",1);
	setdvar("scorestreak_enabled_plane_gunner",1);
	setdvar("scorestreak_enabled_paratroopers",1);
	setdvar("scorestreak_enabled_molotovs",1);
	level thread lib_0526::func_52F6();
	level thread lib_0527::func_52F7();
	level thread lib_0529::func_52F4();
	level thread maps\mp\killstreaks\_v2_missle_strike::func_52F5();
	level thread lib_0528::func_52F3();
	level thread maps\mp\killstreaks\_uav::func_D5();
	level thread maps\mp\killstreaks\_missile_strike::func_D5();
	level thread maps\mp\killstreaks\_airstrike::func_D5();
	level thread maps\mp\killstreaks\_glidebomb::func_D5();
	level thread lib_0517::func_D5();
	level thread maps\mp\killstreaks\_mortarstrike::func_D5();
	level thread lib_0518::func_D5();
	level thread maps\mp\killstreaks\_dog_killstreak::func_D5();
	level thread maps\mp\killstreaks\_firebomb::func_D5();
	level thread maps\mp\killstreaks\_flamethrower::func_D5();
	level thread maps\mp\killstreaks\_v2_nuke::func_D5();
	level thread maps\mp\killstreaks\_flak_gun::func_D5();
	level thread maps\mp\killstreaks\_plane_gunner::func_D5();
	level thread maps\mp\killstreaks\_fighter_strike::func_D5();
	level thread maps\mp\killstreaks\_paratroopers::func_D5();
	level thread maps\mp\killstreaks\_molotovs::func_D5();
	level thread maps/mp/killstreaks/_basic_training_serum::func_D5();
}

//Function Number: 2
func_5312()
{
	var_00 = 0;
	for(;;)
	{
		var_01 = tablelookupbyrow("mp/killstreakTable.csv",var_00,1);
		if(!isdefined(var_01) || var_01 == "")
		{
			break;
		}

		if(var_01 == "b1" || var_01 == "none")
		{
		}
		else
		{
			var_02 = function_01B0("mp/killstreakTable.csv",var_00,10);
			var_03 = tablelookupbyrow("mp/killstreakTable.csv",var_00,12);
			game["dialog"][var_01] = var_03;
			var_04 = tablelookupbyrow("mp/killstreakTable.csv",var_00,13);
			game["dialog"]["allies_friendly_" + var_01 + "_inbound"] = "ss_" + var_04 + "_allyuse";
			game["dialog"]["allies_enemy_" + var_01 + "_inbound"] = "ss_" + var_04 + "_enemyuse";
			var_05 = tablelookupbyrow("mp/killstreakTable.csv",var_00,14);
			game["dialog"]["axis_friendly_" + var_01 + "_inbound"] = "ss_" + var_05 + "_allyuse";
			game["dialog"]["axis_enemy_" + var_01 + "_inbound"] = "ss_" + var_05 + "_enemyuse";
			var_06 = int(tablelookupbyrow("mp/killstreakTable.csv",var_00,17));
			maps\mp\gametypes\_rank::func_7C06(var_01 + "_earned",var_06);
		}

		var_00++;
	}
}