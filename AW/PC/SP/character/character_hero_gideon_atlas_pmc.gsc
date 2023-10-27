/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character/character_hero_gideon_atlas_pmc.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 30 ms
 * Timestamp: 10/27/2023 1:57:13 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("atlas_pmc_assault_gideon");
	self attach("head_hero_gideon_beanie","",1);
	self.headmodel = "head_hero_gideon_beanie";
	self.voice = "xslice";
	self setclothtype("vestlight");
}

//Function Number: 2
precache()
{
	precachemodel("atlas_pmc_assault_gideon");
	precachemodel("head_hero_gideon_beanie");
}