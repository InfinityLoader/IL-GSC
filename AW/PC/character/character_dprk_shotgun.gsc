/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character_dprk_shotgun.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 48 ms
 * Timestamp: 4/22/2024 2:01:57 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("nk_army_shotgun_body");
	self attach("nk_army_b_head","",1);
	self.headmodel = "nk_army_b_head";
	self.voice = "northkorea";
	self setclothtype("vestlight");
}

//Function Number: 2
precache()
{
	precachemodel("nk_army_shotgun_body");
	precachemodel("nk_army_b_head");
}