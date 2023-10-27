/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\killstreaks\_portableaoegenerator.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 18
 * Decompile Time: 973 ms
 * Timestamp: 10/27/2023 12:29:20 AM
*******************************************************************/

//Function Number: 1
init()
{
	if(!isdefined(level.var_D671))
	{
		level.var_D671 = [];
		level.var_773B = [];
	}
}

//Function Number: 2
func_FB16(param_00)
{
	var_01 = level.var_D671[param_00];
	self method_831D("flash");
	scripts\mp\_utility::func_12C6(var_01.var_39C,0);
	self method_817C(var_01.var_39C);
	if(!isdefined(self.var_522E))
	{
		self.var_522E = [];
	}

	thread func_B9DE(param_00);
}

//Function Number: 3
func_12D67(param_00)
{
	self notify("end_monitorUse_" + param_00);
}

//Function Number: 4
func_51B7(param_00,param_01)
{
	if(!isdefined(param_00))
	{
		return;
	}

	foreach(var_03 in level.players)
	{
		if(isdefined(var_03) && isdefined(var_03.var_94C7))
		{
			var_03.var_94C7[param_01] = undefined;
		}
	}

	func_DEF2(param_00,param_01,undefined);
	param_00 notify("death");
	param_00 delete();
}

//Function Number: 5
func_DEF2(param_00,param_01,param_02)
{
	if(isdefined(param_02) && param_02)
	{
		self.var_522E[param_01] = param_00;
	}
	else
	{
		self.var_522E[param_01] = undefined;
		param_02 = undefined;
	}

	var_03 = level.var_773B[param_01];
	if(!isdefined(var_03))
	{
		level.var_773B[param_01] = [];
		var_03 = level.var_773B[param_01];
	}

	var_04 = func_7F0C(param_00);
	var_03[var_04] = param_02;
}

//Function Number: 6
func_B9DE(param_00)
{
	self notify("end_monitorUse_" + param_00);
	self endon("end_monitorUse_" + param_00);
	self endon("disconnect");
	level endon("game_ended");
	var_01 = level.var_D671[param_00];
	for(;;)
	{
		self waittill("grenade_fire",var_02,var_03);
		if(var_03 == var_01.var_39C || var_03 == param_00)
		{
			if(!isalive(self))
			{
				var_02 delete();
				return;
			}

			if(func_3E1B(var_02,var_01.var_CC26))
			{
				var_04 = self.var_522E[param_00];
				if(isdefined(var_04))
				{
					func_51B7(var_04,param_00);
				}

				var_05 = func_108EA(param_00,var_02.origin);
				var_06 = var_02 getlinkedparent();
				if(isdefined(var_06))
				{
					var_05 linkto(var_06);
				}

				if(isdefined(var_02))
				{
					var_02 delete();
				}

				continue;
			}

			self setweaponammostock(var_01.var_39C,self getweaponammostock("trophy_mp") + 1);
		}
	}
}

//Function Number: 7
func_3E1B(param_00,param_01)
{
	param_00 hide();
	param_00 waittill("missile_stuck",var_02);
	if(param_01 * param_01 < distancesquared(param_00.origin,self.origin))
	{
		var_03 = bullettrace(self.origin,self.origin - (0,0,param_01),0,self);
		if(var_03["fraction"] == 1)
		{
			param_00 delete();
			return 0;
		}

		param_00.origin = var_03["position"];
	}

	param_00 show();
	return 1;
}

//Function Number: 8
func_108EA(param_00,param_01)
{
	var_02 = level.var_D671[param_00];
	var_03 = spawn("script_model",param_01);
	var_03.health = var_02.health;
	var_03.team = self.team;
	var_03.var_222 = self;
	var_03 setcandamage(1);
	var_03 setmodel(var_02.var_CC12);
	if(level.teambased)
	{
		var_03 scripts\mp\_entityheadicons::func_F877(self.team,(0,0,var_02.var_8C79));
	}
	else
	{
		var_03 scripts\mp\_entityheadicons::func_F7F2(self,(0,0,var_02.var_8C79));
	}

	var_03 thread func_13AE2(self,param_00);
	var_03 thread func_139E5(self,param_00);
	var_03 thread func_13B9C(self,param_00);
	var_03 thread scripts\mp\_utility::notusableforjoiningplayers(self);
	if(isdefined(var_02.var_C4F0))
	{
		var_03 [[ var_02.var_C4F0 ]](self,param_00);
	}

	var_03 thread scripts\mp\_weapons::func_4988(var_02.var_2C68,"tag_origin",self);
	func_DEF2(var_03,param_00,1);
	wait(0.05);
	if(isdefined(var_03) && var_03 scripts\mp\_utility::touchingbadtrigger())
	{
		var_03 notify("death");
	}

	return var_03;
}

//Function Number: 9
func_13AE2(param_00,param_01)
{
	self endon("death");
	level endon("game_ended");
	if(scripts\mp\_utility::func_2DD9())
	{
		param_00 waittill("killstreak_disowned");
	}
	else
	{
		param_00 scripts\common\utility::waittill_either("killstreak_disowned","death");
	}

	param_00 thread func_51B7(self,param_01);
}

//Function Number: 10
func_139E5(param_00,param_01)
{
	self.var_773C = param_01;
	var_02 = level.var_D671[param_01];
	scripts\mp\_damage::func_B9C6(var_02.health,var_02.var_4D4A,::func_898F,::func_B938,0);
}

//Function Number: 11
func_B938(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = param_03;
	var_05 = scripts\mp\_damage::func_89C3(param_01,param_02,var_05);
	var_05 = scripts\mp\_damage::func_8999(param_01,param_02,var_05);
	var_05 = scripts\mp\_damage::func_89C6(param_01,param_02,var_05);
	var_05 = scripts\mp\_damage::func_89AC(param_01,param_02,var_05);
	var_05 = scripts\mp\_damage::func_8975(param_01,param_02,var_05);
	return var_05;
}

//Function Number: 12
func_898F(param_00,param_01,param_02)
{
	var_03 = self.var_222;
	var_04 = level.var_D671[self.var_773C];
	if(isdefined(var_03) && param_00 != var_03)
	{
		param_00 notify("destroyed_equipment");
	}

	if(isdefined(var_04.var_C4F1))
	{
		var_03 [[ var_04.var_C4F1 ]](self,self.var_773C);
	}

	var_03 thread func_51B7(self,self.var_773C);
}

//Function Number: 13
func_13B9C(param_00,param_01)
{
	self endon("death");
	level endon("game_ended");
	param_00 endon("disconnect");
	var_02 = level.var_D671[param_01];
	self setcursorhint("HINT_NOICON");
	self sethintstring(var_02.var_13092);
	scripts\mp\_utility::func_F838(param_00);
	for(;;)
	{
		self waittill("trigger",var_03);
		var_03 playlocalsound(var_02.var_130D9);
		if(var_03 method_80FB(var_02.var_39C) == 0 && !var_03 scripts\mp\_utility::func_9E59())
		{
			var_03 func_FB16(param_01);
		}

		var_03 thread func_51B7(self,param_01);
	}
}

//Function Number: 14
func_7737()
{
	self endon("death");
	self endon("disconnect");
	self endon("faux_spawn");
	level endon("game_ended");
	var_00 = randomfloat(0.5);
	wait(var_00);
	self.var_94C7 = [];
	for(;;)
	{
		wait(0.05);
		if(level.var_773B.size > 0 || self.var_94C7.size > 0)
		{
			foreach(var_02 in level.var_D671)
			{
				func_3DE7(var_02.var_773C);
			}
		}
	}
}

//Function Number: 15
func_3DE7(param_00)
{
	var_01 = level.var_773B[param_00];
	if(isdefined(var_01))
	{
		var_02 = level.var_D671[param_00];
		var_03 = var_02.var_2044 * var_02.var_2044;
		var_04 = undefined;
		foreach(var_06 in var_01)
		{
			if(isdefined(var_06) && scripts\mp\_utility::func_9F19(var_06))
			{
				if((level.teambased && func_B3E5(var_06.team,self.team,var_02.var_11589)) || !level.teambased && func_B3E4(var_06.var_222,self,var_02.var_11589))
				{
					var_07 = distancesquared(var_06.origin,self.origin);
					if(var_07 < var_03)
					{
						var_04 = var_06;
						break;
					}
				}
			}
		}

		var_09 = isdefined(var_04);
		var_0A = isdefined(self.var_94C7[param_00]);
		if(var_09 && !var_0A)
		{
			self [[ var_02.var_C510 ]]();
		}
		else if(!var_09 && var_0A)
		{
			self [[ var_02.var_C51E ]]();
		}

		self.var_94C7[param_00] = var_04;
	}
}

//Function Number: 16
func_B3E5(param_00,param_01,param_02)
{
	return param_02 == "all" || param_02 == "friendly" && param_00 == param_01 || param_02 == "enemy" && param_00 != param_01;
}

//Function Number: 17
func_B3E4(param_00,param_01,param_02)
{
	return param_02 == "all" || param_02 == "friendly" && param_00 == param_01 || param_02 == "enemy" && param_00 != param_01;
}

//Function Number: 18
func_7F0C(param_00)
{
	return param_00.var_222.var_86BD + param_00.var_64;
}