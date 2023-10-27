/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\zombies\shotgun\_zombies_shotgun_exp_events.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 8
 * Decompile Time: 172 ms
 * Timestamp: 10/27/2023 3:12:29 AM
*******************************************************************/

//Function Number: 1
completed_an_objective()
{
	lib_054D::giveplayersexp("dlc3_exp_ref_0");
}

//Function Number: 2
individual_escape_bonus(param_00)
{
	lib_054D::giveplayersexp("dlc3_exp_ref_1",param_00);
}

//Function Number: 3
group_escape_bonus()
{
	lib_054D::giveplayersexp("dlc3_exp_ref_2");
	if(!function_0371())
	{
		lib_054D::giveplayersexp("dlc3_exp_ref_2");
	}
}

//Function Number: 4
boss_defeated_bonus()
{
	lib_054D::giveplayersexp("dlc3_exp_ref_3");
}

//Function Number: 5
award_exp_small()
{
	lib_054D::giveplayersexp("shardroom");
}

//Function Number: 6
award_exp_smallish()
{
	lib_054D::giveplayersexp("truevoice");
}

//Function Number: 7
award_exp_med()
{
	lib_054D::giveplayersexp("escortclaw");
}

//Function Number: 8
award_exp_large()
{
	lib_054D::giveplayersexp("brutefinale");
}