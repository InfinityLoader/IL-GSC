/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: traverse\stepup_38.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 40 ms
 * Timestamp: 4/22/2024 1:59:42 AM
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
	var_00["traverseAnim"] = %traverse_stepup_52;
	var_00["traverseHeight"] = 38;
	var_00["traverseSound"] = "npc_step_up_38";
	animscripts\traverse\shared::dotraverse(var_00);
}