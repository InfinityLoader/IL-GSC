/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\gametypes\obj_dogtag.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 24
 * Decompile Time: 1377 ms
 * Timestamp: 10/27/2023 12:12:55 AM
*******************************************************************/

//Function Number: 1
init()
{
	level.var_58C0 = [];
	level.var_58BE = ::scripts\mp\gametypes\common::func_58BE;
	level.var_58BF = ::scripts\mp\gametypes\common::func_58BF;
	level.var_4507["vanish"] = loadfx("vfx/core/impacts/small_snowhit");
	level.var_C236 = scripts\mp\_utility::func_7ECE();
}

//Function Number: 2
func_10083(param_00)
{
	if(isdefined(self.var_11377))
	{
		return 0;
	}

	if(isdefined(param_00) && param_00 == self)
	{
		return 0;
	}

	if(level.teambased && isdefined(param_00) && isdefined(param_00.team) && param_00.team == self.team)
	{
		return 0;
	}

	if(isdefined(param_00) && !isdefined(param_00.team) && param_00.classname == "trigger_hurt" || param_00.classname == "worldspawn")
	{
		return 0;
	}

	return 1;
}

//Function Number: 3
func_10849(param_00,param_01,param_02)
{
	var_03 = 1;
	if(scripts\mp\_utility::func_9FB3(level.var_C236))
	{
		var_03 = param_00 func_10083(param_01);
		if(var_03)
		{
			var_03 = var_03 && !scripts\mp\_utility::func_9F19(param_00);
		}

		if(var_03)
		{
			var_03 = var_03 && !param_00 scripts\mp\_playerlogic::func_B4EE();
		}
	}

	if(!var_03)
	{
		return;
	}

	if(isagent(param_00))
	{
		return;
	}

	if(isagent(param_01))
	{
		param_01 = param_01.var_222;
	}

	var_04 = 14;
	var_05 = (0,0,0);
	var_06 = param_00.angles;
	if(param_00 scripts\mp\_gameobjects::touchingarbitraryuptrigger())
	{
		var_06 = param_00 getworldupreferenceangles();
		var_05 = anglestoup(var_06);
		if(var_05[2] < 0)
		{
			var_04 = -14;
		}
	}

	if(isdefined(level.var_58C0[param_00.var_86BD]))
	{
		playfx(level.var_4507["vanish"],level.var_58C0[param_00.var_86BD].var_4B2C);
		level.var_58C0[param_00.var_86BD] func_E277();
		level.var_58C0[param_00.var_86BD].visuals[0].angles = (0,0,0);
		level.var_58C0[param_00.var_86BD].visuals[1].angles = (0,0,0);
	}
	else
	{
		var_07[0] = spawn("script_model",(0,0,0));
		var_07[0] setmodel("dogtags_iw7_foe");
		var_07[1] = spawn("script_model",(0,0,0));
		var_07[1] setmodel("dogtags_iw7_friend");
		if(level.var_C236)
		{
			var_07[0] method_82BF(param_00);
			var_07[1] method_82BF(param_00);
		}

		var_07[0] method_8588();
		var_07[1] method_8588();
		var_08 = spawn("trigger_radius",(0,0,0),0,32,32);
		if(param_00 scripts\mp\_gameobjects::touchingarbitraryuptrigger())
		{
			if(var_05[2] < 0)
			{
				var_07[0].angles = var_06;
				var_07[1].angles = var_06;
			}
		}

		level.var_58C0[param_00.var_86BD] = scripts\mp\_gameobjects::func_4A2E("any",var_08,var_07,(0,0,16));
		level.var_58C0[param_00.var_86BD] scripts\mp\_gameobjects::func_FB08(0);
		level.var_58C0[param_00.var_86BD].var_C5BB = ::func_C5BB;
		level.var_58C0[param_00.var_86BD].var_13372 = param_00;
		level.var_58C0[param_00.var_86BD].var_13383 = param_00.team;
		level thread func_41C9(param_00);
		param_00 thread func_11423(level.var_58C0[param_00.var_86BD]);
	}

	var_09 = param_00.origin + (0,0,var_04);
	level.var_58C0[param_00.var_86BD].var_4B2C = var_09;
	level.var_58C0[param_00.var_86BD].trigger.origin = var_09;
	level.var_58C0[param_00.var_86BD].visuals[0].origin = var_09;
	level.var_58C0[param_00.var_86BD].visuals[1].origin = var_09;
	level.var_58C0[param_00.var_86BD] scripts\mp\_gameobjects::initializetagpathvariables();
	level.var_58C0[param_00.var_86BD] scripts\mp\_gameobjects::func_1CAF("any");
	if(level.teambased)
	{
		level.var_58C0[param_00.var_86BD].visuals[0] thread func_10159(level.var_58C0[param_00.var_86BD],param_01.team);
		level.var_58C0[param_00.var_86BD].visuals[1] thread func_10159(level.var_58C0[param_00.var_86BD],param_00.team);
	}
	else
	{
		level.var_58C0[param_00.var_86BD] thread showtoffaattacker(level.var_58C0[param_00.var_86BD],param_01,param_00);
	}

	level.var_58C0[param_00.var_86BD].var_4F = param_01;
	level.var_58C0[param_00.var_86BD].var_250F = param_01.team;
	if(level.var_58C0[param_00.var_86BD].var_115DC[param_00.team] != -1)
	{
		scripts\mp\objidpoolmanager::minimap_objective_add(level.var_58C0[param_00.var_86BD].var_115DC[param_00.team],"active",var_09,"waypoint_dogtags_friendlys");
		if(level.var_C236)
		{
			scripts\mp\objidpoolmanager::minimap_objective_team(level.var_58C0[param_00.var_86BD].var_115DC[param_00.team],param_00.team);
		}
		else
		{
			scripts\mp\objidpoolmanager::minimap_objective_player(level.var_58C0[param_00.var_86BD].var_115DC[param_00.team],param_00 getentitynumber());
		}
	}

	if(level.var_58C0[param_00.var_86BD].var_115DC[param_01.team] != -1)
	{
		scripts\mp\objidpoolmanager::minimap_objective_add(level.var_58C0[param_00.var_86BD].var_115DC[param_01.team],"active",var_09,"waypoint_dogtags");
		if(level.teambased)
		{
			scripts\mp\objidpoolmanager::minimap_objective_team(level.var_58C0[param_00.var_86BD].var_115DC[param_01.team],param_01.team);
		}
		else
		{
			scripts\mp\objidpoolmanager::minimap_objective_player(level.var_58C0[param_00.var_86BD].var_115DC[param_01.team],param_01 getentitynumber());
		}
	}

	playsoundatpos(var_09,"mp_killconfirm_tags_drop");
	level notify(param_02,level.var_58C0[param_00.var_86BD]);
	param_00.var_113EF = 1;
	level.var_58C0[param_00.var_86BD].visuals[0] scriptmodelplayanim("mp_dogtag_spin");
	level.var_58C0[param_00.var_86BD].visuals[1] scriptmodelplayanim("mp_dogtag_spin");
	if(level.var_C236)
	{
		param_00.var_2C7 = "hud_status_dogtag";
	}
}

//Function Number: 4
func_E277()
{
	self.var_4F = undefined;
	self notify("reset");
	self.visuals[0] hide();
	self.visuals[1] hide();
	self.visuals[0] dontinterpolate();
	self.visuals[1] dontinterpolate();
	self.var_4B2C = (0,0,1000);
	self.trigger.origin = (0,0,1000);
	self.visuals[0].origin = (0,0,1000);
	self.visuals[1].origin = (0,0,1000);
	scripts\mp\_gameobjects::func_1CAF("none");
	if(self.var_115DC[self.var_13383] != -1)
	{
		scripts\mp\objidpoolmanager::minimap_objective_state(self.var_115DC[self.var_13383],"invisible");
	}

	if(self.var_115DC[self.var_250F] != -1)
	{
		scripts\mp\objidpoolmanager::minimap_objective_state(self.var_115DC[self.var_250F],"invisible");
	}
}

//Function Number: 5
func_E178(param_00,param_01)
{
	if(isdefined(level.var_58C0[param_00]))
	{
		level.var_58C0[param_00] scripts\mp\_gameobjects::func_1CAF("none");
		if(scripts\mp\_utility::func_9FB3(param_01) && isdefined(level.var_58C0[param_00].var_4F))
		{
			level.var_58C0[param_00].var_4F thread scripts\mp\_rank::func_EC2D("kill_denied");
		}

		playfx(level.var_4507["vanish"],level.var_58C0[param_00].var_4B2C);
		level.var_58C0[param_00] notify("reset");
		wait(0.05);
		if(isdefined(level.var_58C0[param_00]))
		{
			level.var_58C0[param_00] notify("death");
			for(var_02 = 0;var_02 < level.var_58C0[param_00].visuals.size;var_02++)
			{
				level.var_58C0[param_00].visuals[var_02] delete();
			}

			level.var_58C0[param_00] thread scripts\mp\_gameobjects::func_51DA();
			level.var_58C0[param_00] = undefined;
		}
	}
}

//Function Number: 6
func_10159(param_00,param_01)
{
	param_00 endon("death");
	param_00 endon("reset");
	self hide();
	foreach(var_03 in level.players)
	{
		if(var_03.team == param_01)
		{
			self showtoplayer(var_03);
		}

		if(var_03.team == "spectator" && param_01 == "allies")
		{
			self showtoplayer(var_03);
		}
	}

	for(;;)
	{
		level waittill("joined_team",var_03);
		if(var_03.team == param_01)
		{
			self showtoplayer(var_03);
		}

		if(var_03.team == "spectator" && param_01 == "allies")
		{
			self showtoplayer(var_03);
		}
	}
}

//Function Number: 7
showtoffaattacker(param_00,param_01,param_02)
{
	param_00 endon("death");
	param_00 endon("reset");
	param_00.visuals[0] hide();
	param_00.visuals[1] hide();
	foreach(var_04 in level.players)
	{
		if(var_04 != param_02)
		{
			param_00.visuals[0] showtoplayer(var_04);
		}
		else
		{
			param_00.visuals[1] showtoplayer(var_04);
		}

		if(var_04.team == "spectator")
		{
			param_00.visuals[0] showtoplayer(var_04);
		}
	}

	for(;;)
	{
		level waittill("joined_team",var_04);
		param_00.visuals[0] showtoplayer(var_04);
	}
}

//Function Number: 8
func_D36B(param_00)
{
	if(lib_0DF8::func_9DDF(param_00))
	{
		return 0;
	}

	return 1;
}

//Function Number: 9
func_C5BB(param_00)
{
	if(!func_D36B(param_00))
	{
		return;
	}

	if(isdefined(param_00.var_222))
	{
		param_00 = param_00.var_222;
	}

	if(level.gametype == "conf")
	{
		param_00 thread func_13B1C();
	}

	if(level.teambased)
	{
		if(param_00.pers["team"] == self.var_13383)
		{
			self.trigger playsound("mp_killconfirm_tags_deny");
			param_00 scripts\mp\_utility::func_93DF("denied",1);
			param_00 scripts\mp\_persistence::func_10E56("round","denied",param_00.pers["denied"]);
			if(level.var_C236)
			{
				func_AC69(param_00);
			}
			else
			{
				func_1D32(param_00);
			}

			if(isdefined(level.var_58BE) && !level.var_7669)
			{
				self thread [[ level.var_58BE ]](param_00);
			}
		}
		else
		{
			self.trigger playsound("mp_killconfirm_tags_pickup");
			if(level.gametype != "grind")
			{
				param_00 scripts\mp\_utility::func_93DF("confirmed",1);
				param_00 scripts\mp\_persistence::func_10E56("round","confirmed",param_00.pers["confirmed"]);
			}

			if(level.var_C236)
			{
				func_AC6A(param_00);
			}
			else
			{
				func_656A(param_00);
			}

			if(isdefined(level.var_58BF) && !level.var_7669)
			{
				self thread [[ level.var_58BF ]](param_00);
			}
		}
	}
	else
	{
		runffatagpickup(param_00);
	}

	self.var_13372 notify("tag_removed");
	thread func_E178(self.var_13372.var_86BD);
}

//Function Number: 10
runffatagpickup(param_00)
{
	if(param_00 == self.var_13372)
	{
		self.trigger playsound("mp_killconfirm_tags_deny");
		func_1D32(param_00);
		if(isdefined(level.var_58BE) && !level.var_7669)
		{
			self thread [[ level.var_58BE ]](param_00);
			return;
		}

		return;
	}

	self.trigger playsound("mp_killconfirm_tags_pickup");
	func_656A(param_00);
	if(isdefined(level.var_58BF) && !level.var_7669)
	{
		self thread [[ level.var_58BF ]](param_00);
	}
}

//Function Number: 11
func_13B1C()
{
	level endon("game_ended");
	self endon("death");
	self endon("disconnect");
	self notify("watchRapidTagPickup()");
	self endon("watchRapidTagPickup()");
	if(!isdefined(self.var_DDCE))
	{
		self.var_DDCE = 1;
	}
	else
	{
		self.var_DDCE++;
		if(self.var_DDCE == 3)
		{
			thread scripts\mp\_awards::func_8380("mode_kc_3_tags");
		}
	}

	wait(3);
	self.var_DDCE = 0;
}

//Function Number: 12
func_11423(param_00)
{
	level endon("game_ended");
	self endon("disconnect");
	param_00 endon("death");
	for(;;)
	{
		self waittill("joined_team");
		thread func_E178(self.var_86BD,1);
	}
}

//Function Number: 13
func_41C9(param_00)
{
	param_00 notify("clearOnVictimDisconnect");
	param_00 endon("clearOnVictimDisconnect");
	param_00 endon("tag_removed");
	level endon("game_ended");
	var_01 = param_00.var_86BD;
	param_00 waittill("disconnect");
	thread func_E178(var_01,1);
}

//Function Number: 14
func_C175(param_00,param_01,param_02)
{
	var_03 = param_02.team;
	var_04 = scripts\mp\_utility::getotherteam(var_03);
	foreach(var_06 in level.players)
	{
		if(var_06.team == var_03)
		{
			if(var_06 != param_02)
			{
				var_06 func_C16D(param_00);
			}

			continue;
		}

		if(var_06.team == var_04)
		{
			var_06 func_C16D(param_01);
		}
	}
}

//Function Number: 15
func_C16D(param_00)
{
	thread scripts\mp\_hud_message::func_10151(param_00);
}

//Function Number: 16
func_C5AD(param_00)
{
	level endon("game_ended");
	self endon("disconnect");
	while(!isdefined(self.pers))
	{
		wait(0.05);
	}

	thread scripts\mp\_utility::func_83B4(param_00);
}

//Function Number: 17
func_AC69(param_00)
{
	param_00.pers["rescues"]++;
	param_00 scripts\mp\_persistence::func_10E56("round","rescues",param_00.pers["rescues"]);
	func_C175("sr_ally_respawned","sr_enemy_respawned",self.var_13372);
	if(isdefined(self.var_13372))
	{
		self.var_13372 thread scripts\mp\_hud_message::func_10151("sr_respawned");
		level notify("sr_player_respawned",self.var_13372);
		self.var_13372 scripts\mp\_utility::func_AAEC("revived");
		if(!level.var_7669)
		{
			self.var_13372 thread func_E284();
		}

		self.var_13372.var_113EF = undefined;
		self.var_13372.var_2C7 = "";
	}

	if(isdefined(self.var_4F))
	{
		self.var_4F thread scripts\mp\_rank::func_EC2D("kill_denied");
	}

	param_00 thread func_C5AD("kill_denied");
	param_00 scripts\mp\_missions::func_D992("ch_rescuer");
	if(!isdefined(param_00.var_E1C0))
	{
		param_00.var_E1C0 = [];
	}

	param_00.var_E1C0[self.var_13372.var_86BD] = 1;
	if(param_00.var_E1C0.size == 4)
	{
		param_00 scripts\mp\_missions::func_D992("ch_helpme");
	}
}

//Function Number: 18
func_AC6A(param_00)
{
	if(isdefined(self.var_13372))
	{
		self.var_13372 thread scripts\mp\_hud_message::func_10151("sr_eliminated");
		level notify("sr_player_eliminated",self.var_13372);
	}

	func_C175("sr_ally_eliminated","sr_enemy_eliminated",self.var_13372);
	if(isdefined(self.var_13372))
	{
		if(!level.var_7669)
		{
			self.var_13372 scripts\mp\_utility::setlowermessage("spawn_info",game["strings"]["spawn_next_round"]);
			self.var_13372 thread scripts\mp\_playerlogic::func_E170(3);
		}

		self.var_13372.var_113EF = undefined;
		self.var_13372.var_2C7 = "hud_status_dead";
	}

	if(self.var_4F != param_00)
	{
		self.var_4F thread func_C5AD("kill_confirmed");
	}

	param_00 thread func_C5AD("kill_confirmed");
	param_00 scripts\mp\_utility::func_AAEC("kill_confirmed");
	param_00 scripts\mp\_missions::func_D992("ch_hideandseek");
}

//Function Number: 19
func_E284()
{
	scripts\mp\_playerlogic::func_93F8(self.team);
	self.var_1D40 = 1;
	thread func_136F9();
	func_12E58();
}

//Function Number: 20
func_136F9()
{
	for(;;)
	{
		wait(0.05);
		if(isdefined(self) && self.sessionstate == "spectator" || !scripts\mp\_utility::func_9F19(self))
		{
			self.pers["lives"] = 1;
			scripts\mp\_playerlogic::func_1083A();
			continue;
		}
	}
}

//Function Number: 21
func_12E58()
{
	if(isdefined(level.var_1BE5["allies"]))
	{
		setomnvar("ui_allies_alive",level.var_1BE5["allies"].size);
	}

	if(isdefined(level.var_1BE5["axis"]))
	{
		setomnvar("ui_axis_alive",level.var_1BE5["axis"].size);
	}
}

//Function Number: 22
func_1D32(param_00)
{
	if(self.var_13372 == param_00)
	{
		param_00 thread scripts\mp\_awards::func_8380("mode_kc_own_tags");
	}
	else if(level.gametype == "conf")
	{
		param_00 func_C5AD("kill_denied");
	}
	else
	{
		param_00 func_C5AD("tag_denied");
	}

	if(isdefined(self.var_4F))
	{
		self.var_4F thread scripts\mp\_rank::func_EC2D("tag_denied");
	}

	param_00 scripts\mp\_missions::func_D992("ch_denier");
}

//Function Number: 23
func_656A(param_00)
{
	if(level.gametype == "conf")
	{
		param_00 func_C5AD("kill_confirmed");
	}
	else
	{
		param_00 func_C5AD("tag_collected");
	}

	if(level.gametype == "grind")
	{
		param_00 func_D414(param_00.var_11422 + 1);
	}

	if(self.var_4F != param_00)
	{
		if(level.teambased)
		{
			self.var_4F thread func_C5AD("kc_friendly_pickup");
			if(isdefined(level.var_112C0) && level.var_112C0)
			{
				if(isdefined(self.var_4F.var_47ED) && self.var_4F.var_47ED)
				{
					param_00 scripts\mp\_utility::func_F6A8("kill");
				}
				else
				{
					self.var_4F scripts\mp\_utility::func_C4DB(undefined,self.var_4F);
				}
			}
		}
		else
		{
			param_00 func_C5AD("kill_denied");
		}
	}

	param_00 scripts\mp\_missions::func_D992("ch_collector");
}

//Function Number: 24
func_D414(param_00)
{
	self.var_11422 = param_00;
	self.var_150 = param_00;
	if(param_00 > 999)
	{
		param_00 = 999;
	}

	self setclientomnvar("ui_grind_tags",param_00);
}