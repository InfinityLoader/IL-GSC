/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character\mp_character_opforce_snow_lmg.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 2
 * Decompile Time: 29 ms
 * Timestamp: 10/27/2023 2:28:22 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("mp_body_russian_military_lmg_a_arctic");
	codescripts\character::attachhead("alias_russian_military_arctic_heads",xmodelalias\alias_russian_military_arctic_heads::main());
	self setviewmodel("viewhands_russian_d");
	self.voice = "russian";
}

//Function Number: 2
precache()
{
	precachemodel("mp_body_russian_military_lmg_a_arctic");
	codescripts\character::func_19F4(xmodelalias\alias_russian_military_arctic_heads::main());
	precachemodel("viewhands_russian_d");
}