/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character_civ_seoul_male_b.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 33 ms
 * Timestamp: 4/22/2024 2:01:44 AM
*******************************************************************/

//Function Number: 1
main()
{
	codescripts\character::setmodelfromarray(xmodelalias\alias_seoul_civilian_body_males_b::main());
	codescripts\character::attachhead("alias_seoul_civilian_head_males_b",xmodelalias\alias_seoul_civilian_head_males_b::main());
	self.voice = "american";
	self setclothtype("vestlight");
}

//Function Number: 2
precache()
{
	codescripts\character::precachemodelarray(xmodelalias\alias_seoul_civilian_body_males_b::main());
	codescripts\character::precachemodelarray(xmodelalias\alias_seoul_civilian_head_males_b::main());
}