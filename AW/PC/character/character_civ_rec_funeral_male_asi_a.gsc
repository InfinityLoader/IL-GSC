/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character_civ_rec_funeral_male_asi_a.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 30 ms
 * Timestamp: 4/22/2024 2:01:33 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("civ_urban_male_body_f");
	self attach("head_m_gen_asi_kang","",1);
	self.headmodel = "head_m_gen_asi_kang";
	self.voice = "american";
	self setclothtype("vestlight");
}

//Function Number: 2
precache()
{
	precachemodel("civ_urban_male_body_f");
	precachemodel("head_m_gen_asi_kang");
}