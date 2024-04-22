/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\gametypes\_weapons.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 156
 * Decompile Time: 2424 ms
 * Timestamp: 4/22/2024 2:10:34 AM
*******************************************************************/

//Function Number: 1
init()
{
	level.scavenger_altmode = 1;
	level.scavenger_secondary = 1;
	level.maxperplayerexplosives = max(maps\mp\_utility::getintproperty("scr_maxPerPlayerExplosives",2),1);
	level.riotshieldxpbullets = maps\mp\_utility::getintproperty("scr_riotShieldXPBullets",15);
	createthreatbiasgroup("DogsDontAttack");
	createthreatbiasgroup("Dogs");
	setignoremegroup("DogsDontAttack","Dogs");
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

	var_00 = getdvar("g_gametype");
	var_01 = maps\mp\_utility::getattachmentlistbasenames();
	var_01 = common_scripts\utility::alphabetize(var_01);
	var_02 = 150;
	level.weaponlist = [];
	level.weaponattachments = [];
	for(var_03 = 0;var_03 <= var_02;var_03++)
	{
		var_04 = tablelookup("mp/statstable.csv",0,var_03,4);
		if(var_04 == "")
		{
			continue;
		}

		if(tablelookup("mp/statsTable.csv",0,var_03,51) != "")
		{
			continue;
		}

		if(!issubstr(tablelookup("mp/statsTable.csv",0,var_03,2),"weapon_"))
		{
			continue;
		}

		if(issubstr(var_04,"iw5") || issubstr(var_04,"iw6"))
		{
			var_05 = maps\mp\_utility::getweaponnametokens(var_04);
			var_04 = var_05[0] + "_" + var_05[1] + "_mp";
			level.weaponlist[level.weaponlist.size] = var_04;
			continue;
		}
		else
		{
			level.weaponlist[level.weaponlist.size] = var_04 + "_mp";
		}

		var_06 = maps\mp\_utility::getweaponattachmentarrayfromstats(var_04);
		var_07 = [];
		foreach(var_09 in var_01)
		{
			if(!isdefined(var_06[var_09]))
			{
				continue;
			}

			level.weaponlist[level.weaponlist.size] = var_04 + "_" + var_09 + "_mp";
			var_07[var_07.size] = var_09;
		}

		var_0B = [];
		for(var_0C = 0;var_0C < var_07.size - 1;var_0C++)
		{
			var_0D = tablelookuprownum("mp/attachmentCombos.csv",0,var_07[var_0C]);
			for(var_0E = var_0C + 1;var_0E < var_07.size;var_0E++)
			{
				if(tablelookup("mp/attachmentCombos.csv",0,var_07[var_0E],var_0D) == "no")
				{
					continue;
				}

				var_0B[var_0B.size] = var_07[var_0C] + "_" + var_07[var_0E];
			}
		}

		foreach(var_10 in var_0B)
		{
			level.weaponlist[level.weaponlist.size] = var_04 + "_" + var_10 + "_mp";
		}
	}

	if(!isdefined(level.iszombiegame) || !level.iszombiegame)
	{
		foreach(var_13 in level.weaponlist)
		{
			precacheitem(var_13);
		}
	}

	thread maps\mp\_flashgrenades::main();
	thread maps\mp\_entityheadicons::init();
	thread maps\mp\_empgrenade::init();
	if(!isdefined(level.iszombiegame) || !level.iszombiegame)
	{
		thread maps\mp\_tridrone::init();
		thread maps\mp\_explosive_gel::init();
		thread maps\mp\_riotshield::init();
	}

	thread maps\mp\_exoknife::init();
	if(!isdefined(level.weapondropfunction))
	{
		level.weapondropfunction = ::dropweaponfordeath;
	}

	var_16 = 70;
	level.claymoredetectiondot = cos(var_16);
	level.claymoredetectionmindist = 20;
	level.claymoredetectiongraceperiod = 0.75;
	level.claymoredetonateradius = 192;
	if(!isdefined(level.iszombiegame) || !level.iszombiegame)
	{
		level.minedetectiongraceperiod = 0.3;
		level.minedetectionradius = 100;
		level.minedetectionheight = 20;
		level.minedamageradius = 256;
		level.minedamagemin = 70;
		level.minedamagemax = 210;
		level.minedamagehalfheight = 46;
		level.mineselfdestructtime = 120;
		level.mine_launch = loadfx("vfx/weaponimpact/bouncing_betty_launch_dirt");
		level.mine_spin = loadfx("vfx/dust/bouncing_betty_swirl");
		level.mine_explode = loadfx("vfx/explosion/bouncing_betty_explosion");
		level.mine_beacon["enemy"] = loadfx("vfx/lights/light_c4_blink");
		level.mine_beacon["friendly"] = loadfx("vfx/lights/light_mine_blink_friendly");
		level.empgrenadeexplode = loadfx("vfx/explosion/emp_grenade_mp");
	}

	level._effect["mine_stunned"] = loadfx("vfx/sparks/emp_drone_damage");
	level.delayminetime = 3;
	level.sentry_fire = loadfx("fx/muzzleflashes/shotgunflash");
	level.stingerfxid = loadfx("fx/explosions/aerial_explosion_large");
	level.primary_weapon_array = [];
	level.side_arm_array = [];
	level.grenade_array = [];
	level.missile_array = [];
	level.inventory_array = [];
	level.mines = [];
	level.trophies = [];
	if(!maps\mp\_utility::invirtuallobby())
	{
		if(!isdefined(level.iszombiegame) || !level.iszombiegame)
		{
			precachemodel("weapon_claymore_bombsquad");
			precachemodel("weapon_c4_bombsquad");
			precachemodel("projectile_m67fraggrenade_bombsquad");
			precachemodel("projectile_semtex_grenade_bombsquad");
			precachemodel("weapon_light_stick_tactical_bombsquad");
			precachemodel("projectile_bouncing_betty_grenade");
			precachemodel("projectile_bouncing_betty_grenade_bombsquad");
			precachemodel("weapon_jammer");
			precachemodel("weapon_jammer_bombsquad");
			precachemodel("weapon_radar");
			precachemodel("weapon_radar_bombsquad");
			precachemodel("mp_trophy_system");
			precachemodel("mp_trophy_system_bombsquad");
			precachemodel("projectile_semtex_grenade");
			precachemodel("npc_variable_grenade_lethal");
			precacheshader("exo_hud_cloak_overlay");
		}

		precachelaser("mp_attachment_lasersight");
		precachelaser("mp_attachment_directhack");
		precachelaser("mp_attachment_lasersight_short");
		level._effect["equipment_explode"] = loadfx("vfx/explosion/sparks_burst_lrg_c");
		level._effect["sniperDustLarge"] = loadfx("vfx/dust/sniper_dust_kickup");
		level._effect["sniperDustLargeSuppress"] = loadfx("vfx/dust/sniper_dust_kickup_accum_suppress");
	}

	level thread onplayerconnect();
	level.c4explodethisframe = 0;
	common_scripts\utility::array_thread(getentarray("misc_turret","classname"),::turret_monitoruse);
}

//Function Number: 2
dumpit()
{
	wait(5);
}

//Function Number: 3
bombsquadwaiter()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("grenade_fire",var_00,var_01);
		var_02 = maps\mp\_utility::strip_suffix(var_01,"_lefthand");
		if(var_02 == "c4_mp")
		{
			var_00 thread createbombsquadmodel("weapon_c4_bombsquad","tag_origin",self);
			continue;
		}

		if(var_02 == "claymore_mp")
		{
			var_00 thread createbombsquadmodel("weapon_claymore_bombsquad","tag_origin",self);
			continue;
		}

		if(var_02 == "frag_grenade_mp")
		{
			var_00 thread createbombsquadmodel("projectile_m67fraggrenade_bombsquad","tag_weapon",self);
			continue;
		}

		if(var_02 == "frag_grenade_short_mp")
		{
			var_00 thread createbombsquadmodel("projectile_m67fraggrenade_bombsquad","tag_weapon",self);
			continue;
		}

		if(var_02 == "semtex_mp")
		{
			var_00 thread createbombsquadmodel("projectile_semtex_grenade_bombsquad","tag_weapon",self);
			continue;
		}

		if(var_02 == "thermobaric_grenade_mp")
		{
			var_00 thread createbombsquadmodel("projectile_m67fraggrenade_bombsquad","tag_weapon",self);
		}
	}
}

//Function Number: 4
createbombsquadmodel(param_00,param_01,param_02)
{
	var_03 = spawn("script_model",(0,0,0));
	var_03 hide();
	wait(0.05);
	if(!isdefined(self))
	{
		return;
	}

	var_03 thread bombsquadvisibilityupdater(param_02);
	var_03 setmodel(param_00);
	var_03 linkto(self,param_01,(0,0,0),(0,0,0));
	var_03 setcontents(0);
	self waittill("death");
	if(isdefined(self.trigger))
	{
		self.trigger delete();
	}

	var_03 delete();
}

//Function Number: 5
bombsquadvisibilityupdater(param_00)
{
	self endon("death");
	if(!isdefined(param_00))
	{
		return;
	}

	var_01 = param_00.team;
	foreach(var_03 in level.players)
	{
		if(level.teambased)
		{
			if(var_03.team == "spectator")
			{
				continue;
			}

			if(var_03.team != var_01 && var_03 maps\mp\_utility::_hasperk("specialty_detectexplosive"))
			{
				self showtoplayer(var_03);
			}

			continue;
		}

		if(isdefined(param_00) && var_03 == param_00)
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
				if(var_03.team == "spectator")
				{
					continue;
				}

				if(var_03.team != var_01 && var_03 maps\mp\_utility::_hasperk("specialty_detectexplosive"))
				{
					self showtoplayer(var_03);
				}

				continue;
			}

			if(isdefined(param_00) && var_03 == param_00)
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

//Function Number: 6
onplayerconnect()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_00.hits = 0;
		var_00.issiliding = 0;
		maps\mp\gametypes\_gamelogic::sethasdonecombat(var_00,0);
		if(!maps\mp\_utility::invirtuallobby())
		{
			if(!isdefined(level.iszombiegame) && level.iszombiegame)
			{
				var_00 kc_regweaponforfxremoval("remotemissile_projectile_mp");
			}

			var_00 thread sniperdustwatcher();
		}

		var_00 thread onplayerspawned();
		var_00 thread bombsquadwaiter();
		var_00 thread watchmissileusage();
		var_00 thread update_em1_heat_omnvar();
	}
}

//Function Number: 7
onplayerspawned()
{
	self endon("disconnect");
	for(;;)
	{
		common_scripts\utility::waittill_any("spawned_player","faux_spawn");
		self.currentweaponatspawn = self getcurrentweapon();
		self.empendtime = 0;
		self.concussionendtime = 0;
		self.hits = 0;
		maps\mp\gametypes\_gamelogic::sethasdonecombat(self,0);
		if(!isdefined(self.trackingweaponname))
		{
			self.trackingweaponname = "";
			self.trackingweaponname = "none";
			self.trackingweaponshots = 0;
			self.trackingweaponkills = 0;
			self.trackingweaponhits = 0;
			self.trackingweaponheadshots = 0;
			self.trackingweaponhipfirekills = 0;
			self.trackingweapondeaths = 0;
			self.trackingweaponusetime = 0;
		}

		thread watchslide();
		thread watchweaponusage();
		thread watchgrenadeusage();
		thread watchstingerusage();
		thread watchweaponreload();
		thread watchmineusage();
		if(!isdefined(level.iszombiegame) && level.iszombiegame || isagent(self))
		{
			thread maps\mp\_riotshield::watchriotshielduse();
		}

		thread stancerecoiladjuster();
		thread maps\mp\perks\_perkfunctions::monitortiuse();
		thread maps\mp\_target_enhancer::target_enhancer_think();
		thread maps\mp\_opticsthermal::opticsthermal_think();
		thread maps\mp\_stock::stock_think();
		thread maps\mp\_lasersight::lasersight_think();
		thread maps\mp\_microdronelauncher::monitor_microdrone_launch();
		thread maps\mp\_exocrossbow::monitor_exocrossbow_launch();
		thread maps\mp\_stingerm7::stingerm7_think();
		thread maps\mp\_trackrounds::trackrounds_think();
		thread maps\mp\_na45::main();
		thread maps\mp\_lsrmissileguidance::monitor_lsr_missile_launch();
		thread maps\mp\_exoknife::exo_knife_think();
		thread maps\mp\_exo_battery::play_insufficient_tactical_energy_sfx();
		thread maps\mp\_exo_battery::play_insufficient_lethal_energy_sfx();
		thread watchgrenadegraceperiod();
		if(!isdefined(level.iszombiegame) && level.iszombiegame)
		{
			thread maps\mp\_tracking_drone::watchtrackingdroneusage();
			thread maps\mp\_explosive_drone::watchexplosivedroneusage();
		}

		if(!maps\mp\_utility::invirtuallobby())
		{
			thread watchsentryusage();
		}

		thread watchweaponchange();
		if(isdefined(level.onplayerspawnedweaponsfunc))
		{
			self thread [[ level.onplayerspawnedweaponsfunc ]]();
		}

		self.lasthittime = [];
		self.droppeddeathweapon = undefined;
		self.tookweaponfrom = [];
		self.pickedupweaponfrom = [];
		thread updatesavedlastweapon();
		thread monitorsemtex();
		self.currentweaponatspawn = undefined;
		self.trophyremainingammo = undefined;
		thread track_damage_info();
		if(!isdefined(self.spawninfo))
		{
			self.spawninfo = spawnstruct();
		}

		self.spawninfo.spawntime = gettime();
		self.spawninfo.damagedealttoofast = 0;
		self.spawninfo.damagereceivedtoofast = 0;
		self.spawninfo.badspawn = 0;
		var_00 = self.spawninfo.spawntime;
		if(!isdefined(self.num_lives))
		{
			self.num_lives = 0;
		}

		self.num_lives++;
		if(isagent(self))
		{
			return;
		}

		if(isdefined(self.explosive_drone_owner))
		{
			self.explosive_drone_owner = undefined;
		}

		var_01 = 0.1;
		var_02 = var_01;
		var_03 = "_matchdata.gsc";
		var_04 = -1;
		var_05 = -1;
		var_06 = -1;
		if(isdefined(self.spawninfo))
		{
			if(isdefined(self.spawninfo.spawnpoint))
			{
				if(isdefined(self.spawninfo.spawnpoint.israndom))
				{
					var_04 = self.spawninfo.spawnpoint.israndom;
				}

				if(isdefined(self.spawninfo.spawnpoint.numberofpossiblespawnchoices))
				{
					var_05 = self.spawninfo.spawnpoint.numberofpossiblespawnchoices;
				}

				if(isdefined(self.spawninfo.spawnpoint.lastupdatetime))
				{
					var_06 = self.spawninfo.spawnpoint.lastupdatetime;
				}
			}
		}

		reconspatialevent(self.spawnpos,"script_mp_playerspawn: player_name %s, life_id %d, life_index %d, was_tactical_insertion %b, team %s, gameTime %d, version %f, script_file %s, randomSpawn %b, number_of_choices %d, last_update_time %d",self.name,self.lifeid,self.num_lives,self.wasti,self.team,var_00,var_02,var_03,var_04,var_05,var_06);
	}
}

//Function Number: 8
recordtogglescopestates()
{
	self.pers["toggleScopeStates"] = [];
	var_00 = self getweaponslistprimaries();
	foreach(var_02 in var_00)
	{
		if(var_02 == self.primaryweapon || var_02 == self.secondaryweapon)
		{
			var_03 = getweaponattachments(var_02);
			foreach(var_05 in var_03)
			{
				if(var_05 == "variablereddot")
				{
					self.pers["toggleScopeStates"][var_02] = self gethybridsightenabled(var_02);
					break;
				}
			}
		}
	}
}

//Function Number: 9
sniperdustwatcher()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	var_00 = undefined;
	for(;;)
	{
		self waittill("weapon_fired");
		if(self getstance() != "prone")
		{
			continue;
		}

		if(maps\mp\_utility::getweaponclass(self getcurrentweapon()) != "weapon_sniper")
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

//Function Number: 10
watchstingerusage()
{
	maps\mp\_stinger::stingerusageloop();
}

//Function Number: 11
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

	var_01 = 1;
	for(;;)
	{
		if(!var_01)
		{
			self waittill("weapon_change");
		}

		var_01 = 0;
		var_00 = self getcurrentweapon();
		if(var_00 == "none")
		{
			continue;
		}

		var_02 = getweaponattachments(var_00);
		self.has_opticsthermal = 0;
		self.has_target_enhancer = 0;
		self.has_stock = 0;
		self.has_laser = 0;
		if(isdefined(var_02))
		{
			foreach(var_04 in var_02)
			{
				if(var_04 == "opticstargetenhancer")
				{
					self.has_target_enhancer = 1;
					continue;
				}

				if(var_04 == "stock")
				{
					self.has_stock = 1;
					continue;
				}

				if(var_04 == "lasersight")
				{
					self.has_laser = 1;
					continue;
				}

				if(issubstr(var_04,"opticsthermal"))
				{
					self.has_opticsthermal = 1;
				}
			}
		}

		if(maps\mp\_utility::isbombsiteweapon(var_00))
		{
			continue;
		}

		if(maps\mp\_utility::iskillstreakweapon(var_00))
		{
			if(maps\mp\killstreaks\_killstreaks::canshufflewithkillstreakweapon())
			{
				self.changingweapon = undefined;
			}

			continue;
		}

		var_06 = maps\mp\_utility::getweaponnametokens(var_00);
		self.bothbarrels = undefined;
		if(issubstr(var_00,"ranger"))
		{
			thread watchrangerusage(var_00);
		}

		if(var_06[0] == "alt")
		{
			var_07 = getsubstr(var_00,4);
			var_00 = var_07;
			var_06 = maps\mp\_utility::getweaponnametokens(var_00);
		}

		if(var_00 != "none" && var_06[0] != "iw5" && var_06[0] != "iw6")
		{
			if(maps\mp\_utility::iscacprimaryweapon(var_00) && !isdefined(self.hitsthismag[var_00 + "_mp"]))
			{
				self.hitsthismag[var_00 + "_mp"] = weaponclipsize(var_00 + "_mp");
			}
		}
		else if(var_00 != "none" && var_06[0] == "iw5" || var_06[0] == "iw6")
		{
			if(maps\mp\_utility::iscacprimaryweapon(var_00) && !isdefined(self.hitsthismag[var_00]))
			{
				self.hitsthismag[var_00] = weaponclipsize(var_00);
			}
		}

		if(maydropweapon(var_00))
		{
			self.lastdroppableweapon = var_00;
		}

		self.changingweapon = undefined;
	}
}

//Function Number: 12
watchstartweaponchange()
{
	self endon("faux_spawn");
	self endon("death");
	self endon("disconnect");
	self.changingweapon = undefined;
	for(;;)
	{
		self waittill("weapon_switch_started",var_00);
		thread makesureweaponchanges(self getcurrentweapon());
		self.changingweapon = var_00;
		if(var_00 == "none" && isdefined(self.iscapturingcrate) && self.iscapturingcrate)
		{
			while(self.iscapturingcrate)
			{
				wait(0.05);
			}

			self.changingweapon = undefined;
		}
	}
}

//Function Number: 13
makesureweaponchanges(param_00)
{
	self endon("weapon_switch_started");
	self endon("weapon_change");
	self endon("disconnect");
	self endon("death");
	level endon("game_ended");
	if(!maps\mp\killstreaks\_killstreaks::canshufflewithkillstreakweapon())
	{
		return;
	}

	wait(1);
	self.changingweapon = undefined;
}

//Function Number: 14
watchweaponreload()
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

//Function Number: 15
watchrangerusage(param_00)
{
	var_01 = self getweaponammoclip(param_00,"right");
	var_02 = self getweaponammoclip(param_00,"left");
	self endon("reload");
	self endon("weapon_change");
	self endon("faux_spawn");
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

//Function Number: 16
maydropweapon(param_00)
{
	if(param_00 == "none")
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

	if(maps\mp\_utility::getweaponclass(param_00) == "weapon_projectile")
	{
		return 0;
	}

	var_01 = weaponinventorytype(param_00);
	if(var_01 != "primary")
	{
		return 0;
	}

	if(issubstr(param_00,"combatknife") || issubstr(param_00,"underwater"))
	{
		return 0;
	}

	return 1;
}

//Function Number: 17
dropweaponfordeath(param_00,param_01)
{
	if(!maps\mp\_utility::isusingremote())
	{
		waittillframeend;
	}

	if(isdefined(level.blockweapondrops))
	{
		return;
	}

	if(!isdefined(self))
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

	var_02 = self.lastdroppableweapon;
	if(!isdefined(var_02))
	{
		return;
	}

	if(var_02 == "none")
	{
		return;
	}

	if(!self hasweapon(var_02))
	{
		return;
	}

	if(maps\mp\_utility::isjuggernaut())
	{
		return;
	}

	if(isdefined(level.gamemodemaydropweapon) && !self [[ level.gamemodemaydropweapon ]](var_02))
	{
		return;
	}

	var_03 = maps\mp\_utility::getweaponnametokens(var_02);
	if(var_03[0] == "alt")
	{
		for(var_04 = 0;var_04 < var_03.size;var_04++)
		{
			if(var_04 > 0 && var_04 < 2)
			{
				var_02 = var_02 + var_03[var_04];
				continue;
			}

			if(var_04 > 0)
			{
				var_02 = var_02 + "_" + var_03[var_04];
				continue;
			}

			var_02 = "";
		}
	}

	if(var_02 != "riotshield_mp")
	{
		if(!self anyammoforweaponmodes(var_02))
		{
			return;
		}

		var_05 = self getweaponammoclip(var_02,"right");
		var_06 = self getweaponammoclip(var_02,"left");
		if(!var_05 && !var_06)
		{
			return;
		}

		var_07 = self setweaponammostock(var_02);
		var_08 = weaponmaxammo(var_02);
		if(var_07 > var_08)
		{
			var_07 = var_08;
		}

		var_09 = self dropitem(var_02);
		if(!isdefined(var_09))
		{
			return;
		}

		if(maps\mp\_utility::ismeleemod(param_01))
		{
			var_09.origin = (var_09.origin[0],var_09.origin[1],var_09.origin[2] - 5);
		}

		var_09 itemweaponsetammo(var_05,var_07,var_06);
	}
	else
	{
		var_09 = self dropitem(var_03);
		if(!isdefined(var_09))
		{
			return;
		}

		var_09 itemweaponsetammo(1,1,0);
	}

	self.droppeddeathweapon = 1;
	if(maps\mp\_riotshield::weaponisriotshield(var_02))
	{
		self refreshshieldmodels();
	}

	var_09.owner = self;
	var_09.ownersattacker = param_00;
	var_09.targetname = "dropped_weapon";
	var_09 thread watchpickup();
	var_09 thread deletepickupafterawhile();
}

//Function Number: 18
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

//Function Number: 19
deletepickupafterawhile()
{
	self endon("death");
	wait(60);
	if(!isdefined(self))
	{
		return;
	}

	self delete();
}

//Function Number: 20
getitemweaponname()
{
	var_00 = self.classname;
	var_01 = getsubstr(var_00,7);
	return var_01;
}

//Function Number: 21
watchpickup()
{
	self endon("death");
	var_00 = getitemweaponname();
	var_01 = self.owner;
	for(;;)
	{
		self waittill("trigger",var_02,var_03);
		if(isdefined(var_00) && var_00 == var_02.primaryweapon)
		{
			return;
		}

		if(isdefined(var_00) && var_00 == var_02.secondaryweapon)
		{
			return;
		}

		var_02.pickedupweaponfrom[var_00] = undefined;
		var_02.tookweaponfrom[var_00] = undefined;
		if(isdefined(var_02.pers["weaponPickupsCount"]))
		{
			var_02.pers["weaponPickupsCount"]++;
		}

		if(isdefined(var_01) && var_01 != var_02)
		{
			var_02.pickedupweaponfrom[var_00] = var_01;
			if(isdefined(self.ownersattacker) && self.ownersattacker == var_02)
			{
				var_02.tookweaponfrom[var_00] = var_01;
			}
		}

		if(isdefined(var_03))
		{
			break;
		}
	}

	var_03.owner = var_02;
	var_03.targetname = "dropped_weapon";
	var_04 = var_03 getitemweaponname();
	if(isdefined(var_02.primaryweapon) && var_02.primaryweapon == var_04)
	{
		var_02.primaryweapon = var_00;
	}

	if(isdefined(var_02.secondaryweapon) && var_02.secondaryweapon == var_04)
	{
		var_02.secondaryweapon = var_00;
	}

	if(isdefined(var_02.pickedupweaponfrom[var_04]))
	{
		var_03.owner = var_02.pickedupweaponfrom[var_04];
		var_02.pickedupweaponfrom[var_04] = undefined;
	}

	if(isdefined(var_02.tookweaponfrom[var_04]))
	{
		var_03.ownersattacker = var_02;
		var_02.tookweaponfrom[var_04] = undefined;
	}

	var_03 thread watchpickup();
}

//Function Number: 22
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

//Function Number: 23
handlescavengerbagpickup(param_00)
{
	self endon("death");
	level endon("game_ended");
	self waittill("scavenger",var_01);
	var_01 notify("scavenger_pickup");
	var_02 = var_01 getweaponslistoffhands();
	foreach(var_04 in var_02)
	{
		if(maps\mp\gametypes\_class::isvalidoffhand(var_04,0) && var_01 maps\mp\_utility::_hasperk("specialty_tacticalresupply"))
		{
			var_01 batteryfullrecharge(var_04);
			continue;
		}

		if(maps\mp\gametypes\_class::isvalidequipment(var_04,0) && var_01 maps\mp\_utility::_hasperk("specialty_lethalresupply"))
		{
			var_05 = var_01 getweaponammoclip(var_04);
			var_01 setweaponammoclip(var_04,var_05 + 1);
		}
	}

	if(var_01 maps\mp\_utility::_hasperk("specialty_scavenger"))
	{
		var_07 = var_01 getweaponslistprimaries();
		foreach(var_09 in var_07)
		{
			if(maps\mp\_utility::iscacprimaryweapon(var_09) || level.scavenger_secondary && maps\mp\_utility::iscacsecondaryweapon(var_09))
			{
				var_0A = var_01 setweaponammostock(var_09);
				var_0B = 0;
				var_0C = maps\mp\_utility::getweaponclass(var_09);
				if(isbeamweapon(var_09) || var_0C == "weapon_riot" || issubstr(var_09,"riotshield"))
				{
				}
				else if(var_0C == "weapon_projectile" || issubstr(var_09,"exocrossbow") || issubstr(var_09,"microdronelauncher"))
				{
					if(var_01 maps\mp\_utility::_hasperk("specialty_explosiveammoresupply"))
					{
						var_0B = weaponclipsize(var_09);
					}
				}
				else if(issubstr(var_09,"alt") && issubstr(var_09,"gl"))
				{
					if(var_01 maps\mp\_utility::_hasperk("specialty_explosiveammoresupply"))
					{
						var_0B = weaponclipsize(var_09);
					}
				}
				else if(isbulletweapon(var_09))
				{
					if(var_01 maps\mp\_utility::_hasperk("specialty_bulletresupply"))
					{
						var_0D = weaponmaxammo(var_09);
						var_0B = int(var_0D * var_01.ammopickup_scalar);
					}
				}

				if(var_0B > 0)
				{
					var_01 setweaponammostock(var_09,var_0A + var_0B);
				}
			}
		}
	}

	var_01 maps\mp\gametypes\_damagefeedback::updatedamagefeedback("scavenger");
}

//Function Number: 24
dropscavengerfordeath(param_00)
{
	waittillframeend;
	if(level.ingraceperiod)
	{
		return;
	}

	if(!isdefined(self))
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

	if(level.iszombiegame)
	{
		return;
	}

	if(!isdefined(self.agentbody))
	{
		var_01 = self dropscavengerbag("scavenger_bag_mp");
	}
	else
	{
		var_01 = self.agentbody dropscavengerbag("scavenger_bag_mp");
	}

	var_01 thread handlescavengerbagpickup(self);
	if(isdefined(level.bot_funcs["bots_add_scavenger_bag"]))
	{
		[[ level.bot_funcs["bots_add_scavenger_bag"] ]](var_01);
	}
}

//Function Number: 25
getweaponbasedgrenadecount(param_00)
{
	return 2;
}

//Function Number: 26
getweaponbasedsmokegrenadecount(param_00)
{
	return 1;
}

//Function Number: 27
getfraggrenadecount()
{
	var_00 = "frag_grenade_mp";
	var_01 = self getammocount(var_00);
	return var_01;
}

//Function Number: 28
getsmokegrenadecount()
{
	var_00 = self getammocount("smoke_grenade_mp");
	var_00 = var_00 + self getammocount("smoke_grenade_mp_lefthand");
	var_00 = var_00 + self getammocount("smoke_grenade_var_mp");
	var_00 = var_00 + self getammocount("smoke_grenade_var_mp_lefthand");
	return var_00;
}

//Function Number: 29
setweaponstat(param_00,param_01,param_02)
{
	maps\mp\gametypes\_gamelogic::setweaponstat(param_00,param_01,param_02);
}

//Function Number: 30
watchweaponusage(param_00)
{
	self endon("death");
	self endon("disconnect");
	self endon("faux_spawn");
	level endon("game_ended");
	if(isai(self))
	{
		return;
	}

	for(;;)
	{
		self waittill("weapon_fired",var_01);
		maps\mp\gametypes\_gamelogic::sethasdonecombat(self,1);
		self.lastshotfiredtime = gettime();
		if(!maps\mp\_utility::iscacprimaryweapon(var_01) && !maps\mp\_utility::iscacsecondaryweapon(var_01))
		{
			continue;
		}

		if(isdefined(self.hitsthismag[var_01]))
		{
			thread updatemagshots(var_01);
		}

		var_02 = maps\mp\gametypes\_persistence::statgetbuffered("totalShots") + 1;
		var_03 = maps\mp\gametypes\_persistence::statgetbuffered("hits");
		var_04 = clamp(float(var_03) / float(var_02),0,1) * 10000;
		maps\mp\gametypes\_persistence::statsetbuffered("totalShots",var_02);
		maps\mp\gametypes\_persistence::statsetbuffered("accuracy",int(var_04));
		maps\mp\gametypes\_persistence::statsetbuffered("misses",int(var_02 - var_03));
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

//Function Number: 31
updatemagshots(param_00)
{
	self endon("death");
	self endon("faux_spawn");
	self endon("disconnect");
	self endon("updateMagShots_" + param_00);
	self.hitsthismag[param_00]--;
	wait(0.05);
	self.hitsthismag[param_00] = weaponclipsize(param_00);
}

//Function Number: 32
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

//Function Number: 33
checkhit(param_00,param_01)
{
	self endon("disconnect");
	if(maps\mp\_utility::isstrstart(param_00,"alt_"))
	{
		var_02 = maps\mp\_utility::getweaponnametokens(param_00);
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

	if(self meleebuttonpressed())
	{
		return;
	}

	switch(weaponclass(param_00))
	{
		case "beam":
		case "smg":
		case "mg":
		case "pistol":
		case "rifle":
		case "sniper":
			self.hits++;
			break;

		case "spread":
			self.hits = 1;
			break;

		case "rocketlauncher":
		case "ball":
		case "shield":
		case "item":
		case "underwater":
		case "grenade":
			break;

		default:
			break;
	}

	if(issubstr(param_00,"riotshield"))
	{
		thread maps\mp\gametypes\_gamelogic::threadedsetweaponstatbyname("riotshield",self.hits,"hits");
		self.hits = 0;
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
	var_08 = maps\mp\gametypes\_persistence::statgetbuffered("totalShots");
	var_09 = maps\mp\gametypes\_persistence::statgetbuffered("hits") + 1;
	if(var_09 <= var_08)
	{
		maps\mp\gametypes\_persistence::statsetbuffered("hits",var_09);
		maps\mp\gametypes\_persistence::statsetbuffered("misses",int(var_08 - var_09));
		var_0A = clamp(float(var_09) / float(var_08),0,1) * 10000;
		maps\mp\gametypes\_persistence::statsetbuffered("accuracy",int(var_0A));
	}
}

//Function Number: 34
attackercandamageitem(param_00,param_01)
{
	return friendlyfirecheck(param_01,param_00);
}

//Function Number: 35
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

//Function Number: 36
watchgrenadeusage()
{
	self endon("death");
	self endon("disconnect");
	self endon("faux_spawn");
	self.throwinggrenade = undefined;
	self.gotpullbacknotify = 0;
	if(maps\mp\_utility::getintproperty("scr_deleteexplosivesonspawn",1) == 1)
	{
		if(isdefined(self.dont_delete_grenades_on_next_spawn))
		{
			self.dont_delete_grenades_on_next_spawn = undefined;
		}
		else
		{
			delete_all_grenades();
		}
	}
	else
	{
		if(!isdefined(self.manuallydetonatedarray))
		{
			self.manuallydetonatedarray = [];
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

	thread watchmanuallydetonatedusage();
	thread watchmanualdetonationbyemptythrow();
	thread watchmanualdetonationbydoubletap();
	thread watchc4usage();
	thread watchclaymores();
	thread deletec4andclaymoresondisconnect();
	thread watchforthrowbacks();
	for(;;)
	{
		self waittill("grenade_pullback",var_00);
		setweaponstat(var_00,1,"shots");
		maps\mp\gametypes\_gamelogic::sethasdonecombat(self,1);
		thread watchoffhandcancel();
		if(var_00 == "claymore_mp")
		{
			continue;
		}

		self.throwinggrenade = var_00;
		self.gotpullbacknotify = 1;
		if(var_00 == "c4_mp")
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

//Function Number: 37
begingrenadetracking()
{
	self endon("faux_spawn");
	self endon("death");
	self endon("disconnect");
	self endon("offhand_end");
	self endon("weapon_change");
	var_00 = gettime();
	self waittill("grenade_fire",var_01,var_02);
	if(isdefined(var_01))
	{
		var_03 = maps\mp\_utility::strip_suffix(var_02,"_lefthand");
		if(gettime() - var_00 > 1000 && var_03 == "frag_grenade_mp")
		{
			var_01.iscooked = 1;
		}

		self.changingweapon = undefined;
		var_01.owner = self;
		var_01.weaponname = var_02;
		switch(var_03)
		{
			case "semtex_grenade_var_mp":
			case "frag_grenade_var_mp":
			case "semtex_mp":
			case "frag_grenade_mp":
				var_01 thread maps\mp\gametypes\_shellshock::grenade_earthquake();
				var_01.originalowner = self;
				break;

			case "flash_grenade_mp":
				var_01 thread ninebangexplodewaiter();
				break;

			case "concussion_grenade_mp":
				var_01 thread empexplodewaiter();
				break;

			case "stun_grenade_var_mp":
			case "stun_grenade_mp":
				break;

			case "smoke_grenade_var_mp":
			case "smoke_grenade_mp":
				var_01 thread watchsmokeexplode();
				break;

			case "paint_grenade_horde_mp":
			case "paint_grenade_var_mp":
			case "paint_grenade_mp":
				var_01 thread watchpaintgrenade();
				break;
		}
	}
}

//Function Number: 38
watchoffhandcancel()
{
	self endon("death");
	self endon("disconnect");
	self endon("faux_spawn");
	self endon("grenade_fire");
	self waittill("offhand_end");
	if(isdefined(self.changingweapon) && self.changingweapon != self getcurrentweapon())
	{
		self.changingweapon = undefined;
	}
}

//Function Number: 39
watchpaintgrenade()
{
	var_00 = self.owner;
	var_00 endon("disconnect");
	var_00 endon("death");
	self waittill("explode",var_01);
	if(var_00 maps\mp\_utility::isemped() && isdefined(level.empequipmentdisabled) && level.empequipmentdisabled)
	{
		return;
	}

	detection_grenade_think(var_01,var_00);
}

//Function Number: 40
detection_grenade_think(param_00,param_01)
{
	var_02 = getdvarfloat("paintExplosionRadius");
	var_03 = 1;
	var_04 = 1.5;
	if(isdefined(level.ishorde))
	{
		var_04 = 10;
	}

	thread maps\mp\_threatdetection::detection_grenade_hud_effect(param_01,param_00,var_03,var_02);
	thread maps\mp\_threatdetection::detection_highlight_hud_effect(param_01,var_04);
	foreach(var_06 in level.players)
	{
		if(!isdefined(var_06) || !isalive(var_06) || var_06 maps\mp\_utility::_hasperk("specialty_coldblooded") || level.teambased == 1 && param_01 != var_06 && param_01.team == var_06.team)
		{
			continue;
		}

		if(distance(var_06.origin,param_00) < var_02)
		{
			if(var_06 sightconetrace(param_00))
			{
				if(param_01 == var_06)
				{
					foreach(var_08 in level.players)
					{
						if(isdefined(var_08) && level.teambased == 0 || param_01.team != var_08.team || param_01 == var_08)
						{
							thread maps\mp\_threatdetection::detection_highlight_hud_effect(var_08,var_04);
							param_01 maps\mp\_threatdetection::addthreatevent([var_08],var_04,"PAINT_GRENADE",1,0);
						}
					}

					continue;
				}

				var_06 maps\mp\_threatdetection::addthreatevent([param_01],var_04,"PAINT_GRENADE",1,0);
				param_01 maps\mp\gametypes\_damagefeedback::updatedamagefeedback("paint");
			}
		}
	}

	if(isdefined(level.agentarray))
	{
		foreach(var_0C in level.agentarray)
		{
			if(!isdefined(var_0C) || !isalive(var_0C) || isdefined(var_0C.team) && level.teambased == 1 && param_01.team == var_0C.team)
			{
				continue;
			}

			if(distance(var_0C.origin,param_00) < var_02)
			{
				if(var_0C sightconetrace(param_00))
				{
					var_0C maps\mp\_threatdetection::addthreatevent([param_01],var_04,"PAINT_GRENADE",1,0);
					param_01 maps\mp\gametypes\_damagefeedback::updatedamagefeedback("paint");
				}
			}
		}
	}
}

//Function Number: 41
watchsmokeexplode()
{
	level endon("smokeTimesUp");
	var_00 = self.owner;
	var_00 endon("disconnect");
	self waittill("explode",var_01);
	var_02 = 128;
	var_03 = 8;
	level thread waitsmoketime(var_03,var_02,var_01);
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

		wait(0.05);
	}
}

//Function Number: 42
waitsmoketime(param_00,param_01,param_02)
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

//Function Number: 43
watchmissileusage()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("missile_fire",var_00,var_01);
		var_02 = [var_00];
		if(issubstr(var_01,"_gl"))
		{
			var_00.owner = self;
			var_00.primaryweapon = self getcurrentprimaryweapon();
			var_00 thread maps\mp\gametypes\_shellshock::grenade_earthquake();
		}

		if(isdefined(var_00))
		{
			var_00.weaponname = var_01;
			if(isprimaryorsecondaryprojectileweapon(var_01))
			{
				var_00.firedads = self playerads();
			}
		}

		switch(var_01)
		{
			case "iw5_lsr_mp":
			case "stinger_mp":
				var_00.lockedstingertarget = self.stingertarget;
				level notify("stinger_fired",self,var_02);
				thread maps\mp\_utility::setaltsceneobj(var_00,"tag_origin",65);
				break;
	
			default:
				break;
		}

		switch(var_01)
		{
			case "ac130_40mm_mp":
			case "ac130_105mm_mp":
			case "rpg_mp":
			case "remotemissile_projectile_mp":
				var_00 thread maps\mp\gametypes\_shellshock::grenade_earthquake();
				break;
	
			default:
				break;
		}
	}
}

//Function Number: 44
watchhitbymissile()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("hit_by_missile",var_00,var_01,var_02,var_03,var_04,var_05,var_06,var_07);
		if(!isdefined(var_00) || !isdefined(var_01))
		{
			continue;
		}

		if(level.teambased && self.team == var_00.team)
		{
			self cancelrocketcorpse(var_01,var_03,var_04,var_05,var_06,var_07);
			continue;
		}

		if(var_02 != "rpg_mp")
		{
			self cancelrocketcorpse(var_01,var_03,var_04,var_05,var_06,var_07);
			continue;
		}

		if(randomintrange(0,100) < 99)
		{
			self cancelrocketcorpse(var_01,var_03,var_04,var_05,var_06,var_07);
			continue;
		}

		var_08 = getdvarfloat("rocket_corpse_max_air_time",0.5);
		var_09 = getdvarfloat("rocket_corpse_view_offset_up",100);
		var_0A = getdvarfloat("rocket_corpse_view_offset_forward",35);
		self.isrocketcorpse = 1;
		self setcontents(0);
		var_0B = self setrocketcorpse(1);
		var_0C = var_0B / 1000;
		self.killcament = spawn("script_model",var_01.origin);
		self.killcament.angles = var_01.angles;
		self.killcament linkto(var_01);
		self.killcament setscriptmoverkillcam("rocket_corpse");
		self.killcament setcontents(0);
		self dodamage(1000,self.origin,var_00,var_01);
		self.body = self cloneplayer(var_0B);
		self.body.origin = var_01.origin;
		self.body.angles = var_01.angles;
		self.body setcorpsefalling(0);
		self.body enablelinkto();
		self.body linkto(var_01);
		self.body setcontents(0);
		if(!isdefined(self.switching_teams))
		{
			thread maps\mp\gametypes\_deathicons::adddeathicon(self.body,self,self.team,5);
		}

		self playerhide();
		var_0D = vectornormalize(anglestoup(var_01.angles));
		var_0E = vectornormalize(anglestoforward(var_01.angles));
		var_0F = var_0E * var_09 + var_0D * var_0A;
		var_10 = var_01.origin + var_0F;
		var_11 = spawn("script_model",var_10);
		var_11 setmodel("tag_origin");
		var_11.angles = vectortoangles(var_01.origin - var_11.origin);
		var_11 linkto(var_01);
		var_11 setcontents(0);
		self cameralinkto(var_11,"tag_origin");
		if(var_08 > var_0C)
		{
			var_08 = var_0C;
		}

		var_12 = var_01 common_scripts\utility::waittill_notify_or_timeout_return("death",var_08);
		if(isdefined(var_12) && var_12 == "timeout" && isdefined(var_01))
		{
			var_01 detonate();
		}

		self notify("final_rocket_corpse_death");
		self.body unlink();
		self.body setcorpsefalling(1);
		self.body startragdoll();
		var_11 linkto(self.body);
		self.isrocketcorpse = undefined;
		self waittill("death_delay_finished");
		self cameraunlink();
		self.killcament delete();
		var_11 delete();
	}
}

//Function Number: 45
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

//Function Number: 46
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

//Function Number: 47
ninebangexplodewaiter()
{
	thread maps\mp\gametypes\_shellshock::endondeath();
	self endon("end_explode");
	self waittill("explode",var_00);
	level thread doninebang(var_00,self.owner);
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

//Function Number: 48
flashbangplayer(param_00,param_01,param_02)
{
	var_03 = 640000;
	var_04 = 40000;
	var_05 = 60;
	var_06 = 40;
	var_07 = 11;
	if(!maps\mp\_utility::isreallyalive(param_00) || param_00.sessionstate != "playing")
	{
		return;
	}

	var_08 = distancesquared(param_01,param_00.origin);
	if(var_08 > var_03)
	{
		return;
	}

	if(var_08 <= var_04)
	{
		var_09 = 1;
	}
	else
	{
		var_09 = 1 - var_09 - var_05 / var_04 - var_05;
	}

	var_0A = param_00 sightconetrace(param_01);
	if(var_0A < 0.5)
	{
		return;
	}

	var_0B = anglestoforward(param_00 getplayerangles());
	var_0C = param_00.origin;
	switch(param_00 getstance())
	{
		case "stand":
			var_0C = (var_0C[0],var_0C[1],var_0C[2] + var_05);
			break;

		case "crouch":
			var_0C = (var_0C[0],var_0C[1],var_0C[2] + var_06);
			break;

		case "prone":
			var_0C = (var_0C[0],var_0C[1],var_0C[2] + var_07);
			break;
	}

	var_0D = param_01 - var_0C;
	var_0D = vectornormalize(var_0D);
	var_0E = 0.5 * 1 + vectordot(var_0B,var_0D);
	param_00 notify("flashbang",param_01,var_09,var_0E,param_02);
}

//Function Number: 49
doninebang(param_00,param_01)
{
	level endon("game_ended");
	var_02 = 1;
	for(var_03 = 0;var_03 < var_02;var_03++)
	{
		if(var_03 > 0)
		{
			playsoundatpos(param_00,"null");
			foreach(var_05 in level.players)
			{
				flashbangplayer(var_05,param_00,param_01);
			}
		}

		var_07 = getempdamageents(param_00,512,0);
		foreach(var_09 in var_07)
		{
			if(isdefined(var_09.owner) && !friendlyfirecheck(self.owner,var_09.owner))
			{
				continue;
			}

			var_09 notify("emp_damage",self.owner,8);
		}

		wait(randomfloatrange(0.25,0.5));
	}
}

//Function Number: 50
beginc4tracking()
{
	self endon("faux_spawn");
	self endon("death");
	self endon("disconnect");
	common_scripts\utility::waittill_any("grenade_fire","weapon_change","offhand_end");
	self.changingweapon = undefined;
}

//Function Number: 51
watchforthrowbacks()
{
	self endon("faux_spawn");
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
		var_00.originalowner = self;
		var_00 thread maps\mp\gametypes\_shellshock::grenade_earthquake();
	}
}

//Function Number: 52
manuallydetonated_removeundefined(param_00)
{
	var_01 = [];
	foreach(var_03 in param_00)
	{
		if(!isdefined(var_03[0]))
		{
			continue;
		}

		var_01[var_01.size] = var_03;
	}

	return var_01;
}

//Function Number: 53
watchmanuallydetonatedusage()
{
	self endon("spawned_player");
	self endon("faux_spawn");
	self endon("disconnect");
	for(;;)
	{
		self waittill("grenade_fire",var_00,var_01);
		var_02 = isweaponmanuallydetonatedbyemptythrow(var_01);
		var_03 = isweaponmanuallydetonatedbydoubletap(var_01);
		if(var_02 || var_03)
		{
			if(!self.manuallydetonatedarray.size)
			{
				thread watchmanuallydetonatedfordoubletap();
			}

			if(self.manuallydetonatedarray.size)
			{
				self.manuallydetonatedarray = manuallydetonated_removeundefined(self.manuallydetonatedarray);
				if(self.manuallydetonatedarray.size >= level.maxperplayerexplosives)
				{
					self.manuallydetonatedarray[0][0] detonate();
				}
			}

			var_04 = self.manuallydetonatedarray.size;
			self.manuallydetonatedarray[var_04] = [];
			self.manuallydetonatedarray[var_04][0] = var_00;
			self.manuallydetonatedarray[var_04][1] = var_02;
			self.manuallydetonatedarray[var_04][2] = var_03;
			if(isdefined(var_00))
			{
				var_00.owner = self;
				var_00 setotherent(self);
				var_00.team = self.team;
				var_00.weaponname = var_01;
				var_00.stunned = 0;
			}
		}
	}
}

//Function Number: 54
watchc4usage()
{
	self endon("faux_spawn");
	self endon("spawned_player");
	self endon("disconnect");
	for(;;)
	{
		self waittill("grenade_fire",var_00,var_01);
		if(var_01 == "c4" || var_01 == "c4_mp")
		{
			level.mines[level.mines.size] = var_00;
			var_00 thread maps\mp\gametypes\_shellshock::c4_earthquake();
			var_00 thread c4damage();
			var_00 thread c4empdamage();
			var_00 thread c4empkillstreakwait();
			var_00 thread watchc4stuck();
			var_00 thread setmineteamheadicon(self.pers["team"]);
		}
	}
}

//Function Number: 55
watchc4stuck()
{
	self endon("death");
	self waittill("missile_stuck");
	self.trigger = spawn("script_origin",self.origin);
	self.trigger.owner = self;
	thread equipmentwatchuse(self.owner,1);
	makeexplosivetargetablebyai();
}

//Function Number: 56
c4empdamage()
{
	self endon("death");
	for(;;)
	{
		self waittill("emp_damage",var_00,var_01);
		playfxontag(common_scripts\utility::getfx("sentry_explode_mp"),self,"tag_origin");
		self.disabled = 1;
		self notify("disabled");
		wait(var_01);
		self.disabled = undefined;
		self notify("enabled");
	}
}

//Function Number: 57
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

//Function Number: 58
setmineteamheadicon(param_00)
{
	self endon("death");
	wait(0.05);
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

//Function Number: 59
watchclaymores()
{
	self endon("faux_spawn");
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
			var_00 common_scripts\utility::waittill_any_timeout(0.05,"missile_stuck");
			var_02 = 60;
			var_03 = (0,0,4);
			var_04 = distancesquared(self.origin,var_00.origin);
			var_05 = distancesquared(self geteye(),var_00.origin);
			var_04 = var_04 + 600;
			var_06 = var_00 getlinkedparent();
			if(isdefined(var_06))
			{
				var_00 unlink();
			}

			if(var_04 < var_05)
			{
				if(var_02 * var_02 < distancesquared(var_00.origin,self.origin))
				{
					var_07 = bullettrace(self.origin,self.origin - (0,0,var_02),0,self);
					if(var_07["fraction"] == 1)
					{
						var_00 delete();
						self setweaponammostock("claymore_mp",self setweaponammostock("claymore_mp") + 1);
						continue;
					}
					else
					{
						var_00.origin = var_07["position"];
						var_06 = var_07["entity"];
					}
				}
				else
				{
				}
			}
			else if(var_02 * var_02 < distancesquared(var_00.origin,self geteye()))
			{
				var_07 = bullettrace(self.origin,self.origin - (0,0,var_02),0,self);
				if(var_07["fraction"] == 1)
				{
					var_00 delete();
					self setweaponammostock("claymore_mp",self setweaponammostock("claymore_mp") + 1);
					continue;
				}
				else
				{
					var_00.origin = var_07["position"];
					var_06 = var_07["entity"];
				}
			}
			else
			{
				var_03 = (0,0,-5);
				var_00.angles = var_00.angles + (0,180,0);
			}

			var_00.angles = var_00.angles * (0,1,1);
			var_00.origin = var_00.origin + var_03;
			if(isdefined(var_06))
			{
				var_00 linkto(var_06);
			}

			var_00 show();
			self.claymorearray = common_scripts\utility::array_removeundefined(self.claymorearray);
			if(self.claymorearray.size >= level.maxperplayerexplosives)
			{
				deleteequipment(self.claymorearray[0]);
			}

			self.claymorearray[self.claymorearray.size] = var_00;
			var_00.owner = self;
			var_00 setotherent(self);
			var_00.team = self.team;
			var_00.weaponname = var_01;
			var_00.trigger = spawn("script_origin",var_00.origin);
			var_00.trigger.owner = var_00;
			var_00.stunned = 0;
			var_00 makeexplosivetargetablebyai();
			level.mines[level.mines.size] = var_00;
			var_00 thread c4damage();
			var_00 thread c4empdamage();
			var_00 thread c4empkillstreakwait();
			var_00 thread claymoredetonation();
			var_00 thread equipmentwatchuse(self,1);
			var_00 thread setmineteamheadicon(self.pers["team"]);
			self.changingweapon = undefined;
		}
	}
}

//Function Number: 60
equipmentenableuse(param_00)
{
	self notify("equipmentWatchUse");
	self endon("spawned_player");
	self endon("disconnect");
	self endon("equipmentWatchUse");
	self endon("change_owner");
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
}

//Function Number: 61
equipmentdisableuse(param_00)
{
	self.trigger sethintstring("");
	self.trigger maps\mp\_utility::setselfunusuable();
}

//Function Number: 62
equipmentwatchenabledisableuse(param_00)
{
	self endon("spawned_player");
	self endon("disconnect");
	self endon("death");
	param_00 endon("disconnect");
	param_00 endon("death");
	var_01 = 1;
	for(;;)
	{
		if(param_00 setweaponammostock(self.weaponname) < weaponmaxammo(self.weaponname))
		{
			if(!var_01)
			{
				equipmentenableuse(param_00);
				var_01 = 1;
			}
		}
		else if(var_01)
		{
			equipmentdisableuse(param_00);
			var_01 = 0;
		}

		wait(0.05);
	}
}

//Function Number: 63
equipmentwatchuse(param_00,param_01)
{
	self endon("spawned_player");
	self endon("disconnect");
	self endon("death");
	self endon("change_owner");
	self.trigger setcursorhint("HINT_NOICON");
	equipmentenableuse(param_00);
	if(isdefined(param_01) && param_01)
	{
		thread updatetriggerposition();
	}

	for(;;)
	{
		thread equipmentwatchenabledisableuse(param_00);
		self.trigger waittill("trigger",param_00);
		var_02 = param_00 setweaponammostock(self.weaponname);
		if(var_02 < weaponmaxammo(self.weaponname))
		{
			param_00 playlocalsound("scavenger_pack_pickup");
			param_00 setweaponammostock(self.weaponname,var_02 + 1);
			self.trigger delete();
			self delete();
			self notify("death");
		}
	}
}

//Function Number: 64
updatetriggerposition()
{
	self endon("death");
	for(;;)
	{
		if(isdefined(self) && isdefined(self.trigger))
		{
			self.trigger.origin = self.origin;
			if(isdefined(self.bombsquadmodel))
			{
				self.bombsquadmodel.origin = self.origin;
			}
		}
		else
		{
			return;
		}

		wait(0.05);
	}
}

//Function Number: 65
claymoredetonation()
{
	self endon("death");
	self endon("change_owner");
	var_00 = spawn("trigger_radius",self.origin + (0,0,0 - level.claymoredetonateradius),0,level.claymoredetonateradius,level.claymoredetonateradius * 2);
	thread deleteondeath(var_00);
	for(;;)
	{
		var_00 waittill("trigger",var_01);
		if(self.stunned)
		{
			wait(0.05);
			continue;
		}

		if(getdvarint("scr_claymoredebug") != 1)
		{
			if(isdefined(self.owner))
			{
				if(var_01 == self.owner)
				{
					continue;
				}

				if(isdefined(var_01.owner) && var_01.owner == self.owner)
				{
					continue;
				}
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
		wait(level.delayminetime);
	}
	else
	{
		wait(level.claymoredetectiongraceperiod);
	}

	if(isdefined(self.trigger))
	{
		self.trigger delete();
	}

	if(isdefined(self.owner) && isdefined(level.leaderdialogonplayer_func))
	{
		self.owner thread [[ level.leaderdialogonplayer_func ]]("claymore_destroyed",undefined,undefined,self.origin);
	}

	self detonate();
}

//Function Number: 66
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

//Function Number: 67
deleteondeath(param_00)
{
	self waittill("death");
	wait(0.05);
	if(isdefined(param_00))
	{
		if(isdefined(param_00.trigger))
		{
			param_00.trigger delete();
		}

		param_00 delete();
	}
}

//Function Number: 68
deleteequipment(param_00)
{
	if(isdefined(param_00))
	{
		if(isdefined(param_00.trigger))
		{
			param_00.trigger delete();
		}

		param_00 delete();
	}
}

//Function Number: 69
watchmanuallydetonatedfordoubletap()
{
	self endon("death");
	self endon("disconnect");
	self endon("all_detonated");
	level endon("game_ended");
	self endon("change_owner");
	var_00 = 0;
	for(;;)
	{
		if(self usebuttonpressed())
		{
			var_00 = 0;
			while(self usebuttonpressed())
			{
				var_00 = var_00 + 0.05;
				wait(0.05);
			}

			if(var_00 >= 0.5)
			{
				continue;
			}

			var_00 = 0;
			while(!self usebuttonpressed() && var_00 < 0.35)
			{
				var_00 = var_00 + 0.05;
				wait(0.05);
			}

			if(var_00 >= 0.35)
			{
				continue;
			}

			if(!self.manuallydetonatedarray.size)
			{
				return;
			}

			self notify("detonate_double_tap");
		}

		wait(0.05);
	}
}

//Function Number: 70
watchmanualdetonationbyemptythrow()
{
	self endon("death");
	self endon("faux_spawn");
	self endon("disconnect");
	for(;;)
	{
		self waittill("detonate");
		manuallydetonateall(1);
	}
}

//Function Number: 71
watchmanualdetonationbydoubletap()
{
	self endon("death");
	self endon("faux_spawn");
	self endon("disconnect");
	for(;;)
	{
		self waittill("detonate_double_tap");
		var_00 = self getcurrentweapon();
		if(!isweaponmanuallydetonatedbydoubletap(var_00))
		{
			manuallydetonateall(2);
		}
	}
}

//Function Number: 72
manuallydetonateall(param_00)
{
	var_01 = 0;
	var_02 = [];
	for(var_03 = 0;var_03 < self.manuallydetonatedarray.size;var_03++)
	{
		if(!self.manuallydetonatedarray[var_03][param_00])
		{
			var_01 = 1;
			continue;
		}

		var_04 = self.manuallydetonatedarray[var_03][0];
		if(isdefined(var_04))
		{
			if(var_04.stunned)
			{
				var_01 = 1;
				return;
			}

			if(isdefined(var_04.weaponname) && !self getdetonateenabled(var_04.weaponname))
			{
				var_01 = 1;
				continue;
			}

			if(isdefined(var_04.manuallydetonatefunc))
			{
				self thread [[ var_04.manuallydetonatefunc ]](var_04);
				continue;
			}

			var_04 thread waitanddetonate(0,param_00);
		}
	}

	if(var_01)
	{
		self.manuallydetonatedarray = manuallydetonated_removeundefined(self.manuallydetonatedarray);
		return;
	}

	self.manuallydetonatedarray = var_02;
	self notify("all_detonated");
}

//Function Number: 73
waitanddetonate(param_00,param_01)
{
	self endon("death");
	wait(param_00);
	waittillenabled();
	if(param_01 == 2)
	{
		self detonatebydoubletap();
	}
	else
	{
		self detonate();
	}

	level.mines = common_scripts\utility::array_removeundefined(level.mines);
}

//Function Number: 74
deletec4andclaymoresondisconnect()
{
	self endon("faux_spawn");
	self endon("death");
	self waittill("disconnect");
	var_00 = self.manuallydetonatedarray;
	var_01 = self.claymorearray;
	wait(0.05);
	for(var_02 = 0;var_02 < var_00.size;var_02++)
	{
		if(isdefined(var_00[var_02][0]))
		{
			var_00[var_02][0] delete();
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

//Function Number: 75
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
		if(!isplayer(var_00) && !isagent(var_00))
		{
			continue;
		}

		if(!friendlyfirecheck(self.owner,var_00))
		{
			continue;
		}

		if(isdefined(var_09))
		{
			var_0A = maps\mp\_utility::strip_suffix(var_09,"_lefthand");
			switch(var_0A)
			{
				case "smoke_grenade_var_mp":
				case "stun_grenade_var_mp":
				case "smoke_grenade_mp":
				case "stun_grenade_mp":
				case "concussion_grenade_mp":
				case "flash_grenade_mp":
					break;
			}
		}

		break;
	}

	if(level.c4explodethisframe)
	{
		wait(0.1 + randomfloat(0.4));
	}
	else
	{
		wait(0.05);
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
		if(isdefined(var_00) && isdefined(self.owner))
		{
			var_0B = var_00.pers["team"];
			var_0C = self.owner.pers["team"];
			if(isdefined(var_0B) && isdefined(var_0C) && var_0B != var_0C)
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

//Function Number: 76
resetc4explodethisframe()
{
	wait(0.05);
	level.c4explodethisframe = 0;
}

//Function Number: 77
saydamaged(param_00,param_01)
{
	for(var_02 = 0;var_02 < 60;var_02++)
	{
		wait(0.05);
	}
}

//Function Number: 78
waittillenabled()
{
	if(!isdefined(self.disabled))
	{
		return;
	}

	self waittill("enabled");
}

//Function Number: 79
makeexplosivetargetablebyai(param_00)
{
	common_scripts\utility::make_entity_sentient_mp(self.owner.team);
	if(!isdefined(param_00) || !param_00)
	{
		self makeentitynomeleetarget();
	}

	if(issentient(self))
	{
		self setthreatbiasgroup("DogsDontAttack");
	}
}

//Function Number: 80
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

//Function Number: 81
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
		wait(0.05);
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

//Function Number: 82
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
				case "vehicle_ugv_talon_gun_cloaked_mp":
				case "vehicle_ugv_talon_gun_mp":
				case "mp_remote_turret":
				case "mp_scramble_turret":
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

//Function Number: 83
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

//Function Number: 84
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

//Function Number: 85
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

//Function Number: 86
debugline(param_00,param_01,param_02)
{
	for(var_03 = 0;var_03 < 600;var_03++)
	{
		wait(0.05);
	}
}

//Function Number: 87
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

//Function Number: 88
debugprint(param_00,param_01)
{
	for(var_02 = 0;var_02 < 600;var_02++)
	{
		wait(0.05);
	}
}

//Function Number: 89
onweapondamage(param_00,param_01,param_02,param_03,param_04)
{
	self endon("death");
	self endon("disconnect");
	var_05 = 700;
	var_06 = 25;
	var_07 = var_05 * var_05;
	var_08 = var_06 * var_06;
	var_09 = 60;
	var_0A = 40;
	var_0B = 11;
	if(issubstr(param_01,"_uts19_"))
	{
		thread uts19shock(param_00);
		return;
	}

	var_0C = maps\mp\_utility::strip_suffix(param_01,"_lefthand");
	switch(var_0C)
	{
		case "stun_grenade_var_mp":
		case "stun_grenade_mp":
		case "stun_grenade_horde_mp":
			var_0D = param_00.origin;
			var_0E = distancesquared(var_0D,self.origin);
			if(var_0E > var_07)
			{
				return;
			}
	
			var_0F = self sightconetrace(var_0D);
			if(var_0F < 0.5)
			{
				return;
			}
	
			if(var_0E <= var_08)
			{
				var_10 = 1;
			}
			else
			{
				var_10 = 1 - var_0F - var_09 / var_08 - var_09;
			}
	
			var_11 = anglestoforward(self getplayerangles());
			var_12 = self.origin;
			switch(self getstance())
			{
				case "stand":
					var_12 = (var_12[0],var_12[1],var_12[2] + var_09);
					break;
	
				case "crouch":
					var_12 = (var_12[0],var_12[1],var_12[2] + var_0A);
					break;
	
				case "prone":
					var_12 = (var_12[0],var_12[1],var_12[2] + var_0B);
					break;
			}
	
			var_13 = var_0D - var_12;
			var_13 = vectornormalize(var_13);
			var_14 = 0.5 * 1 + vectordot(var_11,var_13);
			if(!isdefined(param_00))
			{
				return;
			}
			else if(param_02 == "MOD_IMPACT")
			{
				return;
			}
	
			var_15 = 1;
			if(isdefined(param_00.owner) && param_00.owner == param_04)
			{
				var_15 = 0;
			}
	
			var_16 = 3;
			if(isdefined(self.stunscaler))
			{
				var_16 = var_16 * self.stunscaler;
			}
	
			wait(0.05);
			self notify("concussed",param_04);
			if(param_04 != self)
			{
				param_04 maps\mp\gametypes\_missions::processchallenge("ch_alittleconcussed");
			}
	
			var_17 = var_10 * var_14 * var_16;
			self shellshock("stun_grenade_mp",var_17,0,1,var_10 * var_16);
			self.concussionendtime = gettime() + var_16 * 1000;
			if(var_17 > 0.1)
			{
				thread maps\mp\_utility::light_set_override_for_player("flashed",0.1,0.1,var_10 * var_14 * var_16 - 0.1);
			}
	
			if(var_15 && param_04 != self)
			{
				param_04 thread maps\mp\gametypes\_damagefeedback::updatedamagefeedback("stun");
			}
			break;

		case "concussion_grenade_mp":
			if(!isdefined(param_00))
			{
				return;
			}
			else if(param_02 == "MOD_IMPACT")
			{
				return;
			}
	
			var_15 = 1;
			if(isdefined(param_00.owner) && param_00.owner == param_04)
			{
				var_15 = 0;
			}
	
			var_18 = 512;
			var_19 = 1 - distance(self.origin,param_00.origin) / var_18;
			if(var_19 < 0)
			{
				var_19 = 0;
			}
	
			var_16 = 2 + 4 * var_19;
			if(isdefined(self.stunscaler))
			{
				var_16 = var_16 * self.stunscaler;
			}
	
			wait(0.05);
			self notify("concussed",param_04);
			if(param_04 != self)
			{
				param_04 maps\mp\gametypes\_missions::processchallenge("ch_alittleconcussed");
			}
	
			self shellshock("concussion_grenade_mp",var_16);
			self.concussionendtime = gettime() + var_16 * 1000;
			if(var_15 && param_04 != self)
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

//Function Number: 90
uts19shock(param_00)
{
	if(getdvarint("scr_game_uts19_shock",0) == 0)
	{
		return;
	}

	if(!isdefined(param_00))
	{
		return;
	}

	var_01 = 0.45;
	var_02 = 1.2;
	var_03 = 250;
	var_04 = 700;
	var_05 = distance(self.origin,param_00.origin) - var_03 / var_04 - var_03;
	var_06 = 1 - var_05;
	var_06 = clamp(var_06,0,1);
	var_07 = var_01 + var_02 - var_01 * var_06;
	if(isdefined(self.utsshockqueuedtime))
	{
		if(self.utsshockqueuedtime >= var_07)
		{
			return;
		}
	}

	self.utsshockqueuedtime = var_07;
	self shellshock("uts19_mp",var_07);
	waittillframeend;
	if(isdefined(self))
	{
		self.utsshockqueuedtime = undefined;
	}
}

//Function Number: 91
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
		case "rocketlauncher":
		case "beam":
		case "smg":
		case "mg":
		case "pistol":
		case "rifle":
		case "sniper":
		case "spread":
			return 1;

		default:
			return 0;
	}
}

//Function Number: 92
isbulletweapon(param_00)
{
	if(param_00 == "none")
	{
		return 0;
	}

	switch(maps\mp\_utility::getweaponclass(param_00))
	{
		case "weapon_machine_pistol":
		case "weapon_pistol":
		case "weapon_shotgun":
		case "weapon_lmg":
		case "weapon_sniper":
		case "weapon_assault":
		case "weapon_smg":
			return 1;

		case "weapon_heavy":
			return issubstr(param_00,"exoxmg") || issubstr(param_00,"lsat") || issubstr(param_00,"asaw") || issubstr(param_00,"dlcgun2_mp") || issubstr(param_00,"dlcgun2loot");

		case "weapon_special":
			return issubstr(param_00,"dlcgun3_mp") || issubstr(param_00,"dlcgun3loot") || issubstr(param_00,"dlcgun5loot5");

		default:
			return 0;
	}
}

//Function Number: 93
isbeamweapon(param_00)
{
	return issubstr(param_00,"em1") || issubstr(param_00,"epm3") || issubstr(param_00,"dlcgun1_") || issubstr(param_00,"dlcgun1loot") || issubstr(param_00,"dlcgun9loot6");
}

//Function Number: 94
isaltmodeweapon(param_00)
{
	if(param_00 == "none")
	{
		return 0;
	}

	return weaponinventorytype(param_00) == "altmode";
}

//Function Number: 95
isinventoryweapon(param_00)
{
	if(param_00 == "none")
	{
		return 0;
	}

	return weaponinventorytype(param_00) == "item";
}

//Function Number: 96
isriotshield(param_00)
{
	if(param_00 == "none")
	{
		return 0;
	}

	return weapontype(param_00) == "riotshield";
}

//Function Number: 97
isoffhandweapon(param_00)
{
	if(param_00 == "none")
	{
		return 0;
	}

	return weaponinventorytype(param_00) == "offhand";
}

//Function Number: 98
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

//Function Number: 99
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

	return 1;
}

//Function Number: 100
isvalidlastweapon(param_00)
{
	if(param_00 == "none")
	{
		return 0;
	}

	var_01 = weaponinventorytype(param_00);
	return var_01 == "primary" || var_01 == "altmode";
}

//Function Number: 101
updatesavedlastweapon()
{
	self endon("death");
	self endon("disconnect");
	self endon("faux_spawn");
	var_00 = self.currentweaponatspawn;
	self.saved_lastweapon = var_00;
	setweaponusagevariables(var_00);
	for(;;)
	{
		self waittill("weapon_change",var_01);
		updateweaponusagestats(var_01);
		if(isvalidmovespeedscaleweapon(var_01))
		{
			updatemovespeedscale();
		}

		self.saved_lastweapon = var_00;
		if(isvalidlastweapon(var_01))
		{
			var_00 = var_01;
		}
	}
}

//Function Number: 102
updateweaponusagestats(param_00)
{
	var_01 = int(gettime() - self.weaponusagestarttime / 1000);
	thread setweaponstat(self.weaponusagename,var_01,"timeInUse");
	setweaponusagevariables(param_00);
}

//Function Number: 103
setweaponusagevariables(param_00)
{
	self.weaponusagename = param_00;
	self.weaponusagestarttime = gettime();
}

//Function Number: 104
empplayer(param_00)
{
	self endon("disconnect");
	self endon("death");
	thread clearempondeath();
}

//Function Number: 105
clearempondeath()
{
	self endon("disconnect");
	self waittill("death");
}

//Function Number: 106
getweaponheaviestvalue()
{
	var_00 = 1000;
	self.weaponlist = self getweaponslistprimaries();
	if(self.weaponlist.size)
	{
		foreach(var_02 in self.weaponlist)
		{
			var_03 = getweaponweight(var_02);
			if(var_03 == 0)
			{
				continue;
			}

			if(var_03 < var_00)
			{
				var_00 = var_03;
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

	var_00 = clampweaponweightvalue(var_00);
	return var_00;
}

//Function Number: 107
getweaponweight(param_00)
{
	var_01 = undefined;
	var_02 = maps\mp\_utility::getbaseweaponname(param_00);
	if(isdefined(level.weaponweightfunc))
	{
		return [[ level.weaponweightfunc ]](var_02);
	}

	var_01 = int(tablelookup("mp/statstable.csv",4,var_02,8));
	return var_01;
}

//Function Number: 108
clampweaponweightvalue(param_00)
{
	return clamp(param_00,0,10);
}

//Function Number: 109
isvalidmovespeedscaleweapon(param_00)
{
	if(isvalidlastweapon(param_00))
	{
		return 1;
	}

	var_01 = weaponclass(param_00);
	if(var_01 == "ball")
	{
		return 1;
	}

	return 0;
}

//Function Number: 110
updatemovespeedscale()
{
	var_00 = undefined;
	self.weaponlist = self getweaponslistprimaries();
	if(!self.weaponlist.size)
	{
		var_00 = 8;
	}
	else
	{
		var_01 = self getcurrentweapon();
		if(!isvalidmovespeedscaleweapon(var_01))
		{
			if(isdefined(self.saved_lastweapon))
			{
				var_01 = self.saved_lastweapon;
			}
			else
			{
				var_01 = undefined;
			}
		}

		if(!isdefined(var_01) || !self hasweapon(var_01))
		{
			var_00 = getweaponheaviestvalue();
		}
		else if(maps\mp\_utility::getbaseweaponname(var_01) == "iw5_underwater")
		{
			var_00 = 5;
		}
		else
		{
			var_00 = getweaponweight(var_01);
			var_00 = clampweaponweightvalue(var_00);
		}
	}

	var_02 = var_00 / 10;
	self.weaponspeed = var_02;
	self setmovespeedscale(var_02 * self.movespeedscaler);
}

//Function Number: 111
stancerecoiladjuster()
{
	if(!isplayer(self))
	{
		return;
	}

	self endon("death");
	self endon("disconnect");
	self endon("faux_spawn");
	self notifyonplayercommand("adjustedStance","+stance");
	self notifyonplayercommand("adjustedStance","+goStand");
	for(;;)
	{
		common_scripts\utility::waittill_any("adjustedStance","sprint_begin","weapon_change");
		wait(0.5);
		self.stance = self getstance();
		if(self.stance == "prone")
		{
			var_00 = self getcurrentprimaryweapon();
			var_01 = maps\mp\_utility::getweaponclass(var_00);
			if(var_01 == "weapon_lmg")
			{
				maps\mp\_utility::setrecoilscale(0,40);
			}
			else if(var_01 == "weapon_sniper")
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
			var_00 = self getcurrentprimaryweapon();
			var_01 = maps\mp\_utility::getweaponclass(var_00);
			if(var_01 == "weapon_lmg")
			{
				maps\mp\_utility::setrecoilscale(0,10);
			}
			else if(var_01 == "weapon_sniper")
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

//Function Number: 112
buildweapondata(param_00)
{
}

//Function Number: 113
monitorsemtex()
{
	self endon("disconnect");
	self endon("death");
	self endon("faux_spawn");
	for(;;)
	{
		self waittill("grenade_fire",var_00);
		if(!isdefined(var_00))
		{
			continue;
		}

		if(!isdefined(var_00.weaponname))
		{
			continue;
		}

		if(!issubstr(var_00.weaponname,"semtex"))
		{
			continue;
		}

		var_00 thread monitorsemtexstick();
	}
}

//Function Number: 114
monitorsemtexstick()
{
	self.owner endon("disconnect");
	self.owner endon("death");
	self.owner endon("faux_spawn");
	self waittill("missile_stuck",var_00);
	thread stickyhandlemovers("detonate");
	if(!isplayer(var_00))
	{
		return;
	}

	if(self.owner isstucktofriendly(var_00))
	{
		self.owner.isstuck = "friendly";
		return;
	}

	self.isstuck = "enemy";
	self.stuckenemyentity = var_00;
	self.owner maps\mp\_events::semtexstickevent(var_00);
	self.owner notify("process","ch_bullseye");
}

//Function Number: 115
isstucktofriendly(param_00)
{
	return level.teambased && isdefined(param_00.team) && param_00.team == self.team;
}

//Function Number: 116
turret_monitoruse()
{
	for(;;)
	{
		self waittill("trigger",var_00);
		thread turret_playerthread(var_00);
	}
}

//Function Number: 117
turret_playerthread(param_00)
{
	param_00 endon("death");
	param_00 endon("disconnect");
	param_00 notify("weapon_change","none");
	self waittill("turret_deactivate");
	param_00 notify("weapon_change",param_00 getcurrentweapon());
}

//Function Number: 118
spawnmine(param_00,param_01,param_02,param_03,param_04)
{
	if(!isdefined(param_03))
	{
		param_03 = (0,randomfloat(360),0);
	}

	var_05 = "projectile_bouncing_betty_grenade";
	var_06 = spawn("script_model",param_00);
	var_06.angles = param_03;
	var_06 setmodel(var_05);
	var_06.owner = param_01;
	var_06.stunned = 0;
	var_06 setotherent(param_01);
	var_06.weaponname = "bouncingbetty_mp";
	level.mines[level.mines.size] = var_06;
	var_06.killcamoffset = (0,0,4);
	var_06.killcament = spawn("script_model",var_06.origin + var_06.killcamoffset);
	var_06.killcament setscriptmoverkillcam("explosive");
	param_01.equipmentmines = common_scripts\utility::array_removeundefined(param_01.equipmentmines);
	if(param_01.equipmentmines.size >= level.maxperplayerexplosives)
	{
		param_01.equipmentmines[0] delete();
	}

	param_01.equipmentmines[param_01.equipmentmines.size] = var_06;
	var_06 thread createbombsquadmodel("projectile_bouncing_betty_grenade_bombsquad","tag_origin",param_01);
	var_06 thread minebeacon();
	var_06 thread setmineteamheadicon(param_01.pers["team"]);
	var_06 thread minedamagemonitor();
	var_06 thread mineproximitytrigger();
	var_07 = self getlinkedparent();
	if(isdefined(var_07))
	{
		var_06 linkto(var_07);
	}

	var_06 makeexplosivetargetablebyai(!param_04);
	return var_06;
}

//Function Number: 119
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
		if(!isplayer(var_00) && !isagent(var_00))
		{
			continue;
		}

		if(isdefined(var_09) && var_09 == "bouncingbetty_mp")
		{
			continue;
		}

		if(!friendlyfirecheck(self.owner,var_00))
		{
			continue;
		}

		if(isdefined(var_09))
		{
			var_0A = maps\mp\_utility::strip_suffix(var_09,"_lefthand");
			switch(var_0A)
			{
				case "smoke_grenade_var_mp":
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
		if(isdefined(var_00) && isdefined(self.owner))
		{
			var_0B = var_00.pers["team"];
			var_0C = self.owner.pers["team"];
			if(isdefined(var_0B) && isdefined(var_0C) && var_0B != var_0C)
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

//Function Number: 120
mineproximitytrigger()
{
	self endon("mine_destroyed");
	self endon("mine_selfdestruct");
	self endon("death");
	wait(2);
	var_00 = spawn("trigger_radius",self.origin,0,level.minedetectionradius,level.minedetectionheight);
	var_00.owner = self;
	thread minedeletetrigger(var_00);
	var_01 = undefined;
	for(;;)
	{
		var_00 waittill("trigger",var_01);
		if(self.stunned)
		{
			continue;
		}

		if(getdvarint("scr_minesKillOwner") != 1)
		{
			if(isdefined(self.owner))
			{
				if(var_01 == self.owner)
				{
					continue;
				}

				if(isdefined(var_01.owner) && var_01.owner == self.owner)
				{
					continue;
				}
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
		wait(level.delayminetime);
	}
	else
	{
		wait(level.minedetectiongraceperiod);
	}

	thread minebounce();
}

//Function Number: 121
minedeletetrigger(param_00)
{
	common_scripts\utility::waittill_any("mine_triggered","mine_destroyed","mine_selfdestruct","death");
	param_00 delete();
}

//Function Number: 122
mineselfdestruct()
{
	self endon("mine_triggered");
	self endon("mine_destroyed");
	self endon("death");
	wait(level.mineselfdestructtime);
	wait(randomfloat(0.4));
	self notify("mine_selfdestruct");
	thread mineexplode();
}

//Function Number: 123
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
	wait(0.65);
	thread mineexplode();
}

//Function Number: 124
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

	self playsound("null");
	var_01 = self gettagorigin("tag_fx");
	playfx(level.mine_explode,var_01);
	wait(0.05);
	if(!isdefined(self) || !isdefined(self.owner))
	{
		return;
	}

	self hide();
	self radiusdamage(self.origin,level.minedamageradius,level.minedamagemax,level.minedamagemin,param_00,"MOD_EXPLOSIVE");
	if(isdefined(self.owner) && isdefined(level.leaderdialogonplayer_func))
	{
		self.owner thread [[ level.leaderdialogonplayer_func ]]("mine_destroyed",undefined,undefined,self.origin);
	}

	wait(0.2);
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

//Function Number: 125
minestunbegin()
{
	if(self.stunned)
	{
		return;
	}

	self.stunned = 1;
	playfxontag(common_scripts\utility::getfx("mine_stunned"),self,"tag_origin");
}

//Function Number: 126
minestunend()
{
	self.stunned = 0;
	stopfxontag(common_scripts\utility::getfx("mine_stunned"),self,"tag_origin");
}

//Function Number: 127
minechangeowner(param_00)
{
	if(isdefined(self.weaponname))
	{
		if(isdefined(self.entityheadicon))
		{
			self.entityheadicon destroy();
		}

		if(self.weaponname == "bouncingbetty_mp")
		{
			if(isdefined(self.trigger))
			{
				self.trigger delete();
			}

			if(isdefined(self.effect["friendly"]))
			{
				self.effect["friendly"] delete();
			}

			if(isdefined(self.effect["enemy"]))
			{
				self.effect["enemy"] delete();
			}

			for(var_01 = 0;var_01 < self.owner.equipmentmines.size;var_01++)
			{
				if(self.owner.equipmentmines[var_01] == self)
				{
					self.owner.equipmentmines[var_01] = undefined;
				}
			}

			self.owner.equipmentmines = common_scripts\utility::array_removeundefined(self.owner.equipmentmines);
			self notify("change_owner");
			self.owner = param_00;
			self.owner.equipmentmines[self.owner.equipmentmines.size] = self;
			self.team = param_00.team;
			self setotherent(param_00);
			self.trigger = spawn("script_origin",self.origin + (0,0,25));
			self.trigger.owner = self;
			equipmentdisableuse(param_00);
			thread minebeacon();
			thread setmineteamheadicon(param_00.team);
			param_00 thread minewatchownerdisconnect(self);
			param_00 thread minewatchownerchangeteams(self);
			return;
		}

		if(self.weaponname == "claymore_mp")
		{
			if(isdefined(self.trigger))
			{
				self.trigger delete();
			}

			for(var_01 = 0;var_01 < self.owner.claymorearray.size;var_01++)
			{
				if(self.owner.claymorearray[var_01] == self)
				{
					self.owner.claymorearray[var_01] = undefined;
				}
			}

			self.owner.claymorearray = common_scripts\utility::array_removeundefined(self.owner.claymorearray);
			self notify("change_owner");
			self.owner = param_00;
			self.owner.claymorearray[self.owner.claymorearray.size] = self;
			self.team = param_00.team;
			self setotherent(param_00);
			self.trigger = spawn("script_origin",self.origin);
			self.trigger.owner = self;
			equipmentdisableuse(param_00);
			thread setmineteamheadicon(param_00.team);
			param_00 thread minewatchownerdisconnect(self);
			param_00 thread minewatchownerchangeteams(self);
			thread claymoredetonation();
			return;
		}

		if(self.weaponname == "c4_mp")
		{
			var_02 = 0;
			var_03 = 0;
			for(var_01 = 0;var_01 < self.owner.manuallydetonatedarray.size;var_01++)
			{
				if(self.owner.manuallydetonatedarray[var_01][0] == self)
				{
					self.owner.manuallydetonatedarray[var_01][0] = undefined;
					var_02 = self.owner.manuallydetonatedarray[var_01][1];
					var_03 = self.owner.manuallydetonatedarray[var_01][2];
				}
			}

			self.owner.manuallydetonatedarray = manuallydetonated_removeundefined(self.owner.manuallydetonatedarray);
			self notify("change_owner");
			self.owner = param_00;
			var_04 = self.owner.manuallydetonatedarray.size;
			self.owner.manuallydetonatedarray[var_04] = [];
			self.owner.manuallydetonatedarray[var_04][0] = self;
			self.owner.manuallydetonatedarray[var_04][1] = var_02;
			self.owner.manuallydetonatedarray[var_04][2] = var_03;
			self.team = param_00.team;
			self setotherent(param_00);
			equipmentdisableuse(param_00);
			thread setmineteamheadicon(param_00.team);
			return;
		}

		return;
	}
}

//Function Number: 128
playspinnerfx()
{
	self endon("death");
	var_00 = gettime() + 1000;
	while(gettime() < var_00)
	{
		wait(0.05);
		playfxontag(level.mine_spin,self,"tag_fx_spin1");
		playfxontag(level.mine_spin,self,"tag_fx_spin3");
		wait(0.05);
		playfxontag(level.mine_spin,self,"tag_fx_spin2");
		playfxontag(level.mine_spin,self,"tag_fx_spin4");
	}
}

//Function Number: 129
minedamagedebug(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06[0] = (1,0,0);
	var_06[1] = (0,1,0);
	if(param_01[2] < param_05)
	{
		var_07 = 0;
	}
	else
	{
		var_07 = 1;
	}

	var_08 = (param_00[0],param_00[1],param_05);
	var_09 = (param_01[0],param_01[1],param_05);
	thread debugcircle(var_08,level.minedamageradius,var_06[var_07],32);
	var_0A = distancesquared(param_00,param_01);
	if(var_0A > param_02)
	{
		var_07 = 0;
	}
	else
	{
		var_07 = 1;
	}

	thread debugline(var_08,var_09,var_06[var_07]);
}

//Function Number: 130
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

//Function Number: 131
watchslide()
{
	self endon("disconnect");
	self endon("spawned_player");
	self endon("faux_spawn");
	for(;;)
	{
		self.issiliding = 0;
		self waittill("sprint_slide_begin");
		self.issiliding = 1;
		self.lastslidetime = gettime();
		self waittill("sprint_slide_end");
	}
}

//Function Number: 132
watchmineusage()
{
	self endon("disconnect");
	self endon("spawned_player");
	self endon("faux_spawn");
	if(isdefined(self.equipmentmines))
	{
		if(maps\mp\_utility::getintproperty("scr_deleteexplosivesonspawn",1) == 1)
		{
			if(isdefined(self.dont_delete_mines_on_next_spawn))
			{
				self.dont_delete_mines_on_next_spawn = undefined;
			}
			else
			{
				delete_all_mines();
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
		self waittill("grenade_fire",var_00,var_01);
		if(var_01 == "bouncingbetty" || var_01 == "bouncingbetty_mp")
		{
			if(!isalive(self))
			{
				var_00 delete();
				return;
			}

			maps\mp\gametypes\_gamelogic::sethasdonecombat(self,1);
			var_00 thread minethrown(self,1);
		}
	}
}

//Function Number: 133
minethrown(param_00,param_01)
{
	self.owner = param_00;
	self waittill("missile_stuck");
	if(!isdefined(param_00))
	{
		return;
	}

	var_02 = bullettrace(self.origin + (0,0,4),self.origin - (0,0,4),0,self);
	var_03 = var_02["position"];
	if(var_02["fraction"] == 1)
	{
		var_03 = getgroundposition(self.origin,12,0,32);
		var_02["normal"] = var_02["normal"] * -1;
	}

	var_04 = vectornormalize(var_02["normal"]);
	var_05 = vectortoangles(var_04);
	var_05 = var_05 + (90,0,0);
	var_06 = spawnmine(var_03,param_00,undefined,var_05,param_01);
	var_06.trigger = spawn("script_origin",var_06.origin + (0,0,25));
	var_06.trigger.owner = var_06;
	var_06 thread equipmentwatchuse(param_00);
	param_00 thread minewatchownerdisconnect(var_06);
	param_00 thread minewatchownerchangeteams(var_06);
	self delete();
}

//Function Number: 134
minewatchownerdisconnect(param_00)
{
	param_00 endon("death");
	level endon("game_ended");
	param_00 endon("change_owner");
	self waittill("disconnect");
	if(isdefined(param_00.trigger))
	{
		param_00.trigger delete();
	}

	param_00 delete();
}

//Function Number: 135
minewatchownerchangeteams(param_00)
{
	param_00 endon("death");
	level endon("game_ended");
	param_00 endon("change_owner");
	common_scripts\utility::waittill_either("joined_team","joined_spectators");
	if(isdefined(param_00.trigger))
	{
		param_00.trigger delete();
	}

	param_00 delete();
}

//Function Number: 136
minebeacon()
{
	self endon("change_owner");
	self.effect["friendly"] = spawnfx(level.mine_beacon["friendly"],self gettagorigin("tag_fx"));
	self.effect["enemy"] = spawnfx(level.mine_beacon["enemy"],self gettagorigin("tag_fx"));
	thread minebeaconteamupdater();
	self waittill("death");
	self.effect["friendly"] delete();
	self.effect["enemy"] delete();
}

//Function Number: 137
minebeaconteamupdater()
{
	self endon("death");
	self endon("change_owner");
	var_00 = self.owner.team;
	wait(0.05);
	triggerfx(self.effect["friendly"]);
	triggerfx(self.effect["enemy"]);
	for(;;)
	{
		self.effect["friendly"] hide();
		self.effect["enemy"] hide();
		foreach(var_02 in level.players)
		{
			if(level.teambased)
			{
				if(var_02.team == var_00)
				{
					self.effect["friendly"] showtoplayer(var_02);
				}
				else
				{
					self.effect["enemy"] showtoplayer(var_02);
				}

				continue;
			}

			if(var_02 == self.owner)
			{
				self.effect["friendly"] showtoplayer(var_02);
				continue;
			}

			self.effect["enemy"] showtoplayer(var_02);
		}

		level common_scripts\utility::waittill_either("joined_team","player_spawned");
	}
}

//Function Number: 138
delete_all_grenades()
{
	if(isdefined(self.manuallydetonatedarray))
	{
		for(var_00 = 0;var_00 < self.manuallydetonatedarray.size;var_00++)
		{
			if(isdefined(self.manuallydetonatedarray[var_00][0]))
			{
				if(isdefined(self.manuallydetonatedarray[var_00][0].trigger))
				{
					self.manuallydetonatedarray[var_00][0].trigger delete();
				}

				self.manuallydetonatedarray[var_00][0] delete();
			}
		}
	}

	self.manuallydetonatedarray = [];
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

//Function Number: 139
delete_all_mines()
{
	if(isdefined(self.equipmentmines))
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

//Function Number: 140
transfer_grenade_ownership(param_00)
{
	param_00 delete_all_grenades();
	param_00 delete_all_mines();
	if(isdefined(self.manuallydetonatedarray))
	{
		param_00.manuallydetonatedarray = manuallydetonated_removeundefined(self.manuallydetonatedarray);
	}
	else
	{
		param_00.manuallydetonatedarray = undefined;
	}

	if(isdefined(self.claymorearray))
	{
		param_00.claymorearray = common_scripts\utility::array_removeundefined(self.claymorearray);
	}
	else
	{
		param_00.claymorearray = undefined;
	}

	if(isdefined(self.bouncingbettyarray))
	{
		param_00.bouncingbettyarray = common_scripts\utility::array_removeundefined(self.bouncingbettyarray);
	}
	else
	{
		param_00.bouncingbettyarray = undefined;
	}

	if(isdefined(self.equipmentmines))
	{
		param_00.equipmentmines = common_scripts\utility::array_removeundefined(self.equipmentmines);
	}
	else
	{
		param_00.equipmentmines = undefined;
	}

	if(isdefined(self.killstreakmines))
	{
		param_00.killstreakmines = common_scripts\utility::array_removeundefined(self.killstreakmines);
	}
	else
	{
		param_00.killstreakmines = undefined;
	}

	if(isdefined(param_00.manuallydetonatedarray))
	{
		foreach(var_02 in param_00.manuallydetonatedarray)
		{
			var_02[0].owner = param_00;
			var_02[0] thread equipmentwatchuse(param_00);
		}
	}

	if(isdefined(param_00.claymorearray))
	{
		foreach(var_05 in param_00.claymorearray)
		{
			var_05.owner = param_00;
			var_05 thread equipmentwatchuse(param_00);
		}
	}

	if(isdefined(param_00.bouncingbettyarray))
	{
		foreach(var_08 in param_00.bouncingbettyarray)
		{
			var_08.owner = param_00;
			var_08 thread equipmentwatchuse(param_00);
		}
	}

	if(isdefined(param_00.equipmentmines))
	{
		foreach(var_0B in param_00.equipmentmines)
		{
			var_0B.owner = param_00;
			var_0B thread equipmentwatchuse(param_00);
		}
	}

	if(isdefined(param_00.killstreakmines))
	{
		foreach(var_0E in param_00.killstreakmines)
		{
			var_0E.owner = param_00;
			var_0E thread equipmentwatchuse(param_00);
		}
	}

	self.manuallydetonatedarray = [];
	self.claymorearray = [];
	self.bouncingbettyarray = [];
	self.equipmentmines = [];
	self.killstreakmines = [];
	self.dont_delete_grenades_on_next_spawn = 1;
	self.dont_delete_mines_on_next_spawn = 1;
}

//Function Number: 141
update_em1_heat_omnvar()
{
	level endon("game_ended");
	self endon("disconnect");
	for(;;)
	{
		var_00 = self getcurrentweapon();
		if(issubstr(var_00,"em1") || issubstr(var_00,"epm3") || issubstr(var_00,"dlcgun1_") || issubstr(var_00,"dlcgun1loot") || issubstr(var_00,"dlcgun9loot6") || issubstr(var_00,"dlcgun10loot6") || issubstr(var_00,"dlcgun10loot4"))
		{
			var_01 = self getweaponheatlevel(var_00);
			self setclientomnvar("ui_em1_heat",var_01);
		}

		wait(0.05);
	}
}

//Function Number: 142
equipmentdeathvfx()
{
	playfx(common_scripts\utility::getfx("equipment_sparks"),self.origin);
	self playsound("sentry_explode");
}

//Function Number: 143
equipmentdeletevfx()
{
	playfx(common_scripts\utility::getfx("equipment_explode_big"),self.origin);
	playfx(common_scripts\utility::getfx("equipment_smoke"),self.origin);
}

//Function Number: 144
equipmentempstunvfx()
{
	playfxontag(common_scripts\utility::getfx("emp_stun"),self,"tag_origin");
}

//Function Number: 145
track_damage_info()
{
	self.damage_info = [];
	thread reset_damage_info_when_healed();
}

//Function Number: 146
reset_damage_info_when_healed()
{
	self endon("death");
	self endon("disconnect");
	self endon("faux_spawn");
	for(;;)
	{
		if(self.health >= 100 && isdefined(self.damage_info) && self.damage_info.size > 0)
		{
			self.damage_info = [];
		}

		wait(0.05);
	}
}

//Function Number: 147
stickyhandlemovers(param_00,param_01)
{
	var_02 = spawnstruct();
	if(isdefined(param_00))
	{
		var_02.notifystring = param_00;
	}

	if(isdefined(param_01))
	{
		var_02.endonstring = param_01;
	}

	var_02.deathoverridecallback = ::stickymovingplatformdetonate;
	thread maps\mp\_movers::handle_moving_platforms(var_02);
}

//Function Number: 148
stickymovingplatformdetonate(param_00)
{
	if(!isdefined(self))
	{
		return;
	}

	self endon("death");
	if(isdefined(self))
	{
		if(isdefined(param_00.notifystring))
		{
			if(param_00.notifystring == "detonate")
			{
				self detonate();
				return;
			}

			self notify(param_00.notifystring);
			return;
		}

		self delete();
	}
}

//Function Number: 149
getgrenadegraceperiodtimeleft()
{
	var_00 = 10;
	if(isdefined(level.grenadegraceperiod))
	{
		var_00 = level.grenadegraceperiod;
	}

	var_01 = 0;
	if(isdefined(level.prematch_done_time))
	{
		var_01 = gettime() - level.prematch_done_time / 1000;
	}

	return var_00 - var_01;
}

//Function Number: 150
ingrenadegraceperiod()
{
	return getgrenadegraceperiodtimeleft() > 0;
}

//Function Number: 151
isweaponallowedingrenadegraceperiod(param_00)
{
	if(isendstr(param_00,"_gl"))
	{
		return 0;
	}

	switch(param_00)
	{
		case "frag_grenade_mp_lefthand":
		case "explosive_drone_mp_lefthand":
		case "semtex_mp_lefthand":
		case "explosive_drone_mp":
		case "semtex_mp":
		case "frag_grenade_mp":
			return 0;

		default:
			break;
	}

	var_01 = getweaponbasename(param_00);
	if(isdefined(var_01))
	{
		switch(var_01)
		{
			case "iw5_stingerm7_mp":
			case "iw5_microdronelauncher_mp":
			case "iw5_exocrossbow_mp":
			case "iw5_maaws_mp":
			case "iw5_mahem_mp":
				return 0;

			default:
				break;
		}
	}

	return 1;
}

//Function Number: 152
watchgrenadegraceperiod()
{
	self endon("death");
	self endon("disconnect");
	self endon("faux_spawn");
	for(;;)
	{
		var_00 = common_scripts\utility::waittill_any_return_parms("grenade_fire","missile_fire");
		var_01 = var_00[0];
		var_02 = var_00[1];
		var_03 = var_00[2];
		if(!isdefined(var_03) || var_03 == "")
		{
			continue;
		}

		if(ingrenadegraceperiod())
		{
			if(!isweaponallowedingrenadegraceperiod(var_03))
			{
				var_04 = int(getgrenadegraceperiodtimeleft() + 0.5);
				if(!var_04)
				{
					var_04 = 1;
				}

				if(isplayer(self))
				{
					self iprintlnbold(&"MP_EXPLOSIVES_UNAVAILABLE_FOR_N",var_04);
				}
			}

			continue;
		}

		break;
	}
}

//Function Number: 153
isprimaryorsecondaryprojectileweapon(param_00)
{
	var_01 = maps\mp\_utility::getweaponclass(param_00);
	var_02 = maps\mp\_utility::getbaseweaponname(param_00);
	if(var_01 == "weapon_projectile")
	{
		return 1;
	}

	if(isdefined(var_02) && issubstr(var_02,"microdronelauncher") || issubstr(var_02,"exocrossbow"))
	{
		return 1;
	}

	return 0;
}

//Function Number: 154
saveweapon(param_00,param_01,param_02)
{
	var_03 = self.saveweapons.size;
	if(var_03 == 0)
	{
		self.firstsaveweapon = param_01;
	}

	self.saveweapons[var_03]["type"] = param_00;
	self.saveweapons[var_03]["use"] = param_02;
}

//Function Number: 155
getsavedweapon(param_00)
{
	var_01 = self.saveweapons.size;
	var_02 = -1;
	for(var_03 = 0;var_03 < var_01;var_03++)
	{
		if(self.saveweapons[var_03]["type"] == param_00)
		{
			var_02 = var_03;
			break;
		}
	}

	if(var_02 >= 0)
	{
		return self.saveweapons[var_02]["use"];
	}

	return "none";
}

//Function Number: 156
restoreweapon(param_00)
{
	var_01 = [];
	var_02 = self.saveweapons.size;
	var_03 = -1;
	var_04 = 0;
	for(var_05 = 0;var_05 < var_02;var_05++)
	{
		if(var_03 < 0 && self.saveweapons[var_05]["type"] == param_00)
		{
			var_03 = var_05;
			continue;
		}

		var_01[var_04] = self.saveweapons[var_05];
		var_04++;
	}

	if(var_03 >= 0)
	{
		var_06 = "none";
		if(var_01.size == 0)
		{
			var_06 = self.firstsaveweapon;
			self.saveweapons = var_01;
			self.firstsaveweapon = "none";
		}
		else
		{
			self.saveweapons = var_01;
			var_06 = getsavedweapon("underwater");
			if(var_06 == "none")
			{
				var_06 = self.saveweapons[0]["use"];
			}
		}

		var_07 = self getcurrentweapon();
		if(var_07 != var_06)
		{
			self switchtoweaponimmediate(var_06);
		}
	}
}