/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character\mp_character_cloak_test.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 28 ms
 * Timestamp: 10/27/2023 2:38:38 AM
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