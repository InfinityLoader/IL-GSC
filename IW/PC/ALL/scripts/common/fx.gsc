/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\common\fx.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 29
 * Decompile Time: 1526 ms
 * Timestamp: 10/27/2023 12:03:25 AM
*******************************************************************/

//Function Number: 1
func_980A()
{
	if(!scripts\common\utility::func_16F3("fx",::func_980A))
	{
		return;
	}

	scripts\common\utility::func_16DC("create_triggerfx",::func_496F);
	thread func_95F6();
}

//Function Number: 2
func_95F6()
{
	if(!isdefined(level.var_128D))
	{
		level.var_128D = spawnstruct();
	}

	scripts\common\utility::func_4914("createfx_looper",20);
	level.var_128D.var_6D70 = 1;
	level.var_128D.var_69B4 = ::scripts\common\exploder::func_69A5;
	waittillframeend;
	waittillframeend;
	level.var_128D.var_69B4 = ::scripts\common\exploder::func_69A4;
	level.var_128D.var_F27D = 0;
	if(getdvarint("serverCulledSounds") == 1)
	{
		level.var_128D.var_F27D = 1;
	}

	if(level.createfx_enabled)
	{
		level.var_128D.var_F27D = 0;
	}

	if(level.createfx_enabled)
	{
		level waittill("createfx_common_done");
	}

	for(var_00 = 0;var_00 < level.var_49C9.size;var_00++)
	{
		var_01 = level.var_49C9[var_00];
		var_01 scripts\common\createfx::func_F3BD();
		switch(var_01.var_13125["type"])
		{
			case "loopfx":
				var_01 thread func_B059();
				break;

			case "oneshotfx":
				var_01 thread func_C51A();
				break;

			case "soundfx":
				var_01 thread func_4917();
				break;

			case "soundfx_interval":
				var_01 thread func_4907();
				break;

			case "reactive_fx":
				var_01 func_1734();
				break;
		}
	}

	func_3D65();
}

//Function Number: 3
func_DFFD()
{
}

//Function Number: 4
func_C365()
{
}

//Function Number: 5
func_3D65()
{
}

//Function Number: 6
func_3DB2(param_00,param_01)
{
}

//Function Number: 7
func_D8FD(param_00,param_01,param_02,param_03)
{
	if(getdvar("debug") == "1")
	{
	}
}

//Function Number: 8
func_C519(param_00,param_01,param_02,param_03)
{
}

//Function Number: 9
func_B052(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	var_07 = scripts\common\utility::func_49E6(param_00);
	var_07.var_13125["origin"] = param_01;
	var_07.var_13125["angles"] = (0,0,0);
	if(isdefined(param_03))
	{
		var_07.var_13125["angles"] = vectortoangles(param_03 - param_01);
	}

	var_07.var_13125["delay"] = param_02;
}

//Function Number: 10
func_4916()
{
	self.var_B051 = function_0173(level._effect[self.var_13125["fxid"]],self.var_13125["delay"],self.var_13125["origin"],0,self.var_13125["forward"],self.var_13125["up"]);
	func_4917();
}

//Function Number: 11
func_4917()
{
	self notify("stop_loop");
	if(!isdefined(self.var_13125["soundalias"]))
	{
		return;
	}

	if(self.var_13125["soundalias"] == "nil")
	{
		return;
	}

	var_00 = 0;
	var_01 = undefined;
	if(isdefined(self.var_13125["stopable"]) && self.var_13125["stopable"])
	{
		if(isdefined(self.var_B051))
		{
			var_01 = "death";
		}
		else
		{
			var_01 = "stop_loop";
		}
	}
	else if(level.var_128D.var_F27D && isdefined(self.var_13125["server_culled"]))
	{
		var_00 = self.var_13125["server_culled"];
	}

	var_02 = self;
	if(isdefined(self.var_B051))
	{
		var_02 = self.var_B051;
	}

	var_03 = undefined;
	if(level.createfx_enabled)
	{
		var_03 = self;
	}

	var_02 scripts\common\utility::func_B043(self.var_13125["soundalias"],self.var_13125["origin"],self.var_13125["angles"],var_00,var_01,var_03);
}

//Function Number: 12
func_4907()
{
	self notify("stop_loop");
	if(!isdefined(self.var_13125["soundalias"]))
	{
		return;
	}

	if(self.var_13125["soundalias"] == "nil")
	{
		return;
	}

	var_00 = undefined;
	var_01 = self;
	if((isdefined(self.var_13125["stopable"]) && self.var_13125["stopable"]) || level.createfx_enabled)
	{
		if(isdefined(self.var_B051))
		{
			var_01 = self.var_B051;
			var_00 = "death";
		}
		else
		{
			var_00 = "stop_loop";
		}
	}

	var_01 thread scripts\common\utility::func_B042(self.var_13125["soundalias"],self.var_13125["origin"],self.var_13125["angles"],var_00,undefined,self.var_13125["delay_min"],self.var_13125["delay_max"]);
}

//Function Number: 13
func_B059()
{
	scripts\common\utility::func_136F7();
	if(isdefined(self.var_7641))
	{
		level waittill("start fx" + self.var_7641);
	}

	for(;;)
	{
		func_4916();
		if(isdefined(self.var_11901))
		{
			thread func_B058(self.var_11901);
		}

		if(isdefined(self.var_7642))
		{
			level waittill("stop fx" + self.var_7642);
		}
		else
		{
			return;
		}

		if(isdefined(self.var_B051))
		{
			self.var_B051 delete();
		}

		if(isdefined(self.var_7641))
		{
			level waittill("start fx" + self.var_7641);
			continue;
		}
	}
}

//Function Number: 14
func_B058(param_00)
{
	self endon("death");
	wait(param_00);
	self.var_B051 delete();
}

//Function Number: 15
func_B065(param_00,param_01,param_02)
{
	level thread func_B067(param_00,param_01,param_02);
}

//Function Number: 16
func_B067(param_00,param_01,param_02)
{
	var_03 = spawn("script_origin",param_01);
	var_03.origin = param_01;
	var_03 playloopsound(param_00);
}

//Function Number: 17
func_86F7(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	thread func_86F8(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07);
}

//Function Number: 18
func_86F8(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	level endon("stop all gunfireloopfx");
	scripts\common\utility::func_136F7();
	if(param_07 < param_06)
	{
		var_08 = param_07;
		param_07 = param_06;
		param_06 = var_08;
	}

	var_09 = param_06;
	var_0A = param_07 - param_06;
	if(param_05 < param_04)
	{
		var_08 = param_05;
		param_05 = param_04;
		param_04 = var_08;
	}

	var_0B = param_04;
	var_0C = param_05 - param_04;
	if(param_03 < param_02)
	{
		var_08 = param_03;
		param_03 = param_02;
		param_02 = var_08;
	}

	var_0D = param_02;
	var_0E = param_03 - param_02;
	var_0F = spawnfx(level._effect[param_00],param_01);
	if(!level.createfx_enabled)
	{
		var_0F willneverchange();
	}

	for(;;)
	{
		var_10 = var_0D + randomint(var_0E);
		for(var_11 = 0;var_11 < var_10;var_11++)
		{
			triggerfx(var_0F);
			wait(var_0B + randomfloat(var_0C));
		}

		wait(var_09 + randomfloat(var_0A));
	}
}

//Function Number: 19
func_496F()
{
	if(!func_1329E(self.var_13125["fxid"]))
	{
		return;
	}

	self.var_B051 = spawnfx(level._effect[self.var_13125["fxid"]],self.var_13125["origin"],self.var_13125["forward"],self.var_13125["up"]);
	triggerfx(self.var_B051,self.var_13125["delay"]);
	if(!level.createfx_enabled)
	{
		self.var_B051 willneverchange();
	}

	func_4917();
}

//Function Number: 20
func_1329E(param_00)
{
	if(isdefined(level._effect[param_00]))
	{
		return 1;
	}

	if(!isdefined(level.var_134E))
	{
		level.var_134E = [];
	}

	level.var_134E[self.var_13125["fxid"]] = param_00;
	func_1329F(param_00);
	return 0;
}

//Function Number: 21
func_1329F(param_00)
{
	level notify("verify_effects_assignment_print");
	level endon("verify_effects_assignment_print");
	wait(0.05);
	var_01 = getarraykeys(level.var_134E);
	foreach(var_03 in var_01)
	{
	}
}

//Function Number: 22
func_C51A()
{
	wait(0.05);
	if(self.var_13125["delay"] > 0)
	{
		wait(self.var_13125["delay"]);
	}

	[[ level.var_74C2["create_triggerfx"] ]]();
}

//Function Number: 23
func_1734()
{
	if(!scripts\common\utility::issp() && getdvar("createfx") == "")
	{
		return;
	}

	if(!isdefined(level.var_128D.var_DD5C))
	{
		level.var_128D.var_DD5C = 1;
		level thread func_DD57();
	}

	if(!isdefined(level.var_128D.var_DD56))
	{
		level.var_128D.var_DD56 = [];
	}

	level.var_128D.var_DD56[level.var_128D.var_DD56.size] = self;
	self.var_BF54 = 3000;
}

//Function Number: 24
func_DD57()
{
	if(!scripts\common\utility::issp())
	{
		if(getdvar("createfx") == "on")
		{
			scripts\common\utility::flag_wait("createfx_started");
		}
	}

	level.var_128D.var_DD5B = [];
	var_00 = 256;
	for(;;)
	{
		level waittill("code_damageradius",var_01,var_00,var_02,var_03,var_04);
		var_05 = func_1042F(var_02,var_00);
		foreach(var_08, var_07 in var_05)
		{
			var_07 thread func_CDD9(var_08,var_04);
		}
	}
}

//Function Number: 25
func_13194(param_00)
{
	return (param_00[0],param_00[1],0);
}

//Function Number: 26
func_1042F(param_00,param_01)
{
	var_02 = [];
	var_03 = gettime();
	foreach(var_05 in level.var_128D.var_DD56)
	{
		if(var_05.var_BF54 > var_03)
		{
			continue;
		}

		var_06 = var_05.var_13125["reactive_radius"] + param_01;
		var_06 = var_06 * var_06;
		if(distancesquared(param_00,var_05.var_13125["origin"]) < var_06)
		{
			var_02[var_02.size] = var_05;
		}
	}

	foreach(var_05 in var_02)
	{
		var_09 = func_13194(var_05.var_13125["origin"] - level.player.origin);
		var_0A = func_13194(param_00 - level.player.origin);
		var_0B = vectornormalize(var_09);
		var_0C = vectornormalize(var_0A);
		var_05.var_5ABA = vectordot(var_0B,var_0C);
	}

	for(var_0E = 0;var_0E < var_02.size - 1;var_0E++)
	{
		for(var_0F = var_0E + 1;var_0F < var_02.size;var_0F++)
		{
			if(var_02[var_0E].var_5ABA > var_02[var_0F].var_5ABA)
			{
				var_10 = var_02[var_0E];
				var_02[var_0E] = var_02[var_0F];
				var_02[var_0F] = var_10;
			}
		}
	}

	foreach(var_05 in var_02)
	{
		var_05.origin = undefined;
		var_05.var_5ABA = undefined;
	}

	for(var_0E = 4;var_0E < var_02.size;var_0E++)
	{
		var_02[var_0E] = undefined;
	}

	return var_02;
}

//Function Number: 27
func_CDD9(param_00,param_01)
{
	if(self.var_13125["fxid"] != "No FX")
	{
		playfx(level._effect[self.var_13125["fxid"]],self.var_13125["origin"],self.var_13125["forward"],self.var_13125["up"]);
	}

	if(self.var_13125["soundalias"] == "nil")
	{
		return;
	}

	var_02 = func_7BFA();
	if(!isdefined(var_02))
	{
		return;
	}

	self.var_BF54 = gettime() + 3000;
	var_02.origin = self.var_13125["origin"];
	var_02.var_9C80 = 1;
	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	wait(param_00 * randomfloatrange(0.05,0.1) + param_01);
	if(scripts\common\utility::issp())
	{
		var_02 playsound(self.var_13125["soundalias"],"sounddone");
		var_02 waittill("sounddone");
	}
	else
	{
		var_02 playsound(self.var_13125["soundalias"]);
		wait(2);
	}

	wait(0.1);
	var_02.var_9C80 = 0;
}

//Function Number: 28
func_7BFA()
{
	foreach(var_01 in level.var_128D.var_DD5B)
	{
		if(!var_01.var_9C80)
		{
			return var_01;
		}
	}

	if(level.var_128D.var_DD5B.size < 4)
	{
		var_01 = spawn("script_origin",(0,0,0));
		var_01.var_9C80 = 0;
		level.var_128D.var_DD5B[level.var_128D.var_DD5B.size] = var_01;
		return var_01;
	}

	return undefined;
}

//Function Number: 29
func_D484(param_00,param_01,param_02,param_03)
{
	var_04 = 0;
	var_05 = [];
	foreach(var_07 in level.players)
	{
		if(var_07 method_84D9())
		{
			var_04 = 1;
			continue;
		}

		var_05[var_05.size] = var_07;
	}

	if(var_04)
	{
		foreach(var_07 in var_05)
		{
			playfx(param_00,param_01,param_02,param_03,var_07);
		}

		return;
	}

	playfx(param_00,param_01,param_02,param_03);
}