/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\agents\elvira\elvira_agent.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 16
 * Decompile Time: 854 ms
 * Timestamp: 10/27/2023 12:11:15 AM
*******************************************************************/

//Function Number: 1
registerscriptedagent()
{
	lib_0A02::init();
	behaviortree\elvira::func_DEE8();
	scripts\asm\elvira\mp\states::func_2371();
	scripts\mp\agents\elvira\elvira_tunedata::setuptunedata();
	thread func_FAB0();
}

//Function Number: 2
func_FAB0()
{
	level endon("game_ended");
	if(!isdefined(level.agent_definition))
	{
		level waittill("scripted_agents_initialized");
	}

	if(!isdefined(level.var_10970))
	{
		level.var_10970 = [];
	}

	level.var_10970["elvira"] = [];
	level.agent_definition["elvira"]["setup_func"] = ::setupagent;
	level.agent_definition["elvira"]["setup_model_func"] = ::func_FACE;
}

//Function Number: 3
func_FACE(param_00)
{
	self setmodel("fullbody_zmb_hero_elvira");
}

//Function Number: 4
setupagent()
{
	self.accuracy = 0.8;
	self.noattackeraccuracymod = 0;
	self.sharpturnnotifydist = 48;
	self.last_enemy_sight_time = 0;
	self.maxsightdistsqrd = 67108864;
	self.meleerangesq = 9216;
	self.meleechargedist = 45;
	self.meleechargedistvsplayer = 45;
	self.meleechargedistreloadmultiplier = 1.2;
	self.maxzdiff = 50;
	self.meleeactorboundsradius = 32;
	self.meleemindamage = 300;
	self.meleemaxdamage = 450;
	self.footstepdetectdist = 1000;
	self.footstepdetectdistwalk = 1000;
	self.footstepdetectdistsprint = 1000;
	self.var_1A44 = 50;
	self.var_B62D = 70;
	self.var_B62E = 70;
	self.var_B631 = 80;
	self.var_B62F = squared(self.var_B62E);
	self.var_B607 = 0.5;
	self.var_B601 = 9999;
	self.var_129AF = 55;
	self.var_257 = 15;
	self.height = 65;
	self.allowpain = 0;
	func_FAFE();
	thread func_899D();
	level.the_hoff_revive = 1;
	thread elviracleanup();
}

//Function Number: 5
elviracleanup()
{
	self waittill("death");
	level.the_hoff_revive = undefined;
}

//Function Number: 6
func_FAFE()
{
	self.targetcrawlerfunction = ::func_11562;
	self.targetingfunctions = [::func_11562,::func_11559,::func_1156F,::func_1157B,::func_11570];
	self.targetingfunctionchances = [0,47,21,21,11];
}

//Function Number: 7
func_899D()
{
	self endon("death");
	for(;;)
	{
		self waittill("enemy");
		for(;;)
		{
			if(isdefined(self.var_10C))
			{
				self.var_6571 = gettime() + 1000;
			}
			else if(isdefined(self.var_6571))
			{
				if(gettime() > self.var_6571)
				{
					self.var_6571 = undefined;
					break;
				}
			}

			wait(0.25);
		}
	}
}

//Function Number: 8
func_11570()
{
	var_00 = 70;
	var_01 = 15;
	if(isdefined(self.var_10C.var_18F4))
	{
		var_00 = self.var_10C.var_18F4;
		var_01 = self.var_10C.var_18F9;
	}

	var_02 = var_00 * randomfloatrange(0.25,0.35);
	var_03 = var_01 * 0.5;
	var_04 = var_03 * -1;
	var_05 = randomfloatrange(var_04,var_03);
	var_06 = anglestoright(self.angles);
	var_07 = (var_06[0] * var_05,var_06[1] * var_05,var_02);
	var_08 = self.var_10C.origin + var_07;
	return var_08;
}

//Function Number: 9
func_1157B()
{
	var_00 = 70;
	var_01 = 15;
	if(isdefined(self.var_10C.var_18F4))
	{
		var_00 = self.var_10C.var_18F4;
		var_01 = self.var_10C.var_18F9;
	}

	var_02 = var_00 * randomfloatrange(0.65,0.75);
	var_03 = var_01 * 0.75;
	var_04 = anglestoright(self.angles);
	var_05 = (var_04[0] * var_03,var_04[1] * var_03,var_02);
	var_06 = self.var_10C.origin + var_05;
	return var_06;
}

//Function Number: 10
func_1156F()
{
	var_00 = 70;
	var_01 = 15;
	if(isdefined(self.var_10C.var_18F4))
	{
		var_00 = self.var_10C.var_18F4;
		var_01 = self.var_10C.var_18F9;
	}

	var_02 = var_00 * randomfloatrange(0.65,0.75);
	var_03 = var_01 * -0.75;
	var_04 = anglestoright(self.angles);
	var_05 = (var_04[0] * var_03,var_04[1] * var_03,var_02);
	var_06 = self.var_10C.origin + var_05;
	return var_06;
}

//Function Number: 11
func_11559()
{
	var_00 = 70;
	var_01 = 15;
	if(isdefined(self.var_10C.var_18F4))
	{
		var_00 = self.var_10C.var_18F4;
		var_01 = self.var_10C.var_18F9;
	}

	var_02 = var_00 * randomfloatrange(0.65,0.75);
	var_03 = var_01 * 0.5;
	var_04 = var_03 * -1;
	var_05 = randomfloatrange(var_04,var_03);
	var_06 = anglestoright(self.angles);
	var_07 = (var_06[0] * var_05,var_06[1] * var_05,var_02);
	var_08 = self.var_10C.origin + var_07;
	return var_08;
}

//Function Number: 12
func_11562()
{
	var_00 = self.var_10C gettagorigin("j_head");
	return var_00;
}

//Function Number: 13
func_CB30()
{
	if(isdefined(self.var_10C) && isdefined(self.var_10C.var_565C) && self.var_10C.var_565C)
	{
		if(isdefined(self.targetcrawlerfunction))
		{
			return self.targetcrawlerfunction;
		}
	}

	var_00 = 0;
	var_01 = randomint(100);
	for(var_02 = 0;var_02 < self.targetingfunctionchances.size;var_02++)
	{
		var_03 = self.targetingfunctionchances[var_02];
		if(var_01 < var_03 + var_00)
		{
			return self.targetingfunctions[var_02];
		}

		var_00 = var_00 + var_03;
	}

	return undefined;
}

//Function Number: 14
func_7E8E()
{
	var_00 = self.var_10C gettagorigin("j_head");
	return var_00;
}

//Function Number: 15
func_7E66()
{
	if(scripts\common\utility::istrue(self.var_565C))
	{
		return func_7E8E();
	}

	var_00 = 70;
	var_01 = 15;
	if(isdefined(self.var_10C.var_18F4))
	{
		var_00 = self.var_10C.var_18F4;
		var_01 = self.var_10C.var_18F9;
	}

	var_02 = var_00 * 0.75;
	var_03 = (0,0,var_02);
	var_04 = self.var_10C.origin + var_03;
	return var_04;
}

//Function Number: 16
getenemy()
{
	return self.var_10C;
}