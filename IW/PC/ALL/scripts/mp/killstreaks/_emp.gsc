/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\killstreaks\_emp.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 25
 * Decompile Time: 1152 ms
 * Timestamp: 10/27/2023 12:28:28 AM
*******************************************************************/

//Function Number: 1
init()
{
}

//Function Number: 2
func_C56E()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_00 thread func_C57B();
	}
}

//Function Number: 3
func_C57B()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("spawned_player");
		if((level.teambased && level.var_115C9[self.team]) || !level.teambased && isdefined(level.var_61AD) && level.var_61AD != self)
		{
			self method_82DA(1);
		}
	}
}

//Function Number: 4
func_618B(param_00,param_01)
{
	var_02 = self.pers["team"];
	if(level.multiteambased)
	{
		thread func_6166(var_02);
	}
	else if(level.teambased)
	{
		var_03 = level.var_C74B[var_02];
		thread func_6165(var_03);
	}
	else
	{
		thread func_6164(self);
	}

	scripts\mp\_matchdata::func_AFC9("emp",self.origin);
	self notify("used_emp");
	return 1;
}

//Function Number: 5
func_6166(param_00)
{
	level endon("game_ended");
	thread scripts\mp\_utility::func_115DE("used_emp",self);
	level notify("EMP_JamTeam" + param_00);
	level endon("EMP_JamTeam" + param_00);
	foreach(var_02 in level.players)
	{
		var_02 playlocalsound("emp_activate");
		if(var_02.team == param_00)
		{
			continue;
		}

		if(var_02 scripts\mp\_utility::_hasperk("specialty_localjammer"))
		{
			var_02 method_807C();
		}
	}

	function_0237("coup_sunblind",0.1);
	thread func_619F();
	wait(0.1);
	function_0237("coup_sunblind",0);
	function_0237("",3);
	for(var_04 = 0;var_04 < level.teamnamelist.size;var_04++)
	{
		if(param_00 != level.teamnamelist[var_04])
		{
			level.var_115C9[level.teamnamelist[var_04]] = 1;
		}
	}

	level notify("emp_update");
	for(var_04 = 0;var_04 < level.teamnamelist.size;var_04++)
	{
		if(param_00 != level.teamnamelist[var_04])
		{
			level func_52CA(self,level.teamnamelist[var_04]);
		}
	}

	level thread func_A577();
	scripts\mp\_hostmigration::func_13708(level.var_61B5);
	for(var_04 = 0;var_04 < level.teamnamelist.size;var_04++)
	{
		if(param_00 != level.teamnamelist[var_04])
		{
			level.var_115C9[level.teamnamelist[var_04]] = 0;
		}
	}

	foreach(var_02 in level.players)
	{
		if(var_02.team == param_00)
		{
			continue;
		}

		if(var_02 scripts\mp\_utility::_hasperk("specialty_localjammer"))
		{
			var_02 method_81F4();
		}
	}

	level notify("emp_update");
}

//Function Number: 6
func_6165(param_00)
{
	level endon("game_ended");
	thread scripts\mp\_utility::func_115DE("used_emp",self);
	level notify("EMP_JamTeam" + param_00);
	level endon("EMP_JamTeam" + param_00);
	foreach(var_02 in level.players)
	{
		var_02 playlocalsound("emp_activate");
		if(var_02.team != param_00)
		{
			continue;
		}

		if(var_02 scripts\mp\_utility::_hasperk("specialty_localjammer"))
		{
			var_02 method_807C();
		}

		var_02 visionsetnakedforplayer("coup_sunblind",0.1);
	}

	thread func_619F();
	wait(0.1);
	function_0237("coup_sunblind",0);
	function_0237("",3);
	level.var_115C9[param_00] = 1;
	level notify("emp_update");
	level func_52CA(self,param_00);
	level thread func_A577();
	scripts\mp\_hostmigration::func_13708(level.var_61B5);
	level.var_115C9[param_00] = 0;
	foreach(var_02 in level.players)
	{
		if(var_02.team != param_00)
		{
			continue;
		}

		if(var_02 scripts\mp\_utility::_hasperk("specialty_localjammer"))
		{
			var_02 method_81F4();
		}
	}

	level notify("emp_update");
}

//Function Number: 7
func_6164(param_00)
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

		if(var_02 scripts\mp\_utility::_hasperk("specialty_localjammer"))
		{
			var_02 method_807C();
		}
	}

	function_0237("coup_sunblind",0.1);
	thread func_619F();
	wait(0.1);
	function_0237("coup_sunblind",0);
	function_0237("",3);
	level notify("emp_update");
	level.var_61AD = param_00;
	level.var_61AD thread func_61AE();
	level func_52CA(param_00);
	level notify("emp_update");
	level thread func_A577();
	scripts\mp\_hostmigration::func_13708(level.var_61B5);
	foreach(var_02 in level.players)
	{
		if(var_02 == param_00)
		{
			continue;
		}

		if(var_02 scripts\mp\_utility::_hasperk("specialty_localjammer"))
		{
			var_02 method_81F4();
		}
	}

	level.var_61AD = undefined;
	level notify("emp_update");
	level notify("emp_ended");
}

//Function Number: 8
func_A577()
{
	level notify("keepEMPTimeRemaining");
	level endon("keepEMPTimeRemaining");
	level endon("emp_ended");
	level.var_61B6 = int(level.var_61B5);
	while(level.var_61B6)
	{
		wait(1);
		level.var_61B6--;
	}
}

//Function Number: 9
func_61AE()
{
	level endon("EMP_JamPlayers");
	level endon("emp_ended");
	self waittill("disconnect");
	level notify("emp_update");
}

//Function Number: 10
func_619F()
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
		var_04 thread func_619E(var_01);
	}
}

//Function Number: 11
func_619E(param_00)
{
	param_00 endon("disconnect");
	wait(0.5);
	playfxontagforclients(level._effect["emp_flash"],self,"tag_origin",param_00);
}

//Function Number: 12
func_6187()
{
	level endon("game_ended");
	for(;;)
	{
		level scripts\common\utility::waittill_either("joined_team","emp_update");
		foreach(var_01 in level.players)
		{
			if(var_01.team == "spectator")
			{
				continue;
			}

			if(!level.var_115C9[var_01.team] && !var_01 scripts\mp\killstreaks\_emp_common::isemped())
			{
				var_01 func_626B(0);
				continue;
			}

			var_01 func_626B(1);
		}
	}
}

//Function Number: 13
func_617C()
{
	level endon("game_ended");
	for(;;)
	{
		level scripts\common\utility::waittill_either("joined_team","emp_update");
		foreach(var_01 in level.players)
		{
			if(var_01.team == "spectator")
			{
				continue;
			}

			if(isdefined(level.var_61AD) && level.var_61AD != var_01)
			{
				var_01 func_626B(1);
				continue;
			}

			if(!var_01 scripts\mp\killstreaks\_emp_common::isemped())
			{
				var_01 func_626B(0);
			}
		}
	}
}

//Function Number: 14
func_52CA(param_00,param_01)
{
	thread func_52C2(param_00,param_01);
	thread func_52C4(param_00,param_01);
	thread func_52C7(param_00,param_01);
	thread func_52C6(param_00,param_01);
	thread func_52C8(param_00,param_01);
	thread func_52C3(param_00,param_01);
	thread func_52C9(param_00,param_01);
	thread func_52C0(param_00,param_01);
	thread func_52C1(param_00,param_01);
	thread func_532B(param_00,param_01,level.var_DF74);
	thread func_532B(param_00,param_01,level.var_12F81);
}

//Function Number: 15
func_532B(param_00,param_01,param_02)
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
		else if(isdefined(var_0D.var_222) && var_0D.var_222 == param_00)
		{
			continue;
		}

		var_0D notify("damage",var_05,param_00,var_06,var_07,var_03,var_08,var_09,var_0A,var_0B,var_04);
		wait(0.05);
	}
}

//Function Number: 16
func_52C2(param_00,param_01)
{
	func_532B(param_00,param_01,level.var_8DD3);
}

//Function Number: 17
func_52C4(param_00,param_01)
{
	func_532B(param_00,param_01,level.var_AD8B);
}

//Function Number: 18
func_52C7(param_00,param_01)
{
	func_532B(param_00,param_01,level.var_12A83);
}

//Function Number: 19
func_52C6(param_00,param_01)
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
	foreach(var_0C in level.var_E5DE)
	{
		if(level.teambased && isdefined(param_01))
		{
			if(isdefined(var_0C.team) && var_0C.team != param_01)
			{
				continue;
			}
		}
		else if(isdefined(var_0C.var_222) && var_0C.var_222 == param_00)
		{
			continue;
		}

		playfx(level.var_DF7E["explode"],var_0C.origin);
		var_0C delete();
		wait(0.05);
	}
}

//Function Number: 20
func_52C8(param_00,param_01)
{
	var_02 = level.var_12AF3;
	if(level.teambased && isdefined(param_01))
	{
		var_02 = level.var_12AF3[param_01];
	}

	func_532B(param_00,param_01,var_02);
}

//Function Number: 21
func_52C3(param_00,param_01)
{
	func_532B(param_00,param_01,level.var_935F);
}

//Function Number: 22
func_52C9(param_00,param_01)
{
	func_532B(param_00,param_01,level.var_12B14);
}

//Function Number: 23
func_52C0(param_00,param_01)
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
		if(isdefined(level.var_1541) && isdefined(level.var_1541.team) && level.var_1541.team == param_01)
		{
			level.var_1537.var_CC44 notify("damage",var_04,param_00,var_05,var_06,var_02,var_07,var_08,var_09,var_0A,var_03);
			return;
		}

		return;
	}

	if(isdefined(level.var_1541))
	{
		if(!isdefined(level.var_1537.var_222) || isdefined(level.var_1537.var_222) && level.var_1537.var_222 != param_00)
		{
			level.var_1537.var_CC44 notify("damage",var_04,param_00,var_05,var_06,var_02,var_07,var_08,var_09,var_0A,var_03);
			return;
		}
	}
}

//Function Number: 24
func_52C1(param_00,param_01)
{
	func_532B(param_00,param_01,level.var_27EF);
}

//Function Number: 25
func_626B(param_00)
{
	self method_82DA(param_00);
	var_01 = 0;
	if(param_00)
	{
		var_01 = 1;
	}

	thread scripts\mp\killstreaks\_emp_common::func_10D95();
}