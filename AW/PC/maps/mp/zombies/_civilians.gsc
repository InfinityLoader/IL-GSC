/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\zombies\_civilians.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 39
 * Decompile Time: 612 ms
 * Timestamp: 4/22/2024 2:13:35 AM
*******************************************************************/

//Function Number: 1
init()
{
	while(!isdefined(level.struct_class_names))
	{
		wait(0.05);
	}

	level.agent_funcs["zombie_civilian"] = level.agent_funcs["player"];
	level.agent_funcs["zombie_civilian"]["onAIConnect"] = ::oncivaiconnect;
	level.agent_funcs["zombie_civilian"]["on_killed"] = ::oncivkilled;
	level.agent_funcs["zombie_civilian"]["on_damaged"] = ::oncivdamaged;
	level.agent_funcs["zombie_civilian"]["on_damaged_finished"] = ::oncivdamagefinished;
	level.agent_funcs["zombie_civilian"]["spawn"] = ::onzombiecivilianspawn;
	level.agent_funcs["zombie_civilian"]["think"] = ::zombiecivilianthink;
	level.zombies_spawners_civ = common_scripts\utility::getstructarray("civ_spawner","targetname");
	var_00 = spawnstruct();
	var_00.agent_type = "zombie_civilian";
	var_00.animclass = "zombie_civilian_animclass";
	var_00.health_scale = 1;
	var_00.meleedamage = 5;
	buildbodies(var_00);
	createthreatbiasgroup("zombie_civilians");
	var_01 = maps\mp\zombies\_util::getnumplayers();
	if(var_01 == 1)
	{
		setthreatbias("zombie_civilians","zombies",100);
	}
	else
	{
		setthreatbias("zombie_civilians","zombies",500);
	}

	maps\mp\zombies\_util::agentclassregister(var_00,"zombie_civilian");
	level.currentmaxenemycountfunc["civilian"] = ::civilianroundmaxnumenemies;
	level.extractioninitfuncs["default"] = ::defaultextractioninit;
	level.extractionescortfuncs["default"] = ::defaultextractionescort;
	level.extractionfuncs["default"] = ::defaultextraction;
	level.numberofalivecivilians = 0;
	level.civiliancowerpoints = common_scripts\utility::getstructarray("cower_point","script_noteworthy");
	level._effect["Extraction_Flare"] = loadfx("vfx/props/flare_ambient");
	level.civiliansextracting = 0;
	level.civiliansrescued = 0;
}

//Function Number: 2
precachestrings()
{
	precachestring(&"ZOMBIE_CIVILIANS_SURVIVOR");
	precachestring(&"ZOMBIE_CIVILIANS_RESCUE_START");
	precachestring(&"ZOMBIE_CIVILIANS_RESCUE_FAIL");
	precachestring(&"ZOMBIE_CIVILIANS_RESCUE_SUCCESS");
	precachestring(&"ZOMBIE_CIVILIANS_SUCCESS_END_ROUND");
	precachestring(&"ZOMBIE_CIVILIANS_FAIL_END_ROUND");
	precachestring(&"ZOMBIE_CIVILIANS_POWER_RESTORED");
	precachestring(&"ZOMBIE_CIVILIANS_INCOMING_UPGRADE");
	precachestring(&"ZOMBIE_CIVILIANS_POWER_OFF_TRIGGER");
	precachestring(&"ZOMBIE_CIVILIANS_SUCCESS_SILVER_END_ROUND");
	precachestring(&"ZOMBIE_CIVILIANS_SUCCESS_GOLD_END_ROUND");
}

//Function Number: 3
buildbodies(param_00)
{
	if(level.nextgen)
	{
		var_01[0] = ["civ_urban_male_body_a_dlc2","civ_urban_male_body_c_dlc2","civ_urban_male_body_d_dlc2","civ_urban_male_body_e_dlc2"];
		var_02[0] = ["head_m_gen_cau_anderson","head_m_gen_cau_clark","head_m_act_cau_ramsay_base"];
		var_01[1] = ["civ_brg_employee_dlc2"];
		var_02[1] = ["head_m_gen_cau_anderson","head_m_gen_cau_clark","head_m_act_cau_ramsay_base"];
	}
	else
	{
		var_01[0] = ["civ_urban_male_body_a_dlc2"];
		param_00[0] = ["head_m_gen_cau_anderson","head_m_gen_cau_clark","head_m_act_cau_ramsay_base"];
		var_01[1] = ["civ_brg_employee_dlc2"];
		var_02[1] = ["head_m_gen_cau_anderson","head_m_gen_cau_clark","head_m_act_cau_ramsay_base"];
	}

	param_00.model_bodies = var_01;
	param_00.model_heads = var_02;
}

//Function Number: 4
oncivaiconnect()
{
	self.agentname = &"ZOMBIE_CIVILIANS_SURVIVOR";
	self allowprone(0);
	self.traversecost = 3;
}

//Function Number: 5
spawncivilian(param_00,param_01)
{
	level endon("zombie_wave_interrupt");
	var_02 = maps\mp\zombies\_util::agentclassget(param_00);
	var_03 = getcenterofplayers();
	if(!isdefined(level.civ_extract.spawnpoint))
	{
		return;
	}

	if(!isdefined(var_02))
	{
		return;
	}

	var_04 = 36864;
	var_05 = 1;
	var_06 = gettime() + 90000;
	iprintlnbold(&"ZOMBIE_CIVILIANS_RESCUE_START");
	if(isdefined(level.civ_extract.spawnpoint.target))
	{
		var_07 = common_scripts\utility::getstruct(level.civ_extract.spawnpoint.target,"targetname");
	}
	else
	{
		var_07 = level.civ_extract.spawnpoint;
	}

	var_08 = spawn("script_model",var_07.origin);
	var_08 setmodel("tag_origin");
	thread killicononroundskip(var_08);
	foreach(var_0A in level.players)
	{
		if(var_0A.sessionstate == "spectator")
		{
			continue;
		}

		var_08.headicon = var_08 maps\mp\_entityheadicons::setheadicon(var_0A,"hud_waypoint_survivor",(0,0,16),4,4,undefined,undefined,undefined,1,undefined,0);
	}

	level.waitingforcivilianspawn = 1;
	while(var_05 == 1)
	{
		foreach(var_0A in level.players)
		{
			if(distance2dsquared(var_07.origin,var_0A.origin) < var_04 && abs(var_0A.origin[2] - var_07.origin[2]) < 128)
			{
				var_05 = 2;
				break;
			}
		}

		if(gettime() >= var_06)
		{
			var_05 = 3;
		}

		wait 0.05;
	}

	level.waitingforcivilianspawn = undefined;
	if(isdefined(var_08.headicon))
	{
		var_08.headicon destroy();
		var_08 delete();
	}

	if(var_05 == 3)
	{
		level notify("extraction_failed");
		iprintlnbold(&"ZOMBIE_CIVILIANS_RESCUE_FAIL");
		return;
	}

	var_0E = maps\mp\zombies\_util::spawnscriptagent(level.civ_extract.spawnpoint,var_02,level.playerteam);
	if(var_0E.model == "civ_brg_employee_dlc2")
	{
		var_0E thread maps\mp\mp_zombie_brg::burgertownemployeeattachhat();
	}

	level notify("civilian_spawned",var_0E);
	if(!isdefined(var_0E))
	{
		return;
	}

	var_0E thermaldrawdisable();
	var_0F = maps\mp\zombies\_util::getnumplayers();
	if(var_0F == 1)
	{
		var_10 = int(var_02.roundhealth * 2.5);
	}
	else
	{
		var_10 = var_03.roundhealth;
	}

	var_0E maps\mp\agents\_agent_common::set_agent_health(var_10);
	var_0E.meleedamage = var_02.meleedamage;
	var_0E maps\mp\zombies\_util::zombies_make_objective("compass_objpoint_ammo_friendly");
	var_0E scragentsetspecies("civilian");
	var_0E maps\mp\_utility::giveperk("specialty_coldblooded",0);
	return var_0E;
}

//Function Number: 6
civilianroundmaxnumenemies(param_00)
{
	if(level.players.size > 1 || level.civiliansextracting > 0 || level.numberofalivecivilians <= 0)
	{
		return param_00;
	}

	return int(param_00 * 0.75);
}

//Function Number: 7
killicononroundskip(param_00)
{
	level endon("game_ended");
	level endon("civilian_spawned");
	level waittill("zombie_wave_interrupt");
	if(isdefined(param_00))
	{
		param_00.headicon destroy();
		param_00 delete();
	}
}

//Function Number: 8
getcenterofplayers()
{
	var_00 = (0,0,0);
	foreach(var_02 in level.players)
	{
		var_00 = var_00 + var_02.origin;
	}

	var_00 = var_00 / level.players.size;
	return var_00;
}

//Function Number: 9
onzombiecivilianspawn(param_00,param_01,param_02)
{
	maps\mp\zombies\_util::onspawnscriptagenthumanoid(param_00,param_01,param_02);
	thread interestmonitor();
	self.idlestateoverridefunc = ::determineidlestate;
	level.numberofalivecivilians++;
	self setthreatbiasgroup("zombie_civilians");
	self.movemode = "walk";
}

//Function Number: 10
interestmonitor()
{
	self endon("death");
	level endon("game_ended");
	var_00 = 262144;
	var_01 = 2.5;
	for(;;)
	{
		if(!isdefined(self.targetofinterest) || distancesquared(self.origin,self.targetofinterest.origin) > var_00)
		{
			var_02 = findfirstenemyinradius(var_00,1);
			if(isdefined(var_02))
			{
				self.targetofinterest = var_02;
				wait(var_01);
			}
		}

		wait(0.1);
	}
}

//Function Number: 11
findfirstenemyinradius(param_00,param_01)
{
	var_02 = maps\mp\agents\_agent_utility::getactiveagentsoftype("all");
	foreach(var_04 in var_02)
	{
		if(!isenemyteam(self.team,var_04.team))
		{
			continue;
		}

		if(!param_01 && isdefined(self.dismember_crawl) && self.dismember_crawl)
		{
			continue;
		}

		if(distancesquared(self.origin,var_04.origin) < param_00)
		{
			return var_04;
		}
	}

	return undefined;
}

//Function Number: 12
getnumberofenemiesinradius(param_00,param_01)
{
	var_02 = 128;
	var_03 = maps\mp\agents\_agent_utility::getactiveagentsoftype("all");
	var_04 = 0;
	foreach(var_06 in var_03)
	{
		if(!isenemyteam(self.team,var_06.team))
		{
			continue;
		}

		if(!param_01 && isdefined(self.dismember_crawl) && self.dismember_crawl)
		{
			continue;
		}

		if(abs(self.origin[2] - var_06.origin[2]) > var_02)
		{
			continue;
		}

		if(distancesquared(self.origin,var_06.origin) < param_00)
		{
			var_04++;
		}
	}

	return var_04;
}

//Function Number: 13
getpercentageofplayersinradius(param_00)
{
	var_01 = 0;
	foreach(var_03 in level.players)
	{
		if(maps\mp\zombies\_util::isplayerinlaststand(var_03))
		{
			continue;
		}

		if(distancesquared(self.origin,var_03.origin) < param_00)
		{
			var_01++;
		}
	}

	return float(var_01 / level.players.size);
}

//Function Number: 14
determineidlestate()
{
	if(isdefined(self.targetofinterest))
	{
		return "idle_combat";
	}

	return "idle_noncombat";
}

//Function Number: 15
setupcivilianstate()
{
	maps\mp\agents\humanoid\_humanoid::setuphumanoidstate();
	self.isbeingescorted = 0;
	self.stoprequested = 0;
	self.extracting = 0;
	thread civilianmovementrate();
}

//Function Number: 16
zombiecivilianthink()
{
	self endon("death");
	level endon("game_ended");
	setupcivilianstate();
	var_00 = self.origin;
	self.targetextractpoint = level.civ_extract.extractpoint;
	if(isdefined(self.targetextractpoint.script_parameters) && isdefined(level.extractionfuncs[self.targetextractpoint.script_parameters]))
	{
		var_01 = self.targetextractpoint.script_parameters;
	}
	else
	{
		var_01 = "default";
	}

	self notify("begin_extraction_init");
	[[ level.extractionescortfuncs[var_01] ]]();
	thread maps\mp\zombies\_util::waitforbadpath();
	thread enemyproximitymonitor();
	var_02 = spawn("script_model",self.targetextractpoint.origin + (0,0,2));
	var_02 setmodel("viewmodel_flare");
	var_02.angles = (90,randomfloatrange(-180,180),0);
	maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("Extraction_Flare"),var_02,"TAG_FIRE_FX",0);
	var_02 playloopsound("zmb_civ_extraction_flare_lp");
	thread flarefxcleanup(var_02);
	for(;;)
	{
		if(self.extracting)
		{
			break;
		}

		if(shouldstartmoving())
		{
			thread movetoextractpoint();
		}
		else if(shouldstopmoving())
		{
			thread stopmoving();
		}
		else if(isdefined(self.nearbyenemy))
		{
			attempttomeleeenemy();
		}

		wait 0.05;
	}

	if(isalive(self))
	{
		common_scripts\utility::waittill_any("extraction_complete","death");
	}
}

//Function Number: 17
movetoextractpoint()
{
	self endon("civilian_stop");
	self endon("death");
	level endon("game_ended");
	self.isbeingescorted = 1;
	self.lastplayerproximitytime = gettime();
	if(isdefined(self.targetextractpoint.script_parameters) && isdefined(level.extractionfuncs[self.targetextractpoint.script_parameters]))
	{
		var_00 = self.targetextractpoint.script_parameters;
	}
	else
	{
		var_00 = "default";
	}

	self notify("begin_extraction_escort");
	[[ level.extractionescortfuncs[var_00] ]]();
	self scragentsetgoalradius(64);
	var_01 = self.targetextractpoint;
	self.badpathresults = 0;
	for(;;)
	{
		for(;;)
		{
			self scragentsetgoalpos(self.targetextractpoint.origin);
			var_02 = common_scripts\utility::waittill_any_return("goal","goal_reached","bad_path","close_enemy");
			if(var_02 == "goal" || var_02 == "goal_reached" && distance(self.origin,self.targetextractpoint.origin) < 64)
			{
				break;
			}
		}

		break;
	}

	if(var_02 == "goal" || var_02 == "goal_reached" && distance(self.origin,self.targetextractpoint.origin) < 64)
	{
		self.targetextractpoint = var_01;
		thread startextraction();
		return;
	}

	if(var_02 == "bad_path")
	{
		self.badpathresults++;
		if(self.badpathresults >= 3)
		{
			self.stoprequested = 1;
			return;
		}
	}
}

//Function Number: 18
flarefxcleanup(param_00)
{
	level common_scripts\utility::waittill_any("extraction_complete","extraction_failed");
	maps\mp\zombies\_util::killfxontagnetwork(common_scripts\utility::getfx("Extraction_Flare"),param_00,"TAG_FIRE_FX");
	param_00 stoploopsound();
	wait(10);
	param_00 delete();
}

//Function Number: 19
attempttomeleeenemy()
{
	if(!isdefined(self.nextvalidmeleetime))
	{
		self.nextvalidmeleetime = calculatenextmeleetime();
	}

	if(gettime() >= self.nextvalidmeleetime)
	{
		self.curmeleetarget = self.nearbyenemy;
		self.hastraversed = 1;
		maps\mp\zombies\_behavior::humanoid_begin_melee();
		self.nextvalidmeleetime = calculatenextmeleetime();
	}
}

//Function Number: 20
calculatenextmeleetime()
{
	var_00 = 1000;
	var_01 = 3000;
	return gettime() + randomintrange(var_00,var_01);
}

//Function Number: 21
enemyproximitymonitor()
{
	self endon("begin_extraction");
	level endon("game_ended");
	wait 0.05;
	var_00 = maps\mp\zombies\_util::getnumplayers();
	if(var_00 == 1)
	{
		var_01 = 4096;
	}
	else
	{
		var_01 = 16384;
	}

	for(;;)
	{
		var_02 = findfirstenemyinradius(var_01,0);
		var_03 = getnumberofenemiesinradius(var_01,0);
		var_04 = getpercentageofplayersinradius(180000);
		if(var_03 > var_04 * 3)
		{
			self.stoprequested = 1;
		}
		else
		{
			self.stoprequested = 0;
		}

		if(!isdefined(self.nearbyenemy))
		{
			self.nextvalidmeleetime = calculatenextmeleetime();
		}

		self.nearbyenemy = var_02;
		wait(0.2);
	}
}

//Function Number: 22
stopmoving()
{
	self endon("death");
	level endon("game_ended");
	self.isbeingescorted = 0;
	self notify("civilian_stop");
	wait 0.05;
	self scragentsetgoalpos(self.origin);
	self scragentsetgoalradius(4096);
	thread movetocowerlocation();
}

//Function Number: 23
movetocowerlocation()
{
	self endon("begin_extraction_escort");
	self endon("death");
	level endon("game_ended");
	var_00 = 262144;
	if(self.stoprequested)
	{
		return;
	}

	var_01 = [];
	foreach(var_03 in level.civiliancowerpoints)
	{
		var_04 = vectordot(self.targetextractpoint.origin - self.origin,var_03.origin - self.origin);
		if(var_04 < 0)
		{
			continue;
		}

		var_05 = distancesquared(var_03.origin,self.origin);
		if(var_05 < var_00)
		{
			var_01[var_01.size] = var_03;
		}
	}

	if(var_01.size == 0)
	{
		return;
	}

	var_07 = undefined;
	foreach(var_03 in var_01)
	{
		if(getpathdist(self.origin,var_03.origin) > -1)
		{
			var_07 = var_03;
			break;
		}

		wait 0.05;
	}

	if(!isdefined(var_07))
	{
		return;
	}

	for(;;)
	{
		self scragentsetgoalpos(var_07.origin);
		self scragentsetgoalradius(64);
		var_0A = common_scripts\utility::waittill_any_return("goal","goal_reached","bad_path","civilian_stop");
		if(var_0A == "goal" || var_0A == "goal_reached")
		{
			break;
		}

		if(var_0A == "bad_path")
		{
			break;
		}

		while(var_0A == "civilian_stop" && self.stoprequested)
		{
			wait 0.05;
		}
	}
}

//Function Number: 24
shouldstartmoving()
{
	if(self.isbeingescorted)
	{
		return 0;
	}

	return !self.stoprequested && areplayerswithinrange(65536);
}

//Function Number: 25
shouldstopmoving()
{
	if(!self.isbeingescorted)
	{
		return 0;
	}

	if(self.stoprequested)
	{
		return 1;
	}

	var_00 = distancesquared(self.origin,self.targetextractpoint.origin);
	if(var_00 < 262144)
	{
		return 0;
	}

	var_01 = gettime();
	var_02 = areplayerswithinrange(180000);
	if(var_02)
	{
		self.lastplayerproximitytime = var_01;
		return 0;
	}

	return var_01 > self.lastplayerproximitytime + 3000;
}

//Function Number: 26
registerextractioninitevent(param_00,param_01)
{
	level.extractioninitfuncs[param_00] = param_01;
}

//Function Number: 27
registerextractionescortevent(param_00,param_01)
{
	level.extractionescortfuncs[param_00] = param_01;
}

//Function Number: 28
registerextractionevent(param_00,param_01)
{
	level.extractionfuncs[param_00] = param_01;
}

//Function Number: 29
startextraction()
{
	maps\mp\zombies\_util::zombies_make_nonobjective();
	if(isdefined(self.targetextractpoint.script_parameters) && isdefined(level.extractionfuncs[self.targetextractpoint.script_parameters]))
	{
		var_00 = self.targetextractpoint.script_parameters;
	}
	else
	{
		var_00 = "default";
	}

	self notify("begin_extraction");
	self.extracting = 1;
	level.civiliansextracting++;
	thread extractioncleanup();
	[[ level.extractionfuncs[var_00] ]]();
}

//Function Number: 30
defaultextractioninit()
{
}

//Function Number: 31
defaultextractionescort()
{
}

//Function Number: 32
defaultextraction()
{
	level notify("extraction_complete");
}

//Function Number: 33
extractioncleanup()
{
	level endon("extraction_failed");
	level waittill("extraction_complete");
	iprintlnbold(&"ZOMBIE_CIVILIANS_RESCUE_SUCCESS");
	if(maps\mp\gametypes\_hostmigration::waittillhostmigrationdone())
	{
		wait(0.05);
	}

	level.numberofalivecivilians--;
	level.civiliansextracting--;
	level.civiliansrescued++;
	givecivilianachievement();
	self notify("extraction_complete");
	self.bypasscorpse = 1;
	level waittill("extraction_sequence_complete");
	self suicide();
}

//Function Number: 34
givecivilianachievement()
{
	switch(level.civiliansrescued)
	{
		case 1:
			maps\mp\gametypes\zombies::giveplayerszombieachievement("DLC2_ZOMBIE_RESCUE1");
			break;

		case 4:
			maps\mp\gametypes\zombies::giveplayerszombieachievement("DLC2_ZOMBIE_RESCUE4");
			break;

		default:
			break;
	}

	foreach(var_01 in level.players)
	{
		if(!isdefined(var_01.numcivilianslifetimetotal))
		{
			var_01.numcivilianslifetimetotal = var_01 getcoopplayerdatareservedint("civiliansRescued");
		}

		if(var_01.numcivilianslifetimetotal + level.civiliansrescued >= 20)
		{
			var_01 maps\mp\gametypes\zombies::givezombieachievement("DLC2_ZOMBIE_RESCUE20");
		}
	}
}

//Function Number: 35
areplayerswithinrange(param_00)
{
	foreach(var_02 in level.players)
	{
		if(!isalive(var_02))
		{
			continue;
		}

		if(distance2dsquared(self.origin,var_02.origin) < param_00)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 36
oncivdamagefinished(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	maps\mp\agents\_agents::agent_damage_finished(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09);
	if(isalive(self) && self.health < self.maxhealth * 0.4)
	{
		self hudoutlineenable(0,0);
	}
}

//Function Number: 37
oncivkilled(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	self hudoutlinedisable();
	maps\mp\zombies\_util::zombies_make_nonobjective();
	self clearperks();
	if(!isdefined(self.extractionsuccessful))
	{
		level notify("extraction_failed");
		level.numberofalivecivilians--;
		level.civiliansextracting--;
		iprintlnbold(&"ZOMBIE_CIVILIANS_RESCUE_FAIL");
	}

	self hudoutlinedisable();
	if(isdefined(self.headicon))
	{
		self.headicon destroy();
	}

	maps\mp\zombies\_util::onscriptagentkilled(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08);
}

//Function Number: 38
oncivdamaged(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	if(maps\mp\zombies\_util::isonhumanteam(param_01))
	{
		return;
	}

	if(isdefined(self.extractionsuccessful))
	{
		return;
	}

	maps\mp\agents\_agents::on_agent_generic_damaged(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09);
}

//Function Number: 39
civilianmovementrate()
{
	self.moveratescale = 1.2;
	self.nonmoveratescale = 1.2;
	self.traverseratescale = 1.2;
}