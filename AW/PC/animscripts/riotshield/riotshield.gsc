/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: riotshield\riotshield.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 28
 * Decompile Time: 333 ms
 * Timestamp: 4/22/2024 1:58:54 AM
*******************************************************************/

//Function Number: 1
init_riotshield_ai_anims()
{
	level.notetracks["detach shield"] = ::notetrackdetachshield;
	animscripts\init_move_transitions::init_move_transition_arrays();
	var_00 = [];
	var_00["cover_trans"]["riotshield"][1] = %riotshield_run_approach_1;
	var_00["cover_trans"]["riotshield"][2] = %riotshield_run_approach_2;
	var_00["cover_trans"]["riotshield"][3] = %riotshield_run_approach_3;
	var_00["cover_trans"]["riotshield"][4] = %riotshield_run_approach_4;
	var_00["cover_trans"]["riotshield"][6] = %riotshield_run_approach_6;
	var_00["cover_trans"]["riotshield"][7] = undefined;
	var_00["cover_trans"]["riotshield"][8] = %riotshield_walk2crouch_8;
	var_00["cover_trans"]["riotshield"][9] = undefined;
	var_00["cover_trans"]["riotshield_crouch"][1] = %riotshield_walk_approach_1;
	var_00["cover_trans"]["riotshield_crouch"][2] = %riotshield_walk_approach_2;
	var_00["cover_trans"]["riotshield_crouch"][3] = %riotshield_walk_approach_3;
	var_00["cover_trans"]["riotshield_crouch"][4] = %riotshield_walk_approach_4;
	var_00["cover_trans"]["riotshield_crouch"][6] = %riotshield_walk_approach_6;
	var_00["cover_trans"]["riotshield_crouch"][7] = undefined;
	var_00["cover_trans"]["riotshield_crouch"][8] = %riotshield_walk2crouch_8;
	var_00["cover_trans"]["riotshield_crouch"][9] = undefined;
	var_01 = [];
	var_01[0] = "riotshield";
	var_01[1] = "riotshield_crouch";
	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		var_03 = var_01[var_02];
		for(var_04 = 1;var_04 <= 9;var_04++)
		{
			if(var_04 == 5)
			{
				continue;
			}

			if(isdefined(var_00["cover_trans"][var_03][var_04]))
			{
				var_00["cover_trans_dist"][var_03][var_04] = getmovedelta(var_00["cover_trans"][var_03][var_04],0,1);
			}
		}
	}

	var_00["cover_trans_angles"]["riotshield_crouch"][1] = 45;
	var_00["cover_trans_angles"]["riotshield_crouch"][2] = 0;
	var_00["cover_trans_angles"]["riotshield_crouch"][3] = -45;
	var_00["cover_trans_angles"]["riotshield_crouch"][4] = 90;
	var_00["cover_trans_angles"]["riotshield_crouch"][6] = -90;
	var_00["cover_trans_angles"]["riotshield_crouch"][8] = 180;
	var_00["cover_trans_angles"]["riotshield"][1] = 45;
	var_00["cover_trans_angles"]["riotshield"][2] = 0;
	var_00["cover_trans_angles"]["riotshield"][3] = -45;
	var_00["cover_trans_angles"]["riotshield"][4] = 90;
	var_00["cover_trans_angles"]["riotshield"][6] = -90;
	var_00["cover_trans_angles"]["riotshield"][8] = 180;
	animscripts\animset::registerarchetype("riotshield",var_00,0);
	level.arrivalendstance["riotshield"] = "crouch";
	level.arrivalendstance["riotshield_crouch"] = "crouch";
	animscripts\combat_utility::addgrenadethrowanimoffset(%riotshield_crouch_grenade_toss,(-3.20014,1.7098,55.6886));
}

//Function Number: 2
notetrackdetachshield(param_00,param_01)
{
	animscripts\shared::dropaiweapon(self.secondaryweapon);
	self.secondaryweapon = "none";
	if(isalive(self))
	{
		riotshield_turn_into_regular_ai();
	}
}

//Function Number: 3
riotshield_approach_type()
{
	if(self.a.pose == "crouch")
	{
		return "riotshield_crouch";
	}

	return "riotshield";
}

//Function Number: 4
riotshield_approach_conditions(param_00)
{
	return 1;
}

//Function Number: 5
init_riotshield_ai()
{
	animscripts\shared::placeweaponon(self.secondaryweapon,"left",0);
	self.animarchetype = "riotshield";
	self initriotshieldhealth(self.secondaryweapon);
	self.shieldmodelvariant = 0;
	thread riotshield_damaged();
	self.subclass = "riotshield";
	self.approachtypefunc = ::riotshield_approach_type;
	self.approachconditioncheckfunc = ::riotshield_approach_conditions;
	self.faceenemyarrival = 1;
	self.disablecoverarrivalsonly = 1;
	self.pathrandompercent = 0;
	self.interval = 0;
	self.disabledoorbehavior = 1;
	self.no_pistol_switch = 1;
	self.dontshootwhilemoving = 1;
	self.disablebulletwhizbyreaction = 1;
	self.disablefriendlyfirereaction = 1;
	self.neversprintforvariation = 1;
	self.combatmode = "no_cover";
	self.fixednode = 0;
	self.maxfaceenemydist = 1500;
	self.nomeleechargedelay = 1;
	self.meleechargedistsq = squared(256);
	self.meleeplayerwhilemoving = 1;
	self.usemuzzlesideoffset = 1;
	if(level.gameskill < 1)
	{
		self.shieldbulletblocklimit = randomintrange(4,8);
	}
	else
	{
		self.shieldbulletblocklimit = randomintrange(8,12);
	}

	self.shieldbulletblockcount = 0;
	self.shieldbulletblocktime = 0;
	self.walkdist = 500;
	self.walkdistfacingmotion = 500;
	self.grenadeawareness = 1;
	self.frontshieldanglecos = 0.5;
	self.nogrenadereturnthrow = 1;
	self.a.grenadethrowpose = "crouch";
	self.minexposedgrenadedist = 400;
	self.ignoresuppression = 1;
	self.specialmelee_standard = ::riotshield_melee_standard;
	self.specialmeleechooseaction = ::riotshield_melee_aivsai;
	maps\_utility::disable_turnanims();
	maps\_utility::disable_surprise();
	maps\_utility::disable_cqbwalk();
	init_riotshield_animsets();
	if(level.gameskill < 1)
	{
		self.bullet_resistance = 30;
	}
	else
	{
		self.bullet_resistance = 40;
	}

	maps\_utility::add_damage_function(::maps\_spawner::bullet_resistance);
	maps\_utility::add_damage_function(::animscripts\pain::additive_pain);
}

//Function Number: 6
riotshield_charge()
{
	if(!animscripts\melee::melee_standard_updateandvalidatetarget())
	{
		return 0;
	}

	var_00 = getmovedelta(%riotshield_basha_attack,0,1);
	var_01 = lengthsquared(var_00);
	if(distancesquared(self.origin,self.melee.target.origin) < var_01)
	{
		return 1;
	}

	animscripts\melee::melee_playchargesound();
	var_02 = 0.1;
	var_03 = 1;
	for(;;)
	{
		if(!animscripts\melee::melee_standard_updateandvalidatetarget())
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
		animscripts\notetracks::donotetracksfortime(var_02,"chargeanim");
		var_04 = distancesquared(self.origin,self.melee.target.origin);
		if(var_04 < var_01)
		{
			break;
		}

		if(gettime() >= self.melee.giveuptime)
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 7
riotshield_melee_standard()
{
	self animmode("zonly_physics");
	animscripts\melee::melee_standard_resetgiveuptime();
	for(;;)
	{
		if(!riotshield_charge())
		{
			self.nextmeleechargetime = gettime() + 1500;
			self.nextmeleechargetarget = self.melee.target;
			break;
		}

		animscripts\battlechatter_ai::evaluatemeleeevent();
		self orientmode("face point",self.melee.target.origin);
		self setflaggedanimknoballrestart("meleeanim",%riotshield_bash_vs_player,%body,1,0.2,1);
		self.melee.inprogress = 1;
		if(!animscripts\melee::melee_standard_playattackloop())
		{
			animscripts\melee::melee_standard_delaystandardcharge(self.melee.target);
			break;
		}

		self animmode("none");
	}

	self animmode("none");
}

//Function Number: 8
riotshield_melee_aivsai()
{
	var_00 = self.melee.target;
	if(self.subclass == "riotshield" && var_00.subclass == "riotshield")
	{
		return 0;
	}

	animscripts\melee::melee_decide_winner();
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
				var_00.melee.surviveanimname = %riotshield_basha_defend_survive;
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
	self.melee.startangles = (var_00.angles[0],angleclamp180(var_00.angles[1] + 180),var_00.angles[2]);
	self.lockorientation = 0;
	var_00.lockorientation = 0;
	return animscripts\melee::melee_updateandvalidatestartpos();
}

//Function Number: 9
riotshield_startmovetransition()
{
	if(isdefined(self.disableexits))
	{
		return;
	}

	self orientmode("face angle",self.angles[1]);
	self animmode("zonly_physics",0);
	if(self.a.pose == "crouch")
	{
		if(isdefined(self.sprint) || isdefined(self.fastwalk))
		{
			var_00 = %riotshield_crouch2stand;
		}
		else
		{
			var_00 = %riotshield_crouch2walk;
		}

		var_01 = randomfloatrange(0.9,1.1);
		if(isdefined(self.copgroup))
		{
			var_01 = 2.5;
		}

		self setflaggedanimknoballrestart("startmove",var_00,%body,1,0.1,var_01);
		animscripts\shared::donotetracks("startmove");
		self clearanim(%riotshield_crouch2walk,0.5);
	}

	if(isdefined(self.sprint) || isdefined(self.fastwalk))
	{
		self allowedstances("stand","crouch");
		self.a.pose = "stand";
	}

	self orientmode("face default");
	self animmode("normal",0);
	thread riotshield_bullet_hit_shield();
}

//Function Number: 10
riotshield_endmovetransition()
{
	if(self.prevscript == "move" && self.a.pose == "crouch")
	{
		self clearanim(%animscript_root,0.2);
		var_00 = randomfloatrange(0.9,1.1);
		if(isdefined(self.copgroup))
		{
			var_00 = 2.5;
		}

		self animmode("zonly_physics");
		self setflaggedanimknoballrestart("endmove",%riotshield_walk2crouch_8,%body,1,0.2,var_00);
		animscripts\shared::donotetracks("endmove");
		self animmode("normal");
	}

	self allowedstances("crouch");
}

//Function Number: 11
riotshield_startcombat()
{
	riotshield_endmovetransition();
	self.pushable = 0;
	thread riotshield_bullet_hit_shield();
}

//Function Number: 12
riotshield_bullet_hit_shield()
{
	self endon("killanimscript");
	for(;;)
	{
		self waittill("bullet_hitshield");
		var_00 = gettime();
		if(var_00 - self.shieldbulletblocktime > 500)
		{
			self.shieldbulletblockcount = 0;
		}
		else
		{
			self.shieldbulletblockcount++;
		}

		self.shieldbulletblocktime = var_00;
		if(self.shieldbulletblockcount > self.shieldbulletblocklimit)
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
		thread riotshield_bullet_hit_shield_clear();
	}
}

//Function Number: 13
riotshield_bullet_hit_shield_clear()
{
	self endon("killanimscript");
	self endon("new_hit_react");
	self waittillmatch("end","hitreact");
	self clearanim(%riotshield_react,0.1);
}

//Function Number: 14
riotshield_grenadecower()
{
	if(self.a.pose == "stand")
	{
		self clearanim(%animscript_root,0.2);
		self setflaggedanimknoballrestart("trans",%riotshield_walk2crouch_8,%body,1,0.2,1.2);
		animscripts\shared::donotetracks("trans");
	}

	if(isdefined(self.grenade))
	{
		var_00 = 1;
		var_01 = self.grenade.origin - self.origin;
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
			if(!isdefined(self.turnthreshold))
			{
				self.turnthreshold = 55;
			}

			while(abs(var_03) > self.turnthreshold)
			{
				if(!isdefined(self.a.array))
				{
					animscripts\combat::setup_anim_array();
				}

				if(!animscripts\combat::turntofacerelativeyaw(var_03))
				{
					break;
				}

				var_03 = angleclamp180(self.angles[1] - vectortoyaw(var_01));
			}
		}
	}

	self setanimknoball(%riotshield_crouch_aim_5,%body,1,0.2,1);
	self setflaggedanimknoballrestart("grenadecower",%riotshield_crouch_idle_add,%add_idle,1,0.2,self.animplaybackrate);
	animscripts\shared::donotetracks("grenadecower");
}

//Function Number: 15
riotshield_flashbang()
{
	self notify("flashed");
	if(!isdefined(self.a.onback))
	{
		var_00 = randomfloatrange(0.9,1.1);
		self.frontshieldanglecos = 1;
		var_01 = [];
		var_01[0] = %riotshield_crouch_grenade_flash1;
		var_01[1] = %riotshield_crouch_grenade_flash2;
		var_01[2] = %riotshield_crouch_grenade_flash3;
		var_01[3] = %riotshield_crouch_grenade_flash4;
		var_02 = var_01[randomint(var_01.size)];
		self setflaggedanimknoballrestart("flashanim",var_02,%body,1,0.1,var_00);
		self.minpaindamage = 1000;
		animscripts\shared::donotetracks("flashanim");
	}
	else
	{
		wait(0.1);
	}

	self.minpaindamage = 0;
	if(isdefined(self.subclass) && self.subclass == "riotshield")
	{
		self.frontshieldanglecos = 0.5;
	}
}

//Function Number: 16
riotshield_pain()
{
	self.a.pose = "crouch";
	if(animscripts\utility::usingsidearm())
	{
		maps\_utility::forceuseweapon(self.primaryweapon,"primary");
	}

	if(!isdefined(self.a.onback))
	{
		var_00 = randomfloatrange(0.8,1.15);
		self.frontshieldanglecos = 1;
		if((self.damageyaw < -120 || self.damageyaw > 120) && isexplosivedamagemod(self.damagemod))
		{
			var_01 = [];
			var_01[0] = %riotshield_crouch_grenade_blowback;
			var_01[1] = %riotshield_crouch_grenade_blowbackl;
			var_01[2] = %riotshield_crouch_grenade_blowbackr;
			var_02 = var_01[randomint(var_01.size)];
			self setflaggedanimknoballrestart("painanim",var_02,%body,1,0.2,var_00);
			self.minpaindamage = 1000;
		}
		else
		{
			self setflaggedanimknoballrestart("painanim",%riotshield_crouch_pain,%body,1,0.2,var_00);
		}

		animscripts\shared::donotetracks("painanim");
	}
	else
	{
		wait(0.1);
	}

	self.minpaindamage = 0;
	if(isdefined(self.subclass) && self.subclass == "riotshield")
	{
		self.frontshieldanglecos = 0.5;
	}
}

//Function Number: 17
riotshield_death()
{
	if(isdefined(self.a.onback) && self.a.pose == "crouch")
	{
		var_00 = [];
		var_00[0] = %dying_back_death_v2;
		var_00[1] = %dying_back_death_v3;
		var_00[2] = %dying_back_death_v4;
		var_01 = var_00[randomint(var_00.size)];
		animscripts\death::playdeathanim(var_01);
		return 1;
	}

	if(self.prevscript == "pain" || self.prevscript == "flashed")
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

		animscripts\death::playdeathanim(var_02);
		return 1;
	}

	self.a.pose = "crouch";
	return 0;
}

//Function Number: 18
init_riotshield_animsets()
{
	var_00 = [];
	var_00["sprint"] = %riotshield_sprint;
	var_00["prone"] = %prone_crawl;
	var_00["straight"] = %riotshield_run_f;
	var_00["move_f"] = %riotshield_run_f;
	var_00["move_l"] = %riotshield_run_l;
	var_00["move_r"] = %riotshield_run_r;
	var_00["move_b"] = %riotshield_run_b;
	var_00["crouch"] = %riotshield_crouchwalk_f;
	var_00["crouch_l"] = %riotshield_crouchwalk_l;
	var_00["crouch_r"] = %riotshield_crouchwalk_r;
	var_00["crouch_b"] = %riotshield_crouchwalk_b;
	var_00["stairs_up"] = %traverse_stair_run_01;
	var_00["stairs_down"] = %traverse_stair_run_down;
	self.custommoveanimset["run"] = var_00;
	self.custommoveanimset["walk"] = var_00;
	self.custommoveanimset["cqb"] = var_00;
	self.customidleanimset = [];
	self.customidleanimset["crouch"] = %riotshield_crouch_aim_5;
	self.customidleanimset["crouch_add"] = %riotshield_crouch_idle_add;
	self.customidleanimset["stand"] = %riotshield_crouch_aim_5;
	self.customidleanimset["stand_add"] = %riotshield_crouch_idle_add;
	self.a.pose = "crouch";
	self allowedstances("crouch");
	var_00 = level.animsets.defaultstand;
	var_00["add_aim_up"] = %riotshield_crouch_aim_8;
	var_00["add_aim_down"] = %riotshield_crouch_aim_2;
	var_00["add_aim_left"] = %riotshield_crouch_aim_4;
	var_00["add_aim_right"] = %riotshield_crouch_aim_6;
	var_00["straight_level"] = %riotshield_crouch_aim_5;
	var_00["fire"] = %riotshield_crouch_fire_auto;
	var_00["single"] = animscripts\utility::array(%riotshield_crouch_fire_single);
	var_00["burst2"] = %riotshield_crouch_fire_burst;
	var_00["burst3"] = %riotshield_crouch_fire_burst;
	var_00["burst4"] = %riotshield_crouch_fire_burst;
	var_00["burst5"] = %riotshield_crouch_fire_burst;
	var_00["burst6"] = %riotshield_crouch_fire_burst;
	var_00["semi2"] = %riotshield_crouch_fire_burst;
	var_00["semi3"] = %riotshield_crouch_fire_burst;
	var_00["semi4"] = %riotshield_crouch_fire_burst;
	var_00["semi5"] = %riotshield_crouch_fire_burst;
	var_00["exposed_idle"] = animscripts\utility::array(%riotshield_crouch_idle_add,%riotshield_crouch_twitch);
	var_00["exposed_grenade"] = animscripts\utility::array(%riotshield_crouch_grenade_toss);
	var_00["reload"] = animscripts\utility::array(%riotshield_crouch_reload);
	var_00["reload_crouchhide"] = animscripts\utility::array(%riotshield_crouch_reload);
	var_00["turn_left_45"] = %riotshield_crouch_lturn;
	var_00["turn_left_90"] = %riotshield_crouch_lturn;
	var_00["turn_left_135"] = %riotshield_crouch_lturn;
	var_00["turn_left_180"] = %riotshield_crouch_lturn;
	var_00["turn_right_45"] = %riotshield_crouch_rturn;
	var_00["turn_right_90"] = %riotshield_crouch_rturn;
	var_00["turn_right_135"] = %riotshield_crouch_rturn;
	var_00["turn_right_180"] = %riotshield_crouch_rturn;
	var_00["stand_2_crouch"] = %riotshield_walk2crouch_8;
	animscripts\animset::init_animset_complete_custom_stand(var_00);
	animscripts\animset::init_animset_complete_custom_crouch(var_00);
	self.chooseposefunc = ::riotshield_choose_pose;
	self.painfunction = ::riotshield_pain;
	self.specialdeathfunc = ::riotshield_death;
	self.specialflashedfunc = ::riotshield_flashbang;
	self.grenadecowerfunction = ::riotshield_grenadecower;
	self.custommovetransition = ::riotshield_startmovetransition;
	self.permanentcustommovetransition = 1;
	common_scripts\utility::set_exception("exposed",::riotshield_startcombat);
}

//Function Number: 19
riotshield_choose_pose(param_00)
{
	if(isdefined(self.grenade))
	{
		return "stand";
	}

	return animscripts\utility::choosepose(param_00);
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
	self.fastwalk = 1;
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
	self.fastwalk = undefined;
	self allowedstances("crouch");
}

//Function Number: 24
null_func()
{
}

//Function Number: 25
riotshield_init_flee()
{
	if(self.script == "move")
	{
		self animcustom(::null_func);
	}

	self.custommovetransition = ::riotshield_flee_and_drop_shield;
}

//Function Number: 26
riotshield_flee_and_drop_shield()
{
	self.custommovetransition = ::riotshield_startmovetransition;
	self animmode("zonly_physics",0);
	self orientmode("face current");
	if(!isdefined(self.dropshieldinplace) && isdefined(self.enemy) && vectordot(self.lookaheaddir,anglestoforward(self.angles)) < 0)
	{
		var_00 = %riotshield_crouch2walk_2flee;
	}
	else
	{
		var_00 = %riotshield_crouch2stand_shield_drop;
	}

	var_01 = randomfloatrange(0.85,1.1);
	self setflaggedanimknoball("fleeanim",var_00,%animscript_root,1,0.1,var_01);
	animscripts\shared::donotetracks("fleeanim");
	self.maxfaceenemydist = 32;
	self.lockorientation = 0;
	self orientmode("face default");
	self animmode("normal",0);
	animscripts\shared::donotetracks("fleeanim");
	self clearanim(var_00,0.2);
	self.maxfaceenemydist = 128;
}

//Function Number: 27
riotshield_turn_into_regular_ai()
{
	self.subclass = "regular";
	self.combatmode = "cover";
	self.approachtypefunc = undefined;
	self.approachconditioncheckfunc = undefined;
	self.faceenemyarrival = undefined;
	self.disablecoverarrivalsonly = undefined;
	self.pathrandompercent = 0;
	self.interval = 80;
	self.disabledoorbehavior = undefined;
	self.no_pistol_switch = undefined;
	self.dontshootwhilemoving = undefined;
	self.disablebulletwhizbyreaction = undefined;
	self.disablefriendlyfirereaction = undefined;
	self.neversprintforvariation = undefined;
	self.maxfaceenemydist = 128;
	self.nomeleechargedelay = undefined;
	self.meleechargedistsq = undefined;
	self.meleeplayerwhilemoving = undefined;
	self.usemuzzlesideoffset = undefined;
	self.pathenemyfightdist = 128;
	self.pathenemylookahead = 128;
	self.walkdist = 256;
	self.walkdistfacingmotion = 64;
	self.lockorientation = 0;
	self.frontshieldanglecos = 1;
	self.nogrenadereturnthrow = 0;
	self.ignoresuppression = 0;
	self.sprint = undefined;
	self allowedstances("stand","crouch","prone");
	self.specialmelee_standard = undefined;
	self.specialmeleechooseaction = undefined;
	maps\_utility::enable_turnanims();
	self.bullet_resistance = undefined;
	maps\_utility::remove_damage_function(::maps\_spawner::bullet_resistance);
	maps\_utility::remove_damage_function(::animscripts\pain::additive_pain);
	animscripts\animset::clear_custom_animset();
	self.chooseposefunc = ::animscripts\utility::choosepose;
	self.painfunction = undefined;
	self.specialdeathfunc = undefined;
	self.specialflashedfunc = undefined;
	self.grenadecowerfunction = undefined;
	self.custommovetransition = undefined;
	self.permanentcustommovetransition = undefined;
	common_scripts\utility::clear_exception("exposed");
	common_scripts\utility::clear_exception("stop_immediate");
}

//Function Number: 28
riotshield_damaged()
{
	self endon("death");
	self waittill("riotshield_damaged");
	self.shieldbroken = 1;
	animscripts\shared::detachallweaponmodels();
	self.shieldmodelvariant = 1;
	animscripts\shared::updateattachedweaponmodels();
}