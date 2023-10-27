/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\_load.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 6
 * Decompile Time: 117 ms
 * Timestamp: 10/27/2023 1:22:22 AM
*******************************************************************/

//Function Number: 1
func_4FDD()
{
	if(isdefined(level._loadstarted))
	{
		return;
	}

	level._loadstarted = 1;
	level.createfx_enabled = getdvar("createfx") != "";
	common_scripts\utility::func_7CF9();
	maps\mp\_utility::initgameflags();
	maps\mp\_utility::initlevelflags();
	maps\mp\_utility::initglobals();
	level.generic_index = 0;
	level.flag_struct = spawnstruct();
	level.flag_struct common_scripts\utility::assign_unique_id();
	if(!isdefined(level.flag))
	{
		level.flag = [];
		level.flags_lock = [];
	}

	level.requiredmapaspectratio = getdvarfloat("scr_RequiredMapAspectratio",1);
	level.createclientfontstring_func = ::maps\mp\gametypes\_hud_util::createfontstring;
	level.hudsetpoint_func = ::maps\mp\gametypes\_hud_util::func_70A4;
	level.leaderdialogonplayer_func = ::maps\mp\_utility::func_4D35;
	thread maps\mp\gametypes\_tweakables::func_44DF();
	if(!isdefined(level.func))
	{
		level.func = [];
	}

	level.func["precacheMpAnim"] = ::precachempanim;
	level.func["scriptModelPlayAnim"] = ::scriptmodelplayanim;
	level.func["scriptModelClearAnim"] = ::scriptmodelclearanim;
	if(!level.createfx_enabled)
	{
		thread maps\mp\_minefields::func_5251();
		thread maps\mp\_radiation::func_62B3();
		thread maps\mp\_shutter::func_4FDD();
		thread maps\mp\_movers::func_44DF();
		thread maps\mp\_destructables::func_44DF();
		thread common_scripts\_elevator::func_44DF();
		thread common_scripts\_dynamic_world::func_44DF();
		thread common_scripts\_destructible::func_44DF();
		level notify("interactive_start");
	}

	game["thermal_vision"] = "thermal_mp";
	visionsetnaked("",0);
	visionsetnight("default_night_mp");
	visionsetmissilecam("missilecam");
	visionsetthermal(game["thermal_vision"]);
	visionsetpain("",0);
	var_00 = getentarray("lantern_glowFX_origin","targetname");
	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		var_00[var_01] thread lanterns();
	}

	maps\mp\_audio::init_audio();
	maps\mp\_art::func_4FDD();
	func_71F8();
	thread common_scripts\_fx::func_460F();
	if(level.createfx_enabled)
	{
		maps\mp\gametypes\_spawnlogic::setmapcenterfordev();
		maps\mp\_createfx::createfx();
	}

	if(getdvar("r_reflectionProbeGenerate") == "1")
	{
		maps\mp\gametypes\_spawnlogic::setmapcenterfordev();
		maps\mp\_global_fx::func_4FDD();
		level waittill("eternity");
	}

	thread maps\mp\_global_fx::func_4FDD();
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
			if(isdefined(var_04[var_01].script_prefab_exploder))
			{
				var_04[var_01].script_exploder = var_04[var_01].script_prefab_exploder;
			}

			if(isdefined(var_04[var_01].script_exploder))
			{
				level thread func_30BC(var_04[var_01]);
			}
		}
	}

	thread maps\mp\_animatedmodels::func_4FDD();
	level.func["damagefeedback"] = ::maps\mp\gametypes\_damagefeedback::func_86E0;
	level.func["setTeamHeadIcon"] = ::maps\mp\_entityheadicons::func_70E0;
	level.laseron_func = ::laseron;
	level.laseroff_func = ::laseroff;
	level.connectpathsfunction = ::connectpaths;
	level.disconnectpathsfunction = ::disconnectpaths;
	setdvar("sm_sunShadowScale",1);
	setdvar("sm_spotLightScoreModelScale",0);
	setdvar("r_specularcolorscale",2.5);
	setdvar("r_diffusecolorscale",1);
	setdvar("r_lightGridEnableTweaks",0);
	setdvar("r_lightGridIntensity",1);
	setdvar("r_lightGridContrast",0);
	setdvar("ui_showInfo",1);
	setdvar("ui_showMinimap",1);
	func_71F3();
	precacheitem("bomb_site_mp");
	if(!level.console)
	{
		level.furfx = loadfx("vfx/apex/nv_dog_a");
		level.wolffurfx = [];
		level.wolffurfx[0] = loadfx("vfx/apex/nv_wolf_b");
		level.wolffurfx[1] = loadfx("vfx/apex/nv_wolf_c");
	}

	level.fauxvehiclecount = 0;
	level.littlebird_model = "vehicle_aas_72x_killstreak";
}

//Function Number: 2
func_30BC(param_00)
{
	level endon("killexplodertridgers" + param_00.script_exploder);
	param_00 waittill("trigger");
	if(isdefined(param_00.script_chance) && randomfloat(1) > param_00.script_chance)
	{
		if(isdefined(param_00.script_delay))
		{
			wait(param_00.script_delay);
		}
		else
		{
			wait(4);
		}

		level thread func_30BC(param_00);
	}

	common_scripts\utility::exploder(param_00.script_exploder);
	level notify("killexplodertridgers" + param_00.script_exploder);
}

//Function Number: 3
func_71F8()
{
	var_00 = getentarray("script_brushmodel","classname");
	var_01 = getentarray("script_model","classname");
	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		var_00[var_00.size] = var_01[var_02];
	}

	for(var_02 = 0;var_02 < var_00.size;var_02++)
	{
		if(isdefined(var_00[var_02].script_prefab_exploder))
		{
			var_00[var_02].script_exploder = var_00[var_02].script_prefab_exploder;
		}

		if(isdefined(var_00[var_02].script_exploder))
		{
			if(var_00[var_02].model == "fx" && !isdefined(var_00[var_02].targetname) || var_00[var_02].targetname != "exploderchunk")
			{
				var_00[var_02] hide();
				continue;
			}

			if(isdefined(var_00[var_02].targetname) && var_00[var_02].targetname == "exploder")
			{
				var_00[var_02] hide();
				var_00[var_02] notsolid();
				continue;
			}

			if(isdefined(var_00[var_02].targetname) && var_00[var_02].targetname == "exploderchunk")
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
		if(isdefined(var_04[var_02].script_prefab_exploder))
		{
			var_04[var_02].script_exploder = var_04[var_02].script_prefab_exploder;
		}

		if(isdefined(var_04[var_02].script_exploder))
		{
			var_03[var_03.size] = var_04[var_02];
		}
	}

	var_04 = getentarray("script_model","classname");
	for(var_02 = 0;var_02 < var_04.size;var_02++)
	{
		if(isdefined(var_04[var_02].script_prefab_exploder))
		{
			var_04[var_02].script_exploder = var_04[var_02].script_prefab_exploder;
		}

		if(isdefined(var_04[var_02].script_exploder))
		{
			var_03[var_03.size] = var_04[var_02];
		}
	}

	var_04 = getentarray("item_health","classname");
	for(var_02 = 0;var_02 < var_04.size;var_02++)
	{
		if(isdefined(var_04[var_02].script_prefab_exploder))
		{
			var_04[var_02].script_exploder = var_04[var_02].script_prefab_exploder;
		}

		if(isdefined(var_04[var_02].script_exploder))
		{
			var_03[var_03.size] = var_04[var_02];
		}
	}

	if(!isdefined(level.createfxent))
	{
		level.createfxent = [];
	}

	var_05 = [];
	var_05["exploderchunk visible"] = 1;
	var_05["exploderchunk"] = 1;
	var_05["exploder"] = 1;
	for(var_02 = 0;var_02 < var_03.size;var_02++)
	{
		var_06 = var_03[var_02];
		var_07 = common_scripts\utility::createexploder(var_06.script_fxid);
		var_07.var_880E = [];
		var_07.var_880E["origin"] = var_06.origin;
		var_07.var_880E["angles"] = var_06.angles;
		var_07.var_880E["delay"] = var_06.script_delay;
		var_07.var_880E["firefx"] = var_06.script_firefx;
		var_07.var_880E["firefxdelay"] = var_06.script_firefxdelay;
		var_07.var_880E["firefxsound"] = var_06.script_firefxsound;
		var_07.var_880E["firefxtimeout"] = var_06.script_firefxtimeout;
		var_07.var_880E["earthquake"] = var_06.script_earthquake;
		var_07.var_880E["damage"] = var_06.script_damage;
		var_07.var_880E["damage_radius"] = var_06.script_radius;
		var_07.var_880E["soundalias"] = var_06.script_soundalias;
		var_07.var_880E["repeat"] = var_06.script_repeat;
		var_07.var_880E["delay_min"] = var_06.script_delay_min;
		var_07.var_880E["delay_max"] = var_06.script_delay_max;
		var_07.var_880E["target"] = var_06.target;
		var_07.var_880E["ender"] = var_06.script_ender;
		var_07.var_880E["type"] = "exploder";
		if(!isdefined(var_06.script_fxid))
		{
			var_07.var_880E["fxid"] = "No FX";
		}
		else
		{
			var_07.var_880E["fxid"] = var_06.script_fxid;
		}

		var_07.var_880E["exploder"] = var_06.script_exploder;
		if(!isdefined(var_07.var_880E["delay"]))
		{
			var_07.var_880E["delay"] = 0;
		}

		if(isdefined(var_06.target))
		{
			var_08 = getent(var_07.var_880E["target"],"targetname").origin;
			var_07.var_880E["angles"] = vectortoangles(var_08 - var_07.var_880E["origin"]);
		}

		if(var_06.classname == "script_brushmodel" || isdefined(var_06.model))
		{
			var_07.model = var_06;
			var_07.model.disconnect_paths = var_06.script_disconnectpaths;
		}

		if(isdefined(var_06.targetname) && isdefined(var_05[var_06.targetname]))
		{
			var_07.var_880E["exploder_type"] = var_06.targetname;
		}
		else
		{
			var_07.var_880E["exploder_type"] = "normal";
		}

		var_07 common_scripts\_createfx::func_60C3();
	}
}

//Function Number: 4
lanterns()
{
	if(!isdefined(level._effect["lantern_light"]))
	{
		level._effect["lantern_light"] = loadfx("fx/props/glow_latern");
	}

	common_scripts\_fx::func_4F75("lantern_light",self.origin,0.3,self.origin + (0,0,1));
}

//Function Number: 5
func_71F3()
{
	var_00 = getentarray("scriptable_destructible_vehicle","targetname");
	foreach(var_02 in var_00)
	{
		var_03 = var_02.origin + (0,0,5);
		var_04 = var_02.origin + (0,0,128);
		var_05 = bullettrace(var_03,var_04,0,var_02);
		var_02.killcament = spawn("script_model",var_05["position"]);
		var_02.killcament.targetname = "killCamEnt_destructible_vehicle";
		var_02.killcament setscriptmoverkillcam("explosive");
		var_02 thread deletedestructiblekillcament();
	}

	var_07 = getentarray("scriptable_destructible_barrel","targetname");
	foreach(var_02 in var_07)
	{
		var_03 = var_02.origin + (0,0,5);
		var_04 = var_02.origin + (0,0,128);
		var_05 = bullettrace(var_03,var_04,0,var_02);
		var_02.killcament = spawn("script_model",var_05["position"]);
		var_02.killcament.targetname = "killCamEnt_explodable_barrel";
		var_02.killcament setscriptmoverkillcam("explosive");
		var_02 thread deletedestructiblekillcament();
	}
}

//Function Number: 6
deletedestructiblekillcament()
{
	level endon("game_ended");
	var_00 = self.killcament;
	var_00 endon("death");
	self waittill("death");
	wait(10);
	if(isdefined(var_00))
	{
		var_00 delete();
	}
}