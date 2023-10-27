/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\agents\_agents_civ_hvt.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 10
 * Decompile Time: 190 ms
 * Timestamp: 10/27/2023 1:28:01 AM
*******************************************************************/

//Function Number: 1
func_4FDD()
{
	func_710C();
}

//Function Number: 2
func_710C()
{
	level.agent_funcs["civ_hvt"] = [];
	level.agent_funcs["civ_hvt"]["spawn"] = ::func_9377;
	level.agent_funcs["civ_hvt"]["think"] = ::func_8F44;
	level.agent_funcs["civ_hvt"]["on_killed"] = ::onagentkilled;
	level.agent_funcs["civ_hvt"]["on_damaged"] = ::maps/mp/agents/_agents::func_58D7;
	level.agent_funcs["civ_hvt"]["on_damaged_finished"] = ::maps/mp/agents/_agents::agent_damage_finished;
}

//Function Number: 3
func_9377(param_00,param_01,param_02,param_03,param_04,param_05)
{
	self.hvtisfollowing = 0;
	maps/mp/agents/_agents::func_7765(param_00,param_01,param_02,param_03,param_04,param_05);
	thread func_9215();
}

//Function Number: 4
onagentkilled(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	self.defendnode = undefined;
	self.hvttrigger makeunusable();
	self.hvttrigger = undefined;
	self.body = self cloneagent(param_08);
	thread maps\mp\gametypes\_damage::func_252D(self.body,param_06,param_05,param_04,param_00,param_03);
	if(isdefined(self.onkilledcallback))
	{
		self [[ self.onkilledcallback ]](param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08);
	}

	maps/mp/agents/_agent_utility::func_233F();
	self.owner notify("hvt_killed");
}

//Function Number: 5
func_8F44()
{
	self notify("agent_think");
	self endon("agent_think");
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	self endon("owner_disconnect");
	for(;;)
	{
		if(self.hvtisfollowing)
		{
			func_9167();
			continue;
		}

		func_9587(150);
	}
}

//Function Number: 6
func_9587(param_00)
{
	self botsetstance("none");
	self botclearscriptgoal();
	maps/mp/bots/_bots_strategy::bot_disable_tactical_goals();
	var_01 = self.owner maps/mp/agents/_agent_utility::getvalidspawnpathnodenearplayer();
	self.cur_defend_node = undefined;
	self.bot_defending = 1;
	self.bot_defending_center = var_01.origin;
	self.bot_defending_radius = param_00;
	self.cur_defend_stance = "crouch";
	self.bot_defending_type = "protect";
	var_02 = "";
	while(var_02 != "goal")
	{
		self.cur_defend_node = var_01;
		self botsetscriptgoalnode(self.cur_defend_node,"tactical");
		var_02 = common_scripts\utility::func_8B33("goal","bad_path");
		self.node_closest_to_defend_center = var_01;
		self.cur_defend_node = undefined;
	}

	childthread maps/mp/bots/_bots_strategy::func_24FE();
	self waittill("hvt_toggle");
}

//Function Number: 7
func_9167()
{
	self botclearscriptgoal();
	maps/mp/bots/_bots_strategy::bot_disable_tactical_goals();
	if(!maps/mp/bots/_bots_util::bot_is_guarding_player(self.owner))
	{
		maps/mp/bots/_bots_strategy::bot_guard_player(self.owner,250);
	}

	self waittill("hvt_toggle");
}

//Function Number: 8
func_9215()
{
	level endon("game_ended");
	self endon("death");
	if(!isdefined(self.hvttrigger))
	{
		self.hvttrigger = spawn("script_model",self.origin);
		self.hvttrigger linkto(self);
	}

	self.hvttrigger makeusable();
	foreach(var_01 in level.players)
	{
		if(var_01 != self.owner)
		{
			self.hvttrigger disableplayeruse(var_01);
			continue;
		}

		self.hvttrigger enableplayeruse(var_01);
	}

	thread func_9585();
	for(;;)
	{
		func_944D();
		self.hvttrigger waittill("trigger",var_01);
		self.hvtisfollowing = !self.hvtisfollowing;
		self notify("hvt_toggle");
	}
}

//Function Number: 9
func_944D()
{
	var_00 = &"MP_HVT_FOLLOW";
	if(self.hvtisfollowing)
	{
		var_00 = &"MP_HVT_WAIT";
	}

	self.hvttrigger sethintstring(var_00);
}

//Function Number: 10
func_9585()
{
	level endon("game_ended");
	self endon("death");
	for(;;)
	{
		level waittill("connected",var_00);
		self.hvttrigger disableplayeruse(var_00);
	}
}