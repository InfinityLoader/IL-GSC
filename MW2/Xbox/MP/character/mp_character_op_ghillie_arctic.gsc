/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character\mp_character_op_ghillie_arctic.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: Xbox
*******************************************************************/

main()
{
	self setmodel("mp_body_op_sniper_ghillie_arctic");
	self attach("head_op_sniper_ghillie_arctic", "", 1);
	self.headmodel = "head_op_sniper_ghillie_arctic";
	self setviewmodel("viewhands_ghillie_arctic");
	self.voice = "russian";
}

precache()
{
	precachemodel("mp_body_op_sniper_ghillie_arctic");
	precachemodel("head_op_sniper_ghillie_arctic");
	precachemodel("viewhands_ghillie_arctic");
}