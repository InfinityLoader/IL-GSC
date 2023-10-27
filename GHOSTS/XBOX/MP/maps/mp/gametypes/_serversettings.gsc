/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_serversettings.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 4
 * Decompile Time: 85 ms
 * Timestamp: 10/27/2023 1:31:32 AM
*******************************************************************/

//Function Number: 1
func_44DF()
{
	level.hostname = getdvar("sv_hostname");
	if(level.hostname == "")
	{
		level.hostname = "CoDHost";
	}

	setdvar("sv_hostname",level.hostname);
	level.allowvote = getdvarint("g_allowvote",1);
	setdvar("g_allowvote",level.allowvote);
	setdvar("ui_allowvote",level.allowvote);
	func_703C(maps\mp\gametypes\_tweakables::func_3C5B("team","fftype"));
	constraingametype(getdvar("g_gametype"));
	for(;;)
	{
		func_872F();
		wait(5);
	}
}

//Function Number: 2
func_872F()
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

	var_02 = maps\mp\gametypes\_tweakables::func_3C5B("team","fftype");
	if(level.friendlyfire != var_02)
	{
		func_703C(var_02);
	}
}

//Function Number: 3
constraingametype(param_00)
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

//Function Number: 4
func_703C(param_00)
{
	level.friendlyfire = param_00;
	setdvar("ui_friendlyfire",param_00);
	setdvar("cg_drawFriendlyHUDGrenades",param_00);
}