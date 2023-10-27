/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 622.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 0 ms
 * Timestamp: 10/27/2023 2:16:10 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("mp_body_russian_military_smg_a_arctic");
	self attach("head_russian_military_f","",1);
	self.var_1E5A = "head_russian_military_f";
	self setviewmodel("viewhands_russian_d");
	self.voice = "russian";
}

//Function Number: 2
precache()
{
	precachemodel("mp_body_russian_military_smg_a_arctic");
	precachemodel("head_russian_military_f");
	precachemodel("viewhands_russian_d");
}