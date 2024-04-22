/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character_civ_s1_male_dead_b.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 46 ms
 * Timestamp: 4/22/2024 2:01:39 AM
*******************************************************************/

//Function Number: 1
main()
{
	codescripts\character::setmodelfromarray(xmodelalias\alias_civ_urban_dead_body_b::main());
	codescripts\character::attachhead("alias_civ_urban_male_heads_afr_light",xmodelalias\alias_civ_urban_male_heads_afr_light::main());
	self.voice = "american";
	self setclothtype("vestlight");
}

//Function Number: 2
precache()
{
	codescripts\character::precachemodelarray(xmodelalias\alias_civ_urban_dead_body_b::main());
	codescripts\character::precachemodelarray(xmodelalias\alias_civ_urban_male_heads_afr_light::main());
}