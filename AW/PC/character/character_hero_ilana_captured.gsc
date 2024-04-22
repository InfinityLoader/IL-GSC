/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character_hero_ilana_captured.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 38 ms
 * Timestamp: 4/22/2024 2:02:07 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("body_ilana_sentinel_pilot_captured");
	self attach("head_hero_ilana_blend","",1);
	self.headmodel = "head_hero_ilana_blend";
	self.voice = "xslice";
	self setclothtype("vestlight");
}

//Function Number: 2
precache()
{
	precachemodel("body_ilana_sentinel_pilot_captured");
	precachemodel("head_hero_ilana_blend");
}