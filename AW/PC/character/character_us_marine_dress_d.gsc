/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character_us_marine_dress_d.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 38 ms
 * Timestamp: 4/22/2024 2:02:32 AM
*******************************************************************/

//Function Number: 1
main()
{
	codescripts\character::setmodelfromarray(xmodelalias\alias_us_marine_dress_bodies::main());
	self attach("head_m_gen_afr_craig_marines_dress","",1);
	self.headmodel = "head_m_gen_afr_craig_marines_dress";
	self.voice = "sentinel";
	self setclothtype("vestlight");
}

//Function Number: 2
precache()
{
	codescripts\character::precachemodelarray(xmodelalias\alias_us_marine_dress_bodies::main());
	precachemodel("head_m_gen_afr_craig_marines_dress");
}