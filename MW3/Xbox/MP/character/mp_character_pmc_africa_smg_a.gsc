/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character\mp_character_pmc_africa_smg_a.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 2
 * Decompile Time: 30 ms
 * Timestamp: 10/27/2023 2:28:18 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("mp_body_pmc_africa_smg_a");
	codescripts\character::attachhead("alias_pmc_africa_heads",xmodelalias\alias_pmc_africa_heads::main());
	self setviewmodel("viewhands_pmc");
	self.voice = "russian";
}

//Function Number: 2
precache()
{
	precachemodel("mp_body_pmc_africa_smg_a");
	codescripts\character::func_19F4(xmodelalias\alias_pmc_africa_heads::main());
	precachemodel("viewhands_pmc");
}