/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\mp_zombie_lab.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 23
 * Decompile Time: 364 ms
 * Timestamp: 4/22/2024 2:19:46 AM
*******************************************************************/

//Function Number: 1
main()
{
	maps\mp\mp_zombie_lab_precache::main();
	maps\mp\mp_zombie_lab_fx::main();
	maps\createart\mp_zombie_lab_fog::main();
	maps\createart\mp_zombie_lab_fog_hdr::main();
	maps\createart\mp_zombie_lab_art::main();
	if(getdvar("r_reflectionProbeGenerate") == "1")
	{
		onreflectionprobecompile();
	}

	maps\mp\_load::main();
	maps\mp\mp_zombie_lab_lighting::main();
	maps\mp\mp_zombie_lab_aud::main();
	maps\mp\mp_zombie_lab_sq::init_sidequest();
	zombielabfixupminimapcorners();
	maps\mp\_compass::setupminimap("compass_map_mp_zombie_lab");
	game["attackers"] = "allies";
	game["defenders"] = "axis";
	level.zombiehostinit = ::maps\mp\zombies\zombie_host::init;
	level.zombiedoginit = ::maps\mp\zombies\zombie_dog::init;
	maps\mp\zombies\_util::enabletokens();
	level.zombies_using_civilians = 0;
	level.zombieinfectedvisionset = "mp_zombie_lab_infected";
	level.zombieinfectedvisionset2 = "mp_zombie_lab_infected_crazy";
	level.zombieinfectedlightset = "mp_zombie_lab_infected";
	level.onstartgametypelevelfunc = ::onzombielabstartgame;
	level._zmbvoxlevelspecific = ::initwaveintermissiondialog;
	level.shouldignoreplayercallback = ::labshouldignoreplayer;
	thread initlabmutators();
	thread initzones();
	thread initcharactermodels();
	thread biochamber();
	thread deleteexoterminallargetriggeronpower();
	if(level.nextgen)
	{
		thread crashhelianim();
	}

	if(level.nextgen)
	{
		level thread zombielabpatchclip();
	}

	level.zmpatchshovefunc = ::zombielabpatchshove;
	if(level.currentgen)
	{
		var_00 = getentarray("CG_ExtraExploitTriggers","targetname");
		foreach(var_02 in var_00)
		{
			var_02 thread cg_exploittriggermonitor();
		}

		var_00 = getentarray("cg_trigger_break_glass","targetname");
		foreach(var_02 in var_00)
		{
			var_02 thread cg_breakglasstriggermonitor();
		}

		thread zombiestuckspotfix01();
	}
}

//Function Number: 2
zombiestuckspotfix01()
{
	level endon("game_ended");
	var_00 = spawn("trigger_radius",(-956,3572,68),0,164,128);
	for(;;)
	{
		var_00 waittill("trigger",var_01);
		if(isdefined(var_01) && !isremovedentity(var_01) && isalive(var_01) && isagent(var_01) && !isdefined(var_01.object_avoid) && isdefined(var_01.team) && var_01.team == level.enemyteam)
		{
			var_01 scragentsetobstacleavoid(1);
			var_01.object_avoid = 1;
			var_01 thread resetavoidtimer();
		}
	}
}

//Function Number: 3
resetavoidtimer()
{
	level endon("game_ended");
	wait(4);
	if(isdefined(self) && !isremovedentity(self))
	{
		self scragentsetobstacleavoid(0);
		self.object_avoid = undefined;
	}
}

//Function Number: 4
onreflectionprobecompile()
{
	var_00 = getentarray("power_show","targetname");
	foreach(var_02 in var_00)
	{
		var_02 delete();
	}

	var_04 = getentarray("power_hide","targetname");
	foreach(var_02 in var_04)
	{
		var_02 delete();
	}
}

//Function Number: 5
zombielabfixupminimapcorners()
{
	var_00 = getentarray("minimap_corner","targetname");
	if(var_00.size != 2)
	{
		return;
	}

	var_00[0].origin = (-4608,6912,192);
	var_00[1].origin = (3072,-768,128);
}

//Function Number: 6
zombielabpatchclip()
{
	maps\mp\_utility::spawnpatchclip("patchclip_player_32_32_32",(185,1627,136),(0,-42.7,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_32_32_32",(348,3126,180),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_32_32_32",(348,3146,180),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64",(1355,1095,170),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64",(988,1287,144),(0,90,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64",(785,1089,144),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_128_128",(703,1373,104),(0,-45,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_128_128",(-1009,3372,253),(-5,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_128_128",(1094.5,3422.5,392),(0,90,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(-571.5,2502.5,192),(0,45,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(878,1988.5,324),(0,90,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(1586.5,1152,336),(5,45,0));
	level thread killglass();
}

//Function Number: 7
zombielabpatchshove(param_00,param_01)
{
	if(param_00)
	{
		if(self.currentzone == "military" && distancesquared(self.origin,(-1845.12,2704,267.125)) < 16)
		{
			self setvelocity((100,0,0));
			return;
		}

		if(self.currentzone == "experimentation")
		{
			if(abs(self.origin[2] - 300) < 5 && abs(self.origin[1] - 3187) < 5)
			{
				var_02 = self getnearestnode();
				if(isdefined(var_02) && self.origin[2] - var_02.origin[2] > 40)
				{
					self setvelocity((0,-100,0));
					return;
				}

				return;
			}

			if(distancesquared(self.origin,(376.846,3177.79,286.386)) < 100)
			{
				self setvelocity((100,-100,0));
				return;
			}

			if(distancesquared(self.origin,(375.539,3164.19,284.327)) < 64)
			{
				self setvelocity((100,0,0));
				return;
			}

			if(distancesquared(self.origin,(375.551,3156.28,279.062)) < 16)
			{
				self setvelocity((100,0,0));
				return;
			}

			if(distancesquared(self.origin,(375.59,3144.32,271.104)) < 64)
			{
				self setvelocity((100,0,0));
				return;
			}

			if(distancesquared(self.origin,(378.329,3131.99,262.901)) < 16)
			{
				self setvelocity((100,0,0));
				return;
			}

			if(distancesquared(self.origin,(375.024,3115.55,251.955)) < 16)
			{
				self setvelocity((100,0,0));
				return;
			}

			return;
		}

		return;
	}

	if(param_01)
	{
		if(self.currentzone == "roundabout")
		{
			var_03 = (112,1543,272);
			var_04 = vectornormalize(self.origin - var_03 * (1,1,0));
			if(abs(self.origin[2] - 200) < 14)
			{
				var_02 = self getnearestnode();
				if(isdefined(var_02) && self.origin[2] - var_02.origin[2] > 68)
				{
					self setvelocity(var_04 * 200);
					return;
				}

				return;
			}

			if(distancesquared(self.origin,(-60.1366,1600.78,248.625)) < 100)
			{
				self setvelocity(var_04 * 200);
				return;
			}

			if(distancesquared(self.origin,(-53.4371,1619.16,248.625)) < 16)
			{
				self setvelocity(var_04 * 200);
				return;
			}

			return;
		}

		if(self.currentzone == "experimentation" && distancesquared(self.origin,(265.649,3985.21,291.625)) < 64)
		{
			var_02 = self getnearestnode();
			if(isdefined(var_02))
			{
				var_05 = vectornormalize(var_02.origin - self.origin * (1,1,0));
				self setvelocity(var_05 * 100);
				return;
			}

			return;
		}

		if(self.currentzone == "lab_hall")
		{
			if(self.origin[2] > 125)
			{
				if(self.origin[0] > 1135 && self.origin[0] < 1382 && self.origin[1] > 1601 && self.origin[1] < 1638)
				{
					self setvelocity((0,-200,0));
					return;
				}

				return;
			}

			return;
		}

		return;
	}
}

//Function Number: 8
killglass()
{
	for(;;)
	{
		var_00 = 1;
		var_01 = 1;
		if(!isdefined(level.players))
		{
			wait(1);
		}

		foreach(var_03 in level.players)
		{
			if(!isalive(var_03))
			{
				continue;
			}

			if(var_03.sessionstate == "spectator" || var_03.sessionstate == "intermission")
			{
				continue;
			}

			if(var_00 && isglassdestroyed(3))
			{
				var_00 = 0;
			}

			if(var_01 && isglassdestroyed(11))
			{
				var_01 = 0;
			}

			if(!var_00 && !var_01)
			{
				break;
			}

			if(isdefined(var_03.currentzone) && var_03.currentzone == "lab")
			{
				if(abs(var_03.origin[0] - 1248) < 6 && abs(var_03.origin[2] - 224) < 5)
				{
					if(var_00 && abs(var_03.origin[1] - 3261.5) < 50)
					{
						destroyglass(3);
					}

					if(var_01 && abs(var_03.origin[1] - 3344.5) < 50)
					{
						destroyglass(11);
					}
				}
			}
		}

		wait(1);
	}
}

//Function Number: 9
onzombielabstartgame()
{
	level thread maps\mp\zombies\_teleport::init();
	level thread maps\mp\zombies\_util::outofboundswatch(0);
	maps\mp\zombies\_traps::register_trap_state_models("dlc_trap_activation_console_01_no_signal","dlc_trap_activation_console_01_ready","dlc_trap_activation_console_01_active","dlc_trap_activation_console_01_cooldown");
}

//Function Number: 10
initlabmutators()
{
	maps\mp\zombies\_mutators::initfastmutator();
	maps\mp\zombies\_mutators::initexplodermutator();
	maps\mp\zombies\_mutators::initemzmutator();
}

//Function Number: 11
initzones()
{
	maps\mp\zombies\_zombies_zone_manager::init();
	maps\mp\zombies\_zombies_zone_manager::initializezone("courtyard",1);
	maps\mp\zombies\_zombies_zone_manager::initializezone("roundabout");
	maps\mp\zombies\_zombies_zone_manager::initializezone("administration");
	maps\mp\zombies\_zombies_zone_manager::initializezone("lab");
	maps\mp\zombies\_zombies_zone_manager::initializezone("lab_hall");
	maps\mp\zombies\_zombies_zone_manager::initializezone("military");
	maps\mp\zombies\_zombies_zone_manager::initializezone("experimentation");
	maps\mp\zombies\_zombies_zone_manager::initializezone("experimentation_stairs");
	maps\mp\zombies\_zombies_zone_manager::addadjacentzone("courtyard","roundabout","courtyard_to_roundabout");
	maps\mp\zombies\_zombies_zone_manager::addadjacentzone("courtyard","administration","courtyard_to_administration");
	maps\mp\zombies\_zombies_zone_manager::addadjacentzone("roundabout","military","roundabout_to_military");
	maps\mp\zombies\_zombies_zone_manager::addadjacentzone("roundabout","lab_hall","roundabout_to_lab");
	maps\mp\zombies\_zombies_zone_manager::addadjacentzone("administration","lab_hall","administration_to_lab");
	maps\mp\zombies\_zombies_zone_manager::addadjacentzone("lab","experimentation","lab_to_experimentation");
	maps\mp\zombies\_zombies_zone_manager::addadjacentzone("military","experimentation_stairs","military_to_experimentation");
	maps\mp\zombies\_zombies_zone_manager::addadjacentzone("experimentation","experimentation_stairs","military_or_lab_to_experimentation");
	maps\mp\zombies\_util::flag_link("military_to_experimentation","military_or_lab_to_experimentation");
	maps\mp\zombies\_util::flag_link("lab_to_experimentation","military_or_lab_to_experimentation");
	maps\mp\zombies\_zombies_zone_manager::addadjacentzone("lab","lab_hall","roundabout_or_administration_or_experimentation_to_lab");
	maps\mp\zombies\_util::flag_link("administration_to_lab","roundabout_or_administration_or_experimentation_to_lab");
	maps\mp\zombies\_util::flag_link("roundabout_to_lab","roundabout_or_administration_or_experimentation_to_lab");
	maps\mp\zombies\_util::flag_link("lab_to_experimentation","roundabout_or_administration_or_experimentation_to_lab");
	maps\mp\zombies\_zombies_zone_manager::activate();
	level.doorbitmaskarray = [];
	level.doorbitmaskarray["courtyard_to_roundabout"] = 1;
	level.doorbitmaskarray["roundabout_to_lab"] = 2;
	level.doorbitmaskarray["roundabout_to_military"] = 4;
	level.doorbitmaskarray["courtyard_to_administration"] = 8;
	level.doorbitmaskarray["administration_to_lab"] = 16;
	level.doorbitmaskarray["lab_to_experimentation"] = 32;
	level.doorbitmaskarray["military_to_experimentation"] = 64;
	maps\mp\zombies\_doors::registerhintstring(&"ZOMBIE_LAB_DOOR_TO_ROUNDABOUT","courtyard_to_roundabout",0);
	maps\mp\zombies\_doors::registerhintstring(&"ZOMBIE_LAB_DOOR_TO_COURTYARD","courtyard_to_roundabout",1);
	maps\mp\zombies\_doors::registerhintstring(&"ZOMBIE_LAB_DOOR_TO_LAB","roundabout_to_lab",0);
	maps\mp\zombies\_doors::registerhintstring(&"ZOMBIE_LAB_DOOR_TO_ROUNDABOUT","roundabout_to_lab",1);
	maps\mp\zombies\_doors::registerhintstring(&"ZOMBIE_LAB_DOOR_TO_MILITARY","roundabout_to_military",0);
	maps\mp\zombies\_doors::registerhintstring(&"ZOMBIE_LAB_DOOR_TO_ROUNDABOUT","roundabout_to_military",1);
	maps\mp\zombies\_doors::registerhintstring(&"ZOMBIE_LAB_DOOR_TO_ADMIN","courtyard_to_administration",0);
	maps\mp\zombies\_doors::registerhintstring(&"ZOMBIE_LAB_DOOR_TO_COURTYARD","courtyard_to_administration",1);
	maps\mp\zombies\_doors::registerhintstring(&"ZOMBIE_LAB_DOOR_TO_LAB","administration_to_lab",0);
	maps\mp\zombies\_doors::registerhintstring(&"ZOMBIE_LAB_DOOR_TO_ADMIN","administration_to_lab",1);
	maps\mp\zombies\_doors::registerhintstring(&"ZOMBIE_LAB_DOOR_TO_EXPER","lab_to_experimentation",0);
	maps\mp\zombies\_doors::registerhintstring(&"ZOMBIE_LAB_DOOR_TO_LAB","lab_to_experimentation",1);
	maps\mp\zombies\_doors::registerhintstring(&"ZOMBIE_LAB_DOOR_TO_EXPER","military_to_experimentation",0);
	maps\mp\zombies\_doors::registerhintstring(&"ZOMBIE_LAB_DOOR_TO_MILITARY","military_to_experimentation",1);
}

//Function Number: 12
initcharactermodels()
{
	maps\mp\zombies\_util::initializecharactermodel("security","security_guard_body","viewhands_security_guard",["security_guard_head"]);
	maps\mp\zombies\_util::initializecharactermodel("exec","executive_body","viewhands_executive",["executive_head"]);
	maps\mp\zombies\_util::initializecharactermodel("it","lilith_body","viewhands_lilith",["lilith_head"]);
	maps\mp\zombies\_util::initializecharactermodel("janitor","janitor_body","viewhands_janitor",["janitor_head"]);
	maps\mp\zombies\_util::initializecharactermodel("security_exo","security_guard_body_exo","viewhands_security_guard_exo",["security_guard_head"]);
	maps\mp\zombies\_util::initializecharactermodel("exec_exo","executive_body_exo","viewhands_executive_exo",["executive_head"]);
	maps\mp\zombies\_util::initializecharactermodel("it_exo","lilith_body_exo","viewhands_lilith_exo",["lilith_head"]);
	maps\mp\zombies\_util::initializecharactermodel("janitor_exo","janitor_body_exo","viewhands_janitor_exo",["janitor_head"]);
	maps\mp\zombies\_util::initializecharactermodel("security_host","security_guard_body",undefined,["security_guard_head_z"]);
	maps\mp\zombies\_util::initializecharactermodel("exec_host","executive_body",undefined,["executive_head_z"]);
	maps\mp\zombies\_util::initializecharactermodel("it_host","lilith_body",undefined,["lilith_head_z"]);
	maps\mp\zombies\_util::initializecharactermodel("janitor_host","janitor_body",undefined,["janitor_head_z"]);
}

//Function Number: 13
biochamber()
{
	precachempanim("dlc_lab_exo_cage_closed_idle");
	precachempanim("dlc_lab_exo_cage_open");
	var_00 = getentarray("biochamber_top","targetname");
	foreach(var_02 in var_00)
	{
		var_02 linktargetedents();
	}

	var_04 = getentarray("biochamber_bottom","targetname");
	foreach(var_06 in var_04)
	{
		var_06 linktargetedents();
	}

	var_08 = common_scripts\utility::getstruct("exo_cage_animnode","targetname");
	var_09 = getent("exo_cage","targetname");
	if(isdefined(var_09) && isdefined(var_08))
	{
		var_09 scriptmodelplayanimdeltamotionfrompos("dlc_lab_exo_cage_closed_idle",var_08.origin,var_08.angles);
	}

	activatepersistentclientexploder(99);
	level waittill("power_experimentation_01");
	stopclientexploder(99);
	common_scripts\_exploder::activate_clientside_exploder(100);
	if(isdefined(var_09) && isdefined(var_08))
	{
		var_09 scriptmodelplayanimdeltamotionfrompos("dlc_lab_exo_cage_open",var_08.origin,var_08.angles);
	}

	foreach(var_02 in var_00)
	{
		if(var_02 maps\mp\_movers::script_mover_is_dynamic_path())
		{
			var_02 connectpaths();
		}

		var_02 moveto(var_02.origin + (0,0,132),2);
	}

	foreach(var_06 in var_04)
	{
		if(var_06 maps\mp\_movers::script_mover_is_dynamic_path())
		{
			var_06 connectpaths();
		}

		var_06 moveto(var_06.origin - (0,0,132),2);
	}

	wait(3.5);
	maps\mp\zombies\_zombies_audio_announcer::announcerexoonlinedialog();
	thread playexosuitvoattractor();
}

//Function Number: 14
playexosuitvoattractor()
{
	var_00 = 360000;
	var_01 = getentarray("exo_terminal","targetname");
	if(var_01.size == 0)
	{
		return;
	}

	wait(10);
	var_02 = var_01[0];
	for(;;)
	{
		if(maps\mp\zombies\_zombies_audio_announcer::isannouncerspeaking())
		{
			maps\mp\zombies\_zombies_audio_announcer::waittillannouncerdonespeaking();
			wait(1);
			continue;
		}

		var_03 = [];
		var_04 = 0;
		foreach(var_06 in level.players)
		{
			if(maps\mp\zombies\_util::is_true(var_06.exosuitonline))
			{
				continue;
			}

			var_04++;
			if(distance2dsquared(var_02.origin,var_06.origin) > var_00)
			{
				continue;
			}

			var_03[var_03.size] = var_06;
		}

		if(var_04 == 0)
		{
			return;
		}
		else
		{
			maps\mp\zombies\_zombies_audio_announcer::announcerglobalattractordialog("exo_suit_avail",var_03);
		}

		wait(15);
	}
}

//Function Number: 15
linktargetedents()
{
	if(!isdefined(self.target))
	{
		return;
	}

	var_00 = getentarray(self.target,"targetname");
	foreach(var_02 in var_00)
	{
		var_02 linkto(self);
	}
}

//Function Number: 16
deleteexoterminallargetriggeronpower()
{
	wait 0.05;
	var_00 = getent("exo_terminal_large_power_off","targetname");
	if(!isdefined(var_00))
	{
		return;
	}

	common_scripts\utility::flag_wait(var_00.script_flag_true);
	var_00 delete();
}

//Function Number: 17
initwaveintermissiondialog()
{
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","it_exec_1","it_exec_wave_intermission_ctx01",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","it_exec_2","it_exec_wave_intermission_ctx02",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","exec_it_3","it_exec_wave_intermission_ctx03",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","exec_it_4","it_exec_wave_intermission_ctx04",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","it_exec_5","it_exec_wave_intermission_ctx05",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","it_exec_6","it_exec_wave_intermission_ctx06",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","it_exec_7","it_exec_wave_intermission_ctx07",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","exec_it_8","it_exec_wave_intermission_ctx08",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","it_exec_9","it_exec_wave_intermission_ctx09",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","it_exec_10","it_exec_wave_intermission_ctx10",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","guard_exec_1","guard_exec_wave_intermission_ctx01",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","guard_exec_2","guard_exec_wave_intermission_ctx02",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","guard_exec_3","guard_exec_wave_intermission_ctx03",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","guard_exec_4","guard_exec_wave_intermission_ctx04",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","guard_exec_5","guard_exec_wave_intermission_ctx05",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","guard_exec_6","guard_exec_wave_intermission_ctx06",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","guard_exec_7","guard_exec_wave_intermission_ctx07",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","guard_exec_8","guard_exec_wave_intermission_ctx08",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","exec_guard_9","guard_exec_wave_intermission_ctx09",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","exec_guard_10","guard_exec_wave_intermission_ctx10",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","exec_guard_11","guard_exec_wave_intermission_ctx11",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","janitor_exec_1","janitor_exec_wave_intermission_ctx01",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","exec_janitor_2","janitor_exec_wave_intermission_ctx02",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","exec_janitor_3","janitor_exec_wave_intermission_ctx03",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","exec_janitor_4","janitor_exec_wave_intermission_ctx04",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","exec_janitor_5","janitor_exec_wave_intermission_ctx05",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","exec_janitor_6","janitor_exec_wave_intermission_ctx06",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","janitor_exec_7","janitor_exec_wave_intermission_ctx07",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","janitor_exec_8","janitor_exec_wave_intermission_ctx08",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","it_guard_1","it_guard_wave_intermission_ctx01",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","it_guard_2","it_guard_wave_intermission_ctx02",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","it_guard_3","it_guard_wave_intermission_ctx03",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","it_guard_4","it_guard_wave_intermission_ctx04",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","guard_it_5","it_guard_wave_intermission_ctx05",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","guard_it_6","it_guard_wave_intermission_ctx06",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","it_guard_7","it_guard_wave_intermission_ctx07",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","guard_it_8","it_guard_wave_intermission_ctx08",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","guard_it_9","it_guard_wave_intermission_ctx09",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","it_guard_10","it_guard_wave_intermission_ctx10",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","guard_it_11","it_guard_wave_intermission_ctx11",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","janitor_it_1","it_janitor_wave_intermission_ctx01",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","it_janitor_2","it_janitor_wave_intermission_ctx02",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","it_janitor_3","it_janitor_wave_intermission_ctx04",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","it_janitor_4","it_janitor_wave_intermission_ctx05",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","it_janitor_5","it_janitor_wave_intermission_ctx06",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","janitor_it_6","it_janitor_wave_intermission_ctx07",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","it_janitor_7","it_janitor_wave_intermission_ctx08",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","it_janitor_8","it_janitor_wave_intermission_ctx09",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","janitor_it_9","it_janitor_wave_intermission_ctx10",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","it_janitor_10","it_janitor_wave_intermission_ctx11",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","it_janitor_11","it_janitor_wave_intermission_ctx12",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","it_janitor_12","it_janitor_wave_intermission_ctx13",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","janitor_it_13","it_janitor_wave_intermission_ctx14",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","janitor_it_14","it_janitor_wave_intermission_ctx15",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","guard_janitor_1","guard_janitor_wave_intermission_ctx01",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","guard_janitor_2","guard_janitor_wave_intermission_ctx02",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","guard_janitor_3","guard_janitor_wave_intermission_ctx03",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","guard_janitor_4","guard_janitor_wave_intermission_ctx04",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","guard_janitor_5","guard_janitor_wave_intermission_ctx05",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","guard_janitor_6","guard_janitor_wave_intermission_ctx06",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","guard_janitor_7","guard_janitor_wave_intermission_ctx07",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","guard_janitor_8","guard_janitor_wave_intermission_ctx08",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","guard_janitor_9","guard_janitor_wave_intermission_ctx09",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("player","conversation","guard_janitor_10","guard_janitor_wave_intermission_ctx10",undefined);
	level.mysteryguystruct = spawnstruct();
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxinitspeaker("announcer2","end_game_atlas_mysteryguy_",level.mysteryguystruct,0);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer2","global_priority","conversation0","ctx01",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer2","global_priority","conversation1","ctx02",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer2","global_priority","conversation2","ctx03",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer2","global_priority","conversation3","ctx04",undefined);
	level.endgamewaitfunc = ::endgamedialog;
	thread endgamestatic();
}

//Function Number: 18
endgamestatic()
{
	level waittill("spawning_intermission");
	foreach(var_01 in level.players)
	{
		var_01 setclientomnvar("ui_zm_hud_static",2);
	}

	wait(0.5);
	foreach(var_01 in level.players)
	{
		var_01 setclientomnvar("ui_zm_hud_static",1);
	}
}

//Function Number: 19
endgamedialog(param_00,param_01,param_02,param_03)
{
	if(param_03 != level.enemyteam)
	{
		if(!param_00 && !level.postgamenotifies)
		{
			if(!maps\mp\_utility::wasonlyround())
			{
				wait(6 + param_02);
			}
			else
			{
				wait(min(10,4 + param_02 + level.postgamenotifies));
			}
		}
		else
		{
			wait(min(10,4 + param_02 + level.postgamenotifies));
		}

		return;
	}

	var_04 = "global_priority";
	var_05 = "conversation" + randomint(4);
	var_06 = 1;
	for(var_07 = 1;var_06;var_07++)
	{
		var_06 = level.mysteryguystruct maps\mp\zombies\_zombies_audio::create_and_play_dialog(var_04,var_05,undefined,var_07,1,undefined,level.players);
		if(isdefined(var_06) && var_06)
		{
			level.mysteryguystruct waittill("done_speaking");
			wait(0.5);
		}
	}

	wait(2);
}

//Function Number: 20
crashhelianim()
{
	var_00 = "dlc_heli_blade_loop";
	precachempanim(var_00);
	var_01 = getent("crashed_heli_blades","targetname");
	var_02 = common_scripts\utility::getstruct("crashed_heli_node","targetname");
	if(isdefined(var_01) && isdefined(var_02))
	{
		var_01 scriptmodelplayanim(var_00);
	}
}

//Function Number: 21
cg_exploittriggermonitor()
{
	level endon("game_ended");
	for(;;)
	{
		self waittill("trigger",var_00);
		if(isplayer(var_00))
		{
			var_01 = maps\mp\agents\_agent_utility::getactiveagentsoftype("all");
			foreach(var_03 in var_01)
			{
				var_04 = distance(var_00.origin,var_03.origin);
				if(var_04 < 100)
				{
					var_05 = common_scripts\utility::getstruct(self.target,"targetname");
					if(isdefined(var_05))
					{
						var_06 = vectornormalize(var_05.origin - var_00.origin * (1,1,0));
						var_00 setvelocity(var_06 * 100);
					}

					break;
				}

				wait(0.1);
			}
		}

		wait(1);
	}
}

//Function Number: 22
cg_breakglasstriggermonitor()
{
	level endon("game_ended");
	var_00 = common_scripts\utility::getstruct(self.target,"targetname");
	self waittill("trigger",var_01);
	glassradiusdamage(var_00.origin,var_00.radius,100,100);
}

//Function Number: 23
labshouldignoreplayer(param_00)
{
	if(maps\mp\zombies\_util::is_true(level.incinerator_active))
	{
		var_01 = maps\mp\mp_zombie_lab_sq::stage4_get_players_in_incinerator();
		if(common_scripts\utility::array_contains(var_01,param_00))
		{
			return 1;
		}
	}

	return 0;
}