/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\_entityheadicons.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 10
 * Decompile Time: 177 ms
 * Timestamp: 4/22/2024 2:15:35 AM
*******************************************************************/

//Function Number: 1
init()
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
			game[var_02] = maps\mp\gametypes\_teams::mt_getteamheadicon(var_01);
			precacheshader(game[var_02]);
		}

		return;
	}

	game["entity_headicon_allies"] = maps\mp\gametypes\_teams::getteamheadicon("allies");
	game["entity_headicon_axis"] = maps\mp\gametypes\_teams::getteamheadicon("axis");
	precacheshader(game["entity_headicon_allies"]);
	precacheshader(game["entity_headicon_axis"]);
}

//Function Number: 2
setheadicon(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B)
{
	if(maps\mp\_utility::isgameparticipant(param_00) && !isplayer(param_00))
	{
		return;
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

	if(!isdefined(param_0B))
	{
		param_0B = "";
	}

	if(!isplayer(param_00) && param_00 == "none")
	{
		foreach(var_0E, var_0D in self.entityheadicons)
		{
			if(isdefined(var_0D))
			{
				var_0D destroy();
			}

			self.entityheadicons[var_0E] = undefined;
		}

		return;
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
			return;
		}

		if(isdefined(self.entityheadicons[param_03.team]))
		{
			self.entityheadicons[param_03.team] destroy();
			self.entityheadicons[param_03.team] = undefined;
		}

		var_0D = newclienthudelem(param_03);
		self.entityheadicons[param_02.guid] = var_0E;
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
			return;
		}

		foreach(var_0F in self.entityheadicons)
		{
			if(var_11 == "axis" || var_11 == "allies")
			{
				continue;
			}

			var_10 = maps\mp\_utility::getplayerforguid(var_11);
			if(var_10.team == param_01)
			{
				self.entityheadicons[var_11] destroy();
				self.entityheadicons[var_11] = undefined;
			}
		}

		var_0D = newteamhudelem(param_01);
		self.entityheadicons[param_01] = var_0D;
	}

	if(!isdefined(param_04) || !isdefined(param_05))
	{
		param_04 = 10;
		param_05 = 10;
	}

	var_0D.archived = param_06;
	var_0D.alpha = 0.85;
	var_0D setshader(param_02,param_04,param_05);
	var_0D setwaypoint(param_08,param_09,param_0A,param_0B);
	if(var_0C == "")
	{
		var_0D.x = self.origin[0] + param_03[0];
		var_0D.y = self.origin[1] + param_03[1];
		var_0D.z = self.origin[2] + param_03[2];
		var_0D thread keeppositioned(self,param_03,param_07);
	}
	else
	{
		var_0D.x = param_03[0];
		var_0D.y = param_03[1];
		var_0D.z = param_03[2];
		var_0D settargetent(self,var_0C);
	}

	thread destroyiconsondeath();
	if(isplayer(param_01))
	{
		var_0D thread destroyonownerdisconnect(param_01);
	}

	if(isplayer(self))
	{
		var_0D thread destroyonownerdisconnect(self);
	}

	return var_0D;
}

//Function Number: 3
destroyonownerdisconnect(param_00)
{
	self endon("death");
	param_00 waittill("disconnect");
	self destroy();
}

//Function Number: 4
destroyiconsondeath()
{
	self notify("destroyIconsOnDeath");
	self endon("destroyIconsOnDeath");
	self waittill("death");
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
keeppositioned(param_00,param_01,param_02)
{
	self endon("death");
	param_00 endon("death");
	param_00 endon("disconnect");
	var_03 = param_00.origin;
	for(;;)
	{
		if(!isdefined(param_00))
		{
			return;
		}

		if(var_03 != param_00.origin)
		{
			var_03 = param_00.origin;
			self.x = var_03[0] + param_01[0];
			self.y = var_03[1] + param_01[1];
			self.z = var_03[2] + param_01[2];
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
setteamheadicon(param_00,param_01,param_02,param_03)
{
	if(!level.teambased)
	{
		return;
	}

	if(!isdefined(param_02))
	{
		param_02 = "";
	}

	if(!isdefined(self.entityheadiconteam))
	{
		self.entityheadiconteam = "none";
		self.entityheadicon = undefined;
	}

	if(isdefined(param_03) && param_03 == 0)
	{
		var_04 = undefined;
	}

	var_05 = game["entity_headicon_" + param_00];
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

		return;
	}

	var_06 = newteamhudelem(param_00);
	var_06.archived = 1;
	var_06.alpha = 0.8;
	var_06 setshader(var_05,10,10);
	var_06 setwaypoint(0,0,0,1);
	self.entityheadicon = var_06;
	if(!isdefined(param_03))
	{
		if(param_02 == "")
		{
			var_06.x = self.origin[0] + self.entityheadiconoffset[0];
			var_06.y = self.origin[1] + self.entityheadiconoffset[1];
			var_06.z = self.origin[2] + self.entityheadiconoffset[2];
			thread keepiconpositioned();
		}
		else
		{
			var_06.x = self.entityheadiconoffset[0];
			var_06.y = self.entityheadiconoffset[1];
			var_06.z = self.entityheadiconoffset[2];
			var_06 settargetent(self,param_02);
		}
	}
	else
	{
		var_07 = anglestoup(self.angles);
		var_08 = self.origin + var_07 * 28;
		if(param_02 == "")
		{
			var_06.x = var_08[0];
			var_06.y = var_08[1];
			var_06.z = var_08[2];
			thread keepiconpositioned(param_03);
		}
		else
		{
			var_06.x = var_08[0];
			var_06.y = var_08[1];
			var_06.z = var_08[2];
			var_06 settargetent(self,param_02);
		}
	}

	thread destroyheadiconsondeath();
}

//Function Number: 7
setplayerheadicon(param_00,param_01,param_02)
{
	if(level.teambased)
	{
		return;
	}

	if(!isdefined(param_02))
	{
		param_02 = "";
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

		return;
	}

	var_03 = param_00.team;
	self.entityheadiconteam = var_03;
	if(isdefined(param_01))
	{
		self.entityheadiconoffset = param_01;
	}
	else
	{
		self.entityheadiconoffset = (0,0,0);
	}

	var_04 = game["entity_headicon_" + var_03];
	var_05 = newclienthudelem(param_00);
	var_05.archived = 1;
	var_05.alpha = 0.8;
	var_05 setshader(var_04,10,10);
	var_05 setwaypoint(0,0,0,1);
	self.entityheadicon = var_05;
	if(param_02 == "")
	{
		var_05.x = self.origin[0] + self.entityheadiconoffset[0];
		var_05.y = self.origin[1] + self.entityheadiconoffset[1];
		var_05.z = self.origin[2] + self.entityheadiconoffset[2];
		thread keepiconpositioned();
	}
	else
	{
		var_05.x = self.entityheadiconoffset[0];
		var_05.y = self.entityheadiconoffset[1];
		var_05.z = self.entityheadiconoffset[2];
		var_05 settargetent(self,param_02);
	}

	thread destroyheadiconsondeath();
}

//Function Number: 8
keepiconpositioned(param_00)
{
	self endon("kill_entity_headicon_thread");
	self endon("death");
	var_01 = self.origin;
	for(;;)
	{
		if(var_01 != self.origin)
		{
			updateheadiconorigin(param_00);
			var_01 = self.origin;
		}

		wait(0.05);
	}
}

//Function Number: 9
destroyheadiconsondeath()
{
	self endon("kill_entity_headicon_thread");
	self waittill("death");
	if(!isdefined(self.entityheadicon))
	{
		return;
	}

	self.entityheadicon destroy();
}

//Function Number: 10
updateheadiconorigin(param_00)
{
	if(!isdefined(param_00))
	{
		self.entityheadicon.x = self.origin[0] + self.entityheadiconoffset[0];
		self.entityheadicon.y = self.origin[1] + self.entityheadiconoffset[1];
		self.entityheadicon.z = self.origin[2] + self.entityheadiconoffset[2];
		return;
	}

	var_01 = anglestoup(self.angles);
	var_02 = self.origin + var_01 * 28;
	self.entityheadicon.x = var_02[0];
	self.entityheadicon.y = var_02[1];
	self.entityheadicon.z = var_02[2];
}