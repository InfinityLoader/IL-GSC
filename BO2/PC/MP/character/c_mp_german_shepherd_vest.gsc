/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character\c_mp_german_shepherd_vest.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 2 ms
 * Timestamp: 10/27/2023 2:59:42 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("german_shepherd_vest");
	self.voice = "american";
	self.skeleton = "base";
}

//Function Number: 2
precache()
{
	precachemodel("german_shepherd_vest");
}