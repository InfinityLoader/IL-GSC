/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character\character_sp_sas_woodland_gaz.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 45 ms
 * Timestamp: 10/27/2023 2:45:14 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("body_sas_woodland_gaz");
	self attach("head_sas_woodland_gaz","",1);
	self.headmodel = "head_sas_woodland_gaz";
	self.voice = "british";
	self setclothtype("vestlight");
}

//Function Number: 2
precache()
{
	precachemodel("body_sas_woodland_gaz");
	precachemodel("head_sas_woodland_gaz");
}