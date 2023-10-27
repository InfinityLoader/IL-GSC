/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\cp\cp_outline.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 20
 * Decompile Time: 1092 ms
 * Timestamp: 10/27/2023 12:09:42 AM
*******************************************************************/

//Function Number: 1
func_C77A()
{
	self endon("disconnect");
	level endon("game_ended");
	wait(2);
	for(;;)
	{
		func_A02C();
		scripts\common\utility::func_136F7();
	}
}

//Function Number: 2
func_C776()
{
	level.var_C785 = [];
}

//Function Number: 3
func_A02C()
{
	self endon("refresh_outline");
	foreach(var_04, var_01 in level.var_C785)
	{
		if(!isdefined(var_01))
		{
			continue;
		}

		if(!isdefined(var_01.cost))
		{
			continue;
		}

		var_02 = 1;
		var_03 = func_7D69(var_01);
		if(var_03 == 3)
		{
			func_6220(var_01,self,func_78CF(var_01,var_02),1,0,"high");
		}
		else if(var_03 == 1)
		{
			func_6220(var_01,self,4,1,0,"high");
		}
		else
		{
			func_5561(var_01,self);
		}

		if(var_04 & 0)
		{
			scripts\common\utility::func_136F7();
		}
	}
}

//Function Number: 4
func_78CF(param_00,param_01)
{
	var_02 = param_00.cost;
	if(isdefined(param_00.struct.var_394) && scripts\cp\_weapon::func_8BBB(param_00.struct.var_394))
	{
		if(isdefined(level.var_7D63))
		{
			var_03 = self [[ level.var_7D63 ]](param_00.struct.var_394);
			if(var_03 > 1)
			{
				var_02 = 4500;
			}
			else
			{
				var_02 = param_00.cost * 0.5;
			}
		}
		else
		{
			var_02 = param_00.cost * 0.5;
		}
	}

	if(scripts\cp\_persistence::func_D0BB(var_02) || scripts\common\utility::istrue(param_00.var_6261))
	{
		return 3;
	}

	return 1;
}

//Function Number: 5
func_7D69(param_00)
{
	var_01 = distancesquared(self.origin,param_00.origin) < 1000000;
	if(!var_01)
	{
		return 0;
	}

	if(scripts\cp\_utility::func_9C03())
	{
		return 1;
	}

	if(scripts\cp\_utility::func_8BAE())
	{
		return 1;
	}

	return 3;
}

//Function Number: 6
func_D3DF()
{
	self endon("disconnect");
	for(;;)
	{
		foreach(var_01 in level.players)
		{
			if(self == var_01)
			{
				continue;
			}

			if(func_FF7F(var_01))
			{
				func_6220(var_01,self,func_78D0(var_01),0,0,"high");
				continue;
			}

			func_5561(var_01,self);
		}

		wait(0.2);
	}
}

//Function Number: 7
func_FF7F(param_00)
{
	if(self.var_C016)
	{
		return 0;
	}

	if(!isalive(param_00) || !isdefined(param_00.maxhealth) || !param_00.maxhealth || param_00.var_C004)
	{
		return 0;
	}

	if(isdefined(level.shouldplayeroutline))
	{
		if(![[ level.shouldplayeroutline ]](self,param_00))
		{
			return 0;
		}
	}

	var_01 = distancesquared(self.origin,param_00.origin) > 2250000;
	if(var_01)
	{
		return 1;
	}

	var_02 = !bullettracepassed(self geteye(),param_00 geteye(),0,self);
	return var_02;
}

//Function Number: 8
func_78D0(param_00)
{
	var_01 = param_00.health / 100;
	if(var_01 <= 0.33 || scripts\cp\_laststand::player_in_laststand(param_00))
	{
		return 4;
	}

	if(var_01 <= 0.66)
	{
		return 5;
	}

	if(var_01 <= 1)
	{
		return 3;
	}

	return 0;
}

//Function Number: 9
func_6221(param_00,param_01,param_02,param_03,param_04,param_05)
{
	param_00 method_8190(param_01,param_02,param_03,param_04);
}

//Function Number: 10
func_6220(param_00,param_01,param_02,param_03,param_04,param_05)
{
	param_00 hudoutlineenableforclient(param_01,param_02,param_03,param_04);
}

//Function Number: 11
func_5562(param_00,param_01)
{
	param_00 method_818D(param_01);
}

//Function Number: 12
func_5561(param_00,param_01)
{
	param_00 hudoutlinedisableforclient(param_01);
}

//Function Number: 13
func_5560(param_00)
{
	param_00 method_818B();
}

//Function Number: 14
func_621F(param_00,param_01,param_02,param_03)
{
	param_00 method_818E(param_01,param_02,param_03);
}

//Function Number: 15
func_F4AE(param_00,param_01,param_02)
{
	level endon("game_ended");
	level endon("outline_disabled");
	if(!isdefined(param_00))
	{
		param_00 = 4;
	}

	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	for(;;)
	{
		foreach(var_04 in scripts\cp\_agent_utils::get_alive_enemies())
		{
			if(isdefined(var_04.var_4D32))
			{
				continue;
			}

			if(isdefined(var_04.var_B36D))
			{
				continue;
			}

			if(isdefined(var_04.var_6BD4))
			{
				func_6221(var_04,level.players,param_00,1,param_02,"high");
				continue;
			}

			func_6221(var_04,level.players,param_00,param_01,param_02,"high");
		}

		wait(0.5);
	}
}

//Function Number: 16
func_F4AF(param_00,param_01,param_02)
{
	level endon("game_ended");
	self endon("outline_disabled");
	if(!isdefined(param_00))
	{
		param_00 = 4;
	}

	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	for(;;)
	{
		foreach(var_04 in scripts\cp\_agent_utils::get_alive_enemies())
		{
			if(isdefined(var_04.var_4D32))
			{
				continue;
			}

			if(isdefined(var_04.var_B36D))
			{
				continue;
			}

			if(isdefined(var_04.var_6BD4))
			{
				func_6220(var_04,self,param_00,1,param_02,"high");
				continue;
			}

			func_6220(var_04,self,param_00,param_01,param_02,"high");
		}

		wait(0.5);
	}
}

//Function Number: 17
func_12C01()
{
	foreach(var_01 in scripts\cp\_agent_utils::get_alive_enemies())
	{
		if(isdefined(var_01.var_4D32))
		{
			continue;
		}

		if(isdefined(var_01.var_B36D))
		{
			continue;
		}

		func_5562(var_01,level.players);
		level notify("outline_disabled");
	}
}

//Function Number: 18
func_12C02()
{
	foreach(var_01 in scripts\cp\_agent_utils::get_alive_enemies())
	{
		if(isdefined(var_01.var_4D32))
		{
			continue;
		}

		if(isdefined(var_01.var_B36D))
		{
			continue;
		}

		func_5561(var_01,self);
		self notify("outline_disabled");
	}
}

//Function Number: 19
func_EB64()
{
	var_00 = ["r_hudoutlineFillColor0","r_hudoutlineFillColor1","r_hudoutlinewidth","r_hudoutlineOccludedOutlineColor","r_hudoutlineOccludedInlineColor","r_hudoutlineOccludedInteriorColor","r_hudOutlineOccludedColorFromFill","cg_hud_outline_colors_0","cg_hud_outline_colors_1","cg_hud_outline_colors_2","cg_hud_outline_colors_3","cg_hud_outline_colors_4","cg_hud_outline_colors_5","cg_hud_outline_colors_6"];
	if(!isdefined(level.var_91AD))
	{
		level.var_91AD = [];
	}

	foreach(var_02 in var_00)
	{
		level.var_91AD[var_02] = getdvar(var_02);
	}
}

//Function Number: 20
func_E2CA()
{
	var_00 = ["r_hudoutlineFillColor0","r_hudoutlineFillColor1","r_hudoutlinewidth","r_hudoutlineOccludedOutlineColor","r_hudoutlineOccludedInlineColor","r_hudoutlineOccludedInteriorColor","r_hudOutlineOccludedColorFromFill","cg_hud_outline_colors_0","cg_hud_outline_colors_1","cg_hud_outline_colors_2","cg_hud_outline_colors_3","cg_hud_outline_colors_4","cg_hud_outline_colors_5","cg_hud_outline_colors_6"];
	if(!isdefined(level.var_91AD))
	{
		return;
	}

	foreach(var_02 in var_00)
	{
		setdvar(var_02,level.var_91AD[var_02]);
	}
}