/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\_gestures_mp.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 17
 * Decompile Time: 646 ms
 * Timestamp: 10/27/2023 12:20:29 AM
*******************************************************************/

//Function Number: 1
init()
{
	level.var_77C0 = [];
	var_00 = 0;
	for(;;)
	{
		var_01 = tablelookupbyrow("mp/gesturetable.csv",var_00,0);
		if(!isdefined(var_01) || var_01 == "")
		{
			break;
		}

		var_02 = tablelookupbyrow("mp/gesturetable.csv",var_00,1);
		if(!isdefined(var_02) || var_02 == "")
		{
			break;
		}

		level.var_77C0[var_01] = var_02;
		var_00++;
	}

	level.rockpaperscissors = ["ges_plyr_gesture043","ges_plyr_gesture114","ges_plyr_gesture115"];
}

//Function Number: 2
func_7ED0(param_00)
{
	if(isbot(self) && param_00 == "devilhorns_mp")
	{
		param_00 = "gesture009";
	}

	return level.var_77C0[param_00];
}

//Function Number: 3
func_41B2()
{
	self notify("clearGesture");
	if(isdefined(self.var_77C2) && self.var_77C2 != "none")
	{
		if(scripts\common\utility::func_9C70())
		{
			scripts\mp\_utility::_setactionslot(3,"");
		}
		else
		{
			scripts\mp\_utility::_setactionslot(7,"");
		}

		scripts\mp\_utility::func_141E(self.var_77C2);
		self.var_77C2 = "none";
	}
}

//Function Number: 4
func_8368(param_00)
{
	switch(param_00)
	{
		case "ges_plyr_gesture043":
			thread gesture_rockpaperscissorsthink();
			param_00 = gesture_pickrockpaperscissors();
			break;

		case "ges_plyr_gesture050":
			if(scripts\mp\_utility::func_9D48("archetype_scout"))
			{
				var_01 = getbodymodel();
				if(!isdefined(var_01) || var_01 != "mp_synaptic_ethan_body" || func_8BDB())
				{
					var_02 = scripts\common\utility::func_116D7(scripts\common\utility::func_4347(),"ges_plyr_gesture050_synaptic","ges_plyr_gesture052_synaptic");
				}
				else
				{
					var_02 = scripts\common\utility::func_116D7(scripts\common\utility::func_4347(),"ges_plyr_gesture050","ges_plyr_gesture052");
				}
			}
			else
			{
				var_02 = scripts\common\utility::func_116D7(scripts\common\utility::func_4347(),"ges_plyr_gesture050","ges_plyr_gesture052");
			}
	
			thread gesture_coinflipthink(var_02);
			param_00 = var_02;
			break;

		case "ges_plyr_gesture020":
			if(scripts\mp\_utility::func_9D48("archetype_scout"))
			{
				var_01 = getbodymodel();
				if(!isdefined(var_01) || var_01 != "mp_synaptic_ethan_body" || func_8BDB())
				{
					param_00 = "ges_plyr_gesture020_synaptic";
				}
			}
			break;

		case "ges_plyr_gesture046":
			if(scripts\mp\_utility::func_9D48("archetype_scout"))
			{
				var_01 = getbodymodel();
				if(!isdefined(var_01) || var_01 != "mp_synaptic_ethan_body" || func_8BDB())
				{
					param_00 = "ges_plyr_gesture046_synaptic";
				}
			}
			break;

		case "ges_plyr_gesture048":
			if(scripts\mp\_utility::func_9D48("archetype_scout"))
			{
				var_01 = getbodymodel();
				if(!isdefined(var_01) || var_01 != "mp_synaptic_ethan_body" || func_8BDB())
				{
					param_00 = "ges_plyr_gesture048_synaptic";
				}
			}
			break;
	}

	if(scripts\common\utility::func_9C70())
	{
		scripts\mp\_utility::_setactionslot(3,"taunt");
	}
	else
	{
		scripts\mp\_utility::_setactionslot(7,"taunt");
	}

	if(!level.console)
	{
		thread monitorgamepadswitch();
	}

	scripts\mp\_utility::func_12C6(param_00);
	self method_8541(param_00);
	self.var_77C2 = param_00;
	thread func_77A4();
}

//Function Number: 5
monitorgamepadswitch()
{
	self endon("clearGesture");
	self endon("disconnect");
	var_00 = scripts\common\utility::func_9C70();
	for(;;)
	{
		if(isdefined(self.var_55C9) && self.var_55C9 > 0)
		{
			wait(0.05);
			continue;
		}

		var_01 = scripts\common\utility::func_9C70();
		if(var_01 != var_00)
		{
			if(var_00)
			{
				scripts\mp\_utility::_setactionslot(3,"");
				scripts\mp\_utility::_setactionslot(7,"taunt");
			}
			else
			{
				scripts\mp\_utility::_setactionslot(3,"taunt");
				scripts\mp\_utility::_setactionslot(7,"");
			}
		}

		var_00 = var_01;
		wait(0.05);
	}
}

//Function Number: 6
func_77A4()
{
	self endon("clearGesture");
	self endon("death");
	self endon("disconnect");
	for(;;)
	{
		self waittill("offhand_pullback",var_00);
		if(self.var_77C2 == var_00)
		{
			self notify("used_cosmetic_gesture");
		}
	}
}

//Function Number: 7
gesture_pickrockpaperscissors()
{
	return level.rockpaperscissors[randomintrange(0,level.rockpaperscissors.size)];
}

//Function Number: 8
gesture_rockpaperscissorsthink()
{
	self endon("clearGesture");
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	self notify("gesture_rockPaperScissorsThink()");
	self endon("gesture_rockPaperScissorsThink()");
	for(;;)
	{
		self waittill("used_cosmetic_gesture");
		var_00 = undefined;
		if(scripts\mp\_utility::func_766C("prematch_done") && getdvarint("scr_test_rps",0) == 0)
		{
			self [[ level.showerrormessagefunc ]]("MP_INGAME_ONLY_RPS_TOO_LATE");
			var_00 = 0;
		}
		else
		{
			self [[ level.showerrormessagefunc ]]("MP_INGAME_ONLY_RPS_START");
			var_00 = 1;
		}

		self waittill("offhand_fired");
		if(var_00)
		{
			thread gesture_playrockpaperscissors();
		}

		self waittill("offhand_end");
		thread gesture_resetrockpaperscissorsgesture();
	}
}

//Function Number: 9
gesture_resetrockpaperscissorsgesture()
{
	func_41B2();
	func_8368("ges_plyr_gesture043");
}

//Function Number: 10
gesture_playrockpaperscissors()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	self endon("rockPaperScissorsFinished");
	self notify("gesture_playRockPaperScissors()");
	self endon("gesture_playRockPaperScissors()");
	var_00 = gesture_getrockpaperscissorsplayers();
	if(isdefined(var_00))
	{
		var_01 = gesture_determinerockpaperscissorswinner(self,self.var_77C2,var_00,var_00.rockpaperscissorschoice);
		if(isdefined(var_01))
		{
			var_01 [[ level.showerrormessagefunc ]]("MP_INGAME_ONLY_RPS_WIN");
			var_01 thread [[ level.givemidmatchawardfunc ]]("rock_paper_scissors_win");
			var_02 = scripts\common\utility::func_116D7(var_01 == self,var_00,self);
			var_02 [[ level.showerrormessagefunc ]]("MP_INGAME_ONLY_RPS_LOSE");
		}
		else
		{
			self [[ level.showerrormessagefunc ]]("MP_INGAME_ONLY_RPS_DRAW");
			var_00 [[ level.showerrormessagefunc ]]("MP_INGAME_ONLY_RPS_DRAW");
		}

		var_00 notify("rockPaperScissorsFinished");
		var_00.rockpaperscissorschoice = undefined;
		return;
	}

	self.rockpaperscissorschoice = self.var_77C2;
	wait(3);
	self.rockpaperscissorschoice = undefined;
}

//Function Number: 11
gesture_getrockpaperscissorsplayers()
{
	var_00 = anglestoforward(self getplayerangles());
	foreach(var_02 in level.players)
	{
		if(!isdefined(var_02) || var_02 == self)
		{
			continue;
		}

		if(!isdefined(var_02.rockpaperscissorschoice))
		{
			continue;
		}

		var_03 = var_02.origin - self.origin;
		var_03 = vectornormalize(var_03);
		var_04 = vectordot(var_03,var_00);
		if(var_04 < 0.7071068)
		{
			continue;
		}

		var_05 = anglestoforward(var_02 getplayerangles());
		var_06 = var_03 * -1;
		var_07 = vectordot(var_06,var_05);
		if(var_07 < 0.7071068)
		{
			continue;
		}

		return var_02;
	}
}

//Function Number: 12
gesture_determinerockpaperscissorswinner(param_00,param_01,param_02,param_03)
{
	if(param_01 == param_03)
	{
		return undefined;
	}

	switch(param_01)
	{
		case "ges_plyr_gesture043":
			return scripts\common\utility::func_116D7(param_03 == "ges_plyr_gesture114",param_02,param_00);

		case "ges_plyr_gesture114":
			return scripts\common\utility::func_116D7(param_03 == "ges_plyr_gesture115",param_02,param_00);

		case "ges_plyr_gesture115":
			return scripts\common\utility::func_116D7(param_03 == "ges_plyr_gesture043",param_02,param_00);
	}
}

//Function Number: 13
gesture_coinflipthink(param_00)
{
	self endon("clearGesture");
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	self notify("gesture_coinFlipThink()");
	self endon("gesture_coinFlipThink()");
	for(;;)
	{
		self waittill("used_cosmetic_gesture");
		for(;;)
		{
			if(!self isgestureplaying(param_00))
			{
				break;
			}

			scripts\common\utility::func_136F7();
		}

		thread gesture_resetcoinflipgesture();
	}
}

//Function Number: 14
gesture_resetcoinflipgesture()
{
	func_41B2();
	func_8368("ges_plyr_gesture050");
}

//Function Number: 15
getbodymodel()
{
	if(!isplayer(self) || isai(self))
	{
		return undefined;
	}

	var_00 = undefined;
	if(level.rankedmatch)
	{
		var_00 = self getplayerdata("rankedloadouts","squadMembers","body");
	}
	else
	{
		var_00 = self getplayerdata("privateloadouts","squadMembers","body");
	}

	return tablelookupbyrow("mp/cac/bodies.csv",var_00,1);
}

//Function Number: 16
func_8BDB()
{
	if(isdefined(self.var_3C56))
	{
		if(!isdefined(self.var_A93D))
		{
			return 1;
		}

		if(self.var_3C56 != self.var_A93D)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 17
gestureaudioduringcountdown()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	while(!scripts\mp\_utility::func_766C("prematch_done"))
	{
		self waittill("offhand_pullback",var_00);
		if(self.var_77C2 == var_00)
		{
			self playsoundtoteam("gib_fullbody",self.team,self);
		}
	}
}