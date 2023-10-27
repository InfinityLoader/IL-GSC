/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_weapons.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 159
 * Decompile Time: 2660 ms
 * Timestamp: 10/27/2023 2:42:25 AM
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
			break;

		case 2:
			break;

		case 3:
			break;
	}
}

//Function Number: 2
bombsquadwaiter()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("grenade_fire",var_00,var_01);
		var_02 = maps\mp\_utility::strip_suffix(var_01,"_lefthand");
		if(var_02 == "h1_c4_mp")
		{
			if(!isdefined(level.bombsquadmodelc4))
			{
				level.bombsquadmodelc4 = "weapon_c4_bombsquad_mw1";
			}

			var_00 thread createbombsquadmodel(level.bombsquadmodelc4,"tag_origin",self);
			continue;
		}

		if(var_02 == "h1_claymore_mp")
		{
			if(!isdefined(level.bombsquadmodelclaymore))
			{
				level.bombsquadmodelclaymore = "weapon_claymore_bombsquad_mw1";
			}

			var_00 thread createbombsquadmodel(level.bombsquadmodelclaymore,"tag_origin",self);
		}
	}
}

//Function Number: 3
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

//Function Number: 4
bombsquadvisibilityupdater(param_00)
{
	self endon("death");
	if(!isdefined(param_00))
	{
		return;
	}

	var_01 = param_00.team;
	checkbombsquadvisibility(param_00,var_01);
	for(;;)
	{
		level common_scripts\utility::waittill_any("joined_team","player_spawned","changed_kit","update_bombsquad");
		self hide();
		checkbombsquadvisibility(param_00,var_01);
	}
}

//Function Number: 5
checkbombsquadvisibility(param_00,param_01)
{
	foreach(var_03 in level.players)
	{
		if(level.teambased)
		{
			if(!isdefined(var_03.team) || var_03.team == "spectator")
			{
				continue;
			}

			if(var_03.team != param_01 && var_03 maps\mp\_utility::_hasperk("specialty_detectexplosive"))
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

//Function Number: 6
onplayerconnect()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_00.hits = 0;
		var_00.issiliding = 0;
		maps\mp\gametypes\_gamelogic::sethasdonecombat(var_00,0);
		var_00 thread onplayerspawned();
		var_00 thread bombsquadwaiter();
		var_00 thread watchmissileusage();
		var_00 thread watchmeleeweapon();
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
		self.meleeweaponbloodytime = undefined;
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
		thread watchweaponinspection();
		if(!isdefined(level.iszombiegame) || !level.iszombiegame)
		{
		}

		thread stancerecoiladjuster();
		thread maps\mp\_opticsthermal::opticsthermal_think();
		thread maps\mp\_lasersight::lasersight_think();
		thread watchgrenadegraceperiod();
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
					self.pers["toggleScopeStates"][var_02] = self gethybridscopestate(var_02);
					break;
				}
			}
		}
	}
}

//Function Number: 9
watchstingerusage()
{
	maps\mp\_stinger::stingerusageloop();
}

//Function Number: 10
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

		if(var_00 != "none" && var_06[0] != "iw5" && var_06[0] != "iw6" && var_06[0] != "h1")
		{
			if(maps\mp\_utility::iscacprimaryweapon(var_00) && !isdefined(self.hitsthismag[var_00 + "_mp"]))
			{
				self.hitsthismag[var_00 + "_mp"] = weaponclipsize(var_00 + "_mp");
			}
		}
		else if(var_00 != "none" && var_06[0] == "iw5" || var_06[0] == "iw6" || var_06[0] == "h1")
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

//Function Number: 11
watchstartweaponchange()
{
	self endon("faux_spawn");
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
				wait(0.05);
			}

			self.changingweapon = undefined;
		}
	}
}

//Function Number: 12
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

//Function Number: 13
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

//Function Number: 14
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

//Function Number: 15
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

		var_07 = self getweaponammostock(var_02);
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

	var_09 itemweaponsetammo(0,0,0,1);
	self.droppeddeathweapon = 1;
	var_09.owner = self;
	var_09.ownersattacker = param_00;
	var_09.targetname = "dropped_weapon";
	var_09 thread watchpickup();
	var_09 thread deletepickupafterawhile();
}

//Function Number: 16
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

//Function Number: 17
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

//Function Number: 18
getitemweaponname()
{
	var_00 = self.classname;
	var_01 = getsubstr(var_00,7);
	return var_01;
}

//Function Number: 19
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

//Function Number: 20
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

//Function Number: 21
handlescavengerbagpickup(param_00)
{
	self endon("death");
	level endon("game_ended");
	self waittill("scavenger",var_01);
	var_01 notify("scavenger_pickup");
	var_02 = var_01 getweaponslistoffhands();
	foreach(var_04 in var_02)
	{
		if(maps\mp\gametypes\_class::isvalidoffhand(var_04) && var_01 maps\mp\_utility::_hasperk("specialty_tacticalresupply"))
		{
			var_01 method_84A0(var_04);
			continue;
		}

		if(maps\mp\gametypes\_class::isvalidequipment(var_04) && var_01 maps\mp\_utility::_hasperk("specialty_lethalresupply"))
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
				var_0A = var_01 getweaponammostock(var_09);
				var_0B = 0;
				var_0C = maps\mp\_utility::getweaponclass(var_09);
				if(isbeamweapon(var_09) || var_0C == "weapon_riot" || issubstr(var_09,"riotshield"))
				{
				}
				else if(var_0C == "weapon_projectile")
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

//Function Number: 22
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
	if(isdefined(level.bot_funcs) && isdefined(level.bot_funcs["bots_add_scavenger_bag"]))
	{
		[[ level.bot_funcs["bots_add_scavenger_bag"] ]](var_01);
	}
}

//Function Number: 23
getweaponbasedgrenadecount(param_00)
{
	return 2;
}

//Function Number: 24
getweaponbasedsmokegrenadecount(param_00)
{
	return 1;
}

//Function Number: 25
getfraggrenadecount()
{
	var_00 = "h1_fraggrenade_mp";
	var_01 = self getammocount(var_00);
	return var_01;
}

//Function Number: 26
getsmokegrenadecount()
{
	var_00 = "h1_smokegrenade_mp";
	var_01 = self getammocount(var_00);
	return var_01;
}

//Function Number: 27
setweaponstat(param_00,param_01,param_02)
{
	maps\mp\gametypes\_gamelogic::setweaponstat(param_00,param_01,param_02);
}

//Function Number: 28
watchweaponusage(param_00)
{
	self endon("death");
	self endon("disconnect");
	self endon("faux_spawn");
	level endon("game_ended");
	for(;;)
	{
		self waittill("weapon_fired",var_01);
		maps\mp\gametypes\_gamelogic::sethasdonecombat(self,1);
		self.lastshotfiredtime = gettime();
		if(isai(self))
		{
			continue;
		}

		if(!maps\mp\_utility::iscacprimaryweapon(var_01) && !maps\mp\_utility::iscacsecondaryweapon(var_01) && !maps\mp\_utility::iscacmeleeweapon(var_01))
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

//Function Number: 29
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

//Function Number: 30
checkhitsthismag(param_00)
{
	self endon("death");
	self endon("disconnect");
	self notify("updateMagShots_" + param_00);
	waittillframeend;
	if(isdefined(self.hitsthismag[param_00]) && self.hitsthismag[param_00] == 0)
	{
		var_01 = maps\mp\_utility::getweaponclass(param_00);
		maps\mp\gametypes\_misions::genericchallenge(var_01);
		self.hitsthismag[param_00] = weaponclipsize(param_00);
	}
}

//Function Number: 31
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

	var_08 = ismeleeinventoryweapon(param_00);
	if(!isprimaryweapon(param_00) && !issidearm(param_00) && !var_08)
	{
		return;
	}

	if(self meleebuttonpressed() && !var_08)
	{
		return;
	}

	switch(weaponclass(param_00))
	{
		case "sniper":
		case "pistol":
		case "mg":
		case "smg":
		case "rifle":
			break;

		case "spread":
			break;

		default:
			break;
	}
}

//Function Number: 32
attackercandamageitem(param_00,param_01)
{
	return friendlyfirecheck(param_01,param_00);
}

//Function Number: 33
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

//Function Number: 34
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
		if(var_00 == "h1_claymore_mp")
		{
			continue;
		}

		self.throwinggrenade = var_00;
		self.gotpullbacknotify = 1;
		if(var_00 == "h1_c4_mp")
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

//Function Number: 35
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
		if(gettime() - var_00 > 1000 && var_03 == "h1_fraggrenade_mp")
		{
			var_01.iscooked = 1;
		}

		self.changingweapon = undefined;
		var_01.owner = self;
		var_01.weaponname = var_02;
		switch(var_03)
		{
			case "h1_fraggrenade_mp":
				break;
		}
	}
}

//Function Number: 36
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

//Function Number: 37
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

//Function Number: 38
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

//Function Number: 39
watchmissileusage()
{
	self endon("disconnect");
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
			break;

		default:
			break;
	}
}

//Function Number: 40
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
			thread maps\mp\gametypes\_deathicons::adddeathicon(self.body,self,self.team,5,0);
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

//Function Number: 41
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

//Function Number: 42
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

//Function Number: 43
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

//Function Number: 44
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
			break;

		case "crouch":
			break;

		case "prone":
			break;
	}
}

//Function Number: 45
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

//Function Number: 46
beginc4tracking()
{
	self endon("faux_spawn");
	self endon("death");
	self endon("disconnect");
	common_scripts\utility::waittill_any("grenade_fire","weapon_change","offhand_end");
	self.changingweapon = undefined;
}

//Function Number: 47
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

		if(!issubstr(var_01,"h1_frag"))
		{
			continue;
		}

		var_00.threwback = 1;
		var_00.originalowner = self;
		var_00 thread maps\mp\gametypes\_shellshock::grenade_earthquake();
	}
}

//Function Number: 48
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

//Function Number: 49
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

//Function Number: 50
watchc4usage()
{
	self endon("faux_spawn");
	self endon("spawned_player");
	self endon("disconnect");
	for(;;)
	{
		self waittill("grenade_fire",var_00,var_01);
		if(var_01 == "c4" || var_01 == "h1_c4_mp")
		{
			level.mines[level.mines.size] = var_00;
			var_00 thread maps\mp\gametypes\_shellshock::c4_earthquake();
			var_00 thread c4damage(var_01);
			var_00 thread c4empdamage();
			var_00 thread c4empkillstreakwait();
			var_00 thread watchc4stuck();
		}
	}
}

//Function Number: 51
watchc4stuck()
{
	self endon("death");
	self waittill("missile_stuck");
	self.trigger = spawn("script_origin",self.origin);
	self.trigger.owner = self;
	makeexplosivetargetablebyai();
	thread playc4effects();
}

//Function Number: 52
playc4effects()
{
	var_00 = self gettagorigin("tag_fx");
	var_01 = self gettagangles("tag_fx");
	var_02 = spawnlinkedfx(level.c4fxid,self,"tag_fx");
	triggerfx(var_02);
	self waittill("death");
	var_02 delete();
}

//Function Number: 53
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

//Function Number: 54
c4empkillstreakwait()
{
	self endon("death");
	for(;;)
	{
		level waittill("emp_update");
		self.disabled = undefined;
		self notify("enabled");
	}
}

//Function Number: 55
setmineteamheadicon(param_00)
{
	if(!maps\mp\_utility::invirtuallobby())
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
			return;
		}
	}
}

//Function Number: 56
watchclaymores()
{
	self endon("faux_spawn");
	self endon("spawned_player");
	self endon("disconnect");
	self.claymorearray = [];
	for(;;)
	{
		self waittill("grenade_fire",var_00,var_01);
		if(var_01 == "claymore" || var_01 == "h1_claymore_mp")
		{
			if(!isalive(self))
			{
				var_00 delete();
				return;
			}

			self.claymorearray = common_scripts\utility::array_removeundefined(self.claymorearray);
			if(self.claymorearray.size >= level.maxperplayerexplosives)
			{
				if(!maps\mp\_utility::invirtuallobby())
				{
					deleteequipment(self.claymorearray[0]);
				}
				else
				{
					self.claymorearray[0] detonate();
				}
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
			var_00 thread c4damage(var_01);
			var_00 thread handleclaymoreeffects();
			var_00 thread c4empdamage();
			var_00 thread c4empkillstreakwait();
			var_00 thread claymoredetonation();
			var_00 thread setmineteamheadicon(self.pers["team"]);
			self.changingweapon = undefined;
		}
	}
}

//Function Number: 57
handleclaymoreeffects()
{
	self endon("death");
	wait(0.15);
	thread playclaymoreeffects();
}

//Function Number: 58
playclaymoreeffects()
{
	var_00 = self gettagorigin("tag_fx");
	var_01 = self gettagangles("tag_fx");
	var_02 = spawnfx(level.claymorefxid,var_00,anglestoforward(var_01),anglestoup(var_01));
	triggerfx(var_02);
	self waittill("death");
	var_02 delete();
}

//Function Number: 59
equipmentenableuse(param_00)
{
	self notify("equipmentWatchUse");
	self endon("spawned_player");
	self endon("disconnect");
	self endon("equipmentWatchUse");
	self endon("change_owner");
	self.trigger setcursorhint("HINT_NOICON");
	if(self.weaponname == "h1_c4_mp")
	{
		self.trigger sethintstring(&"MP_PICKUP_C4");
	}
	else if(self.weaponname == "h1_claymore_mp")
	{
		self.trigger sethintstring(&"MP_PICKUP_CLAYMORE");
	}
	else if(self.weaponname == "bouncingbetty_mp")
	{
		self.trigger sethintstring(&"MP_PICKUP_BOUNCING_BETTY");
	}

	self.trigger maps\mp\_utility::setselfusable(param_00);
}

//Function Number: 60
equipmentdisableuse(param_00)
{
	self.trigger sethintstring("");
	self.trigger maps\mp\_utility::setselfunusuable();
}

//Function Number: 61
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
		if(param_00 getweaponammostock(self.weaponname) < weaponmaxammo(self.weaponname))
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

//Function Number: 62
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
		var_02 = param_00 getweaponammostock(self.weaponname);
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

//Function Number: 63
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

//Function Number: 64
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

//Function Number: 65
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

//Function Number: 66
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

//Function Number: 67
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

//Function Number: 68
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

//Function Number: 69
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

//Function Number: 70
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

//Function Number: 71
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

			if(isdefined(var_04.weaponname) && !self method_84C0(var_04.weaponname))
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

//Function Number: 72
waitanddetonate(param_00,param_01)
{
	self endon("death");
	wait(param_00);
	waittillenabled();
	if(param_01 == 2)
	{
		self method_8519();
	}
	else
	{
		self detonate();
	}

	level.mines = common_scripts\utility::array_removeundefined(level.mines);
}

//Function Number: 73
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

//Function Number: 74
c4damage(param_00)
{
	self endon("death");
	self setcandamage(1);
	self.maxhealth = 100000;
	self.health = self.maxhealth;
	var_01 = undefined;
	self waittill("damage",var_02,var_01,var_03,var_04,var_05,var_06,var_07,var_08,var_09,var_0A);
	if(!isplayer(var_01) && !isagent(var_01))
	{
		continue;
	}

	if(!friendlyfirecheck(self.owner,var_01))
	{
		continue;
	}

	if(isdefined(var_0A))
	{
		var_0B = maps\mp\_utility::strip_suffix(var_0A,"_lefthand");
		switch(var_0B)
		{
			case "h1_flashgrenade_mp":
			case "h1_concussiongrenade_mp":
			case "h1_smokegrenade_mp":
				break;
		}
	}
}

//Function Number: 75
resetc4explodethisframe()
{
	wait(0.05);
	level.c4explodethisframe = 0;
}

//Function Number: 76
saydamaged(param_00,param_01)
{
	for(var_02 = 0;var_02 < 60;var_02++)
	{
		wait(0.05);
	}
}

//Function Number: 77
waittillenabled()
{
	if(!isdefined(self.disabled))
	{
		return;
	}

	self waittill("enabled");
}

//Function Number: 78
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

//Function Number: 79
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

//Function Number: 80
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

//Function Number: 81
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
	var_10 = var_0F;
	var_12 = getfirstarraykey(var_10);
	if(isdefined(var_12))
	{
		var_11 = var_10[var_12];
		var_0B = var_11.origin + (0,0,32);
		var_09 = distancesquared(param_00,var_0B);
		if(var_09 < var_05 && !param_02 || weapondamagetracepassed(param_00,var_0B,param_03,var_11))
		{
			switch(var_11.model)
			{
				case "mp_remote_turret":
					break;
			}
		}
	}
}

//Function Number: 82
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

//Function Number: 83
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

//Function Number: 84
damageent(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	if(self.isplayer)
	{
		self.damageorigin = param_05;
		self.entity thread [[ level.callbackplayerdamage ]](param_00,param_01,param_02,0,param_03,param_04,param_05,param_06,"none",0);
		return;
	}

	if(self.isadestructable && param_04 == "artillery_mp" || param_04 == "h1_claymore_mp")
	{
		return;
	}

	self.entity notify("damage",param_02,param_01,(0,0,0),(0,0,0),"MOD_EXPLOSIVE","","","",undefined,param_04);
}

//Function Number: 85
debugline(param_00,param_01,param_02)
{
	for(var_03 = 0;var_03 < 600;var_03++)
	{
		wait(0.05);
	}
}

//Function Number: 86
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

//Function Number: 87
debugprint(param_00,param_01)
{
	for(var_02 = 0;var_02 < 600;var_02++)
	{
		wait(0.05);
	}
}

//Function Number: 88
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
		case "h1_concussiongrenade_mp":
			break;

		case "weapon_cobra_mk19_mp":
			break;

		default:
			break;
	}
}

//Function Number: 89
isconcussed()
{
	return isdefined(self.concussionendtime) && gettime() < self.concussionendtime;
}

//Function Number: 90
getlastconcussionattacker()
{
	return self.concussionattacker;
}

//Function Number: 91
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

//Function Number: 92
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
		case "beam":
		case "sniper":
		case "rocketlauncher":
		case "pistol":
		case "mg":
		case "smg":
		case "rifle":
		case "spread":
			break;

		default:
			break;
	}
}

//Function Number: 93
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
			break;

		case "weapon_heavy":
			break;

		default:
			break;
	}
}

//Function Number: 94
isbeamweapon(param_00)
{
	return issubstr(param_00,"em1") || issubstr(param_00,"epm3");
}

//Function Number: 95
isaltmodeweapon(param_00)
{
	if(param_00 == "none")
	{
		return 0;
	}

	return weaponinventorytype(param_00) == "altmode";
}

//Function Number: 96
isinventoryweapon(param_00)
{
	if(param_00 == "none")
	{
		return 0;
	}

	return weaponinventorytype(param_00) == "item";
}

//Function Number: 97
isriotshield(param_00)
{
	if(param_00 == "none")
	{
		return 0;
	}

	return weapontype(param_00) == "riotshield";
}

//Function Number: 98
isoffhandweapon(param_00)
{
	if(param_00 == "none")
	{
		return 0;
	}

	return weaponinventorytype(param_00) == "offhand";
}

//Function Number: 99
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

//Function Number: 100
ismeleeinventoryweapon(param_00)
{
	if(param_00 == "none")
	{
		return 0;
	}

	return weaponinventorytype(param_00) == "melee";
}

//Function Number: 101
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

//Function Number: 102
isvalidlastweapon(param_00)
{
	if(param_00 == "none")
	{
		return 0;
	}

	var_01 = weaponinventorytype(param_00);
	return var_01 == "primary" || var_01 == "altmode";
}

//Function Number: 103
updatesavedlastweapon()
{
	self endon("death");
	self endon("disconnect");
	self endon("faux_spawn");
	var_00 = self.currentweaponatspawn;
	self.saved_lastweapon = var_00;
	setweaponusagevariables(var_00);
	thread recordweaponusageondeathorgameend();
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

//Function Number: 104
updateweaponusagestats(param_00)
{
	var_01 = int(gettime() - self.weaponusagestarttime / 1000);
	thread setweaponstat(self.weaponusagename,var_01,"timeInUse");
	setweaponusagevariables(param_00);
}

//Function Number: 105
recordweaponusageondeathorgameend()
{
	self endon("disconnect");
	self endon("faux_spawn");
	common_scripts\utility::waittill_any_ents(self,"death",level,"game_ended");
	var_00 = int(gettime() - self.weaponusagestarttime / 1000);
	thread setweaponstat(self.weaponusagename,var_00,"timeInUse");
	setweaponusagevariables(self.weaponusagename);
}

//Function Number: 106
setweaponusagevariables(param_00)
{
	self.weaponusagename = param_00;
	self.weaponusagestarttime = gettime();
}

//Function Number: 107
empplayer(param_00)
{
	self endon("disconnect");
	self endon("death");
	thread clearempondeath();
}

//Function Number: 108
clearempondeath()
{
	self endon("disconnect");
	self waittill("death");
}

//Function Number: 109
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

//Function Number: 110
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

//Function Number: 111
clampweaponweightvalue(param_00)
{
	return clamp(param_00,0,10);
}

//Function Number: 112
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

//Function Number: 113
updatemovespeedscale()
{
}

//Function Number: 114
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

//Function Number: 115
buildweapondata(param_00)
{
}

//Function Number: 116
isstucktofriendly(param_00)
{
	return level.teambased && isdefined(param_00.team) && param_00.team == self.team;
}

//Function Number: 117
turret_monitoruse()
{
	if(getdvarint("scr_game_deleteturrets",0) || level.gametype == "gun" || maps\mp\_utility::ishodgepodgeph() || maps\mp\_utility::ishodgepodgemm())
	{
		self delete();
		return;
	}

	for(;;)
	{
		self waittill("trigger",var_00);
		thread turret_playerthread(var_00);
	}
}

//Function Number: 118
turret_playerthread(param_00)
{
	param_00 endon("death");
	param_00 endon("disconnect");
	param_00 notify("weapon_change","none");
	self waittill("turret_deactivate");
	param_00 notify("weapon_change",param_00 getcurrentweapon());
}

//Function Number: 119
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

//Function Number: 120
minedamagemonitor()
{
	self endon("mine_triggered");
	self endon("mine_selfdestruct");
	self endon("death");
	self setcandamage(1);
	self.maxhealth = 100000;
	self.health = self.maxhealth;
	var_00 = undefined;
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
			case "h1_smokegrenade_mp":
				break;
		}
	}
}

//Function Number: 121
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

//Function Number: 122
minedeletetrigger(param_00)
{
	common_scripts\utility::waittill_any("mine_triggered","mine_destroyed","mine_selfdestruct","death");
	param_00 delete();
}

//Function Number: 123
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

//Function Number: 124
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

//Function Number: 125
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

//Function Number: 126
minestunbegin()
{
	if(self.stunned)
	{
		return;
	}

	self.stunned = 1;
	playfxontag(common_scripts\utility::getfx("mine_stunned"),self,"tag_origin");
}

//Function Number: 127
minestunend()
{
	self.stunned = 0;
	stopfxontag(common_scripts\utility::getfx("mine_stunned"),self,"tag_origin");
}

//Function Number: 128
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

		if(self.weaponname == "h1_claymore_mp")
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

		if(self.weaponname == "h1_c4_mp")
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

//Function Number: 129
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

//Function Number: 130
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

//Function Number: 131
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

//Function Number: 132
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

//Function Number: 133
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

//Function Number: 134
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

//Function Number: 135
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

//Function Number: 136
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

//Function Number: 137
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

//Function Number: 138
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

//Function Number: 139
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

//Function Number: 140
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

//Function Number: 141
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
		}
	}

	if(isdefined(param_00.claymorearray))
	{
		foreach(var_05 in param_00.claymorearray)
		{
			var_05.owner = param_00;
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
	var_00 = 0;
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
	if(issubstr(param_00,"glmwr"))
	{
		return 0;
	}

	if(isendstr(param_00,"_gl"))
	{
		return 0;
	}

	switch(param_00)
	{
		case "h1_fraggrenade_mp":
			break;

		default:
			break;
	}
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

//Function Number: 157
watchweaponinspection()
{
	self endon("death");
	self endon("disconnect");
	self endon("faux_spawn");
	if(isai(self) || isbot(self))
	{
		return;
	}

	self notifyonplayercommand("weapon_inspection","+actionslot 2");
	for(;;)
	{
		self waittill("weapon_inspection");
		if(maps\mp\_utility::invirtuallobby() && !maps\mp\_utility::is_true(level.in_firingrange))
		{
			continue;
		}

		var_00 = self getcurrentprimaryweapon();
		var_01 = maps\mp\_utility::getweaponclass(var_00);
		var_02 = var_01 == "weapon_pistol";
		var_03 = maps\mp\gametypes\_class::isperkequipment(var_00);
		var_04 = getweaponbasename(var_00);
		if(isdefined(var_04))
		{
			var_05 = var_04 == "h1_augsmg_mp";
		}
		else
		{
			var_05 = 0;
		}

		if(var_02 || var_03 || var_05)
		{
			var_06 = self getammocount(var_00);
			if(var_06 == 0)
			{
				continue;
			}
		}

		self method_855F();
		wait 0.05;
		while(self method_8560())
		{
			wait 0.05;
		}
	}
}

//Function Number: 158
watchmeleeweapon()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("melee_fired",var_00);
		if(!isdefined(var_00))
		{
			continue;
		}

		if(isdefined(self.meleeweaponbloodytime) && maps\mp\_utility::ismeleeweapon(var_00))
		{
			var_01 = gettime() - self.meleeweaponbloodytime <= 100;
			var_02 = gettime() - self.meleeweaponbloodytime > 4000;
			if(!var_01 && !var_02)
			{
				thread playcleanmeleefx();
			}
		}

		maps\mp\gametypes\_gamelogic::sethasdonecombat(self,1);
		self.lastshotfiredtime = gettime();
		if(isai(self))
		{
			continue;
		}

		if(!maps\mp\_utility::iscacmeleeweapon(var_00))
		{
			continue;
		}

		var_03 = maps\mp\gametypes\_persistence::statgetbuffered("totalShots") + 1;
		var_04 = maps\mp\gametypes\_persistence::statgetbuffered("hits");
		var_05 = clamp(float(var_04) / float(var_03),0,1) * 10000;
		maps\mp\gametypes\_persistence::statsetbuffered("totalShots",var_03);
		maps\mp\gametypes\_persistence::statsetbuffered("accuracy",int(var_05));
		maps\mp\gametypes\_persistence::statsetbuffered("misses",int(var_03 - var_04));
		if(isdefined(self.laststandparams) && self.laststandparams.laststandstarttime == gettime())
		{
			self.hits = 0;
			continue;
		}

		var_06 = 1;
		setweaponstat(var_00,var_06,"shots");
		setweaponstat(var_00,self.hits,"hits");
		self.hits = 0;
	}
}

//Function Number: 159
playcleanmeleefx()
{
	self endon("death");
	self endon("disconnect");
	wait(0.05);
	var_00 = self getvieworigin();
	var_01 = self getplayerangles();
	var_02 = anglestoforward(var_01);
	var_03 = bullettrace(var_00,var_00 + var_02 * 200,0);
	if(var_03["fraction"] < 1)
	{
		playfx(level.meleeweaponbloodflick,var_03["position"] - var_02 * 5,-1 * var_02);
	}
}