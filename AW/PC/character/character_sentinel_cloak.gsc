/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character_sentinel_cloak.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 39 ms
 * Timestamp: 4/22/2024 2:02:24 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("sentinel_covert_body_a");
	self attach("sentinel_covert_head_a","",1);
	self.headmodel = "sentinel_covert_head_a";
	self.voice = "sentinel";
	self setclothtype("vestlight");
}

//Function Number: 2
precache()
{
	precachemodel("sentinel_covert_body_a");
	precachemodel("sentinel_covert_head_a");
}