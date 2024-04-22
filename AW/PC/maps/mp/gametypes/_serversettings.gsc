/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\gametypes\_serversettings.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 57 ms
 * Timestamp: 4/22/2024 2:10:16 AM
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
	level.friendlyfire = maps\mp\gametypes\_tweakables::gettweakablevalue("team","fftype");
	constraingametype(getdvar("g_gametype"));
	for(;;)
	{
		updateserversettings();
		wait(5);
	}
}

//Function Number: 2
updateserversettings()
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
	}

	var_02 = maps\mp\gametypes\_tweakables::gettweakablevalue("team","fftype");
	if(level.friendlyfire != var_02)
	{
		level.friendlyfire = var_02;
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

			continue;
		}

		if(param_00 == "atdm")
		{
			if(isdefined(var_03.script_gametype_atdm) && var_03.script_gametype_atdm != "1")
			{
				var_03 delete();
			}
		}
	}
}