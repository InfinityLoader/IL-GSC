/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character_civilian_prisoner_female_b.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 46 ms
 * Timestamp: 4/22/2024 2:01:50 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("civ_prisoner_atlas_body_b");
	codescripts\character::attachhead("alias_civilian_heads_prisoner_female",xmodelalias\alias_civilian_heads_prisoner_female::main());
	self.voice = "american";
	self setclothtype("vestlight");
}

//Function Number: 2
precache()
{
	precachemodel("civ_prisoner_atlas_body_b");
	codescripts\character::precachemodelarray(xmodelalias\alias_civilian_heads_prisoner_female::main());
}