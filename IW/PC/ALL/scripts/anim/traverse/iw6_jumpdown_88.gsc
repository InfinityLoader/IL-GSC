/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\anim\traverse\iw6_jumpdown_88.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 141 ms
 * Timestamp: 10/26/2023 11:59:27 PM
*******************************************************************/

//Function Number: 1
main()
{
	if(self.type == "dog")
	{
		scripts\anim\traverse\shared::func_5867(7,0.7);
		return;
	}

	func_91D4();
}

//Function Number: 2
func_91D4()
{
	var_00 = [];
	var_00["traverseAnim"] = func_7814();
	if(getdvarint("ai_iw7",0) == 0)
	{
		scripts\anim\traverse\shared::func_5AC3(var_00);
		return;
	}

	self waittill("killanimscript");
}

//Function Number: 3
func_7814()
{
	return %traverse_jumpdown_88_iw6;
}