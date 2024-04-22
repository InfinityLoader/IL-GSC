/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character_civ_s1_male_a.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 33 ms
 * Timestamp: 4/22/2024 2:01:38 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("civ_urban_male_body_a");
	self attach("head_m_act_cau_bedrosian_base","",1);
	self.headmodel = "head_m_act_cau_bedrosian_base";
	self.voice = "american";
	self setclothtype("vestlight");
}

//Function Number: 2
precache()
{
	precachemodel("civ_urban_male_body_a");
	precachemodel("head_m_act_cau_bedrosian_base");
}