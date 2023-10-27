/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 407.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 0 ms
 * Timestamp: 10/27/2023 2:15:50 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("mp_body_opforce_ghillie_arctic_sniper");
	self attach("head_opforce_russian_arctic_sniper","",1);
	self.var_1E5A = "head_opforce_russian_arctic_sniper";
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