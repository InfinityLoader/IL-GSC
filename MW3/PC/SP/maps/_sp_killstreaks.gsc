/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_sp_killstreaks.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 35
 * Decompile Time: 568 ms
 * Timestamp: 10/27/2023 2:20:50 AM
*******************************************************************/

//Function Number: 1
sp_killstreaks_global_preload()
{
	precachestring(&"SP_KILLSTREAKS_CAPTURING_CRATE");
	precacheshader("progress_bar_fill");
	precacheshader("progress_bar_bg");
	precacheshader("dpad_killstreak_carepackage");
	precacheshader("specialty_carepackage");
	precachestring(&"SP_KILLSTREAKS_SHAREPACKAGE_TITLE");
	precachestring(&"SP_KILLSTREAKS_SHAREPACKAGE_DESC");
	precachestring(&"SP_KILLSTREAKS_CRATE_HIJACK_TITLE");
	precachestring(&"SP_KILLSTREAKS_CRATE_HIJACK_DESC");
	precachestring(&"SP_KILLSTREAKS_EARNED_AIRDROP");
	precachestring(&"SP_KILLSTREAKS_NAME_AIRDROP");
	precacheitem("killstreak_sentry_sp");
	precacheshader("specialty_sentry_gun_crate");
	precacheshader("specialty_airdrop_sentry_minigun");
	precachestring(&"SP_KILLSTREAKS_EARNED_AIRDROP_SENTRY");
	precachestring(&"SP_KILLSTREAKS_SENTRY_PICKUP");
	precachestring(&"SP_KILLSTREAKS_REWARDNAME_AIRDROP_SENTRY");
	precachestring(&"SP_KILLSTREAKS_REWARDNAME_SENTRY");
	precacheshader("specialty_stalker");
	precacheshader("specialty_longersprint");
	precacheshader("specialty_fastreload");
	precacheshader("specialty_quickdraw");
	precacheshader("specialty_steadyaim");
	precachestring(&"SP_KILLSTREAKS_SPECIALTY_LONGERSPRINT_PICKUP");
	precachestring(&"SP_KILLSTREAKS_SPECIALTY_FASTRELOAD_PICKUP");
	precachestring(&"SP_KILLSTREAKS_SPECIALTY_QUICKDRAW_PICKUP");
	precachestring(&"SP_KILLSTREAKS_SPECIALTY_BULLETACCURACY_PICKUP");
	precachestring(&"SP_KILLSTREAKS_SPECIALTY_STALKER_PICKUP");
	precacheitem("c4");
	precacheshader("hud_icon_c4");
	precachestring(&"SP_KILLSTREAKS_EARNED_AIRDROP_C4");
	precachestring(&"SP_KILLSTREAKS_C4_PICKUP");
	precachestring(&"SP_KILLSTREAKS_REWARDNAME_AIRDROP_C4");
	precacheshader("waypoint_ammo_friendly");
	precachestring(&"PLATFORM_RESUPPLY");
	precachestring(&"SP_KILLSTREAKS_REWARDNAME_AIRDROP_AMMO");
	precacheitem("remote_missile_detonator");
	precacheitem("remote_missile");
	precacheshader("dpad_killstreak_hellfire_missile");
	precacheshader("specialty_predator_missile");
	precachestring(&"SP_KILLSTREAKS_EARNED_PREDATOR_MISSILE");
	precachestring(&"SP_KILLSTREAKS_REMOTEMISSILE_PICKUP");
	precachestring(&"SP_KILLSTREAKS_REWARDNAME_AIRDROP_REMOTEMISSILE");
	precachestring(&"SP_KILLSTREAKS_REWARDNAME_REMOTEMISSILE");
	precacheshader("specialty_nuke");
}

//Function Number: 2
sp_killstreaks_init()
{
	level.ks = spawnstruct();
	level.ks.killstreaktypes = [];
	var_00 = common_scripts\utility::getstruct("map_center","targetname");
	level.mapcenter = var_00.origin;
	common_scripts\utility::array_thread(level.players,::sp_killstreaks_player_init);
	if(!maps\_sp_airdrop::sp_airdrop_init_done())
	{
		maps\_sp_airdrop::sp_airdrop_init();
	}

	sp_killstreaks_hud_init();
	level.ks.globalinitdone = 1;
}

//Function Number: 3
sp_killstreaks_hud_init()
{
	level.uiparent = spawnstruct();
	level.uiparent.horzalign = "left";
	level.uiparent.vertalign = "top";
	level.uiparent.alignx = "left";
	level.uiparent.aligny = "top";
	level.uiparent.x = 0;
	level.uiparent.y = 0;
	level.uiparent.width = 0;
	level.uiparent.height = 0;
	level.uiparent.children = [];
	level.fontheight = 12;
	level.hud["allies"] = spawnstruct();
	level.hud["axis"] = spawnstruct();
	level.primaryprogressbary = -61;
	level.primaryprogressbarx = 0;
	level.primaryprogressbarheight = 9;
	level.primaryprogressbarwidth = 120;
	level.primaryprogressbartexty = -75;
	level.primaryprogressbartextx = 0;
	level.primaryprogressbarfontsize = 0.6;
	level.teamprogressbary = 32;
	level.teamprogressbarheight = 14;
	level.teamprogressbarwidth = 192;
	level.teamprogressbartexty = 8;
	level.teamprogressbarfontsize = 1.65;
	if(issplitscreen())
	{
		level.lowertextyalign = "BOTTOM";
		level.lowertexty = -76;
		level.lowertextfontsize = 1.14;
		return;
	}

	level.lowertextyalign = "CENTER";
	level.lowertexty = 70;
	level.lowertextfontsize = 1.6;
}

//Function Number: 4
sp_killstreaks_init_done()
{
	return isdefined(level.ks) && isdefined(level.ks.globalinitdone);
}

//Function Number: 5
sp_killstreaks_player_init()
{
	self.ks = spawnstruct();
	self.ks.killstreaks = [];
	thread sp_killstreak_use_waiter();
	if(!isdefined(self.remotemissile_actionslot))
	{
		self.remotemissile_actionslot = 4;
	}

	thread maps\_remotemissile_utility::remotemissile_no_autoreload();
}

//Function Number: 6
add_sp_killstreak(param_00)
{
	var_01 = undefined;
	var_02 = undefined;
	var_03 = undefined;
	var_04 = undefined;
	var_05 = undefined;
	var_06 = undefined;
	var_07 = undefined;
	var_08 = undefined;
	var_09 = undefined;
	if(issubstr(param_00,"specialty_"))
	{
		var_01 = "airdrop_marker_mp";
		var_02 = ::sp_killstreak_carepackage_main;
		var_0A = "SP_KILLSTREAKS_REWARDNAME_AIRDROP";
		var_03 = "UK_1mc_achieve_carepackage";
		var_04 = "UK_1mc_use_carepackage";
		var_05 = "specialty_carepackage";
		var_06 = &"SP_KILLSTREAKS_EARNED_AIRDROP";
		var_09 = ::sp_killstreak_perk_crateopen;
		switch(param_00)
		{
			case "specialty_longersprint":
				var_07 = "specialty_longersprint";
				var_08 = &"SP_KILLSTREAKS_SPECIALTY_LONGERSPRINT_PICKUP";
				break;

			case "specialty_fastreload":
				var_07 = "specialty_fastreload";
				var_08 = &"SP_KILLSTREAKS_SPECIALTY_FASTRELOAD_PICKUP";
				break;

			case "specialty_quickdraw":
				var_07 = "specialty_quickdraw";
				var_08 = &"SP_KILLSTREAKS_SPECIALTY_QUICKDRAW_PICKUP";
				break;

			case "specialty_detectexplosive":
				var_07 = "specialty_bombsquad";
				var_08 = &"SP_KILLSTREAKS_SPECIALTY_DETECTEXPLOSIVE_PICKUP";
				break;

			case "specialty_bulletaccuracy":
				var_07 = "specialty_steadyaim";
				var_08 = &"SP_KILLSTREAKS_SPECIALTY_BULLETACCURACY_PICKUP";
				break;

			case "specialty_stalker":
				var_07 = "specialty_stalker";
				var_08 = &"SP_KILLSTREAKS_SPECIALTY_STALKER_PICKUP";
				break;

			default:
				break;
		}
	}
	else
	{
		switch(var_01)
		{
			case "carepackage":
				var_02 = "airdrop_marker_mp";
				var_03 = ::sp_killstreak_carepackage_main;
				var_0A = "SP_KILLSTREAKS_REWARDNAME_AIRDROP";
				var_03 = "UK_1mc_achieve_carepackage";
				var_04 = "UK_1mc_use_carepackage";
				var_05 = "specialty_carepackage";
				var_06 = &"SP_KILLSTREAKS_EARNED_AIRDROP";
				var_07 = "dpad_killstreak_carepackage";
				var_08 = &"SP_KILLSTREAKS_NAME_AIRDROP";
				var_09 = undefined;
				break;

			case "carepackage_sentry":
				var_02 = "airdrop_marker_mp";
				var_03 = ::sp_killstreak_carepackage_main;
				var_0A = "SP_KILLSTREAKS_REWARDNAME_AIRDROP_SENTRY";
				var_03 = "UK_1mc_deploy_sentry";
				var_04 = undefined;
				var_05 = "specialty_airdrop_sentry_minigun";
				var_06 = &"SP_KILLSTREAKS_EARNED_AIRDROP_SENTRY";
				var_07 = "specialty_sentry_gun_crate";
				var_08 = &"SP_KILLSTREAKS_SENTRY_PICKUP";
				var_09 = undefined;
				break;

			case "sentry":
				var_02 = "killstreak_sentry_sp";
				var_03 = ::sp_killstreak_autosentry_main;
				var_0A = "SP_KILLSTREAKS_REWARDNAME_SENTRY";
				if(getdvarint("survival_chaos") == 1)
				{
					var_03 = "cm_bp_cp_sentrygun";
				}
				else
				{
					var_03 = "UK_1mc_deploy_sentry";
				}
	
				var_04 = undefined;
				var_05 = "specialty_airdrop_sentry_minigun";
				var_06 = &"SP_KILLSTREAKS_EARNED_AIRDROP_SENTRY";
				var_07 = "specialty_sentry_gun_crate";
				var_08 = &"SP_KILLSTREAKS_SENTRY_PICKUP";
				var_09 = undefined;
				break;

			case "sentry_gl":
				var_02 = "killstreak_sentry_sp";
				var_03 = ::sp_killstreak_autosentry_gl_main;
				var_0A = "SP_KILLSTREAKS_REWARDNAME_SENTRY";
				var_03 = "UK_1mc_deploy_sentry";
				var_04 = undefined;
				var_05 = "specialty_airdrop_sentry_minigun";
				var_06 = &"SP_KILLSTREAKS_EARNED_AIRDROP_SENTRY";
				var_07 = "specialty_sentry_gun_crate";
				var_08 = &"SP_KILLSTREAKS_SENTRY_PICKUP";
				var_09 = undefined;
				break;

			case "carepackage_remote_missile":
				var_02 = "airdrop_marker_mp";
				var_03 = ::sp_killstreak_carepackage_main;
				var_0A = "SP_KILLSTREAKS_REWARDNAME_AIRDROP_REMOTEMISSILE";
				var_03 = "UK_1mc_achieve_carepackage";
				var_04 = "UK_1mc_use_carepackage";
				var_05 = "specialty_predator_missile";
				var_06 = &"SP_KILLSTREAKS_";
				var_07 = "dpad_killstreak_carepackage";
				var_08 = &"SP_KILLSTREAKS_NAME_AIRDROP";
				var_09 = undefined;
				break;

			case "remote_missile":
				var_02 = "remote_missile_detonator";
				var_03 = ::sp_killstreak_remotemissile_main;
				var_0A = "SP_KILLSTREAKS_REWARDNAME_REMOTEMISSILE";
				var_03 = "UK_1mc_achieve_hellfire";
				var_04 = "UK_1mc_use_hellfire";
				var_05 = "specialty_predator_missile";
				var_06 = &"SP_KILLSTREAKS_EARNED_PREDATOR_MISSILE";
				var_07 = "dpad_killstreak_hellfire_missile";
				var_08 = &"SP_KILLSTREAKS_REMOTEMISSILE_PICKUP";
				var_09 = undefined;
				break;

			case "carepackage_c4":
				var_02 = "airdrop_marker_mp";
				var_03 = ::sp_killstreak_carepackage_main;
				var_0A = "SP_KILLSTREAKS_REWARDNAME_AIRDROP_C4";
				var_03 = "UK_1mc_achieve_carepackage";
				var_04 = "UK_1mc_use_carepackage";
				var_05 = "hud_icon_c4";
				var_06 = &"SP_KILLSTREAKS_EARNED_AIRDROP_C4";
				var_07 = "hud_icon_c4";
				var_08 = &"SP_KILLSTREAKS_C4_PICKUP";
				var_09 = ::sp_killstreak_c4_crateopen;
				break;

			case "carepackage_ammo":
				var_02 = "airdrop_marker_mp";
				var_03 = ::sp_killstreak_carepackage_main;
				var_0A = "SP_KILLSTREAKS_REWARDNAME_AIRDROP_AMMO";
				var_03 = "UK_1mc_achieve_carepackage";
				var_04 = "UK_1mc_use_carepackage";
				var_05 = "specialty_carepackage";
				var_06 = &"SP_KILLSTREAKS_EARNED_AIRDROP";
				var_07 = "waypoint_ammo_friendly";
				var_08 = &"PLATFORM_RESUPPLY";
				var_09 = ::sp_killstreak_ammo_crateopen;
				break;

			case "carepackage_precision_airstrike":
				var_02 = "airdrop_marker_mp";
				var_03 = ::sp_killstreak_carepackage_main;
				var_0A = "SP_KILLSTREAKS_REWARDNAME_PRECISION_AIRSTRIKE";
				var_03 = "UK_1mc_achieve_carepackage";
				var_04 = "UK_1mc_use_carepackage";
				var_05 = "specialty_precision_airstrike";
				var_06 = &"SP_KILLSTREAKS_EARNED_PRECISION_AIRSTRIKE";
				var_07 = "dpad_killstreak_carepackage";
				var_08 = &"SP_KILLSTREAKS_PRECISION_AIRSTRIKE_PICKUP";
				var_09 = undefined;
				break;

			case "precision_airstrike":
				var_02 = "killstreak_precision_airstrike_sp";
				var_03 = ::sp_killstreak_airstrike_main;
				var_0A = "SP_KILLSTREAKS_REWARDNAME_PRECISION_AIRSTRIKE";
				var_03 = "UK_1mc_achieve_airstrike";
				var_04 = "UK_1mc_use_airstrike";
				var_05 = "specialty_precision_airstrike";
				var_06 = &"SP_KILLSTREAKS_EARNED_PRECISION_AIRSTRIKE";
				var_07 = "dpad_killstreak_precision_airstrike";
				var_08 = &"SP_KILLSTREAKS_PRECISION_AIRSTRIKE_PICKUP";
				var_09 = undefined;
				break;

			case "carepackage_stealth_airstrike":
				var_02 = "airdrop_marker_mp";
				var_03 = ::sp_killstreak_carepackage_main;
				var_0A = "SP_KILLSTREAKS_REWARDNAME_STEALTH_AIRSTRIKE";
				var_03 = "UK_1mc_achieve_carepackage";
				var_04 = "UK_1mc_use_carepackage";
				var_05 = "specialty_stealth_bomber";
				var_06 = &"SP_KILLSTREAKS_EARNED_STEALTH_AIRSTRIKE";
				var_07 = "dpad_killstreak_carepackage";
				var_08 = &"SP_KILLSTREAKS_STEALTH_AIRSTRIKE_PICKUP";
				var_09 = undefined;
				break;

			case "stealth_airstrike":
				var_02 = "killstreak_stealth_airstrike_sp";
				var_03 = ::sp_killstreak_airstrike_main;
				var_0A = "SP_KILLSTREAKS_REWARDNAME_STEALTH_AIRSTRIKE";
				var_03 = "UK_1mc_achieve_airstrike";
				var_04 = "UK_1mc_use_airstrike";
				var_05 = "specialty_stealth_bomber";
				var_06 = &"SP_KILLSTREAKS_EARNED_STEALTH_AIRSTRIKE";
				var_07 = "dpad_killstreak_stealth_bomber";
				var_08 = &"SP_KILLSTREAKS_STEALTH_AIRSTRIKE_PICKUP";
				var_09 = undefined;
				break;

			default:
				break;
		}
	}

	var_0B = spawnstruct();
	var_0B.streaktype = param_00;
	var_0B.weaponname = var_01;
	var_0B.streakfunc = var_02;
	var_0B.menurewarddesc = var_0A;
	var_0B.achievevo = var_03;
	var_0B.usevo = var_04;
	var_0B.splashicon = var_05;
	var_0B.splashhint = var_06;
	var_0B.crateicon = var_07;
	var_0B.cratehint = var_08;
	var_0B.crateopenfunc = var_09;
	level.ks.killstreaktypes[param_00] = var_0B;
	add_killstreak_radio_dialogue(var_03,var_04);
}

//Function Number: 7
add_killstreak_radio_dialogue(param_00,param_01)
{
	if(!isdefined(level.scr_radio))
	{
		level.scr_radio = [];
	}

	var_02[0] = param_00;
	foreach(var_04 in var_7B)
	{
		if(!maps\_utility::array_contains(level.scr_radio,var_04) && isdefined(var_04))
		{
			level.scr_radio[var_04] = var_04;
		}
	}
}

//Function Number: 8
sp_killstreak_exists(param_00)
{
	foreach(var_03, var_02 in level.ks.killstreaktypes)
	{
		if(var_03 == param_00)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 9
get_sp_killstreak_info(param_00)
{
	var_01 = level.ks.killstreaktypes[param_00];
	return var_01;
}

//Function Number: 10
give_sp_killstreak(param_00,param_01)
{
	if(!isdefined(self.ks.killstreaks[0]))
	{
		self.ks.killstreaks[0] = param_00;
	}
	else
	{
		var_02 = [];
		foreach(var_04 in self.ks.killstreaks)
		{
			var_7B[var_7B.size] = var_04;
		}

		self.ks.killstreaks = var_7B;
	}

	activate_current_sp_killstreak(var_02);
}

//Function Number: 11
activate_current_sp_killstreak(param_00)
{
	var_01 = self.ks.killstreaks[0];
	var_02 = get_sp_killstreak_info(var_01);
	self giveweapon(var_02.weaponname);
	self setactionslot(4,"weapon",var_02.weaponname);
	if(var_01 == "remote_missile")
	{
		maps\_remotemissile::enable_uav(1,var_02.weaponname);
	}

	if(!isdefined(param_00) || !param_00)
	{
		thread maps\_utility::radio_dialogue(var_02.achievevo);
	}
}

//Function Number: 12
take_sp_killstreak(param_00)
{
	var_01 = 0;
	foreach(var_05, var_03 in self.ks.killstreaks)
	{
		if(var_03 == param_00)
		{
			self.ks.killstreaks = common_scripts\utility::array_remove(self.ks.killstreaks,param_00);
			if(var_05 == 0)
			{
				var_04 = get_sp_killstreak_info(param_00);
				self takeweapon(var_04.weaponname);
			}

			var_01 = 1;
			break;
		}
	}

	if(has_any_killstreak())
	{
		activate_current_sp_killstreak();
	}
}

//Function Number: 13
has_any_killstreak()
{
	return self.ks.killstreaks.size;
}

//Function Number: 14
has_killstreak(param_00)
{
	if(has_any_killstreak())
	{
		foreach(var_02 in self.ks.killstreaks)
		{
			if(param_00 == var_02)
			{
				return 1;
			}
		}
	}

	return 0;
}

//Function Number: 15
sp_killstreak_use_waiter()
{
	self endon("death");
	for(;;)
	{
		self.ks.lastweaponused = self getcurrentweapon();
		self waittill("weapon_change",var_00);
		if(!isalive(self))
		{
			continue;
		}

		var_01 = self.ks.killstreaks[0];
		if(!isdefined(var_01))
		{
			continue;
		}

		var_02 = get_sp_killstreak_info(var_01);
		if(isdefined(var_02.weaponname))
		{
			if(var_00 != var_02.weaponname)
			{
				continue;
			}
		}

		waittillframeend;
		var_03 = sp_killstreak_use_pressed(var_02);
		if(var_03)
		{
			used_sp_killstreak(var_02);
			take_sp_killstreak(var_01);
		}
		else if(!isdefined(self.carrying_pickedup_sentry) || !self.carrying_pickedup_sentry)
		{
			post_killstreak_weapon_switchback();
		}

		if(maps\_utility::is_survival())
		{
			wait 0.05;
			if(isdefined(self.sentry_placement_failed) && self.sentry_placement_failed)
			{
				give_sp_killstreak(var_01,1);
			}
		}

		if(self getcurrentweapon() == "none")
		{
			while(self getcurrentweapon() == "none")
			{
				wait 0.05;
			}

			waittillframeend;
		}
	}
}

//Function Number: 16
sp_killstreak_use_pressed(param_00)
{
	var_01 = param_00.streaktype;
	if(!self isonground() && iscarrykillstreak(var_01))
	{
		return 0;
	}

	if(isusingremote())
	{
		return 0;
	}

	if(isdefined(self.selectinglocation))
	{
		return 0;
	}

	if(self isusingturret() && isridekillstreak(var_01) || iscarrykillstreak(var_01))
	{
		iprintlnbold(&"MP_UNAVAILABLE_USING_TURRET");
		return 0;
	}

	if(maps\_utility::ent_flag_exist("laststand_downed") && maps\_utility::ent_flag("laststand_downed") && isridekillstreak(var_01))
	{
		iprintlnbold(&"MP_UNAVILABLE_IN_LASTSTAND");
		return 0;
	}

	if(!common_scripts\utility::isweaponenabled())
	{
		return 0;
	}

	if(!self [[ param_00.streakfunc ]](param_00))
	{
		return 0;
	}

	return 1;
}

//Function Number: 17
used_sp_killstreak(param_00)
{
	self playlocalsound("weap_c4detpack_trigger_plr");
	if(isdefined(param_00.usevo) && param_00.streaktype != "remote_missile")
	{
		thread maps\_utility::radio_dialogue(param_00.usevo);
	}
}

//Function Number: 18
post_killstreak_weapon_switchback()
{
	if(maps\_utility::is_player_down(self))
	{
		return;
	}

	if(isdefined(self.ks.lastweaponused))
	{
		if(self.ks.lastweaponused == "none")
		{
			var_00 = self getweaponslistprimaries();
			self switchtoweapon(var_00[0]);
			return;
		}

		self switchtoweapon(self.ks.lastweaponused);
	}
}

//Function Number: 19
sp_killstreak_remotemissile_main(param_00)
{
	var_01 = param_00.weaponname;
	self.remotemissilefired = 0;
	thread sp_killstreak_remotemissile_waitforfire(param_00.usevo);
	while(self.using_uav)
	{
		wait 0.05;
	}

	self notify("stopped_using_uav");
	return self.remotemissilefired;
}

//Function Number: 20
sp_killstreak_remotemissile_waitforfire(param_00)
{
	self endon("stopped_using_uav");
	self waittill("player_fired_remote_missile");
	self.remotemissilefired = 1;
	thread maps\_utility::radio_dialogue(param_00);
}

//Function Number: 21
sp_killstreak_carepackage_main(param_00)
{
	var_01 = sp_carepackage_select_reward(param_00);
	var_02 = maps\_sp_airdrop::sp_try_use_airdrop(var_01);
	if(!var_02)
	{
		return 0;
	}

	return 1;
}

//Function Number: 22
sp_carepackage_select_reward(param_00)
{
	if(issubstr(param_00.streaktype,"specialty_"))
	{
		return param_00.streaktype;
	}

	if(param_00.streaktype == "carepackage_c4")
	{
		return "carepackage_c4";
	}
	else if(param_00.streaktype == "carepackage_remote_missile")
	{
		return "remote_missile";
	}
	else if(param_00.streaktype == "carepackage_sentry")
	{
		return "sentry";
	}
	else if(param_00.streaktype == "carepackage_ammo")
	{
		return "carepackage_ammo";
	}
	else if(param_00.streaktype == "carepackage_precision_airstrike")
	{
		return "precision_airstrike";
	}
	else if(param_00.streaktype == "carepackage_stealth_airstrike")
	{
		return "stealth_airstrike";
	}

	var_01 = [];
	var_02 = [];
	var_01[var_01.size] = "sentry";
	var_02[var_02.size] = "remote_missile";
	var_02[var_02.size] = "precision_airstrike";
	var_02[var_02.size] = "stealth_airstrike";
	var_02[var_02.size] = "carepackage_c4";
	var_02[var_02.size] = "carepackage_ammo";
	return getweightedchanceroll(var_02,var_7B);
}

//Function Number: 23
sp_killstreak_ammo_crateopen()
{
	self playlocalsound("ammo_crate_use");
	refillammo();
}

//Function Number: 24
refillammo()
{
	var_00 = self getweaponslistall();
	foreach(var_02 in var_00)
	{
		if(issubstr(var_02,"grenade"))
		{
			if(self getammocount(var_02) >= 1)
			{
				continue;
			}
		}

		self givemaxammo(var_02);
	}
}

//Function Number: 25
sp_killstreak_perk_crateopen(param_00)
{
	thread maps\_so_survival_perks::give_perk(param_00);
}

//Function Number: 26
sp_killstreak_c4_crateopen()
{
	if(!self hasweapon("c4"))
	{
		self giveweapon("c4");
		self setactionslot(2,"weapon","c4");
		return;
	}

	if(self getfractionmaxammo("c4") == 1)
	{
		return;
	}

	var_00 = self getweaponammostock("c4");
	self setweaponammostock("c4",var_00 + 4);
}

//Function Number: 27
sp_killstreak_autosentry_main(param_00)
{
	lib_0616::givesentry("sentry_minigun");
	thread sentry_cancel_notify();
	self notifyonplayercommand("controller_sentry_cancel","+actionslot 4");
	self notifyonplayercommand("controller_sentry_cancel","weapnext");
	common_scripts\utility::waittill_any("sentry_placement_finished","sentry_placement_canceled");
	post_killstreak_weapon_switchback();
	return 1;
}

//Function Number: 28
sp_killstreak_autosentry_gl_main(param_00)
{
	lib_0616::givesentry("sentry_gun");
	thread sentry_cancel_notify();
	self notifyonplayercommand("controller_sentry_cancel","+actionslot 4");
	self notifyonplayercommand("controller_sentry_cancel","weapnext");
	common_scripts\utility::waittill_any("sentry_placement_finished","sentry_placement_canceled");
	post_killstreak_weapon_switchback();
	return 1;
}

//Function Number: 29
sentry_cancel_notify()
{
	self endon("sentry_placement_canceled");
	self endon("sentry_placement_finished");
	self waittill("controller_sentry_cancel");
	if(!isdefined(self.carrying_pickedup_sentry) || !self.carrying_pickedup_sentry)
	{
		self notify("sentry_placement_canceled");
	}
}

//Function Number: 30
sp_killstreak_airstrike_main(param_00)
{
	var_01 = param_00.streaktype;
	var_02 = "default";
	if(var_01 == "precision_airstrike")
	{
		var_02 = "precision";
	}
	else if(var_01 == "stealth_airstrike")
	{
		var_02 = "stealth";
	}

	var_03 = maps\_sp_airstrike::try_use_airstrike(var_02);
	post_killstreak_weapon_switchback();
	return var_03;
}

//Function Number: 31
isusingremote()
{
	return isdefined(self.usingremote);
}

//Function Number: 32
isridekillstreak(param_00)
{
	switch(param_00)
	{
		case "predator_missile":
		case "helicopter_mk19":
		case "helicopter_minigun":
		case "ac130":
			return 1;

		default:
			return 0;
	}
}

//Function Number: 33
iscarrykillstreak(param_00)
{
	switch(param_00)
	{
		case "sentry_gl":
		case "sentry":
			return 1;

		default:
			return 0;
	}
}

//Function Number: 34
deadlykillstreak(param_00)
{
	switch(param_00)
	{
		case "harrier_airstrike":
		case "predator_missile":
		case "stealth_airstrike":
		case "precision_airstrike":
		case "ac130":
			return 1;
	}

	return 0;
}

//Function Number: 35
getweightedchanceroll(param_00,param_01)
{
	var_02 = undefined;
	var_03 = -1;
	foreach(var_05 in param_00)
	{
		if(param_01[var_05] <= 0)
		{
			continue;
		}

		var_06 = randomint(param_01[var_05]);
		if(isdefined(var_02) && param_01[var_02] >= 100)
		{
			if(param_01[var_05] < 100)
			{
				continue;
			}

			continue;
		}

		if(param_01[var_05] >= 100)
		{
			var_02 = var_05;
			var_03 = var_06;
			continue;
		}

		if(var_06 > var_03)
		{
			var_02 = var_05;
			var_03 = var_06;
		}
	}

	return var_02;
}