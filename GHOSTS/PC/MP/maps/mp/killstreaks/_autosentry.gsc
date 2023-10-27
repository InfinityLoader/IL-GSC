/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\killstreaks\_autosentry.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 68
 * Decompile Time: 1224 ms
 * Timestamp: 10/27/2023 1:20:28 AM
*******************************************************************/

//Function Number: 1
func_44DF()
{
	level.sentrytype = [];
	level.sentrytype["sentry_minigun"] = "sentry";
	level.sentrytype["sam_turret"] = "sam_turret";
	level.killstreakfuncs[level.sentrytype["sentry_minigun"]] = ::func_842A;
	level.killstreakfuncs[level.sentrytype["sam_turret"]] = ::tryusesam;
	level.sentrysettings = [];
	level.sentrysettings["sentry_minigun"] = spawnstruct();
	level.sentrysettings["sentry_minigun"].health = 999999;
	level.sentrysettings["sentry_minigun"].maxhealth = 1000;
	level.sentrysettings["sentry_minigun"].burstmin = 20;
	level.sentrysettings["sentry_minigun"].burstmax = 120;
	level.sentrysettings["sentry_minigun"].pausemin = 0.15;
	level.sentrysettings["sentry_minigun"].pausemax = 0.35;
	level.sentrysettings["sentry_minigun"].sentrymodeon = "sentry";
	level.sentrysettings["sentry_minigun"].sentrymodeoff = "sentry_offline";
	level.sentrysettings["sentry_minigun"].timeout = 90;
	level.sentrysettings["sentry_minigun"].spinuptime = 0.05;
	level.sentrysettings["sentry_minigun"].overheattime = 8;
	level.sentrysettings["sentry_minigun"].cooldowntime = 0.1;
	level.sentrysettings["sentry_minigun"].fxtime = 0.3;
	level.sentrysettings["sentry_minigun"].streakname = "sentry";
	level.sentrysettings["sentry_minigun"].weaponinfo = "sentry_minigun_mp";
	level.sentrysettings["sentry_minigun"].modelbase = "weapon_sentry_chaingun";
	level.sentrysettings["sentry_minigun"].modelplacement = "weapon_sentry_chaingun_obj";
	level.sentrysettings["sentry_minigun"].modelplacementfailed = "weapon_sentry_chaingun_obj_red";
	level.sentrysettings["sentry_minigun"].modelbombsquad = "weapon_sentry_chaingun_bombsquad";
	level.sentrysettings["sentry_minigun"].modeldestroyed = "weapon_sentry_chaingun_destroyed";
	level.sentrysettings["sentry_minigun"].hintstring = &"SENTRY_PICKUP";
	level.sentrysettings["sentry_minigun"].headicon = 1;
	level.sentrysettings["sentry_minigun"].teamsplash = "used_sentry";
	level.sentrysettings["sentry_minigun"].shouldsplash = 0;
	level.sentrysettings["sentry_minigun"].vodestroyed = "sentry_destroyed";
	level.sentrysettings["sentry_minigun"].xppopup = "destroyed_sentry";
	level.sentrysettings["sentry_minigun"].lightfxtag = "tag_fx";
	level.sentrysettings["sam_turret"] = spawnstruct();
	level.sentrysettings["sam_turret"].health = 999999;
	level.sentrysettings["sam_turret"].maxhealth = 1000;
	level.sentrysettings["sam_turret"].burstmin = 20;
	level.sentrysettings["sam_turret"].burstmax = 120;
	level.sentrysettings["sam_turret"].pausemin = 0.15;
	level.sentrysettings["sam_turret"].pausemax = 0.35;
	level.sentrysettings["sam_turret"].sentrymodeon = "manual_target";
	level.sentrysettings["sam_turret"].sentrymodeoff = "sentry_offline";
	level.sentrysettings["sam_turret"].timeout = 90;
	level.sentrysettings["sam_turret"].spinuptime = 0.05;
	level.sentrysettings["sam_turret"].overheattime = 8;
	level.sentrysettings["sam_turret"].cooldowntime = 0.1;
	level.sentrysettings["sam_turret"].fxtime = 0.3;
	level.sentrysettings["sam_turret"].streakname = "sam_turret";
	level.sentrysettings["sam_turret"].weaponinfo = "sam_mp";
	level.sentrysettings["sam_turret"].modelbase = "mp_sam_turret";
	level.sentrysettings["sam_turret"].modelplacement = "mp_sam_turret_placement";
	level.sentrysettings["sam_turret"].modelplacementfailed = "mp_sam_turret_placement_failed";
	level.sentrysettings["sam_turret"].modeldestroyed = "mp_sam_turret";
	level.sentrysettings["sam_turret"].hintstring = &"SENTRY_PICKUP";
	level.sentrysettings["sam_turret"].headicon = 1;
	level.sentrysettings["sam_turret"].teamsplash = "used_sam_turret";
	level.sentrysettings["sam_turret"].shouldsplash = 0;
	level.sentrysettings["sam_turret"].vodestroyed = "sam_destroyed";
	level.sentrysettings["sam_turret"].xppopup = undefined;
	level.sentrysettings["sam_turret"].lightfxtag = "tag_fx";
	level._effect["sentry_overheat_mp"] = loadfx("vfx/gameplay/mp/killstreaks/vfx_sg_overheat_smoke");
	level._effect["sentry_explode_mp"] = loadfx("vfx/gameplay/mp/killstreaks/vfx_ims_explosion");
	level._effect["sentry_sparks_mp"] = loadfx("vfx/gameplay/mp/killstreaks/vfx_sentry_gun_explosion");
	level._effect["sentry_smoke_mp"] = loadfx("vfx/gameplay/mp/killstreaks/vfx_sg_damage_blacksmoke");
}

//Function Number: 2
func_842A(param_00,param_01)
{
	var_02 = func_3D0D("sentry_minigun");
	if(var_02)
	{
		maps\mp\_matchdata::func_4F1D(level.sentrysettings["sentry_minigun"].streakname,self.origin);
	}

	return var_02;
}

//Function Number: 3
tryusesam(param_00,param_01)
{
	var_02 = func_3D0D("sam_turret");
	if(var_02)
	{
		maps\mp\_matchdata::func_4F1D(level.sentrysettings["sam_turret"].streakname,self.origin);
	}

	return var_02;
}

//Function Number: 4
func_3D0D(param_00)
{
	self.last_sentry = param_00;
	var_01 = func_211A(param_00,self);
	func_65A6();
	self.carriedsentry = var_01;
	var_02 = func_6FFC(var_01,1);
	self.carriedsentry = undefined;
	thread func_8B12();
	self.iscarrying = 0;
	if(isdefined(var_01))
	{
		return 1;
	}

	return 0;
}

//Function Number: 5
func_6FFC(param_00,param_01)
{
	self endon("death");
	self endon("disconnect");
	param_00 func_6DEC(self);
	common_scripts\utility::_disableweapon();
	if(!isai(self))
	{
		self notifyonplayercommand("place_sentry","+attack");
		self notifyonplayercommand("place_sentry","+attack_akimbo_accessible");
		self notifyonplayercommand("cancel_sentry","+actionslot 4");
		if(!level.console)
		{
			self notifyonplayercommand("cancel_sentry","+actionslot 5");
			self notifyonplayercommand("cancel_sentry","+actionslot 6");
			self notifyonplayercommand("cancel_sentry","+actionslot 7");
		}
	}

	for(;;)
	{
		var_02 = common_scripts\utility::func_8B33("place_sentry","cancel_sentry","force_cancel_placement");
		if(!isdefined(param_00))
		{
			common_scripts\utility::_enableweapon();
			return 1;
		}

		if(var_02 == "cancel_sentry" || var_02 == "force_cancel_placement")
		{
			if(!param_01 && var_02 == "cancel_sentry")
			{
				continue;
			}

			if(level.console)
			{
				var_03 = maps\mp\_utility::getkillstreakweapon(level.sentrysettings[param_00.sentrytype].streakname);
				if(isdefined(self.killstreakindexweapon) && var_03 == maps\mp\_utility::getkillstreakweapon(self.pers["killstreaks"][self.killstreakindexweapon].streakname) && !self getweaponslistitems().size)
				{
					maps\mp\_utility::_giveweapon(var_03,0);
					maps\mp\_utility::_setactionslot(4,"weapon",var_03);
				}
			}

			param_00 func_6DEA(var_02 == "force_cancel_placement" && !isdefined(param_00.firstplacement));
			return 0;
		}

		if(!param_00.canbeplaced)
		{
			continue;
		}

		param_00 func_6DF0();
		common_scripts\utility::_enableweapon();
		return 1;
	}
}

//Function Number: 6
func_65BE()
{
	if(!maps\mp\_utility::func_47BB())
	{
		if(self hasweapon("iw6_riotshield_mp"))
		{
			self.restoreweapon = "iw6_riotshield_mp";
			self takeweapon("iw6_riotshield_mp");
		}
	}

	if(self hasweapon("iw5_alienriotshield_mp"))
	{
		self.restoreweapon = "iw5_alienriotshield_mp";
		self.riotshieldammo = self getammocount("iw5_alienriotshield_mp");
		self takeweapon("iw5_alienriotshield_mp");
	}
}

//Function Number: 7
func_65A6()
{
	if(maps\mp\_utility::_hasperk("specialty_explosivebullets"))
	{
		self.restoreperk = "specialty_explosivebullets";
		maps\mp\_utility::_unsetperk("specialty_explosivebullets");
	}
}

//Function Number: 8
func_6667()
{
	if(isdefined(self.restoreweapon))
	{
		maps\mp\_utility::_giveweapon(self.restoreweapon);
		if(maps\mp\_utility::func_47BB())
		{
			if(self.restoreweapon == "iw5_alienriotshield_mp")
			{
				self setweaponammoclip("iw5_alienriotshield_mp",self.riotshieldammo);
			}
		}

		self.restoreweapon = undefined;
	}
}

//Function Number: 9
func_665E()
{
	if(isdefined(self.restoreperk))
	{
		maps\mp\_utility::func_3CFB(self.restoreperk,0);
		self.restoreperk = undefined;
	}
}

//Function Number: 10
func_8B12()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	wait(0.05);
	func_665E();
}

//Function Number: 11
func_211A(param_00,param_01)
{
	var_02 = spawnturret("misc_turret",param_01.origin,level.sentrysettings[param_00].weaponinfo);
	var_02.angles = param_01.angles;
	var_02 sentry_initsentry(param_00,param_01);
	var_02 thread sentry_createbombsquadmodel(param_00);
	return var_02;
}

//Function Number: 12
sentry_initsentry(param_00,param_01)
{
	self.sentrytype = param_00;
	self.canbeplaced = 1;
	self setmodel(level.sentrysettings[self.sentrytype].modelbase);
	self.shouldsplash = 1;
	self.firstplacement = 1;
	self setcandamage(1);
	switch(param_00)
	{
		case "gl_turret_4":
		case "gl_turret_3":
		case "gl_turret_2":
		case "gl_turret_1":
		case "minigun_turret_4":
		case "minigun_turret_3":
		case "minigun_turret_2":
		case "minigun_turret_1":
		case "gl_turret":
		case "minigun_turret":
			self setleftarc(80);
			self setrightarc(80);
			self setbottomarc(50);
			self setdefaultdroppitch(0);
			self.originalowner = param_01;
			break;

		case "scramble_turret":
		case "sam_turret":
			self maketurretinoperable();
			self setleftarc(180);
			self setrightarc(180);
			self settoparc(80);
			self setdefaultdroppitch(-89);
			self.laser_on = 0;
			var_02 = spawn("script_model",self gettagorigin("tag_laser"));
			var_02 linkto(self);
			self.killcament = var_02;
			self.killcament setscriptmoverkillcam("explosive");
			break;

		default:
			self maketurretinoperable();
			self setdefaultdroppitch(-89);
			break;
	}

	self setturretmodechangewait(1);
	func_6DEE();
	func_6DEF(param_01);
	thread func_6DFE();
	switch(param_00)
	{
		case "minigun_turret_4":
		case "minigun_turret_3":
		case "minigun_turret_2":
		case "minigun_turret_1":
		case "minigun_turret":
			self.momentum = 0;
			self.heatlevel = 0;
			self.overheated = 0;
			thread func_6DC8();
			break;

		case "gl_turret_4":
		case "gl_turret_3":
		case "gl_turret_2":
		case "gl_turret_1":
		case "gl_turret":
			self.momentum = 0;
			self.heatlevel = 0;
			self.cooldownwaittime = 0;
			self.overheated = 0;
			thread func_84EA();
			thread turret_coolmonitor();
			break;

		case "scramble_turret":
		case "sam_turret":
			thread func_6DC6();
			thread func_6DAF();
			break;

		default:
			thread func_6DC6();
			thread func_6DAA();
			thread func_6DAF();
			break;
	}
}

//Function Number: 13
sentry_createbombsquadmodel(param_00)
{
	if(isdefined(level.sentrysettings[param_00].modelbombsquad))
	{
		var_01 = spawn("script_model",self.origin);
		var_01.angles = self.angles;
		var_01 hide();
		var_01 thread maps\mp\gametypes\_weapons::bombsquadvisibilityupdater(self.owner);
		var_01 setmodel(level.sentrysettings[param_00].modelbombsquad);
		var_01 linkto(self);
		var_01 setcontents(0);
		self.bombsquadmodel = var_01;
		self waittill("death");
		if(isdefined(var_01))
		{
			var_01 delete();
		}
	}
}

//Function Number: 14
func_6DC3()
{
	self endon("carried");
	maps\mp\gametypes\_damage::func_537B(level.sentrysettings[self.sentrytype].maxhealth,"sentry",::func_6E05,::sentrymodifydamage,1);
}

//Function Number: 15
sentrymodifydamage(param_00,param_01,param_02,param_03)
{
	var_04 = param_03;
	if(param_02 == "MOD_MELEE")
	{
		var_04 = self.maxhealth * 0.34;
	}

	var_04 = maps\mp\gametypes\_damage::func_3F8A(param_01,param_02,var_04);
	var_04 = maps\mp\gametypes\_damage::handlegrenadedamage(param_01,param_02,var_04);
	var_04 = maps\mp\gametypes\_damage::handleapdamage(param_01,param_02,var_04,param_00);
	return var_04;
}

//Function Number: 16
func_6E05(param_00,param_01,param_02,param_03)
{
	var_04 = level.sentrysettings[self.sentrytype];
	var_05 = maps\mp\gametypes\_damage::onkillstreakkilled(param_00,param_01,param_02,param_03,var_04.xppopup,var_04.vodestroyed);
	if(var_05)
	{
		param_00 notify("destroyed_equipment");
	}
}

//Function Number: 17
func_6E03()
{
	self endon("carried");
	self endon("death");
	level endon("game_ended");
	for(;;)
	{
		self waittill("emp_damage",var_00,var_01);
		maps\mp\gametypes\_weapons::func_7C5B();
		playfxontag(common_scripts\utility::func_3AB9("emp_stun"),self,"tag_aim");
		self setdefaultdroppitch(40);
		self setmode(level.sentrysettings[self.sentrytype].sentrymodeoff);
		wait(var_01);
		self setdefaultdroppitch(-89);
		self setmode(level.sentrysettings[self.sentrytype].sentrymodeon);
		thread maps\mp\gametypes\_weapons::doblinkinglight(level.sentrysettings[self.sentrytype].lightfxtag);
	}
}

//Function Number: 18
func_6DC4()
{
	self endon("carried");
	self waittill("death");
	if(!isdefined(self))
	{
	}

	self freeentitysentient();
	self setmodel(level.sentrysettings[self.sentrytype].modeldestroyed);
	func_6DEE();
	self setdefaultdroppitch(40);
	self setsentryowner(undefined);
	if(isdefined(self.inuseby))
	{
		self useby(self.inuseby);
	}

	self setturretminimapvisible(0);
	if(isdefined(self.ownertrigger))
	{
		self.ownertrigger delete();
	}

	self playsound("sentry_explode");
	switch(self.sentrytype)
	{
		case "gl_turret":
		case "minigun_turret":
			self.forcedisable = 1;
			self turretfiredisable();
			break;

		default:
			break;
	}

	if(isdefined(self.inuseby))
	{
		playfxontag(common_scripts\utility::func_3AB9("sentry_explode_mp"),self,"tag_origin");
		playfxontag(common_scripts\utility::func_3AB9("sentry_smoke_mp"),self,"tag_aim");
		self.inuseby.turret_overheat_bar maps\mp\gametypes\_hud_util::destroyelem();
		self.inuseby func_665E();
		self.inuseby func_6667();
		self notify("deleting");
		wait(1);
		stopfxontag(common_scripts\utility::func_3AB9("sentry_explode_mp"),self,"tag_origin");
		stopfxontag(common_scripts\utility::func_3AB9("sentry_smoke_mp"),self,"tag_aim");
	}
	else
	{
		playfxontag(common_scripts\utility::func_3AB9("sentry_sparks_mp"),self,"tag_aim");
		self playsound("sentry_explode_smoke");
		var_00 = 8;
		while(var_00 > 0)
		{
			playfxontag(common_scripts\utility::func_3AB9("sentry_smoke_mp"),self,"tag_aim");
			wait(0.4);
			var_00 = var_00 - 0.4;
		}

		playfx(common_scripts\utility::func_3AB9("sentry_explode_mp"),self.origin + (0,0,10));
		self notify("deleting");
	}

	maps\mp\gametypes\_weapons::equipmentdeletevfx();
	if(isdefined(self.killcament))
	{
		self.killcament delete();
	}

	self delete();
}

//Function Number: 19
func_6DC6()
{
	self endon("death");
	level endon("game_ended");
	for(;;)
	{
		self waittill("trigger",var_00);
		if(!maps\mp\_utility::func_4945(var_00))
		{
			continue;
		}

		if(self.sentrytype == "sam_turret" || self.sentrytype == "scramble_turret")
		{
			self setmode(level.sentrysettings[self.sentrytype].sentrymodeoff);
		}

		var_00 func_6FFC(self,0);
	}
}

//Function Number: 20
func_84E5(param_00)
{
	self endon("disconnect");
	level endon("game_ended");
	param_00 endon("death");
	if(!isdefined(param_00.ownertrigger))
	{
	}

	var_01 = 0;
	for(;;)
	{
		if(isalive(self) && self istouching(param_00.ownertrigger) && !isdefined(param_00.inuseby) && !isdefined(param_00.carriedby) && self isonground())
		{
			if(self usebuttonpressed())
			{
				if(isdefined(self.using_remote_turret) && self.using_remote_turret)
				{
					continue;
				}

				var_01 = 0;
				while(self usebuttonpressed())
				{
					var_01 = var_01 + 0.05;
					wait(0.05);
				}

				if(var_01 >= 0.5)
				{
					continue;
				}

				var_01 = 0;
				while(!self usebuttonpressed() && var_01 < 0.5)
				{
					var_01 = var_01 + 0.05;
					wait(0.05);
				}

				if(var_01 >= 0.5)
				{
					continue;
				}

				if(!maps\mp\_utility::func_4945(self))
				{
					continue;
				}

				if(isdefined(self.using_remote_turret) && self.using_remote_turret)
				{
					continue;
				}

				param_00 setmode(level.sentrysettings[param_00.sentrytype].sentrymodeoff);
				thread func_6FFC(param_00,0);
				param_00.ownertrigger delete();
			}
		}

		wait(0.05);
	}
}

//Function Number: 21
func_84E6()
{
	self notify("turret_handluse");
	self endon("turret_handleuse");
	self endon("deleting");
	level endon("game_ended");
	self.forcedisable = 0;
	var_00 = (1,0.9,0.7);
	var_01 = (1,0.65,0);
	var_02 = (1,0.25,0);
	for(;;)
	{
		self waittill("trigger",var_03);
		if(isdefined(self.carriedby))
		{
			continue;
		}

		if(isdefined(self.inuseby))
		{
			continue;
		}

		if(!maps\mp\_utility::func_4945(var_03))
		{
			continue;
		}

		var_03 func_65A6();
		var_03 func_65BE();
		self.inuseby = var_03;
		self setmode(level.sentrysettings[self.sentrytype].sentrymodeoff);
		func_6DEF(var_03);
		self setmode(level.sentrysettings[self.sentrytype].sentrymodeon);
		var_03 thread func_8509(self);
		var_03.turret_overheat_bar = var_03 maps\mp\gametypes\_hud_util::createbar(var_00,100,6);
		var_03.turret_overheat_bar maps\mp\gametypes\_hud_util::func_70A4("CENTER","BOTTOM",0,-70);
		var_03.turret_overheat_bar.alpha = 0.65;
		var_03.turret_overheat_bar.bar.alpha = 0.65;
		var_04 = 0;
		for(;;)
		{
			if(!maps\mp\_utility::func_4945(var_03))
			{
				self.inuseby = undefined;
				var_03.turret_overheat_bar maps\mp\gametypes\_hud_util::destroyelem();
				break;
			}

			if(!var_03 isusingturret())
			{
				self notify("player_dismount");
				self.inuseby = undefined;
				var_03.turret_overheat_bar maps\mp\gametypes\_hud_util::destroyelem();
				var_03 func_665E();
				var_03 func_6667();
				self sethintstring(level.sentrysettings[self.sentrytype].hintstring);
				self setmode(level.sentrysettings[self.sentrytype].sentrymodeoff);
				func_6DEF(self.originalowner);
				self setmode(level.sentrysettings[self.sentrytype].sentrymodeon);
				break;
			}

			if(self.heatlevel >= level.sentrysettings[self.sentrytype].overheattime)
			{
				var_05 = 1;
			}
			else
			{
				var_05 = self.heatlevel / level.sentrysettings[self.sentrytype].overheattime;
			}

			var_03.turret_overheat_bar maps\mp\gametypes\_hud_util::func_86CD(var_05);
			if(common_scripts\utility::string_starts_with(self.sentrytype,"minigun_turret"))
			{
				var_06 = "minigun_turret";
			}

			if(self.forcedisable || self.overheated)
			{
				self turretfiredisable();
				var_03.turret_overheat_bar.bar.color = var_02;
				var_04 = 0;
			}
			else if(self.heatlevel > level.sentrysettings[self.sentrytype].overheattime * 0.75 && common_scripts\utility::string_starts_with(self.sentrytype,"minigun_turret"))
			{
				var_03.turret_overheat_bar.bar.color = var_01;
				if(randomintrange(0,10) < 6)
				{
					self turretfireenable();
				}
				else
				{
					self turretfiredisable();
				}

				if(!var_04)
				{
					var_04 = 1;
					thread playheatfx();
				}
			}
			else
			{
				var_03.turret_overheat_bar.bar.color = var_00;
				self turretfireenable();
				var_04 = 0;
				self notify("not_overheated");
			}

			wait(0.05);
		}

		self setdefaultdroppitch(0);
	}
}

//Function Number: 22
func_6DC5()
{
	self endon("death");
	level endon("game_ended");
	self notify("sentry_handleOwner");
	self endon("sentry_handleOwner");
	self.owner waittill("killstreak_disowned");
	self notify("death");
}

//Function Number: 23
func_6DEF(param_00)
{
	self.owner = param_00;
	self setsentryowner(self.owner);
	self setturretminimapvisible(1,self.sentrytype);
	if(level.teambased)
	{
		self.team = self.owner.team;
		self setturretteam(self.team);
	}

	thread func_6DC5();
}

//Function Number: 24
func_6DD0(param_00)
{
	self notify("death");
}

//Function Number: 25
func_6DF0()
{
	self setmodel(level.sentrysettings[self.sentrytype].modelbase);
	if(self getmode() == "manual")
	{
		self setmode(level.sentrysettings[self.sentrytype].sentrymodeoff);
	}

	thread func_6DC3();
	thread func_6DC4();
	self setsentrycarrier(undefined);
	self setcandamage(1);
	switch(self.sentrytype)
	{
		case "gl_turret_4":
		case "gl_turret_3":
		case "gl_turret_2":
		case "gl_turret_1":
		case "minigun_turret_4":
		case "minigun_turret_3":
		case "minigun_turret_2":
		case "minigun_turret_1":
		case "gl_turret":
		case "minigun_turret":
			self.angles = self.carriedby.angles;
			if(isalive(self.originalowner))
			{
				self.originalowner maps\mp\_utility::setlowermessage("pickup_hint",level.sentrysettings[self.sentrytype].ownerhintstring,3,undefined,undefined,undefined,undefined,undefined,1);
			}
	
			self.ownertrigger = spawn("trigger_radius",self.origin + (0,0,1),0,105,64);
			self.ownertrigger enablelinkto();
			self.ownertrigger linkto(self);
			self.originalowner thread func_84E5(self);
			thread func_84E6();
			break;

		default:
			break;
	}

	func_6DCD();
	if(isdefined(self.bombsquadmodel))
	{
		self.bombsquadmodel show();
		level notify("update_bombsquad");
	}

	self.carriedby forceusehintoff();
	self.carriedby = undefined;
	self.firstplacement = undefined;
	if(isdefined(self.owner))
	{
		self.owner.iscarrying = 0;
		common_scripts\utility::func_5009(self.owner.team);
		if(issentient(self))
		{
			self setthreatbiasgroup("DogsDontAttack");
		}

		self.owner notify("new_sentry",self);
	}

	sentry_setactive();
	var_00 = spawnstruct();
	if(isdefined(self.moving_platform))
	{
		var_00.linkparent = self.moving_platform;
	}

	var_00.endonstring = "carried";
	var_00.deathoverridecallback = ::func_6DD0;
	thread maps\mp\_movers::func_3F25(var_00);
	if(self.sentrytype != "multiturret")
	{
		self playsound("sentry_gun_plant");
	}

	thread maps\mp\gametypes\_weapons::doblinkinglight(level.sentrysettings[self.sentrytype].lightfxtag);
	self notify("placed");
}

//Function Number: 26
func_6DEA(param_00)
{
	if(isdefined(self.carriedby))
	{
		var_01 = self.carriedby;
		var_01 forceusehintoff();
		var_01.iscarrying = undefined;
		var_01.carrieditem = undefined;
		var_01 common_scripts\utility::_enableweapon();
		if(isdefined(self.bombsquadmodel))
		{
			self.bombsquadmodel delete();
		}
	}

	if(isdefined(param_00) && param_00)
	{
		maps\mp\gametypes\_weapons::equipmentdeletevfx();
	}

	self delete();
}

//Function Number: 27
func_6DEC(param_00)
{
	if(isdefined(self.originalowner))
	{
	}
	else
	{
	}

	self setmodel(level.sentrysettings[self.sentrytype].modelplacement);
	self setsentrycarrier(param_00);
	self setcandamage(0);
	func_6DCC();
	self.carriedby = param_00;
	param_00.iscarrying = 1;
	param_00 thread func_872B(self);
	thread func_6DD3(param_00);
	thread func_6DD4(param_00);
	thread func_6DD2(param_00);
	thread func_6DD5();
	self freeentitysentient();
	self setdefaultdroppitch(-89);
	func_6DEE();
	if(isdefined(self getlinkedparent()))
	{
		self unlink();
	}

	self notify("carried");
	if(isdefined(self.bombsquadmodel))
	{
		self.bombsquadmodel hide();
	}
}

//Function Number: 28
func_872B(param_00)
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	param_00 endon("placed");
	param_00 endon("death");
	param_00.canbeplaced = 1;
	var_01 = -1;
	for(;;)
	{
		var_02 = self canplayerplacesentry(1,22);
		param_00.origin = var_02["origin"];
		param_00.angles = var_02["angles"];
		param_00.canbeplaced = self isonground() && var_02["result"] && abs(param_00.origin[2] - self.origin[2]) < 30;
		if(isdefined(var_02["entity"]))
		{
			param_00.moving_platform = var_02["entity"];
		}
		else
		{
			param_00.moving_platform = undefined;
		}

		if(param_00.canbeplaced != var_01)
		{
			if(param_00.canbeplaced)
			{
				param_00 setmodel(level.sentrysettings[param_00.sentrytype].modelplacement);
				self forceusehinton(&"SENTRY_PLACE");
			}
			else
			{
				param_00 setmodel(level.sentrysettings[param_00.sentrytype].modelplacementfailed);
				self forceusehinton(&"SENTRY_CANNOT_PLACE");
			}
		}

		var_01 = param_00.canbeplaced;
		wait(0.05);
	}
}

//Function Number: 29
func_6DD3(param_00)
{
	self endon("placed");
	self endon("death");
	param_00 waittill("death");
	if(self.canbeplaced)
	{
		func_6DF0();
	}

	func_6DEA(0);
}

//Function Number: 30
func_6DD4(param_00)
{
	self endon("placed");
	self endon("death");
	param_00 waittill("disconnect");
	self delete();
}

//Function Number: 31
func_6DD2(param_00)
{
	self endon("placed");
	self endon("death");
	param_00 common_scripts\utility::func_8B2A("joined_team","joined_spectators");
	self delete();
}

//Function Number: 32
func_6DD5(param_00)
{
	self endon("placed");
	self endon("death");
	level waittill("game_ended");
	self delete();
}

//Function Number: 33
sentry_setactive()
{
	self setmode(level.sentrysettings[self.sentrytype].sentrymodeon);
	self setcursorhint("HINT_NOICON");
	self sethintstring(level.sentrysettings[self.sentrytype].hintstring);
	if(level.sentrysettings[self.sentrytype].headicon)
	{
		if(level.teambased)
		{
			maps\mp\_entityheadicons::func_70E0(self.team,(0,0,65));
		}
		else
		{
			maps\mp\_entityheadicons::func_7099(self.owner,(0,0,65));
		}
	}

	self makeusable();
	foreach(var_01 in level.players)
	{
		switch(self.sentrytype)
		{
			case "gl_turret_4":
			case "gl_turret_3":
			case "gl_turret_2":
			case "gl_turret_1":
			case "minigun_turret_4":
			case "minigun_turret_3":
			case "minigun_turret_2":
			case "minigun_turret_1":
			case "gl_turret":
			case "minigun_turret":
				self enableplayeruse(var_01);
				if(maps\mp\_utility::func_47BB())
				{
					var_02 = self getentitynumber();
					addtoturretlist(var_02);
				}
				break;

			default:
				var_02 = self getentitynumber();
				addtoturretlist(var_02);
				if(var_01 == self.owner)
				{
					self enableplayeruse(var_01);
				}
				else
				{
					self disableplayeruse(var_01);
				}
				break;
		}
	}

	if(self.shouldsplash)
	{
		level thread maps\mp\_utility::func_7FA0(level.sentrysettings[self.sentrytype].teamsplash,self.owner,self.owner.team);
		self.shouldsplash = 0;
	}

	if(self.sentrytype == "sam_turret")
	{
		thread func_69ED();
	}

	if(self.sentrytype == "scramble_turret")
	{
		thread func_6B03();
	}

	thread func_6E03();
}

//Function Number: 34
func_6DEE()
{
	self setmode(level.sentrysettings[self.sentrytype].sentrymodeoff);
	self makeunusable();
	self freeentitysentient();
	maps\mp\gametypes\_weapons::func_7C5B();
	var_00 = self getentitynumber();
	switch(self.sentrytype)
	{
		case "gl_turret":
			break;

		default:
			func_6597(var_00);
			break;
	}

	if(level.teambased)
	{
		maps\mp\_entityheadicons::func_70E0("none",(0,0,0));
	}

	if(isdefined(self.owner))
	{
		maps\mp\_entityheadicons::func_7099(undefined,(0,0,0));
	}
}

//Function Number: 35
func_6DCD()
{
	self maketurretsolid();
}

//Function Number: 36
func_6DCC()
{
	self setcontents(0);
}

//Function Number: 37
func_48CD(param_00)
{
	if(level.teambased && self.team == param_00.team)
	{
		return 1;
	}

	return 0;
}

//Function Number: 38
addtoturretlist(param_00)
{
	level.turrets[param_00] = self;
}

//Function Number: 39
func_6597(param_00)
{
	level.turrets[param_00] = undefined;
}

//Function Number: 40
func_6DAA()
{
	self endon("death");
	level endon("game_ended");
	self.momentum = 0;
	self.heatlevel = 0;
	self.overheated = 0;
	thread func_6DC8();
	for(;;)
	{
		common_scripts\utility::func_8B4F("turretstatechange","cooled");
		if(self isfiringturret())
		{
			thread func_6DB2();
			continue;
		}

		func_6DF4();
		thread sentry_burstfirestop();
	}
}

//Function Number: 41
func_6DFE()
{
	self endon("death");
	level endon("game_ended");
	var_00 = level.sentrysettings[self.sentrytype].timeout;
	if(!maps\mp\_utility::func_47BB())
	{
	}

	while(var_00)
	{
		wait(1);
		maps\mp\gametypes\_hostmigration::func_8BBA();
		if(!isdefined(self.carriedby))
		{
			var_00 = max(0,var_00 - 1);
		}
	}

	if(isdefined(self.owner))
	{
		if(self.sentrytype == "sam_turret")
		{
			self.owner thread maps\mp\_utility::func_4D35("sam_gone");
		}
		else if(self.sentrytype == "scramble_turret")
		{
			self.owner thread maps\mp\_utility::func_4D35("sam_gone");
		}
		else
		{
			self.owner thread maps\mp\_utility::func_4D35("sentry_gone");
		}
	}

	self notify("death");
}

//Function Number: 42
func_6DFA()
{
	self endon("death");
	self playsound("sentry_gun_beep");
	wait(0.1);
	self playsound("sentry_gun_beep");
	wait(0.1);
	self playsound("sentry_gun_beep");
}

//Function Number: 43
func_6DF5()
{
	thread func_6DFA();
	while(self.momentum < level.sentrysettings[self.sentrytype].spinuptime)
	{
		self.momentum = self.momentum + 0.1;
		wait(0.1);
	}
}

//Function Number: 44
func_6DF4()
{
	self.momentum = 0;
}

//Function Number: 45
func_6DB2()
{
	self endon("death");
	self endon("stop_shooting");
	level endon("game_ended");
	func_6DF5();
	var_00 = weaponfiretime(level.sentrysettings[self.sentrytype].weaponinfo);
	var_01 = level.sentrysettings[self.sentrytype].burstmin;
	var_02 = level.sentrysettings[self.sentrytype].burstmax;
	var_03 = level.sentrysettings[self.sentrytype].pausemin;
	var_04 = level.sentrysettings[self.sentrytype].pausemax;
	for(;;)
	{
		var_05 = randomintrange(var_01,var_02 + 1);
		for(var_06 = 0;var_06 < var_05 && !self.overheated;var_06++)
		{
			self shootturret();
			self notify("bullet_fired");
			self.heatlevel = self.heatlevel + var_00;
			wait(var_00);
		}

		wait(randomfloatrange(var_03,var_04));
	}
}

//Function Number: 46
sentry_burstfirestop()
{
	self notify("stop_shooting");
}

//Function Number: 47
func_8509(param_00)
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	param_00 endon("death");
	param_00 endon("player_dismount");
	var_01 = weaponfiretime(level.sentrysettings[param_00.sentrytype].weaponinfo);
	for(;;)
	{
		param_00 waittill("turret_fire");
		param_00.heatlevel = param_00.heatlevel + var_01;
		param_00.cooldownwaittime = var_01;
	}
}

//Function Number: 48
func_6DC8()
{
	self endon("death");
	var_00 = weaponfiretime(level.sentrysettings[self.sentrytype].weaponinfo);
	var_01 = 0;
	var_02 = 0;
	var_03 = level.sentrysettings[self.sentrytype].overheattime;
	var_04 = level.sentrysettings[self.sentrytype].cooldowntime;
	for(;;)
	{
		if(self.heatlevel != var_01)
		{
			wait(var_00);
		}
		else
		{
			self.heatlevel = max(0,self.heatlevel - 0.05);
		}

		if(self.heatlevel > var_03)
		{
			self.overheated = 1;
			thread playheatfx();
			switch(self.sentrytype)
			{
				case "minigun_turret_4":
				case "minigun_turret_3":
				case "minigun_turret_2":
				case "minigun_turret_1":
				case "minigun_turret":
					playfxontag(common_scripts\utility::func_3AB9("sentry_smoke_mp"),self,"tag_aim");
					break;
	
				default:
					break;
			}

			while(self.heatlevel)
			{
				self.heatlevel = max(0,self.heatlevel - var_04);
				wait(0.1);
			}

			self.overheated = 0;
			self notify("not_overheated");
		}

		var_01 = self.heatlevel;
		wait(0.05);
	}
}

//Function Number: 49
func_84EA()
{
	self endon("death");
	var_00 = level.sentrysettings[self.sentrytype].overheattime;
	for(;;)
	{
		if(self.heatlevel > var_00)
		{
			self.overheated = 1;
			thread playheatfx();
			switch(self.sentrytype)
			{
				case "gl_turret":
					playfxontag(common_scripts\utility::func_3AB9("sentry_smoke_mp"),self,"tag_aim");
					break;
	
				default:
					break;
			}

			while(self.heatlevel)
			{
				wait(0.1);
			}

			self.overheated = 0;
			self notify("not_overheated");
		}

		wait(0.05);
	}
}

//Function Number: 50
turret_coolmonitor()
{
	self endon("death");
	for(;;)
	{
		if(self.heatlevel > 0)
		{
			if(self.cooldownwaittime <= 0)
			{
				self.heatlevel = max(0,self.heatlevel - 0.05);
			}
			else
			{
				self.cooldownwaittime = max(0,self.cooldownwaittime - 0.05);
			}
		}

		wait(0.05);
	}
}

//Function Number: 51
playheatfx()
{
	self endon("death");
	self endon("not_overheated");
	level endon("game_ended");
	self notify("playing_heat_fx");
	self endon("playing_heat_fx");
	for(;;)
	{
		playfxontag(common_scripts\utility::func_3AB9("sentry_overheat_mp"),self,"tag_flash");
		wait(level.sentrysettings[self.sentrytype].fxtime);
	}
}

//Function Number: 52
func_603C()
{
	self endon("death");
	self endon("not_overheated");
	level endon("game_ended");
	for(;;)
	{
		playfxontag(common_scripts\utility::func_3AB9("sentry_smoke_mp"),self,"tag_aim");
		wait(0.4);
	}
}

//Function Number: 53
func_6DAF()
{
	self endon("death");
	level endon("game_ended");
	for(;;)
	{
		wait(3);
		if(!isdefined(self.carriedby))
		{
			self playsound("sentry_gun_beep");
		}
	}
}

//Function Number: 54
func_69ED()
{
	self endon("carried");
	self endon("death");
	level endon("game_ended");
	self.samtargetent = undefined;
	self.sammissilegroups = [];
	for(;;)
	{
		self.samtargetent = func_69EA();
		func_69F5();
		wait(0.05);
	}
}

//Function Number: 55
func_69EA()
{
	var_00 = self gettagorigin("tag_laser");
	if(!isdefined(self.samtargetent))
	{
		if(level.teambased)
		{
			var_01 = [];
			if(level.multiteambased)
			{
				foreach(var_03 in level.teamnamelist)
				{
					if(var_03 != self.team)
					{
						foreach(var_05 in level.uavmodels[var_03])
						{
							var_01[var_01.size] = var_05;
						}
					}
				}
			}
			else
			{
				var_01 = level.uavmodels[level.otherteam[self.team]];
			}

			foreach(var_09 in var_01)
			{
				if(isdefined(var_09.isleaving) && var_09.isleaving)
				{
					continue;
				}

				if(sighttracepassed(var_00,var_09.origin,0,self))
				{
					return var_09;
				}
			}

			foreach(var_0C in level.littlebirds)
			{
				if(isdefined(var_0C.team) && var_0C.team == self.team)
				{
					continue;
				}

				if(sighttracepassed(var_00,var_0C.origin,0,self))
				{
					return var_0C;
				}
			}

			foreach(var_0F in level.helis)
			{
				if(isdefined(var_0F.team) && var_0F.team == self.team)
				{
					continue;
				}

				if(sighttracepassed(var_00,var_0F.origin,0,self))
				{
					return var_0F;
				}
			}

			foreach(var_09 in level.remote_uav)
			{
				if(!isdefined(var_09))
				{
					continue;
				}

				if(isdefined(var_09.team) && var_09.team == self.team)
				{
					continue;
				}

				if(sighttracepassed(var_00,var_09.origin,0,self,var_09))
				{
					return var_09;
				}
			}
		}
		else
		{
			foreach(var_09 in level.uavmodels)
			{
				if(isdefined(var_09.isleaving) && var_09.isleaving)
				{
					continue;
				}

				if(isdefined(var_09.owner) && isdefined(self.owner) && var_09.owner == self.owner)
				{
					continue;
				}

				if(sighttracepassed(var_00,var_09.origin,0,self))
				{
					return var_09;
				}
			}

			foreach(var_0C in level.littlebirds)
			{
				if(isdefined(var_0C.owner) && isdefined(self.owner) && var_0C.owner == self.owner)
				{
					continue;
				}

				if(sighttracepassed(var_00,var_0C.origin,0,self))
				{
					return var_0C;
				}
			}

			foreach(var_0F in level.helis)
			{
				if(isdefined(var_0F.owner) && isdefined(self.owner) && var_0F.owner == self.owner)
				{
					continue;
				}

				if(sighttracepassed(var_00,var_0F.origin,0,self))
				{
					return var_0F;
				}
			}

			foreach(var_09 in level.remote_uav)
			{
				if(!isdefined(var_09))
				{
					continue;
				}

				if(isdefined(var_09.owner) && isdefined(self.owner) && var_09.owner == self.owner)
				{
					continue;
				}

				if(sighttracepassed(var_00,var_09.origin,0,self,var_09))
				{
					return var_09;
				}
			}
		}

		self cleartargetentity();
		return undefined;
	}

	if(!sighttracepassed(var_0F,self.samtargetent.origin,0,self))
	{
		self cleartargetentity();
		return undefined;
	}

	return self.samtargetent;
}

//Function Number: 56
func_69F5()
{
	if(isdefined(self.samtargetent))
	{
		if(self.samtargetent == level.ac130.planemodel && !isdefined(level.ac130player))
		{
			self.samtargetent = undefined;
			self cleartargetentity();
		}

		self settargetentity(self.samtargetent);
		self waittill("turret_on_target");
		if(!isdefined(self.samtargetent))
		{
		}

		if(!self.laser_on)
		{
			thread func_6A0F();
			thread func_6A0E();
			thread sam_watchleaving();
			thread func_6A11();
		}

		wait(2);
		if(!isdefined(self.samtargetent))
		{
		}

		if(self.samtargetent == level.ac130.planemodel && !isdefined(level.ac130player))
		{
			self.samtargetent = undefined;
			self cleartargetentity();
		}

		var_00 = [];
		var_00[0] = self gettagorigin("tag_le_missile1");
		var_00[1] = self gettagorigin("tag_le_missile2");
		var_00[2] = self gettagorigin("tag_ri_missile1");
		var_00[3] = self gettagorigin("tag_ri_missile2");
		var_01 = self.sammissilegroups.size;
		for(var_02 = 0;var_02 < 4;var_02++)
		{
			if(!isdefined(self.samtargetent))
			{
			}

			if(isdefined(self.carriedby))
			{
			}

			self shootturret();
			var_03 = magicbullet("sam_projectile_mp",var_00[var_02],self.samtargetent.origin,self.owner);
			var_03 missile_settargetent(self.samtargetent);
			var_03 missile_setflightmodedirect();
			var_03.samturret = self;
			var_03.sammissilegroup = var_01;
			self.sammissilegroups[var_01][var_02] = var_03;
			level notify("sam_missile_fired",self.owner,var_03,self.samtargetent);
			if(var_02 == 3)
			{
				break;
			}

			wait(0.25);
		}

		level notify("sam_fired",self.owner,self.sammissilegroups[var_01],self.samtargetent);
		wait(3);
	}
}

//Function Number: 57
func_6A11()
{
	level endon("game_ended");
	self endon("death");
	while(isdefined(self.samtargetent) && isdefined(self getturrettarget(1)) && self getturrettarget(1) == self.samtargetent)
	{
		var_00 = self gettagorigin("tag_laser");
		if(!sighttracepassed(var_00,self.samtargetent.origin,0,self,self.samtargetent))
		{
			self cleartargetentity();
			self.samtargetent = undefined;
			break;
		}

		wait(0.05);
	}
}

//Function Number: 58
func_6A0F()
{
	self endon("death");
	self laseron();
	self.laser_on = 1;
	while(isdefined(self.samtargetent) && isdefined(self getturrettarget(1)) && self getturrettarget(1) == self.samtargetent)
	{
		wait(0.05);
	}

	self laseroff();
	self.laser_on = 0;
}

//Function Number: 59
func_6A0E()
{
	self endon("death");
	self.samtargetent endon("death");
	if(!isdefined(self.samtargetent.helitype))
	{
	}

	self.samtargetent waittill("crashing");
	self cleartargetentity();
	self.samtargetent = undefined;
}

//Function Number: 60
sam_watchleaving()
{
	self endon("death");
	self.samtargetent endon("death");
	if(!isdefined(self.samtargetent.model))
	{
	}

	if(self.samtargetent.model == "vehicle_uav_static_mp")
	{
		self.samtargetent waittill("leaving");
		self cleartargetentity();
		self.samtargetent = undefined;
	}
}

//Function Number: 61
func_6B03()
{
	self endon("carried");
	self endon("death");
	level endon("game_ended");
	self.scrambletargetent = undefined;
	for(;;)
	{
		self.scrambletargetent = func_6AF9();
		if(isdefined(self.scrambletargetent) && isdefined(self.scrambletargetent.scrambled) && !self.scrambletargetent.scrambled)
		{
			scrambletarget();
		}

		wait(0.05);
	}
}

//Function Number: 62
func_6AF9()
{
	return func_69EA();
}

//Function Number: 63
scrambletarget()
{
	if(isdefined(self.scrambletargetent))
	{
		if(self.scrambletargetent == level.ac130.planemodel && !isdefined(level.ac130player))
		{
			self.scrambletargetent = undefined;
			self cleartargetentity();
		}

		self settargetentity(self.scrambletargetent);
		self waittill("turret_on_target");
		if(!isdefined(self.scrambletargetent))
		{
		}

		if(!self.laser_on)
		{
			thread func_6AFB();
			thread func_6AFA();
			thread func_6AFC();
			thread scramble_watchlineofsight();
		}

		wait(2);
		if(!isdefined(self.scrambletargetent))
		{
		}

		if(self.scrambletargetent == level.ac130.planemodel && !isdefined(level.ac130player))
		{
			self.scrambletargetent = undefined;
			self cleartargetentity();
		}

		if(!isdefined(self.scrambletargetent))
		{
		}

		if(isdefined(self.carriedby))
		{
		}

		self shootturret();
		thread setscrambled();
		self notify("death");
	}
}

//Function Number: 64
setscrambled()
{
	var_00 = self.scrambletargetent;
	var_00 notify("scramble_fired",self.owner);
	var_00 endon("scramble_fired");
	var_00 endon("death");
	var_00 thread maps\mp\killstreaks\_helicopter::func_412F();
	var_00.scrambled = 1;
	var_00.secondowner = self.owner;
	var_00 notify("findNewTarget");
	wait(30);
	if(isdefined(var_00))
	{
		var_00.scrambled = 0;
		var_00.secondowner = undefined;
		var_00 thread maps\mp\killstreaks\_helicopter::func_412F();
	}
}

//Function Number: 65
scramble_watchlineofsight()
{
	level endon("game_ended");
	self endon("death");
	while(isdefined(self.scrambletargetent) && isdefined(self getturrettarget(1)) && self getturrettarget(1) == self.scrambletargetent)
	{
		var_00 = self gettagorigin("tag_laser");
		if(!sighttracepassed(var_00,self.scrambletargetent.origin,0,self,self.scrambletargetent))
		{
			self cleartargetentity();
			self.scrambletargetent = undefined;
			break;
		}

		wait(0.05);
	}
}

//Function Number: 66
func_6AFB()
{
	self endon("death");
	self laseron();
	self.laser_on = 1;
	while(isdefined(self.scrambletargetent) && isdefined(self getturrettarget(1)) && self getturrettarget(1) == self.scrambletargetent)
	{
		wait(0.05);
	}

	self laseroff();
	self.laser_on = 0;
}

//Function Number: 67
func_6AFA()
{
	self endon("death");
	self.scrambletargetent endon("death");
	if(!isdefined(self.scrambletargetent.helitype))
	{
	}

	self.scrambletargetent waittill("crashing");
	self cleartargetentity();
	self.scrambletargetent = undefined;
}

//Function Number: 68
func_6AFC()
{
	self endon("death");
	self.scrambletargetent endon("death");
	if(!isdefined(self.scrambletargetent.model))
	{
	}

	if(self.scrambletargetent.model == "vehicle_uav_static_mp")
	{
		self.scrambletargetent waittill("leaving");
		self cleartargetentity();
		self.scrambletargetent = undefined;
	}
}