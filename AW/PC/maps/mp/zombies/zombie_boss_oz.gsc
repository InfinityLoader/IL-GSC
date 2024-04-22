/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\zombies\zombie_boss_oz.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 48
 * Decompile Time: 864 ms
 * Timestamp: 4/22/2024 2:14:56 AM
*******************************************************************/

//Function Number: 1
init()
{
	maps\mp\zombies\zombie_boss_oz_stage1::init();
	maps\mp\zombies\zombie_boss_oz_stage2::init();
	level.roundstartfunc["zombie_boss_oz"] = ::bossozroundstart;
	level.zombieroundstartupdate = ::roundstartupdate;
	level._effect["oz_arena_teleport_player"] = loadfx("vfx/unique/dlc_teleport_player");
	level.arenazonename = "arena";
	level.teleportname = "boss_player_teleport";
	if(!isdefined(level.ammodroneillegalzones))
	{
		level.ammodroneillegalzones = [];
	}

	level.ammodroneillegalzones[level.ammodroneillegalzones.size] = level.arenazonename;
	foreach(var_01 in level.hostcuremodels)
	{
		var_01.zone = maps\mp\zombies\_zombies_zone_manager::getlocationzone(var_01.origin + (0,0,10));
	}

	deactivatearenacurestations();
	initpillars();
	initroomcenter();
	initpower();
	maps\mp\killstreaks\_airdrop::addcratetype("airdrop_assault","ammo",25,::ammocratethink,&"ZOMBIE_H2O_AMMO_CRATE","ammo");
	maps\mp\killstreaks\_airdrop::addcratetype("airdrop_assault","ozMoney",25,::moneycratethink,&"ZOMBIES_CRATE_MONEY","ozMoney");
	level._effect["crate_teleport"] = loadfx("vfx/unique/dlc_teleport_soldier_good");
}

//Function Number: 2
initpillars()
{
	level.bossozpillars = common_scripts\utility::getstructarray("oz_room_pillar","targetname");
	foreach(var_01 in level.bossozpillars)
	{
		var_01.destroyed = 0;
		var_01.visuals = [];
		var_02 = getentarray(var_01.target,"targetname");
		foreach(var_04 in var_02)
		{
			if(var_04.classname == "script_brushmodel")
			{
				if(var_04.script_noteworthy == "compile_time_path_blocker")
				{
					var_04 delete();
				}
				else if(var_04.script_noteworthy == "visuals")
				{
					var_04 connectpaths();
					var_04 setaisightlinevisible(1);
					var_04 common_scripts\utility::hide_notsolid();
					var_04 common_scripts\utility::show_solid();
					var_01.sightlineent = var_04;
					var_01.visuals[var_01.visuals.size] = var_04;
				}
				else if(var_04.script_noteworthy == "pillar_path_blocker_top")
				{
					var_04 notsolid();
					var_04 connectpaths();
					var_01.pathblockertop = var_04;
				}
				else if(var_04.script_noteworthy == "pillar_path_blocker_ground")
				{
					var_04 solid();
					var_04 disconnectpaths();
					var_01.pathblockerbottom = var_04;
				}

				continue;
			}

			if(var_04.classname == "script_model")
			{
				var_04 common_scripts\utility::show_solid();
				var_01.visuals[var_01.visuals.size] = var_04;
			}
		}
	}
}

//Function Number: 3
getrandomactivepillar()
{
	var_00 = common_scripts\utility::array_randomize(level.bossozpillars);
	foreach(var_02 in var_00)
	{
		if(!var_02.destroyed)
		{
			return var_02;
		}
	}
}

//Function Number: 4
destroypillar()
{
	self.pathblockertop solid();
	self.pathblockertop disconnectpaths();
	self.pathblockertop notsolid();
	self.pathblockerbottom connectpaths();
	self.pathblockerbottom notsolid();
	self.sightlineent setaisightlinevisible(0);
	foreach(var_01 in self.visuals)
	{
		var_01 common_scripts\utility::hide_notsolid();
		var_01 notsolid();
	}

	self.destroyed = 1;
}

//Function Number: 5
initroomcenter()
{
	level.bossozstage2roomcenter = (0,0,0);
	if(level.bossozpillars.size > 0)
	{
		foreach(var_01 in level.bossozpillars)
		{
			level.bossozstage2roomcenter = level.bossozstage2roomcenter + var_01.origin;
		}

		level.bossozstage2roomcenter = level.bossozstage2roomcenter / level.bossozpillars.size;
	}
}

//Function Number: 6
initpower()
{
	level.boss_power_switches = [];
	foreach(var_01 in level.power_switches)
	{
		var_02 = var_01.script_flag;
		if(isdefined(var_02) && issubstr(var_02,"boss_oz_power"))
		{
			var_01.nopoints = 1;
			level.boss_power_switches[level.boss_power_switches.size] = var_01;
		}
	}

	level thread curestationpower();
}

//Function Number: 7
isbosspreviewround(param_00)
{
	return param_00 == 6;
}

//Function Number: 8
roundstartupdate()
{
	level endon("game_ended");
	if(isbosspreviewround(level.wavecounter))
	{
		level.zombie_wave_running = 1;
		maps\mp\zombies\zombie_boss_oz_stage1::initozrooms();
		while(maps\mp\zombies\_util::is_true(level.zmbbossteleportdelay))
		{
			wait 0.05;
		}

		while(maps\mp\zombies\_util::is_true(level.waitingforteleportout))
		{
			wait 0.05;
		}

		level.zmbbosscountdowninprogress = 1;
		zmbaudioannouncerbossozplayvo("s0intro",1);
		level thread enablearenazone(1);
		teleportplayerstoarena();
		level thread hideshowkillstreakicons();
		level.zmbbosscountdowninprogress = undefined;
		maps\mp\zombies\zombie_boss_oz_stage1::spawnoz();
		var_00 = common_scripts\utility::random(level.bossozrooms);
		maps\mp\zombies\zombie_boss_oz_stage1::moveoztoroom(var_00);
		wait(1.5);
		zmbaudioplayervo("s0_react",1);
		zmbaudiochangeozvotoplayonent(level.bossozstage1);
		zmbaudiobossozplayvo("s0fun",1);
		wait(1);
		zmbaudiobossozplayvo("s0intro2",1);
		var_01 = level.stage1traps["aerial_lasers"];
		[[ var_01.runtrapfunc ]](var_01,10,60,1);
		var_01 = level.stage1traps["electricity"];
		[[ var_01.runtrapfunc ]](var_01,10,60,1);
		wait(1);
		level thread zmbaudioplayervo("s0_traps",0);
		wait(5);
		level notify("stop_all_boss_traps");
		level notify("teleport_players_back");
		level notify("disable_arena_zone");
		level waittill("teleport_from_arena_complete");
		wait(1.5);
		zmbaudioangplayvo("stage0",1);
		zmbaudioannouncerbossozplayvo("s0ang",1);
		wait(0.5);
		zmbaudioplayervo("s0_back",1);
		wait 0.05;
		zmbaudioresetozvoent();
		level.bossozstage1 delete();
		level.zombie_wave_running = 0;
	}
}

//Function Number: 9
bossozroundstart()
{
	while(maps\mp\zombies\_util::is_true(level.zmbbossteleportdelay))
	{
		wait 0.05;
	}

	while(maps\mp\zombies\_util::is_true(level.waitingforteleportout))
	{
		wait 0.05;
	}

	maps\mp\zombies\_util::waittillzombiegameunpaused();
	level.zmbbosscountdowninprogress = 1;
	if(level.bossozstage == 1)
	{
		zmbaudioannouncerbossozplayvo("tele",1);
		wait(0.5);
		zmbaudioannouncerbossozplayvo("count",1);
	}
	else if(level.bossozstage == 2)
	{
		zmbaudioannouncerbossozplayvo("count2",1);
	}

	teleportplayerstoarena();
	maps\mp\zombies\_util::disablepickups();
	level thread hideshowkillstreakicons();
	level.zmbbosscountdowninprogress = undefined;
	if(level.bossozstage == 1)
	{
		level.roundtype = "zombie_boss_oz_stage1";
	}
	else if(level.bossozstage == 2)
	{
		level.roundtype = "zombie_boss_oz_stage2";
	}

	level.zone_data.spawn_points_update_requested = 1;
	if(isdefined(level.roundstartfunc[level.roundtype]))
	{
		[[ level.roundstartfunc[level.roundtype] ]]();
	}

	level thread enablearenazone();
	level thread handlebossroundend();
	level thread handleammo();
}

//Function Number: 10
hideshowkillstreakicons()
{
	level.disablecarepackagedrops = 1;
	wait 0.05;
	var_00 = getentarray("care_package","targetname");
	foreach(var_02 in var_00)
	{
		var_02 thread carepackagehidehudicon();
	}

	var_04 = getentarray("goliath_pod_model","targetname");
	foreach(var_06 in var_04)
	{
		var_06 thread carepackagehidehudicon();
	}

	level waittill("teleport_players_back");
	level.disablecarepackagedrops = undefined;
}

//Function Number: 11
carepackagehidehudicon()
{
	level endon("teleport_players_back");
	self endon("death");
	while(!isdefined(self.entityheadicons) || self.entityheadicons.size == 0)
	{
		wait 0.05;
	}

	foreach(var_01 in self.entityheadicons)
	{
		var_01.alpha = 0;
	}

	thread carepackagedelayshowhudicon();
}

//Function Number: 12
carepackagedelayshowhudicon()
{
	self endon("death");
	level waittill("teleport_players_back");
	if(isdefined(self.entityheadicons))
	{
		foreach(var_01 in self.entityheadicons)
		{
			var_01.alpha = 1;
		}
	}
}

//Function Number: 13
startinfinitezombiespawning()
{
	var_00 = 1;
	if(var_00)
	{
		level childthread maps\mp\zombies\zombies_spawn_manager::spawnzombies(999999);
	}
}

//Function Number: 14
teleportplayerstoarena()
{
	var_00 = common_scripts\utility::getstructarray(level.teleportname,"targetname");
	for(var_01 = 0;var_01 < level.players.size;var_01++)
	{
		level.players[var_01] thread teleporttostructandbackatend(var_00[var_01]);
	}

	level waittill("teleport_to_arena_complete");
	thread ensureeveryplayerteleports();
}

//Function Number: 15
ensureeveryplayerteleports()
{
	level endon("game_ended");
	var_00 = common_scripts\utility::getstructarray(level.teleportname,"targetname");
	var_01 = 1;
	var_02 = undefined;
	while(var_01)
	{
		for(var_03 = 0;var_03 < level.players.size;var_03++)
		{
			if(isalive(level.players[var_03]) && !maps\mp\zombies\_util::is_true(level.players[var_03].startedbossteleport))
			{
				level.players[var_03] thread teleporttostructandbackatend(var_00[var_03]);
			}
		}

		if(maps\mp\zombies\_util::is_true(level.zombie_wave_running) && !isdefined(var_02))
		{
			var_02 = gettime() + 2000;
		}

		if(isdefined(var_02) && gettime() > var_02)
		{
			var_01 = 0;
		}

		wait(1);
	}
}

//Function Number: 16
enablearenazone(param_00)
{
	level endon("game_ended");
	level.zone_data.zones[level.arenazonename].is_enabled = 1;
	enablecurestationcost(0);
	activateonlycurestationinzone(level.arenazonename);
	level thread runarenapowerswitches();
	if(isdefined(level.bossozstage) && level.bossozstage == 1)
	{
		var_01 = level common_scripts\utility::waittill_any_return("activate_terminals","zombie_wave_interrupt");
		if(var_01 == "zombie_wave_interrupt")
		{
			return;
		}
	}

	if(!maps\mp\zombies\_util::is_true(param_00))
	{
		level childthread handlemagicbox();
	}

	level common_scripts\utility::waittill_any("zombie_wave_ended","zombie_wave_interrupt","disable_arena_zone");
	level.zone_data.zones[level.arenazonename].is_enabled = 0;
	deactivatearenacurestations();
	activatenonarenacurestations();
	enablecurestationcost(1);
}

//Function Number: 17
handlemagicbox()
{
	foreach(var_01 in level.magicboxlocations)
	{
		if(maps\mp\zombies\_wall_buys::isscriptedmagicbox(var_01))
		{
			var_01 thread maps\mp\zombies\_wall_buys::activatemagicboxeffects(var_01.modelent,var_01.light);
			level thread maps\mp\zombies\_wall_buys::watchmagicboxtrigger(var_01,0);
			var_01 sethintstring(maps\mp\zombies\_wall_buys::getmagicboxhintsting());
			var_01 setsecondaryhintstring(var_01 maps\mp\zombies\_wall_buys::getmagicboxhintstringcost());
			var_01 maps\mp\zombies\_util::settokencost(maps\mp\zombies\_util::creditstotokens(var_01.cost));
			var_01 maps\mp\zombies\_util::tokenhintstring(1);
			var_01.active = 1;
		}
	}

	level common_scripts\utility::waittill_any("zombie_boss_wave_ended","zombie_wave_interrupt");
	level.zone_data.zones[level.arenazonename].is_enabled = 0;
	foreach(var_01 in level.magicboxlocations)
	{
		if(maps\mp\zombies\_wall_buys::isscriptedmagicbox(var_01))
		{
			var_01 thread maps\mp\zombies\_wall_buys::deactivatemagicboxeffects(var_01.modelent,var_01.light);
			var_01 maps\mp\zombies\_wall_buys::deactivatemagicbox();
			var_01 sethintstring(maps\mp\zombies\_wall_buys::getmagicboxhintsting(1));
			var_01 setsecondaryhintstring(var_01 maps\mp\zombies\_wall_buys::getmagicboxhintstringcost(1));
			var_01 maps\mp\zombies\_util::tokenhintstring(0);
			var_01.active = 0;
		}
	}
}

//Function Number: 18
curestationpower()
{
	level endon("game_ended");
	if(!common_scripts\utility::flag_exist("boss_cure_station_power"))
	{
		return;
	}

	for(;;)
	{
		common_scripts\utility::flag_clear("boss_cure_station_power");
		var_00 = 0;
		while(!var_00)
		{
			var_00 = 1;
			foreach(var_02 in level.boss_power_switches)
			{
				if(!common_scripts\utility::flag(var_02.script_flag))
				{
					var_00 = 0;
					common_scripts\utility::flag_wait(var_02.script_flag);
					break;
				}
			}
		}

		common_scripts\utility::flag_set("boss_cure_station_power");
		level waittill("arena_power_switches_off");
		wait 0.05;
	}
}

//Function Number: 19
runarenapowerswitches()
{
	level endon("zombie_wave_ended");
	level endon("zombie_wave_interrupt");
	level endon("disable_arena_zone");
	if(!isdefined(level.bossozstage))
	{
		arenapowerswitcheson();
		return;
	}

	if(level.bossozstage == 1)
	{
		arenapowerswitcheson();
		return;
	}

	if(level.bossozstage == 2)
	{
		for(;;)
		{
			arenapowerswitchesoff();
			foreach(var_01 in level.hostcuremodels)
			{
				if(var_01 curestationisinarenazone())
				{
					var_01.terminal childthread curestationusewatch();
				}
			}

			level waittill("cureStationUsed");
		}

		return;
	}
}

//Function Number: 20
curestationusewatch()
{
	self notify("endCureStationUseWatch");
	self endon("endCureStationUseWatch");
	for(;;)
	{
		self waittill("trigger");
		if(common_scripts\utility::flag("boss_cure_station_power"))
		{
			level notify("cureStationUsed");
		}
	}
}

//Function Number: 21
arenapowerswitcheson()
{
	foreach(var_01 in level.boss_power_switches)
	{
		var_01.trigger notify("trigger");
	}
}

//Function Number: 22
arenapowerswitchesoff()
{
	foreach(var_01 in level.boss_power_switches)
	{
		var_01.trigger notify("trigger_off");
	}

	level notify("arena_power_switches_off");
}

//Function Number: 23
activateonlycurestationinzone(param_00)
{
	foreach(var_02 in level.hostcuremodels)
	{
		var_02.terminal.terminaldeactivated = var_02.zone != param_00;
	}
}

//Function Number: 24
deactivatearenacurestations()
{
	foreach(var_01 in level.hostcuremodels)
	{
		if(var_01 curestationisinarenazone())
		{
			var_01.terminal.terminaldeactivated = 1;
		}
	}
}

//Function Number: 25
activatenonarenacurestations()
{
	foreach(var_01 in level.hostcuremodels)
	{
		if(!var_01 curestationisinarenazone())
		{
			var_01.terminal.terminaldeactivated = 0;
		}
	}
}

//Function Number: 26
curestationisinarenazone()
{
	return self.zone == level.arenazonename;
}

//Function Number: 27
enablecurestationcost(param_00)
{
	if(param_00)
	{
		level.terminalitems["host_cure"].cost = 250;
	}
	else
	{
		level.terminalitems["host_cure"].cost = 0;
	}

	level notify("terminal_reenabled");
}

//Function Number: 28
teleporttostructandbackatend(param_00)
{
	level endon("game_ended");
	self endon("disconnect");
	self.startedbossteleport = 1;
	while(maps\mp\zombies\_util::isplayerteleporting(self))
	{
		wait(0.05);
	}

	while(maps\mp\zombies\_util::is_true(self.enteringgoliath))
	{
		wait 0.05;
	}

	self notify("stop_useHoldThinkLoop");
	while(self islinked())
	{
		wait 0.05;
	}

	self cancelmantle();
	self.prebossorigin = self.lastgroundposition;
	self.disabletombstonedropinarea = 1;
	maps\mp\zombies\_teleport::teleport_players_through_chute([self],0);
	thread maps\mp\zombies\_teleport::reset_teleport_flag_after_time([self],0.75);
	var_01 = playerphysicstrace(param_00.origin,param_00.origin - (0,0,300),self) - (0,0,0.9);
	self setorigin(var_01,1);
	if(isdefined(param_00.angles))
	{
		self.prebossangles = self getplayerangles();
		self setplayerangles(param_00.angles);
	}

	playfxontagforclients(common_scripts\utility::getfx("oz_arena_teleport_player"),self,"tag_origin",self);
	level notify("teleport_to_arena_complete");
	level waittill("teleport_players_back");
	self notify("stop_useHoldThinkLoop");
	self cancelmantle();
	maps\mp\zombies\_teleport::teleport_players_through_chute([self],0);
	thread maps\mp\zombies\_teleport::reset_teleport_flag_after_time([self],0.75);
	var_02 = playerphysicstrace(self.prebossorigin,self.prebossorigin + (0,0,1));
	if(distancesquared(var_02,self.prebossorigin) < 0.001)
	{
		var_02 = playerphysicstrace(self.prebossorigin + (0,0,10),self.prebossorigin);
		self.prebossorigin = var_02;
	}

	self setorigin(self.prebossorigin,1);
	if(isdefined(self.prebossangles))
	{
		self setplayerangles(self.prebossangles);
	}

	self.disabletombstonedropinarea = undefined;
	playfxontagforclients(common_scripts\utility::getfx("oz_arena_teleport_player"),self,"tag_origin",self);
	level notify("teleport_from_arena_complete");
	level.waitingforteleportout = undefined;
	self.startedbossteleport = undefined;
}

//Function Number: 29
handlebossroundend()
{
	level endon("game_ended");
	level childthread handlepostroundcure();
	level common_scripts\utility::waittill_any("zombie_boss_wave_ended","zombie_wave_interrupt");
	level thread givereward();
	level.waitingforteleportout = 1;
	wait(10);
	zmbaudioangplayvo("stage1_end3",1);
	level notify("teleport_players_back");
	level notify("zombie_wave_ended");
	maps\mp\zombies\_util::enablepickups();
	if(level.bossozstage == 1)
	{
		level waittill("teleport_from_arena_complete");
		wait(1);
		zmbaudioplayervo("s1win",1);
		wait(0.5);
		zmbaudioannouncerbossozplayvo("s1win",1);
	}
}

//Function Number: 30
handlepostroundcure()
{
	level common_scripts\utility::waittill_any("zombie_boss_wave_ended","zombie_wave_interrupt","boss_oz_killed");
	foreach(var_01 in level.players)
	{
		if(maps\mp\zombies\_util::isplayerinfected(var_01))
		{
			var_01 notify("cured",0);
		}
	}
}

//Function Number: 31
givereward()
{
	var_00 = common_scripts\utility::getstructarray("ozCarepackagePosition","targetname");
	foreach(var_02 in var_00)
	{
		var_02.in_use = 0;
	}

	foreach(var_05 in level.players)
	{
		thread giverewardtoplayer(var_05);
	}

	wait(0.75);
	level.disablescoring = 0;
}

//Function Number: 32
giverewardtoplayer(param_00)
{
	level endon("teleport_players_back");
	for(;;)
	{
		var_01 = param_00 getmoneyposition();
		var_01.in_use = 1;
		var_02 = param_00 maps\mp\killstreaks\_airdrop::createairdropcrate(param_00,"airdrop_assault","ozMoney",var_01.origin,undefined,0,1);
		playfx(common_scripts\utility::getfx("crate_teleport"),var_01.origin,(1,0,0),(0,0,1));
		var_02 thread [[ level.cratetypes["airdrop_assault"]["ozMoney"].func ]]("airdrop_assault");
		var_02 disconnectpaths();
		var_02 thread deletecrateonteleport();
		while(isdefined(var_02))
		{
			wait 0.05;
		}

		var_01.in_use = 0;
		wait 0.05;
	}
}

//Function Number: 33
getmoneyposition()
{
	var_00 = common_scripts\utility::getstructarray("ozCarepackagePosition","targetname");
	var_01 = [];
	foreach(var_03 in var_00)
	{
		if(!var_03.in_use)
		{
			var_01[var_01.size] = var_03;
		}
	}

	var_05 = common_scripts\utility::get_array_of_closest(self.origin,var_01);
	var_06 = int(var_05.size * 0.75);
	var_07 = randomintrange(1,var_06);
	return var_05[var_07];
}

//Function Number: 34
deletecrateonteleport()
{
	self endon("death");
	level waittill("teleport_players_back");
	maps\mp\killstreaks\_airdrop::deletecrate(0);
}

//Function Number: 35
handleammo()
{
	level endon("game_ended");
	level.disablescoring = 1;
	level thread handleammodrops();
	level common_scripts\utility::waittill_any("zombie_boss_wave_ended","zombie_wave_interrupt");
	if(isdefined(level.ammocrate))
	{
		level.ammocrate maps\mp\killstreaks\_airdrop::deletecrate(1);
	}
}

//Function Number: 36
handleammodrops()
{
	level endon("game_ended");
	level endon("zombie_wave_interrupt");
	level endon("zombie_boss_wave_ended");
	level.noammodroptriggers = [];
	var_00 = common_scripts\utility::getstructarray("ozCarepackagePosition","targetname");
	for(;;)
	{
		wait(12);
		var_01 = common_scripts\utility::random(level.players);
		var_02 = findammocratedrop(var_00);
		level.ammocrate = var_01 maps\mp\killstreaks\_airdrop::createairdropcrate(var_01,"airdrop_assault","ammo",var_02.origin,undefined,0,1);
		playfx(common_scripts\utility::getfx("crate_teleport"),var_02.origin,(1,0,0),(0,0,1));
		level.ammocrate thread [[ level.cratetypes["airdrop_assault"]["ammo"].func ]]("airdrop_assault");
		level.ammocrate disconnectpaths();
		while(isdefined(level.ammocrate))
		{
			wait(0.05);
		}
	}
}

//Function Number: 37
findammocratedrop(param_00)
{
	var_01 = [];
	foreach(var_03 in param_00)
	{
		var_04 = 1;
		foreach(var_06 in level.noammodroptriggers)
		{
			if(ispointinvolume(var_03.origin + (0,0,35),var_06))
			{
				var_04 = 0;
				break;
			}
		}

		if(var_04)
		{
			var_01[var_01.size] = var_03;
		}
	}

	return common_scripts\utility::random(var_01);
}

//Function Number: 38
moneycratethink(param_00)
{
	self endon("death");
	self.owner = undefined;
	var_01 = undefined;
	if(isdefined(game["strings"][param_00 + self.cratetype + "_hint"]))
	{
		var_01 = game["strings"][param_00 + self.cratetype + "_hint"];
	}
	else
	{
		var_01 = &"PLATFORM_GET_KILLSTREAK";
	}

	maps\mp\killstreaks\_airdrop::cratesetuphintstrings(var_01);
	maps\mp\killstreaks\_airdrop::cratesetupforuse("all","hud_carepkg_world_credits");
	thread maps\mp\zombies\killstreaks\_zombie_killstreaks::crateothercapturethink(undefined,1,500);
	for(;;)
	{
		self waittill("captured",var_02);
		var_02 playlocalsound("zmb_ss_credits_acquire");
		var_03 = 250 + randomintrange(0,20) * 50;
		var_02 maps\mp\gametypes\zombies::givepointsforevent("crate",var_03,1);
		maps\mp\killstreaks\_airdrop::deletecrate(1);
	}
}

//Function Number: 39
ammocratethink(param_00)
{
	self endon("death");
	self.owner = undefined;
	var_01 = &"ZOMBIE_H2O_AMMO_CRATE";
	maps\mp\killstreaks\_airdrop::cratesetuphintstrings(var_01);
	maps\mp\killstreaks\_airdrop::cratesetupforuse("all","hud_drop_sm_maxammo");
	thread maps\mp\zombies\killstreaks\_zombie_killstreaks::crateothercapturethink(undefined,1);
	for(;;)
	{
		self waittill("captured",var_02);
		var_02 playlocalsound("zmb_pickup_general");
		var_02 maps\mp\gametypes\zombies::refillammozombies(var_02,1);
		var_02 maps\mp\gametypes\zombies::playersetem1maxammo();
		maps\mp\killstreaks\_airdrop::deletecrate(1);
	}
}

//Function Number: 40
zmbaudiochangeozvotoplayonent(param_00)
{
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxinitspeaker("announcer_oz","janitor_",param_00,0);
}

//Function Number: 41
zmbaudioresetozvoent()
{
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxinitspeaker("announcer_oz","janitor_",level.announceroz,0);
}

//Function Number: 42
zmbaudiobossozplayvo(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = maps\mp\zombies\_zombies_audio_announcer::getannouncers("oz")[0];
	var_06 endon("death");
	if(isdefined(param_03))
	{
		wait(param_03);
	}

	if(!isdefined(param_05))
	{
		param_05 = 0;
	}

	if(!param_05)
	{
		waittilldonespeaking();
	}

	var_07 = var_06 maps\mp\zombies\_zombies_audio::create_and_play_dialog("machine_all_players","dlc4_" + param_00,undefined,param_02,param_04);
	if(var_07 && param_01)
	{
		var_06 common_scripts\utility::waittill_notify_or_timeout("done_speaking",10);
	}

	return var_07;
}

//Function Number: 43
zmbaudioannouncerbossozplayvo(param_00,param_01)
{
	waittilldonespeaking();
	var_02 = maps\mp\zombies\_zombies_audio_announcer::getannouncers("oz")[0];
	var_03 = var_02 maps\mp\zombies\_zombies_audio::create_and_play_dialog("global_priority","dlc4_" + param_00);
	if(var_03 && param_01)
	{
		maps\mp\zombies\_zombies_audio_announcer::waittillallannouncersdonespeaking();
	}
}

//Function Number: 44
zmbaudioangplayvo(param_00,param_01)
{
	waittilldonespeaking();
	var_02 = maps\mp\zombies\_zombies_audio_announcer::announcerglobaldialog("global_priority",param_00);
	if(var_02 && param_01)
	{
		maps\mp\zombies\_zombies_audio_announcer::waittillallannouncersdonespeaking();
	}
}

//Function Number: 45
anyplayersspeaking()
{
	foreach(var_01 in level.players)
	{
		if(maps\mp\zombies\_util::is_true(var_01.isspeaking))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 46
waittilldonespeaking()
{
	while(anyplayersspeaking() || maps\mp\zombies\_zombies_audio_announcer::isanyannouncerspeaking())
	{
		wait 0.05;
	}
}

//Function Number: 47
getrandomaliveplayer()
{
	var_00 = common_scripts\utility::array_randomize(level.players);
	foreach(var_02 in level.players)
	{
		if(isalive(var_02) && !maps\mp\zombies\_util::isplayerinlaststand(var_02))
		{
			return var_02;
		}
	}
}

//Function Number: 48
zmbaudioplayervo(param_00,param_01,param_02)
{
	waittilldonespeaking();
	if(!isdefined(param_02))
	{
		param_02 = getrandomaliveplayer();
	}

	var_03 = param_02 maps\mp\zombies\_zombies_audio::create_and_play_dialog("general","dlc4_" + param_00);
	if(var_03 && param_01)
	{
		waittilldonespeaking();
	}
}