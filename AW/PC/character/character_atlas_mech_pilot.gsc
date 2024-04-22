/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character_atlas_mech_pilot.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 43 ms
 * Timestamp: 4/22/2024 2:01:18 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("atlas_body_noexo");
	self attach("npc_exo_armor_atlas_head_captured","",1);
	self.headmodel = "npc_exo_armor_atlas_head_captured";
	self.voice = "atlas";
	self setclothtype("vestlight");
}

//Function Number: 2
precache()
{
	precachemodel("atlas_body_noexo");
	precachemodel("npc_exo_armor_atlas_head_captured");
}