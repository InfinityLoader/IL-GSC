/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character_kva_civ_a.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 42 ms
 * Timestamp: 4/22/2024 2:02:14 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("kva_civilian_a");
	self attach("head_m_act_cau_bedrosian_base","",1);
	self.headmodel = "head_m_act_cau_bedrosian_base";
	self.voice = "kva";
	self setclothtype("vestlight");
}

//Function Number: 2
precache()
{
	precachemodel("kva_civilian_a");
	precachemodel("head_m_act_cau_bedrosian_base");
}