/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\utility.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 147
 * Decompile Time: 2420 ms
 * Timestamp: 10/27/2023 1:24:44 AM
*******************************************************************/

//Function Number: 1
initanimtree(param_00)
{
	self clearanim(%body,0.3);
	self setanim(%body,1,0);
	if(param_00 != "pain" && param_00 != "death")
	{
		self.a.var_78D0 = "none";
	}

	self.a.aimweight = 1;
	self.a.aimweight_start = 1;
	self.a.aimweight_end = 1;
	self.a.aimweight_transframes = 0;
	self.a.aimweight_t = 0;
	func_86F6();
}

//Function Number: 2
func_86CA()
{
	if(isdefined(self.desired_anim_pose) && self.desired_anim_pose != self.a.var_60B1)
	{
		if(self.a.var_60B1 == "prone")
		{
			exitpronewrapper(0.5);
		}

		if(self.desired_anim_pose == "prone")
		{
			self setproneanimnodes(-45,45,%prone_legs_down,%exposed_aiming,%prone_legs_up);
			enterpronewrapper(0.5);
			self setanimknoball(lookupanim("default_prone","straight_level"),%body,1,0.1,1);
		}
	}

	self.desired_anim_pose = undefined;
}

//Function Number: 3
func_4622(param_00)
{
	if(isdefined(self.var_4F3D))
	{
		if(param_00 != "pain" && param_00 != "death")
		{
			self kill(self.origin);
		}

		if(param_00 != "pain")
		{
			self.var_4F3D = undefined;
			self notify("kill_long_death");
		}
	}

	if(isdefined(self.a.mayonlydie) && param_00 != "death")
	{
		self kill(self.origin);
	}

	if(isdefined(self.a.var_60DA))
	{
		var_01 = self.a.var_60DA;
		self.a.var_60DA = undefined;
		[[ var_01 ]](param_00);
	}

	if(param_00 != "combat" && param_00 != "pain" && param_00 != "death" && func_87FE())
	{
		animscripts/combat::func_7E22(lookupanim("combat","pistol_to_primary"),1);
	}

	if(param_00 != "combat" && param_00 != "move" && param_00 != "pain")
	{
		self.a.var_4FDC = undefined;
	}

	if(param_00 != "death")
	{
		self.a.var_564F = 0;
	}

	if(isdefined(self.var_48D8) && param_00 == "pain" || param_00 == "death" || param_00 == "flashed")
	{
		animscripts/combat_utility::func_2B4E();
	}

	self.var_48D8 = undefined;
	animscripts/squadmanager::aiupdateanimstate(param_00);
	self.var_1FCA = undefined;
	self.var_7D64 = 0;
	self.isreloading = 0;
	self.changingcoverpos = 0;
	self.a.aimidlethread = undefined;
	self.a.var_6D18 = gettime();
	self.a.atconcealmentnode = 0;
	if(isdefined(self.node) && self.node.type == "Conceal Prone" || self.node.type == "Conceal Crouch" || self.node.type == "Conceal Stand")
	{
		self.a.atconcealmentnode = 1;
	}

	initanimtree(param_00);
	func_86CA();
}

//Function Number: 4
getpreferredweapon()
{
	if(isdefined(self.var_8C03) && self.var_8C03)
	{
		if(isshotgun(self.primaryweapon))
		{
			return self.primaryweapon;
		}
		else if(isshotgun(self.secondaryweapon))
		{
			return self.secondaryweapon;
		}
	}

	return self.primaryweapon;
}

//Function Number: 5
badplacer(param_00,param_01,param_02)
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
func_61A8()
{
	self endon("death");
	self notify("displaceprint");
	self endon("displaceprint");
	wait(0.05);
}

//Function Number: 7
func_48DE(param_00)
{
	if((!isdefined(param_00) || param_00) && self.alertlevelint > 1)
	{
		return 1;
	}

	if(isdefined(self.enemy))
	{
		return 1;
	}

	return self.a.var_1E56 > gettime();
}

//Function Number: 8
func_86F6()
{
	if(isdefined(self.enemy))
	{
		self.a.var_1E56 = gettime() + level.combatmemorytimeconst + randomint(level.var_1E5E);
	}
}

//Function Number: 9
getenemyeyepos()
{
	if(isdefined(self.enemy))
	{
		self.a.lastenemypos = self.enemy getshootatpos();
		self.a.var_4C60 = gettime();
		return self.a.lastenemypos;
	}

	if(isdefined(self.a.var_4C60) && isdefined(self.a.lastenemypos) && self.a.var_4C60 + 3000 < gettime())
	{
		return self.a.lastenemypos;
	}

	var_00 = self getshootatpos();
	var_00 = var_00 + (196 * self.lookforward[0],196 * self.lookforward[1],196 * self.lookforward[2]);
	return var_00;
}

//Function Number: 10
getnodeforwardyaw(param_00)
{
	if(!isdefined(self.heat))
	{
		if(func_4917(param_00))
		{
			return param_00.angles[1] + 90;
		}
		else if(func_491A(param_00))
		{
			return param_00.angles[1] - 90;
		}
		else if(param_00.type == "Cover Multi")
		{
			if(isdefined(self.cover) && isdefined(self.cover.state))
			{
				if(self.cover.state == "right")
				{
					return param_00.angles[1] - 90;
				}
				else if(self.cover.state == "left")
				{
					return param_00.angles[1] + 90;
				}
			}
		}
	}

	return param_00.angles[1];
}

//Function Number: 11
getnodeyawtoorigin(param_00)
{
	if(isdefined(self.node))
	{
		var_01 = self.node.angles[1] - func_3C87(param_00);
	}
	else
	{
		var_01 = self.angles[1] - func_3C87(var_01);
	}

	var_01 = angleclamp180(var_01);
	return var_01;
}

//Function Number: 12
func_3B53()
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
		var_02 = self.node.angles[1] - func_3C87(var_00);
	}
	else
	{
		var_02 = self.angles[1] - func_3C87(var_02);
	}

	var_02 = angleclamp180(var_02);
	return var_02;
}

//Function Number: 13
getyawtospot(param_00)
{
	if(func_4965())
	{
		var_01 = anglestoforward(self.angles);
		var_02 = rotatepointaroundvector(var_01,param_00 - self.origin,self.angles[2] * -1);
		param_00 = var_02 + self.origin;
	}

	var_03 = self.angles[1] - func_3C87(param_00);
	var_03 = angleclamp180(var_03);
	return var_03;
}

//Function Number: 14
func_3C8B()
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

	var_02 = self.angles[1] - func_3C87(var_00);
	var_02 = angleclamp180(var_02);
	return var_02;
}

//Function Number: 15
func_3C87(param_00)
{
	return vectortoyaw(param_00 - self.origin);
}

//Function Number: 16
getyaw2d(param_00)
{
	var_01 = vectortoangles((param_00[0],param_00[1],0) - (self.origin[0],self.origin[1],0));
	return var_01[1];
}

//Function Number: 17
absyawtoenemy()
{
	var_00 = self.angles[1] - func_3C87(self.enemy.origin);
	var_00 = angleclamp180(var_00);
	if(var_00 < 0)
	{
		var_00 = -1 * var_00;
	}

	return var_00;
}

//Function Number: 18
absyawtoenemy2d()
{
	var_00 = self.angles[1] - getyaw2d(self.enemy.origin);
	var_00 = angleclamp180(var_00);
	if(var_00 < 0)
	{
		var_00 = -1 * var_00;
	}

	return var_00;
}

//Function Number: 19
func_07C8(param_00)
{
	var_01 = self.angles[1] - func_3C87(param_00);
	var_01 = angleclamp180(var_01);
	if(var_01 < 0)
	{
		var_01 = -1 * var_01;
	}

	return var_01;
}

//Function Number: 20
absyawtoangles(param_00)
{
	var_01 = self.angles[1] - param_00;
	var_01 = angleclamp180(var_01);
	if(var_01 < 0)
	{
		var_01 = -1 * var_01;
	}

	return var_01;
}

//Function Number: 21
func_3C8A(param_00,param_01)
{
	var_02 = vectortoangles(param_00 - param_01);
	return var_02[1];
}

//Function Number: 22
getyawtotag(param_00,param_01)
{
	var_02 = self gettagangles(param_00)[1] - func_3C8A(param_01,self gettagorigin(param_00));
	var_02 = angleclamp180(var_02);
	return var_02;
}

//Function Number: 23
getyawtoorigin(param_00)
{
	if(isdefined(self.type) && self.type == "Cover Up 3D" || self.type == "Cover Left 3D" || self.type == "Cover Right 3D" || self.type == "Exposed 3D")
	{
		var_01 = gettruenodeangles(self);
		var_02 = anglestoforward(var_01);
		var_03 = rotatepointaroundvector(var_02,param_00 - self.origin,var_01[2] * -1);
		var_03 = var_03 + self.origin;
		var_04 = var_01[1] - func_3C87(var_03);
		var_04 = angleclamp180(var_04);
		return var_04;
	}

	var_04 = self.angles[1] - func_3C87(var_04);
	var_04 = angleclamp180(var_04);
	return var_04;
}

//Function Number: 24
func_3AA6(param_00)
{
	var_01 = self gettagangles("TAG_EYE")[1] - func_3C87(param_00);
	var_01 = angleclamp180(var_01);
	return var_01;
}

//Function Number: 25
func_496E(param_00)
{
	if(isdefined(self.var_1FCA))
	{
		return self.var_1FCA doesnodeallowstance(param_00);
	}

	return self isstanceallowed(param_00);
}

//Function Number: 26
choosepose(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = self.a.var_60B1;
	}

	switch(param_00)
	{
		case "stand":
			if(func_496E("stand"))
			{
				var_01 = "stand";
			}
			else if(func_496E("crouch"))
			{
				var_01 = "crouch";
			}
			else if(func_496E("prone"))
			{
				var_01 = "prone";
			}
			else
			{
				var_01 = "stand";
			}
			break;

		case "crouch":
			if(func_496E("crouch"))
			{
				var_01 = "crouch";
			}
			else if(func_496E("stand"))
			{
				var_01 = "stand";
			}
			else if(func_496E("prone"))
			{
				var_01 = "prone";
			}
			else
			{
				var_01 = "crouch";
			}
			break;

		case "prone":
			if(func_496E("prone"))
			{
				var_01 = "prone";
			}
			else if(func_496E("crouch"))
			{
				var_01 = "crouch";
			}
			else if(func_496E("stand"))
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

//Function Number: 27
func_3A52()
{
	var_00 = self.node;
	if(isdefined(var_00) && self nearnode(var_00) || isdefined(self.var_1FCA) && var_00 == self.var_1FCA)
	{
		return var_00;
	}

	return undefined;
}

//Function Number: 28
getnodetype()
{
	var_00 = func_3A52();
	if(isdefined(var_00))
	{
		return var_00.type;
	}

	return "none";
}

//Function Number: 29
func_3B4A()
{
	var_00 = func_3A52();
	if(isdefined(var_00))
	{
		return var_00.angles[1];
	}

	return self.desiredangle;
}

//Function Number: 30
func_3B4B()
{
	var_00 = func_3A52();
	if(isdefined(var_00))
	{
		return anglestoforward(var_00.angles);
	}

	return anglestoforward(self.angles);
}

//Function Number: 31
getnodeorigin()
{
	var_00 = func_3A52();
	if(isdefined(var_00))
	{
		return var_00.origin;
	}

	return self.origin;
}

//Function Number: 32
func_69E4(param_00,param_01)
{
	var_02 = int(param_00) % param_01;
	var_02 = var_02 + param_01;
	return var_02 % param_01;
}

//Function Number: 33
absangleclamp180(param_00)
{
	return abs(angleclamp180(param_00));
}

//Function Number: 34
quadrantanimweights(param_00)
{
	var_01 = cos(param_00);
	var_02 = sin(param_00);
	var_03["front"] = 0;
	var_03["right"] = 0;
	var_03["back"] = 0;
	var_03["left"] = 0;
	if(isdefined(self.alwaysrunforward))
	{
		var_03["front"] = 1;
		return var_03;
	}

	if(var_01 > 0)
	{
		if(var_02 > var_01)
		{
			var_03["left"] = 1;
		}
		else if(var_02 < -1 * var_01)
		{
			var_03["right"] = 1;
		}
		else
		{
			var_03["front"] = 1;
		}
	}
	else
	{
		var_04 = -1 * var_01;
		if(var_02 > var_04)
		{
			var_03["left"] = 1;
		}
		else if(var_02 < var_01)
		{
			var_03["right"] = 1;
		}
		else
		{
			var_03["back"] = 1;
		}
	}

	return var_03;
}

//Function Number: 35
getquadrant(param_00)
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

//Function Number: 36
isinset(param_00,param_01)
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

//Function Number: 37
func_5D42(param_00)
{
	if(isdefined(param_00))
	{
		self setflaggedanimknoballrestart("playAnim",param_00,%root,1,0.1,1);
		var_01 = getanimlength(param_00);
		var_01 = 3 * var_01 + 1;
		thread notifyaftertime("time is up","time is up",var_01);
		self waittill("time is up");
		self notify("enddrawstring");
	}
}

//Function Number: 38
notifyaftertime(param_00,param_01,param_02)
{
	self endon("death");
	self endon(param_01);
	wait(param_02);
	self notify(param_00);
}

//Function Number: 39
drawstring(param_00)
{
	self endon("killanimscript");
	self endon("enddrawstring");
	wait(0.05);
}

//Function Number: 40
func_2A8A(param_00,param_01,param_02,param_03)
{
	var_04 = param_03 * 20;
	for(var_05 = 0;var_05 < var_04;var_05++)
	{
		wait(0.05);
	}
}

//Function Number: 41
showlastenemysightpos(param_00)
{
	self notify("got known enemy2");
	self endon("got known enemy2");
	self endon("death");
	if(!isdefined(self.enemy))
	{
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
		wait(0.05);
		if(!isdefined(self.lastenemysightpos))
		{
			continue;
		}
	}
}

//Function Number: 42
hasenemysightpos()
{
	if(isdefined(self.node))
	{
		return canseeenemyfromexposed() || func_1A00();
	}

	return func_19F6() || cansuppressenemy();
}

//Function Number: 43
func_3A97()
{
	return self.goodshootpos;
}

//Function Number: 44
func_8807()
{
	if(!hasenemysightpos())
	{
	}

	self.ignoresightpos = func_3A97();
	self.ignoreorigin = self.origin;
}

//Function Number: 45
func_8805()
{
	if(!hasenemysightpos())
	{
		return 0;
	}

	var_00 = self getmuzzlepos();
	var_01 = self getshootatpos() - var_00;
	if(isdefined(self.ignoresightpos) && isdefined(self.ignoreorigin))
	{
		if(distance(self.origin,self.ignoreorigin) < 25)
		{
			return 0;
		}
	}

	self.ignoresightpos = undefined;
	var_02 = self canshoot(func_3A97(),var_01);
	if(!var_02)
	{
		self.ignoresightpos = func_3A97();
		return 0;
	}

	return 1;
}

//Function Number: 46
debugtimeout()
{
	wait(5);
	self notify("timeout");
}

//Function Number: 47
debugposinternal(param_00,param_01,param_02)
{
	self endon("death");
	self notify("stop debug " + param_00);
	self endon("stop debug " + param_00);
	var_03 = spawnstruct();
	var_03 thread debugtimeout();
	var_03 endon("timeout");
	if(self.enemy.team == "allies")
	{
		var_04 = (0.4,0.7,1);
	}
	else
	{
		var_04 = (1,0.7,0.4);
	}

	wait(0.05);
}

//Function Number: 48
debugpos(param_00,param_01)
{
	thread debugposinternal(param_00,param_01,2.15);
}

//Function Number: 49
debugpossize(param_00,param_01,param_02)
{
	thread debugposinternal(param_00,param_01,param_02);
}

//Function Number: 50
func_2418(param_00,param_01)
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

	thread debugpossize(self.origin + (0,0,42),var_03,1.5);
	thread debugpos(self.origin + (0,0,60),"Suppressing");
}

//Function Number: 51
func_61B0()
{
	self endon("death");
	self notify("stop shoot " + self.var_30F7);
	self endon("stop shoot " + self.var_30F7);
	var_00 = 0.25;
	var_01 = var_00 * 20;
	for(var_02 = 0;var_02 < var_01;var_02 = var_02 + 1)
	{
		wait(0.05);
	}
}

//Function Number: 52
func_61AF()
{
}

//Function Number: 53
func_750A(param_00,param_01,param_02,param_03)
{
	self endon("death");
	var_04 = param_03 * 20;
	for(var_05 = 0;var_05 < var_04;var_05 = var_05 + 1)
	{
		wait(0.05);
	}
}

//Function Number: 54
func_7509(param_00,param_01,param_02,param_03)
{
	thread func_750A(param_00,param_01 + (0,0,-5),param_02,param_03);
}

//Function Number: 55
func_7435(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 1;
	}

	[[ level.var_7436 ]](param_00);
}

//Function Number: 56
func_7437(param_00)
{
	self.a.lastshoottime = gettime();
	maps\_gameskill::func_6E1A();
	self notify("shooting");
	self shoot(1,undefined,param_00);
}

//Function Number: 57
func_7438(param_00)
{
	level notify("an_enemy_shot",self);
	func_7437(param_00);
}

//Function Number: 58
func_7448(param_00,param_01)
{
	var_02 = bulletspread(self getmuzzlepos(),param_00,4);
	self.a.lastshoottime = gettime();
	if(!isdefined(param_01))
	{
		param_01 = 1;
	}

	self notify("shooting");
	self shoot(1,var_02,param_01);
}

//Function Number: 59
func_80AF()
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

//Function Number: 60
func_5BB0()
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

		if(isdefined(self.a.var_5486) && self.a.var_5486 == "stop")
		{
			if(isdefined(self.var_48E0) && self.var_48E0 == 1)
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

//Function Number: 61
personalcoldbreathstop()
{
	self notify("stop personal effect");
}

//Function Number: 62
func_5BB1()
{
	self endon("death");
	self notify("stop personal effect");
	self endon("stop personal effect");
	for(;;)
	{
		self waittill("spawned",var_00);
		if(maps\_utility::func_77BE(var_00))
		{
			continue;
		}

		var_00 thread func_5BB0();
	}
}

//Function Number: 63
func_4979()
{
	if(isdefined(self.var_34E1))
	{
		return self.var_34E1;
	}

	if(self.suppressionmeter <= self.var_7D6A)
	{
		return 0;
	}

	return self issuppressed();
}

//Function Number: 64
func_4965()
{
	return isdefined(self.swimmer) && self.swimmer == 1 && isdefined(self.space) && self.space == 1;
}

//Function Number: 65
gettruenodeangles(param_00)
{
	if(!isdefined(param_00))
	{
		return (0,0,0);
	}

	if(!isdefined(param_00.script_angles))
	{
		return param_00.angles;
	}

	var_01 = param_00.angles;
	var_02 = angleclamp180(var_01[0] + param_00.script_angles[0]);
	var_03 = var_01[1];
	var_04 = angleclamp180(var_01[2] + param_00.script_angles[2]);
	return (var_02,var_03,var_04);
}

//Function Number: 66
ispartiallysuppressedwrapper()
{
	if(self.suppressionmeter <= self.var_7D6A * 0.25)
	{
		return 0;
	}

	return self issuppressed();
}

//Function Number: 67
func_3B50(param_00)
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
	var_0B = param_00.type;
	if(var_0B == "Cover Multi")
	{
		var_0B = getcovermultipretendtype(param_00);
	}

	switch(var_0B)
	{
		case "Cover Left":
		case "Cover Left 3D":
			if(param_00 gethighestnodestance() == "crouch")
			{
				var_08 = func_1935(var_09,var_0A,var_01);
			}
			else
			{
				var_08 = func_1935(var_09,var_0A,var_02);
			}
			break;

		case "Cover Right":
		case "Cover Right 3D":
			if(param_00 gethighestnodestance() == "crouch")
			{
				var_08 = func_1935(var_09,var_0A,var_03);
			}
			else
			{
				var_08 = func_1935(var_09,var_0A,var_04);
			}
			break;

		case "Turret":
		case "Cover Stand":
		case "Conceal Stand":
			var_08 = func_1935(var_09,var_0A,var_06);
			break;

		case "Cover Crouch Window":
		case "Cover Crouch":
		case "Conceal Crouch":
			var_08 = func_1935(var_09,var_0A,var_05);
			break;
	}

	param_00.offset = var_08;
	return param_00.offset;
}

//Function Number: 68
func_1935(param_00,param_01,param_02)
{
	return param_00 * param_02[0] + param_01 * param_02[1] + (0,0,param_02[2]);
}

//Function Number: 69
func_63FE()
{
	return isdefined(self.enemy) && self seerecently(self.enemy,5);
}

//Function Number: 70
func_19F6(param_00)
{
	if(!isdefined(self.enemy))
	{
		return 0;
	}

	if((isdefined(param_00) && self cansee(self.enemy,param_00)) || self cansee(self.enemy))
	{
		if(!checkpitchvisibility(self geteye(),self.enemy getshootatpos()))
		{
			return 0;
		}

		self.goodshootpos = getenemyeyepos();
		func_29AE();
		return 1;
	}

	return 0;
}

//Function Number: 71
canseeenemyfromexposed()
{
	if(!isdefined(self.enemy))
	{
		self.goodshootpos = undefined;
		return 0;
	}

	var_00 = getenemyeyepos();
	if(!isdefined(self.node))
	{
		var_01 = self cansee(self.enemy);
	}
	else
	{
		var_01 = canseepointfromexposedatnode(var_01,self.node);
	}

	if(var_01)
	{
		self.goodshootpos = var_00;
		func_29AE();
	}
	else
	{
	}

	return var_01;
}

//Function Number: 72
canseepointfromexposedatnode(param_00,param_01)
{
	if(func_4917(param_01) || func_491A(param_01) || func_4918(param_01))
	{
		if(!animscripts/corner::func_19F8(param_00,param_01))
		{
			return 0;
		}
	}

	var_02 = func_3B50(param_01);
	var_03 = param_01.origin + var_02;
	if(!checkpitchvisibility(var_03,param_00,param_01))
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

		if(func_4965() && param_01.type == "Cover Up 3D")
		{
			var_04 = anglestoup(self.angles);
			var_03 = param_01.origin + (var_04[0] * 32,var_04[1] * 32,var_04[2] * 32);
			return sighttracepassed(var_03,param_00,0,undefined);
		}

		return 0;
	}

	return 1;
}

//Function Number: 73
func_4918(param_00)
{
	if(param_00.type != "Cover Multi")
	{
		return 0;
	}

	if(!isdefined(self.cover))
	{
		return 0;
	}

	if(isdefined(self.cover.state))
	{
		return self.cover.state == "right" || self.cover.state == "left";
	}

	if(isdefined(self.cover.arrivalnodetype))
	{
		return self.cover.arrivalnodetype == "right" || self.cover.arrivalnodetype == "left";
	}

	return 0;
}

//Function Number: 74
getcovermultipretendtype(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = param_00 animscripts/cover_multi::covermulti_getnonrandomvaliddir();
	}

	switch(param_01)
	{
		case "right":
			return "Cover Right";

		case "left":
			return "Cover Left";

		case "stand":
			return "Cover Stand";

		case "crouch":
			return "Cover Crouch";

		default:
			break;
	}
}

//Function Number: 75
checkpitchvisibility(param_00,param_01,param_02)
{
	var_03 = self.downaimlimit - level.aimpitchdifftolerance;
	var_04 = self.upaimlimit + level.aimpitchdifftolerance;
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

		if(var_05 < level.covercrouchleanpitch + var_03)
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 76
func_29AE()
{
	self.a.var_74BD = 1;
}

//Function Number: 77
func_86F1()
{
	if(!isdefined(self.a.var_74BD))
	{
		self.a.var_74BD = 1;
	}

	if(self.a.var_74BD)
	{
		self.a.giveuponsuppressiontime = gettime() + randomintrange(15000,30000);
		self.a.var_74BD = 0;
	}
}

//Function Number: 78
func_751A(param_00,param_01,param_02)
{
	for(;;)
	{
		wait(0.05);
		wait(0.05);
	}
}

//Function Number: 79
aisuppressai()
{
	if(!self canattackenemynode())
	{
		return 0;
	}

	var_00 = undefined;
	if(isdefined(self.enemy.node))
	{
		var_01 = func_3B50(self.enemy.node);
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

//Function Number: 80
func_1A00()
{
	if(!hassuppressableenemy())
	{
		self.goodshootpos = undefined;
		return 0;
	}

	if(!isplayer(self.enemy))
	{
		return aisuppressai();
	}

	if(isdefined(self.node))
	{
		if(func_4917(self.node) || func_491A(self.node))
		{
			if(!animscripts/corner::func_19F8(getenemyeyepos(),self.node))
			{
				return 0;
			}
		}

		var_00 = func_3B50(self.node);
		var_01 = self.node.origin + var_00;
	}
	else
	{
		var_01 = self getmuzzlepos();
	}

	if(!checkpitchvisibility(var_01,self.lastenemysightpos))
	{
		return 0;
	}

	return func_3285(var_01);
}

//Function Number: 81
cansuppressenemy()
{
	if(!hassuppressableenemy())
	{
		self.goodshootpos = undefined;
		return 0;
	}

	if(!isplayer(self.enemy))
	{
		return aisuppressai();
	}

	var_00 = self getmuzzlepos();
	if(!checkpitchvisibility(var_00,self.lastenemysightpos))
	{
		return 0;
	}

	return func_3285(var_00);
}

//Function Number: 82
hassuppressableenemy()
{
	if(!isdefined(self.enemy))
	{
		return 0;
	}

	if(!isdefined(self.lastenemysightpos))
	{
		return 0;
	}

	func_86F1();
	if(gettime() > self.a.giveuponsuppressiontime)
	{
		return 0;
	}

	if(!func_558F())
	{
		return isdefined(self.goodshootpos);
	}

	return 1;
}

//Function Number: 83
canseeandshootpoint(param_00)
{
	if(!sighttracepassed(self getshootatpos(),param_00,0,undefined))
	{
		return 0;
	}

	if(self.a.var_8DB5["right"] == "none")
	{
		return 0;
	}

	var_01 = self getmuzzlepos();
	return sighttracepassed(var_01,param_00,0,undefined);
}

//Function Number: 84
func_558F()
{
	if(isdefined(self.goodshootpos) && !canseeandshootpoint(self.goodshootpos))
	{
		return 1;
	}

	return !isdefined(self.lastenemysightposold) || self.lastenemysightposold != self.lastenemysightpos || distancesquared(self.lastenemysightposselforigin,self.origin) > 1024;
}

//Function Number: 85
func_3285(param_00)
{
	if(!func_558F())
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

	self.lastenemysightposselforigin = self.origin;
	self.lastenemysightposold = self.lastenemysightpos;
	var_01 = getenemyeyepos();
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

//Function Number: 86
anim_array(param_00,param_01)
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

//Function Number: 87
func_6199(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = param_00 / 0.05;
	for(var_07 = 0;var_07 < var_06;var_07++)
	{
		wait(0.05);
	}
}

//Function Number: 88
func_6198(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = 100;
	var_06 = 0;
	param_00 = param_00 + common_scripts\utility::randomvector(30);
	for(var_07 = 0;var_07 < var_05;var_07++)
	{
		var_06 = var_06 + 0.5;
		wait(0.05);
	}
}

//Function Number: 89
crossproduct(param_00,param_01)
{
	return param_00[0] * param_01[1] - param_00[1] * param_01[0] > 0;
}

//Function Number: 90
func_3ABF()
{
	return getweaponmodel(self.grenadeweapon);
}

//Function Number: 91
func_6AAF(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 500;
	}

	return gettime() - self.var_5BB7 < param_00;
}

//Function Number: 92
canthrowgrenade()
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

//Function Number: 93
func_87F0()
{
	return weaponisboltaction(self.weapon);
}

//Function Number: 94
random_weight(param_00)
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

//Function Number: 95
func_7039(param_00,param_01)
{
	if(!isdefined(level.var_59D1))
	{
		anim.var_59D1 = [];
	}

	level.var_59D1[param_00] = 1;
	level._effect["step_" + param_00] = param_01;
}

//Function Number: 96
func_703A(param_00,param_01)
{
	if(!isdefined(level.var_59D3))
	{
		anim.var_59D3 = [];
	}

	level.var_59D3[param_00] = 1;
	level._effect["step_small_" + param_00] = param_01;
}

//Function Number: 97
func_861E(param_00)
{
	if(isdefined(level.var_59D1))
	{
		level.var_59D1[param_00] = undefined;
	}

	level._effect["step_" + param_00] = undefined;
}

//Function Number: 98
func_861F(param_00)
{
	if(isdefined(level.var_59D3))
	{
		level.var_59D3[param_00] = undefined;
	}

	level._effect["step_small_" + param_00] = undefined;
}

//Function Number: 99
setnotetrackeffect(param_00,param_01,param_02,param_03,param_04,param_05)
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
	func_707F(param_00,param_02,param_04,param_05);
}

//Function Number: 100
func_707F(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_01))
	{
		param_01 = "all";
	}

	if(!isdefined(level._notetrackfx))
	{
		level._notetrackfx = [];
	}

	if(isdefined(level._notetrackfx[param_00][param_01]))
	{
		var_04 = level._notetrackfx[param_00][param_01];
	}
	else
	{
		var_04 = spawnstruct();
		level._notetrackfx[param_00][param_01] = var_04;
	}

	if(isdefined(param_02))
	{
		var_04.var_7712 = param_02;
	}

	if(isdefined(param_03))
	{
		var_04.var_7715 = param_03;
	}
}

//Function Number: 101
func_5BAD(param_00,param_01)
{
	self endon("death");
	level notify("newdebugline");
	level endon("newdebugline");
	wait(0.05);
}

//Function Number: 102
enterpronewrapper(param_00)
{
	thread func_2F66(param_00);
}

//Function Number: 103
func_2F66(param_00)
{
	self endon("death");
	self notify("anim_prone_change");
	self endon("anim_prone_change");
	self enterprone(param_00,isdefined(self.a.onback));
	self waittill("killanimscript");
	if(self.a.var_60B1 != "prone" && !isdefined(self.a.onback))
	{
		self.a.var_60B1 = "prone";
	}
}

//Function Number: 104
exitpronewrapper(param_00)
{
	thread func_309D(param_00);
}

//Function Number: 105
func_309D(param_00)
{
	self endon("death");
	self notify("anim_prone_change");
	self endon("anim_prone_change");
	self exitprone(param_00);
	self waittill("killanimscript");
	if(self.a.var_60B1 == "prone")
	{
		self.a.var_60B1 = "crouch";
	}
}

//Function Number: 106
func_199A()
{
	if(self.a.atconcealmentnode)
	{
		return 0;
	}

	if(!animscripts/weaponlist::func_87EF())
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

//Function Number: 107
func_19C9()
{
	if(!hasenemysightpos())
	{
		return 0;
	}

	var_00 = self getmuzzlepos();
	return sighttracepassed(var_00,func_3A97(),0,undefined);
}

//Function Number: 108
getmoveanim(param_00)
{
	return self.a.var_5473[param_00];
}

//Function Number: 109
func_632D(param_00,param_01)
{
	if(randomint(2))
	{
		return param_00;
	}

	return param_01;
}

//Function Number: 110
animarray(param_00)
{
	return self.a.var_ED8[param_00];
}

//Function Number: 111
animarrayanyexist(param_00)
{
	return isdefined(self.a.var_ED8[param_00]) && self.a.var_ED8[param_00].size > 0;
}

//Function Number: 112
animarraypickrandom(param_00)
{
	var_01 = randomint(self.a.var_ED8[param_00].size);
	return self.a.var_ED8[param_00][var_01];
}

//Function Number: 113
func_0ED8(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B,param_0C,param_0D)
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

//Function Number: 114
func_3A13()
{
	return self.primaryweapon;
}

//Function Number: 115
func_3A15()
{
	return self.secondaryweapon;
}

//Function Number: 116
getaisidearmweapon()
{
	return self.var_7544;
}

//Function Number: 117
func_3A0E()
{
	return self.weapon;
}

//Function Number: 118
usingprimary()
{
	return self.weapon == self.primaryweapon && self.weapon != "none";
}

//Function Number: 119
func_87FB()
{
	return self.weapon == self.secondaryweapon && self.weapon != "none";
}

//Function Number: 120
func_87FE()
{
	return self.weapon == self.var_7544 && self.weapon != "none";
}

//Function Number: 121
getaicurrentweaponslot()
{
	if(self.weapon == self.primaryweapon)
	{
		return "primary";
	}

	if(self.weapon == self.secondaryweapon)
	{
		return "secondary";
	}

	if(self.weapon == self.var_7544)
	{
		return "sidearm";
	}
}

//Function Number: 122
aihasweapon(param_00)
{
	if(isdefined(self.weaponinfo[param_00]))
	{
		return 1;
	}

	return 0;
}

//Function Number: 123
func_3A23(param_00)
{
	var_01 = getmovedelta(param_00,0,1);
	return self localtoworldcoords(var_01);
}

//Function Number: 124
func_2310(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B)
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

//Function Number: 125
func_87F4()
{
	return weaponclass(self.weapon) == "pistol";
}

//Function Number: 126
func_87FA()
{
	return weaponclass(self.weapon) == "rocketlauncher";
}

//Function Number: 127
usingmg()
{
	return weaponclass(self.weapon) == "mg";
}

//Function Number: 128
func_87FD()
{
	return weaponclass(self.weapon) == "spread";
}

//Function Number: 129
usingriflelikeweapon()
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

//Function Number: 130
func_74AE(param_00)
{
	return isdefined(self.secondaryweapon) && self.secondaryweapon != "none" && param_00 < squared(512) || self.a.rockets < 1;
}

//Function Number: 131
func_62E1(param_00)
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
			self.a.var_564F = 1;
			self startragdoll();
			self clearanim(param_00,0.1);
			wait(0.05);
			physicsexplosionsphere(var_01,600,0,var_03 * 0.1);
			self notify("killanimscript");
		}
	}
}

//Function Number: 132
func_74A5()
{
	return isdefined(self.var_1FFA) && !isdefined(self.grenade);
}

//Function Number: 133
func_48A0()
{
	return isdefined(self.var_1FFA);
}

//Function Number: 134
iscqbwalkingorfacingenemy()
{
	return !self.facemotion || isdefined(self.var_1FFA);
}

//Function Number: 135
func_633A()
{
	self.a.var_43E4 = randomint(2);
}

//Function Number: 136
isshotgun(param_00)
{
	return weaponclass(param_00) == "spread";
}

//Function Number: 137
issniperrifle(param_00)
{
	return weaponclass(param_00) == "sniper";
}

//Function Number: 138
func_8D9B()
{
	return self.weapon != "none" && weaponisboltaction(self.weapon) && weaponclass(self.weapon) == "spread";
}

//Function Number: 139
func_3BBB(param_00,param_01)
{
	var_02 = param_00 % level.var_6337;
	return level.randominttable[var_02] % param_01;
}

//Function Number: 140
func_3A6D()
{
	if(func_87FB())
	{
		return "secondary";
	}

	if(func_87FE())
	{
		return "sidearm";
	}

	return "primary";
}

//Function Number: 141
func_4917(param_00)
{
	return param_00.type == "Cover Left" || param_00.type == "Cover Left 3D";
}

//Function Number: 142
func_491A(param_00)
{
	return param_00.type == "Cover Right" || param_00.type == "Cover Right 3D";
}

//Function Number: 143
func_4916(param_00)
{
	return param_00.type == "Cover Left 3D" || param_00.type == "Cover Right 3D" || param_00.type == "Cover Up 3D";
}

//Function Number: 144
lookupanim(param_00,param_01)
{
	if(isdefined(self.var_DC4))
	{
		if(isdefined(level.archetypes[self.var_DC4][param_00]) && isdefined(level.archetypes[self.var_DC4][param_00][param_01]))
		{
			return level.archetypes[self.var_DC4][param_00][param_01];
		}
	}

	return level.archetypes["soldier"][param_00][param_01];
}

//Function Number: 145
func_4F5D(param_00)
{
	if(isdefined(self.var_DC4))
	{
		if(isdefined(level.archetypes[self.var_DC4][param_00]))
		{
			var_01 = level.archetypes["soldier"][param_00];
			foreach(var_04, var_03 in level.archetypes[self.var_DC4][param_00])
			{
				var_01[var_04] = var_03;
			}

			return var_01;
		}
	}

	return level.archetypes["soldier"][var_04];
}

//Function Number: 146
func_4F60(param_00,param_01,param_02)
{
	if(isdefined(self.var_DC4))
	{
		if(isdefined(level.archetypes[self.var_DC4][param_00]) && isdefined(level.archetypes[self.var_DC4][param_00][param_01]) && isdefined(level.archetypes[self.var_DC4][param_00][param_01][param_02]))
		{
			return level.archetypes[self.var_DC4][param_00][param_01][param_02];
		}
	}

	return level.archetypes["soldier"][param_00][param_01][param_02];
}

//Function Number: 147
func_4F5F(param_00,param_01)
{
	if(isdefined(self.var_DC4))
	{
		if(isdefined(level.archetypes[self.var_DC4][param_00]) && isdefined(level.archetypes[self.var_DC4][param_00][param_01]))
		{
			return level.archetypes[self.var_DC4][param_00][param_01];
		}
	}

	return level.archetypes["dog"][param_00][param_01];
}