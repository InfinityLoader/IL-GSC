/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_weapons.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: PC
*******************************************************************/

attachmentgroup(attachmentname)
{
	return tablelookup("mp/attachmentTable.csv", 4, attachmentname, 2);
}

getattachmentlist()
{
	attachmentlist = [];
	index = 0;
	attachmentname = tablelookup("mp/attachmentTable.csv", 9, index, 4);
	while(attachmentname != "")
	{
		attachmentlist[attachmentlist.size] = attachmentname;
		index++;
		attachmentname = tablelookup("mp/attachmentTable.csv", 9, index, 4);
	}

	return common_scripts\utility::alphabetize(attachmentlist);
}

init()
{
	level.scavenger_altmode = 1;
	level.scavenger_secondary = 1;
	level.maxperplayerexplosives = max(maps\mp\_utility::getintproperty("scr_maxPerPlayerExplosives", 2), 1);
	level.riotshieldxpbullets = maps\mp\_utility::getintproperty("scr_riotShieldXPBullets", 15);
	switch(maps\mp\_utility::getintproperty("perk_scavengerMode", 0))
	{
		case 1:
			level.scavenger_altmode = 0;
			break;

		case 2:
			level.scavenger_secondary = 0;
			break;

		case 3:
			level.scavenger_altmode = 0;
			level.scavenger_secondary = 0;
			break;
	}

	attachmentlist = getattachmentlist();
	max_weapon_num = 149;
	level.weaponlist = [];
	for(weaponid = 0;weaponid <= max_weapon_num;weaponid++)
	{
		weapon_name = tablelookup("mp/statstable.csv", 0, weaponid, 4);
		if(weapon_name == "")
		{
			continue;
		}

		if(!issubstr(tablelookup("mp/statsTable.csv", 0, weaponid, 2), "weapon_"))
		{
			continue;
		}

		level.weaponlist[level.weaponlist.size] = weapon_name + "_mp";
		attachmentnames = [];
		for(innerloopcount = 0;innerloopcount < 10;innerloopcount++)
		{
			attachmentname = tablelookup("mp/statStable.csv", 0, weaponid, innerloopcount + 11);
			if(attachmentname == "")
			{
				break;
			}

			attachmentnames[attachmentname] = 1;
		}

		attachments = [];
		foreach(attachmentname in attachmentlist)
		{
			if(!isdefined(attachmentnames[attachmentname]))
			{
				continue;
			}

			level.weaponlist[level.weaponlist.size] = weapon_name + "_" + attachmentname + "_mp";
			attachments[attachments.size] = attachmentname;
		}

		attachmentcombos = [];
		for(i = 0;i < attachments.size - 1;i++)
		{
			colindex = tablelookuprownum("mp/attachmentCombos.csv", 0, attachments[i]);
			for(j = i + 1;j < attachments.size;j++)
			{
				if(tablelookup("mp/attachmentCombos.csv", 0, attachments[j], colindex) == "no")
				{
					continue;
				}

				attachmentcombos[attachmentcombos.size] = attachments[i] + "_" + attachments[j];
			}
		}

		foreach(combo in attachmentcombos)
		{
			level.weaponlist[level.weaponlist.size] = weapon_name + "_" + combo + "_mp";
		}
	}

	foreach(weaponname in level.weaponlist)
	{
		precacheitem(weaponname);
	}

	precacheitem("flare_mp");
	precacheitem("scavenger_bag_mp");
	precacheitem("frag_grenade_short_mp");
	precacheitem("destructible_car");
	precacheshellshock("default");
	precacheshellshock("concussion_grenade_mp");
	thread maps\mp\_flashgrenades::main();
	thread maps\mp\_entityheadicons::init();
	claymoredetectionconeangle = 70;
	level.claymoredetectiondot = cos(claymoredetectionconeangle);
	level.claymoredetectionmindist = 20;
	level.claymoredetectiongraceperiod = 0.75;
	level.claymoredetonateradius = 192;
	level.stingerfxid = loadfx("explosions/aerial_explosion_large");
	level.primary_weapon_array = [];
	level.side_arm_array = [];
	level.grenade_array = [];
	level.inventory_array = [];
	level.stow_priority_model_array = [];
	level.stow_offset_array = [];
	max_weapon_num = 149;
	for(i = 0;i < max_weapon_num;i++)
	{
		weapon = tablelookup("mp/statsTable.csv", 0, i, 4);
		stow_model = tablelookup("mp/statsTable.csv", 0, i, 9);
		if(stow_model == "")
		{
			continue;
		}

		precachemodel(stow_model);
		if(issubstr(stow_model, "weapon_stow_"))
		{
			level.stow_offset_array[weapon] = stow_model;
			continue;
		}

		level.stow_priority_model_array[weapon + "_mp"] = stow_model;
	}

	precachemodel("weapon_claymore_bombsquad");
	precachemodel("weapon_c4_bombsquad");
	precachemodel("projectile_m67fraggrenade_bombsquad");
	precachemodel("projectile_semtex_grenade_bombsquad");
	precachemodel("weapon_light_stick_tactical_bombsquad");
	level.killstreakspecialcaseweapons = [];
	level.killstreakspecialcaseweapons["cobra_player_minigun_mp"] = 1;
	level.killstreakspecialcaseweapons["artillery_mp"] = 1;
	level.killstreakspecialcaseweapons["stealth_bomb_mp"] = 1;
	level.killstreakspecialcaseweapons["pavelow_minigun_mp"] = 1;
	level.killstreakspecialcaseweapons["sentry_minigun_mp"] = 1;
	level.killstreakspecialcaseweapons["harrier_20mm_mp"] = 1;
	level.killstreakspecialcaseweapons["ac130_105mm_mp"] = 1;
	level.killstreakspecialcaseweapons["ac130_40mm_mp"] = 1;
	level.killstreakspecialcaseweapons["ac130_25mm_mp"] = 1;
	level.killstreakspecialcaseweapons["remotemissile_projectile_mp"] = 1;
	level.killstreakspecialcaseweapons["cobra_20mm_mp"] = 1;
	level.killstreakspecialcaseweapons["sentry_minigun_mp"] = 1;
	level thread onplayerconnect();
	level.c4explodethisframe = 0;
	common_scripts\utility::array_thread(getentarray("misc_turret", "classname"), ::turret_monitoruse);
}

dumpit()
{
	wait 5;
}

bombsquadwaiter()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("grenade_fire", weaponent, weaponname);
		team = level.otherteam[self.team];
		if(weaponname == "c4_mp")
		{
			weaponent thread createbombsquadmodel("weapon_c4_bombsquad", "tag_origin", team, self);
			continue;
		}

		if(weaponname == "claymore_mp")
		{
			weaponent thread createbombsquadmodel("weapon_claymore_bombsquad", "tag_origin", team, self);
			continue;
		}

		if(weaponname == "frag_grenade_mp")
		{
			weaponent thread createbombsquadmodel("projectile_m67fraggrenade_bombsquad", "tag_weapon", team, self);
			continue;
		}

		if(weaponname == "frag_grenade_short_mp")
		{
			weaponent thread createbombsquadmodel("projectile_m67fraggrenade_bombsquad", "tag_weapon", team, self);
			continue;
		}

		if(weaponname == "semtex_mp")
		{
			weaponent thread createbombsquadmodel("projectile_semtex_grenade_bombsquad", "tag_weapon", team, self);
		}
	}
}

createbombsquadmodel(modelname, tagname, teamname, owner)
{
	bombsquadmodel = spawn("script_model", (0,0,0));
	bombsquadmodel hide();
	wait 0.05;
	if(!isdefined(self))
	{
		return;
	}

	bombsquadmodel thread bombsquadvisibilityupdater(teamname, owner);
	bombsquadmodel setmodel(modelname);
	bombsquadmodel linkto(self, tagname, (0,0,0), (0,0,0));
	bombsquadmodel setcontents(0);
	self waittill("death");
	bombsquadmodel delete();
}

bombsquadvisibilityupdater(teamname, owner)
{
	self endon("death");
	foreach(player in level.players)
	{
		if(level.teambased)
		{
			if(player.team == teamname && player maps\mp\_utility::_hasperk("specialty_detectexplosive"))
			{
				self showtoplayer(player);
			}

			continue;
		}

		if(isdefined(owner) && player == owner)
		{
			continue;
		}

		if(!player maps\mp\_utility::_hasperk("specialty_detectexplosive"))
		{
			continue;
		}

		self showtoplayer(player);
	}

	for(;;)
	{
		level common_scripts\utility::waittill_any("joined_team", "player_spawned", "changed_kit");
		self hide();
		foreach(player in level.players)
		{
			if(level.teambased)
			{
				if(player.team == teamname && player maps\mp\_utility::_hasperk("specialty_detectexplosive"))
				{
					self showtoplayer(player);
				}

				continue;
			}

			if(isdefined(owner) && player == owner)
			{
				continue;
			}

			if(!player maps\mp\_utility::_hasperk("specialty_detectexplosive"))
			{
				continue;
			}

			self showtoplayer(player);
		}
	}
}

onplayerconnect()
{
	for(;;)
	{
		level waittill("connected", player);
		player.hits = 0;
		player.hasdonecombat = 0;
		player kc_regweaponforfxremoval("remotemissile_projectile_mp");
		player thread onplayerspawned();
		player thread bombsquadwaiter();
	}
}

onplayerspawned()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("spawned_player");
		self.currentweaponatspawn = self getcurrentweapon();
		self.empendtime = 0;
		self.concussionendtime = 0;
		self.hasdonecombat = 0;
		thread watchweaponusage();
		thread watchgrenadeusage();
		thread watchweaponchange();
		thread watchstingerusage();
		thread watchjavelinusage();
		thread watchmissileusage();
		thread watchsentryusage();
		thread watchweaponreload();
		thread maps\mp\gametypes\_class::trackriotshield();
		self.lasthittime = [];
		self.droppeddeathweapon = undefined;
		self.tookweaponfrom = [];
		thread updatestowedweapon();
		thread updatesavedlastweapon();
		if(self hasweapon("semtex_mp"))
		{
			thread monitorsemtex();
		}

		self.currentweaponatspawn = undefined;
	}
}

watchstingerusage()
{
	maps\mp\_stinger::stingerusageloop();
}

watchjavelinusage()
{
	maps\mp\_javelin::javelinusageloop();
}

watchweaponchange()
{
	self endon("death");
	self endon("disconnect");
	thread watchstartweaponchange();
	self.lastdroppableweapon = self.currentweaponatspawn;
	self.hitsthismag = [];
	weapon = self getcurrentweapon();
	if(maps\mp\_utility::iscacprimaryweapon(weapon) && !isdefined(self.hitsthismag[weapon]))
	{
		self.hitsthismag[weapon] = weaponclipsize(weapon);
	}

	self.bothbarrels = undefined;
	if(issubstr(weapon, "ranger"))
	{
		thread watchrangerusage(weapon);
	}

	for(;;)
	{
		self waittill("weapon_change", newweapon);
		tokednewweapon = strtok(newweapon, "_");
		self.bothbarrels = undefined;
		if(issubstr(newweapon, "ranger"))
		{
			thread watchrangerusage(newweapon);
		}

		if(tokednewweapon[0] == "gl" || tokednewweapon.size > 2 && tokednewweapon[2] == "attach")
		{
			newweapon = self getcurrentprimaryweapon();
		}

		if(newweapon != "none")
		{
			if(maps\mp\_utility::iscacprimaryweapon(newweapon) && !isdefined(self.hitsthismag[newweapon]))
			{
				self.hitsthismag[newweapon] = weaponclipsize(newweapon);
			}
		}

		self.changingweapon = undefined;
		if(maydropweapon(newweapon))
		{
			self.lastdroppableweapon = newweapon;
		}
	}
}

watchstartweaponchange()
{
	self endon("death");
	self endon("disconnect");
	self.changingweapon = undefined;
	for(;;)
	{
		self waittill("weapon_switch_started", newweapon);
		self.changingweapon = newweapon;
	}
}

watchweaponreload()
{
	self endon("death");
	self endon("disconnect");
	for(;;)
	{
		self waittill("reload");
		weaponname = self getcurrentweapon();
		self.bothbarrels = undefined;
		if(!issubstr(weaponname, "ranger"))
		{
			continue;
		}

		thread watchrangerusage(weaponname);
	}
}

watchrangerusage(rangername)
{
	rightammo = self getweaponammoclip(rangername, "right");
	leftammo = self getweaponammoclip(rangername, "left");
	self endon("reload");
	self endon("weapon_change");
	for(;;)
	{
		self waittill("weapon_fired", weaponname);
		if(weaponname != rangername)
		{
			continue;
		}

		self.bothbarrels = undefined;
		if(issubstr(rangername, "akimbo"))
		{
			newleftammo = self getweaponammoclip(rangername, "left");
			newrightammo = self getweaponammoclip(rangername, "right");
			if(leftammo != newleftammo && rightammo != newrightammo)
			{
				self.bothbarrels = 1;
			}

			if(!newleftammo || !newrightammo)
			{
				return;
			}

			leftammo = newleftammo;
			rightammo = newrightammo;
			continue;
		}

		if(rightammo == 2 && !self getweaponammoclip(rangername, "right"))
		{
			self.bothbarrels = 1;
			return;
		}
	}
}

ishackweapon(weapon)
{
	if(weapon == "radar_mp" || weapon == "airstrike_mp" || weapon == "helicopter_mp")
	{
		return 1;
	}

	if(weapon == "briefcase_bomb_mp")
	{
		return 1;
	}

	return 0;
}

maydropweapon(weapon)
{
	if(weapon == "none")
	{
		return 0;
	}

	if(issubstr(weapon, "ac130"))
	{
		return 0;
	}

	invtype = weaponinventorytype(weapon);
	if(invtype != "primary")
	{
		return 0;
	}

	return 1;
}

dropweaponfordeath(attacker)
{
	weapon = self.lastdroppableweapon;
	if(isdefined(self.droppeddeathweapon))
	{
		return;
	}

	if(level.ingraceperiod)
	{
		return;
	}

	if(!isdefined(weapon))
	{
		return;
	}

	if(weapon == "none")
	{
		return;
	}

	if(!self hasweapon(weapon))
	{
		return;
	}

	if(weapon != "riotshield_mp")
	{
		if(!self anyammoforweaponmodes(weapon))
		{
			return;
		}

		clipammor = self getweaponammoclip(weapon, "right");
		clipammol = self getweaponammoclip(weapon, "left");
		if(!clipammor && !clipammol)
		{
			return;
		}

		stockammo = self getweaponammostock(weapon);
		stockmax = weaponmaxammo(weapon);
		if(stockammo > stockmax)
		{
			stockammo = stockmax;
		}

		item = self dropitem(weapon);
		item itemweaponsetammo(clipammor, stockammo, clipammol);
	}
	else
	{
		item = self dropitem(weapon);
		if(!isdefined(item))
		{
			return;
		}

		item itemweaponsetammo(1, 1, 0);
	}

	self.droppeddeathweapon = 1;
	item.owner = self;
	item.ownersattacker = attacker;
	item thread watchpickup();
	item thread deletepickupafterawhile();
	detach_model = getweaponmodel(weapon);
	if(!isdefined(detach_model))
	{
		return;
	}

	if(isdefined(self.tag_stowed_back) && detach_model == self.tag_stowed_back)
	{
		detach_back_weapon();
	}

	if(!isdefined(self.tag_stowed_hip))
	{
		return;
	}

	if(detach_model == self.tag_stowed_hip)
	{
		detach_hip_weapon();
		return;
	}
}

detachifattached(model, basetag)
{
	attachsize = self getattachsize();
	i = 0;
	while(i < attachsize)
	{
		attach = self getattachmodelname(i);
		if(attach != model)
		{
			continue;
		}

		tag = self getattachtagname(i);
		self detach(model, tag);
		if(tag != basetag)
		{
			attachsize = self getattachsize();
			for(i = 0;i < attachsize;i++)
			{
				tag = self getattachtagname(i);
				if(tag != basetag)
				{
					continue;
				}

				model = self getattachmodelname(i);
				self detach(model, tag);
				break;
			}
		}

		return 1;
		attach++;
	}

	return 0;
}

deletepickupafterawhile()
{
	self endon("death");
	wait 60;
	if(!isdefined(self))
	{
		return;
	}

	self delete();
}

getitemweaponname()
{
	classname = self.classname;
	weapname = getsubstr(classname, 7);
	return weapname;
}

watchpickup()
{
	self endon("death");
	weapname = getitemweaponname();
	for(;;)
	{
		self waittill("trigger", player, droppeditem);
		if(isdefined(droppeditem))
		{
			break;
		}
	}

	droppedweaponname = droppeditem getitemweaponname();
	if(isdefined(player.tookweaponfrom[droppedweaponname]))
	{
		droppeditem.owner = player.tookweaponfrom[droppedweaponname];
		droppeditem.ownersattacker = player;
		player.tookweaponfrom[droppedweaponname] = undefined;
	}

	droppeditem thread watchpickup();
	if(isdefined(self.ownersattacker) && self.ownersattacker == player)
	{
		player.tookweaponfrom[weapname] = self.owner;
		return;
	}

	player.tookweaponfrom[weapname] = undefined;
}

itemremoveammofromaltmodes()
{
	origweapname = getitemweaponname();
	curweapname = weaponaltweaponname(origweapname);
	for(altindex = 1;curweapname != "none" && curweapname != origweapname;altindex++)
	{
		self itemweaponsetammo(0, 0, 0, altindex);
		curweapname = weaponaltweaponname(curweapname);
	}
}

handlescavengerbagpickup(scrplayer)
{
	self endon("death");
	level endon("game_ended");
	self waittill("scavenger", destplayer);
	destplayer notify("scavenger_pickup");
	destplayer playlocalsound("scavenger_pack_pickup");
	offhandweapons = destplayer getweaponslistoffhands();
	if(destplayer maps\mp\_utility::_hasperk("specialty_tacticalinsertion") && destplayer getammocount("flare_mp") < 1)
	{
		destplayer maps\mp\_utility::_setperk("specialty_tacticalinsertion");
	}

	foreach(offhand in offhandweapons)
	{
		currentclipammo = destplayer getweaponammoclip(offhand);
		destplayer setweaponammoclip(offhand, currentclipammo + 1);
	}

	primaryweapons = destplayer getweaponslistprimaries();
	foreach(primary in primaryweapons)
	{
		if(!maps\mp\_utility::iscacprimaryweapon(primary) && !level.scavenger_secondary)
		{
			continue;
		}

		currentstockammo = destplayer getweaponammostock(primary);
		addstockammo = weaponclipsize(primary);
		destplayer setweaponammostock(primary, currentstockammo + addstockammo);
		altweapon = weaponaltweaponname(primary);
		if(!isdefined(altweapon) || altweapon == "none" || !level.scavenger_altmode)
		{
			continue;
		}

		currentstockammo = destplayer getweaponammostock(altweapon);
		addstockammo = weaponclipsize(altweapon);
		destplayer setweaponammostock(altweapon, currentstockammo + addstockammo);
	}

	destplayer maps\mp\gametypes\_damagefeedback::updatedamagefeedback("scavenger");
}

dropscavengerfordeath(attacker)
{
	if(level.ingraceperiod)
	{
		return;
	}

	if(!isdefined(attacker))
	{
		return;
	}

	if(attacker == self)
	{
		return;
	}

	dropbag = self dropscavengerbag("scavenger_bag_mp");
	dropbag thread handlescavengerbagpickup(self);
}

getweaponbasedgrenadecount(weapon)
{
	return 2;
}

getweaponbasedsmokegrenadecount(weapon)
{
	return 1;
}

getfraggrenadecount()
{
	grenadetype = "frag_grenade_mp";
	count = self getammocount(grenadetype);
	return count;
}

getsmokegrenadecount()
{
	grenadetype = "smoke_grenade_mp";
	count = self getammocount(grenadetype);
	return count;
}

watchweaponusage(weaponhand)
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	for(;;)
	{
		self waittill("weapon_fired", weaponname);
		self.hasdonecombat = 1;
		if(!isprimaryweapon(weaponname) && !issidearm(weaponname))
		{
			continue;
		}

		if(isdefined(self.hitsthismag[weaponname]))
		{
			thread updatemagshots(weaponname);
		}

		totalshots = maps\mp\gametypes\_persistence::statgetbuffered("totalShots") + 1;
		hits = maps\mp\gametypes\_persistence::statgetbuffered("hits");
		maps\mp\gametypes\_persistence::statsetbuffered("totalShots", totalshots);
		maps\mp\gametypes\_persistence::statsetbuffered("accuracy", int(hits * 10000 / totalshots));
		maps\mp\gametypes\_persistence::statsetbuffered("misses", int(totalshots - hits));
	}
}

updatemagshots(weaponname)
{
	self endon("death");
	self endon("disconnect");
	self endon("updateMagShots_" + weaponname);
	self.hitsthismag[weaponname]--;
	wait 0.05;
	self.hitsthismag[weaponname] = weaponclipsize(weaponname);
}

checkhitsthismag(weaponname)
{
	self endon("death");
	self endon("disconnect");
	self notify("updateMagShots_" + weaponname);
	waittillframeend;
	if(self.hitsthismag[weaponname] == 0)
	{
		weaponclass = maps\mp\_utility::getweaponclass(weaponname);
		maps\mp\gametypes\_missions::genericchallenge(weaponclass);
		self.hitsthismag[weaponname] = weaponclipsize(weaponname);
		return;
	}
}

checkhit(weaponname, victim)
{
	if(!isprimaryweapon(weaponname) && !issidearm(weaponname))
	{
		return;
	}

	waittillframeend;
	if(isdefined(self.hitsthismag[weaponname]))
	{
		thread checkhitsthismag(weaponname);
	}

	if(!isdefined(self.lasthittime[weaponname]))
	{
		self.lasthittime[weaponname] = 0;
	}

	if(self.lasthittime[weaponname] == gettime())
	{
		return;
	}

	self.lasthittime[weaponname] = gettime();
	totalshots = maps\mp\gametypes\_persistence::statgetbuffered("totalShots");
	hits = maps\mp\gametypes\_persistence::statgetbuffered("hits") + 1;
	if(hits <= totalshots)
	{
		maps\mp\gametypes\_persistence::statsetbuffered("hits", hits);
		maps\mp\gametypes\_persistence::statsetbuffered("misses", int(totalshots - hits));
		maps\mp\gametypes\_persistence::statsetbuffered("accuracy", int(hits * 10000 / totalshots));
		return;
	}
}

attackercandamageitem(attacker, itemowner)
{
	return friendlyfirecheck(itemowner, attacker);
}

friendlyfirecheck(owner, attacker, forcedfriendlyfirerule)
{
	if(!isdefined(owner))
	{
		return 1;
	}

	if(!level.teambased)
	{
		return 1;
	}

	attackerteam = attacker.team;
	friendlyfirerule = level.friendlyfire;
	if(isdefined(forcedfriendlyfirerule))
	{
		friendlyfirerule = forcedfriendlyfirerule;
	}

	if(friendlyfirerule != 0)
	{
		return 1;
	}

	if(attacker == owner)
	{
		return 1;
	}

	if(!isdefined(attackerteam))
	{
		return 1;
	}

	if(attackerteam != owner.team)
	{
		return 1;
	}

	return 0;
}

watchgrenadeusage()
{
	self endon("death");
	self endon("disconnect");
	self.throwinggrenade = undefined;
	self.gotpullbacknotify = 0;
	if(maps\mp\_utility::getintproperty("scr_deleteexplosivesonspawn", 1) == 1)
	{
		if(isdefined(self.c4array))
		{
			for(i = 0;i < self.c4array.size;i++)
			{
				if(isdefined(self.c4array[i]))
				{
					self.c4array[i] delete();
				}
			}
		}

		self.c4array = [];
		if(isdefined(self.claymorearray))
		{
			for(i = 0;i < self.claymorearray.size;i++)
			{
				if(isdefined(self.claymorearray[i]))
				{
					self.claymorearray[i] delete();
				}
			}
		}

		self.claymorearray = [];
	}
	else
	{
		if(!isdefined(self.c4array))
		{
			self.c4array = [];
		}

		if(!isdefined(self.claymorearray))
		{
			self.claymorearray = [];
		}
	}

	thread watchc4();
	thread watchc4detonation();
	thread watchc4altdetonation();
	thread watchclaymores();
	thread deletec4andclaymoresondisconnect();
	thread watchforthrowbacks();
	for(;;)
	{
		self waittill("grenade_pullback", weaponname);
		self.hasdonecombat = 1;
		if(weaponname == "claymore_mp")
		{
			continue;
		}

		self.throwinggrenade = weaponname;
		self.gotpullbacknotify = 1;
		if(weaponname == "c4_mp")
		{
			beginc4tracking();
		}
		else
		{
			begingrenadetracking();
		}

		self.throwinggrenade = undefined;
	}
}

begingrenadetracking()
{
	self endon("death");
	self endon("disconnect");
	self endon("offhand_end");
	self endon("weapon_change");
	starttime = gettime();
	self waittill("grenade_fire", grenade, weaponname);
	if(gettime() - starttime > 1000 && weaponname == "frag_grenade_mp")
	{
		grenade.iscooked = 1;
	}

	self.changingweapon = undefined;
	if(weaponname == "frag_grenade_mp" || weaponname == "semtex_mp")
	{
		grenade thread maps\mp\gametypes\_shellshock::grenade_earthquake();
		grenade.originalowner = self;
	}

	if(weaponname == "flash_grenade_mp" || weaponname == "concussion_grenade_mp")
	{
		grenade.owner = self;
		grenade thread empexplodewaiter();
		return;
	}
}

addmissiletosighttraces(team)
{
	self.team = team;
	level.missilesforsighttraces[level.missilesforsighttraces.size] = self;
	self waittill("death");
	newarray = [];
	foreach(missile in level.missilesforsighttraces)
	{
		if(missile != self)
		{
			newarray[newarray.size] = missile;
		}
	}

	level.missilesforsighttraces = newarray;
}

watchmissileusage()
{
	self endon("death");
	self endon("disconnect");
	for(;;)
	{
		self waittill("missile_fire", missile, weaponname);
		if(issubstr(weaponname, "gl_"))
		{
			missile.primaryweapon = self getcurrentprimaryweapon();
			missile thread maps\mp\gametypes\_shellshock::grenade_earthquake();
		}

		switch(weaponname)
		{
			case "stinger_mp":
			case "at4_mp":
				level notify("stinger_fired", self, missile, self.stingertarget);
				thread maps\mp\_utility::setaltsceneobj(missile, "tag_origin", 65);
				break;
	
			case "javelin_mp":
				level notify("stinger_fired", self, missile, self.javelintarget);
				thread maps\mp\_utility::setaltsceneobj(missile, "tag_origin", 65);
				break;
	
			default:
				break;
		}

		switch(weaponname)
		{
			case "javelin_mp":
			case "rpg_mp":
			case "at4_mp":
			case "remotemissile_projectile_mp":
			case "ac130_40mm_mp":
			case "ac130_105mm_mp":
				missile thread maps\mp\gametypes\_shellshock::grenade_earthquake();
				break;
	
			default:
				break;
		}
	}
}

watchsentryusage()
{
	self endon("death");
	self endon("disconnect");
	for(;;)
	{
		self waittill("sentry_placement_finished", sentry);
		thread maps\mp\_utility::setaltsceneobj(sentry, "tag_flash", 65);
	}
}

empexplodewaiter()
{
	thread maps\mp\gametypes\_shellshock::endondeath();
	self endon("end_explode");
	self waittill("explode", position);
	ents = getempdamageents(position, 512, 0);
	foreach(ent in ents)
	{
		if(isdefined(ent.owner) && !friendlyfirecheck(self.owner, ent.owner))
		{
			continue;
		}

		ent notify("emp_damage", self.owner, 8);
	}
}

beginc4tracking()
{
	self endon("death");
	self endon("disconnect");
	common_scripts\utility::waittill_any("grenade_fire", "weapon_change", "offhand_end");
}

watchforthrowbacks()
{
	self endon("death");
	self endon("disconnect");
	for(;;)
	{
		self waittill("grenade_fire", grenade, weapname);
		if(self.gotpullbacknotify)
		{
			self.gotpullbacknotify = 0;
			continue;
		}

		if(!issubstr(weapname, "frag_") && !issubstr(weapname, "semtex_"))
		{
			continue;
		}

		grenade.threwback = 1;
		thread maps\mp\_utility::incplayerstat("throwbacks", 1);
		grenade thread maps\mp\gametypes\_shellshock::grenade_earthquake();
		grenade.originalowner = self;
	}
}

watchc4()
{
	self endon("spawned_player");
	self endon("disconnect");
	for(;;)
	{
		self waittill("grenade_fire", c4, weapname);
		if(weapname == "c4" || weapname == "c4_mp")
		{
			if(!self.c4array.size)
			{
				thread watchc4altdetonate();
			}

			if(self.c4array.size)
			{
				self.c4array = common_scripts\utility::array_removeundefined(self.c4array);
				if(self.c4array.size >= level.maxperplayerexplosives)
				{
					self.c4array[0] detonate();
				}
			}

			self.c4array[self.c4array.size] = c4;
			c4.owner = self;
			c4.team = self.team;
			c4.activated = 0;
			c4.weaponname = weapname;
			c4 thread maps\mp\gametypes\_shellshock::c4_earthquake();
			c4 thread c4activate();
			c4 thread c4damage();
			c4 thread c4empdamage();
			c4 thread c4empkillstreakwait();
		}
	}
}

c4empdamage()
{
	self endon("death");
	for(;;)
	{
		self waittill("emp_damage", attacker, duration);
		playfxontag(common_scripts\utility::getfx("sentry_explode_mp"), self, "tag_origin");
		self.disabled = 1;
		self notify("disabled");
		wait duration;
		self.disabled = undefined;
		self notify("enabled");
	}
}

c4empkillstreakwait()
{
	self endon("death");
	for(;;)
	{
		level waittill("emp_update");
		if((level.teambased && level.teamemped[self.team]) || !level.teambased && isdefined(level.empplayer) && level.empplayer != self.owner)
		{
			self.disabled = 1;
			self notify("disabled");
			continue;
		}

		self.disabled = undefined;
		self notify("enabled");
	}
}

setclaymoreteamheadicon(team)
{
	self endon("death");
	wait 0.05;
	if(level.teambased)
	{
		maps\mp\_entityheadicons::setteamheadicon(team, (0,0,20));
		return;
	}

	if(isdefined(self.owner))
	{
		maps\mp\_entityheadicons::setplayerheadicon(self.owner, (0,0,20));
		return;
	}
}

watchclaymores()
{
	self endon("spawned_player");
	self endon("disconnect");
	self.claymorearray = [];
	for(;;)
	{
		self waittill("grenade_fire", claymore, weapname);
		if(weapname == "claymore" || weapname == "claymore_mp")
		{
			self.claymorearray = common_scripts\utility::array_removeundefined(self.claymorearray);
			if(self.claymorearray.size >= level.maxperplayerexplosives)
			{
				self.claymorearray[0] detonate();
			}

			self.claymorearray[self.claymorearray.size] = claymore;
			claymore.owner = self;
			claymore.team = self.team;
			claymore.weaponname = weapname;
			claymore thread c4damage();
			claymore thread c4empdamage();
			claymore thread c4empkillstreakwait();
			claymore thread claymoredetonation();
			claymore thread setclaymoreteamheadicon(self.pers["team"]);
		}
	}
}

claymoredetonation()
{
	self endon("death");
	self waittill("missile_stuck");
	damagearea = spawn("trigger_radius", self.origin + (0,0,0 - level.claymoredetonateradius), 0, level.claymoredetonateradius, level.claymoredetonateradius * 2);
	thread deleteondeath(damagearea);
	for(;;)
	{
		damagearea waittill("trigger", player);
		if(getdvarint("scr_claymoredebug") != 1)
		{
			if(isdefined(self.owner) && player == self.owner)
			{
				continue;
			}

			if(!friendlyfirecheck(self.owner, player, 0))
			{
				continue;
			}
		}

		if(lengthsquared(player getvelocity()) < 10)
		{
			continue;
		}

		if(!player shouldaffectclaymore(self))
		{
			continue;
		}

		if(player damageconetrace(self.origin, self) > 0)
		{
			break;
		}
	}

	self playsound("claymore_activated");
	if(player maps\mp\_utility::_hasperk("specialty_delaymine"))
	{
		wait 3;
	}
	else
	{
		wait level.claymoredetectiongraceperiod;
	}

	self detonate();
}

shouldaffectclaymore(claymore)
{
	if(isdefined(claymore.disabled))
	{
		return 0;
	}

	pos = self.origin + (0,0,32);
	dirtopos = pos - claymore.origin;
	claymoreforward = anglestoforward(claymore.angles);
	dist = vectordot(dirtopos, claymoreforward);
	if(dist < level.claymoredetectionmindist)
	{
		return 0;
	}

	dirtopos = vectornormalize(dirtopos);
	dot = vectordot(dirtopos, claymoreforward);
	return dot > level.claymoredetectiondot;
}

deleteondeath(ent)
{
	self waittill("death");
	wait 0.05;
	if(isdefined(ent))
	{
		ent delete();
		return;
	}
}

c4activate()
{
	self endon("death");
	self waittill("missile_stuck");
	wait 0.05;
	self notify("activated");
	self.activated = 1;
}

watchc4altdetonate()
{
	self endon("death");
	self endon("disconnect");
	self endon("detonated");
	level endon("game_ended");
	buttontime = 0;
	for(;;)
	{
		if(self usebuttonpressed())
		{
			buttontime = 0;
			while(self usebuttonpressed())
			{
				buttontime = buttontime + 0.05;
				wait 0.05;
			}

			if(buttontime >= 0.5)
			{
				continue;
			}

			buttontime = 0;
			while(!self usebuttonpressed() && buttontime < 0.5)
			{
				buttontime = buttontime + 0.05;
				wait 0.05;
			}

			if(buttontime >= 0.5)
			{
				continue;
			}

			if(!self.c4array.size)
			{
				return;
			}

			self notify("alt_detonate");
		}

		wait 0.05;
	}
}

watchc4detonation()
{
	self endon("death");
	self endon("disconnect");
	for(;;)
	{
		self waittillmatch("c4_mp", "detonate");
		newarray = [];
		for(i = 0;i < self.c4array.size;i++)
		{
			c4 = self.c4array[i];
			if(isdefined(self.c4array[i]))
			{
				c4 thread waitanddetonate(0.1);
			}
		}

		self.c4array = newarray;
		self notify("detonated");
	}
}

watchc4altdetonation()
{
	self endon("death");
	self endon("disconnect");
	for(;;)
	{
		self waittill("alt_detonate");
		weap = self getcurrentweapon();
		if(weap != "c4_mp")
		{
			newarray = [];
			for(i = 0;i < self.c4array.size;i++)
			{
				c4 = self.c4array[i];
				if(isdefined(self.c4array[i]))
				{
					c4 thread waitanddetonate(0.1);
				}
			}

			self.c4array = newarray;
			self notify("detonated");
		}
	}
}

waitanddetonate(delay)
{
	self endon("death");
	wait delay;
	waittillenabled();
	self detonate();
}

deletec4andclaymoresondisconnect()
{
	self endon("death");
	self waittill("disconnect");
	c4array = self.c4array;
	claymorearray = self.claymorearray;
	wait 0.05;
	for(i = 0;i < c4array.size;i++)
	{
		if(isdefined(c4array[i]))
		{
			c4array[i] delete();
		}
	}

	for(i = 0;i < claymorearray.size;i++)
	{
		if(isdefined(claymorearray[i]))
		{
			claymorearray[i] delete();
		}
	}
}

c4damage()
{
	self endon("death");
	self setcandamage(1);
	self.maxhealth = 100000;
	self.health = self.maxhealth;
	attacker = undefined;
	for(;;)
	{
		self waittill("damage", damage, attacker, direction_vec, point, type, modelname, tagname, partname, idflags);
		if(!isplayer(attacker))
		{
			continue;
		}

		if(!friendlyfirecheck(self.owner, attacker))
		{
			continue;
		}

		if(damage < 5)
		{
			continue;
		}

		break;
	}

	if(level.c4explodethisframe)
	{
		wait 0.1 + randomfloat(0.4);
	}
	else
	{
		wait 0.05;
	}

	if(!isdefined(self))
	{
		return;
	}

	level.c4explodethisframe = 1;
	thread resetc4explodethisframe();
	if(isdefined(type) && issubstr(type, "MOD_GRENADE") || issubstr(type, "MOD_EXPLOSIVE"))
	{
		self.waschained = 1;
	}

	if(isdefined(idflags) && idflags & level.idflags_penetration)
	{
		self.wasdamagedfrombulletpenetration = 1;
	}

	self.wasdamaged = 1;
	if(level.teambased)
	{
		if(isdefined(attacker) && isdefined(attacker.pers["team"]) && isdefined(self.owner) && isdefined(self.owner.pers["team"]))
		{
			if(attacker.pers["team"] != self.owner.pers["team"])
			{
				attacker notify("destroyed_explosive");
			}
		}
	}
	else if(isdefined(self.owner) && isdefined(attacker) && attacker != self.owner)
	{
		attacker notify("destroyed_explosive");
	}

	self detonate(attacker);
}

resetc4explodethisframe()
{
	wait 0.05;
	level.c4explodethisframe = 0;
}

saydamaged(param_418, amount)
{
	for(i = 0;i < 60;i++)
	{
		wait 0.05;
	}
}

waittillenabled()
{
	if(!isdefined(self.disabled))
	{
		return;
	}

	self waittill("enabled");
}

c4detectiontrigger(ownerteam)
{
	self waittill("activated");
	trigger = spawn("trigger_radius", self.origin - (0,0,128), 0, 512, 256);
	trigger.detectid = "trigger" + gettime() + randomint(1000000);
	trigger.owner = self;
	trigger thread detecticonwaiter(level.otherteam[ownerteam]);
	self waittill("death");
	trigger notify("end_detection");
	if(isdefined(trigger.bombsquadicon))
	{
		trigger.bombsquadicon destroy();
	}

	trigger delete();
}

claymoredetectiontrigger_wait(ownerteam)
{
	self endon("death");
	self waittill("missile_stuck");
	thread claymoredetectiontrigger(ownerteam);
}

claymoredetectiontrigger(ownerteam)
{
	trigger = spawn("trigger_radius", self.origin - (0,0,128), 0, 512, 256);
	trigger.detectid = "trigger" + gettime() + randomint(1000000);
	trigger.owner = self;
	trigger thread detecticonwaiter(level.otherteam[ownerteam]);
	self waittill("death");
	trigger notify("end_detection");
	if(isdefined(trigger.bombsquadicon))
	{
		trigger.bombsquadicon destroy();
	}

	trigger delete();
}

detecticonwaiter(detectteam)
{
	self endon("end_detection");
	level endon("game_ended");
	while(!level.gameended)
	{
		self waittill("trigger", player);
		if(!player.detectexplosives)
		{
			continue;
		}

		if(level.teambased && player.team != detectteam)
		{
			continue;
		}
		else if(!level.teambased && player == self.owner.owner)
		{
			continue;
		}

		if(isdefined(player.bombsquadids[self.detectid]))
		{
			continue;
		}

		player thread showheadicon(self);
	}
}

setupbombsquad()
{
	self.bombsquadids = [];
	if(self.detectexplosives && !self.bombsquadicons.size)
	{
		for(index = 0;index < 4;index++)
		{
			self.bombsquadicons[index] = newclienthudelem(self);
			self.bombsquadicons[index].x = 0;
			self.bombsquadicons[index].y = 0;
			self.bombsquadicons[index].z = 0;
			self.bombsquadicons[index].alpha = 0;
			self.bombsquadicons[index].archived = 1;
			self.bombsquadicons[index] setshader("waypoint_bombsquad", 14, 14);
			self.bombsquadicons[index] setwaypoint(0, 0);
			self.bombsquadicons[index].detectid = "";
		}

		return;
	}

	if(!self.detectexplosives)
	{
		for(index = 0;index < self.bombsquadicons.size;index++)
		{
			self.bombsquadicons[index] destroy();
		}

		self.bombsquadicons = [];
		return;
	}
}

showheadicon(trigger)
{
	triggerdetectid = trigger.detectid;
	useid = -1;
	for(index = 0;index < 4;index++)
	{
		detectid = self.bombsquadicons[index].detectid;
		if(detectid == triggerdetectid)
		{
			return;
		}

		if(detectid == "")
		{
			useid = index;
		}
	}

	if(useid < 0)
	{
		return;
	}

	self.bombsquadids[triggerdetectid] = 1;
	self.bombsquadicons[useid].x = trigger.origin[0];
	self.bombsquadicons[useid].y = trigger.origin[1];
	self.bombsquadicons[useid].z = trigger.origin[2] + 24 + 128;
	self.bombsquadicons[useid] fadeovertime(0.25);
	self.bombsquadicons[useid].alpha = 1;
	self.bombsquadicons[useid].detectid = trigger.detectid;
	while(isalive(self) && isdefined(trigger) && self istouching(trigger))
	{
		wait 0.05;
	}

	if(!isdefined(self))
	{
		return;
	}

	self.bombsquadicons[useid].detectid = "";
	self.bombsquadicons[useid] fadeovertime(0.25);
	self.bombsquadicons[useid].alpha = 0;
	self.bombsquadids[triggerdetectid] = undefined;
}

getdamageableents(pos, radius, dolos, startradius)
{
	ents = [];
	if(!isdefined(dolos))
	{
		dolos = 0;
	}

	if(!isdefined(startradius))
	{
		startradius = 0;
	}

	radiussq = radius * radius;
	players = level.players;
	for(i = 0;i < players.size;i++)
	{
		if(!isalive(players[i]) || players[i].sessionstate != "playing")
		{
			continue;
		}

		playerpos = maps\mp\_utility::get_damageable_player_pos(players[i]);
		distsq = distancesquared(pos, playerpos);
		if(distsq < radiussq && !dolos || weapondamagetracepassed(pos, playerpos, startradius, players[i]))
		{
			ents[ents.size] = maps\mp\_utility::get_damageable_player(players[i], playerpos);
		}
	}

	grenades = getentarray("grenade", "classname");
	for(i = 0;i < grenades.size;i++)
	{
		entpos = maps\mp\_utility::get_damageable_grenade_pos(grenades[i]);
		distsq = distancesquared(pos, entpos);
		if(distsq < radiussq && !dolos || weapondamagetracepassed(pos, entpos, startradius, grenades[i]))
		{
			ents[ents.size] = maps\mp\_utility::get_damageable_grenade(grenades[i], entpos);
		}
	}

	destructibles = getentarray("destructible", "targetname");
	for(i = 0;i < destructibles.size;i++)
	{
		entpos = destructibles[i].origin;
		distsq = distancesquared(pos, entpos);
		if(distsq < radiussq && !dolos || weapondamagetracepassed(pos, entpos, startradius, destructibles[i]))
		{
			newent = spawnstruct();
			newent.isplayer = 0;
			newent.isadestructable = 0;
			newent.entity = destructibles[i];
			newent.damagecenter = entpos;
			ents[ents.size] = newent;
		}
	}

	destructables = getentarray("destructable", "targetname");
	for(i = 0;i < destructables.size;i++)
	{
		entpos = destructables[i].origin;
		distsq = distancesquared(pos, entpos);
		if(distsq < radiussq && !dolos || weapondamagetracepassed(pos, entpos, startradius, destructables[i]))
		{
			newent = spawnstruct();
			newent.isplayer = 0;
			newent.isadestructable = 1;
			newent.entity = destructables[i];
			newent.damagecenter = entpos;
			ents[ents.size] = newent;
		}
	}

	sentries = getentarray("misc_turret", "classname");
	foreach(sentry in sentries)
	{
		entpos = sentry.origin + (0,0,32);
		distsq = distancesquared(pos, entpos);
		if(distsq < radiussq && !dolos || weapondamagetracepassed(pos, entpos, startradius, sentry))
		{
			if(sentry.model == "sentry_minigun")
			{
				ents[ents.size] = maps\mp\_utility::get_damageable_sentry(sentry, entpos);
			}
		}
	}

	return ents;
}

getempdamageents(pos, radius, dolos, startradius)
{
	ents = [];
	if(!isdefined(dolos))
	{
		dolos = 0;
	}

	if(!isdefined(startradius))
	{
		startradius = 0;
	}

	grenades = getentarray("grenade", "classname");
	foreach(grenade in grenades)
	{
		entpos = grenade.origin;
		dist = distance(pos, entpos);
		if(dist < radius && !dolos || weapondamagetracepassed(pos, entpos, startradius, grenade))
		{
			ents[ents.size] = grenade;
		}
	}

	turrets = getentarray("misc_turret", "classname");
	foreach(turret in turrets)
	{
		entpos = turret.origin;
		dist = distance(pos, entpos);
		if(dist < radius && !dolos || weapondamagetracepassed(pos, entpos, startradius, turret))
		{
			ents[ents.size] = turret;
		}
	}

	return ents;
}

weapondamagetracepassed(from, to, startradius, ent)
{
	midpos = undefined;
	diff = to - from;
	if(lengthsquared(diff) < startradius * startradius)
	{
		return 1;
	}

	dir = vectornormalize(diff);
	midpos = from + (dir[0] * startradius,dir[1] * startradius,dir[2] * startradius);
	trace = bullettrace(midpos, to, 0, ent);
	if(getdvarint("scr_damage_debug") != 0)
	{
		thread debugprint(from, ".dmg");
		if(isdefined(ent))
		{
			thread debugprint(to, "." + ent.classname);
		}
		else
		{
			thread debugprint(to, ".undefined");
		}

		if(trace["fraction"] == 1)
		{
			thread debugline(midpos, to, (1,1,1));
		}
		else
		{
			thread debugline(midpos, trace["position"], (1,0.9,0.8));
			thread debugline(trace["position"], to, (1,0.4,0.3));
		}
	}

	return trace["fraction"] == 1;
}

damageent(einflictor, eattacker, idamage, smeansofdeath, sweapon, damagepos, damagedir)
{
	if(self.isplayer)
	{
		self.damageorigin = damagepos;
		self.entity thread [[ level.callbackplayerdamage ]](einflictor, eattacker, idamage, 0, smeansofdeath, sweapon, damagepos, damagedir, "none", 0);
		return;
	}

	if((self.isadestructable && sweapon == "artillery_mp" || sweapon == "claymore_mp") || sweapon == "stealth_bomb_mp")
	{
		return;
	}

	self.entity notify("damage", idamage, eattacker, (0,0,0), (0,0,0), "mod_explosive", "", "");
}

debugline(a, b, color)
{
	for(i = 0;i < 600;i++)
	{
		wait 0.05;
	}
}

debugprint(param_43E, param_43F)
{
	for(i = 0;i < 600;i++)
	{
		wait 0.05;
	}
}

onweapondamage(einflictor, sweapon, meansofdeath, damage, eattacker)
{
	self endon("death");
	self endon("disconnect");
	switch(sweapon)
	{
		case "concussion_grenade_mp":
			radius = 512;
			scale = 1 - distance(self.origin, einflictor.origin) / radius;
			if(scale < 0)
			{
				scale = 0;
			}
	
			time = 2 + 4 * scale;
			wait 0.05;
			eattacker notify("stun_hit");
			self shellshock("concussion_grenade_mp", time);
			self.concussionendtime = gettime() + time * 1000;
			break;

		case "weapon_cobra_mk19_mp":
			break;

		default:
			maps\mp\gametypes\_shellshock::shellshockondamage(meansofdeath, damage);
			break;
	}
}

isprimaryweapon(weapname)
{
	if(weapname == "none")
	{
		return 0;
	}

	if(weaponinventorytype(weapname) != "primary")
	{
		return 0;
	}

	switch(weaponclass(weapname))
	{
		case "rocketlauncher":
		case "spread":
		case "mg":
		case "rifle":
		case "smg":
		case "sniper":
		case "pistol":
			return 1;

		default:
			return 0;
	}
}

isaltmodeweapon(weapname)
{
	if(weapname == "none")
	{
		return 0;
	}

	return weaponinventorytype(weapname) == "altmode";
}

isinventoryweapon(weapname)
{
	if(weapname == "none")
	{
		return 0;
	}

	return weaponinventorytype(weapname) == "item";
}

isriotshield(weapname)
{
	if(weapname == "none")
	{
		return 0;
	}

	return weapontype(weapname) == "riotshield";
}

isoffhandweapon(weapname)
{
	if(weapname == "none")
	{
		return 0;
	}

	return weaponinventorytype(weapname) == "offhand";
}

issidearm(weapname)
{
	if(weapname == "none")
	{
		return 0;
	}

	if(weaponinventorytype(weapname) != "primary")
	{
		return 0;
	}

	return weaponclass(weapname) == "pistol";
}

isgrenade(weapname)
{
	weapclass = weaponclass(weapname);
	weaptype = weaponinventorytype(weapname);
	if(weapclass != "grenade")
	{
		return 0;
	}

	if(weaptype != "offhand")
	{
		return 0;
	}
}

getstowoffsetmodel(weaponname)
{
	basename = maps\mp\_utility::getbaseweaponname(weaponname);
	return level.stow_offset_array[basename];
}

stowpriorityweapon()
{
	foreach(weapon_name, priority_weapon in level.stow_priority_model_array)
	{
		weaponname = maps\mp\_utility::getbaseweaponname(weapon_name);
		weaponlist = self getweaponslistall();
		foreach(weapon in weaponlist)
		{
			if(self getcurrentweapon() == weapon)
			{
				continue;
			}

			if(weaponname == maps\mp\_utility::getbaseweaponname(weapon))
			{
				return weaponname + "_mp";
			}
		}
	}

	return "";
}

updatestowedweapon()
{
	self endon("spawned");
	self endon("killed_player");
	self endon("disconnect");
	self.tag_stowed_back = undefined;
	self.tag_stowed_hip = undefined;
	team = self.team;
	class = self.class;
	thread stowedweaponsrefresh();
	for(;;)
	{
		self waittill("weapon_change", newweapon);
		if(newweapon == "none")
		{
			continue;
		}

		thread stowedweaponsrefresh();
	}
}

stowedweaponsrefresh()
{
	self endon("spawned");
	self endon("killed_player");
	self endon("disconnect");
	detach_all_weapons();
	stow_on_back();
	stow_on_hip();
}

detach_all_weapons()
{
	if(isdefined(self.tag_stowed_back))
	{
		detach_back_weapon();
	}

	if(isdefined(self.tag_stowed_hip))
	{
		detach_hip_weapon();
		return;
	}
}

detach_back_weapon()
{
	detach_success = detachifattached(self.tag_stowed_back, "tag_stowed_back");
	self.tag_stowed_back = undefined;
}

detach_hip_weapon()
{
	detach_success = detachifattached(self.tag_stowed_hip, "tag_stowed_hip");
	self.tag_stowed_hip = undefined;
}

stow_on_back()
{
	currentweapon = self getcurrentweapon();
	currentisalt = isaltmodeweapon(currentweapon);
	stowweapon = undefined;
	stowcamo = 0;
	large_projectile = stowpriorityweapon();
	stowoffsetmodel = undefined;
	if(large_projectile != "")
	{
		stowweapon = large_projectile;
	}
	else
	{
		weaponslist = self getweaponslistprimaries();
		foreach(weaponname in weaponslist)
		{
			if(weaponname == currentweapon)
			{
				continue;
			}

			invtype = weaponinventorytype(weaponname);
			if(invtype != "primary")
			{
				if(invtype == "altmode")
				{
					continue;
				}

				if(weaponclass(weaponname) == "pistol")
				{
					continue;
				}
			}

			if(weapontype(weaponname) == "riotshield")
			{
				continue;
			}

			if(currentisalt && weaponaltweaponname(weaponname) == currentweapon)
			{
				continue;
			}

			stowweapon = weaponname;
			stowoffsetmodel = getstowoffsetmodel(stowweapon);
			if(stowweapon == self.primaryweapon)
			{
				stowcamo = self.loadoutprimarycamo;
				continue;
			}

			if(stowweapon == self.secondaryweapon)
			{
				stowcamo = self.loadoutsecondarycamo;
				continue;
			}

			stowcamo = 0;
		}
	}

	if(!isdefined(stowweapon))
	{
		return;
	}

	if(large_projectile != "")
	{
		self.tag_stowed_back = level.stow_priority_model_array[large_projectile];
	}
	else
	{
		self.tag_stowed_back = getweaponmodel(stowweapon, stowcamo);
	}

	if(isdefined(stowoffsetmodel))
	{
		self attach(stowoffsetmodel, "tag_stowed_back", 1);
		attachtag = "tag_stow_back_mid_attach";
	}
	else
	{
		attachtag = "tag_stowed_back";
	}

	self attach(self.tag_stowed_back, attachtag, 1);
	hidetaglist = getweaponhidetags(stowweapon);
	if(!isdefined(hidetaglist))
	{
		return;
	}

	for(i = 0;i < hidetaglist.size;i++)
	{
		self hidepart(hidetaglist[i], self.tag_stowed_back);
	}
}

stow_on_hip()
{
	currentweapon = self getcurrentweapon();
	stowweapon = undefined;
	weaponslist = self getweaponslistoffhands();
	foreach(weaponname in weaponslist)
	{
		if(weaponname == currentweapon)
		{
			continue;
		}

		if(weaponname != "c4_mp" && weaponname != "claymore_mp")
		{
			continue;
		}

		stowweapon = weaponname;
	}

	if(!isdefined(stowweapon))
	{
		return;
	}

	self.tag_stowed_hip = getweaponmodel(stowweapon);
	self attach(self.tag_stowed_hip, "tag_stowed_hip_rear", 1);
	hidetaglist = getweaponhidetags(stowweapon);
	if(!isdefined(hidetaglist))
	{
		return;
	}

	for(i = 0;i < hidetaglist.size;i++)
	{
		self hidepart(hidetaglist[i], self.tag_stowed_hip);
	}
}

updatesavedlastweapon()
{
	self endon("death");
	self endon("disconnect");
	currentweapon = self.currentweaponatspawn;
	self.saved_lastweapon = currentweapon;
	for(;;)
	{
		self waittill("weapon_change", newweapon);
		if(newweapon == "none")
		{
			self.saved_lastweapon = currentweapon;
			continue;
		}

		weaponinvtype = weaponinventorytype(newweapon);
		if(weaponinvtype != "primary" && weaponinvtype != "altmode")
		{
			self.saved_lastweapon = currentweapon;
			continue;
		}

		if(newweapon == "onemanarmy_mp")
		{
			self.saved_lastweapon = currentweapon;
			continue;
		}

		updatemovespeedscale("primary");
		self.saved_lastweapon = currentweapon;
		currentweapon = newweapon;
	}
}

empplayer(numseconds)
{
	self endon("disconnect");
	self endon("death");
	thread clearempondeath();
}

clearempondeath()
{
	self endon("disconnect");
	self waittill("death");
}

updatemovespeedscale(weapontype)
{
	if(!isdefined(weapontype) || weapontype == "primary" || weapontype != "secondary")
	{
		weapontype = self.primaryweapon;
	}
	else
	{
		weapontype = self.secondaryweapon;
	}

	if(isdefined(self.primaryweapon) && self.primaryweapon == "riotshield_mp")
	{
		self setmovespeedscale(0.8 * self.movespeedscaler);
		return;
	}

	if(!isdefined(weapontype))
	{
		weapclass = "none";
	}
	else
	{
		weapclass = weaponclass(weapontype);
	}

	switch(weapclass)
	{
		case "rifle":
			self setmovespeedscale(0.95 * self.movespeedscaler);
			break;

		case "pistol":
			self setmovespeedscale(1 * self.movespeedscaler);
			break;

		case "mg":
			self setmovespeedscale(0.875 * self.movespeedscaler);
			break;

		case "smg":
			self setmovespeedscale(1 * self.movespeedscaler);
			break;

		case "spread":
			self setmovespeedscale(0.95 * self.movespeedscaler);
			break;

		case "rocketlauncher":
			self setmovespeedscale(0.8 * self.movespeedscaler);
			break;

		case "sniper":
			self setmovespeedscale(1 * self.movespeedscaler);
			break;

		default:
			self setmovespeedscale(1 * self.movespeedscaler);
			break;
	}
}

buildweapondata(param_451)
{
	attachmentlist = getattachmentlist();
	max_weapon_num = 149;
	baseweapondata = [];
	for(weaponid = 0;weaponid <= max_weapon_num;weaponid++)
	{
		basename = tablelookup("mp/statstable.csv", 0, weaponid, 4);
		if(basename == "")
		{
			continue;
		}

		assetname = basename + "_mp";
		if(!issubstr(tablelookup("mp/statsTable.csv", 0, weaponid, 2), "weapon_"))
		{
			continue;
		}

		if(weaponinventorytype(assetname) != "primary")
		{
			continue;
		}

		weaponinfo = spawnstruct();
		weaponinfo.basename = basename;
		weaponinfo.assetname = assetname;
		weaponinfo.variants = [];
		weaponinfo.variants[0] = assetname;
		attachmentnames = [];
		for(innerloopcount = 0;innerloopcount < 6;innerloopcount++)
		{
			attachmentname = tablelookup("mp/statStable.csv", 0, weaponid, innerloopcount + 11);
			if(param_451)
			{
				switch(attachmentname)
				{
					case "xmags":
					case "rof":
					case "fmj":
						break;
				}
			}

			if(attachmentname == "")
			{
				break;
			}

			attachmentnames[attachmentname] = 1;
		}

		attachments = [];
		foreach(attachmentname in attachmentlist)
		{
			if(!isdefined(attachmentnames[attachmentname]))
			{
				continue;
			}

			weaponinfo.variants[weaponinfo.variants.size] = basename + "_" + attachmentname + "_mp";
			attachments[attachments.size] = attachmentname;
		}

		for(i = 0;i < attachments.size - 1;i++)
		{
			colindex = tablelookuprownum("mp/attachmentCombos.csv", 0, attachments[i]);
			for(j = i + 1;j < attachments.size;j++)
			{
				if(tablelookup("mp/attachmentCombos.csv", 0, attachments[j], colindex) == "no")
				{
					continue;
				}

				weaponinfo.variants[weaponinfo.variants.size] = basename + "_" + attachments[i] + "_" + attachments[j] + "_mp";
			}
		}

		baseweapondata[basename] = weaponinfo;
	}

	return baseweapondata;
}

monitorsemtex()
{
	self endon("disconnect");
	self endon("death");
	for(;;)
	{
		self waittill("grenade_fire", weapon);
		if(!issubstr(weapon.model, "semtex"))
		{
			continue;
		}

		weapon waittill("missile_stuck", stuckto);
		if(!isplayer(stuckto))
		{
			continue;
		}

		if(level.teambased && isdefined(stuckto.team) && stuckto.team == self.team)
		{
			weapon.isstuck = "friendly";
			continue;
		}

		weapon.isstuck = "enemy";
		weapon.stuckenemyentity = stuckto;
		stuckto maps\mp\gametypes\_hud_message::playercardsplashnotify("semtex_stuck", self);
		thread maps\mp\gametypes\_hud_message::splashnotify("stuck_semtex", 100);
		self notify("process", "ch_bullseye");
	}
}

turret_monitoruse()
{
	for(;;)
	{
		self waittill("trigger", player);
		thread turret_playerthread(player);
	}
}

turret_playerthread(player)
{
	player endon("death");
	player endon("disconnect");
	player notify("weapon_change", "none");
	self waittill("turret_deactivate");
	player notify("weapon_change", player getcurrentweapon());
}