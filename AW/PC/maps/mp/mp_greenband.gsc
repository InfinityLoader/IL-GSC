/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\mp_greenband.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 14
 * Decompile Time: 219 ms
 * Timestamp: 4/22/2024 2:17:28 AM
*******************************************************************/

//Function Number: 1
main()
{
	maps\mp\mp_greenband_precache::main();
	maps\createart\mp_greenband_art::main();
	maps\mp\mp_greenband_fx::main();
	maps\mp\_load::main();
	thread setup_audio();
	maps\mp\_compass::setupminimap("compass_map_mp_greenband");
	setdvar("r_lightGridEnableTweaks",1);
	setdvar("r_lightGridIntensity",1.33);
	setdvar("r_diffuseColorScale",1.5);
	setdvar("r_gunSightColorEntityScale","7");
	setdvar("r_gunSightColorNoneScale","0.8");
	level.ospvisionset = "(mp_greenband_osp)";
	level.osplightset = "(mp_greenband_osp)";
	level.dronevisionset = "(mp_greenband_drone)";
	level.dronelightset = "(mp_greenband_drone)";
	level.warbirdvisionset = "(mp_greenband_warbird)";
	level.warbirdlightset = "(mp_greenband_warbird)";
	game["attackers"] = "allies";
	game["defenders"] = "axis";
	if(level.nextgen)
	{
		level.aerial_pathnode_group_connect_dist = 600;
	}

	level thread maps\mp\_water::init();
	level thread greenband_drones();
	if(!isdefined(level.airstrikeoverrides))
	{
		level.airstrikeoverrides = spawnstruct();
	}

	level.airstrikeoverrides.spawnheight = 2500;
	level.orbitalsupportoverridefunc = ::greenbandcustomospfunc;
	level.goliath_bad_landing_volumes = getentarray("goliath_bad_landing_volume","targetname");
	level thread greenbandpatchclip();
}

//Function Number: 2
greenbandpatchclip()
{
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(-1722,-3380,128),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(-1722,-3380,384),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(-1722,-3380,640),(0,270,0));
}

//Function Number: 3
greenbandcustomospfunc()
{
	level.orbitalsupportoverrides.spawnheight = 9279;
	level.orbitalsupportoverrides.spawnradius = 7000;
	level.orbitalsupportoverrides.turretpitch = 50;
	level.orbitalsupportoverrides.spawnanglemin = undefined;
	level.orbitalsupportoverrides.spawnanglemax = undefined;
	if(level.currentgen)
	{
		level.orbitalsupportoverrides.toparc = -40;
	}
}

//Function Number: 4
setup_audio()
{
	ambientplay("amb_gnb_ext");
}

//Function Number: 5
greenband_drones()
{
	level.drones = [];
	level thread ambient_police_drones();
	level thread vista_police_drones();
	level thread vista_police_group_drones();
}

//Function Number: 6
spawn_police_drone_with_anim(param_00,param_01,param_02)
{
	var_03 = common_scripts\utility::getstruct("event_anim_node","targetname");
	var_04 = spawn_police_drone(param_00);
	if(isdefined(param_02))
	{
		for(;;)
		{
			var_04.health = 20;
			var_04 setcandamage(1);
			var_04 thread police_drone_play_anim(param_01,param_02,param_00,var_03);
			var_04 waittill("death");
			var_04 hide();
			playfx(level._effect["vehicle_pdrone_explosion"],var_04.origin);
			playsoundatpos(var_04.origin,"mp_greenband_drone_exp");
			var_04 waittillmatch("enter_start","event_police_drone");
			var_04 show();
			var_04 thread police_drone_play_all_fx();
		}

		return;
	}

	var_04 thread police_drone_play_anim(param_01,undefined,param_00,var_03);
}

//Function Number: 7
police_drone_play_anim(param_00,param_01,param_02,param_03)
{
	self notify("police_drone_play_anim");
	self endon("police_drone_play_anim");
	self scriptmodelclearanim();
	if(isdefined(param_01))
	{
		self scriptmodelplayanimdeltamotionfrompos(param_01,param_03.origin,param_03.angles,"event_police_drone");
		self waittillmatch("end","event_police_drone");
	}

	self scriptmodelplayanimdeltamotionfrompos(param_00,param_03.origin,param_03.angles,"event_police_drone");
}

//Function Number: 8
spawn_police_drone(param_00)
{
	var_01 = spawn("script_model",(0,0,0));
	var_01.angles = (0,0,0);
	var_01.destroyed = 0;
	var_01.dronetype = param_00;
	if(!isdefined(level.drones[param_00]))
	{
		level.drones[param_00] = [];
	}

	level.drones[param_00][level.drones[param_00].size] = var_01;
	switch(param_00)
	{
		case "ambient":
		case "test":
			var_01.light_fx_name = "mp_gb_drone_blink_nt";
			var_01.exhaust_fx_name = "mp_gb_drone_trail";
			var_01 setmodel("vehicle_police_drone_01_anim");
			var_01 playloopsound("mp_gnb_police_drone_hover_lp");
			break;

		case "vista":
			var_01.light_fx_name = "mp_gb_drone_blink_vista";
			var_01.exhaust_fx_name = "mp_gb_drone_trail_vista";
			var_01 setmodel("vehicle_police_drone_01_simple_anim");
			break;

		case "vista_group":
			var_01.light_fx_name = "mp_gb_drone_hd_grp";
			var_01.exhaust_fx_name = "mp_gb_drone_trail_grp";
			var_01 setmodel("vehicle_police_drone_01_group_anim");
			var_01 playloopsound("mp_gnb_drone_group_flyby");
			break;

		default:
			break;
	}

	var_01 thread police_drone_play_all_fx();
	return var_01;
}

//Function Number: 9
police_drone_play_all_fx()
{
	self endon("death");
	thread police_drone_play_fx(self.light_fx_name,"tag_lights");
	thread police_drone_play_fx(self.exhaust_fx_name,"tag_exhaust");
	for(;;)
	{
		level waittill("connected",var_00);
		thread police_drone_play_fx(self.light_fx_name,"tag_lights",var_00);
		thread police_drone_play_fx(self.exhaust_fx_name,"tag_exhaust",var_00);
	}
}

//Function Number: 10
police_drone_play_fx(param_00,param_01,param_02)
{
	if(!isdefined(param_00))
	{
		return;
	}

	if(isdefined(param_02))
	{
		param_02 endon("death");
	}

	wait 0.05;
	var_03 = [param_01];
	if(self.dronetype == "vista_group")
	{
		for(var_04 = 1;var_04 < 5;var_04++)
		{
			var_03[var_03.size] = param_01 + "" + var_04;
		}
	}

	foreach(var_06 in var_03)
	{
		if(isdefined(param_02))
		{
			playfxontagforclients(level._effect[param_00],self,var_06,param_02);
		}
		else
		{
			playfxontag(level._effect[param_00],self,var_06);
		}

		wait 0.05;
	}
}

//Function Number: 11
vista_police_group_drones()
{
	level thread spawn_police_drone_with_anim("vista_group","mp_gb_drone_vista_group_01");
	level thread spawn_police_drone_with_anim("vista_group","mp_gb_drone_vista_group_02");
}

//Function Number: 12
vista_police_drones()
{
	level thread spawn_police_drone_with_anim("vista","mp_gb_drone_vista_01");
	level thread spawn_police_drone_with_anim("vista","mp_gb_drone_vista_02");
	level thread spawn_police_drone_with_anim("vista","mp_gb_drone_vista_03");
	level thread spawn_police_drone_with_anim("vista","mp_gb_drone_vista_04");
}

//Function Number: 13
ambient_police_drones()
{
	level thread spawn_police_drone_with_anim("ambient","mp_gb_drone_circle_01","mp_gb_drone_circle_01_enter");
	level thread spawn_police_drone_with_anim("ambient","mp_gb_drone_circle_02","mp_gb_drone_circle_02_enter");
	level thread spawn_police_drone_with_anim("ambient","mp_gb_drone_circle_03","mp_gb_drone_circle_03_enter");
	level thread spawn_police_drone_with_anim("ambient","mp_gb_drone_circle_04","mp_gb_drone_circle_04_enter");
	level thread ambient_police_drone_vo();
}

//Function Number: 14
ambient_police_drone_vo()
{
	for(;;)
	{
		foreach(var_01 in level.drones["ambient"])
		{
			if(!var_01.destroyed)
			{
				wait(randomfloatrange(7,15));
				var_01 playsound("mp_gnb_police_drone_chatter");
			}
		}

		wait(1);
	}
}