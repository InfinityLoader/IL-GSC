/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\killstreaks\_emp.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 21
 * Decompile Time: 356 ms
 * Timestamp: 10/27/2023 2:26:47 AM
*******************************************************************/

//Function Number: 1
init()
{
	level._effect["emp_flash"] = loadfx("explosions/emp_flash_mp");
	level.teamemped["allies"] = 0;
	level.teamemped["axis"] = 0;
	level.empplayer = undefined;
	level.emptimeout = 60;
	level.emptimeremaining = int(level.emptimeout);
	if(level.teambased)
	{
		level thread func_30E6();
	}
	else
	{
		level thread func_30E7();
	}

	level.killstreakfuncs["emp"] = ::func_30E0;
	level thread onplayerconnect();
}

//Function Number: 2
onplayerconnect()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_00 thread onplayerspawned();
	}
}

//Function Number: 3
onplayerspawned()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("spawned_player");
		if((level.teambased && level.teamemped[self.team]) || !level.teambased && isdefined(level.empplayer) && level.empplayer != self)
		{
			self setempjammed(1);
		}
	}
}

//Function Number: 4
func_30E0(param_00)
{
	if(!maps\mp\_utility::func_2DF3())
	{
		return 0;
	}

	var_01 = self.pers["team"];
	var_02 = level.otherteam[var_01];
	if(level.teambased)
	{
		thread emp_jamteam(var_02);
	}
	else
	{
		thread emp_jamplayers(self);
	}

	maps\mp\_matchdata::logkillstreakevent("emp",self.origin);
	self notify("used_emp");
	return 1;
}

//Function Number: 5
emp_jamteam(param_00)
{
	level endon("game_ended");
	thread maps\mp\_utility::teamplayercardsplash("used_emp",self);
	level notify("EMP_JamTeam" + param_00);
	level endon("EMP_JamTeam" + param_00);
	foreach(var_02 in level.players)
	{
		var_02 playlocalsound("emp_activate");
		if(var_02.team != param_00)
		{
			continue;
		}

		if(var_02 maps\mp\_utility::func_27AF("specialty_localjammer"))
		{
			var_02 radarjamoff();
		}
	}

	visionsetnaked("coup_sunblind",0.1);
	thread func_30E4();
	wait 0.1;
	visionsetnaked("coup_sunblind",0);
	if(isdefined(level.nukedetonated))
	{
		visionsetnaked(level.nukevisionset,3);
	}
	else
	{
		visionsetnaked("",3);
	}

	level.teamemped[param_00] = 1;
	level notify("emp_update");
	level func_30E8(self,param_00);
	level thread func_80F9();
	maps\mp\gametypes\_hostmigration::func_2740(level.emptimeout);
	level.teamemped[param_00] = 0;
	foreach(var_02 in level.players)
	{
		if(var_02.team != param_00)
		{
			continue;
		}

		if(var_02 maps\mp\_utility::func_27AF("specialty_localjammer"))
		{
			var_02 radarjamon();
		}
	}

	level notify("emp_update");
}

//Function Number: 6
emp_jamplayers(param_00)
{
	level notify("EMP_JamPlayers");
	level endon("EMP_JamPlayers");
	foreach(var_02 in level.players)
	{
		var_02 playlocalsound("emp_activate");
		if(var_02 == param_00)
		{
			continue;
		}

		if(var_02 maps\mp\_utility::func_27AF("specialty_localjammer"))
		{
			var_02 radarjamoff();
		}
	}

	visionsetnaked("coup_sunblind",0.1);
	thread func_30E4();
	wait 0.1;
	visionsetnaked("coup_sunblind",0);
	if(isdefined(level.nukedetonated))
	{
		visionsetnaked(level.nukevisionset,3);
	}
	else
	{
		visionsetnaked("",3);
	}

	level notify("emp_update");
	level.empplayer = param_00;
	level.empplayer thread func_30E3();
	level func_30E8(param_00);
	level notify("emp_update");
	level thread func_80F9();
	maps\mp\gametypes\_hostmigration::func_2740(level.emptimeout);
	foreach(var_02 in level.players)
	{
		if(var_02 == param_00)
		{
			continue;
		}

		if(var_02 maps\mp\_utility::func_27AF("specialty_localjammer"))
		{
			var_02 radarjamon();
		}
	}

	level.empplayer = undefined;
	level notify("emp_update");
	level notify("emp_ended");
}

//Function Number: 7
func_80F9()
{
	level notify("keepEMPTimeRemaining");
	level endon("keepEMPTimeRemaining");
	level endon("emp_ended");
	level.emptimeremaining = int(level.emptimeout);
	while(level.emptimeremaining)
	{
		wait 1;
		level.emptimeremaining--;
	}
}

//Function Number: 8
func_30E3()
{
	level endon("EMP_JamPlayers");
	level endon("emp_ended");
	self waittill("disconnect");
	level notify("emp_update");
}

//Function Number: 9
func_30E4()
{
	foreach(var_01 in level.players)
	{
		var_02 = anglestoforward(var_01.angles);
		var_02 = (var_02[0],var_02[1],0);
		var_02 = vectornormalize(var_02);
		var_03 = 20000;
		var_04 = spawn("script_model",var_01.origin + (0,0,8000) + var_02 * var_03);
		var_04 setmodel("tag_origin");
		var_04.angles = var_04.angles + (270,0,0);
		var_04 thread empeffect(var_01);
	}
}

//Function Number: 10
empeffect(param_00)
{
	param_00 endon("disconnect");
	wait 0.5;
	playfxontagforclients(level._effect["emp_flash"],self,"tag_origin",param_00);
}

//Function Number: 11
func_30E6()
{
	level endon("game_ended");
	for(;;)
	{
		level common_scripts\utility::waittill_either("joined_team","emp_update");
		foreach(var_01 in level.players)
		{
			if(var_01.team == "spectator")
			{
				continue;
			}

			if(!level.teamemped[var_01.team] && !var_01 maps\mp\_utility::func_27E5())
			{
				var_01 setempjammed(0);
				continue;
			}

			var_01 setempjammed(1);
		}
	}
}

//Function Number: 12
func_30E7()
{
	level endon("game_ended");
	for(;;)
	{
		level common_scripts\utility::waittill_either("joined_team","emp_update");
		foreach(var_01 in level.players)
		{
			if(var_01.team == "spectator")
			{
				continue;
			}

			if(isdefined(level.empplayer) && level.empplayer != var_01)
			{
				var_01 setempjammed(1);
				continue;
			}

			if(!var_01 maps\mp\_utility::func_27E5())
			{
				var_01 setempjammed(0);
			}
		}
	}
}

//Function Number: 13
func_30E8(param_00,param_01)
{
	thread destroyactivehelis(param_00,param_01);
	thread destroyactivelittlebirds(param_00,param_01);
	thread destroyactiveturrets(param_00,param_01);
	thread destroyactiverockets(param_00,param_01);
	thread destroyactiveuavs(param_00,param_01);
	thread destroyactiveimss(param_00,param_01);
	thread destroyactiveugvs(param_00,param_01);
	thread destroyactiveac130(param_00,param_01);
}

//Function Number: 14
destroyactivehelis(param_00,param_01)
{
	var_02 = "MOD_EXPLOSIVE";
	var_03 = "killstreak_emp_mp";
	var_04 = 5000;
	var_05 = (0,0,0);
	var_06 = (0,0,0);
	var_07 = "";
	var_08 = "";
	var_09 = "";
	var_0A = undefined;
	foreach(var_0C in level.helis)
	{
		if(level.teambased && isdefined(param_01))
		{
			if(isdefined(var_0C.team) && var_0C.team != param_01)
			{
				continue;
			}
		}
		else if(isdefined(var_0C.owner) && var_0C.owner == param_00)
		{
			continue;
		}

		var_0C notify("damage",var_04,param_00,var_05,var_06,var_02,var_07,var_08,var_09,var_0A,var_03);
		wait 0.05;
	}
}

//Function Number: 15
destroyactivelittlebirds(param_00,param_01)
{
	var_02 = "MOD_EXPLOSIVE";
	var_03 = "killstreak_emp_mp";
	var_04 = 5000;
	var_05 = (0,0,0);
	var_06 = (0,0,0);
	var_07 = "";
	var_08 = "";
	var_09 = "";
	var_0A = undefined;
	foreach(var_0C in level.littlebirds)
	{
		if(level.teambased && isdefined(param_01))
		{
			if(isdefined(var_0C.team) && var_0C.team != param_01)
			{
				continue;
			}
		}
		else if(isdefined(var_0C.owner) && var_0C.owner == param_00)
		{
			continue;
		}

		var_0C notify("damage",var_04,param_00,var_05,var_06,var_02,var_07,var_08,var_09,var_0A,var_03);
		wait 0.05;
	}
}

//Function Number: 16
destroyactiveturrets(param_00,param_01)
{
	var_02 = "MOD_EXPLOSIVE";
	var_03 = "killstreak_emp_mp";
	var_04 = 5000;
	var_05 = (0,0,0);
	var_06 = (0,0,0);
	var_07 = "";
	var_08 = "";
	var_09 = "";
	var_0A = undefined;
	foreach(var_0C in level.turrets)
	{
		if(level.teambased && isdefined(param_01))
		{
			if(isdefined(var_0C.team) && var_0C.team != param_01)
			{
				continue;
			}
		}
		else if(isdefined(var_0C.owner) && var_0C.owner == param_00)
		{
			continue;
		}

		var_0C notify("damage",var_04,param_00,var_05,var_06,var_02,var_07,var_08,var_09,var_0A,var_03);
		wait 0.05;
	}
}

//Function Number: 17
destroyactiverockets(param_00,param_01)
{
	var_02 = "MOD_EXPLOSIVE";
	var_03 = "killstreak_emp_mp";
	var_04 = 5000;
	var_05 = (0,0,0);
	var_06 = (0,0,0);
	var_07 = "";
	var_08 = "";
	var_09 = "";
	var_0A = undefined;
	foreach(var_0C in level.rockets)
	{
		if(level.teambased && isdefined(param_01))
		{
			if(isdefined(var_0C.team) && var_0C.team != param_01)
			{
				continue;
			}
		}
		else if(isdefined(var_0C.owner) && var_0C.owner == param_00)
		{
			continue;
		}

		playfx(level.remotemissile_fx["explode"],var_0C.origin);
		var_0C delete();
		wait 0.05;
	}
}

//Function Number: 18
destroyactiveuavs(param_00,param_01)
{
	var_02 = "MOD_EXPLOSIVE";
	var_03 = "killstreak_emp_mp";
	var_04 = 5000;
	var_05 = (0,0,0);
	var_06 = (0,0,0);
	var_07 = "";
	var_08 = "";
	var_09 = "";
	var_0A = undefined;
	var_0B = level.uavmodels;
	if(level.teambased && isdefined(param_01))
	{
		var_0B = level.uavmodels[param_01];
	}

	foreach(var_0D in var_0B)
	{
		if(level.teambased && isdefined(param_01))
		{
		}
		else if(isdefined(var_0D.owner) && var_0D.owner == param_00)
		{
			continue;
		}

		var_0D notify("damage",var_04,param_00,var_05,var_06,var_02,var_07,var_08,var_09,var_0A,var_03);
		wait 0.05;
	}
}

//Function Number: 19
destroyactiveimss(param_00,param_01)
{
	var_02 = "MOD_EXPLOSIVE";
	var_03 = "killstreak_emp_mp";
	var_04 = 5000;
	var_05 = (0,0,0);
	var_06 = (0,0,0);
	var_07 = "";
	var_08 = "";
	var_09 = "";
	var_0A = undefined;
	foreach(var_0C in level.ims)
	{
		if(level.teambased && isdefined(param_01))
		{
			if(isdefined(var_0C.team) && var_0C.team != param_01)
			{
				continue;
			}
		}
		else if(isdefined(var_0C.owner) && var_0C.owner == param_00)
		{
			continue;
		}

		var_0C notify("damage",var_04,param_00,var_05,var_06,var_02,var_07,var_08,var_09,var_0A,var_03);
		wait 0.05;
	}
}

//Function Number: 20
destroyactiveugvs(param_00,param_01)
{
	var_02 = "MOD_EXPLOSIVE";
	var_03 = "killstreak_emp_mp";
	var_04 = 5000;
	var_05 = (0,0,0);
	var_06 = (0,0,0);
	var_07 = "";
	var_08 = "";
	var_09 = "";
	var_0A = undefined;
	foreach(var_0C in level.ugvs)
	{
		if(level.teambased && isdefined(param_01))
		{
			if(isdefined(var_0C.team) && var_0C.team != param_01)
			{
				continue;
			}
		}
		else if(isdefined(var_0C.owner) && var_0C.owner == param_00)
		{
			continue;
		}

		var_0C notify("damage",var_04,param_00,var_05,var_06,var_02,var_07,var_08,var_09,var_0A,var_03);
		wait 0.05;
	}
}

//Function Number: 21
destroyactiveac130(param_00,param_01)
{
	var_02 = "MOD_EXPLOSIVE";
	var_03 = "killstreak_emp_mp";
	var_04 = 5000;
	var_05 = (0,0,0);
	var_06 = (0,0,0);
	var_07 = "";
	var_08 = "";
	var_09 = "";
	var_0A = undefined;
	if(level.teambased && isdefined(param_01))
	{
		if(isdefined(level.ac130player) && isdefined(level.ac130player.team) && level.ac130player.team == param_01)
		{
			level.ac130.planemodel notify("damage",var_04,param_00,var_05,var_06,var_02,var_07,var_08,var_09,var_0A,var_03);
			return;
		}

		return;
	}

	if(isdefined(level.ac130player))
	{
		if(!isdefined(level.ac130.owner) || isdefined(level.ac130.owner) && level.ac130.owner != param_00)
		{
			level.ac130.planemodel notify("damage",var_04,param_00,var_05,var_06,var_02,var_07,var_08,var_09,var_0A,var_03);
			return;
		}
	}
}