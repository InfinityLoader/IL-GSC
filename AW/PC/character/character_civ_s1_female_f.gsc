/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character_civ_s1_female_f.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 30 ms
 * Timestamp: 4/22/2024 2:01:37 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("civ_urban_female_body_f");
	self attach("head_f_act_cau_biedermann","",1);
	self.headmodel = "head_f_act_cau_biedermann";
	self.voice = "american";
	self setclothtype("vestlight");
}

//Function Number: 2
precache()
{
	precachemodel("civ_urban_female_body_f");
	precachemodel("head_f_act_cau_biedermann");
}