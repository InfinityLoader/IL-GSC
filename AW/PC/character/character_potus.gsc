/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character_potus.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 43 ms
 * Timestamp: 4/22/2024 2:02:23 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("president_body");
	self attach("head_m_gen_cau_potus_base","",1);
	self.headmodel = "head_m_gen_cau_potus_base";
	self.voice = "sentinel";
	self setclothtype("vestlight");
}

//Function Number: 2
precache()
{
	precachemodel("president_body");
	precachemodel("head_m_gen_cau_potus_base");
}