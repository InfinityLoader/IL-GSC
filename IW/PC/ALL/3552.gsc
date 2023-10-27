/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3552.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 11
 * Decompile Time: 15 ms
 * Timestamp: 10/27/2023 12:30:40 AM
*******************************************************************/

//Function Number: 1
init()
{
}

//Function Number: 2
func_835C()
{
	self endon("death");
	self endon("disconnect");
	thread func_C799();
	thread func_2652();
	self playlocalsound("synaptic_comm_on");
	thread func_13B7F();
}

//Function Number: 3
func_E0E0()
{
	self notify("endComLink");
}

//Function Number: 4
func_C799()
{
	if(!level.teambased)
	{
		return;
	}

	foreach(var_01 in level.var_C928)
	{
		if(!isdefined(var_01.team))
		{
			continue;
		}

		if(var_01.team == self.team)
		{
			var_02 = scripts\mp\_utility::func_C794(var_01,"cyan",self,0,0,"killstreak");
			thread func_5604(var_02,var_01);
		}
	}
}

//Function Number: 5
func_5604(param_00,param_01)
{
	self endon("disconnect");
	level endon("game_ended");
	scripts\common\utility::waittill_any_timeout_no_endon_death_2(10,"death","joined_team");
	scripts\mp\_utility::func_C78F(param_00,param_01);
}

//Function Number: 6
func_2652()
{
	self endon("endComLink");
	var_00 = 3;
	var_01 = 3;
	var_02 = 0.5;
	var_03 = 0;
	for(;;)
	{
		var_04 = sortbydistance(level.var_C928,self.origin);
		foreach(var_06 in var_04)
		{
			if(!isdefined(var_06))
			{
				continue;
			}

			if(var_06 == self)
			{
				continue;
			}

			if(level.teambased && var_06.team == self.team)
			{
				continue;
			}

			if(var_06 scripts\mp\_utility::_hasperk("specialty_gpsjammer"))
			{
				continue;
			}

			if(!scripts\mp\_utility::func_9F19(var_06))
			{
				if(isdefined(var_06.var_2A3B))
				{
					var_06.var_2A3B delete();
				}

				continue;
			}

			if(isdefined(var_06.var_12AF1))
			{
				if(isdefined(var_06.var_2A3B))
				{
					var_06.var_2A3B delete();
				}

				var_06.var_12AF1.origin = var_06.origin;
				var_06.var_12AF2.origin = var_06.origin;
				var_06.var_12AF2.alpha = 0.95;
				var_06.var_12AF2 thread func_6AB8(var_01,var_03);
			}
			else
			{
				var_07 = spawn("script_model",var_06.origin);
				var_07 setmodel("tag_origin");
				var_07.var_222 = var_06;
				var_06.var_12AF1 = var_07;
				var_06.var_12AF2 = var_07 scripts\mp\_entityheadicons::func_F73D(self,"headicon_enemy",(0,0,48),2,2,1,0.01,0,1,1,0);
				var_06.var_12AF2 setwaypointedgestyle_rotatingicon();
				var_06.var_12AF2.alpha = 0.95;
				var_06.var_12AF2 thread func_6AB8(var_01,var_03);
			}

			wait(var_02);
		}

		wait(var_01);
	}
}

//Function Number: 7
func_B37E()
{
	self endon("death");
	self endon("disconnect");
	self endon("endComLink");
	level endon("game_ended");
	var_00 = 3;
	var_01 = 3;
	var_02 = 0.5;
	if(!isdefined(self))
	{
		return;
	}

	if(isdefined(self.var_12AF1))
	{
		if(isdefined(self.var_2A3B))
		{
			self.var_2A3B delete();
		}

		self.var_12AF1.origin = self.origin;
		self.var_12AF2.origin = self.origin;
		self.var_12AF2.alpha = 0.95;
		self.var_12AF2 thread func_6AB8(var_01,var_02);
	}
	else
	{
		var_03 = spawn("script_model",self.origin);
		var_03 setmodel("tag_origin");
		var_03.var_222 = self;
		self.var_12AF1 = var_03;
		self.var_12AF2 = var_03 scripts\mp\_entityheadicons::func_F73D(scripts\mp\_utility::getotherteam(self.team),"headicon_enemy",(0,0,48),14,14,1,0.01,0,1,1,0);
		self.var_12AF2.alpha = 0.95;
		self.var_12AF2 thread func_6AB8(var_01,var_02);
		self.var_12AF2 setwaypointedgestyle_rotatingicon();
	}

	wait(var_01);
	if(isdefined(self.var_2A3B))
	{
		self.var_2A3B delete();
	}
}

//Function Number: 8
func_6AB8(param_00,param_01)
{
	self notify("fadeOut");
	self endon("fadeOut");
	var_02 = param_00 - param_01;
	wait(0.05);
	if(!isdefined(self))
	{
		return;
	}

	self fadeovertime(var_02);
	self.alpha = 0;
}

//Function Number: 9
func_13B7F(param_00)
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	wait(10);
	self notify("endComLink");
}

//Function Number: 10
func_13A10()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	for(;;)
	{
		self waittill("emp_damage",var_00,var_01);
		scripts\common\utility::func_136F7();
		self notify("endComLink");
	}
}

//Function Number: 11
func_13A11()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	for(;;)
	{
		level waittill("emp_update");
		if(scripts\mp\killstreaks\_emp_common::isemped())
		{
			self notify("endComLink");
		}
	}
}