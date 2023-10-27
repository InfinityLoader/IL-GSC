/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\melee.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 61
 * Decompile Time: 1066 ms
 * Timestamp: 10/27/2023 1:24:07 AM
*******************************************************************/

//Function Number: 1
func_4509()
{
	var_00 = [];
	var_00["standard"] = %melee_1;
	var_00["standard_stand_to_melee"] = %stand_2_melee_1;
	var_00["standard_run_to_melee"] = %run_2_melee_charge;
	var_00["aivai_exposed_attackerwins_attack"] = %melee_f_awin_attack;
	var_00["aivai_exposed_attackerwins_defend"] = %melee_f_awin_defend;
	var_00["aivai_exposed_attackerwins_defend_survive"] = %melee_f_awin_defend_survive;
	var_00["aivai_exposed_defenderwins_attack"] = %melee_f_dwin_attack;
	var_00["aivai_exposed_defenderwins_defend"] = %melee_f_dwin_defend;
	var_00["aivai_wrestle_attackerwins_attack"] = %bog_melee_r_attack;
	var_00["aivai_wrestle_attackerwins_defend"] = %bog_melee_r_defend;
	var_00["aivai_wrestle_attackerwins_defend_survive"] = %bog_melee_r_backdeath2;
	var_00["aivai_behind_attackerwins_attack"] = %melee_sync_attack;
	var_00["aivai_behind_attackerwins_defend"] = %melee_sync_defend;
	var_00["aivai_coverleft_attackerwins_attack"] = %cornersdl_melee_wina_attacker;
	var_00["aivai_coverleft_attackerwins_defend"] = %cornersdl_melee_wina_defender;
	var_00["aivai_coverleft_attackerwins_defend_survive"] = %cornersdl_melee_wina_defender_survive;
	var_00["aivai_coverleft_defenderwins_attack"] = %cornersdl_melee_wind_attacker;
	var_00["aivai_coverleft_defenderwins_attack_survive"] = %cornersdl_melee_wind_attacker_survive;
	var_00["aivai_coverleft_defenderwins_defend"] = %cornersdl_melee_wind_defender;
	var_00["aivai_coverright_attackerwins_attack"] = %cornersdr_melee_wina_attacker;
	var_00["aivai_coverright_attackerwins_defend"] = %cornersdr_melee_wina_defender;
	var_00["aivai_coverright_defenderwins_attack"] = %cornersdr_melee_wind_attacker;
	var_00["aivai_coverright_defenderwins_defend"] = %cornersdr_melee_wind_defender;
	level.archetypes["soldier"]["melee"] = var_00;
}

//Function Number: 2
func_516B()
{
	precachemodel("weapon_parabolic_knife");
	level._effect["melee_knife_ai"] = loadfx("fx/impacts/flesh_hit_knife");
}

//Function Number: 3
melee_stealthcheck()
{
	if(!isdefined(self._stealth))
	{
		return 0;
	}

	if(isdefined(self.ent_flag) && isdefined(self.ent_flag["_stealth_enabled"]) && self.ent_flag["_stealth_enabled"])
	{
		if(isdefined(self.ent_flag["_stealth_attack"]) && !self.ent_flag["_stealth_attack"])
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 4
func_5192()
{
	if(!isdefined(self.enemy))
	{
		return 0;
	}

	if(isdefined(self.var_29AF))
	{
		return 0;
	}

	if(melee_stealthcheck())
	{
		return 0;
	}

	if(!func_513B(self.enemy))
	{
		return 0;
	}

	melee_resetaction();
	if(!func_514D())
	{
		func_517D(self.enemy);
		return 0;
	}

	self animcustom(::func_5174,::melee_endscript);
}

//Function Number: 5
melee_resetaction()
{
	self.var_5138.target = self.enemy;
	self.var_5138.initiated = 0;
	self.var_5138.var_4660 = 0;
}

//Function Number: 6
func_514D()
{
	if(!func_516C())
	{
		return 0;
	}

	self.var_5138.initiated = 1;
	if(func_513D())
	{
		self.var_5138.func = ::func_5148;
		return 1;
	}

	if(func_5182())
	{
		if(isdefined(self.var_78EF))
		{
			self.var_5138.func = self.var_78EF;
		}
		else
		{
			self.var_5138.func = ::func_5185;
		}

		return 1;
	}

	self.var_5138.func = undefined;
	self.nextmeleechecktime = gettime() + 150;
	self.nextmeleechecktarget = self.var_5138.target;
	return 0;
}

//Function Number: 7
func_5196()
{
	var_00 = 1;
	var_01 = distance2d(self.var_5138.startpos,self.var_5138.target.origin);
	if(var_01 < 32)
	{
		var_02 = vectornormalize((self.var_5138.startpos[0] - self.var_5138.target.origin[0],self.var_5138.startpos[1] - self.var_5138.target.origin[1],0));
		self.var_5138.startpos = self.var_5138.startpos + var_02 * 32 - var_01;
		var_00 = 0;
	}

	var_03 = self getdroptofloorposition(self.var_5138.startpos);
	if(!isdefined(var_03))
	{
		return 0;
	}

	if(abs(self.var_5138.startpos[2] - var_03[2]) > 51.2)
	{
		return 0;
	}

	if(abs(self.origin[2] - var_03[2]) > 51.2)
	{
		return 0;
	}

	self.var_5138.startpos = var_03;
	if(!self maymovetopoint(self.var_5138.startpos,1,var_00))
	{
		return 0;
	}

	if(isdefined(self.var_5138.var_7AF9))
	{
		var_04 = self.var_5138.startpos - self.var_5138.target.origin;
		var_05 = anglestoforward(self.var_5138.var_7AF9);
		var_06 = vectordot(var_05,var_04);
		var_07 = self.var_5138.startpos - var_05 * var_06;
		var_08 = self.var_5138.target.origin - var_07;
		var_09 = distance2d(self.var_5138.target.origin,var_07);
		if(var_09 < 32)
		{
			var_07 = var_07 - var_08 * 32 - var_09 / 32;
		}
	}
	else
	{
		var_02 = vectornormalize((self.var_5138.startpos[0] - self.var_5138.target.origin[0],self.var_5138.startpos[1] - self.var_5138.target.origin[1],0));
		var_07 = self.var_5138.target.origin + var_02 * 32;
	}

	if(!self maymovefrompointtopoint(self.var_5138.startpos,var_07,1,0))
	{
		return 0;
	}

	if(!self maymovefrompointtopoint(var_07,self.var_5138.target.origin,1,1))
	{
		return 0;
	}

	return 1;
}

//Function Number: 8
func_516C()
{
	if(!isdefined(self.var_5138.target))
	{
		return 0;
	}

	var_00 = self.var_5138.target;
	if(isdefined(var_00.var_29AF))
	{
		return 0;
	}

	var_01 = distancesquared(self.origin,var_00.origin);
	if(isdefined(self.var_519C))
	{
		var_02 = self.var_519C;
	}
	else if(isplayer(var_01))
	{
		var_02 = -25536;
	}
	else
	{
		var_02 = 25600;
	}

	if(!self.var_5138.initiated && var_01 > var_02)
	{
		return 0;
	}

	if(!isalive(self))
	{
		return 0;
	}

	if(isdefined(self.a.nofirstframemelee) && self.a.var_6D18 >= gettime() + 50)
	{
		return 0;
	}

	if(isdefined(self.nextmeleechecktime) && isdefined(self.nextmeleechecktarget) && gettime() < self.nextmeleechecktime && self.nextmeleechecktarget == var_00)
	{
		return 0;
	}

	if(isdefined(self.a.onback) || self.a.var_60B1 == "prone")
	{
		return 0;
	}

	if(animscripts/utility::func_87FE())
	{
		return 0;
	}

	if(isdefined(self.grenade) && self.frontshieldanglecos == 1)
	{
		return 0;
	}

	if(!isalive(var_00))
	{
		return 0;
	}

	if(isdefined(var_00.var_29A1) || isdefined(var_00.ignoreme) && var_00.ignoreme)
	{
		return 0;
	}

	if(!isai(var_00) && !isplayer(var_00))
	{
		return 0;
	}

	if(isai(var_00))
	{
		if(var_00 isinscriptedstate())
		{
			return 0;
		}

		if(var_00 maps\_utility::doinglongdeath() || var_00.delayeddeath)
		{
			return 0;
		}
	}

	if(isplayer(var_00))
	{
		var_03 = var_00 getstance();
	}
	else
	{
		var_03 = var_01.a.var_60B1;
	}

	if(var_03 != "stand" && var_03 != "crouch")
	{
		return 0;
	}

	if(isdefined(self.magic_bullet_shield) && isdefined(var_00.magic_bullet_shield))
	{
		return 0;
	}

	if(isdefined(var_00.grenade))
	{
		return 0;
	}

	if(self.var_5138.var_4660)
	{
		var_04 = 110;
	}
	else
	{
		var_04 = 60;
	}

	var_05 = angleclamp180(self.angles[1] - animscripts/utility::func_3C87(var_00.origin));
	if(abs(var_05) > var_04)
	{
		return 0;
	}

	if(var_01 <= 4096)
	{
		return 1;
	}

	if(self.var_5138.var_4660)
	{
		return 0;
	}

	if(isdefined(self.var_55F0) && isdefined(self.var_55EF) && gettime() < self.var_55F0 && self.var_55EF == var_00)
	{
		return 0;
	}

	return 1;
}

//Function Number: 9
func_5189()
{
	self.var_5138.var_6022 = 1;
	self.a.var_5486 = "run";
}

//Function Number: 10
func_518B()
{
	self clearanim(%body,0.2);
	self.var_5138.var_6022 = undefined;
	self.a.var_5486 = "stop";
	self orientmode("face default");
}

//Function Number: 11
func_5174()
{
	self endon("killanimscript");
	self endon("end_melee");
	for(;;)
	{
		var_00 = self.var_5138.func;
		[[ self.var_5138.func ]]();
		if(!isdefined(self.var_5138.func) || var_00 == self.var_5138.func)
		{
			break;
		}
	}
}

//Function Number: 12
func_5183(param_00)
{
	if(!isdefined(param_00))
	{
	}

	self.var_55F4 = gettime() + 2500;
	self.var_55F3 = param_00;
}

//Function Number: 13
melee_standard_checktimeconstraints()
{
	var_00 = distancesquared(self.var_5138.target.origin,self.origin);
	if(var_00 > 4096 && isdefined(self.var_55F4) && isdefined(self.var_55F3) && gettime() < self.var_55F4 && self.var_55F3 == self.var_5138.target)
	{
		return 0;
	}

	return 1;
}

//Function Number: 14
func_5182()
{
	if(isdefined(self.var_5138.target.magic_bullet_shield))
	{
		return 0;
	}

	if(!melee_standard_checktimeconstraints())
	{
		return 0;
	}

	if(isdefined(self.var_5138.target.var_78F0))
	{
		return 0;
	}

	return func_5188();
}

//Function Number: 15
melee_standard_resetgiveuptime()
{
	if(isdefined(self.var_519C))
	{
		var_00 = self.var_519C;
	}
	else if(isplayer(self.var_5138.target))
	{
		var_00 = -25536;
	}
	else
	{
		var_00 = 25600;
	}

	if(distancesquared(self.origin,self.var_5138.target.origin) > var_00)
	{
		self.var_5138.giveuptime = gettime() + 3000;
	}

	self.var_5138.giveuptime = gettime() + 1000;
}

//Function Number: 16
func_5185()
{
	self animmode("zonly_physics");
	if(isdefined(self.var_5138.target))
	{
		melee_standard_resetgiveuptime();
	}

	while(isdefined(self.var_5138.target))
	{
		if(!func_5184())
		{
			self.var_55F0 = gettime() + 1500;
			self.var_55EF = self.var_5138.target;
			break;
		}

		if(!isdefined(self.var_5138.target))
		{
			break;
		}

		animscripts/battlechatter_ai::evaluatemeleeevent();
		self orientmode("face point",self.var_5138.target.origin);
		var_00 = animscripts/utility::lookupanim("melee","standard");
		self setflaggedanimknoballrestart("meleeanim",var_00,%body,1,0.2,1);
		melee_playfacialanim(var_00);
		self.var_5138.var_4660 = 1;
		if(!func_5186())
		{
			func_5183(self.var_5138.target);
			break;
		}
	}

	self animmode("none");
}

//Function Number: 17
func_5186()
{
	for(;;)
	{
		self waittill("meleeanim",var_00);
		if(var_00 == "end")
		{
			return 1;
		}

		if(var_00 == "stop")
		{
			if(!func_514D())
			{
				return 0;
			}

			if(self.var_5138.func != ::func_5185)
			{
				return 1;
			}
		}

		if(var_00 == "fire")
		{
			if(isdefined(self.var_5138.target))
			{
				var_01 = self.var_5138.target.health;
				self melee();
				if(isdefined(self.var_5138.target) && self.var_5138.target.health < var_01)
				{
					melee_standard_resetgiveuptime();
				}
			}
		}
	}
}

//Function Number: 18
func_5188()
{
	if(!isdefined(self.var_5138.target))
	{
		return 0;
	}

	if(!func_516C())
	{
		return 0;
	}

	var_00 = vectornormalize(self.var_5138.target.origin - self.origin);
	self.var_5138.startpos = self.var_5138.target.origin - 40 * var_00;
	return func_5196();
}

//Function Number: 19
func_5184()
{
	if(!func_5188())
	{
		return 0;
	}

	var_00 = common_scripts\utility::func_27FE(self.origin,self.var_5138.target.origin);
	if(var_00 <= 4096)
	{
		var_01 = animscripts/utility::lookupanim("melee","standard_stand_to_melee");
		self setflaggedanimknoball("readyanim",var_01,%body,1,0.3,1);
		melee_playfacialanim(var_01);
		animscripts/shared::func_2986("readyanim");
		return 1;
	}

	func_517A();
	var_02 = self.var_5138.target.origin;
	var_03 = 0.1;
	var_04 = animscripts/utility::lookupanim("melee","standard_run_to_melee");
	var_05 = length(getmovedelta(var_04,0,1));
	var_06 = 32;
	var_07 = 48 + var_06 + var_05;
	var_08 = var_07 * var_07;
	var_09 = 64 + var_06;
	var_0A = var_09 * var_09;
	var_0B = getanimlength(var_04) * 1000;
	var_0C = var_0B - 100;
	var_0D = var_0B - 200;
	var_0E = 0;
	var_0F = undefined;
	var_10 = animscripts/utility::lookupanim("run","straight");
	if(isplayer(self.var_5138.target) && self.var_5138.target == self.enemy)
	{
		self orientmode("face enemy");
	}
	else
	{
		self orientmode("face point",self.var_5138.target.origin);
	}

	self setflaggedanimknoball("chargeanim",var_10,%body,1,0.3,1);
	melee_playfacialanim(var_10);
	var_11 = 0;
	for(;;)
	{
		var_12 = gettime();
		var_13 = isdefined(var_0F) && var_0F <= var_08;
		if(!var_11)
		{
			if(var_13)
			{
				func_5189();
				self setflaggedanimknoballrestart("chargeanim",var_04,%body,1,0.2,1);
				melee_playfacialanim(var_04);
				var_0E = var_12;
				var_11 = 1;
			}
		}
		else
		{
			var_14 = var_01 <= var_08;
			if(var_12 - var_0E >= var_0C || !var_13 && !var_14)
			{
				func_5189();
				self setflaggedanimknoball("chargeanim",var_10,%body,1,0.3,1);
				melee_playfacialanim(var_10);
				var_11 = 0;
			}
		}

		animscripts/notetracks::donotetracksfortime(var_03,"chargeanim");
		if(!func_5188())
		{
			func_518B();
			return 0;
		}

		var_01 = common_scripts\utility::func_27FE(self.origin,self.var_5138.target.origin);
		var_15 = self.var_5138.target.origin - var_02 * 1 / gettime() - var_12;
		var_02 = self.var_5138.target.origin;
		var_16 = self.var_5138.target.origin + var_15 * var_0D;
		var_0F = common_scripts\utility::func_27FE(self.origin,var_16);
		if(var_11 && var_01 <= var_0A && gettime() - var_0E >= var_0C || !isplayer(self.var_5138.target))
		{
			break;
		}

		if(!var_11 && gettime() >= self.var_5138.giveuptime)
		{
			func_518B();
			return 0;
		}
	}

	func_518B();
	return 1;
}

//Function Number: 20
func_517A()
{
	if(!isdefined(self.a.var_55EE))
	{
		self.a.var_55EE = 0;
	}

	if((isdefined(self.enemy) && isplayer(self.enemy)) || randomint(3) == 0)
	{
		if(gettime() > self.a.var_55EE)
		{
			animscripts/face::func_6AB2("meleecharge");
			self.a.var_55EE = gettime() + 8000;
		}
	}
}

//Function Number: 21
melee_aivsai_exposed_chooseanimationandposition_flip(param_00)
{
	var_01 = 90;
	if(self.var_5138.var_4660)
	{
		var_01 = var_01 + 50;
	}

	if(abs(param_00) < var_01)
	{
		return 0;
	}

	var_02 = self.var_5138.target;
	func_5157();
	if(self.var_5138.winner)
	{
		self.var_5138.animname = animscripts/utility::lookupanim("melee","aivai_exposed_attackerwins_attack");
		var_02.var_5138.animname = animscripts/utility::lookupanim("melee","aivai_exposed_attackerwins_defend");
		var_02.var_5138.var_7D7B = animscripts/utility::lookupanim("melee","aivai_exposed_attackerwins_defend_survive");
	}
	else
	{
		self.var_5138.animname = animscripts/utility::lookupanim("melee","aivai_exposed_defenderwins_attack");
		var_02.var_5138.animname = animscripts/utility::lookupanim("melee","aivai_exposed_defenderwins_defend");
	}

	return 1;
}

//Function Number: 22
func_5143(param_00)
{
	var_01 = 100;
	if(self.var_5138.var_4660)
	{
		var_01 = var_01 + 50;
	}

	if(abs(param_00) < var_01)
	{
		return 0;
	}

	var_02 = self.var_5138.target;
	if(isdefined(var_02.magic_bullet_shield))
	{
		return 0;
	}

	if(isdefined(var_02.var_5199))
	{
		return 0;
	}

	self.var_5138.winner = 1;
	self.var_5138.animname = animscripts/utility::lookupanim("melee","aivai_wrestle_attackerwins_attack");
	var_02.var_5138.animname = animscripts/utility::lookupanim("melee","aivai_wrestle_attackerwins_defend");
	var_02.var_5138.var_7D7B = animscripts/utility::lookupanim("melee","aivai_wrestle_attackerwins_defend_survive");
	return 1;
}

//Function Number: 23
melee_aivsai_exposed_chooseanimationandposition_behind(param_00)
{
	if(-90 > param_00 || param_00 > 0)
	{
		return 0;
	}

	var_01 = self.var_5138.target;
	if(isdefined(var_01.magic_bullet_shield))
	{
		return 0;
	}

	if(isdefined(var_01.var_5199))
	{
		return 0;
	}

	self.var_5138.winner = 1;
	self.var_5138.animname = animscripts/utility::lookupanim("melee","aivai_behind_attackerwins_attack");
	var_01.var_5138.animname = animscripts/utility::lookupanim("melee","aivai_behind_attackerwins_defend");
	return 1;
}

//Function Number: 24
func_5141()
{
	if(isdefined(self.meleeforcedexposedflip))
	{
		var_00[0] = ::melee_aivsai_exposed_chooseanimationandposition_flip;
	}
	else if(isdefined(self.meleeforcedexposedwrestle))
	{
		var_00[0] = ::func_5143;
	}
	else
	{
		var_01 = randomint(2);
		var_02 = 1 - var_01;
		var_03 = 2;
		var_00[var_01] = ::melee_aivsai_exposed_chooseanimationandposition_flip;
		var_00[var_02] = ::func_5143;
		var_00[var_03] = ::melee_aivsai_exposed_chooseanimationandposition_behind;
	}

	return var_00;
}

//Function Number: 25
func_513F()
{
	var_00 = self.var_5138.target;
	var_01 = vectortoangles(var_00.origin - self.origin);
	var_02 = angleclamp180(var_00.angles[1] - var_01[1]);
	var_03 = func_5141();
	for(var_04 = 0;var_04 < var_03.size;var_04++)
	{
		if([[ var_03[var_04] ]](var_02))
		{
			self.var_5138.startangles = (0,var_01[1],0);
			self.var_5138.startpos = getstartorigin(var_00.origin,var_00.angles,self.var_5138.animname);
			if(func_5196())
			{
				return 1;
			}
		}
	}

	return 0;
}

//Function Number: 26
func_5157()
{
	var_00 = self.var_5138.target;
	if(isdefined(self.var_5199))
	{
		self.var_5138.winner = 1;
	}
	else if(isdefined(var_00.var_5199))
	{
		self.var_5138.winner = 0;
	}

	if(isdefined(self.magic_bullet_shield))
	{
		self.var_5138.winner = 1;
	}

	if(isdefined(var_00.magic_bullet_shield))
	{
		self.var_5138.winner = 0;
	}

	self.var_5138.winner = common_scripts\utility::func_1DE9();
}

//Function Number: 27
func_514B()
{
	var_00 = self.var_5138.target;
	func_5157();
	var_01 = var_00.var_1FCA.type;
	if(var_01 == "Cover Multi")
	{
		var_01 = animscripts/utility::getcovermultipretendtype(var_00.var_1FCA);
	}

	if(var_01 == "Cover Left")
	{
		if(self.var_5138.winner)
		{
			self.var_5138.animname = animscripts/utility::lookupanim("melee","aivai_coverleft_attackerwins_attack");
			var_00.var_5138.animname = animscripts/utility::lookupanim("melee","aivai_coverleft_attackerwins_defend");
			var_00.var_5138.var_7D7B = animscripts/utility::lookupanim("melee","aivai_coverleft_attackerwins_defend_survive");
		}
		else
		{
			self.var_5138.animname = animscripts/utility::lookupanim("melee","aivai_coverleft_defenderwins_attack");
			self.var_5138.var_7D7B = animscripts/utility::lookupanim("melee","aivai_coverleft_defenderwins_attack_survive");
			var_00.var_5138.animname = animscripts/utility::lookupanim("melee","aivai_coverleft_defenderwins_defend");
		}
	}
	else if(self.var_5138.winner)
	{
		self.var_5138.animname = animscripts/utility::lookupanim("melee","aivai_coverright_attackerwins_attack");
		var_00.var_5138.animname = animscripts/utility::lookupanim("melee","aivai_coverright_attackerwins_defend");
	}
	else
	{
		self.var_5138.animname = animscripts/utility::lookupanim("melee","aivai_coverright_defenderwins_attack");
		var_00.var_5138.animname = animscripts/utility::lookupanim("melee","aivai_coverright_defenderwins_defend");
	}

	self.var_5138.startpos = getstartorigin(var_00.var_1FCA.origin,var_00.var_1FCA.angles,self.var_5138.animname);
	self.var_5138.startangles = (var_00.var_1FCA.angles[0],angleclamp180(var_00.var_1FCA.angles[1] + 180),var_00.var_1FCA.angles[2]);
	var_00.var_5138.faceyaw = animscripts/utility::getnodeforwardyaw(var_00.var_1FCA);
	self.var_5138.var_7AF9 = var_00.var_1FCA.angles;
	if(!func_5196())
	{
		self.var_5138.var_7AF9 = undefined;
		return 0;
	}

	return 1;
}

//Function Number: 28
func_514A()
{
	var_00 = self.var_5138.target.var_1FCA;
	if(!isdefined(var_00))
	{
		return 0;
	}

	if(distancesquared(var_00.origin,self.var_5138.target.origin) > 16 && isdefined(self.var_5138.target.a.covermode) && self.var_5138.target.a.covermode != "hide" && self.var_5138.target.a.covermode != "lean")
	{
		return 0;
	}

	var_01 = vectortoangles(self.origin - var_00.origin);
	var_02 = angleclamp180(var_00.angles[1] - var_01[1]);
	var_03 = var_00.type;
	if(var_03 == "Cover Multi")
	{
		var_03 = animscripts/utility::getcovermultipretendtype(var_00);
	}

	if(var_03 == "Cover Left")
	{
		if(var_02 >= -50 && var_02 <= 0)
		{
			return 1;
		}
	}
	else if(var_03 == "Cover Right")
	{
		if(var_02 >= 0 && var_02 <= 50)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 29
func_513D()
{
	var_00 = self.var_5138.target;
	if(!isai(var_00) || var_00.type != "human")
	{
		return 0;
	}

	if(self.stairsstate != "none" || var_00.stairsstate != "none")
	{
		return 0;
	}

	if(isdefined(self.var_5199) && isdefined(var_00.var_5199))
	{
		return 0;
	}

	if(isdefined(self.magic_bullet_shield) && isdefined(var_00.magic_bullet_shield))
	{
		return 0;
	}

	if((isdefined(self.var_5199) && isdefined(var_00.magic_bullet_shield)) || isdefined(var_00.var_5199) && isdefined(self.magic_bullet_shield))
	{
		return 0;
	}

	if(isdefined(self.var_78F0))
	{
		if(![[ self.var_78F0 ]]())
		{
			return 0;
		}

		self.var_5138.precisepositioning = 1;
	}
	else if(isdefined(var_00.var_78F0))
	{
		return 0;
	}
	else if(func_514A() && func_514B())
	{
		self.var_5138.precisepositioning = 1;
	}
	else
	{
		if(!func_513F())
		{
			return 0;
		}

		self.var_5138.precisepositioning = 0;
	}

	if(!isdefined(var_00.var_5138.faceyaw))
	{
		var_00.var_5138.faceyaw = var_00.angles[1];
	}

	self.var_5138.var_7AEE = self.var_5138.startpos - var_00.origin;
	return 1;
}

//Function Number: 30
func_5149(param_00)
{
	self.var_5138.syncnotetrackent = param_00;
	param_00.var_5138.syncnotetrackent = undefined;
}

//Function Number: 31
melee_aivsai_targetlink(param_00)
{
	if(!isdefined(param_00.var_5138))
	{
	}

	func_517A();
	if(!isalive(param_00))
	{
	}

	self.syncedmeleetarget = param_00;
	param_00.syncedmeleetarget = self;
	self.var_5138.linked = 1;
	param_00.var_5138.linked = 1;
	self linktoblendtotag(param_00,"tag_sync",1,1);
}

//Function Number: 32
func_5148()
{
	if(!func_5144())
	{
		self.var_55F0 = gettime() + 1500;
		self.var_55EF = self.var_5138.target;
	}

	var_00 = self.var_5138.target;
	func_5149(var_00);
	if(self.var_5138.winner)
	{
		self.var_5138.death = undefined;
		var_00.var_5138.death = 1;
	}
	else
	{
		var_00.var_5138.death = undefined;
		self.var_5138.death = 1;
	}

	self.var_5138.var_5B0C = var_00;
	var_00.var_5138.var_5B0C = self;
	if(animscripts/utility::func_87FE())
	{
		maps\_utility::func_34E3(self.primaryweapon,"primary");
		self.lastweapon = self.primaryweapon;
	}

	if(var_00 animscripts/utility::func_87FE())
	{
		var_00 maps\_utility::func_34E3(var_00.primaryweapon,"primary");
		var_00.lastweapon = var_00.primaryweapon;
	}

	self.var_5138.weapon = self.weapon;
	self.var_5138.var_8DC0 = animscripts/utility::func_3A6D();
	var_00.var_5138.weapon = var_00.weapon;
	var_00.var_5138.var_8DC0 = var_00 animscripts/utility::func_3A6D();
	self.var_5138.var_4660 = 1;
	var_00 animcustom(::func_513E,::melee_endscript);
	var_00 thread func_513C(self);
	self.var_5138.target = undefined;
	func_513E();
}

//Function Number: 33
func_513C(param_00)
{
	self endon("end_melee");
	self endon("melee_aivsai_execute");
	wait(0.1);
	if(isdefined(param_00))
	{
		param_00 notify("end_melee");
	}

	self notify("end_melee");
}

//Function Number: 34
func_5147(param_00,param_01)
{
	if(isdefined(param_01) && param_01 <= gettime())
	{
		return 0;
	}

	if(!func_516C())
	{
		return 0;
	}

	var_02 = self.var_5138.target;
	var_03 = distancesquared(var_02.origin,param_00);
	if(self.var_5138.precisepositioning)
	{
		var_04 = 256;
	}
	else
	{
		var_04 = 1296;
	}

	if(var_03 > var_04)
	{
		return 0;
	}

	self.var_5138.startpos = var_02.origin + self.var_5138.var_7AEE;
	if(!func_5196())
	{
		return 0;
	}

	return 1;
}

//Function Number: 35
func_5146(param_00)
{
	var_01 = distancesquared((self.origin[0],self.origin[1],0),(self.var_5138.startpos[0],self.var_5138.startpos[1],0));
	if(var_01 < 64 && abs(self.var_5138.startpos[2] - self.origin[2]) < 64)
	{
		return 1;
	}

	var_02 = distancesquared((param_00[0],param_00[1],0),(self.var_5138.startpos[0],self.var_5138.startpos[1],0));
	var_03 = distancesquared((self.origin[0],self.origin[1],0),(self.var_5138.target.origin[0],self.var_5138.target.origin[1],0));
	if(var_02 > var_03 && abs(self.var_5138.target.origin[2] - self.origin[2]) < 64)
	{
		return 1;
	}

	return 0;
}

//Function Number: 36
func_5145(param_00)
{
	func_518B();
	if(self.var_5138.precisepositioning)
	{
		self forceteleport(self.var_5138.startpos,self.var_5138.startangles);
		wait(0.05);
	}
	else
	{
		self orientmode("face angle",self.var_5138.startangles[1]);
		wait(0.05);
	}

	return func_5147(param_00);
}

//Function Number: 37
func_5144()
{
	if(!func_516C())
	{
		return 0;
	}

	func_5189();
	self clearanim(%body,0.2);
	self setanimknoball(animscripts/run::func_3BDB(),%body,1,0.2);
	self animmode("zonly_physics");
	self.keepclaimednode = 1;
	var_00 = gettime() + 1500;
	var_01 = self.var_5138.target.origin;
	while(func_5147(var_01,var_00))
	{
		if(func_5146(var_01))
		{
			return func_5145(var_01);
		}

		self orientmode("face point",self.var_5138.startpos);
		wait(0.05);
	}

	func_518B();
	return 0;
}

//Function Number: 38
func_513E()
{
	self endon("killanimscript");
	self endon("end_melee");
	self notify("melee_aivsai_execute");
	self animmode("zonly_physics");
	self.a.var_78D0 = "none";
	self.var_78EB = undefined;
	thread func_515C();
	thread func_5178();
	if(isdefined(self.var_5138.faceyaw))
	{
		self orientmode("face angle",self.var_5138.faceyaw);
	}
	else
	{
		self orientmode("face current");
	}

	self.a.var_60B1 = "stand";
	self clearanim(%body,0.2);
	if(isdefined(self.var_5138.death))
	{
		func_5158();
	}

	self setflaggedanimknoballrestart("meleeAnim",self.var_5138.animname,%body,1,0.2);
	melee_playfacialanim(self.var_5138.animname);
	var_00 = animscripts/shared::func_2986("meleeAnim",::func_5163);
	if(var_00 == "melee_death" && isdefined(self.var_5138.survive))
	{
		melee_droppedweaponrestore();
		self setflaggedanimknoballrestart("meleeAnim",self.var_5138.var_7D7B,%body,1,0.2);
		melee_playfacialanim(self.var_5138.var_7D7B);
		var_00 = animscripts/shared::func_2986("meleeAnim",::func_5163);
	}

	if(isdefined(self.var_5138) && isdefined(self.var_5138.death))
	{
		self kill();
	}

	self.keepclaimednode = 0;
}

//Function Number: 39
func_5158()
{
	self.var_5138.var_8C40 = self.allowpain;
	self.var_5138.var_8C48 = self.flashbangimmunity;
	maps\_utility::disable_pain();
	maps\_utility::setflashbangimmunity(1);
}

//Function Number: 40
func_5175()
{
	return isdefined(self.var_5138.weapon) && self.var_5138.weapon != "none" && self.weapon != self.var_5138.weapon;
}

//Function Number: 41
melee_droppedweaponrestore()
{
	if(self.weapon != "none" && self.lastweapon != "none")
	{
	}

	if(!isdefined(self.var_5138.weapon) || self.var_5138.weapon == "none")
	{
	}

	maps\_utility::func_34E3(self.var_5138.weapon,self.var_5138.var_8DC0);
	if(isdefined(self.var_5138.var_2B59))
	{
		self.var_5138.var_2B59 delete();
		self.var_5138.var_2B59 = undefined;
	}
}

//Function Number: 42
func_515C()
{
	self endon("killanimscript");
	self endon("end_melee");
	self waittill("weapon_dropped",var_00);
	if(isdefined(var_00))
	{
		self.var_5138.var_2B59 = var_00;
	}
}

//Function Number: 43
func_5179()
{
	if(!isdefined(self.var_5138.var_7D7B))
	{
		return 0;
	}

	if(!isdefined(self.var_5138.var_7D7A))
	{
		return 0;
	}

	return 1;
}

//Function Number: 44
func_5178()
{
	self endon("killanimscript");
	self endon("end_melee");
	self waittill("partner_end_melee");
	if(isdefined(self.var_5138.death))
	{
		if(isdefined(self.var_5138.var_DEE) || isdefined(self.var_5138.var_46B9))
		{
			self kill();
		}

		self.var_5138.death = undefined;
		if(func_5179())
		{
			self.var_5138.survive = 1;
		}

		self notify("end_melee");
	}

	if(!isdefined(self.var_5138.var_864F))
	{
		self notify("end_melee");
	}
}

//Function Number: 45
func_5194()
{
	if(!isdefined(self.var_5138.linked))
	{
	}

	if(isdefined(self.syncedmeleetarget))
	{
		self.syncedmeleetarget func_5195();
	}

	func_5195();
}

//Function Number: 46
func_5195()
{
	self unlink();
	self.syncedmeleetarget = undefined;
	if(!isalive(self))
	{
	}

	self.var_5138.linked = undefined;
	self animmode("zonly_physics");
	self orientmode("face angle",self.angles[1]);
}

//Function Number: 47
func_5166()
{
	func_5194();
	self.var_5138.var_864F = 1;
	if(isdefined(self.var_5138.var_5B0C) && isdefined(self.var_5138.var_5B0C.var_5138))
	{
		self.var_5138.var_5B0C.var_5138.var_864F = 1;
	}
}

//Function Number: 48
func_5165()
{
	if(animhasnotetrack(self.var_5138.animname,"melee_death"))
	{
		return 0;
	}

	return isdefined(self.var_5138.death);
}

//Function Number: 49
func_5164(param_00)
{
	if(isdefined(param_00) && param_00)
	{
		self.var_5138.var_46B9 = 1;
	}

	self.var_5138.var_DEE = 1;
}

//Function Number: 50
func_5163(param_00)
{
	if(issubstr(param_00,"ps_"))
	{
		var_01 = getsubstr(param_00,3);
		self playsound(var_01);
	}

	if(var_01 == "sync")
	{
		if(isdefined(self.var_5138.syncnotetrackent))
		{
			melee_aivsai_targetlink(self.var_5138.syncnotetrackent);
			self.var_5138.syncnotetrackent = undefined;
		}
	}

	if(var_01 == "unsync")
	{
		func_5166();
		if(func_5165())
		{
			func_5164();
		}
	}

	if(var_01 == "melee_interact")
	{
		self.var_5138.var_7D7A = 1;
	}

	if(var_01 == "melee_death")
	{
		if(isdefined(self.var_5138.survive))
		{
			return var_01;
		}

		func_5164();
		if(isdefined(self.var_5138.var_DEE))
		{
			return var_01;
		}
	}

	if(var_01 == "attach_knife")
	{
		self attach("weapon_parabolic_knife","TAG_INHAND",1);
		self.var_5138.var_4017 = 1;
	}

	if(var_01 == "detach_knife")
	{
		self detach("weapon_parabolic_knife","TAG_INHAND",1);
		self.var_5138.var_4017 = undefined;
	}

	if(var_01 == "stab")
	{
		self playsound("melee_knife_hit_body");
		playfxontag(level._effect["melee_knife_ai"],self,"TAG_KNIFE_FX");
		if(isdefined(self.var_5138.var_5B0C) && isdefined(self.var_5138.var_5B0C.var_5138))
		{
			self.var_5138.var_5B0C func_5164(1);
		}
	}
}

//Function Number: 51
melee_deathhandler_regular()
{
	self endon("end_melee");
	animscripts/shared::func_2B49();
	return 0;
}

//Function Number: 52
func_5155()
{
	self endon("end_melee");
	animscripts/notetracks::donotetrackswithtimeout("meleeAnim",10);
	animscripts/shared::func_2B49();
	self startragdoll();
	return 1;
}

//Function Number: 53
func_515F()
{
	if(!isalive(self) && isdefined(self.var_5138.death))
	{
		if(isdefined(self.var_5138.var_DEE))
		{
			self.var_237B = ::func_5155;
		}

		self.var_237B = ::melee_deathhandler_regular;
	}
}

//Function Number: 54
melee_endscript_checkpositionandmovement()
{
	if(!isalive(self))
	{
	}

	if(isdefined(self.var_5138.var_6022))
	{
		func_518B();
	}

	var_00 = self getdroptofloorposition();
	if(isdefined(var_00))
	{
		self forceteleport(var_00,self.angles);
	}
}

//Function Number: 55
func_5162()
{
	if(isdefined(self.var_5138.var_4017))
	{
		self detach("weapon_parabolic_knife","TAG_INHAND",1);
	}

	if(isalive(self))
	{
		melee_droppedweaponrestore();
	}
}

//Function Number: 56
func_5161()
{
	if(isdefined(self.var_5138.var_8C40))
	{
		if(self.var_5138.var_8C40)
		{
			maps\_utility::func_2CBF();
		}
		else
		{
			maps\_utility::disable_pain();
		}
	}

	if(isdefined(self.var_5138.var_8C48))
	{
		maps\_utility::setflashbangimmunity(self.var_5138.var_8C48);
	}
}

//Function Number: 57
melee_endscript()
{
	func_5194();
	func_515F();
	melee_endscript_checkpositionandmovement();
	func_5162();
	func_5161();
	if(isdefined(self.var_5138.var_5B0C))
	{
		self.var_5138.var_5B0C notify("partner_end_melee");
	}

	func_517D(self.var_5138.target);
	func_5150();
}

//Function Number: 58
func_513B(param_00)
{
	if(isdefined(self.var_5138))
	{
		return 0;
	}

	if(isdefined(param_00.var_5138))
	{
		return 0;
	}

	self.var_5138 = spawnstruct();
	param_00.var_5138 = spawnstruct();
	return 1;
}

//Function Number: 59
func_517D(param_00)
{
	self.var_5138 = undefined;
	if(isdefined(param_00))
	{
		param_00.var_5138 = undefined;
	}
}

//Function Number: 60
melee_playfacialanim(param_00)
{
	self.facialidx = animscripts/face::func_6004(param_00,"pain",self.facialidx);
}

//Function Number: 61
func_5150()
{
	self.facialidx = undefined;
	self clearanim(%head,0.2);
}