/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\pain.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 48
 * Decompile Time: 893 ms
 * Timestamp: 10/27/2023 2:30:38 AM
*******************************************************************/

//Function Number: 1
main()
{
	if(isdefined(self.longdeathstarting))
	{
		self waittill("killanimscript");
		return;
	}

	if([[ level.pain_test ]]())
	{
		return;
	}

	if(self.a.disablepain)
	{
		return;
	}

	self notify("kill_long_death");
	if(isdefined(self.a.paintime))
	{
		self.a.lastpaintime = self.a.paintime;
	}
	else
	{
		self.a.lastpaintime = 0;
	}

	self.a.paintime = gettime();
	if(self.stairsstate != "none")
	{
		self.a.painonstairs = 1;
	}
	else
	{
		self.a.painonstairs = undefined;
	}

	if(self.a.nextstandinghitdying)
	{
		self.health = 1;
	}

	var_00 = 0;
	var_01 = 0;
	var_02 = self.health / self.maxhealth;
	self notify("anim entered pain");
	self endon("killanimscript");
	animscripts/utility::initialize("pain");
	self animmode("gravity");
	if(!isdefined(self.no_pain_sound))
	{
		animscripts/face::saygenericdialogue("pain");
	}

	if(self.damagelocation == "helmet")
	{
		animscripts/death::helmetpop();
	}
	else if(wasdamagedbyexplosive() && randomint(2) == 0)
	{
		animscripts/death::helmetpop();
	}

	if(isdefined(self.painfunction))
	{
		self [[ self.painfunction ]]();
		return;
	}

	if(crawlingpain())
	{
		return;
	}

	if(specialpain(self.a.special))
	{
		return;
	}

	var_03 = getpainanim();
	func_0920(var_03);
}

//Function Number: 2
initpainfx()
{
	level._effect["crawling_death_blood_smear"] = loadfx("impacts/blood_smear_decal");
}

//Function Number: 3
end_script()
{
	if(isdefined(self.damageshieldpain))
	{
		self.var_907 = undefined;
		self.damageshieldpain = undefined;
		self.allowpain = 1;
		if(!isdefined(self.predamageshieldignoreme))
		{
			self.ignoreme = 0;
		}

		self.predamageshieldignoreme = undefined;
	}

	if(isdefined(self.blockingpain))
	{
		self.blockingpain = undefined;
		self.allowpain = 1;
	}
}

//Function Number: 4
wasdamagedbyexplosive()
{
	if(isexplosivedamagemod(self.damagemod))
	{
		return 1;
	}

	if(gettime() - level.lastcarexplosiontime <= 50)
	{
		var_00 = level.lastcarexplosionrange * level.lastcarexplosionrange * 1.2 * 1.2;
		if(distancesquared(self.origin,level.lastcarexplosiondamagelocation) < var_00)
		{
			var_01 = var_00 * 0.5 * 0.5;
			self.maydoupwardsdeath = distancesquared(self.origin,level.lastcarexplosionlocation) < var_01;
			return 1;
		}
	}

	return 0;
}

//Function Number: 5
getdamageshieldpainanim()
{
	if(self.a.var_911 == "prone")
	{
		return;
	}

	if(isdefined(self.lastattacker) && isdefined(self.lastattacker.team) && self.lastattacker.team == self.team)
	{
		return;
	}

	if(!isdefined(self.var_907) || gettime() - self.a.lastpaintime > 1500)
	{
		self.var_907 = randomintrange(2,3);
	}

	if(isdefined(self.lastattacker) && distancesquared(self.origin,self.lastattacker.origin) < squared(512))
	{
		self.var_907 = 0;
	}

	if(self.var_907 > 0)
	{
		self.var_907--;
		return;
	}

	self.damageshieldpain = 1;
	self.allowpain = 0;
	if(self.ignoreme)
	{
		self.predamageshieldignoreme = 1;
	}
	else
	{
		self.ignoreme = 1;
	}

	if(animscripts/utility::usingsidearm())
	{
		animscripts/shared::placeweaponon(self.primaryweapon,"right");
	}

	if(self.a.var_911 == "crouch")
	{
		return %exposed_crouch_extendedpaina;
	}

	var_00 = animscripts/utility::array(%stand_exposed_extendedpain_chest,%stand_exposed_extendedpain_head_2_crouch,%stand_exposed_extendedpain_hip_2_crouch);
	return var_00[randomint(var_00.size)];
}

//Function Number: 6
getpainanim()
{
	if(self.damageshield && !isdefined(self.disabledamageshieldpain))
	{
		var_00 = getdamageshieldpainanim();
		if(isdefined(var_00))
		{
			return var_00;
		}
	}

	if(isdefined(self.a.onback))
	{
		if(self.a.var_911 == "crouch")
		{
			return %back_pain;
		}
		else
		{
			animscripts/notetracks::stoponback();
		}
	}

	if(self.a.var_911 == "stand")
	{
		var_01 = isdefined(self.node) && distancesquared(self.origin,self.node.origin) < 4096;
		if(!var_01 && self.a.movement == "run" && abs(self getmotionangle()) < 60)
		{
			return getrunningforwardpainanim();
		}

		self.a.movement = "stop";
		return getstandpainanim();
	}

	if(self.a.var_911 == "crouch")
	{
		self.a.movement = "stop";
		return getcrouchpainanim();
	}

	if(self.a.var_911 == "prone")
	{
		self.a.movement = "stop";
		return getpronepainanim();
	}
}

//Function Number: 7
getrunningforwardpainanim()
{
	var_00 = [];
	var_01 = 0;
	var_02 = 0;
	var_03 = 0;
	if(self maymovetopoint(self localtoworldcoords((300,0,0))))
	{
		var_02 = 1;
		var_01 = 1;
	}
	else if(self maymovetopoint(self localtoworldcoords((200,0,0))))
	{
		var_01 = 1;
	}

	if(isdefined(self.a.disablelongpain))
	{
		var_02 = 0;
		var_01 = 0;
	}

	if(var_02)
	{
		var_00[var_00.size] = %run_pain_leg;
		var_00[var_00.size] = %run_pain_shoulder;
		var_00[var_00.size] = %run_pain_stomach_stumble;
		var_00[var_00.size] = %run_pain_head;
	}

	if(var_01)
	{
		var_00[var_00.size] = %run_pain_fallonknee_02;
		var_00[var_00.size] = %run_pain_stomach;
		var_00[var_00.size] = %run_pain_stumble;
		var_00[var_00.size] = %run_pain_stomach_fast;
		var_00[var_00.size] = %run_pain_leg_fast;
		var_00[var_00.size] = %run_pain_fall;
	}
	else if(self maymovetopoint(self localtoworldcoords((120,0,0))))
	{
		var_00[var_00.size] = %run_pain_fallonknee;
		var_00[var_00.size] = %run_pain_fallonknee_03;
	}

	if(!var_00.size)
	{
		self.a.movement = "stop";
		return getstandpainanim();
	}

	return var_00[randomint(var_00.size)];
}

//Function Number: 8
getstandpistolpainanim()
{
	var_00 = [];
	if(animscripts/utility::damagelocationisany("torso_upper","torso_lower","left_arm_upper","right_arm_upper","neck"))
	{
	}

	if(animscripts/utility::damagelocationisany("torso_lower","left_leg_upper","right_leg_upper"))
	{
	}

	if(animscripts/utility::damagelocationisany("head","neck"))
	{
	}

	if(animscripts/utility::damagelocationisany("left_arm_lower","left_arm_upper","torso_upper"))
	{
	}

	if(animscripts/utility::damagelocationisany("right_arm_lower","right_arm_upper","torso_upper"))
	{
	}

	if(var_41.size < 2)
	{
	}

	if(var_41.size < 2)
	{
	}

	return var_41[randomint(var_41.size)];
}

//Function Number: 9
getstandpainanim()
{
	if(animscripts/utility::usingsidearm())
	{
		return getstandpistolpainanim();
	}

	var_00 = [];
	var_01 = [];
	if(animscripts/utility::damagelocationisany("torso_upper","torso_lower"))
	{
	}

	if(animscripts/utility::damagelocationisany("torso_upper","head","helmet","neck"))
	{
		var_01[var_01.size] = %exposed_pain_face;
		var_01[var_01.size] = %stand_exposed_extendedpain_neck;
	}

	if(animscripts/utility::damagelocationisany("right_arm_upper","right_arm_lower"))
	{
		var_01[var_01.size] = %exposed_pain_right_arm;
	}

	if(animscripts/utility::damagelocationisany("left_arm_lower","left_arm_upper"))
	{
		var_01[var_01.size] = %stand_exposed_extendedpain_shoulderswing;
	}

	if(animscripts/utility::damagelocationisany("torso_lower","left_leg_upper","right_leg_upper"))
	{
		var_01[var_01.size] = %exposed_pain_groin;
		var_01[var_01.size] = %stand_exposed_extendedpain_hip;
	}

	if(animscripts/utility::damagelocationisany("left_foot","right_foot","left_leg_lower","right_leg_lower"))
	{
		var_01[var_01.size] = %stand_exposed_extendedpain_thigh;
	}

	if(var_01.size < 2)
	{
		if(!self.a.disablelongdeath)
		{
			var_01[var_01.size] = %exposed_pain_2_crouch;
			var_01[var_01.size] = %stand_extendedpainb;
		}
		else
		{
			var_01[var_01.size] = %exposed_pain_right_arm;
			var_01[var_01.size] = %exposed_pain_face;
			var_01[var_01.size] = %exposed_pain_groin;
		}
	}

	if(var_41.size < 2)
	{
	}

	if(!self.damageshield && !self.a.disablelongdeath)
	{
		var_02 = randomint(var_01.size + var_41.size);
		if(var_02 < var_01.size)
		{
			return var_01[var_02];
		}
		else
		{
			return var_41[var_02 - var_01.size];
		}
	}

	return var_01[randomint(var_01.size)];
}

//Function Number: 10
removeblockedanims(param_00)
{
	var_01 = [];
	for(var_02 = 0;var_02 < param_00.size;var_02++)
	{
		var_03 = param_00[var_02];
		var_04 = 1;
		if(animhasnotetrack(var_03,"code_move"))
		{
			var_04 = getnotetracktimes(var_03,"code_move")[0];
		}

		var_05 = getmovedelta(var_03,0,var_04);
		var_06 = self localtoworldcoords(var_05);
		if(self maymovetopoint(var_06,1,1))
		{
			var_01[var_01.size] = var_03;
		}
	}

	return var_01;
}

//Function Number: 11
getcrouchpainanim()
{
	var_00 = [];
	if(!self.damageshield && !self.a.disablelongdeath)
	{
	}

	if(animscripts/utility::damagelocationisany("left_hand","left_arm_lower","left_arm_upper"))
	{
	}

	if(animscripts/utility::damagelocationisany("right_hand","right_arm_lower","right_arm_upper"))
	{
	}

	return var_41[randomint(var_41.size)];
}

//Function Number: 12
getpronepainanim()
{
	if(randomint(2) == 0)
	{
		return %prone_reaction_a;
	}

	return %prone_reaction_b;
}

//Function Number: 13
func_0920(param_00)
{
	var_01 = 1;
	self setflaggedanimknoballrestart("painanim",param_00,%body,1,0.1,var_01);
	if(self.a.var_911 == "prone")
	{
		self updateprone(%prone_legs_up,%prone_legs_down,1,0.1,1);
	}

	if(animhasnotetrack(param_00,"start_aim"))
	{
		thread notifystartaim("painanim");
		self endon("start_aim");
	}

	if(animhasnotetrack(param_00,"code_move"))
	{
		animscripts/shared::donotetracks("painanim");
	}

	animscripts/shared::donotetracks("painanim");
}

//Function Number: 14
notifystartaim(param_00)
{
	self endon("killanimscript");
	self waittillmatch("start_aim",param_00);
	self notify("start_aim");
}

//Function Number: 15
specialpainblocker()
{
	self endon("killanimscript");
	self.blockingpain = 1;
	self.allowpain = 0;
	wait 0.5;
	self.blockingpain = undefined;
	self.allowpain = 1;
}

//Function Number: 16
specialpain(param_00)
{
	if(param_00 == "none")
	{
		return 0;
	}

	self.a.special = "none";
	thread specialpainblocker();
	switch(param_00)
	{
		case "cover_left":
			if(self.a.var_911 == "stand")
			{
				var_01 = [];
				dopainfromarray(var_41);
				var_01 = 1;
			}
			else if(self.a.var_911 == "crouch")
			{
				var_01 = [];
				dopainfromarray(var_41);
				var_01 = 1;
			}
			else
			{
				var_02 = 0;
			}
	
			break;
	var_41[var_01.size]
	%cornercrl_painb
	var_41[var_41.size]
	%corner_standl_paine
	var_41[var_41.size]
	%corner_standl_paind
	var_41[var_41.size]
	%corner_standl_painc
	var_41[var_01.size]
	%corner_standl_painb
			break;

		case "cover_right":
			if(self.a.var_911 == "stand")
			{
				var_01 = [];
				dopainfromarray(var_41);
				var_01 = 1;
			}
			else if(self.a.var_911 == "crouch")
			{
				var_01 = [];
				dopainfromarray(var_41);
				var_01 = 1;
			}
			else
			{
				var_02 = 0;
			}
	
			break;
	var_41[var_41.size]
	%cornercrr_alert_painc
	var_41[var_01.size]
	%cornercrr_alert_paina
	var_41[2]
	%corner_standr_painc
	var_41[1]
	%corner_standr_painb
	var_41[0]
	%corner_standr_pain
			break;

		case "cover_right_stand_A":
			var_02 = 0;
			break;

		case "cover_right_stand_B":
			dopain(%corner_standr_pain_b_2_alert);
			var_02 = 1;
			break;

		case "cover_left_stand_A":
			dopain(%corner_standl_pain_a_2_alert);
			var_02 = 1;
			break;

		case "cover_left_stand_B":
			dopain(%corner_standl_pain_b_2_alert);
			var_02 = 1;
			break;

		case "cover_crouch":
			var_01 = [];
			dopainfromarray(var_41);
			var_01 = 1;
			break;
	var_41[var_41.size]
	%covercrouch_pain_left_3
	var_41[var_41.size]
	%covercrouch_pain_front
	var_41[var_01.size]
	%covercrouch_pain_right
			break;

		case "cover_stand":
			var_01 = [];
			dopainfromarray(var_41);
			var_01 = 1;
			break;
	var_41[var_41.size]
	%coverstand_pain_leg
	var_41[var_01.size]
	%coverstand_pain_groin
			break;

		case "cover_stand_aim":
			var_01 = [];
			dopainfromarray(var_41);
			var_01 = 1;
			break;
	var_41[var_41.size]
	%coverstand_pain_aim_2_hide_02
	var_41[var_01.size]
	%coverstand_pain_aim_2_hide_01
			break;

		case "cover_crouch_aim":
			dopain(%covercrouch_pain_aim_2_hide_01);
			var_02 = 1;
			break;

		case "saw":
			if(self.a.var_911 == "stand")
			{
				var_03 = %saw_gunner_pain;
			}
			else if(self.a.var_911 == "crouch")
			{
				var_03 = %saw_gunner_lowwall_pain_02;
			}
			else
			{
				var_03 = %saw_gunner_prone_pain;
			}
	
			self setflaggedanimknob("painanim",var_03,1,0.3,1);
			animscripts/shared::donotetracks("painanim");
			var_01 = 1;
			break;

		case "mg42":
			mg42pain(self.a.var_911);
			var_02 = 1;
			break;

		case "minigun":
			var_02 = 0;
			break;

		case "corner_right_martyrdom":
			var_02 = func_095B();
			break;

		case "rambo":
		case "rambo_right":
		case "rambo_left":
		case "dying_crawl":
			var_02 = 0;
			break;

		default:
			var_02 = 0;
			break;
	}

	return var_01;
}

//Function Number: 17
paindeathnotify()
{
	self endon("death");
	wait 0.05;
	self notify("pain_death");
}

//Function Number: 18
dopainfromarray(param_00)
{
	var_01 = param_00[randomint(param_00.size)];
	self setflaggedanimknob("painanim",var_01,1,0.3,1);
	animscripts/shared::donotetracks("painanim");
}

//Function Number: 19
dopain(param_00)
{
	self setflaggedanimknob("painanim",param_00,1,0.3,1);
	animscripts/shared::donotetracks("painanim");
}

//Function Number: 20
mg42pain(param_00)
{
	self setflaggedanimknob("painanim",level.mg_animmg["pain_" + param_00],1,0.1,1);
	animscripts/shared::donotetracks("painanim");
}

//Function Number: 21
waitsetstop(param_00,param_01)
{
	self endon("killanimscript");
	self endon("death");
	if(isdefined(param_01))
	{
		self endon(param_01);
	}

	wait param_00;
	self.a.movement = "stop";
}

//Function Number: 22
crawlingpain()
{
	if(self.a.disablelongdeath || self.diequietly || self.damageshield)
	{
		return 0;
	}

	if(self.stairsstate != "none")
	{
		return 0;
	}

	if(isdefined(self.a.onback))
	{
		return 0;
	}

	var_00["prone"] = animscripts/utility::array(%dying_crawl_2_back);
	self.a.crawlingpaintransanim = var_41[self.a.var_911][randomint(var_41[self.a.var_911].size)];
	if(isdefined(self.forcelongdeath))
	{
		self.health = 10;
		thread crawlingpistol();
		self waittill(animscripts/utility::array(%dying_stand_2_back_v1,%dying_stand_2_back_v2),var_41["stand"],animscripts/utility::array(%dying_crouch_2_back),var_41["crouch"],"killanimscript");
		return 1;
	}

	if(!iscrawldeltaallowed(self.a.crawlingpaintransanim))
	{
		return 0;
	}

	if(self.health > 100)
	{
		return 0;
	}

	var_01 = animscripts/utility::damagelocationisany("left_leg_upper","left_leg_lower","right_leg_upper","right_leg_lower","left_foot","right_foot");
	if(var_01 && self.health < self.maxhealth * 0.4)
	{
		if(gettime() < level.nextcrawlingpaintimefromlegdamage)
		{
			return 0;
		}
	}
	else
	{
		if(level.numdeathsuntilcrawlingpain > 0)
		{
			return 0;
		}

		if(gettime() < level.nextcrawlingpaintime)
		{
			return 0;
		}
	}

	if(isdefined(self.deathfunction))
	{
		return 0;
	}

	foreach(var_03 in level.players)
	{
		if(distance(self.origin,var_03.origin) < 175)
		{
			return 0;
		}
	}

	if(animscripts/utility::damagelocationisany("head","helmet","gun","right_hand","left_hand"))
	{
		return 0;
	}

	if(animscripts/utility::usingsidearm())
	{
		return 0;
	}

	anim.nextcrawlingpaintime = gettime() + 3000;
	anim.nextcrawlingpaintimefromlegdamage = gettime() + 3000;
	thread crawlingpistol();
	self waittill("killanimscript");
	return 1;
}

//Function Number: 23
iscrawldeltaallowed(param_00)
{
	if(isdefined(self.a.force_num_crawls))
	{
		return 1;
	}

	var_01 = getmovedelta(param_00,0,1);
	var_02 = self localtoworldcoords(var_01);
	return self maymovetopoint(var_02);
}

//Function Number: 24
initcrawlingpistolanims()
{
	self.a.array = [];
	self.a.array["stand_2_crawl"] = animscripts/utility::array(%dying_stand_2_crawl_v1,%dying_stand_2_crawl_v2,%dying_stand_2_crawl_v3);
	self.a.array["crouch_2_crawl"] = animscripts/utility::array(%dying_crouch_2_crawl);
	self.a.array["crawl"] = %dying_crawl;
	self.a.array["death"] = animscripts/utility::array(%dying_crawl_death_v1,%dying_crawl_death_v2);
	self.a.array["back_idle"] = %dying_back_idle;
	self.a.array["back_idle_twitch"] = animscripts/utility::array(%dying_back_twitch_a,%dying_back_twitch_b);
	self.a.array["back_crawl"] = %dying_crawl_back;
	self.a.array["back_fire"] = %dying_back_fire;
	self.a.array["back_death"] = animscripts/utility::array(%dying_back_death_v1,%dying_back_death_v2,%dying_back_death_v3);
	if(isdefined(self.var_934))
	{
		[[ self.var_934 ]]();
	}
}

//Function Number: 25
crawlingpistol()
{
	self endon("kill_long_death");
	self endon("death");
	initcrawlingpistolanims();
	thread preventpainforashorttime("crawling");
	self.a.special = "none";
	self.specialdeathfunc = undefined;
	thread paindeathnotify();
	level notify("ai_crawling",self);
	thread func_093C();
	self setanimknoball(%dying,%body,1,0.1,1);
	if(!dyingcrawl())
	{
		return;
	}

	self setflaggedanimknob("transition",self.a.crawlingpaintransanim,1,0.5,1);
	animscripts/notetracks::donotetracksintercept("transition",::handlebackcrawlnotetracks);
	self.a.special = "dying_crawl";
	thread dyingcrawlbackaim();
	if(isdefined(self.enemy))
	{
		self setlookatentity(self.enemy);
	}

	decidenumcrawls();
	while(shouldkeepcrawling())
	{
		var_00 = animscripts/utility::animarray("back_crawl");
		if(!iscrawldeltaallowed(var_00))
		{
			break;
		}

		self setflaggedanimknobrestart("back_crawl",var_00,1,0.1,1);
		animscripts/notetracks::donotetracksintercept("back_crawl",::handlebackcrawlnotetracks);
	}

	self.desiredtimeofdeath = gettime() + randomintrange(4000,20000);
	while(shouldstayalive())
	{
		if(animscripts/utility::canseeenemy() && aimedsomewhatatenemy())
		{
			var_01 = animscripts/utility::animarray("back_fire");
			self setflaggedanimknobrestart("back_idle_or_fire",var_01,1,0.2,1);
			animscripts/shared::donotetracks("back_idle_or_fire");
			continue;
		}

		var_01 = animscripts/utility::animarray("back_idle");
		if(randomfloat(1) < 0.4)
		{
			var_01 = animscripts/utility::animarraypickrandom("back_idle_twitch");
		}

		self setflaggedanimknobrestart("back_idle_or_fire",var_01,1,0.1,1);
		var_02 = getanimlength(var_01);
		while(var_02 > 0)
		{
			if(animscripts/utility::canseeenemy() && aimedsomewhatatenemy())
			{
				break;
			}

			var_03 = 0.5;
			if(var_03 > var_02)
			{
				var_03 = var_02;
				var_02 = 0;
				continue;
			}

			var_02 = var_02 - var_03;
			animscripts/notetracks::donotetracksfortime(var_03,"back_idle_or_fire");
		}
	}

	self notify("end_dying_crawl_back_aim");
	self clearanim(%dying_back_aim_4_wrapper,0.3);
	self clearanim(%dying_back_aim_6_wrapper,0.3);
	self.var_93B = animscripts/utility::animarraypickrandom("back_death");
	killwrapper();
	self.a.special = "none";
	self.specialdeathfunc = undefined;
}

//Function Number: 26
func_093C()
{
	if(self.team == "allies")
	{
		return;
	}

	self endon("end_dying_crawl_back_aim");
	self waittill("death",var_00,var_01);
	if(!isdefined(self) || !isdefined(var_00) || !isplayer(var_00))
	{
	}
}

//Function Number: 27
shouldstayalive()
{
	if(!enemyisingeneraldirection(anglestoforward(self.angles)))
	{
		return 0;
	}

	return gettime() < self.desiredtimeofdeath;
}

//Function Number: 28
dyingcrawl()
{
	if(!isdefined(self.forcelongdeath))
	{
		if(self.a.var_911 == "prone")
		{
			return 1;
		}

		if(self.a.movement == "stop")
		{
			if(randomfloat(1) < 0.4)
			{
				if(randomfloat(1) < 0.5)
				{
					return 1;
				}
			}
			else if(abs(self.damageyaw) > 90)
			{
				return 1;
			}
		}
		else if(abs(self getmotionangle()) > 90)
		{
			return 1;
		}
	}

	if(self.a.var_911 != "prone")
	{
		var_00 = animscripts/utility::animarraypickrandom(self.a.var_911 + "_2_crawl");
		if(!iscrawldeltaallowed(var_00))
		{
			return 1;
		}

		thread dyingcrawlbloodsmear();
		self setflaggedanimknob("falling",var_00,1,0.5,1);
		animscripts/shared::donotetracks("falling");
	}
	else
	{
		thread dyingcrawlbloodsmear();
	}

	self.a.crawlingpaintransanim = %dying_crawl_2_back;
	self.a.special = "dying_crawl";
	decidenumcrawls();
	while(shouldkeepcrawling())
	{
		var_01 = animscripts/utility::animarray("crawl");
		if(!iscrawldeltaallowed(var_01))
		{
			return 1;
		}

		if(isdefined(self.custom_crawl_sound))
		{
			self playsound(self.custom_crawl_sound);
		}

		self setflaggedanimknobrestart("crawling",var_01,1,0.1,1);
		animscripts/shared::donotetracks("crawling");
	}

	self notify("done_crawling");
	if(!isdefined(self.forcelongdeath) && enemyisingeneraldirection(anglestoforward(self.angles) * -1))
	{
		return 1;
	}

	var_02 = animscripts/utility::animarraypickrandom("death");
	if(var_02 != %dying_crawl_death_v2)
	{
		self.a.nodeath = 1;
	}

	animscripts/death::func_941(var_02);
	killwrapper();
	self.a.special = "none";
	self.specialdeathfunc = undefined;
	return 0;
}

//Function Number: 29
dyingcrawlbloodsmear()
{
	self endon("death");
	if(self.a.var_911 != "prone")
	{
		for(;;)
		{
			self waittill("falling",var_00);
			if(issubstr(var_00,"bodyfall"))
			{
				break;
			}
		}
	}

	var_01 = "J_SpineLower";
	var_02 = "tag_origin";
	var_03 = 0.25;
	var_04 = level._effect["crawling_death_blood_smear"];
	if(isdefined(self.a.crawl_fx_rate))
	{
		var_03 = self.a.crawl_fx_rate;
	}

	if(isdefined(self.a.crawl_fx))
	{
		var_04 = level._effect[self.a.crawl_fx];
	}

	while(var_03)
	{
		var_05 = self gettagorigin(var_01);
		var_06 = self gettagangles(var_02);
		var_07 = anglestoright(var_06);
		var_08 = anglestoforward((270,0,0));
		playfx(var_04,var_05,var_08,var_07);
		wait var_03;
	}
}

//Function Number: 30
dyingcrawlbackaim()
{
	self endon("kill_long_death");
	self endon("death");
	self endon("end_dying_crawl_back_aim");
	if(isdefined(self.dyingcrawlaiming))
	{
		return;
	}

	self.dyingcrawlaiming = 1;
	self setanimlimited(%dying_back_aim_4,1,0);
	self setanimlimited(%dying_back_aim_6,1,0);
	var_00 = 0;
	for(;;)
	{
		var_01 = animscripts/utility::getyawtoenemy();
		var_02 = angleclamp180(var_01 - var_00);
		if(abs(var_02) > 3)
		{
			var_02 = common_scripts\utility::sign(var_02) * 3;
		}

		var_01 = angleclamp180(var_00 + var_02);
		if(var_01 < 0)
		{
			if(var_01 < -45)
			{
				var_01 = -45;
			}

			var_03 = var_01 / -45;
			self setanim(%dying_back_aim_4_wrapper,var_03,0.05);
			self setanim(%dying_back_aim_6_wrapper,0,0.05);
		}
		else
		{
			if(var_01 > 45)
			{
				var_01 = 45;
			}

			var_03 = var_01 / 45;
			self setanim(%dying_back_aim_6_wrapper,var_03,0.05);
			self setanim(%dying_back_aim_4_wrapper,0,0.05);
		}

		var_00 = var_01;
		wait 0.05;
	}
}

//Function Number: 31
startdyingcrawlbackaimsoon()
{
	self endon("kill_long_death");
	self endon("death");
	wait 0.5;
	thread dyingcrawlbackaim();
}

//Function Number: 32
handlebackcrawlnotetracks(param_00)
{
	if(param_00 == "fire_spray")
	{
		if(!animscripts/utility::canseeenemy())
		{
			return 1;
		}

		if(!aimedsomewhatatenemy())
		{
			return 1;
		}

		animscripts/utility::shootenemywrapper();
		return 1;
	}
	else if(param_00 == "pistol_pickup")
	{
		thread startdyingcrawlbackaimsoon();
		return 0;
	}

	return 0;
}

//Function Number: 33
aimedsomewhatatenemy()
{
	var_00 = self.enemy getshootatpos();
	var_01 = self getmuzzleangle();
	var_02 = vectortoangles(var_00 - self getmuzzlepos());
	var_03 = animscripts/utility::absangleclamp180(var_01[1] - var_02[1]);
	if(var_03 > level.painyawdifffartolerance)
	{
		if(distancesquared(self geteye(),var_00) > level.painyawdiffclosedistsq || var_03 > level.painyawdiffclosetolerance)
		{
			return 0;
		}
	}

	return animscripts/utility::absangleclamp180(var_01[0] - var_02[0]) <= level.painpitchdifftolerance;
}

//Function Number: 34
enemyisingeneraldirection(param_00)
{
	if(!isdefined(self.enemy))
	{
		return 0;
	}

	var_01 = vectornormalize(self.enemy getshootatpos() - self geteye());
	return vectordot(var_01,param_00) > 0.5;
}

//Function Number: 35
preventpainforashorttime(param_00)
{
	self endon("kill_long_death");
	self endon("death");
	self.flashbangimmunity = 1;
	self.longdeathstarting = 1;
	self.a.doinglongdeath = 1;
	self notify("long_death");
	self.health = 10000;
	self.threatbias = self.threatbias - 2000;
	wait 0.75;
	if(self.health > 1)
	{
		self.health = 1;
	}

	wait 0.05;
	self.longdeathstarting = undefined;
	self.a.mayonlydie = 1;
	if(param_00 == "crawling")
	{
		wait 1;
		if(isdefined(level.player) && distancesquared(self.origin,level.player.origin) < 1048576)
		{
			anim.numdeathsuntilcrawlingpain = randomintrange(10,30);
			anim.nextcrawlingpaintime = gettime() + randomintrange(15000,-5536);
		}
		else
		{
			anim.numdeathsuntilcrawlingpain = randomintrange(5,12);
			anim.nextcrawlingpaintime = gettime() + randomintrange(5000,25000);
		}

		anim.nextcrawlingpaintimefromlegdamage = gettime() + randomintrange(7000,13000);
		return;
	}

	if(param_00 == "corner_grenade")
	{
		wait 1;
		if(isdefined(level.player) && distancesquared(self.origin,level.player.origin) < 490000)
		{
			anim.numdeathsuntilcornergrenadedeath = randomintrange(10,30);
			anim.nextcornergrenadedeathtime = gettime() + randomintrange(15000,-5536);
			return;
		}

		anim.numdeathsuntilcornergrenadedeath = randomintrange(5,12);
		anim.nextcornergrenadedeathtime = gettime() + randomintrange(5000,25000);
		return;
	}
}

//Function Number: 36
decidenumcrawls()
{
	if(isdefined(self.a.force_num_crawls))
	{
		self.a.numcrawls = self.a.force_num_crawls;
		return;
	}

	self.a.numcrawls = randomintrange(1,5);
}

//Function Number: 37
shouldkeepcrawling()
{
	if(!self.a.numcrawls)
	{
		self.a.numcrawls = undefined;
		return 0;
	}

	self.a.numcrawls--;
	return 1;
}

//Function Number: 38
func_095B()
{
	if(level.numdeathsuntilcornergrenadedeath > 0)
	{
		return 0;
	}

	if(gettime() < level.nextcornergrenadedeathtime)
	{
		return 0;
	}

	if(self.a.disablelongdeath || self.diequietly || self.damageshield)
	{
		return 0;
	}

	if(isdefined(self.deathfunction))
	{
		return 0;
	}

	if(distance(self.origin,level.player.origin) < 175)
	{
		return 0;
	}

	anim.nextcornergrenadedeathtime = gettime() + 3000;
	thread cornerrightgrenadedeath();
	self waittill("killanimscript");
	return 1;
}

//Function Number: 39
cornerrightgrenadedeath()
{
	self endon("kill_long_death");
	self endon("death");
	thread paindeathnotify();
	thread preventpainforashorttime("corner_grenade");
	thread maps\_utility::func_95D(0);
	self.threatbias = -1000;
	self setflaggedanimknoballrestart("corner_grenade_pain",%corner_standr_death_grenade_hit,%body,1,0.1);
	self waittillmatch("dropgun","corner_grenade_pain");
	animscripts/shared::dropallaiweapons();
	self waittillmatch("anim_pose = \"back\","corner_grenade_pain");
	animscripts/notetracks::notetrackposeback();
	self waittillmatch("grenade_left","corner_grenade_pain");
	var_00 = getweaponmodel("fraggrenade");
	self attach(var_00,"tag_inhand");
	self.deathfunction = ::prematurecornergrenadedeath;
	self waittillmatch("end","corner_grenade_pain");
	var_01 = gettime() + randomintrange(25000,-5536);
	self setflaggedanimknoballrestart("corner_grenade_idle",%corner_standr_death_grenade_idle,%body,1,0.2);
	thread watchenemyvelocity();
	while(!enemyisapproaching())
	{
		if(gettime() >= var_01)
		{
			break;
		}

		animscripts/notetracks::donotetracksfortime(0.1,"corner_grenade_idle");
	}

	var_02 = %corner_standr_death_grenade_slump;
	self setflaggedanimknoballrestart("corner_grenade_release",var_02,%body,1,0.2);
	var_03 = getnotetracktimes(var_02,"grenade_drop");
	var_04 = var_03[0] * getanimlength(var_02);
	wait var_04 - 1;
	animscripts/death::playdeathsound();
	wait 0.7;
	self.deathfunction = ::waittillgrenadedrops;
	var_05 = (0,0,30) - anglestoright(self.angles) * 70;
	cornerdeathreleasegrenade(var_05,randomfloatrange(2,3));
	wait 0.05;
	self detach(var_00,"tag_inhand");
	thread killself();
}

//Function Number: 40
cornerdeathreleasegrenade(param_00,param_01)
{
	var_02 = self gettagorigin("tag_inhand");
	var_03 = var_02 + (0,0,20);
	var_04 = var_02 - (0,0,20);
	var_05 = bullettrace(var_03,var_04,0,undefined);
	if(var_05["fraction"] < 0.5)
	{
		var_02 = var_05["position"];
	}

	var_06 = "default";
	if(var_05["surfacetype"] != "none")
	{
		var_06 = var_05["surfacetype"];
	}

	thread playsoundatpoint("grenade_bounce_" + var_06,var_02);
	self.grenadeweapon = "fraggrenade";
	self magicgrenademanual(var_02,param_00,param_01);
}

//Function Number: 41
playsoundatpoint(param_00,param_01)
{
	var_02 = spawn("script_origin",param_01);
	var_02 playsound(param_00,"sounddone");
	var_02 waittill("sounddone");
	var_02 delete();
}

//Function Number: 42
killself()
{
	self.a.nodeath = 1;
	killwrapper();
	self startragdoll();
	wait 0.1;
	self notify("grenade_drop_done");
}

//Function Number: 43
killwrapper()
{
	if(isdefined(self.last_dmg_player))
	{
		self kill(self.origin,self.last_dmg_player);
		return;
	}

	self kill();
}

//Function Number: 44
enemyisapproaching()
{
	if(!isdefined(self.enemy))
	{
		return 0;
	}

	if(distancesquared(self.origin,self.enemy.origin) > 147456)
	{
		return 0;
	}

	if(distancesquared(self.origin,self.enemy.origin) < 16384)
	{
		return 1;
	}

	var_00 = self.enemy.origin + self.enemyvelocity * 3;
	var_01 = self.enemy.origin;
	if(self.enemy.origin != var_00)
	{
		var_01 = pointonsegmentnearesttopoint(self.enemy.origin,var_00,self.origin);
	}

	if(distancesquared(self.origin,var_01) < 16384)
	{
		return 1;
	}

	return 0;
}

//Function Number: 45
prematurecornergrenadedeath()
{
	var_00 = animscripts/utility::array(%dying_back_death_v1,%dying_back_death_v2,%dying_back_death_v3,%dying_back_death_v4);
	var_01 = var_00[randomint(var_00.size)];
	animscripts/death::playdeathsound();
	self setflaggedanimknoballrestart("corner_grenade_die",var_01,%body,1,0.2);
	var_02 = animscripts/combat_utility::getgrenadedropvelocity();
	cornerdeathreleasegrenade(var_02,3);
	var_03 = getweaponmodel("fraggrenade");
	self detach(var_03,"tag_inhand");
	wait 0.05;
	self startragdoll();
	self waittillmatch("end","corner_grenade_die");
}

//Function Number: 46
waittillgrenadedrops()
{
	self waittill("grenade_drop_done");
}

//Function Number: 47
watchenemyvelocity()
{
	self endon("kill_long_death");
	self endon("death");
	self.enemyvelocity = (0,0,0);
	var_00 = undefined;
	var_01 = self.origin;
	var_02 = 0.15;
	for(;;)
	{
		if(isdefined(self.enemy) && isdefined(var_00) && self.enemy == var_00)
		{
			var_03 = self.enemy.origin;
			self.enemyvelocity = var_03 - var_01 * 1 / var_02;
			var_01 = var_03;
		}
		else
		{
			if(isdefined(self.enemy))
			{
				var_01 = self.enemy.origin;
			}
			else
			{
				var_01 = self.origin;
			}

			var_00 = self.enemy;
			self.var_96C = (0,0,0);
		}

		wait var_02;
	}
}

//Function Number: 48
additive_pain(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	self endon("death");
	if(!isdefined(self))
	{
		return;
	}

	if(isdefined(self.doingadditivepain))
	{
		return;
	}

	if(param_00 < self.minpaindamage)
	{
		return;
	}

	self.doingadditivepain = 1;
	var_07 = animscripts/utility::array(%pain_add_standing_belly,%pain_add_standing_left_arm,%pain_add_standing_right_arm);
	var_08 = %pain_add_standing_belly;
	if(animscripts/utility::damagelocationisany("left_arm_lower","left_arm_upper","left_hand"))
	{
		var_08 = %pain_add_standing_left_arm;
	}

	if(animscripts/utility::damagelocationisany("right_arm_lower","right_arm_upper","right_hand"))
	{
		var_08 = %pain_add_standing_right_arm;
	}
	else if(animscripts/utility::damagelocationisany("left_leg_upper","left_leg_lower","left_foot"))
	{
		var_08 = %pain_add_standing_left_leg;
	}
	else if(animscripts/utility::damagelocationisany("right_leg_upper","right_leg_lower","right_foot"))
	{
		var_08 = %pain_add_standing_right_leg;
	}
	else
	{
		var_08 = var_07[randomint(var_07.size)];
	}

	self setanimlimited(%add_pain,1,0.1,1);
	self setanimlimited(var_08,1,0,1);
	wait 0.4;
	self clearanim(var_08,0.2);
	self clearanim(%add_pain,0.2);
	self.doingadditivepain = undefined;
}