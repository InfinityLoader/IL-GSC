/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\combat.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 62
 * Decompile Time: 1046 ms
 * Timestamp: 10/27/2023 2:17:55 AM
*******************************************************************/

//Function Number: 1
main()
{
	if(isdefined(self.var_10EF))
	{
		return;
	}

	if(isdefined(self.onsnowmobile))
	{
		animscripts/snowmobile::main();
		return;
	}

	if(isdefined(self.custom_animscript_table))
	{
		if(isdefined(self.custom_animscript_table["combat"]))
		{
			[[ self.custom_animscript_table["combat"] ]]();
			return;
		}
	}

	self endon("killanimscript");
	[[ self.var_8BE["exposed"] ]]();
	animscripts/utility::func_D15("combat");
	self.a.var_10DF = undefined;
	if(isdefined(self.node) && self.node.type == "Ambush" && self nearnode(self.node))
	{
		self.var_CF1 = self.node;
	}

	func_1107();
	func_1105();
	animscripts/stop::func_10F5();
	func_1109();
	func_111D();
	self notify("stop_deciding_how_to_shoot");
}

//Function Number: 2
func_067F()
{
	self.var_CF1 = undefined;
}

//Function Number: 3
func_1105()
{
	if(self.team != "allies")
	{
		return;
	}

	if(self ismovesuppressed() && self.var_788 == "move" && self.a.pose == "stand" && !isdefined(self.var_1106))
	{
		if(isdefined(self.enemy) && distancesquared(self.origin,self.enemy.origin) < squared(128))
		{
			return;
		}

		self animmode("zonly_physics");
		self setflaggedanimknoballrestart("react",%surprise_stop_v1,%root,1,0.2,self.var_10F7);
		animscripts/shared::donotetracks("react");
	}
}

//Function Number: 4
func_1107()
{
	if(isdefined(self.specialidleanim) || isdefined(self.var_C89))
	{
		return;
	}

	if(isdefined(self.enemy) && distancesquared(self.origin,self.enemy.origin) < 262144)
	{
		return;
	}

	if(self.var_788 == "stop" && !animscripts/utility::func_C98() && self.a.pose == "stand")
	{
		self animmode("zonly_physics");
		self setflaggedanimknoballrestart("transition",%casual_stand_idle_trans_out,%root,1,0.2,1.2 * self.var_10F7);
		animscripts/shared::donotetracks("transition");
	}
}

//Function Number: 5
func_1108()
{
	if(self.a.pose == "stand")
	{
		animscripts/animset::func_C94();
		return;
	}

	if(self.a.pose == "crouch")
	{
		animscripts/animset::func_C99();
		return;
	}

	if(self.a.pose == "prone")
	{
		animscripts/animset::func_C9C();
		return;
	}
}

//Function Number: 6
func_1109()
{
	if(animscripts/utility::func_C95() && self isstanceallowed("stand"))
	{
		func_113F("stand");
	}

	func_1108();
	func_110E();
	thread func_110D();
	self.var_110A = 0;
	self clearanim(%root,0.2);
	animscripts/combat_utility::func_110B(0.2);
	thread animscripts/combat_utility::aimidlethread();
	self.a.var_110C = "aim";
	func_1142();
}

//Function Number: 7
func_110D()
{
	self endon("killanimscript");
	wait 0.2;
	self.a.movement = "stop";
}

//Function Number: 8
func_110E()
{
	self setdefaultaimlimits();
	if(self.a.pose == "stand")
	{
		self.var_714 = 60;
		self.var_715 = -60;
	}

	self.var_F72 = self.var_110F;
}

//Function Number: 9
func_1110()
{
	thread animscripts/track::func_CA9();
	thread func_115E();
	thread animscripts/shoot_behavior::func_CD7("normal");
	thread func_1128();
	func_1127();
	if(isdefined(self.a.var_1111))
	{
		animscripts/weaponlist::func_CD0();
		self.a.var_1111 = undefined;
	}

	self.a.var_1112 = gettime() + randomintrange(500,1500);
}

//Function Number: 10
func_1113(param_00)
{
	if(animscripts/utility::func_BB6() && param_00 < 262144 || self.a.rockets < 1)
	{
		if(self.a.pose != "stand" && self.a.pose != "crouch")
		{
			func_113F("crouch");
		}

		if(self.a.pose == "stand")
		{
			animscripts/shared::func_F87(%rpg_stand_throw);
		}
		else
		{
			animscripts/shared::func_F87(%rpg_crouch_throw);
		}

		self clearanim(%root,0.2);
		animscripts/combat_utility::func_F85();
		func_1108();
		animscripts/combat_utility::func_1114();
		return 1;
	}

	return 0;
}

//Function Number: 11
func_1115(param_00)
{
	if(self.a.pose != "stand" && self isstanceallowed("stand"))
	{
		if(param_00 < 81225)
		{
			func_113F("stand");
			return 1;
		}

		if(func_1120())
		{
			return 1;
		}
	}

	if(param_00 > 262144 && self.a.pose != "crouch" && self isstanceallowed("crouch") && !animscripts/utility::func_C95() && !isdefined(self.heat) && gettime() >= self.a.var_1112 && lengthsquared(self.var_D81) < 10000)
	{
		if(!isdefined(self.var_CB1) || sighttracepassed(self.origin + (0,0,36),self.var_CB1,0,undefined))
		{
			func_113F("crouch");
			return 1;
		}
	}

	return 0;
}

//Function Number: 12
func_1116(param_00)
{
	if(!animscripts/utility::func_C95())
	{
		if(isdefined(self.var_1117) && self.a.pose == "stand")
		{
			if(func_1150())
			{
				return 1;
			}
		}

		if(animscripts/combat_utility::issniper() && param_00 < 167772.2)
		{
			if(func_1150())
			{
				return 1;
			}
		}
	}

	if(animscripts/combat_utility::func_F08(0))
	{
		if(!animscripts/utility::func_C95() && common_scripts\utility::cointoss() && !animscripts/utility::func_BB6() && animscripts/utility::func_1118() && param_00 < 167772.2 && self isstanceallowed("stand"))
		{
			if(self.a.pose != "stand")
			{
				func_113F("stand");
				return 1;
			}

			if(func_1150())
			{
				return 1;
			}
		}

		if(func_1144(0))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 13
func_1119(param_00)
{
	if(animscripts/utility::func_C95() && self.a.pose == "stand" && !isdefined(self.var_1117))
	{
		if(param_00 > 262144 || self.combatmode == "ambush_nodes_only" && !isdefined(self.enemy) || !self cansee(self.enemy))
		{
			func_1159(%pistol_stand_switch);
		}
	}
}

//Function Number: 14
func_111A()
{
	if(isdefined(self.heat) && self nearclaimnodeandangle())
	{
		self safeteleport(self.var_757,self.node.angles);
	}
}

//Function Number: 15
func_111B()
{
	if(func_1121())
	{
		var_00 = 0.25;
		if(isdefined(self.var_CAB) && !issentient(self.var_CAB))
		{
			var_00 = 1.5;
		}

		var_01 = animscripts/shared::func_111C(var_00);
		if(func_0F73(var_01))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 16
func_111D()
{
	self endon("killanimscript");
	self endon("combat_restart");
	func_1110();
	self animmode("zonly_physics",0);
	self orientmode("face angle",self.angles[1]);
	for(;;)
	{
		if(animscripts/utility::func_BB6())
		{
			self.deathfunction = undefined;
		}

		animscripts/utility::func_A69();
		if(func_1122())
		{
			continue;
		}

		func_1141();
		func_111A();
		if(!isdefined(self.var_CB1))
		{
			func_1123();
			if(!isdefined(self.enemy))
			{
				var_00 = 1;
			}

			continue;
		}

		func_1127();
		var_01 = lengthsquared(self.origin - self.var_CB1);
		if(func_1113(var_01))
		{
			continue;
		}

		if(func_111B())
		{
			continue;
		}

		if(func_10E7())
		{
			continue;
		}

		if(func_1116(var_01))
		{
			continue;
		}

		if(animscripts/utility::func_BB6() && self.a.pose != "crouch" && randomfloat(1) > 0.65)
		{
			self.deathfunction = ::func_115D;
		}

		func_1119(var_01);
		if(func_1115(var_01))
		{
			continue;
		}

		if(animscripts/combat_utility::func_10E4())
		{
			func_1136();
			animscripts/combat_utility::func_111E();
			continue;
		}

		func_111F();
	}
}

//Function Number: 17
func_111F()
{
	if(!isdefined(self.enemy) || !self cansee(self.enemy))
	{
		self endon("enemy");
		self endon("shoot_behavior_change");
		wait 0.2 + randomfloat(0.1);
		self waittill("do_slow_things");
		return;
	}

	wait 0.05;
}

//Function Number: 18
func_1120()
{
	if(isdefined(self.enemy) && !self cansee(self.enemy) || !self canshootenemy() && sighttracepassed(self.origin + (0,0,64),self.enemy getshootatpos(),0,undefined))
	{
		self.a.var_1112 = gettime() + 3000;
		func_113F("stand");
		return 1;
	}

	return 0;
}

//Function Number: 19
func_1121()
{
	var_00 = self.var_CB1;
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

	return animscripts/utility::func_D61(var_01) > self.var_F72;
}

//Function Number: 20
func_1122()
{
	var_00 = self.a.pose;
	if(isdefined(self.a.var_D29))
	{
		wait 0.1;
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

		if(self isstanceallowed(var_01))
		{
			if(var_00 == "stand" && animscripts/utility::func_C95())
			{
				return 0;
			}

			func_113F(var_01);
			return 1;
		}
	}

	return 0;
}

//Function Number: 21
func_1123()
{
	if(self.a.pose != "stand" && self isstanceallowed("stand") && func_1120())
	{
		return 1;
	}

	var_00 = gettime();
	self.a.var_1112 = var_00 + 1500;
	if(isdefined(self.group) && isdefined(self.group.forward))
	{
		var_01 = angleclamp180(self.angles[1] - vectortoyaw(self.group.forward));
		if(func_0F73(var_01))
		{
			return 1;
		}
	}

	if(isdefined(self.node) && isdefined(level.var_CBD[self.node.type]))
	{
		var_01 = angleclamp180(self.angles[1] - self.node.angles[1]);
		if(func_0F73(var_01))
		{
			return 1;
		}
	}
	else if((isdefined(self.enemy) && self seerecently(self.enemy,2)) || var_00 > self.a.var_1019 + 1200)
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

		if(isdefined(var_01) && func_0F73(var_01))
		{
			return 1;
		}
	}
	else if(isdefined(self.heat) && self nearclaimnode())
	{
		var_01 = angleclamp180(self.angles[1] - self.node.angles[1]);
		if(func_0F73(var_01))
		{
			return 1;
		}
	}

	if(func_10E7())
	{
		return 1;
	}

	var_03 = self.a.var_1125 < var_00;
	var_04 = 0;
	if(var_03)
	{
		var_04 = 0.99999;
	}

	if(func_1144(var_04))
	{
		return 1;
	}

	if(var_03 && animscripts/utility::func_C95())
	{
		if(func_1159(%pistol_stand_switch))
		{
			return 1;
		}
	}

	func_1126();
	return 1;
}

//Function Number: 22
func_1126()
{
	self endon("shoot_behavior_change");
	wait 0.4 + randomfloat(0.4);
	self waittill("do_slow_things");
}

//Function Number: 23
func_1127()
{
	self.a.var_1125 = gettime() + randomintrange(2000,4000);
}

//Function Number: 24
func_0F73(param_00)
{
	if(param_00 < 0 - self.var_F72)
	{
		if(self.a.pose == "prone")
		{
			animscripts/cover_prone::func_10B0("crouch");
			animscripts/animset::func_C99();
		}

		func_112E("left",0 - param_00);
		maps\_gameskill::didsomethingotherthanshooting();
		return 1;
	}

	if(param_00 > self.var_F72)
	{
		if(self.a.pose == "prone")
		{
			animscripts/cover_prone::func_10B0("crouch");
			animscripts/animset::func_C99();
		}

		func_112E("right",param_00);
		maps\_gameskill::didsomethingotherthanshooting();
		return 1;
	}

	return 0;
}

//Function Number: 25
func_1128()
{
	self endon("killanimscript");
	self.var_D81 = (0,0,0);
	var_00 = undefined;
	var_01 = self.origin;
	var_02 = 0.15;
	for(;;)
	{
		if(isdefined(self.var_CAB) && isdefined(var_00) && self.var_CAB == var_00)
		{
			var_03 = self.var_CAB.origin;
			self.var_D81 = var_03 - var_01 * 1 / var_02;
			var_01 = var_03;
		}
		else
		{
			if(isdefined(self.var_CAB))
			{
				var_01 = self.var_CAB.origin;
			}
			else
			{
				var_01 = self.origin;
			}

			var_00 = self.var_CAB;
			self.var_D81 = (0,0,0);
		}

		wait var_02;
	}
}

//Function Number: 26
func_1129()
{
	return 0;
}

//Function Number: 27
func_112A(param_00)
{
	self endon("killanimscript");
	animscripts/shared::donotetracks(param_00);
}

//Function Number: 28
func_112B()
{
	self endon("killanimscript");
	self notify("facing_enemy_immediately");
	self endon("facing_enemy_immediately");
	var_00 = 5;
	for(;;)
	{
		var_01 = 0 - animscripts/utility::func_D5C();
		if(abs(var_01) < 2)
		{
			break;
		}

		if(abs(var_01) > var_00)
		{
			var_01 = var_00 * common_scripts\utility::sign(var_01);
		}

		self orientmode("face angle",self.angles[1] + var_01);
		wait 0.05;
	}

	self orientmode("face current");
	self notify("can_stop_turning");
}

//Function Number: 29
func_112C(param_00)
{
	var_01 = getmovedelta(param_00,0,1);
	var_02 = self localtoworldcoords(var_01);
	return self isingoal(var_02) && self maymovetopoint(var_02);
}

//Function Number: 30
func_112D(param_00)
{
	var_01 = getmovedelta(param_00,0,1);
	var_02 = self localtoworldcoords(var_01);
	return self isingoal(var_02);
}

//Function Number: 31
func_112E(param_00,param_01)
{
	var_02 = isdefined(self.var_CB1);
	var_03 = 1;
	var_04 = 0.2;
	var_05 = isdefined(self.enemy) && !isdefined(self.var_F3D) && self seerecently(self.enemy,2) && distancesquared(self.enemy.origin,self.origin) < 262144;
	if(self.a.var_1019 + 500 > gettime())
	{
		var_04 = 0.25;
		if(var_05)
		{
			thread func_112B();
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
	var_09 = animscripts/utility::func_D4D(var_08);
	if(isdefined(self.var_F3D))
	{
		self animmode("angle deltas",0);
	}
	else if(isdefined(self.node) && isdefined(level.var_112F[self.node.type]) && distancesquared(self.origin,self.node.origin) < 256)
	{
		self animmode("angle deltas",0);
	}
	else if(func_112D(var_09))
	{
		self animmode("zonly_physics",0);
	}
	else
	{
		self animmode("angle deltas",0);
	}

	self setanimknoball(%exposed_aiming,%body,1,var_04);
	if(!isdefined(self.var_F3D))
	{
		func_1133(var_04);
	}

	self setanimlimited(%turn,1,var_04);
	if(isdefined(self.heat))
	{
		var_03 = min(1,var_03);
	}
	else if(isdefined(self.var_F3D))
	{
		var_03 = max(1.5,var_03);
	}

	self setflaggedanimknoblimitedrestart("turn",var_09,1,var_04,var_03);
	self notify("turning");
	if(var_02 && !isdefined(self.var_F3D) && !isdefined(self.heat))
	{
		thread func_1135();
	}

	func_1131();
	self setanimlimited(%turn,0,0.2);
	if(!isdefined(self.var_F3D))
	{
		func_1134(0.2);
	}

	if(!isdefined(self.var_F3D))
	{
		self clearanim(%turn,0.2);
		self setanimknob(%exposed_aiming,1,0.2,1);
	}
	else
	{
		self clearanim(%exposed_modern,0.3);
	}

	if(isdefined(self.var_1130))
	{
		self.var_1130 = undefined;
		thread func_112B();
	}

	self animmode("zonly_physics",0);
	self notify("done turning");
}

//Function Number: 32
func_1131()
{
	self endon("can_stop_turning");
	animscripts/shared::donotetracks("turn");
}

//Function Number: 33
func_1132()
{
	self endon("killanimscript");
	self endon("done turning");
	var_00 = self.angles[1];
	wait 0.3;
	if(self.angles[1] == var_00)
	{
		self notify("turning_isnt_working");
		self.var_1130 = 1;
	}
}

//Function Number: 34
func_1133(param_00)
{
	self setanimlimited(animscripts/utility::func_D4D("straight_level"),0,param_00);
	self setanim(%add_idle,0,param_00);
	if(!animscripts/utility::func_C97())
	{
		self clearanim(%add_fire,0.2);
	}
}

//Function Number: 35
func_1134(param_00)
{
	self setanimlimited(animscripts/utility::func_D4D("straight_level"),1,param_00);
	self setanim(%add_idle,1,param_00);
}

//Function Number: 36
func_1135()
{
	self endon("killanimscript");
	self endon("done turning");
	if(animscripts/utility::func_BB6())
	{
		return;
	}

	animscripts/combat_utility::func_F06();
	self clearanim(%add_fire,0.2);
}

//Function Number: 37
func_1136()
{
	thread func_1137();
	self endon("need_to_turn");
	thread func_1140();
	animscripts/combat_utility::func_F06();
	self notify("stop_watching_for_need_to_turn");
	self notify("stop_trying_to_melee");
}

//Function Number: 38
func_1137()
{
	self endon("killanimscript");
	self endon("stop_watching_for_need_to_turn");
	var_00 = gettime() + 4000 + randomint(2000);
	for(;;)
	{
		if(gettime() > var_00 || func_1121())
		{
			self notify("need_to_turn");
			break;
		}

		wait 0.1;
	}
}

//Function Number: 39
func_10E7()
{
	if(!animscripts/combat_utility::func_1138())
	{
		return 0;
	}

	if(isdefined(level.throwgrenadeatplayerasap) && isalive(level.player))
	{
		if(func_113B(level.player,200))
		{
			return 1;
		}
	}

	if(isdefined(self.enemy) && func_113B(self.enemy,self.minexposedgrenadedist))
	{
		return 1;
	}

	self.a.var_113A = gettime() + 500;
	return 0;
}

//Function Number: 40
func_113B(param_00,param_01)
{
	var_02 = 0;
	if(isdefined(self.dontevershoot) || isdefined(param_00.var_FA0))
	{
		return 0;
	}

	if(!isdefined(self.a.array["exposed_grenade"]))
	{
		return 0;
	}

	var_03 = param_00.origin;
	if(!self cansee(param_00))
	{
		if(isdefined(self.enemy) && param_00 == self.enemy && isdefined(self.var_CB1))
		{
			var_03 = self.var_CB1;
		}
	}

	if(!self cansee(param_00))
	{
		param_01 = 100;
	}

	if(distancesquared(self.origin,var_03) > param_01 * param_01 && self.a.pose == self.a.var_113C)
	{
		animscripts/combat_utility::func_1093(param_00);
		if(!animscripts/combat_utility::func_113D(param_00))
		{
			return 0;
		}

		var_04 = animscripts/utility::func_113E(var_03);
		if(abs(var_04) < 60)
		{
			var_05 = [];
			foreach(var_07 in self.a.array["exposed_grenade"])
			{
				if(func_112C(var_07))
				{
					var_05[var_05.size] = var_07;
				}
			}

			if(var_05.size > 0)
			{
				self setanim(%exposed_aiming,0,0.1);
				self animmode("zonly_physics");
				animscripts/track::func_CC4(0,0);
				var_02 = animscripts/combat_utility::func_FA1(param_00,var_05[randomint(var_05.size)]);
				self setanim(%exposed_aiming,1,0.1);
				if(var_02)
				{
					animscripts/track::func_CC4(1,0.5);
				}
				else
				{
					animscripts/track::func_CC4(1,0);
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

//Function Number: 41
func_113F(param_00)
{
	if(param_00 == self.a.pose)
	{
		return;
	}

	var_01 = self.a.pose + "_2_" + param_00;
	if(!isdefined(self.a.array))
	{
		return;
	}

	var_02 = self.a.array[var_01];
	if(!isdefined(var_02))
	{
		return;
	}

	self clearanim(%root,0.3);
	animscripts/combat_utility::func_F85();
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
	var_04 = getanimlength(var_02) / var_03;
	var_05 = var_04 - 0.3;
	if(var_05 < 0.2)
	{
		var_05 = 0.2;
	}

	animscripts/notetracks::func_D4F(var_05,"trans");
	self.a.pose = param_00;
	func_1108();
	animscripts/combat_utility::func_1114();
	maps\_gameskill::didsomethingotherthanshooting();
}

//Function Number: 42
func_1140()
{
	self endon("killanimscript");
	self endon("stop_trying_to_melee");
	self endon("done turning");
	self endon("need_to_turn");
	self endon("shoot_behavior_change");
	for(;;)
	{
		wait 0.2 + randomfloat(0.3);
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
				func_1141();
			}
		}
	}
}

//Function Number: 43
func_1141()
{
	animscripts/melee::func_1009();
}

//Function Number: 44
func_1142()
{
	if(isdefined(self.var_1143))
	{
		return;
	}

	if(isplayer(self.enemy))
	{
		return;
	}

	animscripts/melee::func_1021(self.enemy);
}

//Function Number: 45
func_1144(param_00)
{
	if(animscripts/combat_utility::func_F08(param_00))
	{
		self.a.var_1145 = 1;
		animscripts/combat_utility::func_F85();
		var_01 = undefined;
		if(isdefined(self.specialreloadanimfunc))
		{
			var_01 = self [[ self.specialreloadanimfunc ]]();
			self.var_766 = 1;
		}
		else
		{
			var_01 = animscripts/utility::func_CA8("reload");
			if(self.a.pose == "stand" && animscripts/utility::func_F8D("reload_crouchhide") && common_scripts\utility::cointoss())
			{
				var_01 = animscripts/utility::func_CA8("reload_crouchhide");
			}
		}

		thread func_1140();
		self.var_1147 = 0;
		if(weaponclass(self.weapon) == "pistol")
		{
			self orientmode("face default");
		}

		func_1148(var_01,param_00 > 0.05);
		self notify("abort_reload");
		self orientmode("face current");
		if(self.var_1147)
		{
			animscripts/weaponlist::func_CD0();
		}

		self clearanim(%reload,0.2);
		self.var_766 = 0;
		self notify("stop_trying_to_melee");
		self.a.var_1145 = 0;
		self.var_1147 = undefined;
		maps\_gameskill::didsomethingotherthanshooting();
		animscripts/combat_utility::func_1114();
		return 1;
	}

	return 0;
}

//Function Number: 46
func_1148(param_00,param_01)
{
	self endon("abort_reload");
	if(param_01)
	{
		thread func_1149();
	}

	var_02 = 1;
	if(!animscripts/utility::func_C95() && !animscripts/utility::func_CEA(self.weapon) && isdefined(self.enemy) && self cansee(self.enemy) && distancesquared(self.enemy.origin,self.origin) < 1048576)
	{
		var_02 = 1.2;
	}

	var_03 = "reload_" + animscripts/combat_utility::func_FF4();
	self clearanim(%root,0.2);
	self setflaggedanimrestart(var_03,param_00,1,0.2,var_02);
	thread func_114A("abort_reload",var_03);
	self endon("start_aim");
	animscripts/shared::donotetracks(var_03);
	self.var_1147 = 1;
}

//Function Number: 47
func_1149()
{
	self endon("abort_reload");
	self endon("killanimscript");
	for(;;)
	{
		if(isdefined(self.var_CAB) && self cansee(self.var_CAB))
		{
			break;
		}

		wait 0.05;
	}

	self notify("abort_reload");
}

//Function Number: 48
func_114A(param_00,param_01)
{
	self endon(param_00);
	self waittillmatch("start_aim",param_01);
	self.var_1147 = 1;
	self notify("start_aim");
}

//Function Number: 49
func_10EB(param_00)
{
	self endon("killanimscript");
	animscripts/shared::donotetracks(param_00);
}

//Function Number: 50
func_114B()
{
	maps\_mgturret::dropturret();
	animscripts/weaponlist::func_CD0();
	self.a.var_114D = 0;
	self notify("dropped_gun");
	maps\_mgturret::restoredefaults();
}

//Function Number: 51
func_114F()
{
	func_114B();
}

//Function Number: 52
func_1150()
{
	if(isdefined(self.secondaryweapon) && animscripts/utility::func_CEA(self.secondaryweapon))
	{
		return 0;
	}

	if(isdefined(self.no_pistol_switch))
	{
		return 0;
	}

	self.a.pose = "stand";
	func_1152(%pistol_stand_pullout);
	return 1;
}

//Function Number: 53
func_1152(param_00)
{
	self endon("killanimscript");
	thread animscripts/combat_utility::func_1153();
	animscripts/combat_utility::func_F85();
	self.var_1154 = param_00;
	self setflaggedanimknoballrestart("weapon swap",param_00,%body,1,0.2,animscripts/combat_utility::func_F7B());
	func_1155("weapon swap",::func_1158,"end_weapon_swap");
	self clearanim(self.var_1154,0.2);
	self notify("facing_enemy_immediately");
	self notify("switched_to_sidearm");
	maps\_gameskill::didsomethingotherthanshooting();
}

//Function Number: 54
func_1155(param_00,param_01,param_02)
{
	self endon(param_02);
	animscripts/notetracks::func_1156(param_00,param_01);
}

//Function Number: 55
func_1157(param_00)
{
	self endon("killanimscript");
	wait param_00;
	func_112B();
}

//Function Number: 56
func_1158(param_00)
{
	if(param_00 == "pistol_pickup")
	{
		self clearanim(animscripts/utility::func_D4D("straight_level"),0);
		animscripts/animset::func_C94();
		thread func_1157(0.25);
		return;
	}

	if(param_00 == "start_aim")
	{
		animscripts/combat_utility::func_1114();
		if(func_1121())
		{
			self notify("end_weapon_swap");
			return;
		}
	}
}

//Function Number: 57
func_1159(param_00,param_01)
{
	self endon("killanimscript");
	if(animscripts/utility::func_CEA(self.primaryweapon) && isdefined(self.wantshotgun) && !self.wantshotgun && self.lastweapon == animscripts/utility::func_115A())
	{
		return 0;
	}

	animscripts/combat_utility::func_F85();
	self.var_1154 = param_00;
	self setflaggedanimknoballrestart("weapon swap",param_00,%body,1,0.1,1);
	if(isdefined(param_01))
	{
		func_1155("weapon swap",::func_115C,"end_weapon_swap");
	}
	else
	{
		func_1155("weapon swap",::func_115B,"end_weapon_swap");
	}

	self clearanim(self.var_1154,0.2);
	self notify("switched_to_lastweapon");
	maps\_gameskill::didsomethingotherthanshooting();
	return 1;
}

//Function Number: 58
func_115B(param_00)
{
	if(param_00 == "pistol_putaway")
	{
		self clearanim(animscripts/utility::func_D4D("straight_level"),0);
		animscripts/animset::func_C94();
		thread animscripts/combat_utility::func_1153();
		return;
	}

	if(param_00 == "start_aim")
	{
		animscripts/combat_utility::func_1114();
		if(func_1121())
		{
			self notify("end_weapon_swap");
			return;
		}
	}
}

//Function Number: 59
func_115C(param_00)
{
	if(param_00 == "pistol_putaway")
	{
		thread animscripts/combat_utility::func_1153();
		return;
	}

	if(issubstr(param_00,"anim_gunhand"))
	{
		self notify("end_weapon_swap");
	}
}

//Function Number: 60
func_115D()
{
	if(!animscripts/utility::func_BB6() || self.bulletsinclip == 0)
	{
		return 0;
	}

	if(randomfloat(1) > 0.5)
	{
		self setflaggedanimknoball("deathanim",%rpg_stand_death,%root,1,0.05,1);
	}
	else
	{
		self setflaggedanimknoball("deathanim",%rpg_stand_death_stagger,%root,1,0.05,1);
	}

	animscripts/shared::donotetracks("deathanim");
	animscripts/shared::func_D73();
}

//Function Number: 61
func_115E()
{
	self endon("killanimscript");
	self.a.var_1145 = 0;
	for(;;)
	{
		wait 0.2;
		if(isdefined(self.enemy) && !self seerecently(self.enemy,2))
		{
			if(self.combatmode == "ambush" || self.combatmode == "ambush_nodes_only")
			{
				continue;
			}
		}

		func_115F();
	}
}

//Function Number: 62
func_115F()
{
	if(self.fixednode)
	{
		return;
	}

	if(!isdefined(self.enemy))
	{
		self.var_1160 = 0;
		return;
	}

	if(gettime() < self.var_720)
	{
		self.var_1160 = 0;
		return;
	}

	if(isdefined(self.var_1161) && self.var_1161 != self.enemy)
	{
		self.var_1160 = 0;
		self.var_1161 = undefined;
		return;
	}

	self.var_1161 = self.enemy;
	if(self cansee(self.enemy) && self canshootenemy())
	{
		self.var_1160 = 0;
		return;
	}

	if(isdefined(self.var_1147) && !self.var_1147)
	{
		self.var_1160 = 0;
		return;
	}

	if(!isdefined(self.reacquire_without_facing) || !self.reacquire_without_facing)
	{
		var_00 = vectornormalize(self.enemy.origin - self.origin);
		var_01 = anglestoforward(self.angles);
		if(vectordot(var_00,var_01) < 0.5)
		{
			self.var_1160 = 0;
			return;
		}
	}

	if(self.a.var_1145 && animscripts/combat_utility::func_F08(0.25) && self.enemy.health > self.enemy.maxhealth * 0.5)
	{
		self.var_1160 = 0;
		return;
	}

	if(animscripts/combat_utility::func_F34() && self.var_1160 < 3)
	{
		self.var_1160 = 3;
	}

	switch(self.var_1160)
	{
		case 0:
			if(self reacquirestep(32))
			{
				return;
			}
			break;

		case 1:
			if(self reacquirestep(64))
			{
				self.var_1160 = 0;
				return;
			}
			break;

		case 2:
			if(self reacquirestep(96))
			{
				self.var_1160 = 0;
				return;
			}
			break;

		case 3:
			if(animscripts/combat_utility::func_F35(0))
			{
				self.var_1160 = 0;
				return;
			}
			break;

		case 4:
			if(!self cansee(self.enemy) || !self canshootenemy())
			{
				self flagenemyunattackable();
			}
			break;

		default:
			if(self.var_1160 > 15)
			{
				self.var_1160 = 0;
				return;
			}
			break;
	}

	self.var_1160++;
}