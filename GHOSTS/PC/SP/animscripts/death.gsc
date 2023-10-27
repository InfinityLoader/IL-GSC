/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\death.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 39
 * Decompile Time: 686 ms
 * Timestamp: 10/27/2023 1:23:56 AM
*******************************************************************/

//Function Number: 1
init_animset_death()
{
	var_00 = [];
	var_00["strong_legs"] = [%death_shotgun_legs,%death_stand_sniper_leg];
	var_00["strong_torso_lower"] = [%death_shotgun_legs,%death_stand_sniper_leg,%death_shotgun_back_v1,%exposed_death_blowback,%death_stand_sniper_chest1,%death_stand_sniper_chest2,%death_stand_sniper_spin1];
	var_00["strong_default"] = [%death_shotgun_legs,%death_stand_sniper_leg,%death_shotgun_back_v1,%exposed_death_blowback,%death_stand_sniper_chest1,%death_stand_sniper_chest2,%death_stand_sniper_spin1];
	var_00["strong_right"] = [%death_shotgun_spinl,%death_stand_sniper_spin1,%death_stand_sniper_chest1,%death_stand_sniper_chest2];
	var_00["strong_left"] = [%death_shotgun_spinr,%death_stand_sniper_spin2,%death_stand_sniper_chest1,%death_stand_sniper_chest2];
	var_00["running_forward"] = [%run_death_facedown,%run_death_roll,%run_death_fallonback,%run_death_flop];
	var_00["running_forward_f"] = [%run_death_fallonback];
	var_00["stand_pistol_forward"] = [%pistol_death_2];
	var_00["stand_pistol_front"] = [%pistol_death_2];
	var_00["stand_pistol_groin"] = [%pistol_death_3,%pistol_death_3];
	var_00["stand_pistol_torso_upper"] = [%pistol_death_3];
	var_00["stand_pistol_upper_body"] = [%pistol_death_4];
	var_00["stand_pistol_default"] = [%pistol_death_1];
	var_00["stand_pistol_torso_upper"] = [%pistol_death_3,%pistol_death_1];
	var_00["stand_pistol_lower_body"] = [%pistol_death_2];
	var_00["cover_right_stand"] = [%corner_standr_deatha,%corner_standr_deathb];
	var_00["cover_right_crouch_head"] = [%cornercrr_alert_death_slideout];
	var_00["cover_right_crouch_default"] = [%cornercrr_alert_death_slideout,%cornercrr_alert_death_back];
	var_00["cover_left_stand"] = [%corner_standl_deatha,%corner_standl_deathb];
	var_00["cover_left_crouch"] = [%cornercrl_death_side,%cornercrl_death_back];
	var_00["cover_stand"] = [%coverstand_death_left,%coverstand_death_right];
	var_00["cover_crouch_head"] = %covercrouch_death_1;
	var_00["cover_crouch_back"] = %covercrouch_death_3;
	var_00["cover_crouch_default"] = %covercrouch_death_2;
	var_00["saw_stand"] = [%saw_gunner_death];
	var_00["saw_crouch"] = [%saw_gunner_lowwall_death];
	var_00["saw_prone"] = [%saw_gunner_prone_death];
	var_00["dying_crawl_crouch"] = [%dying_back_death_v2,%dying_back_death_v3,%dying_back_death_v4];
	var_00["dying_crawl_prone"] = [%dying_crawl_death_v1,%dying_crawl_death_v2];
	var_00["stand_lower_body"] = [%exposed_death_groin,%stand_death_leg];
	var_00["stand_lower_body_extended"] = [%stand_death_crotch,%stand_death_guts];
	var_00["stand_head"] = [%exposed_death_headshot,%exposed_death_flop];
	var_00["stand_neck"] = [%exposed_death_neckgrab];
	var_00["stand_left_shoulder"] = [%exposed_death_twist,%stand_death_shoulder_spin,%stand_death_shoulderback];
	var_00["stand_torso_upper"] = [%stand_death_tumbleforward,%stand_death_stumbleforward];
	var_00["stand_torso_upper_extended"] = [%stand_death_fallside];
	var_00["stand_front_head"] = [%stand_death_face,%stand_death_headshot_slowfall];
	var_00["stand_front_head_extended"] = [%stand_death_head_straight_back];
	var_00["stand_front_torso"] = [%stand_death_tumbleback];
	var_00["stand_front_torso_extended"] = [%stand_death_chest_stunned];
	var_00["stand_back"] = [%exposed_death_falltoknees,%exposed_death_falltoknees_02];
	var_00["stand_default"] = [%exposed_death_02,%exposed_death_nerve];
	var_00["stand_default_firing"] = [%exposed_death_firing_02,%exposed_death_firing];
	var_00["stand_backup_default"] = %exposed_death;
	var_00["crouch_head"] = [%exposed_crouch_death_fetal];
	var_00["crouch_torso"] = [%exposed_crouch_death_flip];
	var_00["crouch_default1"] = [%exposed_crouch_death_twist];
	var_00["crouch_default2"] = [%exposed_crouch_death_flip];
	var_00["melee_standing_front"] = [%melee_death_standing_front];
	var_00["melee_standing_back"] = [%melee_death_standing_back];
	var_00["melee_standing_left"] = [%melee_death_standing_left];
	var_00["melee_standing_right"] = [%melee_death_standing_right];
	var_00["melee_crouching_front"] = [%melee_death_crouching_front];
	var_00["melee_crouching_back"] = [%melee_death_crouching_back];
	var_00["melee_crouching_left"] = [%melee_death_crouching_left];
	var_00["melee_crouching_right"] = [%melee_death_crouching_right];
	level.archetypes["soldier"]["death"] = var_00;
}

//Function Number: 2
func_4FDD()
{
	self endon("killanimscript");
	self stopsoundchannel("voice");
	var_00 = 0.3;
	self clearanim(%scripted_talking,var_00);
	maps\_anim::disabledefaultfacialanims(0);
	if(self.a.var_564F == 1)
	{
	}

	if(isdefined(self.var_237B))
	{
		var_01 = self [[ self.var_237B ]]();
		if(!isdefined(var_01))
		{
			var_01 = 1;
		}

		if(var_01)
		{
		}
	}

	animscripts/utility::func_4622("death");
	func_65AE(self.origin);
	level.var_5780--;
	level.var_577F--;
	if(isdefined(self.ragdoll_immediate) || self.forceragdollimmediate)
	{
		doimmediateragdolldeath();
	}

	if(isdefined(self.deathanim))
	{
		func_5D59(self.deathanim);
		if(isdefined(self.deathanimscript))
		{
			self [[ self.deathanimscript ]]();
		}
	}

	var_02 = animscripts/pain::func_8C45();
	if(self.damagelocation == "helmet" || self.damagelocation == "head")
	{
		helmetpop();
	}
	else if(var_02 && randomint(3) == 0)
	{
		helmetpop();
	}

	self clearanim(%root,0.3);
	if(!animscripts/utility::func_2310("head","helmet"))
	{
		if(self.diequietly)
		{
		}
		else
		{
			func_5D5B();
		}
	}

	if(var_02 && func_6000())
	{
	}

	if(isdefined(self.var_78EB))
	{
		if([[ self.var_78EB ]]())
		{
		}
	}

	if(func_78EA())
	{
	}

	var_03 = getdeathanim();
	func_5D59(var_03);
}

//Function Number: 3
doimmediateragdolldeath()
{
	animscripts/shared::func_2B49();
	self.var_757F = 1;
	var_00 = 10;
	var_01 = common_scripts\_destructible::getdamagetype(self.damagemod);
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
	var_04 = max(0.3,self.damagedir[2]);
	var_05 = (self.damagedir[0],self.damagedir[1],var_04);
	if(isdefined(self.var_62DA))
	{
		var_05 = var_05 * self.var_62DA;
	}
	else
	{
		var_05 = var_05 * var_03;
	}

	if(self.forceragdollimmediate)
	{
		var_05 = var_05 + self.prevanimdelta * 20 * 10;
	}

	if(isdefined(self.var_62DF))
	{
		var_05 = var_05 + self.var_62DF * 10;
	}

	self startragdollfromimpact(self.damagelocation,var_05);
	wait(0.05);
}

//Function Number: 4
func_214C(param_00,param_01)
{
	return param_00[0] * param_01[1] - param_01[0] * param_00[1];
}

//Function Number: 5
func_51A3(param_00,param_01)
{
	var_02 = vectordot(param_01,param_00);
	var_03 = cos(60);
	if(squared(var_02) < squared(var_03))
	{
		if(func_214C(param_00,param_01) > 0)
		{
			return 1;
		}

		return 3;
	}

	if(var_02 < 0)
	{
		return 0;
	}

	return 2;
}

//Function Number: 6
orientmeleevictim()
{
	if(self.damagemod == "MOD_MELEE" && isdefined(self.attacker))
	{
		var_00 = self.origin - self.attacker.origin;
		var_01 = anglestoforward(self.angles);
		var_02 = vectornormalize((var_00[0],var_00[1],0));
		var_03 = vectornormalize((var_01[0],var_01[1],0));
		var_04 = func_51A3(var_03,var_02);
		var_05 = var_04 * 90;
		var_06 = (-1 * var_02[0],-1 * var_02[1],0);
		var_07 = rotatevector(var_06,(0,var_05,0));
		var_08 = vectortoyaw(var_07);
		self orientmode("face angle",var_08);
	}
}

//Function Number: 7
func_5D59(param_00)
{
	if(!animhasnotetrack(param_00,"dropgun") && !animhasnotetrack(param_00,"fire_spray"))
	{
		animscripts/shared::func_2B49();
	}

	orientmeleevictim();
	self setflaggedanimknoballrestart("deathanim",param_00,%body,1,0.1);
	animscripts/face::func_6004(param_00,"death");
	if(isdefined(self.var_757F))
	{
		if(!isdefined(self.var_5674))
		{
			self startragdoll();
		}

		wait(0.05);
		self animmode("gravity");
	}
	else if(isdefined(self.var_62E2))
	{
		thread func_8AEF(self.var_62E2);
	}
	else if(!animhasnotetrack(param_00,"start_ragdoll"))
	{
		if(self.damagemod == "MOD_MELEE")
		{
			var_01 = 0.7;
		}
		else
		{
			var_01 = 0.35;
		}

		thread func_8AEF(getanimlength(param_00) * var_01);
	}

	if(!isdefined(self.var_757F))
	{
		thread playdeathfx();
	}

	self endon("forcedRagdoll");
	if(self.damagemod != "MOD_MELEE")
	{
		thread updatecheckforceragdoll();
		thread checkforceragdoll();
	}

	animscripts/shared::func_2986("deathanim");
	animscripts/shared::func_2B49();
	self notify("endPlayDeathAnim");
}

//Function Number: 8
updatecheckforceragdoll()
{
	self endon("endPlayDeathAnim");
	self endon("forcedRagdoll");
	wait(0.25);
	while(isdefined(self))
	{
		self queryshouldearlyragdoll();
		wait(0.2);
	}
}

//Function Number: 9
checkforceragdoll()
{
	self endon("endPlayDeathAnim");
	while(isdefined(self))
	{
		self waittill("ragdoll_early_result",var_00);
		if(!isdefined(self))
		{
		}

		if(var_00)
		{
			self startragdoll();
			animscripts/shared::func_2B49();
			break;
		}

		self waittill("ragdoll_early_result",var_00);
	}

	self notify("forcedRagdoll");
}

//Function Number: 10
func_8AEF(param_00)
{
	wait(param_00);
	if(isdefined(self))
	{
		animscripts/shared::func_2B49();
	}

	if(isdefined(self) && !isdefined(self.var_5674))
	{
		self startragdoll();
	}
}

//Function Number: 11
playdeathfx()
{
	self endon("killanimscript");
	if(self.stairsstate != "none")
	{
	}

	wait(2);
	func_5CB1();
}

//Function Number: 12
func_5CB1(param_00,param_01)
{
	if(!isdefined(self))
	{
	}

	if(isdefined(self.var_757E))
	{
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

//Function Number: 13
func_78EA()
{
	if(self.a.var_78D0 == "none")
	{
		return 0;
	}

	if(self.damagemod == "MOD_MELEE")
	{
		return 0;
	}

	switch(self.a.var_78D0)
	{
		case "cover_right":
			if(self.a.var_60B1 == "stand")
			{
				var_00 = animscripts/utility::lookupanim("death","cover_right_stand");
				dodeathfromarray(var_00);
			}
			else
			{
				var_00 = [];
				if(animscripts/utility::func_2310("head","neck"))
				{
					var_00 = animscripts/utility::lookupanim("death","cover_right_crouch_head");
				}
				else
				{
					var_00 = animscripts/utility::lookupanim("death","cover_right_crouch_default");
				}
	
				dodeathfromarray(var_00);
			}
			return 1;

		case "cover_left":
			if(self.a.var_60B1 == "stand")
			{
				var_00 = animscripts/utility::lookupanim("death","cover_left_stand");
				dodeathfromarray(var_00);
			}
			else
			{
				var_00 = animscripts/utility::lookupanim("death","cover_left_crouch");
				dodeathfromarray(var_00);
			}
			return 1;

		case "cover_stand":
			var_00 = animscripts/utility::lookupanim("death","cover_stand");
			dodeathfromarray(var_00);
			return 1;

		case "cover_crouch":
			var_00 = [];
			if(animscripts/utility::func_2310("head","neck") && self.damageyaw > 135 || self.damageyaw <= -45)
			{
				var_00[var_00.size] = animscripts/utility::lookupanim("death","cover_crouch_head");
			}
	
			if(self.damageyaw > -45 && self.damageyaw <= 45)
			{
				var_00[var_00.size] = animscripts/utility::lookupanim("death","cover_crouch_back");
			}
	
			var_00[var_00.size] = animscripts/utility::lookupanim("death","cover_crouch_default");
			dodeathfromarray(var_00);
			return 1;

		case "saw":
			if(self.a.var_60B1 == "stand")
			{
				dodeathfromarray(animscripts/utility::lookupanim("death","saw_stand"));
			}
			else if(self.a.var_60B1 == "crouch")
			{
				dodeathfromarray(animscripts/utility::lookupanim("death","saw_crouch"));
			}
			else
			{
				dodeathfromarray(animscripts/utility::lookupanim("death","saw_prone"));
			}
			return 1;

		case "dying_crawl":
			if(isdefined(self.a.onback) && self.a.var_60B1 == "crouch")
			{
				var_00 = animscripts/utility::lookupanim("death","dying_crawl_crouch");
				dodeathfromarray(var_00);
			}
			else
			{
				var_00 = animscripts/utility::lookupanim("death","dying_crawl_prone");
				dodeathfromarray(var_00);
			}
			return 1;

		case "stumbling_pain":
			func_5D59(self.a.var_7D18[self.a.var_7D18.size - 1]);
			return 1;
	}

	return 0;
}

//Function Number: 14
dodeathfromarray(param_00)
{
	var_01 = param_00[randomint(param_00.size)];
	func_5D59(var_01);
	if(isdefined(self.deathanimscript))
	{
		self [[ self.deathanimscript ]]();
	}
}

//Function Number: 15
func_5D5B()
{
	animscripts/face::func_6AB2("death");
}

//Function Number: 16
func_6197(param_00,param_01,param_02)
{
	var_03 = param_02 * 20;
	for(var_04 = 0;var_04 < var_03;var_04++)
	{
		wait(0.05);
	}
}

//Function Number: 17
helmetpop()
{
	if(!isdefined(self))
	{
	}

	if(!isdefined(self.hatmodel))
	{
	}

	var_00 = getpartname(self.hatmodel,0);
	var_01 = spawn("script_model",self.origin + (0,0,64));
	var_01 setmodel(self.hatmodel);
	var_01.origin = self gettagorigin(var_00);
	var_01.angles = self gettagangles(var_00);
	var_01 thread func_4180(self.damagedir);
	var_02 = self.hatmodel;
	self.hatmodel = undefined;
	wait(0.05);
	if(!isdefined(self))
	{
	}

	self detach(var_02,"");
}

//Function Number: 18
func_4180(param_00)
{
	var_01 = param_00;
	var_01 = var_01 * randomfloatrange(2000,4000);
	var_02 = var_01[0];
	var_03 = var_01[1];
	var_04 = randomfloatrange(1500,3000);
	var_05 = self.origin + (randomfloatrange(-1,1),randomfloatrange(-1,1),randomfloatrange(-1,1)) * 5;
	self physicslaunchclient(var_05,(var_02,var_03,var_04));
	wait(60);
	for(;;)
	{
		if(!isdefined(self))
		{
		}

		if(distancesquared(self.origin,level.player.origin) > 262144)
		{
			break;
		}

		wait(30);
	}

	self delete();
}

//Function Number: 19
func_65AE(param_00)
{
	for(var_01 = 0;var_01 < level.var_7994.size;var_01++)
	{
		level.var_7994[var_01] clearsightposnear(param_00);
	}
}

//Function Number: 20
clearsightposnear(param_00)
{
	if(!isdefined(self.var_754B))
	{
	}

	if(distance(param_00,self.var_754B) < 80)
	{
		self.var_754B = undefined;
		self.var_754E = gettime();
	}
}

//Function Number: 21
func_74A9()
{
	if(self.a.var_5486 != "run")
	{
		return 0;
	}

	if(self getmotionangle() > 60 || self getmotionangle() < -60)
	{
		return 0;
	}

	if(self.damagemod == "MOD_MELEE")
	{
		return 0;
	}

	return 1;
}

//Function Number: 22
func_74AD(param_00,param_01,param_02,param_03)
{
	if(isdefined(self.a.doinglongdeath))
	{
		return 0;
	}

	if(self.a.var_60B1 == "prone" || isdefined(self.a.onback))
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

	if(self.a.var_5486 == "run" && !func_4882(param_03,275))
	{
		if(randomint(100) < 65)
		{
			return 0;
		}
	}

	if(animscripts/utility::issniperrifle(param_00) && self.maxhealth < param_02)
	{
		return 1;
	}

	if(animscripts/utility::isshotgun(param_00) && func_4882(param_03,512))
	{
		return 1;
	}

	if(func_48AA(param_00) && func_4882(param_03,425))
	{
		return 1;
	}

	return 0;
}

//Function Number: 23
func_48AA(param_00)
{
	if(param_00 == "deserteagle")
	{
		return 1;
	}

	return 0;
}

//Function Number: 24
func_4882(param_00,param_01)
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

//Function Number: 25
getdeathanim()
{
	if(func_74AD(self.damageweapon,self.damagemod,self.damagetaken,self.attacker))
	{
		var_00 = func_3C17();
		if(isdefined(var_00))
		{
			return var_00;
		}
	}

	if(isdefined(self.a.onback))
	{
		if(self.a.var_60B1 == "crouch")
		{
			return func_3A36();
		}
		else
		{
			animscripts/notetracks::stoponback();
		}
	}

	if(self.a.var_60B1 == "stand")
	{
		if(func_74A9())
		{
			return func_3BDC();
		}

		return func_3C03();
	}

	if(self.a.var_60B1 == "crouch")
	{
		return getcrouchdeathanim();
	}

	if(self.a.var_60B1 == "prone")
	{
		return func_3BA8();
	}
}

//Function Number: 26
func_3C17()
{
	var_00 = abs(self.damageyaw);
	if(var_00 < 45)
	{
	}

	if(var_00 > 150)
	{
		if(animscripts/utility::func_2310("left_leg_upper","left_leg_lower","right_leg_upper","right_leg_lower","left_foot","right_foot"))
		{
			var_01 = animscripts/utility::lookupanim("death","strong_legs");
		}
		else if(self.damagelocation == "torso_lower")
		{
			var_01 = animscripts/utility::lookupanim("death","strong_torso_lower");
		}
		else
		{
			var_01 = animscripts/utility::lookupanim("death","strong_default");
		}
	}
	else if(self.damageyaw < 0)
	{
		var_01 = animscripts/utility::lookupanim("death","strong_right");
	}
	else
	{
		var_01 = animscripts/utility::lookupanim("death","strong_left");
	}

	return var_01[randomint(var_01.size)];
}

//Function Number: 27
func_3BDC()
{
	if(abs(self.damageyaw) < 45)
	{
		var_00 = animscripts/utility::lookupanim("death","running_forward_f");
		var_01 = func_3BBE(var_00);
		if(isdefined(var_01))
		{
			return var_01;
		}
	}

	var_00 = animscripts/utility::lookupanim("death","running_forward");
	var_01 = func_3BBE(var_00);
	if(isdefined(var_01))
	{
		return var_01;
	}

	return func_3C03();
}

//Function Number: 28
func_3BBE(param_00)
{
	if(!isdefined(param_00))
	{
		return undefined;
	}

	var_01 = undefined;
	for(var_02 = param_00.size;var_02 > 0;var_02--)
	{
		var_03 = randomint(var_02);
		var_01 = param_00[var_03];
		if(!func_4873(var_01))
		{
			return var_01;
		}

		param_00[var_03] = param_00[var_02 - 1];
		param_00[var_02 - 1] = undefined;
	}

	return undefined;
}

//Function Number: 29
func_65B9(param_00)
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

//Function Number: 30
func_4873(param_00)
{
	var_01 = 1;
	if(animhasnotetrack(param_00,"code_move"))
	{
		var_01 = getnotetracktimes(param_00,"code_move")[0];
	}

	var_02 = getmovedelta(param_00,0,var_01);
	var_03 = self localtoworldcoords(var_02);
	return !self maymovetopoint(var_03,1,1);
}

//Function Number: 31
func_3C05()
{
	var_00 = [];
	if(abs(self.damageyaw) < 50)
	{
		var_00 = animscripts/utility::lookupanim("death","stand_pistol_forward");
	}
	else
	{
		if(abs(self.damageyaw) < 110)
		{
			var_00 = animscripts/utility::lookupanim("death","stand_pistol_front");
		}

		if(self.damagelocation == "torso_upper")
		{
			var_00 = common_scripts\utility::array_combine(animscripts/utility::lookupanim("death","stand_pistol_torso_upper"),var_00);
		}
		else if(animscripts/utility::func_2310("torso_lower","left_leg_upper","left_leg_lower","right_leg_upper","right_leg_lower"))
		{
			var_00 = common_scripts\utility::array_combine(animscripts/utility::lookupanim("death","stand_pistol_torso_upper"),var_00);
		}

		if(!animscripts/utility::func_2310("head","neck","helmet","left_foot","right_foot","left_hand","right_hand","gun") && randomint(2) == 0)
		{
			var_00 = common_scripts\utility::array_combine(animscripts/utility::lookupanim("death","stand_pistol_upper_body"),var_00);
		}

		if(var_00.size == 0 || animscripts/utility::func_2310("torso_lower","torso_upper","neck","head","helmet","right_arm_upper","left_arm_upper"))
		{
			var_00 = common_scripts\utility::array_combine(animscripts/utility::lookupanim("death","stand_pistol_default"),var_00);
		}
	}

	return var_00;
}

//Function Number: 32
func_3C03()
{
	var_00 = [];
	var_01 = [];
	if(animscripts/utility::func_87FE())
	{
		var_00 = func_3C05();
	}
	else if(isdefined(self.attacker) && self shouldplaymeleedeathanim(self.attacker))
	{
		if(self.damageyaw <= 120 || self.damageyaw > -120)
		{
			var_00 = animscripts/utility::lookupanim("death","melee_standing_front");
		}
		else if(self.damageyaw <= -60 && self.damageyaw > 60)
		{
			var_00 = animscripts/utility::lookupanim("death","melee_standing_back");
		}
		else if(self.damageyaw < 0)
		{
			var_00 = animscripts/utility::lookupanim("death","melee_standing_left");
		}
		else
		{
			var_00 = animscripts/utility::lookupanim("death","melee_standing_right");
		}
	}
	else
	{
		if(animscripts/utility::func_2310("torso_lower","left_leg_upper","left_leg_lower","right_leg_lower","right_leg_lower"))
		{
			var_00 = animscripts/utility::lookupanim("death","stand_lower_body");
			var_01 = animscripts/utility::lookupanim("death","stand_lower_body_extended");
		}
		else if(animscripts/utility::func_2310("head","helmet"))
		{
			var_00 = animscripts/utility::lookupanim("death","stand_head");
		}
		else if(animscripts/utility::func_2310("neck"))
		{
			var_00 = animscripts/utility::lookupanim("death","stand_neck");
		}
		else if(animscripts/utility::func_2310("torso_upper","left_arm_upper"))
		{
			var_00 = animscripts/utility::lookupanim("death","stand_left_shoulder");
		}

		if(animscripts/utility::func_2310("torso_upper"))
		{
			var_00 = common_scripts\utility::array_combine(var_00,animscripts/utility::lookupanim("death","stand_torso_upper"));
			var_01 = common_scripts\utility::array_combine(var_01,animscripts/utility::lookupanim("death","stand_torso_upper_extended"));
		}

		if(self.damageyaw > 135 || self.damageyaw <= -135)
		{
			if(animscripts/utility::func_2310("neck","head","helmet"))
			{
				var_00 = common_scripts\utility::array_combine(var_00,animscripts/utility::lookupanim("death","stand_front_torso"));
				var_01 = common_scripts\utility::array_combine(var_01,animscripts/utility::lookupanim("death","stand_front_torso_extended"));
			}

			if(animscripts/utility::func_2310("torso_upper"))
			{
				var_00 = common_scripts\utility::array_combine(var_00,animscripts/utility::lookupanim("death","stand_front_torso"));
				var_01 = common_scripts\utility::array_combine(var_01,animscripts/utility::lookupanim("death","stand_front_torso_extended"));
			}
		}
		else if(self.damageyaw > -45 && self.damageyaw <= 45)
		{
			var_00 = common_scripts\utility::array_combine(var_00,animscripts/utility::lookupanim("death","stand_back"));
		}

		var_02 = var_00.size > 0;
		if(!var_02 || randomint(100) < 15)
		{
			var_00 = common_scripts\utility::array_combine(var_00,animscripts/utility::lookupanim("death","stand_default"));
		}

		if(randomint(100) < 10 && func_3344())
		{
			var_00 = common_scripts\utility::array_combine(var_00,animscripts/utility::lookupanim("death","stand_default_firing"));
			var_00 = func_65B9(var_00);
		}
	}

	if(var_00.size == 0)
	{
		var_00[var_00.size] = animscripts/utility::lookupanim("death","stand_backup_default");
	}

	if(!self.a.disablelongdeath && self.stairsstate == "none" && !isdefined(self.a.painonstairs))
	{
		var_03 = randomint(var_00.size + var_01.size);
		if(var_03 < var_00.size)
		{
			return var_00[var_03];
		}
		else
		{
			return var_01[var_03 - var_00.size];
		}
	}

	return var_00[randomint(var_00.size)];
}

//Function Number: 33
getcrouchdeathanim()
{
	var_00 = [];
	if(isdefined(self.attacker) && self shouldplaymeleedeathanim(self.attacker))
	{
		if(self.damageyaw <= 120 || self.damageyaw > -120)
		{
			var_00 = animscripts/utility::lookupanim("death","melee_crouching_front");
		}
		else if(self.damageyaw <= -60 && self.damageyaw > 60)
		{
			var_00 = animscripts/utility::lookupanim("death","melee_crouching_back");
		}
		else if(self.damageyaw < 0)
		{
			var_00 = animscripts/utility::lookupanim("death","melee_crouching_left");
		}
		else
		{
			var_00 = animscripts/utility::lookupanim("death","melee_crouching_right");
		}
	}
	else
	{
		if(animscripts/utility::func_2310("head","neck"))
		{
			var_00 = animscripts/utility::lookupanim("death","crouch_head");
		}

		if(animscripts/utility::func_2310("torso_upper","torso_lower","left_arm_upper","right_arm_upper","neck"))
		{
			var_00 = common_scripts\utility::array_combine(var_00,animscripts/utility::lookupanim("death","crouch_torso"));
		}

		if(var_00.size < 2)
		{
			var_00 = common_scripts\utility::array_combine(var_00,animscripts/utility::lookupanim("death","crouch_default1"));
		}

		if(var_00.size < 2)
		{
			var_00 = common_scripts\utility::array_combine(var_00,animscripts/utility::lookupanim("death","crouch_default2"));
		}
	}

	return var_00[randomint(var_00.size)];
}

//Function Number: 34
func_3BA8()
{
	if(isdefined(self.a.var_61FB))
	{
		return %prone_death_quickdeath;
	}

	return %dying_crawl_death_v1;
}

//Function Number: 35
func_3A36()
{
	var_00 = animscripts/utility::func_ED8(%dying_back_death_v1,%dying_back_death_v2,%dying_back_death_v3,%dying_back_death_v4);
	return var_00[randomint(var_00.size)];
}

//Function Number: 36
func_3344()
{
	if(!isdefined(self.weapon) || !animscripts/utility::usingriflelikeweapon() || !weaponisauto(self.weapon) || self.diequietly)
	{
		return 0;
	}

	if(self.a.var_8DB5["right"] == "none")
	{
		return 0;
	}

	return 1;
}

//Function Number: 37
func_83F5(param_00)
{
	return param_00;
}

//Function Number: 38
func_83F6(param_00)
{
	return param_00;
}

//Function Number: 39
func_6000()
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
	if(self.a.var_5486 != "run")
	{
		if(self.damageyaw > 135 || self.damageyaw <= -135)
		{
			var_00[var_00.size] = func_83F5(%death_explosion_stand_b_v1);
			var_00[var_00.size] = func_83F5(%death_explosion_stand_b_v2);
			var_00[var_00.size] = func_83F5(%death_explosion_stand_b_v3);
			var_00[var_00.size] = func_83F5(%death_explosion_stand_b_v4);
		}
		else if(self.damageyaw > 45 && self.damageyaw <= 135)
		{
			var_00[var_00.size] = func_83F5(%death_explosion_stand_l_v1);
			var_00[var_00.size] = func_83F5(%death_explosion_stand_l_v2);
			var_00[var_00.size] = func_83F5(%death_explosion_stand_l_v3);
		}
		else if(self.damageyaw > -45 && self.damageyaw <= 45)
		{
			var_00[var_00.size] = func_83F5(%death_explosion_stand_f_v1);
			var_00[var_00.size] = func_83F5(%death_explosion_stand_f_v2);
			var_00[var_00.size] = func_83F5(%death_explosion_stand_f_v3);
			var_00[var_00.size] = func_83F5(%death_explosion_stand_f_v4);
		}
		else
		{
			var_00[var_00.size] = func_83F5(%death_explosion_stand_r_v1);
			var_00[var_00.size] = func_83F5(%death_explosion_stand_r_v2);
		}
	}
	else if(self.damageyaw > 135 || self.damageyaw <= -135)
	{
		var_00[var_00.size] = func_83F5(%death_explosion_run_b_v1);
		var_00[var_00.size] = func_83F5(%death_explosion_run_b_v2);
	}
	else if(self.damageyaw > 45 && self.damageyaw <= 135)
	{
		var_00[var_00.size] = func_83F5(%death_explosion_run_l_v1);
		var_00[var_00.size] = func_83F5(%death_explosion_run_l_v2);
	}
	else if(self.damageyaw > -45 && self.damageyaw <= 45)
	{
		var_00[var_00.size] = func_83F5(%death_explosion_run_f_v1);
		var_00[var_00.size] = func_83F5(%death_explosion_run_f_v2);
		var_00[var_00.size] = func_83F5(%death_explosion_run_f_v3);
		var_00[var_00.size] = func_83F5(%death_explosion_run_f_v4);
	}
	else
	{
		var_00[var_00.size] = func_83F5(%death_explosion_run_r_v1);
		var_00[var_00.size] = func_83F5(%death_explosion_run_r_v2);
	}

	var_01 = var_00[randomint(var_00.size)];
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
	func_5D59(var_01);
	return 1;
}