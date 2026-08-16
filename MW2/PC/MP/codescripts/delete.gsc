/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: codescripts\delete.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: PC
*******************************************************************/

main()
{
	wait 0;
	if(isdefined(self))
	{
		self delete();
		return;
	}
}