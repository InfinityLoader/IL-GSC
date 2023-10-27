/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\_gameobjects.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 113
 * Decompile Time: 4527 ms
 * Timestamp: 10/27/2023 12:20:27 AM
*******************************************************************/

//Function Number: 1
main(param_00)
{
	param_00[param_00.size] = "airdrop_pallet";
	var_01 = getentarray();
	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		if(isdefined(var_01[var_02].var_EDBF))
		{
			var_03 = 1;
			var_04 = strtok(var_01[var_02].var_EDBF," ");
			for(var_05 = 0;var_05 < param_00.size;var_05++)
			{
				for(var_06 = 0;var_06 < var_04.size;var_06++)
				{
					if(var_04[var_06] == param_00[var_05])
					{
						var_03 = 0;
						break;
					}
				}

				if(!var_03)
				{
					break;
				}
			}

			if(var_03)
			{
				var_01[var_02] delete();
			}
		}
	}
}

//Function Number: 2
init()
{
	level.var_C22E = 0;
	level thread func_C56E();
	level thread getleveltriggers();
}

//Function Number: 3
func_C56E()
{
	level endon("game_ended");
	for(;;)
	{
		level waittill("connected",var_00);
		if(isbot(var_00))
		{
			level.botsenabled = 1;
		}

		var_00 thread func_C57B();
		var_00 thread func_C4F5();
	}
}

//Function Number: 4
func_C57B()
{
	self endon("disconnect");
	level endon("game_ended");
	for(;;)
	{
		self waittill("spawned_player");
		if(isdefined(self.var_767C))
		{
			self.var_767C = undefined;
			continue;
		}

		func_96DF();
	}
}

//Function Number: 5
func_96DF()
{
	thread func_C4EA();
	self.var_11A46 = [];
	self.var_3AF7 = undefined;
	self.var_3FFA = undefined;
	self.var_38ED = 1;
	self.var_A64F = undefined;
	self.var_987A = 1;
}

//Function Number: 6
func_C4EA()
{
	level endon("game_ended");
	self waittill("death");
	if(isdefined(self.var_3AF7))
	{
		self.var_3AF7 thread func_F6D8();
	}
}

//Function Number: 7
func_C4F5()
{
	level endon("game_ended");
	self waittill("disconnect");
	if(isdefined(self.var_3AF7))
	{
		self.var_3AF7 thread func_F6D8();
	}
}

//Function Number: 8
func_4A29(param_00,param_01)
{
	var_02 = spawn("script_model",self.origin);
	var_02 setmodel("tag_origin");
	var_03 = spawnstruct();
	var_03.type = "carryObject";
	var_03.carrier = param_00;
	var_03.var_4B2C = param_00.origin;
	var_03.var_664A = var_02 getentitynumber();
	var_03.ownerteam = param_00.team;
	var_03.var_4465 = [];
	var_03.var_C2BE = 0;
	var_03.var_C2BD = 0;
	var_03.var_13DCA = [];
	var_03.var_3AF1 = 0;
	var_03.visibleteam = "none";
	foreach(var_05 in level.teamnamelist)
	{
		var_03.var_115DC[var_05] = scripts\mp\objidpoolmanager::requestminimapid(99);
		if(var_03.var_115DC[var_05] != -1)
		{
			scripts\mp\objidpoolmanager::minimap_objective_add(var_03.var_115DC[var_05],"invisible",var_03.var_4B2C);
			scripts\mp\objidpoolmanager::minimap_objective_team(var_03.var_115DC[var_05],var_05);
		}

		var_03.var_C2C2[var_05] = scripts\mp\_objpoints::func_4A23("objpoint_" + var_05 + "_" + var_03.var_664A,var_03.var_4B2C + param_01,var_05,undefined);
		var_03.var_C2C2[var_05].alpha = 0;
		if(getdvarint("com_codcasterEnabled",0) == 1)
		{
			var_06 = "mlg_" + var_05;
			var_03.var_C2C2[var_06] = scripts\mp\_objpoints::func_4A23("objpoint_" + var_06 + "_" + var_03.var_664A,var_03.var_4B2C + param_01,var_05,undefined);
			var_03.var_C2C2[var_06].alpha = 0;
		}
	}

	var_03 thread func_12E6F();
	var_03 thread func_51D8();
	return var_03;
}

//Function Number: 9
func_51D8()
{
	self.carrier waittill("disconnect");
	if(self.type != "carryObject")
	{
		return;
	}

	var_00 = self;
	var_00.type = undefined;
	var_00.carrier = undefined;
	var_00.var_4B2C = undefined;
	var_00.var_664A = undefined;
	var_00.ownerteam = undefined;
	var_00.var_4465 = undefined;
	var_00.var_C2BE = undefined;
	var_00.var_C2BD = undefined;
	var_00.var_13DCA = undefined;
	var_00.var_3AF1 = undefined;
	var_00.visibleteam = undefined;
	foreach(var_02 in level.teamnamelist)
	{
		scripts\mp\objidpoolmanager::returnminimapid(var_00.var_115DC[var_02]);
		scripts\mp\_objpoints::func_51BC(var_00.var_C2C2[var_02]);
		if(getdvarint("com_codcasterEnabled",0) == 1)
		{
			var_03 = "mlg_" + var_02;
			scripts\mp\_objpoints::func_51BC(var_00.var_C2C2[var_03]);
		}
	}
}

//Function Number: 10
func_4993(param_00,param_01,param_02,param_03)
{
	var_04 = spawnstruct();
	var_04.type = "carryObject";
	var_04.var_4B2C = param_01.origin;
	var_04.ownerteam = param_00;
	var_04.var_664A = param_01 getentitynumber();
	if(issubstr(param_01.classname,"use"))
	{
		var_04.triggertype = "use";
	}
	else
	{
		var_04.triggertype = "proximity";
	}

	param_01.var_28AC = param_01.origin;
	var_04.trigger = param_01;
	if(!isdefined(param_01.var_AD48))
	{
		param_01.var_AD48 = 1;
		param_01 enablelinkto();
	}

	var_04.var_130F8 = undefined;
	if(!isdefined(param_03))
	{
		param_03 = (0,0,0);
	}

	var_04.var_C363 = param_03;
	for(var_05 = 0;var_05 < param_02.size;var_05++)
	{
		param_02[var_05].var_28AC = param_02[var_05].origin;
		param_02[var_05].var_2898 = param_02[var_05].angles;
	}

	var_04.visuals = param_02;
	var_04.var_4465 = [];
	var_04.var_C2BE = 0;
	var_04.var_C2BD = 0;
	foreach(var_07 in level.teamnamelist)
	{
		var_04.var_115DC[var_07] = scripts\mp\objidpoolmanager::requestminimapid(99);
		if(var_04.var_115DC[var_07] != -1)
		{
			scripts\mp\objidpoolmanager::minimap_objective_add(var_04.var_115DC[var_07],"invisible",var_04.var_4B2C);
			scripts\mp\objidpoolmanager::minimap_objective_team(var_04.var_115DC[var_07],var_07);
		}

		var_04.var_C2C2[var_07] = scripts\mp\_objpoints::func_4A23("objpoint_" + var_07 + "_" + var_04.var_664A,var_04.var_4B2C + param_03,var_07,undefined);
		var_04.var_C2C2[var_07].alpha = 0;
		if(getdvarint("com_codcasterEnabled",0) == 1)
		{
			var_08 = "mlg_" + var_07;
			var_04.var_C2C2[var_08] = scripts\mp\_objpoints::func_4A23("objpoint_" + var_08 + "_" + var_04.var_664A,var_04.var_4B2C + param_03,var_07,undefined);
			var_04.var_C2C2[var_08].alpha = 0;
		}
	}

	var_04.carrier = undefined;
	var_04.var_9F24 = 0;
	var_04.interactteam = "none";
	var_04.var_1CB3 = 0;
	var_04.var_13DCA = [];
	var_04.var_3AF1 = 0;
	var_04.visibleteam = "none";
	var_04.var_3AF5 = undefined;
	var_04.var_C4F9 = undefined;
	var_04.var_C566 = undefined;
	var_04.var_C581 = undefined;
	if(var_04.triggertype == "use")
	{
		var_04 thread func_3AFC();
	}
	else
	{
		var_04.var_4B30 = 0;
		var_04.var_115DF = [];
		var_04.var_115DF["none"] = 0;
		var_04.var_115DF["allies"] = 0;
		var_04.var_115DF["axis"] = 0;
		var_04.var_130EE = 0;
		var_04.userate = 0;
		var_04.mustmaintainclaim = 0;
		var_04.cancontestclaim = 0;
		var_04.var_115F2 = [];
		var_04.var_115F1 = [];
		var_04.numtouching["neutral"] = 0;
		var_04.touchlist["neutral"] = [];
		var_04.numtouching["none"] = 0;
		var_04.touchlist["none"] = [];
		foreach(var_0B in level.teamnamelist)
		{
			var_04.numtouching[var_0B] = 0;
			var_04.touchlist[var_0B] = [];
		}

		var_04.claimteam = "none";
		var_04.claimplayer = undefined;
		var_04.lastclaimteam = "none";
		var_04.lastclaimtime = 0;
		var_04 thread func_3AF9();
	}

	var_04 thread func_12E6F();
	return var_04;
}

//Function Number: 11
func_51A9()
{
	if(self.type != "carryObject")
	{
		return;
	}

	var_00 = self;
	var_00.type = undefined;
	var_00.var_4B2C = undefined;
	var_00.ownerteam = undefined;
	var_00.var_664A = undefined;
	var_00.triggertype = undefined;
	var_00.trigger unlink();
	var_00.trigger = undefined;
	var_00.var_130F8 = undefined;
	var_00.var_C363 = undefined;
	foreach(var_02 in var_00.visuals)
	{
		var_02 delete();
	}

	var_00.visuals = undefined;
	var_00.var_4465 = undefined;
	var_00.var_C2BE = undefined;
	var_00.var_C2BD = undefined;
	var_00.var_C2BF = undefined;
	scripts\mp\_objpoints::func_51BC(var_00.var_C2C2["allies"]);
	scripts\mp\_objpoints::func_51BC(var_00.var_C2C2["axis"]);
	foreach(var_05 in level.teamnamelist)
	{
		scripts\mp\objidpoolmanager::returnminimapid(var_00.var_115DC[var_05]);
		scripts\mp\_objpoints::func_51BC(var_00.var_C2C2[var_05]);
		if(getdvarint("com_codcasterEnabled",0) == 1)
		{
			var_06 = "mlg_" + var_05;
			scripts\mp\_objpoints::func_51BC(var_00.var_C2C2[var_06]);
		}
	}

	var_00.var_C2C2 = undefined;
	var_00.carrier = undefined;
	var_00.var_9F24 = undefined;
	var_00.interactteam = undefined;
	var_00.var_1CB3 = undefined;
	var_00.var_A57D = undefined;
	var_00.var_13DCA = undefined;
	var_00.var_3AF1 = undefined;
	var_00.visibleteam = undefined;
	var_00.var_3AF5 = undefined;
	var_00.var_C4F9 = undefined;
	var_00.var_C566 = undefined;
	var_00.var_C581 = undefined;
	var_00.var_4B30 = undefined;
	var_00.var_130EE = undefined;
	var_00.userate = undefined;
	var_00.mustmaintainclaim = undefined;
	var_00.cancontestclaim = undefined;
	var_00.var_115F2 = undefined;
	var_00.var_115F1 = undefined;
	var_00.numtouching = undefined;
	var_00.touchlist = undefined;
	var_00.claimteam = undefined;
	var_00.claimplayer = undefined;
	var_00.lastclaimteam = undefined;
	var_00.lastclaimtime = undefined;
	var_00 notify("death");
	var_00 notify("deleted");
}

//Function Number: 12
func_3AFC()
{
	level endon("game_ended");
	for(;;)
	{
		self.trigger waittill("trigger",var_00);
		if(scripts\mp\_utility::func_9F22(var_00))
		{
			continue;
		}

		if(!isplayer(var_00))
		{
			continue;
		}

		if(var_00 method_84CA())
		{
			continue;
		}

		if(var_00 getcurrentweapon() == "ks_remote_map_mp")
		{
			continue;
		}

		if(var_00 getcurrentweapon() == "ks_remote_device_mp")
		{
			continue;
		}

		if(var_00 scripts\mp\_utility::func_9D47())
		{
			var_01 = var_00 scripts\mp\_utility::func_7E4D();
			if(var_01 == "ks_remote_map_mp" || var_01 == "ks_remote_device_mp")
			{
				continue;
			}
		}

		if(scripts\mp\_utility::func_9FB3(var_00.var_13107))
		{
			continue;
		}

		if(!func_DAD1(var_00))
		{
			continue;
		}

		if(self.var_9F24)
		{
			continue;
		}

		if(!scripts\mp\_utility::func_9F19(var_00))
		{
			continue;
		}

		if(!caninteractwith(var_00.pers["team"]))
		{
			continue;
		}

		if(!var_00.var_38ED)
		{
			continue;
		}

		if(isdefined(var_00.var_C087) && var_00.var_C087 > gettime())
		{
			continue;
		}

		if(!isdefined(var_00.var_987A))
		{
			continue;
		}

		if(var_00 scripts\mp\_utility::func_85C7())
		{
			var_02 = var_00 method_854D();
			if(!scripts\mp\_utility::isgesture(var_02))
			{
				continue;
			}
		}

		if(isdefined(self.carrier))
		{
			continue;
		}

		if(var_00 scripts\mp\_utility::func_9FC6())
		{
			continue;
		}

		func_F7E8(var_00);
	}
}

//Function Number: 13
func_3AF9()
{
	if(level.gametype == "ball" || level.gametype == "tdef")
	{
		thread func_3AFC();
		return;
	}

	thread func_3AFA();
}

//Function Number: 14
func_3AFA()
{
	level endon("game_ended");
	if(isdefined(self.trigger))
	{
		self.trigger endon("move_gameobject");
	}

	thread func_DAD2();
	for(;;)
	{
		if(self.var_130EE && self.var_115DF[self.claimteam] >= self.var_130EE)
		{
			self.var_4B30 = 0;
			self.var_115DF[self.claimteam] = self.var_4B30;
			var_00 = func_7E8B();
			if(isdefined(self.var_C50D))
			{
				self [[ self.var_C50D ]](func_7E29(),var_00,isdefined(var_00));
			}

			if(isdefined(var_00))
			{
				func_F7E8(var_00);
			}

			func_F690("none");
			self.claimplayer = undefined;
		}

		if(self.claimteam != "none")
		{
			if(self.var_130EE)
			{
				if(!self.numtouching[self.claimteam])
				{
					if(isdefined(self.var_C50D))
					{
						self [[ self.var_C50D ]](func_7E29(),self.claimplayer,0);
					}

					func_F690("none");
					self.claimplayer = undefined;
				}
				else
				{
					self.var_4B30 = self.var_4B30 + 50 * self.userate;
					self.var_115DF[self.claimteam] = self.var_4B30;
					if(self.ownerteam != level.var_C74B[self.claimteam])
					{
						self.var_115DF[level.var_C74B[self.claimteam]] = 0;
					}

					if(isdefined(self.var_C5C8))
					{
						self [[ self.var_C5C8 ]](func_7E29(),self.var_4B30 / self.var_130EE,50 * self.userate / self.var_130EE,self.claimplayer);
					}
				}
			}
			else
			{
				if(scripts\mp\_utility::func_9F19(self.claimplayer))
				{
					func_F7E8(self.claimplayer);
				}

				func_F690("none");
				self.claimplayer = undefined;
			}
		}

		wait(0.05);
		scripts\mp\_hostmigration::func_13834();
	}
}

//Function Number: 15
func_CB44(param_00)
{
	level endon("game_ended");
	self endon("death");
	self endon("disconnect");
	self.var_38ED = 0;
	if(isdefined(param_00.var_27F4))
	{
		var_01 = 1024;
	}
	else
	{
		var_01 = 4096;
	}

	for(;;)
	{
		if(distancesquared(self.origin,param_00.trigger.origin) > var_01)
		{
			break;
		}

		wait(0.2);
	}

	if(!lib_0DF8::func_9DDF(self))
	{
		self.var_38ED = 1;
	}
}

//Function Number: 16
func_F7E8(param_00)
{
	if(isai(param_00) && isdefined(param_00.var_222))
	{
		return;
	}

	if(isdefined(param_00.var_3AF7) || isdefined(self.var_3B01) && !param_00 scripts\common\utility::func_9FFD())
	{
		if(isdefined(self.var_C567))
		{
			self [[ self.var_C567 ]](param_00);
		}

		return;
	}

	param_00 func_8382(self);
	func_F67F(param_00);
	if(isdefined(self.trigger getlinkedparent()))
	{
		for(var_01 = 0;var_01 < self.visuals.size;var_01++)
		{
			self.visuals[var_01] unlink();
		}

		self.trigger unlink();
	}

	for(var_01 = 0;var_01 < self.visuals.size;var_01++)
	{
		self.visuals[var_01] hide();
	}

	self.trigger.origin = self.trigger.origin + (0,0,10000);
	self.trigger scripts\mp\_movers::func_11001();
	self notify("pickup_object");
	if(isdefined(self.var_C566))
	{
		self [[ self.var_C566 ]](param_00);
	}

	updatecompassicons();
	updateworldicons();
}

//Function Number: 17
func_12E83()
{
	level endon("game_ended");
	if(isdefined(self.trigger))
	{
		self.trigger endon("move_gameobject");
	}

	if(level.gametype == "front")
	{
		self.carrier endon("disconnect");
	}

	for(;;)
	{
		if(isdefined(self.carrier))
		{
			self.var_4B2C = self.carrier.origin + (0,0,75);
		}
		else
		{
			self.var_4B2C = self.trigger.origin;
		}

		wait(0.05);
	}
}

//Function Number: 18
func_12E6F()
{
	level endon("game_ended");
	if(isdefined(self.trigger))
	{
		self.trigger endon("move_gameobject");
	}

	if(level.gametype == "front")
	{
		self.carrier endon("disconnect");
	}

	thread func_12E83();
	if(!isdefined(self.var_C2BF))
	{
		self.var_C2BF = 4;
	}

	for(;;)
	{
		if(isdefined(self.carrier))
		{
			if(getdvarint("com_codcasterEnabled",0) == 1)
			{
				if(isdefined(self.var_C2C2["mlg_allies"]))
				{
					self.var_C2C2["mlg_allies"] scripts\mp\_objpoints::func_12EE3(self.var_4B2C);
				}

				if(isdefined(self.var_C2C2["mlg_axis"]))
				{
					self.var_C2C2["mlg_axis"] scripts\mp\_objpoints::func_12EE3(self.var_4B2C);
				}
			}

			foreach(var_01 in level.teamnamelist)
			{
				self.var_C2C2[var_01] scripts\mp\_objpoints::func_12EE3(self.var_4B2C);
			}

			foreach(var_01 in level.teamnamelist)
			{
				if((self.visibleteam == "friendly" || self.visibleteam == "any") && isfriendlyteam(var_01) && self.var_C2BE)
				{
					if(self.var_C2C2[var_01].var_9F51)
					{
						self.var_C2C2[var_01].alpha = self.var_C2C2[var_01].var_2897;
						self.var_C2C2[var_01] fadeovertime(self.var_C2BF);
						self.var_C2C2[var_01].alpha = 0;
					}

					if(self.var_115DC[var_01] != -1)
					{
						scripts\mp\objidpoolmanager::minimap_objective_position(self.var_115DC[var_01],self.var_4B2C);
					}
				}
			}

			foreach(var_01 in level.teamnamelist)
			{
				if((self.visibleteam == "enemy" || self.visibleteam == "any") && !isfriendlyteam(var_01) && self.var_C2BD)
				{
					if(self.var_C2C2[var_01].var_9F51)
					{
						self.var_C2C2[var_01].alpha = self.var_C2C2[var_01].var_2897;
						self.var_C2C2[var_01] fadeovertime(self.var_C2BF);
						self.var_C2C2[var_01].alpha = 0;
					}

					if(self.var_115DC[var_01] != -1)
					{
						scripts\mp\objidpoolmanager::minimap_objective_position(self.var_115DC[var_01],self.var_4B2C);
					}
				}
			}

			scripts\mp\_utility::wait_endon(self.var_C2BF,"dropped","reset");
			continue;
		}

		foreach(var_01 in level.teamnamelist)
		{
			self.var_C2C2[var_01] scripts\mp\_objpoints::func_12EE3(self.var_4B2C + self.var_C363);
		}

		wait(0.05);
	}
}

//Function Number: 19
func_8EBA()
{
	self endon("disconnect");
	self endon("death");
	self endon("drop_object");
	level waittill("game_ended");
	if(isdefined(self.var_3AF5))
	{
		self.var_3AF5.alpha = 0;
	}
}

//Function Number: 20
func_767E()
{
	var_00 = self getcurrentweapon();
	var_01 = self getcurrentprimaryweapon();
	if("alt_" + var_01 == var_00)
	{
		return var_00;
	}

	return var_01;
}

//Function Number: 21
func_139CC(param_00)
{
	self endon("goal_scored");
	var_01 = gettime();
	var_02 = scripts\mp\_utility::func_11383(param_00,1);
	if(isdefined(var_02))
	{
		if(var_02 == 0)
		{
			if(var_01 == gettime())
			{
				waittillframeend;
			}

			if(isdefined(self.var_3AF7))
			{
				self.var_3AF7 thread func_F6D8();
				return;
			}
		}
	}
}

//Function Number: 22
func_8382(param_00)
{
	self.var_3AF7 = param_00;
	thread func_11ACC();
	if(isdefined(param_00.var_3B01))
	{
		param_00.var_3AF2 = func_767E();
		param_00.var_3AF0 = self hasweapon(param_00.var_3B01);
		if(isdefined(param_00.var_3B02))
		{
			self thread [[ param_00.var_3B02 ]]();
		}

		self giveweapon(param_00.var_3B01);
		thread func_139CC(param_00.var_3B01);
		self disableweaponpickup();
		scripts\common\utility::func_1C76(0);
	}
	else if(!param_00.var_1CB3)
	{
		scripts\common\utility::allow_weapon(0);
		thread func_B31B();
	}

	if(isdefined(param_00.var_3AF5))
	{
		if(level.splitscreen)
		{
			self.var_3AF5 = scripts\mp\_hud_util::createicon(param_00.var_3AF5,33,33);
			self.var_3AF5 scripts\mp\_hud_util::setpoint("BOTTOM LEFT","BOTTOM LEFT",-50,-78);
		}
		else
		{
			self.var_3AF5 = scripts\mp\_hud_util::createicon(param_00.var_3AF5,50,50);
			self.var_3AF5 scripts\mp\_hud_util::setpoint("BOTTOM LEFT","BOTTOM LEFT",175,-30);
		}

		self.var_3AF5.hidewheninmenu = 1;
		thread func_8EBA();
	}
}

//Function Number: 23
func_E472()
{
	self.var_9F24 = 1;
	self notify("reset");
	for(var_00 = 0;var_00 < self.visuals.size;var_00++)
	{
		var_01 = self.visuals[var_00] getlinkedparent();
		if(isdefined(var_01))
		{
			self.visuals[var_00] unlink();
		}

		if(isbombmode() && self.visuals[var_00].var_336 == "sd_bomb")
		{
			self.visuals[var_00].origin = level.var_2C61;
			self.visuals[var_00].angles = level.var_2C60;
		}
		else
		{
			self.visuals[var_00].origin = self.visuals[var_00].var_28AC;
			self.visuals[var_00].angles = self.visuals[var_00].var_2898;
		}

		self.visuals[var_00] show();
	}

	var_01 = self.trigger getlinkedparent();
	if(isdefined(var_01))
	{
		self.trigger unlink();
	}

	self.trigger.origin = self.trigger.var_28AC;
	self.var_4B2C = self.trigger.origin;
	if(isdefined(self.var_C581))
	{
		self [[ self.var_C581 ]]();
	}

	func_41A0();
	updateworldicons();
	updatecompassicons();
	self.var_9F24 = 0;
	self notify("reset_done");
}

//Function Number: 24
func_9E35()
{
	if(isdefined(self.carrier))
	{
		return 0;
	}

	if(self.var_4B2C != self.trigger.var_28AC)
	{
		return 0;
	}

	return 1;
}

//Function Number: 25
func_F806(param_00,param_01)
{
	self.var_9F24 = 1;
	for(var_02 = 0;var_02 < self.visuals.size;var_02++)
	{
		self.visuals[var_02].origin = param_00;
		self.visuals[var_02].angles = param_01;
		self.visuals[var_02] show();
	}

	self.trigger.origin = param_00;
	if(level.gametype == "ball" || level.gametype == "tdef")
	{
		self.trigger linkto(self.visuals[0]);
	}

	self.var_4B2C = self.trigger.origin;
	func_41A0();
	updateworldicons();
	updatecompassicons();
	self.var_9F24 = 0;
}

//Function Number: 26
func_C578()
{
	if(isdefined(self.var_3AF7))
	{
		self.var_3AF7 thread func_F6D8();
	}
}

//Function Number: 27
func_3AF8(param_00)
{
	for(var_01 = 0;var_01 < param_00.var_3AF7.visuals.size;var_01++)
	{
		param_00.var_3AF7.visuals[var_01] unlink();
	}

	param_00.var_3AF7.trigger unlink();
	param_00.var_3AF7 thread func_F6D8(1);
}

//Function Number: 28
func_F6D8(param_00)
{
	if(isdefined(self.var_F6D8))
	{
		if([[ self.var_F6D8 ]]())
		{
			return;
		}
	}

	self.var_9F24 = 1;
	self.var_E25D = undefined;
	self notify("dropped");
	foreach(var_02 in self.visuals)
	{
		var_02.var_D887 = var_02 method_82C7(0);
	}

	if(isdefined(self.carrier))
	{
		var_04 = self.carrier.origin;
	}
	else
	{
		var_04 = self.var_4B2C;
	}

	if(scripts\mp\_utility::func_9FB3(level.botsenabled) || isdefined(self.ftldrop) || touchingdroptonavmeshtrigger(var_04) || level.var_B335 == "mp_junk" && level.gametype == "ctf" && !self.carrier touchingarbitraryuptrigger())
	{
		var_04 = getclosestpointonnavmesh(var_04);
		if(isdefined(self.ftldrop))
		{
			self.ftldrop = undefined;
		}
	}

	var_05 = 20;
	var_06 = 4000;
	var_07 = (0,0,0);
	if(self.carrier touchingarbitraryuptrigger())
	{
		var_08 = self.carrier getworldupreferenceangles();
		var_07 = anglestoup(var_08);
		if(var_07[2] < 0)
		{
			var_05 = -20;
			var_06 = -4000;
		}
	}

	var_09 = var_04 + (0,0,var_05);
	var_0A = var_04 - (0,0,var_06);
	var_0B = scripts\common\trace::func_48BC(0,1,1,0,0,1,1);
	var_0C = [];
	var_0C[0] = self.visuals[0];
	var_0C[1] = self.carrier;
	if(isdefined(self.carrier) && self.carrier.team != "spectator")
	{
		if(level.gametype != "ctf")
		{
			var_0D = scripts\common\trace::func_3A09(var_09,var_0A,8,16,(0,0,0),var_0C,var_0B,0);
		}
		else
		{
			var_0D = scripts\common\trace::func_3A09(var_0A,var_0B,2,4,(0,0,0),var_0D,var_0C,0);
		}
	}
	else
	{
		var_0D = scripts\common\trace::func_DCED(self.var_EA28 + (0,0,20),self.var_EA28 - (0,0,20),var_0D,var_0C,0);
		if(isplayer(var_0D["entity"]))
		{
			var_0D["entity"] = undefined;
		}
	}

	foreach(var_02 in self.visuals)
	{
		var_02 method_82C7(var_02.var_D887);
	}

	var_10 = self.carrier;
	var_11 = 0;
	if(isdefined(var_0D))
	{
		var_12 = randomfloat(360);
		var_13 = var_0D["position"];
		if(isdefined(self.var_1349F))
		{
			var_13 = var_13 + self.var_1349F;
		}

		var_14 = (cos(var_12),sin(var_12),0);
		var_14 = vectornormalize(var_14 - var_0D["normal"] * vectordot(var_14,var_0D["normal"]));
		var_15 = 0;
		if(level.gametype == "ctf" || isbombmode())
		{
			if(self.carrier touchingarbitraryuptrigger() && var_07[2] < 0)
			{
				var_16 = (0,0,-180);
				if(isdefined(self.var_1349F))
				{
					var_13 = var_13 - self.var_1349F * 2;
				}

				if(level.gametype == "ctf")
				{
					var_15 = -80;
				}

				if(isbombmode())
				{
					var_15 = -30;
				}
			}
			else
			{
				var_16 = (0,0,0);
			}
		}
		else
		{
			var_16 = vectortoangles(var_15);
		}

		for(var_17 = 0;var_17 < self.visuals.size;var_17++)
		{
			self.visuals[var_17].origin = var_13;
			self.visuals[var_17].angles = var_16;
			self.visuals[var_17] show();
		}

		self.trigger.origin = var_13 + (0,0,var_15);
		self.var_4B2C = self.trigger.origin;
		var_18 = undefined;
		if(!isplayer(var_0D["entity"]) || !isbot(var_0D["entity"]) || !isagent(var_0D["entity"]))
		{
			var_18 = var_0D["entity"];
		}

		if(isdefined(var_18) && isdefined(var_18.var_222))
		{
			var_19 = var_18 getlinkedparent();
			if(isdefined(var_19))
			{
				var_18 = var_19;
			}
		}

		if(isdefined(var_18))
		{
			if(isdefined(var_18.var_9B09) && var_18.var_9B09 == 1)
			{
				self.var_E25D = 1;
			}
			else
			{
				for(var_17 = 0;var_17 < self.visuals.size;var_17++)
				{
					self.visuals[var_17] linkto(var_18);
				}

				self.trigger linkto(var_18);
				var_1A = spawnstruct();
				var_1A.var_3AF7 = self;
				var_1A.var_4E53 = ::func_3AF8;
				self.trigger thread scripts\mp\_movers::func_892F(var_1A);
			}
		}

		if(!isdefined(param_00))
		{
			thread func_CB49();
		}
	}
	else
	{
		for(var_17 = 0;var_17 < self.visuals.size;var_17++)
		{
			self.visuals[var_17].origin = self.visuals[var_17].var_28AC;
			self.visuals[var_17].angles = self.visuals[var_17].var_2898;
			self.visuals[var_17] show();
		}

		self.trigger.origin = self.trigger.var_28AC;
		self.var_4B2C = self.trigger.var_28AC;
	}

	if(isdefined(self.var_C4F9) && !isdefined(param_00))
	{
		self [[ self.var_C4F9 ]](var_10);
	}

	func_41A0();
	updatecompassicons();
	updateworldicons();
	self.var_9F24 = 0;
}

//Function Number: 29
func_F67F(param_00)
{
	self.carrier = param_00;
	thread updatevisibilityaccordingtoradar();
}

//Function Number: 30
func_41A0()
{
	if(!isdefined(self.carrier))
	{
		return;
	}

	self.carrier thread func_11471(self);
	self.carrier = undefined;
	self notify("carrier_cleared");
}

//Function Number: 31
func_CB49()
{
	self endon("pickup_object");
	self endon("reset_done");
	wait(0.05);
	if(isdefined(self.var_E25D))
	{
		self.var_E25D = undefined;
		func_E472();
		return;
	}

	for(var_00 = 0;var_00 < level.radtriggers.size;var_00++)
	{
		if(!self.visuals[0] istouching(level.radtriggers[var_00]))
		{
			continue;
		}

		func_E472();
		return;
	}

	for(var_00 = 0;var_00 < level.minetriggers.size;var_00++)
	{
		if(!self.visuals[0] istouching(level.minetriggers[var_00]))
		{
			continue;
		}

		func_E472();
		return;
	}

	for(var_00 = 0;var_00 < level.hurttriggers.size;var_00++)
	{
		if(!self.visuals[0] istouching(level.hurttriggers[var_00]))
		{
			continue;
		}

		func_E472();
		return;
	}

	if(scripts\mp\_utility::func_9FB3(level.ballallowedtriggers.size))
	{
		self.allowedintrigger = 0;
		foreach(var_02 in level.ballallowedtriggers)
		{
			if(self.visuals[0] istouching(var_02))
			{
				self.allowedintrigger = 1;
				break;
			}
		}
	}

	foreach(var_02 in level.var_C7B3)
	{
		if(scripts\mp\_utility::func_9FB3(self.allowedintrigger))
		{
			break;
		}

		if(!self.visuals[0] istouching(var_02))
		{
			continue;
		}

		func_E472();
		return;
	}

	if(isdefined(self.var_2667))
	{
		wait(self.var_2667);
		if(!isdefined(self.carrier))
		{
			func_E472();
		}
	}
}

//Function Number: 32
func_11471(param_00)
{
	if(isdefined(self.var_3AF5))
	{
		self.var_3AF5 scripts\mp\_hud_util::destroyelem();
	}

	if(isdefined(self))
	{
		self.var_3AF7 = undefined;
	}

	self notify("drop_object");
	if(param_00.triggertype == "proximity")
	{
		thread func_CB44(param_00);
	}

	if(scripts\mp\_utility::func_9F19(self) && !param_00.var_1CB3)
	{
		if(isdefined(param_00.var_3B01))
		{
			var_01 = isdefined(param_00.var_A575) && param_00.var_A575;
			if(!param_00.var_3AF0 && !var_01)
			{
				if(isdefined(param_00.var_27F4))
				{
					wait(0.25);
				}

				self notify("clear_carrier");
				if(scripts\mp\_utility::func_9F20(param_00.var_3B01))
				{
					scripts\mp\_utility::func_1529(param_00.var_3B01);
				}
				else
				{
					scripts\mp\_utility::func_141E(param_00.var_3B01);
				}

				var_02 = param_00.var_A978;
				thread scripts\mp\_utility::func_72ED(var_02);
			}
			else
			{
			}

			self enableweaponpickup();
			scripts\common\utility::func_1C76(1);
			return;
		}

		if(!param_00.var_1CB3)
		{
			scripts\common\utility::allow_weapon(1);
			return;
		}
	}
}

//Function Number: 33
func_11ACC()
{
	level endon("game_ended");
	self endon("disconnect");
	self endon("death");
	self endon("drop_object");
	while(isdefined(self.var_3AF7) && scripts\mp\_utility::func_9F19(self))
	{
		if(self isonground())
		{
			var_00 = bullettrace(self.origin + (0,0,20),self.origin - (0,0,20),0,undefined);
			if(var_00["fraction"] < 1)
			{
				self.var_3AF7.var_EA28 = var_00["position"];
			}
		}

		wait(0.05);
	}
}

//Function Number: 34
func_B31B()
{
	level endon("game_ended");
	self endon("disconnect");
	self endon("death");
	self endon("drop_object");
	for(;;)
	{
		while(self attackbuttonpressed() || self fragbuttonpressed() || self secondaryoffhandbuttonpressed() || self meleebuttonpressed())
		{
			wait(0.05);
		}

		while((!self attackbuttonpressed() && !self fragbuttonpressed() && !self secondaryoffhandbuttonpressed()) || self meleebuttonpressed())
		{
			wait(0.05);
		}

		if(isdefined(self.var_3AF7) && !self usebuttonpressed())
		{
			self.var_3AF7 thread func_F6D8();
		}
	}
}

//Function Number: 35
func_51DA()
{
	foreach(var_01 in level.teamnamelist)
	{
		scripts\mp\objidpoolmanager::returnminimapid(self.var_115DC[var_01]);
		scripts\mp\_objpoints::func_51BC(self.var_C2C2[var_01]);
		if(getdvarint("com_codcasterEnabled",0) == 1)
		{
			var_02 = "mlg_" + var_01;
			scripts\mp\_objpoints::func_51BC(self.var_C2C2[var_02]);
		}
	}

	self.trigger delete();
	self.trigger = undefined;
	self notify("deleted");
}

//Function Number: 36
func_4A2E(param_00,param_01,param_02,param_03)
{
	var_04 = spawnstruct();
	var_04.type = "useObject";
	var_04.var_4B2C = param_01.origin;
	var_04.ownerteam = param_00;
	var_04.var_664A = param_01 getentitynumber();
	var_04.var_A5A0 = undefined;
	if(issubstr(param_01.classname,"use"))
	{
		var_04.triggertype = "use";
	}
	else
	{
		var_04.triggertype = "proximity";
	}

	var_04.trigger = param_01;
	for(var_05 = 0;var_05 < param_02.size;var_05++)
	{
		param_02[var_05].var_28AC = param_02[var_05].origin;
		param_02[var_05].var_2898 = param_02[var_05].angles;
	}

	var_04.visuals = param_02;
	if(!isdefined(param_03))
	{
		param_03 = (0,0,0);
	}

	var_04.var_C363 = param_03;
	var_04.var_4465 = [];
	foreach(var_07 in level.teamnamelist)
	{
		var_04.var_115DC[var_07] = scripts\mp\objidpoolmanager::requestminimapid(99);
		if(var_04.var_115DC[var_07] != -1)
		{
			scripts\mp\objidpoolmanager::minimap_objective_add(var_04.var_115DC[var_07],"invisible",var_04.var_4B2C);
			scripts\mp\objidpoolmanager::minimap_objective_team(var_04.var_115DC[var_07],var_07);
		}

		var_04.var_C2C2[var_07] = scripts\mp\_objpoints::func_4A23("objpoint_" + var_07 + "_" + var_04.var_664A,var_04.var_4B2C + param_03,var_07,undefined);
		var_04.var_C2C2[var_07].alpha = 0;
		if(getdvarint("com_codcasterEnabled",0) == 1)
		{
			var_08 = "mlg_" + var_07;
			var_04.var_C2C2[var_08] = scripts\mp\_objpoints::func_4A23("objpoint_" + var_08 + "_" + var_04.var_664A,var_04.var_4B2C + param_03,var_07,undefined);
			var_04.var_C2C2[var_08].alpha = 0;
		}
	}

	var_04.interactteam = "none";
	var_04.var_13DCA = [];
	var_04.visibleteam = "none";
	var_04.var_C5BB = undefined;
	var_04.var_C4D4 = undefined;
	var_04.var_130EB = "default";
	var_04.var_130EE = 10000;
	var_04.var_4B30 = 0;
	var_04.var_10B51 = 0;
	var_04.wasstalemate = 0;
	var_04.var_115DF = [];
	var_04.var_115DF["none"] = 0;
	var_04.var_115DF["allies"] = 0;
	var_04.var_115DF["axis"] = 0;
	if(var_04.triggertype == "proximity")
	{
		var_04.var_115F2 = [];
		var_04.var_115F1 = [];
		var_04.numtouching["neutral"] = 0;
		var_04.touchlist["neutral"] = [];
		var_04.numtouching["none"] = 0;
		var_04.touchlist["none"] = [];
		foreach(var_0B in level.teamnamelist)
		{
			var_04.numtouching[var_0B] = 0;
			var_04.touchlist[var_0B] = [];
		}

		var_04.userate = 0;
		var_04.claimteam = "none";
		var_04.claimplayer = undefined;
		var_04.lastclaimteam = "none";
		var_04.lastclaimtime = 0;
		var_04.mustmaintainclaim = 0;
		var_04.cancontestclaim = 0;
		var_04 thread func_130B0();
	}
	else
	{
		var_04.userate = 1;
		var_04 thread useobjectusethink();
	}

	return var_04;
}

//Function Number: 37
func_F76A(param_00)
{
	self.var_A5A0 = param_00;
}

//Function Number: 38
useobjectusethink()
{
	level endon("game_ended");
	self endon("deleted");
	for(;;)
	{
		self.trigger waittill("trigger",var_00);
		if(!scripts\mp\_utility::func_9F19(var_00))
		{
			continue;
		}

		if(!caninteractwith(var_00.pers["team"]))
		{
			continue;
		}

		if(!var_00 isonground())
		{
			continue;
		}

		if(!var_00 scripts\mp\_utility::func_9E59() && scripts\mp\_utility::func_9E6C(var_00 getcurrentweapon()))
		{
			continue;
		}

		if(isdefined(self.var_13056))
		{
			if(!self [[ self.var_13056 ]](var_00))
			{
				continue;
			}
		}

		if(isdefined(self.var_A5A0) && !isdefined(var_00.var_3AF7) || var_00.var_3AF7 != self.var_A5A0)
		{
			if(isdefined(self.var_C4D4))
			{
				self [[ self.var_C4D4 ]](var_00);
			}

			continue;
		}

		if(var_00 hasweapon(self.var_130F8))
		{
			continue;
		}

		if(!var_00 scripts\common\utility::func_9FFD())
		{
			continue;
		}

		var_01 = 1;
		if(self.var_130EE > 0)
		{
			if(isdefined(self.var_C4CB))
			{
				var_00 func_12F53(self,0);
				self [[ self.var_C4CB ]](var_00);
			}

			if(!isdefined(self.var_A5A0))
			{
				thread func_3930();
			}

			var_02 = var_00.pers["team"];
			var_01 = func_13093(var_00);
			self notify("finished_use");
			if(isdefined(self.var_C50D))
			{
				self [[ self.var_C50D ]](var_02,var_00,var_01);
			}
		}

		if(!var_01)
		{
			continue;
		}

		if(isdefined(self.var_C5BB))
		{
			self [[ self.var_C5BB ]](var_00);
		}
	}
}

//Function Number: 39
func_3E22(param_00)
{
	if(!isdefined(self.var_A5A0))
	{
		return 1;
	}

	if(!isdefined(param_00.var_3AF7))
	{
		return 0;
	}

	var_01 = self.var_A5A0;
	if(!isarray(var_01))
	{
		var_01 = [var_01];
	}

	foreach(var_03 in var_01)
	{
		if(var_03 == param_00.var_3AF7)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 40
func_3930()
{
	level endon("game_ended");
	self endon("deleted");
	self endon("finished_use");
	for(;;)
	{
		self.trigger waittill("trigger",var_00);
		if(!scripts\mp\_utility::func_9F19(var_00))
		{
			continue;
		}

		if(!caninteractwith(var_00.pers["team"]))
		{
			continue;
		}

		if(isdefined(self.var_C4D4))
		{
			self [[ self.var_C4D4 ]](var_00);
		}
	}
}

//Function Number: 41
func_7E8B()
{
	var_00 = self.claimteam;
	if(scripts\mp\_utility::func_9F19(self.claimplayer))
	{
		var_01 = self.claimplayer;
	}
	else
	{
		var_01 = undefined;
	}

	if(self.touchlist[var_00].size > 0)
	{
		var_02 = undefined;
		var_03 = getarraykeys(self.touchlist[var_00]);
		for(var_04 = 0;var_04 < var_03.size;var_04++)
		{
			var_05 = self.touchlist[var_00][var_03[var_04]];
			if(scripts\mp\_utility::func_9F19(var_05.player) && !isdefined(var_02) || var_05.var_10DFF < var_02)
			{
				var_01 = var_05.player;
				var_02 = var_05.var_10DFF;
			}
		}
	}

	return var_01;
}

//Function Number: 42
func_130B0()
{
	level endon("game_ended");
	self endon("deleted");
	thread func_DAD2();
	for(;;)
	{
		if(self.cancontestclaim && self.var_10B51 != self.wasstalemate)
		{
			if(self.var_10B51)
			{
				if(isdefined(self.var_C4D9))
				{
					self [[ self.var_C4D9 ]]();
				}
			}
			else
			{
				var_00 = "none";
				if(self.numtouching["allies"])
				{
					var_00 = "allies";
				}
				else if(self.numtouching["axis"])
				{
					var_00 = "axis";
				}

				if(var_00 == "none" && self.ownerteam != "neutral")
				{
					var_00 = self.ownerteam;
				}

				if(isdefined(self.var_C5B9))
				{
					self [[ self.var_C5B9 ]](var_00);
				}

				func_F690("none");
				self.claimplayer = undefined;
			}

			self.wasstalemate = self.var_10B51;
		}
		else if(self.mustmaintainclaim && self.ownerteam != "neutral" && !self.numtouching[self.ownerteam])
		{
			if(isdefined(self.var_C5BA))
			{
				self [[ self.var_C5BA ]]();
			}

			func_F690("none");
			self.claimplayer = undefined;
		}

		if(self.claimteam != "none")
		{
			if(!self.var_130EE)
			{
				if(!self.var_10B51)
				{
					var_01 = func_7E8B();
					if(isdefined(self.var_C5BB))
					{
						self [[ self.var_C5BB ]](self.claimplayer);
					}

					func_F690("none");
					self.claimplayer = undefined;
				}
			}
			else if(self.var_130EE && self.var_115DF[self.claimteam] >= self.var_130EE)
			{
				self.var_4B30 = 0;
				self.var_115DF[self.claimteam] = self.var_4B30;
				var_01 = func_7E8B();
				if(isdefined(self.var_C50D))
				{
					self [[ self.var_C50D ]](self.claimteam,var_01,isdefined(var_01));
				}

				if(isdefined(var_01) && isdefined(self.var_C5BB))
				{
					self [[ self.var_C5BB ]](var_01);
				}

				func_F690("none");
				self.claimplayer = undefined;
			}
			else if(!self.var_10B51 && self.var_130EE && self.ownerteam != self.claimteam)
			{
				if(!self.numtouching[self.claimteam])
				{
					if(isdefined(self.var_C50D))
					{
						self [[ self.var_C50D ]](self.claimteam,self.claimplayer,0);
					}

					func_F690("none");
					self.claimplayer = undefined;
				}
				else
				{
					self.var_4B30 = self.var_4B30 + 50 * self.userate;
					self.var_115DF[self.claimteam] = self.var_4B30;
					if(self.ownerteam != level.var_C74B[self.claimteam])
					{
						self.var_115DF[level.var_C74B[self.claimteam]] = 0;
					}

					if(isdefined(self.var_C5C8))
					{
						self [[ self.var_C5C8 ]](self.claimteam,self.var_115DF[self.claimteam] / self.var_130EE,50 * self.userate / self.var_130EE,self.claimplayer);
					}
				}
			}
		}

		wait(0.05);
		scripts\mp\_hostmigration::func_13834();
	}
}

//Function Number: 43
func_130AE(param_00)
{
	level endon("game_ended");
	self endon("deleted");
	for(;;)
	{
		wait(0.1);
		if(self.ownerteam != "neutral")
		{
			if(self.numtouching[self.ownerteam] >= 1 && !self.var_10B51)
			{
				self.var_4B30 = 0;
				self.var_115DF[self.claimteam] = self.var_4B30;
				break;
			}
		}

		if(self.claimteam == "none")
		{
			if(self.var_130EE)
			{
				wait(0.1);
				if(self.claimteam == "none" && !self.var_10B51)
				{
					self.var_4B30 = self.var_4B30 - 50;
				}

				self.var_115DF[self.lastclaimteam] = self.var_4B30;
			}

			if(self.var_115DF[self.lastclaimteam] <= 0)
			{
				self.var_4B30 = 0;
				self.var_115DF[self.lastclaimteam] = self.var_4B30;
				break;
			}
		}

		scripts\mp\_hostmigration::func_13834();
	}
}

//Function Number: 44
func_3895(param_00)
{
	if(isdefined(self.carrier))
	{
		return 0;
	}

	if(self.cancontestclaim)
	{
		var_01 = func_8019(param_00.pers["team"]);
		if(var_01 != 0)
		{
			return 0;
		}
	}

	if(func_3E22(param_00))
	{
		return 1;
	}

	return 0;
}

//Function Number: 45
func_DAD2()
{
	level endon("game_ended");
	self endon("deleted");
	var_00 = self.var_664A;
	for(;;)
	{
		self.trigger waittill("trigger",var_01);
		if(!scripts\mp\_utility::func_9F19(var_01))
		{
			continue;
		}

		if(isagent(var_01))
		{
			continue;
		}

		if(!scripts\mp\_utility::func_9E0E(var_01))
		{
			continue;
		}

		if(isdefined(self.carrier))
		{
			continue;
		}

		if(isdefined(var_01.var_108DB))
		{
			continue;
		}

		if(var_01 method_8568())
		{
			continue;
		}

		if(isdefined(var_01.classname) && var_01.classname == "script_vehicle")
		{
			continue;
		}

		if(!isdefined(var_01.var_987A))
		{
			continue;
		}

		var_02 = getrelativeteam(var_01.pers["team"]);
		if(isdefined(self.var_115F2[var_02]) && self.var_115F2[var_02] < 0)
		{
			continue;
		}

		if(!lib_0DF8::func_213D(self,var_01))
		{
			continue;
		}

		if(self.claimteam == "none" && caninteractwith(var_01.pers["team"],var_01))
		{
			if(func_3895(var_01))
			{
				if(!func_DAD1(var_01))
				{
					continue;
				}

				func_F690(var_01.pers["team"]);
				self.claimplayer = var_01;
				if(isdefined(self.var_115F2[var_02]))
				{
					self.var_130EE = self.var_115F2[var_02];
				}

				if(self.var_130EE && isdefined(self.var_C4CB))
				{
					self [[ self.var_C4CB ]](self.claimplayer);
				}
			}
			else if(isdefined(self.var_C4D4))
			{
				self [[ self.var_C4D4 ]](var_01);
			}
		}

		if(scripts\mp\_utility::func_9F19(var_01) && !isdefined(var_01.var_11A46[var_00]))
		{
			var_01 thread func_127CA(self);
		}
	}
}

//Function Number: 46
func_DAD1(param_00)
{
	if(!isdefined(self.var_E1BA))
	{
		return 1;
	}

	var_01 = param_00 geteye();
	var_02 = scripts\common\trace::func_48BC(0,1,1,1,0,1,0);
	var_03 = [];
	if(level.gametype == "tdef" || scripts\mp\_utility::func_9FB3(level.var_53E1))
	{
		var_04 = self.trigger.origin + (0,0,16);
		var_05 = 0;
		var_03[0] = self.visuals[0];
	}
	else if(level.gametype == "ball")
	{
		var_04 = self.trigger.origin + (0,0,8);
		var_05 = 0;
		var_03[0] = self.visuals[0];
	}
	else
	{
		var_04 = self.trigger.origin + (0,0,32);
		var_05 = 1;
		var_03[0] = self.visuals;
	}

	var_03[1] = self.carrier;
	var_06 = scripts\common\trace::func_DCED(var_01,var_04,var_03,var_02,0);
	if(var_06["fraction"] != 1 && var_05)
	{
		var_04 = self.trigger.origin + (0,0,16);
		var_06 = scripts\common\trace::func_DCED(var_01,var_04,var_03,var_02,0);
	}

	if(var_06["fraction"] != 1)
	{
		var_04 = self.trigger.origin + (0,0,0);
		var_06 = scripts\common\trace::func_DCED(var_01,var_04,var_03,var_02,0);
	}

	return var_06["fraction"] == 1;
}

//Function Number: 47
func_F690(param_00)
{
	if(!isdefined(self.var_3FF7))
	{
		self.var_3FF7 = 1000;
	}

	if(self.claimteam == "none" && gettime() - self.lastclaimtime > self.var_3FF7)
	{
		self.var_4B30 = 0;
		self.var_115DF[param_00] = self.var_4B30;
	}
	else if(param_00 != "none" && param_00 != self.lastclaimteam)
	{
		self.var_4B30 = 0;
		self.var_115DF[param_00] = self.var_4B30;
	}

	self.lastclaimteam = self.claimteam;
	self.lastclaimtime = gettime();
	self.claimteam = param_00;
	func_12F57();
}

//Function Number: 48
func_7E29()
{
	return self.claimteam;
}

//Function Number: 49
func_127CA(param_00)
{
	var_01 = self.pers["team"];
	param_00.numtouching[var_01]++;
	var_02 = self.var_86BD;
	var_03 = spawnstruct();
	var_03.player = self;
	var_03.var_10DFF = gettime();
	param_00.touchlist[var_01][var_02] = var_03;
	if(!isdefined(param_00.var_C18B))
	{
		param_00.var_C18B = 0;
	}

	self.var_11A46[param_00.var_664A] = param_00.trigger;
	param_00 func_12F57();
	while(scripts\mp\_utility::func_9F19(self) && isdefined(param_00.trigger) && self istouching(param_00.trigger) && !level.var_7669)
	{
		if(!lib_0DF8::func_213D(self,param_00))
		{
			break;
		}

		if(isplayer(self) && param_00.var_130EE > 50)
		{
			func_12F53(param_00,1);
		}

		wait(0.05);
	}

	if(isdefined(self))
	{
		if(param_00.var_130EE > 50)
		{
			if(isplayer(self))
			{
				func_12F53(param_00,0);
			}

			self.var_11A46[param_00.var_664A] = undefined;
		}
		else
		{
			self.var_11A46[param_00.var_664A] = undefined;
		}
	}

	if(level.var_7669)
	{
		return;
	}

	param_00.var_C405 = param_00.touchlist;
	param_00.touchlist[var_01][var_02] = undefined;
	param_00.numtouching[var_01]--;
	param_00 func_12F57();
}

//Function Number: 50
func_B737(param_00)
{
	param_00.var_B737 = 1;
	level waittill("host_migration_begin");
	if(!isdefined(param_00) || !isdefined(self))
	{
		return;
	}

	param_00 setclientomnvar("ui_securing",0);
	param_00 setclientomnvar("ui_securing_progress",0);
	self.var_B737 = undefined;
}

//Function Number: 51
func_8019(param_00)
{
	return self.numtouching[scripts\mp\_utility::getotherteam(param_00)];
}

//Function Number: 52
func_12F53(param_00,param_01)
{
	if(!isdefined(level.var_90A9))
	{
		var_02 = 0;
		if(isdefined(param_00.var_115DF) && isdefined(param_00.claimteam))
		{
			if(param_00.var_115DF[param_00.claimteam] > param_00.var_130EE)
			{
				param_00.var_115DF[param_00.claimteam] = param_00.var_130EE;
			}

			var_02 = param_00.var_115DF[param_00.claimteam] / param_00.var_130EE;
		}
		else
		{
			if(param_00.var_4B30 > param_00.var_130EE)
			{
				param_00.var_4B30 = param_00.var_130EE;
			}

			var_02 = param_00.var_4B30 / param_00.var_130EE;
		}

		if(level.gametype == "ctf" && !isdefined(param_00.var_92B8))
		{
			if(param_01 && scripts\mp\_utility::func_9FB3(param_00.var_10B51))
			{
				if(!isdefined(self.var_12B1C))
				{
					if(!isdefined(self.var_12B1B))
					{
						self.var_12B1B = 1;
					}

					self setclientomnvar("ui_objective_state",-1);
					self.var_12B1C = 1;
				}

				var_02 = 0.01;
			}
			else if(param_01 && isdefined(self.var_12B1B) && isdefined(param_00.var_10B51) && !param_00.var_10B51 && param_00.ownerteam != self.team)
			{
				self setclientomnvar("ui_objective_state",1);
				self.var_12B1B = 1;
				self.var_12B1C = undefined;
			}
			else if(param_01 && isdefined(self.var_12B1B) && isdefined(param_00.var_10B51) && !param_00.var_10B51 && param_00.ownerteam == self.team)
			{
				self setclientomnvar("ui_objective_state",2);
				self.var_12B1B = 1;
				self.var_12B1C = undefined;
			}
			else
			{
				if(!param_01 && isdefined(self.var_12B1C))
				{
					self setclientomnvar("ui_objective_state",0);
					self.var_12B1B = undefined;
				}

				if(param_01 && !isdefined(self.var_12B1C) && param_00.ownerteam == self.team)
				{
					self setclientomnvar("ui_objective_state",0);
					self.var_12B1B = undefined;
				}

				if(param_01 && !isdefined(self.var_12B1B))
				{
					if(param_00.ownerteam != self.team)
					{
						self setclientomnvar("ui_objective_state",1);
						self.var_12B1B = 1;
					}
					else if(param_00.interactteam == "any")
					{
						self setclientomnvar("ui_objective_state",2);
						self.var_12B1B = 1;
					}
				}

				self.var_12B1C = undefined;
			}

			if(!param_01)
			{
				var_02 = 0.01;
				self setclientomnvar("ui_objective_state",0);
				self.var_12B1B = undefined;
			}

			if(var_02 != 0)
			{
				if(isdefined(param_00.var_115DF) && isdefined(param_00.claimteam) && param_01)
				{
					self setclientomnvar("ui_objective_progress",param_00.var_115DF[self.team] / param_00.var_130EE);
				}
				else
				{
					self setclientomnvar("ui_objective_progress",var_02);
				}
			}
		}

		if(func_8BE7() && isdefined(param_00.var_92B8) && param_00.var_92B8 == "domFlag" || param_00.var_92B8 == "hardpoint")
		{
			var_03 = 0;
			if(level.gametype == "koth" || level.gametype == "grnd")
			{
				var_03 = 7;
				if(scripts\mp\_utility::func_9FB3(level.var_13097) && isdefined(param_00.ownerteam) && param_00.ownerteam != "neutral")
				{
					var_03 = 8;
				}
			}
			else
			{
				if(param_00.label == "_a")
				{
					var_03 = 1;
				}
				else if(param_00.label == "_b")
				{
					var_03 = 2;
				}
				else if(param_00.label == "_c")
				{
					var_03 = 3;
				}

				if(scripts\mp\_utility::func_9FB3(param_00.neutralizing))
				{
					var_03 = var_03 + 3;
				}
			}

			if(param_01 && isdefined(param_00.var_10B51) && param_00.var_10B51)
			{
				if(!isdefined(self.var_12B1E))
				{
					if(!isdefined(self.var_12B1D))
					{
						self.var_12B1D = 1;
					}

					self setclientomnvar("ui_objective_state",-1);
					self.var_12B1E = 1;
				}

				var_02 = 0.01;
			}
			else if(param_01 && isdefined(self.var_12B1D) && isdefined(param_00.var_10B51) && !param_00.var_10B51 && param_00.ownerteam != self.team)
			{
				self setclientomnvar("ui_objective_state",var_03);
				self.var_12B1D = 1;
				self.var_12B1E = undefined;
			}
			else
			{
				if(!param_01 && isdefined(self.var_12B1E))
				{
					self setclientomnvar("ui_objective_state",0);
					self.var_12B1D = undefined;
				}

				if(param_01 && !isdefined(self.var_12B1E) && param_00.ownerteam == self.team)
				{
					self setclientomnvar("ui_objective_state",0);
					self.var_12B1D = undefined;
				}

				if(param_01 && !isdefined(self.var_12B1D) && param_00.ownerteam != self.team)
				{
					self setclientomnvar("ui_objective_state",var_03);
					self.var_12B1D = 1;
				}

				self.var_12B1E = undefined;
			}

			if(!param_01 || !param_00 caninteractwith(self.team) && !isdefined(param_00.var_10B51) || isdefined(param_00.var_10B51) && !param_00.var_10B51)
			{
				var_02 = 0.01;
				self setclientomnvar("ui_objective_state",0);
				self.var_12B1D = undefined;
			}

			if(var_02 != 0)
			{
				if(isdefined(param_00.var_115DF) && isdefined(param_00.claimteam) && param_01)
				{
					self setclientomnvar("ui_objective_progress",param_00.var_115DF[self.team] / param_00.var_130EE);
					return;
				}

				self setclientomnvar("ui_objective_progress",var_02);
				return;
			}

			return;
		}

		if(isbombmode() && isdefined(param_00.var_92B8) && param_00.var_92B8 == "bomb_zone" || param_00.var_92B8 == "defuse_object")
		{
			if(isdefined(self))
			{
				if(param_01 && isdefined(self))
				{
					if(!isdefined(self.var_12B1A))
					{
						var_04 = 0;
						if(param_00.var_92B8 == "bomb_zone")
						{
							var_04 = 1;
						}
						else if(param_00.var_92B8 == "defuse_object")
						{
							var_04 = 2;
						}

						self setclientomnvar("ui_objective_state",var_04);
						self.var_12B1A = 1;
					}
				}
				else
				{
					self setclientomnvar("ui_objective_state",0);
					self.var_12B1A = undefined;
					var_02 = 0.01;
				}

				if(var_02 != 0)
				{
					if(isdefined(param_00.var_115DF) && isdefined(param_00.claimteam) && param_01)
					{
						self setclientomnvar("ui_objective_progress",param_00.var_115DF[self.team] / param_00.var_130EE);
						return;
					}

					self setclientomnvar("ui_objective_progress",var_02);
					return;
				}

				return;
			}

			return;
		}

		if(isdefined(param_00.var_92B8))
		{
			var_04 = 0;
			switch(param_00.var_92B8)
			{
				case "care_package":
					var_04 = 1;
					break;

				case "intel":
					var_04 = 2;
					break;

				case "deployable_vest":
					var_04 = 3;
					break;

				case "deployable_weapon_crate":
					var_04 = 4;
					break;

				case "last_stand":
					var_04 = 5;
					if(isdefined(self.inlaststand) && self.inlaststand)
					{
						var_04 = 6;
					}
					break;

				case "breach":
					var_04 = 7;
					break;

				case "use":
					var_04 = 8;
					break;
			}

			func_12F55(var_02,param_01,var_04,param_00,param_00.var_130EE);
			return;
		}

		return;
	}
}

//Function Number: 53
func_8BE7()
{
	if(level.gametype == "dom" || level.gametype == "grind" || level.gametype == "koth" || level.gametype == "grnd" || level.gametype == "siege")
	{
		return 1;
	}

	return 0;
}

//Function Number: 54
func_12F55(param_00,param_01,param_02,param_03,param_04)
{
	if(param_01)
	{
		if(!isdefined(param_03.var_13074))
		{
			param_03.var_13074 = [];
		}

		if(!isdefined(self.var_B737))
		{
			param_03 thread func_B737(self);
		}

		if(!func_693C(self,param_03.var_13074))
		{
			param_03.var_13074[param_03.var_13074.size] = self;
		}

		if(!isdefined(self.var_12B26))
		{
			self setclientomnvar("ui_securing",param_02);
			self.var_12B26 = 1;
		}
	}
	else
	{
		if(isdefined(param_03.var_13074) && func_693C(self,param_03.var_13074))
		{
			param_03.var_13074 = scripts\common\utility::func_22A9(param_03.var_13074,self);
		}

		self setclientomnvar("ui_securing",0);
		self.var_12B26 = undefined;
		param_00 = 0.01;
	}

	if(param_04 == 500)
	{
		param_00 = min(param_00 + 0.15,1);
	}

	if(param_00 != 0)
	{
		self setclientomnvar("ui_securing_progress",param_00);
	}
}

//Function Number: 55
func_693C(param_00,param_01)
{
	if(param_01.size > 0)
	{
		foreach(var_03 in param_01)
		{
			if(var_03 == param_00)
			{
				return 1;
			}
		}
	}

	return 0;
}

//Function Number: 56
func_12F57()
{
	if(self.claimteam == "none" && self.ownerteam != "neutral" && self.ownerteam != "any")
	{
		var_00 = self.ownerteam;
	}
	else
	{
		var_00 = self.claimteam;
	}

	var_01 = self.numtouching[var_00];
	var_02 = 0;
	var_03 = 0;
	if(level.multiteambased)
	{
		foreach(var_05 in level.teamnamelist)
		{
			if(var_00 != var_05)
			{
				var_02 = var_02 + self.numtouching[var_05];
			}
		}
	}
	else
	{
		if(var_00 != "axis")
		{
			var_02 = var_02 + self.numtouching["axis"];
		}

		if(var_00 != "allies")
		{
			var_02 = var_02 + self.numtouching["allies"];
		}
	}

	foreach(var_08 in self.touchlist[var_00])
	{
		if(!isdefined(var_08.player))
		{
			continue;
		}

		if(var_08.player.pers["team"] != var_00)
		{
			continue;
		}

		if(var_08.player.var_C2AD == 1)
		{
			continue;
		}

		var_01 = var_01 * var_08.player.var_C2AD;
		var_03 = var_08.player.var_C2AD;
	}

	self.var_10B51 = var_01 && var_02;
	self.userate = 0;
	if(var_01 && !var_02)
	{
		self.userate = min(var_01,4);
	}

	if(isdefined(self.var_9D49) && self.var_9D49 && var_03 != 0)
	{
		self.userate = 1 * var_03;
		return;
	}

	if(isdefined(self.var_9D49) && self.var_9D49)
	{
		self.userate = 1;
	}
}

//Function Number: 57
func_13093(param_00)
{
	param_00 notify("use_hold");
	if(isplayer(param_00))
	{
		param_00 playerlinkto(self.trigger);
	}
	else
	{
		param_00 linkto(self.trigger);
	}

	param_00 playerlinkedoffsetenable();
	param_00 clientclaimtrigger(self.trigger);
	param_00.var_3FFA = self.trigger;
	param_00 allowmovement(0);
	param_00 unlink();
	if(isbombmode())
	{
		if(scripts\mp\_utility::func_9D46() || scripts\mp\_utility::func_9FB3(level.var_101F7) || param_00 scripts\mp\_utility::_hasperk("specialty_engineer"))
		{
			self.var_130F8 = "briefcase_bomb_defuse_mp";
		}
		else
		{
			self.var_130F8 = "briefcase_bomb_mp";
		}
	}

	var_01 = self.var_130F8;
	var_02 = param_00 getcurrentweapon();
	if(isdefined(var_01))
	{
		if(var_02 == var_01)
		{
			var_02 = param_00.var_A9C6;
		}

		param_00.var_A9C6 = var_02;
		param_00 scripts\mp\_utility::func_12C6(var_01);
		param_00 setweaponammostock(var_01,0);
		param_00 setweaponammoclip(var_01,0);
		param_00 thread func_11382(var_01);
	}
	else
	{
		param_00 scripts\common\utility::allow_weapon(0);
	}

	self.var_4B30 = 0;
	self.var_9B04 = 1;
	self.userate = 0;
	var_03 = func_13094(param_00,var_02);
	if(isdefined(param_00))
	{
		param_00 func_5397();
		param_00 notify("done_using");
	}

	if(isdefined(var_01) && isdefined(param_00))
	{
		param_00 scripts\mp\_supers::func_12D6C();
		if(param_00 scripts\mp\_utility::func_9F20(var_01))
		{
			param_00 scripts\mp\_utility::func_1529(var_01);
		}
		else
		{
			param_00 thread scripts\mp\_utility::func_80F2(var_01);
		}
	}

	if(isdefined(var_03) && var_03)
	{
		param_00 allowmovement(1);
		return 1;
	}

	if(isdefined(param_00))
	{
		param_00.var_3FFA = undefined;
		if(!isdefined(var_01))
		{
			param_00 scripts\common\utility::allow_weapon(1);
		}

		if(!scripts\mp\_utility::func_9F19(param_00))
		{
			param_00.var_A64F = 1;
		}

		param_00 allowmovement(1);
	}

	self.var_9B04 = 0;
	self.trigger releaseclaimedtrigger();
	return 0;
}

//Function Number: 58
func_5397()
{
	if(isdefined(self.var_247F))
	{
		self detach(self.var_247F,"tag_inhand");
		self.var_247F = undefined;
	}
}

//Function Number: 59
func_11382(param_00)
{
	scripts\mp\_supers::func_1CAB();
	var_01 = scripts\mp\_utility::func_11383(param_00,1);
	if(!scripts\common\utility::istrue(var_01))
	{
		scripts\mp\_supers::func_12D6C();
		if(scripts\mp\_utility::func_9F20(param_00))
		{
			scripts\mp\_utility::func_1529(param_00);
			return;
		}

		scripts\mp\_utility::func_141E(param_00);
	}
}

//Function Number: 60
func_130E9(param_00,param_01,param_02,param_03)
{
	if(!scripts\mp\_utility::func_9F19(param_00))
	{
		return 0;
	}

	if(!param_00 istouching(self.trigger))
	{
		return 0;
	}

	if(!param_00 usebuttonpressed())
	{
		return 0;
	}

	if(param_00 scripts\mp\_utility::func_85C7())
	{
		return 0;
	}

	if(param_00 meleebuttonpressed())
	{
		return 0;
	}

	if(self.var_4B30 >= self.var_130EE)
	{
		return 0;
	}

	if(!self.userate && !param_01)
	{
		return 0;
	}

	if(param_01 && param_02 > param_03)
	{
		return 0;
	}

	if(isdefined(self.var_130F8))
	{
		if(param_00 getcurrentweapon() != self.var_130F8 && !param_00 scripts\mp\_utility::func_9F20(self.var_130F8))
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 61
func_13094(param_00,param_01)
{
	level endon("game_ended");
	self endon("disabled");
	var_02 = self.var_130F8;
	var_03 = 1;
	if(isdefined(self.var_136F6))
	{
		var_03 = self.var_136F6;
	}

	if(!var_03)
	{
		self.userate = 1 * param_00.var_C2AD;
	}

	var_04 = 0;
	var_05 = 1.5;
	while(func_130E9(param_00,var_03,var_04,var_05))
	{
		var_04 = var_04 + 0.05;
		if(!var_03 || !isdefined(var_02) || param_00 getcurrentweapon() == var_02)
		{
			self.var_4B30 = self.var_4B30 + 50 * self.userate;
			self.userate = 1 * param_00.var_C2AD;
			var_03 = 0;
		}
		else
		{
			self.userate = 0;
		}

		param_00 func_12F53(self,1);
		if(self.var_4B30 >= self.var_130EE)
		{
			self.var_9B04 = 0;
			param_00 clientreleasetrigger(self.trigger);
			param_00.var_3FFA = undefined;
			if(!isdefined(var_02))
			{
				param_00 scripts\common\utility::allow_weapon(1);
			}

			param_00 unlink();
			return scripts\mp\_utility::func_9F19(param_00);
		}

		wait(0.05);
		scripts\mp\_hostmigration::func_13834();
	}

	param_00 func_12F53(self,0);
	return 0;
}

//Function Number: 62
updatetrigger()
{
	if(self.triggertype != "use")
	{
		return;
	}

	if(self.interactteam == "none")
	{
		self.trigger.origin = self.trigger.origin - (0,0,50000);
		return;
	}

	if(self.interactteam == "any")
	{
		self.trigger.origin = self.var_4B2C;
		self.trigger setteamfortrigger("none");
		return;
	}

	if(self.interactteam == "friendly")
	{
		self.trigger.origin = self.var_4B2C;
		if(self.ownerteam == "allies")
		{
			self.trigger setteamfortrigger("allies");
			return;
		}

		if(self.ownerteam == "axis")
		{
			self.trigger setteamfortrigger("axis");
			return;
		}

		self.trigger.origin = self.trigger.origin - (0,0,50000);
		return;
	}

	if(self.interactteam == "enemy")
	{
		self.trigger.origin = self.var_4B2C;
		if(self.ownerteam == "allies")
		{
			self.trigger setteamfortrigger("axis");
			return;
		}

		if(self.ownerteam == "axis")
		{
			self.trigger setteamfortrigger("allies");
			return;
		}

		self.trigger setteamfortrigger("none");
		return;
	}
}

//Function Number: 63
updateworldicons()
{
	if(self.visibleteam == "any")
	{
		updateworldicon("friendly",1);
		updateworldicon("enemy",1);
		return;
	}

	if(self.visibleteam == "friendly")
	{
		updateworldicon("friendly",1);
		updateworldicon("enemy",0);
		return;
	}

	if(self.visibleteam == "enemy")
	{
		updateworldicon("friendly",0);
		updateworldicon("enemy",1);
		return;
	}

	updateworldicon("friendly",0);
	updateworldicon("enemy",0);
}

//Function Number: 64
getmlgteamcolor(param_00)
{
	if(param_00 == "allies")
	{
		return game["colors"]["friendly"];
	}
	else if(param_00 == "axis")
	{
		return game["colors"]["enemy"];
	}

	return (1,1,1);
}

//Function Number: 65
setobjpointteamcolor(param_00,param_01,param_02)
{
	if(param_01 == "mlg_allies")
	{
		param_00 setmlgdraw(1,0);
		var_03 = self.worldiconscolor[param_02];
		if(var_03 == "friendly")
		{
			param_00.color = getmlgteamcolor("allies");
			return;
		}

		if(var_03 == "enemy")
		{
			param_00.color = getmlgteamcolor("axis");
			return;
		}

		param_00.color = game["colors"][var_03];
		return;
	}

	if(param_01 == "mlg_axis")
	{
		param_00 setmlgdraw(1,0);
		var_03 = self.worldiconscolor[param_02];
		if(var_03 == "friendly")
		{
			param_00.color = getmlgteamcolor("axis");
			return;
		}

		if(var_03 == "enemy")
		{
			param_00.color = getmlgteamcolor("allies");
			return;
		}

		param_00.color = game["colors"][var_03];
		return;
	}

	param_00.color = game["colors"][self.worldiconscolor[param_02]];
	param_00 setmlgdraw(0,1);
}

//Function Number: 66
updateworldicon(param_00,param_01)
{
	if(!isdefined(self.var_13DCA[param_00]))
	{
		param_01 = 0;
	}

	var_02 = getupdateteams(param_00);
	if(getdvarint("com_codcasterEnabled",0) == 1)
	{
		var_03 = var_02.size;
		for(var_04 = 0;var_04 < var_03;var_04++)
		{
			if(var_02[var_04] == "allies")
			{
				var_02[var_02.size] = "mlg_allies";
				continue;
			}

			if(var_02[var_04] == "axis")
			{
				var_02[var_02.size] = "mlg_axis";
			}
		}
	}

	for(var_04 = 0;var_04 < var_02.size;var_04++)
	{
		var_05 = "objpoint_" + var_02[var_04] + "_" + self.var_664A;
		var_06 = scripts\mp\_objpoints::func_801E(var_05);
		if(!isdefined(var_06))
		{
			continue;
		}

		var_06 notify("stop_flashing_thread");
		var_06 thread scripts\mp\_objpoints::func_11070();
		if(param_01)
		{
			var_06 setshader(self.var_13DCA[param_00],level.var_C2C4,level.var_C2C4);
			var_06 fadeovertime(0.05);
			var_06.alpha = var_06.var_2897;
			var_06.var_9F51 = 1;
			if(level.gametype == "dom")
			{
				var_06 setwaypoint(0,1);
			}
			else if(isdefined(self.var_4465[param_00]))
			{
				var_06 setwaypoint(1,1);
			}
			else
			{
				var_06 setwaypoint(1,0);
			}

			setobjpointteamcolor(var_06,var_02[var_04],param_00);
			var_06 setwaypointbackground(getwaypointbackgroundtype(self.var_13DCA[param_00]));
			if(self.type == "carryObject")
			{
				var_07 = var_02[var_04] == "mlg_allies" || var_02[var_04] == "mlg_axis";
				if(isdefined(self.carrier) && !shouldpingobject(param_00) || var_07)
				{
					var_06 settargetent(self.carrier);
				}
				else if(!isdefined(self.carrier) && isdefined(self.var_C2A6) && self.var_C2A6)
				{
					var_06 settargetent(self.visuals[0]);
				}
				else
				{
					var_06 cleartargetent();
				}
			}
			else if(isdefined(self.var_C2B4))
			{
				var_06 settargetent(self.var_C2B4);
			}
		}
		else
		{
			var_06 fadeovertime(0.05);
			var_06.alpha = 0;
			var_06.var_9F51 = 0;
			var_06 cleartargetent();
		}

		var_06 thread func_8EDE();
	}
}

//Function Number: 67
func_8EDE()
{
	self notify("hideWorldIconOnGameEnd");
	self endon("hideWorldIconOnGameEnd");
	self endon("death");
	level waittill("game_ended");
	if(isdefined(self))
	{
		self.alpha = 0;
	}
}

//Function Number: 68
func_12F43(param_00,param_01)
{
}

//Function Number: 69
updatecompassicons()
{
	if(self.visibleteam == "any")
	{
		updatecompassicon("friendly",1);
		updatecompassicon("enemy",1);
		return;
	}

	if(self.visibleteam == "friendly")
	{
		updatecompassicon("friendly",1);
		updatecompassicon("enemy",0);
		return;
	}

	if(self.visibleteam == "enemy")
	{
		updatecompassicon("friendly",0);
		updatecompassicon("enemy",1);
		return;
	}

	updatecompassicon("friendly",0);
	updatecompassicon("enemy",0);
}

//Function Number: 70
updateobjectiveiconcolortype(param_00,param_01)
{
	var_02 = self.worldiconscolor[param_01];
	if(!isdefined(var_02))
	{
		scripts\mp\objidpoolmanager::minimap_objective_icon_colortype(param_00,0);
		return;
	}

	if(var_02 == "friendly")
	{
		scripts\mp\objidpoolmanager::minimap_objective_icon_colortype(param_00,1);
		return;
	}

	if(var_02 == "enemy")
	{
		scripts\mp\objidpoolmanager::minimap_objective_icon_colortype(param_00,2);
		return;
	}

	if(var_02 == "contest")
	{
		scripts\mp\objidpoolmanager::minimap_objective_icon_colortype(param_00,3);
		return;
	}

	scripts\mp\objidpoolmanager::minimap_objective_icon_colortype(param_00,0);
}

//Function Number: 71
updatecompassicon(param_00,param_01)
{
	var_02 = getupdateteams(param_00);
	for(var_03 = 0;var_03 < var_02.size;var_03++)
	{
		var_04 = var_02[var_03];
		var_05 = param_01;
		if(!var_05 && shouldshowcompassduetoradar(var_04))
		{
			var_05 = 1;
		}

		var_06 = self.var_115DC[var_04];
		if(var_06 != -1)
		{
			if(!isdefined(self.var_4465[param_00]) || !var_05)
			{
				scripts\mp\objidpoolmanager::minimap_objective_state(var_06,"invisible");
				continue;
			}

			scripts\mp\objidpoolmanager::minimap_objective_icon(var_06,self.var_4465[param_00]);
			scripts\mp\objidpoolmanager::minimap_objective_state(var_06,"active");
			scripts\mp\objidpoolmanager::minimap_objective_icon_backgroundtype(var_06,getwaypointbackgroundtype(self.var_4465[param_00]));
			updateobjectiveiconcolortype(var_06,param_00);
			if(self.type == "carryObject")
			{
				if(scripts\mp\_utility::func_9F19(self.carrier) && !shouldpingobject(param_00))
				{
					scripts\mp\objidpoolmanager::minimap_objective_onentity(var_06,self.carrier);
				}
				else if(isdefined(self.visuals) && isdefined(self.visuals[0]) && isdefined(self.visuals[0] getlinkedparent()))
				{
					scripts\mp\objidpoolmanager::minimap_objective_onentity(var_06,self.visuals[0]);
				}
				else if(isdefined(self.var_C2A6) && self.var_C2A6 && !shouldpingobject(param_00))
				{
					scripts\mp\objidpoolmanager::minimap_objective_onentity(var_06,self.visuals[0]);
				}
				else
				{
					scripts\mp\objidpoolmanager::minimap_objective_position(var_06,self.var_4B2C);
				}

				continue;
			}

			if(isdefined(self.var_C2B4))
			{
				scripts\mp\objidpoolmanager::minimap_objective_onentity(var_06,self.var_C2B4);
			}
		}
	}
}

//Function Number: 72
shouldpingobject(param_00)
{
	if(param_00 == "friendly" && self.var_C2BE)
	{
		return 1;
	}
	else if(param_00 == "enemy" && self.var_C2BD)
	{
		return 1;
	}

	return 0;
}

//Function Number: 73
getupdateteams(param_00)
{
	var_01 = [];
	foreach(var_03 in level.teamnamelist)
	{
		if(param_00 == "friendly")
		{
			if(isfriendlyteam(var_03))
			{
				var_01[var_01.size] = var_03;
			}

			continue;
		}

		if(param_00 == "enemy")
		{
			if(!isfriendlyteam(var_03))
			{
				var_01[var_01.size] = var_03;
			}
		}
	}

	return var_01;
}

//Function Number: 74
shouldshowcompassduetoradar(param_00)
{
	if(!isdefined(self.carrier))
	{
		return 0;
	}

	if(self.carrier scripts\mp\_utility::_hasperk("specialty_gpsjammer"))
	{
		return 0;
	}

	return getteamradar(param_00);
}

//Function Number: 75
updatevisibilityaccordingtoradar()
{
	self endon("death");
	self endon("carrier_cleared");
	for(;;)
	{
		level waittill("radar_status_change");
		updatecompassicons();
	}
}

//Function Number: 76
func_F7D4(param_00)
{
	self.ownerteam = param_00;
	updatetrigger();
	updatecompassicons();
	updateworldicons();
	if(param_00 != "neutral")
	{
		self.var_D8BA = param_00;
	}
}

//Function Number: 77
func_803E()
{
	return self.ownerteam;
}

//Function Number: 78
func_FB08(param_00)
{
	self.var_130EE = int(param_00 * 1000);
}

//Function Number: 79
func_FB14(param_00)
{
	self.var_136F6 = param_00;
}

//Function Number: 80
func_FB07(param_00)
{
	self.var_130EB = param_00;
}

//Function Number: 81
func_F87D(param_00,param_01)
{
	self.var_115F2[param_00] = int(param_01 * 1000);
}

//Function Number: 82
func_F87C(param_00,param_01)
{
	self.var_115F1[param_00] = param_01;
}

//Function Number: 83
func_FB06(param_00)
{
	self.trigger sethintstring(param_00);
}

//Function Number: 84
func_1C7C(param_00)
{
	self.interactteam = param_00;
}

//Function Number: 85
func_1CAF(param_00)
{
	self.interactteam = param_00;
	updatetrigger();
}

//Function Number: 86
setvisibleteam(param_00)
{
	self.visibleteam = param_00;
	updatecompassicons();
	updateworldicons();
}

//Function Number: 87
setmodelvisibility(param_00)
{
	if(param_00)
	{
		for(var_01 = 0;var_01 < self.visuals.size;var_01++)
		{
			self.visuals[var_01] show();
			if(self.visuals[var_01].classname == "script_brushmodel" || self.visuals[var_01].classname == "script_model")
			{
				foreach(var_03 in level.players)
				{
					if(var_03 istouching(self.visuals[var_01]))
					{
						var_03 scripts\mp\_utility::func_1417();
					}
				}

				self.visuals[var_01] thread makesolid();
			}
		}

		return;
	}

	for(var_01 = 0;var_01 < self.visuals.size;var_01++)
	{
		self.visuals[var_01] hide();
		if(self.visuals[var_01].classname == "script_brushmodel" || self.visuals[var_01].classname == "script_model")
		{
			self.visuals[var_01] notify("changing_solidness");
			self.visuals[var_01] notsolid();
		}
	}
}

//Function Number: 88
makesolid()
{
	self endon("death");
	self notify("changing_solidness");
	self endon("changing_solidness");
	for(;;)
	{
		for(var_00 = 0;var_00 < level.players.size;var_00++)
		{
			if(level.players[var_00] istouching(self))
			{
				break;
			}
		}

		if(var_00 == level.players.size)
		{
			self solid();
			break;
		}

		wait(0.05);
	}
}

//Function Number: 89
func_F680(param_00)
{
	self.var_3AF1 = param_00;
}

//Function Number: 90
func_F67D(param_00)
{
	self.var_130E5 = param_00;
}

//Function Number: 91
func_F283(param_00,param_01)
{
	self.var_4465[param_00] = param_01;
	if(!isdefined(param_01))
	{
		self.worldiconscolor[param_00] = "neutral";
	}
	else
	{
		self.worldiconscolor[param_00] = getwaypointbackgroundcolor(param_01);
	}

	updatecompassicons();
}

//Function Number: 92
getwaypointbackgroundtype(param_00)
{
	if(!isdefined(level.waypointbgtype))
	{
		scripts\mp\_gamelogic::initwaypointbackgrounds();
	}

	var_01 = level.waypointbgtype[param_00];
	if(!isdefined(var_01))
	{
		return 0;
	}

	return var_01;
}

//Function Number: 93
getwaypointbackgroundcolor(param_00)
{
	if(!isdefined(level.waypointcolors))
	{
		scripts\mp\_gamelogic::initwaypointbackgrounds();
	}

	var_01 = level.waypointcolors[param_00];
	if(!isdefined(var_01))
	{
		return "neutral";
	}

	return var_01;
}

//Function Number: 94
func_F284(param_00,param_01)
{
	self.var_13DCA[param_00] = param_01;
	if(!isdefined(param_01))
	{
		self.worldiconscolor[param_00] = "neutral";
	}
	else
	{
		self.worldiconscolor[param_00] = getwaypointbackgroundcolor(param_01);
	}

	updateworldicons();
}

//Function Number: 95
set3duseicon(param_00,param_01)
{
	self.var_13DCD[param_00] = param_01;
}

//Function Number: 96
setcarryicon(param_00)
{
	self.var_3AF5 = param_00;
}

//Function Number: 97
disableobject()
{
	self notify("disabled");
	if(self.type == "carryObject")
	{
		if(isdefined(self.carrier))
		{
			self.carrier func_11471(self);
		}

		for(var_00 = 0;var_00 < self.visuals.size;var_00++)
		{
			self.visuals[var_00] hide();
		}
	}

	self.trigger scripts\common\utility::trigger_off();
	setvisibleteam("none");
}

//Function Number: 98
enableobject()
{
	if(self.type == "carryObject")
	{
		for(var_00 = 0;var_00 < self.visuals.size;var_00++)
		{
			self.visuals[var_00] show();
		}
	}

	self.trigger scripts\common\utility::trigger_on();
	setvisibleteam("any");
}

//Function Number: 99
getrelativeteam(param_00)
{
	if(param_00 == self.ownerteam)
	{
		return "friendly";
	}

	return "enemy";
}

//Function Number: 100
isfriendlyteam(param_00)
{
	if(self.ownerteam == "any")
	{
		return 1;
	}

	if(self.ownerteam == param_00)
	{
		return 1;
	}

	if(self.ownerteam == "neutral" && isdefined(self.var_D8BA) && self.var_D8BA == param_00)
	{
		return 1;
	}

	return 0;
}

//Function Number: 101
caninteractwith(param_00,param_01)
{
	switch(self.interactteam)
	{
		case "none":
			return 0;

		case "any":
			return 1;

		case "friendly":
			if(param_00 == self.ownerteam)
			{
				return 1;
			}
			else
			{
				return 0;
			}
	
			break;

		case "enemy":
			if(param_00 != self.ownerteam)
			{
				return 1;
			}
			else
			{
				return 0;
			}
	
			break;

		default:
			return 0;
	}
}

//Function Number: 102
isteam(param_00)
{
	if(param_00 == "neutral")
	{
		return 1;
	}

	if(param_00 == "allies")
	{
		return 1;
	}

	if(param_00 == "axis")
	{
		return 1;
	}

	if(param_00 == "any")
	{
		return 1;
	}

	if(param_00 == "none")
	{
		return 1;
	}

	foreach(var_02 in level.teamnamelist)
	{
		if(param_00 == var_02)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 103
isrelativeteam(param_00)
{
	if(param_00 == "friendly")
	{
		return 1;
	}

	if(param_00 == "enemy")
	{
		return 1;
	}

	if(param_00 == "any")
	{
		return 1;
	}

	if(param_00 == "none")
	{
		return 1;
	}

	return 0;
}

//Function Number: 104
getenemyteam(param_00)
{
	if(level.multiteambased)
	{
	}

	if(!level.teambased)
	{
	}

	if(param_00 == "neutral")
	{
		return "none";
	}

	if(param_00 == "allies")
	{
		return "axis";
	}

	return "allies";
}

//Function Number: 105
getlabel()
{
	var_00 = self.trigger.script_label;
	if(!isdefined(var_00))
	{
		var_00 = "";
		return var_00;
	}

	if(var_00[0] != "_")
	{
		return "_" + var_00;
	}

	return var_00;
}

//Function Number: 106
initializetagpathvariables()
{
	self.nearest_node = undefined;
	self.calculated_nearest_node = 0;
	self.on_path_grid = undefined;
}

//Function Number: 107
mustmaintainclaim(param_00)
{
	self.mustmaintainclaim = param_00;
}

//Function Number: 108
cancontestclaim(param_00)
{
	self.cancontestclaim = param_00;
}

//Function Number: 109
setzonestatusicons(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = param_00;
	}

	func_F283("friendly",param_00);
	func_F284("friendly",param_00);
	func_F283("enemy",param_01);
	func_F284("enemy",param_01);
}

//Function Number: 110
getleveltriggers()
{
	level.minetriggers = getentarray("minefield","targetname");
	level.hurttriggers = getentarray("trigger_hurt","classname");
	level.radtriggers = getentarray("radiation","targetname");
	level.ballallowedtriggers = getentarray("uplinkAllowedOOB","targetname");
	level.nozonetriggers = getentarray("uplink_nozone","targetname");
	level.droptonavmeshtriggers = getentarray("dropToNavMesh","targetname");
	thread scripts\mp\_utility::initarbitraryuptriggers();
}

//Function Number: 111
isbombmode()
{
	if(level.gametype == "sd" || level.gametype == "sr" || level.gametype == "dd")
	{
		return 1;
	}

	return 0;
}

//Function Number: 112
touchingdroptonavmeshtrigger(param_00)
{
	if(level.droptonavmeshtriggers.size > 0)
	{
		if(isbombmode() || level.gametype == "ctf")
		{
			self.visuals[0].origin = param_00;
		}

		foreach(var_02 in level.droptonavmeshtriggers)
		{
			foreach(var_04 in self.visuals)
			{
				if(var_04 istouching(var_02))
				{
					return 1;
				}
			}
		}
	}

	return 0;
}

//Function Number: 113
touchingarbitraryuptrigger()
{
	if(level.arbitraryuptriggers.size > 0)
	{
		foreach(var_01 in level.arbitraryuptriggers)
		{
			if(self istouching(var_01))
			{
				return 1;
			}
		}
	}

	return 0;
}