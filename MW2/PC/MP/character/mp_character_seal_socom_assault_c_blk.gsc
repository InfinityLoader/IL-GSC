/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character\mp_character_seal_socom_assault_c_blk.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: PC
*******************************************************************/

main()
{
	self setmodel("mp_body_seal_soccom_assault_c_blk");
	codescripts\character::attachhead("alias_seal_soccom_heads_mp_blk", xmodelalias\alias_seal_soccom_heads_mp_blk::main());
	self setviewmodel("viewhands_us_army");
	self.voice = "american";
}

precache()
{
	precachemodel("mp_body_seal_soccom_assault_c_blk");
	codescripts\character::precachemodelarray(xmodelalias\alias_seal_soccom_heads_mp_blk::main());
	precachemodel("viewhands_us_army");
}