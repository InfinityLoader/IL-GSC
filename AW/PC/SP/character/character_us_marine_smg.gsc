/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character/character_us_marine_smg.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 30 ms
 * Timestamp: 10/27/2023 1:57:22 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("marines_body_smg");
	codescripts\character::attachhead("alias_us_marine_heads",xmodelalias\alias_us_marine_heads::main());
	self.voice = "sentinel";
	self setclothtype("vestlight");
}

//Function Number: 2
precache()
{
	precachemodel("marines_body_smg");
	codescripts\character::precachemodelarray(xmodelalias\alias_us_marine_heads::main());
}