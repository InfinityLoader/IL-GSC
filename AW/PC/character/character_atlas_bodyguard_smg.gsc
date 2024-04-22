/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character_atlas_bodyguard_smg.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 32 ms
 * Timestamp: 4/22/2024 2:01:17 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("civ_urban_male_body_g");
	codescripts\character::attachhead("alias_atlas_bodyguard_heads",xmodelalias\alias_atlas_bodyguard_heads::main());
	self.voice = "secretservice";
	self setclothtype("vestlight");
}

//Function Number: 2
precache()
{
	precachemodel("civ_urban_male_body_g");
	codescripts\character::precachemodelarray(xmodelalias\alias_atlas_bodyguard_heads::main());
}