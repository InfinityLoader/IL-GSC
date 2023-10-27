/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\shared.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 34
 * Decompile Time: 590 ms
 * Timestamp: 10/27/2023 2:18:43 AM
*******************************************************************/

//Function Number: 1
func_0C9B(param_00,param_01,param_02)
{
	self notify("weapon_position_change");
	var_03 = self.weaponinfo[param_00].position;
	if(param_01 != "none" && self.a.weaponpos[param_01] == param_00)
	{
		return;
	}

	func_23C1();
	if(var_03 != "none")
	{
		func_23BE(param_00);
	}

	if(param_01 == "none")
	{
		func_23C4();
		return;
	}

	if(self.a.weaponpos[param_01] != "none")
	{
		func_23BE(self.a.weaponpos[param_01]);
	}

	if(!isdefined(param_02))
	{
		param_02 = 1;
	}

	if(param_02 && param_01 == "left" || param_01 == "right")
	{
		func_23BF(param_00,param_01);
		self.weapon = param_00;
	}
	else
	{
		func_23BF(param_00,param_01);
	}

	func_23C4();
}

//Function Number: 2
func_23BE(param_00)
{
	self.a.weaponpos[self.weaponinfo[param_00].position] = "none";
	self.weaponinfo[param_00].position = "none";
}

//Function Number: 3
func_23BF(param_00,param_01)
{
	self.weaponinfo[param_00].position = param_01;
	self.a.weaponpos[param_01] = param_00;
	if(self.a.var_20A4[param_01] != "none")
	{
		self notify("end_weapon_drop_" + param_01);
		self.a.var_20A4[param_01] = "none";
	}
}

//Function Number: 4
func_23C0(param_00)
{
	var_01 = self.a.weaponpos[param_00];
	if(var_01 == "none")
	{
		return self.a.var_20A4[param_00];
	}

	return var_01;
}

//Function Number: 5
func_23C1()
{
	var_00 = [];
	self laseroff();
	foreach(var_02 in var_7B)
	{
		var_03 = func_23C0(var_02);
		if(var_03 == "none")
		{
			continue;
		}

		if(weapontype(var_03) == "riotshield" && isdefined(self.var_23C2))
		{
			if(isdefined(self.var_23C3) && self.var_23C3)
			{
				playfxontag(common_scripts\utility::getfx("riot_shield_dmg"),self,"TAG_BRASS");
				self.var_23C3 = undefined;
			}

			self detach(getweaponmodel(var_03,self.var_23C2),func_23C7(var_02));
			continue;
		}

		self detach(getweaponmodel(var_03),func_23C7(var_02));
	}
}

//Function Number: 6
func_23C4()
{
	var_00 = [];
	foreach(var_02 in var_7B)
	{
		var_03 = func_23C0(var_02);
		if(var_03 == "none")
		{
			continue;
		}

		var_04 = 0;
		if(weapontype(var_03) == "riotshield" && isdefined(self.var_23C2))
		{
			var_04 = self.var_23C2;
		}

		var_05 = getweaponmodel(var_03,var_04);
		if(weapontype(var_03) == "riotshield")
		{
			self attach(var_05,func_23C7(var_02));
		}
		else
		{
			self attach(var_05,func_23C7(var_02),1);
		}

		var_06 = getweaponhidetags(var_03);
		var_07 = 0;
		while(var_07 < var_06.size)
		{
			self hidepart(var_06[var_07],var_05);
			var_07++ = var_7B[var_7B.size];
		}

		if(self.weaponinfo[var_03].var_209B && !self.weaponinfo[var_03].var_209A)
		{
			self hidepart("tag_clip");
		}
	}

	func_0CE0();
}

//Function Number: 7
func_0CE0()
{
	if(isdefined(self.var_23C5))
	{
		[[ self.var_23C5 ]]();
		return;
	}

	if(self.a.weaponpos["right"] == "none")
	{
		return;
	}

	if(func_23C6())
	{
		self laseron();
		return;
	}

	self laseroff();
}

//Function Number: 8
func_23C6()
{
	if(!self.a.var_CDF)
	{
		return 0;
	}

	if(animscripts/utility::func_CEA(self.weapon))
	{
		return 0;
	}

	return isalive(self);
}

//Function Number: 9
func_23C7(param_00)
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
func_23C8(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = self.weapon;
	}

	if(param_00 == "none")
	{
		return;
	}

	if(isdefined(self.nodrop))
	{
		return;
	}

	func_23C1();
	var_01 = self.weaponinfo[param_00].position;
	if(self.dropweapon && var_01 != "none")
	{
		thread func_23C9(param_00,var_01);
	}

	func_23BE(param_00);
	if(param_00 == self.weapon)
	{
		self.weapon = "none";
	}

	func_23C4();
}

//Function Number: 11
func_0D73()
{
	if(isdefined(self.nodrop))
	{
		return "none";
	}

	var_00 = [];
	func_23C1();
	foreach(var_02 in var_7B)
	{
		var_03 = self.a.weaponpos[var_02];
		if(var_03 == "none")
		{
			continue;
		}

		self.weaponinfo[var_03].position = "none";
		self.a.weaponpos[var_02] = "none";
		if(self.dropweapon)
		{
			thread func_23C9(var_03,var_02);
		}
	}

	self.weapon = "none";
	func_23C4();
}

//Function Number: 12
func_23C9(param_00,param_01)
{
	if(self isragdoll())
	{
		return "none";
	}

	self.a.var_20A4[param_01] = param_00;
	var_02 = param_00;
	if(issubstr(tolower(var_02),"rpg"))
	{
		var_02 = "rpg_player";
	}

	self dropweapon(var_02,param_01,0);
	self endon("end_weapon_drop_" + param_01);
	wait 0.1;
	if(!isdefined(self))
	{
		return;
	}

	func_23C1();
	self.a.var_20A4[param_01] = "none";
	func_23C4();
}

//Function Number: 13
donotetracks(param_00,param_01,param_02)
{
	for(;;)
	{
		self waittill(param_00,var_03);
		if(!isdefined(var_03))
		{
			var_03 = "undefined";
		}

		var_04 = animscripts/notetracks::func_23CA(var_03,param_00,param_01);
		if(isdefined(var_04))
		{
			return var_04;
		}
	}
}

//Function Number: 14
func_111C(param_00)
{
	if(!isdefined(self.var_CAB))
	{
		if(!isdefined(self.var_CB1))
		{
			return 0;
		}

		return func_23CE(self.var_CB1);
	}

	var_01 = self.var_CAB.origin + self.var_D81 * param_00;
	return func_23CE(var_01);
}

//Function Number: 15
func_10E9()
{
	if(!isdefined(self.var_CAB))
	{
		if(!isdefined(self.var_CB1))
		{
			return 0;
		}

		return func_23CE(self.var_CB1);
	}

	return func_23CE(self.var_CAB getshootatpos());
}

//Function Number: 16
func_23CB()
{
	var_00 = func_23CC();
	if(self.script == "cover_crouch" && isdefined(self.a.var_CF8) && self.a.var_CF8 == "lean")
	{
		var_00 = var_00 - level.var_CAD;
	}

	return var_00;
}

//Function Number: 17
func_23CC()
{
	if(!isdefined(self.var_CAB))
	{
		if(!isdefined(self.var_CB1))
		{
			return 0;
		}

		return animscripts/combat_utility::func_23B3(self.var_CB1);
	}

	return animscripts/combat_utility::func_23B3(self.var_CAB getshootatpos());
}

//Function Number: 18
func_0CB0()
{
	if(isdefined(self.var_23CD))
	{
		var_00 = self getmuzzlesideoffsetpos();
		return (var_00[0],var_00[1],self geteye()[2]);
	}

	return (self.origin[0],self.origin[1],self geteye()[2]);
}

//Function Number: 19
func_23CE(param_00)
{
	var_01 = animscripts/utility::func_113E(param_00);
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
func_0F90(param_00)
{
	self endon("killanimscript");
	func_23CF(param_00);
	self clearanim(%generic_aim_left,0.5);
	self clearanim(%generic_aim_right,0.5);
}

//Function Number: 21
func_23CF(param_00)
{
	self endon("rambo_aim_end");
	waittillframeend;
	self clearanim(%generic_aim_left,0.2);
	self clearanim(%generic_aim_right,0.2);
	self setanimlimited(%generic_aim_45l,1,0.2);
	self setanimlimited(%generic_aim_45r,1,0.2);
	var_01 = 0.2;
	var_02 = 0;
	for(;;)
	{
		if(isdefined(self.var_CB1))
		{
			var_03 = animscripts/utility::func_101A(self.var_CB1) - self.var_CAF.angles[1];
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

			self setanimlimited(%generic_aim_right,var_04,var_01);
			self setanimlimited(%generic_aim_left,0,var_01);
		}
		else
		{
			var_04 = var_02 / 45;
			if(var_04 > 1)
			{
				var_04 = 1;
			}

			self setanimlimited(%generic_aim_left,var_04,var_01);
			self setanimlimited(%generic_aim_right,0,var_01);
		}

		wait var_01;
	}
}

//Function Number: 22
func_237A()
{
	var_00 = 0;
	var_01 = weaponburstcount(self.weapon);
	if(var_01)
	{
		var_00 = var_01;
	}
	else if(animscripts/weaponlist::func_CCB())
	{
		var_00 = level.var_20DC[randomint(level.var_20DC.size)];
	}
	else if(self.var_CDB)
	{
		var_00 = level.var_20DB[randomint(level.var_20DB.size)];
	}
	else
	{
		var_00 = level.var_20DA[randomint(level.var_20DA.size)];
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
func_2379()
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
func_23D0(param_00,param_01)
{
}

//Function Number: 25
func_23D1(param_00)
{
	self endon("killanimscript");
	self endon("abort_reload");
	var_01 = undefined;
	if(self.weaponinfo[self.weapon].var_209B)
	{
		var_01 = getweaponclipmodel(self.weapon);
	}

	if(self.weaponinfo[self.weapon].var_209A)
	{
		if(animscripts/utility::func_C95())
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
			thread func_23D3(var_01,"tag_clip");
			self.weaponinfo[self.weapon].var_209A = 0;
			thread func_23D2(var_01);
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
					thread func_23D2(var_01,"tag_inhand");
				}
		
				animscripts/weaponlist::func_CD0();
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
					self.weaponinfo[self.weapon].var_209A = 1;
				}
		
				if(animscripts/utility::func_C95())
				{
					self playsound("weap_reload_pistol_clipin_npc");
				}
				else
				{
					self playsound("weap_reload_smg_clipin_npc");
				}
				self.a.var_114D = 0;
				break;
		}
	}
}

//Function Number: 26
func_23D2(param_00,param_01)
{
	self notify("clip_detached");
	self endon("clip_detached");
	common_scripts\utility::waittill_any("killanimscript","abort_reload");
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
		if(self.weapon != "none" && self.weaponinfo[self.weapon].position != "none")
		{
			self showpart("tag_clip");
		}

		self.weaponinfo[self.weapon].var_209A = 1;
		return;
	}

	if(isdefined(param_01))
	{
		func_23D3(param_00,param_01);
	}
}

//Function Number: 27
func_23D3(param_00,param_01)
{
	var_02 = spawn("script_model",self gettagorigin(param_01));
	var_02 setmodel(param_00);
	var_02.angles = self gettagangles(param_01);
	var_02 physicslaunchclient(var_02.origin,(0,0,0));
	wait 10;
	if(isdefined(var_02))
	{
		var_02 delete();
	}
}

//Function Number: 28
func_0F7C(param_00,param_01)
{
	self endon("killanimscript");
	var_02 = distancesquared(self.origin,param_00);
	if(var_02 < 1)
	{
		self safeteleport(param_00);
		return;
	}

	if(var_02 > 256 && !self maymovetopoint(param_00))
	{
		return;
	}

	self.keepclaimednodeifvalid = 1;
	var_03 = self.origin - param_00;
	var_04 = int(param_01 * 20);
	var_05 = var_03 * 1 / var_04;
	for(var_06 = 0;var_06 < var_04;var_06++)
	{
		var_03 = var_03 - var_05;
		self safeteleport(param_00 + var_03);
		wait 0.05;
	}

	self.keepclaimednodeifvalid = 0;
}

//Function Number: 29
func_23D4()
{
	return 1;
}

//Function Number: 30
func_0F93(param_00,param_01,param_02)
{
	if(!isdefined(param_02))
	{
		param_02 = ::func_23D4;
	}

	for(var_03 = 0;var_03 < param_01 * 10;var_03++)
	{
		if(isalive(self.enemy))
		{
			if(animscripts/utility::func_CE3() && [[ param_02 ]]())
			{
				return;
			}
		}

		if(animscripts/utility::func_F4C() && [[ param_02 ]]())
		{
			return;
		}

		self setanimknoball(param_00,%body,1,0.1);
		wait 0.1;
	}
}

//Function Number: 31
func_0F87(param_00)
{
	self endon("killanimscript");
	func_0C9B(self.secondaryweapon,"right");
	maps\_gameskill::didsomethingotherthanshooting();
}

//Function Number: 32
func_20A6()
{
	var_00 = func_23D6();
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

		if(!isdefined(var_01.enemy))
		{
			continue;
		}

		if(var_01.enemy != level.player)
		{
			continue;
		}

		if(isdefined(level.var_23D5) && level.var_23D5 == 0)
		{
			continue;
		}

		thread func_23D7();
		var_00--;
		if(var_00 <= 0)
		{
			return;
		}
	}
}

//Function Number: 33
func_23D6()
{
	var_00 = maps\_utility::getdifficulty();
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

//Function Number: 34
func_23D7()
{
	var_00 = missile_createrepulsorent(level.player,5000,800);
	wait 4;
	missile_deleteattractor(var_00);
}