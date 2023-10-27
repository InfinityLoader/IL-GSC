/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\traverse\hjk_tree_hop.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 2
 * Decompile Time: 47 ms
 * Timestamp: 10/27/2023 1:34:31 AM
*******************************************************************/

//Function Number: 1
func_4FDD()
{
	if(self.type == "dog")
	{
		animscripts/traverse/shared::func_2933("wallhop",40);
		return;
	}

	func_82EF();
}

//Function Number: 2
func_82EF()
{
	if(isdefined(self.type) && self.type == "civilian")
	{
		%so_hijack_civ_log_jump;
	}

	%;
}