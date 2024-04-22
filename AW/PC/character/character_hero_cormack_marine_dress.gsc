/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character_hero_cormack_marine_dress.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 49 ms
 * Timestamp: 4/22/2024 2:02:01 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("marine_dress_body_a");
	self attach("head_hero_cormack_dress_hat","",1);
	self.headmodel = "head_hero_cormack_dress_hat";
	self.voice = "xslice";
	self setclothtype("vestlight");
}

//Function Number: 2
precache()
{
	precachemodel("marine_dress_body_a");
	precachemodel("head_hero_cormack_dress_hat");
}