/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character_civ_s1_male_c.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 32 ms
 * Timestamp: 4/22/2024 2:01:38 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("civ_urban_male_body_c");
	self attach("head_m_gen_cau_anderson","",1);
	self.headmodel = "head_m_gen_cau_anderson";
	self.voice = "american";
	self setclothtype("vestlight");
}

//Function Number: 2
precache()
{
	precachemodel("civ_urban_male_body_c");
	precachemodel("head_m_gen_cau_anderson");
}