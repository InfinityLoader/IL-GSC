/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_dev.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 9
 * Decompile Time: 171 ms
 * Timestamp: 10/27/2023 1:18:05 AM
*******************************************************************/

//Function Number: 1
func_44DF()
{
}

//Function Number: 2
func_595D()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_00 thread func_8725();
	}
}

//Function Number: 3
showspawnpoint(param_00,param_01,param_02)
{
}

//Function Number: 4
func_8725()
{
}

//Function Number: 5
func_6438()
{
}

//Function Number: 6
func_3D8A()
{
}

//Function Number: 7
func_3D8B()
{
}

//Function Number: 8
devaliengiveplayersmoney()
{
}

//Function Number: 9
func_774B()
{
	var_00 = ["headshot","avenger","execution","longshot","posthumous","double","triple","multi"];
	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		thread maps\mp\gametypes\_rank::func_8E77(100);
		thread maps\mp\gametypes\_rank::func_8E6E(var_00[var_01]);
		wait(2);
	}
}