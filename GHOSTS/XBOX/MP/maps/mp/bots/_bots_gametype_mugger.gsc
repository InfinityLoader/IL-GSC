/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\bots\_bots_gametype_mugger.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 13
 * Decompile Time: 268 ms
 * Timestamp: 10/27/2023 1:28:31 AM
*******************************************************************/

//Function Number: 1
func_4FDD()
{
	level.bot_tag_obj_radius = 200;
	func_710C();
}

//Function Number: 2
func_710C()
{
	level.bot_funcs["gametype_think"] = ::func_9002;
	level.bot_funcs["gametype_loadout_modify"] = ::func_9001;
}

//Function Number: 3
func_9002()
{
	self notify("bot_mugger_think");
	self endon("bot_mugger_think");
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	self.last_killtag_tactical_goal_pos = (0,0,0);
	self.tag_getting = undefined;
	self.heading_for_tag_pile = 0;
	self.hiding_until_bank = 0;
	self.default_meleechargedist = self botgetdifficultysetting("meleeChargeDist");
	childthread func_94FA();
	if(self botgetdifficultysetting("strategyLevel") > 0)
	{
		childthread func_94F9();
	}

	if(self botgetdifficultysetting("strategyLevel") > 0)
	{
		childthread func_9138();
	}

	for(;;)
	{
		if(self botgetdifficultysetting("strategyLevel") > 1)
		{
			if(isdefined(self.tags_carried) && level.mugger_bank_limit <= self.tags_carried)
			{
				if(!self.hiding_until_bank)
				{
					var_00 = getnodesinradius(self.origin,1000,0,500,"node_hide");
					var_01 = self botnodepick(var_00,3,"node_hide");
					if(isdefined(var_01))
					{
						self botsetscriptgoalnode(var_01,"critical");
						self.hiding_until_bank = 1;
					}
				}
			}
			else if(self.hiding_until_bank)
			{
				self botclearscriptgoal();
				self.hiding_until_bank = 0;
			}
		}

		if(!self.hiding_until_bank)
		{
			if(!isdefined(self.tag_getting) && !self.heading_for_tag_pile)
			{
				self [[ self.personality_update_function ]]();
			}
		}

		wait(0.05);
	}
}

//Function Number: 4
func_9138()
{
	for(;;)
	{
		if(self botgetdifficultysetting("strategyLevel") < 2)
		{
			wait(0.5);
		}
		else
		{
			wait(0.2);
		}

		if(isdefined(self.enemy) && isplayer(self.enemy) && isdefined(self.enemy.tags_carried) && self.enemy.tags_carried >= 3 && self botcanseeentity(self.enemy) && distance(self.origin,self.enemy.origin) <= 500)
		{
			self botsetdifficultysetting("meleeChargeDist",500);
			self botsetflag("prefer_melee",1);
			self botsetflag("throw_knife_melee",level.mugger_throwing_knife_mug_frac > 0);
			continue;
		}

		self botsetdifficultysetting("meleeChargeDist",self.default_meleechargedist);
		self botsetflag("prefer_melee",0);
		self botsetflag("throw_knife_melee",0);
	}
}

//Function Number: 5
func_94F9()
{
	for(;;)
	{
		level waittill("mugger_tag_pile",var_00);
		if(self.health <= 0)
		{
			continue;
		}

		if(self.hiding_until_bank)
		{
			continue;
		}

		if(!isdefined(self.last_tag_pile_time) || gettime() - self.last_tag_pile_time > 7500)
		{
			self.last_tag_pile_time = undefined;
			self.last_tag_pile_location = undefined;
			self.heading_for_tag_pile = 0;
		}

		if(!isdefined(self.last_tag_pile_location) || distancesquared(self.origin,self.last_tag_pile_location) > distancesquared(self.origin,var_00))
		{
			self.last_tag_pile_time = gettime();
			self.last_tag_pile_location = var_00;
		}
	}
}

//Function Number: 6
func_8FEA()
{
	var_00 = self getnearestnode();
	var_01 = undefined;
	if(isdefined(var_00))
	{
		var_02 = 1000000;
		var_03 = common_scripts\utility::array_combine(level.dogtags,level.mugger_extra_tags);
		foreach(var_05 in var_03)
		{
			if(var_05 maps\mp\gametypes\_gameobjects::func_19CA(self.team))
			{
				var_06 = distancesquared(self.origin,var_05.curorigin);
				if(!isdefined(var_01) || var_06 < var_02)
				{
					if((self botgetdifficultysetting("strategyLevel") > 0 && var_06 < 122500) || var_06 < 1000000 && maps/mp/bots/_bots_gametype_conf::func_8FFA(var_05,var_00,self botgetfovdot()))
					{
						var_02 = var_06;
						var_01 = var_05;
					}
				}
			}
		}
	}

	return var_01;
}

//Function Number: 7
bot_find_visible_tags_mugger(param_00,param_01)
{
	var_02 = [];
	if(isdefined(param_00))
	{
		var_03 = common_scripts\utility::array_combine(level.dogtags,level.mugger_extra_tags);
		foreach(var_05 in var_03)
		{
			if(var_05 maps\mp\gametypes\_gameobjects::func_19CA(self.team))
			{
				if(isplayer(self) || distancesquared(self.origin,var_05.curorigin) < 1000000)
				{
					if(maps/mp/bots/_bots_gametype_conf::func_8FFA(var_05,param_00,param_01))
					{
						var_06 = addstruct();
						var_06.origin = var_05.curorigin;
						var_06.tag = var_05;
						var_02[var_02.size] = var_06;
					}
				}
			}
		}
	}

	return var_02;
}

//Function Number: 8
func_94FA()
{
	wait(randomfloatrange(0,0.5));
	for(;;)
	{
		if(self botgetdifficultysetting("strategyLevel") == 0)
		{
			wait(3);
		}
		else if(self botgetdifficultysetting("strategyLevel") == 1)
		{
			wait(1.5);
		}
		else
		{
			wait(0.5);
		}

		if(self.health <= 0)
		{
			continue;
		}

		if(self.hiding_until_bank)
		{
			continue;
		}

		if(isdefined(self.enemy) && isplayer(self.enemy) && self botcanseeentity(self.enemy))
		{
			continue;
		}

		var_00 = func_8FEA();
		if(isdefined(var_00))
		{
			func_935C(var_00);
			continue;
		}

		if(!self.heading_for_tag_pile)
		{
			if(isdefined(self.last_tag_pile_location) && isdefined(self.last_tag_pile_time) && gettime() - self.last_tag_pile_time <= 7500)
			{
				thread func_935B(self.last_tag_pile_location);
			}
		}
	}
}

//Function Number: 9
func_935B(param_00)
{
	self endon("disconnect");
	level endon("game_ended");
	self.heading_for_tag_pile = 1;
	var_01 = addstruct();
	var_01.script_goal_type = "objective";
	var_01.objective_radius = level.bot_tag_obj_radius;
	maps/mp/bots/_bots_strategy::bot_new_tactical_goal("kill_tag_pile",param_00,25,var_01);
	var_02 = common_scripts\utility::func_8B33("death","tag_spotted");
	self botclearscriptgoal();
	self.heading_for_tag_pile = 0;
	maps/mp/bots/_bots_strategy::bot_abort_tactical_goal("kill_tag_pile");
}

//Function Number: 10
func_935C(param_00)
{
	self endon("disconnect");
	level endon("game_ended");
	self.tag_getting = param_00;
	self notify("tag_spotted");
	childthread func_936B(param_00,"tag_picked_up");
	maps/mp/bots/_bots_strategy::bot_abort_tactical_goal("kill_tag");
	var_01 = param_00.curorigin;
	if(maps/mp/bots/_bots_util::func_16C0(self.last_killtag_tactical_goal_pos,param_00.curorigin))
	{
		var_02 = param_00.nearest_node;
		if(isdefined(var_02))
		{
			var_03 = var_02.origin - var_01;
			var_01 = var_01 + vectornormalize(var_03) * length(var_03) * 0.5;
		}
	}

	self.last_killtag_tactical_goal_pos = param_00.curorigin;
	var_04 = addstruct();
	var_04.script_goal_type = "objective";
	var_04.objective_radius = level.bot_tag_obj_radius;
	maps/mp/bots/_bots_strategy::bot_new_tactical_goal("kill_tag",var_01,25,var_04);
	thread func_936A("tag_aborted");
	var_05 = common_scripts\utility::func_8B33("death","tag_picked_up");
	self notify("tag_watch_stop");
	self.tag_getting = undefined;
	self botclearscriptgoal();
	maps/mp/bots/_bots_strategy::bot_abort_tactical_goal("kill_tag");
}

//Function Number: 11
func_936A(param_00)
{
	self endon("disconnect");
	level endon("game_ended");
	self endon("tag_watch_stop");
	while(maps/mp/bots/_bots_strategy::bot_has_tactical_goal("kill_tag"))
	{
		wait(0.05);
	}

	self notify(param_00);
}

//Function Number: 12
func_936B(param_00,param_01)
{
	self endon("disconnect");
	level endon("game_ended");
	self endon("tag_watch_stop");
	while(param_00 maps\mp\gametypes\_gameobjects::func_19CA(self.team))
	{
		wait(0.05);
	}

	self notify(param_01);
}

//Function Number: 13
func_9001(param_00)
{
	var_01 = 0;
	var_02 = self botgetdifficulty();
	if(var_02 == "recruit")
	{
		var_01 = 0.1;
	}
	else if(var_02 == "regular")
	{
		var_01 = 0.25;
	}
	else if(var_02 == "hardened")
	{
		var_01 = 0.6;
	}
	else if(var_02 == "veteran")
	{
		var_01 = 0.9;
	}

	var_03 = param_00["loadoutEquipment"] == "throwingknife_mp";
	if(!var_03)
	{
		if(var_01 >= randomfloat(1))
		{
			param_00["loadoutEquipment"] = "throwingknife_mp";
			var_03 = 1;
		}
	}

	if(var_01 >= randomfloat(1))
	{
		if(param_00["loadoutOffhand"] != "concussion_grenade_mp")
		{
			param_00["loadoutOffhand"] = "concussion_grenade_mp";
		}
	}

	if(var_01 >= randomfloat(1))
	{
		if(param_00["loadoutPrimaryAttachment"] != "tactical" && param_00["loadoutPrimaryAttachment2"] != "tactical")
		{
			var_04 = maps/mp/bots/_bots_loadout::bot_validate_weapon(param_00["loadoutPrimary"],param_00["loadoutPrimaryAttachment"],"tactical");
			if(var_04)
			{
				param_00["loadoutPrimaryAttachment2"] = "tactical";
			}
			else
			{
				var_04 = maps/mp/bots/_bots_loadout::bot_validate_weapon(param_00["loadoutPrimary"],"tactical",param_00["loadoutPrimaryAttachment2"]);
				if(var_04)
				{
					param_00["loadoutPrimaryAttachment"] = "tactical";
				}
			}
		}
	}

	if(var_01 >= randomfloat(1))
	{
		if(param_00["loadoutSecondaryAttachment"] != "tactical" && param_00["loadoutSecondaryAttachment2"] != "tactical")
		{
			var_04 = maps/mp/bots/_bots_loadout::bot_validate_weapon(param_00["loadoutSecondary"],param_00["loadoutSecondaryAttachment"],"tactical");
			if(var_04)
			{
				param_00["loadoutSecondaryAttachment2"] = "tactical";
			}
			else
			{
				var_04 = maps/mp/bots/_bots_loadout::bot_validate_weapon(param_00["loadoutSecondary"],"tactical",param_00["loadoutSecondaryAttachment2"]);
				if(var_04)
				{
					param_00["loadoutSecondaryAttachment"] = "tactical";
				}
			}
		}
	}

	var_05 = [];
	var_06 = [];
	var_07 = [];
	var_08 = [];
	if(var_03)
	{
		var_08[var_08.size] = "specialty_extra_deadly";
	}

	var_08[var_08.size] = "specialty_lightweight";
	var_08[var_08.size] = "specialty_marathon";
	var_08[var_08.size] = "specialty_fastsprintrecovery";
	var_08[var_08.size] = "specialty_stun_resistance";
	for(var_09 = 1;var_09 < 9;var_09++)
	{
		if(isdefined(param_00["loadoutPerk" + var_09]))
		{
			if(param_00["loadoutPerk" + var_09] != "none")
			{
				var_05[var_05.size] = param_00["loadoutPerk" + var_09];
				var_06[var_06.size] = var_09;
				continue;
			}

			var_07[var_07.size] = var_09;
		}
	}

	foreach(var_0B in var_08)
	{
		if(var_01 >= randomfloat(1))
		{
			if(!common_scripts\utility::array_contains(var_05,var_0B))
			{
				var_0C = -1;
				if(var_07.size)
				{
					var_0C = var_07[0];
					var_07 = common_scripts\utility::array_remove(var_07,var_0C);
				}
				else if(var_06.size)
				{
					var_0C = common_scripts\utility::func_6306(var_06);
					var_06 = common_scripts\utility::array_remove(var_06,var_0C);
				}

				if(var_0C != -1)
				{
					param_00["loadoutPerk" + var_0C] = var_0B;
				}
			}
		}
	}

	if(var_01 >= randomfloat(1))
	{
		if(param_00["loadoutStreakType"] == "streaktype_assault" && param_00["loadoutStreak1"] != "airdrop_juggernaut_maniac" && param_00["loadoutStreak2"] != "airdrop_juggernaut_maniac" && param_00["loadoutStreak3"] != "airdrop_juggernaut_maniac")
		{
			param_00["loadoutStreak3"] = "airdrop_juggernaut_maniac";
		}
	}

	return param_00;
}