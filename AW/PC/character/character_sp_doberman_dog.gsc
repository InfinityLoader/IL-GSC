/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character_sp_doberman_dog.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 48 ms
 * Timestamp: 4/22/2024 2:02:27 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("animal_dobernan");
	self.voice = "arab";
	self setclothtype("vestlight");
}

//Function Number: 2
precache()
{
	precachemodel("animal_dobernan");
}