/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character\mp_character_seal_socom_assault_b.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: PC
*******************************************************************/

main()
{
	self setmodel("mp_body_seal_soccom_assault_b");
	codescripts\character::attachhead("alias_seal_soccom_heads_mp", xmodelalias\alias_seal_soccom_heads_mp::main());
	self setviewmodel("viewhands_us_army");
	self.voice = "american";
}

precache()
{
	precachemodel("mp_body_seal_soccom_assault_b");
	codescripts\character::precachemodelarray(xmodelalias\alias_seal_soccom_heads_mp::main());
	precachemodel("viewhands_us_army");
}