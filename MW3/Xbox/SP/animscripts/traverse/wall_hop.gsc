/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\traverse\wall_hop.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 2
 * Decompile Time: 46 ms
 * Timestamp: 10/27/2023 2:29:36 AM
*******************************************************************/

//Function Number: 1
main()
{
	if(self.type == "dog")
	{
		animscripts/traverse/shared::func_3AFB("wallhop",40);
		return;
	}

	func_3B00();
}

//Function Number: 2
func_3B00()
{
	if(randomint(100) < 30)
	{
		animscripts/traverse/shared::func_3AEA(%traverse_wallhop_3,39.875);
		return;
	}

	animscripts/traverse/shared::func_3AEA(%traverse_wallhop,39.875);
}