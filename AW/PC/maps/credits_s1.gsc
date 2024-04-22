/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: credits_s1.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 27 ms
 * Timestamp: 4/22/2024 2:27:25 AM
*******************************************************************/

//Function Number: 1
main()
{
	level.dodgeloadout = 1;
	level.credits_active = 1;
	maps\_utility::template_level("credits_s1");
	maps\createart\credits_s1_art::main();
	maps\credits_s1_fx::main();
	maps\credits_s1_precache::main();
	maps\_load::main();
	maps\credits_s1_lighting::main();
	maps\credits_s1_aud::main();
	maps\_credits::initcredits("all");
	level.player freezecontrols(1);
	level.player takeallweapons();
	maps\_hud_util::create_client_overlay("black",1);
	thread maps\_credits::allow_early_back_out();
	maps\_credits::playcredits();
	maps\_endmission::end_mission_fade_audio_and_video(1);
	changelevel("",0);
}