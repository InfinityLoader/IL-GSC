/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\traverse\rocket_jump_160_airbrake_512.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 32 ms
 * Timestamp: 10/27/2023 1:53:55 AM
*******************************************************************/

//Function Number: 1
main()
{
	if(self.canjumppath)
	{
		animscripts\traverse\boost::rocket_jump_human(%g_rocket_jump_160_airbrake_512);
	}
}