/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\traverse\stepup_52.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 47 ms
 * Timestamp: 10/27/2023 1:54:07 AM
*******************************************************************/

//Function Number: 1
main()
{
	if(self.type == "dog")
	{
		animscripts\traverse\shared::dog_jump_up(52,5);
		return;
	}

	low_wall_human();
}

//Function Number: 2
low_wall_human()
{
	var_00 = [];
	var_00["traverseAnim"] = %traverse_stepup_52;
	var_00["traverseHeight"] = 52;
	animscripts\traverse\shared::dotraverse(var_00);
}