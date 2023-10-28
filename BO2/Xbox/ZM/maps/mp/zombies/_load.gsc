/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\zombies\_load.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: Console
 * Function Count: 10
 * Decompile Time: 17 ms
 * Timestamp: 10/28/2023 12:14:10 AM
*******************************************************************/

#include common_scripts/utility;
#include maps/mp/_art;
#include maps/mp/_audio;
#include maps/mp/_busing;
#include maps/mp/_createfx;
#include maps/mp/_demo;
#include maps/mp/_fxanim;
#include maps/mp/_global_fx;
#include maps/mp/_interactive_objects;
#include maps/mp/_music;
#include maps/mp/_script_gen;
#include maps/mp/_serverfaceanim_mp;
#include maps/mp/_utility;
#include maps/mp/animscripts/traverse/shared;
#include maps/mp/animscripts/utility;
#include maps/mp/gametypes_zm/_spawnlogic;
#include maps/mp/zombies/_load;

//Function Number: 1
main(bscriptgened,bcsvgened,bsgenabled)
{
	if(!(IsDefined(level.script_gen_dump_reasons)))
	{
		level.script_gen_dump_reasons = [];
	}

	if(!(IsDefined(bsgenabled)))
	{
		level.script_gen_dump_reasons[level.script_gen_dump_reasons.size] = "First run";
	}

	if(!(IsDefined(bcsvgened)))
	{
		bcsvgened = 0;
	}

	level.bcsvgened = bcsvgened;
	if(!(IsDefined(bscriptgened)))
	{
		bscriptgened = 0;
	}
	else
	{
		bscriptgened = 1;
	}

	level.bscriptgened = bscriptgened;
	level._loadstarted = 1;
	struct_class_init();
	level.clientscripts = GetDvar(#"8831409B") != "";
	level._client_exploders = [];
	level._client_exploder_ids = [];
	if(!(IsDefined(level.flag)))
	{
		level.flag = [];
		level.flags_lock = [];
	}

	if(!(IsDefined(level.timeofday)))
	{
		level.timeofday = "day";
	}

	flag_init("scriptgen_done");
	level.script_gen_dump_reasons = [];
	if(!(IsDefined(level.script_gen_dump)))
	{
		level.script_gen_dump = [];
		level.script_gen_dump_reasons[0] = "First run";
	}

	if(!(IsDefined(level.script_gen_dump2)))
	{
		level.script_gen_dump2 = [];
	}

	if(IsDefined(level.createfxent) && IsDefined(level.script))
	{
		script_gen_dump_addline("maps\\mp\\createfx\\" + level.script + "_fx::main();",level.script + "_fx");
	}

	if(IsDefined(level.script_gen_dump_preload))
	{
		for(i = 0;i < level.script_gen_dump_preload.size;i++)
		{
			script_gen_dump_addline(level.script_gen_dump_preload[i].string,level.script_gen_dump_preload[i].signature);
		}
	}

	if(GetDvar(#"33CF364A") == "")
	{
		setdvar("scr_RequiredMapAspectratio","1");
	}

	setdvar("r_waterFogTest",0);
	precacherumble("reload_small");
	precacherumble("reload_medium");
	precacherumble("reload_large");
	precacherumble("reload_clipin");
	precacherumble("reload_clipout");
	precacherumble("reload_rechamber");
	precacherumble("pullout_small");
	precacherumble("buzz_high");
	precacherumble("riotshield_impact");
	registerclientsys("levelNotify");
	level.aitriggerspawnflags = getaitriggerflags();
	level.vehicletriggerspawnflags = getvehicletriggerflags();
	level.physicstracemaskphysics = 1;
	level.physicstracemaskvehicle = 2;
	level.physicstracemaskwater = 4;
	level.physicstracemaskclip = 8;
	level.physicstracecontentsvehicleclip = 16;
	level.createfx_enabled = GetDvar(#"134D5297") != "";
	level thread start_intro_screen_zm();
	thread maps/mp/_interactive_objects::init();
	maps/mp/_audio::init();
	thread maps/mp/_busing::businit();
	thread maps/mp/_music::music_init();
	thread maps/mp/_fxanim::init();
	thread maps/mp/_serverfaceanim_mp::init();
	if(level.createfx_enabled)
	{
		setinitialplayersconnected();
	}

	visionsetnight("default_night");
	setup_traversals();
	maps/mp/_art::main();
	setupexploders();
	parse_structs();
	thread footsteps();
/#
	level thread level_notify_listener();
	level thread client_notify_listener();
#/
	thread maps/mp/_createfx::fx_init();
	if(level.createfx_enabled)
	{
		calculate_map_center();
		maps/mp/_createfx::createfx();
	}

	if(GetDvar(#"F7B30924") == "1")
	{
		maps/mp/_global_fx::main();
		level waittill("eternity");
	}

	thread maps/mp/_global_fx::main();
	maps/mp/_demo::init();
	for(p = 0;p < 6;p++)
	{
		switch(p)
		{
			case "ha":
				triggertype = "trigger_multiple";
				break;

			case "ha":
				triggertype = "trigger_once";
				break;

			case "ha":
				triggertype = "trigger_use";
				break;

			case "ha":
				triggertype = "trigger_radius";
				break;

			case "ha":
				triggertype = "trigger_lookat";
				break;

			default:
	/#
				assert(p == 5);
	#/
				triggertype = "trigger_damage";
				break;
		}

		triggers = getentarray(triggertype,"classname");
		for(i = 0;i < triggers.size;i++)
		{
			if(IsDefined(triggers[i].script_prefab_exploder))
			{
				triggers[i].script_exploder = triggers[i].script_prefab_exploder;
			}

			if(IsDefined(triggers[i].script_exploder))
			{
				level thread maps/mp/zombies/_load::exploder_load(triggers[i]);
			}
		}
	}
}

//Function Number: 2
level_notify_listener()
{
	while(1)
	{
		val = GetDvar(#"B42CFE95");
		if(val != "")
		{
			level notify(val);
			setdvar("level_notify","");
		}

		wait(0.2);
	}
}

//Function Number: 3
client_notify_listener()
{
	while(1)
	{
		val = GetDvar(#"C5740DFC");
		if(val != "")
		{
			clientnotify(val);
			setdvar("client_notify","");
		}

		wait(0.2);
	}
}

//Function Number: 4
footsteps()
{
	if(is_true(level.fx_exclude_footsteps))
	{
		return;
	}

	maps/mp/animscripts/utility::setfootstepeffect("asphalt",loadfx("bio/player/fx_footstep_dust"));
	maps/mp/animscripts/utility::setfootstepeffect("brick",loadfx("bio/player/fx_footstep_dust"));
	maps/mp/animscripts/utility::setfootstepeffect("carpet",loadfx("bio/player/fx_footstep_dust"));
	maps/mp/animscripts/utility::setfootstepeffect("cloth",loadfx("bio/player/fx_footstep_dust"));
	maps/mp/animscripts/utility::setfootstepeffect("concrete",loadfx("bio/player/fx_footstep_dust"));
	maps/mp/animscripts/utility::setfootstepeffect("dirt",loadfx("bio/player/fx_footstep_sand"));
	maps/mp/animscripts/utility::setfootstepeffect("foliage",loadfx("bio/player/fx_footstep_sand"));
	maps/mp/animscripts/utility::setfootstepeffect("gravel",loadfx("bio/player/fx_footstep_dust"));
	maps/mp/animscripts/utility::setfootstepeffect("grass",loadfx("bio/player/fx_footstep_dust"));
	maps/mp/animscripts/utility::setfootstepeffect("metal",loadfx("bio/player/fx_footstep_dust"));
	maps/mp/animscripts/utility::setfootstepeffect("mud",loadfx("bio/player/fx_footstep_mud"));
	maps/mp/animscripts/utility::setfootstepeffect("paper",loadfx("bio/player/fx_footstep_dust"));
	maps/mp/animscripts/utility::setfootstepeffect("plaster",loadfx("bio/player/fx_footstep_dust"));
	maps/mp/animscripts/utility::setfootstepeffect("rock",loadfx("bio/player/fx_footstep_dust"));
	maps/mp/animscripts/utility::setfootstepeffect("sand",loadfx("bio/player/fx_footstep_sand"));
	maps/mp/animscripts/utility::setfootstepeffect("water",loadfx("bio/player/fx_footstep_water"));
	maps/mp/animscripts/utility::setfootstepeffect("wood",loadfx("bio/player/fx_footstep_dust"));
}

//Function Number: 5
parse_structs()
{
	for(i = 0;i < level.struct.size;i++)
	{
		if(IsDefined(level.struct[i].targetname))
		{
			if(level.struct[i].targetname == "flak_fire_fx")
			{
				level._effect["flak20_fire_fx"] = loadfx("weapon/tracer/fx_tracer_flak_single_noExp");
				level._effect["flak38_fire_fx"] = loadfx("weapon/tracer/fx_tracer_quad_20mm_Flak38_noExp");
				level._effect["flak_cloudflash_night"] = loadfx("weapon/flak/fx_flak_cloudflash_night");
				level._effect["flak_burst_single"] = loadfx("weapon/flak/fx_flak_single_day_dist");
			}

			if(level.struct[i].targetname == "fake_fire_fx")
			{
				level._effect["distant_muzzleflash"] = loadfx("weapon/muzzleflashes/heavy");
			}

			if(level.struct[i].targetname == "spotlight_fx")
			{
				level._effect["spotlight_beam"] = loadfx("env/light/fx_ray_spotlight_md");
			}
		}
	}
}

//Function Number: 6
exploder_load(trigger)
{
	level endon("killexplodertridgers" + trigger.script_exploder);
	trigger waittill("trigger");
	if(IsDefined(trigger.script_chance) && randomfloat(1) > trigger.script_chance)
	{
		if(IsDefined(trigger.script_delay))
		{
			wait(trigger.script_delay);
		}
		else
		{
			wait(4);
		}

		level thread exploder_load(trigger);
		return;
	}

	maps/mp/_utility::exploder(trigger.script_exploder);
	level notify("killexplodertridgers" + trigger.script_exploder);
}

//Function Number: 7
setupexploders()
{
	ents = getentarray("script_brushmodel","classname");
	smodels = getentarray("script_model","classname");
	for(i = 0;i < smodels.size;i++)
	{
		ents[ents.size] = smodels[i];
	}

	for(i = 0;i < ents.size;i++)
	{
		if(IsDefined(ents[i].script_prefab_exploder))
		{
			ents[i].script_exploder = ents[i].script_prefab_exploder;
		}

		if(IsDefined(ents[i].script_exploder))
		{
			if(ents[i].model == "fx" && !IsDefined(ents[i].targetname) || ents[i].targetname != "exploderchunk")
			{
				ents[i] hide();
			}
			else if(IsDefined(ents[i].targetname) && ents[i].targetname == "exploder")
			{
				ents[i] hide();
				ents[i] notsolid();
			}
			else if(IsDefined(ents[i].targetname) && ents[i].targetname == "exploderchunk")
			{
				ents[i] hide();
				ents[i] notsolid();
			}
		}
	}

	script_exploders = [];
	potentialexploders = getentarray("script_brushmodel","classname");
	for(i = 0;i < potentialexploders.size;i++)
	{
		if(IsDefined(potentialexploders[i].script_prefab_exploder))
		{
			potentialexploders[i].script_exploder = potentialexploders[i].script_prefab_exploder;
		}

		if(IsDefined(potentialexploders[i].script_exploder))
		{
			script_exploders[script_exploders.size] = potentialexploders[i];
		}
	}

	potentialexploders = getentarray("script_model","classname");
	for(i = 0;i < potentialexploders.size;i++)
	{
		if(IsDefined(potentialexploders[i].script_prefab_exploder))
		{
			potentialexploders[i].script_exploder = potentialexploders[i].script_prefab_exploder;
		}

		if(IsDefined(potentialexploders[i].script_exploder))
		{
			script_exploders[script_exploders.size] = potentialexploders[i];
		}
	}

	potentialexploders = getentarray("item_health","classname");
	for(i = 0;i < potentialexploders.size;i++)
	{
		if(IsDefined(potentialexploders[i].script_prefab_exploder))
		{
			potentialexploders[i].script_exploder = potentialexploders[i].script_prefab_exploder;
		}

		if(IsDefined(potentialexploders[i].script_exploder))
		{
			script_exploders[script_exploders.size] = potentialexploders[i];
		}
	}

	if(!(IsDefined(level.createfxent)))
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
		ent = createexploder(exploder.script_fxid);
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
		if(!(IsDefined(exploder.script_fxid)))
		{
			ent.v["fxid"] = "No FX";
		}
		else
		{
			ent.v["fxid"] = exploder.script_fxid;
		}

		ent.v["exploder"] = exploder.script_exploder;
/#
		assert(IsDefined(exploder.script_exploder),"Exploder at origin " + exploder.origin + " has no script_exploder");
#/
		if(!(IsDefined(ent.v["delay"])))
		{
			ent.v["delay"] = 0;
		}

		if(IsDefined(exploder.target))
		{
			org = getent(ent.v["target"],"targetname").origin;
			ent.v["angles"] = VectorToAngles(org - ent.v["origin"]);
		}

		if(exploder.classname == "script_brushmodel" || IsDefined(exploder.model))
		{
			ent.model = exploder;
			ent.model.disconnect_paths = exploder.script_disconnectpaths;
		}

		if(IsDefined(exploder.targetname) && IsDefined(acceptabletargetnames[exploder.targetname]))
		{
			ent.v["exploder_type"] = exploder.targetname;
		}
		else
		{
			ent.v["exploder_type"] = "normal";
		}

		ent maps/mp/_createfx::post_entity_creation_function();
	}

	level.createfxexploders = [];
	for(i = 0;i < level.createfxent.size;i++)
	{
		ent = level.createfxent[i];
		if(ent.v["type"] != "exploder")
		{
		}
		else
		{
			ent.v["exploder_id"] = getexploderid(ent);
			if(!(IsDefined(level.createfxexploders[ent.v["exploder"]])))
			{
				level.createfxexploders[ent.v["exploder"]] = [];
			}

			level.createfxexploders[ent.v["exploder"]][level.createfxexploders[ent.v["exploder"]].size] = ent;
		}
	}
}

//Function Number: 8
setup_traversals()
{
	potential_traverse_nodes = getallnodes();
	for(i = 0;i < potential_traverse_nodes.size;i++)
	{
		node = potential_traverse_nodes[i];
		if(node.type == "Begin")
		{
			node maps/mp/animscripts/traverse/shared::init_traverse();
		}
	}
}

//Function Number: 9
calculate_map_center()
{
	if(!(IsDefined(level.mapcenter)))
	{
		level.nodesmins = (0,0,0);
		level.nodesmaxs = (0,0,0);
		level.mapcenter = maps/mp/gametypes_zm/_spawnlogic::findboxcenter(level.nodesmins,level.nodesmaxs);
/#
		println("map center: ",level.mapcenter);
#/
		setmapcenter(level.mapcenter);
	}
}

//Function Number: 10
start_intro_screen_zm()
{
	if(level.createfx_enabled)
	{
		return;
	}

	if(!(IsDefined(level.introscreen)))
	{
		level.introscreen = newhudelem();
		level.introscreen.x = 0;
		level.introscreen.y = 0;
		level.introscreen.horzalign = "fullscreen";
		level.introscreen.vertalign = "fullscreen";
		level.introscreen.foreground = 0;
		level.introscreen setshader("black",640,480);
		level.introscreen.immunetodemogamehudsettings = 1;
		level.introscreen.immunetodemofreecamera = 1;
		wait(0.05);
	}

	level.introscreen.alpha = 1;
	players = get_players();
	for(i = 0;i < players.size;i++)
	{
		players[i] freezecontrols(1);
	}

	wait(1);
}