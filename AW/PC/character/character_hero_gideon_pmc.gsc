/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character_hero_gideon_pmc.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 44 ms
 * Timestamp: 4/22/2024 2:02:05 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("atlas_pmc_body");
	self attach("head_hero_gideon_beanie","",1);
	self.headmodel = "head_hero_gideon_beanie";
	self.voice = "xslice";
	self setclothtype("vestlight");
}

//Function Number: 2
precache()
{
	precachemodel("atlas_pmc_body");
	precachemodel("head_hero_gideon_beanie");
}