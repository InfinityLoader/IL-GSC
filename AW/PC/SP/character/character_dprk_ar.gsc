/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character/character_dprk_ar.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 28 ms
 * Timestamp: 10/27/2023 1:57:10 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("nk_army_assault_body");
	self attach("nk_army_a_head","",1);
	self.headmodel = "nk_army_a_head";
	self.voice = "northkorea";
	self setclothtype("vestlight");
}

//Function Number: 2
precache()
{
	precachemodel("nk_army_assault_body");
	precachemodel("nk_army_a_head");
}