/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character_civ_rec_funeral_male_afr_b.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 30 ms
 * Timestamp: 4/22/2024 2:01:32 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("civ_urban_male_body_g_afr");
	self attach("head_m_act_afr_brickerson_base_sunglasses","",1);
	self.headmodel = "head_m_act_afr_brickerson_base_sunglasses";
	self.voice = "american";
	self setclothtype("vestlight");
}

//Function Number: 2
precache()
{
	precachemodel("civ_urban_male_body_g_afr");
	precachemodel("head_m_act_afr_brickerson_base_sunglasses");
}