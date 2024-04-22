/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\zombies\_wall_buys.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 87
 * Decompile Time: 1409 ms
 * Timestamp: 4/22/2024 2:14:18 AM
*******************************************************************/

//Function Number: 1
init()
{
	level thread mapweaponnamestonumbers();
	level thread wallbuyinit();
	initmagicboxweapons();
	level thread magicboxthink();
	level thread magicboxmaps();
	level thread weaponlevelboxinit();
}

//Function Number: 2
wallbuyinit()
{
	level.wallbuyweapons = [];
	var_00 = getentarray("wallbuy","targetname");
	foreach(var_02 in var_00)
	{
		level thread wallbuythink(var_02);
	}
}

//Function Number: 3
wallbuyupdatehinstrings(param_00)
{
	param_00 endon("disconnect");
	for(;;)
	{
		common_scripts\utility::waittill_any_ents(param_00,"weapon_change",param_00,"new_equipment",level,"disableWallbuysUpdate");
		var_01 = 0;
		var_02 = "";
		var_03 = param_00 getweaponslistall();
		foreach(var_05 in var_03)
		{
			var_02 = getweaponbasename(var_05);
			if(var_02 == self.weaponname)
			{
				var_01 = 1;
				break;
			}

			var_06 = maps\mp\zombies\_util::getzombieequipmentalternatename(var_02);
			if(isdefined(var_06) && var_06 == self.weaponname)
			{
				var_01 = 1;
				break;
			}
		}

		var_08 = param_00 getcurrentprimaryweapon();
		var_09 = 0;
		if(!maps\mp\zombies\_util::iszombieequipment(self.weaponname))
		{
			var_09 = maps\mp\zombies\_util::getzombieweaponlevel(param_00,self.weaponname);
		}

		self setcursorhint("HINT_NOICON");
		if(maps\mp\zombies\_util::isrippedturretweapon(var_08) || maps\mp\zombies\_util::iszombiekillstreakweapon(var_08) || maps\mp\zombies\_util::arewallbuysdisabled())
		{
			self sethintstring("");
			self setsecondaryhintstring("");
			maps\mp\zombies\_util::tokenhintstring(0);
			continue;
		}

		if(var_01)
		{
			self sethintstring(getammohintstring(self));
			self setsecondaryhintstring(getammohintcoststring(self,var_09));
			maps\mp\zombies\_util::settokencost(maps\mp\zombies\_util::creditstotokens(self.currentammocost));
			maps\mp\zombies\_util::tokenhintstring(1);
			continue;
		}

		self sethintstring(getweaponhintstring(self));
		self setsecondaryhintstring(getweaponhintcoststring(self,var_09));
		maps\mp\zombies\_util::settokencost(maps\mp\zombies\_util::creditstotokens(self.currentweaponcost));
		maps\mp\zombies\_util::tokenhintstring(1);
	}
}

//Function Number: 4
cg_wallbuyupdatehintstrings(param_00)
{
	param_00 endon("disconnect");
	maps\mp\zombies\_util::cg_setupstorestrings(param_00);
	thread cg_storetriggermonitor(param_00);
	if(!isdefined(param_00.haveweapons))
	{
		param_00.haveweapons = [];
	}

	for(;;)
	{
		param_00 common_scripts\utility::waittill_any("weapon_change","new_equipment");
		param_00.haveweapons[self.weaponname] = 0;
		var_01 = "";
		var_02 = param_00 getweaponslistall();
		foreach(var_04 in var_02)
		{
			var_01 = getweaponbasename(var_04);
			if(var_01 == self.weaponname)
			{
				param_00.haveweapons[self.weaponname] = 1;
				break;
			}

			var_05 = maps\mp\zombies\_util::getzombieequipmentalternatename(var_01);
			if(isdefined(var_05) && var_05 == self.weaponname)
			{
				param_00.haveweapons[self.weaponname] = 1;
				break;
			}
		}
	}
}

//Function Number: 5
cg_storetriggermonitor(param_00)
{
	param_00 endon("disconnect");
	for(;;)
	{
		while(!param_00 istouching(self))
		{
			wait(0.1);
		}

		var_01 = param_00 getcurrentprimaryweapon();
		var_02 = 0;
		if(!maps\mp\zombies\_util::iszombieequipment(self.weaponname))
		{
			var_02 = maps\mp\zombies\_util::getzombieweaponlevel(param_00,self.weaponname);
		}

		if(maps\mp\zombies\_util::isrippedturretweapon(var_01) || maps\mp\zombies\_util::iszombiekillstreakweapon(var_01) || maps\mp\zombies\_util::arewallbuysdisabled())
		{
			param_00.storedescription settext("");
			param_00.storecost settext("");
		}
		else if(param_00.haveweapons[self.weaponname] == 1)
		{
			param_00.storedescription settext(getammohintstring(self));
			param_00.storecost settext(getammohintcoststring(self,var_02));
		}
		else
		{
			param_00.storedescription settext(getweaponhintstring(self));
			param_00.storecost settext(getweaponhintcoststring(self,var_02));
		}

		cg_terminalwaittilltriggerexit(param_00);
		param_00.storedescription settext("");
		param_00.storecost settext("");
	}
}

//Function Number: 6
cg_terminalwaittilltriggerexit(param_00)
{
	param_00 endon("wallBuyStateChange");
	childthread cg_wallbuywaittillstatechange(param_00);
	while(param_00 istouching(self))
	{
		wait(0.1);
	}
}

//Function Number: 7
cg_wallbuywaittillstatechange(param_00)
{
	param_00 common_scripts\utility::waittill_any("weapon_change","new_equipment");
	param_00 notify("wallBuyStateChange");
}

//Function Number: 8
cg_onplayerconnectedwallbuyupdatehinstrings(param_00)
{
	param_00 endon("death");
	for(;;)
	{
		level waittill("connected",var_01);
		param_00 thread cg_wallbuyupdatehintstrings(var_01);
	}
}

//Function Number: 9
wallbuythink(param_00)
{
	level endon("game_ended");
	var_01 = param_00.script_noteworthy;
	var_02 = 1;
	var_03 = strtok(param_00.script_parameters,",");
	var_04 = int(var_03[0]);
	var_05 = 1000;
	if(!maps\mp\zombies\_util::iszombieequipment(var_01))
	{
		var_06 = var_01;
		var_01 = maps\mp\gametypes\_class::buildweaponname(var_01,"none","none","none",0,0);
		var_02 = 0;
	}

	if(var_03.size > 1)
	{
		var_05 = int(var_03[1]);
	}

	param_00.currentweaponcost = var_04;
	param_00.weaponcost = var_04;
	param_00.currentammocost = var_05;
	param_00.ammocost = var_05;
	param_00.weaponname = var_01;
	if(level.nextgen)
	{
		param_00.modelent = getent(param_00.target,"targetname");
		thread audio_wpnbox_attract_on(param_00.modelent);
		if(isdefined(param_00.modelent.target))
		{
			param_00.weaponent = getent(param_00.modelent.target,"targetname");
			if(maps\mp\zombies\_util::isusetriggerprimary(param_00) && !maps\mp\zombies\_util::iszombieequipment(var_01) && isdefined(param_00.weaponent))
			{
				var_07 = level.wallbuyweapons.size;
				level.wallbuyweapons[var_07]["baseName"] = param_00.script_noteworthy + "_mp";
				level.wallbuyweapons[var_07]["displayModel"] = param_00.weaponent.model;
			}
		}

		if(maps\mp\zombies\_util::isusetriggerprimary(param_00))
		{
			if(isdefined(param_00.weaponent))
			{
				param_00.weaponent cloakingenable();
				param_00.weaponent hideweapontags(var_01);
				param_00.weaponent.origin = param_00.modelent.origin;
				var_08 = undefined;
				if(var_01 == "teleport_zombies_mp")
				{
					var_08 = [5,-3,4];
				}

				level thread centerweaponforwallbuy(param_00.modelent,param_00.weaponent,var_08);
			}

			maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("station_buy_weapon_pwr_on"),param_00.modelent,"tag_origin");
		}
	}
	else
	{
		if(isdefined(param_00.script_flag))
		{
			if(maps\mp\zombies\_util::isusetriggerprimary(param_00) && !maps\mp\zombies\_util::iszombieequipment(var_01) && isdefined(param_00.script_noteworthy))
			{
				var_07 = level.wallbuyweapons.size;
				level.wallbuyweapons[var_07]["baseName"] = param_00.script_noteworthy + "_mp";
				level.wallbuyweapons[var_07]["displayModel"] = param_00.script_flag;
			}
		}

		thread audio_wpnbox_attract_on(param_00);
	}

	if(level.nextgen)
	{
		maps\mp\zombies\_util::setupusetriggerforclient(param_00,::wallbuyupdatehinstrings);
	}
	else
	{
		foreach(var_0A in level.players)
		{
			param_00 thread cg_wallbuyupdatehintstrings(var_0A);
		}

		thread cg_onplayerconnectedwallbuyupdatehinstrings(param_00);
	}

	for(;;)
	{
		var_0C = param_00 maps\mp\zombies\_util::waittilltriggerortokenuse();
		var_0A = var_0C[0];
		var_0D = var_0C[1];
		var_0E = var_0A getcurrentprimaryweapon();
		if(level.nextgen)
		{
			if(maps\mp\zombies\_util::isrippedturretweapon(var_0E) || maps\mp\zombies\_util::iszombiekillstreakweapon(var_0E) || maps\mp\zombies\_util::arewallbuysdisabled())
			{
				return;
			}
		}
		else if(maps\mp\zombies\_util::isrippedturretweapon(var_0E) || maps\mp\zombies\_util::iszombiekillstreakweapon(var_0E) || maps\mp\zombies\_util::arewallbuysdisabled())
		{
			continue;
		}

		var_0F = param_00.currentweaponcost;
		if(level.nextgen)
		{
			var_01 = getupgradeweaponname(var_0A,var_01);
		}
		else
		{
			var_01 = getupgradeweaponname(var_0A,param_00.weaponname);
		}

		if(maps\mp\zombies\_util::playerhasweapon(var_0A,var_01))
		{
			var_0F = param_00.currentammocost;
			if(hasfullammo(var_0A,var_01))
			{
				displayfullammomessage(var_0A,var_02);
				continue;
			}
		}

		if(var_0D == "token")
		{
			var_0A maps\mp\gametypes\zombies::spendtoken(param_00.tokencost);
		}
		else if(!var_0A maps\mp\gametypes\zombies::attempttobuy(var_0F))
		{
			var_0A thread maps\mp\zombies\_zombies_audio::playerweaponbuy("wpn_no_cash");
			continue;
		}

		if(level.nextgen)
		{
			param_00 thread cloaking();
			param_00.modelent scriptmodelplayanim("dlc_weapon_box_01_activate");
			var_0A thread maps\mp\zombies\_zombies_audio::moneyspend();
			maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("station_buy_weapon"),param_00.modelent,"tag_printer_laser",1);
			maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("wall_buy_steam"),param_00.modelent,"tag_origin",1);
			param_00.modelent playsound("interact_weapon_box");
			thread audio_wpnbox_attract_in_use(param_00.modelent);
		}
		else
		{
			if(isdefined(param_00.target))
			{
				var_10 = common_scripts\utility::getstruct(param_00.target,"targetname");
				playfx(common_scripts\utility::getfx("station_buy_weapon"),var_10.origin,anglestoforward(var_10.angles),anglestoup(var_10.angles));
			}

			var_0A thread maps\mp\zombies\_zombies_audio::moneyspend();
			param_00 playsound("interact_weapon_box");
		}

		if(var_02)
		{
			givezombieequipment(var_0A,var_01);
			continue;
		}

		givezombieweapon(var_0A,var_01);
	}
}

//Function Number: 10
centerweaponforwallbuy(param_00,param_01,param_02)
{
	var_03 = [6,0,4];
	if(isdefined(param_02))
	{
		var_03 = param_02;
	}

	var_04 = param_00.origin;
	var_05 = anglestoaxis(param_00.angles);
	var_04 = var_04 + var_05["forward"] * var_03[0];
	var_04 = var_04 + var_05["right"] * var_03[1];
	var_04 = var_04 + var_05["up"] * var_03[2];
	var_06 = param_01 getpointinmodelbounds(0,1,0);
	var_07 = var_04 - var_06;
	param_01 dontinterpolate();
	param_01.origin = param_01.origin + var_07;
}

//Function Number: 11
cloaking()
{
	self notify("walbuy_cloak");
	self endon("walbuy_cloak");
	if(isdefined(self.weaponent))
	{
		self.weaponent cloakingdisable();
		wait(3.5);
		self.weaponent cloakingenable();
	}
}

//Function Number: 12
hasfullammo(param_00,param_01)
{
	if(maps\mp\zombies\_util::iszombieequipment(param_01) && !param_00 maps\mp\zombies\_terminals::hasexosuit())
	{
		var_02 = maps\mp\zombies\_util::getpreexoequipment(param_01);
		if(isdefined(var_02))
		{
			param_01 = var_02;
		}
	}

	if(param_00 setweaponammostock(param_01) < weaponmaxammo(param_01,param_00))
	{
		return 0;
	}

	if(param_00 getweaponammoclip(param_01) < weaponclipsize(param_01,param_00))
	{
		return 0;
	}

	return 1;
}

//Function Number: 13
displayfullammomessage(param_00,param_01)
{
	param_00 playsoundtoplayer("ui_button_error",param_00);
	if(param_01)
	{
		param_00 iprintlnbold(&"ZOMBIES_EQUIPMENT_FULL");
		return;
	}

	param_00 iprintlnbold(&"ZOMBIES_AMMO_FULL");
}

//Function Number: 14
getweaponhintstring(param_00)
{
	switch(param_00.script_noteworthy)
	{
		case "iw5_arx160zm":
			return &"ZOMBIES_ARX160";

		case "iw5_maulzm":
			return &"ZOMBIES_BULLDOG";

		case "contact_grenade_zombies_mp":
			return &"ZOMBIES_CONTACT";

		case "explosive_drone_zombie_mp":
			return &"ZOMBIES_EXPLOSIVE_DRONE";

		case "iw5_hbra3zm":
			return &"ZOMBIES_HBRA3";

		case "iw5_hmr9zm":
			return &"ZOMBIES_HMR9";

		case "iw5_himarzm":
			return &"ZOMBIES_IMR";

		case "iw5_m182sprzm":
			return &"ZOMBIES_MK14";

		case "iw5_mp11zm":
			return &"ZOMBIES_MP11";

		case "iw5_sac3zm":
			return &"ZOMBIES_SAC3";

		case "iw5_uts19zm":
			return &"ZOMBIES_TAC19";

		case "iw5_lsatzm":
			return &"ZOMBIES_LSAT";

		case "iw5_asawzm":
			return &"ZOMBIES_ASAW";

		case "iw5_rw1zm":
			return &"ZOMBIES_RW1";

		case "teleport_zombies_mp":
			return &"ZOMBIE_DLC3_TELEPORT_GRENADE";

		default:
			return &"ZOMBIES_WALL_BUY_AMMO_ERROR";
	}
}

//Function Number: 15
getweaponhintcoststring(param_00,param_01)
{
	param_00.currentweaponcost = param_00.weaponcost;
	if(param_01 > 4)
	{
		param_00.currentweaponcost = 2000;
	}

	if(param_01 > 9)
	{
		param_00.currentweaponcost = 3000;
	}

	if(param_01 > 14)
	{
		param_00.currentweaponcost = 4000;
	}

	if(param_01 > 19)
	{
		param_00.currentweaponcost = 5000;
	}

	if(isdefined(level.penaltycostincrease))
	{
		for(var_02 = 0;var_02 < level.penaltycostincrease;var_02++)
		{
			var_03 = maps\mp\zombies\_util::getincreasedcost(param_00.currentweaponcost);
			param_00.currentweaponcost = var_03;
		}
	}

	return maps\mp\zombies\_util::getcoststring(param_00.currentweaponcost);
}

//Function Number: 16
getammohintstring(param_00)
{
	switch(param_00.script_noteworthy)
	{
		case "contact_grenade_zombies_mp":
			return &"ZOMBIES_CONTACT_AMMO";

		case "explosive_drone_zombie_mp":
			return &"ZOMBIES_DRONE_AMMO";

		case "teleport_zombies_mp":
			return &"ZOMBIE_DLC3_TELEPORT_GRENADE_AMMO";
	}

	return &"ZOMBIES_WALL_BUY_AMMO";
}

//Function Number: 17
getammohintcoststring(param_00,param_01)
{
	switch(param_00.script_noteworthy)
	{
		case "contact_grenade_zombies_mp":
			return &"ZOMBIES_COST_500";

		case "explosive_drone_zombie_mp":
			return &"ZOMBIES_COST_500";

		case "teleport_zombies_mp":
			return &"ZOMBIES_COST_500";
	}

	param_00.currentammocost = param_00.ammocost;
	if(param_01 > 4)
	{
		param_00.currentammocost = 1000;
	}

	if(param_01 > 9)
	{
		param_00.currentammocost = 2000;
	}

	if(param_01 > 14)
	{
		param_00.currentammocost = 3000;
	}

	if(param_01 > 19)
	{
		param_00.currentammocost = 4000;
	}

	if(isdefined(level.ammocostdecrease))
	{
		var_02 = maps\mp\zombies\_util::getreducedcost(param_00.currentammocost);
		param_00.currentammocost = var_02;
	}

	if(isdefined(level.penaltycostincrease))
	{
		for(var_03 = 0;var_03 < level.penaltycostincrease;var_03++)
		{
			var_04 = maps\mp\zombies\_util::getincreasedcost(param_00.currentammocost);
			param_00.currentammocost = var_04;
		}
	}

	return maps\mp\zombies\_util::getcoststring(param_00.currentammocost);
}

//Function Number: 18
getweaponslistprimariesminusalts()
{
	var_00 = [];
	var_01 = self getweaponslistprimaries();
	foreach(var_03 in var_01)
	{
		if(!maps\mp\gametypes\_weapons::isaltmodeweapon(var_03))
		{
			var_00[var_00.size] = var_03;
		}
	}

	return var_00;
}

//Function Number: 19
givezombieweapon(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_02))
	{
		param_02 = 1;
	}

	if(!isdefined(param_03))
	{
		param_03 = 1;
	}

	var_04 = param_00 getweaponslistprimariesminusalts();
	if(var_04.size > 1)
	{
		var_05 = 1;
		foreach(var_07 in var_04)
		{
			if(param_01 == var_07)
			{
				var_05 = 0;
			}
		}

		if(var_05)
		{
			var_09 = param_00 getcurrentprimaryweapon();
			if(isdefined(level.customreplaceweaponfunc))
			{
				var_09 = [[ level.customreplaceweaponfunc ]](param_00);
			}
			else
			{
				if(var_09 == "none" || var_09 == "search_dstry_bomb_defuse_mp")
				{
					var_09 = param_00 common_scripts\utility::getlastweapon();
				}

				if(!param_00 hasweapon(var_09))
				{
					var_09 = param_00 maps\mp\killstreaks\_killstreaks::getfirstprimaryweapon();
				}
			}

			param_00 takeweapon(var_09);
		}
		else
		{
			zombiesgiveammoandswitch(param_01,param_02,var_04);
			return;
		}
	}
	else if(var_04.size == 1 && var_04[0] == param_01)
	{
		zombiesgiveammoandswitch(param_00,param_01,param_03);
		return;
	}

	maps\mp\gametypes\zombies::createzombieweaponstate(param_00,param_01);
	param_00 maps\mp\_utility::_giveweapon(param_01);
	param_00 givemaxammo(param_01);
	param_00 givemaxscriptedammo(param_01);
	if(param_03)
	{
		param_00 switchtoweaponimmediate(param_01);
	}

	if(isdefined(level.zmbprocessweapongivenfunc))
	{
		level thread [[ level.zmbprocessweapongivenfunc ]](param_00,param_01);
	}

	if(param_02)
	{
		param_00 maps\mp\zombies\_zombies_audio::play_weapon_vo(param_01);
	}

	giveweaponlevelachievement(param_00);
	writeweaponlisttomatchdata(param_00);
}

//Function Number: 20
writeweaponlisttomatchdata(param_00)
{
	if(maps\mp\zombies\_util::isplayerinlaststand(param_00))
	{
		if(isdefined(level.weaponnamemap["LastStand"]))
		{
			setmatchdata("players",param_00.clientid,"endMisses",level.weaponnamemap["LastStand"]);
			setmatchdata("players",param_00.clientid,"endGamesPlayed",level.weaponnamemap["LastStand"]);
			return;
		}

		return;
	}

	var_01 = param_00 getweaponslistprimaries();
	var_02 = [];
	foreach(var_04 in var_01)
	{
		var_02[var_02.size] = getweaponbasename(var_04);
	}

	if(isdefined(var_02[0]) && isdefined(level.weaponnamemap[var_02[0]]))
	{
		setmatchdata("players",param_00.clientid,"endMisses",level.weaponnamemap[var_02[0]]);
	}

	if(isdefined(var_02[1]) && isdefined(level.weaponnamemap[var_02[1]]))
	{
		setmatchdata("players",param_00.clientid,"endGamesPlayed",level.weaponnamemap[var_02[1]]);
	}
}

//Function Number: 21
givezombieequipment(param_00,param_01,param_02)
{
	if(maps\mp\zombies\_util::iszombielethal(param_01))
	{
		if(!param_00 maps\mp\zombies\_terminals::hasexosuit())
		{
			var_03 = maps\mp\zombies\_util::getpreexoequipment(param_01);
			if(isdefined(var_03))
			{
				param_01 = var_03;
			}
		}

		var_04 = param_00 getlethalweapon();
		if(var_04 != param_01)
		{
			param_00 takeweapon(var_04);
			param_00 setlethalweapon(param_01);
			param_00 giveweapon(param_01);
			fillweaponclip(param_00,param_01);
			if(isdefined(level.weaponnamemap[param_01]))
			{
				setmatchdata("players",param_00.clientid,"endLosses",level.weaponnamemap[param_01]);
			}

			param_00 notify("new_equipment");
		}
		else
		{
			param_00 setweaponammoclip(param_01,param_00 getweaponammoclip(param_01) + 1);
		}
	}
	else if(maps\mp\zombies\_util::iszombietactical(param_01))
	{
		if(maps\mp\zombies\_util::getzombieslevelnum() == 3 && param_01 == "teleport_zombies_mp")
		{
			level notify("player_purchased_teleport_grenade");
		}

		if(!param_00 maps\mp\zombies\_terminals::hasexosuit())
		{
			var_03 = maps\mp\zombies\_util::getpreexoequipment(param_01);
			if(isdefined(var_03))
			{
				param_01 = var_03;
			}
		}

		var_05 = param_00 gettacticalweapon();
		if(var_05 != param_01)
		{
			param_00 takeweapon(var_05);
			param_00 settacticalweapon(param_01);
			param_00 giveweapon(param_01);
			fillweaponclip(param_00,param_01);
			if(isdefined(level.weaponnamemap[param_01]))
			{
				setmatchdata("players",param_00.clientid,"endHits",level.weaponnamemap[param_01]);
			}

			param_00 notify("new_equipment");
		}
		else
		{
			param_00 setweaponammoclip(param_01,param_00 getweaponammoclip(param_01) + 1);
		}
	}

	if(isdefined(level.zmbprocessweapongivenfunc))
	{
		level thread [[ level.zmbprocessweapongivenfunc ]](param_00,param_01);
	}

	if(!isdefined(param_02))
	{
		param_02 = 1;
	}

	if(param_02)
	{
		param_00 maps\mp\zombies\_zombies_audio::play_weapon_vo(param_01);
	}
}

//Function Number: 22
fillweaponclip(param_00,param_01)
{
	var_02 = weaponclipsize(param_01,param_00);
	param_00 setweaponammoclip(param_01,var_02);
}

//Function Number: 23
plusoneweaponclip(param_00,param_01)
{
	var_02 = weaponclipsize(param_01,param_00);
	var_03 = param_00 getweaponammoclip(param_01);
	if(var_03 + 1 <= var_02)
	{
		var_03++;
	}

	param_00 setweaponammoclip(param_01,var_03);
}

//Function Number: 24
zombiesgiveammoandswitch(param_00,param_01,param_02)
{
	var_03 = weaponclipsize(param_01,param_00);
	param_00 setweaponammoclip(param_01,var_03,"right");
	if(issubstr(param_01,"akimbo"))
	{
		param_00 setweaponammoclip(param_01,var_03,"left");
	}

	param_00 givemaxammo(param_01);
	param_00 givemaxscriptedammo(param_01);
	if(param_02)
	{
		param_00 switchtoweaponimmediate(param_01);
	}
}

//Function Number: 25
givemaxscriptedammo(param_00)
{
	if(issubstr(param_00,"iw5_em1zm_mp"))
	{
		maps\mp\gametypes\zombies::playersetem1maxammo();
	}

	if(isdefined(level.givemaxscriptedammofunc))
	{
		self [[ level.givemaxscriptedammofunc ]](param_00);
	}
}

//Function Number: 26
magicboxmaps()
{
	var_00 = common_scripts\utility::getstructarray("magic_box_map","targetname");
	common_scripts\utility::array_thread(var_00,::magicboxmapinit);
}

//Function Number: 27
magicboxmapinit()
{
	self.box_locs = [];
	var_00 = getentarray(self.target,"targetname");
	var_01 = common_scripts\utility::getstructarray(self.target,"targetname");
	var_02 = common_scripts\utility::array_combine(var_00,var_01);
	foreach(var_04 in var_02)
	{
		switch(var_04.script_noteworthy)
		{
			case "current":
				var_04 hide();
				self.current_ent = var_04;
				break;

			case "all":
				var_04 hide();
				self.all_ent = var_04;
				break;

			case "box_loc":
				self.box_locs[self.box_locs.size] = var_04;
				break;

			case "breach_map":
				if(level.currentgen && maps\mp\_utility::getmapname() == "mp_zombie_ark")
				{
					break;
				}
				else if(isdefined(level.breachmapfunc))
				{
					level thread [[ level.breachmapfunc ]](var_04);
				}
				break;

			default:
				break;
		}
	}

	common_scripts\utility::flag_wait("magic_box_init");
	foreach(var_07 in self.box_locs)
	{
		thread magicboxmapcurrentthink(var_07);
	}

	thread magicboxmapallthink();
	thread magicboxmapoffthink();
}

//Function Number: 28
magicboxmapcurrentthink(param_00)
{
	for(;;)
	{
		common_scripts\utility::flag_wait(param_00.script_flag_true);
		var_01 = 0;
		while(maps\mp\_utility::gameflag("fire_sale"))
		{
			var_01 = 1;
			wait 0.05;
		}

		var_02 = 0;
		while(maps\mp\_utility::gameflag("power_off"))
		{
			var_02 = 1;
			wait 0.05;
		}

		if(var_01 || var_02)
		{
			common_scripts\utility::flag_waitopen(param_00.script_flag_true);
			continue;
		}

		self.current_ent show();
		self.current_ent.origin = param_00.origin;
		common_scripts\utility::flag_waitopen(param_00.script_flag_true);
	}
}

//Function Number: 29
magicboxmapallthink()
{
	for(;;)
	{
		self.all_ent hide();
		maps\mp\_utility::gameflagwait("fire_sale");
		self.all_ent show();
		self.current_ent hide();
		while(maps\mp\_utility::gameflag("fire_sale"))
		{
			wait 0.05;
		}

		self.current_ent show();
	}
}

//Function Number: 30
magicboxmapoffthink()
{
	for(;;)
	{
		maps\mp\_utility::gameflagwait("power_off");
		self.all_ent hide();
		self.current_ent hide();
		while(maps\mp\_utility::gameflag("power_off"))
		{
			wait 0.05;
		}

		self.current_ent show();
	}
}

//Function Number: 31
mapweaponnamestonumbers()
{
	level.weaponnamemap = [];
	level.weaponnamemap["iw5_rw1zm_mp"] = 1;
	level.weaponnamemap["iw5_vbrzm_mp"] = 2;
	level.weaponnamemap["iw5_gm6zm_mp"] = 3;
	level.weaponnamemap["iw5_rhinozm_mp"] = 4;
	level.weaponnamemap["iw5_lsatzm_mp"] = 5;
	level.weaponnamemap["iw5_asawzm_mp"] = 6;
	level.weaponnamemap["iw5_ak12zm_mp"] = 7;
	level.weaponnamemap["iw5_bal27zm_mp"] = 8;
	level.weaponnamemap["iw5_himarzm_mp"] = 9;
	level.weaponnamemap["iw5_asm1zm_mp"] = 10;
	level.weaponnamemap["iw5_sn6zm_mp"] = 11;
	level.weaponnamemap["iw5_sac3zm_mp"] = 12;
	level.weaponnamemap["iw5_fusionzm_mp"] = 13;
	level.weaponnamemap["distraction_drone_zombie_mp"] = 14;
	level.weaponnamemap["dna_aoe_grenade_zombie_mp"] = 15;
	level.weaponnamemap["iw5_exocrossbowzm_mp"] = 16;
	level.weaponnamemap["iw5_mahemzm_mp"] = 17;
	level.weaponnamemap["iw5_em1zm_mp"] = 18;
	level.weaponnamemap["iw5_dlcgun1zm_mp"] = 19;
	level.weaponnamemap["iw5_arx160zm_mp"] = 20;
	level.weaponnamemap["iw5_mp11zm_mp"] = 21;
	level.weaponnamemap["explosive_drone_zombie_mp"] = 22;
	level.weaponnamemap["contact_grenade_zombies_mp"] = 23;
	level.weaponnamemap["iw5_hbra3zm_mp"] = 24;
	level.weaponnamemap["iw5_hmr9zm_mp"] = 25;
	level.weaponnamemap["iw5_maulzm_mp"] = 26;
	level.weaponnamemap["iw5_m182sprzm_mp"] = 27;
	level.weaponnamemap["iw5_uts19zm_mp"] = 28;
	level.weaponnamemap["contact_grenade_throw_zombies_mp"] = 29;
	level.weaponnamemap["explosive_drone_throw_zombie_mp"] = 30;
	level.weaponnamemap["distraction_drone_throw_zombie_mp"] = 31;
	level.weaponnamemap["dna_aoe_grenade_throw_zombie_mp"] = 32;
	level.weaponnamemap["iw5_titan45zm_mp"] = 33;
	level.weaponnamemap["LastStand"] = 34;
	level.weaponnamemap["iw5_microwavezm_mp"] = 35;
	level.weaponnamemap["iw5_linegunzm_mp"] = 36;
	level.weaponnamemap["frag_grenade_zombies_mp"] = 37;
	level.weaponnamemap["frag_grenade_throw_zombies_mp"] = 38;
	level.weaponnamemap["iw5_dlcgun2zm_mp"] = 39;
	level.weaponnamemap["iw5_dlcgun3zm_mp"] = 40;
	level.weaponnamemap["teleport_zombies_mp"] = 41;
	level.weaponnamemap["repulsor_zombie_mp"] = 42;
	level.weaponnamemap["iw5_tridentzm_mp"] = 43;
	level.weaponnamemap["iw5_dlcgun4zm_mp"] = 44;
	level.weaponnamemap["iw5_exominigunzm_mp"] = 45;
	level.weaponnamemap["playermech_rocket_zm_mp"] = 46;
	level.weaponnamemap["iw5_juggernautrocketszm_mp"] = 47;
	level.weaponnamemap["playermech_rocket_swarm_zm_mp"] = 48;
}

//Function Number: 32
initmagicboxweapons()
{
	level.magicboxuses = 0;
	level.ondeckweapons = [];
	addmagicboxweapon("iw5_rw1zm","npc_rw1_main_base_static_holo",&"ZOMBIES_RW1","none","none","none");
	addmagicboxweapon("iw5_vbrzm","npc_vbr_base_static_holo",&"ZOMBIES_VBR","none","none","none");
	addmagicboxweapon("iw5_gm6zm","npc_gm6_base_static_holo",&"ZOMBIES_GM6","gm6scope","none","none");
	addmagicboxweapon("iw5_rhinozm","npc_rhino_base_static_holo",&"ZOMBIES_RHINO","none","none","none");
	addmagicboxweapon("iw5_lsatzm","npc_lsat_base_static_holo",&"ZOMBIES_LSAT","none","none","none");
	addmagicboxweapon("iw5_asawzm","npc_ameli_base_static_holo",&"ZOMBIES_ASAW","none","none","none");
	addmagicboxweapon("iw5_ak12zm","npc_ak12_base_static_holo",&"ZOMBIES_AK12","none","none","none");
	addmagicboxweapon("iw5_bal27zm","npc_bal27_base_black_static_holo",&"ZOMBIES_BAL27","none","none","none");
	addmagicboxweapon("iw5_himarzm","npc_himar_base_static_holo",&"ZOMBIES_IMR","none","none","none");
	addmagicboxweapon("iw5_asm1zm","npc_asm1_base_static_holo",&"ZOMBIES_ASM1","none","none","none");
	addmagicboxweapon("iw5_sn6zm","npc_sn6_base_black_static_holo",&"ZOMBIES_SN6","none","none","none");
	addmagicboxweapon("iw5_sac3zm","npc_sac3_base_static_holo",&"ZOMBIES_SAC3","none","none","none");
	addmagicboxweapon("iw5_fusionzm","npc_fusion_shotgun_base_holo",&"ZOMBIES_FUSION_RIFLE","none","none","none",2);
	addmagicboxweapon("distraction_drone_zombie","dlc_distraction_drone_01_holo",&"ZOMBIES_DISTRACTION_DRONE","none","none","none",2);
	addmagicboxweapon("dna_aoe_grenade_zombie","npc_exo_launcher_grenade_holo",&"ZOMBIES_DNA_AOE","none","none","none",2);
	addmagicboxweapon("iw5_exocrossbowzm","npc_crossbow_base_static_holo",&"ZOMBIES_CROSSBOW","none","none","none");
	addmagicboxweapon("iw5_mahemzm","npc_mahem_base_holo",&"ZOMBIES_MAHEM","none","none","none");
	addmagicboxweapon("iw5_em1zm","npc_em1_base_static_holo",&"ZOMBIES_EM1","none","none","none");
	addmagicboxweapon("iw5_dlcgun1zm","npc_dear_base_static_holo",&"ZOMBIES_DLC_GUN_1","none","none","none");
	if(isdefined(level.initmagicboxweaponsfunc))
	{
		[[ level.initmagicboxweaponsfunc ]]();
	}
}

//Function Number: 33
addmagicboxweapon(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	if(!isdefined(level.magicboxweapons))
	{
		level.magicboxweapons = [];
	}

	var_08 = level.magicboxweapons.size;
	level.magicboxweapons[var_08]["baseNameNoMP"] = param_00;
	level.magicboxweapons[var_08]["baseName"] = param_00 + "_mp";
	level.magicboxweapons[var_08]["fullName"] = param_00 + "_mp";
	level.magicboxweapons[var_08]["displayModel"] = param_01;
	level.magicboxweapons[var_08]["displayString"] = param_02;
	level.magicboxweapons[var_08]["attachment1"] = param_03;
	level.magicboxweapons[var_08]["attachment2"] = param_04;
	level.magicboxweapons[var_08]["attachment3"] = param_05;
	level.magicboxweapons[var_08]["limit"] = param_06;
	if(isdefined(param_07))
	{
		level.magicboxweapons[var_08]["forceSelect"] = randomint(param_07);
	}

	if(!maps\mp\zombies\_util::iszombieequipment(level.magicboxweapons[var_08]["baseName"]))
	{
		level.magicboxweapons[var_08]["fullName"] = maps\mp\gametypes\_class::buildweaponname(param_00,param_03,param_04,param_05,0,0);
	}
}

//Function Number: 34
removemagicboxweapon(param_00)
{
	var_01 = undefined;
	for(var_02 = 0;var_02 < level.magicboxweapons.size;var_02++)
	{
		if(level.magicboxweapons[var_02]["baseNameNoMP"] == param_00)
		{
			var_01 = var_02;
			break;
		}
	}

	if(isdefined(var_01))
	{
		level.magicboxweapons = maps\mp\zombies\_util::array_remove_index(level.magicboxweapons,var_01);
	}
}

//Function Number: 35
magicboxthink()
{
	level endon("game_ended");
	common_scripts\utility::flag_init("magic_box_init");
	common_scripts\utility::flag_init("magic_box_moved");
	level.magicboxlocations = getentarray("magic_box","targetname");
	var_00 = undefined;
	foreach(var_02 in level.magicboxlocations)
	{
		var_02.modelent = getent(var_02.target,"targetname");
		if(isdefined(var_02.modelent) && isdefined(var_02.modelent.target))
		{
			var_03 = getent(var_02.modelent.target,"targetname");
			if(isdefined(var_03) && var_03.code_classname == "light")
			{
				var_02.light = var_03;
				var_02.light.lightonintensity = var_02.light getlightintensity();
				var_02.light.lightoffintensity = 0.1;
			}
		}

		var_02.active = 0;
		var_02.isdispensingweapon = 0;
		var_02.ismoving = 0;
		if(isdefined(var_02.script_flag))
		{
			common_scripts\utility::flag_init(var_02.script_flag);
		}
	}

	wait(2);
	foreach(var_02 in level.magicboxlocations)
	{
		if(isdefined(var_02.script_noteworthy) && var_02.script_noteworthy == "start_location")
		{
			var_00 = var_02;
			var_00.active = 1;
			var_02 activatemagicboxeffects(var_02.modelent,var_02.light);
			var_02 sethintstring(getmagicboxhintsting());
			var_02 setsecondaryhintstring(var_02 getmagicboxhintstringcost());
			var_02 maps\mp\zombies\_util::settokencost(maps\mp\zombies\_util::creditstotokens(var_02.cost));
			var_02 maps\mp\zombies\_util::tokenhintstring(1);
			continue;
		}

		var_02 sethintstring(getmagicboxhintsting(1));
		var_02 setsecondaryhintstring(var_02 getmagicboxhintstringcost(1));
		var_02 maps\mp\zombies\_util::tokenhintstring(0);
		var_02 deactivatemagicboxeffects(var_02.modelent,var_02.light);
	}

	common_scripts\utility::flag_set("magic_box_init");
	if(!isdefined(var_00))
	{
		return;
	}

	for(;;)
	{
		watchmagicboxtrigger(var_00,0);
		while(maps\mp\_utility::gameflag("fire_sale"))
		{
			while(maps\mp\_utility::gameflag("fire_sale") || var_00.isdispensingweapon)
			{
				wait(0.15);
			}

			var_00 notify("fireSaleOver");
		}

		common_scripts\utility::flag_set("magic_box_moved");
		var_07 = [];
		foreach(var_09 in level.magicboxlocations)
		{
			if(var_00 == var_09)
			{
				continue;
			}

			if(isscriptedmagicbox(var_09))
			{
				continue;
			}

			if(var_09.isdispensingweapon)
			{
				continue;
			}

			var_07[var_07.size] = var_09;
		}

		if(var_07.size > 0)
		{
			var_00 deactivatemagicboxeffects(var_00.modelent,var_00.light);
			var_00 sethintstring(getmagicboxhintsting(1));
			var_00 setsecondaryhintstring(var_00 getmagicboxhintstringcost(1));
			var_00 maps\mp\zombies\_util::tokenhintstring(0);
			var_00.active = 0;
			while(isdefined(var_00.deactivated))
			{
				wait 0.05;
			}

			var_00 = var_07[randomint(var_07.size)];
			var_00 activatemagicboxeffects(var_00.modelent,var_00.light);
			var_00 sethintstring(getmagicboxhintsting());
			var_00 setsecondaryhintstring(var_00 getmagicboxhintstringcost());
			var_00 maps\mp\zombies\_util::settokencost(maps\mp\zombies\_util::creditstotokens(var_00.cost));
			var_00 maps\mp\zombies\_util::tokenhintstring(1);
			var_00.active = 1;
		}
	}
}

//Function Number: 36
magicboxhasmoved()
{
	return common_scripts\utility::flag_exist("magic_box_moved") && common_scripts\utility::flag("magic_box_moved");
}

//Function Number: 37
activatemagicboxeffects(param_00,param_01)
{
	maps\mp\zombies\_util::killfxontagnetwork(common_scripts\utility::getfx("station_mystery_box_icon_off"),param_00,"tag_origin");
	maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("station_mystery_box_icon_on"),param_00,"tag_origin");
	thread audio_magicbox_attract_on(param_00);
	if(isdefined(param_01))
	{
		param_01 setlightintensity(param_01.lightonintensity);
	}

	if(isdefined(self.script_flag))
	{
		common_scripts\utility::flag_set(self.script_flag);
	}
}

//Function Number: 38
deactivatemagicboxeffects(param_00,param_01)
{
	maps\mp\zombies\_util::killfxontagnetwork(common_scripts\utility::getfx("station_mystery_box_icon_on"),param_00,"tag_origin");
	maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("station_mystery_box_icon_off"),param_00,"tag_origin");
	thread audio_magicbox_attract_off(param_00);
	if(isdefined(param_01))
	{
		param_01 setlightintensity(param_01.lightoffintensity);
	}

	if(isdefined(self.script_flag))
	{
		common_scripts\utility::flag_clear(self.script_flag);
	}
}

//Function Number: 39
audio_magicbox_attract_on(param_00)
{
	if(!isdefined(param_00.soundent))
	{
		var_01 = param_00 gettagorigin("tag_printer_laser");
		param_00.soundent = spawn("script_origin",var_01);
		param_00.soundent scalevolume(0);
		wait 0.05;
	}

	param_00.soundent scalevolume(1,0.25);
	param_00.soundent playloopsound("interact_mystery_box_attract");
}

//Function Number: 40
audio_magicbox_attract_off(param_00)
{
	if(!isdefined(param_00.soundent))
	{
		return;
	}

	param_00.soundent scalevolume(0,1);
	wait(1);
	param_00.soundent stoploopsound();
	wait 0.05;
	param_00.soundent delete();
}

//Function Number: 41
audio_magicbox_attract_in_use(param_00)
{
	param_00.soundent scalevolume(0,0.5);
	wait(0.5);
	param_00.soundent stoploopsound();
}

//Function Number: 42
audio_wpnbox_attract_on(param_00)
{
	param_00 scalevolume(1,0.25);
	param_00 playloopsound("interact_weapon_box_attract");
}

//Function Number: 43
audio_wpnbox_attract_in_use(param_00)
{
	param_00 scalevolume(0,0.5);
	wait(3.5);
	param_00 scalevolume(1,0.5);
}

//Function Number: 44
centerweaponformagicbox(param_00,param_01,param_02)
{
	var_03 = [0,0,39];
	var_04 = param_00.origin;
	var_05 = anglestoaxis(param_00.angles);
	var_04 = var_04 + var_05["forward"] * var_03[0];
	var_04 = var_04 + var_05["right"] * var_03[1];
	var_04 = var_04 + var_05["up"] * var_03[2];
	var_06 = param_01 getpointinmodelbounds(0,0,0);
	var_07 = var_04 - var_06;
	param_01 dontinterpolate();
	param_01.origin = param_01.origin + var_07;
}

//Function Number: 45
magicboxusewait()
{
	self endon("fireSaleOver");
	self endon("deactivated");
	return maps\mp\zombies\_util::waittilltriggerortokenuse();
}

//Function Number: 46
isscriptedmagicbox(param_00)
{
	return isdefined(param_00.script_noteworthy) && param_00.script_noteworthy == "scripted_magic_box";
}

//Function Number: 47
watchmagicboxtrigger(param_00,param_01)
{
	var_02 = 0;
	var_03 = randomintrange(4,7);
	var_04 = int(param_00.script_parameters);
	var_05 = param_00.modelent.origin;
	var_06 = param_00.modelent gettagangles("tag_printer_laser");
	var_07 = spawn("script_model",var_05);
	var_07.angles = var_06 + (0,90,0);
	var_07 setmodel("tag_origin");
	param_00.weaponmodel = var_07;
	param_00.lastweapon = "";
	maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("weapon_cycle_slow"),param_00.modelent,"tag_origin");
	for(;;)
	{
		if(param_01 && !maps\mp\_utility::gameflag("fire_sale"))
		{
			break;
		}

		var_08 = param_00 magicboxusewait();
		if(!isdefined(var_08))
		{
			break;
		}

		var_09 = var_08;
		var_0A = var_09[0];
		var_0B = var_09[1];
		var_0C = var_02 >= var_03 && !maps\mp\_utility::gameflag("fire_sale") && !isscriptedmagicbox(param_00);
		var_0D = getmagicboxcost(var_04);
		var_0E = var_0A getcurrentprimaryweapon();
		if(maps\mp\zombies\_util::isrippedturretweapon(var_0E) || maps\mp\zombies\_util::iszombiekillstreakweapon(var_0E) || maps\mp\zombies\_util::arewallbuysdisabled())
		{
			continue;
		}

		if(var_0C && !var_0A maps\mp\gametypes\zombies::canbuy(var_0D))
		{
			var_0A thread maps\mp\zombies\_zombies_audio::playerweaponbuy("printer_no_cash");
			continue;
		}

		if(!var_0C && !isdefined(self.deactivated))
		{
			if(var_0B == "token")
			{
				var_0A maps\mp\gametypes\zombies::spendtoken(param_00.tokencost);
			}
			else if(!var_0A maps\mp\gametypes\zombies::attempttobuy(var_0D))
			{
				var_0A thread maps\mp\zombies\_zombies_audio::playerweaponbuy("printer_no_cash");
				continue;
			}
		}

		if(!var_0C && !isdefined(self.deactivated))
		{
			if(var_02 == 0)
			{
				var_0A thread maps\mp\zombies\_zombies_audio::playerfoundprinter();
			}

			level notify("magicBoxUse",param_00);
			param_00 common_scripts\utility::trigger_off();
			param_00.isdispensingweapon = 1;
			var_0A thread maps\mp\zombies\_zombies_audio::moneyspend();
			maps\mp\zombies\_util::killfxontagnetwork(common_scripts\utility::getfx("weapon_cycle_slow"),param_00.modelent,"tag_origin");
			var_12 = selectmagicboxweapon(var_0A,param_00);
			level.ondeckweapons[level.ondeckweapons.size] = var_12["fullName"];
			var_07 setmodel(var_12["displayModel"]);
			level thread centerweaponformagicbox(param_00.modelent,var_07);
			var_07 show();
			if(level.nextgen)
			{
				var_07 cloakingenable();
			}

			wait(0.5);
			if(level.nextgen)
			{
				var_07 cloakingdisable();
			}

			param_00.modelent scriptmodelplayanim("dlc_weapon_mystery_box_01_open","magicBox");
			param_00.modelent.soundent playsound("interact_mystery_box");
			maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("station_mystery_box"),param_00.modelent,"tag_printer_laser",1);
			maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("magic_box_steam"),param_00.modelent,"tag_origin",1);
			param_00.lastweapon = var_12["baseName"];
			level.magicboxuses++;
			if(isdefined(var_0A))
			{
				var_0A.magicboxuses++;
				var_0A givemagicboxachievement();
			}

			thread audio_magicbox_attract_in_use(param_00.modelent);
			param_00.modelent waittillmatch("weapon_ready","magicBox");
			var_13 = var_12["displayString"];
			if(isdefined(param_00.magicboxpickupstrfunc))
			{
				var_13 = [[ param_00.magicboxpickupstrfunc ]]();
			}

			param_00 sethintstring(var_13);
			param_00 setsecondaryhintstring("");
			param_00 maps\mp\zombies\_util::tokenhintstring(0);
			if(isdefined(var_0A))
			{
				var_0A clientclaimtrigger(param_00);
			}

			param_00 common_scripts\utility::trigger_on();
			param_00 notify("pickupReady");
			var_14 = 8;
			var_15 = gettime() + var_14 * 1000;
			level thread flashweaponmodel(var_07);
			var_16 = "nothing";
			while(gettime() < var_15 && var_16 != "trigger")
			{
				var_17 = var_15 - gettime() / 1000;
				param_00 thread activemagicboxtimeout(var_17);
				var_18 = param_00 maps\mp\zombies\_util::waittill_any_return_parms_no_endon_death("timeout","trigger");
				param_00 notify("stopActiveMagicBoxTimeout");
				var_16 = var_18[0];
				if(var_16 == "timeout")
				{
					break;
				}

				var_19 = var_18[1];
				if(isdefined(param_00.magicboxcanpickupfunc))
				{
					if(![[ param_00.magicboxcanpickupfunc ]](var_19))
					{
						var_16 = "nothing";
					}

					continue;
				}

				var_0E = var_19 getcurrentprimaryweapon();
				if(maps\mp\zombies\_util::isrippedturretweapon(var_0E) || maps\mp\zombies\_util::iszombiekillstreakweapon(var_0E) || maps\mp\zombies\_util::arewallbuysdisabled())
				{
					var_16 = "nothing";
				}

				if(var_16 == "trigger")
				{
					var_0A = var_19;
				}
			}

			param_00.modelent.soundent playsound("interact_mystery_box_reset");
			param_00.modelent scriptmodelplayanim("dlc_weapon_mystery_box_01_close","magicBox");
			param_00 common_scripts\utility::trigger_off();
			param_00 sethintstring(getmagicboxhintsting());
			param_00 setsecondaryhintstring(param_00 getmagicboxhintstringcost());
			param_00 maps\mp\zombies\_util::settokencost(maps\mp\zombies\_util::creditstotokens(param_00.cost));
			param_00 maps\mp\zombies\_util::tokenhintstring(1);
			param_00 releaseclaimedtrigger();
			var_07 setmodel("tag_origin");
			var_07 notify("stop_flashing");
			if(isdefined(var_0A))
			{
				var_1A = getupgradeweaponname(var_0A,var_12["fullName"]);
				if(isdefined(param_00.magicboxgivefunc))
				{
					param_00 [[ param_00.magicboxgivefunc ]](var_16,var_0A);
				}
				else if(var_16 == "trigger" && maps\mp\_utility::isreallyalive(var_0A) && !maps\mp\zombies\_util::isplayerinlaststand(var_0A))
				{
					if(maps\mp\zombies\_util::iszombieequipment(var_1A))
					{
						givezombieequipment(var_0A,var_1A);
					}
					else
					{
						givezombieweapon(var_0A,var_1A);
					}
				}
			}

			level.ondeckweapons = arrayremovestring(level.ondeckweapons,var_12["fullName"]);
			param_00.modelent waittillmatch("end","magicBox");
			param_00 common_scripts\utility::trigger_on();
			param_00.isdispensingweapon = 0;
			param_00 notify("magicBoxUseEnd");
			thread audio_magicbox_attract_on(param_00.modelent);
			if(!maps\mp\_utility::gameflag("fire_sale"))
			{
				var_02++;
			}

			maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("weapon_cycle_slow"),param_00.modelent,"tag_origin");
			continue;
		}

		param_00 common_scripts\utility::trigger_off();
		param_00.ismoving = 1;
		maps\mp\zombies\_util::killfxontagnetwork(common_scripts\utility::getfx("weapon_cycle_slow"),param_00.modelent,"tag_origin");
		maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("weapon_cycle_fast"),param_00.modelent,"tag_origin");
		param_00.modelent.soundent playsound("interact_mystery_box_break");
		thread audio_magicbox_attract_in_use(param_00.modelent);
		wait(2);
		maps\mp\zombies\_util::killfxontagnetwork(common_scripts\utility::getfx("weapon_cycle_fast"),param_00.modelent,"tag_origin");
		maps\mp\zombies\_util::killfxontagnetwork(common_scripts\utility::getfx("station_mystery_box_icon_on"),param_00.modelent,"tag_origin");
		maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("magic_box_move"),param_00.modelent,"tag_origin");
		maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("magic_box_steam"),param_00.modelent,"tag_origin",1);
		param_00.modelent scriptmodelplayanim("dlc_weapon_mystery_box_01_malfunction","magicBox");
		maps\mp\zombies\_zombies_audio_announcer::announcerprintermoveddialog();
		wait(3);
		param_00.modelent.soundent playsound("interact_mystery_box_shutoff");
		wait(2);
		maps\mp\zombies\_util::killfxontagnetwork(common_scripts\utility::getfx("magic_box_move"),param_00.modelent,"tag_origin");
		param_00.ismoving = 0;
		param_00 common_scripts\utility::trigger_on();
		break;
	}

	maps\mp\zombies\_util::killfxontagnetwork(common_scripts\utility::getfx("weapon_cycle_slow"),param_00.modelent,"tag_origin");
	var_07 delete();
}

//Function Number: 48
activemagicboxtimeout(param_00)
{
	self endon("stopActiveMagicBoxTimeout");
	wait(param_00);
	self notify("timeout");
}

//Function Number: 49
flashweaponmodel(param_00)
{
	param_00 endon("stop_flashing");
	wait(5);
	for(;;)
	{
		param_00 ghost();
		wait(0.35);
		param_00 show();
		wait(0.35);
	}
}

//Function Number: 50
arrayremovestring(param_00,param_01)
{
	var_02 = [];
	foreach(var_04 in param_00)
	{
		if(var_04 != param_01)
		{
			var_02[var_02.size] = var_04;
		}
	}

	return var_02;
}

//Function Number: 51
selectmagicboxweapon(param_00,param_01)
{
	var_02 = [];
	var_03 = "";
	var_04 = param_00 getweaponslistall();
	var_05 = [];
	foreach(var_07 in var_04)
	{
		var_05[var_05.size] = getweaponbasename(var_07);
	}

	foreach(var_0E, var_0A in level.magicboxweapons)
	{
		var_0B = 1;
		foreach(var_07 in var_05)
		{
			if(var_0A["baseName"] == var_07)
			{
				var_0B = 0;
				break;
			}
		}

		if(param_01.lastweapon == var_0A["baseName"])
		{
			var_0B = 0;
		}

		if(islimitreached(var_0A))
		{
			var_0B = 0;
		}

		if(isdefined(var_0A["forceSelect"]))
		{
			if(var_0A["forceSelect"] <= level.magicboxuses)
			{
				level.magicboxweapons[var_0E]["forceSelect"] = undefined;
				var_02 = [var_0A];
				break;
			}
			else
			{
				var_0B = 0;
			}
		}

		if(var_0B)
		{
			var_02[var_02.size] = var_0A;
		}
	}

	var_03 = var_02[randomint(var_02.size)];
	return var_03;
}

//Function Number: 52
islimitreached(param_00)
{
	if(!isdefined(param_00["limit"]))
	{
		return 0;
	}

	var_01 = level.ondeckweapons;
	foreach(var_03 in level.players)
	{
		var_04 = var_03 getweaponslistall();
		var_01 = common_scripts\utility::array_combine(var_01,var_04);
	}

	var_06 = 0;
	var_07 = param_00["limit"];
	foreach(var_09 in var_01)
	{
		var_0A = getweaponbasename(var_09);
		if(var_0A == param_00["baseName"])
		{
			var_06++;
		}
	}

	return var_06 >= var_07;
}

//Function Number: 53
getmagicboxhintsting(param_00)
{
	var_01 = &"ZOMBIES_BUY_MYSTERY_BOX";
	if(maps\mp\_utility::gameflag("fire_sale"))
	{
		var_01 = &"ZOMBIES_FIRE_SALE_MAGIC_BOX";
	}

	if(isdefined(param_00) && param_00)
	{
		var_01 = &"ZOMBIES_PRINTER_OFFLINE";
		if(randomint(1000) == 500)
		{
			var_01 = &"ZOMBIES_PC_LOAD_LETTER";
		}
	}

	return var_01;
}

//Function Number: 54
getmagicboxhintstringcost(param_00)
{
	self.cost = 1000;
	var_01 = &"ZOMBIES_COST_1000";
	if(isdefined(level.penaltycostincrease))
	{
		var_02 = 1000;
		for(var_03 = 0;var_03 < level.penaltycostincrease;var_03++)
		{
			var_02 = maps\mp\zombies\_util::getincreasedcost(var_02);
		}

		self.cost = var_02;
		var_01 = maps\mp\zombies\_util::getcoststring(var_02);
	}

	if(maps\mp\_utility::gameflag("fire_sale"))
	{
		self.cost = 10;
		var_01 = &"ZOMBIES_COST_10";
	}

	if(isdefined(param_00) && param_00)
	{
		self.cost = 0;
		var_01 = &"ZOMBIES_EMPTY_STRING";
	}

	return var_01;
}

//Function Number: 55
getmagicboxcost(param_00)
{
	var_01 = param_00;
	if(isdefined(level.penaltycostincrease))
	{
		for(var_02 = 0;var_02 < level.penaltycostincrease;var_02++)
		{
			var_01 = maps\mp\zombies\_util::getincreasedcost(var_01);
		}
	}

	if(maps\mp\_utility::gameflag("fire_sale"))
	{
		var_01 = 10;
	}

	return var_01;
}

//Function Number: 56
givemagicboxachievement()
{
	if(self.magicboxuses >= 15)
	{
		maps\mp\gametypes\zombies::givezombieachievement("DLC1_ZOMBIE_PCLOADLETTER");
	}
}

//Function Number: 57
weaponlevelboxinit()
{
	initcamolevels();
	level.weaponlevelboxes = getentarray("weapon_level_box","targetname");
	common_scripts\utility::array_thread(level.weaponlevelboxes,::weaponlevelboxthink);
}

//Function Number: 58
weaponlevelboxsetupspecialbox()
{
	if(!isdefined(self.modelent) || !isdefined(self.modelent.target) || isdefined(self.modelent.light))
	{
		return;
	}

	var_00 = getent(self.modelent.target,"targetname");
	if(isdefined(var_00) && var_00.code_classname == "light")
	{
		self.modelent.light = var_00;
		self.modelent.light.lightonintensity = self.modelent.light getlightintensity();
		self.modelent.light.lightoffintensity = 0.1;
		self.modelent.light.ison = 1;
	}
}

//Function Number: 59
weaponlevelboxturnonlight()
{
	if(isdefined(self.modelent.light) && isdefined(self.modelent.light.lightoffintensity) && isdefined(self.modelent.light.ison) && !self.modelent.light.ison)
	{
		self.modelent.light setlightintensity(self.modelent.light.lightonintensity);
		self.modelent.light.ison = 1;
	}
}

//Function Number: 60
weaponlevelboxturnofflight()
{
	if(isdefined(self.modelent.light) && isdefined(self.modelent.light.lightoffintensity) && isdefined(self.modelent.light.ison) && self.modelent.light.ison)
	{
		self.modelent.light setlightintensity(self.modelent.light.lightoffintensity);
		self.modelent.light.ison = 0;
	}
}

//Function Number: 61
isspecialweaponbox(param_00)
{
	return isdefined(param_00.script_noteworthy) && param_00.script_noteworthy == "special";
}

//Function Number: 62
weaponlevelboxisplayerweaponmaxed(param_00,param_01)
{
	return (!isspecialweaponbox(self) && param_00.weaponstate[param_01]["level"] >= 20) || isspecialweaponbox(self) && param_00.weaponstate[param_01]["level"] >= 25;
}

//Function Number: 63
weaponlevelboxupdatehintstrings(param_00)
{
	param_00 endon("disconnect");
	var_01 = &"ZOMBIES_COST_2500";
	if(maps\mp\zombies\_util::iszombieshardmode())
	{
		var_01 = &"ZOMBIES_COST_1500";
	}

	for(;;)
	{
		var_02 = param_00 maps\mp\zombies\_util::waittill_any_return_parms_no_endon_death("weapon_change","no_upgrades");
		var_03 = undefined;
		if(var_02[0] == "no_upgrades" && self.allowupgrade)
		{
			continue;
		}

		switch(var_02[0])
		{
			case "weapon_change":
				var_03 = var_02[1];
				break;
	
			case "no_upgrades":
				self sethintstring("");
				self setsecondaryhintstring("");
				maps\mp\zombies\_util::tokenhintstring(0);
				param_00 waittill("allow_upgrades");
				var_03 = maps\mp\zombies\_util::getplayerweaponzombies(param_00);
				break;
		}

		var_04 = getweaponbasename(var_03);
		self setcursorhint("HINT_NOICON");
		if(!maps\mp\zombies\_util::haszombieweaponstate(param_00,var_04) || !weaponlevelboxisplayerweaponmaxed(param_00,var_04))
		{
			self sethintstring(&"ZOMBIES_WEAPON_LEVEL_BOX");
			self setsecondaryhintstring(var_01);
			maps\mp\zombies\_util::settokencost(maps\mp\zombies\_util::creditstotokens(2500));
			maps\mp\zombies\_util::tokenhintstring(1);
			continue;
		}

		self sethintstring(&"ZOMBIES_WEAPON_LEVEL_MAX");
		self setsecondaryhintstring("");
		maps\mp\zombies\_util::tokenhintstring(0);
	}
}

//Function Number: 64
deactivatemagicbox()
{
	self.deactivated = 1;
	self notify("deactivated");
}

//Function Number: 65
reactivatemagicbox()
{
	self.deactivated = undefined;
}

//Function Number: 66
cg__onplayerconnectedweaponlevelboxupdatehintstrings(param_00)
{
	param_00 endon("death");
	for(;;)
	{
		level waittill("connected",var_01);
		param_00 thread cg_weaponlevelboxupdatehintstrings(var_01);
	}
}

//Function Number: 67
cg_weaponlevelboxupdatehintstrings(param_00)
{
	param_00 endon("disconnect");
	maps\mp\zombies\_util::cg_setupstorestrings(param_00);
	thread cg_levelboxtriggermonitor(param_00);
	for(;;)
	{
		var_01 = param_00 maps\mp\zombies\_util::waittill_any_return_parms_no_endon_death("weapon_change","no_upgrades");
		var_02 = undefined;
		if(var_01[0] == "no_upgrades" && self.allowupgrade)
		{
			continue;
		}

		switch(var_01[0])
		{
			case "weapon_change":
				var_02 = var_01[1];
				break;
	
			case "no_upgrades":
				param_00 waittill("allow_upgrades");
				var_02 = maps\mp\zombies\_util::getplayerweaponzombies(param_00);
				break;
		}

		param_00.baseweapon = getweaponbasename(var_02);
	}
}

//Function Number: 68
cg_levelboxtriggermonitor(param_00)
{
	param_00 endon("disconnect");
	for(;;)
	{
		while(!param_00 istouching(self))
		{
			wait(0.1);
		}

		if(!maps\mp\zombies\_util::haszombieweaponstate(param_00,param_00.baseweapon) || !weaponlevelboxisplayerweaponmaxed(param_00,param_00.baseweapon))
		{
			param_00.storedescription settext(&"ZOMBIES_WEAPON_LEVEL_BOX");
			var_01 = &"ZOMBIES_COST_2500";
			if(maps\mp\zombies\_util::iszombieshardmode())
			{
				var_01 = &"ZOMBIES_COST_1500";
			}

			param_00.storecost settext(var_01);
		}
		else
		{
			param_00.storedescription settext(&"ZOMBIES_WEAPON_LEVEL_MAX");
			param_00.storecost settext("");
		}

		while(param_00 istouching(self))
		{
			wait(0.1);
		}

		param_00.storedescription settext("");
		param_00.storecost settext("");
	}
}

//Function Number: 69
weaponlevelboxthink()
{
	level endon("game_ended");
	self.modelent = getent(self.target,"targetname");
	self.allowupgrade = 1;
	if(isspecialweaponbox(self))
	{
		weaponlevelboxsetupspecialbox();
		weaponlevelboxturnofflight();
		common_scripts\utility::trigger_off();
		level waittill("special_weapon_box_unlocked");
		if(level.currentgen)
		{
			common_scripts\utility::trigger_on();
		}

		weaponlevelboxturnonlight();
	}

	var_00 = self.modelent gettagangles("tag_origin");
	self.modelent playloopsound("interact_weapon_upgrade_attract");
	if(maps\mp\zombies\_util::isusetriggerprimary(self))
	{
		maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("station_upgrade_weapon_pwr_on"),self.modelent,"tag_origin");
	}

	if(level.nextgen)
	{
		maps\mp\zombies\_util::setupusetriggerforclient(self,::weaponlevelboxupdatehintstrings);
	}
	else
	{
		foreach(var_02 in level.players)
		{
			thread cg_weaponlevelboxupdatehintstrings(var_02);
		}

		thread cg__onplayerconnectedweaponlevelboxupdatehintstrings(self);
	}

	var_04 = int(self.script_parameters);
	if(isdefined(level.penaltycostincrease))
	{
		for(var_05 = 0;var_05 < level.penaltycostincrease;var_05++)
		{
			var_06 = maps\mp\zombies\_util::getincreasedcost(var_04);
			var_04 = var_06;
		}
	}

	if(maps\mp\zombies\_util::iszombieshardmode())
	{
		var_04 = 1500;
	}

	for(;;)
	{
		var_07 = maps\mp\zombies\_util::waittilltriggerortokenuse();
		var_02 = var_07[0];
		var_08 = var_07[1];
		var_09 = var_02 getcurrentprimaryweapon();
		if(maps\mp\zombies\_util::isrippedturretweapon(var_09) || maps\mp\zombies\_util::iszombiekillstreakweapon(var_09) || maps\mp\zombies\_util::arewallbuysdisabled())
		{
			continue;
		}

		var_0A = maps\mp\zombies\_util::getplayerweaponzombies(var_02);
		var_0B = getweaponbasename(var_0A);
		if(!maps\mp\zombies\_util::haszombieweaponstate(var_02,var_0B))
		{
			continue;
		}

		if(weaponlevelboxisplayerweaponmaxed(var_02,var_0B))
		{
			diaplaymaxlevelmessage(var_02);
			continue;
		}

		if(isspecialweaponbox(self) && var_02.weaponstate[var_0B]["level"] != 20)
		{
			displayrequiredlevelmessage(var_02);
			continue;
		}

		if(var_08 == "token")
		{
			var_02 maps\mp\gametypes\zombies::spendtoken(self.tokencost);
		}
		else if(!var_02 maps\mp\gametypes\zombies::attempttobuy(var_04))
		{
			var_02 thread maps\mp\zombies\_zombies_audio::playerweaponbuy("wpn_no_cash");
			continue;
		}

		self.allowupgrade = 0;
		foreach(var_0D in level.players)
		{
			var_0D notify("no_upgrades");
		}

		var_0F = undefined;
		if(level.nextgen)
		{
			var_10 = findholomodel(var_0B);
			var_0F = spawn("script_model",self.origin);
			var_0F.angles = var_00 - (0,90,0);
			var_0F setmodel(var_10);
			var_11 = [15,0,-6];
			if(var_0B == "iw5_exocrossbowzm_mp")
			{
				var_11 = [13,0,-13];
				var_0F.angles = var_0F.angles + (0,0,-90);
			}

			level thread centerweaponforwallbuy(self.modelent,var_0F,var_11);
		}

		maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("station_upgrade_weapon"),self.modelent,"tag_origin",1);
		self.modelent playsound("interact_weapon_upgrade");
		if(isspecialweaponbox(self))
		{
			setweaponlevel(var_02,var_0A,25);
		}
		else
		{
			setweaponlevel(var_02,var_0A,var_02.weaponstate[var_0B]["level"] + 1);
		}

		var_02 thread maps\mp\zombies\_zombies_audio::playerweaponupgrade(isspecialweaponbox(self),var_02.weaponstate[var_0B]["level"]);
		var_02.numupgrades++;
		wait(1.2);
		if(isdefined(var_02))
		{
			if(var_02.weaponstate[var_0B]["level"] > 19)
			{
				maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("weapon_level_20"),self.modelent,"tag_origin",1);
				self.modelent playsound("interact_weapon_upgrade_fwks");
			}
		}

		wait(0.75);
		if(isdefined(var_0F))
		{
			var_0F delete();
		}

		self.allowupgrade = 1;
		foreach(var_0D in level.players)
		{
			var_0D notify("allow_upgrades");
		}
	}
}

//Function Number: 70
setweaponlevel(param_00,param_01,param_02)
{
	param_00 takeweapon(param_01);
	var_03 = getweaponbasename(param_01);
	param_00.weaponstate[var_03]["level"] = param_02;
	var_04 = getupgradeweaponname(param_00,var_03);
	givezombieweapon(param_00,var_04,0);
	if(issubstr(var_04,"iw5_em1zm_mp"))
	{
		param_00 maps\mp\gametypes\zombies::playersetem1maxammo();
	}

	if(isdefined(level.setweaponlevelfunc))
	{
		param_00 [[ level.setweaponlevelfunc ]](param_01,param_02);
	}

	param_00 playsoundtoplayer("mp_s1_earn_medal",param_00);
}

//Function Number: 71
giveweaponlevelachievement(param_00)
{
	var_01 = param_00 getweaponslistprimaries();
	if(var_01.size < 2)
	{
		return;
	}

	foreach(var_03 in var_01)
	{
		var_04 = getweaponbasename(var_03);
		if(param_00.weaponstate[var_04]["level"] < 20)
		{
			return;
		}
	}

	param_00 maps\mp\gametypes\zombies::givezombieachievement("DLC1_ZOMBIE_2020");
}

//Function Number: 72
findholomodel(param_00)
{
	foreach(var_02 in level.magicboxweapons)
	{
		if(var_02["baseName"] == param_00)
		{
			return var_02["displayModel"];
		}
	}

	foreach(var_02 in level.wallbuyweapons)
	{
		if(var_02["baseName"] == param_00)
		{
			return var_02["displayModel"];
		}
	}

	return "npc_titan45_base_static_holo";
}

//Function Number: 73
getupgradeweaponname(param_00,param_01)
{
	var_02 = param_01;
	var_03 = getweaponbasename(param_01);
	if(maps\mp\zombies\_util::haszombieweaponstate(param_00,var_03) && param_00.weaponstate[var_03]["level"] > 0)
	{
		var_04 = param_00.weaponstate[var_03]["level"];
		if(var_04 > 25)
		{
			var_04 = 25;
		}

		var_05 = getcamoforweaponlevel(var_03,var_04);
		var_06 = getattachment1forweaponlevel(var_03,var_04);
		var_07 = getattachment2forweaponlevel(var_03,var_04);
		var_08 = getattachment3forweaponlevel(var_03,var_04);
		var_09 = maps\mp\_utility::strip_suffix(var_03,"_mp");
		var_02 = maps\mp\gametypes\_class::buildweaponname(var_09,var_06,var_07,var_08,var_05,0);
	}

	return var_02;
}

//Function Number: 74
getcamoforweaponlevel(param_00,param_01)
{
	param_01 = int(min(param_01,level.camolevel.size - 1));
	return level.camolevel[param_01];
}

//Function Number: 75
getattachment1forweaponlevel(param_00,param_01)
{
	var_02 = getmagicboxweapondefaultattachment(param_00,"attachment1");
	if(param_01 > 3)
	{
		switch(param_00)
		{
			case "iw5_m182sprzm_mp":
			case "iw5_hbra3zm_mp":
			case "iw5_dlcgun1zm_mp":
			case "iw5_ak12zm_mp":
				var_02 = "opticseotech";
				break;

			case "iw5_arx160zm_mp":
			case "iw5_sn6zm_mp":
			case "iw5_bal27zm_mp":
			case "iw5_exocrossbowzm_mp":
			case "iw5_em1zm_mp":
				var_02 = "variablereddot";
				break;

			case "iw5_uts19zm_mp":
			case "iw5_maulzm_mp":
			case "iw5_mp11zm_mp":
			case "iw5_asm1zm_mp":
			case "iw5_vbrzm_mp":
			case "iw5_microwavezm_mp":
				var_02 = "opticsreddot";
				break;

			case "iw5_asawzm_mp":
				var_02 = "opticsthermalar";
				break;

			case "iw5_hmr9zm_mp":
				var_02 = "opticsthermal";
				break;

			case "iw5_himarzm_mp":
			case "iw5_lsatzm_mp":
			case "iw5_rhinozm_mp":
			case "iw5_rw1zm_mp":
			case "iw5_dlcgun2zm_mp":
			case "iw5_linegunzm_mp":
			case "iw5_fusionzm_mp":
			case "iw5_tridentzm_mp":
			case "iw5_titan45zm_mp":
				var_02 = "opticstargetenhancer";
				break;

			case "iw5_sac3zm_mp":
			case "iw5_dlcgun3zm_mp":
				var_02 = "lasersight";
				break;

			case "iw5_dlcgun4zm_mp":
			case "iw5_mahemzm_mp":
				var_02 = "quickdraw";
				break;

			case "iw5_gm6zm_mp":
				var_02 = "opticsacog2";
				break;
		}
	}

	return var_02;
}

//Function Number: 76
getattachment2forweaponlevel(param_00,param_01)
{
	var_02 = getmagicboxweapondefaultattachment(param_00,"attachment2");
	if(param_01 > 6)
	{
		switch(param_00)
		{
			case "iw5_uts19zm_mp":
			case "iw5_maulzm_mp":
			case "iw5_hmr9zm_mp":
			case "iw5_hbra3zm_mp":
			case "iw5_mp11zm_mp":
			case "iw5_arx160zm_mp":
			case "iw5_asm1zm_mp":
			case "iw5_himarzm_mp":
			case "iw5_bal27zm_mp":
			case "iw5_ak12zm_mp":
			case "iw5_asawzm_mp":
			case "iw5_rhinozm_mp":
				var_02 = "lasersight";
				break;

			case "iw5_m182sprzm_mp":
			case "iw5_dlcgun1zm_mp":
			case "iw5_lsatzm_mp":
			case "iw5_dlcgun4zm_mp":
			case "iw5_dlcgun2zm_mp":
			case "iw5_fusionzm_mp":
				var_02 = "stock";
				break;

			case "iw5_vbrzm_mp":
			case "iw5_rw1zm_mp":
			case "iw5_dlcgun3zm_mp":
			case "iw5_linegunzm_mp":
			case "iw5_tridentzm_mp":
			case "iw5_gm6zm_mp":
			case "iw5_em1zm_mp":
			case "iw5_titan45zm_mp":
				var_02 = "quickdraw";
				break;

			case "iw5_sac3zm_mp":
			case "iw5_sn6zm_mp":
				var_02 = "firerate";
				break;

			case "iw5_mahemzm_mp":
			case "iw5_exocrossbowzm_mp":
				var_02 = "xmags";
				break;
		}
	}

	return var_02;
}

//Function Number: 77
getattachment3forweaponlevel(param_00,param_01)
{
	var_02 = getmagicboxweapondefaultattachment(param_00,"attachment3");
	if(param_01 > 9)
	{
		switch(param_00)
		{
			case "iw5_arx160zm_mp":
			case "iw5_himarzm_mp":
			case "iw5_bal27zm_mp":
			case "iw5_ak12zm_mp":
			case "iw5_mahemzm_mp":
			case "iw5_em1zm_mp":
				var_02 = "stock";
				break;

			case "iw5_hbra3zm_mp":
			case "iw5_mp11zm_mp":
			case "iw5_asm1zm_mp":
			case "iw5_asawzm_mp":
			case "iw5_lsatzm_mp":
			case "iw5_dlcgun2zm_mp":
			case "iw5_exocrossbowzm_mp":
				var_02 = "quickdraw";
				break;

			case "iw5_uts19zm_mp":
			case "iw5_m182sprzm_mp":
			case "iw5_maulzm_mp":
			case "iw5_hmr9zm_mp":
			case "iw5_dlcgun1zm_mp":
			case "iw5_sac3zm_mp":
			case "iw5_sn6zm_mp":
			case "iw5_rhinozm_mp":
			case "iw5_vbrzm_mp":
			case "iw5_rw1zm_mp":
			case "iw5_dlcgun4zm_mp":
			case "iw5_dlcgun3zm_mp":
			case "iw5_fusionzm_mp":
			case "iw5_tridentzm_mp":
			case "iw5_gm6zm_mp":
			case "iw5_titan45zm_mp":
				var_02 = "xmags";
				break;

			case "iw5_linegunzm_mp":
				var_02 = "xmagslinegun";
				break;
		}
	}

	return var_02;
}

//Function Number: 78
getmagicboxweapondefaultattachment(param_00,param_01)
{
	var_02 = "none";
	foreach(var_04 in level.magicboxweapons)
	{
		if(var_04["baseName"] == param_00)
		{
			var_02 = var_04[param_01];
			break;
		}
	}

	return var_02;
}

//Function Number: 79
displayrequiredlevelmessage(param_00)
{
	param_00 playsoundtoplayer("ui_button_error",param_00);
	param_00 iprintlnbold(&"ZOMBIES_REQUIRES_LEVEL_20");
}

//Function Number: 80
diaplaymaxlevelmessage(param_00)
{
	param_00 playsoundtoplayer("ui_button_error",param_00);
	if(!isspecialweaponbox(self))
	{
		param_00 iprintlnbold(&"ZOMBIES_MAX_LEVEL_20");
		return;
	}

	param_00 iprintlnbold(&"ZOMBIES_MAX_LEVEL_25");
}

//Function Number: 81
initcamolevels()
{
	var_00 = "mp/zmWeaponLevels.csv";
	level.camolevel = [];
	for(var_01 = 0;var_01 <= 25;var_01++)
	{
		var_02 = int(tablelookup(var_00,0,var_01,1));
		level.camolevel[var_01] = var_02;
	}
}

//Function Number: 82
wallbuydisable(param_00)
{
	if(level.nextgen)
	{
		param_00.weaponent hide();
		maps\mp\zombies\_util::killfxontagnetwork(common_scripts\utility::getfx("station_buy_weapon_pwr_on"),param_00.modelent,"tag_origin");
	}

	param_00 common_scripts\utility::trigger_off();
}

//Function Number: 83
wallbuyenable(param_00)
{
	if(level.nextgen)
	{
		param_00.weaponent show();
		maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("station_buy_weapon_pwr_on"),param_00.modelent,"tag_origin");
	}

	param_00 common_scripts\utility::trigger_on();
	thread wallbuyrestoretriggerhintstring(param_00);
}

//Function Number: 84
wallbuyrestoretriggerhintstring(param_00)
{
	if(level.nextgen)
	{
		maps\mp\zombies\_util::setupusetriggerforclient(param_00,::wallbuyupdatehinstrings);
		return;
	}

	foreach(var_02 in level.players)
	{
		param_00 thread cg_wallbuyupdatehintstrings(var_02);
	}

	thread cg_onplayerconnectedwallbuyupdatehinstrings(param_00);
}

//Function Number: 85
weaponlevelrestoretriggerhintstring(param_00)
{
	if(level.nextgen)
	{
		maps\mp\zombies\_util::setupusetriggerforclient(param_00,::weaponlevelboxupdatehintstrings);
		return;
	}

	foreach(var_02 in level.players)
	{
		param_00 thread cg_weaponlevelboxupdatehintstrings(var_02);
	}

	thread cg__onplayerconnectedweaponlevelboxupdatehintstrings(param_00);
}

//Function Number: 86
weaponlevelboxdisable(param_00)
{
	maps\mp\zombies\_util::killfxontagnetwork(common_scripts\utility::getfx("station_upgrade_weapon_pwr_on"),param_00.modelent,"tag_origin");
	param_00 weaponlevelboxturnofflight();
	param_00 common_scripts\utility::trigger_off();
}

//Function Number: 87
weaponlevelboxenable(param_00)
{
	maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("station_upgrade_weapon_pwr_on"),param_00.modelent,"tag_origin");
	param_00 weaponlevelboxturnonlight();
	param_00 common_scripts\utility::trigger_on();
	thread weaponlevelrestoretriggerhintstring(param_00);
}