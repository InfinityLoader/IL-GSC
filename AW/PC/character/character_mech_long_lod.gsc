/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character_mech_long_lod.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 39 ms
 * Timestamp: 4/22/2024 2:02:18 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("npc_exo_armor_long_lod");
	self attach("npc_exo_armor_atlas_head","",1);
	self.headmodel = "npc_exo_armor_atlas_head";
	self.voice = "atlas";
	self setclothtype("vestlight");
}

//Function Number: 2
precache()
{
	precachemodel("npc_exo_armor_long_lod");
	precachemodel("npc_exo_armor_atlas_head");
}