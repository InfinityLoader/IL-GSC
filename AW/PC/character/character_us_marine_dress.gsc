/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character_us_marine_dress.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 50 ms
 * Timestamp: 4/22/2024 2:02:31 AM
*******************************************************************/

//Function Number: 1
main()
{
	codescripts\character::setmodelfromarray(xmodelalias\alias_us_marine_dress_bodies::main());
	codescripts\character::attachhead("alias_us_marine_dress_heads",xmodelalias\alias_us_marine_dress_heads::main());
	self.voice = "sentinel";
	self setclothtype("vestlight");
}

//Function Number: 2
precache()
{
	codescripts\character::precachemodelarray(xmodelalias\alias_us_marine_dress_bodies::main());
	codescripts\character::precachemodelarray(xmodelalias\alias_us_marine_dress_heads::main());
}