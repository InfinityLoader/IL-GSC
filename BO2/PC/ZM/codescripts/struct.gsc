/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: codescripts\struct.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 5 ms
 * Timestamp: 10/27/2023 3:01:59 AM
*******************************************************************/

//Function Number: 1
initstructs()
{
	level.struct = [];
}

//Function Number: 2
createstruct()
{
	struct = spawnstruct();
	level.struct[level.struct.size] = struct;
	return struct;
}

//Function Number: 3
findstruct(position)
{
	foreach(key, _ in level.struct_class_names)
	{
		foreach(s_array in level.struct_class_names[key])
		{
			foreach(struct in s_array)
			{
				if(distancesquared(struct.origin,position) < 1)
				{
					return struct;
				}
			}
		}
	}
}