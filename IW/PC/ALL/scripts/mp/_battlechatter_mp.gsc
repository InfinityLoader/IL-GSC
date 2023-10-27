/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\_battlechatter_mp.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 64
 * Decompile Time: 3056 ms
 * Timestamp: 10/27/2023 12:14:34 AM
*******************************************************************/

//Function Number: 1
init()
{
	if(level.multiteambased)
	{
		foreach(var_01 in level.teamnamelist)
		{
			level.var_9F9F[var_01] = 0;
			level.var_1092F[var_01] = [];
		}
	}
	else
	{
		level.var_9F9F["allies"] = 0;
		level.var_9F9F["axis"] = 0;
		level.var_1092F["allies"] = [];
		level.var_1092F["axis"] = [];
	}

	func_FAE9();
	level.var_29CB = [];
	level.var_29CB["reload"] = "inform_reloading_generic";
	level.var_29CB["frag_out"] = "inform_attack_grenade";
	level.var_29CB["flash_out"] = "inform_attack_flashbang";
	level.var_29CB["smoke_out"] = "inform_attack_smoke";
	level.var_29CB["conc_out"] = "inform_attack_stun";
	level.var_29CB["c4_plant"] = "inform_attack_thwc4";
	level.var_29CB["claymore_plant"] = "inform_plant_claymore";
	level.var_29CB["semtex_out"] = "semtex_use";
	level.var_29CB["kill"] = "inform_killfirm_infantry";
	level.var_29CB["casualty"] = "reaction_casualty_generic";
	level.var_29CB["suppressing_fire"] = "cmd_suppressfire";
	level.var_29CB["moving"] = "order_move_combat";
	level.var_29CB["callout_generic"] = "threat_infantry_generic";
	level.var_29CB["callout_response_generic"] = "response_ack_yes";
	level.var_29CB["damage"] = "inform_taking_fire";
	level.var_29CB["semtex_incoming"] = "semtex_incoming";
	level.var_29CB["c4_incoming"] = "c4_incoming";
	level.var_29CB["flash_incoming"] = "flash_incoming";
	level.var_29CB["stun_incoming"] = "stun_incoming";
	level.var_29CB["grenade_incoming"] = "grenade_incoming";
	level.var_29CB["rpg_incoming"] = "rpg_incoming";
	level.var_29AA = [];
	level.var_29AA["timeout"]["suppressing_fire"] = 5000;
	level.var_29AA["timeout"]["moving"] = -20536;
	level.var_29AA["timeout"]["callout_generic"] = 15000;
	level.var_29AA["timeout"]["callout_location"] = 3000;
	level.var_29AA["timeout_player"]["suppressing_fire"] = 10000;
	level.var_29AA["timeout_player"]["moving"] = 120000;
	level.var_29AA["timeout_player"]["callout_generic"] = 5000;
	level.var_29AA["timeout_player"]["callout_location"] = 5000;
	foreach(var_05, var_04 in level.var_1092F)
	{
		level.var_29AA["last_say_time"][var_05]["suppressing_fire"] = -99999;
		level.var_29AA["last_say_time"][var_05]["moving"] = -99999;
		level.var_29AA["last_say_time"][var_05]["callout_generic"] = -99999;
		level.var_29AA["last_say_time"][var_05]["callout_location"] = -99999;
		level.var_29AA["last_say_pos"][var_05]["suppressing_fire"] = (0,0,-9000);
		level.var_29AA["last_say_pos"][var_05]["moving"] = (0,0,-9000);
		level.var_29AA["last_say_pos"][var_05]["callout_generic"] = (0,0,-9000);
		level.var_29AA["last_say_pos"][var_05]["callout_location"] = (0,0,-9000);
		level.var_13526[var_05][""] = 0;
		level.var_13526[var_05]["w"] = 0;
	}

	scripts\common\bcs_location_trigs::func_29BB();
	scripts\mp\bcs_location_trigs::func_29BB();
	var_06 = getdvar("g_gametype");
	level.var_9F92 = 1;
	if(var_06 == "war" || var_06 == "kc" || var_06 == "dom")
	{
		level.var_9F92 = 0;
	}

	level thread func_C56E();
}

//Function Number: 2
func_C56E()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_01 = var_00 getplayerdata("common","gender");
		if(var_01)
		{
			var_00.var_7727 = "female";
		}
		else
		{
			var_00.var_7727 = "male";
		}

		var_00 thread func_C57B();
	}
}

//Function Number: 3
func_C57B()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("spawned_player");
		self.var_29AA = [];
		self.var_29AA["last_say_time"]["suppressing_fire"] = -99999;
		self.var_29AA["last_say_time"]["moving"] = -99999;
		self.var_29AA["last_say_time"]["callout_generic"] = -99999;
		self.var_29AA["last_say_time"]["callout_location"] = -99999;
		if(scripts\mp\_utility::func_9D48("archetype_heavy"))
		{
			var_00 = "HV_";
		}
		else if(scripts\mp\_utility::func_9D48("archetype_scout"))
		{
			var_00 = "SN_";
		}
		else if(scripts\mp\_utility::func_9D48("archetype_assassin"))
		{
			var_00 = "FT_";
		}
		else if(scripts\mp\_utility::func_9D48("archetype_engineer"))
		{
			var_00 = "N6_";
		}
		else if(scripts\mp\_utility::func_9D48("archetype_sniper"))
		{
			var_00 = "GH_";
		}
		else if(scripts\mp\_utility::func_9D48("archetype_assault"))
		{
			var_00 = "AS_";
		}
		else
		{
			var_00 = "AS_";
		}

		var_01 = scripts\mp\_teams::func_7E55();
		if(isdefined(var_01))
		{
			var_02 = var_01["body"];
			if(isdefined(var_02))
			{
				switch(var_02)
				{
					case "mp_ftl_hero_valley_girl_body":
						var_00 = "N6_";
						break;
	
					case "body_mp_ghost_zombies":
						var_00 = "N6_";
						break;
				}
			}
		}

		var_03 = !isagent(self) && !scripts\mp\_utility::isfemale();
		self.pers["voicePrefix"] = var_00 + var_03 + "_";
		if(level.splitscreen)
		{
			continue;
		}

		if(!level.teambased)
		{
			continue;
		}

		if(scripts\mp\_utility::func_9D46())
		{
			self.var_29A4 = 1;
			continue;
		}

		thread func_402C();
		thread func_DF5F();
		thread func_85E5();
		thread func_85D1();
		thread func_112CC();
		thread func_3B20();
		thread func_4D73();
		thread func_10AC4();
		thread func_117E1();
	}
}

//Function Number: 4
func_85D1()
{
	self endon("disconnect");
	self endon("death");
	var_00 = self.origin;
	var_01 = 147456;
	for(;;)
	{
		var_02 = scripts\common\utility::func_116D7(isdefined(level.var_85D5),level.var_85D5,[]);
		var_03 = scripts\common\utility::func_116D7(isdefined(level.var_B898),level.var_B898,[]);
		if(var_02.size + var_03.size < 1 || !scripts\mp\_utility::func_9F19(self))
		{
			wait(0.05);
			continue;
		}

		var_02 = scripts\common\utility::array_combine(var_02,var_03);
		foreach(var_05 in var_02)
		{
			wait(0.05);
			if(!isdefined(var_05))
			{
				continue;
			}

			if(isdefined(var_05.var_13C2E))
			{
				switch(var_05.var_13C2E)
				{
					case "mobile_radar_mp":
					case "motion_sensor_mp":
					case "proximity_explosive_mp":
					case "throwingreaper_mp":
					case "throwingknifesmokewall_mp":
					case "throwingknifeteleport_mp":
					case "trophy_mp":
					case "smoke_grenade_mp":
					case "throwingknife_mp":
					case "blackhole_grenade_mp":
					case "throwingknifec4_mp":
						break;
				}

				if(function_0244(var_05.var_13C2E) != "offhand" && weaponclass(var_05.var_13C2E) == "grenade")
				{
					continue;
				}

				if(!isdefined(var_05.var_222))
				{
					var_05.var_222 = getmissileowner(var_05);
				}

				if(isdefined(var_05.var_222) && level.teambased && var_05.var_222.team == self.team)
				{
					continue;
				}

				var_06 = distancesquared(var_05.origin,self.origin);
				if(var_06 < var_01)
				{
					if(scripts\common\utility::func_4347())
					{
						wait(5);
						continue;
					}

					if(bullettracepassed(var_05.origin,self.origin,0,self))
					{
						if(var_05.var_13C2E == "concussion_grenade_mp" || var_05.var_13C2E == "sensor_grenade_mp")
						{
							level thread func_EB84(self,"stun_incoming");
							wait(5);
							continue;
						}

						if(var_05.var_13C2E == "flash_grenade_mp")
						{
							level thread func_EB84(self,"flash_incoming");
							wait(5);
							continue;
						}

						if(weaponclass(var_05.var_13C2E) == "rocketlauncher")
						{
							level thread func_EB84(self,"rpg_incoming");
							wait(5);
							continue;
						}

						if(var_05.var_13C2E == "c4_mp")
						{
							level thread func_EB84(self,"c4_incoming");
							wait(5);
							continue;
						}

						if(var_05.var_13C2E == "semtex_mp")
						{
							level thread func_EB84(self,"semtex_incoming");
							wait(5);
							continue;
						}

						level thread func_EB84(self,"grenade_incoming");
						wait(5);
					}
				}
			}
		}
	}
}

//Function Number: 5
func_112CC()
{
	self endon("death");
	self endon("disconnect");
	self endon("faux_spawn");
	var_00 = undefined;
	for(;;)
	{
		self waittill("begin_firing");
		thread func_112D1();
		thread func_112D0();
		self waittill("stoppedFiring");
	}
}

//Function Number: 6
func_112D0()
{
	thread func_1371B();
	self endon("begin_firing");
	self waittill("end_firing");
	wait(0.3);
	self notify("stoppedFiring");
}

//Function Number: 7
func_1371B()
{
	self endon("stoppedFiring");
	self waittill("begin_firing");
	thread func_112D0();
}

//Function Number: 8
func_112D1()
{
	self notify("suppressWaiter");
	self endon("suppressWaiter");
	self endon("death");
	self endon("disconnect");
	self endon("stoppedFiring");
	wait(1);
	if(func_3902("suppressing_fire"))
	{
		level thread func_EB84(self,"suppressing_fire");
	}
}

//Function Number: 9
func_402C()
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
			level thread func_EB84(self,"claymore_plant");
		}
	}
}

//Function Number: 10
func_DF5F()
{
	self endon("death");
	self endon("disconnect");
	self endon("faux_spawn");
	for(;;)
	{
		self waittill("reload_start");
		level thread func_EB84(self,"reload");
	}
}

//Function Number: 11
func_85E5()
{
	self endon("death");
	self endon("disconnect");
	self endon("faux_spawn");
	for(;;)
	{
		self waittill("grenade_fire",var_00,var_01);
		if(var_01 == "frag_grenade_mp")
		{
			level thread func_EB84(self,"frag_out");
			continue;
		}

		if(var_01 == "semtex_mp")
		{
			level thread func_EB84(self,"semtex_out");
			continue;
		}

		if(var_01 == "cluster_grenade_mp")
		{
			level thread func_EB84(self,"frag_out");
			continue;
		}

		if(var_01 == "flash_grenade_mp")
		{
			level thread func_EB84(self,"flash_out");
			continue;
		}

		if(var_01 == "concussion_grenade_mp" || var_01 == "sensor_grenade_mp")
		{
			level thread func_EB84(self,"conc_out");
			continue;
		}

		if(var_01 == "smoke_grenade_mp" || var_01 == "gas_grenade_mp")
		{
			level thread func_EB84(self,"smoke_out");
			continue;
		}

		if(var_01 == "c4_mp")
		{
			level thread func_EB84(self,"c4_plant");
		}
	}
}

//Function Number: 12
func_10AC4()
{
	self endon("death");
	self endon("disconnect");
	self endon("faux_spawn");
	for(;;)
	{
		self waittill("sprint_begin");
		if(func_3902("moving"))
		{
			level thread func_EB84(self,"moving",0,0);
		}
	}
}

//Function Number: 13
func_4D73()
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
			level thread func_EB84(self,"damage");
			wait(3);
		}
	}
}

//Function Number: 14
func_3B20()
{
	self endon("disconnect");
	self endon("faux_spawn");
	self waittill("death");
	foreach(var_01 in level.var_C928)
	{
		if(!isdefined(var_01))
		{
			continue;
		}

		if(var_01 == self)
		{
			continue;
		}

		if(!scripts\mp\_utility::func_9F19(var_01))
		{
			continue;
		}

		if(!isdefined(self.team))
		{
			continue;
		}

		if(var_01.team != self.team)
		{
			continue;
		}

		if(isagent(var_01))
		{
			continue;
		}

		if(distancesquared(self.origin,var_01.origin) <= 262144)
		{
			level thread func_EB85(var_01,"casualty",0.75);
			break;
		}
	}
}

//Function Number: 15
func_117E1()
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

		if(!func_3902("callout_location") && !func_3902("callout_generic"))
		{
			continue;
		}

		var_00 = self method_815C();
		if(!isdefined(var_00))
		{
			continue;
		}

		var_01 = 0;
		var_02 = 4000000;
		if(self method_822E() > 0.7)
		{
			var_02 = 6250000;
		}

		foreach(var_04 in var_00)
		{
			if(isdefined(var_04) && scripts\mp\_utility::func_9F19(var_04) && !var_04 scripts\mp\_utility::_hasperk("specialty_coldblooded") && distancesquared(self.origin,var_04.origin) < var_02)
			{
				var_05 = var_04 func_81F7(self);
				var_01 = 1;
				if(isdefined(var_05) && func_3902("callout_location") && func_73DC(4840000))
				{
					if(scripts\mp\_utility::_hasperk("specialty_quieter") || !func_73DC(262144))
					{
						level thread func_EB84(self,var_05.var_AECB[0],0);
					}
					else
					{
						level thread func_EB84(self,var_05.var_AECB[0],1);
					}

					break;
				}
			}
		}

		if(var_01 && func_3902("callout_generic"))
		{
			level thread func_EB84(self,"callout_generic");
			level thread func_EB87(self,"plr_target_generic",undefined,0.75);
		}
	}
}

//Function Number: 16
func_EB85(param_00,param_01,param_02,param_03,param_04)
{
	param_00 endon("death");
	param_00 endon("disconnect");
	wait(param_02);
	func_EB84(param_00,param_01,param_03,param_04);
}

//Function Number: 17
func_EB84(param_00,param_01,param_02,param_03)
{
	param_00 endon("death");
	param_00 endon("disconnect");
	if(scripts\mp\_utility::func_9FB3(param_00.var_29A4))
	{
		return;
	}

	if(func_9F6A(param_00))
	{
		return;
	}

	if(param_00.team != "spectator")
	{
		var_04 = param_00.pers["voicePrefix"];
		if(isdefined(level.var_29CB[param_01]))
		{
			var_05 = var_04 + level.var_29CB[param_01];
		}
		else
		{
			func_AEC5(param_02);
			var_05 = var_05 + "co_loc_" + param_02;
			param_00 thread func_5ABF(var_05,param_01);
			param_01 = "callout_location";
		}

		param_00 func_12E72(param_01);
		param_00 thread func_5AB0(var_05,param_02,param_03);
	}
}

//Function Number: 18
func_5AB0(param_00,param_01,param_02)
{
	if(!isdefined(param_02))
	{
		param_02 = 1;
	}

	var_03 = self.pers["team"];
	level func_182A(self,var_03);
	var_04 = !level.var_9F92 || !scripts\mp\_utility::_hasperk("specialty_coldblooded") && isagent(self) || self method_81B9();
	if(param_02 && var_04)
	{
		if(isagent(self) || level.var_1BE6[var_03] > 3)
		{
			thread func_5AB1(param_00,var_03);
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

	thread func_118EF(param_00);
	scripts\common\utility::waittill_any_3(param_00,"death","disconnect");
	level func_E173(self,var_03);
}

//Function Number: 19
func_5AB1(param_00,param_01)
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
func_5ABF(param_00,param_01)
{
	var_02 = scripts\common\utility::func_13734(param_00,"death","disconnect");
	if(var_02 == param_00)
	{
		var_03 = self.team;
		var_04 = self.pers["voicePrefix"];
		var_05 = self.origin;
		wait(0.5);
		foreach(var_0B, var_07 in level.var_C928)
		{
			if(!isdefined(var_07))
			{
				continue;
			}

			if(var_07 == self)
			{
				continue;
			}

			if(!scripts\mp\_utility::func_9F19(var_07))
			{
				continue;
			}

			if(var_07.team != var_03)
			{
				continue;
			}

			var_08 = var_07.pers["voicePrefix"];
			if(!isdefined(var_08))
			{
				continue;
			}

			if(var_08 != var_04 && distancesquared(var_05,var_07.origin) <= 262144 && !func_9F6A(var_07))
			{
				var_09 = var_08 + "co_loc_" + param_01 + "_echo";
				if(soundexists(var_09) && scripts\common\utility::func_4347())
				{
					var_0A = var_09;
				}
				else
				{
					var_0A = var_0B + level.var_29CB["callout_response_generic"];
				}

				var_07 thread func_5AB0(var_0A,0,1);
				break;
			}
		}
	}
}

//Function Number: 21
func_118EF(param_00)
{
	self endon("death");
	self endon("disconnect");
	wait(2);
	self notify(param_00);
}

//Function Number: 22
func_9F6A(param_00,param_01)
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
		for(var_03 = 0;var_03 < level.var_1092F[param_00.team].size;var_03++)
		{
			var_04 = level.var_1092F[param_00.team][var_03];
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
func_182A(param_00,param_01)
{
	level.var_1092F[param_01][level.var_1092F[param_01].size] = param_00;
}

//Function Number: 24
func_E173(param_00,param_01)
{
	var_02 = [];
	for(var_03 = 0;var_03 < level.var_1092F[param_01].size;var_03++)
	{
		if(level.var_1092F[param_01][var_03] == param_00)
		{
			continue;
		}

		var_02[var_02.size] = level.var_1092F[param_01][var_03];
	}

	level.var_1092F[param_01] = var_02;
}

//Function Number: 25
func_55B4(param_00)
{
	param_00.var_29A4 = 1;
}

//Function Number: 26
func_6260(param_00)
{
	param_00.var_29A4 = undefined;
}

//Function Number: 27
func_3902(param_00)
{
	var_01 = self.pers["team"];
	if(var_01 == "spectator")
	{
		return 0;
	}

	var_02 = level.var_29AA["timeout_player"][param_00];
	var_03 = gettime() - self.var_29AA["last_say_time"][param_00];
	if(var_02 > var_03)
	{
		return 0;
	}

	var_02 = level.var_29AA["timeout"][param_00];
	var_03 = gettime() - level.var_29AA["last_say_time"][var_01][param_00];
	if(var_02 < var_03)
	{
		return 1;
	}

	return 0;
}

//Function Number: 28
func_12E72(param_00)
{
	var_01 = self.pers["team"];
	self.var_29AA["last_say_time"][param_00] = gettime();
	level.var_29AA["last_say_time"][var_01][param_00] = gettime();
	level.var_29AA["last_say_pos"][var_01][param_00] = self.origin;
}

//Function Number: 29
func_12EC1(param_00)
{
}

//Function Number: 30
func_7F7E()
{
	var_00 = func_7803();
	var_00 = scripts\common\utility::array_randomize(var_00);
	if(var_00.size)
	{
		foreach(var_02 in var_00)
		{
			if(!func_AEC6(var_02))
			{
				return var_02;
			}
		}

		foreach(var_02 in var_00)
		{
			if(!func_AEC7(var_02))
			{
				return var_02;
			}
		}
	}

	return undefined;
}

//Function Number: 31
func_81F7(param_00)
{
	var_01 = func_7803();
	var_01 = scripts\common\utility::array_randomize(var_01);
	if(var_01.size)
	{
		foreach(var_03 in var_01)
		{
			if(!func_AEC6(var_03) && param_00 func_3878(var_03))
			{
				return var_03;
			}
		}

		foreach(var_03 in var_01)
		{
			if(!func_AEC7(var_03) && param_00 func_3878(var_03))
			{
				return var_03;
			}
		}
	}

	return undefined;
}

//Function Number: 32
func_7803()
{
	var_00 = level.var_29BC;
	var_01 = self getistouchingentities(var_00);
	var_02 = [];
	foreach(var_04 in var_01)
	{
		if(isdefined(var_04.var_AECB))
		{
			var_02[var_02.size] = var_04;
		}
	}

	return var_02;
}

//Function Number: 33
func_12D96()
{
	if(isdefined(level.var_29BC))
	{
		anim.var_29BC = scripts\common\utility::func_22BC(level.var_29BC);
	}
}

//Function Number: 34
func_9C15()
{
	var_00 = func_7803();
	foreach(var_02 in var_00)
	{
		if(!func_AEC7(var_02))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 35
func_AEC6(param_00)
{
	var_01 = func_AEC9(param_00.var_AECB[0]);
	if(!isdefined(var_01))
	{
		return 0;
	}

	return 1;
}

//Function Number: 36
func_AEC7(param_00)
{
	var_01 = func_AEC9(param_00.var_AECB[0]);
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
func_AEC5(param_00)
{
	level.var_AECC[param_00] = gettime();
}

//Function Number: 38
func_AEC9(param_00)
{
	if(isdefined(level.var_AECC[param_00]))
	{
		return level.var_AECC[param_00];
	}

	return undefined;
}

//Function Number: 39
func_3878(param_00)
{
	foreach(var_02 in param_00.var_AECB)
	{
		var_03 = func_7F7F("co_loc_" + var_02);
		var_04 = func_80A3(var_02,0);
		var_05 = func_7F7F("concat_loc_" + var_02);
		var_06 = soundexists(var_03) || soundexists(var_04) || soundexists(var_05);
		if(var_06)
		{
			return var_06;
		}
	}

	return 0;
}

//Function Number: 40
func_3896(param_00)
{
	var_01 = param_00.var_AECB;
	foreach(var_03 in var_01)
	{
		if(func_9D7A(var_03,self))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 41
func_7E18(param_00)
{
	var_01 = undefined;
	var_02 = self.var_AECB;
	foreach(var_04 in var_02)
	{
		if(func_9D7B(var_04,param_00) && !isdefined(self.var_DB40))
		{
			var_01 = var_04;
			break;
		}

		if(func_9D7C(var_04))
		{
			var_01 = var_04;
		}
	}

	return var_01;
}

//Function Number: 42
func_9D7C(param_00)
{
	return issubstr(param_00,"_report");
}

//Function Number: 43
func_9D7A(param_00,param_01)
{
	var_02 = param_01 func_7F7F("concat_loc_" + param_00);
	if(soundexists(var_02))
	{
		return 1;
	}

	return 0;
}

//Function Number: 44
func_9D7B(param_00,param_01)
{
	if(issubstr(param_00,"_qa") && soundexists(param_00))
	{
		return 1;
	}

	var_02 = param_01 func_80A3(param_00,0);
	if(soundexists(var_02))
	{
		return 1;
	}

	return 0;
}

//Function Number: 45
func_7F7F(param_00)
{
	var_01 = self.pers["voicePrefix"] + param_00;
	return var_01;
}

//Function Number: 46
func_80A3(param_00,param_01)
{
	var_02 = func_7F7F(param_00);
	var_02 = var_02 + "_qa" + param_01;
	return var_02;
}

//Function Number: 47
func_28D2()
{
	return 0;
}

//Function Number: 48
func_28D3()
{
	return 0;
}

//Function Number: 49
func_28DA(param_00)
{
}

//Function Number: 50
func_28DB(param_00)
{
}

//Function Number: 51
func_28D4(param_00)
{
}

//Function Number: 52
func_7DAD(param_00)
{
}

//Function Number: 53
func_28DC(param_00,param_01,param_02)
{
}

//Function Number: 54
func_73DC(param_00)
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

//Function Number: 55
func_FAE9()
{
	level.var_F215 = [];
	level.var_F215["plr_killfirm_c6"] = "kill_rig";
	level.var_F215["plr_killfirm_ftl"] = "kill_rig";
	level.var_F215["plr_killfirm_ghost"] = "kill_rig";
	level.var_F215["plr_killfirm_merc"] = "kill_rig";
	level.var_F215["plr_killfirm_stryker"] = "kill_rig";
	level.var_F215["plr_killfirm_warfighter"] = "kill_rig";
	level.var_F215["plr_killfirm_generic"] = "kill_gen";
	level.var_F215["plr_killfirm_amf"] = "kill_amf";
	level.var_F215["plr_killfirm_headshot"] = "kill_headshot";
	level.var_F215["plr_killfirm_grenade"] = "kill_grenade";
	level.var_F215["plr_killfirm_rival"] = "kill_rival";
	level.var_F215["plr_killfirm_semtex"] = "kill_semtex";
	level.var_F215["plr_killfirm_multi"] = "kill_multi";
	level.var_F215["plr_killfirm_twofer"] = "kill_twofer";
	level.var_F215["plr_killfirm_threefer"] = "kill_threefer";
	level.var_F215["plr_killfirm_killstreak"] = "kill_ss";
	level.var_F215["plr_killstreak_destroy"] = "kill_other_ss";
	level.var_F215["plr_killstreak_target"] = "targeted_by_ss";
	level.var_F215["plr_hit_back"] = "dmg_back";
	level.var_F215["plr_damaged_light"] = "dmg_light";
	level.var_F215["plr_damaged_heavy"] = "dmg_heavy";
	level.var_F215["plr_damaged_emp"] = "dmg_emp";
	level.var_F215["plr_healing"] = "healing";
	level.var_F215["plr_kd_high"] = "kd_high";
	level.var_F215["plr_firefight"] = "firefight";
	level.var_F215["plr_target_generic"] = "enemy_sighted";
	level.var_F215["plr_perk_super"] = "super_activate";
	level.var_F215["plr_perk_trophy"] = "super_activate";
	level.var_F215["plr_perk_turret"] = "super_activate";
	level.var_F215["plr_perk_amplify"] = "super_activate";
	level.var_F215["plr_perk_overdrive"] = "super_activate";
	level.var_F215["plr_perk_ftl"] = "super_activate";
	level.var_F215["plr_perk_pulse"] = "super_activate";
	level.var_F215["plr_perk_rewind"] = "super_activate";
	level.var_F215["plr_perk_super_kill"] = "super_kill";
	level.var_F215["plr_perk_trophy_block"] = "super_kill";
	level.var_F215["plr_perk_turret_kill"] = "super_kill";
	level.var_F215["plr_killfirm_shift"] = "super_kill";
	level.var_F215["plr_perk_railgun"] = "super_kill";
	level.var_F215["plr_perk_stealth"] = "super_kill";
	level.var_F215["plr_perk_armor"] = "super_kill";
	level.var_F215["plr_perk_charge"] = "super_kill";
	level.var_F215["plr_perk_dragon"] = "super_kill";
	level.var_F215["plr_perk_pound"] = "super_kill";
	level.var_F215["plr_perk_reaper"] = "super_kill";
	level.var_F214 = [];
	func_F839("kill_rig",15,0.3,0.25);
	func_F839("kill_gen",30,0.1,0.25);
	func_F839("kill_amf",15,0.5,0.5);
	func_F839("kill_headshot",15,0.7,0.25);
	func_F839("kill_grenade",15,0.5,0.25);
	func_F839("kill_rival",15,0.7,0.25);
	func_F839("kill_semtex",15,0.5,0.25);
	func_F839("kill_multi",20,0.6,0.25);
	func_F839("kill_twofer",10,0.7,0.75);
	func_F839("kill_threefer",10,0.8,0.75);
	func_F839("kill_ss",10,0.5,0.2);
	func_F839("kill_other_ss",10,0.7,0.75);
	func_F839("targeted_by_ss",10,0.4,0.33);
	func_F839("dmg_back",20,0.5,0.5);
	func_F839("dmg_light",20,0.4,0.1);
	func_F839("dmg_heavy",20,0.5,0.2);
	func_F839("healing",10,0.3,0.1);
	func_F839("kd_high",20,0.7,0.8);
	func_F839("enemy_sighted",20,0.2,0.25);
	func_F839("firefight",10,0.4,0.33);
	func_F839("super_activate",10,1,1);
	func_F839("super_kill",10,0.9,0.66);
}

//Function Number: 56
func_F839(param_00,param_01,param_02,param_03)
{
	level.var_F214[param_00]["timeout"] = param_01;
	level.var_F214[param_00]["priority"] = param_02;
	level.var_F214[param_00]["chance"] = param_03;
}

//Function Number: 57
func_EB87(param_00,param_01,param_02,param_03)
{
	if(isagent(param_00) || !isplayer(param_00))
	{
		return;
	}

	if(scripts\mp\_utility::func_9FB3(param_00.var_29A4))
	{
		return;
	}

	var_04 = param_00.pers["voicePrefix"] + param_01;
	if(!isdefined(param_01) || !soundexists(var_04))
	{
		if(!isdefined(param_02))
		{
			return;
		}

		param_01 = param_02;
		var_04 = param_00.pers["voicePrefix"] + param_01;
		if(!soundexists(var_04))
		{
			return;
		}
	}

	if(!isdefined(param_00.var_F213))
	{
		param_00.var_F213 = [];
		param_00.var_D4B0 = 0;
		param_00.var_DB91 = "none";
	}

	if(isdefined(param_00.var_F213[level.var_F215[param_01]]) && param_00.var_F213[level.var_F215[param_01]] > 0)
	{
		return;
	}

	if(!isdefined(param_00.pers["selfVOBonusChance"]))
	{
		param_00 thread func_12F14();
	}

	if(randomfloat(1) > level.var_F214[level.var_F215[param_01]]["chance"] + param_00.pers["selfVOBonusChance"])
	{
		return;
	}

	param_00 thread func_128AC(param_01,param_03);
}

//Function Number: 58
func_12F14()
{
	self endon("disconnect");
	level endon("game_ended");
	self.pers["selfVOBonusChance"] = 0;
	for(;;)
	{
		self.pers["selfVOBonusChance"] = self.pers["selfVOBonusChance"] + 0.1;
		wait(3);
	}
}

//Function Number: 59
func_128AC(param_00,param_01)
{
	self endon("death");
	self endon("disconnect");
	if(self.var_DB91 == param_00)
	{
		return;
	}

	if(self.var_DB91 == "none" || level.var_F214[level.var_F215[self.var_DB91]]["priority"] < level.var_F214[level.var_F215[param_00]]["priority"] || level.var_F214[level.var_F215[self.var_DB91]]["priority"] == level.var_F214[level.var_F215[param_00]]["priority"] && scripts\common\utility::func_4347())
	{
		self.var_DB91 = param_00;
	}
	else
	{
		return;
	}

	self notify("addToSelfVOQueue");
	self endon("addToSelfVOQueue");
	self.var_F212 = 1;
	if(isdefined(param_01))
	{
		thread func_F211(param_01);
	}

	var_02 = func_809D(param_00);
	var_03 = gettime();
	while(self.var_D4B0 || !self.var_F212 || var_02 > gettime())
	{
		if(gettime() > var_03 + 2000)
		{
			self.var_DB91 = "none";
			return;
		}

		wait(0.05);
	}

	scripts\common\utility::func_136F7();
	thread func_D510(param_00);
}

//Function Number: 60
func_809D(param_00)
{
	if(!isdefined(self.var_A9EC))
	{
		self.var_A9EC = 0;
	}

	return self.var_A9EC + 2000 + 10000 * 1 - level.var_F214[level.var_F215[param_00]]["priority"];
}

//Function Number: 61
func_F211(param_00)
{
	self endon("death");
	self endon("disconnect");
	self endon("addToSelfVOQueue");
	self.var_F212 = 0;
	wait(param_00);
	self.var_F212 = 1;
}

//Function Number: 62
func_D510(param_00)
{
	self endon("death");
	self endon("disconnect");
	var_01 = self.pers["voicePrefix"] + param_00;
	self.pers["selfVOBonusChance"] = 0;
	self.var_DB91 = "none";
	var_02 = lookupsoundlength(var_01) / 1000;
	self.var_A9EC = gettime();
	thread func_D4B1(var_02);
	thread func_12F15(param_00);
	self playsoundtoplayer(var_01,self);
}

//Function Number: 63
func_D4B1(param_00)
{
	self endon("disconnect");
	self.var_D4B0 = 1;
	wait(param_00);
	self.var_D4B0 = 0;
}

//Function Number: 64
func_12F15(param_00)
{
	self endon("disconnect");
	self.var_F213[level.var_F215[param_00]] = gettime();
	wait(level.var_F214[level.var_F215[param_00]]["timeout"]);
	self.var_F213[level.var_F215[param_00]] = 0;
}