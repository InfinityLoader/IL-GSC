/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\track.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 9
 * Decompile Time: 156 ms
 * Timestamp: 10/27/2023 2:30:55 AM
*******************************************************************/

//Function Number: 1
trackshootentorpos()
{
	self endon("killanimscript");
	self endon("stop tracking");
	self endon("melee");
	trackloop(%aim_2,%aim_4,%aim_6,%aim_8);
}

//Function Number: 2
trackloop(param_00,param_01,param_02,param_03)
{
	var_04 = 0;
	var_05 = 0;
	var_06 = (0,0,0);
	var_07 = 1;
	var_08 = 0;
	var_09 = 0;
	var_0A = 10;
	var_0B = (0,0,0);
	if(self.type == "dog")
	{
		var_0C = 0;
		self.shootent = self.enemy;
	}
	else
	{
		var_0C = 1;
		var_0D = 0;
		var_0E = 0;
		if(isdefined(self.var_897))
		{
			var_0D = level.var_898;
		}

		if((self.script == "cover_left" || self.script == "cover_right") && isdefined(self.a.var_899) && self.a.var_899 == "lean")
		{
			var_0E = self.covernode.angles[1] - self.angles[1];
		}

		var_0B = (var_0D,var_0E,0);
	}

	for(;;)
	{
		incranimaimweight();
		var_0F = animscripts/shared::func_89B();
		var_10 = self.shootpos;
		if(isdefined(self.shootent))
		{
			var_10 = self.shootent getshootatpos();
		}

		if(!isdefined(var_10) && animscripts/utility::shouldcqb())
		{
			var_10 = trackloop_cqbshootpos(var_0F);
		}

		var_11 = isdefined(self.var_89E) || isdefined(self.onatv);
		var_12 = isdefined(var_10);
		var_13 = (0,0,0);
		if(var_12)
		{
			var_13 = var_10;
		}

		var_14 = 0;
		var_15 = isdefined(self.stepoutyaw);
		if(var_15)
		{
			var_14 = self.stepoutyaw;
		}

		var_06 = self getaimangle(var_0F,var_13,var_12,var_0B,var_14,var_15,var_11);
		var_16 = var_06[0];
		var_17 = var_06[1];
		var_06 = undefined;
		if(var_09 > 0)
		{
			var_09 = var_09 - 1;
			var_0A = max(10,var_0A - 5);
		}
		else if(self.relativedir && self.relativedir != var_08)
		{
			var_09 = 2;
			var_0A = 30;
		}
		else
		{
			var_0A = 10;
		}

		var_18 = squared(var_0A);
		var_08 = self.relativedir;
		var_19 = self.movemode != "stop" || !var_07;
		if(var_19)
		{
			var_1A = var_17 - var_04;
			if(squared(var_1A) > var_18)
			{
				var_17 = var_04 + clamp(var_1A,-1 * var_0A,var_0A);
				var_17 = clamp(var_17,self.leftaimlimit,self.rightaimlimit);
			}

			var_1B = var_16 - var_05;
			if(squared(var_1B) > var_18)
			{
				var_16 = var_05 + clamp(var_1B,-1 * var_0A,var_0A);
				var_16 = clamp(var_16,self.downaimlimit,self.upaimlimit);
			}
		}

		var_07 = 0;
		var_04 = var_17;
		var_05 = var_16;
		func_08AD(param_00,param_01,param_02,param_03,var_16,var_17);
		wait 0.05;
	}
}

//Function Number: 3
trackloop_cqbshootpos(param_00)
{
	var_01 = undefined;
	var_02 = anglestoforward(self.angles);
	if(isdefined(self.cqb_target))
	{
		var_01 = self.cqb_target getshootatpos();
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
trackloop_anglesfornoshootpos(param_00,param_01)
{
	if(animscripts/utility::recentlysawenemy())
	{
		var_02 = self.enemy getshootatpos() - self.enemy.origin;
		var_03 = self lastknownpos(self.enemy) + var_02;
		return trackloop_getdesiredangles(var_03 - param_00,param_01);
	}

	var_04 = 0;
	var_05 = 0;
	if(isdefined(self.node) && isdefined(level.iscombatscriptnode[self.node.type]) && distancesquared(self.origin,self.node.origin) < 16)
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
trackloop_getdesiredangles(param_00,param_01)
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
	if(isdefined(self.stepoutyaw))
	{
		var_06 = self.stepoutyaw - var_02[1];
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
trackloop_clampangles(param_00,param_01,param_02)
{
	if(isdefined(self.var_89E) || isdefined(self.onatv))
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
	else if(param_02 && abs(param_01) > level.maxanglecheckyawdelta || abs(param_00) > level.maxanglecheckpitchdelta)
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
func_08AD(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(param_05 > 0)
	{
		var_06 = param_05 / self.rightaimlimit * self.a.var_8AE;
		self setanimlimited(param_01,0,0.1,1,1);
		self setanimlimited(param_02,var_06,0.1,1,1);
	}
	else if(param_05 < 0)
	{
		var_06 = param_05 / self.leftaimlimit * self.a.var_8AE;
		self setanimlimited(param_02,0,0.1,1,1);
		self setanimlimited(param_01,var_06,0.1,1,1);
	}

	if(param_04 > 0)
	{
		var_06 = param_04 / self.upaimlimit * self.a.var_8AE;
		self setanimlimited(param_00,0,0.1,1,1);
		self setanimlimited(param_03,var_06,0.1,1,1);
		return;
	}

	if(param_04 < 0)
	{
		var_06 = param_04 / self.downaimlimit * self.a.var_8AE;
		self setanimlimited(param_03,0,0.1,1,1);
		self setanimlimited(param_00,var_06,0.1,1,1);
	}
}

//Function Number: 8
setanimaimweight(param_00,param_01)
{
	if(!isdefined(param_01) || param_01 <= 0)
	{
		self.a.var_8AE = param_00;
		self.a.aimweight_start = param_00;
		self.a.aimweight_end = param_00;
		self.a.aimweight_transframes = 0;
	}
	else
	{
		if(!isdefined(self.a.var_8AE))
		{
			self.a.var_8AE = 0;
		}

		self.a.aimweight_start = self.a.var_8AE;
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
		self.a.var_8AE = self.a.aimweight_start * 1 - var_00 + self.a.aimweight_end * var_00;
	}
}