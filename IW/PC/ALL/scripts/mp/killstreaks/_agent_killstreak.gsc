/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\killstreaks\_agent_killstreak.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 10
 * Decompile Time: 445 ms
 * Timestamp: 10/27/2023 12:28:00 AM
*******************************************************************/

//Function Number: 1
init()
{
	scripts\mp\killstreaks\_killstreaks::func_DEFB("agent",::func_12905);
	scripts\mp\killstreaks\_killstreaks::func_DEFB("recon_agent",::func_128F8);
}

//Function Number: 2
func_F8F4()
{
	level.agent_funcs["squadmate"] = level.agent_funcs["player"];
	level.agent_funcs["squadmate"]["think"] = ::func_10AEA;
	level.agent_funcs["squadmate"]["on_killed"] = ::func_C4AA;
	level.agent_funcs["squadmate"]["on_damaged"] = ::scripts\mp\agents\_agents::func_C4A8;
	level.agent_funcs["squadmate"]["gametype_update"] = ::func_BFF0;
}

//Function Number: 3
func_BFF0()
{
	return 0;
}

//Function Number: 4
func_12905(param_00,param_01)
{
	return func_130DB("agent");
}

//Function Number: 5
func_128F8(param_00,param_01)
{
	return func_130DB("reconAgent");
}

//Function Number: 6
func_130DB(param_00)
{
	if(lib_0D65::func_8008("squadmate") >= 5)
	{
		self iprintlnbold(&"KILLSTREAKS_AGENT_MAX");
		return 0;
	}

	if(lib_0D65::func_8010(self) >= 2)
	{
		self iprintlnbold(&"KILLSTREAKS_AGENT_MAX");
		return 0;
	}

	var_01 = lib_0D65::func_81FB(0,1);
	if(!isdefined(var_01))
	{
		return 0;
	}

	if(!scripts\mp\_utility::func_9F19(self))
	{
		return 0;
	}

	var_02 = var_01.origin;
	var_03 = vectortoangles(self.origin - var_01.origin);
	var_04 = scripts\mp\agents\_agents::func_16F2("squadmate",self.team,undefined,var_02,var_03,self,0,0,"veteran");
	if(!isdefined(var_04))
	{
		self iprintlnbold(&"KILLSTREAKS_AGENT_MAX");
		return 0;
	}

	var_04.var_A6BB = param_00;
	if(var_04.var_A6BB == "reconAgent")
	{
		var_04 thread func_F22B("iw6_riotshield_mp");
		var_04 thread func_6CE2();
		var_04 thread scripts\mp\_class::func_8379(self.pers["team"],"reconAgent",0);
		var_04 scripts\mp\agents\_agent_common::func_F28C(250);
		var_04 scripts\mp\perks\_perkfunctions::func_F785();
		var_04 setmodel("mp_fullbody_synaptic_1");
		var_04 detach(var_04.var_8C98);
		var_04.var_8C98 = undefined;
	}
	else
	{
		var_04 scripts\mp\perks\_perkfunctions::func_F785();
	}

	var_04 scripts\mp\_utility::func_13CE("player_name_bg_green_agent","player_name_bg_red_agent");
	return 1;
}

//Function Number: 7
func_6CE2()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	self waittill("giveLoadout");
	scripts\mp\perks\_perkfunctions::func_F785();
	scripts\mp\_utility::func_8387("specialty_quickswap");
	scripts\mp\_utility::func_8387("specialty_regenfaster");
	self method_804D("minInaccuracy",1.5 * self botgetdifficultysetting("minInaccuracy"));
	self method_804D("maxInaccuracy",1.5 * self botgetdifficultysetting("maxInaccuracy"));
	self method_804D("minFireTime",1.5 * self botgetdifficultysetting("minFireTime"));
	self method_804D("maxFireTime",1.25 * self botgetdifficultysetting("maxFireTime"));
}

//Function Number: 8
func_F22B(param_00)
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
func_10AEA()
{
	self endon("death");
	self endon("disconnect");
	self endon("owner_disconnect");
	level endon("game_ended");
	for(;;)
	{
		self botsetflag("prefer_shield_out",1);
		var_00 = self [[ lib_0D65::func_1908("gametype_update") ]]();
		if(!var_00)
		{
			if(!scripts\mp\bots\_bots_util::func_2DDA(self.var_222))
			{
				scripts\mp\bots\_bots_strategy::func_2DC1(self.var_222,350);
			}
		}

		wait(0.05);
	}
}

//Function Number: 10
func_C4AA(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	scripts\mp\agents\_agents::func_C4B3(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,0);
	if(isplayer(param_01) && isdefined(self.var_222) && param_01 != self.var_222)
	{
		self.var_222 scripts\mp\_utility::func_AAEC("squad_killed");
		scripts\mp\_damage::func_C548("squad_mate",param_01,param_04,param_03,param_02,"destroyed_squad_mate");
	}

	lib_0D65::func_4DDB();
}