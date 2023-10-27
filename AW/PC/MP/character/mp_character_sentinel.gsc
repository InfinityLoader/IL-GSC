/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character/mp_character_sentinel.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 29 ms
 * Timestamp: 10/27/2023 1:46:53 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("mp_sentinel_body_nojet_b");
	codescripts\character::attachhead("alias_mp_sentinel_heads",xmodelalias\alias_mp_sentinel_heads::main());
	self setviewmodel("viewhands_s1_pmc");
	self.voice = "american";
	self setclothtype("vestlight");
}

//Function Number: 2
precache()
{
	precachemodel("mp_sentinel_body_nojet_b");
	codescripts\character::precachemodelarray(xmodelalias\alias_mp_sentinel_heads::main());
	precachemodel("viewhands_s1_pmc");
}