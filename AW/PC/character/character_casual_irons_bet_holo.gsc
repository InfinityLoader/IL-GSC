/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character_casual_irons_bet_holo.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 33 ms
 * Timestamp: 4/22/2024 2:01:20 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("irons_casual");
	self attach("head_hero_irons_holo_blend","",1);
	self.headmodel = "head_hero_irons_holo_blend";
	self.voice = "xslice";
	self setclothtype("vestlight");
}

//Function Number: 2
precache()
{
	precachemodel("irons_casual");
	precachemodel("head_hero_irons_holo_blend");
}