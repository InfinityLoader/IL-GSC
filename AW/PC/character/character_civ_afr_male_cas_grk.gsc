/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character_civ_afr_male_cas_grk.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 33 ms
 * Timestamp: 4/22/2024 2:01:23 AM
*******************************************************************/

//Function Number: 1
main()
{
	codescripts\character::setmodelfromarray(xmodelalias\alias_civ_afr_dark_male_bodies_casual::main());
	codescripts\character::attachhead("alias_greece_civilian_heads_males_b",xmodelalias\alias_greece_civilian_heads_males_b::main());
	self.voice = "african";
	self setclothtype("vestlight");
}

//Function Number: 2
precache()
{
	codescripts\character::precachemodelarray(xmodelalias\alias_civ_afr_dark_male_bodies_casual::main());
	codescripts\character::precachemodelarray(xmodelalias\alias_greece_civilian_heads_males_b::main());
}