/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character_hero_knox_sentinel_cloak.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 40 ms
 * Timestamp: 4/22/2024 2:02:10 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("sentinel_covert_body_a");
	self attach("head_hero_knox_sentinel_covert_blend","",1);
	self.headmodel = "head_hero_knox_sentinel_covert_blend";
	self.voice = "xslice";
	self setclothtype("vestlight");
}

//Function Number: 2
precache()
{
	precachemodel("sentinel_covert_body_a");
	precachemodel("head_hero_knox_sentinel_covert_blend");
}