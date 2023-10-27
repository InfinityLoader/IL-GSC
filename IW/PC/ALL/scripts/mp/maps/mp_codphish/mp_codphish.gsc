/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\maps\mp_codphish\mp_codphish.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 152 ms
 * Timestamp: 10/27/2023 12:13:18 AM
*******************************************************************/

//Function Number: 1
main()
{
	scripts\mp\maps\mp_codphish\mp_codphish_precache::main();
	scripts\mp\maps\mp_codphish\gen\mp_codphish_art::main();
	scripts\mp\maps\mp_codphish\mp_codphish_fx::main();
	scripts\mp\_load::main();
	level.var_C7B3 = getentarray("OutOfBounds","targetname");
	scripts\mp\_compass::func_FACD("compass_map_mp_codphish");
	setdvar("r_lightGridEnableTweaks",1);
	setdvar("r_lightGridIntensity",1.33);
	setdvar("r_umbraMinObjectContribution",8);
	game["attackers"] = "allies";
	game["defenders"] = "axis";
	game["allies_outfit"] = "urban";
	game["axis_outfit"] = "woodland";
	level.var_C7B3 = getentarray("OutOfBounds","targetname");
	thread apex_not_outofbounds();
}

//Function Number: 2
apex_not_outofbounds()
{
	level.outofboundstriggerpatches = [];
	var_00 = getent("apex_unoutofbounds","targetname");
	level.outofboundstriggerpatches[level.outofboundstriggerpatches.size] = var_00;
	level waittill("game_ended");
	foreach(var_00 in level.outofboundstriggerpatches)
	{
		if(isdefined(var_00))
		{
			var_00 delete();
		}
	}
}