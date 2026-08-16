/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character\mp_character_seal_udt_smg.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: PC
*******************************************************************/

main()
{
	self setmodel("mp_body_seal_udt_smg");
	codescripts\character::attachhead("alias_seal_udt_heads", xmodelalias\alias_seal_udt_heads::main());
	self setviewmodel("viewhands_udt");
	self.voice = "seal";
}

precache()
{
	precachemodel("mp_body_seal_udt_smg");
	codescripts\character::precachemodelarray(xmodelalias\alias_seal_udt_heads::main());
	precachemodel("viewhands_udt");
}