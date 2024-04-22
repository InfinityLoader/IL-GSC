/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character_atlas_elete.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 52 ms
 * Timestamp: 4/22/2024 2:01:17 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("atlas_elite_body");
	codescripts\character::attachhead("alias_enemy_atlas_elite_heads",xmodelalias\alias_enemy_atlas_elite_heads::main());
	self.voice = "atlas";
	self setclothtype("vestlight");
}

//Function Number: 2
precache()
{
	precachemodel("atlas_elite_body");
	codescripts\character::precachemodelarray(xmodelalias\alias_enemy_atlas_elite_heads::main());
}