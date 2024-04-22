/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character_hero_gideon_sentinel_cloak.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 40 ms
 * Timestamp: 4/22/2024 2:02:05 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("body_hero_burke_sentinel_covert");
	self attach("head_hero_gideon_sentinel_covert","",1);
	self.headmodel = "head_hero_gideon_sentinel_covert";
	self.voice = "xslice";
	self setclothtype("vestlight");
}

//Function Number: 2
precache()
{
	precachemodel("body_hero_burke_sentinel_covert");
	precachemodel("head_hero_gideon_sentinel_covert");
}