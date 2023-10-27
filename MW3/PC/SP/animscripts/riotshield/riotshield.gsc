/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\riotshield\riotshield.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 28
 * Decompile Time: 478 ms
 * Timestamp: 10/27/2023 2:17:19 AM
*******************************************************************/

//Function Number: 1
func_3AB4()
{
	level.notetracks["detach shield"] = ::func_3AB5;
	animscripts/init_move_transitions::func_2082();
	level.var_1164["riotshield"] = [];
	level.var_1164["riotshield"][1] = %riotshield_run_approach_1;
	level.var_1164["riotshield"][2] = %riotshield_run_approach_2;
	level.var_1164["riotshield"][3] = %riotshield_run_approach_3;
	level.var_1164["riotshield"][4] = %riotshield_run_approach_4;
	level.var_1164["riotshield"][6] = %riotshield_run_approach_6;
	level.var_1164["riotshield"][7] = undefined;
	level.var_1164["riotshield"][8] = %riotshield_walk2crouch_8;
	level.var_1164["riotshield"][9] = undefined;
	level.var_1164["riotshield_crouch"] = [];
	level.var_1164["riotshield_crouch"][1] = %riotshield_walk_approach_1;
	level.var_1164["riotshield_crouch"][2] = %riotshield_walk_approach_2;
	level.var_1164["riotshield_crouch"][3] = %riotshield_walk_approach_3;
	level.var_1164["riotshield_crouch"][4] = %riotshield_walk_approach_4;
	level.var_1164["riotshield_crouch"][6] = %riotshield_walk_approach_6;
	level.var_1164["riotshield_crouch"][7] = undefined;
	level.var_1164["riotshield_crouch"][8] = %riotshield_walk2crouch_8;
	level.var_1164["riotshield_crouch"][9] = undefined;
	var_00 = [];
	for(var_01 = 0;var_01 < var_7B.size;var_01++ = "riotshield_crouch")
	{
		var_02 = var_7B[var_01];
		for(var_03 = 1;var_03 <= 9;var_03++ = var_7B[1])
		{
			if(var_03 == 5)
			{
				continue;
			}

			if(isdefined(level.var_1164[var_02][var_03]))
			{
				level.var_1186[var_02][var_03] = getmovedelta(level.var_1164[var_02][var_03],0,1);
			}
		}
	}

	level.var_1187["riotshield_crouch"][1] = 45;
	level.var_1187["riotshield_crouch"][2] = 0;
	level.var_1187["riotshield_crouch"][3] = -45;
	level.var_1187["riotshield_crouch"][4] = 90;
	level.var_1187["riotshield_crouch"][6] = -90;
	level.var_1187["riotshield_crouch"][8] = 180;
	level.var_1187["riotshield"][1] = 45;
	level.var_1187["riotshield"][2] = 0;
	level.var_1187["riotshield"][3] = -45;
	level.var_1187["riotshield"][4] = 90;
	level.var_1187["riotshield"][6] = -90;
	level.var_1187["riotshield"][8] = 180;
	level.var_1166["riotshield"] = "crouch";
	level.var_1166["riotshield_crouch"] = "crouch";
	animscripts/combat_utility::func_238B(%riotshield_crouch_grenade_toss,(-3.20014,1.7098,55.6886));
}

//Function Number: 2
func_3AB5(param_00,param_01)
{
	animscripts/shared::func_23C8(self.secondaryweapon);
	self.secondaryweapon = "none";
	if(isalive(self))
	{
		func_3AD4();
	}
}

//Function Number: 3
func_3AB6()
{
	if(self.a.pose == "crouch")
	{
		return "riotshield_crouch";
	}

	return "riotshield";
}

//Function Number: 4
func_3AB7(param_00)
{
	return 1;
}

//Function Number: 5
func_3AB8()
{
	animscripts/shared::func_C9B(self.secondaryweapon,"left",0);
	self initriotshieldhealth(self.secondaryweapon);
	self.var_23C2 = 0;
	thread func_3AD5();
	self.subclass = "riotshield";
	self.var_1193 = ::func_3AB6;
	self.var_118E = ::func_3AB7;
	self.var_1195 = 1;
	self.var_1194 = 1;
	self.pathrandompercent = 0;
	self.interval = 0;
	self.var_1089 = 1;
	self.no_pistol_switch = 1;
	self.dontshootwhilemoving = 1;
	self.disablebulletwhizbyreaction = 1;
	self.var_1106 = 1;
	self.neversprintforvariation = 1;
	self.combatmode = "no_cover";
	self.fixednode = 0;
	self.maxfaceenemydist = 1500;
	self.var_1143 = 1;
	self.var_1017 = squared(256);
	self.var_10D3 = 1;
	self.var_23CD = 1;
	if(level.gameskill < 1)
	{
		self.shieldbulletblocklimit = randomintrange(4,8);
	}
	else
	{
		self.shieldbulletblocklimit = randomintrange(8,12);
	}

	self.var_3ABA = 0;
	self.var_3ABB = 0;
	self.walkdist = 500;
	self.walkdistfacingmotion = 500;
	self.grenadeawareness = 1;
	self.var_772 = 0.5;
	self.var_770 = 1;
	self.a.var_113C = "crouch";
	self.minexposedgrenadedist = 400;
	self.ignoresuppression = 1;
	self.var_1010 = ::func_3ABD;
	self.var_1026 = ::func_3ABE;
	maps\_utility::disable_turnanims();
	maps\_utility::disable_surprise();
	maps\_utility::disable_cqbwalk();
	func_3AC9();
	if(level.gameskill < 1)
	{
		self.bullet_resistance = 30;
	}
	else
	{
		self.bullet_resistance = 40;
	}

	maps\_utility::add_damage_function(::maps\_spawner::bullet_resistance);
	maps\_utility::add_damage_function(::animscripts/pain::func_D82);
}

//Function Number: 6
func_3ABC()
{
	if(!animscripts/melee::func_102B())
	{
		return 0;
	}

	var_00 = getmovedelta(%riotshield_basha_attack,0,1);
	var_01 = lengthsquared(var_00);
	if(distancesquared(self.origin,self.melee.target.origin) < var_01)
	{
		return 1;
	}

	animscripts/melee::func_102E();
	var_02 = 0.1;
	var_03 = 1;
	for(;;)
	{
		if(!animscripts/melee::func_102B())
		{
			return 0;
		}

		if(var_03)
		{
			self.a.pose = "stand";
			self setflaggedanimknoball("chargeanim",%riotshield_sprint,%body,1,0.2,1);
			var_03 = 0;
		}

		self orientmode("face point",self.melee.target.origin);
		animscripts/notetracks::func_D4F(var_02,"chargeanim");
		var_04 = distancesquared(self.origin,self.melee.target.origin);
		if(var_04 < var_01)
		{
			break;
		}

		if(gettime() >= self.melee.var_1028)
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 7
func_3ABD()
{
	self animmode("zonly_physics");
	animscripts/melee::func_1027();
	for(;;)
	{
		if(!func_3ABC())
		{
			self.var_101B = gettime() + 1500;
			self.var_101C = self.melee.target;
			break;
		}

		animscripts/battlechatter_ai::func_B37();
		self orientmode("face point",self.melee.target.origin);
		self setflaggedanimknoballrestart("meleeanim",%riotshield_bash_vs_player,%body,1,0.2,1);
		self.melee.var_100E = 1;
		if(!animscripts/melee::func_102A())
		{
			animscripts/melee::func_1021(self.melee.target);
			break;
		}

		self animmode("none");
	}

	self animmode("none");
}

//Function Number: 8
func_3ABE()
{
	var_00 = self.melee.target;
	if(self.subclass == "riotshield" && var_00.subclass == "riotshield")
	{
		return 0;
	}

	animscripts/melee::func_103C();
	var_01 = vectortoangles(var_00.origin - self.origin);
	var_02 = angleclamp180(var_00.angles[1] - var_01[1]);
	if(abs(var_02) > 100)
	{
		if(self.melee.winner)
		{
			if(self.subclass == "riotshield")
			{
				self.melee.animname = %riotshield_basha_attack;
				var_00.melee.animname = %riotshield_basha_defend;
				var_00.melee.var_1033 = %riotshield_basha_defend_survive;
			}
			else
			{
				self.melee.animname = %riotshield_bashb_defend;
				var_00.melee.animname = %riotshield_bashb_attack;
			}
		}
		else if(self.subclass == "riotshield")
		{
			self.melee.animname = %riotshield_bashb_attack;
			var_00.melee.animname = %riotshield_bashb_defend;
		}
		else
		{
			self.melee.animname = %riotshield_basha_defend;
			var_00.melee.animname = %riotshield_basha_attack;
		}
	}
	else
	{
		return 0;
	}

	self.melee.startpos = getstartorigin(var_00.origin,var_00.angles,self.melee.animname);
	self.melee.var_103B = (var_00.angles[0],angleclamp180(var_00.angles[1] + 180),var_00.angles[2]);
	self.lockorientation = 0;
	var_00.lockorientation = 0;
	return animscripts/melee::func_1013();
}

//Function Number: 9
func_3ABF()
{
	if(isdefined(self.disableexits))
	{
		return;
	}

	self orientmode("face angle",self.angles[1]);
	self animmode("zonly_physics",0);
	if(self.a.pose == "crouch")
	{
		if(isdefined(self.sprint) || isdefined(self.var_3AC0))
		{
			var_00 = %riotshield_crouch2stand;
		}
		else
		{
			var_00 = %riotshield_crouch2walk;
		}

		var_01 = randomfloatrange(0.9,1.1);
		self setflaggedanimknoballrestart("startmove",var_00,%body,1,0.1,var_01);
		animscripts/shared::donotetracks("startmove");
		self clearanim(%riotshield_crouch2walk,0.5);
	}

	if(isdefined(self.sprint) || isdefined(self.var_3AC0))
	{
		self allowedstances("stand","crouch");
		self.a.pose = "stand";
	}

	self orientmode("face default");
	self animmode("normal",0);
	thread func_3AC3();
}

//Function Number: 10
func_3AC1()
{
	if(self.var_788 == "move" && self.a.pose == "crouch")
	{
		self clearanim(%root,0.2);
		var_00 = randomfloatrange(0.9,1.1);
		self animmode("zonly_physics");
		self setflaggedanimknoballrestart("endmove",%riotshield_walk2crouch_8,%body,1,0.2,var_00);
		animscripts/shared::donotetracks("endmove");
		self animmode("normal");
	}

	self allowedstances("crouch");
}

//Function Number: 11
func_3AC2()
{
	func_3AC1();
	self.pushable = 0;
	thread func_3AC3();
}

//Function Number: 12
func_3AC3()
{
	self endon("killanimscript");
	for(;;)
	{
		self waittill("bullet_hitshield");
		var_00 = gettime();
		if(var_00 - self.var_3ABB > 500)
		{
			self.var_3ABA = 0;
		}
		else
		{
			self.var_3ABA++;
		}

		self.var_3ABB = var_00;
		if(self.var_3ABA > self.shieldbulletblocklimit)
		{
			self dodamage(1,(0,0,0));
		}

		if(common_scripts\utility::cointoss())
		{
			var_01 = %riotshield_reacta;
		}
		else
		{
			var_01 = %riotshield_reactb;
		}

		self notify("new_hit_react");
		self setflaggedanimrestart("hitreact",var_01,1,0.1,1);
		thread func_3AC4();
	}
}

//Function Number: 13
func_3AC4()
{
	self endon("killanimscript");
	self endon("new_hit_react");
	self waittillmatch("end","hitreact");
	self clearanim(%riotshield_react,0.1);
}

//Function Number: 14
func_3AC5()
{
	if(self.a.pose == "stand")
	{
		self clearanim(%root,0.2);
		self setflaggedanimknoballrestart("trans",%riotshield_walk2crouch_8,%body,1,0.2,1.2);
		animscripts/shared::donotetracks("trans");
	}

	if(isdefined(self.var_73C))
	{
		var_00 = 1;
		var_01 = self.var_73C.origin - self.origin;
		if(isdefined(self.enemy))
		{
			var_02 = self.enemy.origin - self.origin;
			if(vectordot(var_01,var_02) < 0)
			{
				var_00 = 0;
			}
		}

		if(var_00)
		{
			var_03 = angleclamp180(self.angles[1] - vectortoyaw(var_01));
			if(!isdefined(self.var_F72))
			{
				self.var_F72 = 55;
			}

			while(abs(var_03) > self.var_F72)
			{
				if(!isdefined(self.a.array))
				{
					animscripts/combat::func_1108();
				}

				if(!animscripts/combat::func_F73(var_03))
				{
					break;
				}

				var_03 = angleclamp180(self.angles[1] - vectortoyaw(var_01));
			}
		}
	}

	self setanimknoball(%riotshield_crouch_aim_5,%body,1,0.2,1);
	self setflaggedanimknoballrestart("grenadecower",%riotshield_crouch_idle_add,%add_idle,1,0.2,self.var_10F7);
	animscripts/shared::donotetracks("grenadecower");
}

//Function Number: 15
func_3AC6()
{
	self notify("flashed");
	if(!isdefined(self.a.var_D29))
	{
		var_00 = randomfloatrange(0.9,1.1);
		self.var_772 = 1;
		var_01 = [];
		var_02 = var_7B[randomint(var_7B.size)];
		self setflaggedanimknoballrestart("flashanim",var_02,%body,1,0.1,var_01);
		self.minpaindamage = 1000;
		animscripts/shared::donotetracks("flashanim");
	}
	else
	{
		wait 0.1;
	}

	self.minpaindamage = 0;
	if(isdefined(self.subclass) && self.subclass == "riotshield")
	{
		self.var_772 = 0.5;
	}
}

//Function Number: 16
func_3AC7()
{
	self.a.pose = "crouch";
	if(animscripts/utility::func_C95())
	{
		maps\_utility::forceuseweapon(self.primaryweapon,"primary");
	}

	if(!isdefined(self.a.var_D29))
	{
		var_00 = randomfloatrange(0.8,1.15);
		self.var_772 = 1;
		if((self.var_723 < -120 || self.var_723 > 120) && isexplosivedamagemod(self.var_726))
		{
			var_01 = [];
			var_02 = var_7B[randomint(var_7B.size)];
			self setflaggedanimknoballrestart("painanim",var_02,%body,1,0.2,var_01);
			self.minpaindamage = 1000;
		}
		else
		{
			self setflaggedanimknoballrestart("painanim",%riotshield_crouch_pain,%body,1,0.2,var_01);
		}

		animscripts/shared::donotetracks("painanim");
	}
	else
	{
		wait 0.1;
	}

	self.minpaindamage = 0;
	if(isdefined(self.subclass) && self.subclass == "riotshield")
	{
		self.var_772 = 0.5;
	}
}

//Function Number: 17
func_3AC8()
{
	if(isdefined(self.a.var_D29) && self.a.pose == "crouch")
	{
		var_00 = [];
		var_01 = var_7B[randomint(var_7B.size)];
		animscripts/death::func_D56(var_01);
		return 1;
	}

	if(self.var_788 == "pain" || self.var_788 == "flashed")
	{
		var_02 = randomint(2) == 0;
	}
	else
	{
		var_02 = 1;
	}

	if(var_02)
	{
		if(common_scripts\utility::cointoss())
		{
			var_01 = %riotshield_crouch_death;
		}
		else
		{
			var_01 = %riotshield_crouch_death_fallback;
		}

		animscripts/death::func_D56(var_02);
		return 1;
	}

	self.a.pose = "crouch";
	return 0;
}

//Function Number: 18
func_3AC9()
{
	var_00 = [];
	self.custommoveanimset["run"] = var_7B;
	self.custommoveanimset["walk"] = var_7B;
	self.custommoveanimset["cqb"] = var_7B;
	self.var_C89 = [];
	self.var_C89["crouch"] = %riotshield_crouch_aim_5;
	self.var_C89["crouch_add"] = %riotshield_crouch_idle_add;
	self.var_C89["stand"] = %riotshield_crouch_aim_5;
	self.var_C89["stand_add"] = %riotshield_crouch_idle_add;
	self.a.pose = "crouch";
	self allowedstances("crouch");
	var_7B = level.animsets.var_C78;
	animscripts/animset::func_C81(var_7B);
	animscripts/animset::func_C84(var_7B);
	self.var_FBA = ::func_3ACB;
	self.var_D18 = ::func_3AC7;
	self.var_D4B = ::func_3AC8;
	self.var_2095 = ::func_3AC6;
	self.var_3ACA = ::func_3AC5;
	self.custommovetransition = ::func_3ABF;
	self.var_11A1 = 1;
	common_scripts\utility::set_exception("exposed",::func_3AC2);
}

//Function Number: 19
func_3ACB(param_00)
{
	if(isdefined(self.var_73C))
	{
		return "stand";
	}

	return animscripts/utility::func_10AF(param_00);
}

//Function Number: 20
riotshield_sprint_on()
{
	self.maxfaceenemydist = 128;
	self.sprint = 1;
	self orientmode("face default");
	self.lockorientation = 0;
	self.walkdist = 32;
	self.walkdistfacingmotion = 32;
}

//Function Number: 21
riotshield_fastwalk_on()
{
	self.maxfaceenemydist = 128;
	self.var_3AC0 = 1;
	self.walkdist = 32;
	self.walkdistfacingmotion = 32;
}

//Function Number: 22
riotshield_sprint_off()
{
	self.maxfaceenemydist = 1500;
	self.walkdist = 500;
	self.walkdistfacingmotion = 500;
	self.sprint = undefined;
	self allowedstances("crouch");
}

//Function Number: 23
riotshield_fastwalk_off()
{
	self.maxfaceenemydist = 1500;
	self.walkdist = 500;
	self.walkdistfacingmotion = 500;
	self.var_3AC0 = undefined;
	self allowedstances("crouch");
}

//Function Number: 24
func_3AD0()
{
}

//Function Number: 25
func_3AD1()
{
	if(self.script == "move")
	{
		self animcustom(::func_3AD0);
	}

	self.custommovetransition = ::func_3AD2;
}

//Function Number: 26
func_3AD2()
{
	self.custommovetransition = ::func_3ABF;
	self animmode("zonly_physics",0);
	self orientmode("face current");
	if(!isdefined(self.var_3AD3) && isdefined(self.enemy) && vectordot(self.var_773,anglestoforward(self.angles)) < 0)
	{
		var_00 = %riotshield_crouch2walk_2flee;
	}
	else
	{
		var_00 = %riotshield_crouch2stand_shield_drop;
	}

	var_01 = randomfloatrange(0.85,1.1);
	self setflaggedanimknoball("fleeanim",var_00,%root,1,0.1,var_01);
	animscripts/shared::donotetracks("fleeanim");
	self.maxfaceenemydist = 32;
	self.lockorientation = 0;
	self orientmode("face default");
	self animmode("normal",0);
	animscripts/shared::donotetracks("fleeanim");
	self clearanim(var_00,0.2);
	self.maxfaceenemydist = 128;
}

//Function Number: 27
func_3AD4()
{
	self.subclass = "regular";
	self.combatmode = "cover";
	self.var_1193 = undefined;
	self.var_118E = undefined;
	self.var_1195 = undefined;
	self.var_1194 = undefined;
	self.pathrandompercent = 0;
	self.interval = 80;
	self.var_1089 = undefined;
	self.no_pistol_switch = undefined;
	self.dontshootwhilemoving = undefined;
	self.disablebulletwhizbyreaction = undefined;
	self.var_1106 = undefined;
	self.neversprintforvariation = undefined;
	self.maxfaceenemydist = 128;
	self.var_1143 = undefined;
	self.var_1017 = undefined;
	self.var_10D3 = undefined;
	self.var_23CD = undefined;
	self.pathenemyfightdist = 128;
	self.pathenemylookahead = 128;
	self.walkdist = 256;
	self.walkdistfacingmotion = 64;
	self.lockorientation = 0;
	self.var_772 = 1;
	self.var_770 = 0;
	self.ignoresuppression = 0;
	self.sprint = undefined;
	self allowedstances("stand","crouch","prone");
	self.var_1010 = undefined;
	self.var_1026 = undefined;
	maps\_utility::enable_turnanims();
	self.bullet_resistance = undefined;
	maps\_utility::remove_damage_function(::maps\_spawner::bullet_resistance);
	maps\_utility::remove_damage_function(::animscripts/pain::func_D82);
	animscripts/animset::func_C87();
	self.var_FBA = ::animscripts/utility::func_10AF;
	self.var_D18 = undefined;
	self.var_D4B = undefined;
	self.var_2095 = undefined;
	self.var_3ACA = undefined;
	self.custommovetransition = undefined;
	self.var_11A1 = undefined;
	common_scripts\utility::clear_exception("exposed");
	common_scripts\utility::clear_exception("stop_immediate");
}

//Function Number: 28
func_3AD5()
{
	self endon("death");
	self waittill("riotshield_damaged");
	self.var_23C3 = 1;
	animscripts/shared::func_23C1();
	self.var_23C2 = 1;
	animscripts/shared::func_23C4();
}