/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\mp_compact.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: PC
*******************************************************************/

main()
{
	maps\mp\mp_compact_precache::main();
	maps\createart\mp_compact_art::main();
	maps\mp\mp_compact_fx::main();
	maps\mp\_destructible_dlc::main();
	maps\mp\_load::main();
	maps\mp\_compass::setupminimap("compass_map_mp_compact");
	setdvar("r_lightGridEnableTweaks", 1);
	setdvar("r_lightGridIntensity", 1.1);
	setdvar("r_lightGridContrast", 1);
	setdvar("compassmaxrange", "1700");
	ambientplay("ambient_mp_compact");
	game["attackers"] = "allies";
	game["defenders"] = "axis";
}

domagnet()
{
	strength = 18000;
	if(getdvar("scr_compact_magnet_strength") != "")
	{
		strength = getdvarfloat("scr_compact_magnet_strength");
	}

	if(strength == 0)
	{
		return;
	}

	radius = 250;
	if(getdvar("scr_compact_magnet_radius") != "")
	{
		radius = getdvarfloat("scr_compact_magnet_radius");
	}

	if(radius <= 0)
	{
		return;
	}

	magnet = getent("magnetorg", "targetname");
	missile_createattractorent(magnet, strength, radius);
}

crushercontrol()
{
	crusher = getent("crusher01", "targetname");
	crushtop = getent("crushtop01", "targetname");
	playerdetector = getent("onelevator", "targetname");
	uporigin = crusher getorigin();
	downorigin = uporigin + (0,0,-128);
	crushtop thread triggerlinkthread(crusher);
	crushtop thread crushemthread();
	playerdetector thread triggerlinkthread(crusher);
	playerdetector thread playerdetectorthread();
	for(;;)
	{
		crusher playsound("elev_run_start");
		crusher playloopsound("elev_run_loop");
		crusher moveto(downorigin, 10);
		crusher waittill("movedone");
		crusher stoploopsound("elev_run_loop");
		crusher playsound("elev_run_end");
		wait 2;
		playerdetector waittill("trigger", player);
		crusher playsound("elev_run_start");
		crusher playloopsound("elev_run_loop");
		crusher moveto(uporigin, 10);
		crusher waittill("movedone");
		crusher stoploopsound("elev_run_loop");
		crusher playsound("elev_run_end");
		wait 2;
		while(gettime() - playerdetector.triggertime <= 2000)
		{
			wait 0.05;
		}
	}
}

triggerlinkthread(crusher)
{
	for(;;)
	{
		self.origin = crusher.origin;
		wait 0.05;
	}
}

playerdetectorthread()
{
	self.triggertime = gettime();
	for(;;)
	{
		self waittill("trigger", player);
		self.triggertime = gettime();
	}
}

crushemthread()
{
	crushbottom = getent("crushbtm01", "targetname");
	for(;;)
	{
		self waittill("trigger", player);
		if(player istouching(crushbottom) && maps\mp\_utility::isreallyalive(player))
		{
			player maps\mp\_utility::_suicide();
		}
	}
}