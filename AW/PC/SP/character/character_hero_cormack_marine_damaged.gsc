/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character/character_hero_cormack_marine_damaged.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 29 ms
 * Timestamp: 10/27/2023 1:57:12 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("body_hero_cormack_marine_damage");
	self attach("head_hero_cormack_marines_damage","",1);
	self.headmodel = "head_hero_cormack_marines_damage";
	self.voice = "xslice";
	self setclothtype("vestlight");
}

//Function Number: 2
precache()
{
	precachemodel("body_hero_cormack_marine_damage");
	precachemodel("head_hero_cormack_marines_damage");
}