/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps/mp/gametypes/_spectating.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 10
 * Decompile Time: 154 ms
 * Timestamp: 10/27/2023 1:51:06 AM
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
		if(!maps\mp\_utility::invirtuallobby() && self ismlgspectator() || isdefined(self.pers["mlgSpectator"]) && self.pers["mlgSpectator"])
		{
			self setmlgspectator(1);
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
	if(self ismlgspectator())
	{
		for(;;)
		{
			level waittill("player_spawned",var_00);
			var_01 = var_00.spectatorviewloadout;
			if(isdefined(var_01))
			{
				if(isdefined(var_01.primary))
				{
					self precachekillcamiconforweapon(var_01.primary);
				}

				if(isdefined(var_01.secondary))
				{
					self precachekillcamiconforweapon(var_01.secondary);
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
			if(self ismlgspectator())
			{
				updatespectatedloadout(var_00);
			}
		}
	}
}

//Function Number: 7
updatespectatesettings()
{
	level endon("game_ended");
	for(var_00 = 0;var_00 < level.players.size;var_00++)
	{
		level.players[var_00] setspectatepermissions();
	}
}

//Function Number: 8
setspectatepermissions()
{
	var_00 = self.sessionteam;
	if(level.gameended && gettime() - level.gameendtime >= 2000)
	{
		if(level.multiteambased)
		{
			for(var_01 = 0;var_01 < level.teamnamelist.size;var_01++)
			{
				self allowspectateteam(level.teamnamelist[var_01],0);
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

	var_02 = maps\mp\gametypes\_tweakables::gettweakablevalue("game","spectatetype");
	var_03 = maps\mp\gametypes\_tweakables::gettweakablevalue("game","lockspectatepov");
	if(self ismlgspectator() && !maps\mp\_utility::invirtuallobby())
	{
		var_02 = 2;
	}

	if(isdefined(level.iszombiegame) && level.iszombiegame)
	{
		var_02 = 1;
	}

	switch(var_02)
	{
		case 0:
			break;

		case 1:
			break;

		case 2:
			break;
	}
}

//Function Number: 9
updatespectatedloadoutweapon(param_00,param_01,param_02)
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
	for(var_03 = 0;var_03 < param_02.size;var_03++)
	{
		var_04 = undefined;
		if(isdefined(param_02[var_03]))
		{
			var_04 = maps\mp\_utility::attachmentmap_tobase(param_02[var_03]);
			var_04 = tablelookuprownum("mp/attachmentTable.csv",3,var_04);
		}

		if(!isdefined(var_04))
		{
			var_04 = 0;
		}

		self setclientomnvar(param_00 + "attachment_" + var_03,var_04);
	}
}

//Function Number: 10
updatespectatedloadout(param_00)
{
	var_01 = param_00.spectatorviewloadout;
	updatespectatedloadoutweapon("ui_mlg_loadout_primary_",var_01.primary,[var_01.primaryattachment,var_01.primaryattachment2,var_01.primaryattachment3]);
	updatespectatedloadoutweapon("ui_mlg_loadout_secondary_",var_01.secondary,[var_01.secondaryattachment,var_01.secondaryattachment2]);
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
	if(var_01.equipmentextra)
	{
		self setclientomnvar("ui_mlg_loadout_equipment_2",var_03);
	}
	else
	{
		self setclientomnvar("ui_mlg_loadout_equipment_2",-1);
	}

	var_04 = [var_01.killstreak1,var_01.killstreak2,var_01.killstreak3,var_01.killstreak4];
	for(var_05 = 0;var_05 < 4;var_05++)
	{
		var_06 = var_04[var_05];
		if(isdefined(var_06))
		{
			var_06 = tablelookuprownum("mp/killstreakTable.csv",1,var_06);
		}

		if(!isdefined(var_06))
		{
			var_07 = 0;
		}

		self setclientomnvar("ui_mlg_loadout_streak_" + var_05,var_06);
	}

	for(var_05 = 0;var_05 < 6;var_05++)
	{
		var_08 = var_01.perks[var_05];
		if(isdefined(var_08))
		{
			var_08 = tablelookuprownum("mp/perkTable.csv",1,var_08);
		}

		if(!isdefined(var_08))
		{
			var_08 = 0;
		}

		self setclientomnvar("ui_mlg_loadout_perk_" + var_05,var_08);
	}
}