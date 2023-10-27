/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character\mp_character_op_ghillie_forest.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 2
 * Decompile Time: 27 ms
 * Timestamp: 10/27/2023 2:29:24 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("mp_body_opforce_ghillie_woodland_sniper");
	self attach("head_opforce_russian_woodland_sniper","",1);
	self.headmodel = "head_opforce_russian_woodland_sniper";
	self setviewmodel("viewhands_iw5_ghillie_woodland");
	self.voice = "russian";
}

//Function Number: 2
precache()
{
	precachemodel("mp_body_opforce_ghillie_woodland_sniper");
	precachemodel("head_opforce_russian_woodland_sniper");
	precachemodel("viewhands_iw5_ghillie_woodland");
}