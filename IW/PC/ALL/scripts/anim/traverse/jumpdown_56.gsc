/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\anim\traverse\jumpdown_56.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 134 ms
 * Timestamp: 10/26/2023 11:59:31 PM
*******************************************************************/

//Function Number: 1
main()
{
	if(self.type == "dog")
	{
		scripts\anim\traverse\shared::func_5867(5,1);
		return;
	}

	if(self.var_12BA4 == "seeker")
	{
		scripts\anim\traverse\shared::func_F163();
		return;
	}

	func_B0CC();
}

//Function Number: 2
func_B0CC()
{
	var_00 = [];
	var_00["traverseAnim"] = %traverse_jumpdown_56;
	scripts\anim\traverse\shared::func_5AC3(var_00);
}