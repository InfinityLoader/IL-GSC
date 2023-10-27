/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\killstreaks\_remoteuav.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 59
 * Decompile Time: 1090 ms
 * Timestamp: 10/27/2023 2:27:22 AM
*******************************************************************/

//Function Number: 1
init()
{
	precachemodel("vehicle_remote_uav");
	precachemodel("test_vehicle_little_bird_toy_placement");
	precachemodel("test_vehicle_little_bird_toy_placement_failed");
	if(level.console)
	{
		precachevehicle("remote_uav_mp");
	}
	else
	{
		precachevehicle("remote_uav_mp_pc");
	}

	precacheitem("uav_remote_mp");
	precacheitem("killstreak_remote_uav_mp");
	precacheshader("veh_hud_target");
	precacheshader("veh_hud_target_marked");
	precacheshader("veh_hud_target_unmarked");
	precacheshader("compassping_sentry_enemy");
	precacheshader("compassping_enemy_uav");
	precacheshader("hud_fofbox_hostile_vehicle");
	precacherumble("damage_light");
	precachestring(&"MP_REMOTE_UAV_PLACE");
	precachestring(&"MP_REMOTE_UAV_CANNOT_PLACE");
	precachestring(&"SPLASHES_DESTROYED_REMOTE_UAV");
	precachestring(&"SPLASHES_MARKED_BY_REMOTE_UAV");
	precachestring(&"SPLASHES_REMOTE_UAV_MARKED");
	precachestring(&"SPLASHES_TURRET_MARKED_BY_REMOTE_UAV");
	precachestring(&"SPLASHES_REMOTE_UAV_ASSIST");
	level.remoteuav_fx["hit"] = loadfx("impacts/large_metal_painted_hit");
	level.remoteuav_fx["smoke"] = loadfx("smoke/remote_heli_damage_smoke_runner");
	level.remoteuav_fx["explode"] = loadfx("explosions/bouncing_betty_explosion");
	level.remoteuav_fx["missile_explode"] = loadfx("explosions/stinger_explosion");
	level.remoteuav_dialog["launch"][0] = "ac130_plt_yeahcleared";
	level.remoteuav_dialog["launch"][1] = "ac130_plt_rollinin";
	level.remoteuav_dialog["launch"][2] = "ac130_plt_scanrange";
	level.remoteuav_dialog["out_of_range"][0] = "ac130_plt_cleanup";
	level.remoteuav_dialog["out_of_range"][1] = "ac130_plt_targetreset";
	level.remoteuav_dialog["track"][0] = "ac130_fco_moreenemy";
	level.remoteuav_dialog["track"][1] = "ac130_fco_getthatguy";
	level.remoteuav_dialog["track"][2] = "ac130_fco_guymovin";
	level.remoteuav_dialog["track"][3] = "ac130_fco_getperson";
	level.remoteuav_dialog["track"][4] = "ac130_fco_guyrunnin";
	level.remoteuav_dialog["track"][5] = "ac130_fco_gotarunner";
	level.remoteuav_dialog["track"][6] = "ac130_fco_backonthose";
	level.remoteuav_dialog["track"][7] = "ac130_fco_gonnagethim";
	level.remoteuav_dialog["track"][8] = "ac130_fco_personnelthere";
	level.remoteuav_dialog["track"][9] = "ac130_fco_rightthere";
	level.remoteuav_dialog["track"][10] = "ac130_fco_tracking";
	level.remoteuav_dialog["tag"][0] = "ac130_fco_nice";
	level.remoteuav_dialog["tag"][1] = "ac130_fco_yougothim";
	level.remoteuav_dialog["tag"][2] = "ac130_fco_yougothim2";
	level.remoteuav_dialog["tag"][3] = "ac130_fco_okyougothim";
	level.remoteuav_dialog["assist"][0] = "ac130_fco_goodkill";
	level.remoteuav_dialog["assist"][1] = "ac130_fco_thatsahit";
	level.remoteuav_dialog["assist"][2] = "ac130_fco_directhit";
	level.remoteuav_dialog["assist"][3] = "ac130_fco_rightontarget";
	level.remoteuav_lastdialogtime = 0;
	level.remoteuav_nodeployzones = getentarray("no_vehicles","targetname");
	level.killstreakfuncs["remote_uav"] = ::useremoteuav;
	level.remote_uav = [];
}

//Function Number: 2
useremoteuav(param_00)
{
	return tryuseremoteuav(param_00,"remote_uav");
}

//Function Number: 3
func_8241(param_00)
{
	if(level.gametype == "dm")
	{
		if(isdefined(level.remote_uav[param_00]) || isdefined(level.remote_uav[level.otherteam[param_00]]))
		{
			return 1;
		}

		return 0;
	}

	if(isdefined(level.remote_uav[param_00]))
	{
		return 1;
	}

	return 0;
}

//Function Number: 4
tryuseremoteuav(param_00,param_01)
{
	common_scripts\utility::_disableusability();
	if(maps\mp\_utility::isusingremote() || self isusingturret() || isdefined(level.nukeincoming))
	{
		common_scripts\utility::_enableusability();
		return 0;
	}

	var_02 = 1;
	if(func_8241(self.team) || level.littlebirds.size >= 4)
	{
		self iprintlnbold(&"MP_AIR_SPACE_TOO_CROWDED");
		common_scripts\utility::_enableusability();
		return 0;
	}
	else if(maps\mp\_utility::func_2BEC() >= maps\mp\_utility::maxvehiclesallowed() || level.fauxvehiclecount + var_02 >= maps\mp\_utility::maxvehiclesallowed())
	{
		self iprintlnbold(&"MP_TOO_MANY_VEHICLES");
		common_scripts\utility::_enableusability();
		return 0;
	}

	self setplayerdata("reconDroneState","staticAlpha",0);
	self setplayerdata("reconDroneState","incomingMissile",0);
	maps\mp\_utility::func_80C7();
	var_03 = givecarryremoteuav(param_00,param_01);
	if(var_03)
	{
		maps\mp\_matchdata::logkillstreakevent(param_01,self.origin);
		thread maps\mp\_utility::teamplayercardsplash("used_remote_uav",self);
	}
	else
	{
		maps\mp\_utility::func_80C8();
	}

	self.iscarrying = 0;
	return var_03;
}

//Function Number: 5
givecarryremoteuav(param_00,param_01)
{
	var_02 = func_2C61(param_01,self);
	self takeweapon("killstreak_uav_mp");
	maps\mp\_utility::_giveweapon("killstreak_remote_uav_mp");
	self switchtoweaponimmediate("killstreak_remote_uav_mp");
	setcarryingremoteuav(var_02);
	if(isalive(self) && isdefined(var_02))
	{
		var_03 = var_02.origin;
		var_04 = self.angles;
		var_02.var_8242 delete();
		var_02 delete();
		var_05 = func_2C6F(param_00,param_01,var_03,var_04);
	}
	else
	{
		var_05 = 0;
		if(isalive(self))
		{
			self takeweapon("killstreak_remote_uav_mp");
			maps\mp\_utility::_giveweapon("killstreak_uav_mp");
		}
	}

	return var_05;
}

//Function Number: 6
func_2C61(param_00,param_01)
{
	var_02 = param_01.origin + anglestoforward(param_01.angles) * 4 + anglestoup(param_01.angles) * 50;
	var_03 = spawnturret("misc_turret",var_02,"sentry_minigun_mp");
	var_03.origin = var_02;
	var_03.angles = param_01.angles;
	var_03.sentrytype = "sentry_minigun";
	var_03.canbeplaced = 1;
	var_03 setturretmodechangewait(1);
	var_03 setmode("sentry_offline");
	var_03 makeunusable();
	var_03 maketurretinoperable();
	var_03.owner = param_01;
	var_03 setsentryowner(var_03.owner);
	var_03.scale = 3;
	var_03.var_2C64 = 0;
	var_03 thread func_2C6D();
	var_03.rangetrigger = getent("remote_uav_range","targetname");
	if(!isdefined(var_03.rangetrigger))
	{
		var_04 = getent("airstrikeheight","targetname");
		var_03.maxheight = var_04.origin[2];
		var_03.maxdistance = 3600;
	}

	var_03.var_8242 = spawn("script_origin",var_03.origin);
	var_03.var_8242.angles = var_03.angles;
	var_03.var_8242.origin = var_03.origin;
	var_03.var_8242 linkto(var_03);
	var_03.var_8242 playloopsound("recondrone_idle_high");
	return var_03;
}

//Function Number: 7
setcarryingremoteuav(param_00)
{
	param_00 thread func_2C6A(self);
	self notifyonplayercommand("place_carryRemoteUAV","+attack");
	self notifyonplayercommand("place_carryRemoteUAV","+attack_akimbo_accessible");
	self notifyonplayercommand("cancel_carryRemoteUAV","+actionslot 4");
	if(!level.console)
	{
		self notifyonplayercommand("cancel_carryRemoteUAV","+actionslot 5");
		self notifyonplayercommand("cancel_carryRemoteUAV","+actionslot 6");
		self notifyonplayercommand("cancel_carryRemoteUAV","+actionslot 7");
	}

	for(;;)
	{
		var_01 = local_waittill_any_return("place_carryRemoteUAV","cancel_carryRemoteUAV","weapon_switch_started","force_cancel_placement","death","disconnect");
		self forceusehintoff();
		if(var_01 != "place_carryRemoteUAV")
		{
			carryremoteuav_delete(param_00);
			break;
		}

		if(!param_00.canbeplaced)
		{
			if(self.team != "spectator")
			{
				self forceusehinton(&"MP_REMOTE_UAV_CANNOT_PLACE");
			}

			continue;
		}

		if(isdefined(level.nukeincoming) || maps\mp\_utility::func_27E5() || func_8241(self.team) || maps\mp\_utility::func_2BEC() >= maps\mp\_utility::maxvehiclesallowed() || level.fauxvehiclecount >= maps\mp\_utility::maxvehiclesallowed())
		{
			if(isdefined(level.nukeincoming) || maps\mp\_utility::func_27E5())
			{
				self iprintlnbold(&"MP_UNAVAILABLE_FOR_N_WHEN_EMP",level.emptimeremaining);
			}
			else
			{
				self iprintlnbold(&"MP_TOO_MANY_VEHICLES");
			}

			carryremoteuav_delete(param_00);
			break;
		}

		self.iscarrying = 0;
		param_00.carriedby = undefined;
		param_00 playsound("sentry_gun_plant");
		param_00 notify("placed");
		break;
	}
}

//Function Number: 8
local_waittill_any_return(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if((!isdefined(param_00) || param_00 != "death") && !isdefined(param_01) || param_01 != "death" && !isdefined(param_02) || param_02 != "death" && !isdefined(param_03) || param_03 != "death" && !isdefined(param_04) || param_04 != "death")
	{
		self endon("death");
	}

	var_06 = spawnstruct();
	if(isdefined(param_00))
	{
		thread common_scripts\utility::waittill_string(param_00,var_06);
	}

	if(isdefined(param_01))
	{
		thread common_scripts\utility::waittill_string(param_01,var_06);
	}

	if(isdefined(param_02))
	{
		thread common_scripts\utility::waittill_string(param_02,var_06);
	}

	if(isdefined(param_03))
	{
		thread common_scripts\utility::waittill_string(param_03,var_06);
	}

	if(isdefined(param_04))
	{
		thread common_scripts\utility::waittill_string(param_04,var_06);
	}

	if(isdefined(param_05))
	{
		thread common_scripts\utility::waittill_string(param_05,var_06);
	}

	var_06 waittill("returned",var_07);
	var_06 notify("die");
	return var_07;
}

//Function Number: 9
func_2C6A(param_00)
{
	self setcandamage(0);
	self setsentrycarrier(param_00);
	self setcontents(0);
	self.carriedby = param_00;
	param_00.iscarrying = 1;
	param_00 thread func_2C6C(self);
	self notify("carried");
}

//Function Number: 10
carryremoteuav_delete(param_00)
{
	self.iscarrying = 0;
	if(isdefined(param_00))
	{
		if(isdefined(param_00.var_8242))
		{
			param_00.var_8242 delete();
		}

		param_00 delete();
	}
}

//Function Number: 11
func_2C6B()
{
	if(isdefined(level.remoteuav_nodeployzones) && level.remoteuav_nodeployzones.size)
	{
		foreach(var_01 in level.remoteuav_nodeployzones)
		{
			if(self istouching(var_01))
			{
				return 1;
			}
		}
	}

	return 0;
}

//Function Number: 12
func_2C6C(param_00)
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	param_00 endon("placed");
	param_00 endon("death");
	param_00.canbeplaced = 1;
	var_01 = -1;
	common_scripts\utility::_enableusability();
	for(;;)
	{
		var_02 = 18;
		switch(self getstance())
		{
			case "stand":
				var_02 = 40;
				break;
	
			case "crouch":
				var_02 = 25;
				break;
	
			case "prone":
				var_02 = 10;
				break;
		}

		var_03 = self canplayerplacetank(22,22,50,var_02,0,0);
		param_00.origin = var_03["origin"] + anglestoup(self.angles) * 27;
		param_00.angles = var_03["angles"];
		param_00.canbeplaced = self isonground() && var_03["result"] && param_00 remoteuav_in_range() && !param_00 func_2C6B();
		if(param_00.canbeplaced != var_01)
		{
			if(param_00.canbeplaced)
			{
				if(self.team != "spectator")
				{
					self forceusehinton(&"MP_REMOTE_UAV_PLACE");
				}

				if(self attackbuttonpressed())
				{
					self notify("place_carryRemoteUAV");
				}
			}
			else if(self.team != "spectator")
			{
				self forceusehinton(&"MP_REMOTE_UAV_CANNOT_PLACE");
			}
		}

		var_01 = param_00.canbeplaced;
		wait 0.05;
	}
}

//Function Number: 13
func_2C6D()
{
	level endon("game_ended");
	self.owner endon("place_carryRemoteUAV");
	self.owner endon("cancel_carryRemoteUAV");
	self.owner common_scripts\utility::waittill_any("death","disconnect","joined_team","joined_spectators");
	if(isdefined(self))
	{
		if(isdefined(self.var_8242))
		{
			self.var_8242 delete();
		}

		self delete();
	}
}

//Function Number: 14
func_2C6E()
{
	level endon("game_ended");
	self endon("disconnect");
	wait 0.7;
}

//Function Number: 15
func_2C6F(param_00,param_01,param_02,param_03)
{
	lockplayerforremoteuavlaunch();
	maps\mp\_utility::setusingremote(param_01);
	maps\mp\_utility::_giveweapon("uav_remote_mp");
	self switchtoweaponimmediate("uav_remote_mp");
	self visionsetnakedforplayer("black_bw",0);
	var_04 = maps\mp\killstreaks\_killstreaks::initridekillstreak("remote_uav");
	if(var_04 != "success")
	{
		if(var_04 != "disconnect")
		{
			self notify("remoteuav_unlock");
			self takeweapon("uav_remote_mp");
			maps\mp\_utility::clearusingremote();
		}

		return 0;
	}

	if(func_8241(self.team) || maps\mp\_utility::func_2BEC() >= maps\mp\_utility::maxvehiclesallowed() || level.fauxvehiclecount >= maps\mp\_utility::maxvehiclesallowed())
	{
		self iprintlnbold(&"MP_TOO_MANY_VEHICLES");
		self notify("remoteuav_unlock");
		self takeweapon("uav_remote_mp");
		maps\mp\_utility::clearusingremote();
		return 0;
	}

	self notify("remoteuav_unlock");
	var_05 = createremoteuav(param_00,self,param_01,param_02,param_03);
	if(isdefined(var_05))
	{
		thread func_2C7B(param_00,var_05,param_01);
		return 1;
	}

	self iprintlnbold(&"MP_TOO_MANY_VEHICLES");
	self takeweapon("uav_remote_mp");
	maps\mp\_utility::clearusingremote();
	return 0;
}

//Function Number: 16
remoteuav_clearrideintro()
{
	if(isdefined(level.nukedetonated))
	{
		self visionsetnakedforplayer(level.nukevisionset,0);
		return;
	}

	self visionsetnakedforplayer("",0);
}

//Function Number: 17
lockplayerforremoteuavlaunch()
{
	var_00 = spawn("script_origin",self.origin);
	var_00 hide();
	self playerlinkto(var_00);
	thread clearplayerlockfromremoteuavlaunch(var_00);
}

//Function Number: 18
clearplayerlockfromremoteuavlaunch(param_00)
{
	level endon("game_ended");
	var_01 = common_scripts\utility::waittill_any_return("disconnect","death","remoteuav_unlock");
	if(var_01 != "disconnect")
	{
		self unlink();
	}

	param_00 delete();
}

//Function Number: 19
createremoteuav(param_00,param_01,param_02,param_03,param_04)
{
	if(level.console)
	{
		var_05 = spawnhelicopter(param_01,param_03,param_04,"remote_uav_mp","vehicle_remote_uav");
	}
	else
	{
		var_05 = spawnhelicopter(param_02,param_04,var_05,"remote_uav_mp_pc","vehicle_remote_uav");
	}

	if(!isdefined(var_05))
	{
		return undefined;
	}

	var_05 maps\mp\killstreaks\_helicopter::func_2C4A();
	var_05 thread maps\mp\killstreaks\_helicopter::func_2C4B();
	var_05 makevehiclesolidcapsule(18,-9,18);
	var_05.lifeid = param_00;
	var_05.team = param_01.team;
	var_05.pers["team"] = param_01.team;
	var_05.owner = param_01;
	var_05.health = 999999;
	var_05.maxhealth = 250;
	var_05.damagetaken = 0;
	var_05.destroyed = 0;
	var_05 setcandamage(1);
	var_05.specialdamagecallback = ::callback_vehicledamage;
	var_05.scrambler = spawn("script_model",param_03);
	var_05.scrambler linkto(var_05,"tag_origin",(0,0,-160),(0,0,0));
	var_05.scrambler makescrambler(param_01);
	var_05.smoking = 0;
	var_05.var_2C64 = 0;
	var_05.helitype = "remote_uav";
	var_05.markedplayers = [];
	var_05 thread remoteuav_light_fx();
	var_05 thread func_2CA0();
	var_05 thread func_2CA1();
	var_05 thread func_2CA5();
	var_05 thread func_2CA2();
	var_05 thread remoteuav_leave_on_timeout();
	var_05 thread func_2C99();
	var_05 thread remoteuav_watchheliproximity();
	var_05 thread func_2CAD();
	var_05.numflares = 2;
	var_05.hasincoming = 0;
	var_05.incomingmissiles = [];
	var_05 thread func_2CAA();
	var_05 thread remoteuav_handleincomingstinger();
	var_05 thread func_2CA9();
	level.remote_uav[var_05.team] = var_05;
	return var_05;
}

//Function Number: 20
func_2C7B(param_00,param_01,param_02)
{
	param_01.playerlinked = 1;
	self.restoreangles = self.angles;
	if(getdvarint("camera_thirdPerson"))
	{
		maps\mp\_utility::setthirdpersondof(0);
	}

	if(maps\mp\_utility::isjuggernaut() && isdefined(self.juggernautoverlay))
	{
		self.juggernautoverlay.alpha = 0;
	}

	if(isdefined(self.haslightarmor) && isdefined(self.combathighoverlay))
	{
		self.combathighoverlay.alpha = 0;
	}

	self cameralinkto(param_01,"tag_origin");
	self remotecontrolvehicle(param_01);
	thread func_2C84(param_01);
	thread remoteuav_track(param_01);
	thread func_2C8E(param_01);
	self.var_2C7F = param_00;
	self.remoteuav = param_01;
	thread func_2C81(param_01);
	self visionsetnakedforplayer("black_bw",0);
	if(isdefined(level.nukedetonated))
	{
		self visionsetnakedforplayer(level.nukevisionset,1);
		return;
	}

	self visionsetnakedforplayer("",1);
}

//Function Number: 21
func_2C81(param_00)
{
	level endon("game_ended");
	self endon("disconnect");
	param_00 endon("death");
	param_00 endon("end_remote");
	param_00 endon("end_launch_dialog");
	wait 3;
	remoteuav_dialog("launch");
}

//Function Number: 22
remoteuav_endride(param_00)
{
	if(isdefined(param_00))
	{
		param_00.playerlinked = 0;
		param_00 notify("end_remote");
		maps\mp\_utility::clearusingremote();
		if(getdvarint("camera_thirdPerson"))
		{
			maps\mp\_utility::setthirdpersondof(1);
		}

		if(maps\mp\_utility::isjuggernaut() && isdefined(self.juggernautoverlay))
		{
			self.juggernautoverlay.alpha = 1;
		}

		if(isdefined(self.haslightarmor) && isdefined(self.combathighoverlay))
		{
			self.combathighoverlay.alpha = 1;
		}

		self cameraunlink(param_00);
		self remotecontrolvehicleoff(param_00);
		self thermalvisionoff();
		self setplayerangles(self.restoreangles);
		self switchtoweapon(common_scripts\utility::getlastweapon());
		self takeweapon("uav_remote_mp");
		thread remoteuav_freezebuffer();
	}

	self.remoteuav = undefined;
}

//Function Number: 23
remoteuav_freezebuffer()
{
	self endon("disconnect");
	self endon("death");
	level endon("game_ended");
	maps\mp\_utility::freezecontrolswrapper(1);
	wait 0.5;
	maps\mp\_utility::freezecontrolswrapper(0);
}

//Function Number: 24
func_2C84(param_00)
{
	level endon("game_ended");
	self endon("disconnect");
	param_00 endon("death");
	param_00 endon("end_remote");
	wait 2;
	for(;;)
	{
		var_01 = 0;
		while(self usebuttonpressed())
		{
			var_01 = var_01 + 0.05;
			if(var_01 > 0.75)
			{
				param_00 thread func_2CA4();
				return;
			}

			wait 0.05;
		}

		wait 0.05;
	}
}

//Function Number: 25
remoteuav_track(param_00)
{
	level endon("game_ended");
	self endon("disconnect");
	param_00 endon("death");
	param_00 endon("end_remote");
	param_00.lasttrackingdialogtime = 0;
	self.lockedtarget = undefined;
	self weaponlockfree();
	wait 1;
	for(;;)
	{
		var_01 = param_00 gettagorigin("tag_turret");
		var_02 = anglestoforward(self getplayerangles());
		var_03 = var_01 + var_02 * 1024;
		var_04 = bullettrace(var_01,var_03,1,param_00);
		if(isdefined(var_04["position"]))
		{
			var_05 = var_04["position"];
		}
		else
		{
			var_05 = var_03;
			var_04["endpos"] = var_03;
		}

		param_00.trace = var_04;
		var_06 = func_2C89(param_00,level.players,var_05);
		var_07 = func_2C89(param_00,level.turrets,var_05);
		var_08 = undefined;
		if(level.teambased)
		{
			var_08 = func_2C89(param_00,level.uavmodels[level.otherteam[self.team]],var_05);
		}
		else
		{
			var_08 = func_2C89(param_00,level.uavmodels,var_05);
		}

		var_09 = undefined;
		if(isdefined(var_06))
		{
			var_09 = var_06;
		}
		else if(isdefined(var_07))
		{
			var_09 = var_07;
		}
		else if(isdefined(var_08))
		{
			var_09 = var_08;
		}

		if(isdefined(var_09))
		{
			if(!isdefined(self.lockedtarget) || isdefined(self.lockedtarget) && self.lockedtarget != var_09)
			{
				self weaponlockfinalize(var_09);
				self.lockedtarget = var_09;
				if(isdefined(var_06))
				{
					param_00 notify("end_launch_dialog");
					remoteuav_dialog("track");
				}
			}
		}
		else
		{
			self weaponlockfree();
			self.lockedtarget = undefined;
		}

		wait 0.05;
	}
}

//Function Number: 26
func_2C89(param_00,param_01,param_02)
{
	level endon("game_ended");
	var_03 = undefined;
	foreach(var_05 in param_01)
	{
		if(level.teambased && !isdefined(var_05.team) || var_05.team == self.team)
		{
			continue;
		}

		if(isplayer(var_05))
		{
			if(!maps\mp\_utility::isreallyalive(var_05))
			{
				continue;
			}

			if(var_05 == self)
			{
				continue;
			}

			var_06 = var_05.guid;
		}
		else
		{
			var_06 = var_05.birthtime;
		}

		if(isdefined(var_05.sentrytype) || isdefined(var_05.turrettype))
		{
			var_07 = (0,0,32);
			var_08 = "hud_fofbox_hostile_vehicle";
		}
		else if(isdefined(var_05.uavtype))
		{
			var_07 = (0,0,-52);
			var_08 = "hud_fofbox_hostile_vehicle";
		}
		else
		{
			var_07 = (0,0,26);
			var_08 = "veh_hud_target_unmarked";
		}

		if(isdefined(var_05.uavremotemarkedby))
		{
			if(!isdefined(param_00.markedplayers[var_06]))
			{
				param_00.markedplayers[var_06] = [];
				param_00.markedplayers[var_06]["player"] = var_05;
				param_00.markedplayers[var_06]["icon"] = var_05 maps\mp\_entityheadicons::func_277C(self,"veh_hud_target_marked",var_07,10,10,0,0.05,0,0,0,0);
				param_00.markedplayers[var_06]["icon"].shader = "veh_hud_target_marked";
				if(!isdefined(var_05.sentrytype) || !isdefined(var_05.turrettype))
				{
					param_00.markedplayers[var_06]["icon"] settargetent(var_05);
				}
			}
			else if(isdefined(param_00.markedplayers[var_06]) && isdefined(param_00.markedplayers[var_06]["icon"]) && isdefined(param_00.markedplayers[var_06]["icon"].shader) && param_00.markedplayers[var_06]["icon"].shader != "veh_hud_target_marked")
			{
				param_00.markedplayers[var_06]["icon"].shader = "veh_hud_target_marked";
				param_00.markedplayers[var_06]["icon"] setshader("veh_hud_target_marked",10,10);
				param_00.markedplayers[var_06]["icon"] setwaypoint(0,0,0,0);
			}

			continue;
		}

		if(isplayer(var_05))
		{
			var_09 = isdefined(var_05.spawntime) && gettime() - var_05.spawntime / 1000 <= 5;
			var_0A = var_05 maps\mp\_utility::func_27AF("specialty_blindeye");
			var_0B = 0;
			var_0C = 0;
		}
		else
		{
			var_09 = 0;
			var_0A = 0;
			var_0B = isdefined(var_07.carriedby);
			var_0C = isdefined(var_06.isleaving) && var_06.isleaving == 1;
		}

		if(!isdefined(param_00.markedplayers[var_06]) && !var_09 && !var_0A && !var_0B && !var_0C)
		{
			param_00.markedplayers[var_06] = [];
			param_00.markedplayers[var_06]["player"] = var_05;
			param_00.markedplayers[var_06]["icon"] = var_05 maps\mp\_entityheadicons::func_277C(self,var_08,var_07,10,10,0,0.05,0,0,0,0);
			param_00.markedplayers[var_06]["icon"].shader = var_08;
			if(!isdefined(var_05.sentrytype) || !isdefined(var_05.turrettype))
			{
				param_00.markedplayers[var_06]["icon"] settargetent(var_05);
			}
		}

		if(((!isdefined(var_03) || var_03 != var_05) && isdefined(param_00.trace["entity"]) && param_00.trace["entity"] == var_05 && !var_0B && !var_0C) || distance(var_05.origin,param_02) < 200 * param_00.trace["fraction"] && !var_09 && !var_0B && !var_0C || !var_0C && func_2C8D(param_00,var_05))
		{
			var_0D = bullettrace(param_00.origin,var_05.origin + (0,0,32),1,param_00);
			if((isdefined(var_0D["entity"]) && var_0D["entity"] == var_05) || var_0D["fraction"] == 1)
			{
				self playlocalsound("recondrone_lockon");
				var_03 = var_05;
			}
		}
	}

	return var_03;
}

//Function Number: 27
func_2C8D(param_00,param_01)
{
	if(isdefined(param_01.uavtype))
	{
		var_02 = anglestoforward(self getplayerangles());
		var_03 = vectornormalize(param_01.origin - param_00 gettagorigin("tag_turret"));
		var_04 = vectordot(var_02,var_03);
		if(var_04 > 0.985)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 28
func_2C8E(param_00)
{
	self endon("disconnect");
	param_00 endon("death");
	level endon("game_ended");
	param_00 endon("end_remote");
	wait 1;
	self notifyonplayercommand("remoteUAV_tag","+attack");
	self notifyonplayercommand("remoteUAV_tag","+attack_akimbo_accessible");
	for(;;)
	{
		self waittill("remoteUAV_tag");
		if(isdefined(self.lockedtarget))
		{
			self playlocalsound("recondrone_tag");
			maps\mp\gametypes\_damagefeedback::updatedamagefeedback("");
			thread remoteuav_markplayer(self.lockedtarget);
			thread func_2C8F(param_00,3);
			wait 0.25;
			continue;
		}

		wait 0.05;
	}
}

//Function Number: 29
func_2C8F(param_00,param_01)
{
	self endon("disconnect");
	param_00 endon("death");
	level endon("game_ended");
	param_00 endon("end_remote");
	param_00 notify("end_rumble");
	param_00 endon("end_rumble");
	for(var_02 = 0;var_02 < param_01;var_02++)
	{
		self playrumbleonentity("damage_heavy");
		wait 0.05;
	}
}

//Function Number: 30
remoteuav_markplayer(param_00)
{
	level endon("game_ended");
	param_00.uavremotemarkedby = self;
	if(isplayer(param_00) && !param_00 maps\mp\_utility::isusingremote())
	{
		param_00 playlocalsound("player_hit_while_ads_hurt");
		param_00 thread maps\mp\_flashgrenades::func_27AA(2,1);
		param_00 thread maps\mp\gametypes\_rank::xpeventpopup(&"SPLASHES_MARKED_BY_REMOTE_UAV");
	}
	else if(isdefined(param_00.uavtype))
	{
		param_00.birth_time = param_00.birthtime;
	}
	else if(isdefined(param_00.owner) && isalive(param_00.owner))
	{
		param_00.owner thread maps\mp\gametypes\_rank::xpeventpopup(&"SPLASHES_TURRET_MARKED_BY_REMOTE_UAV");
	}

	remoteuav_dialog("tag");
	thread maps\mp\gametypes\_rank::xpeventpopup(&"SPLASHES_REMOTE_UAV_MARKED");
	if(level.gametype != "dm")
	{
		if(isplayer(param_00))
		{
			maps\mp\gametypes\_gamescore::func_26D3("kill",self,undefined,1);
			thread maps\mp\gametypes\_rank::func_2AB3("kill");
		}
	}

	if(isplayer(param_00))
	{
		param_00 setperk("specialty_radarblip",1,0);
	}
	else
	{
		if(isdefined(param_00.uavtype))
		{
			var_01 = "compassping_enemy_uav";
		}
		else
		{
			var_01 = "compassping_sentry_enemy";
		}

		if(level.teambased)
		{
			var_02 = maps\mp\gametypes\_gameobjects::func_2A31();
			objective_add(var_02,"invisible",(0,0,0));
			objective_onentity(var_02,param_00);
			objective_state(var_02,"active");
			objective_team(var_02,self.team);
			objective_icon(var_02,var_01);
			param_00.remoteuavmarkedobjid01 = var_02;
		}
		else
		{
			var_02 = maps\mp\gametypes\_gameobjects::func_2A31();
			objective_add(var_02,"invisible",(0,0,0));
			objective_onentity(var_02,param_00);
			objective_state(var_02,"active");
			objective_team(var_02,level.otherteam[self.team]);
			objective_icon(var_02,var_01);
			param_00.remoteuavmarkedobjid02 = var_02;
			var_02 = maps\mp\gametypes\_gameobjects::func_2A31();
			objective_add(var_02,"invisible",(0,0,0));
			objective_onentity(var_02,param_00);
			objective_state(var_02,"active");
			objective_team(var_02,self.team);
			objective_icon(var_02,var_01);
			param_00.remoteuavmarkedobjid03 = var_02;
		}
	}

	param_00 thread func_2C96(self.remoteuav);
}

//Function Number: 31
remoteuav_processtaggedassist(param_00)
{
	remoteuav_dialog("assist");
	thread maps\mp\gametypes\_rank::xpeventpopup(&"SPLASHES_REMOTE_UAV_ASSIST");
	if(level.gametype != "dm")
	{
		self.taggedassist = 1;
		if(isdefined(param_00))
		{
			thread maps\mp\gametypes\_gamescore::func_26F9(param_00);
			return;
		}

		maps\mp\gametypes\_gamescore::func_26D3("assist",self,undefined,1);
		thread maps\mp\gametypes\_rank::func_2AB3("assist");
	}
}

//Function Number: 32
func_2C96(param_00)
{
	level endon("game_ended");
	var_01 = common_scripts\utility::waittill_any_return("death","disconnect","carried","leaving");
	if(var_01 == "leaving" || !isdefined(self.uavtype))
	{
		self.uavremotemarkedby = undefined;
	}

	if(isdefined(param_00))
	{
		if(isplayer(self))
		{
			var_02 = self.guid;
		}
		else if(isdefined(self.birthtime))
		{
			var_02 = self.birthtime;
		}
		else
		{
			var_02 = self.birth_time;
		}

		if(var_01 == "carried" || var_01 == "leaving")
		{
			param_00.markedplayers[var_02]["icon"] destroy();
			param_00.markedplayers[var_02]["icon"] = undefined;
		}

		if(isdefined(var_02) && isdefined(param_00.markedplayers[var_02]))
		{
			param_00.markedplayers[var_02] = undefined;
			param_00.markedplayers = common_scripts\utility::array_removeundefined(param_00.markedplayers);
		}
	}

	if(isplayer(self))
	{
		self unsetperk("specialty_radarblip",1);
		return;
	}

	if(isdefined(self.remoteuavmarkedobjid01))
	{
		maps\mp\_utility::_objective_delete(self.remoteuavmarkedobjid01);
	}

	if(isdefined(self.remoteuavmarkedobjid02))
	{
		maps\mp\_utility::_objective_delete(self.remoteuavmarkedobjid02);
	}

	if(isdefined(self.remoteuavmarkedobjid03))
	{
		maps\mp\_utility::_objective_delete(self.remoteuavmarkedobjid03);
	}
}

//Function Number: 33
remoteuav_clearmarkedforowner()
{
	foreach(var_01 in self.markedplayers)
	{
		if(isdefined(var_01["icon"]))
		{
			var_01["icon"] destroy();
			var_01["icon"] = undefined;
		}
	}

	self.markedplayers = undefined;
}

//Function Number: 34
remoteuav_operationrumble(param_00)
{
	self endon("disconnect");
	param_00 endon("death");
	level endon("game_ended");
	param_00 endon("end_remote");
	for(;;)
	{
		self playrumbleonentity("damage_light");
		wait 0.5;
	}
}

//Function Number: 35
func_2C99()
{
	self endon("death");
	self.rangetrigger = getent("remote_uav_range","targetname");
	if(!isdefined(self.rangetrigger))
	{
		var_00 = getent("airstrikeheight","targetname");
		self.maxheight = var_00.origin[2];
		self.maxdistance = 12800;
	}

	self.centerref = spawn("script_model",level.mapcenter);
	var_01 = self.origin;
	self.var_2C9B = 0;
	for(;;)
	{
		if(!remoteuav_in_range())
		{
			var_02 = 0;
			while(!remoteuav_in_range())
			{
				self.owner remoteuav_dialog("out_of_range");
				if(!self.var_2C9B)
				{
					self.var_2C9B = 1;
					thread remoteuav_rangecountdown();
				}

				if(isdefined(self.heliinproximity))
				{
					var_03 = distance(self.origin,self.heliinproximity.origin);
					var_02 = 1 - var_03 - 150 / 150;
				}
				else
				{
					var_03 = distance(self.origin,var_01);
					var_02 = min(1,var_03 / 200);
				}

				self.owner setplayerdata("reconDroneState","staticAlpha",var_02);
				wait 0.05;
			}

			self notify("in_range");
			self.var_2C9B = 0;
			thread remoteuav_staticfade(var_02);
		}

		var_01 = self.origin;
		wait 0.05;
	}
}

//Function Number: 36
remoteuav_in_range()
{
	if(isdefined(self.rangetrigger))
	{
		if(!self istouching(self.rangetrigger) && !self.var_2C64)
		{
			return 1;
		}
	}
	else if(distance2d(self.origin,level.mapcenter) < self.maxdistance && self.origin[2] < self.maxheight && !self.var_2C64)
	{
		return 1;
	}

	return 0;
}

//Function Number: 37
remoteuav_staticfade(param_00)
{
	self endon("death");
	while(remoteuav_in_range())
	{
		param_00 = param_00 - 0.05;
		if(param_00 < 0)
		{
			self.owner setplayerdata("reconDroneState","staticAlpha",0);
			break;
		}

		self.owner setplayerdata("reconDroneState","staticAlpha",param_00);
		wait 0.05;
	}
}

//Function Number: 38
remoteuav_rangecountdown()
{
	self endon("death");
	self endon("in_range");
	if(isdefined(self.heliinproximity))
	{
		var_00 = 3;
	}
	else
	{
		var_00 = 6;
	}

	maps\mp\gametypes\_hostmigration::func_2740(var_00);
	self notify("death");
}

//Function Number: 39
func_2CA0()
{
	self endon("death");
	self.owner waittill("disconnect");
	self notify("death");
}

//Function Number: 40
func_2CA1()
{
	self endon("death");
	self.owner common_scripts\utility::waittill_any("joined_team","joined_spectators");
	self notify("death");
}

//Function Number: 41
func_2CA2()
{
	self endon("death");
	level waittill("game_ended");
	remoteuav_clearmarkedforowner();
}

//Function Number: 42
remoteuav_leave_on_timeout()
{
	self endon("death");
	var_00 = 60;
	maps\mp\gametypes\_hostmigration::func_2740(var_00);
	thread func_2CA4();
}

//Function Number: 43
func_2CA4()
{
	level endon("game_ended");
	self endon("death");
	self notify("leaving");
	self.owner remoteuav_endride(self);
	self notify("death");
}

//Function Number: 44
func_2CA5()
{
	level endon("game_ended");
	self waittill("death");
	self playsound("recondrone_destroyed");
	playfx(level.remoteuav_fx["explode"],self.origin);
	remoteuav_cleanup();
}

//Function Number: 45
remoteuav_cleanup()
{
	if(self.playerlinked == 1 && isdefined(self.owner))
	{
		self.owner remoteuav_endride(self);
	}

	if(isdefined(self.scrambler))
	{
		self.scrambler delete();
	}

	if(isdefined(self.centerref))
	{
		self.centerref delete();
	}

	remoteuav_clearmarkedforowner();
	stopfxontag(level.remoteuav_fx["smoke"],self,"tag_origin");
	level.remote_uav[self.team] = undefined;
	maps\mp\_utility::func_80C8();
	self delete();
}

//Function Number: 46
remoteuav_light_fx()
{
	playfxontag(level.chopper_fx["light"]["belly"],self,"tag_light_nose");
	wait 0.05;
	playfxontag(level.chopper_fx["light"]["tail"],self,"tag_light_tail1");
}

//Function Number: 47
remoteuav_dialog(param_00)
{
	if(param_00 == "tag")
	{
		var_01 = 1000;
	}
	else
	{
		var_01 = 5000;
	}

	if(gettime() - level.remoteuav_lastdialogtime < var_01)
	{
		return;
	}

	level.remoteuav_lastdialogtime = gettime();
	var_02 = randomint(level.remoteuav_dialog[param_00].size);
	var_03 = level.remoteuav_dialog[param_00][var_02];
	var_04 = maps\mp\gametypes\_teams::getteamvoiceprefix(self.team) + var_03;
	self playlocalsound(var_04);
}

//Function Number: 48
remoteuav_handleincomingstinger()
{
	level endon("game_ended");
	self endon("death");
	self endon("end_remote");
	for(;;)
	{
		level waittill("stinger_fired",var_00,var_01,var_02);
		if(!isdefined(var_01) || !isdefined(var_02) || var_02 != self)
		{
			continue;
		}

		self.owner playlocalsound("javelin_clu_lock");
		self.owner setplayerdata("reconDroneState","incomingMissile",1);
		self.hasincoming = 1;
		self.incomingmissiles[self.incomingmissiles.size] = var_01;
		var_01.owner = var_00;
		var_01 thread func_2C52(var_02);
	}
}

//Function Number: 49
func_2CA9()
{
	level endon("game_ended");
	self endon("death");
	self endon("end_remote");
	for(;;)
	{
		level waittill("sam_fired",var_00,var_01,var_02);
		if(!isdefined(var_02) || var_02 != self)
		{
			continue;
		}

		var_03 = 0;
		foreach(var_05 in var_01)
		{
			if(isdefined(var_05))
			{
				self.incomingmissiles[self.incomingmissiles.size] = var_05;
				var_05.owner = var_00;
				var_03++;
			}
		}

		if(var_03)
		{
			self.owner playlocalsound("javelin_clu_lock");
			self.owner setplayerdata("reconDroneState","incomingMissile",1);
			self.hasincoming = 1;
			level thread watchsamproximity(var_02,var_01);
		}
	}
}

//Function Number: 50
func_2C52(param_00)
{
	level endon("game_ended");
	self endon("death");
	self missile_settargetent(param_00);
	var_01 = vectornormalize(param_00.origin - self.origin);
	while(isdefined(param_00))
	{
		var_02 = param_00 getpointinbounds(0,0,0);
		var_03 = distance(self.origin,var_02);
		if(param_00.numflares > 0 && var_03 < 4000)
		{
			var_04 = param_00 deployflares();
			self missile_settargetent(var_04);
			return;
		}
		else
		{
			var_04 = vectornormalize(var_01.origin - self.origin);
			if(vectordot(var_04,var_02) < 0)
			{
				self playsound("exp_stinger_armor_destroy");
				playfx(level.remoteuav_fx["missile_explode"],self.origin);
				if(isdefined(self.owner))
				{
					radiusdamage(self.origin,400,1000,1000,self.owner,"MOD_EXPLOSIVE","stinger_mp");
				}
				else
				{
					radiusdamage(self.origin,400,1000,1000,undefined,"MOD_EXPLOSIVE","stinger_mp");
				}

				self hide();
				wait 0.05;
				self delete();
				continue;
			}

			var_02 = var_04;
		}

		wait 0.05;
	}
}

//Function Number: 51
watchsamproximity(param_00,param_01)
{
	level endon("game_ended");
	param_00 endon("death");
	foreach(var_03 in param_01)
	{
		if(isdefined(var_03))
		{
			var_03 missile_settargetent(param_00);
			var_03.lastvectotarget = vectornormalize(param_00.origin - var_03.origin);
		}
	}

	while(param_01.size && isdefined(param_00))
	{
		var_05 = param_00 getpointinbounds(0,0,0);
		foreach(var_0D, var_03 in param_01)
		{
			if(isdefined(var_03))
			{
				if(isdefined(self.markfordetete))
				{
					self delete();
					continue;
				}

				if(param_00.numflares > 0)
				{
					var_07 = distance(var_03.origin,var_05);
					if(var_07 < 4000)
					{
						var_08 = param_00 deployflares();
						foreach(var_0A in param_01)
						{
							if(isdefined(var_0A))
							{
								var_0A missile_settargetent(var_08);
							}
						}

						return;
					}

					continue;
				}

				var_0C = vectornormalize(var_04.origin - var_0D.origin);
				if(vectordot(var_0C,var_0D.lastvectotarget) < 0)
				{
					var_0D playsound("exp_stinger_armor_destroy");
					playfx(level.remoteuav_fx["missile_explode"],var_0D.origin);
					if(isdefined(var_0D.owner))
					{
						radiusdamage(var_0D.origin,400,1000,1000,var_0D.owner,"MOD_EXPLOSIVE","stinger_mp");
					}
					else
					{
						radiusdamage(var_0D.origin,400,1000,1000,undefined,"MOD_EXPLOSIVE","stinger_mp");
					}

					var_0D hide();
					var_0D.markfordetete = 1;
				}
				else
				{
					var_0D.lastvectotarget = var_0C;
				}
			}
		}

		var_05 = common_scripts\utility::array_removeundefined(var_05);
		wait 0.05;
	}
}

//Function Number: 52
deployflares()
{
	self.numflares--;
	self.owner thread func_2C8F(self,6);
	self playsound("WEAP_SHOTGUNATTACH_FIRE_NPC");
	thread func_2C4D();
	var_00 = self.origin + (0,0,-100);
	var_01 = spawn("script_origin",var_00);
	var_01.angles = self.angles;
	var_01 movegravity((0,0,-1),5);
	var_01 thread func_2C55(5);
	return var_01;
}

//Function Number: 53
func_2C4D()
{
	for(var_00 = 0;var_00 < 5;var_00++)
	{
		if(!isdefined(self))
		{
			return;
		}

		playfxontag(level._effect["ac130_flare"],self,"TAG_FLARE");
		wait 0.15;
	}
}

//Function Number: 54
func_2C55(param_00)
{
	wait param_00;
	self delete();
}

//Function Number: 55
func_2CAA()
{
	level endon("game_ended");
	self endon("death");
	self endon("end_remote");
	for(;;)
	{
		var_00 = 0;
		for(var_01 = 0;var_01 < self.incomingmissiles.size;var_01++)
		{
			if(isdefined(self.incomingmissiles[var_01]) && missile_isincoming(self.incomingmissiles[var_01],self))
			{
				var_00++;
			}
		}

		if(self.hasincoming && !var_00)
		{
			self.hasincoming = 0;
			self.owner setplayerdata("reconDroneState","incomingMissile",0);
		}

		self.incomingmissiles = common_scripts\utility::array_removeundefined(self.incomingmissiles);
		wait 0.05;
	}
}

//Function Number: 56
missile_isincoming(param_00,param_01)
{
	var_02 = vectornormalize(param_01.origin - param_00.origin);
	var_03 = anglestoforward(param_00.angles);
	return vectordot(var_02,var_03) > 0;
}

//Function Number: 57
remoteuav_watchheliproximity()
{
	level endon("game_ended");
	self endon("death");
	self endon("end_remote");
	for(;;)
	{
		var_00 = 0;
		foreach(var_02 in level.helis)
		{
			if(distance(var_02.origin,self.origin) < 300)
			{
				var_00 = 1;
				self.heliinproximity = var_02;
			}
		}

		foreach(var_05 in level.littlebirds)
		{
			if(var_05 != self && !isdefined(var_05.helitype) || var_05.helitype != "remote_uav" && distance(var_05.origin,self.origin) < 300)
			{
				var_00 = 1;
				self.heliinproximity = var_05;
			}
		}

		if(!self.var_2C64 && var_00)
		{
			self.var_2C64 = 1;
		}
		else if(self.var_2C64 && !var_00)
		{
			self.var_2C64 = 0;
			self.heliinproximity = undefined;
		}

		wait 0.05;
	}
}

//Function Number: 58
func_2CAD()
{
	level endon("game_ended");
	self endon("death");
	self endon("end_remote");
	for(;;)
	{
		self waittill("damage",var_00,var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09);
		if(isdefined(self.specialdamagecallback))
		{
			self [[ self.specialdamagecallback ]](undefined,var_01,var_00,var_08,var_04,var_09,var_03,var_02,undefined,undefined,var_05,var_07);
		}
	}
}

//Function Number: 59
callback_vehicledamage(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B)
{
	if(self.destroyed == 1)
	{
		return;
	}

	var_0C = self.team;
	if(isdefined(param_01.team))
	{
		var_0D = param_01.team;
	}
	else
	{
		var_0D = "none";
	}

	if(!isdefined(param_01) || param_01 != self.owner && level.teambased && var_0D == var_0C)
	{
		return;
	}

	if(isdefined(param_03) && param_03 & level.idflags_penetration)
	{
		self.wasdamagedfrombulletpenetration = 1;
	}

	var_0E = param_02;
	if(isplayer(param_01))
	{
		param_01 maps\mp\gametypes\_damagefeedback::updatedamagefeedback("remote_uav");
		if(param_01 maps\mp\_utility::func_27AF("specialty_armorpiercing"))
		{
			var_0E = param_02 * level.armorpiercingmod;
		}
	}

	if(isdefined(param_01.owner) && isplayer(param_01.owner))
	{
		param_01.owner maps\mp\gametypes\_damagefeedback::updatedamagefeedback("remote_uav");
	}

	if(isdefined(param_05))
	{
		switch(param_05)
		{
			case "remote_mortar_missile_mp":
			case "javelin_mp":
			case "stinger_mp":
			case "remotemissile_projectile_mp":
			case "ac130_40mm_mp":
			case "ac130_105mm_mp":
				self.largeprojectiledamage = 1;
				var_0E = self.maxhealth + 1;
				break;

			case "emp_grenade_mp":
			case "bomb_site_mp":
				self.largeprojectiledamage = 0;
				var_0E = self.maxhealth + 1;
				break;
		}

		maps\mp\killstreaks\_killstreaks::killstreakhit(param_01,param_05,self);
	}

	if(isdefined(param_04) && param_04 == "MOD_MELEE")
	{
		var_0E = self.maxhealth + 1;
	}

	self.damagetaken = self.damagetaken + var_0E;
	playfxontagforclients(level.remoteuav_fx["hit"],self,"tag_origin",self.owner);
	self playsound("recondrone_damaged");
	if(self.smoking == 0 && self.damagetaken >= self.maxhealth / 2)
	{
		self.smoking = 1;
		playfxontag(level.remoteuav_fx["smoke"],self,"tag_origin");
	}

	if(self.damagetaken >= self.maxhealth && (level.teambased && var_0C != var_0D) || !level.teambased)
	{
		self.destroyed = 1;
		var_0F = undefined;
		if(isdefined(param_01.owner) && !isdefined(self.owner) || param_01.owner != self.owner)
		{
			var_0F = param_01.owner;
		}
		else if(!isdefined(self.owner) || param_01 != self.owner)
		{
			var_0F = param_01;
		}

		if(!isdefined(param_01.owner) && param_01.classname == "script_vehicle")
		{
			var_0F = undefined;
		}

		if(isdefined(param_01.class) && param_01.class == "worldspawn")
		{
			var_0F = undefined;
		}

		if(param_01.classname == "trigger_hurt")
		{
			var_0F = undefined;
		}

		if(isdefined(var_0F))
		{
			var_0F notify("destroyed_killstreak",param_05);
			thread maps\mp\_utility::teamplayercardsplash("callout_destroyed_remote_uav",var_0F);
			var_0F thread maps\mp\gametypes\_rank::func_2AB3("kill",50,param_05,param_04);
			var_0F thread maps\mp\gametypes\_rank::xpeventpopup(&"SPLASHES_DESTROYED_REMOTE_UAV");
			thread maps\mp\gametypes\_missions::vehiclekilled(self.owner,self,undefined,var_0F,param_02,param_04,param_05);
		}

		self notify("death");
	}
}