/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\mp_takeoff.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: PC
 * Function Count: 19
 * Decompile Time: 131 ms
 * Timestamp: 10/27/2023 3:01:56 AM
*******************************************************************/

#include common_scripts/utility;
#include maps/mp/_compass;
#include maps/mp/_events;
#include maps/mp/_load;
#include maps/mp/_utility;
#include maps/mp/gametypes/_spawning;
#include maps/mp/mp_takeoff_fx;

//Function Number: 1
main()
{
	level.levelspawndvars = ::levelspawndvars;
	level.overrideplayerdeathwatchtimer = ::leveloverridetime;
	level.useintermissionpointsonwavespawn = ::useintermissionpointsonwavespawn;
	maps/mp/mp_takeoff_fx::main();
	precachemodel("collision_nosight_wall_64x64x10");
	precachemodel("collision_clip_wall_128x128x10");
	precachemodel("collision_mp_takeoff_solar_weap");
	maps/mp/_load::main();
	maps/mp/_compass::setupminimap("compass_map_mp_takeoff");
	setdvar("compassmaxrange","2100");
	game["strings"]["war_callsign_a"] = &"MPUI_CALLSIGN_MAPNAME_A";
	game["strings"]["war_callsign_b"] = &"MPUI_CALLSIGN_MAPNAME_B";
	game["strings"]["war_callsign_c"] = &"MPUI_CALLSIGN_MAPNAME_C";
	game["strings"]["war_callsign_d"] = &"MPUI_CALLSIGN_MAPNAME_D";
	game["strings"]["war_callsign_e"] = &"MPUI_CALLSIGN_MAPNAME_E";
	game["strings_menu"]["war_callsign_a"] = "@MPUI_CALLSIGN_MAPNAME_A";
	game["strings_menu"]["war_callsign_b"] = "@MPUI_CALLSIGN_MAPNAME_B";
	game["strings_menu"]["war_callsign_c"] = "@MPUI_CALLSIGN_MAPNAME_C";
	game["strings_menu"]["war_callsign_d"] = "@MPUI_CALLSIGN_MAPNAME_D";
	game["strings_menu"]["war_callsign_e"] = "@MPUI_CALLSIGN_MAPNAME_E";
	spawncollision("collision_nosight_wall_64x64x10","collider",(-915,790,212),(0,0,0));
	spawncollision("collision_nosight_wall_64x64x10","collider",(-979,790,212),(0,0,0));
	spawncollision("collision_nosight_wall_64x64x10","collider",(-1043,790,212),(0,0,0));
	spawncollision("collision_nosight_wall_64x64x10","collider",(-1083,790,212),(0,0,0));
	spawncollision("collision_nosight_wall_64x64x10","collider",(-915,790,148),(0,0,0));
	spawncollision("collision_nosight_wall_64x64x10","collider",(-979,790,148),(0,0,0));
	spawncollision("collision_nosight_wall_64x64x10","collider",(-1043,790,148),(0,0,0));
	spawncollision("collision_nosight_wall_64x64x10","collider",(-1083,790,148),(0,0,0));
	spawncollision("collision_clip_wall_128x128x10","collider",(136,2511,245.5),VectorScale((0,1,0)));
	spawncollision("collision_mp_takeoff_solar_weap","collider",(580,3239.5,32.5),(0,0,0));
	spawncollision("collision_clip_wall_128x128x10","collider",(1523.5,2085.5,220.5),VectorScale((0,1,0)));
	maps/mp/gametypes/_spawning::level_use_unified_spawning(1);
	level thread dog_jump_think();
	level.disableoutrovisionset = 1;
	level.mptakeoffrocket = getent("takeoff_rocket","targetname");
/#
	assert(IsDefined(level.mptakeoffrocket),"Unable to find entity with targetname: \'takeoff_rocket\'");
#/
	level.endgamefunction = ::takeoff_end_game;
	level.preendgamefunction = ::takeoff_pre_end_game;
	level thread setuprocketcamera();
/#
	execdevgui("devgui_mp_takeoff");
	level thread watchdevnotify();
	level thread devgui_endgame();
#/
}

//Function Number: 2
dog_jump_think()
{
	origin = (209,3819,91);
	trigger = spawn("trigger_box",origin,getaitriggerflags(),64,32,64);
	trigger setexcludeteamfortrigger("none");
	for(;;)
	{
		trigger waittill("trigger",entity);
		if(isai(entity))
		{
			glassradiusdamage(origin,64,5001,5000);
			trigger delete();
			return;
		}
	}
}

//Function Number: 3
setuprocketcamera()
{
	wait(0.1);
	getrocketcamera();
}

//Function Number: 4
getrocketcamera()
{
	camerastruct = getstruct("endgame_first_camera","targetname");
/#
	assert(IsDefined(camerastruct),"Unable to find entity with targetname: \'endgame_first_camera\'");
#/
	if(!(IsDefined(level.rocketcamera)))
	{
		level.rocketcamera = spawn("script_model",camerastruct.origin);
		level.rocketcamera setmodel("tag_origin");
	}
	else
	{
		level.rocketcamera.origin = camerastruct.origin;
	}

	level.rocketcamera.angles = camerastruct.angles;
	return level.rocketcamera;
}

//Function Number: 5
levelspawndvars(reset_dvars)
{
	ss = level.spawnsystem;
	ss.enemy_influencer_radius = set_dvar_float_if_unset("scr_spawn_enemy_influencer_radius","2300",reset_dvars);
}

//Function Number: 6
watchdevnotify()
{
/#
	startvalue = 0;
	setdvarint("scr_takeoff_rocket",startvalue);
	for(;;)
	{
		takeoff_rocket = GetDvarInt(#"12AE1013");
		level notify("dev_takeoff_rocket",takeoff_rocket != startvalue);
		startvalue = takeoff_rocket;
		wait(0.2);
	}
#/
}

//Function Number: 7
devgui_endgame()
{
/#
	rocket = level.mptakeoffrocket;
/#
	assert(IsDefined(rocket),"Unable to find entity with targetname: \'takeoff_rocket\'");
#/
	rocketorigin = rocket.origin;
	rocketangles = rocket.angles;
	rocketmodel = rocket.model;
	for(;;)
	{
		level waittill("dev_takeoff_rocket");
		visionsetnaked("blackout",0.1);
		thread takeoff_pre_end_game();
		wait(1);
		visionsetnaked("mp_takeoff",0.1);
		thread takeoff_end_game();
		wait(4.5);
		level notify("debug_end_takeoff");
		wait(1);
		visionsetnaked("mp_takeoff",0.1);
		i = 0;
		for(;;)
		{
			player = level.players[i];
			player cameraactivate(0);
			i++;
		}
		stop_exploder(1001);
		rocket delete();
		rocket = spawn("script_model",rocketorigin);
		rocket.angles = rocketangles;
		rocket setmodel(rocketmodel);
		level.mptakeoffrocket = rocket;
	}
i < level.players.size
#/
}

//Function Number: 8
water_trigger_init()
{
	wait(3);
	triggers = getentarray("trigger_hurt","classname");
	foreach(trigger in triggers)
	{
		if(trigger.origin[2] > level.mapcenter[2])
		{
		}
		else
		{
			trigger thread water_trigger_think();
		}
	}

	triggers = getentarray("water_killbrush","targetname");
	foreach(trigger in triggers)
	{
		trigger thread player_splash_think();
	}
}

//Function Number: 9
player_splash_think()
{
	for(;;)
	{
		self waittill("trigger",entity);
		if(isplayer(entity) && isalive(entity))
		{
			self thread trigger_thread(entity,::player_water_fx);
		}
	}
}

//Function Number: 10
player_water_fx(player,endon_condition)
{
	maxs = self.origin + self getmaxs();
	if(maxs[2] > 60)
	{
		maxs = 10 + VectorScale((0,0,1));
	}

	origin = (player.origin[0],player.origin[1],maxs[2]);
	playfx(level._effect["water_splash_sm"],origin);
}

//Function Number: 11
water_trigger_think()
{
	for(;;)
	{
		self waittill("trigger",entity);
		if(isplayer(entity))
		{
			entity playsound("mpl_splash_death");
			playfx(level._effect["water_splash"],40 + VectorScale((0,0,1)));
		}
	}
}

//Function Number: 12
leveloverridetime(defaulttime)
{
	if(self isinwater())
	{
		return 0.4;
	}
}

//Function Number: 13
useintermissionpointsonwavespawn()
{
	return self isinwater();
}

//Function Number: 14
isinwater()
{
	triggers = getentarray("trigger_hurt","classname");
	foreach(trigger in triggers)
	{
		if(trigger.origin[2] > level.mapcenter[2])
		{
		}
		else if(self istouching(trigger))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 15
takeoff_pre_end_game(timetillendgame,debug)
{
	if(!(IsDefined(debug)))
	{
		level waittill("play_final_killcam");
		wait(10);
	}

	rocket = level.mptakeoffrocket;
/#
	assert(IsDefined(rocket),"Unable to find entity with targetname: \'takeoff_rocket\'");
#/
	rocket rocket_thrusters_initialize();
}

//Function Number: 16
takeoff_end_game()
{
/#
	level endon("debug_end_takeoff");
#/
	level.rocket_camera = 0;
	rocket = level.mptakeoffrocket;
	rocket playsound("evt_shuttle_launch");
/#
	assert(IsDefined(rocket),"Unable to find entity with targetname: \'takeoff_rocket\'");
#/
	rocket rocket_thrusters_initialize();
	cameraone = getrocketcamera();
	cameraone thread vibrateaftertime(getdvarfloatdefault("mp_takeoff_shakewait",0.5));
	for(i = 0;i < level.players.size;i++)
	{
		player = level.players[i];
		player camerasetposition(cameraone);
		player camerasetlookat();
		player cameraactivate(1);
		player setdepthoffield(0,0,512,512,4,0);
	}

	level.rocket_camera = 1;
	rocket thread rocket_move();
	wait(4);
	visionsetnaked("blackout",getdvarfloatdefault("mp_takeoff_fade_black",0.5));
}

//Function Number: 17
rocket_thrusters_initialize()
{
	if(!(IsDefined(self.thrustersinited)))
	{
		self.thrustersinited = 1;
		exploder(1001);
		playfxontag(level._effect["fx_mp_tak_shuttle_thruster_lg"],self,"tag_fx");
		playfxontag(level._effect["fx_mp_tak_shuttle_thruster_sm"],self,"tag_fx5");
		playfxontag(level._effect["fx_mp_tak_shuttle_thruster_md"],self,"tag_fx6");
		playfxontag(level._effect["fx_mp_tak_shuttle_thruster_sm"],self,"tag_fx7");
	}
}

//Function Number: 18
rocket_move()
{
	origin = self.origin;
	heightincrease = getdvarintdefault("mp_takeoff_rocket_start_height",0);
	self.origin = self.origin + (0,0,heightincrease);
	movetime = getdvarintdefault("mp_takeoff_moveTime",17);
	moveaccelratio = getdvarfloatdefault("mp_takeoff_moveAccel",1);
	self moveto(50000 + VectorScale((0,0,1)),self.origin,movetime);
	self waittill(movetime * moveaccelratio,"movedone");
	origin = self.origin;
}

//Function Number: 19
vibrateaftertime(waittime)
{
	self endon("death");
/#
	level endon("debug_end_takeoff");
#/
	wait(waittime);
	pitchvibrateamplitude = getdvarfloatdefault("mp_takeoff_start",0.1);
	vibrateamplitude = getdvarfloatdefault("mp_takeoff_a_start",0.1);
	vibratetime = 0.05;
	originalangles = self.angles;
	for(;;)
	{
		angles0 = (originalangles[0] - pitchvibrateamplitude,originalangles[1],originalangles[2] - vibrateamplitude);
		angles1 = (originalangles[0] + pitchvibrateamplitude,originalangles[1],originalangles[2] + vibrateamplitude);
		self rotateto(angles0,vibratetime);
		self waittill("rotatedone");
		self rotateto(angles1,vibratetime);
		self waittill("rotatedone");
		vibrateamplitude = vibrateamplitude * getdvarfloatdefault("mp_takeoff_amp_vredux",1.12);
		pitchvibrateamplitude = 0 - pitchvibrateamplitude;
		pitchvibrateamplitude = pitchvibrateamplitude * getdvarfloatdefault("mp_takeoff_amp_predux",1.11);
	}
}