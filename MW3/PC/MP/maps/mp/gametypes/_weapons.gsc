/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_weapons.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 111
 * Decompile Time: 1719 ms
 * Timestamp: 10/27/2023 2:13:05 AM
*******************************************************************/

//Function Number: 1
attachmentgroup(param_00)
{
	return tablelookup("mp/attachmentTable.csv",4,param_00,2);
}

//Function Number: 2
getattachmentlist()
{
	var_00 = [];
	var_01 = 0;
	var_02 = tablelookup("mp/attachmentTable.csv",9,var_01,4);
	while(var_02 != "")
	{
		var_00[var_00.size] = var_02;
		var_01++;
		var_02 = tablelookup("mp/attachmentTable.csv",9,var_01,4);
	}

	return common_scripts\utility::alphabetize(var_00);
}

//Function Number: 3
init()
{
	level.scavenger_altmode = 1;
	level.scavenger_secondary = 1;
	level.maxperplayerexplosives = max(maps\mp\_utility::getintproperty("scr_maxPerPlayerExplosives",2),1);
	level.riotshieldxpbullets = maps\mp\_utility::getintproperty("scr_riotShieldXPBullets",15);
	switch(maps\mp\_utility::getintproperty("perk_scavengerMode",0))
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

	var_00 = getattachmentlist();
	var_01 = 149;
	level.weaponlist = [];
	for(var_02 = 0;var_02 <= var_01;var_02++)
	{
		var_03 = tablelookup("mp/statstable.csv",0,var_02,4);
		if(var_03 == "")
		{
			continue;
		}

		if(!issubstr(tablelookup("mp/statsTable.csv",0,var_02,2),"weapon_"))
		{
			continue;
		}

		if(issubstr(var_03,"iw5_"))
		{
			var_04 = strtok(var_03,"_");
			var_03 = var_04[0] + "_" + var_04[1] + "_mp";
			level.weaponlist[level.weaponlist.size] = var_03;
			continue;
		}
		else
		{
			level.weaponlist[level.weaponlist.size] = var_03 + "_mp";
		}

		var_05 = [];
		for(var_06 = 0;var_06 < 10;var_06++)
		{
			var_07 = tablelookup("mp/statStable.csv",0,var_02,var_06 + 11);
			if(var_07 == "")
			{
				break;
			}

			var_05[var_07] = 1;
		}

		var_08 = [];
		foreach(var_07 in var_00)
		{
			if(!isdefined(var_05[var_07]))
			{
				continue;
			}

			level.weaponlist[level.weaponlist.size] = var_03 + "_" + var_07 + "_mp";
			var_08[var_08.size] = var_07;
		}

		var_0B = [];
		for(var_0C = 0;var_0C < var_08.size - 1;var_0C++)
		{
			var_0D = tablelookuprownum("mp/attachmentCombos.csv",0,var_08[var_0C]);
			for(var_0E = var_0C + 1;var_0E < var_08.size;var_0E++)
			{
				if(tablelookup("mp/attachmentCombos.csv",0,var_08[var_0E],var_0D) == "no")
				{
					continue;
				}

				var_0B[var_0B.size] = var_08[var_0C] + "_" + var_08[var_0E];
			}
		}

		foreach(var_10 in var_0B)
		{
			level.weaponlist[level.weaponlist.size] = var_03 + "_" + var_10 + "_mp";
		}
	}

	foreach(var_13 in level.weaponlist)
	{
		precacheitem(var_13);
	}

	precacheitem("flare_mp");
	precacheitem("scavenger_bag_mp");
	precacheitem("frag_grenade_short_mp");
	precacheitem("c4death_mp");
	precacheitem("destructible_car");
	precacheitem("destructible_toy");
	precacheitem("bouncingbetty_mp");
	precacheitem("scrambler_mp");
	precacheitem("portable_radar_mp");
	precacheshellshock("default");
	precacheshellshock("concussion_grenade_mp");
	thread maps\mp\_flashgrenades::main();
	thread maps\mp\_entityheadicons::init();
	thread lib_0348::init();
	var_16 = 70;
	level.claymoredetectiondot = cos(var_16);
	level.claymoredetectionmindist = 20;
	level.claymoredetectiongraceperiod = 0.75;
	level.claymoredetonateradius = 192;
	level.minedetectiongraceperiod = 0.3;
	level.minedetectionradius = 100;
	level.minedetectionheight = 20;
	level.minedamageradius = 256;
	level.minedamagemin = 70;
	level.minedamagemax = 210;
	level.minedamagehalfheight = 46;
	level.mineselfdestructtime = 120;
	level.mine_launch = loadfx("impacts/bouncing_betty_launch_dirt");
	level.mine_spin = loadfx("dust/bouncing_betty_swirl");
	level.mine_explode = loadfx("explosions/bouncing_betty_explosion");
	level.mine_beacon["enemy"] = loadfx("misc/light_c4_blink");
	level.mine_beacon["friendly"] = loadfx("misc/light_mine_blink_friendly");
	level.empgrenadeexplode = loadfx("explosions/emp_grenade");
	level.delayminetime = 3;
	level.sentry_fire = loadfx("muzzleflashes/shotgunflash");
	level.stingerfxid = loadfx("explosions/aerial_explosion_large");
	level.primary_weapon_array = [];
	level.side_arm_array = [];
	level.grenade_array = [];
	level.missile_array = [];
	level.inventory_array = [];
	level.mines = [];
	precachemodel("weapon_claymore_bombsquad");
	precachemodel("weapon_c4_bombsquad");
	precachemodel("projectile_m67fraggrenade_bombsquad");
	precachemodel("projectile_semtex_grenade_bombsquad");
	precachemodel("weapon_light_stick_tactical_bombsquad");
	precachemodel("projectile_bouncing_betty_grenade");
	precachemodel("projectile_bouncing_betty_grenade_bombsquad");
	precachemodel("projectile_bouncing_betty_trigger");
	precachemodel("weapon_jammer");
	precachemodel("weapon_jammer_bombsquad");
	precachemodel("weapon_radar");
	precachemodel("weapon_radar_bombsquad");
	precachemodel("mp_trophy_system");
	precachemodel("mp_trophy_system_bombsquad");
	level._effect["equipment_explode"] = loadfx("explosions/sparks_a");
	level._effect["sniperDustLarge"] = loadfx("dust/sniper_dust_kickup");
	level._effect["sniperDustSmall"] = loadfx("dust/sniper_dust_kickup_minimal");
	level._effect["sniperDustLargeSuppress"] = loadfx("dust/sniper_dust_kickup_accum_suppress");
	level._effect["sniperDustSmallSuppress"] = loadfx("dust/sniper_dust_kickup_accum_supress_minimal");
	level thread onplayerconnect();
	level.c4explodethisframe = 0;
	common_scripts\utility::array_thread(getentarray("misc_turret","classname"),::turret_monitoruse);
}

//Function Number: 4
func_2CB8()
{
	wait 5;
}

//Function Number: 5
bombsquadwaiter()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("grenade_fire",var_00,var_01);
		var_02 = level.otherteam[self.team];
		if(var_01 == "c4_mp")
		{
			var_00 thread createbombsquadmodel("weapon_c4_bombsquad","tag_origin",var_02,self);
			continue;
		}

		if(var_01 == "claymore_mp")
		{
			var_00 thread createbombsquadmodel("weapon_claymore_bombsquad","tag_origin",var_02,self);
			continue;
		}

		if(var_01 == "frag_grenade_mp")
		{
			var_00 thread createbombsquadmodel("projectile_m67fraggrenade_bombsquad","tag_weapon",var_02,self);
			continue;
		}

		if(var_01 == "frag_grenade_short_mp")
		{
			var_00 thread createbombsquadmodel("projectile_m67fraggrenade_bombsquad","tag_weapon",var_02,self);
			continue;
		}

		if(var_01 == "semtex_mp")
		{
			var_00 thread createbombsquadmodel("projectile_semtex_grenade_bombsquad","tag_weapon",var_02,self);
		}
	}
}

//Function Number: 6
createbombsquadmodel(param_00,param_01,param_02,param_03)
{
	var_04 = spawn("script_model",(0,0,0));
	var_04 hide();
	wait 0.05;
	if(!isdefined(self))
	{
		return;
	}

	var_04 thread bombsquadvisibilityupdater(param_02,param_03);
	var_04 setmodel(param_00);
	var_04 linkto(self,param_01,(0,0,0),(0,0,0));
	var_04 setcontents(0);
	self waittill("death");
	if(isdefined(self.trigger))
	{
		self.trigger delete();
	}

	var_04 delete();
}

//Function Number: 7
bombsquadvisibilityupdater(param_00,param_01)
{
	self endon("death");
	foreach(var_03 in level.players)
	{
		if(level.teambased)
		{
			if(var_03.team == param_00 && var_03 maps\mp\_utility::_hasperk("specialty_detectexplosive"))
			{
				self showtoplayer(var_03);
			}

			continue;
		}

		if(isdefined(param_01) && var_03 == param_01)
		{
			continue;
		}

		if(!var_03 maps\mp\_utility::_hasperk("specialty_detectexplosive"))
		{
			continue;
		}

		self showtoplayer(var_03);
	}

	for(;;)
	{
		level common_scripts\utility::waittill_any("joined_team","player_spawned","changed_kit","update_bombsquad");
		self hide();
		foreach(var_03 in level.players)
		{
			if(level.teambased)
			{
				if(var_03.team == param_00 && var_03 maps\mp\_utility::_hasperk("specialty_detectexplosive"))
				{
					self showtoplayer(var_03);
				}

				continue;
			}

			if(isdefined(param_01) && var_03 == param_01)
			{
				continue;
			}

			if(!var_03 maps\mp\_utility::_hasperk("specialty_detectexplosive"))
			{
				continue;
			}

			self showtoplayer(var_03);
		}
	}
}

//Function Number: 8
onplayerconnect()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_00.hits = 0;
		var_00.hasdonecombat = 0;
		var_00 kc_regweaponforfxremoval("remotemissile_projectile_mp");
		var_00 thread onplayerspawned();
		var_00 thread bombsquadwaiter();
		var_00 thread watchmissileusage();
		var_00 thread sniperdustwatcher();
	}
}

//Function Number: 9
onplayerspawned()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("spawned_player");
		self.currentweaponatspawn = self getcurrentweapon();
		self.empendtime = 0;
		self.concussionendtime = 0;
		self.hits = 0;
		self.hasdonecombat = 0;
		if(!isdefined(self.trackingweaponname))
		{
			self.trackingweaponname = "";
			self.trackingweaponname = "none";
			self.trackingweaponshots = 0;
			self.trackingweaponkills = 0;
			self.trackingweaponhits = 0;
			self.trackingweaponheadshots = 0;
			self.trackingweapondeaths = 0;
		}

		thread watchweaponusage();
		thread watchgrenadeusage();
		thread watchweaponchange();
		thread watchstingerusage();
		thread watchjavelinusage();
		thread watchsentryusage();
		thread func_2CD9();
		thread watchmineusage();
		thread maps\mp\gametypes\_class::trackriotshield();
		thread maps\mp\gametypes\_equipment::watchtrophyusage();
		thread stancerecoiladjuster();
		self.lasthittime = [];
		self.droppeddeathweapon = undefined;
		self.tookweaponfrom = [];
		thread updatesavedlastweapon();
		thread updateweaponrank();
		if(self hasweapon("semtex_mp"))
		{
			thread monitorsemtex();
		}

		self.currentweaponatspawn = undefined;
		self.trophyremainingammo = undefined;
	}
}

//Function Number: 10
sniperdustwatcher()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	var_00 = undefined;
	for(;;)
	{
		self waittill("weapon_fired");
		if(maps\mp\_utility::getweaponclass(self getcurrentweapon()) != "weapon_sniper")
		{
			continue;
		}

		if(self getstance() != "prone")
		{
			continue;
		}

		var_01 = anglestoforward(self.angles);
		if(!isdefined(var_00) || gettime() - var_00 > 2000)
		{
			playfx(level._effect["sniperDustLarge"],self.origin + (0,0,10) + var_01 * 50,var_01);
			var_00 = gettime();
			continue;
		}

		playfx(level._effect["sniperDustLargeSuppress"],self.origin + (0,0,10) + var_01 * 50,var_01);
	}
}

//Function Number: 11
watchstingerusage()
{
	maps\mp\_stinger::stingerusageloop();
}

//Function Number: 12
watchjavelinusage()
{
	maps\mp\_javelin::javelinusageloop();
}

//Function Number: 13
watchweaponchange()
{
	self endon("death");
	self endon("disconnect");
	self endon("faux_spawn");
	thread watchstartweaponchange();
	self.lastdroppableweapon = self.currentweaponatspawn;
	self.hitsthismag = [];
	var_00 = self getcurrentweapon();
	if(maps\mp\_utility::iscacprimaryweapon(var_00) && !isdefined(self.hitsthismag[var_00]))
	{
		self.hitsthismag[var_00] = weaponclipsize(var_00);
	}

	self.bothbarrels = undefined;
	if(issubstr(var_00,"ranger"))
	{
		thread watchrangerusage(var_00);
	}

	for(;;)
	{
		self waittill("weapon_change",var_01);
		if(var_01 == "none")
		{
			continue;
		}

		if(var_01 == "briefcase_bomb_mp" || var_01 == "briefcase_bomb_defuse_mp")
		{
			continue;
		}

		if(maps\mp\_utility::iskillstreakweapon(var_01))
		{
			if(maps\mp\_utility::isjuggernaut())
			{
				self.changingweapon = undefined;
			}

			continue;
		}

		var_02 = strtok(var_01,"_");
		self.bothbarrels = undefined;
		if(issubstr(var_01,"ranger"))
		{
			thread watchrangerusage(var_01);
		}

		if(var_02[0] == "alt")
		{
			var_03 = getsubstr(var_01,4);
			var_01 = var_03;
			var_02 = strtok(var_01,"_");
		}
		else if(var_02[0] != "iw5")
		{
			var_01 = var_02[0];
		}

		if(var_01 != "none" && var_02[0] != "iw5")
		{
			if(maps\mp\_utility::iscacprimaryweapon(var_01) && !isdefined(self.hitsthismag[var_01 + "_mp"]))
			{
				self.hitsthismag[var_01 + "_mp"] = weaponclipsize(var_01 + "_mp");
			}
		}
		else if(var_01 != "none" && var_02[0] == "iw5")
		{
			if(maps\mp\_utility::iscacprimaryweapon(var_01) && !isdefined(self.hitsthismag[var_01]))
			{
				self.hitsthismag[var_01] = weaponclipsize(var_01);
			}
		}

		self.changingweapon = undefined;
		if(var_02[0] == "iw5")
		{
			self.lastdroppableweapon = var_01;
		}
		else if(var_01 != "none" && maydropweapon(var_01 + "_mp"))
		{
			self.lastdroppableweapon = var_01 + "_mp";
		}

		if(isdefined(self.class_num))
		{
			if(var_02[0] != "iw5")
			{
				var_01 = var_01 + "_mp";
			}

			if(isdefined(self.loadoutprimarybuff) && self.loadoutprimarybuff != "specialty_null")
			{
				if(var_01 == self.primaryweapon && !maps\mp\_utility::_hasperk(self.loadoutprimarybuff))
				{
					maps\mp\_utility::giveperk(self.loadoutprimarybuff,1);
				}

				if(var_01 != self.primaryweapon && maps\mp\_utility::_hasperk(self.loadoutprimarybuff))
				{
					maps\mp\_utility::_unsetperk(self.loadoutprimarybuff);
				}
			}

			if(isdefined(self.loadoutsecondarybuff) && self.loadoutsecondarybuff != "specialty_null")
			{
				if(var_01 == self.secondaryweapon && !maps\mp\_utility::_hasperk(self.loadoutsecondarybuff))
				{
					maps\mp\_utility::giveperk(self.loadoutsecondarybuff,1);
				}

				if(var_01 != self.secondaryweapon && maps\mp\_utility::_hasperk(self.loadoutsecondarybuff))
				{
					maps\mp\_utility::_unsetperk(self.loadoutsecondarybuff);
				}
			}
		}
	}
}

//Function Number: 14
watchstartweaponchange()
{
	self endon("death");
	self endon("disconnect");
	self.changingweapon = undefined;
	for(;;)
	{
		self waittill("weapon_switch_started",var_00);
		self.changingweapon = var_00;
		if(var_00 == "none" && isdefined(self.iscapturingcrate) && self.iscapturingcrate)
		{
			while(self.iscapturingcrate)
			{
				wait 0.05;
			}

			self.changingweapon = undefined;
		}
	}
}

//Function Number: 15
func_2CD9()
{
	self endon("death");
	self endon("disconnect");
	self endon("faux_spawn");
	for(;;)
	{
		self waittill("reload");
		var_00 = self getcurrentweapon();
		self.bothbarrels = undefined;
		if(!issubstr(var_00,"ranger"))
		{
			continue;
		}

		thread watchrangerusage(var_00);
	}
}

//Function Number: 16
watchrangerusage(param_00)
{
	var_01 = self getweaponammoclip(param_00,"right");
	var_02 = self getweaponammoclip(param_00,"left");
	self endon("reload");
	self endon("weapon_change");
	for(;;)
	{
		self waittill("weapon_fired",var_03);
		if(var_03 != param_00)
		{
			continue;
		}

		self.bothbarrels = undefined;
		if(issubstr(param_00,"akimbo"))
		{
			var_04 = self getweaponammoclip(param_00,"left");
			var_05 = self getweaponammoclip(param_00,"right");
			if(var_02 != var_04 && var_01 != var_05)
			{
				self.bothbarrels = 1;
			}

			if(!var_04 || !var_05)
			{
				return;
			}

			var_02 = var_04;
			var_01 = var_05;
			continue;
		}

		if(var_01 == 2 && !self getweaponammoclip(param_00,"right"))
		{
			self.bothbarrels = 1;
			return;
		}
	}
}

//Function Number: 17
ishackweapon(param_00)
{
	if(param_00 == "radar_mp" || param_00 == "airstrike_mp" || param_00 == "helicopter_mp")
	{
		return 1;
	}

	if(param_00 == "briefcase_bomb_mp")
	{
		return 1;
	}

	return 0;
}

//Function Number: 18
maydropweapon(param_00)
{
	if(param_00 == "none")
	{
		return 0;
	}

	if(issubstr(param_00,"ac130"))
	{
		return 0;
	}

	if(issubstr(param_00,"uav"))
	{
		return 0;
	}

	if(issubstr(param_00,"killstreak"))
	{
		return 0;
	}

	var_01 = weaponinventorytype(param_00);
	if(var_01 != "primary")
	{
		return 0;
	}

	return 1;
}

//Function Number: 19
dropweaponfordeath(param_00)
{
	if(isdefined(level.blockweapondrops))
	{
		return;
	}

	if(isdefined(self.droppeddeathweapon))
	{
		return;
	}

	if(level.ingraceperiod)
	{
		return;
	}

	var_01 = self.lastdroppableweapon;
	if(!isdefined(var_01))
	{
		return;
	}

	if(var_01 == "none")
	{
		return;
	}

	if(!self hasweapon(var_01))
	{
		return;
	}

	if(maps\mp\_utility::isjuggernaut())
	{
		return;
	}

	var_02 = strtok(var_01,"_");
	if(var_02[0] == "alt")
	{
		for(var_03 = 0;var_03 < var_02.size;var_03++)
		{
			if(var_03 > 0 && var_03 < 2)
			{
				var_01 = var_01 + var_02[var_03];
				continue;
			}

			if(var_03 > 0)
			{
				var_01 = var_01 + "_" + var_02[var_03];
				continue;
			}

			var_01 = "";
		}
	}

	if(var_01 != "riotshield_mp")
	{
		if(!self anyammoforweaponmodes(var_01))
		{
			return;
		}

		var_04 = self getweaponammoclip(var_01,"right");
		var_05 = self getweaponammoclip(var_01,"left");
		if(!var_04 && !var_05)
		{
			return;
		}

		var_06 = self getweaponammostock(var_01);
		var_07 = weaponmaxammo(var_01);
		if(var_06 > var_07)
		{
			var_06 = var_07;
		}

		var_08 = self dropitem(var_01);
		if(!isdefined(var_08))
		{
			return;
		}

		var_08 itemweaponsetammo(var_04,var_06,var_05);
	}
	else
	{
		var_08 = self dropitem(var_02);
		if(!isdefined(var_08))
		{
			return;
		}

		var_08 itemweaponsetammo(1,1,0);
	}

	self.droppeddeathweapon = 1;
	var_08.owner = self;
	var_08.ownersattacker = param_00;
	var_08 thread watchpickup();
	var_08 thread deletepickupafterawhile();
}

//Function Number: 20
detachifattached(param_00,param_01)
{
	var_02 = self getattachsize();
	var_03 = 0;
	while(var_03 < var_02)
	{
		var_04 = self getattachmodelname(var_03);
		if(var_04 != param_00)
		{
			continue;
		}

		var_05 = self getattachtagname(var_03);
		self detach(param_00,var_05);
		if(var_05 != param_01)
		{
			var_02 = self getattachsize();
			for(var_03 = 0;var_03 < var_02;var_03++)
			{
				var_05 = self getattachtagname(var_03);
				if(var_05 != param_01)
				{
					continue;
				}

				param_00 = self getattachmodelname(var_03);
				self detach(param_00,var_05);
				break;
			}
		}

		return 1;
		var_04++;
	}

	return 0;
}

//Function Number: 21
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

//Function Number: 22
getitemweaponname()
{
	var_00 = self.classname;
	var_01 = getsubstr(var_00,7);
	return var_01;
}

//Function Number: 23
watchpickup()
{
	self endon("death");
	var_00 = getitemweaponname();
	for(;;)
	{
		self waittill("trigger",var_01,var_02);
		if(isdefined(var_02))
		{
			break;
		}
	}

	var_03 = var_02 getitemweaponname();
	if(isdefined(var_01.tookweaponfrom[var_03]))
	{
		var_02.owner = var_01.tookweaponfrom[var_03];
		var_02.ownersattacker = var_01;
		var_01.tookweaponfrom[var_03] = undefined;
	}

	var_02 thread watchpickup();
	if(isdefined(self.ownersattacker) && self.ownersattacker == var_01)
	{
		var_01.tookweaponfrom[var_00] = self.owner;
		return;
	}

	var_01.tookweaponfrom[var_00] = undefined;
}

//Function Number: 24
itemremoveammofromaltmodes()
{
	var_00 = getitemweaponname();
	var_01 = weaponaltweaponname(var_00);
	for(var_02 = 1;var_01 != "none" && var_01 != var_00;var_02++)
	{
		self itemweaponsetammo(0,0,0,var_02);
		var_01 = weaponaltweaponname(var_01);
	}
}

//Function Number: 25
handlescavengerbagpickup(param_00)
{
	self endon("death");
	level endon("game_ended");
	self waittill("scavenger",var_01);
	var_01 notify("scavenger_pickup");
	var_01 playlocalsound("scavenger_pack_pickup");
	var_02 = var_01 getweaponslistoffhands();
	foreach(var_04 in var_02)
	{
		if(var_04 != "throwingknife_mp")
		{
			continue;
		}

		var_05 = var_01 getweaponammoclip(var_04);
		var_01 setweaponammoclip(var_04,var_05 + 1);
	}

	var_07 = var_01 getweaponslistprimaries();
	foreach(var_09 in var_07)
	{
		if(!maps\mp\_utility::iscacprimaryweapon(var_09) && !level.scavenger_secondary)
		{
			continue;
		}

		if(issubstr(var_09,"alt") && issubstr(var_09,"m320") || issubstr(var_09,"gl") || issubstr(var_09,"gp25") || issubstr(var_09,"hybrid"))
		{
			continue;
		}

		if(maps\mp\_utility::getweaponclass(var_09) == "weapon_projectile")
		{
			continue;
		}

		var_0A = var_01 getweaponammostock(var_09);
		var_0B = weaponclipsize(var_09);
		var_01 setweaponammostock(var_09,var_0A + var_0B);
	}

	var_01 maps\mp\gametypes\_damagefeedback::updatedamagefeedback("scavenger");
}

//Function Number: 26
dropscavengerfordeath(param_00)
{
	if(level.ingraceperiod)
	{
		return;
	}

	if(!isdefined(param_00))
	{
		return;
	}

	if(param_00 == self)
	{
		return;
	}

	var_01 = self dropscavengerbag("scavenger_bag_mp");
	var_01 thread handlescavengerbagpickup(self);
}

//Function Number: 27
getweaponbasedgrenadecount(param_00)
{
	return 2;
}

//Function Number: 28
getweaponbasedsmokegrenadecount(param_00)
{
	return 1;
}

//Function Number: 29
getfraggrenadecount()
{
	var_00 = "frag_grenade_mp";
	var_01 = self getammocount(var_00);
	return var_01;
}

//Function Number: 30
getsmokegrenadecount()
{
	var_00 = "smoke_grenade_mp";
	var_01 = self getammocount(var_00);
	return var_01;
}

//Function Number: 31
setweaponstat(param_00,param_01,param_02)
{
	maps\mp\gametypes\_gamelogic::setweaponstat(param_00,param_01,param_02);
}

//Function Number: 32
watchweaponusage(param_00)
{
	self endon("death");
	self endon("disconnect");
	self endon("faux_spawn");
	level endon("game_ended");
	for(;;)
	{
		self waittill("weapon_fired",var_01);
		self.hasdonecombat = 1;
		if(!isprimaryweapon(var_01) && !issidearm(var_01))
		{
			continue;
		}

		if(isdefined(self.hitsthismag[var_01]))
		{
			thread updatemagshots(var_01);
		}

		var_02 = maps\mp\gametypes\_persistance::statgetbuffered("totalShots") + 1;
		var_03 = maps\mp\gametypes\_persistance::statgetbuffered("hits");
		var_04 = clamp(float(var_03) / float(var_02),0,1) * 10000;
		maps\mp\gametypes\_persistance::statsetbuffered("totalShots",var_02);
		maps\mp\gametypes\_persistance::statsetbuffered("accuracy",int(var_04));
		maps\mp\gametypes\_persistance::statsetbuffered("misses",int(var_02 - var_03));
		if(isdefined(self.laststandparams) && self.laststandparams.laststandstarttime == gettime())
		{
			self.hits = 0;
			return;
		}

		var_05 = 1;
		setweaponstat(var_01,var_05,"shots");
		setweaponstat(var_01,self.hits,"hits");
		self.hits = 0;
	}
}

//Function Number: 33
updatemagshots(param_00)
{
	self endon("death");
	self endon("disconnect");
	self endon("updateMagShots_" + param_00);
	self.hitsthismag[param_00]--;
	wait 0.05;
	self.hitsthismag[param_00] = weaponclipsize(param_00);
}

//Function Number: 34
checkhitsthismag(param_00)
{
	self endon("death");
	self endon("disconnect");
	self notify("updateMagShots_" + param_00);
	waittillframeend;
	if(isdefined(self.hitsthismag[param_00]) && self.hitsthismag[param_00] == 0)
	{
		var_01 = maps\mp\_utility::getweaponclass(param_00);
		maps\mp\gametypes\_missions::genericchallenge(var_01);
		self.hitsthismag[param_00] = weaponclipsize(param_00);
	}
}

//Function Number: 35
checkhit(param_00,param_01)
{
	if(maps\mp\_utility::isstrstart(param_00,"alt_"))
	{
		var_02 = strtok(param_00,"_");
		foreach(var_04 in var_02)
		{
			if(var_04 == "shotgun")
			{
				var_05 = getsubstr(param_00,0,4);
				if(!isprimaryweapon(var_05) && !issidearm(var_05))
				{
					self.hits = 1;
				}

				continue;
			}

			if(var_04 == "hybrid")
			{
				var_06 = getsubstr(param_00,4);
				param_00 = var_06;
			}
		}
	}

	if(!isprimaryweapon(param_00) && !issidearm(param_00))
	{
		return;
	}

	switch(weaponclass(param_00))
	{
		case "pistol":
		case "mg":
		case "smg":
		case "rifle":
			self.hits++;
			break;

		case "spread":
			self.hits = 1;
			break;

		default:
			break;
	}

	waittillframeend;
	if(isdefined(self.hitsthismag[param_00]))
	{
		thread checkhitsthismag(param_00);
	}

	if(!isdefined(self.lasthittime[param_00]))
	{
		self.lasthittime[param_00] = 0;
	}

	if(self.lasthittime[param_00] == gettime())
	{
		return;
	}

	self.lasthittime[param_00] = gettime();
	var_08 = maps\mp\gametypes\_persistance::statgetbuffered("totalShots");
	var_09 = maps\mp\gametypes\_persistance::statgetbuffered("hits") + 1;
	if(var_09 <= var_08)
	{
		maps\mp\gametypes\_persistance::statsetbuffered("hits",var_09);
		maps\mp\gametypes\_persistance::statsetbuffered("misses",int(var_08 - var_09));
		maps\mp\gametypes\_persistance::statsetbuffered("accuracy",int(var_09 * 10000 / var_08));
	}
}

//Function Number: 36
attackercandamageitem(param_00,param_01)
{
	return friendlyfirecheck(param_01,param_00);
}

//Function Number: 37
friendlyfirecheck(param_00,param_01,param_02)
{
	if(!isdefined(param_00))
	{
		return 1;
	}

	if(!level.teambased)
	{
		return 1;
	}

	var_03 = param_01.team;
	var_04 = level.friendlyfire;
	if(isdefined(param_02))
	{
		var_04 = param_02;
	}

	if(var_04 != 0)
	{
		return 1;
	}

	if(param_01 == param_00)
	{
		return 1;
	}

	if(!isdefined(var_03))
	{
		return 1;
	}

	if(var_03 != param_00.team)
	{
		return 1;
	}

	return 0;
}

//Function Number: 38
watchgrenadeusage()
{
	self endon("death");
	self endon("disconnect");
	self endon("faux_spawn");
	self.throwinggrenade = undefined;
	self.gotpullbacknotify = 0;
	if(maps\mp\_utility::getintproperty("scr_deleteexplosivesonspawn",1) == 1)
	{
		if(isdefined(self.c4array))
		{
			for(var_00 = 0;var_00 < self.c4array.size;var_00++)
			{
				if(isdefined(self.c4array[var_00]))
				{
					if(isdefined(self.c4array[var_00].trigger))
					{
						self.c4array[var_00].trigger delete();
					}

					self.c4array[var_00] delete();
				}
			}
		}

		self.c4array = [];
		if(isdefined(self.claymorearray))
		{
			for(var_00 = 0;var_00 < self.claymorearray.size;var_00++)
			{
				if(isdefined(self.claymorearray[var_00]))
				{
					if(isdefined(self.claymorearray[var_00].trigger))
					{
						self.claymorearray[var_00].trigger delete();
					}

					self.claymorearray[var_00] delete();
				}
			}
		}

		self.claymorearray = [];
		if(isdefined(self.bouncingbettyarray))
		{
			for(var_00 = 0;var_00 < self.bouncingbettyarray.size;var_00++)
			{
				if(isdefined(self.bouncingbettyarray[var_00]))
				{
					if(isdefined(self.bouncingbettyarray[var_00].trigger))
					{
						self.bouncingbettyarray[var_00].trigger delete();
					}

					self.bouncingbettyarray[var_00] delete();
				}
			}
		}

		self.bouncingbettyarray = [];
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

		if(!isdefined(self.bouncingbettyarray))
		{
			self.bouncingbettyarray = [];
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
		self waittill("grenade_pullback",var_01);
		setweaponstat(var_01,1,"shots");
		self.hasdonecombat = 1;
		if(var_01 == "claymore_mp")
		{
			continue;
		}

		self.throwinggrenade = var_01;
		self.gotpullbacknotify = 1;
		if(var_01 == "c4_mp")
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

//Function Number: 39
begingrenadetracking()
{
	self endon("death");
	self endon("disconnect");
	self endon("offhand_end");
	self endon("weapon_change");
	var_00 = gettime();
	self waittill("grenade_fire",var_01,var_02);
	if(gettime() - var_00 > 1000 && var_02 == "frag_grenade_mp")
	{
		var_01.iscooked = 1;
	}

	self.changingweapon = undefined;
	var_01.owner = self;
	switch(var_02)
	{
		case "semtex_mp":
		case "frag_grenade_mp":
			var_01 thread maps\mp\gametypes\_shellshock::grenade_earthquake();
			var_01.originalowner = self;
			break;

		case "flash_grenade_mp":
		case "concussion_grenade_mp":
			var_01 thread empexplodewaiter();
			break;

		case "smoke_grenade_mp":
			var_01 thread watchsmokeexplode();
			break;
	}
}

//Function Number: 40
watchsmokeexplode()
{
	level endon("smokeTimesUp");
	var_00 = self.owner;
	var_00 endon("disconnect");
	self waittill("explode",var_01);
	var_02 = 128;
	var_03 = 8;
	level thread func_2CFD(var_03,var_02,var_01);
	for(;;)
	{
		if(!isdefined(var_00))
		{
			break;
		}

		foreach(var_05 in level.players)
		{
			if(!isdefined(var_05))
			{
				continue;
			}

			if(level.teambased && var_05.team == var_00.team)
			{
				continue;
			}

			if(distancesquared(var_05.origin,var_01) < var_02 * var_02)
			{
				var_05.inplayersmokescreen = var_00;
				continue;
			}

			var_05.inplayersmokescreen = undefined;
		}

		wait 0.05;
	}
}

//Function Number: 41
func_2CFD(param_00,param_01,param_02)
{
	maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(param_00);
	level notify("smokeTimesUp");
	waittillframeend;
	foreach(var_04 in level.players)
	{
		if(isdefined(var_04))
		{
			var_04.inplayersmokescreen = undefined;
		}
	}
}

//Function Number: 42
addmissiletosighttraces(param_00)
{
	self.team = param_00;
	level.missilesforsighttraces[level.missilesforsighttraces.size] = self;
	self waittill("death");
	var_01 = [];
	foreach(var_03 in level.missilesforsighttraces)
	{
		if(var_03 != self)
		{
			var_01[var_01.size] = var_03;
		}
	}

	level.missilesforsighttraces = var_01;
}

//Function Number: 43
watchmissileusage()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("missile_fire",var_00,var_01);
		if(issubstr(var_01,"gl_"))
		{
			var_00.primaryweapon = self getcurrentprimaryweapon();
			var_00 thread maps\mp\gametypes\_shellshock::grenade_earthquake();
		}

		switch(var_01)
		{
			case "at4_mp":
			case "iw5_smaw_mp":
			case "stinger_mp":
				level notify("stinger_fired",self,var_00,self.stingertarget);
				thread maps\mp\_utility::setaltsceneobj(var_00,"tag_origin",65);
				break;
	
			case "javelin_mp":
			case "remote_mortar_missile_mp":
			case "uav_strike_projectile_mp":
				level notify("stinger_fired",self,var_00,self.javelintarget);
				thread maps\mp\_utility::setaltsceneobj(var_00,"tag_origin",65);
				break;
	
			default:
				break;
		}

		switch(var_01)
		{
			case "rpg_mp":
			case "at4_mp":
			case "javelin_mp":
			case "iw5_smaw_mp":
			case "remote_mortar_missile_mp":
			case "uav_strike_projectile_mp":
			case "remotemissile_projectile_mp":
			case "ac130_40mm_mp":
			case "ac130_105mm_mp":
				var_00 thread maps\mp\gametypes\_shellshock::grenade_earthquake();
				break;
	
			default:
				break;
		}
	}
}

//Function Number: 44
watchsentryusage()
{
	self endon("death");
	self endon("disconnect");
	self endon("faux_spawn");
	for(;;)
	{
		self waittill("sentry_placement_finished",var_00);
		thread maps\mp\_utility::setaltsceneobj(var_00,"tag_flash",65);
	}
}

//Function Number: 45
empexplodewaiter()
{
	thread maps\mp\gametypes\_shellshock::endondeath();
	self endon("end_explode");
	self waittill("explode",var_00);
	var_01 = getempdamageents(var_00,512,0);
	foreach(var_03 in var_01)
	{
		if(isdefined(var_03.owner) && !friendlyfirecheck(self.owner,var_03.owner))
		{
			continue;
		}

		var_03 notify("emp_damage",self.owner,8);
	}
}

//Function Number: 46
beginc4tracking()
{
	self endon("death");
	self endon("disconnect");
	common_scripts\utility::waittill_any("grenade_fire","weapon_change","offhand_end");
	self.changingweapon = undefined;
}

//Function Number: 47
watchforthrowbacks()
{
	self endon("death");
	self endon("disconnect");
	for(;;)
	{
		self waittill("grenade_fire",var_00,var_01);
		if(self.gotpullbacknotify)
		{
			self.gotpullbacknotify = 0;
			continue;
		}

		if(!issubstr(var_01,"frag_") && !issubstr(var_01,"semtex_"))
		{
			continue;
		}

		var_00.threwback = 1;
		thread maps\mp\_utility::incplayerstat("throwbacks",1);
		var_00 thread maps\mp\gametypes\_shellshock::grenade_earthquake();
		var_00.originalowner = self;
	}
}

//Function Number: 48
watchc4()
{
	self endon("spawned_player");
	self endon("disconnect");
	for(;;)
	{
		self waittill("grenade_fire",var_00,var_01);
		if(var_01 == "c4" || var_01 == "c4_mp")
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

			self.c4array[self.c4array.size] = var_00;
			var_00.owner = self;
			var_00.team = self.team;
			var_00.activated = 0;
			var_00.weaponname = var_01;
			var_00 thread maps\mp\gametypes\_shellshock::c4_earthquake();
			var_00 thread c4activate();
			var_00 thread c4damage();
			var_00 thread c4empdamage();
			var_00 thread c4empkillstreakwait();
			var_00 waittill("missile_stuck");
			var_00.trigger = spawn("script_origin",var_00.origin);
			var_00 thread equipmentwatchuse(self);
		}
	}
}

//Function Number: 49
c4empdamage()
{
	self endon("death");
	for(;;)
	{
		self waittill("emp_damage",var_00,var_01);
		playfxontag(common_scripts\utility::getfx("sentry_explode_mp"),self,"tag_origin");
		self.disabled = 1;
		self notify("disabled");
		wait var_01;
		self.disabled = undefined;
		self notify("enabled");
	}
}

//Function Number: 50
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

//Function Number: 51
setclaymoreteamheadicon(param_00)
{
	self endon("death");
	wait 0.05;
	if(level.teambased)
	{
		maps\mp\_entityheadicons::setteamheadicon(param_00,(0,0,20));
		return;
	}

	if(isdefined(self.owner))
	{
		maps\mp\_entityheadicons::setplayerheadicon(self.owner,(0,0,20));
	}
}

//Function Number: 52
watchclaymores()
{
	self endon("spawned_player");
	self endon("disconnect");
	self.claymorearray = [];
	for(;;)
	{
		self waittill("grenade_fire",var_00,var_01);
		if(var_01 == "claymore" || var_01 == "claymore_mp")
		{
			if(!isalive(self))
			{
				var_00 delete();
				return;
			}

			var_00 hide();
			var_00 waittill("missile_stuck");
			var_02 = 40;
			if(var_02 * var_02 < distancesquared(var_00.origin,self.origin))
			{
				var_03 = bullettrace(self.origin,self.origin - (0,0,var_02),0,self);
				if(var_03["fraction"] == 1)
				{
					var_00 delete();
					self setweaponammostock("claymore_mp",self getweaponammostock("claymore_mp") + 1);
					continue;
				}

				var_00.origin = var_03["position"];
			}

			var_00 show();
			self.claymorearray = common_scripts\utility::array_removeundefined(self.claymorearray);
			if(self.claymorearray.size >= level.maxperplayerexplosives)
			{
				self.claymorearray[0] detonate();
			}

			self.claymorearray[self.claymorearray.size] = var_00;
			var_00.owner = self;
			var_00.team = self.team;
			var_00.weaponname = var_01;
			var_00.trigger = spawn("script_origin",var_00.origin);
			level.mines[level.mines.size] = var_00;
			var_00 thread c4damage();
			var_00 thread c4empdamage();
			var_00 thread c4empkillstreakwait();
			var_00 thread claymoredetonation();
			var_00 thread equipmentwatchuse(self);
			var_00 thread setclaymoreteamheadicon(self.pers["team"]);
			self.changingweapon = undefined;
		}
	}
}

//Function Number: 53
equipmentwatchuse(param_00)
{
	self endon("spawned_player");
	self endon("disconnect");
	self.trigger setcursorhint("HINT_NOICON");
	if(self.weaponname == "c4_mp")
	{
		self.trigger sethintstring(&"MP_PICKUP_C4");
	}
	else if(self.weaponname == "claymore_mp")
	{
		self.trigger sethintstring(&"MP_PICKUP_CLAYMORE");
	}
	else if(self.weaponname == "bouncingbetty_mp")
	{
		self.trigger sethintstring(&"MP_PICKUP_BOUNCING_BETTY");
	}

	self.trigger maps\mp\_utility::setselfusable(param_00);
	self.trigger thread maps\mp\_utility::notusableforjoiningplayers(self);
	for(;;)
	{
		self.trigger waittill("trigger",param_00);
		param_00 playlocalsound("scavenger_pack_pickup");
		param_00 setweaponammostock(self.weaponname,param_00 getweaponammostock(self.weaponname) + 1);
		self.trigger delete();
		self delete();
		self notify("death");
	}
}

//Function Number: 54
claymoredetonation()
{
	self endon("death");
	var_00 = spawn("trigger_radius",self.origin + (0,0,0 - level.claymoredetonateradius),0,level.claymoredetonateradius,level.claymoredetonateradius * 2);
	thread deleteondeath(var_00);
	for(;;)
	{
		var_00 waittill("trigger",var_01);
		if(getdvarint("scr_claymoredebug") != 1)
		{
			if(isdefined(self.owner) && var_01 == self.owner)
			{
				continue;
			}

			if(!friendlyfirecheck(self.owner,var_01,0))
			{
				continue;
			}
		}

		if(lengthsquared(var_01 getentityvelocity()) < 10)
		{
			continue;
		}

		var_02 = abs(var_01.origin[2] - self.origin[2]);
		if(var_02 > 128)
		{
			continue;
		}

		if(!var_01 shouldaffectclaymore(self))
		{
			continue;
		}

		if(var_01 damageconetrace(self.origin,self) > 0)
		{
			break;
		}
	}

	self playsound("claymore_activated");
	if(isplayer(var_01) && var_01 maps\mp\_utility::_hasperk("specialty_delaymine"))
	{
		var_01 notify("triggered_claymore");
		wait level.delayminetime;
	}
	else
	{
		wait level.claymoredetectiongraceperiod;
	}

	if(isdefined(self.trigger))
	{
		self.trigger delete();
	}

	self detonate();
}

//Function Number: 55
shouldaffectclaymore(param_00)
{
	if(isdefined(param_00.disabled))
	{
		return 0;
	}

	var_01 = self.origin + (0,0,32);
	var_02 = var_01 - param_00.origin;
	var_03 = anglestoforward(param_00.angles);
	var_04 = vectordot(var_02,var_03);
	if(var_04 < level.claymoredetectionmindist)
	{
		return 0;
	}

	var_02 = vectornormalize(var_02);
	var_05 = vectordot(var_02,var_03);
	return var_05 > level.claymoredetectiondot;
}

//Function Number: 56
deleteondeath(param_00)
{
	self waittill("death");
	wait 0.05;
	if(isdefined(param_00))
	{
		if(isdefined(param_00.trigger))
		{
			param_00.trigger delete();
		}

		param_00 delete();
	}
}

//Function Number: 57
c4activate()
{
	self endon("death");
	self waittill("missile_stuck");
	wait 0.05;
	self notify("activated");
	self.activated = 1;
}

//Function Number: 58
watchc4altdetonate()
{
	self endon("death");
	self endon("disconnect");
	self endon("detonated");
	level endon("game_ended");
	var_00 = 0;
	for(;;)
	{
		if(self usebuttonpressed())
		{
			var_00 = 0;
			while(self usebuttonpressed())
			{
				var_00 = var_00 + 0.05;
				wait 0.05;
			}

			if(var_00 >= 0.5)
			{
				continue;
			}

			var_00 = 0;
			while(!self usebuttonpressed() && var_00 < 0.5)
			{
				var_00 = var_00 + 0.05;
				wait 0.05;
			}

			if(var_00 >= 0.5)
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

//Function Number: 59
watchc4detonation()
{
	self endon("death");
	self endon("disconnect");
	for(;;)
	{
		self waittillmatch("c4_mp","detonate");
		var_00 = [];
		for(var_01 = 0;var_01 < self.c4array.size;var_01++)
		{
			var_02 = self.c4array[var_01];
			if(isdefined(self.c4array[var_01]))
			{
				var_02 thread waitanddetonate(0.1);
			}
		}

		self.c4array = var_00;
		self notify("detonated");
	}
}

//Function Number: 60
watchc4altdetonation()
{
	self endon("death");
	self endon("disconnect");
	for(;;)
	{
		self waittill("alt_detonate");
		var_00 = self getcurrentweapon();
		if(var_00 != "c4_mp")
		{
			var_01 = [];
			for(var_02 = 0;var_02 < self.c4array.size;var_02++)
			{
				var_03 = self.c4array[var_02];
				if(isdefined(self.c4array[var_02]))
				{
					var_03 thread waitanddetonate(0.1);
				}
			}

			self.c4array = var_01;
			self notify("detonated");
		}
	}
}

//Function Number: 61
waitanddetonate(param_00)
{
	self endon("death");
	wait param_00;
	waittillenabled();
	self detonate();
}

//Function Number: 62
deletec4andclaymoresondisconnect()
{
	self endon("death");
	self waittill("disconnect");
	var_00 = self.c4array;
	var_01 = self.claymorearray;
	wait 0.05;
	for(var_02 = 0;var_02 < var_00.size;var_02++)
	{
		if(isdefined(var_00[var_02]))
		{
			var_00[var_02] delete();
		}
	}

	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		if(isdefined(var_01[var_02]))
		{
			var_01[var_02] delete();
		}
	}
}

//Function Number: 63
c4damage()
{
	self endon("death");
	self setcandamage(1);
	self.maxhealth = 100000;
	self.health = self.maxhealth;
	var_00 = undefined;
	for(;;)
	{
		self waittill("damage",var_01,var_00,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09);
		if(!isplayer(var_00))
		{
			continue;
		}

		if(!friendlyfirecheck(self.owner,var_00))
		{
			continue;
		}

		if(isdefined(var_09))
		{
			switch(var_09)
			{
				case "flash_grenade_mp":
				case "smoke_grenade_mp":
				case "concussion_grenade_mp":
					break;
			}
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
	if(isdefined(var_04) && issubstr(var_04,"MOD_GRENADE") || issubstr(var_04,"MOD_EXPLOSIVE"))
	{
		self.waschained = 1;
	}

	if(isdefined(var_08) && var_08 & level.idflags_penetration)
	{
		self.wasdamagedfrombulletpenetration = 1;
	}

	self.wasdamaged = 1;
	if(isplayer(var_00))
	{
		var_00 maps\mp\gametypes\_damagefeedback::updatedamagefeedback("c4");
	}

	if(level.teambased)
	{
		if(isdefined(var_00) && isdefined(var_00.pers["team"]) && isdefined(self.owner) && isdefined(self.owner.pers["team"]))
		{
			if(var_00.pers["team"] != self.owner.pers["team"])
			{
				var_00 notify("destroyed_explosive");
			}
		}
	}
	else if(isdefined(self.owner) && isdefined(var_00) && var_00 != self.owner)
	{
		var_00 notify("destroyed_explosive");
	}

	if(isdefined(self.trigger))
	{
		self.trigger delete();
	}

	self detonate(var_00);
}

//Function Number: 64
resetc4explodethisframe()
{
	wait 0.05;
	level.c4explodethisframe = 0;
}

//Function Number: 65
saydamaged(param_00,param_01)
{
	for(var_02 = 0;var_02 < 60;var_02++)
	{
		wait 0.05;
	}
}

//Function Number: 66
waittillenabled()
{
	if(!isdefined(self.disabled))
	{
		return;
	}

	self waittill("enabled");
}

//Function Number: 67
c4detectiontrigger(param_00)
{
	self waittill("activated");
	var_01 = spawn("trigger_radius",self.origin - (0,0,128),0,512,256);
	var_01.detectid = "trigger" + gettime() + randomint(1000000);
	var_01.owner = self;
	var_01 thread detecticonwaiter(level.otherteam[param_00]);
	self waittill("death");
	var_01 notify("end_detection");
	if(isdefined(var_01.bombsquadicon))
	{
		var_01.bombsquadicon destroy();
	}

	var_01 delete();
}

//Function Number: 68
claymoredetectiontrigger(param_00)
{
	var_01 = spawn("trigger_radius",self.origin - (0,0,128),0,512,256);
	var_01.detectid = "trigger" + gettime() + randomint(1000000);
	var_01.owner = self;
	var_01 thread detecticonwaiter(level.otherteam[param_00]);
	self waittill("death");
	var_01 notify("end_detection");
	if(isdefined(var_01.bombsquadicon))
	{
		var_01.bombsquadicon destroy();
	}

	var_01 delete();
}

//Function Number: 69
detecticonwaiter(param_00)
{
	self endon("end_detection");
	level endon("game_ended");
	while(!level.gameended)
	{
		self waittill("trigger",var_01);
		if(!var_01.detectexplosives)
		{
			continue;
		}

		if(level.teambased && var_01.team != param_00)
		{
			continue;
		}
		else if(!level.teambased && var_01 == self.owner.owner)
		{
			continue;
		}

		if(isdefined(var_01.bombsquadids[self.detectid]))
		{
			continue;
		}

		var_01 thread showheadicon(self);
	}
}

//Function Number: 70
setupbombsquad()
{
	self.bombsquadids = [];
	if(self.detectexplosives && !self.bombsquadicons.size)
	{
		for(var_00 = 0;var_00 < 4;var_00++)
		{
			self.bombsquadicons[var_00] = newclienthudelem(self);
			self.bombsquadicons[var_00].x = 0;
			self.bombsquadicons[var_00].y = 0;
			self.bombsquadicons[var_00].z = 0;
			self.bombsquadicons[var_00].alpha = 0;
			self.bombsquadicons[var_00].archived = 1;
			self.bombsquadicons[var_00] setshader("waypoint_bombsquad",14,14);
			self.bombsquadicons[var_00] setwaypoint(0,0);
			self.bombsquadicons[var_00].detectid = "";
		}

		return;
	}

	if(!self.detectexplosives)
	{
		for(var_00 = 0;var_00 < self.bombsquadicons.size;var_00++)
		{
			self.bombsquadicons[var_00] destroy();
		}

		self.bombsquadicons = [];
	}
}

//Function Number: 71
showheadicon(param_00)
{
	var_01 = param_00.detectid;
	var_02 = -1;
	for(var_03 = 0;var_03 < 4;var_03++)
	{
		var_04 = self.bombsquadicons[var_03].detectid;
		if(var_04 == var_01)
		{
			return;
		}

		if(var_04 == "")
		{
			var_02 = var_03;
		}
	}

	if(var_02 < 0)
	{
		return;
	}

	self.bombsquadids[var_01] = 1;
	self.bombsquadicons[var_02].x = param_00.origin[0];
	self.bombsquadicons[var_02].y = param_00.origin[1];
	self.bombsquadicons[var_02].z = param_00.origin[2] + 24 + 128;
	self.bombsquadicons[var_02] fadeovertime(0.25);
	self.bombsquadicons[var_02].alpha = 1;
	self.bombsquadicons[var_02].detectid = param_00.detectid;
	while(isalive(self) && isdefined(param_00) && self istouching(param_00))
	{
		wait 0.05;
	}

	if(!isdefined(self))
	{
		return;
	}

	self.bombsquadicons[var_02].detectid = "";
	self.bombsquadicons[var_02] fadeovertime(0.25);
	self.bombsquadicons[var_02].alpha = 0;
	self.bombsquadids[var_01] = undefined;
}

//Function Number: 72
getdamageableents(param_00,param_01,param_02,param_03)
{
	var_04 = [];
	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	if(!isdefined(param_03))
	{
		param_03 = 0;
	}

	var_05 = param_01 * param_01;
	var_06 = level.players;
	for(var_07 = 0;var_07 < var_06.size;var_07++)
	{
		if(!isalive(var_06[var_07]) || var_06[var_07].sessionstate != "playing")
		{
			continue;
		}

		var_08 = maps\mp\_utility::get_damageable_player_pos(var_06[var_07]);
		var_09 = distancesquared(param_00,var_08);
		if(var_09 < var_05 && !param_02 || weapondamagetracepassed(param_00,var_08,param_03,var_06[var_07]))
		{
			var_04[var_04.size] = maps\mp\_utility::get_damageable_player(var_06[var_07],var_08);
		}
	}

	var_0A = getentarray("grenade","classname");
	for(var_07 = 0;var_07 < var_0A.size;var_07++)
	{
		var_0B = maps\mp\_utility::get_damageable_grenade_pos(var_0A[var_07]);
		var_09 = distancesquared(param_00,var_0B);
		if(var_09 < var_05 && !param_02 || weapondamagetracepassed(param_00,var_0B,param_03,var_0A[var_07]))
		{
			var_04[var_04.size] = maps\mp\_utility::get_damageable_grenade(var_0A[var_07],var_0B);
		}
	}

	var_0C = getentarray("destructible","targetname");
	for(var_07 = 0;var_07 < var_0C.size;var_07++)
	{
		var_0B = var_0C[var_07].origin;
		var_09 = distancesquared(param_00,var_0B);
		if(var_09 < var_05 && !param_02 || weapondamagetracepassed(param_00,var_0B,param_03,var_0C[var_07]))
		{
			var_0D = spawnstruct();
			var_0D.isplayer = 0;
			var_0D.isadestructable = 0;
			var_0D.entity = var_0C[var_07];
			var_0D.damagecenter = var_0B;
			var_04[var_04.size] = var_0D;
		}
	}

	var_0E = getentarray("destructable","targetname");
	for(var_07 = 0;var_07 < var_0E.size;var_07++)
	{
		var_0B = var_0E[var_07].origin;
		var_09 = distancesquared(param_00,var_0B);
		if(var_09 < var_05 && !param_02 || weapondamagetracepassed(param_00,var_0B,param_03,var_0E[var_07]))
		{
			var_0D = spawnstruct();
			var_0D.isplayer = 0;
			var_0D.isadestructable = 1;
			var_0D.entity = var_0E[var_07];
			var_0D.damagecenter = var_0B;
			var_04[var_04.size] = var_0D;
		}
	}

	var_0F = getentarray("misc_turret","classname");
	foreach(var_11 in var_0F)
	{
		var_0B = var_11.origin + (0,0,32);
		var_09 = distancesquared(param_00,var_0B);
		if(var_09 < var_05 && !param_02 || weapondamagetracepassed(param_00,var_0B,param_03,var_11))
		{
			switch(var_11.model)
			{
				case "vehicle_ugv_talon_gun_mp":
				case "mp_remote_turret":
				case "mp_sam_turret":
				case "sentry_minigun_weak":
					var_04[var_04.size] = maps\mp\_utility::get_damageable_sentry(var_11,var_0B);
					break;
			}
		}
	}

	var_13 = getentarray("script_model","classname");
	foreach(var_15 in var_13)
	{
		if(var_15.model != "projectile_bouncing_betty_grenade" && var_15.model != "ims_scorpion_body")
		{
			continue;
		}

		var_0B = var_15.origin + (0,0,32);
		var_09 = distancesquared(param_00,var_0B);
		if(var_09 < var_05 && !param_02 || weapondamagetracepassed(param_00,var_0B,param_03,var_15))
		{
			var_04[var_04.size] = maps\mp\_utility::get_damageable_mine(var_15,var_0B);
		}
	}

	return var_04;
}

//Function Number: 73
getempdamageents(param_00,param_01,param_02,param_03)
{
	var_04 = [];
	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	if(!isdefined(param_03))
	{
		param_03 = 0;
	}

	var_05 = getentarray("grenade","classname");
	foreach(var_07 in var_05)
	{
		var_08 = var_07.origin;
		var_09 = distance(param_00,var_08);
		if(var_09 < param_01 && !param_02 || weapondamagetracepassed(param_00,var_08,param_03,var_07))
		{
			var_04[var_04.size] = var_07;
		}
	}

	var_0B = getentarray("misc_turret","classname");
	foreach(var_0D in var_0B)
	{
		var_08 = var_0D.origin;
		var_09 = distance(param_00,var_08);
		if(var_09 < param_01 && !param_02 || weapondamagetracepassed(param_00,var_08,param_03,var_0D))
		{
			var_04[var_04.size] = var_0D;
		}
	}

	return var_04;
}

//Function Number: 74
weapondamagetracepassed(param_00,param_01,param_02,param_03)
{
	var_04 = undefined;
	var_05 = param_01 - param_00;
	if(lengthsquared(var_05) < param_02 * param_02)
	{
		return 1;
	}

	var_06 = vectornormalize(var_05);
	var_04 = param_00 + (var_06[0] * param_02,var_06[1] * param_02,var_06[2] * param_02);
	var_07 = bullettrace(var_04,param_01,0,param_03);
	if(getdvarint("scr_damage_debug") != 0 || getdvarint("scr_debugMines") != 0)
	{
		thread debugprint(param_00,".dmg");
		if(isdefined(param_03))
		{
			thread debugprint(param_01,"." + param_03.classname);
		}
		else
		{
			thread debugprint(param_01,".undefined");
		}

		if(var_07["fraction"] == 1)
		{
			thread debugline(var_04,param_01,(1,1,1));
		}
		else
		{
			thread debugline(var_04,var_07["position"],(1,0.9,0.8));
			thread debugline(var_07["position"],param_01,(1,0.4,0.3));
		}
	}

	return var_07["fraction"] == 1;
}

//Function Number: 75
damageent(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	if(self.isplayer)
	{
		self.damageorigin = param_05;
		self.entity thread [[ level.callbackplayerdamage ]](param_00,param_01,param_02,0,param_03,param_04,param_05,param_06,"none",0);
		return;
	}

	if(self.isadestructable && param_04 == "artillery_mp" || param_04 == "claymore_mp" || param_04 == "stealth_bomb_mp")
	{
		return;
	}

	self.entity notify("damage",param_02,param_01,(0,0,0),(0,0,0),"MOD_EXPLOSIVE","","","",undefined,param_04);
}

//Function Number: 76
debugline(param_00,param_01,param_02)
{
	for(var_03 = 0;var_03 < 600;var_03++)
	{
		wait 0.05;
	}
}

//Function Number: 77
debugcircle(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_03))
	{
		param_03 = 16;
	}

	var_04 = 360 / param_03;
	var_05 = [];
	for(var_06 = 0;var_06 < param_03;var_06++)
	{
		var_07 = var_04 * var_06;
		var_08 = cos(var_07) * param_01;
		var_09 = sin(var_07) * param_01;
		var_0A = param_00[0] + var_08;
		var_0B = param_00[1] + var_09;
		var_0C = param_00[2];
		var_05[var_05.size] = (var_0A,var_0B,var_0C);
	}

	for(var_06 = 0;var_06 < var_05.size;var_06++)
	{
		var_0D = var_05[var_06];
		if(var_06 + 1 >= var_05.size)
		{
			var_0E = var_05[0];
		}
		else
		{
			var_0E = var_05[var_06 + 1];
		}

		thread debugline(var_0D,var_0E,param_02);
	}
}

//Function Number: 78
debugprint(param_00,param_01)
{
	for(var_02 = 0;var_02 < 600;var_02++)
	{
		wait 0.05;
	}
}

//Function Number: 79
onweapondamage(param_00,param_01,param_02,param_03,param_04)
{
	self endon("death");
	self endon("disconnect");
	switch(param_01)
	{
		case "concussion_grenade_mp":
			if(!isdefined(param_00))
			{
				return;
			}
			else if(param_02 == "MOD_IMPACT")
			{
				return;
			}
	
			var_05 = 1;
			if(isdefined(param_00.owner) && param_00.owner == param_04)
			{
				var_05 = 0;
			}
	
			var_06 = 512;
			var_07 = 1 - distance(self.origin,param_00.origin) / var_06;
			if(var_07 < 0)
			{
				var_07 = 0;
			}
	
			var_08 = 2 + 4 * var_07;
			if(isdefined(self.stunscaler))
			{
				var_08 = var_08 * self.stunscaler;
			}
	
			wait 0.05;
			param_04 notify("stun_hit");
			self notify("concussed",param_04);
			if(param_04 != self)
			{
				param_04 maps\mp\gametypes\_missions::processchallenge("ch_alittleconcussed");
			}
	
			self shellshock("concussion_grenade_mp",var_08);
			self.concussionendtime = gettime() + var_08 * 1000;
			if(var_05)
			{
				param_04 thread maps\mp\gametypes\_damagefeedback::updatedamagefeedback("stun");
			}
			break;

		case "weapon_cobra_mk19_mp":
			break;

		default:
			maps\mp\gametypes\_shellshock::shellshockondamage(param_02,param_03);
			break;
	}
}

//Function Number: 80
isprimaryweapon(param_00)
{
	if(param_00 == "none")
	{
		return 0;
	}

	if(weaponinventorytype(param_00) != "primary")
	{
		return 0;
	}

	switch(weaponclass(param_00))
	{
		case "sniper":
		case "rocketlauncher":
		case "pistol":
		case "spread":
		case "mg":
		case "smg":
		case "rifle":
			return 1;

		default:
			return 0;
	}
}

//Function Number: 81
isaltmodeweapon(param_00)
{
	if(param_00 == "none")
	{
		return 0;
	}

	return weaponinventorytype(param_00) == "altmode";
}

//Function Number: 82
isinventoryweapon(param_00)
{
	if(param_00 == "none")
	{
		return 0;
	}

	return weaponinventorytype(param_00) == "item";
}

//Function Number: 83
isriotshield(param_00)
{
	if(param_00 == "none")
	{
		return 0;
	}

	return weapontype(param_00) == "riotshield";
}

//Function Number: 84
isoffhandweapon(param_00)
{
	if(param_00 == "none")
	{
		return 0;
	}

	return weaponinventorytype(param_00) == "offhand";
}

//Function Number: 85
issidearm(param_00)
{
	if(param_00 == "none")
	{
		return 0;
	}

	if(weaponinventorytype(param_00) != "primary")
	{
		return 0;
	}

	return weaponclass(param_00) == "pistol";
}

//Function Number: 86
isgrenade(param_00)
{
	var_01 = weaponclass(param_00);
	var_02 = weaponinventorytype(param_00);
	if(var_01 != "grenade")
	{
		return 0;
	}

	if(var_02 != "offhand")
	{
		return 0;
	}
}

//Function Number: 87
updatesavedlastweapon()
{
	self endon("death");
	self endon("disconnect");
	self endon("faux_spawn");
	var_00 = self.currentweaponatspawn;
	self.saved_lastweapon = var_00;
	for(;;)
	{
		self waittill("weapon_change",var_01);
		if(var_01 == "none")
		{
			self.saved_lastweapon = var_00;
			continue;
		}

		var_02 = weaponinventorytype(var_01);
		if(var_02 != "primary" && var_02 != "altmode")
		{
			self.saved_lastweapon = var_00;
			continue;
		}

		updatemovespeedscale();
		self.saved_lastweapon = var_00;
		var_00 = var_01;
	}
}

//Function Number: 88
updateweaponrank()
{
	self endon("death");
	self endon("disconnect");
	self endon("faux_spawn");
	var_00 = self.currentweaponatspawn;
	var_01 = strtok(var_00,"_");
	if(var_01[0] == "iw5")
	{
	}
	else if(var_7B[0] == "alt")
	{
	}

	self.pers["weaponRank"] = maps\mp\gametypes\_rank::getweaponrank(var_7B[0]);
	for(;;)
	{
		self waittill(var_01[0] + "_" + var_01[1],var_7B[0],var_7B[1] + "_" + var_7B[2],var_7B[0],"weapon_change",var_02);
		if(var_02 == "none" || maps\mp\_utility::isjuggernaut() || maps\mp\_utility::isdeathstreakweapon(var_02))
		{
			continue;
		}

		var_03 = weaponinventorytype(var_02);
		if(var_03 == "primary")
		{
			var_7B = strtok(var_02,"_");
			if(var_7B[0] == "iw5")
			{
				self.pers["weaponRank"] = maps\mp\gametypes\_rank::getweaponrank(var_7B[0] + "_" + var_7B[1]);
				continue;
			}

			if(var_7B[0] == "alt")
			{
				self.pers["weaponRank"] = maps\mp\gametypes\_rank::getweaponrank(var_7B[1] + "_" + var_7B[2]);
				continue;
			}

			self.pers["weaponRank"] = maps\mp\gametypes\_rank::getweaponrank(var_7B[0]);
		}
	}
}

//Function Number: 89
empplayer(param_00)
{
	self endon("disconnect");
	self endon("death");
	thread clearempondeath();
}

//Function Number: 90
clearempondeath()
{
	self endon("disconnect");
	self waittill("death");
}

//Function Number: 91
updatemovespeedscale()
{
	self.weaponlist = self getweaponslistprimaries();
	if(self.weaponlist.size)
	{
		var_00 = 1000;
		foreach(var_02 in self.weaponlist)
		{
			var_03 = maps\mp\_utility::getbaseweaponname(var_02);
			var_04 = int(tablelookup("mp/statstable.csv",4,var_03,8));
			if(var_04 == 0)
			{
				continue;
			}

			if(var_04 < var_00)
			{
				var_00 = var_04;
			}
		}

		if(var_00 > 10)
		{
			var_00 = 10;
		}
	}
	else
	{
		var_00 = 8;
	}

	var_06 = var_00 / 10;
	self.weaponspeed = var_06;
	self setmovespeedscale(var_06 * self.movespeedscaler);
}

//Function Number: 92
stancerecoiladjuster()
{
	self endon("death");
	self endon("disconnect");
	self endon("faux_spawn");
	self notifyonplayercommand("adjustedStance","+stance");
	self notifyonplayercommand("adjustedStance","+goStand");
	for(;;)
	{
		common_scripts\utility::waittill_any("adjustedStance","sprint_begin");
		var_00 = maps\mp\_utility::getweaponclass(self getcurrentprimaryweapon());
		if(var_00 != "weapon_lmg" && var_00 != "weapon_sniper")
		{
			continue;
		}

		wait 0.5;
		self.stance = self getstance();
		if(self.stance == "prone")
		{
			if(var_00 == "weapon_lmg")
			{
				maps\mp\_utility::setrecoilscale(0,40);
			}
			else if(var_00 == "weapon_sniper")
			{
				maps\mp\_utility::setrecoilscale(0,60);
			}
			else
			{
				maps\mp\_utility::setrecoilscale();
			}

			continue;
		}

		if(self.stance == "crouch")
		{
			if(var_00 == "weapon_lmg")
			{
				maps\mp\_utility::setrecoilscale(0,10);
			}
			else if(var_00 == "weapon_sniper")
			{
				maps\mp\_utility::setrecoilscale(0,30);
			}
			else
			{
				maps\mp\_utility::setrecoilscale();
			}

			continue;
		}

		maps\mp\_utility::setrecoilscale();
	}
}

//Function Number: 93
func_2D32(param_00)
{
	var_01 = getattachmentlist();
	var_02 = 149;
	var_03 = [];
	for(var_04 = 0;var_04 <= var_02;var_04++)
	{
		var_05 = tablelookup("mp/statstable.csv",0,var_04,4);
		if(var_05 == "")
		{
			continue;
		}

		var_06 = var_05 + "_mp";
		if(!issubstr(tablelookup("mp/statsTable.csv",0,var_04,2),"weapon_"))
		{
			continue;
		}

		if(weaponinventorytype(var_06) != "primary")
		{
			continue;
		}

		var_07 = spawnstruct();
		var_07.basename = var_05;
		var_07.assetname = var_06;
		var_07.variants = [];
		var_07.variants[0] = var_06;
		var_08 = [];
		for(var_09 = 0;var_09 < 6;var_09++)
		{
			var_0A = tablelookup("mp/statStable.csv",0,var_04,var_09 + 11);
			if(param_00)
			{
				switch(var_0A)
				{
					case "xmags":
					case "rof":
					case "fmj":
						break;
				}
			}

			if(var_0A == "")
			{
				break;
			}

			var_08[var_0A] = 1;
		}

		var_0B = [];
		foreach(var_0A in var_01)
		{
			if(!isdefined(var_08[var_0A]))
			{
				continue;
			}

			var_07.variants[var_07.variants.size] = var_05 + "_" + var_0A + "_mp";
			var_0B[var_0B.size] = var_0A;
		}

		for(var_0E = 0;var_0E < var_0B.size - 1;var_0E++)
		{
			var_0F = tablelookuprownum("mp/attachmentCombos.csv",0,var_0B[var_0E]);
			for(var_10 = var_0E + 1;var_10 < var_0B.size;var_10++)
			{
				if(tablelookup("mp/attachmentCombos.csv",0,var_0B[var_10],var_0F) == "no")
				{
					continue;
				}

				var_07.variants[var_07.variants.size] = var_05 + "_" + var_0B[var_0E] + "_" + var_0B[var_10] + "_mp";
			}
		}

		var_03[var_05] = var_07;
	}

	return var_03;
}

//Function Number: 94
monitorsemtex()
{
	self endon("disconnect");
	self endon("death");
	self endon("faux_spawn");
	for(;;)
	{
		self waittill("grenade_fire",var_00);
		if(!issubstr(var_00.model,"semtex"))
		{
			continue;
		}

		var_00 waittill("missile_stuck",var_01);
		if(!isplayer(var_01))
		{
			continue;
		}

		if(level.teambased && isdefined(var_01.team) && var_01.team == self.team)
		{
			var_00.isstuck = "friendly";
			continue;
		}

		var_00.isstuck = "enemy";
		var_00.stuckenemyentity = var_01;
		var_01 maps\mp\gametypes\_hud_message::playercardsplashnotify("semtex_stuck",self);
		thread maps\mp\gametypes\_hud_message::splashnotify("stuck_semtex",100);
		self notify("process","ch_bullseye");
	}
}

//Function Number: 95
turret_monitoruse()
{
	for(;;)
	{
		self waittill("trigger",var_00);
		thread turret_playerthread(var_00);
	}
}

//Function Number: 96
turret_playerthread(param_00)
{
	param_00 endon("death");
	param_00 endon("disconnect");
	param_00 notify("weapon_change","none");
	self waittill("turret_deactivate");
	param_00 notify("weapon_change",param_00 getcurrentweapon());
}

//Function Number: 97
spawnmine(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_03))
	{
		param_03 = (0,randomfloat(360),0);
	}

	var_04 = "projectile_bouncing_betty_grenade";
	var_05 = spawn("script_model",param_00);
	var_05.angles = param_03;
	var_05 setmodel(var_04);
	var_05.owner = param_01;
	var_05.weaponname = "bouncingbetty_mp";
	level.mines[level.mines.size] = var_05;
	var_05.killcamoffset = (0,0,4);
	var_05.killcament = spawn("script_model",var_05.origin + var_05.killcamoffset);
	var_05.killcament setscriptmoverkillcam("explosive");
	if(!isdefined(param_02) || param_02 == "equipment")
	{
		param_01.equipmentmines = common_scripts\utility::array_removeundefined(param_01.equipmentmines);
		if(param_01.equipmentmines.size >= level.maxperplayerexplosives)
		{
			param_01.equipmentmines[0] delete();
		}

		param_01.equipmentmines[param_01.equipmentmines.size] = var_05;
	}
	else
	{
		param_01.killstreakmines[param_01.killstreakmines.size] = var_05;
	}

	var_05 thread createbombsquadmodel("projectile_bouncing_betty_grenade_bombsquad","tag_origin",level.otherteam[param_01.team],param_01);
	var_05 thread minebeacon();
	var_05 thread setclaymoreteamheadicon(param_01.pers["team"]);
	var_05 thread minedamagemonitor();
	var_05 thread mineproximitytrigger();
	return var_05;
}

//Function Number: 98
minedamagemonitor()
{
	self endon("mine_triggered");
	self endon("mine_selfdestruct");
	self endon("death");
	self setcandamage(1);
	self.maxhealth = 100000;
	self.health = self.maxhealth;
	var_00 = undefined;
	for(;;)
	{
		self waittill("damage",var_01,var_00,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09);
		if(!isplayer(var_00) || isdefined(var_09) && var_09 == "bouncingbetty_mp")
		{
			continue;
		}

		if(!friendlyfirecheck(self.owner,var_00))
		{
			continue;
		}

		if(isdefined(var_09))
		{
			switch(var_09)
			{
				case "smoke_grenade_mp":
					break;
			}
		}

		break;
	}

	self notify("mine_destroyed");
	if(isdefined(var_04) && issubstr(var_04,"MOD_GRENADE") || issubstr(var_04,"MOD_EXPLOSIVE"))
	{
		self.waschained = 1;
	}

	if(isdefined(var_08) && var_08 & level.idflags_penetration)
	{
		self.wasdamagedfrombulletpenetration = 1;
	}

	self.wasdamaged = 1;
	if(isplayer(var_00))
	{
		var_00 maps\mp\gametypes\_damagefeedback::updatedamagefeedback("bouncing_betty");
	}

	if(level.teambased)
	{
		if(isdefined(var_00) && isdefined(var_00.pers["team"]) && isdefined(self.owner) && isdefined(self.owner.pers["team"]))
		{
			if(var_00.pers["team"] != self.owner.pers["team"])
			{
				var_00 notify("destroyed_explosive");
			}
		}
	}
	else if(isdefined(self.owner) && isdefined(var_00) && var_00 != self.owner)
	{
		var_00 notify("destroyed_explosive");
	}

	thread mineexplode(var_00);
}

//Function Number: 99
mineproximitytrigger()
{
	self endon("mine_destroyed");
	self endon("mine_selfdestruct");
	self endon("death");
	wait 2;
	var_00 = spawn("trigger_radius",self.origin,0,level.minedetectionradius,level.minedetectionheight);
	thread minedeletetrigger(var_00);
	var_01 = undefined;
	for(;;)
	{
		var_00 waittill("trigger",var_01);
		if(getdvarint("scr_minesKillOwner") != 1)
		{
			if(isdefined(self.owner) && var_01 == self.owner)
			{
				continue;
			}

			if(!friendlyfirecheck(self.owner,var_01,0))
			{
				continue;
			}
		}

		if(lengthsquared(var_01 getentityvelocity()) < 10)
		{
			continue;
		}

		if(var_01 damageconetrace(self.origin,self) > 0)
		{
			break;
		}
	}

	self notify("mine_triggered");
	self playsound("mine_betty_click");
	if(isplayer(var_01) && var_01 maps\mp\_utility::_hasperk("specialty_delaymine"))
	{
		var_01 notify("triggered_mine");
		wait level.delayminetime;
	}
	else
	{
		wait level.minedetectiongraceperiod;
	}

	thread minebounce();
}

//Function Number: 100
minedeletetrigger(param_00)
{
	common_scripts\utility::waittill_any("mine_triggered","mine_destroyed","mine_selfdestruct","death");
	param_00 delete();
}

//Function Number: 101
mineselfdestruct()
{
	self endon("mine_triggered");
	self endon("mine_destroyed");
	self endon("death");
	wait level.mineselfdestructtime;
	wait randomfloat(0.4);
	self notify("mine_selfdestruct");
	thread mineexplode();
}

//Function Number: 102
minebounce()
{
	self playsound("mine_betty_spin");
	playfx(level.mine_launch,self.origin);
	if(isdefined(self.trigger))
	{
		self.trigger delete();
	}

	var_00 = self.origin + (0,0,64);
	self moveto(var_00,0.7,0,0.65);
	self.killcament moveto(var_00 + self.killcamoffset,0.7,0,0.65);
	self rotatevelocity((0,750,32),0.7,0,0.65);
	thread playspinnerfx();
	wait 0.65;
	thread mineexplode();
}

//Function Number: 103
mineexplode(param_00)
{
	if(!isdefined(self) || !isdefined(self.owner))
	{
		return;
	}

	if(!isdefined(param_00))
	{
		param_00 = self.owner;
	}

	self playsound("grenade_explode_metal");
	playfxontag(level.mine_explode,self,"tag_fx");
	wait 0.05;
	if(!isdefined(self) || !isdefined(self.owner))
	{
		return;
	}

	self hide();
	self radiusdamage(self.origin,level.minedamageradius,level.minedamagemax,level.minedamagemin,param_00,"MOD_EXPLOSIVE","bouncingbetty_mp");
	wait 0.2;
	if(!isdefined(self) || !isdefined(self.owner))
	{
		return;
	}

	if(isdefined(self.trigger))
	{
		self.trigger delete();
	}

	self.killcament delete();
	self delete();
}

//Function Number: 104
playspinnerfx()
{
	self endon("death");
	var_00 = gettime() + 1000;
	while(gettime() < var_00)
	{
		wait 0.05;
		playfxontag(level.mine_spin,self,"tag_fx_spin1");
		playfxontag(level.mine_spin,self,"tag_fx_spin3");
		wait 0.05;
		playfxontag(level.mine_spin,self,"tag_fx_spin2");
		playfxontag(level.mine_spin,self,"tag_fx_spin4");
	}
}

//Function Number: 105
minedamagedebug(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06[0] = (1,0,0);
	if(param_02[2] < var_06)
	{
		var_07 = 0;
	}
	else
	{
		var_07 = 1;
	}

	var_08 = (param_01[0],param_01[1],var_06);
	var_09 = (param_02[0],param_02[1],var_06);
	thread debugcircle(var_08,level.minedamageradius,var_7B[var_07],32);
	var_0A = distancesquared(param_01,param_02);
	if(var_0A > param_03)
	{
		var_07 = 0;
	}
	else
	{
		var_07 = 1;
	}

	thread debugline(var_08,var_09,var_7B[var_07]);
}

//Function Number: 106
minedamageheightpassed(param_00,param_01)
{
	if(isplayer(param_01) && isalive(param_01) && param_01.sessionstate == "playing")
	{
		var_02 = param_01 maps\mp\_utility::getstancecenter();
	}
	else if(var_02.classname == "misc_turret")
	{
		var_02 = var_02.origin + (0,0,32);
	}
	else
	{
		var_02 = var_02.origin;
	}

	var_03 = 0;
	var_04 = param_00.origin[2] + var_03 + level.minedamagehalfheight;
	var_05 = param_00.origin[2] + var_03 - level.minedamagehalfheight;
	if(var_02[2] > var_04 || var_02[2] < var_05)
	{
		return 0;
	}

	return 1;
}

//Function Number: 107
watchmineusage()
{
	self endon("disconnect");
	self endon("spawned_player");
	if(isdefined(self.equipmentmines))
	{
		if(maps\mp\_utility::getintproperty("scr_deleteexplosivesonspawn",1) == 1)
		{
			self.equipmentmines = common_scripts\utility::array_removeundefined(self.equipmentmines);
			foreach(var_01 in self.equipmentmines)
			{
				if(isdefined(var_01.trigger))
				{
					var_01.trigger delete();
				}

				var_01 delete();
			}
		}
	}
	else
	{
		self.equipmentmines = [];
	}

	if(!isdefined(self.killstreakmines))
	{
		self.killstreakmines = [];
	}

	for(;;)
	{
		self waittill("grenade_fire",var_03,var_04);
		if(var_04 == "bouncingbetty" || var_04 == "bouncingbetty_mp")
		{
			if(!isalive(self))
			{
				var_03 delete();
				return;
			}

			self.hasdonecombat = 1;
			var_03 thread minethrown(self);
		}
	}
}

//Function Number: 108
minethrown(param_00)
{
	self.owner = param_00;
	self waittill("missile_stuck");
	if(!isdefined(param_00))
	{
		return;
	}

	var_01 = bullettrace(self.origin + (0,0,4),self.origin - (0,0,4),0,self);
	var_02 = var_01["position"];
	if(var_01["fraction"] == 1)
	{
		var_02 = getgroundposition(self.origin,12,0,32);
		var_01["normal"] = var_01["normal"] * -1;
	}

	var_03 = vectornormalize(var_01["normal"]);
	var_04 = vectortoangles(var_03);
	var_04 = var_04 + (90,0,0);
	var_05 = spawnmine(var_02,param_00,"equipment",var_04);
	var_05.trigger = spawn("script_origin",var_05.origin + (0,0,25));
	var_05 thread equipmentwatchuse(param_00);
	param_00 thread minewatchowner(var_05);
	self delete();
}

//Function Number: 109
minewatchowner(param_00)
{
	param_00 endon("death");
	level endon("game_ended");
	common_scripts\utility::waittill_any("disconnect","joined_team","joined_spectators");
	if(isdefined(param_00.trigger))
	{
		param_00.trigger delete();
	}

	param_00 delete();
}

//Function Number: 110
minebeacon()
{
	var_00["friendly"] = spawnfx(level.mine_beacon["friendly"],self gettagorigin("tag_fx"));
	thread minebeaconteamupdater(var_7B);
	self waittill(spawnfx(level.mine_beacon["enemy"],self gettagorigin("tag_fx")),var_7B["enemy"],"death");
	var_7B["friendly"] delete();
	var_7B["enemy"] delete();
}

//Function Number: 111
minebeaconteamupdater(param_00)
{
	self endon("death");
	var_01 = self.owner.team;
	wait 0.05;
	triggerfx(param_00["friendly"]);
	triggerfx(param_00["enemy"]);
	for(;;)
	{
		param_00["friendly"] hide();
		param_00["enemy"] hide();
		foreach(var_03 in level.players)
		{
			if(level.teambased)
			{
				if(var_03.team == var_01)
				{
					param_00["friendly"] showtoplayer(var_03);
				}
				else
				{
					param_00["enemy"] showtoplayer(var_03);
				}

				continue;
			}

			if(var_03 == self.owner)
			{
				param_00["friendly"] showtoplayer(var_03);
				continue;
			}

			param_00["enemy"] showtoplayer(var_03);
		}

		level common_scripts\utility::waittill_either("joined_team","player_spawned");
	}
}