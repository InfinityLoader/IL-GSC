/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character/character_sp_usmc_at4.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 39 ms
 * Timestamp: 10/27/2023 1:57:16 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("body_sp_usmc_at4");
	self attach("head_sp_usmc_james_james_body","",1);
	self.headmodel = "head_sp_usmc_james_james_body";
	self.voice = "american";
	self setclothtype("vestlight");
}

//Function Number: 2
precache()
{
	precachemodel("body_sp_usmc_at4");
	precachemodel("head_sp_usmc_james_james_body");
}