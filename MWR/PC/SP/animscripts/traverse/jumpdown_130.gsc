/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\traverse\jumpdown_130.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 44 ms
 * Timestamp: 10/27/2023 2:43:00 AM
*******************************************************************/

//Function Number: 1
main()
{
	if(self.type == "dog")
	{
		animscripts\traverse\shared::dog_jump_down(7,0.7);
		return;
	}

	jumpdown_130_human();
}

//Function Number: 2
jumpdown_130_human()
{
	var_00 = [];
	var_00["traverseAnim"] = %traverse_jumpdown_130;
	animscripts\traverse\shared::dotraverse(var_00);
}