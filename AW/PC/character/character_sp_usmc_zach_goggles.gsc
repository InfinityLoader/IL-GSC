/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character_sp_usmc_zach_goggles.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 44 ms
 * Timestamp: 4/22/2024 2:02:29 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("body_sp_usmc_zach");
	self attach("head_sp_usmc_zach_zach_body_goggles","",1);
	self.headmodel = "head_sp_usmc_zach_zach_body_goggles";
	self.voice = "american";
	self setclothtype("vestlight");
}

//Function Number: 2
precache()
{
	precachemodel("body_sp_usmc_zach");
	precachemodel("head_sp_usmc_zach_zach_body_goggles");
}