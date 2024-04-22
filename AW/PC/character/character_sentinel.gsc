/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character_sentinel.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 38 ms
 * Timestamp: 4/22/2024 2:02:23 AM
*******************************************************************/

//Function Number: 1
main()
{
	codescripts\character::setmodelfromarray(xmodelalias\alias_sentinel_bodies::main());
	codescripts\character::attachhead("alias_sentinel_heads",xmodelalias\alias_sentinel_heads::main());
	self.voice = "sentinel";
	self setclothtype("vestlight");
}

//Function Number: 2
precache()
{
	codescripts\character::precachemodelarray(xmodelalias\alias_sentinel_bodies::main());
	codescripts\character::precachemodelarray(xmodelalias\alias_sentinel_heads::main());
}