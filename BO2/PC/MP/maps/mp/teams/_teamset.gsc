/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\teams\_teamset.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 5 ms
 * Timestamp: 10/27/2023 3:01:08 AM
*******************************************************************/

//Function Number: 1
init()
{
	if(!(IsDefined(game["flagmodels"])))
	{
		game["flagmodels"] = [];
	}

	if(!(IsDefined(game["carry_flagmodels"])))
	{
		game["carry_flagmodels"] = [];
	}

	if(!(IsDefined(game["carry_icon"])))
	{
		game["carry_icon"] = [];
	}

	game["flagmodels"]["neutral"] = "mp_flag_neutral";
}

//Function Number: 2
customteam_init()
{
	if(GetDvar(#"8D1F0A47") != "")
	{
		setdvar("g_TeamName_Allies",GetDvar(#"8D1F0A47"));
	}

	if(GetDvar(#"4C4BAFC2") != "")
	{
		setdvar("g_TeamName_Axis",GetDvar(#"4C4BAFC2"));
	}
}