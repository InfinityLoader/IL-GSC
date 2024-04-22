/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp_character_ally_ghillie_urban.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 40 ms
 * Timestamp: 4/22/2024 2:02:36 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("mp_body_ally_ghillie_urban_sniper");
	self attach("head_ally_delta_sniper","",1);
	self.headmodel = "head_ally_delta_sniper";
	self setviewmodel("viewhands_iw5_ghillie_urban");
	self.voice = "delta";
	self setclothtype("vestlight");
}

//Function Number: 2
precache()
{
	precachemodel("mp_body_ally_ghillie_urban_sniper");
	precachemodel("head_ally_delta_sniper");
	precachemodel("viewhands_iw5_ghillie_urban");
}