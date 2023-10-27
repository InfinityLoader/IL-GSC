/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\_whizby.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 10
 * Decompile Time: 472 ms
 * Timestamp: 10/27/2023 12:22:29 AM
*******************************************************************/

//Function Number: 1
init()
{
	level._effect["whizzby_left"] = loadfx("vfx/old/_requests/mp_gameplay/vfx_near_miss_edge_left.vfx");
	level._effect["whizzby_right"] = loadfx("vfx/old/_requests/mp_gameplay/vfx_near_miss_edge_right.vfx");
	level._effect["whizzby_top"] = loadfx("vfx/old/_requests/mp_gameplay/vfx_near_miss_edge_top.vfx");
	level._effect["whizzby_top_left"] = loadfx("vfx/old/_requests/mp_gameplay/vfx_near_miss_edge_top_left.vfx");
	level._effect["whizzby_top_right"] = loadfx("vfx/old/_requests/mp_gameplay/vfx_near_miss_edge_top_right.vfx");
	level._effect["whizzby_bottom"] = loadfx("vfx/old/_requests/mp_gameplay/vfx_near_miss_edge_bottom.vfx");
	level._effect["whizzby_bottom_left"] = loadfx("vfx/old/_requests/mp_gameplay/vfx_near_miss_edge_bottom_left.vfx");
	level._effect["whizzby_bottom_right"] = loadfx("vfx/old/_requests/mp_gameplay/vfx_near_miss_edge_bottom_right.vfx");
	level thread func_C56E();
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
	self.var_1468 = [];
	for(;;)
	{
		self waittill("spawned_player");
		thread func_13D18();
		thread func_13D11();
	}
}

//Function Number: 4
func_13D18()
{
	self endon("disconnect");
	self endon("death");
	level endon("game_ended");
	var_00 = gettime();
	for(;;)
	{
		self waittill("bulletwhizby",var_01,var_02);
		if(!lib_0DF8::func_213D(self,var_01))
		{
			continue;
		}

		if(gettime() - var_00 > 190 && !scripts\mp\_utility::func_9FC6() && getdvar("scr_whizby_off") == "")
		{
			thread func_13D17(var_01);
			var_00 = gettime();
		}
	}
}

//Function Number: 5
func_13D11()
{
	scripts\common\utility::waittill_any_3("death","disconnect");
	foreach(var_01 in self.var_1468)
	{
		if(isalive(var_01))
		{
			var_01 delete();
		}
	}
}

//Function Number: 6
func_13D17(param_00)
{
	var_01 = distance(param_00 geteye(),self geteye()) * 0.9;
	var_02 = param_00 geteye();
	var_03 = anglestoforward(param_00 getgunangles());
	var_04 = var_02 + var_03 * var_01;
	var_05 = self geteye();
	var_06 = 2;
	var_07 = var_05[2] - var_04[2];
	if(abs(var_07) > 10)
	{
		var_06 = var_07 <= 0;
	}

	var_08 = 2;
	var_09 = anglestoforward(self.angles);
	var_0A = var_09;
	var_0B = var_04 - self geteye();
	var_0A = (var_0A[0],var_0A[1],0);
	var_0B = (var_0B[0],var_0B[1],0);
	var_0C = scripts\common\utility::func_1E7D(var_0A,var_0B,(0,0,1));
	if(abs(var_0C) > 21 || 180 - abs(var_0C) < 21)
	{
		var_08 = var_0C > 0;
	}

	var_0D = func_13D15(var_06,var_08);
	if(!isdefined(self.var_1468[var_0D]))
	{
		if(isdefined(level._effect[var_0D]))
		{
			self.var_1468[var_0D] = function_01E1(level._effect[var_0D],self geteye(),self);
		}
		else
		{
		}
	}

	triggerfx(self.var_1468[var_0D]);
	self.var_1468[var_0D] notify("reset");
	self.var_1468[var_0D] thread func_13D19();
}

//Function Number: 7
func_13D15(param_00,param_01)
{
	var_02 = "whizzby";
	if(param_00 == 0)
	{
		var_02 = var_02 + "_bottom";
	}
	else if(param_00 == 1)
	{
		var_02 = var_02 + "_top";
	}

	if(param_01 == 0)
	{
		var_02 = var_02 + "_right";
	}
	else if(param_01 == 1)
	{
		var_02 = var_02 + "_left";
	}

	if(param_00 == 2 && param_01 == 2)
	{
		var_02 = var_02 + "_top";
	}

	return var_02;
}

//Function Number: 8
func_13D12(param_00,param_01)
{
	var_02 = param_00;
	if(param_01 == "left")
	{
		var_02 = var_02 + 90;
	}

	return var_02;
}

//Function Number: 9
func_13D16(param_00)
{
	return level.var_1467[param_00];
}

//Function Number: 10
func_13D19()
{
	self endon("reset");
	wait(0.75);
	self delete();
}