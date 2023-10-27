/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character\mp_character_sas_urban_assault.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 2
 * Decompile Time: 28 ms
 * Timestamp: 10/27/2023 2:28:12 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("mp_body_sas_urban_assault");
	codescripts\character::attachhead("alias_sas_heads",xmodelalias\alias_sas_heads::main());
	self setviewmodel("viewhands_sas");
	self.voice = "british";
}

//Function Number: 2
precache()
{
	precachemodel("mp_body_sas_urban_assault");
	codescripts\character::func_19F4(xmodelalias\alias_sas_heads::main());
	precachemodel("viewhands_sas");
}