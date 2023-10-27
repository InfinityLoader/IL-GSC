/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\killstreaks\_dronehive.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 21
 * Decompile Time: 348 ms
 * Timestamp: 10/27/2023 1:32:25 AM
*******************************************************************/

//Function Number: 1
func_44DF()
{
	level.killstreakfuncs["drone_hive"] = ::tryusedronehive;
	level.dronemissilespawnarray = getentarray("remoteMissileSpawn","targetname");
	foreach(var_01 in level.dronemissilespawnarray)
	{
		var_01.targetent = getent(var_01.target,"targetname");
	}
}

//Function Number: 2
tryusedronehive(param_00,param_01)
{
	return func_87B7(self,param_00);
}

//Function Number: 3
func_87B7(param_00,param_01)
{
	if(isdefined(self.underwater) && self.underwater)
	{
		return 0;
	}

	param_00 maps\mp\_utility::func_720F("remotemissile");
	param_00 maps\mp\_utility::func_350E(1);
	param_00 common_scripts\utility::_disableweaponswitch();
	level thread func_537F(param_00);
	level thread func_5390(param_00);
	level thread func_53B1(param_00);
	var_02 = param_00 maps\mp\killstreaks\_killstreaks::func_4649("drone_hive");
	if(var_02 == "success")
	{
		param_00 maps\mp\_utility::func_350E(0);
		level thread func_698A(param_00,param_01);
	}
	else
	{
		param_00 notify("end_kill_streak");
		param_00 maps\mp\_utility::func_1D59();
		param_00 common_scripts\utility::_enableweaponswitch();
	}

	return var_02 == "success";
}

//Function Number: 4
watchhostmigrationstartedinit(param_00)
{
	param_00 endon("killstreak_disowned");
	param_00 endon("disconnect");
	level endon("game_ended");
	self endon("death");
	for(;;)
	{
		level waittill("host_migration_begin");
		if(isdefined(self))
		{
			param_00 visionsetmissilecamforplayer(game["thermal_vision"],0);
			param_00 maps\mp\_utility::set_visionset_for_watching_players("default",0,undefined,1);
			param_00 thermalvisionfofoverlayon();
			continue;
		}

		param_00 setclientomnvar("ui_predator_missile",2);
	}
}

//Function Number: 5
watchhostmigrationfinishedinit(param_00)
{
	param_00 endon("killstreak_disowned");
	param_00 endon("disconnect");
	level endon("game_ended");
	self endon("death");
	for(;;)
	{
		level waittill("host_migration_end");
		if(isdefined(self))
		{
			param_00 setclientomnvar("ui_predator_missile",1);
			param_00 setclientomnvar("ui_predator_missiles_left",self.missilesleft);
			continue;
		}

		param_00 setclientomnvar("ui_predator_missile",2);
	}
}

//Function Number: 6
func_698A(param_00,param_01)
{
	param_00 endon("killstreak_disowned");
	level endon("game_ended");
	param_00 notifyonplayercommand("missileTargetSet","+attack");
	param_00 notifyonplayercommand("missileTargetSet","+attack_akimbo_accessible");
	var_02 = func_3A3C(param_00,level.dronemissilespawnarray);
	var_03 = var_02.origin;
	var_04 = var_02.targetent.origin;
	var_05 = vectornormalize(var_03 - var_04);
	var_03 = var_05 * 14000 + var_04;
	var_06 = magicbullet("drone_hive_projectile_mp",var_03,var_04,param_00);
	var_06 setcandamage(1);
	var_06 physicsgetangspeed();
	var_06 enablemissilestick(1);
	var_06.team = param_00.team;
	var_06.lifeid = param_01;
	var_06.type = "remote";
	var_06.owner = param_00;
	var_06.entitynumber = var_06 getentitynumber();
	level.rockets[var_06.entitynumber] = var_06;
	level.remotemissileinprogress = 1;
	level thread func_537D(var_06,1);
	level thread func_5375(var_06);
	if(isdefined(param_00.killsthislifeperweapon))
	{
		param_00.killsthislifeperweapon["drone_hive_projectile_mp"] = 0;
		param_00.killsthislifeperweapon["switch_blade_child_mp"] = 0;
	}

	func_52C3(param_00,var_06);
	param_00 setclientomnvar("ui_predator_missile",1);
	var_06 thread watchhostmigrationstartedinit(param_00);
	var_06 thread watchhostmigrationfinishedinit(param_00);
	var_07 = 0;
	var_06.missilesleft = 2;
	param_00 setclientomnvar("ui_predator_missiles_left",2);
	for(;;)
	{
		var_08 = var_06 common_scripts\utility::func_8B33("death","missileTargetSet");
		maps\mp\gametypes\_hostmigration::func_8BBA();
		if(var_08 == "death")
		{
			break;
		}

		if(!isdefined(var_06))
		{
			break;
		}

		if(var_07 < 2)
		{
			level thread func_78C2(var_06,var_07);
			var_07++;
			var_06.missilesleft = 2 - var_07;
			param_00 setclientomnvar("ui_predator_missiles_left",var_06.missilesleft);
			if(var_07 == 2)
			{
				var_06 disablemissileboosting();
			}
		}
	}

	thread func_6687(param_00);
}

//Function Number: 7
func_53A3()
{
	level endon("game_ended");
	self endon("death");
	var_00 = [];
	var_01 = [];
	for(;;)
	{
		var_02 = [];
		var_00 = func_3A99();
		foreach(var_04 in var_00)
		{
			var_05 = self.owner worldpointinreticle_circle(var_04.origin,65,90);
			if(var_05)
			{
				self.owner thread maps\mp\_utility::func_2A7E(self.origin,var_04.origin,10,(0,0,1));
				var_02[var_02.size] = var_04;
			}
		}

		if(var_02.size)
		{
			var_01 = sortbydistance(var_02,self.origin);
			self.lasttargetlocked = var_01[0];
			maps\mp\gametypes\_hostmigration::func_8B0D(0.25);
		}

		wait(0.05);
		maps\mp\gametypes\_hostmigration::func_8BBA();
	}
}

//Function Number: 8
func_3A99(param_00)
{
	var_01 = [];
	foreach(var_03 in level.participants)
	{
		if(param_00 maps\mp\_utility::isenemy(var_03) && !var_03 maps\mp\_utility::_hasperk("specialty_blindeye"))
		{
			var_01[var_01.size] = var_03;
		}
	}

	var_05 = maps\mp\gametypes\_weapons::func_4EE2();
	if(var_01.size && var_05.size)
	{
		var_06 = common_scripts\utility::array_combine(var_01,var_05);
		return var_06;
	}

	if(var_02.size)
	{
		return var_02;
	}

	return var_06;
}

//Function Number: 9
func_78C2(param_00,param_01)
{
	param_00.owner playlocalsound("ammo_crate_use");
	var_02 = param_00 gettagangles("tag_camera");
	var_03 = anglestoforward(var_02);
	var_04 = anglestoright(var_02);
	var_05 = (35,35,35);
	var_06 = (15000,15000,15000);
	if(param_01)
	{
		var_05 = var_05 * -1;
	}

	var_07 = bullettrace(param_00.origin,param_00.origin + var_03 * var_06,0,param_00);
	var_06 = var_06 * var_07["fraction"];
	var_08 = param_00.origin + var_04 * var_05;
	var_09 = param_00.origin + var_03 * var_06;
	var_0A = param_00.owner func_3A99(param_00.owner);
	var_0B = magicbullet("switch_blade_child_mp",var_08,var_09,param_00.owner);
	foreach(var_0D in var_0A)
	{
		if(function_0210(var_0D.origin,var_09) < 262144)
		{
			var_0B missilesettargetent(var_0D);
			break;
		}
	}

	var_0B setcandamage(1);
	var_0B enablemissilestick(1);
	var_0B.team = param_00.team;
	var_0B.lifeid = param_00.lifeid;
	var_0B.type = param_00.type;
	var_0B.owner = param_00.owner;
	var_0B.entitynumber = var_0B getentitynumber();
	level.rockets[var_0B.entitynumber] = var_0B;
	level thread func_537D(var_0B,0);
}

//Function Number: 10
func_4F89(param_00,param_01)
{
	param_01 endon("death");
	level endon("game_ended");
	self endon("death");
	for(;;)
	{
		triggerfx(param_00);
		wait(0.25);
	}
}

//Function Number: 11
getnextmissilespawnindex(param_00)
{
	var_01 = param_00 + 1;
	if(var_01 == level.dronemissilespawnarray.size)
	{
		var_01 = 0;
	}

	return var_01;
}

//Function Number: 12
func_5375(param_00)
{
	param_00 endon("death");
	for(;;)
	{
		param_00.owner waittill("missileTargetSet");
		param_00 notify("missileTargetSet");
	}
}

//Function Number: 13
func_3A3C(param_00,param_01)
{
	var_02 = [];
	foreach(var_04 in level.players)
	{
		if(!maps\mp\_utility::func_4945(var_04))
		{
			continue;
		}

		if(var_04.team == param_00.team)
		{
			continue;
		}

		if(var_04.team == "spectator")
		{
			continue;
		}

		var_02[var_02.size] = var_04;
	}

	if(!var_02.size)
	{
		return param_01[randomint(param_01.size)];
	}

	var_06 = common_scripts\utility::array_randomize(param_01);
	var_07 = var_06[0];
	foreach(var_09 in var_06)
	{
		var_09.sightedenemies = 0;
		for(var_0A = 0;var_0A < var_02.size;var_0A++)
		{
			var_0B = var_02[var_0A];
			if(!maps\mp\_utility::func_4945(var_0B))
			{
				var_02[var_0A] = var_02[var_02.size - 1];
				var_02[var_02.size - 1] = undefined;
				var_0A--;
				continue;
			}

			if(bullettracepassed(var_0B.origin + (0,0,32),var_09.origin,0,var_0B))
			{
				var_09.sightedenemies = var_09.sightedenemies + 1;
				return var_09;
			}

			wait(0.05);
			maps\mp\gametypes\_hostmigration::func_8BBA();
		}

		if(var_09.sightedenemies == var_02.size)
		{
			return var_09;
		}

		if(var_09.sightedenemies > var_07.sightedenemies)
		{
			var_07 = var_09;
		}
	}

	return var_07;
}

//Function Number: 14
func_52C3(param_00,param_01)
{
	var_02 = 1;
	param_00 maps\mp\_utility::func_350E(1);
	param_00 cameralinkto(param_01,"tag_origin");
	param_00 controlslinkto(param_01);
	param_00 visionsetmissilecamforplayer("default",var_02);
	param_00 thread maps\mp\_utility::set_visionset_for_watching_players("default",var_02,undefined,1);
	param_00 visionsetmissilecamforplayer(game["thermal_vision"],1);
	param_00 thread delayedfofoverlay();
	level thread func_85A0(param_00,var_02);
}

//Function Number: 15
delayedfofoverlay()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	maps\mp\gametypes\_hostmigration::func_8B0D(0.25);
	self thermalvisionfofoverlayon();
}

//Function Number: 16
func_85A0(param_00,param_01,param_02)
{
	param_00 endon("disconnect");
	maps\mp\gametypes\_hostmigration::func_8B0D(param_01 - 0.35);
	param_00 maps\mp\_utility::func_350E(0);
}

//Function Number: 17
func_537F(param_00)
{
	param_00 endon("disconnect");
	param_00 endon("end_kill_streak");
	param_00 waittill("killstreak_disowned");
	level thread func_6687(param_00);
}

//Function Number: 18
func_5390(param_00)
{
	param_00 endon("disconnect");
	param_00 endon("end_kill_streak");
	level waittill("game_ended");
	level thread func_6687(param_00);
}

//Function Number: 19
func_53B1(param_00)
{
	param_00 endon("end_kill_streak");
	param_00 endon("disconnect");
	level waittill("objective_cam");
	level thread func_6687(param_00,1);
}

//Function Number: 20
func_537D(param_00,param_01)
{
	param_00 waittill("death");
	maps\mp\gametypes\_hostmigration::func_8BBA();
	if(isdefined(param_00.targeffect))
	{
		param_00.targeffect delete();
	}

	if(isdefined(param_00.entitynumber))
	{
		level.rockets[param_00.entitynumber] = undefined;
	}

	if(param_01)
	{
		level.remotemissileinprogress = undefined;
	}
}

//Function Number: 21
func_6687(param_00,param_01)
{
	if(!isdefined(param_00))
	{
	}

	param_00 setclientomnvar("ui_predator_missile",2);
	param_00 notify("end_kill_streak");
	param_00 maps\mp\_utility::func_350E(1);
	param_00 thermalvisionfofoverlayoff();
	param_00 controlsunlink();
	if(!isdefined(param_01))
	{
		maps\mp\gametypes\_hostmigration::func_8B0D(0.95);
	}

	param_00 cameraunlink();
	param_00 setclientomnvar("ui_predator_missile",0);
	param_00 maps\mp\_utility::func_1D59();
	param_00 common_scripts\utility::_enableweaponswitch();
}