/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 654.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 0 ms
 * Timestamp: 10/27/2023 2:16:13 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("mp_body_opforce_russian_woodland_sniper");
	self attach("head_opforce_russian_woodland_sniper","",1);
	self.var_1E5A = "head_opforce_russian_woodland_sniper";
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