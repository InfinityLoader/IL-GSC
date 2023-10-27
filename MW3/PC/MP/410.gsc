/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 410.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 0 ms
 * Timestamp: 10/27/2023 2:15:51 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("mp_body_ally_ghillie_woodland_sniper");
	self attach("head_ally_delta_sniper","",1);
	self.var_1E5A = "head_ally_delta_sniper";
	self setviewmodel("viewhands_iw5_ghillie_woodland");
	self.voice = "pmc";
}

//Function Number: 2
precache()
{
	precachemodel("mp_body_ally_ghillie_woodland_sniper");
	precachemodel("head_ally_delta_sniper");
	precachemodel("viewhands_iw5_ghillie_woodland");
}