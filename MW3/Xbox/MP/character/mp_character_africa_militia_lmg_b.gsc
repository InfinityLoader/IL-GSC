/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character\mp_character_africa_militia_lmg_b.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 2
 * Decompile Time: 29 ms
 * Timestamp: 10/27/2023 2:28:37 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("mp_body_africa_militia_lmg_b");
	codescripts\character::attachhead("alias_africa_militia_heads_mp",xmodelalias\alias_africa_militia_heads_mp::main());
	self setviewmodel("viewhands_african_militia");
	self.voice = "african";
}

//Function Number: 2
precache()
{
	precachemodel("mp_body_africa_militia_lmg_b");
	codescripts\character::func_19F4(xmodelalias\alias_africa_militia_heads_mp::main());
	precachemodel("viewhands_african_militia");
}