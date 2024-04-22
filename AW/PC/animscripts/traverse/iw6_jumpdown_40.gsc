/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: traverse\iw6_jumpdown_40.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 51 ms
 * Timestamp: 4/22/2024 1:59:22 AM
*******************************************************************/

//Function Number: 1
main()
{
	if(self.type == "dog")
	{
		animscripts\traverse\shared::dog_jump_down(7,0.7);
		return;
	}

	human_traverse();
}

//Function Number: 2
human_traverse()
{
	var_00 = [];
	var_00["traverseAnim"] = %traverse_jumpdown_40_iw6;
	animscripts\traverse\shared::dotraverse(var_00);
}