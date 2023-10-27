/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\_entityheadicons.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 11
 * Decompile Time: 579 ms
 * Timestamp: 10/27/2023 12:15:13 AM
*******************************************************************/

//Function Number: 1
init()
{
	if(isdefined(level.var_9801))
	{
		return;
	}

	level.var_9801 = 1;
	if(level.multiteambased)
	{
		foreach(var_01 in level.teamnamelist)
		{
			var_02 = "entity_headicon_" + var_01;
			game[var_02] = scripts\mp\_teams::func_BD71(var_01);
			precacheshader(game[var_02]);
		}

		return;
	}

	game["entity_headicon_allies"] = scripts\mp\_teams::func_81B0("allies");
	game["entity_headicon_axis"] = scripts\mp\_teams::func_81B0("axis");
	precacheshader(game["entity_headicon_allies"]);
	precacheshader(game["entity_headicon_axis"]);
}

//Function Number: 2
func_F73D(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A)
{
	if(scripts\mp\_utility::func_9E0E(param_00) && !isplayer(param_00))
	{
		return;
	}

	if(!isdefined(self.var_6647))
	{
		self.var_6647 = [];
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

	if(!isplayer(param_00) && param_00 == "none")
	{
		foreach(var_0D, var_0C in self.var_6647)
		{
			if(isdefined(var_0C))
			{
				var_0C destroy();
			}

			self.var_6647[var_0D] = undefined;
		}

		return;
	}

	if(isplayer(param_03))
	{
		if(isdefined(self.var_6647[param_03.var_86BD]))
		{
			self.var_6647[param_03.var_86BD] destroy();
			self.var_6647[param_03.var_86BD] = undefined;
		}

		if(param_04 == "")
		{
			return;
		}

		if(isdefined(param_03.team))
		{
			if(isdefined(self.var_6647[param_03.team]))
			{
				self.var_6647[param_03.team] destroy();
				self.var_6647[param_03.team] = undefined;
			}
		}

		var_0C = newclienthudelem(param_03);
		self.var_6647[param_02.var_86BD] = var_0D;
	}
	else
	{
		if(isdefined(self.var_6647[param_03]))
		{
			self.var_6647[param_03] destroy();
			self.var_6647[param_03] = undefined;
		}

		if(param_04 == "")
		{
			return;
		}

		foreach(var_0E in self.var_6647)
		{
			if(var_10 == "axis" || var_10 == "allies")
			{
				continue;
			}

			var_0F = scripts\mp\_utility::func_8071(var_10);
			if(var_0F.team == param_01)
			{
				self.var_6647[var_10] destroy();
				self.var_6647[var_10] = undefined;
			}
		}

		var_0C = newteamhudelem(param_01);
		self.var_6647[param_01] = var_0C;
	}

	if(!isdefined(param_04) || !isdefined(param_05))
	{
		param_04 = 10;
		param_05 = 10;
	}

	var_0C.archived = param_06;
	var_0C.x = self.origin[0] + param_03[0];
	var_0C.y = self.origin[1] + param_03[1];
	var_0C.var_3A6 = self.origin[2] + param_03[2];
	var_0C.alpha = 0.85;
	var_0C setshader(param_02,param_04,param_05);
	var_0C setwaypoint(param_08,param_09,param_0A,var_0B);
	var_0C thread func_A57C(self,param_03,param_07);
	thread func_531F();
	if(isplayer(param_01))
	{
		var_0C thread func_5320(param_01);
	}

	if(isplayer(self))
	{
		var_0C thread func_5320(self);
	}

	return var_0C;
}

//Function Number: 3
func_5320(param_00)
{
	self endon("death");
	param_00 waittill("disconnect");
	self destroy();
}

//Function Number: 4
func_531F()
{
	self notify("destroyIconsOnDeath");
	self endon("destroyIconsOnDeath");
	self waittill("death");
	if(!isdefined(self.var_6647))
	{
		return;
	}

	foreach(var_01 in self.var_6647)
	{
		if(!isdefined(var_01))
		{
			continue;
		}

		var_01 destroy();
	}
}

//Function Number: 5
func_A57C(param_00,param_01,param_02)
{
	self endon("death");
	param_00 endon("death");
	param_00 endon("disconnect");
	var_03 = isdefined(param_00.classname) && !func_9ED0(param_00);
	if(var_03)
	{
		self linkwaypointtotargetwithoffset(param_00,param_01);
	}

	for(;;)
	{
		if(!isdefined(param_00))
		{
			return;
		}

		if(!var_03)
		{
			var_04 = param_00.origin;
			self.x = var_04[0] + param_01[0];
			self.y = var_04[1] + param_01[1];
			self.var_3A6 = var_04[2] + param_01[2];
		}

		if(param_02 > 0.05)
		{
			self.alpha = 0.85;
			self fadeovertime(param_02);
			self.alpha = 0;
		}

		wait(param_02);
	}
}

//Function Number: 6
func_9ED0(param_00)
{
	return isdefined(param_00.var_336) && param_00.var_336 == "care_package";
}

//Function Number: 7
func_F73E(param_00,param_01,param_02)
{
	self endon("death");
	param_00 endon("disconnect");
	wait(param_02);
	if(level.teambased)
	{
		func_F877(param_00.team,param_01);
		return;
	}

	func_F7F2(param_00,param_01);
}

//Function Number: 8
func_F877(param_00,param_01)
{
	if(!level.teambased)
	{
		return;
	}

	if(!isdefined(self.var_6648))
	{
		self.var_6648 = "none";
		self.var_6644 = undefined;
	}

	var_02 = game["entity_headicon_" + param_00];
	self.var_6648 = param_00;
	if(isdefined(param_01))
	{
		self.var_6645 = param_01;
	}
	else
	{
		self.var_6645 = (0,0,0);
	}

	self notify("kill_entity_headicon_thread");
	if(param_00 == "none")
	{
		if(isdefined(self.var_6644))
		{
			self.var_6644 destroy();
		}

		return;
	}

	var_03 = newteamhudelem(param_00);
	var_03.archived = 1;
	var_03.x = self.origin[0] + self.var_6645[0];
	var_03.y = self.origin[1] + self.var_6645[1];
	var_03.var_3A6 = self.origin[2] + self.var_6645[2];
	var_03.origin = (var_03.x,var_03.y,var_03.var_3A6);
	var_03.alpha = 1;
	var_03 setshader(var_02,10,10);
	var_03 setwaypoint(0,0,0,1);
	self.var_6644 = var_03;
	thread func_A578();
	thread func_531E();
}

//Function Number: 9
func_F7F2(param_00,param_01)
{
	if(level.teambased)
	{
		return;
	}

	if(!isdefined(self.var_6648))
	{
		self.var_6648 = "none";
		self.var_6644 = undefined;
	}

	self notify("kill_entity_headicon_thread");
	if(!isdefined(param_00))
	{
		if(isdefined(self.var_6644))
		{
			self.var_6644 destroy();
		}

		return;
	}

	var_02 = param_00.team;
	self.var_6648 = var_02;
	if(isdefined(param_01))
	{
		self.var_6645 = param_01;
	}
	else
	{
		self.var_6645 = (0,0,0);
	}

	var_03 = game["entity_headicon_" + var_02];
	var_04 = newclienthudelem(param_00);
	var_04.archived = 1;
	var_04.x = self.origin[0] + self.var_6645[0];
	var_04.y = self.origin[1] + self.var_6645[1];
	var_04.var_3A6 = self.origin[2] + self.var_6645[2];
	var_04.alpha = 0.8;
	var_04 setshader(var_03,10,10);
	var_04 setwaypoint(0,0,0,1);
	self.var_6644 = var_04;
	thread func_A578();
	thread func_531E();
}

//Function Number: 10
func_A578()
{
	self.var_6644 linkwaypointtotargetwithoffset(self,self.var_6645);
}

//Function Number: 11
func_531E()
{
	self endon("kill_entity_headicon_thread");
	self waittill("death");
	if(!isdefined(self.var_6644))
	{
		return;
	}

	self.var_6644 destroy();
}