/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\utility.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 132
 * Decompile Time: 2198 ms
 * Timestamp: 10/27/2023 2:31:02 AM
*******************************************************************/

//Function Number: 1
initanimtree(param_00)
{
	self clearanim(%body,0.3);
	self setanim(%body,1,0);
	if(param_00 != "pain" && param_00 != "death")
	{
		self.a.special = "none";
	}

	self.missedsightchecks = 0;
	self.a.var_8AE = 1;
	self.a.aimweight_start = 1;
	self.a.aimweight_end = 1;
	self.a.aimweight_transframes = 0;
	self.a.aimweight_t = 0;
	isincombat();
}

//Function Number: 2
updateanimpose()
{
	if(isdefined(self.desired_anim_pose) && self.desired_anim_pose != self.a.var_911)
	{
		if(self.a.var_911 == "prone")
		{
			exitpronewrapper(0.5);
		}

		if(self.desired_anim_pose == "prone")
		{
			self setproneanimnodes(-45,45,%prone_legs_down,%exposed_aiming,%prone_legs_up);
			enterpronewrapper(0.5);
			self setanimknoball(%prone_aim_5,%body,1,0.1,1);
		}
	}

	self.desired_anim_pose = undefined;
}

//Function Number: 3
initialize(param_00)
{
	if(isdefined(self.longdeathstarting))
	{
		if(param_00 != "pain" && param_00 != "death")
		{
			self kill(self.origin);
		}

		if(param_00 != "pain")
		{
			self.longdeathstarting = undefined;
			self notify("kill_long_death");
		}
	}

	if(isdefined(self.a.mayonlydie) && param_00 != "death")
	{
		self kill(self.origin);
	}

	if(isdefined(self.a.var_1C2F))
	{
		var_01 = self.a.var_1C2F;
		self.a.var_1C2F = undefined;
		[[ var_01 ]](param_00);
	}

	if(param_00 != "combat" && param_00 != "pain" && param_00 != "death" && usingsidearm())
	{
		animscripts/combat::switchtolastweapon(%pistol_stand_switch,1);
	}

	if(param_00 != "combat" && param_00 != "move" && param_00 != "pain")
	{
		self.a.magicreloadwhenreachenemy = undefined;
	}

	if(param_00 != "death")
	{
		self.a.nodeath = 0;
	}

	if(isdefined(self.isholdinggrenade) && param_00 == "pain" || param_00 == "death" || param_00 == "flashed")
	{
		animscripts/combat_utility::func_1F2C();
	}

	self.isholdinggrenade = undefined;
	animscripts/squadmanager::func_6AE(param_00);
	self.covernode = undefined;
	self.suppressed = 0;
	self.isreloading = 0;
	self.var_8C8 = 0;
	self.a.aimidlethread = undefined;
	self.a.scriptstarttime = gettime();
	self.a.atconcealmentnode = 0;
	if(isdefined(self.node) && self.node.type == "Conceal Prone" || self.node.type == "Conceal Crouch" || self.node.type == "Conceal Stand")
	{
		self.a.atconcealmentnode = 1;
	}

	initanimtree(param_00);
	updateanimpose();
}

//Function Number: 4
getpreferredweapon()
{
	if(isdefined(self.wantshotgun) && self.wantshotgun)
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
func_1FFF(param_00,param_01,param_02)
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
func_2000()
{
	self endon("death");
	self notify("displaceprint");
	self endon("displaceprint");
	wait 0.05;
}

//Function Number: 7
isincombat()
{
	if(self.alertlevelint > 1)
	{
		return 1;
	}

	if(isdefined(self.enemy))
	{
		self.a.var_1C2B = gettime() + level.var_1C4C + randomint(level.var_1C4D);
		return 1;
	}

	return self.a.var_1C2B > gettime();
}

//Function Number: 8
getenemyeyepos()
{
	if(isdefined(self.enemy))
	{
		self.a.var_2001 = self.enemy getshootatpos();
		self.a.lastenemytime = gettime();
		return self.a.var_2001;
	}

	if(isdefined(self.a.lastenemytime) && isdefined(self.a.var_2001) && self.a.lastenemytime + 3000 < gettime())
	{
		return self.a.var_2001;
	}

	var_00 = self getshootatpos();
	var_00 = var_00 + (196 * self.lookforward[0],196 * self.lookforward[1],196 * self.lookforward[2]);
	return var_00;
}

//Function Number: 9
getnodeforwardyaw(param_00)
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
func_2002(param_00)
{
	if(isdefined(self.node))
	{
		var_01 = self.node.angles[1] - func_0C05(param_00);
	}
	else
	{
		var_01 = self.angles[1] - func_0C05(var_01);
	}

	var_01 = angleclamp180(var_01);
	return var_01;
}

//Function Number: 11
getnodeyawtoenemy()
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
		var_02 = self.node.angles[1] - func_0C05(var_00);
	}
	else
	{
		var_02 = self.angles[1] - func_0C05(var_02);
	}

	var_02 = angleclamp180(var_02);
	return var_02;
}

//Function Number: 12
getyawtospot(param_00)
{
	var_01 = self.angles[1] - func_0C05(param_00);
	var_01 = angleclamp180(var_01);
	return var_01;
}

//Function Number: 13
getyawtoenemy()
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

	var_02 = self.angles[1] - func_0C05(var_00);
	var_02 = angleclamp180(var_02);
	return var_02;
}

//Function Number: 14
func_0C05(param_00)
{
	return vectortoyaw(param_00 - self.origin);
}

//Function Number: 15
func_2003(param_00)
{
	var_01 = vectortoangles((param_00[0],param_00[1],0) - (self.origin[0],self.origin[1],0));
	return var_01[1];
}

//Function Number: 16
func_2004()
{
	var_00 = self.angles[1] - func_0C05(self.enemy.origin);
	var_00 = angleclamp180(var_00);
	if(var_00 < 0)
	{
		var_00 = -1 * var_00;
	}

	return var_00;
}

//Function Number: 17
absyawtoenemy2d()
{
	var_00 = self.angles[1] - func_2003(self.enemy.origin);
	var_00 = angleclamp180(var_00);
	if(var_00 < 0)
	{
		var_00 = -1 * var_00;
	}

	return var_00;
}

//Function Number: 18
absyawtoorigin(param_00)
{
	var_01 = self.angles[1] - func_0C05(param_00);
	var_01 = angleclamp180(var_01);
	if(var_01 < 0)
	{
		var_01 = -1 * var_01;
	}

	return var_01;
}

//Function Number: 19
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

//Function Number: 20
func_2008(param_00,param_01)
{
	var_02 = vectortoangles(param_00 - param_01);
	return var_02[1];
}

//Function Number: 21
getyawtotag(param_00,param_01)
{
	var_02 = self gettagangles(param_00)[1] - func_2008(param_01,self gettagorigin(param_00));
	var_02 = angleclamp180(var_02);
	return var_02;
}

//Function Number: 22
func_1FD1(param_00)
{
	var_01 = self.angles[1] - func_0C05(param_00);
	var_01 = angleclamp180(var_01);
	return var_01;
}

//Function Number: 23
func_200A(param_00)
{
	var_01 = self gettagangles("TAG_EYE")[1] - func_0C05(param_00);
	var_01 = angleclamp180(var_01);
	return var_01;
}

//Function Number: 24
isstanceallowedwrapper(param_00)
{
	if(isdefined(self.covernode))
	{
		return self.covernode doesnodeallowstance(param_00);
	}

	return self isstanceallowed(param_00);
}

//Function Number: 25
choosepose(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = self.a.var_911;
	}

	switch(param_00)
	{
		case "stand":
			if(isstanceallowedwrapper("stand"))
			{
				var_01 = "stand";
			}
			else if(isstanceallowedwrapper("crouch"))
			{
				var_01 = "crouch";
			}
			else if(isstanceallowedwrapper("prone"))
			{
				var_01 = "prone";
			}
			else
			{
				var_01 = "stand";
			}
			break;

		case "crouch":
			if(isstanceallowedwrapper("crouch"))
			{
				var_01 = "crouch";
			}
			else if(isstanceallowedwrapper("stand"))
			{
				var_01 = "stand";
			}
			else if(isstanceallowedwrapper("prone"))
			{
				var_01 = "prone";
			}
			else
			{
				var_01 = "crouch";
			}
			break;

		case "prone":
			if(isstanceallowedwrapper("prone"))
			{
				var_01 = "prone";
			}
			else if(isstanceallowedwrapper("crouch"))
			{
				var_01 = "crouch";
			}
			else if(isstanceallowedwrapper("stand"))
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
getclaimednode()
{
	var_00 = self.node;
	if(isdefined(var_00) && self nearnode(var_00) || isdefined(self.covernode) && var_00 == self.covernode)
	{
		return var_00;
	}

	return undefined;
}

//Function Number: 27
getnodetype()
{
	var_00 = getclaimednode();
	if(isdefined(var_00))
	{
		return var_00.type;
	}

	return "none";
}

//Function Number: 28
getnodedirection()
{
	var_00 = getclaimednode();
	if(isdefined(var_00))
	{
		return var_00.angles[1];
	}

	return self.desiredangle;
}

//Function Number: 29
getnodeforward()
{
	var_00 = getclaimednode();
	if(isdefined(var_00))
	{
		return anglestoforward(var_00.angles);
	}

	return anglestoforward(self.angles);
}

//Function Number: 30
getnodeorigin()
{
	var_00 = getclaimednode();
	if(isdefined(var_00))
	{
		return var_00.origin;
	}

	return self.origin;
}

//Function Number: 31
safemod(param_00,param_01)
{
	var_02 = int(param_00) % param_01;
	var_02 = var_02 + param_01;
	return var_02 % param_01;
}

//Function Number: 32
absangleclamp180(param_00)
{
	return abs(angleclamp180(param_00));
}

//Function Number: 33
quadrantanimweights(param_00)
{
	var_01 = cos(param_00);
	var_02 = sin(param_00);
	var_03["front"] = 0;
	if(isdefined(self.alwaysrunforward))
	{
		return var_41;
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
			var_41["left"] = 1;
		}
		else if(var_03 < var_02)
		{
			var_41["right"] = 1;
		}
		else
		{
			var_41["back"] = 1;
		}
	}

	return var_41;
}

//Function Number: 34
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

//Function Number: 35
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

//Function Number: 36
playanim(param_00)
{
	if(isdefined(param_00))
	{
		self setflaggedanimknoballrestart("playAnim",param_00,%root,1,0.1,1);
		var_01 = getanimlength(param_00);
		var_01 = 3 * var_01 + 1;
		thread func_2010("time is up","time is up",var_01);
		self waittill("time is up");
		self notify("enddrawstring");
	}
}

//Function Number: 37
func_2010(param_00,param_01,param_02)
{
	self endon("death");
	self endon(param_01);
	wait param_02;
	self notify(param_00);
}

//Function Number: 38
drawstring(param_00)
{
	self endon("killanimscript");
	self endon("enddrawstring");
	wait 0.05;
}

//Function Number: 39
func_2012(param_00,param_01,param_02,param_03)
{
	var_04 = param_03 * 20;
	for(var_05 = 0;var_05 < var_04;var_05++)
	{
		wait 0.05;
	}
}

//Function Number: 40
func_2013(param_00)
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
hasenemysightpos()
{
	if(isdefined(self.node))
	{
		return func_0B35() || cansuppressenemyfromexposed();
	}

	return canseeenemy() || cansuppressenemy();
}

//Function Number: 42
getenemysightpos()
{
	return self.goodshootpos;
}

//Function Number: 43
util_ignorecurrentsightpos()
{
	if(!hasenemysightpos())
	{
		return;
	}

	self.ignoresightpos = getenemysightpos();
	self.ignoreorigin = self.origin;
}

//Function Number: 44
func_2017()
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
	var_02 = self canshoot(getenemysightpos(),var_01);
	if(!var_02)
	{
		self.ignoresightpos = getenemysightpos();
		return 0;
	}

	return 1;
}

//Function Number: 45
debugtimeout()
{
	wait 5;
	self notify("timeout");
}

//Function Number: 46
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

	wait 0.05;
}

//Function Number: 47
debugpos(param_00,param_01)
{
	thread debugposinternal(param_00,param_01,2.15);
}

//Function Number: 48
debugpossize(param_00,param_01,param_02)
{
	thread debugposinternal(param_00,param_01,param_02);
}

//Function Number: 49
debugburstprint(param_00,param_01)
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

//Function Number: 50
func_201D()
{
	self endon("death");
	self notify("stop shoot " + self.var_1DEB);
	self endon("stop shoot " + self.var_1DEB);
	var_00 = 0.25;
	var_01 = var_00 * 20;
	for(var_02 = 0;var_02 < var_01;var_02 = var_02 + 1)
	{
		wait 0.05;
	}
}

//Function Number: 51
func_201E()
{
}

//Function Number: 52
func_201F(param_00,param_01,param_02,param_03)
{
	self endon("death");
	var_04 = param_03 * 20;
	for(var_05 = 0;var_05 < var_04;var_05 = var_05 + 1)
	{
		wait 0.05;
	}
}

//Function Number: 53
showdebugline(param_00,param_01,param_02,param_03)
{
	thread func_201F(param_00,param_01 + (0,0,-5),param_02,param_03);
}

//Function Number: 54
shootenemywrapper()
{
	[[ level.shootenemywrapper_func ]]();
}

//Function Number: 55
func_2021()
{
	self.a.lastshoottime = gettime();
	maps\_gameskill::func_1E92();
	self notify("shooting");
	self shoot();
}

//Function Number: 56
shootenemywrapper_shootnotify()
{
	level notify("an_enemy_shot",self);
	func_2021();
}

//Function Number: 57
shootposwrapper(param_00)
{
	var_01 = bulletspread(self getmuzzlepos(),param_00,4);
	self.a.lastshoottime = gettime();
	self notify("shooting");
	self shoot(1,var_01);
}

//Function Number: 58
func_2022()
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
func_1C4E(param_00)
{
	level.idleanimtransition["stand"]["in"] = %casual_stand_idle_trans_in;
	level.idleanimarray["stand"][0][0] = %casual_stand_idle;
	level.idleanimarray["stand"][0][1] = %casual_stand_idle_twitch;
	level.idleanimarray["stand"][0][2] = %casual_stand_idle_twitchb;
	level.idleanimweights["stand"][0][0] = 2;
	level.idleanimweights["stand"][0][1] = 1;
	level.idleanimweights["stand"][0][2] = 1;
	level.idleanimarray["stand"][1][0] = %casual_stand_v2_idle;
	level.idleanimarray["stand"][1][1] = %casual_stand_v2_twitch_radio;
	level.idleanimarray["stand"][1][2] = %casual_stand_v2_twitch_shift;
	level.idleanimarray["stand"][1][3] = %casual_stand_v2_twitch_talk;
	level.idleanimweights["stand"][1][0] = 10;
	level.idleanimweights["stand"][1][1] = 4;
	level.idleanimweights["stand"][1][2] = 7;
	level.idleanimweights["stand"][1][3] = 4;
	level.idleanimarray["stand_cqb"][0][0] = %cqb_stand_idle;
	level.idleanimarray["stand_cqb"][0][1] = %cqb_stand_twitch;
	level.idleanimweights["stand_cqb"][0][0] = 2;
	level.idleanimweights["stand_cqb"][0][1] = 1;
	level.idleanimtransition["crouch"]["in"] = %casual_crouch_idle_in;
	level.idleanimarray["crouch"][0][0] = %casual_crouch_idle;
	level.idleanimweights["crouch"][0][0] = 6;
}

//Function Number: 60
func_2023()
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
			if(isdefined(self.isindoor) && self.isindoor == 1)
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
personalcoldbreathstop()
{
	self notify("stop personal effect");
}

//Function Number: 62
func_2025()
{
	self endon("death");
	self notify("stop personal effect");
	self endon("stop personal effect");
	for(;;)
	{
		self waittill("spawned",var_00);
		if(maps\_utility::func_F77(var_00))
		{
			continue;
		}

		var_00 thread func_2023();
	}
}

//Function Number: 63
issuppressedwrapper()
{
	if(isdefined(self.forcesuppression))
	{
		return self.forcesuppression;
	}

	if(self.suppressionmeter <= self.suppressionthreshold)
	{
		return 0;
	}

	return self issuppressed();
}

//Function Number: 64
ispartiallysuppressedwrapper()
{
	if(self.suppressionmeter <= self.suppressionthreshold * 0.25)
	{
		return 0;
	}

	return self issuppressed();
}

//Function Number: 65
getnodeoffset(param_00)
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
				var_08 = calculatenodeoffset(var_09,var_0A,var_01);
			}
			else
			{
				var_08 = calculatenodeoffset(var_09,var_0A,var_02);
			}
			break;

		case "Cover Right":
			if(param_00 gethighestnodestance() == "crouch")
			{
				var_08 = calculatenodeoffset(var_09,var_0A,var_03);
			}
			else
			{
				var_08 = calculatenodeoffset(var_09,var_0A,var_04);
			}
			break;

		case "Turret":
		case "Cover Stand":
		case "Conceal Stand":
			var_08 = calculatenodeoffset(var_09,var_0A,var_06);
			break;

		case "Cover Crouch Window":
		case "Cover Crouch":
		case "Conceal Crouch":
			var_08 = calculatenodeoffset(var_09,var_0A,var_05);
			break;
	}

	param_00.offset = var_08;
	return param_00.offset;
}

//Function Number: 66
calculatenodeoffset(param_00,param_01,param_02)
{
	return param_00 * param_02[0] + param_01 * param_02[1] + (0,0,param_02[2]);
}

//Function Number: 67
recentlysawenemy()
{
	return isdefined(self.enemy) && self seerecently(self.enemy,5);
}

//Function Number: 68
canseeenemy(param_00)
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
		func_2029();
		return 1;
	}

	return 0;
}

//Function Number: 69
func_0B35()
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
		func_2029();
	}
	else
	{
	}

	return var_01;
}

//Function Number: 70
canseepointfromexposedatnode(param_00,param_01)
{
	if(param_01.type == "Cover Left" || param_01.type == "Cover Right")
	{
		if(!animscripts/corner::canseepointfromexposedatcorner(param_00,param_01))
		{
			return 0;
		}
	}

	var_02 = getnodeoffset(param_01);
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

		return 0;
	}

	return 1;
}

//Function Number: 71
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

		if(var_05 < level.var_898 + var_03)
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 72
func_2029()
{
	self.a.shouldresetgiveuponsuppressiontimer = 1;
}

//Function Number: 73
updategiveuponsuppressiontimer()
{
	if(!isdefined(self.a.shouldresetgiveuponsuppressiontimer))
	{
		self.a.shouldresetgiveuponsuppressiontimer = 1;
	}

	if(self.a.shouldresetgiveuponsuppressiontimer)
	{
		self.a.giveuponsuppressiontime = gettime() + randomintrange(15000,30000);
		self.a.shouldresetgiveuponsuppressiontimer = 0;
	}
}

//Function Number: 74
showlines(param_00,param_01,param_02)
{
	for(;;)
	{
		wait 0.05;
		wait 0.05;
	}
}

//Function Number: 75
func_202E()
{
	if(!self canattackenemynode())
	{
		return 0;
	}

	var_00 = undefined;
	if(isdefined(self.enemy.node))
	{
		var_01 = getnodeoffset(self.enemy.node);
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
cansuppressenemyfromexposed()
{
	if(!hassuppressableenemy())
	{
		self.goodshootpos = undefined;
		return 0;
	}

	if(!isplayer(self.enemy))
	{
		return func_202E();
	}

	if(isdefined(self.node))
	{
		if(self.node.type == "Cover Left" || self.node.type == "Cover Right")
		{
			if(!animscripts/corner::canseepointfromexposedatcorner(getenemyeyepos(),self.node))
			{
				return 0;
			}
		}

		var_00 = getnodeoffset(self.node);
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

	return func_2034(var_01);
}

//Function Number: 77
cansuppressenemy()
{
	if(!hassuppressableenemy())
	{
		self.goodshootpos = undefined;
		return 0;
	}

	if(!isplayer(self.enemy))
	{
		return func_202E();
	}

	var_00 = self getmuzzlepos();
	if(!checkpitchvisibility(var_00,self.lastenemysightpos))
	{
		return 0;
	}

	return func_2034(var_00);
}

//Function Number: 78
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

	updategiveuponsuppressiontimer();
	if(gettime() > self.a.giveuponsuppressiontime)
	{
		return 0;
	}

	if(!needrecalculatesuppressspot())
	{
		return isdefined(self.goodshootpos);
	}

	return 1;
}

//Function Number: 79
canseeandshootpoint(param_00)
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
needrecalculatesuppressspot()
{
	if(isdefined(self.goodshootpos) && !canseeandshootpoint(self.goodshootpos))
	{
		return 1;
	}

	return !isdefined(self.lastenemysightposold) || self.lastenemysightposold != self.lastenemysightpos || distancesquared(self.var_2033,self.origin) > 1024;
}

//Function Number: 81
func_2034(param_00)
{
	if(!needrecalculatesuppressspot())
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

	self.var_2033 = self.origin;
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

//Function Number: 82
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

//Function Number: 83
print3dtime(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = param_00 / 0.05;
	for(var_07 = 0;var_07 < var_06;var_07++)
	{
		wait 0.05;
	}
}

//Function Number: 84
func_2036(param_00,param_01,param_02,param_03,param_04)
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
func_2037(param_00,param_01)
{
	return param_00[0] * param_01[1] - param_00[1] * param_01[0] > 0;
}

//Function Number: 86
getgrenademodel()
{
	return getweaponmodel(self.grenadeweapon);
}

//Function Number: 87
sawenemymove(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 500;
	}

	return gettime() - self.personalsighttime < param_00;
}

//Function Number: 88
func_203A()
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
usingboltactionweapon()
{
	return weaponisboltaction(self.weapon);
}

//Function Number: 90
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

//Function Number: 91
setfootstepeffect(param_00,param_01)
{
	if(!isdefined(level.var_1C53))
	{
		anim.var_1C53 = [];
	}

	level.var_1C53[level.var_1C53.size] = param_00;
	level._effect["step_" + param_00] = param_01;
}

//Function Number: 92
setfootstepeffectsmall(param_00,param_01)
{
	if(!isdefined(level.optionalstepeffectssmall))
	{
		anim.optionalstepeffectssmall = [];
	}

	level.optionalstepeffectssmall[level.optionalstepeffectssmall.size] = param_00;
	level._effect["step_small_" + param_00] = param_01;
}

//Function Number: 93
func_203F(param_00,param_01,param_02,param_03,param_04,param_05)
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
		level._notetrackfx[param_00][param_02].sound_prefix = param_04;
	}

	if(isdefined(param_05))
	{
		level._notetrackfx[param_00][param_02].sound_suffix = param_05;
	}
}

//Function Number: 94
func_2040(param_00,param_01)
{
	self endon("death");
	level notify("newdebugline");
	level endon("newdebugline");
	wait 0.05;
}

//Function Number: 95
enterpronewrapper(param_00)
{
	thread enterpronewrapperproc(param_00);
}

//Function Number: 96
enterpronewrapperproc(param_00)
{
	self endon("death");
	self notify("anim_prone_change");
	self endon("anim_prone_change");
	self enterprone(param_00,isdefined(self.a.onback));
	self waittill("killanimscript");
	if(self.a.var_911 != "prone" && !isdefined(self.a.onback))
	{
		self.a.var_911 = "prone";
	}
}

//Function Number: 97
exitpronewrapper(param_00)
{
	thread exitpronewrapperproc(param_00);
}

//Function Number: 98
exitpronewrapperproc(param_00)
{
	self endon("death");
	self notify("anim_prone_change");
	self endon("anim_prone_change");
	self exitprone(param_00);
	self waittill("killanimscript");
	if(self.a.var_911 == "prone")
	{
		self.a.var_911 = "crouch";
	}
}

//Function Number: 99
canblindfire()
{
	if(self.a.atconcealmentnode)
	{
		return 0;
	}

	if(!animscripts/weaponlist::usingautomaticweapon())
	{
		return 0;
	}

	if(weaponclass(self.weapon) == "mg")
	{
		return 0;
	}

	if(isdefined(self.var_2043) && self.var_2043 == 1)
	{
		return 0;
	}

	return 1;
}

//Function Number: 100
canhitsuppressspot()
{
	if(!hasenemysightpos())
	{
		return 0;
	}

	var_00 = self getmuzzlepos();
	return sighttracepassed(var_00,getenemysightpos(),0,undefined);
}

//Function Number: 101
moveanim(param_00)
{
	return self.a.moveanimset[param_00];
}

//Function Number: 102
randomanimoftwo(param_00,param_01)
{
	if(randomint(2))
	{
		return param_00;
	}

	return param_01;
}

//Function Number: 103
animarray(param_00)
{
	return self.a.array[param_00];
}

//Function Number: 104
animarrayanyexist(param_00)
{
	return self.a.array[param_00].size > 0;
}

//Function Number: 105
animarraypickrandom(param_00)
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
		return var_41;
	}

	if(isdefined(param_02))
	{
	}
	else
	{
		return var_41;
	}

	if(isdefined(param_03))
	{
	}
	else
	{
		return var_41;
	}

	if(isdefined(param_04))
	{
	}
	else
	{
		return var_41;
	}

	if(isdefined(param_05))
	{
	}
	else
	{
		return var_41;
	}

	if(isdefined(param_06))
	{
	}
	else
	{
		return var_41;
	}

	if(isdefined(param_07))
	{
	}
	else
	{
		return var_41;
	}

	if(isdefined(param_08))
	{
	}
	else
	{
		return var_41;
	}

	if(isdefined(param_09))
	{
	}
	else
	{
		return var_41;
	}

	if(isdefined(param_0A))
	{
	}
	else
	{
		return var_41;
	}

	if(isdefined(param_0B))
	{
	}
	else
	{
		return var_41;
	}

	if(isdefined(param_0C))
	{
	}
	else
	{
		return var_41;
	}

	if(isdefined(param_0D))
	{
	}
	else
	{
		return var_41;
	}

	if(isdefined(var_0E))
	{
	}

	return var_41;
}

//Function Number: 107
func_0D45()
{
	return self.primaryweapon;
}

//Function Number: 108
getaisecondaryweapon()
{
	return self.secondaryweapon;
}

//Function Number: 109
getaisidearmweapon()
{
	return self.sidearm;
}

//Function Number: 110
getaicurrentweapon()
{
	return self.weapon;
}

//Function Number: 111
usingprimary()
{
	return self.weapon == self.primaryweapon && self.weapon != "none";
}

//Function Number: 112
func_2048()
{
	return self.weapon == self.secondaryweapon && self.weapon != "none";
}

//Function Number: 113
usingsidearm()
{
	return self.weapon == self.sidearm && self.weapon != "none";
}

//Function Number: 114
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

	if(self.weapon == self.sidearm)
	{
		return "sidearm";
	}
}

//Function Number: 115
aihasweapon(param_00)
{
	if(isdefined(self.weaponinfo[param_00]))
	{
		return 1;
	}

	return 0;
}

//Function Number: 116
getanimendpos(param_00)
{
	var_01 = getmovedelta(param_00,0,1);
	return self localtoworldcoords(var_01);
}

//Function Number: 117
damagelocationisany(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B)
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
usingpistol()
{
	return weaponclass(self.weapon) == "pistol";
}

//Function Number: 119
usingrocketlauncher()
{
	return weaponclass(self.weapon) == "rocketlauncher";
}

//Function Number: 120
usingmg()
{
	return weaponclass(self.weapon) == "mg";
}

//Function Number: 121
func_1F02()
{
	return weaponclass(self.weapon) == "spread";
}

//Function Number: 122
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

//Function Number: 123
ragdolldeath(param_00)
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
			self.a.nodeath = 1;
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
shouldcqb()
{
	return isdefined(self.cqbwalking) && !isdefined(self.grenade);
}

//Function Number: 125
iscqbwalking()
{
	return isdefined(self.cqbwalking);
}

//Function Number: 126
iscqbwalkingorfacingenemy()
{
	return !self.facemotion || isdefined(self.cqbwalking);
}

//Function Number: 127
randomizeidleset()
{
	self.a.idleset = randomint(2);
}

//Function Number: 128
isshotgun(param_00)
{
	return weaponclass(param_00) == "spread";
}

//Function Number: 129
issniperrifle(param_00)
{
	return weaponclass(param_00) == "sniper";
}

//Function Number: 130
weapon_pump_action_shotgun()
{
	return self.weapon != "none" && weaponisboltaction(self.weapon) && weaponclass(self.weapon) == "spread";
}

//Function Number: 131
getrandomintfromseed(param_00,param_01)
{
	var_02 = param_00 % level.randominttablesize;
	return level.randominttable[var_02] % param_01;
}

//Function Number: 132
getcurrentweaponslotname()
{
	if(func_2048())
	{
		return "secondary";
	}

	if(usingsidearm())
	{
		return "sidearm";
	}

	return "primary";
}