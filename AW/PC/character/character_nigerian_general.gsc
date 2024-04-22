/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character_nigerian_general.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 40 ms
 * Timestamp: 4/22/2024 2:02:20 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("nigerian_general_body");
	self attach("nigerian_general_head","",1);
	self.headmodel = "nigerian_general_head";
	self.voice = "african";
	self setclothtype("vestlight");
}

//Function Number: 2
precache()
{
	precachemodel("nigerian_general_body");
	precachemodel("nigerian_general_head");
}