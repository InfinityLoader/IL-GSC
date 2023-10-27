/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\traverse\step_up_32.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 46 ms
 * Timestamp: 10/27/2023 2:17:28 AM
*******************************************************************/

//Function Number: 1
main()
{
	if(self.type == "dog")
	{
		animscripts/traverse/shared::func_3FF9(32,5);
		return;
	}

	func_4003();
}

//Function Number: 2
func_4003()
{
	var_00 = [];
	animscripts/traverse/shared::func_3FEB(var_7B);
}