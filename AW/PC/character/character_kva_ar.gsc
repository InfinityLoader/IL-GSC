/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character_kva_ar.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 48 ms
 * Timestamp: 4/22/2024 2:02:13 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("kva_body_assault");
	codescripts\character::attachhead("alias_kva_heads",xmodelalias\alias_kva_heads::main());
	self.voice = "kva";
	self setclothtype("vestlight");
}

//Function Number: 2
precache()
{
	precachemodel("kva_body_assault");
	codescripts\character::precachemodelarray(xmodelalias\alias_kva_heads::main());
}