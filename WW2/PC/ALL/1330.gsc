/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 1330.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 11
 * Decompile Time: 1 ms
 * Timestamp: 10/27/2023 3:25:23 AM
*******************************************************************/

//Function Number: 1
func_00D5()
{
	level.var_6232 = 6;
	level.var_622E = 675;
	level.var_622F = 185;
	level.var_6230 = 0.95;
	level.var_6231 = 2;
	level.var_6233 = 0.42;
	level.var_6234 = 1.65;
	level.var_622C = 2.1;
	level.var_6225 = 4.3;
	level.var_6226 = 1;
	level.var_6227 = 0.85;
	level.var_6228 = 0.25;
	self.var_622D = [];
	self.var_4B78 = 0;
}

//Function Number: 2
func_3662()
{
	self.var_4B78 = 1;
	thread func_5FC7();
	thread func_5FC9();
}

//Function Number: 3
func_622A(param_00,param_01)
{
	var_02 = "airstrike_missile_mp";
	var_03 = "scorestreak_minimap_mortar_strike_damage";
	var_04 = "scorestreak_minimap_mortar_strike_kill";
	var_05 = 1;
	var_06 = 100;
	var_07 = 0;
	var_08 = 1;
	var_09 = getweaponexplosionradius(var_02);
	var_0A = var_09 * 2;
	self.var_29E1 = spawnplane("script_model",param_01);
	self.var_29E1 method_8351(param_00,var_03,var_0A,var_0A,var_08,var_07);
	self.var_29E1 method_8352(var_06,var_05);
	var_0B = 100;
	var_0C = 0;
	var_0D = getweaponexplosiondistancefordamage(var_02,var_0C,var_0B);
	var_0E = var_0D * 2;
	self.var_5A88 = spawnplane("script_model",param_01);
	self.var_5A88 method_8351(param_00,var_04,var_0E,var_0E,var_08,var_07);
	self.var_5A88 method_8352(var_06,var_05);
}

//Function Number: 4
func_6229()
{
	self waittill("death");
	var_00 = 80;
	var_01 = 0;
	self.var_29E1 method_8352(var_00,var_01);
	self.var_5A88 method_8352(var_00,var_01);
	wait(var_00 / 1000);
	self.var_29E1 delete();
	self.var_5A88 delete();
}

//Function Number: 5
func_5FC7()
{
	self endon("MisinformationDisabled");
	for(;;)
	{
		var_00 = func_464F();
		if(getpathdist(self.var_116,var_00) > 0)
		{
			var_00 = var_00 - (0,0,500);
			func_622A(self,var_00);
			wait(randomfloat(level.var_6226) + level.var_6225);
			func_6229();
			wait(randomfloat(level.var_6228) + level.var_6227);
			continue;
		}

		wait 0.05;
	}
}

//Function Number: 6
func_5FC8()
{
	self endon("MisinformationDisabled");
	for(;;)
	{
		var_00 = func_464F();
		if(getpathdist(self.var_116,var_00) > 0)
		{
			var_01 = randomint(10);
			if(var_01 >= 0 & var_01 < 6)
			{
				var_02 = "tabun_grenade_mp";
			}
			else if(var_02 >= 6 & var_02 < 9)
			{
				var_02 = "smoke_grenade_mp";
				if(isdefined(self.var_1A7) && self.var_1A7 == "axis")
				{
					var_02 = "smoke_grenade_axis_mp";
				}
			}
			else
			{
				var_02 = "killstreak_carepackage_grenade_mp";
			}

			magicgrenademanual(var_02,var_00,(0,0,0),0.05,self);
			wait(level.var_622C);
			continue;
		}

		wait 0.05;
	}
}

//Function Number: 7
func_5FC9()
{
	self endon("MisinformationDisabled");
	for(;;)
	{
		var_00 = func_464F();
		if(getpathdist(self.var_116,var_00) > 0)
		{
			thread func_2817(var_00);
			wait(level.var_6233 + randomfloat(level.var_6234));
			continue;
		}

		wait 0.05;
	}
}

//Function Number: 8
func_2817(param_00)
{
	self endon("MisinformationDisabled");
	var_01 = spawnstruct();
	if(isdefined(self.var_622D))
	{
		self.var_622D = common_scripts\utility::func_FA0(self.var_622D);
		if(self.var_622D.size >= level.var_6232)
		{
			maps\mp\_utility::func_68B(self.var_622D[0].var_3770);
			maps\mp\_utility::func_68B(self.var_622D[0].var_3EE2);
			self.var_622D[0] = undefined;
		}

		self.var_622D = common_scripts\utility::func_FA0(self.var_622D);
	}
	else
	{
		self.var_622D = [];
	}

	self.var_622D[self.var_622D.size] = var_01;
	var_01.var_3EE2 = maps\mp\gametypes\_gameobjects::func_45A9();
	objective_add(var_01.var_3EE2,"invisible",(0,0,0));
	objective_position(var_01.var_3EE2,param_00);
	function_01D1(var_01.var_3EE2,"cb_compassping_minion_friend_mp");
	if(!level.var_984D)
	{
		objective_playerteam(var_01.var_3EE2,self getentitynumber());
	}
	else
	{
		objective_team(var_01.var_3EE2,self.var_1A7);
	}

	var_01.var_3770 = maps\mp\gametypes\_gameobjects::func_45A9();
	objective_add(var_01.var_3770,"invisible",(0,0,0));
	objective_position(var_01.var_3770,param_00);
	function_01D1(var_01.var_3770,"cb_compassping_enemy_objective");
	if(!level.var_984D)
	{
		objective_playerenemyteam(var_01.var_3770,self getentitynumber());
	}
	else
	{
		objective_team(var_01.var_3770,level.var_6C63[self.var_1A7]);
	}

	if(self.var_4B78)
	{
		thread func_63CF(var_01);
		return;
	}

	self.var_622D = common_scripts\utility::func_F98(var_01,self.var_622D);
	maps\mp\_utility::func_68B(var_01.var_3770);
	maps\mp\_utility::func_68B(var_01.var_3EE2);
	var_01 = undefined;
}

//Function Number: 9
func_63CF(param_00)
{
	self endon("MisinformationDisabled");
	if(!isdefined(param_00) || !isdefined(param_00.var_3770) || !isdefined(param_00.var_3EE2))
	{
		return;
	}

	objective_state(param_00.var_3770,"active");
	objective_state(param_00.var_3EE2,"active");
	wait(level.var_6230 + randomfloat(level.var_6231));
	if(!isdefined(param_00) || !isdefined(param_00.var_3770) || !isdefined(param_00.var_3EE2))
	{
		return;
	}

	self.var_622D = common_scripts\utility::func_F98(param_00,self.var_622D);
	maps\mp\_utility::func_68B(param_00.var_3770);
	maps\mp\_utility::func_68B(param_00.var_3EE2);
	param_00 = undefined;
}

//Function Number: 10
func_2F9E()
{
	self notify("MisinformationDisabled");
	if(isdefined(self.var_622B))
	{
		self.var_622B delete();
	}

	if(isdefined(self.var_622D))
	{
		self.var_622D = common_scripts\utility::func_FA0(self.var_622D);
		for(var_00 = self.var_622D.size - 1;var_00 >= 0;var_00--)
		{
			maps\mp\_utility::func_68B(self.var_622D[var_00].var_3770);
			maps\mp\_utility::func_68B(self.var_622D[var_00].var_3EE2);
			self.var_622D[var_00] = undefined;
		}

		self.var_622D = [];
	}

	self.var_4B78 = 0;
}

//Function Number: 11
func_464F()
{
	var_00 = randomint(2) * 2 - 1;
	var_01 = randomint(2) * 2 - 1;
	var_02 = (var_00 * randomfloatrange(level.var_622F,level.var_622E),var_01 * randomfloatrange(level.var_622F,level.var_622E),0);
	var_02 = self.var_116 + var_02;
	var_02 = getgroundposition(var_02,3);
	return var_02;
}