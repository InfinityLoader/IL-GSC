/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character\mp_character_op_ghillie_forest.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: PC
*******************************************************************/

main()
{
	self setmodel("mp_body_op_sniper_ghillie_forest");
	self attach("head_op_sniper_ghillie_forest", "", 1);
	self.headmodel = "head_op_sniper_ghillie_forest";
	self setviewmodel("viewhands_ghillie_forest");
	self.voice = "russian";
}

precache()
{
	precachemodel("mp_body_op_sniper_ghillie_forest");
	precachemodel("head_op_sniper_ghillie_forest");
	precachemodel("viewhands_ghillie_forest");
}