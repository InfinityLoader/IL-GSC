/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_serversettings.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 3
 * Decompile Time: 48 ms
 * Timestamp: 10/27/2023 2:25:50 AM
*******************************************************************/

//Function Number: 1
init()
{
	level.hostname = getdvar("sv_hostname");
	if(level.hostname == "")
	{
		level.hostname = "CoDHost";
	}

	setdvar("sv_hostname",level.hostname);
	level.allowvote = getdvarint("g_allowvote",1);
	setdvar("g_allowvote",level.allowvote);
	makedvarserverinfo("ui_allowvote",level.allowvote);
	level.friendlyfire = maps\mp\gametypes\_tweakables::func_270D("team","fftype");
	makedvarserverinfo("ui_friendlyfire",level.friendlyfire);
	func_2B94(getdvar("g_gametype"));
	for(;;)
	{
		func_2B93();
		wait 5;
	}
}

//Function Number: 2
func_2B93()
{
	var_00 = getdvar("sv_hostname");
	if(level.hostname != var_00)
	{
		level.hostname = var_00;
	}

	var_01 = getdvarint("g_allowvote",1);
	if(level.allowvote != var_01)
	{
		level.allowvote = var_01;
		setdvar("ui_allowvote",level.allowvote);
	}

	var_02 = maps\mp\gametypes\_tweakables::func_270D("team","fftype");
	if(level.friendlyfire != var_02)
	{
		level.friendlyfire = var_02;
		setdvar("ui_friendlyfire",level.friendlyfire);
	}
}

//Function Number: 3
func_2B94(param_00)
{
	var_01 = getentarray();
	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		var_03 = var_01[var_02];
		if(param_00 == "dm")
		{
			if(isdefined(var_03.script_gametype_dm) && var_03.script_gametype_dm != "1")
			{
				var_03 delete();
			}

			continue;
		}

		if(param_00 == "tdm")
		{
			if(isdefined(var_03.script_gametype_tdm) && var_03.script_gametype_tdm != "1")
			{
				var_03 delete();
			}

			continue;
		}

		if(param_00 == "ctf")
		{
			if(isdefined(var_03.script_gametype_ctf) && var_03.script_gametype_ctf != "1")
			{
				var_03 delete();
			}

			continue;
		}

		if(param_00 == "hq")
		{
			if(isdefined(var_03.script_gametype_hq) && var_03.script_gametype_hq != "1")
			{
				var_03 delete();
			}

			continue;
		}

		if(param_00 == "sd")
		{
			if(isdefined(var_03.script_gametype_sd) && var_03.script_gametype_sd != "1")
			{
				var_03 delete();
			}

			continue;
		}

		if(param_00 == "koth")
		{
			if(isdefined(var_03.script_gametype_koth) && var_03.script_gametype_koth != "1")
			{
				var_03 delete();
			}
		}
	}
}