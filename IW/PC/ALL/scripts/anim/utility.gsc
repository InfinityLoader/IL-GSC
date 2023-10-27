/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\anim\utility.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 83
 * Decompile Time: 4291 ms
 * Timestamp: 10/27/2023 12:01:10 AM
*******************************************************************/

//Function Number: 1
func_97CF(param_00)
{
	self method_806F(%body,0.3);
	self method_82A2(%body,1,0);
	if(param_00 != "pain" && param_00 != "death")
	{
		self.var_1491.var_10930 = "none";
	}

	self.var_1491.var_1A4B = 1;
	self.var_1491.var_1A4D = 1;
	self.var_1491.var_1A4C = 1;
	self.var_1491.var_1A4F = 0;
	self.var_1491.var_1A4E = 0;
	func_12EB9();
}

//Function Number: 2
func_12E5F()
{
	if(isdefined(self.var_5270) && self.var_5270 != self.var_1491.var_D6A5)
	{
		if(self.var_1491.var_D6A5 == "prone")
		{
			func_697B(0.5);
		}

		if(self.var_5270 == "prone")
		{
			self method_832B(-45,45,%prone_legs_down,%exposed_aiming,%prone_legs_up);
			func_662A(0.5);
			self method_82A5(func_B027("default_prone","straight_level"),%body,1,0.1,1);
		}
	}

	self.var_5270 = undefined;
}

//Function Number: 3
func_9832(param_00)
{
	if(getdvarint("ai_iw7",0) == 1)
	{
		self endon("killanimscript");
		self waittill("Hellfreezesover");
		return;
	}

	if(isdefined(self.var_AFE7))
	{
		if(param_00 != "pain" && param_00 != "death")
		{
			self method_81D0(self.origin);
		}

		if(param_00 != "pain")
		{
			self.var_AFE7 = undefined;
			self notify("kill_long_death");
		}
	}

	if(isdefined(self.var_1491.var_B4E7) && param_00 != "death")
	{
		self method_81D0(self.origin);
	}

	if(isdefined(self.var_1491.var_D707))
	{
		var_01 = self.var_1491.var_D707;
		self.var_1491.var_D707 = undefined;
		[[ var_01 ]](param_00);
	}

	if(param_00 != "combat" && param_00 != "pain" && param_00 != "death" && scripts\anim\utility_common::func_9FCA())
	{
		scripts\anim\combat::func_11380(func_B027("combat","pistol_to_primary"),1);
	}

	if(param_00 != "combat" && param_00 != "move" && param_00 != "pain")
	{
		self.var_1491.var_B168 = undefined;
	}

	if(param_00 != "death")
	{
		self.var_1491.var_C043 = 0;
	}

	if(isdefined(self.var_9E33) && param_00 == "pain" || param_00 == "death" || param_00 == "flashed")
	{
		scripts\anim\combat_utility::func_5D29();
	}

	self.var_9E33 = undefined;
	scripts\anim\squadmanager::func_1B0E(param_00);
	self.var_473C = undefined;
	self.var_112C8 = 0;
	self.var_9F21 = 0;
	self.var_3C60 = 0;
	self.var_1491.var_1A3E = undefined;
	self.var_1491.var_EF87 = gettime();
	self.var_1491.var_2411 = 0;
	if(isdefined(self.var_205) && self.var_205.type == "Conceal Prone" || self.var_205.type == "Conceal Crouch" || self.var_205.type == "Conceal Stand")
	{
		self.var_1491.var_2411 = 1;
	}

	func_97CF(param_00);
	func_12E5F();
}

//Function Number: 4
func_8097()
{
	if(isdefined(self.var_138DF) && self.var_138DF)
	{
		if(scripts\anim\utility_common::func_9F4F(self.var_D8E1))
		{
			return self.var_D8E1;
		}
		else if(scripts\anim\utility_common::func_9F4F(self.var_F0C4))
		{
			return self.var_F0C4;
		}
	}

	return self.var_D8E1;
}

//Function Number: 5
func_2758(param_00,param_01,param_02)
{
	for(var_03 = 0;var_03 < param_00 * 20;var_03++)
	{
		for(var_04 = 0;var_04 < 10;var_04++)
		{
			var_05 = (0,randomint(360),0);
			var_06 = anglestoforward(var_05);
			var_07 = var_06 * param_02;
		}

		wait(0.05);
	}
}

//Function Number: 6
func_D912()
{
	self endon("death");
	self notify("displaceprint");
	self endon("displaceprint");
	wait(0.05);
}

//Function Number: 7
func_9E40(param_00)
{
	if((!isdefined(param_00) || param_00) && self.var_29 > 1)
	{
		return 1;
	}

	if(isdefined(self.var_10C))
	{
		return 1;
	}

	return self.var_1491.var_4401 > gettime();
}

//Function Number: 8
func_12EB9()
{
	if(isdefined(self.var_10C))
	{
		self.var_1491.var_4401 = gettime() + level.var_4407 + randomint(level.var_4408);
	}
}

//Function Number: 9
func_824E(param_00,param_01)
{
	var_02 = self gettagangles(param_00)[1] - scripts\anim\utility_common::func_8249(param_01,self gettagorigin(param_00));
	var_02 = angleclamp180(var_02);
	return var_02;
}

//Function Number: 10
func_7EAD(param_00)
{
	var_01 = self gettagangles("TAG_EYE")[1] - scripts\common\utility::func_8246(param_00);
	var_01 = angleclamp180(var_01);
	return var_01;
}

//Function Number: 11
func_9F75(param_00)
{
	if(isdefined(self.var_473C))
	{
		return self.var_473C method_80B1(param_00);
	}

	return self method_81BF(param_00);
}

//Function Number: 12
func_3EF2(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = self.var_1491.var_D6A5;
	}

	switch(param_00)
	{
		case "stand":
			if(func_9F75("stand"))
			{
				var_01 = "stand";
			}
			else if(func_9F75("crouch"))
			{
				var_01 = "crouch";
			}
			else if(func_9F75("prone"))
			{
				var_01 = "prone";
			}
			else
			{
				var_01 = "stand";
			}
			break;

		case "crouch":
			if(func_9F75("crouch"))
			{
				var_01 = "crouch";
			}
			else if(func_9F75("stand"))
			{
				var_01 = "stand";
			}
			else if(func_9F75("prone"))
			{
				var_01 = "prone";
			}
			else
			{
				var_01 = "crouch";
			}
			break;

		case "prone":
			if(func_9F75("prone"))
			{
				var_01 = "prone";
			}
			else if(func_9F75("crouch"))
			{
				var_01 = "crouch";
			}
			else if(func_9F75("stand"))
			{
				var_01 = "stand";
			}
			else
			{
				var_01 = "prone";
			}
			break;

		default:
			var_01 = "stand";
			break;
	}

	return var_01;
}

//Function Number: 13
func_CEA8(param_00)
{
	if(isdefined(param_00))
	{
		self method_82E4("playAnim",param_00,%root,1,0.1,1);
		var_01 = getanimlength(param_00);
		var_01 = 3 * var_01 + 1;
		thread func_C15B("time is up","time is up",var_01);
		self waittill("time is up");
		self notify("enddrawstring");
	}
}

//Function Number: 14
func_C15B(param_00,param_01,param_02)
{
	self endon("death");
	self endon(param_01);
	wait(param_02);
	self notify(param_00);
}

//Function Number: 15
func_5B86(param_00)
{
	self endon("killanimscript");
	self endon("enddrawstring");
	wait(0.05);
}

//Function Number: 16
func_5B87(param_00,param_01,param_02,param_03)
{
	var_04 = param_03 * 20;
	for(var_05 = 0;var_05 < var_04;var_05++)
	{
		wait(0.05);
	}
}

//Function Number: 17
func_10136(param_00)
{
	self notify("got known enemy2");
	self endon("got known enemy2");
	self endon("death");
	if(!isdefined(self.var_10C))
	{
		return;
	}

	if(self.var_10C.team == "allies")
	{
		var_01 = (0.4,0.7,1);
	}
	else
	{
		var_01 = (1,0.7,0.4);
	}

	for(;;)
	{
		wait(0.05);
		if(!isdefined(self.var_1B2))
		{
			continue;
		}
	}
}

//Function Number: 18
func_8BED()
{
	if(isdefined(self.var_205))
	{
		return scripts\anim\utility_common::func_3908() || scripts\anim\utility_common::func_3918();
	}

	return scripts\anim\utility_common::func_3907() || scripts\anim\utility_common::func_3917();
}

//Function Number: 19
func_7E90()
{
	return self.var_8451;
}

//Function Number: 20
func_13123()
{
	if(!func_8BED())
	{
		return;
	}

	self.var_9332 = func_7E90();
	self.var_932D = self.origin;
}

//Function Number: 21
func_13122()
{
	if(!func_8BED())
	{
		return 0;
	}

	var_00 = self method_8142();
	var_01 = self method_815B() - var_00;
	if(isdefined(self.var_9332) && isdefined(self.var_932D))
	{
		if(distance(self.origin,self.var_932D) < 25)
		{
			return 0;
		}
	}

	self.var_9332 = undefined;
	var_02 = self method_8060(func_7E90(),var_01);
	if(!var_02)
	{
		self.var_9332 = func_7E90();
		return 0;
	}

	return 1;
}

//Function Number: 22
func_4F57()
{
	wait(5);
	self notify("timeout");
}

//Function Number: 23
func_4F4E(param_00,param_01,param_02)
{
	self endon("death");
	self notify("stop debug " + param_00);
	self endon("stop debug " + param_00);
	var_03 = spawnstruct();
	var_03 thread func_4F57();
	var_03 endon("timeout");
	if(self.var_10C.team == "allies")
	{
		var_04 = (0.4,0.7,1);
	}
	else
	{
		var_04 = (1,0.7,0.4);
	}

	wait(0.05);
}

//Function Number: 24
func_4F4D(param_00,param_01)
{
	thread func_4F4E(param_00,param_01,2.15);
}

//Function Number: 25
func_4F4F(param_00,param_01,param_02)
{
	thread func_4F4E(param_00,param_01,param_02);
}

//Function Number: 26
func_4F38(param_00,param_01)
{
	var_02 = param_00 / param_01;
	var_03 = undefined;
	if(param_00 == self.var_3250)
	{
		var_03 = "all rounds";
	}
	else if(var_02 < 0.25)
	{
		var_03 = "small burst";
	}
	else if(var_02 < 0.5)
	{
		var_03 = "med burst";
	}
	else
	{
		var_03 = "long burst";
	}

	thread func_4F4F(self.origin + (0,0,42),var_03,1.5);
	thread func_4F4D(self.origin + (0,0,60),"Suppressing");
}

//Function Number: 27
func_D91C()
{
	self endon("death");
	self notify("stop shoot " + self.var_6A0B);
	self endon("stop shoot " + self.var_6A0B);
	var_00 = 0.25;
	var_01 = var_00 * 20;
	for(var_02 = 0;var_02 < var_01;var_02 = var_02 + 1)
	{
		wait(0.05);
	}
}

//Function Number: 28
func_D91B()
{
}

//Function Number: 29
func_1011C(param_00,param_01,param_02,param_03)
{
	self endon("death");
	var_04 = param_03 * 20;
	for(var_05 = 0;var_05 < var_04;var_05 = var_05 + 1)
	{
		wait(0.05);
	}
}

//Function Number: 30
func_1011B(param_00,param_01,param_02,param_03)
{
	thread func_1011C(param_00,param_01 + (0,0,-5),param_02,param_03);
}

//Function Number: 31
func_FE9C(param_00)
{
	self.var_1491.var_A9ED = gettime();
	scripts\sp\_gameskill::func_F288();
	self notify("shooting");
	if(scripts\anim\utility_common::func_9D4D() && isdefined(self.var_2303.var_FECD) && isdefined(self.var_2303.var_FECD.var_D699))
	{
		self method_837B(1,self.var_2303.var_FECD.var_D699,1,0,1);
	}
	else
	{
		self method_837B(1,undefined,param_00);
	}
}

//Function Number: 32
func_FE9D(param_00)
{
	level notify("an_enemy_shot",self);
	func_FE9C(param_00);
}

//Function Number: 33
func_FED2(param_00,param_01)
{
	self.var_1491.var_A9ED = gettime();
	if(!isdefined(param_01))
	{
		param_01 = 1;
	}

	self notify("shooting");
	if(scripts\anim\utility_common::func_9D4D())
	{
		self method_837B(1,param_00,1,1,1);
	}
	else
	{
		var_02 = function_002C(self method_8142(),param_00,4);
		self method_837B(1,var_02,param_01);
	}
}

//Function Number: 34
func_11816()
{
	var_00 = spawn("script_model",(0,0,0));
	var_00 setmodel("temp");
	var_00.origin = self gettagorigin("tag_weapon_right") + (50,50,0);
	var_00.angles = self gettagangles("tag_weapon_right");
	var_01 = anglestoright(var_00.angles);
	var_01 = var_01 * 15;
	var_02 = anglestoforward(var_00.angles);
	var_02 = var_02 * 15;
	var_00 movegravity((0,50,150),100);
	var_03 = "weapon_" + self.var_394;
	var_04 = spawn(var_03,var_00.origin);
	var_04.angles = self gettagangles("tag_weapon_right");
	var_04 linkto(var_00);
	var_05 = var_00.origin;
	while(isdefined(var_04) && isdefined(var_04.origin))
	{
		var_06 = var_05;
		var_07 = var_00.origin;
		var_08 = vectortoangles(var_07 - var_06);
		var_02 = anglestoforward(var_08);
		var_02 = var_02 * 4;
		var_09 = bullettrace(var_07,var_07 + var_02,1,var_04);
		if(isalive(var_09["entity"]) && var_09["entity"] == self)
		{
			wait(0.05);
			continue;
		}

		if(var_09["fraction"] < 1)
		{
			break;
		}

		var_05 = var_00.origin;
		wait(0.05);
	}

	if(isdefined(var_04) && isdefined(var_04.origin))
	{
		var_04 unlink();
	}

	var_00 delete();
}

//Function Number: 35
func_CA76()
{
	var_00 = "TAG_EYE";
	self endon("death");
	self notify("stop personal effect");
	self endon("stop personal effect");
	while(isdefined(self))
	{
		wait(0.05);
		if(!isdefined(self))
		{
			break;
		}

		if(isdefined(self.var_1491.var_BCC8) && self.var_1491.var_BCC8 == "stop")
		{
			if(isdefined(self.var_9E45) && self.var_9E45 == 1)
			{
				continue;
			}

			playfxontag(level._effect["cold_breath"],self,var_00);
			wait(2.5 + randomfloat(3));
			continue;
		}

		wait(0.5);
	}
}

//Function Number: 36
func_CA78()
{
	self notify("stop personal effect");
}

//Function Number: 37
func_CA77()
{
	self endon("death");
	self notify("stop personal effect");
	self endon("stop personal effect");
	for(;;)
	{
		self waittill("spawned",var_00);
		if(scripts\sp\_utility::func_106ED(var_00))
		{
			continue;
		}

		var_00 thread func_CA76();
	}
}

//Function Number: 38
func_9ED4()
{
	if(self.var_2D5 <= self.var_112CE * 0.25)
	{
		return 0;
	}

	return self method_81C0();
}

//Function Number: 39
func_10137(param_00,param_01,param_02)
{
	for(;;)
	{
		wait(0.05);
		wait(0.05);
	}
}

//Function Number: 40
func_1E9D(param_00,param_01)
{
	var_02 = param_00.size;
	var_03 = randomint(var_02);
	if(var_02 == 1)
	{
		return param_00[0];
	}

	var_04 = 0;
	var_05 = 0;
	for(var_06 = 0;var_06 < var_02;var_06++)
	{
		var_05 = var_05 + param_01[var_06];
	}

	var_07 = randomfloat(var_05);
	var_08 = 0;
	for(var_06 = 0;var_06 < var_02;var_06++)
	{
		var_08 = var_08 + param_01[var_06];
		if(var_07 >= var_08)
		{
			continue;
		}

		var_03 = var_06;
		break;
	}

	return param_00[var_03];
}

//Function Number: 41
func_EB7E(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 500;
	}

	return gettime() - self.var_CA7E < param_00;
}

//Function Number: 42
func_3928()
{
	if(!self.var_162)
	{
		return 0;
	}

	if(self.var_EDB1)
	{
		return 1;
	}

	return isplayer(self.var_10C);
}

//Function Number: 43
func_13110()
{
	return function_0246(self.var_394);
}

//Function Number: 44
func_DCA3(param_00)
{
	var_01 = randomint(param_00.size);
	if(param_00.size > 1)
	{
		var_02 = 0;
		for(var_03 = 0;var_03 < param_00.size;var_03++)
		{
			var_02 = var_02 + param_00[var_03];
		}

		var_04 = randomfloat(var_02);
		var_02 = 0;
		for(var_03 = 0;var_03 < param_00.size;var_03++)
		{
			var_02 = var_02 + param_00[var_03];
			if(var_04 < var_02)
			{
				var_01 = var_03;
				break;
			}
		}
	}

	return var_01;
}

//Function Number: 45
func_F715(param_00,param_01,param_02)
{
	if(!isdefined(level.var_C6BD))
	{
		anim.var_C6BD = [];
	}

	level.var_C6BD[param_01] = 1;
	level._effect["step_" + param_01][param_00] = param_02;
}

//Function Number: 46
func_F716(param_00,param_01,param_02)
{
	if(!isdefined(level.var_C6BF))
	{
		anim.var_C6BF = [];
	}

	level.var_C6BF[param_01] = 1;
	level._effect["step_small_" + param_01][param_00] = param_02;
}

//Function Number: 47
func_12CBF(param_00)
{
	if(isdefined(level.var_C6BD))
	{
		level.var_C6BD[param_00] = undefined;
	}

	level._effect["step_" + param_00] = undefined;
}

//Function Number: 48
func_12CC0(param_00)
{
	if(isdefined(level.var_C6BF))
	{
		level.var_C6BF[param_00] = undefined;
	}

	level._effect["step_small_" + param_00] = undefined;
}

//Function Number: 49
func_F7B9(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(!isdefined(param_02))
	{
		param_02 = "all";
	}

	if(!isdefined(level.var_1359))
	{
		level.var_1359 = [];
	}

	level.var_1359[param_00][param_02] = spawnstruct();
	level.var_1359[param_00][param_02].var_2DD = param_01;
	level.var_1359[param_00][param_02].var_7542 = param_03;
	func_F7BA(param_00,param_02,param_04,param_05);
}

//Function Number: 50
func_F7BA(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_01))
	{
		param_01 = "all";
	}

	if(!isdefined(level.var_1359))
	{
		level.var_1359 = [];
	}

	if(isdefined(level.var_1359[param_00][param_01]))
	{
		var_04 = level.var_1359[param_00][param_01];
	}
	else
	{
		var_04 = spawnstruct();
		level.var_1359[param_00][param_01] = var_04;
	}

	if(isdefined(param_02))
	{
		var_04.var_1046D = param_02;
	}

	if(isdefined(param_03))
	{
		var_04.var_10470 = param_03;
	}
}

//Function Number: 51
func_662A(param_00)
{
	thread func_662B(param_00);
}

//Function Number: 52
func_662B(param_00)
{
	self endon("death");
	self notify("anim_prone_change");
	self endon("anim_prone_change");
	self method_80DF(param_00,isdefined(self.var_1491.var_C4C8));
	self waittill("killanimscript");
	if(self.var_1491.var_D6A5 != "prone" && !isdefined(self.var_1491.var_C4C8))
	{
		self.var_1491.var_D6A5 = "prone";
	}
}

//Function Number: 53
func_697B(param_00)
{
	thread func_697C(param_00);
}

//Function Number: 54
func_697C(param_00)
{
	self endon("death");
	self notify("anim_prone_change");
	self endon("anim_prone_change");
	self method_80E0(param_00);
	self waittill("killanimscript");
	if(self.var_1491.var_D6A5 == "prone")
	{
		self.var_1491.var_D6A5 = "crouch";
	}
}

//Function Number: 55
func_3875()
{
	if(self.var_1491.var_2411)
	{
		return 0;
	}

	if(!scripts\anim\weaponlist::func_1310F())
	{
		return 0;
	}

	if(weaponclass(self.var_394) == "mg")
	{
		return 0;
	}

	if(isdefined(self.var_5507) && self.var_5507 == 1)
	{
		return 0;
	}

	return 1;
}

//Function Number: 56
func_38C0()
{
	if(!func_8BED())
	{
		return 0;
	}

	var_00 = self method_8142();
	return sighttracepassed(var_00,func_7E90(),0,undefined);
}

//Function Number: 57
func_7FCC(param_00)
{
	return self.var_1491.var_BCA5[param_00];
}

//Function Number: 58
func_DCA6(param_00,param_01)
{
	if(randomint(2))
	{
		return param_00;
	}

	return param_01;
}

//Function Number: 59
func_1F64(param_00)
{
	return self.var_1491.var_2274[param_00];
}

//Function Number: 60
func_1F65(param_00)
{
	return isdefined(self.var_1491.var_2274[param_00]) && self.var_1491.var_2274[param_00].size > 0;
}

//Function Number: 61
func_1F67(param_00)
{
	var_01 = randomint(self.var_1491.var_2274[param_00].size);
	return self.var_1491.var_2274[param_00][var_01];
}

//Function Number: 62
func_2274(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B,param_0C,param_0D)
{
	var_0E = [];
	if(isdefined(param_00))
	{
		var_0E[0] = param_00;
	}
	else
	{
		return var_0E;
	}

	if(isdefined(param_01))
	{
		var_0E[1] = param_01;
	}
	else
	{
		return var_0E;
	}

	if(isdefined(param_02))
	{
		var_0E[2] = param_02;
	}
	else
	{
		return var_0E;
	}

	if(isdefined(param_03))
	{
		var_0E[3] = param_03;
	}
	else
	{
		return var_0E;
	}

	if(isdefined(param_04))
	{
		var_0E[4] = param_04;
	}
	else
	{
		return var_0E;
	}

	if(isdefined(param_05))
	{
		var_0E[5] = param_05;
	}
	else
	{
		return var_0E;
	}

	if(isdefined(param_06))
	{
		var_0E[6] = param_06;
	}
	else
	{
		return var_0E;
	}

	if(isdefined(param_07))
	{
		var_0E[7] = param_07;
	}
	else
	{
		return var_0E;
	}

	if(isdefined(param_08))
	{
		var_0E[8] = param_08;
	}
	else
	{
		return var_0E;
	}

	if(isdefined(param_09))
	{
		var_0E[9] = param_09;
	}
	else
	{
		return var_0E;
	}

	if(isdefined(param_0A))
	{
		var_0E[10] = param_0A;
	}
	else
	{
		return var_0E;
	}

	if(isdefined(param_0B))
	{
		var_0E[11] = param_0B;
	}
	else
	{
		return var_0E;
	}

	if(isdefined(param_0C))
	{
		var_0E[12] = param_0C;
	}
	else
	{
		return var_0E;
	}

	if(isdefined(param_0D))
	{
		var_0E[13] = param_0D;
	}

	return var_0E;
}

//Function Number: 63
func_7DA9()
{
	return self.var_D8E1;
}

//Function Number: 64
func_7DAB()
{
	return self.var_F0C4;
}

//Function Number: 65
func_7DAC()
{
	return self.var_101B4;
}

//Function Number: 66
func_7DA1()
{
	return self.var_394;
}

//Function Number: 67
func_7DA2()
{
	if(self.var_394 == self.var_D8E1)
	{
		return "primary";
	}

	if(self.var_394 == self.var_F0C4)
	{
		return "secondary";
	}

	if(self.var_394 == self.var_101B4)
	{
		return "sidearm";
	}
}

//Function Number: 68
func_1A18(param_00)
{
	if(isdefined(self.var_39B[param_00]))
	{
		return 1;
	}

	return 0;
}

//Function Number: 69
func_7DC6(param_00)
{
	var_01 = getmovedelta(param_00,0,1);
	return self method_81E7(var_01);
}

//Function Number: 70
func_10000(param_00)
{
	return isdefined(self.var_F0C4) && self.var_F0C4 != "none" && param_00 < squared(512) || self.var_1491.var_E5DE < 1;
}

//Function Number: 71
func_DC1F(param_00)
{
	self endon("killanimscript");
	var_01 = self.origin;
	var_02 = (0,0,0);
	for(;;)
	{
		wait(0.05);
		var_03 = distance(self.origin,var_01);
		var_01 = self.origin;
		if(self.health == 1)
		{
			self.var_1491.var_C043 = 1;
			self method_839A();
			self method_806F(param_00,0.1);
			wait(0.05);
			physicsexplosionsphere(var_01,600,0,var_03 * 0.1);
			self notify("killanimscript");
			return;
		}
	}
}

//Function Number: 72
func_FFDB()
{
	return func_9D9B() && !isdefined(self.var_15F);
}

//Function Number: 73
func_9D9B()
{
	return isdefined(self.var_51E3) && self.var_51E3 == "cqb";
}

//Function Number: 74
func_9D9C()
{
	return !self.var_12A || func_9D9B();
}

//Function Number: 75
func_DCB7()
{
	self.var_1491.var_92F9 = randomint(2);
}

//Function Number: 76
func_80BD(param_00,param_01)
{
	var_02 = param_00 % level.var_DCB3;
	return level.var_DCB2[var_02] % param_01;
}

//Function Number: 77
func_7E52()
{
	if(scripts\anim\utility_common::func_9FC8())
	{
		return "secondary";
	}

	if(scripts\anim\utility_common::func_9FCA())
	{
		return "sidearm";
	}

	return "primary";
}

//Function Number: 78
func_B027(param_00,param_01)
{
	if(isdefined(self.var_1F62))
	{
		if(isdefined(level.var_2128[self.var_1F62][param_00]) && isdefined(level.var_2128[self.var_1F62][param_00][param_01]))
		{
			return level.var_2128[self.var_1F62][param_00][param_01];
		}
	}

	return level.var_2128["soldier"][param_00][param_01];
}

//Function Number: 79
func_B028(param_00)
{
	if(isdefined(self.var_1F62))
	{
		if(isdefined(level.var_2128[self.var_1F62][param_00]))
		{
			var_01 = level.var_2128["soldier"][param_00];
			foreach(var_04, var_03 in level.var_2128[self.var_1F62][param_00])
			{
				var_01[var_04] = var_03;
			}

			return var_01;
		}
	}

	return level.var_2128["soldier"][var_04];
}

//Function Number: 80
func_B031(param_00,param_01,param_02)
{
	if(isdefined(self.var_1F62))
	{
		if(isdefined(level.var_2128[self.var_1F62][param_00]) && isdefined(level.var_2128[self.var_1F62][param_00][param_01]) && isdefined(level.var_2128[self.var_1F62][param_00][param_01][param_02]))
		{
			return level.var_2128[self.var_1F62][param_00][param_01][param_02];
		}
	}

	return level.var_2128["soldier"][param_00][param_01][param_02];
}

//Function Number: 81
func_B02B(param_00,param_01)
{
	if(isdefined(self.var_1F62))
	{
		if(isdefined(level.var_2128[self.var_1F62][param_00]) && isdefined(level.var_2128[self.var_1F62][param_00][param_01]))
		{
			return level.var_2128[self.var_1F62][param_00][param_01];
		}
	}

	return level.var_2128["dog"][param_00][param_01];
}

//Function Number: 82
func_13142(param_00,param_01,param_02)
{
}

//Function Number: 83
func_9DDB(param_00)
{
	return function_02D4(param_00);
}