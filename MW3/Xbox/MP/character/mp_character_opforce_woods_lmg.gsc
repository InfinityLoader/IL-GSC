/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character\mp_character_opforce_woods_lmg.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 2
 * Decompile Time: 30 ms
 * Timestamp: 10/27/2023 2:28:26 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("mp_body_russian_military_lmg_a_woodland");
	self attach("head_russian_military_a","",1);
	self.headmodel = "head_russian_military_a";
	self setviewmodel("viewhands_russian_c");
	self.voice = "russian";
}

//Function Number: 2
precache()
{
	precachemodel("mp_body_russian_military_lmg_a_woodland");
	precachemodel("head_russian_military_a");
	precachemodel("viewhands_russian_c");
}