/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\traverse\wall_hop.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 2
 * Decompile Time: 43 ms
 * Timestamp: 10/27/2023 1:35:56 AM
*******************************************************************/

//Function Number: 1
func_4FDD()
{
	if(self.type == "dog")
	{
		animscripts/traverse/shared::func_2933("wallhop",40);
		return;
	}

	func_8BF5();
}

//Function Number: 2
func_8BF5()
{
	if(randomint(100) < 30)
	{
		%traverse_wallhop_3;
	}

	%;
}