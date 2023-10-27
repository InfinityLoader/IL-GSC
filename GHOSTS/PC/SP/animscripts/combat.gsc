/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\combat.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 68
 * Decompile Time: 1129 ms
 * Timestamp: 10/27/2023 1:23:32 AM
*******************************************************************/

//Function Number: 1
init_animset_combat()
{
	var_00 = [];
	var_00["surprise_stop"] = %surprise_stop_v1;
	var_00["trans_to_combat"] = %casual_stand_idle_trans_out;
	var_00["drop_rpg_stand"] = %rpg_stand_throw;
	var_00["drop_rpg_crouch"] = %rpg_crouch_throw;
	var_00["pistol_to_primary"] = %pistol_stand_switch;
	var_00["primary_to_pistol"] = %pistol_stand_pullout;
	var_00["rpg_death"] = %rpg_stand_death;
	var_00["rpg_death_stagger"] = %rpg_stand_death_stagger;
	level.archetypes["soldier"]["combat"] = var_00;
}

//Function Number: 2
func_4FDD()
{
	if(isdefined(self.var_5613))
	{
	}

	if(isdefined(self.var_2214))
	{
		if(isdefined(self.var_2214["combat"]))
		{
			[[ self.var_2214["combat"] ]]();
		}
	}

	self endon("killanimscript");
	[[ self.exception["exposed"] ]]();
	animscripts/utility::func_4622("combat");
	self.a.arrivaltype = undefined;
	if(isdefined(self.node) && self.node.type == "Ambush" && self nearnode(self.node))
	{
		self.var_CFA = self.node;
	}

	func_8270();
	dofriendlyfirereaction();
	if(isdefined(self.var_78ED))
	{
		animscripts/stop::func_78EE();
	}

	func_70EF();
	exposedcombatmainloop();
	self notify("stop_deciding_how_to_shoot");
}

//Function Number: 3
end_script()
{
	self.var_CFA = undefined;
	func_1E23();
}

//Function Number: 4
dofriendlyfirereaction()
{
	if(self.team != "allies")
	{
	}

	if(self ismovesuppressed() && self.prevscript == "move" && self.a.var_60B1 == "stand" && !isdefined(self.var_27AE))
	{
		if(isdefined(self.enemy) && distancesquared(self.origin,self.enemy.origin) < squared(128))
		{
		}

		if(!isdefined(self.a.var_ED8))
		{
		}

		if(isdefined(self.a.var_ED8["surprise_stop"]))
		{
			var_00 = animscripts/utility::animarray("surprise_stop");
		}
		else if(self.swimmer)
		{
			var_00 = animscripts/swim::func_3C1D("surprise_stop");
			if(!isdefined(var_00))
			{
			}
		}
		else
		{
			var_00 = animscripts/utility::lookupanim("combat","surprise_stop");
		}

		func_6605();
		self setflaggedanimknoballrestart("react",var_00,%root,1,0.2,self.animplaybackrate);
		combat_playfacialanim(var_00,"run");
		animscripts/shared::func_2986("react");
	}
}

//Function Number: 5
func_8270()
{
	if(isdefined(self.var_78ED) || isdefined(self.customidleanimset))
	{
	}

	if(isdefined(self.enemy) && distancesquared(self.origin,self.enemy.origin) < 262144)
	{
	}

	if(self.prevscript == "stop" && !animscripts/utility::func_48A0() && self.a.var_60B1 == "stand")
	{
		func_6605();
		var_00 = animscripts/utility::lookupanim("combat","trans_to_combat");
		self setflaggedanimknoballrestart("transition",var_00,%root,1,0.2,1.2 * self.animplaybackrate);
		combat_playfacialanim(var_00,"run");
		animscripts/shared::func_2986("transition");
	}
}

//Function Number: 6
func_70FE()
{
	if(self.a.var_60B1 == "stand")
	{
		animscripts/animset::func_6E41();
	}

	if(self.a.var_60B1 == "crouch")
	{
		animscripts/animset::set_animarray_crouching();
	}

	if(self.a.var_60B1 == "prone")
	{
		animscripts/animset::func_6E3F();
	}
}

//Function Number: 7
func_70EF()
{
	if(animscripts/utility::func_87FE() && self isstanceallowed("stand"))
	{
		func_826F("stand");
	}

	func_70FE();
	func_6E22();
	thread func_7C70();
	self.var_616D = 0;
	self clearanim(%root,0.2);
	animscripts/combat_utility::func_71EA(0.2);
	thread animscripts/combat_utility::aimidlethread();
	self.a.var_51AA = "aim";
	func_252C();
}

//Function Number: 8
func_7C70()
{
	self endon("killanimscript");
	wait(0.2);
	self.a.var_5486 = "stop";
}

//Function Number: 9
func_6E84()
{
	if(self.swimmer)
	{
		if(animscripts/utility::func_4965())
		{
			self.upaimlimit = 90;
			self.downaimlimit = -90;
			self.rightaimlimit = 45;
			self.leftaimlimit = -45;
		}

		self.upaimlimit = 90;
		self.downaimlimit = -120;
	}
}

//Function Number: 10
func_6E7C(param_00)
{
	if(isdefined(param_00))
	{
		self setdefaultaimlimits(param_00);
	}
	else
	{
		self setdefaultaimlimits();
	}

	func_6E84();
}

//Function Number: 11
func_6E22()
{
	func_6E7C();
	if(self.a.var_60B1 == "stand" && !self.swimmer)
	{
		self.upaimlimit = 60;
		self.downaimlimit = -60;
	}

	self.var_84BC = self.defaultturnthreshold;
}

//Function Number: 12
func_71F9()
{
	thread animscripts/track::trackshootentorpos();
	thread func_63AE();
	thread animscripts/shoot_behavior::func_2439("normal");
	thread func_8D1E();
	func_660B();
	if(isdefined(self.a.var_4FDC))
	{
		animscripts/weaponlist::refillclip();
		self.a.var_4FDC = undefined;
	}

	self.a.dontcrouchtime = gettime() + randomintrange(500,1500);
}

//Function Number: 13
exposedcombatstopusingrpgcheck(param_00)
{
	if(animscripts/utility::func_87FA() && animscripts/utility::func_74AE(param_00))
	{
		if(self.a.var_60B1 != "stand" && self.a.var_60B1 != "crouch")
		{
			func_826F("crouch");
		}

		if(self.a.var_60B1 == "stand")
		{
			animscripts/shared::func_80AC(animscripts/utility::lookupanim("combat","drop_rpg_stand"));
		}
		else
		{
			animscripts/shared::func_80AC(animscripts/utility::lookupanim("combat","drop_rpg_crouch"));
		}

		self clearanim(%root,0.2);
		animscripts/combat_utility::func_2D52();
		func_70FE();
		animscripts/combat_utility::startfireandaimidlethread();
		return 1;
	}

	return 0;
}

//Function Number: 14
func_30FE(param_00)
{
	if(self.a.var_60B1 != "stand" && self isstanceallowed("stand"))
	{
		if(param_00 < 81225)
		{
			func_826F("stand");
			return 1;
		}

		if(func_79D0())
		{
			return 1;
		}
	}

	if(param_00 > 262144 && self.a.var_60B1 != "crouch" && self isstanceallowed("crouch") && !self.swimmer && !animscripts/utility::func_87FE() && !isdefined(self.heat) && gettime() >= self.a.dontcrouchtime && lengthsquared(self.shootentvelocity) < 10000)
	{
		if(!isdefined(self.var_7445) || sighttracepassed(self.origin + (0,0,36),self.var_7445,0,undefined))
		{
			func_826F("crouch");
			return 1;
		}
	}

	return 0;
}

//Function Number: 15
exposedcombatcheckreloadorusepistol(param_00)
{
	if(!animscripts/utility::func_87FE())
	{
		if(isdefined(self.var_34DC) && self.a.var_60B1 == "stand")
		{
			if(func_845E())
			{
				return 1;
			}
		}

		if(animscripts/combat_utility::issniper() && param_00 < 167772.2)
		{
			if(func_845E())
			{
				return 1;
			}
		}
	}

	if(animscripts/combat_utility::func_5596(0))
	{
		if(!animscripts/utility::func_87FE() && common_scripts\utility::func_1DE9() && !animscripts/utility::func_87FA() && animscripts/utility::usingprimary() && param_00 < 167772.2 && self isstanceallowed("stand"))
		{
			if(self.a.var_60B1 != "stand")
			{
				func_826F("stand");
				return 1;
			}

			if(func_845E())
			{
				return 1;
			}
		}

		if(func_3103(0))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 16
exposedcombatcheckputawaypistol(param_00)
{
	if(animscripts/utility::func_87FE() && self.a.var_60B1 == "stand" && !isdefined(self.var_34DC))
	{
		if(param_00 > 262144 || self.combatmode == "ambush_nodes_only" && !isdefined(self.enemy) || !self cansee(self.enemy))
		{
			func_7E22(animscripts/utility::lookupanim("combat","pistol_to_primary"));
		}
	}
}

//Function Number: 17
exposedcombatpositionadjust()
{
	if(isdefined(self.heat) && self nearclaimnodeandangle())
	{
		self safeteleport(self.nodeoffsetpos,self.node.angles);
	}
}

//Function Number: 18
func_3100()
{
	if(func_5597())
	{
		var_00 = 0.25;
		if(isdefined(self.var_7439) && !issentient(self.var_7439))
		{
			var_00 = 1.5;
		}

		var_01 = animscripts/shared::getpredictedaimyawtoshootentorpos(var_00);
		if(func_84BF(var_01))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 19
exposedcombatmainloop()
{
	self endon("killanimscript");
	func_71F9();
	func_6605(0);
	if(animscripts/utility::func_4965())
	{
		var_00 = (0,self.angles[1],0);
		self orientmode("face angle 3d",var_00);
	}
	else
	{
		self orientmode("face angle",self.angles[1]);
	}

	for(;;)
	{
		if(animscripts/utility::func_87FA())
		{
			self.var_237B = undefined;
		}

		animscripts/utility::func_86F6();
		if(waitforstancechange())
		{
			continue;
		}

		func_8403();
		exposedcombatpositionadjust();
		if(!isdefined(self.var_7445))
		{
			cantseeenemybehavior();
			continue;
		}

		func_660B();
		var_01 = lengthsquared(self.origin - self.var_7445);
		if(exposedcombatstopusingrpgcheck(var_01))
		{
			continue;
		}

		if(func_3100())
		{
			continue;
		}

		if(considerthrowgrenade())
		{
			continue;
		}

		if(exposedcombatcheckreloadorusepistol(var_01))
		{
			continue;
		}

		if(animscripts/utility::func_87FA() && self.a.var_60B1 != "crouch" && randomfloat(1) > 0.65)
		{
			self.var_237B = ::func_68B1;
		}

		exposedcombatcheckputawaypistol(var_01);
		if(func_30FE(var_01))
		{
			continue;
		}

		if(animscripts/combat_utility::aimedatshootentorpos())
		{
			shootuntilneedtoturn();
			animscripts/combat_utility::func_4204();
			continue;
		}

		func_3106();
	}
}

//Function Number: 20
func_3106()
{
	if(!isdefined(self.enemy) || !self cansee(self.enemy))
	{
		self endon("enemy");
		self endon("shoot_behavior_change");
		wait(0.2 + randomfloat(0.1));
		self waittill("do_slow_things");
	}

	wait(0.05);
}

//Function Number: 21
func_79D0()
{
	if(isdefined(self.enemy) && !self cansee(self.enemy) || !self canshootenemy() && sighttracepassed(self.origin + (0,0,64),self.enemy getshootatpos(),0,undefined))
	{
		self.a.dontcrouchtime = gettime() + 3000;
		func_826F("stand");
		return 1;
	}

	return 0;
}

//Function Number: 22
func_5597()
{
	var_00 = self.var_7445;
	if(!isdefined(var_00))
	{
		return 0;
	}

	var_01 = self.angles[1] - vectortoyaw(var_00 - self.origin);
	var_02 = distancesquared(self.origin,var_00);
	if(var_02 < 65536)
	{
		var_03 = sqrt(var_02);
		if(var_03 > 3)
		{
			var_01 = var_01 + asin(-3 / var_03);
		}
	}

	return animscripts/utility::absangleclamp180(var_01) > self.var_84BC;
}

//Function Number: 23
waitforstancechange()
{
	var_00 = self.a.var_60B1;
	if(isdefined(self.a.onback))
	{
		wait(0.1);
		return 1;
	}

	if(var_00 == "stand" && isdefined(self.heat))
	{
		return 0;
	}

	if(!self isstanceallowed(var_00))
	{
		var_01 = "crouch";
		if(var_00 == "crouch")
		{
			var_01 = "stand";
		}

		var_02 = "prone";
		if(var_00 == "prone")
		{
			var_01 = "stand";
			var_02 = "crouch";
		}

		if(self isstanceallowed(var_01))
		{
			if(var_00 == "stand" && animscripts/utility::func_87FE())
			{
				return 0;
			}

			func_826F(var_01);
			return 1;
		}
		else if(self isstanceallowed(var_02))
		{
			if(var_00 == "stand" && animscripts/utility::func_87FE())
			{
				return 0;
			}

			func_826F(var_02);
			return 1;
		}
		else
		{
		}
	}

	return 0;
}

//Function Number: 24
cantseeenemybehavior()
{
	if(self.a.var_60B1 != "stand" && self isstanceallowed("stand") && func_79D0())
	{
		return 1;
	}

	var_00 = gettime();
	self.a.dontcrouchtime = var_00 + 1500;
	if(isdefined(self.group) && isdefined(self.group.forward))
	{
		var_01 = angleclamp180(self.angles[1] - vectortoyaw(self.group.forward));
		if(func_84BF(var_01))
		{
			return 1;
		}
	}

	if(isdefined(self.node) && isdefined(level.var_489E[self.node.type]))
	{
		var_01 = angleclamp180(self.angles[1] - self.node.angles[1]);
		if(func_84BF(var_01))
		{
			return 1;
		}
	}
	else if((isdefined(self.enemy) && self seerecently(self.enemy,2)) || var_00 > self.a.var_6D18 + 1200)
	{
		var_01 = undefined;
		var_02 = self getanglestolikelyenemypath();
		if(isdefined(var_02))
		{
			var_01 = angleclamp180(self.angles[1] - var_02[1]);
		}
		else if(isdefined(self.node))
		{
			var_01 = angleclamp180(self.angles[1] - self.node.angles[1]);
		}
		else if(isdefined(self.enemy))
		{
			var_02 = vectortoangles(self lastknownpos(self.enemy) - self.origin);
			var_01 = angleclamp180(self.angles[1] - var_02[1]);
		}

		if(isdefined(var_01) && func_84BF(var_01))
		{
			return 1;
		}
	}
	else if(isdefined(self.heat) && self nearclaimnode())
	{
		var_01 = angleclamp180(self.angles[1] - self.node.angles[1]);
		if(func_84BF(var_01))
		{
			return 1;
		}
	}

	if(considerthrowgrenade())
	{
		return 1;
	}

	var_03 = self.a.var_55EA < var_00;
	var_04 = 0;
	if(var_03)
	{
		var_04 = 0.99999;
	}

	if(func_3103(var_04))
	{
		return 1;
	}

	if(var_03 && animscripts/utility::func_87FE())
	{
		if(func_7E22(animscripts/utility::lookupanim("combat","pistol_to_primary")))
		{
			return 1;
		}
	}

	cantseeenemywait();
	return 1;
}

//Function Number: 25
cantseeenemywait()
{
	self endon("shoot_behavior_change");
	wait(0.4 + randomfloat(0.4));
	self waittill("do_slow_things");
}

//Function Number: 26
func_660B()
{
	self.a.var_55EA = gettime() + randomintrange(2000,4000);
}

//Function Number: 27
func_84BF(param_00)
{
	if(param_00 < 0 - self.var_84BC)
	{
		if(self.a.var_60B1 == "prone")
		{
			animscripts/cover_prone::func_6204("crouch");
			animscripts/animset::set_animarray_crouching();
		}

		func_2A22("left",0 - param_00);
		maps\_gameskill::didsomethingotherthanshooting();
		return 1;
	}

	if(param_00 > self.var_84BC)
	{
		if(self.a.var_60B1 == "prone")
		{
			animscripts/cover_prone::func_6204("crouch");
			animscripts/animset::set_animarray_crouching();
		}

		func_2A22("right",param_00);
		maps\_gameskill::didsomethingotherthanshooting();
		return 1;
	}

	return 0;
}

//Function Number: 28
func_8D1E()
{
	self endon("killanimscript");
	self.shootentvelocity = (0,0,0);
	var_00 = undefined;
	var_01 = self.origin;
	var_02 = 0.15;
	for(;;)
	{
		if(isdefined(self.var_7439) && isdefined(var_00) && self.var_7439 == var_00)
		{
			var_03 = self.var_7439.origin;
			self.shootentvelocity = var_03 - var_01 * 1 / var_02;
			var_01 = var_03;
		}
		else
		{
			if(isdefined(self.var_7439))
			{
				var_01 = self.var_7439.origin;
			}
			else
			{
				var_01 = self.origin;
			}

			var_00 = self.var_7439;
			self.shootentvelocity = (0,0,0);
		}

		wait(var_02);
	}
}

//Function Number: 29
func_74CD()
{
	return 0;
}

//Function Number: 30
donotetrackswithendon(param_00)
{
	self endon("killanimscript");
	animscripts/shared::func_2986(param_00);
}

//Function Number: 31
func_311A()
{
	self endon("killanimscript");
	self notify("facing_enemy_immediately");
	self endon("facing_enemy_immediately");
	var_00 = 5;
	for(;;)
	{
		var_01 = 0 - animscripts/utility::func_3C8B();
		if(abs(var_01) < 2)
		{
			break;
		}

		if(abs(var_01) > var_00)
		{
			var_01 = var_00 * common_scripts\utility::sign(var_01);
		}

		self orientmode("face angle",self.angles[1] + var_01);
		wait(0.05);
	}

	self orientmode("face current");
	self notify("can_stop_turning");
}

//Function Number: 32
func_48A9(param_00)
{
	var_01 = getmovedelta(param_00,0,1);
	var_02 = self localtoworldcoords(var_01);
	return self isingoal(var_02) && self maymovetopoint(var_02);
}

//Function Number: 33
func_4874(param_00)
{
	var_01 = getmovedelta(param_00,0,1);
	var_02 = self localtoworldcoords(var_01);
	return self isingoal(var_02);
}

//Function Number: 34
func_2A22(param_00,param_01)
{
	var_02 = isdefined(self.var_7445);
	var_03 = 1;
	var_04 = 0.2;
	var_05 = isdefined(self.enemy) && !isdefined(self.var_84C0) && self seerecently(self.enemy,2) && distancesquared(self.enemy.origin,self.origin) < 262144;
	if(self.a.var_6D18 + 500 > gettime())
	{
		var_04 = 0.25;
		if(var_05)
		{
			thread func_311A();
		}
	}
	else if(var_05)
	{
		var_06 = 1 - distance(self.enemy.origin,self.origin) / 512;
		var_03 = 1 + var_06 * 1;
		if(var_03 > 2)
		{
			var_04 = 0.05;
		}
		else if(var_03 > 1.3)
		{
			var_04 = 0.1;
		}
		else
		{
			var_04 = 0.15;
		}
	}

	var_07 = 0;
	if(param_01 > 157.5)
	{
		var_07 = 180;
	}
	else if(param_01 > 112.5)
	{
		var_07 = 135;
	}
	else if(param_01 > 67.5)
	{
		var_07 = 90;
	}
	else
	{
		var_07 = 45;
	}

	var_08 = "turn_" + param_00 + "_" + var_07;
	var_09 = animscripts/utility::animarray(var_08);
	if(isdefined(self.var_84C0))
	{
		self animmode("angle deltas",0);
	}
	else if(isdefined(self.node) && isdefined(level.var_489C[self.node.type]) && distancesquared(self.origin,self.node.origin) < 256)
	{
		self animmode("angle deltas",0);
	}
	else if(func_4874(var_09))
	{
		func_6605();
	}
	else
	{
		self animmode("angle deltas",0);
	}

	self setanimknoball(%exposed_aiming,%body,1,var_04);
	if(!isdefined(self.var_84C0))
	{
		func_84B7(var_04);
	}

	self setanimlimited(%turn,1,var_04);
	if(isdefined(self.heat))
	{
		var_03 = min(1,var_03);
	}
	else if(isdefined(self.var_84C0))
	{
		var_03 = max(1.5,var_03);
	}

	self setflaggedanimknoblimitedrestart("turn",var_09,1,var_04,var_03);
	combat_playfacialanim(var_09,"aim");
	self notify("turning");
	if(var_02 && !isdefined(self.var_84C0) && !isdefined(self.heat))
	{
		thread func_7452();
	}

	doturnnotetracks();
	self setanimlimited(%turn,0,0.2);
	if(!isdefined(self.var_84C0))
	{
		func_84B6(0.2);
	}

	if(!isdefined(self.var_84C0))
	{
		self clearanim(%turn,0.2);
		self setanimknob(%exposed_aiming,1,0.2,1);
	}
	else
	{
		self clearanim(%exposed_modern,0.3);
	}

	if(isdefined(self.var_84B8))
	{
		self.var_84B8 = undefined;
		thread func_311A();
	}

	func_6605(0);
	self notify("done turning");
}

//Function Number: 35
doturnnotetracks()
{
	self endon("can_stop_turning");
	animscripts/shared::func_2986("turn");
}

//Function Number: 36
makesureturnworks()
{
	self endon("killanimscript");
	self endon("done turning");
	var_00 = self.angles[1];
	wait(0.3);
	if(self.angles[1] == var_00)
	{
		self notify("turning_isnt_working");
		self.var_84B8 = 1;
	}
}

//Function Number: 37
func_84B7(param_00)
{
	self setanimlimited(animscripts/utility::animarray("straight_level"),0,param_00);
	self setanim(%add_idle,0,param_00);
	if(!animscripts/utility::func_8D9B())
	{
		self clearanim(%add_fire,0.2);
	}
}

//Function Number: 38
func_84B6(param_00)
{
	self setanimlimited(animscripts/utility::animarray("straight_level"),1,param_00);
	self setanim(%add_idle,1,param_00);
}

//Function Number: 39
func_7452()
{
	self endon("killanimscript");
	self endon("done turning");
	if(animscripts/utility::func_87FA())
	{
	}

	animscripts/combat_utility::func_744D();
	self clearanim(%add_fire,0.2);
}

//Function Number: 40
shootuntilneedtoturn()
{
	thread func_8CEB();
	self endon("need_to_turn");
	thread keeptryingtomelee();
	animscripts/combat_utility::func_744D();
	self notify("stop_watching_for_need_to_turn");
	self notify("stop_trying_to_melee");
}

//Function Number: 41
func_8CEB()
{
	self endon("killanimscript");
	self endon("stop_watching_for_need_to_turn");
	var_00 = gettime() + 4000 + randomint(2000);
	for(;;)
	{
		if(gettime() > var_00 || func_5597())
		{
			self notify("need_to_turn");
			break;
		}

		wait(0.1);
	}
}

//Function Number: 42
considerthrowgrenade()
{
	if(!animscripts/combat_utility::func_554D())
	{
		return 0;
	}

	if(isdefined(level.var_80AD) && isalive(level.player))
	{
		if(func_83FE(level.player,200))
		{
			return 1;
		}
	}

	if(isdefined(self.enemy) && func_83FE(self.enemy,self.var_525E))
	{
		return 1;
	}

	self.a.var_55EC = gettime() + 500;
	return 0;
}

//Function Number: 43
func_83FE(param_00,param_01)
{
	var_02 = 0;
	if(isdefined(self.var_29AA) || isdefined(param_00.var_29A1))
	{
		return 0;
	}

	if(!isdefined(self.a.var_ED8["exposed_grenade"]))
	{
		return 0;
	}

	var_03 = param_00.origin;
	if(!self cansee(param_00))
	{
		if(isdefined(self.enemy) && param_00 == self.enemy && isdefined(self.var_7445))
		{
			var_03 = self.var_7445;
		}
	}

	if(!self cansee(param_00))
	{
		param_01 = 100;
	}

	if(distancesquared(self.origin,var_03) > param_01 * param_01 && self.a.var_60B1 == self.a.grenadethrowpose)
	{
		animscripts/combat_utility::setactivegrenadetimer(param_00);
		if(!animscripts/combat_utility::grenadecooldownelapsed(param_00))
		{
			return 0;
		}

		var_04 = animscripts/utility::getyawtospot(var_03);
		if(abs(var_04) < 60)
		{
			var_05 = [];
			foreach(var_07 in self.a.var_ED8["exposed_grenade"])
			{
				if(func_48A9(var_07))
				{
					var_05[var_05.size] = var_07;
				}
			}

			if(var_05.size > 0)
			{
				self setanim(%exposed_aiming,0,0.1);
				func_1E23();
				self animmode("zonly_physics");
				animscripts/track::setanimaimweight(0,0);
				var_02 = animscripts/combat_utility::func_8400(param_00,var_05[randomint(var_05.size)]);
				self setanim(%exposed_aiming,1,0.1);
				combat_playfacialanim(undefined,"aim");
				if(var_02)
				{
					animscripts/track::setanimaimweight(1,0.5);
				}
				else
				{
					animscripts/track::setanimaimweight(1,0);
				}
			}
		}
	}

	if(var_02)
	{
		maps\_gameskill::didsomethingotherthanshooting();
	}

	return var_02;
}

//Function Number: 44
func_826F(param_00)
{
	if(param_00 == self.a.var_60B1)
	{
	}

	var_01 = self.a.var_60B1 + "_2_" + param_00;
	if(!isdefined(self.a.var_ED8))
	{
	}

	var_02 = self.a.var_ED8[var_01];
	if(!isdefined(var_02))
	{
	}

	self clearanim(%root,0.3);
	animscripts/combat_utility::func_2D52();
	if(param_00 == "stand")
	{
		var_03 = 2;
	}
	else
	{
		var_03 = 1.5;
	}

	if(!animhasnotetrack(var_02,"anim_pose = \" + param_00 + "\"))
	{
	}

	self setflaggedanimknoballrestart("trans",var_02,%body,1,0.2,var_03);
	combat_playfacialanim(var_02,"run");
	var_04 = getanimlength(var_02) / var_03;
	var_05 = var_04 - 0.3;
	if(var_05 < 0.2)
	{
		var_05 = 0.2;
	}

	animscripts/notetracks::donotetracksfortime(var_05,"trans");
	self.a.var_60B1 = param_00;
	func_70FE();
	animscripts/combat_utility::startfireandaimidlethread();
	maps\_gameskill::didsomethingotherthanshooting();
}

//Function Number: 45
keeptryingtomelee()
{
	self endon("killanimscript");
	self endon("stop_trying_to_melee");
	self endon("done turning");
	self endon("need_to_turn");
	self endon("shoot_behavior_change");
	for(;;)
	{
		wait(0.2 + randomfloat(0.3));
		if(isdefined(self.enemy))
		{
			if(isplayer(self.enemy))
			{
				var_00 = -25536;
			}
			else
			{
				var_00 = 10000;
			}

			if(distancesquared(self.enemy.origin,self.origin) < var_00)
			{
				func_8403();
			}
		}
	}
}

//Function Number: 46
func_8403()
{
	animscripts/melee::func_5192();
}

//Function Number: 47
func_252C()
{
	if(isdefined(self.nomeleechargedelay))
	{
	}

	if(isplayer(self.enemy))
	{
	}

	animscripts/melee::func_5183(self.enemy);
}

//Function Number: 48
func_3103(param_00)
{
	if(animscripts/combat_utility::func_5596(param_00))
	{
		self.a.var_3104 = 1;
		animscripts/combat_utility::func_2D52();
		var_01 = undefined;
		if(isdefined(self.specialreloadanimfunc))
		{
			var_01 = self [[ self.specialreloadanimfunc ]]();
			self.keepclaimednode = 1;
		}
		else
		{
			var_01 = animscripts/utility::animarraypickrandom("reload");
			if(self.a.var_60B1 == "stand" && animscripts/utility::animarrayanyexist("reload_crouchhide") && common_scripts\utility::func_1DE9())
			{
				var_01 = animscripts/utility::animarraypickrandom("reload_crouchhide");
			}
		}

		thread keeptryingtomelee();
		self.var_329B = 0;
		if(weaponclass(self.weapon) == "pistol")
		{
			self orientmode("face default");
		}

		func_2A09(var_01,param_00 > 0.05);
		self notify("abort_reload");
		self orientmode("face current");
		if(self.var_329B)
		{
			animscripts/weaponlist::refillclip();
		}

		self clearanim(%reload,0.2);
		self.keepclaimednode = 0;
		self notify("stop_trying_to_melee");
		self.a.var_3104 = 0;
		self.var_329B = undefined;
		maps\_gameskill::didsomethingotherthanshooting();
		animscripts/combat_utility::startfireandaimidlethread();
		return 1;
	}

	return 0;
}

//Function Number: 49
func_2A09(param_00,param_01)
{
	self endon("abort_reload");
	if(param_01)
	{
		thread abortreloadwhencanshoot();
	}

	var_02 = 1;
	if(!animscripts/utility::func_87FE() && !animscripts/utility::isshotgun(self.weapon) && isdefined(self.enemy) && self cansee(self.enemy) && distancesquared(self.enemy.origin,self.origin) < 1048576)
	{
		var_02 = 1.2;
	}

	var_03 = "reload_" + animscripts/combat_utility::getuniqueflagnameindex();
	self clearanim(%root,0.2);
	self setflaggedanimrestart(var_03,param_00,1,0.2,var_02);
	combat_playfacialanim(param_00,"run");
	thread func_572C("abort_reload",var_03);
	self endon("start_aim");
	animscripts/shared::func_2986(var_03);
	self.var_329B = 1;
}

//Function Number: 50
abortreloadwhencanshoot()
{
	self endon("abort_reload");
	self endon("killanimscript");
	for(;;)
	{
		if(isdefined(self.var_7439) && self cansee(self.var_7439))
		{
			break;
		}

		wait(0.05);
	}

	self notify("abort_reload");
}

//Function Number: 51
func_572C(param_00,param_01)
{
	self endon(param_00);
	self waittillmatch("start_aim",param_01);
	self.var_329B = 1;
	self notify("start_aim");
}

//Function Number: 52
func_329D(param_00)
{
	self endon("killanimscript");
	animscripts/shared::func_2986(param_00);
}

//Function Number: 53
drop_turret()
{
	maps\_mgturret::dropturret();
	animscripts/weaponlist::refillclip();
	self.a.var_5593 = 0;
	self notify("dropped_gun");
	maps\_mgturret::func_665C();
}

//Function Number: 54
func_3045()
{
	drop_turret();
}

//Function Number: 55
func_845E()
{
	if(isdefined(self.secondaryweapon) && animscripts/utility::isshotgun(self.secondaryweapon))
	{
		return 0;
	}

	if(isdefined(self.var_562A))
	{
		return 0;
	}

	self.a.var_60B1 = "stand";
	func_7E23(animscripts/utility::lookupanim("combat","primary_to_pistol"));
	return 1;
}

//Function Number: 56
func_7E23(param_00)
{
	self endon("killanimscript");
	thread animscripts/combat_utility::func_6255();
	animscripts/combat_utility::func_2D52();
	self.var_7D9A = param_00;
	self setflaggedanimknoballrestart("weapon swap",param_00,%body,1,0.2,animscripts/combat_utility::func_31EE());
	combat_playfacialanim(param_00,"run");
	func_2992("weapon swap",::func_3F90,"end_weapon_swap");
	self clearanim(self.var_7D9A,0.2);
	self notify("facing_enemy_immediately");
	self notify("switched_to_sidearm");
	maps\_gameskill::didsomethingotherthanshooting();
}

//Function Number: 57
func_2992(param_00,param_01,param_02)
{
	self endon(param_02);
	animscripts/notetracks::donotetrackspostcallback(param_00,param_01);
}

//Function Number: 58
func_3119(param_00)
{
	self endon("killanimscript");
	wait(param_00);
	func_311A();
}

//Function Number: 59
func_3F90(param_00)
{
	if(param_00 == "pistol_pickup")
	{
		self clearanim(animscripts/utility::animarray("straight_level"),0);
		animscripts/animset::func_6E41();
		thread func_3119(0.25);
	}

	if(param_00 == "start_aim")
	{
		animscripts/combat_utility::startfireandaimidlethread();
		if(func_5597())
		{
			self notify("end_weapon_swap");
		}
	}
}

//Function Number: 60
func_7E22(param_00,param_01)
{
	self endon("killanimscript");
	if(animscripts/utility::isshotgun(self.primaryweapon) && isdefined(self.var_8C03) && !self.var_8C03 && self.lastweapon == animscripts/utility::func_3A13())
	{
		return 0;
	}

	animscripts/combat_utility::func_2D52();
	self.var_7D9A = param_00;
	self setflaggedanimknoballrestart("weapon swap",param_00,%body,1,0.1,1);
	combat_playfacialanim(param_00,"run");
	if(isdefined(param_01))
	{
		func_2992("weapon swap",::handlecleanupputaway,"end_weapon_swap");
	}
	else
	{
		func_2992("weapon swap",::func_3F93,"end_weapon_swap");
	}

	self clearanim(self.var_7D9A,0.2);
	self notify("switched_to_lastweapon");
	maps\_gameskill::didsomethingotherthanshooting();
	return 1;
}

//Function Number: 61
func_3F93(param_00)
{
	if(param_00 == "pistol_putaway")
	{
		self clearanim(animscripts/utility::animarray("straight_level"),0);
		animscripts/animset::func_6E41();
		thread animscripts/combat_utility::func_6255();
	}

	if(param_00 == "start_aim")
	{
		animscripts/combat_utility::startfireandaimidlethread();
		if(func_5597())
		{
			self notify("end_weapon_swap");
		}
	}
}

//Function Number: 62
handlecleanupputaway(param_00)
{
	if(param_00 == "pistol_putaway")
	{
		thread animscripts/combat_utility::func_6255();
	}

	if(issubstr(param_00,"anim_gunhand"))
	{
		self notify("end_weapon_swap");
	}
}

//Function Number: 63
func_68B1()
{
	if(!animscripts/utility::func_87FA() || self.bulletsinclip == 0)
	{
		return 0;
	}

	if(randomfloat(1) > 0.5)
	{
		var_00 = animscripts/utility::lookupanim("combat","rpg_death");
	}
	else
	{
		var_00 = animscripts/utility::lookupanim("combat","rpg_death_stagger");
	}

	self setflaggedanimknoball("deathanim",var_00,%root,1,0.05,1);
	combat_playfacialanim(var_00,"death");
	animscripts/shared::func_2986("deathanim");
	animscripts/shared::func_2B49();
}

//Function Number: 64
func_63AE()
{
	self endon("killanimscript");
	self.a.var_3104 = 0;
	for(;;)
	{
		wait(0.2);
		if(isdefined(self.enemy) && !self seerecently(self.enemy,2))
		{
			if(self.combatmode == "ambush" || self.combatmode == "ambush_nodes_only")
			{
				continue;
			}
		}

		func_83FD();
	}
}

//Function Number: 65
func_83FD()
{
	if(self.fixednode)
	{
	}

	if(!isdefined(self.enemy))
	{
		self.var_63AC = 0;
	}

	if(gettime() < self.teammovewaittime)
	{
		self.var_63AC = 0;
	}

	if(isdefined(self.var_6161) && self.var_6161 != self.enemy)
	{
		self.var_63AC = 0;
		self.var_6161 = undefined;
	}

	self.var_6161 = self.enemy;
	if(self cansee(self.enemy) && self canshootenemy())
	{
		self.var_63AC = 0;
	}

	if(isdefined(self.var_329B) && !self.var_329B)
	{
		self.var_63AC = 0;
	}

	if(!isdefined(self.var_63AD) || !self.var_63AD)
	{
		var_00 = vectornormalize(self.enemy.origin - self.origin);
		var_01 = anglestoforward(self.angles);
		if(vectordot(var_00,var_01) < 0.5)
		{
			self.var_63AC = 0;
		}
	}

	if(self.a.var_3104 && animscripts/combat_utility::func_5596(0.25) && self.enemy.health > self.enemy.maxhealth * 0.5)
	{
		self.var_63AC = 0;
	}

	if(animscripts/combat_utility::shouldhelpadvancingteammate() && self.var_63AC < 3)
	{
		self.var_63AC = 3;
	}

	switch(self.var_63AC)
	{
		case 0:
			if(self reacquirestep(32))
			{
			}
			break;

		case 1:
			if(self reacquirestep(64))
			{
				self.var_63AC = 0;
			}
			break;

		case 2:
			if(self reacquirestep(96))
			{
				self.var_63AC = 0;
			}
			break;

		case 3:
			if(animscripts/combat_utility::func_8405(0))
			{
				self.var_63AC = 0;
			}
			break;

		case 4:
			if(!self cansee(self.enemy) || !self canshootenemy())
			{
				self flagenemyunattackable();
			}
			break;

		default:
			if(self.var_63AC > 15)
			{
				self.var_63AC = 0;
			}
			break;
	}

	self.var_63AC++;
}

//Function Number: 66
func_6605(param_00)
{
	var_01 = param_00;
	if(!isdefined(var_01))
	{
		var_01 = 1;
	}

	if(self.swimmer)
	{
		self animmode("nogravity",var_01);
	}

	self animmode("zonly_physics",var_01);
}

//Function Number: 67
combat_playfacialanim(param_00,param_01)
{
	self.facialidx = animscripts/face::func_6004(param_00,param_01,self.facialidx);
}

//Function Number: 68
func_1E23()
{
	self.facialidx = undefined;
	self clearanim(%head,0.2);
}