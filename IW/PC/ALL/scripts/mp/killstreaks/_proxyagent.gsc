/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\killstreaks\_proxyagent.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 15
 * Decompile Time: 792 ms
 * Timestamp: 10/27/2023 12:29:21 AM
*******************************************************************/

//Function Number: 1
func_45D0(param_00,param_01,param_02,param_03,param_04,param_05)
{
	self.var_DAD6 = undefined;
	if(param_03 < 3)
	{
		scripts\mp\_hud_message::func_10122("KILLSTREAKS_SCORESTREAK_ENDING");
		return 0;
	}

	var_06 = scripts\mp\killstreaks\_killstreaks::func_D507(param_01,1);
	if(!var_06)
	{
		return 0;
	}

	thread func_13B05(param_02);
	thread watchgameend();
	if(!isdefined(param_04) || !param_04)
	{
		thread func_13B03(param_02);
	}

	if(isalive(param_00) && !scripts\mp\_utility::func_9FB3(param_00.var_5F6F))
	{
		func_10D7E(param_00,param_01.var_110EA,param_02,param_05);
	}
	else
	{
		self notify(param_02);
		return 0;
	}

	return 1;
}

//Function Number: 2
func_13B01(param_00,param_01)
{
	self endon("disconnect");
	self endon(param_00);
	for(;;)
	{
		self waittill("player_killstreak_death",var_02,var_03,var_04,var_05,var_06,var_07);
		if(var_03 != self && isplayer(var_03))
		{
			var_03 notify("destroyed_killstreak",var_07);
			var_03 scripts\mp\_utility::func_83B4("destroyed_" + param_01);
			thread scripts\mp\_utility::func_115DE("callout_destroyed_" + param_01,var_03);
			thread scripts\mp\_missions::func_A6A3(param_01,self,self,undefined,var_03,var_04,var_06,var_07,"destroyed_" + param_01);
			thread scripts\mp\_utility::func_AAEC(param_01 + "_destroyed",undefined,undefined,self.origin);
		}

		self notify(param_00,1);
	}
}

//Function Number: 3
func_13B02(param_00)
{
	self endon(param_00);
	self waittill("disconnect");
	self notify(param_00,1);
}

//Function Number: 4
func_13B06(param_00)
{
	self endon(param_00);
	self waittill("joined_team");
	self notify(param_00,1);
}

//Function Number: 5
func_13B03(param_00)
{
	self endon("disconnect");
	self endon(param_00);
	for(;;)
	{
		var_01 = 0;
		while(self usebuttonpressed())
		{
			var_01 = var_01 + 0.05;
			if(var_01 > 0.75)
			{
				self.var_D3CB = self.origin;
				self notify(param_00);
				return;
			}

			wait(0.05);
		}

		wait(0.05);
	}
}

//Function Number: 6
func_13B07(param_00,param_01)
{
	self endon("disconnect");
	self endon(param_00);
	wait(param_01);
	self notify(param_00,1);
}

//Function Number: 7
func_13B04(param_00)
{
	self endon("disconnect");
	self endon(param_00);
	self waittill("emp_damage",var_01,var_02);
}

//Function Number: 8
func_13B05(param_00)
{
	scripts\common\utility::waittill_any_3(param_00,"level_game_ended");
	func_11066();
}

//Function Number: 9
watchgameend()
{
	level waittill("game_ended");
	self notify("level_game_ended");
}

//Function Number: 10
func_10D7E(param_00,param_01,param_02,param_03)
{
	if(isdefined(self) && isalive(param_00))
	{
		self method_84E2(param_00);
		if(isdefined(param_03))
		{
			self visionsetnakedforplayer(param_03,0);
		}

		self.var_D3E7 = param_00;
	}
}

//Function Number: 11
func_8077(param_00)
{
	var_01 = 0;
	switch(param_00)
	{
		case "spiderbot":
			var_01 = 0.45;
			break;

		case "remote_c8":
			var_01 = -0.2;
			break;
	}

	return var_01;
}

//Function Number: 12
func_11066()
{
	if(isdefined(self))
	{
		if(scripts\mp\_utility::func_9D92())
		{
			self method_84E3();
			self visionsetnakedforplayer("",0);
		}

		thread scripts\mp\killstreaks\_killstreaks::func_11086(1);
		self.var_D3E7 = undefined;
		self.var_165A = undefined;
	}
}

//Function Number: 13
func_4198(param_00)
{
	lib_0D69::func_E0D0(param_00.var_AE62);
	scripts\mp\perks\_perks::func_11AA();
}

//Function Number: 14
func_DDA3(param_00)
{
	var_01 = undefined;
	switch(param_00.var_AE62)
	{
		case "archetype_assault":
			var_01 = ::lib_0D68::func_20BB;
			break;

		case "archetype_heavy":
			var_01 = ::lib_0D6C::func_20BB;
			break;

		case "archetype_scout":
			var_01 = ::lib_0D6F::func_20BB;
			break;

		case "archetype_assassin":
			var_01 = ::lib_0D67::func_20BB;
			break;

		case "archetype_engineer":
			var_01 = ::lib_0D6B::func_20BB;
			break;

		case "archetype_sniper":
			var_01 = ::lib_0D70::func_20BB;
			break;
	}

	scripts\mp\_class::func_AE58(param_00);
	if(isdefined(var_01))
	{
		self [[ var_01 ]]();
	}
}

//Function Number: 15
func_A670(param_00)
{
}