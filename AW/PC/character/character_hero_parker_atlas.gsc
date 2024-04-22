/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character_hero_parker_atlas.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 40 ms
 * Timestamp: 4/22/2024 2:02:12 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("atlas_body");
	self attach("head_m_gen_mde_azzam","",1);
	self.headmodel = "head_m_gen_mde_azzam";
	self.voice = "xslice";
	self setclothtype("vestlight");
}

//Function Number: 2
precache()
{
	precachemodel("atlas_body");
	precachemodel("head_m_gen_mde_azzam");
}