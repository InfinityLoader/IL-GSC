/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\bots\_bots_gametype_assault.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 4
 * Decompile Time: 90 ms
 * Timestamp: 10/27/2023 3:09:13 AM
*******************************************************************/

//Function Number: 1
func_00F9()
{
	func_87A7();
	func_879B();
}

//Function Number: 2
func_87A7()
{
	level.var_19D5["gametype_think"] = ::func_1B25;
}

//Function Number: 3
func_879B()
{
}

//Function Number: 4
func_1B25()
{
	self notify("bot_war_think");
	self endon("bot_war_think");
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	self endon("owner_disconnect");
	for(;;)
	{
		self [[ self.var_6F7F ]]();
		wait 0.05;
	}
}