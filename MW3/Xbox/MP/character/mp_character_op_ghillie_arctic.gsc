/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character\mp_character_op_ghillie_arctic.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 2
 * Decompile Time: 28 ms
 * Timestamp: 10/27/2023 2:29:23 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("mp_body_opforce_ghillie_arctic_sniper");
	self attach("head_opforce_russian_arctic_sniper","",1);
	self.headmodel = "head_opforce_russian_arctic_sniper";
	self setviewmodel("viewhands_iw5_ghillie_arctic");
	self.voice = "russian";
}

//Function Number: 2
precache()
{
	precachemodel("mp_body_opforce_ghillie_arctic_sniper");
	precachemodel("head_opforce_russian_arctic_sniper");
	precachemodel("viewhands_iw5_ghillie_arctic");
}