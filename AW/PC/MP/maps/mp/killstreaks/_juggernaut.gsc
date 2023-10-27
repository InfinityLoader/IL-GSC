/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps/mp/killstreaks/_juggernaut.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 145
 * Decompile Time: 2332 ms
 * Timestamp: 10/27/2023 1:51:51 AM
*******************************************************************/

//Function Number: 1
init()
{
	level.juggsettings = [];
	level.juggsettings["juggernaut_exosuit"] = spawnstruct();
	level.juggsettings["juggernaut_exosuit"].splashusedname = "used_juggernaut";
	level.juggsettings["juggernaut_exosuit"].splashattachmentname = "callout_destroyed_heavyexoattachment";
	level.juggsettings["juggernaut_exosuit"].splashweakenedname = "callout_weakened_heavyexoattachment";
	level._effect["green_light_mp"] = loadfx("vfx/lights/aircraft_light_wingtip_green");
	level._effect["juggernaut_sparks"] = loadfx("vfx/explosion/bouncing_betty_explosion");
	level._effect["jugg_droppod_open"] = loadfx("vfx/explosion/goliath_pod_opening");
	level._effect["jugg_droppod_marker"] = loadfx("vfx/unique/vfx_marker_killstreak_guide_goliath");
	level._effect["exo_ping_inactive"] = loadfx("vfx/unique/exo_ping_inactive");
	level._effect["exo_ping_active"] = loadfx("vfx/unique/exo_ping_active");
	level._effect["goliath_death_fire"] = loadfx("vfx/fire/goliath_death_fire");
	level._effect["goliath_self_destruct"] = loadfx("vfx/explosion/goliath_self_destruct");
	level._effect["lethal_rocket_wv"] = loadfx("vfx/muzzleflash/playermech_lethal_flash_wv");
	level._effect["swarm_rocket_wv"] = loadfx("vfx/muzzleflash/playermech_tactical_wv_run");
	level.killstreakwieldweapons["juggernaut_sentry_mg_mp"] = "juggernaut_exosuit";
	level.killstreakwieldweapons["iw5_juggernautrockets_mp"] = "juggernaut_exosuit";
	level.killstreakwieldweapons["iw5_exoxmgjugg_mp_akimbo"] = "juggernaut_exosuit";
	level.killstreakwieldweapons["iw5_juggtitan45_mp"] = "juggernaut_exosuit";
	level.killstreakwieldweapons["iw5_exominigun_mp"] = "juggernaut_exosuit";
	level.killstreakwieldweapons["iw5_mechpunch_mp"] = "juggernaut_exosuit";
	level.killstreakwieldweapons["playermech_rocket_mp"] = "juggernaut_exosuit";
	level.killstreakwieldweapons["killstreak_goliathsd_mp"] = "juggernaut_exosuit";
	level.killstreakwieldweapons["orbital_carepackage_droppod_mp"] = "juggernaut_exosuit";
	level.killstreakwieldweapons["heavy_exo_trophy_mp"] = "juggernaut_exosuit";
	level.killstreakfuncs["heavy_exosuit"] = ::tryuseheavyexosuit;
	game["dialog"]["assist_mp_goliath"] = "ks_goliath_joinreq";
	game["dialog"]["copilot_mp_goliath"] = "copilot_mp_goliath";
	game["dialog"]["sntryoff_mp_exoai"] = "sntryoff_mp_exoai";
	game["dialog"]["mancoff_mp_exoai"] = "mancoff_mp_exoai";
	game["dialog"]["longoff_mp_exoai"] = "longoff_mp_exoai";
	game["dialog"]["rcnoff_mp_exoai"] = "rcnoff_mp_exoai";
	game["dialog"]["rcktoff_mp_exoai"] = "rcktoff_mp_exoai";
	game["dialog"]["trphyoff_mp_exoai"] = "trphyoff_mp_exoai";
	game["dialog"]["weakdmg_mp_exoai"] = "weakdmg_mp_exoai";
	level thread onplayerconnect();
}

//Function Number: 2
tryuseheavyexosuit(param_00,param_01)
{
	if(isdefined(level.ishorde) && level.ishorde)
	{
		if(isdefined(self.hordegoliathpodinfield) || isdefined(self.hordegoliathcontroller) || isdefined(self.hordeclassgoliathcontroller))
		{
			self iprintlnbold(&"KILLSTREAKS_HEAVY_EXO_IN_USE");
			return 0;
		}
	}

	var_02 = playerlaunchdroppod(param_01);
	return var_02;
}

//Function Number: 3
resetweapon()
{
	var_00 = maps\mp\_utility::getkillstreakweapon("heavy_exosuit");
	self switchtoweapon(common_scripts\utility::getlastweapon());
	maps\mp\killstreaks\_killstreaks::takekillstreakweaponifnodupe(var_00);
}

//Function Number: 4
cansetupstance()
{
	if(self getstance() == "prone" || self getstance() == "crouch")
	{
		self setstance("stand");
	}

	maps\mp\_utility::freezecontrolswrapper(1);
	var_00 = gettime() + 1500;
	while(gettime() < var_00 && self getstance() != "stand")
	{
		wait 0.05;
	}

	maps\mp\_utility::freezecontrolswrapper(0);
	return self getstance() == "stand";
}

//Function Number: 5
givejuggernaut(param_00,param_01)
{
	self endon("death");
	self endon("disconnect");
	if(isdefined(level.ishorde) && level.ishorde)
	{
		self endon("becameSpectator");
	}

	if(maps\mp\perks\_perkfunctions::haslightarmor())
	{
		maps\mp\perks\_perkfunctions::unsetlightarmor();
	}

	if(maps\mp\_utility::_hasperk("specialty_explosivebullets"))
	{
		maps\mp\_utility::_unsetperk("specialty_explosivebullets");
	}

	self.maxhealth = 125;
	if(isdefined(level.ishorde) && level.ishorde)
	{
		self.maxhealth = 300 + 25 * self.hordearmor;
	}

	self.health = self.maxhealth;
	self.attackerlist = [];
	switch(param_00)
	{
		case "juggernaut_exosuit":
		default:
			break;
	}
}

//Function Number: 6
juggernautsounds()
{
	level endon("game_ended");
	self endon("death");
	self endon("disconnect");
	self endon("jugg_removed");
	if(isdefined(level.ishorde) && level.ishorde)
	{
		self endon("becameSpectator");
	}

	for(;;)
	{
		wait(3);
		self playsound("juggernaut_breathing_sound");
	}
}

//Function Number: 7
radarmover(param_00)
{
	level endon("game_ended");
	self endon("disconnect");
	self endon("jugg_removed");
	self endon("jugdar_removed");
	for(;;)
	{
		param_00 moveto(self.origin,0.05);
		wait(0.05);
	}
}

//Function Number: 8
juggremover()
{
	level endon("game_ended");
	self endon("disconnect");
	self endon("jugg_removed");
	thread juggremoveongameended();
	common_scripts\utility::waittill_any("death","joined_team","joined_spectators","lost_juggernaut");
	self enableweaponpickup();
	self.isjuggernaut = 0;
	common_scripts\utility::resetusability();
	self allowjump(1);
	self allowcrouch(1);
	self allowladder(1);
	self allowmantle(1);
	self setdemigod(0);
	if(isdefined(self.juggernautoverlay))
	{
		self.juggernautoverlay destroy();
	}

	self unsetperk("specialty_radarjuggernaut",1);
	if(isdefined(self.personalradar))
	{
		self notify("jugdar_removed");
		level maps\mp\gametypes\_portable_radar::deleteportableradar(self.personalradar);
		self.personalradar = undefined;
	}

	self notify("jugg_removed");
}

//Function Number: 9
juggremoveongameended()
{
	self endon("disconnect");
	self endon("jugg_removed");
	level waittill("game_ended");
	if(isdefined(self.juggernautoverlay))
	{
		self.juggernautoverlay destroy();
	}
}

//Function Number: 10
removeweapons()
{
	self.primarytorestore = common_scripts\utility::getlastweapon();
	foreach(var_01 in self.weaponlist)
	{
		var_02 = maps\mp\_utility::getweaponnametokens(var_01);
		if(var_02[0] == "alt")
		{
			self.restoreweaponclipammo[var_01] = self getweaponammoclip(var_01);
			self.restoreweaponstockammo[var_01] = self setweaponammostock(var_01);
			continue;
		}

		self.restoreweaponclipammo[var_01] = self getweaponammoclip(var_01);
		self.restoreweaponstockammo[var_01] = self setweaponammostock(var_01);
	}

	self.weaponstorestore = [];
	foreach(var_01 in self.weaponlist)
	{
		var_02 = maps\mp\_utility::getweaponnametokens(var_01);
		if(var_02[0] == "alt")
		{
			continue;
		}

		if(maps\mp\_utility::iskillstreakweapon(var_01))
		{
			continue;
		}

		self.weaponstorestore[self.weaponstorestore.size] = var_01;
		self takeweapon(var_01);
	}
}

//Function Number: 11
playersetupjuggernautexo(param_00,param_01)
{
	var_02 = spawnstruct();
	self.heavyexodata = var_02;
	var_02.streakplayer = self;
	var_02.hascoopsentry = 1;
	var_02.modules = param_00;
	var_02.juggtype = param_01;
	if(isdefined(param_00))
	{
		var_02.hasradar = common_scripts\utility::array_contains(param_00,"heavy_exosuit_radar");
		var_02.hasmaniac = common_scripts\utility::array_contains(param_00,"heavy_exosuit_maniac");
		var_02.haslongpunch = common_scripts\utility::array_contains(param_00,"heavy_exosuit_punch");
		var_02.hastrophy = common_scripts\utility::array_contains(param_00,"heavy_exosuit_trophy");
		var_02.hasrockets = common_scripts\utility::array_contains(param_00,"heavy_exosuit_rockets");
		var_02.hasextraammo = common_scripts\utility::array_contains(param_00,"heavy_exosuit_ammo");
	}
	else
	{
		var_02.hasradar = 1;
		var_02.hasmaniac = 1;
		var_02.haslongpunch = 0;
		var_02.hastrophy = 1;
		var_02.hasrockets = 1;
		var_02.hasextraammo = 1;
	}

	var_03 = 0;
	if(var_02.hasrockets)
	{
		var_03 = var_03 + 1;
	}

	if(var_02.haslongpunch)
	{
		var_03 = var_03 + 2;
	}

	if(var_02.hasradar)
	{
		var_03 = var_03 + 4;
	}

	if(var_02.hastrophy)
	{
		var_03 = var_03 + 8;
	}

	if(var_02.hasmaniac)
	{
		var_03 = var_03 + 16;
	}

	if(var_02.hascoopsentry)
	{
		var_03 = var_03 + 32;
	}

	self setclientomnvar("ui_exo_suit_modules_on",var_03);
	maps\mp\_utility::playerallowpowerslide(0,"heavyexo");
	if(!var_02.hasmaniac)
	{
		maps\mp\_utility::playerallowdodge(0,"heavyexo");
		maps\mp\_utility::playerallowboostjump(0,"heavyexo");
		maps\mp\_utility::playerallowhighjump(0,"heavyexo");
		maps\mp\_utility::playerallowhighjumpdrop(0,"heavyexo");
	}

	common_scripts\utility::_disableusability();
	self allowjump(0);
	self allowcrouch(0);
	self allowladder(0);
	self allowmantle(0);
	self.inliveplayerkillstreak = 1;
	self.mechhealth = 125;
	if(isdefined(level.ishorde) && level.ishorde)
	{
		self.mechhealth = self.maxhealth;
	}

	self setdemigod(1);
	self setclientomnvar("ui_exo_suit_health",1);
	playersetjuggexomodel(var_02);
	thread playershowjuggernauthud(var_02);
	thread playercleanupondeath(var_02);
	thread playercleanuponother();
	thread playerrocketsandswarmwatcher();
	thread playermech_invalid_weapon_watcher();
	thread playerhandlebootupsequence();
	thread play_goliath_death_fx();
	thread playermech_watch_emp_grenade();
	if(isdefined(level.ishorde) && level.ishorde)
	{
		thread playermechtimeout();
	}

	if(var_02.hascoopsentry)
	{
	}

	if(var_02.hasradar)
	{
		level thread setupradar(self,var_02);
	}

	if(var_02.hasmaniac)
	{
		level thread setupmaniac(self);
		set_mech_chaingun_state("offline");
	}
	else
	{
		thread playerhandlebarrel();
		set_mech_chaingun_state("ready");
	}

	if(var_02.haslongpunch)
	{
		level thread setuplongpunch(self,var_02);
		set_mech_rocket_state("ready");
		thread playermech_monitor_rocket_recharge();
	}
	else
	{
		set_mech_rocket_state("offline");
		if(!var_02.hasmaniac)
		{
			self disableoffhandweapons();
		}
	}

	if(var_02.hastrophy)
	{
		level thread setuptrophy(self,var_02);
	}

	if(var_02.hasrockets)
	{
		level thread setuprocketswarm(self,var_02);
		set_mech_swarm_state("ready");
		thread playermech_monitor_swarm_recharge();
	}
	else
	{
		self disableoffhandsecondaryweapons();
		set_mech_swarm_state("offline");
	}

	level thread delaysetweapon(self);
	if(isdefined(level.ishorde) && level.ishorde)
	{
		self endon("horde_cancel_goliath");
	}

	wait(5);
	if(isdefined(self))
	{
		thread self_destruct_goliath();
	}
}

//Function Number: 12
playerhandlebootupsequence()
{
	self.goliathbootupsequence = 1;
	wait(4.16);
	self.goliathbootupsequence = undefined;
}

//Function Number: 13
juggernautmodifydamage(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	if(!param_00 maps\mp\_utility::isjuggernaut())
	{
		return param_02;
	}

	var_09 = param_02;
	if(isdefined(param_03) && param_03 == "MOD_FALLING")
	{
		var_09 = 0;
	}

	if(isdefined(param_04) && param_04 == "boost_slam_mp")
	{
		var_09 = 20;
	}

	if(isdefined(param_01) && isdefined(param_00) && param_01 == param_00 && isdefined(param_04) && param_04 == "iw5_juggernautrockets_mp" || param_04 == "playermech_rocket_mp")
	{
		var_09 = 0;
	}

	if(isdefined(param_00.goliathbootupsequence) && param_00.goliathbootupsequence)
	{
		if(isdefined(level.ishorde) && level.ishorde && param_03 == "MOD_TRIGGER_HURT" && param_00 maps\mp\_utility::touchingbadtrigger())
		{
			var_09 = 10000;
		}
		else
		{
			var_09 = 0;
		}
	}

	if(isdefined(param_01) && !maps\mp\gametypes\_weapons::friendlyfirecheck(param_00,param_01))
	{
		var_09 = 0;
	}

	if(var_09 > 0)
	{
		if(maps\mp\_utility::attackerishittingteam(param_00,param_01))
		{
			if(isdefined(level.juggernautmod))
			{
				var_09 = var_09 * level.juggernautmod;
			}
			else
			{
				var_09 = var_09 * 0.08;
			}
		}

		if(isdefined(param_07) && param_07 == "head")
		{
			var_09 = var_09 * 4;
		}

		if(isdefined(param_04) && param_04 == "killstreak_goliathsd_mp" && isdefined(param_01) && isdefined(param_00) && param_01 == param_00)
		{
			var_09 = param_00.mechhealth + 1;
		}

		if(isdefined(param_04) && param_04 == "nuke_mp" && isdefined(param_01) && isdefined(param_00) && param_01 != param_00)
		{
			var_09 = param_00.mechhealth + 1;
		}

		param_00.mechhealth = param_00.mechhealth - var_09;
		if(isdefined(level.ishorde) && level.ishorde)
		{
			param_00 setclientomnvar("ui_exo_suit_health",param_00.mechhealth / param_00.maxhealth);
		}
		else
		{
			param_00 setclientomnvar("ui_exo_suit_health",param_00.mechhealth / 125);
		}

		if(isdefined(param_01) && isplayer(param_01))
		{
			if(isdefined(param_07) && param_07 == "head")
			{
				param_01 maps\mp\gametypes\_damagefeedback::updatedamagefeedback("headshot");
			}
			else
			{
				param_01 maps\mp\gametypes\_damagefeedback::updatedamagefeedback("hitjuggernaut");
			}

			if(param_00 maps\mp\gametypes\_damage::isnewattacker(param_01))
			{
				param_00.attackerlist[param_00.attackerlist.size] = param_01;
			}
		}

		if(param_00.mechhealth < 0)
		{
			if(isdefined(level.ishorde) && level.ishorde)
			{
				maps\mp\_snd_common_mp::snd_message("goliath_self_destruct");
				playfx(common_scripts\utility::getfx("goliath_self_destruct"),self.origin,anglestoup(self.angles));
				self thread [[ level.hordehandlejuggdeath ]]();
			}
			else
			{
				param_00 thread playerkillheavyexo(param_05,param_01,param_03,param_04,param_08);
			}
		}
	}

	return int(var_09);
}

//Function Number: 14
playerkillheavyexo(param_00,param_01,param_02,param_03,param_04)
{
	self notify("killHeavyExo");
	self allowjump(1);
	self allowcrouch(1);
	self allowladder(1);
	self allowmantle(1);
	self setdemigod(0);
	self.isjuggernaut = 0;
	var_05 = 1001;
	if(!isdefined(param_00))
	{
		param_00 = self.origin;
	}

	var_06 = 0;
	if(isdefined(param_03) && isdefined(param_01) && isdefined(param_02) && isdefined(param_04))
	{
		var_06 = self dodamage(var_05,param_00,param_01,param_04,param_02,param_03);
	}
	else if(isdefined(param_03) && isdefined(param_01) && isdefined(param_02))
	{
		var_06 = self dodamage(var_05,param_00,param_01,undefined,param_02,param_03);
	}
	else if(isdefined(param_01) && isdefined(param_02))
	{
		var_06 = self dodamage(var_05,param_00,param_01,undefined,param_02);
	}
	else if(isdefined(param_01))
	{
		var_06 = self dodamage(var_05,param_00,param_01,undefined);
	}
	else
	{
		var_06 = self dodamage(var_05,param_00);
	}
}

//Function Number: 15
delaysetweapon(param_00)
{
	param_00 endon("death");
	param_00 endon("disconnect");
	if(isdefined(level.ishorde) && level.ishorde)
	{
		param_00 endon("becameSpectator");
	}

	var_01 = maps\mp\_utility::getkillstreakweapon("heavy_exosuit");
	param_00 maps\mp\killstreaks\_killstreaks::takekillstreakweaponifnodupe(var_01);
	param_00 giveweapon("iw5_exominigun_mp");
	param_00 switchtoweapon("iw5_exominigun_mp");
	param_00 notify("waitTakeKillstreakWeapon");
	wait 0.05;
	param_00 setplayermech(1);
	param_00 disableweaponswitch();
}

//Function Number: 16
playercleanupondeath(param_00)
{
	self endon("disconnect");
	self waittill("death",var_01,var_02,var_03);
	if(isdefined(var_01) && isplayer(var_01) && var_01 != self && var_01.team != self.team)
	{
		var_01 maps\mp\_utility::incplayerstat("goliath_destroyed",1);
		level thread maps\mp\gametypes\_rank::awardgameevent("goliath_destroyed",var_01,var_03,self,var_02);
	}

	if(!isdefined(level.ishorde))
	{
		maps\mp\_events::checkvandalismmedal(var_01);
	}

	self.inliveplayerkillstreak = undefined;
	self.mechhealth = undefined;
	playerreset(param_00);
}

//Function Number: 17
playercleanuponother()
{
	self endon("death");
	self endon("disconnect");
	self endon("joined_team");
	self endon("faux_spawn");
	if(isdefined(level.ishorde) && level.ishorde)
	{
		self endon("becameSpectator");
	}

	level common_scripts\utility::waittill_any("game_ended");
	playerresetomnvars();
}

//Function Number: 18
playerreset(param_00)
{
	self notify("lost_juggernaut");
	self notify("exit_mech");
	playerresetomnvars();
	maps\mp\_utility::playerallowdodge(1,"heavyexo");
	maps\mp\_utility::playerallowpowerslide(1,"heavyexo");
	maps\mp\_utility::playerallowboostjump(1,"heavyexo");
	maps\mp\_utility::playerallowhighjump(1,"heavyexo");
	self enableoffhandsecondaryweapons();
	self enableoffhandweapons();
	self enableweaponswitch();
	self setplayermech(0);
	self.restoreweaponclipammo = undefined;
	self.restoreweaponstockammo = undefined;
	self.juggernautweak = undefined;
	self.heavyexodata = undefined;
	if(isdefined(self.juggernautattachments))
	{
		self.juggernautattachments = undefined;
	}

	if(isdefined(param_00))
	{
		foreach(var_02 in param_00.hud)
		{
			if(isdefined(var_02))
			{
				var_02.textoffline = undefined;
				var_02.type = undefined;
				var_02 destroy();
			}
		}
	}
}

//Function Number: 19
playerresetomnvars()
{
	self setclientomnvar("ui_exo_suit_enabled",0);
	self setclientomnvar("ui_exo_suit_modules_on",0);
	self setclientomnvar("ui_exo_suit_health",0);
	self setclientomnvar("ui_exo_suit_recon_cd",0);
	self setclientomnvar("ui_exo_suit_punch_cd",0);
	self setclientomnvar("ui_exo_suit_rockets_cd",0);
	self setclientomnvar("ui_playermech_swarmrecharge",0);
	self setclientomnvar("ui_playermech_rocketrecharge",0);
}

//Function Number: 20
playersetjuggexomodel(param_00)
{
	self detachall();
	self setmodel("npc_exo_armor_mp_base");
	self attach("head_hero_cormack_sentinel_halo");
	self setviewmodel("vm_view_arms_mech_mp");
	if((isdefined(param_00) && !param_00.hasmaniac) || isdefined(level.ishorde))
	{
		self attach("npc_exo_armor_minigun_handle","TAG_HANDLE");
	}

	if(isai(self))
	{
		self.hideondeath = 1;
	}

	self notify("goliath_equipped");
}

//Function Number: 21
playerhandlebarrel()
{
	self endon("death");
	self endon("disconnect");
	if(isdefined(level.ishorde) && level.ishorde)
	{
		self endon("becameSpectator");
	}

	thread playercleanupbarrel();
	self notifyonplayercommand("goliathAttack","+attack");
	self notifyonplayercommand("goliathAttackDone","-attack");
	self.barrellinker = spawn("script_model",self gettagorigin("tag_barrel"));
	self.barrellinker setmodel("generic_prop_raven");
	self.barrellinker vehicle_jetbikesethoverforcescale(self,"tag_barrel",(12.7,0,-2.9),(90,0,0));
	self.barrel = spawn("script_model",self.barrellinker gettagorigin("j_prop_1"));
	self.barrel setmodel("npc_exo_armor_minigun_barrel");
	self.barrel vehicle_jetbikesethoverforcescale(self.barrellinker,"j_prop_1",(0,0,0),(-90,0,0));
	if(isdefined(level.ishorde) && level.ishorde && isplayer(self))
	{
		self.barrel hudoutlineenable(5,1);
	}

	self.barrellinker scriptmodelplayanimdeltamotion("mp_generic_prop_spin_02");
	self.barrellinker scriptmodelpauseanim(1);
	for(;;)
	{
		self waittill("goliathAttack");
		self.barrellinker scriptmodelpauseanim(0);
		self waittill("goliathAttackDone");
		self.barrellinker scriptmodelpauseanim(1);
	}
}

//Function Number: 22
playercleanupbarrel()
{
	if(isdefined(level.ishorde) && level.ishorde)
	{
		common_scripts\utility::waittill_any("death","disconnect","becameSpectator");
	}
	else
	{
		common_scripts\utility::waittill_any("death","disconnect");
	}

	if(isdefined(level.ishorde) && level.ishorde)
	{
		self.barrel hudoutlinedisable();
	}

	self.barrel delete();
	self.barrellinker delete();
}

//Function Number: 23
playerrocketsandswarmwatcher()
{
	self endon("death");
	self endon("disconnect");
	if(isdefined(level.ishorde) && level.ishorde)
	{
		self endon("becameSpectator");
	}

	for(;;)
	{
		self waittill("grenade_pullback",var_00);
		if(var_00 == "playermech_rocket_mp")
		{
			self notify("mech_rocket_pullback");
			self waittill("grenade_fire",var_01,var_00);
			self notify("mech_rocket_fire",var_01);
		}
		else if(var_00 == "playermech_rocket_swarm_mp" || var_00 == "playermech_rocket_swarm_maniac_mp")
		{
			self notify("mech_swarm_pullback");
			self waittill("grenade_fire",var_01,var_00);
			self notify("mech_swarm_fire",var_01.origin);
			var_01 delete();
		}

		wait 0.05;
	}
}

//Function Number: 24
setupcoopturret(param_00,param_01)
{
	var_02 = param_01 gettagorigin("tag_turret");
	var_03 = spawnattachment("juggernaut_sentry_mg_mp","npc_heavy_exo_armor_turret_base",var_02,200,param_01,&"KILLSTREAKS_HEAVY_EXO_SENTRY_LOST");
	var_03 setmode("sentry_offline");
	var_03 setsentryowner(param_01);
	var_03 setleftarc(180);
	var_03 setrightarc(180);
	var_03 settoparc(55);
	var_03 setbottomarc(30);
	var_03 setdefaultdroppitch(0);
	var_03 setturretmodechangewait(1);
	var_03 makeunusable();
	var_03 maketurretsolid();
	var_03.rocketturret = 0;
	var_03.energyturret = 0;
	var_03.turrettype = "mg_turret";
	var_03.issentry = 0;
	var_03.stunned = 0;
	var_03.nexttracer = 5;
	var_03.heatlevel = 0;
	var_03.baseowner = param_01;
	if(level.teambased)
	{
		var_03 setturretteam(param_01.team);
	}

	var_03 common_scripts\utility::make_entity_sentient_mp(param_01.team);
	var_03 maps\mp\killstreaks\_autosentry::addtoturretlist(var_03 getentitynumber());
	var_03 thread maps\mp\killstreaks\_remoteturret::turret_watchdisabled();
	var_03 linkto(param_01,"tag_turret",(0,0,0),(0,0,0));
	var_03.effect = spawnattachmenteffect(var_02,param_01);
	var_03.effect linkto(var_03,"tag_player",(29,-7,-6),(0,0,0));
	var_03.effect hide();
	param_00.coopturret = var_03;
	thread stopturret(param_00,var_03,param_01);
	thread handlecoopshooting(param_00,var_03,param_01);
	thread handleturretonplayerdone(param_00,var_03,param_01);
	return var_03;
}

//Function Number: 25
stopturret(param_00,param_01,param_02)
{
	param_01 waittill("death");
	if(isdefined(param_01))
	{
		param_01.issentry = 0;
		param_02 notify("turretDead");
		removecoopturretbuddy(param_00);
		stopfxonattachment(param_01,common_scripts\utility::getfx("green_light_mp"),1);
		param_01 playsound("sentry_explode");
		param_01 thread maps\mp\killstreaks\_remoteturret::sentry_stopattackingtargets();
		param_01 maps\mp\killstreaks\_autosentry::removefromturretlist(param_01 getentitynumber());
		param_01 setmode("sentry_offline");
		param_01.damagecallback = undefined;
		param_01 setcandamage(0);
		param_01 setdamagecallbackon(0);
		param_01 freeentitysentient();
		param_01 setdefaultdroppitch(35);
		param_01 setsentryowner(undefined);
		level thread doturretdeatheffects(param_01);
	}
}

//Function Number: 26
handlecoopshooting(param_00,param_01,param_02)
{
	param_01 endon("death");
	var_03 = weaponfiretime("juggernaut_sentry_mg_mp");
	for(;;)
	{
		if(!isdefined(param_01.remotecontrolled) || !param_01.remotecontrolled)
		{
			wait 0.05;
			continue;
		}

		if(param_01.owner attackbuttonpressed() && !param_01 isturretoverheated())
		{
			param_01 turretshootblank(param_01.baseowner);
			wait(var_03);
			continue;
		}

		wait 0.05;
	}
}

//Function Number: 27
turretshoot()
{
	self shootturret();
	turretshootblank(self.baseowner);
}

//Function Number: 28
turretshootblank(param_00)
{
	var_01 = self gettagorigin("tag_flash");
	var_02 = anglestoforward(self gettagangles("tag_flash"));
	var_03 = var_01 + var_02 * 1000;
	var_04 = 0;
	self.nexttracer--;
	if(self.nexttracer <= 0)
	{
		var_04 = 1;
		self.nexttracer = 5;
	}

	shootblank(var_01,var_03,"juggernaut_sentry_mg_mp",var_04,param_00);
}

//Function Number: 29
doturretdeatheffects(param_00)
{
	param_00 playsound("sentry_explode");
	playfxontag(common_scripts\utility::getfx("sentry_explode_mp"),param_00,"tag_aim");
	wait(1.5);
	if(!isdefined(param_00))
	{
		return;
	}

	param_00 playsound("sentry_explode_smoke");
	for(var_01 = 0;var_01 < 10;var_01++)
	{
		playfxontag(common_scripts\utility::getfx("sentry_smoke_mp"),param_00,"tag_aim");
		wait(0.4);
		if(!isdefined(param_00))
		{
			return;
		}
	}
}

//Function Number: 30
handleturretonplayerdone(param_00,param_01,param_02)
{
	thread attachmentdeath(param_00,param_01,param_02);
	waittillattachmentdone(param_02);
	stopfxonattachment(param_01,common_scripts\utility::getfx("green_light_mp"));
	param_01 maps\mp\killstreaks\_autosentry::removefromturretlist(param_01 getentitynumber());
	param_01.issentry = 0;
	param_02 notify("turretDead");
	removecoopturretbuddy(param_00);
	param_01 delete();
}

//Function Number: 31
setupradar(param_00,param_01)
{
	var_02 = param_00 gettagorigin("tag_recon_back");
	var_03 = spawnattachment("radar","npc_heavy_exo_armor_recon_back_base",var_02,undefined,param_00);
	var_03 linkto(param_00,"tag_recon_back",(0,0,0),(0,0,0));
	param_00 thread playerhandleradarping(param_01,var_03);
	waittillattachmentdone(param_00);
	wait 0.05;
	var_03 delete();
}

//Function Number: 32
playerhandleradarping(param_00,param_01)
{
	param_01 endon("death");
	self endon("death");
	self endon("disconnect");
	self endon("faux_spawn");
	self endon("joined_team");
	if(isdefined(level.ishorde) && level.ishorde)
	{
		self endon("becameSpectator");
	}

	if(!isbot(self))
	{
		self notifyonplayercommand("juggernautPing","weapnext");
	}

	playfxontag(common_scripts\utility::getfx("exo_ping_inactive"),self,"J_SpineUpper");
	for(;;)
	{
		self waittill("juggernautPing");
		activate_exo_ping();
		self setclientomnvar("ui_exo_suit_recon_cd",1);
		wait(10);
		deactivate_exo_ping();
		waitattachmentcooldown(5,"ui_exo_suit_recon_cd");
	}
}

//Function Number: 33
activate_exo_ping()
{
	thread stop_exo_ping();
	self setperk("specialty_exo_ping",1,0);
	self playlocalsound("mp_exo_cloak_activate");
	self.highlight_effect = maps\mp\_threatdetection::detection_highlight_hud_effect_on(self,-1);
	killfxontag(common_scripts\utility::getfx("exo_ping_inactive"),self,"J_SpineUpper");
	playfxontag(common_scripts\utility::getfx("exo_ping_active"),self,"J_SpineUpper");
}

//Function Number: 34
deactivate_exo_ping()
{
	self unsetperk("specialty_exo_ping",1);
	self playlocalsound("mp_exo_cloak_deactivate");
	if(isdefined(self.highlight_effect))
	{
		maps\mp\_threatdetection::detection_highlight_hud_effect_off(self.highlight_effect);
	}

	killfxontag(common_scripts\utility::getfx("exo_ping_active"),self,"J_SpineUpper");
	playfxontag(common_scripts\utility::getfx("exo_ping_inactive"),self,"J_SpineUpper");
}

//Function Number: 35
stop_exo_ping()
{
	self endon("disconnect");
	if(isdefined(level.ishorde) && level.ishorde)
	{
		common_scripts\utility::waittill_any("death","faux_spawn","joined_team","becameSpectator");
	}
	else
	{
		common_scripts\utility::waittill_any("death","faux_spawn","joined_team");
	}

	self unsetperk("specialty_exo_ping",1);
	if(isdefined(self.highlight_effect))
	{
		maps\mp\_threatdetection::detection_highlight_hud_effect_off(self.highlight_effect);
	}

	killfxontag(common_scripts\utility::getfx("exo_ping_active"),self,"J_SpineUpper");
}

//Function Number: 36
setupmaniac(param_00)
{
	var_01 = param_00 gettagorigin("tag_maniac_l");
	var_02 = spawnattachment("speedAttachment","npc_heavy_exo_armor_maniac_l_base",var_01,undefined,param_00);
	var_02 linkto(param_00,"tag_maniac_l",(0,0,0),(0,0,0));
	var_01 = param_00 gettagorigin("tag_maniac_r");
	var_03 = spawnattachment("speedAttachment","npc_heavy_exo_armor_maniac_r_base",var_01,undefined,param_00);
	var_03 linkto(param_00,"tag_maniac_r",(0,0,0),(0,0,0));
	var_04 = param_00 gettagorigin("tag_jetpack");
	var_05 = spawnattachment("speedAttachment","npc_heavy_exo_armor_jetpack_base",var_04,undefined,param_00);
	var_05 linkto(param_00,"tag_jetpack",(0,0,0),(0,0,0));
	waittillattachmentdone(param_00);
	attachmentexplode(var_02,param_00,"maniac",var_03);
	attachmentexplode(var_05,param_00,"maniac");
	wait 0.05;
	var_02 delete();
	var_03 delete();
	var_05 delete();
}

//Function Number: 37
setuplongpunch(param_00,param_01)
{
	param_00 setlethalweapon("playermech_rocket_mp");
	param_00 giveweapon("playermech_rocket_mp");
	var_02 = "tag_origin";
	param_00 thread playerwatchnoobtubeuse(param_01);
	waittillattachmentdone(param_00);
}

//Function Number: 38
playerwatchnoobtubeuse(param_00)
{
	self endon("death");
	self endon("disconnect");
	if(isdefined(level.ishorde) && level.ishorde)
	{
		self endon("becameSpectator");
	}

	for(;;)
	{
		self waittill("mech_rocket_fire",var_01);
		playfxontag(common_scripts\utility::getfx("lethal_rocket_wv"),self,"TAG_WEAPON_RIGHT");
		thread reloadrocket(self,param_00);
	}
}

//Function Number: 39
reloadrocket(param_00,param_01)
{
	param_00 endon("death");
	param_00 endon("disconnect");
	if(isdefined(level.ishorde) && level.ishorde)
	{
		param_00 endon("becameSpectator");
	}

	waitattachmentcooldown(10,"ui_exo_suit_punch_cd");
}

//Function Number: 40
playrocketreloadsound(param_00)
{
	self playlocalsound("orbitalsupport_reload_40mm");
}

//Function Number: 41
waitattachmentcooldown(param_00,param_01)
{
	var_02 = 0;
	for(;;)
	{
		wait(0.05);
		var_02 = var_02 + 0.05;
		var_03 = 1 - var_02 / param_00;
		var_03 = clamp(var_03,0,1);
		self setclientomnvar(param_01,var_03);
		if(var_03 <= 0)
		{
			break;
		}
	}
}

//Function Number: 42
setuptrophy(param_00,param_01)
{
	var_02 = param_00 gettagorigin("j_spine4");
	var_03 = spawnattachment("trophy","npc_heavy_exo_armor_trophy_l_base",var_02,undefined,param_00);
	var_03.stunned = 0;
	var_03.ammo = 1;
	var_03 linkto(param_00,"tag_trophy_l",(0,0,0),(0,0,0));
	var_03.weaponname = "heavy_exo_trophy_mp";
	var_03 thread maps\mp\gametypes\_equipment::trophyactive(param_00,undefined,1,var_03.weaponname);
	var_03 thread maps\mp\gametypes\_equipment::trophyaddlaser(12,(90,90,270));
	var_03 thread maps\mp\gametypes\_equipment::trophysetmindot(-0.087,(90,90,270));
	level.trophies[level.trophies.size] = var_03;
	var_04 = spawnattachment("trophy","npc_heavy_exo_armor_trophy_r_base",var_02,undefined,param_00);
	var_04.stunned = 0;
	var_04.ammo = 1;
	var_04 linkto(param_00,"tag_trophy_r",(0,0,0),(0,0,0));
	var_04.weaponname = "heavy_exo_trophy_mp";
	var_04 thread maps\mp\gametypes\_equipment::trophyactive(param_00,undefined,1,var_04.weaponname);
	var_04 thread maps\mp\gametypes\_equipment::trophyaddlaser(6,(260,90,270));
	var_04 thread maps\mp\gametypes\_equipment::trophysetmindot(-0.087,(260,90,270));
	level.trophies[level.trophies.size] = var_04;
	var_03.othertrophy = var_04;
	var_04.othertrophy = var_03;
	waittillattachmentdone(param_00);
	var_03 notify("trophyDisabled");
	var_04 notify("trophyDisabled");
	wait 0.05;
	if(isdefined(var_03.laserent))
	{
		var_03.laserent delete();
	}

	if(isdefined(var_04.laserent))
	{
		var_04.laserent delete();
	}

	var_03 delete();
	var_04 delete();
}

//Function Number: 43
trophystunbegin()
{
	if(self.stunned)
	{
		return;
	}

	self.stunned = 1;
	self.othertrophy.stunned = 1;
	var_00 = spawn("script_model",self.origin);
	var_00 setmodel("tag_origin");
	playfxontag(common_scripts\utility::getfx("mine_stunned"),var_00,"tag_origin");
	thread trophymovestunent(var_00);
	common_scripts\utility::waittill_notify_or_timeout("death",3);
	self notify("stunEnd");
	stopfxontag(common_scripts\utility::getfx("mine_stunned"),var_00,"tag_origin");
	wait 0.05;
	var_00 delete();
	if(isdefined(self))
	{
		self.stunned = 0;
		self.othertrophy.stunned = 0;
	}
}

//Function Number: 44
trophymovestunent(param_00)
{
	self endon("death");
	self endon("stunEnd");
	for(;;)
	{
		param_00.origin = self.origin;
		wait 0.05;
	}
}

//Function Number: 45
setuprocketswarm(param_00,param_01)
{
	var_02 = "playermech_rocket_swarm_mp";
	if(param_01.hasmaniac)
	{
		var_02 = "playermech_rocket_swarm_maniac_mp";
	}

	param_00 settacticalweapon(var_02);
	param_00 giveweapon(var_02);
	var_03 = "tag_origin";
	var_04 = param_00 gettagorigin(var_03);
	var_05 = spawnattachment("rocketAttachment","npc_heavy_exo_armor_missile_pack_base",var_04,undefined,param_00);
	var_05.lockedtarget = 0;
	var_05.reloading = 0;
	var_05.rockets = [];
	var_05.icons = [];
	var_05 linkto(param_00,var_03,(0,0,0),(0,0,0));
	var_05 hide();
	param_00.rocketattachment = var_05;
	thread scanforrocketenemies(var_05,param_00);
	param_00 thread playerwatchrocketuse(var_05,param_01);
	waittillattachmentdone(param_00,var_05);
	wait 0.05;
	var_05 delete();
	param_00.rocketattachment = undefined;
}

//Function Number: 46
scanforrocketenemies(param_00,param_01)
{
	param_01 endon("death");
	param_01 endon("disconnect");
	if(isdefined(level.ishorde) && level.ishorde)
	{
		param_01 endon("becameSpectator");
	}

	for(;;)
	{
		wait 0.05;
		if(param_00.reloading || param_00.rockets.size > 0 || param_00.lockedtarget)
		{
			continue;
		}

		var_02 = getbestenemy(param_01,4);
		if(isdefined(var_02))
		{
			if(!isdefined(param_00.enemytarget) || param_00.enemytarget != var_02)
			{
				thread markplayerasrockettarget(param_00,param_01,var_02);
			}

			continue;
		}

		if(isdefined(param_00.enemytarget))
		{
			param_00 notify("unmark");
			param_00.enemytarget = undefined;
		}
	}
}

//Function Number: 47
playerisrocketswarmreloading()
{
	return isdefined(self.rocketattachment) && isdefined(self.rocketattachment.reloading) && self.rocketattachment.reloading;
}

//Function Number: 48
playerisrocketswarmtargetlocked()
{
	return isdefined(self.rocketattachment) && isdefined(self.rocketattachment.enemytarget);
}

//Function Number: 49
getbestenemy(param_00,param_01)
{
	var_02 = 0.8433914;
	var_03 = anglestoforward(param_00 getplayerangles());
	var_04 = param_00 geteye();
	var_05 = undefined;
	var_06 = [];
	foreach(var_08 in level.participants)
	{
		if(var_08.team == param_00.team)
		{
			continue;
		}

		if(!maps\mp\_utility::isreallyalive(var_08))
		{
			continue;
		}

		var_09 = var_08 geteye();
		var_0A = vectornormalize(var_09 - var_04);
		var_0B = vectordot(var_03,var_0A);
		if(var_0B > var_02)
		{
			var_06[var_06.size] = var_08;
			var_08.dot = var_0B;
			var_08.checked = 0;
		}
	}

	if(var_06.size == 0)
	{
		return;
	}

	for(var_0D = 0;var_0D < param_01 && var_0D < var_06.size;var_0D++)
	{
		var_0E = gethighestdot(var_06);
		var_0E.checked = 1;
		var_0F = var_04;
		var_10 = var_0E geteye();
		var_11 = sighttracepassed(var_0F,var_10,1,param_00,var_0E);
		if(var_11)
		{
			var_05 = var_0E;
			break;
		}
	}

	foreach(var_08 in level.participants)
	{
		var_08.dot = undefined;
		var_08.checked = undefined;
	}

	return var_05;
}

//Function Number: 50
gethighestdot(param_00)
{
	if(param_00.size == 0)
	{
		return;
	}

	var_01 = undefined;
	var_02 = 0;
	foreach(var_04 in param_00)
	{
		if(!var_04.checked && var_04.dot > var_02)
		{
			var_01 = var_04;
			var_02 = var_04.dot;
		}
	}

	return var_01;
}

//Function Number: 51
playerwatchrocketuse(param_00,param_01)
{
	param_00 endon("death");
	for(;;)
	{
		self waittill("mech_swarm_fire",var_02);
		if(param_00.reloading || param_00.lockedtarget)
		{
			wait 0.05;
			continue;
		}

		thread handlelockedtarget(param_00,param_01);
		thread reloadrocketswarm(param_00,self,param_01);
		thread firerocketswarm(param_00,self,var_02);
	}
}

//Function Number: 52
handlelockedtarget(param_00,param_01)
{
	param_00 endon("death");
	param_00.lockedtarget = 1;
	param_00 notify("lockedTarget");
	waittillrocketsexploded(param_00);
	if(isdefined(param_00))
	{
		param_00.lockedtarget = 0;
		param_00.enemytarget = undefined;
	}
}

//Function Number: 53
firerocketswarm(param_00,param_01,param_02)
{
	var_03 = anglestoforward(param_01 getplayerangles());
	var_04 = anglestoright(param_01 getplayerangles());
	var_05 = [(0,0,50),(0,0,20),(10,0,0),(0,10,0)];
	playfxontag(common_scripts\utility::getfx("swarm_rocket_wv"),param_01,"TAG_ROCKET4");
	for(var_06 = 0;var_06 < 4;var_06++)
	{
		var_07 = param_02 + var_03 * 20 + var_04 * -30;
		var_08 = var_03 + random_vector(0.2);
		var_09 = magicbullet("iw5_juggernautrockets_mp",var_07,var_07 + var_08,param_01);
		param_00.rockets = common_scripts\utility::array_add(param_00.rockets,var_09);
		var_09 thread rockettargetent(param_00,param_00.enemytarget,var_05[var_06]);
		var_09 thread rocketdestroyaftertime(7);
	}
}

//Function Number: 54
rockettargetent(param_00,param_01,param_02)
{
	param_00 endon("death");
	if(isdefined(param_01))
	{
		self missile_settargetent(param_01,param_02);
	}

	self waittill("death");
	param_00.rockets = common_scripts\utility::array_remove(param_00.rockets,self);
}

//Function Number: 55
rocketdestroyaftertime(param_00)
{
	self endon("death");
	wait(param_00);
	self delete();
}

//Function Number: 56
reloadrocketswarm(param_00,param_01,param_02)
{
	param_00 endon("death");
	param_00.reloading = 1;
	waitattachmentcooldown(10,"ui_exo_suit_rockets_cd");
	param_00.reloading = 0;
}

//Function Number: 57
playrocketswarmreloadsound(param_00,param_01,param_02)
{
	param_00 endon("death");
	var_03 = 3;
	self playlocalsound("warbird_missile_reload_bed");
	wait(0.5);
	for(var_04 = 0;var_04 < var_03;var_04++)
	{
		self playlocalsound("warbird_missile_reload");
		wait(param_02 / var_03);
	}
}

//Function Number: 58
markplayerasrockettarget(param_00,param_01,param_02)
{
	param_02 endon("disconnect");
	param_00 notify("mark");
	param_00 endon("mark");
	param_00 endon("unmark");
	var_03 = (0,0,60);
	var_04 = param_02 getentitynumber();
	param_00.enemytarget = param_02;
	if(isdefined(level.ishorde) && level.ishorde)
	{
		param_02 hudoutlineenableforclient(param_01,1,0);
		param_01.markedformech[param_01.markedformech.size] = param_02;
	}
	else
	{
		param_02 hudoutlineenableforclient(param_01,4,0);
	}

	thread cleanuprockettargeticon(param_00,param_02,param_01);
	param_00 waittill("lockedTarget");
	param_02 hudoutlineenableforclient(param_01,0,0);
	waittillrocketsexploded(param_00);
	if(isdefined(level.ishorde) && level.ishorde)
	{
		if(level.currentaliveenemycount < 3)
		{
			if(level.objdefend && distancesquared(param_01.origin,level.currentdefendloc.origin) > 640000)
			{
				param_02 hudoutlineenableforclient(param_01,level.enemyoutlinecolor,0);
			}

			param_01.markedformech = common_scripts\utility::array_remove(param_01.markedformech,param_02);
			return;
		}

		param_02 hudoutlinedisableforclient(param_01);
		param_01.markedformech = common_scripts\utility::array_remove(param_01.markedformech,param_02);
		return;
	}

	param_02 hudoutlinedisableforclient(param_01);
}

//Function Number: 59
cleanuprockettargeticon(param_00,param_01,param_02)
{
	param_01 endon("disconnect");
	waittillunmarkplayerasrockettarget(param_00);
	if(isdefined(level.ishorde) && level.ishorde && isdefined(param_02))
	{
		if(level.currentaliveenemycount < 3)
		{
			if(level.objdefend && distancesquared(param_02.origin,level.currentdefendloc.origin) > 640000)
			{
				param_01 hudoutlineenableforclient(param_02,level.enemyoutlinecolor,0);
			}

			param_02.markedformech = common_scripts\utility::array_remove(param_02.markedformech,param_01);
			return;
		}

		param_01 hudoutlinedisableforclient(param_02);
		param_02.markedformech = common_scripts\utility::array_remove(param_02.markedformech,param_01);
		return;
	}

	if(isdefined(param_02))
	{
		param_01 hudoutlinedisableforclient(param_02);
	}
}

//Function Number: 60
waittillunmarkplayerasrockettarget(param_00)
{
	param_00.enemytarget endon("death");
	param_00 common_scripts\utility::waittill_any("death","mark","unmark");
}

//Function Number: 61
waittillrocketsexploded(param_00)
{
	wait(0.1);
	while(isdefined(param_00) && param_00.rockets.size > 0)
	{
		wait 0.05;
	}
}

//Function Number: 62
waittillattachmentdone(param_00,param_01,param_02)
{
	param_00 endon("disconnect");
	param_00 endon("death");
	if(isdefined(level.ishorde) && level.ishorde)
	{
		param_00 endon("becameSpectator");
	}

	if(isdefined(param_01))
	{
		param_01 endon("death");
	}

	if(isdefined(param_02))
	{
		param_02 endon("death");
	}

	param_00 waittill("forever");
}

//Function Number: 63
delayplayfx(param_00,param_01)
{
	param_00 endon("death");
	wait 0.05;
	wait 0.05;
	playfxontag(param_01,param_00,"tag_origin");
}

//Function Number: 64
stopfxonattachment(param_00,param_01,param_02)
{
	if(isdefined(param_00.effect))
	{
		stopfxontag(param_01,param_00.effect,"tag_origin");
		if(isdefined(param_02) && param_02)
		{
			playfx(common_scripts\utility::getfx("juggernaut_sparks"),param_00.effect.origin);
		}

		param_00.effect delete();
	}
}

//Function Number: 65
attachmentdeath(param_00,param_01,param_02,param_03)
{
	param_02 endon("death");
	param_02 endon("disconnect");
	if(isdefined(level.ishorde) && level.ishorde)
	{
		param_02 endon("becameSpectator");
	}

	if(isdefined(param_03))
	{
		param_03 endon("death");
	}

	param_01 waittill("death",var_04,var_05,var_06);
	if(isdefined(var_04) && isplayer(var_04))
	{
		var_07 = level.juggsettings[param_00.juggtype].splashattachmentname;
		if(issubstr(param_01.attachmenttype,"weakSpot"))
		{
			var_07 = level.juggsettings[param_00.juggtype].splashweakenedname;
		}

		maps\mp\_utility::teamplayercardsplash(var_07,var_04);
	}
}

//Function Number: 66
attachmentexplode(param_00,param_01,param_02,param_03)
{
	if(isdefined(param_01))
	{
		if(isalive(param_01))
		{
			param_01 thread playerplayattachmentdialog(param_00.attachmenttype);
		}

		if(isdefined(param_00))
		{
			playfx(common_scripts\utility::getfx("juggernaut_sparks"),param_00.origin);
		}

		if(isdefined(param_03))
		{
			playfx(common_scripts\utility::getfx("juggernaut_sparks"),param_03.origin);
		}

		param_01 playsound("sentry_explode");
	}
}

//Function Number: 67
hidefromplayer(param_00)
{
	self hide();
	foreach(var_02 in level.players)
	{
		if(var_02 != param_00)
		{
			self showtoplayer(var_02);
		}
	}
}

//Function Number: 68
hidefromplayers(param_00)
{
	self hide();
	foreach(var_02 in level.players)
	{
		if(!common_scripts\utility::array_contains(param_00,var_02))
		{
			self showtoplayer(var_02);
		}
	}
}

//Function Number: 69
spawnattachment(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = undefined;
	if(issubstr(param_00,"sentry"))
	{
		var_06 = spawnturret("misc_turret",param_02,param_00);
	}
	else
	{
		var_06 = spawn("script_model",param_02);
	}

	var_06 setmodel(param_01);
	var_06.attachmenttype = param_00;
	if(isdefined(param_03))
	{
		var_06.health = param_03;
		var_06.maxhealth = var_06.health;
		var_06.damagecallback = ::handleattachmentdamage;
		if(isdefined(param_05))
		{
			var_06 thread handleattachmentdeath(param_00,param_04,param_05);
		}

		var_06 setdamagecallbackon(1);
	}

	var_06 hidefromplayer(param_04);
	var_06.owner = param_04;
	if(level.teambased)
	{
		var_06.team = param_04.team;
	}

	return var_06;
}

//Function Number: 70
spawnattachmenteffect(param_00,param_01,param_02)
{
	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	var_03 = spawn("script_model",param_00);
	var_03 setmodel("tag_origin");
	var_03 hidefromplayer(param_01);
	thread delayplayfx(var_03,common_scripts\utility::getfx("green_light_mp"));
	return var_03;
}

//Function Number: 71
handleattachmentdeath(param_00,param_01,param_02)
{
	if(param_00 == "weakSpotHead")
	{
		return;
	}

	level endon("game_ended");
	self waittill("death",var_03,var_04,var_05);
	if(!isdefined(var_03) || !isplayer(var_03) || isdefined(param_01) && var_03 == param_01)
	{
		return;
	}

	level thread maps\mp\gametypes\_rank::awardgameevent("heavy_exo_attachment",var_03,undefined,undefined,undefined,param_02);
}

//Function Number: 72
handleattachmentdamage(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B)
{
	if(!isdefined(self.lasttimedamaged))
	{
		self.lasttimedamaged = 0;
	}

	var_0C = param_02;
	if((isdefined(param_01) && !maps\mp\gametypes\_weapons::friendlyfirecheck(self.owner,param_01)) || param_01 == self.owner || self.lasttimedamaged == gettime())
	{
		var_0C = 0;
	}
	else
	{
		if(isdefined(param_05) && param_05 == "boost_slam_mp" && param_02 > 10)
		{
			var_0C = 10;
		}

		if(maps\mp\_utility::ismeleemod(param_04))
		{
			var_0C = var_0C + self.maxhealth;
		}

		if(isdefined(param_03) && param_03 & level.idflags_penetration)
		{
			self.wasdamagedfrombulletpenetration = 1;
		}

		self.wasdamaged = 1;
		self.damagefade = 0;
		if(isplayer(param_01))
		{
			if(param_01 maps\mp\_utility::_hasperk("specialty_armorpiercing"))
			{
				var_0C = var_0C * level.armorpiercingmod;
			}

			param_01 maps\mp\gametypes\_damagefeedback::updatedamagefeedback("juggernautAttachment");
			param_01 notify("hitHeavyExoAttachment");
			self.lastattacker = param_01;
		}

		if(isdefined(param_05))
		{
			var_0D = maps\mp\_utility::strip_suffix(param_05,"_lefthand");
			switch(var_0D)
			{
				case "ac130_40mm_mp":
				case "ac130_105mm_mp":
				case "stinger_mp":
				case "remotemissile_projectile_mp":
					break;

				case "stealth_bomb_mp":
				case "artillery_mp":
					break;

				case "emp_grenade_killstreak_mp":
				case "emp_grenade_var_mp":
				case "emp_grenade_mp":
				case "bomb_site_mp":
					break;
			}
		}
	}
}

//Function Number: 73
random_vector(param_00)
{
	return (randomfloat(param_00) - param_00 * 0.5,randomfloat(param_00) - param_00 * 0.5,randomfloat(param_00) - param_00 * 0.5);
}

//Function Number: 74
handlecoopjoining(param_00,param_01)
{
	for(;;)
	{
		var_02 = maps\mp\killstreaks\_coop_util::promptforstreaksupport(param_01.team,&"MP_JOIN_HEAVY_EXO","heavy_exosuit_coop_offensive","assist_mp_goliath","copilot_mp_goliath",param_01);
		level thread watchforjoin(var_02,param_01,param_00);
		var_03 = waittillpromptcomplete(param_01,"buddyJoinedStreak");
		maps\mp\killstreaks\_coop_util::stoppromptforstreaksupport(var_02);
		if(!isdefined(var_03))
		{
			return;
		}

		var_03 = waittillpromptcomplete(param_01,"buddyLeftCoopTurret");
		if(!isdefined(var_03))
		{
			return;
		}
	}
}

//Function Number: 75
waittillpromptcomplete(param_00,param_01,param_02,param_03)
{
	param_00 endon("death");
	param_00 endon("disconnect");
	param_00 endon("turretDead");
	if(isdefined(level.ishorde) && level.ishorde)
	{
		param_00 endon("becameSpectator");
	}

	return param_00 common_scripts\utility::waittill_any_return_no_endon_death(param_01,param_02,param_03);
}

//Function Number: 76
waittillturretstuncomplete(param_00,param_01)
{
	param_01 endon("death");
	param_01 endon("disconnect");
	param_01 endon("turretDead");
	if(isdefined(level.ishorde) && level.ishorde)
	{
		param_01 endon("becameSpectator");
	}

	for(;;)
	{
		wait 0.05;
		if(param_00.coopturret.stunned || param_00.coopturret.directhacked)
		{
			continue;
		}

		return 1;
	}
}

//Function Number: 77
watchforjoin(param_00,param_01,param_02)
{
	param_01 endon("disconnect");
	param_01 endon("death");
	if(isdefined(level.ishorde) && level.ishorde)
	{
		param_01 endon("becameSpectator");
	}

	var_03 = maps\mp\killstreaks\_coop_util::waittillbuddyjoinedstreak(param_00);
	param_01 notify("buddyJoinedStreak");
	var_03 thread playerremotecoopturret(param_02);
}

//Function Number: 78
playerremotecoopturret(param_00)
{
	self endon("disconnect");
	param_00.coopturret endon("death");
	param_00.streakplayer endon("death");
	param_00.streakplayer endon("disconnect");
	if(isdefined(level.ishorde) && level.ishorde)
	{
		self endon("becameSpectator");
		param_00.streakplayer endon("becameSpectator");
	}

	param_00.coopturret setsentryowner(undefined);
	param_00.coopturret setsentryowner(self);
	param_00.coopturret.owner = self;
	param_00.coopturret.effect hidefromplayers([self,param_00.streakplayer]);
	self.using_remote_turret = 1;
	param_00.coopturret maps\mp\killstreaks\_remoteturret::startusingremoteturret(180,180,55,30,1);
	thread removecoopturretbuddyondisconnect(param_00);
	param_00.coopturret maps\mp\killstreaks\_remoteturret::waittillremoteturretleavereturn();
	removecoopturretbuddy(param_00);
}

//Function Number: 79
removecoopturretbuddyondisconnect(param_00)
{
	param_00.coopturret endon("removeCoopTurretBuddy");
	self waittill("disconnect");
	thread removecoopturretbuddy(param_00);
}

//Function Number: 80
removecoopturretbuddy(param_00)
{
	if(!isdefined(param_00.coopturret.remotecontrolled))
	{
		return;
	}

	param_00.coopturret notify("removeCoopTurretBuddy");
	param_00.coopturret.remotecontrolled = undefined;
	var_01 = param_00.coopturret.owner;
	if(isdefined(var_01))
	{
		var_01.using_remote_turret = undefined;
		param_00.coopturret maps\mp\killstreaks\_remoteturret::stopusingremoteturret(0);
	}
	else if(isalive(param_00.coopturret))
	{
	}

	var_01 enableweaponswitch();
	if(isdefined(param_00.streakplayer) && maps\mp\_utility::isreallyalive(param_00.streakplayer))
	{
		if(isdefined(param_00.coopturret.effect))
		{
			param_00.coopturret.effect hide();
		}

		param_00.coopturret setsentryowner(undefined);
		param_00.coopturret setsentryowner(param_00.streakplayer);
		param_00.coopturret.owner = param_00.streakplayer;
		param_00.streakplayer notify("buddyLeftCoopTurret");
	}
}

//Function Number: 81
playershowjuggernauthud(param_00)
{
	param_00.hud = [];
	thread playerwatchemp(param_00);
	createjuggernautoverlay(param_00);
}

//Function Number: 82
createjuggernautoverlay(param_00)
{
	self setclientomnvar("ui_exo_suit_enabled",1);
	thread playermech_state_manager();
}

//Function Number: 83
playerwatchemp(param_00)
{
	self endon("death");
	self endon("disconnect");
	if(isdefined(level.ishorde) && level.ishorde)
	{
		self endon("becameSpectator");
	}

	for(;;)
	{
		common_scripts\utility::waittill_any("emp_grenaded","applyEMPkillstreak","directHackStarted");
		foreach(var_02 in param_00.hud)
		{
			var_02.alpha = 0;
		}

		for(;;)
		{
			common_scripts\utility::waittill_any("empGrenadeTimedOut","removeEMPkillstreak","directHackTimedOut");
			wait 0.05;
			if(playershouldshowhud())
			{
				break;
			}
		}

		foreach(var_02 in param_00.hud)
		{
			if(var_02.type != "rocketReload")
			{
				var_02 fadeovertime(0.5);
				var_02.alpha = 1;
			}
		}
	}
}

//Function Number: 84
playershouldshowhud()
{
	return !isdefined(self.empgrenaded) || !self.empgrenaded || !isdefined(self.empon) || !self.empon;
}

//Function Number: 85
playerplayattachmentdialog(param_00)
{
	var_01 = undefined;
	switch(param_00)
	{
		case "juggernaut_sentry_mp_mp":
			break;

		case "speedAttachment":
			break;

		case "punchAttachment":
			break;

		case "radar":
			break;

		case "rocketAttachment":
			break;

		case "trophy":
			break;

		default:
			break;
	}
}

//Function Number: 86
playerlaunchdroppod(param_00)
{
	var_01 = maps\mp\killstreaks\_orbital_util::playergetoutsidenode();
	if(!isdefined(var_01))
	{
		thread maps\mp\killstreaks\_orbital_util::playerplayinvalidpositioneffect(common_scripts\utility::getfx("ocp_ground_marker_bad"));
		self setclientomnvar("ui_invalid_goliath",1);
		return 0;
	}

	thread firedroppod(var_01,param_00);
	return 1;
}

//Function Number: 87
droppodmovenearbyallies(param_00)
{
	if(!isdefined(self) || !isdefined(param_00))
	{
		return;
	}

	self.unresolved_collision_nodes = getnodesinradius(self.origin,300,80,200);
	foreach(var_02 in level.characters)
	{
		if(!isalive(var_02))
		{
			continue;
		}

		if(isalliedsentient(var_02,param_00))
		{
			if(distancesquared(self.origin,var_02.origin) < 6000)
			{
				maps\mp\_movers::unresolved_collision_nearest_node(var_02,1);
			}
		}
	}
}

//Function Number: 88
givebackgoliathstreak(param_00)
{
	var_01 = maps\mp\killstreaks\_killstreaks::getstreakcost("heavy_exosuit");
	var_02 = maps\mp\killstreaks\_killstreaks::getnextkillstreakslotindex("heavy_exosuit",0);
	thread maps\mp\gametypes\_hud_message::killstreaksplashnotify("heavy_exosuit",var_01,undefined,param_00,var_02);
	thread maps\mp\killstreaks\_killstreaks::givekillstreak("heavy_exosuit",0,0,self,param_00);
}

//Function Number: 89
firedroppod(param_00,param_01)
{
	var_02 = maps\mp\killstreaks\_orbital_util::playergetorbitalstartpos(param_00);
	var_03 = param_00.origin;
	var_04 = magicbullet("orbital_carepackage_droppod_mp",var_02,var_03,self,0,1);
	var_04.team = self.team;
	var_04.killcament = spawn("script_model",(0,0,0));
	var_04.killcament vehicle_jetbikesethoverforcescale(var_04,"tag_origin",(0,0,200),(0,10,10));
	var_04.killcament.targetname = "killCamEnt_goliath_droppod";
	var_04.killcament setscriptmoverkillcam("missile");
	var_04 thread maps\mp\_load::deletedestructiblekillcament();
	var_05 = maps\mp\gametypes\_gameobjects::getnextobjid();
	objective_add(var_05,"invisible",(0,0,0));
	objective_position(var_05,var_03);
	objective_state(var_05,"active");
	var_06 = "compass_waypoint_farp";
	objective_icon(var_05,var_06);
	var_07 = spawn("script_model",var_03 + (0,0,5));
	var_07.angles = (-90,0,0);
	var_07 setmodel("tag_origin");
	var_07 hide();
	var_07 showtoplayer(self);
	playfxontag(common_scripts\utility::getfx("jugg_droppod_marker"),var_07,"tag_origin");
	maps\mp\killstreaks\_orbital_util::adddropmarker(var_07);
	var_08 = 0;
	if(isdefined(level.ishorde) && level.ishorde)
	{
		if(self.killstreakindexweapon == 1)
		{
			self notify("used_horde_goliath");
			var_08 = 1;
			self.hordeclassgoliathpodinfield = 1;
		}

		self.hordegoliathpodinfield = 1;
	}

	var_04 waittill("death");
	if(distancesquared(var_04.origin,var_03) > 22500)
	{
		var_07 delete();
		maps\mp\_utility::_objective_delete(var_05);
		if(!isdefined(level.ishorde) || !level.ishorde)
		{
			givebackgoliathstreak(param_01);
		}
		else
		{
			self [[ level.hordegivebackgoliath ]](var_08);
			self.hordeclassgoliathpodinfield = undefined;
			self.hordegoliathpodinfield = undefined;
		}

		return;
	}

	var_03 = getgroundposition(var_04.origin + (0,0,8),20);
	thread destroy_nearby_turrets(var_03);
	var_07 hide();
	earthquake(0.4,1,var_03,800);
	playrumbleonposition("artillery_rumble",var_03);
	stopfxontag(common_scripts\utility::getfx("jugg_droppod_marker"),var_07,"tag_origin");
	var_09 = spawn("script_model",var_03);
	var_09.angles = (0,0,0);
	var_09 createcollision(var_03);
	var_09.targetname = "care_package";
	var_09.droppingtoground = 0;
	var_09.curobjid = var_05;
	var_0A = spawn("script_model",var_03);
	var_0A.angles = (90,0,0);
	var_0A.targetname = "goliath_pod_model";
	var_0A setmodel("vehicle_drop_pod");
	var_0A thread handle_goliath_drop_pod_removal(var_09);
	if(isdefined(self))
	{
		var_09.owner = self;
	}

	var_09.cratetype = "juggernaut";
	var_09.droptype = "juggernaut";
	var_09 thread control_goliath_usability();
	var_09 sethintstring(&"KILLSTREAKS_HEAVY_EXO_PICKUP");
	var_09 thread maps\mp\killstreaks\_airdrop::crateothercapturethink();
	var_09 thread maps\mp\killstreaks\_airdrop::crateownercapturethink();
	var_09 thread usegoliathupdater();
	var_0B = spawnstruct();
	var_0B.useent = var_09;
	var_0B.playdeathfx = 1;
	var_0B.deathoverridecallback = ::movingplatformdeathfunc;
	var_0B.touchingplatformvalid = ::movingplatformtouchvalid;
	var_09 thread maps\mp\_movers::handle_moving_platforms(var_0B);
	var_09 thread handle_goliath_drop_pod_timeout(var_08);
	var_09 droppodmovenearbyallies(self);
	if(isdefined(level.ishorde) && level.ishorde)
	{
		var_09 disconnectpaths();
	}

	if(isdefined(level.ishorde) && level.ishorde)
	{
		if(level.zombiesstarted || level.teamemped["allies"])
		{
			var_09 deletegoliathpod();
		}
		else
		{
			var_09 thread delete_goliath_drop_pod_for_event(self);
		}
	}

	var_0C = var_09 playerwaittillgoliathactivated();
	if(isdefined(level.ishorde) && level.ishorde && isdefined(self))
	{
		if(isdefined(var_0C) && var_0C != self)
		{
			if(var_08)
			{
				var_0C.hordeclassgoliathowner = self;
				self.hordeclassgoliathcontroller = var_0C;
			}
			else
			{
				var_0C.hordegoliathowner = self;
				self.hordegoliathcontroller = var_0C;
			}

			var_0C [[ level.laststandsaveloadoutinfo ]](1,1,1);
		}
		else
		{
			self [[ level.laststandsaveloadoutinfo ]](1,1,1);
		}

		self.hordeclassgoliathpodinfield = undefined;
		self.hordegoliathpodinfield = undefined;
	}

	if(isdefined(var_0C) && isalive(var_0C))
	{
		maps\mp\gametypes\_gamelogic::sethasdonecombat(var_0C,1);
		self notify("entering_juggernaut");
		var_0C.enteringgoliath = 1;
		var_0C takeallweapons();
		var_0C giveweapon("iw5_combatknifegoliath_mp",0,0,0,1);
		var_0C switchtoweapon("iw5_combatknifegoliath_mp");
		var_0C unlink();
		var_0C maps\mp\_utility::freezecontrolswrapper(1);
		var_0D = var_03 - var_0C.origin;
		var_0E = vectortoangles(var_0D);
		var_0F = (0,var_0E[1],0);
		var_10 = rotatevector(var_0D,(45,0,0));
		var_11 = spawn("script_model",var_03);
		var_11.angles = var_0F;
		var_11 setmodel("npc_exo_armor_ingress");
		var_11 scriptmodelplayanimdeltamotion("mp_goliath_spawn");
		var_0C maps\mp\_snd_common_mp::snd_message("goliath_pod_burst");
		if(isdefined(var_09))
		{
			var_09 deletegoliathpod(0);
		}

		playfx(level._effect["jugg_droppod_open"],var_03,var_10);
		wait(0.1);
		var_0C is_entering_goliath(var_11,var_03);
		if(isdefined(var_0C) && isalive(var_0C) && !isdefined(level.ishorde) && level.ishorde && isdefined(var_0C.isspectator) && var_0C.isspectator)
		{
			var_0C setorigin(var_03,1);
			var_0C setplayerangles(var_11.angles);
			var_0C enableweapons();
			var_0C givejuggernaut("juggernaut_exosuit",param_01);
			var_11 delete();
			var_0C playgoliathtoidleleanim();
			if(isdefined(level.ishorde) && level.ishorde)
			{
				var_0C.enteringgoliath = undefined;
			}

			wait(1);
			var_0C.enteringgoliath = undefined;
			var_0C maps\mp\_utility::freezecontrolswrapper(0);
			if(isdefined(level.ishorde) && level.ishorde)
			{
				var_0C hudoutlineenable(5,1);
			}
		}
		else
		{
			var_11 delete();
		}
	}

	var_07 delete();
}

//Function Number: 90
destroy_nearby_turrets(param_00)
{
	var_01 = 4096;
	foreach(var_03 in level.players)
	{
		if(isdefined(var_03.turret) && distancesquared(var_03.turret.origin,param_00) <= var_01)
		{
			var_03.turret notify("death");
		}
	}
}

//Function Number: 91
is_goliath_drop_pod(param_00)
{
	return isdefined(param_00.cratetype) && param_00.cratetype == "juggernaut" && isdefined(param_00.droptype) && param_00.droptype == "juggernaut";
}

//Function Number: 92
movingplatformdeathfunc(param_00)
{
	if(isdefined(self) && isdefined(self.curobjid))
	{
		maps\mp\_utility::_objective_delete(self.curobjid);
	}

	if(isdefined(param_00.emptymech))
	{
		param_00.emptymech delete();
	}

	if(isdefined(param_00.useent))
	{
		param_00.useent delete();
	}
}

//Function Number: 93
movingplatformtouchvalid(param_00)
{
	return goliathandcarepackagevalid(param_00) && goliathandgoliathvalid(param_00) && goliathandplatformvalid(param_00);
}

//Function Number: 94
goliathandcarepackagevalid(param_00)
{
	return !isdefined(self.cratetype) || !isdefined(param_00.targetname) || self.cratetype != "juggernaut" || param_00.targetname != "care_package";
}

//Function Number: 95
goliathandgoliathvalid(param_00)
{
	return !isdefined(self.cratetype) || !isdefined(param_00.cratetype) || self.cratetype != "juggernaut" || param_00.cratetype != "juggernaut";
}

//Function Number: 96
goliathandplatformvalid(param_00)
{
	return !isdefined(self.cratetype) || !isdefined(param_00.carepackagetouchvalid) || self.cratetype != "juggernaut" || !param_00.carepackagetouchvalid;
}

//Function Number: 97
control_goliath_usability()
{
	self endon("captured");
	self endon("death");
	level endon("game_ended");
	self makeusable();
	foreach(var_01 in level.players)
	{
		self disableplayeruse(var_01);
	}

	for(;;)
	{
		foreach(var_01 in level.players)
		{
			var_04 = 0;
			if(var_01 isonground() && !var_01 isonladder() && !var_01 isjumping() && !var_01 ismantling() && maps\mp\_utility::isreallyalive(var_01) && var_01 getstance() == "stand")
			{
				if(distancesquared(self.origin,var_01.origin) < 6000)
				{
					if(var_01 worldpointinreticle_rect(self.origin + (0,0,50),65,400,600))
					{
						var_04 = 1;
					}
				}
			}

			if(var_04 == 1)
			{
				self enableplayeruse(var_01);
				continue;
			}

			self disableplayeruse(var_01);
		}

		wait(0.2);
	}
}

//Function Number: 98
is_entering_goliath(param_00,param_01)
{
	var_02 = anglestoforward(param_00.angles);
	param_01 = param_01 - var_02 * 37;
	self setorigin(param_01,0);
	self setplayerangles(param_00.angles);
	wait(0.05);
	param_00 scriptmodelplayanimdeltamotion("mp_goliath_enter");
	self playgoliathentryanim();
	wait(2.3);
}

//Function Number: 99
createcollision(param_00)
{
	var_01 = getent("goliath_collision","targetname");
	if(isdefined(var_01))
	{
		self clonebrushmodeltoscriptmodel(var_01);
	}
}

//Function Number: 100
playerwaittillgoliathactivated()
{
	self endon("death");
	self waittill("captured",var_00);
	var_00 setstance("stand");
	var_00 setdemigod(1);
	if(isdefined(self.owner) && var_00 != self.owner)
	{
		if(!level.teambased || var_00.team != self.owner.team)
		{
			var_00 thread maps\mp\_events::hijackerevent(self.owner);
		}
		else if(!isdefined(level.ishorde))
		{
			self.owner thread maps\mp\_events::sharedevent();
		}
	}

	return var_00;
}

//Function Number: 101
usegoliathupdater()
{
	self endon("death");
	level endon("game_ended");
	foreach(var_01 in level.players)
	{
		if(var_01 maps\mp\_utility::isjuggernaut())
		{
			self disableplayeruse(var_01);
			thread usepostjuggernautupdater(var_01);
		}
	}

	for(;;)
	{
		level waittill("juggernaut_equipped",var_01);
		self disableplayeruse(var_01);
		thread usepostjuggernautupdater(var_01);
	}
}

//Function Number: 102
usepostjuggernautupdater(param_00)
{
	self endon("death");
	level endon("game_ended");
	param_00 endon("disconnect");
	if(isdefined(level.ishorde) && level.ishorde)
	{
		param_00 endon("becameSpectator");
	}

	param_00 waittill("death");
	self enableplayeruse(param_00);
}

//Function Number: 103
adjustlink(param_00,param_01,param_02,param_03,param_04)
{
	param_00 endon("death");
	if(!isdefined(param_03))
	{
		param_03 = (0,0,0);
	}

	if(!isdefined(param_04))
	{
		param_04 = (0,0,0);
	}

	thread drawspine(param_02,param_00);
	setdvar("scr_adjust_angles","" + param_04);
	setdvar("scr_adjust_origin","" + param_03);
	var_05 = (0,0,0);
	var_06 = (0,0,0);
	for(;;)
	{
		wait 0.05;
		var_07 = getdvarvector("scr_adjust_angles");
		var_08 = getdvarvector("scr_adjust_origin");
		if(var_07 == var_05 && var_08 == var_06)
		{
			continue;
		}

		var_05 = var_07;
		var_06 = var_08;
		param_00 unlink();
		param_00 linkto(param_02,param_01,var_06,var_05);
	}
}

//Function Number: 104
drawspine(param_00,param_01)
{
	param_00 endon("disconnect");
	param_00 endon("death");
	param_01 endon("death");
	if(isdefined(level.ishorde) && level.ishorde)
	{
		param_00 endon("becameSpectator");
	}

	for(;;)
	{
		var_02 = param_01.origin;
		var_03 = param_01.angles;
		debug_axis(var_02,var_03);
		wait 0.05;
	}
}

//Function Number: 105
debug_axis(param_00,param_01)
{
	var_02 = 20;
	var_03 = anglestoforward(param_01) * var_02;
	var_04 = anglestoright(param_01) * var_02;
	var_05 = anglestoup(param_01) * var_02;
}

//Function Number: 106
playermech_ui_state_reset()
{
	if(!isdefined(self.mechuistate))
	{
		self.mechuistate = spawnstruct();
		self.mechuistate.chaingun = spawnstruct();
		self.mechuistate.swarm = spawnstruct();
		self.mechuistate.rocket = spawnstruct();
		self.mechuistate.threat_list = spawnstruct();
		self.mechuistate.state = "none";
		self.mechuistate.chaingun.state = "none";
		self.mechuistate.chaingun.last_state = "none";
		self.mechuistate.swarm.state = "none";
		self.mechuistate.swarm.last_state = "none";
		self.mechuistate.rocket.state = "none";
		self.mechuistate.rocket.last_state = "none";
	}

	set_mech_state();
	self.mechuistate.threat_list.threats = [];
	self.mechuistate.threat_list.compass_offsets = [];
	self.mechuistate.chaingun.heatlevel = 0;
	self.mechuistate.chaingun.overheated = 0;
	self.mechuistate.swarm.threat_scan = 0;
	self.mechuistate.swarm.recharge = 100;
	self.mechuistate.rocket.fire = 0;
	self.mechuistate.rocket.recharge = 100;
}

//Function Number: 107
playermech_state_manager()
{
	self endon("disconnect");
	self endon("exit_mech");
	if(isdefined(level.ishorde) && level.ishorde)
	{
		self endon("becameSpectator");
	}

	playermech_ui_state_reset();
	set_mech_state();
	set_mech_chaingun_state();
	set_mech_rocket_state();
	set_mech_swarm_state();
	wait 0.05;
	for(;;)
	{
		state_chaingun_pump();
		state_rocket_pump();
		state_swarm_pump();
		playermech_ui_update_lui(self.mechuistate);
		wait(0.05);
	}
}

//Function Number: 108
set_mech_state(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = "none";
	}

	if(!isdefined(self.mechuistate))
	{
		return;
	}

	if(self.mechuistate.state == param_00)
	{
		return;
	}

	self.mechuistate.state = param_00;
}

//Function Number: 109
get_mech_state()
{
	if(!isdefined(self.mechuistate))
	{
		return;
	}

	return self.mechuistate.state;
}

//Function Number: 110
get_is_in_mech()
{
	var_00 = self getattachmodelname(0);
	if(isdefined(var_00) && var_00 == "head_hero_cormack_sentinel_halo")
	{
		return 1;
	}

	return 0;
}

//Function Number: 111
get_front_sorted_threat_list(param_00,param_01)
{
	var_02 = [];
	foreach(var_04 in param_00)
	{
		if(vectordot(var_04.origin - self.origin,param_01) < 0)
		{
			continue;
		}

		var_02[var_02.size] = var_04;
	}

	var_02 = sortbydistance(var_02,self.origin);
	return var_02;
}

//Function Number: 112
playermech_ui_weapon_feedback(param_00,param_01)
{
	self endon("disconnect");
	self endon("exit_mech");
	if(isdefined(level.ishorde) && level.ishorde)
	{
		self endon("becameSpectator");
	}

	self setclientomnvar(param_01,0);
	for(;;)
	{
		while(!self [[ param_00 ]]())
		{
			wait(0.05);
		}

		self setclientomnvar(param_01,1);
		while(self [[ param_00 ]]())
		{
			wait(0.05);
		}

		self setclientomnvar(param_01,0);
		wait(0.05);
	}
}

//Function Number: 113
playermech_ui_update_lui(param_00)
{
	var_01 = playerisrocketswarmtargetlocked();
	var_02 = 0;
	if(var_01)
	{
		var_02 = 1;
	}

	if(self.heavyexodata.hasrockets)
	{
		self setclientomnvar("ui_playermech_swarmrecharge",param_00.swarm.recharge);
	}

	if(self.heavyexodata.haslongpunch)
	{
		self setclientomnvar("ui_playermech_rocketrecharge",param_00.rocket.recharge);
	}
}

//Function Number: 114
playermech_invalid_gun_callback()
{
	if(self.mechuistate.chaingun.overheated)
	{
		return 1;
	}

	return 0;
}

//Function Number: 115
playermech_invalid_rocket_callback()
{
	if(self.mechuistate.rocket.recharge < 100)
	{
		return 1;
	}

	return 0;
}

//Function Number: 116
playermech_invalid_swarm_callback()
{
	if(self.mechuistate.swarm.recharge < 100)
	{
		return 1;
	}

	return 0;
}

//Function Number: 117
playermech_invalid_weapon_instance(param_00,param_01)
{
	self endon("disconnect");
	self endon("exit_mech");
	if(isdefined(level.ishorde) && level.ishorde)
	{
		self endon("becameSpectator");
	}

	var_02 = 0;
	for(;;)
	{
		wait(0.05);
		if(self [[ param_00 ]]())
		{
			if(!var_02)
			{
				if([[ param_01 ]]())
				{
					var_02 = 1;
					self playlocalsound("wpn_mech_offline");
					wait(1.5);
				}
			}

			continue;
		}

		var_02 = 0;
	}
}

//Function Number: 118
playermech_invalid_weapon_watcher()
{
	thread playermech_invalid_weapon_instance(::attackbuttonpressed,::playermech_invalid_gun_callback);
	thread playermech_invalid_weapon_instance(::fragbuttonpressed,::playermech_invalid_rocket_callback);
	thread playermech_invalid_weapon_instance(::secondaryoffhandbuttonpressed,::playermech_invalid_swarm_callback);
}

//Function Number: 119
state_main_pump()
{
	switch(get_mech_state())
	{
		case "dmg2":
		case "dmg2_transition":
		case "dmg1":
		case "dmg1_transition":
		case "base":
		case "base_transition":
		case "base_swarmonly":
		case "base_noweap":
		case "base_swarmonly_exit":
		case "base_swarmonly_nolegs":
		case "base_noweap_bootup":
			break;

		case "none":
			break;

		default:
			break;
	}
}

//Function Number: 120
state_chaingun_pump()
{
	var_00 = get_mech_chaingun_state();
	var_01 = self getcurrentweapon();
	self.mechuistate.chaingun.heatlevel = self getweaponheatlevel(var_01);
	self.mechuistate.chaingun.overheated = self isweaponoverheated(var_01);
	if(var_00 == "ready")
	{
		if(self.mechuistate.chaingun.overheated)
		{
			set_mech_chaingun_state("overheat");
			return;
		}

		if(self attackbuttonpressed())
		{
			set_mech_chaingun_state("firing");
			return;
		}

		return;
	}

	if(var_00 == "firing")
	{
		if(self.mechuistate.chaingun.overheated)
		{
			set_mech_chaingun_state("overheat");
			return;
		}

		if(!self attackbuttonpressed())
		{
			set_mech_chaingun_state("ready");
			return;
		}

		return;
	}

	if(var_00 == "overheat" && !self.mechuistate.chaingun.overheated)
	{
		set_mech_chaingun_state("ready");
		return;
	}
}

//Function Number: 121
state_rocket_pump()
{
	var_00 = get_mech_rocket_state();
	if(var_00 != "offline" && playermech_invalid_rocket_callback())
	{
		set_mech_rocket_state("reload");
		return;
	}

	if(var_00 == "reload" && !playermech_invalid_rocket_callback())
	{
		set_mech_rocket_state("ready");
	}
}

//Function Number: 122
state_swarm_pump()
{
	var_00 = get_mech_swarm_state();
	if(!playerisrocketswarmtargetlocked() && !playerisrocketswarmreloading())
	{
		set_mech_swarm_state("target");
		return;
	}

	if(var_00 == "target" && playermech_invalid_swarm_callback())
	{
		set_mech_swarm_state("reload");
		return;
	}

	if(var_00 == "reload" && !playermech_invalid_swarm_callback())
	{
		set_mech_swarm_state("ready");
		return;
	}
}

//Function Number: 123
set_mech_chaingun_state(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = "none";
	}

	if(!isdefined(self.mechuistate.chaingun.state))
	{
		self.mechuistate.chaingun.state = "none";
	}

	if(self.mechuistate.chaingun.state == param_00)
	{
		return;
	}

	self.mechuistate.chaingun.state = param_00;
	self notify("chaingun_state_" + param_00);
}

//Function Number: 124
get_mech_chaingun_state()
{
	if(!isdefined(self.mechuistate))
	{
		return;
	}

	return self.mechuistate.chaingun.state;
}

//Function Number: 125
same_mech_chaingun_last_state()
{
	if(isdefined(self.mechuistate.chaingun.last_state) && self.mechuistate.chaingun.state == self.mechuistate.chaingun.last_state)
	{
		return 1;
	}

	self.mechuistate.chaingun.last_state = self.mechuistate.chaingun.state;
	return 0;
}

//Function Number: 126
set_mech_rocket_state(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = "none";
	}

	if(!isdefined(self.mechuistate.rocket.state))
	{
		self.mechuistate.rocket.state = "none";
	}

	if(self.mechuistate.rocket.state == param_00)
	{
		return;
	}

	self.mechuistate.rocket.state = param_00;
}

//Function Number: 127
get_mech_rocket_state()
{
	if(!isdefined(self.mechuistate))
	{
		return;
	}

	return self.mechuistate.rocket.state;
}

//Function Number: 128
same_mech_rocket_last_state()
{
	if(isdefined(self.mechuistate.rocket.last_state) && self.mechuistate.rocket.state == self.mechuistate.rocket.last_state)
	{
		return 1;
	}

	self.mechuistate.rocket.last_state = self.mechuistate.rocket.state;
	return 0;
}

//Function Number: 129
set_mech_swarm_state(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = "none";
	}

	if(!isdefined(self.mechuistate.swarm.state))
	{
		self.mechuistate.swarm.state = "none";
	}

	if(self.mechuistate.swarm.state == param_00)
	{
		return;
	}

	self.mechuistate.swarm.state = param_00;
}

//Function Number: 130
get_mech_swarm_state()
{
	if(!isdefined(self.mechuistate))
	{
		return;
	}

	return self.mechuistate.swarm.state;
}

//Function Number: 131
same_mech_swarm_last_state()
{
	if(isdefined(self.mechuistate.swarm.last_state) && self.mechuistate.swarm.state == self.mechuistate.swarm.last_state)
	{
		return 1;
	}

	self.mechuistate.swarm.last_state = self.mechuistate.swarm.state;
	return 0;
}

//Function Number: 132
playermech_monitor_update_recharge(param_00,param_01)
{
	param_00.recharge = 0;
	var_02 = 100 / param_01 / 0.05;
	while(param_00.recharge < 100)
	{
		param_00.recharge = param_00.recharge + var_02;
		wait(0.05);
	}

	param_00.recharge = 100;
	while(isdefined(self.underwatermotiontype))
	{
		wait(0.05);
	}
}

//Function Number: 133
playermech_monitor_rocket_recharge()
{
	self endon("disconnect");
	self endon("exit_mech");
	self notify("stop_rocket_recharge");
	self endon("stop_rocket_recharge");
	if(isdefined(level.ishorde) && level.ishorde)
	{
		self endon("becameSpectator");
	}

	for(;;)
	{
		self waittill("mech_rocket_fire");
		self disableoffhandweapons();
		playermech_monitor_update_recharge(self.mechuistate.rocket,10);
		self enableoffhandweapons();
		wait(0.05);
	}
}

//Function Number: 134
playermech_monitor_swarm_recharge()
{
	self endon("disconnect");
	self endon("exit_mech");
	self notify("stop_swarm_recharge");
	self endon("stop_swarm_recharge");
	if(isdefined(level.ishorde) && level.ishorde)
	{
		self endon("becameSpectator");
	}

	for(;;)
	{
		self waittill("mech_swarm_fire");
		self disableoffhandsecondaryweapons();
		playermech_monitor_update_recharge(self.mechuistate.swarm,10);
		self enableoffhandsecondaryweapons();
		wait(0.05);
	}
}

//Function Number: 135
play_goliath_death_fx()
{
	level endon("game_ended");
	self endon("disconnect");
	if(isdefined(level.ishorde) && level.ishorde)
	{
		self endon("becameSpectator");
	}

	common_scripts\utility::waittill_any("death","joined_team","faux_spawn");
	if(isai(self))
	{
		maps\mp\_snd_common_mp::snd_message("goliath_self_destruct");
		playfx(common_scripts\utility::getfx("goliath_self_destruct"),self.origin,anglestoup(self.angles));
		if(isagent(self) && isdefined(self.hideondeath) && self.hideondeath == 1)
		{
			var_00 = self getcorpseentity();
			if(isdefined(var_00))
			{
				var_00 hide();
			}
		}
	}
	else if(!isdefined(self.juggernautsuicide) && !isdefined(level.ishorde))
	{
		playfxontag(common_scripts\utility::getfx("goliath_death_fire"),self.body,"J_NECK");
		maps\mp\_snd_common_mp::snd_message("goliath_death_explosion");
	}

	self.juggernautsuicide = undefined;
}

//Function Number: 136
self_destruct_goliath()
{
	level endon("game_ended");
	self endon("death");
	self endon("disconnect");
	self endon("joined_team");
	self endon("faux_spawn");
	if(isdefined(level.ishorde) && level.ishorde)
	{
		self endon("horde_cancel_goliath");
	}

	var_00 = 0;
	while(maps\mp\_utility::isjuggernaut())
	{
		if(self usebuttonpressed())
		{
			var_00 = var_00 + 0.05;
			if(var_00 > 1)
			{
				maps\mp\_snd_common_mp::snd_message("goliath_self_destruct");
				playfx(common_scripts\utility::getfx("goliath_self_destruct"),self.origin,anglestoup(self.angles));
				wait(0.05);
				self.hideondeath = 1;
				self.juggernautsuicide = 1;
				radiusdamage(self.origin + (0,0,50),400,200,20,self,"MOD_EXPLOSIVE","killstreak_goliathsd_mp");
				if(isdefined(level.ishorde) && level.ishorde)
				{
					self thread [[ level.hordehandlejuggdeath ]]();
				}
			}

			continue;
		}

		var_00 = 0;
		wait(0.05);
	}
}

//Function Number: 137
playermechtimeout()
{
	level endon("game_ended");
	self endon("disconnect");
	self endon("lost_juggernaut");
	if(isdefined(level.ishorde) && level.ishorde)
	{
		self endon("horde_cancel_goliath");
	}

	for(;;)
	{
		wait(1);
		self.mechhealth = self.mechhealth - int(self.maxhealth / 100);
		if(self.mechhealth < 0)
		{
			maps\mp\_snd_common_mp::snd_message("goliath_self_destruct");
			playfx(common_scripts\utility::getfx("goliath_self_destruct"),self.origin,anglestoup(self.angles));
			self thread [[ level.hordehandlejuggdeath ]]();
		}

		self setclientomnvar("ui_exo_suit_health",self.mechhealth / self.maxhealth);
	}
}

//Function Number: 138
onplayerconnect()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_00 thread onplayerspawned();
	}
}

//Function Number: 139
onplayerspawned()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("spawned_player");
		self.hideondeath = 0;
	}
}

//Function Number: 140
deletegoliathpod(param_00,param_01)
{
	if(!isdefined(param_00))
	{
		param_00 = 1;
	}

	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	if(isdefined(self.curobjid))
	{
		maps\mp\_utility::_objective_delete(self.curobjid);
	}

	if(isdefined(self.droptype))
	{
		if(param_00)
		{
			playfx(common_scripts\utility::getfx("ocp_death"),self.origin);
		}

		if(param_01)
		{
			playsoundatpos(self.origin,"orbital_pkg_self_destruct");
		}
	}

	self delete();
}

//Function Number: 141
handle_goliath_drop_pod_timeout(param_00)
{
	level endon("game_ended");
	self endon("death");
	wait(120);
	if(isdefined(level.ishorde) && level.ishorde && param_00)
	{
		self.owner.hordeclassgoliathpodinfield = undefined;
		self.owner.hordegoliathpodinfield = undefined;
		self.owner notify("startJuggCooldown");
	}

	deletegoliathpod();
}

//Function Number: 142
delete_goliath_drop_pod_for_event(param_00)
{
	level endon("game_ended");
	self endon("death");
	common_scripts\utility::waittill_any_ents(level,"zombies_start",level,"EMP_JamTeamallies",param_00,"disconnect");
	deletegoliathpod();
}

//Function Number: 143
handle_goliath_drop_pod_removal(param_00)
{
	level endon("game_ended");
	self endon("death");
	param_00 waittill("death");
	self delete();
}

//Function Number: 144
playermech_watch_emp_grenade()
{
	level endon("game_ended");
	self endon("death");
	self endon("disconnect");
	if(isdefined(level.ishorde) && level.ishorde)
	{
		self endon("becameSpectator");
	}

	for(;;)
	{
		self waittill("emp_grenaded",var_00);
		if(isdefined(var_00) && isplayer(var_00))
		{
			var_00 thread ch_emp_goliath_think();
		}
	}
}

//Function Number: 145
ch_emp_goliath_think()
{
	level endon("game_ended");
	self endon("death");
	self endon("disconnect");
	if(isdefined(level.ishorde) && level.ishorde)
	{
		self endon("becameSpectator");
	}

	var_00 = 5;
	wait(var_00);
	if(maps\mp\_utility::isreallyalive(self))
	{
		maps\mp\gametypes\_missions::processchallenge("ch_precision_closecall");
	}
}