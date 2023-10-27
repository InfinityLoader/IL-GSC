/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\traverse\ladder_down.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 28 ms
 * Timestamp: 10/27/2023 2:43:04 AM
*******************************************************************/

//Function Number: 1
main()
{
	if(isdefined(self.type) && self.type == "dog")
	{
		return;
	}

	animscripts\traverse\shared::dovariablelengthtraverse(%ladder_climbon,%ladder_climbdown,undefined,"noclip","stand","stop");
}