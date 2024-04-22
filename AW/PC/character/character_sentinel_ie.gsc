/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character_sentinel_ie.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 48 ms
 * Timestamp: 4/22/2024 2:02:25 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("sentinel_udt_underwater");
	self.voice = "sentinel";
	self setclothtype("vestlight");
}

//Function Number: 2
precache()
{
	precachemodel("sentinel_udt_underwater");
}