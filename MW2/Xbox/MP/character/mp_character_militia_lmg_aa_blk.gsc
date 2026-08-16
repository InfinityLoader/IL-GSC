/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character\mp_character_militia_lmg_aa_blk.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: Xbox
*******************************************************************/

main()
{
	self setmodel("mp_body_militia_lmg_aa_blk");
	codescripts\character::attachhead("alias_opforce_militia_heads_blk", xmodelalias\alias_opforce_militia_heads_blk::main());
	self setviewmodel("viewhands_militia");
	self.voice = "portuguese";
}

precache()
{
	precachemodel("mp_body_militia_lmg_aa_blk");
	codescripts\character::precachemodelarray(xmodelalias\alias_opforce_militia_heads_blk::main());
	precachemodel("viewhands_militia");
}