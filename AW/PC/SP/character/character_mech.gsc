/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character/character_mech.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 27 ms
 * Timestamp: 10/27/2023 1:57:15 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("npc_exo_armor_base");
	self attach("npc_exo_armor_atlas_head","",1);
	self.headmodel = "npc_exo_armor_atlas_head";
	self.voice = "atlas";
	self setclothtype("vestlight");
}

//Function Number: 2
precache()
{
	precachemodel("npc_exo_armor_base");
	precachemodel("npc_exo_armor_atlas_head");
}