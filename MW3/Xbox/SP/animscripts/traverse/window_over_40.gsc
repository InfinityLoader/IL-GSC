/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\traverse\window_over_40.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 2
 * Decompile Time: 45 ms
 * Timestamp: 10/27/2023 2:29:39 AM
*******************************************************************/

//Function Number: 1
main()
{
	if(self.type == "dog")
	{
		animscripts/traverse/shared::func_3AFB("window_40",40);
		return;
	}

	jump_through_window_human();
}

//Function Number: 2
jump_through_window_human()
{
	var_00 = [];
	var_29["interruptDeathAnim"] = 0;
	var_29["interruptDeathAnim"] = 1;
	animscripts/traverse/shared::func_3AEF(var_29);
}