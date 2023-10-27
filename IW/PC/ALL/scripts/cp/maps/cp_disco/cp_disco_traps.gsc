/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\cp\maps\cp_disco\cp_disco_traps.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 25
 * Decompile Time: 1399 ms
 * Timestamp: 10/27/2023 12:04:10 AM
*******************************************************************/

//Function Number: 1
init_buffer_trap()
{
	scripts\common\utility::array_thread(scripts\common\utility::getstructarray("trap_buffer","script_noteworthy"),::power_on_buffer);
}

//Function Number: 2
power_on_buffer()
{
	var_00 = getent(self.target,"targetname");
	var_00 method_8318(1);
	if(scripts\common\utility::istrue(self.var_E1B9))
	{
		var_01 = undefined;
		if(isdefined(self.script_area))
		{
			var_01 = self.script_area;
		}
		else
		{
			var_01 = scripts\cp\_interaction::func_7829(self);
		}

		if(isdefined(var_01))
		{
			level scripts\common\utility::waittill_any_3("power_on",var_01 + " power_on");
		}
	}

	self.var_D776 = 1;
}

//Function Number: 3
use_buffer_trap(param_00,param_01)
{
	scripts\cp\_interaction::remove_from_current_interaction_list(param_00);
	param_01 thread scripts\cp\_vo::try_to_play_vo("activate_trap_generic","zmb_comment_vo","low",10,0,1,0,40);
	var_02 = getent(param_00.target,"targetname");
	if(!isdefined(var_02.var_127C9))
	{
		var_03 = [];
		foreach(var_05 in scripts\common\utility::getstructarray(param_00.target,"targetname"))
		{
			var_03[var_03.size] = spawn("trigger_radius",var_05.origin,0,var_05.var_257,var_05.height);
		}

		foreach(var_08 in var_03)
		{
			var_08 enablelinkto();
			var_08 linkto(var_02);
		}

		var_02.var_127C9 = var_03;
	}

	playfxontag(level._effect["buffer_smoke"],var_02,"tag_origin");
	param_01 playlocalsound("purchase_generic");
	var_02 buffer_trap_sfx();
	param_00.var_126A4 = 0;
	if(!isdefined(param_00.offset_vector))
	{
		param_00.offset_forward = distance2d(var_02.origin,param_00.origin) * -1;
	}

	param_00.offset_up = distance2d(var_02.origin,param_00.origin);
	var_0A = var_02.origin;
	var_0B = 0;
	while(var_0B < 2)
	{
		var_02 moveto(var_02.origin + (0,0,5),0.1);
		foreach(param_01 in level.players)
		{
			var_0D = param_01.origin[2] - var_02.origin[2];
			if(distance(var_02.origin,param_01.origin) < 72 && param_01.origin[2] > var_02.origin[2] && var_0D < 72)
			{
				param_01 setvelocity((randomintrange(220,250),randomintrange(220,250),0));
			}
		}

		wait(0.1);
		var_02 moveto(var_0A,0.1);
		wait(0.2);
		var_0B = var_0B + 0.3;
	}

	foreach(var_08 in var_02.var_127C9)
	{
		var_02 thread func_A631(var_08,param_01,param_00);
	}

	var_02 thread buffer_move();
	wait(16);
	var_02 notify("stop_buffer");
	var_02 rotateyaw(30,1,0,0);
	var_02 rotateyaw(-30,1,0,1);
	stopfxontag(level._effect["buffer_smoke"],var_02,"tag_origin");
	var_02 moveto(var_02.origin + anglestoforward(var_02.var_A912.angles) * 2,0.25,0,0.25);
	var_02 playsoundonmovingent("trap_buffer_stop");
	wait(1);
	var_02 stoploopsound("trap_buffer_spin_lp");
	wait(1);
	var_02 method_83AD();
	var_02.var_A912 = undefined;
	var_02.last_yaw = undefined;
	level notify("buffer_trap_kills",param_00.var_126A4);
	param_00.origin = var_02.origin + anglestoforward(var_02.angles) * param_00.offset_forward + (0,0,param_00.offset_up);
	scripts\cp\_interaction::add_to_current_interaction_list(param_00);
	scripts\cp\_interaction::func_9A0D(param_00,90);
}

//Function Number: 4
buffer_move()
{
	self endon("stop_buffer");
	var_00 = 1;
	var_01 = scripts\common\utility::getstructarray(self.target,"targetname");
	var_02 = squared(192);
	for(;;)
	{
		var_03 = [];
		var_04 = [];
		foreach(var_06 in var_01)
		{
			var_07 = distance2dsquared(var_06.origin,self.origin);
			if(var_07 > var_02)
			{
				if(isdefined(self.var_A912) && var_06.angles == self.var_A912.angles)
				{
					continue;
				}

				var_04[var_03.size] = var_07;
				var_03[var_03.size] = var_06;
			}
		}

		var_09 = randomintrange(0,var_03.size - 1);
		if(!isdefined(var_09))
		{
			break;
		}

		var_0A = undefined;
		if(!isdefined(self.var_A912))
		{
			var_0B = var_03[var_09];
			var_0A = sqrt(var_04[var_09]) / 180;
			self moveto(var_0B.origin,var_0A,1,0);
		}
		else
		{
			var_0B = var_03[var_09];
			var_0A = sqrt(var_04[var_09]) / 180;
			self playsoundonmovingent("trap_buffer_bump_edge");
			self moveto(var_0B.origin,var_0A,0,0);
			self rotateyaw(randomintrange(500,1080) * var_00,var_0A,randomfloatrange(0,var_0A * 0.5),0);
			var_00 = var_00 * -1;
		}

		wait(var_0A);
		self.var_A912 = var_0B;
	}
}

//Function Number: 5
buffer_trap_sfx()
{
	self endon("stop_buffer");
	self playsoundonmovingent("trap_buffer_startup");
	wait(3.1);
	self playloopsound("trap_buffer_spin_lp");
}

//Function Number: 6
func_A631(param_00,param_01,param_02)
{
	self endon("stop_buffer");
	for(;;)
	{
		param_00 waittill("trigger",var_03);
		if(isplayer(var_03) && !scripts\cp\_laststand::player_in_laststand(var_03))
		{
			if(scripts\common\utility::istrue(var_03.flung))
			{
				continue;
			}

			var_03.flung = 1;
			var_03 thread throwandkillplayer();
			continue;
		}

		if(isdefined(var_03.flung))
		{
			continue;
		}

		if(isdefined(var_03.agent_type) && var_03.agent_type == "slasher")
		{
			continue;
		}

		var_03.flung = 1;
		param_02.var_126A4++;
		level thread func_6F32(var_03,self,param_01);
	}
}

//Function Number: 7
throwandkillplayer()
{
	self endon("disconnect");
	self endon("last_stand");
	self dodamage(35,self.origin);
	self setvelocity((randomintrange(220,250),randomintrange(220,250),0));
	wait(0.5);
	self.flung = undefined;
}

//Function Number: 8
func_6F32(param_00,param_01,param_02)
{
	param_00 endon("death");
	param_00.do_immediate_ragdoll = 1;
	param_00.var_4C87 = 1;
	param_00.disable_armor = 1;
	param_00.nocorpse = 1;
	param_00.full_gib = 1;
	var_03 = ["kill_trap_generic","trap_kill_buffer"];
	if(param_02 scripts\cp\_utility::is_valid_player())
	{
		var_04 = param_02;
		var_04 thread scripts\cp\_vo::try_to_play_vo(scripts\common\utility::random(var_03),"zmb_comment_vo","highest",10,0,0,1,25);
	}
	else
	{
		var_04 = undefined;
	}

	param_00 dodamage(param_00.health + 1000,param_00.origin,var_04,var_04,"MOD_UNKNOWN","iw7_buffertrap_zm");
}

//Function Number: 9
init_hydrant_trap()
{
	level._effect["trap_hydrant_spray"] = loadfx("vfx/iw7/levels/cp_disco/vfx_trap_hydrant_spray.vfx");
	level._effect["trap_hydrant_spray2"] = loadfx("vfx/iw7/levels/cp_disco/vfx_trap_hydrant_spray_2.vfx");
	level._effect["trap_hydrant_pool"] = loadfx("vfx/iw7/levels/cp_disco/vfx_trap_hydrant_pool.vfx");
}

//Function Number: 10
use_hydrant_trap(param_00,param_01)
{
	var_02 = getent(param_00.target,"targetname");
	var_03 = [];
	foreach(var_05 in scripts\common\utility::getstructarray(param_00.target,"targetname"))
	{
		var_05.pool_spot = scripts\common\utility::getstruct(var_05.target,"targetname");
		foreach(var_07 in getentarray(var_05.target,"targetname"))
		{
			if(issubstr(var_07.classname,"phys"))
			{
				var_05.physvolume = var_07;
				continue;
			}

			if(issubstr(var_07.classname,"trigger"))
			{
				var_05.trigger = var_07;
			}
		}

		var_05.player = param_01;
		var_05.var_9A09 = param_00;
		var_05.valve = var_02;
		var_03[var_03.size] = var_05;
	}

	param_01 thread scripts\cp\_vo::try_to_play_vo("activate_trap_generic","zmb_comment_vo","low",10,0,1,0,40);
	param_00.var_126A4 = 0;
	param_01 playlocalsound("purchase_generic");
	scripts\cp\_interaction::func_554F(param_00);
	wait(0.5);
	var_02 rotateyaw(360,1);
	playsoundatpos(var_02.origin,"trap_hydrant_valve");
	wait(0.5);
	playrumbleonposition("light_3s",var_02.origin);
	earthquake(0.2,2,var_02.origin,500);
	wait(0.5);
	scripts\common\utility::array_thread(var_03,::shoot_water);
	wait(15);
	level notify("hydrant_trap_kills",param_00.var_126A4);
	var_02 notify("stop_hydrant_trap");
	playsoundatpos(var_02.origin,"trap_hydrant_valve");
	scripts\cp\_interaction::add_to_current_interaction_list(param_00);
	scripts\cp\_interaction::func_9A0D(param_00,90);
}

//Function Number: 11
shoot_water()
{
	if(isdefined(self.script_noteworthy) && self.script_noteworthy == "2")
	{
		playfx(scripts\common\utility::getfx("trap_hydrant_spray2"),self.origin,anglestoforward(self.angles),anglestoup(self.angles));
	}
	else
	{
		playfx(scripts\common\utility::getfx("trap_hydrant_spray"),self.origin,anglestoforward(self.angles),anglestoup(self.angles));
	}

	playsoundatpos(self.origin,"trap_hydrant_spray");
	var_00 = anglestoforward(self.angles);
	self.physvolume method_852B(1,var_00,5000);
	self.physvolume method_8529(1);
	self.physvolume method_8526(1);
	thread kill_zombies_hydrant(var_00);
	self.valve waittill("stop_hydrant_trap");
	self.physvolume method_8526(0);
	self.physvolume method_8529(0);
}

//Function Number: 12
kill_zombies_hydrant(param_00)
{
	self.valve endon("stop_hydrant_trap");
	for(;;)
	{
		self.trigger waittill("trigger",var_01);
		if(isplayer(var_01))
		{
			var_02 = var_01 getvelocity();
			var_01 setvelocity(var_02 + param_00 * 35);
			continue;
		}

		if(!scripts\cp\_utility::func_FF18(var_01,undefined,1))
		{
			continue;
		}

		self.var_9A09.var_126A4++;
		var_01 thread fling_zombie_hydrant(self.var_9A09,self.player);
	}
}

//Function Number: 13
fling_zombie_hydrant(param_00,param_01)
{
	self endon("death");
	self.flung = 1;
	self.var_B36E = 1;
	self.do_immediate_ragdoll = 1;
	self.var_4C87 = 1;
	self.disable_armor = 1;
	wait(randomfloatrange(0.5,1.5));
	if(param_01 scripts\cp\_utility::is_valid_player())
	{
		var_02 = param_01;
		var_03 = ["kill_trap_generic","trap_kill_firehydrant"];
		var_02 thread scripts\cp\_vo::try_to_play_vo(scripts\common\utility::random(var_03),"zmb_comment_vo","high",10,0,0,1,25);
	}
	else
	{
		var_02 = undefined;
	}

	self dodamage(self.health + 100,self.origin,var_02,var_02,"MOD_UNKNOWN","iw7_hydranttrap_zm");
}

//Function Number: 14
init_mosh_trap()
{
	scripts\common\utility::flag_init("flag_moshing_allowed");
	scripts\common\utility::array_thread(scripts\common\utility::getstructarray("trap_mosh","script_noteworthy"),::power_on_mosh);
}

//Function Number: 15
power_on_mosh()
{
	level.punk_rockspots = [];
	level.punk_speakers = [];
	self.aoe = undefined;
	foreach(var_01 in scripts\common\utility::getstructarray(self.target,"targetname"))
	{
		if(var_01.script_area == "rockout")
		{
			level.punk_rockspots[level.punk_rockspots.size] = var_01;
			continue;
		}

		if(var_01.script_area == "radius")
		{
			self.aoe = var_01;
			continue;
		}

		if(var_01.script_area == "speaker")
		{
			level.punk_speakers[level.punk_speakers.size] = var_01;
		}
	}

	self.aoe_trigger = spawn("trigger_radius",self.aoe.origin + (0,0,16),0,600,64);
	self.var_D776 = 1;
}

//Function Number: 16
use_mosh_trap(param_00,param_01)
{
	scripts\common\utility::func_6E2A("flag_moshing_allowed");
	param_00.var_126A4 = 0;
	param_01 playlocalsound("purchase_generic");
	scripts\cp\_interaction::remove_from_current_interaction_list(param_00);
	param_01 thread scripts\cp\_vo::try_to_play_vo("activate_trap_generic","zmb_comment_vo","low",10,0,1,0,40);
	level.punk_rockers = [];
	level.punk_moshers = [];
	wait(0.5);
	level thread scripts\cp\maps\cp_disco\cp_disco::start_mosh_trap_music();
	level thread mosh_trap_trigger(param_00,param_01);
	wait(1.1);
	scripts\common\utility::exploder(50);
	wait(28);
	level notify("stop_mosh_trap");
	level notify("mosh_trap_kills",param_00.var_126A4);
	kill_mosh_stragglers(param_01);
	scripts\cp\_interaction::add_to_current_interaction_list(param_00);
	scripts\cp\_interaction::func_9A0D(param_00,90);
}

//Function Number: 17
mosh_trap_trigger(param_00,param_01)
{
	level endon("stop_mosh_trap");
	for(;;)
	{
		param_00.aoe_trigger waittill("trigger",var_02);
		if(var_02 scripts\cp\_utility::is_valid_player())
		{
			continue;
		}

		if(scripts\common\utility::istrue(var_02.var_9CEF) || scripts\common\utility::istrue(var_02.mosh_trap) || scripts\common\utility::istrue(var_02.var_9CEC))
		{
			continue;
		}

		if(scripts\common\utility::istrue(var_02.is_skeleton))
		{
			continue;
		}

		if(!scripts\cp\_utility::func_FF18(var_02) || var_02.var_152C || var_02.var_EF64)
		{
			continue;
		}

		if(var_02.agent_type == "ratking" || var_02.agent_type == "karatemaster" || var_02.agent_type == "cop_dlc2" || var_02.agent_type == "skater")
		{
			continue;
		}

		var_02 thread func_DF45(param_01);
		var_02 thread rockmode(param_00,param_01);
	}
}

//Function Number: 18
clean_array(param_00)
{
	var_01 = [];
	foreach(var_03 in param_00)
	{
		if(isdefined(var_03) && isalive(var_03))
		{
			var_01[var_01.size] = var_03;
		}
	}

	return var_01;
}

//Function Number: 19
rockmode(param_00,param_01)
{
	level endon("stop_mosh_trap");
	self endon("death");
	self.mosh_trap = 1;
	self.og_movemode = self.var_1F5;
	self.var_1F5 = "sprint";
	self.goalradius_old = self.var_15C;
	self.is_rocking = 1;
	self.var_152C = 1;
	self.var_EF64 = 1;
	self method_8287(32);
	var_02 = get_rock_spot(param_00);
	thread release_rockspot_on_death();
	self.var_5273 = (0,var_02.angles[1],0);
	self.var_180 = 1;
	self method_8286(var_02.origin);
	scripts\common\utility::waittill_any_3("goal","goal_reached");
	self notify("rockmode");
	self.do_immediate_ragdoll = 1;
	self.var_9BB0 = 1;
	level.punk_rockers[level.punk_rockers.size] = self;
}

//Function Number: 20
moshdeath(param_00,param_01)
{
	if(scripts\common\utility::istrue(param_01))
	{
		self.electrocuted = 1;
		self.dontmutilate = 1;
		self playsound("trap_electric_shock");
	}

	var_02 = ["kill_trap_generic","trap_kill_moshpit"];
	if(param_00 scripts\cp\_utility::is_valid_player())
	{
		var_03 = param_00;
		var_03 thread scripts\cp\_vo::try_to_play_vo(scripts\common\utility::random(var_02),"zmb_comment_vo","high",10,0,0,1,25);
	}
	else
	{
		var_03 = undefined;
	}

	if(scripts\common\utility::istrue(self.is_moshing))
	{
		self.team = "axis";
	}

	self setscriptablepartstate("eyes","yellow_eyes");
	self dodamage(self.health + 1000,self.origin,var_03,var_03,"MOD_UNKNOWN","iw7_moshtrap_zm");
}

//Function Number: 21
get_rock_spot(param_00)
{
	if(isdefined(self.rockspot))
	{
		self.rockspot.var_222 = undefined;
		self.rockspot = undefined;
	}

	var_01 = sortbydistance(level.punk_rockspots,param_00.origin);
	foreach(var_03 in var_01)
	{
		if(!isdefined(var_03.var_222))
		{
			var_03.var_222 = self;
			self.rockspot = var_03;
			return var_03;
		}
	}

	return scripts\common\utility::random(var_01);
}

//Function Number: 22
get_mosh_spot(param_00)
{
	var_01 = sortbydistance(level.punk_rockspots,param_00.origin);
	return var_01[0];
}

//Function Number: 23
kill_mosh_stragglers(param_00)
{
	foreach(var_02 in level.punk_rockers)
	{
		if(!isdefined(var_02) || !isalive(var_02))
		{
			continue;
		}

		var_03 = scripts\common\utility::random(level.punk_speakers);
		var_04 = var_02 gettagorigin("J_HEAD");
		function_02E0(level._effect["blue_ark_beam"],var_03.origin,vectortoangles(var_03.origin - var_04),var_04);
		var_02 moshdeath(param_00,1);
		wait(randomfloatrange(0.1,0.2));
	}
}

//Function Number: 24
func_DF45(param_00)
{
	self endon("death");
	self endon("moshmode");
	self endon("rockmode");
	level waittill("stop_mosh_trap");
	if(isdefined(self.var_C37F))
	{
		self.var_15C = self.var_C37F;
	}

	self method_8287(self.var_15C);
	self.var_C37F = undefined;
	self.var_EF64 = 0;
	if(isdefined(self.og_movemode))
	{
		self.var_1F5 = self.og_movemode;
	}

	self.og_movemode = undefined;
	self.var_180 = 0;
	self.var_152C = 0;
	self.mosh_trap = undefined;
	self.is_rocking = undefined;
	self.do_immediate_ragdoll = 0;
	if(isdefined(self.rockspot))
	{
		self.rockspot.var_222 = undefined;
	}

	self.rockspot = undefined;
}

//Function Number: 25
release_rockspot_on_death()
{
	self waittill("death");
	if(isdefined(self.rockspot))
	{
		self.rockspot.var_222 = undefined;
	}
}