/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\gametypes\_battlechatter_mp.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 53
 * Decompile Time: 813 ms
 * Timestamp: 4/22/2024 2:09:05 AM
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
	level.bcsounds["semtex_out"] = "semtex_use";
	level.bcsounds["conc_out"] = "inform_attack_stun";
	level.bcsounds["smoke_out"] = "inform_attack_smoke";
	level.bcsounds["emp_out"] = "emp_use";
	level.bcsounds["threat_out"] = "threat_use";
	level.bcsounds["drone_out"] = "inform_drone_use";
	level.bcsounds["grenade_incoming"] = "grenade_incoming";
	level.bcsounds["semtex_incoming"] = "semtex_incoming";
	level.bcsounds["stun_incoming"] = "stun_incoming";
	level.bcsounds["emp_incoming"] = "incoming_emp";
	level.bcsounds["drone_incoming"] = "inform_drone_enemy";
	level.bcsounds["exo_cloak_use"] = "inform_cloaking_use";
	level.bcsounds["exo_overclock_use"] = "inform_overclock_use";
	level.bcsounds["exo_ping_use"] = "exo_ping";
	level.bcsounds["exo_shield_use"] = "exo_shield_use";
	level.bcsounds["callout_generic"] = "threat_infantry_generic";
	level.bcsounds["callout_sniper"] = "threat_sniper_generic";
	level.bcsounds["callout_hover"] = "enemy_hover";
	level.bcsounds["callout_shield"] = "exo_shield_enemy";
	level.bcsounds["callout_cloak"] = "inform_cloaking_enemy";
	level.bcsounds["callout_overclock"] = "inform_overclock_enemy";
	level.bcsounds["callout_response_generic"] = "response_ack_yes";
	level.bcsounds["kill"] = "inform_killfirm_infantry";
	level.bcsounds["casualty"] = "inform_casualty_generic";
	level.bcsounds["suppressing_fire"] = "cmd_suppressfire";
	level.bcsounds["moving"] = "order_move_combat";
	level.bcsounds["damage"] = "inform_taking_fire";
	level.bcinfo = [];
	level.bcinfo["timeout"]["suppressing_fire"] = 5000;
	level.bcinfo["timeout"]["moving"] = 45000;
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
		self.bcinfo = [];
		self.bcinfo["last_say_time"]["suppressing_fire"] = -99999;
		self.bcinfo["last_say_time"]["moving"] = -99999;
		self.bcinfo["last_say_time"]["callout_generic"] = -99999;
		self.bcinfo["last_say_time"]["callout_location"] = -99999;
		var_00 = maps\mp\gametypes\_teams::getteamvoiceprefix(self.team);
		if(level.currentgen)
		{
			var_01 = 5;
			var_02 = 3;
		}
		else
		{
			var_01 = 9;
			var_02 = 5;
		}

		var_03 = "";
		if(!isagent(self) && self hasfemalecustomizationmodel())
		{
			var_03 = "w";
		}

		self.pers["voiceNum"] = level.voice_count[self.team][var_03];
		if(var_03 == "w")
		{
			level.voice_count[self.team][var_03] = level.voice_count[self.team][var_03] + 1 % var_02;
		}
		else
		{
			level.voice_count[self.team][var_03] = level.voice_count[self.team][var_03] + 1 % var_01;
		}

		self.pers["voicePrefix"] = var_00 + var_03 + self.pers["voiceNum"] + "_";
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
		thread grenadeproximitytracking();
		thread exoabilitytracking();
		thread suppressingfiretracking();
		thread casualtytracking();
		thread damagetracking();
		thread sprinttracking();
		thread threatcallouttracking();
	}
}

//Function Number: 4
grenadeproximitytracking()
{
	self endon("disconnect");
	self endon("death");
	var_00 = self.origin;
	var_01 = 147456;
	for(;;)
	{
		if(common_scripts\utility::cointoss())
		{
			wait(5);
			continue;
		}

		var_02 = common_scripts\utility::ter_op(isdefined(level.grenades),level.grenades,[]);
		var_03 = common_scripts\utility::ter_op(isdefined(level.missiles),level.missiles,[]);
		var_04 = common_scripts\utility::ter_op(isdefined(level.trackingdrones),level.trackingdrones,[]);
		if(var_02.size + var_03.size + var_04.size < 1 || !maps\mp\_utility::isreallyalive(self))
		{
			wait(0.05);
			continue;
		}

		var_02 = common_scripts\utility::array_combine(var_02,var_03);
		var_02 = common_scripts\utility::array_combine(var_02,var_04);
		if(var_02.size < 1)
		{
			wait(0.05);
			continue;
		}

		foreach(var_06 in var_02)
		{
			wait(0.05);
			if(!isdefined(var_06))
			{
				continue;
			}

			var_07 = isdefined(var_06.type) && var_06.type == "explosive_drone" || var_06.type == "tracking_drone";
			if(isdefined(var_06.weaponname))
			{
				switch(var_06.weaponname)
				{
					case "gamemode_ball":
						break;
				}

				if(weaponinventorytype(var_06.weaponname) != "offhand" && weaponclass(var_06.weaponname) == "grenade")
				{
					continue;
				}
			}

			if(!isdefined(var_06.owner) && !var_07)
			{
				var_06.owner = getmissileowner(var_06);
			}

			if(isdefined(var_06.owner) && isdefined(var_06.owner.team) && level.teambased && var_06.owner.team == self.team)
			{
				continue;
			}

			var_08 = distancesquared(var_06.origin,self.origin);
			if(var_08 < var_01)
			{
				if(bullettracepassed(var_06.origin,self.origin,0,self))
				{
					var_09 = "";
					if(var_07)
					{
						var_09 = "drone_incoming";
					}
					else if(isdefined(var_06.weaponname))
					{
						switch(var_06.weaponname)
						{
							case "semtex_mp":
								var_09 = "semtex_incoming";
								break;

							case "stun_grenade_var_mp":
							case "stun_grenade_mp":
								var_09 = "stun_incoming";
								break;

							case "emp_grenade_var_mp":
							case "emp_grenade_mp":
								var_09 = "emp_incoming";
								break;
						}
					}

					if(var_09 == "")
					{
						var_09 = "grenade_incoming";
					}

					level thread saylocalsound(self,var_09);
					wait(5);
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
		thread suppresswaiter();
		thread suppresstimeout();
		self notify("stoppedFiring");
	}
}

//Function Number: 6
suppresstimeout()
{
	thread waitsuppresstimeout();
	self endon("begin_firing");
	self waittill("end_firing");
	wait(0.3);
	self notify("stoppedFiring");
}

//Function Number: 7
waitsuppresstimeout()
{
	self endon("stoppedFiring");
	self waittill("begin_firing");
	thread suppresstimeout();
}

//Function Number: 8
suppresswaiter()
{
	self notify("suppressWaiter");
	self endon("suppressWaiter");
	self endon("death");
	self endon("disconnect");
	self endon("stoppedFiring");
	wait(1);
	if(cansay("suppressing_fire"))
	{
		level thread saylocalsound(self,"suppressing_fire");
	}
}

//Function Number: 9
reloadtracking()
{
	self endon("death");
	self endon("disconnect");
	self endon("faux_spawn");
	for(;;)
	{
		self waittill("reload_start");
		level thread saylocalsound(self,"reload");
	}
}

//Function Number: 10
grenadetracking()
{
	self endon("death");
	self endon("disconnect");
	self endon("faux_spawn");
	for(;;)
	{
		self waittill("grenade_fire",var_00,var_01);
		var_02 = maps\mp\_utility::strip_suffix(var_01,"_lefthand");
		if(var_02 == "frag_grenade_mp" || var_02 == "frag_grenade_var_mp" || var_02 == "contact_grenade_var_mp")
		{
			level thread saylocalsound(self,"frag_out");
			continue;
		}

		if(var_02 == "semtex_mp" || var_02 == "semtex_grenade_var_mp")
		{
			level thread saylocalsound(self,"semtex_out");
			continue;
		}

		if(var_02 == "explosive_drone_mp" || var_02 == "tracking_drone_mp")
		{
			level thread saylocalsound(self,"drone_out");
			continue;
		}

		if(var_02 == "concussion_grenade_mp" || var_02 == "stun_grenade_mp" || var_02 == "stun_grenade_var_mp")
		{
			level thread saylocalsound(self,"conc_out");
			continue;
		}

		if(var_02 == "smoke_grenade_mp" || var_02 == "smoke_grenade_var_mp")
		{
			level thread saylocalsound(self,"smoke_out");
			continue;
		}

		if(var_02 == "emp_grenade_mp" || var_02 == "emp_grenade_var_mp")
		{
			level thread saylocalsound(self,"emp_out");
			continue;
		}

		if(var_02 == "paint_grenade_mp" || var_02 == "paint_grenade_var_mp")
		{
			level thread saylocalsound(self,"threat_out");
		}
	}
}

//Function Number: 11
exoabilitytracking()
{
	self endon("death");
	self endon("disconnect");
	self endon("faux_spawn");
	var_00 = maps\mp\_exo_shield::get_exo_shield_weapon();
	var_01 = maps\mp\_exo_cloak::get_exo_cloak_weapon();
	var_02 = "exoping_equipment_mp";
	for(;;)
	{
		var_03 = common_scripts\utility::waittill_any_return_parms("grenade_pullback","grenade_fire","exo_adrenaline_fire");
		wait 0.05;
		if(var_03[0] == "grenade_pullback" && isdefined(var_03[1]) && var_03[1] == var_00 && isdefined(self.exo_shield_on) && self.exo_shield_on)
		{
			level thread saylocalsound(self,"exo_shield_use");
			continue;
		}

		if(var_03[0] == "grenade_fire" && isdefined(var_03[2]) && var_03[2] == var_01 && isdefined(self.exo_cloak_on) && self.exo_cloak_on)
		{
			level thread saylocalsound(self,"exo_cloak_use");
			continue;
		}

		if(var_03[0] == "grenade_fire" && isdefined(var_03[2]) && var_03[2] == var_02 && isdefined(self.exo_ping_on) && self.exo_ping_on)
		{
			level thread saylocalsound(self,"exo_ping_use");
			continue;
		}

		if(var_03[0] == "exo_adrenaline_fire" && isdefined(self.overclock_on) && self.overclock_on)
		{
			level thread saylocalsound(self,"exo_overclock_use");
		}
	}
}

//Function Number: 12
sprinttracking()
{
	self endon("death");
	self endon("disconnect");
	self endon("faux_spawn");
	for(;;)
	{
		self waittill("sprint_begin");
		if(cansay("moving"))
		{
			level thread saylocalsound(self,"moving",0,0);
		}
	}
}

//Function Number: 13
damagetracking()
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

		if(isdefined(level.ishorde) && level.ishorde && isdefined(var_01.agent_type) && var_01.agent_type == "dog")
		{
			continue;
		}

		if(var_01 != self && var_01.classname != "worldspawn")
		{
			wait(1.5);
			level thread saylocalsound(self,"damage");
			wait(3);
		}
	}
}

//Function Number: 14
casualtytracking()
{
	self endon("disconnect");
	self endon("faux_spawn");
	var_00 = self.team;
	self waittill("death");
	foreach(var_02 in level.participants)
	{
		if(!isdefined(var_02))
		{
			continue;
		}

		if(var_02 == self)
		{
			continue;
		}

		if(!maps\mp\_utility::isreallyalive(var_02))
		{
			continue;
		}

		if(var_02.team != var_00)
		{
			continue;
		}

		if(isdefined(self) && distancesquared(self.origin,var_02.origin) <= 262144)
		{
			level thread saylocalsounddelayed(var_02,"casualty",0.75);
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
		if(getdvarint("ui_inprematch"))
		{
			level waittill("prematch_over");
			continue;
		}

		if(!cansay("callout_location") && !cansay("callout_generic"))
		{
			continue;
		}

		var_00 = self getsightedplayers();
		if(!isdefined(var_00))
		{
			continue;
		}

		var_01 = undefined;
		var_02 = 4000000;
		if(self playerads() > 0.7)
		{
			var_02 = 6250000;
		}

		foreach(var_04 in var_00)
		{
			if(isdefined(var_04) && maps\mp\_utility::isreallyalive(var_04) && !var_04 maps\mp\_utility::_hasperk("specialty_coldblooded") && distancesquared(self.origin,var_04.origin) < var_02)
			{
				var_05 = var_04 getvalidlocation(self);
				var_01 = var_04;
				if(isdefined(var_05) && cansay("callout_location") && friendly_nearby(4840000))
				{
					if(maps\mp\_utility::_hasperk("specialty_quieter") || !friendly_nearby(262144))
					{
						level thread saylocalsound(self,var_05.locationaliases[0],0);
					}
					else
					{
						level thread saylocalsound(self,var_05.locationaliases[0],1);
					}

					break;
				}
			}
		}

		if(isdefined(var_01) && cansay("callout_generic"))
		{
			var_07 = var_01 getcurrentprimaryweapon();
			var_08 = var_01 iscloaked();
			var_09 = isdefined(var_01.exo_hover_on) && var_01.exo_hover_on;
			var_0A = isdefined(var_01.overclock_on) && var_01.overclock_on;
			var_0B = isdefined(var_01.exo_shield_on) && var_01.exo_shield_on;
			var_0B = var_0B || isdefined(self.frontshieldmodel);
			var_0C = weaponclass(var_07) == "sniper";
			if(var_08)
			{
				level thread saylocalsound(self,"callout_cloak");
			}
			else if(var_09)
			{
				level thread saylocalsound(self,"callout_hover");
			}
			else if(var_0A)
			{
				level thread saylocalsound(self,"callout_overclock");
			}
			else if(var_0B)
			{
				level thread saylocalsound(self,"callout_shield");
			}
			else if(var_0C)
			{
				level thread saylocalsound(self,"callout_sniper");
			}
			else
			{
				level thread saylocalsound(self,"callout_generic");
			}
		}
	}
}

//Function Number: 16
saylocalsounddelayed(param_00,param_01,param_02,param_03,param_04)
{
	param_00 endon("death");
	param_00 endon("disconnect");
	wait(param_02);
	saylocalsound(param_00,param_01,param_03,param_04);
}

//Function Number: 17
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

	if(param_00 maps\mp\killstreaks\_juggernaut::get_is_in_mech())
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
					param_01 = "callout_generic";
					break;
			}
		}
		else
		{
			location_add_last_callout_time(param_02);
			var_05 = var_05 + "co_loc_" + param_02;
			param_00 thread dothreatcalloutresponse(var_05,param_01);
			param_01 = "callout_location";
		}

		param_00 updatechatter(param_01);
		param_00 thread dosound(var_05,param_02,param_03);
	}
}

//Function Number: 18
dosound(param_00,param_01,param_02)
{
	if(!isdefined(param_02))
	{
		param_02 = 0;
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

//Function Number: 19
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

//Function Number: 20
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

//Function Number: 21
timehack(param_00)
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

//Function Number: 25
disablebattlechatter(param_00)
{
	param_00.bcdisabled = 1;
}

//Function Number: 26
enablebattlechatter(param_00)
{
	param_00.bcdisabled = undefined;
}

//Function Number: 27
cansay(param_00)
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
updatechatter(param_00)
{
	var_01 = self.pers["team"];
	self.bcinfo["last_say_time"][param_00] = gettime();
	level.bcinfo["last_say_time"][var_01][param_00] = gettime();
	level.bcinfo["last_say_pos"][var_01][param_00] = self.origin;
}

//Function Number: 29
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

//Function Number: 30
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

//Function Number: 31
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

//Function Number: 32
update_bcs_locations()
{
	if(isdefined(level.bcs_locations))
	{
		anim.bcs_locations = common_scripts\utility::array_removeundefined(level.bcs_locations);
	}
}

//Function Number: 33
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

//Function Number: 34
location_called_out_ever(param_00)
{
	var_01 = location_get_last_callout_time(param_00.locationaliases[0]);
	if(!isdefined(var_01))
	{
		return 0;
	}

	return 1;
}

//Function Number: 35
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

//Function Number: 36
location_add_last_callout_time(param_00)
{
	level.locationlastcallouttimes[param_00] = gettime();
}

//Function Number: 37
location_get_last_callout_time(param_00)
{
	if(isdefined(level.locationlastcallouttimes[param_00]))
	{
		return level.locationlastcallouttimes[param_00];
	}

	return undefined;
}

//Function Number: 38
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

//Function Number: 39
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

//Function Number: 40
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

//Function Number: 41
iscallouttypereport(param_00)
{
	return issubstr(param_00,"_report");
}

//Function Number: 42
iscallouttypeconcat(param_00,param_01)
{
	var_02 = param_01 getloccalloutalias("concat_loc_" + param_00);
	if(soundexists(var_02))
	{
		return 1;
	}

	return 0;
}

//Function Number: 43
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

//Function Number: 44
getloccalloutalias(param_00)
{
	var_01 = self.pers["voicePrefix"] + param_00;
	return var_01;
}

//Function Number: 45
getqacalloutalias(param_00,param_01)
{
	var_02 = getloccalloutalias(param_00);
	var_02 = var_02 + "_qa" + param_01;
	return var_02;
}

//Function Number: 46
battlechatter_canprint()
{
	return 0;
}

//Function Number: 47
battlechatter_canprintdump()
{
	return 0;
}

//Function Number: 48
battlechatter_print(param_00)
{
}

//Function Number: 49
battlechatter_printdump(param_00)
{
}

//Function Number: 50
battlechatter_debugprint(param_00)
{
}

//Function Number: 51
getaliastypefromsoundalias(param_00)
{
}

//Function Number: 52
battlechatter_printdumpline(param_00,param_01,param_02)
{
}

//Function Number: 53
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