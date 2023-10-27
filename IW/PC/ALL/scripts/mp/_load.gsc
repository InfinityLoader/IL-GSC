/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\_load.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 6
 * Decompile Time: 258 ms
 * Timestamp: 10/27/2023 12:20:47 AM
*******************************************************************/

//Function Number: 1
main()
{
	if(isdefined(level.var_1307))
	{
		return;
	}

	level.var_74C2 = [];
	level.var_1307 = 1;
	level.createfx_enabled = getdvar("createfx") != "";
	level.players_waiting_for_callback = [];
	scripts\common\utility::func_1115B();
	scripts\mp\_utility::func_980B();
	scripts\mp\_utility::func_9892();
	thread scripts\mp\_playerlogic::queueconnectednotify();
	level.var_7763 = 0;
	level.var_6E46 = spawnstruct();
	level.var_6E46 scripts\common\flags::func_23D9();
	if(!isdefined(level.flag))
	{
		level.flag = [];
		level.var_6E6E = [];
	}

	level.var_499A = ::scripts\mp\_hud_util::createfontstring;
	level.var_91B0 = ::scripts\mp\_hud_util::setpoint;
	thread scripts\mp\_tweakables::init();
	if(!isdefined(level.var_74C2))
	{
		level.var_74C2 = [];
	}

	level.var_74C2["precacheMpAnim"] = ::precachempanim;
	level.var_74C2["scriptModelPlayAnim"] = ::scriptmodelplayanim;
	level.var_74C2["scriptModelClearAnim"] = ::method_8292;
	if(!level.createfx_enabled)
	{
		thread scripts\mp\_minefields::func_B774();
		thread scripts\mp\_shutter::main();
		thread scripts\mp\_movers::init();
		thread scripts\mp\_destructables::init();
		thread scripts\common\elevator::init();
		level notify("interactive_start");
	}

	game["thermal_vision"] = "thermal_mp";
	function_0237("",0);
	function_0238("default_night_mp");
	function_0236("missilecam");
	function_023A(game["thermal_vision"]);
	function_0239("",0);
	var_00 = getentarray("lantern_glowFX_origin","targetname");
	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		var_00[var_01] thread func_A84C();
	}

	scripts\mp\_audio::func_9539();
	scripts\mp\_art::main();
	func_FAAA();
	thread scripts\common\fx::func_980A();
	if(level.createfx_enabled)
	{
		scripts\mp\_spawnlogic::func_F78E();
		scripts\mp\_createfx::func_49B4();
	}

	if(getdvar("r_reflectionProbeGenerate") == "1")
	{
		scripts\mp\_dev::func_DE5D();
		scripts\mp\_dev::func_DE5C();
		scripts\mp\_spawnlogic::func_F78E();
		scripts\mp\_global_fx::main();
		level waittill("eternity");
	}

	thread scripts\mp\_global_fx::main();
	for(var_02 = 0;var_02 < 7;var_02++)
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

			case 5:
				var_03 = "trigger_multiple_arbitrary_up";
				break;

			default:
				var_03 = "trigger_damage";
				break;
		}

		var_04 = getentarray(var_03,"classname");
		for(var_01 = 0;var_01 < var_04.size;var_01++)
		{
			if(isdefined(var_04[var_01].var_EE89))
			{
				var_04[var_01].var_ED84 = var_04[var_01].var_EE89;
			}

			if(isdefined(var_04[var_01].var_ED84))
			{
				level thread func_69AA(var_04[var_01]);
			}

			if(var_03 == "trigger_multiple_arbitrary_up")
			{
				var_05 = var_04[var_01];
				var_05 method_84C0(1);
				if(isdefined(var_05.target))
				{
					var_06 = getent(var_05.target,"targetname");
					var_05 enablelinkto();
					var_05 linkto(var_06);
				}
			}
		}
	}

	thread scripts\mp\_animatedmodels::main();
	level.var_74C2["damagefeedback"] = ::scripts\mp\_damagefeedback::func_12E84;
	level.var_74C2["setTeamHeadIcon"] = ::scripts\mp\_entityheadicons::func_F877;
	level.var_A879 = ::method_81D9;
	level.var_A877 = ::method_81D8;
	level.var_4537 = ::connectpaths;
	level.var_563A = ::disconnectpaths;
	setdvar("sm_sunShadowScale",1);
	setdvar("sm_spotLightScoreModelScale",0);
	setdvar("r_specularcolorscale",1);
	setdvar("r_diffusecolorscale",1);
	setdvar("r_lightGridEnableTweaks",0);
	setdvar("r_lightGridIntensity",1);
	setdvar("r_lightGridContrast",0);
	setdvar("ui_showInfo",1);
	setdvar("ui_showMinimap",1);
	func_FAA3();
	precacheitem("bomb_site_mp");
	level.var_6BAA = 0;
	level.var_AD86 = "vehicle_aas_72x_killstreak";
}

//Function Number: 2
func_69AA(param_00)
{
	level endon("killexplodertridgers" + param_00.var_ED84);
	param_00 waittill("trigger");
	if(isdefined(param_00.var_ED28) && randomfloat(1) > param_00.var_ED28)
	{
		if(isdefined(param_00.script_delay))
		{
			wait(param_00.script_delay);
		}
		else
		{
			wait(4);
		}

		level thread func_69AA(param_00);
		return;
	}

	scripts\common\utility::exploder(param_00.var_ED84);
	level notify("killexplodertridgers" + param_00.var_ED84);
}

//Function Number: 3
func_FAAA()
{
	var_00 = getentarray("script_brushmodel","classname");
	var_01 = getentarray("script_model","classname");
	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		var_00[var_00.size] = var_01[var_02];
	}

	for(var_02 = 0;var_02 < var_00.size;var_02++)
	{
		if(isdefined(var_00[var_02].var_EE89))
		{
			var_00[var_02].var_ED84 = var_00[var_02].var_EE89;
		}

		if(isdefined(var_00[var_02].var_ED84))
		{
			if(var_00[var_02].model == "fx" && !isdefined(var_00[var_02].var_336) || var_00[var_02].var_336 != "exploderchunk")
			{
				var_00[var_02] hide();
				continue;
			}

			if(isdefined(var_00[var_02].var_336) && var_00[var_02].var_336 == "exploder")
			{
				var_00[var_02] hide();
				var_00[var_02] notsolid();
				continue;
			}

			if(isdefined(var_00[var_02].var_336) && var_00[var_02].var_336 == "exploderchunk")
			{
				var_00[var_02] hide();
				var_00[var_02] notsolid();
			}
		}
	}

	var_03 = [];
	var_04 = getentarray("script_brushmodel","classname");
	for(var_02 = 0;var_02 < var_04.size;var_02++)
	{
		if(isdefined(var_04[var_02].var_EE89))
		{
			var_04[var_02].var_ED84 = var_04[var_02].var_EE89;
		}

		if(isdefined(var_04[var_02].var_ED84))
		{
			var_03[var_03.size] = var_04[var_02];
		}
	}

	var_04 = getentarray("script_model","classname");
	for(var_02 = 0;var_02 < var_04.size;var_02++)
	{
		if(isdefined(var_04[var_02].var_EE89))
		{
			var_04[var_02].var_ED84 = var_04[var_02].var_EE89;
		}

		if(isdefined(var_04[var_02].var_ED84))
		{
			var_03[var_03.size] = var_04[var_02];
		}
	}

	var_04 = getentarray("item_health","classname");
	for(var_02 = 0;var_02 < var_04.size;var_02++)
	{
		if(isdefined(var_04[var_02].var_EE89))
		{
			var_04[var_02].var_ED84 = var_04[var_02].var_EE89;
		}

		if(isdefined(var_04[var_02].var_ED84))
		{
			var_03[var_03.size] = var_04[var_02];
		}
	}

	if(!isdefined(level.var_49C9))
	{
		level.var_49C9 = [];
	}

	var_05 = [];
	var_05["exploderchunk visible"] = 1;
	var_05["exploderchunk"] = 1;
	var_05["exploder"] = 1;
	for(var_02 = 0;var_02 < var_03.size;var_02++)
	{
		var_06 = var_03[var_02];
		var_07 = scripts\common\utility::func_49AE(var_06.script_fxid);
		var_07.var_13125 = [];
		var_07.var_13125["origin"] = var_06.origin;
		var_07.var_13125["angles"] = var_06.angles;
		var_07.var_13125["delay"] = var_06.script_delay;
		var_07.var_13125["firefx"] = var_06.var_ED93;
		var_07.var_13125["firefxdelay"] = var_06.var_ED94;
		var_07.var_13125["firefxsound"] = var_06.var_ED95;
		var_07.var_13125["firefxtimeout"] = var_06.var_ED96;
		var_07.var_13125["earthquake"] = var_06.var_ED76;
		var_07.var_13125["damage"] = var_06.var_ED41;
		var_07.var_13125["damage_radius"] = var_06.var_EE8F;
		var_07.var_13125["soundalias"] = var_06.var_EEB1;
		var_07.var_13125["repeat"] = var_06.var_EE94;
		var_07.var_13125["delay_min"] = var_06.var_ED50;
		var_07.var_13125["delay_max"] = var_06.var_ED4F;
		var_07.var_13125["target"] = var_06.target;
		var_07.var_13125["ender"] = var_06.var_ED78;
		var_07.var_13125["type"] = "exploder";
		if(!isdefined(var_06.script_fxid))
		{
			var_07.var_13125["fxid"] = "No FX";
		}
		else
		{
			var_07.var_13125["fxid"] = var_06.script_fxid;
		}

		var_07.var_13125["exploder"] = var_06.var_ED84;
		if(!isdefined(var_07.var_13125["delay"]))
		{
			var_07.var_13125["delay"] = 0;
		}

		if(isdefined(var_06.target))
		{
			var_08 = getent(var_07.var_13125["target"],"targetname").origin;
			var_07.var_13125["angles"] = vectortoangles(var_08 - var_07.var_13125["origin"]);
		}

		if(var_06.classname == "script_brushmodel" || isdefined(var_06.model))
		{
			var_07.model = var_06;
			var_07.model.var_5635 = var_06.var_ED5D;
		}

		if(isdefined(var_06.var_336) && isdefined(var_05[var_06.var_336]))
		{
			var_07.var_13125["exploder_type"] = var_06.var_336;
		}
		else
		{
			var_07.var_13125["exploder_type"] = "normal";
		}

		var_07 scripts\common\createfx::func_D6CF();
	}
}

//Function Number: 4
func_A84C()
{
	if(!isdefined(level._effect["lantern_light"]))
	{
		level._effect["lantern_light"] = loadfx("vfx/props/glow_latern");
	}

	scripts\common\fx::func_B052("lantern_light",self.origin,0.3,self.origin + (0,0,1));
}

//Function Number: 5
func_FAA3()
{
	var_00 = getentarray("scriptable_destructible_vehicle","targetname");
	foreach(var_02 in var_00)
	{
		var_03 = var_02.origin + (0,0,5);
		var_04 = var_02.origin + (0,0,128);
		var_05 = bullettrace(var_03,var_04,0,var_02);
		var_02.var_A63A = spawn("script_model",var_05["position"]);
		var_02.var_A63A.var_336 = "killCamEnt_destructible_vehicle";
		var_02.var_A63A setscriptmoverkillcam("explosive");
		var_02 thread func_51AE();
	}

	var_07 = getentarray("scriptable_destructible_barrel","targetname");
	foreach(var_02 in var_07)
	{
		var_03 = var_02.origin + (0,0,5);
		var_04 = var_02.origin + (0,0,128);
		var_05 = bullettrace(var_03,var_04,0,var_02);
		var_02.var_A63A = spawn("script_model",var_05["position"]);
		var_02.var_A63A.var_336 = "killCamEnt_explodable_barrel";
		var_02.var_A63A setscriptmoverkillcam("explosive");
		var_02 thread func_51AE();
	}
}

//Function Number: 6
func_51AE()
{
	level endon("game_ended");
	var_00 = self.var_A63A;
	var_00 endon("death");
	self waittill("death");
	wait(10);
	if(isdefined(var_00))
	{
		var_00 delete();
	}
}