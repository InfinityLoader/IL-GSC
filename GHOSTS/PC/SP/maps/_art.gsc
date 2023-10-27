/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_art.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 26
 * Decompile Time: 413 ms
 * Timestamp: 10/27/2023 1:27:09 AM
*******************************************************************/

//Function Number: 1
func_4FDD()
{
	level.current_sunflare_setting = "default";
	level._clearalltextafterhudelem = 0;
	func_2886();
	tess_init();
	precachemenu("dev_vision_noloc");
	precachemenu("dev_vision_exec");
	level.var_78E4 = [];
	level.var_18D7 = [];
	if(!isdefined(level.var_8A06))
	{
		level.var_8A06 = spawnstruct();
		level.var_8A06.var_89FF = "";
		level.var_8A06.time = 0;
	}

	if(!isdefined(level.var_7D4B))
	{
		level.var_7D4B = [];
	}

	if(!isdefined(level.var_8A01))
	{
		level.var_8A01 = [];
		func_2073(level.script);
		common_scripts\_artcommon::func_7038();
	}

	if(!isdefined(level.script))
	{
		level.script = tolower(getdvar("mapname"));
	}
}

//Function Number: 2
func_2073(param_00)
{
	var_01 = maps\_utility::create_vision_set_fog(param_00);
	var_01.startdist = 3764.17;
	var_01.halfwaydist = 19391;
	var_01.red = 0.661137;
	var_01.green = 0.554261;
	var_01.blue = 0.454014;
	var_01.maxopacity = 0.7;
	var_01.transitiontime = 0;
	var_01.skyfogintensity = 0;
	var_01.skyfogminangle = 0;
	var_01.skyfogmaxangle = 0;
}

//Function Number: 3
dof_set_generic(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	level.var_287A[param_00][param_01]["nearStart"] = param_02;
	level.var_287A[param_00][param_01]["nearEnd"] = param_03;
	level.var_287A[param_00][param_01]["nearBlur"] = param_04;
	level.var_287A[param_00][param_01]["farStart"] = param_05;
	level.var_287A[param_00][param_01]["farEnd"] = param_06;
	level.var_287A[param_00][param_01]["farBlur"] = param_07;
	level.var_287A[param_00][param_01]["weight"] = param_08;
}

//Function Number: 4
dof_blend_interior_generic(param_00)
{
	if(level.var_287A[param_00]["timeRemaining"] <= 0)
	{
	}

	var_01 = min(1,0.05 / level.var_287A[param_00]["timeRemaining"]);
	level.var_287A[param_00]["timeRemaining"] = level.var_287A[param_00]["timeRemaining"] - 0.05;
	if(level.var_287A[param_00]["timeRemaining"] <= 0)
	{
		level.var_287A[param_00]["timeRemaining"] = 0;
		level.var_287A[param_00]["current"]["nearStart"] = level.var_287A[param_00]["goal"]["nearStart"];
		level.var_287A[param_00]["current"]["nearEnd"] = level.var_287A[param_00]["goal"]["nearEnd"];
		level.var_287A[param_00]["current"]["nearBlur"] = level.var_287A[param_00]["goal"]["nearBlur"];
		level.var_287A[param_00]["current"]["farStart"] = level.var_287A[param_00]["goal"]["farStart"];
		level.var_287A[param_00]["current"]["farEnd"] = level.var_287A[param_00]["goal"]["farEnd"];
		level.var_287A[param_00]["current"]["farBlur"] = level.var_287A[param_00]["goal"]["farBlur"];
		level.var_287A[param_00]["current"]["weight"] = level.var_287A[param_00]["goal"]["weight"];
	}

	level.var_287A[param_00]["current"]["nearStart"] = level.var_287A[param_00]["current"]["nearStart"] + var_01 * level.var_287A[param_00]["goal"]["nearStart"] - level.var_287A[param_00]["current"]["nearStart"];
	level.var_287A[param_00]["current"]["nearEnd"] = level.var_287A[param_00]["current"]["nearEnd"] + var_01 * level.var_287A[param_00]["goal"]["nearEnd"] - level.var_287A[param_00]["current"]["nearEnd"];
	level.var_287A[param_00]["current"]["nearBlur"] = level.var_287A[param_00]["current"]["nearBlur"] + var_01 * level.var_287A[param_00]["goal"]["nearBlur"] - level.var_287A[param_00]["current"]["nearBlur"];
	level.var_287A[param_00]["current"]["farStart"] = level.var_287A[param_00]["current"]["farStart"] + var_01 * level.var_287A[param_00]["goal"]["farStart"] - level.var_287A[param_00]["current"]["farStart"];
	level.var_287A[param_00]["current"]["farEnd"] = level.var_287A[param_00]["current"]["farEnd"] + var_01 * level.var_287A[param_00]["goal"]["farEnd"] - level.var_287A[param_00]["current"]["farEnd"];
	level.var_287A[param_00]["current"]["farBlur"] = level.var_287A[param_00]["current"]["farBlur"] + var_01 * level.var_287A[param_00]["goal"]["farBlur"] - level.var_287A[param_00]["current"]["farBlur"];
	level.var_287A[param_00]["current"]["weight"] = level.var_287A[param_00]["current"]["weight"] + var_01 * level.var_287A[param_00]["goal"]["weight"] - level.var_287A[param_00]["current"]["weight"];
}

//Function Number: 5
func_2886()
{
	if(getdvar("scr_dof_enable") == "")
	{
		setsaveddvar("scr_dof_enable","1");
	}

	setdvar("ads_dof_tracedist",8192);
	setdvar("ads_dof_maxEnemyDist",10000);
	setdvar("ads_dof_playerForgetEnemyTime",5000);
	setdvar("ads_dof_nearStartScale",0.25);
	setdvar("ads_dof_nearEndScale",0.85);
	setdvar("ads_dof_farStartScale",1.15);
	setdvar("ads_dof_farEndScale",3);
	setdvar("ads_dof_nearBlur",4);
	setdvar("ads_dof_farBlur",1.5);
	setdvar("ads_dof_debug",0);
	var_00 = 1;
	var_01 = 1;
	var_02 = 4.5;
	var_03 = 500;
	var_04 = 500;
	var_05 = 0.05;
	level.var_287A = [];
	level.var_287A["base"] = [];
	level.var_287A["base"]["current"] = [];
	level.var_287A["base"]["goal"] = [];
	level.var_287A["base"]["timeRemaining"] = 0;
	dof_set_generic("base","current",var_00,var_01,var_02,var_03,var_04,var_05,1);
	dof_set_generic("base","goal",0,0,0,0,0,0,0);
	level.var_287A["script"] = [];
	level.var_287A["script"]["current"] = [];
	level.var_287A["script"]["goal"] = [];
	level.var_287A["script"]["timeRemaining"] = 0;
	dof_set_generic("script","current",0,0,0,0,0,0,0);
	dof_set_generic("script","goal",0,0,0,0,0,0,0);
	level.var_287A["ads"] = [];
	level.var_287A["ads"]["current"] = [];
	level.var_287A["ads"]["goal"] = [];
	dof_set_generic("ads","current",0,0,0,0,0,0,0);
	dof_set_generic("ads","goal",0,0,0,0,0,0,0);
	level.var_287A["results"] = [];
	level.var_287A["results"]["current"] = [];
	dof_set_generic("results","current",var_00,var_01,var_02,var_03,var_04,var_05,1);
	foreach(var_07 in level.players)
	{
		var_07 thread func_2891();
	}
}

//Function Number: 6
func_288C(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	dof_set_generic("base","goal",param_00,param_01,param_02,param_03,param_04,param_05,1);
	level.var_287A["base"]["timeRemaining"] = param_06;
	if(param_06 <= 0)
	{
		dof_set_generic("base","current",param_00,param_01,param_02,param_03,param_04,param_05,1);
	}
}

//Function Number: 7
dof_enable_script(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	dof_set_generic("script","goal",param_00,param_01,param_02,param_03,param_04,param_05,1);
	level.var_287A["script"]["timeRemaining"] = param_06;
	if(param_06 <= 0)
	{
		dof_set_generic("script","current",param_00,param_01,param_02,param_03,param_04,param_05,1);
	}

	if(level.var_287A["script"]["current"]["weight"] <= 0)
	{
		dof_set_generic("script","current",param_00,param_01,param_02,param_03,param_04,param_05,0);
	}
}

//Function Number: 8
func_2883(param_00)
{
	level.var_287A["script"]["goal"]["weight"] = 0;
	level.var_287A["script"]["timeRemaining"] = param_00;
	if(param_00 <= 0)
	{
		level.var_287A["script"]["current"]["weight"] = 0;
	}
}

//Function Number: 9
dof_enable_ads(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	dof_set_generic("ads","goal",param_00,param_01,param_02,param_03,param_04,param_05,param_06);
	if(level.var_287A["ads"]["current"]["weight"] <= 0)
	{
		dof_set_generic("ads","current",param_00,param_01,param_02,param_03,param_04,param_05,0);
	}
}

//Function Number: 10
dof_blend_interior_ads_element(param_00,param_01,param_02,param_03)
{
	if(param_00 > param_01)
	{
		var_04 = param_00 - param_01 * param_03;
		if(var_04 > param_02)
		{
			var_04 = param_02;
		}
		else if(var_04 < 1)
		{
			var_04 = 1;
		}

		if(param_00 - var_04 <= param_01)
		{
			return param_01;
		}
		else
		{
			return param_00 - var_04;
		}
	}
	else if(param_00 < param_01)
	{
		var_04 = param_01 - param_00 * param_03;
		if(var_04 > param_02)
		{
			var_04 = param_02;
		}
		else if(var_04 < 1)
		{
			var_04 = 1;
		}

		if(param_00 + var_04 >= param_01)
		{
			return param_01;
		}
		else
		{
			return param_00 + var_04;
		}
	}

	return param_00;
}

//Function Number: 11
dof_blend_interior_ads()
{
	var_00 = level.var_287A["ads"]["goal"]["weight"];
	if(var_00 < 1)
	{
		if(self adsbuttonpressed() && self playerads() > 0)
		{
			var_00 = min(1,var_00 + 0.7);
		}
		else
		{
			var_00 = 0;
		}

		level.var_287A["ads"]["current"]["nearStart"] = level.var_287A["ads"]["goal"]["nearStart"];
		level.var_287A["ads"]["current"]["nearEnd"] = level.var_287A["ads"]["goal"]["nearEnd"];
		level.var_287A["ads"]["current"]["nearBlur"] = level.var_287A["ads"]["goal"]["nearBlur"];
		level.var_287A["ads"]["current"]["farStart"] = level.var_287A["ads"]["goal"]["farStart"];
		level.var_287A["ads"]["current"]["farEnd"] = level.var_287A["ads"]["goal"]["farEnd"];
		level.var_287A["ads"]["current"]["farBlur"] = level.var_287A["ads"]["goal"]["farBlur"];
		level.var_287A["ads"]["current"]["weight"] = var_00;
	}

	if(isdefined(level.dof_blend_interior_ads_scalar))
	{
		var_01 = level.dof_blend_interior_ads_scalar;
	}
	else
	{
		var_01 = 0.1;
	}

	var_02 = 10;
	var_03 = max(var_02,abs(level.var_287A["ads"]["current"]["nearStart"] - level.var_287A["ads"]["goal"]["nearStart"]) * var_01);
	var_04 = max(var_02,abs(level.var_287A["ads"]["current"]["nearEnd"] - level.var_287A["ads"]["goal"]["nearEnd"]) * var_01);
	var_05 = max(var_02,abs(level.var_287A["ads"]["current"]["farStart"] - level.var_287A["ads"]["goal"]["farStart"]) * var_01);
	var_06 = max(var_02,abs(level.var_287A["ads"]["current"]["farEnd"] - level.var_287A["ads"]["goal"]["farEnd"]) * var_01);
	var_07 = 0.1;
	level.var_287A["ads"]["current"]["nearStart"] = dof_blend_interior_ads_element(level.var_287A["ads"]["current"]["nearStart"],level.var_287A["ads"]["goal"]["nearStart"],var_03,0.33);
	level.var_287A["ads"]["current"]["nearEnd"] = dof_blend_interior_ads_element(level.var_287A["ads"]["current"]["nearEnd"],level.var_287A["ads"]["goal"]["nearEnd"],var_04,0.33);
	level.var_287A["ads"]["current"]["nearBlur"] = dof_blend_interior_ads_element(level.var_287A["ads"]["current"]["nearBlur"],level.var_287A["ads"]["goal"]["nearBlur"],var_07,0.33);
	level.var_287A["ads"]["current"]["farStart"] = dof_blend_interior_ads_element(level.var_287A["ads"]["current"]["farStart"],level.var_287A["ads"]["goal"]["farStart"],var_05,0.33);
	level.var_287A["ads"]["current"]["farEnd"] = dof_blend_interior_ads_element(level.var_287A["ads"]["current"]["farEnd"],level.var_287A["ads"]["goal"]["farEnd"],var_06,0.33);
	level.var_287A["ads"]["current"]["farBlur"] = dof_blend_interior_ads_element(level.var_287A["ads"]["current"]["farBlur"],level.var_287A["ads"]["goal"]["farBlur"],var_07,0.33);
	level.var_287A["ads"]["current"]["weight"] = 1;
}

//Function Number: 12
dof_disable_ads()
{
	level.var_287A["ads"]["goal"]["weight"] = 0;
	level.var_287A["ads"]["current"]["weight"] = 0;
}

//Function Number: 13
func_287B(param_00)
{
	var_01 = level.var_287A[param_00]["current"]["weight"];
	var_02 = 1 - var_01;
	level.var_287A["results"]["current"]["nearStart"] = level.var_287A["results"]["current"]["nearStart"] * var_02 + level.var_287A[param_00]["current"]["nearStart"] * var_01;
	level.var_287A["results"]["current"]["nearEnd"] = level.var_287A["results"]["current"]["nearEnd"] * var_02 + level.var_287A[param_00]["current"]["nearEnd"] * var_01;
	level.var_287A["results"]["current"]["nearBlur"] = level.var_287A["results"]["current"]["nearBlur"] * var_02 + level.var_287A[param_00]["current"]["nearBlur"] * var_01;
	level.var_287A["results"]["current"]["farStart"] = level.var_287A["results"]["current"]["farStart"] * var_02 + level.var_287A[param_00]["current"]["farStart"] * var_01;
	level.var_287A["results"]["current"]["farEnd"] = level.var_287A["results"]["current"]["farEnd"] * var_02 + level.var_287A[param_00]["current"]["farEnd"] * var_01;
	level.var_287A["results"]["current"]["farBlur"] = level.var_287A["results"]["current"]["farBlur"] * var_02 + level.var_287A[param_00]["current"]["farBlur"] * var_01;
}

//Function Number: 14
func_2880()
{
	dof_blend_interior_generic("base");
	dof_blend_interior_generic("script");
	dof_blend_interior_ads();
	func_287B("base");
	func_287B("script");
	func_287B("ads");
	var_00 = level.var_287A["results"]["current"]["nearStart"];
	var_01 = level.var_287A["results"]["current"]["nearEnd"];
	var_02 = level.var_287A["results"]["current"]["nearBlur"];
	var_03 = level.var_287A["results"]["current"]["farStart"];
	var_04 = level.var_287A["results"]["current"]["farEnd"];
	var_05 = level.var_287A["results"]["current"]["farBlur"];
	var_00 = max(0,var_00);
	var_01 = max(0,var_01);
	var_03 = max(0,var_03);
	var_04 = max(0,var_04);
	var_02 = max(4,var_02);
	var_02 = min(10,var_02);
	var_05 = max(0,var_05);
	var_05 = min(var_02,var_05);
	if(var_05 > 0)
	{
		var_03 = max(var_01,var_03);
	}

	level.var_287A["results"]["current"]["nearStart"] = var_00;
	level.var_287A["results"]["current"]["nearEnd"] = var_01;
	level.var_287A["results"]["current"]["nearBlur"] = var_02;
	level.var_287A["results"]["current"]["farStart"] = var_03;
	level.var_287A["results"]["current"]["farEnd"] = var_04;
	level.var_287A["results"]["current"]["farBlur"] = var_05;
}

//Function Number: 15
dof_process_ads()
{
	var_00 = self playerads();
	if(var_00 <= 0)
	{
		dof_disable_ads();
	}

	if(isdefined(level.var_2221))
	{
		[[ level.var_2221 ]]();
	}

	var_01 = getdvarfloat("ads_dof_tracedist",4096);
	var_02 = getdvarfloat("ads_dof_maxEnemyDist",0);
	var_03 = getdvarint("ads_dof_playerForgetEnemyTime",5000);
	var_04 = getdvarfloat("ads_dof_nearStartScale",0.25);
	var_05 = getdvarfloat("ads_dof_nearEndScale",0.85);
	var_06 = getdvarfloat("ads_dof_farStartScale",1.15);
	var_07 = getdvarfloat("ads_dof_farEndScale",3);
	var_08 = getdvarfloat("ads_dof_nearBlur",4);
	var_09 = getdvarfloat("ads_dof_farBlur",2.5);
	var_0A = self geteye();
	var_0B = self getplayerangles();
	if(isdefined(self.dof_ref_ent))
	{
		var_0C = combineangles(self.dof_ref_ent.angles,var_0B);
	}
	else
	{
		var_0C = var_0C;
	}

	var_0D = vectornormalize(anglestoforward(var_0C));
	var_0E = bullettrace(var_0A,var_0A + var_0D * var_01,1,self,1,0,0,0,0);
	var_0F = getaiarray("axis");
	var_10 = self getcurrentweapon();
	if(isdefined(level.var_78E4[var_10]))
	{
		[[ level.var_78E4[var_10] ]](var_0E,var_0F,var_0A,var_0D,var_00);
	}

	if(var_0E["fraction"] == 1)
	{
		var_01 = 2048;
		var_11 = 256;
		var_12 = var_01 * var_06 * 2;
	}
	else
	{
		var_03 = distance(var_0C,var_10["position"]);
		var_11 = var_03 * var_06;
		var_12 = var_02 * var_07;
	}

	foreach(var_14 in var_0F)
	{
		var_15 = var_14 isenemyaware();
		var_16 = var_14 hasenemybeenseen(var_03);
		if(!var_15 && !var_16)
		{
			continue;
		}

		var_17 = vectornormalize(var_14.origin - var_0A);
		var_18 = vectordot(var_0D,var_17);
		if(var_18 < 0.923)
		{
			continue;
		}

		var_19 = distance(var_0A,var_14.origin);
		if(var_19 - 30 < var_11)
		{
			var_11 = var_19 - 30;
		}

		var_1A = min(var_19,var_02);
		if(var_1A + 30 > var_12)
		{
			var_12 = var_1A + 30;
		}
	}

	if(var_11 > var_12)
	{
		var_11 = var_12 - 256;
	}

	if(var_11 > var_01)
	{
		var_11 = var_01 - 30;
	}

	if(var_11 < 1)
	{
		var_11 = 1;
	}

	if(var_12 < var_01)
	{
		var_12 = var_01;
	}

	var_1C = var_11 * var_04;
	var_1D = var_12 * var_07;
	dof_enable_ads(var_1C,var_11,var_08,var_12,var_1D,var_09,var_00);
}

//Function Number: 16
javelin_dof(param_00,param_01,param_02,param_03,param_04)
{
	if(param_04 < 0.88)
	{
		dof_disable_ads();
	}

	var_05 = 10000;
	var_06 = -1;
	var_05 = 2400;
	var_07 = 2400;
	for(var_08 = 0;var_08 < param_01.size;var_08++)
	{
		var_09 = vectornormalize(param_01[var_08].origin - param_02);
		var_0A = vectordot(param_03,var_09);
		if(var_0A < 0.923)
		{
			continue;
		}

		var_0B = distance(param_02,param_01[var_08].origin);
		if(var_0B < 2500)
		{
			var_0B = 2500;
		}

		if(var_0B - 30 < var_05)
		{
			var_05 = var_0B - 30;
		}

		if(var_0B + 30 > var_06)
		{
			var_06 = var_0B + 30;
		}
	}

	if(var_05 > var_06)
	{
		var_05 = 2400;
		var_06 = 3000;
	}
	else
	{
		if(var_05 < 50)
		{
			var_05 = 50;
		}

		if(var_06 > 2500)
		{
			var_06 = 2500;
		}
		else if(var_06 < 1000)
		{
			var_06 = 1000;
		}
	}

	var_0C = distance(param_02,param_00["position"]);
	if(var_0C < 2500)
	{
		var_0C = 2500;
	}

	if(var_05 > var_0C)
	{
		var_05 = var_0C - 30;
	}

	if(var_05 < 1)
	{
		var_05 = 1;
	}

	if(var_06 < var_0C)
	{
		var_06 = var_0C;
	}

	if(var_07 >= var_05)
	{
		var_07 = var_05 - 1;
	}

	var_0D = var_06 * 4;
	var_0E = 4;
	var_0F = 1.8;
	dof_enable_ads(var_07,var_05,var_0E,var_06,var_0D,var_0F,param_04);
}

//Function Number: 17
func_2891()
{
	for(;;)
	{
		common_scripts\utility::func_8AFE();
		if(level.level_specific_dof)
		{
			continue;
		}

		if(!getdvarint("scr_dof_enable"))
		{
			continue;
		}

		dof_process_ads();
		func_2880();
		var_00 = level.var_287A["results"]["current"]["nearStart"];
		var_01 = level.var_287A["results"]["current"]["nearEnd"];
		var_02 = level.var_287A["results"]["current"]["farStart"];
		var_03 = level.var_287A["results"]["current"]["farEnd"];
		var_04 = level.var_287A["results"]["current"]["nearBlur"];
		var_05 = level.var_287A["results"]["current"]["farBlur"];
		self setdepthoffield(var_00,var_01,var_02,var_03,var_04,var_05);
	}
}

//Function Number: 18
tess_init()
{
	var_00 = getdvar("r_tessellation");
	if(var_00 == "")
	{
	}

	level.tess = spawnstruct();
	level.tess.cutoff_distance_current = getdvarfloat("r_tessellationCutoffDistance",960);
	level.tess.cutoff_distance_goal = level.tess.cutoff_distance_current;
	level.tess.cutoff_falloff_current = getdvarfloat("r_tessellationCutoffFalloff",320);
	level.tess.cutoff_falloff_goal = level.tess.cutoff_falloff_current;
	level.tess.time_remaining = 0;
	foreach(var_02 in level.players)
	{
		var_02 thread tess_update();
	}
}

//Function Number: 19
tess_set_goal(param_00,param_01,param_02)
{
	level.tess.cutoff_distance_goal = param_00;
	level.tess.cutoff_falloff_goal = param_01;
	level.tess.time_remaining = param_02;
}

//Function Number: 20
tess_update()
{
	for(;;)
	{
		var_00 = level.tess.cutoff_distance_current;
		var_01 = level.tess.cutoff_falloff_current;
		common_scripts\utility::func_8AFE();
		if(level.tess.time_remaining > 0)
		{
			var_02 = level.tess.time_remaining * 20;
			var_03 = level.tess.cutoff_distance_goal - level.tess.cutoff_distance_current / var_02;
			var_04 = level.tess.cutoff_falloff_goal - level.tess.cutoff_falloff_current / var_02;
			level.tess.cutoff_distance_current = level.tess.cutoff_distance_current + var_03;
			level.tess.cutoff_falloff_current = level.tess.cutoff_falloff_current + var_04;
			level.tess.time_remaining = level.tess.time_remaining - 0.05;
		}
		else
		{
			level.tess.cutoff_distance_current = level.tess.cutoff_distance_goal;
			level.tess.cutoff_falloff_current = level.tess.cutoff_falloff_goal;
		}

		if(var_00 != level.tess.cutoff_distance_current)
		{
			setsaveddvar("r_tessellationCutoffDistance",level.tess.cutoff_distance_current);
		}

		if(var_01 != level.tess.cutoff_falloff_current)
		{
			setsaveddvar("r_tessellationCutoffFalloff",level.tess.cutoff_falloff_current);
		}
	}
}

//Function Number: 21
func_7D49(param_00,param_01)
{
	if(!isdefined(level.var_7D4B[param_00]))
	{
	}

	self notify("sunflare_start_adjust");
	self endon("sunflare_start_adjust");
	var_02 = gettime();
	var_03 = param_01 * 1000;
	var_04 = getdvarvector("r_sunflare_position",(0,0,0));
	var_05 = gettime() - var_02;
	var_06 = level.var_7D4B[param_00].position;
	level.current_sunflare_setting = param_00;
	while(var_05 < var_03)
	{
		var_06 = level.var_7D4B[param_00].position;
		var_07 = min(float(var_05 / var_03),1);
		var_08 = var_04 + var_06 - var_04 * var_07;
		setdvar("r_sunflare_position",var_08);
		setsunflareposition(var_08);
		wait(0.05);
		var_05 = gettime() - var_02;
	}

	setdvar("r_sunflare_position",level.var_7D4B[param_00].position);
	setsunflareposition(var_06);
}

//Function Number: 22
init_fog_transition()
{
	if(!isdefined(level.var_3483))
	{
		level.var_3483 = spawnstruct();
		level.var_3483.var_3486 = "";
		level.var_3483.time = 0;
	}
}

//Function Number: 23
func_6EDC(param_00)
{
	var_01 = 1 - param_00;
	var_02 = self.var_7A62 * var_01 + self.end_neardist * param_00;
	var_03 = self.var_7A37 * var_01 + self.end_fardist * param_00;
	var_04 = self.var_7A17 * var_01 + self.end_color * param_00;
	var_05 = self.var_7A45 * var_01 + self.var_2D1C * param_00;
	var_06 = self.var_7A6F;
	var_07 = self.end_opacity;
	var_08 = self.var_7A91;
	var_09 = self.var_7A93;
	var_0A = self.var_7A92;
	var_08 = self.var_7A91 * var_01 + self.end_skyfogintensity * param_00;
	var_09 = self.var_7A93 * var_01 + self.var_2D38 * param_00;
	var_0A = self.var_7A92 * var_01 + self.var_2D37 * param_00;
	if(!isdefined(var_06))
	{
		var_06 = 1;
	}

	if(!isdefined(var_07))
	{
		var_07 = 1;
	}

	var_0B = var_06 * var_01 + var_07 * param_00;
	if(self.var_7D4C)
	{
		var_0C = self.start_suncolor * var_01 + self.end_suncolor * param_00;
		var_0D = self.start_hdrsuncolorintensity * var_01 + self.end_hdrsuncolorintensity * param_00;
		var_0E = self.var_7AA1 * var_01 + self.end_sundir * param_00;
		var_0F = self.var_7A9F * var_01 + self.end_sunbeginfadeangle * param_00;
		var_10 = self.var_7AA2 * var_01 + self.end_sunendfadeangle * param_00;
		var_11 = self.var_7AA3 * var_01 + self.end_sunfogscale * param_00;
		setexpfog(var_02,var_03,var_04[0],var_04[1],var_04[2],var_05,var_0B,0.4,var_0C[0],var_0C[1],var_0C[2],var_0D,var_0E,var_0F,var_10,var_11,var_08,var_09,var_0A);
	}

	setexpfog(var_02,var_03,var_04[0],var_04[1],var_04[2],var_05,var_0B,0.4,var_08,var_09,var_0A);
}

//Function Number: 24
ssao_set_target_over_time_internal(param_00,param_01)
{
	level notify("ssao_set_target_over_time_internal");
	level endon("ssao_set_target_over_time_internal");
	maps\_utility::set_console_status();
	if(!maps\_utility::func_47F6())
	{
	}

	var_02 = getdvarfloat("r_ssaoScriptScale",1);
	var_03 = param_01;
	while(var_03 > 0)
	{
		var_04 = min(1,0.05 / var_03);
		var_05 = var_02;
		var_02 = var_02 + var_04 * param_00 - var_02;
		if(var_05 != var_02)
		{
			setsaveddvar("r_ssaoScriptScale",var_02);
		}

		common_scripts\utility::func_8AFE();
		var_03 = var_03 - 0.05;
	}

	setsaveddvar("r_ssaoScriptScale",param_00);
}

//Function Number: 25
disable_ssao_over_time(param_00)
{
	level thread ssao_set_target_over_time_internal(0,param_00);
}

//Function Number: 26
enable_ssao_over_time(param_00)
{
	level thread ssao_set_target_over_time_internal(1,param_00);
}