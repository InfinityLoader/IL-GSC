/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character_atlas_arctic_ar.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 38 ms
 * Timestamp: 4/22/2024 2:01:17 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("atlas_arctic_body");
	codescripts\character::attachhead("alias_enemy_atlas_arctic_heads",xmodelalias\alias_enemy_atlas_arctic_heads::main());
	self.voice = "atlas";
	self setclothtype("vestlight");
}

//Function Number: 2
precache()
{
	precachemodel("atlas_arctic_body");
	codescripts\character::precachemodelarray(xmodelalias\alias_enemy_atlas_arctic_heads::main());
}