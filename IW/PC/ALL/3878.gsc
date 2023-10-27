/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3878.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 16
 * Decompile Time: 14 ms
 * Timestamp: 10/27/2023 12:31:07 AM
*******************************************************************/

//Function Number: 1
func_117D3(param_00)
{
	var_01 = isdefined(level.var_10E6D.var_117C3) && level.var_10E6D.var_117C3;
	level.var_10E6D.var_117C3 = param_00;
	func_117D1(param_00);
	if(!param_00 && var_01)
	{
		level notify("threat_sight_disabled");
		foreach(var_03 in level.players)
		{
			var_03.var_10E6D.var_117DD = undefined;
		}
	}
	else if(param_00 && !var_01)
	{
		level notify("threat_sight_enabled");
	}

	var_05 = function_0072();
	foreach(var_07 in var_05)
	{
		if(isalive(var_07) && isdefined(var_07.var_10E6D) && isdefined(var_07.var_10E6D.var_117DB))
		{
			var_07 func_117D4(var_07.var_10E6D.var_117DB);
		}
	}
}

//Function Number: 2
func_117D1(param_00)
{
	setdvarifuninitialized("ai_threatForcedRate",0.4);
	setdvarifuninitialized("ai_threatForcedMax",0.5);
	if(param_00 && !isdefined(level.var_10E6D.var_117C3) || !level.var_10E6D.var_117C3)
	{
		return;
	}

	function_01C5("ai_threatsight",param_00);
	level thread func_117D2(param_00);
}

//Function Number: 3
func_117D2(param_00)
{
	self notify("threat_sight_set_dvar_display");
	self endon("threat_sight_set_dvar_display");
	if(!param_00)
	{
		wait(1);
	}

	function_01C5("ai_threatsightDisplay",param_00);
}

//Function Number: 4
func_117C3()
{
	if(!getdvarint("ai_threatsight"))
	{
		return 0;
	}

	if(self == level)
	{
		return isdefined(level.var_10E6D.var_117C3) && level.var_10E6D.var_117C3;
	}

	return isdefined(self.var_341) && self.var_341;
}

//Function Number: 5
func_117D4(param_00)
{
	if(isdefined(self.var_10E6D))
	{
		self.var_10E6D.var_117DB = param_00;
	}

	if(!isdefined(level.var_10E6D.var_117C3) || !level.var_10E6D.var_117C3)
	{
		if(!scripts\common\utility::istrue(self.var_117C9))
		{
			thread func_117C9();
			self.var_117C9 = 1;
		}

		return;
	}
	else if(scripts\common\utility::istrue(self.var_117C9))
	{
		self notify("threat_sight_immediate_thread");
		self.var_117C9 = undefined;
	}

	switch(param_00)
	{
		case "hidden":
			self.var_341 = 1;
			self.var_10E6D.var_117C2 = undefined;
			self.var_10E6D.var_117CA = undefined;
			break;

		case "investigate":
			self.var_341 = 1;
			break;

		case "spotted":
		case "death":
			self.var_341 = 0;
			break;

		default:
			break;
	}

	foreach(var_02 in level.players)
	{
		var_02 func_117CD(self,param_00);
	}

	func_117D5(param_00);
}

//Function Number: 6
func_117D5(param_00)
{
	var_01 = 1;
	var_02 = 1;
	if(!isdefined(param_00))
	{
		param_00 = self.var_10E6D.var_117DB;
	}

	if(isdefined(self.var_10E6D.var_117EB))
	{
		var_01 = var_01 * self.var_10E6D.var_117EB;
	}

	if(isdefined(self.var_10E6D.var_117EA))
	{
		var_01 = var_01 * self.var_10E6D.var_117EA;
	}

	if(isdefined(level.var_10E6D.var_117EB))
	{
		var_02 = var_02 * level.var_10E6D.var_117EB;
	}

	if(isdefined(level.var_10E6D.var_117EA))
	{
		var_02 = var_02 * level.var_10E6D.var_117EA;
	}

	switch(param_00)
	{
		case "investigate":
			self.var_343 = 256 * var_02;
			self.var_342 = 1024 * var_02;
			self.var_345 = 1.5 * var_01;
			self.var_344 = 0.05 * var_01;
			break;

		default:
			self.var_343 = 256 * var_02;
			self.var_342 = 1024 * var_02;
			self.var_345 = 0.5 * var_01;
			self.var_344 = 0.025 * var_01;
			break;
	}
}

//Function Number: 7
func_117C9()
{
	self notify("threat_sight_immediate_thread");
	self endon("threat_sight_immediate_thread");
	self endon("death");
	level endon("threat_sight_enabled");
	for(;;)
	{
		level scripts\common\utility::flag_wait("stealth_enabled");
		level scripts\common\utility::func_6E5A("stealth_spotted");
		wait(randomfloatrange(0.4,0.6));
		foreach(var_01 in level.players)
		{
			if(self method_805F(var_01))
			{
				self method_84F7("sight",var_01,var_01.origin);
			}
		}
	}
}

//Function Number: 8
func_117CF()
{
	if(!isdefined(self.var_10E6D.var_117C0))
	{
		self.var_10E6D.var_117C0 = [];
	}

	if(!isdefined(self.var_10E6D.var_117DF))
	{
		self.var_10E6D.var_117DF = 0;
	}

	if(!isdefined(self.var_10E6D.var_117BF))
	{
		self.var_10E6D.var_117BF = 0;
	}

	if(!isdefined(self.var_10E6D.var_117DC))
	{
		self.var_10E6D.var_117DC = [];
	}
}

//Function Number: 9
func_117CD(param_00,param_01)
{
	func_117CF();
	var_02 = param_00 getentitynumber();
	switch(param_01)
	{
		case "hidden":
			self.var_10E6D.var_117DC[var_02] = undefined;
			break;

		case "investigate":
			if(isdefined(param_00.var_10C) && param_00.var_10C == self)
			{
				param_00 method_84EA(self,1);
			}
			break;

		case "spotted":
			param_00 method_84EA(self,1);
			break;

		case "death":
			param_00 method_84EA(self,0);
			break;
	}

	switch(param_01)
	{
		case "death":
			self.var_10E6D.var_117C0[var_02] = undefined;
			self.var_10E6D.var_117DC[var_02] = undefined;
			break;

		default:
			self.var_10E6D.var_117C0[var_02] = param_00;
			break;
	}

	if(!isdefined(self.var_10E6D.var_117DD))
	{
		self.var_10E6D.var_117DD = 1;
		thread func_117CE();
	}
}

//Function Number: 10
func_117D6(param_00)
{
	self endon("death");
	param_00 endon("disconnect");
	var_01 = self getentitynumber();
	param_00.var_10E6D.var_117DC[var_01] = self;
	self method_84F7("sight",param_00,param_00.origin);
	var_02 = lib_0F27::func_1B24(param_00);
	if(!isdefined(self.var_10E6D.var_117C2))
	{
		self.var_10E6D.var_117C2 = 0;
	}
	else
	{
		self.var_10E6D.var_117C2++;
	}

	var_02 = var_02 * 1 / pow(2,self.var_10E6D.var_117C2);
	wait(var_02);
	thread func_117D7(param_00);
}

//Function Number: 11
func_117D7(param_00)
{
	var_01 = param_00 getentitynumber();
	self notify("threat_sight_sighted_wait_lost_" + var_01);
	self endon("threat_sight_sighted_wait_lost_" + var_01);
	self endon("death");
	param_00 endon("disconnect");
	var_02 = self getentitynumber();
	param_00.var_10E6D.var_117DC[var_02] = undefined;
	for(;;)
	{
		self.var_10E6D.var_117CA = self method_84E9(param_00) < 0.75;
		if(self.var_10E6D.var_117CA)
		{
			return;
		}

		wait(0.05);
	}
}

//Function Number: 12
func_117C5(param_00,param_01)
{
	var_02 = gettime() + int(1000 * param_01);
	var_03 = param_00 getentitynumber();
	if(!isdefined(self.var_10E6D.var_729B))
	{
		self.var_10E6D.var_729B = [];
	}

	if(isdefined(self.var_10E6D.var_729B[var_03]))
	{
		self.var_10E6D.var_729B[var_03].var_62A3 = max(self.var_10E6D.var_729B[var_03].var_62A3,var_02);
	}
	else
	{
		self.var_10E6D.var_729B[var_03] = spawnstruct();
		self.var_10E6D.var_729B[var_03].var_62A3 = var_02;
	}

	self.var_10E6D.var_729B[var_03].var_65D3 = param_00;
	thread func_117C6();
}

//Function Number: 13
func_117C6()
{
	if(scripts\common\utility::istrue(self.var_10E6D.var_729C))
	{
		return;
	}

	self notify("threat_sight_force_visible_thread");
	self endon("threat_sight_force_visible_thread");
	self endon("death");
	self.var_10E6D.var_729C = 1;
	var_00 = 0.05;
	var_01 = 0;
	while(isdefined(self.var_10E6D.var_729B) && self.var_10E6D.var_729B.size > 0)
	{
		var_02 = gettime();
		var_03 = [];
		var_04 = getdvarfloat("ai_threatForcedRate") * var_00;
		foreach(var_08, var_06 in self.var_10E6D.var_729B)
		{
			if(var_02 < var_06.var_62A3 && issentient(var_06.var_65D3) && !self method_805F(var_06.var_65D3))
			{
				var_07 = self method_84E9(var_06.var_65D3);
				if(isplayer(var_06.var_65D3))
				{
					var_06.var_65D3 thread func_117D0(1,max(var_06.var_65D3.var_10E6D.var_B4CB,var_07));
				}

				if(var_07 + var_04 < getdvarfloat("ai_threatForcedMax"))
				{
					var_07 = var_07 + var_04;
					self method_84EA(var_06.var_65D3,var_07);
					if(getdvarfloat("ai_threatForcedMax") >= 1 && var_07 >= 1 && !var_01)
					{
						self method_84F7("sight",var_06.var_65D3,var_06.var_65D3.origin);
						var_01 = 1;
					}
					else if(var_07 < 0.75 && var_01)
					{
						var_01 = 0;
					}
				}

				continue;
			}

			var_03[var_03.size] = var_08;
		}

		foreach(var_08 in var_03)
		{
			self.var_10E6D.var_729B[var_08] = undefined;
		}

		wait(var_00);
	}

	self.var_10E6D.var_729B = undefined;
	self.var_10E6D.var_729C = undefined;
}

//Function Number: 14
func_117CE()
{
	self endon("death");
	self endon("disconnect");
	level endon("threat_sight_disabled");
	var_00 = 0;
	for(;;)
	{
		var_01 = 0;
		var_02 = 0;
		self.var_10E6D.var_B4CB = 0;
		self.var_10E6D.var_B476 = -1;
		var_03 = self geteye();
		var_04 = cos(90);
		foreach(var_06 in self.var_10E6D.var_117C0)
		{
			if(!isalive(var_06))
			{
				continue;
			}

			var_07 = var_06 getentitynumber();
			self.var_10E6D.var_B476 = max(self.var_10E6D.var_B476,var_06.var_29);
			if(getdvarint("ai_threatsight",1))
			{
				var_08 = var_06 method_84E9(self);
				var_09 = var_06 method_805F(self);
				if(var_09)
				{
					var_00 = gettime();
				}

				if(var_08 >= 1)
				{
					if(!isdefined(self.var_10E6D.var_117DC[var_07]) && isdefined(var_06.var_10C) && var_06.var_10C == self)
					{
						var_06 thread func_117D6(self);
					}

					var_01 = 1;
				}

				self.var_10E6D.var_B4CB = max(self.var_10E6D.var_B4CB,var_06 method_84E9(self));
				var_0A = var_09 && scripts\common\utility::istrue(level.var_10E6D.var_5659) || var_06 lib_0F22::func_9B2C() && var_08 > 0;
				if(var_0A)
				{
					var_0B = vectornormalize(var_03 - var_06 geteye());
					var_0C = anglestoright(var_06 gettagangles("j_spineupper"));
					var_0A = vectordot(var_0B,var_0C) > var_04;
				}

				if(var_0A)
				{
					var_06.var_10E6D.var_B020 = self;
					var_06 method_8306(self);
				}
				else if(isdefined(var_06.var_10E6D.var_B020) && var_06.var_10E6D.var_B020 == self)
				{
					var_06.var_10E6D.var_B020 = undefined;
					var_06 method_8306();
				}
			}

			if(var_06.var_28 == "combat" || !var_06.var_341)
			{
				var_02 = 1;
			}
		}

		var_0E = !var_02 && var_00 > 0 && gettime() - var_00 < 250;
		if(getdvarfloat("ai_threatsightFakeThreat") <= 0)
		{
			thread func_117D0(var_0E,self.var_10E6D.var_B4CB);
		}

		self.var_10E6D.var_117DF = var_0E;
		wait(0.05);
	}
}

//Function Number: 15
func_117C4(param_00,param_01)
{
	self notify("threat_sight_fake");
	self endon("threat_sight_fake");
	function_01C5("ai_threatsightFakeThreat",param_01);
	function_01C5("ai_threatsightFakeX",param_00[0]);
	function_01C5("ai_threatsightFakeY",param_00[1]);
	function_01C5("ai_threatsightFakeZ",param_00[2]);
	if(!isdefined(self.var_10E6D.var_B4CB))
	{
		self.var_10E6D.var_B4CB = 0;
	}

	while(param_01 > 0)
	{
		thread func_117D0(1,max(self.var_10E6D.var_B4CB,param_01));
		wait(0.05);
	}

	thread func_117D0(0,max(self.var_10E6D.var_B4CB,param_01));
}

//Function Number: 16
func_117D0(param_00,param_01,param_02)
{
	var_03 = 180;
	var_04 = 0.01;
	var_05 = 0.05;
	var_06 = 0.125;
	self endon("disconnect");
	self notify("threat_sight_player_sight_audio");
	self endon("threat_sight_player_sight_audio");
	var_07 = ["ui_stealth_threat_low_lp","ui_stealth_threat_med_lp","ui_stealth_threat_high_lp"];
	if(!getdvarint("ai_threatsightdisplay",0))
	{
		param_01 = 0;
	}

	if(!isdefined(self.var_10E6D.var_117D8) && param_00 && param_01 > 0)
	{
		self.var_10E6D.var_117D8 = [];
		self.var_10E6D.var_117DA = 0;
		self.var_10E6D.var_117D9 = 0;
		foreach(var_09 in var_07)
		{
			var_0A = spawn("script_origin",self.origin);
			var_0A linkto(self);
			var_0A method_8278(0,0);
			var_0A.var_9F00 = 0;
			self.var_10E6D.var_117D8[var_09] = var_0A;
		}
	}

	if(isdefined(self.var_10E6D.var_117D8))
	{
		self.var_10E6D.var_117D9 = self.var_10E6D.var_117D9 - self.var_10E6D.var_117D9 * var_06;
		self.var_10E6D.var_117D9 = self.var_10E6D.var_117D9 + param_01 * var_06;
		if(self.var_10E6D.var_117D9 < 0.0001)
		{
			self.var_10E6D.var_117D9 = 0;
		}

		param_01 = self.var_10E6D.var_117D9;
	}

	while(isdefined(self.var_10E6D.var_117D8))
	{
		var_0B = 0;
		var_0C = 0;
		if(param_01 > 0)
		{
			if(param_01 < var_05)
			{
				var_0D = clamp(param_01,0,var_05);
				var_0E = var_0D / var_05;
				var_0F = 1 - var_04;
				var_10 = var_04 + var_0F * var_0E;
				self.var_10E6D.var_117DA = var_10;
			}
			else
			{
				self.var_10E6D.var_117DA = 1;
			}
		}
		else
		{
			self.var_10E6D.var_117DA = 0;
			self.var_10E6D.var_117D9 = 0;
		}

		self.var_10E6D.var_117DA = clamp(self.var_10E6D.var_117DA,0,1);
		foreach(var_09, var_0A in self.var_10E6D.var_117D8)
		{
			var_12 = 1;
			switch(var_0B)
			{
				case 0:
					if(param_01 < 0.75)
					{
						var_12 = cos(var_03 * param_01 * 0.666);
					}
					else
					{
						var_12 = 0;
					}
					break;

				case 1:
					if(param_01 < 0.75)
					{
						var_12 = sin(var_03 * param_01 * 0.666);
					}
					else if(param_01 < 1)
					{
						var_12 = sin(var_03 * 1 - param_01 * 2);
					}
					else
					{
						var_12 = 0;
					}
					break;

				case 2:
					if(param_01 < 0.75)
					{
						var_12 = 0;
					}
					else
					{
						var_12 = cos(var_03 * 1 - param_01 * 2);
					}
					break;
			}

			var_13 = clamp(self.var_10E6D.var_117DA * var_12,0,1);
			if(var_13 > 0)
			{
				var_0C = 1;
				if(var_0A.var_9F00 == 0)
				{
					var_0A method_8278(0,0);
					var_0A scripts\common\utility::delaycall(0.05,::playloopsound,var_09);
					var_0A.var_9F00 = 1;
				}

				var_0A scripts\common\utility::delaycall(0,::method_8278,var_13,0.05);
			}
			else if(var_0A.var_9F00 == 1)
			{
				var_0A method_8278(0,0.05);
				var_0A scripts\common\utility::delaycall(0.05,::stoploopsound);
				var_0A.var_9F00 = 0;
			}

			var_0B++;
		}

		if(!var_0C)
		{
			foreach(var_0A in self.var_10E6D.var_117D8)
			{
				var_0A method_8278(0,0.05);
				var_0A stoploopsound();
				var_0A scripts\common\utility::delaycall(0.05,::delete);
			}

			self.var_10E6D.var_117D8 = undefined;
			self.var_10E6D.var_117DA = undefined;
			self.var_10E6D.var_117D9 = undefined;
		}

		wait(0.05);
	}
}