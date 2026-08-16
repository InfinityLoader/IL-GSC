/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character\mp_character_opforce_arctic_assault_b.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: Xbox
*******************************************************************/

main()
{
	self setmodel("mp_body_opforce_arctic_assault_b");
	codescripts\character::attachhead("alias_opforce_arctic_heads", xmodelalias\alias_opforce_arctic_heads::main());
	self setviewmodel("viewhands_arctic_opforce");
	self.voice = "russian";
}

precache()
{
	precachemodel("mp_body_opforce_arctic_assault_b");
	codescripts\character::precachemodelarray(xmodelalias\alias_opforce_arctic_heads::main());
	precachemodel("viewhands_arctic_opforce");
}