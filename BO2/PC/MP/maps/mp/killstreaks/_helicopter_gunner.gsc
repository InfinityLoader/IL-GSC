/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\killstreaks\_helicopter_gunner.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: PC
 * Function Count: 53
 * Decompile Time: 20 ms
 * Timestamp: 10/28/2023 12:10:43 AM
*******************************************************************/

#include common_scripts/utility;
#include maps/mp/_heatseekingmissile;
#include maps/mp/_popups;
#include maps/mp/_treadfx;
#include maps/mp/_utility;
#include maps/mp/gametypes/_spawning;
#include maps/mp/gametypes/_weaponobjects;
#include maps/mp/killstreaks/_helicopter;
#include maps/mp/killstreaks/_killstreakrules;
#include maps/mp/killstreaks/_killstreaks;

#using_animtree( "mp_vehicles" );

//Function Number: 1
init()
{
	registerkillstreak("helicopter_player_gunner_mp","helicopter_player_gunner_mp","killstreak_helicopter_player_gunner","helicopter_used",::heli_gunner_killstreak,1);
	registerkillstreakstrings("helicopter_player_gunner_mp",&"KILLSTREAK_EARNED_HELICOPTER_GUNNER",&"KILLSTREAK_HELICOPTER_GUNNER_NOT_AVAILABLE",&"KILLSTREAK_HELICOPTER_GUNNER_INBOUND");
	registerkillstreakdialog("helicopter_player_gunner_mp","mpl_killstreak_osprey_strt","kls_playerheli_used","","kls_playerheli_enemy","","kls_playerheli_ready");
	registerkillstreakdevdvar("helicopter_player_gunner_mp","scr_givehelicopter_player_gunner");
	registerkillstreakaltweapon("helicopter_player_gunner_mp","cobra_minigun_mp");
	registerkillstreakaltweapon("helicopter_player_gunner_mp","heli_gunner_rockets_mp");
	registerkillstreakaltweapon("helicopter_player_gunner_mp","chopper_minigun_mp");
	setkillstreakteamkillpenaltyscale("helicopter_player_gunner_mp",level.teamkillreducedpenalty);
	overrideentitycameraindemo("helicopter_player_gunner_mp",1);
	loadfx("vehicle/treadfx/fx_heli_dust_default");
	loadfx("vehicle/treadfx/fx_heli_dust_concrete");
	loadfx("vehicle/treadfx/fx_heli_water_spray");
	loadfx("vehicle/exhaust/fx_exhaust_huey_engine");
	level._effect["heli_gunner"]["vtol_fx"] = loadfx("vehicle/exhaust/fx_exhaust_vtol_mp");
	level._effect["heli_gunner"]["vtol_fx_rt"] = loadfx("vehicle/exhaust/fx_exhaust_vtol_rt_mp");
	precacheitem("chopper_minigun_mp");
	precacheitem("heli_gunner_rockets_mp");
	level.chopper_defs["player_gunner"] = "heli_player_gunner_mp";
	level.chopper_models["player_gunner"]["friendly"] = "veh_t6_air_v78_vtol_killstreak";
	level.chopper_models["player_gunner"]["enemy"] = "veh_t6_air_v78_vtol_killstreak_alt";
	foreach(team in level.teams)
	{
		level.chopper_death_models["player_gunner"][team] = "t5_veh_helo_hind_dead";
		level.chopper_sounds["player_gunner"][team] = "mpl_kls_hind_helicopter";
	}

	level.chopper_death_models["player_gunner"]["allies"] = "t5_veh_helo_hind_dead";
	level.chopper_death_models["player_gunner"]["axis"] = "t5_veh_helo_hind_dead";
	level.chopper_sounds["player_gunner"]["allies"] = "mpl_kls_cobra_helicopter";
	level.chopper_sounds["player_gunner"]["axis"] = "mpl_kls_hind_helicopter";
	level.chaff_offset["player_gunner"] = (-185,0,-85);
	precachemodel(level.chopper_models["player_gunner"]["friendly"]);
	precachemodel(level.chopper_models["player_gunner"]["enemy"]);
	precachevehicle(level.chopper_defs["player_gunner"]);
	level.chopper_infrared_vision = "remote_mortar_infrared";
	level.chopper_enhanced_vision = "remote_mortar_enhanced";
	level._effect["heli_gunner_light"]["friendly"] = loadfx("light/fx_vlight_mp_vtol_grn");
	level._effect["heli_gunner_light"]["enemy"] = loadfx("light/fx_vlight_mp_vtol_red");
	level.heligunnervtolupanim = %veh_anim_v78_vtol_engine_left;
	level.heligunnervtoldownanim = %veh_anim_v78_vtol_engine_right;
	level.heli_angle_offset = 90;
	level.heli_forced_wait = 0;
}

//Function Number: 2
heli_gunner_killstreak(hardpointtype)
{
/#
	assert(hardpointtype == "helicopter_player_gunner_mp");
#/
	if(!IsDefined(level.heli_paths) || !level.heli_paths.size)
	{
/#
		println("No helicopter paths found in map");
#/
		return 0;
	}

	if(!IsDefined(level.heli_primary_path) || !level.heli_primary_path.size)
	{
/#
		println("No primary helicopter path found in map");
#/
		return 0;
	}

	if(!(self maps/mp/killstreaks/_killstreakrules::iskillstreakallowed(hardpointtype,self.team)))
	{
		return 0;
	}

	if(is_true(self.isplanting))
	{
		return 0;
	}

	if(is_true(self.isdefusing))
	{
		return 0;
	}

	if(!self isonground() || self isusingremote())
	{
		self iprintlnbold(&"KILLSTREAK_CHOPPER_GUNNER_NOT_USABLE");
		return 0;
	}

	result = self heli_gunner_spawn(hardpointtype);
	if(level.gameended)
	{
		return 1;
	}

	if(!(IsDefined(result)))
	{
		return 0;
	}
}

//Function Number: 3
heli_gunner_spawn(hardpointtype)
{
	self endon("disconnect");
	level endon("game_ended");
	self setusingremote(hardpointtype);
	result = self maps/mp/killstreaks/_killstreaks::initridekillstreak("qrdrone");
	if(result != "success")
	{
		if(result != "disconnect")
		{
			self clearusingremote();
		}

		return 0;
	}

	if(!(self starthelicopter("player_gunner",0,hardpointtype,level.heli_primary_path[0])))
	{
		self clearusingremote();
		return 0;
	}

	if(IsDefined(self.carryicon))
	{
		self.prevcarryiconalpha = self.carryicon.alpha;
		self.carryicon.alpha = 0;
	}

	self thread maps/mp/killstreaks/_helicopter::announcehelicopterinbound(hardpointtype);
	self.heli maps/mp/killstreaks/_helicopter::heli_reset();
	self.heli usevehicle(self,0);
	self setplayerangles(self.heli gettagangles("tag_player"));
	self.heli.zoffset = VectorScale((0,0,1));
	self.heli.playermovedrecently = 0;
	self.heli.soundmod = "default_loud";
	attack_nodes = getentarray("heli_attack_area","targetname");
	if(attack_nodes.size)
	{
		self.heli thread heli_fly_well(level.heli_primary_path[0],attack_nodes);
		self thread change_location(attack_nodes);
	}
	else
	{
		self.heli thread maps/mp/killstreaks/_helicopter::heli_fly(level.heli_primary_path[0],0,hardpointtype);
	}

	self.pilotvoicenumber = self.bcvoicenumber + 1;
	if(self.pilotvoicenumber > 3)
	{
		self.pilotvoicenumber = 0;
	}

	wait(1);
	if(!(IsDefined(self.heli)))
	{
		return 0;
	}

	self.heli thread fireheliweapon(self);
	self.heli thread hind_watch_rocket_fire(self);
	self.heli thread look_with_player(self);
	self.heli thread play_lockon_sounds(self);
	target_setturretaquire(self.heli,1);
	self.heli.lockondelay = 0;
	self.heli waittill_any("death","leaving","abandoned");
	if(IsDefined(self.heli) && IsDefined(self.heli.targetent))
	{
		self.heli.targetent delete();
	}

	return 1;
}

//Function Number: 4
play_lockon_sounds(player)
{
	player endon("disconnect");
	self endon("death");
	self endon("exit_vehicle");
	self endon("heli_timeup");
	self endon("crashing");
	self endon("leaving");
	self.locksounds = spawn("script_model",self.origin);
	wait(0.1);
	self.locksounds linkto(self,"tag_player");
	while(1)
	{
		self waittill("locking on");
		while(1)
		{
			if(enemy_locking())
			{
				self.locksounds playsoundtoplayer("uin_alert_lockon",player);
				wait(0.125);
			}

			if(enemy_locked())
			{
				self.locksounds playsoundtoplayer("uin_alert_lockon",player);
				wait(0.125);
			}

			if(!enemy_locking() && !enemy_locked())
			{
				self.locksounds stopsounds();
				break;
			}
		}
	}
}

//Function Number: 5
enemy_locking()
{
	if(IsDefined(self.locking_on) && self.locking_on)
	{
		return 1;
	}
}

//Function Number: 6
enemy_locked()
{
	if(IsDefined(self.locked_on) && self.locked_on)
	{
		return 1;
	}
}

//Function Number: 7
look_with_player(player)
{
	player endon("disconnect");
	self endon("death");
	self endon("exit_vehicle");
	self endon("heli_timeup");
	self endon("crashing");
	self endon("leaving");
	while(1)
	{
		self setgoalyaw(player getplayerangles()[1]);
		wait(0.05);
	}
}

//Function Number: 8
change_location(destnodes)
{
	self.heli endon("death");
	self.heli endon("crashing");
	self.heli endon("leaving");
	self.moves = 0;
	self.heli waittill("near_goal");
	self.heli waittill("goal");
	for(;;)
	{
		if(self secondaryoffhandbuttonpressed())
		{
			self.moves++;
			self thread player_moved_recently_think();
			currentnode = self get_best_area_attack_node(destnodes,1);
			self playsoundtoplayer("mpl_cgunner_nav",self);
			self.heli traveltonode(currentnode);
			if(IsDefined(currentnode.script_airspeed) && IsDefined(currentnode.script_accel))
			{
				heli_speed = currentnode.script_airspeed;
				heli_accel = currentnode.script_accel;
			}
			else
			{
				heli_speed = 80 + randomint(20);
				heli_accel = 40 + randomint(10);
			}

			self.heli setspeed(heli_speed,heli_accel);
			self.heli setvehgoalpos(currentnode.origin + self.heli.zoffset,1);
			self.heli setgoalyaw(currentnode.angles[1] + level.heli_angle_offset);
			self.heli waittill("goal");
			while(self secondaryoffhandbuttonpressed())
			{
				wait(0.05);
			}
		}

		wait(0.05);
	}
}

//Function Number: 9
player_moved_recently_think()
{
	self endon("death");
	self endon("crashing");
	self endon("leaving");
	mymove = self.moves;
	self.heli.playermovedrecently = 1;
	wait(15);
	if(mymove == self.moves && IsDefined(self.heli))
	{
		self.heli.playermovedrecently = 0;
	}
}

//Function Number: 10
heli_fly_well(startnode,destnodes)
{
	self notify("flying");
	self endon("flying");
	self endon("death");
	self endon("crashing");
	self endon("leaving");
	nextnode = getent(startnode.target,"targetname");
/#
	assert(IsDefined(nextnode),"Next node in path is undefined, but has targetname");
#/
	self setspeed(150,80);
	self setvehgoalpos(nextnode.origin + self.zoffset,1);
	self waittill("near_goal");
	for(;;)
	{
		if(!(self.playermovedrecently))
		{
			currentnode = self get_best_area_attack_node(destnodes,0);
			traveltonode(currentnode);
			if(IsDefined(currentnode.script_airspeed) && IsDefined(currentnode.script_accel))
			{
				heli_speed = currentnode.script_airspeed;
				heli_accel = currentnode.script_accel;
			}
			else
			{
				heli_speed = 80 + randomint(20);
				heli_accel = 40 + randomint(10);
			}

			self setspeed(heli_speed,heli_accel);
			self setvehgoalpos(currentnode.origin + self.zoffset,1);
			self setgoalyaw(currentnode.angles[1] + level.heli_angle_offset);
		}

		if(level.heli_forced_wait != 0)
		{
			self waittill("near_goal");
			wait(level.heli_forced_wait);
			continue;
		}

		if(!(IsDefined(currentnode.script_delay)))
		{
			self waittill("near_goal");
			wait(10 + randomint(5));
			continue;
		}

		self waittillmatch
		return;
		("goal");
		wait(currentnode.script_delay);
	}
}

//Function Number: 11
get_best_area_attack_node(destnodes,forcemove)
{
	return updateareanodes(destnodes,forcemove);
}

//Function Number: 12
updateareanodes(areanodes,forcemove)
{
	validenemies = [];
	foreach(node in areanodes)
	{
		node.validplayers = [];
		node.nodescore = 0;
	}

	foreach(player in level.players)
	{
		if(!(isalive(player)))
		{
		}
		else if(player.team == self.team)
		{
		}
		else
		{
			foreach(node in areanodes)
			{
				if(distancesquared(player.origin,node.origin) > 1048576)
				{
				}
				else
				{
					node.validplayers[node.validplayers.size] = player;
				}
			}
		}
	}

	bestnode = areanodes[0];
	foreach(node in areanodes)
	{
		helinode = getent(node.target,"targetname");
		foreach(player in node.validplayers)
		{
			node.nodescore = node.nodescore + 1;
			if(bullettracepassed(32 + VectorScale((0,0,1)),player.origin,helinode.origin,0))
			{
				node.nodescore = node.nodescore + 3;
			}
		}

		if(forcemove && distance(self.heli.origin,helinode.origin) < 200)
		{
			node.nodescore = -1;
		}

		if(node.nodescore > bestnode.nodescore)
		{
			bestnode = node;
		}
	}

	return getent(bestnode.target,"targetname");
}

//Function Number: 13
traveltonode(goalnode)
{
	originoffets = getoriginoffsets(goalnode);
	if(originoffets["start"] != self.origin)
	{
		if(IsDefined(goalnode.script_airspeed) && IsDefined(goalnode.script_accel))
		{
			heli_speed = goalnode.script_airspeed;
			heli_accel = goalnode.script_accel;
		}
		else
		{
			heli_speed = 30 + randomint(20);
			heli_accel = 15 + randomint(15);
		}

		self setspeed(heli_speed,heli_accel);
		self setvehgoalpos(30 + VectorScale((0,0,1)),originoffets["start"]);
		self setgoalyaw(goalnode.angles[1] + level.heli_angle_offset);
		self waittill(0,"goal");
	}

	if(originoffets["end"] != goalnode.origin)
	{
		if(IsDefined(goalnode.script_airspeed) && IsDefined(goalnode.script_accel))
		{
			heli_speed = goalnode.script_airspeed;
			heli_accel = goalnode.script_accel;
		}
		else
		{
			heli_speed = 30 + randomint(20);
			heli_accel = 15 + randomint(15);
		}

		self setspeed(heli_speed,heli_accel);
		self setvehgoalpos(30 + VectorScale((0,0,1)),originoffets["end"]);
		self setgoalyaw(goalnode.angles[1] + level.heli_angle_offset);
		self waittill(0,"goal");
	}
}

//Function Number: 14
getoriginoffsets(goalnode)
{
	startorigin = self.origin;
	endorigin = goalnode.origin;
	numtraces = 0;
	maxtraces = 40;
	traceoffset = VectorScale((0,0,-1));
	for(traceorigin = bullettrace(startorigin + traceoffset,endorigin + traceoffset,0,self);distancesquared(traceorigin["position"],endorigin + traceoffset) > 10 && numtraces < maxtraces;traceorigin = bullettrace(startorigin + traceoffset,endorigin + traceoffset,0,self))
	{
/#
		println("trace failed: " + distancesquared(traceorigin["position"],endorigin + traceoffset));
#/
		if(startorigin[2] < endorigin[2])
		{
			startorigin = 128 + VectorScale((0,0,1));
		}
		else if(startorigin[2] > endorigin[2])
		{
			endorigin = 128 + VectorScale((0,0,1));
		}
		else
		{
			startorigin = 128 + VectorScale((0,0,1));
			endorigin = 128 + VectorScale((0,0,1));
		}

/#
#/
		numtraces++;
	}

	offsets = [];
	offsets["start"] = startorigin;
	offsets["end"] = endorigin;
	return offsets;
}

//Function Number: 15
starthelicopter(type,player_driven,hardpointtype,startnode)
{
	self endon("disconnect");
	self endon("game_ended");
	team = self.team;
	killstreak_id = self maps/mp/killstreaks/_killstreakrules::killstreakstart(hardpointtype,team,undefined,0);
	if(killstreak_id == -1)
	{
		return 0;
	}

	self.enteringvehicle = 1;
	self freeze_player_controls(1);
	if(team != self.team)
	{
		self maps/mp/killstreaks/_killstreakrules::killstreakstop(hardpointtype,team,killstreak_id);
		return 0;
	}

	if(!(IsDefined(self.heli)))
	{
		heli = spawnplayerhelicopter(self,type,startnode.origin,startnode.angles,hardpointtype);
		if(!(IsDefined(heli)))
		{
			self freeze_player_controls(0);
			maps/mp/killstreaks/_killstreakrules::killstreakstop(hardpointtype,team,killstreak_id);
			self.enteringvehicle = 0;
			return 0;
		}

		self.heli = heli;
		self.heli.killstreak_id = killstreak_id;
	}

	if(!(isalive(self)))
	{
		if(IsDefined(self.heli))
		{
			self deleteplayerheli();
		}
		else
		{
			self maps/mp/killstreaks/_killstreakrules::killstreakstop(hardpointtype,team,killstreak_id);
		}

		debug_print_heli(">>>>>>>startHelicopter: player dead while starting");
		self notify("heli_timeup");
		self freeze_player_controls(0);
		self.enteringvehicle = 0;
		return 0;
	}

	if(level.gameended)
	{
		maps/mp/killstreaks/_killstreakrules::killstreakstop(hardpointtype,team,killstreak_id);
		self.enteringvehicle = 0;
		return 0;
	}

	self thread inithelicopter(player_driven,hardpointtype);
	self freeze_player_controls(0);
	self.enteringvehicle = 0;
	self stopshellshock();
	if(IsDefined(level.killstreaks[hardpointtype]) && IsDefined(level.killstreaks[hardpointtype].inboundtext))
	{
		level thread maps/mp/_popups::displaykillstreakteammessagetoall(hardpointtype,self);
	}

	self thread visionswitch(0);
	return 1;
}

//Function Number: 16
fireheliweapon(player)
{
	while(1)
	{
		self waittill("turret_fire");
		self fireweapon("tag_flash");
		earthquake(0.05,0.05,self.origin,1000);
	}
}

//Function Number: 17
spawnplayerhelicopter(owner,type,origin,angles,hardpointtype)
{
	debug_print_heli(">>>>>>>spawnHelicopter " + type);
	heli = maps/mp/killstreaks/_helicopter::spawn_helicopter(self,origin,angles,level.chopper_defs[type],level.chopper_models[type]["friendly"],VectorScale((0,0,-1)),100);
	if(!(IsDefined(heli)))
	{
		return undefined;
	}

	target_setturretaquire(heli,0);
	heli.lockondelay = 1;
	heli setenemymodel(level.chopper_models[type]["enemy"]);
	heli.chaff_offset = level.chaff_offset[type];
	heli.death_model = level.chopper_death_models[type][owner.team];
	heli playloopsound(level.chopper_sounds[type][owner.team]);
	heli.defaultweapon = "cobra_20mm_mp";
	heli.owner = owner;
	heli.team = owner.team;
	heli setowner(owner);
	heli setteam(owner.team);
	heli.destroyfunc = ::destroyplayerhelicopter;
	snd_ent = spawn("script_origin",heli gettagorigin("snd_cockpit"));
	snd_ent linkto(heli,"snd_cockpit",(0,0,0),(0,0,0));
	heli.snd_ent = snd_ent;
	if(IsDefined(level.chopper_interior_models) && IsDefined(level.chopper_interior_models[type]) && IsDefined(level.chopper_interior_models[type][owner.team]))
	{
		heli.interior_model = spawn("script_model",heli.origin);
		heli.interior_model setmodel(level.chopper_interior_models[type][owner.team]);
		heli.interior_model linkto(heli,"tag_origin",(0,0,0),(0,0,0));
	}

	heli.killcament = owner;
	heli makevehicleunusable();
	maps/mp/_treadfx::loadtreadfx(heli);
	return heli;
}

//Function Number: 18
deleteplayerheli()
{
	self notify("heli_timeup");
	debug_print_heli(">>>>>>>Unlink and delete (deletePlayerHeli)");
	if(IsDefined(self.viewlockedentity))
	{
		self unlink();
	}

	self.heli maps/mp/killstreaks/_helicopter::destroyhelicopter();
	self.heli = undefined;
}

//Function Number: 19
destroyplayerhelicopter()
{
	if(IsDefined(self.owner) && IsDefined(self.owner.heli))
	{
		self.owner deleteplayerheli();
	}
	else
	{
		self maps/mp/killstreaks/_helicopter::destroyhelicopter();
	}
}

//Function Number: 20
debug_print_heli(msg)
{
/#
	if(GetDvar(#"2CCCDCB5") == "")
	{
		setdvar("scr_debugheli","0");
	}

	if(GetDvarInt(#"2CCCDCB5") == 1)
	{
		println(msg);
	}
#/
}

//Function Number: 21
inithelicopter(isdriver,hardpointtype)
{
	self.heli.reached_dest = 0;
	switch(hardpointtype)
	{
		case "helicopter_gunner_mp":
			self.heli.maxhealth = level.heli_amored_maxhealth;
			break;

		case "helicopter_player_firstperson_mp":
			self.heli.maxhealth = level.heli_amored_maxhealth;
			break;

		case "helicopter_player_gunner_mp":
			self.heli.maxhealth = level.heli_amored_maxhealth;
			break;

		default:
			self.heli.maxhealth = level.heli_amored_maxhealth;
			break;
	}

	self.heli.rocketdamageoneshot = self.heli.maxhealth + 1;
	self.heli.rocketdamagetwoshot = self.heli.maxhealth / 2 + 1;
	self.heli.numflares = 2;
	self.heli.nflareoffset = VectorScale((0,0,-1));
	self.heli.waittime = 0;
	self.heli.loopcount = 0;
	self.heli.evasive = 0;
	self.heli.health_bulletdamageble = level.heli_armor;
	self.heli.health_evasive = level.heli_armor;
	self.heli.health_low = self.heli.maxhealth * 0.8;
	self.heli.targeting_delay = level.heli_targeting_delay;
	self.heli.primarytarget = undefined;
	self.heli.secondarytarget = undefined;
	self.heli.attacker = undefined;
	self.heli.missile_ammo = level.heli_missile_max;
	self.heli.currentstate = "ok";
	self.heli.lastrocketfiretime = -1;
	self.heli.maxlifetime = 55000;
	self.heli.donotstop = 1;
	self.heli.targetent = spawn("script_model",(0,0,0));
	self.heli.targetent setmodel("tag_origin");
	self.heli.health = 99999999;
	self.heli setturningability(1);
	self.heli.starttime = GetTime();
	self.heli.startingteam = self.team;
	self.heli.startinggametype = level.gametype;
	if(isdriver)
	{
		self.heli thread hind_setup_rocket_attack(hardpointtype,self);
		self.heli thread hind_watch_rocket_fire(self);
		self.heli.current_weapon = "mini_gun";
		self.heli.numberrockets = 2;
		self.heli.numberminigun = 999;
		self.heli setjitterparams(VectorScale((1,1,1)),3,0.5);
	}
	else
	{
		self.heli.numberrockets = 4;
		self.heli.rocketregentime = 3;
		self.heli.rocketreloadtime = 6;
		self.heli.rocketrefiretime = 0.15;
	}

	self create_hud(isdriver);
	self thread watchforearlyleave(hardpointtype);
	self thread waitfortimeout(hardpointtype);
	self thread exitheliwaiter();
	self thread gameendheliwaiter(hardpointtype);
	self thread heli_owner_exit(hardpointtype);
	self thread heli_owner_teamkillkicked(hardpointtype);
	self.heli thread maps/mp/killstreaks/_helicopter::heli_damage_monitor(hardpointtype);
	self.heli thread maps/mp/killstreaks/_helicopter::heli_kill_monitor(hardpointtype);
	self.heli thread maps/mp/_heatseekingmissile::missiletarget_lockonmonitor(self,"crashing","death");
	self.heli thread maps/mp/_heatseekingmissile::missiletarget_proximitydetonateincomingmissile("crashing","death");
	self.heli thread create_flare_ent(VectorScale((0,0,-1)));
	self.heli maps/mp/gametypes/_spawning::create_helicopter_influencers(self.team);
	self.heli thread heli_player_damage_monitor(self);
	self.heli thread heli_health_player(self,hardpointtype);
	self.heli thread debugtags();
}

//Function Number: 22
player_heli_reset()
{
	self cleartargetyaw();
	self cleargoalyaw();
	self setspeed(45,25);
	self setyawspeed(75,45,45);
	self setmaxpitchroll(30,40);
	self setneargoalnotifydist(256);
	self setturningability(0.3);
}

//Function Number: 23
visionswitch(delay)
{
	self endon("disconnect");
	self.heli endon("crashing");
	self.heli endon("leaving");
	self.heli endon("death");
	wait(delay);
	inverted = 0;
	self setinfraredvision(0);
	self useservervisionset(1);
	self setvisionsetforplayer(level.chopper_enhanced_vision,1);
	self setclientflag(3);
	self clientnotify("cgfutz");
	for(;;)
	{
		if(self changeseatbuttonpressed())
		{
			if(!(inverted))
			{
				self setinfraredvision(1);
				self setvisionsetforplayer(level.chopper_infrared_vision,0.5);
				self playsoundtoplayer("mpl_cgunner_flir_on",self);
			}
			else
			{
				self setinfraredvision(0);
				self setvisionsetforplayer(level.chopper_enhanced_vision,0.5);
				self playsoundtoplayer("mpl_cgunner_flir_off",self);
			}

			inverted = !inverted;
			while(self changeseatbuttonpressed())
			{
				wait(0.05);
			}
		}

		wait(0.05);
	}
}

//Function Number: 24
hind_setup_rocket_attack(hardpointtype,player)
{
	wait(1);
	self endon("death");
	self endon("heli_timeup");
	self notify("stop_turret_shoot");
	self endon("stop_turret_shoot");
	index = 0;
	while(IsDefined(self) && self.health > 0)
	{
		self waittill("turret_fire");
		if(self.current_weapon == "rockets")
		{
			self.current_weapon = "mini_gun";
			self fireweapon();
			self.numberminigun = self.numberminigun - 1;
			if(IsDefined(player.ammo_hud))
			{
				player.ammo_hud setvalue(self.numberminigun);
			}

			wait(0.3);
		}
	}
}

//Function Number: 25
rocket_ammo_think(player)
{
	player endon("disconnect");
	self endon("death");
	self endon("exit_vehicle");
	self endon("heli_timeup");
	while(1)
	{
		while(self.numberrockets == 4)
		{
			wait(0.05);
		}

		wait(self.rocketregentime);
		self.numberrockets++;
	}
}

//Function Number: 26
hind_watch_rocket_fire(player)
{
	player endon("disconnect");
	self endon("death");
	self endon("exit_vehicle");
	self endon("heli_timeup");
	self endon("crashing");
	self endon("leaving");
	self thread watchforoverheat(player);
	while(IsDefined(self) && self.health > 0 && IsDefined(self.targetent))
	{
		player waittill("missile_fire",missile);
		missile.killcament = player;
		origin = player geteye();
		forward = AnglesToForward(player getplayerangles());
		endpoint = origin + forward * 15000;
		trace = bullettrace(origin,endpoint,0,self);
		missile missile_settarget(self.targetent,trace["position"]);
	}

	self notify("endWatchForOverheat");
}

//Function Number: 27
watchforoverheat(player)
{
	player endon("disconnect");
	self endon("death");
	self endon("exit_vehicle");
	self endon("heli_timeup");
	self endon("crashing");
	self endon("leaving");
	self endon("endWatchForOverheat");
	while(1)
	{
		self waittill("gunner_turret_overheat");
		self thread reload_rocket_audio(player);
		self waittill("gunner_turret_stop_overheat");
	}
}

//Function Number: 28
reload_rocket_audio(player)
{
	player endon("disconnect");
	self endon("death");
	self endon("exit_vehicle");
	self endon("heli_timeup");
	self endon("crashing");
	self endon("leaving");
	self endon("endWatchForOverheat");
	self endon("gunner_turret_stop_overheat");
	for(i = 0;i < 5;i++)
	{
		wait(1);
		player playlocalsound("wpn_gunner_rocket_fire_reload_plr");
	}
}

//Function Number: 29
hind_out_of_rockets(player)
{
	player endon("disconnect");
	self endon("death");
	self endon("exit_vehicle");
	self endon("heli_timeup");
	if(IsDefined(player.alt_title))
	{
		player.alt_title.alpha = 0;
	}

	if(IsDefined(player.alt_ammo_hud))
	{
		player.alt_ammo_hud.alpha = 0;
	}

	wait(max(0,level.heli_missile_reload_time - 0.5));
	self.snd_ent playsound(level.chopper_sounds["missile_reload"]);
	wait(0.5);
	if(IsDefined(player.alt_title))
	{
		player.alt_title.alpha = 1;
	}

	if(IsDefined(player.alt_ammo_hud))
	{
		player.alt_ammo_hud.alpha = 1;
	}

	self.numberrockets = 2;
	if(IsDefined(player.alt_ammo_hud))
	{
		player.alt_ammo_hud setvalue(2);
	}
}

//Function Number: 30
fire_rocket(tagname,player)
{
	start_origin = self gettagorigin(tagname);
	trace_angles = self gettagangles("tag_flash");
	forward = AnglesToForward(trace_angles);
	trace_origin = self gettagorigin("tag_flash");
	trace_direction = self gettagangles("tag_barrel");
	trace_direction = AnglesToForward(trace_direction) * 5000;
	trace = bullettrace(trace_origin,trace_origin + trace_direction,0,self);
	end_origin = trace["position"];
	magicbullet("heli_gunner_rockets_mp",start_origin,end_origin,self);
	player playlocalsound("wpn_gunner_rocket_fire_plr");
	self playsound("wpn_rpg_fire_npc");
	player playrumbleonentity("damage_heavy");
	earthquake(0.35,0.5,start_origin,1000,self);
}

//Function Number: 31
create_gunner_hud()
{
	self.minigun_hud = newclienthudelem(self);
	self.minigun_hud.alignx = "left";
	self.minigun_hud.aligny = "bottom";
	self.minigun_hud.horzalign = "user_left";
	self.minigun_hud.vertalign = "user_bottom";
	self.minigun_hud.font = "small";
	self.minigun_hud settext(&"MP_HELI_FIRE_MINIGUN");
	self.minigun_hud.hidewheninmenu = 1;
	self.minigun_hud.hidewhenindemo = 1;
	self.minigun_hud.x = 30;
	self.minigun_hud.y = -70;
	self.minigun_hud.fontscale = 1.25;
	self.zoom_hud = newclienthudelem(self);
	self.zoom_hud.alignx = "left";
	self.zoom_hud.aligny = "bottom";
	self.zoom_hud.horzalign = "user_left";
	self.zoom_hud.vertalign = "user_bottom";
	self.zoom_hud.font = "small";
	self.zoom_hud settext(&"KILLSTREAK_INCREASE_ZOOM");
	self.zoom_hud.hidewheninmenu = 1;
	self.zoom_hud.hidewhenindemo = 1;
	self.zoom_hud.x = 30;
	self.zoom_hud.y = -55;
	self.zoom_hud.fontscale = 1.25;
	self.missile_hud = newclienthudelem(self);
	self.missile_hud.alignx = "left";
	self.missile_hud.aligny = "bottom";
	self.missile_hud.horzalign = "user_left";
	self.missile_hud.vertalign = "user_bottom";
	self.missile_hud.font = "small";
	self.missile_hud settext(&"MP_HELI_FIRE_MISSILES");
	self.missile_hud.hidewheninmenu = 1;
	self.missile_hud.hidewhenindemo = 1;
	self.missile_hud.x = 30;
	self.missile_hud.y = -40;
	self.missile_hud.fontscale = 1.25;
	self.move_hud = newclienthudelem(self);
	self.move_hud.alignx = "left";
	self.move_hud.aligny = "bottom";
	self.move_hud.horzalign = "user_left";
	self.move_hud.vertalign = "user_bottom";
	self.move_hud.font = "small";
	self.move_hud settext(&"MP_HELI_NEW_LOCATION");
	self.move_hud.hidewheninmenu = 1;
	self.move_hud.hidewhenindemo = 1;
	self.move_hud.x = 30;
	self.move_hud.y = -25;
	self.move_hud.fontscale = 1.25;
	self.hud_prompt_exit = newclienthudelem(self);
	self.hud_prompt_exit.alignx = "left";
	self.hud_prompt_exit.aligny = "bottom";
	self.hud_prompt_exit.horzalign = "user_left";
	self.hud_prompt_exit.vertalign = "user_bottom";
	self.hud_prompt_exit.font = "small";
	self.hud_prompt_exit.fontscale = 1.25;
	self.hud_prompt_exit.hidewheninmenu = 1;
	self.hud_prompt_exit.hidewhenindemo = 1;
	self.hud_prompt_exit.archived = 0;
	self.hud_prompt_exit.x = 30;
	self.hud_prompt_exit.y = -10;
	self.hud_prompt_exit settext(level.remoteexithint);
	self thread fade_out_hint_hud();
}

//Function Number: 32
fade_out_hint_hud()
{
	wait(8);
	time = 0;
	while(time < 2)
	{
		if(!(IsDefined(self.minigun_hud)))
		{
			return;
		}

		self.minigun_hud.alpha = self.minigun_hud.alpha - 0.025;
		self.zoom_hud.alpha = self.zoom_hud.alpha - 0.025;
		time = time + 0.05;
		wait(0.05);
	}

	if(!(IsDefined(self.minigun_hud)))
	{
		return;
	}

	self.minigun_hud.alpha = 0;
	self.zoom_hud.alpha = 0;
}

//Function Number: 33
create_hud(isdriver)
{
	debug_print_heli(">>>>>>>create_hud");
	if(isdriver)
	{
		hud_minigun_create();
		hud_rocket_create();
		self.leaving_play_area = newclienthudelem(self);
		self.leaving_play_area.fontscale = 1.25;
		self.leaving_play_area.x = 0;
		self.leaving_play_area.y = 50;
		self.leaving_play_area.alignx = "center";
		self.leaving_play_area.aligny = "top";
		self.leaving_play_area.horzalign = "user_center";
		self.leaving_play_area.vertalign = "user_top";
		self.leaving_play_area.hidewhendead = 0;
		self.leaving_play_area.hidewheninmenu = 1;
		self.leaving_play_area.archived = 0;
		self.leaving_play_area.alpha = 0;
		self.leaving_play_area settext(&"MP_HELI_LEAVING_BATTLEFIELD");
	}
}

//Function Number: 34
remove_hud()
{
	debug_print_heli(">>>>>>>remove_hud");
	if(IsDefined(self.ammo_hud))
	{
		self.ammo_hud destroy();
	}

	if(IsDefined(self.title))
	{
		self.title destroy();
	}

	if(IsDefined(self.alt_ammo_hud))
	{
		self.alt_ammo_hud destroy();
	}

	if(IsDefined(self.alt_title))
	{
		self.alt_title destroy();
	}

	if(IsDefined(self.leaving_play_area))
	{
		self.leaving_play_area destroy();
	}

	if(IsDefined(self.minigun_hud))
	{
		self.minigun_hud destroy();
	}

	if(IsDefined(self.missile_hud))
	{
		self.missile_hud destroy();
	}

	if(IsDefined(self.zoom_hud))
	{
		self.zoom_hud destroy();
	}

	if(IsDefined(self.move_hud))
	{
		self.move_hud destroy();
	}

	if(IsDefined(self.hud_prompt_exit))
	{
		self.hud_prompt_exit destroy();
	}

	self.ammo_hud = undefined;
	self.alt_ammo_hud = undefined;
	self.alt_title = undefined;
	self.leaving_play_area = undefined;
	self clearclientflag(3);
	self clientnotify("nofutz");
	self notify("hind weapons disabled");
}

//Function Number: 35
gameendheliwaiter(hardpointtype)
{
	self endon("disconnect");
	self endon("heli_timeup");
	level waittill("game_ended");
	debug_print_heli(">>>>>>>gameEndHeliWaiter");
	self thread player_heli_leave(hardpointtype);
}

//Function Number: 36
heli_owner_teamkillkicked(hardpointtype)
{
	self endon("disconnect");
	self endon("heli_timeup");
	self waittill("teamKillKicked");
	self thread player_heli_leave(hardpointtype);
}

//Function Number: 37
heli_owner_exit(hardpointtype)
{
	self endon("disconnect");
	self endon("heli_timeup");
	wait(1);
	while(1)
	{
		timeused = 0;
		while(self usebuttonpressed())
		{
			timeused = timeused + 0.05;
			if(timeused > 0.25)
			{
				self thread player_heli_leave(hardpointtype);
				return;
			}

			wait(0.05);
		}

		wait(0.05);
	}
}

//Function Number: 38
exitheliwaiter()
{
	self endon("disconnect");
	self waittill("heli_timeup");
	debug_print_heli(">>>>>>>exitHeliWaiter");
	self remove_hud();
	if(IsDefined(self.heli))
	{
		debug_print_heli(">>>>>>>Unlink and delete (exitHeliWaiter)");
		if(IsDefined(self.viewlockedentity))
		{
			self unlink();
			if(IsDefined(level.gameended) && level.gameended)
			{
				self freezecontrolswrapper(1);
			}
		}

		self.heli = undefined;
	}

	self setinfraredvision(0);
	self useservervisionset(0);
	self.killstreak_waitamount = undefined;
	if(IsDefined(self.carryicon))
	{
		self.carryicon.alpha = self.prevcarryiconalpha;
	}

	if(IsDefined(self))
	{
		self clearusingremote();
	}
}

//Function Number: 39
heli_player_damage_monitor(player)
{
	player endon("disconnect");
	self endon("death");
	self endon("crashing");
	self endon("leaving");
	for(;;)
	{
		self waittill("damage",damage,attacker,direction,point,type);
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

		if(type == "MOD_PISTOL_BULLET" || type == "MOD_RIFLE_BULLET")
		{
			earthquake(0.1,0.5,point,1000,player);
		}

		if(type == "MOD_PROJECTILE")
		{
			earthquake(0.7,1.5,point,1000,player);
		}

		player sendkillstreakdamageevent(int(damage));
	}
}

//Function Number: 40
heli_health_player(player,hardpointtype)
{
	if(!(isalive(player)))
	{
		if(IsDefined(self.heli))
		{
			self deleteplayerheli();
		}

		debug_print_heli(">>>>>>>send notify [dead before starting]");
		player notify("heli_timeup");
	}

	self thread maps/mp/killstreaks/_helicopter::heli_health(hardpointtype,player,"heli_timeup");
}

//Function Number: 41
debugtag(tagname)
{
/#
	start_origin = self gettagorigin(tagname);
	if(IsDefined(start_origin))
	{
		sphere(start_origin,5,(1,0,0),1,1,10,1);
	}
#/
}

//Function Number: 42
debugtags()
{
	self endon("death");
	while(1)
	{
		wait(0.05);
		tagname = GetDvar(#"CEED6282");
		if(!IsDefined(tagname) || tagname == "")
		{
			continue;
		}

		self debugtag(tagname);
	}
}

//Function Number: 43
hud_minigun_create()
{
	if(!(IsDefined(self.minigun_hud)))
	{
		self.minigun_hud = [];
	}

	self.minigun_hud["gun"] = newclienthudelem(self);
	self.minigun_hud["gun"].alignx = "right";
	self.minigun_hud["gun"].aligny = "bottom";
	self.minigun_hud["gun"].horzalign = "user_right";
	self.minigun_hud["gun"].vertalign = "user_bottom";
	self.minigun_hud["gun"].alpha = 0.55;
	self.minigun_hud["gun"] fadeovertime(0.05);
	self.minigun_hud["gun"].y = 0;
	self.minigun_hud["gun"].x = 23;
	self.minigun_hud["gun"] setshader("hud_hind_cannon01",64,64);
	self.minigun_hud["gun"].hidewheninmenu = 1;
	self.minigun_hud["button"] = newclienthudelem(self);
	self.minigun_hud["button"].alignx = "right";
	self.minigun_hud["button"].aligny = "bottom";
	self.minigun_hud["button"].horzalign = "user_right";
	self.minigun_hud["button"].vertalign = "user_bottom";
	self.minigun_hud["button"].font = "small";
	self.minigun_hud["button"] settext("[{+attack}]");
	self.minigun_hud["button"].hidewheninmenu = 1;
	if(level.ps3)
	{
		self.minigun_hud["button"].x = -30;
		self.minigun_hud["button"].y = -4;
		self.minigun_hud["button"].fontscale = 1.25;
	}
	else
	{
		self.minigun_hud["button"].x = -28;
		self.minigun_hud["button"].y = -6;
		self.minigun_hud["button"].fontscale = 1;
	}

	self thread hud_minigun_destroy();
}

//Function Number: 44
hud_minigun_destroy()
{
	self waittill("hind weapons disabled");
	self.minigun_hud["gun"] destroy();
	self.minigun_hud["button"] destroy();
}

//Function Number: 45
hud_minigun_think()
{
	self endon("hind weapons disabled");
	self endon("disconnect");
	player = get_players()[0];
	while(1)
	{
		while(!(player attackbuttonpressed()))
		{
			wait(0.05);
		}

		swap_counter = 1;
		self.minigun_hud["gun"] fadeovertime(0.05);
		self.minigun_hud["gun"].alpha = 0.65;
		while(player attackbuttonpressed())
		{
			wait(0.05);
			player playloopsound("wpn_hind_minigun_fire_plr_loop");
			self.minigun_hud["gun"] setshader("hud_hind_cannon0" + swap_counter,64,64);
			if(swap_counter == 5)
			{
				swap_counter = 1;
				continue;
			}

			swap_counter++;
		}

		self.minigun_hud["gun"] setshader("hud_hind_cannon01",64,64);
		self.minigun_hud["gun"] fadeovertime(0.05);
		self.minigun_hud["gun"].alpha = 0.55;
		player stoploopsound(0.048);
	}
}

//Function Number: 46
hud_rocket_create()
{
	if(!(IsDefined(self.rocket_hud)))
	{
		self.rocket_hud = [];
	}

	self.rocket_hud["border"] = newclienthudelem(self);
	self.rocket_hud["border"].alignx = "left";
	self.rocket_hud["border"].aligny = "bottom";
	self.rocket_hud["border"].horzalign = "user_left";
	self.rocket_hud["border"].vertalign = "user_bottom";
	self.rocket_hud["border"].y = -6;
	self.rocket_hud["border"].x = 2;
	self.rocket_hud["border"].alpha = 0.55;
	self.rocket_hud["border"] fadeovertime(0.05);
	self.rocket_hud["border"] setshader("hud_hind_rocket_border_small",20,5);
	self.rocket_hud["border"].hidewheninmenu = 1;
	self.rocket_hud["loading_border"] = newclienthudelem(self);
	self.rocket_hud["loading_border"].alignx = "left";
	self.rocket_hud["loading_border"].aligny = "bottom";
	self.rocket_hud["loading_border"].horzalign = "user_left";
	self.rocket_hud["loading_border"].vertalign = "user_bottom";
	self.rocket_hud["loading_border"].y = -2;
	self.rocket_hud["loading_border"].x = 2;
	self.rocket_hud["loading_border"].alpha = 0.55;
	self.rocket_hud["loading_border"] fadeovertime(0.05);
	self.rocket_hud["loading_border"] setshader("hud_hind_rocket_loading",20,5);
	self.rocket_hud["loading_border"].hidewheninmenu = 1;
	self.rocket_hud["loading_bar"] = newclienthudelem(self);
	self.rocket_hud["loading_bar"].alignx = "left";
	self.rocket_hud["loading_bar"].aligny = "bottom";
	self.rocket_hud["loading_bar"].horzalign = "user_left";
	self.rocket_hud["loading_bar"].vertalign = "user_bottom";
	self.rocket_hud["loading_bar"].y = -2;
	self.rocket_hud["loading_bar"].x = 2;
	self.rocket_hud["loading_bar"].alpha = 0.55;
	self.rocket_hud["loading_bar"] fadeovertime(0.05);
	self.rocket_hud["loading_bar"].width = 20;
	self.rocket_hud["loading_bar"].height = 5;
	self.rocket_hud["loading_bar"].shader = "hud_hind_rocket_loading_fill";
	self.rocket_hud["loading_bar"] setshader("hud_hind_rocket_loading_fill",20,5);
	self.rocket_hud["loading_bar"].hidewheninmenu = 1;
	self.rocket_hud["loading_bar_bg"] = spawnstruct();
	self.rocket_hud["loading_bar_bg"].elemtype = "bar";
	self.rocket_hud["loading_bar_bg"].bar = self.rocket_hud["loading_bar"];
	self.rocket_hud["loading_bar_bg"].width = 20;
	self.rocket_hud["loading_bar_bg"].height = 5;
	self.rocket_hud["ammo1"] = newclienthudelem(self);
	self.rocket_hud["ammo1"].alignx = "left";
	self.rocket_hud["ammo1"].aligny = "bottom";
	self.rocket_hud["ammo1"].horzalign = "user_left";
	self.rocket_hud["ammo1"].vertalign = "user_bottom";
	self.rocket_hud["ammo1"].alpha = 0.55;
	self.rocket_hud["ammo1"] fadeovertime(0.05);
	self.rocket_hud["ammo1"].y = -10;
	self.rocket_hud["ammo1"].x = -7;
	self.rocket_hud["ammo1"] setshader("hud_hind_rocket",48,48);
	self.rocket_hud["ammo1"].hidewheninmenu = 1;
	self.rocket_hud["ammo2"] = newclienthudelem(self);
	self.rocket_hud["ammo2"].alignx = "left";
	self.rocket_hud["ammo2"].aligny = "bottom";
	self.rocket_hud["ammo2"].horzalign = "user_left";
	self.rocket_hud["ammo2"].vertalign = "user_bottom";
	self.rocket_hud["ammo2"].alpha = 0.55;
	self.rocket_hud["ammo2"] fadeovertime(0.05);
	self.rocket_hud["ammo2"].y = -10;
	self.rocket_hud["ammo2"].x = -18;
	self.rocket_hud["ammo2"] setshader("hud_hind_rocket",48,48);
	self.rocket_hud["ammo2"].hidewheninmenu = 1;
	self.rocket_hud["button"] = newclienthudelem(self);
	self.rocket_hud["button"].alignx = "left";
	self.rocket_hud["button"].aligny = "bottom";
	self.rocket_hud["button"].horzalign = "user_left";
	self.rocket_hud["button"].vertalign = "user_bottom";
	self.rocket_hud["button"].font = "small";
	self.rocket_hud["button"] settext("[{+speed_throw}]");
	self.rocket_hud["button"].hidewheninmenu = 1;
	if(level.ps3)
	{
		self.rocket_hud["button"].x = 25;
		self.rocket_hud["button"].y = -4;
		self.rocket_hud["button"].fontscale = 1.25;
	}
	else
	{
		self.rocket_hud["button"].x = 23;
		self.rocket_hud["button"].y = -6;
		self.rocket_hud["button"].fontscale = 1;
	}

	self thread hud_rocket_think();
	self thread hud_rocket_destroy();
}

//Function Number: 47
hud_rocket_destroy()
{
	self waittill("hind weapons disabled");
	self.rocket_hud["border"] destroy();
	self.rocket_hud["loading_border"] destroy();
	self.rocket_hud["loading_bar"] destroy();
	self.rocket_hud["ammo1"] destroy();
	self.rocket_hud["button"] destroy();
	self.rocket_hud["ammo2"] destroy();
}

//Function Number: 48
hud_rocket_think()
{
	self endon("hind weapons disabled");
	self endon("disconnect");
	last_rocket_count = self.heli.numberrockets;
	while(1)
	{
		for(i = 1;i < 3;i++)
		{
			if(i - 1 < self.heli.numberrockets)
			{
				self.rocket_hud["ammo" + i] setshader("hud_hind_rocket",48,48);
				self.rocket_hud["ammo" + i].alpha = 0.55;
				self.rocket_hud["ammo" + i] fadeovertime(0.05);
			}
			else
			{
				self.rocket_hud["ammo" + i] setshader("hud_hind_rocket",48,48);
				self.rocket_hud["ammo" + i].alpha = 0;
				self.rocket_hud["ammo" + i] fadeovertime(0.05);
			}
		}

		if(last_rocket_count != self.heli.numberrockets)
		{
			if(self.heli.numberrockets == 0)
			{
				rateofchange = level.heli_missile_reload_time;
			}

			last_rocket_count = self.heli.numberrockets;
			self.rocket_hud["loading_bar_bg"] updateammobarscale(self.heli.numberrockets * 0.5);
			if(self.heli.numberrockets == 0)
			{
				rateofchange = level.heli_missile_reload_time;
				self.rocket_hud["loading_bar_bg"] updateammobarscale(1,rateofchange);
			}
		}

		wait(0.05);
	}
}

//Function Number: 49
updateammobarscale(barfrac,rateofchange)
{
	barwidth = int(self.width * barfrac + 0.5);
	if(!(barwidth))
	{
		barwidth = 1;
	}

	if(IsDefined(rateofchange) && barwidth <= self.width)
	{
		self.bar scaleovertime(rateofchange,barwidth,self.height);
	}
	else
	{
		self.bar setshader(self.bar.shader,barwidth,self.height);
	}
}

//Function Number: 50
player_heli_leave(hardpointtype)
{
	self endon("heli_timeup");
	self.heli thread maps/mp/killstreaks/_helicopter::heli_leave(hardpointtype);
	wait(0.1);
	debug_print_heli(">>>>>>>player_heli_leave");
	self notify("heli_timeup");
}

//Function Number: 51
waitfortimeout(hardpointtype)
{
	self endon("disconnect");
	self endon("heli_timeup");
	self.heli endon("death");
	self.killstreak_waitamount = self.heli.maxlifetime;
	while(1)
	{
		timeleft = self.heli.maxlifetime - GetTime() - self.heli.starttime;
		if(timeleft <= 0)
		{
			player_heli_leave(hardpointtype);
			debug_print_heli(">>>>>>>send notify [exit_vehicle***heli_timeup] TIMEUP!!!!!!!!!!!!!!");
		}

		wait(0.1);
	}
}

//Function Number: 52
debugcheckforexit(hardpointtype)
{
/#
	self endon("disconnect");
	self endon("heli_timeup");
	if(IsDefined(self.pers["isBot"]) && self.pers["isBot"])
	{
		return;
	}

	while(1)
	{
		if(self usebuttonpressed())
		{
			player_heli_leave(hardpointtype);
			debug_print_heli(">>>>>>>send notify [exit_vehicle***heli_timeup]");
			return;
		}

		wait(0.1);
	}
#/
}

//Function Number: 53
playpilotdialog(dialog,time)
{
	if(IsDefined(time))
	{
		wait(time);
	}

	if(!(IsDefined(self.pilotvoicenumber)))
	{
		self.pilotvoicenumber = 0;
	}

	soundalias = level.teamprefix[self.team] + self.pilotvoicenumber + "_" + dialog;
	self playlocalsound(soundalias);
}