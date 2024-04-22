/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character_civilian_africa_male_b.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 36 ms
 * Timestamp: 4/22/2024 2:01:46 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("body_africa_civ_male_b");
	codescripts\character::attachhead("alias_africa_civilian_male_heads",xmodelalias\alias_africa_civilian_male_heads::main());
	self.voice = "african";
	self setclothtype("vestlight");
}

//Function Number: 2
precache()
{
	precachemodel("body_africa_civ_male_b");
	codescripts\character::precachemodelarray(xmodelalias\alias_africa_civilian_male_heads::main());
}