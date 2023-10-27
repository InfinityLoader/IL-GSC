/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: common_scripts\_fx.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 28
 * Decompile Time: 449 ms
 * Timestamp: 10/27/2023 2:15:48 AM
*******************************************************************/

//Function Number: 1
initfx()
{
	if(!isdefined(level.func))
	{
		level.func = [];
	}

	if(!isdefined(level.func["create_triggerfx"]))
	{
		level.func["create_triggerfx"] = ::create_triggerfx;
	}

	common_scripts\utility::create_lock("createfx_looper",20);
	level.var_7CD = ::common_scripts\utility::exploder_before_load;
	waittillframeend;
	waittillframeend;
	level.var_7CD = ::common_scripts\utility::exploder_after_load;
	level.var_7CF = 0;
	if(getdvarint("serverCulledSounds") == 1)
	{
		level.var_7CF = 1;
	}

	if(level.createfx_enabled)
	{
		level.var_7CF = 0;
	}

	if(level.createfx_enabled)
	{
		level waittill("createfx_common_done");
	}

	if(isdefined(level.var_3FF))
	{
		wait level.var_3FF;
	}

	for(var_00 = 0;var_00 < level.createfxent.size;var_00++)
	{
		var_01 = level.createfxent[var_00];
		var_01 common_scripts\_createfx::set_forward_and_up_vectors();
		if(var_01.v["type"] == "loopfx")
		{
			var_01 thread loopfxthread();
		}

		if(var_01.v["type"] == "oneshotfx")
		{
			var_01 thread oneshotfxthread();
		}

		if(var_01.v["type"] == "soundfx")
		{
			var_01 thread create_loopsound();
		}

		if(var_01.v["type"] == "soundfx_interval")
		{
			var_01 thread create_interval_sound();
		}
	}
}

//Function Number: 2
print_org(param_00,param_01,param_02,param_03)
{
	if(getdvar("debug") == "1")
	{
	}
}

//Function Number: 3
oneshotfx(param_00,param_01,param_02,param_03)
{
}

//Function Number: 4
exploderfx(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B,param_0C,param_0D,param_0E,param_0F,param_10,param_11)
{
	if(1)
	{
		var_12 = common_scripts\utility::createexploder(param_01);
		var_12.v["origin"] = param_02;
		var_12.v["angles"] = (0,0,0);
		if(isdefined(param_04))
		{
			var_12.v["angles"] = vectortoangles(param_04 - param_02);
		}

		var_12.v["delay"] = param_03;
		var_12.v["exploder"] = param_00;
		if(isdefined(level.createfxexploders))
		{
			var_13 = level.createfxexploders[var_12.v["exploder"]];
			if(!isdefined(var_13))
			{
				var_13 = [];
			}

			level.createfxexploders[var_13.v["exploder"]] = var_7B;
		}

		return;
	}

	var_14 = spawn("script_origin",(0,0,0));
	var_14.origin = param_04;
	var_14.angles = vectortoangles(param_06 - param_04);
	var_14.script_exploder = param_02;
	var_14.script_fxid = param_03;
	var_14.script_delay = param_05;
	var_14.script_firefx = param_07;
	var_14.script_firefxdelay = param_08;
	var_14.script_firefxsound = param_09;
	var_14.script_sound = param_0A;
	var_14.script_earthquake = param_0B;
	var_14.script_damage = param_0C;
	var_14.script_radius = param_11;
	var_14.script_soundalias = param_0D;
	var_14.script_firefxtimeout = var_12;
	var_14.script_repeat = param_0E;
	var_14.script_delay_min = param_0F;
	var_14.var_7E6 = param_10;
	var_14.var_7E7 = var_13;
	var_15 = anglestoforward(var_14.angles);
	var_15 = var_15 * 150;
	var_14.targetpos = param_04 + var_15;
	if(!isdefined(level.var_7E9))
	{
		level.var_7E9 = [];
	}

	level.var_7E9[level.var_7E9.size] = var_14;
	common_scripts\_createfx::createfx_showorigin(param_03,param_04,param_05,param_06,"exploderfx",var_14,undefined,param_07,param_08,param_09,param_0A,param_0B,param_0C,param_0D,param_0E,param_0F,param_10,param_11,var_12);
}

//Function Number: 5
loopfx(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	var_07 = common_scripts\utility::createloopeffect(param_00);
	var_07.v["origin"] = param_01;
	var_07.v["angles"] = (0,0,0);
	if(isdefined(param_03))
	{
		var_07.v["angles"] = vectortoangles(param_03 - param_01);
	}

	var_07.v["delay"] = param_02;
}

//Function Number: 6
create_looper()
{
	self.looper = playloopedfx(level._effect[self.v["fxid"]],self.v["delay"],self.v["origin"],0,self.v["forward"],self.v["up"]);
	create_loopsound();
}

//Function Number: 7
create_loopsound()
{
	self notify("stop_loop");
	if(isdefined(self.v["soundalias"]) && self.v["soundalias"] != "nil")
	{
		if(isdefined(self.v["stopable"]) && self.v["stopable"])
		{
			if(isdefined(self.looper))
			{
				self.looper thread common_scripts\utility::loop_fx_sound(self.v["soundalias"],self.v["origin"],0,"death");
				return;
			}

			thread common_scripts\utility::loop_fx_sound(self.v["soundalias"],self.v["origin"],0,"stop_loop");
			return;
		}

		if(isdefined(self.looper))
		{
			self.looper thread common_scripts\utility::loop_fx_sound(self.v["soundalias"],self.v["origin"],0);
			return;
		}

		var_00 = 0;
		if(level.var_7CF == 1 && isdefined(self.v["server_culled"]))
		{
			var_00 = self.v["server_culled"];
		}

		thread common_scripts\utility::loop_fx_sound(self.v["soundalias"],self.v["origin"],var_00);
		return;
	}
}

//Function Number: 8
create_interval_sound()
{
	self notify("stop_loop");
	if(!isdefined(self.v["soundalias"]))
	{
		return;
	}

	if(self.v["soundalias"] == "nil")
	{
		return;
	}

	var_00 = undefined;
	var_01 = self;
	if((isdefined(self.v["stopable"]) && self.v["stopable"]) || level.createfx_enabled)
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

	var_01 thread common_scripts\utility::loop_fx_sound_interval(self.v["soundalias"],self.v["origin"],var_00,undefined,self.v["delay_min"],self.v["delay_max"]);
}

//Function Number: 9
loopfxthread()
{
	common_scripts\utility::waitframe();
	if(isdefined(self.var_7F6))
	{
		level waittill("start fx" + self.var_7F6);
	}

	for(;;)
	{
		create_looper();
		if(isdefined(self.timeout))
		{
			thread loopfxstop(self.timeout);
		}

		if(isdefined(self.var_7F8))
		{
			level waittill("stop fx" + self.var_7F8);
		}
		else
		{
			return;
		}

		if(isdefined(self.looper))
		{
			self.looper delete();
		}

		if(isdefined(self.var_7F6))
		{
			level waittill("start fx" + self.var_7F6);
			continue;
		}
	}
}

//Function Number: 10
loopfxchangeid(param_00)
{
	self endon("death");
	param_00 waittill("effect id changed",var_01);
}

//Function Number: 11
loopfxchangeorg(param_00)
{
	self endon("death");
	for(;;)
	{
		param_00 waittill("effect org changed",var_01);
		self.origin = var_01;
	}
}

//Function Number: 12
loopfxchangedelay(param_00)
{
	self endon("death");
	param_00 waittill("effect delay changed",var_01);
}

//Function Number: 13
loopfxdeletion(param_00)
{
	self endon("death");
	param_00 waittill("effect deleted");
	self delete();
}

//Function Number: 14
loopfxstop(param_00)
{
	self endon("death");
	wait param_00;
	self.looper delete();
}

//Function Number: 15
loopsound(param_00,param_01,param_02)
{
	level thread loopsoundthread(param_00,param_01,param_02);
}

//Function Number: 16
loopsoundthread(param_00,param_01,param_02)
{
	var_03 = spawn("script_origin",param_01);
	var_03.origin = param_01;
	var_03 playloopsound(param_00);
}

//Function Number: 17
gunfireloopfx(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	thread gunfireloopfxthread(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07);
}

//Function Number: 18
gunfireloopfxthread(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	level endon("stop all gunfireloopfx");
	common_scripts\utility::waitframe();
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
			wait var_0B + randomfloat(var_0C);
		}

		wait var_09 + randomfloat(var_0A);
	}
}

//Function Number: 19
gunfireloopfxvec(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	thread gunfireloopfxvecthread(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08);
}

//Function Number: 20
gunfireloopfxvecthread(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	level endon("stop all gunfireloopfx");
	common_scripts\utility::waitframe();
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
		var_10 willneverchange();
	}

	for(;;)
	{
		var_11 = var_0E + randomint(var_0F);
		for(var_12 = 0;var_12 < int(var_11 / level.fxfireloopmod);var_12++)
		{
			triggerfx(var_10);
			var_13 = var_0C + randomfloat(var_0D) * level.fxfireloopmod;
			if(var_13 < 0.05)
			{
				var_13 = 0.05;
			}

			wait var_13;
		}

		wait var_0C + randomfloat(var_0D);
		wait var_0A + randomfloat(var_0B);
	}
}

//Function Number: 21
setfireloopmod(param_00)
{
	level.fxfireloopmod = 1 / param_00;
}

//Function Number: 22
setup_fx()
{
	if(!isdefined(self.script_fxid) || !isdefined(self.script_fxcommand) || !isdefined(self.script_delay))
	{
		return;
	}

	if(isdefined(self.model))
	{
		if(self.model == "toilet")
		{
			thread burnville_paratrooper_hack();
			return;
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
	if(isdefined(self.var_808))
	{
		var_02 = self.var_808;
	}

	var_03 = undefined;
	if(isdefined(self.var_809))
	{
		var_03 = self.var_809;
	}

	if(self.script_fxcommand == "OneShotfx")
	{
		oneshotfx(self.script_fxid,self.origin,self.script_delay,var_00);
	}

	if(self.script_fxcommand == "loopfx")
	{
		loopfx(self.script_fxid,self.origin,self.script_delay,var_00,var_02,var_03);
	}

	if(self.script_fxcommand == "loopsound")
	{
		loopsound(self.script_fxid,self.origin,self.script_delay);
	}

	self delete();
}

//Function Number: 23
burnville_paratrooper_hack()
{
	var_00 = (0,0,self.angles[1]);
	var_01 = level._effect[self.script_fxid];
	var_02 = self.origin;
	wait 1;
	level thread burnville_paratrooper_hack_loop(var_00,var_02,var_01);
	self delete();
}

//Function Number: 24
burnville_paratrooper_hack_loop(param_00,param_01,param_02)
{
	for(;;)
	{
		playfx(param_02,param_01);
		wait 30 + randomfloat(40);
	}
}

//Function Number: 25
create_triggerfx()
{
	if(!verify_effects_assignment(self.v["fxid"]))
	{
		return;
	}

	self.looper = spawnfx(level._effect[self.v["fxid"]],self.v["origin"],self.v["forward"],self.v["up"]);
	triggerfx(self.looper,self.v["delay"]);
	if(!level.createfx_enabled)
	{
		self.looper willneverchange();
	}

	create_loopsound();
}

//Function Number: 26
verify_effects_assignment(param_00)
{
	if(isdefined(level._effect[param_00]))
	{
		return 1;
	}

	if(!isdefined(level.var_80E))
	{
		level.var_80E = [];
	}

	level.var_80E[self.v["fxid"]] = param_00;
	verify_effects_assignment_print(param_00);
	return 0;
}

//Function Number: 27
verify_effects_assignment_print(param_00)
{
	level notify("verify_effects_assignment_print");
	level endon("verify_effects_assignment_print");
	wait 0.05;
	var_01 = getarraykeys(level.var_80E);
	foreach(var_03 in var_01)
	{
	}
}

//Function Number: 28
oneshotfxthread()
{
	common_scripts\utility::waitframe();
	if(self.v["delay"] > 0)
	{
		wait self.v["delay"];
	}

	[[ level.func["create_triggerfx"] ]]();
}