/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps/_patrol_anims_casualkiller.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 5
 * Decompile Time: 70 ms
 * Timestamp: 10/27/2023 2:00:01 AM
*******************************************************************/

//Function Number: 1
main()
{
	humans();
	dogs();
}

//Function Number: 2
humans()
{
	level.scr_anim["generic"]["_stealth_patrol_walk_casualkiller"] = %casual_killer_jog_b;
	level.scr_anim["generic"]["patrol_walk_casualkiller"] = %casual_killer_jog_b;
	level.scr_anim["generic"]["patrol_idle_casualkiller"][0] = %casual_stand_idle;
	level.scr_anim["generic"]["patrol_stop_casualkiller"] = %casual_killer_walk_stop;
	level.scr_anim["generic"]["patrol_start_casualkiller"] = %casual_killer_walk_start;
}

//Function Number: 3
dogs()
{
}

//Function Number: 4
enable_casualkiller()
{
	self.script_animation = "casualkiller";
	if(isdefined(self.script_patroller) && self.script_patroller)
	{
		maps\_patrol::set_patrol_run_anim_array();
	}
}

//Function Number: 5
init_casualkiller_archetype()
{
	if(isdefined(level.archetypes) && maps\_utility::archetype_exists("casualkiller"))
	{
		return;
	}

	var_00 = [];
	var_00["cover_trans_angles"]["casualkiller"][1] = 45;
	var_00["cover_trans_angles"]["casualkiller"][2] = 0;
	var_00["cover_trans_angles"]["casualkiller"][3] = -45;
	var_00["cover_trans_angles"]["casualkiller"][4] = 90;
	var_00["cover_trans_angles"]["casualkiller"][6] = -90;
	var_00["cover_trans_angles"]["casualkiller"][8] = 180;
	var_00["run"]["straight"] = %casual_killer_jog_b;
	var_00["run"]["move_f"] = %casual_killer_jog_b;
	var_00["run"]["straight_twitch"] = [%casual_killer_walk_f_weapon_swap,%casual_killer_walk_wave,%casual_killer_walk_point];
	maps\_utility::register_archetype("casualkiller",var_00);
}