/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character_civ_rec_funeral_male_cau_a.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 32 ms
 * Timestamp: 4/22/2024 2:01:34 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("civ_male_body_suit_closed");
	self attach("head_m_gen_cau_anderson_sunglasses","",1);
	self.headmodel = "head_m_gen_cau_anderson_sunglasses";
	self.voice = "american";
	self setclothtype("vestlight");
}

//Function Number: 2
precache()
{
	precachemodel("civ_male_body_suit_closed");
	precachemodel("head_m_gen_cau_anderson_sunglasses");
}