/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\traverse\wall_over_40.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 47 ms
 * Timestamp: 10/27/2023 2:17:31 AM
*******************************************************************/

//Function Number: 1
main()
{
	if(self.type == "dog")
	{
		animscripts/traverse/shared::func_3FF7("window_40",40);
		return;
	}

	func_4003();
}

//Function Number: 2
func_4003()
{
	var_00 = [];
	var_1C["interruptDeathAnim"] = 0;
	var_1C["interruptDeathAnim"] = 1;
	animscripts/traverse/shared::func_3FEB(var_1C);
}