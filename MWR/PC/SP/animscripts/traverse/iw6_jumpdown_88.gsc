/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\traverse\iw6_jumpdown_88.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 58 ms
 * Timestamp: 10/27/2023 2:42:54 AM
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
	var_00["traverseAnim"] = %traverse_jumpdown_88_iw6;
	animscripts\traverse\shared::dotraverse(var_00);
}