/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\mp_lost.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 15
 * Decompile Time: 383 ms
 * Timestamp: 4/22/2024 2:18:00 AM
*******************************************************************/

//Function Number: 1
main()
{
	level.callbackstartgametype = ::lost_callbackstartgametype;
	maps\mp\mp_lost_precache::main();
	maps\createart\mp_lost_art::main();
	maps\mp\mp_lost_fx::main();
	maps\mp\_load::main();
	maps\mp\mp_lost_lighting::main();
	maps\mp\mp_lost_aud::main();
	maps\mp\_compass::setupminimap("compass_map_mp_lost");
	game["attackers"] = "allies";
	game["defenders"] = "axis";
	level.mapcustomkillstreakfunc = ::lostcustomkillstreakfunc;
	maps\mp\_water::init();
	level.orbitalsupportoverridefunc = ::lostpaladinoverrides;
	level.ospvisionset = "mp_lost_osp";
	level.osplightset = "mp_lost_osp";
	if(level.currentgen)
	{
		level.warbirdzoffset = 575;
	}

	thread drone_anims();
	thread sandcrawler_anims();
	thread core_watersheeting();
	var_00 = getent("lost_reactor_core_machine_mid","targetname");
	if(isdefined(var_00))
	{
		var_00 delete();
	}

	thread kill_triggers();
	thread patchclipfixes();
}

//Function Number: 2
patchclipfixes()
{
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(3120,-1784,-48),(0,30,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(3120,-1784,208),(0,30,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(3120,-1784,464),(0,30,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(3120,-1784,720),(0,30,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(3120,-1784,976),(0,30,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(3120,-1784,1232),(0,30,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(-2200,-1352,224),(0,135,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(-2200,-1352,480),(0,135,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(-2200,-1352,736),(0,135,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(-2200,-1352,992),(0,135,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(-2376,-1528,224),(0,135,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(-2376,-1528,480),(0,135,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(-2376,-1528,736),(0,135,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(-2376,-1528,992),(0,135,0));
}

//Function Number: 3
kill_triggers()
{
	var_00 = 300;
	var_01 = 300;
	var_02 = [];
	var_02[var_02.size] = spawn("trigger_radius",(2160,-1216,88),0,var_00,var_01);
	var_02[var_02.size] = spawn("trigger_radius",(2160,-544,88),0,var_00,var_01);
	var_02[var_02.size] = spawn("trigger_radius",(2112,48,88),0,var_00,var_01);
	var_02[var_02.size] = spawn("trigger_radius",(2048,592,72),0,var_00,var_01);
	var_02[var_02.size] = spawn("trigger_radius",(2136,1056,72),0,64,var_01);
	var_02[var_02.size] = spawn("trigger_radius",(2008,1324,72),0,64,var_01);
	foreach(var_04 in var_02)
	{
		var_04 thread hurtplayersthink();
	}

	var_06 = getentarray("trigger_hurt","classname");
	var_07 = 8;
	foreach(var_04 in var_06)
	{
		if(distance(var_04.origin,(-2036,-2428,80)) <= var_07)
		{
			var_04.origin = var_04.origin + (0,0,32);
			continue;
		}

		if(distance(var_04.origin,(-2968,-168,80)) <= var_07)
		{
			var_04.origin = var_04.origin + (32,0,32);
		}
	}

	var_04 = spawn("trigger_radius",(-1776,1016,-64),0,var_00,var_01);
	var_04 thread hurtplayersthink();
	if(isdefined(level.ishorde) && level.ishorde)
	{
		level.hordekilltriggers = [];
		foreach(var_0B in var_02)
		{
			level.hordekilltriggers[level.hordekilltriggers.size] = var_0B;
		}

		level.hordekilltriggers[level.hordekilltriggers.size] = var_04;
	}
}

//Function Number: 4
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
				if(isdefined(level.ishorde) && level.ishorde)
				{
					var_01 dodamage(10000,var_01.origin,undefined,undefined,"MOD_TRIGGER_HURT","none","none");
					continue;
				}

				var_01 maps\mp\_utility::_suicide();
			}
		}

		wait(0.5);
	}
}

//Function Number: 5
core_watersheeting()
{
	level endon("game_ended");
	var_00 = getentarray("core_watersheeting","targetname");
	foreach(var_02 in var_00)
	{
		var_02 thread watch_player_inwatersheeting();
	}
}

//Function Number: 6
watch_player_inwatersheeting()
{
	level endon("game_ended");
	for(;;)
	{
		self waittill("trigger",var_00);
		if(!isplayer(var_00) && !isai(var_00))
		{
			continue;
		}

		if(!isalive(var_00))
		{
			continue;
		}

		if(var_00 maps\mp\_utility::isusingremote())
		{
			continue;
		}

		if(!isdefined(var_00.inwatersheeting))
		{
			var_00 thread player_inwatersheeting(self);
		}
	}
}

//Function Number: 7
player_inwatersheeting(param_00)
{
	level endon("game_ended");
	self endon("death");
	self endon("disconnect");
	self endon("joined_team");
	for(;;)
	{
		if(!self istouching(param_00))
		{
			player_end_watersheeting(1,0.5);
			return 0;
		}

		if(isdefined(self.inwatersheeting) && maps\mp\_utility::isusingremote())
		{
			player_end_watersheeting();
			return 0;
		}
		else if(!isdefined(self.inwatersheeting))
		{
			self.inwatersheeting = 1;
			thread player_loop_watersheeting();
			thread player_watch_disconnect();
		}

		wait(0.1);
	}
}

//Function Number: 8
player_end_watersheeting(param_00,param_01)
{
	if(!isdefined(param_00))
	{
		param_00 = 0;
	}

	if(isdefined(self) && isplayer(self))
	{
		self.inwatersheeting = undefined;
		self notify("end_watersheeting");
		if(isdefined(param_01))
		{
			self setwatersheeting(param_00,param_01);
			return;
		}

		self setwatersheeting(param_00);
	}
}

//Function Number: 9
player_loop_watersheeting()
{
	level endon("game_ended");
	self endon("death");
	self endon("disconnect");
	self endon("end_watersheeting");
	self endon("joined_team");
	while(isdefined(self.inwatersheeting))
	{
		self setwatersheeting(1,20);
		wait(10.367);
	}
}

//Function Number: 10
player_watch_disconnect()
{
	level endon("game_ended");
	common_scripts\utility::waittill_any("disconnect","joined_team","joined_spectators","death");
	player_end_watersheeting();
}

//Function Number: 11
lostpaladinoverrides()
{
	level.orbitalsupportoverrides.spawnheight = 9553;
}

//Function Number: 12
lost_callbackstartgametype()
{
	maps\mp\gametypes\_gamelogic::callback_startgametype();
	common_scripts\_bcs_location_trigs_dlc::bcs_location_trigs_dlc_init();
}

//Function Number: 13
lostcustomkillstreakfunc()
{
	level thread maps\mp\killstreaks\streak_mp_lost::init();
}

//Function Number: 14
drone_anims()
{
	var_00 = getent("drone_cleaner_01","targetname");
	var_01 = getent("drone_cleaner_02","targetname");
	var_02 = getent("drone_cleaner_03","targetname");
	var_03 = var_01.origin;
	var_04 = var_01.angles;
	var_00 willneverchange(0);
	var_01 willneverchange(0);
	var_02 willneverchange(0);
	var_05 = spawn("script_model",(0,0,0));
	var_05 setmodel("lost_repair_drone_01");
	var_05.origin = var_00.origin;
	var_05.angles = var_00.angles;
	maps\mp\_audio::scriptmodelplayanimwithnotify_uniquename(var_05,"lost_repair_drone_standby_idle01","drone_cleaner_01_notify","aud_lost_drone_idle_01","mp_lost_drone_idle_01","aud_drone_01_end_01","aud_drone_01_end_02","aud_drone_01_end_03");
	var_05 thread maps\mp\mp_lost_fx::play_jackhammer_robot_concrete_fx();
	var_06 = spawn("script_model",(0,0,0));
	var_06 setmodel("lost_repair_drone_01");
	var_06.origin = var_01.origin - (0,0,25);
	var_06.angles = var_01.angles;
	maps\mp\_audio::scriptmodelplayanimwithnotify_uniquename(var_06,"lost_repair_drone_standby_idle02","drone_cleaner_02_notify","aud_lost_drone_idle_02","mp_lost_drone_idle_02","aud_drone_02_end_01","aud_drone_02_end_02","aud_drone_02_end_03");
	var_06 thread maps\mp\mp_lost_fx::play_poking_robot_concrete_fx();
	var_07 = spawn("script_model",(0,0,0));
	var_07 setmodel("lost_repair_drone_01");
	var_07.origin = var_02.origin;
	var_07.angles = var_02.angles;
	maps\mp\_audio::scriptmodelplayanimwithnotify_uniquename(var_07,"lost_repair_drone_standby_idle03","drone_cleaner_03_notify","aud_lost_drone_idle_03","mp_lost_drone_idle_03","aud_drone_03_end_01","aud_drone_03_end_02","aud_drone_03_end_03");
	var_07 thread maps\mp\mp_lost_fx::play_jackhammer_robot_fx();
	var_00 delete();
	var_01 delete();
	var_02 delete();
	var_08 = getent("drone_cleaner_02_sign","targetname");
	var_09 = spawn("script_model",var_03);
	var_09 setmodel("genericprop");
	var_09.angles = var_04;
	var_08.origin = var_03;
	var_08.angles = var_04;
	var_08 linkto(var_09,"tag_origin_animated");
	var_09 scriptmodelplayanim("lost_repair_drone_standby_idle02_sign");
	var_0A = getent("drone_cleaner_02_sign02","targetname");
	var_0B = spawn("script_model",var_03);
	var_0B setmodel("genericprop");
	var_0B.angles = var_04;
	var_0A.origin = var_03;
	var_0A.angles = var_04;
	var_0A linkto(var_0B,"tag_origin_animated");
	var_0B scriptmodelplayanim("lost_repair_drone_standby_idle02_sign02");
	wait(0.05);
	var_0C = ["ps_mp_lost_drone_walk_pt_01","ps_mp_lost_drone_walk_pt_02","ps_mp_lost_drone_walk_pt_03","ps_mp_lost_drone_walk_pt_04","ps_mp_lost_drone_drill_01","ps_mp_lost_drone_walk_pt_05","ps_mp_lost_drone_walk_pt_06","ps_mp_lost_drone_walk_pt_07","ps_mp_lost_drone_walk_pt_08","ps_mp_lost_drone_drill_02"];
	var_0D = ["mp_lost_drone_walk_pt_01","mp_lost_drone_walk_pt_02","mp_lost_drone_walk_pt_03","mp_lost_drone_walk_pt_04","mp_lost_drone_walk_drill_01","mp_lost_drone_walk_pt_05","mp_lost_drone_walk_pt_06","mp_lost_drone_walk_pt_07","mp_lost_drone_walk_pt_08","mp_lost_drone_walk_drill_02"];
	var_0E = getent("drone_cleaner_04","targetname");
	maps\mp\_audio::scriptmodelplayanimwithnotify_uniquename(var_0E,"lost_canal_drone01_walk_to_idle02","drone_cleaner_04_notify",var_0C,var_0D,"aud_drone_04_end_01","aud_drone_04_end_02","aud_drone_04_end_03");
	var_0E thread maps\mp\mp_lost_fx::play_cleaner_walk_fx();
	var_0F = getent("lost_canal_drone_04_collision","targetname");
	var_0F linkto(var_0E,"tag_origin");
	var_0F solid();
	wait(3);
	var_10 = getent("drone_cleaner_05","targetname");
	maps\mp\_audio::scriptmodelplayanimwithnotify_uniquename(var_10,"lost_canal_drone01_walk_to_idle02","drone_cleaner_05_notify",var_0C,var_0D,"aud_drone_05_end_01","aud_drone_05_end_02","aud_drone_05_end_03");
	var_10 thread maps\mp\mp_lost_fx::play_cleaner_walk_fx();
	var_11 = getent("lost_canal_drone_05_collision","targetname");
	var_11 linkto(var_10,"tag_origin");
	var_11 solid();
}

//Function Number: 15
sandcrawler_anims()
{
	level endon("game_ended");
	var_00 = getentarray("lost_sandcrawler","targetname");
	foreach(var_02 in var_00)
	{
		var_02 scriptmodelplayanim("lost_sand_crawler_idle01");
	}
}