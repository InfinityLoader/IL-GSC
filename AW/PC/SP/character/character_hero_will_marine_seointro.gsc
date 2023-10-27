/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character/character_hero_will_marine_seointro.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 39 ms
 * Timestamp: 10/27/2023 1:57:14 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("body_hero_will_marine_drop_pod");
	self attach("head_hero_will_marines","",1);
	self.headmodel = "head_hero_will_marines";
	self.voice = "xslice";
	self setclothtype("vestlight");
}

//Function Number: 2
precache()
{
	precachemodel("body_hero_will_marine_drop_pod");
	precachemodel("head_hero_will_marines");
}