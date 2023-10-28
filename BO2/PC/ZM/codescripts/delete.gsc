/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: codescripts\delete.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 0 ms
 * Timestamp: 10/28/2023 12:11:15 AM
*******************************************************************/

//Function Number: 1
main()
{
/#
	assert(IsDefined(self));
#/
	wait(0);
	if(IsDefined(self))
	{
/#
		if(IsDefined(self.classname))
		{
			if(self.classname == "trigger_once" || self.classname == "trigger_radius" || self.classname == "trigger_multiple")
			{
				println("");
				println("*** trigger debug: delete.gsc is deleting trigger with ent#: " + self getentitynumber() + " at origin: " + self.origin);
				println("");
			}
		}
#/
		self delete();
	}
}