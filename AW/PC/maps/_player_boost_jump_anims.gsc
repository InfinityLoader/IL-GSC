/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _player_boost_jump_anims.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 40 ms
 * Timestamp: 4/22/2024 2:22:07 AM
*******************************************************************/

//Function Number: 1
main()
{
	player_animations();
}

//Function Number: 2
player_animations()
{
	level.scr_animtree["player_rig"] = #animtree;
	level.scr_model["player_rig"] = "viewhands_player_delta";
	level.scr_anim["player_rig"]["boost_land"] = %vm_rocket_jump_airbrake;
}