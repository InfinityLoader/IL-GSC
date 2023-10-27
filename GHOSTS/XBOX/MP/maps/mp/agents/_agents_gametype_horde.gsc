/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\agents\_agents_gametype_horde.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 26
 * Decompile Time: 459 ms
 * Timestamp: 10/27/2023 1:28:06 AM
*******************************************************************/

//Function Number: 1
func_4FDD()
{
	func_710C();
	level thread func_69A7();
}

//Function Number: 2
func_710C()
{
	level.agent_funcs["player"]["onAIConnect"] = ::onaiconnect;
	level.agent_funcs["player"]["think"] = ::func_2F11;
	level.agent_funcs["player"]["on_killed"] = ::onagentkilled;
	level.agent_funcs["squadmate"]["onAIConnect"] = ::onaiconnect;
	level.agent_funcs["squadmate"]["think"] = ::allyagentthink;
	level.agent_funcs["dog"]["onAIConnect"] = ::onaiconnect;
	level.agent_funcs["dog"]["think"] = ::agentdogthink;
	level.agent_funcs["dog"]["on_killed"] = ::func_5919;
}

//Function Number: 3
onaiconnect()
{
	self.gamemodefirstspawn = 1;
	self.agentname = &"HORDE_INFECTED";
	self.horde_type = "";
}

//Function Number: 4
func_69A7()
{
	level endon("game_ended");
	for(;;)
	{
		level waittill("start_round");
		if(maps\mp\gametypes\_horde_util::func_496C())
		{
			func_69AA();
			continue;
		}

		func_699D();
	}
}

//Function Number: 5
func_69AA()
{
	maps\mp\gametypes\_horde_crates::func_6990();
}

//Function Number: 6
func_699D()
{
	level childthread func_421A();
	while(level.currentenemycount < level.maxenemycount)
	{
		while(level.currentaliveenemycount < level.maxaliveenemycount)
		{
			func_20DD();
			if(level.currentenemycount == level.maxenemycount)
			{
				break;
			}
		}

		level waittill("enemy_death");
	}
}

//Function Number: 7
func_20DD()
{
	if(maps\mp\gametypes\_horde_util::func_48AE() && randomintrange(1,101) < level.chancetospawndog)
	{
		createdogenemy();
	}

	createhumanoidenemy();
}

//Function Number: 8
createhumanoidenemy()
{
	var_00 = undefined;
	while(!isdefined(var_00))
	{
		var_00 = maps/mp/agents/_agents::add_humanoid_agent("player",level.enemyteam,"class1");
		if(isdefined(var_00))
		{
			level.currentenemycount++;
			level.currentaliveenemycount++;
		}

		common_scripts\utility::func_8AFE();
	}
}

//Function Number: 9
createdogenemy()
{
	var_00 = undefined;
	while(!isdefined(var_00))
	{
		var_00 = maps/mp/agents/_agent_common::func_1EBE("dog",level.enemyteam);
		if(isdefined(var_00))
		{
			var_00 thread [[ var_00 maps/mp/agents/_agent_utility::agentfunc("spawn") ]]();
			level.currentenemycount++;
			level.currentaliveenemycount++;
		}

		common_scripts\utility::func_8AFE();
	}
}

//Function Number: 10
func_5D3F()
{
	playfx(level._effect["spawn_effect"],self.origin);
}

//Function Number: 11
func_421A()
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
			foreach(var_01 in level.characters)
			{
				if(maps\mp\gametypes\_horde_util::isonhumanteam(var_01))
				{
					continue;
				}

				if(maps\mp\_utility::func_4945(var_01))
				{
					var_01 hudoutlineenable(level.enemyoutlinecolor,0);
					var_01.outlinecolor = level.enemyoutlinecolor;
				}
			}

			break;
		}
	}
}

//Function Number: 12
onagentkilled(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	if(!maps\mp\gametypes\_horde_util::isonhumanteam(self))
	{
		func_42B1(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08);
	}

	self hudoutlinedisable();
	maps/mp/agents/_agents::func_58E5(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,0);
	maps/mp/agents/_agent_utility::func_233F();
}

//Function Number: 13
func_5919(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	if(!maps\mp\gametypes\_horde_util::isonhumanteam(self))
	{
		func_42B1(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08);
	}

	self hudoutlinedisable();
	maps\mp\killstreaks\_dog_killstreak::func_58D5(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08);
}

//Function Number: 14
func_42B1(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	level.currentaliveenemycount--;
	func_9511(param_04,param_03);
	level thread maps/mp/gametypes/horde::chancetospawnpickup(self);
	level notify("enemy_death");
	if(isplayer(param_01))
	{
		maps\mp\gametypes\_horde_util::func_8F93(param_01);
		if(param_01 maps\mp\_utility::_hasperk("specialty_triggerhappy"))
		{
			param_01 thread maps\mp\perks\_perkfunctions::func_70E9();
		}
	}

	if(isdefined(param_01) && isdefined(param_01.owner) && isplayer(param_01.owner) && isdefined(param_01.owner.killz))
	{
		maps\mp\gametypes\_horde_util::func_8F93(param_01.owner);
	}
}

//Function Number: 15
func_9511(param_00,param_01)
{
	if(level.isteamintelcomplete)
	{
	}

	if(param_00 == "none")
	{
	}

	if(param_01 == "MOD_MELEE")
	{
		level.nummeleekillsintel++;
	}

	if(!maps\mp\_utility::func_48F7(param_00) && param_01 == "MOD_HEAD_SHOT")
	{
		level.numheadshotsintel++;
	}

	if(maps\mp\_utility::func_48F7(param_00) && param_00 != level.intelminigun)
	{
		level.numkillstreakkillsintel++;
	}

	if(maps\mp\gametypes\_class::func_499E(param_00,0) || maps\mp\gametypes\_class::func_49A2(param_00,0))
	{
		level.numequipmentkillsintel++;
	}
}

//Function Number: 16
func_2F11()
{
	self endon("death");
	level endon("game_ended");
	self botsetflag("no_enemy_search",1);
	thread func_5372();
	thread func_4EB9();
}

//Function Number: 17
func_5372()
{
	self endon("death");
	level endon("game_ended");
	var_00 = gettime();
	for(;;)
	{
		wait(5);
		if(!maps/mp/bots/_bots_util::bot_in_combat(120000))
		{
			func_5A53(self);
			if(!maps/mp/bots/_bots_util::bot_in_combat(240000))
			{
				break;
			}
		}

		if(checkexpiretime(var_00,240,480))
		{
			break;
		}
	}

	maps/mp/agents/_agent_utility::func_4B0B(self);
}

//Function Number: 18
func_5371()
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
			func_5A53(self);
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

	maps/mp/agents/_agent_utility::func_4B0B(self);
}

//Function Number: 19
checkexpiretime(param_00,param_01,param_02)
{
	var_03 = gettime() - param_00 / 1000;
	if(var_03 > param_01)
	{
		func_5A53(self);
		if(var_03 > param_02)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 20
func_5A53(param_00)
{
	param_00 hudoutlineenable(level.enemyoutlinecolor,0);
	param_00.outlinecolor = level.enemyoutlinecolor;
}

//Function Number: 21
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
		if(castfloat(self.owner.health) / self.owner.maxhealth < 0.5 && gettime() > var_01)
		{
			var_02 = getnodesinradiussorted(self.owner.origin,256,0);
			if(var_02.size >= 2)
			{
				self.defense_force_next_node_goal = var_02[1];
				self notify("defend_force_node_recalculation");
				var_01 = gettime() + 1000;
			}
		}
		else if(castfloat(self.health) / self.maxhealth >= 0.6)
		{
			var_00 = 0;
		}
		else if(!var_00)
		{
			var_03 = maps/mp/bots/_bots_util::bot_find_node_to_guard_player(self.owner.origin,350,1);
			if(isdefined(var_03))
			{
				self.defense_force_next_node_goal = var_03;
				self notify("defend_force_node_recalculation");
				var_00 = 1;
			}
		}

		if(!maps/mp/bots/_bots_util::bot_is_guarding_player(self.owner))
		{
			var_04["override_goal_type"] = "critical";
			var_04["min_goal_time"] = 20;
			var_04["max_goal_time"] = 30;
			maps/mp/bots/_bots_strategy::bot_guard_player(self.owner,350,var_04);
		}

		wait(0.05);
	}
}

//Function Number: 22
hordesetupdogstate()
{
	maps\mp\_utility::_setnameplatematerial("player_name_bg_green_dog","player_name_bg_red_dog");
	self.enableextendedkill = 0;
	self.agentname = &"HORDE_QUAD";
	self.horde_type = "Quad";
	self.lassetgoalpos = (0,0,0);
	self.bhasnopath = 0;
	self.randompathstoptime = 0;
	maps/mp/gametypes/horde::func_702A(self);
}

//Function Number: 23
agentdogthink()
{
	self endon("death");
	level endon("game_ended");
	self endon("owner_disconnect");
	maps/mp/agents/dog/_dog_think::func_71F5();
	hordesetupdogstate();
	thread func_4EB9();
	self thread [[ self.watchattackstatefunc ]]();
	thread func_8AD7();
	thread func_5371();
	for(;;)
	{
		if(self.aistate != "melee" && !self.statelocked && maps/mp/agents/dog/_dog_think::func_63DA() && !maps/mp/agents/dog/_dog_think::didpastmeleefail())
		{
			self beginmelee(self.curmeleetarget);
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
				var_01 = randomintrange(castint(var_00.size * 0.9),var_00.size);
				self setgoalpos(var_00[var_01].origin);
				self.bhasnopath = 0;
				self.randompathstoptime = gettime() + 2500;
			}
		}
		else
		{
			var_02 = maps/mp/agents/dog/_dog_think::getattackpoint(self.enemy);
			self.curmeleetarget = self.enemy;
			self.movemode = "sprint";
			self.barrivalsenabled = 0;
			if(distancesquared(var_02,self.lassetgoalpos) > 4096)
			{
				self setgoalpos(var_02);
				self.lassetgoalpos = var_02;
			}
		}

		wait(0.05);
	}
}

//Function Number: 24
func_8AD7()
{
	self endon("death");
	level endon("game_ended");
	for(;;)
	{
		self waittill("bad_path",var_00);
		self.bhasnopath = 1;
	}
}

//Function Number: 25
func_4EB9()
{
	self endon("death");
	level endon("game_ended");
	for(;;)
	{
		foreach(var_01 in level.participants)
		{
			if(maps\mp\gametypes\_horde_util::isonhumanteam(var_01))
			{
				self ai_getenemyinfo(var_01);
			}
		}

		wait(0.5);
	}
}

//Function Number: 26
func_3283()
{
	var_00 = undefined;
	var_01 = 1410065408;
	foreach(var_03 in level.players)
	{
		if(maps\mp\_utility::func_4945(var_03) && maps\mp\gametypes\_horde_util::isonhumanteam(var_03) && !maps\mp\gametypes\_horde_util::func_4934(var_03))
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