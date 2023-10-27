/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_battlechatter_mp.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 43
 * Decompile Time: 741 ms
 * Timestamp: 10/27/2023 2:41:03 AM
*******************************************************************/

//Function Number: 1
init()
{
	if(level.multiteambased)
	{
		foreach(var_01 in level.teamnamelist)
		{
			level.isteamspeaking[var_01] = 0;
			level.speakers[var_01] = [];
		}
	}
	else
	{
		level.isteamspeaking["allies"] = 0;
		level.isteamspeaking["axis"] = 0;
		level.speakers["allies"] = [];
		level.speakers["axis"] = [];
	}

	level.bcsounds = [];
	level.bcsounds["reload"] = "inform_reloading_generic";
	level.bcsounds["frag_out"] = "inform_attack_grenade";
	level.bcsounds["flash_out"] = "inform_attack_flashbang";
	level.bcsounds["smoke_out"] = "inform_attack_smoke";
	level.bcsounds["conc_out"] = "inform_attack_stun";
	level.bcsounds["c4_plant"] = "inform_attack_thwc4";
	level.bcsounds["claymore_plant"] = "inform_plant_claymore";
	level.bcsounds["kill"] = "inform_killfirm_infantry";
	level.bcinfo = [];
	foreach(var_05, var_04 in level.speakers)
	{
		level.voice_count[var_05]["m"] = 0;
		level.voice_count[var_05]["fe"] = 0;
	}

	var_06 = getdvar("g_gametype");
	level.istactical = 1;
	if(var_06 == "war" || var_06 == "conf" || var_06 == "dom")
	{
		level.istactical = 0;
	}

	level thread onplayerconnect();
}

//Function Number: 2
onplayerconnect()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_00 thread onplayerspawned();
	}
}

//Function Number: 3
onplayerspawned()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("spawned_player");
		if(maps\mp\_utility::is_true(level.virtuallobbyactive))
		{
			continue;
		}

		self.bcinfo = [];
		var_00 = maps\mp\gametypes\_teams::getteamvoiceprefix(self.team);
		if(!isdefined(self.pers["voiceIndex"]))
		{
			var_01 = 4;
			var_02 = 4;
			var_03 = "m";
			if(!isagent(self) && self hasfemalecustomizationmodel())
			{
				var_03 = "fe";
			}

			self.pers["voiceNum"] = level.voice_count[self.team][var_03] + 1;
			if(var_03 == "fe")
			{
				level.voice_count[self.team][var_03] = level.voice_count[self.team][var_03] + 1 % var_02;
			}
			else
			{
				level.voice_count[self.team][var_03] = level.voice_count[self.team][var_03] + 1 % var_01;
			}

			self.pers["voicePrefix"] = var_00 + self.pers["voiceNum"] + var_03 + "_";
		}

		if(level.splitscreen)
		{
			continue;
		}

		if(!level.teambased)
		{
			continue;
		}

		thread reloadtracking();
		thread grenadetracking();
		thread claymoretracking();
	}
}

//Function Number: 4
reloadtracking()
{
	self endon("death");
	self endon("disconnect");
	self endon("faux_spawn");
	for(;;)
	{
		self waittill("reload_start");
		level thread saylocalsound(self,"reload",0);
	}
}

//Function Number: 5
grenadetracking()
{
	self endon("death");
	self endon("disconnect");
	self endon("faux_spawn");
	for(;;)
	{
		self waittill("grenade_fire",var_00,var_01);
		if(var_01 == "h1_fraggrenade_mp")
		{
			level thread saylocalsound(self,"frag_out",0);
			continue;
		}

		if(var_01 == "h1_flashgrenade_mp")
		{
			level thread saylocalsound(self,"flash_out",0);
			continue;
		}

		if(var_01 == "h1_concussiongrenade_mp")
		{
			level thread saylocalsound(self,"conc_out",0);
			continue;
		}

		if(var_01 == "h1_smokegrenade_mp")
		{
			level thread saylocalsound(self,"smoke_out",0);
			continue;
		}

		if(var_01 == "h1_c4_mp")
		{
			level thread saylocalsound(self,"c4_plant",0);
		}
	}
}

//Function Number: 6
claymoretracking()
{
	self endon("death");
	self endon("disconnect");
	self endon("faux_spawn");
	for(;;)
	{
		self waittill("begin_firing");
		var_00 = self getcurrentweapon();
		if(var_00 == "h1_claymore_mp")
		{
			level thread saylocalsound(self,"claymore_plant",0);
		}
	}
}

//Function Number: 7
saylocalsounddelayed(param_00,param_01,param_02,param_03,param_04)
{
	param_00 endon("death");
	param_00 endon("disconnect");
	wait(param_02);
	if(!isdefined(param_03) && isdefined(0))
	{
		param_03 = 0;
	}

	saylocalsound(param_00,param_01,param_03,param_04);
}

//Function Number: 8
saylocalsound(param_00,param_01,param_02,param_03)
{
	param_00 endon("death");
	param_00 endon("disconnect");
	if(isdefined(level.chatterdisabled) && level.chatterdisabled)
	{
		return;
	}

	if(isdefined(param_00.bcdisabled) && param_00.bcdisabled == 1)
	{
		return;
	}

	if(isspeakerinrange(param_00))
	{
		return;
	}

	if(param_00.team != "spectator")
	{
		var_04 = param_00.pers["voicePrefix"];
		if(isdefined(level.bcsounds[param_01]))
		{
			var_05 = var_04 + level.bcsounds[param_01];
			switch(param_01)
			{
				case "callout_overclock":
				case "callout_cloak":
				case "callout_shield":
				case "callout_hover":
				case "callout_sniper":
					break;
			}
		}
	}
}

//Function Number: 9
dosound(param_00,param_01,param_02)
{
	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	var_03 = self.pers["team"];
	level addspeaker(self,var_03);
	if(param_02 && !level.istactical || !maps\mp\_utility::_hasperk("specialty_coldblooded") && isagent(self) || self issighted())
	{
		if(isagent(self) || level.alivecount[var_03] > 3)
		{
			thread dosounddistant(param_00,var_03);
		}
	}

	if(!soundexists(param_00))
	{
		level removespeaker(self,var_03);
		return;
	}

	if(isagent(self) || isdefined(param_01) && param_01)
	{
		self playsoundtoteam(param_00,var_03);
	}
	else
	{
		self playsoundtoteam(param_00,var_03,self);
	}

	thread timehack(param_00);
	common_scripts\utility::waittill_any(param_00,"death","disconnect");
	level removespeaker(self,var_03);
}

//Function Number: 10
dosounddistant(param_00,param_01)
{
	if(soundexists(param_00))
	{
		foreach(var_03 in level.teamnamelist)
		{
			if(var_03 != param_01)
			{
				self playsoundtoteam(param_00,var_03);
			}
		}
	}
}

//Function Number: 11
dothreatcalloutresponse(param_00,param_01)
{
	var_02 = common_scripts\utility::waittill_any_return(param_00,"death","disconnect");
	if(var_02 == param_00)
	{
		var_03 = self.team;
		if(!isagent(self))
		{
			var_04 = self hasfemalecustomizationmodel();
		}
		else
		{
			var_04 = 0;
		}

		var_05 = self.pers["voiceNum"];
		var_06 = self.origin;
		wait(0.5);
		foreach(var_08 in level.participants)
		{
			if(!isdefined(var_08))
			{
				continue;
			}

			if(var_08 == self)
			{
				continue;
			}

			if(!maps\mp\_utility::isreallyalive(var_08))
			{
				continue;
			}

			if(var_08.team != var_03)
			{
				continue;
			}

			if(!isagent(var_08))
			{
				var_09 = var_08 hasfemalecustomizationmodel();
			}
			else
			{
				var_09 = 0;
			}

			if((var_05 != var_08.pers["voiceNum"] || var_04 != var_09) && distancesquared(var_06,var_08.origin) <= 262144 && !isspeakerinrange(var_08))
			{
				var_0A = var_08.pers["voicePrefix"];
				var_0B = var_0A + "co_loc_" + param_01 + "_echo";
				if(common_scripts\utility::cointoss() && soundexists(var_0B))
				{
					var_0C = var_0B;
				}
				else
				{
					var_0C = var_0B + level.bcsounds["callout_response_generic"];
				}

				var_08 thread dosound(var_0C,0,0);
				break;
			}
		}
	}
}

//Function Number: 12
timehack(param_00)
{
	self endon("death");
	self endon("disconnect");
	wait(2);
	self notify(param_00);
}

//Function Number: 13
isspeakerinrange(param_00,param_01)
{
	param_00 endon("death");
	param_00 endon("disconnect");
	if(!isdefined(param_01))
	{
		param_01 = 1000;
	}

	var_02 = param_01 * param_01;
	if(isdefined(param_00) && isdefined(param_00.team) && param_00.team != "spectator")
	{
		for(var_03 = 0;var_03 < level.speakers[param_00.team].size;var_03++)
		{
			var_04 = level.speakers[param_00.team][var_03];
			if(var_04 == param_00)
			{
				return 1;
			}

			if(!isdefined(var_04))
			{
				continue;
			}

			if(distancesquared(var_04.origin,param_00.origin) < var_02)
			{
				return 1;
			}
		}
	}

	return 0;
}

//Function Number: 14
addspeaker(param_00,param_01)
{
	level.speakers[param_01][level.speakers[param_01].size] = param_00;
}

//Function Number: 15
removespeaker(param_00,param_01)
{
	var_02 = [];
	for(var_03 = 0;var_03 < level.speakers[param_01].size;var_03++)
	{
		if(level.speakers[param_01][var_03] == param_00)
		{
			continue;
		}

		var_02[var_02.size] = level.speakers[param_01][var_03];
	}

	level.speakers[param_01] = var_02;
}

//Function Number: 16
disablebattlechatter(param_00)
{
	param_00.bcdisabled = 1;
}

//Function Number: 17
enablebattlechatter(param_00)
{
	param_00.bcdisabled = undefined;
}

//Function Number: 18
updatechatter(param_00)
{
	var_01 = self.pers["team"];
	self.bcinfo["last_say_time"][param_00] = gettime();
	level.bcinfo["last_say_time"][var_01][param_00] = gettime();
	level.bcinfo["last_say_pos"][var_01][param_00] = self.origin;
}

//Function Number: 19
getlocation()
{
	var_00 = get_all_my_locations();
	var_00 = common_scripts\utility::array_randomize(var_00);
	if(var_00.size)
	{
		foreach(var_02 in var_00)
		{
			if(!location_called_out_ever(var_02))
			{
				return var_02;
			}
		}

		foreach(var_02 in var_00)
		{
			if(!location_called_out_recently(var_02))
			{
				return var_02;
			}
		}
	}

	return undefined;
}

//Function Number: 20
getvalidlocation(param_00)
{
	var_01 = get_all_my_locations();
	var_01 = common_scripts\utility::array_randomize(var_01);
	if(var_01.size)
	{
		foreach(var_03 in var_01)
		{
			if(!location_called_out_ever(var_03) && param_00 cancalloutlocation(var_03))
			{
				return var_03;
			}
		}

		foreach(var_03 in var_01)
		{
			if(!location_called_out_recently(var_03) && param_00 cancalloutlocation(var_03))
			{
				return var_03;
			}
		}
	}

	return undefined;
}

//Function Number: 21
get_all_my_locations()
{
	var_00 = level.bcs_locations;
	var_01 = self getistouchingentities(var_00);
	var_02 = [];
	foreach(var_04 in var_01)
	{
		if(isdefined(var_04.locationaliases))
		{
			var_02[var_02.size] = var_04;
		}
	}

	return var_02;
}

//Function Number: 22
update_bcs_locations()
{
	if(isdefined(level.bcs_locations))
	{
		anim.bcs_locations = common_scripts\utility::array_removeundefined(level.bcs_locations);
	}
}

//Function Number: 23
is_in_callable_location()
{
	var_00 = get_all_my_locations();
	foreach(var_02 in var_00)
	{
		if(!location_called_out_recently(var_02))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 24
location_called_out_ever(param_00)
{
	var_01 = location_get_last_callout_time(param_00.locationaliases[0]);
	if(!isdefined(var_01))
	{
		return 0;
	}

	return 1;
}

//Function Number: 25
location_called_out_recently(param_00)
{
	var_01 = location_get_last_callout_time(param_00.locationaliases[0]);
	if(!isdefined(var_01))
	{
		return 0;
	}

	var_02 = var_01 + 25000;
	if(gettime() < var_02)
	{
		return 1;
	}

	return 0;
}

//Function Number: 26
location_add_last_callout_time(param_00)
{
	level.locationlastcallouttimes[param_00] = gettime();
}

//Function Number: 27
location_get_last_callout_time(param_00)
{
	if(isdefined(level.locationlastcallouttimes[param_00]))
	{
		return level.locationlastcallouttimes[param_00];
	}

	return undefined;
}

//Function Number: 28
cancalloutlocation(param_00)
{
	foreach(var_02 in param_00.locationaliases)
	{
		var_03 = getloccalloutalias("co_loc_" + var_02);
		var_04 = getqacalloutalias(var_02,0);
		var_05 = getloccalloutalias("concat_loc_" + var_02);
		var_06 = soundexists(var_03) || soundexists(var_04) || soundexists(var_05);
		if(var_06)
		{
			return var_06;
		}
	}

	return 0;
}

//Function Number: 29
canconcat(param_00)
{
	var_01 = param_00.locationaliases;
	foreach(var_03 in var_01)
	{
		if(iscallouttypeconcat(var_03,self))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 30
getcannedresponse(param_00)
{
	var_01 = undefined;
	var_02 = self.locationaliases;
	foreach(var_04 in var_02)
	{
		if(iscallouttypeqa(var_04,param_00) && !isdefined(self.qafinished))
		{
			var_01 = var_04;
			break;
		}

		if(iscallouttypereport(var_04))
		{
			var_01 = var_04;
		}
	}

	return var_01;
}

//Function Number: 31
iscallouttypereport(param_00)
{
	return issubstr(param_00,"_report");
}

//Function Number: 32
iscallouttypeconcat(param_00,param_01)
{
	var_02 = param_01 getloccalloutalias("concat_loc_" + param_00);
	if(soundexists(var_02))
	{
		return 1;
	}

	return 0;
}

//Function Number: 33
iscallouttypeqa(param_00,param_01)
{
	if(issubstr(param_00,"_qa") && soundexists(param_00))
	{
		return 1;
	}

	var_02 = param_01 getqacalloutalias(param_00,0);
	if(soundexists(var_02))
	{
		return 1;
	}

	return 0;
}

//Function Number: 34
getloccalloutalias(param_00)
{
	var_01 = self.pers["voicePrefix"] + param_00;
	return var_01;
}

//Function Number: 35
getqacalloutalias(param_00,param_01)
{
	var_02 = getloccalloutalias(param_00);
	var_02 = var_02 + "_qa" + param_01;
	return var_02;
}

//Function Number: 36
battlechatter_canprint()
{
	return 0;
}

//Function Number: 37
battlechatter_canprintdump()
{
	return 0;
}

//Function Number: 38
battlechatter_print(param_00)
{
}

//Function Number: 39
battlechatter_printdump(param_00)
{
}

//Function Number: 40
battlechatter_debugprint(param_00)
{
}

//Function Number: 41
getaliastypefromsoundalias(param_00)
{
}

//Function Number: 42
battlechatter_printdumpline(param_00,param_01,param_02)
{
}

//Function Number: 43
friendly_nearby(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 262144;
	}

	foreach(var_02 in level.players)
	{
		if(var_02.team == self.pers["team"])
		{
			if(var_02 != self && distancesquared(var_02.origin,self.origin) <= param_00)
			{
				return 1;
			}
		}
	}

	return 0;
}