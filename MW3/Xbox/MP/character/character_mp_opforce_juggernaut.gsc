/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character\character_mp_opforce_juggernaut.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 2
 * Decompile Time: 39 ms
 * Timestamp: 10/27/2023 2:28:21 AM
*******************************************************************/

//Function Number: 1
main()
{
	self setmodel("mp_fullbody_opforce_juggernaut");
	self setviewmodel("viewhands_juggernaut_opforce");
	self.voice = "russian";
}

//Function Number: 2
precache()
{
	precachemodel("mp_fullbody_opforce_juggernaut");
	precachemodel("viewhands_juggernaut_opforce");
}