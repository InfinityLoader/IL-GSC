/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: common_scripts\_fx.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 39
 * Decompile Time: 651 ms
 * Timestamp: 10/27/2023 2:46:47 AM
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

	if(!isdefined(level._fx))
	{
		level._fx = spawnstruct();
	}

	common_scripts\utility::create_lock("createfx_looper",20);
	level.fxfireloopmod = 1;
	level._fx.exploderfunction = ::common_scripts\_exploder::exploder_before_load;
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

	var_00 = 0;
	if(var_00 < level.createfxent.size)
	{
		var_01 = level.createfxent[var_00];
		var_01 common_scripts\_createfx::set_forward_and_up_vectors();
		switch(var_01.v["type"])
		{
			case "loopfx":
				break;

			case "oneshotfx":
				break;

			case "soundfx":
				break;

			case "soundfx_interval":
				break;

			case "reactive_fx":
				break;

			case "soundfx_dynamic":
				break;
		}
	}
}

//Function Number: 2
remove_dupes()
{
}

//Function Number: 3
check_createfx_limit()
{
}

//Function Number: 4
check_limit_type(param_00,param_01)
{
}

//Function Number: 5
print_org(param_00,param_01,param_02,param_03)
{
	if(getdvar("debug") == "1")
	{
	}
}

//Function Number: 6
platformmatches()
{
	if(isdefined(self.v["platform"]) && isdefined(level.currentgen))
	{
		var_00 = self.v["platform"];
		if((var_00 == "cg" && !level.currentgen) || var_00 == "ng" && !level.nextgen || var_00 == "xenon" && !level.xenon || var_00 == "ps3" && !level.ps3 || var_00 == "pc" && !level.pc || var_00 == "xb3" && !level.xb3 || var_00 == "ps4" && !level.ps4 || var_00 == "pccg" && !level.pccg || var_00 == "!cg" && level.currentgen || var_00 == "!ng" && level.nextgen || var_00 == "!xenon" && level.xenon || var_00 == "!ps3" && level.ps3 || var_00 == "!pc" && level.pc || var_00 == "!xb3" && level.xb3 || var_00 == "!ps4" && level.ps4 || var_00 == "!pccg" && level.pccg)
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 7
oneshotfx(param_00,param_01,param_02,param_03)
{
}

//Function Number: 8
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

			var_13[var_13.size] = var_12;
			level.createfxexploders[var_12.v["exploder"]] = var_13;
		}

		return;
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

//Function Number: 9
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

//Function Number: 10
create_looper()
{
	self.looper = playloopedfx(level._effect[self.v["fxid"]],self.v["delay"],self.v["origin"],0,self.v["forward"],self.v["up"]);
	create_loopsound();
}

//Function Number: 11
create_loopsound()
{
	if(!platformmatches())
	{
		return;
	}

	self notify("stop_loop");
	if(!isdefined(self.v["soundalias"]))
	{
		return;
	}

	if(self.v["soundalias"] == "nil")
	{
		return;
	}

	var_00 = 0;
	var_01 = undefined;
	if(isdefined(self.v["stopable"]) && self.v["stopable"])
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
	else if(level._fx.server_culled_sounds && isdefined(self.v["server_culled"]))
	{
		var_00 = self.v["server_culled"];
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

	var_02 common_scripts\utility::loop_fx_sound_with_angles(self.v["soundalias"],self.v["origin"],self.v["angles"],var_00,var_01,var_03);
}

//Function Number: 12
create_interval_sound()
{
	if(!platformmatches())
	{
		return;
	}

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

	var_01 thread common_scripts\utility::loop_fx_sound_interval_with_angles(self.v["soundalias"],self.v["origin"],self.v["angles"],var_00,undefined,self.v["delay_min"],self.v["delay_max"]);
}

//Function Number: 13
create_dynamicambience()
{
	if(!platformmatches())
	{
		return;
	}

	if(!isdefined(self.v["ambiencename"]))
	{
		return;
	}

	if(self.v["ambiencename"] == "nil")
	{
		return;
	}

	if(common_scripts\utility::issp())
	{
		return;
	}

	if(getdvar("createfx") == "on")
	{
		common_scripts\utility::flag_wait("createfx_started");
	}

	if(isdefined(self.dambinfostruct))
	{
		level.player method_847A(self.dambinfostruct.unique_id);
	}

	self.dambinfostruct = spawnstruct();
	self.dambinfostruct common_scripts\utility::assign_unique_id();
	level.player method_8479(self.v["ambiencename"],self.v["origin"],self.v["dynamic_distance"],self.dambinfostruct.unique_id);
}

//Function Number: 14
loopfxthread()
{
	wait 0.05;
	if(isdefined(self.fxstart))
	{
		level waittill("start fx" + self.fxstart);
	}

	for(;;)
	{
		create_looper();
		if(isdefined(self.timeout))
		{
			thread loopfxstop(self.timeout);
		}

		if(isdefined(self.fxstop))
		{
			level waittill("stop fx" + self.fxstop);
		}
		else
		{
			return;
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

//Function Number: 15
loopfxchangeid(param_00)
{
	self endon("death");
	param_00 waittill("effect id changed",var_01);
}

//Function Number: 16
loopfxchangeorg(param_00)
{
	self endon("death");
	for(;;)
	{
		param_00 waittill("effect org changed",var_01);
		self.origin = var_01;
	}
}

//Function Number: 17
loopfxchangedelay(param_00)
{
	self endon("death");
	param_00 waittill("effect delay changed",var_01);
}

//Function Number: 18
loopfxdeletion(param_00)
{
	self endon("death");
	param_00 waittill("effect deleted");
	self delete();
}

//Function Number: 19
loopfxstop(param_00)
{
	self endon("death");
	wait(param_00);
	self.looper delete();
}

//Function Number: 20
loopsound(param_00,param_01,param_02)
{
	level thread loopsoundthread(param_00,param_01,param_02);
}

//Function Number: 21
loopsoundthread(param_00,param_01,param_02)
{
	var_03 = spawn("script_origin",param_01);
	var_03.origin = param_01;
	var_03 playloopsound(param_00);
}

//Function Number: 22
gunfireloopfx(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	thread gunfireloopfxthread(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07);
}

//Function Number: 23
gunfireloopfxthread(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	level endon("stop all gunfireloopfx");
	wait 0.05;
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

//Function Number: 24
gunfireloopfxvec(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	thread gunfireloopfxvecthread(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08);
}

//Function Number: 25
gunfireloopfxvecthread(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	level endon("stop all gunfireloopfx");
	wait 0.05;
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

			wait(var_13);
		}

		wait(var_0C + randomfloat(var_0D));
		wait(var_0A + randomfloat(var_0B));
	}
}

//Function Number: 26
setfireloopmod(param_00)
{
	level.fxfireloopmod = 1 / param_00;
}

//Function Number: 27
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

//Function Number: 28
burnville_paratrooper_hack()
{
	var_00 = (0,0,self.angles[1]);
	var_01 = level._effect[self.script_fxid];
	var_02 = self.origin;
	wait(1);
	level thread burnville_paratrooper_hack_loop(var_00,var_02,var_01);
	self delete();
}

//Function Number: 29
burnville_paratrooper_hack_loop(param_00,param_01,param_02)
{
	for(;;)
	{
		playfx(param_02,param_01);
		wait(30 + randomfloat(40));
	}
}

//Function Number: 30
create_triggerfx()
{
	if(!verify_effects_assignment(self.v["fxid"]))
	{
		return;
	}

	if(isdefined(self.v["tintcolor"]) || isdefined(self.v["tintalpha"]) || isdefined(self.v["fadein"]) || isdefined(self.v["fadeout"]) || isdefined(self.v["emissive"]) || isdefined(self.v["sizescale"]))
	{
		var_00 = self.v["tintcolor"];
		if(!isdefined(var_00))
		{
			var_00 = (1,1,1);
		}

		var_01 = self.v["tintalpha"];
		if(!isdefined(var_01))
		{
			var_01 = 1;
		}

		var_02 = self.v["fadein"];
		if(!isdefined(var_02))
		{
			var_02 = (0,0,0);
		}

		var_03 = self.v["fadeout"];
		if(!isdefined(var_03))
		{
			var_03 = (0,0,0);
		}

		var_04 = self.v["emissive"];
		if(!isdefined(var_04))
		{
			var_04 = 1;
		}

		var_05 = self.v["sizescale"];
		if(!isdefined(var_05))
		{
			var_05 = 1;
		}

		self.looper = spawnfx(level._effect[self.v["fxid"]],self.v["origin"],self.v["forward"],self.v["up"],var_00,var_01,var_02,var_03,var_04,var_05);
	}
	else
	{
		self.looper = spawnfx(level._effect[self.v["fxid"]],self.v["origin"],self.v["forward"],self.v["up"]);
	}

	triggerfx(self.looper,self.v["delay"]);
	if(!level.createfx_enabled)
	{
		self.looper willneverchange();
	}
	else
	{
		setfxkillondelete(self.looper,1);
	}

	create_loopsound();
}

//Function Number: 31
verify_effects_assignment(param_00)
{
	if(isdefined(level._effect[param_00]))
	{
		return 1;
	}

	if(!isdefined(level._missing_fx))
	{
		level._missing_fx = [];
	}

	level._missing_fx[self.v["fxid"]] = param_00;
	verify_effects_assignment_print(param_00);
	return 0;
}

//Function Number: 32
verify_effects_assignment_print(param_00)
{
	level notify("verify_effects_assignment_print");
	level endon("verify_effects_assignment_print");
	wait(0.05);
	var_01 = getarraykeys(level._missing_fx);
	foreach(var_03 in var_01)
	{
	}
}

//Function Number: 33
oneshotfxthread()
{
	wait(0.05);
	if(!platformmatches())
	{
		return;
	}

	if(self.v["delay"] > 0)
	{
		wait(self.v["delay"]);
	}

	[[ level.func["create_triggerfx"] ]]();
}

//Function Number: 34
add_reactive_fx()
{
	if(!platformmatches())
	{
		return;
	}

	if(!common_scripts\utility::issp() && getdvar("createfx") == "")
	{
		return;
	}

	if(!isdefined(level._fx.reactive_thread))
	{
		level._fx.reactive_thread = 1;
		level thread reactive_fx_thread();
	}

	if(!isdefined(level._fx.reactive_fx_ents))
	{
		level._fx.reactive_fx_ents = [];
	}

	level._fx.reactive_fx_ents[level._fx.reactive_fx_ents.size] = self;
	self.next_reactive_time = 3000;
}

//Function Number: 35
reactive_fx_thread()
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
		var_04 = sort_reactive_ents(var_02,var_00);
		foreach(var_07, var_06 in var_04)
		{
			var_06 thread play_reactive_fx(var_07);
		}
	}
}

//Function Number: 36
vector2d(param_00)
{
	return (param_00[0],param_00[1],0);
}

//Function Number: 37
sort_reactive_ents(param_00,param_01)
{
	var_02 = [];
	var_03 = gettime();
	foreach(var_05 in level._fx.reactive_fx_ents)
	{
		if(var_05.next_reactive_time > var_03)
		{
			continue;
		}

		var_06 = var_05.v["reactive_radius"] + param_01;
		var_06 = var_06 * var_06;
		if(distancesquared(param_00,var_05.v["origin"]) < var_06)
		{
			var_02[var_02.size] = var_05;
		}
	}

	foreach(var_05 in var_02)
	{
		var_09 = vector2d(var_05.v["origin"] - level.player.origin);
		var_0A = vector2d(param_00 - level.player.origin);
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

//Function Number: 38
play_reactive_fx(param_00)
{
	var_01 = get_reactive_sound_ent();
	if(!isdefined(var_01))
	{
		return;
	}

	self.next_reactive_time = gettime() + 3000;
	var_01.origin = self.v["origin"];
	var_01.is_playing = 1;
	wait(param_00 * randomfloatrange(0.05,0.1));
	if(common_scripts\utility::issp())
	{
		var_01 playsound(self.v["soundalias"],"sounddone");
		var_01 waittill("sounddone");
	}
	else
	{
		var_01 playsound(self.v["soundalias"]);
		wait(2);
	}

	wait(0.1);
	var_01.is_playing = 0;
}

//Function Number: 39
get_reactive_sound_ent()
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