/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\traverse\boost_jump_128_across.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 32 ms
 * Timestamp: 10/27/2023 1:53:08 AM
*******************************************************************/

//Function Number: 1
main()
{
	if(self.canjumppath)
	{
		animscripts\traverse\boost::rocket_jump_human(%boost_jump_128_across_variation,1);
	}
}