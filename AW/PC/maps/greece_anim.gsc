/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: greece_anim.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 6
 * Decompile Time: 95 ms
 * Timestamp: 4/22/2024 2:30:23 AM
*******************************************************************/

//Function Number: 1
main()
{
	if(level.nextgen)
	{
		anim.forced_s1_motionset = 1;
	}

	player_setupanimations();
	burke_setupanimations();
	enemy_setupanimations();
	civilian_setupanimations();
	rope_setupanimation();
}

//Function Number: 2
player_setupanimations()
{
	level.scr_animtree["player_rig"] = #animtree;
	level.scr_model["player_rig"] = "viewhands_atlas_military";
	level.scr_anim["player_rig"]["knockdown"] = %player_view_dog_knockdown_saved;
}

//Function Number: 3
burke_setupanimations()
{
}

//Function Number: 4
enemy_setupanimations()
{
}

//Function Number: 5
civilian_setupanimations()
{
}

//Function Number: 6
rope_setupanimation()
{
}