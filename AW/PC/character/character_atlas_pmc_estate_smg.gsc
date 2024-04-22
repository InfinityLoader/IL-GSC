/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character_atlas_pmc_estate_smg.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 30 ms
 * Timestamp: 4/22/2024 2:01:18 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("atlas_pmc_body_noexo");
	codescripts\character::attachhead("alias_pmc_casual_heads",xmodelalias\alias_pmc_casual_heads::main());
	self.voice = "secretservice";
	self setclothtype("vestlight");
}

//Function Number: 2
precache()
{
	precachemodel("atlas_pmc_body_noexo");
	codescripts\character::precachemodelarray(xmodelalias\alias_pmc_casual_heads::main());
}