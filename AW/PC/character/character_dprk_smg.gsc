/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character_dprk_smg.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 43 ms
 * Timestamp: 4/22/2024 2:01:57 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("nk_army_smg_body");
	self attach("nk_army_c_head","",1);
	self.headmodel = "nk_army_c_head";
	self.voice = "northkorea";
	self setclothtype("vestlight");
}

//Function Number: 2
precache()
{
	precachemodel("nk_army_smg_body");
	precachemodel("nk_army_c_head");
}