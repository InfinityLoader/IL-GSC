/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character\character_sp_sas_woodland_peter.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 47 ms
 * Timestamp: 10/27/2023 2:45:19 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("body_sp_sas_woodland_assault_a");
	self attach("head_sp_sas_woodland_peter","",1);
	self.headmodel = "head_sp_sas_woodland_peter";
	self.voice = "british";
	self setclothtype("vestlight");
}

//Function Number: 2
precache()
{
	precachemodel("body_sp_sas_woodland_assault_a");
	precachemodel("head_sp_sas_woodland_peter");
}