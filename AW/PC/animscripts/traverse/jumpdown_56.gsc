/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: traverse\jumpdown_56.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 54 ms
 * Timestamp: 4/22/2024 1:59:28 AM
*******************************************************************/

//Function Number: 1
main()
{
	if(self.type == "dog")
	{
		animscripts\traverse\shared::dog_jump_down(5,1);
		return;
	}

	low_wall_human();
}

//Function Number: 2
low_wall_human()
{
	var_00 = [];
	var_00["traverseAnim"] = %traverse_jumpdown_56;
	animscripts\traverse\shared::dotraverse(var_00);
}