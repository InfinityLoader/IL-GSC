/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character_kva_hazmat.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 41 ms
 * Timestamp: 4/22/2024 2:02:15 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("kva_hazmat_body_a");
	self attach("kva_hazmat_head_a","",1);
	self.headmodel = "kva_hazmat_head_a";
	self.voice = "kva";
	self setclothtype("vestlight");
}

//Function Number: 2
precache()
{
	precachemodel("kva_hazmat_body_a");
	precachemodel("kva_hazmat_head_a");
}