/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\traverse\jumpdown_40.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 45 ms
 * Timestamp: 10/27/2023 1:53:48 AM
*******************************************************************/

//Function Number: 1
main()
{
	if(self.type == "dog")
	{
		animscripts\traverse\shared::dog_jump_down(3,1);
		return;
	}

	low_wall_human();
}

//Function Number: 2
low_wall_human()
{
	var_00 = [];
	var_00["traverseAnim"] = %traverse_jumpdown_40;
	var_00["traverseHeight"] = 0;
	animscripts\traverse\shared::dotraverse(var_00);
}