/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character_kva_hazmat_nohat.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 39 ms
 * Timestamp: 4/22/2024 2:02:15 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("kva_hazmat_body_low");
	codescripts\character::attachhead("alias_civ_cau_male_heads_hazmat_nohat",xmodelalias\alias_civ_cau_male_heads_hazmat_nohat::main());
	self.voice = "kva";
	self setclothtype("vestlight");
}

//Function Number: 2
precache()
{
	precachemodel("kva_hazmat_body_low");
	codescripts\character::precachemodelarray(xmodelalias\alias_civ_cau_male_heads_hazmat_nohat::main());
}