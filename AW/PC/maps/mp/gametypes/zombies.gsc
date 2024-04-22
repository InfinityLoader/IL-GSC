/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\gametypes\zombies.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 157
 * Decompile Time: 2441 ms
 * Timestamp: 4/22/2024 2:11:19 AM
*******************************************************************/

//Function Number: 1
main()
{
	setzombiesdlclevel();
	maps\mp\gametypes\_globallogic::init();
	lib_0540::setupcallbacks();
	maps\mp\gametypes\_globallogic::setupcallbacks();
	maps\mp\zombies\_mutators::main();
	if(isusingmatchrulesdata())
	{
		level.initializematchrules = ::initializematchrules;
		[[ level.initializematchrules ]]();
		level thread maps\mp\_utility::reinitializematchrulesonmigration();
	}
	else
	{
		maps\mp\_utility::registerroundswitchdvar(level.gametype,0,0,9);
		maps\mp\_utility::registertimelimitdvar(level.gametype,0);
		maps\mp\_utility::registerscorelimitdvar(level.gametype,0);
		maps\mp\_utility::registerroundlimitdvar(level.gametype,1);
		maps\mp\_utility::registerwinlimitdvar(level.gametype,1);
		maps\mp\_utility::registernumlivesdvar(level.gametype,1);
		maps\mp\_utility::registerhalftimedvar(level.gametype,0);
	}

	setdynamicdvar("r_hudOutlineWidth",2);
	setdynamicdvar("scr_zombies_timeLimit",0);
	setdynamicdvar("scr_zombies_numLives",1);
	setdynamicdvar("hover_max_travel_distance",5000);
	setdynamicdvar("scr_game_matchstarttime",0);
	setdynamicdvar("scr_game_playerwaittime",5);
	setdynamicdvar("scr_game_playerwaittime_ds",5);
	setdynamicdvar("scr_game_graceperiod",5);
	setdynamicdvar("scr_game_graceperiod_ds",5);
	setdynamicdvar("scr_player_healthregentime",3);
	maps\mp\_utility::registertimelimitdvar(level.gametype,0);
	setspecialloadouts();
	initpickups();
	loadeffects();
	level.teambased = 1;
	level.iszombiegame = 1;
	level.disableforfeit = 1;
	level.alwaysdrawfriendlynames = 1;
	level.scorelimitoverride = 1;
	level.allowlatecomers = 1;
	level.skiplivesxpscalar = 1;
	level.nocratetimeout = 1;
	level.assists_disabled = 1;
	level.skipspawnsighttraces = 1;
	level.killstreakrewards = 0;
	level.disableweaponstats = 1;
	level.gamehasstarted = 0;
	level.rankedmatch = 0;
	level.playerteam = "allies";
	level.enemyteam = "axis";
	level.spawndistanceteamskip = "axis";
	level.laststandusetime = 2000;
	level.grenadegraceperiod = 0;
	level.playermeleedamage = 150;
	level.playerexomeleedamage = 500;
	level.tokensenabled = 0;
	level.modifyweapondamage = [];
	level.damageweapontoweapon = [];
	level.onstartgametype = ::onstartgametype;
	level.getspawnpoint = ::getspawnpoint;
	level.onnormaldeath = ::onnormaldeath;
	level.onspawnplayer = ::onplayerspawn;
	level.modifyplayerdamage = ::modifyplayerdamagezombies;
	level.callbackplayerlaststand = ::maps\mp\zombies\_zombies_laststand::callback_playerlaststandzombies;
	level.callbackplayerdamage = ::callback_playerdamage;
	level.bypassclasschoicefunc = ::zombiegameclass;
	level.ondeadevent = ::ondeadevent;
	level.onsuicidedeath = ::onsuicidedeath;
	level.weapondropfunction = ::dropweaponfordeathzombies;
	level.autoassign = ::zombiesautoassign;
	level.groundslam = ::maps\mp\zombies\_terminals::zombiesgroundslam;
	level.groundslamhitplayer = ::maps\mp\zombies\_terminals::zombiesgroundslamhitplayer;
	level.weaponweightfunc = ::zombieweaponweight;
	level.customcratefunc = ::maps\mp\zombies\killstreaks\_zombie_killstreaks::airdropcustomfunc;
	level.customplaydeathsound = ::maps\mp\zombies\_zombies_audio::zmplaydeathsound;
	level.customplaydamagesound = ::maps\mp\zombies\_zombies_audio::zmplaydamagesound;
	level.bot_killstreak_setup_func = ::maps\mp\zombies\killstreaks\_zombie_killstreaks::bot_killstreak_setup;
	level.cb_usedkillstreak = ::maps\mp\zombies\_util::removeksicon;
	level.callbackplayergrenadesuicide = ::ongrenadesuicide;
	level.disablespawningforplayerfunc = ::disablespawningforplayerfunc;
	level.hurttriggerfunc = ::hurtplayersthink;
	level.moversuicidecustom = ::moversuicidecustom;
}

//Function Number: 2
loadeffects()
{
	level._effect["mutant_blood_pool"] = loadfx("vfx/blood/dlc_zombie_gib_bloodpool");
	level._effect["mutant_gib_death"] = loadfx("vfx/blood/dlc_zombie_gib_burst");
	level._effect["electrical_arc"] = loadfx("fx/misc/electrical_arc");
	level._effect["slow_zone"] = loadfx("vfx/test/hms_mutant_ooze_impact_burst");
	level._effect["boost_jump"] = loadfx("vfx/code/high_jump_jetpack");
	level._effect["boost_lunge"] = loadfx("vfx/code/dodge_forward_jetpack");
	level._effect["boost_dodge_back"] = loadfx("vfx/code/dodge_back_jetpack");
	level._effect["boost_dodge_right"] = loadfx("vfx/code/dodge_right_jetpack");
	level._effect["boost_dodge_left"] = loadfx("vfx/code/dodge_left_jetpack");
	level._effect["torso_arm_loss_left"] = loadfx("vfx/blood/dlc_zombie_torso_loss_arm_le");
	level._effect["torso_arm_loss_left_emz"] = loadfx("vfx/gameplay/mp/zombie/zombie_torso_dismem_arm_le_emz");
	level._effect["torso_arm_loss_left_ovr"] = loadfx("vfx/gameplay/mp/zombie/zombie_torso_dismem_arm_le_chrz");
	level._effect["torso_arm_loss_left_exp"] = loadfx("vfx/gameplay/mp/zombie/zombie_torso_dismem_arm_le_xplod");
	level._effect["torso_arm_loss_right"] = loadfx("vfx/blood/dlc_zombie_torso_loss_arm_ri");
	level._effect["torso_arm_loss_right_emz"] = loadfx("vfx/gameplay/mp/zombie/zombie_torso_dismem_arm_ri_emz");
	level._effect["torso_arm_loss_right_ovr"] = loadfx("vfx/gameplay/mp/zombie/zombie_torso_dismem_arm_ri_chrz");
	level._effect["torso_arm_loss_right_exp"] = loadfx("vfx/gameplay/mp/zombie/zombie_torso_dismem_arm_ri_xplod");
	level._effect["torso_head_loss"] = loadfx("vfx/blood/dlc_zombie_torso_loss_head");
	level._effect["torso_head_loss_emz"] = loadfx("vfx/gameplay/mp/zombie/zombie_torso_dismem_head_emz");
	level._effect["torso_head_loss_ovr"] = loadfx("vfx/gameplay/mp/zombie/zombie_torso_dismem_head_ovrchrz");
	level._effect["torso_head_loss_exp"] = loadfx("vfx/gameplay/mp/zombie/zombie_torso_dismem_head_xplod");
	level._effect["torso_loss_left"] = loadfx("vfx/blood/dlc_zombie_torso_loss_impact_le");
	level._effect["torso_loss_left_emz"] = loadfx("vfx/gameplay/mp/zombie/zombie_torso_dismem_leg_le_emz");
	level._effect["torso_loss_left_ovr"] = loadfx("vfx/gameplay/mp/zombie/zombie_torso_dismem_leg_le_chrz");
	level._effect["torso_loss_left_exp"] = loadfx("vfx/gameplay/mp/zombie/zombie_torso_dismem_leg_le_xplod");
	level._effect["torso_loss_right"] = loadfx("vfx/blood/dlc_zombie_torso_loss_impact_ri");
	level._effect["torso_loss_right_emz"] = loadfx("vfx/gameplay/mp/zombie/zombie_torso_dismem_leg_ri_emz");
	level._effect["torso_loss_right_ovr"] = loadfx("vfx/gameplay/mp/zombie/zombie_torso_dismem_leg_ri_chrz");
	level._effect["torso_loss_right_exp"] = loadfx("vfx/gameplay/mp/zombie/zombie_torso_dismem_leg_ri_xplod");
	level._effect["arm_loss_left"] = loadfx("vfx/blood/dlc_zombie_arm_loss_impact_le");
	level._effect["arm_loss_left_emz"] = loadfx("vfx/gameplay/mp/zombie/zombie_limb_dismem_arm_le_emz");
	level._effect["arm_loss_left_ovr"] = loadfx("vfx/gameplay/mp/zombie/zombie_limb_dismem_arm_le_ovrchrz");
	level._effect["arm_loss_left_exp"] = loadfx("vfx/gameplay/mp/zombie/zombie_limb_dismem_arm_le_xplod");
	level._effect["arm_loss_right"] = loadfx("vfx/blood/dlc_zombie_arm_loss_impact_ri");
	level._effect["arm_loss_right_emz"] = loadfx("vfx/gameplay/mp/zombie/zombie_limb_dismem_arm_ri_emz");
	level._effect["arm_loss_right_ovr"] = loadfx("vfx/gameplay/mp/zombie/zombie_limb_dismem_arm_ri_ovrchrz");
	level._effect["arm_loss_right_exp"] = loadfx("vfx/gameplay/mp/zombie/zombie_limb_dismem_arm_ri_xplod");
	level._effect["head_loss"] = loadfx("vfx/blood/dlc_zombie_head_loss_impact");
	level._effect["head_loss_emz"] = loadfx("vfx/gameplay/mp/zombie/zombie_limb_dismem_head_emz");
	level._effect["head_loss_ovr"] = loadfx("vfx/gameplay/mp/zombie/zombie_limb_dismem_head_ovrchrz");
	level._effect["head_loss_exp"] = loadfx("vfx/gameplay/mp/zombie/zombie_limb_dismem_head_xplod");
	level._effect["limb_loss_left"] = loadfx("vfx/blood/dlc_zombie_limb_loss_impact_le");
	level._effect["limb_loss_left_emz"] = loadfx("vfx/gameplay/mp/zombie/zombie_limb_dismem_leg_le_emz");
	level._effect["limb_loss_left_ovr"] = loadfx("vfx/gameplay/mp/zombie/zombie_limb_dismem_leg_le_ovrchrz");
	level._effect["limb_loss_left_exp"] = loadfx("vfx/gameplay/mp/zombie/zombie_limb_dismem_leg_le_xplod");
	level._effect["limb_loss_right"] = loadfx("vfx/blood/dlc_zombie_limb_loss_impact_ri");
	level._effect["limb_loss_right_emz"] = loadfx("vfx/gameplay/mp/zombie/zombie_limb_dismem_leg_ri_emz");
	level._effect["limb_loss_right_ovr"] = loadfx("vfx/gameplay/mp/zombie/zombie_limb_dismem_leg_ri_ovrchrz");
	level._effect["limb_loss_right_exp"] = loadfx("vfx/gameplay/mp/zombie/zombie_limb_dismem_leg_ri_xplod");
	level._effect["gib_full_body"] = loadfx("vfx/blood/dlc_zombie_gib_full_body");
	level._effect["gib_full_body_cheap"] = loadfx("vfx/blood/dlc_zombie_gib_full_body_cheap");
	level._effect["gib_full_body_emz"] = loadfx("vfx/gameplay/mp/zombie/zombie_gib_full_body_emz");
	level._effect["gib_full_body_ovr"] = loadfx("vfx/gameplay/mp/zombie/zombie_gib_full_body_ovrchrz");
	level._effect["gib_full_body_exp"] = loadfx("vfx/gameplay/mp/zombie/zombie_gib_full_body_xplod");
	level._effect["gib_bloodpool"] = loadfx("vfx/blood/dlc_zombie_blood_tread_fx");
	level._effect["crawl_dust"] = loadfx("vfx/treadfx/DLC/crawl_dust");
	level._effect["nuke_blast"] = loadfx("vfx/gameplay/mp/zombie/zombie_nuke_burst");
	loadeyeeffects();
	level._effect["station_buy_weapon"] = loadfx("vfx/props/dlc_prop_weapon_dispenser_fx_main");
	level._effect["station_buy_weapon_pwr_on"] = loadfx("vfx/props/dlc_prop_weapon_dispenser_icon_pwr_on");
	level._effect["station_buy_exo"] = loadfx("vfx/props/dlc_prop_exo_buy_fx_main");
	level._effect["station_buy_exo_pwr_on"] = loadfx("vfx/props/dlc_prop_exo_buy_icon_pwr_on");
	level._effect["station_buy_exo_pwr_off"] = loadfx("vfx/props/dlc_prop_exo_buy_icon_pwr_off");
	level._effect["station_mystery_box"] = loadfx("vfx/props/dlc_prop_mystery_box_fx_main");
	level._effect["station_mystery_box_icon_on"] = loadfx("vfx/props/dlc_prop_mystery_box_icon_pwr_on");
	level._effect["station_mystery_box_icon_off"] = loadfx("vfx/props/dlc_prop_mystery_box_icon_pwr_off");
	level._effect["station_mystery_box_icon_money"] = loadfx("vfx/props/dlc_prop_mystery_box_icon_money");
	level._effect["station_upgrade_exo"] = loadfx("vfx/props/dlc_prop_exo_upgrade_fx_main");
	level._effect["station_upgrade_exo_health_pwr_on"] = loadfx("vfx/props/dlc_prop_exo_upg_icon_health_pwr_on");
	level._effect["station_upgrade_exo_health_pwr_off"] = loadfx("vfx/props/dlc_prop_exo_upg_icon_health_pwr_off");
	level._effect["station_upgrade_exo_reload_pwr_on"] = loadfx("vfx/props/dlc_prop_exo_upg_icon_reload_pwr_on");
	level._effect["station_upgrade_exo_reload_pwr_off"] = loadfx("vfx/props/dlc_prop_exo_upg_icon_reload_pwr_off");
	level._effect["station_upgrade_exo_revive_pwr_on"] = loadfx("vfx/props/dlc_prop_exo_upg_icon_revive_pwr_on");
	level._effect["station_upgrade_exo_revive_pwr_off"] = loadfx("vfx/props/dlc_prop_exo_upg_icon_revive_pwr_off");
	level._effect["station_upgrade_exo_slam_pwr_on"] = loadfx("vfx/props/dlc_prop_exo_upg_icon_slam_pwr_on");
	level._effect["station_upgrade_exo_slam_pwr_off"] = loadfx("vfx/props/dlc_prop_exo_upg_icon_slam_pwr_off");
	level._effect["station_upgrade_exo_stabilizer_pwr_on"] = loadfx("vfx/props/dlc_prop_exo_upg_icon_stble_pwr_on");
	level._effect["station_upgrade_exo_stabilizer_pwr_off"] = loadfx("vfx/props/dlc_prop_exo_upg_icon_stble_pwr_off");
	level._effect["station_upgrade_exo_tactarmor_pwr_on"] = loadfx("vfx/props/dlc_prop_exo_upg_icon_tact_pwr_on");
	level._effect["station_upgrade_exo_tactarmor_pwr_off"] = loadfx("vfx/props/dlc_prop_exo_upg_icon_tact_pwr_off");
	level._effect["station_upgrade_weapon"] = loadfx("vfx/props/dlc_prop_weapon_upgrade_fx_main");
	level._effect["station_upgrade_weapon_pwr_on"] = loadfx("vfx/props/dlc_prop_weapon_upg_icon_pwr_on");
	level._effect["weapon_cycle_slow"] = loadfx("vfx/props/dlc_prop_mystery_box_weap_lp");
	level._effect["weapon_cycle_fast"] = loadfx("vfx/props/dlc_prop_mystery_box_weap_lp_fast");
	if(maps\mp\zombies\_util::getzombieslevelnum() == 3)
	{
		if(level.currentgen)
		{
		}
		else
		{
			level._effect["weapon_cycle_slow"] = loadfx("vfx/props/dlc3_prop_mystery_box_weap_lp");
			level._effect["weapon_cycle_fast"] = loadfx("vfx/props/dlc3_prop_mystery_box_weap_lp_fast");
		}
	}
	else if(maps\mp\zombies\_util::getzombieslevelnum() == 4)
	{
		if(level.nextgen)
		{
			level._effect["weapon_cycle_slow"] = loadfx("vfx/props/dlc4_prop_mystery_box_weap_lp");
			level._effect["weapon_cycle_fast"] = loadfx("vfx/props/dlc4_prop_mystery_box_weap_lp_fast");
		}
	}

	level._effect["magic_box_move"] = loadfx("vfx/props/dlc_prop_mystery_box_weap_broken");
	level._effect["weapon_level_20"] = loadfx("vfx/props/dlc_prop_weapon_upg_fanfare");
	level._effect["magic_box_steam"] = loadfx("vfx/props/dlc_prop_mystery_box_use");
	level._effect["wall_buy_steam"] = loadfx("vfx/props/dlc_prop_weapon_dispenser_use");
	level._effect["pickup_nuke"] = loadfx("vfx/gameplay/mp/zombie/dlc_pickup_zombies_01_apocalypse");
	level._effect["pickup_doublepoints"] = loadfx("vfx/gameplay/mp/zombie/dlc_pickup_zombies_01_dble_pts");
	level._effect["pickup_instakill"] = loadfx("vfx/gameplay/mp/zombie/dlc_pickup_zombies_01_insta_kill");
	level._effect["pickup_maxammo"] = loadfx("vfx/gameplay/mp/zombie/dlc_pickup_zombies_01_max_ammo");
	level._effect["pickup_firesale"] = loadfx("vfx/gameplay/mp/zombie/dlc_pickup_zombies_01_power_surge");
	level._effect["pickup_tombstone"] = loadfx("vfx/gameplay/mp/zombie/dlc_pickup_zombies_01_tombstone");
	level._effect["pickup_trap"] = loadfx("vfx/gameplay/mp/zombie/dlc_pickup_zombies_01_trap");
}

//Function Number: 3
loadeyeeffectsfortype(param_00,param_01)
{
	if(!isdefined(level.valideyetypes))
	{
		level.valideyetypes = ["vanilla","emp","exploder","fast"];
	}

	if(isdefined(level.addvalideyetypesfunc))
	{
		[[ level.addvalideyetypesfunc ]]();
	}

	if(!isdefined(level.validheadtypes))
	{
		level.validheadtypes = ["afr_dlc_a","afr_dlc_b","afr_dlc_c","cau_dlc_a","cau_dlc_b","cau_dlc_c","shg_dlc_b"];
	}

	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	var_02 = "zombie_eye_" + param_00;
	level._effect[var_02] = loadfx("vfx/gameplay/mp/zombie/" + var_02);
	if(!param_01)
	{
		foreach(var_04 in level.validheadtypes)
		{
			var_02 = "zombie_eye_" + param_00 + "_" + var_04;
			level._effect[var_02] = loadfx("vfx/gameplay/mp/zombie/" + var_02);
		}
	}
}

//Function Number: 4
geteyeeffectforzombie(param_00,param_01)
{
	var_02 = param_01;
	if(isdefined(param_01) && common_scripts\utility::string_starts_with(param_01,"zombies_head_"))
	{
		var_02 = getsubstr(param_01,13);
	}

	if(!isdefined(var_02) || !isdefined(common_scripts\utility::array_find(level.validheadtypes,var_02)))
	{
		var_03 = "zombie_eye_" + param_00;
	}
	else
	{
		var_03 = "zombie_eye_" + param_01 + "_" + var_03;
	}

	return var_03;
}

//Function Number: 5
loadeyeeffects()
{
	loadeyeeffectsfortype("vanilla");
	loadeyeeffectsfortype("emp");
	loadeyeeffectsfortype("exploder");
	loadeyeeffectsfortype("fast");
}

//Function Number: 6
zombieweaponweight(param_00)
{
	var_01 = tablelookup("mp/zombieStatsTable.csv",0,param_00,1);
	if(!isdefined(var_01) || var_01 == "")
	{
		var_01 = tablelookup("mp/statstable.csv",4,param_00,8);
	}

	if(!isdefined(var_01) || var_01 == "")
	{
		var_01 = 4;
	}

	return int(var_01);
}

//Function Number: 7
initpickups()
{
	level.pickupents = [];
	level.maxpickupsperround = getmaxpickupsperround();
	level.percentchancetodrop = getpercentchancetodrop();
	level.dropscheduled = 0;
	level.currentpickupcount = 0;
	level.pickuphuds = [];
	level.pickuprotation = [];
	level.pickuprotationindex = 0;
	level.pickuprecent = undefined;
	level.firesaletestcounter = 0;
	level.pickup["ammo"]["func"] = ::ammopickup;
	level.pickup["ammo"]["fx"] = "pickup_maxammo";
	level.pickup["insta_kill"]["func"] = ::instakillpickup;
	level.pickup["insta_kill"]["fx"] = "pickup_instakill";
	level.pickup["double_points"]["func"] = ::doublepointspickup;
	level.pickup["double_points"]["fx"] = "pickup_doublepoints";
	level.pickup["fire_sale"]["func"] = ::firesalepickup;
	level.pickup["fire_sale"]["fx"] = "pickup_firesale";
	level.pickup["nuke"]["func"] = ::nukepickup;
	level.pickup["nuke"]["fx"] = "pickup_nuke";
	level.pickup["trap"]["func"] = ::trappickup;
	level.pickup["trap"]["fx"] = "pickup_trap";
	prespawnpickupents();
	randomizepickuplist();
	level thread scheduledrops();
}

//Function Number: 8
prespawnpickupents()
{
	var_00 = 4;
	for(var_01 = 0;var_01 < var_00;var_01++)
	{
		spawnpickupent();
	}
}

//Function Number: 9
getpickupent()
{
	var_00 = undefined;
	foreach(var_02 in level.pickupents)
	{
		if(!var_02.inuse)
		{
			var_00 = var_02;
			break;
		}
	}

	if(!isdefined(var_00))
	{
		var_00 = spawnpickupent();
	}

	var_00 show();
	var_00.inuse = 1;
	var_00 dontinterpolate();
	var_00.trigger dontinterpolate();
	return var_00;
}

//Function Number: 10
spawnpickupent()
{
	var_00 = spawn("script_model",(0,0,0));
	var_00 setmodel("dlc_dogtags_zombie_invisible");
	var_00 ghost();
	var_00.inuse = 0;
	var_00.trigger = spawn("trigger_radius",(0,0,0),0,32,32);
	level.pickupents[level.pickupents.size] = var_00;
	return var_00;
}

//Function Number: 11
randomizepickuplist()
{
	level.pickuprotation = [];
	foreach(var_02, var_01 in level.pickup)
	{
		level.pickuprotation[level.pickuprotation.size] = var_02;
	}

	level.pickuprotation = common_scripts\utility::array_randomize(level.pickuprotation);
	while(isdefined(level.pickuprecent) && level.pickuprotation.size > 1 && level.pickuprotation[0] == level.pickuprecent)
	{
		level.pickuprotation = common_scripts\utility::array_randomize(level.pickuprotation);
	}
}

//Function Number: 12
selectnextpickup()
{
	if(level.pickuprotationindex >= level.pickuprotation.size)
	{
		level.pickuprotationindex = 0;
		randomizepickuplist();
	}

	if(isdefined(level.pickuprecent) && level.pickuprotation[level.pickuprotationindex] == level.pickuprecent && level.pickuprotationindex < level.pickuprotation.size - 1)
	{
		var_00 = level.pickuprotation[level.pickuprotationindex];
		level.pickuprotation[level.pickuprotationindex] = level.pickuprotation[level.pickuprotationindex + 1];
		level.pickuprotation[level.pickuprotationindex + 1] = var_00;
	}

	var_01 = level.pickuprotation[level.pickuprotationindex];
	level.pickuprotationindex++;
	return var_01;
}

//Function Number: 13
ispickupvalid(param_00)
{
	if(isdefined(level.pickuprecent) && param_00 == level.pickuprecent)
	{
		return 0;
	}

	if(param_00 == "fire_sale")
	{
		if(!maps\mp\zombies\_wall_buys::magicboxhasmoved())
		{
			return 0;
		}

		if(level.wavecounter <= 5)
		{
			return 0;
		}

		if(maps\mp\_utility::gameflag("fire_sale"))
		{
			return 0;
		}

		level.firesaletestcounter++;
		if(level.firesaletestcounter % 2 == 1)
		{
			return 0;
		}
	}

	if(param_00 == "trap")
	{
		if(isdefined(level.trappickupdisabled))
		{
			return 0;
		}

		if(!maps\mp\zombies\_doors::doorhasbeenopened())
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 14
selectnextvalidpickup()
{
	for(var_00 = selectnextpickup();!ispickupvalid(var_00);var_00 = selectnextpickup())
	{
	}

	return var_00;
}

//Function Number: 15
selectnextvalidpickupavoid(param_00)
{
	var_01 = selectnextvalidpickup();
	if(var_01 != param_00)
	{
		return var_01;
	}

	while(var_01 == param_00)
	{
		var_01 = selectnextvalidpickup();
	}

	for(var_02 = level.pickuprotation.size - 1;var_02 >= level.pickuprotationindex;var_02--)
	{
		level.pickuprotation[var_02 + 1] = level.pickuprotation[var_02];
	}

	level.pickuprotation[level.pickuprotationindex] = param_00;
	if(level.pickuprotationindex < level.pickuprotation.size - 1 && level.pickuprotation[level.pickuprotationindex] == level.pickuprotation[level.pickuprotationindex + 1])
	{
		level.pickuprotationindex++;
	}

	return var_01;
}

//Function Number: 16
scheduledrops()
{
	level waittill("zombie_wave_started");
	var_00 = level.players.size * 1000;
	var_01 = level.players.size * 2000;
	var_02 = 1.14;
	var_03 = var_00 + var_01;
	pickupdebugprint("Next Scheduled at " + var_03 + " points");
	for(;;)
	{
		var_04 = 0;
		foreach(var_06 in level.players)
		{
			if(isdefined(var_06.moneyearnedtotal))
			{
				var_04 = var_04 + var_06.moneyearnedtotal;
			}
		}

		if(var_04 > var_03)
		{
			level.dropscheduled = 1;
			pickupdebugprint("Reached Scheduled " + var_04 + ">" + var_03);
			var_01 = var_01 * var_02;
			var_03 = var_04 + var_01;
			pickupdebugprint("Next Scheduled at " + var_03 + " points");
		}

		wait(0.5);
	}
}

//Function Number: 17
getmaxpickupsperround()
{
	var_00 = maps\mp\zombies\_util::getnumplayers() + 1;
	return clamp(var_00,2,4);
}

//Function Number: 18
getpercentchancetodrop()
{
	if(maps\mp\zombies\_util::getzombieslevelnum() >= 3)
	{
		return 1;
	}

	return 2;
}

//Function Number: 19
initializematchrules()
{
	maps\mp\_utility::setcommonrulesfrommatchrulesdata();
	setdynamicdvar("scr_zombies_roundswitch",0);
	maps\mp\_utility::registerroundswitchdvar(level.gametype,0,0,9);
	setdynamicdvar("scr_zombies_roundlimit",1);
	maps\mp\_utility::registerroundlimitdvar(level.gametype,1);
	setdynamicdvar("scr_zombies_winlimit",1);
	maps\mp\_utility::registerwinlimitdvar(level.gametype,1);
	setdynamicdvar("scr_zombies_halftime",0);
	maps\mp\_utility::registerhalftimedvar(level.gametype,0);
	setdynamicdvar("scr_zombies_timeLimit",0);
	maps\mp\_utility::registertimelimitdvar(level.gametype,0);
	setdynamicdvar("scr_zombies_numLives",1);
	maps\mp\_utility::registernumlivesdvar(level.gametype,1);
	setdynamicdvar("r_hudOutlineWidth",1);
}

//Function Number: 20
onstartgametype()
{
	setclientnamemode("auto_change");
	if(!isdefined(game["switchedsides"]))
	{
		game["switchedsides"] = 0;
	}

	maps\mp\_utility::setobjectivetext("allies",&"ZOMBIES_EMPTY_STRING");
	maps\mp\_utility::setobjectivetext("axis",&"ZOMBIES_EMPTY_STRING");
	maps\mp\_utility::setobjectivescoretext("allies",&"ZOMBIES_EMPTY_STRING");
	maps\mp\_utility::setobjectivescoretext("axis",&"ZOMBIES_EMPTY_STRING");
	maps\mp\_utility::setobjectivehinttext("allies",undefined);
	maps\mp\_utility::setobjectivehinttext("axis",undefined);
	thread init_spawns();
	thread init_structs();
	var_00[0] = level.gametype;
	maps\mp\gametypes\_gameobjects::main(var_00);
	initzombiesettings();
	level thread zombievignette();
	level thread onplayerconnectzombies();
	level thread maps\mp\zombies\_util::handlenetworkeffects();
	level thread initializedefaultcharacter();
	level thread maps\mp\zombies\zombies_spawn_manager::init();
	level thread maps\mp\zombies\_wall_buys::init();
	level thread maps\mp\zombies\_power::init();
	level thread maps\mp\zombies\_doors::init();
	level thread maps\mp\zombies\_terminals::init();
	level thread maps\mp\zombies\_traps::init();
	level thread maps\mp\zombies\killstreaks\_zombie_killstreaks::init();
	level thread maps\mp\zombies\weapons\_zombie_weapons::init();
	level thread maps\mp\zombies\_zombies_audio::init();
	level thread maps\mp\zombies\_zombies_sidequests::init();
	level thread maps\mp\zombies\_debug::init();
	level thread runzombiesmode();
	level thread handlezombieshostmigration();
	thread horde_audio();
	if(isdefined(level.onstartgametypelevelfunc))
	{
		[[ level.onstartgametypelevelfunc ]]();
	}
}

//Function Number: 21
initzombiesettings()
{
	maps\mp\_utility::gameflaginit("insta_kill",0);
	maps\mp\_utility::gameflaginit("double_points",0);
	maps\mp\_utility::gameflaginit("fire_sale",0);
	maps\mp\_utility::gameflaginit("power_off",0);
	level.wavecounter = 0;
	level.specialroundnumber = 0;
	level.specialroundcounter = 0;
	level.roundtype = "normal";
	level.lastenemydeathpos = (0,0,0);
	level.zombiegamepaused = 0;
	level.doorsopenedbitmask = 0;
	level.pointevents = [];
	level.pointevents["damage_body"] = 10;
	level.pointevents["damage_head"] = 10;
	level.pointevents["kill_trap"] = 10;
	level.pointevents["kill_limb"] = 50;
	level.pointevents["kill_streak"] = 40;
	level.pointevents["kill_body"] = 60;
	level.pointevents["kill_head"] = 100;
	level.pointevents["kill_melee"] = 130;
	level.pointevents["power_on"] = 100;
	level.pointevents["atm"] = 100;
	level.pointevents["atm_jackpot"] = 10;
	level.pointevents["cure"] = 100;
	level.pointevents["crate"] = 500;
	level.pointevents["nuke"] = 400;
	level.pointevents["reward_bronze"] = 500;
	level.pointevents["reward_silver"] = 1000;
	level.pointevents["reward_gold"] = 2000;
	level.pointevents["breach_fix"] = 200;
	if(!isdefined(level.doorbitmaskarray))
	{
		level.doorbitmaskarray = [];
	}
}

//Function Number: 22
setzombiesdlclevel()
{
	level.zombiedlclevel = 99;
	var_00 = getdvar("mapname");
	if(var_00 == "mp_zombie_lab")
	{
		level.zombiedlclevel = 1;
		return;
	}

	if(var_00 == "mp_zombie_brg")
	{
		level.zombiedlclevel = 2;
		return;
	}

	if(var_00 == "mp_zombie_ark")
	{
		level.zombiedlclevel = 3;
		return;
	}

	if(var_00 == "mp_zombie_h2o")
	{
		level.zombiedlclevel = 4;
		return;
	}
}

//Function Number: 23
zombiesautoassign()
{
	thread maps\mp\gametypes\_menus::setteam("allies");
	self.sessionteam = "allies";
}

//Function Number: 24
onplayerconnectzombies()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_00 thread maps\mp\zombies\_zombies_audio::init_audio_functions();
		var_00 thread playermonitorweapon();
		var_00 thread playermonitorboostevents();
		var_00 thread playermonitortokenuse();
		var_00 thread playermonitorlastgroundpos();
		level thread createplayervariables(var_00);
		var_01 = undefined;
		if(isdefined(level.givecustomcharacters))
		{
			var_00 [[ level.givecustomcharacters ]](var_01);
		}
		else
		{
			var_00 maps\mp\zombies\_util::givecustomcharactersdefault(var_01);
		}

		if(isbot(var_00))
		{
			continue;
		}
	}
}

//Function Number: 25
playermonitorlastgroundpos()
{
	self endon("disconnect");
	for(;;)
	{
		if(maps\mp\zombies\_util::getzombieslevelnum() == 4 && maps\mp\zombies\_util::is_true(self.inwater))
		{
			wait 0.05;
			continue;
		}

		if(self isonground() && !maps\mp\zombies\_util::is_true(self.disabletombstonedropinarea))
		{
			self.lastgroundposition = self.origin;
		}

		wait 0.05;
	}
}

//Function Number: 26
playermonitortokenuse()
{
	self endon("disconnect");
	if(!isbot(self))
	{
		self notifyonplayercommand("TokenUseDown","+actionslot 3");
		self notifyonplayercommand("TokenUseUp","-actionslot 3");
	}

	for(;;)
	{
		self.tokenbuttonpressed = 0;
		self waittill("TokenUseDown");
		self.tokenbuttonpressed = 1;
		self waittill("TokenUseUp");
	}
}

//Function Number: 27
initializedefaultcharacter()
{
	var_00 = ["head_hero_cormack_sentinel_halo","mp_exo_01a"];
	maps\mp\zombies\_util::initializecharactermodel("default","atlas_arctic_guard_body_mp","viewhands_security_guard",var_00);
}

//Function Number: 28
createplayervariables(param_00)
{
	param_00.weaponstate = [];
	param_00.pointnotifylua = [];
	param_00.hasradar = 0;
	param_00.radarshowenemydirection = 0;
	param_00.magicboxuses = 0;
	param_00.trapuses = 0;
	param_00.headshotkills = 0;
	param_00.meleekills = 0;
	param_00.sidequest = 0;
	param_00.numberofdowns = 0;
	param_00.numberofbleedouts = 0;
	param_00.exosuitround = 0;
	param_00.numupgrades = 0;
	if(maps\mp\zombies\_util::iszombieshardmode())
	{
		param_00.deaths = 0;
		param_00.score = 0;
		param_00.timeplayed["total"] = 0;
		param_00.suicides = 0;
		param_00.kills = 0;
		param_00.headshots = 0;
		param_00.assists = 0;
		param_00 maps\mp\_utility::setpersstat("kills",0);
		param_00 maps\mp\_utility::setpersstat("assists",0);
	}

	param_00 resetmoney(500);
	param_00 inittokens();
	maps\mp\zombies\_util::clearzombiestats(param_00);
	createzombieweaponstate(param_00,"iw5_titan45zm_mp");
	level thread monitorpointnotifylua(param_00);
	level thread weaponleveldisplay(param_00);
	level thread playerinitroundmatchdata(param_00);
}

//Function Number: 29
updatepersistentmoney()
{
	var_00 = 8388607;
	var_01 = 128;
	var_02 = 65536;
	var_03 = self.moneycurrent;
	if(var_03 > var_00)
	{
		var_03 = var_00;
	}

	var_04 = int(var_03 / var_02);
	var_05 = var_03 % var_02;
	self.extrascore1 = var_04;
	maps\mp\_utility::setpersstat("extrascore1",var_04);
	self.score = var_05;
	maps\mp\_utility::setpersstat("score",var_05);
	var_06 = 67108863;
	var_07 = 1024;
	var_08 = 65536;
	var_09 = self.moneyearnedtotal;
	if(var_09 > var_06)
	{
		var_09 = var_06;
	}

	var_0A = int(var_09 / var_08);
	var_0B = var_09 % var_08;
	self.deaths = var_0A;
	maps\mp\_utility::setpersstat("deaths",var_0A);
	self.extrascore0 = var_0B;
	maps\mp\_utility::setpersstat("extrascore0",var_0B);
}

//Function Number: 30
resetmoney(param_00)
{
	self.moneycurrent = param_00;
	self.moneyearnedtotal = param_00;
	updatepersistentmoney();
}

//Function Number: 31
givemoney(param_00)
{
	if(!isdefined(param_00))
	{
		return;
	}

	var_01 = param_00;
	if(var_01 > 9999)
	{
		var_01 = 9999;
	}

	self.pointnotifylua[self.pointnotifylua.size] = var_01;
	if(level.gameended)
	{
		return;
	}

	self.moneycurrent = self.moneycurrent + param_00;
	self.moneyearnedtotal = self.moneyearnedtotal + param_00;
	if(isdefined(self.roundmoneyearned))
	{
		self.roundmoneyearned = self.roundmoneyearned + param_00;
	}

	givemoneybagsachievement();
	updatepersistentmoney();
}

//Function Number: 32
givemoneybagsachievement()
{
	if(self.moneycurrent < 15000 || isdefined(self.moneybags))
	{
		return;
	}

	givezombieachievement("DLC1_ZOMBIE_MONEYBAGS");
	self.moneybags = 1;
}

//Function Number: 33
spendmoney(param_00)
{
	var_01 = 0 - param_00;
	if(var_01 < -9999)
	{
		var_01 = -9999;
	}

	self.pointnotifylua[self.pointnotifylua.size] = var_01;
	self.moneycurrent = self.moneycurrent - param_00;
	if(isdefined(self.roundmoneyspent))
	{
		self.roundmoneyspent = self.roundmoneyspent + param_00;
	}

	updatepersistentmoney();
}

//Function Number: 34
getcurrentmoney(param_00)
{
	return param_00.moneycurrent;
}

//Function Number: 35
inittokens()
{
	var_00 = self getcommonplayerdatareservedint("tokensAvailable");
	settokens(var_00);
}

//Function Number: 36
gettokenusetime()
{
	return 1000;
}

//Function Number: 37
hastoken(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 1;
	}

	return self.tokens >= param_00;
}

//Function Number: 38
givetoken(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 1;
	}

	settokens(self.tokens + param_00);
}

//Function Number: 39
spendtoken(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 1;
	}

	settokens(self.tokens - param_00);
}

//Function Number: 40
settokens(param_00)
{
	if(level.tokensenabled)
	{
		if(param_00 < 0)
		{
			param_00 = 0;
		}

		self.tokens = param_00;
		self setcommonplayerdatareservedint("tokensAvailable",self.tokens);
		self setclientomnvar("ui_zm_token_count",self.tokens);
		return;
	}

	self.tokens = -1;
	self setclientomnvar("ui_zm_token_count",-1);
}

//Function Number: 41
createzombieweaponstate(param_00,param_01)
{
	var_02 = getweaponbasename(param_01);
	if(maps\mp\zombies\_util::haszombieweaponstate(param_00,var_02))
	{
		return;
	}

	param_00.weaponstate[var_02]["level"] = 1;
}

//Function Number: 42
weaponleveldisplay(param_00)
{
	level endon("game_ended");
	param_00 endon("disconnect");
	for(;;)
	{
		param_00 common_scripts\utility::waittill_any("weaponLevelEarned","weapon_change");
		var_01 = maps\mp\zombies\_util::getplayerweaponzombies(param_00);
		var_02 = getweaponbasename(var_01);
		if(!maps\mp\zombies\_util::haszombieweaponstate(param_00,var_02))
		{
			continue;
		}

		var_03 = param_00.weaponstate[var_02]["level"];
		if(100 < var_03)
		{
			var_03 = 100;
		}

		param_00 setclientomnvar("ui_horde_count",var_03);
	}
}

//Function Number: 43
playerinitroundmatchdata(param_00)
{
	level endon("game_ended");
	param_00 endon("disconnect");
	param_00 waittill("spawned");
	var_01 = 0;
	if(isdefined(level.wavecounter))
	{
		var_01 = level.wavecounter - 1;
	}

	param_00 maps\mp\zombies\_util::recordplayermatchdataforroundstart(var_01);
}

//Function Number: 44
monitordisconnect(param_00)
{
	level endon("game_ended");
	param_00 waittill("disconnect");
	level notify("player_disconnected");
}

//Function Number: 45
zombiegameclass()
{
	self.pers["class"] = "gamemode";
	self.pers["lastClass"] = "";
	self.pers["gamemodeLoadout"] = level.modeloadouts[level.playerteam];
	self.class = self.pers["class"];
	self.lastclass = self.pers["lastClass"];
}

//Function Number: 46
onplayerspawn()
{
	if(isagent(self))
	{
		self thread [[ maps\mp\agents\_agent_utility::agentfunc("spawn") ]]();
		return;
	}

	maps\mp\zombies\_util::zombieallowallboost(0,"class");
	maps\mp\zombies\_terminals::onplayerspawn();
	thread onspawnfinished();
}

//Function Number: 47
onspawnfinished(param_00)
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	self waittill("applyLoadout");
	maps\mp\killstreaks\_killstreaks::clearkillstreaks();
	if(maps\mp\zombies\_util::isonhumanteam(self))
	{
		var_01 = "iw5_titan45zm_mp";
		if(isplayer(self))
		{
			if(isdefined(self.characterindex))
			{
				var_02 = "ui_zm_character_" + self.characterindex + "_alive";
				setomnvar(var_02,1);
			}

			self setlethalweapon("frag_grenade_throw_zombies_mp");
			self giveweapon("frag_grenade_throw_zombies_mp");
			self setweaponammoclip("frag_grenade_throw_zombies_mp",4);
			maps\mp\_utility::giveperk("specialty_pistoldeath",0);
			maps\mp\_utility::giveperk("specialty_wildcard_duallethals",0);
			maps\mp\_utility::giveperk("specialty_coldblooded",0);
			if(level.wavecounter <= 1 && !isdefined(self.joinedround1))
			{
				self.joinedround1 = 1;
			}

			self.hideondeath = undefined;
			if(isdefined(self.body))
			{
				self.body delete();
			}

			if((!isdefined(self.playedspawnweaponflourish) || !self.playedspawnweaponflourish) && !isdefined(level.zombieinitialcountdownover) || !level.zombieinitialcountdownover)
			{
				playintroweaponflourish();
				self.playedspawnweaponflourish = 1;
			}
			else
			{
				var_01 = maps\mp\zombies\_wall_buys::getupgradeweaponname(self,"iw5_titan45zm_mp");
				self giveweapon(var_01);
				self setspawnweapon(var_01);
			}
		}

		self givemaxammo(var_01);
	}
}

//Function Number: 48
waittoloadweapons(param_00)
{
	self endon("disconnect");
	for(;;)
	{
		if(self hasloadedcustomizationplayerview(self,param_00))
		{
			break;
		}

		wait 0.05;
	}
}

//Function Number: 49
freezecontrolsduringcharacterintroflourish()
{
	self endon("disconnect");
	self freezecontrols(1);
	maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(4);
	self freezecontrols(0);
}

//Function Number: 50
getcharacterintroweaponname()
{
	switch(self.characterindex)
	{
		case 0:
			return "char_intro_guardzm_mp";

		case 1:
			return "char_intro_execzm_mp";

		case 2:
			return "char_intro_itzm_mp";

		case 3:
		default:
			if(maps\mp\zombies\_util::getzombieslevelnum() >= 3)
			{
				return "char_intro_pilotzm_mp";
			}
			return "char_intro_janitorzm_mp";
	}
}

//Function Number: 51
getcharacterintroidleweapon()
{
	switch(self.characterindex)
	{
		case 3:
			return "char_intro_pilotidlezm_mp";

		default:
			return "";
	}
}

//Function Number: 52
getexosuitequipweaponname()
{
	switch(self.characterindex)
	{
		case 0:
			return "exo_suit_equip_guardzm_mp";

		case 1:
			return "exo_suit_equip_execzm_mp";

		case 2:
			return "exo_suit_equip_itzm_mp";

		case 3:
		default:
			if(maps\mp\zombies\_util::getzombieslevelnum() >= 3)
			{
				return "exo_suit_equip_pilotzm_mp";
			}
			return "exo_suit_equip_janitorzm_mp";
	}
}

//Function Number: 53
getexosuitequipweaponduration()
{
	return 2.7;
}

//Function Number: 54
getexosuitperkweaponname(param_00)
{
	switch(param_00)
	{
		case "health":
			return "exo_suit_perk_healthzm_mp";

		case "slam":
			return "exo_suit_perk_slamzm_mp";

		case "fastreload":
			return "exo_suit_perk_speedzm_mp";

		case "stabilizer":
			return "exo_suit_perk_stabilizerzm_mp";

		case "stim":
		default:
			return "exo_suit_perk_stimzm_mp";
	}
}

//Function Number: 55
getexosuitperkweaponduration()
{
	return 1.5;
}

//Function Number: 56
playpilotintroweaponflourish()
{
	self endon("disconnect");
	var_00 = "char_intro_pilotidlezm_mp";
	var_01 = "char_intro_pilotzm_mp";
	var_02[0] = "iw5_titan45zm_mp";
	var_02[1] = var_01;
	var_02[2] = var_00;
	self hasloadedcustomizationplayerview(self,var_02);
	self giveweapon(var_00);
	self switchtoweaponimmediate(var_00);
	self disableweaponswitch();
	maps\mp\zombies\_util::playerallowfire(0,"flourish");
	maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(0.2);
	thread freezecontrolsduringcharacterintroflourish();
	wait(1);
	self giveweapon(var_01);
	self switchtoweaponimmediate(var_01);
	common_scripts\utility::_disableweaponswitch();
	maps\mp\zombies\_util::playerallowfire(0,"flourish");
	maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(3.6);
	waittoloadweapons(var_02);
	common_scripts\utility::_enableweaponswitch();
	maps\mp\zombies\_util::playerallowfire(1,"flourish");
	self takeweapon(var_00);
	self takeweapon(var_01);
	self giveweapon("iw5_titan45zm_mp");
	self switchtoweaponimmediate("iw5_titan45zm_mp");
}

//Function Number: 57
playintroweaponflourish()
{
	if(maps\mp\zombies\_util::getzombieslevelnum() >= 3 && self.characterindex == 3)
	{
		playpilotintroweaponflourish();
		return;
	}

	self endon("disconnect");
	var_00 = getcharacterintroweaponname();
	var_01[0] = "iw5_titan45zm_mp";
	var_01[1] = var_00;
	waittoloadweapons(var_01);
	thread freezecontrolsduringcharacterintroflourish();
	maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(1);
	self giveweapon(var_00);
	self switchtoweaponimmediate(var_00);
	common_scripts\utility::_disableweaponswitch();
	maps\mp\zombies\_util::playerallowfire(0,"flourish");
	maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(3.6);
	common_scripts\utility::_enableweaponswitch();
	maps\mp\zombies\_util::playerallowfire(1,"flourish");
	self takeweapon(var_00);
	self giveweapon("iw5_titan45zm_mp");
	self switchtoweaponimmediate("iw5_titan45zm_mp");
}

//Function Number: 58
playweaponflourish(param_00,param_01)
{
	self endon("disconnect");
	if(maps\mp\zombies\_util::isplayerinlaststand(self))
	{
		return;
	}

	var_02 = self getcurrentweapon(1);
	if(maps\mp\zombies\_util::iszombiekillstreakweapon(var_02) || maps\mp\zombies\_util::isrippedturretweapon(var_02))
	{
		return;
	}

	self.playingweaponflourish = 1;
	self giveweapon(param_00);
	self switchtoweaponimmediate(param_00);
	common_scripts\utility::_disableweaponswitch();
	maps\mp\zombies\_util::playerallowfire(0,"flourish");
	maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(param_01);
	maps\mp\zombies\_util::playerallowfire(1,"flourish");
	self takeweapon(param_00);
	common_scripts\utility::_enableweaponswitch();
	if(!maps\mp\zombies\_util::isplayerinlaststand(self))
	{
		self switchtoweaponimmediate(var_02);
	}

	self.playingweaponflourish = 0;
}

//Function Number: 59
closeclassmenu()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	wait(0.05);
	if(!isagent(self))
	{
		thread maps\mp\gametypes\_playerlogic::setuioptionsmenu(-1);
	}
}

//Function Number: 60
waituntilmatchstart()
{
	maps\mp\_utility::gameflagwait("prematch_done");
	setomnvar("ui_match_countdown_title",0);
	while(!isdefined(level.bot_loadouts_initialized) || level.bot_loadouts_initialized == 0)
	{
		wait(0.05);
	}

	while(!level.players.size)
	{
		wait(0.05);
	}
}

//Function Number: 61
watchforhostmigrationsetround()
{
	level endon("game_ended");
	for(;;)
	{
		level waittill("host_migration_end");
		var_00 = int(max(level.wavecounter,1));
		setomnvar("ui_horde_round_number",var_00);
		foreach(var_02 in level.players)
		{
			if(isai(var_02))
			{
				continue;
			}

			if(!isdefined(var_02))
			{
				continue;
			}

			if(!isdefined(var_02.horde_perks))
			{
				continue;
			}

			if(!var_02.horde_perks.size)
			{
				continue;
			}

			var_03 = var_02.horde_perks.size;
			for(var_04 = 0;var_04 < var_03;var_04++)
			{
				if(!isdefined(var_02))
				{
					continue;
				}

				if(!isagent(var_02))
				{
					var_02 setclientomnvar("ui_horde_update_perk",var_02.horde_perks[var_04]["index"]);
				}

				wait(0.05);
			}
		}
	}
}

//Function Number: 62
getspawnpoint()
{
	var_00 = self.team;
	if(maps\mp\zombies\_util::isonhumanteam(self))
	{
		var_01 = maps\mp\gametypes\_spawnlogic::getteamspawnpoints(var_00);
		if(level.ingraceperiod)
		{
			var_02 = level.startspawnpoints;
			if(isdefined(level.filterstartspawnfunc))
			{
				var_02 = self [[ level.filterstartspawnfunc ]](var_02);
			}

			var_03 = maps\mp\gametypes\_spawnlogic::getspawnpoint_random(var_02);
		}
		else if(isdefined(self.lastdeathpos))
		{
			if(isdefined(level.filterrespawnfunc))
			{
				var_03 = self [[ level.filterrespawnfunc ]](var_03);
			}

			var_03 = maps\mp\zombies\_zombies_spawnscoring::getzombiesspawnpoint_neartombstone(var_03);
		}
		else
		{
			if(isdefined(level.filterrespawnfunc))
			{
				var_03 = self [[ level.filterrespawnfunc ]](var_03);
			}

			var_03 = maps\mp\zombies\_zombies_spawnscoring::getzombiesspawnpoint_nearteam(var_03);
		}

		return var_03;
	}

	var_01 = maps\mp\gametypes\_spawnlogic::getteamspawnpoints(var_03);
	var_03 = maps\mp\gametypes\_spawnscoring::getspawnpoint_safeguard(var_03);
	return var_03;
}

//Function Number: 63
onnormaldeath(param_00,param_01,param_02)
{
}

//Function Number: 64
onsuicidedeath(param_00)
{
	var_01 = "ui_zm_character_" + param_00.characterindex + "_alive";
	setomnvar(var_01,0);
}

//Function Number: 65
ongrenadesuicide(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	if(level.players.size > 1)
	{
		param_00 laststanddie();
	}

	[[ level.callbackplayerlaststand ]](param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,0);
}

//Function Number: 66
disablespawningforplayerfunc(param_00)
{
	return !self.hasspawned && level.wavecounter > 1 && isdefined(level.zombie_wave_running) && level.zombie_wave_running;
}

//Function Number: 67
callback_playerdamage(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	if((param_04 == "MOD_MELEE" || param_04 == "MOD_IMPACT") && self issprinting())
	{
		thread meleesprintdeactivate();
	}

	maps\mp\gametypes\_damage::callback_playerdamage(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09);
}

//Function Number: 68
meleesprintdeactivate()
{
	self endon("death");
	level endon("game_ended");
	self allowsprint(0);
	wait 0.05;
	if(isalive(self))
	{
		self allowsprint(1);
	}
}

//Function Number: 69
playerinvinciblefromcrateorpowerup(param_00,param_01,param_02)
{
	if(maps\mp\zombies\_util::iscrategodmode(param_00))
	{
		if(isdefined(param_02) && param_02 == "MOD_TRIGGER_HURT")
		{
			return 0;
		}

		if(isdefined(param_01))
		{
			if(maps\mp\zombies\_util::is_true(param_01.iszomboni))
			{
				return 0;
			}

			if(isai(param_01) && !isscriptedagent(param_01))
			{
				return 0;
			}
		}

		return 1;
	}

	return 0;
}

//Function Number: 70
isfriendlyfireroundkill(param_00,param_01,param_02,param_03,param_04,param_05)
{
	return maps\mp\zombies\_util::isfriendlyfireround() && isdefined(param_00) && isdefined(param_02) && isdefined(param_00.characterindex) && isdefined(param_02.characterindex) && param_00 != param_02;
}

//Function Number: 71
calculatefriendlyfirerounddamage(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(!isdefined(param_05))
	{
		return 0;
	}

	if(param_05 == "repulsor_zombie_mp")
	{
		return 0;
	}

	var_06 = maps\mp\_utility::getbaseweaponname(param_05);
	if(isdefined(param_04) && isexplosivedamagemod(param_04))
	{
		return 25;
	}

	if(isdefined(param_04) && maps\mp\_utility::ismeleemod(param_04))
	{
		return 34;
	}

	var_07 = 3;
	var_08 = 0;
	if(var_06 == "iw5_em1zm_mp")
	{
		var_07 = 2;
	}
	else if(var_06 == "iw5_gm6zm_mp")
	{
		var_07 = 34;
	}

	if(isdefined(param_02.weaponstate) && isdefined(param_02.weaponstate[param_05]) && isdefined(param_02.weaponstate[param_05]["level"]))
	{
		var_08 = param_02.weaponstate[param_05]["level"];
	}

	return var_07 + var_08;
}

//Function Number: 72
modifyplayerdamagezombies(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	var_09 = param_03;
	if(!isdefined(param_00))
	{
		return 0;
	}

	if(!isdefined(param_05))
	{
		return 0;
	}

	if(isfriendlyfireroundkill(param_00,param_01,param_02,param_03,param_04,param_05))
	{
		return calculatefriendlyfirerounddamage(param_00,param_01,param_02,param_03,param_04,param_05);
	}

	var_0A = 1;
	if(isdefined(param_02) && param_02.classname == "trigger_hurt" && var_09 == 999999)
	{
		var_0A = 0;
	}

	if(var_0A)
	{
		if(isdefined(param_00.godmode) && param_00.godmode)
		{
			return 0;
		}

		if(isdefined(param_00.onlydamagedbylargeenemies) && param_00.onlydamagedbylargeenemies)
		{
			if(isdefined(param_02) && !isdefined(param_02.meleesectortype) && param_02.meleesectortype == "large")
			{
				return 0;
			}
		}
	}

	if(isdefined(param_02) && isdefined(param_02.owner))
	{
		param_02 = param_02.owner;
	}

	var_0B = maps\mp\_utility::attackerishittingteam(param_00,param_02);
	var_0C = getweaponbasename(param_05);
	if(!isdefined(var_0C))
	{
		var_0C = "none";
	}

	if(isdefined(level.damageweapontoweapon[var_0C]))
	{
		var_0C = level.damageweapontoweapon[var_0C];
	}

	if(isdefined(level.defusedamagemultiplier) && maps\mp\zombies\_util::is_true(param_00.isdefusing) && isai(param_02) && !isscriptedagent(param_02))
	{
		var_09 = int(var_09 * level.defusedamagemultiplier);
	}

	if(isplayer(param_00))
	{
		if(isai(param_02) && param_02 maps\mp\zombies\_util::zombiewaitingfordeath())
		{
			return 0;
		}

		if(var_0B)
		{
			return 0;
		}

		if(maps\mp\zombies\_util::isplayerinlaststand(param_00))
		{
			return 0;
		}

		if(maps\mp\zombies\_util::is_true(param_00.enteringgoliath))
		{
			return 0;
		}

		if(playerinvinciblefromcrateorpowerup(param_00,param_01,param_04))
		{
			return 0;
		}

		if(isdefined(param_00.lastrevivetime))
		{
			var_0D = 1000;
			if(gettime() - param_00.lastrevivetime < var_0D)
			{
				return 0;
			}
		}

		if(isdefined(param_05) && maps\mp\_utility::iskillstreakweapon(param_05) || maps\mp\zombies\_util::iszombieequipment(param_05) || maps\mp\zombies\_traps::isexplosivetrap(param_05) || param_05 == "exploder_zm_small_mp")
		{
			return 0;
		}

		if(var_0C == "iw5_exocrossbowzm_mp" || var_0C == "iw5_mahemzm_mp")
		{
			var_09 = 20;
		}

		if(isdefined(param_02) && isai(param_02))
		{
			var_0D = 500;
			if(isscriptedagent(param_02) && isdefined(param_00.lastzombiedamagetime) && gettime() - param_00.lastzombiedamagetime < var_0D)
			{
				return 0;
			}

			var_0E = level.agentclasses[param_02.agent_type].melee_damage_scale;
			var_0F = level.agentclasses[param_02.agent_type].damage_scale;
			if(isdefined(var_0E) && param_04 == "MOD_MELEE")
			{
				var_09 = int(max(var_09 * var_0E,1));
			}
			else if(isdefined(var_0F))
			{
				var_09 = int(max(var_09 * var_0F,1));
			}
		}

		if(maps\mp\zombies\_util::isplayerinfected(param_00))
		{
			return int(min(var_09,param_00.health - 1));
		}

		if(isdefined(param_02) && isai(param_02))
		{
			if(isdefined(level.ondamageplayerfunc) && isdefined(level.ondamageplayerfunc[param_02.agent_type]))
			{
				param_02 [[ level.ondamageplayerfunc[param_02.agent_type] ]](param_00);
			}
		}

		if(param_05 == "exploder_zm_large_mp")
		{
			param_00 addzmexploderbloodfx();
		}
	}

	if(isai(param_00) && !isplayer(param_00) && !isdefined(param_02))
	{
		if(param_04 == "MOD_FALLING")
		{
			return 0;
		}

		if(param_05 == "exploder_zm_small_mp" || param_05 == "exploder_zm_large_mp")
		{
			var_09 = int(level.wavecounter * 100 + 50);
		}

		if(maps\mp\zombies\_util::isinstakill() && !param_00 maps\mp\zombies\_util::instakillimmune())
		{
			var_09 = param_00.maxhealth + 10;
		}
	}

	if(isai(param_00) && !isplayer(param_00) && isai(param_02))
	{
		if(!isscriptedagent(param_02) && isalliedsentient(param_00,param_02))
		{
			return 0;
		}

		if(isdefined(param_00.agent_type) && param_00.agent_type == "sq_character" && param_00.godmode)
		{
			return 0;
		}

		if(isdefined(param_00.agent_type) && param_00.agent_type == "zm_squadmate")
		{
			var_0F = level.agentclasses[param_02.agent_type].damagescalevssquadmates;
			if(isdefined(var_0F))
			{
				var_09 = int(var_09 * var_0F);
			}
		}

		if(maps\mp\zombies\_util::is_true(param_00.nodamageself) && param_00 == param_02)
		{
			return 0;
		}
	}

	if(isai(param_00) && !isplayer(param_00) && isdefined(param_01) && param_01.classname == "misc_turret")
	{
		if(isdefined(param_01.team) && param_01.team == param_00.team)
		{
			return 0;
		}
	}

	if(isdefined(param_02) && isplayer(param_02) && isai(param_00) && !isplayer(param_00))
	{
		if(isdefined(level.modifyweapondamage[var_0C]))
		{
			var_09 = [[ level.modifyweapondamage[var_0C] ]](param_00,param_02,var_09,param_04,param_05,param_06,param_07,param_08);
		}

		if(isdefined(level.modifyweapondamagebyagenttype) && isdefined(param_00.agent_type))
		{
			if(isdefined(level.modifyweapondamagebyagenttype[param_00.agent_type]) && isdefined(level.modifyweapondamagebyagenttype[param_00.agent_type][var_0C]))
			{
				var_09 = [[ level.modifyweapondamagebyagenttype[param_00.agent_type][var_0C] ]](param_00,param_02,var_09,param_04,param_05,param_06,param_07,param_08);
			}
		}

		var_09 = param_00 maps\mp\zombies\killstreaks\_zombie_killstreaks::modifydamagekillstreak(param_01,param_02,var_09,param_05,param_04);
		if(maps\mp\zombies\_util::haszombieweaponstate(param_02,var_0C))
		{
			var_10 = 0.2;
			if(isdefined(param_02.weaponstate[var_0C]["weapon_level_increase"]))
			{
				var_10 = param_02.weaponstate[var_0C]["weapon_level_increase"];
			}

			var_09 = int(var_09 + var_09 * var_10 * param_02.weaponstate[var_0C]["level"] - 1);
		}

		var_09 = param_00 modifyplayerequipmentdamage(param_05,var_09,param_04,param_06);
		if(isdefined(param_04) && param_04 == "MOD_MELEE")
		{
			if(param_02 ishighjumpallowed())
			{
				var_09 = level.playerexomeleedamage;
			}
			else
			{
				var_09 = level.playermeleedamage;
			}
		}

		if(isdefined(level.modifydamagebyagenttype) && isdefined(level.modifydamagebyagenttype[param_00.agent_type]))
		{
			var_09 = [[ level.modifydamagebyagenttype[param_00.agent_type] ]](param_00,param_02,var_09,param_04,param_05,param_06,param_07,param_08);
		}

		var_09 = param_00 mutatormodifydamage(param_01,param_02,param_05,var_09,param_08,param_04);
		var_09 = param_00 trapmodifydamage(param_05,var_09,param_08,param_04);
		if(maps\mp\zombies\_util::is_true(param_00.inairforleap))
		{
			var_09 = var_09 * 2;
		}

		if(isdefined(level.zombie_rewards))
		{
			if(isdefined(level.laststandupgrade) && level.laststandupgrade == 1 && maps\mp\zombies\_util::isplayerinlaststand(param_02))
			{
				var_09 = var_09 * 4;
			}
		}

		if(maps\mp\zombies\_util::isinstakill() && !param_00 maps\mp\zombies\_util::instakillimmune())
		{
			var_09 = param_00.maxhealth + 10;
		}

		if(param_00 maps\mp\zombies\_util::zombiewaitingfordeath())
		{
			return 0;
		}

		if(param_00 maps\mp\zombies\_util::zombieshouldwaitfordeath(param_00,param_02,var_09,param_04,param_05,param_06,param_07,param_08))
		{
			param_00 thread maps\mp\zombies\_util::zombiedelaydeath(param_00,param_02,var_09,param_04,param_05,param_06,param_07,param_08);
			return 0;
		}

		if(!maps\mp\zombies\_util::ispendingdeath(param_00))
		{
			param_02 givepointsfordamage(param_00,var_09,param_04,param_05,param_06,param_07,param_08,0);
		}

		if(isdefined(level.processenemydamagedfunc))
		{
			self thread [[ level.processenemydamagedfunc ]](param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08);
		}
	}

	if(isplayer(param_00))
	{
		param_00 maps\mp\zombies\_zombies_audio::player_hurt(param_02,var_09,param_04);
		if(isdefined(param_02) && isai(param_02) && isscriptedagent(param_02))
		{
			param_00.lastzombiedamagetime = gettime();
		}
	}
	else if(isai(param_00) && isscriptedagent(param_00))
	{
		param_00 maps\mp\zombies\_zombies_audio::zombie_hurt(param_02,var_09);
	}

	return var_09;
}

//Function Number: 73
modifyplayerequipmentdamage(param_00,param_01,param_02,param_03)
{
	if(param_02 == "MOD_IMPACT")
	{
		return param_01;
	}

	if(maps\mp\zombies\_util::iszombiednagrenade(param_00))
	{
		return level.wavecounter * param_01;
	}

	if(isdefined(param_00) && param_00 == "repulsor_zombie_mp")
	{
		if(maps\mp\zombies\_util::instakillimmune())
		{
			return 0;
		}

		if(isdefined(self.agent_type) && issubstr(self.agent_type,"ranged_elite_soldier_goliath"))
		{
			return 0;
		}

		var_04 = 0;
		foreach(var_06 in level.agentclasses)
		{
			var_07 = calculatezombiehealth(var_06);
			if(var_07 > var_04)
			{
				var_04 = var_07;
			}
		}

		return var_04 + 1;
	}

	if(isdefined(var_05) && var_05 == "teleport_zombies_mp")
	{
		if(var_07 == "MOD_CRUSH")
		{
			return var_06;
		}
	}

	if(maps\mp\zombies\_util::iszombieequipment(var_05) || maps\mp\zombies\_traps::isexplosivetrap(var_05))
	{
		var_06 = level.wavecounter * randomintrange(100,200);
		if(isdefined(level.modifyplayerequipmentdamagefunc))
		{
			var_06 = [[ level.modifyplayerequipmentdamagefunc ]](var_05,var_06,var_08);
		}

		if(isdefined(self.agent_type) && isdefined(level.modifyequipmentdamagebyagenttype) && isdefined(level.modifyequipmentdamagebyagenttype[self.agent_type]))
		{
			var_06 = [[ level.modifyequipmentdamagebyagenttype[self.agent_type] ]](var_05,var_06,var_08);
		}
	}

	return var_06;
}

//Function Number: 74
mutatormodifydamage(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = isdefined(level.zmdamageignoresarmor) && [[ level.zmdamageignoresarmor ]](param_00,param_01,param_02,param_03,param_04,param_05);
	if(!var_06)
	{
		if(isdefined(self.hashelmet) && maps\mp\_utility::isheadshot(param_02,param_04,param_05))
		{
			param_03 = int(param_03 * 0.5);
		}

		if(isdefined(self.hasarmor) && !maps\mp\_utility::isheadshot(param_02,param_04,param_05))
		{
			param_03 = int(param_03 * 0.5);
		}
	}

	return param_03;
}

//Function Number: 75
zmdamageignoresarmor(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(isdefined(param_02))
	{
		if(param_02 == "repulsor_zombie_mp")
		{
			return 1;
		}

		if(param_02 == "explosive_touch_zombies_mp")
		{
			return 1;
		}

		if(param_02 == "teleport_zombies_mp" & param_05 == "MOD_CRUSH")
		{
			return 1;
		}
	}

	if(isdefined(param_00))
	{
		if(maps\mp\zombies\_util::is_true(param_00.iszomboni))
		{
			return 1;
		}

		if(maps\mp\zombies\_util::is_true(param_00.is_door))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 76
trapmodifydamage(param_00,param_01,param_02,param_03)
{
	if(isdefined(param_00) && param_00 == "trap_sniper_zm_mp")
	{
		if(common_scripts\utility::cointoss())
		{
			param_01 = self.health + 10;
			if(isdefined(self.maxhealth))
			{
				param_01 = self.maxhealth + 10;
			}
		}
		else
		{
			param_01 = int(self.health * 0.5);
			if(isdefined(self.maxhealth))
			{
				param_01 = int(self.maxhealth * 0.5);
			}
		}

		if(maps\mp\zombies\_util::istrapresistant())
		{
			param_01 = int(param_01 * 0.05);
		}
	}

	if(isdefined(param_00) && param_00 == "zombie_trap_turret_mp")
	{
		if(maps\mp\zombies\_util::istrapresistant())
		{
			param_01 = int(param_01 * 0.05);
		}
	}

	return param_01;
}

//Function Number: 77
givepointsfordamage(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	var_08 = maps\mp\_utility::isheadshot(param_03,param_06,param_02,self);
	var_09 = maps\mp\_utility::ismeleemod(param_02) || param_02 == "MOD_IMPACT";
	var_0A = param_01 >= param_00.health;
	var_0B = maps\mp\_utility::iskillstreakweapon(param_03);
	var_0C = maps\mp\zombies\_util::istrapweapon(param_03);
	if(var_09 && param_06 == "shield")
	{
		return;
	}

	var_0D = undefined;
	if(var_0A)
	{
		var_0D = "kill_limb";
		if(var_08)
		{
			var_0D = "kill_head";
			self.headshotkills++;
		}

		if(var_09 && !var_0C)
		{
			var_0D = "kill_melee";
			self.meleekills++;
		}
		else
		{
			if(isbodyshot(param_03,param_06,param_02,self))
			{
				var_0D = "kill_body";
			}

			if(var_0B)
			{
				var_0D = "kill_streak";
			}

			if(var_0C)
			{
				var_0D = "kill_trap";
			}

			if(isdefined(level.givepointsforkillshotfunc))
			{
				var_0D = [[ level.givepointsforkillshotfunc ]](var_0D,param_03);
			}
		}
	}
	else
	{
		if(var_0B)
		{
			return;
		}

		if(var_0C)
		{
			return;
		}

		var_0D = "damage_body";
		if(var_08 && isdefined(param_03) && !maps\mp\_utility::iskillstreakweapon(param_03))
		{
			var_0D = "damage_head";
		}

		if(!playercanawardpointsfordamage(param_03,param_00))
		{
			return;
		}
	}

	givepointsforevent(var_0D);
}

//Function Number: 78
playercanawardpointsfordamage(param_00,param_01)
{
	if(issubstr(param_00,"iw5_em1zm_mp") || param_00 == "turretheadenergy_mp")
	{
		if(isdefined(self.nextem1pointstime) && gettime() < self.nextem1pointstime)
		{
			return 0;
		}

		self.nextem1pointstime = gettime() + 200;
	}
	else if(isdefined(param_01) && maps\mp\zombies\_util::iszombiednagrenade(param_00))
	{
		if(isdefined(param_01.nextdnaaoepointstime) && gettime() < param_01.nextdnaaoepointstime)
		{
			return 0;
		}

		param_01.nextdnaaoepointstime = gettime() + 1000;
	}

	if(isdefined(level.playercanawardpointsfordamagefunc) && ![[ level.playercanawardpointsfordamagefunc ]](param_00,param_01))
	{
		return 0;
	}

	if(maps\mp\zombies\_util::iszombieshardmode())
	{
		return 0;
	}

	return 1;
}

//Function Number: 79
isbodyshot(param_00,param_01,param_02,param_03)
{
	if(isdefined(param_03))
	{
		if(isdefined(param_03.owner))
		{
			if(param_03.code_classname == "script_vehicle")
			{
				return 0;
			}

			if(param_03.code_classname == "misc_turret")
			{
				return 0;
			}

			if(param_03.code_classname == "script_model")
			{
				return 0;
			}
		}

		if(isdefined(param_03.agent_type))
		{
			if(param_03.agent_type == "dog" || param_03.agent_type == "alien")
			{
				return 0;
			}
		}
	}

	var_04 = param_01 == "torso_upper" || param_01 == "right_arm_upper" || param_01 == "left_arm_upper" || param_01 == "gun" || param_01 == "torso_lower";
	return var_04 && !maps\mp\_utility::ismeleemod(param_02) && param_02 != "MOD_IMPACT" && !maps\mp\_utility::isenvironmentweapon(param_00);
}

//Function Number: 80
givepointsforevent(param_00,param_01,param_02)
{
	if(isdefined(level.disablescoring) && level.disablescoring)
	{
		return;
	}

	var_03 = level.pointevents[param_00];
	if(isdefined(param_01))
	{
		var_03 = param_01;
	}

	if(!var_03)
	{
		return;
	}

	if(maps\mp\_utility::gameflag("double_points"))
	{
		var_03 = int(var_03 * 2);
	}

	if(isdefined(param_02) && param_02)
	{
		var_04 = common_scripts\utility::tostring(var_03);
		var_04 = strinsertnumericdelimiters(var_04);
		self iprintlnbold(&"ZOMBIES_PLUS_CREDITS",var_04);
	}

	givemoney(var_03);
}

//Function Number: 81
canbuy(param_00,param_01)
{
	if(param_00 > getcurrentmoney(self))
	{
		if(!isdefined(param_01) || !param_01)
		{
			displayneedmoremoneymessage(self);
		}

		self playlocalsound("interact_purchase_fail");
		return 0;
	}

	if(isdefined(self.playingweaponflourish) && self.playingweaponflourish)
	{
		self playlocalsound("interact_purchase_fail");
		return 0;
	}

	return 1;
}

//Function Number: 82
attempttobuy(param_00,param_01)
{
	if(!canbuy(param_00,param_01))
	{
		return 0;
	}

	spendmoney(param_00);
	return 1;
}

//Function Number: 83
displayneedmoremoneymessage(param_00)
{
	param_00 playsoundtoplayer("ui_button_error",param_00);
	param_00 iprintlnbold(&"ZOMBIES_NEED_MORE_MONEY");
}

//Function Number: 84
monitorpointnotifylua(param_00)
{
	level endon("game_ended");
	param_00 endon("disconnect");
	for(;;)
	{
		if(param_00.pointnotifylua.size > 0)
		{
			if(!isagent(param_00))
			{
				param_00 setclientomnvar("ui_zm_award_points",param_00.pointnotifylua[param_00.pointnotifylua.size - 1]);
			}

			param_00.pointnotifylua = removelastelement(param_00.pointnotifylua);
		}

		wait(0.05);
	}
}

//Function Number: 85
removelastelement(param_00)
{
	var_01 = [];
	for(var_02 = 0;var_02 < param_00.size - 1;var_02++)
	{
		var_01[var_02] = param_00[var_02];
	}

	return var_01;
}

//Function Number: 86
maydropweaponzombies(param_00)
{
	if(isai(self))
	{
		return 0;
	}

	if(!isdefined(param_00) || param_00 == "none")
	{
		return 0;
	}

	var_01 = getweaponbasename(param_00);
	if(var_01 == "iw5_titan45zm_mp")
	{
		return 0;
	}

	return 1;
}

//Function Number: 87
shouldsavetombstoneweapon()
{
	if(!maps\mp\zombies\_util::is_true(self.laststand) && !maps\mp\zombies\_util::is_true(self.infected))
	{
		var_00 = self getcurrentprimaryweapon();
		return !maps\mp\_utility::iskillstreakweapon(var_00);
	}

	return 0;
}

//Function Number: 88
dropweaponfordeathzombies(param_00,param_01,param_02)
{
	if(maps\mp\zombies\_util::iszombieshardmode())
	{
		return;
	}

	if(isai(self))
	{
		return;
	}

	var_03 = maps\mp\zombies\_util::getplayerweaponzombies(self);
	if(shouldsavetombstoneweapon())
	{
		maps\mp\zombies\_zombies_laststand::savelaststandweapons(var_03,0);
	}

	if(isdefined(self.tombstoneweapon))
	{
		var_03 = self.tombstoneweapon;
	}

	if(!maydropweaponzombies(var_03))
	{
		return;
	}

	var_04 = self.origin;
	if(isdefined(param_02))
	{
		var_04 = param_02;
	}
	else if(isdefined(param_01) && param_01 == "MOD_TRIGGER_HURT" || param_01 == "MOD_SUICIDE" && isdefined(self.lastgroundposition))
	{
		var_04 = self.lastgroundposition;
	}
	else if(isdefined(self.disabletombstonedropinarea) && self.disabletombstonedropinarea && isdefined(self.lastgroundposition))
	{
		var_04 = self.lastgroundposition;
	}

	var_05 = (0,0,18);
	var_06 = spawn("script_model",var_04 + var_05);
	var_06 setmodel("dlc_dogtags_zombie_invisible");
	var_06 scriptmodelplayanim("mp_dogtag_spin");
	var_06 hide();
	var_06.owner = self;
	var_06.curorigin = var_04 + var_05;
	var_06.trackingweaponname = var_03;
	var_06.visuals = spawn("script_model",var_04 + var_05);
	var_06.visuals setmodel("pickups_zombies_01_tombstone");
	var_06.visuals hide();
	var_06.visuals hudoutlineenable(1,0);
	var_06.visuals linkto(var_06,"j_dogtag",(0,0,-12),(0,0,0));
	var_06.trigger = spawn("trigger_radius",var_04 + var_05,0,32,32);
	foreach(var_08 in level.players)
	{
		if(var_06.owner == var_08)
		{
			var_06 showtoplayer(var_06.owner);
			var_06.visuals showtoplayer(var_06.owner);
		}
	}

	maps\mp\zombies\_util::playfxontagforclientnetwork(level._effect["pickup_tombstone"],var_06,"j_dogtag",var_06.owner);
	var_06 thread watchweaponownerdisconnect();
	var_06 thread watchweaponpickupzombies();
	var_06 thread removeweaponpickupzombies(param_02);
}

//Function Number: 89
watchweaponownerdisconnect()
{
	self endon("death");
	level endon("game_ended");
	self.owner waittill("disconnect");
	self.visuals delete();
	self.trigger delete();
	self delete();
}

//Function Number: 90
watchweaponpickupzombies()
{
	self endon("death");
	for(;;)
	{
		self.trigger waittill("trigger",var_00);
		if(var_00 == self.owner)
		{
			if(canpickuptombstone(var_00))
			{
				break;
			}
			else
			{
				wait(0.25);
			}
		}
	}

	maps\mp\zombies\_wall_buys::givezombieweapon(var_00,self.trackingweaponname,undefined,level.dotombstoneweaponswitch);
	var_00 thread maps\mp\gametypes\_hud_message::splashnotify("zombie_tombstome");
	var_00 playlocalsound("zmb_pickup_general");
	self.visuals delete();
	self.trigger delete();
	self delete();
}

//Function Number: 91
canpickuptombstone(param_00)
{
	if(maps\mp\zombies\_util::isplayerinlaststand(param_00))
	{
		return 0;
	}

	if(isdefined(param_00.playingweaponflourish) && param_00.playingweaponflourish)
	{
		return 0;
	}

	return 1;
}

//Function Number: 92
removeweaponpickupzombies(param_00)
{
	self endon("death");
	level endon("game_ended");
	if(!isdefined(param_00))
	{
		self.owner common_scripts\utility::waittill_any("started_spawnPlayer","disconnect");
	}

	wait(52);
	thread startweaponpickupflashing();
	wait(8);
	if(!isdefined(self))
	{
		return;
	}

	self.visuals delete();
	self.trigger delete();
	self delete();
}

//Function Number: 93
startweaponpickupflashing()
{
	self endon("trigger");
	self endon("death");
	level endon("game_ended");
	if(isdefined(self.owner))
	{
		self.owner endon("disconnect");
	}

	for(;;)
	{
		self hide();
		self.visuals hide();
		wait(0.25);
		self showtoplayer(self.owner);
		self.visuals showtoplayer(self.owner);
		wait(0.25);
	}
}

//Function Number: 94
ondeadevent(param_00)
{
	if(param_00 != level.enemyteam)
	{
		maps\mp\zombies\_zombies_laststand::zombieendgame();
	}
}

//Function Number: 95
setspecialloadouts()
{
	level.modeloadouts["allies"] = maps\mp\gametypes\_class::getemptyloadout();
	level.modeloadouts["allies"]["loadoutPrimary"] = "none";
	level.modeloadouts["allies"]["loadoutSecondary"] = "none";
}

//Function Number: 96
init_spawns()
{
	level.spawnmins = (0,0,0);
	level.spawnmaxs = (0,0,0);
	maps\mp\gametypes\_spawnlogic::addstartspawnpoints("mp_tdm_spawn_allies_start");
	level.spawn_name = "mp_tdm_spawn";
	maps\mp\gametypes\_spawnlogic::addspawnpoints("allies",level.spawn_name);
	maps\mp\gametypes\_spawnlogic::addspawnpoints("axis",level.spawn_name);
	level.mapcenter = maps\mp\gametypes\_spawnlogic::findboxcenter(level.spawnmins,level.spawnmaxs);
	setmapcenter(level.mapcenter);
}

//Function Number: 97
init_structs()
{
	while(!isdefined(level.struct_class_names))
	{
		wait(0.05);
	}

	level.evac_points = common_scripts\utility::getstructarray("evac_point","targetname");
}

//Function Number: 98
runzombiesmode()
{
	waituntilmatchstart();
	level.gamehasstarted = 1;
	level thread maps\mp\zombies\_zombies_audio::play_level_start_vox();
	level thread maps\mp\zombies\_zombies::init();
	runinitialcountdown();
	level.zombieinitialcountdownover = 1;
	for(;;)
	{
		updatezombiesettings();
		while(maps\mp\zombies\_util::iszombiegamepaused())
		{
			wait 0.05;
		}

		if(isdefined(level.zombieroundstartupdate))
		{
			[[ level.zombieroundstartupdate ]]();
		}

		runroundstart(level.wavecounter);
		level notify("zombie_wave_started");
		while(maps\mp\zombies\_util::iszombiegamepaused())
		{
			wait 0.05;
		}

		maps\mp\zombies\_zombies_audio_announcer::announcerrounddialog(level.roundtype);
		if(isdefined(level.runwavefunc) && isdefined(level.runwavefunc[level.roundtype]))
		{
			level thread [[ level.runwavefunc[level.roundtype] ]](level.wavecounter);
		}
		else
		{
			level thread maps\mp\zombies\zombies_spawn_manager::runwave(level.wavecounter);
		}

		level waittill("zombie_wave_ended");
		runroundend();
	}
}

//Function Number: 99
handlezombieshostmigration()
{
	level endon("game_ended");
	for(;;)
	{
		level waittill("host_migration_begin");
		if(level.wavecounter > 4 || maps\mp\zombies\_util::iszombieshardmode())
		{
			setnojipscore(1);
		}

		level.dismemberedbodyparts = [];
		level.nextdismemberedbodypartindex = 0;
	}
}

//Function Number: 100
horde_audio()
{
	self endon("death");
	wait(1);
	level.horde_audio_ent = spawn("script_origin",(0,0,0));
	for(;;)
	{
		level.horde_audio_ent scalevolume(0);
		level waittill("zombie_wave_started");
		wait(0.5);
		if(level.roundtype == "zombie_dog")
		{
			level.horde_audio_ent playsound("zmb_dog_round_start");
			wait(1.5);
			level.horde_audio_ent playloopsound("zmb_horde_dog");
		}
		else if(level.roundtype == "zombie_host")
		{
			level.horde_audio_ent playsound("zmb_hst_round_start");
			wait(1.5);
			level.horde_audio_ent playloopsound("zmb_horde_host");
		}
		else if(level.roundtype == "normal")
		{
			level.horde_audio_ent playsound("zmb_gen_round_start");
			wait(1.5);
			level.horde_audio_ent playloopsound("zmb_horde_general");
		}

		level.horde_audio_ent scalevolume(1,3);
		level waittill("zombie_wave_ended");
		level.horde_audio_ent stoploopsound();
	}
}

//Function Number: 101
runinitialcountdown()
{
	wait(5);
}

//Function Number: 102
updatezombiesettings()
{
	level.wavecounter++;
	if(maps\mp\zombies\_util::isspecialround())
	{
		level.specialroundcounter++;
	}

	level.roundtype = calculateroundtype();
	level.maxpickupsperround = getmaxpickupsperround();
	level.percentchancetodrop = getpercentchancetodrop();
	level.currentpickupcount = 0;
	foreach(var_01 in level.agentclasses)
	{
		var_01.roundhealth = calculatezombiehealth(var_01);
	}

	if(level.specialroundnumber <= level.wavecounter - 1)
	{
		level.specialroundnumber = calculatenextspecialround();
	}

	if(level.wavecounter > 4)
	{
		setnojipscore(1);
	}

	giveroundachievement();
	level notify("zombie_round_count_update");
}

//Function Number: 103
giveroundachievement()
{
	var_00 = undefined;
	var_01 = maps\mp\_utility::getmapname();
	if(var_01 == "mp_zombie_h2o" && level.wavecounter == 7 && level.doorsopenedbitmask == 0)
	{
		giveplayerszombieachievement("DLC4_ZOMBIE_NODOORS");
	}

	switch(var_01)
	{
		case "mp_zombie_lab":
			var_00 = "DLC1_";
			break;

		case "mp_zombie_brg":
			var_00 = "DLC2_";
			break;

		case "mp_zombie_ark":
			var_00 = "DLC3_";
			break;

		default:
			break;
	}

	switch(level.wavecounter)
	{
		case 10:
			var_00 = var_00 + "ZOMBIE_ROUND10";
			break;

		case 25:
			if(var_01 == "mp_zombie_lab")
			{
				var_00 = var_00 + "ZOMBIE_ROUND30";
				break;
			}
			else if(var_01 == "mp_zombie_brg")
			{
				var_00 = var_00 + "ZOMBIE_ROUND25";
				break;
			}
			else
			{
				return;
			}
			break;

		case 30:
			if(var_01 == "mp_zombie_ark")
			{
				var_00 = var_00 + "ZOMBIE_ROUND30";
			}
			else
			{
				return;
			}
			break;

		default:
			break;
	}

	giveplayerszombieachievement(var_00);
}

//Function Number: 104
calculatenextspecialround()
{
	if(isdefined(level.calculatenextspecialround))
	{
		return [[ level.calculatenextspecialround ]]();
	}

	var_00 = level.specialroundnumber + randomintrange(4,6);
	return var_00;
}

//Function Number: 105
calculateroundtype()
{
	if(isdefined(level.calculateroundtypeoverridefunc))
	{
		return [[ level.calculateroundtypeoverridefunc ]]();
	}

	if(maps\mp\zombies\_util::isspecialround())
	{
		if(isdefined(level.calculatespecialroundtypeoverride))
		{
			return [[ level.calculatespecialroundtypeoverride ]]();
		}
		else
		{
			return calculatespecialroundtype();
		}
	}

	return "normal";
}

//Function Number: 106
calculatespecialroundtype()
{
	var_00 = ["zombie_dog","zombie_host"];
	var_01 = var_00[0];
	switch(level.specialroundcounter)
	{
		case 1:
			var_01 = "zombie_dog";
			break;

		case 2:
			var_01 = "zombie_host";
			break;

		default:
			if(!isdefined(level.specialroundarray) || level.specialroundindex == level.specialroundarray.size)
			{
				level.specialroundarray = common_scripts\utility::array_randomize(var_00);
				level.specialroundindex = 0;
			}
	
			var_01 = level.specialroundarray[level.specialroundindex];
			level.specialroundindex++;
			break;
	}

	return var_01;
}

//Function Number: 107
calculatezombiehealth(param_00)
{
	var_01 = 0;
	if(isdefined(param_00.healthoverridefunc))
	{
		var_01 = [[ param_00.healthoverridefunc ]]();
	}
	else
	{
		var_02 = 150;
		if(level.wavecounter == 1)
		{
			var_01 = var_02;
		}
		else if(level.wavecounter <= 9)
		{
			var_01 = var_02 + level.wavecounter - 1 * 100;
		}
		else
		{
			var_03 = 950;
			var_04 = level.wavecounter - 9;
			var_01 = var_03 * pow(1.1,var_04);
		}
	}

	var_01 = int(var_01 * param_00.health_scale);
	if(maps\mp\zombies\_util::iszombieshardmode())
	{
		var_01 = int(var_01 * 1.75);
	}

	if(isdefined(param_00.roundhealth) && param_00.roundhealth > var_01)
	{
		var_01 = param_00.roundhealth;
	}

	return var_01;
}

//Function Number: 108
runroundstart(param_00)
{
	var_01 = 0;
	if(maps\mp\zombies\_util::getzombieslevelnum() == 4 && param_00 == 1 && maps\mp\zombies\_util::iszombieshardmode())
	{
		var_01 = 1;
	}

	if(var_01)
	{
		maps\mp\zombies\_zombies_music::changezombiemusic("round_start_hard_mode");
	}
	else
	{
		maps\mp\zombies\_zombies_music::changezombiemusic("round_start");
	}

	level notify("zombie_round_countdown_started");
	var_02 = 5;
	while(var_02 > 0)
	{
		while(maps\mp\zombies\_util::iszombiegamepaused())
		{
			wait 0.05;
		}

		setomnvar("ui_zm_round_countdown",var_02);
		var_02--;
		wait(1);
	}

	setomnvar("ui_zm_round_countdown",0);
	if(isdefined(level.roundstartfunc[level.roundtype]))
	{
		[[ level.roundstartfunc[level.roundtype] ]]();
	}

	var_03 = maps\mp\gametypes\_gamelogic::getgameduration();
	setomnvar("ui_zm_round_start",var_03 * 1000);
	setomnvar("ui_horde_round_number",param_00);
	setomnvar("ui_zm_round_type",maps\mp\zombies\_util::getroundtype(level.roundtype));
	maps\mp\zombies\_zombies_music::changezombiemusic("round_" + level.roundtype);
	level maps\mp\zombies\_util::recordmatchdataforroundstart(param_00 - 1);
}

//Function Number: 109
runroundend()
{
	while(maps\mp\zombies\_util::iszombiegamepaused())
	{
		wait 0.05;
	}

	thread maps\mp\zombies\_zombies_music::changezombiemusic("round_end");
	thread maps\mp\zombies\_zombies_music::changezombiemusic("round_intermission");
	level thread revivedownedplayers();
	if(isdefined(level.roundendfunc[level.roundtype]))
	{
		[[ level.roundendfunc[level.roundtype] ]]();
	}

	maps\mp\zombies\weapons\_zombie_weapons::givegrenadesafterrounds();
	level maps\mp\zombies\_util::recordmatchdataforroundend(level.wavecounter - 1);
	wait(10);
}

//Function Number: 110
revivedownedplayers()
{
	foreach(var_01 in level.players)
	{
		if(var_01.sessionstate == "spectator" || var_01.sessionstate == "dead")
		{
			var_02 = "ui_zm_character_" + var_01.characterindex + "_alive";
			setomnvar(var_02,1);
			var_01 thread maps\mp\zombies\_zombies_laststand::revivefromspectatemode();
		}
		else if(maps\mp\zombies\_util::isplayerinlaststand(var_01))
		{
			var_01 notify("revive_trigger");
		}

		if(maps\mp\zombies\_util::isplayerinfected(var_01))
		{
			var_01 notify("cured",0);
		}
	}
}

//Function Number: 111
pickupdebugprint(param_00)
{
	if(!maps\mp\zombies\_util::is_true(level.pickupdebugprint))
	{
		return;
	}

	var_01 = maps\mp\gametypes\_gamelogic::getgameduration();
	var_02 = var_01 - int(getomnvar("ui_zm_round_start") / 1000);
}

//Function Number: 112
chancetospawnpickup(param_00,param_01,param_02,param_03)
{
	if(maps\mp\zombies\_util::arepickupsdisabled())
	{
		return;
	}

	if(isdefined(level.candroppickupsfunc[level.roundtype]) && ![[ level.candroppickupsfunc[level.roundtype] ]](param_00))
	{
		var_04 = 0;
		if(!var_04)
		{
			return;
		}
	}

	if(level.currentpickupcount >= level.maxpickupsperround)
	{
		return;
	}

	if(isdefined(level.canspawnpickupoverridefunc))
	{
		if(![[ level.canspawnpickupoverridefunc ]](param_00,param_01,param_02,param_03))
		{
			return 0;
		}
	}

	if(isdefined(param_02) && param_02 == "MOD_SUICIDE")
	{
		return;
	}

	if(maps\mp\zombies\_util::is_true(param_01.killedbynuke))
	{
		return;
	}

	if(maps\mp\zombies\_util::is_true(param_01.nopickups))
	{
		return;
	}

	if(isdefined(param_03) && maps\mp\zombies\_util::istrapweapon(param_03))
	{
		return;
	}

	if(isdefined(param_00) && isagent(param_00) && !isscriptedagent(param_00))
	{
		return;
	}

	if(isdefined(level.nopickuppenalty) && level.nopickuppenalty == 1)
	{
		return;
	}

	level endon("game_ended");
	var_05 = randomint(100);
	var_06 = "none";
	if(var_05 > level.percentchancetodrop)
	{
		if(!level.dropscheduled)
		{
			return;
		}

		var_06 = "score";
	}
	else
	{
		var_06 = "random";
	}

	if(isdefined(level.zone_data) && !maps\mp\zombies\_zombies_zone_manager::iszombieinenabledzone(param_01))
	{
		return;
	}

	var_07 = common_scripts\utility::ter_op(level.dropscheduled,"true ","false ");
	var_08 = common_scripts\utility::ter_op(var_05 > level.percentchancetodrop,"false ","true ");
	var_09 = "Scheduled: " + var_07 + "Chance: " + var_08 + "(" + var_05 + "<=" + level.percentchancetodrop + ")";
	level.dropscheduled = 0;
	var_0A = selectnextvalidpickup();
	createpickup(var_0A,param_01.origin,var_09);
}

//Function Number: 113
createpickuporgive(param_00,param_01,param_02)
{
	if(isdefined(level.zone_data) && maps\mp\zombies\_zombies_zone_manager::ispointinanyzone(param_01 + (0,0,1)))
	{
		createpickup(param_00,param_01,param_02);
		return;
	}

	var_03 = common_scripts\utility::random(level.players);
	[[ level.pickup[param_00]["func"] ]](var_03);
}

//Function Number: 114
createpickup(param_00,param_01,param_02)
{
	var_03 = level.pickup[param_00]["model"];
	var_04 = level.pickup[param_00]["func"];
	var_05 = level.pickup[param_00]["icon"];
	var_06 = level.pickup[param_00]["fx"];
	var_07 = level.pickup[param_00]["outline"];
	level.currentpickupcount++;
	level.pickuprecent = param_00;
	if(!isdefined(param_02))
	{
		param_02 = "<undefined>";
	}

	pickupdebugprint(param_00 + " Dropped - " + param_02);
	spawnpickupmodel(param_01 + (0,0,22),var_03,var_05,var_06,var_04,undefined,var_07);
}

//Function Number: 115
spawnpickupmodel(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	var_07[0] = getpickupent();
	if(isdefined(param_03))
	{
		var_07[0] setmodel("dlc_dogtags_zombie_invisible");
	}
	else
	{
		var_07[0] setmodel(param_01);
	}

	if(isdefined(param_06) && param_06)
	{
		var_07[0] hudoutlineenable(0,0);
	}

	var_08 = var_07[0].trigger;
	var_09 = maps\mp\gametypes\_gameobjects::createuseobject(level.playerteam,var_08,var_07,(0,0,16),1);
	var_0A = param_00;
	var_09.curorigin = var_0A;
	var_09.trigger.origin = var_0A;
	var_09.visuals[0].origin = var_0A;
	if(isdefined(param_02) && param_02 != "")
	{
		var_09.icon = var_08 maps\mp\_entityheadicons::setheadicon(level.playerteam,param_02,(0,0,30),14,14,undefined,undefined,undefined,undefined,undefined,0);
	}

	var_09 maps\mp\gametypes\_gameobjects::setusetime(0);
	var_09 maps\mp\gametypes\_gameobjects::allowuse("friendly");
	var_09.onuse = param_04;
	if(isdefined(param_05))
	{
		var_09.canuseobject = param_05;
	}
	else
	{
		var_09.canuseobject = ::canactivatepickup;
	}

	if(isdefined(param_03))
	{
		var_09.visuals[0] scriptmodelplayanim("mp_dogtag_spin");
		var_09.visuals[0].origin = var_0A + (0,0,-12);
		var_09.fx = level._effect[param_03];
		var_09.fxtag = "j_dogtag";
		playfxontag(var_09.fx,var_09.visuals[0],var_09.fxtag);
	}
	else
	{
		var_09 thread pickupbounce();
	}

	var_09 thread pickuptimer();
}

//Function Number: 116
canactivatepickup(param_00)
{
	if(isdefined(param_00) && isagent(param_00))
	{
		return 0;
	}

	return 1;
}

//Function Number: 117
pickupbounce()
{
	level endon("game_ended");
	self endon("deleted");
	self endon("death");
	var_00 = self;
	var_01 = self.curorigin;
	var_02 = self.curorigin + (0,0,12);
	var_03 = 1.25;
	if(isdefined(self.visuals) && isdefined(self.visuals[0]))
	{
		var_00 = self.visuals[0];
	}

	for(;;)
	{
		var_00 moveto(var_02,var_03,0.15,0.15);
		var_00 rotateyaw(180,var_03);
		wait(var_03);
		var_00 moveto(var_01,var_03,0.15,0.15);
		var_00 rotateyaw(180,var_03);
		wait(var_03);
	}
}

//Function Number: 118
pickuptimer()
{
	self endon("deleted");
	wait(15);
	thread pickupstartflashing();
	thread pickupexpiringsound(self.curorigin);
	wait(8);
	playsoundatpos(self.curorigin,"zmb_pickup_expired");
	level thread removepickup(self);
}

//Function Number: 119
pickupexpiringsound(param_00)
{
	var_01 = spawn("script_origin",param_00);
	var_01 playloopsound("zmb_pickup_timer");
	self waittill("deleted");
	var_01 stoploopsound();
	wait 0.05;
	var_01 delete();
}

//Function Number: 120
pickupstartflashing()
{
	self endon("deleted");
	for(;;)
	{
		if(isdefined(self.fx))
		{
			stopfxontag(self.fx,self.visuals[0],self.fxtag);
		}
		else if(isdefined(self.visuals) && isdefined(self.visuals[0]))
		{
			self.visuals[0] ghost();
		}

		wait(0.25);
		if(isdefined(self.fx))
		{
			playfxontag(self.fx,self.visuals[0],self.fxtag);
		}
		else if(isdefined(self.visuals) && isdefined(self.visuals[0]))
		{
			self.visuals[0] show();
		}

		wait(0.25);
	}
}

//Function Number: 121
removepickup(param_00)
{
	if(!isdefined(param_00.visuals))
	{
		return;
	}

	param_00 notify("deleted");
	param_00.visuals[0] show();
	param_00.visuals[0] ghost();
	if(isdefined(param_00.fx))
	{
		stopfxontag(param_00.fx,param_00.visuals[0],param_00.fxtag);
	}

	param_00.trigger.origin = param_00.trigger.origin - (0,0,-10000);
	wait(1);
	param_00.visuals[0].inuse = 0;
}

//Function Number: 122
ammopickup(param_00)
{
	showteamsplashzombies("zombie_max_ammo");
	param_00 playlocalsound("zmb_pickup_general");
	level thread activatemaxammo();
	maps\mp\zombies\_zombies_audio_announcer::announcerpickupdialog("full_reload",param_00);
	level thread removepickup(self);
}

//Function Number: 123
activatemaxammo()
{
	foreach(var_01 in level.players)
	{
		if(maps\mp\zombies\_util::isonhumanteam(var_01) && maps\mp\_utility::isreallyalive(var_01))
		{
			refillammozombies(var_01);
			var_01 playersetem1maxammo();
			var_01.health = var_01.maxhealth;
			if(isdefined(level.activatemaxammofunc))
			{
				var_01 [[ level.activatemaxammofunc ]]();
			}
		}
	}
}

//Function Number: 124
refillammozombies(param_00,param_01)
{
	var_02 = param_00 getweaponslistprimaries();
	var_02[var_02.size] = param_00 getlethalweapon();
	var_02[var_02.size] = param_00 gettacticalweapon();
	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	foreach(var_04 in var_02)
	{
		if(var_04 == "none")
		{
			continue;
		}

		if(maps\mp\zombies\_util::isrippedturretweapon(var_04) || maps\mp\zombies\_util::iszombiekillstreakweapon(var_04))
		{
			continue;
		}

		if(maps\mp\zombies\_util::iszombieequipment(var_04))
		{
			if(!param_01)
			{
				maps\mp\zombies\_wall_buys::fillweaponclip(param_00,var_04);
			}
			else
			{
				maps\mp\zombies\_wall_buys::plusoneweaponclip(param_00,var_04);
			}

			continue;
		}

		param_00 givemaxammo(var_04);
		if(issubstr(var_04,"dlcgun1"))
		{
			var_05 = weaponclipsize(var_04);
			param_00 setweaponammoclip(var_04,var_05,"right");
		}
	}

	if(maps\mp\zombies\_util::isplayerinlaststand(param_00))
	{
		param_00 maps\mp\zombies\_zombies_laststand::refillstoredweaponammo();
	}
}

//Function Number: 125
instakillpickup(param_00)
{
	showteamsplashzombies("zombie_insta_kill");
	param_00 playlocalsound("zmb_pickup_overdrive");
	level thread activateinstakill();
	maps\mp\zombies\_zombies_audio_announcer::announcerpickupdialog("hyper_dmg",param_00);
	level thread removepickup(self);
}

//Function Number: 126
refreshmeleecharge()
{
	var_00 = maps\mp\agents\_agent_utility::getactiveagentsoftype("all");
	foreach(var_02 in var_00)
	{
		if(isalive(var_02))
		{
			var_02 maps\mp\zombies\_zombies::updatemeleechargeforcurrenthealth();
		}
	}
}

//Function Number: 127
activateinstakill()
{
	level notify("instaKillPickup");
	level endon("game_ended");
	level endon("instaKillPickup");
	var_00 = 30;
	if(isdefined(level.instakilltime))
	{
		var_00 = level.instakilltime;
	}

	level thread setendtimeomnvarwithhostmigration("ui_zm_instakill",gettime() + var_00 * 1000);
	maps\mp\_utility::gameflagset("insta_kill");
	refreshmeleecharge();
	maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(var_00);
	maps\mp\_utility::gameflagclear("insta_kill");
	refreshmeleecharge();
}

//Function Number: 128
doublepointspickup(param_00)
{
	showteamsplashzombies("zombie_double_points");
	param_00 playlocalsound("zmb_pickup_general");
	level thread activatedoublepoints();
	maps\mp\zombies\_zombies_audio_announcer::announcerpickupdialog("multiplier",param_00);
	level thread removepickup(self);
}

//Function Number: 129
activatedoublepoints()
{
	level notify("doublePointsPickup");
	level endon("game_ended");
	level endon("doublePointsPickup");
	var_00 = 30;
	if(isdefined(level.doublepointstime))
	{
		var_00 = level.doublepointstime;
	}

	level thread setendtimeomnvarwithhostmigration("ui_zm_doublepoints",gettime() + var_00 * 1000);
	maps\mp\_utility::gameflagset("double_points");
	maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(var_00);
	maps\mp\_utility::gameflagclear("double_points");
}

//Function Number: 130
firesalepickup(param_00)
{
	showteamsplashzombies("zombie_fire_sale");
	param_00 playlocalsound("zmb_pickup_general");
	level thread activatefiresale();
	maps\mp\zombies\_zombies_audio_announcer::announcerpickupdialog("pow_surge",param_00);
	level thread removepickup(self);
}

//Function Number: 131
activatefiresale()
{
	level notify("fireSalePickup");
	level endon("game_ended");
	level endon("fireSalePickup");
	var_00 = 30;
	if(isdefined(level.firesaletime))
	{
		var_00 = level.firesaletime;
	}

	level thread setendtimeomnvarwithhostmigration("ui_zm_firesale",gettime() + var_00 * 1000);
	if(!maps\mp\_utility::gameflag("fire_sale"))
	{
		maps\mp\_utility::gameflagset("fire_sale");
		foreach(var_02 in level.magicboxlocations)
		{
			level thread turnonfiresalemachine(var_02);
		}
	}

	maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(var_00);
	maps\mp\_utility::gameflagclear("fire_sale");
	foreach(var_02 in level.magicboxlocations)
	{
		level thread turnofffiresalemachine(var_02);
	}
}

//Function Number: 132
turnonfiresalemachine(param_00)
{
	while(param_00.isdispensingweapon)
	{
		wait(0.05);
	}

	param_00 sethintstring(&"ZOMBIES_FIRE_SALE_MAGIC_BOX");
	param_00 setsecondaryhintstring(param_00 maps\mp\zombies\_wall_buys::getmagicboxhintstringcost());
	param_00 maps\mp\zombies\_util::settokencost(maps\mp\zombies\_util::creditstotokens(param_00.cost));
	param_00 maps\mp\zombies\_util::tokenhintstring(1);
	if(!param_00.active)
	{
		param_00 maps\mp\zombies\_wall_buys::activatemagicboxeffects(param_00.modelent,param_00.light);
		level thread maps\mp\zombies\_wall_buys::watchmagicboxtrigger(param_00,1);
		return;
	}

	if(param_00.ismoving)
	{
		while(param_00.ismoving)
		{
			wait(0.05);
		}

		param_00 maps\mp\zombies\_wall_buys::activatemagicboxeffects(param_00.modelent,param_00.light);
		level thread maps\mp\zombies\_wall_buys::watchmagicboxtrigger(param_00,1);
	}
}

//Function Number: 133
turnofffiresalemachine(param_00)
{
	while(param_00.isdispensingweapon)
	{
		wait(0.05);
	}

	if(!param_00.active)
	{
		param_00 sethintstring(maps\mp\zombies\_wall_buys::getmagicboxhintsting(1));
		param_00 setsecondaryhintstring(maps\mp\zombies\_wall_buys::getmagicboxhintstringcost(1));
		param_00 maps\mp\zombies\_util::tokenhintstring(0);
		param_00 maps\mp\zombies\_wall_buys::deactivatemagicboxeffects(param_00.modelent,param_00.light);
		param_00 notify("fireSaleOver");
		return;
	}

	param_00 sethintstring(maps\mp\zombies\_wall_buys::getmagicboxhintsting());
	param_00 setsecondaryhintstring(maps\mp\zombies\_wall_buys::getmagicboxhintstringcost());
	param_00 setsecondaryhintstring(param_00 maps\mp\zombies\_wall_buys::getmagicboxhintstringcost());
	param_00 maps\mp\zombies\_util::settokencost(maps\mp\zombies\_util::creditstotokens(param_00.cost));
	param_00 maps\mp\zombies\_util::tokenhintstring(1);
}

//Function Number: 134
trappickup(param_00)
{
	showteamsplashzombies("zombie_activate_traps");
	param_00 playsoundtoteam("zmb_pickup_traps","allies");
	level thread activatetrappickup(param_00);
	maps\mp\zombies\_zombies_audio_announcer::announcerpickupdialog("security",param_00);
	level thread removepickup(self);
}

//Function Number: 135
activatetrappickup(param_00)
{
	var_01 = maps\mp\zombies\_traps::get_trap_time();
	level thread setendtimeomnvarwithhostmigration("ui_zm_alltraps",gettime() + var_01 * 1000);
	foreach(var_03 in level.traps)
	{
		var_03 maps\mp\zombies\_traps::trap_activate(param_00,1);
	}

	foreach(var_06 in level.zombiedoors)
	{
		var_06 notify("trap_trigger",param_00,var_01);
	}
}

//Function Number: 136
nukepickup(param_00)
{
	showteamsplashzombies("zombie_nuke");
	param_00 playlocalsound("zmb_pickup_apocalypse");
	earthquake(0.35,0.95,param_00.origin,128);
	playfx(common_scripts\utility::getfx("nuke_blast"),param_00.origin,anglestoforward(param_00.angles),anglestoup(param_00.angles));
	level thread activatenukepickup(param_00.origin);
	maps\mp\zombies\_zombies_audio_announcer::announcerpickupdialog("dna_bomb",param_00);
	level thread removepickup(self);
}

//Function Number: 137
activatenukepickup(param_00)
{
	foreach(var_02 in level.players)
	{
		var_02 givepointsforevent("nuke");
	}

	var_04 = maps\mp\agents\_agent_utility::getactiveagentsoftype("all");
	var_04 = sortbydistance(var_04,param_00);
	foreach(var_06 in var_04)
	{
		if(var_06.agentteam == level.playerteam)
		{
			continue;
		}

		if(var_06 maps\mp\zombies\_util::instakillimmune())
		{
			continue;
		}

		wait(0.1);
		if(isalive(var_06))
		{
			var_07 = "MOD_EXPLOSIVE";
			if(!isscriptedagent(var_06))
			{
				var_07 = "MOD_ENERGY";
			}

			var_06.killedbynuke = 1;
			var_06 dodamage(var_06.health,var_06.origin,undefined,undefined,var_07,level.ocp_weap_name);
		}
	}
}

//Function Number: 138
showteamsplashzombies(param_00)
{
	foreach(var_02 in level.players)
	{
		if(maps\mp\zombies\_util::isonhumanteam(var_02) && maps\mp\_utility::isreallyalive(var_02))
		{
			var_02 thread maps\mp\gametypes\_hud_message::splashnotify(param_00);
		}
	}
}

//Function Number: 139
zombievignette()
{
	if(isdefined(level.zombievignette))
	{
		var_00 = newhudelem();
		var_00.x = 0;
		var_00.y = 0;
		var_00.alpha = 1;
		var_00.horzalign = "fullscreen";
		var_00.vertalign = "fullscreen";
		var_00.sort = 3;
		var_00 setshader(level.zombievignette,640,480);
	}
}

//Function Number: 140
playermonitorweapon()
{
	self endon("disconnect");
	self setclientomnvar("ui_energy_ammo",1);
	for(;;)
	{
		self waittill("weapon_change",var_00);
		wait 0.05;
		thread playerdoem1logic(var_00);
	}
}

//Function Number: 141
playerdoem1logic(param_00)
{
	self endon("disconnect");
	if(!issubstr(param_00,"iw5_em1zm_mp"))
	{
		if(maps\mp\zombies\_util::playerhasem1ammoinfo() && maps\mp\zombies\_util::playergetem1ammo() <= 0 && !playerhasem1() && !maps\mp\zombies\_util::isplayerinlaststand(self))
		{
			maps\mp\zombies\_util::playerclearem1ammoinfo();
		}

		return;
	}

	playersetem1ammo();
	self setweaponammostock(param_00,0);
	thread playersetupem1ammo();
	self waittill("weapon_change");
	maps\mp\zombies\_util::playerallowfire(1,"em1");
	self notifyonplayercommandremove("fire_em1_weapon","+attack");
	self notifyonplayercommandremove("fire_em1_weapon","+attack_akimbo_accessible");
}

//Function Number: 142
playerhasem1()
{
	var_00 = self getweaponslistprimaries();
	foreach(var_02 in var_00)
	{
		if(issubstr(var_02,"iw5_em1zm_mp"))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 143
playerupdateem1omnvar()
{
	var_00 = getem1maxammo(1);
	var_01 = maps\mp\zombies\_util::playergetem1ammo();
	var_02 = var_01 / var_00;
	self setclientomnvar("ui_energy_ammo",var_02);
}

//Function Number: 144
playersetupem1ammo()
{
	self endon("death");
	self endon("disconnect");
	self endon("weapon_change");
	self notifyonplayercommand("fire_em1_weapon","+attack");
	self notifyonplayercommand("fire_em1_weapon","+attack_akimbo_accessible");
	var_00 = maps\mp\zombies\_util::playergetem1ammo();
	playerupdateem1omnvar();
	if(var_00 <= 0)
	{
		maps\mp\zombies\_util::playerallowfire(0,"em1");
	}

	for(;;)
	{
		if(!self attackbuttonpressed())
		{
			self waittill("fire_em1_weapon");
		}

		var_01 = self getcurrentweapon();
		if(self isreloading() || !issubstr(var_01,"iw5_em1zm_mp") || !self isfiring() || self isusingoffhand())
		{
			wait 0.05;
			continue;
		}

		var_00 = maps\mp\zombies\_util::playergetem1ammo();
		playerupdateem1omnvar();
		if(var_00 <= 0)
		{
			var_02 = self getweaponslistprimaries();
			var_03 = maps\mp\_utility::getbaseweaponname(var_02[0]);
			if(var_03 != "iw5_em1zm")
			{
				maps\mp\zombies\_util::playerallowfire(0,"em1");
				self switchtoweapon(var_02[0]);
				wait 0.05;
				continue;
			}

			if(var_02.size > 1)
			{
				var_03 = maps\mp\_utility::getbaseweaponname(var_02[1]);
				if(var_03 != "iw5_em1zm")
				{
					self switchtoweapon(var_02[1]);
					maps\mp\zombies\_util::playerallowfire(0,"em1");
					wait 0.05;
					continue;
				}
			}

			maps\mp\zombies\_util::playerallowfire(0,"em1");
			wait 0.05;
			continue;
		}

		wait 0.05;
		if(maps\mp\zombies\_util::gameflagexists("unlimited_ammo") && maps\mp\_utility::gameflag("unlimited_ammo"))
		{
			continue;
		}

		var_00 = maps\mp\zombies\_util::playergetem1ammo();
		maps\mp\zombies\_util::playerrecordem1ammo(var_00 - 1);
	}
}

//Function Number: 145
playersetem1ammo()
{
	if(!isdefined(self.pers["em1Ammo"]))
	{
		self.pers["em1Ammo"] = spawnstruct();
		playersetem1maxammo();
		maps\mp\zombies\_util::playerallowfire(1,"em1");
	}
}

//Function Number: 146
getem1maxammo(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 0;
	}

	var_01 = 1;
	if(!param_00 && self hasperk("specialty_stockpile",1))
	{
		var_01 = var_01 * 1.2;
	}

	return 1800 * var_01;
}

//Function Number: 147
playersetem1maxammo()
{
	if(isdefined(self.pers["em1Ammo"]))
	{
		var_00 = getem1maxammo();
		self.pers["em1Ammo"].ammo = var_00;
		playerupdateem1omnvar();
		maps\mp\zombies\_util::playerallowfire(1,"em1");
	}
}

//Function Number: 148
playerpostslam_deathwaiter(param_00)
{
	self notify("postSlamDeathWaiter");
	self endon("postSlamDeathWaiter");
	self endon("postSlamTimedOut");
	self waittill("death");
	playerpostslam_reenableboost(param_00);
}

//Function Number: 149
playerpostslam_reenableboost(param_00)
{
	maps\mp\gametypes\_scrambler::playersethudempscrambledoff(param_00);
	maps\mp\_utility::playerallowhighjump(1,"postSlam");
	maps\mp\_utility::playerallowhighjumpdrop(1,"postSlam");
	maps\mp\_utility::playerallowboostjump(1,"postSlam");
	maps\mp\_utility::playerallowpowerslide(1,"postSlam");
	maps\mp\_utility::playerallowdodge(1,"postSlam");
}

//Function Number: 150
playerpostslam_disableboost()
{
	self notify("postSlamDisableBoost");
	self endon("postSlamDisableBoost");
	self endon("death");
	self endon("disconnect");
	var_00 = 2;
	var_01 = gettime() + var_00 * 1000;
	var_02 = maps\mp\gametypes\_scrambler::playersethudempscrambled(var_01,1,"postSlam");
	maps\mp\_utility::playerallowhighjump(0,"postSlam");
	maps\mp\_utility::playerallowhighjumpdrop(0,"postSlam");
	maps\mp\_utility::playerallowboostjump(0,"postSlam");
	maps\mp\_utility::playerallowpowerslide(0,"postSlam");
	maps\mp\_utility::playerallowdodge(0,"postSlam");
	thread playerpostslam_deathwaiter(var_02);
	wait(var_00);
	self notify("postSlamTimedOut");
	playerpostslam_reenableboost(var_02);
}

//Function Number: 151
playermonitorboostevents()
{
	self endon("disconnect");
	self.exoeventtime = 0;
	self.exoboosttime = 0;
	self.exoslamtime = 0;
	self.exododgetime = 0;
	self.exoslidetime = 0;
	for(;;)
	{
		var_00 = common_scripts\utility::waittill_any_return_no_endon_death("exo_boost","ground_slam","exo_dodge","exo_slide");
		self.exoeventtime = gettime();
		switch(var_00)
		{
			case "exo_boost":
				self.exoboosttime = gettime();
				break;
	
			case "ground_slam":
				self.exoslamtime = gettime();
				break;
	
			case "exo_dodge":
				self.exododgetime = gettime();
				break;
	
			case "exo_slide":
				self.exoslidetime = gettime();
				break;
		}
	}
}

//Function Number: 152
giveplayerszombieachievement(param_00)
{
	foreach(var_02 in level.players)
	{
		if(!isdefined(var_02.joinedround1) || !var_02.joinedround1)
		{
			continue;
		}

		var_02 givezombieachievement(param_00);
	}
}

//Function Number: 153
givezombieachievement(param_00)
{
	var_01 = maps\mp\_utility::getmapname();
	switch(var_01)
	{
		case "mp_zombie_lab":
			if(!issubstr(param_00,"DLC1"))
			{
				return;
			}
			break;

		case "mp_zombie_brg":
			if(!issubstr(param_00,"DLC2"))
			{
				return;
			}
			break;

		case "mp_zombie_ark":
			if(!issubstr(param_00,"DLC3"))
			{
				return;
			}
			break;

		case "mp_zombie_h2o":
			if(!issubstr(param_00,"DLC4"))
			{
				return;
			}
			break;
	}

	self giveachievement(param_00);
}

//Function Number: 154
setendtimeomnvarwithhostmigration(param_00,param_01)
{
	level endon("game_ended");
	level notify(param_00 + "_cancel");
	level endon(param_00 + "_cancel");
	for(;;)
	{
		setomnvar(param_00,param_01);
		level common_scripts\utility::waittill_notify_or_timeout("host_migration_begin",param_01 - gettime() / 1000);
		setomnvar(param_00,0);
		if(gettime() >= param_01)
		{
			break;
		}

		var_02 = maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();
		param_01 = param_01 + var_02;
		if(gettime() >= param_01)
		{
			break;
		}
	}
}

//Function Number: 155
hurtplayersthink()
{
	level endon("game_ended");
	wait(randomfloat(1));
	for(;;)
	{
		foreach(var_01 in level.players)
		{
			if(var_01 istouching(self) && maps\mp\_utility::isreallyalive(var_01))
			{
				var_02 = "ui_zm_character_" + var_01.characterindex + "_alive";
				setomnvar(var_02,0);
				var_01 maps\mp\_utility::_suicide();
			}
		}

		wait(0.5);
	}
}

//Function Number: 156
moversuicidecustom()
{
	var_00 = "ui_zm_character_" + self.characterindex + "_alive";
	setomnvar(var_00,0);
	maps\mp\_utility::_suicide();
	if(level.players.size < 2)
	{
		maps\mp\zombies\_zombies_laststand::zombieendgame(undefined,"MOD_SUICIDE");
	}
}

//Function Number: 157
getroundintermissionduration()
{
	return 10;
}