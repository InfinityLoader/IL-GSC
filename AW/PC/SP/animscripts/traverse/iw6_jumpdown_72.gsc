/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\traverse\iw6_jumpdown_72.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 61 ms
 * Timestamp: 10/27/2023 1:53:42 AM
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
	var_00["traverseAnim"] = %traverse_jumpdown_72_iw6;
	animscripts\traverse\shared::dotraverse(var_00);
}