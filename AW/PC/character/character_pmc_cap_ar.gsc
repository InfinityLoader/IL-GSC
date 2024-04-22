/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character_pmc_cap_ar.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 41 ms
 * Timestamp: 4/22/2024 2:02:21 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("atlas_pmc_body");
	self attach("pmc_casual_head_c","",1);
	self.headmodel = "pmc_casual_head_c";
	self.voice = "atlas";
	self setclothtype("vestlight");
}

//Function Number: 2
precache()
{
	precachemodel("atlas_pmc_body");
	precachemodel("pmc_casual_head_c");
}