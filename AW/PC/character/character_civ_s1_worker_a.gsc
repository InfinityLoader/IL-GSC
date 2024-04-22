/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character_civ_s1_worker_a.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 33 ms
 * Timestamp: 4/22/2024 2:01:41 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("civ_worker");
	self attach("head_m_gen_cau_barton","",1);
	self.headmodel = "head_m_gen_cau_barton";
	self.voice = "american";
	self setclothtype("vestlight");
}

//Function Number: 2
precache()
{
	precachemodel("civ_worker");
	precachemodel("head_m_gen_cau_barton");
}