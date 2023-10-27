/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character/character_pmc_smg.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 32 ms
 * Timestamp: 10/27/2023 1:57:15 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("atlas_pmc_smg");
	codescripts\character::attachhead("alias_pmc_casual_heads",xmodelalias\alias_pmc_casual_heads::main());
	self.voice = "atlas";
	self setclothtype("vestlight");
}

//Function Number: 2
precache()
{
	precachemodel("atlas_pmc_smg");
	codescripts\character::precachemodelarray(xmodelalias\alias_pmc_casual_heads::main());
}