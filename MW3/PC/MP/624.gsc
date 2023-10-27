/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 624.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 0 ms
 * Timestamp: 10/27/2023 2:16:10 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("mp_body_russian_military_assault_a");
	self attach("head_russian_military_aa","",1);
	self.var_1E5A = "head_russian_military_aa";
	self setviewmodel("viewhands_russian_a");
	self.voice = "russian";
}

//Function Number: 2
precache()
{
	precachemodel("mp_body_russian_military_assault_a");
	precachemodel("head_russian_military_aa");
	precachemodel("viewhands_russian_a");
}