/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character_civ_cau_fem_drs_sml.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 32 ms
 * Timestamp: 4/22/2024 2:01:25 AM
*******************************************************************/

//Function Number: 1
main()
{
	codescripts\character::setmodelfromarray(xmodelalias\alias_civ_cau_fem_bod_drs_sml::main());
	codescripts\character::attachhead("alias_civ_cau_fem_heads_sml",xmodelalias\alias_civ_cau_fem_heads_sml::main());
	self.voice = "american";
	self setclothtype("vestlight");
}

//Function Number: 2
precache()
{
	codescripts\character::precachemodelarray(xmodelalias\alias_civ_cau_fem_bod_drs_sml::main());
	codescripts\character::precachemodelarray(xmodelalias\alias_civ_cau_fem_heads_sml::main());
}