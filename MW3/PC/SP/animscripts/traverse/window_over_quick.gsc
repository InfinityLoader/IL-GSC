/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\traverse\window_over_quick.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 48 ms
 * Timestamp: 10/27/2023 2:17:34 AM
*******************************************************************/

//Function Number: 1
main()
{
	if(self.type == "dog")
	{
		animscripts/traverse/shared::func_3FF7("window_40",40);
		return;
	}

	func_3FFE();
}

//Function Number: 2
func_3FFE()
{
	var_00 = [];
	var_1C["interruptDeathAnim"] = 0;
	var_1C["interruptDeathAnim"] = 1;
	animscripts/traverse/shared::func_3FEB(var_1C);
}