/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\traverse\jumpdown_96.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 48 ms
 * Timestamp: 10/27/2023 1:23:01 AM
*******************************************************************/

//Function Number: 1
func_4FDD()
{
	if(self.type == "dog")
	{
		animscripts/traverse/shared::dog_jump_down(7,0.8);
		return;
	}

	func_4F99();
}

//Function Number: 2
func_4F99()
{
	var_00 = [];
	var_00["traverseAnim"] = %traverse_jumpdown_96;
	animscripts/traverse/shared::func_2A1F(var_00);
}