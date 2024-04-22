/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character_civ_rec_funeral_male.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 43 ms
 * Timestamp: 4/22/2024 2:01:31 AM
*******************************************************************/

//Function Number: 1
main()
{
	codescripts\character::setmodelfromarray(xmodelalias\alias_civ_rec_funeral_male_body::main());
	codescripts\character::attachhead("alias_civ_rec_funeral_male_heads",xmodelalias\alias_civ_rec_funeral_male_heads::main());
	self.voice = "american";
	self setclothtype("vestlight");
}

//Function Number: 2
precache()
{
	codescripts\character::precachemodelarray(xmodelalias\alias_civ_rec_funeral_male_body::main());
	codescripts\character::precachemodelarray(xmodelalias\alias_civ_rec_funeral_male_heads::main());
}