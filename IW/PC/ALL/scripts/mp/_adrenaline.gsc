/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\_adrenaline.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 26
 * Decompile Time: 1273 ms
 * Timestamp: 10/27/2023 12:14:20 AM
*******************************************************************/

//Function Number: 1
init()
{
	if(getdvarint("prototype_adrenaline_enabled") == 1 && level.rankedmatch)
	{
		func_97BF();
		level thread func_C56E();
	}
}

//Function Number: 2
func_97BF()
{
	precacheshader("combathigh_overlay");
}

//Function Number: 3
func_7D9E()
{
	return getdvarfloat("adrenaline_winddown_time_sec",30);
}

//Function Number: 4
func_7D9F()
{
	return getdvarint("adrenaline_xp_multiplier",4);
}

//Function Number: 5
func_7D9D()
{
	return getdvarint("adrenaline_min_spm_threshold",80);
}

//Function Number: 6
func_7D9C()
{
	return getdvarfloat("adrenaline_history_mins",3);
}

//Function Number: 7
func_1892()
{
	return getdvarint("adrenaline_debugging",0);
}

//Function Number: 8
func_C56E()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_00 thread func_C57B();
	}
}

//Function Number: 9
func_C57B()
{
	for(;;)
	{
		if(func_1892())
		{
		}

		self waittill("spawned_player");
		func_FA89();
		thread func_18AB();
		thread func_18B1();
		thread func_18AF();
		thread func_18B0();
	}
}

//Function Number: 10
func_18AB()
{
	self endon("disconnect");
	self endon("death");
	var_00 = 0;
	for(;;)
	{
		func_1891();
		var_01 = func_18A9();
		var_02 = self.var_115B;
		if(func_1892() && var_01 > 0 && var_01 != var_00)
		{
		}

		if(var_00 < var_01 && func_181E() <= var_01)
		{
			self.var_115B = func_7D9E();
			self notify("adrenaline_update");
		}

		var_00 = var_01;
		wait(0.3);
	}
}

//Function Number: 11
func_1896()
{
	var_00 = self.var_115B - 5 / func_7D9E() - 5 * 0.5;
	var_00 = var_00 + 0.5;
	if(var_00 > 1)
	{
		var_00 = 1;
	}

	return var_00;
}

//Function Number: 12
func_1891()
{
	for(var_00 = 0;var_00 < self.var_115E.size;var_00++)
	{
		if(gettime() - self.var_115E[var_00] > func_7D9C() * 60 * 1000)
		{
			self.var_115E[var_00] = undefined;
			self.var_115D[var_00] = undefined;
		}
	}

	self.var_115E = scripts\common\utility::func_22BC(self.var_115E);
	self.var_115D = scripts\common\utility::func_22BC(self.var_115D);
}

//Function Number: 13
func_18A9()
{
	var_00 = 0;
	foreach(var_02 in self.var_115D)
	{
		var_00 = var_00 + var_02;
	}

	return var_00 / func_7D9C() * 1;
}

//Function Number: 14
func_181E()
{
	var_00 = scripts\mp\_persistence::func_10E33("score");
	var_01 = scripts\mp\_persistence::func_10E34("timePlayedTotal");
	if(var_01 > 0)
	{
		var_02 = var_00 / var_01 / 60 + 34;
	}
	else
	{
		var_02 = func_7D9D();
	}

	if(var_02 < func_7D9D())
	{
		var_02 = func_7D9D();
	}

	if(func_1892())
	{
	}

	return var_02;
}

//Function Number: 15
func_1890(param_00)
{
	if(func_1892())
	{
	}

	if(isdefined(self.var_115A))
	{
		self.var_115E[self.var_115E.size] = gettime();
		self.var_115D[self.var_115D.size] = param_00;
	}
}

//Function Number: 16
func_1897()
{
	var_00 = 0;
	if(isdefined(self.var_115A) && self.var_115A)
	{
		var_00 = func_7D9F();
	}

	return var_00;
}

//Function Number: 17
func_FA89()
{
	self.var_115B = 0;
	self.var_115E = [];
	self.var_115D = [];
	self.var_115A = 0;
	self.var_115C = 0;
	self.var_18A8 = undefined;
}

//Function Number: 18
func_18AA()
{
	self.var_115C = 1;
}

//Function Number: 19
func_1893()
{
	var_00 = 0;
	if(getdvarint("prototype_adrenaline_enabled") == 1)
	{
		var_00 = self.var_115C;
	}

	return var_00;
}

//Function Number: 20
func_1898()
{
	var_00 = 0;
	if(getdvarint("prototype_adrenaline_enabled") == 1 && isdefined(self.var_115A))
	{
		var_00 = self.var_115A;
	}

	return var_00;
}

//Function Number: 21
func_18AE(param_00)
{
	if(param_00 func_1898())
	{
		if(param_00 func_1893())
		{
			thread scripts\mp\_hud_message::func_10151("adrenaline_mood_killer",0);
			return;
		}

		thread scripts\mp\_hud_message::func_10151("adrenaline_iced",0);
	}
}

//Function Number: 22
func_661F()
{
	if(!self.var_115A)
	{
		self.var_18A8 = newclienthudelem(self);
		self.var_18A8.x = 0;
		self.var_18A8.y = 0;
		self.var_18A8.alignx = "left";
		self.var_18A8.aligny = "top";
		self.var_18A8.horzalign = "fullscreen";
		self.var_18A8.vertalign = "fullscreen";
		self.var_18A8 setshader("combathigh_overlay",640,480);
		self.var_18A8.sort = -10;
		self.var_18A8.archived = 1;
		self.var_18A8.alpha = 0;
		self.var_115A = 1;
	}
}

//Function Number: 23
func_18AF()
{
	self endon("death");
	self endon("disconnect");
	for(;;)
	{
		self waittill("adrenaline_update");
		if(!self.var_115A)
		{
			wait(0.05);
			if(func_1892())
			{
			}

			func_661F();
			thread scripts\mp\_hud_message::func_10151("adrenaline_enter",func_7D9F());
		}

		self.var_18A8 fadeovertime(0.3);
		self.var_18A8.alpha = 1;
		wait(0.3);
		thread func_18AC();
	}
}

//Function Number: 24
func_18AC()
{
	self endon("adrenaline_update");
	self endon("death");
	self endon("disconnect");
	while(self.var_115B > 5)
	{
		var_00 = func_1896();
		if(func_1892())
		{
		}

		self.var_18A8 fadeovertime(0.3);
		self.var_18A8.alpha = var_00;
		wait(0.3);
		self.var_115B = self.var_115B - 0.3;
	}

	var_01 = 40;
	var_02 = 40;
	while(self.var_115B > 0)
	{
		self.var_18A8 fadeovertime(0.1);
		self.var_18A8.alpha = 1;
		wait(0.05);
		self.var_18A8 fadeovertime(0.1);
		self.var_18A8.alpha = 0.5;
		wait(0.9);
		self.var_115B = self.var_115B - 1;
	}

	self.var_18A8 fadeovertime(0.3);
	self.var_18A8.alpha = 0;
	wait(0.3);
	self notify("adrenaline_cleanup");
}

//Function Number: 25
func_18B0()
{
	for(;;)
	{
		scripts\common\utility::func_13734("adrenaline_cleanup","death","disconnect");
		if(self.var_115A)
		{
			self.var_115A = 0;
			self.var_18A8 destroy();
			self.var_18A8 = undefined;
		}
	}
}

//Function Number: 26
func_18B1()
{
	self waittill("death");
	self notify("adrenaline_cleanup");
}