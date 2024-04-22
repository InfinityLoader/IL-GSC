/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: traverse\mantle_over_low_cover_40.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 40 ms
 * Timestamp: 4/22/2024 1:59:31 AM
*******************************************************************/

//Function Number: 1
main()
{
	if(self.type == "dog")
	{
		animscripts\traverse\shared::dog_wall_and_window_hop("window_40",40);
		return;
	}

	mantle_over_low_wall_40_human();
}

//Function Number: 2
mantle_over_low_wall_40_human()
{
	var_00 = [];
	var_00["traverseAnim"] = common_scripts\utility::random([%traverse_mantle_over_low_cover_40_var1,%traverse_mantle_over_low_cover_40_var2]);
	var_00["traverseHeight"] = 0;
	animscripts\traverse\shared::dotraverse(var_00);
}