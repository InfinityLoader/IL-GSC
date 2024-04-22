/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character_civ_afr_light_fem_drs_sml.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 37 ms
 * Timestamp: 4/22/2024 2:01:22 AM
*******************************************************************/

//Function Number: 1
main()
{
	codescripts\character::setmodelfromarray(xmodelalias\alias_civ_afr_lgt_fem_bod_drs_sml::main());
	codescripts\character::attachhead("alias_civ_afr_lgt_female_heads",xmodelalias\alias_civ_afr_lgt_female_heads::main());
	self.voice = "american";
	self setclothtype("vestlight");
}

//Function Number: 2
precache()
{
	codescripts\character::precachemodelarray(xmodelalias\alias_civ_afr_lgt_fem_bod_drs_sml::main());
	codescripts\character::precachemodelarray(xmodelalias\alias_civ_afr_lgt_female_heads::main());
}