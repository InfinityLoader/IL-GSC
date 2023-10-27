/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3431.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 17
 * Decompile Time: 4 ms
 * Timestamp: 10/27/2023 12:27:26 AM
*******************************************************************/

//Function Number: 1
func_20BB()
{
}

//Function Number: 2
func_97D0()
{
	level._effect["atomize_body"] = loadfx("vfx/iw7/_requests/mp/vfx_atomize_body.vfx");
}

//Function Number: 3
func_E0D0()
{
	self notify("removeArchetype");
	self setclientomnvar("ui_dodge_charges",0);
	if(isdefined(self.var_1166A))
	{
		self.var_1166A delete();
	}
}

//Function Number: 4
func_CAAF()
{
	self endon("death");
	self endon("removeArchetype");
	for(;;)
	{
		self setclientomnvar("ui_dodge_charges",4);
		self waittill("sprint_slide_begin");
		if(lib_0DF8::func_9DDF(self))
		{
			continue;
		}

		wait(0.1);
		self setclientomnvar("ui_dodge_charges",0);
		lib_0DF8::func_6626(0);
		func_CAAE();
		wait(4);
		self setclientomnvar("ui_dodge_charges",4);
	}
}

//Function Number: 5
func_CAAE()
{
	self endon("death");
	self endon("removeArchetype");
	self endon("phase_shift_power_activated");
	scripts\common\utility::waittill_notify_or_timeout("sprint_slide_end",1);
	lib_0DF8::func_6978(0);
}

//Function Number: 6
func_1166B()
{
	self endon("death");
	self endon("removeArchetype");
	var_00 = spawn("script_model",self.origin);
	var_00 setmodel("ks_marker_mp");
	var_00 rotatepitch(-90,0.05);
	self.var_1166A = var_00;
	for(;;)
	{
		self setclientomnvar("ui_dodge_charges",4);
		self waittill("sprint_slide_begin");
		var_01 = scripts\common\utility::waittill_any_timeout_1(0.1,"sprint_slide_end");
		if(var_01 != "timeout")
		{
			continue;
		}

		if(lib_0DF8::func_9DDF(self))
		{
			continue;
		}

		var_02 = func_81C1(320);
		var_03 = getdvarint("teleport_minDrawDistanceForFX",16);
		if(distance2dsquared(var_02,self.origin) <= var_03 * var_03)
		{
			continue;
		}

		self setclientomnvar("ui_dodge_charges",0);
		var_04 = var_02 - self.origin;
		wait(0.1);
		var_05 = scripts\common\trace::func_48BC(1,1,1,1,0,1,1);
		var_06 = scripts\common\trace::func_D305(var_02,var_02 - (0,0,100),self.angles,self,var_05);
		var_07 = var_06["position"] + (0,0,6);
		var_08 = scripts\common\trace::func_D095(var_07,self.angles,0,self,var_05,0);
		var_09 = var_08["position"];
		var_09 = var_09 + (0,0,12);
		thread func_10148(var_09);
		wait(0.2);
		wait(4);
		self setclientomnvar("ui_dodge_charges",4);
	}
}

//Function Number: 7
func_10148(param_00)
{
	self.var_1166A.origin = param_00;
	self.var_1166A show();
	wait(0.45);
	self.var_1166A hide();
}

//Function Number: 8
func_81C1(param_00)
{
	var_01 = self.origin + (0,0,0);
	var_02 = anglestoforward(self.angles);
	var_03 = var_01 + var_02 * param_00;
	var_04 = scripts\common\trace::func_48BC(1,1,1,1,0,1,1);
	var_05 = scripts\common\trace::func_D305(var_01,var_03,self.angles,self,var_04,0,35);
	var_06 = var_05["fraction"];
	var_07 = var_05["position"];
	if(var_06 != 1)
	{
		var_08 = param_00 * var_06;
		var_08 = var_08 - 32;
		var_07 = var_01 + var_02 * var_08;
	}

	var_09 = getclosestpointonnavmesh3d(var_07);
	if(isdefined(var_09))
	{
		return var_09;
	}

	return var_07;
}

//Function Number: 9
func_CAA7()
{
	self endon("death");
	self endon("removeArchetype");
	for(;;)
	{
		self waittill("doubleJumpBegin");
		if(lib_0DF8::func_9DDF(self))
		{
			continue;
		}

		lib_0DF8::func_6626(0);
		func_CAA6();
	}
}

//Function Number: 10
func_CAA6()
{
	self endon("death");
	self endon("removeArchetype");
	self endon("phase_shift_power_activated");
	var_00 = 0;
	for(;;)
	{
		if(var_00 >= 0.5)
		{
			lib_0DF8::func_6978(0);
			return;
		}

		wait(0.05);
		var_00 = var_00 + 0.05;
	}
}

//Function Number: 11
func_E88E()
{
	self endon("death");
	self endon("disconnect");
	self endon("removeArchetype");
	for(;;)
	{
		self waittill("got_a_kill",var_00,var_01,var_02);
		if(var_02 != "MOD_MELEE")
		{
			continue;
		}

		self notify("phase_slash_entered");
		wait(0.5);
		wait(0.1);
	}
}

//Function Number: 12
func_20D9(param_00,param_01)
{
	self endon("death");
	self endon("disconnect");
	self endon("removeArchetype");
	level endon("game_ended");
	playfx(scripts\common\utility::getfx("phase_slash_spool"),param_01 + (0,0,36));
	playsoundatpos(param_01,"blackhole_grenade_explode_default");
	scripts\mp\_utility::func_1302("phaseSlash_grenade_mp",param_01 + (0,0,36),(0,0,0),1.5);
	wait(1.5);
	playfx(scripts\common\utility::getfx("phase_blast"),param_01);
	playsoundatpos(param_01,"kinetic_pulse_npc");
}

//Function Number: 13
func_CAAD()
{
	self endon("death");
	self endon("removeArchetype");
	self endon("phase_shift_power_activated");
	wait(2.5);
	lib_0DF8::func_6978(0);
}

//Function Number: 14
func_1091C()
{
	self endon("death");
	self endon("disconnect");
	self endon("removeArchetype");
	var_00 = level.players.size - 1;
	for(;;)
	{
		if(level.players.size != var_00)
		{
			foreach(var_02 in level.players)
			{
				if(var_02 == self)
				{
					continue;
				}

				if(var_02.team == self.team)
				{
					continue;
				}

				if(var_02 scripts\mp\_utility::_hasperk("specialty_coldblooded"))
				{
					continue;
				}

				var_02 thread func_BA1A(self);
			}

			var_00 = level.players.size;
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 15
func_BA1A(param_00)
{
	param_00 endon("death");
	param_00 endon("disconnect");
	param_00 endon("removearchetype");
	self endon("end_spawnview");
	for(;;)
	{
		self waittill("spawned_player");
		wait(0.1);
		func_C7A6(param_00);
	}
}

//Function Number: 16
func_C7A6(param_00)
{
	var_01 = scripts\mp\_utility::func_C794(self,"red",param_00,0,1,"level_script");
	if(!isai(param_00))
	{
		param_00 scripts\mp\_utility::func_12E5(5);
	}

	param_00 func_13AA0(var_01,self,6);
}

//Function Number: 17
func_13AA0(param_00,param_01,param_02)
{
	self endon("disconnect");
	level endon("game_ended");
	scripts\common\utility::waittill_any_timeout_no_endon_death_2(param_02,"leave","end_spawnview");
	if(isdefined(param_01))
	{
		scripts\mp\_utility::func_C78F(param_00,param_01);
		if(!isai(param_01))
		{
			param_01 scripts\mp\_utility::func_12E4();
		}
	}
}