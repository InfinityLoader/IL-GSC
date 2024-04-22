/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character_civ_s1_male_hostage_lag.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 31 ms
 * Timestamp: 4/22/2024 2:01:40 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("civ_urban_male_body_f");
	self attach("head_m_act_cau_ramsay_base","",1);
	self.headmodel = "head_m_act_cau_ramsay_base";
	self.voice = "american";
	self setclothtype("vestlight");
}

//Function Number: 2
precache()
{
	precachemodel("civ_urban_male_body_f");
	precachemodel("head_m_act_cau_ramsay_base");
}