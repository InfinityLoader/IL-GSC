/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character\character_sp_sas_woodland_hugh.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 45 ms
 * Timestamp: 10/27/2023 2:45:18 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("body_sp_sas_woodland_support_a");
	self attach("head_sp_sas_woodland_hugh","",1);
	self.headmodel = "head_sp_sas_woodland_hugh";
	self.voice = "british";
	self setclothtype("vestlight");
}

//Function Number: 2
precache()
{
	precachemodel("body_sp_sas_woodland_support_a");
	precachemodel("head_sp_sas_woodland_hugh");
}