/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character_hero_knox_sentinel_jetpack.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 47 ms
 * Timestamp: 4/22/2024 2:02:11 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("sentinel_body_c");
	self attach("head_hero_knox_blend","",1);
	self.headmodel = "head_hero_knox_blend";
	self.voice = "xslice";
	self setclothtype("vestlight");
}

//Function Number: 2
precache()
{
	precachemodel("sentinel_body_c");
	precachemodel("head_hero_knox_blend");
}