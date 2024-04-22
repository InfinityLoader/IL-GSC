/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character_civ_rec_funeral_female_wife.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 30 ms
 * Timestamp: 4/22/2024 2:01:31 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("civ_funeral_female_irons_body");
	self attach("head_f_act_cau_atias_funeral","",1);
	self.headmodel = "head_f_act_cau_atias_funeral";
	self.voice = "american";
	self setclothtype("vestlight");
}

//Function Number: 2
precache()
{
	precachemodel("civ_funeral_female_irons_body");
	precachemodel("head_f_act_cau_atias_funeral");
}