/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\pain.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 53
 * Decompile Time: 883 ms
 * Timestamp: 10/27/2023 1:55:20 AM
*******************************************************************/

//Function Number: 1
init_animset_pain()
{
	var_00 = [];
	var_00["damage_shield_crouch"] = %exposed_crouch_extendedpaina;
	var_00["damage_shield_pain_array"] = [%stand_exposed_extendedpain_chest,%stand_exposed_extendedpain_head_2_crouch,%stand_exposed_extendedpain_hip_2_crouch];
	var_00["back"] = %back_pain;
	var_00["run_long"] = [%run_pain_leg,%run_pain_shoulder,%run_pain_stomach_stumble,%run_pain_head,%run_pain_fallonknee_02,%run_pain_stomach,%run_pain_stumble,%run_pain_stomach_fast,%run_pain_leg_fast,%run_pain_fall];
	var_00["run_medium"] = [%run_pain_fallonknee_02,%run_pain_stomach,%run_pain_stumble,%run_pain_stomach_fast,%run_pain_leg_fast,%run_pain_fall];
	var_00["run_short"] = [%run_pain_fallonknee,%run_pain_fallonknee_03];
	var_00["pistol_torso_upper"] = [%pistol_stand_pain_chest,%pistol_stand_pain_rightshoulder,%pistol_stand_pain_leftshoulder];
	var_00["pistol_torso_lower"] = [%pistol_stand_pain_chest,%pistol_stand_pain_groin];
	var_00["pistol_neck"] = [%pistol_stand_pain_chest,%pistol_stand_pain_head];
	var_00["pistol_head"] = [%pistol_stand_pain_head];
	var_00["pistol_leg"] = [%pistol_stand_pain_groin];
	var_00["pistol_left_arm_upper"] = [%pistol_stand_pain_chest,%pistol_stand_pain_leftshoulder];
	var_00["pistol_right_arm_upper"] = [%pistol_stand_pain_chest,%pistol_stand_pain_rightshoulder];
	var_00["pistol_left_arm_lower"] = [%pistol_stand_pain_leftshoulder];
	var_00["pistol_right_arm_lower"] = [%pistol_stand_pain_rightshoulder];
	var_00["pistol_default1"] = [%pistol_stand_pain_chest];
	var_00["pistol_default2"] = [%pistol_stand_pain_groin];
	var_00["torso_pistol"] = %pistol_stand_pain_chest;
	var_00["torso_upper"] = [%exposed_pain_face,%stand_exposed_extendedpain_neck];
	var_00["torso_upper_extended"] = [%stand_exposed_extendedpain_gut,%stand_exposed_extendedpain_stomach,%stand_exposed_extendedpain_head_2_crouch];
	var_00["torso_lower"] = [%exposed_pain_groin,%stand_exposed_extendedpain_hip];
	var_00["torso_lower_extended"] = [%stand_exposed_extendedpain_gut,%stand_exposed_extendedpain_stomach,%stand_exposed_extendedpain_hip_2_crouch,%stand_exposed_extendedpain_feet_2_crouch,%stand_exposed_extendedpain_stomach];
	var_00["head"] = [%exposed_pain_face,%stand_exposed_extendedpain_neck];
	var_00["head_extended"] = [%stand_exposed_extendedpain_head_2_crouch];
	var_00["right_arm"] = [%exposed_pain_right_arm];
	var_00["right_arm_extended"] = [];
	var_00["left_arm"] = [%stand_exposed_extendedpain_shoulderswing];
	var_00["left_arm_extended"] = [%stand_exposed_extendedpain_shoulder_2_crouch];
	var_00["leg"] = [%exposed_pain_groin,%stand_exposed_extendedpain_hip];
	var_00["leg_extended"] = [%stand_exposed_extendedpain_hip_2_crouch,%stand_exposed_extendedpain_feet_2_crouch,%stand_exposed_extendedpain_stomach];
	var_00["foot"] = [%stand_exposed_extendedpain_thigh];
	var_00["foot_extended"] = [%stand_exposed_extendedpain_feet_2_crouch];
	var_00["default_long"] = [%exposed_pain_2_crouch,%stand_extendedpainb];
	var_00["default_short"] = [%exposed_pain_right_arm,%exposed_pain_face,%exposed_pain_groin];
	var_00["default_extended"] = [%stand_extendedpainc,%stand_exposed_extendedpain_chest];
	var_00["crouch_longdeath"] = [%exposed_crouch_extendedpaina];
	var_00["crouch_default"] = [%exposed_crouch_pain_chest,%exposed_crouch_pain_headsnap,%exposed_crouch_pain_flinch];
	var_00["crouch_left_arm"] = [%exposed_crouch_pain_left_arm];
	var_00["crouch_right_arm"] = [%exposed_crouch_pain_right_arm];
	var_00["prone"] = [%prone_reaction_a,%prone_reaction_b];
	var_00["cover_left_stand"] = [%corner_standl_painb,%corner_standl_painc,%corner_standl_paind,%corner_standl_paine];
	var_00["cover_left_crouch"] = [%cornercrl_painb];
	var_00["cover_right_stand"] = [%corner_standr_pain,%corner_standr_painb,%corner_standr_painc];
	var_00["cover_right_crouch"] = [%cornercrr_alert_paina,%cornercrr_alert_painc];
	var_00["cover_right_stand_B"] = %corner_standr_pain_b_2_alert;
	var_00["cover_left_stand_A"] = %corner_standl_pain_a_2_alert;
	var_00["cover_left_stand_B"] = %corner_standl_pain_b_2_alert;
	var_00["cover_crouch"] = [%covercrouch_pain_right,%covercrouch_pain_front,%covercrouch_pain_left_3];
	var_00["cover_stand"] = [%coverstand_pain_groin,%coverstand_pain_leg];
	var_00["cover_stand_aim"] = [%coverstand_pain_aim_2_hide_01,%coverstand_pain_aim_2_hide_02];
	var_00["smg_cover_stand_aim"] = [%smg_coverstand_pain_aim_2_hide_01,%smg_coverstand_pain_aim_2_hide_02];
	var_00["cover_crouch_aim"] = [%covercrouch_pain_aim_2_hide_01];
	var_00["saw_stand"] = %saw_gunner_pain;
	var_00["saw_crouch"] = %saw_gunner_lowwall_pain_02;
	var_00["saw_prone"] = %saw_gunner_prone_pain;
	level.archetypes["soldier"]["pain"] = var_00;
	var_00 = [];
	var_00["prone_transition"] = [%dying_crawl_2_back];
	var_00["stand_transition"] = [%dying_stand_2_back_v1,%dying_stand_2_back_v2];
	var_00["crouch_transition"] = [%dying_crouch_2_back];
	var_00["default_transition"] = %dying_crawl_2_back;
	var_00["stand_2_crawl"] = [%dying_stand_2_crawl_v1,%dying_stand_2_crawl_v2,%dying_stand_2_crawl_v3];
	var_00["crouch_2_crawl"] = [%dying_crouch_2_crawl];
	var_00["crawl"] = %dying_crawl;
	var_00["death"] = [%dying_crawl_death_v1,%dying_crawl_death_v2];
	var_00["back_idle"] = %dying_back_idle;
	var_00["back_idle_twitch"] = [%dying_back_twitch_a,%dying_back_twitch_b];
	var_00["back_crawl"] = %dying_crawl_back;
	var_00["back_fire"] = %dying_back_fire;
	var_00["back_death"] = [%dying_back_death_v1,%dying_back_death_v2,%dying_back_death_v3];
	var_00["aim_4"] = %dying_back_aim_4;
	var_00["aim_6"] = %dying_back_aim_6;
	var_00["longdeath"] = [];
	var_00["longdeath"]["gut_b"] = [[%stand_2_longdeath_wander_gut,%longdeath_wander_gut,%longdeath_wander_gut_collapse,%longdeath_wander_gut_death],[%stand_2_longdeath_gut_wounded_b,%longdeath_gut_wounded_b_walk,%longdeath_gut_wounded_b_collapse],[%stand_2_longdeath_gut_b,%longdeath_gut_b_walk,%longdeath_gut_b_impact]];
	var_00["longdeath"]["gut_l"] = [[%stand_2_longdeath_gut_l,%longdeath_gut_l_walk,%longdeath_gut_l_impact]];
	var_00["longdeath"]["gut_r"] = [[%stand_2_longdeath_gut_r,%longdeath_gut_r_walk,%longdeath_gut_r_impact]];
	var_00["longdeath"]["leg_b"] = [[%stand_2_longdeath_wander_leg_1,%longdeath_wander_leg_1,%longdeath_wander_leg_collapse_1,%longdeath_wander_leg_death],[%stand_2_longdeath_wander_leg_2,%longdeath_wander_leg_2,%longdeath_wander_leg_collapse_2,%longdeath_wander_leg_death],[%stand_2_longdeath_leg_wounded_b_1,%longdeath_leg_wounded_b_walk_1,%longdeath_leg_wounded_b_collapse_1],[%stand_2_longdeath_leg_wounded_b_2,%longdeath_leg_wounded_b_walk_2,%longdeath_leg_wounded_b_collapse_2]];
	level.archetypes["soldier"]["crawl_death"] = var_00;
	var_00 = [];
	var_00["pain"] = %corner_standr_death_grenade_hit;
	var_00["idle"] = %corner_standr_death_grenade_idle;
	var_00["release"] = %corner_standr_death_grenade_slump;
	var_00["premature_death"] = [%dying_back_death_v1,%dying_back_death_v2,%dying_back_death_v3,%dying_back_death_v4];
	level.archetypes["soldier"]["corner_grenade_death"] = var_00;
	var_00 = [];
	var_00["default"] = [%pain_add_standing_belly,%pain_add_standing_left_arm,%pain_add_standing_right_arm];
	var_00["left_arm"] = %pain_add_standing_left_arm;
	var_00["right_arm"] = %pain_add_standing_right_arm;
	var_00["left_leg"] = %pain_add_standing_left_leg;
	var_00["right_leg"] = %pain_add_standing_right_leg;
	level.archetypes["soldier"]["additive_pain"] = var_00;
}

//Function Number: 2
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
	self.facialanimidx = undefined;
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

	self notify("anim entered pain");
	self endon("killanimscript");
	animscripts\utility::initialize("pain");
	self animmode("gravity");
	if(!isdefined(self.no_pain_sound))
	{
		animscripts\face::saygenericdialogue("pain");
	}

	if(self.damagelocation == "helmet")
	{
		animscripts\death::helmetpop();
	}
	else if(wasdamagedbyexplosive() && randomint(2) == 0)
	{
		animscripts\death::helmetpop();
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

	var_00 = getpainanim();
	if(isdefined(var_00))
	{
		self.a.painanimlength = getanimlength(var_00);
	}

	playpainanim(var_00);
}

//Function Number: 3
initpainfx()
{
	level._effect["crawling_death_blood_smear"] = loadfx("vfx/blood/blood_smear_decal");
}

//Function Number: 4
end_script()
{
	if(isdefined(self.damageshieldpain))
	{
		self.damageshieldcounter = undefined;
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

	self clearanim(%head,0.2);
	self.facialanimidx = undefined;
}

//Function Number: 5
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

//Function Number: 6
getdamageshieldpainanim()
{
	if(self.a.pose == "prone")
	{
		return;
	}

	if(isdefined(self.lastattacker) && isdefined(self.lastattacker.team) && self.lastattacker.team == self.team)
	{
		return;
	}

	if(!isdefined(self.damageshieldcounter) || gettime() - self.a.lastpaintime > 1500)
	{
		self.damageshieldcounter = randomintrange(2,3);
	}

	if(isdefined(self.lastattacker) && distancesquared(self.origin,self.lastattacker.origin) < squared(512))
	{
		self.damageshieldcounter = 0;
	}

	if(self.damageshieldcounter > 0)
	{
		self.damageshieldcounter--;
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

	if(animscripts\utility::usingsidearm())
	{
		animscripts\shared::placeweaponon(self.primaryweapon,"right");
	}

	if(self.a.pose == "crouch")
	{
		return animscripts\utility::lookupanim("pain","damage_shield_crouch");
	}

	var_00 = animscripts\utility::lookupanim("pain","damage_shield_pain_array");
	return var_00[randomint(var_00.size)];
}

//Function Number: 7
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
		if(self.a.pose == "crouch")
		{
			return animscripts\utility::lookupanim("pain","back");
		}
		else
		{
			animscripts\notetracks::stoponback();
		}
	}

	if(self.a.pose == "stand")
	{
		var_01 = isdefined(self.node) && distancesquared(self.origin,self.node.origin) < 4096;
		if(!var_01 && self.a.movement == "run" && abs(self getmotionangle()) < 60)
		{
			return getrunningforwardpainanim();
		}

		self.a.movement = "stop";
		return getstandpainanim();
	}

	if(self.a.pose == "crouch")
	{
		self.a.movement = "stop";
		return getcrouchpainanim();
	}

	if(self.a.pose == "prone")
	{
		self.a.movement = "stop";
		return getpronepainanim();
	}
}

//Function Number: 8
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
		var_00 = animscripts\utility::lookupanim("pain","run_long");
	}
	else if(var_01)
	{
		var_00 = animscripts\utility::lookupanim("pain","run_medium");
	}
	else if(self maymovetopoint(self localtoworldcoords((120,0,0))))
	{
		var_00 = animscripts\utility::lookupanim("pain","run_short");
	}

	if(!var_00.size)
	{
		self.a.movement = "stop";
		return getstandpainanim();
	}

	return var_00[randomint(var_00.size)];
}

//Function Number: 9
getstandpistolpainanim()
{
	var_00 = [];
	if(animscripts\utility::damagelocationisany("torso_upper"))
	{
		var_00 = animscripts\utility::lookupanim("pain","pistol_torso_upper");
	}
	else if(animscripts\utility::damagelocationisany("torso_lower"))
	{
		var_00 = animscripts\utility::lookupanim("pain","pistol_torso_lower");
	}
	else if(animscripts\utility::damagelocationisany("neck"))
	{
		var_00 = animscripts\utility::lookupanim("pain","pistol_neck");
	}
	else if(animscripts\utility::damagelocationisany("head"))
	{
		var_00 = animscripts\utility::lookupanim("pain","pistol_head");
	}
	else if(animscripts\utility::damagelocationisany("left_leg_upper","right_leg_upper"))
	{
		var_00 = animscripts\utility::lookupanim("pain","pistol_leg");
	}
	else if(animscripts\utility::damagelocationisany("left_arm_upper"))
	{
		var_00 = animscripts\utility::lookupanim("pain","pistol_left_arm_upper");
	}
	else if(animscripts\utility::damagelocationisany("left_arm_lower"))
	{
		var_00 = animscripts\utility::lookupanim("pain","pistol_left_arm_lower");
	}
	else if(animscripts\utility::damagelocationisany("right_arm_upper"))
	{
		var_00 = animscripts\utility::lookupanim("pain","pistol_right_arm_upper");
	}
	else if(animscripts\utility::damagelocationisany("right_arm_lower"))
	{
		var_00 = animscripts\utility::lookupanim("pain","pistol_right_arm_lower");
	}

	if(var_00.size < 2)
	{
		var_00 = common_scripts\utility::array_combine(var_00,animscripts\utility::lookupanim("pain","pistol_default1"));
	}

	if(var_00.size < 2)
	{
		var_00 = common_scripts\utility::array_combine(var_00,animscripts\utility::lookupanim("pain","pistol_default2"));
	}

	return var_00[randomint(var_00.size)];
}

//Function Number: 10
getstandpainanim()
{
	if(animscripts\utility::usingsidearm())
	{
		return getstandpistolpainanim();
	}

	var_00 = [];
	var_01 = [];
	if(animscripts\utility::damagelocationisany("torso_upper"))
	{
		var_00 = animscripts\utility::lookupanim("pain","torso_upper");
		var_01 = animscripts\utility::lookupanim("pain","torso_upper_extended");
	}
	else if(animscripts\utility::damagelocationisany("torso_lower"))
	{
		var_00 = animscripts\utility::lookupanim("pain","torso_lower");
		var_01 = animscripts\utility::lookupanim("pain","torso_lower_extended");
	}
	else if(animscripts\utility::damagelocationisany("head","helmet","neck"))
	{
		var_00 = animscripts\utility::lookupanim("pain","head");
		var_01 = animscripts\utility::lookupanim("pain","head_extended");
	}
	else if(animscripts\utility::damagelocationisany("right_arm_upper","right_arm_lower"))
	{
		var_00 = animscripts\utility::lookupanim("pain","right_arm");
		var_01 = animscripts\utility::lookupanim("pain","right_arm_extended");
	}
	else if(animscripts\utility::damagelocationisany("left_arm_upper","left_arm_lower"))
	{
		var_00 = animscripts\utility::lookupanim("pain","left_arm");
		var_01 = animscripts\utility::lookupanim("pain","left_arm_extended");
	}
	else if(animscripts\utility::damagelocationisany("left_leg_upper","right_leg_upper"))
	{
		var_00 = animscripts\utility::lookupanim("pain","leg");
		var_01 = animscripts\utility::lookupanim("pain","leg_extended");
	}
	else if(animscripts\utility::damagelocationisany("left_foot","right_foot","left_leg_lower","right_leg_lower"))
	{
		var_00 = animscripts\utility::lookupanim("pain","foot");
		var_01 = animscripts\utility::lookupanim("pain","foot_extended");
	}

	if(var_00.size < 2)
	{
		if(!self.a.disablelongdeath)
		{
			var_00 = common_scripts\utility::array_combine(var_00,animscripts\utility::lookupanim("pain","default_long"));
		}
		else
		{
			var_00 = common_scripts\utility::array_combine(var_00,animscripts\utility::lookupanim("pain","default_short"));
		}
	}

	if(var_01.size < 2)
	{
		var_01 = common_scripts\utility::array_combine(var_01,animscripts\utility::lookupanim("pain","default_extended"));
	}

	if(!self.damageshield && !self.a.disablelongdeath)
	{
		var_02 = randomint(var_00.size + var_01.size);
		if(var_02 < var_00.size)
		{
			return var_00[var_02];
		}
		else
		{
			return var_01[var_02 - var_00.size];
		}
	}

	return var_00[randomint(var_00.size)];
}

//Function Number: 11
getcrouchpainanim()
{
	var_00 = [];
	if(!self.damageshield && !self.a.disablelongdeath)
	{
		var_00 = animscripts\utility::lookupanim("pain","crouch_longdeath");
	}

	var_00 = common_scripts\utility::array_combine(var_00,animscripts\utility::lookupanim("pain","crouch_default"));
	if(animscripts\utility::damagelocationisany("left_hand","left_arm_lower","left_arm_upper"))
	{
		var_00 = common_scripts\utility::array_combine(var_00,animscripts\utility::lookupanim("pain","crouch_left_arm"));
	}

	if(animscripts\utility::damagelocationisany("right_hand","right_arm_lower","right_arm_upper"))
	{
		var_00 = common_scripts\utility::array_combine(var_00,animscripts\utility::lookupanim("pain","crouch_right_arm"));
	}

	return var_00[randomint(var_00.size)];
}

//Function Number: 12
getpronepainanim()
{
	var_00 = animscripts\utility::lookupanim("pain","prone");
	return var_00[randomint(var_00.size)];
}

//Function Number: 13
playpainanim(param_00)
{
	var_01 = 1;
	pain_setflaggedanimknoballrestart("painanim",param_00,%body,1,0.1,var_01);
	if(self.a.pose == "prone")
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
		animscripts\shared::donotetracks("painanim");
	}

	animscripts\shared::donotetracks("painanim");
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
	wait(0.5);
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
			break;

		case "cover_right":
			break;

		case "cover_right_stand_A":
			break;

		case "cover_right_stand_B":
			break;

		case "cover_left_stand_A":
			break;

		case "cover_left_stand_B":
			break;

		case "cover_crouch":
			break;

		case "cover_stand":
			break;

		case "cover_stand_aim":
			break;

		case "smg_cover_stand_aim":
			break;

		case "cover_crouch_aim":
			break;

		case "saw":
			break;

		case "mg42":
			break;

		case "minigun":
			break;

		case "corner_right_martyrdom":
			break;

		case "rambo_right":
		case "rambo_left":
		case "dying_crawl":
		case "rambo":
			break;

		default:
			break;
	}
}

//Function Number: 17
paindeathnotify()
{
	self endon("death");
	wait(0.05);
	self notify("pain_death");
}

//Function Number: 18
dopainfromarray(param_00)
{
	var_01 = param_00[randomint(param_00.size)];
	pain_setflaggedanimknob("painanim",var_01,1,0.3,1);
	animscripts\shared::donotetracks("painanim");
}

//Function Number: 19
dopain(param_00)
{
	pain_setflaggedanimknob("painanim",param_00,1,0.3,1);
	animscripts\shared::donotetracks("painanim");
}

//Function Number: 20
mg42pain(param_00)
{
	pain_setflaggedanimknob("painanim",level.mg_animmg["pain_" + param_00],1,0.1,1);
	animscripts\shared::donotetracks("painanim");
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

	wait(param_00);
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

	if(isdefined(self.mech) && self.mech)
	{
		return 0;
	}

	var_00 = animscripts\utility::damagelocationisany("left_leg_upper","left_leg_lower","right_leg_upper","right_leg_lower","left_foot","right_foot");
	if(isdefined(self.forcelongdeath))
	{
		setcrawlingpaintransanim(var_00);
		self.health = 10;
		thread crawlingpistol();
		self waittill("killanimscript");
		return 1;
	}

	if(self.health > 100)
	{
		return 0;
	}

	if(var_00 && self.health < self.maxhealth * 0.4)
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

	foreach(var_02 in level.players)
	{
		if(distancesquared(self.origin,var_02.origin) < 30625)
		{
			return 0;
		}
	}

	if(animscripts\utility::damagelocationisany("head","helmet","gun","right_hand","left_hand"))
	{
		return 0;
	}

	if(animscripts\utility::usingsidearm())
	{
		return 0;
	}

	setcrawlingpaintransanim(var_00);
	if(!isdefined(self.a.stumblingpainanimseq) && !iscrawldeltaallowed(self.a.crawlingpaintransanim))
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
setcrawlingpaintransanim(param_00)
{
	var_01 = [];
	var_02 = undefined;
	if(self.a.pose == "stand")
	{
		var_02 = shouldattemptstumblingpain(param_00);
		if(isdefined(var_02))
		{
			var_01 = [var_02[0]];
		}
		else
		{
			var_01 = animscripts\utility::lookupanim("crawl_death","stand_transition");
		}
	}
	else if(self.a.pose == "crouch")
	{
		var_01 = animscripts\utility::lookupanim("crawl_death","crouch_transition");
	}
	else
	{
		var_01 = animscripts\utility::lookupanim("crawl_death","prone_transition");
	}

	self.a.crawlingpaintransanim = var_01[randomint(var_01.size)];
	self.a.stumblingpainanimseq = var_02;
}

//Function Number: 24
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

//Function Number: 25
crawlingpistol()
{
	self endon("kill_long_death");
	self endon("death");
	thread preventpainforashorttime("crawling");
	self.a.special = "none";
	self.specialdeathfunc = undefined;
	self setlookatentity();
	thread paindeathnotify();
	level notify("ai_crawling",self);
	self setanimknoball(%dying,%body,1,0.1,1);
	if(isdefined(self.a.stumblingpainanimseq))
	{
		stumblingpain();
		self.a.stumblingpainanimseq = undefined;
		return;
	}

	if(!dyingcrawl())
	{
		return;
	}

	pain_setflaggedanimknob("transition",self.a.crawlingpaintransanim,1,0.5,1);
	animscripts\notetracks::donotetracksintercept("transition",::handlebackcrawlnotetracks);
	self.a.special = "dying_crawl";
	thread dyingcrawlbackaim();
	if(isdefined(self.enemy))
	{
		self setlookatentity(self.enemy);
	}

	decidenumcrawls();
	while(shouldkeepcrawling())
	{
		var_00 = animscripts\utility::lookupanim("crawl_death","back_crawl");
		if(!iscrawldeltaallowed(var_00))
		{
			break;
		}

		pain_setflaggedanimknobrestart("back_crawl",var_00,1,0.1,1);
		animscripts\notetracks::donotetracksintercept("back_crawl",::handlebackcrawlnotetracks);
	}

	self.desiredtimeofdeath = gettime() + randomintrange(4000,20000);
	while(shouldstayalive())
	{
		if(animscripts\utility::canseeenemy() && aimedsomewhatatenemy())
		{
			var_01 = animscripts\utility::lookupanim("crawl_death","back_fire");
			pain_setflaggedanimknobrestart("back_idle_or_fire",var_01,1,0.2,1);
			animscripts\shared::donotetracks("back_idle_or_fire");
			continue;
		}

		var_01 = animscripts\utility::lookupanim("crawl_death","back_idle");
		if(randomfloat(1) < 0.4)
		{
			var_02 = animscripts\utility::lookupanim("crawl_death","back_idle_twitch");
			var_01 = var_02[randomint(var_02.size)];
		}

		pain_setflaggedanimknobrestart("back_idle_or_fire",var_01,1,0.1,1);
		var_03 = getanimlength(var_01);
		while(var_03 > 0)
		{
			if(animscripts\utility::canseeenemy() && aimedsomewhatatenemy())
			{
				break;
			}

			var_04 = 0.5;
			if(var_04 > var_03)
			{
				var_04 = var_03;
				var_03 = 0;
				continue;
			}

			var_03 = var_03 - var_04;
			animscripts\notetracks::donotetracksfortime(var_04,"back_idle_or_fire");
		}
	}

	self notify("end_dying_crawl_back_aim");
	self clearanim(%dying_back_aim_4_wrapper,0.3);
	self clearanim(%dying_back_aim_6_wrapper,0.3);
	var_05 = animscripts\utility::lookupanim("crawl_death","back_death");
	self.deathanim = var_05[randomint(var_05.size)];
	killwrapper();
	self.a.special = "none";
	self.specialdeathfunc = undefined;
}

//Function Number: 26
shouldattemptstumblingpain(param_00)
{
	if(self.a.pose != "stand")
	{
		return;
	}

	var_01 = 2;
	if(randomint(10) > var_01)
	{
		return;
	}

	var_02 = 0;
	if(!param_00)
	{
		var_02 = animscripts\utility::damagelocationisany("torso_upper","torso_lower");
		if(!var_02)
		{
			return;
		}
	}

	var_03 = 0;
	var_04 = "leg";
	var_05 = "b";
	if(param_00)
	{
		var_03 = 200;
	}
	else
	{
		var_04 = "gut";
		var_03 = 128;
		if(45 < self.damageyaw && self.damageyaw < 135)
		{
			var_05 = "l";
		}
		else if(-135 < self.damageyaw && self.damageyaw < -45)
		{
			var_05 = "r";
		}
		else if(-45 < self.damageyaw && self.damageyaw < 45)
		{
			return;
		}
	}

	switch(var_05)
	{
		case "b":
			break;

		case "l":
			break;

		case "r":
			break;

		default:
			break;
	}
}

//Function Number: 27
stumblingpain()
{
	pain_setflaggedanimknobrestart("stumblingPainInto",self.a.stumblingpainanimseq[0]);
	animscripts\shared::donotetracks("stumblingPainInto");
	self.a.special = "stumbling_pain";
	var_00 = getmovedelta(self.a.stumblingpainanimseq[2]);
	var_01 = getanimlength(self.a.stumblingpainanimseq[2]) * 1000;
	for(var_02 = randomint(2) + 1;var_02 > 0;var_02--)
	{
		var_03 = anglestoforward(self.angles);
		var_04 = self.origin + var_03 * var_00;
		if(!self maymovetopoint(var_04))
		{
			break;
		}

		pain_setflaggedanimknobrestart("stumblingPain",self.a.stumblingpainanimseq[1]);
		animscripts\shared::donotetracks("stumblingPain");
	}

	self.a.nodeath = 1;
	self.a.special = "none";
	pain_setflaggedanimknobrestart("stumblingPainCollapse",self.a.stumblingpainanimseq[2],1,0.75);
	animscripts\notetracks::donotetracksintercept("stumblingPainCollapse",::stumblingpainnotetrackhandler);
	animscripts\shared::donotetracks("stumblingPainCollapse");
	killwrapper();
}

//Function Number: 28
stumblingpainnotetrackhandler(param_00)
{
	if(param_00 == "start_ragdoll")
	{
		animscripts\notetracks::handlenotetrack(param_00,"stumblingPainCollapse");
		return 1;
	}
}

//Function Number: 29
shouldstayalive()
{
	if(!enemyisingeneraldirection(anglestoforward(self.angles)))
	{
		return 0;
	}

	return gettime() < self.desiredtimeofdeath;
}

//Function Number: 30
dyingcrawl()
{
	if(!isdefined(self.forcelongdeath))
	{
		if(self.a.pose == "prone")
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

	if(self.a.pose != "prone")
	{
		var_00 = animscripts\utility::lookupanim("crawl_death",self.a.pose + "_2_crawl");
		var_01 = var_00[randomint(var_00.size)];
		if(!iscrawldeltaallowed(var_01))
		{
			return 1;
		}

		thread dyingcrawlbloodsmear();
		pain_setflaggedanimknob("falling",var_01,1,0.5,1);
		animscripts\shared::donotetracks("falling");
	}
	else
	{
		thread dyingcrawlbloodsmear();
	}

	self.a.crawlingpaintransanim = animscripts\utility::lookupanim("crawl_death","default_transition");
	self.a.special = "dying_crawl";
	decidenumcrawls();
	var_02 = animscripts\utility::lookupanim("crawl_death","crawl");
	while(shouldkeepcrawling())
	{
		if(!iscrawldeltaallowed(var_02))
		{
			return 1;
		}

		if(isdefined(self.custom_crawl_sound))
		{
			self playsound(self.custom_crawl_sound);
		}

		pain_setflaggedanimknobrestart("crawling",var_02,1,0.1,1);
		animscripts\shared::donotetracks("crawling");
	}

	self notify("done_crawling");
	if(!isdefined(self.forcelongdeath) && enemyisingeneraldirection(anglestoforward(self.angles) * -1))
	{
		return 1;
	}

	var_03 = animscripts\utility::lookupanim("crawl_death","death");
	var_04 = var_03[randomint(var_03.size)];
	if(var_04 != %dying_crawl_death_v2)
	{
		self.a.nodeath = 1;
	}

	animscripts\death::playdeathanim(var_04);
	killwrapper();
	self.a.special = "none";
	self.specialdeathfunc = undefined;
	return 0;
}

//Function Number: 31
dyingcrawlbloodsmear()
{
	self endon("death");
	if(self.a.pose != "prone")
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
		wait(var_03);
	}
}

//Function Number: 32
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
	self setanimlimited(animscripts\utility::lookupanim("crawl_death","aim_4"),1,0);
	self setanimlimited(animscripts\utility::lookupanim("crawl_death","aim_6"),1,0);
	var_00 = 0;
	for(;;)
	{
		var_01 = animscripts\utility::getyawtoenemy();
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
		wait(0.05);
	}
}

//Function Number: 33
startdyingcrawlbackaimsoon()
{
	self endon("kill_long_death");
	self endon("death");
	wait(0.5);
	thread dyingcrawlbackaim();
}

//Function Number: 34
handlebackcrawlnotetracks(param_00)
{
	if(param_00 == "fire_spray")
	{
		if(!animscripts\utility::canseeenemy())
		{
			return 1;
		}

		if(!aimedsomewhatatenemy())
		{
			return 1;
		}

		animscripts\utility::shootenemywrapper();
		return 1;
	}
	else if(param_00 == "pistol_pickup")
	{
		thread startdyingcrawlbackaimsoon();
		return 0;
	}

	return 0;
}

//Function Number: 35
aimedsomewhatatenemy()
{
	if(common_scripts\utility::flag("_cloaked_stealth_enabled"))
	{
		var_00 = animscripts\combat_utility::get_last_known_shoot_pos(self.enemy);
	}
	else
	{
		var_00 = self.enemy getshootatpos();
	}

	var_01 = self getmuzzleangle();
	var_02 = vectortoangles(var_00 - self getmuzzlepos());
	var_03 = animscripts\utility::absangleclamp180(var_01[1] - var_02[1]);
	if(var_03 > level.painyawdifffartolerance)
	{
		if(distancesquared(self geteye(),var_00) > level.painyawdiffclosedistsq || var_03 > level.painyawdiffclosetolerance)
		{
			return 0;
		}
	}

	return animscripts\utility::absangleclamp180(var_01[0] - var_02[0]) <= level.painpitchdifftolerance;
}

//Function Number: 36
enemyisingeneraldirection(param_00)
{
	if(!isdefined(self.enemy))
	{
		return 0;
	}

	if(common_scripts\utility::flag("_cloaked_stealth_enabled"))
	{
		var_01 = animscripts\combat_utility::get_last_known_shoot_pos(self.enemy);
	}
	else
	{
		var_01 = self.enemy getshootatpos();
	}

	var_02 = vectornormalize(var_01 - self geteye());
	return vectordot(var_02,param_00) > 0.5;
}

//Function Number: 37
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
	wait(0.75);
	if(self.health > 1)
	{
		self.health = 1;
	}

	wait(0.05);
	self.longdeathstarting = undefined;
	self.a.mayonlydie = 1;
	if(param_00 == "crawling")
	{
		wait(1);
		if(isdefined(level.player) && distancesquared(self.origin,level.player.origin) < 1048576)
		{
			anim.numdeathsuntilcrawlingpain = randomintrange(10,30);
			anim.nextcrawlingpaintime = gettime() + randomintrange(15000,60000);
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
		wait(1);
		if(isdefined(level.player) && distancesquared(self.origin,level.player.origin) < 490000)
		{
			anim.numdeathsuntilcornergrenadedeath = randomintrange(10,30);
			anim.nextcornergrenadedeathtime = gettime() + randomintrange(15000,60000);
			return;
		}

		anim.numdeathsuntilcornergrenadedeath = randomintrange(5,12);
		anim.nextcornergrenadedeathtime = gettime() + randomintrange(5000,25000);
		return;
	}
}

//Function Number: 38
decidenumcrawls()
{
	if(isdefined(self.a.force_num_crawls))
	{
		self.a.numcrawls = self.a.force_num_crawls;
		return;
	}

	self.a.numcrawls = randomintrange(1,5);
}

//Function Number: 39
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

//Function Number: 40
trycornerrightgrenadedeath()
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

//Function Number: 41
cornerrightgrenadedeath()
{
	self endon("kill_long_death");
	self endon("death");
	thread paindeathnotify();
	thread preventpainforashorttime("corner_grenade");
	thread maps\_utility::set_battlechatter(0);
	self.threatbias = -1000;
	pain_setflaggedanimknoballrestart("corner_grenade_pain",animscripts\utility::lookupanim("corner_grenade_death","pain"),%body,1,0.1);
	self waittillmatch("dropgun","corner_grenade_pain");
	animscripts\shared::dropallaiweapons();
	self waittillmatch("anim_pose = \"back\","corner_grenade_pain");
	animscripts\notetracks::notetrackposeback();
	self waittillmatch("grenade_left","corner_grenade_pain");
	var_00 = getweaponmodel("fraggrenade");
	self attach(var_00,"tag_inhand");
	self.deathfunction = ::prematurecornergrenadedeath;
	self waittillmatch("end","corner_grenade_pain");
	var_01 = gettime() + randomintrange(25000,60000);
	pain_setflaggedanimknoballrestart("corner_grenade_idle",animscripts\utility::lookupanim("corner_grenade_death","pain"),%body,1,0.2);
	thread watchenemyvelocity();
	while(!enemyisapproaching())
	{
		if(gettime() >= var_01)
		{
			break;
		}

		animscripts\notetracks::donotetracksfortime(0.1,"corner_grenade_idle");
	}

	var_02 = animscripts\utility::lookupanim("corner_grenade_death","release");
	pain_setflaggedanimknoballrestart("corner_grenade_release",var_02,%body,1,0.2);
	var_03 = getnotetracktimes(var_02,"grenade_drop");
	var_04 = var_03[0] * getanimlength(var_02);
	wait(var_04 - 1);
	animscripts\death::playdeathsound();
	wait(0.7);
	self.deathfunction = ::waittillgrenadedrops;
	var_05 = (0,0,30) - anglestoright(self.angles) * 70;
	cornerdeathreleasegrenade(var_05,randomfloatrange(2,3));
	wait(0.05);
	self detach(var_00,"tag_inhand");
	thread killself();
}

//Function Number: 42
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

//Function Number: 43
playsoundatpoint(param_00,param_01)
{
	var_02 = spawn("script_origin",param_01);
	var_02 playsound(param_00,"sounddone");
	var_02 waittill("sounddone");
	var_02 delete();
}

//Function Number: 44
killself()
{
	self.a.nodeath = 1;
	killwrapper();
	self startragdoll();
	wait(0.1);
	self notify("grenade_drop_done");
}

//Function Number: 45
killwrapper()
{
	if(isdefined(self.last_dmg_player))
	{
		self kill(self.origin,self.last_dmg_player);
		return;
	}

	self kill();
}

//Function Number: 46
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

//Function Number: 47
prematurecornergrenadedeath()
{
	var_00 = animscripts\utility::lookupanim("corner_grenade_death","premature_death");
	var_01 = var_00[randomint(var_00.size)];
	animscripts\death::playdeathsound();
	pain_setflaggedanimknoballrestart("corner_grenade_die",var_01,%body,1,0.2);
	var_02 = animscripts\combat_utility::getgrenadedropvelocity();
	cornerdeathreleasegrenade(var_02,3);
	var_03 = getweaponmodel("fraggrenade");
	self detach(var_03,"tag_inhand");
	wait(0.05);
	self startragdoll();
	self waittillmatch("end","corner_grenade_die");
}

//Function Number: 48
waittillgrenadedrops()
{
	self waittill("grenade_drop_done");
}

//Function Number: 49
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
			self.shootentvelocity = (0,0,0);
		}

		wait(var_02);
	}
}

//Function Number: 50
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

	if(!isdefined(self.mech) || isdefined(self.mech) && !self.mech)
	{
		if(param_00 < self.minpaindamage)
		{
			return;
		}
	}
	else if(param_00 < self.minpaindamage / 3)
	{
		return;
	}

	self.doingadditivepain = 1;
	var_07 = undefined;
	if(animscripts\utility::damagelocationisany("left_arm_lower","left_arm_upper","left_hand"))
	{
		var_07 = animscripts\utility::lookupanim("additive_pain","left_arm");
	}

	if(animscripts\utility::damagelocationisany("right_arm_lower","right_arm_upper","right_hand"))
	{
		var_07 = animscripts\utility::lookupanim("additive_pain","right_arm");
	}
	else if(animscripts\utility::damagelocationisany("left_leg_upper","left_leg_lower","left_foot"))
	{
		var_07 = animscripts\utility::lookupanim("additive_pain","left_leg");
	}
	else if(animscripts\utility::damagelocationisany("right_leg_upper","right_leg_lower","right_foot"))
	{
		var_07 = animscripts\utility::lookupanim("additive_pain","right_leg");
	}
	else
	{
		var_08 = animscripts\utility::lookupanim("additive_pain","default");
		var_07 = var_08[randomint(var_08.size)];
	}

	self setanimlimited(%add_pain,1,0.1,1);
	self setanimlimited(var_07,1,0,1);
	wait(0.4);
	self clearanim(var_07,0.2);
	self clearanim(%add_pain,0.2);
	self.doingadditivepain = undefined;
}

//Function Number: 51
pain_setflaggedanimknob(param_00,param_01,param_02,param_03,param_04)
{
	if(!isdefined(param_02))
	{
		param_02 = 1;
	}

	if(!isdefined(param_03))
	{
		param_03 = 0.2;
	}

	if(!isdefined(param_04))
	{
		param_04 = 1;
	}

	self setflaggedanimknob(param_00,param_01,param_02,param_03,param_04);
	self.facialanimidx = animscripts\face::playfacialanim(param_01,"pain",self.facialanimidx);
}

//Function Number: 52
pain_setflaggedanimknobrestart(param_00,param_01,param_02,param_03,param_04)
{
	if(!isdefined(param_02))
	{
		param_02 = 1;
	}

	if(!isdefined(param_03))
	{
		param_03 = 0.2;
	}

	if(!isdefined(param_04))
	{
		param_04 = 1;
	}

	self setflaggedanimknobrestart(param_00,param_01,param_02,param_03,param_04);
	self.facialanimidx = animscripts\face::playfacialanim(param_01,"pain",self.facialanimidx);
}

//Function Number: 53
pain_setflaggedanimknoballrestart(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(!isdefined(param_03))
	{
		param_03 = 1;
	}

	if(!isdefined(param_04))
	{
		param_04 = 0.2;
	}

	if(!isdefined(param_05))
	{
		param_05 = 1;
	}

	self setflaggedanimknoballrestart(param_00,param_01,param_02,param_03,param_04,param_05);
	self.facialanimidx = animscripts\face::playfacialanim(param_01,"pain",self.facialanimidx);
}