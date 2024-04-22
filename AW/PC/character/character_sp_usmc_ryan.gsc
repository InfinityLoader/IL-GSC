/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character_sp_usmc_ryan.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 49 ms
 * Timestamp: 4/22/2024 2:02:28 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("body_sp_usmc_ryan");
	self attach("head_sp_usmc_ryan_ryan_body","",1);
	self.headmodel = "head_sp_usmc_ryan_ryan_body";
	self.voice = "american";
	self setclothtype("vestlight");
}

//Function Number: 2
precache()
{
	precachemodel("body_sp_usmc_ryan");
	precachemodel("head_sp_usmc_ryan_ryan_body");
}