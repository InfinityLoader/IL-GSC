/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\anim\shared.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 32
 * Decompile Time: 1708 ms
 * Timestamp: 10/27/2023 12:00:59 AM
*******************************************************************/

//Function Number: 1
func_CC2C(param_00,param_01,param_02)
{
	self notify("weapon_position_change");
	var_03 = self.var_39B[param_00].var_245;
	if(param_01 != "none" && self.var_1491.var_13CBA[param_01] == param_00)
	{
		return;
	}

	func_5390();
	if(var_03 != "none")
	{
		func_5398(param_00);
	}

	if(param_01 == "none")
	{
		func_12E61();
		return;
	}

	if(self.var_1491.var_13CBA[param_01] != "none")
	{
		func_5398(self.var_1491.var_13CBA[param_01]);
	}

	if(!isdefined(param_02))
	{
		param_02 = 1;
	}

	if(param_02 && param_01 == "left" || param_01 == "right")
	{
		func_24AF(param_00,param_01);
		self.var_394 = param_00;
	}
	else
	{
		func_24AF(param_00,param_01);
	}

	func_12E61();
}

//Function Number: 2
func_5398(param_00)
{
	self.var_1491.var_13CBA[self.var_39B[param_00].var_245] = "none";
	self.var_39B[param_00].var_245 = "none";
}

//Function Number: 3
func_24AF(param_00,param_01)
{
	self.var_39B[param_00].var_245 = param_01;
	self.var_1491.var_13CBA[param_01] = param_00;
	if(self.var_1491.var_13CBB[param_01] != "none")
	{
		self notify("end_weapon_drop_" + param_01);
		self.var_1491.var_13CBB[param_01] = "none";
	}
}

//Function Number: 4
func_8221(param_00)
{
	var_01 = self.var_1491.var_13CBA[param_00];
	if(var_01 == "none")
	{
		return self.var_1491.var_13CBB[param_00];
	}

	return var_01;
}

//Function Number: 5
func_5390()
{
	var_00 = [];
	var_00[var_00.size] = "right";
	var_00[var_00.size] = "left";
	var_00[var_00.size] = "chest";
	var_00[var_00.size] = "back";
	self method_81D8();
	foreach(var_02 in var_00)
	{
		var_03 = func_8221(var_02);
		if(var_03 == "none")
		{
			continue;
		}

		if(function_024C(var_03) == "riotshield" && isdefined(self.var_FCA0))
		{
			if(isdefined(self.var_FC94) && self.var_FC94)
			{
				playfxontag(scripts\common\utility::getfx("riot_shield_dmg"),self,"TAG_BRASS");
				self.var_FC94 = undefined;
			}
		}
	}

	self method_83CD();
}

//Function Number: 6
func_12E61()
{
	var_00 = [];
	var_01 = [];
	var_02 = [];
	var_00[var_00.size] = "right";
	var_00[var_00.size] = "left";
	var_00[var_00.size] = "chest";
	var_00[var_00.size] = "back";
	foreach(var_04 in var_00)
	{
		var_01[var_01.size] = func_8221(var_04);
		var_02[var_02.size] = func_8193(var_04);
	}

	self method_83CD(var_01[0],var_02[0],var_01[1],var_02[1],var_01[2],var_02[2],var_01[3],var_02[3]);
	foreach(var_04 in var_00)
	{
		var_07 = func_8221(var_04);
		if(var_07 == "none")
		{
			continue;
		}

		if(self.var_39B[var_07].var_13053 && !self.var_39B[var_07].var_8BDE)
		{
			self method_8187("tag_clip");
		}
	}

	func_12EBD();
}

//Function Number: 7
func_12EBD()
{
	if(isdefined(self.var_4C5C))
	{
		[[ self.var_4C5C ]]();
		return;
	}

	if(self.var_1491.var_13CBA["right"] == "none")
	{
		return;
	}

	if(func_3939())
	{
		self method_81D9();
		return;
	}

	self method_81D8();
}

//Function Number: 8
func_3939()
{
	if(!self.var_1491.var_A878)
	{
		return 0;
	}

	if(scripts\anim\utility_common::func_9F4F(self.var_394))
	{
		return 0;
	}

	return isalive(self);
}

//Function Number: 9
func_8193(param_00)
{
	switch(param_00)
	{
		case "chest":
			return "tag_weapon_chest";

		case "back":
			return "tag_stowed_back";

		case "left":
			return "tag_weapon_left";

		case "right":
			return "tag_weapon_right";

		case "hand":
			return "tag_accessory_right";

		case "thigh":
			return "tag_stowed_thigh";

		default:
			break;
	}
}

//Function Number: 10
func_5D19(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = self.var_394;
	}

	if(param_00 == "none")
	{
		return;
	}

	if(isdefined(self.var_C05C))
	{
		return;
	}

	func_5390();
	var_01 = self.var_39B[param_00].var_245;
	if(self.var_102 && var_01 != "none")
	{
		thread func_5EF5(param_00,var_01);
	}

	func_5398(param_00);
	if(param_00 == self.var_394)
	{
		self.var_394 = "none";
	}

	func_12E61();
}

//Function Number: 11
func_5D1A()
{
	if(isdefined(self.var_C05C))
	{
		return "none";
	}

	var_00 = [];
	var_00[var_00.size] = "left";
	var_00[var_00.size] = "right";
	var_00[var_00.size] = "chest";
	var_00[var_00.size] = "back";
	func_5390();
	foreach(var_02 in var_00)
	{
		var_03 = self.var_1491.var_13CBA[var_02];
		if(var_03 == "none")
		{
			continue;
		}

		self.var_39B[var_03].var_245 = "none";
		self.var_1491.var_13CBA[var_02] = "none";
		if(self.var_102)
		{
			thread func_5EF5(var_03,var_02);
		}
	}

	self.var_394 = "none";
	func_12E61();
}

//Function Number: 12
func_5EF5(param_00,param_01)
{
	if(self method_81B7())
	{
		return "none";
	}

	self.var_1491.var_13CBB[param_01] = param_00;
	var_02 = getweaponbasename(param_00);
	var_03 = getsubstr(param_00,var_02.size,param_00.size);
	if(issubstr(tolower(var_02),"_ai"))
	{
		var_02 = getsubstr(var_02,0,var_02.size - 3);
	}

	var_04 = var_02 + var_03;
	self method_80BA(var_04,param_01,0);
	self endon("end_weapon_drop_" + param_01);
	wait(0.05);
	if(!isdefined(self))
	{
		return;
	}

	func_5390();
	self.var_1491.var_13CBB[param_01] = "none";
	func_12E61();
}

//Function Number: 13
func_592B(param_00,param_01,param_02)
{
	for(;;)
	{
		self waittill(param_00,var_03);
		if(!isdefined(var_03))
		{
			var_03 = ["undefined"];
		}

		if(!isarray(var_03))
		{
			var_03 = [var_03];
		}

		scripts\anim\utility::func_13142(param_00,var_03);
		foreach(var_05 in var_03)
		{
			var_06 = scripts\anim\notetracks::func_89CB(var_05,param_00,param_01);
			if(isdefined(var_06))
			{
				return var_06;
			}
		}
	}
}

//Function Number: 14
func_7DA8()
{
	if(!isdefined(self.var_FE9E))
	{
		if(!isdefined(self.var_FECF))
		{
			return 0;
		}

		return scripts\common\utility::func_7DA7(self.var_FECF);
	}

	return scripts\common\utility::func_7DA7(self.var_FE9E method_815B());
}

//Function Number: 15
func_7DA5()
{
	var_00 = func_8064();
	if(self.script == "cover_crouch" && isdefined(self.var_1491.var_4727) && self.var_1491.var_4727 == "lean")
	{
		var_00 = var_00 - level.var_4717;
	}

	return var_00;
}

//Function Number: 16
func_8064()
{
	if(!isdefined(self.var_FE9E))
	{
		if(!isdefined(self.var_FECF))
		{
			return 0;
		}

		return scripts\anim\combat_utility::func_8065(self.var_FECF);
	}

	return scripts\anim\combat_utility::func_8065(self.var_FE9E method_815B());
}

//Function Number: 17
func_811C()
{
	if(scripts\common\utility::func_167E())
	{
		return self geteye();
	}

	if(isdefined(self.var_130A9) && self.var_130A9)
	{
		var_00 = self method_8143();
		if(isdefined(self.var_130A8))
		{
			return var_00;
		}

		return (var_00[0],var_00[1],self geteye()[2]);
	}

	return (self.origin[0],self.origin[1],self geteye()[2]);
}

//Function Number: 18
func_DC59(param_00)
{
	self endon("killanimscript");
	func_DC5A(param_00);
}

//Function Number: 19
func_DC5A(param_00)
{
	self endon("rambo_aim_end");
	waittillframeend;
	var_01 = 0.2;
	var_02 = 0;
	for(;;)
	{
		if(isdefined(self.var_FECF))
		{
			var_03 = scripts\common\utility::func_8246(self.var_FECF) - self.var_473C.angles[1];
			var_03 = angleclamp180(var_03 - param_00);
			if(abs(var_03 - var_02) > 10)
			{
				if(var_03 > var_02)
				{
					var_03 = var_02 + 10;
				}
				else
				{
					var_03 = var_02 - 10;
				}
			}

			var_02 = var_03;
		}

		if(var_02 < 0)
		{
			var_04 = var_02 / -45;
			if(var_04 > 1)
			{
				var_04 = 1;
			}
		}
		else
		{
			var_04 = var_02 / 45;
			if(var_04 > 1)
			{
				var_04 = 1;
			}
		}

		wait(var_01);
	}
}

//Function Number: 20
func_4F65()
{
	var_00 = 0;
	var_01 = function_023C(self.var_394);
	if(var_01)
	{
		var_00 = var_01;
	}
	else if(scripts\anim\weaponlist::func_1311D())
	{
		var_00 = level.var_F217[randomint(level.var_F217.size)];
	}
	else if(self.var_6B92)
	{
		var_00 = level.var_6B93[randomint(level.var_6B93.size)];
	}
	else
	{
		var_00 = level.var_32BF[randomint(level.var_32BF.size)];
	}

	if(var_00 <= self.var_3250)
	{
		return var_00;
	}

	if(self.var_3250 <= 0)
	{
		return 1;
	}

	return self.var_3250;
}

//Function Number: 21
func_4F66()
{
	var_00 = self.var_3250;
	if(weaponclass(self.var_394) == "mg")
	{
		var_01 = randomfloat(10);
		if(var_01 < 3)
		{
			var_00 = randomintrange(2,6);
		}
		else if(var_01 < 8)
		{
			var_00 = randomintrange(6,12);
		}
		else
		{
			var_00 = randomintrange(12,20);
		}
	}

	return var_00;
}

//Function Number: 22
func_8996(param_00)
{
	self endon("abort_reload");
	self endon(param_00 + "_finished");
	var_01 = self.var_394;
	var_02 = undefined;
	if(self.var_39B[self.var_394].var_13053)
	{
		var_02 = function_00E6(self.var_394);
	}

	if(self.var_39B[self.var_394].var_8BDE)
	{
		if(scripts\anim\utility_common::func_9FCA())
		{
			self playsound("weap_reload_pistol_clipout_npc");
		}
		else
		{
			self playsound("weap_reload_smg_clipout_npc");
		}

		if(isdefined(var_02))
		{
			self method_8187("tag_clip");
			thread func_5D25(var_02,"tag_clip");
			self.var_39B[self.var_394].var_8BDE = 0;
		}
	}

	var_03 = 0;
	while(!var_03)
	{
		self waittill(param_00,var_04);
		if(!isarray(var_04))
		{
			var_04 = [var_04];
		}

		foreach(var_06 in var_04)
		{
			switch(var_06)
			{
				case "attach clip left":
					if(isdefined(var_02))
					{
						self attach(var_02,"tag_accessory_left");
						if(!self.var_39B[self.var_394].var_8BDE)
						{
							self method_8187("tag_clip");
						}
					}
	
					scripts\anim\weaponlist::func_DE4D();
					break;

				case "attach clip right":
					if(isdefined(var_02))
					{
						self attach(var_02,"tag_accessory_right");
						if(!self.var_39B[self.var_394].var_8BDE)
						{
							self method_8187("tag_clip");
						}
					}
	
					scripts\anim\weaponlist::func_DE4D();
					break;

				case "detach clip nohand":
					if(isdefined(var_02))
					{
						self detach(var_02,"tag_accessory_right");
					}
					break;

				case "detach clip right":
					if(isdefined(var_02))
					{
						self detach(var_02,"tag_accessory_right");
						if(var_01 == self.var_394)
						{
							self method_8387("tag_clip");
						}
						else
						{
							self.var_39B[var_01].var_8BDE = 1;
						}
	
						self notify("clip_detached");
						self.var_39B[self.var_394].var_8BDE = 1;
					}
	
					if(scripts\anim\utility_common::func_9FCA())
					{
						self playsound("weap_reload_pistol_clipin_npc");
					}
					else
					{
						self playsound("weap_reload_smg_clipin_npc");
					}
	
					self.var_1491.var_BE98 = 0;
					var_03 = 1;
					break;

				case "detach clip left":
					if(isdefined(var_02))
					{
						self detach(var_02,"tag_accessory_left");
						if(var_01 == self.var_394)
						{
							self method_8387("tag_clip");
						}
						else
						{
							self.var_39B[var_01].var_8BDE = 1;
						}
	
						self notify("clip_detached");
						self.var_39B[self.var_394].var_8BDE = 1;
					}
	
					if(scripts\anim\utility_common::func_9FCA())
					{
						self playsound("weap_reload_pistol_clipin_npc");
					}
					else
					{
						self playsound("weap_reload_smg_clipin_npc");
					}
	
					self.var_1491.var_BE98 = 0;
					var_03 = 1;
					break;
			}
		}
	}
}

//Function Number: 23
func_E24C(param_00,param_01)
{
	self notify("clip_detached");
	self endon("clip_detached");
	scripts\common\utility::waittill_any_3("killanimscript","abort_reload");
	if(!isdefined(self))
	{
		return;
	}

	if(isdefined(param_01))
	{
		self detach(param_00,param_01);
	}

	if(isalive(self))
	{
		if(self.var_394 != "none" && self.var_39B[self.var_394].var_245 != "none")
		{
			self method_8387("tag_clip");
		}

		self.var_39B[self.var_394].var_8BDE = 1;
		return;
	}

	if(isdefined(param_01))
	{
		func_5D25(param_00,param_01);
	}
}

//Function Number: 24
func_5D25(param_00,param_01)
{
	var_02 = spawn("script_model",self gettagorigin(param_01));
	var_02 setmodel(param_00);
	var_02.angles = self gettagangles(param_01);
	wait(0.05);
	var_02 physicslaunchclient(var_02.origin,(0,0,-0.1));
	wait(10);
	if(isdefined(var_02))
	{
		var_02 delete();
	}
}

//Function Number: 25
func_BD1D(param_00,param_01)
{
	self endon("killanimscript");
	var_02 = param_00.origin;
	var_03 = distancesquared(self.origin,var_02);
	if(var_03 < 1)
	{
		self method_8272(var_02);
		return;
	}

	if(var_03 > 256 && !self method_8200(var_02,!scripts\common\utility::func_167E()))
	{
		return;
	}

	self.var_1A4 = 1;
	var_04 = distance(self.origin,var_02);
	var_05 = int(param_01 * 20);
	for(var_06 = 0;var_06 < var_05;var_06++)
	{
		var_02 = param_00.origin;
		var_07 = self.origin - var_02;
		var_07 = vectornormalize(var_07);
		var_08 = var_02 + var_07 * var_04;
		var_09 = var_08 + var_02 - var_08 * var_06 + 1 / var_05;
		self method_8272(var_09);
		wait(0.05);
	}

	self.var_1A4 = 0;
}

//Function Number: 26
func_E47B()
{
	return 1;
}

//Function Number: 27
func_D4C2(param_00,param_01,param_02)
{
	if(!isdefined(param_02))
	{
		param_02 = ::func_E47B;
	}

	for(var_03 = 0;var_03 < param_01 * 10;var_03++)
	{
		if(isalive(self.var_10C))
		{
			if(scripts\anim\utility_common::func_3907() && [[ param_02 ]]())
			{
				return;
			}
		}

		if(scripts\anim\utility_common::func_9F8F() && [[ param_02 ]]())
		{
			return;
		}

		self method_82A5(param_00,%body,1,0.1);
		wait(0.1);
	}
}

//Function Number: 28
func_1180E(param_00)
{
	self endon("killanimscript");
	func_CC2C(self.var_F0C4,"right");
	scripts\sp\_gameskill::func_54C4();
}

//Function Number: 29
func_E775()
{
	var_00 = func_E777();
	if(var_00 == 0)
	{
		return;
	}

	self endon("death");
	for(;;)
	{
		level waittill("an_enemy_shot",var_01);
		if(var_01 != self)
		{
			continue;
		}

		if(!isdefined(var_01.var_10C))
		{
			continue;
		}

		if(var_01.var_10C != level.player)
		{
			continue;
		}

		if(isdefined(level.var_4A0A) && level.var_4A0A == 0)
		{
			continue;
		}

		thread func_E776();
		var_00--;
		if(var_00 <= 0)
		{
			return;
		}
	}
}

//Function Number: 30
func_E777()
{
	var_00 = scripts\sp\_utility::func_7E72();
	switch(var_00)
	{
		case "gimp":
		case "easy":
			return 2;

		case "difficult":
		case "hard":
		case "medium":
			return 1;

		case "fu":
			return 0;
	}

	return 2;
}

//Function Number: 31
func_E776()
{
	var_00 = missile_createrepulsorent(level.player,5000,800);
	wait(4);
	missile_deleteattractor(var_00);
}

//Function Number: 32
func_CB29()
{
	if(isdefined(self.var_13CAE) && self.var_13CAE)
	{
		return;
	}

	if(scripts\common\utility::func_13D90(level.player.origin,level.player getplayerangles(),self.origin,0.173648))
	{
		return;
	}

	if(distancesquared(self.origin,self.var_10C.origin) < self.var_42AE * self.var_42AE)
	{
		var_00 = self.var_72BB;
	}
	else
	{
		var_00 = self.var_72BC;
	}

	if(var_00 != self.var_394)
	{
		scripts\sp\_utility::func_72EC(var_00,"primary");
		self.var_13C4D setmodel(function_00EA(self.var_72BA));
		self.var_72BA = var_00;
	}
}