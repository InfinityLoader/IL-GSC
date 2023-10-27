/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_battlechatter_mp.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 54
 * Decompile Time: 985 ms
 * Timestamp: 10/27/2023 1:17:52 AM
*******************************************************************/

//Function Number: 1
func_44DF()
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
	level.bcsounds["semtex_out"] = "semtex_use";
	level.bcsounds["kill"] = "inform_killfirm_infantry";
	level.bcsounds["casualty"] = "reaction_casualty_generic";
	level.bcsounds["suppressing_fire"] = "cmd_suppressfire";
	level.bcsounds["moving"] = "order_move_combat";
	level.bcsounds["callout_generic"] = "threat_infantry_generic";
	level.bcsounds["callout_response_generic"] = "response_ack_yes";
	level.bcsounds["damage"] = "inform_taking_fire";
	level.bcsounds["semtex_incoming"] = "semtex_incoming";
	level.bcsounds["c4_incoming"] = "c4_incoming";
	level.bcsounds["flash_incoming"] = "flash_incoming";
	level.bcsounds["stun_incoming"] = "stun_incoming";
	level.bcsounds["grenade_incoming"] = "grenade_incoming";
	level.bcsounds["rpg_incoming"] = "rpg_incoming";
	level.bcinfo = [];
	level.bcinfo["timeout"]["suppressing_fire"] = 5000;
	level.bcinfo["timeout"]["moving"] = -20536;
	level.bcinfo["timeout"]["callout_generic"] = 15000;
	level.bcinfo["timeout"]["callout_location"] = 3000;
	level.bcinfo["timeout_player"]["suppressing_fire"] = 10000;
	level.bcinfo["timeout_player"]["moving"] = 120000;
	level.bcinfo["timeout_player"]["callout_generic"] = 5000;
	level.bcinfo["timeout_player"]["callout_location"] = 5000;
	foreach(var_05, var_04 in level.speakers)
	{
		level.bcinfo["last_say_time"][var_05]["suppressing_fire"] = -99999;
		level.bcinfo["last_say_time"][var_05]["moving"] = -99999;
		level.bcinfo["last_say_time"][var_05]["callout_generic"] = -99999;
		level.bcinfo["last_say_time"][var_05]["callout_location"] = -99999;
		level.bcinfo["last_say_pos"][var_05]["suppressing_fire"] = (0,0,-9000);
		level.bcinfo["last_say_pos"][var_05]["moving"] = (0,0,-9000);
		level.bcinfo["last_say_pos"][var_05]["callout_generic"] = (0,0,-9000);
		level.bcinfo["last_say_pos"][var_05]["callout_location"] = (0,0,-9000);
		level.voice_count[var_05][""] = 0;
		level.voice_count[var_05]["w"] = 0;
	}

	common_scripts\_bcs_location_trigs::bcs_location_trigs_init();
	var_06 = getdvar("g_gametype");
	level.istactical = 1;
	if(var_06 == "war" || var_06 == "kc" || var_06 == "dom")
	{
		level.istactical = 0;
	}

	level thread func_595D();
}

//Function Number: 2
func_595D()
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
		self.bcinfo = [];
		self.bcinfo["last_say_time"]["suppressing_fire"] = -99999;
		self.bcinfo["last_say_time"]["moving"] = -99999;
		self.bcinfo["last_say_time"]["callout_generic"] = -99999;
		self.bcinfo["last_say_time"]["callout_location"] = -99999;
		var_00 = maps\mp\gametypes\_teams::getteamvoiceprefix(self.team);
		var_01 = "";
		if(!isagent(self) && self hasfemalecustomizationmodel())
		{
			var_01 = "w";
		}

		self.pers["voiceNum"] = level.voice_count[self.team][var_01];
		level.voice_count[self.team][var_01] = level.voice_count[self.team][var_01] + 1 % 3;
		self.pers["voicePrefix"] = var_00 + var_01 + self.pers["voiceNum"] + "_";
		if(level.splitscreen)
		{
			continue;
		}

		if(!level.teambased)
		{
			continue;
		}

		thread claymoretracking();
		thread func_648F();
		thread grenadetracking();
		thread func_3DB5();
		thread suppressingfiretracking();
		thread casualtytracking();
		thread func_231A();
		thread func_7984();
		thread threatcallouttracking();
	}
}

//Function Number: 4
func_3DB5()
{
	self endon("disconnect");
	self endon("death");
	var_00 = self.origin;
	var_01 = 147456;
	for(;;)
	{
		var_02 = common_scripts\utility::func_803F(isdefined(level.grenades),level.grenades,[]);
		var_03 = common_scripts\utility::func_803F(isdefined(level.missiles),level.missiles,[]);
		if(var_02.size + var_03.size < 1 || !maps\mp\_utility::func_4945(self))
		{
			wait(0.05);
			continue;
		}

		var_02 = common_scripts\utility::array_combine(var_02,var_03);
		foreach(var_05 in var_02)
		{
			wait(0.05);
			if(!isdefined(var_05))
			{
				continue;
			}

			if(isdefined(var_05.weapon_name))
			{
				switch(var_05.weapon_name)
				{
					case "proximity_explosive_mp":
					case "smoke_grenade_mp":
					case "motion_sensor_mp":
					case "trophy_mp":
					case "throwingknife_mp":
						break;
				}

				if(weaponinventorytype(var_05.weapon_name) != "offhand" && weaponclass(var_05.weapon_name) == "grenade")
				{
					continue;
				}

				if(!isdefined(var_05.owner))
				{
					var_05.owner = getmissileowner(var_05);
				}

				if(isdefined(var_05.owner) && level.teambased && var_05.owner.team == self.team)
				{
					continue;
				}

				var_06 = distancesquared(var_05.origin,self.origin);
				if(var_06 < var_01)
				{
					if(common_scripts\utility::func_1DE9())
					{
						wait(5);
						continue;
					}

					if(bullettracepassed(var_05.origin,self.origin,0,self))
					{
						if(var_05.weapon_name == "concussion_grenade_mp")
						{
							level thread func_6AB3(self,"stun_incoming");
							wait(5);
							continue;
						}

						if(var_05.weapon_name == "flash_grenade_mp")
						{
							level thread func_6AB3(self,"flash_incoming");
							wait(5);
							continue;
						}

						if(weaponclass(var_05.weapon_name) == "rocketlauncher")
						{
							level thread func_6AB3(self,"rpg_incoming");
							wait(5);
							continue;
						}

						if(var_05.weapon_name == "c4_mp")
						{
							level thread func_6AB3(self,"c4_incoming");
							wait(5);
							continue;
						}

						if(var_05.weapon_name == "semtex_mp")
						{
							level thread func_6AB3(self,"semtex_incoming");
							wait(5);
							continue;
						}

						level thread func_6AB3(self,"grenade_incoming");
						wait(5);
					}
				}
			}
		}
	}
}

//Function Number: 5
suppressingfiretracking()
{
	self endon("death");
	self endon("disconnect");
	self endon("faux_spawn");
	var_00 = undefined;
	for(;;)
	{
		self waittill("begin_firing");
		thread func_7D6D();
		thread func_7D6C();
		self waittill("stoppedFiring");
	}
}

//Function Number: 6
func_7D6C()
{
	thread func_8B1D();
	self endon("begin_firing");
	self waittill("end_firing");
	wait(0.3);
	self notify("stoppedFiring");
}

//Function Number: 7
func_8B1D()
{
	self endon("stoppedFiring");
	self waittill("begin_firing");
	thread func_7D6C();
}

//Function Number: 8
func_7D6D()
{
	self notify("suppressWaiter");
	self endon("suppressWaiter");
	self endon("death");
	self endon("disconnect");
	self endon("stoppedFiring");
	wait(1);
	if(func_19F2("suppressing_fire"))
	{
		level thread func_6AB3(self,"suppressing_fire");
	}
}

//Function Number: 9
claymoretracking()
{
	self endon("death");
	self endon("disconnect");
	self endon("faux_spawn");
	for(;;)
	{
		self waittill("begin_firing");
		var_00 = self getcurrentweapon();
		if(var_00 == "claymore_mp")
		{
			level thread func_6AB3(self,"claymore_plant");
		}
	}
}

//Function Number: 10
func_648F()
{
	self endon("death");
	self endon("disconnect");
	self endon("faux_spawn");
	for(;;)
	{
		self waittill("reload_start");
		level thread func_6AB3(self,"reload");
	}
}

//Function Number: 11
grenadetracking()
{
	self endon("death");
	self endon("disconnect");
	self endon("faux_spawn");
	for(;;)
	{
		self waittill("grenade_fire",var_00,var_01);
		if(var_01 == "frag_grenade_mp")
		{
			level thread func_6AB3(self,"frag_out");
			continue;
		}

		if(var_01 == "semtex_mp")
		{
			level thread func_6AB3(self,"semtex_out");
			continue;
		}

		if(var_01 == "flash_grenade_mp")
		{
			level thread func_6AB3(self,"flash_out");
			continue;
		}

		if(var_01 == "concussion_grenade_mp")
		{
			level thread func_6AB3(self,"conc_out");
			continue;
		}

		if(var_01 == "smoke_grenade_mp")
		{
			level thread func_6AB3(self,"smoke_out");
			continue;
		}

		if(var_01 == "c4_mp")
		{
			level thread func_6AB3(self,"c4_plant");
		}
	}
}

//Function Number: 12
func_7984()
{
	self endon("death");
	self endon("disconnect");
	self endon("faux_spawn");
	for(;;)
	{
		self waittill("sprint_begin");
		if(func_19F2("moving"))
		{
			level thread func_6AB3(self,"moving",0,0);
		}
	}
}

//Function Number: 13
func_231A()
{
	self endon("death");
	self endon("disconnect");
	self endon("faux_spawn");
	for(;;)
	{
		self waittill("damage",var_00,var_01);
		if(!isdefined(var_01))
		{
			continue;
		}

		if(!isdefined(var_01.classname))
		{
			continue;
		}

		if(var_01 != self && var_01.classname != "worldspawn")
		{
			wait(1.5);
			level thread func_6AB3(self,"damage");
			wait(3);
		}
	}
}

//Function Number: 14
casualtytracking()
{
	self endon("disconnect");
	self endon("faux_spawn");
	self waittill("death");
	foreach(var_01 in level.participants)
	{
		if(!isdefined(var_01))
		{
			continue;
		}

		if(var_01 == self)
		{
			continue;
		}

		if(!maps\mp\_utility::func_4945(var_01))
		{
			continue;
		}

		if(var_01.team != self.team)
		{
			continue;
		}

		if(distancesquared(self.origin,var_01.origin) <= 262144)
		{
			level thread saylocalsounddelayed(var_01,"casualty",0.75);
			break;
		}
	}
}

//Function Number: 15
threatcallouttracking()
{
	self endon("death");
	self endon("disconnect");
	self endon("faux_spawn");
	for(;;)
	{
		self waittill("enemy_sighted");
		if(getomnvar("ui_prematch_period"))
		{
			level waittill("prematch_over");
			continue;
		}

		if(!func_19F2("callout_location") && !func_19F2("callout_generic"))
		{
			continue;
		}

		var_00 = self getsightedplayers();
		if(!isdefined(var_00))
		{
			continue;
		}

		var_01 = 0;
		var_02 = 4000000;
		if(self playerads() > 0.7)
		{
			var_02 = 6250000;
		}

		foreach(var_04 in var_00)
		{
			if(isdefined(var_04) && maps\mp\_utility::func_4945(var_04) && !var_04 maps\mp\_utility::_hasperk("specialty_coldblooded") && distancesquared(self.origin,var_04.origin) < var_02)
			{
				var_05 = var_04 func_3C62(self);
				var_01 = 1;
				if(isdefined(var_05) && func_19F2("callout_location") && friendly_nearby(4840000))
				{
					if(maps\mp\_utility::_hasperk("specialty_quieter") || !friendly_nearby(262144))
					{
						level thread func_6AB3(self,var_05.locationaliases[0],0);
					}
					else
					{
						level thread func_6AB3(self,var_05.locationaliases[0],1);
					}

					break;
				}
			}
		}

		if(var_01 && func_19F2("callout_generic"))
		{
			level thread func_6AB3(self,"callout_generic");
		}
	}
}

//Function Number: 16
saylocalsounddelayed(param_00,param_01,param_02,param_03,param_04)
{
	param_00 endon("death");
	param_00 endon("disconnect");
	wait(param_02);
	func_6AB3(param_00,param_01,param_03,param_04);
}

//Function Number: 17
func_6AB3(param_00,param_01,param_02,param_03)
{
	param_00 endon("death");
	param_00 endon("disconnect");
	if(isdefined(param_00.bcdisabled) && param_00.bcdisabled == 1)
	{
	}

	if(isspeakerinrange(param_00))
	{
	}

	if(param_00.team != "spectator")
	{
		var_04 = param_00.pers["voicePrefix"];
		if(isdefined(level.bcsounds[param_01]))
		{
			var_05 = var_04 + level.bcsounds[param_01];
		}
		else
		{
			location_add_last_callout_time(param_02);
			var_05 = var_05 + "co_loc_" + param_02;
			param_00 thread func_2A1D(var_05,param_01);
			param_01 = "callout_location";
		}

		param_00 func_86D6(param_01);
		param_00 thread func_2A0F(var_05,param_02,param_03);
	}
}

//Function Number: 18
func_2A0F(param_00,param_01,param_02)
{
	if(!isdefined(param_02))
	{
		param_02 = 1;
	}

	var_03 = self.pers["team"];
	level addspeaker(self,var_03);
	var_04 = !level.istactical || !maps\mp\_utility::_hasperk("specialty_coldblooded") && isagent(self) || self issighted();
	if(param_02 && var_04)
	{
		if(isagent(self) || level.alivecount[var_03] > 3)
		{
			thread dosounddistant(param_00,var_03);
		}
	}

	if(isagent(self) || isdefined(param_01) && param_01)
	{
		self playsoundtoteam(param_00,var_03);
	}
	else
	{
		self playsoundtoteam(param_00,var_03,self);
	}

	thread func_811C(param_00);
	common_scripts\utility::func_8B2A(param_00,"death","disconnect");
	level func_65B1(self,var_03);
}

//Function Number: 19
dosounddistant(param_00,param_01)
{
	var_02 = spawn("script_origin",self.origin + (0,0,256));
	var_03 = param_00 + "_n";
	if(soundexists(var_03))
	{
		foreach(var_05 in level.teamnamelist)
		{
			if(var_05 != param_01)
			{
				var_02 playsoundtoteam(var_03,var_05);
			}
		}
	}

	wait(3);
	var_02 delete();
}

//Function Number: 20
func_2A1D(param_00,param_01)
{
	var_02 = common_scripts\utility::func_8B33(param_00,"death","disconnect");
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

			if(!maps\mp\_utility::func_4945(var_08))
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

			if(isdefined(var_08.pers["voiceNum"]) && var_05 != var_08.pers["voiceNum"] || var_04 != var_09 && distancesquared(var_06,var_08.origin) <= 262144 && !isspeakerinrange(var_08))
			{
				var_0A = var_08.pers["voicePrefix"];
				var_0B = var_0A + "co_loc_" + param_01 + "_echo";
				if(soundexists(var_0B) && common_scripts\utility::func_1DE9())
				{
					var_0C = var_0B;
				}
				else
				{
					var_0C = var_0B + level.bcsounds["callout_response_generic"];
				}

				var_08 thread func_2A0F(var_0C,0,1);
				break;
			}
		}
	}
}

//Function Number: 21
func_811C(param_00)
{
	self endon("death");
	self endon("disconnect");
	wait(2);
	self notify(param_00);
}

//Function Number: 22
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

//Function Number: 23
addspeaker(param_00,param_01)
{
	level.speakers[param_01][level.speakers[param_01].size] = param_00;
}

//Function Number: 24
func_65B1(param_00,param_01)
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

//Function Number: 25
disablebattlechatter(param_00)
{
	param_00.bcdisabled = 1;
}

//Function Number: 26
func_2CE1(param_00)
{
	param_00.bcdisabled = undefined;
}

//Function Number: 27
func_19F2(param_00)
{
	var_01 = self.pers["team"];
	if(var_01 == "spectator")
	{
		return 0;
	}

	var_02 = level.bcinfo["timeout_player"][param_00];
	var_03 = gettime() - self.bcinfo["last_say_time"][param_00];
	if(var_02 > var_03)
	{
		return 0;
	}

	var_02 = level.bcinfo["timeout"][param_00];
	var_03 = gettime() - level.bcinfo["last_say_time"][var_01][param_00];
	if(var_02 < var_03)
	{
		return 1;
	}

	return 0;
}

//Function Number: 28
func_86D6(param_00)
{
	var_01 = self.pers["team"];
	self.bcinfo["last_say_time"][param_00] = gettime();
	level.bcinfo["last_say_time"][var_01][param_00] = gettime();
	level.bcinfo["last_say_pos"][var_01][param_00] = self.origin;
}

//Function Number: 29
func_86FA(param_00)
{
}

//Function Number: 30
getlocation()
{
	var_00 = func_37BF();
	var_00 = common_scripts\utility::array_randomize(var_00);
	if(var_00.size)
	{
		foreach(var_02 in var_00)
		{
			if(!func_4EBC(var_02))
			{
				return var_02;
			}
		}

		foreach(var_02 in var_00)
		{
			if(!func_4EBD(var_02))
			{
				return var_02;
			}
		}
	}

	return undefined;
}

//Function Number: 31
func_3C62(param_00)
{
	var_01 = func_37BF();
	var_01 = common_scripts\utility::array_randomize(var_01);
	if(var_01.size)
	{
		foreach(var_03 in var_01)
		{
			if(!func_4EBC(var_03) && param_00 cancalloutlocation(var_03))
			{
				return var_03;
			}
		}

		foreach(var_03 in var_01)
		{
			if(!func_4EBD(var_03) && param_00 cancalloutlocation(var_03))
			{
				return var_03;
			}
		}
	}

	return undefined;
}

//Function Number: 32
func_37BF()
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

//Function Number: 33
func_8662()
{
	if(isdefined(level.bcs_locations))
	{
		anim.bcs_locations = common_scripts\utility::array_removeundefined(level.bcs_locations);
	}
}

//Function Number: 34
func_4804()
{
	var_00 = func_37BF();
	foreach(var_02 in var_00)
	{
		if(!func_4EBD(var_02))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 35
func_4EBC(param_00)
{
	var_01 = func_4EBF(param_00.locationaliases[0]);
	if(!isdefined(var_01))
	{
		return 0;
	}

	return 1;
}

//Function Number: 36
func_4EBD(param_00)
{
	var_01 = func_4EBF(param_00.locationaliases[0]);
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

//Function Number: 37
location_add_last_callout_time(param_00)
{
	level.locationlastcallouttimes[param_00] = gettime();
}

//Function Number: 38
func_4EBF(param_00)
{
	if(isdefined(level.locationlastcallouttimes[param_00]))
	{
		return level.locationlastcallouttimes[param_00];
	}

	return undefined;
}

//Function Number: 39
cancalloutlocation(param_00)
{
	foreach(var_02 in param_00.locationaliases)
	{
		var_03 = getloccalloutalias("co_loc_" + var_02);
		var_04 = func_3BAB(var_02,0);
		var_05 = getloccalloutalias("concat_loc_" + var_02);
		var_06 = soundexists(var_03) || soundexists(var_04) || soundexists(var_05);
		if(var_06)
		{
			return var_06;
		}
	}

	return 0;
}

//Function Number: 40
func_19AF(param_00)
{
	var_01 = param_00.locationaliases;
	foreach(var_03 in var_01)
	{
		if(func_4891(var_03,self))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 41
func_3A49(param_00)
{
	var_01 = undefined;
	var_02 = self.locationaliases;
	foreach(var_04 in var_02)
	{
		if(func_4892(var_04,param_00) && !isdefined(self.qafinished))
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

//Function Number: 42
iscallouttypereport(param_00)
{
	return issubstr(param_00,"_report");
}

//Function Number: 43
func_4891(param_00,param_01)
{
	var_02 = param_01 getloccalloutalias("concat_loc_" + param_00);
	if(soundexists(var_02))
	{
		return 1;
	}

	return 0;
}

//Function Number: 44
func_4892(param_00,param_01)
{
	if(issubstr(param_00,"_qa") && soundexists(param_00))
	{
		return 1;
	}

	var_02 = param_01 func_3BAB(param_00,0);
	if(soundexists(var_02))
	{
		return 1;
	}

	return 0;
}

//Function Number: 45
getloccalloutalias(param_00)
{
	var_01 = self.pers["voicePrefix"] + param_00;
	return var_01;
}

//Function Number: 46
func_3BAB(param_00,param_01)
{
	var_02 = getloccalloutalias(param_00);
	var_02 = var_02 + "_qa" + param_01;
	return var_02;
}

//Function Number: 47
battlechatter_canprint()
{
	return 0;
}

//Function Number: 48
func_130C()
{
	return 0;
}

//Function Number: 49
battlechatter_print(param_00)
{
}

//Function Number: 50
func_1313(param_00)
{
}

//Function Number: 51
battlechatter_debugprint(param_00)
{
}

//Function Number: 52
getaliastypefromsoundalias(param_00)
{
}

//Function Number: 53
battlechatter_printdumpline(param_00,param_01,param_02)
{
}

//Function Number: 54
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