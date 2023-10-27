/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\killstreaks\_deployablebox.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 40
 * Decompile Time: 1803 ms
 * Timestamp: 10/27/2023 12:28:21 AM
*******************************************************************/

//Function Number: 1
init()
{
	if(!isdefined(level.var_2F30))
	{
		level.var_2F30 = [];
	}
}

//Function Number: 2
func_2A63(param_00,param_01,param_02,param_03)
{
	thread func_139EB(param_01,param_00,param_02,param_03);
	return 1;
}

//Function Number: 3
func_139EB(param_00,param_01,param_02,param_03)
{
	self endon("spawned_player");
	self endon("disconnect");
	if(!isdefined(param_02))
	{
		return;
	}

	if(!isdefined(param_03))
	{
		return;
	}

	if(!scripts\mp\_utility::func_9F19(self))
	{
		param_02 delete();
	}

	param_02 makecollidewithitemclip(1);
	self notify("deployable_deployed");
	param_02.var_222 = self;
	param_02.var_39C = param_03;
	self.var_B377 = param_02;
	if(func_9E19(param_00))
	{
		self thread [[ level.var_2F30[param_00].var_85E7 ]](param_02);
		return;
	}

	param_02 playsoundtoplayer(level.var_2F30[param_00].var_5230,self);
	param_02 thread func_B378(param_01,param_00,::func_2F22);
}

//Function Number: 4
func_C80D(param_00)
{
	self notify("death");
}

//Function Number: 5
func_B378(param_00,param_01,param_02)
{
	self notify("markerActivate");
	self endon("markerActivate");
	self waittill("missile_stuck");
	var_03 = self.var_222;
	var_04 = self.origin;
	if(!isdefined(var_03))
	{
		return;
	}

	var_05 = func_498B(param_01,var_04,var_03);
	var_06 = spawnstruct();
	var_06.var_AD39 = self getlinkedparent();
	if(isdefined(var_06.var_AD39) && isdefined(var_06.var_AD39.model) && var_06.var_AD39.model != "")
	{
		var_05.origin = var_06.var_AD39.origin;
		var_07 = var_06.var_AD39 getlinkedparent();
		if(isdefined(var_07))
		{
			var_06.var_AD39 = var_07;
		}
		else
		{
			var_06.var_AD39 = undefined;
		}
	}

	var_06.var_4E53 = ::func_C80D;
	var_05 thread scripts\mp\_movers::func_892F(var_06);
	var_05.var_BD3B = var_06.var_AD39;
	var_05 method_831F(var_03);
	wait(0.05);
	var_05 thread [[ param_02 ]]();
	self delete();
	if(isdefined(var_05) && var_05 scripts\mp\_utility::touchingbadtrigger())
	{
		var_05 notify("death");
	}
}

//Function Number: 6
func_5225(param_00)
{
	if(param_00 == "mp_satcom")
	{
		return 1;
	}
	else if(issubstr(param_00,"paris_catacombs_iron"))
	{
		return 1;
	}
	else if(issubstr(param_00,"mp_warhawk_iron_gate"))
	{
		return 1;
	}

	return 0;
}

//Function Number: 7
func_9E32()
{
	var_00 = self getcurrentweapon();
	if(isdefined(var_00))
	{
		foreach(var_02 in level.var_2F30)
		{
			if(var_00 == var_02.var_39B)
			{
				return 1;
			}
		}
	}

	return 0;
}

//Function Number: 8
func_498B(param_00,param_01,param_02)
{
	var_03 = level.var_2F30[param_00];
	var_04 = spawn("script_model",param_01 - (0,0,1));
	var_04 setmodel(var_03.var_B91A);
	var_04.health = 999999;
	var_04.maxhealth = var_03.maxhealth;
	var_04.angles = param_02.angles;
	var_04.var_2F33 = param_00;
	var_04.var_222 = param_02;
	var_04.team = param_02.team;
	var_04.var_92B8 = var_03.var_92B8;
	if(isdefined(var_03.var_5B0C))
	{
		var_04.var_5B0C = var_03.var_5B0C;
	}

	if(isdefined(var_03.var_B4D1))
	{
		var_04.var_130DC = var_03.var_B4D1;
	}

	var_04 func_2F24();
	var_04 thread func_2F1C();
	var_04 func_17AF();
	return var_04;
}

//Function Number: 9
func_2F22(param_00)
{
	self setcursorhint("HINT_NOICON");
	var_01 = level.var_2F30[self.var_2F33];
	self sethintstring(var_01.var_17B);
	self.var_9B04 = 0;
	var_02 = scripts\mp\objidpoolmanager::requestminimapid(1);
	if(var_02 != -1)
	{
		scripts\mp\objidpoolmanager::minimap_objective_add(var_02,"invisible",(0,0,0));
		if(!isdefined(self getlinkedparent()))
		{
			scripts\mp\objidpoolmanager::minimap_objective_position(var_02,self.origin);
		}
		else
		{
			scripts\mp\objidpoolmanager::minimap_objective_onentity(var_02,self);
		}

		scripts\mp\objidpoolmanager::minimap_objective_state(var_02,"active");
		scripts\mp\objidpoolmanager::minimap_objective_icon(var_02,var_01.var_FC47);
	}

	self.var_C2BB = var_02;
	if(level.teambased)
	{
		if(var_02 != -1)
		{
			scripts\mp\objidpoolmanager::minimap_objective_team(var_02,self.team);
		}

		foreach(var_04 in level.players)
		{
			if(self.team == var_04.team && !isdefined(var_01.var_3936) || var_04 [[ var_01.var_3936 ]](self))
			{
				func_2F23(var_04,var_01.var_110EA,var_01.var_8C7A);
			}
		}
	}
	else
	{
		if(var_02 != -1)
		{
			scripts\mp\objidpoolmanager::minimap_objective_player(var_02,self.var_222 getentitynumber());
		}

		if(!isdefined(var_01.var_3936) || self.var_222 [[ var_01.var_3936 ]](self))
		{
			func_2F23(self.var_222,var_01.var_110EA,var_01.var_8C7A);
		}
	}

	self makeusable();
	self.var_9FBF = 1;
	self setcandamage(1);
	thread func_2F19();
	thread func_2F1A();
	thread func_2F26();
	thread func_561E();
	if(issentient(self))
	{
		self method_834E("DogsDontAttack");
	}

	if(isdefined(self.var_222))
	{
		self.var_222 notify("new_deployable_box",self);
	}

	if(level.teambased)
	{
		foreach(var_04 in level.var_C928)
		{
			func_119B(var_04,self.team == var_04.team,var_01.var_3936);
			if(!isai(var_04))
			{
				thread func_2F21(var_04);
			}
		}
	}
	else
	{
		foreach(var_04 in level.var_C928)
		{
			func_119B(var_04,isdefined(self.var_222) && self.var_222 == var_04,var_01.var_3936);
		}
	}

	thread func_2F20();
	thread func_2F14();
	if(isdefined(var_01.var_C4F0))
	{
		self [[ var_01.var_C4F0 ]](var_01);
	}

	thread func_4988(self.var_2F33);
}

//Function Number: 10
func_119B(param_00,param_01,param_02)
{
	if(param_01)
	{
		if(!isdefined(param_02) || param_00 [[ param_02 ]](self))
		{
			func_2F18(param_00);
		}
		else
		{
			func_2F15(param_00);
			thread func_5ADE(param_00);
		}

		thread func_2F31(param_00);
		return;
	}

	func_2F15(param_00);
}

//Function Number: 11
func_2F20()
{
	self endon("death");
	for(;;)
	{
		level waittill("connected",var_00);
		childthread func_2F27(var_00);
	}
}

//Function Number: 12
func_2F14()
{
	self endon("death");
	for(;;)
	{
		level waittill("spawned_agent_player",var_00);
		func_2F13(var_00);
	}
}

//Function Number: 13
func_2F27(param_00)
{
	param_00 waittill("spawned_player");
	if(level.teambased)
	{
		func_2F13(param_00);
		thread func_2F21(param_00);
	}
}

//Function Number: 14
func_2F21(param_00)
{
	self endon("death");
	param_00 endon("disconnect");
	for(;;)
	{
		param_00 waittill("joined_team");
		if(level.teambased)
		{
			func_2F13(param_00);
		}
	}
}

//Function Number: 15
func_2F13(param_00)
{
	if(self.team == param_00.team)
	{
		func_2F18(param_00);
		thread func_2F31(param_00);
		func_2F23(param_00,level.var_2F30[self.var_2F33].var_110EA,level.var_2F30[self.var_2F33].var_8C7A);
		return;
	}

	func_2F15(param_00);
	scripts\mp\_entityheadicons::func_F73D(param_00,"",(0,0,0));
}

//Function Number: 16
func_2F23(param_00,param_01,param_02)
{
	scripts\mp\_entityheadicons::func_F73D(param_00,scripts\mp\_utility::func_7F49(param_01),(0,0,param_02),14,14,undefined,undefined,undefined,undefined,undefined,0);
}

//Function Number: 17
func_2F18(param_00)
{
	if(isplayer(param_00))
	{
		self enableplayeruse(param_00);
	}

	self.var_55BC[param_00 getentitynumber()] = 0;
}

//Function Number: 18
func_2F15(param_00)
{
	if(isplayer(param_00))
	{
		self disableplayeruse(param_00);
	}

	self.var_55BC[param_00 getentitynumber()] = 1;
}

//Function Number: 19
func_2F24()
{
	self makeunusable();
	self.var_9FBF = 0;
	scripts\mp\_entityheadicons::func_F73D("none","",(0,0,0));
	if(isdefined(self.var_C2BB))
	{
		scripts\mp\objidpoolmanager::returnminimapid(self.var_C2BB);
	}
}

//Function Number: 20
func_2F19()
{
	var_00 = level.var_2F30[self.var_2F33];
	scripts\mp\_damage::func_B9C6(var_00.maxhealth,var_00.var_4D4A,::func_2F1B,::func_2F1F,1);
}

//Function Number: 21
func_2F1F(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = param_03;
	var_06 = level.var_2F30[self.var_2F33];
	if(var_06.var_1C9D)
	{
		var_05 = scripts\mp\_damage::func_89C3(param_01,param_02,var_05);
	}

	var_05 = scripts\mp\_damage::func_89C6(param_01,param_02,var_05);
	var_05 = scripts\mp\_damage::func_89AC(param_01,param_02,var_05);
	var_05 = scripts\mp\_damage::func_8975(param_01,param_02,var_05);
	return var_05;
}

//Function Number: 22
func_2F1B(param_00,param_01,param_02,param_03)
{
	var_04 = level.var_2F30[self.var_2F33];
	var_05 = scripts\mp\_damage::func_C548("deployable_ammo",param_00,param_01,param_02,param_03,var_04.var_EC44,var_04.var_13523);
	if(var_05)
	{
		param_00 notify("destroyed_equipment");
	}
}

//Function Number: 23
func_2F1A()
{
	self waittill("death");
	if(!isdefined(self))
	{
		return;
	}

	func_2F24();
	func_E0DA();
	var_00 = level.var_2F30[self.var_2F33];
	playfx(var_00.var_4E74,self.origin);
	self playsound("mp_killstreak_disappear");
	if(isdefined(var_00.var_4E3A))
	{
		var_01 = undefined;
		if(isdefined(self.var_222))
		{
			var_01 = self.var_222;
		}

		radiusdamage(self.origin + (0,0,var_00.var_8C7A),var_00.var_4E3C,var_00.var_4E3A,var_00.var_4E3B,var_01,"MOD_EXPLOSIVE",var_00.var_4E76);
	}

	self notify("deleting");
	self delete();
}

//Function Number: 24
func_2F1C()
{
	self endon("death");
	level endon("game_ended");
	self notify("box_handleOwner");
	self endon("box_handleOwner");
	self.var_222 waittill("killstreak_disowned");
	self notify("death");
}

//Function Number: 25
func_2F31(param_00)
{
	self endon("death");
	thread func_2F28(param_00);
	if(!isdefined(param_00.var_2F2B))
	{
		param_00.var_2F2B = [];
	}

	param_00.var_2F2B[param_00.var_2F2B.size] = self;
	var_01 = level.var_2F30[self.var_2F33];
	for(;;)
	{
		self waittill("captured",var_02);
		if(var_02 == param_00)
		{
			param_00 playlocalsound(var_01.var_C5C7);
			if(isdefined(var_01.var_C5BC))
			{
				param_00 [[ var_01.var_C5BC ]](self);
			}

			if(isdefined(self.var_222) && param_00 != self.var_222)
			{
				self.var_222 thread scripts\mp\_utility::func_83B4("support",undefined,var_01.var_130FC);
			}

			if(isdefined(self.var_130DC))
			{
				self.var_130DC--;
				if(self.var_130DC == 0)
				{
					func_2F1D();
					break;
				}
			}

			if(isdefined(var_01.var_393B) && var_01.var_393B)
			{
				foreach(var_04 in level.var_5212[var_01.var_110EA])
				{
					var_04 func_2F15(self);
					var_04 scripts\mp\_entityheadicons::func_F73D(self,"",(0,0,0));
					var_04 thread func_5ADE(self);
				}

				continue;
			}

			scripts\mp\_entityheadicons::func_F73D(param_00,"",(0,0,0));
			func_2F15(param_00);
			thread func_5ADE(param_00);
		}
	}
}

//Function Number: 26
func_5ADE(param_00)
{
	self endon("death");
	param_00 endon("disconnect");
	param_00 waittill("death");
	if(level.teambased)
	{
		if(self.team == param_00.team)
		{
			func_2F23(param_00,level.var_2F30[self.var_2F33].var_110EA,level.var_2F30[self.var_2F33].var_8C7A);
			func_2F18(param_00);
			return;
		}

		return;
	}

	if(isdefined(self.var_222) && self.var_222 == param_00)
	{
		func_2F23(param_00,level.var_2F30[self.var_2F33].var_110EA,level.var_2F30[self.var_2F33].var_8C7A);
		func_2F18(param_00);
	}
}

//Function Number: 27
func_2F28(param_00)
{
	level endon("game_ended");
	while(isdefined(self))
	{
		self waittill("trigger",var_01);
		if(isdefined(level.var_2F30[self.var_2F33].var_C18C) && level.var_2F30[self.var_2F33].var_C18C && scripts\mp\_utility::func_9E6C(param_00 getcurrentweapon()))
		{
			continue;
		}

		if(var_01 == param_00 && func_13093(param_00,level.var_2F30[self.var_2F33].var_130EE))
		{
			self notify("captured",param_00);
		}
	}
}

//Function Number: 28
func_9E08(param_00)
{
	return level.teambased && self.team == param_00.team;
}

//Function Number: 29
func_2F26()
{
	self endon("death");
	level endon("game_ended");
	var_00 = level.var_2F30[self.var_2F33];
	var_01 = var_00.var_AC71;
	scripts\mp\_hostmigration::func_13708(var_01);
	if(isdefined(var_00.var_13524))
	{
		self.var_222 thread scripts\mp\_utility::func_AAEC(var_00.var_13524);
	}

	func_2F1D();
}

//Function Number: 30
func_2F1D()
{
	wait(0.05);
	self notify("death");
}

//Function Number: 31
func_51C5(param_00)
{
	wait(0.25);
	self linkto(param_00,"tag_origin",(0,0,0),(0,0,0));
	param_00 waittill("death");
	func_2F1D();
}

//Function Number: 32
func_2F1E(param_00)
{
	self endon("death");
	self hide();
	foreach(var_02 in level.players)
	{
		if(var_02.team == param_00)
		{
			self showtoplayer(var_02);
		}
	}

	for(;;)
	{
		level waittill("joined_team");
		self hide();
		foreach(var_02 in level.players)
		{
			if(var_02.team == param_00)
			{
				self showtoplayer(var_02);
			}
		}
	}
}

//Function Number: 33
func_13093(param_00,param_01)
{
	scripts\mp\_movers::func_EE3E(param_00);
	param_00 scripts\common\utility::allow_weapon(0);
	param_00.var_2F2F = spawnstruct();
	param_00.var_2F2F.var_4B30 = 0;
	param_00.var_2F2F.var_9B04 = 1;
	param_00.var_2F2F.userate = 0;
	param_00.var_2F2F.var_92B8 = self.var_92B8;
	if(isdefined(param_01))
	{
		param_00.var_2F2F.var_130EE = param_01;
	}
	else
	{
		param_00.var_2F2F.var_130EE = 3000;
	}

	var_02 = func_13094(param_00);
	if(isalive(param_00))
	{
		param_00 scripts\common\utility::allow_weapon(1);
		scripts\mp\_movers::func_EE4D(param_00);
	}

	if(!isdefined(self))
	{
		return 0;
	}

	param_00.var_2F2F.var_9B04 = 0;
	param_00.var_2F2F.var_4B30 = 0;
	return var_02;
}

//Function Number: 34
func_13094(param_00)
{
	var_01 = param_00.var_2F2F;
	while(param_00 func_9EFD(var_01))
	{
		if(!param_00 scripts\mp\_movers::func_EE4E(self))
		{
			param_00 scripts\mp\_gameobjects::func_12F53(var_01,0);
			return 0;
		}

		var_01.var_4B30 = var_01.var_4B30 + 50 * var_01.userate;
		if(isdefined(param_00.var_C2AD))
		{
			var_01.userate = 1 * param_00.var_C2AD;
		}
		else
		{
			var_01.userate = 1;
		}

		param_00 scripts\mp\_gameobjects::func_12F53(var_01,1);
		if(var_01.var_4B30 >= var_01.var_130EE)
		{
			param_00 scripts\mp\_gameobjects::func_12F53(var_01,0);
			return scripts\mp\_utility::func_9F19(param_00);
		}

		wait(0.05);
	}

	param_00 scripts\mp\_gameobjects::func_12F53(var_01,0);
	return 0;
}

//Function Number: 35
func_561E()
{
	level endon("game_ended");
	self endon("death");
	for(;;)
	{
		level waittill("juggernaut_equipped",var_00);
		scripts\mp\_entityheadicons::func_F73D(var_00,"",(0,0,0));
		func_2F15(var_00);
		thread func_5ADE(var_00);
	}
}

//Function Number: 36
func_17AF()
{
	level.var_5212[self.var_2F33][self getentitynumber()] = self;
}

//Function Number: 37
func_E0DA()
{
	level.var_5212[self.var_2F33][self getentitynumber()] = undefined;
}

//Function Number: 38
func_4988(param_00)
{
	var_01 = level.var_2F30[param_00];
	if(isdefined(var_01.var_B91C))
	{
		var_02 = spawn("script_model",self.origin);
		var_02.angles = self.angles;
		var_02 hide();
		var_02 thread scripts\mp\_weapons::func_2C69(self.var_222);
		var_02 setmodel(var_01.var_B91C);
		var_02 linkto(self);
		var_02 method_82C7(0);
		self.var_2C68 = var_02;
		self waittill("death");
		if(isdefined(var_02))
		{
			var_02 delete();
			self.var_2C68 = undefined;
		}
	}
}

//Function Number: 39
func_9EFD(param_00)
{
	return !level.var_7669 && isdefined(param_00) && scripts\mp\_utility::func_9F19(self) && self usebuttonpressed() && !self method_81B5() && !self meleebuttonpressed() && param_00.var_4B30 < param_00.var_130EE && !isdefined(self.var_1165E) || !self.var_1165E;
}

//Function Number: 40
func_9E19(param_00)
{
	var_01 = 0;
	switch(param_00)
	{
		case "deployable_adrenaline_mist":
		case "deployable_speed_strip":
			var_01 = 1;
			break;

		default:
			var_01 = 0;
			break;
	}

	return var_01;
}