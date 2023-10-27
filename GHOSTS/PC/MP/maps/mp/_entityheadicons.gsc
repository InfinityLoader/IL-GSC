/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\_entityheadicons.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 10
 * Decompile Time: 208 ms
 * Timestamp: 10/27/2023 1:22:14 AM
*******************************************************************/

//Function Number: 1
func_44DF()
{
	if(isdefined(level.initedentityheadicons))
	{
		return;
	}

	level.initedentityheadicons = 1;
	if(level.multiteambased)
	{
		foreach(var_01 in level.teamnamelist)
		{
			var_02 = "entity_headicon_" + var_01;
			game[var_02] = maps\mp\gametypes\_teams::func_54F5(var_01);
			precacheshader(game[var_02]);
		}

		return;
	}

	game["entity_headicon_allies"] = maps\mp\gametypes\_teams::func_3C38("allies");
	game["entity_headicon_axis"] = maps\mp\gametypes\_teams::func_3C38("axis");
	precacheshader(game["entity_headicon_allies"]);
	precacheshader(game["entity_headicon_axis"]);
}

//Function Number: 2
setheadicon(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A)
{
	if(maps\mp\_utility::func_48CE(param_00) && !isplayer(param_00))
	{
	}

	if(!isdefined(self.entityheadicons))
	{
		self.entityheadicons = [];
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
		foreach(var_0D, var_0C in self.entityheadicons)
		{
			if(isdefined(var_0C))
			{
				var_0C destroy();
			}

			self.entityheadicons[var_0D] = undefined;
		}
	}

	if(isplayer(param_03))
	{
		if(isdefined(self.entityheadicons[param_03.guid]))
		{
			self.entityheadicons[param_03.guid] destroy();
			self.entityheadicons[param_03.guid] = undefined;
		}

		if(param_04 == "")
		{
		}

		if(isdefined(param_03.team))
		{
			if(isdefined(self.entityheadicons[param_03.team]))
			{
				self.entityheadicons[param_03.team] destroy();
				self.entityheadicons[param_03.team] = undefined;
			}
		}

		var_0C = newclienthudelem(param_03);
		self.entityheadicons[param_02.guid] = var_0D;
	}
	else
	{
		if(isdefined(self.entityheadicons[param_03]))
		{
			self.entityheadicons[param_03] destroy();
			self.entityheadicons[param_03] = undefined;
		}

		if(param_04 == "")
		{
		}

		foreach(var_0E in self.entityheadicons)
		{
			if(var_10 == "axis" || var_10 == "allies")
			{
				continue;
			}

			var_0F = maps\mp\_utility::func_3B96(var_10);
			if(var_0F.team == param_01)
			{
				self.entityheadicons[var_10] destroy();
				self.entityheadicons[var_10] = undefined;
			}
		}

		var_0C = newteamhudelem(param_01);
		self.entityheadicons[param_01] = var_0C;
	}

	if(!isdefined(param_04) || !isdefined(param_05))
	{
		param_04 = 10;
		param_05 = 10;
	}

	var_0C.archived = param_06;
	var_0C.x = self.origin[0] + param_03[0];
	var_0C.y = self.origin[1] + param_03[1];
	var_0C.z = self.origin[2] + param_03[2];
	var_0C.alpha = 0.85;
	var_0C setshader(param_02,param_04,param_05);
	var_0C setwaypoint(param_08,param_09,param_0A,var_0B);
	var_0C thread func_4AA1(self,param_03,param_07);
	thread func_2656();
	if(isplayer(param_01))
	{
		var_0C thread func_2657(param_01);
	}

	if(isplayer(self))
	{
		var_0C thread func_2657(self);
	}

	return var_0C;
}

//Function Number: 3
func_2657(param_00)
{
	self endon("death");
	param_00 waittill("disconnect");
	self destroy();
}

//Function Number: 4
func_2656()
{
	self notify("destroyIconsOnDeath");
	self endon("destroyIconsOnDeath");
	self waittill("death");
	if(!isdefined(self.entityheadicons))
	{
	}

	foreach(var_01 in self.entityheadicons)
	{
		if(!isdefined(var_01))
		{
			continue;
		}

		var_01 destroy();
	}
}

//Function Number: 5
func_4AA1(param_00,param_01,param_02)
{
	self endon("death");
	param_00 endon("death");
	param_00 endon("disconnect");
	var_03 = isdefined(param_00.classname) && !func_4924(param_00);
	if(var_03)
	{
		self linkwaypointtotargetwithoffset(param_00,param_01);
	}

	for(;;)
	{
		if(!isdefined(param_00))
		{
		}

		if(!var_03)
		{
			var_04 = param_00.origin;
			self.x = var_04[0] + param_01[0];
			self.y = var_04[1] + param_01[1];
			self.z = var_04[2] + param_01[2];
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
func_4924(param_00)
{
	return isdefined(param_00.targetname) && param_00.targetname == "care_package";
}

//Function Number: 7
func_70E0(param_00,param_01)
{
	if(!level.teambased)
	{
	}

	if(!isdefined(self.entityheadiconteam))
	{
		self.entityheadiconteam = "none";
		self.entityheadicon = undefined;
	}

	var_02 = game["entity_headicon_" + param_00];
	self.entityheadiconteam = param_00;
	if(isdefined(param_01))
	{
		self.entityheadiconoffset = param_01;
	}
	else
	{
		self.entityheadiconoffset = (0,0,0);
	}

	self notify("kill_entity_headicon_thread");
	if(param_00 == "none")
	{
		if(isdefined(self.entityheadicon))
		{
			self.entityheadicon destroy();
		}
	}

	var_03 = newteamhudelem(param_00);
	var_03.archived = 1;
	var_03.x = self.origin[0] + self.entityheadiconoffset[0];
	var_03.y = self.origin[1] + self.entityheadiconoffset[1];
	var_03.z = self.origin[2] + self.entityheadiconoffset[2];
	var_03.alpha = 0.8;
	var_03 setshader(var_02,10,10);
	var_03 setwaypoint(0,0,0,1);
	self.entityheadicon = var_03;
	thread func_4A9F();
	thread destroyheadiconsondeath();
}

//Function Number: 8
func_7099(param_00,param_01)
{
	if(level.teambased)
	{
	}

	if(!isdefined(self.entityheadiconteam))
	{
		self.entityheadiconteam = "none";
		self.entityheadicon = undefined;
	}

	self notify("kill_entity_headicon_thread");
	if(!isdefined(param_00))
	{
		if(isdefined(self.entityheadicon))
		{
			self.entityheadicon destroy();
		}
	}

	var_02 = param_00.team;
	self.entityheadiconteam = var_02;
	if(isdefined(param_01))
	{
		self.entityheadiconoffset = param_01;
	}
	else
	{
		self.entityheadiconoffset = (0,0,0);
	}

	var_03 = game["entity_headicon_" + var_02];
	var_04 = newclienthudelem(param_00);
	var_04.archived = 1;
	var_04.x = self.origin[0] + self.entityheadiconoffset[0];
	var_04.y = self.origin[1] + self.entityheadiconoffset[1];
	var_04.z = self.origin[2] + self.entityheadiconoffset[2];
	var_04.alpha = 0.8;
	var_04 setshader(var_03,10,10);
	var_04 setwaypoint(0,0,0,1);
	self.entityheadicon = var_04;
	thread func_4A9F();
	thread destroyheadiconsondeath();
}

//Function Number: 9
func_4A9F()
{
	self.entityheadicon linkwaypointtotargetwithoffset(self,self.entityheadiconoffset);
}

//Function Number: 10
destroyheadiconsondeath()
{
	self endon("kill_entity_headicon_thread");
	self waittill("death");
	if(!isdefined(self.entityheadicon))
	{
	}

	self.entityheadicon destroy();
}