/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character/character_civ_seoul_female.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 29 ms
 * Timestamp: 10/27/2023 1:57:07 AM
*******************************************************************/

//Function Number: 1
main()
{
	codescripts\character::setmodelfromarray(xmodelalias\alias_seoul_civilian_body_females::main());
	codescripts\character::attachhead("alias_seoul_civilian_head_females",xmodelalias\alias_seoul_civilian_head_females::main());
	self.voice = "american";
	self setclothtype("vestlight");
}

//Function Number: 2
precache()
{
	codescripts\character::precachemodelarray(xmodelalias\alias_seoul_civilian_body_females::main());
	codescripts\character::precachemodelarray(xmodelalias\alias_seoul_civilian_head_females::main());
}