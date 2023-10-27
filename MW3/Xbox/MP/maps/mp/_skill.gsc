/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\_skill.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 6
 * Decompile Time: 97 ms
 * Timestamp: 10/27/2023 2:28:55 AM
*******************************************************************/

//Function Number: 1
init()
{
	level thread onplayerconnect();
	level thread onplayerdisconnect();
}

//Function Number: 2
onplayerconnect()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_00.var_2BBC = gettime();
		var_00.targets = [];
		var_00 thread func_2BBF();
		var_00 thread ondeath();
	}
}

//Function Number: 3
onplayerdisconnect()
{
	for(;;)
	{
		level waittill("disconnected",var_00);
		var_00.targets = [];
	}
}

//Function Number: 4
func_2BBF()
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
processkill(param_00,param_01)
{
	updateskill(param_00,param_01,"war",1);
}