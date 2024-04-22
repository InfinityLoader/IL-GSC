/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character_civilian_slum_male_ba_wht.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 39 ms
 * Timestamp: 4/22/2024 2:01:52 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("body_slum_civ_male_ba_wht");
	codescripts\character::attachhead("alias_civilian_slum_heads_wht",xmodelalias\alias_civilian_slum_heads_wht::main());
	self.voice = "american";
	self setclothtype("vestlight");
}

//Function Number: 2
precache()
{
	precachemodel("body_slum_civ_male_ba_wht");
	codescripts\character::precachemodelarray(xmodelalias\alias_civilian_slum_heads_wht::main());
}