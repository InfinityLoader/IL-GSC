/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\killstreaks\_emp.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 25
 * Decompile Time: 400 ms
 * Timestamp: 10/27/2023 1:32:26 AM
*******************************************************************/

//Function Number: 1
func_44DF()
{
}

//Function Number: 2
func_595D()
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
emp_use(param_00,param_01)
{
	var_02 = self.pers["team"];
	if(level.multiteambased)
	{
		thread func_2C7C(var_02);
	}
	else if(level.teambased)
	{
		var_03 = level.otherteam[var_02];
		thread func_2C7B(var_03);
	}
	else
	{
		thread emp_jamplayers(self);
	}

	maps\mp\_matchdata::func_4F1D("emp",self.origin);
	self notify("used_emp");
	return 1;
}

//Function Number: 5
func_2C7C(param_00)
{
	level endon("game_ended");
	thread maps\mp\_utility::func_7FA0("used_emp",self);
	level notify("EMP_JamTeam" + param_00);
	level endon("EMP_JamTeam" + param_00);
	foreach(var_02 in level.players)
	{
		var_02 playlocalsound("emp_activate");
		if(var_02.team == param_00)
		{
			continue;
		}

		if(var_02 maps\mp\_utility::_hasperk("specialty_localjammer"))
		{
			var_02 clearscrambler();
		}
	}

	visionsetnaked("coup_sunblind",0.1);
	thread empeffects();
	wait(0.1);
	visionsetnaked("coup_sunblind",0);
	visionsetnaked("",3);
	for(var_04 = 0;var_04 < level.teamnamelist.size;var_04++)
	{
		if(param_00 != level.teamnamelist[var_04])
		{
			level.teamemped[level.teamnamelist[var_04]] = 1;
		}
	}

	level notify("emp_update");
	for(var_04 = 0;var_04 < level.teamnamelist.size;var_04++)
	{
		if(param_00 != level.teamnamelist[var_04])
		{
			level func_2640(self,level.teamnamelist[var_04]);
		}
	}

	level thread func_4A9E();
	maps\mp\gametypes\_hostmigration::func_8B0D(level.emptimeout);
	for(var_04 = 0;var_04 < level.teamnamelist.size;var_04++)
	{
		if(param_00 != level.teamnamelist[var_04])
		{
			level.teamemped[level.teamnamelist[var_04]] = 0;
		}
	}

	foreach(var_02 in level.players)
	{
		if(var_02.team == param_00)
		{
			continue;
		}

		if(var_02 maps\mp\_utility::_hasperk("specialty_localjammer"))
		{
			var_02 makescrambler();
		}
	}

	level notify("emp_update");
}

//Function Number: 6
func_2C7B(param_00)
{
	level endon("game_ended");
	thread maps\mp\_utility::func_7FA0("used_emp",self);
	level notify("EMP_JamTeam" + param_00);
	level endon("EMP_JamTeam" + param_00);
	foreach(var_02 in level.players)
	{
		var_02 playlocalsound("emp_activate");
		if(var_02.team != param_00)
		{
			continue;
		}

		if(var_02 maps\mp\_utility::_hasperk("specialty_localjammer"))
		{
			var_02 clearscrambler();
		}

		var_02 visionsetnakedforplayer("coup_sunblind",0.1);
	}

	thread empeffects();
	wait(0.1);
	visionsetnaked("coup_sunblind",0);
	visionsetnaked("",3);
	level.teamemped[param_00] = 1;
	level notify("emp_update");
	level func_2640(self,param_00);
	level thread func_4A9E();
	maps\mp\gametypes\_hostmigration::func_8B0D(level.emptimeout);
	level.teamemped[param_00] = 0;
	foreach(var_02 in level.players)
	{
		if(var_02.team != param_00)
		{
			continue;
		}

		if(var_02 maps\mp\_utility::_hasperk("specialty_localjammer"))
		{
			var_02 makescrambler();
		}
	}

	level notify("emp_update");
}

//Function Number: 7
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

		if(var_02 maps\mp\_utility::_hasperk("specialty_localjammer"))
		{
			var_02 clearscrambler();
		}
	}

	visionsetnaked("coup_sunblind",0.1);
	thread empeffects();
	wait(0.1);
	visionsetnaked("coup_sunblind",0);
	visionsetnaked("",3);
	level notify("emp_update");
	level.empplayer = param_00;
	level.empplayer thread func_2C88();
	level func_2640(param_00);
	level notify("emp_update");
	level thread func_4A9E();
	maps\mp\gametypes\_hostmigration::func_8B0D(level.emptimeout);
	foreach(var_02 in level.players)
	{
		if(var_02 == param_00)
		{
			continue;
		}

		if(var_02 maps\mp\_utility::_hasperk("specialty_localjammer"))
		{
			var_02 makescrambler();
		}
	}

	level.empplayer = undefined;
	level notify("emp_update");
	level notify("emp_ended");
}

//Function Number: 8
func_4A9E()
{
	level notify("keepEMPTimeRemaining");
	level endon("keepEMPTimeRemaining");
	level endon("emp_ended");
	level.emptimeremaining = castint(level.emptimeout);
	while(level.emptimeremaining)
	{
		wait(1);
		level.emptimeremaining--;
	}
}

//Function Number: 9
func_2C88()
{
	level endon("EMP_JamPlayers");
	level endon("emp_ended");
	self waittill("disconnect");
	level notify("emp_update");
}

//Function Number: 10
empeffects()
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
		var_04 thread func_2C81(var_01);
	}
}

//Function Number: 11
func_2C81(param_00)
{
	param_00 endon("disconnect");
	wait(0.5);
	playfxontagforclients(level._effect["emp_flash"],self,"tag_origin",param_00);
}

//Function Number: 12
emp_teamtracker()
{
	level endon("game_ended");
	for(;;)
	{
		level common_scripts\utility::func_8B4F("joined_team","emp_update");
		foreach(var_01 in level.players)
		{
			if(var_01.team == "spectator")
			{
				continue;
			}

			if(!level.teamemped[var_01.team] && !var_01 maps\mp\_utility::func_48B2())
			{
				var_01 enablejammedeffect(0);
				continue;
			}

			var_01 enablejammedeffect(1);
		}
	}
}

//Function Number: 13
func_2C7D()
{
	level endon("game_ended");
	for(;;)
	{
		level common_scripts\utility::func_8B4F("joined_team","emp_update");
		foreach(var_01 in level.players)
		{
			if(var_01.team == "spectator")
			{
				continue;
			}

			if(isdefined(level.empplayer) && level.empplayer != var_01)
			{
				var_01 enablejammedeffect(1);
				continue;
			}

			if(!var_01 maps\mp\_utility::func_48B2())
			{
				var_01 enablejammedeffect(0);
			}
		}
	}
}

//Function Number: 14
func_2640(param_00,param_01)
{
	thread func_2639(param_00,param_01);
	thread destroyactivelittlebirds(param_00,param_01);
	thread destroyactiveturrets(param_00,param_01);
	thread destroyactiverockets(param_00,param_01);
	thread destroyactiveuavs(param_00,param_01);
	thread destroyactiveimss(param_00,param_01);
	thread destroyactiveugvs(param_00,param_01);
	thread func_2637(param_00,param_01);
	thread func_2638(param_00,param_01);
	thread func_265B(param_00,param_01,level.remote_uav);
	thread func_265B(param_00,param_01,level.uplinks);
}

//Function Number: 15
func_265B(param_00,param_01,param_02)
{
	var_03 = "MOD_EXPLOSIVE";
	var_04 = "killstreak_emp_mp";
	var_05 = 5000;
	var_06 = (0,0,0);
	var_07 = (0,0,0);
	var_08 = "";
	var_09 = "";
	var_0A = "";
	var_0B = undefined;
	foreach(var_0D in param_02)
	{
		if(level.teambased && isdefined(param_01))
		{
			if(isdefined(var_0D.team) && var_0D.team != param_01)
			{
				continue;
			}
		}
		else if(isdefined(var_0D.owner) && var_0D.owner == param_00)
		{
			continue;
		}

		var_0D notify("damage",var_05,param_00,var_06,var_07,var_03,var_08,var_09,var_0A,var_0B,var_04);
		wait(0.05);
	}
}

//Function Number: 16
func_2639(param_00,param_01)
{
	func_265B(param_00,param_01,level.helis);
}

//Function Number: 17
destroyactivelittlebirds(param_00,param_01)
{
	func_265B(param_00,param_01,level.littlebirds);
}

//Function Number: 18
destroyactiveturrets(param_00,param_01)
{
	func_265B(param_00,param_01,level.turrets);
}

//Function Number: 19
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
		wait(0.05);
	}
}

//Function Number: 20
destroyactiveuavs(param_00,param_01)
{
	var_02 = level.uavmodels;
	if(level.teambased && isdefined(param_01))
	{
		var_02 = level.uavmodels[param_01];
	}

	func_265B(param_00,param_01,var_02);
}

//Function Number: 21
destroyactiveimss(param_00,param_01)
{
	func_265B(param_00,param_01,level.ims);
}

//Function Number: 22
destroyactiveugvs(param_00,param_01)
{
	func_265B(param_00,param_01,level.ugvs);
}

//Function Number: 23
func_2637(param_00,param_01)
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
		}
	}

	if(isdefined(level.ac130player))
	{
		if(!isdefined(level.ac130.owner) || isdefined(level.ac130.owner) && level.ac130.owner != param_00)
		{
			level.ac130.planemodel notify("damage",var_04,param_00,var_05,var_06,var_02,var_07,var_08,var_09,var_0A,var_03);
		}
	}
}

//Function Number: 24
func_2638(param_00,param_01)
{
	func_265B(param_00,param_01,level.balldrones);
}

//Function Number: 25
enablejammedeffect(param_00)
{
	self setempjammed(param_00);
	var_01 = 0;
	if(param_00)
	{
		var_01 = 1;
	}

	thread lib_05FE::func_7AD1();
}