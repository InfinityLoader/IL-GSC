/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\perks\_perkfunctions.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 131
 * Decompile Time: 2239 ms
 * Timestamp: 10/27/2023 2:27:32 AM
*******************************************************************/

//Function Number: 1
setoverkillpro()
{
}

//Function Number: 2
unsetoverkillpro()
{
}

//Function Number: 3
func_295F()
{
}

//Function Number: 4
func_2960()
{
}

//Function Number: 5
func_295D()
{
	func_2A36();
	func_2A35();
}

//Function Number: 6
func_2A35()
{
	self waittill("death");
	self endon("disconnect");
	self endon("endAutoSpotAdsWatcher");
	level endon("game_ended");
	self autospotoverlayoff();
}

//Function Number: 7
func_295E()
{
	self notify("endAutoSpotAdsWatcher");
	self autospotoverlayoff();
}

//Function Number: 8
func_2A36()
{
	self endon("death");
	self endon("disconnect");
	self endon("endAutoSpotAdsWatcher");
	level endon("game_ended");
	var_00 = 0;
	for(;;)
	{
		wait 0.05;
		if(self isusingturret())
		{
			self autospotoverlayoff();
			continue;
		}

		var_01 = self playerads();
		if(var_01 < 1 && var_00)
		{
			var_00 = 0;
			self autospotoverlayoff();
		}

		if(var_01 < 1 && !var_00)
		{
			continue;
		}

		if(var_01 == 1 && !var_00)
		{
			var_00 = 1;
			self autospotoverlayon();
		}
	}
}

//Function Number: 9
func_295B()
{
}

//Function Number: 10
func_295C()
{
}

//Function Number: 11
func_2959()
{
	self.shellshockreduction = 0.25;
}

//Function Number: 12
unsethardshell()
{
	self.shellshockreduction = 0;
}

//Function Number: 13
func_2957()
{
	self setviewkickscale(0.5);
}

//Function Number: 14
func_2958()
{
	self setviewkickscale(1);
}

//Function Number: 15
func_2955()
{
	self endon("death");
	self endon("disconnect");
	self endon("endDoubleLoad");
	level endon("game_ended");
	for(;;)
	{
		self waittill("reload");
		var_00 = self getweaponslist("primary");
		foreach(var_02 in var_00)
		{
			var_03 = self getweaponammoclip(var_02);
			var_04 = weaponclipsize(var_02);
			var_05 = var_04 - var_03;
			var_06 = self getweaponammostock(var_02);
			if(var_03 != var_04 && var_06 > 0)
			{
				if(var_03 + var_06 >= var_04)
				{
					self setweaponammoclip(var_02,var_04);
					self setweaponammostock(var_02,var_06 - var_05);
					continue;
				}

				self setweaponammoclip(var_02,var_03 + var_06);
				if(var_06 - var_05 > 0)
				{
					self setweaponammostock(var_02,var_06 - var_05);
					continue;
				}

				self setweaponammostock(var_02,0);
			}
		}
	}
}

//Function Number: 16
unsetdoubleload()
{
	self notify("endDoubleLoad");
}

//Function Number: 17
setmarksman()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	maps\mp\_utility::setrecoilscale(10);
	self.recoilscale = 10;
}

//Function Number: 18
unsetmarksman()
{
	maps\mp\_utility::setrecoilscale(0);
	self.recoilscale = 0;
}

//Function Number: 19
func_2951()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	self.stunscaler = 0.5;
}

//Function Number: 20
unsetstunresistance()
{
	self.stunscaler = 1;
}

//Function Number: 21
setsteadyaimpro()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	self setaimspreadmovementscale(0.5);
}

//Function Number: 22
func_2950()
{
	self notify("end_SteadyAimPro");
	self setaimspreadmovementscale(1);
}

//Function Number: 23
func_2A38(param_00,param_01)
{
	self endon("death");
	self endon("disconnect");
	self endon("end_perkUseTracker");
	level endon("game_ended");
	for(;;)
	{
		self waittill("empty_offhand");
		if(!common_scripts\utility::isoffhandweaponenabled())
		{
			continue;
		}

		self [[ param_01 ]](maps\mp\_utility::func_27AF("_specialty_blastshield"));
	}
}

//Function Number: 24
perkusedeathtracker()
{
	self endon("disconnect");
	self waittill("death");
	self._useperkenabled = undefined;
}

//Function Number: 25
func_293B()
{
}

//Function Number: 26
func_293C()
{
	self notify("end_perkUseTracker");
}

//Function Number: 27
func_2939()
{
	if(isdefined(self.endgame))
	{
		return;
	}

	self.maxhealth = maps\mp\gametypes\_tweakables::func_270D("player","maxhealth") * 4;
	self.health = self.maxhealth;
	self.endgame = 1;
	self.attackertable[0] = "";
	self visionsetnakedforplayer("end_game",5);
	thread func_2A42(7);
	maps\mp\gametypes\_gamelogic::sethasdonecombat(self,1);
}

//Function Number: 28
func_293A()
{
	self notify("stopEndGame");
	self.endgame = undefined;
	func_2A3F();
	if(!isdefined(self.endgametimer))
	{
		return;
	}

	self.endgametimer maps\mp\gametypes\_hud_util::destroyelem();
	self.endgameicon maps\mp\gametypes\_hud_util::destroyelem();
}

//Function Number: 29
func_2A3F()
{
	if(isdefined(level.nukedetonated))
	{
		self visionsetnakedforplayer(level.nukevisionset,1);
		return;
	}

	self visionsetnakedforplayer("",1);
}

//Function Number: 30
func_2A42(param_00)
{
	self endon("death");
	self endon("disconnect");
	self endon("joined_team");
	level endon("game_ended");
	self endon("stopEndGame");
	wait param_00 + 1;
	maps\mp\_utility::_suicide();
}

//Function Number: 31
func_2925()
{
	thread tracksiegeenable();
	thread func_2A44();
}

//Function Number: 32
tracksiegeenable()
{
	self endon("death");
	self endon("disconnect");
	self endon("stop_trackSiege");
	for(;;)
	{
		self waittill("gambit_on");
		self.movespeedscaler = 0;
		maps\mp\gametypes\_weapons::func_2884();
		var_00 = weaponclass(self getcurrentweapon());
		if(var_00 == "pistol" || var_00 == "smg")
		{
			self setspreadoverride(1);
		}
		else
		{
			self setspreadoverride(2);
		}

		self player_recoilscaleon(0);
		self allowjump(0);
	}
}

//Function Number: 33
func_2A44()
{
	self endon("death");
	self endon("disconnect");
	self endon("stop_trackSiege");
	for(;;)
	{
		self waittill("gambit_off");
		unsetsiege();
	}
}

//Function Number: 34
func_2A45()
{
	self endon("death");
	self endon("disconnect");
	self notifyonplayercommand("adjustedStance","+stance");
	for(;;)
	{
		self waittill("adjustedStance");
		if(self.movespeedscaler != 0)
		{
			continue;
		}

		unsetsiege();
	}
}

//Function Number: 35
func_2A46()
{
	self endon("death");
	self endon("disconnect");
	self notifyonplayercommand("jumped","+goStand");
	for(;;)
	{
		self waittill("jumped");
		if(self.movespeedscaler != 0)
		{
			continue;
		}

		unsetsiege();
	}
}

//Function Number: 36
unsetsiege()
{
	self.movespeedscaler = 1;
	self resetspreadoverride();
	maps\mp\gametypes\_weapons::func_2884();
	self player_recoilscaleoff();
	self allowjump(1);
}

//Function Number: 37
func_2935()
{
	if(!level.hardcoremode)
	{
		self.maxhealth = maps\mp\gametypes\_tweakables::func_270D("player","maxhealth");
		if(isdefined(self.xpscaler) && self.xpscaler == 1 && self.maxhealth > 30)
		{
			self.xpscaler = 2;
		}
	}
}

//Function Number: 38
unsetchallenger()
{
	self.xpscaler = 1;
}

//Function Number: 39
func_2937()
{
	self.objectivescaler = 1.2;
}

//Function Number: 40
func_2938()
{
	self.objectivescaler = 1;
}

//Function Number: 41
setlightweight()
{
	self.movespeedscaler = maps\mp\_utility::func_80F2();
	maps\mp\gametypes\_weapons::func_2884();
}

//Function Number: 42
func_2930()
{
	self.movespeedscaler = 1;
	maps\mp\gametypes\_weapons::func_2884();
}

//Function Number: 43
setblackbox()
{
	self.killstreakscaler = 1.5;
}

//Function Number: 44
func_292E()
{
	self.killstreakscaler = 1;
}

//Function Number: 45
func_2931()
{
	maps\mp\_utility::giveperk("specialty_bulletaccuracy",1);
	maps\mp\_utility::giveperk("specialty_holdbreath",0);
}

//Function Number: 46
unsetsteelnerves()
{
	maps\mp\_utility::func_282E("specialty_bulletaccuracy");
	maps\mp\_utility::func_282E("specialty_holdbreath");
}

//Function Number: 47
func_2933()
{
}

//Function Number: 48
unsetdelaymine()
{
}

//Function Number: 49
func_2A48()
{
	self attachshieldmodel("weapon_riot_shield_mp","tag_shield_back");
}

//Function Number: 50
func_2A49()
{
	self detachshieldmodel("weapon_riot_shield_mp","tag_shield_back");
}

//Function Number: 51
setlocaljammer()
{
	if(!maps\mp\_utility::func_27E5())
	{
		self radarjamon();
	}
}

//Function Number: 52
unsetlocaljammer()
{
	self radarjamoff();
}

//Function Number: 53
func_293D()
{
	thread killstreakthink("ac130",7,"end_ac130Think");
}

//Function Number: 54
unsetac130()
{
	self notify("end_ac130Think");
}

//Function Number: 55
func_293F()
{
	thread killstreakthink("airdrop_sentry_minigun",2,"end_sentry_minigunThink");
}

//Function Number: 56
func_2940()
{
	self notify("end_sentry_minigunThink");
}

//Function Number: 57
func_2943()
{
	thread killstreakthink("tank",6,"end_tankThink");
}

//Function Number: 58
func_2944()
{
	self notify("end_tankThink");
}

//Function Number: 59
setprecision_airstrike()
{
	thread killstreakthink("precision_airstrike",6,"end_precision_airstrike");
}

//Function Number: 60
unsetprecision_airstrike()
{
	self notify("end_precision_airstrike");
}

//Function Number: 61
setpredatormissile()
{
	thread killstreakthink("predator_missile",4,"end_predator_missileThink");
}

//Function Number: 62
func_2942()
{
	self notify("end_predator_missileThink");
}

//Function Number: 63
func_2947()
{
	thread killstreakthink("helicopter_minigun",5,"end_helicopter_minigunThink");
}

//Function Number: 64
unsethelicopterminigun()
{
	self notify("end_helicopter_minigunThink");
}

//Function Number: 65
killstreakthink(param_00,param_01,param_02)
{
	self endon("death");
	self endon("disconnect");
	self endon(param_02);
	for(;;)
	{
		self waittill("killed_enemy");
		if(self.pers["cur_kill_streak"] != param_01)
		{
			continue;
		}

		thread maps\mp\killstreaks\_killstreaks::givekillstreak(param_00);
		thread maps\mp\gametypes\_hud_message::killstreaksplashnotify(param_00,param_01);
	}
}

//Function Number: 66
setthermal()
{
	self thermalvisionon();
}

//Function Number: 67
func_292C()
{
	self thermalvisionoff();
}

//Function Number: 68
func_2949()
{
	thread onemanarmyweaponchangetracker();
}

//Function Number: 69
unsetonemanarmy()
{
	self notify("stop_oneManArmyTracker");
}

//Function Number: 70
onemanarmyweaponchangetracker()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	self endon("stop_oneManArmyTracker");
	for(;;)
	{
		self waittill("weapon_change",var_00);
		if(var_00 != "onemanarmy_mp")
		{
			continue;
		}

		thread func_2A4F();
	}
}

//Function Number: 71
func_2A4E(param_00)
{
	if(param_00 == game["menu_onemanarmy"])
	{
		return 1;
	}

	if(isdefined(game["menu_onemanarmy_defaults_splitscreen"]) && param_00 == game["menu_onemanarmy_defaults_splitscreen"])
	{
		return 1;
	}

	if(isdefined(game["menu_onemanarmy_custom_splitscreen"]) && param_00 == game["menu_onemanarmy_custom_splitscreen"])
	{
		return 1;
	}

	return 0;
}

//Function Number: 72
func_2A4F()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	common_scripts\utility::_disableweaponswitch();
	common_scripts\utility::_disableoffhandweapons();
	common_scripts\utility::_disableusability();
	self openpopupmenu(game["menu_onemanarmy"]);
	thread func_2A50();
	self waittill("menuresponse",var_00,var_01);
	common_scripts\utility::_enableweaponswitch();
	common_scripts\utility::_enableoffhandweapons();
	common_scripts\utility::_enableusability();
	if(var_01 == "back" || !func_2A4E(var_00) || maps\mp\_utility::isusingremote())
	{
		if(self getcurrentweapon() == "onemanarmy_mp")
		{
			common_scripts\utility::_disableweaponswitch();
			common_scripts\utility::_disableoffhandweapons();
			common_scripts\utility::_disableusability();
			self switchtoweapon(common_scripts\utility::getlastweapon());
			self waittill("weapon_change");
			common_scripts\utility::_enableweaponswitch();
			common_scripts\utility::_enableoffhandweapons();
			common_scripts\utility::_enableusability();
		}

		return;
	}

	thread func_2A51(var_01);
}

//Function Number: 73
func_2A50()
{
	self endon("menuresponse");
	self endon("disconnect");
	level endon("game_ended");
	self waittill("death");
	common_scripts\utility::_enableweaponswitch();
	common_scripts\utility::_enableoffhandweapons();
	common_scripts\utility::_enableusability();
	self closepopupmenu();
}

//Function Number: 74
func_2A51(param_00)
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	if(maps\mp\_utility::func_27AF("specialty_omaquickchange"))
	{
		var_01 = 3;
		self playlocalsound("foly_onemanarmy_bag3_plr");
		self playsoundtoteam("foly_onemanarmy_bag3_npc","allies",self);
		self playsoundtoteam("foly_onemanarmy_bag3_npc","axis",self);
	}
	else
	{
		var_01 = 6;
		self playlocalsound("foly_onemanarmy_bag6_plr");
		self playsoundtoteam("foly_onemanarmy_bag6_npc","allies",self);
		self playsoundtoteam("foly_onemanarmy_bag6_npc","axis",self);
	}

	thread omausebar(var_01);
	common_scripts\utility::_disableweapon();
	common_scripts\utility::_disableoffhandweapons();
	common_scripts\utility::_disableusability();
	wait var_01;
	common_scripts\utility::_enableweapon();
	common_scripts\utility::_enableoffhandweapons();
	common_scripts\utility::_enableusability();
	self.omaclasschanged = 1;
	maps\mp\gametypes\_class::func_2A52(self.pers["team"],param_00,0);
	if(isdefined(self.carryflag))
	{
		self attach(self.carryflag,"J_spine4",1);
	}

	self notify("changed_kit");
	level notify("changed_kit");
}

//Function Number: 75
omausebar(param_00)
{
	self endon("disconnect");
	var_01 = maps\mp\gametypes\_hud_util::createprimaryprogressbar(0,-25);
	var_02 = maps\mp\gametypes\_hud_util::createprimaryprogressbartext(0,-25);
	var_02 settext(&"MPUI_CHANGING_KIT");
	var_01 maps\mp\gametypes\_hud_util::updatebar(0,1 / param_00);
	var_03 = 0;
	while(var_03 < param_00 && isalive(self) && !level.gameended)
	{
		wait 0.05;
		var_03 = var_03 + 0.05;
	}

	var_01 maps\mp\gametypes\_hud_util::destroyelem();
	var_02 maps\mp\gametypes\_hud_util::destroyelem();
}

//Function Number: 76
func_2923()
{
	self setweaponhudiconoverride("primaryoffhand","specialty_blastshield");
}

//Function Number: 77
func_2924()
{
	self setweaponhudiconoverride("primaryoffhand","none");
}

//Function Number: 78
func_2927()
{
}

//Function Number: 79
func_2928()
{
}

//Function Number: 80
settacticalinsertion()
{
	self setoffhandsecondaryclass("flash");
	maps\mp\_utility::_giveweapon("flare_mp",0);
	self givestartammo("flare_mp");
	thread func_2A59();
}

//Function Number: 81
func_294E()
{
	self notify("end_monitorTIUse");
}

//Function Number: 82
clearprevioustispawnpoint()
{
	common_scripts\utility::waittill_any("disconnect","joined_team","joined_spectators");
	if(isdefined(self.setspawnpoint))
	{
		func_2A63(self.setspawnpoint);
	}
}

//Function Number: 83
func_2A56()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	self endon("end_monitorTIUse");
	while(maps\mp\_utility::isreallyalive(self))
	{
		if(func_2A58())
		{
			self.tispawnposition = self.origin;
		}

		wait 0.05;
	}
}

//Function Number: 84
func_2A58()
{
	if(canspawn(self.origin) && self isonground())
	{
		return 1;
	}

	return 0;
}

//Function Number: 85
func_2A59()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	self endon("end_monitorTIUse");
	thread func_2A56();
	thread clearprevioustispawnpoint();
	for(;;)
	{
		self waittill("grenade_fire",var_00,var_01);
		if(var_01 != "flare_mp")
		{
			continue;
		}

		if(isdefined(self.setspawnpoint))
		{
			func_2A63(self.setspawnpoint);
		}

		if(!isdefined(self.tispawnposition))
		{
			continue;
		}

		if(maps\mp\_utility::func_2A5A())
		{
			continue;
		}

		var_02 = playerphysicstrace(self.tispawnposition + (0,0,16),self.tispawnposition - (0,0,2048)) + (0,0,1);
		var_03 = spawn("script_model",var_02);
		var_03.angles = self.angles;
		var_03.team = self.team;
		var_03.owner = self;
		var_03.enemytrigger = spawn("script_origin",var_02);
		var_03 thread func_2A5D(self);
		var_03.playerspawnpos = self.tispawnposition;
		var_03 thread maps\mp\gametypes\_weapons::createbombsquadmodel("weapon_light_stick_tactical_bombsquad","tag_fire_fx",level.otherteam[self.team],self);
		self.setspawnpoint = var_03;
	}
}

//Function Number: 86
func_2A5D(param_00)
{
	self setmodel(level.spawnglowmodel["enemy"]);
	if(level.teambased)
	{
		maps\mp\_entityheadicons::setteamheadicon(self.team,(0,0,20));
	}
	else
	{
		maps\mp\_entityheadicons::setplayerheadicon(param_00,(0,0,20));
	}

	thread func_2A5F(param_00);
	thread func_2A65(param_00);
	thread func_2A61(param_00);
	thread glowstickteamupdater(level.otherteam[self.team],level.spawnglow["enemy"],param_00);
	var_01 = spawn("script_model",self.origin + (0,0,0));
	var_01.angles = self.angles;
	var_01 setmodel(level.spawnglowmodel["friendly"]);
	var_01 setcontents(0);
	var_01 thread glowstickteamupdater(self.team,level.spawnglow["friendly"],param_00);
	var_01 playloopsound("emt_road_flare_burn");
	self waittill("death");
	var_01 stoploopsound();
	var_01 delete();
}

//Function Number: 87
glowstickteamupdater(param_00,param_01,param_02)
{
	self endon("death");
	wait 0.05;
	var_03 = self gettagangles("tag_fire_fx");
	var_04 = spawnfx(param_01,self gettagorigin("tag_fire_fx"),anglestoforward(var_03),anglestoup(var_03));
	triggerfx(var_04);
	thread deleteondeath(var_04);
	for(;;)
	{
		self hide();
		var_04 hide();
		foreach(var_06 in level.players)
		{
			if(var_06.team == param_00 && level.teambased)
			{
				self showtoplayer(var_06);
				var_04 showtoplayer(var_06);
				continue;
			}

			if(!level.teambased && var_06 == param_02 && param_01 == level.spawnglow["friendly"])
			{
				self showtoplayer(var_06);
				var_04 showtoplayer(var_06);
				continue;
			}

			if(!level.teambased && var_06 != param_02 && param_01 == level.spawnglow["enemy"])
			{
				self showtoplayer(var_06);
				var_04 showtoplayer(var_06);
			}
		}

		level common_scripts\utility::waittill_either("joined_team","player_spawned");
	}
}

//Function Number: 88
deleteondeath(param_00)
{
	self waittill("death");
	if(isdefined(param_00))
	{
		param_00 delete();
	}
}

//Function Number: 89
func_2A5F(param_00)
{
	self endon("death");
	self setcandamage(1);
	self.health = 999999;
	self.maxhealth = 100;
	self.damagetaken = 0;
	for(;;)
	{
		self waittill("damage",var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09,var_0A);
		if(!maps\mp\gametypes\_weapons::func_27A1(self.owner,var_02))
		{
			continue;
		}

		if(isdefined(var_0A))
		{
			switch(var_0A)
			{
				case "concussion_grenade_mp":
				case "flash_grenade_mp":
				case "smoke_grenade_mp":
					break;
			}
		}

		if(!isdefined(self))
		{
			return;
		}

		if(var_05 == "MOD_MELEE")
		{
			self.damagetaken = self.damagetaken + self.maxhealth;
		}

		if(isdefined(var_09) && var_09 & level.idflags_penetration)
		{
			self.wasdamagedfrombulletpenetration = 1;
		}

		self.wasdamaged = 1;
		self.damagetaken = self.damagetaken + var_01;
		if(isplayer(var_02))
		{
			var_02 maps\mp\gametypes\_damagefeedback::updatedamagefeedback("tactical_insertion");
		}

		if(self.damagetaken >= self.maxhealth)
		{
			if(isdefined(param_00) && var_02 != param_00)
			{
				var_02 notify("destroyed_insertion",param_00);
				var_02 notify("destroyed_explosive");
				param_00 thread maps\mp\_utility::func_2A60("ti_destroyed");
			}

			var_02 thread func_2A63(self);
		}
	}
}

//Function Number: 90
func_2A61(param_00)
{
	self endon("death");
	level endon("game_ended");
	param_00 endon("disconnect");
	self setcursorhint("HINT_NOICON");
	self sethintstring(&"MP_PATCH_PICKUP_TI");
	thread updateenemyuse(param_00);
	for(;;)
	{
		self waittill("trigger",var_01);
		var_01 playsound("chemlight_pu");
		if(!var_01 maps\mp\_utility::isjuggernaut())
		{
			var_01 thread settacticalinsertion();
		}

		var_01 thread func_2A63(self);
	}
}

//Function Number: 91
updateenemyuse(param_00)
{
	self endon("death");
	for(;;)
	{
		maps\mp\_utility::setselfusable(param_00);
		level common_scripts\utility::waittill_either("joined_team","player_spawned");
	}
}

//Function Number: 92
func_2A63(param_00)
{
	if(isdefined(param_00.enemytrigger))
	{
		param_00.enemytrigger delete();
	}

	var_01 = param_00.origin;
	var_02 = param_00.angles;
	param_00 delete();
	var_03 = spawn("script_model",var_01);
	var_03.angles = var_02;
	var_03 setmodel(level.spawnglowmodel["friendly"]);
	var_03 setcontents(0);
	thread func_2A64(var_03);
}

//Function Number: 93
func_2A64(param_00)
{
	wait 2.5;
	param_00 delete();
}

//Function Number: 94
func_2A65(param_00)
{
	self endon("death");
	level endon("game_ended");
	param_00 endon("disconnect");
	self.enemytrigger setcursorhint("HINT_NOICON");
	self.enemytrigger sethintstring(&"MP_PATCH_DESTROY_TI");
	self.enemytrigger maps\mp\_utility::makeenemyusable(param_00);
	for(;;)
	{
		self.enemytrigger waittill("trigger",var_01);
		var_01 notify("destroyed_insertion",param_00);
		var_01 notify("destroyed_explosive");
		if(isdefined(param_00) && var_01 != param_00)
		{
			param_00 thread maps\mp\_utility::func_2A60("ti_destroyed");
		}

		var_01 thread func_2A63(self);
	}
}

//Function Number: 95
setlittlebirdsupport()
{
	thread killstreakthink("littlebird_support",2,"end_littlebird_support_think");
}

//Function Number: 96
func_294C()
{
	self notify("end_littlebird_support_think");
}

//Function Number: 97
func_2980()
{
	if(isplayer(self))
	{
		var_00 = 10;
		if(maps\mp\_utility::func_27AF("specialty_quieter"))
		{
			var_00 = var_00 * 0.5;
		}

		self.painted = 1;
		self setperk("specialty_radararrow",1,0);
		thread func_2A69(var_00);
		thread func_2A68();
	}
}

//Function Number: 98
func_2A68()
{
	self endon("disconnect");
	level endon("game_ended");
	self waittill("death");
	self.painted = 0;
}

//Function Number: 99
func_2A69(param_00)
{
	self notify("painted_again");
	self endon("painted_again");
	self endon("disconnect");
	self endon("death");
	level endon("game_ended");
	wait param_00;
	self.painted = 0;
	self unsetperk("specialty_radararrow",1);
}

//Function Number: 100
ispainted()
{
	return isdefined(self.painted) && self.painted;
}

//Function Number: 101
setfinalstand()
{
	maps\mp\_utility::giveperk("specialty_pistoldeath",0);
}

//Function Number: 102
unsetfinalstand()
{
	maps\mp\_utility::func_282E("specialty_pistoldeath");
}

//Function Number: 103
setcarepackage()
{
	thread maps\mp\killstreaks\_killstreaks::givekillstreak("airdrop_assault",0,0,self,1);
}

//Function Number: 104
unsetcarepackage()
{
}

//Function Number: 105
setuav()
{
	thread maps\mp\killstreaks\_killstreaks::givekillstreak("uav",0,0,self,1);
}

//Function Number: 106
unsetuav()
{
}

//Function Number: 107
func_2971()
{
	maps\mp\_utility::giveperk("specialty_bulletdamage",0);
	thread func_2A6A();
}

//Function Number: 108
func_2A6A()
{
	self notify("watchStoppingPowerKill");
	self endon("watchStoppingPowerKill");
	self endon("disconnect");
	level endon("game_ended");
	self waittill("killed_enemy");
	func_2972();
}

//Function Number: 109
func_2972()
{
	maps\mp\_utility::func_282E("specialty_bulletdamage");
	self notify("watchStoppingPowerKill");
}

//Function Number: 110
func_2969()
{
	if(!maps\mp\_utility::func_27AF("specialty_pistoldeath"))
	{
		maps\mp\_utility::giveperk("specialty_pistoldeath",0);
	}
}

//Function Number: 111
func_296A()
{
	if(maps\mp\_utility::func_27AF("specialty_pistoldeath"))
	{
		maps\mp\_utility::func_282E("specialty_pistoldeath");
	}
}

//Function Number: 112
setjuiced()
{
	self endon("death");
	self endon("faux_spawn");
	self endon("disconnect");
	self endon("unset_juiced");
	level endon("end_game");
	self.isjuiced = 1;
	self.movespeedscaler = 1.25;
	maps\mp\gametypes\_weapons::func_2884();
	if(level.splitscreen)
	{
		var_00 = 56;
		var_01 = 21;
	}
	else
	{
		var_00 = 80;
		var_01 = 32;
	}

	self.juicedtimer = maps\mp\gametypes\_hud_util::createtimer("hudsmall",1);
	self.juicedtimer maps\mp\gametypes\_hud_util::setpoint("CENTER","CENTER",0,var_00);
	self.juicedtimer settimer(7);
	self.juicedtimer.color = (0.8,0.8,0);
	self.juicedtimer.archived = 0;
	self.juicedtimer.foreground = 1;
	self.juicedicon = maps\mp\gametypes\_hud_util::createicon("specialty_juiced",var_01,var_01);
	self.juicedicon.alpha = 0;
	self.juicedicon maps\mp\gametypes\_hud_util::setparent(self.juicedtimer);
	self.juicedicon maps\mp\gametypes\_hud_util::setpoint("BOTTOM","TOP");
	self.juicedicon.archived = 1;
	self.juicedicon.sort = 1;
	self.juicedicon.foreground = 1;
	self.juicedicon fadeovertime(1);
	self.juicedicon.alpha = 0.85;
	thread func_2A6F();
	thread unsetjuicedonride();
	wait 5;
	if(isdefined(self.juicedicon))
	{
		self.juicedicon fadeovertime(2);
		self.juicedicon.alpha = 0;
	}

	if(isdefined(self.juicedtimer))
	{
		self.juicedtimer fadeovertime(2);
		self.juicedtimer.alpha = 0;
	}

	wait 2;
	func_296E();
}

//Function Number: 113
func_296E(param_00)
{
	if(!isdefined(param_00))
	{
		if(maps\mp\_utility::isjuggernaut())
		{
			if(isdefined(self.juggmovespeedscaler))
			{
				self.movespeedscaler = self.juggmovespeedscaler;
			}
			else
			{
				self.movespeedscaler = 0.7;
			}
		}
		else
		{
			self.movespeedscaler = 1;
			if(maps\mp\_utility::func_27AF("specialty_lightweight"))
			{
				self.movespeedscaler = maps\mp\_utility::func_80F2();
			}
		}

		maps\mp\gametypes\_weapons::func_2884();
	}

	if(isdefined(self.juicedicon))
	{
		self.juicedicon destroy();
	}

	if(isdefined(self.juicedtimer))
	{
		self.juicedtimer destroy();
	}

	self.isjuiced = undefined;
	self notify("unset_juiced");
}

//Function Number: 114
unsetjuicedonride()
{
	self endon("disconnect");
	self endon("unset_juiced");
	for(;;)
	{
		wait 0.05;
		if(maps\mp\_utility::isusingremote())
		{
			thread func_296E();
			break;
		}
	}
}

//Function Number: 115
func_2A6F()
{
	self endon("disconnect");
	self endon("unset_juiced");
	common_scripts\utility::waittill_any("death","faux_spawn");
	thread func_296E(1);
}

//Function Number: 116
setcombathigh()
{
	self endon("death");
	self endon("disconnect");
	self endon("unset_combathigh");
	level endon("end_game");
	self.damageblockedtotal = 0;
	if(level.splitscreen)
	{
		var_00 = 56;
		var_01 = 21;
	}
	else
	{
		var_00 = 112;
		var_01 = 32;
	}

	if(isdefined(self.juicedtimer))
	{
		self.juicedtimer destroy();
	}

	if(isdefined(self.juicedicon))
	{
		self.juicedicon destroy();
	}

	self.combathighoverlay = newclienthudelem(self);
	self.combathighoverlay.x = 0;
	self.combathighoverlay.y = 0;
	self.combathighoverlay.alignx = "left";
	self.combathighoverlay.aligny = "top";
	self.combathighoverlay.horzalign = "fullscreen";
	self.combathighoverlay.vertalign = "fullscreen";
	self.combathighoverlay setshader("combathigh_overlay",640,480);
	self.combathighoverlay.sort = -10;
	self.combathighoverlay.archived = 1;
	self.combathightimer = maps\mp\gametypes\_hud_util::createtimer("hudsmall",1);
	self.combathightimer maps\mp\gametypes\_hud_util::setpoint("CENTER","CENTER",0,var_00);
	self.combathightimer settimer(10);
	self.combathightimer.color = (0.8,0.8,0);
	self.combathightimer.archived = 0;
	self.combathightimer.foreground = 1;
	self.combathighicon = maps\mp\gametypes\_hud_util::createicon("specialty_painkiller",var_01,var_01);
	self.combathighicon.alpha = 0;
	self.combathighicon maps\mp\gametypes\_hud_util::setparent(self.combathightimer);
	self.combathighicon maps\mp\gametypes\_hud_util::setpoint("BOTTOM","TOP");
	self.combathighicon.archived = 1;
	self.combathighicon.sort = 1;
	self.combathighicon.foreground = 1;
	self.combathighoverlay.alpha = 0;
	self.combathighoverlay fadeovertime(1);
	self.combathighicon fadeovertime(1);
	self.combathighoverlay.alpha = 1;
	self.combathighicon.alpha = 0.85;
	thread unsetcombathighondeath();
	thread func_2A74();
	wait 8;
	self.combathighicon fadeovertime(2);
	self.combathighicon.alpha = 0;
	self.combathighoverlay fadeovertime(2);
	self.combathighoverlay.alpha = 0;
	self.combathightimer fadeovertime(2);
	self.combathightimer.alpha = 0;
	wait 2;
	self.damageblockedtotal = undefined;
	maps\mp\_utility::func_282E("specialty_combathigh");
}

//Function Number: 117
unsetcombathighondeath()
{
	self endon("disconnect");
	self endon("unset_combathigh");
	self waittill("death");
	thread maps\mp\_utility::func_282E("specialty_combathigh");
}

//Function Number: 118
func_2A74()
{
	self endon("disconnect");
	self endon("unset_combathigh");
	for(;;)
	{
		wait 0.05;
		if(maps\mp\_utility::isusingremote())
		{
			thread maps\mp\_utility::func_282E("specialty_combathigh");
			break;
		}
	}
}

//Function Number: 119
unsetcombathigh()
{
	self notify("unset_combathigh");
	self.combathighoverlay destroy();
	self.combathighicon destroy();
	self.combathightimer destroy();
}

//Function Number: 120
func_2965()
{
	thread givelightarmor();
}

//Function Number: 121
givelightarmor()
{
	self notify("give_light_armor");
	self endon("give_light_armor");
	self endon("death");
	self endon("disconnect");
	level endon("end_game");
	if(isdefined(self.haslightarmor) && self.haslightarmor == 1)
	{
		removelightarmor(self.previousmaxhealth);
	}

	var_00 = 200;
	thread removelightarmorondeath();
	self.haslightarmor = 1;
	self.combathighoverlay = newclienthudelem(self);
	self.combathighoverlay.x = 0;
	self.combathighoverlay.y = 0;
	self.combathighoverlay.alignx = "left";
	self.combathighoverlay.aligny = "top";
	self.combathighoverlay.horzalign = "fullscreen";
	self.combathighoverlay.vertalign = "fullscreen";
	self.combathighoverlay setshader("combathigh_overlay",640,480);
	self.combathighoverlay.sort = -10;
	self.combathighoverlay.archived = 1;
	self.previousmaxhealth = self.maxhealth;
	self.maxhealth = var_00;
	self.health = self.maxhealth;
	var_01 = 50;
	var_02 = self.health;
	for(;;)
	{
		if(self.maxhealth != var_00)
		{
			removelightarmor();
			break;
		}

		if(self.health < 100)
		{
			removelightarmor(self.previousmaxhealth);
			break;
		}

		if(self.health < var_02)
		{
			var_01 = var_01 - var_02 - self.health;
			var_02 = self.health;
			if(var_01 <= 0)
			{
				removelightarmor(self.previousmaxhealth);
				break;
			}
		}

		wait 0.5;
	}
}

//Function Number: 122
removelightarmorondeath()
{
	self endon("disconnect");
	self endon("give_light_armor");
	self endon("remove_light_armor");
	self waittill("death");
	removelightarmor();
}

//Function Number: 123
removelightarmor(param_00)
{
	if(isdefined(param_00))
	{
		self.maxhealth = param_00;
	}

	if(isdefined(self.combathighoverlay))
	{
		self.combathighoverlay destroy();
	}

	self.haslightarmor = undefined;
	self notify("remove_light_armor");
}

//Function Number: 124
unsetlightarmor()
{
	thread removelightarmor(self.previousmaxhealth);
}

//Function Number: 125
setrevenge()
{
	self notify("stopRevenge");
	wait 0.05;
	if(!isdefined(self.lastkilledby))
	{
		return;
	}

	if(level.teambased && self.team == self.lastkilledby.team)
	{
		return;
	}

	var_00 = spawnstruct();
	var_00.showto = self;
	var_00.icon = "compassping_revenge";
	var_00.offset = (0,0,64);
	var_00.width = 10;
	var_00.height = 10;
	var_00.archived = 0;
	var_00.delay = 1.5;
	var_00.constantsize = 0;
	var_00.pintoscreenedge = 1;
	var_00.fadeoutpinnedicon = 0;
	var_00.is3d = 0;
	self.revengeparams = var_00;
	self.lastkilledby maps\mp\_entityheadicons::func_277C(var_00.showto,var_00.icon,var_00.offset,var_00.width,var_00.height,var_00.archived,var_00.delay,var_00.constantsize,var_00.pintoscreenedge,var_00.fadeoutpinnedicon,var_00.is3d);
	thread func_2A80();
	thread watchrevengekill();
	thread func_2A82();
	thread watchrevengevictimdisconnected();
	thread func_2A83();
}

//Function Number: 126
func_2A80()
{
	self endon("stopRevenge");
	self endon("disconnect");
	var_00 = self.lastkilledby;
	for(;;)
	{
		var_00 waittill("spawned_player");
		var_00 maps\mp\_entityheadicons::func_277C(self.revengeparams.showto,self.revengeparams.icon,self.revengeparams.offset,self.revengeparams.width,self.revengeparams.height,self.revengeparams.archived,self.revengeparams.delay,self.revengeparams.constantsize,self.revengeparams.pintoscreenedge,self.revengeparams.fadeoutpinnedicon,self.revengeparams.is3d);
	}
}

//Function Number: 127
watchrevengekill()
{
	self endon("stopRevenge");
	self waittill("killed_enemy");
	self notify("stopRevenge");
}

//Function Number: 128
func_2A82()
{
	self endon("stopRevenge");
	self.lastkilledby waittill("disconnect");
	self notify("stopRevenge");
}

//Function Number: 129
func_2A83()
{
	var_00 = self.lastkilledby;
	self waittill("stopRevenge");
	if(!isdefined(var_00))
	{
		return;
	}

	foreach(var_02 in var_00.entityheadicons)
	{
		if(!isdefined(var_02))
		{
			continue;
		}

		var_02 destroy();
	}
}

//Function Number: 130
watchrevengevictimdisconnected()
{
	var_00 = self.objidfriendly;
	var_01 = self.lastkilledby;
	var_01 endon("disconnect");
	level endon("game_ended");
	self endon("stopRevenge");
	self waittill("disconnect");
	if(!isdefined(var_01))
	{
		return;
	}

	foreach(var_03 in var_01.entityheadicons)
	{
		if(!isdefined(var_03))
		{
			continue;
		}

		var_03 destroy();
	}
}

//Function Number: 131
unsetrevenge()
{
	self notify("stopRevenge");
}