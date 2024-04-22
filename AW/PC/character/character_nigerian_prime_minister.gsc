/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character_nigerian_prime_minister.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 52 ms
 * Timestamp: 4/22/2024 2:02:20 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("nigerian_prime_minister_body");
	self attach("prime_minister_head","",1);
	self.headmodel = "prime_minister_head";
	self.voice = "african";
	self setclothtype("vestlight");
}

//Function Number: 2
precache()
{
	precachemodel("nigerian_prime_minister_body");
	precachemodel("prime_minister_head");
}