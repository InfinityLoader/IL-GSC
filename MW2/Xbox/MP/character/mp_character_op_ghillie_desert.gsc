/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character\mp_character_op_ghillie_desert.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: Xbox
*******************************************************************/

main()
{
	self setmodel("mp_body_op_sniper_ghillie_desert");
	self attach("head_op_sniper_ghillie_desert", "", 1);
	self.headmodel = "head_op_sniper_ghillie_desert";
	self setviewmodel("viewhands_ghillie_desert");
	self.voice = "arab";
}

precache()
{
	precachemodel("mp_body_op_sniper_ghillie_desert");
	precachemodel("head_op_sniper_ghillie_desert");
	precachemodel("viewhands_ghillie_desert");
}