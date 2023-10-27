/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3606.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 16
 * Decompile Time: 6 ms
 * Timestamp: 10/27/2023 12:30:53 AM
*******************************************************************/

//Function Number: 1
func_98AB()
{
	level.var_C7F2 = [];
}

//Function Number: 2
func_F7CE()
{
	thread func_13A4F();
}

//Function Number: 3
func_12CFF()
{
	self notify("overdriveUnset");
	func_6373(1);
}

//Function Number: 4
func_10DD6()
{
	if(!scripts\mp\_utility::func_9D46())
	{
		self.health = self.maxhealth;
	}

	self motionblurhqenable();
	thread func_13ADF();
	thread func_13AE0();
	thread func_13AE1();
	self setscriptablepartstate("overdrive","activeOn",0);
	level thread scripts\mp\_battlechatter_mp::func_EB87(self,"plr_perk_overdrive",undefined,0.75);
}

//Function Number: 5
func_6373(param_00)
{
	self notify("overdriveEnd");
	self method_8208();
	if(self.var_AE62 == "archetype_assault")
	{
		if(!scripts\mp\_utility::func_9FB3(param_00))
		{
			self setscriptablepartstate("overdrive","activeOff",0);
		}

		self setscriptablepartstate("overdriveMove","neutral",0);
	}
}

//Function Number: 6
func_13A4F()
{
	self endon("disconnect");
	self endon("overdriveUnset");
	self notify("watchForOverdrive");
	self endon("watchForOverdrive");
	for(;;)
	{
		var_00 = spawnstruct();
		childthread func_13A53(var_00);
		childthread func_13A51(var_00);
		childthread func_13A50(var_00);
		childthread func_13A52(var_00);
		childthread watchforoverdriveracegameended(var_00);
		self waittill("overdriveBeginRace");
		waittillframeend;
		if(isdefined(var_00.var_6ACF))
		{
			scripts\mp\_supers::func_DE7D();
		}
		else if(isdefined(var_00.var_10DE6) && isdefined(var_00.var_637B) || isdefined(var_00.var_4E59) || isdefined(var_00.gameendedreceived))
		{
			scripts\mp\_supers::func_DE7D();
		}
		else if(isdefined(var_00.var_4E59))
		{
			func_6373(1);
		}
		else if(isdefined(var_00.var_637B))
		{
			func_6373(0);
		}
		else if(isdefined(var_00.gameendedreceived))
		{
			if(self method_856B())
			{
				self method_85AD();
				func_6373(0);
			}
		}
		else if(isdefined(var_00.var_10DE6))
		{
			func_10DD6();
		}

		self notify("overdriveEndRace");
	}
}

//Function Number: 7
func_13A53(param_00)
{
	self endon("overdriveEndRace");
	self waittill("overdriveStart",var_01,var_02);
	param_00.var_10DE6 = 1;
	param_00.var_2C5 = var_01;
	param_00.var_6378 = var_02;
	self notify("overdriveBeginRace");
}

//Function Number: 8
func_13A51(param_00)
{
	self endon("overdriveEndRace");
	self waittill("overdriveEnd");
	param_00.var_637B = 1;
	self notify("overdriveBeginRace");
}

//Function Number: 9
func_13A50(param_00)
{
	self endon("overdriveEndRace");
	self waittill("death");
	param_00.var_4E59 = 1;
	self notify("overdriveBeginRace");
}

//Function Number: 10
func_13A52(param_00)
{
	self endon("overdriveEndRace");
	self waittill("overdriveFailed");
	param_00.var_6ACF = 1;
	self notify("overdriveBeginRace");
}

//Function Number: 11
watchforoverdriveracegameended(param_00)
{
	self endon("overdriveEndRace");
	level scripts\common\utility::waittill_any_3("bro_shot_start","game_ended");
	param_00.gameendedreceived = 1;
	self notify("overdriveBeginRace");
}

//Function Number: 12
func_13ADF()
{
	self endon("death");
	self endon("disconnect");
	self endon("overdriveEnd");
	waittillframeend;
	while(self method_856B())
	{
		var_00 = scripts\mp\_supers::func_7E4E();
		var_00.var_130EF = self method_856C() * scripts\mp\_supers::func_8188() * 1000;
		scripts\mp\_supers::func_112A5();
		scripts\common\utility::func_136F7();
	}
}

//Function Number: 13
func_13AE1()
{
	var_00 = physics_volumecreate(self.origin,72);
	var_00.time = gettime();
	level.var_C7F2 scripts\common\utility::func_22BC(level.var_C7F2);
	var_01 = undefined;
	var_02 = 0;
	for(var_03 = 0;var_03 < 3;var_03++)
	{
		var_04 = level.var_C7F2[var_03];
		if(!isdefined(var_04))
		{
			var_02 = var_03;
			break;
		}
		else if(!isdefined(var_01) || isdefined(var_01) && var_01.time > var_04.time)
		{
			var_01 = var_04;
			var_02 = var_03;
		}
	}

	if(isdefined(var_01))
	{
		var_01 delete();
	}

	level.var_C7F2[var_02] = var_00;
	var_05 = spawn("script_origin",var_00.origin);
	var_00 linkto(var_05);
	thread func_13AEF(var_00);
	thread func_13AF0(var_05);
	scripts\common\utility::waittill_any_3("death","disconnect","overdriveEnd");
	if(isdefined(var_00))
	{
		var_00 delete();
	}

	var_05 delete();
}

//Function Number: 14
func_13AF0(param_00)
{
	param_00 endon("death");
	self endon("death");
	self endon("disconnect");
	self endon("overdriveEnd");
	for(;;)
	{
		param_00 moveto(self.origin,0.1);
		wait(0.1);
	}
}

//Function Number: 15
func_13AEF(param_00)
{
	param_00 endon("death");
	self endon("death");
	self endon("disconnect");
	self endon("overdriveEnd");
	var_01 = -10311;
	for(;;)
	{
		var_02 = self getvelocity();
		if(lengthsquared(var_02) < var_01)
		{
			param_00 method_8526(0);
		}
		else
		{
			var_03 = vectornormalize(var_02);
			var_04 = self.origin + var_03 * 25;
			param_00 method_852C(1,var_04,325);
			param_00 method_8529(1);
			param_00 method_8526(1);
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 16
func_13AE0()
{
	self endon("death");
	self endon("disconnect");
	self endon("overdriveEnd");
	var_00 = -10311;
	for(;;)
	{
		var_01 = self getvelocity() * (1,1,0);
		var_02 = length2dsquared(var_01);
		if(var_02 >= var_00)
		{
			self setscriptablepartstate("overdriveMove","active",0);
		}
		else
		{
			self setscriptablepartstate("overdriveMove","neutral",0);
		}

		wait(0.1);
	}
}