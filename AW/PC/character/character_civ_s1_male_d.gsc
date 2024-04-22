/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character_civ_s1_male_d.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 32 ms
 * Timestamp: 4/22/2024 2:01:39 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("civ_urban_male_body_d");
	self attach("head_m_gen_cau_clark","",1);
	self.headmodel = "head_m_gen_cau_clark";
	self.voice = "american";
	self setclothtype("vestlight");
}

//Function Number: 2
precache()
{
	precachemodel("civ_urban_male_body_d");
	precachemodel("head_m_gen_cau_clark");
}