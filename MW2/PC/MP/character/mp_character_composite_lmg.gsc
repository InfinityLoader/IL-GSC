/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character\mp_character_composite_lmg.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: PC
*******************************************************************/

main()
{
	self setmodel("mp_body_opforce_arab_lmg_a");
	codescripts\character::attachhead("alias_opforce_arab_heads", xmodelalias\alias_opforce_arab_heads::main());
	self setviewmodel("viewhands_militia");
	self.voice = "arab";
}

precache()
{
	precachemodel("mp_body_opforce_arab_lmg_a");
	codescripts\character::precachemodelarray(xmodelalias\alias_opforce_arab_heads::main());
	precachemodel("viewhands_militia");
}