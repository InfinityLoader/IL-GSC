/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character_us_marine_dress_f.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 39 ms
 * Timestamp: 4/22/2024 2:02:33 AM
*******************************************************************/

//Function Number: 1
main()
{
	codescripts\character::setmodelfromarray(xmodelalias\alias_us_marine_dress_bodies::main());
	self attach("head_m_act_asi_owens_marines_dress","",1);
	self.headmodel = "head_m_act_asi_owens_marines_dress";
	self.voice = "sentinel";
	self setclothtype("vestlight");
}

//Function Number: 2
precache()
{
	codescripts\character::precachemodelarray(xmodelalias\alias_us_marine_dress_bodies::main());
	precachemodel("head_m_act_asi_owens_marines_dress");
}