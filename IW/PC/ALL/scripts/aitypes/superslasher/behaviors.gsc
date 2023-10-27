/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\aitypes\superslasher\behaviors.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 92
 * Decompile Time: 4058 ms
 * Timestamp: 10/26/2023 11:59:04 PM
*******************************************************************/

//Function Number: 1
superslasher_isonroof()
{
	return self.var_3135.locationstate == 0;
}

//Function Number: 2
superslasher_isonground()
{
	return self.var_3135.locationstate == 2;
}

//Function Number: 3
superslasher_isgoingtoroof()
{
	return self.var_3135.locationstate == 1;
}

//Function Number: 4
superslasher_isgoingtoground()
{
	return self.var_3135.locationstate == 3;
}

//Function Number: 5
superslasher_isfinalstage()
{
	return self.health <= self.maxhealth * 0.1;
}

//Function Number: 6
superslasher_init(param_00)
{
	self method_85B6("superslasher");
	self.var_3135.locationstate = 0;
	self.var_3135.allownextaction = gettime() + 1000;
	self.var_3135.imaskchange = 0;
	self.nextsummonid = 0;
	self.bmaystomp = 1;
	self.bmayjumpattack = 1;
	self.bmayfrisbee = 0;
	self.bmaysawfan = 0;
	self.bmaytaunt = 0;
	self.bmayshockwave = 1;
	self.bmaywire = 0;
	self.bmayshark = 1;
	roof_initbehaviors();
	self.var_3135.onroofstarttime = gettime() - 120000 + 2000;
	setnextidlesoundtime();
	setdvarifuninitialized("btSuperSlasherShield",0);
	setdvarifuninitialized("btSuperSlasherTargetTimer",20000);
	setdvarifuninitialized("btSuperSlasherRush",0);
	self.animratescale = 1.25;
	self.var_BCD6 = self.animratescale;
	self.var_BCE4 = self.var_BCD6;
	return level.var_111AE;
}

//Function Number: 7
func_58E1(param_00)
{
	if(!isdefined(self.var_1198.bintrorequested))
	{
		return level.var_111AE;
	}

	if(lib_0A1A::func_232A("intro_anim","end"))
	{
		self.var_1198.bintrorequested = undefined;
		return level.var_111AE;
	}

	return level.var_E87A;
}

//Function Number: 8
updateeveryframe(param_00)
{
	if(!isalive(self))
	{
		return level.var_6AD5;
	}

	if((isdefined(self.var_EF47) && self.var_EF47) || isdefined(self.var_1198.bgameended))
	{
		self method_841F();
		self method_8287(512);
		return level.var_6AD5;
	}

	func_12F35();
	self.var_BCD6 = self.animratescale;
	self.var_BCE4 = self.var_BCD6;
	updateidlesound();
	return level.var_111AE;
}

//Function Number: 9
setnextidlesoundtime()
{
	self.nextidlesoundtime = gettime() + 3000 + randomint(2000);
}

//Function Number: 10
updateidlesound()
{
	if(gettime() > self.nextidlesoundtime)
	{
		if(isdefined(self.var_1198.var_2BE4) || isdefined(self.var_1198.bidle))
		{
			self playsoundonmovingent("zmb_vo_supslasher_idle_grunt");
		}

		setnextidlesoundtime();
	}
}

//Function Number: 11
isvalidtarget(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	if(!isalive(param_00))
	{
		return 0;
	}

	if(param_00.ignoreme || isdefined(param_00.var_222) && param_00.var_222.ignoreme)
	{
		return 0;
	}

	if(lib_0F74::func_1002C(param_00))
	{
		return 0;
	}

	return 1;
}

//Function Number: 12
func_F874(param_00)
{
	self.var_3135.target = param_00;
	self.var_3135.targetstarttime = gettime();
}

//Function Number: 13
func_12F35()
{
	var_00 = !isdefined(self.var_3135.target) || !isvalidtarget(self.var_3135.target);
	if(!var_00)
	{
		var_01 = getdvarint("btSuperSlasherTargetTimer");
		var_00 = var_01 > 0 && gettime() > self.var_3135.targetstarttime + var_01;
	}

	if(var_00)
	{
		var_02 = level.players;
		if(isdefined(self.var_3135.target))
		{
			var_02 = scripts\common\utility::func_22A9(var_02,self.var_3135.target);
		}

		var_03 = [];
		foreach(var_05 in var_02)
		{
			if(isvalidtarget(var_05))
			{
				var_03[var_03.size] = var_05;
			}
		}

		if(var_03.size > 0)
		{
			func_F874(var_03[randomint(var_03.size)]);
		}
	}
}

//Function Number: 14
dotrapped(param_00)
{
	if(isdefined(self.var_1198.btraprequested))
	{
		return level.var_E87A;
	}

	return level.var_111AE;
}

//Function Number: 15
shouldgotoroof(param_00)
{
	if(self.var_3135.locationstate != 2)
	{
		return level.var_6AD5;
	}

	if(superslasher_isfinalstage())
	{
		return level.var_6AD5;
	}

	if(isdefined(self.var_1198.bstaggerrequested))
	{
		return level.var_111AE;
	}

	if(isdefined(self.var_1198.bgotoroofrequested))
	{
		return level.var_111AE;
	}

	return level.var_6AD5;
}

//Function Number: 16
walktoroof_init(param_00)
{
	self.var_3135.var_9928[param_00] = spawnstruct();
	self.var_3135.var_9928[param_00].var_10DFF = gettime();
	self.var_3135.var_9928[param_00].var_15B = getclosestpointonnavmesh(level.superslashergotogroundspot,self);
	if(distance2dsquared(self.origin,level.superslashergotogroundspot) < 1296)
	{
		self.var_3135.var_9928[param_00].bgoodtogo = 1;
	}
}

//Function Number: 17
walktoroof(param_00)
{
	if(isdefined(self.var_3135.var_9928[param_00].bgoodtogo))
	{
		return level.var_111AE;
	}

	var_01 = gettime();
	var_02 = 10000;
	if(var_01 > self.var_3135.var_9928[param_00].var_10DFF + var_02)
	{
		return level.var_111AE;
	}

	if(var_01 > self.var_3135.var_9928[param_00].var_10DFF + 500)
	{
		if(!isdefined(self.var_233))
		{
			return level.var_111AE;
		}
	}

	self method_8286(self.var_3135.var_9928[param_00].var_15B);
	self method_8287(64);
	return level.var_E87A;
}

//Function Number: 18
walktoroof_cleanup(param_00)
{
	self.var_3135.var_9928[param_00] = undefined;
}

//Function Number: 19
jumptoroof_init(param_00)
{
	self.var_3135.var_9928[param_00] = gettime();
	self.var_1198.broofrequested = 1;
	self.var_1198.iroofjump = 0;
	scripts\aitypes\superslasher\util::ongotoroof_init();
	scripts\asm\superslasher\superslasher_actions::killallsharks(self);
	self notify("kill_sharks");
}

//Function Number: 20
jumptoroof(param_00)
{
	var_01 = 15000;
	var_02 = gettime();
	if(gettime() > self.var_3135.var_9928[param_00] + var_01)
	{
		self setorigin(level.superslasherrooftopspot,1);
		self.angles = level.superslasherrooftopangles;
		self.var_3135.locationstate = 0;
		roof_initbehaviors();
		return level.var_111AE;
	}

	if(lib_0A1A::func_232A("jumptoroof","end"))
	{
		self.var_3135.locationstate = 0;
		roof_initbehaviors();
		return level.var_111AE;
	}

	return level.var_E87A;
}

//Function Number: 21
jumptoroof_cleanup(param_00)
{
	self.var_1198.broofrequested = undefined;
	self.var_3135.var_9928[param_00] = undefined;
}

//Function Number: 22
roof_initbehaviors()
{
	self method_841F();
	self method_8287(512);
	var_00 = gettime();
	self.var_3135.onroofstarttime = var_00;
	self.var_1198.bonroof = 1;
	self.var_3135.bcaninterruptfortimer = 1;
	self.var_1198.bgotoroofrequested = undefined;
	self.var_3135.allownextaction = var_00 + 1000;
	scripts\aitypes\superslasher\util::onroof_init();
}

//Function Number: 23
stagger_init(param_00)
{
	self.var_3135.var_9928[param_00] = gettime();
}

//Function Number: 24
dostagger(param_00)
{
	if(!isdefined(self.var_1198.bstaggerrequested))
	{
		return level.var_111AE;
	}

	var_01 = 5000;
	if(gettime() > self.var_3135.var_9928[param_00] + var_01)
	{
		return level.var_111AE;
	}

	if(lib_0A1A::func_232A("staggeranim","end"))
	{
		return level.var_111AE;
	}

	self method_841F(self.origin);
	self method_8287(36);
	return level.var_E87A;
}

//Function Number: 25
stagger_cleanup(param_00)
{
	self.var_3135.var_9928[param_00] = undefined;
	self.var_1198.bstaggerrequested = undefined;
}

//Function Number: 26
shouldgotoground(param_00)
{
	if(self.var_3135.locationstate != 0)
	{
		return level.var_6AD5;
	}

	if(isdefined(self.var_1198.bstaggerrequested))
	{
		return level.var_111AE;
	}

	if(isdefined(self.var_1198.bgotogroundrequested))
	{
		return level.var_111AE;
	}

	if(superslasher_isonroof())
	{
		return level.var_111AE;
	}

	return level.var_6AD5;
}

//Function Number: 27
gotoground_init(param_00)
{
	self.var_1198.bgroundrequested = 1;
	self.var_3135.locationstate = 3;
	if(!isdefined(self.var_3135.igroundphase))
	{
		self.var_3135.igroundphase = 0;
	}
	else
	{
		self.var_3135.igroundphase++;
	}

	scripts\aitypes\superslasher\util::ongotoground_init();
}

//Function Number: 28
gotoground(param_00)
{
	if(lib_0A1A::func_232A("jumptoground","end"))
	{
		self.var_3135.locationstate = 2;
		ground_initbehaviors();
		return level.var_111AE;
	}

	return level.var_E87A;
}

//Function Number: 29
ground_initbehaviors()
{
	self method_841F(self.origin);
	self method_8287(24);
	var_00 = gettime();
	self.var_3135.ongroundstarttime = var_00;
	self.var_1198.bonroof = 0;
	self.var_3135.bcaninterruptfortimer = 1;
	self.var_1198.bgotogroundrequested = undefined;
	self.var_3135.allownextaction = var_00 + 1000;
	self.var_3135.allowgroundpoundtime = var_00;
	self.var_3135.allowthrowsawtime = var_00;
	self.var_3135.allowthrowsawfantime = var_00;
	self.var_3135.allowgroundjumptime = var_00;
	self.var_3135.allowstomptime = var_00;
	self.var_3135.allowshockwavetime = var_00 + -6536;
	self.var_3135.allowsharktime = var_00 + 29000;
	scripts\aitypes\superslasher\util::onground_init();
	if(isdefined(self.btrophysystem))
	{
		thread dotrophysystem();
	}
}

//Function Number: 30
gotoground_cleanup(param_00)
{
	self.var_1198.bgroundrequested = undefined;
}

//Function Number: 31
isonroof(param_00)
{
	if(self.var_3135.locationstate == 0)
	{
		return level.var_111AE;
	}

	return level.var_6AD5;
}

//Function Number: 32
shouldtaunt(param_00)
{
	if(!isdefined(self.bmaytaunt) || !self.bmaytaunt)
	{
		return level.var_6AD5;
	}

	var_01 = gettime();
	if(var_01 < self.var_3135.allownextaction)
	{
		return level.var_6AD5;
	}

	if(var_01 < self.var_3135.allowtaunttime)
	{
		return level.var_6AD5;
	}

	if(isdefined(self.var_1198.bcommittedtoanim))
	{
		return level.var_6AD5;
	}

	if(self.var_3135.locationstate == 2)
	{
		return level.var_6AD5;
	}

	if(isanyplayerwithinradius(100))
	{
		return level.var_6AD5;
	}

	return level.var_111AE;
}

//Function Number: 33
taunt_init(param_00)
{
	self.var_3135.var_9928[param_00] = gettime();
	self.var_3135.bcaninterruptfortimer = 0;
	self.var_1198.btauntrequested = 1;
}

//Function Number: 34
taunt_setnextallowedtime()
{
	var_00 = gettime();
	if(self.var_3135.locationstate == 0)
	{
		self.var_3135.allowtaunttime = var_00 + 3000;
	}
	else
	{
		self.var_3135.allowtaunttime = var_00 + 10000;
	}

	self.var_3135.allownextaction = var_00 + 1000;
}

//Function Number: 35
func_5ABE(param_00)
{
	var_01 = 20000;
	if(gettime() > self.var_3135.var_9928[param_00] + var_01)
	{
		taunt_setnextallowedtime();
		return level.var_111AE;
	}

	if(lib_0A1A::func_232A("tauntanim","end"))
	{
		taunt_setnextallowedtime();
		return level.var_111AE;
	}

	self method_841F(self.origin);
	self method_8287(64);
	return level.var_E87A;
}

//Function Number: 36
taunt_cleanup(param_00)
{
	self.var_3135.var_9928[param_00] = undefined;
	self.var_3135.bcaninterruptfortimer = 1;
	self.var_1198.btauntrequested = undefined;
}

//Function Number: 37
dotauntcontinuously(param_00)
{
	self method_841F(self.origin);
	self method_8287(64);
	if(isdefined(self.var_1198.bstoptauntingcontinuously))
	{
		if(lib_0A1A::func_232A("tauntanim","end"))
		{
			taunt_setnextallowedtime();
			self.var_1198.bstoptauntingcontinuously = undefined;
			return level.var_111AE;
		}
	}

	return level.var_E87A;
}

//Function Number: 38
shouldgroundpound(param_00)
{
	if(!superslasher_isonground())
	{
		return level.var_6AD5;
	}

	if(gettime() < self.var_3135.allowgroundpoundtime)
	{
		return level.var_6AD5;
	}

	if(isdefined(self.var_1198.bcommittedtoanim))
	{
		return level.var_6AD5;
	}

	if(!isanyplayerwithinradius(256))
	{
		return level.var_6AD5;
	}

	return level.var_111AE;
}

//Function Number: 39
groundpound_init(param_00)
{
	self.var_3135.var_9928[param_00] = gettime();
	self method_841F(self.origin);
	self method_8287(36);
	self.var_3135.bcaninterruptfortimer = 0;
	self.var_1198.bgroundpoundrequested = 1;
}

//Function Number: 40
dogroundpound(param_00)
{
	var_01 = 12000;
	if(gettime() > self.var_3135.var_9928[param_00] + var_01)
	{
		groundpound_setnextallowedtime();
		return level.var_111AE;
	}

	if(lib_0A1A::func_232A("groundpoundanim","end"))
	{
		groundpound_setnextallowedtime();
		return level.var_111AE;
	}

	return level.var_E87A;
}

//Function Number: 41
groundpound_setnextallowedtime()
{
	var_00 = gettime();
	self.var_3135.allowgroundpoundtime = var_00 + 5000;
	self.var_3135.allownextaction = var_00 + 1000;
}

//Function Number: 42
groundpound_cleanup(param_00)
{
	self.var_3135.var_9928[param_00] = undefined;
	self.var_3135.bcaninterruptfortimer = 1;
	self.var_1198.bgroundpoundrequested = undefined;
}

//Function Number: 43
func_10039(param_00)
{
	if(!isdefined(self.var_3135.target))
	{
		return level.var_6AD5;
	}

	if(!superslasher_isonground())
	{
		return level.var_6AD5;
	}

	if(isanyplayerwithinradius(128))
	{
		return level.var_111AE;
	}

	return level.var_6AD5;
}

//Function Number: 44
melee_charge_init(param_00)
{
	self.var_3135.var_9928[param_00] = spawnstruct();
	self.var_3135.var_9928[param_00].var_10DFF = gettime();
	self.var_3135.var_B64D = self.var_3135.target;
	var_01 = getdvarint("btSuperSlasherRush") != 0;
	if(var_01)
	{
		if(distance2dsquared(self.origin,self.var_3135.target.origin) > 300)
		{
			lib_0A1B::func_2966(self.var_3135.target,self.var_3135.target.origin);
			self.var_3135.var_9928[param_00].var_29A7 = 1;
			self.var_3135.bcaninterruptfortimer = 0;
		}
	}
}

//Function Number: 45
melee_charge(param_00)
{
	if(isdefined(self.var_1198.var_2BE4))
	{
		var_01 = -28672;
	}
	else
	{
		var_01 = 20736;
	}

	if(isdefined(self.var_3135.target) && isvalidtarget(self.var_3135.target))
	{
		if(!isdefined(self.var_1198.bcommittedtoanim))
		{
			var_02 = self.var_3135.target.origin - self.origin;
			var_03 = length2dsquared(var_02);
			if(var_03 < var_01)
			{
				self.var_3135.var_9928[param_00].bsuccess = 1;
				return level.var_111AE;
			}
		}
	}
	else
	{
		self.var_3135.var_9928[param_00].bsuccess = 1;
		return level.var_111AE;
	}

	var_04 = gettime();
	if(var_04 > self.var_3135.var_9928[param_00].var_10DFF + 200 && !isdefined(self.var_233))
	{
		return level.var_6AD5;
	}

	var_05 = 5000;
	if(var_04 > self.var_3135.var_9928[param_00].var_10DFF + var_05)
	{
		return level.var_6AD5;
	}

	var_06 = 1000;
	if(isdefined(self.var_3135.var_9928[param_00].var_29A7) && var_04 > self.var_3135.var_9928[param_00].var_10DFF + var_06)
	{
		var_07 = anglestoforward(self.angles);
		var_08 = self method_84AC();
		if(navtrace(var_08,var_08 + var_07 * 36))
		{
			self.var_3135.var_9928[param_00].bsuccess = 1;
			return level.var_111AE;
		}
	}

	var_09 = getclosestpointonnavmesh(self.var_3135.target.origin,self);
	self method_8286(var_09);
	self method_8287(24);
	return level.var_E87A;
}

//Function Number: 46
melee_charge_cleanup(param_00)
{
	if(!isdefined(self.var_3135.var_9928[param_00].bsuccess))
	{
		self.var_3135.var_B64D = undefined;
		lib_0A1B::func_2913();
	}

	self.var_3135.bcaninterruptfortimer = 1;
	self.var_3135.var_9928[param_00] = undefined;
}

//Function Number: 47
func_B599(param_00)
{
	self.var_3135.var_9928[param_00] = spawnstruct();
	self.var_3135.var_9928[param_00].var_10DFF = gettime();
	self.var_3135.bcaninterruptfortimer = 0;
	lib_0A1B::func_2965(self.var_3135.var_B64D);
}

//Function Number: 48
func_5902(param_00)
{
	var_01 = 8000;
	if(gettime() > self.var_3135.var_9928[param_00].var_10DFF + var_01)
	{
		return level.var_6AD5;
	}

	if(lib_0A1A::func_232A("meleeanim","end"))
	{
		return level.var_111AE;
	}

	if(isdefined(self.var_3135.var_B64D))
	{
		var_02 = getclosestpointonnavmesh(self.var_3135.var_B64D.origin,self);
		self method_8286(var_02);
		self method_8287(24);
	}
	else
	{
		self method_841F(self.origin);
		self method_8287(36);
	}

	return level.var_E87A;
}

//Function Number: 49
melee_cleanup(param_00)
{
	self.var_3135.var_9928[param_00] = undefined;
	self.var_3135.bcaninterruptfortimer = 1;
	self.var_3135.var_B64D = undefined;
	lib_0A1B::func_2914();
	lib_0A1B::func_2913();
	self.var_3135.allownextaction = gettime() + 1000;
}

//Function Number: 50
shouldthrowsaw(param_00)
{
	if(!isdefined(self.bmayfrisbee) || !self.bmayfrisbee)
	{
		return level.var_6AD5;
	}

	var_01 = gettime();
	if(!isdefined(self.var_3135.target))
	{
		return level.var_6AD5;
	}

	if(!superslasher_isonground())
	{
		return level.var_6AD5;
	}

	if(var_01 < self.var_3135.allownextaction)
	{
		return level.var_6AD5;
	}

	if(var_01 < self.var_3135.allowthrowsawtime)
	{
		return level.var_6AD5;
	}

	if(isdefined(self.var_1198.bcommittedtoanim))
	{
		return level.var_6AD5;
	}

	if(self.var_3135.locationstate == 2)
	{
		if(isanyplayerwithinradius(256))
		{
			return level.var_6AD5;
		}

		var_02 = anglestoforward(self.angles);
		var_03 = self.var_3135.target.origin - self.origin;
		if(vectordot(var_02,var_03) < 0)
		{
			return level.var_6AD5;
		}

		var_04 = getclosestpointonnavmesh(self.var_3135.target.origin,self);
		if(!navisstraightlinereachable(self method_84AC(),var_04))
		{
			return level.var_6AD5;
		}
	}

	return level.var_111AE;
}

//Function Number: 51
throwsaw_init(param_00)
{
	self.var_3135.var_9928[param_00] = gettime();
	self.var_1198.bthrowsawrequested = 1;
	self.var_1198.throwsawtarget = self.var_3135.target;
	self.var_1198.throwsawbackuptargetpos = self.var_3135.target.origin;
	self.var_1198.throwsawchargetime = 1;
}

//Function Number: 52
dothrowsaw(param_00)
{
	var_01 = 6001;
	if(gettime() > self.var_3135.var_9928[param_00] + var_01)
	{
		return level.var_6AD5;
	}

	if(lib_0A1A::func_232A("throwsawanim","end"))
	{
		return level.var_111AE;
	}

	self method_841F(self.origin);
	self method_8287(64);
	return level.var_E87A;
}

//Function Number: 53
throwsaw_setnextallowedtime()
{
	var_00 = gettime();
	if(self.var_3135.locationstate == 0)
	{
		self.var_3135.allowthrowsawtime = var_00 + 9000;
	}
	else
	{
		self.var_3135.allowthrowsawtime = var_00 + 8000;
	}

	self.var_3135.allownextaction = var_00 + 1000;
}

//Function Number: 54
throwsaw_cleanup(param_00)
{
	throwsaw_setnextallowedtime();
	self.var_1198.bthrowsawrequested = undefined;
	self.var_1198.throwsawtarget = undefined;
	self.var_3135.var_9928[param_00] = undefined;
}

//Function Number: 55
shouldthrowsawfan(param_00)
{
	if(!superslasher_isonground())
	{
		return level.var_6AD5;
	}

	if(!isdefined(self.bmaysawfan) || !self.bmaysawfan)
	{
		return level.var_6AD5;
	}

	var_01 = gettime();
	if(var_01 < self.var_3135.allownextaction)
	{
		return level.var_6AD5;
	}

	if(var_01 < self.var_3135.allowthrowsawfantime)
	{
		return level.var_6AD5;
	}

	if(isdefined(self.var_1198.bcommittedtoanim))
	{
		return level.var_6AD5;
	}

	return level.var_111AE;
}

//Function Number: 56
throwsawfan_setnextallowedtime()
{
	var_00 = gettime();
	self.var_3135.allowthrowsawfantime = var_00 + 9500;
	self.var_3135.allownextaction = var_00 + 1000;
}

//Function Number: 57
throwsawfan_init(param_00)
{
	self.var_3135.var_9928[param_00] = gettime();
	self.var_1198.bthrowsawfanrequested = 1;
}

//Function Number: 58
dothrowsawfan(param_00)
{
	var_01 = 5000;
	if(gettime() > self.var_3135.var_9928[param_00] + var_01)
	{
		return level.var_6AD5;
	}

	if(lib_0A1A::func_232A("sawfananim","end"))
	{
		return level.var_111AE;
	}

	self method_841F(self.origin);
	self method_8287(64);
	return level.var_E87A;
}

//Function Number: 59
throwsawfan_cleanup(param_00)
{
	throwsawfan_setnextallowedtime();
	self.var_1198.bthrowsawfanrequested = undefined;
	self.var_3135.var_9928[param_00] = undefined;
}

//Function Number: 60
shouldstomp(param_00)
{
	if(!isdefined(self.bmaystomp) || !self.bmaystomp)
	{
		return level.var_6AD5;
	}

	if(!superslasher_isonground())
	{
		return level.var_6AD5;
	}

	var_01 = gettime();
	if(var_01 < self.var_3135.allownextaction)
	{
		return level.var_6AD5;
	}

	if(var_01 < self.var_3135.allowstomptime)
	{
		return level.var_6AD5;
	}

	if(isdefined(self.var_1198.bcommittedtoanim))
	{
		return level.var_6AD5;
	}

	var_02 = anglestoforward(self.angles);
	var_03 = -1;
	var_04 = undefined;
	foreach(var_06 in level.players)
	{
		if(!isvalidtarget(var_06))
		{
			continue;
		}

		var_07 = var_06.origin - self.origin;
		var_08 = vectordot(var_02,var_07);
		if(var_08 > 768)
		{
			continue;
		}

		if(var_08 < 0)
		{
			continue;
		}

		var_09 = vectordot(var_02,var_07 / var_08);
		if(var_09 > var_03)
		{
			var_03 = var_09;
			var_04 = var_06;
		}
	}

	if(var_03 > 0)
	{
		self.var_1198.bstomprequested = 1;
		self.var_1198.stomptarget = var_04;
		self.var_1198.stompdist = 768;
		return level.var_111AE;
	}

	return level.var_6AD5;
}

//Function Number: 61
stomp_init(param_00)
{
	self.var_3135.var_9928[param_00] = gettime();
}

//Function Number: 62
dostomp(param_00)
{
	var_01 = 15000;
	if(gettime() > self.var_3135.var_9928[param_00] + var_01)
	{
		return level.var_6AD5;
	}

	if(lib_0A1A::func_232A("stompanim","end"))
	{
		return level.var_111AE;
	}

	self method_841F();
	return level.var_E87A;
}

//Function Number: 63
stomp_setnextallowedtime()
{
	var_00 = gettime();
	self.var_3135.allownextaction = var_00 + 1000;
	self.var_3135.allowstomptime = var_00 + 9000;
}

//Function Number: 64
stomp_cleanup(param_00)
{
	self.var_1198.bstomprequested = undefined;
	self.var_1198.stomptarget = undefined;
	self.var_1198.stompdist = undefined;
	stomp_setnextallowedtime();
	self.var_3135.var_9928[param_00] = undefined;
}

//Function Number: 65
shouldshockwave(param_00)
{
	if(!isdefined(self.bmayshockwave) || !self.bmayshockwave)
	{
		return level.var_6AD5;
	}

	if(!superslasher_isonground())
	{
		return level.var_6AD5;
	}

	var_01 = gettime();
	if(var_01 < self.var_3135.allownextaction)
	{
		return level.var_6AD5;
	}

	if(isdefined(self.var_1198.bcommittedtoanim))
	{
		return level.var_6AD5;
	}

	if(isdefined(self.bshockwaverequested))
	{
		return level.var_111AE;
	}

	return level.var_6AD5;
}

//Function Number: 66
shockwave_init(param_00)
{
	self.var_3135.var_9928[param_00] = gettime();
	self.var_1198.bshockwaverequested = 1;
	self.bshockwaverequested = undefined;
}

//Function Number: 67
doshockwave(param_00)
{
	var_01 = 12000;
	if(gettime() > self.var_3135.var_9928[param_00] + var_01)
	{
		return level.var_6AD5;
	}

	if(lib_0A1A::func_232A("shockwaveanim","end"))
	{
		return level.var_111AE;
	}

	return level.var_E87A;
}

//Function Number: 68
shockwave_setnextallowedtime()
{
	var_00 = gettime();
	self.var_3135.allownextaction = var_00 + 1000;
	self.var_3135.allowshockwavetime = var_00 + -6536;
}

//Function Number: 69
shockwave_cleanup(param_00)
{
	shockwave_setnextallowedtime();
	self.var_1198.bshockwaverequested = undefined;
	self.var_3135.var_9928[param_00] = undefined;
}

//Function Number: 70
shoulddowires(param_00)
{
	if(!isdefined(self.bmaywire) || !self.bmaywire)
	{
		return level.var_6AD5;
	}

	if(!superslasher_isonroof())
	{
		return level.var_6AD5;
	}

	if(isdefined(self.var_1198.bwired))
	{
		return level.var_6AD5;
	}

	return level.var_111AE;
}

//Function Number: 71
wires_init(param_00)
{
	self.var_3135.var_9928[param_00] = gettime();
	self.var_1198.bwiresrequested = 1;
}

//Function Number: 72
dowires(param_00)
{
	var_01 = 5000;
	if(gettime() > self.var_3135.var_9928[param_00] + var_01)
	{
		return level.var_6AD5;
	}

	if(lib_0A1A::func_232A("wiresanim","end"))
	{
		return level.var_111AE;
	}

	return level.var_E87A;
}

//Function Number: 73
wires_cleanup(param_00)
{
	self.var_3135.var_9928[param_00] = undefined;
	self.var_1198.bwiresrequested = undefined;
}

//Function Number: 74
wires_stop(param_00)
{
	scripts\asm\superslasher\superslasher_actions::stopwireattack();
	return level.var_111AE;
}

//Function Number: 75
shoulddosharks(param_00)
{
	if(!isdefined(self.bmayshark) || !self.bmayshark)
	{
		return level.var_6AD5;
	}

	if(!superslasher_isonground())
	{
		return level.var_6AD5;
	}

	var_01 = gettime();
	if(var_01 < self.var_3135.allownextaction)
	{
		return level.var_6AD5;
	}

	if(var_01 < self.var_3135.allowsharktime)
	{
		return level.var_6AD5;
	}

	if(isdefined(self.var_1198.bcommittedtoanim))
	{
		return level.var_6AD5;
	}

	return level.var_111AE;
}

//Function Number: 76
sharks_init(param_00)
{
	self.var_3135.var_9928[param_00] = gettime();
	self.var_1198.bsharksrequested = 1;
}

//Function Number: 77
dosharks(param_00)
{
	var_01 = 15000;
	if(gettime() > self.var_3135.var_9928[param_00] + var_01)
	{
		return level.var_6AD5;
	}

	if(lib_0A1A::func_232A("sharksanim","end"))
	{
		return level.var_111AE;
	}

	self method_841F();
	return level.var_E87A;
}

//Function Number: 78
sharks_setnextallowedtime()
{
	var_00 = gettime();
	self.var_3135.allownextaction = var_00 + 1000;
	self.var_3135.allowsharktime = var_00 + 29000;
}

//Function Number: 79
sharks_cleanup(param_00)
{
	sharks_setnextallowedtime();
	self.var_3135.var_9928[param_00] = undefined;
	self.var_1198.bsharksrequested = undefined;
}

//Function Number: 80
shouldjumpmove(param_00)
{
	if(!isdefined(self.bmayjumpattack) || !self.bmayjumpattack)
	{
		return level.var_6AD5;
	}

	if(!superslasher_isonground())
	{
		return level.var_6AD5;
	}

	var_01 = gettime();
	if(var_01 < self.var_3135.allownextaction)
	{
		return level.var_6AD5;
	}

	if(var_01 < self.var_3135.allowgroundjumptime)
	{
		return level.var_6AD5;
	}

	if(isdefined(self.var_1198.bcommittedtoanim))
	{
		return level.var_6AD5;
	}

	var_02 = 147456;
	if(isdefined(self.var_3135.target))
	{
		var_03 = getclosestpointonnavmesh(self.var_3135.target.origin,self);
		if(distance2dsquared(self.origin,var_03) >= var_02)
		{
			var_04 = self method_84AC();
			if(navisstraightlinereachable(var_04,var_03,self))
			{
				return level.var_111AE;
			}
		}
	}

	return level.var_6AD5;
}

//Function Number: 81
jumpmove_init(param_00)
{
	self.var_3135.var_9928[param_00] = gettime();
	self.var_1198.bjumpmoverequested = 1;
	self.var_1198.jumptargetpos = getclosestpointonnavmesh(self.var_3135.target.origin,self);
	self method_8286(self.var_1198.jumptargetpos);
}

//Function Number: 82
dojumpmove(param_00)
{
	var_01 = 4000;
	if(gettime() > self.var_3135.var_9928[param_00] + var_01)
	{
		return level.var_6AD5;
	}

	if(lib_0A1A::func_232A("jumpmoveanim","end"))
	{
		return level.var_111AE;
	}

	return level.var_E87A;
}

//Function Number: 83
jumpmove_setnextallowedtime()
{
	self.var_3135.allowgroundjumptime = gettime() + 7000;
}

//Function Number: 84
jumpmove_cleanup(param_00)
{
	jumpmove_setnextallowedtime();
	self.var_1198.bjumpmoverequested = undefined;
	self.var_3135.var_9928[param_00] = undefined;
}

//Function Number: 85
move_init(param_00)
{
	self.var_3135.var_9928[param_00] = gettime();
}

//Function Number: 86
func_BBF7(param_00)
{
	var_01 = gettime();
	if(var_01 >= self.var_3135.var_9928[param_00])
	{
		if(isdefined(self.var_3135.target) && isvalidtarget(self.var_3135.target))
		{
			var_02 = 5000;
			var_03 = getclosestpointonnavmesh(self.var_3135.target.origin,self);
			self method_8286(var_03);
			self method_8287(36);
			self.var_3135.var_9928[param_00] = var_01 + var_02;
		}
	}

	return level.var_E87A;
}

//Function Number: 87
move_cleanup(param_00)
{
	self.var_3135.var_9928[param_00] = undefined;
}

//Function Number: 88
isanyplayerwithinradius(param_00)
{
	var_01 = param_00 * param_00;
	foreach(var_03 in level.players)
	{
		if(isvalidtarget(var_03))
		{
			if(distance2dsquared(self.origin,var_03.origin) < var_01)
			{
				return 1;
			}
		}
	}

	return 0;
}

//Function Number: 89
dotrophysystem()
{
	self endon("killshield");
	self endon("death");
	var_00 = 3;
	self.shields = [];
	for(var_01 = 0;var_01 < var_00;var_01++)
	{
		self.shields[var_01] = setupshield(var_01,var_00);
		wait(0.05);
	}

	for(;;)
	{
		for(var_01 = 0;var_01 < var_00;var_01++)
		{
			updateshield(self.shields[var_01]);
		}

		self.var_A964 = [];
		wait(0.05);
	}
}

//Function Number: 90
setupshield(param_00,param_01)
{
	var_02 = 96;
	var_03 = 120;
	var_04 = -90;
	var_05 = angleclamp180(param_00 * 360 / param_01);
	var_06 = (var_02,0,var_03);
	var_07 = spawn("script_model",self.origin + rotatevector(var_06,(0,var_05,0)));
	var_07 setmodel("superslasher_trophy_system");
	var_07.angles = (0,self.angles[1] + var_04,0);
	var_07.halfrange = 180 / param_01;
	var_07.midrange = var_05;
	var_07.var_C364 = var_06;
	var_07.var_A96A = 0;
	var_07.beffect = 0;
	var_07.effectontime = 0;
	var_07.var_1E81 = var_04;
	var_07.curangle = var_05;
	var_07.sine = 0;
	var_07.targetangle = var_05;
	return var_07;
}

//Function Number: 91
updateshield(param_00)
{
	var_01 = 4;
	var_02 = gettime();
	var_03 = 1000;
	var_04 = 0;
	if(param_00.beffect && var_02 - param_00.effectontime > var_03)
	{
		param_00 setscriptablepartstate("shield","off");
		param_00.beffect = 0;
		var_04 = 1;
	}

	if(self.var_A964.size > 0)
	{
		foreach(var_06 in self.var_A964)
		{
			var_07 = vectortoyaw(var_06);
			if(abs(angleclamp180(var_07 - param_00.midrange)) < param_00.halfrange)
			{
				param_00.targetangle = var_07;
				param_00.var_A96A = self.var_A96A;
				if(!param_00.beffect && !var_04)
				{
					param_00 setscriptablepartstate("shield","impact");
					param_00.effectontime = var_02;
					param_00.beffect = 1;
				}

				break;
			}
		}
	}

	var_09 = 3000;
	if(var_02 - param_00.var_A96A > var_09)
	{
		param_00.targetangle = param_00.midrange;
	}

	var_0A = angleclamp180(param_00.targetangle - param_00.curangle);
	var_0A = clamp(var_0A,-1 * var_01,var_01);
	param_00.curangle = angleclamp180(param_00.curangle + var_0A);
	var_0B = self.origin + rotatevector(param_00.var_C364,(0,param_00.curangle,0));
	var_0C = var_0B + (0,0,sin(param_00.sine) * 12);
	param_00.sine = param_00.sine + 3 % 360;
	param_00.origin = var_0C;
	param_00.angles = (0,param_00.curangle + param_00.var_1E81,0);
}

//Function Number: 92
shieldcleanup()
{
	if(isdefined(self.shields))
	{
		self notify("killshield");
		foreach(var_01 in self.shields)
		{
			var_01 delete();
		}

		self.shields = undefined;
	}
}