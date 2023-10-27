/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\melee.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 59
 * Decompile Time: 1007 ms
 * Timestamp: 10/27/2023 2:30:30 AM
*******************************************************************/

//Function Number: 1
melee_init()
{
	precachemodel("weapon_parabolic_knife");
	level._effect["melee_knife_ai"] = loadfx("impacts/flesh_hit_knife");
}

//Function Number: 2
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

//Function Number: 3
melee_tryexecuting()
{
	if(!isdefined(self.enemy))
	{
		return 0;
	}

	if(isdefined(self.dontmelee))
	{
		return 0;
	}

	if(melee_stealthcheck())
	{
		return 0;
	}

	if(!melee_acquiremutex(self.enemy))
	{
		return 0;
	}

	melee_resetaction();
	if(!melee_chooseaction())
	{
		melee_releasemutex(self.enemy);
		return 0;
	}

	self animcustom(::melee_mainloop,::melee_endscript);
}

//Function Number: 4
melee_resetaction()
{
	self.melee.target = self.enemy;
	self.melee.initiated = 0;
	self.melee.inprogress = 0;
}

//Function Number: 5
melee_chooseaction()
{
	if(!melee_isvalid())
	{
		return 0;
	}

	self.melee.initiated = 1;
	if(melee_aivsai_chooseaction())
	{
		self.melee.func = ::melee_aivsai_main;
		return 1;
	}

	if(func_0C10())
	{
		if(isdefined(self.specialmelee_standard))
		{
			self.melee.func = self.specialmelee_standard;
		}
		else
		{
			self.melee.func = ::melee_standard_main;
		}

		return 1;
	}

	self.melee.func = undefined;
	self.nextmeleechecktime = gettime() + 150;
	self.var_BFD = self.melee.target;
	return 0;
}

//Function Number: 6
melee_updateandvalidatestartpos()
{
	var_00 = 1;
	var_01 = distance2d(self.melee.startpos,self.melee.target.origin);
	if(var_01 < 32)
	{
		var_02 = vectornormalize((self.melee.startpos[0] - self.melee.target.origin[0],self.melee.startpos[1] - self.melee.target.origin[1],0));
		self.melee.startpos = self.melee.startpos + var_02 * 32 - var_01;
		var_00 = 0;
	}

	var_03 = self getdroptofloorposition(self.melee.startpos);
	if(!isdefined(var_03))
	{
		return 0;
	}

	if(abs(self.melee.startpos[2] - var_03[2]) > 51.2)
	{
		return 0;
	}

	if(abs(self.origin[2] - var_03[2]) > 51.2)
	{
		return 0;
	}

	self.melee.startpos = var_03;
	if(!self maymovetopoint(self.melee.startpos,1,var_00))
	{
		return 0;
	}

	if(isdefined(self.melee.starttotargetcornerangles))
	{
		var_04 = self.melee.startpos - self.melee.target.origin;
		var_05 = anglestoforward(self.melee.starttotargetcornerangles);
		var_06 = vectordot(var_05,var_04);
		var_07 = self.melee.startpos - var_05 * var_06;
		var_08 = self.melee.target.origin - var_07;
		var_09 = distance2d(self.melee.target.origin,var_07);
		if(var_09 < 32)
		{
			var_07 = var_07 - var_08 * 32 - var_09 / 32;
		}
	}
	else
	{
		var_02 = vectornormalize((self.melee.startpos[0] - self.melee.target.origin[0],self.melee.startpos[1] - self.melee.target.origin[1],0));
		var_07 = self.melee.target.origin + var_02 * 32;
	}

	if(!self maymovefrompointtopoint(self.melee.startpos,var_07,1,0))
	{
		return 0;
	}

	if(!self maymovefrompointtopoint(var_07,self.melee.target.origin,1,1))
	{
		return 0;
	}

	return 1;
}

//Function Number: 7
melee_isvalid()
{
	if(!isdefined(self.melee.target))
	{
		return 0;
	}

	var_00 = self.melee.target;
	if(isdefined(var_00.dontmelee))
	{
		return 0;
	}

	var_01 = distancesquared(self.origin,var_00.origin);
	if(isdefined(self.meleechargedistsq))
	{
		var_02 = self.meleechargedistsq;
	}
	else if(isplayer(var_01))
	{
		var_02 = -25536;
	}
	else
	{
		var_02 = 25600;
	}

	if(!self.melee.initiated && var_01 > var_02)
	{
		return 0;
	}

	if(!isalive(self))
	{
		return 0;
	}

	if(isdefined(self.a.nofirstframemelee) && self.a.scriptstarttime >= gettime() + 50)
	{
		return 0;
	}

	if(isdefined(self.nextmeleechecktime) && isdefined(self.var_BFD) && gettime() < self.nextmeleechecktime && self.var_BFD == var_00)
	{
		return 0;
	}

	if(isdefined(self.a.onback) || self.a.var_911 == "prone")
	{
		return 0;
	}

	if(animscripts/utility::usingsidearm())
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

	if(isdefined(var_00.dontattackme) || isdefined(var_00.ignoreme) && var_00.ignoreme)
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
		var_03 = var_01.a.var_911;
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

	if(self.melee.inprogress)
	{
		var_04 = 110;
	}
	else
	{
		var_04 = 60;
	}

	var_05 = angleclamp180(self.angles[1] - animscripts/utility::func_C05(var_00.origin));
	if(abs(var_05) > var_04)
	{
		return 0;
	}

	if(var_01 <= 4096)
	{
		return 1;
	}

	if(self.melee.inprogress)
	{
		return 0;
	}

	if(isdefined(self.nextmeleechargetime) && isdefined(self.nextmeleechargetarget) && gettime() < self.nextmeleechargetime && self.nextmeleechargetarget == var_00)
	{
		return 0;
	}

	return 1;
}

//Function Number: 8
melee_startmovement()
{
	self.melee.playingmovementanim = 1;
	self.a.movement = "run";
}

//Function Number: 9
melee_stopmovement()
{
	self clearanim(%body,0.2);
	self.melee.playingmovementanim = undefined;
	self.a.movement = "stop";
	self orientmode("face default");
}

//Function Number: 10
melee_mainloop()
{
	self endon("killanimscript");
	self endon("end_melee");
	for(;;)
	{
		var_00 = self.melee.func;
		[[ self.melee.func ]]();
		if(!isdefined(self.melee.func) || var_00 == self.melee.func)
		{
			break;
		}
	}
}

//Function Number: 11
melee_standard_delaystandardcharge(param_00)
{
	if(!isdefined(param_00))
	{
		return;
	}

	self.nextmeleestandardchargetime = gettime() + 2500;
	self.nextmeleestandardchargetarget = param_00;
}

//Function Number: 12
melee_standard_checktimeconstraints()
{
	var_00 = distancesquared(self.melee.target.origin,self.origin);
	if(var_00 > 4096 && isdefined(self.nextmeleestandardchargetime) && isdefined(self.nextmeleestandardchargetarget) && gettime() < self.nextmeleestandardchargetime && self.nextmeleestandardchargetarget == self.melee.target)
	{
		return 0;
	}

	return 1;
}

//Function Number: 13
func_0C10()
{
	if(isdefined(self.melee.target.magic_bullet_shield))
	{
		return 0;
	}

	if(!melee_standard_checktimeconstraints())
	{
		return 0;
	}

	if(isdefined(self.melee.target.specialmeleechooseaction))
	{
		return 0;
	}

	return func_0C16();
}

//Function Number: 14
melee_standard_resetgiveuptime()
{
	if(isdefined(self.meleechargedistsq))
	{
		var_00 = self.meleechargedistsq;
	}
	else if(isplayer(self.melee.target))
	{
		var_00 = -25536;
	}
	else
	{
		var_00 = 25600;
	}

	if(distancesquared(self.origin,self.melee.target.origin) > var_00)
	{
		self.melee.giveuptime = gettime() + 3000;
		return;
	}

	self.melee.giveuptime = gettime() + 1000;
}

//Function Number: 15
melee_standard_main()
{
	self animmode("zonly_physics");
	if(isdefined(self.melee.target))
	{
		melee_standard_resetgiveuptime();
	}

	while(isdefined(self.melee.target))
	{
		if(!melee_standard_getinposition())
		{
			self.nextmeleechargetime = gettime() + 1500;
			self.nextmeleechargetarget = self.melee.target;
			break;
		}

		if(!isdefined(self.melee.target))
		{
			break;
		}

		animscripts/battlechatter_ai::evaluatemeleeevent();
		self orientmode("face point",self.melee.target.origin);
		self setflaggedanimknoballrestart("meleeanim",%melee_1,%body,1,0.2,1);
		self.melee.inprogress = 1;
		if(!melee_standard_playattackloop())
		{
			melee_standard_delaystandardcharge(self.melee.target);
			break;
		}
	}

	self animmode("none");
}

//Function Number: 16
melee_standard_playattackloop()
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
			if(!melee_chooseaction())
			{
				return 0;
			}

			if(self.melee.func != ::melee_standard_main)
			{
				return 1;
			}
		}

		if(var_00 == "fire")
		{
			if(isdefined(self.melee.target))
			{
				var_01 = self.melee.target.health;
				self melee();
				if(isdefined(self.melee.target) && self.melee.target.health < var_01)
				{
					melee_standard_resetgiveuptime();
				}
			}
		}
	}
}

//Function Number: 17
func_0C16()
{
	if(!isdefined(self.melee.target))
	{
		return 0;
	}

	if(!melee_isvalid())
	{
		return 0;
	}

	var_00 = vectornormalize(self.melee.target.origin - self.origin);
	self.melee.startpos = self.melee.target.origin - 40 * var_00;
	return melee_updateandvalidatestartpos();
}

//Function Number: 18
distance2dsquared(param_00,param_01)
{
	var_02 = (param_00[0] - param_01[0],param_00[1] - param_01[1],0);
	return lengthsquared(var_02);
}

//Function Number: 19
melee_standard_getinposition()
{
	if(!func_0C16())
	{
		return 0;
	}

	var_00 = distance2dsquared(self.origin,self.melee.target.origin);
	if(var_00 <= 4096)
	{
		self setflaggedanimknoball("readyanim",%stand_2_melee_1,%body,1,0.3,1);
		animscripts/shared::donotetracks("readyanim");
		return 1;
	}

	melee_playchargesound();
	var_01 = self.melee.target.origin;
	var_02 = 0.1;
	var_03 = length(getmovedelta(%run_2_melee_charge,0,1));
	var_04 = 32;
	var_05 = 48 + var_04 + var_03;
	var_06 = var_05 * var_05;
	var_07 = 64 + var_04;
	var_08 = var_07 * var_07;
	var_09 = getanimlength(%run_2_melee_charge) * 1000;
	var_0A = var_09 - 100;
	var_0B = var_09 - 200;
	var_0C = 0;
	var_0D = undefined;
	var_0E = %run_lowready_f;
	if(isplayer(self.melee.target) && self.melee.target == self.enemy)
	{
		self orientmode("face enemy");
	}
	else
	{
		self orientmode("face point",self.melee.target.origin);
	}

	self setflaggedanimknoball("chargeanim",var_0E,%body,1,0.3,1);
	var_0F = 0;
	for(;;)
	{
		var_10 = gettime();
		var_11 = isdefined(var_0D) && var_0D <= var_06;
		if(!var_0F)
		{
			if(var_11)
			{
				melee_startmovement();
				self setflaggedanimknoballrestart("chargeanim",%run_2_melee_charge,%body,1,0.2,1);
				var_0C = var_10;
				var_0F = 1;
			}
		}
		else
		{
			var_12 = var_00 <= var_06;
			if(var_10 - var_0C >= var_0A || !var_11 && !var_12)
			{
				melee_startmovement();
				self setflaggedanimknoball("chargeanim",var_0E,%body,1,0.3,1);
				var_0F = 0;
			}
		}

		animscripts/notetracks::donotetracksfortime(var_02,"chargeanim");
		if(!func_0C16())
		{
			melee_stopmovement();
			return 0;
		}

		var_00 = distance2dsquared(self.origin,self.melee.target.origin);
		var_13 = self.melee.target.origin - var_01 * 1 / gettime() - var_10;
		var_01 = self.melee.target.origin;
		var_14 = self.melee.target.origin + var_13 * var_0B;
		var_0D = distance2dsquared(self.origin,var_14);
		if(var_0F && var_00 <= var_08 && gettime() - var_0C >= var_0A || !isplayer(self.melee.target))
		{
			break;
		}

		if(!var_0F && gettime() >= self.melee.giveuptime)
		{
			melee_stopmovement();
			return 0;
		}
	}

	melee_stopmovement();
	return 1;
}

//Function Number: 20
melee_playchargesound()
{
	if(!isdefined(self.a.var_C1A))
	{
		self.a.var_C1A = 0;
	}

	if((isdefined(self.enemy) && isplayer(self.enemy)) || randomint(3) == 0)
	{
		if(gettime() > self.a.var_C1A)
		{
			animscripts/face::saygenericdialogue("meleecharge");
			self.a.var_C1A = gettime() + 8000;
		}
	}
}

//Function Number: 21
melee_aivsai_exposed_chooseanimationandposition_flip(param_00)
{
	var_01 = 90;
	if(self.melee.inprogress)
	{
		var_01 = var_01 + 50;
	}

	if(abs(param_00) < var_01)
	{
		return 0;
	}

	var_02 = self.melee.target;
	func_0C27();
	if(self.melee.winner)
	{
		self.melee.animname = %melee_f_awin_attack;
		var_02.melee.animname = %melee_f_awin_defend;
		var_02.melee.surviveanimname = %melee_f_awin_defend_survive;
	}
	else
	{
		self.melee.animname = %melee_f_dwin_attack;
		var_02.melee.animname = %melee_f_dwin_defend;
	}

	return 1;
}

//Function Number: 22
melee_aivsai_exposed_chooseanimationandposition_wrestle(param_00)
{
	var_01 = 100;
	if(self.melee.inprogress)
	{
		var_01 = var_01 + 50;
	}

	if(abs(param_00) < var_01)
	{
		return 0;
	}

	var_02 = self.melee.target;
	if(isdefined(var_02.magic_bullet_shield))
	{
		return 0;
	}

	if(isdefined(var_02.meleealwayswin))
	{
		return 0;
	}

	self.melee.winner = 1;
	self.melee.animname = %bog_melee_r_attack;
	var_02.melee.animname = %bog_melee_r_defend;
	var_02.melee.surviveanimname = %bog_melee_r_backdeath2;
	return 1;
}

//Function Number: 23
melee_aivsai_exposed_chooseanimationandposition_behind(param_00)
{
	if(-90 > param_00 || param_00 > 0)
	{
		return 0;
	}

	var_01 = self.melee.target;
	if(isdefined(var_01.magic_bullet_shield))
	{
		return 0;
	}

	if(isdefined(var_01.meleealwayswin))
	{
		return 0;
	}

	self.melee.winner = 1;
	self.melee.animname = %melee_sync_attack;
	var_01.melee.animname = %melee_sync_defend;
	return 1;
}

//Function Number: 24
melee_aivsai_exposed_chooseanimationandposition_buildexposedlist()
{
	if(isdefined(self.var_C23))
	{
		var_00[0] = ::melee_aivsai_exposed_chooseanimationandposition_flip;
	}
	else if(isdefined(self.meleeforcedexposedwrestle))
	{
		var_00[0] = ::melee_aivsai_exposed_chooseanimationandposition_wrestle;
	}
	else
	{
		var_01 = randomint(2);
		var_02 = 1 - var_01;
		var_03 = 2;
		var_00[var_01] = ::melee_aivsai_exposed_chooseanimationandposition_flip;
		var_00[var_02] = ::melee_aivsai_exposed_chooseanimationandposition_wrestle;
		var_00[var_03] = ::melee_aivsai_exposed_chooseanimationandposition_behind;
	}

	return var_00;
}

//Function Number: 25
melee_aivsai_exposed_chooseanimationandposition()
{
	var_00 = self.melee.target;
	var_01 = vectortoangles(var_00.origin - self.origin);
	var_02 = angleclamp180(var_00.angles[1] - var_01[1]);
	var_03 = melee_aivsai_exposed_chooseanimationandposition_buildexposedlist();
	for(var_04 = 0;var_04 < var_03.size;var_04++)
	{
		if([[ var_03[var_04] ]](var_02))
		{
			self.melee.startangles = (0,var_01[1],0);
			self.melee.startpos = getstartorigin(var_00.origin,var_00.angles,self.melee.animname);
			if(melee_updateandvalidatestartpos())
			{
				return 1;
			}
		}
	}

	return 0;
}

//Function Number: 26
func_0C27()
{
	var_00 = self.melee.target;
	if(isdefined(self.meleealwayswin))
	{
		self.melee.winner = 1;
		return;
	}
	else if(isdefined(var_00.meleealwayswin))
	{
		self.melee.winner = 0;
		return;
	}

	if(isdefined(self.magic_bullet_shield))
	{
		self.melee.winner = 1;
		return;
	}

	if(isdefined(var_00.magic_bullet_shield))
	{
		self.melee.winner = 0;
		return;
	}

	self.melee.winner = common_scripts\utility::cointoss();
}

//Function Number: 27
melee_aivsai_specialcover_chooseanimationandposition()
{
	var_00 = self.melee.target;
	func_0C27();
	if(var_00.covernode.type == "Cover Left")
	{
		if(self.melee.winner)
		{
			self.melee.animname = %cornersdl_melee_wina_attacker;
			var_00.melee.animname = %cornersdl_melee_wina_defender;
			var_00.melee.surviveanimname = %cornersdl_melee_wina_defender_survive;
		}
		else
		{
			self.melee.animname = %cornersdl_melee_wind_attacker;
			self.melee.surviveanimname = %cornersdl_melee_wind_attacker_survive;
			var_00.melee.animname = %cornersdl_melee_wind_defender;
		}
	}
	else if(self.melee.winner)
	{
		self.melee.animname = %cornersdr_melee_wina_attacker;
		var_00.melee.animname = %cornersdr_melee_wina_defender;
	}
	else
	{
		self.melee.animname = %cornersdr_melee_wind_attacker;
		var_00.melee.animname = %cornersdr_melee_wind_defender;
	}

	self.melee.startpos = getstartorigin(var_00.covernode.origin,var_00.covernode.angles,self.melee.animname);
	self.melee.startangles = (var_00.covernode.angles[0],angleclamp180(var_00.covernode.angles[1] + 180),var_00.covernode.angles[2]);
	var_00.melee.faceyaw = animscripts/utility::getnodeforwardyaw(var_00.covernode);
	self.melee.starttotargetcornerangles = var_00.covernode.angles;
	if(!melee_updateandvalidatestartpos())
	{
		self.melee.starttotargetcornerangles = undefined;
		return 0;
	}

	return 1;
}

//Function Number: 28
melee_aivsai_specialcover_canexecute()
{
	var_00 = self.melee.target.covernode;
	if(!isdefined(var_00))
	{
		return 0;
	}

	if(distancesquared(var_00.origin,self.melee.target.origin) > 16 && isdefined(self.melee.target.a.var_8E3) && self.melee.target.a.var_8E3 != "hide" && self.melee.target.a.var_8E3 != "lean")
	{
		return 0;
	}

	var_01 = vectortoangles(self.origin - var_00.origin);
	var_02 = angleclamp180(var_00.angles[1] - var_01[1]);
	if(var_00.type == "Cover Left")
	{
		if(var_02 >= -50 && var_02 <= 0)
		{
			return 1;
		}
	}
	else if(var_00.type == "Cover Right")
	{
		if(var_02 >= 0 && var_02 <= 50)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 29
melee_aivsai_chooseaction()
{
	var_00 = self.melee.target;
	if(!isai(var_00) || var_00.type != "human")
	{
		return 0;
	}

	if(self.stairsstate != "none" || var_00.stairsstate != "none")
	{
		return 0;
	}

	if(isdefined(self.meleealwayswin) && isdefined(var_00.meleealwayswin))
	{
		return 0;
	}

	if(isdefined(self.magic_bullet_shield) && isdefined(var_00.magic_bullet_shield))
	{
		return 0;
	}

	if((isdefined(self.meleealwayswin) && isdefined(var_00.magic_bullet_shield)) || isdefined(var_00.meleealwayswin) && isdefined(self.magic_bullet_shield))
	{
		return 0;
	}

	if(isdefined(self.specialmeleechooseaction))
	{
		if(![[ self.specialmeleechooseaction ]]())
		{
			return 0;
		}

		self.melee.precisepositioning = 1;
	}
	else if(isdefined(var_00.specialmeleechooseaction))
	{
		return 0;
	}
	else if(melee_aivsai_specialcover_canexecute() && melee_aivsai_specialcover_chooseanimationandposition())
	{
		self.melee.precisepositioning = 1;
	}
	else
	{
		if(!melee_aivsai_exposed_chooseanimationandposition())
		{
			return 0;
		}

		self.melee.precisepositioning = 0;
	}

	if(!isdefined(var_00.melee.faceyaw))
	{
		var_00.melee.faceyaw = var_00.angles[1];
	}

	self.melee.startposoffset = self.melee.startpos - var_00.origin;
	return 1;
}

//Function Number: 30
melee_aivsai_schedulenotetracklink(param_00)
{
	self.melee.syncnotetrackent = param_00;
	param_00.melee.syncnotetrackent = undefined;
}

//Function Number: 31
melee_aivsai_targetlink(param_00)
{
	if(!isdefined(param_00.melee))
	{
		return;
	}

	melee_playchargesound();
	if(!isalive(param_00))
	{
		return;
	}

	self.syncedmeleetarget = param_00;
	param_00.syncedmeleetarget = self;
	self.melee.var_C31 = 1;
	param_00.melee.var_C31 = 1;
	self linktoblendtotag(param_00,"tag_sync",1,1);
}

//Function Number: 32
melee_aivsai_main()
{
	if(!melee_aivsai_getinposition())
	{
		self.nextmeleechargetime = gettime() + 1500;
		self.nextmeleechargetarget = self.melee.target;
		return;
	}

	var_00 = self.melee.target;
	melee_aivsai_schedulenotetracklink(var_00);
	if(self.melee.winner)
	{
		self.melee.death = undefined;
		var_00.melee.death = 1;
	}
	else
	{
		var_00.melee.death = undefined;
		self.melee.death = 1;
	}

	self.melee.partner = var_00;
	var_00.melee.partner = self;
	if(animscripts/utility::usingsidearm())
	{
		maps\_utility::forceuseweapon(self.primaryweapon,"primary");
		self.lastweapon = self.primaryweapon;
	}

	if(var_00 animscripts/utility::usingsidearm())
	{
		var_00 maps\_utility::forceuseweapon(var_00.primaryweapon,"primary");
		var_00.lastweapon = var_00.primaryweapon;
	}

	self.melee.weapon = self.weapon;
	self.melee.weaponslot = animscripts/utility::getcurrentweaponslotname();
	var_00.melee.weapon = var_00.weapon;
	var_00.melee.weaponslot = var_00 animscripts/utility::getcurrentweaponslotname();
	self.melee.inprogress = 1;
	var_00 animcustom(::melee_aivsai_execute,::melee_endscript);
	var_00 thread melee_aivsai_animcustominterruptionmonitor(self);
	self.melee.target = undefined;
	melee_aivsai_execute();
}

//Function Number: 33
melee_aivsai_animcustominterruptionmonitor(param_00)
{
	self endon("end_melee");
	self endon("melee_aivsai_execute");
	wait 0.1;
	if(isdefined(param_00))
	{
		param_00 notify("end_melee");
	}

	self notify("end_melee");
}

//Function Number: 34
melee_aivsai_getinposition_updateandvalidatetarget(param_00,param_01)
{
	if(isdefined(param_01) && param_01 <= gettime())
	{
		return 0;
	}

	if(!melee_isvalid())
	{
		return 0;
	}

	var_02 = self.melee.target;
	var_03 = distancesquared(var_02.origin,param_00);
	if(self.melee.precisepositioning)
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

	self.melee.startpos = var_02.origin + self.melee.startposoffset;
	if(!melee_updateandvalidatestartpos())
	{
		return 0;
	}

	return 1;
}

//Function Number: 35
melee_aivsai_getinposition_issuccessful(param_00)
{
	var_01 = distancesquared((self.origin[0],self.origin[1],0),(self.melee.startpos[0],self.melee.startpos[1],0));
	if(var_01 < 64 && abs(self.melee.startpos[2] - self.origin[2]) < 64)
	{
		return 1;
	}

	var_02 = distancesquared((param_00[0],param_00[1],0),(self.melee.startpos[0],self.melee.startpos[1],0));
	var_03 = distancesquared((self.origin[0],self.origin[1],0),(self.melee.target.origin[0],self.melee.target.origin[1],0));
	if(var_02 > var_03 && abs(self.melee.target.origin[2] - self.origin[2]) < 64)
	{
		return 1;
	}

	return 0;
}

//Function Number: 36
melee_aivsai_getinposition_finalize(param_00)
{
	melee_stopmovement();
	if(self.melee.precisepositioning)
	{
		self forceteleport(self.melee.startpos,self.melee.startangles);
		wait 0.05;
	}
	else
	{
		self orientmode("face angle",self.melee.startangles[1]);
		wait 0.05;
	}

	return melee_aivsai_getinposition_updateandvalidatetarget(param_00);
}

//Function Number: 37
melee_aivsai_getinposition()
{
	if(!melee_isvalid())
	{
		return 0;
	}

	melee_startmovement();
	self clearanim(%body,0.2);
	self setanimknoball(animscripts/run::getrunanim(),%body,1,0.2);
	self animmode("zonly_physics");
	self.keepclaimednode = 1;
	var_00 = gettime() + 1500;
	var_01 = self.melee.target.origin;
	while(melee_aivsai_getinposition_updateandvalidatetarget(var_01,var_00))
	{
		if(melee_aivsai_getinposition_issuccessful(var_01))
		{
			return melee_aivsai_getinposition_finalize(var_01);
		}

		self orientmode("face point",self.melee.startpos);
		wait 0.05;
	}

	melee_stopmovement();
	return 0;
}

//Function Number: 38
melee_aivsai_execute()
{
	self endon("killanimscript");
	self endon("end_melee");
	self notify("melee_aivsai_execute");
	self animmode("zonly_physics");
	self.a.special = "none";
	self.specialdeathfunc = undefined;
	thread melee_droppedweaponmonitorthread();
	thread func_0C4A();
	if(isdefined(self.melee.faceyaw))
	{
		self orientmode("face angle",self.melee.faceyaw);
	}
	else
	{
		self orientmode("face current");
	}

	self.a.var_911 = "stand";
	self clearanim(%body,0.2);
	if(isdefined(self.melee.death))
	{
		melee_disableinterruptions();
	}

	self setflaggedanimknoballrestart("meleeAnim",self.melee.animname,%body,1,0.2);
	var_00 = animscripts/shared::donotetracks("meleeAnim",::melee_handlenotetracks);
	if(var_00 == "melee_death" && isdefined(self.melee.survive))
	{
		func_0C45();
		self setflaggedanimknoballrestart("meleeAnim",self.melee.surviveanimname,%body,1,0.2);
		var_00 = animscripts/shared::donotetracks("meleeAnim",::melee_handlenotetracks);
	}

	if(isdefined(self.melee) && isdefined(self.melee.death))
	{
		self kill();
	}

	self.keepclaimednode = 0;
}

//Function Number: 39
melee_disableinterruptions()
{
	self.melee.wasallowingpain = self.allowpain;
	self.melee.wasflashbangimmune = self.flashbangimmunity;
	maps\_utility::disable_pain();
	maps\_utility::setflashbangimmunity(1);
}

//Function Number: 40
func_0C44()
{
	return isdefined(self.melee.weapon) && self.melee.weapon != "none" && self.weapon != self.melee.weapon;
}

//Function Number: 41
func_0C45()
{
	if(self.weapon != "none" && self.lastweapon != "none")
	{
		return;
	}

	if(!isdefined(self.melee.weapon) || self.melee.weapon == "none")
	{
		return;
	}

	maps\_utility::forceuseweapon(self.melee.weapon,self.melee.weaponslot);
	if(isdefined(self.melee.var_C46))
	{
		self.melee.var_C46 delete();
		self.melee.var_C46 = undefined;
	}
}

//Function Number: 42
melee_droppedweaponmonitorthread()
{
	self endon("killanimscript");
	self endon("end_melee");
	self waittill("weapon_dropped",var_00);
	if(isdefined(var_00))
	{
		self.melee.var_C46 = var_00;
	}
}

//Function Number: 43
melee_partnerendedmeleemonitorthread_shouldanimsurvive()
{
	if(!isdefined(self.melee.surviveanimname))
	{
		return 0;
	}

	if(!isdefined(self.melee.surviveanimallowed))
	{
		return 0;
	}

	return 1;
}

//Function Number: 44
func_0C4A()
{
	self endon("killanimscript");
	self endon("end_melee");
	self waittill("partner_end_melee");
	if(isdefined(self.melee.death))
	{
		if(isdefined(self.melee.animateddeath) || isdefined(self.melee.interruptdeath))
		{
			self kill();
			return;
		}

		self.melee.death = undefined;
		if(melee_partnerendedmeleemonitorthread_shouldanimsurvive())
		{
			self.melee.survive = 1;
			return;
		}

		self notify("end_melee");
		return;
	}

	if(!isdefined(self.melee.unsynchappened))
	{
		self notify("end_melee");
	}
}

//Function Number: 45
melee_unlink()
{
	if(!isdefined(self.melee.var_C31))
	{
		return;
	}

	if(isdefined(self.syncedmeleetarget))
	{
		self.syncedmeleetarget func_0C4F();
	}

	func_0C4F();
}

//Function Number: 46
func_0C4F()
{
	self unlink();
	self.syncedmeleetarget = undefined;
	if(!isalive(self))
	{
		return;
	}

	self.melee.var_C31 = undefined;
	self animmode("zonly_physics");
	self orientmode("face angle",self.angles[1]);
}

//Function Number: 47
melee_handlenotetracks_unsync()
{
	melee_unlink();
	self.melee.unsynchappened = 1;
	if(isdefined(self.melee.partner) && isdefined(self.melee.partner.melee))
	{
		self.melee.partner.melee.unsynchappened = 1;
	}
}

//Function Number: 48
melee_handlenotetracks_shoulddieafterunsync()
{
	if(animhasnotetrack(self.melee.animname,"melee_death"))
	{
		return 0;
	}

	return isdefined(self.melee.death);
}

//Function Number: 49
melee_handlenotetracks_death(param_00)
{
	if(isdefined(param_00) && param_00)
	{
		self.melee.interruptdeath = 1;
		return;
	}

	self.melee.animateddeath = 1;
}

//Function Number: 50
melee_handlenotetracks(param_00)
{
	if(issubstr(param_00,"ps_"))
	{
		var_01 = getsubstr(param_00,3);
		self playsound(var_01);
		return;
	}

	if(var_01 == "sync")
	{
		if(isdefined(self.melee.syncnotetrackent))
		{
			melee_aivsai_targetlink(self.melee.syncnotetrackent);
			self.melee.syncnotetrackent = undefined;
			return;
		}

		return;
	}

	if(var_01 == "unsync")
	{
		melee_handlenotetracks_unsync();
		if(melee_handlenotetracks_shoulddieafterunsync())
		{
			melee_handlenotetracks_death();
			return;
		}

		return;
	}

	if(var_01 == "melee_interact")
	{
		self.melee.surviveanimallowed = 1;
		return;
	}

	if(var_01 == "melee_death")
	{
		if(isdefined(self.melee.survive))
		{
			return var_01;
		}

		melee_handlenotetracks_death();
		if(isdefined(self.melee.animateddeath))
		{
			return var_01;
		}

		return;
	}

	if(var_01 == "attach_knife")
	{
		self attach("weapon_parabolic_knife","TAG_INHAND",1);
		self.melee.hasknife = 1;
		return;
	}

	if(var_01 == "detach_knife")
	{
		self detach("weapon_parabolic_knife","TAG_INHAND",1);
		self.melee.hasknife = undefined;
		return;
	}

	if(var_01 == "stab")
	{
		self playsound("melee_knife_hit_body");
		playfxontag(level._effect["melee_knife_ai"],self,"TAG_KNIFE_FX");
		if(isdefined(self.melee.partner) && isdefined(self.melee.partner.melee))
		{
			self.melee.partner melee_handlenotetracks_death(1);
			return;
		}

		return;
	}
}

//Function Number: 51
func_0C55()
{
	self endon("end_melee");
	animscripts/shared::dropallaiweapons();
	return 0;
}

//Function Number: 52
melee_deathhandler_delayed()
{
	self endon("end_melee");
	animscripts/notetracks::func_C57("meleeAnim",10);
	animscripts/shared::dropallaiweapons();
	self startragdoll();
	return 1;
}

//Function Number: 53
melee_endscript_checkdeath()
{
	if(!isalive(self) && isdefined(self.melee.death))
	{
		if(isdefined(self.melee.animateddeath))
		{
			self.deathfunction = ::melee_deathhandler_delayed;
			return;
		}

		self.deathfunction = ::func_0C55;
	}
}

//Function Number: 54
melee_endscript_checkpositionandmovement()
{
	if(!isalive(self))
	{
		return;
	}

	if(isdefined(self.melee.playingmovementanim))
	{
		melee_stopmovement();
	}

	var_00 = self getdroptofloorposition();
	if(isdefined(var_00))
	{
		self forceteleport(var_00,self.angles);
	}
}

//Function Number: 55
melee_endscript_checkweapon()
{
	if(isdefined(self.melee.hasknife))
	{
		self detach("weapon_parabolic_knife","TAG_INHAND",1);
	}

	if(isalive(self))
	{
		func_0C45();
	}
}

//Function Number: 56
melee_endscript_checkstatechanges()
{
	if(isdefined(self.melee.wasallowingpain))
	{
		if(self.melee.wasallowingpain)
		{
			maps\_utility::enable_pain();
		}
		else
		{
			maps\_utility::disable_pain();
		}
	}

	if(isdefined(self.melee.wasflashbangimmune))
	{
		maps\_utility::setflashbangimmunity(self.melee.wasflashbangimmune);
	}
}

//Function Number: 57
melee_endscript()
{
	melee_unlink();
	melee_endscript_checkdeath();
	melee_endscript_checkpositionandmovement();
	melee_endscript_checkweapon();
	melee_endscript_checkstatechanges();
	if(isdefined(self.melee.partner))
	{
		self.melee.partner notify("partner_end_melee");
	}

	melee_releasemutex(self.melee.target);
}

//Function Number: 58
melee_acquiremutex(param_00)
{
	if(isdefined(self.melee))
	{
		return 0;
	}

	if(isdefined(param_00.melee))
	{
		return 0;
	}

	self.melee = spawnstruct();
	param_00.melee = spawnstruct();
	return 1;
}

//Function Number: 59
melee_releasemutex(param_00)
{
	self.melee = undefined;
	if(isdefined(param_00))
	{
		param_00.melee = undefined;
	}
}