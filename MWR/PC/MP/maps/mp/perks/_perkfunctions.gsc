/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\perks\_perkfunctions.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 85
 * Decompile Time: 1308 ms
 * Timestamp: 10/27/2023 2:42:30 AM
*******************************************************************/

//Function Number: 1
setcrouchmovement()
{
	thread crouchstatelistener();
	crouchmovementsetspeed();
}

//Function Number: 2
crouchstatelistener()
{
	self endon("death");
	self endon("disconnect");
	self endon("unsetCrouchMovement");
	self notifyonplayercommand("adjustedStance","+stance");
	self notifyonplayercommand("adjustedStance","+goStand");
	for(;;)
	{
		common_scripts\utility::waittill_any("adjustedStance","sprint_begin","weapon_change");
		wait(0.5);
		crouchmovementsetspeed();
	}
}

//Function Number: 3
crouchmovementsetspeed()
{
	self.stancecrouchmovement = self getstance();
	var_00 = 0;
	if(self.stancecrouchmovement == "crouch")
	{
		var_00 = self.crouch_speed_scalar;
	}
	else if(maps\mp\_utility::_hasperk("specialty_lightweight"))
	{
		var_00 = maps\mp\_utility::lightweightscalar();
	}

	self.movespeedscaler = var_00;
	maps\mp\gametypes\_weapons::updatemovespeedscale();
}

//Function Number: 4
unsetcrouchmovement()
{
	self notify("unsetCrouchMovement");
	var_00 = 1;
	if(maps\mp\_utility::_hasperk("specialty_lightweight"))
	{
		var_00 = maps\mp\_utility::lightweightscalar();
	}

	self.movespeedscaler = var_00;
	maps\mp\gametypes\_weapons::updatemovespeedscale();
}

//Function Number: 5
setpersonaluav()
{
	var_00 = spawn("script_model",self.origin);
	var_00.team = self.team;
	var_00 makeportableradar(self);
	self.personalradar = var_00;
	thread radarmover(var_00);
}

//Function Number: 6
radarmover(param_00)
{
	level endon("game_ended");
	self endon("disconnect");
	self endon("personal_uav_remove");
	self endon("personal_uav_removed");
	for(;;)
	{
		param_00 moveto(self.origin,0.05);
		wait(0.05);
	}
}

//Function Number: 7
unsetpersonaluav()
{
	if(isdefined(self.personalradar))
	{
		self notify("personal_uav_removed");
		level maps\mp\gametypes\_portable_radar::deleteportableradar(self.personalradar);
		self.personalradar = undefined;
	}
}

//Function Number: 8
setoverkillpro()
{
}

//Function Number: 9
unsetoverkillpro()
{
}

//Function Number: 10
setempimmune()
{
}

//Function Number: 11
unsetempimmune()
{
}

//Function Number: 12
setautospot()
{
	autospotadswatcher();
	autospotdeathwatcher();
}

//Function Number: 13
autospotdeathwatcher()
{
	self waittill("death");
	self endon("disconnect");
	self endon("endAutoSpotAdsWatcher");
	level endon("game_ended");
	self autospotoverlayoff();
}

//Function Number: 14
unsetautospot()
{
	self notify("endAutoSpotAdsWatcher");
	self autospotoverlayoff();
}

//Function Number: 15
autospotadswatcher()
{
	self endon("death");
	self endon("disconnect");
	self endon("endAutoSpotAdsWatcher");
	level endon("game_ended");
	var_00 = 0;
	for(;;)
	{
		wait(0.05);
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

//Function Number: 16
setregenspeed()
{
}

//Function Number: 17
unsetregenspeed()
{
}

//Function Number: 18
setsharpfocus()
{
	self setviewkickscale(0.5);
}

//Function Number: 19
unsetsharpfocus()
{
	self setviewkickscale(1);
}

//Function Number: 20
setdoubleload()
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

//Function Number: 21
unsetdoubleload()
{
	self notify("endDoubleLoad");
}

//Function Number: 22
setmarksman(param_00)
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	if(!isdefined(param_00))
	{
		param_00 = 10;
	}
	else
	{
		param_00 = int(param_00) * 2;
	}

	maps\mp\_utility::setrecoilscale(param_00);
	self.recoilscale = param_00;
}

//Function Number: 23
unsetmarksman()
{
	maps\mp\_utility::setrecoilscale(0);
	self.recoilscale = 0;
}

//Function Number: 24
setstunresistance(param_00)
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	if(!isdefined(param_00))
	{
		self.stunscaler = 0.5;
		return;
	}

	self.stunscaler = int(param_00) / 10;
}

//Function Number: 25
unsetstunresistance()
{
	self.stunscaler = 1;
}

//Function Number: 26
setsteadyaimpro()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	self setaimspreadmovementscale(0.5);
}

//Function Number: 27
unsetsteadyaimpro()
{
	self notify("end_SteadyAimPro");
	self setaimspreadmovementscale(1);
}

//Function Number: 28
blastshieldusetracker(param_00,param_01)
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

		self [[ param_01 ]](maps\mp\_utility::_hasperk("specialty_blastshield2"));
	}
}

//Function Number: 29
perkusedeathtracker()
{
	self endon("disconnect");
	self waittill("death");
	self._useperkenabled = undefined;
}

//Function Number: 30
setrearview()
{
}

//Function Number: 31
unsetrearview()
{
	self notify("end_perkUseTracker");
}

//Function Number: 32
setendgame()
{
	if(isdefined(self.endgame))
	{
		return;
	}

	self.maxhealth = maps\mp\gametypes\_tweakables::gettweakablevalue("player","maxhealth") * 4;
	self.health = self.maxhealth;
	self.endgame = 1;
	self.attackertable[0] = "";
	self visionsetnakedforplayer("end_game",5);
	thread endgamedeath(7);
	self.hasdonecombat = 1;
}

//Function Number: 33
unsetendgame()
{
	self notify("stopEndGame");
	self.endgame = undefined;
	maps\mp\_utility::revertvisionsetforplayer();
	if(!isdefined(self.endgametimer))
	{
		return;
	}

	self.endgametimer maps\mp\gametypes\_hud_util::destroyelem();
	self.endgameicon maps\mp\gametypes\_hud_util::destroyelem();
}

//Function Number: 34
endgamedeath(param_00)
{
	self endon("death");
	self endon("disconnect");
	self endon("joined_team");
	level endon("game_ended");
	self endon("stopEndGame");
	wait(param_00 + 1);
	maps\mp\_utility::_suicide();
}

//Function Number: 35
stancestatelistener()
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

//Function Number: 36
jumpstatelistener()
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

//Function Number: 37
unsetsiege()
{
	self.movespeedscaler = level.baseplayermovescale;
	self resetspreadoverride();
	maps\mp\gametypes\_weapons::updatemovespeedscale();
	self player_recoilscaleoff();
	self allowjump(1);
}

//Function Number: 38
setsaboteur()
{
	self.objectivescaler = 2;
}

//Function Number: 39
unsetsaboteur()
{
	self.objectivescaler = 1;
}

//Function Number: 40
setlightweight(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 10;
	}

	self.movespeedscaler = maps\mp\_utility::lightweightscalar(param_00);
	maps\mp\gametypes\_weapons::updatemovespeedscale();
}

//Function Number: 41
unsetlightweight()
{
	self.movespeedscaler = level.baseplayermovescale;
	maps\mp\gametypes\_weapons::updatemovespeedscale();
}

//Function Number: 42
setblackbox()
{
	self.killstreakscaler = 1.5;
}

//Function Number: 43
unsetblackbox()
{
	self.killstreakscaler = 1;
}

//Function Number: 44
setsteelnerves()
{
	maps\mp\_utility::giveperk("specialty_bulletaccuracy",1);
	maps\mp\_utility::giveperk("specialty_holdbreath",0);
}

//Function Number: 45
unsetsteelnerves()
{
	maps\mp\_utility::_unsetperk("specialty_bulletaccuracy");
	maps\mp\_utility::_unsetperk("specialty_holdbreath");
}

//Function Number: 46
setdelaymine()
{
}

//Function Number: 47
unsetdelaymine()
{
}

//Function Number: 48
setlocaljammer()
{
	if(!maps\mp\_utility::isemped())
	{
		self setmotiontrackervisible(0);
	}
}

//Function Number: 49
unsetlocaljammer()
{
	self setmotiontrackervisible(1);
}

//Function Number: 50
setthermal()
{
	self thermalvisionon();
}

//Function Number: 51
unsetthermal()
{
	self thermalvisionoff();
}

//Function Number: 52
setonemanarmy()
{
	thread onemanarmyweaponchangetracker();
}

//Function Number: 53
unsetonemanarmy()
{
	self notify("stop_oneManArmyTracker");
}

//Function Number: 54
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

		thread selectonemanarmyclass();
	}
}

//Function Number: 55
isonemanarmymenu(param_00)
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

//Function Number: 56
selectonemanarmyclass()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	common_scripts\utility::_disableweaponswitch();
	common_scripts\utility::_disableoffhandweapons();
	common_scripts\utility::_disableusability();
	self openpopupmenu(game["menu_onemanarmy"]);
	thread closeomamenuondeath();
	self waittill("menuresponse",var_00,var_01);
	common_scripts\utility::_enableweaponswitch();
	common_scripts\utility::_enableoffhandweapons();
	common_scripts\utility::_enableusability();
	if(var_01 == "back" || !isonemanarmymenu(var_00) || maps\mp\_utility::isusingremote())
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

	thread giveonemanarmyclass(var_01);
}

//Function Number: 57
closeomamenuondeath()
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

//Function Number: 58
giveonemanarmyclass(param_00)
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	if(maps\mp\_utility::_hasperk("specialty_omaquickchange"))
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
	wait(var_01);
	common_scripts\utility::_enableweapon();
	common_scripts\utility::_enableoffhandweapons();
	common_scripts\utility::_enableusability();
	self.omaclasschanged = 1;
	maps\mp\gametypes\_class::giveandapplyloadout(self.pers["team"],param_00,0);
	if(isdefined(self.carryflag))
	{
		self attach(self.carryflag,"J_spine4",1);
	}

	self notify("changed_kit");
	level notify("changed_kit");
}

//Function Number: 59
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
		wait(0.05);
		var_03 = var_03 + 0.05;
	}

	var_01 maps\mp\gametypes\_hud_util::destroyelem();
	var_02 maps\mp\gametypes\_hud_util::destroyelem();
}

//Function Number: 60
setblastshield()
{
	self setweaponhudiconoverride("primaryoffhand","specialty_s1_temp");
}

//Function Number: 61
unsetblastshield()
{
	self setweaponhudiconoverride("primaryoffhand","none");
}

//Function Number: 62
setfreefall()
{
}

//Function Number: 63
unsetfreefall()
{
}

//Function Number: 64
setpainted(param_00)
{
	if(isplayer(self))
	{
		if(isdefined(param_00.specialty_paint_time) && !maps\mp\_utility::_hasperk("specialty_coldblooded"))
		{
			self.painted = 1;
			self setperk("specialty_radararrow",1,0);
			thread unsetpainted(param_00.specialty_paint_time);
			thread watchpainteddeath();
		}
	}
}

//Function Number: 65
watchpainteddeath()
{
	self endon("disconnect");
	level endon("game_ended");
	self endon("unsetPainted");
	self waittill("death");
	self.painted = 0;
}

//Function Number: 66
unsetpainted(param_00)
{
	self notify("painted_again");
	self endon("painted_again");
	self endon("disconnect");
	self endon("death");
	level endon("game_ended");
	wait(param_00);
	self.painted = 0;
	self unsetperk("specialty_radararrow",1);
	self notify("unsetPainted");
}

//Function Number: 67
ispainted()
{
	return isdefined(self.painted) && self.painted;
}

//Function Number: 68
setrefillgrenades()
{
	if(isdefined(self.primarygrenade))
	{
		self givemaxammo(self.primarygrenade);
	}

	if(isdefined(self.secondarygrenade))
	{
		self givemaxammo(self.secondarygrenade);
	}
}

//Function Number: 69
setfinalstand()
{
	maps\mp\_utility::giveperk("specialty_pistoldeath",0);
}

//Function Number: 70
unsetfinalstand()
{
	maps\mp\_utility::_unsetperk("specialty_pistoldeath");
}

//Function Number: 71
setuav()
{
}

//Function Number: 72
unsetuav()
{
}

//Function Number: 73
setstoppingpower()
{
	maps\mp\_utility::giveperk("specialty_bulletdamage",0);
	thread watchstoppingpowerkill();
}

//Function Number: 74
watchstoppingpowerkill()
{
	self notify("watchStoppingPowerKill");
	self endon("watchStoppingPowerKill");
	self endon("disconnect");
	level endon("game_ended");
	self waittill("killed_enemy");
	unsetstoppingpower();
}

//Function Number: 75
unsetstoppingpower()
{
	maps\mp\_utility::_unsetperk("specialty_bulletdamage");
	self notify("watchStoppingPowerKill");
}

//Function Number: 76
setjuiced(param_00,param_01,param_02)
{
	self endon("death");
	self endon("faux_spawn");
	self endon("disconnect");
	self endon("unset_juiced");
	level endon("end_game");
	self.isjuiced = 1;
	if(!isdefined(param_00))
	{
		param_00 = 1.25;
	}

	self.movespeedscaler = param_00;
	maps\mp\gametypes\_weapons::updatemovespeedscale();
	if(level.splitscreen)
	{
		var_03 = 56;
		var_04 = 21;
	}
	else
	{
		var_03 = 80;
		var_04 = 32;
	}

	if(!isdefined(param_01))
	{
		param_01 = 7;
	}

	if(!isdefined(param_02) || param_02 == 1)
	{
		self.juicedtimer = maps\mp\gametypes\_hud_util::createtimer("hudsmall",1);
		self.juicedtimer maps\mp\gametypes\_hud_util::setpoint("CENTER","CENTER",0,var_03);
		self.juicedtimer settimer(param_01);
		self.juicedtimer.color = (0.8,0.8,0);
		self.juicedtimer.archived = 0;
		self.juicedtimer.foreground = 1;
		self.juicedicon = maps\mp\gametypes\_hud_util::createicon(level.specialty_juiced_icon,var_04,var_04);
		self.juicedicon.alpha = 0;
		self.juicedicon maps\mp\gametypes\_hud_util::setparent(self.juicedtimer);
		self.juicedicon maps\mp\gametypes\_hud_util::setpoint("BOTTOM","TOP");
		self.juicedicon.archived = 1;
		self.juicedicon.sort = 1;
		self.juicedicon.foreground = 1;
		self.juicedicon fadeovertime(1);
		self.juicedicon.alpha = 0.85;
	}

	thread unsetjuicedondeath();
	thread unsetjuicedonride();
	wait(param_01 - 2);
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

	wait(2);
	unsetjuiced();
}

//Function Number: 77
unsetjuiced(param_00)
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
			self.movespeedscaler = level.baseplayermovescale;
			if(maps\mp\_utility::_hasperk("specialty_lightweight"))
			{
				self.movespeedscaler = maps\mp\_utility::lightweightscalar();
			}
		}

		maps\mp\gametypes\_weapons::updatemovespeedscale();
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

//Function Number: 78
unsetjuicedonride()
{
	self endon("disconnect");
	self endon("unset_juiced");
	for(;;)
	{
		wait(0.05);
		if(maps\mp\_utility::isusingremote())
		{
			thread unsetjuiced();
			break;
		}
	}
}

//Function Number: 79
unsetjuicedondeath()
{
	self endon("disconnect");
	self endon("unset_juiced");
	common_scripts\utility::waittill_any("death","faux_spawn");
	thread unsetjuiced(1);
}

//Function Number: 80
setlightarmorhp(param_00)
{
	if(isdefined(param_00))
	{
		self.lightarmorhp = param_00;
		if(isplayer(self) && isdefined(self.maxlightarmorhp) && self.maxlightarmorhp > 0)
		{
			var_01 = clamp(self.lightarmorhp / self.maxlightarmorhp,0,1);
			self setclientomnvar("ui_light_armor_percent",var_01);
			return;
		}

		return;
	}

	self.lightarmorhp = undefined;
	self.maxlightarmorhp = undefined;
	self setclientomnvar("ui_light_armor_percent",0);
}

//Function Number: 81
setlightarmor(param_00)
{
	self notify("give_light_armor");
	if(isdefined(self.lightarmorhp))
	{
		unsetlightarmor();
	}

	thread removelightarmorondeath();
	thread removelightarmoronmatchend();
	if(isdefined(param_00))
	{
		self.maxlightarmorhp = param_00;
	}
	else
	{
		self.maxlightarmorhp = 150;
	}

	setlightarmorhp(self.maxlightarmorhp);
}

//Function Number: 82
removelightarmorondeath()
{
	self endon("disconnect");
	self endon("give_light_armor");
	self endon("remove_light_armor");
	self waittill("death");
	unsetlightarmor();
}

//Function Number: 83
unsetlightarmor()
{
	setlightarmorhp(undefined);
	self notify("remove_light_armor");
}

//Function Number: 84
removelightarmoronmatchend()
{
	self endon("disconnect");
	self endon("remove_light_armor");
	level common_scripts\utility::waittill_any("round_end_finished","game_ended");
	thread unsetlightarmor();
}

//Function Number: 85
haslightarmor()
{
	return isdefined(self.lightarmorhp) && self.lightarmorhp > 0;
}