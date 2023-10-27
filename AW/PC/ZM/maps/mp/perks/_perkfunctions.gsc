/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps/mp/perks/_perkfunctions.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 101
 * Decompile Time: 1608 ms
 * Timestamp: 10/27/2023 2:10:12 AM
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
	if(isdefined(self.adrenaline_speed_scalar))
	{
		var_00 = self.adrenaline_speed_scalar;
	}
	else if(self.stancecrouchmovement == "crouch")
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
			var_06 = self setweaponammostock(var_02);
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

		self [[ param_01 ]](maps\mp\_utility::_hasperk("_specialty_blastshield"));
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
	self playerrecoilscaleoff();
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
settacticalinsertion()
{
	maps\mp\_utility::_giveweapon("s1_tactical_insertion_device_mp",0);
	self givestartammo("s1_tactical_insertion_device_mp");
	thread monitortiuse();
}

//Function Number: 65
clearprevioustispawnpoint()
{
	self notify("clearPreviousTISpawnpointStarted");
	self endon("clearPreviousTISpawnpointStarted");
	common_scripts\utility::waittill_any("disconnect","joined_team","joined_spectators");
	if(isdefined(self.setspawnpoint))
	{
		deleteti(self.setspawnpoint);
	}
}

//Function Number: 66
updatetispawnposition()
{
	self endon("death");
	self endon("disconnect");
	self endon("faux_spawn");
	level endon("game_ended");
	while(maps\mp\_utility::isreallyalive(self))
	{
		if(isvalidtispawnposition())
		{
			self.tispawnposition = self.origin;
		}

		wait(0.05);
	}
}

//Function Number: 67
isvalidtispawnposition()
{
	if(canspawn(self.origin) && self isonground())
	{
		return 1;
	}

	return 0;
}

//Function Number: 68
monitortiuse()
{
	self endon("death");
	self endon("disconnect");
	self endon("faux_spawn");
	level endon("game_ended");
	thread clearprevioustispawnpoint();
	thread updatetispawnposition();
	thread monitorthirdpersonmodel();
	for(;;)
	{
		self waittill("grenade_fire",var_00,var_01);
		if(var_01 != "s1_tactical_insertion_device_mp")
		{
			continue;
		}

		if(isdefined(self.setspawnpoint))
		{
			deleteti(self.setspawnpoint);
		}

		if(!isdefined(self.tispawnposition))
		{
			continue;
		}

		if(maps\mp\_utility::touchingbadtrigger())
		{
			continue;
		}

		var_02 = playerphysicstrace(self.tispawnposition + (0,0,16),self.tispawnposition - (0,0,2048)) + (0,0,1);
		var_03 = spawn("script_model",var_02);
		var_03.angles = self.angles;
		var_03.team = self.team;
		var_03.owner = self;
		var_03.enemytrigger = spawn("script_origin",var_02);
		var_03 thread glowsticksetupandwaitfordeath(self);
		var_03.playerspawnpos = self.tispawnposition;
		var_03 setotherent(self);
		var_03 common_scripts\utility::make_entity_sentient_mp(self.team,1);
		var_03 playloopsound("tac_insert_spark_lp");
		self.setspawnpoint = var_03;
	}
}

//Function Number: 69
monitorthirdpersonmodel()
{
	self notify("third_person_ti");
	self endon("third_person_ti");
	for(;;)
	{
		if(isdefined(self.attachmodelti))
		{
			self detach("npc_tactical_insertion_device","tag_inhand");
			self.attachmodelti = undefined;
		}

		self waittillmatch("s1_tactical_insertion_device_mp","grenade_pullback");
		self attach("npc_tactical_insertion_device","tag_inhand",1);
		self.attachmodelti = "npc_tactical_insertion_device";
		maps\mp\_utility::waitfortimeornotify(3,"death");
		self detach("npc_tactical_insertion_device","tag_inhand");
		self.attachmodelti = undefined;
	}
}

//Function Number: 70
glowsticksetupandwaitfordeath(param_00)
{
	self setmodel(level.spawnglowmodel["enemy"]);
	thread maps\mp\gametypes\_damage::setentitydamagecallback(100,undefined,::ondeathti,undefined,0);
	thread glowstickenemyuselistener(param_00);
	thread glowstickuselistener(param_00);
	thread glowstickteamupdater(self.team,level.spawnglow["enemy"],param_00);
	var_01 = spawn("script_model",self.origin + (0,0,0));
	var_01.angles = self.angles;
	var_01 setmodel(level.spawnglowmodel["friendly"]);
	var_01 setcontents(0);
	var_01 thread glowstickteamupdater(self.team,level.spawnglow["friendly"],param_00);
	var_01 playloopsound("tac_insert_spark_lp");
	self waittill("death");
	var_01 stoploopsound();
	var_01 delete();
}

//Function Number: 71
glowstickteamupdater(param_00,param_01,param_02)
{
	self endon("death");
	wait(0.05);
	var_03 = self gettagangles("tag_fire_fx");
	var_04 = spawnfx(param_01,self gettagorigin("tag_fire_fx"),anglestoforward(var_03),anglestoup(var_03));
	triggerfx(var_04);
	thread perk_deleteondeath(var_04);
	for(;;)
	{
		self hide();
		var_04 hide();
		foreach(var_06 in level.players)
		{
			if(var_06.team == param_00 && level.teambased && param_01 == level.spawnglow["friendly"])
			{
				self showtoplayer(var_06);
				var_04 showtoplayer(var_06);
				continue;
			}

			if(var_06.team != param_00 && level.teambased && param_01 == level.spawnglow["enemy"])
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

//Function Number: 72
perk_deleteondeath(param_00)
{
	self waittill("death");
	if(isdefined(param_00))
	{
		param_00 delete();
	}
}

//Function Number: 73
ondeathti(param_00,param_01,param_02,param_03)
{
	if(isdefined(self.owner) && param_00 != self.owner)
	{
		param_00 notify("destroyed_explosive");
		param_00 thread maps\mp\gametypes\_missions::processchallenge("ch_darkbringer");
	}

	playfx(level.spawnfire,self.origin);
	self.owner thread maps\mp\_utility::leaderdialogonplayer("ti_destroyed",undefined,undefined,self.origin);
	param_00 thread deleteti(self);
}

//Function Number: 74
glowstickuselistener(param_00)
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
		var_01 playsound("tac_insert_pickup_plr");
		var_01 thread settacticalinsertion();
		var_01 thread deleteti(self);
	}
}

//Function Number: 75
updateenemyuse(param_00)
{
	self endon("death");
	for(;;)
	{
		maps\mp\_utility::setselfusable(param_00);
		level common_scripts\utility::waittill_either("joined_team","player_spawned");
	}
}

//Function Number: 76
deleteti(param_00)
{
	if(isdefined(param_00.enemytrigger))
	{
		param_00.enemytrigger delete();
	}

	param_00 stoploopsound();
	param_00 delete();
}

//Function Number: 77
glowstickenemyuselistener(param_00)
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
		thread ondeathti(var_01);
	}
}

//Function Number: 78
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

//Function Number: 79
watchpainteddeath()
{
	self endon("disconnect");
	level endon("game_ended");
	self endon("unsetPainted");
	self waittill("death");
	self.painted = 0;
}

//Function Number: 80
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

//Function Number: 81
ispainted()
{
	return isdefined(self.painted) && self.painted;
}

//Function Number: 82
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

//Function Number: 83
setfinalstand()
{
	maps\mp\_utility::giveperk("specialty_pistoldeath",0);
}

//Function Number: 84
unsetfinalstand()
{
	maps\mp\_utility::_unsetperk("specialty_pistoldeath");
}

//Function Number: 85
setcarepackage()
{
	thread maps\mp\killstreaks\_killstreaks::givekillstreak("airdrop_assault",0,0,self);
}

//Function Number: 86
unsetcarepackage()
{
}

//Function Number: 87
setuav()
{
	thread maps\mp\killstreaks\_killstreaks::givekillstreak("uav",0,0,self);
}

//Function Number: 88
unsetuav()
{
}

//Function Number: 89
setstoppingpower()
{
	maps\mp\_utility::giveperk("specialty_bulletdamage",0);
	thread watchstoppingpowerkill();
}

//Function Number: 90
watchstoppingpowerkill()
{
	self notify("watchStoppingPowerKill");
	self endon("watchStoppingPowerKill");
	self endon("disconnect");
	level endon("game_ended");
	self waittill("killed_enemy");
	unsetstoppingpower();
}

//Function Number: 91
unsetstoppingpower()
{
	maps\mp\_utility::_unsetperk("specialty_bulletdamage");
	self notify("watchStoppingPowerKill");
}

//Function Number: 92
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

//Function Number: 93
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

//Function Number: 94
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

//Function Number: 95
unsetjuicedondeath()
{
	self endon("disconnect");
	self endon("unset_juiced");
	common_scripts\utility::waittill_any("death","faux_spawn");
	thread unsetjuiced(1);
}

//Function Number: 96
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

//Function Number: 97
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

//Function Number: 98
removelightarmorondeath()
{
	self endon("disconnect");
	self endon("give_light_armor");
	self endon("remove_light_armor");
	self waittill("death");
	unsetlightarmor();
}

//Function Number: 99
unsetlightarmor()
{
	setlightarmorhp(undefined);
	self notify("remove_light_armor");
}

//Function Number: 100
removelightarmoronmatchend()
{
	self endon("disconnect");
	self endon("remove_light_armor");
	level common_scripts\utility::waittill_any("round_end_finished","game_ended");
	thread unsetlightarmor();
}

//Function Number: 101
haslightarmor()
{
	return isdefined(self.lightarmorhp) && self.lightarmorhp > 0;
}