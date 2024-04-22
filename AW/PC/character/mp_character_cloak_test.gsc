/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp_character_cloak_test.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 40 ms
 * Timestamp: 4/22/2024 2:02:36 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("mp_body_cloak_test");
	self attach("mp_head_cloak_test","",1);
	self.headmodel = "mp_head_cloak_test";
	self setviewmodel("mp_viewhands_cloak_test");
	self.voice = "american";
	self setclothtype("vestlight");
}

//Function Number: 2
precache()
{
	precachemodel("mp_body_cloak_test");
	precachemodel("mp_head_cloak_test");
	precachemodel("mp_viewhands_cloak_test");
}