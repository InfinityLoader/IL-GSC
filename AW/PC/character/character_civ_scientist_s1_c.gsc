/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character_civ_scientist_s1_c.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 40 ms
 * Timestamp: 4/22/2024 2:01:42 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("civ_scientist");
	self attach("head_m_gen_cau_barton_hardhat","",1);
	self.headmodel = "head_m_gen_cau_barton_hardhat";
	self.voice = "american";
	self setclothtype("vestlight");
}

//Function Number: 2
precache()
{
	precachemodel("civ_scientist");
	precachemodel("head_m_gen_cau_barton_hardhat");
}