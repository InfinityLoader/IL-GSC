/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\traverse\step_up_24.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 46 ms
 * Timestamp: 10/27/2023 1:54:05 AM
*******************************************************************/

//Function Number: 1
main()
{
	if(self.type == "dog")
	{
		animscripts\traverse\shared::dog_jump_up(24,5);
		return;
	}

	human_traverse();
}

//Function Number: 2
human_traverse()
{
	var_00 = [];
	var_00["traverseAnim"] = %sw_traversal_suspension_on;
	var_00["traverseHeight"] = 24;
	animscripts\traverse\shared::dotraverse(var_00);
}