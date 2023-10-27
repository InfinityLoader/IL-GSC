/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character\mp_character_opforce_woods_smg.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 2
 * Decompile Time: 31 ms
 * Timestamp: 10/27/2023 2:28:35 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("mp_body_russian_military_smg_a_woodland");
	self attach("head_russian_military_e","",1);
	self.headmodel = "head_russian_military_e";
	self setviewmodel("viewhands_russian_c");
	self.voice = "russian";
}

//Function Number: 2
precache()
{
	precachemodel("mp_body_russian_military_smg_a_woodland");
	precachemodel("head_russian_military_e");
	precachemodel("viewhands_russian_c");
}