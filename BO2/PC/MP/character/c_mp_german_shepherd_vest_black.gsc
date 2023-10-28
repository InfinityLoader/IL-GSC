/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character\c_mp_german_shepherd_vest_black.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 0 ms
 * Timestamp: 10/28/2023 12:10:19 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("german_shepherd_vest_black");
	self.voice = "american";
	self.skeleton = "base";
}

//Function Number: 2
precache()
{
	precachemodel("german_shepherd_vest_black");
}