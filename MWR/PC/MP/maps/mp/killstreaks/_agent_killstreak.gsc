/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\killstreaks\_agent_killstreak.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 10
 * Decompile Time: 234 ms
 * Timestamp: 10/27/2023 2:42:26 AM
*******************************************************************/

//Function Number: 1
init()
{
	level.killstreakfuncs["agent"] = ::tryusesquadmate;
	level.killstreakfuncs["recon_agent"] = ::tryusereconsquadmate;
}

//Function Number: 2
setup_callbacks()
{
	level.agent_funcs["squadmate"] = level.agent_funcs["player"];
	level.agent_funcs["squadmate"]["think"] = ::squadmate_agent_think;
	level.agent_funcs["squadmate"]["on_killed"] = ::on_agent_squadmate_killed;
	level.agent_funcs["squadmate"]["on_damaged"] = ::maps\mp\agents\_agents::on_agent_player_damaged;
	level.agent_funcs["squadmate"]["gametype_update"] = ::no_gametype_update;
}

//Function Number: 3
no_gametype_update()
{
	return 0;
}

//Function Number: 4
tryusesquadmate(param_00,param_01)
{
	return usesquadmate("agent");
}

//Function Number: 5
tryusereconsquadmate(param_00,param_01)
{
	return usesquadmate("reconAgent");
}

//Function Number: 6
usesquadmate(param_00)
{
	if(maps\mp\agents\_agent_utility::getnumactiveagents("squadmate") >= 5)
	{
		self iprintlnbold(&"KILLSTREAKS_AGENT_MAX");
		return 0;
	}

	if(maps\mp\agents\_agent_utility::getnumownedactiveagents(self) >= 2)
	{
		self iprintlnbold(&"KILLSTREAKS_AGENT_MAX");
		return 0;
	}

	var_01 = maps\mp\agents\_agent_utility::getvalidspawnpathnodenearplayer(0,1);
	if(!isdefined(var_01))
	{
		return 0;
	}

	if(!maps\mp\_utility::isreallyalive(self))
	{
		return 0;
	}

	var_02 = var_01.origin;
	var_03 = vectortoangles(self.origin - var_01.origin);
	var_04 = maps\mp\agents\_agents::add_humanoid_agent("squadmate",self.team,undefined,var_02,var_03,self,0,0,"veteran");
	if(!isdefined(var_04))
	{
		self iprintlnbold(&"KILLSTREAKS_AGENT_MAX");
		return 0;
	}

	var_04.killstreaktype = param_00;
	var_04 maps\mp\perks\_perkfunctions::setlightarmor();
	var_04 maps\mp\_utility::_setnameplatematerial("player_name_bg_green_agent","player_name_bg_red_agent");
	return 1;
}

//Function Number: 7
finishreconagentloadout()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	self waittill("applyLoadout");
	maps\mp\perks\_perkfunctions::setlightarmor();
	maps\mp\_utility::giveperk("specialty_quickswap",0);
	maps\mp\_utility::giveperk("specialty_regenfaster",0);
}

//Function Number: 8
sendagentweaponnotify(param_00)
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	self waittill("applyLoadout");
	self notify("weapon_change",param_00);
}

//Function Number: 9
squadmate_agent_think()
{
	self endon("death");
	self endon("disconnect");
	self endon("owner_disconnect");
	level endon("game_ended");
	for(;;)
	{
		self botsetflag("prefer_shield_out",1);
		var_00 = self [[ maps\mp\agents\_agent_utility::agentfunc("gametype_update") ]]();
		if(!var_00)
		{
			if(!maps\mp\bots\_bots_util::bot_is_guarding_player(self.owner))
			{
				maps\mp\bots\_bots_strategy::bot_guard_player(self.owner,350);
			}
		}

		wait(0.05);
	}
}

//Function Number: 10
on_agent_squadmate_killed(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	maps\mp\agents\_agents::on_humanoid_agent_killed_common(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,0);
	if(isplayer(param_01) && isdefined(self.owner) && param_01 != self.owner)
	{
		self.owner maps\mp\_utility::leaderdialogonplayer("squad_killed");
		maps\mp\gametypes\_damage::onkillstreakkilled(param_01,param_04,param_03,param_02,"destroyed_squad_mate");
	}

	maps\mp\agents\_agent_utility::deactivateagent();
}