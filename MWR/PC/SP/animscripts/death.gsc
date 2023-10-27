/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\death.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 49
 * Decompile Time: 810 ms
 * Timestamp: 10/27/2023 2:44:07 AM
*******************************************************************/

//Function Number: 1
init_animset_death()
{
	var_00 = [];
	var_00["directed_energy_stand_front_head"] = [%stand_death_head_front_a_dea];
	var_00["directed_energy_stand_front_legs"] = [%stand_death_legs_front_a_dea];
	var_00["directed_energy_stand_front_default"] = [%stand_death_torso_front_a_dea];
	var_00["directed_energy_stand_back_default"] = [%stand_death_torso_back_a_dea];
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
	var_00["cover_right_crouch_head"] = [[%h1_cornercrr_alert_death_neck_2],[%cornercrr_alert_death_slideout]];
	var_00["cover_right_crouch_default"] = [[%h1_cornercrr_alert_death_slideout_2,%h1_cornercrr_alert_death_fallout_2,%h1_cornercrr_alert_death_back_2],[%cornercrr_alert_death_slideout,%cornercrr_alert_death_back]];
	var_00["cover_left_stand"] = [%corner_standl_deatha,%corner_standl_deathb];
	var_00["cover_left_crouch"] = [[%h1_cornercrl_death_back_2,%h1_cornercrl_death_side_2],[%cornercrl_death_side,%cornercrl_death_back]];
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
main()
{
	self endon("killanimscript");
	self stopsounds();
	var_00 = 0.3;
	self clearanim(%scripted_talking,var_00);
	maps\_anim::disabledefaultfacialanims(0);
	self hudoutlinedisable();
	if(self.a.nodeath == 1)
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

	animscripts\utility::initialize("death");
	removeselffrom_squadlastseenenemypos(self.origin);
	level.numdeathsuntilcrawlingpain--;
	level.numdeathsuntilcornergrenadedeath--;
	if(isdefined(self.ragdoll_immediate) || self.forceragdollimmediate)
	{
		doimmediateragdolldeath();
	}

	if(isdefined(self.deathanim))
	{
		playdeathanim(self.deathanim,1);
		if(isdefined(self.deathanimscript))
		{
			self [[ self.deathanimscript ]]();
		}

		return;
	}

	var_02 = animscripts\pain::wasdamagedbyexplosive();
	if(self.damagelocation == "helmet" || self.damagelocation == "head")
	{
		helmetpop();
	}
	else if(var_02 && randomint(3) == 0)
	{
		helmetpop();
	}

	self clearanim(%animscript_root,0.3);
	if(!animscripts\utility::damagelocationisany("head","helmet") || (self.damagemod == "MOD_MELEE" || self.damagemod == "MOD_MELEE_ALT") && isdefined(self.attacker))
	{
		if(self.diequietly)
		{
		}
		else
		{
			playdeathsound();
		}
	}

	if(var_02 && playexplodedeathanim())
	{
		return;
	}

	if(isdefined(self.specialdeathfunc))
	{
		if([[ self.specialdeathfunc ]]())
		{
			return;
		}
	}

	if(specialdeath())
	{
		return;
	}

	var_03 = getdeathanim();
	playdeathanim(var_03,0);
}

//Function Number: 3
doimmediateragdolldeath()
{
	animscripts\shared::dropallaiweapons();
	self.skipdeathanim = 1;
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
	if(level.cheat_super_ragdoll)
	{
		var_03 = clamp(int(var_02 / 100) * randomintrange(2500,5000),2500,25000);
	}

	var_04 = max(0.3,self.damagedir[2]);
	var_05 = (self.damagedir[0],self.damagedir[1],var_04);
	if(isdefined(self.ragdoll_directionscale))
	{
		var_05 = var_05 * self.ragdoll_directionscale;
	}
	else
	{
		var_05 = var_05 * var_03;
	}

	if(self.forceragdollimmediate)
	{
		var_05 = var_05 + self.prevanimdelta * 20 * 10;
	}

	if(isdefined(self.ragdoll_start_vel))
	{
		var_05 = var_05 + self.ragdoll_start_vel * 10;
	}

	self startragdollfromimpact(self.damagelocation,var_05);
	wait(0.05);
}

//Function Number: 4
cross2d(param_00,param_01)
{
	return param_00[0] * param_01[1] - param_01[0] * param_00[1];
}

//Function Number: 5
meleegetattackercardinaldirection(param_00,param_01)
{
	var_02 = vectordot(param_01,param_00);
	var_03 = cos(60);
	if(squared(var_02) < squared(var_03))
	{
		if(cross2d(param_00,param_01) > 0)
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
	if((self.damagemod == "MOD_MELEE" || self.damagemod == "MOD_MELEE_ALT") && isdefined(self.attacker))
	{
		if(isdefined(self.altmeleedeath) && isdefined(self.altmeleevictimorientation))
		{
			var_00 = self.altmeleevictimorientation;
			self.altmeleevictimorientation = undefined;
		}
		else
		{
			var_00 = getorientedmeleevictimtargetyaw();
		}

		self orientmode("face angle",var_00);
	}
}

//Function Number: 7
getorientedmeleevictimtargetyaw()
{
	var_00 = self.origin - self.attacker.origin;
	var_01 = anglestoforward(self.angles);
	var_02 = vectornormalize((var_00[0],var_00[1],0));
	var_03 = vectornormalize((var_01[0],var_01[1],0));
	var_04 = meleegetattackercardinaldirection(var_03,var_02);
	var_05 = var_04 * 90;
	var_06 = (-1 * var_02[0],-1 * var_02[1],0);
	var_07 = rotatevector(var_06,(0,var_05,0));
	var_08 = vectortoyaw(var_07);
	return var_08;
}

//Function Number: 8
man_overboard()
{
	if(getdvar("mapname") != "sanfran_b")
	{
		return;
	}

	var_00 = getentarray("enemy_overboard_achievement_trigger","targetname");
	foreach(var_02 in var_00)
	{
		var_02 thread man_overboard_helper(self);
	}
}

//Function Number: 9
man_overboard_helper(param_00)
{
	while(isdefined(param_00))
	{
		if(self istouching(param_00) && isdefined(level.player.man_overboard))
		{
			maps\_utility::giveachievement_wrapper("LEVEL_12A");
			break;
		}

		wait(0.05);
	}
}

//Function Number: 10
playdeathanim(param_00,param_01)
{
	if(self.damagemod == "MOD_MELEE_ALT" && getdvar("mapname","undefined") == "sanfran_b")
	{
		thread man_overboard();
	}

	if(!animhasnotetrack(param_00,"dropgun") && !animhasnotetrack(param_00,"fire_spray"))
	{
		animscripts\shared::dropallaiweapons();
	}

	if(!isdefined(self.nomeleedeathorient) || !self.nomeleedeathorient)
	{
		orientmeleevictim();
	}

	self setflaggedanimknoballrestart("deathanim",param_00,%body,1,0.1);
	animscripts\face::playfacialanim(param_00,"death");
	if(isdefined(self.skipdeathanim))
	{
		if(!isdefined(self.noragdoll))
		{
			self startragdoll();
		}

		wait(0.05);
		self animmode("gravity");
	}
	else if(isdefined(self.ragdolltime))
	{
		thread waitforragdoll(self.ragdolltime);
	}
	else if(!animhasnotetrack(param_00,"start_ragdoll"))
	{
		if(!isdefined(param_01) || !param_01)
		{
			if(self.damagemod == "MOD_MELEE" || self.damagemod == "MOD_MELEE_ALT")
			{
				var_02 = 0.7;
			}
			else
			{
				var_02 = 0.35;
			}

			thread waitforragdoll(getanimlength(param_00) * var_02);
		}
	}

	if(!isdefined(self.skipdeathanim))
	{
		thread playdeathfx(getanimlength(param_00) - 0.1);
	}

	self endon("forcedRagdoll");
	if(self.damagemod != "MOD_MELEE")
	{
		thread updatecheckforceragdoll();
		thread checkforceragdoll();
	}

	animscripts\shared::donotetracks("deathanim");
	animscripts\shared::dropallaiweapons();
	self notify("endPlayDeathAnim");
}

//Function Number: 11
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

//Function Number: 12
checkforceragdoll()
{
	self endon("endPlayDeathAnim");
	while(isdefined(self))
	{
		self waittill("ragdoll_early_result",var_00);
		if(!isdefined(self))
		{
			return;
		}

		if(var_00)
		{
			self startragdoll();
			animscripts\shared::dropallaiweapons();
			break;
		}

		self waittill("ragdoll_early_result",var_00);
	}

	self notify("forcedRagdoll");
}

//Function Number: 13
waitforragdoll(param_00)
{
	wait(param_00);
	if(isdefined(self))
	{
		animscripts\shared::dropallaiweapons();
	}

	if(isdefined(self) && !isdefined(self.noragdoll))
	{
		self startragdoll();
	}
}

//Function Number: 14
playdeathfx(param_00)
{
	self endon("killanimscript");
	if(self.stairsstate != "none")
	{
		return;
	}

	if(isdefined(param_00))
	{
		wait(param_00);
	}
	else
	{
		wait(2);
	}

	play_blood_pool();
}

//Function Number: 15
play_blood_pool(param_00,param_01)
{
	if(!isdefined(self))
	{
		return;
	}

	if(isdefined(self.skipbloodpool))
	{
		return;
	}

	if(getdvarint("cg_blood") == 0)
	{
		return;
	}

	var_02 = self gettagorigin("j_SpineUpper");
	var_03 = self gettagangles("j_SpineUpper");
	var_04 = anglestoforward(var_03);
	var_05 = anglestoup(var_03);
	var_06 = anglestoright(var_03);
	var_02 = var_02 + var_04 * -8.5 + var_05 * 5 + var_06 * 0;
	var_07 = bullettrace(var_02 + (0,0,30),var_02 - (0,0,100),0,self);
	if(var_07["normal"][2] > 0.9)
	{
		playfx(level._effect["deathfx_bloodpool_generic"],var_07["position"]);
	}
}

//Function Number: 16
specialdeath()
{
	if(level.cheat_super_ragdoll && getdvarint("ragdoll_enable"))
	{
		doimmediateragdolldeath();
		return 1;
	}

	if(self.a.special == "none")
	{
		return 0;
	}

	if(self.damagemod == "MOD_MELEE" || self.damagemod == "MOD_MELEE_ALT")
	{
		return 0;
	}

	switch(self.a.special)
	{
		case "cover_right":
			break;

		case "cover_left":
			break;

		case "cover_stand":
			break;

		case "cover_crouch":
			break;

		case "saw":
			break;

		case "dying_crawl":
			break;

		case "stumbling_pain":
			break;
	}
}

//Function Number: 17
dodeathfromarray(param_00)
{
	var_01 = param_00[randomint(param_00.size)];
	playdeathanim(var_01,0);
	if(isdefined(self.deathanimscript))
	{
		self [[ self.deathanimscript ]]();
	}
}

//Function Number: 18
playdeathsound()
{
	if((self.damagemod == "MOD_MELEE" || self.damagemod == "MOD_MELEE_ALT") && isdefined(self.attacker))
	{
		animscripts\face::saygenericdialogue("melee_death");
		return;
	}

	animscripts\face::saygenericdialogue("death");
}

//Function Number: 19
print3dfortime(param_00,param_01,param_02)
{
	var_03 = param_02 * 20;
	for(var_04 = 0;var_04 < var_03;var_04++)
	{
		wait(0.05);
	}
}

//Function Number: 20
helmetpop()
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
	var_02 = getheadshothelmet();
	var_01 setmodel(var_02);
	var_01.origin = self gettagorigin(var_00);
	var_01.angles = self gettagangles(var_00);
	var_01 thread helmetlaunch(self.damagedir);
	var_03 = self.hatmodel;
	self.hatmodel = undefined;
	wait(0.05);
	if(!isdefined(self))
	{
		return;
	}

	self detach(var_03,"");
}

//Function Number: 21
getheadshothelmet()
{
	var_00 = self.hatmodel;
	if(!isdefined(level.nostraphelmetmodel))
	{
		return var_00;
	}

	foreach(var_03, var_02 in level.nostraphelmetmodel)
	{
		if(var_00 == var_03)
		{
			var_00 = var_02;
			break;
		}
	}

	return var_00;
}

//Function Number: 22
init_headshot_helmet()
{
	level.nostraphelmetmodel = [];
	level.nostraphelmetmodel["helmet_sp_arab_regular_tariq"] = "helmet_sp_arab_regular_tariq_nostrap";
	level.nostraphelmetmodel["helmet_sp_arab_regular_suren"] = "helmet_sp_arab_regular_suren_nostrap";
	foreach(var_01 in level.nostraphelmetmodel)
	{
		precachemodel(var_01);
	}
}

//Function Number: 23
helmetlaunch(param_00)
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
			return;
		}

		if(distancesquared(self.origin,level.player.origin) > 262144)
		{
			break;
		}

		wait(30);
	}

	self delete();
}

//Function Number: 24
removeselffrom_squadlastseenenemypos(param_00)
{
	for(var_01 = 0;var_01 < level.squadindex.size;var_01++)
	{
		level.squadindex[var_01] clearsightposnear(param_00);
	}
}

//Function Number: 25
clearsightposnear(param_00)
{
	if(!isdefined(self.sightpos))
	{
		return;
	}

	if(distance(param_00,self.sightpos) < 80)
	{
		self.sightpos = undefined;
		self.sighttime = gettime();
	}
}

//Function Number: 26
shoulddorunningforwarddeath()
{
	if(self.a.movement != "run")
	{
		return 0;
	}

	if(self getmotionangle() > 60 || self getmotionangle() < -60)
	{
		return 0;
	}

	if(self.damagemod == "MOD_MELEE" || self.damagemod == "MOD_MELEE_ALT")
	{
		return 0;
	}

	return 1;
}

//Function Number: 27
shoulddodirectedenergydeath(param_00,param_01,param_02,param_03)
{
	if(param_01 != "MOD_ENERGY")
	{
		return 0;
	}

	if(self.a.pose != "stand")
	{
		return 0;
	}

	if(isdefined(self.a.doinglongdeath))
	{
		return 0;
	}

	return 1;
}

//Function Number: 28
is_weak_melee_weapon(param_00)
{
	if(isdefined(param_00))
	{
		return issubstr(param_00,"onearm");
	}

	return 0;
}

//Function Number: 29
shoulddostrongmeleedamage(param_00,param_01,param_02)
{
	if(isdefined(param_00))
	{
		if(param_00 == "MOD_MELEE_ALT")
		{
			if(is_weak_melee_weapon(param_02))
			{
				return 0;
			}

			return 1;
		}
		else if(param_00 == "MOD_MELEE" && isdefined(param_01) && isdefined(param_01.forcealtmeleedeaths))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 30
shoulddostrongbulletdamage(param_00,param_01,param_02,param_03)
{
	if(isdefined(self.a.doinglongdeath))
	{
		return 0;
	}

	if(self.a.pose == "prone" || isdefined(self.a.onback))
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

	if(param_01 == "MOD_MELEE" || param_01 == "MOD_MELEE_ALT")
	{
		return 0;
	}

	if(self.a.movement == "run" && !isattackerwithindist(param_03,275))
	{
		if(randomint(100) < 65)
		{
			return 0;
		}
	}

	if(animscripts\utility::issniperrifle(param_00) && self.maxhealth < param_02)
	{
		return 1;
	}

	if(animscripts\utility::isshotgun(param_00) && isattackerwithindist(param_03,512))
	{
		return 1;
	}

	if(isdeserteagle(param_00) && isattackerwithindist(param_03,425))
	{
		return 1;
	}

	return 0;
}

//Function Number: 31
isdeserteagle(param_00)
{
	if(param_00 == "deserteagle")
	{
		return 1;
	}

	return 0;
}

//Function Number: 32
isattackerwithindist(param_00,param_01)
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

//Function Number: 33
getdeathanim()
{
	if(shoulddostrongmeleedamage(self.damagemod,self.attacker,self.damageweapon))
	{
		self.altmeleedeath = 1;
		var_00 = getalternatemeleedeathanim();
		if(isdefined(var_00))
		{
			return var_00;
		}
	}

	if(shoulddodirectedenergydeath(self.damageweapon,self.damagemod,self.damagetaken,self.attacker))
	{
		var_00 = getdirectedenergydeathanim();
		if(isdefined(var_00))
		{
			return var_00;
		}
	}

	if(shoulddostrongbulletdamage(self.damageweapon,self.damagemod,self.damagetaken,self.attacker))
	{
		var_00 = getstrongbulletdamagedeathanim();
		if(isdefined(var_00))
		{
			return var_00;
		}
	}

	if(isdefined(self.a.onback))
	{
		if(self.a.pose == "crouch")
		{
			return getbackdeathanim();
		}
		else
		{
			animscripts\notetracks::stoponback();
		}
	}

	if(self.a.pose == "stand")
	{
		if(shoulddorunningforwarddeath())
		{
			return getrunningforwarddeathanim();
		}

		return getstanddeathanim();
	}

	if(self.a.pose == "crouch")
	{
		return getcrouchdeathanim();
	}

	if(self.a.pose == "prone")
	{
		return getpronedeathanim();
	}
}

//Function Number: 34
getalternatemeleedeathanim()
{
	self.altmeleevictimorientation = getorientedmeleevictimtargetyaw();
	var_00 = self.altmeleevictimorientation - self.angles[1];
	var_01 = angleclamp180(self.damageyaw - var_00);
	var_02 = self.a.pose;
	if(!isdefined(self.attacker) || self.attacker != level.player)
	{
		return;
	}

	var_03 = level.player getstance();
	var_04 = [];
	if(var_01 < -135 || var_01 > 135)
	{
		var_04 = animscripts\utility::lookupanim("death","melee_exo_front_" + var_03 + "_" + var_02);
		if(animscripts\utility::damagelocationisany("head","neck"))
		{
			var_04 = common_scripts\utility::array_combine(var_04,animscripts\utility::lookupanim("death","melee_exo_" + var_02 + "_front_head"));
		}
	}
	else if(var_01 < 45 && var_01 > -45)
	{
		var_04 = animscripts\utility::lookupanim("death","melee_exo_back_" + var_03 + "_" + var_02);
		if(animscripts\utility::damagelocationisany("head","neck"))
		{
			var_04 = common_scripts\utility::array_combine(var_04,animscripts\utility::lookupanim("death","melee_exo_" + var_02 + "_back_head"));
		}
	}
	else if(var_01 < -45 && var_01 > -135)
	{
		var_04 = animscripts\utility::lookupanim("death","melee_exo_left_" + var_03 + "_" + var_02);
		if(animscripts\utility::damagelocationisany("head","neck"))
		{
			var_04 = common_scripts\utility::array_combine(var_04,animscripts\utility::lookupanim("death","melee_exo_" + var_02 + "_left_head"));
		}
	}
	else
	{
		var_04 = animscripts\utility::lookupanim("death","melee_exo_right_" + var_03 + "_" + var_02);
		if(animscripts\utility::damagelocationisany("head","neck"))
		{
			var_04 = common_scripts\utility::array_combine(var_04,animscripts\utility::lookupanim("death","melee_exo_" + var_02 + "_right_head"));
		}
	}

	return var_04[randomint(var_04.size)];
}

//Function Number: 35
getstrongbulletdamagedeathanim()
{
	var_00 = abs(self.damageyaw);
	if(var_00 < 45)
	{
		return;
	}

	if(var_00 > 150)
	{
		if(animscripts\utility::damagelocationisany("left_leg_upper","left_leg_lower","right_leg_upper","right_leg_lower","left_foot","right_foot"))
		{
			var_01 = animscripts\utility::lookupanim("death","strong_legs");
		}
		else if(self.damagelocation == "torso_lower")
		{
			var_01 = animscripts\utility::lookupanim("death","strong_torso_lower");
		}
		else
		{
			var_01 = animscripts\utility::lookupanim("death","strong_default");
		}
	}
	else if(self.damageyaw < 0)
	{
		var_01 = animscripts\utility::lookupanim("death","strong_right");
	}
	else
	{
		var_01 = animscripts\utility::lookupanim("death","strong_left");
	}

	return var_01[randomint(var_01.size)];
}

//Function Number: 36
getdirectedenergydeathanim()
{
	var_00 = abs(self.damageyaw);
	if(var_00 > 135)
	{
		var_01 = "directed_energy_stand_front_default";
		if(isdefined(self.last_damage_pos))
		{
			if(self.last_damage_pos[2] < self.origin[2] + 20)
			{
				var_01 = "directed_energy_stand_front_legs";
			}
			else if(self.last_damage_pos[2] > self.origin[2] + 40)
			{
				var_01 = "directed_energy_stand_front_head";
			}
		}
	}
	else
	{
		var_01 = "directed_energy_stand_back_default";
	}

	var_02 = animscripts\utility::lookupanim("death",var_01);
	var_03 = var_02[randomint(var_02.size)];
	return var_03;
}

//Function Number: 37
getrunningforwarddeathanim()
{
	if(abs(self.damageyaw) < 45)
	{
		var_00 = animscripts\utility::lookupanim("death","running_forward_f");
		var_01 = getrandomunblockedanim(var_00);
		if(isdefined(var_01))
		{
			return var_01;
		}
	}

	var_00 = animscripts\utility::lookupanim("death","running_forward");
	var_01 = getrandomunblockedanim(var_00);
	if(isdefined(var_01))
	{
		return var_01;
	}

	return getstanddeathanim();
}

//Function Number: 38
getrandomunblockedanim(param_00)
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
		if(!isanimblocked(var_01))
		{
			return var_01;
		}

		param_00[var_03] = param_00[var_02 - 1];
		param_00[var_02 - 1] = undefined;
	}

	return undefined;
}

//Function Number: 39
removeundefined(param_00)
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

//Function Number: 40
isanimblocked(param_00)
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

//Function Number: 41
getstandpistoldeathanim()
{
	var_00 = [];
	if(abs(self.damageyaw) < 50)
	{
		var_00 = animscripts\utility::lookupanim("death","stand_pistol_forward");
	}
	else
	{
		if(abs(self.damageyaw) < 110)
		{
			var_00 = animscripts\utility::lookupanim("death","stand_pistol_front");
		}

		if(self.damagelocation == "torso_upper")
		{
			var_00 = common_scripts\utility::array_combine(animscripts\utility::lookupanim("death","stand_pistol_torso_upper"),var_00);
		}
		else if(animscripts\utility::damagelocationisany("torso_lower","left_leg_upper","left_leg_lower","right_leg_upper","right_leg_lower"))
		{
			var_00 = common_scripts\utility::array_combine(animscripts\utility::lookupanim("death","stand_pistol_torso_upper"),var_00);
		}

		if(!animscripts\utility::damagelocationisany("head","neck","helmet","left_foot","right_foot","left_hand","right_hand","gun") && randomint(2) == 0)
		{
			var_00 = common_scripts\utility::array_combine(animscripts\utility::lookupanim("death","stand_pistol_upper_body"),var_00);
		}

		if(var_00.size == 0 || animscripts\utility::damagelocationisany("torso_lower","torso_upper","neck","head","helmet","right_arm_upper","left_arm_upper"))
		{
			var_00 = common_scripts\utility::array_combine(animscripts\utility::lookupanim("death","stand_pistol_default"),var_00);
		}
	}

	return var_00;
}

//Function Number: 42
getstanddeathanim()
{
	var_00 = [];
	var_01 = [];
	if(animscripts\utility::usingsidearm())
	{
		var_00 = getstandpistoldeathanim();
	}
	else if(isdefined(self.emp) && self.emp)
	{
		var_00 = animscripts\utility::lookupanim("death","emp");
	}
	else if(isdefined(self.attacker) && self shouldplaymeleedeathanim(self.attacker))
	{
		if(self.damageyaw <= 120 || self.damageyaw > -120)
		{
			var_00 = animscripts\utility::lookupanim("death","melee_standing_front");
		}
		else if(self.damageyaw <= -60 && self.damageyaw > 60)
		{
			var_00 = animscripts\utility::lookupanim("death","melee_standing_back");
		}
		else if(self.damageyaw < 0)
		{
			var_00 = animscripts\utility::lookupanim("death","melee_standing_left");
		}
		else
		{
			var_00 = animscripts\utility::lookupanim("death","melee_standing_right");
		}
	}
	else
	{
		if(animscripts\utility::damagelocationisany("torso_lower","left_leg_upper","left_leg_lower","right_leg_lower","right_leg_lower"))
		{
			var_00 = animscripts\utility::lookupanim("death","stand_lower_body");
			var_01 = animscripts\utility::lookupanim("death","stand_lower_body_extended");
		}
		else if(animscripts\utility::damagelocationisany("head","helmet"))
		{
			var_00 = animscripts\utility::lookupanim("death","stand_head");
		}
		else if(animscripts\utility::damagelocationisany("neck"))
		{
			var_00 = animscripts\utility::lookupanim("death","stand_neck");
		}
		else if(animscripts\utility::damagelocationisany("torso_upper","left_arm_upper"))
		{
			var_00 = animscripts\utility::lookupanim("death","stand_left_shoulder");
		}

		if(animscripts\utility::damagelocationisany("torso_upper"))
		{
			var_00 = common_scripts\utility::array_combine(var_00,animscripts\utility::lookupanim("death","stand_torso_upper"));
			var_01 = common_scripts\utility::array_combine(var_01,animscripts\utility::lookupanim("death","stand_torso_upper_extended"));
		}

		if(self.damageyaw > 135 || self.damageyaw <= -135)
		{
			if(animscripts\utility::damagelocationisany("neck","head","helmet"))
			{
				var_00 = common_scripts\utility::array_combine(var_00,animscripts\utility::lookupanim("death","stand_front_torso"));
				var_01 = common_scripts\utility::array_combine(var_01,animscripts\utility::lookupanim("death","stand_front_torso_extended"));
			}

			if(animscripts\utility::damagelocationisany("torso_upper"))
			{
				var_00 = common_scripts\utility::array_combine(var_00,animscripts\utility::lookupanim("death","stand_front_torso"));
				var_01 = common_scripts\utility::array_combine(var_01,animscripts\utility::lookupanim("death","stand_front_torso_extended"));
			}
		}
		else if(self.damageyaw > -45 && self.damageyaw <= 45)
		{
			var_00 = common_scripts\utility::array_combine(var_00,animscripts\utility::lookupanim("death","stand_back"));
		}

		var_02 = var_00.size > 0;
		if(!var_02 || randomint(100) < 15)
		{
			var_00 = common_scripts\utility::array_combine(var_00,animscripts\utility::lookupanim("death","stand_default"));
		}

		if(randomint(100) < 10 && firingdeathallowed())
		{
			var_00 = common_scripts\utility::array_combine(var_00,animscripts\utility::lookupanim("death","stand_default_firing"));
			var_00 = removeundefined(var_00);
		}
	}

	if(var_00.size == 0)
	{
		var_00[var_00.size] = animscripts\utility::lookupanim("death","stand_backup_default");
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

//Function Number: 43
getcrouchdeathanim()
{
	var_00 = [];
	if(isdefined(self.attacker) && self shouldplaymeleedeathanim(self.attacker))
	{
		if(self.damageyaw <= 120 || self.damageyaw > -120)
		{
			var_00 = animscripts\utility::lookupanim("death","melee_crouching_front");
		}
		else if(self.damageyaw <= -60 && self.damageyaw > 60)
		{
			var_00 = animscripts\utility::lookupanim("death","melee_crouching_back");
		}
		else if(self.damageyaw < 0)
		{
			var_00 = animscripts\utility::lookupanim("death","melee_crouching_left");
		}
		else
		{
			var_00 = animscripts\utility::lookupanim("death","melee_crouching_right");
		}
	}
	else
	{
		if(animscripts\utility::damagelocationisany("head","neck"))
		{
			var_00 = animscripts\utility::lookupanim("death","crouch_head");
		}

		if(animscripts\utility::damagelocationisany("torso_upper","torso_lower","left_arm_upper","right_arm_upper","neck"))
		{
			var_00 = common_scripts\utility::array_combine(var_00,animscripts\utility::lookupanim("death","crouch_torso"));
		}

		if(var_00.size < 2)
		{
			var_00 = common_scripts\utility::array_combine(var_00,animscripts\utility::lookupanim("death","crouch_default1"));
		}

		if(var_00.size < 2)
		{
			var_00 = common_scripts\utility::array_combine(var_00,animscripts\utility::lookupanim("death","crouch_default2"));
		}
	}

	return var_00[randomint(var_00.size)];
}

//Function Number: 44
getpronedeathanim()
{
	return %prone_death_quickdeath;
}

//Function Number: 45
getbackdeathanim()
{
	var_00 = animscripts\utility::array(%dying_back_death_v1,%dying_back_death_v2,%dying_back_death_v3,%dying_back_death_v4);
	return var_00[randomint(var_00.size)];
}

//Function Number: 46
firingdeathallowed()
{
	if(!isdefined(self.weapon) || !animscripts\utility::usingriflelikeweapon() || !weaponisauto(self.weapon) || self.diequietly || animscripts\utility::usingrocketlauncher())
	{
		return 0;
	}

	if(self.a.weaponpos["right"] == "none")
	{
		return 0;
	}

	return 1;
}

//Function Number: 47
tryadddeathanim(param_00)
{
	return param_00;
}

//Function Number: 48
tryaddfiringdeathanim(param_00)
{
	return param_00;
}

//Function Number: 49
playexplodedeathanim()
{
	if(isdefined(self.juggernaut) || isdefined(self.mech))
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
		if(self.damageyaw > 135 || self.damageyaw <= -135)
		{
			var_00[var_00.size] = tryadddeathanim(%death_explosion_stand_b_v1);
			var_00[var_00.size] = tryadddeathanim(%death_explosion_stand_b_v2);
			var_00[var_00.size] = tryadddeathanim(%death_explosion_stand_b_v3);
			var_00[var_00.size] = tryadddeathanim(%death_explosion_stand_b_v4);
		}
		else if(self.damageyaw > 45 && self.damageyaw <= 135)
		{
			var_00[var_00.size] = tryadddeathanim(%death_explosion_stand_l_v1);
			var_00[var_00.size] = tryadddeathanim(%death_explosion_stand_l_v2);
			var_00[var_00.size] = tryadddeathanim(%death_explosion_stand_l_v3);
		}
		else if(self.damageyaw > -45 && self.damageyaw <= 45)
		{
			var_00[var_00.size] = tryadddeathanim(%death_explosion_stand_f_v1);
			var_00[var_00.size] = tryadddeathanim(%death_explosion_stand_f_v2);
			var_00[var_00.size] = tryadddeathanim(%death_explosion_stand_f_v3);
			var_00[var_00.size] = tryadddeathanim(%death_explosion_stand_f_v4);
		}
		else
		{
			var_00[var_00.size] = tryadddeathanim(%death_explosion_stand_r_v1);
			var_00[var_00.size] = tryadddeathanim(%death_explosion_stand_r_v2);
		}
	}
	else if(self.damageyaw > 135 || self.damageyaw <= -135)
	{
		var_00[var_00.size] = tryadddeathanim(%death_explosion_run_b_v1);
		var_00[var_00.size] = tryadddeathanim(%death_explosion_run_b_v2);
	}
	else if(self.damageyaw > 45 && self.damageyaw <= 135)
	{
		var_00[var_00.size] = tryadddeathanim(%death_explosion_run_l_v1);
		var_00[var_00.size] = tryadddeathanim(%death_explosion_run_l_v2);
	}
	else if(self.damageyaw > -45 && self.damageyaw <= 45)
	{
		var_00[var_00.size] = tryadddeathanim(%death_explosion_run_f_v1);
		var_00[var_00.size] = tryadddeathanim(%death_explosion_run_f_v2);
		var_00[var_00.size] = tryadddeathanim(%death_explosion_run_f_v3);
		var_00[var_00.size] = tryadddeathanim(%death_explosion_run_f_v4);
	}
	else
	{
		var_00[var_00.size] = tryadddeathanim(%death_explosion_run_r_v1);
		var_00[var_00.size] = tryadddeathanim(%death_explosion_run_r_v2);
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
	playdeathanim(var_01,0);
	return 1;
}