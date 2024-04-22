/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character_hero_gideon_atlas_arctic.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 43 ms
 * Timestamp: 4/22/2024 2:02:03 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("atlas_arctic_body");
	self attach("head_hero_gideon_beanie","",1);
	self.headmodel = "head_hero_gideon_beanie";
	self.voice = "atlas";
	self setclothtype("vestlight");
}

//Function Number: 2
precache()
{
	precachemodel("atlas_arctic_body");
	precachemodel("head_hero_gideon_beanie");
}