/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character\character_us_space_int_b.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 2
 * Decompile Time: 32 ms
 * Timestamp: 10/27/2023 1:38:27 AM
*******************************************************************/

//Function Number: 1
func_4FDD()
{
	self setmodel("body_us_space_int_b");
	codescripts\character::attachhead("alias_us_space_int_heads",xmodelalias\alias_us_space_int_heads::func_4FDD());
	self.voice = "american";
	self setclothtype("cloth");
}

//Function Number: 2
func_6101()
{
	precachemodel("body_us_space_int_b");
	codescripts\character::func_6113(xmodelalias\alias_us_space_int_heads::func_4FDD());
}