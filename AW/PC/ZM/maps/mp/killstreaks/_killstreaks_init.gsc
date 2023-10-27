/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps/mp/killstreaks/_killstreaks_init.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 48 ms
 * Timestamp: 10/27/2023 2:09:37 AM
*******************************************************************/

//Function Number: 1
init()
{
	level.killstreak_string_table = "mp/killstreakTable.csv";
	level.killstreak_gimme_slot = 0;
	level.killstreak_slot_1 = 1;
	level.killstreak_slot_2 = 2;
	level.killstreak_slot_3 = 3;
	level.killstreak_slot_4 = 4;
	level.killstreak_stacking_start_slot = 5;
	level.ks_modules_table = "mp/killstreakModules.csv";
	level.ks_module_ref_column = 1;
	level.ks_module_killstreak_ref_column = 4;
	level.ks_module_added_points_column = 5;
	level.ks_module_slot_column = 6;
	level.ks_module_support_column = 7;
	level.killstreakrounddelay = maps\mp\_utility::getintproperty("scr_game_killstreakdelay",10);
	level.killstreakfuncs = [];
	level.killstreaksetupfuncs = [];
	level.killstreakwieldweapons = [];
	initkillstreakdata();
	level thread maps\mp\killstreaks\_killstreaks::onplayerconnect();
	if(isdefined(level.iszombiegame) && level.iszombiegame)
	{
		return;
	}

	level thread maps\mp\killstreaks\_aerial_utility::init();
	level thread maps\mp\killstreaks\_coop_util::init();
	if(isdefined(level.mapcustomkillstreakfunc))
	{
		[[ level.mapcustomkillstreakfunc ]]();
	}

	level thread maps\mp\killstreaks\_uav::init();
	level thread maps\mp\killstreaks\_airdrop::init();
	level thread maps\mp\killstreaks\_remoteturret::init();
	level thread maps\mp\killstreaks\_rippedturret::init();
	level thread maps\mp\killstreaks\_emp::init();
	level thread maps\mp\killstreaks\_nuke::init();
	level thread maps\mp\killstreaks\_juggernaut::init();
	level thread maps\mp\killstreaks\_orbital_strike::init();
	level thread maps\mp\killstreaks\_missile_strike::init();
	level thread maps\mp\killstreaks\_orbital_carepackage::init();
	level thread maps\mp\killstreaks\_warbird::init();
	level thread maps\mp\killstreaks\_drone_assault::init();
	level thread maps\mp\killstreaks\_drone_recon::init();
	level thread maps\mp\killstreaks\_orbitalsupport::init();
	level thread maps\mp\killstreaks\_airstrike::init();
	level thread maps\mp\killstreaks\_drone_carepackage::init();
	level thread maps\mp\killstreaks\_orbital_util::initstart();
}

//Function Number: 2
initkillstreakdata()
{
	var_00 = 0;
	for(;;)
	{
		var_01 = tablelookupbyrow(level.killstreak_string_table,var_00,1);
		if(!isdefined(var_01) || var_01 == "")
		{
			break;
		}

		if(var_01 == "b1" || var_01 == "none")
		{
		}
		else
		{
			var_02 = tablelookupistringbyrow(level.killstreak_string_table,var_00,5);
			var_03 = tablelookupbyrow(level.killstreak_string_table,var_00,7);
			game["dialog"][var_01] = var_03;
			var_04 = tablelookupbyrow(level.killstreak_string_table,var_00,8);
			game["dialog"]["allies_friendly_" + var_01 + "_inbound"] = "ks_" + var_04 + "_allyuse";
			game["dialog"]["allies_enemy_" + var_01 + "_inbound"] = "ks_" + var_04 + "_enemyuse";
			var_05 = tablelookupbyrow(level.killstreak_string_table,var_00,9);
			game["dialog"]["axis_friendly_" + var_01 + "_inbound"] = "ks_" + var_05 + "_allyuse";
			game["dialog"]["axis_enemy_" + var_01 + "_inbound"] = "ks_" + var_05 + "_enemyuse";
			var_06 = int(tablelookupbyrow(level.killstreak_string_table,var_00,12));
			maps\mp\gametypes\_rank::registerxpeventinfo(var_01 + "_earned",var_06);
		}

		var_00++;
	}

	additionalvo();
}

//Function Number: 3
additionalvo()
{
	var_00 = "allies_friendly_emp_inbound";
	var_01 = "allies_enemy_emp_inbound";
	var_02 = "axis_friendly_emp_inbound";
	var_03 = "axis_enemy_emp_inbound";
	for(var_04 = 1;var_04 < 9;var_04++)
	{
		var_05 = "_0" + var_04;
		game["dialog"][var_00 + var_05] = game["dialog"][var_00] + var_05;
		game["dialog"][var_01 + var_05] = game["dialog"][var_01] + var_05;
		game["dialog"][var_02 + var_05] = game["dialog"][var_02] + var_05;
		game["dialog"][var_03 + var_05] = game["dialog"][var_03] + var_05;
	}
}