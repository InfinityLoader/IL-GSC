/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character\mp_character_opforce_air_smg.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 2
 * Decompile Time: 28 ms
 * Timestamp: 10/27/2023 2:28:21 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("mp_body_russian_military_smg_a_airborne");
	self attach("head_russian_military_f","",1);
	self.headmodel = "head_russian_military_f";
	self setviewmodel("viewhands_russian_b");
	self.voice = "russian";
}

//Function Number: 2
precache()
{
	precachemodel("mp_body_russian_military_smg_a_airborne");
	precachemodel("head_russian_military_f");
	precachemodel("viewhands_russian_b");
}