/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character\character_sp_sas_woodland_afro_02.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 42 ms
 * Timestamp: 10/27/2023 2:45:11 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("body_sas_woodland_soldier_afro_02");
	self attach("head_sp_sas_woodland_soldier_afro_02","",1);
	self.headmodel = "head_sp_sas_woodland_soldier_afro_02";
	self.voice = "british";
	self setclothtype("vestlight");
}

//Function Number: 2
precache()
{
	precachemodel("body_sas_woodland_soldier_afro_02");
	precachemodel("head_sp_sas_woodland_soldier_afro_02");
}