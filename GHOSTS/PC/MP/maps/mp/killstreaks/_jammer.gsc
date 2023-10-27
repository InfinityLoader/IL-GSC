/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\killstreaks\_jammer.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 10
 * Decompile Time: 187 ms
 * Timestamp: 10/27/2023 1:21:05 AM
*******************************************************************/

//Function Number: 1
func_44DF()
{
	level.teamemped["allies"] = 0;
	level.teamemped["axis"] = 0;
	level.empplayer = undefined;
	level.emptimeout = 10;
	level.emptimeremaining = int(level.emptimeout);
	level.killstreakfuncs["jammer"] = ::emp_use;
	level thread func_595D();
}

//Function Number: 2
func_595D()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_00 thread onplayerkilled();
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
		if(lib_05FE::func_74B9())
		{
			lib_05FE::applyperplayerempeffects();
		}
	}
}

//Function Number: 4
onplayerkilled()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("death");
		lib_05FE::func_7C5E();
	}
}

//Function Number: 5
emp_use(param_00,param_01)
{
	var_02 = self.pers["team"];
	if(level.teambased)
	{
		var_03 = level.otherteam[var_02];
		thread func_2C7B(var_03);
	}
	else
	{
		thread emp_jamplayers(self);
	}

	maps\mp\_matchdata::func_4F1D("jammer",self.origin);
	self notify("used_emp");
	level notify("emp_used");
	return 1;
}

//Function Number: 6
func_2C7B(param_00)
{
	level endon("game_ended");
	wait(0.5);
	thread maps\mp\_utility::func_7FA0("used_jammer",self);
	level notify("EMP_JamTeam" + param_00);
	level endon("EMP_JamTeam" + param_00);
	level.teamemped[param_00] = 1;
	foreach(var_02 in level.players)
	{
		var_02 lib_05FE::applyperplayerempeffects_ondetonate();
		if(var_02 lib_05FE::func_74B9())
		{
			var_02 lib_05FE::applyperplayerempeffects();
		}
	}

	level thread lib_05FE::applyglobalempeffects();
	level notify("emp_update");
	level func_2654(self,param_00);
	level thread func_4A9E();
	maps\mp\gametypes\_hostmigration::func_8B0D(level.emptimeout);
	level.teamemped[param_00] = 0;
	foreach(var_02 in level.players)
	{
		if(var_02.team == param_00 && !var_02 lib_05FE::func_74B9())
		{
			var_02 lib_05FE::func_65A7();
		}
	}

	level notify("emp_update");
}

//Function Number: 7
emp_jamplayers(param_00)
{
	level notify("EMP_JamPlayers");
	level endon("EMP_JamPlayers");
	wait(0.5);
	if(!isdefined(param_00))
	{
	}

	level.empplayer = param_00;
	foreach(var_02 in level.players)
	{
		var_02 lib_05FE::applyperplayerempeffects_ondetonate();
		if(var_02 lib_05FE::func_74B9())
		{
			var_02 lib_05FE::applyperplayerempeffects();
		}
	}

	level thread lib_05FE::applyglobalempeffects();
	level notify("emp_update");
	level.empplayer thread func_2C88();
	level func_2654(param_00);
	level thread func_4A9E();
	maps\mp\gametypes\_hostmigration::func_8B0D(level.emptimeout);
	level.empplayer = undefined;
	foreach(var_02 in level.players)
	{
		if((!isdefined(param_00) || var_02 != param_00) && !var_02 lib_05FE::func_74B9())
		{
			var_02 lib_05FE::func_65A7();
		}
	}

	level notify("emp_update");
	level notify("emp_ended");
}

//Function Number: 8
func_4A9E()
{
	level notify("keepEMPTimeRemaining");
	level endon("keepEMPTimeRemaining");
	level endon("emp_ended");
	level.emptimeremaining = int(level.emptimeout);
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
func_2654(param_00,param_01)
{
	maps\mp\killstreaks\_killstreaks::destroytargetarray(param_00,param_01,"killstreak_emp_mp",level.turrets);
	maps\mp\killstreaks\_killstreaks::destroytargetarray(param_00,param_01,"killstreak_emp_mp",level.placedims);
	maps\mp\killstreaks\_killstreaks::destroytargetarray(param_00,param_01,"killstreak_emp_mp",level.balldrones);
	thread maps\mp\killstreaks\_killstreaks::destroytargetarray(param_00,param_01,"killstreak_emp_mp",level.uplinks);
	maps\mp\killstreaks\_killstreaks::destroytargetarray(param_00,param_01,"killstreak_emp_mp",level.mines);
}