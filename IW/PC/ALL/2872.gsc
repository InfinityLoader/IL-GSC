/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 2872.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 0 ms
 * Timestamp: 10/27/2023 12:24:28 AM
*******************************************************************/

//Function Number: 1
func_9606()
{
	scripts\common\utility::array_thread(getentarray("window_poster","targetname"),::func_13D55);
}

//Function Number: 2
func_13D55()
{
	var_00 = getglass(self.target);
	if(!isdefined(var_00))
	{
		return;
	}

	level waittillmatch(var_00,"glass_destroyed");
	self delete();
}