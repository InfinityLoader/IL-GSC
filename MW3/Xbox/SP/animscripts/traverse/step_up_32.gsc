/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\traverse\step_up_32.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 2
 * Decompile Time: 44 ms
 * Timestamp: 10/27/2023 2:29:34 AM
*******************************************************************/

//Function Number: 1
main()
{
	if(self.type == "dog")
	{
		animscripts/traverse/shared::func_3AFD(32,5);
		return;
	}

	low_wall_human();
}

//Function Number: 2
low_wall_human()
{
	var_00 = [];
	animscripts/traverse/shared::func_3AEF(var_41);
}