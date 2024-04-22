/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character_civilian_worker_b.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 40 ms
 * Timestamp: 4/22/2024 2:01:53 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("body_work_civ_male_b");
	codescripts\character::attachhead("alias_civilian_worker_heads",xmodelalias\alias_civilian_worker_heads::main());
	self.voice = "american";
	self setclothtype("vestlight");
}

//Function Number: 2
precache()
{
	precachemodel("body_work_civ_male_b");
	codescripts\character::precachemodelarray(xmodelalias\alias_civilian_worker_heads::main());
}