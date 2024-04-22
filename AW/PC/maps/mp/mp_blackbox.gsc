/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\mp_blackbox.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 23
 * Decompile Time: 358 ms
 * Timestamp: 4/22/2024 2:17:04 AM
*******************************************************************/

//Function Number: 1
main()
{
	level.callbackstartgametype = ::blackbox_callbackstartgametype;
	maps\mp\mp_blackbox_precache::main();
	maps\createart\mp_blackbox_art::main();
	maps\mp\mp_blackbox_fx::main();
	maps\mp\_load::main();
	maps\mp\mp_blackbox_lighting::main();
	maps\mp\mp_blackbox_aud::main();
	maps\mp\_compass::setupminimap("compass_map_mp_blackbox");
	game["attackers"] = "allies";
	game["defenders"] = "axis";
	level.ospvisionset = "mp_blackbox_osp";
	level.osplightset = "mp_blackbox_osp";
	level.dronevisionset = "mp_blackbox_drone";
	level.dronelightset = "mp_blackbox_drone";
	level.warbirdvisionset = "mp_blackbox_warbird";
	level.warbirdlightset = "mp_blackbox_warbird";
	level.mapcustomkillstreakfunc = ::blackboxcustomkillstreakfunc;
	level.orbitalsupportoverridefunc = ::blackboxcustomospfunc;
	thread blackboxcustomairstrike();
	level.orbitallaseroverridefunc = ::blackboxcustomorbitallaserfunc;
	thread surface_light_relocation();
	level thread resetuplinkballoutofbounds();
	level thread patchclip();
}

//Function Number: 2
patchclip()
{
	thread grappleshipclip01();
	thread grappleshipclip02();
	thread grappleshipclip03();
	thread grappleshipclip04();
	thread grappleshipclip05();
	thread spectateshipclip01();
	thread grappleexteriordebris01();
	thread grappleexteriorship01();
	thread grapplerock01();
	thread droneterrainclip();
	thread cockpitgrappleclip();
}

//Function Number: 3
grappleshipclip05()
{
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(-581,-1713,1788),(0,250,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(-581,-1713,1660),(0,250,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(-581,-1713,1532),(0,250,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(-581,-1713,1404),(0,250,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(-537,-1593,1788),(0,250,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(-537,-1593,1660),(0,250,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(-537,-1593,1532),(0,250,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(-537,-1593,1404),(0,250,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(-476,-1752,1788),(0,250,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(-476,-1752,1660),(0,250,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(-476,-1752,1532),(0,250,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(-476,-1752,1404),(0,250,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(-433,-1632,1788),(0,250,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(-433,-1632,1660),(0,250,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(-433,-1632,1532),(0,250,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(-433,-1632,1404),(0,250,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(-389,-1512,1788),(0,250,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(-389,-1512,1660),(0,250,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(-389,-1512,1532),(0,250,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(-389,-1512,1404),(0,250,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(-355,-1673,1818),(0,250,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(-355,-1673,1690),(0,250,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(-355,-1673,1562),(0,250,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(-311,-1553,1818),(0,250,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(-311,-1553,1690),(0,250,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(-311,-1553,1562),(0,250,0));
}

//Function Number: 4
spectateshipclip01()
{
	maps\mp\_utility::spawnpatchclip("patchclip_vehicle_16_256_256",(752,-1012,1432),(89.9999,38.8699,-31.1302));
	maps\mp\_utility::spawnpatchclip("patchclip_vehicle_16_256_256",(692,-1178,1432),(89.9999,38.8699,-31.1302));
	maps\mp\_utility::spawnpatchclip("patchclip_vehicle_16_128_128",(586,-1020,1498),(0,69.9994,0));
}

//Function Number: 5
grappleshipclip04()
{
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(646,-452,1420),(0,29.1973,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(646,-452,1676),(0,29.1973,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(646,-452,1932),(0,29.1973,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(672,-444,1932),(0,19.1973,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(672,-444,1676),(0,19.1973,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(672,-444,1420),(0,19.1973,0));
}

//Function Number: 6
grapplerock01()
{
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(1022,1918,1237),(0,2.69981,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(1034,1663,1237),(0,2.69981,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(1034,1663,1493),(0,2.69981,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(1022,1918,1493),(0,2.69981,0));
	maps\mp\_utility::spawnpatchclip("patchclip_grapple_16_256_256",(1034,1663,1237),(0,2.69981,0));
}

//Function Number: 7
grappleshipclip01()
{
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(955,34.5,1574),(0,244,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(955,34.5,1830),(0,244,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(955,34.5,2086),(0,244,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(955,34.5,2342),(0,244,0));
}

//Function Number: 8
grappleshipclip02()
{
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_128_128",(-1083.99,-2538.42,1468),(0,157.1,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_128_128",(-1083.99,-2538.42,1596),(0,157.1,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_128_128",(-1083.99,-2538.42,1724),(0,157.1,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_128_128",(-1083.99,-2538.42,1852),(0,157.1,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_128_128",(-1083.99,-2538.42,1980),(0,157.1,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_128_128",(-1083.99,-2538.42,2108),(0,157.1,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_128_128",(-1098.6,-2448.2,1468),(0,207.7,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_128_128",(-1098.6,-2448.2,1596),(0,207.7,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_128_128",(-1098.6,-2448.2,1724),(0,207.7,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_128_128",(-1098.6,-2448.2,1852),(0,207.7,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_128_128",(-1098.6,-2448.2,1980),(0,207.7,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_128_128",(-1098.6,-2448.2,2108),(0,207.7,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(-1215.06,-2369.69,1532),(0,253.3,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(-1215.06,-2369.69,1788),(0,253.3,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(-1215.06,-2369.69,2044),(0,253.3,0));
}

//Function Number: 9
grappleshipclip03()
{
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(-170,76,1212),(90,297.479,1.4795));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(-282,306,1212),(90,297.479,1.4795));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(-334,412,1212),(90,297.479,1.4795));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(398,314,1212),(90,297.479,1.4795));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(286,544,1212),(90,297.479,1.4795));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(228,664,1212),(90,297.479,1.4795));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_128_128",(-158,24,1186),(0,295.999,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_128_128",(-28,26,1186),(0,251.998,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_64_64_64",(42,-20,1268),(0,295.999,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_128_128",(330,200,1186),(0,339.999,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_128_128",(408,292,1186),(0,295.999,0));
}

//Function Number: 10
grappleexteriordebris01()
{
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(1436,-2710,1612),(0,295.999,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(1436,-2710,1868),(0,295.999,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(1436,-2710,2124),(0,295.999,0));
	maps\mp\_utility::spawnpatchclip("patchclip_grapple_16_256_256",(1430,-2710,1612),(0,295.999,0));
}

//Function Number: 11
grappleexteriorship01()
{
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(-514,486,1760),(0,295.999,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(-514,486,1504),(0,295.999,0));
}

//Function Number: 12
droneterrainclip()
{
	maps\mp\_utility::spawnpatchclip("patchclip_vehicle_16_256_256",(1320.71,-3140.18,1344),(270,184.081,67.9193));
	maps\mp\_utility::spawnpatchclip("patchclip_vehicle_16_256_256",(1399.82,-2896.71,1344),(270,184.081,67.9193));
	maps\mp\_utility::spawnpatchclip("patchclip_vehicle_16_256_256",(1643.29,-2975.82,1344),(270,184.081,67.9193));
	maps\mp\_utility::spawnpatchclip("patchclip_vehicle_16_256_256",(1564.18,-3219.29,1344),(270,184.081,67.9193));
}

//Function Number: 13
cockpitgrappleclip()
{
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(-252,2332,854),(296.672,48.4086,-64.9689));
}

//Function Number: 14
resetuplinkballoutofbounds()
{
	level endon("game_ended");
	if(level.gametype == "ball")
	{
		while(!isdefined(level.balls))
		{
			wait(0.05);
		}

		foreach(var_01 in level.balls)
		{
			var_01 thread watchcarryobjects();
		}
	}
}

//Function Number: 15
watchcarryobjects()
{
	level endon("game_ended");
	for(;;)
	{
		self waittill("dropped");
		wait(0.1);
		thread monitorballstate();
		var_00 = common_scripts\utility::waittill_any_return("pickup_object","reset");
	}
}

//Function Number: 16
monitorballstate()
{
	self endon("pickup_object");
	self endon("reset");
	for(;;)
	{
		if(isoutofbounds())
		{
			thread maps\mp\gametypes\_gameobjects::returnhome();
			return;
		}

		wait(0.05);
	}
}

//Function Number: 17
isoutofbounds()
{
	var_00 = getentarray("object_out_of_bounds","targetname");
	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		if(!self.visuals[0] istouching(var_00[var_01]))
		{
			continue;
		}

		return 1;
	}

	return 0;
}

//Function Number: 18
blackbox_callbackstartgametype()
{
	maps\mp\gametypes\_gamelogic::callback_startgametype();
	common_scripts\_bcs_location_trigs_dlc::bcs_location_trigs_dlc_init();
}

//Function Number: 19
blackboxcustomkillstreakfunc()
{
	level.killstreakweildweapons["iw5_dlcgun12loot4_mp"] = 1;
	level thread maps\mp\killstreaks\streak_mp_blackbox::streak_init();
}

//Function Number: 20
surface_light_relocation()
{
	var_00 = getentarray("alien_green_surface_lights","targetname");
	foreach(var_02 in var_00)
	{
		var_02 hide();
	}
}

//Function Number: 21
blackboxcustomospfunc()
{
	level.orbitalsupportoverrides.spawnanglemin = 10;
	level.orbitalsupportoverrides.spawnanglemax = 70;
	level.orbitalsupportoverrides.spawnheight = 9000;
	if(level.currentgen)
	{
		level.orbitalsupportoverrides.leftarc = 20;
		level.orbitalsupportoverrides.rightarc = 20;
		level.orbitalsupportoverrides.toparc = -30;
		level.orbitalsupportoverrides.bottomarc = 60;
	}
}

//Function Number: 22
blackboxcustomairstrike()
{
	if(!isdefined(level.airstrikeoverrides))
	{
		level.airstrikeoverrides = spawnstruct();
	}

	level.airstrikeoverrides.spawnheight = 6000;
}

//Function Number: 23
blackboxcustomorbitallaserfunc()
{
	level.orbitallaseroverrides.spawnheight = 3500;
}