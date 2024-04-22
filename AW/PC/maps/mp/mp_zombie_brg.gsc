/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\mp_zombie_brg.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 138
 * Decompile Time: 2165 ms
 * Timestamp: 4/22/2024 2:19:12 AM
*******************************************************************/

//Function Number: 1
main()
{
	maps\mp\mp_zombie_brg_precache::main();
	maps\createart\mp_zombie_brg_art::main();
	maps\mp\mp_zombie_brg_fx::main();
	level.zmbaudioattractorwait = 8;
	level.numkitingconversations = 0;
	maps\mp\_load::main();
	maps\mp\mp_zombie_brg_lighting::main();
	maps\mp\mp_zombie_brg_aud::main();
	maps\mp\_compass::setupminimap("compass_map_mp_zombie_brg");
	game["attackers"] = "allies";
	game["defenders"] = "axis";
	level.zombiehostinit = ::maps\mp\zombies\zombie_host::init;
	level.zombiedoginit = ::maps\mp\zombies\zombie_dog::init;
	level.dlcleaderboardnumber = 2;
	level.allow_swimming = 0;
	level.disable_water_weapon_swap = 1;
	level.laststandinwaterfunc = ::laststandinwater;
	level thread maps\mp\_water::init();
	thread disablepronevolumecheck();
	level.enabledzonepickupdrop = 1;
	level.zombies_using_civilians = 1;
	level.civ_extract = spawnstruct();
	level.civrounds = 0;
	level.firstcivilianround = 6;
	level.onstartgametypelevelfunc = ::onzombieburgertownstartgame;
	maps\mp\zombies\_zombies_rewards::init();
	precacheburgertown();
	level.zombielevelinit = ::initburgertown;
	level.zombieroundstartupdate = ::roundstartupdate;
	level.calculateroundtypeoverridefunc = ::calculateroundtype;
	level.specialmutatorstartingroundoverridefunc = ::getspecialmutatorstartinground;
	level.spawnzombiekilledfxfunc = ::spawnzombiekilledfx;
	level.noflashemzfunc = ::noflashemzhitfx;
	level.noemzflashzones = ["sewermain_vol","sewertrans_vol","sewerpit_vol","sewertunnel_vol","sewerexit_vol","sewercave_vol"];
	level.mutatortablesetupfunc = ::buildmutatortable;
	level.shouldspecialmutatorapplyfunc = ::shouldapplyspecialmutator;
	level.zombieinfectedvisionset = "mp_zombie_lab_infected";
	level.zombieinfectedlightset = "mp_zombie_lab_infected";
	level.allowzombierecycle = 1;
	level.wavecycleoverride = 6;
	level.burgertownspecialroundcounter = 0;
	thread maps\mp\zombies\_zombies_audio_dlc2::initdlc2audio();
	level.usezoneconnectiontombstonescoring = 1;
	thread initmutators();
	thread initzones();
	thread initextractions();
	thread initcharactermodels();
	thread upcomingcivilianroundmonitor();
	thread inittoxiczones();
	thread sewerscurestationdisablespawning();
	initweapons();
	thread initrollupdoors();
	if(level.nextgen)
	{
		thread spinningpitbullwheel();
	}

	thread maps\mp\mp_zombie_brg_sq::init_sidequest();
	thread warbirdintro();
	level.spawnanimationnotetrackhandlerassigner = ::spawnanimationnotetrackhandlerassigner;
	level.zombiespawnfxcount = 0;
	precacheheadicon("hud_waypoint_survivor");
	thread laddertriggersetup();
	thread exploittrigger();
	thread enablespecialweaponlevelbox();
	thread flyoverbink();
	thread updateburgertowndoorcosts();
	thread updateburgertowntrapcosts();
	if(level.currentgen)
	{
		thread setstaticscriptmodels();
	}

	if(level.nextgen)
	{
		thread spawnpatchclipfixes();
		thread windowexploitledgelogic();
		thread shoveplayer();
	}

	if(level.currentgen)
	{
		var_00 = getentarray("cg_window_ledge","targetname");
		foreach(var_02 in var_00)
		{
			var_02 thread windowexploitledgelogicthink();
		}
	}

	thread fixstuckzombie01();
	thread destroypatioglass();
}

//Function Number: 2
fixstuckzombie01()
{
	var_00 = getnodesinradius((1800,-1526,240),10,0);
	disconnectnodepair(var_00[0],getnode(var_00[0].target,"targetname"));
}

//Function Number: 3
laststandinwater()
{
	self endon("death");
	self endon("disconnect");
	self endon("revive");
	level endon("game_ended");
	for(;;)
	{
		if(isdefined(self.inwater) && self.inwater == 1 && isdefined(self.isshocked) && self.isshocked == 1)
		{
			self stopshellshock();
			self.isshocked = 0;
		}

		wait(0.05);
	}
}

//Function Number: 4
laddertriggersetup()
{
	var_00 = getentarray("ladder_check_volume","targetname");
	foreach(var_02 in var_00)
	{
		var_02 thread laddermonitor();
	}
}

//Function Number: 5
laddermonitor()
{
	level endon("game_ended");
	for(;;)
	{
		self waittill("trigger",var_00);
		if(isplayer(var_00))
		{
			if(isdefined(var_00.laddercheck))
			{
				continue;
			}
			else if(var_00 isonladder())
			{
				var_00.laddercheck = 1;
				ladderdisablethink(var_00);
			}
		}
	}
}

//Function Number: 6
ladderdisablethink(param_00)
{
	level endon("game_ended");
	var_01 = self;
	var_02 = gettime() + 5000;
	while(gettime() < var_02)
	{
		wait(0.2);
		if(!param_00 isonladder())
		{
			param_00.laddercheck = undefined;
			return;
		}

		var_03 = maps\mp\agents\_agent_utility::getactiveagentsoftype("all");
		var_04 = 1;
		foreach(var_06 in var_03)
		{
			if(var_06 istouching(var_01) && param_00 isonladder())
			{
				var_04 = 0;
				break;
			}
		}

		if(var_04 == 1)
		{
			param_00 allowladder(1);
			param_00.laddercheck = undefined;
			return;
		}
	}

	param_00 allowladder(0);
	param_00 thread ladderenablethink();
}

//Function Number: 7
ladderenablethink()
{
	level endon("game_ended");
	wait(10);
	self allowladder(1);
	self.laddercheck = undefined;
}

//Function Number: 8
disablepronevolumecheck()
{
	level endon("game_ended");
	var_00 = getentarray("sewers_water_no_prone","targetname");
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

//Function Number: 9
disableprone(param_00)
{
	self notify("noprone");
	self endon("noprone");
	self endon("disconnect");
	while(self istouching(param_00))
	{
		self allowprone(0);
		wait(0.5);
	}

	self allowprone(1);
}

//Function Number: 10
setstaticscriptmodels()
{
	var_00 = getentarray("static_entity","targetname");
	foreach(var_02 in var_00)
	{
		var_02 setstatic();
	}
}

//Function Number: 11
updateburgertowndoorcosts()
{
	var_00 = "mp/dlc2CostTable.csv";
	var_01 = 0;
	var_02 = 1;
	var_03 = common_scripts\utility::getstructarray("door","targetname");
	wait(5);
	foreach(var_05 in var_03)
	{
		if(!isdefined(var_05.script_flag))
		{
			continue;
		}

		var_05.cost = int(tablelookup(var_00,var_01,var_05.script_flag,var_02));
		if(var_05 thread maps\mp\zombies\_doors::door_requires_power())
		{
			continue;
		}

		foreach(var_07 in var_05.triggers)
		{
			var_07 setsecondaryhintstring(maps\mp\zombies\_util::getcoststring(var_05.cost));
		}
	}
}

//Function Number: 12
updateburgertowntrapcosts()
{
	var_00 = "mp/dlc2CostTable.csv";
	var_01 = 0;
	var_02 = 1;
	wait(5);
	foreach(var_04 in level.traps)
	{
		if(!isdefined(var_04.script_noteworthy))
		{
			continue;
		}

		var_04.cost = int(tablelookup(var_00,var_01,var_04.script_noteworthy,var_02));
	}
}

//Function Number: 13
initextractions()
{
	maps\mp\zombies\_civilians::registerextractioninitevent("warbird",::maps\mp\zombies\_extraction::warbirdextractioninit);
	maps\mp\zombies\_civilians::registerextractionescortevent("warbird",::maps\mp\zombies\_extraction::warbirdextractionescort);
	maps\mp\zombies\_civilians::registerextractionevent("warbird",::maps\mp\zombies\_extraction::warbirdextraction);
}

//Function Number: 14
warbirdintro()
{
	wait(2);
	var_00 = common_scripts\utility::getstructarray("warbird_intro","targetname");
	var_01 = common_scripts\utility::random(var_00);
	var_02 = spawnhelicopter(level.players[0],var_01.origin,var_01.angles,"warbird_player_mp","vehicle_xh9_warbird_low_cloaked_in_out_mp_cloak");
	var_02 vehicle_turnengineoff();
	var_02 scalevolume(0);
	var_02 playloopsound("veh_warbird_fly_over");
	var_02 scalevolume(1,5);
	wait(3);
	var_02 thread warbirdintroflightpath(var_01);
}

//Function Number: 15
warbirdintroflightpath(param_00)
{
	self endon("death");
	var_01 = param_00;
	for(;;)
	{
		var_01 = common_scripts\utility::getstruct(var_01.target,"targetname");
		maps\mp\zombies\_extraction::warbirdmovetoattackpoint(self,var_01,25);
		if(isdefined(var_01.script_noteworthy) && var_01.script_noteworthy == "warbird_exit")
		{
			self delete();
		}

		wait(0.05);
	}
}

//Function Number: 16
initmutators()
{
	maps\mp\zombies\_mutators::initexplodermutator();
	maps\mp\zombies\_mutators::initemzmutator();
	maps\mp\zombies\_mutators_spiked::initspikedmutator();
	maps\mp\zombies\_mutators_acid::initacidmutator();
	maps\mp\zombies\_mutators_armor::initarmormutator();
}

//Function Number: 17
buildmutatortable()
{
	for(;;)
	{
		level.special_mutators = [];
		var_00 = getburgertownrandommutators();
		var_01 = 1;
		var_02 = 1;
		level waittill("zombie_round_countdown_started");
		if(level.wavecounter >= 8)
		{
			var_02 = 2;
		}

		for(var_03 = 0;var_03 < var_02;var_03++)
		{
			var_04 = common_scripts\utility::random(var_00);
			var_00 = common_scripts\utility::array_remove(var_00,var_04);
			if(var_04 == "acid")
			{
				level.special_mutators[var_04] = [::shouldapplyacidmutator,var_01];
				continue;
			}

			level.special_mutators[var_04] = [::shouldapplymutator,var_01];
		}

		if(level.wavecounter >= 5)
		{
			if(level.wavecounter >= 12)
			{
				var_01 = 2;
			}
			else
			{
				var_01 = 1;
			}

			level.special_mutators["emz"] = [::shouldapplymutator,var_01];
		}

		level waittill("zombie_wave_ended");
	}
}

//Function Number: 18
getburgertownrandommutators()
{
	var_00 = [];
	if(level.wavecounter < 6)
	{
		var_00 = ["armor","acid","spiked"];
	}
	else if(level.wavecounter >= 6)
	{
		var_00 = ["armor","exploder","acid","spiked"];
	}
	else if(level.wavecounter >= 12)
	{
		var_00 = ["exploder","acid","spiked"];
	}

	return var_00;
}

//Function Number: 19
shouldapplyacidmutator(param_00)
{
	if(level.activeacidzombies >= level.maxacidzombies)
	{
		return 0;
	}

	return 1;
}

//Function Number: 20
shouldapplymutator(param_00)
{
	if(level.wavecounter < 3)
	{
		return 0;
	}

	if(level.special_mutators.size == 0)
	{
		return 0;
	}

	return 1;
}

//Function Number: 21
shouldapplyspecialmutator(param_00)
{
	if(self.agent_type == "zombie_dog" && level.wavecounter < 15)
	{
		return 0;
	}
	else if(self.agent_type == "zombie_dog" && level.wavecounter > 25)
	{
		return 1;
	}

	return undefined;
}

//Function Number: 22
precacheburgertown()
{
	maps\mp\zombies\_civilians::precachestrings();
}

//Function Number: 23
initburgertown()
{
	maps\mp\zombies\zombie_melee_goliath::init();
	maps\mp\zombies\zombie_murderbot::init();
	level.roundspawndelayfunc["normal"] = ::calculatenormalroundspawndelay;
	level.roundspawndelayfunc["civilian"] = ::calculatecivilianroundspawndelay;
	level.candroppickupsfunc["normal"] = ::burgertowncandroppickups;
	level.candroppickupsfunc["civilian"] = ::burgertowncancivilianrounddroppickups;
	level.nummaxenemiesthisroundfunc["civilian"] = ::civilianroundmaxnumenemies;
	level.spawnzombiesoverridefunc = ::maps\mp\zombies\_zombies_burgertown_spawning::spawnzombies;
	maps\mp\zombies\_zombies_burgertown_spawning::init();
	maps\mp\zombies\_civilians::init();
	level.assignzombiemeshoverridefunc = ::assignzombiemesh;
	common_scripts\utility::flag_init("no_more_burgertown_employees");
	level thread burgertownemployeemonitor();
	level.mutatorfunc["zombie_generic"] = ::applyburgertownzombiemutator;
}

//Function Number: 24
burgertownemployeemonitor()
{
	level endon("game_ended");
	common_scripts\utility::flag_wait("no_more_burgertown_employees");
	if(!common_scripts\utility::flag("sewer_to_burgertown"))
	{
		common_scripts\utility::flag_wait("sewer_to_burgertown");
	}

	var_00 = maps\mp\zombies\_util::agentclassget("zombie_generic");
	var_00.model_heads[var_00.model_heads.size] = ["zombies_head_cau_dlc_a","zombies_head_cau_dlc_b","zombies_head_cau_dlc_c","zombies_head_shg_dlc_b"];
	var_00.model_bodies[var_00.model_bodies.size] = ["zom_civ_brg_employee_torso_slice"];
	var_01["right_leg"] = ["zom_civ_ruban_male_r_leg_slice"];
	var_01["left_leg"] = ["zom_civ_ruban_male_l_leg_slice"];
	var_01["right_arm"] = ["zom_civ_brg_employee_r_arm_slice"];
	var_01["left_arm"] = ["zom_civ_brg_employee_l_arm_slice"];
	var_00.model_limbs[var_00.model_limbs.size] = var_01;
	level.exobodyparts["zom_civ_brg_employee_torso_slice"]["torso"] = "zom_marine_exo_torso_slice";
	level.exobodyparts["zom_civ_brg_employee_torso_slice"]["right_arm"] = "zom_marine_exo_r_arm_slice";
	level.exobodyparts["zom_civ_brg_employee_torso_slice"]["left_arm"] = "zom_marine_exo_l_arm_slice";
	level.exobodyparts["zom_civ_brg_employee_torso_slice"]["right_leg"] = "zom_marine_exo_r_leg_slice";
	level.exobodyparts["zom_civ_brg_employee_torso_slice"]["left_leg"] = "zom_marine_exo_l_leg_slice";
}

//Function Number: 25
assignzombiemesh()
{
	if(!isdefined(self.agent_type) || self.agent_type != "zombie_generic")
	{
		return 0;
	}

	if(common_scripts\utility::flag("sewer_to_burgertown") && shouldbeburgertownzombie())
	{
		var_00 = ["zombies_head_cau_dlc_a","zombies_head_cau_dlc_b","zombies_head_cau_dlc_c","zombies_head_shg_dlc_b"];
		self setmodel("zom_civ_brg_employee_torso_slice");
		var_01 = common_scripts\utility::random(var_00);
		self attach(var_01);
		thread burgertownemployeeattachhat();
		self attach("zom_civ_ruban_male_r_leg_slice");
		self attach("zom_civ_ruban_male_l_leg_slice");
		self attach("zom_civ_brg_employee_r_arm_slice");
		self attach("zom_civ_brg_employee_l_arm_slice");
		self.burgertownemployee = 1;
		level.burgertownzombiesthisround++;
		return 1;
	}

	return 0;
}

//Function Number: 26
burgertownemployeeattachhat()
{
	self attach("brg_hat_01","J_helmet");
}

//Function Number: 27
applyburgertownzombiemutator(param_00)
{
	if(!isdefined(param_00.burgertownemployee))
	{
		maps\mp\zombies\zombies_spawn_manager::applyzombiemutator(param_00);
	}
}

//Function Number: 28
shouldbeburgertownzombie()
{
	if(common_scripts\utility::flag("no_more_burgertown_employees"))
	{
		return 0;
	}

	var_00 = 6;
	var_01 = 3;
	var_02 = 6;
	if(level.wavecounter < var_02)
	{
		return 0;
	}

	var_03 = int(level.wavecounter - var_02 * 0.25);
	var_04 = max(var_01,var_00 - var_03);
	if(level.burgertownzombiesthisround >= var_04)
	{
		return 0;
	}

	var_05 = 0.25;
	return randomfloat(1) < var_05;
}

//Function Number: 29
civilianroundmaxnumenemies(param_00)
{
	return param_00 - 1;
}

//Function Number: 30
roundstartupdate()
{
	level.burgertownzombiesthisround = 0;
}

//Function Number: 31
calculateroundtype()
{
	if(!isdefined(level.nextcivilianround))
	{
		calculatenextcivilianround();
		calculatenextspecialround();
	}

	if(level.wavecounter < 12)
	{
		var_00 = getscriptedroundtype();
	}
	else
	{
		var_00 = calculatenextroundtype();
	}

	if(var_00 == "civilian")
	{
		level thread activatecivilianround();
	}
	else
	{
		level.spawnzombiesoverridefunc = ::maps\mp\zombies\_zombies_burgertown_spawning::spawnzombies;
	}

	return var_00;
}

//Function Number: 32
getscriptedroundtype()
{
	if(level.wavecounter == level.firstcivilianround)
	{
		return "civilian";
	}

	if(level.wavecounter == 8)
	{
		return "zombie_host";
	}

	if(level.wavecounter == 10)
	{
		return "zombie_melee_goliath";
	}

	return "normal";
}

//Function Number: 33
calculatenextroundtype()
{
	if(level.wavecounter == level.nextcivilianround)
	{
		calculatenextcivilianround();
		return "civilian";
	}

	if(level.wavecounter == level.nextspecialround)
	{
		calculatenextspecialround();
		return getspecialroundtype();
	}

	level.spawnzombiesoverridefunc = ::maps\mp\zombies\_zombies_burgertown_spawning::spawnzombies;
	return "normal";
}

//Function Number: 34
getspecialroundtype()
{
	var_00 = ["zombie_host","zombie_melee_goliath"];
	var_01 = common_scripts\utility::mod(level.burgertownspecialroundcounter,var_00.size);
	switch(var_01)
	{
		case 0:
			var_01 = "zombie_host";
			break;

		case 1:
			var_01 = "zombie_melee_goliath";
			break;

		default:
			var_01 = var_00[0];
			break;
	}

	level.burgertownspecialroundcounter++;
	return var_01;
}

//Function Number: 35
upcomingcivilianroundmonitor()
{
	level endon("game_ended");
	level waittill("upcoming_civilian_round");
}

//Function Number: 36
activatecivilianround()
{
	level endon("game_ended");
	level.civrounds++;
	updatecivilianextractionpoints();
	level thread maps\mp\zombies\_civilians::spawncivilian("zombie_civilian");
	level.shouldwaveendoverridefunc = ::shouldcivilianroundend;
	level.spawnzombiesoverridefunc = ::maps\mp\zombies\_zombies_burgertown_spawning::spawnzombiescivilianround;
	playsoundatpos((0,0,0),"zmb_civ_extract_rnd_start");
	level waittill("zombie_wave_ended");
	level.shouldwaveendoverridefunc = undefined;
}

//Function Number: 37
shouldcivilianroundend(param_00,param_01)
{
	if(level.numberofalivecivilians > 0 || isdefined(level.waitingforcivilianspawn))
	{
		return 0;
	}

	return param_00 >= param_01;
}

//Function Number: 38
calculatenextcivilianround()
{
	var_00 = 12;
	var_01 = 5;
	if(!isdefined(level.nextcivilianround))
	{
		level.nextcivilianround = var_00;
		return;
	}

	level.nextcivilianround = level.nextcivilianround + var_01;
}

//Function Number: 39
calculatenextextractionpointreset()
{
	level.resetextractionpointround = level.wavecounter + 20;
}

//Function Number: 40
calculatenextspecialround()
{
	var_00 = 2;
	var_01 = 3;
	level.nextspecialround = level.nextcivilianround + randomintrange(var_00,var_01);
}

//Function Number: 41
calculatenormalroundspawndelay(param_00,param_01)
{
	return maps\mp\zombies\zombies_spawn_manager::calculatespawndelay();
}

//Function Number: 42
calculatecivilianroundspawndelay(param_00,param_01)
{
	var_02 = 2;
	return maps\mp\zombies\zombies_spawn_manager::calculatespawndelay(var_02);
}

//Function Number: 43
getspecialmutatorstartinground()
{
	return 3;
}

//Function Number: 44
calculatenexttoxicgasround()
{
	var_00 = 11;
	if(!isdefined(level.nexttoxicgasround))
	{
		level.nexttoxicgasround = var_00;
		return;
	}

	level.nexttoxicgasround = level.nexttoxicgasround + randomintrange(3,5);
}

//Function Number: 45
initzones()
{
	maps\mp\zombies\_zombies_zone_manager::init();
	maps\mp\zombies\_zombies_zone_manager::initializezone("warehouse_office_vol",1);
	maps\mp\zombies\_zombies_zone_manager::initializezone("warehouse_atlas_vol",1);
	maps\mp\zombies\_zombies_zone_manager::initializezone("warehouse_gas_vol",1);
	maps\mp\zombies\_zombies_zone_manager::initializezone("gas_station_pit_vol");
	maps\mp\zombies\_zombies_zone_manager::initializezone("gas_station_bldg_vol");
	maps\mp\zombies\_zombies_zone_manager::initializezone("gas_station_pumps_vol");
	maps\mp\zombies\_zombies_zone_manager::initializezone("gas_station_awning_vol");
	maps\mp\zombies\_zombies_zone_manager::initializezone("atlas_north_vol");
	maps\mp\zombies\_zombies_zone_manager::initializezone("atlas_center_vol");
	maps\mp\zombies\_zombies_zone_manager::initializezone("atlas_south_vol");
	maps\mp\zombies\_zombies_zone_manager::initializezone("atlas_pit_vol");
	maps\mp\zombies\_zombies_zone_manager::initializezone("atlas_command_vol");
	maps\mp\zombies\_zombies_zone_manager::initializezone("atlas_surplus_vol");
	maps\mp\zombies\_zombies_zone_manager::initializezone("burgertown_trench_vol");
	maps\mp\zombies\_zombies_zone_manager::initializezone("burgertown_parking_vol");
	maps\mp\zombies\_zombies_zone_manager::initializezone("burgertown_roof_vol");
	maps\mp\zombies\_zombies_zone_manager::initializezone("burgertown_int_vol");
	maps\mp\zombies\_zombies_zone_manager::initializezone("burgertown_east_vol");
	maps\mp\zombies\_zombies_zone_manager::initializezone("burgertown_west_vol");
	maps\mp\zombies\_zombies_zone_manager::initializezone("sewermain_vol");
	maps\mp\zombies\_zombies_zone_manager::initializezone("sewertrans_vol");
	maps\mp\zombies\_zombies_zone_manager::initializezone("sewerpit_vol");
	maps\mp\zombies\_zombies_zone_manager::initializezone("sewertunnel_vol");
	maps\mp\zombies\_zombies_zone_manager::initializezone("sewerexit_vol");
	maps\mp\zombies\_zombies_zone_manager::initializezone("sewercave_vol");
	maps\mp\zombies\_zombies_zone_manager::addadjacentzone("warehouse_gas_vol","gas_station_pumps_vol","warehouse_to_gas_station");
	maps\mp\zombies\_zombies_zone_manager::addadjacentzone("warehouse_atlas_vol","atlas_center_vol","warehouse_to_atlas");
	maps\mp\zombies\_zombies_zone_manager::addadjacentzone("gas_station_pit_vol","sewertrans_vol","gas_station_to_sewer");
	maps\mp\zombies\_zombies_zone_manager::addadjacentzone("atlas_pit_vol","sewermain_vol","atlas_to_sewer");
	maps\mp\zombies\_zombies_zone_manager::addadjacentzone("sewertrans_vol","sewertunnel_vol","sewertrans_to_sewertunnel",1);
	maps\mp\zombies\_zombies_zone_manager::addadjacentzone("sewertunnel_vol","sewerexit_vol","sewertrans_to_sewertunnel");
	maps\mp\zombies\_zombies_zone_manager::addadjacentzone("sewermain_vol","sewercave_vol","sewermain_to_sewercave",1);
	maps\mp\zombies\_zombies_zone_manager::addadjacentzone("sewerexit_vol","burgertown_trench_vol","sewer_to_burgertown");
	maps\mp\zombies\_zombies_zone_manager::addadjacentzone("atlas_south_vol","atlas_command_vol","atlas_command",1);
	maps\mp\zombies\_zombies_zone_manager::addadjacentzone("atlas_pit_vol","atlas_command_vol","atlas_command",1);
	maps\mp\zombies\_zombies_zone_manager::addadjacentzone("warehouse_office_vol","warehouse_atlas_vol","warehouse_start");
	maps\mp\zombies\_zombies_zone_manager::addadjacentzone("warehouse_office_vol","warehouse_gas_vol","warehouse_start");
	maps\mp\zombies\_zombies_zone_manager::addadjacentzone("warehouse_atlas_vol","warehouse_gas_vol","warehouse_start");
	common_scripts\utility::flag_set("warehouse_start");
	maps\mp\zombies\_zombies_zone_manager::addadjacentzone("sewermain_vol","sewertrans_vol","any_zone_to_sewer");
	maps\mp\zombies\_zombies_zone_manager::addadjacentzone("sewermain_vol","sewerpit_vol","any_zone_to_sewer");
	maps\mp\zombies\_zombies_zone_manager::addadjacentzone("sewertrans_vol","sewerpit_vol","any_zone_to_sewer");
	maps\mp\zombies\_util::flag_link("atlas_to_sewer","any_zone_to_sewer");
	maps\mp\zombies\_util::flag_link("gas_station_to_sewer","any_zone_to_sewer");
	maps\mp\zombies\_zombies_zone_manager::addadjacentzone("gas_station_pumps_vol","gas_station_pit_vol","any_zone_to_gas_station");
	maps\mp\zombies\_zombies_zone_manager::addadjacentzone("gas_station_pumps_vol","gas_station_bldg_vol","any_zone_to_gas_station");
	maps\mp\zombies\_zombies_zone_manager::addadjacentzone("gas_station_pumps_vol","gas_station_awning_vol","any_zone_to_gas_station");
	maps\mp\zombies\_zombies_zone_manager::addadjacentzone("gas_station_pit_vol","gas_station_bldg_vol","any_zone_to_gas_station");
	maps\mp\zombies\_zombies_zone_manager::addadjacentzone("gas_station_pit_vol","gas_station_awning_vol","any_zone_to_gas_station");
	maps\mp\zombies\_zombies_zone_manager::addadjacentzone("gas_station_bldg_vol","gas_station_awning_vol","any_zone_to_gas_station");
	maps\mp\zombies\_util::flag_link("warehouse_to_gas_station","any_zone_to_gas_station");
	maps\mp\zombies\_util::flag_link("gas_station_to_sewer","any_zone_to_gas_station");
	maps\mp\zombies\_zombies_zone_manager::addadjacentzone("atlas_center_vol","atlas_north_vol","any_zone_to_atlas");
	maps\mp\zombies\_zombies_zone_manager::addadjacentzone("atlas_center_vol","atlas_south_vol","any_zone_to_atlas");
	maps\mp\zombies\_zombies_zone_manager::addadjacentzone("atlas_center_vol","atlas_pit_vol","any_zone_to_atlas");
	maps\mp\zombies\_zombies_zone_manager::addadjacentzone("atlas_center_vol","atlas_surplus_vol","any_zone_to_atlas");
	maps\mp\zombies\_zombies_zone_manager::addadjacentzone("atlas_north_vol","atlas_surplus_vol","any_zone_to_atlas");
	maps\mp\zombies\_zombies_zone_manager::addadjacentzone("atlas_south_vol","atlas_pit_vol","any_zone_to_atlas");
	maps\mp\zombies\_util::flag_link("warehouse_to_atlas","any_zone_to_atlas");
	maps\mp\zombies\_util::flag_link("atlas_to_sewer","any_zone_to_atlas");
	maps\mp\zombies\_zombies_zone_manager::addadjacentzone("burgertown_roof_vol","burgertown_int_vol","any_zone_to_burgertown");
	maps\mp\zombies\_zombies_zone_manager::addadjacentzone("burgertown_roof_vol","burgertown_east_vol","any_zone_to_burgertown");
	maps\mp\zombies\_zombies_zone_manager::addadjacentzone("burgertown_roof_vol","burgertown_west_vol","any_zone_to_burgertown");
	maps\mp\zombies\_zombies_zone_manager::addadjacentzone("burgertown_roof_vol","burgertown_trench_vol","any_zone_to_burgertown");
	maps\mp\zombies\_zombies_zone_manager::addadjacentzone("burgertown_roof_vol","burgertown_parking_vol","any_zone_to_burgertown");
	maps\mp\zombies\_zombies_zone_manager::addadjacentzone("burgertown_parking_vol","burgertown_int_vol","any_zone_to_burgertown");
	maps\mp\zombies\_zombies_zone_manager::addadjacentzone("burgertown_parking_vol","burgertown_east_vol","any_zone_to_burgertown");
	maps\mp\zombies\_zombies_zone_manager::addadjacentzone("burgertown_parking_vol","burgertown_trench_vol","any_zone_to_burgertown");
	maps\mp\zombies\_zombies_zone_manager::addadjacentzone("burgertown_int_vol","burgertown_east_vol","any_zone_to_burgertown");
	maps\mp\zombies\_zombies_zone_manager::addadjacentzone("burgertown_int_vol","burgertown_west_vol","any_zone_to_burgertown");
	maps\mp\zombies\_zombies_zone_manager::addadjacentzone("burgertown_east_vol","burgertown_west_vol","any_zone_to_burgertown");
	maps\mp\zombies\_zombies_zone_manager::addadjacentzone("burgertown_west_vol","burgertown_trench_vol","any_zone_to_burgertown");
	maps\mp\zombies\_util::flag_link("sewer_to_burgertown","any_zone_to_burgertown");
	maps\mp\zombies\_zombies_zone_manager::activate(::maps\mp\zombies\_zombies_zone_manager::calculateweightedspawnpoint);
	level.doorbitmaskarray = [];
	level.doorbitmaskarray["warehouse_to_gas_station"] = 1;
	level.doorbitmaskarray["warehouse_to_atlas"] = 2;
	level.doorbitmaskarray["gas_station_interior"] = 4;
	level.doorbitmaskarray["gas_station_to_sewer"] = 8;
	level.doorbitmaskarray["atlas_command"] = 16;
	level.doorbitmaskarray["atlas_to_sewer"] = 32;
	level.doorbitmaskarray["sewertrans_to_sewertunnel"] = 64;
	level.doorbitmaskarray["sewermain_to_sewercave"] = 128;
	level.doorbitmaskarray["sewer_to_burgertown"] = 256;
	level.doorbitmaskarray["burgertown_storage"] = 512;
	thread maps\mp\zombies\_doors::registerhintstring(&"ZOMBIE_BRG_DOOR_TO_WAREHOUSE","warehouse_to_gas_station",0);
	thread maps\mp\zombies\_doors::registerhintstring(&"ZOMBIE_BRG_DOOR_TO_GAS_STATION","warehouse_to_gas_station",1);
	thread maps\mp\zombies\_doors::registerhintstring(&"ZOMBIE_BRG_DOOR_TO_ATLAS","warehouse_to_atlas",0);
	thread maps\mp\zombies\_doors::registerhintstring(&"ZOMBIE_BRG_DOOR_TO_WAREHOUSE","warehouse_to_atlas",1);
	thread maps\mp\zombies\_doors::registerhintstring(&"ZOMBIE_BRG_DOOR_TO_SEWER","gas_station_to_sewer",0);
	thread maps\mp\zombies\_doors::registerhintstring(&"ZOMBIE_BRG_DOOR_TO_GAS_STATION","gas_station_to_sewer",1);
	thread maps\mp\zombies\_doors::registerhintstring(&"ZOMBIE_BRG_DOOR_TO_SEWER_JUNC","atlas_to_sewer",0);
	thread maps\mp\zombies\_doors::registerhintstring(&"ZOMBIE_BRG_DOOR_TO_ATLAS","atlas_to_sewer",1);
	thread maps\mp\zombies\_doors::registerhintstring(&"ZOMBIE_BRG_DOOR_TO_SEWER","sewer_to_burgertown",0);
	thread maps\mp\zombies\_doors::registerhintstring(&"ZOMBIE_BRG_DOOR_TO_BURGERTOWN","sewer_to_burgertown",1);
	thread maps\mp\zombies\_doors::registerhintstring(&"ZOMBIE_BRG_DOOR_TO_SEWER_TUNNELS","sewertrans_to_sewertunnel",0);
	thread maps\mp\zombies\_doors::registerhintstring(&"ZOMBIE_BRG_DOOR_TO_SEWER_JUNC","sewertrans_to_sewertunnel",1);
	thread maps\mp\zombies\_doors::registerhintstring(&"ZOMBIE_BRG_DOOR_TO_SEWER_JUNC","sewermain_to_sewercave",0);
	thread maps\mp\zombies\_doors::registerhintstring(&"ZOMBIE_BRG_DOOR_TO_SEWER_CAVE","sewermain_to_sewercave",1);
	thread maps\mp\zombies\_doors::registerhintstring(&"ZOMBIE_BRG_DOOR_TO_BURGER_STORAGE","burgertown_storage",0);
	thread maps\mp\zombies\_doors::registerhintstring(&"ZOMBIE_BRG_DOOR_TO_BURGER_STORAGE","burgertown_storage",1);
	thread maps\mp\zombies\_doors::registerhintstring(&"ZOMBIE_BRG_DOOR_TO_GAS_INTERIOR","gas_station_interior",0);
	thread maps\mp\zombies\_doors::registerhintstring(&"ZOMBIE_BRG_DOOR_TO_GAS_INTERIOR","gas_station_interior",1);
	thread maps\mp\zombies\_doors::registerhintstring(&"ZOMBIE_BRG_DOOR_TO_ATLAS_COMMAND","atlas_command",0);
	thread maps\mp\zombies\_doors::registerhintstring(&"ZOMBIE_BRG_DOOR_TO_ATLAS_COMMAND","atlas_command",1);
	thread initgranulardoors("burgertown_storage",0.1);
	thread initgranulardoors("gas_station_interior",0.1);
	thread initgranulardoors("atlas_command",1);
	thread initgranulardoors("atlas_to_sewer",1,"warehouse_to_atlas");
	thread initgranulardoors("gas_station_to_sewer",1,"warehouse_to_gas_station");
}

//Function Number: 46
initcharactermodels()
{
	maps\mp\zombies\_util::initializecharactermodel("security","security_guard_body_dlc2","viewhands_security_guard",["security_guard_head_dlc2"]);
	maps\mp\zombies\_util::initializecharactermodel("exec","executive_body_dlc2","viewhands_executive",["executive_head_dlc2"]);
	maps\mp\zombies\_util::initializecharactermodel("it","lilith_body_dlc2","viewhands_lilith",["lilith_head_dlc2"]);
	maps\mp\zombies\_util::initializecharactermodel("janitor","janitor_body_dlc2","viewhands_janitor",["janitor_head_dlc2"]);
	maps\mp\zombies\_util::initializecharactermodel("security_exo","security_guard_body_exo_dlc2","viewhands_security_guard_exo",["security_guard_head_dlc2"]);
	maps\mp\zombies\_util::initializecharactermodel("exec_exo","executive_body_exo_dlc2","viewhands_executive_exo",["executive_head_dlc2"]);
	maps\mp\zombies\_util::initializecharactermodel("it_exo","lilith_body_exo_dlc2","viewhands_lilith_exo",["lilith_head_dlc2"]);
	maps\mp\zombies\_util::initializecharactermodel("janitor_exo","janitor_body_exo_dlc2","viewhands_janitor_exo",["janitor_head_dlc2"]);
	maps\mp\zombies\_util::initializecharactermodel("security_host","security_guard_body_dlc2",undefined,["security_guard_head_z"]);
	maps\mp\zombies\_util::initializecharactermodel("exec_host","executive_body_dlc2",undefined,["executive_head_z"]);
	maps\mp\zombies\_util::initializecharactermodel("it_host","lilith_body_dlc2",undefined,["lilith_head_z"]);
	maps\mp\zombies\_util::initializecharactermodel("janitor_host","janitor_body_dlc2",undefined,["janitor_head_z"]);
}

//Function Number: 47
initgranulardoors(param_00,param_01,param_02)
{
	var_03 = [];
	var_04 = common_scripts\utility::getstructarray("door","targetname");
	if(!isdefined(param_01))
	{
		param_01 = 0.5;
	}

	if(!common_scripts\utility::flag_exist(param_00))
	{
		common_scripts\utility::flag_init(param_00);
	}

	if(!isdefined(param_02))
	{
		param_02 = param_00;
	}
	else if(!common_scripts\utility::flag_exist(param_02))
	{
		common_scripts\utility::flag_init(param_02);
	}

	foreach(var_06 in var_04)
	{
		if(isdefined(var_06.script_flag) && var_06.script_flag == param_02)
		{
			var_03 = common_scripts\utility::add_to_array(var_03,var_06);
		}
	}

	common_scripts\utility::flag_wait(param_00);
	foreach(var_06 in var_03)
	{
		wait(randomfloat(param_01));
		var_06 notify("open");
	}
}

//Function Number: 48
initweapons()
{
	level.zombieweaponinitfunc = ::burgertownzombieweaponinit;
	level.zombieweapononplayerspawnedfunc = ::burgertownzombieweapononplayerspawned;
	level.initmagicboxweaponsfunc = ::burgertownzombieinitmagicboxweapons;
	level.playerammolowfunc = ::burgertownplayerammolow;
	level.activatemaxammofunc = ::burgertownactivatemaxammo;
	level.setweaponlevelfunc = ::burgertownsetweaponlevel;
	level.givemaxscriptedammofunc = ::burgertowngivemaxscriptedammo;
	level.givepointsforkillshotfunc = ::burgertowngivepointsforkillshot;
	level.playercanawardpointsfordamagefunc = ::burgertownplayercanawardpointsfordamage;
	level.onzombiekilledfunc = ::burgertownonzombiekilled;
	level.nearestnodetounreachabledronesearchheight = 128;
}

//Function Number: 49
burgertownzombieweaponinit()
{
	maps\mp\zombies\weapons\_zombie_microwave_gun::init();
}

//Function Number: 50
burgertownzombieweapononplayerspawned()
{
	thread maps\mp\zombies\weapons\_zombie_microwave_gun::onplayerspawn();
}

//Function Number: 51
burgertownzombieinitmagicboxweapons()
{
	maps\mp\zombies\_wall_buys::addmagicboxweapon("iw5_microwavezm","dlc_npc_microwave_gun_holo",&"ZOMBIES_MWG","none","none","none",1);
}

//Function Number: 52
burgertownplayerammolow(param_00)
{
	if(issubstr(param_00,"iw5_microwavezm_mp") && maps\mp\zombies\weapons\_zombie_microwave_gun::playerhasmicrowaveammoinfo())
	{
		var_01 = maps\mp\zombies\weapons\_zombie_microwave_gun::playergetmicrowaveammo();
		var_02 = maps\mp\zombies\weapons\_zombie_microwave_gun::getmicrowavemaxammo();
		return var_01 / var_02 < 0.05;
	}

	return undefined;
}

//Function Number: 53
burgertowncancivilianrounddroppickups(param_00)
{
	return 0;
}

//Function Number: 54
burgertowncandroppickups(param_00)
{
	if(isdefined(param_00) && isdefined(param_00.agent_type) && param_00.agent_type == "zombie_melee_goliath")
	{
		return 0;
	}

	return 1;
}

//Function Number: 55
burgertownactivatemaxammo()
{
	maps\mp\zombies\weapons\_zombie_microwave_gun::playersetmicrowavemaxammo();
}

//Function Number: 56
burgertownsetweaponlevel(param_00,param_01)
{
	if(issubstr(param_00,"iw5_microwavezm_mp"))
	{
		maps\mp\zombies\weapons\_zombie_microwave_gun::setmicrowaveweaponlevel(param_01);
		maps\mp\zombies\weapons\_zombie_microwave_gun::playersetmicrowavemaxammo();
	}
}

//Function Number: 57
burgertowngivemaxscriptedammo(param_00)
{
	if(issubstr(param_00,"iw5_microwavezm_mp"))
	{
		maps\mp\zombies\weapons\_zombie_microwave_gun::playersetmicrowavemaxammo();
	}
}

//Function Number: 58
burgertowngivepointsforkillshot(param_00,param_01)
{
	if(issubstr(param_01,"iw5_microwavezm_mp"))
	{
		return "kill_head";
	}

	return param_00;
}

//Function Number: 59
burgertownplayercanawardpointsfordamage(param_00,param_01)
{
	if(isdefined(param_01) && issubstr(param_00,"iw5_microwavezm_mp"))
	{
		if(isdefined(param_01.nextmicrowavepointstime) && gettime() < param_01.nextmicrowavepointstime)
		{
			return 0;
		}

		param_01.nextmicrowavepointstime = gettime() + maps\mp\zombies\weapons\_zombie_microwave_gun::getmicrowavepointstimesec() * 1000;
	}

	return 1;
}

//Function Number: 60
burgertownonzombiekilled(param_00,param_01)
{
	maps\mp\zombies\_terminals::givecurestationachievement();
	maps\mp\zombies\weapons\_zombie_microwave_gun::givezombiescookedachievement(param_00,param_01);
	giveburgertowntrapachievement(param_01);
}

//Function Number: 61
inittraps()
{
	precachestring(&"ZOMBIE_BRG_AMBULANCE_TRAP_READY");
	precachestring(&"ZOMBIE_BRG_AMBULANCE_TRAP_COOLDOWN");
	precachestring(&"ZOMBIE_BRG_ELECTRIC_FLOOR_TRAP_READY");
	precachestring(&"ZOMBIE_BRG_ELECTRIC_FLOOR_TRAP_COOLDOWN");
	precachestring(&"ZOMBIE_BRG_SNIPER_TRAP_READY");
	precachestring(&"ZOMBIE_BRG_SNIPER_TRAP_COOLDOWN");
	precachestring(&"ZOMBIE_BRG_GATOR_TRAP_READY");
	precachestring(&"ZOMBIE_BRG_GATOR_TRAP_COOLDOWN");
	precachestring(&"ZOMBIE_BRG_STEAM_TRAP_READY");
	precachestring(&"ZOMBIE_BRG_STEAM_TRAP_COOLDOWN");
	precachestring(&"ZOMBIE_BRG_AIRSTRIKE_TRAP_READY");
	precachestring(&"ZOMBIE_BRG_AIRSTRIKE_TRAP_COOLDOWN");
	level.trappickupdisabled = 1;
	level.modplayertrapdmg = 1;
	maps\mp\zombies\traps\_trap_sniper::init();
	maps\mp\zombies\traps\_trap_airstrike::init();
	maps\mp\zombies\_traps::register_trap_state_models("dlc2_wall_interact_off","dlc2_wall_interact_on","dlc2_wall_interact_active","dlc2_wall_interact_cooldown");
	thread maps\mp\zombies\_traps::trap_setup_custom_function("trap_snipers","active",::trap_snipers);
	thread maps\mp\zombies\_traps::trap_setup_custom_function("trap_gators","active",::trap_gators);
	thread maps\mp\zombies\_traps::trap_setup_custom_function("trap_airstrike","active",::trap_airstrike);
	thread maps\mp\zombies\_traps::trap_setup_custom_function("trap_electric_floor","active",::trap_electric_floor);
	thread maps\mp\zombies\_traps::trap_setup_custom_function("trap_sewer_steam","active",::trap_sewer_gas);
	thread maps\mp\zombies\_traps::trap_setup_custom_function("trap_ambulance","active",::trap_ambulance);
	thread maps\mp\zombies\_traps::trap_setup_custom_function("trap_snipers","ready",::trap_console_audio);
	thread maps\mp\zombies\_traps::trap_setup_custom_function("trap_gators","ready",::trap_console_audio);
	thread maps\mp\zombies\_traps::trap_setup_custom_function("trap_airstrike","ready",::trap_console_audio);
	thread maps\mp\zombies\_traps::trap_setup_custom_function("trap_electric_floor","ready",::trap_console_audio);
	thread maps\mp\zombies\_traps::trap_setup_custom_function("trap_sewer_steam","ready",::trap_console_audio);
	thread maps\mp\zombies\_traps::trap_setup_custom_function("trap_ambulance","ready",::trap_console_audio);
	maps\mp\zombies\_traps::trap_setup_custom_hints("trap_ambulance",&"ZOMBIE_BRG_AMBULANCE_TRAP_READY",&"ZOMBIE_BRG_AMBULANCE_TRAP_COOLDOWN");
	maps\mp\zombies\_traps::trap_setup_custom_hints("trap_electric_floor",&"ZOMBIE_BRG_ELECTRIC_FLOOR_TRAP_READY",&"ZOMBIE_BRG_ELECTRIC_FLOOR_TRAP_COOLDOWN");
	maps\mp\zombies\_traps::trap_setup_custom_hints("trap_snipers",&"ZOMBIE_BRG_SNIPER_TRAP_READY",&"ZOMBIE_BRG_SNIPER_TRAP_COOLDOWN");
	maps\mp\zombies\_traps::trap_setup_custom_hints("trap_gators",&"ZOMBIE_BRG_GATOR_TRAP_READY",&"ZOMBIE_BRG_GATOR_TRAP_COOLDOWN");
	maps\mp\zombies\_traps::trap_setup_custom_hints("trap_sewer_steam",&"ZOMBIE_BRG_STEAM_TRAP_READY",&"ZOMBIE_BRG_STEAM_TRAP_COOLDOWN");
	maps\mp\zombies\_traps::trap_setup_custom_hints("trap_airstrike",&"ZOMBIE_BRG_AIRSTRIKE_TRAP_READY",&"ZOMBIE_BRG_AIRSTRIKE_TRAP_COOLDOWN");
}

//Function Number: 62
trap_console_audio(param_00)
{
	var_01 = getentarray(param_00.target,"targetname");
	var_02 = common_scripts\utility::getstructarray(param_00.target,"targetname");
	var_03 = common_scripts\utility::array_combine(var_01,var_02);
	foreach(var_05 in var_03)
	{
		if(isdefined(var_05.script_noteworthy) && var_05.script_noteworthy == "activate_model")
		{
			param_00 thread trap_console_audio_think(var_05);
		}
	}
}

//Function Number: 63
trap_console_audio_think(param_00)
{
	param_00 playloopsound("trap_module_on");
	for(;;)
	{
		self waittill("trap_state_change",var_01);
		if(var_01 == "no_power" || var_01 == "deactivate")
		{
			wait 0.05;
			param_00 stoploopsound();
			break;
		}
	}
}

//Function Number: 64
trap_snipers(param_00)
{
	var_01 = getentarray(param_00.target,"targetname");
	foreach(var_03 in var_01)
	{
		if(!isdefined(var_03.script_noteworthy))
		{
			continue;
		}

		if(var_03.script_noteworthy == "sniper_laser")
		{
			var_04 = thread maps\mp\zombies\traps\_trap_sniper::spawnsniperent(var_03,param_00);
			var_04 thread trap_snipers_cleanup(param_00);
		}
	}
}

//Function Number: 65
trap_snipers_cleanup(param_00)
{
	for(;;)
	{
		param_00 waittill("trap_state_change",var_01);
		if(var_01 == "cooldown" || var_01 == "no_power" || var_01 == "deactivate")
		{
			self delete();
			break;
		}
	}

	param_00 notify("snipers_off");
}

//Function Number: 66
trap_gators(param_00)
{
	if(!isdefined(param_00.pitfallcounter))
	{
		param_00.pitfallcounter = 1;
	}
	else
	{
		param_00.pitfallcounter++;
	}

	if(param_00.pitfallcounter >= 5)
	{
		param_00 thread maps\mp\zombies\traps\_trap_gator::trap_gator_pitfall_audio();
	}

	var_01 = getent("gator_coll","targetname");
	var_01.start_origin = var_01.origin;
	var_01.start_angles = var_01.angles;
	var_01.gator_killed = undefined;
	if(isdefined(level.gator_kills_active) && level.gator_kills_active == 1)
	{
		var_01 thread maps\mp\gametypes\_damage::setentitydamagecallback(999999,undefined,::trap_gator_death);
		var_01 thread trap_gator_track_damage(param_00);
	}

	param_00 maps\mp\zombies\traps\_trap_gator::trap_gator_enter(var_01);
	var_02 = getentarray(param_00.target,"targetname");
	foreach(var_04 in var_02)
	{
		if(!isdefined(var_04.script_noteworthy))
		{
			continue;
		}

		if(var_04.script_noteworthy == "gator_water")
		{
			param_00 thread maps\mp\zombies\traps\_trap_gator::trap_gator_trigger_watch(var_04,var_01);
			wait 0.05;
		}
	}

	param_00 thread trap_gators_cleanup();
}

//Function Number: 67
trap_gators_cleanup()
{
	for(;;)
	{
		self waittill("trap_state_change",var_00);
		if(var_00 == "cooldown" || var_00 == "no_power" || var_00 == "deactivate")
		{
			playsoundatpos((2763,-2137,-116),"gator_leave_vox");
			self.usepitfallaudio = 0;
			break;
		}
	}
}

//Function Number: 68
trap_gator_track_damage(param_00)
{
	self.gator_killed = 0;
	for(;;)
	{
		if(self.damagetaken > 1500)
		{
			self.gator_killed = 1;
			level notify("gator_killed");
			break;
		}

		wait(0.05);
	}

	param_00 thread maps\mp\zombies\_traps::trap_set_state("cooldown");
}

//Function Number: 69
trap_gator_death(param_00,param_01,param_02,param_03)
{
	self notify("death");
}

//Function Number: 70
trap_airstrike(param_00)
{
	playsoundatpos((1801,-3294,752),"airstrike_start_alert");
	param_00 maps\mp\zombies\traps\_trap_airstrike::trap_airstrike_begin();
}

//Function Number: 71
trap_electric_floor(param_00)
{
	var_01 = getentarray(param_00.target,"targetname");
	foreach(var_03 in var_01)
	{
		if(!isdefined(var_03.script_noteworthy))
		{
			continue;
		}

		if(var_03.script_noteworthy == "damage_over_time")
		{
			param_00 thread maps\mp\zombies\traps\_trap_electrofloor::trap_electrofloor_trigger_watch(var_03);
			param_00 thread maps\mp\zombies\traps\_trap_electrofloor::trap_electrofloor_player_watch(var_03);
			wait 0.05;
		}
	}

	thread trap_electric_floor_audio(param_00);
}

//Function Number: 72
trap_electric_floor_audio(param_00)
{
	var_01 = spawn("script_origin",(1958,-1739,383));
	playsoundatpos(var_01.origin,"electric_floor_start");
	var_01 playloopsound("electric_floor_loop");
	for(;;)
	{
		param_00 waittill("trap_state_change",var_02);
		if(var_02 == "cooldown" || var_02 == "no_power" || var_02 == "deactivate")
		{
			playsoundatpos(var_01.origin,"electric_floor_stop");
			var_01 scalevolume(0,0.25);
			wait(0.25);
			var_01 stoploopsound();
			wait 0.05;
			var_01 delete();
			break;
		}
	}
}

//Function Number: 73
trap_sewer_gas(param_00)
{
	var_01 = getentarray(param_00.target,"targetname");
	foreach(var_03 in var_01)
	{
		if(!isdefined(var_03.script_noteworthy))
		{
			continue;
		}

		if(var_03.script_noteworthy == "damage_over_time")
		{
			param_00 thread maps\mp\zombies\traps\_trap_sewergas::trap_sewergas_trigger_watch(var_03);
			param_00 thread maps\mp\zombies\traps\_trap_sewergas::trap_sewergas_player_watch(var_03);
			wait 0.05;
		}
	}
}

//Function Number: 74
trap_ambulance(param_00)
{
	thread trap_ambulance_audio(param_00);
}

//Function Number: 75
trap_ambulance_audio(param_00)
{
	var_01 = spawn("script_origin",param_00.origin);
	playsoundatpos(var_01.origin,"ambulance_start");
	wait(0.3);
	var_01 scalevolume(0);
	var_01 playloopsound("ambulance_loop");
	var_01 scalevolume(1,0.35);
	for(;;)
	{
		param_00 waittill("trap_state_change",var_02);
		if(var_02 == "cooldown" || var_02 == "no_power" || var_02 == "deactivate")
		{
			playsoundatpos(var_01.origin,"ambulance_stop");
			var_01 scalevolume(0,0.25);
			wait(0.25);
			var_01 stoploopsound();
			wait 0.05;
			var_01 delete();
			break;
		}
	}
}

//Function Number: 76
trap_carwash(param_00)
{
	thread trap_carwash_audio(param_00);
}

//Function Number: 77
trap_carwash_audio(param_00)
{
	var_01 = spawn("script_origin",(456,-421,233));
	playsoundatpos(var_01.origin,"carwash_start");
	var_01 playloopsound("carwash_loop");
	for(;;)
	{
		param_00 waittill("trap_state_change",var_02);
		if(var_02 == "cooldown" || var_02 == "no_power" || var_02 == "deactivate")
		{
			playsoundatpos(var_01.origin,"carwash_stop");
			var_01 scalevolume(0,0.25);
			wait(0.25);
			var_01 stoploopsound();
			wait 0.05;
			var_01 delete();
			break;
		}
	}
}

//Function Number: 78
giveburgertowntrapachievement(param_00)
{
	if(!isdefined(param_00))
	{
		return;
	}

	if(!isdefined(level.numtrapkills))
	{
		level.numtrapkills = 0;
	}

	switch(param_00)
	{
		case "trap_sniper_zm_mp":
		case "trap_missile_zm_mp":
		case "trap_zm_mp":
			level.numtrapkills++;
			break;

		default:
			break;
	}

	if(level.numtrapkills == 100)
	{
		maps\mp\gametypes\zombies::giveplayerszombieachievement("DLC2_ZOMBIE_INDIRECTFIRE");
	}
}

//Function Number: 79
spawnzombiekilledfx(param_00,param_01)
{
	if(!isdefined(param_00) || !isdefined(param_01))
	{
		return 0;
	}

	if(self.agent_type == "zombie_melee_goliath")
	{
		return 1;
	}

	if(param_00 == "MOD_EXPLOSIVE" && param_01 == "iw5_microwavezm_mp")
	{
		maps\mp\zombies\weapons\_zombie_microwave_gun::playzombiekilledmicrowavefx();
		return 1;
	}

	return 0;
}

//Function Number: 80
enablespecialweaponlevelbox()
{
	wait(1);
	level notify("special_weapon_box_unlocked");
}

//Function Number: 81
initrollupdoors()
{
	var_00 = "dlc_rollup_door_metal_open";
	precachempanim(var_00);
	wait(1);
	var_01 = getentarray("rollup_door","targetname");
	foreach(var_03 in var_01)
	{
		var_03 thread rollupdoorthink(var_00);
	}
}

//Function Number: 82
rollupdoorthink(param_00)
{
	var_01 = self.script_flag;
	common_scripts\utility::flag_wait(var_01);
	self scriptmodelplayanim(param_00);
}

//Function Number: 83
spinningpitbullwheel()
{
	var_00 = "hms_greece_sniperscramble_pitbull_destroyed_veh";
	precachempanim(var_00);
	wait(1);
	var_01 = getent("pitbull_veh","targetname");
	var_01 scriptmodelplayanim(var_00);
}

//Function Number: 84
flyoverbink()
{
}

//Function Number: 85
setupflyoveranimation(param_00,param_01,param_02,param_03)
{
	var_04 = common_scripts\utility::getstruct("env_bink_anim_node","targetname");
	if(!isdefined(var_04))
	{
		var_04 = spawnstruct();
		var_04.origin = (0,3584,88);
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
	level.zombiegamepaused = 1;
	wait(1);
	var_05 = spawn("script_model",(0,0,0));
	var_05 setmodel("genericprop_x3");
	var_06 = spawn("script_model",(0,0,0));
	var_06 setmodel("tag_player");
	var_06 vehicle_jetbikesethoverforcescale(var_05,param_01,(0,0,0),(0,0,0));
	for(;;)
	{
		while(getdvarint(param_03,0) == 0)
		{
			wait 0.05;
		}

		level.player playerlinkweaponviewtodelta(var_06,"tag_player",1,0,0,0,0,1);
		level.player playerlinkedsetviewznear(0);
		level.player hide();
		var_05 scriptmodelplayanimdeltamotionfrompos(param_00,var_04.origin,var_04.angles,"camera_notetrack");
		foreach(var_08 in param_02)
		{
			level thread donotetrack(var_05,"camera_notetrack",var_08);
		}

		wait(1);
		while(getdvarint(param_03,0) == 1)
		{
			wait 0.05;
		}

		var_05 notify("notetrackDone");
		level.player show();
		level.player unlink();
		var_05 scriptmodelclearanim();
		wait(1);
	}
}

//Function Number: 86
donotetrack(param_00,param_01,param_02,param_03)
{
	param_00 endon("notetrackDone");
	param_00 waittillmatch(param_02,param_01);
	if(param_02 == "trigger_gater")
	{
	}
	else if(param_02 == "water_fx")
	{
		var_04 = common_scripts\utility::getstruct("gator_water_level","script_noteworthy");
		var_05 = var_04.origin;
		var_06 = (0,0,90);
		playfx(common_scripts\utility::getfx("trap_gator_enter_splash"),var_05,var_06);
		playsoundatpos(var_05,"gator_spawn_splash");
	}

	level notify(param_02);
}

//Function Number: 87
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

//Function Number: 88
inittoxiczones()
{
	calculatenexttoxicgasround();
	precachestring(&"ZOMBIE_BRG_TOXIC_EVENT_START");
	precachestring(&"ZOMBIE_BRG_TOXIC_EVENT_STOP");
	precachestring(&"ZOMBIE_BRG_ATLAS_ZONE");
	precachestring(&"ZOMBIE_BRG_BURGER_TOWN_ZONE");
	precachestring(&"ZOMBIE_BRG_GAS_ZONE");
	level._effect["Toxic_Gas_Burst"] = loadfx("vfx/gameplay/mp/zombie/dlc2_host_cloud_burst");
	level._effect["Toxic_Gas_Cloud"] = loadfx("vfx/gameplay/mp/zombie/dlc2_host_cloud_large");
	level._effect["Toxic_Gas_Jets"] = loadfx("vfx/gameplay/mp/zombie/dlc2_host_cloud_jets");
	level._effect["Toxic_Gas_Doorways"] = loadfx("vfx/gameplay/mp/zombie/dlc2_host_cloud_doorway");
	level.toxiczones = [];
	level.toxiczones["Atlas"] = spawnstruct();
	level.toxiczones["BurgerTown"] = spawnstruct();
	level.toxiczones["GasStation"] = spawnstruct();
	level.toxiczones["Atlas"].zonename = "Atlas";
	level.toxiczones["BurgerTown"].zonename = "BurgerTown";
	level.toxiczones["GasStation"].zonename = "GasStation";
	level.toxiczones["Atlas"].zones = ["atlas_north_vol","atlas_center_vol","atlas_south_vol"];
	level.toxiczones["BurgerTown"].zones = ["burgertown_trench_vol","burgertown_parking_vol","burgertown_roof_vol","burgertown_int_vol","burgertown_east_vol","burgertown_west_vol"];
	level.toxiczones["GasStation"].zones = ["gas_station_pit_vol","gas_station_bldg_vol","gas_station_pumps_vol"];
	thread toxicgaszoneevent();
}

//Function Number: 89
toxicgaszoneevent()
{
	var_00 = ["Atlas","BurgerTown","GasStation"];
	for(;;)
	{
		level waittill("zombie_round_countdown_started");
		if(level.roundtype == "civilian")
		{
			continue;
		}

		if(level.wavecounter >= level.nexttoxicgasround)
		{
			var_01 = [];
			var_02 = maps\mp\zombies\_zombies_zone_manager::getcurrentplayeroccupiedzones();
			if(var_02.size <= 0)
			{
				continue;
			}

			foreach(var_04 in var_02)
			{
				foreach(var_06 in var_00)
				{
					if(!common_scripts\utility::array_contains(level.toxiczones[var_06].zones,var_04))
					{
						continue;
					}

					if(!common_scripts\utility::array_contains(var_01,level.toxiczones[var_06].zonename))
					{
						var_01 = common_scripts\utility::array_add(var_01,level.toxiczones[var_06].zonename);
					}
				}
			}

			thread activatetoxiczones(var_01,var_00);
			if(level.wavecounter >= 30)
			{
				level.special_mutators["emz"][1] = 1;
			}

			calculatenexttoxicgasround();
		}
	}
}

//Function Number: 90
activatetoxiczones(param_00,param_01)
{
	if(level.wavecounter >= 30)
	{
		var_02 = 3;
	}
	else if(level.wavecounter >= 20)
	{
		var_02 = 2;
	}
	else
	{
		var_02 = 1;
	}

	param_00 = common_scripts\utility::array_randomize(param_00);
	var_03 = 0;
	for(var_04 = 0;var_04 < var_02 && var_04 < param_00.size;var_04++)
	{
		var_05 = param_00[var_04];
		if(!var_03)
		{
			level thread maps\mp\zombies\_zombies_audio_dlc2::zmaudiotoxiczonesvo(level.toxiczones[var_05].zones);
			var_03 = 1;
		}

		thread toxicgaszonefx(var_05);
		thread toxicgaszonefillfx(var_05);
		wait(2);
		param_01 = common_scripts\utility::array_remove(param_01,var_05);
	}

	if(var_04 == var_02)
	{
		return;
	}

	param_01 = common_scripts\utility::array_randomize(param_01);
	var_06 = var_04;
	for(var_04 = 0;var_06 < var_02 && var_04 < param_01.size > 0;var_04++)
	{
		thread toxicgaszonefx(param_01[var_04]);
		var_06++;
		wait(2);
	}
}

//Function Number: 91
toxicgaszonefx(param_00)
{
	level endon("game_ended");
	level notify("toxic_gas_started");
	var_01 = level.toxiczones[param_00].zones;
	var_02 = toxicgaszonelocstringreturn(param_00);
	var_03 = common_scripts\utility::getstruct(param_00 + "_ToxicGas","script_noteworthy");
	var_04 = spawn("script_model",var_03.origin);
	var_04 setmodel("tag_origin");
	var_04.angles = (270,0,0);
	thread toxicgasstartaudio(var_03);
	thread toxicgascanfx(var_04);
	iprintlnbold(var_02);
	wait(5);
	maps\mp\zombies\_zombies_audio_announcer::announcerglobaldialog("global_priority","gas_warning",undefined,1,1);
	maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("Toxic_Gas_Burst"),var_04,"tag_origin");
	wait(5);
	maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("Toxic_Gas_Cloud"),var_04,"tag_origin");
	foreach(var_06 in var_01)
	{
		thread toxicgaszoneinfectiontrigger(var_06);
	}

	thread toxicgascleanupfx(var_04);
	level waittill("zombie_wave_ended");
	level notify("toxic_gas_ended");
	iprintlnbold(&"ZOMBIE_BRG_TOXIC_EVENT_STOP");
	thread toxicgasallclearaudio();
}

//Function Number: 92
toxicgaszonefillfx(param_00)
{
	var_01 = common_scripts\utility::getstructarray(param_00 + "_ToxicFillGas","targetname");
	foreach(var_03 in var_01)
	{
		var_04 = spawn("script_model",var_03.origin);
		var_04 setmodel("tag_origin");
		var_04.angles = var_03.angles;
		maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("Toxic_Gas_Doorways"),var_04,"tag_origin");
		thread toxicgascleanupfx(var_04);
	}
}

//Function Number: 93
toxicgaszonelocstringreturn(param_00)
{
	switch(param_00)
	{
		case "Atlas":
			return &"ZOMBIE_BRG_ATLAS_ZONE";

		case "BurgerTown":
			return &"ZOMBIE_BRG_BURGER_TOWN_ZONE";

		case "GasStation":
			return &"ZOMBIE_BRG_GAS_ZONE";
	}

	return undefined;
}

//Function Number: 94
toxicgascleanupfx(param_00)
{
	level endon("game_ended");
	level waittill("zombie_wave_ended");
	param_00 delete();
}

//Function Number: 95
toxicgascanfx(param_00)
{
	level endon("game_ended");
	level endon("toxic_gas_ended");
	param_00 endon("death");
	for(;;)
	{
		earthquake(0.35,5,param_00.origin,1024);
		thread audioscreenshake();
		maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("Toxic_Gas_Jets"),param_00,"tag_origin");
		wait(30);
	}
}

//Function Number: 96
toxicgaszoneinfectiontrigger(param_00)
{
	level endon("game_ended");
	level endon("zombie_wave_ended");
	var_01 = 5000;
	for(;;)
	{
		foreach(var_03 in level.players)
		{
			if(!isalive(var_03))
			{
				continue;
			}

			if(maps\mp\zombies\_util::isplayerinlaststand(var_03))
			{
				continue;
			}

			if(var_03 maps\mp\zombies\_zombies_zone_manager::getplayerzone() != param_00)
			{
				continue;
			}

			if(maps\mp\zombies\_util::isplayerinfected(var_03))
			{
				var_03 dodamage(25,var_03.origin,undefined,undefined,"MOD_TRIGGER_HURT");
				continue;
			}

			var_03 thread maps\mp\zombies\_zombies_laststand::hostzombielaststand();
		}

		wait(2.5);
	}
}

//Function Number: 97
toxicgasstartaudio(param_00)
{
	thread toxicgasspewaudio(param_00);
	if(isdefined(level.toxic_alarm_aud) && level.toxic_alarm_aud)
	{
		return;
	}

	level.toxic_alarm_aud = 1;
	for(var_01 = 0;var_01 < 5;var_01 = var_01 + 1)
	{
		maps\mp\_audio::snd_play_in_space("event_gas_alert_front",(0,0,0));
		wait(2.5);
	}

	level.toxic_alarm_aud = 0;
}

//Function Number: 98
audioscreenshake()
{
	maps\mp\_audio::snd_play_in_space("event_gas_screen_shake_front",(0,0,0));
}

//Function Number: 99
toxicgasallclearaudio()
{
	for(var_00 = 0;var_00 < 3;var_00 = var_00 + 1)
	{
		maps\mp\_audio::snd_play_in_space("event_gas_all_clear_front",(0,0,0));
		wait(1.5);
	}
}

//Function Number: 100
toxicgasspewaudio(param_00)
{
	var_01 = spawn("script_model",param_00.origin);
	wait(0.35);
	playsoundatpos(var_01.origin,"event_gas_steam_active");
	wait(4.9);
	playsoundatpos(var_01.origin,"event_gas_steam_2nd_burst");
	wait(0.25);
	var_01 playloopsound("event_gas_steam_active_lp");
	var_01 scalevolume(0);
	wait 0.05;
	var_01 scalevolume(1,0.5);
	level waittill("zombie_wave_ended");
	var_01 scalevolume(0,5);
	wait(5);
	var_01 stoploopsound("event_gas_steam_active_lp");
}

//Function Number: 101
spawnanimationnotetrackhandlerassigner(param_00)
{
	if(isdefined(param_00.script_wtf))
	{
		var_01 = param_00.target;
		self.spawnfxloc = common_scripts\utility::getstruct(var_01,"targetname");
		switch(param_00.script_wtf)
		{
			case "spawn_dirt":
				return ::dirtspawnnotetrackhandler;

			case "spawn_concrete":
				return ::concretespawnnotetrackhandler;

			case "spawn_mud":
				return ::mudspawnnotetrackhandler;

			case "spawn_garbage":
				return ::garbagespawnnotetrackhandler;

			case "spawn_manhole":
				return ::manholespawnnotetrackhandler;

			case "spawn_water":
				return ::waterspawnnotetrackhandler;

			case "spawn_goliath_dirt":
				return ::goliathdirtspawnnotetrackhandler;

			case "spawn_goliath_water":
				return ::goliathwaterspawnnotetrackhandler;

			case "spawn_goliath_concrete":
				return ::goliathconcretespawnnotetrackhandler;

			case "spawn_goliath_mud":
				return ::goliathmudspawnnotetrackhandler;

			case "spawn_goliath_metal":
				return ::goliathmetalspawnnotetrackhandler;
		}
	}
}

//Function Number: 102
dirtspawnnotetrackhandler(param_00,param_01,param_02,param_03)
{
	if(param_00 == "zom_spawn_event")
	{
		thread zombiespawnfx("spawn_dirt");
		self playsound("zmb_spawn_dirt");
	}
}

//Function Number: 103
mudspawnnotetrackhandler(param_00,param_01,param_02,param_03)
{
	if(param_00 == "zom_spawn_event")
	{
		thread zombiespawnfx("spawn_mud");
		self playsound("zmb_spawn_mud");
	}
}

//Function Number: 104
concretespawnnotetrackhandler(param_00,param_01,param_02,param_03)
{
	if(param_00 == "zom_spawn_event")
	{
		thread zombiespawnfx("spawn_concrete");
		self playsound("zmb_spawn_concrete");
	}
}

//Function Number: 105
garbagespawnnotetrackhandler(param_00,param_01,param_02,param_03)
{
	if(param_00 == "zom_spawn_event")
	{
		thread zombiespawnfx("spawn_garbage");
		self playsound("zmb_spawn_garbage");
	}
}

//Function Number: 106
manholespawnnotetrackhandler(param_00,param_01,param_02,param_03)
{
	if(param_00 == "zom_spawn_event")
	{
		thread zombiespawnfx("spawn_manhole");
		thread zombiedripfx("spawn_water");
		self playsound("zmb_spawn_manhole");
	}
}

//Function Number: 107
waterspawnnotetrackhandler(param_00,param_01,param_02,param_03)
{
	if(param_00 == "zom_spawn_event")
	{
		thread zombiespawnfx("spawn_water");
		thread zombiedripfx("spawn_water");
		self playsound("zmb_spawn_water");
	}
}

//Function Number: 108
zombiedripfx(param_00)
{
	if(!level.nextgen)
	{
		return;
	}

	if(level.wavecounter >= 20)
	{
		return;
	}

	if(isdefined(self.activemutators))
	{
		return;
	}

	var_01 = "spawn_water_drip";
	if(isdefined(param_00))
	{
		var_01 = param_00 + "_drip";
	}

	var_02 = [];
	if(isdefined(self.agent_type) && self.agent_type == "zombie_dog")
	{
		var_02 = ["J_Spine4","J_Head"];
	}
	else
	{
		var_02 = ["J_Shoulder_RI","J_Shoulder_LE","J_Hip_LE","J_Hip_RI","J_Head"];
	}

	foreach(var_04 in var_02)
	{
		if(isdefined(self gettagorigin(var_04)))
		{
			maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx(var_01),self,var_04);
		}
	}

	zombiedripfxcleanup(var_02,var_01);
}

//Function Number: 109
zombiedripfxcleanup(param_00,param_01)
{
	self endon("death");
	while(isdefined(self) && isalive(self))
	{
		wait(0.1);
		if(!isdefined(self.inspawnanim) || !self.inspawnanim)
		{
			break;
		}
	}

	wait(randomfloatrange(5,15));
	if(!isdefined(self) || !isalive(self))
	{
		return;
	}

	foreach(var_03 in param_00)
	{
		if(isdefined(self gettagorigin(var_03)))
		{
			maps\mp\zombies\_util::stopfxontagnetwork(common_scripts\utility::getfx(param_01),self,var_03);
		}
	}
}

//Function Number: 110
zombiespawnfx(param_00)
{
	if(level.nextgen && level.zombiespawnfxcount >= 12)
	{
		return;
	}
	else if(!level.nextgen && level.zombiespawnfxcount >= 3)
	{
		return;
	}

	var_01 = self.spawnfxloc;
	if(!isdefined(var_01))
	{
		var_01 = self;
	}

	var_02 = spawnfx(common_scripts\utility::getfx(param_00),var_01.origin,anglestoforward(var_01.angles),anglestoup(var_01.angles));
	triggerfx(var_02);
	level.zombiespawnfxcount++;
	common_scripts\utility::waittill_notify_or_timeout("death",3);
	level.zombiespawnfxcount--;
	var_02 delete();
}

//Function Number: 111
goliathdirtspawnnotetrackhandler(param_00,param_01,param_02,param_03)
{
	if(param_00 == "zom_spawn_event")
	{
		thread goliathspawntrailfx();
		return;
	}

	if(param_00 == "goliath_impact")
	{
		thread goliathspawnfx("goliath_spawn_dirt");
	}
}

//Function Number: 112
goliathwaterspawnnotetrackhandler(param_00,param_01,param_02,param_03)
{
	if(param_00 == "zom_spawn_event")
	{
		thread goliathspawntrailfx();
		return;
	}

	if(param_00 == "goliath_impact")
	{
		thread goliathspawnfx("goliath_spawn_water");
	}
}

//Function Number: 113
goliathconcretespawnnotetrackhandler(param_00,param_01,param_02,param_03)
{
	if(param_00 == "zom_spawn_event")
	{
		thread goliathspawntrailfx();
		return;
	}

	if(param_00 == "goliath_impact")
	{
		thread goliathspawnfx("goliath_spawn_concrete");
	}
}

//Function Number: 114
goliathmudspawnnotetrackhandler(param_00,param_01,param_02,param_03)
{
	if(param_00 == "zom_spawn_event")
	{
		thread goliathspawntrailfx();
		return;
	}

	if(param_00 == "goliath_impact")
	{
		thread goliathspawnfx("goliath_spawn_mud");
	}
}

//Function Number: 115
goliathmetalspawnnotetrackhandler(param_00,param_01,param_02,param_03)
{
	if(param_00 == "zom_spawn_event")
	{
		thread goliathspawntrailfx();
		return;
	}

	if(param_00 == "goliath_impact")
	{
		thread goliathspawnfx("goliath_spawn_metal");
	}
}

//Function Number: 116
goliathspawnfx(param_00)
{
	var_01 = self.spawnfxloc;
	if(!isdefined(var_01))
	{
		var_01 = self;
	}

	var_02 = spawnfx(common_scripts\utility::getfx(param_00),var_01.origin,anglestoforward(var_01.angles),anglestoup(var_01.angles));
	triggerfx(var_02);
	self notify("end_spawn_trail_fx");
	thread goliathspawnexplosion();
	self playsound("zmb_gol_spawn_crash_land");
	level.zombiespawnfxcount++;
	common_scripts\utility::waittill_notify_or_timeout("death",3);
	level.zombiespawnfxcount--;
	var_02 delete();
}

//Function Number: 117
goliathspawnexplosion()
{
	var_00 = self.origin;
	thread goliathspawnexplosionradiusdamage(var_00);
	thread goliathspawndestroydroppods(var_00);
	physicsexplosionsphere(var_00,512,128,randomfloatrange(2,5));
	earthquake(0.5,1,var_00,1200);
	playrumbleonposition("artillery_rumble",var_00);
}

//Function Number: 118
goliathspawnexplosionradiusdamage(param_00)
{
	wait(0.05);
	var_01 = maps\mp\agents\_agent_utility::getactiveagentsoftype("all");
	var_01 = sortbydistance(var_01,param_00,64);
	foreach(var_03 in var_01)
	{
		if(isdefined(var_03.agent_type) && var_03.agent_type == "zombie_melee_goliath")
		{
			continue;
		}
		else
		{
			if(isplayer(var_03) || isdefined(var_03.agentteam) && var_03.agentteam == level.playerteam)
			{
				var_04 = int(var_03.health * 0.5);
				var_03 dodamage(var_04,param_00);
				continue;
			}

			var_04 = var_03.health + 10;
			if(isdefined(var_03.maxhealth))
			{
				var_04 = var_03.maxhealth + 10;
			}

			var_03 dodamage(var_04,param_00);
		}
	}
}

//Function Number: 119
goliathspawntrailfx()
{
	maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("goliath_spawn_trail"),self,"J_Spine4");
	self waittill("end_spawn_trail_fx");
	maps\mp\zombies\_util::stopfxontagnetwork(common_scripts\utility::getfx("goliath_spawn_trail"),self,"J_Spine4");
}

//Function Number: 120
goliathspawndestroydroppods(param_00)
{
	if(!isdefined(level.carepackages))
	{
		return;
	}

	var_01 = level.carepackages;
	var_01 = sortbydistance(var_01,param_00,64);
	foreach(var_03 in var_01)
	{
		var_03 maps\mp\killstreaks\_airdrop::deletecrate(1);
	}
}

//Function Number: 121
onzombieburgertownstartgame()
{
	level thread maps\mp\zombies\_teleport::init();
	level thread maps\mp\zombies\_util::outofboundswatch(0);
	thread inittraps();
}

//Function Number: 122
exploittrigger()
{
	var_00 = getentarray("exploitTrigger","targetname");
	foreach(var_02 in var_00)
	{
		var_02 thread exploittriggermonitor();
	}
}

//Function Number: 123
exploittriggermonitor()
{
	level endon("game_ended");
	for(;;)
	{
		self waittill("trigger",var_00);
		if(isplayer(var_00))
		{
			if(isdefined(self.script_parameters) && self.script_parameters == "exploitTriggerDmg")
			{
				thread exploittriggerdamage(var_00);
			}

			if(isdefined(self.script_noteworthy) && self.script_noteworthy == "exploitTriggerUseStructs" || self.script_noteworthy == "exploitTriggerUseZombies")
			{
				var_01 = maps\mp\agents\_agent_utility::getactiveagentsoftype("all");
				foreach(var_03 in var_01)
				{
					var_04 = distance(var_00.origin,var_03.origin);
					if(var_04 < 100)
					{
						if(self.script_noteworthy == "exploitTriggerUseStructs")
						{
							var_05 = common_scripts\utility::getstructarray(self.target,"targetname");
							var_06 = common_scripts\utility::getclosest(var_00.origin,var_05);
							if(isdefined(var_06))
							{
								var_07 = vectornormalize(var_06.origin - var_00.origin * (1,1,0));
							}
							else
							{
								var_07 = vectornormalize(var_00.origin - var_03.origin * (1,1,0));
							}
						}
						else
						{
							var_07 = vectornormalize(var_04.origin - var_01.origin * (1,1,0));
						}

						var_00 setvelocity(var_07 * 20);
						break;
					}

					wait(0.1);
				}
			}
		}

		wait(1);
	}
}

//Function Number: 124
exploittriggerdamage(param_00)
{
	level endon("game_ended");
	param_00 endon("death");
	param_00 endon("begin_last_stand");
	wait(1);
	if(param_00 istouching(self))
	{
		param_00 dodamage(10,param_00.origin);
	}
}

//Function Number: 125
zombiespawnhudoutline()
{
	for(;;)
	{
		wait(0.25);
		var_00 = maps\mp\agents\_agent_utility::getactiveagentsoftype("all");
		foreach(var_02 in var_00)
		{
			var_02 hudoutlineenable(0,0);
		}
	}
}

//Function Number: 126
zombiezonedebug(param_00)
{
	if(param_00 == 1)
	{
		thread zombiespawnhudoutline();
	}

	wait(10);
	var_01 = getentarray("info_volume","classname");
	foreach(var_03 in var_01)
	{
		if(var_03.targetname != "burger_tower_vol")
		{
			var_04 = common_scripts\utility::getstructarray(var_03.target,"targetname");
			var_03 thread zombiezonedebugplayerlocation(var_04);
		}
	}
}

//Function Number: 127
zombiezonedebugplayerlocation(param_00)
{
	for(;;)
	{
		wait(0.05);
		if(!level.players[0] istouching(self))
		{
			continue;
		}

		foreach(var_02 in param_00)
		{
			if(isdefined(var_02.script_animation))
			{
				switch(var_02.script_animation)
				{
					case "spawn_crawl_left":
						common_scripts\utility::draw_arrow_time(var_02.origin,var_02.origin + (0,0,32),(255,255,0),0.05);
						break;
	
					case "spawn_crawl_right":
						common_scripts\utility::draw_arrow_time(var_02.origin,var_02.origin + (0,0,32),(255,0,0),0.05);
						break;
	
					case "spawn_crawl_up":
						common_scripts\utility::draw_arrow_time(var_02.origin,var_02.origin + (0,0,32),(0,0,255),0.05);
						break;
				}

				continue;
			}

			common_scripts\utility::draw_arrow_time(var_02.origin,var_02.origin + (0,0,32),(255,255,255),0.05);
		}
	}
}

//Function Number: 128
sewerscurestationdisablespawning()
{
	for(;;)
	{
		level waittill("cure_station_active");
		var_00 = maps\mp\zombies\_util::getnumplayers();
		if(var_00 == 1)
		{
			break;
		}

		level.zone_data.zones["sewerpit_vol"].disablespawns = 1;
		level waittill("cure_station_deactive");
		level.zone_data.zones["sewerpit_vol"].disablespawns = undefined;
	}
}

//Function Number: 129
updatecivilianextractionpoints()
{
	var_00 = "warehouse_office_vol";
	var_01 = "gas_station_bldg_vol";
	var_02 = "atlas_center_vol";
	var_03 = "sewermain_vol";
	var_04 = "sewertunnel_vol";
	var_05 = "burgertown_roof_vol";
	var_06 = [var_01,var_02,var_03,var_04,var_05];
	var_07 = [];
	var_08 = [];
	if(!isdefined(level.resetextractionpointround))
	{
		calculatenextextractionpointreset();
	}

	if(level.civrounds <= 3)
	{
		switch(level.civrounds)
		{
			case 1:
				var_07 = common_scripts\utility::array_combine(level.zone_data.zones[var_01].civilian_spawners,level.zone_data.zones[var_02].civilian_spawners);
				var_08 = level.zone_data.zones[var_00].civilian_extracts;
				break;

			case 2:
				var_07 = level.zone_data.zones[var_03].civilian_spawners;
				var_08 = common_scripts\utility::array_combine(level.zone_data.zones[var_01].civilian_extracts,level.zone_data.zones[var_02].civilian_extracts);
				break;

			case 3:
				if(!maps\mp\zombies\_zombies_zone_manager::iszoneenabled(var_05))
				{
					var_07 = level.zone_data.zones[var_05].civilian_spawners;
					var_08 = common_scripts\utility::array_combine(level.zone_data.zones[var_01].civilian_extracts,level.zone_data.zones[var_02].civilian_extracts);
				}
				else
				{
					var_07 = common_scripts\utility::array_combine(level.zone_data.zones[var_01].civilian_spawners,level.zone_data.zones[var_02].civilian_spawners);
					var_08 = level.zone_data.zones[var_05].civilian_extracts;
				}
				break;
		}
	}
	else
	{
		foreach(var_0A in var_06)
		{
			foreach(var_0C in level.zone_data.zones[var_0A].civilian_spawners)
			{
				var_07 = common_scripts\utility::add_to_array(var_07,var_0C);
			}

			foreach(var_0F in level.zone_data.zones[var_0A].civilian_extracts)
			{
				var_08 = common_scripts\utility::add_to_array(var_08,var_0F);
				if(level.wavecounter >= level.resetextractionpointround)
				{
					var_0F.hasbeenused = undefined;
				}
			}
		}
	}

	var_12 = common_scripts\utility::random(var_07);
	foreach(var_0F in var_08)
	{
		if((isdefined(var_0F.hasbeenused) && var_0F.hasbeenused == 1) || !maps\mp\zombies\_zombies_zone_manager::ispathnodeinenabledzone(var_0F))
		{
			var_08 = common_scripts\utility::array_remove(var_08,var_0F);
		}
	}

	var_08 = sortbydistance(var_08,var_12.origin);
	if(var_08.size > 2)
	{
		var_15 = var_08[var_08.size - randomintrange(1,2)];
	}
	else if(var_12.size > 0)
	{
		var_15 = var_12[var_12.size - 1];
	}
	else
	{
		var_15 = level.zone_data.zones[var_01].civilian_extracts[0];
	}

	level.civ_extract.spawnpoint = var_12;
	level.civ_extract.extractpoint = var_15;
	var_15.hasbeenused = 1;
	if(level.wavecounter >= level.resetextractionpointround)
	{
		calculatenextextractionpointreset();
	}
}

//Function Number: 130
noflashemzhitfx(param_00)
{
	var_01 = maps\mp\zombies\_zombies_zone_manager::getplayerzone();
	if(common_scripts\utility::array_contains(level.noemzflashzones,var_01))
	{
		return level._effect["mut_emz_attack_no_flash"];
	}

	return level._effect["mut_emz_attack_sm"];
}

//Function Number: 131
spawnpatchclipfixes()
{
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(51,-1714,138.5),(0,15,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64",(2.5,-1694,236),(29.099,15,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64",(19.5,-1757,236),(29.099,15,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64",(37,-1808,242),(29.099,15,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64",(50,-1856.5,242),(29.099,15,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64",(82.5006,-1672,235.993),(30.0996,195,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64",(99.4994,-1735,236.007),(30.0996,195,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64",(108,-1792,236),(30.0996,182.5,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64",(122.5,-1837,242),(30.0996,195,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_128_128",(124,-1823.5,138.5),(0,2.5,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64",(85,-1894.5,242),(30.0996,105,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64",(113,-1887,242),(30.0996,105,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(2192,-4416,216),(0,45,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(2192,-4416,344),(0,45,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(2192,-4416,472),(0,45,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(1832,-4700,536),(0,315,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(1832,-4700,280),(0,315,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_128_128",(1360,-4350,239),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64",(1420,-4350,166),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_128_128",(2613,-2048.5,-275.5),(270,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_128_128",(2613,-2148.48,-275.523),(270,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_128_128",(2613,-2010,-347.5),(0,270,90));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_128_128",(2741,-2010,-347.5),(0,270,90));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_128_128",(2869,-2010,-347.5),(0,270,90));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_128_128",(2613,-2185.5,-347.5),(0,270,90));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_128_128",(2741,-2185.5,-347.5),(0,270,90));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_128_128",(2869,-2185.5,-347.5),(0,270,90));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64",(2046,-2388,165),(90,180,90));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64",(2046,-2324,165),(90,180,90));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64",(2055,-2388,159),(90,180,90));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64",(2055,-2324,159),(90,180,90));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(148,-2896,124),(349,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(148,-2640,124),(349,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(1864,-622,78),(11,37,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(1888,-716,28),(11,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_128_128",(1375,-2634,-344),(0,22,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_128_128",(1351,-2574,-344),(0,12,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_128_128",(2869,-2205.5,-335.5),(0,270,90));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_128_128",(2846,-2249.5,-335.5),(0,0,90));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_128_128",(3007.3,-1934.3,254.867),(0,90,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_128_128",(3135.3,-1934.3,254.9),(0,90,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_128_128",(2916.5,-2412.5,256.5),(0,90,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(134,-4776,278.5),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(134,-4776,534.5),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(2922,-860,518),(356,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(1493.5,-1317,52.3),(270,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(1493.5,-1573,52.3),(270,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(1493.5,-1829,52.3),(270,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(1929.5,-1829,52.3),(270,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(1929.5,-1573,52.3),(270,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(1929.5,-1317,52.3),(270,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(981,-1908,528),(0,315,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(981,-1908,272),(0,315,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_128_128",(3251.84,-1724.74,526.326),(357.2,324.7,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64",(4132.2,-2064.51,-490.7),(355,204.4,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64",(4130.7,-2185.5,-490.7),(355,155.4,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(560,-876,410),(0,80,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(560,-876,666),(0,80,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_32_32_32",(3219.5,-1910,440),(0,315,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_32_32_32",(3219.5,-1910,472),(0,315,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(3342,-2386,624.5),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64",(3582.5,-2012,1),(0,316.324,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64",(3576,-2006,65),(338.312,316.324,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64",(3534,-2033,-61),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64",(3534,-2033,3),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64",(1291,-4350,280),(0,90,0));
}

//Function Number: 132
destroypatioglass()
{
	var_00 = spawn("trigger_radius",(1522,-3404,194),0,128,128);
	var_00.radius = 128;
	radiusdamage(var_00.origin,128,1000,1000);
	wait(10);
	var_00 delete();
}

//Function Number: 133
windowexploitledgelogic()
{
	level endon("game_ended");
	var_00 = [];
	var_01[0] = (922,-3589,193);
	var_01[1] = (978,-3589,193);
	var_01[2] = (1036,-3589,193);
	var_01[3] = (1444,-3589,193);
	var_01[4] = (1500,-3589,193);
	var_01[5] = (1558,-3589,193);
	var_01[6] = (1675,-3729,193);
	var_01[7] = (1675,-3786,193);
	var_01[8] = (1675,-3842,193);
	var_01[9] = (974,-4344,200);
	var_01[10] = (944,-4344,200);
	foreach(var_03 in var_01)
	{
		var_04 = spawn("trigger_radius",var_03,0,7,7);
		var_00 = common_scripts\utility::array_add(var_00,var_04);
	}

	foreach(var_04 in var_00)
	{
		var_04 thread windowexploitledgelogicthink();
	}
}

//Function Number: 134
windowexploitledgelogicthink()
{
	level endon("game_ended");
	self endon("end_exploit_logic");
	for(;;)
	{
		self waittill("trigger",var_00);
		wait(1.5);
		if(isplayer(var_00))
		{
			var_01 = maps\mp\agents\_agent_utility::getactiveagentsoftype("all");
			foreach(var_03 in var_01)
			{
				var_04 = distance(var_00.origin,var_03.origin);
				if(var_04 < 75)
				{
					var_05 = vectornormalize(var_03.origin - var_00.origin * (1,1,0));
					var_00 setvelocity(var_05 * 100);
					break;
				}
			}
		}
	}
}

//Function Number: 135
alterjumpexploit(param_00)
{
	level endon("game_ended");
	var_01 = spawn("trigger_radius",param_00.origin,0,7,96);
	var_01 thread windowexploitledgelogicthink();
	param_00 waittill("placed",var_02);
	var_01 notify("end_exploit_logic");
	level waittill("sq_raise_altar");
	var_01 thread windowexploitledgelogicthink();
}

//Function Number: 136
shoveplayer()
{
	level endon("game_ended");
	var_00[0] = (1398.46,-3952.36,372);
	var_01 = spawn("trigger_radius",var_00[0],0,7,7);
	for(;;)
	{
		var_01 waittill("trigger",var_02);
		wait(1.5);
		if(isplayer(var_02))
		{
			var_03 = vectornormalize(var_02.origin + (-100,0,0) - var_02.origin * (1,1,0));
			var_02 setvelocity(var_03 * 300);
		}
	}
}

//Function Number: 137
trapelectricfloorfix()
{
	var_00[0] = (1658.76,-2277.19,150);
	if(level.nextgen)
	{
		var_01 = spawn("trigger_radius",var_00[0],0,196,6);
	}
	else
	{
		var_01 = getent("elec_trap_trigger","targetname");
	}

	var_01.script_noteworthy = "damage_over_time";
	var_01.script_count = 5;
	level.elec_trap_triggers = common_scripts\utility::array_add(level.elec_trap_triggers,var_01);
	level.elec_trap_fix_trigger = var_01;
}

//Function Number: 138
fixtrapfunc(param_00,param_01)
{
	if(param_01.script_noteworthy == "trap_electric_floor")
	{
		param_00 = common_scripts\utility::array_add(param_00,level.elec_trap_fix_trigger);
	}

	return param_00;
}