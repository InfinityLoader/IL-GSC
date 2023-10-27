/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\traverse\wall_hop.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 46 ms
 * Timestamp: 10/27/2023 2:17:30 AM
*******************************************************************/

//Function Number: 1
main()
{
	if(self.type == "dog")
	{
		animscripts/traverse/shared::func_3FF7("wallhop",40);
		return;
	}

	func_3FFC();
}

//Function Number: 2
func_3FFC()
{
	if(randomint(100) < 30)
	{
		animscripts/traverse/shared::func_3FE6(%traverse_wallhop_3,39.875);
		return;
	}

	animscripts/traverse/shared::func_3FE6(%traverse_wallhop,39.875);
}