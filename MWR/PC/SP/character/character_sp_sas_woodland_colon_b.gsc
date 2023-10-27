/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character\character_sp_sas_woodland_colon_b.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 53 ms
 * Timestamp: 10/27/2023 2:45:12 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("body_sp_sas_woodland_colon");
	self attach("head_sas_ct_assault_neal_nomask","",1);
	self.headmodel = "head_sas_ct_assault_neal_nomask";
	self.voice = "british";
	self setclothtype("vestlight");
}

//Function Number: 2
precache()
{
	precachemodel("body_sp_sas_woodland_colon");
	precachemodel("head_sas_ct_assault_neal_nomask");
}