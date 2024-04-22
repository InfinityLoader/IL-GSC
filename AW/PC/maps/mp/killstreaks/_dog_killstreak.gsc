/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\killstreaks\_dog_killstreak.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 8
 * Decompile Time: 134 ms
 * Timestamp: 4/22/2024 2:11:36 AM
*******************************************************************/

//Function Number: 1
init()
{
	precachemodel("animal_dobernan");
	level.killstreakfuncs["guard_dog"] = ::tryusedog;
}

//Function Number: 2
setup_callbacks()
{
	level.agent_funcs["dog"] = level.agent_funcs["player"];
	level.agent_funcs["dog"]["spawn"] = ::spawn_dog;
	level.agent_funcs["dog"]["on_killed"] = ::on_agent_dog_killed;
	level.agent_funcs["dog"]["on_damaged"] = ::maps\mp\agents\_agents::on_agent_generic_damaged;
	level.agent_funcs["dog"]["on_damaged_finished"] = ::on_damaged_finished;
	level.agent_funcs["dog"]["think"] = ::maps\mp\agents\dog\_dog_think::main;
	level.killstreakwieldweapons["agent_mp"] = "agent_mp";
}

//Function Number: 3
tryusedog(param_00,param_01)
{
	return usedog();
}

//Function Number: 4
usedog()
{
	if(maps\mp\agents\_agent_utility::getnumactiveagents("dog") >= 5)
	{
		self iprintlnbold(&"KILLSTREAKS_TOO_MANY_DOGS");
		return 0;
	}

	if(maps\mp\agents\_agent_utility::getnumownedactiveagentsbytype(self,"dog") >= 1)
	{
		self iprintlnbold(&"KILLSTREAKS_ALREADY_HAVE_DOG");
		return 0;
	}

	if(maps\mp\agents\_agent_utility::getnumownedactiveagents(self) >= 2)
	{
		self iprintlnbold(&"KILLSTREAKS_AGENT_MAX");
		return 0;
	}

	var_00 = getmaxagents();
	if(maps\mp\agents\_agent_utility::getnumactiveagents() >= var_00)
	{
		self iprintlnbold(&"KILLSTREAKS_UNAVAILABLE");
		return 0;
	}

	if(!maps\mp\_utility::isreallyalive(self))
	{
		return 0;
	}

	var_01 = maps\mp\agents\_agent_utility::getvalidspawnpathnodenearplayer(1);
	if(!isdefined(var_01))
	{
		return 0;
	}

	var_02 = maps\mp\agents\_agent_common::connectnewagent("dog",self.team);
	if(!isdefined(var_02))
	{
		return 0;
	}

	var_02 maps\mp\agents\_agent_utility::set_agent_team(self.team,self);
	var_03 = var_01.origin;
	var_04 = vectortoangles(self.origin - var_01.origin);
	var_02 thread [[ var_02 maps\mp\agents\_agent_utility::agentfunc("spawn") ]](var_03,var_04,self);
	var_02 maps\mp\_utility::_setnameplatematerial("player_name_bg_green_dog","player_name_bg_red_dog");
	if(isdefined(self.balldrone) && self.balldrone.balldronetype == "ball_drone_backup")
	{
		maps\mp\gametypes\_missions::processchallenge("ch_twiceasdeadly");
	}

	return 1;
}

//Function Number: 5
on_agent_dog_killed(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	self.isactive = 0;
	self.hasdied = 0;
	param_01.lastkilldogtime = gettime();
	if(isdefined(self.animcbs.onexit[self.aistate]))
	{
		self [[ self.animcbs.onexit[self.aistate] ]]();
	}

	if(isplayer(param_01) && isdefined(self.owner) && param_01 != self.owner)
	{
		self.owner maps\mp\_utility::leaderdialogonplayer("dog_killed");
		maps\mp\gametypes\_damage::onkillstreakkilled(param_01,param_04,param_03,param_02,"destroyed_guard_dog");
		if(isplayer(param_01))
		{
			param_01 maps\mp\gametypes\_missions::processchallenge("ch_notsobestfriend");
			if(!self isonground())
			{
				param_01 maps\mp\gametypes\_missions::processchallenge("ch_hoopla");
			}
		}
	}

	self setanimstate("death");
	var_09 = self getanimentry();
	var_0A = getanimlength(var_09);
	param_08 = int(var_0A * 1000);
	self.body = self finishagentdamage(param_08);
	self playsound("anml_doberman_death");
	maps\mp\agents\_agent_utility::deactivateagent();
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
		maps\mp\agents\dog\_dog_think::ondamage(param_00,param_01,var_0A,param_03,param_04,param_05,param_06,param_07,param_08,param_09);
	}

	if(isplayer(param_01))
	{
		if(isdefined(self.attackstate) && self.attackstate != "attacking")
		{
			if(distancesquared(self.origin,param_01.origin) <= self.dogdamagedradiussq)
			{
				self.favoriteenemy = param_01;
				self.forceattack = 1;
				thread maps\mp\agents\dog\_dog_think::watchfavoriteenemydeath();
			}
		}
	}

	maps\mp\agents\_agents::agent_damage_finished(param_00,param_01,var_0A,param_03,param_04,param_05,param_06,param_07,param_08,param_09);
}

//Function Number: 7
play_pain_sound(param_00)
{
	self endon("death");
	self playsound("anml_doberman_pain");
	self.playing_pain_sound = 1;
	wait(param_00);
	self.playing_pain_sound = undefined;
}

//Function Number: 8
spawn_dog(param_00,param_01,param_02)
{
	if(ishairrunning())
	{
		self setmodel("animal_dobernan");
	}
	else
	{
		self setmodel("animal_dobernan");
	}

	self.species = "dog";
	self.onenteranimstate = ::maps\mp\agents\dog\_dog_think::onenteranimstate;
	if(isdefined(param_00) && isdefined(param_01))
	{
		var_03 = param_00;
		var_04 = param_01;
	}
	else
	{
		var_05 = self [[ level.getspawnpoint ]]();
		var_03 = var_05.origin;
		var_04 = var_05.angles;
	}

	maps\mp\agents\_agent_utility::activateagent();
	self.spawntime = gettime();
	self.lastspawntime = gettime();
	maps\mp\agents\dog\_dog_think::init();
	self spawnagent(var_03,var_04,"dog_animclass",15,40,param_02);
	level notify("spawned_agent",self);
	maps\mp\agents\_agent_common::set_agent_health(250);
	if(isdefined(param_02))
	{
		maps\mp\agents\_agent_utility::set_agent_team(param_02.team,param_02);
	}

	self setthreatbiasgroup("Dogs");
	self takeallweapons();
	if(isdefined(self.owner))
	{
		self hide();
		wait(1);
		if(!isalive(self))
		{
			return;
		}

		self show();
		wait(0.1);
	}

	self thread [[ maps\mp\agents\_agent_utility::agentfunc("think") ]]();
	wait(0.1);
	if(ishairrunning())
	{
		playfxontag(level.furfx,self,"tag_origin");
	}
}