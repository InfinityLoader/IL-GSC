/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: traverse\wall_hop.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 40 ms
 * Timestamp: 4/22/2024 1:59:44 AM
*******************************************************************/

//Function Number: 1
main()
{
	if(self.type == "dog")
	{
		animscripts\traverse\shared::dog_wall_and_window_hop("wallhop",40);
		return;
	}

	wall_hop_human();
}

//Function Number: 2
wall_hop_human()
{
	var_00 = [];
	var_00["traverseAnim"] = %traverse_window_quick;
	var_00["traverseHeight"] = 40;
	if(randomint(100) < 30)
	{
		var_00["traverseAnim"] = %traverse_wallhop_3;
	}
	else
	{
		var_00["traverseAnim"] = %traverse_wallhop;
	}

	animscripts\traverse\shared::dotraverse(var_00);
}