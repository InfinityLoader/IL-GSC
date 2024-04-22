/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: traverse\ladder_down.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 28 ms
 * Timestamp: 4/22/2024 1:59:29 AM
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