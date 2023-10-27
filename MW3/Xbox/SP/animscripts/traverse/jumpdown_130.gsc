/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\traverse\jumpdown_130.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 2
 * Decompile Time: 71 ms
 * Timestamp: 10/27/2023 2:29:29 AM
*******************************************************************/

//Function Number: 1
main()
{
	if(self.type == "dog")
	{
		animscripts/traverse/shared::func_3AFC(7,0.7);
		return;
	}

	func_3B0D();
}

//Function Number: 2
func_3B0D()
{
	var_00 = [];
	animscripts/traverse/shared::func_3AEF(var_41);
}