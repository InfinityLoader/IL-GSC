/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\cp\zombies\interaction_woodchipper_trap.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 8
 * Decompile Time: 427 ms
 * Timestamp: 10/27/2023 12:09:05 AM
*******************************************************************/

//Function Number: 1
init_woodchipper_trap()
{
	level.blackholetrapuses = 0;
	var_00 = scripts\common\utility::getstructarray("interaction_woodchipper","script_noteworthy");
	foreach(var_02 in var_00)
	{
		var_02 thread woodchipper_trap_wait_for_power();
		var_03 = scripts\common\utility::getstructarray(var_02.target,"targetname");
		foreach(var_05 in var_03)
		{
			if(isdefined(var_05.var_257))
			{
				var_02.suction_spot = var_05;
			}

			if(var_05.script_noteworthy == "zombie_in_fx")
			{
				var_02.zombie_in_fx = var_05;
			}

			if(var_05.script_noteworthy == "zombie_out_fx")
			{
				var_02.zombie_out_fx = var_05;
			}
		}

		var_07 = getentarray(var_02.target,"targetname");
		foreach(var_09 in var_07)
		{
			if(var_09.classname == "light_spot")
			{
				var_02.var_1B9 = var_09;
			}
		}

		var_02.woodchipper_trigger = spawn("trigger_radius",var_02.suction_spot.origin,0,var_02.suction_spot.var_257,96);
		var_02.var_1B9 setlightintensity(0);
	}
}

//Function Number: 2
woodchipper_trap_wait_for_power()
{
	var_00 = scripts\common\utility::istrue(self.var_E1B9) && isdefined(self.var_D71C);
	for(;;)
	{
		var_01 = "power_on";
		if(var_00)
		{
			var_01 = level scripts\common\utility::waittill_any_return_no_endon_death_3("power_on",self.var_D71C + " power_on","power_off");
			if(var_01 != "power_off")
			{
				self.var_D776 = 1;
			}
			else
			{
				self.var_D776 = 0;
			}
		}

		if(!var_00)
		{
			break;
		}

		wait(0.25);
	}
}

//Function Number: 3
use_woodchipper_trap(param_00,param_01)
{
	param_01 thread scripts\cp\_vo::try_to_play_vo("activate_trap_generic","zmb_comment_vo","low",10,0,1,0,40);
	scripts\cp\_interaction::func_554F(param_00);
	param_00.var_1B9 setlightintensity(80);
	param_00.var_19 = 1;
	param_00.var_126A4 = 0;
	var_02 = gettime() + 20000;
	param_00 thread func_A631(param_01);
	earthquake(0.21,int(21),param_00.origin,500);
	playsoundatpos(param_00.origin,"trap_wood_chipper_start");
	var_03 = thread scripts\common\utility::play_loopsound_in_space("trap_wood_chipper_lp",param_00.origin);
	while(gettime() < var_02)
	{
		wait(1);
	}

	playsoundatpos(param_00.origin,"trap_wood_chipper_end");
	var_03 stoploopsound();
	var_03 delete();
	param_00.var_1B9 setlightintensity(0);
	param_00 notify("stop_dmg");
	param_00.var_19 = undefined;
	level notify("woodchipper_trap_kills",param_00.var_126A4);
	if(param_01 scripts\cp\_utility::is_valid_player())
	{
		param_01.var_1189F = param_00.var_126A4;
		scripts\cp\zombies\arcade_game_utility::update_player_tickets_earned(param_01);
	}

	wait(3);
	scripts\cp\_interaction::func_6214(param_00);
	scripts\cp\_interaction::func_9A0D(param_00,max(level.blackholetrapuses * 45,45));
}

//Function Number: 4
func_2B35(param_00,param_01)
{
	playsoundatpos(param_01,"trap_blackhole_ride_start");
	wait(2);
	var_02 = scripts\common\utility::play_loopsound_in_space("trap_blackhole_ride_loop",param_01);
	wait(0.8);
	playsoundatpos((-3321,802,888),"trap_blackhole_energy_start");
	wait(0.6);
	var_03 = scripts\common\utility::play_loopsound_in_space("trap_blackhole_energy_close_lp",(-3321,802,888));
	wait(0.1);
	var_04 = scripts\common\utility::play_loopsound_in_space("trap_blackhole_trap_suction_lp",(-3013,833,511));
	wait(param_00 - 8.5);
	playsoundatpos(param_01,"trap_blackhole_ride_stop");
	wait(1);
	var_02 stoploopsound();
	wait(3.5);
	playsoundatpos((-3321,802,888),"trap_blackhole_energy_end");
	var_03 stoploopsound();
	var_04 stoploopsound();
	var_02 delete();
	var_03 delete();
	var_04 delete();
}

//Function Number: 5
func_A631(param_00)
{
	self endon("stop_dmg");
	wait(2);
	for(;;)
	{
		self.woodchipper_trigger waittill("trigger",var_01);
		if(!scripts\cp\_utility::func_FF18(var_01) || isdefined(var_01.flung))
		{
			continue;
		}

		var_01.flung = 1;
		var_01 thread func_111B0(param_00,self);
		level thread lib_0D62::func_CE9C(var_01,"death_blackhole",0);
	}
}

//Function Number: 6
func_111B0(param_00,param_01)
{
	self endon("death");
	var_02 = param_01.zombie_in_fx;
	var_03 = param_01.suction_spot;
	self.var_EF64 = 1;
	wait(randomfloatrange(0,1));
	var_04 = 4096;
	while(distancesquared(self.origin,var_03.origin) > var_04)
	{
		self setvelocity(vectornormalize(var_03.origin - self.origin) * 150 + (0,0,30));
		wait(0.05);
	}

	if(!isdefined(param_01.var_19))
	{
		self.var_EF64 = 0;
		self.flung = undefined;
		return;
	}

	var_05 = 2304;
	self.nocorpse = 1;
	self.var_180 = 1;
	self.anchor = spawn("script_origin",self.origin);
	self.anchor.angles = self.angles;
	self linkto(self.anchor);
	self.anchor rotateto((-90,0,0),0.2);
	self.anchor moveto(var_02.origin,0.5);
	wait(0.5);
	playfx(level._effect["woodchipper_entry"],self.origin,anglestoforward((0,0,0)),anglestoup((0,0,0)));
	self.anchor delete();
	self.disable_armor = 1;
	param_01.var_126A4 = param_01.var_126A4 + 1;
	thread woodchipper_spray(param_01);
	if(param_01.var_126A4 == 1)
	{
		scripts\common\utility::exploder(11);
	}

	thread woodchipper_grind_sfx(param_01);
	if(isdefined(param_00))
	{
		var_06 = ["kill_trap_generic","kill_trap_1","kill_trap_2","kill_trap_3","kill_trap_4","kill_trap_5","kill_trap_6","trap_kill_7"];
		param_00 thread scripts\cp\_vo::try_to_play_vo(scripts\common\utility::random(var_06),"zmb_comment_vo","highest",10,0,0,1,25);
		self dodamage(self.health + 100,var_02.origin,param_00,param_00,"MOD_UNKNOWN","iw7_chromosphere_zm");
		return;
	}

	self dodamage(self.health + 100,var_02.origin,undefined,undefined,"MOD_UNKNOWN","iw7_chromosphere_zm");
}

//Function Number: 7
woodchipper_grind_sfx(param_00)
{
	if(!isdefined(param_00.grind_sfx))
	{
		param_00.grind_sfx = 0;
	}

	if(param_00.grind_sfx == 0)
	{
		param_00.grind_sfx = 1;
		playsoundatpos(param_00.origin,"trap_wood_chipper_grind");
		wait(2.2);
		param_00.grind_sfx = 0;
	}
}

//Function Number: 8
woodchipper_spray(param_00)
{
	self waittill("death");
	wait(0.5);
	playfx(level._effect["woodchipper_spray"],param_00.zombie_out_fx.origin,anglestoforward(param_00.zombie_out_fx.angles),anglestoup(param_00.zombie_out_fx.angles));
}