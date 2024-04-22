/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: greece_starts.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 26 ms
 * Timestamp: 4/22/2024 2:31:35 AM
*******************************************************************/

//Function Number: 1
add_greece_starts(param_00)
{
	switch(param_00)
	{
		case "safehouse":
			maps\_utility::describe_start("start_safehouse_intro");
			maps\_utility::describe_start("start_safehouse_follow");
			maps\_utility::describe_start("start_safehouse_xslice");
			maps\_utility::describe_start("start_safehouse_clear");
			maps\_utility::describe_start("start_safehouse_transition");
			break;

		case "conference_center":
			maps\_utility::describe_start("start_conf_center_intro");
			maps\_utility::describe_start("start_conf_center_support1");
			maps\_utility::describe_start("start_conf_center_support2");
			maps\_utility::describe_start("start_conf_center_support3");
			maps\_utility::describe_start("start_conf_center_kill");
			maps\_utility::describe_start("start_conf_center_combat");
			maps\_utility::describe_start("start_conf_center_outro");
			break;

		case "safehouse_final":
			maps\_utility::describe_start("start_safehouse_exit");
			break;

		case "alley":
			maps\_utility::describe_start("start_alleys_transition");
			maps\_utility::describe_start("start_alleys");
			maps\_utility::describe_start("start_alleys_art");
			maps\_utility::describe_start("start_alleys_end");
			break;

		case "sniper_scramble":
			maps\_utility::describe_start("start_sniper_scramble_intro");
			maps\_utility::describe_start("start_sniper_scramble_hotel");
			maps\_utility::describe_start("start_sniper_scramble_drones");
			maps\_utility::describe_start("start_sniper_scramble_finale");
			break;

		case "ending":
			maps\_utility::describe_start("start_ending_ambush");
			maps\_utility::describe_start("start_ending_fight");
			maps\_utility::describe_start("start_ending_hades");
			break;
	}
}