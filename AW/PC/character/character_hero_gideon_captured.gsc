/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character_hero_gideon_captured.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 40 ms
 * Timestamp: 4/22/2024 2:02:05 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("sentinel_pilot_body_captured");
	self attach("head_hero_gideon_blend","",1);
	self.headmodel = "head_hero_gideon_blend";
	self.voice = "xslice";
	self setclothtype("vestlight");
}

//Function Number: 2
precache()
{
	precachemodel("sentinel_pilot_body_captured");
	precachemodel("head_hero_gideon_blend");
}