/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\_entityheadicons.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 10
 * Decompile Time: 172 ms
 * Timestamp: 10/27/2023 3:21:15 AM
*******************************************************************/

//Function Number: 1
func_00D5()
{
	if(isdefined(level.var_52B3))
	{
		return;
	}

	level.var_52B3 = 1;
	if(level.var_6520)
	{
		foreach(var_01 in level.var_985B)
		{
			var_02 = "entity_headicon_" + var_01;
			game[var_02] = maps\mp\gametypes\_teams::func_650A(var_01);
			precacheshader(game[var_02]);
		}

		return;
	}

	game["entity_headicon_allies"] = maps\mp\gametypes\_teams::func_46D1("allies");
	game["entity_headicon_axis"] = maps\mp\gametypes\_teams::func_46D1("axis");
	precacheshader(game["entity_headicon_allies"]);
	precacheshader(game["entity_headicon_axis"]);
}

//Function Number: 2
func_869E(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B,param_0C)
{
	if(maps\mp\_utility::func_56FF(param_00) && !isplayer(param_00))
	{
		return;
	}

	if(!isdefined(self.var_37D6))
	{
		self.var_37D6 = [];
	}

	if(!isdefined(param_05))
	{
		param_05 = 1;
	}

	if(!isdefined(param_06))
	{
		param_06 = 0.05;
	}

	if(!isdefined(param_07))
	{
		param_07 = 1;
	}

	if(!isdefined(param_08))
	{
		param_08 = 1;
	}

	if(!isdefined(param_09))
	{
		param_09 = 0;
	}

	if(!isdefined(param_0A))
	{
		param_0A = 1;
	}

	if(!isdefined(param_0B))
	{
		param_0B = "";
	}

	if(!isplayer(param_00) && param_00 == "none")
	{
		foreach(var_0F, var_0E in self.var_37D6)
		{
			if(isdefined(var_0E))
			{
				var_0E destroy();
			}

			self.var_37D6[var_0F] = undefined;
		}

		return;
	}

	if(isplayer(param_03))
	{
		if(isdefined(self.var_37D6[param_03.var_48CA]))
		{
			self.var_37D6[param_03.var_48CA] destroy();
			self.var_37D6[param_03.var_48CA] = undefined;
		}

		if(param_04 == "")
		{
			return;
		}

		if(isdefined(self.var_37D6[param_03.var_1A7]))
		{
			self.var_37D6[param_03.var_1A7] destroy();
			self.var_37D6[param_03.var_1A7] = undefined;
		}

		var_0E = newclienthudelem(param_03);
		self.var_37D6[param_02.var_48CA] = var_0F;
	}
	else
	{
		if(isdefined(self.var_37D6[param_03]))
		{
			self.var_37D6[param_03] destroy();
			self.var_37D6[param_03] = undefined;
		}

		if(param_04 == "")
		{
			return;
		}

		foreach(var_10 in self.var_37D6)
		{
			if(var_12 == "axis" || var_12 == "allies")
			{
				continue;
			}

			var_11 = maps\mp\_utility::func_4621(var_12);
			if(var_11.var_1A7 == param_01)
			{
				self.var_37D6[var_12] destroy();
				self.var_37D6[var_12] = undefined;
			}
		}

		if(isdefined(var_0D))
		{
			var_0E = newteamclienthiddenhudelem(param_01,var_0D);
		}
		else
		{
			var_0E = newteamhudelem(param_01);
		}

		self.var_37D6[param_01] = var_0E;
	}

	if(!isdefined(param_04) || !isdefined(param_05))
	{
		param_04 = 10;
		param_05 = 10;
	}

	var_0E.var_1F = param_06;
	var_0E.var_18 = 0.85;
	var_0E setshader(param_02,param_04,param_05);
	var_0E setwaypoint(param_08,param_09,param_0A,param_0B);
	if(param_0C == "")
	{
		var_0E.maxsightdistsqrd = self.var_116[0] + param_03[0];
		var_0E.var_1D7 = self.var_116[1] + param_03[1];
		var_0E.var_1D9 = self.var_116[2] + param_03[2];
		var_0E thread func_59DC(self,param_03,param_07);
	}
	else
	{
		var_0E.maxsightdistsqrd = param_03[0];
		var_0E.var_1D7 = param_03[1];
		var_0E.var_1D9 = param_03[2];
		var_0E settargetent(self,param_0C);
	}

	thread func_2DCF();
	if(isplayer(param_01))
	{
		var_0E thread func_2DD5(param_01);
	}

	if(isplayer(self))
	{
		var_0E thread func_2DD5(self);
	}

	return var_0E;
}

//Function Number: 3
func_2DD5(param_00)
{
	self endon("death");
	param_00 waittill("disconnect");
	self destroy();
}

//Function Number: 4
func_2DCF()
{
	self notify("destroyIconsOnDeath");
	self endon("destroyIconsOnDeath");
	self waittill("death");
	foreach(var_01 in self.var_37D6)
	{
		if(!isdefined(var_01))
		{
			continue;
		}

		var_01 destroy();
	}
}

//Function Number: 5
func_59DC(param_00,param_01,param_02)
{
	self endon("death");
	param_00 endon("death");
	param_00 endon("disconnect");
	var_03 = param_00.var_116;
	for(;;)
	{
		if(!isdefined(param_00))
		{
			return;
		}

		if(var_03 != param_00.var_116)
		{
			var_03 = param_00.var_116;
			self.maxsightdistsqrd = var_03[0] + param_01[0];
			self.var_1D7 = var_03[1] + param_01[1];
			self.var_1D9 = var_03[2] + param_01[2];
		}

		if(param_02 > 0.05)
		{
			self.var_18 = 0.85;
			self fadeovertime(param_02);
			self.var_18 = 0;
		}

		wait(param_02);
	}
}

//Function Number: 6
func_873C(param_00,param_01,param_02,param_03)
{
	if(!level.var_984D)
	{
		return;
	}

	if(!isdefined(param_02))
	{
		param_02 = "";
	}

	if(!isdefined(self.var_37D7))
	{
		self.var_37D7 = "none";
		self.var_37D3 = undefined;
	}

	if(isdefined(param_03) && param_03 == 0)
	{
		var_04 = undefined;
	}

	var_05 = param_00;
	if(maps\mp\_utility::func_579B() && common_scripts\utility::func_562E(level.var_79C1))
	{
		var_05 = maps\mp\_utility::func_45DE(param_00);
	}

	var_06 = game["entity_headicon_" + var_05];
	self.var_37D7 = param_00;
	if(isdefined(param_01))
	{
		self.var_37D4 = param_01;
	}
	else
	{
		self.var_37D4 = (0,0,0);
	}

	self notify("kill_entity_headicon_thread");
	if(param_00 == "none")
	{
		if(isdefined(self.var_37D3))
		{
			self.var_37D3 destroy();
		}

		return;
	}

	var_07 = newteamhudelem(param_00);
	var_07.var_1F = 1;
	var_07.var_18 = 0.8;
	var_07 setshader(var_06,10,10);
	var_07 setwaypoint(0,0,0,1);
	self.var_37D3 = var_07;
	if(!isdefined(param_03))
	{
		if(param_02 == "")
		{
			var_07.maxsightdistsqrd = self.var_116[0] + self.var_37D4[0];
			var_07.var_1D7 = self.var_116[1] + self.var_37D4[1];
			var_07.var_1D9 = self.var_116[2] + self.var_37D4[2];
			thread func_59DB();
		}
		else
		{
			var_07.maxsightdistsqrd = self.var_37D4[0];
			var_07.var_1D7 = self.var_37D4[1];
			var_07.var_1D9 = self.var_37D4[2];
			var_07 settargetent(self,param_02);
		}
	}
	else
	{
		var_08 = anglestoup(self.var_1D);
		var_09 = self.var_116 + var_08 * 28;
		if(param_02 == "")
		{
			var_07.maxsightdistsqrd = var_09[0];
			var_07.var_1D7 = var_09[1];
			var_07.var_1D9 = var_09[2];
			thread func_59DB(param_03);
		}
		else
		{
			var_07.maxsightdistsqrd = var_09[0];
			var_07.var_1D7 = var_09[1];
			var_07.var_1D9 = var_09[2];
			var_07 settargetent(self,param_02);
		}
	}

	thread func_2DCE();
}

//Function Number: 7
func_86FC(param_00,param_01,param_02)
{
	if(level.var_984D)
	{
		return;
	}

	if(!isdefined(param_02))
	{
		param_02 = "";
	}

	if(!isdefined(self.var_37D7))
	{
		self.var_37D7 = "none";
		self.var_37D3 = undefined;
	}

	self notify("kill_entity_headicon_thread");
	if(!isdefined(param_00))
	{
		if(isdefined(self.var_37D3))
		{
			self.var_37D3 destroy();
		}

		return;
	}

	var_03 = param_00.var_1A7;
	self.var_37D7 = var_03;
	if(isdefined(param_01))
	{
		self.var_37D4 = param_01;
	}
	else
	{
		self.var_37D4 = (0,0,0);
	}

	if(var_03 == "spectator")
	{
		var_04 = game["entity_headicon_allies"];
	}
	else
	{
		var_04 = game["entity_headicon_" + var_04];
	}

	var_05 = newclienthudelem(param_00);
	var_05.var_1F = 1;
	var_05.var_18 = 0.8;
	var_05 setshader(var_04,10,10);
	var_05 setwaypoint(0,0,0,1);
	self.var_37D3 = var_05;
	if(param_02 == "")
	{
		var_05.maxsightdistsqrd = self.var_116[0] + self.var_37D4[0];
		var_05.var_1D7 = self.var_116[1] + self.var_37D4[1];
		var_05.var_1D9 = self.var_116[2] + self.var_37D4[2];
		thread func_59DB();
	}
	else
	{
		var_05.maxsightdistsqrd = self.var_37D4[0];
		var_05.var_1D7 = self.var_37D4[1];
		var_05.var_1D9 = self.var_37D4[2];
		var_05 settargetent(self,param_02);
	}

	thread func_2DCE();
}

//Function Number: 8
func_59DB(param_00)
{
	self endon("kill_entity_headicon_thread");
	self endon("death");
	var_01 = self.var_116;
	for(;;)
	{
		if(var_01 != self.var_116)
		{
			func_A122(param_00);
			var_01 = self.var_116;
		}

		wait 0.05;
	}
}

//Function Number: 9
func_2DCE()
{
	self endon("kill_entity_headicon_thread");
	self waittill("death");
	if(!isdefined(self.var_37D3))
	{
		return;
	}

	self.var_37D3 destroy();
}

//Function Number: 10
func_A122(param_00)
{
	if(!isdefined(param_00))
	{
		self.var_37D3.maxsightdistsqrd = self.var_116[0] + self.var_37D4[0];
		self.var_37D3.var_1D7 = self.var_116[1] + self.var_37D4[1];
		self.var_37D3.var_1D9 = self.var_116[2] + self.var_37D4[2];
		return;
	}

	var_01 = anglestoup(self.var_1D);
	var_02 = self.var_116 + var_01 * 28;
	self.var_37D3.maxsightdistsqrd = var_02[0];
	self.var_37D3.var_1D7 = var_02[1];
	self.var_37D3.var_1D9 = var_02[2];
}