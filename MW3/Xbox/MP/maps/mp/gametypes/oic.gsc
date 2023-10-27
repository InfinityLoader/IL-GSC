/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\oic.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 23
 * Decompile Time: 322 ms
 * Timestamp: 10/27/2023 2:26:18 AM
*******************************************************************/

//Function Number: 1
main()
{
	maps\mp\gametypes\_globallogic::init();
	maps\mp\gametypes\_callbacksetup::setupcallbacks();
	maps\mp\gametypes\_globallogic::setupcallbacks();
	if(isusingmatchrulesdata())
	{
		level.initializematchrules = ::initializematchrules;
		[[ level.initializematchrules ]]();
		level thread maps\mp\_utility::func_810A();
	}
	else
	{
		maps\mp\_utility::func_3315(level.gametype,10);
		maps\mp\_utility::registerscorelimitdvar(level.gametype,0);
		maps\mp\_utility::func_3312(level.gametype,1);
		maps\mp\_utility::registerwinlimitdvar(level.gametype,1);
		maps\mp\_utility::func_3317(level.gametype,2);
		maps\mp\_utility::registerhalftimedvar(level.gametype,0);
		level.matchrules_damagemultiplier = 0;
		level.matchrules_vampirism = 0;
		level.matchrules_oneshotkill = 0;
		level.matchrules_initialammo = 2;
		level.matchrules_rewardammo = 2;
	}

	func_351A();
	func_34B3();
	level.teambased = 0;
	level.doprematch = 1;
	level.onstartgametype = ::onstartgametype;
	level.onspawnplayer = ::onspawnplayer;
	level.getspawnpoint = ::getspawnpoint;
	level.onplayerkilled = ::onplayerkilled;
	level.ononeleftevent = ::ononeleftevent;
	if(level.matchrules_oneshotkill)
	{
		level.modifyplayerdamage = ::modifyplayerdamage;
	}
}

//Function Number: 2
initializematchrules()
{
	maps\mp\_utility::func_334C(1);
	level.matchrules_initialammo = getmatchrulesdata("oicData","initialAmmoCount");
	level.matchrules_rewardammo = getmatchrulesdata("oicData","killRewardAmmoCount");
	level.matchrules_oneshotkill = getmatchrulesdata("oicData","oneShotKill");
	level.matchrules_damagemultiplier = 0;
	level.matchrules_vampirism = 0;
	setdynamicdvar("scr_oic_winlimit",1);
	maps\mp\_utility::registerwinlimitdvar("oic",1);
	setdynamicdvar("scr_oic_roundlimit",1);
	maps\mp\_utility::func_3312("oic",1);
	setdynamicdvar("scr_oic_halftime",0);
	maps\mp\_utility::registerhalftimedvar("oic",0);
	setdynamicdvar("scr_oic_promode",0);
	setdynamicdvar("scr_oic_playerrespawndelay",0);
	setdynamicdvar("scr_oic_waverespawndelay",0);
	setdynamicdvar("scr_player_forcerespawn",1);
	setdynamicdvar("scr_player_maxhealth",100);
	setdynamicdvar("scr_game_onlyheadshots",0);
	setdynamicdvar("scr_player_healthregentime",5);
	if(maps\mp\_utility::matchmakinggame())
	{
		setdynamicdvar("scr_game_hardpoints",1);
		setdynamicdvar("scr_game_perks",1);
		return;
	}

	setdynamicdvar("scr_game_hardpoints",0);
}

//Function Number: 3
onstartgametype()
{
	setclientnamemode("auto_change");
	maps\mp\_utility::func_3305("allies",&"OBJECTIVES_OIC");
	maps\mp\_utility::func_3305("axis",&"OBJECTIVES_OIC");
	if(level.splitscreen)
	{
		maps\mp\_utility::func_3306("allies",&"OBJECTIVES_OIC");
		maps\mp\_utility::func_3306("axis",&"OBJECTIVES_OIC");
	}
	else
	{
		maps\mp\_utility::func_3306("allies",&"OBJECTIVES_OIC_SCORE");
		maps\mp\_utility::func_3306("axis",&"OBJECTIVES_OIC_SCORE");
	}

	maps\mp\_utility::setobjectivehinttext("allies",&"OBJECTIVES_OIC_HINT");
	maps\mp\_utility::setobjectivehinttext("axis",&"OBJECTIVES_OIC_HINT");
	level.spawnmins = (0,0,0);
	level.spawnmaxs = (0,0,0);
	maps\mp\gametypes\_spawnlogic::func_2FD0("allies","mp_dm_spawn");
	maps\mp\gametypes\_spawnlogic::func_2FD0("axis","mp_dm_spawn");
	level.mapcenter = maps\mp\gametypes\_spawnlogic::func_2FCD(level.spawnmins,level.spawnmaxs);
	setmapcenter(level.mapcenter);
	var_00 = [];
	maps\mp\gametypes\_gameobjects::main(var_00);
	if(maps\mp\_utility::matchmakinggame())
	{
		maps\mp\gametypes\_equipment::createkilltriggers();
	}

	maps\mp\gametypes\_rank::registerscoreinfo("kill_bonus",50);
	maps\mp\gametypes\_rank::registerscoreinfo("kill",100);
	maps\mp\gametypes\_rank::registerscoreinfo("survivor",20);
	maps\mp\gametypes\_rank::registerscoreinfo("assist",0);
	maps\mp\gametypes\_rank::registerscoreinfo("suicide",0);
	maps\mp\gametypes\_rank::registerscoreinfo("teamkill",0);
	maps\mp\gametypes\_rank::registerscoreinfo("headshot",0);
	maps\mp\gametypes\_rank::registerscoreinfo("execution",0);
	maps\mp\gametypes\_rank::registerscoreinfo("avenger",0);
	maps\mp\gametypes\_rank::registerscoreinfo("defender",0);
	maps\mp\gametypes\_rank::registerscoreinfo("posthumous",0);
	maps\mp\gametypes\_rank::registerscoreinfo("revenge",0);
	maps\mp\gametypes\_rank::registerscoreinfo("double",0);
	maps\mp\gametypes\_rank::registerscoreinfo("triple",0);
	maps\mp\gametypes\_rank::registerscoreinfo("multi",0);
	maps\mp\gametypes\_rank::registerscoreinfo("buzzkill",0);
	maps\mp\gametypes\_rank::registerscoreinfo("firstblood",0);
	maps\mp\gametypes\_rank::registerscoreinfo("comeback",0);
	maps\mp\gametypes\_rank::registerscoreinfo("longshot",0);
	maps\mp\gametypes\_rank::registerscoreinfo("assistedsuicide",0);
	maps\mp\gametypes\_rank::registerscoreinfo("knifethrow",0);
	level.quickmessagetoall = 1;
	level.blockweapondrops = 1;
	if(maps\mp\_utility::matchmakinggame())
	{
		level.killstreakrewards = 1;
		level thread finalthreeuav();
	}
	else
	{
		level.killstreakrewards = 0;
	}

	level thread onplayerconnect();
}

//Function Number: 4
onplayerconnect()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_00.oic_firstspawn = 1;
		var_00.oic_hasspawned = 0;
		var_00.oichud_button = undefined;
		var_00.oichud_text = undefined;
		var_00.oichud_name = undefined;
	}
}

//Function Number: 5
getspawnpoint()
{
	if(self.oic_firstspawn)
	{
		self.oic_firstspawn = 0;
		self.pers["class"] = "gamemode";
		self.pers["lastClass"] = "";
		self.class = self.pers["class"];
		self.lastclass = self.pers["lastClass"];
		if(common_scripts\utility::cointoss())
		{
			maps\mp\gametypes\_menus::func_2AF3("axis",1);
		}
		else
		{
			maps\mp\gametypes\_menus::func_2AF3("allies",1);
		}

		thread movelatejoinerstospectators();
	}

	var_00 = maps\mp\gametypes\_spawnlogic::getteamspawnpoints(self.pers["team"]);
	var_01 = maps\mp\gametypes\_spawnlogic::func_2FEF(var_00);
	return var_01;
}

//Function Number: 6
movelatejoinerstospectators()
{
	level endon("game_ended");
	self endon("disconnect");
	maps\mp\_utility::func_274B("prematch_done");
	maps\mp\_utility::func_274B("graceperiod_done");
	maps\mp\gametypes\_hostmigration::func_2740(5);
	if(!self.oic_hasspawned)
	{
		self notify("used_predicted_spawnpoint");
		maps\mp\gametypes\_menus::func_2AF3("spectator",1);
		if(level.console && maps\mp\_utility::matchmakinggame())
		{
			thread playerwager(0);
		}
	}
}

//Function Number: 7
onspawnplayer()
{
	if(isdefined(self.oic_rewardammo) && self.oic_rewardammo)
	{
		func_3518();
	}
	else
	{
		self.oic_rewardammo = 0;
	}

	self.pers["gamemodeLoadout"] = level.oic_loadouts[self.pers["team"]];
	thread waitloadoutdone();
	level notify("spawned_player");
}

//Function Number: 8
waitloadoutdone()
{
	level endon("game_ended");
	self endon("disconnect");
	self waittill("spawned_player");
	self takeallweapons();
	maps\mp\_utility::giveperk("specialty_bling",0);
	var_00 = func_8114(level.oic_gun);
	maps\mp\_utility::_giveweapon(var_00);
	self switchtoweapon(var_00);
	self setspawnweapon(var_00);
	var_01 = strtok(var_00,"_");
	if(var_01[0] == "iw5")
	{
		var_02 = var_01[0] + "_" + var_01[1];
	}
	else if(var_02[0] == "alt")
	{
		var_02 = var_02[1] + "_" + var_02[2];
	}
	else
	{
		var_02 = var_02[0];
	}

	self.pers["primaryWeapon"] = var_02;
	self.primaryweapon = var_00;
	var_03 = weaponclipsize(var_00);
	if(level.matchrules_initialammo > var_03)
	{
		self setweaponammoclip(self.primaryweapon,var_03);
		self setweaponammostock(self.primaryweapon,level.matchrules_initialammo - var_03);
	}
	else
	{
		self setweaponammoclip(self.primaryweapon,level.matchrules_initialammo);
		self setweaponammostock(self.primaryweapon,0);
	}

	if(maps\mp\_utility::matchmakinggame())
	{
		thread removescavenger();
		wait 0.05;
		if(!maps\mp\_utility::func_27AF("specialty_fastmantle"))
		{
			maps\mp\_utility::giveperk("specialty_fastmantle",0);
		}

		if(!maps\mp\_utility::func_27AF("specialty_assists"))
		{
			maps\mp\_utility::giveperk("specialty_assists",0);
		}

		if(!maps\mp\_utility::func_27AF("specialty_falldamage"))
		{
			maps\mp\_utility::giveperk("specialty_falldamage",0);
		}
	}

	self.oic_hasspawned = 1;
}

//Function Number: 9
func_8114(param_00)
{
	if(isdefined(level.gun_attachments[param_00]) && isdefined(level.gun_attachments[param_00]["attach1"]))
	{
		var_01 = level.gun_attachments[param_00]["attach1"];
	}
	else
	{
		var_01 = "none";
	}

	if(isdefined(level.gun_attachments[param_00]) && isdefined(level.gun_attachments[param_00]["attach2"]))
	{
		var_02 = level.gun_attachments[param_00]["attach2"];
	}
	else
	{
		var_02 = "none";
	}

	var_03 = maps\mp\gametypes\_class::func_32BC(param_00,var_01,var_02,0,0);
	return var_03;
}

//Function Number: 10
modifyplayerdamage(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	if(param_03 == "MOD_PISTOL_BULLET" || param_03 == "MOD_RIFLE_BULLET" || param_03 == "MOD_HEAD_SHOT")
	{
		param_02 = 999;
	}

	return param_02;
}

//Function Number: 11
onplayerkilled(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	if(isdefined(param_01) && isplayer(param_01) && self != param_01)
	{
		param_01.oic_rewardammo = param_01.oic_rewardammo + level.matchrules_rewardammo;
		if(self attackbuttonpressed())
		{
			param_01 thread waitgiveammo();
		}
		else
		{
			param_01 func_3518();
		}

		if(maps\mp\_utility::getgametypenumlives() && self.pers["deaths"] == maps\mp\_utility::getgametypenumlives())
		{
			eliminateplayer();
		}

		if(level.console && maps\mp\_utility::matchmakinggame())
		{
			foreach(var_0B in level.players)
			{
				if(isdefined(var_0B.sessionstate) && var_0B.sessionstate == "spectator" || var_0B.sessionstate == "spectating" && isdefined(var_0B.wagingplayer) && var_0B.wagingplayer == param_01.name)
				{
					var_0B thread maps\mp\gametypes\_rank::xpeventpopup(&"SPLASHES_PROXIMITYKILL");
					var_0B thread maps\mp\gametypes\_rank::func_2AB3("kill_bonus");
				}
			}
		}
	}
}

//Function Number: 12
ononeleftevent(param_00)
{
	var_01 = maps\mp\_utility::getlastlivingplayer();
	logstring("last one alive, win: " + var_01.name);
	level.finalkillcam_winner = "none";
	level thread maps\mp\gametypes\_gamelogic::endgame(var_01,&"MP_ENEMIES_ELIMINATED");
}

//Function Number: 13
waitgiveammo()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	self notify("oic_waitGiveAmmo");
	self endon("oic_waitGiveAmmo");
	while(self attackbuttonpressed())
	{
		wait 0.05;
	}

	func_3518();
}

//Function Number: 14
func_3518()
{
	var_00 = self getcurrentweapon();
	var_01 = self getweaponammostock(var_00);
	var_02 = self getweaponammoclip(var_00);
	var_03 = weaponclipsize(var_00);
	if(var_02 + self.oic_rewardammo > var_03)
	{
		self setweaponammoclip(var_00,var_03);
		self setweaponammostock(var_00,var_01 + var_02 + self.oic_rewardammo - var_03);
	}
	else
	{
		self setweaponammoclip(var_00,var_02 + self.oic_rewardammo);
	}

	self playlocalsound("scavenger_pack_pickup");
	self.oic_rewardammo = 0;
}

//Function Number: 15
eliminateplayer()
{
	if(level.console && maps\mp\_utility::matchmakinggame())
	{
		thread playerwager(1);
	}

	thread maps\mp\_utility::teamplayercardsplash("callout_eliminated",self);
	var_00 = [];
	foreach(var_02 in level.players)
	{
		if(var_02.pers["deaths"] < maps\mp\_utility::getgametypenumlives() && var_02.oic_hasspawned)
		{
			var_00[var_00.size] = var_02;
			var_02 thread maps\mp\gametypes\_rank::xpeventpopup(&"SPLASHES_SURVIVOR");
			maps\mp\gametypes\_gamescore::func_26D3("survivor",var_02,undefined,1);
			var_02 thread maps\mp\gametypes\_rank::func_2AB3("survivor");
			continue;
		}

		if(isdefined(var_02.wagingplayer) && var_02.wagingplayer == self.name)
		{
			var_02.oichud_name settext(" ");
		}
	}

	if(var_00.size > 2)
	{
		maps\mp\_utility::func_2D68("mp_enemy_obj_captured");
		return;
	}

	if(var_00.size == 2)
	{
		maps\mp\_utility::func_2D68("mp_obj_captured");
		var_00[0] thread maps\mp\gametypes\_hud_message::playercardsplashnotify("callout_lastenemyalive",var_00[1]);
		var_00[1] thread maps\mp\gametypes\_hud_message::playercardsplashnotify("callout_lastenemyalive",var_00[0]);
	}
}

//Function Number: 16
playerwager(param_00)
{
	level endon("game_ended");
	self endon("disconnect");
	if(param_00)
	{
		wait 7;
	}

	self.oichud_button = createhudelem("^3[{+usereload}]^7",1.4,(0.8,0.8,0.8),0,-50,100);
	self.oichud_text = createhudelem(&"MENU_SELECT",1.6,(0.8,0.8,0.8),0,-27,99);
	self.oichud_name = createhudelem(" ",1.75,(0.25,0.75,0.25),0.75,-23,122);
	thread hidebuttonsonfreespectate();
	self notifyonplayercommand("selected_player","+usereload");
	for(;;)
	{
		self waittill("selected_player");
		var_01 = self getspectatingplayer();
		if(isdefined(var_01))
		{
			self.wagingplayer = var_01.name;
			self.oichud_name settext(var_01.name);
			self playlocalsound("recondrone_lockon");
		}
	}
}

//Function Number: 17
createhudelem(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = maps\mp\gametypes\_hud_util::createfontstring("small",param_01);
	var_06 settext(param_00);
	if(self issplitscreenplayer())
	{
		param_05 = param_05 - 35;
	}

	var_06 maps\mp\gametypes\_hud_util::setpoint("TOPLEFT","CENTER",param_04,param_05);
	var_06.alpha = 0;
	var_06.color = param_02;
	var_06.glowcolor = param_02;
	var_06.glowalpha = param_03;
	var_06.archived = 0;
	var_06.hidewheninmenu = 1;
	level thread func_3535(var_06);
	return var_06;
}

//Function Number: 18
hidebuttonsonfreespectate()
{
	level endon("game_ended");
	self endon("disconnect");
	for(;;)
	{
		var_00 = self getspectatingplayer();
		if(isdefined(var_00))
		{
			self.oichud_button.alpha = 1;
			self.oichud_text.alpha = 1;
			self.oichud_name.alpha = 1;
		}
		else
		{
			self.oichud_button.alpha = 0;
			self.oichud_text.alpha = 0;
			self.oichud_name.alpha = 0;
		}

		wait 0.05;
	}
}

//Function Number: 19
func_3535(param_00)
{
	level waittill("game_ended");
	if(isdefined(param_00))
	{
		param_00.alpha = 0;
	}
}

//Function Number: 20
removescavenger()
{
	level endon("game_ended");
	self endon("disconnect");
	self endon("death");
	for(;;)
	{
		if(maps\mp\_utility::func_27AF("specialty_scavenger"))
		{
			maps\mp\_utility::func_282E("specialty_scavenger");
		}

		wait 0.05;
	}
}

//Function Number: 21
finalthreeuav()
{
	level endon("game_ended");
	maps\mp\_utility::func_274B("prematch_done");
	maps\mp\_utility::func_274B("graceperiod_done");
	for(;;)
	{
		var_00 = [];
		foreach(var_02 in level.players)
		{
			if(var_02.pers["deaths"] < maps\mp\_utility::getgametypenumlives() && var_02.oic_hasspawned)
			{
				var_00[var_00.size] = var_02;
			}
		}

		if(var_00.size < 4)
		{
			foreach(var_02 in var_00)
			{
				var_02 setclientdvars("g_compassShowEnemies",1);
			}

			setdynamicdvar("scr_game_forceuav",1);
			break;
		}

		wait 0.5;
	}
}

//Function Number: 22
func_351A()
{
	level.oic_gun = undefined;
	var_00 = "none";
	if(isusingmatchrulesdata())
	{
		var_00 = getmatchrulesdata("oicData","weapon");
	}

	if(isdefined(var_00) && var_00 != "none")
	{
		level.oic_gun = var_00;
	}
	else
	{
		level.oic_gun = "iw5_deserteagle";
	}

	if(level.oic_gun == "iw5_type95" || level.oic_gun == "iw5_m16")
	{
		level.matchrules_initialammo = level.matchrules_initialammo * 3;
		level.matchrules_rewardammo = level.matchrules_rewardammo * 3;
	}
}

//Function Number: 23
func_34B3()
{
	level.oic_loadouts["axis"]["loadoutPrimary"] = "iw5_acr";
	level.oic_loadouts["axis"]["loadoutPrimaryAttachment"] = "none";
	level.oic_loadouts["axis"]["loadoutPrimaryAttachment2"] = "none";
	level.oic_loadouts["axis"]["loadoutPrimaryBuff"] = "specialty_null";
	level.oic_loadouts["axis"]["loadoutPrimaryCamo"] = "none";
	level.oic_loadouts["axis"]["loadoutPrimaryReticle"] = "none";
	level.oic_loadouts["axis"]["loadoutSecondary"] = "none";
	level.oic_loadouts["axis"]["loadoutSecondaryAttachment"] = "none";
	level.oic_loadouts["axis"]["loadoutSecondaryAttachment2"] = "none";
	level.oic_loadouts["axis"]["loadoutSecondaryBuff"] = "specialty_null";
	level.oic_loadouts["axis"]["loadoutSecondaryCamo"] = "none";
	level.oic_loadouts["axis"]["loadoutSecondaryReticle"] = "none";
	level.oic_loadouts["axis"]["loadoutEquipment"] = "specialty_null";
	level.oic_loadouts["axis"]["loadoutOffhand"] = "none";
	if(maps\mp\_utility::matchmakinggame())
	{
		level.oic_loadouts["axis"]["loadoutPerk1"] = "specialty_longersprint";
		level.oic_loadouts["axis"]["loadoutPerk2"] = "specialty_hardline";
		level.oic_loadouts["axis"]["loadoutPerk3"] = "specialty_null";
		level.oic_loadouts["axis"]["loadoutStreakType"] = "streaktype_specialist";
		level.oic_loadouts["axis"]["loadoutKillstreak1"] = "specialty_quickdraw_ks";
		level.oic_loadouts["axis"]["loadoutKillstreak2"] = "specialty_stalker_ks";
		level.oic_loadouts["axis"]["loadoutKillstreak3"] = "specialty_bulletaccuracy_ks";
		level.oic_loadouts["axis"]["loadoutDeathstreak"] = "specialty_juiced";
	}
	else
	{
		level.oic_loadouts["axis"]["loadoutPerk1"] = "specialty_null";
		level.oic_loadouts["axis"]["loadoutPerk2"] = "specialty_null";
		level.oic_loadouts["axis"]["loadoutPerk3"] = "specialty_null";
		level.oic_loadouts["axis"]["loadoutDeathstreak"] = "specialty_null";
	}

	level.oic_loadouts["axis"]["loadoutJuggernaut"] = 0;
	level.oic_loadouts["allies"] = level.oic_loadouts["axis"];
	level.gun_attachments = [];
	level.gun_attachments["iw5_usp45"]["attach1"] = "tactical";
	level.gun_attachments["iw5_p99"]["attach1"] = "tactical";
	level.gun_attachments["iw5_fnfiveseven"]["attach1"] = "tactical";
	level.gun_attachments["iw5_44magnum"]["attach1"] = "tactical";
	level.gun_attachments["iw5_deserteagle"]["attach1"] = "tactical";
	level.gun_attachments["iw5_mp412"]["attach1"] = "tactical";
	level.gun_attachments["iw5_fmg9"]["attach1"] = "reflex";
	level.gun_attachments["iw5_skorpion"]["attach1"] = "reflex";
	level.gun_attachments["iw5_mp9"]["attach1"] = "reflex";
	level.gun_attachments["iw5_g18"]["attach1"] = "reflex";
	level.gun_attachments["iw5_mp5"]["attach1"] = "reflex";
	level.gun_attachments["iw5_m9"]["attach1"] = "reflex";
	level.gun_attachments["iw5_p90"]["attach1"] = "reflex";
	level.gun_attachments["iw5_pp90m1"]["attach1"] = "reflex";
	level.gun_attachments["iw5_ump45"]["attach1"] = "reflex";
	level.gun_attachments["iw5_mp7"]["attach1"] = "reflex";
	level.gun_attachments["iw5_ak47"]["attach1"] = "reflex";
	level.gun_attachments["iw5_m16"]["attach1"] = "reflex";
	level.gun_attachments["iw5_m4"]["attach1"] = "reflex";
	level.gun_attachments["iw5_fad"]["attach1"] = "reflex";
	level.gun_attachments["iw5_acr"]["attach1"] = "reflex";
	level.gun_attachments["iw5_type95"]["attach1"] = "reflex";
	level.gun_attachments["iw5_mk14"]["attach1"] = "reflex";
	level.gun_attachments["iw5_scar"]["attach1"] = "reflex";
	level.gun_attachments["iw5_g36c"]["attach1"] = "reflex";
	level.gun_attachments["iw5_cm901"]["attach1"] = "reflex";
	level.gun_attachments["iw5_ksg"]["attach1"] = "grip";
	level.gun_attachments["iw5_striker"]["attach1"] = "grip";
	level.gun_attachments["iw5_aa12"]["attach1"] = "grip";
	level.gun_attachments["iw5_usas12"]["attach1"] = "grip";
	level.gun_attachments["iw5_spas12"]["attach1"] = "grip";
	level.gun_attachments["iw5_m60"]["attach1"] = "grip";
	level.gun_attachments["iw5_m60"]["attach2"] = "reflex";
	level.gun_attachments["iw5_mk46"]["attach1"] = "grip";
	level.gun_attachments["iw5_mk46"]["attach2"] = "reflex";
	level.gun_attachments["iw5_pecheneg"]["attach1"] = "grip";
	level.gun_attachments["iw5_pecheneg"]["attach2"] = "reflex";
	level.gun_attachments["iw5_sa80"]["attach1"] = "grip";
	level.gun_attachments["iw5_sa80"]["attach2"] = "reflex";
	level.gun_attachments["iw5_mg36"]["attach1"] = "grip";
	level.gun_attachments["iw5_mg36"]["attach2"] = "reflex";
}