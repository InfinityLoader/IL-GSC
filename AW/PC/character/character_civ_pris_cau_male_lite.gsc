/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character_civ_pris_cau_male_lite.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 33 ms
 * Timestamp: 4/22/2024 2:01:29 AM
*******************************************************************/

//Function Number: 1
main()
{
	codescripts\character::setmodelfromarray(xmodelalias\alias_civ_pris_cau_male_bodies::main());
	codescripts\character::attachhead("alias_civ_cau_male_heads",xmodelalias\alias_civ_cau_male_heads::main());
	self.voice = "american";
	self setclothtype("vestlight");
}

//Function Number: 2
precache()
{
	codescripts\character::precachemodelarray(xmodelalias\alias_civ_pris_cau_male_bodies::main());
	codescripts\character::precachemodelarray(xmodelalias\alias_civ_cau_male_heads::main());
}