/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: traverse\dog_jump_up_24.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 53 ms
 * Timestamp: 4/22/2024 1:59:14 AM
*******************************************************************/

//Function Number: 1
main()
{
	if(self.type == "dog")
	{
		animscripts\traverse\shared::dog_jump_up(24,5,"jump_up_24",1);
		return;
	}

	low_wall_human();
}

//Function Number: 2
low_wall_human()
{
	var_00 = [];
	var_00["traverseAnim"] = %ch_pragueb_7_5_crosscourt_aimantle_a;
	var_00["traverseHeight"] = 32;
	animscripts\traverse\shared::dotraverse(var_00);
}