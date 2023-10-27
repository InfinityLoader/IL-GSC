/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character\mp_character_opforce_hench_lmg_a.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 2
 * Decompile Time: 28 ms
 * Timestamp: 10/27/2023 2:28:49 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("mp_body_henchmen_lmg_a");
	codescripts\character::attachhead("alias_henchmen_heads_mp",xmodelalias\alias_henchmen_heads_mp::main());
	self setviewmodel("viewhands_henchmen");
	self.voice = "russian";
}

//Function Number: 2
precache()
{
	precachemodel("mp_body_henchmen_lmg_a");
	codescripts\character::func_19F4(xmodelalias\alias_henchmen_heads_mp::main());
	precachemodel("viewhands_henchmen");
}