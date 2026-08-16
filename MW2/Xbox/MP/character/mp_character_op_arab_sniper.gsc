/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character\mp_character_op_arab_sniper.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: Xbox
*******************************************************************/

main()
{
	self setmodel("mp_body_op_arab_sniper");
	self attach("head_op_arab_sniper", "", 1);
	self.headmodel = "head_op_arab_sniper";
	self setviewmodel("viewhands_sniper_op_arab");
	self.voice = "arab";
}

precache()
{
	precachemodel("mp_body_op_arab_sniper");
	precachemodel("head_op_arab_sniper");
	precachemodel("viewhands_sniper_op_arab");
}