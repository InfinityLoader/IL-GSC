/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_shellshock.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 12
 * Decompile Time: 181 ms
 * Timestamp: 10/27/2023 3:24:26 AM
*******************************************************************/

//Function Number: 1
func_00D5()
{
}

//Function Number: 2
func_8AF0(param_00,param_01)
{
	if(maps\mp\_flashgrenades::func_56F3())
	{
		return;
	}

	if(maps\mp\_utility::func_581D() || maps\mp\_utility::func_572D())
	{
		return;
	}

	if(param_00 == "MOD_EXPLOSIVE" || param_00 == "MOD_GRENADE" || param_00 == "MOD_GRENADE_SPLASH" || param_00 == "MOD_PROJECTILE" || param_00 == "MOD_PROJECTILE_SPLASH")
	{
		if(param_01 > 10)
		{
			if(!maps\mp\_utility::func_649("specialty_stun_resistance") && !isdefined(self.var_4B64) || !self.var_4B64)
			{
				self shellshock("frag_grenade_mp",0.5);
				return;
			}
		}
	}
}

//Function Number: 3
func_36DC()
{
	self waittill("death");
	waittillframeend;
	self notify("end_explode");
}

//Function Number: 4
func_485C()
{
	thread func_36DC();
	self endon("make_dud");
	self endon("end_explode");
	var_00 = self.var_117;
	var_01 = undefined;
	if(isdefined(var_00))
	{
		var_01 = var_00.var_1A7;
	}

	self waittill("explode",var_02);
	if(function_0367())
	{
	}
	else
	{
		function_01BB("grenade_rumble",var_02);
		earthquake(0.4,0.75,var_02,256);
	}

	foreach(var_04 in level.var_744A)
	{
		if(!isalive(var_04) || var_04 maps\mp\_utility::func_581D() || var_04 maps\mp\_utility::func_572D())
		{
			continue;
		}

		if(distancesquared(var_02,var_04.var_116) > 22500)
		{
			continue;
		}

		if(isdefined(level.var_984D) && level.var_984D && isdefined(var_00) && isdefined(var_01) && isdefined(var_04.var_1A7) && var_04 != var_00 && var_04.var_1A7 == var_01)
		{
			continue;
		}

		if(var_04 method_81D7(var_02))
		{
			if(!var_04 maps\mp\_utility::func_649("specialty_stun_resistance"))
			{
				var_04 shellshock("ear_ring_mp",1,0,0);
			}
		}

		var_04 setclientomnvar("ui_hud_shake",1);
	}
}

//Function Number: 5
func_2F13(param_00)
{
	self notify("dirtEffect");
	self endon("dirtEffect");
	self endon("disconnect");
	if(!maps\mp\_utility::func_57A0(self))
	{
		return;
	}

	var_01 = vectornormalize(anglestoforward(self.var_1D));
	var_02 = vectornormalize(anglestoright(self.var_1D));
	var_03 = vectornormalize(param_00 - self.var_116);
	var_04 = vectordot(var_03,var_01);
	var_05 = vectordot(var_03,var_02);
	var_06 = ["death","damage"];
	if(var_04 > 0 && var_04 > 0.5)
	{
		self setclientomnvar("ui_fullscreen_dirt_left",1);
		common_scripts\utility::func_A710(var_06,2);
		return;
	}

	if(abs(var_04) < 0.866)
	{
		if(var_05 > 0)
		{
			self setclientomnvar("ui_fullscreen_dirt_left",1);
			common_scripts\utility::func_A710(var_06,2);
			return;
		}

		self setclientomnvar("ui_fullscreen_dirt_left",1);
		common_scripts\utility::func_A710(var_06,2);
		return;
	}
}

//Function Number: 6
func_17FE(param_00)
{
	self notify("bloodEffect");
	self endon("bloodEffect");
	self endon("disconnect");
	if(!maps\mp\_utility::func_57A0(self))
	{
		return;
	}

	var_01 = vectornormalize(anglestoforward(self.var_1D));
	var_02 = vectornormalize(anglestoright(self.var_1D));
	var_03 = vectornormalize(param_00 - self.var_116);
	var_04 = vectordot(var_03,var_01);
	var_05 = vectordot(var_03,var_02);
	var_06 = ["death","damage"];
	if(var_04 > 0 && var_04 > 0.5)
	{
		common_scripts\utility::func_A710(var_06,7);
		return;
	}

	if(abs(var_04) < 0.866)
	{
		if(var_05 > 0)
		{
			common_scripts\utility::func_A710(var_06,7);
			return;
		}

		common_scripts\utility::func_A710(var_06,7);
		return;
	}
}

//Function Number: 7
func_17FF()
{
	self endon("disconnect");
	wait(0.5);
	if(isalive(self))
	{
		common_scripts\utility::func_A74B("death",1.5);
	}
}

//Function Number: 8
func_1DEE()
{
	thread func_36DC();
	self endon("end_explode");
	self endon("make_dud");
	var_00 = self.var_117;
	var_01 = self.var_117.var_1A7;
	self waittill("explode",var_02);
	function_01BB("grenade_rumble",var_02);
	earthquake(0.4,0.75,var_02,256);
	foreach(var_04 in level.var_744A)
	{
		if(var_04 maps\mp\_utility::func_581D() || var_04 maps\mp\_utility::func_572D())
		{
			continue;
		}

		if(distance(var_02,var_04.var_116) > 150)
		{
			continue;
		}

		if(isdefined(level.var_984D) && level.var_984D && isdefined(var_00) && isdefined(var_01) && isdefined(var_04.var_1A7) && var_04 != var_00 && var_04.var_1A7 == var_01)
		{
			continue;
		}

		if(var_04 method_81D7(var_02))
		{
			var_04 shellshock("ear_ring_mp",1,0,0);
		}

		var_04 setclientomnvar("ui_hud_shake",1);
	}
}

//Function Number: 9
func_15C5()
{
	var_00 = self.var_116;
	function_01BB("grenade_rumble",var_00);
	earthquake(0.4,0.5,var_00,512);
	foreach(var_02 in level.var_744A)
	{
		if(var_02 maps\mp\_utility::func_581D() || var_02 maps\mp\_utility::func_572D())
		{
			continue;
		}

		if(distance(var_00,var_02.var_116) > 512)
		{
			continue;
		}

		if(var_02 method_81D7(var_00))
		{
			var_02 setclientomnvar("ui_hud_shake",1);
		}
	}
}

//Function Number: 10
func_0FD9()
{
	var_00 = self.var_116;
	function_01BB("artillery_rumble",self.var_116);
	earthquake(0.7,0.5,self.var_116,800);
	foreach(var_02 in level.var_744A)
	{
		if(var_02 maps\mp\_utility::func_581D() || var_02 maps\mp\_utility::func_572D())
		{
			continue;
		}

		if(distance(var_00,var_02.var_116) > 600)
		{
			continue;
		}

		if(var_02 method_81D7(var_00))
		{
			var_02 setclientomnvar("ui_hud_shake",1);
		}
	}
}

//Function Number: 11
func_938E(param_00)
{
	function_01BB("grenade_rumble",param_00);
	earthquake(0.6,0.6,param_00,2000);
	foreach(var_02 in level.var_744A)
	{
		if(var_02 maps\mp\_utility::func_581D() || var_02 maps\mp\_utility::func_572D())
		{
			continue;
		}

		if(distance(param_00,var_02.var_116) > 1000)
		{
			continue;
		}

		if(var_02 method_81D7(param_00))
		{
			var_02 setclientomnvar("ui_hud_shake",1);
		}
	}
}

//Function Number: 12
func_0B94(param_00)
{
	function_01BB("artillery_rumble",param_00);
	earthquake(0.7,0.75,param_00,1000);
	foreach(var_02 in level.var_744A)
	{
		if(var_02 maps\mp\_utility::func_581D() || var_02 maps\mp\_utility::func_572D())
		{
			continue;
		}

		if(distance(param_00,var_02.var_116) > 900)
		{
			continue;
		}

		if(var_02 method_81D7(param_00))
		{
			var_02 setclientomnvar("ui_hud_shake",1);
		}
	}
}