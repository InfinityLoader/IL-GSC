/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character_sentinel_ie_land.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 41 ms
 * Timestamp: 4/22/2024 2:02:25 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("sentinel_udt_land_body");
	codescripts\character::attachhead("alias_sentinel_udt_heads",xmodelalias\alias_sentinel_udt_heads::main());
	self.voice = "sentinel";
	self setclothtype("vestlight");
}

//Function Number: 2
precache()
{
	precachemodel("sentinel_udt_land_body");
	codescripts\character::precachemodelarray(xmodelalias\alias_sentinel_udt_heads::main());
}