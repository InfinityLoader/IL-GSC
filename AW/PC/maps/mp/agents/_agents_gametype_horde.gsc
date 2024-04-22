/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\agents\_agents_gametype_horde.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 33
 * Decompile Time: 579 ms
 * Timestamp: 4/22/2024 2:08:22 AM
*******************************************************************/

//Function Number: 1
main()
{
	setup_callbacks();
	level thread runroundspawning();
	if(maps\mp\_utility::getmapname() == "mp_detroit")
	{
		level.goliathexploittrigger = spawn("trigger_radius",(-1662,-72,582.5),0,86,64);
	}
}

//Function Number: 2
setup_callbacks()
{
	level.agent_funcs["player"]["onAIConnect"] = ::onaiconnect;
	level.agent_funcs["player"]["think"] = ::enemyagentthink;
	level.agent_funcs["player"]["on_killed"] = ::onagentkilled;
	level.agent_funcs["squadmate"]["onAIConnect"] = ::onaiconnect;
	level.agent_funcs["squadmate"]["think"] = ::allyagentthink;
	level.agent_funcs["dog"]["onAIConnect"] = ::onaiconnect;
	level.agent_funcs["dog"]["think"] = ::agentdogthink;
	level.agent_funcs["dog"]["on_killed"] = ::ondogkilled;
}

//Function Number: 3
onaiconnect()
{
	self.gamemodefirstspawn = 1;
	self.agentname = &"HORDE_GRUNT";
	self.horde_type = "";
}

//Function Number: 4
runroundspawning()
{
	level endon("game_ended");
	for(;;)
	{
		level waittill("start_round");
		wait(2);
		if(maps\mp\_utility::getmapname() == "mp_prison_z" && level.currentroundnumber > 10)
		{
			runzombieround();
			continue;
		}

		runnormalround();
	}
}

//Function Number: 5
runnormalround()
{
	level childthread highlightlastenemies();
	while(level.currentenemycount < level.maxenemycount)
	{
		while(level.currentaliveenemycount < level.maxaliveenemycount)
		{
			createenemy();
			if(level.currentenemycount == level.maxenemycount)
			{
				break;
			}
		}

		level.wavefirstspawn = 0;
		level waittill("enemy_death");
	}
}

//Function Number: 6
runzombieround()
{
	level.zombiesdead = 0;
	level waittill("beginZombieSpawn");
	while(level.currentenemycount < level.maxenemycount)
	{
		while(level.currentaliveenemycount < level.maxaliveenemycount)
		{
			createenemy();
			wait(0.1);
		}

		level.wavefirstspawn = 0;
		level common_scripts\utility::waittill_any("enemy_death","go_zombie");
		level.zombiesdead++;
	}
}

//Function Number: 7
createenemy()
{
	if(level.maxdogcount > 1 && level.dogsalive < level.maxdogcount)
	{
		createdogenemy();
		return;
	}

	if(level.maxwarbirdcount > 0)
	{
		foreach(var_01 in level.players)
		{
			if(maps\mp\gametypes\_horde_util::isonhumanteam(var_01) && isalive(var_01))
			{
				level.maxwarbirdcount--;
				var_01 createwarbirdenemy();
				break;
			}
		}

		return;
	}

	if(level.maxdronecount > 0)
	{
		createdroneenemy();
		level.maxdronecount--;
		return;
	}

	createhumanoidenemy();
}

//Function Number: 8
createhumanoidenemy()
{
	var_00 = undefined;
	while(!isdefined(var_00))
	{
		var_00 = maps\mp\agents\_agents::add_humanoid_agent("player",level.enemyteam,"class1");
		if(isdefined(var_00))
		{
			level.currentenemycount++;
			level.currentaliveenemycount++;
		}

		wait 0.05;
	}
}

//Function Number: 9
createdogenemy()
{
	var_00 = undefined;
	while(!isdefined(var_00))
	{
		var_00 = maps\mp\agents\_agent_common::connectnewagent("dog",level.enemyteam);
		if(isdefined(var_00))
		{
			var_00 thread [[ var_00 maps\mp\agents\_agent_utility::agentfunc("spawn") ]]();
			var_00.awardpoints = 100;
			level.currentenemycount++;
			level.currentaliveenemycount++;
			level.dogsalive++;
		}

		wait 0.05;
	}
}

//Function Number: 10
createdroneenemy()
{
	thread waitingtospawndrone();
	level.currentenemycount++;
	level.currentaliveenemycount++;
}

//Function Number: 11
waitingtospawndrone()
{
	level.numdroneswaitingtospawn++;
	while(maps\mp\_utility::currentactivevehiclecount(2) >= maps\mp\_utility::maxvehiclesallowed())
	{
		wait(1);
	}

	level.numdroneswaitingtospawn--;
	wait 0.05;
	var_00 = maps\mp\gametypes\_horde_drones::hordecreatedrone(level.players[0],"assault_uav_horde",level.hordedronemodel);
	var_00 hudoutlineenable(level.enemyoutlinecolor,1);
	var_00.droneturret hudoutlineenable(level.enemyoutlinecolor,1);
	var_00.outlinecolor = level.enemyoutlinecolor;
}

//Function Number: 12
createwarbirdenemy()
{
	thread maps\mp\gametypes\_horde_warbird::hordecreatewarbird();
	handle_first_warbird();
}

//Function Number: 13
handle_first_warbird()
{
	if(!isdefined(level.first_warbird_spawned))
	{
		level.first_warbird_spawned = 1;
	}
	else
	{
		return;
	}

	while(!isdefined(level.spawnedwarbirds))
	{
		wait 0.05;
	}

	level.spawnedwarbirds[0] endon("death");
	level.spawnedwarbirds[0] endon("crashing");
	wait(30);
}

//Function Number: 14
playaispawneffect()
{
	playfx(level._effect["spawn_effect"],self.origin);
}

//Function Number: 15
highlightlastenemies()
{
	level endon("round_ended");
	for(;;)
	{
		level waittill("enemy_death");
		if(level.currentenemycount != level.maxenemycount)
		{
			continue;
		}

		if(level.currentaliveenemycount < 3)
		{
			foreach(var_01 in level.flying_attack_drones)
			{
				var_01 hudoutlineenable(level.enemyoutlinecolor,0);
				var_01.droneturret hudoutlineenable(level.enemyoutlinecolor,0);
				var_01.lasttwoenemies = 1;
			}

			foreach(var_04 in level.spawnedwarbirds)
			{
				if(isdefined(var_04.team) && var_04.team == "axis" && !isdefined(var_04.iscrashing) && var_04.iscrashing)
				{
					var_04 hudoutlineenable(level.enemyoutlinecolor,0);
					var_04.warbirdturret hudoutlineenable(level.enemyoutlinecolor,0);
					var_04.lasttwoenemies = 1;
				}
			}

			foreach(var_07 in level.characters)
			{
				if(maps\mp\gametypes\_horde_util::isonhumanteam(var_07))
				{
					continue;
				}

				if(maps\mp\_utility::isreallyalive(var_07) && !var_07 iscloaked())
				{
					var_07 hudoutlineenable(level.enemyoutlinecolor,0);
					var_07.outlinecolor = level.enemyoutlinecolor;
				}
			}

			setdvar("bg_compassShowEnemies",1);
			break;
		}
	}
}

//Function Number: 16
onagentkilled(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	if(!maps\mp\gametypes\_horde_util::isonhumanteam(self))
	{
		hordeenemykilled(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08);
	}

	self hudoutlinedisable();
	maps\mp\agents\_agents::on_humanoid_agent_killed_common(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,0);
	maps\mp\agents\_agent_utility::deactivateagent();
}

//Function Number: 17
ondogkilled(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	if(!maps\mp\gametypes\_horde_util::isonhumanteam(self))
	{
		hordeenemykilled(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08);
	}

	self hudoutlinedisable();
	maps\mp\killstreaks\_dog_killstreak::on_agent_dog_killed(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08);
}

//Function Number: 18
hordeenemykilled(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	level.currentaliveenemycount--;
	level.killssinceinteldrop++;
	level.killssinceammodrop++;
	if(level.objdefend)
	{
		maps\mp\gametypes\horde::checkdefendkill(self,param_01);
	}

	trackintelkills(param_04,param_03);
	level thread maps\mp\gametypes\horde::chancetospawnpickup(self);
	level notify("enemy_death",param_01,self);
	level.enemiesleft--;
	if(!level.zombiesstarted)
	{
		setomnvar("ui_horde_enemies_left",level.enemiesleft);
	}

	if(isplayer(param_01) && !level.zombiesstarted)
	{
		maps\mp\gametypes\_horde_util::awardhordekill(param_01);
		param_01 thread maps\mp\gametypes\_rank::xppointspopup("kill",self.awardpoints);
		level thread maps\mp\gametypes\_horde_util::hordeupdatescore(param_01,self.awardpoints);
		if(param_01 maps\mp\_utility::_hasperk("specialty_triggerhappy"))
		{
		}
	}

	if(isdefined(param_01) && isdefined(param_01.owner) && isplayer(param_01.owner) && isdefined(param_01.owner.killz))
	{
		maps\mp\gametypes\_horde_util::awardhordekill(param_01.owner);
		param_01.owner thread maps\mp\gametypes\_rank::xppointspopup("kill",self.awardpoints);
		level thread maps\mp\gametypes\_horde_util::hordeupdatescore(param_01.owner,self.awardpoints);
	}
}

//Function Number: 19
trackintelkills(param_00,param_01)
{
	if(level.isteamintelcomplete)
	{
		return;
	}

	if(param_00 == "none")
	{
		return;
	}

	if(maps\mp\_utility::ismeleemod(param_01))
	{
		level.nummeleekillsintel++;
	}

	if(!maps\mp\_utility::iskillstreakweapon(param_00) && param_01 == "MOD_HEAD_SHOT")
	{
		level.numheadshotsintel++;
	}

	if(maps\mp\_utility::iskillstreakweapon(param_00) && param_00 != level.intelminigun)
	{
		level.numkillstreakkillsintel++;
	}

	if(maps\mp\gametypes\_class::isvalidequipment(param_00,0) || maps\mp\gametypes\_class::isvalidoffhand(param_00,0))
	{
		level.numequipmentkillsintel++;
	}
}

//Function Number: 20
enemyagentthink()
{
	self endon("death");
	level endon("game_ended");
	self botsetflag("no_enemy_search",1);
	thread monitorbadhumanoidai();
	thread locateenemypositions();
}

//Function Number: 21
monitorbadhumanoidai()
{
	self endon("death");
	level endon("game_ended");
	var_00 = gettime();
	for(;;)
	{
		wait(5);
		if(!maps\mp\bots\_bots_util::bot_in_combat(120000))
		{
			if(!maps\mp\bots\_bots_util::bot_in_combat(240000))
			{
				break;
			}
		}

		if(checkexpiretime(var_00,240,480))
		{
			break;
		}
	}
}

//Function Number: 22
monitorbaddogai()
{
	self endon("death");
	level endon("game_ended");
	var_00 = gettime();
	var_01 = self.origin;
	var_02 = var_00;
	for(;;)
	{
		wait(5);
		var_03 = distancesquared(self.origin,var_01);
		var_04 = gettime() - var_02 / 1000;
		if(var_03 > 16384)
		{
			var_01 = self.origin;
			var_02 = gettime();
		}
		else if(var_04 > 25)
		{
			if(var_04 > 55)
			{
				break;
			}
		}

		if(checkexpiretime(var_00,120,240))
		{
			break;
		}
	}

	maps\mp\agents\_agent_utility::killagent(self);
}

//Function Number: 23
checkexpiretime(param_00,param_01,param_02)
{
	var_03 = gettime() - param_00 / 1000;
	if(var_03 > param_01)
	{
		if(var_03 > param_02)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 24
allyagentthink()
{
	self endon("death");
	level endon("game_ended");
	self endon("owner_disconnect");
	self botsetflag("force_sprint",1);
	var_00 = 0;
	var_01 = 0;
	for(;;)
	{
		if(float(self.owner.health) / self.owner.maxhealth < 0.5 && gettime() > var_01)
		{
			var_02 = getnodesinradiussorted(self.owner.origin,256,0);
			if(var_02.size >= 2)
			{
				self.defense_force_next_node_goal = var_02[1];
				self notify("defend_force_node_recalculation");
				var_01 = gettime() + 1000;
			}
		}
		else if(float(self.health) / self.maxhealth >= 0.6)
		{
			var_00 = 0;
		}
		else if(!var_00)
		{
			var_03 = maps\mp\bots\_bots_util::bot_find_node_to_guard_player(self.owner.origin,350,1);
			if(isdefined(var_03))
			{
				self.defense_force_next_node_goal = var_03;
				self notify("defend_force_node_recalculation");
				var_00 = 1;
			}
		}

		if(!maps\mp\bots\_bots_util::bot_is_guarding_player(self.owner))
		{
			var_04["override_goal_type"] = "critical";
			var_04["min_goal_time"] = 20;
			var_04["max_goal_time"] = 30;
			maps\mp\bots\_bots_strategy::bot_guard_player(self.owner,350,var_04);
		}

		wait(0.05);
	}
}

//Function Number: 25
hordesetupdogstate()
{
	self.enableextendedkill = 0;
	self.agentname = &"HORDE_QUAD";
	self.horde_type = "Quad";
	thread maps\mp\gametypes\horde::hordeapplyaimodifiers();
	self.lassetgoalpos = (0,0,0);
	self.bhasnopath = 0;
	self.randompathstoptime = 0;
	self.maxhealth = 60;
	self.health = self.maxhealth;
}

//Function Number: 26
agentdogthink()
{
	self endon("death");
	level endon("game_ended");
	self endon("owner_disconnect");
	maps\mp\agents\dog\_dog_think::setupdogstate();
	hordesetupdogstate();
	thread locateenemypositions();
	self thread [[ self.watchattackstatefunc ]]();
	thread waitforbadpathhorde();
	thread monitorbaddogai();
	thread agentdogbark();
	for(;;)
	{
		if(self.aistate != "melee" && !self.statelocked && maps\mp\agents\dog\_dog_think::readytomeleetarget() && !maps\mp\agents\dog\_dog_think::didpastmeleefail())
		{
			self scragentbeginmelee(self.curmeleetarget);
		}

		if(self.randompathstoptime > gettime())
		{
			wait(0.05);
			continue;
		}

		if(!isdefined(self.enemy) || self.bhasnopath)
		{
			var_00 = getnodesinradiussorted(self.origin,1024,256,128,"Path");
			if(var_00.size > 0)
			{
				var_01 = randomintrange(int(var_00.size * 0.9),var_00.size);
				self scragentsetgoalpos(var_00[var_01].origin);
				self.bhasnopath = 0;
				self.randompathstoptime = gettime() + 2500;
			}
		}
		else
		{
			var_02 = maps\mp\agents\dog\_dog_think::getattackpoint(self.enemy);
			self.curmeleetarget = self.enemy;
			self.movemode = "sprint";
			self.barrivalsenabled = 0;
			if(distancesquared(var_02,self.lassetgoalpos) > 4096)
			{
				self scragentsetgoalpos(var_02);
				self.lassetgoalpos = var_02;
			}
		}

		wait(0.05);
	}
}

//Function Number: 27
agentdogbark()
{
	self endon("death");
	level endon("game_ended");
	for(;;)
	{
		while(!isdefined(self.curmeleetarget))
		{
			wait(0.25);
		}

		while(isdefined(self.curmeleetarget) && distance(self.origin,self.curmeleetarget.origin) > 200)
		{
			wait(randomfloatrange(0,2));
			self playsound("anml_doberman_bark");
		}

		wait(0.05);
	}
}

//Function Number: 28
waitforbadpathhorde()
{
	self endon("death");
	level endon("game_ended");
	for(;;)
	{
		self waittill("bad_path",var_00);
		self.bhasnopath = 1;
	}
}

//Function Number: 29
locateenemypositions()
{
	self endon("death");
	level endon("game_ended");
	for(;;)
	{
		foreach(var_01 in level.participants)
		{
			if(maps\mp\gametypes\_horde_util::isonhumanteam(var_01))
			{
				self getenemyinfo(var_01);
				if(isdefined(var_01.hordedrone))
				{
					self getenemyinfo(var_01.hordedrone);
				}
			}
		}

		wait(0.5);
	}
}

//Function Number: 30
findclosestplayer()
{
	var_00 = undefined;
	var_01 = 1410065408;
	foreach(var_03 in level.players)
	{
		if(maps\mp\_utility::isreallyalive(var_03) && maps\mp\gametypes\_horde_util::isonhumanteam(var_03) && !maps\mp\gametypes\_horde_util::isplayerinlaststand(var_03))
		{
			var_04 = distancesquared(var_03.origin,self.origin);
			if(var_04 < var_01)
			{
				var_00 = var_03;
				var_01 = var_04;
			}
		}
	}

	return var_00;
}

//Function Number: 31
handledetroitgoliathtrailerexploit()
{
	self endon("death");
	level endon("game_ended");
	wait(1);
	for(;;)
	{
		if(isdefined(self.enemy) && self.enemy istouching(level.goliathexploittrigger))
		{
			self botsetscriptgoal((-1696,-408,608.5),32,"critical",200);
			while(isdefined(self.enemy) && maps\mp\_utility::isreallyalive(self.enemy) && !maps\mp\gametypes\_horde_util::isplayerinlaststand(self.enemy) && self.enemy istouching(level.goliathexploittrigger))
			{
				wait(0.25);
			}

			self botclearscriptgoal();
		}

		wait(1);
	}
}

//Function Number: 32
hordejuggrocketswarmthink()
{
	self endon("death");
	level endon("game_ended");
	while(!isdefined(self.enemy) || !sighttracepassed(self gettagorigin("TAG_ROCKET4"),self.enemy geteye(),0,undefined))
	{
		wait(0.05);
	}

	wait(randomintrange(5,10));
	for(;;)
	{
		while(!isdefined(self.enemy) || !sighttracepassed(self gettagorigin("TAG_ROCKET4"),self.enemy geteye(),0,undefined))
		{
			wait(0.05);
		}

		var_00 = anglestoforward(self getplayerangles());
		var_01 = anglestoright(self getplayerangles());
		var_02 = [(0,0,50),(0,0,20),(10,0,0),(0,10,0)];
		var_03 = self gettagorigin("TAG_ROCKET4");
		playfxontag(common_scripts\utility::getfx("swarm_rocket_wv"),self,"TAG_ROCKET4");
		for(var_04 = 0;var_04 < 4;var_04++)
		{
			var_05 = var_03 + var_00 * 20 + var_01 * -30;
			var_06 = var_00 + maps\mp\killstreaks\_juggernaut::random_vector(0.2);
			var_07 = magicbullet("iw5_juggernautrockets_mp",var_03,self.enemy geteye(),self);
			var_07 thread rockettargetent(self.enemy,var_02[var_04]);
			var_07 thread maps\mp\killstreaks\_juggernaut::rocketdestroyaftertime(7);
			wait(0.1);
		}

		wait(randomintrange(10,20));
	}
}

//Function Number: 33
rockettargetent(param_00,param_01)
{
	if(isdefined(param_00))
	{
		self missile_settargetent(param_00,param_01);
	}
}