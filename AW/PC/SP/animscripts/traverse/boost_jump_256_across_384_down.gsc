/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\traverse\boost_jump_256_across_384_down.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 31 ms
 * Timestamp: 10/27/2023 1:53:21 AM
*******************************************************************/

//Function Number: 1
main()
{
	if(self.canjumppath)
	{
		animscripts\traverse\boost::rocket_jump_human(%boost_jump_256_across_384_down_variation,1);
	}
}