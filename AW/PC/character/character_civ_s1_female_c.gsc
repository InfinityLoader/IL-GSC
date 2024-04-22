/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character_civ_s1_female_c.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 40 ms
 * Timestamp: 4/22/2024 2:01:36 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("civ_urban_female_body_c_afr_dark");
	self attach("head_f_act_afr_townes","",1);
	self.headmodel = "head_f_act_afr_townes";
	self.voice = "american";
	self setclothtype("vestlight");
}

//Function Number: 2
precache()
{
	precachemodel("civ_urban_female_body_c_afr_dark");
	precachemodel("head_f_act_afr_townes");
}