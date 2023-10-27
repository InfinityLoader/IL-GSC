/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\traverse\hms_greece_window_over_40.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 61 ms
 * Timestamp: 10/27/2023 2:42:51 AM
*******************************************************************/

//Function Number: 1
main()
{
	hms_greece_window_over_40();
}

//Function Number: 2
hms_greece_window_over_40()
{
	var_00 = [];
	var_00[0] = %hms_greece_alleys_trav_over_40_window_quick;
	var_00[1] = %hms_greece_alleys_trav_over_40_window_run_01;
	var_00[2] = %hms_greece_alleys_trav_over_40_window_run_02;
	var_00[3] = %hms_greece_alleys_trav_over_40_window_run_03;
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