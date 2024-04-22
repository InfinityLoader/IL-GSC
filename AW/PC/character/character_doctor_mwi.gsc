/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character_doctor_mwi.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 40 ms
 * Timestamp: 4/22/2024 2:01:55 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("civ_urban_male_body_f");
	self attach("head_m_gen_cau_shipley","",1);
	self.headmodel = "head_m_gen_cau_shipley";
	self.voice = "atlas";
	self setclothtype("vestlight");
}

//Function Number: 2
precache()
{
	precachemodel("civ_urban_male_body_f");
	precachemodel("head_m_gen_cau_shipley");
}