/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\common\pipes.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 13
 * Decompile Time: 498 ms
 * Timestamp: 10/27/2023 12:23:27 AM
*******************************************************************/

//Function Number: 1
main()
{
	if(isdefined(level.var_CBD2))
	{
		return;
	}

	level.var_CBD2 = 1;
	var_00 = getentarray("pipe_shootable","targetname");
	if(!var_00.size)
	{
		return;
	}

	level.var_1367 = spawnstruct();
	level.var_1367.var_C1FD = 0;
	var_00 thread func_D80E();
	var_00 thread func_B6A0();
	thread func_D6D7(var_00);
}

//Function Number: 2
func_D6D7(param_00)
{
	waittillframeend;
	if(level.createfx_enabled)
	{
		return;
	}

	scripts\common\utility::array_thread(param_00,::func_CBD4);
}

//Function Number: 3
func_CBD4()
{
	self setcandamage(1);
	self setcanradiusdamage(0);
	self.var_CBCD = [];
	var_00 = undefined;
	if(isdefined(self.target))
	{
		var_00 = scripts\common\utility::getstruct(self.target,"targetname");
		self.var_1491 = var_00.origin;
		var_01 = anglestoforward(var_00.angles);
		var_01 = var_01 * 128;
		self.var_26FF = self.var_1491 + var_01;
	}
	else
	{
		var_01 = anglestoforward(self.angles);
		var_02 = var_01 * 64;
		self.var_1491 = self.origin + var_02;
		var_02 = var_01 * -64;
		self.var_26FF = self.origin + var_02;
	}

	thread func_CBCF();
}

//Function Number: 4
func_CBCF()
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
		var_07 = func_CBCE(var_05,var_00,var_06,var_04);
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

//Function Number: 5
func_CBCE(param_00,param_01,param_02,param_03)
{
	if(level.var_1367.var_C1FD > 12)
	{
		return 0;
	}

	if(!isdefined(level.var_1367.var_1366[param_02]))
	{
		param_01 = func_CBCA(param_01,param_02);
	}
	else
	{
		param_01 = self [[ level.var_1367.var_1366[param_02] ]](param_01,param_02);
	}

	if(!isdefined(param_01))
	{
		return 0;
	}

	if(isdefined(param_03.classname) && param_03.classname == "worldspawn")
	{
		return 0;
	}

	foreach(var_05 in self.var_CBCD)
	{
		if(distancesquared(param_01,var_05.origin) < 25)
		{
			return 0;
		}
	}

	var_07 = undefined;
	if(isai(param_03))
	{
		var_07 = param_03 geteye();
	}
	else
	{
		var_07 = param_03.origin;
	}

	var_08 = param_01 - var_07;
	var_09 = bullettrace(var_07,var_07 + 1.5 * var_08,0,param_03,0);
	if(isdefined(var_09["normal"]) && isdefined(var_09["entity"]) && var_09["entity"] == self)
	{
		var_0A = var_09["normal"];
		thread func_CBD0(param_01,var_0A,param_03);
		return 1;
	}

	return 0;
}

//Function Number: 6
func_CBD0(param_00,param_01,param_02)
{
	var_03 = level.var_1367.var_760B[self.script_noteworthy];
	var_04 = level.var_1367.var_1365[self.script_noteworthy];
	var_05 = int(var_04 / var_03);
	var_06 = 30;
	var_07 = "mtl_steam_pipe_hit";
	var_08 = "mtl_steam_pipe_hiss_loop";
	var_09 = "mtl_steam_pipe_hiss_loop_end";
	var_0A = spawn("script_origin",param_00);
	var_0A hide();
	var_0A playsound(var_07);
	var_0A playloopsound(var_08);
	self.var_CBCD[self.var_CBCD.size] = var_0A;
	if(scripts\common\utility::issp() || self.script_noteworthy != "steam")
	{
		thread func_CBCC(param_00,param_01,param_02,var_0A);
	}

	if(self.script_noteworthy == "oil_leak")
	{
		var_0B = spawn("script_model",param_00);
		var_0B setmodel("tag_origin");
		var_0B.angles = vectortoangles(param_01);
		playfxontag(level.var_1367._effect[self.script_noteworthy],var_0B,"tag_origin");
		level.var_1367.var_C1FD++;
		var_0B rotatepitch(90,var_03,1,1);
		wait(var_03);
		stopfxontag(level.var_1367._effect[self.script_noteworthy],var_0B,"tag_origin");
		var_05--;
	}
	else
	{
		playfx(level.var_1367._effect[self.script_noteworthy],param_00,param_01);
		level.var_1367.var_C1FD++;
		wait(var_03);
		var_05--;
	}

	while(level.var_1367.var_C1FD <= 12 && var_05 > 0)
	{
		if(self.script_noteworthy == "oil_leak")
		{
			var_0B = spawn("script_model",param_00);
			var_0B setmodel("tag_origin");
			var_0B.angles = vectortoangles(param_01);
			playfxontag(level.var_1367._effect[self.script_noteworthy],var_0B,"tag_origin");
			level.var_1367.var_C1FD++;
			var_0B rotatepitch(90,var_03,1,1);
			wait(var_03);
			stopfxontag(level.var_1367._effect[self.script_noteworthy],var_0B,"tag_origin");
			continue;
		}

		playfx(level.var_1367._effect[self.script_noteworthy],param_00,param_01);
		wait(var_03);
		var_05--;
	}

	var_0A playsound(var_09);
	wait(0.5);
	var_0A stoploopsound(var_08);
	var_0A delete();
	self.var_CBCD = scripts\common\utility::func_22BC(self.var_CBCD);
	level.var_1367.var_C1FD--;
}

//Function Number: 7
func_CBCC(param_00,param_01,param_02,param_03)
{
	if(!func_1C5A())
	{
		return;
	}

	param_03 endon("death");
	var_04 = param_03.origin + vectornormalize(param_01) * 40;
	var_05 = level.var_1367.var_11E4[self.script_noteworthy];
	for(;;)
	{
		if(!isdefined(self.var_4D5C))
		{
			self radiusdamage(var_04,36,var_05,var_05 * 0.75,undefined,"MOD_TRIGGER_HURT");
		}
		else
		{
			self radiusdamage(var_04,36,var_05,var_05 * 0.75,param_02,"MOD_TRIGGER_HURT");
		}

		wait(0.4);
	}
}

//Function Number: 8
func_1C5A()
{
	if(!scripts\common\utility::issp())
	{
		return 0;
	}

	if(!isdefined(level.var_CBD3))
	{
		return 1;
	}

	return level.var_CBD3;
}

//Function Number: 9
func_B6A0()
{
	level.var_1367.var_1366 = [];
	level.var_1367.var_1366["MOD_UNKNOWN"] = ::func_CBCB;
	level.var_1367.var_1366["MOD_PISTOL_BULLET"] = ::func_CBC9;
	level.var_1367.var_1366["MOD_RIFLE_BULLET"] = ::func_CBC9;
	level.var_1367.var_1366["MOD_GRENADE"] = ::func_CBCB;
	level.var_1367.var_1366["MOD_GRENADE_SPLASH"] = ::func_CBCB;
	level.var_1367.var_1366["MOD_PROJECTILE"] = ::func_CBCB;
	level.var_1367.var_1366["MOD_PROJECTILE_SPLASH"] = ::func_CBCB;
	level.var_1367.var_1366["MOD_TRIGGER_HURT"] = ::func_CBCB;
	level.var_1367.var_1366["MOD_EXPLOSIVE"] = ::func_CBCB;
	level.var_1367.var_1366["MOD_EXPLOSIVE_BULLET"] = ::func_CBCB;
}

//Function Number: 10
func_CBC9(param_00,param_01)
{
	return param_00;
}

//Function Number: 11
func_CBCB(param_00,param_01)
{
	var_02 = vectornormalize(vectorfromlinetopoint(self.var_1491,self.var_26FF,param_00));
	param_00 = pointonsegmentnearesttopoint(self.var_1491,self.var_26FF,param_00);
	return param_00 + var_02 * 4;
}

//Function Number: 12
func_CBCA(param_00,param_01)
{
	return undefined;
}

//Function Number: 13
func_D80E()
{
	var_00 = 0;
	var_01 = 0;
	var_02 = 0;
	var_03 = 0;
	var_04 = 0;
	foreach(var_06 in self)
	{
		if(var_06.script_noteworthy == "water")
		{
			var_06.script_noteworthy = "steam";
		}

		if(var_06.script_noteworthy == "steam")
		{
			var_06 willneverchange();
			var_00 = 1;
			continue;
		}

		if(var_06.script_noteworthy == "fire")
		{
			var_06 willneverchange();
			var_01 = 1;
			continue;
		}

		if(var_06.script_noteworthy == "steam_small")
		{
			var_06 willneverchange();
			var_02 = 1;
			continue;
		}

		if(var_06.script_noteworthy == "oil_leak")
		{
			var_06 willneverchange();
			var_03 = 1;
			continue;
		}

		if(var_06.script_noteworthy == "oil_cap")
		{
			var_06 willneverchange();
			var_04 = 1;
			continue;
		}
	}

	if(var_00)
	{
		level.var_1367._effect["steam"] = loadfx("vfx/core/impacts/pipe_steam");
		level.var_1367.var_1408["steam_hit"] = "mtl_steam_pipe_hit";
		level.var_1367.var_1408["steam_loop"] = "mtl_steam_pipe_hiss_loop";
		level.var_1367.var_1408["steam_end"] = "mtl_steam_pipe_hiss_loop_end";
		level.var_1367.var_760B["steam"] = 3;
		level.var_1367.var_11E4["steam"] = 5;
		level.var_1367.var_1365["steam"] = 25;
	}

	if(var_02)
	{
		level.var_1367._effect["steam_small"] = loadfx("vfx/core/impacts/pipe_steam_small");
		level.var_1367.var_1408["steam_small_hit"] = "mtl_steam_pipe_hit";
		level.var_1367.var_1408["steam_small_loop"] = "mtl_steam_pipe_hiss_loop";
		level.var_1367.var_1408["steam_small_end"] = "mtl_steam_pipe_hiss_loop_end";
		level.var_1367.var_760B["steam_small"] = 3;
		level.var_1367.var_11E4["steam_small"] = 5;
		level.var_1367.var_1365["steam_small"] = 25;
	}

	if(var_01)
	{
		level.var_1367._effect["fire"] = loadfx("vfx/core/impacts/pipe_fire");
		level.var_1367.var_1408["fire_hit"] = "mtl_gas_pipe_hit";
		level.var_1367.var_1408["fire_loop"] = "mtl_gas_pipe_flame_loop";
		level.var_1367.var_1408["fire_end"] = "mtl_gas_pipe_flame_end";
		level.var_1367.var_760B["fire"] = 3;
		level.var_1367.var_11E4["fire"] = 5;
		level.var_1367.var_1365["fire"] = 25;
	}

	if(var_03)
	{
		level.var_1367._effect["oil_leak"] = loadfx("vfx/core/impacts/pipe_oil_barrel_spill");
		level.var_1367.var_1408["oil_leak_hit"] = "mtl_oil_barrel_hit";
		level.var_1367.var_1408["oil_leak_loop"] = "mtl_oil_barrel_hiss_loop";
		level.var_1367.var_1408["oil_leak_end"] = "mtl_oil_barrel_hiss_loop_end";
		level.var_1367.var_760B["oil_leak"] = 6;
		level.var_1367.var_1365["oil_leak"] = 6;
		level.var_1367.var_11E4["oil_leak"] = 5;
	}

	if(var_04)
	{
		level.var_1367._effect["oil_cap"] = loadfx("vfx/core/impacts/pipe_oil_barrel_squirt");
		level.var_1367.var_1408["oil_cap_hit"] = "mtl_steam_pipe_hit";
		level.var_1367.var_1408["oil_cap_loop"] = "mtl_steam_pipe_hiss_loop";
		level.var_1367.var_1408["oil_cap_end"] = "mtl_steam_pipe_hiss_loop_end";
		level.var_1367.var_760B["oil_cap"] = 3;
		level.var_1367.var_11E4["oil_cap"] = 5;
		level.var_1367.var_1365["oil_cap"] = 5;
	}
}