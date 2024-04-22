/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\mp_refraction.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 12
 * Decompile Time: 197 ms
 * Timestamp: 4/22/2024 2:18:16 AM
*******************************************************************/

//Function Number: 1
main()
{
	maps\mp\mp_refraction_precache::main();
	maps\createart\mp_refraction_art::main();
	maps\mp\mp_refraction_lighting::main();
	maps\mp\mp_refraction_fx::main();
	level.aerial_pathnode_offset = 600;
	level.aerial_pathnode_group_connect_dist = 300;
	level.ospvisionset = "mp_refraction_osp";
	level.osplightset = "mp_refraction_osp";
	level.warbirdvisionset = "mp_refraction_osp";
	level.warbirdlightset = "mp_refraction_osp";
	level.vulcanvisionset = "mp_refraction_osp";
	level.vulcanlightset = "mp_refraction_osp";
	maps\mp\_load::main();
	level.alarmfx = loadfx("vfx/lights/light_red_pulse_fast");
	level.rain = loadfx("vfx/rain/rain_volume_windy");
	level thread common_scripts\_exploder::activate_clientside_exploder(10);
	maps\mp\_water::init();
	maps\mp\_compass::setupminimap("compass_map_mp_refraction");
	setdvar("r_lightGridEnableTweaks",1);
	setdvar("r_lightGridIntensity",1.33);
	thread set_lighting_values();
	game["attackers"] = "allies";
	game["defenders"] = "axis";
	level.mapcustomkillstreakfunc = ::refractioncustomkillstreakfunc;
	level.orbitalsupportoverridefunc = ::refractioncustomospfunc;
	level.remote_missile_height_override = 16000;
	level.orbitallaseroverridefunc = ::refractionvulcancustomfunc;
	thread scriptpatchclip();
	thread scriptpatchdisconnectnodes();
	common_scripts\utility::array_thread(getentarray("com_radar_dish","targetname"),::radar_dish_rotate);
}

//Function Number: 2
scriptpatchclip()
{
	thread lockingpiececlip();
}

//Function Number: 3
scriptpatchdisconnectnodes()
{
	thread whitneybuildingnodes();
	thread overgapcenternodes01();
}

//Function Number: 4
whitneybuildingnodes()
{
	findpairnodeanddisconnect((2554.5,-700,2286));
	findpairnodeanddisconnect((2778,-886,2204));
}

//Function Number: 5
overgapcenternodes01()
{
	findpairnodeanddisconnect((-289.1,-1157.1,2000));
}

//Function Number: 6
findpairnodeanddisconnect(param_00)
{
	var_01 = getnodesinradius(param_00,64,0,72,"Begin");
	foreach(var_03 in var_01)
	{
		if(isdefined(var_03.target))
		{
			var_04 = getnode(var_03.target,"targetname");
			if(isdefined(var_04) && isdefined(var_03))
			{
				disconnectnodepair(var_03,var_04);
			}
		}
	}
}

//Function Number: 7
lockingpiececlip()
{
	maps\mp\_utility::spawnpatchclip("patchclip_nosight_16_128_128",(110,-180,2565.5),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_nosight_16_128_128",(110,-180,2693.5),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_nosight_16_128_128",(110,-180,2821.5),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_nosight_16_128_128",(110,-180,2874),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_nosight_16_128_128",(38,-180,2930),(90,0,180));
	maps\mp\_utility::spawnpatchclip("patchclip_nosight_16_128_128",(-38,-180,2930),(90,0,180));
	maps\mp\_utility::spawnpatchclip("patchclip_nosight_16_128_128",(-110,-180,2874),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_nosight_16_128_128",(-110,-180,2821.5),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_nosight_16_128_128",(-110,-180,2693.5),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_nosight_16_128_128",(-110,-180,2565.5),(0,0,0));
}

//Function Number: 8
refractioncustomkillstreakfunc()
{
	level.killstreakweildweapons["refraction_turret_mp"] = 1;
	level thread maps\mp\killstreaks\streak_mp_refraction::init();
}

//Function Number: 9
refractioncustomospfunc()
{
	level.orbitalsupportoverrides.spawnanglemin = 260;
	level.orbitalsupportoverrides.spawnanglemax = 350;
	level.orbitalsupportoverrides.turretpitch = 50;
	level.orbitalsupportoverrides.toparc = -38;
	level.orbitalsupportoverrides.spawnheight = 10426;
}

//Function Number: 10
refractionvulcancustomfunc()
{
	level.orbitallaseroverrides.spawnpoint = (20,-500,0);
}

//Function Number: 11
radar_dish_rotate()
{
	var_00 = 0;
	var_01 = 40000;
	var_02 = 1;
	if(isdefined(self.speed))
	{
		var_02 = self.speed;
	}

	var_00 = 70;
	if(isdefined(self.script_noteworthy) && self.script_noteworthy == "lockedspeed")
	{
		wait(0);
	}
	else
	{
		wait(randomfloatrange(0,1));
	}

	for(;;)
	{
		self rotatevelocity((0,var_00,0),var_01);
		wait(var_01);
	}
}

//Function Number: 12
set_lighting_values()
{
	if(isusinghdr())
	{
		for(;;)
		{
			level waittill("connected",var_00);
			var_00 setclientdvars("r_tonemap","1");
		}
	}
}