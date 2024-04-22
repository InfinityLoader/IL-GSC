/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\killstreaks\streak_mp_recovery.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 33
 * Decompile Time: 534 ms
 * Timestamp: 4/22/2024 2:12:42 AM
*******************************************************************/

//Function Number: 1
init()
{
	level.mp_recovery_killstreak = spawnstruct();
	level.mp_recovery_killstreak.killstreak_inuse = 0;
	level.mp_recovery_killstreak.killstreak_duration = 25;
	level.mp_recovery_killstreak.speed_scale = 1.25;
	level.mp_recovery_killstreak.health_scale = 1.75;
	level.mp_recovery_killstreak.max_health_amplify_object = 1500;
	level.mp_recovery_killstreak.exo_super_vfx = loadfx("vfx/lights/air_light_exosuper_yellow");
	level.mp_recovery_killstreak.amplify_vfx = loadfx("vfx/lights/air_light_amplifymachine_yellow");
	var_00 = getent("damage_ring_01","targetname");
	var_01 = getent("damage_ring_02","targetname");
	level.mp_recovery_killstreak.damageringsarray = [var_00,var_01];
	foreach(var_03 in level.mp_recovery_killstreak.damageringsarray)
	{
		var_03 hudoutlineenable(1,1);
		var_03 setcandamage(1);
		var_03 setcanradiusdamage(1);
		var_03.max_fake_health = level.mp_recovery_killstreak.max_health_amplify_object;
		var_03.health = var_03.max_fake_health;
		var_03.maxhealth = var_03.max_fake_health;
		var_03.fakehealth = var_03.max_fake_health;
		var_04 = common_scripts\utility::getstructarray(var_03.target,"targetname");
		var_03.tag_array = [];
		foreach(var_06 in var_04)
		{
			var_07 = common_scripts\utility::spawn_tag_origin();
			var_07.origin = var_06.origin;
			var_07 show();
			var_03.tag_array[var_03.tag_array.size] = var_07;
		}
	}

	precachestring(&"KILLSTREAKS_MP_RECOVERY");
	level.killstreakfuncs["mp_recovery"] = ::tryusemprecovery;
	level.mapkillstreak = "mp_recovery";
	level thread onrecoveryplayerconnect();
}

//Function Number: 2
tryusemprecovery(param_00,param_01)
{
	if(level.mp_recovery_killstreak.killstreak_inuse)
	{
		self iprintlnbold(&"MP_RECOVERY_IN_USE");
		return 0;
	}

	if(maps\mp\_utility::isusingremote())
	{
		return 0;
	}

	if(maps\mp\_utility::isairdenied())
	{
		return 0;
	}

	if(maps\mp\_utility::isemped())
	{
		return 0;
	}

	var_02 = exoteambuffsetup(self);
	if(isdefined(var_02) && var_02)
	{
		maps\mp\_matchdata::logkillstreakevent("mp_recovery",self.origin);
	}

	return var_02;
}

//Function Number: 3
exoteambuffsetup(param_00)
{
	if(isdefined(param_00))
	{
		level.mp_recovery_killstreak.killstreak_inuse = 1;
		level.mp_recovery_killstreak.owner = param_00;
		level.mp_recovery_killstreak.killstreak_team = param_00.team;
	}
	else
	{
		return 0;
	}

	var_01 = param_00.team;
	thread startexorecoverykillstreak(param_00,var_01);
	return 1;
}

//Function Number: 4
startexorecoverykillstreak(param_00,param_01)
{
	setupamplifierdamagemonitor(param_00,param_01);
	sortplayersandgivepowers(param_00,param_01);
	thread setmapkillstreaktimer();
	level common_scripts\utility::waittill_any("time_up","amplifier_destroyed");
	shutoffamplifyobjectvfx();
	shutoffallplayersexobuffs();
	level notify("recovery_streak_over");
	wait(0.25);
	level.mp_recovery_killstreak.killstreak_inuse = 0;
}

//Function Number: 5
setmapkillstreaktimer()
{
	level endon("recovery_streak_over");
	wait(level.mp_recovery_killstreak.killstreak_duration);
	level notify("time_up");
}

//Function Number: 6
setupamplifierdamagemonitor(param_00,param_01)
{
	var_02 = "atlas";
	var_03 = "axis";
	if(param_01 == "axis")
	{
		var_02 = "atlas";
		var_03 = "allies";
	}
	else if(param_01 == "allies")
	{
		var_02 = "sentinel";
		var_03 = "axis";
	}

	var_04 = "faction_128_" + var_02;
	foreach(var_06 in level.mp_recovery_killstreak.damageringsarray)
	{
		var_06 setcandamage(1);
		var_06 setcanradiusdamage(1);
		var_06.health = var_06.max_fake_health;
		var_06.maxhealth = var_06.max_fake_health;
		var_06.fakehealth = var_06.max_fake_health;
		var_06 thread startamplifyobjectvfx();
		var_06 thread monitoramplifierdamage(param_00,param_01);
		if(level.dynamiceventstatus == "before" && var_06.targetname == "damage_ring_02")
		{
			continue;
		}
		else if(level.dynamiceventstatus == "after" && var_06.targetname == "damage_ring_01")
		{
			continue;
		}

		if(level.teambased == 0)
		{
			foreach(var_08 in level.players)
			{
				if(var_08 != param_00)
				{
					var_06 maps\mp\_entityheadicons::setheadicon(var_08,var_04,(0,0,0),18,18,undefined,undefined,undefined,1,0,0);
				}
			}

			continue;
		}

		if(level.teambased == 1)
		{
			var_06 maps\mp\_entityheadicons::setheadicon(var_03,var_04,(0,0,0),18,18,undefined,undefined,undefined,1,0,0);
		}
	}
}

//Function Number: 7
monitoramplifierdamage(param_00,param_01)
{
	level endon("recovery_streak_over");
	while(level.mp_recovery_killstreak.killstreak_inuse == 1)
	{
		self waittill("damage",var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09,var_0A,var_0B);
		if(!isvalidstreakplayer(var_03,param_00,param_01))
		{
			self.fakehealth = self.fakehealth + var_02 * -1;
			if(self.fakehealth <= 0)
			{
				level notify("amplifier_destroyed");
				return;
			}
		}
	}
}

//Function Number: 8
startamplifyobjectvfx()
{
	foreach(var_01 in level.mp_recovery_killstreak.damageringsarray)
	{
		foreach(var_03 in var_01.tag_array)
		{
			playfxontag(level.mp_recovery_killstreak.amplify_vfx,var_03,"tag_origin");
		}
	}
}

//Function Number: 9
shutoffamplifyobjectvfx()
{
	shutoffplayerhudoutline();
	foreach(var_01 in level.mp_recovery_killstreak.damageringsarray)
	{
		var_01 destroyplayericons();
		foreach(var_03 in var_01.tag_array)
		{
			stopfxontag(level.mp_recovery_killstreak.amplify_vfx,var_03,"tag_origin");
		}
	}
}

//Function Number: 10
destroyplayericons()
{
	if(isdefined(self.entityheadicons))
	{
		if(isdefined(self.entityheadicons["allies"]))
		{
			self.entityheadicons["allies"] destroy();
			self.entityheadicons["allies"] = undefined;
		}

		if(isdefined(self.entityheadicons["axis"]))
		{
			self.entityheadicons["axis"] destroy();
			self.entityheadicons["axis"] = undefined;
		}

		foreach(var_01 in level.players)
		{
			if(isdefined(self.entityheadicons[var_01.guid]))
			{
				self.entityheadicons[var_01.guid] destroy();
				self.entityheadicons[var_01.guid] = undefined;
			}
		}
	}
}

//Function Number: 11
shutoffplayerhudoutline()
{
	foreach(var_01 in level.players)
	{
		foreach(var_03 in level.mp_recovery_killstreak.damageringsarray)
		{
			var_03 hudoutlinedisableforclient(var_01);
		}
	}
}

//Function Number: 12
turnonplayerhudoutline(param_00,param_01)
{
	foreach(var_03 in level.players)
	{
		if(!isvalidstreakplayer(var_03,param_00,param_01))
		{
			foreach(var_05 in level.mp_recovery_killstreak.damageringsarray)
			{
				var_05 hudoutlineenableforclient(var_03,1,1);
			}
		}
	}
}

//Function Number: 13
sortplayersandgivepowers(param_00,param_01)
{
	foreach(var_03 in level.players)
	{
		if(isvalidstreakplayer(var_03,param_00,param_01) == 1)
		{
			if(maps\mp\_utility::isreallyalive(var_03))
			{
				var_03 setupsuperexo();
				var_03 thread givesuperexo();
			}
		}

		var_03 thread monitorspawndurringstreak(param_00,param_01);
	}

	thread monitorconnectedduringstreak(param_00,param_01);
}

//Function Number: 14
shutoffallplayersexobuffs()
{
	foreach(var_01 in level.players)
	{
		var_01 shutoffexobuffs();
	}
}

//Function Number: 15
shutoffexobuffs()
{
	if(isdefined(self.superexosettings) && isdefined(self.superexosettings.isactive))
	{
		self.superexosettings.isactive = 0;
	}

	shutoffspeed();
	shutofffx();
	shutoffhealth();
	shutoffslam();
}

//Function Number: 16
shutoffslam()
{
	if(isdefined(self.cac_has_slam) && self.cac_has_slam == 1)
	{
	}
	else if(maps\mp\_utility::_hasperk("specialty_exo_slamboots"))
	{
		maps\mp\_utility::_unsetperk("specialty_exo_slamboots");
	}

	self.cac_has_slam = undefined;
}

//Function Number: 17
shutoffspeed()
{
	self.movespeedscaler = level.baseplayermovescale;
	if(maps\mp\_utility::_hasperk("specialty_lightweight"))
	{
		self.movespeedscaler = maps\mp\_utility::lightweightscalar();
	}

	maps\mp\gametypes\_weapons::updatemovespeedscale();
}

//Function Number: 18
shutoffhealth()
{
	self.maxhealth = int(self.maxhealth / level.mp_recovery_killstreak.health_scale);
	if(self.health > self.maxhealth)
	{
		self.health = self.maxhealth;
	}

	self.healthregenlevel = undefined;
}

//Function Number: 19
shutofffx()
{
	if(isdefined(self.superexosettings) && isdefined(self.superexosettings.overlay))
	{
		self.superexosettings.overlay destroy();
	}

	if(isdefined(level.mp_recovery_killstreak.exo_super_vfx))
	{
		if(maps\mp\_utility::isreallyalive(self))
		{
			stopfxontag(level.mp_recovery_killstreak.exo_super_vfx,self,"tag_shield_back");
			stopfxontag(level.mp_recovery_killstreak.exo_super_vfx,self,"j_knee_le");
			stopfxontag(level.mp_recovery_killstreak.exo_super_vfx,self,"j_knee_ri");
		}
	}
}

//Function Number: 20
givesuperexo()
{
	setupsuperexo();
	self.superexosettings.isactive = 1;
	givesuperspeed();
	givesuperhealth();
	givesuperstomp();
	givesuperpunch();
	givesuperrepulse();
	turnonsuperfx();
	thread watchfordeath();
}

//Function Number: 21
watchfordeath()
{
	level endon("game_ended");
	level endon("recovery_streak_over");
	self endon("disconnect");
	self waittill("death");
	if(level.mp_recovery_killstreak.killstreak_inuse == 1)
	{
		shutoffexobuffs();
	}
}

//Function Number: 22
givesuperspeed()
{
	self endon("death");
	self endon("disconnect");
	self endon("joined_team");
	self endon("faux_spawn");
	self.movespeedscaler = level.mp_recovery_killstreak.speed_scale;
	maps\mp\gametypes\_weapons::updatemovespeedscale();
}

//Function Number: 23
givesuperhealth()
{
	self endon("death");
	self endon("disconnect");
	self endon("joined_team");
	self endon("faux_spawn");
	self.maxhealth = int(self.maxhealth * level.mp_recovery_killstreak.health_scale);
	self.ignoreregendelay = 1;
	self.healthregenlevel = 0.99;
	self notify("damage");
}

//Function Number: 24
givesuperstomp()
{
	self endon("death");
	self endon("disconnect");
	self endon("joined_team");
	self endon("faux_spawn");
	self.cac_has_slam = undefined;
	if(maps\mp\_utility::_hasperk("specialty_exo_slamboots"))
	{
		self.cac_has_slam = 1;
		return;
	}

	maps\mp\_utility::giveperk("specialty_exo_slamboots",0);
	self.cac_has_slam = 0;
}

//Function Number: 25
givesuperpunch()
{
	self endon("death");
	self endon("disconnect");
	self endon("joined_team");
	self endon("faux_spawn");
}

//Function Number: 26
givesuperrepulse()
{
	self endon("death");
	self endon("disconnect");
	self endon("joined_team");
	self endon("faux_spawn");
	thread maps\mp\_exo_repulsor::do_exo_repulsor();
}

//Function Number: 27
turnonsuperfx()
{
	self endon("death");
	self endon("disconnect");
	self endon("joined_team");
	self endon("faux_spawn");
	if(!isdefined(self.superexosettings.overlay))
	{
		self.superexosettings.overlay = newclienthudelem(self);
		self.superexosettings.overlay.x = 0;
		self.superexosettings.overlay.y = 0;
		self.superexosettings.overlay.horzalign = "fullscreen";
		self.superexosettings.overlay.vertalign = "fullscreen";
		self.superexosettings.overlay setshader("exo_hud_cloak_overlay",640,480);
		self.superexosettings.overlay.archive = 1;
		self.superexosettings.overlay.alpha = 1;
	}

	if(isdefined(level.mp_recovery_killstreak.exo_super_vfx))
	{
		playfxontag(level.mp_recovery_killstreak.exo_super_vfx,self,"tag_shield_back");
		playfxontag(level.mp_recovery_killstreak.exo_super_vfx,self,"j_knee_le");
		playfxontag(level.mp_recovery_killstreak.exo_super_vfx,self,"j_knee_ri");
	}
}

//Function Number: 28
setupsuperexo()
{
	if(!isdefined(self.superexosettings))
	{
		self.superexosettings = spawnstruct();
	}

	if(!isdefined(level.mp_recovery_killstreak.exo_super_vfx))
	{
		level.mp_recovery_killstreak.exo_super_vfx = loadfx("vfx/lights/air_light_exosuper_yellow");
	}

	self.superexosettings.isactive = 0;
}

//Function Number: 29
isvalidstreakplayer(param_00,param_01,param_02)
{
	if(level.teambased == 0 && isdefined(param_01) && param_00 == param_01)
	{
		return 1;
	}

	if(level.teambased == 1 && param_00.team == param_02)
	{
		return 1;
	}

	return 0;
}

//Function Number: 30
monitorspawndurringstreak(param_00,param_01)
{
	self endon("disconnect");
	level endon("game_ended");
	level endon("recovery_streak_over");
	while(level.mp_recovery_killstreak.killstreak_inuse == 1)
	{
		self waittill("spawned_player");
		if(isvalidstreakplayer(self,param_00,param_01) == 1)
		{
			wait(0.25);
			if(level.mp_recovery_killstreak.killstreak_inuse == 1)
			{
				setupsuperexo();
				thread givesuperexo();
			}
		}
	}
}

//Function Number: 31
monitorconnectedduringstreak(param_00,param_01)
{
	level endon("game_ended");
	level endon("recovery_streak_over");
	while(level.mp_recovery_killstreak.killstreak_inuse == 1)
	{
		level waittill("connected",var_02);
		var_02 monitorspawndurringstreak(param_00,param_01);
	}
}

//Function Number: 32
onrecoveryplayerconnect()
{
	level endon("game_ended");
	for(;;)
	{
		level waittill("connected",var_00);
		foreach(var_02 in level.mp_recovery_killstreak.damageringsarray)
		{
			var_02 hudoutlinedisableforclient(var_00);
		}

		var_00 thread onrecoveryplayerdisconnect();
	}
}

//Function Number: 33
onrecoveryplayerdisconnect()
{
	level endon("game_ended");
	self waittill("disconnect");
}