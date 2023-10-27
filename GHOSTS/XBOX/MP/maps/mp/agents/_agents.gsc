/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\agents\_agents.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 12
 * Decompile Time: 225 ms
 * Timestamp: 10/27/2023 1:28:00 AM
*******************************************************************/

//Function Number: 1
func_4FDD()
{
	if(isdefined(level.createfx_enabled) && level.createfx_enabled)
	{
		return;
	}

	func_710C();
	level.badplace_cylinder_func = ::badplace_cylinder;
	level.badplace_delete_func = ::badplace_delete;
	level thread maps/mp/agents/_agent_common::func_44DF();
	level thread maps\mp\killstreaks\_agent_killstreak::func_44DF();
	level thread maps\mp\killstreaks\_dog_killstreak::func_44DF();
}

//Function Number: 2
func_710C()
{
	if(!isdefined(level.agent_funcs))
	{
		level.agent_funcs = [];
	}

	level.agent_funcs["player"] = [];
	level.agent_funcs["player"]["spawn"] = ::func_7765;
	level.agent_funcs["player"]["think"] = ::maps/mp/bots/_bots_gametype_war::bot_war_think;
	level.agent_funcs["player"]["on_killed"] = ::func_58D8;
	level.agent_funcs["player"]["on_damaged"] = ::func_58D7;
	level.agent_funcs["player"]["on_damaged_finished"] = ::agent_damage_finished;
	maps\mp\killstreaks\_agent_killstreak::func_710C();
	maps\mp\killstreaks\_dog_killstreak::func_710C();
}

//Function Number: 3
func_8AB5()
{
	while(!isdefined(level.agent_funcs))
	{
		wait(0.05);
	}
}

//Function Number: 4
add_humanoid_agent(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	var_09 = maps/mp/agents/_agent_common::func_1EBE(param_00,param_01,param_02);
	if(isdefined(var_09))
	{
		var_09 thread [[ var_09 maps/mp/agents/_agent_utility::agentfunc("spawn") ]](param_03,param_04,param_05,param_06,param_07,param_08);
	}

	return var_09;
}

//Function Number: 5
func_7765(param_00,param_01,param_02,param_03,param_04,param_05)
{
	self endon("disconnect");
	while(!isdefined(level.getspawnpoint))
	{
		common_scripts\utility::func_8AFE();
	}

	if(self.hasdied)
	{
		wait(randomintrange(6,10));
	}

	maps/mp/agents/_agent_utility::func_4642(1);
	if(isdefined(param_00) && isdefined(param_01))
	{
		var_06 = param_00;
		var_07 = param_01;
		self.lastspawnpoint = addstruct();
		self.lastspawnpoint.origin = var_06;
		self.lastspawnpoint.angles = var_07;
	}
	else
	{
		var_08 = self [[ level.getspawnpoint ]]();
		var_06 = var_08.origin;
		var_07 = var_08.angles;
		self.lastspawnpoint = var_08;
	}

	maps/mp/agents/_agent_utility::activateagent();
	self.lastspawntime = gettime();
	self.var_78C4 = gettime();
	var_09 = var_06 + (0,0,25);
	var_0A = var_06;
	var_0B = playerphysicstrace(var_09,var_0A);
	if(distancesquared(var_0B,var_09) > 1)
	{
		var_06 = var_0B;
	}

	self spawnagent(var_06,var_07);
	if(isdefined(param_03) && param_03)
	{
		maps/mp/bots/_bots_personality::func_157C();
	}
	else
	{
		maps/mp/bots/_bots_util::bot_set_personality("default");
	}

	if(isdefined(param_05))
	{
		maps/mp/bots/_bots_util::bot_set_difficulty(param_05);
	}

	func_4640();
	maps/mp/agents/_agent_common::func_6E1C(100);
	if(isdefined(param_04) && param_04)
	{
		self.respawn_on_death = 1;
	}

	if(isdefined(param_02))
	{
		maps/mp/agents/_agent_utility::func_6E1D(param_02.team,param_02);
	}

	if(isdefined(self.owner))
	{
		thread func_2657(self.owner);
	}

	thread maps\mp\_flashgrenades::func_538C();
	self enableanimstate(0);
	self [[ level.var_5976 ]]();
	maps\mp\gametypes\_class::giveloadout(self.team,self.class,1);
	thread maps/mp/bots/_bots::bot_think_watch_enemy(1);
	thread maps/mp/bots/_bots::bot_think_crate();
	if(self.agent_type == "player")
	{
		thread maps/mp/bots/_bots::func_16B0();
	}
	else if(self.agent_type == "odin_juggernaut")
	{
		thread maps/mp/bots/_bots::func_16B0(128);
	}

	thread maps/mp/bots/_bots_strategy::bot_think_tactical_goals();
	self thread [[ maps/mp/agents/_agent_utility::agentfunc("think") ]]();
	if(!self.hasdied)
	{
		maps\mp\gametypes\_spawnlogic::addtoparticipantsarray();
	}

	self.hasdied = 0;
	thread maps\mp\gametypes\_weapons::onplayerspawned();
	thread maps\mp\gametypes\_healthoverlay::func_5FB3();
	thread maps\mp\gametypes\_battlechatter_mp::onplayerspawned();
	level notify("spawned_agent_player",self);
	level notify("spawned_agent",self);
	self notify("spawned_player");
}

//Function Number: 6
func_2657(param_00)
{
	self endon("death");
	param_00 waittill("killstreak_disowned");
	self notify("owner_disconnect");
	if(maps\mp\gametypes\_hostmigration::func_8BBA())
	{
		wait(0.05);
	}

	self suicide();
}

//Function Number: 7
agent_damage_finished(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	if(isdefined(param_00) || isdefined(param_01))
	{
		if(!isdefined(param_00))
		{
			param_00 = param_01;
		}

		if(isdefined(self.allowvehicledamage) && !self.allowvehicledamage)
		{
			if(isdefined(param_00.classname) && param_00.classname == "script_vehicle")
			{
				return 0;
			}
		}

		if(isdefined(param_00.classname) && param_00.classname == "auto_turret")
		{
			param_01 = param_00;
		}

		if(isdefined(param_01) && param_04 != "MOD_FALLING" && param_04 != "MOD_SUICIDE")
		{
			if(level.teambased)
			{
				if(isdefined(param_01.team) && param_01.team != self.team)
				{
					self setagentattacker(param_01);
				}
			}
			else
			{
				self setagentattacker(param_01);
			}
		}
	}

	self finishagentdamage(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,0);
	if(!isdefined(self.isactive))
	{
		self.waitingtodeactivate = 1;
	}

	return 1;
}

//Function Number: 8
func_58D6(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	var_0A = isdefined(param_01) && isdefined(self.owner) && self.owner == param_01;
	var_0B = maps\mp\_utility::attackerishittingteam(self.owner,param_01) || var_0A;
	if(level.teambased && var_0B && !level.friendlyfire)
	{
		return 0;
	}

	if(!level.teambased && var_0A)
	{
		return 0;
	}

	if(isdefined(param_04) && param_04 == "MOD_CRUSH" && isdefined(param_00) && isdefined(param_00.classname) && param_00.classname == "script_vehicle")
	{
		return 0;
	}

	if(!isdefined(self) || !maps\mp\_utility::func_4945(self))
	{
		return 0;
	}

	if(isdefined(param_01) && param_01.classname == "script_origin" && isdefined(param_01.type) && param_01.type == "soft_landing")
	{
		return 0;
	}

	if(param_05 == "killstreak_emp_mp")
	{
		return 0;
	}

	if(param_05 == "bouncingbetty_mp" && !maps\mp\gametypes\_weapons::func_5244(param_00,self))
	{
		return 0;
	}

	if((param_05 == "throwingknife_mp" || param_05 == "throwingknifejugg_mp") && param_04 == "MOD_IMPACT")
	{
		param_02 = self.health + 1;
	}

	if(isdefined(param_00) && isdefined(param_00.stuckenemyentity) && param_00.stuckenemyentity == self)
	{
		param_02 = self.health + 1;
	}

	if(param_02 <= 0)
	{
		return 0;
	}

	if(isdefined(param_01) && param_01 != self && param_02 > 0 && !isdefined(param_08) || param_08 != "shield")
	{
		if(param_03 & level.idflags_stun)
		{
			var_0C = "stun";
		}
		else if(!maps\mp\gametypes\_damage::func_74D2(param_06))
		{
			var_0C = "none";
		}
		else
		{
			var_0C = common_scripts\utility::func_803F(param_03 >= self.health,"hitkill","standard");
		}

		param_01 thread maps\mp\gametypes\_damagefeedback::func_86E0(var_0C);
	}

	if(isdefined(level.modifyplayerdamage))
	{
		param_02 = [[ level.modifyplayerdamage ]](self,param_01,param_02,param_04,param_05,param_06,param_07,param_08);
	}

	return self [[ maps/mp/agents/_agent_utility::agentfunc("on_damaged_finished") ]](param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09);
}

//Function Number: 9
func_58D7(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	var_0A = isdefined(param_01) && isdefined(self.owner) && self.owner == param_01;
	if(!level.teambased && var_0A)
	{
		return 0;
	}

	maps\mp\gametypes\_damage::callback_playerdamage(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09);
}

//Function Number: 10
func_58D8(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	func_58E5(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,1);
	if(isplayer(param_01) && !isdefined(self.owner) || param_01 != self.owner)
	{
		maps\mp\gametypes\_damage::onkillstreakkilled(param_01,param_04,param_03,param_02,"destroyed_squad_mate");
	}

	maps\mp\gametypes\_weapons::dropscavengerfordeath(param_01);
	if(self.isactive)
	{
		self.hasdied = 1;
		if(maps\mp\_utility::func_3ABB() != 1 && isdefined(self.respawn_on_death) && self.respawn_on_death)
		{
			self thread [[ maps/mp/agents/_agent_utility::agentfunc("spawn") ]]();
		}

		maps/mp/agents/_agent_utility::func_233F();
	}
}

//Function Number: 11
func_58E5(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	if(self.hasriotshieldequipped)
	{
		maps\mp\gametypes\_damage::func_4D00(param_02,param_03);
		if(!param_09)
		{
			var_0A = self dropitem(self getcurrentweapon());
			if(isdefined(var_0A))
			{
				var_0A thread maps\mp\gametypes\_weapons::deletepickupafterawhile();
				var_0A.owner = self;
				var_0A.ownersattacker = param_01;
				var_0A makeunusable();
			}
		}
	}

	if(param_09)
	{
		self [[ level.weapondropfunction ]](param_01,param_03);
	}

	self.body = self cloneagent(param_08);
	thread maps\mp\gametypes\_damage::func_252D(self.body,param_06,param_05,param_04,param_00,param_03);
	maps\mp\_utility::func_66D1();
}

//Function Number: 12
func_4640()
{
	if(isdefined(self.class_override))
	{
		self.class = self.class_override;
	}

	if(maps/mp/bots/_bots_loadout::func_1691())
	{
		self.class = "callback";
	}

	self.class = "class1";
}