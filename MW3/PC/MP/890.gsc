/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 890.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 6
 * Decompile Time: 0 ms
 * Timestamp: 10/27/2023 2:16:52 AM
*******************************************************************/

//Function Number: 1
init()
{
	level thread onplayerconnect();
	level thread func_3066();
}

//Function Number: 2
onplayerconnect()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_00.var_3064 = gettime();
		var_00.var_3065 = [];
		var_00 thread func_3067();
		var_00 thread ondeath();
	}
}

//Function Number: 3
func_3066()
{
	for(;;)
	{
		level waittill("disconnected",var_00);
		var_00.var_3065 = [];
	}
}

//Function Number: 4
func_3067()
{
	level endon("game_ended");
	self endon("disconnected");
	self waittill("weapon_fired");
}

//Function Number: 5
ondeath()
{
	level endon("game_ended");
	self endon("disconnected");
	self waittill("death");
}

//Function Number: 6
func_3068(param_00,param_01)
{
	updateskill(param_00,param_01,"war",1);
}