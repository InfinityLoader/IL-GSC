/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\zombies\zombie_boss_oz_stage1.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 26
 * Decompile Time: 417 ms
 * Timestamp: 4/22/2024 2:14:58 AM
*******************************************************************/

//Function Number: 1
init()
{
	level.runwavefunc["zombie_boss_oz_stage1"] = ::bossozstage1runwave;
	level.roundspawndelayfunc["zombie_boss_oz_stage1"] = ::bossozgetzombiespawndelay;
	level._effect["oz_room_destroyed_explode"] = loadfx("vfx/explosion/ambient_explosion_fireball");
	level._effect["oz_room_destroyed_fire"] = loadfx("vfx/fire/fire_lp_m_dim");
	level._effect["oz_teleport"] = loadfx("vfx/unique/dlc_teleport_soldier_bad");
	maps\mp\zombies\zombie_boss_oz_stage1_traps::init_traps();
	level.animnametoasset["zom_boss_st1_exposed_pain_left"] = %zom_boss_st1_exposed_pain_left;
	level.animnametoasset["zom_boss_st1_exposed_pain_right"] = %zom_boss_st1_exposed_pain_right;
	level.animnametoasset["zom_boss_st1_exposed_pain_head"] = %zom_boss_st1_exposed_pain_head;
	level.animnametoasset["zom_boss_st1_teleport_in"] = %zom_boss_st1_teleport_in;
	level.animnametoasset["zom_boss_st1_teleport_out"] = %zom_boss_st1_teleport_out;
	level.animnametoasset["zom_boss_st1_trap_mid"] = %zom_boss_st1_trap_mid;
	level.animnametoasset["zom_boss_st1_trap_right"] = %zom_boss_st1_trap_right;
	level.animnametoasset["zom_boss_st1_trap_left"] = %zom_boss_st1_trap_left;
	level.animnametoasset["zom_boss_st1_exposed_react"] = %zom_boss_st1_exposed_react;
	level.animnametoasset["zom_boss_st1_taunt_01"] = %zom_boss_st1_taunt_01;
	level.animnametoasset["zom_boss_st1_taunt_02"] = %zom_boss_st1_taunt_02;
	level.animnametoasset["zom_boss_st1_exposed_to_normal"] = %zom_boss_st1_exposed_to_normal;
}

//Function Number: 2
bossozgetzombiespawndelay(param_00,param_01)
{
	var_02 = 28;
	var_03 = [1,0.78,0.56,0.34];
	var_04 = int(clamp(maps\mp\zombies\_util::getnumplayers() - 1,0,3));
	var_05 = var_03[var_04];
	var_06 = level.bossozrooms.size / level.totalnumbossozrooms;
	var_07 = var_02 * var_05 * var_06;
	return var_07;
}

//Function Number: 3
setmaxpickups()
{
	level endon("game_ended");
	var_00 = level.maxpickupsperround;
	var_01 = level.trappickupdisabled;
	level.maxpickupsperround = 99999;
	level.trappickupdisabled = 1;
	common_scripts\utility::waittill_any("zombie_wave_interrupt","zombie_boss_wave_ended");
	level.maxpickupsperround = var_00;
	level.trappickupdisabled = var_01;
}

//Function Number: 4
setwaverunningandspawnoz()
{
	level.zombie_wave_running = 1;
	spawnoz();
	common_scripts\utility::waittill_any("zombie_wave_interrupt","zombie_boss_wave_ended");
	maps\mp\zombies\zombie_boss_oz::zmbaudioresetozvoent();
	level.bossozstage1 delete();
	level.zombie_wave_running = 0;
}

//Function Number: 5
spawnoz()
{
	level.bossozstage1 = spawn("script_model",(0,0,0));
	level.bossozstage1.team = "axis";
	level.bossozstage1 setmodel("zom_oz_boss_stage1");
	level.bossozstage1 maps\mp\zombies\_util::zombie_set_eyes("zombie_eye_host_janitor");
	level.bossozstage1.health = 999999;
	level.bossozstage1.maxhealth = 999999;
	level.bossozstage1 thermaldrawenable();
	foreach(var_01 in level.players)
	{
		level.bossozstage1 threatdetectedtoplayer(var_01);
	}
}

//Function Number: 6
initozrooms()
{
	level.bossozrooms = common_scripts\utility::getstructarray("boss_oz_spot","targetname");
	foreach(var_01 in level.bossozrooms)
	{
		var_01.explosion_locations = [];
		var_01.fire_locations = [];
		var_02 = common_scripts\utility::array_combine(getentarray(var_01.target,"targetname"),common_scripts\utility::getstructarray(var_01.target,"targetname"));
		foreach(var_04 in var_02)
		{
			if(var_04.script_noteworthy == "door")
			{
				var_01.doorbrushmodel = var_04;
				continue;
			}

			if(var_04.script_noteworthy == "explosion_origin")
			{
				var_01.explosion_locations[var_01.explosion_locations.size] = var_04;
				continue;
			}

			if(var_04.script_noteworthy == "fire_origin")
			{
				var_01.fire_locations[var_01.fire_locations.size] = var_04;
			}
		}

		if(isdefined(var_01.doorbrushmodel.startorigin))
		{
			var_01.doorbrushmodel.origin = var_01.doorbrushmodel.startorigin;
		}
		else
		{
			var_01.doorbrushmodel.startorigin = var_01.doorbrushmodel.origin;
		}

		if(level.nextgen)
		{
			var_06 = getscriptablearray("scriptable_boss_oz_room","targetname");
			var_01.scriptablelight = common_scripts\utility::get_array_of_closest(var_01.origin,var_06)[0];
			var_01.scriptablelight setscriptablepartstate(0,6);
		}

		foreach(var_08 in var_01.fire_locations)
		{
			if(isdefined(var_08.fx))
			{
				var_08.fx delete();
			}
		}
	}

	level.totalnumbossozrooms = level.bossozrooms.size;
}

//Function Number: 7
bossozstage1runwave(param_00)
{
	level endon("game_ended");
	thread maps\mp\mp_zombie_h2o_aud::sndbossozstartstage1();
	runwave(param_00);
	level notify("zombie_stop_spawning");
	if(isdefined(level.bossozstage1.lastattacker))
	{
		var_01 = level.bossozstage1.lastattacker.origin;
	}
	else
	{
		var_01 = common_scripts\utility::random(level.players).origin;
	}

	maps\mp\gametypes\zombies::createpickup("nuke",var_01,"Boss Oz Wave 1 Complete - Nuke");
	maps\mp\gametypes\zombies::createpickup("ammo",var_01,"Boss Oz Wave 1 Complete - Max Ammo");
	givebossozstage1achievement();
	level notify("zombie_boss_wave_ended");
	level waittill("zombie_wave_ended");
}

//Function Number: 8
moveoztoroom(param_00)
{
	playfx(common_scripts\utility::getfx("oz_teleport"),level.bossozstage1.origin,(1,0,0),(0,0,1));
	level.bossozstage1 notify("teleport");
	level.bossozstage1.origin = param_00.origin;
	level.bossozstage1.angles = param_00.angles;
	level.bossozstage1.animnode = param_00;
	level.bossozstage1 thread ozplayanimthenidle("zom_boss_st1_teleport_in");
	level.bossozstage1.damagetaken = 0;
	level.bossozstage1.inpainanim = 0;
	playfx(common_scripts\utility::getfx("oz_teleport"),level.bossozstage1.origin,(1,0,0),(0,0,1));
	if(level.nextgen)
	{
		param_00.scriptablelight setscriptablepartstate(0,0);
	}
}

//Function Number: 9
taunttoolongtodamage()
{
	level endon("game_ended");
	level endon("zombie_boss_wave_ended");
	level endon("zombie_wave_interrupt");
	level.bossozstage1 endon("damage_taken");
	wait(20);
	var_00 = 3;
	for(;;)
	{
		var_01 = maps\mp\zombies\zombie_boss_oz::zmbaudiobossozplayvo("toolong",1);
		if(var_01)
		{
			var_00--;
			if(var_00 <= 0)
			{
				return;
			}
			else
			{
				wait(15);
			}

			continue;
		}

		wait(1);
	}
}

//Function Number: 10
doshieldupvo(param_00)
{
	level endon("end_spawn_wait");
	wait(1);
	maps\mp\zombies\zombie_boss_oz::zmbaudioangplayvo("stage1_shield",1);
	maps\mp\zombies\zombie_boss_oz::zmbaudiobossozplayvo("shieldup",1,param_00);
	maps\mp\zombies\zombie_boss_oz::zmbaudioplayervo("shieldup",1);
}

//Function Number: 11
runwave(param_00)
{
	level endon("zombie_wave_interrupt");
	thread setmaxpickups();
	thread setwaverunningandspawnoz();
	initozrooms();
	maps\mp\zombies\zombie_boss_oz_stage1_traps::begin_round_init_traps();
	var_01 = [99999,20,15,10];
	var_02 = 2.5;
	level.totalaispawned = 0;
	level.maxenemycount = maps\mp\zombies\zombies_spawn_manager::getmaxenemycount();
	var_03 = common_scripts\utility::random(level.bossozrooms);
	moveoztoroom(var_03);
	wait(1.5);
	maps\mp\zombies\zombie_boss_oz::zmbaudioangplayvo("stage1_start",1);
	maps\mp\zombies\zombie_boss_oz::zmbaudiochangeozvotoplayonent(level.bossozstage1);
	maps\mp\zombies\zombie_boss_oz::zmbaudiobossozplayvo("tele2",1);
	maps\mp\zombies\zombie_boss_oz::zmbaudioplayervo("ozsee",1);
	wait(1);
	maps\mp\zombies\zombie_boss_oz::zmbaudiobossozplayvo("intro",1);
	var_04 = 0;
	var_05 = 0;
	while(level.bossozrooms.size > 0)
	{
		var_06 = getstage1phase();
		if(var_06 > 0)
		{
			if(!var_05)
			{
				var_05 = 1;
				level notify("activate_terminals");
			}

			if(!var_04)
			{
				var_04 = 1;
				maps\mp\zombies\zombie_boss_oz::startinfinitezombiespawning();
			}

			var_03 = common_scripts\utility::random(level.bossozrooms);
			moveoztoroom(var_03);
			wait(5);
		}

		var_07 = 1;
		var_08 = var_06;
		while(var_07)
		{
			var_09 = var_06 > 0;
			if(var_09)
			{
				maps\mp\zombies\zombie_boss_oz_stage1_traps::run_trap_sequence(var_08);
			}

			maps\mp\zombies\_util::waittillzombiegameunpaused();
			var_0A = undefined;
			if(var_06 == 0)
			{
				var_0A = 1;
			}

			level thread doshieldupvo(var_0A);
			playsoundatpos(var_03.origin,"oz_s1_location_open");
			level.bossozstage1 thread ozplayanimthenidle("zom_boss_st1_exposed_react","zom_boss_st1_exposed_idle");
			var_03 oz_room_open_door(1,var_02);
			make_oz_damageable(1);
			if(var_06 == 0)
			{
				level thread taunttoolongtodamage();
			}

			var_0B = level.bossozstage1 common_scripts\utility::waittill_any_timeout(var_01[var_06] + var_02,"oz_phase_defeated");
			make_oz_damageable(0);
			if(var_0B == "timeout")
			{
				playsoundatpos(var_03.origin,"oz_s1_location_close");
				var_03 oz_room_open_door(0,0.5);
				level thread maps\mp\zombies\zombie_boss_oz::zmbaudiobossozplayvo("shielddown",0);
				var_08 = 1;
				level.bossozstage1 thread ozplayanimthenidle("zom_boss_st1_exposed_to_normal");
				wait(3);
				continue;
			}

			var_07 = 0;
			level.bossozrooms = common_scripts\utility::array_remove(level.bossozrooms,var_03);
			level notify("end_spawn_wait");
			level.bossozstage1 ozplayanimuntilnotetrack("zom_boss_st1_teleport_out","teleport");
			foreach(var_0D in var_03.explosion_locations)
			{
				playfx(common_scripts\utility::getfx("oz_room_destroyed_explode"),var_0D.origin,anglestoforward(var_0D.angles),(0,0,1));
			}

			foreach(var_0D in var_03.fire_locations)
			{
				var_0D.fx = spawnfx(common_scripts\utility::getfx("oz_room_destroyed_fire"),var_0D.origin,anglestoforward(var_0D.angles),(0,0,1));
				thread maps\mp\mp_zombie_h2o_aud::sndbossozfire(var_0D.origin);
				triggerfx(var_0D.fx);
			}

			earthquake(0.5,1,var_03.origin,10000);
			playsoundatpos(var_03.origin,"oz_s1_location_destroyed");
			if(level.nextgen)
			{
				var_03.scriptablelight setscriptablepartstate(0,7);
			}

			if(var_06 != 3)
			{
				level thread maps\mp\zombies\zombie_boss_oz::zmbaudiobossozplayvo("progress",0,undefined,2);
			}

			var_11 = int(clamp(var_06 + 1,1,4));
			var_12 = "zm_boss_phase" + var_11;
			foreach(var_14 in level.players)
			{
				var_14 thread maps\mp\_matchdata::loggameevent(var_12,var_14.origin);
			}
		}
	}
}

//Function Number: 12
givebossozstage1achievement()
{
	foreach(var_01 in level.players)
	{
		var_01 maps\mp\gametypes\zombies::givezombieachievement("DLC4_ZOMBIE_DEFEATBOSS1");
	}
}

//Function Number: 13
getstage1phase()
{
	var_00 = level.totalnumbossozrooms - level.bossozrooms.size;
	return var_00;
}

//Function Number: 14
oz_room_open_door(param_00,param_01)
{
	if(param_00)
	{
		self.doorbrushmodel moveto(self.doorbrushmodel.startorigin + (0,0,160),param_01);
		return;
	}

	self.doorbrushmodel moveto(self.doorbrushmodel.startorigin,param_01);
}

//Function Number: 15
make_oz_damageable(param_00)
{
	if(param_00)
	{
		level.bossozstage1 setcandamage(1);
		level.bossozstage1 setdamagecallbackon(1);
		level.bossozstage1.damagecallback = ::ozhandledamagecallback;
		return;
	}

	level.bossozstage1 setcandamage(0);
	level.bossozstage1 setdamagecallbackon(0);
	level.bossozstage1.damagecallback = undefined;
}

//Function Number: 16
ozgetbaseweaponname(param_00)
{
	var_01 = getweaponbasename(param_00);
	if(!isdefined(var_01))
	{
		var_01 = "none";
	}

	if(isdefined(level.damageweapontoweapon[var_01]))
	{
		var_01 = level.damageweapontoweapon[var_01];
	}

	return var_01;
}

//Function Number: 17
ozmodifydamage(param_00,param_01,param_02,param_03,param_04)
{
	if(param_01.team == self.team)
	{
		return 0;
	}

	var_05 = ozscaledamageforkillstreakorweaponlevel(param_00,param_01,param_02,param_03,param_04);
	param_02 = ozgetbaseweaponname(param_02);
	if(param_02 == "iw5_fusionzm_mp")
	{
		var_05 = int(var_05 * 0.7);
	}

	if(param_02 == "iw5_rhinozm_mp")
	{
		var_05 = int(var_05 * 0.7);
	}

	if(param_02 == "iw5_linegunzm_mp")
	{
		var_05 = int(var_05 * 0.7);
	}

	if(param_02 == "iw5_tridentzm_mp")
	{
		var_05 = int(var_05 * 0.7);
	}

	return var_05;
}

//Function Number: 18
ozscaledamageforkillstreakorweaponlevel(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = param_04;
	var_06 = maps\mp\zombies\killstreaks\_zombie_killstreaks::modifydamagekillstreak(param_00,param_01,param_04,param_02,param_03);
	if(var_06 != var_05)
	{
		var_05 = int(var_06 * 0.25);
	}

	var_07 = ozgetbaseweaponname(param_02);
	if(maps\mp\zombies\_util::haszombieweaponstate(param_01,var_07))
	{
		var_08 = 0.2;
		if(isdefined(param_01.weaponstate[var_07]["weapon_level_increase"]))
		{
			var_08 = param_01.weaponstate[var_07]["weapon_level_increase"];
		}

		var_05 = int(var_05 + var_05 * var_08 * param_01.weaponstate[var_07]["level"] - 1);
	}

	return var_05;
}

//Function Number: 19
ozhurtvo()
{
	level.bossozstage1 endon("death");
	if(maps\mp\zombies\zombie_boss_oz::anyplayersspeaking() || maps\mp\zombies\_zombies_audio_announcer::isanyannouncerspeaking())
	{
		return;
	}

	if(!maps\mp\zombies\_util::is_true(level.bossozstage1.playedfirsthurtvo))
	{
		level.bossozstage1.playedfirsthurtvo = maps\mp\zombies\zombie_boss_oz::zmbaudiobossozplayvo("hurt",0,2,undefined,undefined,1);
		return;
	}

	maps\mp\zombies\zombie_boss_oz::zmbaudiobossozplayvo("hurt",0,undefined,undefined,undefined,1);
}

//Function Number: 20
ozhandledamagecallback(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B)
{
	var_0C = ozmodifydamage(param_00,param_01,param_05,param_04,param_02);
	level.bossozstage1.damagetaken = level.bossozstage1.damagetaken + var_0C;
	level.bossozstage1 notify("damage_taken");
	level thread ozhurtvo();
	if(var_0C > 0)
	{
		param_01 maps\mp\gametypes\_damagefeedback::updatedamagefeedback("boss_oz_trigger");
		param_01 maps\mp\gametypes\zombies::givepointsfordamage(self,param_02,param_04,param_05,param_06,param_07,param_08,0);
		self.lastattacker = param_01;
		if(!self.inpainanim)
		{
			thread ozplaypainanim();
		}
	}

	if(level.bossozstage1.damagetaken >= int(4900 * maps\mp\zombies\_util::getnumplayers()))
	{
		self notify("oz_phase_defeated",param_01);
	}
}

//Function Number: 21
ozplaypainanim()
{
	self endon("death");
	var_00 = common_scripts\utility::random(["zom_boss_st1_exposed_pain_head","zom_boss_st1_exposed_pain_left","zom_boss_st1_exposed_pain_right"]);
	self.inpainanim = 1;
	ozplayanimthenidle(var_00,"zom_boss_st1_exposed_idle");
	self.inpainanim = 0;
}

//Function Number: 22
ozplaytrapanim(param_00)
{
	level.bossozstage1 endon("death");
	var_01 = common_scripts\utility::random(["zom_boss_st1_trap_mid","zom_boss_st1_trap_right","zom_boss_st1_trap_left"]);
	level.bossozstage1 ozplayanimthenidle(var_01);
	level.bossozstage1.trapfinishedanimtime = gettime() + int(param_00 * 1000);
}

//Function Number: 23
ozplayanim(param_00)
{
	self scriptmodelplayanimdeltamotionfrompos(param_00,self.animnode.origin,self.animnode.angles,undefined,1);
	self notify("playAnim");
}

//Function Number: 24
ozplayanimthenidle(param_00,param_01)
{
	self endon("death");
	var_02 = level.animnametoasset[param_00];
	var_03 = getanimlength(var_02);
	ozplayanim(param_00);
	self endon("playAnim");
	wait(var_03);
	if(isdefined(param_01))
	{
		ozplayanim(param_01);
		return;
	}

	thread ozplaydefaultidle();
}

//Function Number: 25
ozplayanimuntilnotetrack(param_00,param_01)
{
	var_02 = level.animnametoasset[param_00];
	var_03 = getnotetracktimes(var_02,param_01)[0];
	ozplayanim(param_00);
	wait(var_03);
	self scriptmodelclearanim();
}

//Function Number: 26
ozplaydefaultidle()
{
	self endon("death");
	ozplayanim("zom_boss_st1_idle");
	self endon("playAnim");
	wait(randomfloatrange(5,10));
	if(!isdefined(self.trapfinishedanimtime) || level.bossozstage1.trapfinishedanimtime - gettime() > 10000)
	{
		thread ozplayanimthenidle(common_scripts\utility::random(["zom_boss_st1_taunt_01","zom_boss_st1_taunt_02"]));
	}
}