/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\squadmanager.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 32
 * Decompile Time: 565 ms
 * Timestamp: 10/27/2023 1:24:31 AM
*******************************************************************/

//Function Number: 1
func_45AF()
{
	if(isdefined(level.var_7995) && level.var_7995)
	{
		return;
	}

	anim.var_798F = [];
	anim.var_7990 = [];
	anim.var_799C = [];
	anim.var_7994 = [];
	anim.var_799B = 0;
	anim.var_7995 = 1;
}

//Function Number: 2
createsquad(param_00,param_01)
{
	level.var_799C[param_00] = spawnstruct();
	var_02 = level.var_799C[param_00];
	var_02.var_7998 = param_00;
	var_02.team = func_3BFF(param_01);
	var_02.var_754E = 0;
	var_02.origin = undefined;
	var_02.forward = undefined;
	var_02.enemy = undefined;
	var_02.var_48DE = 0;
	var_02.var_51C0 = 0;
	var_02.var_51C5 = [];
	var_02.officers = [];
	var_02.officercount = 0;
	var_02.var_7996 = [];
	var_02.var_51BD = [];
	var_02.var_51BE = [];
	var_02.var_51C3 = [];
	var_02.memberremovestrings = [];
	var_02.squadupdatefuncs = [];
	var_02.var_79A1 = [];
	var_02.var_7993 = level.var_7994.size;
	var_02 initstate("combat",0.75);
	var_02 initstate("cover",0.75);
	var_02 initstate("move",0.75);
	var_02 initstate("stop",0.75);
	var_02 initstate("death",0.75);
	var_02 initstate("suppressed",0.75);
	var_02 initstate("attacking",0.5);
	level.var_7994[level.var_7994.size] = var_02;
	var_02 func_8735();
	level notify("squad created " + param_00);
	anim notify("squad created " + param_00);
	for(var_03 = 0;var_03 < level.var_798F.size;var_03++)
	{
		var_04 = level.var_798F[var_03];
		var_02 thread [[ var_04 ]]();
	}

	for(var_03 = 0;var_03 < level.var_7994.size;var_03++)
	{
		level.var_7994[var_03] func_8735();
	}

	var_02 thread func_8754();
	var_02 thread func_799F();
	var_02 thread func_5861();
	var_02 thread func_8702();
	return var_02;
}

//Function Number: 3
func_2598(param_00)
{
	if(param_00 == "axis" || param_00 == "team3" || param_00 == "allies")
	{
	}

	var_01 = level.var_799C[param_00].var_7993;
	var_02 = level.var_799C[param_00];
	var_02 notify("squad_deleting");
	while(var_02.var_51C5.size)
	{
		var_02.var_51C5[0] addtosquad(var_02.var_51C5[0].team);
	}

	level.var_7994[var_01] = level.var_7994[level.var_7994.size - 1];
	level.var_7994[var_01].var_7993 = var_01;
	level.var_7994[level.var_7994.size - 1] = undefined;
	level.var_799C[param_00] = undefined;
	level notify("squad deleted " + param_00);
	anim notify("squad deleted " + param_00);
	for(var_03 = 0;var_03 < level.var_7994.size;var_03++)
	{
		level.var_7994[var_03] func_8735();
	}
}

//Function Number: 4
generatesquadname()
{
	var_00 = "auto" + level.var_799B;
	level.var_799B++;
	return var_00;
}

//Function Number: 5
addplayertosquad(param_00)
{
	if(!isdefined(param_00))
	{
		if(isdefined(self.var_6CB8))
		{
			param_00 = self.var_6CB8;
		}
		else
		{
			param_00 = self.team;
		}
	}

	if(!isdefined(level.var_799C[param_00]))
	{
		anim createsquad(param_00,self);
	}

	var_01 = level.var_799C[param_00];
	self.squad = var_01;
}

//Function Number: 6
func_798E()
{
	self endon("death");
	wait(10);
	if(!isdefined(self.var_6CB8))
	{
		var_00 = self.team + self.var_6BC7;
	}
	else
	{
		var_00 = self.var_6CB8 + self.var_6BC7;
	}

	addtosquad(var_00);
}

//Function Number: 7
func_3BFF(param_00)
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
		if(isdefined(self.var_6BC7))
		{
			thread func_798E();
		}

		if(isdefined(self.var_6CB8))
		{
			param_00 = self.var_6CB8;
		}
		else
		{
			param_00 = self.team;
		}
	}

	if(!isdefined(level.var_799C[param_00]))
	{
		anim createsquad(param_00,self);
	}

	var_01 = level.var_799C[param_00];
	if(isdefined(self.squad))
	{
		if(self.squad == var_01)
		{
		}
		else
		{
			func_6593();
		}
	}

	self.var_4C5F = 0;
	self.combattime = 0;
	self.squad = var_01;
	self.var_51C2 = var_01.var_51C5.size;
	var_01.var_51C5[self.var_51C2] = self;
	var_01.var_51C0 = var_01.var_51C5.size;
	if(isdefined(level.var_4EA0))
	{
		if(self.team == "allies" && animscripts/battlechatter::func_4920())
		{
			addofficertosquad();
		}
	}

	for(var_02 = 0;var_02 < self.squad.var_51BD.size;var_02++)
	{
		var_03 = self.squad.var_51BD[var_02];
		self thread [[ var_03 ]](self.squad.var_7998);
	}

	thread func_51BF();
	thread func_51C1();
}

//Function Number: 9
func_6593()
{
	var_00 = self.squad;
	var_01 = -1;
	if(isdefined(self))
	{
		var_01 = self.var_51C2;
	}
	else
	{
		for(var_02 = 0;var_02 < var_00.var_51C5.size;var_02++)
		{
			if(var_00.var_51C5[var_02] == self)
			{
				var_01 = var_02;
			}
		}
	}

	if(var_01 != var_00.var_51C5.size - 1)
	{
		var_03 = var_00.var_51C5[var_00.var_51C5.size - 1];
		var_00.var_51C5[var_01] = var_03;
		if(isdefined(var_03))
		{
			var_03.var_51C2 = var_01;
		}
	}

	var_00.var_51C5[var_00.var_51C5.size - 1] = undefined;
	var_00.var_51C0 = var_00.var_51C5.size;
	if(isdefined(self.officerid))
	{
		func_65A2();
	}

	for(var_02 = 0;var_02 < self.squad.var_51C3.size;var_02++)
	{
		var_04 = self.squad.var_51C3[var_02];
		self thread [[ var_04 ]](var_00.var_7998);
	}

	if(var_00.var_51C0 == 0)
	{
		func_2598(var_00.var_7998);
	}

	if(isdefined(self))
	{
		self.squad = undefined;
		self.var_51C2 = undefined;
	}

	self notify("removed from squad");
}

//Function Number: 10
addofficertosquad()
{
	var_00 = self.squad;
	if(isdefined(self.officerid))
	{
	}

	self.officerid = var_00.officers.size;
	var_00.officers[self.officerid] = self;
	var_00.officercount = var_00.officers.size;
}

//Function Number: 11
func_65A2()
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
func_5861()
{
	if(!isdefined(level.var_4EA0))
	{
		anim waittill("loadout complete");
	}

	for(var_00 = 0;var_00 < self.var_51C5.size;var_00++)
	{
		if(self.var_51C5[var_00] animscripts/battlechatter::func_4920())
		{
			self.var_51C5[var_00] addofficertosquad();
		}
	}
}

//Function Number: 13
func_8754()
{
	for(;;)
	{
		anim waittill("squadupdate",var_00);
		switch(var_00)
		{
			case "squadlist":
				func_8735();
				break;
	
			case "combat":
				func_86D9();
				break;
	
			case "origin":
				func_870A();
				break;
	
			case "forward":
				func_86F2();
				break;
		}
	}
}

//Function Number: 14
func_799F()
{
	anim endon("squad deleted " + self.var_7998);
	for(;;)
	{
		func_86C6();
		wait(0.1);
	}
}

//Function Number: 15
func_51C1()
{
	self endon("removed from squad");
	self waittill("death",var_00);
	if(isdefined(self))
	{
		self.attacker = var_00;
	}

	func_6593();
}

//Function Number: 16
func_51BF()
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
			self.squad.var_48DE = 1;
		}

		wait(0.05);
	}
}

//Function Number: 17
func_86F2()
{
	if(isdefined(self.enemy))
	{
		self.forward = vectornormalize(self.enemy.origin - self.origin);
	}

	var_00 = (0,0,0);
	var_01 = 0;
	for(var_02 = 0;var_02 < self.var_51C5.size;var_02++)
	{
		if(!isalive(self.var_51C5[var_02]))
		{
			continue;
		}

		var_00 = var_00 + anglestoforward(self.var_51C5[var_02].angles);
		var_01++;
	}

	if(var_01)
	{
		self.forward = (var_00[0] / var_01,var_00[1] / var_01,var_00[2] / var_01);
	}

	self.forward = var_00;
}

//Function Number: 18
func_870A()
{
	var_00 = (0,0,0);
	var_01 = 0;
	for(var_02 = 0;var_02 < self.var_51C5.size;var_02++)
	{
		if(!isalive(self.var_51C5[var_02]))
		{
			continue;
		}

		var_00 = var_00 + self.var_51C5[var_02].origin;
		var_01++;
	}

	if(var_01)
	{
		self.origin = (var_00[0] / var_01,var_00[1] / var_01,var_00[2] / var_01);
	}

	self.origin = var_00;
}

//Function Number: 19
func_86D9()
{
	self.var_48DE = 0;
	for(var_00 = 0;var_00 < level.var_7994.size;var_00++)
	{
		self.var_7996[level.var_7994[var_00].var_7998].isincontact = 0;
	}

	for(var_00 = 0;var_00 < self.var_51C5.size;var_00++)
	{
		if(isdefined(self.var_51C5[var_00].enemy) && isdefined(self.var_51C5[var_00].enemy.squad) && self.var_51C5[var_00].combattime > 0)
		{
			self.var_7996[self.var_51C5[var_00].enemy.squad.var_7998].isincontact = 1;
		}
	}
}

//Function Number: 20
func_86E5()
{
	var_00 = undefined;
	for(var_01 = 0;var_01 < self.var_51C5.size;var_01++)
	{
		if(isdefined(self.var_51C5[var_01].enemy) && isdefined(self.var_51C5[var_01].enemy.squad))
		{
			if(!isdefined(var_00))
			{
				var_00 = self.var_51C5[var_01].enemy.squad;
				continue;
			}

			if(self.var_51C5[var_01].enemy.squad.var_51C0 > var_00.var_51C0)
			{
				var_00 = self.var_51C5[var_01].enemy.squad;
			}
		}
	}

	self.enemy = var_00;
}

//Function Number: 21
func_86C6()
{
	var_00 = (0,0,0);
	var_01 = 0;
	var_02 = undefined;
	var_03 = 0;
	func_86D9();
	for(var_04 = 0;var_04 < self.var_51C5.size;var_04++)
	{
		if(!isalive(self.var_51C5[var_04]))
		{
			continue;
		}

		var_00 = var_00 + self.var_51C5[var_04].origin;
		var_01++;
		if(isdefined(self.var_51C5[var_04].enemy) && isdefined(self.var_51C5[var_04].enemy.squad))
		{
			if(!isdefined(var_02))
			{
				var_02 = self.var_51C5[var_04].enemy.squad;
				continue;
			}

			if(self.var_51C5[var_04].enemy.squad.var_51C0 > var_02.var_51C0)
			{
				var_02 = self.var_51C5[var_04].enemy.squad;
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

	self.var_48DE = var_03;
	self.enemy = var_02;
	func_86F2();
}

//Function Number: 22
func_8735()
{
	for(var_00 = 0;var_00 < level.var_7994.size;var_00++)
	{
		if(!isdefined(self.var_7996[level.var_7994[var_00].var_7998]))
		{
			self.var_7996[level.var_7994[var_00].var_7998] = spawnstruct();
			self.var_7996[level.var_7994[var_00].var_7998].isincontact = 0;
		}

		for(var_01 = 0;var_01 < self.squadupdatefuncs.size;var_01++)
		{
			var_02 = self.squadupdatefuncs[var_01];
			self thread [[ var_02 ]](level.var_7994[var_00].var_7998);
		}
	}
}

//Function Number: 23
func_61A0(param_00,param_01,param_02,param_03)
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
		}

		var_05 = self getshootatpos() + (0,0,10) + param_02;
		wait(0.05);
	}
}

//Function Number: 24
aiupdateanimstate(param_00)
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
		case "cover_swim_up":
		case "cover_swim_right":
		case "cover_swim_left":
		case "cover_prone":
		case "cover_left":
		case "cover_stand":
		case "cover_crouch":
		case "cover_multi":
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
func_8738()
{
	resetstate("combat");
	resetstate("cover");
	resetstate("move");
	resetstate("stop");
	resetstate("death");
	resetstate("suppressed");
	resetstate("attacking");
	for(var_00 = 0;var_00 < self.var_51C5.size;var_00++)
	{
		if(!isalive(self.var_51C5[var_00]))
		{
			continue;
		}

		func_6293(self.var_51C5[var_00]);
		func_6294(self.var_51C5[var_00],"suppressed");
		func_6294(self.var_51C5[var_00],"combat");
		func_6294(self.var_51C5[var_00],"attacking");
		func_6294(self.var_51C5[var_00],"cover");
	}
}

//Function Number: 26
func_8702()
{
	anim endon("squad deleted " + self.var_7998);
	var_00 = 0.05;
	for(;;)
	{
		for(var_01 = 0;var_01 < self.var_51C5.size;var_01++)
		{
			if(!isalive(self.var_51C5[var_01]))
			{
				continue;
			}

			self.var_51C5[var_01] aiupdatecombat(var_00);
			self.var_51C5[var_01] aiupdatesuppressed(var_00);
		}

		wait(var_00);
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

		self.var_4C5F = gettime();
	}
	else if(self issuppressed())
	{
		self.combattime = self.combattime + param_00;
	}

	if(self.combattime > 0)
	{
		self.combattime = 0 - param_00;
	}

	self.combattime = self.combattime - param_00;
}

//Function Number: 28
aiupdatesuppressed(param_00)
{
	if(self.var_7D64)
	{
		if(self.var_7D66 < 0)
		{
			self.var_7D66 = param_00;
		}
		else
		{
			self.var_7D66 = self.var_7D66 + param_00;
		}
	}

	if(self.var_7D66 > 0)
	{
		self.var_7D66 = 0 - param_00;
	}

	self.var_7D66 = self.var_7D66 - param_00;
}

//Function Number: 29
initstate(param_00,param_01)
{
	self.var_799D[param_00] = spawnstruct();
	self.var_799D[param_00].activateratio = param_01;
	self.var_799D[param_00].isactive = 0;
	self.var_799D[param_00].var_5772 = 0;
}

//Function Number: 30
resetstate(param_00)
{
	self.var_799D[param_00].isactive = 0;
	self.var_799D[param_00].var_5772 = 0;
}

//Function Number: 31
func_6293(param_00)
{
	self.var_799D[param_00.a.state].var_5772++;
	if(self.var_799D[param_00.a.state].var_5772 > self.var_799D[param_00.a.state].activateratio * self.var_51C5.size)
	{
		self.var_799D[param_00.a.state].isactive = 1;
	}
}

//Function Number: 32
func_6294(param_00,param_01)
{
	switch(param_01)
	{
		case "suppressed":
			if(param_00.var_7D66 > 1)
			{
				self.var_799D[param_01].var_5772++;
			}
			break;

		case "combat":
			if(param_00.combattime > 0)
			{
				self.var_799D[param_01].var_5772++;
			}
			break;

		case "attacking":
			if(gettime() < param_00.a.lastshoottime + 2000)
			{
				self.var_799D[param_01].var_5772++;
			}
			break;

		case "cover":
			if(!param_00 animscripts/battlechatter::isexposed())
			{
				self.var_799D[param_01].var_5772++;
			}
			break;
	}

	if(self.var_799D[param_01].var_5772 > self.var_799D[param_01].activateratio * self.var_51C5.size)
	{
		self.var_799D[param_01].isactive = 1;
	}
}