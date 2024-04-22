/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: traverse\rocket_jump_run_short_down.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 27 ms
 * Timestamp: 4/22/2024 1:59:35 AM
*******************************************************************/

//Function Number: 1
main()
{
	if(self.canjumppath)
	{
		animscripts\traverse\boost::rocket_jump_human(%g_rocket_jump_run_short_down);
	}
}