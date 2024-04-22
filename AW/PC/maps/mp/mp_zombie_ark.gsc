/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\mp_zombie_ark.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 64
 * Decompile Time: 955 ms
 * Timestamp: 4/22/2024 2:18:50 AM
*******************************************************************/

//Function Number: 1
main()
{
	maps\mp\mp_zombie_ark_precache::main();
	maps\createart\mp_zombie_ark_art::main();
	maps\mp\mp_zombie_ark_fx::main();
	maps\mp\mp_zombie_ark_sq::createfxhidesidquestents();
	maps\mp\_load::main();
	maps\mp\mp_zombie_ark_lighting::main();
	maps\mp\mp_zombie_ark_aud::main();
	maps\mp\mp_zombie_ark_sq::init_sidequest();
	maps\mp\_compass::setupminimap("compass_map_mp_zombie_ark");
	game["attackers"] = "allies";
	game["defenders"] = "axis";
	level.dlcleaderboardnumber = 3;
	level.pickupdebugprint = 1;
	level.zombiehostinit = ::maps\mp\zombies\zombie_host::init;
	level.zombiedoginit = ::maps\mp\zombies\zombie_dog::init;
	level.zombielevelinit = ::initark;
	level.agentshouldragdollimmediatelyfunc = ::agentshouldragdollimmediately;
	level thread flyoverbink();
	visionsetpain("mp_zombie_ark_pain",0);
	level.zombieinfectedvisionset = "mp_zombie_ark_infected";
	level.zombieinfectedvisionset2 = "mp_zombie_ark_infected_uber";
	level.zombieinfectedlightset = "mp_zombie_ark_infected";
	level.zombies_using_civilians = 0;
	level.allow_swimming = 0;
	level thread maps\mp\_water::init();
	thread disablepronevolumecheck();
	level.nearestnodetounreachabledronesearchheight = 128;
	thread initzones();
	thread initcharactermodels();
	thread initarkmutators();
	thread maps\mp\zombies\_pickups_dlc3::init();
	thread maps\mp\zombies\zombie_ammo_drone::init();
	thread maps\mp\zombies\_zombies_audio_dlc3::initdlc3audio();
	thread initareainvalidation();
	thread doidlesharkanimations();
	thread killglass();
	thread zombiearkloadeyeeffects();
	thread exoreveal();
	level.airdropcustomfunclevelspecific = ::airdropcustomfunc;
	level.zmgetscorestreaksforschedule = ::getscorestreaksforschedule;
	level.zombieweapononplayerspawnedfunc = ::zombieweapononplayerspawned;
	level.zombieweaponinitfunc = ::zombieweaponinit;
	level.initmagicboxweaponsfunc = ::zombiearkinitmagicboxweapons;
	level.onstartgametypelevelfunc = ::zombiearkstartgametypelevel;
	level.calculatespecialroundtypeoverride = ::calculatespecialroundtype;
	level.givecustomcharacters = ::zombiearkgivecustomcharacter;
	level.filterstartspawnfunc = ::zombiearkfilterstartspawns;
	level.filterrespawnfunc = ::zombiearkfilterrespawns;
	level.zmcustomdamagetriggerweapon = ::zmcustomdamagetriggerweapon;
	level.zmbteleportgrenadefindzonecustom = ::zmbteleportgrenadefindzonecustom;
	level.zmteleporterinit = ::zmteleporterinit;
	level.zmteleporterused = ::zmteleporterused;
	level.zmteleporterroomenter = ::zmteleporterroomenter;
	level.zmteleporterplayers = ::zmteleporterplayers;
	level.zmteleportreadyhint = &"ZOMBIE_ARK_TELEPORT_USE";
	level.zmteleportlookarcs = [0,0,0,0];
	level.zmdamageignoresarmor = ::maps\mp\gametypes\zombies::zmdamageignoresarmor;
	level.canspawnpickupoverridefunc = ::maps\mp\zombies\_pickups_dlc3::canspawnpickup;
	level.allowzombierecycle = 1;
	level.recyclefullhealthzombies = 1;
	level.zmblasertrapcustom = "trap_ark_zm";
	level.zmblasertrapwarningcustom = "trap_ark_zm_warning";
	level.zmblasertrapsoundloop = "trap_scanner_beam_lp";
	level.zmblasertrapsoundstop = "trap_scanner_off_shot";
	level.zmblasertrapsoundstart = "trap_scanner_on_shot";
	level.modifygenericzombieclassfunc = ::zombiearkmodifygenericzombieclass;
	if(level.nextgen)
	{
		thread spawnpatchclipfixes();
	}
	else
	{
		thread triggerscriptpatchkilltrigger();
	}

	level.zmpatchshovefunc = ::zombiearkpatchshove;
}

//Function Number: 2
triggerscriptpatchkilltrigger()
{
}

//Function Number: 3
spawnkilltriggerthink(param_00,param_01,param_02)
{
	level endon("game_ended");
	var_03 = spawn("trigger_radius",param_00,0,param_01,param_02);
	if(!isdefined(var_03))
	{
		return;
	}

	for(;;)
	{
		var_03 waittill("trigger",var_04);
		if(isdefined(var_04) && isplayer(var_04) && isdefined(var_04.health))
		{
			var_04 dodamage(var_04.health + 999,var_03.origin);
		}
	}
}

//Function Number: 4
zombiearkmodifygenericzombieclass(param_00)
{
	var_01 = param_00.model_bodies.size;
	if(level.nextgen)
	{
		param_00.model_bodies[var_01] = ["zom_worker_torso_slice"];
		param_00.model_limbs[var_01]["right_arm"] = ["zom_worker_r_arm_slice"];
		param_00.model_limbs[var_01]["left_arm"] = ["zom_worker_l_arm_slice"];
		param_00.model_limbs[var_01]["right_leg"] = ["zom_worker_r_leg_slice"];
		param_00.model_limbs[var_01]["left_leg"] = ["zom_worker_l_leg_slice"];
		param_00.model_heads[var_01] = ["zombies_head_cau_worker_dlc3_a","zombies_head_cau_worker_dlc3_b","zombies_head_cau_worker_dlc3_c"];
		var_01++;
		param_00.model_bodies[var_01] = ["zom_worker_b_torso_slice"];
		param_00.model_limbs[var_01]["right_arm"] = ["zom_worker_b_r_arm_slice"];
		param_00.model_limbs[var_01]["left_arm"] = ["zom_worker_b_l_arm_slice"];
		param_00.model_limbs[var_01]["right_leg"] = ["zom_worker_b_r_leg_slice"];
		param_00.model_limbs[var_01]["left_leg"] = ["zom_worker_b_l_leg_slice"];
		param_00.model_heads[var_01] = ["zombies_head_cau_worker_dlc3_a","zombies_head_cau_worker_dlc3_b","zombies_head_cau_worker_dlc3_c"];
		level.exobodyparts["zom_worker_torso_slice"]["torso"] = "zom_marine_exo_torso_slice";
		level.exobodyparts["zom_worker_torso_slice"]["right_arm"] = "zom_marine_exo_r_arm_slice";
		level.exobodyparts["zom_worker_torso_slice"]["left_arm"] = "zom_marine_exo_l_arm_slice";
		level.exobodyparts["zom_worker_torso_slice"]["right_leg"] = "zom_marine_exo_r_leg_slice";
		level.exobodyparts["zom_worker_torso_slice"]["left_leg"] = "zom_marine_exo_l_leg_slice";
		level.exobodyparts["zom_worker_torso_slice"]["heads"] = ["zombies_head_cau_dlc_a","zombies_head_cau_dlc_b","zombies_head_cau_dlc_c","zombies_head_shg_dlc_b"];
		level.exobodyparts["zom_worker_b_torso_slice"]["torso"] = "zom_marine_exo_torso_slice_ab";
		level.exobodyparts["zom_worker_b_torso_slice"]["right_arm"] = "zom_marine_exo_r_arm_slice";
		level.exobodyparts["zom_worker_b_torso_slice"]["left_arm"] = "zom_marine_exo_l_arm_slice";
		level.exobodyparts["zom_worker_b_torso_slice"]["right_leg"] = "zom_marine_exo_r_leg_slice_ab";
		level.exobodyparts["zom_worker_b_torso_slice"]["left_leg"] = "zom_marine_exo_l_leg_slice_ab";
		level.exobodyparts["zom_worker_b_torso_slice"]["heads"] = ["zombies_head_cau_dlc_a","zombies_head_cau_dlc_b","zombies_head_cau_dlc_c","zombies_head_shg_dlc_b"];
		level.dismemberment["zombies_head_cau_worker_dlc3_a"]["nub"] = "zom_worker_head_slice";
		level.dismemberment["zombies_head_cau_worker_dlc3_b"]["nub"] = "zom_worker_head_slice";
		level.dismemberment["zombies_head_cau_worker_dlc3_c"]["nub"] = "zom_worker_head_slice";
		return param_00;
	}

	param_00.model_bodies[var_01] = ["zom_worker_torso_slice"];
	param_00.model_limbs[var_01]["right_arm"] = ["zom_worker_r_arm_slice"];
	param_00.model_limbs[var_01]["left_arm"] = ["zom_worker_l_arm_slice"];
	param_00.model_limbs[var_01]["right_leg"] = ["zom_worker_r_leg_slice"];
	param_00.model_limbs[var_01]["left_leg"] = ["zom_worker_l_leg_slice"];
	param_00.model_heads[var_01] = ["zombies_head_cau_worker_dlc3_a"];
	level.exobodyparts["zom_worker_torso_slice"]["torso"] = "zom_marine_exo_torso_slice";
	level.exobodyparts["zom_worker_torso_slice"]["right_arm"] = "zom_marine_exo_r_arm_slice";
	level.exobodyparts["zom_worker_torso_slice"]["left_arm"] = "zom_marine_exo_l_arm_slice";
	level.exobodyparts["zom_worker_torso_slice"]["right_leg"] = "zom_marine_exo_r_leg_slice";
	level.exobodyparts["zom_worker_torso_slice"]["left_leg"] = "zom_marine_exo_l_leg_slice";
	level.exobodyparts["zom_worker_torso_slice"]["heads"] = ["zombies_head_cau_dlc_a","zombies_head_cau_dlc_b","zombies_head_cau_dlc_c","zombies_head_shg_dlc_b"];
	level.dismemberment["zombies_head_cau_worker_dlc3_a"]["nub"] = "zom_worker_head_slice";
	return param_00;
}

//Function Number: 5
zombiearkloadeyeeffects()
{
	level.validheadtypes[level.validheadtypes.size] = "cau_worker_dlc3_a";
	level.validheadtypes[level.validheadtypes.size] = "cau_worker_dlc3_b";
	level.validheadtypes[level.validheadtypes.size] = "cau_worker_dlc3_c";
	level._effect["zombie_eye_vanilla_cau_worker_dlc3_a"] = loadfx("vfx/gameplay/mp/zombie/zombie_eye_vanilla_cau_dlc_a");
	level._effect["zombie_eye_vanilla_cau_worker_dlc3_b"] = loadfx("vfx/gameplay/mp/zombie/zombie_eye_vanilla_cau_dlc_b");
	level._effect["zombie_eye_vanilla_cau_worker_dlc3_c"] = loadfx("vfx/gameplay/mp/zombie/zombie_eye_vanilla_cau_dlc_c");
}

//Function Number: 6
zmcustomdamagetriggerweapon(param_00,param_01,param_02)
{
	if(param_02 == "laser")
	{
		return "zombie_vaporize_mp";
	}

	return "trap_zm_mp";
}

//Function Number: 7
disablepronevolumecheck()
{
	level endon("game_ended");
	var_00 = getentarray("water_no_prone","targetname");
	foreach(var_02 in var_00)
	{
		for(;;)
		{
			var_02 waittill("trigger",var_03);
			if(isplayer(var_03))
			{
				var_03 thread disableprone(var_02);
			}
		}
	}
}

//Function Number: 8
disableprone(param_00)
{
	self notify("noprone");
	self endon("noprone");
	while(self istouching(param_00))
	{
		self allowprone(0);
		wait(0.5);
	}

	self allowprone(1);
}

//Function Number: 9
initarkmutators()
{
	maps\mp\zombies\_mutators::initfastmutator();
	maps\mp\zombies\_mutators::initexplodermutator();
	maps\mp\zombies\_mutators::initemzmutator();
	maps\mp\zombies\_mutators_spiked::initspikedmutator();
	maps\mp\zombies\_mutators_armor::initarmormutator();
	maps\mp\zombies\_mutators_teleport::initteleportmutator();
	level.mutatortablesetupfunc = ::buildmutatortable;
}

//Function Number: 10
initark()
{
	maps\mp\zombies\zombie_melee_goliath::init();
	maps\mp\zombies\ranged_elite_soldier::init();
	maps\mp\zombies\killstreaks\_zombie_squadmate::init();
}

//Function Number: 11
initzones()
{
	maps\mp\zombies\_zombies_zone_manager::init();
	maps\mp\zombies\_zombies_zone_manager::initializezone("sidebay",1);
	maps\mp\zombies\_zombies_zone_manager::initializezone("rearbay",1);
	maps\mp\zombies\_zombies_zone_manager::initializezone("cargo_elevator");
	maps\mp\zombies\_zombies_zone_manager::initializezone("cargo_bay");
	maps\mp\zombies\_zombies_zone_manager::initializezone("armory");
	maps\mp\zombies\_zombies_zone_manager::initializezone("biomed");
	maps\mp\zombies\_zombies_zone_manager::initializezone("medical");
	maps\mp\zombies\_zombies_zone_manager::initializezone("moonpool");
	maps\mp\zombies\_zombies_zone_manager::addadjacentzone("sidebay","rearbay","sidebay_to_rearbay");
	maps\mp\zombies\_zombies_zone_manager::addadjacentzone("sidebay","armory","sidebay_to_armory");
	maps\mp\zombies\_zombies_zone_manager::addadjacentzone("rearbay","armory","rearbay_to_armory");
	maps\mp\zombies\_zombies_zone_manager::addadjacentzone("cargo_elevator","cargo_bay","cargo_elevator_to_cargo_bay");
	maps\mp\zombies\_zombies_zone_manager::addadjacentzone("biomed","cargo_bay","biomed_to_cargo_bay");
	maps\mp\zombies\_zombies_zone_manager::addadjacentzone("armory","biomed","armory_to_biomed");
	maps\mp\zombies\_zombies_zone_manager::addadjacentzone("armory","cargo_elevator","armory_to_cargo_elevator");
	maps\mp\zombies\_zombies_zone_manager::addadjacentzone("medical","biomed","medical_to_biomed");
	maps\mp\zombies\_zombies_zone_manager::addadjacentzone("moonpool","cargo_elevator","moonpool_to_cargo_elevator");
	maps\mp\zombies\_zombies_zone_manager::addadjacentzone("sidebay","medical","sidebay_to_medical");
	maps\mp\zombies\_zombies_zone_manager::addadjacentzone("rearbay","moonpool","rearbay_to_moonpool");
	level thread zoneopensidebaytorearbay();
	maps\mp\zombies\_zombies_zone_manager::activate();
	level.doorbitmaskarray = [];
	level.doorbitmaskarray["sidebay_to_armory"] = 1;
	level.doorbitmaskarray["rearbay_to_armory"] = 2;
	level.doorbitmaskarray["cargo_elevator_to_cargo_bay"] = 4;
	level.doorbitmaskarray["biomed_to_cargo_bay"] = 8;
	level.doorbitmaskarray["armory_to_biomed"] = 16;
	level.doorbitmaskarray["armory_to_cargo_elevator"] = 32;
	level.doorbitmaskarray["medical_to_biomed"] = 64;
	level.doorbitmaskarray["moonpool_to_cargo_elevator"] = 128;
	level.doorbitmaskarray["sidebay_to_medical"] = 256;
	level.doorbitmaskarray["rearbay_to_moonpool"] = 512;
	maps\mp\zombies\_doors::registerhintstring(&"ZOMBIE_ARK_DOOR_TO_SIDEBAY","sidebay_to_armory",0);
	maps\mp\zombies\_doors::registerhintstring(&"ZOMBIE_ARK_DOOR_TO_ARMORY","sidebay_to_armory",1);
	maps\mp\zombies\_doors::registerhintstring(&"ZOMBIE_ARK_DOOR_TO_REARBAY","rearbay_to_armory",0);
	maps\mp\zombies\_doors::registerhintstring(&"ZOMBIE_ARK_DOOR_TO_ARMORY","rearbay_to_armory",1);
	maps\mp\zombies\_doors::registerhintstring(&"ZOMBIE_ARK_DOOR_TO_CARGOBAY","cargo_elevator_to_cargo_bay",0);
	maps\mp\zombies\_doors::registerhintstring(&"ZOMBIE_ARK_DOOR_TO_CARGOELEVATOR","cargo_elevator_to_cargo_bay",1);
	maps\mp\zombies\_doors::registerhintstring(&"ZOMBIE_ARK_DOOR_TO_BIOMED","biomed_to_cargo_bay",0);
	maps\mp\zombies\_doors::registerhintstring(&"ZOMBIE_ARK_DOOR_TO_CARGOBAY","biomed_to_cargo_bay",1);
	maps\mp\zombies\_doors::registerhintstring(&"ZOMBIE_ARK_DOOR_TO_BIOMED","armory_to_biomed",0);
	maps\mp\zombies\_doors::registerhintstring(&"ZOMBIE_ARK_DOOR_TO_ARMORY","armory_to_biomed",1);
	maps\mp\zombies\_doors::registerhintstring(&"ZOMBIE_ARK_DOOR_TO_ARMORY","armory_to_cargo_elevator",0);
	maps\mp\zombies\_doors::registerhintstring(&"ZOMBIE_ARK_DOOR_TO_CARGOELEVATOR","armory_to_cargo_elevator",1);
	maps\mp\zombies\_doors::registerhintstring(&"ZOMBIE_ARK_DOOR_TO_BIOMED","medical_to_biomed",0);
	maps\mp\zombies\_doors::registerhintstring(&"ZOMBIE_ARK_DOOR_TO_MEDICAL","medical_to_biomed",1);
	maps\mp\zombies\_doors::registerhintstring(&"ZOMBIE_ARK_DOOR_TO_MOONPOOL","moonpool_to_cargo_elevator",0);
	maps\mp\zombies\_doors::registerhintstring(&"ZOMBIE_ARK_DOOR_TO_CARGOELEVATOR","moonpool_to_cargo_elevator",1);
	maps\mp\zombies\_doors::registerhintstring(&"ZOMBIE_ARK_DOOR_TO_SIDEBAY","sidebay_to_medical",0);
	maps\mp\zombies\_doors::registerhintstring(&"ZOMBIE_ARK_DOOR_TO_MEDICAL","sidebay_to_medical",1);
	maps\mp\zombies\_doors::registerhintstring(&"ZOMBIE_ARK_DOOR_TO_REARBAY","rearbay_to_moonpool",0);
	maps\mp\zombies\_doors::registerhintstring(&"ZOMBIE_ARK_DOOR_TO_MOONPOOL","rearbay_to_moonpool",1);
}

//Function Number: 12
zoneopensidebaytorearbay()
{
	level endon("game_ended");
	for(;;)
	{
		var_00 = level common_scripts\utility::waittill_any_return("player_given_exo_suit","player_purchased_teleport_grenade","zombie_wave_started");
		if(var_00 == "zombie_wave_started" && level.wavecounter < 5)
		{
			continue;
		}

		break;
	}

	common_scripts\utility::flag_set("sidebay_to_rearbay");
}

//Function Number: 13
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

//Function Number: 14
initareainvalidation()
{
	thread maps\mp\zombies\_area_invalidation::init();
	maps\mp\zombies\_area_invalidation::setupzone("sidebay",90,1,&"ZOMBIE_ARK_SIDE_BAY","dlc3_zombie_bomb_sidebay","dlc3_zombie_bomb_defuse_sidebay","dlc3_zombie_bomb_detonate_sidebay");
	maps\mp\zombies\_area_invalidation::setupzone("rearbay",91,2,&"ZOMBIE_ARK_REAR_BAY","dlc3_zombie_bomb_rearbay","dlc3_zombie_bomb_defuse_rearbay","dlc3_zombie_bomb_detonate_rearbay");
	maps\mp\zombies\_area_invalidation::setupzone("medical",97,3,&"ZOMBIE_ARK_MEDICAL","dlc3_zombie_bomb_medical","dlc3_zombie_bomb_defuse_medical","dlc3_zombie_bomb_detonate_medical",1);
	maps\mp\zombies\_area_invalidation::setupzone("armory",92,4,&"ZOMBIE_ARK_ARMORY","dlc3_zombie_bomb_armory","dlc3_zombie_bomb_defuse_armory","dlc3_zombie_bomb_detonate_armory");
	maps\mp\zombies\_area_invalidation::setupzone("moonpool",93,5,&"ZOMBIE_ARK_MOON_POOL","dlc3_zombie_bomb_moonpool","dlc3_zombie_bomb_defuse_moonpool","dlc3_zombie_bomb_detonate_moonpool",1);
	maps\mp\zombies\_area_invalidation::setupzone("biomed",94,6,&"ZOMBIE_ARK_BIOMED","dlc3_zombie_bomb_biomed","dlc3_zombie_bomb_defuse_biomed","dlc3_zombie_bomb_detonate_biomed");
	maps\mp\zombies\_area_invalidation::setupzone("cargo_bay",95,7,&"ZOMBIE_ARK_CARGO_ROOM","dlc3_zombie_bomb_cargobay","dlc3_zombie_bomb_defuse_cargobay","dlc3_zombie_bomb_detonate_cargobay");
	maps\mp\zombies\_area_invalidation::setupzone("cargo_elevator",96,8,&"ZOMBIE_ARK_CARGO_ELEVATOR","dlc3_zombie_bomb_cargoelevator","dlc3_zombie_bomb_defuse_cargoelevator","dlc3_zombie_bomb_detonate_cargoelevator");
}

//Function Number: 15
airdropcustomfunc()
{
	maps\mp\killstreaks\_airdrop::addcratetype("airdrop_assault","repulsion_turret",8,::maps\mp\zombies\killstreaks\_zombie_killstreaks::killstreakcratethink,&"KILLSTREAKS_DLC3_DISRUPTOR_TURRET","zm_disruptor");
	maps\mp\killstreaks\_airdrop::addcratetype("airdrop_assault","squadmate",25,::maps\mp\zombies\killstreaks\_zombie_killstreaks::killstreakcratethink,&"ZOMBIE_SQUADMATE_SQUADMATE","zm_squadmate");
}

//Function Number: 16
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

//Function Number: 17
zombieweapononplayerspawned()
{
	thread maps\mp\zombies\weapons\_zombie_repulsor::onplayerspawn();
	thread maps\mp\zombies\weapons\_zombie_teleport_grenade::onplayerspawn();
	thread maps\mp\zombies\weapons\_zombie_line_gun::onplayerspawn();
}

//Function Number: 18
zombieweaponinit()
{
	maps\mp\zombies\weapons\_zombie_repulsor::init();
	maps\mp\zombies\weapons\_zombie_teleport_grenade::init();
	maps\mp\zombies\weapons\_zombie_line_gun::init();
}

//Function Number: 19
zombiearkinitmagicboxweapons()
{
	maps\mp\zombies\_wall_buys::addmagicboxweapon("iw5_linegunzm","npc_zom_line_gun_holo",&"ZOMBIE_WEAPON_LINEGUN_PICKUP","none","none","none",2);
	maps\mp\zombies\_wall_buys::addmagicboxweapon("repulsor_zombie","dlc3_repulsor_device_01_holo",&"ZOMBIE_DLC3_REPULSOR","none","none","none",2);
	maps\mp\zombies\_wall_buys::addmagicboxweapon("iw5_dlcgun2zm","npc_lmg_shotgun_base_static_holo",&"ZOMBIE_WEAPONDLC2_GUN","none","none","none");
	maps\mp\zombies\_wall_buys::addmagicboxweapon("iw5_dlcgun3zm","npc_m1_irons_base_static_holo",&"ZOMBIE_WEAPONDLC3_GUN","none","none","none");
}

//Function Number: 20
buildmutatortable()
{
	for(;;)
	{
		level.special_mutators = [];
		level waittill("zombie_round_countdown_started");
		var_00 = arkgeneratepossiblemutatorsforwave(level.wavecounter);
		foreach(var_03, var_02 in var_00)
		{
			level.special_mutators[var_03] = [::arkmutatoralwaysvalid,var_02["weight"]];
		}

		level waittill("zombie_wave_ended");
	}
}

//Function Number: 21
arkmutatoralwaysvalid(param_00)
{
	return 1;
}

//Function Number: 22
arkgetsolowaveoffset()
{
	if(level.players.size < 2)
	{
		return maps\mp\zombies\zombies_spawn_manager::getsolowaveoffset();
	}

	return 0;
}

//Function Number: 23
arkgeneratepossiblemutatorsforwave(param_00)
{
	param_00 = param_00 - arkgetsolowaveoffset();
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
		var_01["emz"]["weight"] = 4;
		var_01["fast"]["weight"] = 1;
		var_01["teleport"]["weight"] = 2;
		var_01["exploder"]["weight"] = 1;
	}
	else if(param_00 == 8)
	{
		var_01["emz"]["weight"] = 6;
		var_01["fast"]["weight"] = 1;
		var_01["teleport"]["weight"] = 3;
		var_01["exploder"]["weight"] = 1;
		var_01["armor"]["weight"] = 1;
	}
	else if(param_00 <= 19)
	{
		var_01["emz"]["weight"] = 8;
		var_01["fast"]["weight"] = 1;
		var_01["teleport"]["weight"] = 4;
		var_01["exploder"]["weight"] = 1;
		var_01["armor"]["weight"] = 1;
		var_01["spiked"]["weight"] = 1;
	}
	else if(param_00 >= 20)
	{
		var_01["emz"]["weight"] = 12;
		var_01["teleport"]["weight"] = 3;
		var_01["exploder"]["weight"] = 1;
		var_01["armor"]["weight"] = 1;
		var_01["spiked"]["weight"] = 1;
	}

	return var_01;
}

//Function Number: 24
zombiearkrunzomboniachievementforplayer()
{
	self endon("disconnect");
	level endon("game_ended");
	self.zomboniridetime = 0;
	var_00 = 0.1;
	var_01 = 300;
	for(;;)
	{
		wait(var_00);
		if(!isalive(self) || maps\mp\zombies\_util::isplayerinlaststand(self))
		{
			continue;
		}

		if(self.sessionstate == "spectator" || self.sessionstate == "intermission")
		{
			continue;
		}

		var_02 = self getgroundentity();
		if(isdefined(var_02))
		{
			var_03 = var_02 getlinkedparent();
			if(isdefined(var_03) && isdefined(var_03.iszomboni) && var_03.iszomboni)
			{
				self.zomboniridetime = self.zomboniridetime + var_00;
				var_04 = 0;
				if(self.zomboniridetime >= var_01 && !var_04)
				{
					maps\mp\gametypes\zombies::givezombieachievement("DLC3_ZOMBIE_ZOMBONI");
					return;
				}
			}
		}
	}
}

//Function Number: 25
zombiearkrunachievementsforplayer()
{
	thread zombiearkrunzomboniachievementforplayer();
}

//Function Number: 26
zombiearkrunsharktrigger(param_00,param_01)
{
	level endon("game_ended");
	for(;;)
	{
		self waittill("trigger",var_02);
		if(maps\mp\zombies\_util::is_true(var_02.jumpedtheshark))
		{
			continue;
		}

		if(!var_02 isjumping() && !var_02 ishighjumping())
		{
			continue;
		}

		if(param_01 && !maps\mp\zombies\_util::is_true(level.zmbsharktriggeractive))
		{
			continue;
		}

		if(!isdefined(var_02.sharktriggertimes))
		{
			var_02.sharktriggertimes = [];
			for(var_03 = 0;var_03 < level.numsharktriggers;var_03++)
			{
				var_02.sharktriggertimes[var_02.sharktriggertimes.size] = 0;
			}
		}

		var_04 = gettime();
		var_02.sharktriggertimes[param_00] = var_04;
		var_05 = var_04;
		for(var_03 = 0;var_03 < var_02.sharktriggertimes.size;var_03++)
		{
			if(var_02.sharktriggertimes[var_03] < var_05)
			{
				var_05 = var_02.sharktriggertimes[var_03];
			}
		}

		var_06 = 0;
		var_09 = 10000;
		if(var_05 > 0 && var_04 - var_05 < var_09 && !var_06)
		{
			var_02 maps\mp\gametypes\zombies::givezombieachievement("DLC3_ZOMBIE_JUMPTHESHARK");
			var_02.jumpedtheshark = 1;
		}
	}
}

//Function Number: 27
zombiearkrunsharkachievement()
{
	var_00 = getentarray("shark_trigger_static","targetname");
	var_01 = getentarray("shark_trigger_dynamic","targetname");
	var_02 = 0;
	level.numsharktriggers = var_00.size + var_01.size;
	foreach(var_04 in var_00)
	{
		var_04 thread zombiearkrunsharktrigger(var_02,0);
		var_02++;
	}

	foreach(var_04 in var_01)
	{
		var_04 thread zombiearkrunsharktrigger(var_02,1);
		var_02++;
	}
}

//Function Number: 28
zombiearkrunachievements()
{
	level endon("game_ended");
	level thread zombiearkrunsharkachievement();
	foreach(var_01 in level.players)
	{
		var_01 thread zombiearkrunachievementsforplayer();
	}

	for(;;)
	{
		level waittill("connected",var_01);
		var_01 thread zombiearkrunachievementsforplayer();
	}
}

//Function Number: 29
zombiearkrunboatsway()
{
	level endon("game_ended");
	for(;;)
	{
		var_00 = randomfloatrange(0.25,1);
		var_01 = randomfloatrange(3,4);
		level.swayent rotateto((var_00,0,0),var_01,var_01 * 0.5,var_01 * 0.5);
		wait(var_01);
		level.swayent rotateto((0 - var_00,0,0),var_01,var_01 * 0.5,var_01 * 0.5);
		wait(var_01);
	}
}

//Function Number: 30
zombiearkapplyswayentforconditions()
{
	if(maps\mp\zombies\_util::is_true(self.intoxicated))
	{
		return;
	}

	if(maps\mp\zombies\_util::is_true(self.onisland))
	{
		self playersetgroundreferenceent(undefined);
		return;
	}

	if(maps\mp\zombies\_util::is_true(self.boatswaydisabled))
	{
		self playersetgroundreferenceent(undefined);
		return;
	}

	self playersetgroundreferenceent(level.swayent);
}

//Function Number: 31
zombiearksetswayrefent()
{
	self endon("disconnect");
	level endon("game_ended");
	zombiearkapplyswayentforconditions();
	for(;;)
	{
		var_00 = common_scripts\utility::waittill_any_return_no_endon_death("spawned","update_ground_ref_ent");
		if(var_00 == "spawned")
		{
			maps\mp\zombies\_util::waittillplayersnextsnapshot(self);
		}

		zombiearkapplyswayentforconditions();
	}
}

//Function Number: 32
zombiearkboatsway()
{
	level endon("game_ended");
	level.swayent = spawn("script_model",(0,0,0));
	level thread zombiearkrunboatsway();
	foreach(var_01 in level.players)
	{
		var_01 thread zombiearksetswayrefent();
	}

	for(;;)
	{
		level waittill("connected",var_01);
		var_01 thread zombiearksetswayrefent();
	}
}

//Function Number: 33
zombiearkstartgametypelevel()
{
	level thread maps\mp\zombies\_teleport::init();
	level thread maps\mp\zombies\_gambling::init();
	level thread maps\mp\zombies\traps\_trap_turrets::init();
	level thread maps\mp\zombies\traps\_trap_water_floor::init();
	maps\mp\zombies\_traps::register_trap_state_models("dlc_trap_activation_console_01_no_signal","dlc_trap_activation_console_01_ready","dlc_trap_activation_console_01_active","dlc_trap_activation_console_01_cooldown");
	level thread maps\mp\zombies\_util::outofboundswatch(0);
	level thread zombiearkrunachievements();
	level thread zombiearkboatsway();
}

//Function Number: 34
calculatespecialroundtype()
{
	return maps\mp\gametypes\zombies::calculatespecialroundtype();
}

//Function Number: 35
zombiearkchoosespawncharacters()
{
	var_00 = [0,1];
	var_00 = common_scripts\utility::array_randomize(var_00);
	var_01 = [2,3];
	var_01 = common_scripts\utility::array_randomize(var_01);
	var_02 = [var_00,var_01];
	var_02 = common_scripts\utility::array_randomize(var_02);
	level.spawncharindexforplayerindex = [];
	level.spawncharindexforplayerindex[0] = var_02[0][0];
	level.spawncharindexforplayerindex[1] = var_02[0][1];
	level.spawncharindexforplayerindex[2] = var_02[1][0];
	level.spawncharindexforplayerindex[3] = var_02[1][1];
	level.spawnzoneforplayerindex = [];
	if(common_scripts\utility::cointoss())
	{
		level.spawnzoneforplayerindex[0] = "sidebay";
		level.spawnzoneforplayerindex[1] = "sidebay";
		level.spawnzoneforplayerindex[2] = "rearbay";
		level.spawnzoneforplayerindex[3] = "rearbay";
		return;
	}

	level.spawnzoneforplayerindex[0] = "rearbay";
	level.spawnzoneforplayerindex[1] = "rearbay";
	level.spawnzoneforplayerindex[2] = "sidebay";
	level.spawnzoneforplayerindex[3] = "sidebay";
}

//Function Number: 36
zombiearkassignzombieclientid()
{
	if(!isdefined(level.arkconnectedplayers))
	{
		level.arkconnectedplayers = [];
	}

	level.arkconnectedplayers = common_scripts\utility::array_removeundefined(level.arkconnectedplayers);
	level.arkconnectedplayers[level.arkconnectedplayers.size] = self;
	for(var_00 = 0;var_00 < 4;var_00++)
	{
		var_01 = 0;
		foreach(var_03 in level.arkconnectedplayers)
		{
			if(!isdefined(var_03) || isremovedentity(var_03) || var_03 == self)
			{
				continue;
			}

			if(isdefined(var_03.zombieclientid) && var_03.zombieclientid == var_00)
			{
				var_01 = 1;
				break;
			}
		}

		if(!var_01)
		{
			self.zombieclientid = var_00;
			return;
		}
	}
}

//Function Number: 37
zombiearkgivecustomcharacter(param_00)
{
	zombiearkassignzombieclientid();
	var_01 = self.zombieclientid;
	var_01 = int(clamp(var_01,0,3));
	if(!isdefined(level.spawncharindexforplayerindex))
	{
		zombiearkchoosespawncharacters();
	}

	if(isdefined(param_00))
	{
		self.characterindex = param_00;
	}
	else
	{
		self.characterindex = level.spawncharindexforplayerindex[var_01];
	}

	var_03 = 1;
	if(self.characterindex == -1)
	{
		var_03 = 0;
		self.characterindex = 0;
	}

	if(var_03)
	{
		var_02 = "ui_zm_character_" + self.characterindex;
		setomnvar(var_02,self getentitynumber());
		var_04 = "ui_zm_character_" + self.characterindex + "_alive";
		setomnvar(var_04,0);
		thread maps\mp\zombies\_util::resetcharacterondisconnect(var_02,var_04,self.characterindex);
	}

	maps\mp\zombies\_util::setcustomcharacter(self.characterindex,0);
	maps\mp\zombies\_util::setcharacteraudio(self.characterindex);
}

//Function Number: 38
zombiearkfilterstartspawns(param_00)
{
	if(!isplayer(self))
	{
		return param_00;
	}

	var_01 = self.zombieclientid;
	var_01 = int(clamp(var_01,0,3));
	var_02 = level.spawnzoneforplayerindex[var_01];
	var_03 = [];
	foreach(var_05 in param_00)
	{
		if(!isdefined(var_05.script_noteworthy) || var_05.script_noteworthy == var_02)
		{
			var_03[var_03.size] = var_05;
		}
	}

	return var_03;
}

//Function Number: 39
zombiearkfilterrespawns(param_00)
{
	if(!isplayer(self))
	{
		return param_00;
	}

	var_01 = self.zombieclientid;
	var_01 = int(clamp(var_01,0,3));
	var_02 = level.spawnzoneforplayerindex[var_01];
	var_03 = [];
	foreach(var_05 in param_00)
	{
		if(!isdefined(var_05.script_noteworthy) || maps\mp\zombies\_zombies_zone_manager::iszoneenabled(var_05.script_noteworthy) && maps\mp\zombies\_zombies_zone_manager::getzoneconnectionlength(var_05.script_noteworthy,var_02) >= 0)
		{
			var_03[var_03.size] = var_05;
		}
	}

	return var_03;
}

//Function Number: 40
zmbteleportgrenadefindzonecustom(param_00,param_01,param_02)
{
	var_03 = getent("zomboni_room_volume","targetname");
	if(isdefined(var_03) && ispointinvolume(param_02,var_03))
	{
		return "cargo_bay";
	}
}

//Function Number: 41
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

//Function Number: 42
zmteleporterused(param_00)
{
	if(isdefined(self.device))
	{
		playfxontag(common_scripts\utility::getfx("dlc_teleport_in"),self.device,"tag_fx");
		wait(0.3);
	}
}

//Function Number: 43
zmteleporterroomenter(param_00,param_01)
{
	common_scripts\utility::array_thread(param_00,::teleporterfx);
}

//Function Number: 44
teleporterfx()
{
	if(!isdefined(self.teleportchutefx))
	{
		self.teleportchutefx = spawnfxforclient(common_scripts\utility::getfx("dlc_teleport_tunnel_player"),self.origin,self);
		self.teleportchutefx thread teleportfxdelete(self);
	}

	triggerfx(self.teleportchutefx);
}

//Function Number: 45
teleportfxdelete(param_00)
{
	self endon("death");
	param_00 waittill("disconnect");
	self delete();
}

//Function Number: 46
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

//Function Number: 47
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
	param_00 playloopsound("teleporter_hum");
	maps\mp\zombies\_util::stopfxontagnetwork(common_scripts\utility::getfx("dlc_prop_exo_teleport_pwr_off"),param_00,"tag_origin");
	maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("dlc_prop_exo_teleport_pwr_on"),param_00,"tag_origin",0);
}

//Function Number: 48
teleporter_light(param_00)
{
	param_00 setlightcolor((0.941176,0,0));
	param_00 setlightintensity(250);
	self waittill("teleportReady");
	param_00 setlightcolor((0.501961,1,1));
	param_00 setlightintensity(3500);
}

//Function Number: 49
getteleporterlightcoloron()
{
	return (0.501961,1,1);
}

//Function Number: 50
getteleporterlightcolorstandby()
{
	return (0.941176,0,0);
}

//Function Number: 51
getteleporterlightcoloroff()
{
	return (0.941176,0,0);
}

//Function Number: 52
getteleporterlightintensityon()
{
	return 3500;
}

//Function Number: 53
getteleporterlightintensitystandby()
{
	return 250;
}

//Function Number: 54
getteleporterlightintensityoff()
{
	return 0.001;
}

//Function Number: 55
doidlesharkanimations()
{
	var_00 = getentarray("shark_animated","targetname");
	foreach(var_02 in var_00)
	{
		var_02 scriptmodelplayanim("zom_ark_shark_cage_idle","shark_notetrack");
		var_02 thread maps\mp\mp_zombie_ark_aud::idle_shark_sound();
		wait(2);
	}
}

//Function Number: 56
killglass()
{
	while(!isdefined(level.players))
	{
		wait(0.05);
	}

	var_00 = [];
	for(var_01 = 0;var_01 <= 1;var_01++)
	{
		var_02 = getglass("ark_glass_" + var_01);
		var_03 = getent("ark_glass_trigger_" + var_01,"targetname");
		if(isdefined(var_02) && isdefined(var_03))
		{
			var_00[var_01] = [var_02,var_03];
		}
	}

	for(;;)
	{
		for(var_01 = 0;var_01 < var_00.size;var_01++)
		{
			var_04 = var_00[var_01];
			if(isglassdestroyed(var_04[0]))
			{
				var_00[var_01] = var_00[var_00.size - 1];
				var_00[var_00.size - 1] = undefined;
				var_01--;
			}
		}

		if(var_00.size == 0)
		{
			return;
		}

		foreach(var_06 in level.players)
		{
			if(!isalive(var_06) || var_06.sessionstate == "spectator" || var_06.sessionstate == "intermission")
			{
				continue;
			}

			if(maps\mp\zombies\_util::is_true(var_06.validnotmoving))
			{
				foreach(var_04 in var_00)
				{
					if(var_06 istouching(var_04[1]))
					{
						destroyglass(var_04[0]);
					}
				}
			}
		}

		wait(1);
	}
}

//Function Number: 57
agentshouldragdollimmediately(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	return isdefined(param_04) && param_04 == "repulsor_zombie_mp" || param_04 == "zombie_water_trap_mp";
}

//Function Number: 58
flyoverbink()
{
	var_00 = "zombie_bink_env_camera_DLC3";
	var_01 = "scr_" + var_00;
	setdvar(var_01,0);
	var_02 = "devgui_cmd \"Zombie:2/Toggle Flyover Binks/" + var_00 + "\" \"togglep " + var_01 + " 0 1\";";
	thread setupflyoveranimation("zombie_bink_env_camera_DLC3","j_prop_1",["open_doors","trigger_decontamination"],var_01);
}

//Function Number: 59
setupflyoveranimation(param_00,param_01,param_02,param_03)
{
	var_04 = common_scripts\utility::getstruct("shark_anim_node","targetname");
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

//Function Number: 60
donotetrack(param_00,param_01,param_02,param_03)
{
	param_00 endon("notetrackDone");
	param_00 waittillmatch(param_02,param_01);
	if(param_02 == "trigger_decontamination")
	{
		var_04 = getentarray("perk_terminal","targetname");
		foreach(var_06 in var_04)
		{
			if(var_06.trigger.itemtype == "host_cure")
			{
				var_06.trigger thread maps\mp\zombies\_terminals::perkterminalactivatehostcure(5);
			}
		}
	}
	else if(param_02 == "open_doors")
	{
		foreach(var_09 in level.zombiedoors)
		{
			var_09 notify("open",level.player);
		}
	}

	level notify(param_02);
}

//Function Number: 61
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

//Function Number: 62
exoreveal()
{
	level waittill("power_cargo_01");
	foreach(var_01 in level.terminals["exo_suit"])
	{
		if(maps\mp\zombies\_util::isusetriggerprimary(var_01))
		{
			maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("exo_reveal"),var_01.modelent,"tag_origin");
		}
	}
}

//Function Number: 63
spawnpatchclipfixes()
{
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(68,-773,1088),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(68,-773,1344),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(-1168,-1898,1456),(0,90,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(-1168,-1874,1456),(0,90,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(-1168,-1852,1456),(0,90,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(-1168,-1178,1456),(0,90,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(-1168,-1154,1456),(0,90,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(-1168,-1132,1456),(0,90,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64",(-1634.5,1281,928),(0,90,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_128_128",(-1891,1075,824),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_128_128",(-1891,1075,867),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64",(-924,338,1267.5),(0,90,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64",(-924,338,1203.5),(0,90,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64",(-924,338,1159.5),(0,90,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64",(264,2532,961),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64",(264,2526,961),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64",(264,2532,1025),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64",(264,2526,1025),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64",(264,2532,1089),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64",(264,2526,1089),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64",(264,2532,1147),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64",(264,2526,1147),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64",(1434,-74.5,864),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64",(1434,-94.5,864),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64",(1434,-74.5,928),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64",(1434,-94.5,928),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64",(1434,-74.5,992),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64",(1434,-94.5,992),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64",(1434,-74.5,1056),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64",(1434,-94.5,1056),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(1088,768,848),(0,225,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(1088,64,848),(0,315,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64",(316,619,1030),(360,228.599,46.1996));
}

//Function Number: 64
zombiearkpatchshove(param_00,param_01)
{
	if(param_01)
	{
		if(self.currentzone == "sidebay")
		{
			if(self.origin[2] >= 1010 && self.origin[2] <= 1012)
			{
				if(self.origin[0] >= -1670 && self.origin[0] <= -1625 && self.origin[1] >= -693 && self.origin[1] <= -446)
				{
					self setvelocity((200,0,0));
				}
			}

			if(self.origin[2] >= 1073 && self.origin[2] <= 1075)
			{
				if(self.origin[0] >= -1080 && self.origin[0] <= -970 && self.origin[1] >= -1985 && self.origin[1] <= -1975)
				{
					self setvelocity((0,-200,0));
				}
			}

			if(distancesquared(self.origin,(-1136,-1982,1095)) < 144)
			{
				self setvelocity((0,-200,0));
				return;
			}

			return;
		}

		if(self.currentzone == "armory")
		{
			if(distancesquared(self.origin,(-1036,1057,1127)) < 144)
			{
				var_02 = self getnearestnode();
				if(isdefined(var_02) && abs(var_02.origin[2] - self.origin[2]) > 120)
				{
					var_03 = vectornormalize(var_02.origin - self.origin * (1,1,0));
					self setvelocity(var_03 * 100);
					return;
				}

				return;
			}

			return;
		}

		if(self.currentzone == "rearbay")
		{
			if(distancesquared(self.origin,(-757,-1167,879)) < 144)
			{
				self setvelocity((-200,0,0));
			}

			if(distancesquared(self.origin,(-867,-2016,1120)) < 144)
			{
				self setvelocity((200,0,0));
				return;
			}

			return;
		}

		return;
	}
}