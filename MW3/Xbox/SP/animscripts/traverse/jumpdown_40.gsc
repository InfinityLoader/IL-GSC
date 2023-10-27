/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\traverse\jumpdown_40.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 2
 * Decompile Time: 57 ms
 * Timestamp: 10/27/2023 2:29:30 AM
*******************************************************************/

//Function Number: 1
main()
{
	if(self.type == "dog")
	{
		animscripts/traverse/shared::func_3AFC(3,1);
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