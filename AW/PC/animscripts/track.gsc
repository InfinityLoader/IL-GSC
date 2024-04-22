/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: track.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 9
 * Decompile Time: 156 ms
 * Timestamp: 4/22/2024 2:01:04 AM
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
trackloop(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = 0;
	var_06 = 0;
	var_07 = (0,0,0);
	var_08 = 1;
	var_09 = 0;
	var_0A = 0;
	var_0B = 10;
	var_0C = (0,0,0);
	var_0D = 0;
	var_0E = 0;
	var_0F = 0;
	var_10 = 0;
	var_11 = 0.1;
	var_12 = 0;
	if(self.type == "dog")
	{
		var_13 = 0;
		self.shootent = self.enemy;
	}
	else
	{
		var_13 = 1;
		var_14 = 0;
		var_15 = 0;
		if(isdefined(self.covercrouchlean_aimmode))
		{
			var_14 = level.covercrouchleanpitch;
		}

		var_16 = self.script;
		if(var_16 == "cover_multi")
		{
			if(self.cover.state == "right")
			{
				var_16 = "cover_right";
			}
			else if(self.cover.state == "left")
			{
				var_16 = "cover_left";
			}
		}

		if((var_16 == "cover_left" || var_16 == "cover_right") && isdefined(self.a.cornermode) && self.a.cornermode == "lean")
		{
			var_15 = self.covernode.angles[1] - self.angles[1];
		}

		var_0C = (var_14,var_15,0);
	}

	for(;;)
	{
		incranimaimweight();
		if(self gettagindex("tag_flash") == -1)
		{
			wait(0.05);
			continue;
		}

		var_17 = animscripts\shared::getshootfrompos();
		var_18 = self.shootpos;
		if(isdefined(self.shootent))
		{
			if(common_scripts\utility::flag("_cloaked_stealth_enabled"))
			{
				var_18 = animscripts\combat_utility::get_last_known_shoot_pos(self.shootent);
			}
			else
			{
				var_18 = self.shootent getshootatpos();
			}
		}

		if(!isdefined(var_18) && animscripts\utility::shouldcqb())
		{
			var_18 = trackloop_cqbshootpos(var_17);
		}

		var_19 = isdefined(self.onsnowmobile) || isdefined(self.onatv);
		var_1A = isdefined(var_18);
		var_1B = (0,0,0);
		if(var_1A)
		{
			var_1B = var_18;
		}

		var_1C = 0;
		var_1D = isdefined(self.stepoutyaw);
		if(var_1D)
		{
			var_1C = self.stepoutyaw;
		}

		var_07 = self getaimangle(var_17,var_1B,var_1A,var_0C,var_1C,var_1D,var_19);
		var_1E = var_07[0];
		var_1F = var_07[1];
		var_07 = undefined;
		if(animscripts\utility::isspaceai())
		{
			var_20 = self.angles[2] * -1;
			var_21 = var_1E * cos(var_20) - var_1F * sin(var_20);
			var_22 = var_1E * sin(var_20) + var_1F * cos(var_20);
			var_1E = var_21;
			var_1F = var_22;
			var_1E = clamp(var_1E,self.downaimlimit,self.upaimlimit);
			var_1F = clamp(var_1F,self.leftaimlimit,self.rightaimlimit);
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

		var_23 = squared(var_0B);
		var_09 = self.relativedir;
		var_24 = self.movemode != "stop" || !var_08;
		if(var_24)
		{
			var_25 = var_1F - var_05;
			if(squared(var_25) > var_23)
			{
				var_1F = var_05 + clamp(var_25,-1 * var_0B,var_0B);
				var_1F = clamp(var_1F,self.leftaimlimit,self.rightaimlimit);
			}

			var_26 = var_1E - var_06;
			if(squared(var_26) > var_23)
			{
				var_1E = var_06 + clamp(var_26,-1 * var_0B,var_0B);
				var_1E = clamp(var_1E,self.downaimlimit,self.upaimlimit);
			}
		}

		var_08 = 0;
		var_05 = var_1F;
		var_06 = var_1E;
		trackloop_setanimweights(param_00,param_01,param_02,param_03,param_04,var_1E,var_1F);
		wait(0.05);
	}
}

//Function Number: 3
trackloop_cqbshootpos(param_00)
{
	var_01 = undefined;
	var_02 = anglestoforward(self.angles);
	if(isdefined(self.cqb_target))
	{
		if(common_scripts\utility::flag("_cloaked_stealth_enabled"))
		{
			var_01 = animscripts\combat_utility::get_last_known_shoot_pos(self.cqb_target);
		}
		else
		{
			var_01 = self.cqb_target getshootatpos();
		}

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
	if(animscripts\utility::recentlysawenemy())
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
		if(!isdefined(self.mech) || isdefined(self.mech) && !self.mech)
		{
			var_03 = -40;
		}
	}
	else if(self.stairsstate == "down")
	{
		if(!isdefined(self.mech) || isdefined(self.mech) && !self.mech)
		{
			var_03 = 40;
			var_04 = 12;
		}
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
	if(isdefined(self.onsnowmobile) || isdefined(self.onatv))
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
trackloop_setanimweights(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	var_07 = 0;
	var_08 = 0;
	var_09 = 0;
	var_0A = 0;
	var_0B = 0;
	var_0C = 0.1;
	if(isdefined(self.aimblendtime))
	{
		var_0C = self.aimblendtime;
	}

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

	self setanimlimited(param_00,var_07,var_0C,1,1);
	self setanimlimited(param_01,var_08,var_0C,1,1);
	self setanimlimited(param_02,var_0A,var_0C,1,1);
	self setanimlimited(param_03,var_0B,var_0C,1,1);
	if(isdefined(param_04))
	{
		self setanimlimited(param_04,var_09,var_0C,1,1);
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