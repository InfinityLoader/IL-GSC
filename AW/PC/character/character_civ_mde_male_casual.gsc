/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character_civ_mde_male_casual.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 33 ms
 * Timestamp: 4/22/2024 2:01:29 AM
*******************************************************************/

//Function Number: 1
main()
{
	codescripts\character::setmodelfromarray(xmodelalias\alias_civ_mde_male_bodies_casual::main());
	codescripts\character::attachhead("alias_civ_mde_male_heads",xmodelalias\alias_civ_mde_male_heads::main());
	self.voice = "arab";
	self setclothtype("vestlight");
}

//Function Number: 2
precache()
{
	codescripts\character::precachemodelarray(xmodelalias\alias_civ_mde_male_bodies_casual::main());
	codescripts\character::precachemodelarray(xmodelalias\alias_civ_mde_male_heads::main());
}