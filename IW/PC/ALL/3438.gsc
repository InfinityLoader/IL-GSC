/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3438.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 17
 * Decompile Time: 10 ms
 * Timestamp: 10/27/2023 12:27:28 AM
*******************************************************************/

//Function Number: 1
func_97D0()
{
	level._effect["swipe_trail"] = loadfx("vfx/iw7/_requests/mp/vfx_swipe_trail");
	level.var_DDA0 = "prop_mp_reaper_shield";
}

//Function Number: 2
func_20BB()
{
	self method_845A("reaper_mp");
	func_6692();
	self disableweaponpickup();
	self.var_9F1B = 0;
	self.var_C4DA = 0;
	self.var_B62A = spawn("script_model",self.origin);
	self.var_B62A setmodel("tag_origin");
	self.var_FC9F = spawn("script_model",self.origin);
	self.var_FC9F setmodel(level.var_DDA0);
	self.var_FC9F setcandamage(0);
	self.var_FC9F hide();
	thread func_13ACC();
	self method_845E(1);
}

//Function Number: 3
func_E0D0()
{
	self notify("removeReaper");
	self enableweaponpickup();
	self.var_FC9F delete();
	self.var_B62A delete();
}

//Function Number: 4
func_6692()
{
}

//Function Number: 5
func_4FB9(param_00,param_01)
{
	self endon("disconnect");
	self endon("death");
	self endon("removeReaper");
	self endon("shield_down");
	level endon("game_ended");
	while(self.var_4BFD > param_00)
	{
		self.var_4BFD = self.var_4BFD - param_00;
		wait(param_01);
	}

	self.var_C4DA = 1;
	self notify("drop_shield");
}

//Function Number: 6
func_93EE(param_00,param_01,param_02)
{
	self endon("disconnect");
	self endon("death");
	self endon("removeReaper");
	self endon("shield_up");
	level endon("game_ended");
	while(self.var_4BFD < param_02)
	{
		self.var_4BFD = self.var_4BFD + param_00;
		if(self.var_4BFD > 33)
		{
			self.var_C4DA = 0;
		}

		wait(param_01);
	}
}

//Function Number: 7
func_13994()
{
	self endon("disconnect");
	self endon("death");
	self endon("removeReaper");
	level endon("game_ended");
	var_00 = 3;
	var_01 = 100;
	var_02 = var_01 / var_00;
	self.var_4BFD = var_01;
	var_03 = 0.1;
	var_04 = var_02 * var_03;
	self.var_FCA5 = 0;
	thread func_5D58();
	thread func_5D57(var_04,var_03,var_01);
	for(;;)
	{
		if(self.var_9F1B)
		{
			wait(0.05);
			continue;
		}

		if(self adsbuttonpressed() && !self.var_FCA5 && !self.var_C4DA)
		{
			func_FCA5(var_04,var_03);
		}
		else if(!self adsbuttonpressed() && self.var_FCA5)
		{
			func_FC98(var_04,var_03,var_01);
		}

		wait(0.05);
	}
}

//Function Number: 8
func_5D57(param_00,param_01,param_02)
{
	self endon("disconnect");
	self endon("death");
	self endon("removeReaper");
	level endon("game_ended");
	for(;;)
	{
		self waittill("drop_shield");
		func_FC98(param_00,param_01,param_02);
	}
}

//Function Number: 9
func_FCA5(param_00,param_01)
{
	thread func_4FB9(param_00,param_01);
	self.var_FCA5 = 1;
	self notify("shield_up");
	self.var_FC9F.angles = self.angles + (0,90,0);
	self.var_FC9F.origin = func_36DB(32);
	self playlocalsound("reaper_shield_up");
	self.var_FC9F playsound("reaper_shield_up_npc");
	self.var_FC9F show();
	self.var_FC9F setcandamage(1);
	thread func_BCEE();
	thread func_FC9C();
	self method_80AA();
	self allowjump(0);
	self allowprone(0);
	scripts\mp\_utility::func_1309("iw7_erad_mp",self.origin + (0,0,4500),self.origin + (0,0,5500),self);
}

//Function Number: 10
func_FC98(param_00,param_01,param_02)
{
	thread func_93EE(param_00,param_01,param_02);
	self playlocalsound("reaper_shield_down");
	self.var_FC9F playsound("reaper_shield_down_npc");
	self notify("shield_down");
	self.var_FCA5 = 0;
	self enableweapons();
	self allowjump(1);
	self allowprone(1);
	self.var_FC9F hide();
	self.var_FC9F setcandamage(0);
}

//Function Number: 11
func_5D58()
{
	level endon("game_ended");
	var_00 = scripts\common\utility::waittill_any_return_no_endon_death_3("death","disconnect");
	if(var_00 == "death")
	{
		self enableweapons();
		self allowjump(1);
		self allowprone(1);
		self notify("shield_down");
		if(isdefined(self.var_FC9F))
		{
			self.var_FC9F hide();
			self.var_FC9F setcandamage(0);
		}
	}

	if(var_00 == "disconnect" && isdefined(self.var_FC9F))
	{
		self.var_FC9F hide();
		self.var_FC9F setcandamage(0);
	}
}

//Function Number: 12
func_FC9C()
{
	self endon("death");
	self endon("disconnect");
	self endon("removeReaper");
	self endon("shield_down");
	level endon("game_ended");
	for(;;)
	{
		self waittill("damage",var_00,var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09);
		if(isdefined(var_03))
		{
			playsoundatpos(var_03,"bs_shield_impact");
		}
		else
		{
			playsoundatpos(self.var_FC9F.origin,"bs_shield_impact");
		}

		var_01 scripts\mp\_damagefeedback::func_12E84("hitbulletstorm");
		wait(0.05);
	}
}

//Function Number: 13
func_BCEE(param_00)
{
	self endon("death");
	self endon("disconnect");
	self endon("removeReaper");
	self endon("shield_down");
	level endon("game_ended");
	if(isdefined(param_00))
	{
		var_01 = param_00;
	}
	else
	{
		var_01 = 32;
	}

	for(;;)
	{
		self.var_FC9F.angles = self.angles + (0,90,0);
		self.var_FC9F.origin = func_36DB(var_01);
		wait(0.05);
	}
}

//Function Number: 14
func_36DB(param_00)
{
	var_01 = (0,0,0);
	var_02 = self.origin + var_01;
	var_03 = anglestoforward(self.angles);
	var_04 = anglestoright(self.angles);
	var_05 = self getvelocity();
	var_06 = vectordot(var_05,self.angles);
	var_07 = length(var_05);
	if(var_07 < 64)
	{
		var_07 = 64;
	}

	if(var_07 > 64 && var_07 < 128)
	{
		var_07 = 92;
	}

	if(var_07 > 350)
	{
		var_07 = 500;
	}

	if(var_07 > 200)
	{
		var_07 = 256;
	}

	if(var_07 > 128)
	{
		var_07 = 164;
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

//Function Number: 15
func_13ACC(param_00)
{
	self endon("death");
	self endon("disconnect");
	self endon("removeReaper");
	level endon("game_ended");
	var_01 = (0,0,32);
	for(;;)
	{
		self waittill("melee_fired");
		var_02 = self.origin + var_01;
		var_03 = anglestoforward(self.angles);
		var_04 = anglestoright(self.angles);
		scripts\mp\_utility::func_1309("iw7_erad_mp",self.origin + (0,0,4500),self.origin + (0,0,5500),self);
		self playrumbleonentity("damage_light");
		earthquake(0.2,0.1,self.origin,32);
		var_05 = func_36DB(param_00);
		var_05 = var_05 + var_01;
		var_06 = var_02 + var_04 * 64;
		var_07 = var_02 - var_04 * 32;
		var_08 = rotatevector(var_04,(0,45,0));
		var_09 = var_02 + var_08 * 64;
		var_0A = rotatevector(var_04,(0,135,0));
		var_0B = var_02 + var_0A * 32;
		var_0C = gettime();
		self.var_B62A.origin = var_06;
		wait(0.05);
		playfxontag(level._effect["swipe_trail"],self.var_B62A,"tag_origin");
		wait(0.05);
		self.var_B62A.origin = var_09;
		wait(0.05);
		self.var_B62A.origin = var_05;
		thread func_20D9(var_05);
		wait(0.05);
		self.var_B62A.origin = var_0B;
		wait(0.05);
		self.var_B62A.origin = var_07;
		wait(0.05);
		stopfxontag(level._effect["swipe_trail"],self.var_B62A,"tag_origin");
	}
}

//Function Number: 16
func_20D9(param_00)
{
	self endon("death");
	self endon("disconnect");
	self endon("removeReaper");
	level endon("game_ended");
	var_01 = distance2d(self.origin,param_00) / 2;
	self radiusdamage(self.origin,var_01,135,135,self,"MOD_MELEE","iw7_reaperblade_mp");
}

//Function Number: 17
func_11A83(param_00,param_01,param_02)
{
	self endon("death");
	self endon("disconnect");
	self endon("removeReaper");
	level endon("game_ended");
	var_03 = self.origin + (0,0,32);
	var_04 = undefined;
	var_05 = undefined;
	var_06 = undefined;
	var_07 = undefined;
	var_08 = 0;
	var_09 = gettime();
	var_0A = param_02;
	var_04 = scripts\common\trace::func_DCED(var_03,param_00,var_0A);
	if(isdefined(var_04["entity"]))
	{
		var_08 = 1;
		var_06 = var_04["entity"];
		var_0A[var_0A.size] = var_06;
	}

	if(isdefined(param_01))
	{
		var_05 = scripts\common\trace::func_DCED(param_00,param_01,var_0A);
		if(isdefined(var_05) && isdefined(var_05["entity"]))
		{
			var_08 = 1;
			var_07 = var_04["entity"];
			var_0A[var_0A.size] = var_07;
		}
	}

	if(isdefined(var_06))
	{
		if(isdefined(var_06.var_904B) && var_06.var_904B == var_09)
		{
			return var_0A;
		}

		if(!scripts\mp\_utility::func_24F0(var_06,self) && var_06 != self)
		{
			var_06 thread [[ level.callbackplayerdamage ]](undefined,self,135,0,"MOD_MELEE","iw7_reaperblade_mp",self.origin,undefined,"none",0);
		}
	}

	if(isdefined(var_07))
	{
		if(isdefined(var_07.var_904B) && var_07.var_904B == var_09)
		{
			return var_0A;
		}

		if(!scripts\mp\_utility::func_24F0(var_07,self) && var_07 != self)
		{
			var_07 thread [[ level.callbackplayerdamage ]](undefined,self,135,0,"MOD_MELEE","iw7_reaperblade_mp",self.origin,undefined,"none",0);
		}
	}

	return var_0A;
}