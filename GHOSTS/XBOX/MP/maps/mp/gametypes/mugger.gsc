/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\mugger.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 47
 * Decompile Time: 852 ms
 * Timestamp: 10/27/2023 1:29:21 AM
*******************************************************************/

//Function Number: 1
func_4FDD()
{
	if(getdvar("mapname") == "mp_background")
	{
		return;
	}

	maps\mp\gametypes\_globallogic::func_44DF();
	maps\mp\gametypes\_callbacksetup::func_71F0();
	maps\mp\gametypes\_globallogic::func_71F0();
	if(isusingmatchrulesdata())
	{
		level.initializematchrules = ::initializematchrules;
		[[ level.initializematchrules ]]();
		level thread maps\mp\_utility::func_647E();
	}
	else
	{
		maps\mp\_utility::func_6473(level.gametype,0,0,9);
		maps\mp\_utility::func_6476(level.gametype,7);
		maps\mp\_utility::func_6475(level.gametype,2500);
		maps\mp\_utility::func_6472(level.gametype,1);
		maps\mp\_utility::func_647C(level.gametype,1);
		maps\mp\_utility::func_6470(level.gametype,0);
		maps\mp\_utility::func_646A(level.gametype,0);
		level.matchrules_damagemultiplier = 0;
		level.matchrules_vampirism = 0;
		level.mugger_bank_limit = getdvarint("scr_mugger_bank_limit",10);
	}

	setteammode("ffa");
	level.onprecachegametype = ::onprecachegametype;
	level.onstartgametype = ::onstartgametype;
	level.var_5976 = ::func_5976;
	level.getspawnpoint = ::getspawnpoint;
	level.onnormaldeath = ::onnormaldeath;
	level.onplayerscore = ::onplayerscore;
	level.ontimelimit = ::ontimelimit;
	level.onxpevent = ::onxpevent;
	level.customcratefunc = ::createmuggercrates;
	level.assists_disabled = 1;
	if(level.matchrules_damagemultiplier || level.matchrules_vampirism)
	{
		level.modifyplayerdamage = ::maps\mp\gametypes\_damage::gamemodemodifyplayerdamage;
	}

	level.mugger_fx["vanish"] = loadfx("impacts/small_snowhit");
	level.mugger_fx["smoke"] = loadfx("smoke/airdrop_flare_mp_effect_now");
	level.mugger_targetfxid = loadfx("misc/ui_flagbase_red");
	level thread func_595D();
}

//Function Number: 2
initializematchrules()
{
	maps\mp\_utility::func_700A();
	setdynamicdvar("scr_mugger_roundswitch",0);
	maps\mp\_utility::func_6473("mugger",0,0,9);
	setdynamicdvar("scr_mugger_roundlimit",1);
	maps\mp\_utility::func_6472("mugger",1);
	setdynamicdvar("scr_mugger_winlimit",1);
	maps\mp\_utility::func_647C("mugger",1);
	setdynamicdvar("scr_mugger_halftime",0);
	maps\mp\_utility::func_646A("mugger",0);
	setdynamicdvar("scr_mugger_promode",0);
	level.mugger_bank_limit = getmatchrulesdata("muggerData","bankLimit");
	setdynamicdvar("scr_mugger_bank_limit",level.mugger_bank_limit);
	level.mugger_jackpot_limit = getmatchrulesdata("muggerData","jackpotLimit");
	setdynamicdvar("scr_mugger_jackpot_limit",level.mugger_jackpot_limit);
	level.mugger_throwing_knife_mug_frac = getmatchrulesdata("muggerData","throwKnifeFrac");
	setdynamicdvar("scr_mugger_throwing_knife_mug_frac",level.mugger_throwing_knife_mug_frac);
}

//Function Number: 3
onprecachegametype()
{
	precachemodel("prop_dogtags_foe_iw6");
	precachemodel("weapon_us_smoke_grenade_burnt2");
	precachempanim("mp_dogtag_spin");
	precachematerial("waypoint_dogtags2");
	precachematerial("waypoint_dogtag_pile");
	precachematerial("waypoint_jackpot");
	precachematerial("hud_tagcount");
	function_0207("mugger_mugging");
	function_0207("mugger_mega_mugging");
	function_0207("mugger_you_mugged");
	function_0207("mugger_got_mugged");
	function_0207("mugger_mega_drop");
	function_0207("mugger_muggernaut");
	function_0207("mugger_tags_banked");
	precachestring(&"MPUI_MUGGER_JACKPOT");
}

//Function Number: 4
onstartgametype()
{
	setclientnamemode("auto_change");
	maps\mp\_utility::func_7084("allies",&"OBJECTIVES_MUGGER");
	maps\mp\_utility::func_7084("axis",&"OBJECTIVES_MUGGER");
	if(level.splitscreen)
	{
		maps\mp\_utility::func_7083("allies",&"OBJECTIVES_MUGGER");
		maps\mp\_utility::func_7083("axis",&"OBJECTIVES_MUGGER");
	}
	else
	{
		maps\mp\_utility::func_7083("allies",&"OBJECTIVES_MUGGER_SCORE");
		maps\mp\_utility::func_7083("axis",&"OBJECTIVES_MUGGER_SCORE");
	}

	maps\mp\_utility::setobjectivehinttext("allies",&"OBJECTIVES_MUGGER_HINT");
	maps\mp\_utility::setobjectivehinttext("axis",&"OBJECTIVES_MUGGER_HINT");
	level.spawnmins = (0,0,0);
	level.spawnmaxs = (0,0,0);
	maps\mp\gametypes\_spawnlogic::addspawnpoints("allies","mp_dm_spawn");
	maps\mp\gametypes\_spawnlogic::addspawnpoints("axis","mp_dm_spawn");
	level.mapcenter = maps\mp\gametypes\_spawnlogic::findboxcenter(level.spawnmins,level.spawnmaxs);
	setmapcenter(level.mapcenter);
	level.dogtags = [];
	var_00[0] = level.gametype;
	var_00[1] = "dm";
	maps\mp\gametypes\_gameobjects::func_4FDD(var_00);
	level.mugger_timelimit = getdvarint("scr_mugger_timelimit",7);
	setdynamicdvar("scr_mugger_timeLimit",level.mugger_timelimit);
	maps\mp\_utility::func_6476("mugger",level.mugger_timelimit);
	level.mugger_scorelimit = getdvarint("scr_mugger_scorelimit",2500);
	if(level.mugger_scorelimit == 0)
	{
		level.mugger_scorelimit = 2500;
	}

	setdynamicdvar("scr_mugger_scoreLimit",level.mugger_scorelimit);
	maps\mp\_utility::func_6475("mugger",level.mugger_scorelimit);
	level.mugger_bank_limit = getdvarint("scr_mugger_bank_limit",10);
	level.mugger_muggernaut_window = getdvarint("scr_mugger_muggernaut_window",3000);
	level.mugger_muggernaut_muggings_needed = getdvarint("scr_mugger_muggernaut_muggings_needed",3);
	level.mugger_min_spawn_dist_sq = squared(getdvarfloat("mugger_min_spawn_dist",350));
	level.mugger_jackpot_limit = getdvarint("scr_mugger_jackpot_limit",0);
	level.mugger_jackpot_wait_sec = getdvarfloat("scr_mugger_jackpot_wait_sec",10);
	level.mugger_throwing_knife_mug_frac = getdvarfloat("scr_mugger_throwing_knife_mug_frac",1);
	level func_5503();
	level thread func_5518();
	level thread func_5517();
	createdropzones();
	level.jackpot_zone = spawn("script_model",(0,0,0));
	level.jackpot_zone.origin = (0,0,0);
	level.jackpot_zone.angles = (90,0,0);
	level.jackpot_zone setmodel("weapon_us_smoke_grenade_burnt2");
	level.jackpot_zone hide();
	level.jackpot_zone.mugger_fx_playing = 0;
	level thread func_5513();
}

//Function Number: 5
func_595D()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_00.tags_carried = 0;
		var_00.total_tags_banked = 0;
		var_00.assists = var_00.total_tags_banked;
		var_00.pers["assists"] = var_00.total_tags_banked;
		var_00.game_extrainfo = var_00.tags_carried;
		var_00.muggings = [];
		if(isplayer(var_00) && !botsentientswap(var_00))
		{
			var_00.dogtagsicon = var_00 maps\mp\gametypes\_hud_util::func_20FC("hud_tagcount",48,48);
			var_00.dogtagsicon maps\mp\gametypes\_hud_util::func_70A4("TOP LEFT","TOP LEFT",200,0);
			var_00.dogtagsicon.alpha = 1;
			var_00.dogtagsicon.hidewheninmenu = 1;
			var_00.dogtagsicon.archived = 1;
			level thread hidehudelementongameend(var_00.dogtagsicon);
			var_00.dogtagstext = var_00 maps\mp\gametypes\_hud_util::createfontstring("bigfixed",1);
			var_00.dogtagstext maps\mp\gametypes\_hud_util::func_708F(var_00.dogtagsicon);
			var_00.dogtagstext maps\mp\gametypes\_hud_util::func_70A4("CENTER","CENTER",-24);
			var_00.dogtagstext setvalue(var_00.tags_carried);
			var_00.dogtagstext.alpha = 1;
			var_00.dogtagstext.color = (1,1,0.5);
			var_00.dogtagstext.glowalpha = 1;
			var_00.dogtagstext.sort = 1;
			var_00.dogtagstext.hidewheninmenu = 1;
			var_00.dogtagstext.archived = 1;
			var_00.dogtagstext maps\mp\gametypes\_hud::func_349E(3);
			level thread hidehudelementongameend(var_00.dogtagstext);
		}
	}
}

//Function Number: 6
func_5976()
{
	self.muggings = [];
	if(!isbot(self))
	{
		thread func_8B0F();
	}
}

//Function Number: 7
hidehudelementongameend(param_00)
{
	level waittill("game_ended");
	if(isdefined(param_00))
	{
		param_00.alpha = 0;
	}
}

//Function Number: 8
getspawnpoint()
{
	var_00 = maps\mp\gametypes\_spawnlogic::func_3C41(self.pers["team"]);
	var_01 = maps\mp\gametypes\_spawnscoring::func_3BF0(var_00);
	return var_01;
	return var_01;
}

//Function Number: 9
onxpevent(param_00)
{
	if(isdefined(param_00) && param_00 == "suicide")
	{
		level thread func_7868(self,self);
	}

	maps\mp\gametypes\_globallogic::onxpevent(param_00);
}

//Function Number: 10
onnormaldeath(param_00,param_01,param_02)
{
	level thread func_7868(param_00,param_01);
	if(game["state"] == "postgame" && game["teamScores"][param_01.team] > game["teamScores"][level.otherteam[param_01.team]])
	{
		param_01.finalkill = 1;
	}
}

//Function Number: 11
func_5503()
{
	level.mugger_max_extra_tags = getdvarint("scr_mugger_max_extra_tags",50);
	level.mugger_extra_tags = [];
}

//Function Number: 12
func_7868(param_00,param_01)
{
	if(isbot(param_01))
	{
		param_01 = param_01.owner;
	}

	var_02 = 0;
	var_03 = 0;
	if(isdefined(param_01))
	{
		if(param_00 == param_01)
		{
			if(param_00.tags_carried > 0)
			{
				var_02 = param_00.tags_carried;
				param_00.tags_carried = 0;
				param_00.game_extrainfo = 0;
				if(isplayer(param_00) && !botsentientswap(param_00))
				{
					param_00.dogtagstext setvalue(param_00.tags_carried);
					param_00.dogtagstext thread maps\mp\gametypes\_hud::fontpulse(param_00);
					param_00 thread maps\mp\gametypes\_hud_message::func_794E("mugger_suicide",var_02);
				}
			}
		}
		else if(isdefined(param_00.attackerdata) && param_00.attackerdata.size > 0)
		{
			if(isplayer(param_01) && isdefined(param_00.attackerdata) && isdefined(param_01.guid) && isdefined(param_00.attackerdata[param_01.guid]))
			{
				var_04 = param_00.attackerdata[param_01.guid];
				if(isdefined(var_04) && isdefined(var_04.attackerent) && var_04.attackerent == param_01)
				{
					if(isdefined(var_04.smeansofdeath) && var_04.smeansofdeath == "MOD_MELEE" || (var_04.weapon == "throwingknife_mp" || var_04.weapon == "throwingknifejugg_mp") && level.mugger_throwing_knife_mug_frac > 0)
					{
						var_03 = 1;
						if(param_00.tags_carried > 0)
						{
							var_02 = param_00.tags_carried;
							if((var_04.weapon == "throwingknife_mp" || var_04.weapon == "throwingknifejugg_mp") && level.mugger_throwing_knife_mug_frac < 1)
							{
								var_02 = castint(ceil(param_00.tags_carried * level.mugger_throwing_knife_mug_frac));
							}

							param_00.tags_carried = param_00.tags_carried - var_02;
							param_00.game_extrainfo = param_00.tags_carried;
							if(isplayer(param_00) && !botsentientswap(param_00))
							{
								param_00.dogtagstext setvalue(param_00.tags_carried);
								param_00.dogtagstext thread maps\mp\gametypes\_hud::fontpulse(param_00);
								param_00 thread maps\mp\gametypes\_hud_message::func_794E("callout_mugged",var_02);
								param_00 playlocalsound("mugger_got_mugged");
							}

							playsoundatpos(param_00.origin,"mugger_mugging");
							param_01 thread maps\mp\gametypes\_hud_message::func_794E("callout_mugger",var_02);
							if(var_04.weapon == "throwingknife_mp" || var_04.weapon == "throwingknifejugg_mp")
							{
								param_01 playlocalsound("mugger_you_mugged");
							}
						}

						param_01.muggings[param_01.muggings.size] = gettime();
						param_01 thread func_54FC();
					}
				}
			}
		}
	}

	if(isbot(param_00))
	{
		var_05 = param_00.origin + (0,0,14);
		playsoundatpos(var_05,"mp_killconfirm_tags_drop");
		level notify("mugger_jackpot_increment");
		var_06 = func_551F(param_00.origin,40,160);
		var_06.victim = param_00.owner;
		if(isdefined(param_01) && param_00 != param_01)
		{
			var_06.attacker = param_01;
		}
		else
		{
			var_06.attacker = undefined;
		}
	}
	else if(isdefined(level.dogtags[var_02.guid]))
	{
		playfx(level.mugger_fx["vanish"],level.dogtags[var_02.guid].curorigin);
		level.dogtags[var_02.guid] notify("reset");
	}
	else
	{
		var_07[0] = spawn("script_model",(0,0,0));
		var_07[0] setmodel("prop_dogtags_foe_iw6");
		var_08 = spawn("trigger_radius",(0,0,0),0,32,32);
		var_08.targetname = "trigger_dogtag";
		var_08 hide();
		level.dogtags[var_02.guid] = maps\mp\gametypes\_gameobjects::func_212D("any",var_08,var_07,(0,0,16));
		maps\mp\gametypes\_objpoints::deleteobjpoint(level.dogtags[var_02.guid].objpoints["allies"]);
		maps\mp\gametypes\_objpoints::deleteobjpoint(level.dogtags[var_02.guid].objpoints["axis"]);
		level.dogtags[var_02.guid] maps\mp\gametypes\_gameobjects::func_720E(0);
		level.dogtags[var_02.guid].onuse = ::onuse;
		var_08.dogtag = level.dogtags[var_02.guid];
		level.dogtags[var_02.guid].victim = var_02;
		level.dogtags[var_02.guid].objid = maps\mp\gametypes\_gameobjects::getnextobjid();
		objective_add(level.dogtags[var_02.guid].objid,"invisible",(0,0,0));
		objective_icon(level.dogtags[var_02.guid].objid,"waypoint_dogtags2");
		level.dogtags[var_02.guid].visuals[0] scriptmodelplayanim("mp_dogtag_spin");
		level thread clearonvictimdisconnect(var_02);
	}

	var_05 = var_02.origin + (0,0,14);
	level.dogtags[param_01.guid].curorigin = var_06;
	level.dogtags[param_01.guid].trigger.origin = var_06;
	level.dogtags[param_01.guid].visuals[0].origin = var_06;
	level.dogtags[param_01.guid] maps\mp\gametypes\_gameobjects::func_4629();
	level.dogtags[param_01.guid] maps\mp\gametypes\_gameobjects::allowuse("any");
	level.dogtags[param_01.guid].visuals[0] show();
	if(isdefined(var_02) && param_01 != var_02)
	{
		level.dogtags[param_01.guid].attacker = var_02;
	}
	else
	{
		level.dogtags[param_01.guid].attacker = undefined;
	}

	level.dogtags[param_01.guid] thread timeout();
	if(var_03 < 5)
	{
		objective_position(level.dogtags[param_01.guid].objid,var_06);
		objective_state(level.dogtags[param_01.guid].objid,"active");
	}
	else
	{
		func_551E(var_06,"mugger_megadrop",var_03,param_01,var_02);
	}

	playsoundatpos(var_06,"mp_killconfirm_tags_drop");
	level.dogtags[param_01.guid].temp_tag = 0;
	if(var_03 == 0)
	{
		level notify("mugger_jackpot_increment");
	}

	var_09 = 0;
	while(var_06 < var_02)
	{
		var_09 = func_551F(param_00.origin,40,160);
		var_09.victim = param_00;
		if(isdefined(param_01) && param_00 != param_01)
		{
			var_09.attacker = param_01;
			continue;
		}

		var_09.attacker = undefined;
		var_06++;
	}
}

//Function Number: 13
mugger_tag_pickup_wait()
{
	level endon("game_ended");
	self endon("reset");
	self endon("reused");
	self endon("deleted");
	for(;;)
	{
		self.trigger waittill("trigger",var_00);
		if(!maps\mp\_utility::func_4945(var_00))
		{
			continue;
		}

		if(var_00 maps\mp\_utility::func_4995() || isdefined(var_00.var_78A7))
		{
			continue;
		}

		if(isdefined(var_00.classname) && var_00.classname == "script_vehicle")
		{
			continue;
		}

		thread onuse(var_00);
	}
}

//Function Number: 14
mugger_add_extra_tag(param_00)
{
	var_01[0] = spawn("script_model",(0,0,0));
	var_01[0] setmodel("prop_dogtags_foe_iw6");
	var_02 = spawn("trigger_radius",(0,0,0),0,32,32);
	var_02.targetname = "trigger_dogtag";
	var_02 hide();
	level.mugger_extra_tags[param_00] = addstruct();
	var_03 = level.mugger_extra_tags[param_00];
	var_03.type = "useObject";
	var_03.curorigin = var_02.origin;
	var_03.entnum = var_02 getentitynumber();
	var_03.trigger = var_02;
	var_03.triggertype = "proximity";
	var_03 maps\mp\gametypes\_gameobjects::allowuse("any");
	var_01[0].baseorigin = var_01[0].origin;
	var_03.visuals = var_01;
	var_03.offset3d = (0,0,16);
	var_03.temp_tag = 1;
	var_03.last_used_time = 0;
	var_03.visuals[0] scriptmodelplayanim("mp_dogtag_spin");
	var_03 thread mugger_tag_pickup_wait();
	return var_03;
}

//Function Number: 15
mugger_first_unused_or_oldest_extra_tag()
{
	var_00 = undefined;
	var_01 = -1;
	foreach(var_03 in level.mugger_extra_tags)
	{
		if(var_03.interactteam == "none")
		{
			var_03.last_used_time = gettime();
			var_03.visuals[0] show();
			return var_03;
		}

		if(!isdefined(var_00) || var_03.last_used_time < var_01)
		{
			var_01 = var_03.last_used_time;
			var_00 = var_03;
		}
	}

	if(level.mugger_extra_tags.size < level.mugger_max_extra_tags)
	{
		var_05 = mugger_add_extra_tag(level.mugger_extra_tags.size);
		if(isdefined(var_05))
		{
			var_05.last_used_time = gettime();
			return var_05;
		}
	}

	var_00.last_used_time = gettime();
	var_00 notify("reused");
	playfx(level.mugger_fx["vanish"],var_00.curorigin);
	return var_00;
}

//Function Number: 16
func_551F(param_00,param_01,param_02)
{
	var_03 = mugger_first_unused_or_oldest_extra_tag();
	var_04 = param_00 + (0,0,14);
	var_05 = (0,randomfloat(360),0);
	var_06 = anglestoforward(var_05);
	var_07 = randomfloatrange(40,160);
	var_08 = var_04 + var_07 * var_06;
	var_08 = var_08 + (0,0,40);
	var_09 = playerphysicstrace(var_04,var_08);
	var_04 = var_09;
	var_08 = var_04 + (0,0,-100);
	var_09 = playerphysicstrace(var_04,var_08);
	if(var_09[2] != var_08[2])
	{
		var_09 = var_09 + (0,0,14);
	}

	var_03.curorigin = var_09;
	var_03.trigger.origin = var_09;
	var_03.visuals[0].origin = var_09;
	var_03 maps\mp\gametypes\_gameobjects::func_4629();
	var_03 maps\mp\gametypes\_gameobjects::allowuse("any");
	var_03 thread mugger_tag_pickup_wait();
	var_03 thread timeout();
	return var_03;
}

//Function Number: 17
func_551E(param_00,param_01,param_02,param_03,param_04)
{
	level notify("mugger_tag_pile",param_00);
	var_05 = maps\mp\gametypes\_gameobjects::getnextobjid();
	objective_add(var_05,"active",param_00);
	objective_icon(var_05,"waypoint_dogtag_pile");
	level maps\mp\_utility::func_252F(5,::mugger_pile_icon_remove,var_05);
	if(param_02 >= 10)
	{
		level.mugger_last_mega_drop = gettime();
		level.mugger_jackpot_num_tags = 0;
		foreach(var_07 in level.players)
		{
			var_07 playsoundtoplayer("mp_defcon_one",var_07);
			if(isdefined(param_03) && var_07 == param_03)
			{
				continue;
			}

			if(isdefined(param_04) && var_07 == param_04)
			{
				continue;
			}

			var_07 thread maps\mp\gametypes\_hud_message::func_794C(param_01,param_02);
		}

		var_09 = newhudelem();
		var_09 setmaterial("waypoint_dogtag_pile",10,10);
		var_09 setwaypoint(0,1,0,0);
		var_09.x = param_00[0];
		var_09.y = param_00[1];
		var_09.z = param_00[2] + 32;
		var_09.alpha = 1;
		var_09 fadeovertime(5);
		var_09.alpha = 0;
		var_09 maps\mp\_utility::func_252F(5,::func_435F);
	}
}

//Function Number: 18
func_435F()
{
	if(isdefined(self))
	{
		self destroy();
	}
}

//Function Number: 19
func_5518()
{
	level endon("game_ended");
	for(;;)
	{
		var_00 = getentarray("remote_tank","targetname");
		var_01 = getentarray("trigger_dogtag","targetname");
		foreach(var_03 in level.players)
		{
			if(isdefined(var_03.using_remote_tank) && var_03.using_remote_tank == 1)
			{
				foreach(var_05 in var_00)
				{
					if(isdefined(var_05) && isdefined(var_05.owner) && var_05.owner == var_03)
					{
						foreach(var_07 in var_01)
						{
							if(isdefined(var_07) && isdefined(var_07.dogtag))
							{
								if(isdefined(var_07.dogtag.interactteam) && var_07.dogtag.interactteam != "none")
								{
									if(var_05 istouching(var_07))
									{
										var_07.dogtag onuse(var_05.owner);
									}
								}
							}
						}
					}
				}
			}
		}

		wait(0.2);
	}
}

//Function Number: 20
func_5517()
{
	level endon("game_ended");
	for(;;)
	{
		var_00 = getentarray("trigger_dogtag","targetname");
		foreach(var_02 in level.players)
		{
			if(isdefined(var_02) && isdefined(var_02.remoteuav))
			{
				foreach(var_04 in var_00)
				{
					if(isdefined(var_04) && isdefined(var_04.dogtag))
					{
						if(isdefined(var_04.dogtag.interactteam) && var_04.dogtag.interactteam != "none")
						{
							if(var_02.remoteuav istouching(var_04))
							{
								var_04.dogtag onuse(var_02);
							}
						}
					}
				}
			}
		}

		wait(0.2);
	}
}

//Function Number: 21
func_54FC()
{
	level endon("game_ended");
	self endon("disconnect");
	self notify("checking_muggernaut");
	self endon("checking_muggernaut");
	wait(2);
	if(self.muggings.size < level.mugger_muggernaut_muggings_needed)
	{
	}

	var_00 = self.muggings[self.muggings.size - 1];
	var_01 = var_00 - level.mugger_muggernaut_window;
	var_02 = [];
	foreach(var_04 in self.muggings)
	{
		if(var_04 >= var_01)
		{
			var_02[var_02.size] = var_04;
		}
	}

	if(var_02.size >= level.mugger_muggernaut_muggings_needed)
	{
		thread maps\mp\gametypes\_hud_message::func_794E("muggernaut",self.tags_carried);
		thread maps\mp\gametypes\_rank::giverankxp("muggernaut");
		func_54FB(1,1);
		self.muggings = [];
	}

	self.muggings = var_02;
}

//Function Number: 22
mugger_pile_icon_remove(param_00)
{
	objective_delete(param_00);
}

//Function Number: 23
func_4205(param_00)
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

//Function Number: 24
onuse(param_00)
{
	if(isdefined(param_00.owner))
	{
		param_00 = param_00.owner;
	}

	if(self.temp_tag)
	{
		self.trigger playsound("mp_killconfirm_tags_deny");
	}
	else if(isdefined(self.attacker) && param_00 == self.attacker)
	{
		self.trigger playsound("mp_killconfirm_tags_pickup");
		param_00 maps\mp\_utility::func_447B("killsconfirmed",1);
		param_00 maps\mp\_utility::func_4479("confirmed",1);
		param_00 maps\mp\gametypes\_persistence::func_7B28("round","confirmed",param_00.pers["confirmed"]);
	}
	else
	{
		self.trigger playsound("mp_killconfirm_tags_deny");
		param_00 maps\mp\_utility::func_447B("killsdenied",1);
		param_00 maps\mp\_utility::func_4479("denied",1);
		param_00 maps\mp\gametypes\_persistence::func_7B28("round","denied",param_00.pers["denied"]);
	}

	param_00 thread onpickup();
	func_661E(1);
}

//Function Number: 25
onpickup()
{
	level endon("game_ended");
	self endon("disconnect");
	while(!isdefined(self.pers))
	{
		wait(0.05);
	}

	thread mugger_delayed_banking();
}

//Function Number: 26
mugger_delayed_banking()
{
	self notify("banking");
	self endon("banking");
	level endon("banking_all");
	self.tags_carried++;
	self.game_extrainfo = self.tags_carried;
	if(isplayer(self) && !botsentientswap(self))
	{
		self.dogtagstext setvalue(self.tags_carried);
		self.dogtagstext thread maps\mp\gametypes\_hud::fontpulse(self);
	}

	wait(1.5);
	var_00 = level.mugger_bank_limit - self.tags_carried;
	if(var_00 > 0 && var_00 <= 5)
	{
		var_01 = undefined;
		switch(var_00)
		{
			case 1:
				var_01 = "mugger_1more";
				break;

			case 2:
				var_01 = "mugger_2more";
				break;

			case 3:
				var_01 = "mugger_3more";
				break;

			case 4:
				var_01 = "mugger_4more";
				break;

			case 5:
				var_01 = "mugger_5more";
				break;
		}

		if(isdefined(var_01))
		{
			self playsoundtoplayer(var_01,self);
		}
	}

	wait(0.5);
	func_54FB(0);
}

//Function Number: 27
func_54FB(param_00,param_01)
{
	var_02 = 0;
	if(param_00 == 1)
	{
		var_02 = self.tags_carried;
	}
	else
	{
		var_03 = self.tags_carried % level.mugger_bank_limit;
		var_02 = self.tags_carried - var_03;
	}

	if(var_02 > 0)
	{
		self.tags_to_bank = var_02;
		if(!isdefined(param_01))
		{
			thread maps\mp\gametypes\_hud_message::func_794E("callout_tags_banked",var_02);
		}

		thread maps\mp\gametypes\_rank::giverankxp("tags_banked",self.tags_to_bank * maps\mp\gametypes\_rank::func_3BE0("kill_confirmed"));
		level thread maps\mp\gametypes\_gamescore::func_3D00("tags_banked",self,undefined,1);
		self.total_tags_banked = self.total_tags_banked + var_02;
		self.tags_carried = self.tags_carried - var_02;
		self.game_extrainfo = self.tags_carried;
		if(isplayer(self) && !botsentientswap(self))
		{
			self.dogtagstext setvalue(self.tags_carried);
			self.dogtagstext thread maps\mp\gametypes\_hud::fontpulse(self);
		}

		self.assists = self.total_tags_banked;
		self.pers["assists"] = self.total_tags_banked;
		self updatescores();
	}
}

//Function Number: 28
onplayerscore(param_00,param_01,param_02)
{
	if(param_00 == "tags_banked" && isdefined(param_01) && isdefined(param_01.tags_to_bank) && param_01.tags_to_bank > 0)
	{
		var_03 = param_01.tags_to_bank * maps\mp\gametypes\_rank::func_3BE0("kill_confirmed");
		param_01.tags_to_bank = 0;
		return var_03;
	}

	return 0;
}

//Function Number: 29
func_661E(param_00)
{
	if(!param_00)
	{
		level notify("mugger_jackpot_increment");
	}

	self.attacker = undefined;
	self notify("reset");
	self.visuals[0] hide();
	self.curorigin = (0,0,1000);
	self.trigger.origin = (0,0,1000);
	self.visuals[0].origin = (0,0,1000);
	maps\mp\gametypes\_gameobjects::allowuse("none");
	if(isdefined(self.jackpot_tag) && self.jackpot_tag == 1)
	{
		level.mugger_jackpot_tags_spawned--;
	}

	if(!self.temp_tag)
	{
		objective_state(self.objid,"invisible");
	}
}

//Function Number: 30
timeout()
{
	level endon("game_ended");
	self endon("death");
	self endon("deleted");
	self endon("reset");
	self endon("reused");
	self notify("timeout_start");
	self endon("timeout_start");
	level maps\mp\gametypes\_hostmigration::func_8B0D(27);
	var_00 = 3;
	while(var_00 > 0)
	{
		self.visuals[0] hide();
		wait(0.25);
		self.visuals[0] show();
		wait(0.25);
		var_00 = var_00 - 0.5;
	}

	playfx(level.mugger_fx["vanish"],self.curorigin);
	thread func_661E(0);
}

//Function Number: 31
clearonvictimdisconnect(param_00)
{
	level endon("game_ended");
	var_01 = param_00.guid;
	param_00 waittill("disconnect");
	if(isdefined(level.dogtags[var_01]))
	{
		level.dogtags[var_01] maps\mp\gametypes\_gameobjects::allowuse("none");
		playfx(level.mugger_fx["vanish"],level.dogtags[var_01].curorigin);
		level.dogtags[var_01] notify("reset");
		wait(0.05);
		if(isdefined(level.dogtags[var_01]))
		{
			objective_delete(level.dogtags[var_01].objid);
			level.dogtags[var_01].trigger delete();
			for(var_02 = 0;var_02 < level.dogtags[var_01].visuals.size;var_02++)
			{
				level.dogtags[var_01].visuals[var_02] delete();
			}

			level.dogtags[var_01] notify("deleted");
			level.dogtags[var_01] = undefined;
		}
	}
}

//Function Number: 32
ontimelimit()
{
	level notify("banking_all");
	foreach(var_01 in level.players)
	{
		var_01 func_54FB(1);
	}

	wait(0.1);
	maps\mp\gametypes\_gamelogic::func_24A3();
}

//Function Number: 33
func_5513()
{
	level endon("game_ended");
	level endon("jackpot_stop");
	if(level.mugger_jackpot_limit <= 0)
	{
	}

	level.mugger_jackpot_num_tags = 0;
	level.mugger_jackpot_tags_unspawned = 0;
	level.mugger_jackpot_num_tags = 0;
	level thread mugger_jackpot_timer();
	for(;;)
	{
		level waittill("mugger_jackpot_increment");
		var_00 = 1;
		if(var_00)
		{
			level.mugger_jackpot_num_tags++;
			var_01 = clamp(castfloat(level.mugger_jackpot_num_tags / level.mugger_jackpot_limit),0,1);
			if(level.mugger_jackpot_num_tags >= level.mugger_jackpot_limit)
			{
				if(isdefined(level.mugger_jackpot_text))
				{
					level.mugger_jackpot_text thread maps\mp\gametypes\_hud::fontpulse(level.players[0]);
				}

				level.mugger_jackpot_num_tags = 15 + randomintrange(0,3) * 5;
				level thread func_5506();
				break;
			}
		}
	}
}

//Function Number: 34
mugger_jackpot_timer()
{
	level endon("game_ended");
	level endon("jackpot_stop");
	maps\mp\_utility::gameflagwait("prematch_done");
	for(;;)
	{
		wait(level.mugger_jackpot_wait_sec);
		level notify("mugger_jackpot_increment");
	}
}

//Function Number: 35
func_5506()
{
	level endon("game_ended");
	level notify("reset_airdrop");
	level endon("reset_airdrop");
	var_00 = level.mugger_dropzones[level.script][randomint(level.mugger_dropzones[level.script].size)];
	var_00 = var_00 + (randomintrange(-50,50),randomintrange(-50,50),0);
	for(;;)
	{
		var_01 = level.players[0];
		var_02 = 1;
		if(isdefined(var_01) && maps\mp\_utility::func_21E7() < maps\mp\_utility::maxvehiclesallowed() && level.fauxvehiclecount + var_02 < maps\mp\_utility::maxvehiclesallowed() && level.numdropcrates < 8)
		{
			foreach(var_04 in level.players)
			{
				var_04 thread maps\mp\gametypes\_hud_message::func_794C("mugger_jackpot_incoming");
			}

			maps\mp\_utility::func_4487();
			level thread maps\mp\killstreaks\_airdrop::func_2896(var_01,var_00,randomfloat(360),"airdrop_mugger",0,"airdrop_jackpot");
			break;
		}
		else
		{
			wait(0.5);
			continue;
		}
	}

	level.mugger_jackpot_tags_unspawned = level.mugger_jackpot_num_tags;
	level thread func_550D(var_00);
}

//Function Number: 36
func_550B(param_00,param_01,param_02)
{
	if(!isdefined(level.jackpotpileobjid))
	{
		level.jackpotpileobjid = maps\mp\gametypes\_gameobjects::getnextobjid();
		objective_add(level.jackpotpileobjid,"active",param_00);
		objective_icon(level.jackpotpileobjid,"waypoint_jackpot");
	}
	else
	{
		objective_position(level.jackpotpileobjid,param_00);
	}

	if(param_02 >= 10)
	{
		foreach(var_04 in level.players)
		{
			var_04 playlocalsound(game["music"]["victory_" + var_04.pers["team"]]);
		}

		if(!isdefined(level.jackpotpileicon))
		{
			level.jackpotpileicon = newhudelem();
			level.jackpotpileicon setmaterial("waypoint_jackpot",64,64);
			level.jackpotpileicon setwaypoint(0,1,0,0);
		}

		level.jackpotpileicon.x = param_00[0];
		level.jackpotpileicon.y = param_00[1];
		level.jackpotpileicon.z = param_00[2] + 12;
		level.jackpotpileicon.alpha = 0.75;
	}
}

//Function Number: 37
func_550C()
{
	objective_state(level.jackpotpileobjid,"invisible");
	level.jackpotpileicon fadeovertime(2);
	level.jackpotpileicon.alpha = 0;
	level.jackpotpileicon maps\mp\_utility::func_252F(2,::func_435F);
}

//Function Number: 38
func_5507(param_00)
{
	func_5508();
	var_01 = param_00 + (0,0,30);
	var_02 = param_00 + (0,0,-1000);
	var_03 = bullettrace(var_01,var_02,0,undefined);
	level.jackpot_zone.origin = var_03["position"] + (0,0,1);
	level.jackpot_zone show();
	var_04 = vectortoangles(var_03["normal"]);
	var_05 = anglestoforward(var_04);
	var_06 = anglestoright(var_04);
	thread func_78A3(var_03["position"],var_05,var_06,0.5);
	wait(0.1);
	playfxontag(level.mugger_fx["smoke"],level.jackpot_zone,"tag_fx");
	foreach(var_08 in level.players)
	{
		var_08.mugger_fx_playing = 1;
	}

	level.jackpot_zone.mugger_fx_playing = 1;
}

//Function Number: 39
func_5508()
{
	stopfxontag(level.mugger_fx["smoke"],level.jackpot_zone,"tag_fx");
	level.jackpot_zone hide();
	if(isdefined(level.jackpot_targetfx))
	{
		level.jackpot_targetfx delete();
	}

	if(level.jackpot_zone.mugger_fx_playing)
	{
		level.jackpot_zone.mugger_fx_playing = 0;
		stopfxontag(level.mugger_fx["smoke"],level.jackpot_zone,"tag_fx");
		wait(0.05);
	}
}

//Function Number: 40
func_78A3(param_00,param_01,param_02,param_03)
{
	if(isdefined(level.jackpot_targetfx))
	{
		level.jackpot_targetfx delete();
	}

	wait(param_03);
	level.jackpot_targetfx = spawnfx(level.mugger_targetfxid,param_00,param_01,param_02);
	triggerfx(level.jackpot_targetfx);
}

//Function Number: 41
func_8B0F()
{
	level endon("game_ended");
	self endon("disconnect");
	maps\mp\_utility::gameflagwait("prematch_done");
	wait(0.5);
	if(level.jackpot_zone.mugger_fx_playing == 1 && !isdefined(self.mugger_fx_playing))
	{
		playfxontagforclients(level.mugger_fx["smoke"],level.jackpot_zone,"tag_fx",self);
		self.mugger_fx_playing = 1;
	}
}

//Function Number: 42
func_550D(param_00)
{
	level endon("game_ended");
	level endon("jackpot_timeout");
	level notify("jackpot_stop");
	func_550B(param_00,"mugger_jackpot",level.mugger_jackpot_tags_unspawned);
	level thread func_5507(param_00);
	level thread func_5504(30);
	level waittill("airdrop_jackpot_landed",param_00);
	objective_position(level.jackpotpileobjid,param_00);
	level.jackpotpileicon.x = param_00[0];
	level.jackpotpileicon.y = param_00[1];
	level.jackpotpileicon.z = param_00[2] + 32;
	foreach(var_02 in level.players)
	{
		var_02 playsoundtoplayer("mp_defcon_one",var_02);
		var_02 thread maps\mp\gametypes\_hud_message::func_794C("mugger_jackpot",level.mugger_jackpot_tags_unspawned);
	}

	level.mugger_jackpot_tags_spawned = 0;
	while(level.mugger_jackpot_tags_unspawned > 0)
	{
		if(level.mugger_jackpot_tags_spawned < 10)
		{
			level.mugger_jackpot_tags_unspawned--;
			var_04 = func_551F(param_00,0,400);
			var_04.jackpot_tag = 1;
			level.mugger_jackpot_tags_spawned++;
			level thread func_5504(90);
			wait(0.1);
			continue;
		}

		wait(0.5);
	}

	level.mugger_jackpot_num_tags = 0;
	while(level.mugger_jackpot_tags_spawned > 0)
	{
		wait(1);
	}

	func_5505();
}

//Function Number: 43
func_5505()
{
	level notify("jackpot_cleanup");
	func_550C();
	func_5508();
	level thread func_5513();
}

//Function Number: 44
func_5504(param_00)
{
	level endon("jackpot_cleanup");
	level notify("jackpot_abort_after_time");
	level endon("jackpot_abort_after_time");
	wait(param_00);
	level notify("jackpot_timeout");
}

//Function Number: 45
createmuggercrates(param_00,param_01)
{
	maps\mp\killstreaks\_airdrop::addcratetype("airdrop_mugger","airdrop_jackpot",1,::func_5523);
}

//Function Number: 46
func_5523(param_00)
{
	self endon("death");
	level notify("airdrop_jackpot_landed",self.origin);
	wait(0.5);
	maps\mp\killstreaks\_airdrop::deletecrate();
}

//Function Number: 47
createdropzones()
{
	level.mugger_dropzones = [];
	var_00 = common_scripts\utility::func_3C1A("horde_drop","targetname");
	if(isdefined(var_00) && var_00.size)
	{
		var_01 = 0;
		foreach(var_03 in var_00)
		{
			level.mugger_dropzones[level.script][var_01] = var_03.origin;
			var_01++;
		}
	}

	level.mugger_dropzones["mp_seatown"][0] = (-665,-209,226);
	level.mugger_dropzones["mp_seatown"][1] = (-2225,1573,260);
	level.mugger_dropzones["mp_seatown"][2] = (1275,-747,292);
	level.mugger_dropzones["mp_seatown"][3] = (1210,963,225);
	level.mugger_dropzones["mp_seatown"][4] = (-2343,-811,226);
	level.mugger_dropzones["mp_seatown"][5] = (-1125,-1610,184);
	level.mugger_dropzones["mp_dome"][0] = (649,1096,-250);
	level.mugger_dropzones["mp_dome"][1] = (953,-501,-328);
	level.mugger_dropzones["mp_dome"][2] = (-37,2099,-231);
	level.mugger_dropzones["mp_dome"][3] = (-716,1100,-296);
	level.mugger_dropzones["mp_dome"][4] = (-683,-51,-352);
	level.mugger_dropzones["mp_plaza2"][0] = (266,-212,708);
	level.mugger_dropzones["mp_plaza2"][1] = (295,1842,668);
	level.mugger_dropzones["mp_plaza2"][2] = (-1449,1833,692);
	level.mugger_dropzones["mp_plaza2"][3] = (835,-1815,668);
	level.mugger_dropzones["mp_plaza2"][4] = (-1116,76,729);
	level.mugger_dropzones["mp_plaza2"][5] = (-399,951,676);
	level.mugger_dropzones["mp_mogadishu"][0] = (552,1315,8);
	level.mugger_dropzones["mp_mogadishu"][1] = (990,3248,144);
	level.mugger_dropzones["mp_mogadishu"][2] = (-879,2643,135);
	level.mugger_dropzones["mp_mogadishu"][3] = (-68,-995,16);
	level.mugger_dropzones["mp_mogadishu"][4] = (1499,-1206,15);
	level.mugger_dropzones["mp_mogadishu"][5] = (2387,1786,61);
	level.mugger_dropzones["mp_paris"][0] = (-150,-80,63);
	level.mugger_dropzones["mp_paris"][1] = (-947,-1088,107);
	level.mugger_dropzones["mp_paris"][2] = (1052,-614,50);
	level.mugger_dropzones["mp_paris"][3] = (1886,648,24);
	level.mugger_dropzones["mp_paris"][4] = (628,2096,30);
	level.mugger_dropzones["mp_paris"][5] = (-2033,1082,308);
	level.mugger_dropzones["mp_paris"][6] = (-1230,1836,295);
	level.mugger_dropzones["mp_exchange"][0] = (904,441,-77);
	level.mugger_dropzones["mp_exchange"][1] = (-1056,1435,141);
	level.mugger_dropzones["mp_exchange"][2] = (800,1543,148);
	level.mugger_dropzones["mp_exchange"][3] = (2423,1368,141);
	level.mugger_dropzones["mp_exchange"][4] = (596,-1870,89);
	level.mugger_dropzones["mp_exchange"][5] = (-1241,-821,30);
	level.mugger_dropzones["mp_bootleg"][0] = (-444,-114,-8);
	level.mugger_dropzones["mp_bootleg"][1] = (1053,-1051,-13);
	level.mugger_dropzones["mp_bootleg"][2] = (889,1184,-28);
	level.mugger_dropzones["mp_bootleg"][3] = (-994,1877,-41);
	level.mugger_dropzones["mp_bootleg"][4] = (-1707,-1333,63);
	level.mugger_dropzones["mp_bootleg"][5] = (-334,-2155,61);
	level.mugger_dropzones["mp_carbon"][0] = (-1791,-3892,3813);
	level.mugger_dropzones["mp_carbon"][1] = (-338,-4978,3964);
	level.mugger_dropzones["mp_carbon"][2] = (-82,-2941,3990);
	level.mugger_dropzones["mp_carbon"][3] = (-3198,-2829,3809);
	level.mugger_dropzones["mp_carbon"][4] = (-3673,-3893,3610);
	level.mugger_dropzones["mp_carbon"][5] = (-2986,-4863,3648);
	level.mugger_dropzones["mp_hardhat"][0] = (1187,-322,238);
	level.mugger_dropzones["mp_hardhat"][1] = (2010,-1379,357);
	level.mugger_dropzones["mp_hardhat"][2] = (1615,1245,366);
	level.mugger_dropzones["mp_hardhat"][3] = (-371,825,436);
	level.mugger_dropzones["mp_hardhat"][4] = (-820,-927,348);
	level.mugger_dropzones["mp_alpha"][0] = (-239,1315,52);
	level.mugger_dropzones["mp_alpha"][1] = (-1678,-219,55);
	level.mugger_dropzones["mp_alpha"][2] = (235,-369,60);
	level.mugger_dropzones["mp_alpha"][3] = (-201,2138,60);
	level.mugger_dropzones["mp_alpha"][4] = (-1903,2433,198);
	level.mugger_dropzones["mp_village"][0] = (990,-821,331);
	level.mugger_dropzones["mp_village"][1] = (658,2155,337);
	level.mugger_dropzones["mp_village"][2] = (-559,1882,310);
	level.mugger_dropzones["mp_village"][3] = (-1999,1184,343);
	level.mugger_dropzones["mp_village"][4] = (215,-2875,384);
	level.mugger_dropzones["mp_village"][5] = (1731,-483,290);
	level.mugger_dropzones["mp_lambeth"][0] = (712,217,-196);
	level.mugger_dropzones["mp_lambeth"][1] = (1719,-1095,-196);
	level.mugger_dropzones["mp_lambeth"][2] = (2843,1034,-269);
	level.mugger_dropzones["mp_lambeth"][3] = (1251,2645,-213);
	level.mugger_dropzones["mp_lambeth"][4] = (-1114,1301,-200);
	level.mugger_dropzones["mp_lambeth"][5] = (-693,-823,-132);
	level.mugger_dropzones["mp_radar"][0] = (-5052,2371,1223);
	level.mugger_dropzones["mp_radar"][1] = (-4550,4199,1268);
	level.mugger_dropzones["mp_radar"][2] = (-7149,4449,1376);
	level.mugger_dropzones["mp_radar"][3] = (-6350,1528,1302);
	level.mugger_dropzones["mp_radar"][4] = (-3333,992,1222);
	level.mugger_dropzones["mp_radar"][5] = (-4040,-361,1222);
	level.mugger_dropzones["mp_interchange"][0] = (662,-513,142);
	level.mugger_dropzones["mp_interchange"][1] = (674,1724,112);
	level.mugger_dropzones["mp_interchange"][2] = (-1003,1103,30);
	level.mugger_dropzones["mp_interchange"][3] = (385,-2910,209);
	level.mugger_dropzones["mp_interchange"][4] = (2004,-1760,144);
	level.mugger_dropzones["mp_interchange"][5] = (2458,-300,147);
	level.mugger_dropzones["mp_underground"][0] = (31,1319,-196);
	level.mugger_dropzones["mp_underground"][1] = (165,-940,60);
	level.mugger_dropzones["mp_underground"][2] = (-747,143,4);
	level.mugger_dropzones["mp_underground"][3] = (-1671,1666,-216);
	level.mugger_dropzones["mp_underground"][4] = (-631,3158,-68);
	level.mugger_dropzones["mp_underground"][5] = (500,2865,-89);
	level.mugger_dropzones["mp_bravo"][0] = (-39,-119,1280);
	level.mugger_dropzones["mp_bravo"][1] = (1861,-563,1229);
	level.mugger_dropzones["mp_bravo"][2] = (-1548,-366,1007);
	level.mugger_dropzones["mp_bravo"][3] = (-678,1272,1273);
	level.mugger_dropzones["mp_bravo"][4] = (1438,842,1272);
}