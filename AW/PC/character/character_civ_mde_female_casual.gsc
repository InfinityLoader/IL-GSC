/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character_civ_mde_female_casual.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 33 ms
 * Timestamp: 4/22/2024 2:01:28 AM
*******************************************************************/

//Function Number: 1
main()
{
	codescripts\character::setmodelfromarray(xmodelalias\alias_civ_mde_female_bodies_cas::main());
	codescripts\character::attachhead("alias_civ_mde_female_heads",xmodelalias\alias_civ_mde_female_heads::main());
	self.voice = "arab";
	self setclothtype("vestlight");
}

//Function Number: 2
precache()
{
	codescripts\character::precachemodelarray(xmodelalias\alias_civ_mde_female_bodies_cas::main());
	codescripts\character::precachemodelarray(xmodelalias\alias_civ_mde_female_heads::main());
}