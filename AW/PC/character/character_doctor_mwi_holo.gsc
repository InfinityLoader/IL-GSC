/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character_doctor_mwi_holo.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 48 ms
 * Timestamp: 4/22/2024 2:01:56 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("civ_urban_male_body_f");
	self attach("head_m_gen_cau_shipley_holo","",1);
	self.headmodel = "head_m_gen_cau_shipley_holo";
	self.voice = "atlas";
	self setclothtype("vestlight");
}

//Function Number: 2
precache()
{
	precachemodel("civ_urban_male_body_f");
	precachemodel("head_m_gen_cau_shipley_holo");
}