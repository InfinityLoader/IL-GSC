/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\squadmanager.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 32
 * Decompile Time: 556 ms
 * Timestamp: 10/27/2023 2:18:49 AM
*******************************************************************/

//Function Number: 1
func_0A5E()
{
	if(isdefined(level.var_A5F) && level.var_A5F)
	{
		return;
	}

	anim.var_A60 = [];
	anim.var_A61 = [];
	anim.var_A62 = [];
	anim.var_A63 = [];
	anim.var_A64 = 0;
	anim.var_A5F = 1;
}

//Function Number: 2
func_0A65(param_00,param_01)
{
	level.var_A62[param_00] = spawnstruct();
	var_02 = level.var_A62[param_00];
	var_02.var_A66 = param_00;
	var_02.team = func_0A7D(param_01);
	var_02.var_A67 = 0;
	var_02.origin = undefined;
	var_02.forward = undefined;
	var_02.enemy = undefined;
	var_02.var_A69 = 0;
	var_02.var_A6A = 0;
	var_02.members = [];
	var_02.var_A6C = [];
	var_02.var_A6D = 0;
	var_02.var_A6E = [];
	var_02.var_A6F = [];
	var_02.var_A70 = [];
	var_02.var_A71 = [];
	var_02.var_A72 = [];
	var_02.var_A73 = [];
	var_02.var_A74 = [];
	var_02.var_A75 = level.var_A63.size;
	var_02 func_0A9F("combat",0.75);
	var_02 func_0A9F("cover",0.75);
	var_02 func_0A9F("move",0.75);
	var_02 func_0A9F("stop",0.75);
	var_02 func_0A9F("death",0.75);
	var_02 func_0A9F("suppressed",0.75);
	var_02 func_0A9F("attacking",0.5);
	level.var_A63[level.var_A63.size] = var_02;
	var_02 func_0A94();
	level notify("squad created " + param_00);
	anim notify("squad created " + param_00);
	for(var_03 = 0;var_03 < level.var_A60.size;var_03++)
	{
		var_04 = level.var_A60[var_03];
		var_02 thread [[ var_04 ]]();
	}

	for(var_03 = 0;var_03 < level.var_A63.size;var_03++)
	{
		level.var_A63[var_03] func_0A94();
	}

	var_02 thread func_0A89();
	var_02 thread func_0A8A();
	var_02 thread func_0A88();
	var_02 thread func_0A9A();
	return var_02;
}

//Function Number: 3
func_0A76(param_00)
{
	if(param_00 == "axis" || param_00 == "team3" || param_00 == "allies")
	{
		return;
	}

	var_01 = level.var_A62[param_00].var_A75;
	var_02 = level.var_A62[param_00];
	var_02 notify("squad_deleting");
	while(var_02.members.size)
	{
		var_02.members[0] func_0A7E(var_02.members[0].team);
	}

	level.var_A63[var_01] = level.var_A63[level.var_A63.size - 1];
	level.var_A63[var_01].var_A75 = var_01;
	level.var_A63[level.var_A63.size - 1] = undefined;
	level.var_A62[param_00] = undefined;
	level notify("squad deleted " + param_00);
	anim notify("squad deleted " + param_00);
	for(var_03 = 0;var_03 < level.var_A63.size;var_03++)
	{
		level.var_A63[var_03] func_0A94();
	}
}

//Function Number: 4
func_0A77()
{
	var_00 = "auto" + level.var_A64;
	level.var_A64++;
	return var_00;
}

//Function Number: 5
func_0A78(param_00)
{
	if(!isdefined(param_00))
	{
		if(isdefined(self.var_A79))
		{
			param_00 = self.var_A79;
		}
		else
		{
			param_00 = self.team;
		}
	}

	if(!isdefined(level.var_A62[param_00]))
	{
		anim func_0A65(param_00,self);
	}

	var_01 = level.var_A62[param_00];
	self.var_A7A = var_01;
}

//Function Number: 6
func_0A7B()
{
	self endon("death");
	wait 10;
	if(!isdefined(self.var_A79))
	{
		var_00 = self.team + self.script_flanker;
	}
	else
	{
		var_00 = self.var_A79 + self.script_flanker;
	}

	func_0A7E(var_00);
}

//Function Number: 7
func_0A7D(param_00)
{
	var_01 = "allies";
	if(param_00.team == "axis" || param_00.team == "neutral" || param_00.team == "team3")
	{
		var_01 = param_00.team;
	}

	return var_01;
}

//Function Number: 8
func_0A7E(param_00)
{
	if(!isdefined(param_00))
	{
		if(isdefined(self.script_flanker))
		{
			thread func_0A7B();
		}

		if(isdefined(self.var_A79))
		{
			param_00 = self.var_A79;
		}
		else
		{
			param_00 = self.team;
		}
	}

	if(!isdefined(level.var_A62[param_00]))
	{
		anim func_0A65(param_00,self);
	}

	var_01 = level.var_A62[param_00];
	if(isdefined(self.var_A7A))
	{
		if(self.var_A7A == var_01)
		{
			return;
		}
		else
		{
			func_0A84();
		}
	}

	self.var_A7F = 0;
	self.var_A80 = 0;
	self.var_A7A = var_01;
	self.var_A81 = var_01.members.size;
	var_01.members[self.var_A81] = self;
	var_01.var_A6A = var_01.members.size;
	if(isdefined(level.loadoutcomplete))
	{
		if(self.team == "allies" && animscripts/battlechatter::func_A83())
		{
			func_0A86();
		}
	}

	for(var_02 = 0;var_02 < self.var_A7A.var_A6F.size;var_02++)
	{
		var_03 = self.var_A7A.var_A6F[var_02];
		self thread [[ var_03 ]](self.var_A7A.var_A66);
	}

	thread func_0A8D();
	thread func_0A8B();
}

//Function Number: 9
func_0A84()
{
	var_00 = self.var_A7A;
	var_01 = -1;
	if(isdefined(self))
	{
		var_01 = self.var_A81;
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
			var_03.var_A81 = var_01;
		}
	}

	var_00.members[var_00.members.size - 1] = undefined;
	var_00.var_A6A = var_00.members.size;
	if(isdefined(self.var_A85))
	{
		func_0A87();
	}

	for(var_02 = 0;var_02 < self.var_A7A.var_A71.size;var_02++)
	{
		var_04 = self.var_A7A.var_A71[var_02];
		self thread [[ var_04 ]](var_00.var_A66);
	}

	if(var_00.var_A6A == 0)
	{
		func_0A76(var_00.var_A66);
	}

	if(isdefined(self))
	{
		self.var_A7A = undefined;
		self.var_A81 = undefined;
	}

	self notify("removed from squad");
}

//Function Number: 10
func_0A86()
{
	var_00 = self.var_A7A;
	if(isdefined(self.var_A85))
	{
		return;
	}

	self.var_A85 = var_00.var_A6C.size;
	var_00.var_A6C[self.var_A85] = self;
	var_00.var_A6D = var_00.var_A6C.size;
}

//Function Number: 11
func_0A87()
{
	var_00 = self.var_A7A;
	var_01 = -1;
	if(isdefined(self))
	{
		var_01 = self.var_A85;
	}
	else
	{
		for(var_02 = 0;var_02 < var_00.var_A6C.size;var_02++)
		{
			if(var_00.var_A6C[var_02] == self)
			{
				var_01 = var_02;
			}
		}
	}

	if(var_01 != var_00.var_A6C.size - 1)
	{
		var_03 = var_00.var_A6C[var_00.var_A6C.size - 1];
		var_00.var_A6C[var_01] = var_03;
		if(isdefined(var_03))
		{
			var_03.var_A85 = var_01;
		}
	}

	var_00.var_A6C[var_00.var_A6C.size - 1] = undefined;
	var_00.var_A6D = var_00.var_A6C.size;
	if(isdefined(self))
	{
		self.var_A85 = undefined;
	}
}

//Function Number: 12
func_0A88()
{
	if(!isdefined(level.loadoutcomplete))
	{
		anim waittill("loadout complete");
	}

	for(var_00 = 0;var_00 < self.members.size;var_00++)
	{
		if(self.members[var_00] animscripts/battlechatter::func_A83())
		{
			self.members[var_00] func_0A86();
		}
	}
}

//Function Number: 13
func_0A89()
{
	for(;;)
	{
		anim waittill("squadupdate",var_00);
		switch(var_00)
		{
			case "squadlist":
				func_0A94();
				break;
	
			case "combat":
				func_0A90();
				break;
	
			case "origin":
				updateorigin();
				break;
	
			case "forward":
				func_0A8E();
				break;
		}
	}
}

//Function Number: 14
func_0A8A()
{
	anim endon("squad deleted " + self.var_A66);
	for(;;)
	{
		func_0A93();
		wait 0.1;
	}
}

//Function Number: 15
func_0A8B()
{
	self endon("removed from squad");
	self waittill("death",var_00);
	if(isdefined(self))
	{
		self.attacker = var_00;
	}

	func_0A84();
}

//Function Number: 16
func_0A8D()
{
	self endon("removed from squad");
	for(;;)
	{
		self waittill("enemy");
		if(!isdefined(self.enemy))
		{
			self.var_A7A notify("squadupdate","combat");
		}
		else
		{
			self.var_A7A.var_A69 = 1;
		}

		wait 0.05;
	}
}

//Function Number: 17
func_0A8E()
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
func_0A90()
{
	self.var_A69 = 0;
	for(var_00 = 0;var_00 < level.var_A63.size;var_00++)
	{
		self.var_A6E[level.var_A63[var_00].var_A66].var_A91 = 0;
	}

	for(var_00 = 0;var_00 < self.members.size;var_00++)
	{
		if(isdefined(self.members[var_00].enemy) && isdefined(self.members[var_00].enemy.var_A7A) && self.members[var_00].var_A80 > 0)
		{
			self.var_A6E[self.members[var_00].enemy.var_A7A.var_A66].var_A91 = 1;
		}
	}
}

//Function Number: 20
func_0A92()
{
	var_00 = undefined;
	for(var_01 = 0;var_01 < self.members.size;var_01++)
	{
		if(isdefined(self.members[var_01].enemy) && isdefined(self.members[var_01].enemy.var_A7A))
		{
			if(!isdefined(var_00))
			{
				var_00 = self.members[var_01].enemy.var_A7A;
				continue;
			}

			if(self.members[var_01].enemy.var_A7A.var_A6A > var_00.var_A6A)
			{
				var_00 = self.members[var_01].enemy.var_A7A;
			}
		}
	}

	self.enemy = var_00;
}

//Function Number: 21
func_0A93()
{
	var_00 = (0,0,0);
	var_01 = 0;
	var_02 = undefined;
	var_03 = 0;
	func_0A90();
	for(var_04 = 0;var_04 < self.members.size;var_04++)
	{
		if(!isalive(self.members[var_04]))
		{
			continue;
		}

		var_00 = var_00 + self.members[var_04].origin;
		var_01++;
		if(isdefined(self.members[var_04].enemy) && isdefined(self.members[var_04].enemy.var_A7A))
		{
			if(!isdefined(var_02))
			{
				var_02 = self.members[var_04].enemy.var_A7A;
				continue;
			}

			if(self.members[var_04].enemy.var_A7A.var_A6A > var_02.var_A6A)
			{
				var_02 = self.members[var_04].enemy.var_A7A;
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

	self.var_A69 = var_03;
	self.enemy = var_02;
	func_0A8E();
}

//Function Number: 22
func_0A94()
{
	for(var_00 = 0;var_00 < level.var_A63.size;var_00++)
	{
		if(!isdefined(self.var_A6E[level.var_A63[var_00].var_A66]))
		{
			self.var_A6E[level.var_A63[var_00].var_A66] = spawnstruct();
			self.var_A6E[level.var_A63[var_00].var_A66].var_A91 = 0;
		}

		for(var_01 = 0;var_01 < self.var_A73.size;var_01++)
		{
			var_02 = self.var_A73[var_01];
			self thread [[ var_02 ]](level.var_A63[var_00].var_A66);
		}
	}
}

//Function Number: 23
func_0A95(param_00,param_01,param_02,param_03)
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
func_0A96(param_00)
{
	switch(param_00)
	{
		case "move":
		case "combat":
		case "death":
		case "stop":
			self.a.var_A98 = param_00;
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
			self.a.var_A98 = "cover";
			break;

		case "l33t truckride combat":
		case "aim":
			self.a.var_A98 = "combat";
			break;
	}
}

//Function Number: 25
func_0A99()
{
	func_0AA4("combat");
	func_0AA4("cover");
	func_0AA4("move");
	func_0AA4("stop");
	func_0AA4("death");
	func_0AA4("suppressed");
	func_0AA4("attacking");
	for(var_00 = 0;var_00 < self.members.size;var_00++)
	{
		if(!isalive(self.members[var_00]))
		{
			continue;
		}

		func_0AA5(self.members[var_00]);
		func_0AA6(self.members[var_00],"suppressed");
		func_0AA6(self.members[var_00],"combat");
		func_0AA6(self.members[var_00],"attacking");
		func_0AA6(self.members[var_00],"cover");
	}
}

//Function Number: 26
func_0A9A()
{
	anim endon("squad deleted " + self.var_A66);
	var_00 = 0.05;
	for(;;)
	{
		for(var_01 = 0;var_01 < self.members.size;var_01++)
		{
			if(!isalive(self.members[var_01]))
			{
				continue;
			}

			self.members[var_01] func_0A9B(var_00);
			self.members[var_01] func_0A9C(var_00);
		}

		wait var_00;
	}
}

//Function Number: 27
func_0A9B(param_00)
{
	if(isdefined(self.lastenemysightpos))
	{
		if(self.var_A80 < 0)
		{
			self.var_A80 = param_00;
		}
		else
		{
			self.var_A80 = self.var_A80 + param_00;
		}

		self.var_A7F = gettime();
		return;
	}
	else if(self issuppressed())
	{
		self.var_A80 = self.var_A80 + param_00;
		return;
	}

	if(self.var_A80 > 0)
	{
		self.var_A80 = 0 - param_00;
		return;
	}

	self.var_A80 = self.var_A80 - param_00;
}

//Function Number: 28
func_0A9C(param_00)
{
	if(self.var_A9D)
	{
		if(self.var_A9E < 0)
		{
			self.var_A9E = param_00;
		}
		else
		{
			self.var_A9E = self.var_A9E + param_00;
		}

		return;
	}

	if(self.var_A9E > 0)
	{
		self.var_A9E = 0 - param_00;
		return;
	}

	self.var_A9E = self.var_A9E - param_00;
}

//Function Number: 29
func_0A9F(param_00,param_01)
{
	self.var_AA0[param_00] = spawnstruct();
	self.var_AA0[param_00].var_AA1 = param_01;
	self.var_AA0[param_00].var_AA2 = 0;
	self.var_AA0[param_00].var_AA3 = 0;
}

//Function Number: 30
func_0AA4(param_00)
{
	self.var_AA0[param_00].var_AA2 = 0;
	self.var_AA0[param_00].var_AA3 = 0;
}

//Function Number: 31
func_0AA5(param_00)
{
	self.var_AA0[param_00.a.var_A98].var_AA3++;
	if(self.var_AA0[param_00.a.var_A98].var_AA3 > self.var_AA0[param_00.a.var_A98].var_AA1 * self.members.size)
	{
		self.var_AA0[param_00.a.var_A98].var_AA2 = 1;
	}
}

//Function Number: 32
func_0AA6(param_00,param_01)
{
	switch(param_01)
	{
		case "suppressed":
			if(param_00.var_A9E > 1)
			{
				self.var_AA0[param_01].var_AA3++;
			}
			break;

		case "combat":
			if(param_00.var_A80 > 0)
			{
				self.var_AA0[param_01].var_AA3++;
			}
			break;

		case "attacking":
			if(gettime() < param_00.a.lastshoottime + 2000)
			{
				self.var_AA0[param_01].var_AA3++;
			}
			break;

		case "cover":
			if(!param_00 animscripts/battlechatter::func_AA8())
			{
				self.var_AA0[param_01].var_AA3++;
			}
			break;
	}

	if(self.var_AA0[param_01].var_AA3 > self.var_AA0[param_01].var_AA1 * self.members.size)
	{
		self.var_AA0[param_01].var_AA2 = 1;
	}
}