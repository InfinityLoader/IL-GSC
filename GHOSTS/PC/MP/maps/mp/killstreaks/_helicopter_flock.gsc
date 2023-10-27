/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\killstreaks\_helicopter_flock.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 18
 * Decompile Time: 353 ms
 * Timestamp: 10/27/2023 1:20:55 AM
*******************************************************************/

//Function Number: 1
func_44DF()
{
	precachevehicle("attack_littlebird_mp");
	precachemodel("vehicle_apache_mp");
	precachemodel("vehicle_apache_mg");
	precacheturret("apache_minigun_mp");
	precachevehicle("apache_strafe_mp");
	level.killstreakfuncs["littlebird_flock"] = ::func_843F;
	level.heli_flock = [];
}

//Function Number: 2
func_843F(param_00,param_01)
{
	var_02 = 5;
	if(func_4159() || maps\mp\_utility::func_21E7() >= maps\mp\_utility::maxvehiclesallowed() || level.fauxvehiclecount + var_02 >= maps\mp\_utility::maxvehiclesallowed())
	{
		self iprintlnbold(&"KILLSTREAKS_TOO_MANY_VEHICLES");
		return 0;
	}

	maps\mp\_utility::func_4487();
	maps\mp\_utility::func_4487();
	maps\mp\_utility::func_4487();
	maps\mp\_utility::func_4487();
	maps\mp\_utility::func_4487();
	var_03 = func_6D81(param_00,"littlebird_flock");
	if(!isdefined(var_03) || !var_03)
	{
		maps\mp\_utility::decrementfauxvehiclecount();
		maps\mp\_utility::decrementfauxvehiclecount();
		maps\mp\_utility::decrementfauxvehiclecount();
		maps\mp\_utility::decrementfauxvehiclecount();
		maps\mp\_utility::decrementfauxvehiclecount();
		return 0;
	}

	level thread maps\mp\_utility::func_7FA0("used_littlebird_flock",self,self.team);
	return 1;
}

//Function Number: 3
func_4159()
{
	var_00 = 0;
	for(var_01 = 0;var_01 < level.heli_flock.size;var_01++)
	{
		if(isdefined(level.heli_flock[var_01]))
		{
			var_00 = 1;
			break;
		}
	}

	return var_00;
}

//Function Number: 4
func_6D81(param_00,param_01)
{
	self playlocalsound(game["voice"][self.team] + "KS_lbd_inposition");
	maps\mp\_utility::_beginlocationselection(param_01,"map_artillery_selector",1,500);
	self endon("stop_location_selection");
	self waittill("confirm_location",var_02,var_03);
	if(func_4159() || maps\mp\_utility::func_21E7() >= maps\mp\_utility::maxvehiclesallowed() || level.fauxvehiclecount >= maps\mp\_utility::maxvehiclesallowed())
	{
		self iprintlnbold(&"KILLSTREAKS_TOO_MANY_VEHICLES");
		self notify("cancel_location");
		return 0;
	}

	level.heli_flock = [];
	level.heli_flock_victims = [];
	thread littlebirdmadeselectionvo();
	thread func_329C(param_00,var_02,::callstrike,var_03);
	self setblurforplayer(0,0.3);
	return 1;
}

//Function Number: 5
littlebirdmadeselectionvo()
{
	self endon("death");
	self endon("disconnect");
	self playlocalsound(game["voice"][self.team] + "KS_hqr_littlebird");
	wait(3);
	self playlocalsound(game["voice"][self.team] + "KS_lbd_inbound");
}

//Function Number: 6
func_329C(param_00,param_01,param_02,param_03)
{
	self notify("used");
	wait(0.05);
	thread maps\mp\_utility::stoplocationselection(0);
	if(isdefined(self))
	{
		self thread [[ param_02 ]](param_00,param_01,param_03);
	}
}

//Function Number: 7
callstrike(param_00,param_01,param_02)
{
	level endon("game_ended");
	self endon("disconnect");
	thread handleownerleft();
	var_03 = func_3AAE(param_01,param_02,0);
	var_04 = func_3AAE(param_01,param_02,-520);
	var_05 = func_3AAE(param_01,param_02,520);
	var_06 = func_3AAE(param_01,param_02,-1040);
	var_07 = func_3AAE(param_01,param_02,1040);
	level thread dolbstrike(param_00,self,var_03,0);
	wait(0.3);
	level thread dolbstrike(param_00,self,var_04,1);
	level thread dolbstrike(param_00,self,var_05,2);
	wait(0.3);
	level thread dolbstrike(param_00,self,var_06,3);
	level thread dolbstrike(param_00,self,var_07,4);
	maps\mp\_matchdata::func_4F1D("littlebird_flock",param_01);
}

//Function Number: 8
func_3AAE(param_00,param_01,param_02)
{
	param_00 = param_00 * (1,1,0);
	var_03 = (0,param_01,0);
	var_04 = 12000;
	var_05 = [];
	if(isdefined(param_02) && param_02 != 0)
	{
		param_00 = param_00 + anglestoright(var_03) * param_02 + (0,0,randomint(300));
	}

	var_06 = param_00 + anglestoforward(var_03) * -1 * var_04;
	var_07 = param_00 + anglestoforward(var_03) * var_04;
	var_08 = maps\mp\killstreaks\_airdrop::func_3AB0(param_00) + 256;
	var_05["start"] = var_06 + (0,0,var_08);
	var_05["end"] = var_07 + (0,0,var_08);
	return var_05;
}

//Function Number: 9
dolbstrike(param_00,param_01,param_02,param_03)
{
	level endon("game_ended");
	if(!isdefined(param_01))
	{
	}

	var_04 = vectortoangles(param_02["end"] - param_02["start"]);
	var_05 = func_7862(param_01,param_02["start"],var_04,param_03);
	var_05.lifeid = param_00;
	var_05.alreadydead = 0;
	var_05 thread func_8D2E();
	var_05 thread func_8CD6();
	var_05 thread flock_handledamage();
	var_05 thread func_7ADF();
	var_05 thread monitorkills();
	var_05 endon("death");
	var_05 setmaxpitchroll(120,60);
	var_05 vehicle_setspeed(48,48);
	var_05 setvehgoalpos(param_02["end"],0);
	var_05 waittill("goal");
	var_05 setmaxpitchroll(30,40);
	var_05 vehicle_setspeed(32,32);
	var_05 setvehgoalpos(param_02["start"],0);
	wait(2);
	var_05 setmaxpitchroll(100,60);
	var_05 vehicle_setspeed(64,64);
	var_05 waittill("goal");
	var_05 notify("gone");
	var_05 maps\mp\killstreaks\_helicopter::func_659E();
}

//Function Number: 10
func_7862(param_00,param_01,param_02,param_03)
{
	var_04 = spawnhelicopter(param_00,param_01,param_02,"apache_strafe_mp","vehicle_apache_mp");
	if(!isdefined(var_04))
	{
	}

	var_04 maps\mp\killstreaks\_helicopter::addtolittlebirdlist();
	var_04 thread maps\mp\killstreaks\_helicopter::func_6590();
	var_04.health = 999999;
	var_04.maxhealth = 2000;
	var_04.damagetaken = 0;
	var_04 setcandamage(1);
	var_04.owner = param_00;
	var_04.team = param_00.team;
	var_04.killcount = 0;
	var_04.streakname = "littlebird_flock";
	var_04.helitype = "littlebird";
	var_04.specialdamagecallback = ::callback_vehicledamage;
	var_05 = spawnturret("misc_turret",var_04.origin,"apache_minigun_mp");
	var_05 linkto(var_04,"tag_turret",(0,0,0),(0,0,0));
	var_05 setmodel("vehicle_apache_mg");
	var_05.angles = var_04.angles;
	var_05.owner = var_04.owner;
	var_05.team = var_05.owner.team;
	var_05 maketurretinoperable();
	var_05.vehicle = var_04;
	var_06 = var_04.origin + anglestoforward(var_04.angles) * -200 + anglestoright(var_04.angles) * -200 + (0,0,50);
	var_05.killcament = spawn("script_model",var_06);
	var_05.killcament setscriptmoverkillcam("explosive");
	var_05.killcament linkto(var_04,"tag_origin");
	var_04.mgturret1 = var_05;
	var_04.mgturret1 setdefaultdroppitch(0);
	var_04.mgturret1 setmode("auto_nonai");
	var_04.mgturret1 setsentryowner(var_04.owner);
	if(level.teambased)
	{
		var_04.mgturret1 setturretteam(var_04.owner.team);
	}

	level.heli_flock[param_03] = var_04;
	return var_04;
}

//Function Number: 11
func_8D2E()
{
	level endon("game_ended");
	self endon("gone");
	self endon("death");
	maps\mp\gametypes\_hostmigration::func_8B0D(60);
	self notify("death");
}

//Function Number: 12
monitorkills()
{
	level endon("game_ended");
	self endon("gone");
	self endon("death");
	self endon("stopFiring");
	for(;;)
	{
		self waittill("killedPlayer",var_00);
		self.killcount++;
		level.heli_flock_victims[level.heli_flock_victims.size] = var_00;
	}
}

//Function Number: 13
func_7ADF()
{
	self endon("gone");
	self endon("death");
	self endon("stopFiring");
	for(;;)
	{
		self.mgturret1 waittill("turret_on_target");
		var_00 = 1;
		var_01 = self.mgturret1 getturrettarget(0);
		foreach(var_03 in level.heli_flock_victims)
		{
			if(var_01 == var_03)
			{
				self.mgturret1 cleartargetentity();
				var_00 = 0;
				break;
			}
		}

		if(var_00)
		{
			self.mgturret1 shootturret();
		}
	}
}

//Function Number: 14
handleownerleft()
{
	level endon("game_ended");
	self endon("flock_done");
	thread func_572B();
	self waittill("killstreak_disowned");
	for(var_00 = 0;var_00 < level.heli_flock.size;var_00++)
	{
		if(isdefined(level.heli_flock[var_00]))
		{
			level.heli_flock[var_00] notify("stopFiring");
		}
	}

	for(var_00 = 0;var_00 < level.heli_flock.size;var_00++)
	{
		if(isdefined(level.heli_flock[var_00]))
		{
			level.heli_flock[var_00] notify("death");
			wait(0.1);
		}
	}
}

//Function Number: 15
func_572B()
{
	level endon("game_ended");
	self endon("disconnect");
	if(!maps\mp\_utility::bot_is_fireteam_mode())
	{
		self endon("joined_team");
		self endon("joined_spectators");
	}

	while(func_4159())
	{
		wait(0.5);
	}

	self notify("flock_done");
}

//Function Number: 16
flock_handledamage()
{
	self endon("death");
	level endon("game_ended");
	for(;;)
	{
		self waittill("damage",var_00,var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09);
		if(isdefined(self.specialdamagecallback))
		{
			self [[ self.specialdamagecallback ]](undefined,var_01,var_00,var_08,var_04,var_09,var_03,var_02,undefined,undefined,var_05,var_07);
		}
	}
}

//Function Number: 17
callback_vehicledamage(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B)
{
	if(isdefined(self.alreadydead) && self.alreadydead)
	{
	}

	if(!isdefined(param_01) || param_01 == self)
	{
	}

	if(!maps\mp\gametypes\_weapons::func_357F(self.owner,param_01))
	{
	}

	if(isdefined(param_03) && param_03 & level.idflags_penetration)
	{
		self.wasdamagedfrombulletpenetration = 1;
	}

	self.wasdamaged = 1;
	var_0C = param_02;
	if(isplayer(param_01))
	{
		param_01 maps\mp\gametypes\_damagefeedback::func_86E0("helicopter");
		if(param_04 == "MOD_RIFLE_BULLET" || param_04 == "MOD_PISTOL_BULLET")
		{
			if(param_01 maps\mp\_utility::_hasperk("specialty_armorpiercing"))
			{
				var_0C = var_0C + param_02 * level.armorpiercingmod;
			}
		}
	}

	if(isdefined(param_01.owner) && isplayer(param_01.owner))
	{
		param_01.owner maps\mp\gametypes\_damagefeedback::func_86E0("helicopter");
	}

	if(isdefined(param_05))
	{
		switch(param_05)
		{
			case "remotemissile_projectile_mp":
			case "ac130_40mm_mp":
			case "ac130_105mm_mp":
			case "javelin_mp":
			case "remote_mortar_missile_mp":
			case "stinger_mp":
				self.largeprojectiledamage = 1;
				var_0C = self.maxhealth + 1;
				break;

			case "sam_projectile_mp":
				self.largeprojectiledamage = 1;
				var_0C = self.maxhealth * 0.25;
				break;

			case "emp_grenade_mp":
				self.largeprojectiledamage = 0;
				var_0C = self.maxhealth + 1;
				break;
		}

		maps\mp\killstreaks\_killstreaks::func_4B39(param_01,param_05,self);
	}

	self.damagetaken = self.damagetaken + var_0C;
	if(self.damagetaken >= self.maxhealth)
	{
		if(isplayer(param_01) && !isdefined(self.owner) || param_01 != self.owner)
		{
			self.alreadydead = 1;
			param_01 notify("destroyed_helicopter");
			param_01 notify("destroyed_killstreak",param_05);
			thread maps\mp\_utility::func_7FA0("callout_destroyed_helicopter",param_01);
			param_01 thread maps\mp\gametypes\_rank::giverankxp("kill",300,param_05,param_04);
			param_01 thread maps\mp\gametypes\_rank::func_8E6E("destroyed_helicopter");
			thread maps\mp\gametypes\_missions::vehiclekilled(self.owner,self,undefined,param_01,param_02,param_04,param_05);
		}

		self notify("death");
	}
}

//Function Number: 18
func_8CD6()
{
	self endon("gone");
	self waittill("death");
	thread maps\mp\killstreaks\_helicopter::func_4D0A();
}