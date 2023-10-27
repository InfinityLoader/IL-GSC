/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\_spectating.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 20
 * Decompile Time: 799 ms
 * Timestamp: 10/27/2023 12:21:38 AM
*******************************************************************/

//Function Number: 1
init()
{
	level.var_10978["allies"] = spawnstruct();
	level.var_10978["axis"] = spawnstruct();
	level thread func_C56E();
	if(getdvarint("cg_mlg_static_cameras",0) != 0)
	{
		level thread func_7F6C();
	}
}

//Function Number: 2
func_49F0(param_00,param_01)
{
	precacheshader(param_00);
	var_02 = spawn("script_model",(0,0,0));
	var_02 setmodel("tag_origin");
	var_02.angles = (0,0,0);
	return var_02;
}

//Function Number: 3
func_F780(param_00,param_01)
{
	var_02 = param_00;
	if(var_02 >= 4)
	{
		var_02 = var_02 - 4;
	}

	var_03 = tolower(getdvar("mapname"));
	var_04 = tablelookup(param_01,0,var_03,var_02 * 2 + 1);
	if(var_04 != "")
	{
		var_05 = param_00 + 1;
		if(param_00 >= 5)
		{
			var_05 = var_05 - 4;
		}

		level.var_37C3[param_00] = func_49F0("compass_icon_codcaster_cam",1);
		level.var_C215[param_00] = func_49F0("compass_icon_codcaster_num" + var_05,0);
		var_06 = tablelookup(param_01,0,var_03,var_02 * 2 + 2);
		level.var_37C8[param_00] = func_7E16(var_04);
		level.var_37C1[param_00] = func_7E16(var_06);
		level.camerahighestindex = param_00;
	}
}

//Function Number: 4
func_7F6C()
{
	while(!isdefined(level.objidpool))
	{
		wait(0.05);
	}

	var_00 = "mp/CameraPositions";
	var_01 = var_00 + "_" + level.gametype + ".csv";
	var_00 = var_00 + ".csv";
	level.var_37C3 = [];
	level.var_C215 = [];
	for(var_02 = 0;var_02 < 4;var_02++)
	{
		func_F780(var_02,var_00);
	}

	for(var_02 = 4;var_02 < 8;var_02++)
	{
		func_F780(var_02,var_01);
	}
}

//Function Number: 5
func_7E16(param_00)
{
	var_01 = strtok(param_00," ");
	var_02 = (0,0,0);
	if(isdefined(var_01[0]) && isdefined(var_01[1]) && isdefined(var_01[2]))
	{
		var_02 = (int(var_01[0]),int(var_01[1]),int(var_01[2]));
	}

	return var_02;
}

//Function Number: 6
func_C56E()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_00 thread func_C541();
		var_00 thread func_C540();
		var_00 thread func_C5A1();
		var_00 thread func_C531();
		var_00 thread func_C5A2();
	}
}

//Function Number: 7
func_C541()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("joined_team");
		func_F857();
	}
}

//Function Number: 8
func_C540()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("joined_spectators");
		func_F857();
		self setclientomnvar("ui_callout_area_id",-1);
		if(self ismlgspectator() || isdefined(self.pers["mlgSpectator"]) && self.pers["mlgSpectator"])
		{
			self method_830E(1);
			self setclientomnvar("ui_use_mlg_hud",1);
			self method_85B1(0);
			thread updatemlgspectator();
			thread autoattachtoplayer();
		}
	}
}

//Function Number: 9
func_C5A1()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("spectating_cycle");
		var_00 = self method_815D();
		if(self ismlgspectator() || isdefined(var_00))
		{
			var_01 = level.var_377C.var_2138[var_00.var_3779];
			self setclientomnvar("ui_callout_area_id",var_01);
			if(level.gametype == "ball")
			{
				scripts\mp\gametypes\ball::func_2796(self);
			}
		}
	}
}

//Function Number: 10
func_C5A2()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("spectating_mlg_camera");
		var_00 = self method_858E();
		if(self ismlgspectator() || isdefined(self.pers["mlgSpectator"]) && self.pers["mlgSpectator"])
		{
			if(isdefined(var_00))
			{
				self setclientomnvar("ui_callout_area_id",-1);
				continue;
			}
		}
	}
}

//Function Number: 11
func_C531()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("luinotifyserver",var_00,var_01);
		if(var_00 == "mlg_view_change")
		{
			scripts\mp\_playerlogic::func_E27B();
		}
	}
}

//Function Number: 12
func_12F21()
{
	level endon("game_ended");
	for(var_00 = 0;var_00 < level.players.size;var_00++)
	{
		level.players[var_00] func_F857();
	}
}

//Function Number: 13
linkcameratoball(param_00)
{
	self endon("disconnect");
	self endon("joined_team");
	self endon("joined_spectators");
	for(;;)
	{
		if(!isdefined(self.codcasterballcamfollow))
		{
			break;
		}

		if(self method_85AF())
		{
			wait(0.05);
			continue;
		}

		self cameralinkto(self.codcasterballcamfollow,"tag_origin",1);
		var_01 = level.codcasterball.origin;
		var_02 = (0,0,30);
		var_02 = var_02 + -80 * param_00;
		var_03 = var_01 + var_02;
		self.codcasterballcamfollow moveto(var_03,10.5,5.2,5.2);
		self.codcasterballcamfollow.angles = vectortoangles(param_00);
		break;
	}
}

//Function Number: 14
autoattachtoplayer()
{
	self endon("disconnect");
	self endon("game_ended");
	self endon("joined_team");
	self endon("joined_spectator");
	self endon("spectating_mlg_camera");
	for(;;)
	{
		wait(1);
		var_00 = undefined;
		if(!self ismlgspectator() || self method_85AF())
		{
			break;
		}

		if(level.players.size > 1)
		{
			var_01 = scripts\mp\_utility::func_81A0("allies",0);
			if(var_01.size > 0)
			{
				var_00 = scripts\mp\_utility::getlowestclientnum(var_01,1);
			}

			if(!isdefined(var_00))
			{
				var_01 = scripts\mp\_utility::func_81A0("axis",0);
				if(var_01.size > 0)
				{
					var_00 = scripts\mp\_utility::getlowestclientnum(var_01,1);
				}
			}

			if(isdefined(var_00))
			{
				self method_85B0(var_00);
				break;
			}
		}
	}
}

//Function Number: 15
updatemlgspectator()
{
	self endon("joined_team");
	self endon("disconnect");
	self.iswatchingcodcasterball = 0;
	self.codcasterballcamfollow = undefined;
	self.spectatingplayerbeforeballcam = undefined;
	for(;;)
	{
		var_00 = isdefined(level.codcasterball);
		if(!var_00 || !self method_85B2())
		{
			if(self.iswatchingcodcasterball)
			{
				self.iswatchingcodcasterball = 0;
				self.codcasterballcamfollow unlink();
				self.codcasterballcamfollow delete();
				self.codcasterballcamfollow = undefined;
				if(!self method_85AF() && isdefined(self.spectatingplayerbeforeballcam))
				{
					self method_85B0(self.spectatingplayerbeforeballcam getentitynumber());
				}
				else
				{
					self cameraunlink();
				}

				self.spectatingplayerbeforeballcam = undefined;
			}
		}
		else if(!self.iswatchingcodcasterball)
		{
			if(self method_85B2())
			{
				var_01 = self method_815D();
				if(isdefined(var_01) && isdefined(level.codcasterballowner) && var_01 == level.codcasterballowner)
				{
					self.iswatchingcodcasterball = 1;
					self.spectatingplayerbeforeballcam = var_01;
					var_02 = vectornormalize(level.codcasterballinitialforcevector);
					var_03 = var_01 method_816E();
					self.codcasterballcamfollow = spawn("script_model",var_03);
					self.codcasterballcamfollow.angles = vectortoangles(var_02);
					self.codcasterballcamfollow setmodel("tag_origin");
					function_0321(self getentitynumber());
					self cameraunlink();
					thread linkcameratoball(var_02);
				}
			}
		}
		else if(isdefined(self.codcasterballcamfollow))
		{
			var_04 = level.codcasterball.origin;
			var_05 = self.codcasterballcamfollow.origin;
			var_06 = distance2d(var_04,var_05);
			var_07 = var_04 - var_05;
			var_08 = (var_07[0],var_07[1],0);
			var_08 = vectornormalize(var_08);
			var_09 = var_04;
			var_0A = (0,0,30);
			var_0A = var_0A + -80 * var_08;
			var_0B = var_09 + var_0A;
			if(var_06 > 600)
			{
				self.codcasterballcamfollow.origin = var_0B;
			}
			else
			{
				self.codcasterballcamfollow moveto(var_0B,0.5,0,0.2);
			}

			self.codcasterballcamfollow rotateto(vectortoangles(var_07),0.15,0.05,0.05);
		}

		wait(0.05);
	}
}

//Function Number: 16
func_F857()
{
	if(level.var_7669 && gettime() - level.var_766B >= 2000)
	{
		if(level.multiteambased)
		{
			for(var_00 = 0;var_00 < level.teamnamelist.size;var_00++)
			{
				self allowspectateteam(level.teamnamelist[var_00],0);
			}
		}
		else
		{
			self allowspectateteam("allies",0);
			self allowspectateteam("axis",0);
		}

		self allowspectateteam("freelook",0);
		self allowspectateteam("none",1);
		return;
	}

	var_01 = scripts\mp\_tweakables::func_81E7("game","spectatetype");
	if(self ismlgspectator())
	{
		var_01 = 2;
	}

	if(scripts\mp\_utility::func_2DD9())
	{
		var_01 = 1;
	}

	var_02 = self.sessionteam;
	switch(var_01)
	{
		case 0:
			func_F6C5();
			break;

		case 1:
			self notify("waitForGameStartSpectate");
			if(var_02 != "spectator")
			{
				func_F87A(var_02);
			}
			else if(isdefined(self.pers["last_team"]))
			{
				var_02 = self.pers["last_team"];
				func_F87A(var_02);
			}
			else if(scripts\mp\_utility::func_766C("prematch_done"))
			{
				if(randomint(2))
				{
					var_02 = "allies";
				}
				else
				{
					var_02 = "axis";
				}
	
				func_F87A(var_02);
			}
			else
			{
				thread waitforgamestartspectate();
				return;
			}
			break;

		case 2:
			func_F71A();
			break;

		case 3:
			if(var_02 == "spectator")
			{
				func_F71A();
			}
			else
			{
				func_F87A(var_02);
			}
			break;
	}

	if(isdefined(var_02) && var_02 == "axis" || var_02 == "allies")
	{
		if(isdefined(level.var_10978[var_02].var_1C93))
		{
			self allowspectateteam("freelook",1);
		}

		if(isdefined(level.var_10978[var_02].var_1C90))
		{
			self allowspectateteam(scripts\mp\_utility::getotherteam(var_02),1);
		}
	}
}

//Function Number: 17
waitforgamestartspectate()
{
	self endon("waitForGameStartSpectate");
	level waittill("prematch_over");
	thread func_F857();
}

//Function Number: 18
func_F6C5()
{
	if(level.multiteambased)
	{
		for(var_00 = 0;var_00 < level.teamnamelist.size;var_00++)
		{
			self allowspectateteam(level.teamnamelist[var_00],0);
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

//Function Number: 19
func_F87A(param_00)
{
	if(!level.teambased)
	{
		self allowspectateteam("allies",1);
		self allowspectateteam("axis",1);
		self allowspectateteam("none",1);
		self allowspectateteam("freelook",0);
		return;
	}

	if(isdefined(param_00) && param_00 == "allies" || param_00 == "axis" && !level.multiteambased)
	{
		self allowspectateteam(param_00,1);
		self allowspectateteam(scripts\mp\_utility::getotherteam(param_00),0);
		self allowspectateteam("freelook",0);
		self allowspectateteam("none",0);
		return;
	}

	if(isdefined(param_00) && issubstr(param_00,"team_") && level.multiteambased)
	{
		for(var_01 = 0;var_01 < level.teamnamelist.size;var_01++)
		{
			if(param_00 == level.teamnamelist[var_01])
			{
				self allowspectateteam(level.teamnamelist[var_01],1);
				continue;
			}

			self allowspectateteam(level.teamnamelist[var_01],0);
		}

		self allowspectateteam("freelook",0);
		self allowspectateteam("none",0);
		return;
	}

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

//Function Number: 20
func_F71A()
{
	if(level.multiteambased)
	{
		for(var_00 = 0;var_00 < level.teamnamelist.size;var_00++)
		{
			self allowspectateteam(level.teamnamelist[var_00],1);
		}
	}
	else
	{
		self allowspectateteam("allies",1);
		self allowspectateteam("axis",1);
	}

	self allowspectateteam("freelook",1);
	self allowspectateteam("none",1);
}