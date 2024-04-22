/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\mp_recovery.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 38
 * Decompile Time: 913 ms
 * Timestamp: 4/22/2024 2:18:14 AM
*******************************************************************/

//Function Number: 1
main()
{
	maps\mp\mp_recovery_precache::main();
	maps\createart\mp_recovery_art::main();
	maps\mp\mp_recovery_fx::main();
	maps\mp\_load::main();
	maps\mp\mp_recovery_lighting::main();
	maps\mp\mp_recovery_aud::main();
	maps\mp\_compass::setupminimap("compass_map_mp_recovery");
	game["attackers"] = "allies";
	game["defenders"] = "axis";
	level.missilefx = loadfx("vfx/test/hms_fireball_explosion_xlrg");
	thread dynamic_ents();
	thread handle_teleport();
	thread dynamic_pathing_main();
	var_00 = level.gametype;
	if(!isdefined(level.ishorde))
	{
		if(!var_00 == "twar" || var_00 == "sd" || var_00 == "sr")
		{
			level thread maps\mp\_dynamic_events::dynamicevent(::recovery_dynamic_event);
		}
	}

	level thread onplayerconnect();
	thread spawnsetup();
	level.dynamiceventstatus = "before";
	level.hp_pause_for_dynamic_event = 0;
	level.orbitalsupportoverridefunc = ::recoverycustomospfunc;
	level.ospvisionset = "mp_recovery_b";
	level.osplightset = "mp_recovery_osp";
	level.dronevisionset = "mp_recovery_b";
	level.dronelightset = "mp_recovery";
	thread scriptpatchclip();
}

//Function Number: 2
scriptpatchclip()
{
	thread patchclipcentersmallrock();
	thread patchclipsecondsidedoorrocks01();
	thread patchclipsecondsidegoliathrock();
}

//Function Number: 3
patchclipcentersmallrock()
{
	maps\mp\_utility::spawnpatchclip("patchclip_player_32_32_32",(-511,1131,162),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_32_32_32",(-499,1145,162),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_32_32_32",(-499,1157,162),(0,0,0));
}

//Function Number: 4
patchclipsecondsidedoorrocks01()
{
	maps\mp\_utility::spawnpatchclip("patchclip_player_64_64_64",(-208,3304,140),(0,336,0));
}

//Function Number: 5
patchclipsecondsidegoliathrock()
{
	maps\mp\_utility::spawnpatchclip("patchclip_player_32_32_32",(-147,4352.5,170.5),(0,26.9,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_32_32_32",(-124,4366,170.5),(0,45,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_32_32_32",(-101.5,4343.5,170.5),(0,45,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_32_32_32",(-101.5,4343.5,138.5),(0,45,0));
}

//Function Number: 6
recoverycustomospfunc()
{
	level.orbitalsupportoverrides.spawnheight = 9324;
	level.orbitalsupportoverrides.spawnanglemin = 290;
	level.orbitalsupportoverrides.spawnanglemax = 370;
	level.orbitalsupportoverrides.toparc = -45;
	thread recoveryeventcustomospfunc();
}

//Function Number: 7
recoveryeventcustomospfunc()
{
	level waittill("Gas_Cloud_Start");
	level.orbitalsupportoverrides.spawnanglemin = 120;
	level.orbitalsupportoverrides.spawnanglemax = 180;
	level.orbitalsupportoverrides.turretpitch = 55;
	level.orbitalsupportoverrides.toparc = -40;
	level.orbitalsupportoverrides.bottomarc = 65;
}

//Function Number: 8
spawnsetup()
{
	level.dynamichangarspawns = 0;
	level.dynamicspawns = ::getlistofgoodspawnpoints;
}

//Function Number: 9
set_lighting_values()
{
	if(isusinghdr())
	{
		for(;;)
		{
			level waittill("connected",var_00);
			var_00 setclientdvars("r_tonemap","1");
		}
	}
}

//Function Number: 10
dynamic_ents()
{
	var_00 = getent("mp_recovery_signage","targetname");
	wait(0.05);
	var_00 common_scripts\utility::hide_notsolid();
	flickerlights();
	var_01 = getentarray("hangar_door_right","targetname");
	var_02 = getentarray("hangar_door_left","targetname");
	var_03 = getentarray("chemical_missile","targetname");
	var_04 = getentarray("chemical_missile2","targetname");
	var_05 = getentarray("chemical_missile3","targetname");
	var_06 = getentarray("chemical_missile4","targetname");
	var_07 = getentarray("chemical_missile5","targetname");
	var_08 = getentarray("chemical_missile6","targetname");
	var_09 = getentarray("chemical_missile7","targetname");
	var_0A = getentarray("chemical_missile8","targetname");
	var_0B = getentarray("chemical_missile9","targetname");
	var_0C = getentarray("chemical_missile10","targetname");
	var_0D = getentarray("deathTrig_1","targetname");
	var_0E = getentarray("deathTrig_2","targetname");
	var_0F = getentarray("deathTrig_3","targetname");
	foreach(var_11 in var_0D)
	{
		var_11 dontinterpolate();
		var_11.origin = var_11.origin + (0,0,-10000);
	}

	foreach(var_14 in var_0E)
	{
		var_14 dontinterpolate();
		var_14.origin = var_14.origin + (0,0,-10000);
	}

	foreach(var_17 in var_0F)
	{
		var_17 dontinterpolate();
		var_17.origin = var_17.origin + (0,0,-10000);
	}

	level waittill("Missile_Wave2_ended");
	level.dynamichangarspawns = 1;
	level.dynamiceventstatus = "after";
	wait(5);
	foreach(var_11 in var_0D)
	{
		var_11 dontinterpolate();
		var_11.origin = var_11.origin + (0,0,10000);
	}

	wait(5);
	foreach(var_14 in var_0E)
	{
		var_14 dontinterpolate();
		var_14.origin = var_14.origin + (0,0,10000);
	}

	wait(5);
	foreach(var_17 in var_0F)
	{
		var_17 dontinterpolate();
		var_17.origin = var_17.origin + (0,0,10000);
	}
}

//Function Number: 11
recovery_dynamic_event()
{
	var_00 = getent("hologram_signs","targetname");
	var_00 common_scripts\utility::hide_notsolid();
	var_01 = getent("mp_recovery_signage","targetname");
	var_01 show();
	thread killlights();
	thread spawnhangardoors();
	thread volcanostarteruption();
	thread gascloudstart();
}

//Function Number: 12
handle_teleport()
{
	var_00 = level.gametype;
	if(!var_00 == "dom" || var_00 == "ctf" || var_00 == "hp" || var_00 == "ball")
	{
		return;
	}

	if(var_00 == "hp")
	{
		level waittill("dynamic_event_starting");
	}
	else
	{
		level waittill("hangar_doors_opening");
	}

	level.hp_pause_for_dynamic_event = 1;
	maps\mp\_teleport::teleport_to_zone("zone_0",1);
	level.usestartspawns = 0;
}

//Function Number: 13
dynamic_pathing_main()
{
	var_00 = getentarray("hangar_door_right","targetname");
	level waittill("hangar_doors_opening");
	wait(3);
	foreach(var_02 in var_00)
	{
		if(var_02.classname == "script_brushmodel")
		{
			var_02 connectpaths();
		}
	}

	var_04 = getnodearray("escape_gas_dest_node","targetname");
	var_05 = getentarray("escape_gas_dest_trigger","targetname");
	foreach(var_07 in level.participants)
	{
		if(isai(var_07))
		{
			var_07 maps\mp\bots\_bots_strategy::bot_defend_stop();
			switch(level.gametype)
			{
				case "dm":
				case "infect":
				case "conf":
				case "war":
					var_07 thread escape_gas(var_04,var_05);
					break;

				default:
					break;
			}
		}
	}

	level waittill("hangar_doors_closed");
	foreach(var_02 in var_00)
	{
		if(var_02.classname == "script_brushmodel")
		{
			var_02 disconnectpaths();
		}
	}
}

//Function Number: 14
get_escape_gas_dest_node(param_00)
{
	var_01 = randomint(param_00.size);
	var_02 = param_00[var_01];
	return var_02;
}

//Function Number: 15
clear_script_goal_on_gas_end()
{
	level endon("game_ended");
	self endon("disconnect");
	level waittill("hangar_doors_closed");
	wait(0.05);
	self botclearscriptgoal();
}

//Function Number: 16
escape_gas(param_00,param_01)
{
	level endon("game_ended");
	level endon("hangar_doors_closed");
	self endon("disconnect");
	thread clear_script_goal_on_gas_end();
	for(;;)
	{
		var_02 = get_escape_gas_dest_node(param_00);
		self botsetscriptgoal(var_02.origin,512,"critical");
		var_03 = maps\mp\bots\_bots_util::bot_waittill_goal_or_fail(undefined,"death");
		if(var_03 == "goal")
		{
			self botclearscriptgoal();
			wait(5);
			continue;
		}

		wait(1);
	}
}

//Function Number: 17
spawnhangardoors()
{
	var_00 = getentarray("hangar_door_right","targetname");
	var_01 = 12;
	var_02 = 12;
	level waittill("Gas_Cloud_Start");
	level.dynamiceventstatus = "event_in_progress";
	foreach(var_04 in var_00)
	{
		var_05 = getent(var_04.target,"targetname");
		var_04 moveto(var_05.origin,var_01);
	}

	thread notify_doors_open(var_01);
	var_07 = getentarray("hangar_open_sfx","targetname");
	foreach(var_09 in var_07)
	{
		maps\mp\_audio::snd_play_in_space("mp_recovery_hangar_door_open",var_09.origin);
	}

	level waittill("close_doors");
	foreach(var_04 in var_00)
	{
		var_04.unresolved_collision_kill = 1;
		var_05 = getent(var_04.target,"targetname");
		var_0C = getent(var_05.target,"targetname");
		var_04 moveto(var_0C.origin,var_02);
		level thread maps\mp\mp_recovery_fx::sulfur_door_fx();
	}

	thread notify_doors_close(var_02,var_00);
	var_07 = getentarray("hangar_open_sfx","targetname");
	foreach(var_09 in var_07)
	{
		maps\mp\_audio::snd_play_in_space("mp_recovery_hangar_door_close",var_09.origin);
	}
}

//Function Number: 18
notify_doors_close(param_00,param_01)
{
	level notify("hangar_doors_closing");
	playsoundatpos((0,0,0),"mp_recovery_doors_closing");
	wait(param_00);
	level notify("hangar_doors_closed");
	wait(2);
	playsoundatpos((0,0,0),"mp_recovery_doors_sealed");
	foreach(var_03 in param_01)
	{
		var_03.unresolved_collision_kill = 0;
	}
}

//Function Number: 19
notify_doors_open(param_00)
{
	level notify("hangar_doors_opening");
	playsoundatpos((0,0,0),"mp_recovery_doors_opening");
	thread side_b_visionset_reset();
	level.hp_pause_for_dynamic_event = 0;
	level notify("ready_for_next_hp_zone");
	wait(param_00);
	level notify("hangar_doors_opened");
}

//Function Number: 20
volcanostarteruption()
{
	thread aud_dyanmic_event();
	earthquake(0.6,2,(0,0,0),5000);
	foreach(var_01 in level.players)
	{
		var_01 thread play_earthquake_rumble(0.75);
	}

	level.gas_cloud_origin = getent("gas_cloud_origin","targetname");
	stopclientexploder(200);
	if(isdefined(level.panoramicfx))
	{
		level.panoramicfx delete();
	}

	level thread common_scripts\_exploder::activate_clientside_exploder(100);
	wait(8);
	thread boulderbarrage(15,2,10,19);
	wait(5);
	foreach(var_01 in level.players)
	{
		var_01 setclienttriggervisionset("mp_recovery_post",10);
	}

	level notify("Gas_Cloud_Start");
}

//Function Number: 21
aud_dyanmic_event()
{
	playsoundatpos((2067,-2296,186),"emt_event_volcano_erupt");
	thread aud_handle_alarms();
	wait(4);
	playsoundatpos((0,0,0),"mp_recovery_volcanic_activity");
}

//Function Number: 22
aud_handle_alarms()
{
	level endon("hangar_doors_closed");
	for(;;)
	{
		playsoundatpos((0,0,0),"mp_recovery_alarms");
		wait(4);
	}
}

//Function Number: 23
gascloudstart()
{
	level waittill("Gas_Cloud_Start");
	wait(5);
	level.gas_cloud_origin = getent("gas_cloud_origin","targetname");
	playfxontag(common_scripts\utility::getfx("pyroclastic_flow_1"),level.gas_cloud_origin,"tag_origin");
	wait(5);
	thread boulderbarrage(15,2,20,29);
	maps\mp\_utility::delaythread(15,::boulderbarrage,15,1.5,30,39);
	level.dynamichangarspawns = 1;
	var_00 = 40;
	var_01 = 12;
	level.gas_cloud_origin moveto(level.gas_cloud_origin.origin + (0,3912,0),var_00);
	level.gas_cloud_origin thread killplayersincloud(var_00 + var_01,7.5);
	var_02 = var_00 - var_01 / 2;
	thread setup_poison_gas_death();
	wait(var_02);
	level notify("close_doors");
	wait(var_01);
	stopfxontag(common_scripts\utility::getfx("pyroclastic_flow_1"),level.gas_cloud_origin,"tag_origin");
	level.gas_cloud_origin thread instantkillplayersincloud();
	level thread common_scripts\_exploder::activate_clientside_exploder(102);
	wait(0.05);
	level notify("gas_cloud_finished");
	stopclientexploder(40);
}

//Function Number: 24
onplayerconnect()
{
	var_00 = getent("safe_from_gas","targetname");
	for(;;)
	{
		level waittill("connected",var_01);
		var_01 thread swapfogandfx(var_00);
	}
}

//Function Number: 25
swapfogandfx(param_00)
{
	level endon("gas_cloud_finished");
	self endon("disconnect");
	for(;;)
	{
		if(!isdefined(param_00) || !isdefined(self))
		{
			break;
		}

		if(level.dynamiceventstatus == "event_in_progress" && isalive(self))
		{
			if(!self istouching(param_00) && isdefined(self.onnopoisonside))
			{
				self setclienttriggervisionset("mp_recovery_post",5);
				stopfxontag(common_scripts\utility::getfx("pyroclastic_flow_2"),level.gas_cloud_origin,"tag_origin");
				playfxontag(common_scripts\utility::getfx("pyroclastic_flow_1"),level.gas_cloud_origin,"tag_origin");
				self.onnopoisonside = undefined;
			}
			else if(self istouching(param_00) && !isdefined(self.onnopoisonside))
			{
				self setclienttriggervisionset("",5);
				stopfxontag(common_scripts\utility::getfx("pyroclastic_flow_1"),level.gas_cloud_origin,"tag_origin");
				playfxontag(common_scripts\utility::getfx("pyroclastic_flow_2"),level.gas_cloud_origin,"tag_origin");
				self.onnopoisonside = 1;
			}

			wait(0.2);
			continue;
		}

		wait(1);
	}
}

//Function Number: 26
flickerlights()
{
	var_00 = getscriptablearray("stairlgt_die_3","targetname");
	foreach(var_02 in var_00)
	{
		var_02 setscriptablepartstate(0,1);
	}

	var_04 = getscriptablearray("die_2","targetname");
	foreach(var_06 in var_04)
	{
		var_06 setscriptablepartstate(0,1);
	}
}

//Function Number: 27
killlights()
{
	var_00 = getscriptablearray("killed_lights","targetname");
	foreach(var_02 in var_00)
	{
		wait(0.1);
		var_02 setscriptablepartstate(0,1);
	}

	var_04 = getscriptablearray("danger_red","targetname");
	foreach(var_06 in var_04)
	{
		var_06 setscriptablepartstate(0,1);
	}

	var_08 = getscriptablearray("die","targetname");
	foreach(var_0A in var_08)
	{
		var_0A setscriptablepartstate(0,2);
		wait(0.1);
		var_0A setscriptablepartstate(0,3);
	}

	var_0C = getscriptablearray("die_2","targetname");
	foreach(var_0E in var_0C)
	{
		var_0E setscriptablepartstate(0,3);
	}

	var_10 = getscriptablearray("stairlgt_die_3","targetname");
	foreach(var_12 in var_10)
	{
		var_12 setscriptablepartstate(0,3);
	}

	var_14 = getscriptablearray("stairlgt_die","targetname");
	foreach(var_16 in var_14)
	{
		wait(0.1);
		var_16 setscriptablepartstate(0,1);
		wait(0.15);
		var_16 setscriptablepartstate(0,3);
	}

	var_18 = getscriptablearray("stairlgt_die_2","targetname");
	foreach(var_1A in var_18)
	{
		var_1A setscriptablepartstate(0,3);
		wait(0.2);
		var_1A setscriptablepartstate(0,1);
	}

	var_1C = getscriptablearray("evacuate_lights","targetname");
	foreach(var_1E in var_1C)
	{
		var_1E setscriptablepartstate(0,1);
	}

	var_20 = getscriptablearray("evacuate_pill_lights","targetname");
	foreach(var_22 in var_20)
	{
		var_22 setscriptablepartstate(0,1);
	}

	var_24 = getscriptablearray("hologram_lgt","targetname");
	foreach(var_26 in var_24)
	{
		var_26 setscriptablepartstate(0,2);
	}

	var_28 = getscriptablearray("cave_kill","targetname");
	foreach(var_2A in var_28)
	{
		var_2A setscriptablepartstate(0,1);
		wait(0.2);
		var_2A setscriptablepartstate(0,2);
	}
}

//Function Number: 28
boulderbarrage(param_00,param_01,param_02,param_03)
{
	var_04 = gettime() + param_00 * 1000;
	var_05 = 0;
	var_06 = 0;
	while(gettime() < var_04)
	{
		wait(randomfloatrange(param_01 / 2,param_01));
		while(var_05 == 0)
		{
			var_05 = randomintrange(param_02,param_03);
			if(var_05 == var_06)
			{
				var_05 = 0;
				continue;
			}

			var_06 = var_05;
			level thread common_scripts\_exploder::activate_clientside_exploder(var_05);
			level thread maps\mp\mp_recovery_fx::setup_boulder_audio(var_05);
			var_05 = 0;
			break;
			wait(0.05);
		}
	}
}

//Function Number: 29
killplayersincloud(param_00,param_01)
{
	var_02 = 800;
	var_03 = getent("safe_from_gas","targetname");
	var_04 = gettime() + param_00 * 1000;
	foreach(var_06 in level.players)
	{
		var_06.isingas = 0;
	}

	while(gettime() < var_04)
	{
		foreach(var_06 in level.players)
		{
			var_09 = var_06 getvieworigin();
			if(var_06.origin[1] < self.origin[1] - 500 && !var_06 istouching(var_03))
			{
				var_06 dodamage(param_01,var_06.origin);
				if(!var_06 maps\mp\_utility::isusingremote() && var_09[1] < self.origin[1] && var_09[2] < var_02)
				{
					var_06 setclienttriggervisionset("poison_gas",1.5);
					var_06 shellshock("mp_lab_gas",1,1,1,0);
				}

				var_06.isingas = 1;
				continue;
			}

			if(!var_06 maps\mp\_utility::isusingremote())
			{
				if(var_06.isingas == 1)
				{
					if(var_06 istouching(var_03))
					{
						var_06 maps\mp\_utility::revertvisionsetforplayer(1.5);
					}
					else
					{
						var_06 setclienttriggervisionset("mp_recovery_post",1.5);
					}

					var_06.isingas = 0;
				}
			}
		}

		if(level.gametype == "ctf")
		{
			foreach(var_0C in level.teamflags)
			{
				if(var_0C.curorigin[1] < self.origin[1] && !var_0C.visuals[0] istouching(var_03))
				{
					var_0C maps\mp\gametypes\ctf::returnflag();
				}
			}
		}

		wait(0.25);
	}
}

//Function Number: 30
instantkillplayersincloud()
{
	var_00 = getent("safe_from_gas","targetname");
	foreach(var_02 in level.players)
	{
		if(!var_02 istouching(var_00))
		{
			var_02 dodamage(10000,var_02.origin);
		}
	}
}

//Function Number: 31
side_b_visionset_reset()
{
	level endon("game_ended");
	level endon("hangar_doors_closed");
	var_00 = getent("safe_from_gas","targetname");
	for(;;)
	{
		var_00 waittill("trigger",var_01);
		if(isdefined(var_01) && isplayer(var_01) && !isdefined(var_01.safefromgas))
		{
			var_01 maps\mp\_utility::revertvisionsetforplayer(3);
			var_01.safefromgas = 1;
		}
	}
}

//Function Number: 32
setup_poison_gas_death()
{
	foreach(var_01 in level.players)
	{
		var_01 thread onplayerdeath();
	}
}

//Function Number: 33
onplayerdeath()
{
	level endon("game_ended");
	self endon("disconnect");
	self waittill("spawned");
	maps\mp\_utility::revertvisionsetforplayer(0);
}

//Function Number: 34
shockthink()
{
	if(!isdefined(self.ingas))
	{
		self shellshock("mp_lab_gas",1);
	}
}

//Function Number: 35
play_event_music()
{
}

//Function Number: 36
play_earthquake_rumble(param_00)
{
	self endon("death");
	level endon("game_ended");
	for(var_01 = param_00 * 20;var_01 >= 0;var_01 = var_01 - 2)
	{
		self playrumbleonentity("damage_light");
		wait(0.1);
	}
}

//Function Number: 37
getlistofgoodspawnpoints(param_00)
{
	var_01 = [];
	foreach(var_03 in param_00)
	{
		if(!isdefined(var_03.targetname) || var_03.targetname == "")
		{
			var_01 = common_scripts\utility::add_to_array(var_01,var_03);
			continue;
		}

		if(var_03 getvalidspawns() == 1)
		{
			var_01 = common_scripts\utility::add_to_array(var_01,var_03);
		}
	}

	return var_01;
}

//Function Number: 38
getvalidspawns()
{
	if(level.dynamichangarspawns == 0)
	{
		if(self.targetname == "first_map_spawns")
		{
			return 1;
		}
	}
	else if(level.dynamichangarspawns == 1)
	{
		if(self.targetname == "second_map_spawns")
		{
			return 1;
		}
	}

	return 0;
}