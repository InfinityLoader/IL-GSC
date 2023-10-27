/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character\mp_character_sas_urban_sniper.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 2
 * Decompile Time: 39 ms
 * Timestamp: 10/27/2023 2:28:14 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("mp_body_ally_sas_sniper");
	self attach("head_ally_sas_sniper","",1);
	self.headmodel = "head_ally_sas_sniper";
	self setviewmodel("viewhands_sas");
	self.voice = "british";
}

//Function Number: 2
precache()
{
	precachemodel("mp_body_ally_sas_sniper");
	precachemodel("head_ally_sas_sniper");
	precachemodel("viewhands_sas");
}