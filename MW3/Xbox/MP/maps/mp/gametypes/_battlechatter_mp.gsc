/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_battlechatter_mp.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 16
 * Decompile Time: 207 ms
 * Timestamp: 10/27/2023 2:25:11 AM
*******************************************************************/

//Function Number: 1
init()
{
	level.isteamspeaking["allies"] = 0;
	level.isteamspeaking["axis"] = 0;
	level.speakers["allies"] = [];
	level.speakers["axis"] = [];
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
	level.bcsounds["casualty"] = "inform_casualty_generic";
	level.bcsounds["suppressing_fire"] = "cmd_suppressfire";
	level.bcsounds["semtex_incoming"] = "semtex_incoming";
	level.bcsounds["c4_incoming"] = "c4_incoming";
	level.bcsounds["flash_incoming"] = "flash_incoming";
	level.bcsounds["stun_incoming"] = "stun_incoming";
	level.bcsounds["grenade_incoming"] = "grenade_incoming";
	level.bcsounds["rpg_incoming"] = "rpg_incoming";
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
		var_00 = maps\mp\gametypes\_teams::getteamvoiceprefix(self.team);
		if(!isdefined(self.pers["voiceIndex"]) || var_00 != "RU_" && self.pers["voiceNum"] >= 3)
		{
			if(var_00 == "RU_")
			{
				self.pers["voiceNum"] = randomintrange(0,4);
			}
			else
			{
				self.pers["voiceNum"] = randomintrange(0,2);
			}

			self.pers["voicePrefix"] = var_00 + self.pers["voiceNum"] + "_";
		}

		if(level.splitscreen)
		{
			continue;
		}

		thread func_2CB4();
		thread reloadtracking();
		thread func_2CB6();
		thread grenadeproximitytracking();
		thread func_2CB2();
	}
}

//Function Number: 4
grenadeproximitytracking()
{
	self endon("disconnect");
	self endon("death");
	var_00 = self.origin;
	for(;;)
	{
		if(!isdefined(level.grenades) || level.grenades.size < 1 || !maps\mp\_utility::isreallyalive(self))
		{
			wait 0.05;
			continue;
		}

		var_01 = maps\mp\_utility::func_279B(level.grenades,level.missiles);
		foreach(var_03 in var_01)
		{
			wait 0.05;
			if(!isdefined(var_03))
			{
				continue;
			}

			if(isdefined(var_03.weaponname))
			{
				switch(var_03.weaponname)
				{
					case "claymore_mp":
						break;
				}
			}

			switch(var_03.model)
			{
				case "mp_trophy_system":
				case "weapon_radar":
				case "weapon_parabolic_knife":
				case "weapon_jammer":
					break;
			}

			if(!isdefined(var_03.owner))
			{
				var_03.owner = getmissileowner(var_03);
			}

			if(isdefined(var_03.owner) && level.teambased && var_03.owner.team == self.team)
			{
				continue;
			}

			var_04 = distancesquared(var_03.origin,self.origin);
			if(var_04 < 147456)
			{
				if(bullettracepassed(var_03.origin,self.origin,0,self))
				{
					if(common_scripts\utility::cointoss())
					{
						continue;
						wait 5;
						continue;
					}

					if(var_03.model == "projectile_concussion_grenade")
					{
						level thread func_2CB8(self,"stun_incoming");
						wait 5;
						continue;
					}

					if(var_03.model == "projectile_m84_flashbang_grenade")
					{
						level thread func_2CB8(self,"flash_incoming");
						wait 5;
						continue;
					}

					if(var_03.model == "projectile_rocket")
					{
						level thread func_2CB8(self,"rpg_incoming");
						wait 5;
						continue;
					}

					if(var_03.model == "weapon_c4")
					{
						level thread func_2CB8(self,"c4_incoming");
						wait 5;
						continue;
					}

					if(var_03.model == "projectile_m203grenade")
					{
						level thread func_2CB8(self,"rpg_incoming");
						wait 5;
						continue;
					}

					if(var_03.model == "projectile_semtex_grenade")
					{
						level thread func_2CB8(self,"semtex_incoming");
						wait 5;
						continue;
					}

					level thread func_2CB8(self,"grenade_incoming");
					wait 5;
				}
			}
		}
	}
}

//Function Number: 5
func_2CB2()
{
	self endon("death");
	self endon("disconnect");
	self endon("faux_spawn");
	var_00 = undefined;
	for(;;)
	{
		self waittill("begin_firing");
		thread func_2CB3();
		self waittill("end_firing");
		self notify("stoppedFiring");
	}
}

//Function Number: 6
func_2CB3()
{
	self notify("suppressWaiter");
	self endon("suppressWaiter");
	self endon("death");
	self endon("disconnect");
	self endon("stoppedFiring");
	wait 2;
	level thread func_2CB8(self,"suppressing_fire");
}

//Function Number: 7
func_2CB4()
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
			level thread func_2CB8(self,"claymore_plant");
		}
	}
}

//Function Number: 8
reloadtracking()
{
	self endon("death");
	self endon("disconnect");
	self endon("faux_spawn");
	for(;;)
	{
		self waittill("reload_start");
		level thread func_2CB8(self,"reload");
	}
}

//Function Number: 9
func_2CB6()
{
	self endon("death");
	self endon("disconnect");
	self endon("faux_spawn");
	for(;;)
	{
		self waittill("grenade_fire",var_00,var_01);
		if(var_01 == "frag_grenade_mp")
		{
			level thread func_2CB8(self,"frag_out");
			continue;
		}

		if(var_01 == "semtex_mp")
		{
			level thread func_2CB8(self,"semtex_out");
			continue;
		}

		if(var_01 == "flash_grenade_mp")
		{
			level thread func_2CB8(self,"flash_out");
			continue;
		}

		if(var_01 == "concussion_grenade_mp")
		{
			level thread func_2CB8(self,"conc_out");
			continue;
		}

		if(var_01 == "smoke_grenade_mp")
		{
			level thread func_2CB8(self,"smoke_out");
			continue;
		}

		if(var_01 == "c4_mp")
		{
			level thread func_2CB8(self,"c4_plant");
		}
	}
}

//Function Number: 10
saylocalsounddelayed(param_00,param_01,param_02)
{
	param_00 endon("death");
	param_00 endon("disconnect");
	wait param_02;
	func_2CB8(param_00,param_01);
}

//Function Number: 11
func_2CB8(param_00,param_01)
{
	param_00 endon("death");
	param_00 endon("disconnect");
	if(func_2CBB(param_00))
	{
		return;
	}

	if(param_00.team != "spectator")
	{
		var_02 = param_00.pers["voicePrefix"];
		var_03 = var_02 + level.bcsounds[param_01];
		param_00 thread dosound(var_03);
	}
}

//Function Number: 12
dosound(param_00)
{
	var_01 = self.pers["team"];
	level addspeaker(self,var_01);
	self playsoundtoteam(param_00,var_01,self);
	thread timehack(param_00);
	common_scripts\utility::waittill_any(param_00,"death","disconnect");
	level func_2CBD(self,var_01);
}

//Function Number: 13
timehack(param_00)
{
	self endon("death");
	self endon("disconnect");
	wait 2;
	self notify(param_00);
}

//Function Number: 14
func_2CBB(param_00)
{
	param_00 endon("death");
	param_00 endon("disconnect");
	var_01 = 1000000;
	if(isdefined(param_00) && isdefined(param_00.pers["team"]) && param_00.pers["team"] != "spectator")
	{
		for(var_02 = 0;var_02 < level.speakers[param_00.pers["team"]].size;var_02++)
		{
			var_03 = level.speakers[param_00.pers["team"]][var_02];
			if(var_03 == param_00)
			{
				return 1;
			}

			if(!isdefined(var_03))
			{
				continue;
			}

			if(distancesquared(var_03.origin,param_00.origin) < var_01)
			{
				return 1;
			}
		}
	}

	return 0;
}

//Function Number: 15
addspeaker(param_00,param_01)
{
	level.speakers[param_01][level.speakers[param_01].size] = param_00;
}

//Function Number: 16
func_2CBD(param_00,param_01)
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