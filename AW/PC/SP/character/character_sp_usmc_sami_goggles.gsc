/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character/character_sp_usmc_sami_goggles.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 30 ms
 * Timestamp: 10/27/2023 1:57:18 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("body_sp_usmc_james");
	self attach("head_sp_usmc_sami_goggles_zach_body","",1);
	self.headmodel = "head_sp_usmc_sami_goggles_zach_body";
	self.voice = "american";
	self setclothtype("vestlight");
}

//Function Number: 2
precache()
{
	precachemodel("body_sp_usmc_james");
	precachemodel("head_sp_usmc_sami_goggles_zach_body");
}