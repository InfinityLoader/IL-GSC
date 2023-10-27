/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_spectating.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 12
 * Decompile Time: 343 ms
 * Timestamp: 10/27/2023 1:31:41 AM
*******************************************************************/

//Function Number: 1
func_44DF()
{
	level.spectateoverride["allies"] = addstruct();
	level.spectateoverride["axis"] = addstruct();
	level thread func_595D();
	level thread getlevelmlgcams();
}

//Function Number: 2
func_90AF(param_00)
{
	precachematerial(param_00);
	var_01 = spawn("script_model",(0,0,0));
	var_01 setmodel("tag_origin");
	var_01.angles = (0,0,0);
	var_02 = maps\mp\gametypes\_gameobjects::getnextobjid();
	objective_add(var_02,"active",(0,0,0));
	objective_icon(var_02,param_00);
	objective_playermask_hidefromall(var_02);
	objective_onentitywithrotation(var_02,var_01);
	var_01.objid = var_02;
	return var_01;
}

//Function Number: 3
func_9452(param_00)
{
	for(var_01 = 0;var_01 < level.cameramapobjs.size;var_01++)
	{
		if(param_00)
		{
			objective_playermask_showto(level.cameramapobjs[var_01].objid,self getentitynumber());
			continue;
		}

		objective_playermask_hidefrom(level.cameramapobjs[var_01].objid,self getentitynumber());
	}
}

//Function Number: 4
getlevelmlgcams()
{
	var_00 = tolower(getdvar("mapname"));
	var_01 = tablelookup("mp/CameraPositions.csv",0,var_00,1);
	var_02 = tablelookup("mp/CameraPositions.csv",0,var_00,2);
	level.cameramapobjs = [];
	level.cameramapobjs[0] = func_90AF("compass_mlg_cam1");
	level.cameramapobjs[1] = func_90AF("compass_mlg_cam2");
	level.cameramapobjs[2] = func_90AF("compass_mlg_cam3");
	level.cameramapobjs[3] = func_90AF("compass_mlg_cam4");
	if(var_01 == "")
	{
	}

	var_03 = tablelookup("mp/CameraPositions.csv",0,var_00,3);
	var_04 = tablelookup("mp/CameraPositions.csv",0,var_00,4);
	var_05 = tablelookup("mp/CameraPositions.csv",0,var_00,5);
	var_06 = tablelookup("mp/CameraPositions.csv",0,var_00,6);
	var_07 = tablelookup("mp/CameraPositions.csv",0,var_00,7);
	var_08 = tablelookup("mp/CameraPositions.csv",0,var_00,8);
	level.camera1pos = getcameravecorang(var_01);
	level.camera1ang = getcameravecorang(var_02);
	level.camera2pos = getcameravecorang(var_03);
	level.camera2ang = getcameravecorang(var_04);
	level.camera3pos = getcameravecorang(var_05);
	level.camera3ang = getcameravecorang(var_06);
	level.camera4pos = getcameravecorang(var_07);
	level.camera4ang = getcameravecorang(var_08);
	if(var_00 == "mp_strikezone")
	{
		var_09 = tablelookup("mp/CameraPositions.csv",0,var_00 + "_b",1);
		var_0A = tablelookup("mp/CameraPositions.csv",0,var_00 + "_b",2);
		var_0B = tablelookup("mp/CameraPositions.csv",0,var_00 + "_b",3);
		var_0C = tablelookup("mp/CameraPositions.csv",0,var_00 + "_b",4);
		var_0D = tablelookup("mp/CameraPositions.csv",0,var_00 + "_b",5);
		var_0E = tablelookup("mp/CameraPositions.csv",0,var_00 + "_b",6);
		var_0F = tablelookup("mp/CameraPositions.csv",0,var_00 + "_b",7);
		var_10 = tablelookup("mp/CameraPositions.csv",0,var_00 + "_b",8);
		level.camera5pos = getcameravecorang(var_09);
		level.camera5ang = getcameravecorang(var_0A);
		level.camera6pos = getcameravecorang(var_0B);
		level.camera6ang = getcameravecorang(var_0C);
		level.camera7pos = getcameravecorang(var_0D);
		level.camera7ang = getcameravecorang(var_0E);
		level.camera8pos = getcameravecorang(var_0F);
		level.camera8ang = getcameravecorang(var_10);
	}
}

//Function Number: 5
getcameravecorang(param_00)
{
	var_01 = strtok(param_00," ");
	var_02 = (castint(var_01[0]),castint(var_01[1]),castint(var_01[2]));
	return var_02;
}

//Function Number: 6
func_595D()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_00 thread func_5945();
		var_00 thread onjoinedspectators();
		var_00 thread func_5978();
		var_00 thread func_9372();
	}
}

//Function Number: 7
func_5945()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("joined_team");
		func_70D0();
		func_9452(0);
	}
}

//Function Number: 8
onjoinedspectators()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("joined_spectators");
		func_70D0();
		if(self setmlgcameradefaults() || isdefined(self.pers["mlgSpectator"]) && self.pers["mlgSpectator"])
		{
			self usemodelcollisionbounds(1);
			self setclientomnvar("ui_use_mlg_hud",1);
			func_9452(1);
		}
	}
}

//Function Number: 9
func_5978()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("spectating_cycle");
		var_00 = self getspectatingplayer();
		if(isdefined(var_00))
		{
		}
	}
}

//Function Number: 10
func_9372()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("luinotifyserver",var_00,var_01);
		if(var_00 == "mlg_view_change")
		{
			maps\mp\gametypes\_playerlogic::func_6622();
		}
	}
}

//Function Number: 11
func_8733()
{
	level endon("game_ended");
	for(var_00 = 0;var_00 < level.players.size;var_00++)
	{
		level.players[var_00] func_70D0();
	}
}

//Function Number: 12
func_70D0()
{
	var_00 = self.sessionteam;
	if(level.gameended && gettime() - level.gameendtime >= 2000)
	{
		if(level.multiteambased)
		{
			for(var_01 = 0;var_01 < level.teamnamelist.size;var_01++)
			{
				self allowspectateteam(level.teamnamelist[var_01],0);
			}
		}
		else
		{
			self allowspectateteam("allies",0);
			self allowspectateteam("axis",0);
		}

		self allowspectateteam("freelook",0);
		self allowspectateteam("none",1);
	}

	var_02 = maps\mp\gametypes\_tweakables::func_3C5B("game","spectatetype");
	if(self setmlgcameradefaults())
	{
		var_02 = 2;
	}

	if(maps\mp\_utility::bot_is_fireteam_mode())
	{
		var_02 = 1;
	}

	switch(var_02)
	{
		case 0:
			if(level.multiteambased)
			{
				for(var_01 = 0;var_01 < level.teamnamelist.size;var_01++)
				{
					self allowspectateteam(level.teamnamelist[var_01],0);
				}
			}
			else
			{
				self allowspectateteam("allies",0);
				self allowspectateteam("axis",0);
			}
	
			self allowspectateteam("freelook",0);
			self allowspectateteam("none",0);
			break;

		case 1:
			if(!level.teambased)
			{
				self allowspectateteam("allies",1);
				self allowspectateteam("axis",1);
				self allowspectateteam("none",1);
				self allowspectateteam("freelook",0);
			}
			else if(isdefined(var_00) && var_00 == "allies" || var_00 == "axis" && !level.multiteambased)
			{
				self allowspectateteam(var_00,1);
				self allowspectateteam(maps\mp\_utility::getotherteam(var_00),0);
				self allowspectateteam("freelook",0);
				self allowspectateteam("none",0);
			}
			else if(isdefined(var_00) && issubstr(var_00,"team_") && level.multiteambased)
			{
				for(var_01 = 0;var_01 < level.teamnamelist.size;var_01++)
				{
					if(var_00 == level.teamnamelist[var_01])
					{
						self allowspectateteam(level.teamnamelist[var_01],1);
						continue;
					}
	
					self allowspectateteam(level.teamnamelist[var_01],0);
				}
	
				self allowspectateteam("freelook",0);
				self allowspectateteam("none",0);
			}
			else
			{
				if(level.multiteambased)
				{
					for(var_01 = 0;var_01 < level.teamnamelist.size;var_01++)
					{
						self allowspectateteam(level.teamnamelist[var_01],0);
					}
				}
				else
				{
					self allowspectateteam("allies",0);
					self allowspectateteam("axis",0);
				}
	
				self allowspectateteam("freelook",0);
				self allowspectateteam("none",0);
			}
			break;

		case 2:
			if(level.multiteambased)
			{
				for(var_01 = 0;var_01 < level.teamnamelist.size;var_01++)
				{
					self allowspectateteam(level.teamnamelist[var_01],1);
				}
			}
			else
			{
				self allowspectateteam("allies",1);
				self allowspectateteam("axis",1);
			}
	
			self allowspectateteam("freelook",1);
			self allowspectateteam("none",1);
			break;
	}

	if(isdefined(var_00) && var_00 == "axis" || var_00 == "allies")
	{
		if(isdefined(level.spectateoverride[var_00].allowfreespectate))
		{
			self allowspectateteam("freelook",1);
		}

		if(isdefined(level.spectateoverride[var_00].allowenemyspectate))
		{
			self allowspectateteam(maps\mp\_utility::getotherteam(var_00),1);
		}
	}
}