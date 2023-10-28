/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\killstreaks\_supplydrop.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: PC
 * Function Count: 97
 * Decompile Time: 75 ms
 * Timestamp: 10/28/2023 12:10:48 AM
*******************************************************************/

#include common_scripts/utility;
#include maps/mp/_challenges;
#include maps/mp/_entityheadicons;
#include maps/mp/_hacker_tool;
#include maps/mp/_popups;
#include maps/mp/_scoreevents;
#include maps/mp/_tacticalinsertion;
#include maps/mp/_utility;
#include maps/mp/gametypes/_callbacksetup;
#include maps/mp/gametypes/_gameobjects;
#include maps/mp/gametypes/_hostmigration;
#include maps/mp/gametypes/_hud_util;
#include maps/mp/gametypes/_weaponobjects;
#include maps/mp/gametypes/_weapons;
#include maps/mp/killstreaks/_ai_tank;
#include maps/mp/killstreaks/_airsupport;
#include maps/mp/killstreaks/_emp;
#include maps/mp/killstreaks/_helicopter;
#include maps/mp/killstreaks/_killstreak_weapons;
#include maps/mp/killstreaks/_killstreakrules;
#include maps/mp/killstreaks/_killstreaks;
#include maps/mp/killstreaks/_supplydrop;

#using_animtree( "mp_vehicles" );

//Function Number: 1
init()
{
	level.cratemodelfriendly = "t6_wpn_supply_drop_ally";
	level.cratemodelenemy = "t6_wpn_supply_drop_axis";
	level.cratemodelhacker = "t6_wpn_supply_drop_detect";
	level.cratemodeltank = "t6_wpn_drop_box";
	level.cratemodelboobytrapped = "t6_wpn_supply_drop_trap";
	level.supplydrophelicopterfriendly = "veh_t6_drone_supply";
	level.supplydrophelicopterenemy = "veh_t6_drone_supply_alt";
	level.suppydrophelicoptervehicleinfo = "heli_supplydrop_mp";
	level.crateownerusetime = 500;
	level.cratenonownerusetime = getgametypesetting("crateCaptureTime") * 1000;
	level.crate_headicon_offset = VectorScale((0,0,1));
	level.supplydropdisarmcrate = &"KILLSTREAK_SUPPLY_DROP_DISARM_HINT";
	level.disarmingcrate = &"KILLSTREAK_SUPPLY_DROP_DISARMING_CRATE";
	level.supplydropcarepackageidleanim = %o_drone_supply_care_idle;
	level.supplydropcarepackagedropanim = %o_drone_supply_care_drop;
	level.supplydropaitankidleanim = %o_drone_supply_agr_idle;
	level.supplydropaitankdropanim = %o_drone_supply_agr_drop;
	precachemodel(level.cratemodelfriendly);
	precachemodel(level.cratemodelenemy);
	precachemodel(level.cratemodelhacker);
	precachemodel(level.cratemodeltank);
	precachemodel(level.cratemodelboobytrapped);
	precachemodel(level.supplydrophelicopterfriendly);
	precachemodel(level.supplydrophelicopterenemy);
	precachevehicle(level.suppydrophelicoptervehicleinfo);
	precacheshader("compass_supply_drop_black");
	precacheshader("compass_supply_drop_green");
	precacheshader("compass_supply_drop_red");
	precacheshader("waypoint_recon_artillery_strike");
	precacheshader("hud_ks_minigun");
	precacheshader("hud_ks_minigun_drop");
	precacheshader("hud_ks_m32");
	precacheshader("hud_ks_m32_drop");
	precacheshader("hud_ks_m202");
	precacheshader("hud_ks_m202_drop");
	precacheshader("hud_ammo_refill");
	precacheshader("hud_ammo_refill_drop");
	precacheshader("hud_ks_ai_tank_drop");
	precachestring(&"KILLSTREAK_CAPTURING_CRATE");
	precachestring(&"KILLSTREAK_SUPPLY_DROP_DISARM_HINT");
	precachestring(&"KILLSTREAK_SUPPLY_DROP_DISARMING_CRATE");
	precacheshader("headicon_dead");
	registerclientfield("helicopter","supplydrop_care_package_state",1,1,"int");
	registerclientfield("helicopter","supplydrop_ai_tank_state",1,1,"int");
	level._supply_drop_smoke_fx = loadfx("env/smoke/fx_smoke_supply_drop_blue_mp");
	level._supply_drop_explosion_fx = loadfx("explosions/fx_grenadeexp_default");
	maps/mp/killstreaks/_killstreaks::registerkillstreak("inventory_supply_drop_mp","inventory_supplydrop_mp","killstreak_supply_drop","supply_drop_used",::usekillstreaksupplydrop,undefined,1);
	maps/mp/killstreaks/_killstreaks::registerkillstreakstrings("inventory_supply_drop_mp",&"KILLSTREAK_EARNED_SUPPLY_DROP",&"KILLSTREAK_AIRSPACE_FULL",&"KILLSTREAK_SUPPLY_DROP_INBOUND");
	maps/mp/killstreaks/_killstreaks::registerkillstreakdialog("inventory_supply_drop_mp","mpl_killstreak_supply","kls_supply_used","","kls_supply_enemy","","kls_supply_ready");
	maps/mp/killstreaks/_killstreaks::registerkillstreakaltweapon("inventory_supply_drop_mp","mp40_blinged_mp");
	maps/mp/killstreaks/_killstreaks::allowkillstreakassists("inventory_supply_drop_mp",1);
	maps/mp/killstreaks/_killstreaks::registerkillstreakdevdvar("inventory_supply_drop_mp","scr_givesupplydrop");
	maps/mp/killstreaks/_killstreaks::registerkillstreak("supply_drop_mp","supplydrop_mp","killstreak_supply_drop","supply_drop_used",::usekillstreaksupplydrop,undefined,1);
	maps/mp/killstreaks/_killstreaks::registerkillstreakstrings("supply_drop_mp",&"KILLSTREAK_EARNED_SUPPLY_DROP",&"KILLSTREAK_AIRSPACE_FULL",&"KILLSTREAK_SUPPLY_DROP_INBOUND");
	maps/mp/killstreaks/_killstreaks::registerkillstreakdialog("supply_drop_mp","mpl_killstreak_supply","kls_supply_used","","kls_supply_enemy","","kls_supply_ready");
	maps/mp/killstreaks/_killstreaks::registerkillstreakaltweapon("supply_drop_mp","mp40_blinged_mp");
	maps/mp/killstreaks/_killstreaks::allowkillstreakassists("supply_drop_mp",1);
	level.cratetypes = [];
	level.categorytypeweight = [];
	registercratetype("ai_tank_drop_mp","killstreak","ai_tank_mp",1,&"KILLSTREAK_AI_TANK_CRATE",undefined,undefined,undefined,maps/mp/killstreaks/_ai_tank::crateland);
	registercratetype("inventory_ai_tank_drop_mp","killstreak","ai_tank_mp",1,&"KILLSTREAK_AI_TANK_CRATE",undefined,undefined,undefined,maps/mp/killstreaks/_ai_tank::crateland);
	registercratetype("minigun_drop_mp","killstreak","minigun_mp",1,&"KILLSTREAK_MINIGUN_CRATE",&"PLATFORM_MINIGUN_GAMBLER","share_package_death_machine",::givecrateweapon);
	registercratetype("inventory_minigun_drop_mp","killstreak","minigun_mp",1,&"KILLSTREAK_MINIGUN_CRATE",&"PLATFORM_MINIGUN_GAMBLER","share_package_death_machine",::givecrateweapon);
	registercratetype("m32_drop_mp","killstreak","m32_mp",1,&"KILLSTREAK_M32_CRATE",&"PLATFORM_M32_GAMBLER","share_package_multiple_grenade_launcher",::givecrateweapon);
	registercratetype("inventory_m32_drop_mp","killstreak","m32_mp",1,&"KILLSTREAK_M32_CRATE",&"PLATFORM_M32_GAMBLER","share_package_multiple_grenade_launcher",::givecrateweapon);
	registercratetype("supplydrop_mp","killstreak","radar_mp",100,&"KILLSTREAK_RADAR_CRATE",&"PLATFORM_RADAR_GAMBLER","share_package_uav",::givecratekillstreak);
	registercratetype("supplydrop_mp","killstreak","rcbomb_mp",100,&"KILLSTREAK_RCBOMB_CRATE",&"PLATFORM_RCBOMB_GAMBLER","share_package_rcbomb",::givecratekillstreak);
	registercratetype("supplydrop_mp","killstreak","inventory_missile_drone_mp",100,&"KILLSTREAK_MISSILE_DRONE_CRATE",&"PLATFORM_MISSILE_DRONE_GAMBLER","share_package_missile_drone",::givecratekillstreak);
	registercratetype("supplydrop_mp","killstreak","counteruav_mp",100,&"KILLSTREAK_COUNTERU2_CRATE",&"PLATFORM_COUNTERU2_GAMBLER","share_package_counter_uav",::givecratekillstreak);
	registercratetype("supplydrop_mp","killstreak","remote_missile_mp",85,&"KILLSTREAK_REMOTE_MISSILE_CRATE",&"PLATFORM_REMOTE_MISSILE_GAMBLER","share_package_remote_missile",::givecratekillstreak);
	registercratetype("supplydrop_mp","killstreak","planemortar_mp",80,&"KILLSTREAK_PLANE_MORTAR_CRATE",&"PLATFORM_PLANE_MORTAR_GAMBLER","share_package_plane_mortar",::givecratekillstreak);
	registercratetype("supplydrop_mp","killstreak","autoturret_mp",80,&"KILLSTREAK_AUTO_TURRET_CRATE",&"PLATFORM_AUTO_TURRET_GAMBLER","share_package_sentry_gun",::givecratekillstreak);
	registercratetype("supplydrop_mp","killstreak","microwaveturret_mp",120,&"KILLSTREAK_MICROWAVE_TURRET_CRATE",&"PLATFORM_MICROWAVE_TURRET_GAMBLER","share_package_microwave_turret",::givecratekillstreak);
	registercratetype("supplydrop_mp","killstreak","inventory_minigun_mp",60,&"KILLSTREAK_MINIGUN_CRATE",&"PLATFORM_MINIGUN_GAMBLER","share_package_death_machine",::givecratekillstreak);
	registercratetype("supplydrop_mp","killstreak","inventory_m32_mp",60,&"KILLSTREAK_M32_CRATE",&"PLATFORM_M32_GAMBLER","share_package_multiple_grenade_launcher",::givecratekillstreak);
	registercratetype("supplydrop_mp","killstreak","helicopter_guard_mp",20,&"KILLSTREAK_HELICOPTER_GUARD_CRATE",&"PLATFORM_HELICOPTER_GUARD_GAMBLER","share_package_helicopter_guard",::givecratekillstreak);
	registercratetype("supplydrop_mp","killstreak","radardirection_mp",20,&"KILLSTREAK_SATELLITE_CRATE",&"PLATFORM_SATELLITE_GAMBLER","share_package_satellite",::givecratekillstreak);
	registercratetype("supplydrop_mp","killstreak","qrdrone_mp",20,&"KILLSTREAK_QRDRONE_CRATE",&"PLATFORM_QRDRONE_GAMBLER","share_package_qrdrone",::givecratekillstreak);
	registercratetype("supplydrop_mp","killstreak","inventory_ai_tank_drop_mp",20,&"KILLSTREAK_AI_TANK_CRATE",&"PLATFORM_AI_TANK_GAMBLER","share_package_aitank",::givecratekillstreak);
	registercratetype("supplydrop_mp","killstreak","helicopter_comlink_mp",20,&"KILLSTREAK_HELICOPTER_CRATE",&"PLATFORM_HELICOPTER_GAMBLER","share_package_helicopter_comlink",::givecratekillstreak);
	registercratetype("supplydrop_mp","killstreak","emp_mp",5,&"KILLSTREAK_EMP_CRATE",&"PLATFORM_EMP_GAMBLER","share_package_emp",::givecratekillstreak);
	registercratetype("supplydrop_mp","killstreak","remote_mortar_mp",2,&"KILLSTREAK_REMOTE_MORTAR_CRATE",&"PLATFORM_REMOTE_MORTAR_GAMBLER","share_package_remote_mortar",::givecratekillstreak);
	registercratetype("supplydrop_mp","killstreak","helicopter_player_gunner_mp",2,&"KILLSTREAK_HELICOPTER_GUNNER_CRATE",&"PLATFORM_HELICOPTER_GUNNER_GAMBLER","share_package_helicopter_gunner",::givecratekillstreak);
	registercratetype("supplydrop_mp","killstreak","dogs_mp",2,&"KILLSTREAK_DOGS_CRATE",&"PLATFORM_DOGS_GAMBLER","share_package_dogs",::givecratekillstreak);
	registercratetype("supplydrop_mp","killstreak","straferun_mp",2,&"KILLSTREAK_STRAFERUN_CRATE",&"PLATFORM_STRAFERUN_GAMBLER","share_package_strafe_run",::givecratekillstreak);
	registercratetype("supplydrop_mp","killstreak","missile_swarm_mp",2,&"KILLSTREAK_MISSILE_SWARM_CRATE",&"PLATFORM_MISSILE_SWARM_GAMBLER","share_package_missile_swarm",::givecratekillstreak);
	registercratetype("inventory_supplydrop_mp","killstreak","radar_mp",100,&"KILLSTREAK_RADAR_CRATE",&"PLATFORM_RADAR_GAMBLER","share_package_uav",::givecratekillstreak);
	registercratetype("inventory_supplydrop_mp","killstreak","counteruav_mp",100,&"KILLSTREAK_COUNTERU2_CRATE",&"PLATFORM_COUNTERU2_GAMBLER","share_package_counter_uav",::givecratekillstreak);
	registercratetype("inventory_supplydrop_mp","killstreak","rcbomb_mp",100,&"KILLSTREAK_RCBOMB_CRATE",&"PLATFORM_RCBOMB_GAMBLER","share_package_rcbomb",::givecratekillstreak);
	registercratetype("inventory_supplydrop_mp","killstreak","inventory_missile_drone_mp",100,&"KILLSTREAK_MISSILE_DRONE_CRATE",&"PLATFORM_MISSILE_DRONE_GAMBLER","share_package_missile_drone",::givecratekillstreak);
	registercratetype("inventory_supplydrop_mp","killstreak","qrdrone_mp",20,&"KILLSTREAK_QRDRONE_CRATE",&"PLATFORM_QRDRONE_GAMBLER","share_package_qrdrone",::givecratekillstreak);
	registercratetype("inventory_supplydrop_mp","killstreak","remote_missile_mp",85,&"KILLSTREAK_REMOTE_MISSILE_CRATE",&"PLATFORM_REMOTE_MISSILE_GAMBLER","share_package_remote_missile",::givecratekillstreak);
	registercratetype("inventory_supplydrop_mp","killstreak","planemortar_mp",80,&"KILLSTREAK_PLANE_MORTAR_CRATE",&"PLATFORM_PLANE_MORTAR_GAMBLER","share_package_plane_mortar",::givecratekillstreak);
	registercratetype("inventory_supplydrop_mp","killstreak","autoturret_mp",80,&"KILLSTREAK_AUTO_TURRET_CRATE",&"PLATFORM_AUTO_TURRET_GAMBLER","share_package_sentry_gun",::givecratekillstreak);
	registercratetype("inventory_supplydrop_mp","killstreak","microwaveturret_mp",120,&"KILLSTREAK_MICROWAVE_TURRET_CRATE",&"PLATFORM_MICROWAVE_TURRET_GAMBLER","share_package_microwave_turret",::givecratekillstreak);
	registercratetype("inventory_supplydrop_mp","killstreak","inventory_minigun_mp",60,&"KILLSTREAK_MINIGUN_CRATE",&"PLATFORM_MINIGUN_GAMBLER","share_package_death_machine",::givecratekillstreak);
	registercratetype("inventory_supplydrop_mp","killstreak","inventory_m32_mp",60,&"KILLSTREAK_M32_CRATE",&"PLATFORM_M32_GAMBLER","share_package_multiple_grenade_launcher",::givecratekillstreak);
	registercratetype("inventory_supplydrop_mp","killstreak","remote_mortar_mp",2,&"KILLSTREAK_REMOTE_MORTAR_CRATE",&"PLATFORM_REMOTE_MORTAR_GAMBLER","share_package_remote_mortar",::givecratekillstreak);
	registercratetype("inventory_supplydrop_mp","killstreak","helicopter_guard_mp",20,&"KILLSTREAK_HELICOPTER_GUARD_CRATE",&"PLATFORM_HELICOPTER_GUARD_GAMBLER","share_package_helicopter_guard",::givecratekillstreak);
	registercratetype("inventory_supplydrop_mp","killstreak","radardirection_mp",20,&"KILLSTREAK_SATELLITE_CRATE",&"PLATFORM_SATELLITE_GAMBLER","share_package_satellite",::givecratekillstreak);
	registercratetype("inventory_supplydrop_mp","killstreak","inventory_ai_tank_drop_mp",20,&"KILLSTREAK_AI_TANK_CRATE",&"PLATFORM_AI_TANK_GAMBLER","share_package_aitank",::givecratekillstreak);
	registercratetype("inventory_supplydrop_mp","killstreak","helicopter_comlink_mp",20,&"KILLSTREAK_HELICOPTER_CRATE",&"PLATFORM_HELICOPTER_GAMBLER","share_package_helicopter_comlink",::givecratekillstreak);
	registercratetype("inventory_supplydrop_mp","killstreak","emp_mp",5,&"KILLSTREAK_EMP_CRATE",&"PLATFORM_EMP_GAMBLER","share_package_emp",::givecratekillstreak);
	registercratetype("inventory_supplydrop_mp","killstreak","helicopter_player_gunner_mp",2,&"KILLSTREAK_HELICOPTER_GUNNER_CRATE",&"PLATFORM_HELICOPTER_GUNNER_GAMBLER","share_package_helicopter_gunner",::givecratekillstreak);
	registercratetype("inventory_supplydrop_mp","killstreak","dogs_mp",2,&"KILLSTREAK_DOGS_CRATE",&"PLATFORM_DOGS_GAMBLER","share_package_dogs",::givecratekillstreak);
	registercratetype("inventory_supplydrop_mp","killstreak","straferun_mp",2,&"KILLSTREAK_STRAFERUN_CRATE",&"PLATFORM_STRAFERUN_GAMBLER","share_package_strafe_run",::givecratekillstreak);
	registercratetype("inventory_supplydrop_mp","killstreak","missile_swarm_mp",2,&"KILLSTREAK_MISSILE_SWARM_CRATE",&"PLATFORM_MISSILE_SWARM_GAMBLER","share_package_missile_swarm",::givecratekillstreak);
	registercratetype("gambler_mp","killstreak","radar_mp",80,&"KILLSTREAK_RADAR_CRATE",undefined,"share_package_uav",::givecratekillstreak);
	registercratetype("gambler_mp","killstreak","counteruav_mp",80,&"KILLSTREAK_COUNTERU2_CRATE",undefined,"share_package_counter_uav",::givecratekillstreak);
	registercratetype("gambler_mp","killstreak","rcbomb_mp",80,&"KILLSTREAK_RCBOMB_CRATE",undefined,"share_package_rcbomb",::givecratekillstreak);
	registercratetype("gambler_mp","killstreak","inventory_missile_drone_mp",90,&"KILLSTREAK_MISSILE_DRONE_CRATE",undefined,"share_package_missile_drone",::givecratekillstreak);
	registercratetype("gambler_mp","killstreak","qrdrone_mp",30,&"KILLSTREAK_QRDRONE_CRATE",undefined,"share_package_qrdrone",::givecratekillstreak);
	registercratetype("gambler_mp","killstreak","microwaveturret_mp",100,&"KILLSTREAK_MICROWAVE_TURRET_CRATE",undefined,"share_package_microwave_turret",::givecratekillstreak);
	registercratetype("gambler_mp","killstreak","remote_missile_mp",90,&"KILLSTREAK_REMOTE_MISSILE_CRATE",undefined,"share_package_remote_missile",::givecratekillstreak);
	registercratetype("gambler_mp","killstreak","planemortar_mp",90,&"KILLSTREAK_PLANE_MORTAR_CRATE",undefined,"share_package_plane_mortar",::givecratekillstreak);
	registercratetype("gambler_mp","killstreak","autoturret_mp",90,&"KILLSTREAK_AUTO_TURRET_CRATE",undefined,"share_package_sentry_gun",::givecratekillstreak);
	registercratetype("gambler_mp","killstreak","inventory_minigun_mp",60,&"KILLSTREAK_MINIGUN_CRATE",undefined,"share_package_death_machine",::givecratekillstreak);
	registercratetype("gambler_mp","killstreak","inventory_m32_mp",60,&"KILLSTREAK_M32_CRATE",undefined,"share_package_multiple_grenade_launcher",::givecratekillstreak);
	registercratetype("gambler_mp","killstreak","remote_mortar_mp",2,&"KILLSTREAK_REMOTE_MORTAR_CRATE",undefined,"share_package_remote_mortar",::givecratekillstreak);
	registercratetype("gambler_mp","killstreak","helicopter_guard_mp",30,&"KILLSTREAK_HELICOPTER_GUARD_CRATE",undefined,"share_package_helicopter_guard",::givecratekillstreak);
	registercratetype("gambler_mp","killstreak","radardirection_mp",30,&"KILLSTREAK_SATELLITE_CRATE",undefined,"share_package_satellite",::givecratekillstreak);
	registercratetype("gambler_mp","killstreak","inventory_ai_tank_drop_mp",30,&"KILLSTREAK_AI_TANK_CRATE",undefined,"share_package_aitank",::givecratekillstreak);
	registercratetype("gambler_mp","killstreak","helicopter_comlink_mp",30,&"KILLSTREAK_HELICOPTER_CRATE",undefined,"share_package_helicopter_comlink",::givecratekillstreak);
	registercratetype("gambler_mp","killstreak","straferun_mp",2,&"KILLSTREAK_STRAFERUN_CRATE",undefined,"share_package_strafe_run",::givecratekillstreak);
	registercratetype("gambler_mp","killstreak","emp_mp",10,&"KILLSTREAK_EMP_CRATE",undefined,"share_package_emp",::givecratekillstreak);
	registercratetype("gambler_mp","killstreak","helicopter_player_gunner_mp",2,&"KILLSTREAK_HELICOPTER_GUNNER_CRATE",undefined,"share_package_helicopter_gunner",::givecratekillstreak);
	registercratetype("gambler_mp","killstreak","dogs_mp",2,&"KILLSTREAK_DOGS_CRATE",undefined,"share_package_dogs",::givecratekillstreak);
	registercratetype("gambler_mp","killstreak","missile_swarm_mp",2,&"KILLSTREAK_MISSILE_SWARM_CRATE",undefined,"share_package_missile_swarm",::givecratekillstreak);
	level.cratecategoryweights = [];
	level.cratecategorytypeweights = [];
	foreach(categorykey, category in level.cratetypes)
	{
		finalizecratecategory(categorykey);
	}

/#
	level thread supply_drop_dev_gui();
	getdvarintdefault("scr_crate_notimeout",0);
#/
}

//Function Number: 2
finalizecratecategory(category)
{
	level.cratecategoryweights[category] = 0;
	cratetypekeys = getarraykeys(level.cratetypes[category]);
	for(cratetype = 0;cratetype < cratetypekeys.size;cratetype++)
	{
		typekey = cratetypekeys[cratetype];
		level.cratetypes[category][typekey].previousweight = level.cratecategoryweights[category];
		level.cratecategoryweights[category] = level.cratecategoryweights[category] + level.cratetypes[category][typekey].weight;
		level.cratetypes[category][typekey].weight = level.cratecategoryweights[category];
	}
}

//Function Number: 3
advancedfinalizecratecategory(category)
{
	level.cratecategorytypeweights[category] = 0;
	cratetypekeys = getarraykeys(level.categorytypeweight[category]);
	for(cratetype = 0;cratetype < cratetypekeys.size;cratetype++)
	{
		typekey = cratetypekeys[cratetype];
		level.cratecategorytypeweights[category] = level.cratecategorytypeweights[category] + level.categorytypeweight[category][typekey].weight;
		level.categorytypeweight[category][typekey].weight = level.cratecategorytypeweights[category];
	}

	finalizecratecategory(category);
}

//Function Number: 4
setcategorytypeweight(category,type,weight)
{
	if(!(IsDefined(level.categorytypeweight[category])))
	{
		level.categorytypeweight[category] = [];
	}

	level.categorytypeweight[category][type] = spawnstruct();
	level.categorytypeweight[category][type].weight = weight;
	count = 0;
	totalweight = 0;
	startindex = undefined;
	finalindex = undefined;
	cratenamekeys = getarraykeys(level.cratetypes[category]);
	for(cratename = 0;cratename < cratenamekeys.size;cratename++)
	{
		namekey = cratenamekeys[cratename];
		if(level.cratetypes[category][namekey].type == type)
		{
			count++;
			totalweight = totalweight + level.cratetypes[category][namekey].weight;
			if(!(IsDefined(startindex)))
			{
				startindex = cratename;
			}

			if(IsDefined(finalindex) && finalindex + 1 != cratename)
			{
/#
				maps/mp/_utility::error("Crate type declaration must be contiguous");
#/
				maps/mp/gametypes/_callbacksetup::abortlevel();
				return;
			}

			finalindex = cratename;
		}
	}

	level.categorytypeweight[category][type].totalcrateweight = totalweight;
	level.categorytypeweight[category][type].cratecount = count;
	level.categorytypeweight[category][type].startindex = startindex;
	level.categorytypeweight[category][type].finalindex = finalindex;
}

//Function Number: 5
registercratetype(category,type,name,weight,hint,hint_gambler,sharestat,givefunction,landfunctionoverride)
{
	if(!(IsDefined(level.cratetypes[category])))
	{
		level.cratetypes[category] = [];
	}

	cratetype = spawnstruct();
	cratetype.type = type;
	cratetype.name = name;
	cratetype.weight = weight;
	cratetype.hint = hint;
	cratetype.hint_gambler = hint_gambler;
	cratetype.sharestat = sharestat;
	cratetype.givefunction = givefunction;
	if(IsDefined(landfunctionoverride))
	{
		cratetype.landfunctionoverride = landfunctionoverride;
	}

	level.cratetypes[category][name] = cratetype;
	game["strings"][name + "_hint"] = hint;
}

//Function Number: 6
getrandomcratetype(category,gambler_crate_name)
{
/#
	assert(IsDefined(level.cratetypes));
#/
/#
	assert(IsDefined(level.cratetypes[category]));
#/
/#
	assert(IsDefined(level.cratecategoryweights[category]));
#/
	typekey = undefined;
	cratetypestart = 0;
	randomweightend = randomintrange(1,level.cratecategoryweights[category] + 1);
	find_another = 0;
	cratenamekeys = getarraykeys(level.cratetypes[category]);
	if(IsDefined(level.categorytypeweight[category]))
	{
		randomweightend = randomint(level.cratecategorytypeweights[category]) + 1;
		cratetypekeys = getarraykeys(level.categorytypeweight[category]);
		for(cratetype = 0;cratetype < cratetypekeys.size;cratetype++)
		{
			typekey = cratetypekeys[cratetype];
			if(level.categorytypeweight[category][typekey].weight < randomweightend)
			{
			}
			else
			{
				cratetypestart = level.categorytypeweight[category][typekey].startindex;
				randomweightend = randomint(level.categorytypeweight[category][typekey].totalcrateweight) + 1;
				randomweightend = randomweightend + level.cratetypes[category][cratenamekeys[cratetypestart]].previousweight;
				break;
			}
		}
	}

	for(cratetype = cratetypestart;cratetype < cratenamekeys.size;cratetype++)
	{
		typekey = cratenamekeys[cratetype];
		if(level.cratetypes[category][typekey].weight < randomweightend)
		{
		}
		else
		{
			if(IsDefined(gambler_crate_name) && level.cratetypes[category][typekey].name == gambler_crate_name)
			{
				find_another = 1;
			}

			if(find_another)
			{
				if(cratetype < cratenamekeys.size - 1)
				{
					cratetype++;
				}
				else if(cratetype > 0)
				{
					cratetype--;
				}

				typekey = cratenamekeys[cratetype];
			}

			break;
		}
	}

/#
	if(IsDefined(level.dev_gui_supply_drop) && level.dev_gui_supply_drop != "random")
	{
		typekey = level.dev_gui_supply_drop;
	}
#/
	return level.cratetypes[category][typekey];
}

//Function Number: 7
validate_crate_type(killstreak_name,weapon_name,crate_type_name)
{
	players = get_players();
	for(i = 0;i < players.size;i++)
	{
		if(isalive(players[i]))
		{
			for(j = 0;j < players[i].pers["killstreaks"].size;j++)
			{
				if(players[i].pers["killstreaks"][j] == killstreak_name)
				{
					return 1;
				}
			}

			primary_weapons = players[i] getweaponslistprimaries();
			for(j = 0;j < primary_weapons.size;j++)
			{
				if(primary_weapons[j] == weapon_name)
				{
					return 1;
				}
			}

			ents = getentarray("weapon_" + weapon_name,"classname");
			if(IsDefined(ents) && ents.size > 0)
			{
				return 1;
			}

			crate_ents = getentarray("care_package","script_noteworthy");
			for(j = 0;j < crate_ents.size;j++)
			{
				if(!(IsDefined(crate_ents[j].cratetype)))
				{
				}
				else if(IsDefined(crate_ents[j].cratetype.name))
				{
					if(crate_ents[j].cratetype.name == crate_type_name)
					{
						return 1;
					}
				}
			}
		}
	}

	return 0;
}

//Function Number: 8
givecrateitem(crate)
{
	if(!(isalive(self)))
	{
		return;
	}

	return [[ crate.cratetype.givefunction ]](crate.cratetype.name);
}

//Function Number: 9
givecratekillstreakwaiter(event,removecrate,extraendon)
{
	self endon("give_crate_killstreak_done");
	if(IsDefined(extraendon))
	{
		self endon(extraendon);
	}

	self waittill(event);
	self notify("give_crate_killstreak_done",removecrate);
}

//Function Number: 10
givecratekillstreak(killstreak)
{
	self maps/mp/killstreaks/_killstreaks::givekillstreak(killstreak);
}

//Function Number: 11
givespecializedcrateweapon(weapon)
{
	switch(weapon)
	{
		case "minigun_mp":
			level thread maps/mp/_popups::displayteammessagetoall(&"KILLSTREAK_MINIGUN_INBOUND",self);
			level maps/mp/gametypes/_weapons::addlimitedweapon(weapon,self,3);
			break;

		case "m32_mp":
			level thread maps/mp/_popups::displayteammessagetoall(&"KILLSTREAK_M32_INBOUND",self);
			level maps/mp/gametypes/_weapons::addlimitedweapon(weapon,self,3);
			break;

		case "m202_flash_mp":
			level thread maps/mp/_popups::displayteammessagetoall(&"KILLSTREAK_M202_FLASH_INBOUND",self);
			level maps/mp/gametypes/_weapons::addlimitedweapon(weapon,self,3);
			break;

		case "m220_tow_mp":
			level thread maps/mp/_popups::displayteammessagetoall(&"KILLSTREAK_M220_TOW_INBOUND",self);
			level maps/mp/gametypes/_weapons::addlimitedweapon(weapon,self,3);
			break;

		case "mp40_blinged_mp":
			level thread maps/mp/_popups::displayteammessagetoall(&"KILLSTREAK_MP40_INBOUND",self);
			level maps/mp/gametypes/_weapons::addlimitedweapon(weapon,self,3);
			break;

		default:
			break;
	}
}

//Function Number: 12
givecrateweapon(weapon)
{
	currentweapon = self getcurrentweapon();
	if(currentweapon == weapon || self hasweapon(weapon))
	{
		self givemaxammo(weapon);
		return 1;
	}

	if(issupplydropweapon(currentweapon) || IsDefined(level.grenade_array[currentweapon]) || IsDefined(level.inventory_array[currentweapon]))
	{
		self takeweapon(self.lastdroppableweapon);
		self giveweapon(weapon);
		self switchtoweapon(weapon);
		return 1;
	}

	self addweaponstat(weapon,"used",1);
	givespecializedcrateweapon(weapon);
	self giveweapon(weapon);
	self switchtoweapon(weapon);
	self waittill("weapon_change",newweapon);
	self maps/mp/killstreaks/_killstreak_weapons::usekillstreakweaponfromcrate(weapon);
	return 1;
}

//Function Number: 13
givecrateammo(ammo)
{
	weaponslist = self getweaponslist();
	for(idx = 0;idx < weaponslist.size;idx++)
	{
		weapon = weaponslist[idx];
		if(maps/mp/killstreaks/_killstreaks::iskillstreakweapon(weapon))
		{
		}
		else
		{
			switch(weapon)
			{
				case "inventory_supplydrop_mp":
				case "m202_flash_mp":
				case "m220_tow_mp":
				case "m32_mp":
				case "minigun_mp":
				case "mp40_blinged_mp":
				case "supplydrop_mp":
					break;

				case "bouncingbetty_mp":
				case "claymore_mp":
				case "frag_grenade_mp":
				case "hatchet_mp":
				case "satchel_charge_mp":
				case "sticky_grenade_mp":
					stock = self getweaponammostock(weapon);
					maxammo = self.grenadetypeprimarycount;
					maxammo = 0;
					self setweaponammostock(weapon,maxammo);
					break;
	stock < maxammo
	IsDefined(maxammo)
					break;

				case "concussion_grenade_mp":
				case "emp_grenade_mp":
				case "flash_grenade_mp":
				case "nightingale_mp":
				case "proximity_grenade_mp":
				case "tabun_gas_mp":
				case "willy_pete_mp":
					stock = self getweaponammostock(weapon);
					maxammo = self.tacticalgrenadecount;
					maxammo = 0;
					self setweaponammostock(weapon,maxammo);
					break;
	stock < maxammo
	IsDefined(maxammo)
					break;

				default:
					self givemaxammo(weapon);
					break;
			}
		}
	}
}

//Function Number: 14
waitforgrenadefire()
{
	self endon("weapon_change");
	self waittill("grenade_fire");
	return "grenade_fire";
}

//Function Number: 15
usesupplydropmarker(package_contents_id)
{
	self endon("disconnect");
	self endon("spawned_player");
	self thread supplydropwatcher(package_contents_id);
	self.supplygrenadedeathdrop = 0;
	supplydropweapon = undefined;
	currentweapon = self getcurrentweapon();
	prevweapon = currentweapon;
	if(issupplydropweapon(currentweapon))
	{
		supplydropweapon = currentweapon;
	}

	notifystring = self waitforgrenadefire();
	if(!IsDefined(notifystring) || notifystring != "grenade_fire")
	{
		return 0;
	}

	if(!(IsDefined(supplydropweapon)))
	{
		return 0;
	}

	if(IsDefined(self))
	{
		notifystring = self waittill_any_return("weapon_change","death");
		self takeweapon(supplydropweapon);
		if(self hasweapon(supplydropweapon) || self getammocount(supplydropweapon))
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 16
issupplydropgrenadeallowed(hardpointtype,killstreakweapon)
{
	if(!(IsDefined(killstreakweapon)))
	{
		killstreakweapon = hardpointtype;
	}

	if(self maps/mp/killstreaks/_killstreakrules::iskillstreakallowed(hardpointtype,self.team) == 0)
	{
		self switchtoweapon(self getlastweapon());
		return 0;
	}

	return 1;
}

//Function Number: 17
usekillstreaksupplydrop(hardpointtype)
{
	if(self issupplydropgrenadeallowed(hardpointtype,"supplydrop_mp") == 0)
	{
		return 0;
	}

	result = self usesupplydropmarker();
	self notify("supply_drop_marker_done");
	if(!IsDefined(result) || !result)
	{
		return 0;
	}

	return result;
}

//Function Number: 18
use_killstreak_death_machine(hardpointtype)
{
	if(self maps/mp/killstreaks/_killstreakrules::iskillstreakallowed(hardpointtype,self.team) == 0)
	{
		return 0;
	}

	weapon = "minigun_mp";
	currentweapon = self getcurrentweapon();
	if(issupplydropweapon(currentweapon) || IsDefined(level.grenade_array[currentweapon]) || IsDefined(level.inventory_array[currentweapon]))
	{
		self takeweapon(self.lastdroppableweapon);
		self giveweapon(weapon);
		self switchtoweapon(weapon);
		self setblockweaponpickup(weapon,1);
		return 1;
	}

	level thread maps/mp/_popups::displayteammessagetoall(&"KILLSTREAK_MINIGUN_INBOUND",self);
	level maps/mp/gametypes/_weapons::addlimitedweapon(weapon,self,3);
	self takeweapon(currentweapon);
	self giveweapon(weapon);
	self switchtoweapon(weapon);
	self setblockweaponpickup(weapon,1);
	return 1;
}

//Function Number: 19
use_killstreak_grim_reaper(hardpointtype)
{
	if(self maps/mp/killstreaks/_killstreakrules::iskillstreakallowed(hardpointtype,self.team) == 0)
	{
		return 0;
	}

	weapon = "m202_flash_mp";
	currentweapon = self getcurrentweapon();
	if(issupplydropweapon(currentweapon) || IsDefined(level.grenade_array[currentweapon]) || IsDefined(level.inventory_array[currentweapon]))
	{
		self takeweapon(self.lastdroppableweapon);
		self giveweapon(weapon);
		self switchtoweapon(weapon);
		self setblockweaponpickup(weapon,1);
		return 1;
	}

	level thread maps/mp/_popups::displayteammessagetoall(&"KILLSTREAK_M202_FLASH_INBOUND",self);
	level maps/mp/gametypes/_weapons::addlimitedweapon(weapon,self,3);
	self takeweapon(currentweapon);
	self giveweapon(weapon);
	self switchtoweapon(weapon);
	self setblockweaponpickup(weapon,1);
	return 1;
}

//Function Number: 20
use_killstreak_tv_guided_missile(hardpointtype)
{
	if(maps/mp/killstreaks/_killstreakrules::iskillstreakallowed(hardpointtype,self.team) == 0)
	{
		self iprintlnbold(level.killstreaks[hardpointtype].notavailabletext);
		return 0;
	}

	weapon = "m220_tow_mp";
	currentweapon = self getcurrentweapon();
	if(issupplydropweapon(currentweapon) || IsDefined(level.grenade_array[currentweapon]) || IsDefined(level.inventory_array[currentweapon]))
	{
		self takeweapon(self.lastdroppableweapon);
		self giveweapon(weapon);
		self switchtoweapon(weapon);
		self setblockweaponpickup(weapon,1);
		return 1;
	}

	level thread maps/mp/_popups::displayteammessagetoall(&"KILLSTREAK_M220_TOW_INBOUND",self);
	level maps/mp/gametypes/_weapons::addlimitedweapon(weapon,self,3);
	self takeweapon(currentweapon);
	self giveweapon(weapon);
	self switchtoweapon(weapon);
	self setblockweaponpickup(weapon,1);
	return 1;
}

//Function Number: 21
use_killstreak_mp40(hardpointtype)
{
	if(maps/mp/killstreaks/_killstreakrules::iskillstreakallowed(hardpointtype,self.team) == 0)
	{
		self iprintlnbold(level.killstreaks[hardpointtype].notavailabletext);
		return 0;
	}

	weapon = "mp40_blinged_mp";
	currentweapon = self getcurrentweapon();
	if(issupplydropweapon(currentweapon) || IsDefined(level.grenade_array[currentweapon]) || IsDefined(level.inventory_array[currentweapon]))
	{
		self takeweapon(self.lastdroppableweapon);
		self giveweapon(weapon);
		self switchtoweapon(weapon);
		self setblockweaponpickup(weapon,1);
		return 1;
	}

	level thread maps/mp/_popups::displayteammessagetoall(&"KILLSTREAK_MP40_INBOUND",self);
	level maps/mp/gametypes/_weapons::addlimitedweapon(weapon,self,3);
	self takeweapon(currentweapon);
	self giveweapon(weapon);
	self switchtoweapon(weapon);
	self setblockweaponpickup(weapon,1);
	return 1;
}

//Function Number: 22
cleanupwatcherondeath(team,killstreak_id)
{
	self endon("disconnect");
	self endon("supplyDropWatcher");
	self endon("grenade_fire");
	self endon("spawned_player");
	self endon("weapon_change");
	self waittill("death");
	maps/mp/killstreaks/_killstreakrules::killstreakstop("supply_drop_mp",team,killstreak_id);
}

//Function Number: 23
supplydropwatcher(package_contents_id)
{
	self notify("supplyDropWatcher");
	self endon("supplyDropWatcher");
	self endon("spawned_player");
	self endon("disconnect");
	self endon("weapon_change");
	team = self.team;
	killstreak_id = maps/mp/killstreaks/_killstreakrules::killstreakstart("supply_drop_mp",team,0,0);
	if(killstreak_id == -1)
	{
		return;
	}

	self thread checkforemp();
	self thread checkweaponchange(team,killstreak_id);
	self thread cleanupwatcherondeath(team,killstreak_id);
	self waittill("grenade_fire",weapon,weapname);
	if(IsDefined(self) && issupplydropweapon(weapname))
	{
		self thread dosupplydrop(weapon,weapname,self,killstreak_id,package_contents_id);
		weapon thread do_supply_drop_detonation(weapname,self);
		weapon thread supplydropgrenadetimeout(team,killstreak_id,weapname);
		self maps/mp/killstreaks/_killstreaks::switchtolastnonkillstreakweapon();
	}
	else
	{
		maps/mp/killstreaks/_killstreakrules::killstreakstop("supply_drop_mp",team,killstreak_id);
	}
}

//Function Number: 24
checkforemp()
{
	self endon("supplyDropWatcher");
	self endon("spawned_player");
	self endon("disconnect");
	self endon("weapon_change");
	self endon("death");
	self endon("grenade_fire");
	self waittill("emp_jammed");
	self maps/mp/killstreaks/_killstreaks::switchtolastnonkillstreakweapon();
}

//Function Number: 25
supplydropgrenadetimeout(team,killstreak_id,weapname)
{
	self endon("death");
	self endon("stationary");
	grenade_lifetime = 10;
	wait(grenade_lifetime);
	if(!(IsDefined(self)))
	{
		return;
	}

	self notify("grenade_timeout");
	maps/mp/killstreaks/_killstreakrules::killstreakstop("supply_drop_mp",team,killstreak_id);
	if(weapname == "ai_tank_drop_mp")
	{
		maps/mp/killstreaks/_killstreakrules::killstreakstop("ai_tank_drop_mp",team,killstreak_id);
	}
	else if(weapname == "inventory_ai_tank_drop_mp")
	{
		maps/mp/killstreaks/_killstreakrules::killstreakstop("inventory_ai_tank_drop_mp",team,killstreak_id);
	}

	self delete();
}

//Function Number: 26
checkweaponchange(team,killstreak_id)
{
	self endon("supplyDropWatcher");
	self endon("spawned_player");
	self endon("disconnect");
	self endon("grenade_fire");
	self endon("death");
	self waittill("weapon_change");
	maps/mp/killstreaks/_killstreakrules::killstreakstop("supply_drop_mp",team,killstreak_id);
}

//Function Number: 27
supplydropgrenadepullwatcher(killstreak_id)
{
	self endon("disconnect");
	self endon("weapon_change");
	self waittill("grenade_pullback",weapon);
	self _disableusability();
	self thread watchforgrenadeputdown();
	self waittill("death");
	killstreak = "supply_drop_mp";
	self.supplygrenadedeathdrop = 1;
	if(issupplydropweapon(weapon))
	{
		killstreak = maps/mp/killstreaks/_killstreaks::getkillstreakforweapon(weapon);
	}

	if(!IsDefined(self.usingkillstreakfrominventory) || self.usingkillstreakfrominventory == 0)
	{
		self changekillstreakquantity(weapon,-1);
	}
	else
	{
		maps/mp/killstreaks/_killstreaks::removeusedkillstreak(killstreak,killstreak_id);
	}
}

//Function Number: 28
watchforgrenadeputdown()
{
	self notify("watchForGrenadePutDown");
	self endon("watchForGrenadePutDown");
	self endon("death");
	self endon("disconnect");
	self waittill_any("grenade_fire","weapon_change");
	self _enableusability();
}

//Function Number: 29
abortsupplydropmarkerwaiter(waittillstring)
{
	self endon("supply_drop_marker_done");
	self waittill(waittillstring);
	self notify("supply_drop_marker_done");
}

//Function Number: 30
playerchangeweaponwaiter()
{
	self endon("supply_drop_marker_done");
	self endon("disconnect");
	self endon("spawned_player");
	currentweapon = self getcurrentweapon();
	while(issupplydropweapon(currentweapon))
	{
		self waittill("weapon_change",currentweapon);
	}

	waittillframeend;
	self notify("supply_drop_marker_done");
}

//Function Number: 31
issupplydropweapon(weapon)
{
	if(weapon == "supplystation_mp" || weapon == "supplydrop_mp" || weapon == "inventory_supplydrop_mp" || weapon == "turret_drop_mp" || weapon == "ai_tank_drop_mp" || weapon == "inventory_ai_tank_drop_mp" || weapon == "minigun_drop_mp" || weapon == "inventory_minigun_drop_mp" || weapon == "m32_drop_mp" || weapon == "inventory_m32_drop_mp" || weapon == "tow_turret_drop_mp" || weapon == "m220_tow_drop_mp")
	{
		return 1;
	}

	return 0;
}

//Function Number: 32
geticonforcrate()
{
	icon = undefined;
	switch(self.cratetype.type)
	{
		case "killstreak":
			icon = "hud_ks_ai_tank";
			continue;
			killstreak = maps/mp/killstreaks/_killstreaks::getkillstreakmenuname(self.cratetype.name);
			icon = level.killstreakicons[killstreak];
			continue;
	self.cratetype.name == "inventory_ai_tank_drop_mp"
			break;

		case "weapon":
			switch(self.cratetype.name)
			{
				case "minigun_mp":
					icon = "hud_ks_minigun";
					break;
	
				case "m32_mp":
					icon = "hud_ks_m32";
					break;
	
				case "m202_flash_mp":
					icon = "hud_ks_m202";
					break;
	
				case "m220_tow_mp":
					icon = "hud_ks_tv_guided_missile";
					break;
	
				case "mp40_drop_mp":
					icon = "hud_mp40";
					break;
	
				default:
					icon = "waypoint_recon_artillery_strike";
					break;
			}
			break;

		case "ammo":
			icon = "hud_ammo_refill";
			break;

		default:
			return undefined;
	}

	return icon + "_drop";
}

//Function Number: 33
crateactivate(hacker)
{
	self makeusable();
	self setcursorhint("HINT_NOICON");
	self sethintstring(self.cratetype.hint);
	if(IsDefined(self.cratetype.hint_gambler))
	{
		self sethintstringforperk("specialty_showenemyequipment",self.cratetype.hint_gambler);
	}

	crateobjid = maps/mp/gametypes/_gameobjects::getnextobjid();
	objective_add(crateobjid,"invisible",self.origin);
	objective_icon(crateobjid,"compass_supply_drop_green");
	objective_state(crateobjid,"active");
	self.friendlyobjid = crateobjid;
	self.enemyobjid = [];
	icon = self geticonforcrate();
	if(IsDefined(hacker))
	{
		self thread attachreconmodel(level.cratemodelhacker,hacker);
	}

	if(level.teambased)
	{
		objective_team(crateobjid,self.team);
		foreach(team in level.teams)
		{
			if(self.team == team)
			{
			}
			else
			{
				crateobjid = maps/mp/gametypes/_gameobjects::getnextobjid();
				objective_add(crateobjid,"invisible",self.origin);
				if(IsDefined(self.hacker))
				{
					objective_icon(crateobjid,"compass_supply_drop_black");
				}
				else
				{
					objective_icon(crateobjid,"compass_supply_drop_red");
				}

				objective_team(crateobjid,team);
				objective_state(crateobjid,"active");
				self.enemyobjid[self.enemyobjid.size] = crateobjid;
			}
		}
	}
	else
	{
		if(!(self.visibletoall))
		{
			objective_setinvisibletoall(crateobjid);
			enemycrateobjid = maps/mp/gametypes/_gameobjects::getnextobjid();
			objective_add(enemycrateobjid,"invisible",self.origin);
			objective_icon(enemycrateobjid,"compass_supply_drop_red");
			objective_state(enemycrateobjid,"active");
			if(isplayer(self.owner))
			{
				objective_setinvisibletoplayer(enemycrateobjid,self.owner);
			}

			self.enemyobjid[self.enemyobjid.size] = enemycrateobjid;
		}

		if(isplayer(self.owner))
		{
			objective_setvisibletoplayer(crateobjid,self.owner);
		}

		if(IsDefined(self.hacker))
		{
			objective_setinvisibletoplayer(crateobjid,self.hacker);
			crateobjid = maps/mp/gametypes/_gameobjects::getnextobjid();
			objective_add(crateobjid,"invisible",self.origin);
			objective_icon(crateobjid,"compass_supply_drop_black");
			objective_state(crateobjid,"active");
			objective_setinvisibletoall(crateobjid);
			objective_setvisibletoplayer(crateobjid,self.hacker);
			self.hackerobjid = crateobjid;
		}
	}

	if(!self.visibletoall && IsDefined(icon))
	{
		self thread maps/mp/_entityheadicons::setentityheadicon(self.team,self,level.crate_headicon_offset,icon,1);
	}

	if(IsDefined(self.owner) && isplayer(self.owner) && self.owner is_bot())
	{
		self.owner notify("bot_crate_landed",self,_k1089);
	}

	if(IsDefined(self.owner))
	{
		self.owner notify("crate_landed",self);
	}
}

//Function Number: 34
cratedeactivate()
{
	self makeunusable();
	if(IsDefined(self.friendlyobjid))
	{
		objective_delete(self.friendlyobjid);
		maps/mp/gametypes/_gameobjects::releaseobjid(self.friendlyobjid);
		self.friendlyobjid = undefined;
	}

	if(IsDefined(self.enemyobjid))
	{
		foreach(objid in self.enemyobjid)
		{
			objective_delete(objid);
			maps/mp/gametypes/_gameobjects::releaseobjid(objid);
		}

		self.enemyobjid = [];
	}

	if(IsDefined(self.hackerobjid))
	{
		objective_delete(self.hackerobjid);
		maps/mp/gametypes/_gameobjects::releaseobjid(self.hackerobjid);
		self.hackerobjid = undefined;
	}
}

//Function Number: 35
ownerteamchangewatcher()
{
	self endon("death");
	if(!level.teambased || !IsDefined(self.owner))
	{
		return;
	}

	self.owner waittill("joined_team");
	self.owner = undefined;
}

//Function Number: 36
dropalltoground(origin,radius,stickyobjectradius)
{
	physicsexplosionsphere(origin,radius,radius,0);
	wait(0.05);
	maps/mp/gametypes/_weapons::dropweaponstoground(origin,radius);
	maps/mp/killstreaks/_supplydrop::dropcratestoground(origin,radius);
	level notify("drop_objects_to_ground",origin,stickyobjectradius);
}

//Function Number: 37
dropeverythingtouchingcrate(origin)
{
	dropalltoground(origin,70,70);
}

//Function Number: 38
dropalltogroundaftercratedelete(crate,crate_origin)
{
	crate waittill("death");
	wait(0.1);
	crate dropeverythingtouchingcrate(crate_origin);
}

//Function Number: 39
dropcratestoground(origin,radius)
{
	crate_ents = getentarray("care_package","script_noteworthy");
	radius_sq = radius * radius;
	for(i = 0;i < crate_ents.size;i++)
	{
		if(distancesquared(origin,crate_ents[i].origin) < radius_sq)
		{
			crate_ents[i] thread dropcratetoground();
		}
	}
}

//Function Number: 40
dropcratetoground()
{
	self endon("death");
	if(IsDefined(self.droppingtoground))
	{
		return;
	}

	self.droppingtoground = 1;
	dropeverythingtouchingcrate(self.origin);
	self cratedeactivate();
	self thread cratedroptogroundkill();
	self crateredophysics();
	self crateactivate();
	self.droppingtoground = undefined;
}

//Function Number: 41
cratespawn(category,owner,team,drop_origin,drop_angle)
{
	crate = spawn("script_model",drop_origin,1);
	crate.angles = drop_angle;
	crate.team = team;
	crate.visibletoall = 0;
	crate setteam(team);
	if(isplayer(owner))
	{
		crate setowner(owner);
	}

	crate.script_noteworthy = "care_package";
	if(!level.teambased || IsDefined(owner) && owner.team == team)
	{
		crate.owner = owner;
	}

	crate thread ownerteamchangewatcher();
	if(category == "ai_tank_drop_mp" || category == "inventory_ai_tank_drop_mp")
	{
		crate setmodel(level.cratemodeltank);
		crate setenemymodel(level.cratemodeltank);
	}
	else
	{
		crate setmodel(level.cratemodelfriendly);
		crate setenemymodel(level.cratemodelenemy);
	}

	switch(category)
	{
		case "turret_drop_mp":
			crate.cratetype = level.cratetypes[category]["autoturret_mp"];
			break;

		case "tow_turret_drop_mp":
			crate.cratetype = level.cratetypes[category]["auto_tow_mp"];
			break;

		case "m220_tow_drop_mp":
			crate.cratetype = level.cratetypes[category]["m220_tow_mp"];
			break;

		case "ai_tank_drop_mp":
		case "inventory_ai_tank_drop_mp":
			crate.cratetype = level.cratetypes[category]["ai_tank_mp"];
			break;

		case "inventory_minigun_drop_mp":
		case "minigun_drop_mp":
			crate.cratetype = level.cratetypes[category]["minigun_mp"];
			break;

		case "inventory_m32_drop_mp":
		case "m32_drop_mp":
			crate.cratetype = level.cratetypes[category]["m32_mp"];
			break;

		default:
			crate.cratetype = getrandomcratetype(category);
			break;
	}

	return crate;
}

//Function Number: 42
cratedelete(drop_all_to_ground)
{
	if(!(IsDefined(drop_all_to_ground)))
	{
		drop_all_to_ground = 1;
	}

	if(IsDefined(self.friendlyobjid))
	{
		objective_delete(self.friendlyobjid);
		maps/mp/gametypes/_gameobjects::releaseobjid(self.friendlyobjid);
		self.friendlyobjid = undefined;
	}

	if(IsDefined(self.enemyobjid))
	{
		foreach(objid in self.enemyobjid)
		{
			objective_delete(objid);
			maps/mp/gametypes/_gameobjects::releaseobjid(objid);
		}

		self.enemyobjid = undefined;
	}

	if(IsDefined(self.hackerobjid))
	{
		objective_delete(self.hackerobjid);
		maps/mp/gametypes/_gameobjects::releaseobjid(self.hackerobjid);
		self.hackerobjid = undefined;
	}

	if(drop_all_to_ground)
	{
		level thread dropalltogroundaftercratedelete(self,self.origin);
	}

	if(IsDefined(self.killcament))
	{
		self.killcament thread deleteaftertime(5);
	}

	self delete();
}

//Function Number: 43
timeoutcratewaiter()
{
	self endon("death");
	self endon("stationary");
	wait(20);
	self cratedelete();
}

//Function Number: 44
cratephysics()
{
	forcepointvariance = 200;
	vertvelocitymin = -100;
	vertvelocitymax = 100;
	forcepointx = randomfloatrange(0 - forcepointvariance,forcepointvariance);
	forcepointy = randomfloatrange(0 - forcepointvariance,forcepointvariance);
	forcepoint = (forcepointx,forcepointy,0);
	forcepoint = forcepoint + self.origin;
	initialvelocityz = randomfloatrange(vertvelocitymin,vertvelocitymax);
	initialvelocity = (0,0,initialvelocityz);
	self physicslaunch(forcepoint,initialvelocity);
	self thread timeoutcratewaiter();
	self thread update_crate_velocity();
	self thread play_impact_sound();
	self waittill("stationary");
}

//Function Number: 45
play_impact_sound()
{
	self endon("entityshutdown");
	self endon("stationary");
	self endon("death");
	wait(0.5);
	while(Abs(self.velocity[2]) > 5)
	{
		wait(0.1);
	}

	self playsound("phy_impact_supply");
}

//Function Number: 46
update_crate_velocity()
{
	self endon("entityshutdown");
	self endon("stationary");
	self.velocity = (0,0,0);
	self.old_origin = self.origin;
	while(IsDefined(self))
	{
		self.velocity = self.origin - self.old_origin;
		self.old_origin = self.origin;
		wait(0.05);
	}
}

//Function Number: 47
crateredophysics()
{
	forcepoint = self.origin;
	initialvelocity = (0,0,0);
	self physicslaunch(forcepoint,initialvelocity);
	self thread timeoutcratewaiter();
	self waittill("stationary");
}

//Function Number: 48
do_supply_drop_detonation(weapname,owner)
{
	self notify("supplyDropWatcher");
	self endon("supplyDropWatcher");
	self endon("spawned_player");
	self endon("disconnect");
	self endon("death");
	self endon("grenade_timeout");
	self waittillnotmoving();
	self.angles = (0,self.angles[1],90);
	fuse_time = getweaponfusetime(weapname) / 1000;
	wait(fuse_time);
	if(!IsDefined(owner) || owner maps/mp/killstreaks/_emp::isenemyempkillstreakactive() == 0)
	{
		thread playsmokesound(self.origin,6,level.sound_smoke_start,level.sound_smoke_stop,level.sound_smoke_loop);
		playfxontag(level._supply_drop_smoke_fx,self,"tag_fx");
		proj_explosion_sound = getweaponprojexplosionsound(weapname);
		play_sound_in_space(proj_explosion_sound,self.origin);
	}

	wait(3);
	self delete();
}

//Function Number: 49
dosupplydrop(weapon,weaponname,owner,killstreak_id,package_contents_id)
{
	weapon endon("explode");
	weapon endon("grenade_timeout");
	self endon("disconnect");
	team = owner.team;
	weapon thread watchexplode(weaponname,owner,killstreak_id,package_contents_id);
	weapon waittillnotmoving();
	weapon notify("stoppedMoving");
	self thread helidelivercrate(weapon.origin,weaponname,owner,team,killstreak_id,package_contents_id);
}

//Function Number: 50
watchexplode(weaponname,owner,killstreak_id,package_contents_id)
{
	self endon("stoppedMoving");
	team = owner.team;
	self waittill("explode",position);
	owner thread helidelivercrate(position,weaponname,owner,team,killstreak_id,package_contents_id);
}

//Function Number: 51
cratetimeoutthreader()
{
/#
	if(getdvarintdefault("scr_crate_notimeout",0))
	{
		return;
	}
#/
	self thread cratetimeout(90);
}

//Function Number: 52
dropcrate(origin,angle,category,owner,team,killcament,killstreak_id,package_contents_id,crate)
{
	angle = (angle[0] * 0.5,angle[1] * 0.5,angle[2] * 0.5);
	if(IsDefined(crate))
	{
		origin = crate.origin;
		angle = crate.angles;
		crate delete();
	}

	crate = cratespawn(category,owner,team,origin,angle);
	killcament unlink();
	killcament linkto(crate);
	crate.killcament = killcament;
	crate.killstreak_id = killstreak_id;
	crate.package_contents_id = package_contents_id;
	killcament thread deleteaftertime(15);
	killcament thread unlinkonrotation(crate);
	crate endon("death");
	crate thread cratekill();
	crate cratephysics();
	crate cratetimeoutthreader();
	crate thread maps/mp/_hacker_tool::registerwithhackertool(level.carepackagehackertoolradius,level.carepackagehackertooltimems);
	if(IsDefined(crate.cratetype.landfunctionoverride))
	{
		[[ crate.cratetype.landfunctionoverride ]](crate,category,owner,team);
	}
	else
	{
		crate crateactivate();
		crate thread crateusethink();
		crate thread crateusethinkowner();
		if(IsDefined(crate.cratetype.hint_gambler))
		{
			crate thread crategamblerthink();
		}

		default_land_function(crate,category,owner,team);
	}
}

//Function Number: 53
unlinkonrotation(crate)
{
	self endon("delete");
	crate endon("entityshutdown");
	crate endon("stationary");
	waitbeforerotationcheck = getdvarfloatdefault("scr_supplydrop_killcam_rot_wait",0.5);
	wait(waitbeforerotationcheck);
	mincos = getdvarintdefault("scr_supplydrop_killcam_max_rot",0.999);
	cosine = 1;
	currentdirection = vectornormalize(AnglesToForward(crate.angles));
	while(cosine > mincos)
	{
		olddirection = currentdirection;
		wait(0.05);
		currentdirection = vectornormalize(AnglesToForward(crate.angles));
		cosine = vectordot(olddirection,currentdirection);
	}

	self unlink();
}

//Function Number: 54
default_land_function(crate,weaponname,owner,team)
{
	while(1)
	{
		crate waittill("captured",player,remote_hack);
		player maps/mp/_challenges::capturedcrate();
		deletecrate = player givecrateitem(crate);
		if(IsDefined(deletecrate) && !deletecrate)
		{
			continue;
		}

		if((player hasperk("specialty_showenemyequipment") || remote_hack == 1) && owner != player && (level.teambased && team != player.team) || !level.teambased)
		{
			spawn_explosive_crate(crate.origin,crate.angles,weaponname,owner,team,player);
			crate cratedelete(0);
			continue;
		}

		crate cratedelete();
		return;
	}
}

//Function Number: 55
spawn_explosive_crate(origin,angle,weaponname,owner,team,hacker)
{
	crate = cratespawn(weaponname,owner,team,origin,angle);
	crate setowner(owner);
	crate setteam(team);
	if(level.teambased)
	{
		crate setenemymodel(level.cratemodelboobytrapped);
		crate makeusable(team);
	}
	else
	{
		crate setenemymodel(level.cratemodelenemy);
	}

	crate.hacker = hacker;
	crate.visibletoall = 0;
	crate crateactivate(hacker);
	crate sethintstringforperk("specialty_showenemyequipment",level.supplydropdisarmcrate);
	crate thread crateusethink();
	crate thread crateusethinkowner();
	crate thread watch_explosive_crate();
	crate cratetimeoutthreader();
}

//Function Number: 56
watch_explosive_crate()
{
	killcament = spawn("script_model",60 + VectorScale((0,0,1)));
	self.killcament = killcament;
	self waittill(self.origin,"captured",player,remote_hack);
	if(!player hasperk("specialty_showenemyequipment") && !remote_hack)
	{
		self thread maps/mp/_entityheadicons::setentityheadicon(player.team,player,level.crate_headicon_offset,"headicon_dead",1);
		self loop_sound("wpn_semtex_alert",0.15);
		if(!(IsDefined(self.hacker)))
		{
			self.hacker = self;
		}

		self radiusdamage(self.origin,256,300,75,self.hacker,"MOD_EXPLOSIVE","supplydrop_mp");
		playfx(level._supply_drop_explosion_fx,self.origin);
		playsoundatposition("wpn_grenade_explode",self.origin);
	}
	else
	{
		playsoundatposition("mpl_turret_alert",self.origin);
		maps/mp/_scoreevents::processscoreevent("disarm_hacked_care_package",player);
		player maps/mp/_challenges::disarmedhackedcarepackage();
	}

	wait(0.1);
	self cratedelete();
	killcament thread deleteaftertime(5);
}

//Function Number: 57
loop_sound(alias,interval)
{
	self endon("death");
	while(1)
	{
		playsoundatposition(alias,self.origin);
		wait(interval);
		interval = interval / 1.2;
		if(interval < 0.08)
		{
			break;
		}
	}
}

//Function Number: 58
cratekill()
{
	self endon("death");
	stationarythreshold = 2;
	killthreshold = 15;
	maxframestillstationary = 20;
	numframesstationary = 0;
	while(1)
	{
		vel = 0;
		if(IsDefined(self.velocity))
		{
			vel = Abs(self.velocity[2]);
		}

		if(vel > killthreshold)
		{
			self is_touching_crate();
		}

		if(vel < stationarythreshold)
		{
			numframesstationary++;
		}
		else
		{
			numframesstationary = 0;
		}

		if(numframesstationary >= maxframestillstationary)
		{
			break;
		}

		wait(0.01);
	}
}

//Function Number: 59
cratedroptogroundkill()
{
	self endon("death");
	self endon("stationary");
	for(;;)
	{
		players = get_players();
		dotrace = 0;
		for(i = 0;i < players.size;i++)
		{
			if(players[i].sessionstate != "playing")
			{
			}
			else if(players[i].team == "spectator")
			{
			}
			else
			{
				self is_equipment_touching_crate(players[i]);
				if(!(isalive(players[i])))
				{
				}
				else
				{
					flattenedselforigin = (self.origin[0],self.origin[1],0);
					flattenedplayerorigin = (players[i].origin[0],players[i].origin[1],0);
					if(distancesquared(flattenedselforigin,flattenedplayerorigin) > 4096)
					{
					}
					else
					{
						dotrace = 1;
						break;
					}
				}
			}
		}

		if(dotrace)
		{
			start = self.origin;
			cratedroptogroundtrace(start);
			start = self getpointinbounds(1,0,0);
			cratedroptogroundtrace(start);
			start = self getpointinbounds(-1,0,0);
			cratedroptogroundtrace(start);
			start = self getpointinbounds(0,-1,0);
			cratedroptogroundtrace(start);
			start = self getpointinbounds(0,1,0);
			cratedroptogroundtrace(start);
			start = self getpointinbounds(1,1,0);
			cratedroptogroundtrace(start);
			start = self getpointinbounds(-1,1,0);
			cratedroptogroundtrace(start);
			start = self getpointinbounds(1,-1,0);
			cratedroptogroundtrace(start);
			start = self getpointinbounds(-1,-1,0);
			cratedroptogroundtrace(start);
			wait(0.2);
			continue;
		}

		wait(0.5);
	}
}

//Function Number: 60
cratedroptogroundtrace(start)
{
	end = 8000 + VectorScale((0,0,-1));
	trace = bullettrace(start,end,1,self,1,1);
	if(IsDefined(trace["entity"]) && isplayer(trace["entity"]) && isalive(trace["entity"]))
	{
		player = trace["entity"];
		if(player.sessionstate != "playing")
		{
			return;
		}

		if(player.team == "spectator")
		{
			return;
		}

		if(distancesquared(start,trace["position"]) < 144 || self istouching(player))
		{
			player dodamage(player.health + 1,player.origin,self.owner,self,"none","MOD_HIT_BY_OBJECT",0,"supplydrop_mp");
			player playsound("mpl_supply_crush");
			player playsound("phy_impact_supply");
		}
	}
}

//Function Number: 61
is_touching_crate()
{
	extraboundary = VectorScale((1,1,1));
	players = get_players();
	for(i = 0;i < players.size;i++)
	{
		if(IsDefined(players[i]) && isalive(players[i]) && self istouching(players[i],extraboundary))
		{
			if(IsDefined(self.owner))
			{
			}
			else
			{
			}

			attacker = self;
			players[i] dodamage(players[i].health + 1,players[i].origin,attacker,self,"none","MOD_HIT_BY_OBJECT",0,"supplydrop_mp");
			players[i] playsound("mpl_supply_crush");
			players[i] playsound("phy_impact_supply");
		}

		self is_equipment_touching_crate(players[i]);
	}
}

//Function Number: 62
is_equipment_touching_crate(player)
{
	extraboundary = VectorScale((1,1,1));
	if(IsDefined(player) && IsDefined(player.weaponobjectwatcherarray))
	{
		for(watcher = 0;watcher < player.weaponobjectwatcherarray.size;watcher++)
		{
			objectwatcher = player.weaponobjectwatcherarray[watcher];
			objectarray = objectwatcher.objectarray;
			if(IsDefined(objectarray))
			{
				for(weaponobject = 0;weaponobject < objectarray.size;weaponobject++)
				{
					if(IsDefined(objectarray[weaponobject]) && self istouching(objectarray[weaponobject],extraboundary))
					{
						if(IsDefined(objectwatcher.detonate))
						{
							objectwatcher thread maps/mp/gametypes/_weaponobjects::waitanddetonate(objectarray[weaponobject],0);
						}
						else
						{
							maps/mp/gametypes/_weaponobjects::deleteweaponobject(objectwatcher,objectarray[weaponobject]);
						}
					}
				}
			}
		}
	}

	extraboundary = VectorScale((1,1,1));
	if(IsDefined(player) && IsDefined(player.tacticalinsertion) && self istouching(player.tacticalinsertion,extraboundary))
	{
		player.tacticalinsertion thread maps/mp/_tacticalinsertion::fizzle();
	}
}

//Function Number: 63
cratetimeout(time)
{
	self endon("death");
	wait(time);
	self cratedelete();
}

//Function Number: 64
spawnuseent()
{
	useent = spawn("script_origin",self.origin);
	useent.curprogress = 0;
	useent.inuse = 0;
	useent.userate = 0;
	useent.usetime = 0;
	useent.owner = self;
	useent thread useentownerdeathwaiter(self);
	return useent;
}

//Function Number: 65
useentownerdeathwaiter(owner)
{
	self endon("death");
	owner waittill("death");
	self delete();
}

//Function Number: 66
crateusethink()
{
	while(IsDefined(self))
	{
		self waittill("trigger",player);
		if(!(isalive(player)))
		{
			continue;
		}

		if(!(player isonground()))
		{
			continue;
		}

		if(IsDefined(self.owner) && self.owner == player)
		{
			continue;
		}

		useent = self spawnuseent();
		result = 0;
		if(IsDefined(self.hacker))
		{
			useent.hacker = self.hacker;
		}

		self.useent = useent;
		result = useent useholdthink(player,level.cratenonownerusetime);
		if(IsDefined(useent))
		{
			useent delete();
		}

		if(result)
		{
			givecratecapturemedal(self,player);
			self notify("captured",player,0);
		}
	}
}

//Function Number: 67
givecratecapturemedal(crate,capturer)
{
	if(IsDefined(crate.owner) && isplayer(crate.owner))
	{
		if(level.teambased)
		{
			if(capturer.team != crate.owner.team)
			{
				crate.owner playlocalsound("mpl_crate_enemy_steals");
				if(!(IsDefined(crate.hacker)))
				{
					maps/mp/_scoreevents::processscoreevent("capture_enemy_crate",capturer);
				}
			}
			else if(IsDefined(crate.owner) && capturer != crate.owner)
			{
				crate.owner playlocalsound("mpl_crate_friendly_steals");
				if(!(IsDefined(crate.hacker)))
				{
					level.globalsharepackages++;
					maps/mp/_scoreevents::processscoreevent(crate.cratetype.sharestat,crate.owner);
				}
			}
		}
		else if(capturer != crate.owner)
		{
			crate.owner playlocalsound("mpl_crate_enemy_steals");
			if(!(IsDefined(crate.hacker)))
			{
				maps/mp/_scoreevents::processscoreevent("capture_enemy_crate",capturer);
			}
		}
	}
}

//Function Number: 68
crateusethinkowner()
{
	self endon("joined_team");
	while(IsDefined(self))
	{
		self waittill("trigger",player);
		if(!(isalive(player)))
		{
			continue;
		}

		if(!(player isonground()))
		{
			continue;
		}

		if(!(IsDefined(self.owner)))
		{
			continue;
		}

		if(self.owner != player)
		{
			continue;
		}

		result = self useholdthink(player,level.crateownerusetime);
		if(result)
		{
			self notify("captured",player,0);
		}
	}
}

//Function Number: 69
useholdthink(player,usetime)
{
	player notify("use_hold");
	player freeze_player_controls(1);
	player _disableweapon();
	self.curprogress = 0;
	self.inuse = 1;
	self.userate = 0;
	self.usetime = usetime;
	player thread personalusebar(self);
	result = useholdthinkloop(player);
	if(IsDefined(player))
	{
		player notify("done_using");
	}

	if(IsDefined(player))
	{
		if(isalive(player))
		{
			player _enableweapon();
			player freeze_player_controls(0);
		}
	}

	if(IsDefined(self))
	{
		self.inuse = 0;
	}

	if(IsDefined(result) && result)
	{
		return 1;
	}
}

//Function Number: 70
continueholdthinkloop(player)
{
	if(!(IsDefined(self)))
	{
		return 0;
	}

	if(self.curprogress >= self.usetime)
	{
		return 0;
	}

	if(!(isalive(player)))
	{
		return 0;
	}

	if(player.throwinggrenade)
	{
		return 0;
	}

	if(!(player usebuttonpressed()))
	{
		return 0;
	}

	if(player meleebuttonpressed())
	{
		return 0;
	}

	if(player isinvehicle())
	{
		return 0;
	}

	if(player isweaponviewonlylinked())
	{
		return 0;
	}

	if(player isremotecontrolling())
	{
		return 0;
	}

	return 1;
}

//Function Number: 71
useholdthinkloop(player)
{
	level endon("game_ended");
	self endon("disabled");
	self.owner endon("crate_use_interrupt");
	timedout = 0;
	while(self continueholdthinkloop(player))
	{
		timedout = timedout + 0.05;
		self.curprogress = self.curprogress + 50 * self.userate;
		self.userate = 1;
		if(self.curprogress >= self.usetime)
		{
			self.inuse = 0;
			wait(0.05);
			return isalive(player);
		}

		wait(0.05);
		maps/mp/gametypes/_hostmigration::waittillhostmigrationdone();
	}

	return 0;
}

//Function Number: 72
crategamblerthink()
{
	self endon("death");
	for(;;)
	{
		self waittill("trigger_use_doubletap",player);
		if(!(player hasperk("specialty_showenemyequipment")))
		{
			continue;
		}

		if(IsDefined(self.useent) && self.useent.inuse)
		{
			if(IsDefined(self.owner) && self.owner != player)
			{
				continue;
			}
		}

		player playlocalsound("uin_gamble_perk");
		self.cratetype = getrandomcratetype("gambler_mp",self.cratetype.name);
		self cratereactivate();
		self sethintstringforperk("specialty_showenemyequipment",self.cratetype.hint);
		self notify("crate_use_interrupt");
		level notify("use_interrupt",self);
		return;
	}
}

//Function Number: 73
cratereactivate()
{
	self sethintstring(self.cratetype.hint);
	icon = self geticonforcrate();
	self thread maps/mp/_entityheadicons::setentityheadicon(self.team,self,level.crate_headicon_offset,icon,1);
}

//Function Number: 74
personalusebar(object)
{
	self endon("disconnect");
	if(IsDefined(self.usebar))
	{
		return;
	}

	self.usebar = createsecondaryprogressbar();
	self.usebartext = createsecondaryprogressbartext();
	if(self hasperk("specialty_showenemyequipment") && object.owner != self && !IsDefined(object.hacker) && (level.teambased && object.owner.team != self.team) || !level.teambased)
	{
		self.usebartext settext(&"KILLSTREAK_HACKING_CRATE");
		self playlocalsound("evt_hacker_hacking");
	}
	else if(self hasperk("specialty_showenemyequipment") && IsDefined(object.hacker) && object.owner == self || level.teambased && object.owner.team == self.team)
	{
		self.usebartext settext(level.disarmingcrate);
		self playlocalsound("evt_hacker_hacking");
	}
	else
	{
		self.usebartext settext(&"KILLSTREAK_CAPTURING_CRATE");
	}

	lastrate = -1;
	while(isalive(self) && IsDefined(object) && object.inuse && !level.gameended)
	{
		if(lastrate != object.userate)
		{
			if(object.curprogress > object.usetime)
			{
				object.curprogress = object.usetime;
			}

			self.usebar updatebar(object.curprogress / object.usetime,1000 / object.usetime * object.userate);
			if(!(object.userate))
			{
				self.usebar hideelem();
				self.usebartext hideelem();
			}
			else
			{
				self.usebar showelem();
				self.usebartext showelem();
			}
		}

		lastrate = object.userate;
		wait(0.05);
	}

	self.usebar destroyelem();
	self.usebartext destroyelem();
}

//Function Number: 75
spawn_helicopter(owner,team,origin,angles,model,targetname,killstreak_id)
{
	chopper = spawnhelicopter(owner,origin,angles,model,targetname);
	if(!(IsDefined(chopper)))
	{
		if(isplayer(owner))
		{
			maps/mp/killstreaks/_killstreakrules::killstreakstop("supply_drop_mp",team,killstreak_id);
		}

		return undefined;
	}

	chopper.owner = owner;
	chopper.maxhealth = 1500;
	chopper.health = 999999;
	chopper.rocketdamageoneshot = chopper.maxhealth + 1;
	chopper.damagetaken = 0;
	chopper thread maps/mp/killstreaks/_helicopter::heli_damage_monitor("supply_drop_mp");
	chopper.spawntime = GetTime();
	supplydropspeed = getdvarintdefault("scr_supplydropSpeedStarting",125);
	supplydropaccel = getdvarintdefault("scr_supplydropAccelStarting",100);
	chopper setspeed(supplydropspeed,supplydropaccel);
	maxpitch = getdvarintdefault("scr_supplydropMaxPitch",25);
	maxroll = getdvarintdefault("scr_supplydropMaxRoll",45);
	chopper setmaxpitchroll(0,maxroll);
	chopper.team = team;
	chopper setdrawinfrared(1);
	target_set(chopper,VectorScale((0,0,-1)));
	if(isplayer(owner))
	{
		chopper thread refcountdecchopper(team,killstreak_id);
	}

	chopper thread helidestroyed();
	return chopper;
}

//Function Number: 76
getdropheight(origin)
{
	return getminimumflyheight();
}

//Function Number: 77
getdropdirection()
{
	return (0,randomint(360),0);
}

//Function Number: 78
getnextdropdirection(drop_direction,degrees)
{
	drop_direction = (0,drop_direction[1] + degrees,0);
	if(drop_direction[1] >= 360)
	{
		drop_direction = (0,drop_direction[1] - 360,0);
	}

	return drop_direction;
}

//Function Number: 79
gethelistart(drop_origin,drop_direction)
{
	dist = -1 * getdvarintdefault("scr_supplydropIncomingDistance",10000);
	pathrandomness = 100;
	direction = drop_direction + (0,randomintrange(-2,3),0);
	start_origin = drop_origin + AnglesToForward(direction) * dist;
	start_origin = start_origin + (randomfloat(2) - 1 * pathrandomness,randomfloat(2) - 1 * pathrandomness,0);
/#
	if(getdvarintdefault("scr_noflyzones_debug",0))
	{
		if(level.noflyzones.size)
		{
			index = randomintrange(0,level.noflyzones.size);
			delta = drop_origin - level.noflyzones[index].origin;
			delta = (delta[0] + randomint(10),delta[1] + randomint(10),0);
			delta = vectornormalize(delta);
			start_origin = drop_origin + delta * dist;
		}
	}
#/
	return start_origin;
}

//Function Number: 80
getheliend(drop_origin,drop_direction)
{
	pathrandomness = 150;
	dist = -1 * getdvarintdefault("scr_supplydropOutgoingDistance",15000);
	if(randomintrange(0,2) == 0)
	{
		turn = randomintrange(60,121);
	}
	else
	{
		turn = -1 * randomintrange(60,121);
	}

	direction = drop_direction + (0,turn,0);
	end_origin = drop_origin + AnglesToForward(direction) * dist;
	end_origin = end_origin + (randomfloat(2) - 1 * pathrandomness,randomfloat(2) - 1 * pathrandomness,0);
	return end_origin;
}

//Function Number: 81
addoffsetontopoint(point,direction,offset)
{
	angles = VectorToAngles((direction[0],direction[1],0));
	offset_world = rotatepoint(offset,angles);
	return point + offset_world;
}

//Function Number: 82
supplydrophelistartpath(goal,goal_offset)
{
	total_tries = 12;
	tries = 0;
	goalpath = spawnstruct();
	drop_direction = getdropdirection();
	while(tries < total_tries)
	{
		goalpath.start = gethelistart(goal,drop_direction);
		goalpath.path = gethelipath(goalpath.start,goal);
		startnoflyzones = insidenoflyzones(goalpath.start,0);
		if(IsDefined(goalpath.path) && startnoflyzones.size == 0)
		{
			if(goalpath.path.size > 1)
			{
				direction = goalpath.path[goalpath.path.size - 1] - goalpath.path[goalpath.path.size - 2];
			}
			else
			{
				direction = goalpath.path[goalpath.path.size - 1] - goalpath.start;
			}

			goalpath.path[goalpath.path.size - 1] = addoffsetontopoint(goalpath.path[goalpath.path.size - 1],direction,goal_offset);
/#
			sphere(goalpath.path[goalpath.path.size - 1],10,(0,0,1),1,1,10,1000);
#/
			return goalpath;
		}

		drop_direction = getnextdropdirection(drop_direction,30);
		tries++;
	}

	drop_direction = getdropdirection();
	goalpath.start = gethelistart(goal,drop_direction);
	direction = goal - goalpath.start;
	goalpath.path = [];
	goalpath.path[0] = addoffsetontopoint(goal,direction,goal_offset);
	return goalpath;
}

//Function Number: 83
supplydropheliendpath(origin,drop_direction)
{
	total_tries = 5;
	tries = 0;
	goalpath = spawnstruct();
	while(tries < total_tries)
	{
		goal = getheliend(origin,drop_direction);
		goalpath.path = gethelipath(origin,goal);
		if(IsDefined(goalpath.path))
		{
			return goalpath;
		}

		tries++;
	}

	leave_nodes = getentarray("heli_leave","targetname");
	foreach(node in leave_nodes)
	{
		goalpath.path = gethelipath(origin,node.origin);
		if(IsDefined(goalpath.path))
		{
			return goalpath;
		}
	}

	goalpath.path = [];
	goalpath.path[0] = getheliend(origin,drop_direction);
	return goalpath;
}

//Function Number: 84
inccratekillstreakusagestat(weaponname)
{
	if(!(IsDefined(weaponname)))
	{
		return;
	}

	if(weaponname == "turret_drop_mp")
	{
		self maps/mp/killstreaks/_killstreaks::playkillstreakstartdialog("turret_drop_mp",self.pers["team"]);
	}
	else if(weaponname == "tow_turret_drop_mp")
	{
		self maps/mp/killstreaks/_killstreaks::playkillstreakstartdialog("tow_turret_drop_mp",self.pers["team"]);
	}
	else if(weaponname == "supplydrop_mp" || weaponname == "inventory_supplydrop_mp")
	{
		self maps/mp/killstreaks/_killstreaks::playkillstreakstartdialog("supply_drop_mp",self.pers["team"]);
		level thread maps/mp/_popups::displaykillstreakteammessagetoall("supply_drop_mp",self);
		self maps/mp/_challenges::calledincarepackage();
		level.globalkillstreakscalled++;
		self addweaponstat("supplydrop_mp","used",1);
	}
	else if(weaponname == "ai_tank_drop_mp" || weaponname == "inventory_ai_tank_drop_mp")
	{
		self maps/mp/killstreaks/_killstreaks::playkillstreakstartdialog("ai_tank_drop_mp",self.pers["team"]);
		level thread maps/mp/_popups::displaykillstreakteammessagetoall("ai_tank_drop_mp",self);
		level.globalkillstreakscalled++;
		self addweaponstat("ai_tank_drop_mp","used",1);
	}
	else if(weaponname == "inventory_minigun_drop_mp" || weaponname == "minigun_drop_mp")
	{
		self maps/mp/killstreaks/_killstreaks::playkillstreakstartdialog("minigun_mp",self.pers["team"]);
	}
	else if(weaponname == "m32_drop_mp" || weaponname == "inventory_m32_drop_mp")
	{
		self maps/mp/killstreaks/_killstreaks::playkillstreakstartdialog("m32_mp",self.pers["team"]);
	}
}

//Function Number: 85
helidelivercrate(origin,weaponname,owner,team,killstreak_id,package_contents_id,exact)
{
	if(owner maps/mp/killstreaks/_emp::isenemyempkillstreakactive() && owner hasperk("specialty_immuneemp") == 0)
	{
		maps/mp/killstreaks/_killstreakrules::killstreakstop("supply_drop_mp",team,killstreak_id);
		return;
	}

	inccratekillstreakusagestat(weaponname);
	rear_hatch_offset_local = getdvarintdefault("scr_supplydropOffset",0);
	drop_origin = origin;
	drop_height = getdropheight(drop_origin);
	heli_drop_goal = (drop_origin[0],drop_origin[1],drop_height);
/#
	sphere(heli_drop_goal,10,(0,1,0),1,1,10,1000);
#/
	goalpath = supplydrophelistartpath(heli_drop_goal,(rear_hatch_offset_local,0,0));
	drop_direction = VectorToAngles((heli_drop_goal[0],heli_drop_goal[1],0) - (goalpath.start[0],goalpath.start[1],0));
	chopper = spawn_helicopter(owner,team,goalpath.start,drop_direction,level.suppydrophelicoptervehicleinfo,level.supplydrophelicopterfriendly,killstreak_id);
	chopper setenemymodel(level.supplydrophelicopterenemy);
	chopper setteam(team);
	chopper.numflares = 0;
	if(isplayer(owner))
	{
		chopper setowner(owner);
	}

	killcament = spawn("script_model",800 + VectorScale((0,0,1)));
	killcament.angles = (100,chopper.angles[1],chopper.angles[2]);
	killcament.starttime = GetTime();
	killcament linkto(chopper);
	if(isplayer(owner))
	{
		target_setturretaquire(self,0);
		chopper thread samturretwatcher(drop_origin);
	}

	if(!(IsDefined(chopper)))
	{
		return;
	}

	chopper thread helidropcrate(weaponname,owner,rear_hatch_offset_local,killcament,killstreak_id,package_contents_id);
	chopper endon("death",chopper.origin);
	chopper thread followpath(goalpath.path,"drop_goal",1);
	chopper thread speedregulator(heli_drop_goal);
	chopper waittill("drop_goal");
/#
	println("Chopper Incoming Time: " + GetTime() - chopper.spawntime);
#/
	wait(1.2);
	chopper notify("drop_crate",chopper.origin,chopper.angles);
	chopper.droptime = GetTime();
	chopper playsound("veh_supply_drop");
	wait(0.7);
	supplydropspeed = getdvarintdefault("scr_supplydropSpeedLeaving",150);
	supplydropaccel = getdvarintdefault("scr_supplydropAccelLeaving",40);
	chopper setspeed(supplydropspeed,supplydropaccel);
	goalpath = supplydropheliendpath(chopper.origin,(0,chopper.angles[1],0));
	chopper followpath(goalpath.path,undefined,0);
/#
	println("Chopper Outgoing Time: " + GetTime() - chopper.droptime);
#/
	chopper notify("leaving");
	chopper delete();
}

//Function Number: 86
samturretwatcher(destination)
{
	self endon("leaving");
	self endon("helicopter_gone");
	self endon("death");
	sam_turret_aquire_dist = 1500;
	while(1)
	{
		if(distance(destination,self.origin) < sam_turret_aquire_dist)
		{
			break;
		}

		if(self.origin[0] > level.spawnmins[0] && self.origin[0] < level.spawnmaxs[0] && self.origin[1] > level.spawnmins[1] && self.origin[1] < level.spawnmaxs[1])
		{
			break;
		}

		wait(0.1);
	}

	target_setturretaquire(self,1);
}

//Function Number: 87
speedregulator(goal)
{
	self endon("drop_goal");
	self endon("death");
	wait(3);
	supplydropspeed = getdvarintdefault("scr_supplydropSpeed",75);
	supplydropaccel = getdvarintdefault("scr_supplydropAccel",40);
	self setyawspeed(100,60,60);
	self setspeed(supplydropspeed,supplydropaccel);
	wait(1);
	maxpitch = getdvarintdefault("scr_supplydropMaxPitch",25);
	maxroll = getdvarintdefault("scr_supplydropMaxRoll",35);
	self setmaxpitchroll(maxpitch,maxroll);
}

//Function Number: 88
helidropcrate(category,owner,offset,killcament,killstreak_id,package_contents_id)
{
	owner endon("disconnect");
	crate = cratespawn(category,owner,self.team,self.origin,self.angles);
	if(category == "inventory_supplydrop_mp" || category == "supplydrop_mp")
	{
		crate linkto(self,"tag_care_package",(0,0,0));
		self setclientfield("supplydrop_care_package_state",1);
	}
	else if(category == "inventory_ai_tank_drop_mp" || category == "ai_tank_drop_mp")
	{
		crate linkto(self,"tag_drop_box",(0,0,0));
		self setclientfield("supplydrop_ai_tank_state",1);
	}

	team = self.team;
	self waittill("drop_crate",origin,angles);
	if(IsDefined(self))
	{
		if(category == "inventory_supplydrop_mp" || category == "supplydrop_mp")
		{
			self setclientfield("supplydrop_care_package_state",0);
		}
		else if(category == "inventory_ai_tank_drop_mp" || category == "ai_tank_drop_mp")
		{
			self setclientfield("supplydrop_ai_tank_state",0);
		}
	}

	rear_hatch_offset_height = getdvarintdefault("scr_supplydropOffsetHeight",200);
	rear_hatch_offset_world = rotatepoint((offset,0,0),angles);
	drop_origin = origin - (0,0,rear_hatch_offset_height) - rear_hatch_offset_world;
	thread dropcrate(drop_origin,angles,category,owner,team,killcament,killstreak_id,package_contents_id,crate);
}

//Function Number: 89
helidestroyed()
{
	self endon("leaving");
	self endon("helicopter_gone");
	self endon("death");
	while(1)
	{
		if(self.damagetaken > self.maxhealth)
		{
			break;
		}

		wait(0.05);
	}

	if(!(IsDefined(self)))
	{
		return;
	}

	self setspeed(25,5);
	self thread lbspin(randomintrange(180,220));
	wait(randomfloatrange(0.5,1.5));
	self notify("drop_crate",self.origin,self.angles);
	lbexplode();
}

//Function Number: 90
lbexplode()
{
	forward = self.origin + (0,0,1) - self.origin;
	playfx(level.chopper_fx["explode"]["death"],self.origin,forward);
	self playsound(level.heli_sound["crash"]);
	self notify("explode");
	self delete();
}

//Function Number: 91
lbspin(speed)
{
	self endon("explode");
	playfxontag(level.chopper_fx["explode"]["large"],self,"tail_rotor_jnt");
	playfxontag(level.chopper_fx["fire"]["trail"]["large"],self,"tail_rotor_jnt");
	self setyawspeed(speed,speed,speed);
	while(IsDefined(self))
	{
		self settargetyaw(self.angles[1] + speed * 0.9);
		wait(1);
	}
}

//Function Number: 92
refcountdecchopper(team,killstreak_id)
{
	self waittill("death");
	maps/mp/killstreaks/_killstreakrules::killstreakstop("supply_drop_mp",team,killstreak_id);
}

//Function Number: 93
attachreconmodel(modelname,owner)
{
	if(!(IsDefined(self)))
	{
		return;
	}

	reconmodel = spawn("script_model",self.origin);
	reconmodel.angles = self.angles;
	reconmodel setmodel(modelname);
	reconmodel.model_name = modelname;
	reconmodel linkto(self);
	reconmodel setcontents(0);
	reconmodel resetreconmodelvisibility(owner);
	reconmodel thread watchreconmodelfordeath(self);
	reconmodel thread resetreconmodelonevent("joined_team",owner);
	reconmodel thread resetreconmodelonevent("player_spawned",owner);
}

//Function Number: 94
resetreconmodelvisibility(owner)
{
	if(!(IsDefined(self)))
	{
		return;
	}

	self setinvisibletoall();
	self setforcenocull();
	if(!(IsDefined(owner)))
	{
		return;
	}

	for(i = 0;i < level.players.size;i++)
	{
		if(!level.players[i] hasperk("specialty_detectexplosive") && !level.players[i] hasperk("specialty_showenemyequipment"))
		{
		}
		else if(level.players[i].team == "spectator")
		{
		}
		else
		{
			isenemy = 1;
			if(level.teambased)
			{
				if(level.players[i].team == owner.team)
				{
					isenemy = 0;
				}
			}
			else if(level.players[i] == owner)
			{
				isenemy = 0;
			}

			if(isenemy)
			{
				self setvisibletoplayer(level.players[i]);
			}
		}
	}
}

//Function Number: 95
watchreconmodelfordeath(parentent)
{
	self endon("death");
	parentent waittill_any("death","captured");
	self delete();
}

//Function Number: 96
resetreconmodelonevent(eventname,owner)
{
	self endon("death");
	for(;;)
	{
		level waittill(eventname,newowner);
		if(IsDefined(newowner))
		{
			owner = newowner;
		}

		self resetreconmodelvisibility(owner);
	}
}

//Function Number: 97
supply_drop_dev_gui()
{
/#
	setdvar("scr_supply_drop_gui","");
	while(1)
	{
		wait(0.5);
		devgui_string = GetDvar(#"38F6C211");
		switch(devgui_string)
		{
			case "ammo":
				level.dev_gui_supply_drop = "ammo";
				break;

			case "spyplane":
				level.dev_gui_supply_drop = "radar_mp";
				break;

			case "counter_u2":
				level.dev_gui_supply_drop = "counteruav_mp";
				break;

			case "airstrike":
				level.dev_gui_supply_drop = "airstrike_mp";
				break;

			case "artillery":
				level.dev_gui_supply_drop = "artillery_mp";
				break;

			case "autoturret":
				level.dev_gui_supply_drop = "autoturret_mp";
				break;

			case "microwave_turret":
				level.dev_gui_supply_drop = "microwaveturret_mp";
				break;

			case "tow_turret":
				level.dev_gui_supply_drop = "auto_tow_mp";
				break;

			case "dogs":
				level.dev_gui_supply_drop = "dogs_mp";
				break;

			case "rc_bomb":
				level.dev_gui_supply_drop = "rcbomb_mp";
				break;

			case "plane_mortar":
				level.dev_gui_supply_drop = "planemortar_mp";
				break;

			case "heli":
				level.dev_gui_supply_drop = "helicopter_comlink_mp";
				break;

			case "heli_gunner":
				level.dev_gui_supply_drop = "helicopter_player_gunner_mp";
				break;

			case "straferun":
				level.dev_gui_supply_drop = "straferun_mp";
				break;

			case "missile_swarm":
				level.dev_gui_supply_drop = "missile_swarm_mp";
				break;

			case "missile_drone":
				level.dev_gui_supply_drop = "inventory_missile_drone_mp";
				break;

			case "satellite":
				level.dev_gui_supply_drop = "radardirection_mp";
				break;

			case "remote_missile":
				level.dev_gui_supply_drop = "remote_missile_mp";
				break;

			case "helicopter_guard":
				level.dev_gui_supply_drop = "helicopter_guard_mp";
				break;

			case "emp":
				level.dev_gui_supply_drop = "emp_mp";
				break;

			case "remote_mortar":
				level.dev_gui_supply_drop = "remote_mortar_mp";
				break;

			case "qrdrone":
				level.dev_gui_supply_drop = "qrdrone_mp";
				break;

			case "ai_tank":
				level.dev_gui_supply_drop = "inventory_ai_tank_drop_mp";
				break;

			case "minigun":
				level.dev_gui_supply_drop = "inventory_minigun_mp";
				break;

			case "m32":
				level.dev_gui_supply_drop = "inventory_m32_mp";
				break;

			case "random":
				level.dev_gui_supply_drop = "random";
				break;

			default:
				break;
		}
	}
#/
}