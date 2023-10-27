/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_serversettings.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: PC
 * Function Count: 4
 * Decompile Time: 22 ms
 * Timestamp: 10/27/2023 3:00:13 AM
*******************************************************************/

//Function Number: 1
init()
{
	level.hostname = GetDvar(#"5B0D334C");
	if(level.hostname == "")
	{
		level.hostname = "CoDHost";
	}

	setdvar("sv_hostname",level.hostname);
	setdvar("ui_hostname",level.hostname);
	makedvarserverinfo("ui_hostname","CoDHost");
	level.motd = GetDvar(#"72EC4620");
	if(level.motd == "")
	{
		level.motd = "";
	}

	setdvar("scr_motd",level.motd);
	setdvar("ui_motd",level.motd);
	makedvarserverinfo("ui_motd","");
	level.allowvote = GetDvar(#"67B97008");
	if(level.allowvote == "")
	{
		level.allowvote = "1";
	}

	setdvar("g_allowvote",level.allowvote);
	setdvar("ui_allowvote",level.allowvote);
	makedvarserverinfo("ui_allowvote","1");
	level.allow_teamchange = "0";
	if(sessionmodeisprivate() || !sessionmodeisonlinegame())
	{
		level.allow_teamchange = "1";
	}

	setdvar("ui_allow_teamchange",level.allow_teamchange);
	level.friendlyfire = getgametypesetting("friendlyfiretype");
	setdvar("ui_friendlyfire",level.friendlyfire);
	makedvarserverinfo("ui_friendlyfire","0");
	if(GetDvar(#"A0F97FC5") == "")
	{
		setdvar("scr_mapsize","64");
	}
	else if(GetDvarFloat(#"A0F97FC5") >= 64)
	{
		setdvar("scr_mapsize","64");
	}
	else if(GetDvarFloat(#"A0F97FC5") >= 32)
	{
		setdvar("scr_mapsize","32");
	}
	else if(GetDvarFloat(#"A0F97FC5") >= 16)
	{
		setdvar("scr_mapsize","16");
	}
	else
	{
		setdvar("scr_mapsize","8");
	}

	level.mapsize = GetDvarFloat(#"A0F97FC5");
	constraingametype(GetDvar(#"4F118387"));
	constrainmapsize(level.mapsize);
	for(;;)
	{
		updateserversettings();
		wait(5);
	}
}

//Function Number: 2
updateserversettings()
{
	sv_hostname = GetDvar(#"5B0D334C");
	if(level.hostname != sv_hostname)
	{
		level.hostname = sv_hostname;
		setdvar("ui_hostname",level.hostname);
	}

	scr_motd = GetDvar(#"72EC4620");
	if(level.motd != scr_motd)
	{
		level.motd = scr_motd;
		setdvar("ui_motd",level.motd);
	}

	g_allowvote = GetDvar(#"67B97008");
	if(level.allowvote != g_allowvote)
	{
		level.allowvote = g_allowvote;
		setdvar("ui_allowvote",level.allowvote);
	}

	scr_friendlyfire = getgametypesetting("friendlyfiretype");
	if(level.friendlyfire != scr_friendlyfire)
	{
		level.friendlyfire = scr_friendlyfire;
		setdvar("ui_friendlyfire",level.friendlyfire);
	}
}

//Function Number: 3
constraingametype(gametype)
{
	entities = getentarray();
	for(i = 0;i < entities.size;i++)
	{
		entity = entities[i];
		if(gametype == "dm")
		{
			if(IsDefined(entity.script_gametype_dm) && entity.script_gametype_dm != "1")
			{
				entity delete();
			}
		}
		else if(gametype == "tdm")
		{
			if(IsDefined(entity.script_gametype_tdm) && entity.script_gametype_tdm != "1")
			{
				entity delete();
			}
		}
		else if(gametype == "ctf")
		{
			if(IsDefined(entity.script_gametype_ctf) && entity.script_gametype_ctf != "1")
			{
				entity delete();
			}
		}
		else if(gametype == "hq")
		{
			if(IsDefined(entity.script_gametype_hq) && entity.script_gametype_hq != "1")
			{
				entity delete();
			}
		}
		else if(gametype == "sd")
		{
			if(IsDefined(entity.script_gametype_sd) && entity.script_gametype_sd != "1")
			{
				entity delete();
			}
		}
		else if(gametype == "koth")
		{
			if(IsDefined(entity.script_gametype_koth) && entity.script_gametype_koth != "1")
			{
				entity delete();
			}
		}
	}
}

//Function Number: 4
constrainmapsize(mapsize)
{
	entities = getentarray();
	for(i = 0;i < entities.size;i++)
	{
		entity = entities[i];
		if(int(mapsize) == 8)
		{
			if(IsDefined(entity.script_mapsize_08) && entity.script_mapsize_08 != "1")
			{
				entity delete();
			}
		}
		else if(int(mapsize) == 16)
		{
			if(IsDefined(entity.script_mapsize_16) && entity.script_mapsize_16 != "1")
			{
				entity delete();
			}
		}
		else if(int(mapsize) == 32)
		{
			if(IsDefined(entity.script_mapsize_32) && entity.script_mapsize_32 != "1")
			{
				entity delete();
			}
		}
		else if(int(mapsize) == 64)
		{
			if(IsDefined(entity.script_mapsize_64) && entity.script_mapsize_64 != "1")
			{
				entity delete();
			}
		}
	}
}