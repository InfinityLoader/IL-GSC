/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: codescripts\delete.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: Console
 * Function Count: 1
 * Decompile Time: 4 ms
 * Timestamp: 10/27/2023 3:04:04 AM
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
		println("");
		println("*** trigger debug: delete.gsc is deleting trigger with ent#: " + self getentitynumber() + " at origin: " + self.origin);
		println("");
self.classname == "trigger_once" || self.classname == "trigger_radius" || self.classname == "trigger_multiple"
IsDefined(self.classname)
#/
		self delete();
	}
}