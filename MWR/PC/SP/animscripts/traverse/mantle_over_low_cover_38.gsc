/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\traverse\mantle_over_low_cover_38.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 46 ms
 * Timestamp: 10/27/2023 2:43:06 AM
*******************************************************************/

//Function Number: 1
main()
{
	if(self.type == "dog")
	{
		animscripts\traverse\shared::dog_wall_and_window_hop("window_38",38);
		return;
	}

	mantle_over_low_wall_38_human();
}

//Function Number: 2
mantle_over_low_wall_38_human()
{
	var_00 = [];
	var_00["traverseAnim"] = common_scripts\utility::random([%traverse_mantle_over_low_cover_38_var1,%traverse_mantle_over_low_cover_38_var2]);
	var_00["traverseHeight"] = 0;
	animscripts\traverse\shared::dotraverse(var_00);
}