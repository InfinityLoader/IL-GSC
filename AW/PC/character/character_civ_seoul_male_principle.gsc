/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character_civ_seoul_male_principle.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 33 ms
 * Timestamp: 4/22/2024 2:01:45 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("civ_seoul_male_body_f");
	self attach("civ_seoul_male_head_c","",1);
	self.headmodel = "civ_seoul_male_head_c";
	self.voice = "american";
	self setclothtype("vestlight");
}

//Function Number: 2
precache()
{
	precachemodel("civ_seoul_male_body_f");
	precachemodel("civ_seoul_male_head_c");
}