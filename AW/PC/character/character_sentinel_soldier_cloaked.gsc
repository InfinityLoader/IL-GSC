/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character_sentinel_soldier_cloaked.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 39 ms
 * Timestamp: 4/22/2024 2:02:25 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("body_sentinel_soldier_cloaked");
	self attach("head_sentinel_soldier_cloaked","",1);
	self.headmodel = "head_sentinel_soldier_cloaked";
	self.voice = "xslice";
	self setclothtype("vestlight");
}

//Function Number: 2
precache()
{
	precachemodel("body_sentinel_soldier_cloaked");
	precachemodel("head_sentinel_soldier_cloaked");
}