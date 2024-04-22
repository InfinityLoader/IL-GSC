/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character_nigerian_army.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 40 ms
 * Timestamp: 4/22/2024 2:02:19 AM
*******************************************************************/

//Function Number: 1
main()
{
	codescripts\character::setmodelfromarray(xmodelalias\alias_nigerian_army_bodies::main());
	codescripts\character::attachhead("alias_nigerian_army_heads",xmodelalias\alias_nigerian_army_heads::main());
	self.voice = "african";
	self setclothtype("vestlight");
}

//Function Number: 2
precache()
{
	codescripts\character::precachemodelarray(xmodelalias\alias_nigerian_army_bodies::main());
	codescripts\character::precachemodelarray(xmodelalias\alias_nigerian_army_heads::main());
}