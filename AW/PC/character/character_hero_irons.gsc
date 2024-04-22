/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character_hero_irons.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 40 ms
 * Timestamp: 4/22/2024 2:02:09 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("irons_suit");
	self attach("head_hero_irons_blend","",1);
	self.headmodel = "head_hero_irons_blend";
	self.voice = "xslice";
	self setclothtype("vestlight");
}

//Function Number: 2
precache()
{
	precachemodel("irons_suit");
	precachemodel("head_hero_irons_blend");
}