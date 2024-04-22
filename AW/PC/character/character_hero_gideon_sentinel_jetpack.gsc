/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character_hero_gideon_sentinel_jetpack.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 52 ms
 * Timestamp: 4/22/2024 2:02:06 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("burke_sentinel_body");
	self attach("head_hero_gideon_beanie","",1);
	self.headmodel = "head_hero_gideon_beanie";
	self.voice = "xslice";
	self setclothtype("vestlight");
}

//Function Number: 2
precache()
{
	precachemodel("burke_sentinel_body");
	precachemodel("head_hero_gideon_beanie");
}