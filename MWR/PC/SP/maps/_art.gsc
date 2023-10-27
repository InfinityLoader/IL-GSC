/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_art.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 33
 * Decompile Time: 626 ms
 * Timestamp: 10/27/2023 2:47:13 AM
*******************************************************************/

//Function Number: 1
main()
{
	maps\_utility::set_console_status();
	level.dofdefault["nearStart"] = 1;
	level.dofdefault["nearEnd"] = 1;
	level.dofdefault["farStart"] = 500;
	level.dofdefault["farEnd"] = 500;
	level.dofdefault["nearBlur"] = 4.5;
	level.dofdefault["farBlur"] = 0.05;
	level.current_sunflare_setting = "default";
	level._clearalltextafterhudelem = 0;
	dof_init();
	tess_init();
	precachemenu("dev_vision_noloc");
	precachemenu("dev_vision_exec");
	level.special_weapon_dof_funcs = [];
	level.buttons = [];
	if(!isdefined(level.vision_set_transition_ent))
	{
		level.vision_set_transition_ent = spawnstruct();
		level.vision_set_transition_ent.vision_set = "";
		level.vision_set_transition_ent.time = 0;
	}

	if(!isdefined(level.sunflare_settings))
	{
		level.sunflare_settings = [];
	}

	if(!isdefined(level.vision_set_fog))
	{
		level.vision_set_fog = [];
		create_default_vision_set_fog(level.script);
		common_scripts\_artcommon::setfogsliders();
	}

	if(!isdefined(level.script))
	{
		level.script = tolower(getdvar("mapname"));
	}
}

//Function Number: 2
setdefaultdepthoffield()
{
	self setdepthoffield(level.dofdefault["nearStart"],level.dofdefault["nearEnd"],level.dofdefault["farStart"],level.dofdefault["farEnd"],level.dofdefault["nearBlur"],level.dofdefault["farBlur"]);
}

//Function Number: 3
create_default_vision_set_fog(param_00)
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
	var_01.heightfogenabled = 0;
	var_01.heightfogbaseheight = 0;
	var_01.heightfoghalfplanedistance = 1000;
}

//Function Number: 4
get_fog_filename()
{
	if(isusinghdr())
	{
		return "\\share\\raw\\maps\\createart\\" + common_scripts\utility::get_template_level() + "_fog_hdr.gsc";
	}

	return "\\share\\raw\\maps\\createart\\" + common_scripts\utility::get_template_level() + "_fog.gsc";
}

//Function Number: 5
dof_set_generic(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	level.dof[param_00][param_01]["nearStart"] = param_02;
	level.dof[param_00][param_01]["nearEnd"] = param_03;
	level.dof[param_00][param_01]["nearBlur"] = param_04;
	level.dof[param_00][param_01]["farStart"] = param_05;
	level.dof[param_00][param_01]["farEnd"] = param_06;
	level.dof[param_00][param_01]["farBlur"] = param_07;
	level.dof[param_00][param_01]["weight"] = param_08;
	if(isdefined(param_09))
	{
		level.dof[param_00][param_01]["bias"] = param_09;
	}
}

//Function Number: 6
dof_blend_interior_generic(param_00)
{
	if(level.dof[param_00]["timeRemaining"] <= 0)
	{
		return;
	}

	var_01 = min(1,0.05 / level.dof[param_00]["timeRemaining"]);
	level.dof[param_00]["timeRemaining"] = level.dof[param_00]["timeRemaining"] - 0.05;
	if(level.dof[param_00]["timeRemaining"] <= 0)
	{
		level.dof[param_00]["timeRemaining"] = 0;
		level.dof[param_00]["current"]["nearStart"] = level.dof[param_00]["goal"]["nearStart"];
		level.dof[param_00]["current"]["nearEnd"] = level.dof[param_00]["goal"]["nearEnd"];
		level.dof[param_00]["current"]["nearBlur"] = level.dof[param_00]["goal"]["nearBlur"];
		level.dof[param_00]["current"]["farStart"] = level.dof[param_00]["goal"]["farStart"];
		level.dof[param_00]["current"]["farEnd"] = level.dof[param_00]["goal"]["farEnd"];
		level.dof[param_00]["current"]["farBlur"] = level.dof[param_00]["goal"]["farBlur"];
		level.dof[param_00]["current"]["weight"] = level.dof[param_00]["goal"]["weight"];
		return;
	}

	level.dof[param_00]["current"]["nearStart"] = level.dof[param_00]["current"]["nearStart"] + var_01 * level.dof[param_00]["goal"]["nearStart"] - level.dof[param_00]["current"]["nearStart"];
	level.dof[param_00]["current"]["nearEnd"] = level.dof[param_00]["current"]["nearEnd"] + var_01 * level.dof[param_00]["goal"]["nearEnd"] - level.dof[param_00]["current"]["nearEnd"];
	level.dof[param_00]["current"]["nearBlur"] = level.dof[param_00]["current"]["nearBlur"] + var_01 * level.dof[param_00]["goal"]["nearBlur"] - level.dof[param_00]["current"]["nearBlur"];
	level.dof[param_00]["current"]["farStart"] = level.dof[param_00]["current"]["farStart"] + var_01 * level.dof[param_00]["goal"]["farStart"] - level.dof[param_00]["current"]["farStart"];
	level.dof[param_00]["current"]["farEnd"] = level.dof[param_00]["current"]["farEnd"] + var_01 * level.dof[param_00]["goal"]["farEnd"] - level.dof[param_00]["current"]["farEnd"];
	level.dof[param_00]["current"]["farBlur"] = level.dof[param_00]["current"]["farBlur"] + var_01 * level.dof[param_00]["goal"]["farBlur"] - level.dof[param_00]["current"]["farBlur"];
	level.dof[param_00]["current"]["weight"] = level.dof[param_00]["current"]["weight"] + var_01 * level.dof[param_00]["goal"]["weight"] - level.dof[param_00]["current"]["weight"];
}

//Function Number: 7
dof_init()
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
	level.dof = [];
	level.dof["base"] = [];
	level.dof["base"]["current"] = [];
	level.dof["base"]["goal"] = [];
	level.dof["base"]["timeRemaining"] = 0;
	dof_set_generic("base","current",var_00,var_01,var_02,var_03,var_04,var_05,1,0.5);
	dof_set_generic("base","goal",0,0,0,0,0,0,0,0.5);
	level.dof["script"] = [];
	level.dof["script"]["current"] = [];
	level.dof["script"]["goal"] = [];
	level.dof["script"]["timeRemaining"] = 0;
	dof_set_generic("script","current",0,0,0,0,0,0,0,0.5);
	dof_set_generic("script","goal",0,0,0,0,0,0,0,0.5);
	level.dof["ads"] = [];
	level.dof["ads"]["current"] = [];
	level.dof["ads"]["goal"] = [];
	dof_set_generic("ads","current",0,0,0,0,0,0,0,0.5);
	dof_set_generic("ads","goal",0,0,0,0,0,0,0,0.5);
	level.dof["results"] = [];
	level.dof["results"]["current"] = [];
	dof_set_generic("results","current",var_00,var_01,var_02,var_03,var_04,var_05,1,0.5);
	foreach(var_07 in level.players)
	{
		var_07 thread dof_update();
	}

	level.player maps\_utility::delaythread(1,::dof_monitor_prone);
}

//Function Number: 8
dof_set_base(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	dof_set_generic("base","goal",param_00,param_01,param_02,param_03,param_04,param_05,1,param_07);
	level.dof["base"]["timeRemaining"] = param_06;
	if(param_06 <= 0)
	{
		dof_set_generic("base","current",param_00,param_01,param_02,param_03,param_04,param_05,1,param_07);
	}
}

//Function Number: 9
dof_enable_script(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	dof_set_generic("script","goal",param_00,param_01,param_02,param_03,param_04,param_05,1,param_07);
	level.dof["script"]["timeRemaining"] = param_06;
	if(param_06 <= 0)
	{
		dof_set_generic("script","current",param_00,param_01,param_02,param_03,param_04,param_05,1,param_07);
		return;
	}

	if(level.dof["script"]["current"]["weight"] <= 0)
	{
		dof_set_generic("script","current",param_00,param_01,param_02,param_03,param_04,param_05,0,param_07);
	}
}

//Function Number: 10
dof_disable_script(param_00)
{
	level.dof["script"]["goal"]["weight"] = 0;
	level.dof["script"]["timeRemaining"] = param_00;
	if(param_00 <= 0)
	{
		level.dof["script"]["current"]["weight"] = 0;
	}
}

//Function Number: 11
dof_enable_ads(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	dof_set_generic("ads","goal",param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07);
	if(level.dof["ads"]["current"]["weight"] <= 0)
	{
		dof_set_generic("ads","current",param_00,param_01,param_02,param_03,param_04,param_05,0,param_07);
	}
}

//Function Number: 12
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

//Function Number: 13
dof_blend_interior_ads()
{
	var_00 = level.dof["ads"]["goal"]["weight"];
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

		level.dof["ads"]["current"]["nearStart"] = level.dof["ads"]["goal"]["nearStart"];
		level.dof["ads"]["current"]["nearEnd"] = level.dof["ads"]["goal"]["nearEnd"];
		level.dof["ads"]["current"]["nearBlur"] = level.dof["ads"]["goal"]["nearBlur"];
		level.dof["ads"]["current"]["farStart"] = level.dof["ads"]["goal"]["farStart"];
		level.dof["ads"]["current"]["farEnd"] = level.dof["ads"]["goal"]["farEnd"];
		level.dof["ads"]["current"]["farBlur"] = level.dof["ads"]["goal"]["farBlur"];
		level.dof["ads"]["current"]["weight"] = var_00;
		level.dof["ads"]["current"]["bias"] = level.dof["ads"]["goal"]["bias"];
		return;
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
	var_03 = max(var_02,abs(level.dof["ads"]["current"]["nearStart"] - level.dof["ads"]["goal"]["nearStart"]) * var_01);
	var_04 = max(var_02,abs(level.dof["ads"]["current"]["nearEnd"] - level.dof["ads"]["goal"]["nearEnd"]) * var_01);
	var_05 = max(var_02,abs(level.dof["ads"]["current"]["farStart"] - level.dof["ads"]["goal"]["farStart"]) * var_01);
	var_06 = max(var_02,abs(level.dof["ads"]["current"]["farEnd"] - level.dof["ads"]["goal"]["farEnd"]) * var_01);
	var_07 = 0.1;
	var_08 = 0.1;
	level.dof["ads"]["current"]["nearStart"] = dof_blend_interior_ads_element(level.dof["ads"]["current"]["nearStart"],level.dof["ads"]["goal"]["nearStart"],var_03,0.33);
	level.dof["ads"]["current"]["nearEnd"] = dof_blend_interior_ads_element(level.dof["ads"]["current"]["nearEnd"],level.dof["ads"]["goal"]["nearEnd"],var_04,0.33);
	level.dof["ads"]["current"]["nearBlur"] = dof_blend_interior_ads_element(level.dof["ads"]["current"]["nearBlur"],level.dof["ads"]["goal"]["nearBlur"],var_07,0.33);
	level.dof["ads"]["current"]["farStart"] = dof_blend_interior_ads_element(level.dof["ads"]["current"]["farStart"],level.dof["ads"]["goal"]["farStart"],var_05,0.33);
	level.dof["ads"]["current"]["farEnd"] = dof_blend_interior_ads_element(level.dof["ads"]["current"]["farEnd"],level.dof["ads"]["goal"]["farEnd"],var_06,0.33);
	level.dof["ads"]["current"]["farBlur"] = dof_blend_interior_ads_element(level.dof["ads"]["current"]["farBlur"],level.dof["ads"]["goal"]["farBlur"],var_07,0.33);
	level.dof["ads"]["current"]["weight"] = 1;
	level.dof["ads"]["current"]["bias"] = dof_blend_interior_ads_element(level.dof["ads"]["current"]["bias"],level.dof["ads"]["goal"]["bias"],var_08,0.33);
}

//Function Number: 14
dof_disable_ads()
{
	level.dof["ads"]["goal"]["weight"] = 0;
	level.dof["ads"]["current"]["weight"] = 0;
}

//Function Number: 15
dof_apply_to_results(param_00)
{
	var_01 = level.dof[param_00]["current"]["weight"];
	var_02 = 1 - var_01;
	level.dof["results"]["current"]["nearStart"] = level.dof["results"]["current"]["nearStart"] * var_02 + level.dof[param_00]["current"]["nearStart"] * var_01;
	level.dof["results"]["current"]["nearEnd"] = level.dof["results"]["current"]["nearEnd"] * var_02 + level.dof[param_00]["current"]["nearEnd"] * var_01;
	level.dof["results"]["current"]["nearBlur"] = level.dof["results"]["current"]["nearBlur"] * var_02 + level.dof[param_00]["current"]["nearBlur"] * var_01;
	level.dof["results"]["current"]["farStart"] = level.dof["results"]["current"]["farStart"] * var_02 + level.dof[param_00]["current"]["farStart"] * var_01;
	level.dof["results"]["current"]["farEnd"] = level.dof["results"]["current"]["farEnd"] * var_02 + level.dof[param_00]["current"]["farEnd"] * var_01;
	level.dof["results"]["current"]["farBlur"] = level.dof["results"]["current"]["farBlur"] * var_02 + level.dof[param_00]["current"]["farBlur"] * var_01;
	level.dof["results"]["current"]["bias"] = level.dof["results"]["current"]["bias"] * var_02 + level.dof[param_00]["current"]["bias"] * var_01;
}

//Function Number: 16
dof_calc_results()
{
	dof_blend_interior_generic("base");
	dof_blend_interior_generic("script");
	dof_blend_interior_ads();
	dof_apply_to_results("base");
	dof_apply_to_results("script");
	dof_apply_to_results("ads");
	var_00 = level.dof["results"]["current"]["nearStart"];
	var_01 = level.dof["results"]["current"]["nearEnd"];
	var_02 = level.dof["results"]["current"]["nearBlur"];
	var_03 = level.dof["results"]["current"]["farStart"];
	var_04 = level.dof["results"]["current"]["farEnd"];
	var_05 = level.dof["results"]["current"]["farBlur"];
	var_06 = level.dof["results"]["current"]["bias"];
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

	var_06 = max(0,var_06);
	level.dof["results"]["current"]["nearStart"] = var_00;
	level.dof["results"]["current"]["nearEnd"] = var_01;
	level.dof["results"]["current"]["nearBlur"] = var_02;
	level.dof["results"]["current"]["farStart"] = var_03;
	level.dof["results"]["current"]["farEnd"] = var_04;
	level.dof["results"]["current"]["farBlur"] = var_05;
	level.dof["results"]["current"]["bias"] = var_06;
}

//Function Number: 17
dof_process_ads()
{
	var_00 = self playerads();
	if(var_00 <= 0)
	{
		dof_disable_ads();
		return;
	}

	if(isdefined(level.custom_dof_trace))
	{
		[[ level.custom_dof_trace ]]();
		return;
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
	var_0E = bullettrace(var_0A,var_0A + var_0D * var_01,1,self,0,0,0,0,0);
	var_0F = getaiarray("axis");
	var_10 = self getcurrentweapon();
	if(isdefined(level.special_weapon_dof_funcs[var_10]))
	{
		[[ level.special_weapon_dof_funcs[var_10] ]](var_0E,var_0F,var_0A,var_0D,var_00);
		return;
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

//Function Number: 18
dof_process_physical_ads(param_00)
{
	if(isdefined(level.custom_dof_trace))
	{
		return [[ level.custom_dof_trace ]]();
	}

	var_01 = getdvarfloat("ads_dof_tracedist",4096);
	var_02 = getdvarfloat("ads_dof_maxEnemyDist",0);
	var_03 = getdvarint("ads_dof_playerForgetEnemyTime",5000);
	var_04 = self geteye();
	var_05 = self getplayerangles();
	if(isdefined(self.dof_ref_ent))
	{
		var_06 = combineangles(self.dof_ref_ent.angles,var_05);
	}
	else
	{
		var_06 = var_06;
	}

	var_07 = vectornormalize(anglestoforward(var_06));
	var_08 = bullettrace(var_04,var_04 + var_07 * var_01,1,self,0,1,0,0,0);
	var_09 = getaiarray("axis");
	var_0A = self getcurrentweapon();
	if(isdefined(level.special_weapon_dof_funcs[var_0A]))
	{
		return [[ level.special_weapon_dof_funcs[var_0A] ]](var_08,var_09,var_04,var_07,param_00);
	}

	var_0B["start"] = distance(var_04,var_08["position"]);
	var_0B["end"] = var_0B["start"];
	foreach(var_0D in var_09)
	{
		var_0E = var_0D isenemyaware();
		var_0F = var_0D hasenemybeenseen(var_03);
		if(!var_0E && !var_0F)
		{
			continue;
		}

		var_10 = vectornormalize(var_0D.origin - var_04);
		var_11 = vectordot(var_07,var_10);
		if(var_11 < 0.923)
		{
			continue;
		}

		var_12 = distance(var_04,var_0D.origin);
		if(var_12 < var_0B["start"])
		{
			var_0B["start"] = var_12;
		}

		var_13 = min(var_12,var_02);
		if(var_13 > var_0B["end"])
		{
			var_0B["end"] = var_13;
		}
	}

	return var_0B;
}

//Function Number: 19
dof_monitor_prone()
{
	if(!isdefined(level.dof_while_prone_enabled) || !level.dof_while_prone_enabled)
	{
		return;
	}

	for(;;)
	{
		dof_set_standing();
		while(self getstance() != "prone")
		{
			wait(0.05);
		}

		dof_set_prone();
		while(self getstance() == "prone")
		{
			wait(0.05);
		}
	}
}

//Function Number: 20
dof_set_standing()
{
	level.player method_84A6();
}

//Function Number: 21
dof_set_prone()
{
	level.player method_84A5();
	level.player method_84A7(3,800,20,20);
	level.player method_84B8(12,900);
}

//Function Number: 22
javelin_dof(param_00,param_01,param_02,param_03,param_04)
{
	if(param_04 < 0.88)
	{
		dof_disable_ads();
		return;
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

//Function Number: 23
dof_update()
{
	for(;;)
	{
		wait 0.05;
		if(level.level_specific_dof)
		{
			continue;
		}

		if(!getdvarint("scr_dof_enable"))
		{
			continue;
		}

		if(getdvarint("r_dof_physical_enable"))
		{
			var_00 = self playerads();
			if(var_00 > 0)
			{
				var_01 = dof_process_physical_ads(var_00);
				self method_84A8(var_01["start"],var_01["end"]);
			}

			continue;
		}

		dof_process_ads();
		dof_calc_results();
		var_02 = level.dof["results"]["current"]["nearStart"];
		var_03 = level.dof["results"]["current"]["nearEnd"];
		var_04 = level.dof["results"]["current"]["farStart"];
		var_05 = level.dof["results"]["current"]["farEnd"];
		var_06 = level.dof["results"]["current"]["nearBlur"];
		var_07 = level.dof["results"]["current"]["farBlur"];
		self setdepthoffield(var_02,var_03,var_04,var_05,var_06,var_07);
	}
}

//Function Number: 24
tess_init()
{
	var_00 = getdvar("r_tessellation");
	if(var_00 == "")
	{
		return;
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

//Function Number: 25
tess_set_goal(param_00,param_01,param_02)
{
	level.tess.cutoff_distance_goal = param_00;
	level.tess.cutoff_falloff_goal = param_01;
	level.tess.time_remaining = param_02;
}

//Function Number: 26
tess_update()
{
	for(;;)
	{
		var_00 = level.tess.cutoff_distance_current;
		var_01 = level.tess.cutoff_falloff_current;
		wait 0.05;
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

//Function Number: 27
sunflare_changes(param_00,param_01)
{
	if(!isdefined(level.sunflare_settings[param_00]))
	{
		return;
	}

	self notify("sunflare_start_adjust");
	self endon("sunflare_start_adjust");
	var_02 = gettime();
	var_03 = param_01 * 1000;
	var_04 = getdvarvector("r_sunflare_position",(0,0,0));
	var_05 = gettime() - var_02;
	var_06 = level.sunflare_settings[param_00].position;
	level.current_sunflare_setting = param_00;
	while(var_05 < var_03)
	{
		var_06 = level.sunflare_settings[param_00].position;
		var_07 = min(float(var_05 / var_03),1);
		var_08 = var_04 + var_06 - var_04 * var_07;
		setdvar("r_sunflare_position",var_08);
		setsunflareposition(var_08);
		wait(0.05);
		var_05 = gettime() - var_02;
	}

	setdvar("r_sunflare_position",level.sunflare_settings[param_00].position);
	setsunflareposition(var_06);
}

//Function Number: 28
init_fog_transition()
{
	if(!isdefined(level.fog_transition_ent))
	{
		level.fog_transition_ent = spawnstruct();
		level.fog_transition_ent.fogset = "";
		level.fog_transition_ent.time = 0;
	}
}

//Function Number: 29
set_fog_progress(param_00)
{
	if(isdefined(self.start_hdrcolorintensity))
	{
		set_fog_progress_preh1(param_00);
		return;
	}

	var_01 = 1 - param_00;
	var_02 = self.start_neardist * var_01 + self.end_neardist * param_00;
	var_03 = self.start_fardist * var_01 + self.end_fardist * param_00;
	var_04 = self.start_color * var_01 + self.end_color * param_00;
	setexpfog(var_02,var_03,var_04[0],var_04[1],var_04[2],1,0.4);
}

//Function Number: 30
set_fog_progress_preh1(param_00)
{
	var_01 = 1 - param_00;
	var_02 = self.start_neardist * var_01 + self.end_neardist * param_00;
	var_03 = self.start_fardist * var_01 + self.end_fardist * param_00;
	var_04 = self.start_color * var_01 + self.end_color * param_00;
	var_05 = self.start_hdrcolorintensity * var_01 + self.end_hdrcolorintensity * param_00;
	var_06 = self.start_opacity;
	var_07 = self.end_opacity;
	var_08 = self.start_skyfogintensity;
	var_09 = self.start_skyfogminangle;
	var_0A = self.start_skyfogmaxangle;
	var_08 = self.start_skyfogintensity * var_01 + self.end_skyfogintensity * param_00;
	var_09 = self.start_skyfogminangle * var_01 + self.end_skyfogminangle * param_00;
	var_0A = self.start_skyfogmaxangle * var_01 + self.end_skyfogmaxangle * param_00;
	if(!isdefined(var_06))
	{
		var_06 = 1;
	}

	if(!isdefined(var_07))
	{
		var_07 = 1;
	}

	var_0B = var_06 * var_01 + var_07 * param_00;
	if(self.sunfog_enabled)
	{
		var_0C = self.start_suncolor * var_01 + self.end_suncolor * param_00;
		var_0D = self.start_hdrsuncolorintensity * var_01 + self.end_hdrsuncolorintensity * param_00;
		var_0E = self.start_sundir * var_01 + self.end_sundir * param_00;
		var_0F = self.start_sunbeginfadeangle * var_01 + self.end_sunbeginfadeangle * param_00;
		var_10 = self.start_sunendfadeangle * var_01 + self.end_sunendfadeangle * param_00;
		var_11 = self.start_sunfogscale * var_01 + self.end_sunfogscale * param_00;
		setexpfog(var_02,var_03,var_04[0],var_04[1],var_04[2],var_05,var_0B,0.4,var_0C[0],var_0C[1],var_0C[2],var_0D,var_0E,var_0F,var_10,var_11,var_08,var_09,var_0A);
		return;
	}

	setexpfog(var_02,var_03,var_04[0],var_04[1],var_04[2],var_05,var_0B,0.4,var_08,var_09,var_0A);
}

//Function Number: 31
ssao_set_target_over_time_internal(param_00,param_01)
{
	level notify("ssao_set_target_over_time_internal");
	level endon("ssao_set_target_over_time_internal");
	maps\_utility::set_console_status();
	if(!maps\_utility::is_gen4())
	{
		return;
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

		wait 0.05;
		var_03 = var_03 - 0.05;
	}

	setsaveddvar("r_ssaoScriptScale",param_00);
}

//Function Number: 32
disable_ssao_over_time(param_00)
{
	level thread ssao_set_target_over_time_internal(0,param_00);
}

//Function Number: 33
enable_ssao_over_time(param_00)
{
	level thread ssao_set_target_over_time_internal(1,param_00);
}