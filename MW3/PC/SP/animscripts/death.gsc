/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\death.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 31
 * Decompile Time: 575 ms
 * Timestamp: 10/27/2023 2:18:16 AM
*******************************************************************/

//Function Number: 1
main()
{
	self endon("killanimscript");
	self stopsoundchannel("voice");
	var_00 = 0.3;
	self clearanim(%scripted_talking,var_00);
	if(self.a.var_D55 == 1)
	{
		return;
	}

	if(isdefined(self.deathfunction))
	{
		var_01 = self [[ self.deathfunction ]]();
		if(!isdefined(var_01))
		{
			var_01 = 1;
		}

		if(var_01)
		{
			return;
		}
	}

	animscripts/utility::func_D15("death");
	func_0ED1(self.origin);
	level.var_D43--;
	level.var_D6B--;
	if(isdefined(self.var_EC0) || self.var_746)
	{
		func_0EC2();
	}

	if(isdefined(self.deathanim))
	{
		func_0D56(self.deathanim);
		if(isdefined(self.deathanimscript))
		{
			self [[ self.deathanimscript ]]();
		}

		return;
	}

	var_02 = animscripts/pain::func_D1F();
	if(self.damagelocation == "helmet" || self.damagelocation == "head")
	{
		func_0D17();
	}
	else if(var_02 && randomint(3) == 0)
	{
		func_0D17();
	}

	self clearanim(%root,0.3);
	if(!animscripts/utility::func_D2F("head","helmet"))
	{
		if(self.diequietly)
		{
		}
		else
		{
			playdeathsound();
		}
	}

	if(var_02 && func_0EE7())
	{
		return;
	}

	if(isdefined(self.var_D4B))
	{
		if([[ self.var_D4B ]]())
		{
			return;
		}
	}

	if(specialdeath())
	{
		return;
	}

	var_03 = func_0ED8();
	func_0D56(var_03);
}

//Function Number: 2
func_0EC2()
{
	animscripts/shared::func_D73();
	self.skipdeathanim = 1;
	var_00 = 10;
	var_01 = common_scripts\_destructible::getdamagetype(self.var_726);
	if(isdefined(self.attacker) && self.attacker == level.player && var_01 == "melee")
	{
		var_00 = 5;
	}

	var_02 = self.damagetaken;
	if(var_01 == "bullet")
	{
		var_02 = max(var_02,300);
	}

	var_03 = var_00 * var_02;
	var_04 = max(0.3,self.var_722[2]);
	var_05 = (self.var_722[0],self.var_722[1],var_04);
	if(isdefined(self.var_EC4))
	{
		var_05 = var_05 * self.var_EC4;
	}
	else
	{
		var_05 = var_05 * var_03;
	}

	if(self.var_746)
	{
		var_05 = var_05 + self.var_777 * 20 * 10;
	}

	if(isdefined(self.var_EC5))
	{
		var_05 = var_05 + self.var_EC5 * 10;
	}

	self startragdollfromimpact(self.damagelocation,var_05);
	wait 0.05;
}

//Function Number: 3
func_0D56(param_00)
{
	if(!animhasnotetrack(param_00,"dropgun") && !animhasnotetrack(param_00,"fire_spray"))
	{
		animscripts/shared::func_D73();
	}

	self setflaggedanimknoballrestart("deathanim",param_00,%body,1,0.1);
	if(isdefined(self.skipdeathanim))
	{
		if(!isdefined(self.noragdoll))
		{
			self startragdoll();
		}

		wait 0.05;
		self animmode("gravity");
	}
	else if(isdefined(self.var_EC7))
	{
		thread func_0EC8(self.var_EC7);
	}
	else if(!animhasnotetrack(param_00,"start_ragdoll"))
	{
		thread func_0EC8(getanimlength(param_00) * 0.35);
	}

	if(!isdefined(self.skipdeathanim))
	{
		thread func_0EC9();
	}

	animscripts/shared::donotetracks("deathanim");
	animscripts/shared::func_D73();
}

//Function Number: 4
func_0EC8(param_00)
{
	wait param_00;
	if(isdefined(self))
	{
		animscripts/shared::func_D73();
	}

	if(isdefined(self) && !isdefined(self.noragdoll))
	{
		self startragdoll();
	}
}

//Function Number: 5
func_0EC9()
{
	self endon("killanimscript");
	if(self.var_786 != "none")
	{
		return;
	}

	wait 2;
	func_0ECA();
}

//Function Number: 6
func_0ECA(param_00,param_01)
{
	if(!isdefined(self))
	{
		return;
	}

	if(isdefined(self.skipbloodpool))
	{
		return;
	}

	var_02 = self gettagorigin("j_SpineUpper");
	var_03 = self gettagangles("j_SpineUpper");
	var_04 = anglestoforward(var_03);
	var_05 = anglestoup(var_03);
	var_06 = anglestoright(var_03);
	var_02 = var_02 + var_04 * -8.5 + var_05 * 5 + var_06 * 0;
	var_07 = bullettrace(var_02 + (0,0,30),var_02 - (0,0,100),0,undefined);
	if(var_07["normal"][2] > 0.9)
	{
		playfx(level._effect["deathfx_bloodpool_generic"],var_02);
	}
}

//Function Number: 7
specialdeath()
{
	if(self.a.var_D19 == "none")
	{
		return 0;
	}

	switch(self.a.var_D19)
	{
		case "cover_right":
			if(self.a.pose == "stand")
			{
				var_00 = [];
				func_0ECD(var_7B);
			}
			else
			{
				var_00 = [];
				if(animscripts/utility::func_D2F("head","neck"))
				{
				}
				else
				{
				}
	
				func_0ECD(var_7B);
			}
	
			return 1;
	var_7B[1]
	%cornercrr_alert_death_back
	var_7B[0]
	%cornercrr_alert_death_slideout
	var_7B[0]
	%cornercrr_alert_death_slideout
	var_7B[1]
	%corner_standr_deathb
	var_7B[0]
	%corner_standr_deatha
			break;

		case "cover_left":
			if(self.a.pose == "stand")
			{
				var_00 = [];
				func_0ECD(var_7B);
			}
			else
			{
				var_00 = [];
				func_0ECD(var_7B);
			}
	
			return 1;
	var_7B[1]
	%cornercrl_death_back
	var_7B[0]
	%cornercrl_death_side
	var_7B[1]
	%corner_standl_deathb
	var_7B[0]
	%corner_standl_deatha
			break;

		case "cover_stand":
			var_00 = [];
			func_0ECD(var_7B);
			return 1;
	var_7B[1]
	%coverstand_death_right
	var_7B[0]
	%coverstand_death_left
			break;

		case "cover_crouch":
			var_00 = [];
			if(animscripts/utility::func_D2F("head","neck") && self.var_723 > 135 || self.var_723 <= -45)
			{
			}
	
			if(self.var_723 > -45 && self.var_723 <= 45)
			{
			}
	
			func_0ECD(var_7B);
			return 1;
	var_7B[var_7B.size]
	%covercrouch_death_2
	var_7B[var_7B.size]
	%covercrouch_death_3
	var_7B[var_7B.size]
	%covercrouch_death_1
			break;

		case "saw":
			if(self.a.pose == "stand")
			{
				func_0ECD(animscripts/utility::array(%saw_gunner_death));
			}
			else if(self.a.pose == "crouch")
			{
				func_0ECD(animscripts/utility::array(%saw_gunner_lowwall_death));
			}
			else
			{
				func_0ECD(animscripts/utility::array(%saw_gunner_prone_death));
			}
			return 1;

		case "dying_crawl":
			if(isdefined(self.a.var_D29) && self.a.pose == "crouch")
			{
				var_00 = animscripts/utility::array(%dying_back_death_v2,%dying_back_death_v3,%dying_back_death_v4);
				func_0ECD(var_7B);
			}
			else
			{
				var_00 = animscripts/utility::array(%dying_crawl_death_v1,%dying_crawl_death_v2);
				func_0ECD(var_7B);
			}
			return 1;
	}

	return 0;
}

//Function Number: 8
func_0ECD(param_00)
{
	var_01 = param_00[randomint(param_00.size)];
	func_0D56(var_01);
	if(isdefined(self.deathanimscript))
	{
		self [[ self.deathanimscript ]]();
	}
}

//Function Number: 9
playdeathsound()
{
	animscripts/face::func_C41("death");
}

//Function Number: 10
func_0ECE(param_00,param_01,param_02)
{
	var_03 = param_02 * 20;
	for(var_04 = 0;var_04 < var_03;var_04++)
	{
		wait 0.05;
	}
}

//Function Number: 11
func_0D17()
{
	if(!isdefined(self))
	{
		return;
	}

	if(!isdefined(self.hatmodel))
	{
		return;
	}

	var_00 = getpartname(self.hatmodel,0);
	var_01 = spawn("script_model",self.origin + (0,0,64));
	var_01 setmodel(self.hatmodel);
	var_01.origin = self gettagorigin(var_00);
	var_01.angles = self gettagangles(var_00);
	var_01 thread func_0ED0(self.var_722);
	var_02 = self.hatmodel;
	self.hatmodel = undefined;
	wait 0.05;
	if(!isdefined(self))
	{
		return;
	}

	self detach(var_02,"");
}

//Function Number: 12
func_0ED0(param_00)
{
	var_01 = param_00;
	var_01 = var_01 * randomfloatrange(2000,4000);
	var_02 = var_01[0];
	var_03 = var_01[1];
	var_04 = randomfloatrange(1500,3000);
	var_05 = self.origin + (randomfloatrange(-1,1),randomfloatrange(-1,1),randomfloatrange(-1,1)) * 5;
	self physicslaunchclient(var_05,(var_02,var_03,var_04));
	wait 60;
	for(;;)
	{
		if(!isdefined(self))
		{
			return;
		}

		if(distancesquared(self.origin,level.player.origin) > 262144)
		{
			break;
		}

		wait 30;
	}

	self delete();
}

//Function Number: 13
func_0ED1(param_00)
{
	for(var_01 = 0;var_01 < level.var_A63.size;var_01++)
	{
		level.var_A63[var_01] func_0ED2(param_00);
	}
}

//Function Number: 14
func_0ED2(param_00)
{
	if(!isdefined(self.var_ED3))
	{
		return;
	}

	if(distance(param_00,self.var_ED3) < 80)
	{
		self.var_ED3 = undefined;
		self.var_A67 = gettime();
	}
}

//Function Number: 15
func_0ED4()
{
	if(self.a.movement != "run")
	{
		return 0;
	}

	if(self getmotionangle() > 60 || self getmotionangle() < -60)
	{
		return 0;
	}

	return 1;
}

//Function Number: 16
func_0ED5(param_00,param_01,param_02,param_03)
{
	if(isdefined(self.a.doinglongdeath))
	{
		return 0;
	}

	if(self.a.pose == "prone" || isdefined(self.a.var_D29))
	{
		return 0;
	}

	if(param_00 == "none")
	{
		return 0;
	}

	if(param_02 > 500)
	{
		return 1;
	}

	if(param_01 == "MOD_MELEE")
	{
		return 0;
	}

	if(self.a.movement == "run" && !func_0ED7(param_03,275))
	{
		if(randomint(100) < 65)
		{
			return 0;
		}
	}

	if(animscripts/utility::func_BEB(param_00) && self.maxhealth < param_02)
	{
		return 1;
	}

	if(animscripts/utility::func_CEA(param_00) && func_0ED7(param_03,512))
	{
		return 1;
	}

	if(func_0ED6(param_00) && func_0ED7(param_03,425))
	{
		return 1;
	}

	return 0;
}

//Function Number: 17
func_0ED6(param_00)
{
	if(param_00 == "deserteagle")
	{
		return 1;
	}

	return 0;
}

//Function Number: 18
func_0ED7(param_00,param_01)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	if(distance(self.origin,param_00.origin) > param_01)
	{
		return 0;
	}

	return 1;
}

//Function Number: 19
func_0ED8()
{
	if(func_0ED5(self.damageweapon,self.var_726,self.damagetaken,self.attacker))
	{
		var_00 = func_0ED9();
		if(isdefined(var_00))
		{
			return var_00;
		}
	}

	if(isdefined(self.a.var_D29))
	{
		if(self.a.pose == "crouch")
		{
			return func_0EE1();
		}
		else
		{
			animscripts/notetracks::func_D2A();
		}
	}

	if(self.a.pose == "stand")
	{
		if(func_0ED4())
		{
			return func_0EDA();
		}

		return func_0EDD();
	}

	if(self.a.pose == "crouch")
	{
		return func_0EDE();
	}

	if(self.a.pose == "prone")
	{
		return func_0EDF();
	}
}

//Function Number: 20
func_0ED9()
{
	var_00 = abs(self.var_723);
	if(var_00 < 45)
	{
		return;
	}

	if(var_00 > 150)
	{
		if(animscripts/utility::func_D2F("left_leg_upper","left_leg_lower","right_leg_upper","right_leg_lower","left_foot","right_foot"))
		{
			var_01 = animscripts/utility::array(%death_shotgun_legs,%death_stand_sniper_leg);
		}
		else
		{
			var_01 = [];
			if(self.damagelocation == "torso_lower")
			{
			}
		}
	}
	else if(self.var_723 < 0)
	{
		var_01 = animscripts/utility::array(%death_shotgun_spinl,%death_stand_sniper_spin1,%death_stand_sniper_chest1,%death_stand_sniper_chest2);
	}
	else
	{
		var_01 = animscripts/utility::array(%death_shotgun_spinr,%death_stand_sniper_spin2,%death_stand_sniper_chest1,%death_stand_sniper_chest2);
	}

	return var_7B[randomint(var_7B.size)];
}

//Function Number: 21
func_0EDA()
{
	var_00 = [];
	var_7B = animscripts/pain::func_D32(var_7B);
	if(!var_7B.size)
	{
		return func_0EDD();
	}

	return var_7B[randomint(var_7B.size)];
}

//Function Number: 22
func_0EDB(param_00)
{
	var_01 = [];
	for(var_02 = 0;var_02 < param_00.size;var_02++)
	{
		if(!isdefined(param_00[var_02]))
		{
			continue;
		}

		var_01[var_01.size] = param_00[var_02];
	}

	return var_01;
}

//Function Number: 23
func_0EDC()
{
	var_00 = [];
	if(abs(self.var_723) < 50)
	{
	}
	else
	{
		if(abs(self.var_723) < 110)
		{
		}

		if(animscripts/utility::func_D2F("torso_lower","torso_upper","left_leg_upper","left_leg_lower","right_leg_upper","right_leg_lower"))
		{
			if(!animscripts/utility::func_D2F("torso_upper"))
			{
			}
		}

		if(!animscripts/utility::func_D2F("head","neck","helmet","left_foot","right_foot","left_hand","right_hand","gun") && randomint(2) == 0)
		{
		}

		if(var_7B.size == 0 || animscripts/utility::func_D2F("torso_lower","torso_upper","neck","head","helmet","right_arm_upper","left_arm_upper"))
		{
		}
	}

	return var_7B;
}

//Function Number: 24
func_0EDD()
{
	var_00 = [];
	var_01 = [];
	if(animscripts/utility::func_C95())
	{
		var_00 = func_0EDC();
	}
	else
	{
		if(animscripts/utility::func_D2F("torso_lower","left_leg_upper","left_leg_lower","right_leg_lower","right_leg_lower"))
		{
			var_00[var_00.size] = func_0EE5(%exposed_death_groin);
			var_00[var_00.size] = func_0EE5(%stand_death_leg);
		}

		if(animscripts/utility::func_D2F("head","helmet"))
		{
			var_01[var_01.size] = func_0EE5(%exposed_death_headshot);
			var_01[var_01.size] = func_0EE5(%exposed_death_flop);
		}

		if(animscripts/utility::func_D2F("neck"))
		{
			var_01[var_01.size] = func_0EE5(%exposed_death_neckgrab);
		}

		if(animscripts/utility::func_D2F("torso_upper","left_arm_upper"))
		{
			var_01[var_01.size] = func_0EE5(%exposed_death_twist);
			var_01[var_01.size] = func_0EE5(%stand_death_shoulder_spin);
			var_01[var_01.size] = func_0EE5(%stand_death_shoulderback);
		}

		if(animscripts/utility::func_D2F("torso_upper"))
		{
			var_01[var_01.size] = func_0EE5(%stand_death_tumbleforward);
			var_01[var_01.size] = func_0EE5(%stand_death_stumbleforward);
		}

		if(self.var_723 > 135 || self.var_723 <= -135)
		{
			if(animscripts/utility::func_D2F("neck","head","helmet"))
			{
				var_01[var_01.size] = func_0EE5(%stand_death_face);
				var_01[var_01.size] = func_0EE5(%stand_death_headshot_slowfall);
			}

			if(animscripts/utility::func_D2F("torso_upper"))
			{
				var_01[var_01.size] = func_0EE5(%stand_death_tumbleback);
			}
		}
		else if(self.var_723 > -45 && self.var_723 <= 45)
		{
			var_01[var_01.size] = func_0EE5(%exposed_death_falltoknees);
			var_01[var_01.size] = func_0EE5(%exposed_death_falltoknees_02);
		}

		var_02 = var_01.size > 0;
		if(!var_02 || randomint(100) < 15)
		{
			var_01[var_01.size] = func_0EE5(%exposed_death_02);
			var_01[var_01.size] = func_0EE5(%exposed_death_nerve);
		}

		if(randomint(100) < 10 && func_0EE2())
		{
			var_01[var_01.size] = func_0EE6(%exposed_death_firing_02);
			var_01[var_01.size] = func_0EE6(%exposed_death_firing);
			var_01 = func_0EDB(var_01);
		}
	}

	if(var_01.size == 0)
	{
		var_01[var_01.size] = %exposed_death;
	}

	if(!self.a.disablelongdeath && self.var_786 == "none" && !isdefined(self.a.var_D13))
	{
		var_03 = randomint(var_01.size + var_7B.size);
		if(var_03 < var_01.size)
		{
			return var_01[var_03];
		}
		else
		{
			return var_7B[var_03 - var_01.size];
		}
	}

	return var_01[randomint(var_01.size)];
}

//Function Number: 25
func_0EDE()
{
	var_00 = [];
	if(animscripts/utility::func_D2F("head","neck"))
	{
	}

	if(animscripts/utility::func_D2F("torso_upper","torso_lower","left_arm_upper","right_arm_upper","neck"))
	{
	}

	if(var_7B.size < 2)
	{
	}

	if(var_7B.size < 2)
	{
	}

	return var_7B[randomint(var_7B.size)];
}

//Function Number: 26
func_0EDF()
{
	if(isdefined(self.a.var_EE0))
	{
		return %prone_death_quickdeath;
	}

	return %dying_crawl_death_v1;
}

//Function Number: 27
func_0EE1()
{
	var_00 = animscripts/utility::array(%dying_back_death_v1,%dying_back_death_v2,%dying_back_death_v3,%dying_back_death_v4);
	return var_00[randomint(var_00.size)];
}

//Function Number: 28
func_0EE2()
{
	if(!isdefined(self.weapon) || !animscripts/utility::func_EE3() || !weaponisauto(self.weapon) || self.diequietly)
	{
		return 0;
	}

	if(self.a.weaponpos["right"] == "none")
	{
		return 0;
	}

	return 1;
}

//Function Number: 29
func_0EE5(param_00)
{
	return param_00;
}

//Function Number: 30
func_0EE6(param_00)
{
	return param_00;
}

//Function Number: 31
func_0EE7()
{
	if(isdefined(self.juggernaut))
	{
		return 0;
	}

	if(self.damagelocation != "none")
	{
		return 0;
	}

	var_00 = [];
	if(self.a.movement != "run")
	{
		if(self.var_723 > 135 || self.var_723 <= -135)
		{
		}
		else if(self.var_723 > 45 && self.var_723 <= 135)
		{
		}
		else if(self.var_723 > -45 && self.var_723 <= 45)
		{
		}
		else
		{
		}
	}
	else if(self.var_723 > 135 || self.var_723 <= -135)
	{
	}
	else if(self.var_723 > 45 && self.var_723 <= 135)
	{
	}
	else if(self.var_723 > -45 && self.var_723 <= 45)
	{
	}
	else
	{
	}

	var_01 = var_7B[randomint(var_7B.size)];
	if(getdvar("scr_expDeathMayMoveCheck","on") == "on")
	{
		var_02 = getmovedelta(var_01,0,1);
		var_03 = self localtoworldcoords(var_02);
		if(!self maymovetopoint(var_03,0))
		{
			return 0;
		}
	}

	self animmode("nogravity");
	func_0D56(var_01);
	return 1;
}