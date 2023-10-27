/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\bots\_bots_fireteam_commander.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 32
 * Decompile Time: 1456 ms
 * Timestamp: 10/27/2023 12:27:31 AM
*******************************************************************/

//Function Number: 1
init()
{
	if(scripts\mp\_utility::func_2DD9())
	{
		level.var_113CF = [];
		level.var_113CF[0] = "tactics_exit";
		level.var_113CF[1] = "tactic_none";
		if(level.gametype == "dom")
		{
			level.var_113CF[2] = "tactic_dom_holdA";
			level.var_113CF[3] = "tactic_dom_holdB";
			level.var_113CF[4] = "tactic_dom_holdC";
			level.var_113CF[5] = "tactic_dom_holdAB";
			level.var_113CF[6] = "tactic_dom_holdAC";
			level.var_113CF[7] = "tactic_dom_holdBC";
			level.var_113CF[8] = "tactic_dom_holdABC";
		}
		else if(level.gametype == "war")
		{
			level.var_113CF[2] = "tactic_war_hyg";
			level.var_113CF[3] = "tactic_war_buddy";
			level.var_113CF[4] = "tactic_war_hp";
			level.var_113CF[5] = "tactic_war_pincer";
			level.var_113CF[6] = "tactic_war_ctc";
			level.var_113CF[7] = "tactic_war_rg";
		}
		else
		{
			return;
		}

		level.var_6D88 = [];
		level.var_6D88["axis"] = undefined;
		level.var_6D88["allies"] = undefined;
		level.var_6D8C = [];
		level.var_6D8C["axis"] = undefined;
		level.var_6D8C["allies"] = undefined;
		level.var_6D8E = [];
		level.var_6D8E["axis"] = undefined;
		level.var_6D8E["allies"] = undefined;
		level thread func_4444();
		level thread func_442A();
	}
}

//Function Number: 2
func_442A()
{
	level waittill("game_ended");
	if(isdefined(level.var_6D88["axis"]))
	{
		var_00 = 0;
		foreach(var_02 in level.players)
		{
			if(isbot(var_02) && var_02.team == "axis")
			{
				var_00 = var_00 + var_02.pers["score"];
			}
		}

		level.var_6D88["axis"].pers["score"] = var_00;
		level.var_6D88["axis"].var_278 = var_00;
		level.var_6D88["axis"] scripts\mp\_persistence::func_10E12("score",var_00);
		level.var_6D88["axis"] scripts\mp\_persistence::func_10E56("round","score",var_00);
	}

	if(isdefined(level.var_6D88["allies"]))
	{
		var_00 = 0;
		foreach(var_02 in level.players)
		{
			if(isbot(var_02) && var_02.team == "allies")
			{
				var_00 = var_00 + var_02.pers["score"];
			}
		}

		level.var_6D88["allies"].pers["score"] = var_00;
		level.var_6D88["allies"].var_278 = var_00;
		level.var_6D88["allies"] scripts\mp\_persistence::func_10E12("score",var_00);
		level.var_6D88["allies"] scripts\mp\_persistence::func_10E56("round","score",var_00);
	}
}

//Function Number: 3
func_442D(param_00)
{
	if(!isdefined(self.var_6D8A[param_00]))
	{
		self.var_6D8A[param_00] = scripts\mp\objidpoolmanager::requestminimapid(1);
		var_01 = (0,0,0);
		foreach(var_03 in level.var_5913)
		{
			if(var_03.label == "_" + param_00)
			{
				var_01 = var_03.var_4B2C;
				break;
			}
		}

		scripts\mp\objidpoolmanager::minimap_objective_add(self.var_6D8A[param_00],"invisible",var_01,"compass_obj_fireteam");
		scripts\mp\objidpoolmanager::minimap_objective_playerteam(self.var_6D8A[param_00],self getentitynumber());
	}
}

//Function Number: 4
func_4436()
{
	if(isdefined(self.var_4430))
	{
		return;
	}

	self.var_4430 = 1;
	self.var_4437 = "tactic_none";
	self.var_4438 = "tactic_none";
	switch(level.gametype)
	{
		case "war":
			break;

		case "dom":
			self.var_6D8A = [];
			func_442D("a");
			func_442D("b");
			func_442D("c");
			break;
	}
}

//Function Number: 5
func_443A()
{
	self endon("disconnect");
	level endon("game_ended");
	for(;;)
	{
		self waittill("luinotifyserver",var_00,var_01);
		if(var_00 != "tactic_select")
		{
			if(var_00 == "bot_select")
			{
				if(var_01 > 0)
				{
					func_4432("bot_next");
				}
				else if(var_01 < 0)
				{
					func_4432("bot_prev");
				}
			}
			else if(var_00 == "tactics_menu")
			{
				if(var_01 > 0)
				{
					func_4432("tactics_menu");
				}
				else if(var_01 <= 0)
				{
					func_4432("tactics_close");
				}
			}

			continue;
		}

		if(var_01 >= level.var_113CF.size)
		{
			continue;
		}

		var_02 = level.var_113CF[var_01];
		func_4432(var_02);
	}
}

//Function Number: 6
func_4432(param_00,param_01)
{
	if(!isdefined(param_00))
	{
		return;
	}

	switch(param_00)
	{
		case "bot_prev":
			func_4441(1);
			break;

		case "bot_next":
			func_4441(0);
			break;

		case "tactics_menu":
			self notify("commander_mode");
			if(isdefined(self.var_72E4))
			{
				self.var_72E4 notify("commander_mode");
			}
			break;

		case "tactics_close":
			self.var_442C = gettime();
			self notify("takeover_bot");
			break;

		case "tactic_none":
			if(level.gametype == "dom")
			{
				scripts\mp\objidpoolmanager::minimap_objective_state(self.var_6D8A["a"],"invisible");
				scripts\mp\objidpoolmanager::minimap_objective_state(self.var_6D8A["b"],"invisible");
				scripts\mp\objidpoolmanager::minimap_objective_state(self.var_6D8A["c"],"invisible");
			}
			break;

		case "tactic_dom_holdA":
			scripts\mp\objidpoolmanager::minimap_objective_state(self.var_6D8A["a"],"active");
			scripts\mp\objidpoolmanager::minimap_objective_state(self.var_6D8A["b"],"invisible");
			scripts\mp\objidpoolmanager::minimap_objective_state(self.var_6D8A["c"],"invisible");
			break;

		case "tactic_dom_holdB":
			scripts\mp\objidpoolmanager::minimap_objective_state(self.var_6D8A["a"],"invisible");
			scripts\mp\objidpoolmanager::minimap_objective_state(self.var_6D8A["b"],"active");
			scripts\mp\objidpoolmanager::minimap_objective_state(self.var_6D8A["c"],"invisible");
			break;

		case "tactic_dom_holdC":
			scripts\mp\objidpoolmanager::minimap_objective_state(self.var_6D8A["a"],"invisible");
			scripts\mp\objidpoolmanager::minimap_objective_state(self.var_6D8A["b"],"invisible");
			scripts\mp\objidpoolmanager::minimap_objective_state(self.var_6D8A["c"],"active");
			break;

		case "tactic_dom_holdAB":
			scripts\mp\objidpoolmanager::minimap_objective_state(self.var_6D8A["a"],"active");
			scripts\mp\objidpoolmanager::minimap_objective_state(self.var_6D8A["b"],"active");
			scripts\mp\objidpoolmanager::minimap_objective_state(self.var_6D8A["c"],"invisible");
			break;

		case "tactic_dom_holdAC":
			scripts\mp\objidpoolmanager::minimap_objective_state(self.var_6D8A["a"],"active");
			scripts\mp\objidpoolmanager::minimap_objective_state(self.var_6D8A["b"],"invisible");
			scripts\mp\objidpoolmanager::minimap_objective_state(self.var_6D8A["c"],"active");
			break;

		case "tactic_dom_holdBC":
			scripts\mp\objidpoolmanager::minimap_objective_state(self.var_6D8A["a"],"invisible");
			scripts\mp\objidpoolmanager::minimap_objective_state(self.var_6D8A["b"],"active");
			scripts\mp\objidpoolmanager::minimap_objective_state(self.var_6D8A["c"],"active");
			break;

		case "tactic_dom_holdABC":
			scripts\mp\objidpoolmanager::minimap_objective_state(self.var_6D8A["a"],"active");
			scripts\mp\objidpoolmanager::minimap_objective_state(self.var_6D8A["b"],"active");
			scripts\mp\objidpoolmanager::minimap_objective_state(self.var_6D8A["c"],"active");
			break;

		case "tactic_war_rg":
			break;

		case "tactic_war_ctc":
			break;

		case "tactic_war_hp":
			break;

		case "tactic_war_buddy":
			break;

		case "tactic_war_pincer":
			break;

		case "tactic_war_hyg":
			break;
	}

	if(scripts\common\utility::string_starts_with(param_00,"tactic_"))
	{
		self playlocalsound("earn_superbonus");
		if(self.var_4437 != param_00)
		{
			self.var_4437 = param_00;
			thread func_443C();
			if(isdefined(level.var_2D9E["commander_gametype_tactics"]))
			{
				self [[ level.var_2D9E["commander_gametype_tactics"] ]](param_00);
				return;
			}
		}
	}
}

//Function Number: 7
func_443C()
{
	self notify("commander_order_ack");
	self endon("commander_order_ack");
	self endon("disconnect");
	var_00 = 360000;
	var_01 = var_00;
	var_02 = undefined;
	for(;;)
	{
		wait(0.5);
		var_01 = var_00;
		var_02 = undefined;
		var_03 = self.origin;
		var_04 = self method_815D();
		if(isdefined(var_04))
		{
			var_03 = var_04.origin;
		}

		foreach(var_06 in level.players)
		{
			if(isdefined(var_06) && isalive(var_06) && isbot(var_06) && isdefined(var_06.team) && var_06.team == self.team)
			{
				var_07 = distancesquared(var_03,var_06.origin);
				if(var_07 < var_01)
				{
					var_02 = var_06;
				}
			}
		}

		if(isdefined(var_02))
		{
			var_09 = var_02.pers["voicePrefix"];
			var_0A = var_09 + level.var_29CB["callout_response_generic"];
			var_02 thread scripts\mp\_battlechatter_mp::func_5AB0(var_0A,1,1);
			return;
		}
	}
}

//Function Number: 8
func_4435(param_00)
{
	if(!isdefined(self))
	{
		return;
	}

	self notify("commander_hint_fade_out");
	if(isdefined(self.var_4445))
	{
		var_01 = self.var_4445;
		if(param_00 > 0)
		{
			var_01 changefontscaleovertime(param_00);
			var_01.fontscale = var_01.fontscale * 1.5;
			var_01.var_154 = (0.3,0.6,0.3);
			var_01.var_153 = 1;
			var_01 fadeovertime(param_00);
			var_01.color = (0,0,0);
			var_01.alpha = 0;
			wait(param_00);
		}

		var_01 scripts\mp\_hud_util::destroyelem();
	}
}

//Function Number: 9
func_4433()
{
	self endon("disconnect");
	self endon("commander_mode");
	self.var_4431 = 1;
	wait(1);
	if(!isdefined(self))
	{
		return;
	}

	self.var_4445 = scripts\mp\_hud_util::createfontstring("default",3);
	self.var_4445.color = (1,1,1);
	self.var_4445 settext(&"MPUI_COMMANDER_HINT");
	self.var_4445.x = 0;
	self.var_4445.y = 20;
	self.var_4445.alignx = "center";
	self.var_4445.aligny = "middle";
	self.var_4445.horzalign = "center";
	self.var_4445.vertalign = "middle";
	self.var_4445.foreground = 1;
	self.var_4445.alpha = 1;
	self.var_4445.var_175 = 1;
	self.var_4445.sort = -1;
	self.var_4445 endon("death");
	thread func_4434();
	wait(4);
	thread func_4435(0.5);
}

//Function Number: 10
func_4434()
{
	self endon("disconnect");
	self endon("commander_hint_fade_out");
	self waittill("commander_mode");
	thread func_4435(0);
}

//Function Number: 11
func_9157()
{
	self endon("disconnect");
	self.var_C83C = [];
	for(var_00 = 0;var_00 < 16;var_00++)
	{
		self.var_C83C[var_00] = scripts\mp\_hud_util::createfontstring("default",1);
		self.var_C83C[var_00].color = (1,1,1);
		self.var_C83C[var_00].x = 0;
		self.var_C83C[var_00].y = 30 + var_00 * 12;
		self.var_C83C[var_00].alignx = "center";
		self.var_C83C[var_00].aligny = "top";
		self.var_C83C[var_00].horzalign = "center";
		self.var_C83C[var_00].vertalign = "top";
		self.var_C83C[var_00].foreground = 1;
		self.var_C83C[var_00].alpha = 1;
		self.var_C83C[var_00].sort = -1;
		self.var_C83C[var_00].archived = 0;
	}

	for(;;)
	{
		var_01 = 0;
		var_02 = [];
		foreach(var_04 in self.var_C83C)
		{
		}

		foreach(var_07 in level.players)
		{
			var_08 = 0;
			if(isdefined(var_07) && var_07.team == self.team)
			{
				if(isdefined(var_07.var_222))
				{
					if(scripts\common\utility::func_2286(var_02,var_07))
					{
						self.var_C83C[var_01].color = (1,0,0);
					}
					else
					{
						var_02 = scripts\common\utility::array_add(var_02,var_07);
					}

					if(var_07 != var_07.var_222 && scripts\common\utility::func_2286(var_02,var_07.var_222))
					{
						self.var_C83C[var_01].color = (1,0,0);
					}
					else
					{
						var_02 = scripts\common\utility::array_add(var_02,var_07.var_222);
					}

					if(var_07 == self)
					{
						self.var_C83C[var_01].color = (1,0,0);
					}
					else if(var_07.var_222 == var_07)
					{
						self.var_C83C[var_01].color = (1,0,0);
					}
					else if(var_07.var_222 == self)
					{
						self.var_C83C[var_01].color = (0,1,0);
					}
					else
					{
						self.var_C83C[var_01].color = (1,1,1);
					}
				}
				else if(isdefined(var_07.var_2D8C))
				{
					var_08 = 1;
				}
				else
				{
					self.var_C83C[var_01].color = (1,1,0);
				}
			}
			else
			{
				var_08 = 1;
			}

			if(!var_08)
			{
				var_01++;
			}
		}

		wait(0.1);
	}
}

//Function Number: 12
func_4444()
{
	for(;;)
	{
		foreach(var_01 in level.players)
		{
			if(!isai(var_01) && !isdefined(var_01.var_6D89))
			{
				var_01.var_6D89 = 1;
				var_01 setclientomnvar("ui_options_menu",0);
				var_01.var_4009 = ::func_4439;
				var_02 = "allies";
				if(!isdefined(var_01.team))
				{
					if(level.var_115C6["axis"] < level.var_115C6["allies"])
					{
						var_02 = "axis";
					}
					else if(level.var_115C6["allies"] < level.var_115C6["axis"])
					{
						var_02 = "allies";
					}
				}

				var_01 scripts\mp\_menus::func_185F(var_02);
				level.var_6D88[var_01.team] = var_01;
				var_01 scripts\mp\_menus::func_3327();
				var_01.var_4006 = 0;
				var_01.var_136FE = 0;
				var_01 thread func_C52B();
				var_01 thread func_443A();
			}
		}

		wait(0.05);
	}
}

//Function Number: 13
func_C52B()
{
	self endon("disconnect");
	for(;;)
	{
		if(self.team != "spectator" && self.sessionstate == "spectator")
		{
			thread func_4436();
			thread func_1359A();
			thread func_4440();
			return;
		}

		wait(0.05);
	}
}

//Function Number: 14
func_4440()
{
	self endon("disconnect");
	self endon("joined_team");
	self endon("spectating_cycle");
	for(;;)
	{
		foreach(var_01 in level.players)
		{
			if(isbot(var_01) && var_01.team == self.team)
			{
				thread func_443F(var_01);
				var_01 thread func_4433();
				return;
			}
		}

		wait(0.1);
	}
}

//Function Number: 15
func_B96D()
{
	self endon("disconnect");
	self endon("joined_spectators");
	for(;;)
	{
		self waittill("commander_mode");
		var_00 = scripts\mp\killstreaks\_deployablebox::func_9E32();
		if(!isalive(self) || var_00)
		{
			continue;
		}

		break;
	}

	if(self.team == "spectator")
	{
		return;
	}

	thread func_1359A();
	self playlocalsound("mp_card_slide");
	var_01 = 0;
	foreach(var_03 in level.players)
	{
		if(isdefined(var_03) && var_03 != self && isbot(var_03) && isdefined(var_03.team) && var_03.team == self.team && isdefined(var_03.var_101B9) && var_03.var_101B9 == 1)
		{
			var_03 thread func_1097E(self);
			var_01 = 1;
			break;
		}
	}

	if(!var_01)
	{
		thread scripts\mp\_playerlogic::func_10911();
	}
}

//Function Number: 16
func_442B(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	if(!isbot(param_00))
	{
		return 0;
	}

	if(!isalive(param_00))
	{
		return 0;
	}

	if(!param_00.var_452B)
	{
		return 0;
	}

	if(param_00.team != self.team)
	{
		return 0;
	}

	var_01 = scripts\mp\killstreaks\_deployablebox::func_9E32();
	if(var_01)
	{
		return 0;
	}

	return 1;
}

//Function Number: 17
func_D097()
{
	for(var_00 = 0;var_00 < level.players.size;var_00++)
	{
		if(level.players[var_00] == self)
		{
			return var_00;
		}
	}

	return -1;
}

//Function Number: 18
func_4441(param_00)
{
	var_01 = self method_815D();
	var_02 = undefined;
	var_03 = 0;
	var_04 = 1;
	if(isdefined(param_00) && param_00 == 1)
	{
		var_04 = -1;
	}

	if(isdefined(var_01))
	{
		var_03 = var_01 func_D097();
	}

	var_05 = 1;
	for(var_06 = var_03 + var_04;var_05 < level.players.size;var_06 = var_06 + var_04)
	{
		var_05++;
		if(var_06 < 0)
		{
			var_06 = level.players.size - 1;
		}
		else if(var_06 >= level.players.size)
		{
			var_06 = 0;
		}

		if(!isdefined(level.players[var_06]))
		{
			continue;
		}

		if(isdefined(var_01) && level.players[var_06] == var_01)
		{
			break;
		}

		var_07 = func_442B(level.players[var_06]);
		if(var_07)
		{
			var_02 = level.players[var_06];
			break;
		}
	}

	if(isdefined(var_02) && !isdefined(var_01) || var_02 != var_01)
	{
		thread func_443F(var_02);
		self playlocalsound("oldschool_return");
		var_02 thread func_1148C();
		if(isdefined(var_01))
		{
			var_01 func_2D9D();
			return;
		}

		return;
	}

	self playlocalsound("counter_uav_deactivate");
}

//Function Number: 19
func_443F(param_00)
{
	self notify("commander_spectate_bot");
	self endon("commander_spectate_bot");
	self endon("commander_spectate_stop");
	self endon("disconnect");
	while(isdefined(param_00))
	{
		if(!self.var_2B0 && param_00.sessionstate == "playing")
		{
			var_01 = param_00 getentitynumber();
			if(self.var_140 != var_01)
			{
				self allowspectateteam("none",0);
				self allowspectateteam("freelook",0);
				self.var_140 = var_01;
				self.var_72E4 = param_00;
			}
		}

		wait(0.05);
	}
}

//Function Number: 20
func_7C94()
{
	var_00 = undefined;
	if(isdefined(self.var_72E4))
	{
		var_00 = self.var_72E4;
	}
	else
	{
		var_00 = self method_815D();
	}

	return var_00;
}

//Function Number: 21
func_4443()
{
	self endon("disconnect");
	self endon("joined_team");
	self endon("spectating_cycle");
	for(;;)
	{
		foreach(var_01 in level.players)
		{
			if(isbot(var_01) && var_01.team == self.team)
			{
				func_1097E(var_01);
				return;
			}
		}

		wait(0.1);
	}
}

//Function Number: 22
func_1097E(param_00)
{
	self.var_72E2 = param_00.origin;
	var_01 = param_00 getplayerangles();
	var_01 = (var_01[0],var_01[1],0);
	self.var_72E0 = (0,param_00.angles[1],0);
	self setstance(param_00 getstance());
	self.var_2EE3 = param_00.var_2EE3;
	self.var_2D33 = param_00.var_2D33;
	func_443B(self.var_2D33);
	self.health = param_00.health;
	self.var_381 = param_00.var_381;
	func_110AA(param_00);
	param_00 thread scripts\mp\_playerlogic::func_10911();
	if(isbot(param_00))
	{
		param_00.var_101B9 = 1;
		param_00 func_2D9D();
		self method_8230(param_00);
		self notify("commander_spectate_stop");
		param_00 notify("commander_took_over");
	}
	else
	{
	}

	thread scripts\mp\_playerlogic::func_1083A();
	self setplayerangles(var_01);
	func_20B7();
	function_0027(self,param_00);
	if(isbot(self))
	{
		param_00 thread func_443F(self);
		param_00 method_8230(undefined);
		self.var_101B9 = 0;
		param_00 playlocalsound("counter_uav_activate");
		thread func_1148C();
		param_00.var_4447 = undefined;
		param_00.var_A89D = self;
		func_2EC9();
		return;
	}

	thread func_B96D();
	self playsound("copycat_steal_class");
	thread func_1148C();
	self.var_4447 = param_00;
	self.var_A89D = undefined;
	if(!isdefined(self.var_4431))
	{
		thread func_4433();
	}
}

//Function Number: 23
func_1148C()
{
	if(!isdefined(self.var_1148D))
	{
		self.var_1148D = newclienthudelem(self);
		self.var_1148D.x = 0;
		self.var_1148D.y = 0;
		self.var_1148D.alignx = "left";
		self.var_1148D.aligny = "top";
		self.var_1148D.horzalign = "fullscreen";
		self.var_1148D.vertalign = "fullscreen";
		self.var_1148D setshader("combathigh_overlay",640,480);
		self.var_1148D.sort = -10;
		self.var_1148D.archived = 1;
	}

	self.var_1148D.alpha = 0;
	self.var_1148D fadeovertime(0.25);
	self.var_1148D.alpha = 1;
	wait(0.75);
	self.var_1148D fadeovertime(0.5);
	self.var_1148D.alpha = 0;
}

//Function Number: 24
func_1359A()
{
	self endon("disconnect");
	self endon("joined_team");
	self notify("takeover_wait_start");
	self endon("takeover_wait_start");
	for(;;)
	{
		self waittill("takeover_bot");
		var_00 = func_7C94();
		var_01 = func_442B(var_00);
		if(!var_01)
		{
			func_4441(0);
			var_00 = func_7C94();
			var_01 = func_442B(var_00);
		}

		if(var_01)
		{
			thread func_1097E(var_00);
			break;
		}

		self playlocalsound("counter_uav_deactivate");
	}
}

//Function Number: 25
func_2EC9()
{
	if(!isdefined(self) || !isplayer(self) || !isbot(self))
	{
		return;
	}

	self notify("wait_here");
	self botsetflag("disable_movement",1);
	self.var_2757 = "bot_waiting_" + self.team + "_" + self.name;
	badplace_cylinder(self.var_2757,5,self.origin,32,72,self.team);
	thread func_2D58();
	thread func_2EC8();
}

//Function Number: 26
func_2D58(param_00)
{
	self endon("freed_to_move");
	self endon("disconnect");
	self waittill("death");
	func_2D9D();
}

//Function Number: 27
func_2EC8()
{
	self endon("wait_here");
	wait(5);
	thread func_2D9D();
}

//Function Number: 28
func_2D9D()
{
	if(!isdefined(self) || !isplayer(self) || !isbot(self))
	{
		return;
	}

	self botsetflag("disable_movement",0);
	if(isdefined(self.var_2757))
	{
		badplace_delete(self.var_2757);
	}

	self notify("freed_to_move");
}

//Function Number: 29
func_4439(param_00)
{
	return self.var_2EE3;
}

//Function Number: 30
func_443B(param_00)
{
	self.pers["class"] = param_00;
	self.var_4004 = param_00;
	scripts\mp\_class::func_F691(param_00);
	self.var_322 = undefined;
	self.var_113E7 = undefined;
}

//Function Number: 31
func_110AA(param_00)
{
	self.var_4643 = param_00 getweaponslistall();
	self.var_464B = param_00 getcurrentweapon();
	foreach(var_02 in self.var_4643)
	{
		self.var_4648[var_02] = param_00 getweaponammoclip(var_02);
		self.var_464A[var_02] = param_00 getweaponammostock(var_02);
	}
}

//Function Number: 32
func_20B7()
{
	foreach(var_01 in self.var_4643)
	{
		if(!self hasweapon(var_01))
		{
			self giveweapon(var_01);
		}
	}

	var_03 = self getweaponslistall();
	foreach(var_01 in var_03)
	{
		if(!scripts\common\utility::func_2286(self.var_4643,var_01))
		{
			scripts\mp\_utility::func_141E(var_01);
		}
	}

	foreach(var_01 in self.var_4643)
	{
		if(self hasweapon(var_01))
		{
			self setweaponammoclip(var_01,self.var_4648[var_01]);
			self setweaponammostock(var_01,self.var_464A[var_01]);
			continue;
		}
	}

	if(self getcurrentweapon() != self.var_464B)
	{
		scripts\mp\_utility::_switchtoweapon(self.var_464B);
	}
}