/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\mp_zombie_h2o.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 62
 * Decompile Time: 1042 ms
 * Timestamp: 4/22/2024 2:19:28 AM
*******************************************************************/

//Function Number: 1
main()
{
	maps\mp\mp_zombie_h2o_precache::main();
	maps\createart\mp_zombie_h2o_art::main();
	maps\mp\mp_zombie_h2o_fx::main();
	maps\mp\_load::main();
	maps\mp\mp_zombie_h2o_lighting::main();
	maps\mp\mp_zombie_h2o_aud::main();
	maps\mp\mp_zombie_h2o_sq::init_sidequest();
	level thread common_scripts\_exploder::activate_clientside_exploder(10);
	maps\mp\_compass::setupminimap("compass_map_mp_zombie_h2o");
	setdvar("r_lightGridEnableTweaks",1);
	setdvar("r_lightGridIntensity",1.33);
	game["attackers"] = "allies";
	game["defenders"] = "axis";
	level.dlcleaderboardnumber = 4;
	level.pickupdebugprint = 1;
	level.zombiehostinit = ::maps\mp\zombies\zombie_host::init;
	level.zombiedoginit = ::maps\mp\zombies\zombie_dog::init;
	level.zombielevelinit = ::inith2o;
	if(level.nextgen)
	{
		level thread flyoverbink();
	}

	level.zombies_using_civilians = 0;
	level.allow_swimming = 0;
	level thread maps\mp\_water::init();
	thread initzones();
	thread inittraversalsthroughdoors();
	thread initcharactermodels();
	thread inith2omutators();
	thread lightning();
	thread exo_reveal();
	thread tidalgeneratorblade();
	thread windtowerblades();
	thread ambientmantarays();
	thread onplayerfadetoblackonwaterdeath();
	thread maps\mp\zombies\_pickups_dlc3::init();
	thread maps\mp\zombies\zombie_ammo_drone::init();
	thread maps\mp\zombies\_tubes::init();
	thread maps\mp\zombies\_zombies_audio_dlc4::initdlc4audio();
	level.airdropcustomfunclevelspecific = ::airdropcustomfunc;
	level.zmgetscorestreaksforschedule = ::getscorestreaksforschedule;
	level.mapcustomkillstreakfunc = ::initkillstreaksformap;
	level.zombieweapononplayerspawnedfunc = ::zombieweapononplayerspawned;
	level.zombieweaponinitfunc = ::zombieweaponinit;
	level.initmagicboxweaponsfunc = ::zombieh2oinitmagicboxweapons;
	level.onstartgametypelevelfunc = ::zombieh2ostartgametypelevel;
	level.calculateroundtypeoverridefunc = ::calculateroundtype;
	level.calculatenextspecialround = ::calculatenextspecialround;
	level.zmbteleportgrenadefindzonecustom = ::zmbteleportgrenadefindzonecustom;
	level.zmdamageignoresarmor = ::maps\mp\gametypes\zombies::zmdamageignoresarmor;
	level.zmteleporterinit = ::zmteleporterinit;
	level.zmteleporterused = ::zmteleporterused;
	level.zmteleporterroomenter = ::zmteleporterroomenter;
	level.zmteleporterplayers = ::zmteleporterplayers;
	level.zmteleportreadyhint = &"ZOMBIE_H2O_TELEPORT_USE";
	level.zmteleportlookarcs = [0,0,0,0];
	level.allowzombierecycle = 1;
	level.recyclefullhealthzombies = 1;
	level.zombieinfectedvisionset = "mp_zombie_h2o_infected";
	level.zombieinfectedvisionset2 = "mp_zombie_h2o_infected_crazy";
	level.zombieinfectedlightset = "mp_zombie_h2o_infected";
	if(!isdefined(level.ammodroneillegalzones))
	{
		level.ammodroneillegalzones = [];
	}

	level.ammodroneillegalzones[level.ammodroneillegalzones.size] = "bus";
	level.ammodroneillegalzones[level.ammodroneillegalzones.size] = "easter_egg";
	activatepersistentclientexploder(60);
	level thread outsiderailshove();
	level thread waterfallshove();
	fixupcratepositions();
	if(level.nextgen)
	{
		thread spawnpatchclipfixes();
	}

	level.zmpatchshovefunc = ::zombieh2opatchshove;
}

//Function Number: 2
fixupcratepositions()
{
	var_00 = common_scripts\utility::getstructarray("ozCarepackagePosition","targetname");
	foreach(var_02 in var_00)
	{
		if(var_02.origin == (-349,-4305,-632))
		{
			var_02.origin = (-355,-4305,-632);
			continue;
		}

		if(var_02.origin == (159,-5593,-696))
		{
			var_02.origin = (159,-5598,-696);
			continue;
		}

		if(var_02.origin == (-857,-5265,-696))
		{
			var_02.origin = (-862,-5265,-696);
		}
	}
}

//Function Number: 3
spawnpatchclipfixes()
{
	maps\mp\_utility::spawnpatchclip("patchclip_player_64_64_64",(448,214,40),(0,28.9,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_64_64_64",(448,214,104),(0,28.9,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_64_64_64",(448,214,168),(0,28.9,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_64_64_64",(448,214,232),(0,28.9,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_64_64_64",(259,216,40),(0,-34.3,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_64_64_64",(259,216,104),(0,-34.3,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_64_64_64",(259,216,168),(0,-34.3,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_64_64_64",(259,216,232),(0,-34.3,0));
}

//Function Number: 4
zombieh2opatchshove(param_00,param_01)
{
	if(param_01)
	{
		if(self.currentzone == "start" || self.currentzone == "zone_04")
		{
			var_02 = self getgroundentity();
			if(isdefined(var_02) && isdefined(var_02.cratetype) && var_02.cratetype == "juggernaut")
			{
				var_03 = randomfloat(360);
				self setvelocity(anglestoforward((0,var_03,0)) * 200);
			}
		}

		if(self.currentzone == "zone_04" && self.origin[2] > 865 && self.origin[2] < 900 && self.origin[0] >= -1095)
		{
			self setvelocity((200,0,0));
		}
	}
}

//Function Number: 5
initkillstreaksformap()
{
	thread maps\mp\zombies\killstreaks\_zombie_goliath_suit::init();
}

//Function Number: 6
inith2omutators()
{
	maps\mp\zombies\_mutators::initfastmutator();
	maps\mp\zombies\_mutators::initexplodermutator();
	maps\mp\zombies\_mutators::initemzmutator();
	maps\mp\zombies\_mutators_spiked::initspikedmutator();
	maps\mp\zombies\_mutators_armor::initarmormutator();
	maps\mp\zombies\_mutators_teleport::initteleportmutator();
	maps\mp\zombies\_mutators_combo::initcombomutators();
	level.mutatortablesetupfunc = ::buildmutatortable;
}

//Function Number: 7
inith2o()
{
	maps\mp\zombies\zombie_boss_oz::init();
	maps\mp\zombies\killstreaks\_zombie_squadmate::init();
}

//Function Number: 8
initzones()
{
	maps\mp\zombies\_zombies_zone_manager::init();
	maps\mp\zombies\_zombies_zone_manager::initializezone("start",1);
	maps\mp\zombies\_zombies_zone_manager::initializezone("zone_01");
	maps\mp\zombies\_zombies_zone_manager::initializezone("zone_01a");
	maps\mp\zombies\_zombies_zone_manager::initializezone("zone_02");
	maps\mp\zombies\_zombies_zone_manager::initializezone("atrium");
	maps\mp\zombies\_zombies_zone_manager::initializezone("zone_02a");
	maps\mp\zombies\_zombies_zone_manager::initializezone("venthall");
	maps\mp\zombies\_zombies_zone_manager::initializezone("zone_03");
	maps\mp\zombies\_zombies_zone_manager::initializezone("zone_04");
	maps\mp\zombies\_zombies_zone_manager::initializezone("arena");
	maps\mp\zombies\_zombies_zone_manager::initializezone("bus");
	maps\mp\zombies\_zombies_zone_manager::initializezone("easter_egg");
	maps\mp\zombies\_zombies_zone_manager::addadjacentzone("start","zone_01","start_to_zone_01");
	maps\mp\zombies\_zombies_zone_manager::addadjacentzone("start","zone_02","start_to_zone_02");
	maps\mp\zombies\_zombies_zone_manager::addadjacentzone("zone_01","atrium","zone_01_to_atrium");
	maps\mp\zombies\_zombies_zone_manager::addadjacentzone("zone_01","zone_01a","zone_01_to_zone_01a");
	maps\mp\zombies\_zombies_zone_manager::addadjacentzone("zone_02","zone_01","zone_02_to_zone_01");
	maps\mp\zombies\_zombies_zone_manager::addadjacentzone("zone_02","zone_02a","zone_02_to_zone_02a");
	maps\mp\zombies\_zombies_zone_manager::addadjacentzone("zone_02a","venthall","zone_02a_to_venthall");
	maps\mp\zombies\_zombies_zone_manager::addadjacentzone("venthall","zone_03","venthall_to_zone_03");
	maps\mp\zombies\_zombies_zone_manager::addadjacentzone("venthall","atrium","venthall_to_atrium");
	maps\mp\zombies\_zombies_zone_manager::addadjacentzone("atrium","zone_04","atrium_to_zone_04");
	maps\mp\zombies\_zombies_zone_manager::addadjacentzone("zone_04","easter_egg","zone_04_to_easter_egg");
	maps\mp\zombies\_zombies_zone_manager::activate();
	level.doorbitmaskarray = [];
	level.doorbitmaskarray["start_to_zone_01"] = 1;
	level.doorbitmaskarray["start_to_zone_02"] = 2;
	level.doorbitmaskarray["zone_01_to_atrium"] = 4;
	level.doorbitmaskarray["zone_01_to_zone_01a"] = 8;
	level.doorbitmaskarray["zone_02_to_zone_01"] = 16;
	level.doorbitmaskarray["zone_02_to_zone_02a"] = 32;
	level.doorbitmaskarray["zone_02a_to_venthall"] = 64;
	level.doorbitmaskarray["venthall_to_zone_03"] = 128;
	level.doorbitmaskarray["venthall_to_atrium"] = 256;
	level.doorbitmaskarray["atrium_to_zone_04"] = 512;
	maps\mp\zombies\_doors::registerhintstring(&"ZOMBIE_H2O_DOOR_TO_CONCIERGE","start_to_zone_01",0);
	maps\mp\zombies\_doors::registerhintstring(&"ZOMBIE_H2O_DOOR_TO_LANDING","start_to_zone_01",1);
	maps\mp\zombies\_doors::registerhintstring(&"ZOMBIE_H2O_DOOR_TO_RECEPTION","start_to_zone_02",0);
	maps\mp\zombies\_doors::registerhintstring(&"ZOMBIE_H2O_DOOR_TO_LANDING","start_to_zone_02",1);
	maps\mp\zombies\_doors::registerhintstring(&"ZOMBIE_H2O_DOOR_TO_RECEPTION","zone_02_to_zone_01",0);
	maps\mp\zombies\_doors::registerhintstring(&"ZOMBIE_H2O_DOOR_TO_CONCIERGE","zone_02_to_zone_01",1);
	maps\mp\zombies\_doors::registerhintstring(&"ZOMBIE_H2O_DOOR_TO_PROMENADE","zone_02_to_zone_02a",0);
	maps\mp\zombies\_doors::registerhintstring(&"ZOMBIE_H2O_DOOR_TO_RECEPTION","zone_02_to_zone_02a",1);
	maps\mp\zombies\_doors::registerhintstring(&"ZOMBIE_H2O_DOOR_TO_ANNEX","zone_02a_to_venthall",0);
	maps\mp\zombies\_doors::registerhintstring(&"ZOMBIE_H2O_DOOR_TO_PROMENADE","zone_02a_to_venthall",1);
	maps\mp\zombies\_doors::registerhintstring(&"ZOMBIE_H2O_DOOR_TO_ANNEX","venthall_to_zone_03",0);
	maps\mp\zombies\_doors::registerhintstring(&"ZOMBIE_H2O_DOOR_TO_LOUNGE","venthall_to_zone_03",1);
	maps\mp\zombies\_doors::registerhintstring(&"ZOMBIE_H2O_DOOR_TO_GALLERIA","venthall_to_atrium",0);
	maps\mp\zombies\_doors::registerhintstring(&"ZOMBIE_H2O_DOOR_TO_ANNEX","venthall_to_atrium",1);
	maps\mp\zombies\_doors::registerhintstring(&"ZOMBIE_H2O_DOOR_TO_GALLERIA","atrium_to_zone_04",0);
	maps\mp\zombies\_doors::registerhintstring(&"ZOMBIE_H2O_DOOR_TO_TIDAL_GENERATOR","atrium_to_zone_04",1);
	maps\mp\zombies\_doors::registerhintstring(&"ZOMBIE_H2O_DOOR_TO_GALLERIA","zone_01_to_atrium",0);
	maps\mp\zombies\_doors::registerhintstring(&"ZOMBIE_H2O_DOOR_TO_GREAT_HALL","zone_01_to_atrium",1);
	maps\mp\zombies\_doors::registerhintstring(&"ZOMBIE_H2O_DOOR_TO_SPA","zone_01_to_zone_01a",0);
	maps\mp\zombies\_doors::registerhintstring(&"ZOMBIE_H2O_DOOR_TO_GREAT_HALL","zone_01_to_zone_01a",1);
}

//Function Number: 9
inittraversalsthroughdoors()
{
	level endon("game_ended");
	while(!isdefined(level.closetpathnodescalculated))
	{
		wait(0.05);
	}

	var_00 = getallnodes();
	var_01 = [];
	foreach(var_03 in var_00)
	{
		if(var_03.type == "Begin")
		{
			var_01[var_01.size] = var_03;
		}
	}

	wait(0.05);
	foreach(var_06 in var_01)
	{
		var_07 = getnode(var_06.target,"targetname");
		if(isdefined(var_06.zombieszone) && isdefined(var_07.zombieszone) && var_06.zombieszone != var_07.zombieszone)
		{
			var_08 = finddoorforzonepair(var_06.zombieszone,var_07.zombieszone);
			var_09 = distance(var_08.origin,pointonsegmentnearesttopoint(var_06.origin,var_07.origin,var_08.origin));
			if(var_09 < 100)
			{
				if(!isdefined(var_08.traversalnodepairs))
				{
					var_08.traversalnodepairs = [];
				}

				var_08.traversalnodepairs[var_08.traversalnodepairs.size] = [var_06,var_07];
				disconnectnodepair(var_06,var_07);
			}
		}
	}

	level.closetpathnodescalculated++;
}

//Function Number: 10
finddoorforzonepair(param_00,param_01)
{
	foreach(var_03 in level.zombiedoors)
	{
		var_04 = param_00 + "_to_" + param_01;
		if(var_03.script_flag == var_04)
		{
			return var_03;
		}

		var_04 = param_01 + "_to_" + param_00;
		if(var_03.script_flag == var_04)
		{
			return var_03;
		}
	}

	return undefined;
}

//Function Number: 11
zmcustomdamagetriggerweapon(param_00,param_01,param_02)
{
	if(param_02 == "laser")
	{
		return "zombie_vaporize_mp";
	}

	return "trap_zm_mp";
}

//Function Number: 12
initcharactermodels()
{
	maps\mp\zombies\_util::initializecharactermodel("security","security_guard_body","viewhands_security_guard",["security_guard_head"]);
	maps\mp\zombies\_util::initializecharactermodel("exec","executive_body","viewhands_executive",["executive_head"]);
	maps\mp\zombies\_util::initializecharactermodel("it","lilith_body","viewhands_lilith",["lilith_head"]);
	maps\mp\zombies\_util::initializecharactermodel("pilot","pilot_body_nohelmet","viewhands_pilot_bcambell",["pilot_head"]);
	maps\mp\zombies\_util::initializecharactermodel("security_exo","security_guard_body_exo","viewhands_security_guard_exo",["security_guard_head"]);
	maps\mp\zombies\_util::initializecharactermodel("exec_exo","executive_body_exo","viewhands_executive_exo",["executive_head"]);
	maps\mp\zombies\_util::initializecharactermodel("it_exo","lilith_body_exo","viewhands_lilith_exo",["lilith_head"]);
	maps\mp\zombies\_util::initializecharactermodel("pilot_exo","pilot_body_nohelmet_exo","viewhands_pilot_bcambell_exo",["pilot_head"]);
	maps\mp\zombies\_util::initializecharactermodel("security_host","security_guard_body",undefined,["security_guard_head_z"]);
	maps\mp\zombies\_util::initializecharactermodel("exec_host","executive_body",undefined,["executive_head_z"]);
	maps\mp\zombies\_util::initializecharactermodel("it_host","lilith_body",undefined,["lilith_head_z"]);
	maps\mp\zombies\_util::initializecharactermodel("pilot_host","pilot_body_nohelmet",undefined,["pilot_head_z"]);
}

//Function Number: 13
airdropcustomfunc()
{
	maps\mp\killstreaks\_airdrop::addcratetype("airdrop_assault","repulsion_turret",8,::maps\mp\zombies\killstreaks\_zombie_killstreaks::killstreakcratethink,&"KILLSTREAKS_DLC3_DISRUPTOR_TURRET","zm_disruptor");
	maps\mp\killstreaks\_airdrop::addcratetype("airdrop_assault","squadmate",25,::maps\mp\zombies\killstreaks\_zombie_killstreaks::killstreakcratethink,&"ZOMBIE_SQUADMATE_SQUADMATE","zm_squadmate");
}

//Function Number: 14
getscorestreaksforschedule()
{
	var_00 = [];
	var_00[var_00.size] = "sentry_" + randomintrange(1,4);
	var_00[var_00.size] = "drone_" + randomintrange(1,3);
	var_00[var_00.size] = "money";
	var_00[var_00.size] = "camo";
	var_00[var_00.size] = "squadmate";
	var_00[var_00.size] = "repulsion_turret";
	var_00[var_00.size] = "sentry_" + randomintrange(1,4);
	var_00[var_00.size] = "drone_" + randomintrange(1,3);
	var_00[var_00.size] = "money";
	var_00[var_00.size] = "camo";
	var_00[var_00.size] = "squadmate";
	var_00[var_00.size] = "repulsion_turret";
	return var_00;
}

//Function Number: 15
zombieweapononplayerspawned()
{
	thread maps\mp\zombies\weapons\_zombie_repulsor::onplayerspawn();
	thread maps\mp\zombies\weapons\_zombie_teleport_grenade::onplayerspawn();
	thread maps\mp\zombies\weapons\_zombie_trident::onplayerspawn();
}

//Function Number: 16
zombieweaponinit()
{
	maps\mp\zombies\weapons\_zombie_repulsor::init();
	maps\mp\zombies\weapons\_zombie_teleport_grenade::init();
	maps\mp\zombies\weapons\_zombie_trident::init();
}

//Function Number: 17
zombieh2oinitmagicboxweapons()
{
	maps\mp\zombies\_wall_buys::addmagicboxweapon("repulsor_zombie","dlc3_repulsor_device_01_holo",&"ZOMBIE_DLC3_REPULSOR","none","none","none",2);
	maps\mp\zombies\_wall_buys::addmagicboxweapon("iw5_dlcgun2zm","npc_lmg_shotgun_base_static_holo",&"ZOMBIE_WEAPONDLC2_GUN","none","none","none");
	maps\mp\zombies\_wall_buys::addmagicboxweapon("iw5_dlcgun3zm","npc_m1_irons_base_static_holo",&"ZOMBIE_WEAPONDLC3_GUN","none","none","none");
	if(level.nextgen)
	{
		maps\mp\zombies\_wall_buys::addmagicboxweapon("iw5_dlcgun4zm","npc_blunderbuss_base_holo",&"ZOMBIE_WEAPONDLC4_GUN","none","none","none",2);
	}

	maps\mp\zombies\_wall_buys::addmagicboxweapon("iw5_tridentzm","npc_zom_trident_base_holo",&"ZOMBIE_WEAPON_TRIDENT_PICKUP","none","none","none",2);
}

//Function Number: 18
buildmutatortable()
{
	for(;;)
	{
		level.special_mutators = [];
		level common_scripts\utility::waittill_any("zombie_round_countdown_started");
		var_00 = h2ogeneratepossiblemutatorsforwave(level.wavecounter);
		foreach(var_03, var_02 in var_00)
		{
			level.special_mutators[var_03] = [::h2omutatoralwaysvalid,var_02["weight"]];
		}

		level waittill("zombie_wave_ended");
	}
}

//Function Number: 19
h2omutatoralwaysvalid(param_00)
{
	return 1;
}

//Function Number: 20
h2ogetsolowaveoffset()
{
	if(level.players.size < 2)
	{
		return maps\mp\zombies\zombies_spawn_manager::getsolowaveoffset();
	}

	return 0;
}

//Function Number: 21
h2ogeneratepossiblemutatorsforwave(param_00)
{
	param_00 = param_00 - h2ogetsolowaveoffset();
	var_01 = [];
	if(param_00 < 4)
	{
	}
	else if(param_00 == 4)
	{
		var_01["emz"]["weight"] = 1;
	}
	else if(param_00 == 5)
	{
		var_01["emz"]["weight"] = 1;
		var_01["fast"]["weight"] = 1;
	}
	else if(param_00 == 6)
	{
		var_01["emz"]["weight"] = 2;
		var_01["fast"]["weight"] = 1;
		var_01["teleport"]["weight"] = 1;
	}
	else if(param_00 == 7)
	{
		var_01["emz"]["weight"] = 3;
		var_01["fast"]["weight"] = 1;
		var_01["teleport"]["weight"] = 1;
		var_01["exploder"]["weight"] = 1;
	}
	else if(param_00 == 8)
	{
		var_01["emz"]["weight"] = 4;
		var_01["fast"]["weight"] = 1;
		var_01["teleport"]["weight"] = 1;
		var_01["exploder"]["weight"] = 1;
		var_01["armor"]["weight"] = 1;
	}
	else if(param_00 <= 11)
	{
		var_01["emz"]["weight"] = 5;
		var_01["fast"]["weight"] = 1;
		var_01["teleport"]["weight"] = 1;
		var_01["exploder"]["weight"] = 1;
		var_01["armor"]["weight"] = 1;
		var_01["spiked"]["weight"] = 1;
	}
	else if(param_00 <= 13)
	{
		var_01["emz"]["weight"] = 6;
		var_01["fast"]["weight"] = 1;
		var_01["teleport"]["weight"] = 1;
		var_01["exploder"]["weight"] = 1;
		var_01["armor"]["weight"] = 1;
		var_01["spiked"]["weight"] = 1;
		var_01["combo_exploder_teleport"]["weight"] = 1;
	}
	else if(param_00 <= 15)
	{
		var_01["emz"]["weight"] = 4;
		var_01["combo_armor_emz"]["weight"] = 2;
		var_01["fast"]["weight"] = 1;
		var_01["teleport"]["weight"] = 1;
		var_01["exploder"]["weight"] = 1;
		var_01["armor"]["weight"] = 1;
		var_01["spiked"]["weight"] = 1;
		var_01["combo_exploder_teleport"]["weight"] = 1;
	}
	else if(param_00 <= 17)
	{
		var_01["emz"]["weight"] = 5;
		var_01["combo_armor_emz"]["weight"] = 2;
		var_01["fast"]["weight"] = 1;
		var_01["teleport"]["weight"] = 1;
		var_01["exploder"]["weight"] = 1;
		var_01["armor"]["weight"] = 1;
		var_01["spiked"]["weight"] = 1;
		var_01["combo_exploder_teleport"]["weight"] = 1;
		var_01["combo_spike_teleport"]["weight"] = 1;
	}
	else if(param_00 <= 19)
	{
		var_01["emz"]["weight"] = 5;
		var_01["combo_armor_emz"]["weight"] = 1;
		var_01["combo_emz_spike"]["weight"] = 1;
		var_01["fast"]["weight"] = 1;
		var_01["teleport"]["weight"] = 1;
		var_01["exploder"]["weight"] = 1;
		var_01["armor"]["weight"] = 1;
		var_01["spiked"]["weight"] = 1;
		var_01["combo_exploder_teleport"]["weight"] = 1;
		var_01["combo_spike_teleport"]["weight"] = 1;
	}
	else if(param_00 >= 20)
	{
		var_01["emz"]["weight"] = 6;
		var_01["combo_armor_emz"]["weight"] = 3;
		var_01["combo_emz_spike"]["weight"] = 3;
		var_01["teleport"]["weight"] = 1;
		var_01["exploder"]["weight"] = 1;
		var_01["armor"]["weight"] = 1;
		var_01["spiked"]["weight"] = 1;
		var_01["combo_exploder_teleport"]["weight"] = 1;
		var_01["combo_spike_teleport"]["weight"] = 1;
	}

	return var_01;
}

//Function Number: 22
zombieh2ostartgametypelevel()
{
	level thread maps\mp\zombies\_teleport::init();
	level thread maps\mp\zombies\_util::outofboundswatch(0);
	level thread maps\mp\zombies\traps\_trap_turrets::init();
	maps\mp\zombies\_traps::register_trap_state_models("dlc_trap_activation_console_01_no_signal","dlc_trap_activation_console_01_ready","dlc_trap_activation_console_01_active","dlc_trap_activation_console_01_cooldown");
}

//Function Number: 23
initspecialstreaks()
{
}

//Function Number: 24
calculateroundtype()
{
	if(isbossround(level.wavecounter))
	{
		if(maps\mp\zombies\_util::isspecialround())
		{
			level.specialroundcounter--;
			level.specialroundnumber = level.specialroundnumber + 1;
		}

		if(level.wavecounter == 13)
		{
			level.bossozstage = 1;
		}

		if(level.wavecounter == 20)
		{
			level.bossozstage = 2;
		}

		return "zombie_boss_oz";
	}

	if(maps\mp\zombies\_util::isspecialround())
	{
		return calculatespecialroundtype();
	}

	return "normal";
}

//Function Number: 25
isbossround(param_00)
{
	return param_00 == 13 || param_00 == 20;
}

//Function Number: 26
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

		case 3:
			var_01 = "zombie_dog";
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

//Function Number: 27
calculatenextspecialround()
{
	if(level.specialroundnumber < 12)
	{
		var_00 = level.specialroundnumber + 4;
	}
	else
	{
		var_00 = level.specialroundnumber + randomintrange(4,6);
	}

	return var_00;
}

//Function Number: 28
zmteleporterinit(param_00,param_01)
{
	switch(param_01)
	{
		case "ark_device":
			thread teleporter_device(param_00);
			break;

		case "ark_light":
			thread teleporter_light(param_00);
			break;

		default:
			return 0;
	}

	return 1;
}

//Function Number: 29
zmteleporterused(param_00)
{
	if(isdefined(self.device))
	{
		playfxontag(common_scripts\utility::getfx("dlc_teleport_in"),self.device,"tag_fx");
		wait(0.3);
	}
}

//Function Number: 30
zmteleporterroomenter(param_00,param_01)
{
	if(!maps\mp\zombies\_util::is_true(param_01))
	{
		common_scripts\utility::array_thread(param_00,::teleporterfx);
	}
}

//Function Number: 31
teleporterfx()
{
	if(!isdefined(self.teleportchutefx))
	{
		self.teleportchutefx = spawnfxforclient(common_scripts\utility::getfx("dlc_teleport_tunnel_player"),self.origin,self);
		self.teleportchutefx thread teleportfxdelete(self);
	}

	triggerfx(self.teleportchutefx);
}

//Function Number: 32
teleportfxdelete(param_00)
{
	self endon("death");
	param_00 waittill("disconnect");
	self delete();
}

//Function Number: 33
zmteleporterplayers(param_00)
{
	foreach(var_02 in param_00)
	{
		if(!isdefined(var_02))
		{
			continue;
		}

		playfx(common_scripts\utility::getfx("teleport_post_fx"),var_02.origin,anglestoforward(var_02.angles));
	}
}

//Function Number: 34
teleporter_device(param_00)
{
	self.device = param_00;
	param_00 hidepart("TAG_FX_ON");
	param_00 hidepart("TAG_FX_OFF");
	param_00 showpart("TAG_FX_GLOW");
	maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("dlc_prop_exo_teleport_pwr_off"),param_00,"tag_origin",0);
	self waittill("teleportReady");
	param_00 showpart("TAG_FX_ON");
	param_00 hidepart("TAG_FX_OFF");
	param_00 hidepart("TAG_FX_GLOW");
	maps\mp\zombies\_util::stopfxontagnetwork(common_scripts\utility::getfx("dlc_prop_exo_teleport_pwr_off"),param_00,"tag_origin");
	maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("dlc_prop_exo_teleport_pwr_on"),param_00,"tag_origin",0);
}

//Function Number: 35
teleporter_light(param_00)
{
	param_00 setlightcolor((0.941176,0,0));
	param_00 setlightintensity(250);
	self waittill("teleportReady");
	param_00 setlightcolor((0.501961,1,1));
	param_00 setlightintensity(3500);
}

//Function Number: 36
getteleporterlightcoloron()
{
	return (0.501961,1,1);
}

//Function Number: 37
getteleporterlightcolorstandby()
{
	return (0.941176,0,0);
}

//Function Number: 38
getteleporterlightcoloroff()
{
	return (0.941176,0,0);
}

//Function Number: 39
getteleporterlightintensityon()
{
	return (0.501961,1,1);
}

//Function Number: 40
getteleporterlightintensitystandby()
{
	return 250;
}

//Function Number: 41
getteleporterlightintensityoff()
{
	return 0.001;
}

//Function Number: 42
lightning()
{
	var_00 = getscriptablearray("lightning_pos","targetname");
	if(!var_00.size)
	{
		return;
	}

	for(;;)
	{
		var_00 = common_scripts\utility::array_randomize(var_00);
		foreach(var_02 in var_00)
		{
			var_02 setscriptablepartstate(0,1);
			var_03 = randomfloatrange(5,7);
			wait(var_03);
			while(maps\mp\zombies\_util::is_true(level.zmbpauselightningflashes))
			{
				wait 0.05;
			}

			var_02 setscriptablepartstate(0,0);
		}

		while(maps\mp\zombies\_util::is_true(level.zmbpauselightningflashes))
		{
			wait 0.05;
		}

		wait(0.1);
	}
}

//Function Number: 43
exo_reveal()
{
	var_00 = getentarray("exo_glass","targetname");
	common_scripts\utility::array_thread(var_00,::exo_reveal_run);
}

//Function Number: 44
exo_reveal_run()
{
	if(isdefined(self.target))
	{
		var_00 = getentarray(self.target,"targetname");
		foreach(var_02 in var_00)
		{
			var_02 linkto(self);
		}
	}

	level waittill("power_atrium");
	self connectpaths();
	self moveto(self.origin + (0,0,216),2);
}

//Function Number: 45
tidalgeneratorblade()
{
	var_00 = getent("tidal_generator_blade","targetname");
	if(!isdefined(var_00))
	{
		return;
	}

	var_01 = 120;
	var_02 = 100;
	for(;;)
	{
		var_00 rotatevelocity((0,var_02,0),var_01);
		wait(var_01);
	}
}

//Function Number: 46
windtowerblades()
{
	var_00 = getentarray("wind_tower_fan_front","targetname");
	common_scripts\utility::array_thread(var_00,::windtowerbladespin,(0,0,100));
	var_01 = getentarray("wind_tower_fan_back","targetname");
	common_scripts\utility::array_thread(var_01,::windtowerbladespin,(0,0,100));
}

//Function Number: 47
windtowerbladespin(param_00)
{
	var_01 = 600;
	for(;;)
	{
		self rotatevelocity(param_00,var_01);
		wait(var_01);
	}
}

//Function Number: 48
ambientmantarays()
{
	if(level.currentgen)
	{
		return;
	}

	var_00 = common_scripts\utility::getstruct("floater_anim_node","targetname");
	if(!isdefined(var_00))
	{
		return;
	}

	if(!isdefined(var_00.angles))
	{
		var_00.angles = (0,0,0);
	}

	var_01 = spawn("script_model",(0,0,0));
	var_01 setmodel("h2o_mantaray_01_anim");
	var_01 scriptmodelplayanimdeltamotionfrompos("zom_h2o_manta_ray_flyby_01",var_00.origin,var_00.angles,"manta_ray_1");
	var_02 = spawn("script_model",(0,0,0));
	var_02 setmodel("h2o_mantaray_01_anim");
	var_02 scriptmodelplayanimdeltamotionfrompos("zom_h2o_manta_ray_flyby_02",var_00.origin,var_00.angles,"manta_ray_2");
}

//Function Number: 49
onplayerfadetoblackonwaterdeath()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_00 thread fadetoblackonwaterdeath();
	}
}

//Function Number: 50
fadetoblackonwaterdeath()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("death");
		if(isagent(self) || isbot(self))
		{
			continue;
		}

		if(istouchingwatertrigger())
		{
			var_00 = underwateroverlay();
			thread underwateroverlaycleanup(var_00);
		}
	}
}

//Function Number: 51
istouchingwatertrigger()
{
	var_00 = getentarray("trigger_underwater","targetname");
	foreach(var_02 in var_00)
	{
		if(self istouching(var_02))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 52
underwateroverlay()
{
	var_00 = newclienthudelem(self);
	var_00.x = 0;
	var_00.y = 0;
	var_00 setshader("black",640,480);
	var_00.horzalign = "fullscreen";
	var_00.vertalign = "fullscreen";
	var_00.alpha = 0;
	var_00 fadeovertime(1.5);
	var_00.alpha = 1;
	return var_00;
}

//Function Number: 53
underwateroverlaycleanup(param_00)
{
	param_00 endon("death");
	common_scripts\utility::waittill_any("spawned","disconnect");
	param_00 destroy();
}

//Function Number: 54
zmbteleportgrenadefindzonecustom(param_00,param_01,param_02)
{
	var_03 = 100;
	var_04 = 0;
	var_05 = param_02 - param_00;
	var_06 = length(var_05);
	var_07 = vectornormalize(var_05);
	var_08 = maps\mp\zombies\_zombies_zone_manager::getplayerzone();
	if(isdefined(var_08) && var_08 == "bus")
	{
		return "bus";
	}
	else if(isdefined(var_08) && var_08 == "arena")
	{
		return "arena";
	}

	for(;;)
	{
		var_09 = param_00 + var_07 * var_04;
		var_0A = maps\mp\zombies\_zombies_zone_manager::ispointinanyzonereturn(var_09,1);
		if(isdefined(var_0A) && maps\mp\zombies\_zombies_zone_manager::iszoneenabled(var_0A))
		{
			if(var_0A != "bus" && var_0A != "arena")
			{
				return var_0A;
			}
		}

		if(var_04 == var_06)
		{
			break;
		}

		var_04 = var_04 + var_03;
		if(var_04 > var_06)
		{
			var_04 = var_06;
		}
	}

	if(isdefined(var_08))
	{
		return var_08;
	}
}

//Function Number: 55
flyoverbink()
{
	var_00 = "zombie_bink_env_camera_DLC4";
	var_01 = "scr_" + var_00;
	setdvar(var_01,0);
	var_02 = "devgui_cmd \"Zombie:2/Toggle Flyover Binks/" + var_00 + "\" \"togglep " + var_01 + " 0 1\";";
	thread setupflyoveranimation("zombie_bink_env_camera_DLC4","j_prop_1",[],var_01);
}

//Function Number: 56
setupflyoveranimation(param_00,param_01,param_02,param_03)
{
	var_04 = common_scripts\utility::getstruct("floater_anim_node","targetname");
	if(!isdefined(var_04))
	{
		return;
	}

	if(!isdefined(var_04.angles))
	{
		var_04.angles = (0,0,0);
	}

	if(!isdefined(param_02))
	{
		param_02 = [];
	}

	while(getdvarint(param_03,0) == 0)
	{
		wait 0.05;
	}

	setdvar("lui_enabled",0);
	setdvar("cg_drawBuildname",0);
	setdvar("cg_drawMapBuildInfo",0);
	setdvar("cg_drawversion",0);
	setdvar("cg_drawviewpos",0);
	setdvar("cg_fovScale",1.1);
	level.zombiegamepaused = 1;
	var_05 = maps\mp\agents\_agent_utility::getactiveagentsoftype("all");
	foreach(var_07 in var_05)
	{
		var_07.bypasscorpse = 1;
		var_07 dodamage(var_07.health + 500000,var_07.origin,level.players[0],undefined,"MOD_EXPLOSIVE","repulsor_zombie_mp");
	}

	wait(2);
	var_09 = spawn("script_model",(0,0,0));
	var_09 setmodel("genericprop_x3");
	var_0A = spawn("script_model",(0,0,0));
	var_0A setmodel("tag_player");
	var_0A vehicle_jetbikesethoverforcescale(var_09,param_01,(0,0,0),(0,0,0));
	for(;;)
	{
		while(getdvarint(param_03,0) == 0)
		{
			wait 0.05;
		}

		level.player playerlinkweaponviewtodelta(var_0A,"tag_player",1,0,0,0,0,1);
		level.player playerlinkedsetviewznear(0);
		level.player hide();
		var_09 scriptmodelplayanimdeltamotionfrompos(param_00,var_04.origin,var_04.angles,"camera_notetrack");
		foreach(var_0C in param_02)
		{
			level thread donotetrack(var_09,"camera_notetrack",var_0C);
		}

		wait(1);
		while(getdvarint(param_03,0) == 1)
		{
			wait 0.05;
		}

		var_09 notify("notetrackDone");
		level.player show();
		level.player unlink();
		var_09 scriptmodelclearanim();
		wait(1);
	}
}

//Function Number: 57
donotetrack(param_00,param_01,param_02,param_03)
{
	param_00 endon("notetrackDone");
	param_00 waittillmatch(param_02,param_01);
	if(param_02 == "trigger_decontamination")
	{
	}
	else if(param_02 == "open_doors")
	{
	}

	level notify(param_02);
}

//Function Number: 58
setupscriptmodelanimation(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = common_scripts\utility::getstruct("env_bink_anim_node","targetname");
	if(!isdefined(var_05))
	{
		var_05 = spawnstruct();
		var_05.origin = (0,3584,88);
	}

	if(!isdefined(var_05.angles))
	{
		var_05.angles = (0,0,0);
	}

	if(!isdefined(param_03))
	{
		param_03 = [];
	}

	var_06 = spawn("script_model",(0,0,0));
	var_06 setmodel(param_01);
	for(;;)
	{
		while(getdvarint(param_04,0) == 0)
		{
			wait 0.05;
		}

		if(isdefined(param_02))
		{
			level waittill(param_02);
		}

		var_06 scriptmodelplayanimdeltamotionfrompos(param_00,var_05.origin,var_05.angles,"ent_notetrack");
		foreach(var_08 in param_03)
		{
			level thread donotetrack(var_06,"ent_notetrack",var_08);
		}

		wait(1);
		while(getdvarint(param_04,0) == 1)
		{
			wait 0.05;
		}

		var_06 notify("notetrackDone");
		var_06 scriptmodelclearanim();
		wait(1);
	}
}

//Function Number: 59
outsiderailshove()
{
	level waittill("player_spawned");
	for(;;)
	{
		foreach(var_01 in level.players)
		{
			if(var_01 playerisonarailing())
			{
				if(maps\mp\zombies\_util::is_true(var_01.onoutsiderail))
				{
					var_02 = var_01 playergetnearestnode();
					if(isdefined(var_02))
					{
						var_03 = vectornormalize(var_02.origin - var_01.origin * (1,1,0));
						var_01 setvelocity(var_03 * 200);
					}
				}
				else
				{
					var_01.onoutsiderail = 1;
				}

				continue;
			}

			var_01.onoutsiderail = undefined;
		}

		wait(0.1);
	}
}

//Function Number: 60
playerisonarailing()
{
	if(self.origin[2] > 688 && self.origin[2] < 689)
	{
		return 0;
	}
	else if(self.origin[2] > 712 && self.origin[2] < 713)
	{
		return 0;
	}
	else if(!self isonground() || self isjumping())
	{
		return 0;
	}

	var_00 = getentarray("railing_exploit","targetname");
	if(var_00.size > 0)
	{
		foreach(var_02 in var_00)
		{
			if(self istouching(var_02))
			{
				return 1;
			}
		}

		return 0;
	}

	if(self.origin[2] > 758 && self.origin[2] < 759 && self.origin[1] > -700 && self.origin[1] < 500 && self.origin[0] > -900 && self.origin[0] < 700)
	{
		return 1;
	}

	if(self.origin[2] > 738 && self.origin[2] < 739 && self.origin[1] > 4500 && self.origin[1] < 5100 && self.origin[0] > -2000 && self.origin[0] < -1300)
	{
		return 1;
	}

	return 0;
}

//Function Number: 61
playergetnearestnode()
{
	var_00 = self getnearestnode();
	if(!isdefined(var_00))
	{
		var_01 = getnodesinradiussorted(self.origin,256,0);
		if(var_01.size > 0)
		{
			var_00 = var_01[0];
		}
	}

	return var_00;
}

//Function Number: 62
waterfallshove()
{
	var_00 = anglestoforward((0,150,0));
	level waittill("player_spawned");
	for(;;)
	{
		foreach(var_02 in level.players)
		{
			if(var_02.origin[2] > 88 && var_02.origin[2] < 89 && var_02.origin[1] > 940 && var_02.origin[1] < 1010 && var_02.origin[0] > 1230 && var_02.origin[0] < 1255)
			{
				if(maps\mp\zombies\_util::is_true(var_02.onwaterfalledge))
				{
					var_02 setvelocity(var_00 * 150);
				}
				else
				{
					var_02.onwaterfalledge = 1;
				}

				continue;
			}

			var_02.onwaterfalledge = undefined;
		}

		wait(0.1);
	}
}