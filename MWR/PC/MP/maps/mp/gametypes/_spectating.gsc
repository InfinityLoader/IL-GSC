/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_spectating.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 11
 * Decompile Time: 168 ms
 * Timestamp: 10/27/2023 2:42:11 AM
*******************************************************************/

//Function Number: 1
init()
{
	level.spectateoverride["allies"] = spawnstruct();
	level.spectateoverride["axis"] = spawnstruct();
	level thread onplayerconnect();
}

//Function Number: 2
onplayerconnect()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_00 thread onjoinedteam();
		var_00 thread onjoinedspectators();
		var_00 thread onspectatingclient();
	}
}

//Function Number: 3
onjoinedteam()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("joined_team");
		setspectatepermissions();
	}
}

//Function Number: 4
onjoinedspectators()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("joined_spectators");
		setspectatepermissions();
		if(!maps\mp\_utility::invirtuallobby() && self method_842D() || isdefined(self.pers["mlgSpectator"]) && self.pers["mlgSpectator"])
		{
			self method_84FD(1);
			if(game["roundsPlayed"] > 0)
			{
				self setclientomnvar("ui_use_mlg_hud",1);
			}
		}
	}
}

//Function Number: 5
updatemlgicons()
{
	self endon("disconnect");
	if(self method_842D())
	{
		for(;;)
		{
			level waittill("player_spawned",var_00);
			var_01 = var_00.spectatorviewloadout;
			if(isdefined(var_01))
			{
				if(isdefined(var_01.primary))
				{
					self method_852C(var_01.primary);
				}

				if(isdefined(var_01.secondary))
				{
					self method_852C(var_01.secondary);
				}
			}
		}
	}
}

//Function Number: 6
onspectatingclient()
{
	self endon("disconnect");
	thread updatemlgicons();
	for(;;)
	{
		self waittill("spectating_cycle");
		var_00 = self getspectatingplayer();
		if(isdefined(var_00))
		{
			self setcarddisplayslot(var_00,6);
			if(self method_842D())
			{
				updatespectatedloadout(var_00);
			}
		}
	}
}

//Function Number: 7
allowallyteamspectating()
{
	while(!isdefined(level.spectateoverride))
	{
		wait(0.05);
	}

	level.spectateoverride["allies"].allowallyspectate = 1;
	level.spectateoverride["axis"].allowallyspectate = 1;
	updatespectatesettings();
}

//Function Number: 8
updatespectatesettings()
{
	level endon("game_ended");
	for(var_00 = 0;var_00 < level.players.size;var_00++)
	{
		level.players[var_00] setspectatepermissions();
	}
}

//Function Number: 9
setspectatepermissions()
{
	if(level.gameended && gettime() - level.gameendtime >= 2000)
	{
		if(level.multiteambased)
		{
			for(var_00 = 0;var_00 < level.teamnamelist.size;var_00++)
			{
				self allowspectateteam(level.teamnamelist[var_00],0);
			}
		}
		else
		{
			self allowspectateteam("allies",0);
			self allowspectateteam("axis",0);
		}

		self allowspectateteam("freelook",0);
		self allowspectateteam("none",1);
		return;
	}

	var_01 = maps\mp\gametypes\_tweakables::gettweakablevalue("game","spectatetype");
	var_02 = maps\mp\gametypes\_tweakables::gettweakablevalue("game","lockspectatepov");
	var_03 = self.sessionteam;
	if(var_01 == 1)
	{
		var_04 = self.lastgameteamchosen;
		if(isdefined(var_04))
		{
			var_03 = var_04;
		}
	}

	if(self method_842D() && !maps\mp\_utility::invirtuallobby())
	{
		var_01 = 2;
	}

	if(isdefined(level.iszombiegame) && level.iszombiegame)
	{
		var_01 = 1;
	}

	switch(var_01)
	{
		case 0:
			break;

		case 1:
			break;

		case 2:
			break;
	}
}

//Function Number: 10
updatespectatedloadoutweapon(param_00,param_01,param_02,param_03,param_04)
{
	if(isdefined(param_01))
	{
		param_01 = maps\mp\_utility::strip_suffix(param_01,"_mp");
		param_01 = tablelookuprownum("mp/statsTable.csv",4,param_01);
	}

	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	self setclientomnvar(param_00 + "weapon",param_01);
	if(param_03 != "none")
	{
		var_05 = maps\mp\gametypes\_class::attachkitnametoid(param_03);
		self setclientomnvar(param_00 + "attachkit",var_05);
	}
	else
	{
		self setclientomnvar(param_00 + "attachkit",0);
		for(var_06 = 0;var_06 < param_02.size;var_06++)
		{
			var_07 = undefined;
			if(isdefined(param_02[var_06]))
			{
				var_07 = maps\mp\_utility::attachmentmap_tobase(param_02[var_06]);
				var_07 = tablelookuprownum("mp/attachmentTable.csv",3,var_07);
			}

			if(!isdefined(var_07))
			{
				var_07 = 0;
			}

			self setclientomnvar(param_00 + "attachment_" + var_06,var_07);
		}
	}

	if(param_04 != "none" && param_04 != "base")
	{
		var_08 = maps\mp\gametypes\_class::furniturekitnametoid(param_04);
		self setclientomnvar(param_00 + "furniturekit",var_08);
		return;
	}

	self setclientomnvar(param_00 + "furniturekit",0);
}

//Function Number: 11
updatespectatedloadout(param_00)
{
	var_01 = param_00.spectatorviewloadout;
	updatespectatedloadoutweapon("ui_mlg_loadout_primary_",var_01.primary,[var_01.primaryattachment,var_01.primaryattachment2,var_01.primaryattachment3],var_01.primaryattachkit,var_01.primaryfurniturekit);
	updatespectatedloadoutweapon("ui_mlg_loadout_secondary_",var_01.secondary,[var_01.secondaryattachment,var_01.secondaryattachment2],var_01.secondaryattachkit,var_01.secondaryfurniturekit);
	var_02 = var_01.offhand;
	if(isdefined(var_02))
	{
		var_02 = tablelookuprownum("mp/perkTable.csv",1,var_02);
	}

	if(!isdefined(var_02))
	{
		var_02 = 0;
	}

	self setclientomnvar("ui_mlg_loadout_equipment_0",var_02);
	var_03 = var_01.equipment;
	if(isdefined(var_03))
	{
		var_03 = tablelookuprownum("mp/perkTable.csv",1,var_03);
	}

	if(!isdefined(var_03))
	{
		var_03 = 0;
	}

	self setclientomnvar("ui_mlg_loadout_equipment_1",var_03);
	self setclientomnvar("ui_mlg_loadout_equipment_2",-1);
	for(var_04 = 0;var_04 < 3;var_04++)
	{
		var_05 = var_01.perks[var_04];
		if(isdefined(var_05))
		{
			var_05 = tablelookuprownum("mp/perkTable.csv",1,var_05);
		}

		if(!isdefined(var_05))
		{
			var_05 = 0;
		}

		self setclientomnvar("ui_mlg_loadout_perk_" + var_04,var_05);
	}
}