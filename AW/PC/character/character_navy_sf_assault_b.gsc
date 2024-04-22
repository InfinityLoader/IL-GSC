/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character_navy_sf_assault_b.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 39 ms
 * Timestamp: 4/22/2024 2:02:19 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("navy_body_c");
	self attach("head_m_gen_cau_young","",1);
	self.headmodel = "head_m_gen_cau_young";
	self.voice = "sentinel";
	self setclothtype("vestlight");
}

//Function Number: 2
precache()
{
	precachemodel("navy_body_c");
	precachemodel("head_m_gen_cau_young");
}