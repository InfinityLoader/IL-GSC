/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes_zm\_scoreboard.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 0 ms
 * Timestamp: 10/28/2023 12:11:38 AM
*******************************************************************/

//Function Number: 1
init()
{
	setdvar("g_ScoresColor_Spectator",".25 .25 .25");
	setdvar("g_ScoresColor_Free",".76 .78 .10");
	setdvar("g_teamColor_MyTeam",".4 .7 .4");
	setdvar("g_teamColor_EnemyTeam","1 .315 0.35");
	setdvar("g_teamColor_MyTeamAlt",".35 1 1");
	setdvar("g_teamColor_EnemyTeamAlt","1 .5 0");
	setdvar("g_teamColor_Squad",".315 0.35 1");
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