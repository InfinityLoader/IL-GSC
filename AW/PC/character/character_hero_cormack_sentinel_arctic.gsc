/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character_hero_cormack_sentinel_arctic.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 43 ms
 * Timestamp: 4/22/2024 2:02:02 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("body_hero_cormack_sentinel_halo");
	self attach("head_hero_cormack_sentinel_halo","",1);
	self.headmodel = "head_hero_cormack_sentinel_halo";
	self.voice = "xslice";
	self setclothtype("vestlight");
}

//Function Number: 2
precache()
{
	precachemodel("body_hero_cormack_sentinel_halo");
	precachemodel("head_hero_cormack_sentinel_halo");
}