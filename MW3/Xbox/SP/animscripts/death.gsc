/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\death.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 31
 * Decompile Time: 556 ms
 * Timestamp: 10/27/2023 2:30:20 AM
*******************************************************************/

//Function Number: 1
main()
{
	self endon("killanimscript");
	self stopsoundchannel("voice");
	var_00 = 0.3;
	self clearanim(%scripted_talking,var_00);
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

	animscripts/utility::initialize("death");
	removeselffrom_squadlastseenenemypos(self.origin);
	level.numdeathsuntilcrawlingpain--;
	level.numdeathsuntilcornergrenadedeath--;
	if(isdefined(self.ragdoll_immediate) || self.forceragdollimmediate)
	{
		doimmediateragdolldeath();
	}

	if(isdefined(self.var_93B))
	{
		func_0941(self.var_93B);
		if(isdefined(self.deathanimscript))
		{
			self [[ self.deathanimscript ]]();
		}

		return;
	}

	var_02 = animscripts/pain::wasdamagedbyexplosive();
	if(self.damagelocation == "helmet" || self.damagelocation == "head")
	{
		helmetpop();
	}
	else if(var_02 && randomint(3) == 0)
	{
		helmetpop();
	}

	self clearanim(%root,0.3);
	if(!animscripts/utility::damagelocationisany("head","helmet"))
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
	func_0941(var_03);
}

//Function Number: 2
doimmediateragdolldeath()
{
	animscripts/shared::dropallaiweapons();
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
	wait 0.05;
}

//Function Number: 3
func_0941(param_00)
{
	if(!animhasnotetrack(param_00,"dropgun") && !animhasnotetrack(param_00,"fire_spray"))
	{
		animscripts/shared::dropallaiweapons();
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
	else if(isdefined(self.ragdolltime))
	{
		thread waitforragdoll(self.ragdolltime);
	}
	else if(!animhasnotetrack(param_00,"start_ragdoll"))
	{
		thread waitforragdoll(getanimlength(param_00) * 0.35);
	}

	if(!isdefined(self.skipdeathanim))
	{
		thread playdeathfx();
	}

	animscripts/shared::donotetracks("deathanim");
	animscripts/shared::dropallaiweapons();
}

//Function Number: 4
waitforragdoll(param_00)
{
	wait param_00;
	if(isdefined(self))
	{
		animscripts/shared::dropallaiweapons();
	}

	if(isdefined(self) && !isdefined(self.noragdoll))
	{
		self startragdoll();
	}
}

//Function Number: 5
playdeathfx()
{
	self endon("killanimscript");
	if(self.stairsstate != "none")
	{
		return;
	}

	wait 2;
	play_blood_pool();
}

//Function Number: 6
play_blood_pool(param_00,param_01)
{
	if(!isdefined(self))
	{
		return;
	}

	if(isdefined(self.var_AB6))
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
	if(self.a.special == "none")
	{
		return 0;
	}

	switch(self.a.special)
	{
		case "cover_right":
			if(self.a.var_911 == "stand")
			{
				var_00 = [];
				func_0AB8(var_41);
			}
			else
			{
				var_00 = [];
				if(animscripts/utility::damagelocationisany("head","neck"))
				{
				}
				else
				{
				}
	
				func_0AB8(var_41);
			}
	
			return 1;
	var_41[1]
	%cornercrr_alert_death_back
	var_41[0]
	%cornercrr_alert_death_slideout
	var_41[0]
	%cornercrr_alert_death_slideout
	var_41[1]
	%corner_standr_deathb
	var_41[0]
	%corner_standr_deatha
			break;

		case "cover_left":
			if(self.a.var_911 == "stand")
			{
				var_00 = [];
				func_0AB8(var_41);
			}
			else
			{
				var_00 = [];
				func_0AB8(var_41);
			}
	
			return 1;
	var_41[1]
	%cornercrl_death_back
	var_41[0]
	%cornercrl_death_side
	var_41[1]
	%corner_standl_deathb
	var_41[0]
	%corner_standl_deatha
			break;

		case "cover_stand":
			var_00 = [];
			func_0AB8(var_41);
			return 1;
	var_41[1]
	%coverstand_death_right
	var_41[0]
	%coverstand_death_left
			break;

		case "cover_crouch":
			var_00 = [];
			if(animscripts/utility::damagelocationisany("head","neck") && self.damageyaw > 135 || self.damageyaw <= -45)
			{
			}
	
			if(self.damageyaw > -45 && self.damageyaw <= 45)
			{
			}
	
			func_0AB8(var_41);
			return 1;
	var_41[var_41.size]
	%covercrouch_death_2
	var_41[var_41.size]
	%covercrouch_death_3
	var_41[var_41.size]
	%covercrouch_death_1
			break;

		case "saw":
			if(self.a.var_911 == "stand")
			{
				func_0AB8(animscripts/utility::array(%saw_gunner_death));
			}
			else if(self.a.var_911 == "crouch")
			{
				func_0AB8(animscripts/utility::array(%saw_gunner_lowwall_death));
			}
			else
			{
				func_0AB8(animscripts/utility::array(%saw_gunner_prone_death));
			}
			return 1;

		case "dying_crawl":
			if(isdefined(self.a.onback) && self.a.var_911 == "crouch")
			{
				var_00 = animscripts/utility::array(%dying_back_death_v2,%dying_back_death_v3,%dying_back_death_v4);
				func_0AB8(var_41);
			}
			else
			{
				var_00 = animscripts/utility::array(%dying_crawl_death_v1,%dying_crawl_death_v2);
				func_0AB8(var_41);
			}
			return 1;
	}

	return 0;
}

//Function Number: 8
func_0AB8(param_00)
{
	var_01 = param_00[randomint(param_00.size)];
	func_0941(var_01);
	if(isdefined(self.deathanimscript))
	{
		self [[ self.deathanimscript ]]();
	}
}

//Function Number: 9
playdeathsound()
{
	animscripts/face::saygenericdialogue("death");
}

//Function Number: 10
print3dfortime(param_00,param_01,param_02)
{
	var_03 = param_02 * 20;
	for(var_04 = 0;var_04 < var_03;var_04++)
	{
		wait 0.05;
	}
}

//Function Number: 11
helmetpop()
{
	if(!isdefined(self))
	{
		return;
	}

	if(!isdefined(self.var_ABA))
	{
		return;
	}

	var_00 = getpartname(self.var_ABA,0);
	var_01 = spawn("script_model",self.origin + (0,0,64));
	var_01 setmodel(self.var_ABA);
	var_01.origin = self gettagorigin(var_00);
	var_01.angles = self gettagangles(var_00);
	var_01 thread helmetlaunch(self.damagedir);
	var_02 = self.var_ABA;
	self.var_ABA = undefined;
	wait 0.05;
	if(!isdefined(self))
	{
		return;
	}

	self detach(var_02,"");
}

//Function Number: 12
helmetlaunch(param_00)
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
removeselffrom_squadlastseenenemypos(param_00)
{
	for(var_01 = 0;var_01 < level.squadindex.size;var_01++)
	{
		level.squadindex[var_01] clearsightposnear(param_00);
	}
}

//Function Number: 14
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

//Function Number: 15
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

	return 1;
}

//Function Number: 16
shoulddostrongbulletdamage(param_00,param_01,param_02,param_03)
{
	if(isdefined(self.a.doinglongdeath))
	{
		return 0;
	}

	if(self.a.var_911 == "prone" || isdefined(self.a.onback))
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

	if(self.a.movement == "run" && !isattackerwithindist(param_03,275))
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

	if(animscripts/utility::isshotgun(param_00) && isattackerwithindist(param_03,512))
	{
		return 1;
	}

	if(isdeserteagle(param_00) && isattackerwithindist(param_03,425))
	{
		return 1;
	}

	return 0;
}

//Function Number: 17
isdeserteagle(param_00)
{
	if(param_00 == "deserteagle")
	{
		return 1;
	}

	return 0;
}

//Function Number: 18
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

//Function Number: 19
getdeathanim()
{
	if(shoulddostrongbulletdamage(self.damageweapon,self.damagemod,self.damagetaken,self.attacker))
	{
		var_00 = func_0AC4();
		if(isdefined(var_00))
		{
			return var_00;
		}
	}

	if(isdefined(self.a.onback))
	{
		if(self.a.var_911 == "crouch")
		{
			return getbackdeathanim();
		}
		else
		{
			animscripts/notetracks::stoponback();
		}
	}

	if(self.a.var_911 == "stand")
	{
		if(shoulddorunningforwarddeath())
		{
			return getrunningforwarddeathanim();
		}

		return func_0AC8();
	}

	if(self.a.var_911 == "crouch")
	{
		return func_0AC9();
	}

	if(self.a.var_911 == "prone")
	{
		return getpronedeathanim();
	}
}

//Function Number: 20
func_0AC4()
{
	var_00 = abs(self.damageyaw);
	if(var_00 < 45)
	{
		return;
	}

	if(var_00 > 150)
	{
		if(animscripts/utility::damagelocationisany("left_leg_upper","left_leg_lower","right_leg_upper","right_leg_lower","left_foot","right_foot"))
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
	else if(self.damageyaw < 0)
	{
		var_01 = animscripts/utility::array(%death_shotgun_spinl,%death_stand_sniper_spin1,%death_stand_sniper_chest1,%death_stand_sniper_chest2);
	}
	else
	{
		var_01 = animscripts/utility::array(%death_shotgun_spinr,%death_stand_sniper_spin2,%death_stand_sniper_chest1,%death_stand_sniper_chest2);
	}

	return var_41[randomint(var_41.size)];
}

//Function Number: 21
getrunningforwarddeathanim()
{
	var_00 = [];
	var_41 = animscripts/pain::removeblockedanims(var_41);
	if(!var_41.size)
	{
		return func_0AC8();
	}

	return var_41[randomint(var_41.size)];
}

//Function Number: 22
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

//Function Number: 23
getstandpistoldeathanim()
{
	var_00 = [];
	if(abs(self.damageyaw) < 50)
	{
	}
	else
	{
		if(abs(self.damageyaw) < 110)
		{
		}

		if(animscripts/utility::damagelocationisany("torso_lower","torso_upper","left_leg_upper","left_leg_lower","right_leg_upper","right_leg_lower"))
		{
			if(!animscripts/utility::damagelocationisany("torso_upper"))
			{
			}
		}

		if(!animscripts/utility::damagelocationisany("head","neck","helmet","left_foot","right_foot","left_hand","right_hand","gun") && randomint(2) == 0)
		{
		}

		if(var_41.size == 0 || animscripts/utility::damagelocationisany("torso_lower","torso_upper","neck","head","helmet","right_arm_upper","left_arm_upper"))
		{
		}
	}

	return var_41;
}

//Function Number: 24
func_0AC8()
{
	var_00 = [];
	var_01 = [];
	if(animscripts/utility::usingsidearm())
	{
		var_00 = getstandpistoldeathanim();
	}
	else
	{
		if(animscripts/utility::damagelocationisany("torso_lower","left_leg_upper","left_leg_lower","right_leg_lower","right_leg_lower"))
		{
			var_00[var_00.size] = tryadddeathanim(%exposed_death_groin);
			var_00[var_00.size] = tryadddeathanim(%stand_death_leg);
		}

		if(animscripts/utility::damagelocationisany("head","helmet"))
		{
			var_01[var_01.size] = tryadddeathanim(%exposed_death_headshot);
			var_01[var_01.size] = tryadddeathanim(%exposed_death_flop);
		}

		if(animscripts/utility::damagelocationisany("neck"))
		{
			var_01[var_01.size] = tryadddeathanim(%exposed_death_neckgrab);
		}

		if(animscripts/utility::damagelocationisany("torso_upper","left_arm_upper"))
		{
			var_01[var_01.size] = tryadddeathanim(%exposed_death_twist);
			var_01[var_01.size] = tryadddeathanim(%stand_death_shoulder_spin);
			var_01[var_01.size] = tryadddeathanim(%stand_death_shoulderback);
		}

		if(animscripts/utility::damagelocationisany("torso_upper"))
		{
			var_01[var_01.size] = tryadddeathanim(%stand_death_tumbleforward);
			var_01[var_01.size] = tryadddeathanim(%stand_death_stumbleforward);
		}

		if(self.damageyaw > 135 || self.damageyaw <= -135)
		{
			if(animscripts/utility::damagelocationisany("neck","head","helmet"))
			{
				var_01[var_01.size] = tryadddeathanim(%stand_death_face);
				var_01[var_01.size] = tryadddeathanim(%stand_death_headshot_slowfall);
			}

			if(animscripts/utility::damagelocationisany("torso_upper"))
			{
				var_01[var_01.size] = tryadddeathanim(%stand_death_tumbleback);
			}
		}
		else if(self.damageyaw > -45 && self.damageyaw <= 45)
		{
			var_01[var_01.size] = tryadddeathanim(%exposed_death_falltoknees);
			var_01[var_01.size] = tryadddeathanim(%exposed_death_falltoknees_02);
		}

		var_02 = var_01.size > 0;
		if(!var_02 || randomint(100) < 15)
		{
			var_01[var_01.size] = tryadddeathanim(%exposed_death_02);
			var_01[var_01.size] = tryadddeathanim(%exposed_death_nerve);
		}

		if(randomint(100) < 10 && firingdeathallowed())
		{
			var_01[var_01.size] = tryaddfiringdeathanim(%exposed_death_firing_02);
			var_01[var_01.size] = tryaddfiringdeathanim(%exposed_death_firing);
			var_01 = removeundefined(var_01);
		}
	}

	if(var_01.size == 0)
	{
		var_01[var_01.size] = %exposed_death;
	}

	if(!self.a.disablelongdeath && self.stairsstate == "none" && !isdefined(self.a.painonstairs))
	{
		var_03 = randomint(var_01.size + var_41.size);
		if(var_03 < var_01.size)
		{
			return var_01[var_03];
		}
		else
		{
			return var_41[var_03 - var_01.size];
		}
	}

	return var_01[randomint(var_01.size)];
}

//Function Number: 25
func_0AC9()
{
	var_00 = [];
	if(animscripts/utility::damagelocationisany("head","neck"))
	{
	}

	if(animscripts/utility::damagelocationisany("torso_upper","torso_lower","left_arm_upper","right_arm_upper","neck"))
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

//Function Number: 26
getpronedeathanim()
{
	if(isdefined(self.a.var_ACB))
	{
		return %prone_death_quickdeath;
	}

	return %dying_crawl_death_v1;
}

//Function Number: 27
getbackdeathanim()
{
	var_00 = animscripts/utility::array(%dying_back_death_v1,%dying_back_death_v2,%dying_back_death_v3,%dying_back_death_v4);
	return var_00[randomint(var_00.size)];
}

//Function Number: 28
firingdeathallowed()
{
	if(!isdefined(self.weapon) || !animscripts/utility::usingriflelikeweapon() || !weaponisauto(self.weapon) || self.diequietly)
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
tryadddeathanim(param_00)
{
	return param_00;
}

//Function Number: 30
tryaddfiringdeathanim(param_00)
{
	return param_00;
}

//Function Number: 31
playexplodedeathanim()
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
		if(self.damageyaw > 135 || self.damageyaw <= -135)
		{
		}
		else if(self.damageyaw > 45 && self.damageyaw <= 135)
		{
		}
		else if(self.damageyaw > -45 && self.damageyaw <= 45)
		{
		}
		else
		{
		}
	}
	else if(self.damageyaw > 135 || self.damageyaw <= -135)
	{
	}
	else if(self.damageyaw > 45 && self.damageyaw <= 135)
	{
	}
	else if(self.damageyaw > -45 && self.damageyaw <= 45)
	{
	}
	else
	{
	}

	var_01 = var_41[randomint(var_41.size)];
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
	func_0941(var_01);
	return 1;
}