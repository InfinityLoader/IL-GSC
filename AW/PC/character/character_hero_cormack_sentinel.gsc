/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character_hero_cormack_sentinel.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 41 ms
 * Timestamp: 4/22/2024 2:02:02 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("body_hero_cormack_sentinel");
	self attach("head_hero_cormack_helmet","",1);
	self.headmodel = "head_hero_cormack_helmet";
	self.voice = "xslice";
	self setclothtype("vestlight");
}

//Function Number: 2
precache()
{
	precachemodel("body_hero_cormack_sentinel");
	precachemodel("head_hero_cormack_helmet");
}