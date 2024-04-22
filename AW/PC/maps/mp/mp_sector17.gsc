/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\mp_sector17.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 13
 * Decompile Time: 218 ms
 * Timestamp: 4/22/2024 2:18:19 AM
*******************************************************************/

//Function Number: 1
main()
{
	level.callbackstartgametype = ::mpsector17callbackstartgametype;
	maps\mp\mp_sector17_precache::main();
	maps\createart\mp_sector17_art::main();
	maps\mp\mp_sector17_fx::main();
	maps\mp\_load::main();
	maps\mp\mp_sector17_lighting::main();
	maps\mp\mp_sector17_aud::main();
	maps\mp\_compass::setupminimap("compass_map_mp_sector17");
	game["attackers"] = "allies";
	game["defenders"] = "axis";
	level.allow_swimming = 0;
	level thread maps\mp\_water::init();
	level thread runloudspeakers();
	level thread killstreakoverrides();
	level.isoutofboundscustomfunc = ::isoutofboundscustomfunc;
	if(level.nextgen)
	{
		level thread patchcollision();
	}
}

//Function Number: 2
patchcollision()
{
}

//Function Number: 3
mpsector17callbackstartgametype()
{
	maps\mp\gametypes\_gamelogic::callback_startgametype();
	common_scripts\_bcs_location_trigs_dlc::bcs_location_trigs_dlc_init();
}

//Function Number: 4
runloudspeakers()
{
	level endon("game_ended");
	level.sector17voice = "gid";
	if(common_scripts\utility::cointoss())
	{
		level.sector17voice = "cor";
	}

	level.sector17aliases = [];
	level.sector17aliases[level.sector17aliases.size] = "mp_sec17_amb_" + level.sector17voice + "_01";
	level.sector17aliases[level.sector17aliases.size] = "mp_sec17_amb_" + level.sector17voice + "_02";
	level.sector17aliases[level.sector17aliases.size] = "mp_sec17_amb_" + level.sector17voice + "_03";
	level.sector17aliases[level.sector17aliases.size] = "mp_sec17_amb_" + level.sector17voice + "_04";
	level.sector17aliases[level.sector17aliases.size] = "mp_sec17_amb_" + level.sector17voice + "_05";
	level.sector17aliases[level.sector17aliases.size] = "mp_sec17_amb_" + level.sector17voice + "_06";
	level.sector17aliases = common_scripts\utility::array_randomize(level.sector17aliases);
	level.sector17aliasindex = 0;
	level waittill("prematch_done");
	for(;;)
	{
		wait(randomfloatrange(90,120));
		level notify("stopOnPlayerConnectedSector17");
		var_00 = getnextalias();
		var_01 = playloudspeakermessage(var_00);
		if(var_01)
		{
			incrementaliasindex();
		}
	}
}

//Function Number: 5
onplayerconnectedsector17()
{
	level endon("stopOnPlayerConnectedSector17");
	for(;;)
	{
		level waittill("connected",var_00);
		var_00 thread playerdostartmessage();
	}
}

//Function Number: 6
playerdostartmessage()
{
	self endon("disconnect");
	level endon("stopOnPlayerConnectedSector17");
	self waittill("spawned_player");
	self waittill("playLeaderDialogOnPlayer");
	self waittill("playLeaderDialogOnPlayer");
	wait(5);
	thread playerdoloudspeakerannouncement("mp_sec17_amb_" + level.sector17voice + "_07");
}

//Function Number: 7
playloudspeakermessage(param_00)
{
	var_01 = 0;
	param_00 = getnextalias();
	foreach(var_03 in level.players)
	{
		if(isdefined(var_03.leaderdialogactive) && var_03.leaderdialogactive != "")
		{
			continue;
		}

		if(isdefined(var_03.leaderdialogqueue) && var_03.leaderdialogqueue.size > 0)
		{
			continue;
		}

		var_01 = 1;
		var_03 thread playerdoloudspeakerannouncement(param_00);
	}

	return var_01;
}

//Function Number: 8
getnextalias()
{
	return level.sector17aliases[level.sector17aliasindex];
}

//Function Number: 9
incrementaliasindex()
{
	level.sector17aliasindex++;
	if(level.sector17aliasindex >= level.sector17aliases.size)
	{
		level.sector17aliases = common_scripts\utility::array_randomize(level.sector17aliases);
		level.sector17aliasindex = 0;
	}
}

//Function Number: 10
playerdoloudspeakerannouncement(param_00)
{
	self.leaderdialoglocalsound = "scripted";
	self.leaderdialogactive = "scripted";
	self.leaderdialoggroup = "scripted";
	self playlocalsound(param_00);
	wait(5);
	thread restartleaderdialog();
}

//Function Number: 11
restartleaderdialog()
{
	self.leaderdialoglocalsound = "";
	self.leaderdialogactive = "";
	self.leaderdialoggroup = "";
	var_00 = self.pers["team"];
	if(self.leaderdialogqueue.size > 0)
	{
		var_01 = self.leaderdialogqueue[0];
		var_02 = self.leaderdialoglocqueue[0];
		for(var_03 = 1;var_03 < self.leaderdialogqueue.size;var_03++)
		{
			self.leaderdialogqueue[var_03 - 1] = self.leaderdialogqueue[var_03];
		}

		for(var_03 = 1;var_03 < self.leaderdialoglocqueue.size;var_03++)
		{
			self.leaderdialoglocqueue[var_03 - 1] = self.leaderdialoglocqueue[var_03];
		}

		self.leaderdialogqueue[var_03 - 1] = undefined;
		self.leaderdialoglocqueue[var_03 - 1] = undefined;
		thread maps\mp\_utility::leaderdialogonplayer_internal(var_01,var_00,var_02);
	}
}

//Function Number: 12
killstreakoverrides()
{
	if(!isdefined(level.airstrikeoverrides))
	{
		level.airstrikeoverrides = spawnstruct();
	}

	level.airstrikeoverrides.spawnheight = 1400;
}

//Function Number: 13
isoutofboundscustomfunc(param_00,param_01,param_02)
{
	var_03 = 0;
	if(isdefined(param_00.vehicletype) && param_00.vehicletype == "orbital_strike" && isdefined(param_02[0].targetname) && param_02[0].targetname == "remote_heli_range")
	{
		if(param_00.origin[0] < -2496 || param_00.origin[0] > 2416 || param_00.origin[1] < -1640 || param_00.origin[1] > 4272)
		{
			var_03 = 1;
		}
	}
	else
	{
		var_03 = param_00 maps\mp\killstreaks\_aerial_utility::vehicletouchinganytrigger(param_02);
	}

	return var_03;
}