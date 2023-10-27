/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character\character_fed_space_assault_a.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 2
 * Decompile Time: 27 ms
 * Timestamp: 10/27/2023 1:38:23 AM
*******************************************************************/

//Function Number: 1
func_4FDD()
{
	codescripts\character::func_7072(xmodelalias/alias_fed_space_assualt_bodies::func_4FDD());
	codescripts\character::attachhead("alias_fed_space_assault_heads",xmodelalias\alias_fed_space_assault_heads::func_4FDD());
	self.voice = "russian";
	self setclothtype("vestlight");
}

//Function Number: 2
func_6101()
{
	codescripts\character::func_6113(xmodelalias/alias_fed_space_assualt_bodies::func_4FDD());
	codescripts\character::func_6113(xmodelalias\alias_fed_space_assault_heads::func_4FDD());
}