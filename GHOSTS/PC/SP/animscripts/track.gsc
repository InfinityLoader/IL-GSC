/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\track.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 9
 * Decompile Time: 204 ms
 * Timestamp: 10/27/2023 1:24:36 AM
*******************************************************************/

//Function Number: 1
trackshootentorpos()
{
	self endon("killanimscript");
	self endon("stop tracking");
	self endon("melee");
	func_8221(%aim_2,%aim_4,%aim_6,%aim_8);
}

//Function Number: 2
func_8221(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = 0;
	var_06 = 0;
	var_07 = (0,0,0);
	var_08 = 1;
	var_09 = 0;
	var_0A = 0;
	var_0B = 10;
	var_0C = (0,0,0);
	if(self.type == "dog")
	{
		var_0D = 0;
		self.var_7439 = self.enemy;
	}
	else
	{
		var_0D = 1;
		var_0E = 0;
		var_0F = 0;
		if(isdefined(self.covercrouchlean_aimmode))
		{
			var_0E = level.covercrouchleanpitch;
		}

		var_10 = self.script;
		if(var_10 == "cover_multi")
		{
			if(self.cover.state == "right")
			{
				var_10 = "cover_right";
			}
			else if(self.cover.state == "left")
			{
				var_10 = "cover_left";
			}
		}

		if((var_10 == "cover_left" || var_10 == "cover_right") && isdefined(self.a.cornermode) && self.a.cornermode == "lean")
		{
			var_0F = self.var_1FCA.angles[1] - self.angles[1];
		}

		var_0C = (var_0E,var_0F,0);
	}

	for(;;)
	{
		incranimaimweight();
		var_11 = animscripts/shared::func_3BE5();
		var_12 = self.var_7445;
		if(isdefined(self.var_7439))
		{
			var_12 = self.var_7439 getshootatpos();
		}

		if(!isdefined(var_12) && animscripts/utility::func_74A5())
		{
			var_12 = trackloop_cqbshootpos(var_11);
		}

		var_13 = isdefined(self.var_5974) || isdefined(self.onatv);
		var_14 = isdefined(var_12);
		var_15 = (0,0,0);
		if(var_14)
		{
			var_15 = var_12;
		}

		var_16 = 0;
		var_17 = isdefined(self.var_7BED);
		if(var_17)
		{
			var_16 = self.var_7BED;
		}

		var_07 = self getaimangle(var_11,var_15,var_14,var_0C,var_16,var_17,var_13);
		var_18 = var_07[0];
		var_19 = var_07[1];
		var_07 = undefined;
		if(animscripts/utility::func_4965())
		{
			var_1A = self.angles[2] * -1;
			var_1B = var_18 * cos(var_1A) - var_19 * sin(var_1A);
			var_1C = var_18 * sin(var_1A) + var_19 * cos(var_1A);
			var_18 = var_1B;
			var_19 = var_1C;
			var_18 = clamp(var_18,self.downaimlimit,self.upaimlimit);
			var_19 = clamp(var_19,self.leftaimlimit,self.rightaimlimit);
		}

		if(var_0A > 0)
		{
			var_0A = var_0A - 1;
			var_0B = max(10,var_0B - 5);
		}
		else if(self.relativedir && self.relativedir != var_09)
		{
			var_0A = 2;
			var_0B = 30;
		}
		else
		{
			var_0B = 10;
		}

		var_1D = squared(var_0B);
		var_09 = self.relativedir;
		var_1E = self.movemode != "stop" || !var_08;
		if(var_1E)
		{
			var_1F = var_19 - var_05;
			if(squared(var_1F) > var_1D)
			{
				var_19 = var_05 + clamp(var_1F,-1 * var_0B,var_0B);
				var_19 = clamp(var_19,self.leftaimlimit,self.rightaimlimit);
			}

			var_20 = var_18 - var_06;
			if(squared(var_20) > var_1D)
			{
				var_18 = var_06 + clamp(var_20,-1 * var_0B,var_0B);
				var_18 = clamp(var_18,self.downaimlimit,self.upaimlimit);
			}
		}

		var_08 = 0;
		var_05 = var_19;
		var_06 = var_18;
		func_8226(param_00,param_01,param_02,param_03,param_04,var_18,var_19);
		wait(0.05);
	}
}

//Function Number: 3
trackloop_cqbshootpos(param_00)
{
	var_01 = undefined;
	var_02 = anglestoforward(self.angles);
	if(isdefined(self.var_1FF2))
	{
		var_01 = self.var_1FF2 getshootatpos();
		if(isdefined(self.cqb_wide_target_track))
		{
			if(vectordot(vectornormalize(var_01 - param_00),var_02) < 0.177)
			{
				var_01 = undefined;
			}
		}
		else if(vectordot(vectornormalize(var_01 - param_00),var_02) < 0.643)
		{
			var_01 = undefined;
		}
	}

	if(!isdefined(var_01) && isdefined(self.cqb_point_of_interest))
	{
		var_01 = self.cqb_point_of_interest;
		if(isdefined(self.cqb_wide_poi_track))
		{
			if(vectordot(vectornormalize(var_01 - param_00),var_02) < 0.177)
			{
				var_01 = undefined;
			}
		}
		else if(vectordot(vectornormalize(var_01 - param_00),var_02) < 0.643)
		{
			var_01 = undefined;
		}
	}

	return var_01;
}

//Function Number: 4
func_8222(param_00,param_01)
{
	if(animscripts/utility::func_63FE())
	{
		var_02 = self.enemy getshootatpos() - self.enemy.origin;
		var_03 = self lastknownpos(self.enemy) + var_02;
		return func_8225(var_03 - param_00,param_01);
	}

	var_04 = 0;
	var_05 = 0;
	if(isdefined(self.node) && isdefined(level.var_489E[self.node.type]) && distancesquared(self.origin,self.node.origin) < 16)
	{
		var_05 = angleclamp180(self.angles[1] - self.node.angles[1]);
	}
	else
	{
		var_06 = self getanglestolikelyenemypath();
		if(isdefined(var_06))
		{
			var_05 = angleclamp180(self.angles[1] - var_06[1]);
			var_04 = angleclamp180(360 - var_06[0]);
		}
	}

	return (var_04,var_05,0);
}

//Function Number: 5
func_8225(param_00,param_01)
{
	var_02 = vectortoangles(param_00);
	var_03 = 0;
	var_04 = 0;
	if(self.stairsstate == "up")
	{
		var_03 = -40;
	}
	else if(self.stairsstate == "down")
	{
		var_03 = 40;
		var_04 = 12;
	}

	var_05 = 360 - var_02[0];
	var_05 = angleclamp180(var_05 + param_01[0] + var_03);
	if(isdefined(self.var_7BED))
	{
		var_06 = self.var_7BED - var_02[1];
	}
	else
	{
		var_07 = angleclamp180(self.desiredangle - self.angles[1]) * 0.5;
		var_06 = var_07 + self.angles[1] - var_02[1];
	}

	var_06 = angleclamp180(var_06 + param_01[1] + var_04);
	return (var_05,var_06,0);
}

//Function Number: 6
func_8223(param_00,param_01,param_02)
{
	if(isdefined(self.var_5974) || isdefined(self.onatv))
	{
		if(param_01 > self.rightaimlimit || param_01 < self.leftaimlimit)
		{
			param_01 = 0;
		}

		if(param_00 > self.upaimlimit || param_00 < self.downaimlimit)
		{
			param_00 = 0;
		}
	}
	else if(param_02 && abs(param_01) > level.var_50F0 || abs(param_00) > level.var_50EF)
	{
		param_01 = 0;
		param_00 = 0;
	}
	else
	{
		if(self.gunblockedbywall)
		{
			param_01 = clamp(param_01,-10,10);
		}
		else
		{
			param_01 = clamp(param_01,self.leftaimlimit,self.rightaimlimit);
		}

		param_00 = clamp(param_00,self.downaimlimit,self.upaimlimit);
	}

	return (param_00,param_01,0);
}

//Function Number: 7
func_8226(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	var_07 = 0;
	var_08 = 0;
	var_09 = 0;
	var_0A = 0;
	var_0B = 0;
	if(param_06 > 0)
	{
		var_0A = param_06 / self.rightaimlimit * self.a.aimweight;
		var_09 = 1;
	}
	else if(param_06 < 0)
	{
		var_08 = param_06 / self.leftaimlimit * self.a.aimweight;
		var_09 = 1;
	}

	if(param_05 > 0)
	{
		var_0B = param_05 / self.upaimlimit * self.a.aimweight;
		var_09 = 1;
	}
	else if(param_05 < 0)
	{
		var_07 = param_05 / self.downaimlimit * self.a.aimweight;
		var_09 = 1;
	}

	self setanimlimited(param_00,var_07,0.1,1,1);
	self setanimlimited(param_01,var_08,0.1,1,1);
	self setanimlimited(param_02,var_0A,0.1,1,1);
	self setanimlimited(param_03,var_0B,0.1,1,1);
	if(isdefined(param_04))
	{
		self setanimlimited(param_04,var_09,0.1,1,1);
	}
}

//Function Number: 8
setanimaimweight(param_00,param_01)
{
	if(!isdefined(param_01) || param_01 <= 0)
	{
		self.a.aimweight = param_00;
		self.a.aimweight_start = param_00;
		self.a.aimweight_end = param_00;
		self.a.aimweight_transframes = 0;
	}
	else
	{
		if(!isdefined(self.a.aimweight))
		{
			self.a.aimweight = 0;
		}

		self.a.aimweight_start = self.a.aimweight;
		self.a.aimweight_end = param_00;
		self.a.aimweight_transframes = int(param_01 * 20);
	}

	self.a.aimweight_t = 0;
}

//Function Number: 9
incranimaimweight()
{
	if(self.a.aimweight_t < self.a.aimweight_transframes)
	{
		self.a.aimweight_t++;
		var_00 = 1 * self.a.aimweight_t / self.a.aimweight_transframes;
		self.a.aimweight = self.a.aimweight_start * 1 - var_00 + self.a.aimweight_end * var_00;
	}
}