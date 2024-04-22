/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character_coop_cloaked_static.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 39 ms
 * Timestamp: 4/22/2024 2:01:54 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("body_coop_cloaked_static");
	codescripts\character::attachhead("alias_coop_cloaked_static_heads",xmodelalias\alias_coop_cloaked_static_heads::main());
	self.voice = "russian";
	self setclothtype("vestlight");
}

//Function Number: 2
precache()
{
	precachemodel("body_coop_cloaked_static");
	codescripts\character::precachemodelarray(xmodelalias\alias_coop_cloaked_static_heads::main());
}