/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: greece.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 6
 * Decompile Time: 96 ms
 * Timestamp: 4/22/2024 2:30:17 AM
*******************************************************************/

//Function Number: 1
main()
{
	maps\_utility::template_level("greece");
	levelflaginit();
	levelstartpoints();
	levelprecacheassets();
	levelglobalvars();
	levelglobalsetup();
	if(level.currentgen)
	{
		setsaveddvar("r_gunSightColorEntityScale","7");
		setsaveddvar("r_gunSightColorNoneScale","0.8");
		maps\_utility::tff_sync_setup();
	}

	maps\createart\greece_art::main();
	maps\greece_fx::main();
	maps\greece_precache::main();
	maps\_rambo::main();
	maps\_load::main();
	thread maps\_player_exo::main("specialist",1,0);
	maps\greece_lighting::main();
	maps\greece_aud::main();
	maps\greece_anim::main();
	maps\greece_safehouse::main();
	maps\greece_conf_center::main();
	maps\greece_alleys::main();
	maps\greece_sniper_scramble::main();
	maps\greece_ending::main();
	maps\greece_vo::main();
	maps\_variable_grenade::init_variable_grenade();
	maps\_compass::setupminimap("compass_map_greece");
	thread maps\_hms_utility::_glass_physics_wakeup();
	thread maps\greece_alleys::trans2alleysmagicdisappearingworldevent();
}

//Function Number: 2
levelprecacheassets()
{
	precachestring(&"GREECE_INTRO_SCREEN_TITLE_TXT");
	precachestring(&"GREECE_INTRO_SCREEN_DATE_TXT");
	precachestring(&"GREECE_INTRO_SCREEN_WHO_TXT");
	precachestring(&"GREECE_INTRO_SCREEN_SQUAD_TXT");
	precachestring(&"GREECE_INTRO_SCREEN_WHERE_TXT");
	precacheitem("iw5_hmr9_sp");
	precacheitem("iw5_hmr9_sp_variablereddot");
	precacheitem("iw5_bal27_sp");
	precacheitem("iw5_bal27_sp_silencer01_variablereddot");
	precacheitem("iw5_sn6_sp");
	precacheitem("fraggrenade");
	precacheitem("flash_grenade");
	precacherumble("steady_rumble");
	precacherumble("silencer_fire");
	precacherumble("damage_light");
	precacherumble("damage_heavy");
}

//Function Number: 3
levelflaginit()
{
	common_scripts\utility::flag_init("FlagSafeHouseStart");
	common_scripts\utility::flag_init("FlagConfCenterStart");
	common_scripts\utility::flag_init("FlagAlleysTransitionStart");
	common_scripts\utility::flag_init("FlagAlleysStart");
	common_scripts\utility::flag_init("FlagAlleysArtStart");
	common_scripts\utility::flag_init("FlagAlleysEndStart");
	common_scripts\utility::flag_init("FlagSniperScrambleStart");
	common_scripts\utility::flag_init("FlagEndingStart");
}

//Function Number: 4
levelglobalvars()
{
	level.showdebugtoggle = 0;
}

//Function Number: 5
levelglobalsetup()
{
	maps\_utility::battlechatter_on("allies");
	maps\_utility::battlechatter_on("axis");
	maps\greece_code::initfanprops();
	maps\greece_code::setdefaulthudoutlinedvars();
}

//Function Number: 6
levelstartpoints()
{
	maps\greece_safehouse::safehousestartpoints();
	maps\greece_conf_center::confcenterstartpoints();
	maps\greece_safehouse::safehousestartpointsfinal();
	maps\greece_alleys::alleysstartpoints();
	maps\greece_sniper_scramble::sniperscramblestartpoints();
	maps\greece_ending::endingstartpoints();
	if(level.currentgen)
	{
		maps\greece_transients_cg::setup_start_points_for_transients();
	}
}