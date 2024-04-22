/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\zombies\weapons\_zombie_teleport_grenade.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 18
 * Decompile Time: 304 ms
 * Timestamp: 4/22/2024 2:13:28 AM
*******************************************************************/

//Function Number: 1
init()
{
	level._effect["teleport_equipment"] = loadfx("vfx/unique/dlc_teleport_grenade");
	level._effect["teleport_player"] = loadfx("vfx/unique/dlc_teleport_player");
	level.teleport_grenade_override_triggers = getentarray("teleport_grenade_override_trigger","targetname");
	level.teleport_grenade_ignore_triggers = getentarray("trigger_underwater","targetname");
}

//Function Number: 2
onplayerspawn()
{
	self endon("spawned_player");
	self endon("disconnect");
	self endon("death");
	self endon("faux_spawn");
	self notify("onPlayerSpawnTeleportGrenade");
	self endon("onPlayerSpawnTeleportGrenade");
	for(;;)
	{
		self waittill("grenade_fire",var_00,var_01);
		var_02 = maps\mp\_utility::strip_suffix(var_01,"_lefthand");
		if(var_02 != "teleport_zombies_mp" && var_02 != "teleport_throw_zombies_mp")
		{
			continue;
		}

		thread doteleport(var_00,var_01);
	}
}

//Function Number: 3
grenadewaitformisslestuck()
{
	self endon("death");
	thread grenadetimeout();
	self waittill("missile_stuck",var_00);
	return var_00;
}

//Function Number: 4
grenadetimeout()
{
	self endon("missile_stuck");
	self endon("death");
	wait(4);
	self notify("missile_stuck");
}

//Function Number: 5
doteleport(param_00,param_01)
{
	self notify("doTeleportGrenade");
	self endon("doTeleportGrenade");
	thread playerteleportgrenadecleanup(param_00);
	var_02 = param_00.origin;
	var_03 = param_00 grenadewaitformisslestuck();
	if(!isdefined(param_00))
	{
		return;
	}

	if(isdefined(level.zmbteleportgrenadestuckcustom))
	{
		if([[ level.zmbteleportgrenadestuckcustom ]](param_00,param_01,self))
		{
			return;
		}
	}

	var_04 = param_00.origin;
	var_05 = param_00.angles;
	param_00 delete();
	if(maps\mp\zombies\_util::gameflagexists("sq_plinko") && maps\mp\_utility::gameflag("sq_plinko") && isdefined(var_03) && isdefined(var_03.script_noteworthy) && issubstr(var_03.script_noteworthy,"gate_"))
	{
		return;
	}
	else if(isdefined(var_03) && maps\mp\zombies\_util::is_true(var_03.noteleportgrenade))
	{
		return;
	}

	if(!isdefined(self) || maps\mp\zombies\_util::isplayerinlaststand(self) || !isalive(self))
	{
		return;
	}

	if(isdefined(level.zmplayeraltteleport))
	{
		if(self [[ level.zmplayeraltteleport ]](var_04,var_05,var_02))
		{
			return;
		}
	}

	doteleportinstant(var_04,var_05,var_02,param_01,var_03);
}

//Function Number: 6
playerteleportgrenadecleanup(param_00)
{
	param_00 endon("death");
	param_00 endon("missile_stuck");
	common_scripts\utility::waittill_any("doTeleportGrenade","disconnect");
	playfx(common_scripts\utility::getfx("teleport_equipment"),param_00.origin);
	param_00 delete();
}

//Function Number: 7
playerteleport(param_00,param_01)
{
	if(isdefined(param_00))
	{
		givecoast2coastachievement(param_00);
		self setorigin(param_00,1);
	}

	if(isdefined(param_01))
	{
		self setplayerangles(param_01);
	}

	thread playerteleportaudio();
	playfxontagforclients(common_scripts\utility::getfx("teleport_player"),self,"tag_origin",self);
}

//Function Number: 8
doteleportinstant(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = self.origin;
	playfx(common_scripts\utility::getfx("teleport_equipment"),param_00);
	var_06 = gettime();
	var_07 = findsafeposition(param_00,param_01,param_02);
	var_08 = gettime();
	if(isdefined(var_07))
	{
		var_09 = var_08 - var_06 / 1000;
		if(var_09 < 0.2)
		{
			wait(0.2 - var_09);
		}

		playerteleport(var_07);
		self playrumbleonentity("damage_heavy");
		earthquake(randomfloatrange(0.25,0.35),1,self.origin,100,self);
		playertelefragzombie(param_04,var_07);
		self radiusdamage(var_07,300,200 * level.wavecounter,100 * level.wavecounter,self,"MOD_EXPLOSIVE","teleport_zombies_mp");
		thread playerteleportedvo();
		thread playerfixgoingunderwater();
		return;
	}

	var_0A = self getweaponammoclip(param_03);
	self setweaponammoclip(param_03,var_0A + 1);
}

//Function Number: 9
playerfixgoingunderwater()
{
	if(isdefined(self.underwatermotiontype))
	{
		self.underwater = undefined;
		self.isswimming = undefined;
		self.iswading = undefined;
		self notify("above_water");
		playfx(level._effect["water_splash_emerge"],self.origin,anglestoforward((0,self.angles[1],0) + (270,180,0)));
		if(maps\mp\zombies\_util::is_true(self.isshocked))
		{
			self stopshellshock();
			self.isshocked = undefined;
		}

		maps\mp\_water::playerdisableunderwater();
		if(maps\mp\_utility::isaugmentedgamemode())
		{
			maps\mp\_water::enableexo();
		}
	}
}

//Function Number: 10
givecoast2coastachievement(param_00)
{
	if(maps\mp\_utility::getmapname() != "mp_zombie_h2o")
	{
		return;
	}

	var_01 = "start";
	var_02 = "zone_04";
	var_03 = self.currentzone;
	var_04 = maps\mp\zombies\_zombies_zone_manager::getlocationzone(param_00);
	if(!isdefined(var_03) || !isdefined(var_04))
	{
		return;
	}

	if((var_03 == var_01 && var_04 == var_02) || var_03 == var_02 && var_04 == var_01)
	{
		maps\mp\gametypes\zombies::givezombieachievement("DLC4_ZOMBIE_COAST2COAST");
	}
}

//Function Number: 11
playertelefragzombie(param_00,param_01)
{
	if(!isdefined(param_00) || !isagent(param_00) || !isalive(param_00) || !isdefined(param_00.team) || param_00.team != level.enemyteam || !isdefined(param_00.agent_type))
	{
		return;
	}

	if(param_00 maps\mp\zombies\_util::instakillimmune())
	{
		return;
	}

	param_00 dodamage(param_00.health + 1,param_01,self,self,"MOD_CRUSH","teleport_zombies_mp");
}

//Function Number: 12
playerteleportaudio()
{
	self playsoundtoplayer("teleport_player",self);
	self playsoundtoteam("teleport_npc","allies",self);
}

//Function Number: 13
findsafeposition(param_00,param_01,param_02)
{
	if(maps\mp\zombies\_util::isplayerteleporting(self))
	{
		return;
	}

	foreach(var_04 in level.teleport_grenade_override_triggers)
	{
		if(ispointinvolume(param_00,var_04))
		{
			var_05 = common_scripts\utility::getstruct(var_04.target,"targetname");
			return var_05.origin;
		}
	}

	foreach(var_06 in level.teleport_grenade_ignore_triggers)
	{
		if(ispointinvolume(param_01,var_06))
		{
			return;
		}
	}

	var_09 = findlastzone(param_01,param_02,var_03);
	if(!isdefined(var_09))
	{
		return;
	}

	var_0A = maps\mp\zombies\_zombies_zone_manager::ispointinanyzonereturn(param_01,1);
	if(isdefined(var_0A) && var_0A == var_09)
	{
		var_0B = anglestoup(param_02);
		var_0C = var_0B[2] > 0.8;
		if(var_0C && teleporttrace(param_01,self))
		{
			return param_01;
		}
	}

	var_0D = vectornormalize(var_03 - param_01);
	var_0E = param_01 + var_0D * 30;
	var_0F = 50;
	var_10 = 0;
	var_11 = 100;
	var_12 = 50;
	var_13 = getclosestnodeteleport(param_01,var_10,var_0F,var_11,var_12,0,var_09);
	var_0F = 1500;
	var_12 = 1000;
	if(!isdefined(var_13))
	{
		var_13 = getclosestnodeteleport(var_0E,var_10,var_0F,var_11,var_12,1,var_09);
	}

	if(!isdefined(var_13))
	{
		var_13 = getclosestnodeteleport(var_0E,var_10,var_0F,var_11,var_12,0,var_09);
	}

	if(isdefined(var_13))
	{
		return var_13.origin;
	}
}

//Function Number: 14
findlastzone(param_00,param_01,param_02)
{
	var_03 = 100;
	var_04 = 0;
	var_05 = param_02 - param_00;
	var_06 = length(var_05);
	var_07 = vectornormalize(var_05);
	if(isdefined(level.zmbteleportgrenadefindzonecustom))
	{
		var_08 = [[ level.zmbteleportgrenadefindzonecustom ]](param_00,param_01,param_02);
		if(isdefined(var_08))
		{
			return var_08;
		}
	}

	for(;;)
	{
		var_09 = param_00 + var_07 * var_04;
		var_0A = maps\mp\zombies\_zombies_zone_manager::ispointinanyzonereturn(var_09,1);
		if(isdefined(var_0A) && maps\mp\zombies\_zombies_zone_manager::iszoneenabled(var_0A))
		{
			return var_0A;
		}

		if(var_04 == var_06)
		{
			break;
		}

		var_04 = var_04 + var_03;
		if(var_04 > var_06)
		{
			var_04 = var_06;
		}
	}

	var_0A = maps\mp\zombies\_zombies_zone_manager::getplayerzone();
	if(isdefined(var_0A))
	{
		return var_0A;
	}
}

//Function Number: 15
getclosestnodeteleport(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	var_07 = 200;
	var_08 = param_01;
	var_09 = param_01 + param_03;
	var_0A = gettime() + var_07;
	var_0B = 3;
	var_0C = 0;
	while(var_09 < param_02 || var_08 < param_02)
	{
		var_0D = getnodesinradius(param_00,var_09,var_08,param_04);
		if(var_0D.size > 0)
		{
			if(var_0D.size > 1)
			{
				var_0D = sortbydistance(var_0D,param_00,undefined,1);
			}

			foreach(var_0F in var_0D)
			{
				if(isdefined(var_0F.zombieszone) && !maps\mp\zombies\_zombies_zone_manager::iszoneenabled(var_0F.zombieszone))
				{
					continue;
				}

				if(isdefined(var_0F.zombieszone) && param_06 != var_0F.zombieszone)
				{
					continue;
				}

				if(var_0C >= var_0B)
				{
					if(gettime() >= var_0A)
					{
						return;
					}

					var_0C = 0;
					wait 0.05;
				}

				var_10 = 1;
				if(param_05)
				{
					var_11 = bullettrace(param_00,var_0F.origin,0,self,0,0,0,0,0,0,0);
					var_0C++;
					var_10 = var_11["fraction"] == 1;
				}

				if(var_10)
				{
					if(maps\mp\zombies\_util::nodeisinspawncloset(var_0F))
					{
						if(param_05)
						{
							var_12 = findnodeoutsideofspawncloset(var_0F,param_06);
							if(isdefined(var_12))
							{
								return var_12;
							}
						}

						continue;
					}

					return var_0F;
				}
			}
		}

		var_08 = var_08 + param_03;
		var_09 = var_09 + param_03;
		if(var_09 > param_02)
		{
			var_09 = param_02;
		}

		if(var_08 == var_09)
		{
			break;
		}
	}
}

//Function Number: 16
findnodeoutsideofspawncloset(param_00,param_01)
{
	var_02 = getlinkednodes(param_00);
	var_03 = [param_00];
	for(var_04 = 0;var_04 < var_02.size;var_04++)
	{
		var_05 = var_02[var_04];
		if(!maps\mp\zombies\_util::nodeisinspawncloset(var_05) && var_05.zombieszone == param_01)
		{
			return var_05;
		}

		var_03[var_03.size] = var_05;
		if(maps\mp\zombies\_util::nodeisinspawncloset(var_05))
		{
			var_06 = getlinkednodes(var_05);
			foreach(var_08 in var_06)
			{
				if(common_scripts\utility::array_contains(var_03,var_08) || common_scripts\utility::array_contains(var_02,var_08))
				{
					continue;
				}

				var_02[var_02.size] = var_08;
			}
		}
	}
}

//Function Number: 17
teleporttrace(param_00,param_01,param_02)
{
	var_03 = 30;
	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	foreach(var_05 in level.orbitaldropmarkers)
	{
		var_06 = var_03 * 2;
		var_07 = var_06 * var_06;
		var_08 = distance2dsquared(var_05.origin,param_00);
		if(var_08 < var_07)
		{
			return 0;
		}
	}

	var_0A = playerphysicstraceinfo(param_00,param_00,param_01);
	return var_0A["fraction"] == 1;
}

//Function Number: 18
playerteleportedvo()
{
	self endon("disconnect");
	wait(0.4);
	var_00 = 0;
	if(!isdefined(self.firstteleport))
	{
		var_00 = 1;
		self.firstteleport = 1;
	}

	maps\mp\zombies\_zombies_audio::create_and_play_dialog("general","teleport_use",undefined,undefined,var_00);
}