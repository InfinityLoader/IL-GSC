/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character_sf_police_a.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 49 ms
 * Timestamp: 4/22/2024 2:02:26 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("sf_police_body_darkskin");
	self attach("head_m_gen_afr_davis_police","",1);
	self.headmodel = "head_m_gen_afr_davis_police";
	self.voice = "sentinel";
	self setclothtype("vestlight");
}

//Function Number: 2
precache()
{
	precachemodel("sf_police_body_darkskin");
	precachemodel("head_m_gen_afr_davis_police");
}