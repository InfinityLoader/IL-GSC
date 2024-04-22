/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character_kva_civ_b.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 40 ms
 * Timestamp: 4/22/2024 2:02:14 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("kva_civilian_b");
	self attach("head_m_gen_cau_young","",1);
	self.headmodel = "head_m_gen_cau_young";
	self.voice = "kva";
	self setclothtype("vestlight");
}

//Function Number: 2
precache()
{
	precachemodel("kva_civilian_b");
	precachemodel("head_m_gen_cau_young");
}