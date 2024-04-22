/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character_civ_s1_male_e.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 32 ms
 * Timestamp: 4/22/2024 2:01:40 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("civ_urban_male_body_e");
	self attach("head_m_gen_cau_young","",1);
	self.headmodel = "head_m_gen_cau_young";
	self.voice = "american";
	self setclothtype("vestlight");
}

//Function Number: 2
precache()
{
	precachemodel("civ_urban_male_body_e");
	precachemodel("head_m_gen_cau_young");
}