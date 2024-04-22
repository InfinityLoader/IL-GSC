/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character_hero_cormack_captured.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 39 ms
 * Timestamp: 4/22/2024 2:01:59 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("sentinel_pilot_body_captured");
	self attach("head_hero_cormack_blend","",1);
	self.headmodel = "head_hero_cormack_blend";
	self.voice = "xslice";
	self setclothtype("vestlight");
}

//Function Number: 2
precache()
{
	precachemodel("sentinel_pilot_body_captured");
	precachemodel("head_hero_cormack_blend");
}