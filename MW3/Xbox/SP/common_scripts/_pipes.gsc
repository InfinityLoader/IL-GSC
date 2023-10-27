/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: common_scripts\_pipes.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 12
 * Decompile Time: 243 ms
 * Timestamp: 10/27/2023 2:35:17 AM
*******************************************************************/

//Function Number: 1
main()
{
	level.var_18A1 = 25;
	var_00 = getentarray("pipe_shootable","targetname");
	if(!var_00.size)
	{
		return;
	}

	level.var_18A2 = spawnstruct();
	level.var_18A2.num_pipe_fx = 0;
	var_00 thread precachefx();
	var_00 thread methodsinit();
	waittillframeend;
	common_scripts\utility::array_thread(var_00,::pipesetup);
}

//Function Number: 2
pipesetup()
{
	self setcandamage(1);
	self setcanradiusdamage(0);
	self.var_18A5 = [];
	var_00 = undefined;
	if(isdefined(self.target))
	{
		var_00 = common_scripts\utility::getstruct(self.target,"targetname");
		self.a = var_00.origin;
		var_01 = anglestoforward(var_00.angles);
		var_01 = var_01 * 128;
		self.b = self.a + var_01;
	}
	else
	{
		var_01 = anglestoforward(self.angles);
		var_02 = var_01 * 64;
		self.a = self.origin + var_02;
		var_02 = var_01 * -64;
		self.b = self.origin + var_02;
	}

	thread pipe_wait_loop();
}

//Function Number: 3
pipe_wait_loop()
{
	var_00 = (0,0,0);
	var_01 = 0;
	var_02 = 4;
	for(;;)
	{
		self waittill("damage",var_03,var_04,var_05,var_00,var_06);
		if(var_01)
		{
			if(randomint(100) <= 33)
			{
				continue;
			}
		}

		var_01 = 1;
		var_07 = pipe_logic(var_05,var_00,var_06,var_04);
		if(var_07)
		{
			var_02--;
		}

		if(var_02 <= 0)
		{
			break;
		}
	}

	self setcandamage(0);
}

//Function Number: 4
pipe_logic(param_00,param_01,param_02,param_03)
{
	if(level.var_18A2.num_pipe_fx > 8)
	{
		return 0;
	}

	if(!isdefined(level.var_18A2._pipe_methods[param_02]))
	{
		param_01 = pipe_calc_nofx(param_01,param_02);
	}
	else
	{
		param_01 = self [[ level.var_18A2._pipe_methods[param_02] ]](param_01,param_02);
	}

	if(!isdefined(param_01))
	{
		return 0;
	}

	if(isdefined(param_03.classname) && param_03.classname == "worldspawn")
	{
		return 0;
	}

	foreach(var_05 in self.var_18A5)
	{
		if(distancesquared(param_01,var_05.origin) < 25)
		{
			return 0;
		}
	}

	var_07 = vectorfromlinetopoint(self.a,self.b,param_01);
	thread pipefx(param_01,var_07,param_03);
	return 1;
}

//Function Number: 5
pipefx(param_00,param_01,param_02)
{
	var_03 = level.var_18A2.fx_time[self.script_noteworthy];
	var_04 = int(level.var_18A1 / var_03);
	var_05 = level.var_18A2._sound[self.script_noteworthy + "_hit"];
	var_06 = level.var_18A2._sound[self.script_noteworthy + "_loop"];
	var_07 = level.var_18A2._sound[self.script_noteworthy + "_end"];
	var_08 = spawn("script_origin",param_00);
	var_08 hide();
	var_08 playsound(var_05);
	var_08 playloopsound(var_06);
	self.var_18A5[self.var_18A5.size] = var_08;
	level.var_18A2.num_pipe_fx++;
	if(common_scripts\utility::issp() || self.script_noteworthy != "steam")
	{
		thread pipe_damage(param_00,param_01,param_02,var_08);
	}

	playfx(level.var_18A2._effect[self.script_noteworthy],param_00,param_01);
	wait var_03;
	var_04--;
	while(level.var_18A2.num_pipe_fx <= 8 && var_04 > 0)
	{
		playfx(level.var_18A2._effect[self.script_noteworthy],param_00,param_01);
		wait var_03;
		var_04--;
	}

	var_08 playsound(var_07);
	wait 0.5;
	var_08 stoploopsound(var_06);
	var_08 delete();
	self.var_18A5 = common_scripts\utility::array_removeundefined(self.var_18A5);
	level.var_18A2.num_pipe_fx--;
}

//Function Number: 6
pipe_damage(param_00,param_01,param_02,param_03)
{
	if(!func_18AF())
	{
		return;
	}

	param_03 endon("death");
	var_04 = param_03.origin + vectornormalize(param_01) * 40;
	var_05 = level.var_18A2._dmg[self.script_noteworthy];
	for(;;)
	{
		if(!isdefined(self.damageowner))
		{
			self radiusdamage(var_04,36,var_05,var_05 * 0.75,undefined,"MOD_TRIGGER_HURT");
		}
		else
		{
			self radiusdamage(var_04,36,var_05,var_05 * 0.75,param_02,"MOD_TRIGGER_HURT");
		}

		wait 0.4;
	}
}

//Function Number: 7
func_18AF()
{
	if(!common_scripts\utility::issp())
	{
		return 0;
	}

	if(!isdefined(level.var_18B0))
	{
		return 1;
	}

	return level.var_18B0;
}

//Function Number: 8
methodsinit()
{
	level.var_18A2._pipe_methods = [];
	level.var_18A2._pipe_methods["MOD_UNKNOWN"] = ::func_18B3;
	level.var_18A2._pipe_methods["MOD_PISTOL_BULLET"] = ::pipe_calc_ballistic;
	level.var_18A2._pipe_methods["MOD_RIFLE_BULLET"] = ::pipe_calc_ballistic;
	level.var_18A2._pipe_methods["MOD_GRENADE"] = ::func_18B3;
	level.var_18A2._pipe_methods["MOD_GRENADE_SPLASH"] = ::func_18B3;
	level.var_18A2._pipe_methods["MOD_PROJECTILE"] = ::func_18B3;
	level.var_18A2._pipe_methods["MOD_PROJECTILE_SPLASH"] = ::func_18B3;
	level.var_18A2._pipe_methods["MOD_TRIGGER_HURT"] = ::func_18B3;
	level.var_18A2._pipe_methods["MOD_EXPLOSIVE"] = ::func_18B3;
	level.var_18A2._pipe_methods["MOD_EXPLOSIVE_BULLET"] = ::func_18B3;
}

//Function Number: 9
pipe_calc_ballistic(param_00,param_01)
{
	return param_00;
}

//Function Number: 10
func_18B3(param_00,param_01)
{
	var_02 = vectornormalize(vectorfromlinetopoint(self.a,self.b,param_00));
	param_00 = pointonsegmentnearesttopoint(self.a,self.b,param_00);
	return param_00 + var_02 * 4;
}

//Function Number: 11
pipe_calc_nofx(param_00,param_01)
{
	return undefined;
}

//Function Number: 12
precachefx()
{
	var_00 = 0;
	var_01 = 0;
	foreach(var_03 in self)
	{
		if(var_03.script_noteworthy == "water")
		{
			var_03.script_noteworthy = "steam";
		}

		if(var_03.script_noteworthy == "steam")
		{
			var_03 willneverchange();
			var_00 = 1;
			continue;
		}

		if(var_03.script_noteworthy == "fire")
		{
			var_03 willneverchange();
			var_01 = 1;
			continue;
		}
	}

	if(var_00)
	{
		level.var_18A2._effect["steam"] = loadfx("impacts/pipe_steam");
		level.var_18A2._sound["steam_hit"] = "mtl_steam_pipe_hit";
		level.var_18A2._sound["steam_loop"] = "mtl_steam_pipe_hiss_loop";
		level.var_18A2._sound["steam_end"] = "mtl_steam_pipe_hiss_loop_end";
		level.var_18A2.fx_time["steam"] = 3;
		level.var_18A2._dmg["steam"] = 5;
	}

	if(var_01)
	{
		level.var_18A2._effect["fire"] = loadfx("impacts/pipe_fire");
		level.var_18A2._sound["fire_hit"] = "mtl_gas_pipe_hit";
		level.var_18A2._sound["fire_loop"] = "mtl_gas_pipe_flame_loop";
		level.var_18A2._sound["fire_end"] = "mtl_gas_pipe_flame_end";
		level.var_18A2.fx_time["fire"] = 3;
		level.var_18A2._dmg["fire"] = 5;
	}
}