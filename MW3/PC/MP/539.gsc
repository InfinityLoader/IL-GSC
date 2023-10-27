/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 539.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 0 ms
 * Timestamp: 10/27/2023 2:16:03 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("mp_body_gign_paris_smg");
	self attach("head_gign_saber_gasmask","",1);
	self.var_1E5A = "head_gign_saber_gasmask";
	self setviewmodel("viewhands_sas");
	self.voice = "french";
}

//Function Number: 2
precache()
{
	precachemodel("mp_body_gign_paris_smg");
	precachemodel("head_gign_saber_gasmask");
	precachemodel("viewhands_sas");
}