/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character_civilian_slum_male_ab.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 41 ms
 * Timestamp: 4/22/2024 2:01:51 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("body_slum_civ_male_ab");
	codescripts\character::attachhead("alias_civilian_slum_heads",xmodelalias\alias_civilian_slum_heads::main());
	self.voice = "american";
	self setclothtype("vestlight");
}

//Function Number: 2
precache()
{
	precachemodel("body_slum_civ_male_ab");
	codescripts\character::precachemodelarray(xmodelalias\alias_civilian_slum_heads::main());
}