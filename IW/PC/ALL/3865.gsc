/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3865.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 12
 * Decompile Time: 4 ms
 * Timestamp: 10/27/2023 12:31:03 AM
*******************************************************************/

//Function Number: 1
func_4682()
{
	self.var_10E6D.var_466C = spawnstruct();
}

//Function Number: 2
func_4683()
{
	if(isdefined(level.var_10E6D) && isdefined(level.var_10E6D.var_466C))
	{
		return;
	}

	func_4681();
	level.var_10E6D.var_466C = spawnstruct();
	level.var_10E6D.var_466C.var_E237 = 30;
	level lib_0F27::func_F5B4("saw_corpse",::func_4687);
	level lib_0F27::func_F5B4("found_corpse",::func_467E);
	func_F30F();
}

//Function Number: 3
func_4681()
{
	level.var_EC85["generic"]["check_body_1"] = %hm_grnd_yel_patrol_seekclear_checkbody_ar_01;
	level.var_EC85["generic"]["check_body_2"] = %hm_grnd_yel_patrol_seekclear_checkbody_ar_02;
	level.var_EC85["generic"]["check_body_3"] = %hm_grnd_yel_patrol_seekclear_checkbody_ar_03;
	level.var_EC85["generic"]["check_body_4"] = %hm_grnd_yel_patrol_seekclear_checkbody_ar_04;
}

//Function Number: 4
func_F30F()
{
	var_00["sight_dist"] = 600;
	var_00["detect_dist"] = 300;
	var_00["found_dist"] = 100;
	func_F30E(var_00);
}

//Function Number: 5
func_F30E(param_00)
{
	level.var_10E6D.var_466C.var_101E0 = squared(param_00["sight_dist"]);
	level.var_10E6D.var_466C.var_53A1 = squared(param_00["detect_dist"]);
	level.var_10E6D.var_466C.var_733B = squared(param_00["found_dist"]);
}

//Function Number: 6
func_F30D()
{
	level.var_10E6D.var_930F[self getentitynumber()] = self.origin;
}

//Function Number: 7
func_468A()
{
	if(isdefined(self.var_10E6D.var_4686) && gettime() < self.var_10E6D.var_4686)
	{
		return;
	}

	if(scripts\sp\_utility::func_65DB("stealth_hold_position"))
	{
		return;
	}

	if(self.var_180)
	{
		return;
	}

	if(scripts\common\utility::istrue(self.var_10E6D.var_466C.var_9B2C))
	{
		return;
	}

	if(isdefined(self.var_10E6D.var_466C.var_65D3))
	{
		self.var_10E6D.var_4686 = gettime() + 100;
	}
	else
	{
		self.var_10E6D.var_4686 = gettime() + 1000;
	}

	var_00 = function_0083();
	var_01 = undefined;
	var_02 = undefined;
	foreach(var_04 in var_00)
	{
		var_05 = var_04 getentitynumber();
		if(isdefined(level.var_10E6D.var_930F) && isdefined(level.var_10E6D.var_930F[var_05]) && distancesquared(level.var_10E6D.var_930F[var_05],var_04.origin) < squared(100))
		{
			level.var_10E6D.var_930F[var_05] = undefined;
			var_04.var_7339 = 1;
		}

		if(isdefined(var_04.var_7339))
		{
			continue;
		}

		var_06 = var_04 scripts\sp\_utility::func_78E4();
		var_07 = distancesquared(self.origin,var_06);
		var_08 = level.var_10E6D.var_466C.var_733B;
		var_09 = level.var_10E6D.var_466C.var_101E0;
		var_0A = level.var_10E6D.var_466C.var_53A1;
		if(isdefined(self.var_10E6D.var_C810))
		{
			var_08 = self.var_10E6D.var_C810 * self.var_10E6D.var_C810;
		}

		if(isdefined(self.var_10E6D.var_C811))
		{
			var_09 = self.var_10E6D.var_C811 * self.var_10E6D.var_C811;
		}

		if(isdefined(self.var_10E6D.var_C80F))
		{
			var_0A = self.var_10E6D.var_C80F * self.var_10E6D.var_C80F;
		}

		if(var_07 < var_08)
		{
			if(abs(self.origin[2] - var_06[2]) < 60)
			{
				var_01 = var_04;
				break;
			}
		}

		if(isdefined(self.var_10E6D.var_466C.var_65D3))
		{
			if(self.var_10E6D.var_466C.var_65D3 == var_04)
			{
				continue;
			}

			var_0B = self.var_10E6D.var_466C.var_65D3 scripts\sp\_utility::func_78E4();
			var_0C = distancesquared(self.origin,var_0B);
			if(var_0C <= var_07)
			{
				continue;
			}
		}

		if(var_07 > var_09)
		{
			continue;
		}

		if(var_06[2] - self.origin[2] > 128)
		{
			continue;
		}

		if(var_07 < var_0A)
		{
			if(!isdefined(var_04.var_F182) && self method_805F(var_04))
			{
				var_02 = var_04;
				break;
			}
		}

		var_0D = anglestoforward(self gettagangles("tag_eye"));
		var_0E = vectornormalize(var_06 + (0,0,30) - self geteye());
		if(vectordot(var_0D,var_0E) > 0.55)
		{
			if(!isdefined(var_04.var_F182) && self method_805F(var_04))
			{
				var_02 = var_04;
				break;
			}
		}
	}

	if(isdefined(var_01))
	{
		var_01.var_7339 = 1;
		if(scripts\common\utility::istrue(var_01.var_F182) && isdefined(self.var_10E6D.var_466C.var_65D3) && self.var_10E6D.var_466C.var_65D3 == var_01)
		{
			self.var_10E6D.var_C997 = gettime();
		}

		self method_84F7("found_corpse",var_01,var_01 scripts\sp\_utility::func_78E4());
		return;
	}

	if(isdefined(var_02))
	{
		thread func_4688(var_02);
		self method_84F7("saw_corpse",var_02,var_02 scripts\sp\_utility::func_78E4());
	}
}

//Function Number: 8
func_467E(param_00)
{
	self notify("investigate_behavior");
	self notify("stop_runto_and_lookaround");
	self notify("corpse_found");
	self endon("corpse_found");
	self endon("death");
	self endon("investigate_behavior");
	self endon("stop_runto_and_lookaround");
	var_01 = param_00.var_114;
	var_02 = var_01 scripts\sp\_utility::func_78E4();
	if(isdefined(self.var_10E6D.var_466C.var_65D3))
	{
		self.var_10E6D.var_466C.var_65D3.var_F182 = undefined;
	}

	self.var_10E6D.var_466C.var_65D3 = undefined;
	var_01 method_82CB(level.var_10E6D.var_466C.var_E237);
	if(!isdefined(self.var_1FBB) && isdefined(self.var_1FEC) && self.var_1FEC == "generic_human")
	{
		self.var_1FBB = "generic";
	}

	var_03 = ["check_body_1","check_body_2","check_body_3","check_body_4"];
	var_04 = var_03[randomint(var_03.size)];
	self.var_10E6D.var_466C.var_9B2C = 1;
	lib_0F27::func_CD58(var_02,var_04);
	thread func_467C();
	param_00.origin = self.origin + anglestoforward((0,randomfloatrange(0,360),0)) * 100;
	param_00.var_9B22 = getclosestpointonnavmesh(param_00.origin,self);
	self.var_10E6D.var_C997 = gettime();
	thread lib_0F22::func_9B24(param_00);
}

//Function Number: 9
func_4687(param_00)
{
	var_01 = param_00.var_114;
	var_02 = var_01 scripts\sp\_utility::func_78E4();
	self.var_10E6D.var_466C.origin = var_02;
	thread func_4688(var_01);
	thread func_4689(var_01);
	self.var_10E6D.var_C985 = undefined;
}

//Function Number: 10
func_4688(param_00)
{
	self notify("corpse_seen_claim");
	self endon("corpse_seen_claim");
	if(isdefined(self.var_10E6D.var_466C.var_65D3))
	{
		self.var_10E6D.var_466C.var_65D3.var_F182 = undefined;
	}

	param_00.var_F182 = 1;
	self.var_10E6D.var_466C.var_65D3 = param_00;
	self waittill("death");
	if(isdefined(param_00))
	{
		param_00.var_F182 = undefined;
	}

	if(isdefined(self))
	{
		thread func_467C();
	}
}

//Function Number: 11
func_4689(param_00)
{
	self endon("death");
	param_00 endon("death");
	self notify("corpse_seen_follow");
	self endon("corpse_seen_follow");
	self endon("investigate_behavior");
	self endon("stop_runto_and_lookaround");
	self endon("corpse_found");
	var_01 = self.origin;
	var_02 = self.origin;
	for(;;)
	{
		wait(0.05);
		if(!isdefined(param_00))
		{
			return;
		}

		var_03 = param_00 scripts\sp\_utility::func_78E4();
		if(distancesquared(var_01,var_03) > 0.1)
		{
			var_01 = var_03;
			var_04 = getclosestpointonnavmesh(var_01,self);
			if(distancesquared(var_03,var_02) > 0.1)
			{
				var_02 = var_04;
				scripts\sp\_utility::func_F3DC(var_02);
			}
		}
	}
}

//Function Number: 12
func_467C()
{
	if(isdefined(self.var_10E6D.var_466C))
	{
		if(isdefined(self.var_10E6D.var_466C.var_65D3))
		{
			self.var_10E6D.var_466C.var_65D3.var_F182 = undefined;
		}

		self.var_10E6D.var_466C.var_65D3 = undefined;
		self.var_10E6D.var_466C.var_9B2C = undefined;
	}
}