/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character_civ_rec_funeral_female_a.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 30 ms
 * Timestamp: 4/22/2024 2:01:30 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("civ_funeral_female_body_a");
	self attach("head_f_act_cau_biedermann_fun","",1);
	self.headmodel = "head_f_act_cau_biedermann_fun";
	self.voice = "american";
	self setclothtype("vestlight");
}

//Function Number: 2
precache()
{
	precachemodel("civ_funeral_female_body_a");
	precachemodel("head_f_act_cau_biedermann_fun");
}