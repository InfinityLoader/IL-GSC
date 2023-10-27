/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character\mp_character_gign_paris_lmg.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 2
 * Decompile Time: 28 ms
 * Timestamp: 10/27/2023 2:28:14 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("mp_body_gign_paris_lmg");
	self attach("head_gign_d","",1);
	self.headmodel = "head_gign_d";
	self setviewmodel("viewhands_sas");
	self.voice = "french";
}

//Function Number: 2
precache()
{
	precachemodel("mp_body_gign_paris_lmg");
	precachemodel("head_gign_d");
	precachemodel("viewhands_sas");
}