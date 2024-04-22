/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp_character_op_ghillie_urban.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 41 ms
 * Timestamp: 4/22/2024 2:02:37 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("mp_body_opforce_ghillie_urban_sniper");
	self attach("head_opforce_russian_urban_sniper","",1);
	self.headmodel = "head_opforce_russian_urban_sniper";
	self setviewmodel("viewhands_iw5_ghillie_urban");
	self.voice = "russian";
	self setclothtype("vestlight");
}

//Function Number: 2
precache()
{
	precachemodel("mp_body_opforce_ghillie_urban_sniper");
	precachemodel("head_opforce_russian_urban_sniper");
	precachemodel("viewhands_iw5_ghillie_urban");
}