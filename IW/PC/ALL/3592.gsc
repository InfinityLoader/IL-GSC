/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3592.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 33
 * Decompile Time: 11 ms
 * Timestamp: 10/27/2023 12:30:50 AM
*******************************************************************/

//Function Number: 1
init()
{
	level._effect["transponder"] = loadfx("vfx/iw7/_requests/mp/vfx_smokewall");
	level._effect["transponder_activate"] = loadfx("vfx/iw7/_requests/mp/vfx_transponder_activate");
	level._effect["direction_indicator_close"] = loadfx("vfx/iw7/_requests/mp/vfx_transponder_direction_indicator_close");
	level._effect["direction_indicator_mid"] = loadfx("vfx/iw7/_requests/mp/vfx_transponder_direction_indicator_mid");
	level._effect["direction_indicator_far"] = loadfx("vfx/iw7/_requests/mp/vfx_transponder_direction_indicator_far");
	self.var_E561 = 0;
	self.var_9F2F = 0;
	self.var_9FB0 = 0;
	scripts\mp\_powerloot::func_DF06("power_transponder",["passive_increased_range","passive_spot_enemies","passive_ripper"]);
}

//Function Number: 2
func_F5D3()
{
}

//Function Number: 3
func_E180()
{
	self notify("remove_transponder");
}

//Function Number: 4
func_1268C(param_00)
{
	if(func_3E5A())
	{
		func_1268E(param_00);
		return;
	}

	thread func_CC21(param_00);
}

//Function Number: 5
func_1268F(param_00)
{
	self.var_9F2F = scripts\mp\_powerloot::func_D779("power_transponder","passive_ripper");
	self.var_9FB0 = scripts\mp\_powerloot::func_D779("power_transponder","passive_spot_enemies");
	func_1268E(param_00);
}

//Function Number: 6
func_1268E(param_00)
{
	self endon("death");
	self endon("disconnect");
	self endon("remove_transponder");
	var_01 = "power_transponder";
	self setclientomnvar("ui_transponder_range_finder",0);
	self setclientomnvar("ui_show_transponder_outofrange",0);
	if(!scripts\mp\_utility::func_9F19(self))
	{
		param_00 delete();
		return;
	}

	param_00 thread scripts\mp\_weapons::func_C4F4();
	thread func_13B90(param_00);
	param_00 method_831F(self);
	param_00.var_1604 = 0;
	scripts\mp\_weapons::func_C5AC(param_00,"power_transponder");
	thread func_12696(param_00);
	param_00 thread func_12690();
	param_00 thread scripts\mp\_weapons::func_3343();
	param_00 thread func_12692();
	param_00 thread scripts\mp\_weapons::func_66B4(1);
	param_00 thread scripts\mp\perks\_perk_equipmentping::func_E84B();
	level thread scripts\mp\_weapons::func_B9CA(self,param_00);
}

//Function Number: 7
func_13B90(param_00)
{
	self endon("death");
	self endon("disconnect");
	self endon("transponder_alt_detonate");
	self endon("transponder_detonated");
	param_00 waittill("activated");
	for(;;)
	{
		self setclientomnvar("ui_show_transponder_outofrange",0);
		self waittillmatch("transponder_mp","detonate");
		var_01 = scripts\mp\_powerloot::func_7FC5("power_transponder",1801);
		if(isdefined(param_00) && param_00.var_1604 && length2d(param_00.origin - self.origin) <= var_01)
		{
			func_1268D(param_00);
			func_12693();
			continue;
		}

		if(isdefined(param_00))
		{
			self setclientomnvar("ui_show_transponder_outofrange",1);
			scripts\common\utility::func_136F7();
		}

		continue;
	}
}

//Function Number: 8
func_12692()
{
	var_00 = self.var_222;
	var_00 waittill("transponder_update");
	var_00 setclientomnvar("ui_transponder_range_finder",0);
}

//Function Number: 9
func_12693()
{
	foreach(var_01 in self.var_CC4D)
	{
		if(isdefined(var_01) && var_01.var_13C2E == "transponder_mp")
		{
			var_01 scripts\mp\_weapons::func_51B5();
			scripts\common\utility::func_22A9(self.var_CC4D,var_01);
		}
	}

	self notify("transponder_update",0);
	waittillframeend;
	self notify("transponder_detonated");
}

//Function Number: 10
func_13B8F(param_00)
{
	self endon("death");
	self endon("disconnect");
	self endon("transponder_detonated");
	param_00 waittill("activated");
	for(;;)
	{
		self waittill("transponder_alt_detonate");
		var_01 = self getcurrentweapon();
		if(var_01 != "transponder_mp")
		{
			if(isdefined(param_00) && param_00.var_1604)
			{
				func_1268D(param_00);
				func_12693();
				continue;
			}

			continue;
		}
	}
}

//Function Number: 11
func_13B8E(param_00)
{
	self endon("death");
	self endon("disconnect");
	self endon("transponder_detonated");
	level endon("game_ended");
	param_00 waittill("activated");
	var_01 = 0;
	for(;;)
	{
		if(self usebuttonpressed())
		{
			var_01 = 0;
			while(self usebuttonpressed())
			{
				var_01 = var_01 + 0.05;
				wait(0.05);
			}

			if(var_01 >= 0.5)
			{
				continue;
			}

			var_01 = 0;
			while(!self usebuttonpressed() && var_01 < 0.5)
			{
				var_01 = var_01 + 0.05;
				wait(0.05);
			}

			if(var_01 >= 0.5)
			{
				continue;
			}

			if(!self.var_CC4D.size)
			{
				return;
			}

			if(self ismantling())
			{
				self cancelmantle();
			}

			if(isdefined(self.var_9FF6))
			{
				lib_0D70::func_639B();
			}

			self notify("transponder_alt_detonate");
		}

		wait(0.05);
	}
}

//Function Number: 12
func_12690()
{
	self waittill("missile_stuck",var_00);
	wait(0.05);
	if(!func_3E5B())
	{
		self.var_222 func_CC21(self);
		return;
	}

	self.var_222 notify("powers_transponder_used",1);
	self notify("activated");
	self.var_1604 = 1;
	self.var_222 func_5616(self);
	scripts\mp\_weapons::func_B2A5();
	scripts\mp\_weapons::func_69FF(var_00);
}

//Function Number: 13
func_1268D(param_00)
{
	self notify("transponder_teleportPlayer");
	var_01 = undefined;
	var_02 = getclosestpointonnavmesh(param_00.origin);
	var_01 = getclosestnodeinsight(var_02);
	if(isdefined(var_01))
	{
		thread func_161E(self.origin,param_00.origin);
		self playlocalsound("ghost_use_transponder");
		self setorigin(var_01.origin + (0,0,20));
		if(self.var_9FB0)
		{
			thread func_12694();
		}

		if(self.var_9F2F)
		{
			thread func_12691();
			return;
		}

		return;
	}

	iprintlnbold("Transponder lost connection");
	self.var_222 func_12693();
}

//Function Number: 14
func_161E(param_00,param_01)
{
	wait(0.1);
	var_02 = "direction_indicator_far";
	var_03 = length2d(param_00 - param_01);
	if(var_03 < 1024)
	{
		var_02 = "direction_indicator_close";
	}
	else if(var_03 < 2048)
	{
		var_02 = "direction_indicator_mid";
	}

	playfx(scripts\common\utility::getfx(var_02),param_00,(0,0,1),anglestoforward(vectortoangles(param_01 - param_00)));
	playfx(scripts\common\utility::getfx("transponder_activate"),param_01);
}

//Function Number: 15
func_E8AB()
{
	self endon("disconnect");
	scripts\mp\killstreaks\_emp_common::func_20C3();
	self shellshock("flashbang_mp",1.2);
	scripts\common\utility::waittill_any_timeout_1(1.2,"death");
	scripts\mp\killstreaks\_emp_common::func_E0F3();
}

//Function Number: 16
func_12696(param_00)
{
	param_00 endon("death");
	self endon("disconnect");
	thread func_12698(param_00);
	while(isdefined(param_00))
	{
		var_01 = distance2d(self.origin,param_00.origin);
		self setclientomnvar("ui_transponder_range_finder",int(var_01));
		wait(0.1);
	}
}

//Function Number: 17
func_12698(param_00)
{
	param_00 waittill("deleted_equipment");
	self setclientomnvar("ui_transponder_range_finder",0);
}

//Function Number: 18
func_3E5B()
{
	var_00 = getclosestpointonnavmesh(self.origin);
	var_01 = self.var_222 scripts\mp\_powerloot::func_7FC5("power_transponder",256);
	if(distance(self.origin,var_00) > var_01)
	{
		return 0;
	}

	var_02 = getclosestnodeinsight(var_00);
	return isdefined(var_02);
}

//Function Number: 19
func_3E5A()
{
	return !self method_8446() && !self method_81B5() && self isonground();
}

//Function Number: 20
func_CC21(param_00)
{
	self iprintlnbold("TRANSPONDER LOST COMMUNICATION");
	self notify("powers_transponder_used",0);
	self.var_1604 = 0;
	func_12693();
	self.var_CC4D = scripts\common\utility::func_22BC(self.var_CC4D);
	if(isdefined(param_00))
	{
		param_00 delete();
	}
}

//Function Number: 21
func_897B(param_00)
{
	param_00 endon("death");
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	self iprintlnbold("Transponder Hacked!");
	wait(2);
	self notify("transponder_alt_detonate");
}

//Function Number: 22
func_5616(param_00)
{
	scripts\mp\_powers::func_D727("power_transponder");
	thread func_5617(param_00);
}

//Function Number: 23
func_5617(param_00)
{
	self endon("death");
	self endon("disconnect");
	self endon("remove_transponder");
	param_00 waittill("death");
	scripts\mp\_powers::func_D72D("power_transponder");
}

//Function Number: 24
func_12694()
{
	self endon("death");
	self endon("disconnect");
	var_00 = 0;
	var_01 = 0.8;
	var_02 = 0;
	var_03 = 650;
	self.var_E561 = 0;
	foreach(var_05 in level.var_C928)
	{
		if(!scripts\mp\_utility::func_9F19(var_05))
		{
			continue;
		}

		if(!scripts\mp\_utility::func_9DD6(var_05))
		{
			continue;
		}

		if(var_05 scripts\mp\_utility::_hasperk("specialty_noplayertarget") || var_05 scripts\mp\_utility::_hasperk("specialty_noscopeoutline"))
		{
			continue;
		}

		var_06 = var_05.origin - self.origin;
		if(1 && vectordot(anglestoforward(self.angles),var_06) < 0)
		{
			continue;
		}

		var_07 = var_03 * var_03;
		if(length2dsquared(var_06) > var_07)
		{
			continue;
		}

		var_00++;
		thread func_12695(var_05,distance2d(self.origin,var_05.origin) / var_03,var_01);
		var_02 = 1;
	}
}

//Function Number: 25
func_12695(param_00,param_01,param_02)
{
	wait(param_02 * param_01);
	var_03 = scripts\mp\_utility::func_C794(param_00,"orange",self,0,0,"level_script");
	param_00 scripts\mp\_hud_message::func_1013D("spotted");
	var_04 = 3;
	func_13AA0(var_03,param_00,var_04);
}

//Function Number: 26
func_13AA0(param_00,param_01,param_02)
{
	self endon("disconnect");
	level endon("game_ended");
	scripts\common\utility::waittill_any_timeout_no_endon_death_2(param_02,"leave");
	if(isdefined(param_01))
	{
		scripts\mp\_utility::func_C78F(param_00,param_01);
	}
}

//Function Number: 27
func_12691()
{
	level._effect["reaper_fisheye"] = loadfx("vfx/code/screen/vfx_scrnfx_reaper_fisheye");
	self.var_12697 = ["specialty_fastermelee","specialty_extendedmelee","specialty_stun_resistance","specialty_detectexplosive"];
	foreach(var_01 in self.var_12697)
	{
		scripts\mp\_utility::func_8387(var_01);
	}

	var_03 = self.maxhealth;
	self method_845A("reaper_mp");
	self.maxhealth = 170;
	self.health = self.maxhealth;
	level._effect["reaper_swipe_trail"] = loadfx("vfx/iw7/_requests/mp/vfx_swipe_trail");
	self.var_B62A = spawn("script_model",self.origin);
	self.var_B62A setmodel("tag_origin");
	thread func_13ACC();
	thread func_AD77(var_03);
}

//Function Number: 28
func_AD77(param_00)
{
	scripts\common\utility::waittill_any_timeout_1(5,"death");
	thread func_E164(param_00);
}

//Function Number: 29
func_13ACC(param_00)
{
	self endon("death");
	self endon("disconnect");
	self endon("removeRipper");
	level endon("game_ended");
	var_01 = (0,0,4);
	for(;;)
	{
		self waittill("melee_fired");
		var_02 = self.origin + var_01;
		var_03 = anglestoforward(self.angles);
		var_04 = anglestoright(self.angles);
		var_05 = func_36DB(param_00);
		var_05 = var_05 + var_01;
		var_06 = var_02 + var_04 * 64;
		var_07 = var_02 - var_04 * 32;
		var_08 = rotatevector(var_04,(0,45,0));
		var_09 = var_02 + var_08 * 64;
		var_0A = rotatevector(var_04,(0,135,0));
		var_0B = var_02 + var_0A * 32;
		self.var_B62A.origin = var_06;
		wait(0.05);
		playfxontag(level._effect["reaper_swipe_trail"],self.var_B62A,"tag_origin");
		wait(0.075);
		self.var_B62A.origin = var_09;
		wait(0.075);
		self.var_B62A.origin = var_05;
		thread func_20D9(var_05);
		wait(0.075);
		self.var_B62A.origin = var_0B;
		wait(0.075);
		self.var_B62A.origin = var_07;
		wait(0.05);
		stopfxontag(level._effect["reaper_swipe_trail"],self.var_B62A,"tag_origin");
	}
}

//Function Number: 30
func_40B3()
{
	if(isdefined(self.var_C7FF))
	{
		self.var_C7FF delete();
	}
}

//Function Number: 31
func_E164(param_00)
{
	self notify("removeRipper");
	self.var_9F2E = 0;
	self.var_9FB0 = 0;
	self.var_E561 = 0;
	foreach(var_02 in self.var_12697)
	{
		scripts\mp\_utility::func_E150(var_02);
	}

	self.var_12697 = undefined;
	self method_845A("scout_mp");
	self.maxhealth = param_00;
	self setclientomnvar("ui_odin",-1);
	func_40B3();
}

//Function Number: 32
func_20D9(param_00)
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	self endon("removeRipper");
	var_01 = distance2d(self.origin,param_00) / 2;
	self radiusdamage(self.origin + (0,0,36),var_01,250,135,self,"MOD_MELEE","iw7_reaperblade_mp");
}

//Function Number: 33
func_36DB(param_00)
{
	self endon("removeRipper");
	var_01 = (0,0,0);
	var_02 = self.origin + var_01;
	var_03 = anglestoforward(self.angles);
	var_04 = anglestoright(self.angles);
	var_05 = self getvelocity();
	var_06 = vectordot(var_05,self.angles);
	var_07 = length(var_05);
	if(var_07 < 64)
	{
		var_07 = 92;
	}

	if(var_07 > 64 && var_07 < 128)
	{
		var_07 = 128;
	}

	if(var_07 > 350)
	{
		var_07 = 700;
	}

	if(var_07 > 200)
	{
		var_07 = 328;
	}

	if(var_07 > 128)
	{
		var_07 = 256;
	}

	if(var_06 < 1)
	{
		var_07 = 64;
	}

	if(isdefined(param_00))
	{
		var_07 = param_00;
	}

	return var_02 + var_03 * var_07;
}