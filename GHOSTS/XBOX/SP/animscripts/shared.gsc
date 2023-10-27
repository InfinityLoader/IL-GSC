/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\shared.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 33
 * Decompile Time: 430 ms
 * Timestamp: 10/27/2023 1:36:32 AM
*******************************************************************/

//Function Number: 1
placeweaponon(param_00,param_01,param_02)
{
	self notify("weapon_position_change");
	var_03 = self.weaponinfo[param_00].position;
	if(param_01 != "none" && self.a.var_8DB5[param_01] == param_00)
	{
		return;
	}

	detachallweaponmodels();
	if(var_03 != "none")
	{
		func_26BD(param_00);
	}

	if(param_01 == "none")
	{
		func_86CC();
		return;
	}

	if(self.a.var_8DB5[param_01] != "none")
	{
		func_26BD(self.a.var_8DB5[param_01]);
	}

	if(!isdefined(param_02))
	{
		param_02 = 1;
	}

	if(param_02 && param_01 == "left" || param_01 == "right")
	{
		func_0FD9(param_00,param_01);
		self.weapon = param_00;
	}
	else
	{
		func_0FD9(param_00,param_01);
	}

	func_86CC();
}

//Function Number: 2
func_26BD(param_00)
{
	self.a.var_8DB5[self.weaponinfo[param_00].position] = "none";
	self.weaponinfo[param_00].position = "none";
}

//Function Number: 3
func_0FD9(param_00,param_01)
{
	self.weaponinfo[param_00].position = param_01;
	self.a.var_8DB5[param_01] = param_00;
	if(self.a.var_8DB6[param_01] != "none")
	{
		self notify("end_weapon_drop_" + param_01);
		self.a.var_8DB6[param_01] = "none";
	}
}

//Function Number: 4
getweaponforpos(param_00)
{
	var_01 = self.a.var_8DB5[param_00];
	if(var_01 == "none")
	{
		return self.a.var_8DB6[param_00];
	}

	return var_01;
}

//Function Number: 5
detachallweaponmodels()
{
	var_00 = [];
	var_00[var_00.size] = "right";
	var_00[var_00.size] = "left";
	var_00[var_00.size] = "chest";
	var_00[var_00.size] = "back";
	self laseroff();
	foreach(var_02 in var_00)
	{
		var_03 = getweaponforpos(var_02);
		if(var_03 == "none")
		{
			continue;
		}

		if(weapontype(var_03) == "riotshield" && isdefined(self.var_7403))
		{
			if(isdefined(self.var_7400) && self.var_7400)
			{
				playfxontag(common_scripts\utility::func_3AB9("riot_shield_dmg"),self,"TAG_BRASS");
				self.var_7400 = undefined;
			}
		}
	}

	self method_814F();
}

//Function Number: 6
func_86CC()
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
		var_01[var_01.size] = getweaponforpos(var_04);
		var_02[var_02.size] = func_3C1F(var_04);
	}

	self method_814F(var_01[0],var_02[0],var_01[1],var_02[1],var_01[2],var_02[2],var_01[3],var_02[3]);
	foreach(var_04 in var_00)
	{
		var_07 = getweaponforpos(var_04);
		if(var_07 == "none")
		{
			continue;
		}

		if(self.weaponinfo[var_07].var_87A8 && !self.weaponinfo[var_07].var_4003)
		{
			self hidepart("tag_clip");
		}
	}

	func_86F8();
}

//Function Number: 7
func_86F8()
{
	if(isdefined(self.custom_laser_function))
	{
		[[ self.custom_laser_function ]]();
	}

	if(self.a.var_8DB5["right"] == "none")
	{
	}

	if(func_1A1E())
	{
		self laseron();
	}

	self laseroff();
}

//Function Number: 8
func_1A1E()
{
	if(!self.a.var_4BDF)
	{
		return 0;
	}

	if(animscripts/utility::isshotgun(self.weapon))
	{
		return 0;
	}

	return isalive(self);
}

//Function Number: 9
func_3C1F(param_00)
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
			return "tag_inhand";

		default:
			break;
	}
}

//Function Number: 10
func_2B48(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = self.weapon;
	}

	if(param_00 == "none")
	{
	}

	if(isdefined(self.var_565D))
	{
	}

	detachallweaponmodels();
	var_01 = self.weaponinfo[param_00].position;
	if(self.dropweapon && var_01 != "none")
	{
		thread func_2B66(param_00,var_01);
	}

	func_26BD(param_00);
	if(param_00 == self.weapon)
	{
		self.weapon = "none";
	}

	func_86CC();
}

//Function Number: 11
func_2B49()
{
	if(isdefined(self.var_565D))
	{
		return "none";
	}

	var_00 = [];
	var_00[var_00.size] = "left";
	var_00[var_00.size] = "right";
	var_00[var_00.size] = "chest";
	var_00[var_00.size] = "back";
	detachallweaponmodels();
	foreach(var_02 in var_00)
	{
		var_03 = self.a.var_8DB5[var_02];
		if(var_03 == "none")
		{
			continue;
		}

		self.weaponinfo[var_03].position = "none";
		self.a.var_8DB5[var_02] = "none";
		if(self.dropweapon)
		{
			thread func_2B66(var_03,var_02);
		}
	}

	self.weapon = "none";
	func_86CC();
}

//Function Number: 12
func_2B66(param_00,param_01)
{
	if(self isragdoll())
	{
		return "none";
	}

	self.a.var_8DB6[param_01] = param_00;
	var_02 = param_00;
	if(issubstr(tolower(var_02),"rpg"))
	{
		var_02 = "rpg_player";
	}
	else if(issubstr(tolower(var_02),"panzerfaust3"))
	{
		var_02 = "panzerfaust3_player";
	}

	self method_81F6(var_02,param_01,0);
	self endon("end_weapon_drop_" + param_01);
	wait(0.1);
	if(!isdefined(self))
	{
	}

	detachallweaponmodels();
	self.a.var_8DB6[param_01] = "none";
	func_86CC();
}

//Function Number: 13
func_2986(param_00,param_01,param_02)
{
	for(;;)
	{
		self waittill(param_00,var_03);
		if(!isdefined(var_03))
		{
			var_03 = "undefined";
		}

		var_04 = animscripts/notetracks::handlenotetrack(var_03,param_00,param_01);
		if(isdefined(var_04))
		{
			return var_04;
		}
	}
}

//Function Number: 14
getpredictedaimyawtoshootentorpos(param_00)
{
	if(!isdefined(self.var_7439))
	{
		if(!isdefined(self.var_7445))
		{
			return 0;
		}

		return func_3A11(self.var_7445);
	}

	var_01 = self.var_7439.origin + self.shootentvelocity * param_00;
	return func_3A11(var_01);
}

//Function Number: 15
func_3A12()
{
	if(!isdefined(self.var_7439))
	{
		if(!isdefined(self.var_7445))
		{
			return 0;
		}

		return func_3A11(self.var_7445);
	}

	return func_3A11(self.var_7439 method_82D1());
}

//Function Number: 16
getaimpitchtoshootentorpos()
{
	var_00 = getpitchtoshootentorpos();
	if(self.script == "cover_crouch" && isdefined(self.a.covermode) && self.a.covermode == "lean")
	{
		var_00 = var_00 - level.covercrouchleanpitch;
	}

	return var_00;
}

//Function Number: 17
getpitchtoshootentorpos()
{
	if(!isdefined(self.var_7439))
	{
		if(!isdefined(self.var_7445))
		{
			return 0;
		}

		return animscripts/combat_utility::func_3B91(self.var_7445);
	}

	return animscripts/combat_utility::func_3B91(self.var_7439 method_82D1());
}

//Function Number: 18
func_3BE5()
{
	if(isdefined(self.var_87C4))
	{
		var_00 = self method_81EE();
		return (var_00[0],var_00[1],self geteye()[2]);
	}

	return (self.origin[0],self.origin[1],self geteye()[2]);
}

//Function Number: 19
func_3A11(param_00)
{
	var_01 = animscripts/utility::getyawtospot(param_00);
	var_02 = distance(self.origin,param_00);
	if(var_02 > 3)
	{
		var_03 = asin(-3 / var_02);
		var_01 = var_01 + var_03;
	}

	var_01 = angleclamp180(var_01);
	return var_01;
}

//Function Number: 20
func_62FA(param_00)
{
	self endon("killanimscript");
	func_62FB(param_00);
	%generic_aim_left;
	%generic_aim_right;
}

//Function Number: 21
func_62FB(param_00)
{
	self endon("rambo_aim_end");
	waittillframeend;
	%generic_aim_left;
	%generic_aim_right;
	%generic_aim_45l;
	%generic_aim_45r;
	var_01 = 0.2;
	var_02 = 0;
	for(;;)
	{
		if(isdefined(self.var_7445))
		{
			var_03 = animscripts/utility::func_3C87(self.var_7445) - self.var_1FCA.angles[1];
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

			%generic_aim_right;
			%generic_aim_left;
		}
		else
		{
			var_04 = var_02 / 45;
			if(var_04 > 1)
			{
				var_04 = 1;
			}

			%generic_aim_left;
			%generic_aim_right;
		}

		wait(var_01);
	}
}

//Function Number: 22
func_2437()
{
	var_00 = 0;
	var_01 = weaponburstcount(self.weapon);
	if(var_01)
	{
		var_00 = var_01;
	}
	else if(animscripts/weaponlist::func_87FC())
	{
		var_00 = level.var_6D8B[randomint(level.var_6D8B.size)];
	}
	else if(self.var_31EA)
	{
		var_00 = level.fastburstfirenumshots[randomint(level.fastburstfirenumshots.size)];
	}
	else
	{
		var_00 = level.burstfirenumshots[randomint(level.burstfirenumshots.size)];
	}

	if(var_00 <= self.bulletsinclip)
	{
		return var_00;
	}

	if(self.bulletsinclip <= 0)
	{
		return 1;
	}

	return self.bulletsinclip;
}

//Function Number: 23
func_2438()
{
	var_00 = self.bulletsinclip;
	if(weaponclass(self.weapon) == "mg")
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

//Function Number: 24
func_3F7A(param_00)
{
	self endon("killanimscript");
	self endon("abort_reload");
	var_01 = undefined;
	if(self.weaponinfo[self.weapon].var_87A8)
	{
		var_01 = function_0170(self.weapon);
	}

	if(self.weaponinfo[self.weapon].var_4003)
	{
		if(animscripts/utility::func_87FE())
		{
			self playsound("weap_reload_pistol_clipout_npc");
		}
		else
		{
			self playsound("weap_reload_smg_clipout_npc");
		}

		if(isdefined(var_01))
		{
			self hidepart("tag_clip");
			thread func_2B4C(var_01,"tag_clip");
			self.weaponinfo[self.weapon].var_4003 = 0;
			thread func_6609(var_01);
		}
	}

	for(;;)
	{
		self waittill(param_00,var_02);
		switch(var_02)
		{
			case "attach clip right":
			case "attach clip left":
				if(isdefined(var_01))
				{
					self attach(var_01,"tag_inhand");
					thread func_6609(var_01,"tag_inhand");
					if(!self.weaponinfo[self.weapon].var_4003)
					{
						self hidepart("tag_clip");
					}
				}
		
				animscripts/weaponlist::refillclip();
				break;
	
			case "detach clip nohand":
				if(isdefined(var_01))
				{
					self detach(var_01,"tag_inhand");
				}
				break;
	
			case "detach clip right":
			case "detach clip left":
				if(isdefined(var_01))
				{
					self detach(var_01,"tag_inhand");
					self showpart("tag_clip");
					self notify("clip_detached");
					self.weaponinfo[self.weapon].var_4003 = 1;
				}
		
				if(animscripts/utility::func_87FE())
				{
					self playsound("weap_reload_pistol_clipin_npc");
				}
				else
				{
					self playsound("weap_reload_smg_clipin_npc");
				}
				self.a.var_5593 = 0;
				break;
		}
	}
}

//Function Number: 25
func_6609(param_00,param_01)
{
	self notify("clip_detached");
	self endon("clip_detached");
	common_scripts\utility::func_8B2A("killanimscript","abort_reload");
	if(!isdefined(self))
	{
	}

	if(isdefined(param_01))
	{
		self detach(param_00,param_01);
	}

	if(isalive(self))
	{
		if(self.weapon != "none" && self.weaponinfo[self.weapon].position != "none")
		{
			self showpart("tag_clip");
		}

		self.weaponinfo[self.weapon].var_4003 = 1;
	}

	if(isdefined(param_01))
	{
		func_2B4C(param_00,param_01);
	}
}

//Function Number: 26
func_2B4C(param_00,param_01)
{
	var_02 = spawn("script_model",self gettagorigin(param_01));
	var_02 setmodel(param_00);
	var_02.angles = self gettagangles(param_01);
	var_02 physicslaunchclient(var_02.origin,(0,0,0));
	wait(10);
	if(isdefined(var_02))
	{
		var_02 delete();
	}
}

//Function Number: 27
func_54BF(param_00,param_01)
{
	self endon("killanimscript");
	var_02 = param_00.origin;
	var_03 = distancesquared(self.origin,var_02);
	if(var_03 < 1)
	{
		self method_81FB(var_02);
	}

	if(var_03 > 256 && !self method_81F7(var_02,!self.swimmer))
	{
	}

	self.keepclaimednodeifvalid = 1;
	var_04 = distance(self.origin,var_02);
	var_05 = castint(param_01 * 20);
	for(var_06 = 0;var_06 < var_05;var_06++)
	{
		var_02 = param_00.origin;
		var_07 = self.origin - var_02;
		var_07 = vectornormalize(var_07);
		var_08 = var_02 + var_07 * var_04;
		var_09 = var_08 + var_02 - var_08 * var_06 + 1 / var_05;
		self method_81FB(var_09);
		wait(0.05);
	}

	self.keepclaimednodeifvalid = 0;
}

//Function Number: 28
func_668A()
{
	return 1;
}

//Function Number: 29
playlookanimation(param_00,param_01,param_02)
{
	if(!isdefined(param_02))
	{
		param_02 = ::func_668A;
	}

	for(var_03 = 0;var_03 < param_01 * 10;var_03++ = 1)
	{
		if(isalive(self.enemy))
		{
			if(animscripts/utility::func_19F6() && [[ param_02 ]]())
			{
			}
		}

		if(animscripts/utility::func_4979() && [[ param_02 ]]())
		{
		}

		%body;
		wait(0.1);
	}
}

//Function Number: 30
func_80AC(param_00)
{
	self endon("killanimscript");
	placeweaponon(self.secondaryweapon,"right");
	maps\_gameskill::didsomethingotherthanshooting();
}

//Function Number: 31
func_68B3()
{
	var_00 = func_68B5();
	if(var_00 == 0)
	{
	}

	self endon("death");
	for(;;)
	{
		level waittill("an_enemy_shot",var_01);
		if(var_01 != self)
		{
			continue;
		}

		if(!isdefined(var_01.enemy))
		{
			continue;
		}

		if(var_01.enemy != level.player)
		{
			continue;
		}

		if(isdefined(level.createrpgrepulsors) && level.createrpgrepulsors == 0)
		{
			continue;
		}

		thread func_68B4();
		var_00--;
		if(var_00 <= 0)
		{
		}
	}
}

//Function Number: 32
func_68B5()
{
	var_00 = maps\_utility::func_3A7F();
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

//Function Number: 33
func_68B4()
{
	var_00 = missilecreaterepulsorent(level.player,5000,800);
	wait(4);
	missiledeleteattractor(var_00);
}