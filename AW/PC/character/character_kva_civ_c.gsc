/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character_kva_civ_c.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 47 ms
 * Timestamp: 4/22/2024 2:02:15 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("kva_civilian_c");
	self attach("head_m_gen_cau_barton_kva_civ","",1);
	self.headmodel = "head_m_gen_cau_barton_kva_civ";
	self.voice = "kva";
	self setclothtype("vestlight");
}

//Function Number: 2
precache()
{
	precachemodel("kva_civilian_c");
	precachemodel("head_m_gen_cau_barton_kva_civ");
}