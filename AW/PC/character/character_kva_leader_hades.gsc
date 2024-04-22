/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character_kva_leader_hades.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 51 ms
 * Timestamp: 4/22/2024 2:02:16 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("kva_leader_body");
	self attach("kva_leader_head","",1);
	self.headmodel = "kva_leader_head";
	self.voice = "kva";
	self setclothtype("vestlight");
}

//Function Number: 2
precache()
{
	precachemodel("kva_leader_body");
	precachemodel("kva_leader_head");
}