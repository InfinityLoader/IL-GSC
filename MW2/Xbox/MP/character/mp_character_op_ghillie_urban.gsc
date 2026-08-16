/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character\mp_character_op_ghillie_urban.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: Xbox
*******************************************************************/

main()
{
	self setmodel("mp_body_op_sniper_ghillie_urban");
	self attach("head_op_sniper_ghillie_urban", "", 1);
	self.headmodel = "head_op_sniper_ghillie_urban";
	self setviewmodel("viewhands_ghillie_urban");
	self.voice = "russian";
}

precache()
{
	precachemodel("mp_body_op_sniper_ghillie_urban");
	precachemodel("head_op_sniper_ghillie_urban");
	precachemodel("viewhands_ghillie_urban");
}