/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character\character_sp_sas_woodland_golden_a.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 48 ms
 * Timestamp: 10/27/2023 2:45:15 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("body_sp_sas_woodland_golden");
	self attach("head_sas_ct_assault_mitchel_nomask","",1);
	self.headmodel = "head_sas_ct_assault_mitchel_nomask";
	self.voice = "british";
	self setclothtype("vestlight");
}

//Function Number: 2
precache()
{
	precachemodel("body_sp_sas_woodland_golden");
	precachemodel("head_sas_ct_assault_mitchel_nomask");
}