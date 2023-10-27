/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\agents\_agent_utility.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 15
 * Decompile Time: 424 ms
 * Timestamp: 10/27/2023 1:16:45 AM
*******************************************************************/

//Function Number: 1
agentfunc(param_00)
{
	return level.agent_funcs[self.agent_type][param_00];
}

//Function Number: 2
func_6E1D(param_00,param_01)
{
	self.team = param_00;
	self.agentteam = param_00;
	self.pers["team"] = param_00;
	self.owner = param_01;
	self setotherent(param_01);
	self setentityowner(param_01);
}

//Function Number: 3
func_45D6()
{
	self.agent_type = "player";
	self.pers = [];
	self.hasdied = 0;
	self.isactive = 0;
	self.isagent = 1;
	self.var_8C4D = 0;
	self.issniper = 0;
	self.var_78C4 = 0;
	self.entity_number = self getentitynumber();
	self.agent_teamparticipant = 0;
	self.agent_gameparticipant = 0;
	self.canperformclienttraces = 0;
	self.agentname = undefined;
	self detachall();
	func_4642(0);
}

//Function Number: 4
func_4642(param_00)
{
	if(!param_00)
	{
		self.class = undefined;
		self.lastclass = undefined;
		self.movespeedscaler = undefined;
		self.avoidkillstreakonspawntimer = undefined;
		self.guid = undefined;
		self.name = undefined;
		self.saved_actionslotdata = undefined;
		self.perks = undefined;
		self.weaponlist = undefined;
		self.omaclasschanged = undefined;
		self.objectivescaler = undefined;
		self.touchtriggers = undefined;
		self.carryobject = undefined;
		self.claimtrigger = undefined;
		self.canpickupobject = undefined;
		self.killedinuse = undefined;
		self.sessionteam = undefined;
		self.sessionstate = undefined;
		self.lastspawntime = undefined;
		self.lastspawnpoint = undefined;
		self.disabledweapon = undefined;
		self.var_27AB = undefined;
		self.disabledoffhandweapons = undefined;
		self.disabledusability = undefined;
		self.var_7402 = undefined;
		self.var_7401 = undefined;
		self.var_63FF = undefined;
	}
	else
	{
		self.movespeedscaler = 1;
		self.avoidkillstreakonspawntimer = 5;
		self.guid = maps\mp\_utility::getuniqueid();
		self.name = self.guid;
		self.sessionteam = self.team;
		self.sessionstate = "playing";
		self.var_7402 = 0;
		self.var_7401 = 0;
		self.var_63FF = 0;
		self.agent_gameparticipant = 1;
		maps\mp\gametypes\_playerlogic::func_7208();
		thread maps\mp\perks\_perks::onplayerspawned();
		if(maps\mp\_utility::func_48CE(self))
		{
			self.objectivescaler = 1;
			maps\mp\gametypes\_gameobjects::func_4589();
			self.disabledweapon = 0;
			self.var_27AB = 0;
			self.disabledoffhandweapons = 0;
		}
	}

	self.disabledusability = 1;
}

//Function Number: 5
getfreeagent(param_00)
{
	var_01 = undefined;
	if(isdefined(level.agentarray))
	{
		foreach(var_03 in level.agentarray)
		{
			if(!isdefined(var_03.isactive) || !var_03.isactive)
			{
				if(isdefined(var_03.waitingtodeactivate) && var_03.waitingtodeactivate)
				{
					continue;
				}

				var_01 = var_03;
				var_01 func_45D6();
				if(isdefined(param_00))
				{
					var_01.agent_type = param_00;
				}

				break;
			}
		}
	}

	return var_01;
}

//Function Number: 6
activateagent()
{
	self.isactive = 1;
}

//Function Number: 7
func_233F()
{
	thread func_2340();
}

//Function Number: 8
func_2340()
{
	self notify("deactivateAgentDelayed");
	self endon("deactivateAgentDelayed");
	if(maps\mp\_utility::func_48CE(self))
	{
		maps\mp\gametypes\_spawnlogic::func_6592();
	}

	maps\mp\gametypes\_spawnlogic::func_658C();
	wait(0.05);
	self.isactive = 0;
	self.hasdied = 0;
	self.owner = undefined;
	self.connecttime = undefined;
	self.waitingtodeactivate = undefined;
	foreach(var_01 in level.characters)
	{
		if(isdefined(var_01.attackers))
		{
			foreach(var_04, var_03 in var_01.attackers)
			{
				if(var_03 == self)
				{
					var_01.attackers[var_04] = undefined;
				}
			}
		}
	}

	if(isdefined(self.headmodel))
	{
		self detach(self.headmodel);
		self.headmodel = undefined;
	}

	self notify("disconnect");
}

//Function Number: 9
getnumactiveagents(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = "all";
	}

	var_01 = getactiveagentsoftype(param_00);
	return var_01.size;
}

//Function Number: 10
getactiveagentsoftype(param_00)
{
	var_01 = [];
	if(!isdefined(level.agentarray))
	{
		return var_01;
	}

	foreach(var_03 in level.agentarray)
	{
		if(isdefined(var_03.isactive) && var_03.isactive)
		{
			if(param_00 == "all" || var_03.agent_type == param_00)
			{
				var_01[var_01.size] = var_03;
			}
		}
	}

	return var_01;
}

//Function Number: 11
getnumownedactiveagents(param_00)
{
	return func_3B5A(param_00,"all");
}

//Function Number: 12
func_3B5A(param_00,param_01)
{
	var_02 = 0;
	if(!isdefined(level.agentarray))
	{
		return var_02;
	}

	foreach(var_04 in level.agentarray)
	{
		if(isdefined(var_04.isactive) && var_04.isactive)
		{
			if(isdefined(var_04.owner) && var_04.owner == param_00)
			{
				if((param_01 == "all" && var_04.agent_type != "alien") || var_04.agent_type == param_01)
				{
					var_02++;
				}
			}
		}
	}

	return var_02;
}

//Function Number: 13
getvalidspawnpathnodenearplayer(param_00,param_01)
{
	var_02 = getnodesinradius(self.origin,350,64,128,"Path");
	if(!isdefined(var_02) || var_02.size == 0)
	{
		return undefined;
	}

	if(isdefined(level.waterdeletez) && isdefined(level.trigunderwater))
	{
		var_03 = var_02;
		var_02 = [];
		foreach(var_05 in var_03)
		{
			if(var_05.origin[2] > level.waterdeletez || !ispointinvolume(var_05.origin,level.trigunderwater))
			{
				var_02[var_02.size] = var_05;
			}
		}
	}

	var_07 = anglestoforward(self.angles);
	var_08 = -10;
	var_09 = maps\mp\gametypes\_spawnlogic::getplayertraceheight(self);
	var_0A = (0,0,var_09);
	if(!isdefined(param_00))
	{
		param_00 = 0;
	}

	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	var_0B = [];
	var_0C = [];
	foreach(var_0E in var_02)
	{
		if(!var_0E doesnodeallowstance("stand") || isdefined(var_0E.no_agent_spawn))
		{
			continue;
		}

		var_0F = vectornormalize(var_0E.origin - self.origin);
		var_10 = vectordot(var_07,var_0F);
		for(var_11 = 0;var_11 < var_0C.size;var_11++)
		{
			if(var_10 > var_0C[var_11])
			{
				for(var_12 = var_0C.size;var_12 > var_11;var_12--)
				{
					var_0C[var_12] = var_0C[var_12 - 1];
					var_0B[var_12] = var_0B[var_12 - 1];
				}

				break;
			}
		}

		var_0B[var_11] = var_0E;
		var_0C[var_11] = var_10;
	}

	for(var_11 = 0;var_11 < var_0B.size;var_11++)
	{
		var_0E = var_0B[var_11];
		var_14 = self.origin + var_0A;
		var_15 = var_0E.origin + var_0A;
		if(var_11 > 0)
		{
			wait(0.05);
		}

		if(!sighttracepassed(var_14,var_15,0,self))
		{
			continue;
		}

		if(param_01)
		{
			if(var_11 > 0)
			{
				wait(0.05);
			}

			var_16 = playerphysicstrace(var_0E.origin + var_0A,var_0E.origin);
			if(distancesquared(var_16,var_0E.origin) > 1)
			{
				continue;
			}
		}

		if(param_00)
		{
			if(var_11 > 0)
			{
				wait(0.05);
			}

			var_16 = physicstrace(var_14,var_15);
			if(distancesquared(var_16,var_15) > 1)
			{
				continue;
			}
		}

		return var_0E;
	}

	if(var_0B.size > 0 && isdefined(level.ishorde))
	{
		return var_0B[0];
	}
}

//Function Number: 14
func_4B0B(param_00)
{
	param_00 dodamage(param_00.health + 500000,param_00.origin);
}

//Function Number: 15
func_4B15()
{
	self [[ agentfunc("on_damaged") ]](level,undefined,self.health + 1,0,"MOD_CRUSH","none",(0,0,0),(0,0,0),"none",0);
}