/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\_load.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 13
 * Decompile Time: 204 ms
 * Timestamp: 10/27/2023 3:21:30 AM
*******************************************************************/

//Function Number: 1
func_00F9()
{
	if(isdefined(level.var_674))
	{
		return;
	}

	level.var_674 = 1;
	level.var_A559 = getdvarint("4017",0);
	level.var_6508 = issubstr(maps\mp\_utility::func_4571(),"mp_hub_");
	level.var_53C7 = level.var_3FDC == "scorestreak_training";
	level.var_53C6 = maps\mp\_utility::func_4571() == "mp_scorestreak_training";
	maps\mp\_utility::func_843E();
	level.var_27F6 = getdvar("1459") != "";
	common_scripts\utility::func_947B();
	maps\mp\_utility::func_52BE();
	maps\mp\_utility::func_5315();
	level.var_402A = 0;
	level.var_3C92 = spawnstruct();
	level.var_3C92 common_scripts\utility::func_10DA();
	if(!isdefined(level.var_3C77))
	{
		level.var_3C77 = [];
		level.var_3CC6 = [];
	}

	level.var_7D23 = getdvarfloat("scr_RequiredMapAspectratio",1);
	level.var_27D9 = ::maps\mp\gametypes\_hud_util::func_27ED;
	level.var_4F76 = ::maps\mp\gametypes\_hud_util::func_8707;
	level.var_5C44 = ::maps\mp\_utility::func_5C43;
	thread maps\mp\gametypes\_tweakables::func_D5();
	if(!isdefined(level.var_3F02))
	{
		level.var_3F02 = [];
	}

	level.var_3F02["precacheMpAnim"] = ::precachempanim;
	level.var_3F02["scriptModelPlayAnim"] = ::scriptmodelplayanim;
	level.var_3F02["scriptModelClearAnim"] = ::scriptmodelclearanim;
	if(!level.var_27F6)
	{
		thread maps\mp\_movers::func_D5();
		thread maps\mp\_shutter::func_F9();
		thread maps\mp\_destructables::func_D5();
		thread common_scripts\_elevator::func_D5();
		thread maps\mp\_dynamic_world::func_D5();
		thread common_scripts\_destructible::func_D5();
	}

	game["thermal_vision"] = "default";
	visionsetnaked("",0);
	visionsetnight("default_night_mp");
	visionsetthermal(game["thermal_vision"]);
	if(isdefined(level.var_585D) && level.var_585D)
	{
		visionsetpain("near_death_hdr_zm",0);
	}
	else
	{
		visionsetmissilecam("orbital_strike");
		visionsetpain("near_death_hdr",0);
	}

	var_00 = getentarray("lantern_glowFX_origin","targetname");
	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		var_00[var_01] thread func_5AFD();
	}

	lib_0378::func_8D89();
	maps\mp\_audio::func_5163();
	maps\mp\_art::func_F9();
	func_8A1A();
	thread common_scripts\_fx::func_52BD();
	if(level.var_27F6)
	{
		lib_050D::func_86C5();
		maps\mp\_createfx::func_27EE();
	}

	if(getdvar("233") == "1")
	{
		func_2D35();
		lib_050D::func_86C5();
		maps\mp\_global_fx::func_F9();
		level waittill("eternity");
	}

	thread maps\mp\_global_fx::func_F9();
	for(var_02 = 0;var_02 < 6;var_02++)
	{
		switch(var_02)
		{
			case 0:
				var_03 = "trigger_multiple";
				break;

			case 1:
				var_03 = "trigger_once";
				break;

			case 2:
				var_03 = "trigger_use";
				break;

			case 3:
				var_03 = "trigger_radius";
				break;

			case 4:
				var_03 = "trigger_lookat";
				break;

			default:
				var_03 = "trigger_damage";
				break;
		}

		var_04 = getentarray(var_03,"classname");
		for(var_01 = 0;var_01 < var_04.size;var_01++)
		{
			if(isdefined(var_04[var_01].var_8272))
			{
				var_04[var_01].var_8186 = var_04[var_01].var_8272;
			}

			if(isdefined(var_04[var_01].var_8186))
			{
				level thread func_3938(var_04[var_01]);
			}
		}
	}

	var_05 = getentarray("trigger_hurt","classname");
	foreach(var_07 in var_05)
	{
		var_07 thread func_4FF4();
	}

	level.var_6246 = getentarray("trigger_multiple_missile_dud","classname");
	thread maps\mp\_animatedmodels::func_F9();
	func_527B();
	level.var_3F02["damagefeedback"] = ::maps\mp\gametypes\_damagefeedback::func_A102;
	level.var_3F02["setTeamHeadIcon"] = ::maps\mp\_entityheadicons::func_873C;
	level.var_5B0E = ::method_80A4;
	level.var_5B0C = ::method_80A5;
	level.var_2587 = ::method_8060;
	level.var_2FC3 = ::method_805F;
	func_84B5();
	func_8A15();
	level.var_3A62 = 0;
	setdvar("bot_FlightDynamicsModeEnabled",0);
	func_5DE3();
}

//Function Number: 2
set_turret_hand_ik(param_00,param_01,param_02)
{
	level endon("game_ended");
	param_00 endon("disconnect");
	self endon("quit_hand_ik");
	wait(0.5);
	if(isdefined(param_00) && function_0389(param_00))
	{
		if(param_01)
		{
			param_00 method_8572(self,"TAG_IK_LOC_LE");
		}

		if(param_02)
		{
			param_00 method_8574(self,"TAG_IK_LOC_RI");
		}

		self.prevowner = param_00;
	}
}

//Function Number: 3
func_A8E7()
{
	level endon("game_ended");
	var_00 = self method_8445("TAG_IK_LOC_LE") != -1;
	var_01 = self method_8445("TAG_IK_LOC_RI") != -1;
	if(!var_00 && !var_01)
	{
		return;
	}

	self.prevowner = undefined;
	for(;;)
	{
		self waittill("turretownerchange",var_02);
		self notify("quit_hand_ik");
		if(isdefined(self.prevowner) && function_0389(self.prevowner))
		{
			self.prevowner clearscriptedlefthandik();
			self.prevowner clearscriptedlefthandik_0();
		}

		self.prevowner = undefined;
		if(isdefined(var_02) && function_0389(var_02))
		{
			thread set_turret_hand_ik(var_02,var_00,var_01);
		}
	}
}

//Function Number: 4
func_527B()
{
	var_00 = getentarray("misc_turret","classname");
	foreach(var_02 in var_00)
	{
		var_02 thread func_A8E7();
	}
}

//Function Number: 5
func_84B5()
{
	setdvar("5176",0.1);
	setdvar("882",0.2);
	setdvar("5800",0);
	setdvar("1963",0);
	setdvar("r_lightGridEnableTweaks",0);
	setdvar("r_lightGridIntensity",1);
	setdvar("r_lightGridContrast",0);
	setdvar("1175",0);
	setdvar("190",1);
	setdvar("r_gpuTriangleDepthFiltering",1);
}

//Function Number: 6
func_3938(param_00)
{
	level endon("killexplodertridgers" + param_00.var_8186);
	param_00 waittill("trigger");
	if(isdefined(param_00.var_8136) && randomfloat(1) > param_00.var_8136)
	{
		if(isdefined(param_00.var_161))
		{
			wait(param_00.var_161);
		}
		else
		{
			wait(4);
		}

		level thread func_3938(param_00);
		return;
	}

	common_scripts\_exploder::func_392A(param_00.var_8186);
	level notify("killexplodertridgers" + param_00.var_8186);
}

//Function Number: 7
func_8A1A()
{
	var_00 = getentarray("script_brushmodel","classname");
	var_01 = getentarray("script_model","classname");
	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		var_00[var_00.size] = var_01[var_02];
	}

	for(var_02 = 0;var_02 < var_00.size;var_02++)
	{
		if(isdefined(var_00[var_02].var_8272))
		{
			var_00[var_02].var_8186 = var_00[var_02].var_8272;
		}

		if(isdefined(var_00[var_02].var_8186))
		{
			if(var_00[var_02].var_106 == "fx" && !isdefined(var_00[var_02].var_1A5) || var_00[var_02].var_1A5 != "exploderchunk")
			{
				var_00[var_02] method_805C();
				continue;
			}

			if(isdefined(var_00[var_02].var_1A5) && var_00[var_02].var_1A5 == "exploder")
			{
				var_00[var_02] method_805C();
				var_00[var_02] notsolid();
				continue;
			}

			if(isdefined(var_00[var_02].var_1A5) && var_00[var_02].var_1A5 == "exploderchunk")
			{
				var_00[var_02] method_805C();
				var_00[var_02] notsolid();
			}
		}
	}

	var_03 = [];
	var_04 = getentarray("script_brushmodel","classname");
	for(var_02 = 0;var_02 < var_04.size;var_02++)
	{
		if(isdefined(var_04[var_02].var_8272))
		{
			var_04[var_02].var_8186 = var_04[var_02].var_8272;
		}

		if(isdefined(var_04[var_02].var_8186))
		{
			var_03[var_03.size] = var_04[var_02];
		}
	}

	var_04 = getentarray("script_model","classname");
	for(var_02 = 0;var_02 < var_04.size;var_02++)
	{
		if(isdefined(var_04[var_02].var_8272))
		{
			var_04[var_02].var_8186 = var_04[var_02].var_8272;
		}

		if(isdefined(var_04[var_02].var_8186))
		{
			var_03[var_03.size] = var_04[var_02];
		}
	}

	var_04 = getentarray("item_health","classname");
	for(var_02 = 0;var_02 < var_04.size;var_02++)
	{
		if(isdefined(var_04[var_02].var_8272))
		{
			var_04[var_02].var_8186 = var_04[var_02].var_8272;
		}

		if(isdefined(var_04[var_02].var_8186))
		{
			var_03[var_03.size] = var_04[var_02];
		}
	}

	if(!isdefined(level.var_2804))
	{
		level.var_2804 = [];
	}

	var_05 = [];
	var_05["exploderchunk visible"] = 1;
	var_05["exploderchunk"] = 1;
	var_05["exploder"] = 1;
	for(var_02 = 0;var_02 < var_03.size;var_02++)
	{
		var_06 = var_03[var_02];
		var_07 = common_scripts\utility::func_27E7(var_06.var_81BB);
		var_07.var_A265 = [];
		var_07.var_A265["origin"] = var_06.var_116;
		var_07.var_A265["angles"] = var_06.var_1D;
		var_07.var_A265["delay"] = var_06.var_161;
		var_07.var_A265["firefx"] = var_06.var_8193;
		var_07.var_A265["firefxdelay"] = var_06.var_8194;
		var_07.var_A265["firefxsound"] = var_06.var_8195;
		var_07.var_A265["firefxtimeout"] = var_06.var_8196;
		var_07.var_A265["earthquake"] = var_06.var_817B;
		var_07.var_A265["damage"] = var_06.var_8146;
		var_07.var_A265["damage_radius"] = var_06.var_8276;
		var_07.var_A265["soundalias"] = var_06.var_828B;
		var_07.var_A265["repeat"] = var_06.var_8278;
		var_07.var_A265["delay_min"] = var_06.var_8154;
		var_07.var_A265["delay_max"] = var_06.var_8153;
		var_07.var_A265["target"] = var_06.var_1A2;
		var_07.var_A265["ender"] = var_06.getstruct;
		var_07.var_A265["type"] = "exploder";
		if(isdefined(var_06.var_106))
		{
			var_07.var_A265["radiant"] = 1;
		}

		if(!isdefined(var_06.var_81BB))
		{
			var_07.var_A265["fxid"] = "No FX";
		}
		else
		{
			var_07.var_A265["fxid"] = var_06.var_81BB;
		}

		var_07.var_A265["exploder"] = var_06.var_8186;
		if(!isdefined(var_07.var_A265["delay"]))
		{
			var_07.var_A265["delay"] = 0;
		}

		if(isdefined(var_06.var_1A2))
		{
			var_08 = getentarray(var_07.var_A265["target"],"targetname")[0];
			if(isdefined(var_08))
			{
				var_09 = var_08.var_116;
				var_07.var_A265["angles"] = vectortoangles(var_09 - var_07.var_A265["origin"]);
			}
			else
			{
				var_08 = common_scripts\utility::func_4375(var_07.var_A265["target"]);
				if(isdefined(var_08))
				{
					var_09 = var_08.var_116;
					var_07.var_A265["angles"] = vectortoangles(var_09 - var_07.var_A265["origin"]);
				}
			}
		}

		if(var_06.var_3A == "script_brushmodel" || isdefined(var_06.var_106))
		{
			var_07.var_106 = var_06;
			var_07.var_106.var_2FBF = var_06.var_8166;
		}

		if(isdefined(var_06.var_1A5) && isdefined(var_05[var_06.var_1A5]))
		{
			var_07.var_A265["exploder_type"] = var_06.var_1A5;
		}
		else
		{
			var_07.var_A265["exploder_type"] = "normal";
		}

		var_07 common_scripts\_createfx::func_75BE();
	}
}

//Function Number: 8
func_5AFD()
{
	common_scripts\_fx::func_5EEE("lantern_light",self.var_116,0.3,self.var_116 + (0,0,1));
}

//Function Number: 9
func_4FF4()
{
	level endon("game_ended");
	wait(randomfloat(1));
	for(;;)
	{
		foreach(var_01 in level.var_744A)
		{
			if(var_01 istouching(self) && maps\mp\_utility::func_57A0(var_01))
			{
				var_01 maps\mp\_utility::func_728();
			}
		}

		wait(0.5);
	}
}

//Function Number: 10
func_8A15()
{
	var_00 = getentarray("destructible_vehicle","targetname");
	foreach(var_02 in var_00)
	{
		switch(getdvar("1673"))
		{
			case "mp_interchange":
				if(var_02.var_116[2] > 150)
				{
					break;
				}
				break;
		}

		var_03 = var_02.var_116 + (0,0,5);
		var_04 = var_02.var_116 + (0,0,128);
		var_05 = bullettrace(var_03,var_04,0,var_02);
		var_02.var_5A2C = spawn("script_model",var_05["position"]);
		var_02.var_5A2C.var_1A5 = "killCamEnt_destructible_vehicle";
		var_02.var_5A2C setscriptmoverkillcam("explosive");
		var_02 thread func_2D34();
	}

	var_07 = getentarray("destructible_toy","targetname");
	foreach(var_02 in var_07)
	{
		var_03 = var_02.var_116 + (0,0,5);
		var_04 = var_02.var_116 + (0,0,128);
		var_05 = bullettrace(var_03,var_04,0,var_02);
		var_02.var_5A2C = spawn("script_model",var_05["position"]);
		var_02.var_5A2C.var_1A5 = "killCamEnt_destructible_toy";
		var_02.var_5A2C setscriptmoverkillcam("explosive");
		var_02 thread func_2D34();
	}

	var_0A = getentarray("explodable_barrel","targetname");
	foreach(var_02 in var_0A)
	{
		var_03 = var_02.var_116 + (0,0,5);
		var_04 = var_02.var_116 + (0,0,128);
		var_05 = bullettrace(var_03,var_04,0,var_02);
		var_02.var_5A2C = spawn("script_model",var_05["position"]);
		var_02.var_5A2C.var_1A5 = "killCamEnt_explodable_barrel";
		var_02.var_5A2C setscriptmoverkillcam("explosive");
		var_02 thread func_2D34();
	}
}

//Function Number: 11
func_2D34()
{
	level endon("game_ended");
	var_00 = self.var_5A2C;
	var_00 endon("death");
	self waittill("death");
	wait(10);
	if(isdefined(var_00))
	{
		var_00 delete();
	}
}

//Function Number: 12
func_2D35()
{
	var_00 = getentarray("hp_zone_center","targetname");
	foreach(var_02 in var_00)
	{
		if(isdefined(var_02.var_1A2))
		{
			var_03 = getentarray(var_02.var_1A2,"targetname");
			foreach(var_05 in var_03)
			{
				var_05 delete();
			}
		}
	}

	var_08 = getentarray("orbital_bad_spawn_overlay","targetname");
	foreach(var_0A in var_08)
	{
		var_0A delete();
	}
}

//Function Number: 13
func_5DE3()
{
	if(isdefined(level.var_2683))
	{
		return;
	}

	level.var_2683 = ["shirt","head","pants","gear","hat","eyewear"];
	level.var_2682 = [];
	for(var_00 = 0;var_00 < level.var_2683.size;var_00++)
	{
		var_01 = level.var_2683[var_00];
		level.var_2682[var_01] = var_00;
	}

	level.var_2686 = [];
	level.var_2686["shirt"] = "0x62";
	level.var_2686["head"] = "0x63";
	level.var_2686["pants"] = "0x64";
	level.var_2686["gear"] = "0x67";
	level.var_2686["hat"] = "0x66";
	level.var_2686["eyewear"] = "0x6c";
}