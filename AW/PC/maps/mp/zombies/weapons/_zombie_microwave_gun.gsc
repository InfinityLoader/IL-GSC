/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\zombies\weapons\_zombie_microwave_gun.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 35
 * Decompile Time: 562 ms
 * Timestamp: 4/22/2024 2:13:26 AM
*******************************************************************/

//Function Number: 1
init()
{
	level._effect["microwave_buff"][0] = loadfx("vfx/weaponimpact/xombie_flesh_microwave_bubbles_1");
	level._effect["microwave_buff"][1] = loadfx("vfx/weaponimpact/xombie_flesh_microwave_bubbles_2");
	level._effect["microwave_buff_head"] = loadfx("vfx/weaponimpact/xombie_flesh_microwave_bubbles_head_2");
	level._effect["microwave_buff_shoulder_left"] = loadfx("vfx/weaponimpact/xombie_flesh_microwave_bubbles_le_2");
	level._effect["microwave_buff_shoulder_right"] = loadfx("vfx/weaponimpact/xombie_flesh_microwave_bubbles_ri_2");
	level._effect["gib_full_body_microwave"] = loadfx("vfx/blood/dlc_zombie_microwave_death");
}

//Function Number: 2
onplayerspawn()
{
	self endon("spawned_player");
	self endon("disconnect");
	self endon("death");
	self endon("faux_spawn");
	self notify("onPlayerSpawnMicrowaveGun");
	self endon("onPlayerSpawnMicrowaveGun");
	maps\mp\gametypes\zombies::createzombieweaponstate(self,"iw5_microwavezm_mp");
	self.weaponstate["iw5_microwavezm_mp"]["weapon_level_increase"] = 0.2;
	var_00 = self.team;
	var_01 = spawnstruct();
	var_01.lastfiredtime = 0;
	var_01.beamrange = 650;
	var_02 = 0;
	self.microwavegundata = var_01;
	setmicrowaveweaponlevel(1);
	childthread updatebeamrange(var_01);
	childthread playermonitormicrowaveweapon(var_01);
	childthread update_microwave_heat_omnvar();
	childthread updatecookzombieburger(var_01);
	for(;;)
	{
		wait(0.05);
		if(gettime() - var_01.lastfiredtime > 100)
		{
			var_02 = 0;
			continue;
		}

		var_02 = 1;
		cookenemiesinrange(var_01,var_00);
	}
}

//Function Number: 3
updatebeamrange(param_00)
{
	for(;;)
	{
		wait(0.5);
		var_01 = self getcurrentweapon(0);
		if(!issubstr(var_01,"iw5_microwavezm_mp"))
		{
			continue;
		}

		var_02 = self getplayerangles();
		var_03 = anglestoforward(var_02);
		var_04 = self geteye();
		var_05 = var_04 + var_03 * 850;
		var_06 = bullettrace(var_04,var_05,0,self,0,0,0,0,0,1,0);
		if(var_06["fraction"] < 1)
		{
			param_00.beamrange = length(var_06["position"] - var_04);
			continue;
		}

		param_00.beamrange = 850;
	}
}

//Function Number: 4
cookenemiesinrange(param_00,param_01)
{
	var_02 = param_00.beamrange;
	if(self playerads() < 0.3)
	{
		var_02 = min(var_02,650);
	}

	var_03 = squared(var_02 + param_00.beamwidth * 2);
	var_04 = squared(param_00.beamwidth);
	var_05 = self geteye();
	var_06 = self getplayerangles();
	var_07 = anglestoforward(var_06);
	var_08 = var_05 + var_07 * param_00.beamwidth;
	var_09 = var_08 + var_07 * var_02;
	foreach(var_0B in level.agentarray)
	{
		if(!isdefined(var_0B) || !isalive(var_0B) || isdefined(var_0B.team) && !isenemyteam(param_01,var_0B.team))
		{
			continue;
		}

		if(distancesquared(self.origin,var_0B.origin) > var_03)
		{
			continue;
		}

		var_0C = var_0B.origin - var_05 * (1,1,0);
		if(vectordot(var_0C,var_07 * (1,1,0)) < 0)
		{
			continue;
		}

		var_0D = pointdistancetolinesq(var_0B geteye(),var_08,var_09);
		var_0E = pointdistancetolinesq(var_0B gettagorigin("J_Spine4"),var_08,var_09);
		var_0F = min(var_0D,var_0E);
		if(var_0F > var_04)
		{
			continue;
		}

		if(maps\mp\zombies\_util::isinstakill())
		{
			var_0B explodezombie(self);
			continue;
		}

		var_0B dodamage(30,var_0B geteye(),self,undefined,"MOD_EXPLOSIVE","iw5_microwavezm_mp","none");
		if(!isdefined(var_0B) || !isalive(var_0B))
		{
			continue;
		}

		var_0B maps\mp\zombies\_zombies::addbuff("microwaveBuff",var_0B getmicrowavebuff(self));
	}
}

//Function Number: 5
updatecookzombieburger(param_00)
{
	level endon("game_ended");
	self endon("disconnect");
	level waittill("main_stage5_over");
	var_01 = getent("zombie_patty_raw","targetname");
	if(!isdefined(var_01))
	{
		return;
	}

	var_01.cooktime = 0;
	var_02 = 0.5;
	for(;;)
	{
		wait(var_02);
		if(gettime() - param_00.lastfiredtime > 100)
		{
			continue;
		}

		cookzombieburger(param_00,var_01,var_02);
		if(var_01.cooktime >= 5)
		{
			break;
		}
	}

	level notify("burger_patty_cooked",self);
}

//Function Number: 6
cookzombieburger(param_00,param_01,param_02)
{
	var_03 = squared(param_00.beamrange + param_00.beamwidth * 2);
	var_04 = squared(param_00.beamwidth);
	var_05 = self geteye();
	var_06 = self getplayerangles();
	var_07 = anglestoforward(var_06);
	var_08 = var_05 + var_07 * param_00.beamwidth;
	var_09 = var_08 + var_07 * param_00.beamrange;
	if(distancesquared(self.origin,param_01.origin) > var_03)
	{
		return;
	}

	var_0A = param_01.origin - var_05 * (1,1,0);
	if(vectordot(var_0A,var_07 * (1,1,0)) < 0)
	{
		return;
	}

	var_0B = pointdistancetolinesq(param_01.origin,var_08,var_09);
	if(var_0B > var_04)
	{
		return;
	}

	param_01.cooktime = param_01.cooktime + param_02;
}

//Function Number: 7
pointdistancetolinesq(param_00,param_01,param_02)
{
	var_03 = lengthsquared(param_02 - param_01);
	if(var_03 == 0)
	{
		return lengthsquared(param_01 - param_00);
	}

	var_04 = vectordot(param_00 - param_01,param_02 - param_01) / var_03;
	if(var_04 < 0)
	{
		return lengthsquared(param_00 - param_01);
	}
	else if(var_04 > 1)
	{
		return lengthsquared(param_00 - param_02);
	}

	var_05 = param_01 + var_04 * param_02 - param_01;
	var_06 = lengthsquared(param_00 - var_05);
	return var_06;
}

//Function Number: 8
getmicrowavebuff(param_00)
{
	var_01 = maps\mp\zombies\_zombies::getbuff("microwaveBuff");
	if(!isdefined(var_01))
	{
		var_01 = spawnmicrowavebuff(param_00);
		maps\mp\zombies\_util::playfxontagnetwork(level._effect["microwave_buff"][0],self,"J_Spine4");
		var_02 = clamp(var_01.bufflevel / var_01.timetoexplode,0,1);
		thread audio_flesh_bubble(var_02);
	}
	else
	{
		var_03 = var_02.bufflevel;
		var_01.bufflevel = var_01.bufflevel + 0.05;
		var_02 = clamp(var_01.bufflevel / var_01.timetoexplode,0,1);
		var_01.speedmultiplier = calculatebuffspeedmultiplier(var_01.bufflevel,var_02,var_01.lifespan,var_01.player);
		var_04 = getmicrowavebufffxindex(var_03,var_01.timetoexplode);
		var_05 = getmicrowavebufffxindex(var_01.bufflevel,var_01.timetoexplode);
		if(var_05 > var_04)
		{
			maps\mp\zombies\_util::stopfxontagnetwork(level._effect["microwave_buff"][var_04],self,"J_Spine4");
			maps\mp\zombies\_util::playfxontagnetwork(level._effect["microwave_buff"][var_05],self,"J_Spine4");
			maps\mp\zombies\_util::playfxontagnetwork(level._effect["microwave_buff_head"],self,"J_head");
			if(canplayadditionalbufffx())
			{
				maps\mp\zombies\_util::playfxontagnetwork(level._effect["microwave_buff_shoulder_left"],self,"J_Shoulder_LE");
				maps\mp\zombies\_util::playfxontagnetwork(level._effect["microwave_buff_shoulder_right"],self,"J_Shoulder_RI");
			}
		}

		audio_flesh_bubble_volume(var_02);
	}

	var_01.lifespan = param_00.microwavegundata.bufflifespan;
	var_01.player = param_00;
	return var_01;
}

//Function Number: 9
calculatebuffspeedmultiplier(param_00,param_01,param_02,param_03)
{
	var_04 = clamp(param_00 / 0.2,0,1);
	if(param_02 < 2)
	{
		var_04 = clamp(param_02 / 2,0,1);
	}

	return maps\mp\zombies\_util::lerp(var_04,0.9,param_03.microwavegundata.fullyslowed);
}

//Function Number: 10
audio_flesh_bubble(param_00)
{
	if(!isdefined(self.fleshbubblesound))
	{
		self.fleshbubblesound = spawn("script_origin",self.origin);
	}

	self.fleshbubblesound linkto(self);
	thread common_scripts\utility::delete_on_death(self.fleshbubblesound);
	self.fleshbubblesound playloopsound("npc_mwave_flesh_bubble");
	self.fleshbubblesound scalevolume(clamp(param_00,0,1),0);
}

//Function Number: 11
audio_flesh_bubble_volume(param_00)
{
	if(isdefined(self.fleshbubblesound))
	{
		self.fleshbubblesound scalevolume(clamp(param_00,0,1),0);
	}
}

//Function Number: 12
audio_stop_flesh_bubble()
{
	if(!isdefined(self.fleshbubblesound))
	{
		return;
	}

	var_00 = self.fleshbubblesound;
	var_00 endon("death");
	wait(1.3);
	var_00 scalevolume(0,1);
	wait(1);
	var_00 stoploopsound();
	wait 0.05;
	var_00 delete();
	var_00 = undefined;
}

//Function Number: 13
getmicrowavebufffxindex(param_00,param_01)
{
	var_02 = param_00 / param_01;
	if(var_02 < 0.25)
	{
		return 0;
	}

	return 1;
}

//Function Number: 14
canplayadditionalbufffx()
{
	return self.species != "dog";
}

//Function Number: 15
spawnmicrowavebuff(param_00)
{
	var_01 = spawnstruct();
	var_01.buffupdate = ::updatemicrowavebuff;
	var_01.buffremove = ::removemicrowavebuff;
	var_01.lifespan = param_00.microwavegundata.bufflifespan;
	var_01.speedmultiplier = 0.9;
	var_01.bufflevel = 0.05;
	var_01.timetoexplode = 2;
	return var_01;
}

//Function Number: 16
explodezombie(param_00)
{
	earthquake(randomfloatrange(0.5,1),randomfloatrange(0.5,1),self.origin,128);
	self dodamage(self.maxhealth + 10,self geteye(),param_00,undefined,"MOD_EXPLOSIVE","iw5_microwavezm_mp","none");
}

//Function Number: 17
givezombiescookedachievement(param_00,param_01)
{
	if(!isdefined(param_00) || !isdefined(param_01) || !issubstr(param_01,"iw5_microwavezm_mp"))
	{
		return;
	}

	if(!isdefined(param_00.numzombiescooked))
	{
		param_00.numzombiescooked = 0;
	}

	param_00.numzombiescooked++;
	if(param_00.numzombiescooked == 50)
	{
		param_00 maps\mp\gametypes\zombies::givezombieachievement("DLC2_ZOMBIE_POPCORN");
	}
}

//Function Number: 18
updatemicrowavebuff(param_00)
{
	var_01 = clamp(param_00.bufflevel / param_00.timetoexplode,0,1);
	param_00.speedmultiplier = calculatebuffspeedmultiplier(param_00.bufflevel,var_01,param_00.lifespan,param_00.player);
}

//Function Number: 19
removemicrowavebuff(param_00)
{
	var_01 = getmicrowavebufffxindex(param_00.bufflevel,param_00.timetoexplode);
	maps\mp\zombies\_util::stopfxontagnetwork(level._effect["microwave_buff"][var_01],self,"J_Spine4");
	thread audio_stop_flesh_bubble();
	if(var_01 == 0)
	{
		return;
	}

	maps\mp\zombies\_util::stopfxontagnetwork(level._effect["microwave_buff_head"],self,"J_head");
	if(canplayadditionalbufffx())
	{
		maps\mp\zombies\_util::stopfxontagnetwork(level._effect["microwave_buff_shoulder_left"],self,"J_Shoulder_LE");
		maps\mp\zombies\_util::stopfxontagnetwork(level._effect["microwave_buff_shoulder_right"],self,"J_Shoulder_RI");
	}
}

//Function Number: 20
playermonitormicrowaveweapon(param_00)
{
	self endon("disconnect");
	self setclientomnvar("ui_energy_ammo",1);
	for(;;)
	{
		self waittill("weapon_change",var_01);
		wait 0.05;
		thread playerdomicrowavelogic(var_01,param_00);
	}
}

//Function Number: 21
playerdomicrowavelogic(param_00,param_01)
{
	self endon("disconnect");
	if(!issubstr(param_00,"iw5_microwavezm_mp"))
	{
		if(playerhasmicrowaveammoinfo() && playergetmicrowaveammo() <= 0 && !playerhasmicrowave() && !maps\mp\zombies\_util::isplayerinlaststand(self))
		{
			playerclearmicrowaveammoinfo();
		}

		return;
	}

	playersetmicrowaveammo();
	self setweaponammostock(param_00,0);
	thread playersetupmicrowaveammo(param_01);
	self waittill("weapon_change");
	self allowfire(1);
	self notifyonplayercommandremove("fire_microwave_weapon","+attack");
	self notifyonplayercommandremove("fire_microwave_weapon","+attack_akimbo_accessible");
}

//Function Number: 22
playerhasmicrowave()
{
	var_00 = self getweaponslistprimaries();
	foreach(var_02 in var_00)
	{
		if(issubstr(var_02,"iw5_microwavezm_mp"))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 23
playerupdatemicrowaveomnvar()
{
	var_00 = getmicrowavemaxammo();
	var_01 = playergetmicrowaveammo();
	var_02 = var_01 / var_00;
	self setclientomnvar("ui_energy_ammo",var_02);
}

//Function Number: 24
playersetupmicrowaveammo(param_00)
{
	self endon("death");
	self endon("disconnect");
	self endon("weapon_change");
	self notifyonplayercommand("fire_microwave_weapon","+attack");
	self notifyonplayercommand("fire_microwave_weapon","+attack_akimbo_accessible");
	var_01 = playergetmicrowaveammo();
	playerupdatemicrowaveomnvar();
	if(var_01 <= 0)
	{
		self allowfire(0);
	}

	for(;;)
	{
		if(!self attackbuttonpressed())
		{
			self waittill("fire_microwave_weapon");
		}

		var_02 = self getcurrentweapon();
		if(self isreloading() || !issubstr(var_02,"iw5_microwavezm_mp") || !self isfiring() || self isusingoffhand() || self ismeleeing())
		{
			wait 0.05;
			continue;
		}

		param_00.lastfiredtime = gettime();
		var_01 = playergetmicrowaveammo();
		playerupdatemicrowaveomnvar();
		if(var_01 <= 0)
		{
			var_03 = self getweaponslistprimaries();
			var_04 = maps\mp\_utility::getbaseweaponname(var_03[0]);
			if(var_04 != "iw5_microwavezm")
			{
				self allowfire(0);
				self switchtoweapon(var_03[0]);
				wait 0.05;
				continue;
			}

			if(var_03.size > 1)
			{
				var_04 = maps\mp\_utility::getbaseweaponname(var_03[1]);
				if(var_04 != "iw5_microwavezm")
				{
					self switchtoweapon(var_03[1]);
					self allowfire(0);
					wait 0.05;
					continue;
				}
			}

			self allowfire(0);
			wait 0.05;
			continue;
		}

		wait 0.05;
		if(maps\mp\zombies\_util::gameflagexists("unlimited_ammo") && maps\mp\_utility::gameflag("unlimited_ammo"))
		{
			continue;
		}

		var_01 = playergetmicrowaveammo();
		playerrecordmicrowaveammo(var_01 - 1);
	}
}

//Function Number: 25
playersetmicrowaveammo()
{
	if(!isdefined(self.pers["microwaveAmmo"]))
	{
		self.pers["microwaveAmmo"] = spawnstruct();
		playersetmicrowavemaxammo();
		self allowfire(1);
	}
}

//Function Number: 26
getmicrowavemaxammo()
{
	return 900;
}

//Function Number: 27
playersetmicrowavemaxammo()
{
	if(isdefined(self.pers["microwaveAmmo"]))
	{
		self.pers["microwaveAmmo"].ammo = getmicrowavemaxammo();
		self setclientomnvar("ui_energy_ammo",1);
		self allowfire(1);
	}
}

//Function Number: 28
playergetmicrowaveammo()
{
	return self.pers["microwaveAmmo"].ammo;
}

//Function Number: 29
playerrecordmicrowaveammo(param_00)
{
	self.pers["microwaveAmmo"].ammo = param_00;
}

//Function Number: 30
playerhasmicrowaveammoinfo()
{
	return isdefined(self.pers["microwaveAmmo"]);
}

//Function Number: 31
playerclearmicrowaveammoinfo()
{
	self.pers["microwaveAmmo"] = undefined;
}

//Function Number: 32
update_microwave_heat_omnvar()
{
	level endon("game_ended");
	self endon("disconnect");
	for(;;)
	{
		var_00 = self getcurrentweapon();
		if(issubstr(var_00,"iw5_microwavezm_mp"))
		{
			var_01 = self getweaponheatlevel(var_00);
			self setclientomnvar("ui_em1_heat",var_01);
		}

		wait(0.05);
	}
}

//Function Number: 33
playzombiekilledmicrowavefx()
{
	var_00 = common_scripts\utility::getfx("gib_full_body_microwave");
	var_01 = level.dismemberment["full"]["fxTagName"];
	playfx(var_00,self.body gettagorigin(var_01));
	self.body playsound("npc_mwave_flesh_expl_front");
	self.body hide();
	self.body hideallparts();
}

//Function Number: 34
setmicrowaveweaponlevel(param_00)
{
	param_00 = clamp(param_00,1,20);
	if(!isdefined(self.microwavegundata))
	{
		return;
	}

	var_01 = clamp(param_00 - 1 / 19,0,1);
	self.microwavegundata.bufflifespan = maps\mp\zombies\_util::lerp(var_01,3,10);
	self.microwavegundata.fullyslowed = maps\mp\zombies\_util::lerp(var_01,0.6,0.4);
	self.microwavegundata.beamwidth = 25;
}

//Function Number: 35
getmicrowavepointstimesec()
{
	return 0.5;
}