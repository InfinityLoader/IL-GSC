/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character\mp_character_militia_smg_aa_wht.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: Xbox
*******************************************************************/

main()
{
	self setmodel("mp_body_militia_smg_aa_wht");
	codescripts\character::attachhead("alias_opforce_militia_heads_wht", xmodelalias\alias_opforce_militia_heads_wht::main());
	self setviewmodel("viewhands_militia");
	self.voice = "portuguese";
}

precache()
{
	precachemodel("mp_body_militia_smg_aa_wht");
	codescripts\character::precachemodelarray(xmodelalias\alias_opforce_militia_heads_wht::main());
	precachemodel("viewhands_militia");
}