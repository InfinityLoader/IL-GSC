/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character\mp_character_op_ghillie_militia.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 2
 * Decompile Time: 27 ms
 * Timestamp: 10/27/2023 2:29:25 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("mp_body_opforce_ghillie_africa_militia_sniper");
	self attach("head_ghillie_africa_militia_sniper","",1);
	self.headmodel = "head_ghillie_africa_militia_sniper";
	self setviewmodel("viewhands_african_militia");
	self.voice = "russian";
}

//Function Number: 2
precache()
{
	precachemodel("mp_body_opforce_ghillie_africa_militia_sniper");
	precachemodel("head_ghillie_africa_militia_sniper");
	precachemodel("viewhands_african_militia");
}