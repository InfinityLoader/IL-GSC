/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: traverse\berlin_column_jump.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 31 ms
 * Timestamp: 4/22/2024 1:58:56 AM
*******************************************************************/

//Function Number: 1
main()
{
	if(self.type == "dog")
	{
		animscripts\traverse\shared::dog_jump_up(38,5);
		return;
	}

	low_wall_human();
}

//Function Number: 2
low_wall_human()
{
	var_00 = [];
	var_00["traverseAnim"] = %berlin_jumping_column_sandman;
	var_00["traverseHeight"] = 38;
	animscripts\traverse\shared::dotraverse(var_00);
}