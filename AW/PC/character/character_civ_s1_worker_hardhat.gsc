/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character_civ_s1_worker_hardhat.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 33 ms
 * Timestamp: 4/22/2024 2:01:41 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("civ_worker");
	codescripts\character::attachhead("alias_civ_worker_hardhat_s1_heads",xmodelalias\alias_civ_worker_hardhat_s1_heads::main());
	self.voice = "american";
	self setclothtype("vestlight");
}

//Function Number: 2
precache()
{
	precachemodel("civ_worker");
	codescripts\character::precachemodelarray(xmodelalias\alias_civ_worker_hardhat_s1_heads::main());
}