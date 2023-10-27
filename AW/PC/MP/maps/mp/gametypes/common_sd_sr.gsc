/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\common_sd_sr.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 38
 * Decompile Time: 656 ms
 * Timestamp: 10/27/2023 1:43:04 AM
*******************************************************************/

//Function Number: 1
onprecachegametype()
{
	game["bomb_dropped_sound"] = "mp_obj_notify_neg_sml";
	game["bomb_dropped_enemy_sound"] = "mp_obj_notify_pos_sml";
	game["bomb_recovered_sound"] = "mp_obj_notify_pos_sml";
	game["bomb_grabbed_sound"] = "mp_snd_bomb_pickup";
	game["bomb_planted_sound"] = "mp_obj_notify_pos_med";
	game["bomb_planted_enemy_sound"] = "mp_obj_notify_neg_med";
	game["bomb_disarm_sound"] = "mp_obj_notify_pos_lrg";
	game["bomb_disarm_enemy_sound"] = "mp_obj_notify_neg_lrg";
}

//Function Number: 2
updategametypedvars()
{
	level.planttime = maps\mp\_utility::dvarfloatvalue("planttime",5,0,20);
	level.defusetime = maps\mp\_utility::dvarfloatvalue("defusetime",5,0,20);
	level.bombtimer = maps\mp\_utility::dvarfloatvalue("bombtimer",45,1,300);
	level.multibomb = maps\mp\_utility::dvarintvalue("multibomb",0,0,1);
	level.silentplant = maps\mp\_utility::dvarintvalue("silentplant",0,0,1);
}

//Function Number: 3
setspecialloadout()
{
	if(isusingmatchrulesdata() && getmatchrulesdata("defaultClasses",game["attackers"],5,"class","inUse"))
	{
		level.sd_loadout[game["attackers"]] = maps\mp\_utility::getmatchrulesspecialclass(game["attackers"],5);
	}
}

//Function Number: 4
isplayeroutsideofanybombsite(param_00)
{
	if(isdefined(level.bombzones))
	{
		foreach(var_02 in level.bombzones)
		{
			if(distancesquared(self.origin,var_02.trigger.origin) < 4096)
			{
				return 0;
			}
		}
	}

	return 1;
}

//Function Number: 5
onnormaldeath(param_00,param_01,param_02)
{
	if(game["state"] == "postgame" && param_00.team == game["defenders"] || !level.bombplanted)
	{
		param_01.finalkill = 1;
	}

	if(param_00.isplanting || param_00.isdefusing)
	{
		param_01 thread maps\mp\_events::defendobjectiveevent(param_00,param_02);
		if(param_00.isplanting)
		{
			param_01 maps\mp\gametypes\_missions::processchallenge("ch_" + level.gametype + "_interrupt");
		}

		if(param_00.isdefusing)
		{
			param_01 maps\mp\gametypes\_missions::processchallenge("ch_" + level.gametype + "_protector");
		}
	}

	if(waselminatedbyenemy(param_00,param_01))
	{
		var_03 = islastplayeralive(param_01);
		param_01 thread maps\mp\_events::eliminateplayerevent(var_03,param_00);
	}
}

//Function Number: 6
waselminatedbyenemy(param_00,param_01)
{
	if(maps\mp\gametypes\_damage::isfriendlyfire(param_00,param_01))
	{
		return 0;
	}

	if(param_00 maps\mp\gametypes\_playerlogic::mayspawn())
	{
		return 0;
	}

	return 1;
}

//Function Number: 7
onpickup(param_00)
{
	param_00.isbombcarrier = 1;
	if(param_00.team == "allies")
	{
		param_00.objective = 1;
	}
	else
	{
		param_00.objective = 2;
	}

	if(isplayer(param_00))
	{
		param_00 thread maps\mp\_matchdata::loggameevent("pickup",param_00.origin);
		param_00 setclientomnvar("ui_carrying_bomb",1);
	}

	maps\mp\gametypes\_gameobjects::set2dicon("friendly","waypoint_escort");
	maps\mp\gametypes\_gameobjects::set3dicon("friendly","waypoint_escort");
	if(isdefined(level.sd_loadout) && isdefined(level.sd_loadout[param_00.team]))
	{
		param_00.isrespawningwithbombcarrierclass = 1;
		param_00 thread applybombcarrierclass();
	}

	if(!level.bombdefused)
	{
		maps\mp\_utility::teamplayercardsplash("callout_bombtaken",param_00,param_00.team);
		maps\mp\_utility::leaderdialog("bomb_taken",param_00.pers["team"]);
	}

	maps\mp\_utility::playsoundonplayers(game["bomb_recovered_sound"],game["attackers"]);
	param_00 playlocalsound(game["bomb_grabbed_sound"]);
}

//Function Number: 8
bombs()
{
	level.bombplanted = 0;
	level.bombdefused = 0;
	level.bombexploded = 0;
	var_00 = getent("sd_bomb_pickup_trig","targetname");
	if(!isdefined(var_00))
	{
		common_scripts\utility::error("No sd_bomb_pickup_trig trigger found in map.");
		return;
	}

	var_01[0] = getent("sd_bomb","targetname");
	if(!isdefined(var_01[0]))
	{
		common_scripts\utility::error("No sd_bomb script_model found in map.");
		return;
	}

	var_01[0] setmodel("npc_search_dstry_bomb");
	if(!level.multibomb)
	{
		level.sdbomb = maps\mp\gametypes\_gameobjects::createcarryobject(game["attackers"],var_00,var_01,(0,0,32));
		level.sdbomb maps\mp\gametypes\_gameobjects::allowcarry("friendly");
		level.sdbomb maps\mp\gametypes\_gameobjects::set2dicon("friendly","waypoint_bomb");
		level.sdbomb maps\mp\gametypes\_gameobjects::set3dicon("friendly","waypoint_bomb");
		level.sdbomb maps\mp\gametypes\_gameobjects::setvisibleteam("friendly");
		if(game["attackers"] == "allies")
		{
			maps\mp\_utility::setmlgicons(level.sdbomb,"waypoint_bomb_green");
		}
		else
		{
			maps\mp\_utility::setmlgicons(level.sdbomb,"waypoint_bomb_red");
		}

		level.sdbomb.allowweapons = 1;
		level.sdbomb.onpickup = ::onpickup;
		level.sdbomb.ondrop = ::ondrop;
		level.sdbomb.canuseobject = ::canuse;
		level.sdbomb.goliaththink = ::goliathdropbomb;
	}
	else
	{
		var_00 delete();
		var_01[0] delete();
	}

	level.bombzones = [];
	var_02 = getentarray("bombzone","targetname");
	var_03 = getentarray("bombzone_augmented","targetname");
	if(maps\mp\_utility::isaugmentedgamemode())
	{
		for(var_04 = 0;var_04 < var_03.size;var_04++)
		{
			var_05 = var_03[var_04].script_label;
			for(var_06 = 0;var_06 < var_02.size;var_06++)
			{
				if(var_02[var_06].script_label == var_05)
				{
					removebombzone(var_02[var_06]);
					break;
				}
			}
		}
	}
	else
	{
		for(var_07 = 0;var_07 < var_03.size;var_07++)
		{
			removebombzone(var_03[var_07]);
		}
	}

	var_02 = common_scripts\utility::array_combine(var_02,var_03);
	for(var_07 = 0;var_07 < var_02.size;var_07++)
	{
		var_00 = var_02[var_07];
		var_01 = getentarray(var_02[var_07].target,"targetname");
		playfxontag(common_scripts\utility::getfx("bomb_light_blinking"),var_01[0],"tag_fx_1");
		playfxontag(common_scripts\utility::getfx("bomb_light_blinking"),var_01[0],"tag_fx_2");
		var_08 = maps\mp\gametypes\_gameobjects::createuseobject(game["defenders"],var_00,var_01,(0,0,64));
		var_08 maps\mp\gametypes\_gameobjects::allowuse("enemy");
		var_08 maps\mp\gametypes\_gameobjects::setusetime(level.planttime);
		var_08 maps\mp\gametypes\_gameobjects::setusehinttext(&"PLATFORM_HOLD_TO_PLANT_EXPLOSIVES");
		if(!level.multibomb)
		{
			var_08 maps\mp\gametypes\_gameobjects::setkeyobject(level.sdbomb);
		}

		var_09 = var_08 maps\mp\gametypes\_gameobjects::getlabel();
		var_08.label = var_09;
		var_08 maps\mp\gametypes\_gameobjects::set2dicon("friendly","waypoint_defend" + var_09);
		var_08 maps\mp\gametypes\_gameobjects::set3dicon("friendly","waypoint_defend" + var_09);
		var_08 maps\mp\gametypes\_gameobjects::set2dicon("enemy","waypoint_target" + var_09);
		var_08 maps\mp\gametypes\_gameobjects::set3dicon("enemy","waypoint_target" + var_09);
		var_08 maps\mp\gametypes\_gameobjects::setvisibleteam("any");
		maps\mp\_utility::setmlgicons(var_08,"waypoint_esports_snd_target" + var_09 + "_white");
		var_08.onbeginuse = ::onbeginuse;
		var_08.onenduse = ::onenduse;
		var_08.nousebar = 1;
		var_08.id = "bombZone";
		var_08.onuse = ::onuseplantobject;
		var_08.oncantuse = ::oncantuse;
		var_08.useweapon = "search_dstry_bomb_mp";
		for(var_0A = 0;var_0A < var_01.size;var_0A++)
		{
			if(isdefined(var_01[var_0A].script_exploder))
			{
				var_08.exploderindex = var_01[var_0A].script_exploder;
				var_01[var_0A] thread setupkillcament(var_08);
				break;
			}
		}

		level.bombzones[level.bombzones.size] = var_08;
		var_08.bombdefusetrig = getent(var_01[0].target,"targetname");
		var_08.bombdefusetrig.origin = var_08.bombdefusetrig.origin + (0,0,-10000);
		var_08.bombdefusetrig.label = var_09;
		var_08.bombdefusetrig usetriggertouchcheckstance(1);
	}

	for(var_07 = 0;var_07 < level.bombzones.size;var_07++)
	{
		var_0B = [];
		for(var_0C = 0;var_0C < level.bombzones.size;var_0C++)
		{
			if(var_0C != var_07)
			{
				var_0B[var_0B.size] = level.bombzones[var_0C];
			}
		}

		level.bombzones[var_07].otherbombzones = var_0B;
	}

	setomnvar("ui_mlg_game_mode_status_1",0);
}

//Function Number: 9
removebombzone(param_00)
{
	var_01 = getentarray("script_brushmodel","classname");
	foreach(var_03 in var_01)
	{
		if(!isdefined(var_03.script_gameobjectname) || var_03.script_gameobjectname != "bombzone")
		{
			continue;
		}

		if(!isdefined(var_03.script_label))
		{
			continue;
		}

		var_04 = issubstr(var_03.script_label,"augmented");
		if(maps\mp\_utility::isaugmentedgamemode() && var_04)
		{
			continue;
		}

		if(!maps\mp\_utility::isaugmentedgamemode() && !var_04)
		{
			continue;
		}

		if(issubstr(var_03.script_label,param_00.script_label) && issubstr(var_03.script_label,param_00.targetname))
		{
			var_03 delete();
		}
	}

	var_06 = getentarray(param_00.target,"targetname");
	foreach(var_08 in var_06)
	{
		if(isdefined(var_08.target))
		{
			var_09 = getentarray(var_08.target,"targetname");
			foreach(var_0B in var_09)
			{
				var_0B delete();
			}
		}

		var_08 delete();
	}

	param_00 delete();
}

//Function Number: 10
onuseplantobject(param_00)
{
	if(!maps\mp\gametypes\_gameobjects::isfriendlyteam(param_00.pers["team"]))
	{
		level thread bombplanted(self,param_00);
		for(var_01 = 0;var_01 < level.bombzones.size;var_01++)
		{
			if(level.bombzones[var_01] == self)
			{
				var_02 = level.bombzones[var_01] maps\mp\gametypes\_gameobjects::getlabel();
				maps\mp\_utility::setmlgicons(level.bombzones[var_01],"waypoint_esports_snd_planted" + var_02);
				continue;
			}

			level.bombzones[var_01] maps\mp\gametypes\_gameobjects::disableobject();
			maps\mp\_utility::setmlgicons(level.bombzones[var_01],undefined);
		}

		param_00 playsound("mp_bomb_plant");
		param_00 notify("bomb_planted");
		param_00 thread maps\mp\_events::bombplantevent();
		maps\mp\_utility::leaderdialog("bomb_planted");
		maps\mp\_utility::playsoundonplayers(game["bomb_planted_sound"],game["attackers"]);
		maps\mp\_utility::playsoundonplayers(game["bomb_planted_enemy_sound"],game["defenders"]);
		if(isdefined(level.sd_loadout) && isdefined(level.sd_loadout[param_00.team]))
		{
			param_00 thread removebombcarrierclass();
		}

		level.bombowner = param_00;
		param_00.bombplantedtime = gettime();
	}
}

//Function Number: 11
play_looping_beep_on_player(param_00)
{
	var_01 = common_scripts\utility::array_remove(level.players,param_00);
	if(var_01.size)
	{
		param_00 maps\mp\_utility::playloopsoundtoplayers("snd_bomb_button_press_lp",undefined,var_01);
	}
}

//Function Number: 12
stop_looping_beep_on_player(param_00)
{
	param_00 common_scripts\utility::stop_loop_sound_on_entity("snd_bomb_button_press_lp");
}

//Function Number: 13
setupkillcament(param_00)
{
	var_01 = spawn("script_origin",self.origin);
	var_01.angles = self.angles;
	var_01 rotateyaw(-45,0.05);
	wait(0.05);
	var_02 = self.origin + (0,0,5);
	var_03 = self.origin + anglestoforward(var_01.angles) * 100 + (0,0,128);
	var_04 = bullettrace(var_02,var_03,0,self);
	self.killcament = spawn("script_model",var_04["position"]);
	self.killcament setscriptmoverkillcam("explosive");
	param_00.killcamentnum = self.killcament getentitynumber();
	var_01 delete();
}

//Function Number: 14
onbeginuse(param_00)
{
	param_00 allowmelee(0);
	if(maps\mp\gametypes\_gameobjects::isfriendlyteam(param_00.pers["team"]))
	{
		if(!level.silentplant)
		{
			param_00 maps\mp\_utility::notify_enemy_bots_bomb_used("defuse");
			param_00 playsound("mp_snd_bomb_disarming");
			level thread play_looping_beep_on_player(param_00);
		}

		param_00.isdefusing = 1;
		if(isdefined(level.sdbombmodel))
		{
			level.sdbombmodel hide();
			stopfxontag(common_scripts\utility::getfx("bomb_light_planted"),level.sdbombmodel,"tag_flash");
			return;
		}

		return;
	}

	if(!level.silentplant)
	{
		param_00 maps\mp\_utility::notify_enemy_bots_bomb_used("plant");
		param_00 playsound("mp_snd_bomb_arming");
		level thread play_looping_beep_on_player(param_00);
	}

	param_00.isplanting = 1;
	if(level.multibomb)
	{
		for(var_01 = 0;var_01 < self.otherbombzones.size;var_01++)
		{
			self.otherbombzones[var_01] maps\mp\gametypes\_gameobjects::allowuse("none");
			self.otherbombzones[var_01] maps\mp\gametypes\_gameobjects::setvisibleteam("friendly");
		}
	}
}

//Function Number: 15
light_after_delay()
{
	wait(0.05);
	playfxontag(common_scripts\utility::getfx("bomb_light_planted"),level.sdbombmodel,"tag_flash");
}

//Function Number: 16
onenduse(param_00,param_01,param_02)
{
	if(!isdefined(param_01))
	{
		return;
	}

	param_01 allowmelee(1);
	if(isalive(param_01))
	{
		param_01.isdefusing = 0;
		param_01.isplanting = 0;
	}

	level thread stop_looping_beep_on_player(param_01);
	if(maps\mp\gametypes\_gameobjects::isfriendlyteam(param_01.pers["team"]))
	{
		if(isdefined(level.sdbombmodel) && !param_02)
		{
			level.sdbombmodel show();
			thread light_after_delay();
			return;
		}

		return;
	}

	if(level.multibomb && !param_02)
	{
		for(var_03 = 0;var_03 < self.otherbombzones.size;var_03++)
		{
			self.otherbombzones[var_03] maps\mp\gametypes\_gameobjects::allowuse("enemy");
			self.otherbombzones[var_03] maps\mp\gametypes\_gameobjects::setvisibleteam("any");
		}
	}
}

//Function Number: 17
bombplantedanim(param_00)
{
	param_00 endon("death");
	param_00 endon("disconnect");
	param_00 playerlinkto(level.sdbombmodel);
	param_00 playerlinkedoffsetenable();
	while(param_00 getcurrentweapon() == self.useweapon)
	{
		wait 0.05;
	}

	param_00 unlink();
}

//Function Number: 18
bombplanted(param_00,param_01)
{
	level notify("bomb_planted",param_00);
	maps\mp\gametypes\_gamelogic::pausetimer();
	level.bombplanted = 1;
	param_01.objective = 0;
	if(isplayer(param_01))
	{
		param_01 setclientomnvar("ui_carrying_bomb",0);
	}

	param_00.visuals[0] thread maps\mp\gametypes\_gamelogic::playtickingsound();
	level.tickingobject = param_00.visuals[0];
	level.timelimitoverride = 1;
	level.defuseendtime = int(gettime() + level.bombtimer * 1000);
	setgameendtime(level.defuseendtime);
	setomnvar("ui_bomb_timer",1);
	if(!level.multibomb)
	{
		level.sdbomb maps\mp\gametypes\_gameobjects::allowcarry("none");
		level.sdbomb maps\mp\gametypes\_gameobjects::setvisibleteam("none");
		maps\mp\_utility::setmlgicons(level.sdbomb,undefined);
		level.sdbomb maps\mp\gametypes\_gameobjects::setdropped();
		level.sdbombmodel = level.sdbomb.visuals[0];
	}
	else
	{
		level.sdbombmodel = spawn("script_model",param_01.origin);
		level.sdbombmodel.angles = param_01.angles;
		level.sdbombmodel setmodel("npc_search_dstry_bomb");
	}

	level.sdbombmodel thread invalidatecarepackageandgoliathdrop();
	playfxontag(common_scripts\utility::getfx("bomb_light_planted"),level.sdbombmodel,"tag_flash");
	param_00 maps\mp\gametypes\_gameobjects::allowuse("none");
	param_00 maps\mp\gametypes\_gameobjects::setvisibleteam("none");
	var_02 = param_00 maps\mp\gametypes\_gameobjects::getlabel();
	param_00 thread bombplantedanim(param_01);
	var_03 = param_00.bombdefusetrig;
	var_03.origin = level.sdbombmodel.origin;
	var_04 = [];
	var_05 = maps\mp\gametypes\_gameobjects::createuseobject(game["defenders"],var_03,var_04,(0,0,32));
	var_05 maps\mp\gametypes\_gameobjects::allowuse("friendly");
	var_05 maps\mp\gametypes\_gameobjects::setusetime(level.defusetime);
	var_05 maps\mp\gametypes\_gameobjects::setusehinttext(&"PLATFORM_HOLD_TO_DEFUSE_EXPLOSIVES");
	var_05 maps\mp\gametypes\_gameobjects::setvisibleteam("any");
	var_05 maps\mp\gametypes\_gameobjects::set2dicon("friendly","waypoint_defuse" + var_02);
	var_05 maps\mp\gametypes\_gameobjects::set2dicon("enemy","waypoint_defend" + var_02);
	var_05 maps\mp\gametypes\_gameobjects::set3dicon("friendly","waypoint_defuse" + var_02);
	var_05 maps\mp\gametypes\_gameobjects::set3dicon("enemy","waypoint_defend" + var_02);
	var_05.label = var_02;
	var_05.onbeginuse = ::onbeginuse;
	var_05.onenduse = ::onenduse;
	var_05.onuse = ::onusedefuseobject;
	var_05.nousebar = 1;
	var_05.id = "defuseObject";
	var_05.useweapon = "search_dstry_bomb_defuse_mp";
	if(var_02 == "_a" || var_02 == "_A")
	{
		setomnvar("ui_mlg_game_mode_status_1",1);
	}
	else if(var_02 == "_b" || var_02 == "_B")
	{
		setomnvar("ui_mlg_game_mode_status_1",2);
	}

	maps\mp\_utility::playsoundinspace("mp_snd_bomb_planted",level.sdbombmodel.origin + (0,0,1));
	bombtimerwait();
	setomnvar("ui_bomb_timer",0);
	param_00.visuals[0] maps\mp\gametypes\_gamelogic::stoptickingsound();
	if(level.gameended || level.bombdefused)
	{
		return;
	}

	level.bombexploded = 1;
	setomnvar("ui_mlg_game_mode_status_1",0);
	if(isdefined(level.sd_onbombtimerend))
	{
		level thread [[ level.sd_onbombtimerend ]]();
	}
	else
	{
		var_06 = level.sdbombmodel.origin;
		var_06 = var_06 + (0,0,10);
		level.sdbombmodel hide();
		stopfxontag(common_scripts\utility::getfx("bomb_light_planted"),level.sdbombmodel,"tag_flash");
		if(isdefined(param_01))
		{
			param_00.visuals[0] radiusdamage(var_06,512,300,20,param_01,"MOD_EXPLOSIVE","bomb_site_mp");
			param_01 thread maps\mp\_events::bombdetonateevent();
		}
		else
		{
			param_00.visuals[0] radiusdamage(var_06,512,300,20,undefined,"MOD_EXPLOSIVE","bomb_site_mp");
		}

		var_07 = "bomb_explosion";
		if(isdefined(param_00.trigger.effect))
		{
			var_07 = param_00.trigger.effect;
		}

		var_08 = randomfloat(360);
		var_09 = var_06 + (0,0,50);
		var_0A = spawnfx(level._effect[var_07],var_09 + (0,0,50),(0,0,1),(cos(var_08),sin(var_08),0));
		triggerfx(var_0A);
		physicsexplosionsphere(var_09,200,100,3);
		playrumbleonposition("grenade_rumble",var_06);
		earthquake(0.75,2,var_06,2000);
		thread maps\mp\_utility::playsoundinspace("mp_snd_bomb_detonated",var_06);
		if(isdefined(param_00.exploderindex))
		{
			common_scripts\_exploder::exploder(param_00.exploderindex);
		}
	}

	for(var_0B = 0;var_0B < level.bombzones.size;var_0B++)
	{
		level.bombzones[var_0B] maps\mp\gametypes\_gameobjects::disableobject();
	}

	var_05 maps\mp\gametypes\_gameobjects::disableobject();
	setgameendtime(0);
	wait(3);
	sd_endgame(game["attackers"],game["end_reason"]["target_destroyed"]);
}

//Function Number: 19
invalidatecarepackageandgoliathdrop()
{
	var_00 = self;
	var_01 = 64;
	var_02 = 64;
	var_03 = var_00.origin + (0,0,-4);
	var_04 = spawn("trigger_radius",var_03,0,var_01,var_02);
	var_04.targetname = "orbital_node_covered";
	var_04.script_noteworthy = "dont_move_me";
	if(!isdefined(level.orbital_util_covered_volumes))
	{
		level.orbital_util_covered_volumes = [];
	}

	var_05 = 0;
	if(level.orbital_util_covered_volumes.size > 0)
	{
		foreach(var_07 in level.orbital_util_covered_volumes)
		{
			if(var_07 == var_04)
			{
				var_05 = 1;
				break;
			}
		}
	}

	if(var_05 == 0)
	{
		level.orbital_util_covered_volumes[level.orbital_util_covered_volumes.size] = var_04;
	}

	if(!isdefined(level.goliath_bad_landing_volumes))
	{
		level.goliath_bad_landing_volumes = [];
	}

	var_09 = 0;
	if(level.goliath_bad_landing_volumes.size > 0)
	{
		foreach(var_07 in level.goliath_bad_landing_volumes)
		{
			if(var_07 == var_04)
			{
				var_09 = 1;
				break;
			}
		}
	}

	if(var_09 == 0)
	{
		level.goliath_bad_landing_volumes[level.goliath_bad_landing_volumes.size] = var_04;
	}

	var_0C = getnodesinradiussorted(var_03,var_01,0,var_02);
	if(var_0C.size > 0)
	{
		foreach(var_0E in var_0C)
		{
			nodesetremotemissilename(var_0E,"none");
		}
	}

	common_scripts\utility::waittill_any("bomb_defused","game_ended");
	level.goliath_bad_landing_volumes = common_scripts\utility::array_remove(level.goliath_bad_landing_volumes,var_04);
	level.goliath_bad_landing_volumes = common_scripts\utility::array_remove_duplicates(level.goliath_bad_landing_volumes);
	level.orbital_util_covered_volumes = common_scripts\utility::array_remove(level.orbital_util_covered_volumes,var_04);
	level.orbital_util_covered_volumes = common_scripts\utility::array_remove_duplicates(level.orbital_util_covered_volumes);
	var_04 delete();
	if(var_0C.size > 0)
	{
		foreach(var_0E in var_0C)
		{
			nodesetremotemissilename(var_0E,"up");
		}
	}
}

//Function Number: 20
bombtimerwait()
{
	level endon("game_ended");
	level endon("bomb_defused");
	var_00 = int(level.bombtimer * 1000 + gettime());
	setomnvar("ui_bomb_timer_endtime",var_00);
	level thread handlehostmigration(var_00);
	maps\mp\gametypes\_hostmigration::waitlongdurationwithgameendtimeupdate(level.bombtimer);
}

//Function Number: 21
handlehostmigration(param_00)
{
	level endon("game_ended");
	level endon("bomb_defused");
	level endon("game_ended");
	level endon("disconnect");
	level waittill("host_migration_begin");
	setomnvar("ui_bomb_timer_endtime",0);
	var_01 = maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();
	if(var_01 > 0)
	{
		setomnvar("ui_bomb_timer_endtime",param_00 + var_01);
	}
}

//Function Number: 22
ondrop(param_00)
{
	maps\mp\gametypes\_gameobjects::set2dicon("friendly","waypoint_bomb");
	maps\mp\gametypes\_gameobjects::set3dicon("friendly","waypoint_bomb");
	maps\mp\_utility::playsoundonplayers(game["bomb_dropped_sound"],game["attackers"]);
	maps\mp\_utility::playsoundonplayers(game["bomb_dropped_enemy_sound"],game["defenders"]);
}

//Function Number: 23
canuse(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	if(param_00 maps\mp\_utility::isjuggernaut())
	{
		return 0;
	}

	if(isdefined(param_00.enteringgoliath) && param_00.enteringgoliath == 1)
	{
		return 0;
	}

	return 1;
}

//Function Number: 24
goliathdropbomb()
{
	level endon("game_ended");
	self endon("death");
	self endon("disconnect");
	self endon("joined_team");
	self waittill("goliath_equipped");
	if(isdefined(self.carryobject))
	{
		self.isbombcarrier = 0;
		self setclientomnvar("ui_carrying_bomb",0);
		self.carryobject thread maps\mp\gametypes\_gameobjects::setdropped();
	}
}

//Function Number: 25
onusedefuseobject(param_00)
{
	param_00 notify("bomb_defused");
	level thread bombdefused();
	maps\mp\gametypes\_gameobjects::disableobject();
	maps\mp\_utility::leaderdialog("bomb_defused_attackers",game["attackers"]);
	maps\mp\_utility::leaderdialog("bomb_defused_defenders",game["defenders"]);
	maps\mp\_utility::playsoundonplayers(game["bomb_disarm_enemy_sound"],game["attackers"]);
	maps\mp\_utility::playsoundonplayers(game["bomb_disarm_sound"],game["defenders"]);
	var_01 = "defuse";
	if(isdefined(level.bombowner) && maps\mp\_utility::isreallyalive(level.bombowner) && level.bombowner.bombplantedtime + 6000 + level.defusetime * 1000 > gettime())
	{
		var_01 = "ninja_defuse";
	}

	if(islastplayeralive(param_00))
	{
		var_01 = "last_man_defuse";
	}

	param_00 thread maps\mp\_events::bombdefuseevent(var_01);
}

//Function Number: 26
islastplayeralive(param_00)
{
	foreach(var_02 in level.players)
	{
		if(var_02 == param_00)
		{
			continue;
		}

		if(var_02 maps\mp\gametypes\_playerlogic::mayspawn())
		{
			return 0;
		}

		if(maps\mp\_utility::isreallyalive(var_02))
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 27
bombdefused()
{
	level.tickingobject maps\mp\gametypes\_gamelogic::stoptickingsound();
	level.bombdefused = 1;
	setomnvar("ui_bomb_timer",0);
	setomnvar("ui_mlg_game_mode_status_1",0);
	level notify("bomb_defused");
	wait(1.5);
	setgameendtime(0);
	sd_endgame(game["defenders"],game["end_reason"]["bomb_defused"]);
}

//Function Number: 28
oncantuse(param_00)
{
	param_00 iprintlnbold(&"MP_CANT_PLANT_WITHOUT_BOMB");
}

//Function Number: 29
ontimelimit()
{
	sd_endgame(game["defenders"],game["end_reason"]["time_limit_reached"]);
}

//Function Number: 30
sd_endgame(param_00,param_01)
{
	level.finalkillcam_winner = param_00;
	if(param_01 == game["end_reason"]["target_destroyed"] || param_01 == game["end_reason"]["bomb_defused"])
	{
		var_02 = 1;
		foreach(var_04 in level.bombzones)
		{
			if(isdefined(level.finalkillcam_killcamentityindex[param_00]) && level.finalkillcam_killcamentityindex[param_00] == var_04.killcamentnum)
			{
				var_02 = 0;
				break;
			}
		}

		if(var_02)
		{
			maps\mp\gametypes\_damage::erasefinalkillcam();
		}
	}

	maps\mp\gametypes\_gamescore::giveteamscoreforobjective(param_00,1);
	thread maps\mp\gametypes\_gamelogic::endgame(param_00,param_01);
}

//Function Number: 31
checkallowspectating()
{
	wait(0.05);
	var_00 = 0;
	if(!level.alivecount[game["attackers"]])
	{
		level.spectateoverride[game["attackers"]].allowenemyspectate = 1;
		var_00 = 1;
	}

	if(!level.alivecount[game["defenders"]])
	{
		level.spectateoverride[game["defenders"]].allowenemyspectate = 1;
		var_00 = 1;
	}

	if(var_00)
	{
		maps\mp\gametypes\_spectating::updatespectatesettings();
	}
}

//Function Number: 32
ondeadevent(param_00)
{
	if(level.bombexploded || level.bombdefused)
	{
		return;
	}

	if(param_00 == "all")
	{
		if(level.bombplanted)
		{
			sd_endgame(game["attackers"],game["end_reason"][game["defenders"] + "_eliminated"]);
			return;
		}

		sd_endgame(game["defenders"],game["end_reason"][game["attackers"] + "_eliminated"]);
		return;
	}

	if(param_00 == game["attackers"])
	{
		if(level.bombplanted)
		{
			return;
		}

		level thread sd_endgame(game["defenders"],game["end_reason"][game["attackers"] + "_eliminated"]);
		return;
	}

	if(param_00 == game["defenders"])
	{
		level thread sd_endgame(game["attackers"],game["end_reason"][game["defenders"] + "_eliminated"]);
		return;
	}
}

//Function Number: 33
ononeleftevent(param_00)
{
	if(level.bombexploded || level.bombdefused)
	{
		return;
	}

	var_01 = maps\mp\_utility::getlastlivingplayer(param_00);
	var_01 thread givelastonteamwarning();
}

//Function Number: 34
givelastonteamwarning()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	maps\mp\_utility::waittillrecoveredhealth(3);
	var_00 = maps\mp\_utility::getotherteam(self.pers["team"]);
	level thread maps\mp\_utility::teamplayercardsplash("callout_lastteammemberalive",self,self.pers["team"]);
	level thread maps\mp\_utility::teamplayercardsplash("callout_lastenemyalive",self,var_00);
	level notify("last_alive",self);
	maps\mp\gametypes\_missions::lastmansd();
}

//Function Number: 35
onreset()
{
}

//Function Number: 36
applybombcarrierclass()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	if(isdefined(self.iscarrying) && self.iscarrying == 1)
	{
		self notify("force_cancel_placement");
		wait(0.05);
	}

	while(self ismantling())
	{
		wait(0.05);
	}

	while(!self isonground())
	{
		wait(0.05);
	}

	if(maps\mp\_utility::isjuggernaut())
	{
		self notify("lost_juggernaut");
		wait(0.05);
	}

	self.pers["gamemodeLoadout"] = level.sd_loadout[self.team];
	self.gamemode_chosenclass = self.class;
	self.gamemode_carrierclass = 1;
	self.pers["class"] = "gamemode";
	self.pers["lastClass"] = "gamemode";
	self.class = "gamemode";
	self.lastclass = "gamemode";
	self notify("faux_spawn");
	maps\mp\gametypes\_class::giveandapplyloadout(self.team,"gamemode");
	if(self.loadoutkeepcurrentkillstreaks)
	{
		maps\mp\killstreaks\_killstreaks::updatekillstreaks(1);
	}

	refillbattery();
}

//Function Number: 37
refillbattery()
{
	var_00 = self getweaponslistoffhands();
	foreach(var_02 in var_00)
	{
		self batteryfullrecharge(var_02);
	}
}

//Function Number: 38
removebombcarrierclass()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	if(isdefined(self.iscarrying) && self.iscarrying == 1)
	{
		self notify("force_cancel_placement");
		wait(0.05);
	}

	while(self ismantling())
	{
		wait(0.05);
	}

	while(!self isonground())
	{
		wait(0.05);
	}

	if(maps\mp\_utility::isjuggernaut())
	{
		self notify("lost_juggernaut");
		wait(0.05);
	}

	self.pers["gamemodeLoadout"] = undefined;
	self notify("faux_spawn");
	maps\mp\gametypes\_class::giveandapplyloadout(self.team,self.class);
	if(self.loadoutkeepcurrentkillstreaks)
	{
		maps\mp\killstreaks\_killstreaks::updatekillstreaks(1);
	}

	refillbattery();
}