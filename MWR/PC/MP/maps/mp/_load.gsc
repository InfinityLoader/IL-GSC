/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\_load.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 11
 * Decompile Time: 168 ms
 * Timestamp: 10/27/2023 2:40:24 AM
*******************************************************************/

//Function Number: 1
main()
{
	if(isdefined(level._loadstarted))
	{
		return;
	}

	level._loadstarted = 1;
	level.virtuallobbyactive = getdvarint("virtualLobbyActive",0);
	maps\mp\_utility::set_console_status();
	level.createfx_enabled = getdvar("createfx") != "";
	common_scripts\utility::struct_class_init();
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
	level.hudsetpoint_func = ::maps\mp\gametypes\_hud_util::setpoint;
	level.leaderdialogonplayer_func = ::maps\mp\_utility::leaderdialogonplayer;
	thread maps\mp\gametypes\_tweakables::init();
	if(!isdefined(level.func))
	{
		level.func = [];
	}

	level.func["precacheMpAnim"] = ::precachempanim;
	level.func["scriptModelPlayAnim"] = ::scriptmodelplayanim;
	level.func["scriptModelClearAnim"] = ::scriptmodelclearanim;
	if(!level.createfx_enabled)
	{
		thread maps\mp\_movers::init();
		thread maps\mp\_shutter::main();
		thread maps\mp\_destructables::init();
		thread common_scripts\_elevator::init();
	}

	game["thermal_vision"] = "default";
	visionsetnaked("",0);
	visionsetnight("default_night_mp");
	visionsetthermal(game["thermal_vision"]);
	visionsetpain("near_death_mp",0);
	var_00 = getentarray("lantern_glowFX_origin","targetname");
	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		var_00[var_01] thread lanterns();
	}

	maps\mp\_audio::init_audio();
	maps\mp\_art::main();
	setupexploders();
	thread common_scripts\_fx::initfx();
	if(level.createfx_enabled)
	{
		maps\mp\gametypes\_spawnlogic::setmapcenterfordev();
		maps\mp\_createfx::createfx();
	}

	if(getdvar("r_reflectionProbeGenerate") == "1")
	{
		deleteduringreflectionprobegeneration();
		maps\mp\gametypes\_spawnlogic::setmapcenterfordev();
		maps\mp\_global_fx::main();
		level waittill("eternity");
	}

	thread maps\mp\_global_fx::main();
	var_02 = 0;
	if(var_02 < 6)
	{
		switch(var_02)
		{
			case 0:
				break;

			case 1:
				break;

			case 2:
				break;

			case 3:
				break;

			case 4:
				break;

			default:
				break;
		}
	}
}

//Function Number: 2
exploder_load(param_00)
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

		level thread exploder_load(param_00);
		return;
	}

	common_scripts\_exploder::exploder(param_00.script_exploder);
	level notify("killexplodertridgers" + param_00.script_exploder);
}

//Function Number: 3
setupexploders()
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
		var_07.v = [];
		var_07.v["origin"] = var_06.origin;
		var_07.v["angles"] = var_06.angles;
		var_07.v["delay"] = var_06.script_delay;
		var_07.v["firefx"] = var_06.script_firefx;
		var_07.v["firefxdelay"] = var_06.script_firefxdelay;
		var_07.v["firefxsound"] = var_06.script_firefxsound;
		var_07.v["firefxtimeout"] = var_06.script_firefxtimeout;
		var_07.v["earthquake"] = var_06.script_earthquake;
		var_07.v["damage"] = var_06.script_damage;
		var_07.v["damage_radius"] = var_06.script_radius;
		var_07.v["soundalias"] = var_06.script_soundalias;
		var_07.v["repeat"] = var_06.script_repeat;
		var_07.v["delay_min"] = var_06.script_delay_min;
		var_07.v["delay_max"] = var_06.script_delay_max;
		var_07.v["target"] = var_06.target;
		var_07.v["ender"] = var_06.script_ender;
		var_07.v["type"] = "exploder";
		if(!isdefined(var_06.script_fxid))
		{
			var_07.v["fxid"] = "No FX";
		}
		else
		{
			var_07.v["fxid"] = var_06.script_fxid;
		}

		var_07.v["exploder"] = var_06.script_exploder;
		if(!isdefined(var_07.v["delay"]))
		{
			var_07.v["delay"] = 0;
		}

		if(isdefined(var_06.target))
		{
			var_08 = getentarray(var_07.v["target"],"targetname")[0];
			if(isdefined(var_08))
			{
				var_09 = var_08.origin;
				var_07.v["angles"] = vectortoangles(var_09 - var_07.v["origin"]);
			}
			else
			{
				var_08 = common_scripts\utility::get_target_ent(var_07.v["target"]);
				if(isdefined(var_08))
				{
					var_09 = var_08.origin;
					var_07.v["angles"] = vectortoangles(var_09 - var_07.v["origin"]);
				}
			}
		}

		if(var_06.classname == "script_brushmodel" || isdefined(var_06.model))
		{
			var_07.model = var_06;
			var_07.model.disconnect_paths = var_06.script_disconnectpaths;
		}

		if(isdefined(var_06.targetname) && isdefined(var_05[var_06.targetname]))
		{
			var_07.v["exploder_type"] = var_06.targetname;
		}
		else
		{
			var_07.v["exploder_type"] = "normal";
		}

		var_07 common_scripts\_createfx::post_entity_creation_function();
	}
}

//Function Number: 4
lanterns()
{
	common_scripts\_fx::loopfx("lantern_light",self.origin,0.3,self.origin + (0,0,1));
}

//Function Number: 5
hurtplayersthink()
{
	level endon("game_ended");
	wait(randomfloat(1));
	for(;;)
	{
		foreach(var_01 in level.players)
		{
			if(var_01 istouching(self) && maps\mp\_utility::isreallyalive(var_01))
			{
				var_01 maps\mp\_utility::_suicide();
			}
		}

		wait(0.5);
	}
}

//Function Number: 6
setupdestructiblekillcaments()
{
	var_00 = getentarray("destructible_vehicle","targetname");
	var_01 = var_00;
	var_06 = getfirstarraykey(var_01);
	if(isdefined(var_06))
	{
		var_02 = var_01[var_06];
		switch(getdvar("mapname"))
		{
			case "mp_interchange":
				break;
		}
	}
}

//Function Number: 7
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

//Function Number: 8
watchfordestructiblevehicles()
{
	var_00 = getscriptablearray();
	foreach(var_02 in var_00)
	{
		var_03 = var_02 method_8438();
		if(issubstr(var_03,"destpv_"))
		{
			var_02 thread destructiblevehiclewatch();
		}
	}
}

//Function Number: 9
destructiblevehiclewatch()
{
	self endon("death");
	self waittill("explode",var_00);
	if(isdefined(var_00) && var_00 != self)
	{
		var_00 notify("destroyed_car");
	}
}

//Function Number: 10
deleteduringreflectionprobegeneration()
{
	var_00 = getentarray("boost_jump_border","targetname");
	foreach(var_02 in var_00)
	{
		var_02 delete();
	}

	var_00 = getentarray("mp_recovery_signage","targetname");
	foreach(var_02 in var_00)
	{
		var_02 delete();
	}

	var_06 = getentarray("horde_dome","targetname");
	foreach(var_08 in var_06)
	{
		var_08 delete();
	}

	var_0A = getentarray("hp_zone_center","targetname");
	foreach(var_0C in var_0A)
	{
		if(isdefined(var_0C.target))
		{
			var_00 = getentarray(var_0C.target,"targetname");
			foreach(var_02 in var_00)
			{
				var_02 delete();
			}
		}
	}

	var_10 = getentarray("orbital_bad_spawn_overlay","targetname");
	foreach(var_12 in var_10)
	{
		var_12 delete();
	}
}

//Function Number: 11
load_costume_indices()
{
	if(isdefined(level.costumecategories))
	{
		return;
	}

	level.costumecategories = ["gender","shirt","head","gloves"];
	level.costumecat2idx = [];
	for(var_00 = 0;var_00 < level.costumecategories.size;var_00++)
	{
		var_01 = level.costumecategories[var_00];
		level.costumecat2idx[var_01] = var_00;
	}
}