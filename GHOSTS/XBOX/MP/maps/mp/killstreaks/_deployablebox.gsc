/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\killstreaks\_deployablebox.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 41
 * Decompile Time: 633 ms
 * Timestamp: 10/27/2023 1:32:19 AM
*******************************************************************/

//Function Number: 1
func_44DF()
{
	if(!isdefined(level.boxsettings))
	{
		level.boxsettings = [];
	}
}

//Function Number: 2
func_13F5(param_00,param_01)
{
	thread watchdeployablemarkercancel(param_01);
	thread func_8CD8(param_01,param_00);
	for(;;)
	{
		var_02 = common_scripts\utility::func_8B33("deployable_canceled","deployable_deployed","death","disconnect");
		return var_02 == "deployable_deployed";
	}
}

//Function Number: 3
func_842D(param_00,param_01)
{
	thread watchdeployablemarkercancel(param_01);
	thread func_8CD8(param_01,param_00);
	for(;;)
	{
		var_02 = common_scripts\utility::func_8B33("deployable_canceled","deployable_deployed","death","disconnect");
		return var_02 == "deployable_deployed";
	}
}

//Function Number: 4
watchdeployablemarkercancel(param_00)
{
	self endon("death");
	self endon("disconnect");
	self endon("deployable_deployed");
	var_01 = level.boxsettings[param_00];
	var_02 = self getcurrentweapon();
	while(var_02 == var_01.weaponinfo)
	{
		self waittill("weapon_change",var_02);
	}

	self notify("deployable_canceled");
}

//Function Number: 5
func_8CD8(param_00,param_01)
{
	self endon("spawned_player");
	self endon("disconnect");
	self endon("deployable_canceled");
	for(;;)
	{
		self waittill("grenade_fire",var_02,var_03);
		if(maps\mp\_utility::func_4945(self))
		{
			break;
		}
		else
		{
			var_02 delete();
		}
	}

	var_02 isleaning(1);
	self notify("deployable_deployed");
	var_02.owner = self;
	var_02.weaponname = var_03;
	self.marker = var_02;
	var_02 playsoundtoplayer(level.boxsettings[param_00].deployedsfx,self);
	var_02 thread func_50A8(param_01,param_00,::box_setactive);
}

//Function Number: 6
func_5A7E(param_00)
{
	self notify("death");
}

//Function Number: 7
func_50A8(param_00,param_01,param_02)
{
	self notify("markerActivate");
	self endon("markerActivate");
	self waittill("missile_stuck");
	var_03 = self.owner;
	var_04 = self.origin;
	if(!isdefined(var_03))
	{
	}

	var_05 = func_20CB(param_01,var_04,var_03);
	var_06 = addstruct();
	var_06.linkparent = self getlinkedparent();
	if(isdefined(var_06.linkparent) && isdefined(var_06.linkparent.model) && deployableexclusion(var_06.linkparent.model))
	{
		var_05.origin = var_06.linkparent.origin;
		var_07 = var_06.linkparent getlinkedparent();
		if(isdefined(var_07))
		{
			var_06.linkparent = var_07;
		}
		else
		{
			var_06.linkparent = undefined;
		}
	}

	var_06.deathoverridecallback = ::func_5A7E;
	var_05 thread maps\mp\_movers::func_3F25(var_06);
	var_05.moving_platform = var_06.linkparent;
	var_05 setotherent(var_03);
	wait(0.05);
	var_05 thread [[ param_02 ]]();
	self delete();
	if(isdefined(var_05) && var_05 maps\mp\_utility::func_818D())
	{
		var_05 notify("death");
	}
}

//Function Number: 8
deployableexclusion(param_00)
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

//Function Number: 9
func_48D7()
{
	var_00 = self getcurrentweapon();
	if(isdefined(var_00))
	{
		foreach(var_02 in level.boxsettings)
		{
			if(var_00 == var_02.weaponinfo)
			{
				return 1;
			}
		}
	}

	return 0;
}

//Function Number: 10
func_20CB(param_00,param_01,param_02)
{
	var_03 = level.boxsettings[param_00];
	var_04 = spawn("script_model",param_01 - (0,0,1));
	var_04 setmodel(var_03.modelbase);
	var_04.health = 999999;
	var_04.maxhealth = var_03.maxhealth;
	var_04.angles = param_02.angles;
	var_04.boxtype = param_00;
	var_04.owner = param_02;
	var_04.team = param_02.team;
	var_04.id = var_03.id;
	if(isdefined(var_03.dpadname))
	{
		var_04.dpadname = var_03.dpadname;
	}

	if(isdefined(var_03.maxuses))
	{
		var_04.usesremaining = var_03.maxuses;
	}

	var_04 box_setinactive();
	var_04 thread box_handleownerdisconnect();
	var_04 addboxtolevelarray();
	return var_04;
}

//Function Number: 11
box_setactive(param_00)
{
	self setcursorhint("HINT_NOICON");
	var_01 = level.boxsettings[self.boxtype];
	self sethintstring(var_01.hintstring);
	self.inuse = 0;
	var_02 = maps\mp\gametypes\_gameobjects::getnextobjid();
	objective_add(var_02,"invisible",(0,0,0));
	if(!isdefined(self getlinkedparent()))
	{
		objective_position(var_02,self.origin);
	}
	else
	{
		objective_onentity(var_02,self);
	}

	objective_state(var_02,"active");
	objective_icon(var_02,var_01.shadername);
	self.objidfriendly = var_02;
	if(level.teambased)
	{
		objective_team(var_02,self.team);
		foreach(var_04 in level.players)
		{
			if(self.team == var_04.team && !isdefined(var_01.canusecallback) || var_04 [[ var_01.canusecallback ]](self))
			{
				box_seticon(var_04,var_01.streakname,var_01.headiconoffset);
			}
		}
	}
	else
	{
		objective_player(var_02,self.owner getentitynumber());
		if(!isdefined(var_01.canusecallback) || self.owner [[ var_01.canusecallback ]](self))
		{
			box_seticon(self.owner,var_01.streakname,var_01.headiconoffset);
		}
	}

	self makeusable();
	self.isusable = 1;
	self setcandamage(1);
	thread box_handledamage();
	thread box_handledeath();
	thread func_16FE();
	thread disablewhenjuggernaut();
	common_scripts\utility::func_5009(self.team,1);
	if(issentient(self))
	{
		self setthreatbiasgroup("DogsDontAttack");
	}

	if(isdefined(self.owner))
	{
		self.owner notify("new_deployable_box",self);
	}

	if(level.teambased)
	{
		foreach(var_04 in level.participants)
		{
			_box_setactivehelper(var_04,self.team == var_04.team,var_01.canusecallback);
			if(!isai(var_04))
			{
				thread box_playerjoinedteam(var_04);
			}
		}
	}
	else
	{
		foreach(var_04 in level.participants)
		{
			_box_setactivehelper(var_04,isdefined(self.owner) && self.owner == var_04,var_01.canusecallback);
		}
	}

	level thread maps\mp\_utility::func_7FA0(var_01.splashname,self.owner,self.team);
	thread func_16F8();
	thread box_agentconnected();
	if(isdefined(var_01.ondeploycallback))
	{
		self [[ var_01.ondeploycallback ]](var_01);
	}

	thread createbombsquadmodel(self.boxtype);
}

//Function Number: 12
_box_setactivehelper(param_00,param_01,param_02)
{
	if(param_01)
	{
		if(!isdefined(param_02) || param_00 [[ param_02 ]](self))
		{
			box_enableplayeruse(param_00);
		}
		else
		{
			box_disableplayeruse(param_00);
			thread func_2A28(param_00);
		}

		thread boxthink(param_00);
	}

	box_disableplayeruse(param_00);
}

//Function Number: 13
func_16F8()
{
	self endon("death");
	for(;;)
	{
		level waittill("connected",var_00);
		childthread func_16FF(var_00);
	}
}

//Function Number: 14
box_agentconnected()
{
	self endon("death");
	for(;;)
	{
		level waittill("spawned_agent_player",var_00);
		func_16ED(var_00);
	}
}

//Function Number: 15
func_16FF(param_00)
{
	param_00 waittill("spawned_player");
	if(level.teambased)
	{
		func_16ED(param_00);
		thread box_playerjoinedteam(param_00);
	}
}

//Function Number: 16
box_playerjoinedteam(param_00)
{
	self endon("death");
	param_00 endon("disconnect");
	for(;;)
	{
		param_00 waittill("joined_team");
		if(level.teambased)
		{
			func_16ED(param_00);
		}
	}
}

//Function Number: 17
func_16ED(param_00)
{
	if(self.team == param_00.team)
	{
		box_enableplayeruse(param_00);
		thread boxthink(param_00);
		box_seticon(param_00,level.boxsettings[self.boxtype].streakname,level.boxsettings[self.boxtype].headiconoffset);
	}

	box_disableplayeruse(param_00);
	maps\mp\_entityheadicons::setheadicon(param_00,"",(0,0,0));
}

//Function Number: 18
box_seticon(param_00,param_01,param_02)
{
	maps\mp\_entityheadicons::setheadicon(param_00,maps\mp\_utility::getkillstreakoverheadicon(param_01),(0,0,param_02),14,14,undefined,undefined,undefined,undefined,undefined,0);
}

//Function Number: 19
box_enableplayeruse(param_00)
{
	if(isplayer(param_00))
	{
		self enableplayeruse(param_00);
	}

	self.disabled_use_for[param_00 getentitynumber()] = 0;
}

//Function Number: 20
box_disableplayeruse(param_00)
{
	if(isplayer(param_00))
	{
		self disableplayeruse(param_00);
	}

	self.disabled_use_for[param_00 getentitynumber()] = 1;
}

//Function Number: 21
box_setinactive()
{
	self makeunusable();
	self.isusable = 0;
	maps\mp\_entityheadicons::setheadicon("none","",(0,0,0));
	if(isdefined(self.objidfriendly))
	{
		maps\mp\_utility::_objective_delete(self.objidfriendly);
	}
}

//Function Number: 22
box_handledamage()
{
	var_00 = level.boxsettings[self.boxtype];
	maps\mp\gametypes\_damage::func_537B(var_00.maxhealth,var_00.damagefeedback,::box_handledeathdamage,::func_16F7,1);
}

//Function Number: 23
func_16F7(param_00,param_01,param_02,param_03)
{
	var_04 = param_03;
	var_05 = level.boxsettings[self.boxtype];
	if(var_05.allowmeleedamage)
	{
		var_04 = maps\mp\gametypes\_damage::handlemeleedamage(param_01,param_02,var_04);
	}

	var_04 = maps\mp\gametypes\_damage::func_3F8A(param_01,param_02,var_04);
	var_04 = maps\mp\gametypes\_damage::handlegrenadedamage(param_01,param_02,var_04);
	var_04 = maps\mp\gametypes\_damage::handleapdamage(param_01,param_02,var_04,param_00);
	return var_04;
}

//Function Number: 24
box_handledeathdamage(param_00,param_01,param_02,param_03)
{
	var_04 = level.boxsettings[self.boxtype];
	var_05 = maps\mp\gametypes\_damage::onkillstreakkilled(param_00,param_01,param_02,param_03,var_04.xppopup,var_04.vodestroyed);
	if(var_05)
	{
		param_00 notify("destroyed_equipment");
	}
}

//Function Number: 25
box_handledeath()
{
	self waittill("death");
	if(!isdefined(self))
	{
	}

	box_setinactive();
	func_657F();
	var_00 = level.boxsettings[self.boxtype];
	playfx(var_00.deathvfx,self.origin);
	self playsound("mp_killstreak_disappear");
	if(isdefined(var_00.deathdamagemax))
	{
		var_01 = undefined;
		if(isdefined(self.owner))
		{
			var_01 = self.owner;
		}

		radiusdamage(self.origin + (0,0,var_00.headiconoffset),var_00.deathdamageradius,var_00.deathdamagemax,var_00.deathdamagemin,var_01,"MOD_EXPLOSIVE",var_00.deathweaponinfo);
	}

	self notify("deleting");
	self delete();
}

//Function Number: 26
box_handleownerdisconnect()
{
	self endon("death");
	level endon("game_ended");
	self notify("box_handleOwner");
	self endon("box_handleOwner");
	self.owner waittill("killstreak_disowned");
	self notify("death");
}

//Function Number: 27
boxthink(param_00)
{
	self endon("death");
	thread func_1700(param_00);
	if(!isdefined(param_00.boxes))
	{
		param_00.boxes = [];
	}

	param_00.boxes[param_00.boxes.size] = self;
	var_01 = level.boxsettings[self.boxtype];
	for(;;)
	{
		self waittill("captured",var_02);
		if(var_02 == param_00)
		{
			param_00 playlocalsound(var_01.onusesfx);
			if(isdefined(var_01.onusecallback))
			{
				param_00 [[ var_01.onusecallback ]](self);
			}

			if(isdefined(self.owner) && param_00 != self.owner)
			{
				self.owner thread maps\mp\gametypes\_rank::func_8E6E(var_01.event);
				self.owner thread maps\mp\gametypes\_rank::giverankxp("support",var_01.usexp);
			}

			if(isdefined(self.usesremaining))
			{
				self.usesremaining--;
				if(self.usesremaining == 0)
				{
					func_16F5();
					break;
				}
			}

			if(isdefined(var_01.canuseotherboxes) && var_01.canuseotherboxes)
			{
				foreach(var_04 in level.deployable_box[var_01.streakname])
				{
					var_04 box_disableplayeruse(self);
					var_04 maps\mp\_entityheadicons::setheadicon(self,"",(0,0,0));
					var_04 thread func_2A28(self);
				}

				continue;
			}

			maps\mp\_entityheadicons::setheadicon(param_00,"",(0,0,0));
			box_disableplayeruse(param_00);
			thread func_2A28(param_00);
		}
	}
}

//Function Number: 28
func_2A28(param_00)
{
	self endon("death");
	param_00 endon("disconnect");
	param_00 waittill("death");
	if(level.teambased)
	{
		if(self.team == param_00.team)
		{
			box_seticon(param_00,level.boxsettings[self.boxtype].streakname,level.boxsettings[self.boxtype].headiconoffset);
			box_enableplayeruse(param_00);
		}
	}

	if(isdefined(self.owner) && self.owner == param_00)
	{
		box_seticon(param_00,level.boxsettings[self.boxtype].streakname,level.boxsettings[self.boxtype].headiconoffset);
		box_enableplayeruse(param_00);
	}
}

//Function Number: 29
func_1700(param_00)
{
	level endon("game_ended");
	while(isdefined(self))
	{
		self waittill("trigger",var_01);
		if(isdefined(level.boxsettings[self.boxtype].nousekillstreak) && level.boxsettings[self.boxtype].nousekillstreak && maps\mp\_utility::func_48F7(param_00 getcurrentweapon()))
		{
			continue;
		}

		if(var_01 == param_00 && func_87BF(param_00,level.boxsettings[self.boxtype].usetime))
		{
			self notify("captured",param_00);
		}
	}
}

//Function Number: 30
func_48CB(param_00)
{
	return level.teambased && self.team == param_00.team;
}

//Function Number: 31
func_16FE()
{
	self endon("death");
	level endon("game_ended");
	var_00 = level.boxsettings[self.boxtype];
	var_01 = var_00.lifespan;
	maps\mp\gametypes\_hostmigration::func_8B0D(var_01);
	if(isdefined(var_00.vogone))
	{
		self.owner thread maps\mp\_utility::func_4D35(var_00.vogone);
	}

	func_16F5();
}

//Function Number: 32
func_16F5()
{
	wait(0.05);
	self notify("death");
}

//Function Number: 33
func_2591(param_00)
{
	wait(0.25);
	self linkto(param_00,"tag_origin",(0,0,0),(0,0,0));
	param_00 waittill("death");
	func_16F5();
}

//Function Number: 34
box_modelteamupdater(param_00)
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

//Function Number: 35
func_87BF(param_00,param_01)
{
	maps\mp\_movers::script_mover_link_to_use_object(param_00);
	param_00 common_scripts\utility::_disableweapon();
	param_00.boxparams = addstruct();
	param_00.boxparams.curprogress = 0;
	param_00.boxparams.inuse = 1;
	param_00.boxparams.userate = 0;
	param_00.boxparams.id = self.id;
	if(isdefined(param_01))
	{
		param_00.boxparams.usetime = param_01;
	}
	else
	{
		param_00.boxparams.usetime = 3000;
	}

	var_02 = useholdthinkloop(param_00);
	if(isalive(param_00))
	{
		param_00 common_scripts\utility::_enableweapon();
		maps\mp\_movers::script_mover_unlink_from_use_object(param_00);
	}

	if(!isdefined(self))
	{
		return 0;
	}

	param_00.boxparams.inuse = 0;
	param_00.boxparams.curprogress = 0;
	return var_02;
}

//Function Number: 36
useholdthinkloop(param_00)
{
	var_01 = param_00.boxparams;
	while(param_00 func_92B0(var_01))
	{
		if(!param_00 maps\mp\_movers::script_mover_use_can_link(self))
		{
			param_00 maps\mp\gametypes\_gameobjects::func_874E(var_01,0);
			return 0;
		}

		var_01.curprogress = var_01.curprogress + 50 * var_01.userate;
		if(isdefined(param_00.objectivescaler))
		{
			var_01.userate = 1 * param_00.objectivescaler;
		}
		else
		{
			var_01.userate = 1;
		}

		param_00 maps\mp\gametypes\_gameobjects::func_874E(var_01,1);
		if(var_01.curprogress >= var_01.usetime)
		{
			param_00 maps\mp\gametypes\_gameobjects::func_874E(var_01,0);
			return maps\mp\_utility::func_4945(param_00);
		}

		wait(0.05);
	}

	param_00 maps\mp\gametypes\_gameobjects::func_874E(var_01,0);
	return 0;
}

//Function Number: 37
disablewhenjuggernaut()
{
	level endon("game_ended");
	self endon("death");
	for(;;)
	{
		level waittill("juggernaut_equipped",var_00);
		maps\mp\_entityheadicons::setheadicon(var_00,"",(0,0,0));
		box_disableplayeruse(var_00);
		thread func_2A28(var_00);
	}
}

//Function Number: 38
addboxtolevelarray()
{
	level.deployable_box[self.boxtype][self getentitynumber()] = self;
}

//Function Number: 39
func_657F()
{
	level.deployable_box[self.boxtype][self getentitynumber()] = undefined;
}

//Function Number: 40
createbombsquadmodel(param_00)
{
	var_01 = level.boxsettings[param_00];
	if(isdefined(var_01.modelbombsquad))
	{
		var_02 = spawn("script_model",self.origin);
		var_02.angles = self.angles;
		var_02 hide();
		var_02 thread maps\mp\gametypes\_weapons::bombsquadvisibilityupdater(self.owner);
		var_02 setmodel(var_01.modelbombsquad);
		var_02 linkto(self);
		var_02 setcontents(0);
		self.bombsquadmodel = var_02;
		self waittill("death");
		if(isdefined(var_02))
		{
			var_02 delete();
			self.bombsquadmodel = undefined;
		}
	}
}

//Function Number: 41
func_92B0(param_00)
{
	return !level.gameended && isdefined(param_00) && maps\mp\_utility::func_4945(self) && self usebuttonpressed() && !self isonladder() && !self meleebuttonpressed() && !isdefined(self.throwinggrenade) && param_00.curprogress < param_00.usetime && !isdefined(self.teleporting) || !self.teleporting;
}