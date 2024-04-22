/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character_atlas_security_ar.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 33 ms
 * Timestamp: 4/22/2024 2:01:19 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("atlas_security");
	self attach("atlas_security_head_a","",1);
	self.headmodel = "atlas_security_head_a";
	self.voice = "atlas";
	self setclothtype("vestlight");
}

//Function Number: 2
precache()
{
	precachemodel("atlas_security");
	precachemodel("atlas_security_head_a");
}