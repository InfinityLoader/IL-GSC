/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character_civ_afr_light_male_dress.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 31 ms
 * Timestamp: 4/22/2024 2:01:23 AM
*******************************************************************/

//Function Number: 1
main()
{
	codescripts\character::setmodelfromarray(xmodelalias\alias_civ_afr_light_male_bodies_dress::main());
	codescripts\character::attachhead("alias_civ_afr_light_male_heads",xmodelalias\alias_civ_afr_light_male_heads::main());
	self.voice = "african";
	self setclothtype("vestlight");
}

//Function Number: 2
precache()
{
	codescripts\character::precachemodelarray(xmodelalias\alias_civ_afr_light_male_bodies_dress::main());
	codescripts\character::precachemodelarray(xmodelalias\alias_civ_afr_light_male_heads::main());
}