/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\killstreaks\_dog_killstreak.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 8
 * Decompile Time: 145 ms
 * Timestamp: 10/27/2023 1:20:39 AM
*******************************************************************/

//Function Number: 1
func_44DF()
{
	level.killstreakfuncs["guard_dog"] = ::func_8435;
}

//Function Number: 2
func_710C()
{
	level.agent_funcs["dog"] = level.agent_funcs["player"];
	level.agent_funcs["dog"]["spawn"] = ::func_77A6;
	level.agent_funcs["dog"]["on_killed"] = ::func_58D5;
	level.agent_funcs["dog"]["on_damaged"] = ::maps/mp/agents/_agents::func_58D6;
	level.agent_funcs["dog"]["on_damaged_finished"] = ::on_damaged_finished;
	level.agent_funcs["dog"]["think"] = ::maps/mp/agents/dog/_dog_think::func_4FDD;
}

//Function Number: 3
func_8435(param_00,param_01)
{
	return func_87B5();
}

//Function Number: 4
func_87B5()
{
	if(isdefined(self.hasdog) && self.hasdog)
	{
		var_00 = self getcommonplayerdatareservedint("mp_dog_type");
		if(var_00 == 1)
		{
			self iprintlnbold(&"KILLSTREAKS_ALREADY_HAVE_WOLF");
		}
		else
		{
			self iprintlnbold(&"KILLSTREAKS_ALREADY_HAVE_DOG");
		}

		return 0;
	}

	if(maps/mp/agents/_agent_utility::getnumactiveagents("dog") >= 5)
	{
		self iprintlnbold(&"KILLSTREAKS_TOO_MANY_DOGS");
		return 0;
	}

	if(maps/mp/agents/_agent_utility::getnumownedactiveagents(self) >= 2)
	{
		self iprintlnbold(&"KILLSTREAKS_AGENT_MAX");
		return 0;
	}

	var_01 = getmaxagents();
	if(maps/mp/agents/_agent_utility::getnumactiveagents() >= var_01)
	{
		self iprintlnbold(&"KILLSTREAKS_UNAVAILABLE");
		return 0;
	}

	if(!maps\mp\_utility::func_4945(self))
	{
		return 0;
	}

	var_02 = maps/mp/agents/_agent_utility::getvalidspawnpathnodenearplayer(1);
	if(!isdefined(var_02))
	{
		return 0;
	}

	var_03 = maps/mp/agents/_agent_common::func_1EBE("dog",self.team);
	if(!isdefined(var_03))
	{
		return 0;
	}

	self.hasdog = 1;
	var_03 maps/mp/agents/_agent_utility::func_6E1D(self.team,self);
	var_04 = var_02.origin;
	var_05 = vectortoangles(self.origin - var_02.origin);
	var_03 thread [[ var_03 maps/mp/agents/_agent_utility::agentfunc("spawn") ]](var_04,var_05,self);
	var_03 maps\mp\_utility::_setnameplatematerial("player_name_bg_green_dog","player_name_bg_red_dog");
	if(isdefined(self.balldrone) && self.balldrone.balldronetype == "ball_drone_backup")
	{
		maps\mp\gametypes\_missions::func_61CE("ch_twiceasdeadly");
	}

	maps\mp\_matchdata::func_4F1D("guard_dog",self.origin);
	return 1;
}

//Function Number: 5
func_58D5(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	self.isactive = 0;
	self.hasdied = 0;
	if(isdefined(self.owner))
	{
		self.owner.hasdog = 0;
	}

	param_01.lastkilldogtime = gettime();
	if(isdefined(self.animcbs.onexit[self.aistate]))
	{
		self [[ self.animcbs.onexit[self.aistate] ]]();
	}

	if(isplayer(param_01) && isdefined(self.owner) && param_01 != self.owner)
	{
		self.owner maps\mp\_utility::func_4D35("dog_killed");
		maps\mp\gametypes\_damage::onkillstreakkilled(param_01,param_04,param_03,param_02,"destroyed_guard_dog");
		if(isplayer(param_01))
		{
			param_01 maps\mp\gametypes\_missions::func_61CE("ch_notsobestfriend");
			if(!self isonground())
			{
				param_01 maps\mp\gametypes\_missions::func_61CE("ch_hoopla");
			}
		}
	}

	self setanimstate("death");
	var_09 = self getanimentry();
	var_0A = getanimlength(var_09);
	param_08 = int(var_0A * 1000);
	self.body = self cloneagent(param_08);
	self playsound(common_scripts\utility::func_803F(self.biswolf,"anml_wolf_shot_death","anml_dog_shot_death"));
	maps/mp/agents/_agent_utility::func_233F();
	self notify("killanimscript");
}

//Function Number: 6
on_damaged_finished(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	if(!isdefined(self.playing_pain_sound))
	{
		thread play_pain_sound(2.5);
	}

	var_0A = param_02;
	if(isdefined(param_08) && param_08 == "head" && level.gametype != "horde")
	{
		var_0A = int(var_0A * 0.6);
		if(param_02 > 0 && var_0A <= 0)
		{
			var_0A = 1;
		}
	}

	if(self.health - var_0A > 0)
	{
		maps/mp/agents/dog/_dog_think::func_5906(param_00,param_01,var_0A,param_03,param_04,param_05,param_06,param_07,param_08,param_09);
	}

	if(isplayer(param_01))
	{
		if(isdefined(self.attackstate) && self.attackstate != "attacking")
		{
			if(distancesquared(self.origin,param_01.origin) <= self.dogdamagedradiussq)
			{
				self.favoriteenemy = param_01;
				self.forceattack = 1;
				thread maps/mp/agents/dog/_dog_think::func_8CE4();
			}
		}
	}

	maps/mp/agents/_agents::agent_damage_finished(param_00,param_01,var_0A,param_03,param_04,param_05,param_06,param_07,param_08,param_09);
}

//Function Number: 7
play_pain_sound(param_00)
{
	self endon("death");
	self playsound(common_scripts\utility::func_803F(self.biswolf,"anml_wolf_shot_pain","anml_dog_shot_pain"));
	self.playing_pain_sound = 1;
	wait(param_00);
	self.playing_pain_sound = undefined;
}

//Function Number: 8
func_77A6(param_00,param_01,param_02)
{
	var_03 = 0;
	var_04 = 0;
	if(isdefined(param_02))
	{
		if(isdefined(param_02.squad_bot_dog_type))
		{
			var_03 = param_02.squad_bot_dog_type;
		}
		else
		{
			var_03 = param_02 getcommonplayerdatareservedint("mp_dog_type");
		}
	}

	var_05 = "mp_fullbody_dog_a";
	if(var_03 == 1)
	{
		if(var_04 == 0)
		{
			var_05 = "mp_fullbody_wolf_b";
		}
		else
		{
			var_05 = "mp_fullbody_wolf_c";
		}
	}

	if(ishairrunning())
	{
		var_05 = var_05 + "_fur";
	}

	self setmodel(var_05);
	self.species = "dog";
	self.onenteranimstate = ::maps/mp/agents/dog/_dog_think::onenteranimstate;
	if(isdefined(param_00) && isdefined(param_01))
	{
		var_06 = param_00;
		var_07 = param_01;
	}
	else
	{
		var_08 = self [[ level.getspawnpoint ]]();
		var_06 = var_08.origin;
		var_07 = var_08.angles;
	}

	maps/mp/agents/_agent_utility::activateagent();
	self.var_78C4 = gettime();
	self.lastspawntime = gettime();
	self.biswolf = var_03 == 1;
	maps/mp/agents/dog/_dog_think::func_44DF();
	if(var_03 == 1)
	{
		var_09 = "wolf_animclass";
	}
	else
	{
		var_09 = "dog_animclass";
	}

	self spawnagent(var_06,var_07,var_09,15,40,param_02);
	level notify("spawned_agent",self);
	maps/mp/agents/_agent_common::func_6E1C(250);
	if(isdefined(param_02))
	{
		maps/mp/agents/_agent_utility::func_6E1D(param_02.team,param_02);
	}

	self setthreatbiasgroup("Dogs");
	self takeallweapons();
	if(isdefined(self.owner))
	{
		self hide();
		wait(1);
		if(!isalive(self))
		{
		}

		self show();
	}

	self thread [[ maps/mp/agents/_agent_utility::agentfunc("think") ]]();
	wait(0.1);
	if(ishairrunning())
	{
		if(var_03 == 1)
		{
			var_0A = level.wolffurfx[var_04];
		}
		else
		{
			var_0A = level.furfx;
		}

		playfxontag(var_0A,self,"tag_origin");
	}
}