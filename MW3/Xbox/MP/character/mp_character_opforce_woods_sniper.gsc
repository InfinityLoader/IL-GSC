/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character\mp_character_opforce_woods_sniper.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 2
 * Decompile Time: 30 ms
 * Timestamp: 10/27/2023 2:28:35 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("mp_body_opforce_russian_woodland_sniper");
	self attach("head_opforce_russian_woodland_sniper","",1);
	self.headmodel = "head_opforce_russian_woodland_sniper";
	self setviewmodel("viewhands_russian_c");
	self.voice = "russian";
}

//Function Number: 2
precache()
{
	precachemodel("mp_body_opforce_russian_woodland_sniper");
	precachemodel("head_opforce_russian_woodland_sniper");
	precachemodel("viewhands_russian_c");
}