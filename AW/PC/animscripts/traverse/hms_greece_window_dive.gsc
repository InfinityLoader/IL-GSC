/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: traverse\hms_greece_window_dive.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 54 ms
 * Timestamp: 4/22/2024 1:59:21 AM
*******************************************************************/

//Function Number: 1
main()
{
	hms_greece_window_dive();
}

//Function Number: 2
hms_greece_window_dive()
{
	var_00 = [];
	var_00[0] = %hms_greece_alleys_trav_over_40_window_dive;
	var_01 = [];
	var_01["traverseAnim"] = var_00[randomint(var_00.size)];
	thread glass_break();
	animscripts\traverse\shared::dotraverse(var_01);
}

//Function Number: 3
glass_break()
{
	level waittill("glass_break");
	if(isdefined(self))
	{
		glassradiusdamage(self.origin,48,1000,1000);
	}
}