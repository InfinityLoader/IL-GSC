/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\killstreaks\_helicopter.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: PC
 * Function Count: 86
 * Decompile Time: 1235 ms
 * Timestamp: 10/27/2023 3:00:40 AM
*******************************************************************/

#include common_scripts/utility;
#include maps/mp/_challenges;
#include maps/mp/_heatseekingmissile;
#include maps/mp/_scoreevents;
#include maps/mp/_treadfx;
#include maps/mp/_utility;
#include maps/mp/gametypes/_damagefeedback;
#include maps/mp/gametypes/_globallogic_player;
#include maps/mp/gametypes/_hostmigration;
#include maps/mp/gametypes/_hud_util;
#include maps/mp/gametypes/_spawning;
#include maps/mp/gametypes/_tweakables;
#include maps/mp/gametypes/_weaponobjects;
#include maps/mp/killstreaks/_airsupport;
#include maps/mp/killstreaks/_dogs;
#include maps/mp/killstreaks/_killstreakrules;
#include maps/mp/killstreaks/_killstreaks;

#using_animtree( "mp_vehicles" );

//Function Number: 1
precachehelicopter(model,type)
{
	if(!(IsDefined(type)))
	{
		type = "blackhawk";
	}

	precachemodel(model);
	level.vehicle_deathmodel[model] = model;
	precacheitem("cobra_20mm_mp");
	precacheitem("cobra_20mm_comlink_mp");
	precachestring(&"MP_DESTROYED_HELICOPTER");
	precachestring(&"KILLSTREAK_DESTROYED_HELICOPTER_GUNNER");
	level.cobra_missile_models = [];
	level.cobra_missile_models["cobra_Hellfire"] = "projectile_hellfire_missile";
	precachemodel(level.cobra_missile_models["cobra_Hellfire"]);
	level.heli_sound["hit"] = "evt_helicopter_hit";
	level.heli_sound["hitsecondary"] = "evt_helicopter_hit";
	level.heli_sound["damaged"] = "null";
	level.heli_sound["spinloop"] = "evt_helicopter_spin_loop";
	level.heli_sound["spinstart"] = "evt_helicopter_spin_start";
	level.heli_sound["crash"] = "evt_helicopter_midair_exp";
	level.heli_sound["missilefire"] = "wpn_hellfire_fire_npc";
	maps/mp/_treadfx::preloadtreadfx("helicopter_player_mp");
	maps/mp/_treadfx::preloadtreadfx("heli_ai_mp");
	maps/mp/_treadfx::preloadtreadfx("heli_player_gunner_mp");
	maps/mp/_treadfx::preloadtreadfx("heli_guard_mp");
	maps/mp/_treadfx::preloadtreadfx("heli_supplydrop_mp");
}

//Function Number: 2
usekillstreakhelicopter(hardpointtype)
{
	if(self maps/mp/killstreaks/_killstreakrules::iskillstreakallowed(hardpointtype,self.team) == 0)
	{
		return 0;
	}

	if(!IsDefined(level.heli_paths) || !level.heli_paths.size)
	{
		iprintlnbold("Need to add helicopter paths to the level");
		return 0;
	}

	if(hardpointtype == "helicopter_comlink_mp")
	{
		result = self selecthelicopterlocation(hardpointtype);
		if(!IsDefined(result) || result == 0)
		{
			return 0;
		}
	}

	destination = 0;
	missilesenabled = 0;
	if(hardpointtype == "helicopter_x2_mp")
	{
		missilesenabled = 1;
	}

/#
	assert(level.heli_paths.size > 0,"No non-primary helicopter paths found in map");
#/
	random_path = randomint(level.heli_paths[destination].size);
	startnode = level.heli_paths[destination][random_path];
	protectlocation = undefined;
	armored = 0;
	if(hardpointtype == "helicopter_comlink_mp")
	{
		protectlocation = (level.helilocation[0],level.helilocation[1],int(maps/mp/killstreaks/_airsupport::getminimumflyheight()));
		armored = 0;
		startnode = getvalidprotectlocationstart(random_path,protectlocation,destination);
	}

	killstreak_id = self maps/mp/killstreaks/_killstreakrules::killstreakstart(hardpointtype,self.team);
	if(killstreak_id == -1)
	{
		return 0;
	}

	self thread announcehelicopterinbound(hardpointtype);
	thread heli_think(self,startnode,self.team,missilesenabled,protectlocation,hardpointtype,armored,killstreak_id);
	return 1;
}

//Function Number: 3
announcehelicopterinbound(hardpointtype)
{
	team = self.team;
	self maps/mp/killstreaks/_killstreaks::playkillstreakstartdialog(hardpointtype,team,1);
	level.globalkillstreakscalled++;
	self addweaponstat(hardpointtype,"used",1);
}

//Function Number: 4
heli_path_graph()
{
	path_start = getentarray("heli_start","targetname");
	path_dest = getentarray("heli_dest","targetname");
	loop_start = getentarray("heli_loop_start","targetname");
	gunner_loop_start = getentarray("heli_gunner_loop_start","targetname");
	leave_nodes = getentarray("heli_leave","targetname");
	crash_start = getentarray("heli_crash_start","targetname");
/#
	assert(IsDefined(path_start) && IsDefined(path_dest),"Missing path_start or path_dest");
#/
	for(i = 0;i < path_dest.size;i++)
	{
		startnode_array = [];
		isprimarydest = 0;
		destnode_pointer = path_dest[i];
		destnode = getent(destnode_pointer.target,"targetname");
		for(j = 0;j < path_start.size;j++)
		{
			todest = 0;
			for(currentnode = path_start[j];IsDefined(currentnode.target);currentnode = nextnode)
			{
				nextnode = getent(currentnode.target,"targetname");
				if(nextnode.origin == destnode.origin)
				{
					todest = 1;
					break;
				}

				debug_print3d_simple("+",currentnode,VectorScale((0,0,-1)));
				if(IsDefined(nextnode.target))
				{
					debug_line(nextnode.origin,getent(nextnode.target,"targetname").origin,(0.25,0.5,0.25),5);
				}

				if(IsDefined(currentnode.script_delay))
				{
					debug_print3d_simple("Wait: " + currentnode.script_delay,currentnode,VectorScale((0,0,1)));
				}
			}

			if(todest)
			{
				startnode_array[startnode_array.size] = getent(path_start[j].target,"targetname");
				if(IsDefined(path_start[j].script_noteworthy) && path_start[j].script_noteworthy == "primary")
				{
					isprimarydest = 1;
				}
			}
		}

/#
		assert(IsDefined(startnode_array) && startnode_array.size > 0,"No path(s) to destination");
#/
		if(isprimarydest)
		{
			level.heli_primary_path = startnode_array;
		}
		else
		{
			level.heli_paths[level.heli_paths.size] = startnode_array;
		}
	}

	for(i = 0;i < loop_start.size;i++)
	{
		startnode = getent(loop_start[i].target,"targetname");
		level.heli_loop_paths[level.heli_loop_paths.size] = startnode;
	}

/#
	assert(IsDefined(level.heli_loop_paths[0]),"No helicopter loop paths found in map");
#/
	for(i = 0;i < gunner_loop_start.size;i++)
	{
		startnode = getent(gunner_loop_start[i].target,"targetname");
		startnode.isgunnerpath = 1;
		level.heli_loop_paths[level.heli_loop_paths.size] = startnode;
	}

	for(i = 0;i < leave_nodes.size;i++)
	{
		level.heli_leavenodes[level.heli_leavenodes.size] = leave_nodes[i];
	}

/#
	assert(IsDefined(level.heli_leavenodes[0]),"No helicopter leave nodes found in map");
#/
	for(i = 0;i < crash_start.size;i++)
	{
		crash_start_node = getent(crash_start[i].target,"targetname");
		level.heli_crash_paths[level.heli_crash_paths.size] = crash_start_node;
	}

/#
	assert(IsDefined(level.heli_crash_paths[0]),"No helicopter crash paths found in map");
#/
}

//Function Number: 5
init()
{
	path_start = getentarray("heli_start","targetname");
	loop_start = getentarray("heli_loop_start","targetname");
	thread heli_update_global_dvars();
	level.chaff_offset["attack"] = (-130,0,-140);
	level.choppercomlinkfriendly = "veh_t6_air_attack_heli_mp_light";
	level.choppercomlinkenemy = "veh_t6_air_attack_heli_mp_dark";
	level.chopperregular = "veh_t6_air_attack_heli_mp_dark";
	precachehelicopter(level.chopperregular);
	precachehelicopter(level.choppercomlinkfriendly);
	precachehelicopter(level.choppercomlinkenemy);
	precachevehicle("heli_ai_mp");
	registerclientfield("helicopter","heli_comlink_bootup_anim",1,1,"int");
	level.heli_paths = [];
	level.heli_loop_paths = [];
	level.heli_leavenodes = [];
	level.heli_crash_paths = [];
	level.chopper_fx["explode"]["death"] = loadfx("vehicle/vexplosion/fx_vexplode_helicopter_exp_mp");
	level.chopper_fx["explode"]["guard"] = loadfx("vehicle/vexplosion/fx_vexplode_heli_sm_exp_mp");
	level.chopper_fx["explode"]["gunner"] = loadfx("vehicle/vexplosion/fx_vexplode_vtol_mp");
	level.chopper_fx["explode"]["large"] = loadfx("vehicle/vexplosion/fx_vexplode_heli_killstreak_exp_sm");
	level.chopper_fx["damage"]["light_smoke"] = loadfx("trail/fx_trail_heli_killstreak_engine_smoke_33");
	level.chopper_fx["damage"]["heavy_smoke"] = loadfx("trail/fx_trail_heli_killstreak_engine_smoke_66");
	level.chopper_fx["smoke"]["trail"] = loadfx("trail/fx_trail_heli_killstreak_tail_smoke");
	level.chopper_fx["fire"]["trail"]["large"] = loadfx("trail/fx_trail_heli_killstreak_engine_smoke");
	level._effect["heli_comlink_light"]["friendly"] = loadfx("light/fx_vlight_mp_attack_heli_grn");
	level._effect["heli_comlink_light"]["enemy"] = loadfx("light/fx_vlight_mp_attack_heli_red");
	level.helicomlinkbootupanim = %veh_anim_future_heli_gearup_bay_open;
	if(!path_start.size && !loop_start.size)
	{
		return;
	}

	heli_path_graph();
	precachelocationselector("compass_objpoint_helicopter");
	if(maps/mp/gametypes/_tweakables::gettweakablevalue("killstreak","allowhelicopter_comlink"))
	{
		maps/mp/killstreaks/_killstreaks::registerkillstreak("helicopter_comlink_mp","helicopter_comlink_mp","killstreak_helicopter_comlink","helicopter_used",::usekillstreakhelicopter,1);
		maps/mp/killstreaks/_killstreaks::registerkillstreakstrings("helicopter_comlink_mp",&"KILLSTREAK_EARNED_HELICOPTER_COMLINK",&"KILLSTREAK_HELICOPTER_COMLINK_NOT_AVAILABLE",&"KILLSTREAK_HELICOPTER_COMLINK_INBOUND");
		maps/mp/killstreaks/_killstreaks::registerkillstreakdialog("helicopter_comlink_mp","mpl_killstreak_heli","kls_cobra_used","","kls_cobra_enemy","","kls_cobra_ready");
		maps/mp/killstreaks/_killstreaks::registerkillstreakdevdvar("helicopter_comlink_mp","scr_givehelicopter_comlink");
		maps/mp/killstreaks/_killstreaks::registerkillstreakaltweapon("helicopter_comlink_mp","cobra_20mm_comlink_mp");
		maps/mp/killstreaks/_killstreaks::setkillstreakteamkillpenaltyscale("helicopter_comlink_mp",0);
	}
}

//Function Number: 6
heli_update_global_dvars()
{
	for(;;)
	{
		level.heli_loopmax = heli_get_dvar_int("scr_heli_loopmax","2");
		level.heli_missile_rof = heli_get_dvar_int("scr_heli_missile_rof","2");
		level.heli_armor = heli_get_dvar_int("scr_heli_armor","500");
		level.heli_maxhealth = heli_get_dvar_int("scr_heli_maxhealth","1000");
		level.heli_amored_maxhealth = heli_get_dvar_int("scr_heli_armored_maxhealth","1500");
		level.heli_missile_max = heli_get_dvar_int("scr_heli_missile_max","20");
		level.heli_dest_wait = heli_get_dvar_int("scr_heli_dest_wait","8");
		level.heli_debug = heli_get_dvar_int("scr_heli_debug","0");
		level.heli_debug_crash = heli_get_dvar_int("scr_heli_debug_crash","0");
		level.heli_targeting_delay = heli_get_dvar("scr_heli_targeting_delay","0.6");
		level.heli_turretreloadtime = heli_get_dvar("scr_heli_turretReloadTime","1.5");
		level.heli_turretclipsize = heli_get_dvar_int("scr_heli_turretClipSize","20");
		level.heli_visual_range = heli_get_dvar_int("scr_heli_visual_range","3500");
		level.heli_missile_range = heli_get_dvar_int("scr_heli_missile_range","100000");
		level.heli_health_degrade = heli_get_dvar_int("scr_heli_health_degrade","0");
		level.heli_turret_angle_tan = heli_get_dvar_int("scr_heli_turret_angle_tan","1");
		level.heli_turret_target_cone = heli_get_dvar("scr_heli_turret_target_cone","0.6");
		level.heli_target_spawnprotection = heli_get_dvar_int("scr_heli_target_spawnprotection","5");
		level.heli_missile_regen_time = heli_get_dvar("scr_heli_missile_regen_time","10");
		level.heli_turret_spinup_delay = heli_get_dvar("scr_heli_turret_spinup_delay","0.7");
		level.heli_target_recognition = heli_get_dvar("scr_heli_target_recognition","0.5");
		level.heli_missile_friendlycare = heli_get_dvar_int("scr_heli_missile_friendlycare","512");
		level.heli_missile_target_cone = heli_get_dvar("scr_heli_missile_target_cone","0.6");
		level.heli_valid_target_cone = heli_get_dvar("scr_heli_missile_valid_target_cone","0.7");
		level.heli_armor_bulletdamage = heli_get_dvar("scr_heli_armor_bulletdamage","0.5");
		level.heli_attract_strength = heli_get_dvar("scr_heli_attract_strength","1000");
		level.heli_attract_range = heli_get_dvar("scr_heli_attract_range","20000");
		level.helicopterturretmaxangle = heli_get_dvar_int("scr_helicopterTurretMaxAngle","35");
		level.heli_protect_time = heli_get_dvar("scr_heli_protect_time","60");
		level.heli_protect_pos_time = heli_get_dvar("scr_heli_protect_pos_time","12");
		level.heli_protect_radius = heli_get_dvar_int("scr_heli_protect_radius","2000");
		level.heli_missile_reload_time = heli_get_dvar("scr_heli_missile_reload_time","5.0");
		level.heli_warning_distance = heli_get_dvar_int("scr_heli_warning_distance","500");
		wait(1);
	}
}

//Function Number: 7
heli_get_dvar_int(dvar,def)
{
	return int(heli_get_dvar(dvar,def));
}

//Function Number: 8
heli_get_dvar(dvar,def)
{
	if(GetDvar(dvar) != "")
	{
		return GetDvarFloat(dvar);
	}
	else
	{
		setdvar(dvar,def);
		return def;
	}
}

//Function Number: 9
spawn_helicopter(owner,origin,angles,model,targetname,target_offset,hardpointtype,killstreak_id)
{
	chopper = spawnhelicopter(owner,origin,angles,model,targetname);
	chopper.attackers = [];
	chopper.attackerdata = [];
	chopper.attackerdamage = [];
	chopper.flareattackerdamage = [];
	chopper.destroyfunc = ::destroyhelicopter;
	chopper.hardpointtype = hardpointtype;
	chopper.killstreak_id = killstreak_id;
	chopper.pilotistalking = 0;
	chopper setdrawinfrared(1);
	if(!(IsDefined(target_offset)))
	{
		target_offset = (0,0,0);
	}

	target_set(chopper,target_offset);
	chopper.pilotvoicenumber = self.bcvoicenumber - 1;
	if(chopper.pilotvoicenumber < 0)
	{
		chopper.pilotvoicenumber = 3;
	}

	owner.pilottalking = 0;
	if(hardpointtype == "helicopter_player_gunner_mp")
	{
		chopper thread playpilotdialog("a10_used",2.5);
	}
	else
	{
		chopper thread playpilotdialog("attackheli_approach",2.5);
	}

	chopper.soundmod = "heli";
	return chopper;
}

//Function Number: 10
explodeoncontact(hardpointtype)
{
	self endon("death");
	wait(10);
	for(;;)
	{
		self waittill("touch");
		self thread heli_explode();
	}
}

//Function Number: 11
getvalidprotectlocationstart(random_path,protectlocation,destination)
{
	startnode = level.heli_paths[destination][random_path];
	path_index = random_path + 1 % level.heli_paths[destination].size;
	innofly = crossesnoflyzone(protectlocation + (0,0,1),protectlocation);
	if(IsDefined(innofly))
	{
		protectlocation = (protectlocation[0],protectlocation[1],level.noflyzones[innofly].origin[2] + level.noflyzones[innofly].height);
	}

	noflyzone = crossesnoflyzone(startnode.origin,protectlocation);
	while(IsDefined(noflyzone) && path_index != random_path)
	{
		startnode = level.heli_paths[destination][path_index];
		noflyzone = crossesnoflyzone(startnode.origin,protectlocation);
		if(IsDefined(noflyzone))
		{
			path_index = path_index + 1 % level.heli_paths[destination].size;
		}
	}

	return level.heli_paths[destination][path_index];
}

//Function Number: 12
getvalidrandomleavenode(start)
{
	random_leave_node = randomint(level.heli_leavenodes.size);
	leavenode = level.heli_leavenodes[random_leave_node];
	path_index = random_leave_node + 1 % level.heli_leavenodes.size;
	noflyzone = crossesnoflyzone(leavenode.origin,start);
	while(IsDefined(noflyzone) && path_index != random_leave_node)
	{
		leavenode = level.heli_leavenodes[path_index];
		noflyzone = crossesnoflyzone(leavenode.origin,start);
		path_index = path_index + 1 % level.heli_leavenodes.size;
	}

	return level.heli_leavenodes[path_index];
}

//Function Number: 13
getvalidrandomcrashnode(start)
{
	random_leave_node = randomint(level.heli_crash_paths.size);
	leavenode = level.heli_crash_paths[random_leave_node];
	path_index = random_leave_node + 1 % level.heli_crash_paths.size;
	noflyzone = crossesnoflyzone(leavenode.origin,start);
	while(IsDefined(noflyzone) && path_index != random_leave_node)
	{
		leavenode = level.heli_crash_paths[path_index];
		noflyzone = crossesnoflyzone(leavenode.origin,start);
		path_index = path_index + 1 % level.heli_crash_paths.size;
	}

	return level.heli_crash_paths[path_index];
}

//Function Number: 14
heli_think(owner,startnode,heli_team,missilesenabled,protectlocation,hardpointtype,armored,killstreak_id)
{
	heliorigin = startnode.origin;
	heliangles = startnode.angles;
	if(hardpointtype == "helicopter_comlink_mp")
	{
		choppermodelfriendly = level.choppercomlinkfriendly;
		choppermodelenemy = level.choppercomlinkenemy;
	}
	else
	{
		choppermodelfriendly = level.chopperregular;
		choppermodelenemy = level.chopperregular;
	}

	chopper = spawn_helicopter(owner,heliorigin,heliangles,"heli_ai_mp",choppermodelfriendly,VectorScale((0,0,-1)),100,hardpointtype);
	chopper setenemymodel(choppermodelenemy);
	chopper thread watchforearlyleave(hardpointtype);
	target_setturretaquire(chopper,0);
	chopper thread samturretwatcher();
	if(hardpointtype == "helicopter_comlink_mp")
	{
		chopper.defaultweapon = "cobra_20mm_comlink_mp";
	}
	else
	{
		chopper.defaultweapon = "cobra_20mm_mp";
	}

	chopper.requireddeathcount = owner.deathcount;
	chopper.chaff_offset = level.chaff_offset["attack"];
	minigun_snd_ent = spawn("script_origin",chopper gettagorigin("tag_flash"));
	minigun_snd_ent linkto(chopper,"tag_flash",(0,0,0),(0,0,0));
	chopper.minigun_snd_ent = minigun_snd_ent;
	minigun_snd_ent thread autostopsound();
	chopper.team = heli_team;
	chopper setteam(heli_team);
	chopper.owner = owner;
	chopper setowner(owner);
	chopper thread heli_existance();
	level.chopper = chopper;
	chopper.reached_dest = 0;
	if(armored)
	{
		chopper.maxhealth = level.heli_amored_maxhealth;
	}
	else
	{
		chopper.maxhealth = level.heli_maxhealth;
	}

	chopper.rocketdamageoneshot = level.heli_maxhealth + 1;
	chopper.rocketdamagetwoshot = level.heli_maxhealth / 2 + 1;
	if(hardpointtype == "helicopter_comlink_mp" || hardpointtype == "helicopter_guard_mp")
	{
		chopper.numflares = 1;
	}
	else
	{
		chopper.numflares = 2;
	}

	chopper.flareoffset = VectorScale((0,0,-1));
	chopper.waittime = level.heli_dest_wait;
	chopper.loopcount = 0;
	chopper.evasive = 0;
	chopper.health_bulletdamageble = level.heli_armor;
	chopper.health_evasive = level.heli_armor;
	chopper.health_low = chopper.maxhealth * 0.8;
	chopper.targeting_delay = level.heli_targeting_delay;
	chopper.primarytarget = undefined;
	chopper.secondarytarget = undefined;
	chopper.attacker = undefined;
	chopper.missile_ammo = level.heli_missile_max;
	chopper.currentstate = "ok";
	chopper.lastrocketfiretime = -1;
	if(IsDefined(protectlocation))
	{
		chopper thread heli_protect(startnode,protectlocation,hardpointtype,heli_team);
		chopper setclientfield("heli_comlink_bootup_anim",1);
	}
	else
	{
		chopper thread heli_fly(startnode,2,hardpointtype);
	}

	chopper thread heli_damage_monitor(hardpointtype);
	chopper thread heli_kill_monitor(hardpointtype);
	chopper thread heli_health(hardpointtype,owner);
	chopper thread attack_targets(missilesenabled,hardpointtype);
	chopper thread heli_targeting(missilesenabled,hardpointtype);
	chopper thread heli_missile_regen();
	chopper thread maps/mp/_heatseekingmissile::missiletarget_proximitydetonateincomingmissile("crashing","death");
	chopper thread create_flare_ent(VectorScale((0,0,-1)));
	chopper maps/mp/gametypes/_spawning::create_helicopter_influencers(heli_team);
}

//Function Number: 15
autostopsound()
{
	self endon("death");
	level waittill("game_ended");
	self stoploopsound();
}

//Function Number: 16
heli_existance()
{
	self waittill("leaving");
	self maps/mp/gametypes/_spawning::remove_helicopter_influencers();
}

//Function Number: 17
create_flare_ent(offset)
{
	self.flare_ent = spawn("script_model",self gettagorigin("tag_origin"));
	self.flare_ent setmodel("tag_origin");
	self.flare_ent linkto(self,"tag_origin",offset);
}

//Function Number: 18
heli_missile_regen()
{
	self endon("death");
	self endon("crashing");
	self endon("leaving");
	for(;;)
	{
		debug_print3d("Missile Ammo: " + self.missile_ammo,(0.5,0.5,1),self,VectorScale((0,0,-1)),100);
		if(self.missile_ammo >= level.heli_missile_max)
		{
			self waittill(0,"missile fired");
		}
		else if(self.currentstate == "heavy smoke")
		{
			wait(level.heli_missile_regen_time / 4);
		}
		else if(self.currentstate == "light smoke")
		{
			wait(level.heli_missile_regen_time / 2);
		}
		else
		{
			wait(level.heli_missile_regen_time);
		}

		if(self.missile_ammo < level.heli_missile_max)
		{
			self.missile_ammo++;
		}
	}
}

//Function Number: 19
heli_targeting(missilesenabled,hardpointtype)
{
	self endon("death");
	self endon("crashing");
	self endon("leaving");
	for(;;)
	{
		targets = [];
		targetsmissile = [];
		players = level.players;
		for(i = 0;i < players.size;i++)
		{
			player = players[i];
			if(self cantargetplayer_turret(player,hardpointtype))
			{
				if(IsDefined(player))
				{
					targets[targets.size] = player;
				}
			}

			if(missilesenabled && self cantargetplayer_missile(player,hardpointtype))
			{
				if(IsDefined(player))
				{
					targetsmissile[targetsmissile.size] = player;
				}
			}
			else
			{
			}
		}

		dogs = maps/mp/killstreaks/_dogs::dog_manager_get_dogs();
		foreach(dog in dogs)
		{
			if(self cantargetdog_turret(dog))
			{
				targets[targets.size] = dog;
			}

			if(missilesenabled && self cantargetdog_missile(dog))
			{
				targetsmissile[targetsmissile.size] = dog;
			}
		}

		tanks = getentarray("talon","targetname");
		foreach(tank in tanks)
		{
			if(self cantargettank_turret(tank))
			{
				targets[targets.size] = tank;
			}
		}

		if(targets.size == 0 && targetsmissile.size == 0)
		{
			self.primarytarget = undefined;
			self.secondarytarget = undefined;
			debug_print_target();
			self setgoalyaw(randomint(360));
			wait(self.targeting_delay);
			continue;
		}

		if(targets.size == 1)
		{
			if(IsDefined(targets[0].type) && targets[0].type == "dog" || targets[0].type == "tank_drone")
			{
				update_dog_threat(targets[0]);
			}
			else
			{
				update_player_threat(targets[0]);
			}

			self.primarytarget = targets[0];
			self notify("primary acquired",_k670,_k656,Stack-Empty ? Stack-Empty : Stack-Empty);
			self.secondarytarget = undefined;
			debug_print_target();
		}
		else if(targets.size > 1)
		{
			assignprimarytargets(targets);
		}

		if(targetsmissile.size == 1)
		{
			if(!IsDefined(targetsmissile[0].type) || targetsmissile[0].type != "dog" || targets[0].type == "tank_drone")
			{
				self update_missile_player_threat(targetsmissile[0]);
			}
			else if(targetsmissile[0].type == "dog")
			{
				self update_missile_dog_threat(targetsmissile[0]);
			}

			self.secondarytarget = targetsmissile[0];
			self notify("secondary acquired");
			debug_print_target();
		}
		else if(targetsmissile.size > 1)
		{
			assignsecondarytargets(targetsmissile);
		}

		wait(self.targeting_delay);
		debug_print_target();
	}
}

//Function Number: 20
cantargetplayer_turret(player,hardpointtype)
{
	cantarget = 1;
	if(!isalive(player) || player.sessionstate != "playing")
	{
		return 0;
	}

	if(player == self.owner)
	{
		self check_owner(hardpointtype);
		return 0;
	}

	if(player cantargetplayerwithspecialty() == 0)
	{
		return 0;
	}

	if(distance(player.origin,self.origin) > level.heli_visual_range)
	{
		return 0;
	}

	if(!(IsDefined(player.team)))
	{
		return 0;
	}

	if(level.teambased && player.team == self.team)
	{
		return 0;
	}

	if(player.team == "spectator")
	{
		return 0;
	}

	if(IsDefined(player.spawntime) && GetTime() - player.spawntime / 1000 <= level.heli_target_spawnprotection)
	{
		return 0;
	}

	heli_centroid = 160 + VectorScale((0,0,-1));
	heli_forward_norm = AnglesToForward(self.angles);
	heli_turret_point = heli_centroid + 144 * heli_forward_norm;
	visible_amount = player sightconetrace(heli_turret_point,self);
	if(visible_amount < level.heli_target_recognition)
	{
		return 0;
	}
}

//Function Number: 21
getverticaltan(startorigin,endorigin)
{
	vector = endorigin - startorigin;
	opposite = startorigin[2] - endorigin[2];
	if(opposite < 0)
	{
		opposite = opposite * 1;
	}

	adjacent = distance2d(startorigin,endorigin);
	if(adjacent < 0)
	{
		adjacent = adjacent * 1;
	}

	if(adjacent < 0.01)
	{
		adjacent = 0.01;
	}

	tangent = opposite / adjacent;
	return tangent;
}

//Function Number: 22
cantargetplayer_missile(player,hardpointtype)
{
	cantarget = 1;
	if(!isalive(player) || player.sessionstate != "playing")
	{
		return 0;
	}

	if(player == self.owner)
	{
		self check_owner(hardpointtype);
		return 0;
	}

	if(player cantargetplayerwithspecialty() == 0)
	{
		return 0;
	}

	if(distance(player.origin,self.origin) > level.heli_missile_range)
	{
		return 0;
	}

	if(!(IsDefined(player.team)))
	{
		return 0;
	}

	if(level.teambased && player.team == self.team)
	{
		return 0;
	}

	if(player.team == "spectator")
	{
		return 0;
	}

	if(IsDefined(player.spawntime) && GetTime() - player.spawntime / 1000 <= level.heli_target_spawnprotection)
	{
		return 0;
	}

	if(self target_cone_check(player,level.heli_missile_target_cone) == 0)
	{
		return 0;
	}

	heli_centroid = 160 + VectorScale((0,0,-1));
	heli_forward_norm = AnglesToForward(self.angles);
	heli_turret_point = heli_centroid + 144 * heli_forward_norm;
	if(!(IsDefined(player.lasthit)))
	{
		player.lasthit = 0;
	}

	player.lasthit = self heliturretsighttrace(heli_turret_point,player,player.lasthit);
	if(player.lasthit != 0)
	{
		return 0;
	}

	return cantarget;
}

//Function Number: 23
cantargetdog_turret(dog)
{
	cantarget = 1;
	if(!(IsDefined(dog)))
	{
		return 0;
	}

	if(distance(dog.origin,self.origin) > level.heli_visual_range)
	{
		return 0;
	}

	if(!(IsDefined(dog.aiteam)))
	{
		return 0;
	}

	if(level.teambased && dog.aiteam == self.team)
	{
		return 0;
	}

	if(IsDefined(dog.script_owner) && self.owner == dog.script_owner)
	{
		return 0;
	}

	heli_centroid = 160 + VectorScale((0,0,-1));
	heli_forward_norm = AnglesToForward(self.angles);
	heli_turret_point = heli_centroid + 144 * heli_forward_norm;
	if(!(IsDefined(dog.lasthit)))
	{
		dog.lasthit = 0;
	}

	dog.lasthit = self heliturretdogtrace(heli_turret_point,dog,dog.lasthit);
	if(dog.lasthit != 0)
	{
		return 0;
	}

	return cantarget;
}

//Function Number: 24
cantargetdog_missile(dog)
{
	cantarget = 1;
	if(!(IsDefined(dog)))
	{
		return 0;
	}

	if(distance(dog.origin,self.origin) > level.heli_missile_range)
	{
		return 0;
	}

	if(!(IsDefined(dog.aiteam)))
	{
		return 0;
	}

	if(level.teambased && dog.aiteam == self.team)
	{
		return 0;
	}

	if(IsDefined(dog.script_owner) && self.owner == dog.script_owner)
	{
		return 0;
	}

	heli_centroid = 160 + VectorScale((0,0,-1));
	heli_forward_norm = AnglesToForward(self.angles);
	heli_turret_point = heli_centroid + 144 * heli_forward_norm;
	if(!(IsDefined(dog.lasthit)))
	{
		dog.lasthit = 0;
	}

	dog.lasthit = self heliturretdogtrace(heli_turret_point,dog,dog.lasthit);
	if(dog.lasthit != 0)
	{
		return 0;
	}

	return cantarget;
}

//Function Number: 25
cantargettank_turret(tank)
{
	cantarget = 1;
	if(!(IsDefined(tank)))
	{
		return 0;
	}

	if(distance(tank.origin,self.origin) > level.heli_visual_range)
	{
		return 0;
	}

	if(!(IsDefined(tank.aiteam)))
	{
		return 0;
	}

	if(level.teambased && tank.aiteam == self.team)
	{
		return 0;
	}

	if(IsDefined(tank.owner) && self.owner == tank.owner)
	{
		return 0;
	}
}

//Function Number: 26
assignprimarytargets(targets)
{
	for(idx = 0;idx < targets.size;idx++)
	{
		if(IsDefined(targets[idx].type) && targets[idx].type == "dog")
		{
			update_dog_threat(targets[idx]);
		}
		else
		{
			update_player_threat(targets[idx]);
		}
	}

/#
	assert(targets.size >= 2,"Not enough targets to assign primary and secondary");
#/
	highest = 0;
	second_highest = 0;
	primarytarget = undefined;
	for(idx = 0;idx < targets.size;idx++)
	{
/#
		assert(IsDefined(targets[idx].threatlevel),"Target player does not have threat level");
#/
		if(targets[idx].threatlevel >= highest)
		{
			highest = targets[idx].threatlevel;
			primarytarget = targets[idx];
		}
	}

/#
	assert(IsDefined(primarytarget),"Targets exist, but none was assigned as primary");
#/
	self.primarytarget = primarytarget;
	self notify("primary acquired");
}

//Function Number: 27
assignsecondarytargets(targets)
{
	for(idx = 0;idx < targets.size;idx++)
	{
		if(!IsDefined(targets[idx].type) || targets[idx].type != "dog")
		{
			self update_missile_player_threat(targets[idx]);
		}
		else if(targets[idx].type == "dog" || targets[0].type == "tank_drone")
		{
			update_missile_dog_threat(targets[idx]);
		}
	}

/#
	assert(targets.size >= 2,"Not enough targets to assign primary and secondary");
#/
	highest = 0;
	second_highest = 0;
	primarytarget = undefined;
	secondarytarget = undefined;
	for(idx = 0;idx < targets.size;idx++)
	{
/#
		assert(IsDefined(targets[idx].missilethreatlevel),"Target player does not have threat level");
#/
		if(targets[idx].missilethreatlevel >= highest)
		{
			highest = targets[idx].missilethreatlevel;
			secondarytarget = targets[idx];
		}
	}

/#
	assert(IsDefined(secondarytarget),"1+ targets exist, but none was assigned as secondary");
#/
	self.secondarytarget = secondarytarget;
	self notify("secondary acquired");
}

//Function Number: 28
update_player_threat(player)
{
	player.threatlevel = 0;
	dist = distance(player.origin,self.origin);
	player.threatlevel = player.threatlevel + level.heli_visual_range - dist / level.heli_visual_range * 100;
	if(IsDefined(self.attacker) && player == self.attacker)
	{
		player.threatlevel = player.threatlevel + 100;
	}

	if(IsDefined(player.carryobject))
	{
		player.threatlevel = player.threatlevel + 200;
	}

	if(IsDefined(player.score))
	{
		player.threatlevel = player.threatlevel + player.score * 4;
	}

	if(IsDefined(player.antithreat))
	{
		player.threatlevel = player.threatlevel - player.antithreat;
	}

	if(player.threatlevel <= 0)
	{
		player.threatlevel = 1;
	}
}

//Function Number: 29
update_missile_player_threat(player)
{
	player.missilethreatlevel = 0;
	dist = distance(player.origin,self.origin);
	player.missilethreatlevel = player.missilethreatlevel + level.heli_missile_range - dist / level.heli_missile_range * 100;
	if(self missile_valid_target_check(player) == 0)
	{
		player.missilethreatlevel = 1;
		return;
	}

	if(IsDefined(self.attacker) && player == self.attacker)
	{
		player.missilethreatlevel = player.missilethreatlevel + 100;
	}

	player.missilethreatlevel = player.missilethreatlevel + player.score * 4;
	if(IsDefined(player.antithreat))
	{
		player.missilethreatlevel = player.missilethreatlevel - player.antithreat;
	}

	if(player.missilethreatlevel <= 0)
	{
		player.missilethreatlevel = 1;
	}
}

//Function Number: 30
update_dog_threat(dog)
{
	dog.threatlevel = 0;
	dist = distance(dog.origin,self.origin);
	dog.threatlevel = dog.threatlevel + level.heli_visual_range - dist / level.heli_visual_range * 100;
}

//Function Number: 31
update_missile_dog_threat(dog)
{
	dog.missilethreatlevel = 1;
}

//Function Number: 32
heli_reset()
{
	self cleartargetyaw();
	self cleargoalyaw();
	self setspeed(60,25);
	self setyawspeed(75,45,45);
	self setmaxpitchroll(30,30);
	self setneargoalnotifydist(256);
	self setturningability(0.9);
}

//Function Number: 33
heli_wait(waittime)
{
	self endon("death");
	self endon("crashing");
	self endon("evasive");
	self thread heli_hover();
	wait(waittime);
	heli_reset();
	self notify("stop hover");
}

//Function Number: 34
heli_hover()
{
	self endon("death");
	self endon("stop hover");
	self endon("evasive");
	self endon("leaving");
	self endon("crashing");
	randint = randomint(360);
	self setgoalyaw(self.angles[1] + randint);
}

//Function Number: 35
heli_kill_monitor(hardpointtype)
{
	self endon("death");
	self endon("crashing");
	self endon("leaving");
	self.damagetaken = 0;
	self.bda = 0;
	last_kill_vo = 0;
	kill_vo_spacing = 4000;
	for(;;)
	{
		self waittill("killed",victim);
/#
		println("got killed notify");
#/
		if(!(IsDefined(self.owner)))
		{
			continue;
		}

		if(self.owner == victim)
		{
			continue;
		}

		if(level.teambased && self.owner.team == victim.team)
		{
			continue;
		}

		if(last_kill_vo + kill_vo_spacing < GetTime())
		{
			self.pilotistalking = 1;
			wait(1.5);
			if(hardpointtype == "helicopter_player_gunner_mp")
			{
				type = "kls";
				self thread playpilotdialog("kls_hit",1);
			}
			else
			{
				type = "klsheli";
				self thread playpilotdialog("klsheli_hit",1);
			}

			wait(4);
			if(self.bda == 0)
			{
				bdadialog = type + "_killn";
			}

			if(self.bda == 1)
			{
				bdadialog = type + "_kill1";
			}

			if(self.bda == 2)
			{
				bdadialog = type + "_kill2";
			}

			if(self.bda == 3)
			{
				bdadialog = type + "_kill3";
			}
			else if(self.bda > 3)
			{
				bdadialog = type + "_killm";
			}

			self thread playpilotdialog(bdadialog);
			self.bda = 0;
			last_kill_vo = GetTime();
			wait(1.5);
			self.pilotistalking = 0;
		}
	}
}

//Function Number: 36
heli_damage_monitor(hardpointtype)
{
	self endon("death");
	self endon("crashing");
	self.damagetaken = 0;
	last_hit_vo = 0;
	hit_vo_spacing = 6000;
	if(!(IsDefined(self.attackerdata)))
	{
		self.attackers = [];
		self.attackerdata = [];
		self.attackerdamage = [];
		self.flareattackerdamage = [];
	}

	for(;;)
	{
		self waittill("damage",damage,attacker,direction,point,type,modelname,tagname,partname,weapon);
		if(!IsDefined(attacker) || !isplayer(attacker))
		{
			continue;
		}

		heli_friendlyfire = maps/mp/gametypes/_weaponobjects::friendlyfirecheck(self.owner,attacker);
		if(!(heli_friendlyfire))
		{
			continue;
		}

		if(!(level.hardcoremode))
		{
			if(IsDefined(self.owner) && attacker == self.owner)
			{
				continue;
			}

			if(level.teambased)
			{
				isvalidattacker = IsDefined(attacker.team) && attacker.team != self.team;
			}
			else
			{
				isvalidattacker = 1;
			}

			if(!(isvalidattacker))
			{
				continue;
			}
		}

		if(isplayer(attacker))
		{
			if(maps/mp/gametypes/_globallogic_player::dodamagefeedback(weapon,attacker))
			{
				attacker maps/mp/gametypes/_damagefeedback::updatedamagefeedback();
			}

			if(type == "MOD_RIFLE_BULLET" || type == "MOD_PISTOL_BULLET")
			{
				if(attacker hasperk("specialty_armorpiercing"))
				{
					damage = damage + int(damage * level.cac_armorpiercing_data);
				}

				damage = damage * level.heli_armor_bulletdamage;
			}

			self trackassists(attacker,damage,0);
		}

		self.attacker = attacker;
		if(type == "MOD_PROJECTILE")
		{
			switch(weapon)
			{
				case "tow_turret_mp":
					self.damagetaken = self.damagetaken + self.rocketdamagetwoshot;
					continue;
					self.damagetaken = self.damagetaken + self.rocketdamageoneshot;
					continue;
					self.damagetaken = self.damagetaken + damage;
					break;
		IsDefined(self.rocketdamageoneshot)
		IsDefined(self.rocketdamagetwoshot)
					break;
	
				case "xm25_mp":
					self.damagetaken = self.damagetaken + damage;
					break;
	
				default:
					self.damagetaken = self.damagetaken + self.rocketdamageoneshot;
					continue;
					self.damagetaken = self.damagetaken + damage;
					break;
		IsDefined(self.rocketdamageoneshot)
					break;
			}
		}
		else
		{
			self.damagetaken = self.damagetaken + damage;
		}

		playercontrolled = 0;
		if(self.damagetaken > self.maxhealth && !IsDefined(self.xpgiven) && !IsDefined(self.owner) || attacker != self.owner)
		{
			self.xpgiven = 1;
			switch(hardpointtype)
			{
				case "helicopter_gunner_mp":
					playercontrolled = 1;
					event = "destroyed_helicopter_gunner";
					break;
	
				case "helicopter_player_gunner_mp":
					playercontrolled = 1;
					event = "destroyed_helicopter_gunner";
					break;
	
				case "helicopter_guard_mp":
					event = "destroyed_helicopter_guard";
					break;
	
				case "helicopter_comlink_mp":
					event = "destroyed_helicopter_comlink";
					break;
	
				case "supply_drop_mp":
					event = "destroyed_helicopter_supply_drop";
					break;
			}

			if(IsDefined(event))
			{
				if(self.owner isenemyplayer(attacker))
				{
					maps/mp/_challenges::destroyedhelicopter(attacker,weapon,type,playercontrolled);
					maps/mp/_challenges::destroyedaircraft(attacker,weapon);
					maps/mp/_scoreevents::processscoreevent(event,attacker,self.owner,weapon);
					attacker maps/mp/_challenges::addflyswatterstat(weapon,self);
					if(playercontrolled == 1)
					{
						attacker destroyedplayercontrolledaircraft();
					}

					if(hardpointtype == "helicopter_player_gunner_mp")
					{
						attacker addweaponstat(weapon,"destroyed_controlled_killstreak",1);
					}
				}
				else
				{
				}
			}

			weaponstatname = "destroyed";
			switch(weapon)
			{
				case "auto_tow_mp":
				case "tow_turret_drop_mp":
				case "tow_turret_mp":
					weaponstatname = "kills";
					break;
			}

			attacker addweaponstat(weapon,weaponstatname,1);
			killstreakreference = undefined;
			switch(hardpointtype)
			{
				case "helicopter_gunner_mp":
					killstreakreference = "killstreak_helicopter_gunner";
					break;
	
				case "helicopter_player_gunner_mp":
					killstreakreference = "killstreak_helicopter_player_gunner";
					break;
	
				case "helicopter_player_firstperson_mp":
					killstreakreference = "killstreak_helicopter_player_firstperson";
					break;
	
				case "helicopter_comlink_mp":
				case "helicopter_mp":
				case "helicopter_x2_mp":
					killstreakreference = "killstreak_helicopter_comlink";
					break;
	
				case "supply_drop_mp":
					killstreakreference = "killstreak_supply_drop";
					break;
	
				case "helicopter_guard_mp":
					killstreakreference = "killstreak_helicopter_guard";
					break;
			}

			if(IsDefined(killstreakreference))
			{
				level.globalkillstreaksdestroyed++;
				attacker addweaponstat(hardpointtype,"destroyed",1);
			}

			notifystring = &"KILLSTREAK_DESTROYED_HELICOPTER";
			if(hardpointtype == "helicopter_player_gunner_mp")
			{
				notifystring = &"KILLSTREAK_DESTROYED_HELICOPTER_GUNNER";
				self.owner sendkillstreakdamageevent(600);
			}

			for(i = 0;i < level.players.size;i++)
			{
				level.players[i] luinotifyevent(&"player_callout",2,notifystring,attacker.entnum);
			}

			if(IsDefined(self.attackers))
			{
				for(j = 0;j < self.attackers.size;j++)
				{
					player = self.attackers[j];
					if(!(IsDefined(player)))
					{
					}
					else if(player == attacker)
					{
					}
					else
					{
						flare_done = self.flareattackerdamage[player.clientid];
						if(IsDefined(flare_done) && flare_done == 1)
						{
							maps/mp/_scoreevents::processscoreevent("aircraft_flare_assist",player);
						}
						else
						{
							damage_done = self.attackerdamage[player.clientid];
							player thread processcopterassist(self,damage_done);
						}
					}
				}

				self.attackers = [];
			}

			attacker notify("destroyed_helicopter");
			target_remove(self);
			continue;
		}

		if(IsDefined(self.owner) && isplayer(self.owner))
		{
			if(last_hit_vo + hit_vo_spacing < GetTime())
			{
				if(type == "MOD_PROJECTILE" || randomintrange(0,3) == 0)
				{
					self.owner playlocalsound(level.heli_vo[self.team]["hit"]);
					last_hit_vo = GetTime();
				}
			}
		}
	}
}

//Function Number: 37
trackassists(attacker,damage,isflare)
{
	if(!(IsDefined(self.attackerdata[attacker.clientid])))
	{
		self.attackerdamage[attacker.clientid] = damage;
		self.attackers[self.attackers.size] = attacker;
		self.attackerdata[attacker.clientid] = 0;
	}
	else
	{
		self.attackerdamage[attacker.clientid] = self.attackerdamage[attacker.clientid] + damage;
	}

	if(IsDefined(isflare) && isflare == 1)
	{
		self.flareattackerdamage[attacker.clientid] = 1;
	}
	else
	{
		self.flareattackerdamage[attacker.clientid] = 0;
	}
}

//Function Number: 38
heli_health(hardpointtype,player,playernotify)
{
	self endon("death");
	self endon("crashing");
	self.currentstate = "ok";
	self.laststate = "ok";
	self setdamagestage(3);
	damagestate = 3;
	for(;;)
	{
		self waittill("damage",damage,attacker,direction,point,type,modelname,tagname,partname,weapon);
		wait(0.05);
		if(self.damagetaken > self.maxhealth)
		{
			damagestate = 0;
			self setdamagestage(damagestate);
			self thread heli_crash(hardpointtype,player,playernotify);
		}
		else if(self.damagetaken >= self.maxhealth * 0.66 && damagestate >= 2)
		{
			if(IsDefined(self.vehicletype) && self.vehicletype == "heli_player_gunner_mp")
			{
				playfxontag(level.chopper_fx["damage"]["heavy_smoke"],self,"tag_origin");
			}
			else
			{
				playfxontag(level.chopper_fx["damage"]["heavy_smoke"],self,"tag_main_rotor");
			}

			damagestate = 1;
			self.currentstate = "heavy smoke";
			self.evasive = 1;
			self notify("damage state");
		}
		else if(self.damagetaken >= self.maxhealth * 0.33 && damagestate == 3)
		{
			if(IsDefined(self.vehicletype) && self.vehicletype == "heli_player_gunner_mp")
			{
				playfxontag(level.chopper_fx["damage"]["light_smoke"],self,"tag_origin");
			}
			else
			{
				playfxontag(level.chopper_fx["damage"]["light_smoke"],self,"tag_main_rotor");
			}

			damagestate = 2;
			self.currentstate = "light smoke";
			self notify("damage state");
		}

		if(self.damagetaken <= level.heli_armor)
		{
			debug_print3d_simple("Armor: " + level.heli_armor - self.damagetaken,self,VectorScale((0,0,1)),100);
			continue;
		}

		debug_print3d_simple("Health: " + self.maxhealth - self.damagetaken,self,VectorScale((0,0,1)),100);
	}
}

//Function Number: 39
heli_evasive(hardpointtype)
{
	self notify("evasive");
	self.evasive = 1;
	loop_startnode = level.heli_loop_paths[0];
	gunnerpathfound = 1;
	if(hardpointtype == "helicopter_gunner_mp")
	{
		gunnerpathfound = 0;
		for(i = 0;i < level.heli_loop_paths.size;i++)
		{
			if(IsDefined(level.heli_loop_paths[i].isgunnerpath) && level.heli_loop_paths[i].isgunnerpath)
			{
				loop_startnode = level.heli_loop_paths[i];
				gunnerpathfound = 1;
				break;
			}
		}
	}

/#
	assert(gunnerpathfound,"No chopper gunner loop paths found in map");
#/
	startwait = 2;
	if(IsDefined(self.donotstop) && self.donotstop)
	{
		startwait = 0;
	}

	self thread heli_fly(loop_startnode,startwait,hardpointtype);
}

//Function Number: 40
notify_player(player,playernotify,delay)
{
	if(!(IsDefined(player)))
	{
		return;
	}

	if(!(IsDefined(playernotify)))
	{
		return;
	}

	player endon("disconnect");
	player endon(playernotify);
	wait(delay);
	player notify(playernotify);
}

//Function Number: 41
play_going_down_vo(delay)
{
	self.owner endon("disconnect");
	self endon("death");
	wait(delay);
	self playpilotdialog("attackheli_down");
}

//Function Number: 42
heli_crash(hardpointtype,player,playernotify)
{
	self endon("death");
	self notify("crashing");
	self maps/mp/gametypes/_spawning::remove_helicopter_influencers();
	self stoploopsound(0);
	if(IsDefined(self.minigun_snd_ent))
	{
		self.minigun_snd_ent stoploopsound();
	}

	if(IsDefined(self.alarm_snd_ent))
	{
		self.alarm_snd_ent stoploopsound();
	}

	crashtypes = [];
	crashtypes[0] = "crashOnPath";
	crashtypes[1] = "spinOut";
	crashtype = crashtypes[randomint(2)];
	if(IsDefined(self.crashtype))
	{
		crashtype = self.crashtype;
	}

/#
	switch(level.heli_debug_crash)
	{
		case "1":
			crashtype = "explode";
			break;
		case "2":
			crashtype = "crashOnPath";
			break;
		case "3":
			crashtype = "spinOut";
			break;
		default:
			break;
	}
level.heli_debug_crash
#/
	switch(crashtype)
	{
		case "explode":
			thread notify_player(player,playernotify,0);
			self thread heli_explode();
			break;

		case "crashOnPath":
			self thread play_going_down_vo(0.5);
			thread notify_player(player,playernotify,4);
			self clear_client_flags();
			self thread crashonnearestcrashpath(hardpointtype);
			break;
	IsDefined(player)
			break;

		case "spinOut":
			self thread play_going_down_vo(0.5);
			thread notify_player(player,playernotify,4);
			self clear_client_flags();
			heli_reset();
			heli_speed = 30 + randomint(50);
			heli_accel = 10 + randomint(25);
			leavenode = getvalidrandomcrashnode(self.origin);
			self setspeed(heli_speed,heli_accel);
			self setvehgoalpos(leavenode.origin,0);
			rateofspin = 45 + randomint(90);
			thread heli_secondary_explosions();
			self thread heli_spin(rateofspin);
			self waittill_any_timeout(randomintrange(4,6),"near_goal");
			player notify(playernotify,IsDefined(player) && IsDefined(playernotify),IsDefined(player));
			self thread heli_explode();
			break;
	}

	self thread explodeoncontact(hardpointtype);
	time = randomintrange(4,6);
	self thread waitthenexplode(time);
}

//Function Number: 43
damagedrotorfx()
{
	self endon("death");
	self setrotorspeed(0.6);
}

//Function Number: 44
waitthenexplode(time)
{
	self endon("death");
	wait(time);
	self thread heli_explode();
}

//Function Number: 45
crashonnearestcrashpath(hardpointtype)
{
	crashpathdistance = -1;
	crashpath = level.heli_crash_paths[0];
	for(i = 0;i < level.heli_crash_paths.size;i++)
	{
		currentdistance = distance(self.origin,level.heli_crash_paths[i].origin);
		if(crashpathdistance == -1 || crashpathdistance > currentdistance)
		{
			crashpathdistance = currentdistance;
			crashpath = level.heli_crash_paths[i];
		}
	}

	heli_speed = 30 + randomint(50);
	heli_accel = 10 + randomint(25);
	self setspeed(heli_speed,heli_accel);
	thread heli_secondary_explosions();
	self thread heli_fly(crashpath,0,hardpointtype);
	rateofspin = 45 + randomint(90);
	self thread heli_spin(rateofspin);
	self waittill("path start");
	self waittill("destination reached");
	self thread heli_explode();
}

//Function Number: 46
heli_secondary_explosions()
{
	self endon("death");
	playfxontag(level.chopper_fx["explode"]["large"],self,"tag_engine_left");
	self playsound(level.heli_sound["hit"]);
	if(IsDefined(self.vehicletype) && self.vehicletype == "heli_player_gunner_mp")
	{
		self thread trail_fx(level.chopper_fx["smoke"]["trail"],"tag_engine_right","stop tail smoke");
	}
	else
	{
		self thread trail_fx(level.chopper_fx["smoke"]["trail"],"tail_rotor_jnt","stop tail smoke");
	}

	self setdamagestage(0);
	self thread trail_fx(level.chopper_fx["fire"]["trail"]["large"],"tag_engine_left","stop body fire");
	wait(3);
	if(!(IsDefined(self)))
	{
		return;
	}

	playfxontag(level.chopper_fx["explode"]["large"],self,"tag_engine_left");
	self playsound(level.heli_sound["hitsecondary"]);
}

//Function Number: 47
heli_spin(speed)
{
	self endon("death");
	self thread spinsoundshortly();
	self setyawspeed(speed,speed / 3,speed / 3);
	while(IsDefined(self))
	{
		self settargetyaw(self.angles[1] + speed * 0.9);
		wait(1);
	}
}

//Function Number: 48
spinsoundshortly()
{
	self endon("death");
	wait(0.25);
	self stoploopsound();
	wait(0.05);
	self playloopsound(level.heli_sound["spinloop"]);
	wait(0.05);
	self playsound(level.heli_sound["spinstart"]);
}

//Function Number: 49
trail_fx(trail_fx,trail_tag,stop_notify)
{
	playfxontag(trail_fx,self,trail_tag);
}

//Function Number: 50
destroyhelicopter()
{
	team = self.team;
	self maps/mp/gametypes/_spawning::remove_helicopter_influencers();
	if(IsDefined(self.interior_model))
	{
		self.interior_model delete();
		self.interior_model = undefined;
	}

	if(IsDefined(self.minigun_snd_ent))
	{
		self.minigun_snd_ent stoploopsound();
		self.minigun_snd_ent delete();
		self.minigun_snd_ent = undefined;
	}

	if(IsDefined(self.alarm_snd_ent))
	{
		self.alarm_snd_ent delete();
		self.alarm_snd_ent = undefined;
	}

	if(IsDefined(self.flare_ent))
	{
		self.flare_ent delete();
		self.flare_ent = undefined;
	}

	self delete();
	maps/mp/killstreaks/_killstreakrules::killstreakstop(self.hardpointtype,team,self.killstreak_id);
}

//Function Number: 51
heli_explode()
{
	self death_notify_wrapper();
	forward = 100 + VectorScale((0,0,1)) - self.origin;
	if(IsDefined(self.helitype) && self.helitype == "littlebird")
	{
		playfx(level.chopper_fx["explode"]["guard"],self.origin,forward);
	}
	else if(IsDefined(self.vehicletype) && self.vehicletype == "heli_player_gunner_mp")
	{
		playfx(level.chopper_fx["explode"]["gunner"],self.origin,forward);
	}
	else
	{
		playfx(level.chopper_fx["explode"]["death"],self.origin,forward);
	}

	self playsound(level.heli_sound["crash"]);
	wait(0.1);
/#
	assert(IsDefined(self.destroyfunc));
#/
	self [[ self.destroyfunc ]]();
}

//Function Number: 52
clear_client_flags()
{
}

//Function Number: 53
heli_leave(hardpointtype)
{
	self notify("desintation reached");
	self notify("leaving");
	if(hardpointtype == "helicopter_player_gunner_mp")
	{
		self thread playpilotdialog("a10_leave",2.5);
	}
	else
	{
		self thread playpilotdialog("attackheli_leave",2.5);
	}

	self clear_client_flags();
	leavenode = getvalidrandomleavenode(self.origin);
	heli_reset();
	self clearlookatent();
	exitangles = VectorToAngles(leavenode.origin - self.origin);
	self setgoalyaw(exitangles[1]);
	wait(1.5);
	if(!(IsDefined(self)))
	{
		return;
	}

	self setspeed(180,65);
	self setvehgoalpos(1000 + VectorScale((0,0,1)));
	self waittill(self.origin + leavenode.origin - self.origin / 2,"near_goal");
	self setvehgoalpos(leavenode.origin,1);
	self waittillmatch
	return;
	("goal");
	self stoploopsound(1);
	self death_notify_wrapper();
	if(IsDefined(self.alarm_snd_ent))
	{
		self.alarm_snd_ent stoploopsound();
		self.alarm_snd_ent delete();
		self.alarm_snd_ent = undefined;
	}

	if(target_istarget(self))
	{
		target_remove(self);
	}

/#
	assert(IsDefined(self.destroyfunc));
#/
	self [[ self.destroyfunc ]]();
}

//Function Number: 54
heli_fly(currentnode,startwait,hardpointtype)
{
	self endon("death");
	self endon("leaving");
	self notify("flying");
	self endon("flying");
	self endon("abandoned");
	self.reached_dest = 0;
	heli_reset();
	pos = self.origin;
	wait(startwait);
	while(IsDefined(currentnode.target))
	{
		nextnode = getent(currentnode.target,"targetname");
/#
		assert(IsDefined(nextnode),"Next node in path is undefined, but has targetname");
#/
		pos = 30 + VectorScale((0,0,1));
		if(IsDefined(currentnode.script_airspeed) && IsDefined(currentnode.script_accel))
		{
			heli_speed = currentnode.script_airspeed;
			heli_accel = currentnode.script_accel;
		}
		else
		{
			heli_speed = 30 + randomint(20);
			heli_accel = 10 + randomint(5);
		}

		if(IsDefined(self.pathspeedscale))
		{
			heli_speed = heli_speed * self.pathspeedscale;
			heli_accel = heli_accel * self.pathspeedscale;
		}

		if(!(IsDefined(nextnode.target)))
		{
			stop = 1;
		}
		else
		{
			stop = 0;
		}

		debug_line(currentnode.origin,nextnode.origin,(1,0.5,0.5),200);
		if(self.currentstate == "heavy smoke" || self.currentstate == "light smoke")
		{
			self setspeed(heli_speed,heli_accel);
			self setvehgoalpos(pos,stop);
			self waittill(nextnode.origin,"near_goal");
			self notify("path start");
		}
		else
		{
			if(IsDefined(nextnode.script_delay) && !IsDefined(self.donotstop))
			{
				stop = 1;
			}

			self setspeed(heli_speed,heli_accel);
			self setvehgoalpos(pos,stop);
			if(!IsDefined(nextnode.script_delay) || IsDefined(self.donotstop))
			{
				self waittill("near_goal");
				self notify("path start");
			}
			else
			{
				self setgoalyaw(nextnode.angles[1]);
				self waittillmatch
				return;
				("goal");
				heli_wait(nextnode.script_delay);
			}
		}

		for(index = 0;index < level.heli_loop_paths.size;index++)
		{
			if(level.heli_loop_paths[index].origin == nextnode.origin)
			{
				self.loopcount++;
			}
		}

		if(self.loopcount >= level.heli_loopmax)
		{
			self thread heli_leave(hardpointtype);
			return;
		}

		currentnode = nextnode;
	}

	self setgoalyaw(currentnode.angles[1]);
	self.reached_dest = 1;
	self notify("destination reached");
	if(IsDefined(self.waittime) && self.waittime > 0)
	{
		heli_wait(self.waittime);
	}

	if(IsDefined(self))
	{
		self thread heli_evasive(hardpointtype);
	}
}

//Function Number: 55
heli_random_point_in_radius(protectdest,nodeheight)
{
	min_distance = int(level.heli_protect_radius * 0.2);
	direction = randomintrange(0,360);
	distance = randomintrange(min_distance,level.heli_protect_radius);
	x = cos(direction);
	y = sin(direction);
	x = x * distance;
	y = y * distance;
	return (protectdest[0] + x,protectdest[1] + y,nodeheight);
}

//Function Number: 56
heli_get_protect_spot(protectdest,nodeheight)
{
	protect_spot = heli_random_point_in_radius(protectdest,nodeheight);
	tries = 10;
	for(noflyzone = crossesnoflyzone(protectdest,protect_spot);tries != 0 && IsDefined(noflyzone);noflyzone = crossesnoflyzone(protectdest,protect_spot))
	{
		protect_spot = heli_random_point_in_radius(protectdest,nodeheight);
		tries--;
	}

	noflyzoneheight = getnoflyzoneheightcrossed(protectdest,protect_spot,nodeheight);
	return (protect_spot[0],protect_spot[1],noflyzoneheight);
}

//Function Number: 57
wait_or_waittill(time,msg1,msg2)
{
	self endon(msg1);
	self endon(msg2);
	wait(time);
	return 1;
}

//Function Number: 58
set_heli_speed_normal()
{
	self setmaxpitchroll(30,30);
	heli_speed = 30 + randomint(20);
	heli_accel = 10 + randomint(5);
	self setspeed(heli_speed,heli_accel);
	self setyawspeed(75,45,45);
}

//Function Number: 59
set_heli_speed_evasive()
{
	self setmaxpitchroll(30,90);
	heli_speed = 50 + randomint(20);
	heli_accel = 30 + randomint(5);
	self setspeed(heli_speed,heli_accel);
	self setyawspeed(100,75,75);
}

//Function Number: 60
set_heli_speed_hover()
{
	self setmaxpitchroll(0,90);
	self setspeed(20,10);
	self setyawspeed(55,25,25);
}

//Function Number: 61
is_targeted()
{
	if(IsDefined(self.locking_on) && self.locking_on)
	{
		return 1;
	}

	if(IsDefined(self.locked_on) && self.locked_on)
	{
		return 1;
	}
}

//Function Number: 62
heli_mobilespawn(protectdest)
{
	self endon("death");
	self notify("flying");
	self endon("flying");
	self endon("abandoned");
	iprintlnbold("PROTECT ORIGIN: (" + protectdest[0] + "," + protectdest[1] + "," + protectdest[2] + ")\n");
	heli_reset();
	self sethoverparams(50,100,50);
	wait(2);
	set_heli_speed_normal();
	self setvehgoalpos(protectdest,1);
	self waittill("near_goal");
	set_heli_speed_hover();
}

//Function Number: 63
heli_protect(startnode,protectdest,hardpointtype,heli_team)
{
	self endon("death");
	self notify("flying");
	self endon("flying");
	self endon("abandoned");
	self.reached_dest = 0;
	heli_reset();
	self sethoverparams(50,100,50);
	wait(2);
	currentdest = protectdest;
	nodeheight = protectdest[2];
	nextnode = startnode;
	heightoffset = 0;
	if(heli_team == "axis")
	{
		heightoffset = 800;
	}

	protectdest = (protectdest[0],protectdest[1],nodeheight);
	noflyzoneheight = getnoflyzoneheight(protectdest);
	protectdest = (protectdest[0],protectdest[1],noflyzoneheight + heightoffset);
	currentdest = protectdest;
	starttime = GetTime();
	endtime = starttime + level.heli_protect_time * 1000;
	self setspeed(150,80);
	self setvehgoalpos(1000 + VectorScale((0,0,1)));
	self waittill(self.origin + currentdest - self.origin / 3,"near_goal");
	heli_speed = 30 + randomint(20);
	heli_accel = 10 + randomint(5);
	self thread updatetargetyaw();
	mapenter = 1;
	while(GetTime() < endtime)
	{
		stop = 1;
		if(!(mapenter))
		{
			self updatespeed();
		}
		else
		{
			mapenter = 0;
		}

		self setvehgoalpos(currentdest,stop);
		self thread updatespeedonlock();
		self waittill_any("near_goal","locking on");
		maps/mp/gametypes/_hostmigration::waittillhostmigrationdone();
		self notify("path start");
		if(!(self is_targeted()))
		{
			waittillframeend;
			time = level.heli_protect_pos_time;
			if(self.evasive == 1)
			{
				time = 2;
			}

			set_heli_speed_hover();
			wait_or_waittill(time,"locking on","damage state");
		}

		prevdest = currentdest;
		currentdest = heli_get_protect_spot(protectdest,nodeheight);
		noflyzoneheight = getnoflyzoneheight(currentdest);
		currentdest = (currentdest[0],currentdest[1],noflyzoneheight + heightoffset);
		noflyzones = crossesnoflyzones(prevdest,currentdest);
		if(IsDefined(noflyzones) && noflyzones.size > 0)
		{
			currentdest = prevdest;
		}
	}

	self thread heli_leave(hardpointtype);
}

//Function Number: 64
updatespeedonlock()
{
	self endon("death");
	self endon("crashing");
	self endon("leaving");
	self waittill_any("near_goal","locking on");
	self updatespeed();
}

//Function Number: 65
updatespeed()
{
	if(self is_targeted() || IsDefined(self.evasive) && self.evasive)
	{
		set_heli_speed_evasive();
	}
	else
	{
		set_heli_speed_normal();
	}
}

//Function Number: 66
updatetargetyaw()
{
	self notify("endTargetYawUpdate");
	self endon("death");
	self endon("crashing");
	self endon("leaving");
	self endon("endTargetYawUpdate");
	for(;;)
	{
		if(IsDefined(self.primarytarget))
		{
			yaw = get2dyaw(self.origin,self.primarytarget.origin);
			self settargetyaw(yaw);
		}

		wait(1);
	}
}

//Function Number: 67
fire_missile(smissiletype,ishots,etarget)
{
	if(!(IsDefined(ishots)))
	{
		ishots = 1;
	}

/#
	assert(self.health > 0);
#/
	weaponname = undefined;
	weaponshoottime = undefined;
	tags = [];
	switch(smissiletype)
	{
		case "ffar":
			weaponname = "hind_FFAR_mp";
			tags[0] = "tag_store_r_2";
			break;

		default:
	/#
			assertmsg("Invalid missile type specified. Must be ffar");
	#/
			break;
	}

/#
	assert(IsDefined(weaponname));
#/
/#
	assert(tags.size > 0);
#/
	weaponshoottime = weaponfiretime(weaponname);
/#
	assert(IsDefined(weaponshoottime));
#/
	self setvehweapon(weaponname);
	nextmissiletag = -1;
	for(i = 0;i < ishots;i++)
	{
		nextmissiletag++;
		if(nextmissiletag >= tags.size)
		{
			nextmissiletag = 0;
		}

		if(IsDefined(etarget))
		{
			emissile = self fireweapon(tags[nextmissiletag],etarget);
		}
		else
		{
			emissile = self fireweapon(tags[nextmissiletag]);
		}

		emissile.killcament = self;
		self.lastrocketfiretime = GetTime();
		if(i < ishots - 1)
		{
			wait(weaponshoottime);
		}
	}
}

//Function Number: 68
check_owner(hardpointtype)
{
	if(!IsDefined(self.owner) || !IsDefined(self.owner.team) || self.owner.team != self.team)
	{
		self notify("abandoned");
		self thread heli_leave(hardpointtype);
	}
}

//Function Number: 69
attack_targets(missilesenabled,hardpointtype)
{
	self thread attack_primary(hardpointtype);
	if(missilesenabled)
	{
		self thread attack_secondary(hardpointtype);
	}
}

//Function Number: 70
attack_secondary(hardpointtype)
{
	self endon("death");
	self endon("crashing");
	self endon("leaving");
	for(;;)
	{
		if(IsDefined(self.secondarytarget))
		{
			self.secondarytarget.antithreat = undefined;
			self.missiletarget = self.secondarytarget;
			antithreat = 0;
			while(IsDefined(self.missiletarget) && isalive(self.missiletarget))
			{
				if(self target_cone_check(self.missiletarget,level.heli_missile_target_cone))
				{
					self thread missile_support(self.missiletarget,level.heli_missile_rof,1,undefined);
				}
				else
				{
					break;
				}

				antithreat = antithreat + 100;
				self.missiletarget.antithreat = antithreat;
				wait(level.heli_missile_rof);
				if(!IsDefined(self.secondarytarget) || IsDefined(self.secondarytarget) && self.missiletarget != self.secondarytarget)
				{
					break;
				}
			}

			if(IsDefined(self.missiletarget))
			{
				self.missiletarget.antithreat = undefined;
			}
		}

		self waittill("secondary acquired");
		self check_owner(hardpointtype);
	}
}

//Function Number: 71
turret_target_check(turrettarget,attackangle)
{
	targetyaw = get2dyaw(self.origin,turrettarget.origin);
	chopperyaw = self.angles[1];
	if(targetyaw < 0)
	{
		targetyaw = targetyaw * -1;
	}

	targetyaw = int(targetyaw) % 360;
	if(chopperyaw < 0)
	{
		chopperyaw = chopperyaw * -1;
	}

	chopperyaw = int(chopperyaw) % 360;
	if(chopperyaw > targetyaw)
	{
		difference = chopperyaw - targetyaw;
	}
	else
	{
		difference = targetyaw - chopperyaw;
	}

	return difference <= attackangle;
}

//Function Number: 72
target_cone_check(target,conecosine)
{
	heli2target_normal = vectornormalize(target.origin - self.origin);
	heli2forward = AnglesToForward(self.angles);
	heli2forward_normal = vectornormalize(heli2forward);
	heli_dot_target = vectordot(heli2target_normal,heli2forward_normal);
	if(heli_dot_target >= conecosine)
	{
		debug_print3d_simple("Cone sight: " + heli_dot_target,self,VectorScale((0,0,-1)),40);
		return 1;
	}
}

//Function Number: 73
missile_valid_target_check(missiletarget)
{
	heli2target_normal = vectornormalize(missiletarget.origin - self.origin);
	heli2forward = AnglesToForward(self.angles);
	heli2forward_normal = vectornormalize(heli2forward);
	heli_dot_target = vectordot(heli2target_normal,heli2forward_normal);
	if(heli_dot_target >= level.heli_valid_target_cone)
	{
		return 1;
	}
}

//Function Number: 74
missile_support(target_player,rof,instantfire,endon_notify)
{
	self endon("death");
	self endon("crashing");
	self endon("leaving");
	if(IsDefined(endon_notify))
	{
		self endon(endon_notify);
	}

	self.turret_giveup = 0;
	if(!(instantfire))
	{
		wait(rof);
		self.turret_giveup = 1;
		self notify("give up");
	}

	if(IsDefined(target_player))
	{
		if(level.teambased)
		{
			for(i = 0;i < level.players.size;i++)
			{
				player = level.players[i];
				if(IsDefined(player.team) && player.team == self.team && distance(player.origin,target_player.origin) <= level.heli_missile_friendlycare)
				{
					debug_print3d_simple("Missile omitted due to nearby friendly",self,VectorScale((0,0,-1)),80);
					self notify("missile ready",40);
					return;
				}
			}
		}
		else
		{
			player = self.owner;
			if(IsDefined(player) && IsDefined(player.team) && player.team == self.team && distance(player.origin,target_player.origin) <= level.heli_missile_friendlycare)
			{
				debug_print3d_simple("Missile omitted due to nearby friendly",self,VectorScale((0,0,-1)),80);
				self notify("missile ready",40);
				return;
			}
		}
	}

	if(self.missile_ammo > 0 && IsDefined(target_player))
	{
		self fire_missile("ffar",1,target_player);
		self.missile_ammo--;
		self notify("missile fired");
	}
	else
	{
		return;
	}

	if(instantfire)
	{
		wait(rof);
		self notify("missile ready");
	}
}

//Function Number: 75
attack_primary(hardpointtype)
{
	self endon("death");
	self endon("crashing");
	self endon("leaving");
	level endon("game_ended");
	for(;;)
	{
		if(IsDefined(self.primarytarget))
		{
			self.primarytarget.antithreat = undefined;
			self.turrettarget = self.primarytarget;
			antithreat = 0;
			last_pos = undefined;
			while(IsDefined(self.turrettarget) && isalive(self.turrettarget))
			{
				if(hardpointtype == "helicopter_comlink_mp")
				{
					self setlookatent(self.turrettarget);
				}

				helicopterturretmaxangle = heli_get_dvar_int("scr_helicopterTurretMaxAngle",level.helicopterturretmaxangle);
				while(IsDefined(self.turrettarget) && isalive(self.turrettarget) && self turret_target_check(self.turrettarget,helicopterturretmaxangle) == 0)
				{
					wait(0.1);
				}

				if(!IsDefined(self.turrettarget) || !isalive(self.turrettarget))
				{
					break;
				}

				self setturrettargetent(self.turrettarget,VectorScale((0,0,1)));
				self waittill(50,"turret_on_target");
				maps/mp/gametypes/_hostmigration::waittillhostmigrationdone();
				self notify("turret_on_target");
				if(!(self.pilotistalking))
				{
					self thread playpilotdialog("attackheli_target");
				}

				self thread turret_target_flag(self.turrettarget);
				wait(level.heli_turret_spinup_delay);
				weaponshoottime = weaponfiretime(self.defaultweapon);
				self setvehweapon(self.defaultweapon);
				for(i = 0;i < level.heli_turretclipsize;i++)
				{
					if(IsDefined(self.turrettarget) && IsDefined(self.primarytarget))
					{
						if(self.primarytarget != self.turrettarget)
						{
							self setturrettargetent(self.primarytarget,VectorScale((0,0,1)));
						}
					}
					else if(IsDefined(self.targetlost) && self.targetlost && IsDefined(self.turret_last_pos))
					{
						self setturrettargetvec(self.turret_last_pos);
					}
					else
					{
						self clearturrettarget();
					}

					if(GetTime() != self.lastrocketfiretime)
					{
						self setvehweapon(self.defaultweapon);
						minigun = self fireweapon("tag_flash");
					}

					if(i < level.heli_turretclipsize - 1)
					{
						wait(weaponshoottime);
					}
				}

				self notify("turret reloading",40);
				wait(level.heli_turretreloadtime);
				if(IsDefined(self.turrettarget) && isalive(self.turrettarget))
				{
					antithreat = antithreat + 100;
					self.turrettarget.antithreat = antithreat;
				}

				if(!IsDefined(self.primarytarget) || IsDefined(self.turrettarget) && IsDefined(self.primarytarget) && self.primarytarget != self.turrettarget)
				{
					break;
				}
			}

			if(IsDefined(self.turrettarget))
			{
				self.turrettarget.antithreat = undefined;
			}
		}

		self waittill("primary acquired");
		self check_owner(hardpointtype);
	}
}

//Function Number: 76
turret_target_flag(turrettarget)
{
	self notify("flag check is running");
	self endon("flag check is running");
	self endon("death");
	self endon("crashing");
	self endon("leaving");
	self endon("turret reloading");
	turrettarget endon("death");
	turrettarget endon("disconnect");
	self.targetlost = 0;
	self.turret_last_pos = undefined;
	while(IsDefined(turrettarget))
	{
		heli_centroid = 160 + VectorScale((0,0,-1));
		heli_forward_norm = AnglesToForward(self.angles);
		heli_turret_point = heli_centroid + 144 * heli_forward_norm;
		sight_rec = turrettarget sightconetrace(heli_turret_point,self);
		if(sight_rec < level.heli_target_recognition)
		{
			break;
		}

		wait(0.05);
	}

	if(IsDefined(turrettarget) && IsDefined(turrettarget.origin))
	{
/#
		assert(IsDefined(turrettarget.origin),"turrettarget.origin is undefined after isdefined check");
#/
		self.turret_last_pos = 40 + VectorScale((0,0,1));
/#
		assert(IsDefined(self.turret_last_pos),"self.turret_last_pos is undefined after setting it #1");
#/
		self setturrettargetvec(self.turret_last_pos);
/#
		assert(IsDefined(self.turret_last_pos),"self.turret_last_pos is undefined after setting it #2");
#/
		debug_print3d_simple("Turret target lost at: " + self.turret_last_pos,self,VectorScale((0,0,-1)),70);
		self.targetlost = 1;
	}
	else
	{
		self.targetlost = undefined;
		self.turret_last_pos = undefined;
	}
}

//Function Number: 77
debug_print_target()
{
	if(IsDefined(level.heli_debug) && level.heli_debug == 1)
	{
		if(IsDefined(self.primarytarget) && IsDefined(self.primarytarget.threatlevel))
		{
			if(IsDefined(self.primarytarget.type) && self.primarytarget.type == "dog")
			{
				name = "dog";
			}
			else
			{
				name = self.primarytarget.name;
			}

			primary_msg = "Primary: " + name + " : " + self.primarytarget.threatlevel;
		}
		else
		{
			primary_msg = "Primary: ";
		}

		if(IsDefined(self.secondarytarget) && IsDefined(self.secondarytarget.threatlevel))
		{
			if(IsDefined(self.secondarytarget.type) && self.secondarytarget.type == "dog")
			{
				name = "dog";
			}
			else
			{
				name = self.secondarytarget.name;
			}

			secondary_msg = "Secondary: " + name + " : " + self.secondarytarget.threatlevel;
		}
		else
		{
			secondary_msg = "Secondary: ";
		}

		frames = int(self.targeting_delay * 20) + 1;
		thread draw_text(primary_msg,(1,0.6,0.6),self,VectorScale((0,0,1)),40);
		thread draw_text(secondary_msg,(1,0.6,0.6),self,(0,0,0),frames);
	}
}

//Function Number: 78
improved_sightconetrace(helicopter)
{
	heli_centroid = 160 + VectorScale((0,0,-1));
	heli_forward_norm = AnglesToForward(helicopter.angles);
	heli_turret_point = heli_centroid + 144 * heli_forward_norm;
	debug_line(heli_turret_point,self.origin,(1,1,1),5);
	start = heli_turret_point;
	yes = 0;
	point = [];
	for(i = 0;i < 5;i++)
	{
		if(!(IsDefined(self)))
		{
			break;
		}

		half_height = 36 + VectorScale((0,0,1));
		tovec = start - half_height;
		tovec_angles = VectorToAngles(tovec);
		forward_norm = AnglesToForward(tovec_angles);
		side_norm = AnglesToRight(tovec_angles);
		point[point.size] = 36 + VectorScale((0,0,1));
		point[point.size] = 10 + VectorScale((0,0,1));
		point[point.size] = 10 + VectorScale((0,0,1));
		point[point.size] = 64 + VectorScale((0,0,1));
		point[point.size] = 64 + VectorScale((0,0,1));
		debug_line(point[1],point[2],(1,1,1),1);
		debug_line(point[2],point[3],(1,1,1),1);
		debug_line(point[3],point[4],(1,1,1),1);
		debug_line(point[4],point[1],(1,1,1),1);
		if(bullettracepassed(start,point[i],1,self))
		{
			debug_line(start,point[i],(randomint(10) / 10,randomint(10) / 10,randomint(10) / 10),1);
			yes++;
		}

		waittillframeend;
	}

	return yes / 5;
}

//Function Number: 79
waittill_confirm_location()
{
	self endon("emp_jammed");
	self endon("emp_grenaded");
	self waittill("confirm_location",location);
	return location;
}

//Function Number: 80
selecthelicopterlocation(hardpointtype)
{
	self beginlocationcomlinkselection("compass_objpoint_helicopter",1500);
	self.selectinglocation = 1;
	self thread endselectionthink();
	location = self waittill_confirm_location();
	if(!(IsDefined(location)))
	{
		return 0;
	}

	if(self maps/mp/killstreaks/_killstreakrules::iskillstreakallowed(hardpointtype,self.team) == 0)
	{
		return 0;
	}

	level.helilocation = location;
	return finishhardpointlocationusage(location,::nullcallback);
}

//Function Number: 81
nullcallback(arg1,arg2)
{
	return 1;
}

//Function Number: 82
processcopterassist(destroyedcopter,damagedone)
{
	self endon("disconnect");
	destroyedcopter endon("disconnect");
	wait(0.05);
	if(!(IsDefined(level.teams[self.team])))
	{
		return;
	}

	if(self.team == destroyedcopter.team)
	{
		return;
	}

	assist_level = "aircraft_destruction_assist";
	assist_level_value = int(ceil(damagedone / destroyedcopter.maxhealth * 4));
	if(assist_level_value > 0)
	{
		if(assist_level_value > 3)
		{
			assist_level_value = 3;
		}

		assist_level = assist_level + "_" + assist_level_value * 25;
	}

	maps/mp/_scoreevents::processscoreevent(assist_level,self);
}

//Function Number: 83
samturretwatcher()
{
	self endon("death");
	self endon("crashing");
	self endon("leaving");
	level endon("game_ended");
	self waittill_any("turret_on_target","path start","near_goal");
	target_setturretaquire(self,1);
}

//Function Number: 84
playpilotdialog(dialog,time,voice,shouldwait)
{
	self endon("death");
	level endon("remote_end");
	if(IsDefined(time))
	{
		wait(time);
	}

	if(!(IsDefined(self.pilotvoicenumber)))
	{
		self.pilotvoicenumber = 0;
	}

	if(IsDefined(voice))
	{
		voicenumber = voice;
	}
	else
	{
		voicenumber = self.pilotvoicenumber;
	}

	soundalias = level.teamprefix[self.team] + voicenumber + "_" + dialog;
	if(IsDefined(self.owner))
	{
		self.owner playpilottalking(shouldwait,soundalias);
	}
}

//Function Number: 85
playpilottalking(shouldwait,soundalias)
{
	self endon("disconnect");
	self endon("joined_team");
	self endon("joined_spectators");
	for(trycounter = 0;IsDefined(self.pilottalking) && self.pilottalking && trycounter < 10;trycounter++)
	{
		if(IsDefined(shouldwait) && !shouldwait)
		{
			return;
		}

		wait(1);
	}

	self.pilottalking = 1;
	self playlocalsound(soundalias);
	wait(3);
	self.pilottalking = 0;
}

//Function Number: 86
watchforearlyleave(hardpointtype)
{
	self endon("heli_timeup");
	self waittill_any("joined_team","disconnect");
	self.heli thread heli_leave(hardpointtype);
	self notify("heli_timeup");
}