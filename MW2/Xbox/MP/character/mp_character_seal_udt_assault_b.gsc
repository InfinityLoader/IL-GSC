/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character\mp_character_seal_udt_assault_b.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: Xbox
*******************************************************************/

main()
{
	self setmodel("mp_body_seal_udt_assault_b");
	codescripts\character::attachhead("alias_seal_udt_heads", xmodelalias\alias_seal_udt_heads::main());
	self setviewmodel("viewhands_udt");
	self.voice = "seal";
}

precache()
{
	precachemodel("mp_body_seal_udt_assault_b");
	codescripts\character::precachemodelarray(xmodelalias\alias_seal_udt_heads::main());
	precachemodel("viewhands_udt");
}