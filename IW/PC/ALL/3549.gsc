/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3549.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 18
 * Decompile Time: 4 ms
 * Timestamp: 10/27/2023 12:30:39 AM
*******************************************************************/

//Function Number: 1
func_333D(param_00)
{
	thread func_333F();
}

//Function Number: 2
func_333E(param_00)
{
	self endon("disconnect");
	param_00 endon("death");
	scripts\mp\_utility::func_D915("c4 spawn",param_00.var_222);
	param_00.var_11832 = gettime();
	func_332E(param_00);
	thread func_3340();
	thread func_333F();
	if(scripts\mp\_utility::_hasperk("specialty_rugged_eqp"))
	{
		param_00.hasruggedeqp = 1;
	}

	param_00 thread scripts\mp\_weapons::func_B76A();
	param_00 thread func_3339();
	param_00 thread func_3334();
	thread scripts\mp\_weapons::monitordisownedgrenade(self,param_00);
	param_00 waittill("missile_stuck");
	param_00 method_831F(self);
	param_00 method_8317(1);
	scripts\mp\_weapons::func_C54E(param_00,"power_c4");
	thread scripts\mp\_weapons::func_B9CA(self,param_00);
	param_00 thread scripts\mp\_weapons::func_B2A7("tag_use",1);
	param_00 scripts\mp\sentientpoolmanager::registersentient("Lethal_Static",param_00.var_222,1);
	param_00 thread func_3333();
	param_00 thread scripts\mp\perks\_perk_equipmentping::func_E84B();
	param_00 setscriptablepartstate("plant","active",0);
	thread scripts\mp\_weapons::func_C798(param_00,self);
	param_00 method_859F();
	param_00 method_85A0();
	param_00 thread scripts\mp\_entityheadicons::func_F73E(self,(0,0,20),0.1);
}

//Function Number: 3
func_3335()
{
	self endon("death");
	self.var_222 endon("disconnect");
	wait(0.1);
	thread func_3338(self.var_222);
}

//Function Number: 4
func_3338(param_00)
{
	scripts\mp\_utility::func_D915("c4 triggered",self.var_222);
	thread func_3330(0.1);
	self method_82DD(param_00);
	self method_8593();
	self setscriptablepartstate("plant","neutral",0);
	self setscriptablepartstate("explode","active",0);
}

//Function Number: 5
func_3332(param_00)
{
	thread func_3330(0.1);
	self setscriptablepartstate("plant","neutral",0);
	self setscriptablepartstate("destroy","active",0);
}

//Function Number: 6
func_3330(param_00)
{
	self notify("death");
	level.var_B779[self getentitynumber()] = undefined;
	self setcandamage(0);
	scripts\mp\_weapons::func_B2A4();
	self.var_69BA = 1;
	var_01 = self.var_222;
	if(isdefined(self.var_222))
	{
		var_01.var_CC4C = scripts\common\utility::func_22A9(var_01.var_CC4C,self);
		var_01 notify("c4_update",0);
	}

	wait(param_00);
	self delete();
}

//Function Number: 7
func_3339()
{
	self endon("death");
	self.var_222 endon("disconnect");
	level endon("game_ended");
	var_00 = self.var_222;
	self waittill("detonateExplosive",var_01);
	if(isdefined(var_01))
	{
		thread func_3338(var_01);
		return;
	}

	thread func_3338(var_00);
}

//Function Number: 8
func_3333()
{
	self endon("death");
	self.var_222 endon("disconnect");
	self waittill("emp_damage",var_00,var_01,var_02,var_03,var_04);
	if(isdefined(var_03) && var_03 == "emp_grenade_mp")
	{
		if(scripts\mp\_utility::func_9FB3(scripts\mp\_utility::playersareenemies(self.var_222,var_00)))
		{
			var_00 scripts\mp\_missions::func_D991("ch_tactical_emp_eqp");
		}
	}

	if(scripts\mp\_utility::func_9FB3(scripts\mp\_utility::playersareenemies(self.var_222,var_00)))
	{
		var_00 notify("destroyed_equipment");
		var_00 scripts\mp\killstreaks\_killstreaks::func_83A0();
	}

	var_05 = "";
	if(scripts\mp\_utility::func_9FB3(self.hasruggedeqp))
	{
		var_05 = "hitequip";
	}

	if(isplayer(var_00))
	{
		var_00 scripts\mp\_damagefeedback::func_12E84(var_05);
	}

	thread func_3332();
}

//Function Number: 9
func_3334()
{
	self endon("death");
	level scripts\common\utility::waittill_any_3("game_ended","bro_shot_start");
	thread func_3332();
}

//Function Number: 10
c4_validdetonationstate()
{
	if(!scripts\mp\_utility::func_9F19(self))
	{
		return 0;
	}

	if(scripts\mp\_utility::func_9FC6())
	{
		return 0;
	}

	if(lib_0DF8::func_9DDF(self))
	{
		return 0;
	}

	if(lib_0E17::isusingreaper())
	{
		return 0;
	}

	if(self method_84CA())
	{
		return 0;
	}

	if(self method_8568())
	{
		return 0;
	}

	return 1;
}

//Function Number: 11
func_332F()
{
	return gettime() - self.var_11832 / 1000 > 0.3;
}

//Function Number: 12
func_3340()
{
	self endon("death");
	self endon("disconnect");
	self endon("c4_unset");
	level endon("game_ended");
	self notify("watchForDetonation");
	self endon("watchForDetonation");
	for(;;)
	{
		self waittill("detonate");
		thread func_3336();
	}
}

//Function Number: 13
func_333F()
{
	self endon("death");
	self endon("disconnect");
	self endon("c4_unset");
	level endon("game_ended");
	self notify("watchForAltDetonation");
	self endon("watchForAltDetonation");
	while(self usebuttonpressed())
	{
		scripts\common\utility::func_136F7();
	}

	var_00 = 0;
	for(;;)
	{
		if(self usebuttonpressed())
		{
			var_00 = 0;
			while(self usebuttonpressed())
			{
				var_00 = var_00 + 0.05;
				wait(0.05);
			}

			if(var_00 >= 0.5)
			{
				continue;
			}

			var_00 = 0;
			while(!self usebuttonpressed() && var_00 < 0.25)
			{
				var_00 = var_00 + 0.05;
				wait(0.05);
			}

			if(var_00 >= 0.25)
			{
				continue;
			}

			if(c4_validdetonationstate())
			{
				thread func_3336();
			}
		}

		wait(0.05);
	}
}

//Function Number: 14
func_3336()
{
	if(isdefined(self.var_334E))
	{
		foreach(var_01 in self.var_334E)
		{
			if(var_01 func_332F())
			{
				var_01 thread func_3335();
			}
		}
	}
}

//Function Number: 15
c4_resetaltdetonpickup()
{
	if(scripts\mp\_powers::func_8C17("power_c4"))
	{
		thread func_333F();
	}
}

//Function Number: 16
func_332E(param_00)
{
	var_01 = self.var_222;
	if(!isdefined(self.var_334E))
	{
		self.var_334E = [];
	}

	self.var_334E[param_00 getentitynumber()] = param_00;
	thread func_333C(param_00);
}

//Function Number: 17
func_333B(param_00)
{
	if(!isdefined(self.var_334E))
	{
		return;
	}

	self.var_334E[param_00] = undefined;
}

//Function Number: 18
func_333C(param_00)
{
	self endon("disconnect");
	var_01 = param_00 getentitynumber();
	param_00 waittill("death");
	func_333B(var_01);
}