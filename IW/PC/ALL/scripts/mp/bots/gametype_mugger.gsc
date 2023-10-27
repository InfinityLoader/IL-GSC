/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\bots\gametype_mugger.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 13
 * Decompile Time: 696 ms
 * Timestamp: 10/27/2023 12:12:04 AM
*******************************************************************/

//Function Number: 1
main()
{
	level.var_2EA7 = 200;
	func_F8F4();
}

//Function Number: 2
func_F8F4()
{
	level.var_2D9E["gametype_think"] = ::func_2E26;
	level.var_2D9E["gametype_loadout_modify"] = ::func_2E25;
}

//Function Number: 3
func_2E26()
{
	self notify("bot_mugger_think");
	self endon("bot_mugger_think");
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	self.var_A8D9 = (0,0,0);
	self.var_113DD = undefined;
	self.var_8C7C = 0;
	self.var_8EE1 = 0;
	self.var_5001 = self botgetdifficultysetting("meleeChargeDist");
	childthread func_113ED();
	if(self botgetdifficultysetting("strategyLevel") > 0)
	{
		childthread func_113E3();
	}

	if(self botgetdifficultysetting("strategyLevel") > 0)
	{
		childthread func_6541();
	}

	for(;;)
	{
		if(self botgetdifficultysetting("strategyLevel") > 1)
		{
			if(isdefined(self.var_1141D) && level.var_BD7D <= self.var_1141D)
			{
				if(!self.var_8EE1)
				{
					var_00 = getnodesinradius(self.origin,1000,0,500,"node_hide");
					var_01 = self botnodepick(var_00,3,"node_hide");
					if(isdefined(var_01))
					{
						self botsetscriptgoalnode(var_01,"critical");
						self.var_8EE1 = 1;
					}
				}
			}
			else if(self.var_8EE1)
			{
				self botclearscriptgoal();
				self.var_8EE1 = 0;
			}
		}

		if(!self.var_8EE1)
		{
			if(!isdefined(self.var_113DD) && !self.var_8C7C)
			{
				self [[ self.var_CA7B ]]();
			}
		}

		wait(0.05);
	}
}

//Function Number: 4
func_6541()
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

		if(isdefined(self.var_10C) && isplayer(self.var_10C) && isdefined(self.var_10C.var_1141D) && self.var_10C.var_1141D >= 3 && self botcanseeentity(self.var_10C) && distance(self.origin,self.var_10C.origin) <= 500)
		{
			self method_804D("meleeChargeDist",500);
			self botsetflag("prefer_melee",1);
			self botsetflag("throw_knife_melee",level.var_BDA6 > 0);
			continue;
		}

		self method_804D("meleeChargeDist",self.var_5001);
		self botsetflag("prefer_melee",0);
		self botsetflag("throw_knife_melee",0);
	}
}

//Function Number: 5
func_113E3()
{
	for(;;)
	{
		level waittill("mugger_tag_pile",var_00);
		if(self.health <= 0)
		{
			continue;
		}

		if(self.var_8EE1)
		{
			continue;
		}

		if(!isdefined(self.var_A91B) || gettime() - self.var_A91B > 7500)
		{
			self.var_A91B = undefined;
			self.var_A91A = undefined;
			self.var_8C7C = 0;
		}

		if(!isdefined(self.var_A91A) || distancesquared(self.origin,self.var_A91A) > distancesquared(self.origin,var_00))
		{
			self.var_A91B = gettime();
			self.var_A91A = var_00;
		}
	}
}

//Function Number: 6
func_2D75()
{
	var_00 = self getnearestnode();
	var_01 = undefined;
	if(isdefined(var_00))
	{
		var_02 = 1000000;
		var_03 = scripts\common\utility::array_combine(level.var_58C0,level.var_BD82);
		foreach(var_05 in var_03)
		{
			if(var_05 scripts\mp\_gameobjects::caninteractwith(self.team))
			{
				var_06 = distancesquared(self.origin,var_05.var_4B2C);
				if(!isdefined(var_01) || var_06 < var_02)
				{
					if((self botgetdifficultysetting("strategyLevel") > 0 && var_06 < 122500) || var_06 < 1000000 && scripts\mp\bots\gametype_conf::func_2DE1(var_05,var_00,self botgetfovdot()))
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
func_2D7D(param_00,param_01)
{
	var_02 = [];
	if(isdefined(param_00))
	{
		var_03 = scripts\common\utility::array_combine(level.var_58C0,level.var_BD82);
		foreach(var_05 in var_03)
		{
			if(var_05 scripts\mp\_gameobjects::caninteractwith(self.team))
			{
				if(isplayer(self) || distancesquared(self.origin,var_05.var_4B2C) < 1000000)
				{
					if(scripts\mp\bots\gametype_conf::func_2DE1(var_05,param_00,param_01))
					{
						var_06 = spawnstruct();
						var_06.origin = var_05.var_4B2C;
						var_06.var_2DD = var_05;
						var_02[var_02.size] = var_06;
					}
				}
			}
		}
	}

	return var_02;
}

//Function Number: 8
func_113ED()
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

		if(self.var_8EE1)
		{
			continue;
		}

		if(isdefined(self.var_10C) && isplayer(self.var_10C) && self botcanseeentity(self.var_10C))
		{
			continue;
		}

		var_00 = func_2D75();
		if(isdefined(var_00))
		{
			func_BD9F(var_00);
			continue;
		}

		if(!self.var_8C7C)
		{
			if(isdefined(self.var_A91A) && isdefined(self.var_A91B) && gettime() - self.var_A91B <= 7500)
			{
				thread func_BD86(self.var_A91A);
			}
		}
	}
}

//Function Number: 9
func_BD86(param_00)
{
	self endon("disconnect");
	level endon("game_ended");
	self.var_8C7C = 1;
	var_01 = spawnstruct();
	var_01.var_EDCA = "objective";
	var_01.var_C293 = level.var_2EA7;
	scripts\mp\bots\_bots_strategy::func_2E27("kill_tag_pile",param_00,25,var_01);
	var_02 = scripts\common\utility::func_13734("death","tag_spotted");
	self botclearscriptgoal();
	self.var_8C7C = 0;
	scripts\mp\bots\_bots_strategy::func_2D02("kill_tag_pile");
}

//Function Number: 10
func_BD9F(param_00)
{
	self endon("disconnect");
	level endon("game_ended");
	self.var_113DD = param_00;
	self notify("tag_spotted");
	childthread func_C157(param_00,"tag_picked_up");
	scripts\mp\bots\_bots_strategy::func_2D02("kill_tag");
	var_01 = param_00.var_4B2C;
	if(scripts\mp\bots\_bots_util::func_2EC6(self.var_A8D9,param_00.var_4B2C))
	{
		var_02 = param_00.nearest_node;
		if(isdefined(var_02))
		{
			var_03 = var_02.origin - var_01;
			var_01 = var_01 + vectornormalize(var_03) * length(var_03) * 0.5;
		}
	}

	self.var_A8D9 = param_00.var_4B2C;
	var_04 = spawnstruct();
	var_04.var_EDCA = "objective";
	var_04.var_C293 = level.var_2EA7;
	scripts\mp\bots\_bots_strategy::func_2E27("kill_tag",var_01,25,var_04);
	thread func_C156("tag_aborted");
	var_05 = scripts\common\utility::func_13734("death","tag_picked_up");
	self notify("tag_watch_stop");
	self.var_113DD = undefined;
	self botclearscriptgoal();
	scripts\mp\bots\_bots_strategy::func_2D02("kill_tag");
}

//Function Number: 11
func_C156(param_00)
{
	self endon("disconnect");
	level endon("game_ended");
	self endon("tag_watch_stop");
	while(scripts\mp\bots\_bots_strategy::func_2DC5("kill_tag"))
	{
		wait(0.05);
	}

	self notify(param_00);
}

//Function Number: 12
func_C157(param_00,param_01)
{
	self endon("disconnect");
	level endon("game_ended");
	self endon("tag_watch_stop");
	while(param_00 scripts\mp\_gameobjects::caninteractwith(self.team))
	{
		wait(0.05);
	}

	self notify(param_01);
}

//Function Number: 13
func_2E25(param_00)
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
			var_04 = scripts\mp\bots\_bots_loadout::func_2EC2(param_00["loadoutPrimary"],param_00["loadoutPrimaryAttachment"],"tactical");
			if(var_04)
			{
				param_00["loadoutPrimaryAttachment2"] = "tactical";
			}
			else
			{
				var_04 = scripts\mp\bots\_bots_loadout::func_2EC2(param_00["loadoutPrimary"],"tactical",param_00["loadoutPrimaryAttachment2"]);
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
			var_04 = scripts\mp\bots\_bots_loadout::func_2EC2(param_00["loadoutSecondary"],param_00["loadoutSecondaryAttachment"],"tactical");
			if(var_04)
			{
				param_00["loadoutSecondaryAttachment2"] = "tactical";
			}
			else
			{
				var_04 = scripts\mp\bots\_bots_loadout::func_2EC2(param_00["loadoutSecondary"],"tactical",param_00["loadoutSecondaryAttachment2"]);
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
			if(!scripts\common\utility::func_2286(var_05,var_0B))
			{
				var_0C = -1;
				if(var_07.size)
				{
					var_0C = var_07[0];
					var_07 = scripts\common\utility::func_22A9(var_07,var_0C);
				}
				else if(var_06.size)
				{
					var_0C = scripts\common\utility::random(var_06);
					var_06 = scripts\common\utility::func_22A9(var_06,var_0C);
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