/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: dog\dog_reactions.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 22 ms
 * Timestamp: 4/22/2024 1:58:48 AM
*******************************************************************/

//Function Number: 1
main()
{
	if(isdefined(level.shark_functions))
	{
		if(issubstr(self.model,"shark"))
		{
			self [[ level.shark_functions["reactions"] ]]();
			return;
		}
	}
}