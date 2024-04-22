/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character_hero_carter_pmc.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 41 ms
 * Timestamp: 4/22/2024 2:01:59 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("atlas_pmc_body");
	codescripts\character::attachhead("alias_pmc_helmet_heads",xmodelalias\alias_pmc_helmet_heads::main());
	self.voice = "xslice";
	self setclothtype("vestlight");
}

//Function Number: 2
precache()
{
	precachemodel("atlas_pmc_body");
	codescripts\character::precachemodelarray(xmodelalias\alias_pmc_helmet_heads::main());
}