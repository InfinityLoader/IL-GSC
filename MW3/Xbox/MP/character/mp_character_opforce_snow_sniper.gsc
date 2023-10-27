/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character\mp_character_opforce_snow_sniper.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 2
 * Decompile Time: 28 ms
 * Timestamp: 10/27/2023 2:28:24 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("mp_body_opforce_russian_arctic_sniper");
	self attach("head_opforce_russian_arctic_sniper","",1);
	self.headmodel = "head_opforce_russian_arctic_sniper";
	self setviewmodel("viewhands_russian_d");
	self.voice = "russian";
}

//Function Number: 2
precache()
{
	precachemodel("mp_body_opforce_russian_arctic_sniper");
	precachemodel("head_opforce_russian_arctic_sniper");
	precachemodel("viewhands_russian_d");
}