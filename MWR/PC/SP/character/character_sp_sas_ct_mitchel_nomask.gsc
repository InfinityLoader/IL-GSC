/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character\character_sp_sas_ct_mitchel_nomask.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 47 ms
 * Timestamp: 10/27/2023 2:45:08 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("body_sas_ct_assault_mitchel");
	self attach("head_slum_civ_male_h","",1);
	self.headmodel = "head_slum_civ_male_h";
	self.voice = "british";
	self setclothtype("vestlight");
}

//Function Number: 2
precache()
{
	precachemodel("body_sas_ct_assault_mitchel");
	precachemodel("head_slum_civ_male_h");
}