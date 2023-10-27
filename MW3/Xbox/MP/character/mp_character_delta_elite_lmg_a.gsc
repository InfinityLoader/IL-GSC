/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character\mp_character_delta_elite_lmg_a.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 2
 * Decompile Time: 27 ms
 * Timestamp: 10/27/2023 2:28:09 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("mp_body_delta_elite_lmg_a");
	codescripts\character::attachhead("alias_delta_elite_heads",xmodelalias\alias_delta_elite_heads::main());
	self setviewmodel("viewhands_delta");
	self.voice = "delta";
}

//Function Number: 2
precache()
{
	precachemodel("mp_body_delta_elite_lmg_a");
	codescripts\character::func_19F4(xmodelalias\alias_delta_elite_heads::main());
	precachemodel("viewhands_delta");
}