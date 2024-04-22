/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character_civ_seoul_male_c.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 30 ms
 * Timestamp: 4/22/2024 2:01:44 AM
*******************************************************************/

//Function Number: 1
main()
{
	codescripts\character::setmodelfromarray(xmodelalias\alias_seoul_civilian_body_males_c::main());
	codescripts\character::attachhead("alias_seoul_civilian_head_males_c",xmodelalias\alias_seoul_civilian_head_males_c::main());
	self.voice = "american";
	self setclothtype("vestlight");
}

//Function Number: 2
precache()
{
	codescripts\character::precachemodelarray(xmodelalias\alias_seoul_civilian_body_males_c::main());
	codescripts\character::precachemodelarray(xmodelalias\alias_seoul_civilian_head_males_c::main());
}