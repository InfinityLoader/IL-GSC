/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character\mp_character_op_militia_sniper.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: Xbox
*******************************************************************/

main()
{
	self setmodel("mp_body_op_miltia_sniper");
	self attach("head_op_militia_sniper", "", 1);
	self.headmodel = "head_op_militia_sniper";
	self setviewmodel("viewhands_militia");
	self.voice = "portuguese";
}

precache()
{
	precachemodel("mp_body_op_miltia_sniper");
	precachemodel("head_op_militia_sniper");
	precachemodel("viewhands_militia");
}