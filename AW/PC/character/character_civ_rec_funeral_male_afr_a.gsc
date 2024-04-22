/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character_civ_rec_funeral_male_afr_a.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 42 ms
 * Timestamp: 4/22/2024 2:01:32 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("civ_male_body_suit_closed_afr");
	self attach("head_m_gen_afr_bowman","",1);
	self.headmodel = "head_m_gen_afr_bowman";
	self.voice = "american";
	self setclothtype("vestlight");
}

//Function Number: 2
precache()
{
	precachemodel("civ_male_body_suit_closed_afr");
	precachemodel("head_m_gen_afr_bowman");
}