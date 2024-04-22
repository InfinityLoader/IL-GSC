/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character_civ_seoul_female.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 31 ms
 * Timestamp: 4/22/2024 2:01:44 AM
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