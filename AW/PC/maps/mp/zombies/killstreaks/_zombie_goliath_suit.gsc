/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\zombies\killstreaks\_zombie_goliath_suit.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 132
 * Decompile Time: 2000 ms
 * Timestamp: 4/22/2024 2:13:09 AM
*******************************************************************/

//Function Number: 1
init()
{
	level._effect["green_light_mp"] = loadfx("vfx/lights/aircraft_light_wingtip_green");
	level._effect["juggernaut_sparks"] = loadfx("vfx/explosion/bouncing_betty_explosion");
	level._effect["jugg_droppod_open"] = loadfx("vfx/explosion/goliath_pod_opening");
	level._effect["jugg_droppod_marker"] = loadfx("vfx/unique/vfx_marker_killstreak_guide_goliath");
	level._effect["goliath_death_fire"] = loadfx("vfx/fire/goliath_death_fire");
	level._effect["goliath_self_destruct"] = loadfx("vfx/explosion/goliath_self_destruct");
	level._effect["lethal_rocket_wv"] = loadfx("vfx/muzzleflash/playermech_lethal_flash_wv");
	level._effect["swarm_rocket_wv"] = loadfx("vfx/muzzleflash/playermech_tactical_wv_run");
	level.goliathsuitweapons = ["iw5_exominigunzm_mp","playermech_rocket_zm_mp","playermech_rocket_swarm_zm_mp","iw5_juggernautrocketszm_mp","iw5_combatknifegoliath_mp"];
	level.killstreakwieldweapons["iw5_exominigunzm_mp"] = "juggernaut_exosuit";
	level.killstreakwieldweapons["playermech_rocket_zm_mp"] = "juggernaut_exosuit";
	level.killstreakwieldweapons["playermech_rocket_swarm_zm_mp"] = "juggernaut_exosuit";
	level.killstreakwieldweapons["iw5_juggernautrocketszm_mp"] = "juggernaut_exosuit";
	level.killstreakwieldweapons["iw5_combatknifegoliath_mp"] = "juggernaut_exosuit";
	level.killstreakwieldweapons["orbital_carepackage_droppod_zm_mp"] = "juggernaut_exosuit";
	level.killstreakfuncs["zm_goliath_suit"] = ::tryuseheavyexosuit;
	level.customjuggernautdamagefunc = ::juggernautmodifydamage;
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
	level thread roundlogic();
}

//Function Number: 2
roundlogic()
{
	var_00 = randomintrange(8,10);
	for(;;)
	{
		level waittill("zombie_wave_started");
		if(maps\mp\zombies\_util::is_true(level.disablecarepackagedrops))
		{
			continue;
		}

		while(level.wavecounter >= var_00)
		{
			var_01 = randomfloatrange(35,45);
			var_02 = level common_scripts\utility::waittill_notify_or_timeout_return("zombie_wave_ended",var_01);
			if(!isdefined(var_02) || var_02 != "timeout")
			{
				continue;
			}

			if(maps\mp\zombies\_util::is_true(level.disablecarepackagedrops))
			{
				continue;
			}

			var_02 = tryuseheavyexosuit();
			if(isdefined(var_02))
			{
				var_00 = var_00 + randomintrange(5,7);
			}
		}

		level waittill("zombie_wave_ended");
	}
}

//Function Number: 3
getowner()
{
	foreach(var_01 in level.players)
	{
		if(isdefined(var_01))
		{
			return var_01;
		}
	}
}

//Function Number: 4
tryuseheavyexosuit(param_00,param_01)
{
	var_02 = self;
	if(!isdefined(self) || !isplayer(self))
	{
		var_02 = getowner();
		if(!isdefined(var_02))
		{
			return 0;
		}
	}

	var_03 = maps\mp\zombies\killstreaks\_zombie_killstreaks::getcratelandingspot(var_02,"goliath_suit");
	if(!isdefined(var_03))
	{
		return 0;
	}

	level thread firedroppod(var_03,[],var_02);
	return 1;
}

//Function Number: 5
givejuggernaut(param_00,param_01)
{
	self endon("death");
	self endon("disconnect");
	self.attackerlist = [];
	var_02 = 1;
	self.juggmovespeedscaler = var_02;
	var_03 = isdefined(self.perks["specialty_hardline"]);
	self.isjuggernaut = 1;
	self.movespeedscaler = var_02;
	maps\mp\_utility::giveperk("specialty_radarjuggernaut",0);
	if(var_03)
	{
		maps\mp\_utility::giveperk("specialty_hardline",0);
	}

	thread playersetupjuggernautexo(param_01,param_00);
	self.saved_lastweapon = self getweaponslistprimaries()[0];
	maps\mp\gametypes\_weapons::updatemovespeedscale();
	self playsoundonmovingent("goliath_suit_up_mp");
	level thread announcerglobalplaysuitvo("gol_start",5,self);
	level notify("juggernaut_equipped",self);
	maps\mp\_matchdata::logkillstreakevent("juggernaut",self.origin);
}

//Function Number: 6
cggoliathroverlay()
{
	self endon("death");
	self endon("disconnect");
	self endon("death");
	self endon("ejectedFromJuggernaut");
	var_00 = 0.35;
	var_01 = newclienthudelem(self);
	thread cggoliathoverlaycleanup(var_01);
	var_01.x = 0;
	var_01.y = 0;
	var_01 setshader("black",640,480);
	var_01.horzalign = "fullscreen";
	var_01.vertalign = "fullscreen";
	var_01.alpha = 0;
	var_01 fadeovertime(var_00);
	var_01.alpha = 1;
	wait(2);
	var_01 fadeovertime(var_00);
	var_01.alpha = 0;
}

//Function Number: 7
cggoliathoverlaycleanup(param_00)
{
	param_00 endon("death");
	common_scripts\utility::waittill_any("spawned","disconnect","ejectedFromJuggernaut","death");
	param_00 destroy();
}

//Function Number: 8
removeweapons()
{
	maps\mp\zombies\_zombies_laststand::savelaststandweapons("",0);
	self.primarytorestore = common_scripts\utility::getlastweapon();
	var_00 = self getweaponslistall();
	foreach(var_02 in var_00)
	{
		var_03 = maps\mp\_utility::getweaponnametokens(var_02);
		if(var_03[0] == "alt")
		{
			self.restoreweaponclipammo[var_02] = self getweaponammoclip(var_02);
			self.restoreweaponstockammo[var_02] = self setweaponammostock(var_02);
			continue;
		}

		self.restoreweaponclipammo[var_02] = self getweaponammoclip(var_02);
		self.restoreweaponstockammo[var_02] = self setweaponammostock(var_02);
	}

	self.weaponstorestore = [];
	foreach(var_02 in var_00)
	{
		var_03 = maps\mp\_utility::getweaponnametokens(var_02);
		if(var_03[0] == "alt")
		{
			continue;
		}

		if(maps\mp\_utility::iskillstreakweapon(var_02))
		{
			continue;
		}

		self.weaponstorestore[self.weaponstorestore.size] = var_02;
		self takeweapon(var_02);
	}
}

//Function Number: 9
restoreweapons()
{
	var_00 = self getweaponslistall();
	foreach(var_02 in var_00)
	{
		if(maps\mp\_utility::iskillstreakweapon(var_02) && !iskillstreakgoliathweapon(var_02))
		{
			continue;
		}

		self takeweapon(var_02);
	}

	if(!isdefined(self.restoreweaponclipammo) || !isdefined(self.restoreweaponstockammo) || !isdefined(self.weaponstorestore))
	{
		return;
	}

	self setlethalweapon("none");
	self settacticalweapon("none");
	var_04 = [];
	foreach(var_02 in self.weaponstorestore)
	{
		var_06 = maps\mp\_utility::getweaponnametokens(var_02);
		if(var_06[0] == "alt")
		{
			var_04[var_04.size] = var_02;
			continue;
		}

		if(maps\mp\zombies\_util::iszombielethal(var_02))
		{
			self setlethalweapon(var_02);
		}
		else if(maps\mp\zombies\_util::iszombietactical(var_02))
		{
			self settacticalweapon(var_02);
		}

		maps\mp\_utility::_giveweapon(var_02);
		if(isdefined(self.restoreweaponclipammo[var_02]))
		{
			self setweaponammoclip(var_02,self.restoreweaponclipammo[var_02]);
		}

		if(isdefined(self.restoreweaponstockammo[var_02]))
		{
			self setweaponammostock(var_02,self.restoreweaponstockammo[var_02]);
		}
	}

	foreach(var_09 in var_04)
	{
		if(isdefined(self.restoreweaponclipammo[var_09]))
		{
			self setweaponammoclip(var_09,self.restoreweaponclipammo[var_09]);
		}

		if(isdefined(self.restoreweaponstockammo[var_09]))
		{
			self setweaponammostock(var_09,self.restoreweaponstockammo[var_09]);
		}
	}

	self.restoreweaponclipammo = undefined;
	self.restoreweaponstockammo = undefined;
}

//Function Number: 10
iskillstreakgoliathweapon(param_00)
{
	return common_scripts\utility::array_contains(level.goliathsuitweapons,param_00);
}

//Function Number: 11
playersetupjuggernautexo(param_00,param_01)
{
	var_02 = spawnstruct();
	self.heavyexodata = var_02;
	var_02.streakplayer = self;
	var_02.hascoopsentry = 0;
	var_02.modules = param_00;
	var_02.juggtype = param_01;
	var_02.hasradar = 0;
	var_02.hasmaniac = 0;
	var_02.haslongpunch = 1;
	var_02.hastrophy = 0;
	var_02.hasrockets = 1;
	var_02.hasextraammo = 0;
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
	maps\mp\_utility::playerallowdodge(0,"heavyexo");
	maps\mp\_utility::playerallowboostjump(0,"heavyexo");
	maps\mp\_utility::playerallowhighjump(0,"heavyexo");
	maps\mp\_utility::playerallowhighjumpdrop(0,"heavyexo");
	self allowjump(0);
	self allowcrouch(0);
	self allowladder(0);
	self allowmantle(0);
	self.inliveplayerkillstreak = 1;
	self.mechhealth = 600;
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
	thread playermechtimeout();
	if(var_02.hascoopsentry)
	{
		var_04 = setupcoopturret(var_02,self);
		if(level.teambased)
		{
			level thread handlecoopjoining(var_02,self);
		}
	}

	if(!var_02.hasmaniac)
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

	if(var_02.hasrockets)
	{
		level thread setuprocketswarm(self,var_02);
		set_mech_swarm_state("ready");
		thread playermech_monitor_swarm_recharge();
	}

	level thread setupeject(var_02,self);
	level thread delaysetweapon(self);
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

	if(isdefined(param_01) && isdefined(param_00) && param_01 == param_00 && isdefined(param_04) && param_04 == "iw5_juggernautrocketszm_mp" || param_04 == "playermech_rocket_zm_mp")
	{
		var_09 = 0;
	}

	if(isdefined(param_00.goliathbootupsequence) && param_00.goliathbootupsequence)
	{
		var_09 = 0;
	}

	if(isdefined(param_01) && !maps\mp\gametypes\_weapons::friendlyfirecheck(param_00,param_01))
	{
		var_09 = 0;
	}

	if(isdefined(param_01) && isdefined(param_01.agent_type) && param_01.agent_type == "zombie_boss_oz_stage2" && param_03 == "MOD_IMPACT")
	{
		var_09 = var_09 * 2;
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

		var_0A = param_00.mechhealth / 600;
		param_00.mechhealth = param_00.mechhealth - var_09;
		var_0B = param_00.mechhealth / 600;
		param_00 setclientomnvar("ui_exo_suit_health",var_0B);
		level thread dogoliathintegrityvo(var_0A,var_0B,self);
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
			if(!isdefined(param_00.underwatermotiontype))
			{
				param_00 thread playereject();
			}
			else
			{
				param_00 thread playerkillheavyexo(param_05,param_01,param_03,param_04,param_08);
			}
		}
	}

	return 0;
}

//Function Number: 14
dogoliathintegrityvo(param_00,param_01,param_02)
{
	if(param_00 > 0.75 && param_01 <= 0.75)
	{
		level thread announcerglobalplaysuitvo("gol_armor1",undefined,param_02);
		return;
	}

	if(param_00 > 0.5 && param_01 <= 0.5)
	{
		level thread announcerglobalplaysuitvo("gol_armor2",undefined,param_02);
		return;
	}

	if(param_00 > 0.25 && param_01 <= 0.25)
	{
		level thread announcerglobalplaysuitvo("gol_armor3",undefined,param_02);
		return;
	}

	if(param_00 > 0.08 && param_01 <= 0.08)
	{
		level thread announcerglobalplaysuitvo("gol_armor4",undefined,param_02);
		return;
	}
}

//Function Number: 15
playerkillheavyexo(param_00,param_01,param_02,param_03,param_04)
{
	if(maps\mp\_utility::isjuggernaut())
	{
		playerreset();
	}

	var_05 = "ui_zm_character_" + self.characterindex + "_alive";
	setomnvar(var_05,0);
	maps\mp\_utility::_suicide();
	if(level.players.size < 2)
	{
		maps\mp\zombies\_zombies_laststand::zombieendgame(undefined,"MOD_SUICIDE");
	}

	level notify("player_left_goliath_suit");
}

//Function Number: 16
delaysetweapon(param_00)
{
	param_00 endon("death");
	param_00 endon("disconnect");
	param_00 giveweapon("iw5_exominigunzm_mp");
	param_00 switchtoweapon("iw5_exominigunzm_mp");
	wait 0.05;
	param_00 setplayermech(1);
	param_00 common_scripts\utility::_disableweaponswitch();
	if(param_00 hasweapon("iw5_combatknifegoliath_mp"))
	{
		param_00 takeweapon("iw5_combatknifegoliath_mp");
	}
}

//Function Number: 17
playercleanupondeath(param_00)
{
	self endon("disconnect");
	self endon("ejectedFromJuggernaut");
	self waittill("death",var_01,var_02,var_03);
	if(maps\mp\_utility::isjuggernaut())
	{
		thread playerreset();
	}
}

//Function Number: 18
playercleanuponother()
{
	self endon("death");
	self endon("disconnect");
	self endon("ejectedFromJuggernaut");
	level common_scripts\utility::waittill_any("game_ended");
	playerresetomnvars();
}

//Function Number: 19
playerreset()
{
	self notify("lost_juggernaut");
	self notify("exit_mech");
	self.heavyexodata = undefined;
	self.isjuggernaut = 0;
	self unsetperk("specialty_radarjuggernaut",1);
	self.movespeedscaler = 1;
	maps\mp\gametypes\_weapons::updatemovespeedscale();
	maps\mp\_utility::playerallowpowerslide(1,"heavyexo");
	maps\mp\_utility::playerallowdodge(1,"heavyexo");
	maps\mp\_utility::playerallowboostjump(1,"heavyexo");
	maps\mp\_utility::playerallowhighjump(1,"heavyexo");
	maps\mp\_utility::playerallowhighjumpdrop(1,"heavyexo");
	self allowjump(1);
	self allowcrouch(1);
	self allowladder(1);
	self allowmantle(1);
	self.inliveplayerkillstreak = undefined;
	self.mechhealth = undefined;
	self setdemigod(0);
	playerresetomnvars();
	self setplayermech(0);
	common_scripts\utility::_enableweaponswitch();
	self enableoffhandweapons();
	self enableoffhandsecondaryweapons();
	self.restoreweaponclipammo = undefined;
	self.restoreweaponstockammo = undefined;
	if(isdefined(self.juggernautattachments))
	{
		self.juggernautattachments = undefined;
	}
}

//Function Number: 20
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

//Function Number: 21
playersetjuggexomodel(param_00)
{
	self detachall();
	self setmodel("npc_exo_armor_mp_base");
	self attach(self.characterhead);
	self setviewmodel("vm_view_arms_mech_mp");
	self attach("npc_exo_armor_minigun_handle","TAG_HANDLE");
}

//Function Number: 22
playerhandlebarrel()
{
	self endon("death");
	self endon("disconnect");
	self endon("ejectedFromJuggernaut");
	thread playercleanupbarrel();
	self notifyonplayercommand("goliathAttack","+attack");
	self notifyonplayercommand("goliathAttackDone","-attack");
	self.barrellinker = spawn("script_model",self gettagorigin("tag_barrel"));
	self.barrellinker setmodel("generic_prop_raven");
	self.barrellinker vehicle_jetbikesethoverforcescale(self,"tag_barrel",(12.7,0,-2.9),(90,0,0));
	self.barrel = spawn("script_model",self.barrellinker gettagorigin("j_prop_1"));
	self.barrel setmodel("npc_exo_armor_minigun_barrel");
	self.barrel vehicle_jetbikesethoverforcescale(self.barrellinker,"j_prop_1",(0,0,0),(-90,0,0));
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

//Function Number: 23
playercleanupbarrel()
{
	common_scripts\utility::waittill_any("death","disconnect","ejectedFromJuggernaut");
	if(isdefined(self))
	{
		if(isdefined(self.barrel))
		{
			self.barrel delete();
		}

		if(isdefined(self.barrellinker))
		{
			self.barrellinker delete();
		}
	}
}

//Function Number: 24
playerrocketsandswarmwatcher()
{
	self endon("death");
	self endon("disconnect");
	self endon("ejectedFromJuggernaut");
	for(;;)
	{
		self waittill("grenade_pullback",var_00);
		if(var_00 == "playermech_rocket_zm_mp")
		{
			self notify("mech_rocket_pullback");
			self waittill("grenade_fire",var_01,var_00);
			self notify("mech_rocket_fire",var_01);
		}
		else if(var_00 == "playermech_rocket_swarm_zm_mp")
		{
			self notify("mech_swarm_pullback");
			self waittill("grenade_fire",var_01,var_00);
			self notify("mech_swarm_fire",var_01.origin);
			var_01 delete();
		}

		wait 0.05;
	}
}

//Function Number: 25
setupcoopturret(param_00,param_01)
{
	var_02 = param_01 gettagorigin("tag_turret");
	var_03 = spawnattachment("juggernaut_sentry_mg_zm_mp","npc_heavy_exo_armor_turret_base",var_02,200,param_01,&"KILLSTREAKS_HEAVY_EXO_SENTRY_LOST");
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

//Function Number: 26
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

//Function Number: 27
handlecoopshooting(param_00,param_01,param_02)
{
	param_01 endon("death");
	var_03 = weaponfiretime("juggernaut_sentry_mg_zm_mp");
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

//Function Number: 28
turretshoot()
{
	self shootturret();
	turretshootblank(self.baseowner);
}

//Function Number: 29
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

	shootblank(var_01,var_03,"juggernaut_sentry_mg_zm_mp",var_04,param_00);
}

//Function Number: 30
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

//Function Number: 31
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

//Function Number: 32
setuplongpunch(param_00,param_01)
{
	param_00 setlethalweapon("playermech_rocket_zm_mp");
	param_00 giveweapon("playermech_rocket_zm_mp");
	var_02 = "tag_origin";
	param_00 thread playerwatchnoobtubeuse(param_01);
	waittillattachmentdone(param_00);
}

//Function Number: 33
playerwatchnoobtubeuse(param_00)
{
	self endon("death");
	self endon("disconnect");
	self endon("ejectedFromJuggernaut");
	for(;;)
	{
		self waittill("mech_rocket_fire",var_01);
		playfxontag(common_scripts\utility::getfx("lethal_rocket_wv"),self,"TAG_WEAPON_RIGHT");
		thread reloadrocket(self,param_00);
	}
}

//Function Number: 34
reloadrocket(param_00,param_01)
{
	param_00 endon("death");
	param_00 endon("disconnect");
	self endon("ejectedFromJuggernaut");
	waitattachmentcooldown(param_00 playergetrocketreloadtime(),"ui_exo_suit_punch_cd");
}

//Function Number: 35
playergetrocketreloadtime()
{
	if(maps\mp\_utility::gameflag("unlimited_ammo"))
	{
		return 0.1;
	}

	if(maps\mp\_utility::_hasperk("specialty_fastreload"))
	{
		return 5;
	}

	return 10;
}

//Function Number: 36
waitattachmentcooldown(param_00,param_01)
{
	self endon("disconnect");
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

//Function Number: 37
setuprocketswarm(param_00,param_01)
{
	var_02 = "playermech_rocket_swarm_zm_mp";
	param_00 settacticalweapon(var_02);
	param_00 giveweapon(var_02);
	var_03 = "tag_origin";
	var_04 = param_00 gettagorigin(var_03);
	var_05 = spawnattachment("rocketAttachment","npc_heavy_exo_armor_missile_pack_base",var_04,undefined,param_00);
	var_05.lockedtarget = 0;
	var_05.reloading = 0;
	var_05.enemytargets = [];
	var_05.rockets = [];
	var_05.icons = [];
	var_05 linkto(param_00,var_03,(0,0,0),(0,0,0));
	var_05 hide();
	param_00.rocketattachment = var_05;
	thread scanforrocketenemies(var_05,param_00);
	param_00 thread playerwatchrocketuse(var_05,param_01);
	waittillattachmentdone(param_00,var_05);
	wait 0.05;
	if(isdefined(var_05))
	{
		var_05 delete();
	}

	param_00.rocketattachment = undefined;
}

//Function Number: 38
scanforrocketenemies(param_00,param_01)
{
	param_01 endon("death");
	param_01 endon("disconnect");
	param_01 endon("ejectedFromJuggernaut");
	for(;;)
	{
		wait 0.05;
		if(param_00.reloading || param_00.rockets.size > 0 || param_00.lockedtarget)
		{
			continue;
		}

		param_00.enemytargets = getbestenemies(param_01,5);
	}
}

//Function Number: 39
playerisrocketswarmreloading()
{
	return isdefined(self.rocketattachment) && isdefined(self.rocketattachment.reloading) && self.rocketattachment.reloading;
}

//Function Number: 40
playerisrocketswarmtargetlocked()
{
	return isdefined(self.rocketattachment) && isdefined(self.rocketattachment.enemytargets) && self.rocketattachment.enemytargets.size > 0;
}

//Function Number: 41
getbestenemies(param_00,param_01)
{
	var_02 = 0.8433914;
	var_03 = anglestoforward(param_00 getplayerangles());
	var_04 = param_00 geteye();
	var_05 = undefined;
	var_06 = [];
	var_07 = maps\mp\agents\_agent_utility::getactiveagentsoftype("all");
	if(isdefined(level.bossozstage1) && isdefined(level.bossozstage1.damagecallback))
	{
		var_07[var_07.size] = level.bossozstage1;
	}

	foreach(var_09 in var_07)
	{
		if(issentient(var_09) && isalliedsentient(var_09,param_00))
		{
			continue;
		}

		if(!maps\mp\_utility::isreallyalive(var_09))
		{
			continue;
		}

		if(issentient(var_09))
		{
			var_0A = var_09 geteye();
		}
		else
		{
			var_0A = var_09.origin + (0,0,55);
		}

		var_0B = vectornormalize(var_0A - var_04);
		var_0C = vectordot(var_03,var_0B);
		if(var_0C > var_02)
		{
			var_06[var_06.size] = var_09;
			var_09.dot = var_0C;
			var_09.checked = 0;
		}
	}

	if(var_06.size == 0)
	{
		return [];
	}

	var_0E = [];
	for(var_0F = 0;var_0F < param_01 && var_0F < var_06.size;var_0F++)
	{
		var_10 = gethighestdot(var_06);
		if(!isdefined(var_10))
		{
			return;
		}

		var_10.checked = 1;
		var_11 = var_04;
		if(issentient(var_10))
		{
			var_12 = var_10 geteye();
		}
		else
		{
			var_12 = var_10.origin + (0,0,55);
		}

		var_13 = sighttracepassed(var_11,var_12,1,param_00,var_10);
		if(var_13)
		{
			var_0E[var_0E.size] = var_10;
		}
	}

	foreach(var_09 in var_07)
	{
		var_09.dot = undefined;
		var_09.checked = undefined;
	}

	return var_0E;
}

//Function Number: 42
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

//Function Number: 43
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

//Function Number: 44
handlelockedtarget(param_00,param_01)
{
	param_00 endon("death");
	param_00.lockedtarget = 1;
	param_00 notify("lockedTarget");
	waittillrocketsexploded(param_00);
	if(isdefined(param_00))
	{
		param_00.lockedtarget = 0;
		param_00.enemytargets = [];
	}
}

//Function Number: 45
firerocketswarm(param_00,param_01,param_02)
{
	var_03 = anglestoforward(param_01 getplayerangles());
	var_04 = anglestoright(param_01 getplayerangles());
	var_05 = [(0,0,50),(0,0,20),(10,0,0),(0,10,0)];
	playfxontag(common_scripts\utility::getfx("swarm_rocket_wv"),param_01,"TAG_ROCKET4");
	var_06 = 0;
	var_07 = undefined;
	for(var_08 = 0;var_08 < 4;var_08++)
	{
		var_09 = param_02 + var_03 * 20 + var_04 * -30;
		var_0A = var_03 + random_vector(0.2);
		var_0B = magicbullet("iw5_juggernautrocketszm_mp",var_09,var_09 + var_0A,param_01);
		param_00.rockets = common_scripts\utility::array_add(param_00.rockets,var_0B);
		if(var_06 < param_00.enemytargets.size)
		{
			var_07 = param_00.enemytargets[var_06];
			var_06++;
		}

		var_0B thread rockettargetent(param_00,var_07,var_05[var_08]);
		var_0B thread rocketdestroyaftertime(7);
	}
}

//Function Number: 46
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

//Function Number: 47
rocketdestroyaftertime(param_00)
{
	self endon("death");
	wait(param_00);
	self delete();
}

//Function Number: 48
reloadrocketswarm(param_00,param_01,param_02)
{
	param_00 endon("death");
	param_00.reloading = 1;
	waitattachmentcooldown(param_01 playergetswarmreloadtime(),"ui_exo_suit_rockets_cd");
	param_00.reloading = 0;
}

//Function Number: 49
playergetswarmreloadtime()
{
	if(maps\mp\_utility::gameflag("unlimited_ammo"))
	{
		return 0.1;
	}

	if(maps\mp\_utility::_hasperk("specialty_fastreload"))
	{
		return 5;
	}

	return 10;
}

//Function Number: 50
waittillrocketsexploded(param_00)
{
	wait(0.1);
	while(isdefined(param_00) && param_00.rockets.size > 0)
	{
		wait 0.05;
	}
}

//Function Number: 51
waittillattachmentdone(param_00,param_01,param_02)
{
	param_00 endon("disconnect");
	param_00 endon("death");
	param_00 endon("ejectedFromJuggernaut");
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

//Function Number: 52
delayplayfx(param_00,param_01)
{
	param_00 endon("death");
	wait 0.05;
	wait 0.05;
	playfxontag(param_01,param_00,"tag_origin");
}

//Function Number: 53
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

//Function Number: 54
attachmentdeath(param_00,param_01,param_02,param_03)
{
	param_02 endon("death");
	param_02 endon("disconnect");
	param_02 endon("ejectedFromJuggernaut");
	if(isdefined(param_03))
	{
		param_03 endon("death");
	}

	param_01 waittill("death",var_04,var_05,var_06);
}

//Function Number: 55
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

//Function Number: 56
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

//Function Number: 57
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

//Function Number: 58
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

//Function Number: 59
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

//Function Number: 60
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

//Function Number: 61
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
					self.largeprojectiledamage = 1;
					var_0C = self.maxhealth + 1;
					break;

				case "stealth_bomb_mp":
				case "artillery_mp":
					self.largeprojectiledamage = 0;
					var_0C = var_0C + param_02 * 4;
					break;

				case "emp_grenade_killstreak_mp":
				case "emp_grenade_var_mp":
				case "emp_grenade_mp":
				case "bomb_site_mp":
					self.largeprojectiledamage = 0;
					var_0C = self.maxhealth + 1;
					break;
			}

			maps\mp\killstreaks\_killstreaks::killstreakhit(param_01,param_05,self);
		}
	}

	self.lasttimedamaged = gettime();
	self finishentitydamage(param_00,param_01,var_0C,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B);
}

//Function Number: 62
random_vector(param_00)
{
	return (randomfloat(param_00) - param_00 * 0.5,randomfloat(param_00) - param_00 * 0.5,randomfloat(param_00) - param_00 * 0.5);
}

//Function Number: 63
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

//Function Number: 64
waittillpromptcomplete(param_00,param_01,param_02,param_03)
{
	param_00 endon("death");
	param_00 endon("disconnect");
	param_00 endon("ejectedFromJuggernaut");
	param_00 endon("turretDead");
	return param_00 common_scripts\utility::waittill_any_return_no_endon_death(param_01,param_02,param_03);
}

//Function Number: 65
waittillturretstuncomplete(param_00,param_01)
{
	param_01 endon("death");
	param_01 endon("disconnect");
	param_01 endon("turretDead");
	param_01 endon("ejectedFromJuggernaut");
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

//Function Number: 66
watchforjoin(param_00,param_01,param_02)
{
	param_01 endon("disconnect");
	param_01 endon("death");
	param_01 endon("ejectedFromJuggernaut");
	var_03 = maps\mp\killstreaks\_coop_util::waittillbuddyjoinedstreak(param_00);
	param_01 notify("buddyJoinedStreak");
	var_03 thread playerremotecoopturret(param_02);
}

//Function Number: 67
playerremotecoopturret(param_00)
{
	self endon("disconnect");
	param_00.coopturret endon("death");
	param_00.streakplayer endon("death");
	param_00.streakplayer endon("disconnect");
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

//Function Number: 68
removecoopturretbuddyondisconnect(param_00)
{
	param_00.coopturret endon("removeCoopTurretBuddy");
	self waittill("disconnect");
	thread removecoopturretbuddy(param_00);
}

//Function Number: 69
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

//Function Number: 70
playershowjuggernauthud(param_00)
{
	self setclientomnvar("ui_exo_suit_enabled",1);
	thread playermech_state_manager();
}

//Function Number: 71
playerplayattachmentdialog(param_00)
{
	var_01 = undefined;
	switch(param_00)
	{
		case "juggernaut_sentry_mp_mp":
			var_01 = "sntryoff_mp_exoai";
			break;

		case "speedAttachment":
			var_01 = "mancoff_mp_exoai";
			break;

		case "punchAttachment":
			var_01 = "longoff_mp_exoai";
			break;

		case "radar":
			var_01 = "rcnoff_mp_exoai";
			break;

		case "rocketAttachment":
			var_01 = "rcktoff_mp_exoai";
			break;

		case "trophy":
			var_01 = "trphyoff_mp_exoai";
			break;

		default:
			var_01 = "weakdmg_mp_exoai";
			break;
	}

	maps\mp\_utility::leaderdialogonplayer(var_01);
}

//Function Number: 72
droppodmovenearbyallies(param_00)
{
	if(!isdefined(self))
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

		if(var_02.team == param_00)
		{
			if(distancesquared(self.origin,var_02.origin) < 6000)
			{
				maps\mp\_movers::unresolved_collision_nearest_node(var_02,1);
			}
		}
	}
}

//Function Number: 73
givebackgoliathstreak(param_00)
{
	var_01 = maps\mp\killstreaks\_killstreaks::getstreakcost("heavy_exosuit");
	var_02 = maps\mp\killstreaks\_killstreaks::getnextkillstreakslotindex("heavy_exosuit",0);
	thread maps\mp\gametypes\_hud_message::killstreaksplashnotify("heavy_exosuit",var_01,undefined,param_00,var_02);
	thread maps\mp\killstreaks\_killstreaks::givekillstreak("heavy_exosuit",0,0,self,param_00);
}

//Function Number: 74
firedroppod(param_00,param_01,param_02)
{
	var_03 = param_02 maps\mp\killstreaks\_orbital_util::playergetorbitalstartpos(param_00);
	var_04 = param_00.origin;
	if(!isdefined(param_02))
	{
		param_02 = getowner();
	}

	var_05 = param_02.team;
	var_06 = magicbullet("orbital_carepackage_droppod_zm_mp",var_03,var_04,param_02,0,1);
	var_06.team = var_05;
	var_07 = spawn("script_model",var_04 + (0,0,5));
	var_07.angles = (-90,0,0);
	var_07 setmodel("tag_origin");
	playfxontag(common_scripts\utility::getfx("jugg_droppod_marker"),var_07,"tag_origin");
	maps\mp\killstreaks\_orbital_util::adddropmarker(var_07,"goliath_suit");
	if(!maps\mp\zombies\_util::is_true(level.zmkillstreakgoliathprevo))
	{
		var_08 = maps\mp\zombies\killstreaks\_zombie_killstreaks::getcloseplayertodroppoint(var_07.origin);
		var_08 thread maps\mp\zombies\_zombies_audio::playerkillstreakcratevo("gol_drop_pre");
		level.zmkillstreakgoliathprevo = 1;
	}

	var_06 waittill("death");
	if(distancesquared(var_06.origin,var_04) > 22500)
	{
		var_07 delete();
		return;
	}

	var_04 = getgroundposition(var_06.origin + (0,0,8),20);
	if(!maps\mp\zombies\_util::is_true(level.zmkillstreakgoliathreactvo))
	{
		var_08 = maps\mp\zombies\killstreaks\_zombie_killstreaks::getcloseplayertodroppoint(var_04);
		var_08 thread maps\mp\zombies\_zombies_audio::playerkillstreakcratevo("gol_react");
		level.zmkillstreakgoliathreactvo = 1;
	}

	thread destroy_nearby_turrets(var_04);
	var_07 hide();
	earthquake(0.4,1,var_04,800);
	playrumbleonposition("artillery_rumble",var_04);
	stopfxontag(common_scripts\utility::getfx("jugg_droppod_marker"),var_07,"tag_origin");
	var_09 = spawn("script_model",var_04);
	var_09.angles = (0,0,0);
	var_09 createcollision(var_04);
	var_09.targetname = "care_package";
	var_09.droppingtoground = 0;
	var_0A = spawn("script_model",var_04);
	var_0A.angles = (90,0,0);
	var_0A.targetname = "goliath_pod_model";
	var_0A setmodel("vehicle_drop_pod");
	var_0A thread handle_goliath_drop_pod_removal(var_09);
	var_0A maps\mp\_entityheadicons::setheadicon(var_05,maps\mp\killstreaks\_killstreaks::getkillstreakcrateicon("zm_goliath_suit",[]),(0,0,140),14,14,undefined,undefined,undefined,undefined,undefined,0);
	var_09.owner = undefined;
	var_09.cratetype = "juggernaut";
	var_09.droptype = "juggernaut";
	var_09 thread control_goliath_usability();
	var_09 sethintstring(&"KILLSTREAKS_HEAVY_EXO_PICKUP");
	var_09 thread cratecapturethink();
	var_09 thread usegoliathupdater();
	var_0B = spawnstruct();
	var_0B.useent = var_09;
	var_0B.playdeathfx = 1;
	var_0B.deathoverridecallback = ::movingplatformdeathfunc;
	var_0B.touchingplatformvalid = ::movingplatformtouchvalid;
	var_09 thread maps\mp\_movers::handle_moving_platforms(var_0B);
	var_09 droppodmovenearbyallies(var_05);
	var_09 disconnectpaths();
	var_0C = var_09 playerwaittillgoliathactivated();
	if(isdefined(var_0C) && isalive(var_0C))
	{
		maps\mp\gametypes\_gamelogic::sethasdonecombat(var_0C,1);
		var_0C.enteringgoliath = 1;
		var_0C playerswitchtosuitupweapon();
		var_0C unlink();
		var_0C maps\mp\_utility::freezecontrolswrapper(1);
		var_0D = var_04 - var_0C.origin;
		var_0E = vectortoangles(var_0D);
		var_0F = (0,var_0E[1],0);
		var_10 = rotatevector(var_0D,(45,0,0));
		var_11 = spawn("script_model",var_04);
		var_11.angles = var_0F;
		if(level.nextgen)
		{
			var_11 setmodel("npc_exo_armor_ingress");
			var_11 scriptmodelplayanimdeltamotion("mp_goliath_spawn");
		}
		else
		{
			var_11 setmodel("npc_exo_armor_mp_base");
		}

		var_0C maps\mp\_snd_common_mp::snd_message("goliath_pod_burst");
		if(isdefined(var_09))
		{
			var_09 deletegoliathpod(0);
		}

		playfx(level._effect["jugg_droppod_open"],var_04,var_10);
		wait(0.1);
		var_0C is_entering_goliath(var_11,var_04);
		if(isdefined(var_0C) && isalive(var_0C))
		{
			var_0C setorigin(var_04,1);
			var_0C setplayerangles(var_11.angles);
			var_0C enableweapons();
			var_0C givejuggernaut("juggernaut_exosuit",param_01);
			var_11 delete();
			var_0C playgoliathtoidleleanim();
			wait(1);
			if(isdefined(var_0C))
			{
				var_0C.enteringgoliath = undefined;
				var_0C maps\mp\_utility::freezecontrolswrapper(0);
			}
		}
		else
		{
			var_11 delete();
		}
	}

	var_07 delete();
}

//Function Number: 75
playerswitchtosuitupweapon()
{
	removeweapons();
	self giveweapon("iw5_combatknifegoliath_mp",0,0,0,1);
	self switchtoweapon("iw5_combatknifegoliath_mp");
}

//Function Number: 76
cratecapturethink(param_00)
{
	self endon("captured");
	var_01 = self;
	if(isdefined(self.otherstringent))
	{
		var_01 = self.otherstringent;
	}

	while(isdefined(self))
	{
		var_01 waittill("trigger",var_02);
		if(maps\mp\zombies\_util::arekillstreaksdisabled())
		{
			continue;
		}

		if(var_02 maps\mp\_utility::isjuggernaut())
		{
			continue;
		}

		if(isdefined(self.owner) && var_02 == self.owner)
		{
			continue;
		}

		if(var_02 isjumping() || isdefined(var_02.exo_hover_on) && var_02.exo_hover_on)
		{
			continue;
		}

		if(!var_02 isonground() && !maps\mp\killstreaks\_airdrop::waitplayerstuckoncarepackagereturn(var_02))
		{
			continue;
		}

		if(!maps\mp\killstreaks\_airdrop::validateopenconditions(var_02))
		{
			continue;
		}

		var_02.iscapturingcrate = 1;
		var_03 = maps\mp\killstreaks\_airdrop::createuseent();
		var_04 = var_03 useholdthink(var_02,undefined,param_00);
		if(isdefined(var_03))
		{
			var_03 delete();
		}

		if(!var_04)
		{
			if(isdefined(var_02))
			{
				var_02.iscapturingcrate = 0;
			}

			continue;
		}

		var_02.iscapturingcrate = 0;
		self notify("captured",var_02);
	}
}

//Function Number: 77
useholdthink(param_00,param_01,param_02)
{
	if(isplayer(param_00))
	{
		param_00 playerlinkto(self);
	}
	else
	{
		param_00 linkto(self);
	}

	param_00 playerlinkedoffsetenable();
	if(!param_00 maps\mp\_utility::isjuggernaut())
	{
		param_00 common_scripts\utility::_disableweapon();
	}

	thread useholdthinkplayerreset(param_00);
	self.curprogress = 0;
	self.inuse = 1;
	self.userate = 0;
	if(isdefined(param_01))
	{
		if(param_00 maps\mp\_utility::_hasperk("specialty_unwrapper") && isdefined(param_00.specialty_unwrapper_care_bonus))
		{
			param_01 = param_01 * param_00.specialty_unwrapper_care_bonus;
		}

		if(isdefined(level.podcapturetimemodifier))
		{
			param_01 = param_01 * level.podcapturetimemodifier;
		}

		self.usetime = param_01;
	}
	else if(param_00 maps\mp\_utility::_hasperk("specialty_unwrapper") && isdefined(param_00.specialty_unwrapper_care_bonus))
	{
		self.usetime = 3000 * param_00.specialty_unwrapper_care_bonus;
	}
	else
	{
		self.usetime = 3000;
	}

	if(isplayer(param_00))
	{
		param_00 thread personalusebar(self,param_02);
	}

	var_03 = useholdthinkloop(param_00);
	if(!isdefined(var_03))
	{
		var_03 = 0;
	}

	if(!isdefined(self))
	{
		return 0;
	}

	self notify("useHoldThinkLoopDone");
	self.inuse = 0;
	self.curprogress = 0;
	return var_03;
}

//Function Number: 78
useholdthinkplayerreset(param_00)
{
	param_00 endon("death");
	common_scripts\utility::waittill_any("death","captured","useHoldThinkLoopDone");
	if(isalive(param_00))
	{
		if(!param_00 maps\mp\_utility::isjuggernaut())
		{
			param_00 common_scripts\utility::_enableweapon();
		}

		if(param_00 islinked())
		{
			param_00 unlink();
		}
	}
}

//Function Number: 79
personalusebar(param_00,param_01)
{
	self endon("disconnect");
	if(isdefined(param_01))
	{
		iprintlnbold("Fixme @agersant " + param_01);
	}

	self setclientomnvar("ui_use_bar_text",1);
	self setclientomnvar("ui_use_bar_start_time",int(gettime()));
	var_02 = -1;
	while(maps\mp\_utility::isreallyalive(self) && isdefined(param_00) && param_00.inuse && !level.gameended)
	{
		if(var_02 != param_00.userate)
		{
			if(param_00.curprogress > param_00.usetime)
			{
				param_00.curprogress = param_00.usetime;
			}

			if(param_00.userate > 0)
			{
				var_03 = gettime();
				var_04 = param_00.curprogress / param_00.usetime;
				var_05 = var_03 + 1 - var_04 * param_00.usetime / param_00.userate;
				self setclientomnvar("ui_use_bar_end_time",int(var_05));
			}

			var_02 = param_00.userate;
		}

		wait(0.05);
	}

	self setclientomnvar("ui_use_bar_end_time",0);
}

//Function Number: 80
ishordelaststand(param_00)
{
	return isdefined(level.ishorde) && level.ishorde && isdefined(param_00.laststand) && param_00.laststand;
}

//Function Number: 81
useholdthinkloop(param_00)
{
	param_00 endon("stop_useHoldThinkLoop");
	while(!level.gameended && isdefined(self) && maps\mp\_utility::isreallyalive(param_00) && !maps\mp\zombies\_util::isplayerinlaststand(param_00) && param_00 usebuttonpressed() && self.curprogress < self.usetime)
	{
		self.curprogress = self.curprogress + 50 * self.userate;
		if(isdefined(self.objectivescaler))
		{
			self.userate = 1 * self.objectivescaler;
		}
		else
		{
			self.userate = 1;
		}

		if(self.curprogress >= self.usetime)
		{
			return maps\mp\_utility::isreallyalive(param_00);
		}

		wait(0.05);
	}

	return 0;
}

//Function Number: 82
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

//Function Number: 83
is_goliath_drop_pod(param_00)
{
	return isdefined(param_00.cratetype) && param_00.cratetype == "juggernaut" && isdefined(param_00.droptype) && param_00.droptype == "juggernaut";
}

//Function Number: 84
movingplatformdeathfunc(param_00)
{
	if(isdefined(param_00.emptymech))
	{
		param_00.emptymech delete();
	}

	if(isdefined(param_00.useent))
	{
		param_00.useent delete();
	}
}

//Function Number: 85
movingplatformtouchvalid(param_00)
{
	return goliathandcarepackagevalid(param_00) && goliathandgoliathvalid(param_00) && goliathandplatformvalid(param_00);
}

//Function Number: 86
goliathandcarepackagevalid(param_00)
{
	return !isdefined(self.cratetype) || !isdefined(param_00.targetname) || self.cratetype != "juggernaut" || param_00.targetname != "care_package";
}

//Function Number: 87
goliathandgoliathvalid(param_00)
{
	return !isdefined(self.cratetype) || !isdefined(param_00.cratetype) || self.cratetype != "juggernaut" || param_00.cratetype != "juggernaut";
}

//Function Number: 88
goliathandplatformvalid(param_00)
{
	return !isdefined(self.cratetype) || !isdefined(param_00.carepackagetouchvalid) || self.cratetype != "juggernaut" || !param_00.carepackagetouchvalid;
}

//Function Number: 89
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

//Function Number: 90
is_entering_goliath(param_00,param_01)
{
	var_02 = anglestoforward(param_00.angles);
	param_01 = param_01 - var_02 * 37;
	self setorigin(param_01,0);
	self setplayerangles(param_00.angles);
	if(level.currentgen)
	{
		thread cggoliathroverlay();
	}

	wait(0.05);
	param_00 scriptmodelplayanimdeltamotion("mp_goliath_enter");
	self playgoliathentryanim();
	wait(2.3);
}

//Function Number: 91
createcollision(param_00)
{
	var_01 = getent("goliath_collision","targetname");
	if(isdefined(var_01))
	{
		self clonebrushmodeltoscriptmodel(var_01);
	}
}

//Function Number: 92
playerwaittillgoliathactivated()
{
	self endon("death");
	self waittill("captured",var_00);
	var_00 setstance("stand");
	return var_00;
}

//Function Number: 93
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

//Function Number: 94
usepostjuggernautupdater(param_00)
{
	self endon("death");
	level endon("game_ended");
	param_00 endon("disconnect");
	param_00 endon("ejectedFromJuggernaut");
	param_00 waittill("death");
	self enableplayeruse(param_00);
}

//Function Number: 95
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

//Function Number: 96
drawspine(param_00,param_01)
{
	param_00 endon("disconnect");
	param_00 endon("death");
	param_01 endon("death");
	for(;;)
	{
		var_02 = param_01.origin;
		var_03 = param_01.angles;
		debug_axis(var_02,var_03);
		wait 0.05;
	}
}

//Function Number: 97
debug_axis(param_00,param_01)
{
	var_02 = 20;
	var_03 = anglestoforward(param_01) * var_02;
	var_04 = anglestoright(param_01) * var_02;
	var_05 = anglestoup(param_01) * var_02;
}

//Function Number: 98
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

//Function Number: 99
playermech_state_manager()
{
	self endon("disconnect");
	self endon("exit_mech");
	self endon("ejectedFromJuggernaut");
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

//Function Number: 100
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

//Function Number: 101
get_mech_state()
{
	if(!isdefined(self.mechuistate))
	{
		return;
	}

	return self.mechuistate.state;
}

//Function Number: 102
playermech_ui_weapon_feedback(param_00,param_01)
{
	self endon("disconnect");
	self endon("exit_mech");
	self endon("ejectedFromJuggernaut");
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

//Function Number: 103
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

//Function Number: 104
playermech_invalid_gun_callback()
{
	if(self.mechuistate.chaingun.overheated)
	{
		return 1;
	}

	return 0;
}

//Function Number: 105
playermech_invalid_rocket_callback()
{
	if(self.mechuistate.rocket.recharge < 100)
	{
		return 1;
	}

	return 0;
}

//Function Number: 106
playermech_invalid_swarm_callback()
{
	if(self.mechuistate.swarm.recharge < 100)
	{
		return 1;
	}

	return 0;
}

//Function Number: 107
playermech_invalid_weapon_instance(param_00,param_01)
{
	self endon("disconnect");
	self endon("exit_mech");
	self endon("ejectedFromJuggernaut");
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

//Function Number: 108
playermech_invalid_weapon_watcher()
{
	thread playermech_invalid_weapon_instance(::attackbuttonpressed,::playermech_invalid_gun_callback);
	thread playermech_invalid_weapon_instance(::fragbuttonpressed,::playermech_invalid_rocket_callback);
	thread playermech_invalid_weapon_instance(::secondaryoffhandbuttonpressed,::playermech_invalid_swarm_callback);
}

//Function Number: 109
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

//Function Number: 110
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

//Function Number: 111
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

//Function Number: 112
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

//Function Number: 113
get_mech_chaingun_state()
{
	if(!isdefined(self.mechuistate))
	{
		return;
	}

	return self.mechuistate.chaingun.state;
}

//Function Number: 114
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

//Function Number: 115
get_mech_rocket_state()
{
	if(!isdefined(self.mechuistate))
	{
		return;
	}

	return self.mechuistate.rocket.state;
}

//Function Number: 116
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

//Function Number: 117
get_mech_swarm_state()
{
	if(!isdefined(self.mechuistate))
	{
		return;
	}

	return self.mechuistate.swarm.state;
}

//Function Number: 118
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

//Function Number: 119
playermech_monitor_rocket_recharge()
{
	self endon("disconnect");
	self endon("exit_mech");
	self notify("stop_rocket_recharge");
	self endon("stop_rocket_recharge");
	self endon("ejectedFromJuggernaut");
	for(;;)
	{
		self waittill("mech_rocket_fire");
		self disableoffhandweapons();
		playermech_monitor_update_recharge(self.mechuistate.rocket,playergetrocketreloadtime());
		self enableoffhandweapons();
		wait(0.05);
	}
}

//Function Number: 120
playermech_monitor_swarm_recharge()
{
	self endon("disconnect");
	self endon("exit_mech");
	self notify("stop_swarm_recharge");
	self endon("stop_swarm_recharge");
	self endon("ejectedFromJuggernaut");
	for(;;)
	{
		self waittill("mech_swarm_fire");
		self disableoffhandsecondaryweapons();
		playermech_monitor_update_recharge(self.mechuistate.swarm,playergetswarmreloadtime());
		self enableoffhandsecondaryweapons();
		wait(0.05);
	}
}

//Function Number: 121
play_goliath_death_fx()
{
	level endon("game_ended");
	self endon("disconnect");
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
				return;
			}
		}
	}
}

//Function Number: 122
playermechtimeout()
{
	level endon("game_ended");
	self endon("disconnect");
	self endon("lost_juggernaut");
	self endon("ejectedFromJuggernaut");
	var_00 = int(2);
	while(maps\mp\zombies\_util::is_true(self.goliathbootupsequence))
	{
		wait 0.05;
	}

	for(;;)
	{
		wait(1);
		var_01 = self.mechhealth / 600;
		self.mechhealth = self.mechhealth - var_00;
		var_02 = self.mechhealth / 600;
		self setclientomnvar("ui_exo_suit_health",var_02);
		level thread dogoliathintegrityvo(var_01,var_02,self);
		if(self.mechhealth < 0)
		{
			if(!isdefined(self.underwatermotiontype))
			{
				thread playereject();
			}
			else
			{
				thread playerkillheavyexo(self.origin);
			}

			return;
		}
	}
}

//Function Number: 123
onplayerconnect()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_00 thread onplayerspawned();
	}
}

//Function Number: 124
onplayerspawned()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("spawned_player");
		self.hideondeath = 0;
	}
}

//Function Number: 125
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

//Function Number: 126
handle_goliath_drop_pod_removal(param_00)
{
	level endon("game_ended");
	self endon("death");
	param_00 waittill("death");
	self delete();
}

//Function Number: 127
setupeject(param_00,param_01)
{
	param_01 endon("disconnect");
	param_01 endon("death");
	param_01 endon("ejectedFromJuggernaut");
	if(!isbot(param_01))
	{
		param_01 notifyonplayercommand("juggernautEject","+goStand");
	}

	for(;;)
	{
		param_01 waittill("juggernautEject");
		wait 0.05;
		var_02 = 0;
		while(param_01 jumpbuttonpressed())
		{
			var_02 = var_02 + 0.05;
			if(var_02 > 0.7)
			{
				if(!isdefined(param_01.underwatermotiontype))
				{
					param_01 thread playereject();
				}
				else
				{
					param_01 thread playerkillheavyexo(param_01.origin);
				}

				return;
			}

			wait 0.05;
		}
	}
}

//Function Number: 128
playereject(param_00)
{
	self notify("ejectedFromJuggernaut");
	level thread juggernautsuitexplode(self);
	self detachall();
	self setmodel(self.charactermodel);
	self setviewmodel(self.characterviewmodel);
	self attach(self.characterhead);
	restoreweapons();
	thread playersetpreviousweapon();
	if(maps\mp\_utility::isjuggernaut())
	{
		playerreset();
	}

	level notify("player_left_goliath_suit");
}

//Function Number: 129
playerhandlejump()
{
	self endon("disconnect");
	self endon("death");
	self allowjump(0);
	wait(1);
	while(!self isonground())
	{
		wait 0.05;
	}

	self allowjump(1);
}

//Function Number: 130
playersetpreviousweapon()
{
	self endon("disconnect");
	self endon("death");
	var_00 = self.primarytorestore;
	self.primarytorestore = undefined;
	while(self getcurrentweapon() != var_00)
	{
		self switchtoweapon(var_00);
		wait(0.1);
	}
}

//Function Number: 131
juggernautsuitexplode(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = param_00;
	}

	var_02 = param_01.origin;
	var_03 = param_01.angles;
	waittillframeend;
	if(isdefined(param_00))
	{
		param_00 radiusdamage(var_02,400,200,50,param_00,"MOD_EXPLOSIVE","iw5_juggernautrocketszm_mp");
		param_00 maps\mp\_snd_common_mp::snd_message("goliath_self_destruct");
	}

	playfx(common_scripts\utility::getfx("goliath_self_destruct"),var_02,anglestoup(var_03));
}

//Function Number: 132
announcerglobalplaysuitvo(param_00,param_01,param_02)
{
	param_02 endon("death");
	param_02 endon("disconnect");
	param_02 endon("ejectedFromJuggernaut");
	if(isdefined(param_01) && param_01 > 0)
	{
		wait(param_01);
	}

	maps\mp\zombies\_zombies_audio_announcer::waittillallannouncersdonespeaking();
	maps\mp\zombies\_zombies_audio_announcer::announcerglobaldialog("global",param_00,undefined,undefined,undefined,undefined,[param_02]);
}