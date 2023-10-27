/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\melee.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 62
 * Decompile Time: 1162 ms
 * Timestamp: 10/27/2023 2:44:20 AM
*******************************************************************/

//Function Number: 1
init_animset_melee()
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
	var_00["aivai_exposed_defenderwins_attack_kick"] = %melee_f_dwin_attack_kick;
	var_00["aivai_exposed_defenderwins_defend_kick"] = %melee_f_dwin_defend_kick;
	var_00["aivai_exposed_defenderwins_attack_survive_kick"] = %melee_f_dwin_attack_survive_kick;
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
melee_init()
{
	precachemodel("weapon_parabolic_knife");
	level._effect["melee_knife_ai"] = loadfx("vfx/weaponimpact/flesh_impact_knife");
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

//Function Number: 5
melee_resetaction()
{
	self.melee.target = self.enemy;
	self.melee.initiated = 0;
	self.melee.inprogress = 0;
}

//Function Number: 6
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

	if(melee_standard_chooseaction())
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
	self.nextmeleechecktarget = self.melee.target;
	return 0;
}

//Function Number: 7
melee_updateandvalidatestartpos()
{
	var_00 = 1;
	var_01 = distance2d(self.melee.startpos,self.melee.target.origin);
	if(var_01 < 32)
	{
		var_02 = vectornormalize((self.melee.startpos[0] - self.melee.target.origin[0],self.melee.startpos[1] - self.melee.target.origin[1],0));
		self.melee.startpos = self.melee.startpos + var_02 * 32 - var_01;
		if(distance(self.melee.startpos,self.melee.target.origin) < 31.9)
		{
			return 0;
		}

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

//Function Number: 8
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
		var_02 = 40000;
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

	if(isdefined(self.nextmeleechecktime) && isdefined(self.nextmeleechecktarget) && gettime() < self.nextmeleechecktime && self.nextmeleechecktarget == var_00)
	{
		return 0;
	}

	if(isdefined(self.a.onback) || self.a.pose == "prone")
	{
		return 0;
	}

	if(animscripts\utility::usingsidearm())
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
		var_03 = var_01.a.pose;
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

	var_05 = angleclamp180(self.angles[1] - animscripts\utility::getyaw(var_00.origin));
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

//Function Number: 9
melee_startmovement()
{
	self.melee.playingmovementanim = 1;
	self.a.movement = "run";
}

//Function Number: 10
melee_stopmovement()
{
	self clearanim(%body,0.2);
	self.melee.playingmovementanim = undefined;
	self.a.movement = "stop";
	self orientmode("face default");
}

//Function Number: 11
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

//Function Number: 12
melee_standard_delaystandardcharge(param_00)
{
	if(!isdefined(param_00))
	{
		return;
	}

	self.nextmeleestandardchargetime = gettime() + 2500;
	self.nextmeleestandardchargetarget = param_00;
}

//Function Number: 13
melee_standard_checktimeconstraints()
{
	var_00 = distancesquared(self.melee.target.origin,self.origin);
	if(var_00 > 4096 && isdefined(self.nextmeleestandardchargetime) && isdefined(self.nextmeleestandardchargetarget) && gettime() < self.nextmeleestandardchargetime && self.nextmeleestandardchargetarget == self.melee.target)
	{
		return 0;
	}

	return 1;
}

//Function Number: 14
melee_standard_chooseaction()
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

	return melee_standard_updateandvalidatetarget();
}

//Function Number: 15
melee_standard_resetgiveuptime()
{
	if(isdefined(self.meleechargedistsq))
	{
		var_00 = self.meleechargedistsq;
	}
	else if(isplayer(self.melee.target))
	{
		var_00 = 40000;
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

//Function Number: 16
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

		animscripts\battlechatter_ai::evaluatemeleeevent();
		self orientmode("face point",self.melee.target.origin);
		var_00 = animscripts\utility::lookupanim("melee","standard");
		self setflaggedanimknoballrestart("meleeanim",var_00,%body,1,0.2,1);
		melee_playfacialanim(var_00);
		self.melee.inprogress = 1;
		if(!melee_standard_playattackloop())
		{
			melee_standard_delaystandardcharge(self.melee.target);
			break;
		}
	}

	self animmode("none");
}

//Function Number: 17
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

//Function Number: 18
melee_standard_updateandvalidatetarget()
{
	if(!isdefined(self.melee.target))
	{
		return 0;
	}

	if(!isdefined(self.enemy))
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

//Function Number: 19
melee_standard_getinposition()
{
	if(!melee_standard_updateandvalidatetarget())
	{
		return 0;
	}

	var_00 = common_scripts\utility::distance_2d_squared(self.origin,self.melee.target.origin);
	if(var_00 <= 4096)
	{
		var_01 = animscripts\utility::lookupanim("melee","standard_stand_to_melee");
		self setflaggedanimknoball("readyanim",var_01,%body,1,0.3,1);
		melee_playfacialanim(var_01);
		animscripts\shared::donotetracks("readyanim");
		return 1;
	}

	melee_playchargesound();
	var_02 = self.melee.target.origin;
	var_03 = 0.1;
	var_04 = animscripts\utility::lookupanim("melee","standard_run_to_melee");
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
	var_10 = animscripts\utility::lookupanim("run","straight");
	if(isplayer(self.melee.target) && self.melee.target == self.enemy)
	{
		self orientmode("face enemy");
	}
	else
	{
		self orientmode("face point",self.melee.target.origin);
	}

	self setflaggedanimknoball("chargeanim",var_10,%body,1,0.2,1);
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
				melee_startmovement();
				self setflaggedanimknoballrestart("chargeanim",var_04,%body,1,0.1,1);
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
				melee_startmovement();
				self setflaggedanimknoball("chargeanim",var_10,%body,1,0.3,1);
				melee_playfacialanim(var_10);
				var_11 = 0;
			}
		}

		animscripts\notetracks::donotetracksfortime(var_03,"chargeanim");
		if(!melee_standard_updateandvalidatetarget())
		{
			melee_stopmovement();
			return 0;
		}

		var_01 = common_scripts\utility::distance_2d_squared(self.origin,self.melee.target.origin);
		var_15 = self.melee.target.origin - var_02 * 1 / gettime() - var_12;
		var_02 = self.melee.target.origin;
		var_16 = self.melee.target.origin + var_15 * var_0D;
		var_0F = common_scripts\utility::distance_2d_squared(self.origin,var_16);
		if(var_11 && var_01 <= var_0A && gettime() - var_0E >= var_0C || !isplayer(self.melee.target))
		{
			break;
		}

		if(!var_11 && gettime() >= self.melee.giveuptime)
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
	if(!isdefined(self.a.nextmeleechargesound))
	{
		self.a.nextmeleechargesound = 0;
	}

	if((isdefined(self.enemy) && isplayer(self.enemy)) || randomint(3) == 0)
	{
		if(gettime() > self.a.nextmeleechargesound)
		{
			animscripts\face::saygenericdialogue("meleecharge");
			self.a.nextmeleechargesound = gettime() + 8000;
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
	melee_decide_winner();
	if(self.melee.winner)
	{
		self.melee.animname = animscripts\utility::lookupanim("melee","aivai_exposed_attackerwins_attack");
		var_02.melee.animname = animscripts\utility::lookupanim("melee","aivai_exposed_attackerwins_defend");
		var_02.melee.surviveanimname = animscripts\utility::lookupanim("melee","aivai_exposed_attackerwins_defend_survive");
	}
	else
	{
		self.melee.animname = animscripts\utility::lookupanim("melee","aivai_exposed_defenderwins_attack");
		var_02.melee.animname = animscripts\utility::lookupanim("melee","aivai_exposed_defenderwins_defend");
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
	self.melee.animname = animscripts\utility::lookupanim("melee","aivai_wrestle_attackerwins_attack");
	var_02.melee.animname = animscripts\utility::lookupanim("melee","aivai_wrestle_attackerwins_defend");
	var_02.melee.surviveanimname = animscripts\utility::lookupanim("melee","aivai_wrestle_attackerwins_defend_survive");
	return 1;
}

//Function Number: 23
melee_aivsai_exposed_chooseanimationandposition_kick(param_00)
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

	if(isdefined(self.magic_bullet_shield))
	{
		return 0;
	}

	var_02 = self.melee.target;
	if(isdefined(self.meleealwayswin))
	{
		return 0;
	}

	self.melee.winner = 0;
	self.melee.animname = animscripts\utility::lookupanim("melee","aivai_exposed_defenderwins_attack_kick");
	self.melee.surviveanimname = animscripts\utility::lookupanim("melee","aivai_exposed_defenderwins_attack_survive_kick");
	var_02.melee.animname = animscripts\utility::lookupanim("melee","aivai_exposed_defenderwins_defend_kick");
	return 1;
}

//Function Number: 24
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
	self.melee.animname = animscripts\utility::lookupanim("melee","aivai_behind_attackerwins_attack");
	var_01.melee.animname = animscripts\utility::lookupanim("melee","aivai_behind_attackerwins_defend");
	return 1;
}

//Function Number: 25
melee_aivsai_exposed_chooseanimationandposition_buildexposedlist()
{
	if(isdefined(self.meleeforcedexposedflip))
	{
		var_00[0] = ::melee_aivsai_exposed_chooseanimationandposition_flip;
	}
	else if(isdefined(self.meleeforcedexposedwrestle))
	{
		var_00[0] = ::melee_aivsai_exposed_chooseanimationandposition_wrestle;
	}
	else
	{
		var_00[0] = ::melee_aivsai_exposed_chooseanimationandposition_flip;
		var_00[1] = ::melee_aivsai_exposed_chooseanimationandposition_wrestle;
		var_00[2] = ::melee_aivsai_exposed_chooseanimationandposition_kick;
		var_00[3] = ::melee_aivsai_exposed_chooseanimationandposition_behind;
		for(var_01 = 2;var_01 > 0;var_01--)
		{
			var_02 = randomint(var_01 + 1);
			var_03 = var_00[var_01];
			var_00[var_01] = var_00[var_02];
			var_00[var_02] = var_03;
		}
	}

	return var_00;
}

//Function Number: 26
melee_aivsai_exposed_chooseanimationandposition()
{
	if(isdefined(self.h1_melee_animations_enabled) && !self.h1_melee_animations_enabled)
	{
		return 0;
	}

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

//Function Number: 27
melee_decide_winner()
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

//Function Number: 28
melee_aivsai_specialcover_chooseanimationandposition()
{
	var_00 = self.melee.target;
	melee_decide_winner();
	var_01 = var_00.covernode.type;
	if(var_01 == "Cover Multi")
	{
		var_01 = animscripts\utility::getcovermultipretendtype(var_00.covernode);
	}

	if(var_01 == "Cover Left")
	{
		if(self.melee.winner)
		{
			self.melee.animname = animscripts\utility::lookupanim("melee","aivai_coverleft_attackerwins_attack");
			var_00.melee.animname = animscripts\utility::lookupanim("melee","aivai_coverleft_attackerwins_defend");
			var_00.melee.surviveanimname = animscripts\utility::lookupanim("melee","aivai_coverleft_attackerwins_defend_survive");
		}
		else
		{
			self.melee.animname = animscripts\utility::lookupanim("melee","aivai_coverleft_defenderwins_attack");
			self.melee.surviveanimname = animscripts\utility::lookupanim("melee","aivai_coverleft_defenderwins_attack_survive");
			var_00.melee.animname = animscripts\utility::lookupanim("melee","aivai_coverleft_defenderwins_defend");
		}
	}
	else if(self.melee.winner)
	{
		self.melee.animname = animscripts\utility::lookupanim("melee","aivai_coverright_attackerwins_attack");
		var_00.melee.animname = animscripts\utility::lookupanim("melee","aivai_coverright_attackerwins_defend");
	}
	else
	{
		self.melee.animname = animscripts\utility::lookupanim("melee","aivai_coverright_defenderwins_attack");
		var_00.melee.animname = animscripts\utility::lookupanim("melee","aivai_coverright_defenderwins_defend");
	}

	self.melee.startpos = getstartorigin(var_00.covernode.origin,var_00.covernode.angles,self.melee.animname);
	self.melee.startangles = (var_00.covernode.angles[0],angleclamp180(var_00.covernode.angles[1] + 180),var_00.covernode.angles[2]);
	var_00.melee.faceyaw = animscripts\utility::getnodeforwardyaw(var_00.covernode);
	self.melee.starttotargetcornerangles = var_00.covernode.angles;
	if(!melee_updateandvalidatestartpos())
	{
		self.melee.starttotargetcornerangles = undefined;
		return 0;
	}

	return 1;
}

//Function Number: 29
melee_aivsai_specialcover_canexecute()
{
	if(isdefined(self.h1_melee_animations_enabled) && !self.h1_melee_animations_enabled)
	{
		return 0;
	}

	var_00 = self.melee.target.covernode;
	if(!isdefined(var_00))
	{
		return 0;
	}

	if(distancesquared(var_00.origin,self.melee.target.origin) > 16 && isdefined(self.melee.target.a.covermode) && self.melee.target.a.covermode != "hide" && self.melee.target.a.covermode != "lean")
	{
		return 0;
	}

	var_01 = vectortoangles(self.origin - var_00.origin);
	var_02 = angleclamp180(var_00.angles[1] - var_01[1]);
	var_03 = var_00.type;
	if(var_03 == "Cover Multi")
	{
		var_03 = animscripts\utility::getcovermultipretendtype(var_00);
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

//Function Number: 30
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

//Function Number: 31
melee_aivsai_schedulenotetracklink(param_00)
{
	self.melee.syncnotetrackent = param_00;
	param_00.melee.syncnotetrackent = undefined;
}

//Function Number: 32
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
	self.melee.linked = 1;
	param_00.melee.linked = 1;
	self linktoblendtotag(param_00,"tag_sync",1,1);
}

//Function Number: 33
melee_aivsai_main()
{
	if(!melee_aivsai_getinposition())
	{
		self.nextmeleechargetime = gettime() + 1500;
		self.nextmeleechargetarget = self.melee.target;
		return;
	}

	var_00 = self.melee.target;
	if(!animhasnotetrack(self.melee.animname,"sync"))
	{
		return;
	}

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
	if(animscripts\utility::usingsidearm())
	{
		maps\_utility::forceuseweapon(self.primaryweapon,"primary");
		self.lastweapon = self.primaryweapon;
	}

	if(var_00 animscripts\utility::usingsidearm())
	{
		var_00 maps\_utility::forceuseweapon(var_00.primaryweapon,"primary");
		var_00.lastweapon = var_00.primaryweapon;
	}

	self.melee.weapon = self.weapon;
	self.melee.weaponslot = animscripts\utility::getcurrentweaponslotname();
	var_00.melee.weapon = var_00.weapon;
	var_00.melee.weaponslot = var_00 animscripts\utility::getcurrentweaponslotname();
	self.melee.inprogress = 1;
	var_00 animcustom(::melee_aivsai_execute,::melee_endscript);
	var_00 thread melee_aivsai_animcustominterruptionmonitor(self);
	self.melee.target = undefined;
	melee_aivsai_execute();
}

//Function Number: 34
melee_aivsai_animcustominterruptionmonitor(param_00)
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

//Function Number: 35
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

//Function Number: 36
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

//Function Number: 37
melee_aivsai_getinposition_finalize(param_00)
{
	melee_stopmovement();
	if(self.melee.precisepositioning)
	{
		self forceteleport(self.melee.startpos,self.melee.startangles);
		wait(0.05);
	}
	else
	{
		self orientmode("face angle",self.melee.startangles[1]);
		wait(0.05);
	}

	return melee_aivsai_getinposition_updateandvalidatetarget(param_00);
}

//Function Number: 38
melee_aivsai_getinposition()
{
	if(!melee_isvalid())
	{
		return 0;
	}

	melee_startmovement();
	self clearanim(%body,0.2);
	self setanimknoball(animscripts\run::getrunanim(),%body,1,0.2);
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
		wait(0.05);
	}

	melee_stopmovement();
	return 0;
}

//Function Number: 39
melee_aivsai_execute()
{
	self endon("killanimscript");
	self endon("end_melee");
	self notify("melee_aivsai_execute");
	self animmode("zonly_physics");
	self.a.special = "none";
	self.specialdeathfunc = undefined;
	thread melee_droppedweaponmonitorthread();
	thread melee_partnerendedmeleemonitorthread();
	if(isdefined(self.melee.faceyaw))
	{
		self orientmode("face angle",self.melee.faceyaw);
	}
	else
	{
		self orientmode("face current");
	}

	self.a.pose = "stand";
	self clearanim(%body,0.2);
	if(isdefined(self.melee.death))
	{
		melee_disableinterruptions();
	}

	self setflaggedanimknoballrestart("meleeAnim",self.melee.animname,%body,1,0.2);
	melee_playfacialanim(self.melee.animname);
	var_00 = animscripts\shared::donotetracks("meleeAnim",::melee_handlenotetracks);
	if(var_00 == "melee_death" && isdefined(self.melee.survive) || isdefined(self.magic_bullet_shield) && self.magic_bullet_shield)
	{
		melee_droppedweaponrestore();
		self setflaggedanimknoballrestart("meleeAnim",self.melee.surviveanimname,%body,1,0.2);
		melee_playfacialanim(self.melee.surviveanimname);
		var_00 = animscripts\shared::donotetracks("meleeAnim",::melee_handlenotetracks);
	}

	if(isdefined(self.melee) && isdefined(self.melee.death))
	{
		self kill();
	}

	self.keepclaimednode = 0;
}

//Function Number: 40
melee_disableinterruptions()
{
	self.melee.wasallowingpain = self.allowpain;
	self.melee.wasflashbangimmune = self.flashbangimmunity;
	maps\_utility::disable_pain();
	maps\_utility::setflashbangimmunity(1);
}

//Function Number: 41
melee_needsweaponswap()
{
	return isdefined(self.melee.weapon) && self.melee.weapon != "none" && self.weapon != self.melee.weapon;
}

//Function Number: 42
melee_droppedweaponrestore()
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
	if(isdefined(self.melee.droppedweaponent))
	{
		self.melee.droppedweaponent delete();
		self.melee.droppedweaponent = undefined;
	}
}

//Function Number: 43
melee_droppedweaponmonitorthread()
{
	self endon("killanimscript");
	self endon("end_melee");
	self waittill("weapon_dropped",var_00);
	if(isdefined(var_00))
	{
		self.melee.droppedweaponent = var_00;
	}
}

//Function Number: 44
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

//Function Number: 45
melee_partnerendedmeleemonitorthread()
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

//Function Number: 46
melee_unlink()
{
	if(!isdefined(self.melee.linked))
	{
		return;
	}

	if(isdefined(self.syncedmeleetarget))
	{
		self.syncedmeleetarget melee_unlinkinternal();
	}

	melee_unlinkinternal();
}

//Function Number: 47
melee_unlinkinternal()
{
	self unlink();
	self.syncedmeleetarget = undefined;
	if(!isalive(self))
	{
		return;
	}

	self.melee.linked = undefined;
	self animmode("zonly_physics");
	self orientmode("face angle",self.angles[1]);
}

//Function Number: 48
melee_handlenotetracks_unsync()
{
	melee_unlink();
	self.melee.unsynchappened = 1;
	if(isdefined(self.melee.partner) && isdefined(self.melee.partner.melee))
	{
		self.melee.partner.melee.unsynchappened = 1;
	}
}

//Function Number: 49
melee_handlenotetracks_shoulddieafterunsync()
{
	if(animhasnotetrack(self.melee.animname,"melee_death"))
	{
		return 0;
	}

	return isdefined(self.melee.death);
}

//Function Number: 50
melee_handlenotetracks_death(param_00)
{
	if(isdefined(param_00) && param_00)
	{
		self.melee.interruptdeath = 1;
		return;
	}

	self.melee.animateddeath = 1;
}

//Function Number: 51
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
		var_02 = isdefined(self.magic_bullet_shield) && self.magic_bullet_shield;
		if(isdefined(self.melee.survive) || var_02)
		{
			if(var_02)
			{
				self.melee.death = undefined;
			}

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
		if(maps\_utility::hastag(self.model,"TAG_KNIFE_FX"))
		{
			playfxontag(level._effect["melee_knife_ai"],self,"TAG_KNIFE_FX");
		}
		else
		{
		}

		if(isdefined(self.melee.partner) && isdefined(self.melee.partner.melee))
		{
			self.melee.partner melee_handlenotetracks_death(1);
			return;
		}

		return;
	}
}

//Function Number: 52
melee_deathhandler_regular()
{
	self endon("end_melee");
	animscripts\shared::dropallaiweapons();
	return 0;
}

//Function Number: 53
melee_deathhandler_delayed()
{
	self endon("end_melee");
	animscripts\notetracks::donotetrackswithtimeout("meleeAnim",10);
	animscripts\shared::dropallaiweapons();
	self startragdoll();
	return 1;
}

//Function Number: 54
melee_endscript_checkdeath()
{
	if(!isalive(self) && isdefined(self.melee.death))
	{
		if(isdefined(self.melee.animateddeath))
		{
			self.deathfunction = ::melee_deathhandler_delayed;
			return;
		}

		self.deathfunction = ::melee_deathhandler_regular;
	}
}

//Function Number: 55
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

//Function Number: 56
melee_endscript_checkweapon()
{
	if(isdefined(self.melee.hasknife))
	{
		self detach("weapon_parabolic_knife","TAG_INHAND",1);
	}

	if(isalive(self))
	{
		melee_droppedweaponrestore();
	}
}

//Function Number: 57
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

//Function Number: 58
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
	melee_clearfacialanim();
}

//Function Number: 59
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

//Function Number: 60
melee_releasemutex(param_00)
{
	self.melee = undefined;
	if(isdefined(param_00))
	{
		param_00.melee = undefined;
	}
}

//Function Number: 61
melee_playfacialanim(param_00)
{
	self.facialidx = animscripts\face::playfacialanim(param_00,"pain",self.facialidx);
}

//Function Number: 62
melee_clearfacialanim()
{
	self.facialidx = undefined;
	self clearanim(%head,0.2);
}