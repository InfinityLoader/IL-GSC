/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_hud_message.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 44
 * Decompile Time: 827 ms
 * Timestamp: 10/27/2023 3:23:46 AM
*******************************************************************/

//Function Number: 1
func_00D5()
{
	game["round_end"]["draw"] = 1;
	game["round_end"]["round_draw"] = 2;
	game["round_end"]["round_win"] = 3;
	game["round_end"]["round_loss"] = 4;
	game["round_end"]["victory"] = 5;
	game["round_end"]["defeat"] = 6;
	game["round_end"]["halftime"] = 7;
	game["round_end"]["overtime"] = 8;
	game["round_end"]["roundend"] = 9;
	game["round_end"]["intermission"] = 10;
	game["round_end"]["side_switch"] = 11;
	game["round_end"]["match_bonus"] = 12;
	game["round_end"]["tie"] = 13;
	game["round_end"]["game_end"] = 14;
	game["round_end"]["spectator"] = 15;
	game["end_reason"]["score_limit_reached"] = 1;
	game["end_reason"]["time_limit_reached"] = 2;
	game["end_reason"]["players_forfeited"] = 3;
	game["end_reason"]["target_destroyed"] = 4;
	game["end_reason"]["bomb_defused"] = 5;
	game["end_reason"]["allies_eliminated"] = 6;
	game["end_reason"]["axis_eliminated"] = 7;
	game["end_reason"]["allies_forfeited"] = 8;
	game["end_reason"]["axis_forfeited"] = 9;
	game["end_reason"]["enemies_eliminated"] = 10;
	game["end_reason"]["tie"] = 11;
	game["end_reason"]["objective_completed"] = 12;
	game["end_reason"]["objective_failed"] = 13;
	game["end_reason"]["switching_sides"] = 14;
	game["end_reason"]["round_limit_reached"] = 15;
	game["end_reason"]["ended_game"] = 16;
	game["end_reason"]["host_ended_game"] = 17;
	game["end_reason"]["loss_stat_prevented"] = 18;
	game["end_reason"]["zombies_completed"] = 19;
	game["end_reason"]["zombie_extraction_failed"] = 20;
	game["end_reason"]["survivors_eliminated"] = 21;
	game["end_reason"]["infected_eliminated"] = 22;
	game["end_reason"]["survivors_forfeited"] = 23;
	game["end_reason"]["infected_forfeited"] = 24;
	game["end_reason"]["prop_tiebreaker_kills"] = 25;
	game["end_reason"]["prop_tiebreaker_time"] = 26;
	game["end_reason"]["ranked_play_void_match"] = 27;
	game["strings"]["overtime"] = &"MP_OVERTIME";
	level thread func_6B6C();
}

//Function Number: 2
func_6B6C()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_00 thread func_5F2C();
		var_00 thread func_5320();
	}
}

//Function Number: 3
func_4DC1(param_00)
{
	var_01 = spawnstruct();
	var_01.var_6811 = param_00;
	func_680B(var_01);
}

//Function Number: 4
func_5320()
{
	if((level.var_910F || self issplitscreenplayer()) && !function_03BA())
	{
		var_00 = 1.5;
		var_01 = 1.25;
		var_02 = 24;
		var_03 = "hudsmall";
		var_04 = "TOP";
		var_05 = "BOTTOM";
		var_06 = 0;
		var_07 = 0;
	}
	else
	{
		var_00 = 2.5;
		var_01 = 1.75;
		var_02 = 30;
		var_03 = "hudsmall";
		var_04 = "TOP";
		var_05 = "BOTTOM";
		var_06 = 50;
		var_07 = 0;
	}

	self.var_6813 = maps\mp\gametypes\_hud_util::func_27ED(var_03,var_00);
	self.var_6813 maps\mp\gametypes\_hud_util::func_8707(var_04,undefined,var_07,var_06);
	self.var_6813.var_C2 = 1;
	self.var_6813.var_1F = 0;
	self.var_6813.var_18 = 0;
	self.var_6811 = maps\mp\gametypes\_hud_util::func_27ED(var_03,var_01);
	self.var_6811 maps\mp\gametypes\_hud_util::func_86EF(self.var_6813);
	self.var_6811 maps\mp\gametypes\_hud_util::func_8707(var_04,var_05,0,0);
	self.var_6811.var_C2 = 1;
	self.var_6811.var_1F = 0;
	self.var_6811.var_18 = 0;
	self.var_6812 = maps\mp\gametypes\_hud_util::func_27ED(var_03,var_01);
	self.var_6812 maps\mp\gametypes\_hud_util::func_86EF(self.var_6813);
	self.var_6812 maps\mp\gametypes\_hud_util::func_8707(var_04,var_05,0,0);
	self.var_6812.var_C2 = 1;
	self.var_6812.var_1F = 0;
	self.var_6812.var_18 = 0;
	self.var_680A = maps\mp\gametypes\_hud_util::func_280B("white",var_02,var_02);
	self.var_680A maps\mp\gametypes\_hud_util::func_86EF(self.var_6812);
	self.var_680A maps\mp\gametypes\_hud_util::func_8707(var_04,var_05,0,0);
	self.var_680A.var_C2 = 1;
	self.var_680A.var_1F = 0;
	self.var_680A.var_18 = 0;
	self.var_680F = maps\mp\gametypes\_hud_util::func_280B("white",var_02,var_02);
	self.var_680F maps\mp\gametypes\_hud_util::func_86EF(self.var_680A);
	self.var_680F maps\mp\gametypes\_hud_util::func_8707("CENTER","CENTER",0,0);
	self.var_680F.var_C2 = 1;
	self.var_680F.var_1F = 0;
	self.var_680F.var_18 = 0;
	self.var_3202 = [];
	self.var_3202[0] = undefined;
	self.var_3202[1] = undefined;
	self.var_3202[2] = undefined;
	self.var_3202[3] = undefined;
	self.var_9106 = [];
	self.var_9106[0] = [];
	self.var_9106[1] = [];
	self.var_9106[2] = [];
	self.var_9106[3] = [];
}

//Function Number: 5
func_6A64(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = spawnstruct();
	var_06.var_9A2E = param_00;
	var_06.var_6811 = param_01;
	var_06.var_5019 = param_02;
	var_06.var_AB = param_03;
	var_06.var_8F2C = param_04;
	var_06.var_3511 = param_05;
	func_680B(var_06);
}

//Function Number: 6
func_680B(param_00)
{
	self endon("death");
	self endon("disconnect");
	if(!isdefined(param_00.var_8CA3))
	{
		param_00.var_8CA3 = 0;
	}

	var_01 = param_00.var_8CA3;
	if(!isdefined(param_00.var_1B9))
	{
		param_00.var_1B9 = "";
	}

	if(!isdefined(self.var_3202[var_01]))
	{
		thread func_8C0F(param_00);
		return;
	}

	self.var_9106[var_01][self.var_9106[var_01].size] = param_00;
}

//Function Number: 7
func_2FEF(param_00)
{
	waittillframeend;
	var_01 = self.var_9106[param_00][0];
	for(var_02 = 1;var_02 < self.var_9106[param_00].size;var_02++)
	{
		self.var_9106[param_00][var_02 - 1] = self.var_9106[param_00][var_02];
	}

	self.var_9106[param_00][var_02 - 1] = undefined;
	if(isdefined(var_01.var_109))
	{
		func_0884(var_01);
		return;
	}

	func_8C0F(var_01);
}

//Function Number: 8
func_7777()
{
	if(!isplayer(self))
	{
		return;
	}

	self endon("disconnect");
	var_00 = spawnstruct();
	var_01 = "promotion";
	var_00.var_109 = var_01;
	var_00.var_1B9 = tablelookup(func_4369(),0,var_01,11);
	var_00.var_8F2C = tablelookup(func_4369(),0,var_01,9);
	var_00.var_8CA3 = 0;
	thread func_0884(var_00);
}

//Function Number: 9
func_7A6A(param_00)
{
	if(!isplayer(self))
	{
		return;
	}

	self endon("disconnect");
	var_01 = spawnstruct();
	var_02 = "callout_rankPromoted";
	var_01.var_109 = var_02;
	var_01.var_1B9 = tablelookup(func_4369(),0,var_02,11);
	var_01.var_8F2C = tablelookup(func_4369(),0,var_02,9);
	var_01.var_73C1 = param_00;
	var_01.var_8CA3 = 0;
	if(var_01.var_1B9 == "playercard_splash")
	{
		var_01.var_8CA3 = 1;
	}

	thread func_0884(var_01);
}

//Function Number: 10
func_8C0F(param_00)
{
	self endon("disconnect");
	var_01 = param_00.var_8CA3;
	if(level.var_3F9D)
	{
		if(isdefined(param_00.var_1B9) && param_00.var_1B9 == "rank")
		{
			self setclientdvar("ui_promotion",1);
			self.var_75E5 = 1;
		}

		if(self.var_9106[var_01].size)
		{
			thread func_2FEF(var_01);
		}

		return;
	}

	self.var_3202[var_01] = param_00;
	thread func_7D65();
	func_A6F9(0);
	if(isdefined(param_00.var_3511))
	{
		var_02 = param_00.var_3511;
	}
	else if(level.var_3F9D)
	{
		var_02 = 2;
	}
	else
	{
		var_02 = 4;
	}

	if(isdefined(param_00.var_8F2C))
	{
		self method_8615(param_00.var_8F2C);
	}

	if(isdefined(param_00.var_5C49))
	{
		maps\mp\_utility::func_5C43(param_00.var_5C49);
	}

	var_03 = param_00.var_AB;
	var_04 = self.var_6813;
	if(isdefined(param_00.var_9A2E))
	{
		if(isdefined(param_00.var_9A2D))
		{
			self.var_6813.var_E5 = param_00.var_9A2D;
		}
		else
		{
			self.var_6813.var_E5 = &"";
		}

		if(isdefined(param_00.var_9A2D) && !isdefined(param_00.var_9A2C))
		{
			self.var_6813 setvalue(param_00.var_9A2E);
		}
		else
		{
			self.var_6813 settext(param_00.var_9A2E);
		}

		if(isdefined(var_03))
		{
			self.var_6813.var_AB = var_03;
		}

		self.var_6813.var_18 = 1;
		self.var_6813 fadeovertime(var_02 * 1.25);
		self.var_6813.var_18 = 0;
	}

	if(isdefined(param_00.var_992B))
	{
		var_03 = param_00.var_992B;
	}

	if(isdefined(param_00.var_6811))
	{
		if(isdefined(param_00.var_992E))
		{
			self.var_6811.var_E5 = param_00.var_992E;
		}
		else
		{
			self.var_6811.var_E5 = &"";
		}

		if(isdefined(param_00.var_992E) && !isdefined(param_00.var_992D))
		{
			self.var_6811 setvalue(param_00.var_6811);
		}
		else
		{
			self.var_6811 settext(param_00.var_6811);
		}

		if(isdefined(var_03))
		{
			self.var_6811.var_AB = var_03;
		}

		self.var_6811.var_18 = 1;
		self.var_6811 fadeovertime(var_02 * 1.25);
		self.var_6811.var_18 = 0;
		var_04 = self.var_6811;
	}

	if(isdefined(param_00.var_6812))
	{
		self.var_6812 maps\mp\gametypes\_hud_util::func_86EF(var_04);
		if(isdefined(param_00.var_9928))
		{
			self.var_6812.var_E5 = param_00.var_9928;
		}
		else
		{
			self.var_6812.var_E5 = &"";
		}

		self.var_6812 settext(param_00.var_6812);
		if(isdefined(var_03))
		{
			self.var_6812.var_AB = var_03;
		}

		self.var_6812.var_18 = 1;
		self.var_6812 fadeovertime(var_02 * 1.25);
		self.var_6812.var_18 = 0;
		var_04 = self.var_6812;
	}

	if(isdefined(param_00.var_5019))
	{
		self.var_680A maps\mp\gametypes\_hud_util::func_86EF(var_04);
		if((level.var_910F || self issplitscreenplayer()) && !function_03BA())
		{
			self.var_680A setshader(param_00.var_5019,30,30);
		}
		else
		{
			self.var_680A setshader(param_00.var_5019,60,60);
		}

		self.var_680A.var_18 = 0;
		if(isdefined(param_00.var_501E))
		{
			self.var_680A fadeovertime(0.15);
			self.var_680A.var_18 = 1;
			param_00.var_6CAE = 0;
			self.var_680F maps\mp\gametypes\_hud_util::func_86EF(self.var_680A);
			self.var_680F maps\mp\gametypes\_hud_util::func_8707("CENTER","CENTER",0,param_00.var_6CAE);
			self.var_680F setshader(param_00.var_501E,511,511);
			self.var_680F.var_18 = 0;
			self.var_680F.var_56 = game["colors"]["orange"];
			self.var_680F fadeovertime(0.4);
			self.var_680F.var_18 = 0.85;
			self.var_680F scaleovertime(0.4,32,32);
			func_A6F9(var_02);
			self.var_680A fadeovertime(0.75);
			self.var_680A.var_18 = 0;
			self.var_680F fadeovertime(0.75);
			self.var_680F.var_18 = 0;
		}
		else
		{
			self.var_680A fadeovertime(1);
			self.var_680A.var_18 = 1;
			func_A6F9(var_02);
			self.var_680A fadeovertime(0.75);
			self.var_680A.var_18 = 0;
		}
	}
	else
	{
		func_A6F9(var_02);
	}

	self notify("notifyMessageDone");
	self.var_3202[var_01] = undefined;
	if(self.var_9106[var_01].size)
	{
		thread func_2FEF(var_01);
	}
}

//Function Number: 11
func_265F(param_00,param_01)
{
	if(!isplayer(self))
	{
		return;
	}

	self endon("disconnect");
	waittillframeend;
	if(level.var_3F9D)
	{
		return;
	}

	var_02 = spawnstruct();
	var_02.var_109 = param_00;
	var_02.var_1B9 = tablelookup(func_4369(),0,param_00,11);
	var_02.var_6C18 = 0;
	var_02.var_8F2C = tablelookup(func_4369(),0,param_00,9);
	var_02.var_5C49 = param_01;
	var_02.var_8CA3 = 0;
	thread func_0884(var_02);
}

//Function Number: 12
func_5A78(param_00,param_01,param_02,param_03,param_04)
{
	if(!isplayer(self))
	{
		return;
	}

	self endon("disconnect");
	waittillframeend;
	if(level.var_3F9D)
	{
		return;
	}

	var_05 = spawnstruct();
	if(isdefined(param_02))
	{
		param_00 = param_00 + "_" + param_02;
	}

	if(!isdefined(param_03))
	{
		param_03 = -1;
	}

	var_05.var_109 = param_00;
	var_05.var_1B9 = tablelookup(func_4369(),0,param_00,11);
	var_05.var_6C18 = param_01;
	var_05.var_8F2C = maps\mp\_utility::func_4547(param_00);
	var_05.var_5C49 = param_00;
	var_05.var_5C4A = "killstreak_earned";
	var_05.var_8CA3 = 0;
	var_05.var_5A76 = param_03;
	if(isdefined(param_04))
	{
		var_05.var_5C49 = param_04;
	}

	thread func_0884(var_05);
}

//Function Number: 13
func_20AB(param_00,param_01,param_02)
{
	if(!isplayer(self))
	{
		return;
	}

	self endon("disconnect");
	waittillframeend;
	wait 0.05;
	for(var_03 = param_02 - 1;var_03 >= param_01;var_03--)
	{
		var_04 = maps\mp\gametypes\_hud_util::func_2099(param_00,var_03);
		if(var_04 == 0)
		{
			var_04 = 1;
		}

		if(param_00 == "ch_exomech_frontier")
		{
			var_04 = int(var_04 / 528);
		}

		var_05 = spawnstruct();
		var_05.var_109 = param_00;
		var_05.var_1B9 = tablelookup(func_4369(),0,param_00,11);
		var_05.var_20AC = var_03;
		var_05.var_6C18 = var_04;
		var_05.var_8F2C = tablelookup(func_4369(),0,param_00,9);
		var_05.var_8CA3 = 0;
		thread func_0884(var_05);
	}
}

//Function Number: 14
func_9102(param_00,param_01,param_02)
{
	if(!isplayer(self))
	{
		return;
	}

	self endon("disconnect");
	wait 0.05;
	var_03 = spawnstruct();
	var_03.var_109 = param_00;
	var_03.var_1B9 = tablelookup(func_4369(),0,param_00,11);
	var_03.var_6C18 = param_01;
	var_03.var_8F2C = tablelookup(func_4369(),0,var_03.var_109,9);
	if(!isdefined(param_02))
	{
		param_02 = -1;
	}

	var_03.var_5A76 = param_02;
	var_03.var_8CA3 = 0;
	if(common_scripts\utility::func_562E(level.var_2FA1))
	{
		switch(var_03.var_1B9)
		{
			case "specialist_splash":
			case "challenge_splash":
			case "rankup_splash":
			case "largewar_splash":
			case "playercard_splash":
				break;

			default:
				break;
		}
	}

	thread func_0884(var_03);
}

//Function Number: 15
func_9104(param_00,param_01)
{
	if(!isplayer(self))
	{
		return;
	}

	self endon("disconnect");
	wait 0.05;
	var_02 = spawnstruct();
	var_02.var_109 = param_00;
	var_02.var_1B9 = tablelookup(func_4369(),0,param_00,11);
	var_02.var_6C18 = param_01;
	var_02.var_8F2C = tablelookup(func_4369(),0,param_00,9);
	var_02.var_8CA3 = 0;
	thread func_0884(var_02);
}

//Function Number: 16
func_9103(param_00,param_01)
{
	if(!isplayer(self))
	{
		return;
	}

	self endon("disconnect");
	waittillframeend;
	if(level.var_3F9D)
	{
		return;
	}

	var_02 = spawnstruct();
	var_02.var_109 = param_00;
	var_02.var_1B9 = tablelookup(func_4369(),0,param_00,11);
	var_02.var_6C18 = param_01;
	var_02.var_8F2C = tablelookup(func_4369(),0,param_00,9);
	var_02.var_8CA3 = 0;
	thread func_0884(var_02);
}

//Function Number: 17
func_7A6C(param_00,param_01,param_02)
{
	if(!isplayer(self))
	{
		return;
	}

	self endon("disconnect");
	waittillframeend;
	if(level.var_3F9D)
	{
		return;
	}

	var_03 = spawnstruct();
	var_03.var_109 = param_00;
	var_03.var_1B9 = tablelookup(func_4369(),0,param_00,11);
	var_03.var_8F2C = tablelookup(func_4369(),0,param_00,9);
	var_03.var_7A65 = param_01;
	if(isdefined(param_02))
	{
		var_03.var_76B0 = param_02;
	}

	var_03.var_8CA3 = 0;
	thread func_0884(var_03);
}

//Function Number: 18
func_A9DD(param_00,param_01,param_02)
{
	if(!isplayer(self))
	{
		return;
	}

	self endon("disconnect");
	waittillframeend;
	if(level.var_3F9D)
	{
		return;
	}

	var_03 = spawnstruct();
	var_03.var_109 = param_00;
	var_03.var_1B9 = tablelookup(func_4369(),0,param_00,11);
	var_03.var_8F2C = tablelookup(func_4369(),0,param_00,9);
	var_03.var_A9D0 = param_02;
	var_03.var_8CA3 = 0;
	thread func_0884(var_03);
}

//Function Number: 19
func_3055(param_00,param_01)
{
	if(!isplayer(self))
	{
		return;
	}

	self endon("disconnect");
	waittillframeend;
	if(level.var_3F9D)
	{
		return;
	}

	var_02 = spawnstruct();
	var_02.var_109 = param_00;
	var_02.var_1B9 = tablelookup(func_4369(),0,param_00,11);
	var_02.var_8F2C = tablelookup(func_4369(),0,param_00,9);
	var_02.var_3054 = param_01;
	var_02.var_8CA3 = 0;
	thread func_0884(var_02);
}

//Function Number: 20
func_73C2(param_00,param_01,param_02)
{
	if(!isplayer(self))
	{
		return;
	}

	self endon("disconnect");
	waittillframeend;
	if(level.var_3F9D)
	{
		return;
	}

	var_03 = spawnstruct();
	var_03.var_109 = param_00;
	var_03.var_1B9 = tablelookup(func_4369(),0,param_00,11);
	var_03.var_6C18 = param_02;
	var_03.var_8F2C = tablelookup(func_4369(),0,param_00,9);
	var_03.var_73C1 = param_01;
	var_03.var_8CA3 = 0;
	if(var_03.var_1B9 == "playercard_splash")
	{
		var_03.var_8CA3 = 1;
	}

	thread func_0884(var_03);
}

//Function Number: 21
func_0884(param_00)
{
	self endon("death");
	self endon("disconnect");
	var_01 = param_00.var_8CA3;
	if(!isdefined(param_00.var_1B9))
	{
		param_00.var_1B9 = "";
	}

	if(!isdefined(self.var_3202[var_01]))
	{
		thread func_0885(param_00);
		return;
	}
	else
	{
		switch(param_00.var_1B9)
		{
			case "urgent_splash":
			case "specialist_splash":
			case "largewar_splash":
				self.var_6811.var_18 = 0;
				self.var_6812.var_18 = 0;
				self.var_680A.var_18 = 0;
				self setclientomnvar("ui_splash_idx",-1);
				self setclientomnvar("ui_splash_killstreak_idx",-1);
				self setclientomnvar("ui_daily_challenge_idx",-1);
				thread func_0885(param_00);
				break;

			case "daily_challenge_splash":
			case "killstreak_splash":
			case "killstreak_coop_splash":
			case "splash":
				if(self.var_3202[var_01].var_1B9 != "splash" && self.var_3202[var_01].var_1B9 != "urgent_splash" && self.var_3202[var_01].var_1B9 != "largewar_splash" && self.var_3202[var_01].var_1B9 != "killstreak_coop_splash" && self.var_3202[var_01].var_1B9 != "killstreak_splash" && self.var_3202[var_01].var_1B9 != "challenge_splash" && self.var_3202[var_01].var_1B9 != "promotion_splash" && self.var_3202[var_01].var_1B9 != "intel_splash" && self.var_3202[var_01].var_1B9 != "rankup_splash" && self.var_3202[var_01].var_1B9 != "weapon_level_splash" && self.var_3202[var_01].var_1B9 != "division_level_splash" && self.var_3202[var_01].var_1B9 != "daily_challenge_splash" && self.var_3202[var_01].var_1B9 != "specialist_splash")
				{
					self.var_6811.var_18 = 0;
					self.var_6812.var_18 = 0;
					self.var_680A.var_18 = 0;
					thread func_0885(param_00);
					return;
				}
				break;
		}
	}

	if(param_00.var_1B9 == "challenge_splash" || param_00.var_1B9 == "killstreak_splash" || param_00.var_1B9 == "killstreak_coop_splash" || param_00.var_1B9 == "daily_challenge_splash")
	{
		if(param_00.var_1B9 == "daily_challenge_splash" && self.var_9106[var_01].size > 0)
		{
			var_02 = "";
			if(issubstr(param_00.var_109,"_complete"))
			{
				var_02 = "_complete";
			}

			foreach(var_04 in self.var_9106[var_01])
			{
				if(var_04.var_109 + var_02 == param_00.var_109)
				{
					self.var_9106[var_01] = common_scripts\utility::func_F93(self.var_9106[var_01],var_04);
					break;
				}
			}
		}

		for(var_06 = self.var_9106[var_01].size;var_06 > 0;var_06--)
		{
			self.var_9106[var_01][var_06] = self.var_9106[var_01][var_06 - 1];
		}

		self.var_9106[var_01][0] = param_00;
		return;
	}

	self.var_9106[var_01][self.var_9106[var_01].size] = param_00;
}

//Function Number: 22
func_0885(param_00)
{
	self endon("disconnect");
	var_01 = param_00.var_8CA3;
	if(level.var_3F9D)
	{
		if(isdefined(param_00.var_1B9) && param_00.var_1B9 == "promotion_splash" || param_00.var_1B9 == "promotion_weapon_splash")
		{
			self setclientdvar("ui_promotion",1);
			self.var_75E5 = 1;
		}
		else if(isdefined(param_00.var_1B9) && param_00.var_1B9 == "challenge_splash")
		{
			self.var_12C["postGameChallenges"]++;
			self setclientdvar("ui_challenge_" + self.var_12C["postGameChallenges"] + "_ref",param_00.var_109);
		}

		if(self.var_9106[var_01].size)
		{
			thread func_2FEF(var_01);
		}

		return;
	}

	if(!isdefined(self.var_66CE))
	{
		self.var_66CE = 0;
	}

	if(tablelookup(func_4369(),0,param_00.var_109,0) != "")
	{
		var_02 = tablelookuprownum(func_4369(),0,param_00.var_109);
		var_03 = common_scripts\utility::func_9468(tablelookupbyrow(func_4369(),var_02,4));
		switch(param_00.var_1B9)
		{
			case "killstreak_splash":
			case "killstreak_coop_splash":
				if(getdvarint("5270",1))
				{
					func_8C18(param_00.var_109,param_00.var_5A76);
				}
				break;

			case "playercard_splash":
				if(isdefined(param_00.var_73C1))
				{
					self setclientomnvar("ui_splash_playercard_idx",var_02);
					if(isplayer(param_00.var_73C1))
					{
						self setclientomnvar("ui_splash_playercard_clientnum",param_00.var_73C1 getentitynumber());
					}
	
					if(isdefined(param_00.var_6C18))
					{
						self setclientomnvar("ui_splash_playercard_optional_number",param_00.var_6C18);
					}
				}
				break;

			case "perk_challenge_splash":
			case "intel_splash":
			case "daily_challenge_splash":
			case "urgent_splash":
			case "specialist_splash":
			case "challenge_splash":
			case "largewar_splash":
			case "splash":
				func_8C18(param_00.var_109,param_00.var_6C18);
				break;

			case "rankup_splash":
				func_8C18(param_00.var_109,param_00.var_7A65);
				break;

			case "weapon_level_splash":
				func_8C18(param_00.var_109,param_00.var_A9D0);
				break;

			case "division_level_splash":
				func_8C18(param_00.var_109,param_00.var_3054);
				break;

			default:
				break;
		}

		self.var_3202[var_01] = param_00;
		if(isdefined(param_00.var_5C49))
		{
			if(isdefined(param_00.var_5C4A))
			{
				maps\mp\_utility::func_5C43(param_00.var_5C49,param_00.var_5C4A,1);
			}
			else
			{
				maps\mp\_utility::func_5C43(param_00.var_5C49);
			}
		}

		self notify("actionNotifyMessage" + var_01);
		self endon("actionNotifyMessage" + var_01);
		self.var_3202[var_01] = undefined;
	}

	if(self.var_9106[var_01].size)
	{
		thread func_2FEF(var_01);
	}
}

//Function Number: 23
func_A6F9(param_00)
{
	var_01 = 0.05;
	while(!func_1F68())
	{
		wait(var_01);
	}

	while(param_00 > 0)
	{
		wait(var_01);
		if(func_1F68())
		{
			param_00 = param_00 - var_01;
		}
	}
}

//Function Number: 24
func_1F68()
{
	if(maps\mp\_flashgrenades::func_56F3())
	{
		return 0;
	}

	return 1;
}

//Function Number: 25
func_7D66()
{
	self endon("notifyMessageDone");
	self endon("disconnect");
	level endon("game_ended");
	self waittill("death");
	func_7D64();
}

//Function Number: 26
func_7D65()
{
	self notify("resetOnCancel");
	self endon("resetOnCancel");
	self endon("notifyMessageDone");
	self endon("disconnect");
	level waittill("cancel_notify");
	func_7D64();
}

//Function Number: 27
func_7D64()
{
	self.var_6813.var_18 = 0;
	self.var_6811.var_18 = 0;
	self.var_680A.var_18 = 0;
	self.var_680F.var_18 = 0;
	self.var_3202[0] = undefined;
	self.var_3202[1] = undefined;
	self.var_3202[2] = undefined;
	self.var_3202[3] = undefined;
}

//Function Number: 28
func_5F2C()
{
	self endon("disconnect");
	self.var_5F2B = [];
	var_00 = "default";
	if(isdefined(level.var_5F2A))
	{
		var_00 = level.var_5F2A;
	}

	var_01 = -140;
	var_02 = level.var_5F2D;
	var_03 = 1.25;
	if((level.var_910F || self issplitscreenplayer() && !isai(self)) && !function_03BA())
	{
		var_01 = var_01 - 40;
		var_02 = level.var_5F2D * 1.3;
		var_03 = var_03 * 1.5;
	}

	self.var_5F29 = maps\mp\gametypes\_hud_util::func_27ED(var_00,var_02);
	self.var_5F29 settext("");
	self.var_5F29.var_1F = 0;
	self.var_5F29.ignoreme = 10;
	self.var_5F29.var_180 = 0;
	self.var_5F29 maps\mp\gametypes\_hud_util::func_8707("CENTER",level.var_5F2F,0,var_01);
	self.var_5F30 = maps\mp\gametypes\_hud_util::func_27ED("default",var_03);
	self.var_5F30 maps\mp\gametypes\_hud_util::func_86EF(self.var_5F29);
	self.var_5F30 maps\mp\gametypes\_hud_util::func_8707("TOP","BOTTOM",0,0);
	self.var_5F30 settext("");
	self.var_5F30.var_1F = 0;
	self.var_5F30.ignoreme = 10;
	self.var_5F30.var_180 = 0;
}

//Function Number: 29
func_6C66(param_00)
{
	if(level.var_984D)
	{
		if(param_00 == "tie")
		{
			func_602C("draw");
			return;
		}

		if(param_00 == self.var_1A7)
		{
			func_602C("victory");
			return;
		}

		func_602C("defeat");
		return;
	}

	if(param_00 == self)
	{
		func_602C("victory");
		return;
	}

	func_602C("defeat");
}

//Function Number: 30
func_602C(param_00)
{
	var_01 = self.var_1A7;
	var_02 = maps\mp\gametypes\_hud_util::func_27ED("bigfixed",1);
	var_02 maps\mp\gametypes\_hud_util::func_8707("TOP",undefined,0,50);
	var_02.var_A0 = 1;
	var_02.var_AA = 1;
	var_02.var_C2 = 0;
	var_02.var_1F = 0;
	var_02 settext(game["strings"][param_00]);
	var_02.var_18 = 0;
	var_02 fadeovertime(0.5);
	var_02.var_18 = 1;
	switch(param_00)
	{
		case "victory":
			var_02.var_AB = game["colors"]["cyan"];
			break;

		default:
			var_02.var_AB = game["colors"]["orange"];
			break;
	}

	var_03 = maps\mp\gametypes\_hud_util::func_280B(game["icons"][var_01],64,64);
	var_03 maps\mp\gametypes\_hud_util::func_86EF(var_02);
	var_03 maps\mp\gametypes\_hud_util::func_8707("TOP","BOTTOM",0,30);
	var_03.var_A0 = 1;
	var_03.var_C2 = 0;
	var_03.var_1F = 0;
	var_03.var_18 = 0;
	var_03 fadeovertime(0.5);
	var_03.var_18 = 1;
	wait(3);
	var_02 maps\mp\gametypes\_hud_util::func_2DCC();
	var_03 maps\mp\gametypes\_hud_util::func_2DCC();
}

//Function Number: 31
func_56CE()
{
	if(isdefined(self.var_3202[0]))
	{
		return 1;
	}

	if(isdefined(self.var_3202[1]))
	{
		return 1;
	}

	if(isdefined(self.var_3202[2]))
	{
		return 1;
	}

	if(isdefined(self.var_3202[3]))
	{
		return 1;
	}

	return 0;
}

//Function Number: 32
func_985C(param_00,param_01,param_02,param_03)
{
	self endon("disconnect");
	self notify("reset_outcome");
	thread func_5CA5(32,1);
	wait(0.5);
	var_04 = self.var_12C["team"];
	if(!isdefined(var_04) || var_04 != "allies" && var_04 != "axis")
	{
		var_04 = "allies";
	}

	while(func_56CE())
	{
		wait 0.05;
	}

	self endon("reset_outcome");
	var_05 = 0;
	if(level.var_3FDC == "ctf" && isdefined(param_03) && param_03)
	{
		var_05 = 1;
	}

	if(param_00 == "halftime")
	{
		self setclientomnvar("ui_round_end_title",game["round_end"]["halftime"]);
		param_00 = "allies";
		if(level.var_3FDC == "ctf")
		{
			var_05 = 1;
		}
	}
	else if(param_00 == "intermission")
	{
		self setclientomnvar("ui_round_end_title",game["round_end"]["intermission"]);
		param_00 = "allies";
	}
	else if(param_00 == "roundend")
	{
		self setclientomnvar("ui_round_end_title",game["round_end"]["roundend"]);
		param_00 = "allies";
	}
	else if(param_00 == "none")
	{
		self setclientomnvar("ui_round_end_title",game["round_end"]["game_end"]);
	}
	else if(maps\mp\_utility::func_576C(param_00))
	{
		self setclientomnvar("ui_round_end_title",game["round_end"]["overtime"]);
		if(level.var_3FDC == "ctf" && param_00 == "overtime")
		{
			var_05 = 1;
		}

		param_00 = "allies";
	}
	else if(param_00 == "tie")
	{
		if(param_01)
		{
			self setclientomnvar("ui_round_end_title",game["round_end"]["round_draw"]);
		}
		else
		{
			self setclientomnvar("ui_round_end_title",game["round_end"]["draw"]);
		}

		param_00 = "allies";
	}
	else if(self method_8436())
	{
		self setclientomnvar("ui_round_end_title",game["round_end"]["spectator"]);
	}
	else if(isdefined(self.var_12C["team"]) && param_00 == var_04)
	{
		if(param_01)
		{
			self setclientomnvar("ui_round_end_title",game["round_end"]["round_win"]);
		}
		else
		{
			self setclientomnvar("ui_round_end_title",game["round_end"]["victory"]);
		}
	}
	else if(param_01)
	{
		self setclientomnvar("ui_round_end_title",game["round_end"]["round_loss"]);
	}
	else
	{
		self setclientomnvar("ui_round_end_title",game["round_end"]["defeat"]);
		if(isdefined(self.var_5969) && self.var_5969 && maps\mp\_utility::func_7A69())
		{
			param_02 = game["end_reason"]["loss_stat_prevented"];
		}
	}

	self setclientomnvar("ui_round_end_reason",param_02);
	if(isdefined(level.gametyperoundendscoresetomnvar) && [[ level.gametyperoundendscoresetomnvar ]](param_00,param_01,param_02,param_03,var_04))
	{
	}
	else if(var_05 && !level.var_AA24)
	{
		self setclientomnvar("ui_round_end_friendly_score",game["roundsWon"][var_04]);
		self setclientomnvar("ui_round_end_enemy_score",game["roundsWon"][level.var_6C63[var_04]]);
	}
	else if(!maps\mp\_utility::func_57B2() || !maps\mp\_utility::func_5760())
	{
		self setclientomnvar("ui_round_end_friendly_score",maps\mp\gametypes\_gamescore::func_63E(var_04));
		self setclientomnvar("ui_round_end_enemy_score",maps\mp\gametypes\_gamescore::func_63E(level.var_6C63[var_04]));
	}
	else
	{
		self setclientomnvar("ui_round_end_friendly_score",game["roundsWon"][var_04]);
		self setclientomnvar("ui_round_end_enemy_score",game["roundsWon"][level.var_6C63[var_04]]);
	}

	if(isdefined(self.var_6024))
	{
		self setclientomnvar("ui_round_end_match_bonus",self.var_6024);
	}

	if(isdefined(game["round_time_to_beat"]))
	{
		self setclientomnvar("ui_round_end_stopwatch",int(game["round_time_to_beat"] * 60));
	}

	self setclientomnvar("ui_round_end",1);
}

//Function Number: 33
func_6C65(param_00,param_01)
{
	self endon("disconnect");
	self notify("reset_outcome");
	while(func_56CE())
	{
		wait 0.05;
	}

	self endon("reset_outcome");
	var_02 = level.var_7006["all"];
	var_03 = var_02[0];
	var_04 = var_02[1];
	var_05 = var_02[2];
	var_06 = 0;
	if(isdefined(var_03) && self.var_15C == var_03.var_15C && self.var_70 == var_03.var_70)
	{
		if(self != var_03)
		{
			var_06 = 1;
		}
		else if(isdefined(var_04) && var_04.var_15C == var_03.var_15C && var_04.var_70 == var_03.var_70)
		{
			var_06 = 1;
		}
	}

	if(var_06)
	{
		self setclientomnvar("ui_round_end_title",game["round_end"]["tie"]);
	}
	else if(isdefined(var_03) && self == var_03)
	{
		self setclientomnvar("ui_round_end_title",game["round_end"]["victory"]);
	}
	else
	{
		self setclientomnvar("ui_round_end_title",game["round_end"]["defeat"]);
		if(isdefined(self.var_5969) && self.var_5969 && maps\mp\_utility::func_7A69())
		{
			param_01 = game["end_reason"]["loss_stat_prevented"];
		}
	}

	self setclientomnvar("ui_round_end_reason",param_01);
	if(isdefined(self.var_6024))
	{
		self setclientomnvar("ui_round_end_match_bonus",self.var_6024);
	}

	self setclientomnvar("ui_round_end",1);
	self waittill("update_outcome");
}

//Function Number: 34
func_1F6C(param_00)
{
}

//Function Number: 35
func_5CA5(param_00,param_01)
{
	self setblurforplayer(param_00,param_01);
}

//Function Number: 36
func_4369()
{
	return "mp/splashTable.csv";
}

//Function Number: 37
func_8C18(param_00,param_01)
{
	if(isdefined(self.var_7AD5) && self.var_7AD5 >= 6)
	{
		func_788E(param_00,param_01);
		return;
	}

	if(!maps\mp\_utility::func_57A0(self))
	{
		func_788E(param_00,param_01);
		return;
	}

	func_8C19(param_00,param_01);
}

//Function Number: 38
setbroadcasteromnvar(param_00,param_01)
{
	foreach(var_03 in level.broadcasters)
	{
		if(isdefined(var_03.var_1E99) && isdefined(var_03.var_1E99.var_9815) && self == var_03.var_1E99.var_9815)
		{
			var_03 setclientomnvar(param_00 + self.var_66CE,param_01);
		}
	}
}

//Function Number: 39
func_8C19(param_00,param_01)
{
	if(!isplayer(self))
	{
		return;
	}

	var_02 = tablelookuprownum(func_4369(),0,param_00);
	if(!isdefined(var_02) || var_02 < 0)
	{
		return;
	}

	if(!isdefined(self.var_66CE))
	{
		self.var_66CE = 0;
	}

	if(!isdefined(self.var_9100))
	{
		self.var_9100 = 1;
	}

	var_03 = var_02 << 1;
	if(self.var_9100)
	{
		var_03 = var_03 | 1;
	}

	if(isdefined(param_01))
	{
		self setclientomnvar("ui_player_splash_param_" + self.var_66CE,param_01);
		setbroadcasteromnvar("ui_player_splash_param_",param_01);
	}
	else
	{
		self setclientomnvar("ui_player_splash_param_" + self.var_66CE,-1);
		setbroadcasteromnvar("ui_player_splash_param_",-1);
	}

	self setclientomnvar("ui_player_splash_id_" + self.var_66CE,var_03);
	setbroadcasteromnvar("ui_player_splash_id_",var_03);
	if(!isdefined(self.var_7AD5))
	{
		self.var_7AD5 = 1;
	}
	else
	{
		self.var_7AD5++;
	}

	thread func_2389();
	foreach(var_05 in level.broadcasters)
	{
		var_05 thread cleanupbroadcastersplashlist();
	}

	self.var_66CE++;
	if(self.var_66CE >= 6)
	{
		self.var_66CE = 0;
		self.var_9100 = !self.var_9100;
	}
}

//Function Number: 40
func_2389()
{
	self endon("disconnect");
	self notify("cleanupLocalPlayerSplashList()");
	self endon("cleanupLocalPlayerSplashList()");
	common_scripts\utility::func_A74B("death",0.5);
	while(!maps\mp\_utility::func_57A0(self))
	{
		wait(0.15);
	}

	self.var_7AD5 = undefined;
	self notify("splash_list_cleared");
}

//Function Number: 41
cleanupbroadcastersplashlisttimeout()
{
	self endon("disconnect");
	self endon("cleanupBroadcasterSplashList");
	wait(0.5);
	self.var_7AD5 = undefined;
	self notify("splash_list_cleared");
	self notify("broadcasterSplashListTimeOut");
}

//Function Number: 42
cleanupbroadcastersplashlist()
{
	self endon("disconnect");
	self endon("broadcasterSplashListTimeOut");
	self endon("cleanupBroadcasterSplashList");
	for(;;)
	{
		thread cleanupbroadcastersplashlisttimeout();
		self waittill("luinotifyserver",var_00,var_01);
		if(var_00 == "broadcaster_client_change")
		{
			var_02 = int(floor(var_01 / 100));
			if(var_02 == self.var_2418)
			{
				self notify("cleanupBroadcasterSplashList");
				self.var_7AD5 = undefined;
				self notify("splash_list_cleared");
			}
		}
	}
}

//Function Number: 43
func_788E(param_00,param_01)
{
	var_02 = spawnstruct();
	var_02.var_7B79 = param_00;
	var_02.var_6C18 = param_01;
	if(!isdefined(self.var_9107))
	{
		self.var_9107 = var_02;
		self.var_9108 = var_02;
		thread func_4AF7();
		return;
	}

	var_03 = self.var_9108;
	var_03.var_66CD = var_02;
	self.var_9108 = var_02;
}

//Function Number: 44
func_4AF7()
{
	level endon("game_ended");
	self endon("death");
	self endon("disconnect");
	while(isdefined(self.var_9107))
	{
		common_scripts\utility::knock_off_battery("splash_list_cleared","spawned_player");
		for(var_00 = 0;var_00 < 6;var_00++)
		{
			var_01 = self.var_9107;
			func_8C19(var_01.var_7B79,var_01.var_6C18);
			self.var_9107 = var_01.var_66CD;
			if(!isdefined(self.var_9107))
			{
				break;
			}
		}
	}

	self.var_9108 = undefined;
}