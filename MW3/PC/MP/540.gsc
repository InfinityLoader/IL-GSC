/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 540.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 0 ms
 * Timestamp: 10/27/2023 2:16:03 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("mp_body_gign_paris_lmg");
	self attach("head_gign_a","",1);
	self.var_1E5A = "head_gign_a";
	self setviewmodel("viewhands_sas");
	self.voice = "french";
}

//Function Number: 2
precache()
{
	precachemodel("mp_body_gign_paris_lmg");
	precachemodel("head_gign_a");
	precachemodel("viewhands_sas");
}