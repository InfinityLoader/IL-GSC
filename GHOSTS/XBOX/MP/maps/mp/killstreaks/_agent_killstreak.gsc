/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\killstreaks\_agent_killstreak.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 10
 * Decompile Time: 160 ms
 * Timestamp: 10/27/2023 1:32:04 AM
*******************************************************************/

//Function Number: 1
func_44DF()
{
	level.killstreakfuncs["agent"] = ::func_8455;
	level.killstreakfuncs["recon_agent"] = ::func_8448;
}

//Function Number: 2
func_710C()
{
	level.agent_funcs["squadmate"] = level.agent_funcs["player"];
	level.agent_funcs["squadmate"]["think"] = ::func_7997;
	level.agent_funcs["squadmate"]["on_killed"] = ::on_agent_squadmate_killed;
	level.agent_funcs["squadmate"]["on_damaged"] = ::maps/mp/agents/_agents::func_58D7;
	level.agent_funcs["squadmate"]["gametype_update"] = ::func_561F;
}

//Function Number: 3
func_561F()
{
	return 0;
}

//Function Number: 4
func_8455(param_00,param_01)
{
	return func_87D3("agent");
}

//Function Number: 5
func_8448(param_00,param_01)
{
	return func_87D3("reconAgent");
}

//Function Number: 6
func_87D3(param_00)
{
	if(maps/mp/agents/_agent_utility::getnumactiveagents("squadmate") >= 5)
	{
		self iprintlnbold(&"KILLSTREAKS_AGENT_MAX");
		return 0;
	}

	if(maps/mp/agents/_agent_utility::getnumownedactiveagents(self) >= 2)
	{
		self iprintlnbold(&"KILLSTREAKS_AGENT_MAX");
		return 0;
	}

	var_01 = maps/mp/agents/_agent_utility::getvalidspawnpathnodenearplayer(0,1);
	if(!isdefined(var_01))
	{
		return 0;
	}

	if(!maps\mp\_utility::func_4945(self))
	{
		return 0;
	}

	var_02 = var_01.origin;
	var_03 = vectortoangles(self.origin - var_01.origin);
	var_04 = maps/mp/agents/_agents::add_humanoid_agent("squadmate",self.team,undefined,var_02,var_03,self,0,0,"veteran");
	if(!isdefined(var_04))
	{
		self iprintlnbold(&"KILLSTREAKS_AGENT_MAX");
		return 0;
	}

	var_04.killstreaktype = param_00;
	if(var_04.killstreaktype == "reconAgent")
	{
		var_04 thread func_6D9C("iw6_riotshield_mp");
		var_04 thread func_32A0();
		var_04 thread maps\mp\gametypes\_class::giveloadout(self.pers["team"],"reconAgent",0);
		var_04 maps/mp/agents/_agent_common::func_6E1C(250);
		var_04 maps\mp\perks\_perkfunctions::func_7063();
	}
	else
	{
		var_04 maps\mp\perks\_perkfunctions::func_7063();
	}

	var_04 maps\mp\_utility::_setnameplatematerial("player_name_bg_green_agent","player_name_bg_red_agent");
	maps\mp\_matchdata::func_4F1D(var_04.killstreaktype,self.origin);
	return 1;
}

//Function Number: 7
func_32A0()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	self waittill("giveLoadout");
	maps\mp\perks\_perkfunctions::func_7063();
	maps\mp\_utility::func_3CFB("specialty_quickswap",0);
	maps\mp\_utility::func_3CFB("specialty_regenfaster",0);
	self botsetdifficultysetting("minInaccuracy",1.5 * self botgetdifficultysetting("minInaccuracy"));
	self botsetdifficultysetting("maxInaccuracy",1.5 * self botgetdifficultysetting("maxInaccuracy"));
	self botsetdifficultysetting("minFireTime",1.5 * self botgetdifficultysetting("minFireTime"));
	self botsetdifficultysetting("maxFireTime",1.25 * self botgetdifficultysetting("maxFireTime"));
}

//Function Number: 8
func_6D9C(param_00)
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	self waittill("giveLoadout");
	if(!isdefined(param_00))
	{
		param_00 = "iw6_riotshield_mp";
	}

	self notify("weapon_change",param_00);
}

//Function Number: 9
func_7997()
{
	self endon("death");
	self endon("disconnect");
	self endon("owner_disconnect");
	level endon("game_ended");
	for(;;)
	{
		self botsetflag("prefer_shield_out",1);
		var_00 = self [[ maps/mp/agents/_agent_utility::agentfunc("gametype_update") ]]();
		if(!var_00)
		{
			if(!maps/mp/bots/_bots_util::bot_is_guarding_player(self.owner))
			{
				maps/mp/bots/_bots_strategy::bot_guard_player(self.owner,350);
			}
		}

		wait(0.05);
	}
}

//Function Number: 10
on_agent_squadmate_killed(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	maps/mp/agents/_agents::func_58E5(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,0);
	if(isplayer(param_01) && isdefined(self.owner) && param_01 != self.owner)
	{
		self.owner maps\mp\_utility::func_4D35("squad_killed");
		maps\mp\gametypes\_damage::onkillstreakkilled(param_01,param_04,param_03,param_02,"destroyed_squad_mate");
	}

	maps/mp/agents/_agent_utility::func_233F();
}