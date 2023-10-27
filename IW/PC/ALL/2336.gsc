/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 2336.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 0 ms
 * Timestamp: 10/27/2023 12:23:18 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("seeker_grenade_wm");
	self.var_1FEC = "seeker";
	self.var_1FA8 = "seeker";
	self.var_13525 = "unitednations";
	self method_82C6("none");
	if(issentient(self))
	{
		self method_8492("locdmgtable/ai_lochit_dmgtable");
	}

	self method_83D0(#animtree);
}

//Function Number: 2
precache()
{
	precachemodel("seeker_grenade_wm");
}