/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\common_bomb_gameobject.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 22
 * Decompile Time: 390 ms
 * Timestamp: 10/27/2023 2:37:59 AM
*******************************************************************/

//Function Number: 1
onprecachegametype()
{
	game["bomb_grabbed_sound"] = "mp_suitcase_pickup";
	game["bomb_dropped_sound"] = "h1_mp_war_objective_lost";
	game["bomb_dropped_enemy_sound"] = "h1_mp_war_objective_taken";
	game["bomb_recovered_sound"] = "h1_mp_war_objective_taken";
	game["bomb_planted_sound"] = "mp_obj_notify_pos_med";
	game["bomb_planted_enemy_sound"] = "mp_obj_notify_neg_med";
	game["bomb_disarm_sound"] = "mp_obj_notify_pos_lrg";
	game["bomb_disarm_enemy_sound"] = "mp_obj_notify_neg_lrg";
}

//Function Number: 2
loadbombfx()
{
	level._effect["bomb_explosion"] = loadfx("vfx/explosion/mp_gametype_bomb");
}

//Function Number: 3
getcarrybombvisuals(param_00)
{
	var_01 = getent(param_00,"targetname");
	if(isdefined(var_01))
	{
		var_01 setmodel("wpn_h1_briefcase_bomb_npc");
		return [var_01];
	}

	return undefined;
}

//Function Number: 4
createbombcarryobject(param_00,param_01,param_02,param_03)
{
	var_04 = maps\mp\gametypes\_gameobjects::createcarryobject(param_00,param_02,param_03,(0,0,32));
	var_04 maps\mp\gametypes\_gameobjects::allowcarry(param_01);
	var_04 maps\mp\gametypes\_gameobjects::setvisibleteam(param_01);
	if(param_01 == "friendly" || param_01 == "any")
	{
		var_04 maps\mp\gametypes\_gameobjects::set2dicon("friendly","waypoint_bomb");
		var_04 maps\mp\gametypes\_gameobjects::set3dicon("friendly","waypoint_bomb");
	}

	if(param_01 == "enemy" || param_01 == "any")
	{
		var_04 maps\mp\gametypes\_gameobjects::set2dicon("enemy","waypoint_bomb");
		var_04 maps\mp\gametypes\_gameobjects::set3dicon("enemy","waypoint_bomb");
	}

	var_04.allowweapons = 1;
	var_04.canuseobject = ::canusebomb;
	foreach(var_06 in param_03)
	{
		var_06 notsolid();
	}

	return var_04;
}

//Function Number: 5
canusebomb(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	if(param_00 maps\mp\_utility::isjuggernaut())
	{
		return 0;
	}

	return 1;
}

//Function Number: 6
oncarrybombpickup(param_00,param_01)
{
	level notify("bomb_picked_up");
	param_00.isbombcarrier = 1;
	if(isplayer(param_00))
	{
		param_00 thread maps\mp\_matchdata::loggameevent("pickup",param_00.origin);
		param_00 setclientomnvar("ui_carrying_bomb",1);
	}

	maps\mp\gametypes\_gameobjects::set2dicon("friendly","waypoint_escort");
	maps\mp\gametypes\_gameobjects::set3dicon("friendly","waypoint_escort");
	if(isdefined(param_01))
	{
		maps\mp\_utility::playsoundonplayers(game["bomb_recovered_sound"],param_01);
	}
	else
	{
		maps\mp\_utility::playsoundonplayers(game["bomb_recovered_sound"]);
	}

	param_00 playlocalsound(game["bomb_grabbed_sound"]);
}

//Function Number: 7
oncarrybombdrop(param_00,param_01)
{
	maps\mp\gametypes\_gameobjects::set2dicon("friendly","waypoint_bomb");
	maps\mp\gametypes\_gameobjects::set3dicon("friendly","waypoint_bomb");
	maps\mp\_utility::playsoundonplayers(game["bomb_dropped_sound"],param_00);
}

//Function Number: 8
createbombzoneobject(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = getentarray(param_03.target,"targetname");
	var_07 = maps\mp\gametypes\_gameobjects::createuseobject(param_00,param_03,var_06,(0,0,64));
	var_07.label = var_07 maps\mp\gametypes\_gameobjects::getlabel();
	var_07 resetbombzone(param_04,param_01,param_02,param_05);
	var_07.nousebar = 1;
	var_07.id = "bombZone";
	for(var_08 = 0;var_08 < var_06.size;var_08++)
	{
		if(isdefined(var_06[var_08].script_exploder))
		{
			var_07.exploderindex = var_06[var_08].script_exploder;
			var_06[var_08] thread setupkillcament(var_07);
			break;
		}
	}

	return var_07;
}

//Function Number: 9
resetbombzone(param_00,param_01,param_02,param_03)
{
	maps\mp\gametypes\_gameobjects::allowuse(param_01);
	maps\mp\gametypes\_gameobjects::setvisibleteam(param_02);
	maps\mp\gametypes\_gameobjects::setusetime(level.planttime);
	maps\mp\gametypes\_gameobjects::setusehinttext(&"PLATFORM_HOLD_TO_PLANT_EXPLOSIVES");
	maps\mp\gametypes\_gameobjects::setkeyobject(param_00);
	var_04 = "waypoint_defend";
	var_05 = "waypoint_target";
	if(param_01 == "any")
	{
		var_04 = "waypoint_target";
		var_05 = "waypoint_target";
	}

	if(param_03)
	{
		var_04 = var_04 + self.label;
		var_05 = var_05 + self.label;
	}

	maps\mp\gametypes\_gameobjects::set2dicon("friendly",var_04);
	maps\mp\gametypes\_gameobjects::set3dicon("friendly",var_04);
	maps\mp\gametypes\_gameobjects::set2dicon("enemy",var_05);
	maps\mp\gametypes\_gameobjects::set3dicon("enemy",var_05);
	self.useweapon = "briefcase_bomb_mp";
	self.cantuseweapon = "briefcase_bomb_defuse_mp";
	self.bombplantedon = 0;
}

//Function Number: 10
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

//Function Number: 11
setupzonefordefusing(param_00)
{
	var_01 = "waypoint_defuse";
	var_02 = "waypoint_defend";
	if(param_00)
	{
		var_01 = var_01 + self.label;
		var_02 = var_02 + self.label;
	}

	maps\mp\gametypes\_gameobjects::allowuse("friendly");
	maps\mp\gametypes\_gameobjects::setusetime(level.defusetime);
	maps\mp\gametypes\_gameobjects::setusehinttext(&"PLATFORM_HOLD_TO_DEFUSE_EXPLOSIVES");
	maps\mp\gametypes\_gameobjects::setkeyobject(undefined);
	maps\mp\gametypes\_gameobjects::set2dicon("friendly",var_01);
	maps\mp\gametypes\_gameobjects::set3dicon("friendly",var_01);
	maps\mp\gametypes\_gameobjects::set2dicon("enemy",var_02);
	maps\mp\gametypes\_gameobjects::set3dicon("enemy",var_02);
	maps\mp\gametypes\_gameobjects::setvisibleteam("any");
	self.useweapon = "briefcase_bomb_defuse_mp";
	self.cantuseweapon = "briefcase_bomb_mp";
}

//Function Number: 12
onbeginplantbomb(param_00)
{
	param_00 allowmelee(0);
	if(!level.silentplant)
	{
		param_00 maps\mp\_utility::notify_enemy_bots_bomb_used("plant");
		param_00 playsound("mp_snd_bomb_arming");
		level thread play_looping_beep_on_player(param_00);
	}

	param_00.isplanting = 1;
}

//Function Number: 13
onbegindefusebomb(param_00,param_01)
{
	param_00 allowmelee(0);
	if(!level.silentplant)
	{
		param_00 maps\mp\_utility::notify_enemy_bots_bomb_used("defuse");
		param_00 playsound("mp_snd_bomb_disarming");
		level thread play_looping_beep_on_player(param_00);
	}

	param_00.isdefusing = 1;
	if(isdefined(param_01))
	{
		param_01 hide();
		self.hiddenmodel = param_01;
	}
}

//Function Number: 14
play_looping_beep_on_player(param_00)
{
	var_01 = common_scripts\utility::array_remove(level.players,param_00);
	if(var_01.size)
	{
		param_00 maps\mp\_utility::playloopsoundtoplayers("snd_bomb_button_press_lp",undefined,var_01);
	}
}

//Function Number: 15
stop_looping_beep_on_player(param_00)
{
	param_00 common_scripts\utility::stop_loop_sound_on_entity("snd_bomb_button_press_lp");
}

//Function Number: 16
onendusebomb(param_00,param_01)
{
	if(!isdefined(param_00))
	{
		return;
	}

	param_00 allowmelee(1);
	if(isalive(param_00))
	{
		param_00.isdefusing = 0;
		param_00.isplanting = 0;
	}

	level thread stop_looping_beep_on_player(param_00);
	param_00 method_854D("weap_suitcase_raise_plr");
	if(param_01 && isdefined(self.hiddenmodel))
	{
		self.hiddenmodel show();
		self.hiddenmodel = undefined;
	}
}

//Function Number: 17
onplayerplantbomb(param_00,param_01,param_02)
{
	self notify("bomb_planted");
	thread maps\mp\_events::bombplantevent();
	self.bombplantedtime = gettime();
	if(isplayer(self) && param_00)
	{
		self.isbombcarrier = 0;
		self setclientomnvar("ui_carrying_bomb",0);
	}

	self playsound("mp_bomb_plant");
	maps\mp\_utility::playsoundonplayers(game["bomb_planted_sound"],param_01);
	maps\mp\_utility::playsoundonplayers(game["bomb_planted_enemy_sound"],param_02);
	maps\mp\_utility::leaderdialog("bomb_planted");
	level.bombowner = self;
}

//Function Number: 18
onbombplanted(param_00)
{
	level notify("bomb_planted",self);
	self.bombplantedon = 1;
	level.timelimitoverride = 1;
	maps\mp\gametypes\_gamelogic::pausetimer();
	level.timepausestart = gettime();
	maps\mp\_utility::playsoundinspace("mp_snd_bomb_planted",param_00);
	self.tickingobject = self.visuals[0];
	self.tickingobject thread playtickingsound();
}

//Function Number: 19
playtickingsound()
{
	self endon("death");
	self endon("stop_ticking");
	level endon("game_ended");
	var_00 = level.bombtimer;
	for(;;)
	{
		self playsound("ui_mp_suitcasebomb_timer");
		if(var_00 > 10)
		{
			var_00 = var_00 - 1;
			wait(1);
		}
		else if(var_00 > 4)
		{
			var_00 = var_00 - 0.5;
			wait(0.5);
		}
		else if(var_00 > 1)
		{
			var_00 = var_00 - 0.4;
			wait(0.4);
		}
		else
		{
			var_00 = var_00 - 0.3;
			wait(0.3);
		}

		maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();
	}
}

//Function Number: 20
stoptickingsound()
{
	self notify("stop_ticking");
}

//Function Number: 21
onplayerdefusebomb(param_00,param_01,param_02)
{
	self notify("bomb_defused");
	thread maps\mp\_events::bombdefuseevent(param_00);
	maps\mp\_utility::playsoundonplayers(game["bomb_disarm_sound"],param_01);
	maps\mp\_utility::playsoundonplayers(game["bomb_disarm_enemy_sound"],param_02);
	maps\mp\_utility::leaderdialog("bomb_defused");
	level.bombowner = undefined;
}

//Function Number: 22
onbombexploded(param_00,param_01,param_02)
{
	if(isdefined(param_02))
	{
		self.visuals[0] radiusdamage(param_00,512,param_01,20,param_02,"MOD_EXPLOSIVE","bomb_site_mp");
		param_02 thread maps\mp\_events::bombdetonateevent();
	}
	else
	{
		self.visuals[0] radiusdamage(param_00,512,param_01,20,undefined,"MOD_EXPLOSIVE","bomb_site_mp");
	}

	var_03 = "bomb_explosion";
	if(isdefined(self.trigger.effect))
	{
		var_03 = self.trigger.effect;
	}

	var_04 = randomfloat(360);
	var_05 = param_00 + (0,0,50);
	var_06 = spawnfx(level._effect[var_03],var_05 + (0,0,50),(0,0,1),(cos(var_04),sin(var_04),0));
	triggerfx(var_06);
	physicsexplosionsphere(var_05,200,100,3);
	playrumbleonposition("grenade_rumble",param_00);
	earthquake(0.75,2,param_00,2000);
	thread maps\mp\_utility::playsoundinspace("h1_briefcase_exp_mid",param_00);
	if(isdefined(self.exploderindex))
	{
		common_scripts\_exploder::exploder(self.exploderindex);
	}
}