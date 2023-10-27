/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\utility.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 132
 * Decompile Time: 2211 ms
 * Timestamp: 10/27/2023 2:18:57 AM
*******************************************************************/

//Function Number: 1
func_2479(param_00)
{
	self clearanim(%body,0.3);
	self setanim(%body,1,0);
	if(param_00 != "pain" && param_00 != "death")
	{
		self.a.var_D19 = "none";
	}

	self.var_247A = 0;
	self.a.var_CC3 = 1;
	self.a.var_CC5 = 1;
	self.a.var_CC6 = 1;
	self.a.var_CC7 = 0;
	self.a.var_CC8 = 0;
	func_0A69();
}

//Function Number: 2
func_247B()
{
	if(isdefined(self.desired_anim_pose) && self.desired_anim_pose != self.a.pose)
	{
		if(self.a.pose == "prone")
		{
			func_0F7D(0.5);
		}

		if(self.desired_anim_pose == "prone")
		{
			self setproneanimnodes(-45,45,%prone_legs_down,%exposed_aiming,%prone_legs_up);
			func_10E1(0.5);
			self setanimknoball(%prone_aim_5,%body,1,0.1,1);
		}
	}

	self.desired_anim_pose = undefined;
}

//Function Number: 3
func_0D15(param_00)
{
	if(isdefined(self.var_D0F))
	{
		if(param_00 != "pain" && param_00 != "death")
		{
			self kill(self.origin);
		}

		if(param_00 != "pain")
		{
			self.var_D0F = undefined;
			self notify("kill_long_death");
		}
	}

	if(isdefined(self.a.var_D6A) && param_00 != "death")
	{
		self kill(self.origin);
	}

	if(isdefined(self.a.var_20AD))
	{
		var_01 = self.a.var_20AD;
		self.a.var_20AD = undefined;
		[[ var_01 ]](param_00);
	}

	if(param_00 != "combat" && param_00 != "pain" && param_00 != "death" && func_0C95())
	{
		animscripts/combat::func_1159(%pistol_stand_switch,1);
	}

	if(param_00 != "combat" && param_00 != "move" && param_00 != "pain")
	{
		self.a.var_1111 = undefined;
	}

	if(param_00 != "death")
	{
		self.a.var_D55 = 0;
	}

	if(isdefined(self.var_23A0) && param_00 == "pain" || param_00 == "death" || param_00 == "flashed")
	{
		animscripts/combat_utility::func_23AA();
	}

	self.var_23A0 = undefined;
	animscripts/squadmanager::func_A96(param_00);
	self.var_CAF = undefined;
	self.var_A9D = 0;
	self.var_F53 = 0;
	self.var_CDD = 0;
	self.a.aimidlethread = undefined;
	self.a.var_1019 = gettime();
	self.a.var_CE2 = 0;
	if(isdefined(self.node) && self.node.type == "Conceal Prone" || self.node.type == "Conceal Crouch" || self.node.type == "Conceal Stand")
	{
		self.a.var_CE2 = 1;
	}

	func_2479(param_00);
	func_247B();
}

//Function Number: 4
func_23F1()
{
	if(isdefined(self.wantshotgun) && self.wantshotgun)
	{
		if(func_0CEA(self.primaryweapon))
		{
			return self.primaryweapon;
		}
		else if(func_0CEA(self.secondaryweapon))
		{
			return self.secondaryweapon;
		}
	}

	return self.primaryweapon;
}

//Function Number: 5
func_247D(param_00,param_01,param_02)
{
	for(var_03 = 0;var_03 < param_00 * 20;var_03++)
	{
		for(var_04 = 0;var_04 < 10;var_04++)
		{
			var_05 = (0,randomint(360),0);
			var_06 = anglestoforward(var_05);
			var_07 = var_06 * param_02;
		}

		wait 0.05;
	}
}

//Function Number: 6
func_247E()
{
	self endon("death");
	self notify("displaceprint");
	self endon("displaceprint");
	wait 0.05;
}

//Function Number: 7
func_0A69()
{
	if(self.var_74B > 1)
	{
		return 1;
	}

	if(isdefined(self.enemy))
	{
		self.a.var_20A9 = gettime() + level.var_20CA + randomint(level.var_20CB);
		return 1;
	}

	return self.a.var_20A9 > gettime();
}

//Function Number: 8
func_0FB8()
{
	if(isdefined(self.enemy))
	{
		self.a.var_247F = self.enemy getshootatpos();
		self.a.var_20AA = gettime();
		return self.a.var_247F;
	}

	if(isdefined(self.a.var_20AA) && isdefined(self.a.var_247F) && self.a.var_20AA + 3000 < gettime())
	{
		return self.a.var_247F;
	}

	var_00 = self getshootatpos();
	var_00 = var_00 + (196 * self.var_70F[0],196 * self.var_70F[1],196 * self.var_70F[2]);
	return var_00;
}

//Function Number: 9
func_0F41(param_00)
{
	if(!isdefined(self.heat))
	{
		if(param_00.type == "Cover Left")
		{
			return param_00.angles[1] + 90;
		}
		else if(param_00.type == "Cover Right")
		{
			return param_00.angles[1] - 90;
		}
	}

	return param_00.angles[1];
}

//Function Number: 10
func_2480(param_00)
{
	if(isdefined(self.node))
	{
		var_01 = self.node.angles[1] - func_101A(param_00);
	}
	else
	{
		var_01 = self.angles[1] - func_101A(var_01);
	}

	var_01 = angleclamp180(var_01);
	return var_01;
}

//Function Number: 11
func_116D()
{
	var_00 = undefined;
	if(isdefined(self.enemy))
	{
		var_00 = self.enemy.origin;
	}
	else
	{
		if(isdefined(self.node))
		{
			var_01 = anglestoforward(self.node.angles);
		}
		else
		{
			var_01 = anglestoforward(self.angles);
		}

		var_01 = var_01 * 150;
		var_00 = self.origin + var_01;
	}

	if(isdefined(self.node))
	{
		var_02 = self.node.angles[1] - func_101A(var_00);
	}
	else
	{
		var_02 = self.angles[1] - func_101A(var_02);
	}

	var_02 = angleclamp180(var_02);
	return var_02;
}

//Function Number: 12
func_113E(param_00)
{
	var_01 = self.angles[1] - func_101A(param_00);
	var_01 = angleclamp180(var_01);
	return var_01;
}

//Function Number: 13
func_0D5C()
{
	var_00 = undefined;
	if(isdefined(self.enemy))
	{
		var_00 = self.enemy.origin;
	}
	else
	{
		var_01 = anglestoforward(self.angles);
		var_01 = var_01 * 150;
		var_00 = self.origin + var_01;
	}

	var_02 = self.angles[1] - func_101A(var_00);
	var_02 = angleclamp180(var_02);
	return var_02;
}

//Function Number: 14
func_101A(param_00)
{
	return vectortoyaw(param_00 - self.origin);
}

//Function Number: 15
func_2481(param_00)
{
	var_01 = vectortoangles((param_00[0],param_00[1],0) - (self.origin[0],self.origin[1],0));
	return var_01[1];
}

//Function Number: 16
func_2482()
{
	var_00 = self.angles[1] - func_101A(self.enemy.origin);
	var_00 = angleclamp180(var_00);
	if(var_00 < 0)
	{
		var_00 = -1 * var_00;
	}

	return var_00;
}

//Function Number: 17
func_2483()
{
	var_00 = self.angles[1] - func_2481(self.enemy.origin);
	var_00 = angleclamp180(var_00);
	if(var_00 < 0)
	{
		var_00 = -1 * var_00;
	}

	return var_00;
}

//Function Number: 18
func_2484(param_00)
{
	var_01 = self.angles[1] - func_101A(param_00);
	var_01 = angleclamp180(var_01);
	if(var_01 < 0)
	{
		var_01 = -1 * var_01;
	}

	return var_01;
}

//Function Number: 19
func_2485(param_00)
{
	var_01 = self.angles[1] - param_00;
	var_01 = angleclamp180(var_01);
	if(var_01 < 0)
	{
		var_01 = -1 * var_01;
	}

	return var_01;
}

//Function Number: 20
func_2486(param_00,param_01)
{
	var_02 = vectortoangles(param_00 - param_01);
	return var_02[1];
}

//Function Number: 21
func_2487(param_00,param_01)
{
	var_02 = self gettagangles(param_00)[1] - func_2486(param_01,self gettagorigin(param_00));
	var_02 = angleclamp180(var_02);
	return var_02;
}

//Function Number: 22
func_244F(param_00)
{
	var_01 = self.angles[1] - func_101A(param_00);
	var_01 = angleclamp180(var_01);
	return var_01;
}

//Function Number: 23
func_2488(param_00)
{
	var_01 = self gettagangles("TAG_EYE")[1] - func_101A(param_00);
	var_01 = angleclamp180(var_01);
	return var_01;
}

//Function Number: 24
func_2489(param_00)
{
	if(isdefined(self.var_CAF))
	{
		return self.var_CAF doesnodeallowstance(param_00);
	}

	return self isstanceallowed(param_00);
}

//Function Number: 25
func_10AF(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = self.a.pose;
	}

	switch(param_00)
	{
		case "stand":
			if(func_2489("stand"))
			{
				var_01 = "stand";
			}
			else if(func_2489("crouch"))
			{
				var_01 = "crouch";
			}
			else if(func_2489("prone"))
			{
				var_01 = "prone";
			}
			else
			{
				var_01 = "stand";
			}
			break;

		case "crouch":
			if(func_2489("crouch"))
			{
				var_01 = "crouch";
			}
			else if(func_2489("stand"))
			{
				var_01 = "stand";
			}
			else if(func_2489("prone"))
			{
				var_01 = "prone";
			}
			else
			{
				var_01 = "crouch";
			}
			break;

		case "prone":
			if(func_2489("prone"))
			{
				var_01 = "prone";
			}
			else if(func_2489("crouch"))
			{
				var_01 = "crouch";
			}
			else if(func_2489("stand"))
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

//Function Number: 26
func_0BEE()
{
	var_00 = self.node;
	if(isdefined(var_00) && self nearnode(var_00) || isdefined(self.var_CAF) && var_00 == self.var_CAF)
	{
		return var_00;
	}

	return undefined;
}

//Function Number: 27
func_248A()
{
	var_00 = func_0BEE();
	if(isdefined(var_00))
	{
		return var_00.type;
	}

	return "none";
}

//Function Number: 28
func_2472()
{
	var_00 = func_0BEE();
	if(isdefined(var_00))
	{
		return var_00.angles[1];
	}

	return self.var_72B;
}

//Function Number: 29
func_248B()
{
	var_00 = func_0BEE();
	if(isdefined(var_00))
	{
		return anglestoforward(var_00.angles);
	}

	return anglestoforward(self.angles);
}

//Function Number: 30
func_2473()
{
	var_00 = func_0BEE();
	if(isdefined(var_00))
	{
		return var_00.origin;
	}

	return self.origin;
}

//Function Number: 31
func_0D08(param_00,param_01)
{
	var_02 = int(param_00) % param_01;
	var_02 = var_02 + param_01;
	return var_02 % param_01;
}

//Function Number: 32
func_0D61(param_00)
{
	return abs(angleclamp180(param_00));
}

//Function Number: 33
func_0FFC(param_00)
{
	var_01 = cos(param_00);
	var_02 = sin(param_00);
	var_03["front"] = 0;
	if(isdefined(self.alwaysrunforward))
	{
		return var_7B;
	}

	if(var_02 > 0)
	{
		if(var_03 > var_02)
		{
		}
		else if(var_03 < -1 * var_02)
		{
		}
		else
		{
		}
	}
	else
	{
		var_04 = -1 * var_02;
		if(var_03 > var_04)
		{
			var_7B["left"] = 1;
		}
		else if(var_03 < var_02)
		{
			var_7B["right"] = 1;
		}
		else
		{
			var_7B["back"] = 1;
		}
	}

	return var_7B;
}

//Function Number: 34
func_243A(param_00)
{
	param_00 = angleclamp(param_00);
	if(param_00 < 45 || param_00 > 315)
	{
		var_01 = "front";
	}
	else if(var_01 < 135)
	{
		var_01 = "left";
	}
	else if(var_01 < 225)
	{
		var_01 = "back";
	}
	else
	{
		var_01 = "right";
	}

	return var_01;
}

//Function Number: 35
func_248C(param_00,param_01)
{
	for(var_02 = param_01.size - 1;var_02 >= 0;var_02--)
	{
		if(param_00 == param_01[var_02])
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 36
func_248D(param_00)
{
	if(isdefined(param_00))
	{
		self setflaggedanimknoballrestart("playAnim",param_00,%root,1,0.1,1);
		var_01 = getanimlength(param_00);
		var_01 = 3 * var_01 + 1;
		thread func_248E("time is up","time is up",var_01);
		self waittill("time is up");
		self notify("enddrawstring");
	}
}

//Function Number: 37
func_248E(param_00,param_01,param_02)
{
	self endon("death");
	self endon(param_01);
	wait param_02;
	self notify(param_00);
}

//Function Number: 38
func_248F(param_00)
{
	self endon("killanimscript");
	self endon("enddrawstring");
	wait 0.05;
}

//Function Number: 39
func_2490(param_00,param_01,param_02,param_03)
{
	var_04 = param_03 * 20;
	for(var_05 = 0;var_05 < var_04;var_05++)
	{
		wait 0.05;
	}
}

//Function Number: 40
func_2491(param_00)
{
	self notify("got known enemy2");
	self endon("got known enemy2");
	self endon("death");
	if(!isdefined(self.enemy))
	{
		return;
	}

	if(self.enemy.team == "allies")
	{
		var_01 = (0.4,0.7,1);
	}
	else
	{
		var_01 = (1,0.7,0.4);
	}

	for(;;)
	{
		wait 0.05;
		if(!isdefined(self.lastenemysightpos))
		{
			continue;
		}
	}
}

//Function Number: 41
func_0F8C()
{
	if(isdefined(self.node))
	{
		return func_0F4A() || func_0F39();
	}

	return func_0CE3() || func_0CF3();
}

//Function Number: 42
func_0CEE()
{
	return self.goodshootpos;
}

//Function Number: 43
func_2492()
{
	if(!func_0F8C())
	{
		return;
	}

	self.var_2493 = func_0CEE();
	self.var_2494 = self.origin;
}

//Function Number: 44
func_2495()
{
	if(!func_0F8C())
	{
		return 0;
	}

	var_00 = self getmuzzlepos();
	var_01 = self getshootatpos() - var_00;
	if(isdefined(self.var_2493) && isdefined(self.var_2494))
	{
		if(distance(self.origin,self.var_2494) < 25)
		{
			return 0;
		}
	}

	self.var_2493 = undefined;
	var_02 = self canshoot(func_0CEE(),var_01);
	if(!var_02)
	{
		self.var_2493 = func_0CEE();
		return 0;
	}

	return 1;
}

//Function Number: 45
func_2496()
{
	wait 5;
	self notify("timeout");
}

//Function Number: 46
func_2497(param_00,param_01,param_02)
{
	self endon("death");
	self notify("stop debug " + param_00);
	self endon("stop debug " + param_00);
	var_03 = spawnstruct();
	var_03 thread func_2496();
	var_03 endon("timeout");
	if(self.enemy.team == "allies")
	{
		var_04 = (0.4,0.7,1);
	}
	else
	{
		var_04 = (1,0.7,0.4);
	}

	wait 0.05;
}

//Function Number: 47
func_2498(param_00,param_01)
{
	thread func_2497(param_00,param_01,2.15);
}

//Function Number: 48
func_2499(param_00,param_01,param_02)
{
	thread func_2497(param_00,param_01,param_02);
}

//Function Number: 49
func_249A(param_00,param_01)
{
	var_02 = param_00 / param_01;
	var_03 = undefined;
	if(param_00 == self.bulletsinclip)
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

	thread func_2499(self.origin + (0,0,42),var_03,1.5);
	thread func_2498(self.origin + (0,0,60),"Suppressing");
}

//Function Number: 50
func_249B()
{
	self endon("death");
	self notify("stop shoot " + self.export);
	self endon("stop shoot " + self.export);
	var_00 = 0.25;
	var_01 = var_00 * 20;
	for(var_02 = 0;var_02 < var_01;var_02 = var_02 + 1)
	{
		wait 0.05;
	}
}

//Function Number: 51
func_249C()
{
}

//Function Number: 52
func_249D(param_00,param_01,param_02,param_03)
{
	self endon("death");
	var_04 = param_03 * 20;
	for(var_05 = 0;var_05 < var_04;var_05 = var_05 + 1)
	{
		wait 0.05;
	}
}

//Function Number: 53
func_249E(param_00,param_01,param_02,param_03)
{
	thread func_249D(param_00,param_01 + (0,0,-5),param_02,param_03);
}

//Function Number: 54
func_0D5F()
{
	[[ level.var_20D4 ]]();
}

//Function Number: 55
func_249F()
{
	self.a.lastshoottime = gettime();
	maps\_gameskill::set_accuracy_based_on_situation();
	self notify("shooting");
	self shoot();
}

//Function Number: 56
func_20D3()
{
	level notify("an_enemy_shot",self);
	func_249F();
}

//Function Number: 57
func_2384(param_00)
{
	var_01 = bulletspread(self getmuzzlepos(),param_00,4);
	self.a.lastshoottime = gettime();
	self notify("shooting");
	self shoot(1,var_01);
}

//Function Number: 58
func_24A0()
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
	var_03 = "weapon_" + self.weapon;
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
			wait 0.05;
			continue;
		}

		if(var_09["fraction"] < 1)
		{
			break;
		}

		var_05 = var_00.origin;
		wait 0.05;
	}

	if(isdefined(var_04) && isdefined(var_04.origin))
	{
		var_04 unlink();
	}

	var_00 delete();
}

//Function Number: 59
func_20CC(param_00)
{
	level.var_10FA["stand"]["in"] = %casual_stand_idle_trans_in;
	level.var_1100["stand"][0][0] = %casual_stand_idle;
	level.var_1100["stand"][0][1] = %casual_stand_idle_twitch;
	level.var_1100["stand"][0][2] = %casual_stand_idle_twitchb;
	level.var_1101["stand"][0][0] = 2;
	level.var_1101["stand"][0][1] = 1;
	level.var_1101["stand"][0][2] = 1;
	level.var_1100["stand"][1][0] = %casual_stand_v2_idle;
	level.var_1100["stand"][1][1] = %casual_stand_v2_twitch_radio;
	level.var_1100["stand"][1][2] = %casual_stand_v2_twitch_shift;
	level.var_1100["stand"][1][3] = %casual_stand_v2_twitch_talk;
	level.var_1101["stand"][1][0] = 10;
	level.var_1101["stand"][1][1] = 4;
	level.var_1101["stand"][1][2] = 7;
	level.var_1101["stand"][1][3] = 4;
	level.var_1100["stand_cqb"][0][0] = %cqb_stand_idle;
	level.var_1100["stand_cqb"][0][1] = %cqb_stand_twitch;
	level.var_1101["stand_cqb"][0][0] = 2;
	level.var_1101["stand_cqb"][0][1] = 1;
	level.var_10FA["crouch"]["in"] = %casual_crouch_idle_in;
	level.var_1100["crouch"][0][0] = %casual_crouch_idle;
	level.var_1101["crouch"][0][0] = 6;
}

//Function Number: 60
func_24A1()
{
	var_00 = "TAG_EYE";
	self endon("death");
	self notify("stop personal effect");
	self endon("stop personal effect");
	while(isdefined(self))
	{
		wait 0.05;
		if(!isdefined(self))
		{
			break;
		}

		if(isdefined(self.a.movement) && self.a.movement == "stop")
		{
			if(isdefined(self.var_1097) && self.var_1097 == 1)
			{
				continue;
			}

			playfxontag(level._effect["cold_breath"],self,var_00);
			wait 2.5 + randomfloat(3);
			continue;
		}

		wait 0.5;
	}
}

//Function Number: 61
func_24A2()
{
	self notify("stop personal effect");
}

//Function Number: 62
func_24A3()
{
	self endon("death");
	self notify("stop personal effect");
	self endon("stop personal effect");
	for(;;)
	{
		self waittill("spawned",var_00);
		if(maps\_utility::spawn_failed(var_00))
		{
			continue;
		}

		var_00 thread func_24A1();
	}
}

//Function Number: 63
func_0F4C()
{
	if(isdefined(self.forcesuppression))
	{
		return self.forcesuppression;
	}

	if(self.var_738 <= self.var_CFB)
	{
		return 0;
	}

	return self issuppressed();
}

//Function Number: 64
func_0F62()
{
	if(self.var_738 <= self.var_CFB * 0.25)
	{
		return 0;
	}

	return self issuppressed();
}

//Function Number: 65
func_0F8E(param_00)
{
	if(isdefined(param_00.offset))
	{
		return param_00.offset;
	}

	var_01 = (-26,0.4,36);
	var_02 = (-32,7,63);
	var_03 = (43.5,11,36);
	var_04 = (36,8.3,63);
	var_05 = (3.5,-12.5,45);
	var_06 = (-3.7,-22,63);
	var_07 = 0;
	var_08 = (0,0,0);
	var_09 = anglestoright(param_00.angles);
	var_0A = anglestoforward(param_00.angles);
	switch(param_00.type)
	{
		case "Cover Left":
			if(param_00 gethighestnodestance() == "crouch")
			{
				var_08 = func_24A5(var_09,var_0A,var_01);
			}
			else
			{
				var_08 = func_24A5(var_09,var_0A,var_02);
			}
			break;

		case "Cover Right":
			if(param_00 gethighestnodestance() == "crouch")
			{
				var_08 = func_24A5(var_09,var_0A,var_03);
			}
			else
			{
				var_08 = func_24A5(var_09,var_0A,var_04);
			}
			break;

		case "Turret":
		case "Cover Stand":
		case "Conceal Stand":
			var_08 = func_24A5(var_09,var_0A,var_06);
			break;

		case "Cover Crouch Window":
		case "Cover Crouch":
		case "Conceal Crouch":
			var_08 = func_24A5(var_09,var_0A,var_05);
			break;
	}

	param_00.offset = var_08;
	return param_00.offset;
}

//Function Number: 66
func_24A5(param_00,param_01,param_02)
{
	return param_00 * param_02[0] + param_01 * param_02[1] + (0,0,param_02[2]);
}

//Function Number: 67
func_0CBC()
{
	return isdefined(self.enemy) && self seerecently(self.enemy,5);
}

//Function Number: 68
func_0CE3(param_00)
{
	if(!isdefined(self.enemy))
	{
		return 0;
	}

	if((isdefined(param_00) && self cansee(self.enemy,param_00)) || self cansee(self.enemy))
	{
		if(!func_24A6(self geteye(),self.enemy getshootatpos()))
		{
			return 0;
		}

		self.goodshootpos = func_0FB8();
		func_24A7();
		return 1;
	}

	return 0;
}

//Function Number: 69
func_0F4A()
{
	if(!isdefined(self.enemy))
	{
		self.goodshootpos = undefined;
		return 0;
	}

	var_00 = func_0FB8();
	if(!isdefined(self.node))
	{
		var_01 = self cansee(self.enemy);
	}
	else
	{
		var_01 = func_117A(var_01,self.node);
	}

	if(var_01)
	{
		self.goodshootpos = var_00;
		func_24A7();
	}
	else
	{
	}

	return var_01;
}

//Function Number: 70
func_117A(param_00,param_01)
{
	if(param_01.type == "Cover Left" || param_01.type == "Cover Right")
	{
		if(!animscripts/corner::func_244E(param_00,param_01))
		{
			return 0;
		}
	}

	var_02 = func_0F8E(param_01);
	var_03 = param_01.origin + var_02;
	if(!func_24A6(var_03,param_00,param_01))
	{
		return 0;
	}

	if(!sighttracepassed(var_03,param_00,0,undefined))
	{
		if(param_01.type == "Cover Crouch" || param_01.type == "Conceal Crouch")
		{
			var_03 = (0,0,64) + param_01.origin;
			return sighttracepassed(var_03,param_00,0,undefined);
		}

		return 0;
	}

	return 1;
}

//Function Number: 71
func_24A6(param_00,param_01,param_02)
{
	var_03 = self.var_715 - level.var_20A1;
	var_04 = self.var_714 + level.var_20A1;
	var_05 = angleclamp180(vectortoangles(param_01 - param_00)[0]);
	if(var_05 > var_04)
	{
		return 0;
	}

	if(var_05 < var_03)
	{
		if(isdefined(param_02) && param_02.type != "Cover Crouch" && param_02.type != "Conceal Crouch")
		{
			return 0;
		}

		if(var_05 < level.var_CAD + var_03)
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 72
func_24A7()
{
	self.a.var_24A8 = 1;
}

//Function Number: 73
func_24A9()
{
	if(!isdefined(self.a.var_24A8))
	{
		self.a.var_24A8 = 1;
	}

	if(self.a.var_24A8)
	{
		self.a.var_24AA = gettime() + randomintrange(15000,30000);
		self.a.var_24A8 = 0;
	}
}

//Function Number: 74
func_24AB(param_00,param_01,param_02)
{
	for(;;)
	{
		wait 0.05;
		wait 0.05;
	}
}

//Function Number: 75
func_24AC()
{
	if(!self canattackenemynode())
	{
		return 0;
	}

	var_00 = undefined;
	if(isdefined(self.enemy.node))
	{
		var_01 = func_0F8E(self.enemy.node);
		var_00 = self.enemy.node.origin + var_01;
	}
	else
	{
		var_00 = self.enemy getshootatpos();
	}

	if(!self canshoot(var_00))
	{
		return 0;
	}

	if(self.script == "combat")
	{
		if(!sighttracepassed(self geteye(),self getmuzzlepos(),0,undefined))
		{
			return 0;
		}
	}

	self.goodshootpos = var_00;
	return 1;
}

//Function Number: 76
func_0F39()
{
	if(!func_24AD())
	{
		self.goodshootpos = undefined;
		return 0;
	}

	if(!isplayer(self.enemy))
	{
		return func_24AC();
	}

	if(isdefined(self.node))
	{
		if(self.node.type == "Cover Left" || self.node.type == "Cover Right")
		{
			if(!animscripts/corner::func_244E(func_0FB8(),self.node))
			{
				return 0;
			}
		}

		var_00 = func_0F8E(self.node);
		var_01 = self.node.origin + var_00;
	}
	else
	{
		var_01 = self getmuzzlepos();
	}

	if(!func_24A6(var_01,self.lastenemysightpos))
	{
		return 0;
	}

	return func_24B2(var_01);
}

//Function Number: 77
func_0CF3()
{
	if(!func_24AD())
	{
		self.goodshootpos = undefined;
		return 0;
	}

	if(!isplayer(self.enemy))
	{
		return func_24AC();
	}

	var_00 = self getmuzzlepos();
	if(!func_24A6(var_00,self.lastenemysightpos))
	{
		return 0;
	}

	return func_24B2(var_00);
}

//Function Number: 78
func_24AD()
{
	if(!isdefined(self.enemy))
	{
		return 0;
	}

	if(!isdefined(self.lastenemysightpos))
	{
		return 0;
	}

	func_24A9();
	if(gettime() > self.a.var_24AA)
	{
		return 0;
	}

	if(!func_24AF())
	{
		return isdefined(self.goodshootpos);
	}

	return 1;
}

//Function Number: 79
func_24AE(param_00)
{
	if(!sighttracepassed(self getshootatpos(),param_00,0,undefined))
	{
		return 0;
	}

	if(self.a.weaponpos["right"] == "none")
	{
		return 0;
	}

	var_01 = self getmuzzlepos();
	return sighttracepassed(var_01,param_00,0,undefined);
}

//Function Number: 80
func_24AF()
{
	if(isdefined(self.goodshootpos) && !func_24AE(self.goodshootpos))
	{
		return 1;
	}

	return !isdefined(self.var_24B0) || self.var_24B0 != self.lastenemysightpos || distancesquared(self.var_24B1,self.origin) > 1024;
}

//Function Number: 81
func_24B2(param_00)
{
	if(!func_24AF())
	{
		return isdefined(self.goodshootpos);
	}

	if(isdefined(self.enemy) && distancesquared(self.origin,self.enemy.origin) > squared(self.enemy.maxvisibledist))
	{
		self.goodshootpos = undefined;
		return 0;
	}

	if(!sighttracepassed(self getshootatpos(),param_00,0,undefined))
	{
		self.goodshootpos = undefined;
		return 0;
	}

	self.var_24B1 = self.origin;
	self.var_24B0 = self.lastenemysightpos;
	var_01 = func_0FB8();
	var_02 = bullettrace(self.lastenemysightpos,var_01,0,undefined);
	var_03 = var_02["position"];
	var_04 = self.lastenemysightpos - var_03;
	var_05 = vectornormalize(self.lastenemysightpos - param_00);
	var_04 = var_04 - var_05 * vectordot(var_04,var_05);
	var_06 = 20;
	var_07 = int(length(var_04) / var_06 + 0.5);
	if(var_07 < 1)
	{
		var_07 = 1;
	}

	if(var_07 > 20)
	{
		var_07 = 20;
	}

	var_08 = self.lastenemysightpos - var_03;
	var_08 = (var_08[0] / var_07,var_08[1] / var_07,var_08[2] / var_07);
	var_07++;
	var_09 = var_03;
	self.goodshootpos = undefined;
	var_0A = 0;
	var_0B = 2;
	for(var_0C = 0;var_0C < var_07 + var_0B;var_0C++)
	{
		var_0D = sighttracepassed(param_00,var_09,0,undefined);
		var_0E = var_09;
		if(var_0C == var_07 - 1)
		{
			var_08 = var_08 - var_05 * vectordot(var_08,var_05);
		}

		var_09 = var_09 + var_08;
		if(var_0D)
		{
			var_0A++;
			self.goodshootpos = var_0E;
			if(var_0C > 0 && var_0A < var_0B && var_0C < var_07 + var_0B - 1)
			{
				continue;
			}

			return 1;
		}
		else
		{
			var_0A = 0;
		}
	}

	return isdefined(self.goodshootpos);
}

//Function Number: 82
func_10FF(param_00,param_01)
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

//Function Number: 83
func_24B3(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = param_00 / 0.05;
	for(var_07 = 0;var_07 < var_06;var_07++)
	{
		wait 0.05;
	}
}

//Function Number: 84
func_24B4(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = 100;
	var_06 = 0;
	param_00 = param_00 + common_scripts\utility::randomvector(30);
	for(var_07 = 0;var_07 < var_05;var_07++)
	{
		var_06 = var_06 + 0.5;
		wait 0.05;
	}
}

//Function Number: 85
func_24B5(param_00,param_01)
{
	return param_00[0] * param_01[1] - param_00[1] * param_01[0] > 0;
}

//Function Number: 86
func_239F()
{
	return getweaponmodel(self.grenadeweapon);
}

//Function Number: 87
func_24B6(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 500;
	}

	return gettime() - self.var_24B7 < param_00;
}

//Function Number: 88
func_24B8()
{
	if(!self.grenadeammo)
	{
		return 0;
	}

	if(self.script_forcegrenade)
	{
		return 1;
	}

	return isplayer(self.enemy);
}

//Function Number: 89
func_24B9()
{
	return weaponisboltaction(self.weapon);
}

//Function Number: 90
func_24BA(param_00)
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

//Function Number: 91
func_24BB(param_00,param_01)
{
	if(!isdefined(level.var_20D1))
	{
		anim.var_20D1 = [];
	}

	level.var_20D1[level.var_20D1.size] = param_00;
	level._effect["step_" + param_00] = param_01;
}

//Function Number: 92
func_24BC(param_00,param_01)
{
	if(!isdefined(level.var_20D2))
	{
		anim.var_20D2 = [];
	}

	level.var_20D2[level.var_20D2.size] = param_00;
	level._effect["step_small_" + param_00] = param_01;
}

//Function Number: 93
func_24BD(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(!isdefined(param_02))
	{
		param_02 = "all";
	}

	if(!isdefined(level._notetrackfx))
	{
		level._notetrackfx = [];
	}

	level._notetrackfx[param_00][param_02] = spawnstruct();
	level._notetrackfx[param_00][param_02].tag = param_01;
	level._notetrackfx[param_00][param_02].fx = param_03;
	if(isdefined(param_04))
	{
		level._notetrackfx[param_00][param_02].var_23FC = param_04;
	}

	if(isdefined(param_05))
	{
		level._notetrackfx[param_00][param_02].var_23FD = param_05;
	}
}

//Function Number: 94
func_24BE(param_00,param_01)
{
	self endon("death");
	level notify("newdebugline");
	level endon("newdebugline");
	wait 0.05;
}

//Function Number: 95
func_10E1(param_00)
{
	thread func_24BF(param_00);
}

//Function Number: 96
func_24BF(param_00)
{
	self endon("death");
	self notify("anim_prone_change");
	self endon("anim_prone_change");
	self enterprone(param_00,isdefined(self.a.var_D29));
	self waittill("killanimscript");
	if(self.a.pose != "prone" && !isdefined(self.a.var_D29))
	{
		self.a.pose = "prone";
	}
}

//Function Number: 97
func_0F7D(param_00)
{
	thread func_24C0(param_00);
}

//Function Number: 98
func_24C0(param_00)
{
	self endon("death");
	self notify("anim_prone_change");
	self endon("anim_prone_change");
	self exitprone(param_00);
	self waittill("killanimscript");
	if(self.a.pose == "prone")
	{
		self.a.pose = "crouch";
	}
}

//Function Number: 99
func_0F65()
{
	if(self.a.var_CE2)
	{
		return 0;
	}

	if(!animscripts/weaponlist::func_CCA())
	{
		return 0;
	}

	if(weaponclass(self.weapon) == "mg")
	{
		return 0;
	}

	if(isdefined(self.disable_blindfire) && self.disable_blindfire == 1)
	{
		return 0;
	}

	return 1;
}

//Function Number: 100
func_24C2()
{
	if(!func_0F8C())
	{
		return 0;
	}

	var_00 = self getmuzzlepos();
	return sighttracepassed(var_00,func_0CEE(),0,undefined);
}

//Function Number: 101
func_0FC3(param_00)
{
	return self.a.var_CA6[param_00];
}

//Function Number: 102
func_0F26(param_00,param_01)
{
	if(randomint(2))
	{
		return param_00;
	}

	return param_01;
}

//Function Number: 103
func_0D4D(param_00)
{
	return self.a.array[param_00];
}

//Function Number: 104
func_0F8D(param_00)
{
	return self.a.array[param_00].size > 0;
}

//Function Number: 105
func_0CA8(param_00)
{
	var_01 = randomint(self.a.array[param_00].size);
	return self.a.array[param_00][var_01];
}

//Function Number: 106
array(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B,param_0C,param_0D)
{
	var_0E = [];
	if(isdefined(param_00))
	{
	}
	else
	{
		return var_7B;
	}

	if(isdefined(param_02))
	{
	}
	else
	{
		return var_7B;
	}

	if(isdefined(param_03))
	{
	}
	else
	{
		return var_7B;
	}

	if(isdefined(param_04))
	{
	}
	else
	{
		return var_7B;
	}

	if(isdefined(param_05))
	{
	}
	else
	{
		return var_7B;
	}

	if(isdefined(param_06))
	{
	}
	else
	{
		return var_7B;
	}

	if(isdefined(param_07))
	{
	}
	else
	{
		return var_7B;
	}

	if(isdefined(param_08))
	{
	}
	else
	{
		return var_7B;
	}

	if(isdefined(param_09))
	{
	}
	else
	{
		return var_7B;
	}

	if(isdefined(param_0A))
	{
	}
	else
	{
		return var_7B;
	}

	if(isdefined(param_0B))
	{
	}
	else
	{
		return var_7B;
	}

	if(isdefined(param_0C))
	{
	}
	else
	{
		return var_7B;
	}

	if(isdefined(param_0D))
	{
	}
	else
	{
		return var_7B;
	}

	if(isdefined(var_0E))
	{
	}

	return var_7B;
}

//Function Number: 107
func_115A()
{
	return self.primaryweapon;
}

//Function Number: 108
func_24C3()
{
	return self.secondaryweapon;
}

//Function Number: 109
func_24C4()
{
	return self.sidearm;
}

//Function Number: 110
func_24C5()
{
	return self.weapon;
}

//Function Number: 111
func_1118()
{
	return self.weapon == self.primaryweapon && self.weapon != "none";
}

//Function Number: 112
func_24C6()
{
	return self.weapon == self.secondaryweapon && self.weapon != "none";
}

//Function Number: 113
func_0C95()
{
	return self.weapon == self.sidearm && self.weapon != "none";
}

//Function Number: 114
func_24C7()
{
	if(self.weapon == self.primaryweapon)
	{
		return "primary";
	}

	if(self.weapon == self.secondaryweapon)
	{
		return "secondary";
	}

	if(self.weapon == self.sidearm)
	{
		return "sidearm";
	}
}

//Function Number: 115
func_24C8(param_00)
{
	if(isdefined(self.weaponinfo[param_00]))
	{
		return 1;
	}

	return 0;
}

//Function Number: 116
func_0F99(param_00)
{
	var_01 = getmovedelta(param_00,0,1);
	return self localtoworldcoords(var_01);
}

//Function Number: 117
func_0D2F(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	if(self.damagelocation == param_00)
	{
		return 1;
	}

	if(!isdefined(param_01))
	{
		return 0;
	}

	if(self.damagelocation == param_01)
	{
		return 1;
	}

	if(!isdefined(param_02))
	{
		return 0;
	}

	if(self.damagelocation == param_02)
	{
		return 1;
	}

	if(!isdefined(param_03))
	{
		return 0;
	}

	if(self.damagelocation == param_03)
	{
		return 1;
	}

	if(!isdefined(param_04))
	{
		return 0;
	}

	if(self.damagelocation == param_04)
	{
		return 1;
	}

	if(!isdefined(param_05))
	{
		return 0;
	}

	if(self.damagelocation == param_05)
	{
		return 1;
	}

	if(!isdefined(param_06))
	{
		return 0;
	}

	if(self.damagelocation == param_06)
	{
		return 1;
	}

	if(!isdefined(param_07))
	{
		return 0;
	}

	if(self.damagelocation == param_07)
	{
		return 1;
	}

	if(!isdefined(param_08))
	{
		return 0;
	}

	if(self.damagelocation == param_08)
	{
		return 1;
	}

	if(!isdefined(param_09))
	{
		return 0;
	}

	if(self.damagelocation == param_09)
	{
		return 1;
	}

	if(!isdefined(param_0A))
	{
		return 0;
	}

	if(self.damagelocation == param_0A)
	{
		return 1;
	}

	return 0;
}

//Function Number: 118
func_24C9()
{
	return weaponclass(self.weapon) == "pistol";
}

//Function Number: 119
func_0BB6()
{
	return weaponclass(self.weapon) == "rocketlauncher";
}

//Function Number: 120
func_0F79()
{
	return weaponclass(self.weapon) == "mg";
}

//Function Number: 121
func_2380()
{
	return weaponclass(self.weapon) == "spread";
}

//Function Number: 122
func_0EE3()
{
	var_00 = weaponclass(self.weapon);
	switch(var_00)
	{
		case "rifle":
		case "sniper":
		case "smg":
		case "spread":
		case "mg":
			return 1;
	}

	return 0;
}

//Function Number: 123
func_24CA(param_00)
{
	self endon("killanimscript");
	var_01 = self.origin;
	var_02 = (0,0,0);
	for(;;)
	{
		wait 0.05;
		var_03 = distance(self.origin,var_01);
		var_01 = self.origin;
		if(self.health == 1)
		{
			self.a.var_D55 = 1;
			self startragdoll();
			self clearanim(param_00,0.1);
			wait 0.05;
			physicsexplosionsphere(var_01,600,0,var_03 * 0.1);
			self notify("killanimscript");
			return;
		}
	}
}

//Function Number: 124
func_0CB2()
{
	return isdefined(self.cqbwalking) && !isdefined(self.var_73C);
}

//Function Number: 125
func_0C98()
{
	return isdefined(self.cqbwalking);
}

//Function Number: 126
func_10B9()
{
	return !self.var_781 || isdefined(self.cqbwalking);
}

//Function Number: 127
func_10F0()
{
	self.a.var_10F2 = randomint(2);
}

//Function Number: 128
func_0CEA(param_00)
{
	return weaponclass(param_00) == "spread";
}

//Function Number: 129
func_0BEB(param_00)
{
	return weaponclass(param_00) == "sniper";
}

//Function Number: 130
func_0C97()
{
	return self.weapon != "none" && weaponisboltaction(self.weapon) && weaponclass(self.weapon) == "spread";
}

//Function Number: 131
func_1078(param_00,param_01)
{
	var_02 = param_00 % level.var_20F6;
	return level.var_20F7[var_02] % param_01;
}

//Function Number: 132
func_104B()
{
	if(func_24C6())
	{
		return "secondary";
	}

	if(func_0C95())
	{
		return "sidearm";
	}

	return "primary";
}