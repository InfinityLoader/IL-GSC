/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character/character_hero_cormack_marine.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 29 ms
 * Timestamp: 10/27/2023 1:57:12 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("body_hero_cormack_marine");
	self attach("head_hero_cormack_marines","",1);
	self.headmodel = "head_hero_cormack_marines";
	self.voice = "xslice";
	self setclothtype("vestlight");
}

//Function Number: 2
precache()
{
	precachemodel("body_hero_cormack_marine");
	precachemodel("head_hero_cormack_marines");
}