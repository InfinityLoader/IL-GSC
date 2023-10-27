/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character\mp_character_ally_ghillie_desert.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 2
 * Decompile Time: 31 ms
 * Timestamp: 10/27/2023 2:29:20 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("mp_body_ally_ghillie_desert_sniper");
	self attach("head_ally_delta_sniper","",1);
	self.headmodel = "head_ally_delta_sniper";
	self setviewmodel("viewhands_iw5_ghillie_desert");
	self.voice = "delta";
}

//Function Number: 2
precache()
{
	precachemodel("mp_body_ally_ghillie_desert_sniper");
	precachemodel("head_ally_delta_sniper");
	precachemodel("viewhands_iw5_ghillie_desert");
}