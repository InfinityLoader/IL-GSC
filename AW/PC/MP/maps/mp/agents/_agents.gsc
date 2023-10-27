/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\agents\_agents.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 13
 * Decompile Time: 238 ms
 * Timestamp: 10/27/2023 1:40:59 AM
*******************************************************************/

//Function Number: 1
main()
{
	if(isdefined(level.createfx_enabled) && level.createfx_enabled)
	{
		return;
	}

	setup_callbacks();
	level.badplace_cylinder_func = ::badplace_cylinder;
	level.badplace_delete_func = ::badplace_delete;
	level thread maps\mp\agents\_agent_common::init();
	if(!maps\mp\_utility::invirtuallobby() && !isdefined(level.iszombiegame) && level.iszombiegame)
	{
		level thread maps\mp\killstreaks\_agent_killstreak::init();
		level thread maps\mp\killstreaks\_dog_killstreak::init();
	}
}

//Function Number: 2
setup_callbacks()
{
	if(!isdefined(level.agent_funcs))
	{
		level.agent_funcs = [];
	}

	if(!isdefined(level.iszombiegame) && level.iszombiegame)
	{
		level.agent_funcs["player"] = [];
		level.agent_funcs["player"]["spawn"] = ::spawn_agent_player;
		level.agent_funcs["player"]["think"] = ::maps\mp\bots\_bots_gametype_war::bot_war_think;
		level.agent_funcs["player"]["on_killed"] = ::on_agent_player_killed;
		level.agent_funcs["player"]["on_damaged"] = ::on_agent_player_damaged;
		level.agent_funcs["player"]["on_damaged_finished"] = ::agent_damage_finished;
		maps\mp\killstreaks\_agent_killstreak::setup_callbacks();
		maps\mp\killstreaks\_dog_killstreak::setup_callbacks();
	}
}

//Function Number: 3
wait_till_agent_funcs_defined()
{
	while(!isdefined(level.agent_funcs))
	{
		wait(0.05);
	}
}

//Function Number: 4
add_humanoid_agent(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	var_09 = maps\mp\agents\_agent_common::connectnewagent(param_00,param_01,param_02);
	if(isdefined(var_09))
	{
		var_09 thread [[ var_09 maps\mp\agents\_agent_utility::agentfunc("spawn") ]](param_03,param_04,param_05,param_06,param_07,param_08);
	}

	return var_09;
}

//Function Number: 5
spawn_agent_player(param_00,param_01,param_02,param_03,param_04,param_05)
{
	self endon("disconnect");
	while(!isdefined(level.getspawnpoint))
	{
		wait 0.05;
	}

	if(self.hasdied)
	{
		wait(randomintrange(6,10));
	}

	maps\mp\agents\_agent_utility::initplayerscriptvariables(1);
	if(isdefined(param_00) && isdefined(param_01))
	{
		var_06 = param_00;
		var_07 = param_01;
		self.lastspawnpoint = spawnstruct();
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

	maps\mp\agents\_agent_utility::activateagent();
	self.lastspawntime = gettime();
	self.spawntime = gettime();
	var_09 = var_06 + (0,0,25);
	var_0A = var_06;
	var_0B = playerphysicstrace(var_09,var_0A);
	if(distancesquared(var_0B,var_09) > 1)
	{
		var_06 = var_0B;
	}

	self spawnagent(var_06,var_07);
	if(isdefined(param_05))
	{
		self.agent_override_difficulty = param_05;
	}

	if(isdefined(self.agent_override_difficulty))
	{
		if(self.agent_override_difficulty == "follow_code_and_dev_dvar")
		{
			maps\mp\bots\_bots_util::bot_set_difficulty(self botgetdifficulty(),1);
		}
		else
		{
			maps\mp\bots\_bots_util::bot_set_difficulty(param_05);
		}
	}
	else
	{
		maps\mp\bots\_bots_util::bot_set_difficulty(self botgetdifficulty());
	}

	if(isdefined(param_03) && param_03)
	{
		self.use_randomized_personality = 1;
	}

	if(isdefined(self.use_randomized_personality) && self.use_randomized_personality)
	{
		if(!self.hasdied)
		{
			var_0C = self botgetdifficultysetting("advancedPersonality");
			if(isdefined(var_0C) && var_0C != 0)
			{
				maps\mp\bots\_bots_personality::bot_balance_personality();
			}
		}

		maps\mp\bots\_bots_personality::bot_assign_personality_functions();
	}
	else
	{
		maps\mp\bots\_bots_util::bot_set_personality("default");
	}

	initplayerclass();
	maps\mp\agents\_agent_common::set_agent_health(100);
	if(isdefined(param_04) && param_04)
	{
		self.respawn_on_death = 1;
	}

	if(isdefined(param_02))
	{
		maps\mp\agents\_agent_utility::set_agent_team(param_02.team,param_02);
	}

	if(isdefined(self.owner))
	{
		thread destroyonownerdisconnect(self.owner);
	}

	thread maps\mp\_flashgrenades::monitorflash();
	self enableanimstate(0);
	self [[ level.onspawnplayer ]]();
	maps\mp\gametypes\_class::giveandapplyloadout(self.team,self.class,1);
	thread maps\mp\bots\_bots::bot_think_watch_enemy(1);
	thread maps\mp\bots\_bots::bot_think_crate();
	if(self.agent_type == "player")
	{
		thread maps\mp\bots\_bots::bot_think_level_actions();
	}
	else if(self.agent_type == "odin_juggernaut")
	{
		thread maps\mp\bots\_bots::bot_think_level_actions(128);
	}

	thread maps\mp\bots\_bots_strategy::bot_think_tactical_goals();
	self thread [[ maps\mp\agents\_agent_utility::agentfunc("think") ]]();
	if(!self.hasdied)
	{
		maps\mp\gametypes\_spawnlogic::addtoparticipantsarray();
	}

	if(!self.hasdied)
	{
		thread maps\mp\gametypes\_weapons::onplayerspawned();
		thread maps\mp\gametypes\_battlechatter_mp::onplayerspawned();
	}

	self.hasdied = 0;
	thread maps\mp\gametypes\_healthoverlay::playerhealthregen();
	if(isdefined(self.use_randomized_personality) && self.use_randomized_personality && isdefined(self.respawn_on_death) && self.respawn_on_death)
	{
		self setagentcostumeindex(1);
	}

	level notify("spawned_agent_player",self);
	level notify("spawned_agent",self);
	level notify("player_spawned",self);
	self notify("spawned_player");
}

//Function Number: 6
destroyonownerdisconnect(param_00)
{
	self endon("death");
	param_00 waittill("killstreak_disowned");
	self notify("owner_disconnect");
	if(maps\mp\gametypes\_hostmigration::waittillhostmigrationdone())
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

	var_0A = maps\mp\gametypes\_damage::shouldplayblastimpact(param_03,param_04,param_05);
	var_0B = self finishagentdamage(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,0,var_0A);
	if(isdefined(var_0B))
	{
		thread finishagentdamage_impactfxwrapper(var_0B[0],var_0B[1],var_0B[2],var_0B[3],var_0B[4],var_0B[5],var_0B[6]);
	}

	if(!isdefined(self.isactive))
	{
		self.waitingtodeactivate = 1;
	}

	return 1;
}

//Function Number: 8
finishagentdamage_impactfxwrapper(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	waittillframeend;
	if(!isdefined(self) || !isdefined(param_00))
	{
		return;
	}

	self finishagentdamage_impactfx(param_00,param_01,param_02,param_03,param_04,param_05,param_06);
}

//Function Number: 9
on_agent_generic_damaged(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
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

	if(!isdefined(self) || !maps\mp\_utility::isreallyalive(self))
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

	if(param_05 == "bouncingbetty_mp" && !maps\mp\gametypes\_weapons::minedamageheightpassed(param_00,self))
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

	if(isdefined(level.modifyplayerdamage))
	{
		param_02 = [[ level.modifyplayerdamage ]](self,param_00,param_01,param_02,param_04,param_05,param_06,param_07,param_08);
	}

	if(isdefined(param_01) && param_01 != self && param_02 > 0 && !isdefined(param_08) || param_08 != "shield")
	{
		if(param_03 & level.idflags_stun)
		{
			var_0C = "stun";
		}
		else if(!maps\mp\gametypes\_damage::shouldweaponfeedback(param_06))
		{
			var_0C = "none";
		}
		else
		{
			var_0C = "standard";
			if(isdefined(level.iszombiegame) && level.iszombiegame)
			{
				if(param_05 == "trap_zm_mp" || param_05 == "zombie_vaporize_mp" || param_05 == "zombie_trap_turret_mp" || param_05 == "zombie_water_trap_mp")
				{
					var_0C = "none";
				}
				else
				{
					if(param_05 == "iw5_microwavezm_mp")
					{
						var_0C = "nosound";
					}

					if(param_02 < self.health)
					{
						switch(param_08)
						{
							case "neck":
							case "helmet":
							case "head":
								break;
						}
					}
				}
			}
		}
	}
}

//Function Number: 10
on_agent_player_damaged(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	var_0A = isdefined(param_01) && isdefined(self.owner) && self.owner == param_01;
	if(!level.teambased && var_0A)
	{
		return 0;
	}

	maps\mp\gametypes\_damage::callback_playerdamage(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09);
}

//Function Number: 11
on_agent_player_killed(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	on_humanoid_agent_killed_common(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,1);
	if(isplayer(param_01) && !isdefined(self.owner) || param_01 != self.owner && !isdefined(self.nonkillstreakagent) || !self.nonkillstreakagent)
	{
		maps\mp\gametypes\_damage::onkillstreakkilled(param_01,param_04,param_03,param_02,"destroyed_squad_mate");
	}

	if(isdefined(level.on_agent_player_killed))
	{
		[[ level.on_agent_player_killed ]](param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08);
	}

	thread maps\mp\gametypes\_weapons::dropscavengerfordeath(param_01);
	if(self.isactive)
	{
		self.hasdied = 1;
		if(maps\mp\_utility::getgametypenumlives() != 1 && isdefined(self.respawn_on_death) && self.respawn_on_death)
		{
			self thread [[ maps\mp\agents\_agent_utility::agentfunc("spawn") ]]();
			return;
		}

		maps\mp\agents\_agent_utility::deactivateagent();
	}
}

//Function Number: 12
on_humanoid_agent_killed_common(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	if(maps\mp\_riotshield::hasriotshieldequipped())
	{
		maps\mp\gametypes\_damage::launchshield(param_02,param_03);
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
		self thread [[ level.weapondropfunction ]](param_01,param_03);
	}

	if(!isdefined(self.bypassagentcorpse) || !self.bypassagentcorpse)
	{
		self.body = self finishagentdamage(param_08);
		if(isdefined(level.agentshouldragdollimmediatelyfunc) && [[ level.agentshouldragdollimmediatelyfunc ]](param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09))
		{
			self.body startragdoll();
			if(!self.body isragdoll())
			{
				thread maps\mp\gametypes\_damage::delaystartragdoll(self.body,param_06,param_05,param_04,param_00,param_03);
			}
		}
		else
		{
			thread maps\mp\gametypes\_damage::delaystartragdoll(self.body,param_06,param_05,param_04,param_00,param_03);
		}
	}

	maps\mp\_riotshield::riotshield_clear();
}

//Function Number: 13
initplayerclass()
{
	if(isdefined(self.class_override))
	{
		self.class = self.class_override;
		return;
	}

	if(maps\mp\bots\_bots_loadout::bot_setup_loadout_callback())
	{
		self.class = "callback";
		return;
	}

	self.class = "class1";
}