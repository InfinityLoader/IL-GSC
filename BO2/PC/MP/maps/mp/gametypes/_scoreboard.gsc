/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_scoreboard.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 0 ms
 * Timestamp: 10/28/2023 12:10:35 AM
*******************************************************************/

//Function Number: 1
init()
{
	if(level.createfx_enabled)
	{
		return;
	}

	if(sessionmodeiszombiesgame())
	{
		setdvar("g_TeamIcon_Axis","faction_cia");
		setdvar("g_TeamIcon_Allies","faction_cdc");
	}
	else
	{
		setdvar("g_TeamIcon_Axis",game["icons"]["axis"]);
		setdvar("g_TeamIcon_Allies",game["icons"]["allies"]);
	}
}