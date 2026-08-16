/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\_load.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: Xbox
*******************************************************************/

main()
{
	if(isdefined(level._loadstarted))
	{
		return;
	}

	level._loadstarted = 1;
	level.createfx_enabled = getdvar("createfx") != "";
	common_scripts\utility::struct_class_init();
	maps\mp\_utility::initgameflags();
	maps\mp\_utility::initlevelflags();
	level.generic_index = 0;
	level.flag_struct = spawnstruct();
	level.flag_struct common_scripts\utility::assign_unique_id();
	if(!isdefined(level.flag))
	{
		level.flag = [];
		level.flags_lock = [];
	}

	level.requiredmapaspectratio = getdvarfloat("scr_RequiredMapAspectratio", 1);
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
		thread maps\mp\_minefields::minefields();
		thread maps\mp\_radiation::radiation();
		thread maps\mp\_shutter::main();
		thread maps\mp\_destructables::init();
		thread common_scripts\_elevator::init();
		thread common_scripts\_dynamic_world::init();
		thread common_scripts\_destructible::init();
		thread common_scripts\_pipes::main();
	}

	if(getmapcustom("thermal") == "invert")
	{
		game["thermal_vision"] = "thermal_snowlevel_mp";
		setthermalbodymaterial("thermalbody_snowlevel");
	}
	else
	{
		game["thermal_vision"] = "thermal_mp";
	}

	visionsetnaked(getdvar("mapname"), 0);
	visionsetnight("default_night_mp");
	visionsetmissilecam("missilecam");
	visionsetthermal(game["thermal_vision"]);
	visionsetpain(getdvar("mapname"));
	lanterns = getentarray("lantern_glowFX_origin", "targetname");
	for(i = 0;i < lanterns.size;i++)
	{
		lanterns[i] thread lanterns();
	}

	maps\mp\_art::main();
	thread common_scripts\_painter::main("painter_mp");
	setupexploders();
	thread common_scripts\_fx::initfx();
	if(level.createfx_enabled)
	{
		maps\mp\_createfx::createfx();
	}

	if(getdvar("r_reflectionProbeGenerate") == "1")
	{
		maps\mp\gametypes\_spawnlogic::setmapcenterforreflections();
		maps\mp\_global_fx::main();
		level waittill("eternity");
	}

	thread maps\mp\_global_fx::main();
	for(p = 0;p < 6;p++)
	{
		switch(p)
		{
			case 0:
				triggertype = "trigger_multiple";
				break;

			case 1:
				triggertype = "trigger_once";
				break;

			case 2:
				triggertype = "trigger_use";
				break;

			case 3:
				triggertype = "trigger_radius";
				break;

			case 4:
				triggertype = "trigger_lookat";
				break;

			default:
				triggertype = "trigger_damage";
				break;
		}

		triggers = getentarray(triggertype, "classname");
		for(i = 0;i < triggers.size;i++)
		{
			if(isdefined(triggers[i].script_prefab_exploder))
			{
				triggers[i].script_exploder = triggers[i].script_prefab_exploder;
			}

			if(isdefined(triggers[i].script_exploder))
			{
				level thread exploder_load(triggers[i]);
			}
		}
	}

	hurttriggers = getentarray("trigger_hurt", "classname");
	foreach(hurttrigger in hurttriggers)
	{
		hurttrigger thread hurtplayersthink();
	}

	thread maps\mp\_animatedmodels::main();
	level.func["damagefeedback"] = ::maps\mp\gametypes\_damagefeedback::updatedamagefeedback;
	level.func["setTeamHeadIcon"] = ::maps\mp\_entityheadicons::setteamheadicon;
	level.laseron_func = ::laseron;
	level.laseroff_func = ::laseroff;
	setdvar("sm_sunShadowScale", 1);
	setdvar("r_specularcolorscale", 2.5);
	setdvar("r_diffusecolorscale", 1);
	setdvar("r_lightGridEnableTweaks", 0);
	setdvar("r_lightGridIntensity", 1);
	setdvar("r_lightGridContrast", 0);
}

exploder_load(trigger)
{
	level endon("killexplodertridgers" + trigger.script_exploder);
	trigger waittill("trigger");
	if(isdefined(trigger.script_chance) && randomfloat(1) > trigger.script_chance)
	{
		if(isdefined(trigger.script_delay))
		{
			wait trigger.script_delay;
		}
		else
		{
			wait 4;
		}

		level thread exploder_load(trigger);
		return;
	}

	common_scripts\utility::exploder(trigger.script_exploder);
	level notify("killexplodertridgers" + trigger.script_exploder);
}

setupexploders()
{
	ents = getentarray("script_brushmodel", "classname");
	smodels = getentarray("script_model", "classname");
	for(i = 0;i < smodels.size;i++)
	{
		ents[ents.size] = smodels[i];
	}

	for(i = 0;i < ents.size;i++)
	{
		if(isdefined(ents[i].script_prefab_exploder))
		{
			ents[i].script_exploder = ents[i].script_prefab_exploder;
		}

		if(isdefined(ents[i].script_exploder))
		{
			if(ents[i].model == "fx" && !isdefined(ents[i].targetname) || ents[i].targetname != "exploderchunk")
			{
				ents[i] hide();
				continue;
			}

			if(isdefined(ents[i].targetname) && ents[i].targetname == "exploder")
			{
				ents[i] hide();
				ents[i] notsolid();
				continue;
			}

			if(isdefined(ents[i].targetname) && ents[i].targetname == "exploderchunk")
			{
				ents[i] hide();
				ents[i] notsolid();
			}
		}
	}

	script_exploders = [];
	potentialexploders = getentarray("script_brushmodel", "classname");
	for(i = 0;i < potentialexploders.size;i++)
	{
		if(isdefined(potentialexploders[i].script_prefab_exploder))
		{
			potentialexploders[i].script_exploder = potentialexploders[i].script_prefab_exploder;
		}

		if(isdefined(potentialexploders[i].script_exploder))
		{
			script_exploders[script_exploders.size] = potentialexploders[i];
		}
	}

	potentialexploders = getentarray("script_model", "classname");
	for(i = 0;i < potentialexploders.size;i++)
	{
		if(isdefined(potentialexploders[i].script_prefab_exploder))
		{
			potentialexploders[i].script_exploder = potentialexploders[i].script_prefab_exploder;
		}

		if(isdefined(potentialexploders[i].script_exploder))
		{
			script_exploders[script_exploders.size] = potentialexploders[i];
		}
	}

	potentialexploders = getentarray("item_health", "classname");
	for(i = 0;i < potentialexploders.size;i++)
	{
		if(isdefined(potentialexploders[i].script_prefab_exploder))
		{
			potentialexploders[i].script_exploder = potentialexploders[i].script_prefab_exploder;
		}

		if(isdefined(potentialexploders[i].script_exploder))
		{
			script_exploders[script_exploders.size] = potentialexploders[i];
		}
	}

	if(!isdefined(level.createfxent))
	{
		level.createfxent = [];
	}

	acceptabletargetnames = [];
	acceptabletargetnames["exploderchunk visible"] = 1;
	acceptabletargetnames["exploderchunk"] = 1;
	acceptabletargetnames["exploder"] = 1;
	for(i = 0;i < script_exploders.size;i++)
	{
		exploder = script_exploders[i];
		ent = common_scripts\utility::createexploder(exploder.script_fxid);
		ent.v = [];
		ent.v["origin"] = exploder.origin;
		ent.v["angles"] = exploder.angles;
		ent.v["delay"] = exploder.script_delay;
		ent.v["firefx"] = exploder.script_firefx;
		ent.v["firefxdelay"] = exploder.script_firefxdelay;
		ent.v["firefxsound"] = exploder.script_firefxsound;
		ent.v["firefxtimeout"] = exploder.script_firefxtimeout;
		ent.v["earthquake"] = exploder.script_earthquake;
		ent.v["damage"] = exploder.script_damage;
		ent.v["damage_radius"] = exploder.script_radius;
		ent.v["soundalias"] = exploder.script_soundalias;
		ent.v["repeat"] = exploder.script_repeat;
		ent.v["delay_min"] = exploder.script_delay_min;
		ent.v["delay_max"] = exploder.script_delay_max;
		ent.v["target"] = exploder.target;
		ent.v["ender"] = exploder.script_ender;
		ent.v["type"] = "exploder";
		if(!isdefined(exploder.script_fxid))
		{
			ent.v["fxid"] = "No FX";
		}
		else
		{
			ent.v["fxid"] = exploder.script_fxid;
		}

		ent.v["exploder"] = exploder.script_exploder;
		if(!isdefined(ent.v["delay"]))
		{
			ent.v["delay"] = 0;
		}

		if(isdefined(exploder.target))
		{
			org = getent(ent.v["target"], "targetname").origin;
			ent.v["angles"] = vectortoangles(org - ent.v["origin"]);
		}

		if(exploder.classname == "script_brushmodel" || isdefined(exploder.model))
		{
			ent.model = exploder;
			ent.model.disconnect_paths = exploder.script_disconnectpaths;
		}

		if(isdefined(exploder.targetname) && isdefined(acceptabletargetnames[exploder.targetname]))
		{
			ent.v["exploder_type"] = exploder.targetname;
		}
		else
		{
			ent.v["exploder_type"] = "normal";
		}

		ent common_scripts\_createfx::post_entity_creation_function();
	}
}

lanterns()
{
	if(!isdefined(level._effect["lantern_light"]))
	{
		level._effect["lantern_light"] = loadfx("props/glow_latern");
	}

	common_scripts\_fx::loopfx("lantern_light", self.origin, 0.3, self.origin + (0,0,1));
}

hurtplayersthink()
{
	level endon("game_ended");
	wait randomfloat(1);
	for(;;)
	{
		foreach(player in level.players)
		{
			if(player istouching(self) && maps\mp\_utility::isreallyalive(player))
			{
				player maps\mp\_utility::_suicide();
			}
		}

		wait 0.5;
	}
}