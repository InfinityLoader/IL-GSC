/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character_atlas_noexo.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 33 ms
 * Timestamp: 4/22/2024 2:01:18 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("atlas_body_noexo");
	codescripts\character::attachhead("alias_enemy_atlas_heads",xmodelalias\alias_enemy_atlas_heads::main());
	self.voice = "atlas";
	self setclothtype("vestlight");
}

//Function Number: 2
precache()
{
	precachemodel("atlas_body_noexo");
	codescripts\character::precachemodelarray(xmodelalias\alias_enemy_atlas_heads::main());
}