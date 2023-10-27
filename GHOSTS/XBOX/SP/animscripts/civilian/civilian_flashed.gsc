/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\civilian\civilian_flashed.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 2
 * Decompile Time: 47 ms
 * Timestamp: 10/27/2023 1:34:26 AM
*******************************************************************/

//Function Number: 1
get_flashed_anim()
{
	return level.var_1C89[randomint(level.var_1C89.size)];
}

//Function Number: 2
func_4FDD()
{
	var_00 = maps\_utility::func_33FB();
	if(var_00 <= 0)
	{
	}

	animscripts/flashed::flashbangedloop(get_flashed_anim(),var_00);
}