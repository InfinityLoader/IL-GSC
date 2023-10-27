/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\killstreaks\_portableaoegenerator.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 18
 * Decompile Time: 305 ms
 * Timestamp: 10/27/2023 1:21:26 AM
*******************************************************************/

//Function Number: 1
func_44DF()
{
	if(!isdefined(level.portableaoegeneratorsettings))
	{
		level.portableaoegeneratorsettings = [];
		level.generators = [];
	}
}

//Function Number: 2
func_7215(param_00)
{
	var_01 = level.portableaoegeneratorsettings[param_00];
	self setoffhandsecondaryclass("flash");
	maps\mp\_utility::_giveweapon(var_01.weaponname,0);
	self givestartammo(var_01.weaponname);
	if(!isdefined(self.deployedgenerators))
	{
		self.deployedgenerators = [];
	}

	thread func_5391(param_00);
}

//Function Number: 3
func_864C(param_00)
{
	self notify("end_monitorUse_" + param_00);
}

//Function Number: 4
func_258A(param_00,param_01)
{
	if(!isdefined(param_00))
	{
	}

	foreach(var_03 in level.players)
	{
		if(isdefined(var_03) && isdefined(var_03.ingeneratoraoe))
		{
			var_03.ingeneratoraoe[param_01] = undefined;
		}
	}

	func_6469(param_00,param_01,undefined);
	param_00 notify("death");
	param_00 delete();
}

//Function Number: 5
func_6469(param_00,param_01,param_02)
{
	if(isdefined(param_02) && param_02)
	{
		self.deployedgenerators[param_01] = param_00;
	}
	else
	{
		self.deployedgenerators[param_01] = undefined;
		param_02 = undefined;
	}

	var_03 = level.generators[param_01];
	if(!isdefined(var_03))
	{
		level.generators[param_01] = [];
		var_03 = level.generators[param_01];
	}

	var_04 = func_3AD1(param_00);
	var_03[var_04] = param_02;
}

//Function Number: 6
func_5391(param_00)
{
	self notify("end_monitorUse_" + param_00);
	self endon("end_monitorUse_" + param_00);
	self endon("disconnect");
	level endon("game_ended");
	var_01 = level.portableaoegeneratorsettings[param_00];
	for(;;)
	{
		self waittill("grenade_fire",var_02,var_03);
		if(var_03 == var_01.weaponname || var_03 == param_00)
		{
			if(!isalive(self))
			{
				var_02 delete();
			}

			if(checkgeneratorplacement(var_02,var_01.placementztolerance))
			{
				var_04 = self.deployedgenerators[param_00];
				if(isdefined(var_04))
				{
					func_258A(var_04,param_00);
				}

				var_05 = func_78B1(param_00,var_02.origin);
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

			self setweaponammostock(var_01.weaponname,self getweaponammostock("trophy_mp") + 1);
		}
	}
}

//Function Number: 7
checkgeneratorplacement(param_00,param_01)
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
func_78B1(param_00,param_01)
{
	var_02 = level.portableaoegeneratorsettings[param_00];
	var_03 = spawn("script_model",param_01);
	var_03.health = var_02.health;
	var_03.team = self.team;
	var_03.owner = self;
	var_03 setcandamage(1);
	var_03 setmodel(var_02.placedmodel);
	if(level.teambased)
	{
		var_03 maps\mp\_entityheadicons::func_70E0(self.team,(0,0,var_02.headiconheight));
	}
	else
	{
		var_03 maps\mp\_entityheadicons::func_7099(self,(0,0,var_02.headiconheight));
	}

	var_03 thread func_8D08(self,param_00);
	var_03 thread func_8CD5(self,param_00);
	var_03 thread func_8D2F(self,param_00);
	var_03 thread maps\mp\_utility::func_573A(self);
	if(isdefined(var_02.ondeploycallback))
	{
		var_03 [[ var_02.ondeploycallback ]](self,param_00);
	}

	var_03 thread maps\mp\gametypes\_weapons::createbombsquadmodel(var_02.bombsquadmodel,"tag_origin",self);
	func_6469(var_03,param_00,1);
	self.changingweapon = undefined;
	wait(0.05);
	if(isdefined(var_03) && var_03 maps\mp\_utility::func_818D())
	{
		var_03 notify("death");
	}

	return var_03;
}

//Function Number: 9
func_8D08(param_00,param_01)
{
	self endon("death");
	level endon("game_ended");
	if(maps\mp\_utility::bot_is_fireteam_mode())
	{
		param_00 waittill("killstreak_disowned");
	}
	else
	{
		param_00 common_scripts\utility::func_8B4F("killstreak_disowned","death");
	}

	param_00 thread func_258A(self,param_01);
}

//Function Number: 10
func_8CD5(param_00,param_01)
{
	self.generatortype = param_01;
	var_02 = level.portableaoegeneratorsettings[param_01];
	maps\mp\gametypes\_damage::func_537B(var_02.health,var_02.damagefeedback,::handledeathdamage,::modifydamage,0);
}

//Function Number: 11
modifydamage(param_00,param_01,param_02,param_03)
{
	var_04 = param_03;
	var_04 = maps\mp\gametypes\_damage::handlemeleedamage(param_01,param_02,var_04);
	var_04 = maps\mp\gametypes\_damage::handleempdamage(param_01,param_02,var_04);
	var_04 = maps\mp\gametypes\_damage::func_3F8A(param_01,param_02,var_04);
	var_04 = maps\mp\gametypes\_damage::handlegrenadedamage(param_01,param_02,var_04);
	var_04 = maps\mp\gametypes\_damage::handleapdamage(param_01,param_02,var_04,param_00);
	return var_04;
}

//Function Number: 12
handledeathdamage(param_00,param_01,param_02)
{
	var_03 = self.owner;
	var_04 = level.portableaoegeneratorsettings[self.generatortype];
	if(isdefined(var_03) && param_00 != var_03)
	{
		param_00 notify("destroyed_equipment");
	}

	if(isdefined(var_04.ondestroycallback))
	{
		var_03 [[ var_04.ondestroycallback ]](self,self.generatortype);
	}

	var_03 thread func_258A(self,self.generatortype);
}

//Function Number: 13
func_8D2F(param_00,param_01)
{
	self endon("death");
	level endon("game_ended");
	param_00 endon("disconnect");
	var_02 = level.portableaoegeneratorsettings[param_01];
	self setcursorhint("HINT_NOICON");
	self sethintstring(var_02.usehintstring);
	maps\mp\_utility::func_70BF(param_00);
	for(;;)
	{
		self waittill("trigger",var_03);
		var_03 playlocalsound(var_02.usesound);
		if(var_03 getammocount(var_02.weaponname) == 0 && !var_03 maps\mp\_utility::isjuggernaut())
		{
			var_03 func_7215(param_01);
		}

		var_03 thread func_258A(self,param_01);
	}
}

//Function Number: 14
func_3782()
{
	self endon("death");
	self endon("disconnect");
	self endon("faux_spawn");
	level endon("game_ended");
	var_00 = randomfloat(0.5);
	wait(var_00);
	self.ingeneratoraoe = [];
	for(;;)
	{
		wait(0.05);
		if(level.generators.size > 0 || self.ingeneratoraoe.size > 0)
		{
			foreach(var_02 in level.portableaoegeneratorsettings)
			{
				checkallgeneratorsofthistype(var_02.generatortype);
			}
		}
	}
}

//Function Number: 15
checkallgeneratorsofthistype(param_00)
{
	var_01 = level.generators[param_00];
	if(isdefined(var_01))
	{
		var_02 = level.portableaoegeneratorsettings[param_00];
		var_03 = var_02.aoeradius * var_02.aoeradius;
		var_04 = undefined;
		foreach(var_06 in var_01)
		{
			if(isdefined(var_06) && maps\mp\_utility::func_4945(var_06))
			{
				if((level.teambased && matchestargetteam(var_06.team,self.team,var_02.targettype)) || !level.teambased && func_50BA(var_06.owner,self,var_02.targettype))
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
		var_0A = isdefined(self.ingeneratoraoe[param_00]);
		if(var_09 && !var_0A)
		{
			self [[ var_02.onentercallback ]]();
		}
		else if(!var_09 && var_0A)
		{
			self [[ var_02.onexitcallback ]]();
		}

		self.ingeneratoraoe[param_00] = var_04;
	}
}

//Function Number: 16
matchestargetteam(param_00,param_01,param_02)
{
	return param_02 == "all" || param_02 == "friendly" && param_00 == param_01 || param_02 == "enemy" && param_00 != param_01;
}

//Function Number: 17
func_50BA(param_00,param_01,param_02)
{
	return param_02 == "all" || param_02 == "friendly" && param_00 == param_01 || param_02 == "enemy" && param_00 != param_01;
}

//Function Number: 18
func_3AD1(param_00)
{
	return param_00.owner.guid + param_00.birthtime;
}