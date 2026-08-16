/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: codescripts\struct.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: Xbox
*******************************************************************/

initstructs()
{
	level.struct = [];
}

createstruct()
{
	struct = spawnstruct();
	level.struct[level.struct.size] = struct;
	return struct;
}