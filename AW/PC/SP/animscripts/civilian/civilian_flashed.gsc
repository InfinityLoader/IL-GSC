/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\civilian\civilian_flashed.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 44 ms
 * Timestamp: 10/27/2023 1:52:57 AM
*******************************************************************/

//Function Number: 1
get_flashed_anim()
{
	return level.civilianflashedarray[randomint(level.civilianflashedarray.size)];
}

//Function Number: 2
main()
{
	var_00 = maps\_utility::flashbanggettimeleftsec();
	if(var_00 <= 0)
	{
		return;
	}

	animscripts\flashed::flashbangedloop(get_flashed_anim(),var_00);
}