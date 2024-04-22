/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\zombies\_zombies_rewards.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 38
 * Decompile Time: 678 ms
 * Timestamp: 4/22/2024 2:14:41 AM
*******************************************************************/

//Function Number: 1
init()
{
	level.zombie_rewards = [];
	level thread setuprewardlist();
	thread debug_setuppenalty();
	level thread civrescuethink();
}

//Function Number: 2
civrescuethink()
{
	level.civrescueseq = 0;
	level.civfailedescorts = 0;
	for(;;)
	{
		var_00 = level common_scripts\utility::waittill_any_return("extraction_complete","extraction_failed");
		if(var_00 == "extraction_complete")
		{
			level.civrescueseq++;
			level thread civrescuesuccess();
			continue;
		}

		if(level.civrescueseq > 0)
		{
			level.civrescueseq--;
		}

		level thread civrescuefail();
	}
}

//Function Number: 3
civrescuesuccess()
{
	level waittill("zombie_wave_ended");
	wait(1);
	if(level.civrescueseq >= 3 && level.civrescueseq <= 4)
	{
		var_00 = "silver";
	}
	else if(level.civrescueseq >= 5)
	{
		var_00 = "gold";
	}
	else
	{
		var_00 = "bronze";
	}

	thread civrescuesuccessreward(var_00);
}

//Function Number: 4
civrescuesuccessreward(param_00)
{
	if(param_00 == "silver")
	{
		iprintlnbold(&"ZOMBIE_CIVILIANS_SUCCESS_SILVER_END_ROUND");
	}
	else if(param_00 == "gold")
	{
		iprintlnbold(&"ZOMBIE_CIVILIANS_SUCCESS_GOLD_END_ROUND");
	}
	else
	{
		iprintlnbold(&"ZOMBIE_CIVILIANS_SUCCESS_END_ROUND");
	}

	foreach(var_02 in level.players)
	{
		var_02 thread reward_countdowntimer();
	}

	level waittill("timer_countdown_complete");
	reward_enablebyclass(param_00);
}

//Function Number: 5
setuprewardlist()
{
	var_00 = ["bronze_money","silver_money","gold_money","refill_ammo","refill_grenades","single_grenade","droppod_single","droppod_cluster","atm_all_on","weapon_upgrade","fire_sale_activate","solo_extra_revive"];
	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		level.zombie_rewards[var_01] = spawnstruct();
		level.zombie_rewards[var_01].rewardname = var_00[var_01];
		level.zombie_rewards[var_01].lastwavegiven = 0;
		level.zombie_rewards[var_01].specialfunc = undefined;
	}

	setrewardspecialfunction("bronze_money",::reward_givemoney,"reward_bronze");
	setrewardspecialfunction("silver_money",::reward_givemoney,"reward_silver");
	setrewardspecialfunction("gold_money",::reward_givemoney,"reward_gold");
	setrewardspecialfunction("refill_ammo",::reward_ammorefill);
	setrewardspecialfunction("single_grenade",::reward_singlegrenade);
	setrewardspecialfunction("refill_grenades",::reward_grenaderefill);
	setrewardspecialfunction("droppod_single",::reward_orbitaldropsingle);
	setrewardspecialfunction("droppod_cluster",::reward_orbitaldropcluster);
	setrewardspecialfunction("weapon_upgrade",::reward_weaponupgrade);
	setrewardspecialfunction("solo_extra_revive",::reward_soloextrarevive);
	thread debug_setupallrewards();
}

//Function Number: 6
setrewardspecialfunction(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = getrewardbyname(param_00);
	var_05.specialfunc = param_01;
	if(isdefined(param_02))
	{
		var_05.funcparm1 = param_02;
	}

	if(isdefined(param_03))
	{
		var_05.funcparm2 = param_03;
	}

	if(isdefined(param_04))
	{
		var_05.funcparm3 = param_04;
	}
}

//Function Number: 7
getrewardbyname(param_00)
{
	foreach(var_02 in level.zombie_rewards)
	{
		if(var_02.rewardname == param_00)
		{
			return var_02;
		}
	}

	return undefined;
}

//Function Number: 8
reward_enablebyclass(param_00)
{
	switch(param_00)
	{
		case "bronze":
			thread reward_enable("weapon_upgrade");
			break;

		case "silver":
			thread reward_enable("weapon_upgrade");
			thread reward_enable("single_grenade");
			thread reward_enable("droppod_single");
			thread reward_enable("refill_ammo");
			break;

		case "gold":
			thread reward_enable("weapon_upgrade");
			thread reward_enable("refill_grenades");
			thread reward_enable("droppod_cluster");
			thread reward_enable("refill_ammo");
			break;

		default:
			break;
	}
}

//Function Number: 9
reward_enable(param_00)
{
	var_01 = getrewardbyname(param_00);
	if(isdefined(var_01.specialfunc))
	{
		var_01 thread callspecialrewardfunction();
	}
}

//Function Number: 10
callspecialrewardfunction()
{
	var_00 = self;
	if(!isdefined(var_00.funcparm1))
	{
		var_00 thread [[ var_00.specialfunc ]]();
		return;
	}

	if(!isdefined(var_00.funcparm2))
	{
		var_00 thread [[ var_00.specialfunc ]](var_00.funcparm1);
		return;
	}

	if(!isdefined(var_00.funcparm3))
	{
		var_00 thread [[ var_00.specialfunc ]](var_00.funcparm1,var_00.funcparm2);
		return;
	}

	var_00 thread [[ var_00.specialfunc ]](var_00.funcparm1,var_00.funcparm2,var_00.funcparm3);
}

//Function Number: 11
rewardlastwavegiven()
{
	var_00 = 0;
	if(level.wavecounter - self.lastwavegiven <= 3)
	{
		var_00 = self.lastwavegiven;
	}

	return var_00;
}

//Function Number: 12
reward_givemoney(param_00)
{
	wait(3);
	foreach(var_02 in level.players)
	{
		var_02 maps\mp\gametypes\zombies::givepointsforevent(param_00,undefined,1);
	}
}

//Function Number: 13
reward_ammorefill()
{
	level thread maps\mp\gametypes\zombies::activatemaxammo();
}

//Function Number: 14
reward_singlegrenade()
{
	foreach(var_01 in level.players)
	{
		var_02 = var_01 getlethalweapon();
		var_03 = var_01 gettacticalweapon();
		var_04 = [var_02,var_03];
		foreach(var_06 in var_04)
		{
			if(var_06 == "none")
			{
				continue;
			}

			var_01 setweaponammoclip(var_06,var_01 getweaponammoclip(var_06) + 1);
		}
	}
}

//Function Number: 15
reward_grenaderefill()
{
	foreach(var_01 in level.players)
	{
		var_02 = var_01 getlethalweapon();
		var_03 = var_01 gettacticalweapon();
		var_04 = [var_02,var_03];
		foreach(var_06 in var_04)
		{
			if(var_06 == "none")
			{
				continue;
			}

			var_07 = weaponclipsize(var_06);
			var_01 setweaponammoclip(var_06,var_07);
		}
	}
}

//Function Number: 16
reward_orbitaldropsingle()
{
	level.orbitaldropupgrade = 1;
	thread maps\mp\zombies\killstreaks\_zombie_killstreaks::dropcarepackage();
	wait(10);
	level.orbitaldropupgrade = 0;
}

//Function Number: 17
reward_orbitaldropcluster()
{
	level.orbitaldropupgrade = 1;
	var_00 = randomintrange(2,3);
	for(var_01 = 0;var_01 < var_00;var_01++)
	{
		thread maps\mp\zombies\killstreaks\_zombie_killstreaks::dropcarepackage();
		wait(randomfloatrange(1,3));
	}

	wait(10);
	level.orbitaldropupgrade = 0;
}

//Function Number: 18
reward_weaponupgrade()
{
	foreach(var_01 in level.players)
	{
		var_01 thread reward_weaponupgradethink();
	}
}

//Function Number: 19
reward_weaponupgradethink()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	if(isdefined(self.inlaststand) && self.inlaststand == 1)
	{
		while(self.inlaststand == 1)
		{
			wait(0.1);
		}
	}

	if(isdefined(self.iscarrying) && self.iscarrying == 1)
	{
		while(self.iscarrying == 1)
		{
			wait(0.1);
		}
	}

	if(isdefined(self.hasbomb) && self.hasbomb == 1)
	{
		while(self.hasbomb == 1)
		{
			wait(0.1);
		}
	}

	var_00 = maps\mp\zombies\_util::getplayerweaponzombies(self);
	var_01 = getweaponbasename(var_00);
	if(!maps\mp\zombies\_util::haszombieweaponstate(self,var_01))
	{
		return;
	}

	if(self.weaponstate[var_01]["level"] < 20)
	{
		maps\mp\zombies\_wall_buys::setweaponlevel(self,var_00,self.weaponstate[var_01]["level"] + 1);
	}
	else if(self.weaponstate[var_01]["level"] == 20)
	{
		maps\mp\zombies\_wall_buys::setweaponlevel(self,var_00,25);
	}
	else
	{
		return;
	}

	thread maps\mp\zombies\_zombies_audio::playerweaponupgrade(0,self.weaponstate[var_01]["level"]);
	self.numupgrades++;
}

//Function Number: 20
reward_soloextrarevive()
{
	if(level.players.size < 2)
	{
		var_00 = level.terminalitems["exo_revive"];
		var_00.maxbuyssolo++;
		foreach(var_02 in level.players)
		{
			if(!isdefined(var_02.isexostimactive) || isdefined(var_02.isexostimactive) && var_02.isexostimactive == 0)
			{
				var_02.isexostimactive = 1;
			}
		}
	}
}

//Function Number: 21
reward_countdowntimer()
{
	self endon("disconnect");
	var_00 = maps\mp\gametypes\_hud_util::createprimaryprogressbartext(0,185);
	var_00 settext(&"ZOMBIE_CIVILIANS_INCOMING_UPGRADE");
	var_00.fontscale = 0.65;
	var_01 = maps\mp\gametypes\_hud_util::createprimaryprogressbartext(0,205);
	var_01 thread update_countdown();
	var_01.fontscale = 1;
	level common_scripts\utility::waittill_any("timer_countdown_complete");
	var_01 maps\mp\gametypes\_hud_util::destroyelem();
	var_00 maps\mp\gametypes\_hud_util::destroyelem();
}

//Function Number: 22
update_countdown()
{
	self endon("disconnect");
	for(var_00 = 0;var_00 < 5;var_00++)
	{
		var_01 = undefined;
		switch(5 - var_00)
		{
			case 5:
				var_01 = &"ZOMBIE_CIVILIANS_5";
				break;

			case 4:
				var_01 = &"ZOMBIE_CIVILIANS_4";
				break;

			case 3:
				var_01 = &"ZOMBIE_CIVILIANS_3";
				break;

			case 2:
				var_01 = &"ZOMBIE_CIVILIANS_2";
				break;

			case 1:
				var_01 = &"ZOMBIE_CIVILIANS_1";
				break;
		}

		self settext(var_01);
		playsoundatpos((0,0,0),"zmb_weapon_upgrade_countdown");
		wait(1);
	}

	level notify("timer_countdown_complete");
}

//Function Number: 23
civrescuefail()
{
	wait(3);
	level.civfailedescorts++;
	thread penalty_powergenerators();
	thread penalty_magicbox();
	thread penalty_traps();
	thread penalty_wallbuys();
	thread penalty_weaponupgrades();
	maps\mp\_utility::gameflagset("power_off");
	var_00 = civfailduration();
	showteamsplashzombies("zombie_power_down");
	wait(3);
	foreach(var_02 in level.players)
	{
		if(isdefined(var_02.exosuitonline) && var_02.exosuitonline)
		{
			var_02 thread maps\mp\zombies\_mutators::mutatoremz_applyemp();
		}
	}

	setomnvar("ui_zm_powerdown",gettime() + var_00 * 1000);
	wait(var_00);
	maps\mp\_utility::gameflagclear("power_off");
	level notify("restore_power");
	iprintlnbold(&"ZOMBIE_CIVILIANS_POWER_RESTORED");
}

//Function Number: 24
civfailduration()
{
	if(level.civfailedescorts == 1)
	{
		return 60;
	}

	if(level.civfailedescorts == 2)
	{
		return 120;
	}

	if(level.civfailedescorts >= 3)
	{
		return 180;
	}
}

//Function Number: 25
showteamsplashzombies(param_00)
{
	foreach(var_02 in level.players)
	{
		if(maps\mp\zombies\_util::isonhumanteam(var_02) && maps\mp\_utility::isreallyalive(var_02))
		{
			var_02 thread maps\mp\gametypes\_hud_message::splashnotify(param_00);
		}
	}
}

//Function Number: 26
penalty_weaponupgrades()
{
	foreach(var_01 in level.weaponlevelboxes)
	{
		maps\mp\zombies\_wall_buys::weaponlevelboxdisable(var_01);
	}

	level waittill("restore_power");
	foreach(var_01 in level.weaponlevelboxes)
	{
		maps\mp\zombies\_wall_buys::weaponlevelboxenable(var_01);
	}
}

//Function Number: 27
penalty_wallbuys()
{
	var_00 = getentarray("wallbuy","targetname");
	foreach(var_02 in var_00)
	{
		maps\mp\zombies\_wall_buys::wallbuydisable(var_02);
	}

	level waittill("restore_power");
	foreach(var_02 in var_00)
	{
		maps\mp\zombies\_wall_buys::wallbuyenable(var_02);
	}
}

//Function Number: 28
penalty_powergenerators()
{
	level.poweroffpenalty = 1;
	level notify("zombie_power_penalty_start");
	foreach(var_01 in level.power_switches)
	{
		var_01 thread poweroffpenaltyhint();
	}

	level waittill("restore_power");
	level notify("zombie_power_penalty_end");
	level.poweroffpenalty = undefined;
}

//Function Number: 29
poweroffpenaltyhint()
{
	self.trigger setcursorhint("HINT_NOICON");
	self.trigger sethintstring(&"ZOMBIE_CIVILIANS_POWER_OFF_TRIGGER");
	level waittill("zombie_power_penalty_end");
	self.trigger setcursorhint("HINT_NOICON");
	self.trigger sethintstring(&"ZOMBIES_POWER_ON");
}

//Function Number: 30
penalty_magicbox()
{
	foreach(var_01 in level.magicboxlocations)
	{
		if(var_01.active == 0)
		{
			continue;
		}

		var_01 thread magicboxdisablepenaltythink();
	}
}

//Function Number: 31
magicboxdisablepenaltythink()
{
	level endon("game_ended");
	maps\mp\zombies\_wall_buys::deactivatemagicbox();
	level waittill("restore_power");
	maps\mp\zombies\_wall_buys::reactivatemagicbox();
}

//Function Number: 32
penalty_pickups()
{
	level.nopickuppenalty = 1;
	level waittill("restore_power");
	level.nopickuppenalty = 0;
}

//Function Number: 33
penalty_droppods()
{
	level.nodroppodpenalty = 1;
	if(isdefined(level.carepackages))
	{
		foreach(var_01 in level.carepackages)
		{
			var_01 maps\mp\killstreaks\_airdrop::deletecrate(1);
		}
	}

	level waittill("restore_power");
	level.nodroppodpenalty = undefined;
}

//Function Number: 34
penalty_traps()
{
	foreach(var_01 in level.traps)
	{
		var_01 thread trapdisablepenaltythink();
	}
}

//Function Number: 35
trapdisablepenaltythink()
{
	level endon("game_ended");
	var_00 = self;
	var_00 maps\mp\zombies\_traps::trap_deactivate();
	level waittill("restore_power");
	var_00 maps\mp\zombies\_traps::trap_reactivate();
}

//Function Number: 36
debug_setupallrewards()
{
	var_00 = [];
	var_00[0] = "bronze_class";
	var_00[1] = "silver_class";
	var_00[2] = "gold_class";
	foreach(var_02 in var_00)
	{
		thread debug_setupreward(var_02);
	}
}

//Function Number: 37
debug_setupreward(param_00)
{
	var_01 = "scr_reward_" + param_00;
	var_02 = "devgui_cmd \"Zombie:2/Toggle Civ Rewards/" + param_00 + "\" \"togglep " + var_01 + " 0 1\";";
	for(;;)
	{
		while(getdvarint(var_01,0) == 0)
		{
			wait 0.05;
		}

		if(param_00 == "bronze_class")
		{
			thread civrescuesuccessreward("bronze");
			continue;
		}

		if(param_00 == "silver_class")
		{
			thread civrescuesuccessreward("silver");
			continue;
		}

		if(param_00 == "gold_class")
		{
			thread civrescuesuccessreward("gold");
			continue;
		}

		thread reward_enable(param_00);
	}
}

//Function Number: 38
debug_setuppenalty()
{
	var_00 = "scr_rescue_civ_penalty";
	var_01 = "devgui_cmd \"Zombie:2/Toggle Civ Penalty\" \"togglep " + var_00 + " 0 1\";";
	for(;;)
	{
		while(getdvarint(var_00,0) == 0)
		{
			wait 0.05;
		}

		thread civrescuefail();
	}
}