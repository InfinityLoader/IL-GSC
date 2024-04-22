/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character_doctor.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 38 ms
 * Timestamp: 4/22/2024 2:01:54 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("doctor_body");
	codescripts\character::attachhead("alias_civ_asi_male_heads",xmodelalias\alias_civ_asi_male_heads::main());
	self.voice = "atlas";
	self setclothtype("vestlight");
}

//Function Number: 2
precache()
{
	precachemodel("doctor_body");
	codescripts\character::precachemodelarray(xmodelalias\alias_civ_asi_male_heads::main());
}