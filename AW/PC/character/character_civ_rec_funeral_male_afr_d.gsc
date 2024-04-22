/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character_civ_rec_funeral_male_afr_d.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 31 ms
 * Timestamp: 4/22/2024 2:01:33 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("civ_urban_male_body_f_afr");
	self attach("head_m_gen_afr_rice","",1);
	self.headmodel = "head_m_gen_afr_rice";
	self.voice = "american";
	self setclothtype("vestlight");
}

//Function Number: 2
precache()
{
	precachemodel("civ_urban_male_body_f_afr");
	precachemodel("head_m_gen_afr_rice");
}