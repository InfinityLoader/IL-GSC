/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\utility.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 157
 * Decompile Time: 2517 ms
 * Timestamp: 10/27/2023 1:55:48 AM
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

	self.a.aimweight = 1;
	self.a.aimweight_start = 1;
	self.a.aimweight_end = 1;
	self.a.aimweight_transframes = 0;
	self.a.aimweight_t = 0;
	updateisincombattimer();
}

//Function Number: 2
updateanimpose()
{
	if(isdefined(self.desired_anim_pose) && self.desired_anim_pose != self.a.pose)
	{
		if(self.a.pose == "prone")
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

	if(isdefined(self.a.postscriptfunc))
	{
		var_01 = self.a.postscriptfunc;
		self.a.postscriptfunc = undefined;
		[[ var_01 ]](param_00);
	}

	if(param_00 != "combat" && param_00 != "pain" && param_00 != "death" && usingsidearm())
	{
		animscripts\combat::switchtolastweapon(lookupanim("combat","pistol_to_primary"),1);
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
		animscripts\combat_utility::dropgrenade();
	}

	self.isholdinggrenade = undefined;
	animscripts\squadmanager::aiupdateanimstate(param_00);
	self.covernode = undefined;
	self.suppressed = 0;
	self.isreloading = 0;
	self.changingcoverpos = 0;
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
printdisplaceinfo()
{
	self endon("death");
	self notify("displaceprint");
	self endon("displaceprint");
	wait(0.05);
}

//Function Number: 7
isincombat(param_00)
{
	if((!isdefined(param_00) || param_00) && self.alertlevelint > 1)
	{
		return 1;
	}

	if(isdefined(self.enemy))
	{
		return 1;
	}

	return self.a.combatendtime > gettime();
}

//Function Number: 8
updateisincombattimer()
{
	if(isdefined(self.enemy))
	{
		self.a.combatendtime = gettime() + level.combatmemorytimeconst + randomint(level.combatmemorytimerand);
	}
}

//Function Number: 9
getenemyeyepos()
{
	if(isdefined(self.enemy))
	{
		if(common_scripts\utility::flag("_cloaked_stealth_enabled"))
		{
			self.a.lastenemypos = animscripts\combat_utility::get_last_known_shoot_pos(self.enemy);
		}
		else
		{
			self.a.lastenemypos = self.enemy getshootatpos();
		}

		self.a.lastenemytime = gettime();
		return self.a.lastenemypos;
	}

	if(isdefined(self.a.lastenemytime) && isdefined(self.a.lastenemypos) && self.a.lastenemytime + 3000 < gettime())
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
		if(isnodecoverleft(param_00))
		{
			return param_00.angles[1] + 90;
		}
		else if(isnodecoverright(param_00))
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
		var_01 = self.node.angles[1] - getyaw(param_00);
	}
	else
	{
		var_01 = self.angles[1] - getyaw(var_01);
	}

	var_01 = angleclamp180(var_01);
	return var_01;
}

//Function Number: 12
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
		var_02 = self.node.angles[1] - getyaw(var_00);
	}
	else
	{
		var_02 = self.angles[1] - getyaw(var_02);
	}

	var_02 = angleclamp180(var_02);
	return var_02;
}

//Function Number: 13
getyawtospot(param_00)
{
	if(isspaceai())
	{
		var_01 = anglestoforward(self.angles);
		var_02 = rotatepointaroundvector(var_01,param_00 - self.origin,self.angles[2] * -1);
		param_00 = var_02 + self.origin;
	}

	var_03 = self.angles[1] - getyaw(param_00);
	var_03 = angleclamp180(var_03);
	return var_03;
}

//Function Number: 14
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

	var_02 = self.angles[1] - getyaw(var_00);
	var_02 = angleclamp180(var_02);
	return var_02;
}

//Function Number: 15
getyaw(param_00)
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
	var_00 = self.angles[1] - getyaw(self.enemy.origin);
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
absyawtoorigin(param_00)
{
	var_01 = self.angles[1] - getyaw(param_00);
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
getyawfromorigin(param_00,param_01)
{
	var_02 = vectortoangles(param_00 - param_01);
	return var_02[1];
}

//Function Number: 22
getyawtotag(param_00,param_01)
{
	var_02 = self gettagangles(param_00)[1] - getyawfromorigin(param_01,self gettagorigin(param_00));
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
		var_04 = var_01[1] - getyaw(var_03);
		var_04 = angleclamp180(var_04);
		return var_04;
	}

	var_04 = self.angles[1] - getyaw(var_04);
	var_04 = angleclamp180(var_04);
	return var_04;
}

//Function Number: 24
geteyeyawtoorigin(param_00)
{
	var_01 = self gettagangles("TAG_EYE")[1] - getyaw(param_00);
	var_01 = angleclamp180(var_01);
	return var_01;
}

//Function Number: 25
isstanceallowedwrapper(param_00)
{
	if(isdefined(self.covernode))
	{
		return self.covernode doesnodeallowstance(param_00);
	}

	return self isstanceallowed(param_00);
}

//Function Number: 26
choosepose(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = self.a.pose;
	}

	switch(param_00)
	{
		case "stand":
			break;

		case "crouch":
			break;

		case "prone":
			break;

		default:
			break;
	}
}

//Function Number: 27
getclaimednode()
{
	var_00 = self.node;
	if(isdefined(var_00) && self nearnode(var_00) || isdefined(self.covernode) && var_00 == self.covernode)
	{
		return var_00;
	}

	return undefined;
}

//Function Number: 28
getnodetype()
{
	var_00 = getclaimednode();
	if(isdefined(var_00))
	{
		return var_00.type;
	}

	return "none";
}

//Function Number: 29
getnodedirection()
{
	var_00 = getclaimednode();
	if(isdefined(var_00))
	{
		return var_00.angles[1];
	}

	return self.desiredangle;
}

//Function Number: 30
getnodeforward()
{
	var_00 = getclaimednode();
	if(isdefined(var_00))
	{
		return anglestoforward(var_00.angles);
	}

	return anglestoforward(self.angles);
}

//Function Number: 31
getnodeorigin()
{
	var_00 = getclaimednode();
	if(isdefined(var_00))
	{
		return var_00.origin;
	}

	return self.origin;
}

//Function Number: 32
safemod(param_00,param_01)
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
playanim(param_00)
{
	if(isdefined(param_00))
	{
		self setflaggedanimknoballrestart("playAnim",param_00,%animscript_root,1,0.1,1);
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
drawstringtime(param_00,param_01,param_02,param_03)
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
		return canseeenemyfromexposed() || cansuppressenemyfromexposed();
	}

	return canseeenemy() || cansuppressenemy();
}

//Function Number: 43
getenemysightpos()
{
	return self.goodshootpos;
}

//Function Number: 44
util_ignorecurrentsightpos()
{
	if(!hasenemysightpos())
	{
		return;
	}

	self.ignoresightpos = getenemysightpos();
	self.ignoreorigin = self.origin;
}

//Function Number: 45
util_evaluateknownenemylocation()
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

//Function Number: 51
printshootproc()
{
	self endon("death");
	self notify("stop shoot " + self.export);
	self endon("stop shoot " + self.export);
	var_00 = 0.25;
	var_01 = var_00 * 20;
	for(var_02 = 0;var_02 < var_01;var_02 = var_02 + 1)
	{
		wait(0.05);
	}
}

//Function Number: 52
printshoot()
{
}

//Function Number: 53
showdebugproc(param_00,param_01,param_02,param_03)
{
	self endon("death");
	var_04 = param_03 * 20;
	for(var_05 = 0;var_05 < var_04;var_05 = var_05 + 1)
	{
		wait(0.05);
	}
}

//Function Number: 54
showdebugline(param_00,param_01,param_02,param_03)
{
	thread showdebugproc(param_00,param_01 + (0,0,-5),param_02,param_03);
}

//Function Number: 55
shootenemywrapper(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 1;
	}

	[[ level.shootenemywrapper_func ]](param_00);
}

//Function Number: 56
shootenemywrapper_normal(param_00)
{
	self.a.lastshoottime = gettime();
	maps\_gameskill::set_accuracy_based_on_situation();
	self notify("shooting");
	self shoot(1,undefined,param_00);
}

//Function Number: 57
shootenemywrapper_shootnotify(param_00)
{
	level notify("an_enemy_shot",self);
	shootenemywrapper_normal(param_00);
}

//Function Number: 58
shootposwrapper(param_00,param_01)
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
throwgun()
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
personalcoldbreath()
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

		if(isdefined(self.a.movement) && self.a.movement == "stop")
		{
			if(isdefined(self.isindoor) && self.isindoor == 1)
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
personalcoldbreathspawner()
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

		var_00 thread personalcoldbreath();
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
isspaceai()
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
	if(self.suppressionmeter <= self.suppressionthreshold * 0.25)
	{
		return 0;
	}

	return self issuppressed();
}

//Function Number: 67
getnodeoffset(param_00,param_01)
{
	if(isdefined(param_00.offset))
	{
		return param_00.offset;
	}

	var_02 = (-26,0.4,36);
	var_03 = (-32,7,63);
	var_04 = (43.5,11,36);
	var_05 = (36,8.3,63);
	var_06 = (3.5,-12.5,45);
	var_07 = (-3.7,-22,63);
	var_08 = 0;
	var_09 = (0,0,0);
	var_0A = anglestoright(param_00.angles);
	var_0B = anglestoforward(param_00.angles);
	if(!isdefined(param_01))
	{
		param_01 = param_00.type;
		if(param_01 == "Cover Multi")
		{
			param_01 = getcovermultipretendtype(param_00);
		}
	}

	switch(param_01)
	{
		case "Cover Left":
		case "Cover Left 3D":
			break;

		case "Cover Right":
		case "Cover Right 3D":
			break;

		case "Turret":
		case "Cover Stand":
		case "Conceal Stand":
			break;

		case "Cover Crouch Window":
		case "Cover Crouch":
		case "Conceal Crouch":
			break;
	}
}

//Function Number: 68
calculatenodeoffset(param_00,param_01,param_02)
{
	return param_00 * param_02[0] + param_01 * param_02[1] + (0,0,param_02[2]);
}

//Function Number: 69
recentlysawenemy()
{
	return isdefined(self.enemy) && self seerecently(self.enemy,5);
}

//Function Number: 70
canseeenemy(param_00)
{
	if(!isdefined(self.enemy))
	{
		return 0;
	}

	if(common_scripts\utility::flag("_cloaked_stealth_enabled"))
	{
		if(isdefined(self.enemy_who_surprised_me) && self.enemy_who_surprised_me == self.enemy)
		{
			return 1;
		}
		else
		{
			return self cansee(self.enemy);
		}
	}

	if((isdefined(param_00) && self cansee(self.enemy,param_00)) || self cansee(self.enemy))
	{
		if(!checkpitchvisibility(self geteye(),self.enemy getshootatpos()))
		{
			return 0;
		}

		self.goodshootpos = getenemyeyepos();
		dontgiveuponsuppressionyet();
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
		dontgiveuponsuppressionyet();
	}
	else
	{
	}

	return var_01;
}

//Function Number: 72
canseepointfromexposedatnode(param_00,param_01)
{
	if(isnodecoverleft(param_01) || isnodecoverright(param_01) || isnodecovermulticorner(param_01))
	{
		if(!animscripts\corner::canseepointfromexposedatcorner(param_00,param_01))
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

		if(isspaceai() && param_01.type == "Cover Up 3D")
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
isnodecovermulticorner(param_00)
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
		param_01 = param_00 animscripts\cover_multi::covermulti_getnonrandomvaliddir();
	}

	switch(param_01)
	{
		case "right":
			break;

		case "left":
			break;

		case "stand":
			break;

		case "crouch":
			break;

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
dontgiveuponsuppressionyet()
{
	self.a.shouldresetgiveuponsuppressiontimer = 1;
}

//Function Number: 77
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

//Function Number: 78
showlines(param_00,param_01,param_02)
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
		var_01 = getnodeoffset(self.enemy.node);
		var_00 = self.enemy.node.origin + var_01;
	}
	else if(common_scripts\utility::flag("_cloaked_stealth_enabled"))
	{
		var_00 = animscripts\combat_utility::get_last_known_shoot_pos(self.enemy);
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
cansuppressenemyfromexposed()
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
		if(isnodecoverleft(self.node) || isnodecoverright(self.node))
		{
			if(!animscripts\corner::canseepointfromexposedatcorner(getenemyeyepos(),self.node))
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

	return findgoodsuppressspot(var_01);
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

	return findgoodsuppressspot(var_00);
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

//Function Number: 83
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

//Function Number: 84
needrecalculatesuppressspot()
{
	if(isdefined(self.goodshootpos) && !canseeandshootpoint(self.goodshootpos))
	{
		return 1;
	}

	return !isdefined(self.lastenemysightposold) || self.lastenemysightposold != self.lastenemysightpos || distancesquared(self.lastenemysightposselforigin,self.origin) > 1024;
}

//Function Number: 85
findgoodsuppressspot(param_00)
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
print3dtime(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = param_00 / 0.05;
	for(var_07 = 0;var_07 < var_06;var_07++)
	{
		wait(0.05);
	}
}

//Function Number: 88
print3drise(param_00,param_01,param_02,param_03,param_04)
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
getgrenademodel()
{
	return getweaponmodel(self.grenadeweapon);
}

//Function Number: 91
sawenemymove(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 500;
	}

	return gettime() - self.personalsighttime < param_00;
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
usingboltactionweapon()
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
setfootstepeffect(param_00,param_01)
{
	if(!isdefined(level.optionalstepeffects))
	{
		anim.optionalstepeffects = [];
	}

	level.optionalstepeffects[param_00] = 1;
	level._effect["step_" + param_00] = param_01;
}

//Function Number: 96
setfootstepeffectsmall(param_00,param_01)
{
	if(!isdefined(level.optionalstepeffectssmall))
	{
		anim.optionalstepeffectssmall = [];
	}

	level.optionalstepeffectssmall[param_00] = 1;
	level._effect["step_small_" + param_00] = param_01;
}

//Function Number: 97
unsetfootstepeffect(param_00)
{
	if(isdefined(level.optionalstepeffects))
	{
		level.optionalstepeffects[param_00] = undefined;
	}

	level._effect["step_" + param_00] = undefined;
}

//Function Number: 98
unsetfootstepeffectsmall(param_00)
{
	if(isdefined(level.optionalstepeffectssmall))
	{
		level.optionalstepeffectssmall[param_00] = undefined;
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
	level.notetracks[param_00] = ::animscripts\notetracks::customnotetrackfx;
	setnotetracksound(param_00,param_02,param_04,param_05);
}

//Function Number: 100
setnotetracksound(param_00,param_01,param_02,param_03)
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

	level.notetracks[param_00] = ::animscripts\notetracks::customnotetrackfx;
	if(isdefined(param_02))
	{
		var_04.sound_prefix = param_02;
	}

	if(isdefined(param_03))
	{
		var_04.sound_suffix = param_03;
	}
}

//Function Number: 101
persistentdebugline(param_00,param_01)
{
	self endon("death");
	level notify("newdebugline");
	level endon("newdebugline");
	wait(0.05);
}

//Function Number: 102
enterpronewrapper(param_00)
{
	thread enterpronewrapperproc(param_00);
}

//Function Number: 103
enterpronewrapperproc(param_00)
{
	self endon("death");
	self notify("anim_prone_change");
	self endon("anim_prone_change");
	self enterprone(param_00,isdefined(self.a.onback));
	self waittill("killanimscript");
	if(self.a.pose != "prone" && !isdefined(self.a.onback))
	{
		self.a.pose = "prone";
	}
}

//Function Number: 104
exitpronewrapper(param_00)
{
	thread exitpronewrapperproc(param_00);
}

//Function Number: 105
exitpronewrapperproc(param_00)
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

//Function Number: 106
canblindfire()
{
	if(self.a.atconcealmentnode)
	{
		return 0;
	}

	if(!animscripts\weaponlist::usingautomaticweapon())
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
canhitsuppressspot()
{
	if(!hasenemysightpos())
	{
		return 0;
	}

	var_00 = self getmuzzlepos();
	return sighttracepassed(var_00,getenemysightpos(),0,undefined);
}

//Function Number: 108
getmoveanim(param_00)
{
	return self.a.moveanimset[param_00];
}

//Function Number: 109
randomanimoftwo(param_00,param_01)
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
	return self.a.array[param_00];
}

//Function Number: 111
animarrayanyexist(param_00)
{
	return isdefined(self.a.array[param_00]) && self.a.array[param_00].size > 0;
}

//Function Number: 112
animarraypickrandom(param_00)
{
	var_01 = randomint(self.a.array[param_00].size);
	return self.a.array[param_00][var_01];
}

//Function Number: 113
array(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B,param_0C,param_0D)
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
getaiprimaryweapon()
{
	return self.primaryweapon;
}

//Function Number: 115
getaisecondaryweapon()
{
	return self.secondaryweapon;
}

//Function Number: 116
getaisidearmweapon()
{
	return self.sidearm;
}

//Function Number: 117
getaicurrentweapon()
{
	return self.weapon;
}

//Function Number: 118
usingprimary()
{
	return self.weapon == self.primaryweapon && self.weapon != "none";
}

//Function Number: 119
usingsecondary()
{
	return self.weapon == self.secondaryweapon && self.weapon != "none";
}

//Function Number: 120
usingsidearm()
{
	return self.weapon == self.sidearm && self.weapon != "none";
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

	if(self.weapon == self.sidearm)
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
getanimendpos(param_00)
{
	var_01 = getmovedelta(param_00,0,1);
	return self localtoworldcoords(var_01);
}

//Function Number: 124
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

//Function Number: 125
usingpistol()
{
	if(!isdefined(self.weapon))
	{
		return 0;
	}

	return weaponclass(self.weapon) == "pistol";
}

//Function Number: 126
usingrocketlauncher()
{
	if(!isdefined(self.weapon))
	{
		return 0;
	}

	return weaponclass(self.weapon) == "rocketlauncher";
}

//Function Number: 127
usingmg()
{
	if(!isdefined(self.weapon))
	{
		return 0;
	}

	return weaponclass(self.weapon) == "mg";
}

//Function Number: 128
usingshotgun()
{
	if(!isdefined(self.weapon))
	{
		return 0;
	}

	return weaponclass(self.weapon) == "spread";
}

//Function Number: 129
usingsmg()
{
	if(!isdefined(self.weapon))
	{
		return 0;
	}

	return weaponclass(self.weapon) == "smg";
}

//Function Number: 130
usingriflelikeweapon()
{
	if(!isdefined(self.weapon))
	{
		return 0;
	}

	var_00 = weaponclass(self.weapon);
	switch(var_00)
	{
		case "rifle":
		case "sniper":
		case "smg":
		case "spread":
		case "mg":
			break;
	}
}

//Function Number: 131
shoulddroprocketlauncher(param_00)
{
	return isdefined(self.secondaryweapon) && self.secondaryweapon != "none" && param_00 < squared(512) || self.a.rockets < 1;
}

//Function Number: 132
ragdolldeath(param_00)
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
			self.a.nodeath = 1;
			self startragdoll();
			self clearanim(param_00,0.1);
			wait(0.05);
			physicsexplosionsphere(var_01,600,0,var_03 * 0.1);
			self notify("killanimscript");
			return;
		}
	}
}

//Function Number: 133
is_free_running()
{
	return isdefined(self.free_running);
}

//Function Number: 134
shouldcqb()
{
	return isdefined(self.cqbwalking) && !isdefined(self.grenade);
}

//Function Number: 135
iscqbwalking()
{
	return isdefined(self.cqbwalking);
}

//Function Number: 136
setunstableground(param_00)
{
	if(param_00)
	{
		self.custommoveanimset["run"] = lookupanimarray("unstable_run");
		self.custommoveanimset["walk"] = lookupanimarray("unstable_walk");
		self.isunstableground = 1;
		return;
	}

	self.custommoveanimset["run"] = undefined;
	self.custommoveanimset["walk"] = undefined;
	self.isunstableground = 0;
}

//Function Number: 137
isunstableground()
{
	return isdefined(self.isunstableground);
}

//Function Number: 138
setalwaysusepistol(param_00)
{
	if(!isdefined(param_00))
	{
		return;
	}

	if(param_00)
	{
		self.custommoveanimset["run"] = lookupanimarray("pistol_move");
		self.custommoveanimset["walk"] = lookupanimarray("pistol_move");
		self.alwaysusepistol = 1;
		self allowedstances("stand");
		self.no_pistol_switch = 1;
		self.dontshootwhilemoving = 1;
		self.disablebulletwhizbyreaction = 1;
		return;
	}

	self.custommoveanimset["run"] = undefined;
	self.custommoveanimset["walk"] = undefined;
	self.alwaysusepistol = undefined;
	self allowedstances("stand","crouch","prone");
	self.no_pistol_switch = undefined;
	self.dontshootwhilemoving = undefined;
	self.disablebulletwhizbyreaction = undefined;
}

//Function Number: 139
iscqbwalkingorfacingenemy()
{
	return !self.facemotion || isdefined(self.cqbwalking);
}

//Function Number: 140
randomizeidleset()
{
	self.a.idleset = randomint(2);
}

//Function Number: 141
isshotgun(param_00)
{
	return weaponclass(param_00) == "spread";
}

//Function Number: 142
issniperrifle(param_00)
{
	return weaponclass(param_00) == "sniper";
}

//Function Number: 143
weapon_pump_action_shotgun()
{
	return self.weapon != "none" && weaponisboltaction(self.weapon) && weaponclass(self.weapon) == "spread";
}

//Function Number: 144
getrandomintfromseed(param_00,param_01)
{
	var_02 = param_00 % level.randominttablesize;
	return level.randominttable[var_02] % param_01;
}

//Function Number: 145
getcurrentweaponslotname()
{
	if(usingsecondary())
	{
		return "secondary";
	}

	if(usingsidearm())
	{
		return "sidearm";
	}

	return "primary";
}

//Function Number: 146
isnodecoverleft(param_00)
{
	return param_00.type == "Cover Left" || param_00.type == "Cover Left 3D";
}

//Function Number: 147
isnodecoverright(param_00)
{
	return param_00.type == "Cover Right" || param_00.type == "Cover Right 3D";
}

//Function Number: 148
isnodecover3d(param_00)
{
	return param_00.type == "Cover Left 3D" || param_00.type == "Cover Right 3D" || param_00.type == "Cover Up 3D";
}

//Function Number: 149
lookupanim(param_00,param_01)
{
	if(isdefined(level.forced_s1_motionset) || isdefined(level.forced_s1_motionset_overided))
	{
		maps\_utility::enable_s1_motionset(1);
	}

	if(isdefined(self.animarchetype))
	{
		if(isdefined(level.archetypes[self.animarchetype][param_00]) && isdefined(level.archetypes[self.animarchetype][param_00][param_01]))
		{
			return level.archetypes[self.animarchetype][param_00][param_01];
		}
	}

	return level.archetypes["soldier"][param_00][param_01];
}

//Function Number: 150
lookupanimarray(param_00)
{
	if(isdefined(level.forced_s1_motionset) || isdefined(level.forced_s1_motionset_overided))
	{
		maps\_utility::enable_s1_motionset(1);
	}

	if(isdefined(self.animarchetype))
	{
		if(isdefined(level.archetypes[self.animarchetype][param_00]))
		{
			if(isdefined(level.archetypes["soldier"][param_00]))
			{
				var_01 = level.archetypes["soldier"][param_00];
				foreach(var_04, var_03 in level.archetypes[self.animarchetype][param_00])
				{
					var_01[var_04] = var_03;
				}

				return var_01;
			}

			return level.archetypes[self.animarchetype][var_04];
		}
	}

	return level.archetypes["soldier"][var_04];
}

//Function Number: 151
lookuptransitionanim(param_00,param_01,param_02)
{
	if(isdefined(self.animarchetype))
	{
		if(isdefined(level.archetypes[self.animarchetype][param_00]) && isdefined(level.archetypes[self.animarchetype][param_00][param_01]) && isdefined(level.archetypes[self.animarchetype][param_00][param_01][param_02]))
		{
			return level.archetypes[self.animarchetype][param_00][param_01][param_02];
		}

		if(isdefined(level.archetypes[self.animarchetype][param_00]) && isdefined(level.archetypes[self.animarchetype][param_00][param_01]))
		{
			return level.archetypes[self.animarchetype][param_00][param_01];
		}
	}

	return level.archetypes["soldier"][param_00][param_01][param_02];
}

//Function Number: 152
lookupdoganim(param_00,param_01)
{
	if(isdefined(self.animarchetype))
	{
		if(isdefined(level.archetypes[self.animarchetype][param_00]) && isdefined(level.archetypes[self.animarchetype][param_00][param_01]))
		{
			return level.archetypes[self.animarchetype][param_00][param_01];
		}
	}

	return level.archetypes["dog"][param_00][param_01];
}

//Function Number: 153
isdoingpain()
{
	if(isdefined(self.a.paintime) && isdefined(self.a.painanimlength))
	{
		var_00 = self.a.paintime + self.a.painanimlength * 1000;
		var_01 = gettime() < var_00;
		if(!var_01)
		{
			self.a.painanimlength = 0;
		}

		return var_01;
	}

	return 0;
}

//Function Number: 154
get_trajectory_x_given_time(param_00,param_01,param_02,param_03)
{
	return param_00 + param_01 * param_03 + 0.5 * param_02 * squared(param_03);
}

//Function Number: 155
get_trajectory_time_given_x(param_00,param_01,param_02,param_03)
{
	if(param_03 == 0)
	{
		if(param_02 == 0)
		{
			return 999999;
		}

		return param_01 - param_00 / param_02;
	}

	var_04 = 0.5 * param_03;
	var_05 = param_02;
	var_06 = param_00 - param_01;
	var_07 = squared(var_05) - 4 * var_04 * var_06;
	if(var_07 < 0)
	{
		return 999999;
	}

	var_08 = -1 * var_05 - sqrt(var_07) / 2 * var_04;
	if(var_08 >= 0)
	{
		return var_08;
	}

	var_08 = -1 * var_05 + sqrt(var_07) / 2 * var_04;
	return var_08;
}

//Function Number: 156
get_trajectory_v_given_x(param_00,param_01,param_02,param_03)
{
	var_04 = get_trajectory_time_given_x(param_00,param_01,param_02,param_03);
	var_05 = param_02 + param_03 * var_04;
	return var_05;
}

//Function Number: 157
follow_enemy_with_laser(param_00,param_01)
{
	if(!isdefined(param_00) || param_01 == "")
	{
		return;
	}

	if(!isdefined(param_00.laser_follower))
	{
		param_00.laser_follower = 1;
	}
	else
	{
		return;
	}

	if(param_00 gettagindex("tag_flash") == -1)
	{
		param_00.laser_follower = undefined;
		return;
	}

	var_02 = spawn("script_model",param_00 gettagorigin("tag_flash"));
	if(!isdefined(var_02))
	{
		param_00.laser_follower = undefined;
		return;
	}

	var_02 setmodel("tag_laser");
	var_02 laseron(param_01);
	var_03 = cos(10);
	var_04 = 0.5;
	for(;;)
	{
		if(!isdefined(param_00) || !isalive(param_00))
		{
			break;
		}

		if(isdefined(param_00.enemy))
		{
			var_02.origin = param_00 gettagorigin("tag_flash");
			var_05 = param_00 gettagangles("tag_flash");
			var_06 = vectornormalize(param_00.enemy getshootatpos() - var_02.origin);
			var_07 = anglestoforward(var_05);
			var_08 = vectornormalize(var_06);
			var_09 = vectortoangles(var_08);
			var_0A = vectordot(var_07,var_08);
			if(var_0A > var_03)
			{
				var_02 laseron(param_01);
				var_0B = vectortoangles(var_06) + (randomfloatrange(-1 * var_04,var_04),randomfloatrange(-1 * var_04,var_04),randomfloatrange(-1 * var_04,var_04));
				var_02.angles = vectorlerp(var_02.angles,var_0B,0.15);
			}
			else
			{
				var_02 laseroff();
			}
		}

		wait 0.05;
	}

	var_02 laseroff();
	var_02 delete();
	if(isdefined(param_00))
	{
		param_00.laser_follower = undefined;
	}
}