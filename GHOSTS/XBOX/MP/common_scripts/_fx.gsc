/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: common_scripts\_fx.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 37
 * Decompile Time: 584 ms
 * Timestamp: 10/27/2023 1:34:10 AM
*******************************************************************/

//Function Number: 1
func_460F()
{
	if(!isdefined(level.func))
	{
		level.func = [];
	}

	if(!isdefined(level.func["create_triggerfx"]))
	{
		level.func["create_triggerfx"] = ::func_20BB;
	}

	if(!isdefined(level._fx))
	{
		level._fx = addstruct();
	}

	common_scripts\utility::create_lock("createfx_looper",20);
	level.fxfireloopmod = 1;
	level._fx.exploderfunction = ::common_scripts\_exploder::func_30B3;
	waittillframeend;
	waittillframeend;
	level._fx.exploderfunction = ::common_scripts\_exploder::exploder_after_load;
	level._fx.server_culled_sounds = 0;
	if(getdvarint("serverCulledSounds") == 1)
	{
		level._fx.server_culled_sounds = 1;
	}

	if(level.createfx_enabled)
	{
		level._fx.server_culled_sounds = 0;
	}

	if(level.createfx_enabled)
	{
		level waittill("createfx_common_done");
	}

	for(var_00 = 0;var_00 < level.createfxent.size;var_00++)
	{
		var_01 = level.createfxent[var_00];
		var_01 common_scripts\_createfx::func_6EE6();
		switch(var_01.var_880E["type"])
		{
			case "loopfx":
				var_01 thread func_4F7C();
				break;

			case "oneshotfx":
				var_01 thread func_592D();
				break;

			case "soundfx":
				var_01 thread create_loopsound();
				break;

			case "soundfx_interval":
				var_01 thread func_2094();
				break;

			case "reactive_fx":
				var_01 add_reactive_fx();
				break;
		}
	}

	func_1B4F();
}

//Function Number: 2
remove_dupes()
{
}

//Function Number: 3
func_1B4F()
{
}

//Function Number: 4
func_1B76(param_00,param_01)
{
}

//Function Number: 5
func_619D(param_00,param_01,param_02,param_03)
{
	if(getdvar("debug") == "1")
	{
	}
}

//Function Number: 6
func_592C(param_00,param_01,param_02,param_03)
{
}

//Function Number: 7
exploderfx(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B,param_0C,param_0D,param_0E,param_0F,param_10,param_11)
{
	if(1)
	{
		var_12 = common_scripts\utility::createexploder(param_01);
		var_12.var_880E["origin"] = param_02;
		var_12.var_880E["angles"] = (0,0,0);
		if(isdefined(param_04))
		{
			var_12.var_880E["angles"] = vectortoangles(param_04 - param_02);
		}

		var_12.var_880E["delay"] = param_03;
		var_12.var_880E["exploder"] = param_00;
		if(isdefined(level.createfxexploders))
		{
			var_13 = level.createfxexploders[var_12.var_880E["exploder"]];
			if(!isdefined(var_13))
			{
				var_13 = [];
			}

			var_13[var_13.size] = var_12;
			level.createfxexploders[var_12.var_880E["exploder"]] = var_13;
		}
	}

	var_14 = spawn("script_origin",(0,0,0));
	var_14.origin = param_03;
	var_14.angles = vectortoangles(param_05 - param_03);
	var_14.script_exploder = param_01;
	var_14.script_fxid = param_02;
	var_14.script_delay = param_04;
	var_14.script_firefx = param_06;
	var_14.script_firefxdelay = param_07;
	var_14.script_firefxsound = param_08;
	var_14.script_sound = param_09;
	var_14.script_earthquake = param_0A;
	var_14.script_damage = param_0B;
	var_14.script_radius = param_10;
	var_14.script_soundalias = param_0C;
	var_14.script_firefxtimeout = param_11;
	var_14.script_repeat = param_0D;
	var_14.script_delay_min = param_0E;
	var_14.script_delay_max = param_0F;
	var_14.script_exploder_group = var_12;
	var_15 = anglestoforward(var_14.angles);
	var_15 = var_15 * 150;
	var_14.targetpos = param_03 + var_15;
	if(!isdefined(level._script_exploders))
	{
		level._script_exploders = [];
	}

	level._script_exploders[level._script_exploders.size] = var_14;
}

//Function Number: 8
func_4F75(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	var_07 = common_scripts\utility::createloopeffect(param_00);
	var_07.var_880E["origin"] = param_01;
	var_07.var_880E["angles"] = (0,0,0);
	if(isdefined(param_03))
	{
		var_07.var_880E["angles"] = vectortoangles(param_03 - param_01);
	}

	var_07.var_880E["delay"] = param_02;
}

//Function Number: 9
create_looper()
{
	self.looper = playloopedfx(level._effect[self.var_880E["fxid"]],self.var_880E["delay"],self.var_880E["origin"],0,self.var_880E["forward"],self.var_880E["up"]);
	create_loopsound();
}

//Function Number: 10
create_loopsound()
{
	self notify("stop_loop");
	if(!isdefined(self.var_880E["soundalias"]))
	{
	}

	if(self.var_880E["soundalias"] == "nil")
	{
	}

	var_00 = 0;
	var_01 = undefined;
	if(isdefined(self.var_880E["stopable"]) && self.var_880E["stopable"])
	{
		if(isdefined(self.looper))
		{
			var_01 = "death";
		}
		else
		{
			var_01 = "stop_loop";
		}
	}
	else if(level._fx.server_culled_sounds && isdefined(self.var_880E["server_culled"]))
	{
		var_00 = self.var_880E["server_culled"];
	}

	var_02 = self;
	if(isdefined(self.looper))
	{
		var_02 = self.looper;
	}

	var_03 = undefined;
	if(level.createfx_enabled)
	{
		var_03 = self;
	}

	var_02 common_scripts\utility::func_4F6B(self.var_880E["soundalias"],self.var_880E["origin"],self.var_880E["angles"],var_00,var_01,var_03);
}

//Function Number: 11
func_2094()
{
	self notify("stop_loop");
	if(!isdefined(self.var_880E["soundalias"]))
	{
	}

	if(self.var_880E["soundalias"] == "nil")
	{
	}

	var_00 = undefined;
	var_01 = self;
	if((isdefined(self.var_880E["stopable"]) && self.var_880E["stopable"]) || level.createfx_enabled)
	{
		if(isdefined(self.looper))
		{
			var_01 = self.looper;
			var_00 = "death";
		}
		else
		{
			var_00 = "stop_loop";
		}
	}

	var_01 thread common_scripts\utility::func_4F6A(self.var_880E["soundalias"],self.var_880E["origin"],self.var_880E["angles"],var_00,undefined,self.var_880E["delay_min"],self.var_880E["delay_max"]);
}

//Function Number: 12
func_4F7C()
{
	common_scripts\utility::func_8AFE();
	if(isdefined(self.fxstart))
	{
		level waittill("start fx" + self.fxstart);
	}

	for(;;)
	{
		create_looper();
		if(isdefined(self.timeout))
		{
			thread func_4F7B(self.timeout);
		}

		if(isdefined(self.fxstop))
		{
			level waittill("stop fx" + self.fxstop);
		}
		else
		{
		}

		if(isdefined(self.looper))
		{
			self.looper delete();
		}

		if(isdefined(self.fxstart))
		{
			level waittill("start fx" + self.fxstart);
			continue;
		}
	}
}

//Function Number: 13
func_4F78(param_00)
{
	self endon("death");
	param_00 waittill("effect id changed",var_01);
}

//Function Number: 14
func_4F79(param_00)
{
	self endon("death");
	for(;;)
	{
		param_00 waittill("effect org changed",var_01);
		self.origin = var_01;
	}
}

//Function Number: 15
func_4F77(param_00)
{
	self endon("death");
	param_00 waittill("effect delay changed",var_01);
}

//Function Number: 16
func_4F7A(param_00)
{
	self endon("death");
	param_00 waittill("effect deleted");
	self delete();
}

//Function Number: 17
func_4F7B(param_00)
{
	self endon("death");
	wait(param_00);
	self.looper delete();
}

//Function Number: 18
func_4F84(param_00,param_01,param_02)
{
	level thread func_4F86(param_00,param_01,param_02);
}

//Function Number: 19
func_4F86(param_00,param_01,param_02)
{
	var_03 = spawn("script_origin",param_01);
	var_03.origin = param_01;
	var_03 playloopsound(param_00);
}

//Function Number: 20
func_3E0C(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	thread func_3E0D(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07);
}

//Function Number: 21
func_3E0D(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	level endon("stop all gunfireloopfx");
	common_scripts\utility::func_8AFE();
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
		var_0F entitywillneverchange();
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

//Function Number: 22
func_3E0E(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	thread gunfireloopfxvecthread(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08);
}

//Function Number: 23
gunfireloopfxvecthread(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	level endon("stop all gunfireloopfx");
	common_scripts\utility::func_8AFE();
	if(param_08 < param_07)
	{
		var_09 = param_08;
		param_08 = param_07;
		param_07 = var_09;
	}

	var_0A = param_07;
	var_0B = param_08 - param_07;
	if(param_06 < param_05)
	{
		var_09 = param_06;
		param_06 = param_05;
		param_05 = var_09;
	}

	var_0C = param_05;
	var_0D = param_06 - param_05;
	if(param_04 < param_03)
	{
		var_09 = param_04;
		param_04 = param_03;
		param_03 = var_09;
	}

	var_0E = param_03;
	var_0F = param_04 - param_03;
	param_02 = vectornormalize(param_02 - param_01);
	var_10 = spawnfx(level._effect[param_00],param_01,param_02);
	if(!level.createfx_enabled)
	{
		var_10 entitywillneverchange();
	}

	for(;;)
	{
		var_11 = var_0E + randomint(var_0F);
		for(var_12 = 0;var_12 < castint(var_11 / level.fxfireloopmod);var_12++)
		{
			triggerfx(var_10);
			var_13 = var_0C + randomfloat(var_0D) * level.fxfireloopmod;
			if(var_13 < 0.05)
			{
				var_13 = 0.05;
			}

			wait(var_13);
		}

		wait(var_0C + randomfloat(var_0D));
		wait(var_0A + randomfloat(var_0B));
	}
}

//Function Number: 24
func_7032(param_00)
{
	level.fxfireloopmod = 1 / param_00;
}

//Function Number: 25
func_715A()
{
	if(!isdefined(self.script_fxid) || !isdefined(self.script_fxcommand) || !isdefined(self.script_delay))
	{
	}

	if(isdefined(self.model))
	{
		if(self.model == "toilet")
		{
			thread func_18AE();
		}
	}

	var_00 = undefined;
	if(isdefined(self.target))
	{
		var_01 = getent(self.target,"targetname");
		if(isdefined(var_01))
		{
			var_00 = var_01.origin;
		}
	}

	var_02 = undefined;
	if(isdefined(self.script_fxstart))
	{
		var_02 = self.script_fxstart;
	}

	var_03 = undefined;
	if(isdefined(self.script_fxstop))
	{
		var_03 = self.script_fxstop;
	}

	if(self.script_fxcommand == "OneShotfx")
	{
		func_592C(self.script_fxid,self.origin,self.script_delay,var_00);
	}

	if(self.script_fxcommand == "loopfx")
	{
		func_4F75(self.script_fxid,self.origin,self.script_delay,var_00,var_02,var_03);
	}

	if(self.script_fxcommand == "loopsound")
	{
		func_4F84(self.script_fxid,self.origin,self.script_delay);
	}

	self delete();
}

//Function Number: 26
func_18AE()
{
	var_00 = (0,0,self.angles[1]);
	var_01 = level._effect[self.script_fxid];
	var_02 = self.origin;
	wait(1);
	level thread burnville_paratrooper_hack_loop(var_00,var_02,var_01);
	self delete();
}

//Function Number: 27
burnville_paratrooper_hack_loop(param_00,param_01,param_02)
{
	for(;;)
	{
		playfx(param_02,param_01);
		wait(30 + randomfloat(40));
	}
}

//Function Number: 28
func_20BB()
{
	if(!func_8964(self.var_880E["fxid"]))
	{
	}

	self.looper = spawnfx(level._effect[self.var_880E["fxid"]],self.var_880E["origin"],self.var_880E["forward"],self.var_880E["up"]);
	triggerfx(self.looper,self.var_880E["delay"]);
	if(!level.createfx_enabled)
	{
		self.looper entitywillneverchange();
	}

	create_loopsound();
}

//Function Number: 29
func_8964(param_00)
{
	if(isdefined(level._effect[param_00]))
	{
		return 1;
	}

	if(!isdefined(level._missing_fx))
	{
		level._missing_fx = [];
	}

	level._missing_fx[self.var_880E["fxid"]] = param_00;
	func_8965(param_00);
	return 0;
}

//Function Number: 30
func_8965(param_00)
{
	level notify("verify_effects_assignment_print");
	level endon("verify_effects_assignment_print");
	wait(0.05);
	var_01 = getarraykeys(level._missing_fx);
	foreach(var_03 in var_01)
	{
	}
}

//Function Number: 31
func_592D()
{
	wait(0.05);
	if(self.var_880E["delay"] > 0)
	{
		wait(self.var_880E["delay"]);
	}

	[[ level.func["create_triggerfx"] ]]();
}

//Function Number: 32
add_reactive_fx()
{
	if(!common_scripts\utility::issp() && getdvar("createfx") == "")
	{
	}

	if(!isdefined(level._fx.reactive_thread))
	{
		level._fx.reactive_thread = 1;
		level thread func_63C3();
	}

	if(!isdefined(level._fx.reactive_fx_ents))
	{
		level._fx.reactive_fx_ents = [];
	}

	level._fx.reactive_fx_ents[level._fx.reactive_fx_ents.size] = self;
	self.next_reactive_time = 3000;
}

//Function Number: 33
func_63C3()
{
	if(!common_scripts\utility::issp())
	{
		if(getdvar("createfx") == "on")
		{
			common_scripts\utility::flag_wait("createfx_started");
		}
	}

	level._fx.reactive_sound_ents = [];
	var_00 = 256;
	for(;;)
	{
		level waittill("code_damageradius",var_01,var_00,var_02,var_03);
		var_04 = func_76F4(var_02,var_00);
		foreach(var_07, var_06 in var_04)
		{
			var_06 thread func_5D0F(var_07);
		}
	}
}

//Function Number: 34
func_8876(param_00)
{
	return (param_00[0],param_00[1],0);
}

//Function Number: 35
func_76F4(param_00,param_01)
{
	var_02 = [];
	var_03 = gettime();
	foreach(var_05 in level._fx.reactive_fx_ents)
	{
		if(var_05.next_reactive_time > var_03)
		{
			continue;
		}

		var_06 = var_05.var_880E["reactive_radius"] + param_01;
		var_06 = var_06 * var_06;
		if(distancesquared(param_00,var_05.var_880E["origin"]) < var_06)
		{
			var_02[var_02.size] = var_05;
		}
	}

	foreach(var_05 in var_02)
	{
		var_09 = func_8876(var_05.var_880E["origin"] - level.player.origin);
		var_0A = func_8876(param_00 - level.player.origin);
		var_0B = vectornormalize(var_09);
		var_0C = vectornormalize(var_0A);
		var_05.dot = vectordot(var_0B,var_0C);
	}

	for(var_0E = 0;var_0E < var_02.size - 1;var_0E++)
	{
		for(var_0F = var_0E + 1;var_0F < var_02.size;var_0F++)
		{
			if(var_02[var_0E].dot > var_02[var_0F].dot)
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
		var_05.dot = undefined;
	}

	for(var_0E = 4;var_0E < var_02.size;var_0E++)
	{
		var_02[var_0E] = undefined;
	}

	return var_02;
}

//Function Number: 36
func_5D0F(param_00)
{
	var_01 = func_397C();
	if(!isdefined(var_01))
	{
	}

	self.next_reactive_time = gettime() + 3000;
	var_01.origin = self.var_880E["origin"];
	var_01.is_playing = 1;
	wait(param_00 * randomfloatrange(0.05,0.1));
	if(common_scripts\utility::issp())
	{
		var_01 playsound(self.var_880E["soundalias"],"sounddone");
		var_01 waittill("sounddone");
	}
	else
	{
		var_01 playsound(self.var_880E["soundalias"]);
		wait(2);
	}

	wait(0.1);
	var_01.is_playing = 0;
}

//Function Number: 37
func_397C()
{
	foreach(var_01 in level._fx.reactive_sound_ents)
	{
		if(!var_01.is_playing)
		{
			return var_01;
		}
	}

	if(level._fx.reactive_sound_ents.size < 4)
	{
		var_01 = spawn("script_origin",(0,0,0));
		var_01.is_playing = 0;
		level._fx.reactive_sound_ents[level._fx.reactive_sound_ents.size] = var_01;
		return var_01;
	}

	return undefined;
}