/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\traverse\rocket_jump_run_med_down.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 29 ms
 * Timestamp: 10/27/2023 1:53:57 AM
*******************************************************************/

//Function Number: 1
main()
{
	if(self.canjumppath)
	{
		animscripts\traverse\boost::rocket_jump_human(%g_rocket_jump_run_med_down);
	}
}