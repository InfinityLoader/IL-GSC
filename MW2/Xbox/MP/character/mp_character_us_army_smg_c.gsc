/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character\mp_character_us_army_smg_c.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: Xbox
*******************************************************************/

main()
{
	self setmodel("mp_body_us_army_smg_c");
	codescripts\character::attachhead("alias_us_army_heads", xmodelalias\alias_us_army_heads::main());
	self setviewmodel("viewhands_us_army");
	self.voice = "american";
}

precache()
{
	precachemodel("mp_body_us_army_smg_c");
	codescripts\character::precachemodelarray(xmodelalias\alias_us_army_heads::main());
	precachemodel("viewhands_us_army");
}