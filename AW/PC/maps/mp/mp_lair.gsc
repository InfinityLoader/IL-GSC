/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\mp_lair.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 20
 * Decompile Time: 346 ms
 * Timestamp: 4/22/2024 2:17:45 AM
*******************************************************************/

//Function Number: 1
main()
{
	level.callbackstartgametype = ::lair_callbackstartgametype;
	maps\mp\mp_lair_precache::main();
	maps\createart\mp_lair_art::main();
	maps\mp\mp_lair_fx::main();
	maps\mp\_load::main();
	maps\mp\mp_lair_lighting::main();
	maps\mp\mp_lair_aud::main();
	maps\mp\_compass::setupminimap("compass_map_mp_lair");
	maps\mp\_water::init();
	level.osplightset = "mp_lair_osp";
	level.warbirdlightset = "mp_lair_warbird";
	level.vulcanlightset = "mp_lair_osp";
	level.zone_height = 90;
	thread overridevulcanheight();
	game["attackers"] = "allies";
	game["defenders"] = "axis";
	precacheitem("iw5_dlcgun12loot8_mp");
	level dynamicevent_init();
	level thread maps\mp\_dynamic_events::dynamicevent(::startdynamicevent,::enddynamicevent,::enddynamicevent);
	level.orbitalsupportoverridefunc = ::lairpaladinoverrides;
	level thread onplayerconnect();
	thread aud_handle_fireworks_sfx();
}

//Function Number: 2
lair_callbackstartgametype()
{
	maps\mp\gametypes\_gamelogic::callback_startgametype();
	common_scripts\_bcs_location_trigs_dlc::bcs_location_trigs_dlc_init();
}

//Function Number: 3
dynamicevent_init()
{
	level endon("game_ended");
	if(level.gametype == "infect")
	{
		maps\mp\_dynamic_events::setdynamiceventstartpercent(0.2);
	}
	else if(level.gametype == "twar")
	{
		maps\mp\_dynamic_events::setdynamiceventstartpercent(0.25);
	}
	else if(level.gametype == "gun")
	{
		maps\mp\_dynamic_events::setdynamiceventstartpercent(0.3);
	}
	else
	{
		maps\mp\_dynamic_events::setdynamiceventstartpercent(0.4);
	}

	setdvar("scr_dynamic_event_start_perc",level.dynamicevent["start_percent"]);
	thread init_towers();
}

//Function Number: 4
startdynamicevent()
{
	level endon("game_ended");
	thread monitor_towers();
	foreach(var_01 in level.players)
	{
		if(var_01.team == "axis")
		{
			var_01 playlocalsound("at_anr0_ks_lair_plasma_activate");
			continue;
		}

		if(var_01.team == "allies")
		{
			var_01 playlocalsound("se_anr0_ks_lair_plasma_activate");
		}
	}

	wait(15);
	level.teslacoilsactivated = 1;
	thread maps\mp\mp_lair_fx::start_vista_vfx();
	wait(0.8);
	foreach(var_01 in level.players)
	{
		if(var_01.team == "axis")
		{
			var_01 playlocalsound("at_anr0_ks_lair_plasma_on");
			continue;
		}

		if(var_01.team == "allies")
		{
			var_01 playlocalsound("se_anr0_ks_lair_plasma_on");
		}
	}
}

//Function Number: 5
enddynamicevent()
{
	foreach(var_01 in level.tesla_towers)
	{
		var_01 notify("end_dynamic_event");
		level notify("aud_stop_dynamic_event_loops");
		var_01 setcandamage(0);
		var_01.chargingfx hide();
	}
}

//Function Number: 6
onplayerconnect()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_00 thread onplayerspawned();
		var_00 thread onplayerslam();
	}
}

//Function Number: 7
onplayerspawned()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("spawned_player");
		thread detectshockdeath();
	}
}

//Function Number: 8
onplayerslam()
{
	self endon("Disconnect");
	for(;;)
	{
		self waittill("ground_slam",var_00);
		var_01 = getdvarfloat("ground_slam_min_height",maps\mp\_exo_suit::getgroundslamminheight());
		var_02 = getdvarfloat("ground_slam_max_height",maps\mp\_exo_suit::getgroundslammaxheight());
		var_03 = getdvarfloat("ground_slam_min_radius",maps\mp\_exo_suit::getgroundslamminradius());
		var_04 = getdvarfloat("ground_slam_max_radius",maps\mp\_exo_suit::getgroundslammaxradius());
		if(var_00 < var_01)
		{
			continue;
		}

		var_05 = var_00 - var_01 / var_02 - var_01;
		var_05 = clamp(var_05,0,1);
		var_06 = var_04 - var_03 * var_05 + var_03;
		foreach(var_08 in level.tesla_towers)
		{
			if(distance2dsquared(var_08.origin,self.origin) <= var_06 * var_06)
			{
				if(var_08.script_noteworthy == "lamp_08")
				{
					var_09 = var_08.origin + (0,0,65);
					var_0A = self gettagorigin("J_SPINELOWER");
					if(sighttracepassed(var_09,var_0A,0,var_08,self,0))
					{
						var_08 dodamage(1,self.origin,self,self,"MOD_TRIGGER_HURT","boost_slam_mp");
					}
				}
				else
				{
					var_08 dodamage(1,self.origin,self,self,"MOD_TRIGGER_HURT","boost_slam_mp");
				}

				break;
			}
		}
	}
}

//Function Number: 9
detectshockdeath()
{
	self endon("disconnect");
	self waittill("death",var_00,var_01,var_02);
	if(isdefined(var_02) && var_02 == "iw5_dlcgun12loot8_mp")
	{
		thread playshockdeathfx();
	}
}

//Function Number: 10
playshockdeathfx()
{
	playfx(common_scripts\utility::getfx("lightning_bolt_impact"),self.body gettagorigin("J_SpineUpper"),anglestoforward(self.body gettagangles("J_SpineUpper")),anglestoup(self.body gettagangles("J_SpineUpper")));
	playfxontag(common_scripts\utility::getfx("shocked_corpse"),self.body,"j_spineupper");
}

//Function Number: 11
init_towers()
{
	level.tesla_towers = getentarray("tesla_tower","targetname");
	foreach(var_01 in level.tesla_towers)
	{
		var_01.chargingfx = spawnfx(common_scripts\utility::getfx("tesla_coil_charging"),var_01.origin,anglestoforward(var_01.angles),anglestoup(var_01.angles));
		var_01.chargingfx hide();
		var_01.dischargingfx = spawnfx(common_scripts\utility::getfx("tesla_coil_discharging"),var_01.origin,anglestoforward(var_01.angles),anglestoup(var_01.angles));
		var_01.dischargingfx hide();
		var_01 setdamagecallbackon(1);
		var_01.damagecallback = ::tower_processdamagetaken;
	}
}

//Function Number: 12
tower_processdamagetaken(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B)
{
	self notify("tower_damage",param_00,param_01,param_05,param_04);
}

//Function Number: 13
monitor_towers()
{
	foreach(var_01 in level.tesla_towers)
	{
		var_01 thread tower_lifetime();
		wait(0.1);
	}
}

//Function Number: 14
tower_lifetime()
{
	self endon("end_dynamic_event");
	var_00 = 15;
	self.chargingfx show();
	triggerfx(self.chargingfx);
	wait(var_00);
	for(;;)
	{
		thread maps\mp\_audio::snd_play_linked("mp_lair_murder_spark_powered_up",self);
		var_01 = maps\mp\_audio::snd_play_loop_in_space("mp_lair_murder_lamp_lp",self.origin,"aud_stop_dynamic_event_loops");
		var_02 = maps\mp\_audio::snd_play_loop_in_space("mp_lair_murder_lamp_lp_hi",self.origin,"aud_stop_dynamic_event_loops");
		self setcandamage(1);
		self.health = 99999;
		self waittill("tower_damage",var_03,var_04,var_05,var_06);
		if(isdefined(var_05))
		{
			switch(var_05)
			{
				case "killstreakmahem_mp":
					if(isdefined(var_04) && isdefined(var_04.turret))
					{
						self.killcament = var_04.turret;
					}
					break;
	
				case "killstreak_strike_missile_gas_mp":
				case "remote_energy_turret_mp":
				case "sentry_minigun_mp":
					if(isdefined(var_03))
					{
						self.killcament = var_03;
					}
					break;
	
				case "drone_assault_remote_turret_mp":
					if(isdefined(var_03.owner))
					{
						var_04 = var_03.owner;
					}
		
					break;
	
				case "warbird_remote_turret_mp":
				case "warbird_missile_mp":
				case "ugv_missile_mp":
				case "orbital_carepackage_pod_plane_mp":
				case "stealth_bomb_mp":
				case "orbital_carepackage_droppod_mp":
					if(isdefined(var_03) && isdefined(var_03.killcament))
					{
						self.killcament = var_03.killcament;
					}
					break;
	
				case "stun_grenade_var_mp_lefthand":
				case "emp_grenade_var_mp_lefthand":
				case "stun_grenade_mp_lefthand":
				case "emp_grenade_mp_lefthand":
				case "iw5_microdronelauncher_mp":
				case "frag_grenade_mp_lefthand":
				case "semtex_mp_lefthand":
				case "emp_grenade_var_mp":
				case "stun_grenade_var_mp":
				case "emp_grenade_mp":
				case "stun_grenade_mp":
				case "semtex_mp":
				case "frag_grenade_mp":
					if(isdefined(var_06) && var_06 == "MOD_IMPACT")
					{
						break;
					}
					break;
	
				case "paint_grenade_var_mp_lefthand":
				case "paint_grenade_mp_lefthand":
				case "paint_grenade_killstreak_mp":
				case "paint_missile_killstreak_mp":
				case "smoke_grenade_var_mp_lefthand":
				case "smoke_grenade_mp_lefthand":
				case "smoke_grenade_var_mp":
				case "paint_grenade_var_mp":
				case "smoke_grenade_mp":
				case "paint_grenade_mp":
					break;
	
				default:
					break;
			}
		}

		self setcandamage(0);
		thread aud_murder_zap_seq();
		self playsound("mp_lair_murder_spark_zap");
		self playsound("mp_lair_murder_lamp_sweeps");
		if(isdefined(var_01))
		{
			var_01 stopsounds();
			wait(0.05);
			var_01 delete();
		}

		if(isdefined(var_02))
		{
			var_02 stopsounds();
			wait(0.05);
			var_02 delete();
		}

		self.chargingfx hide();
		thread start_shock(var_04);
		self waittill("tower_shock_done");
		self.chargingfx show();
		triggerfx(self.chargingfx);
		wait(var_00);
	}
}

//Function Number: 15
aud_murder_zap_seq()
{
	var_00 = randomfloatrange(0.1,0.3);
	var_01 = randomintrange(7,10);
	for(var_02 = 0;var_02 < var_01;var_02++)
	{
		self playsound("mp_lair_murder_spark_zap");
		wait(var_00);
	}
}

//Function Number: 16
start_shock(param_00)
{
	level.shock_time = 2.2;
	var_01 = 0.2;
	var_02 = self.radius * self.radius;
	var_03 = self.origin + (0,0,115);
	var_04 = common_scripts\utility::spawn_tag_origin();
	var_04.origin = var_03;
	var_04.angles = (270,0,0);
	var_04 show();
	playfxontag(common_scripts\utility::getfx("tesla_lightning_loop"),var_04,"tag_origin");
	self.dischargingfx show();
	triggerfx(self.dischargingfx);
	thread maps\mp\_audio::snd_play_linked("mp_lair_murder_spark_zap",self);
	for(var_05 = 0;var_05 < level.shock_time;var_05 = var_05 + var_01)
	{
		var_06 = [];
		var_07 = [];
		var_08 = [];
		foreach(var_0A in level.players)
		{
			if((isdefined(param_00.team) && var_0A.team != param_00.team) || var_0A == param_00)
			{
				if(var_0A.health > 0 && distancesquared(var_0A.origin,self.origin) <= var_02)
				{
					var_06[var_06.size] = var_0A;
				}
			}
		}

		if(isdefined(level.ugvs))
		{
			foreach(var_0D in level.ugvs)
			{
				if(var_0D.team != param_00.team || var_0D.owner == param_00)
				{
					if(var_0D.damagetaken < var_0D.maxhealth && distancesquared(var_0D.origin,self.origin) <= var_02)
					{
						var_07[var_07.size] = var_0D;
					}
				}
			}
		}

		if(isdefined(level.trackingdrones))
		{
			foreach(var_0D in level.trackingdrones)
			{
				if(var_0D.team != param_00.team || var_0D.owner == param_00)
				{
					if(var_0D.damagetaken < var_0D.maxhealth && distancesquared(var_0D.origin,self.origin) <= var_02)
					{
						var_07[var_07.size] = var_0D;
					}
				}
			}
		}

		if(isdefined(level.turrets))
		{
			foreach(var_12 in level.turrets)
			{
				if(var_12.team != param_00.team || var_12.owner == param_00)
				{
					if(var_12.health > 0 && distancesquared(var_12.origin,self.origin) <= var_02)
					{
						var_08[var_08.size] = var_12;
					}
				}
			}
		}

		foreach(var_15 in var_06)
		{
			var_16 = var_15 gettagorigin("j_neck");
			if(sighttracepassed(var_03,var_16,0,self,var_15,0))
			{
				var_15 dodamage(1000,var_03,param_00,self,"MOD_EXPLOSIVE","iw5_dlcgun12loot8_mp","none");
			}
		}

		foreach(var_0D in var_07)
		{
			var_16 = var_0D.origin;
			var_19 = var_0D.angles;
			if(sighttracepassed(var_03,var_16,0,self,var_0D,0))
			{
				playfx(common_scripts\utility::getfx("lightning_bolt_impact"),var_16,anglestoforward(var_19),anglestoup(var_19));
				var_0D dodamage(1000,var_03,param_00,self,"MOD_EXPLOSIVE","iw5_dlcgun12loot8_mp","none");
			}
		}

		foreach(var_12 in var_08)
		{
			var_16 = var_12 gettagorigin("tag_aim_animated");
			var_19 = var_12 gettagangles("tag_aim_animated");
			if(sighttracepassed(var_03,var_16,0,self,var_12,0))
			{
				var_12 dodamage(1000,var_03,param_00,self,"MOD_EXPLOSIVE","iw5_dlcgun12loot8_mp","none");
				playfx(common_scripts\utility::getfx("lightning_bolt_impact"),var_16,anglestoforward(var_19),anglestoup(var_19));
				playfxontag(common_scripts\utility::getfx("shocked_corpse"),var_12,"tag_aim_animated");
			}
		}

		wait(var_01);
	}

	wait(0.1);
	var_04 delete();
	self.dischargingfx hide();
	self notify("tower_shock_done");
}

//Function Number: 17
lairpaladinoverrides()
{
	level.orbitalsupportoverrides.spawnheight = 9200;
	level.orbitalsupportoverrides.spawnradius = 8000;
	level.orbitalsupportoverrides.spawnangle = 182;
}

//Function Number: 18
overridevulcanheight()
{
	wait(1);
	if(!isdefined(level.orbitallaseroverrides))
	{
		level.orbitallaseroverrides = spawnstruct();
	}

	level.orbitallaseroverrides.spawnheight = 2800;
}

//Function Number: 19
disconnect_lamp_nodes(param_00)
{
	var_01 = getnodearray(param_00,"script_noteworthy");
	var_02 = getnodearray(param_00,"script_noteworthy");
	for(var_03 = 0;var_03 < var_01.size;var_03++)
	{
		var_01[var_03] disconnectnode();
	}

	wait 0.05;
	for(var_03 = 0;var_03 < var_02.size;var_03++)
	{
		var_02[var_03] disconnectnode();
	}

	wait 0.05;
	wait(level.shock_time);
	for(var_03 = 0;var_03 < var_01.size;var_03++)
	{
		var_01[var_03] connectnode();
	}

	wait 0.05;
	for(var_03 = 0;var_03 < var_02.size;var_03++)
	{
		var_02[var_03] connectnode();
	}
}

//Function Number: 20
aud_handle_fireworks_sfx()
{
	level waittill("aud_fireworks");
	var_00 = spawn("script_origin",(0,0,0));
	var_00 playloopsound("amb_mp_lair_fworks");
}