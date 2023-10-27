/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\squadmanager.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 32
 * Decompile Time: 558 ms
 * Timestamp: 10/27/2023 2:30:53 AM
*******************************************************************/

//Function Number: 1
func_0676()
{
	if(isdefined(level.squadinitialized) && level.squadinitialized)
	{
		return;
	}

	anim.var_678 = [];
	anim.squadcreatestrings = [];
	anim.squads = [];
	anim.squadindex = [];
	anim.squadrand = 0;
	anim.squadinitialized = 1;
}

//Function Number: 2
createsquad(param_00,param_01)
{
	level.squads[param_00] = spawnstruct();
	var_02 = level.squads[param_00];
	var_02.var_67E = param_00;
	var_02.team = getsquadteam(param_01);
	var_02.sighttime = 0;
	var_02.origin = undefined;
	var_02.forward = undefined;
	var_02.enemy = undefined;
	var_02.isincombat = 0;
	var_02.membercount = 0;
	var_02.members = [];
	var_02.officers = [];
	var_02.officercount = 0;
	var_02.squadlist = [];
	var_02.memberaddfuncs = [];
	var_02.var_688 = [];
	var_02.var_689 = [];
	var_02.memberremovestrings = [];
	var_02.squadupdatefuncs = [];
	var_02.squadupdatestrings = [];
	var_02.squadid = level.squadindex.size;
	var_02 func_06B7("combat",0.75);
	var_02 func_06B7("cover",0.75);
	var_02 func_06B7("move",0.75);
	var_02 func_06B7("stop",0.75);
	var_02 func_06B7("death",0.75);
	var_02 func_06B7("suppressed",0.75);
	var_02 func_06B7("attacking",0.5);
	level.squadindex[level.squadindex.size] = var_02;
	var_02 updatesquadlist();
	level notify("squad created " + param_00);
	anim notify("squad created " + param_00);
	for(var_03 = 0;var_03 < level.var_678.size;var_03++)
	{
		var_04 = level.var_678[var_03];
		var_02 thread [[ var_04 ]]();
	}

	for(var_03 = 0;var_03 < level.squadindex.size;var_03++)
	{
		level.squadindex[var_03] updatesquadlist();
	}

	var_02 thread updatewaiter();
	var_02 thread squadtracker();
	var_02 thread officerwaiter();
	var_02 thread updatememberstates();
	return var_02;
}

//Function Number: 3
deletesquad(param_00)
{
	if(param_00 == "axis" || param_00 == "team3" || param_00 == "allies")
	{
		return;
	}

	var_01 = level.squads[param_00].squadid;
	var_02 = level.squads[param_00];
	var_02 notify("squad_deleting");
	while(var_02.members.size)
	{
		var_02.members[0] addtosquad(var_02.members[0].team);
	}

	level.squadindex[var_01] = level.squadindex[level.squadindex.size - 1];
	level.squadindex[var_01].squadid = var_01;
	level.squadindex[level.squadindex.size - 1] = undefined;
	level.squads[param_00] = undefined;
	level notify("squad deleted " + param_00);
	anim notify("squad deleted " + param_00);
	for(var_03 = 0;var_03 < level.squadindex.size;var_03++)
	{
		level.squadindex[var_03] updatesquadlist();
	}
}

//Function Number: 4
generatesquadname()
{
	var_00 = "auto" + level.squadrand;
	level.squadrand++;
	return var_00;
}

//Function Number: 5
addplayertosquad(param_00)
{
	if(!isdefined(param_00))
	{
		if(isdefined(self.script_squadname))
		{
			param_00 = self.script_squadname;
		}
		else
		{
			param_00 = self.team;
		}
	}

	if(!isdefined(level.squads[param_00]))
	{
		anim createsquad(param_00,self);
	}

	var_01 = level.squads[param_00];
	self.squad = var_01;
}

//Function Number: 6
squadchange()
{
	self endon("death");
	wait 10;
	if(!isdefined(self.script_squadname))
	{
		var_00 = self.team + self.script_flanker;
	}
	else
	{
		var_00 = self.script_squadname + self.script_flanker;
	}

	addtosquad(var_00);
}

//Function Number: 7
getsquadteam(param_00)
{
	var_01 = "allies";
	if(param_00.team == "axis" || param_00.team == "neutral" || param_00.team == "team3")
	{
		var_01 = param_00.team;
	}

	return var_01;
}

//Function Number: 8
addtosquad(param_00)
{
	if(!isdefined(param_00))
	{
		if(isdefined(self.script_flanker))
		{
			thread squadchange();
		}

		if(isdefined(self.script_squadname))
		{
			param_00 = self.script_squadname;
		}
		else
		{
			param_00 = self.team;
		}
	}

	if(!isdefined(level.squads[param_00]))
	{
		anim createsquad(param_00,self);
	}

	var_01 = level.squads[param_00];
	if(isdefined(self.squad))
	{
		if(self.squad == var_01)
		{
			return;
		}
		else
		{
			func_069C();
		}
	}

	self.lastenemysighttime = 0;
	self.combattime = 0;
	self.squad = var_01;
	self.memberid = var_01.members.size;
	var_01.members[self.memberid] = self;
	var_01.membercount = var_01.members.size;
	if(isdefined(level.loadoutcomplete))
	{
		if(self.team == "allies" && animscripts/battlechatter::isofficer())
		{
			addofficertosquad();
		}
	}

	for(var_02 = 0;var_02 < self.squad.memberaddfuncs.size;var_02++)
	{
		var_03 = self.squad.memberaddfuncs[var_02];
		self thread [[ var_03 ]](self.squad.var_67E);
	}

	thread membercombatwaiter();
	thread memberdeathwaiter();
}

//Function Number: 9
func_069C()
{
	var_00 = self.squad;
	var_01 = -1;
	if(isdefined(self))
	{
		var_01 = self.memberid;
	}
	else
	{
		for(var_02 = 0;var_02 < var_00.members.size;var_02++)
		{
			if(var_00.members[var_02] == self)
			{
				var_01 = var_02;
			}
		}
	}

	if(var_01 != var_00.members.size - 1)
	{
		var_03 = var_00.members[var_00.members.size - 1];
		var_00.members[var_01] = var_03;
		if(isdefined(var_03))
		{
			var_03.memberid = var_01;
		}
	}

	var_00.members[var_00.members.size - 1] = undefined;
	var_00.membercount = var_00.members.size;
	if(isdefined(self.officerid))
	{
		removeofficerfromsquad();
	}

	for(var_02 = 0;var_02 < self.squad.var_689.size;var_02++)
	{
		var_04 = self.squad.var_689[var_02];
		self thread [[ var_04 ]](var_00.var_67E);
	}

	if(var_00.membercount == 0)
	{
		deletesquad(var_00.var_67E);
	}

	if(isdefined(self))
	{
		self.squad = undefined;
		self.memberid = undefined;
	}

	self notify("removed from squad");
}

//Function Number: 10
addofficertosquad()
{
	var_00 = self.squad;
	if(isdefined(self.officerid))
	{
		return;
	}

	self.officerid = var_00.officers.size;
	var_00.officers[self.officerid] = self;
	var_00.officercount = var_00.officers.size;
}

//Function Number: 11
removeofficerfromsquad()
{
	var_00 = self.squad;
	var_01 = -1;
	if(isdefined(self))
	{
		var_01 = self.officerid;
	}
	else
	{
		for(var_02 = 0;var_02 < var_00.officers.size;var_02++)
		{
			if(var_00.officers[var_02] == self)
			{
				var_01 = var_02;
			}
		}
	}

	if(var_01 != var_00.officers.size - 1)
	{
		var_03 = var_00.officers[var_00.officers.size - 1];
		var_00.officers[var_01] = var_03;
		if(isdefined(var_03))
		{
			var_03.officerid = var_01;
		}
	}

	var_00.officers[var_00.officers.size - 1] = undefined;
	var_00.officercount = var_00.officers.size;
	if(isdefined(self))
	{
		self.officerid = undefined;
	}
}

//Function Number: 12
officerwaiter()
{
	if(!isdefined(level.loadoutcomplete))
	{
		anim waittill("loadout complete");
	}

	for(var_00 = 0;var_00 < self.members.size;var_00++)
	{
		if(self.members[var_00] animscripts/battlechatter::isofficer())
		{
			self.members[var_00] addofficertosquad();
		}
	}
}

//Function Number: 13
updatewaiter()
{
	for(;;)
	{
		anim waittill("squadupdate",var_00);
		switch(var_00)
		{
			case "squadlist":
				updatesquadlist();
				break;
	
			case "combat":
				updatecombat();
				break;
	
			case "origin":
				updateorigin();
				break;
	
			case "forward":
				updateheading();
				break;
		}
	}
}

//Function Number: 14
squadtracker()
{
	anim endon("squad deleted " + self.var_67E);
	for(;;)
	{
		updateall();
		wait 0.1;
	}
}

//Function Number: 15
memberdeathwaiter()
{
	self endon("removed from squad");
	self waittill("death",var_00);
	if(isdefined(self))
	{
		self.attacker = var_00;
	}

	func_069C();
}

//Function Number: 16
membercombatwaiter()
{
	self endon("removed from squad");
	for(;;)
	{
		self waittill("enemy");
		if(!isdefined(self.enemy))
		{
			self.squad notify("squadupdate","combat");
		}
		else
		{
			self.squad.isincombat = 1;
		}

		wait 0.05;
	}
}

//Function Number: 17
updateheading()
{
	if(isdefined(self.enemy))
	{
		self.forward = vectornormalize(self.enemy.origin - self.origin);
		return;
	}

	var_00 = (0,0,0);
	var_01 = 0;
	for(var_02 = 0;var_02 < self.members.size;var_02++)
	{
		if(!isalive(self.members[var_02]))
		{
			continue;
		}

		var_00 = var_00 + anglestoforward(self.members[var_02].angles);
		var_01++;
	}

	if(var_01)
	{
		self.forward = (var_00[0] / var_01,var_00[1] / var_01,var_00[2] / var_01);
		return;
	}

	self.forward = var_00;
}

//Function Number: 18
updateorigin()
{
	var_00 = (0,0,0);
	var_01 = 0;
	for(var_02 = 0;var_02 < self.members.size;var_02++)
	{
		if(!isalive(self.members[var_02]))
		{
			continue;
		}

		var_00 = var_00 + self.members[var_02].origin;
		var_01++;
	}

	if(var_01)
	{
		self.origin = (var_00[0] / var_01,var_00[1] / var_01,var_00[2] / var_01);
		return;
	}

	self.origin = var_00;
}

//Function Number: 19
updatecombat()
{
	self.isincombat = 0;
	for(var_00 = 0;var_00 < level.squadindex.size;var_00++)
	{
		self.squadlist[level.squadindex[var_00].var_67E].isincontact = 0;
	}

	for(var_00 = 0;var_00 < self.members.size;var_00++)
	{
		if(isdefined(self.members[var_00].enemy) && isdefined(self.members[var_00].enemy.squad) && self.members[var_00].combattime > 0)
		{
			self.squadlist[self.members[var_00].enemy.squad.var_67E].isincontact = 1;
		}
	}
}

//Function Number: 20
updateenemy()
{
	var_00 = undefined;
	for(var_01 = 0;var_01 < self.members.size;var_01++)
	{
		if(isdefined(self.members[var_01].enemy) && isdefined(self.members[var_01].enemy.squad))
		{
			if(!isdefined(var_00))
			{
				var_00 = self.members[var_01].enemy.squad;
				continue;
			}

			if(self.members[var_01].enemy.squad.membercount > var_00.membercount)
			{
				var_00 = self.members[var_01].enemy.squad;
			}
		}
	}

	self.enemy = var_00;
}

//Function Number: 21
updateall()
{
	var_00 = (0,0,0);
	var_01 = 0;
	var_02 = undefined;
	var_03 = 0;
	updatecombat();
	for(var_04 = 0;var_04 < self.members.size;var_04++)
	{
		if(!isalive(self.members[var_04]))
		{
			continue;
		}

		var_00 = var_00 + self.members[var_04].origin;
		var_01++;
		if(isdefined(self.members[var_04].enemy) && isdefined(self.members[var_04].enemy.squad))
		{
			if(!isdefined(var_02))
			{
				var_02 = self.members[var_04].enemy.squad;
				continue;
			}

			if(self.members[var_04].enemy.squad.membercount > var_02.membercount)
			{
				var_02 = self.members[var_04].enemy.squad;
			}
		}
	}

	if(var_01)
	{
		self.origin = (var_00[0] / var_01,var_00[1] / var_01,var_00[2] / var_01);
	}
	else
	{
		self.origin = var_00;
	}

	self.isincombat = var_03;
	self.enemy = var_02;
	updateheading();
}

//Function Number: 22
updatesquadlist()
{
	for(var_00 = 0;var_00 < level.squadindex.size;var_00++)
	{
		if(!isdefined(self.squadlist[level.squadindex[var_00].var_67E]))
		{
			self.squadlist[level.squadindex[var_00].var_67E] = spawnstruct();
			self.squadlist[level.squadindex[var_00].var_67E].isincontact = 0;
		}

		for(var_01 = 0;var_01 < self.squadupdatefuncs.size;var_01++)
		{
			var_02 = self.squadupdatefuncs[var_01];
			self thread [[ var_02 ]](level.squadindex[var_00].var_67E);
		}
	}
}

//Function Number: 23
printabovehead(param_00,param_01,param_02,param_03)
{
	self endon("death");
	if(!isdefined(param_02))
	{
		param_02 = (0,0,0);
	}

	if(!isdefined(param_03))
	{
		param_03 = (1,0,0);
	}

	for(var_04 = 0;var_04 < param_01 * 2;var_04++)
	{
		if(!isalive(self))
		{
			return;
		}

		var_05 = self getshootatpos() + (0,0,10) + param_02;
		wait 0.05;
	}
}

//Function Number: 24
func_06AE(param_00)
{
	switch(param_00)
	{
		case "move":
		case "combat":
		case "death":
		case "stop":
			self.a.state = param_00;
			break;

		case "grenadecower":
		case "pain":
			break;

		case "stalingrad_cover_crouch":
		case "concealment_stand":
		case "concealment_prone":
		case "concealment_crouch":
		case "cover_wide_right":
		case "cover_wide_left":
		case "cover_prone":
		case "cover_stand":
		case "cover_left":
		case "cover_crouch":
		case "cover_right":
			self.a.state = "cover";
			break;

		case "l33t truckride combat":
		case "aim":
			self.a.state = "combat";
			break;
	}
}

//Function Number: 25
updatestates()
{
	resetstate("combat");
	resetstate("cover");
	resetstate("move");
	resetstate("stop");
	resetstate("death");
	resetstate("suppressed");
	resetstate("attacking");
	for(var_00 = 0;var_00 < self.members.size;var_00++)
	{
		if(!isalive(self.members[var_00]))
		{
			continue;
		}

		querymemberanimstate(self.members[var_00]);
		querymemberstate(self.members[var_00],"suppressed");
		querymemberstate(self.members[var_00],"combat");
		querymemberstate(self.members[var_00],"attacking");
		querymemberstate(self.members[var_00],"cover");
	}
}

//Function Number: 26
updatememberstates()
{
	anim endon("squad deleted " + self.var_67E);
	var_00 = 0.05;
	for(;;)
	{
		for(var_01 = 0;var_01 < self.members.size;var_01++)
		{
			if(!isalive(self.members[var_01]))
			{
				continue;
			}

			self.members[var_01] aiupdatecombat(var_00);
			self.members[var_01] func_06B4(var_00);
		}

		wait var_00;
	}
}

//Function Number: 27
aiupdatecombat(param_00)
{
	if(isdefined(self.lastenemysightpos))
	{
		if(self.combattime < 0)
		{
			self.combattime = param_00;
		}
		else
		{
			self.combattime = self.combattime + param_00;
		}

		self.lastenemysighttime = gettime();
		return;
	}
	else if(self issuppressed())
	{
		self.combattime = self.combattime + param_00;
		return;
	}

	if(self.combattime > 0)
	{
		self.combattime = 0 - param_00;
		return;
	}

	self.combattime = self.combattime - param_00;
}

//Function Number: 28
func_06B4(param_00)
{
	if(self.suppressed)
	{
		if(self.suppressedtime < 0)
		{
			self.suppressedtime = param_00;
		}
		else
		{
			self.suppressedtime = self.suppressedtime + param_00;
		}

		return;
	}

	if(self.suppressedtime > 0)
	{
		self.suppressedtime = 0 - param_00;
		return;
	}

	self.suppressedtime = self.suppressedtime - param_00;
}

//Function Number: 29
func_06B7(param_00,param_01)
{
	self.squadstates[param_00] = spawnstruct();
	self.squadstates[param_00].activateratio = param_01;
	self.squadstates[param_00].isactive = 0;
	self.squadstates[param_00].numactive = 0;
}

//Function Number: 30
resetstate(param_00)
{
	self.squadstates[param_00].isactive = 0;
	self.squadstates[param_00].numactive = 0;
}

//Function Number: 31
querymemberanimstate(param_00)
{
	self.squadstates[param_00.a.state].numactive++;
	if(self.squadstates[param_00.a.state].numactive > self.squadstates[param_00.a.state].activateratio * self.members.size)
	{
		self.squadstates[param_00.a.state].isactive = 1;
	}
}

//Function Number: 32
querymemberstate(param_00,param_01)
{
	switch(param_01)
	{
		case "suppressed":
			if(param_00.suppressedtime > 1)
			{
				self.squadstates[param_01].numactive++;
			}
			break;

		case "combat":
			if(param_00.combattime > 0)
			{
				self.squadstates[param_01].numactive++;
			}
			break;

		case "attacking":
			if(gettime() < param_00.a.lastshoottime + 2000)
			{
				self.squadstates[param_01].numactive++;
			}
			break;

		case "cover":
			if(!param_00 animscripts/battlechatter::isexposed())
			{
				self.squadstates[param_01].numactive++;
			}
			break;
	}

	if(self.squadstates[param_01].numactive > self.squadstates[param_01].activateratio * self.members.size)
	{
		self.squadstates[param_01].isactive = 1;
	}
}