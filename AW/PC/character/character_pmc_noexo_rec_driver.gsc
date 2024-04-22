/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character_pmc_noexo_rec_driver.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 39 ms
 * Timestamp: 4/22/2024 2:02:22 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("atlas_pmc_body_noexo");
	self attach("head_m_gen_cau_young_atlas_pmc","",1);
	self.headmodel = "head_m_gen_cau_young_atlas_pmc";
	self.voice = "atlas";
	self setclothtype("vestlight");
}

//Function Number: 2
precache()
{
	precachemodel("atlas_pmc_body_noexo");
	precachemodel("head_m_gen_cau_young_atlas_pmc");
}