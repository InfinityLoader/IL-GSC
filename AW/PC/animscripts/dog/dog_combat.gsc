/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: dog\dog_combat.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 82
 * Decompile Time: 970 ms
 * Timestamp: 4/22/2024 1:58:44 AM
*******************************************************************/

//Function Number: 1
main()
{
	if(isdefined(level.shark_functions))
	{
		if(issubstr(self.model,"shark"))
		{
			self [[ level.shark_functions["combat"] ]]();
			return;
		}
	}

	self endon("killanimscript");
	if(!isalive(self.enemy))
	{
		combatidle();
		return;
	}

	if(isplayer(self.enemy))
	{
		meleebiteattackplayer();
		return;
	}

	meleestrugglevsai();
}

//Function Number: 2
end_script()
{
	self setpitchorient();
	self.doglastknowngoodpos = undefined;
}

//Function Number: 3
killplayer()
{
	self endon("pvd_melee_interrupted");
	if(!isdefined(self.meleeingplayer.player_view))
	{
		return;
	}

	var_00 = self.meleeingplayer.player_view;
	if(isdefined(var_00.player_killed))
	{
		return;
	}

	var_00.player_killed = 1;
	if(maps\_utility::killing_will_down(self.meleeingplayer))
	{
		knock_down_player_coop(self.meleeingplayer,self);
		return;
	}

	self.meleeingplayer.specialdeath = 1;
	self.meleeingplayer setcandamage(1);
	if(var_00 gettagindex("tag_torso") != -1)
	{
		playfxontag(level._effect["dog_bite_blood"],var_00,"tag_torso");
	}

	wait(1);
	if(!isdefined(self) || !isdefined(self.meleeingplayer))
	{
		return;
	}

	var_01 = is_hyena();
	self.meleeingplayer enablehealthshield(0);
	if(!isalive(self.meleeingplayer))
	{
		return;
	}

	self.meleeingplayer dog_player_kill(self);
	self.meleeingplayer shellshock("default",5);
	waittillframeend;
	setdvar("ui_deadquote","");
	thread dog_death_hud(self.meleeingplayer,var_01);
}

//Function Number: 4
knock_down_player_coop(param_00,param_01)
{
	param_00.dog_downed_player = 1;
	var_02 = dog_vs_player_anim_rate();
	self setflaggedanimknobrestart("meleeanim",%german_shepherd_player_getoff,1,0.1,var_02);
	param_00.player_view notify("pvd_melee_interrupted");
	param_00.player_view notify("pvd_melee_done");
	param_00.player_view playerview_endsequence(param_00);
	if(!maps\_utility::killing_will_down(param_00))
	{
		param_00 dog_player_kill(param_01);
	}
}

//Function Number: 5
dog_player_kill(param_00)
{
	if(maps\_utility::laststand_enabled())
	{
		self enabledeathshield(0);
	}

	self disableinvulnerability();
	if(isalive(param_00))
	{
		self kill(self.origin,param_00);
		return;
	}

	self kill(self.origin);
}

//Function Number: 6
dog_death_hud(param_00,param_01)
{
	if(maps\_utility::is_specialop())
	{
		return;
	}

	wait(1.5);
	thread dog_deathquote(param_00);
	var_02 = newclienthudelem(param_00);
	var_02.x = 0;
	var_02.y = 50;
	if(param_01)
	{
		var_02 setshader("hud_hyena_melee",96,96);
	}
	else
	{
		var_02 setshader("hud_dog_melee",96,96);
	}

	var_02.alignx = "center";
	var_02.aligny = "middle";
	var_02.horzalign = "center";
	var_02.vertalign = "middle";
	var_02.foreground = 1;
	var_02.alpha = 0;
	var_02 fadeovertime(1);
	var_02.alpha = 1;
}

//Function Number: 7
dog_deathquote(param_00)
{
	var_01 = param_00 maps\_hud_util::createclientfontstring("default",1.75);
	var_01.color = (1,1,1);
	var_01 settext(level.dog_death_quote);
	var_01.x = 0;
	var_01.y = -30;
	var_01.alignx = "center";
	var_01.aligny = "middle";
	var_01.horzalign = "center";
	var_01.vertalign = "middle";
	var_01.foreground = 1;
	var_01.alpha = 0;
	var_01 fadeovertime(1);
	var_01.alpha = 1;
}

//Function Number: 8
attackmiss()
{
	self clearanim(%body,0.1);
	var_00 = %german_shepherd_attack_player_miss_b;
	if(isdefined(self.enemy))
	{
		var_01 = anglestoforward((0,self.desiredangle,0));
		var_02 = vectornormalize(self.enemy.origin - self.origin);
		var_03 = self.enemy.origin - self.origin + var_01 * 40;
		if(vectordot(var_02,var_01) > 0.707 || vectordot(var_03,var_01) > 0)
		{
			thread animscripts\dog\dog_stop::lookattarget("normal");
		}
		else
		{
			self.skipstartmove = 1;
			thread attackmisstracktargetthread();
			if(var_02[0] * var_01[1] - var_02[1] * var_01[0] > 0)
			{
				var_00 = %german_shepherd_attack_player_miss_turnr;
			}
			else
			{
				var_00 = %german_shepherd_attack_player_miss_turnl;
			}
		}
	}

	self setflaggedanimrestart("miss_anim",var_00,1,0,1);
	var_04 = getanimlength(var_00);
	soundscripts\_snd::snd_message("anml_doberman","attack_miss");
	animscripts\notetracks::donotetracksfortime(var_04 - 0.1,"miss_anim");
	self notify("stop tracking");
}

//Function Number: 9
attackmisstracktargetthread()
{
	self endon("killanimscript");
	wait(0.6);
	self orientmode("face enemy");
}

//Function Number: 10
knockoutofads(param_00)
{
	param_00 endon("death");
	param_00 allowads(0);
	wait(0.75);
	param_00 allowads(1);
}

//Function Number: 11
dogmelee()
{
	if(isdefined(self.meleeingplayer))
	{
		if(isdefined(self.meleeingplayer.using_uav) && self.meleeingplayer.using_uav)
		{
			self.meleeingplayer notify("force_out_of_uav");
		}

		if(self.meleeingplayer islinked())
		{
			return undefined;
		}

		if(self.meleeingplayer ismantling())
		{
			return undefined;
		}

		if(self.meleeingplayer.laststand && self.meleeingplayer.ignoreme)
		{
			return undefined;
		}
	}

	if(isdefined(self.enemy))
	{
		if(distance2d(self.origin,self.enemy.origin) < 32)
		{
			return self melee();
		}
	}

	return self melee(anglestoforward(self.angles));
}

//Function Number: 12
handlemeleebiteattacknotetracks(param_00)
{
	switch(param_00)
	{
		case "dog_melee":
			var_01 = dogmelee();
			if(isdefined(var_01))
			{
				if(isplayer(var_01))
				{
					var_02 = var_01 getcurrentweapon();
					if(isdefined(var_02) && var_02 == "s1_exo_shield_sp")
					{
						var_01 shellshock("dog_bite_hit_shield",0.5);
					}
					else
					{
						var_01 shellshock("dog_bite",1);
					}
	
					soundscripts\_snd::snd_message("anml_doberman","attack_hit");
					thread knockoutofads(var_01);
				}
			}
			else
			{
				attackmiss();
				return 1;
			}
			break;

		case "stop_tracking":
			self orientmode("face current");
			break;
	}
}

//Function Number: 13
addsafetyhealth()
{
	var_00 = self.meleeingplayer getnormalhealth();
	if(var_00 == 0)
	{
		return 0;
	}

	if(var_00 < 0.25)
	{
		self.meleeingplayer setnormalhealth(var_00 + 0.25);
		return 1;
	}

	return 0;
}

//Function Number: 14
removesafetyhealth()
{
	var_00 = self.meleeingplayer getnormalhealth();
	if(var_00 > 0.25)
	{
		self.meleeingplayer setnormalhealth(var_00 - 0.25);
		return;
	}

	self.meleeingplayer setnormalhealth(0.01);
}

//Function Number: 15
handlemeleefinishattacknotetracks(param_00)
{
	switch(param_00)
	{
		case "dog_melee":
			var_01 = addsafetyhealth();
			var_02 = dogmelee();
			if(isdefined(var_02) && isplayer(var_02) && isalive(self.meleeingplayer))
			{
				if(var_01)
				{
					removesafetyhealth();
				}
	
				self.skipstartmove = undefined;
				self.meleeingplayer.player_view = playerview_spawn(self);
				if(self.meleeingplayer.player_view playerview_startsequence(self))
				{
					self setcandamage(0);
				}
			}
			else
			{
				if(var_01)
				{
					removesafetyhealth();
				}
	
				attackmiss();
				return 1;
			}
			break;

		case "dog_early":
			self notify("dog_early_notetrack");
			var_03 = 0.45 + 0.8 * level.dog_melee_timing_array[level.dog_melee_index];
			var_03 = var_03 * dog_vs_player_anim_rate();
			level.dog_melee_index++;
			if(level.dog_melee_index >= level.dog_melee_timing_array.size)
			{
				level.dog_melee_index = 0;
				level.dog_melee_timing_array = common_scripts\utility::array_randomize(level.dog_melee_timing_array);
			}
	
			self setflaggedanimlimited("meleeanim",%german_shepherd_attack_player,1,0.2,var_03);
			self setflaggedanimlimited("meleeanim",%german_shepherd_attack_player_late,1,0.2,var_03);
			self.meleeingplayer.player_view playerview_playknockdownanimlimited(var_03);
			break;

		case "dog_lunge":
			thread set_melee_timer();
			var_03 = dog_vs_player_anim_rate();
			self setflaggedanim("meleeanim",%german_shepherd_attack_player,1,0.2,var_03);
			self.meleeingplayer.player_view playerview_playknockdownanim(var_03);
			break;

		case "dogbite_damage":
			thread killplayer();
			break;

		case "stop_tracking":
			self orientmode("face current");
			break;
	}
}

//Function Number: 16
handle_dogbite_notetrack(param_00)
{
	switch(param_00)
	{
		case "dogbite_damage":
			thread killplayer();
			break;
	}
}

//Function Number: 17
set_melee_timer()
{
	wait(0.1);
	thread dog_hint();
	wait(0.05);
	self.melee_able_timer = gettime();
}

//Function Number: 18
playerdoginit()
{
	self.lastdogmeleeplayertime = 0;
	self.dogmeleeplayercounter = 0;
}

//Function Number: 19
meleebiteattackplayer()
{
	self.meleeingplayer = self.enemy;
	if(!isdefined(self.meleeingplayer.doginited))
	{
		self.meleeingplayer playerdoginit();
	}

	var_00 = 30;
	var_01 = self.meleeattackdist + var_00;
	for(;;)
	{
		if(!isalive(self.enemy))
		{
			break;
		}

		if(!isplayer(self.enemy))
		{
			break;
		}

		if(maps\_utility::is_player_down(self.enemy))
		{
			combatidle();
			continue;
		}

		if((isdefined(self.meleeingplayer.syncedmeleetarget) && self.meleeingplayer.syncedmeleetarget != self) || isdefined(self.meleeingplayer.player_view) && isdefined(self.meleeingplayer.player_view.inseq))
		{
			if(checkendcombat(var_01))
			{
				break;
			}
			else
			{
				combatidle();
				continue;
			}
		}

		if(shouldwaitincombatidle())
		{
			combatidle();
			continue;
		}

		self orientmode("face enemy");
		self animmode("zonly_physics");
		self.safetochangescript = 0;
		prepareattackplayer();
		self clearanim(%body,0.1);
		self clearpitchorient();
		self.meleeingplayer setnextdogattackallowtime(500);
		if(dog_cant_kill_in_one_hit() || !isdefined(self.dogallowplayerpairedanim))
		{
			self.meleeingplayer.lastdogmeleeplayertime = gettime();
			self.meleeingplayer.dogmeleeplayercounter++;
			self setflaggedanimrestart("meleeanim",%german_shepherd_run_attack_b,1,0.2,1);
			animscripts\shared::donotetracks("meleeanim",::handlemeleebiteattacknotetracks);
		}
		else
		{
			thread dog_melee_death();
			self.meleeingplayer.attacked_by_dog = 1;
			self.meleeingplayer.laststand = 0;
			self.meleeingplayer.achieve_downed_kills = undefined;
			thread clear_player_attacked_by_dog_on_death();
			self setflaggedanimrestart("meleeanim",%german_shepherd_attack_player,1,0.2,1);
			self setflaggedanimrestart("meleeanim",%german_shepherd_attack_player_late,1,0,1);
			self setanimlimited(%attack_player,1,0,1);
			self setanimlimited(%attack_player_late,0.01,0,1);
			animscripts\shared::donotetracks("meleeanim",::handlemeleefinishattacknotetracks);
			self notify("dog_no_longer_melee_able");
			self setcandamage(1);
			self unlink();
		}

		self.safetochangescript = 1;
		wait(0.05);
		if(checkendcombat(var_01))
		{
			break;
		}
	}

	self.safetochangescript = 1;
	self animmode("none");
}

//Function Number: 20
clear_player_attacked_by_dog_on_death()
{
	self waittill("death");
	self.meleeingplayer.attacked_by_dog = undefined;
}

//Function Number: 21
dog_cant_kill_in_one_hit()
{
	if(isdefined(self.meleeingplayer.dogs_dont_instant_kill))
	{
		return 1;
	}

	if(maps\_utility::is_player_down(self.meleeingplayer))
	{
		return 1;
	}

	if(isdefined(self.meleeingplayer.slidemodel))
	{
		return 1;
	}

	if(gettime() - self.meleeingplayer.lastdogmeleeplayertime > 8000)
	{
		self.meleeingplayer.dogmeleeplayercounter = 0;
	}

	return self.meleeingplayer.dogmeleeplayercounter < self.meleeingplayer.gs.dog_hits_before_kill && self.meleeingplayer.health > 25;
}

//Function Number: 22
shouldwaitincombatidle()
{
	return isdefined(self.enemy.dogattackallowtime) && gettime() < self.enemy.dogattackallowtime;
}

//Function Number: 23
setnextdogattackallowtime(param_00)
{
	self.dogattackallowtime = gettime() + param_00;
}

//Function Number: 24
isdoingtraversal()
{
	return self isinscriptedstate() && self.script != "scripted" && self.script != "<custom>";
}

//Function Number: 25
meleestrugglevsai()
{
	if(!isalive(self.enemy) || !isdefined(level.allow_dog_paired_melee_vs_ai))
	{
		return;
	}

	if(isdefined(self.enemy.melee))
	{
		if(!isdefined(self.enemy.melee.target) || self.enemy.melee.target != self)
		{
			combatidle();
			return;
		}
	}

	if(isdefined(self.enemy.syncedmeleetarget) || shouldwaitincombatidle() || !isai(self.enemy))
	{
		combatidle();
		return;
	}

	self.in_melee = 1;
	self.enemy setnextdogattackallowtime(500);
	self.enemy.dog_attacking_me = self;
	var_00 = animscripts\battlechatter::getdirectionfacingclock(self.enemy.angles,self.enemy.origin,self.origin);
	var_01 = "F";
	switch(var_00)
	{
		case "4":
		case "3":
		case "2":
			var_01 = "R";
			break;

		case "10":
		case "9":
		case "8":
			var_01 = "L";
			break;

		case "7":
		case "6":
		case "5":
			var_01 = "B";
			break;
	}

	self.enemy.dog_attack_dir = var_01;
	level notify("dog_attacks_ai",self,self.enemy,var_01);
	self.enemy notify("dog_attacks_ai",self,var_01);
	if(isdefined(level.dog_alt_melee_func))
	{
		if([[ level.dog_alt_melee_func ]](var_01))
		{
			return 1;
		}
	}

	self.safetochangescript = 0;
	self animmode("zonly_physics");
	self.pushable = 0;
	self clearpitchorient();
	self.meleekilltarget = !isdefined(self.enemy.magic_bullet_shield) && !isdefined(self.enemy.noragdoll) && isdefined(self.enemy.a.doinglongdeath) || isdefined(self.meleealwayswin) || randomint(100) > 50;
	self.originaltarget = self.enemy;
	self.enemy.battlechatter = 0;
	self.enemy.ignoreall = 1;
	self.enemy clearenemy();
	self.enemy.diequietly = 1;
	var_02 = 0;
	if(isdefined(self.enemy.use_old_dog_attack))
	{
		var_02 = 1;
	}

	if(meleestruggle_istraverse())
	{
		return meleestrugglevsai_traverse(var_01);
	}

	var_03 = vectortoangles(self.origin - self.enemy.origin);
	var_03 = (0,var_03[1],0);
	var_04 = [];
	var_04[0] = %body;
	if(var_02)
	{
		self.enemy.use_old_dog_attack = 1;
		var_04[1] = %iw6_dog_kill_front_quick_1;
		var_05 = 1;
		if(isdefined(self.controlling_dog) && self.controlling_dog)
		{
			thread maps\_utility::play_sound_on_entity("scn_nml_dog_attack_short");
		}
		else
		{
			thread maps\_utility::play_sound_on_entity("scn_nml_dog_attack_short_npc");
		}
	}
	else if(isdefined(self.enemy.a.doinglongdeath) || self.enemy.a.pose == "prone" || self.enemy isdoingtraversal())
	{
		thread maps\_utility::play_sound_on_entity("scn_nml_dog_attack_short_npc");
		return domeleevsai_simple();
	}
	else
	{
		var_05[1] = %iw6_dog_kill_front_long_1;
		var_05 = 1;
		switch(var_01)
		{
			case "R":
				var_04[1] = %iw6_dog_kill_right_quick_1;
				var_05 = 1;
				var_03 = var_03 + (0,90,0);
				if(isdefined(self.controlling_dog) && self.controlling_dog)
				{
					thread maps\_utility::play_sound_on_entity("scn_nml_dog_attack_short");
				}
				else
				{
					thread maps\_utility::play_sound_on_entity("scn_nml_dog_attack_short_npc");
				}
				break;

			case "L":
				var_04[1] = %iw6_dog_kill_left_quick_1;
				var_05 = 1;
				var_03 = var_03 + (0,-90,0);
				if(isdefined(self.controlling_dog) && self.controlling_dog)
				{
					thread maps\_utility::play_sound_on_entity("scn_nml_dog_attack_short");
				}
				else
				{
					thread maps\_utility::play_sound_on_entity("scn_nml_dog_attack_short_npc");
				}
				break;

			case "B":
				var_04[1] = %iw6_dog_kill_back_quick_1;
				var_05 = 1;
				var_03 = var_03 - (0,180,0);
				if(isdefined(self.controlling_dog) && self.controlling_dog)
				{
					thread maps\_utility::play_sound_on_entity("scn_nml_dog_attack_quick_back_plr");
				}
				else
				{
					thread maps\_utility::play_sound_on_entity("scn_nml_dog_attack_quick_back_npc");
				}
				break;

			default:
				if(isdefined(self.controlling_dog) && self.controlling_dog)
				{
					thread maps\_utility::play_sound_on_entity("scn_nml_dog_attack_front_plr");
				}
				else
				{
					thread maps\_utility::play_sound_on_entity("scn_nml_dog_attack_front_npc");
				}
				break;
		}
	}

	return domeleevsai(var_04,var_05,var_03);
}

//Function Number: 26
domeleevsai_simple()
{
	self animcustom(::domeleevsai_simple_animcustom,::domeleevsai_simple_animcustom_cleanup);
	return 1;
}

//Function Number: 27
domeleevsai_simple_animcustom()
{
	self notify("stop_pant");
	self.flashbangimmunity = 1;
	self.enemy meleestrugglevsdog_justdie();
	var_00 = self.enemy.origin - self.origin;
	var_01 = vectortoangles(var_00);
	self clearanim(%body,0.1);
	self animmode("zonly_physics");
	self orientmode("face angle",var_01[1]);
	animscripts\shared::donotetracks("meleeanim");
}

//Function Number: 28
domeleevsai_simple_animcustom_cleanup()
{
	self.pushable = 1;
	self.safetochangescript = 1;
	self.flashbangimmunity = 0;
	self.in_melee = 0;
}

//Function Number: 29
domeleevsai(param_00,param_01,param_02,param_03)
{
	self notify("stop_pant");
	self setcandamage(0);
	self.enemy.fndogmeleevictim = param_03;
	self endon("melee_dog_interrupted");
	thread meleestrugglevsai_interruptedcheck(self.enemy);
	self clearanim(param_00[0],0.1);
	self animrelative("meleeanim",self.enemy.origin,param_02,param_00[1]);
	if(!animhasnotetrack(param_00[1],"ai_attack_start"))
	{
		handlestartaipart("ai_attack_start");
	}

	animscripts\shared::donotetracks("meleeanim",::handlestartaipart);
	self notify("end_dog_interrupted_check");
	self setcandamage(1);
	self animmode("zonly_physics");
	for(var_04 = 1;var_04 < param_01;var_04++)
	{
		if(isdefined(level._effect["dog_bite"]) && isdefined(level._effect["dog_bite"][var_04]) && isdefined(self.enemy))
		{
			playfxontag(level._effect["dog_bite"][var_04],self.enemy,"TAG_EYE");
		}

		self clearanim(param_00[var_04],0);
		if(!insyncmeleewithtarget())
		{
			break;
		}

		if(!self.meleekilltarget && var_04 + 1 == param_01)
		{
			self.health = 1;
		}

		self setflaggedanimrestart("meleeanim",param_00[var_04 + 1],1,0,1);
		animscripts\shared::donotetracks("meleeanim");
	}

	melee_dogcleanup();
	return 1;
}

//Function Number: 30
melee_dogcleanup()
{
	self unlink();
	if(!self.meleekilltarget)
	{
		if(!isdefined(self.magic_bullet_shield))
		{
			self kill();
		}
	}
	else
	{
		self.pushable = 1;
		self.safetochangescript = 1;
		self.flashbangimmunity = 0;
	}

	thread ragdoll_corpses();
	self.in_melee = 0;
	if(isdefined(self.doglastknowngoodpos))
	{
		var_00 = self aiphysicstrace(self.origin,self.origin + (0,0,2),undefined,undefined,1,0,1);
		if(distancesquared(var_00,self.origin) < 0.001)
		{
			self forceteleport(self.doglastknowngoodpos,self.angles,60);
		}

		self.doglastknowngoodpos = undefined;
	}

	self animmode("none");
}

//Function Number: 31
meleestruggle_istraverse()
{
	var_00 = self getdogattackbeginnode();
	return isdefined(var_00);
}

//Function Number: 32
meleestrugglevsai_traverse(param_00)
{
	self.safetochangescript = 0;
	self animmode("zonly_physics");
	self.pushable = 0;
	self clearpitchorient();
	self.meleekilltarget = !isdefined(self.enemy.magic_bullet_shield) && isdefined(self.enemy.a.doinglongdeath) || isdefined(self.meleealwayswin) || randomint(100) > 50;
	self.originaltarget = self.enemy;
	self.enemy.battlechatter = 0;
	var_01 = vectortoangles(self.origin - self.enemy.origin);
	var_01 = (0,var_01[1],0);
	var_02 = [];
	var_02[0] = %body;
	var_02[1] = %iw6_dog_kill_wall_over_front_1;
	var_03 = 1;
	if(self.enemy isdoingtraversal())
	{
		thread maps\_utility::play_sound_on_entity("scn_nml_dog_attack_short_npc");
	}
	else if(isdefined(self.controlling_dog) && self.controlling_dog)
	{
		thread maps\_utility::play_sound_on_entity("scn_nml_dog_attack_front_plr");
	}
	else
	{
		thread maps\_utility::play_sound_on_entity("scn_nml_dog_attack_front_npc");
	}

	self.doglastknowngoodpos = self.origin;
	return domeleevsai(var_02,var_03,var_01,::meleestrugglevsdog_traverse);
}

//Function Number: 33
meleestrugglevsai_interrupted_animcustom()
{
	self animmode("gravity");
	self clearanim(%body,0.2);
	self setflaggedanim("meleeanim",%iw6_dog_kill_breach_end_nml);
	animscripts\shared::donotetracks("meleeanim");
}

//Function Number: 34
meleestrugglevsai_interrupted_animcustom_cleanup()
{
	if(isdefined(self.doglastknowngoodposcustom))
	{
		self.doglastknowngoodpos = self.doglastknowngoodposcustom;
	}

	self.doglastknowngoodposcustom = undefined;
	self animmode("zonly_physics");
	melee_dogcleanup();
	meleestrugglevsdog_end();
}

//Function Number: 35
meleestrugglevsai_interruptedcheck(param_00)
{
	self endon("killanimscript");
	self endon("death");
	self endon("end_melee_all");
	self endon("end_dog_interrupted_check");
	param_00 waittill("death");
	self notify("melee_dog_interrupted");
	self unlink();
	self setcandamage(1);
	self.doglastknowngoodposcustom = self.doglastknowngoodpos;
	self animcustom(::meleestrugglevsai_interrupted_animcustom,::meleestrugglevsai_interrupted_animcustom_cleanup);
}

//Function Number: 36
combatidle()
{
	self orientmode("face enemy");
	self clearanim(%body,0.1);
	self animmode("zonly_physics");
	var_00 = [];
	var_00[0] = %iw6_dog_attackidle;
	var_00[1] = %iw6_dog_attackidle_bark;
	var_01 = common_scripts\utility::random(var_00);
	thread combatidlepreventoverlappingplayer();
	self setflaggedanimrestart("combat_idle",var_01,1,0.2,1);
	animscripts\shared::donotetracks("combat_idle");
	self notify("combatIdleEnd");
}

//Function Number: 37
combatidlepreventoverlappingplayer()
{
	self endon("killanimscript");
	self endon("combatIdleEnd");
	for(;;)
	{
		wait(0.1);
		var_00 = getentarray("player","classname");
		for(var_01 = 0;var_01 < var_00.size;var_01++)
		{
			var_02 = var_00[var_01];
			if(!isdefined(var_02.syncedmeleetarget) || var_02.syncedmeleetarget == self)
			{
				continue;
			}

			var_03 = var_02.origin - self.origin;
			if(var_03[2] * var_03[2] > 6400)
			{
				continue;
			}

			var_03 = (var_03[0],var_03[1],0);
			var_04 = length(var_03);
			if(var_04 < 1)
			{
				var_03 = anglestoforward(self.angles);
			}

			if(var_04 < 30)
			{
				var_03 = var_03 * 3 / var_04;
				self safeteleport(self.origin - var_03,(0,30,0));
			}
		}
	}
}

//Function Number: 38
insyncmeleewithtarget()
{
	return isdefined(self.enemy) && isdefined(self.enemy.syncedmeleetarget) && self.enemy.syncedmeleetarget == self;
}

//Function Number: 39
handlestartaipart(param_00)
{
	if(param_00 != "ai_attack_start")
	{
		handlevxnotetrack(param_00);
		return undefined;
	}

	if(!isdefined(self.enemy))
	{
		return 1;
	}

	if(self.enemy != self.originaltarget)
	{
		return 1;
	}

	if(isdefined(self.enemy.syncedmeleetarget))
	{
		return 1;
	}

	self.flashbangimmunity = 1;
	self.enemy.syncedmeleetarget = self;
	if(self.enemy isdoingtraversal())
	{
		self.enemy meleestrugglevsdog_justdie();
		return;
	}

	if(isdefined(self.enemy.fndogmeleevictim))
	{
		self.enemy animcustom(self.enemy.fndogmeleevictim);
		return;
	}

	self.enemy animcustom(::meleestrugglevsdog);
}

//Function Number: 40
checkendcombat(param_00)
{
	if(!isdefined(self.enemy))
	{
		return 0;
	}

	var_01 = distancesquared(self.origin,self.enemy.origin);
	return var_01 > param_00 * param_00;
}

//Function Number: 41
prepareattackplayer()
{
	if(is_hyena())
	{
		level.dog_death_quote = &"NEW_HYENA_DEATH_DO_NOTHING_ALT";
		level.so_dog_death_quote = "@NEW_HYENA_DEATH_DO_NOTHING_ALT";
	}
	else
	{
		level.dog_death_quote = &"NEW_DOG_DEATH_DO_NOTHING_ALT";
		level.so_dog_death_quote = "@NEW_DOG_DEATH_DO_NOTHING_ALT";
	}

	level.dog_death_type = "nothing";
	var_00 = distance(self.origin,self.enemy.origin);
	if(var_00 > self.meleeattackdist)
	{
		var_01 = self.enemy.origin - self.origin;
		var_02 = var_00 - self.meleeattackdist / var_00;
		var_01 = (var_01[0] * var_02,var_01[1] * var_02,var_01[2] * var_02);
		thread attackteleportthread(var_01);
	}
}

//Function Number: 42
attackteleportthread(param_00)
{
	self endon("death");
	self endon("killanimscript");
	var_01 = 5;
	var_02 = (param_00[0] / var_01,param_00[1] / var_01,param_00[2] / var_01);
	for(var_03 = 0;var_03 < var_01;var_03++)
	{
		self teleport(self.origin + var_02);
		wait(0.05);
	}
}

//Function Number: 43
player_attacked()
{
	return isalive(self.meleeingplayer) && self.meleeingplayer meleebuttonpressed();
}

//Function Number: 44
dog_hint()
{
	var_00 = self.meleeingplayer.gs.dog_presstime / 1000 / dog_vs_player_anim_rate();
	level endon("clearing_dog_hint");
	if(isdefined(self.meleeingplayer.doghintelem))
	{
		self.meleeingplayer.doghintelem maps\_hud_util::destroyelem();
	}

	self.meleeingplayer.doghintelem = self.meleeingplayer maps\_hud_util::createclientfontstring("default",3);
	self.meleeingplayer.doghintelem.color = (1,1,1);
	self.meleeingplayer.doghintelem settext(&"SCRIPT_PLATFORM_DOG_HINT");
	self.meleeingplayer.doghintelem.x = 0;
	self.meleeingplayer.doghintelem.y = 20;
	self.meleeingplayer.doghintelem.alignx = "center";
	self.meleeingplayer.doghintelem.aligny = "middle";
	self.meleeingplayer.doghintelem.horzalign = "center";
	self.meleeingplayer.doghintelem.vertalign = "middle";
	self.meleeingplayer.doghintelem.foreground = 1;
	self.meleeingplayer.doghintelem.alpha = 1;
	self.meleeingplayer.doghintelem.hidewhendead = 1;
	self.meleeingplayer.doghintelem.sort = -1;
	self.meleeingplayer.doghintelem endon("death");
	wait(var_00);
	thread dog_hint_fade();
}

//Function Number: 45
dog_hint_fade()
{
	level notify("clearing_dog_hint");
	if(isdefined(self) && isdefined(self.meleeingplayer.doghintelem))
	{
		var_00 = self.meleeingplayer.doghintelem;
		if(isdefined(self.meleeingplayer.player_view.necksnapped) && self.meleeingplayer.player_view.necksnapped)
		{
			var_01 = 0.5;
			var_00 changefontscaleovertime(var_01);
			var_00.fontscale = var_00.fontscale * 1.5;
			var_00.glowcolor = (0.3,0.6,0.3);
			var_00.glowalpha = 1;
			var_00 fadeovertime(var_01);
			var_00.color = (0,0,0);
			var_00.alpha = 0;
			wait(var_01);
			var_00 maps\_hud_util::destroyelem();
			return;
		}

		var_00 maps\_hud_util::destroyelem();
	}
}

//Function Number: 46
dog_delayed_unlink()
{
	wait(0.7);
	if(isdefined(self))
	{
		self unlink();
	}
}

//Function Number: 47
dog_delayed_allow_damage()
{
	self endon("death");
	wait(1.5);
	if(isdefined(self))
	{
		self setcandamage(1);
	}
}

//Function Number: 48
dog_melee_death()
{
	self endon("killanimscript");
	self endon("dog_no_longer_melee_able");
	var_00 = 0;
	var_01 = self.meleeingplayer.gs.dog_presstime / dog_vs_player_anim_rate();
	self waittill("dog_early_notetrack");
	while(player_attacked())
	{
		wait(0.05);
	}

	var_02 = 0;
	for(;;)
	{
		if(!var_00)
		{
			if(player_attacked())
			{
				var_00 = 1;
				if(isdefined(self.melee_able_timer) && isalive(self.meleeingplayer))
				{
					if(gettime() - self.melee_able_timer <= var_01)
					{
						self.meleeingplayer set_melee_early(var_02);
						self.meleeingplayer.player_view.necksnapped = 1;
						self notify("melee_stop");
						self setflaggedanimknobrestart("dog_death_anim",%german_shepherd_player_neck_snap,1,0.2,1);
						thread dog_delayed_allow_damage();
						self setcandamage(0);
						self waittillmatch("dog_death","dog_death_anim");
						thread common_scripts\utility::play_sound_in_space("dog_neckbreak",self geteye());
						self setcandamage(1);
						self.a.nodeath = 1;
						self.dog_neck_snapped = 1;
						var_03 = self.meleeingplayer.origin - self.origin;
						var_03 = (var_03[0],var_03[1],0);
						thread dog_delayed_unlink();
						self kill(self geteye() - var_03,self.meleeingplayer);
						self notify("killanimscript");
					}
					else
					{
						self.meleeingplayer set_melee_early(var_02);
						self.meleeingplayer.player_view playerview_knockdownlate();
						self setanimlimited(%attack_player,0.01,0.2,1);
						self setanimlimited(%attack_player_late,1,0.2,1);
						if(is_hyena())
						{
							level.dog_death_quote = &"NEW_HYENA_DEATH_TOO_LATE_ALT";
							level.so_dog_death_quote = "@NEW_HYENA_DEATH_TOO_LATE_ALT";
						}
						else
						{
							level.dog_death_quote = &"NEW_DOG_DEATH_TOO_LATE_ALT";
							level.so_dog_death_quote = "@NEW_DOG_DEATH_TOO_LATE_ALT";
						}

						level.dog_death_type = "late";
					}

					return;
				}

				var_02 = 1;
				if(self.meleeingplayer can_early_melee())
				{
					if(is_hyena())
					{
						level.dog_death_quote = &"NEW_HYENA_DEATH_TOO_SOON_ALT";
						level.so_dog_death_quote = "@NEW_HYENA_DEATH_TOO_SOON_ALT";
					}
					else
					{
						level.dog_death_quote = &"NEW_DOG_DEATH_TOO_SOON_ALT";
						level.so_dog_death_quote = "@NEW_DOG_DEATH_TOO_SOON_ALT";
					}

					level.dog_death_type = "soon";
					var_04 = dog_vs_player_anim_rate();
					self setflaggedanimknobrestart("meleeanim",%german_shepherd_player_neck_miss,1,0.2,var_04);
					self.meleeingplayer.player_view playerview_playmissanim(var_04);
					return;
				}
			}
		}
		else if(!player_attacked())
		{
			var_01 = 0;
		}

		wait(0.05);
	}
}

//Function Number: 49
can_early_melee()
{
	if(self.gameskill == 3)
	{
		return 1;
	}

	if(isdefined(self.dogmeleeearly) && self.dogmeleeearly)
	{
		return 1;
	}

	return 0;
}

//Function Number: 50
set_melee_early(param_00)
{
	if(!param_00)
	{
		return;
	}

	if(level.gameskill > 1 && !isdefined(self.dogmeleeearly))
	{
		self.dogmeleeearly = 1;
	}
}

//Function Number: 51
meleestrugglevsdog()
{
	self endon("killanimscript");
	self endon("death");
	self endon("end_melee_all");
	if(!isdefined(self.syncedmeleetarget))
	{
		return;
	}

	self stopsounds();
	var_00 = vectortoangles(self.syncedmeleetarget.origin - self.origin);
	var_01 = var_00[1];
	if(isdefined(self.use_old_dog_attack) && self.use_old_dog_attack)
	{
		var_02 = [];
		var_02[0] = %body;
		var_02[1] = %iw6_dog_kill_front_quick_guy_1;
		var_03 = 1;
		maps\_utility::gun_remove();
	}
	else
	{
		var_02 = [];
		var_02[0] = %body;
		switch(self.dog_attack_dir)
		{
			case "F":
				var_02[1] = %iw6_dog_kill_front_long_guy_1;
				var_03 = 1;
				playsound_victim("dogdeathlong");
				break;

			case "R":
				var_02[1] = %iw6_dog_kill_right_quick_guy_1;
				var_03 = 1;
				var_01 = var_00[1] + 90;
				playsound_victim("dogdeathshort");
				break;

			case "L":
				var_02[1] = %iw6_dog_kill_left_quick_guy_1;
				var_03 = 1;
				var_01 = var_00[1] - 90;
				playsound_victim("dogdeathshort");
				break;

			case "B":
				var_02[1] = %iw6_dog_kill_back_quick_guy_1;
				var_03 = 1;
				var_01 = var_00[1] - 180;
				playsound_victim("dogdeathshort");
				break;

			default:
				break;
		}
	}

	domeleevsdog(var_02,var_01);
}

//Function Number: 52
playsound_victim(param_00)
{
	if(isdefined(self.syncedmeleetarget.controlling_dog))
	{
		param_00 = param_00 + "plr";
	}

	thread animscripts\face::saygenericdialogue(param_00);
}

//Function Number: 53
meleestrugglevsdog_interruptedcheck()
{
	self endon("killanimscript");
	self endon("death");
	self endon("end_melee_all");
	var_00 = [];
	var_00[1] = %ai_attacked_german_shepherd_02_getup_a;
	var_00[2] = %ai_attacked_german_shepherd_02_getup_a;
	if(self.syncedmeleetarget.meleekilltarget)
	{
		var_00[4] = %ai_attacked_german_shepherd_04_getup_a;
	}

	for(;;)
	{
		if(!isdefined(self.syncedmeleetarget) || !isalive(self.syncedmeleetarget))
		{
			break;
		}

		wait(0.1);
	}

	self.ragdoll_immediate = undefined;
	if(self.meleeseq > 0)
	{
		if(!isdefined(var_00[self.meleeseq]))
		{
			return;
		}

		self clearanim(%melee_dog,0.1);
		self setflaggedanimrestart("getupanim",var_00[self.meleeseq],1,0.1,1);
		animscripts\shared::donotetracks("getupanim");
	}

	meleestrugglevsdog_end();
}

//Function Number: 54
meleestrugglevsdog_end()
{
	self orientmode("face default");
	self.syncedmeleetarget = undefined;
	self.meleeseq = undefined;
	self.allowpain = 1;
	self.battlechatter = 1;
	self.use_old_dog_attack = undefined;
	self.dog_attacking_me = undefined;
	setnextdogattackallowtime(1000);
	if(isdefined(self.olddontattackme))
	{
		self.dontattackme = self.olddontattackme;
		self.olddontattackme = undefined;
	}

	self notify("end_melee_all");
}

//Function Number: 55
meleestrugglevsdog_collision(param_00)
{
	self endon("killanimscript");
	self endon("death");
	self endon("end_melee_all");
	var_01 = self.syncedmeleetarget;
	var_01 endon("death");
	var_01 endon("killanimscript");
	if(isdefined(param_00) && param_00 > 0)
	{
		wait(param_00);
	}

	var_01.doglastknowngoodpos = var_01.origin;
	for(;;)
	{
		var_02 = var_01 aiphysicstrace(self.origin,var_01.origin,undefined,undefined,1,1,1);
		if(var_02["fraction"] >= 1)
		{
			var_01.doglastknowngoodpos = var_01.origin;
			wait(0.05);
			continue;
		}

		if(var_02["normal"][2] >= 0)
		{
			var_03 = var_02["position"] - var_01.origin;
			var_04 = vectordot(var_03,var_02["normal"]);
			if(var_04 > 0)
			{
				var_05 = self.origin + var_04 + 1 * var_02["normal"];
				var_06 = var_05 + (0,0,9);
				var_07 = var_05 + (0,0,-9);
				var_08 = self aiphysicstrace(var_06,var_07);
				if(var_08[2] > var_05[2])
				{
					var_05 = var_08;
				}

				self forceteleport(var_05,self.angles,60);
			}
		}

		wait(0.05);
	}
}

//Function Number: 56
meleestrugglevsdog_justdie()
{
	thread animscripts\face::saygenericdialogue("dogdeathlong");
	self.ragdoll_immediate = 1;
	if(!isdefined(self.magic_bullet_shield))
	{
		self.forceragdollimmediate = 1;
		animscripts\shared::dropallaiweapons();
		self kill(self.dog_attacking_me.origin,self.dog_attacking_me);
	}

	thread ragdoll_corpses();
	setnextdogattackallowtime(1000);
}

//Function Number: 57
meleestrugglevsdog_traverse()
{
	if(!isdefined(self.syncedmeleetarget))
	{
		return;
	}

	var_00 = vectortoangles(self.syncedmeleetarget.origin - self.origin);
	var_01 = var_00[1];
	var_02 = [];
	var_02[0] = %body;
	var_02[1] = %iw6_dog_kill_wall_over_front_guy_1;
	playsound_victim("dogdeathlong");
	domeleevsdog(var_02,var_01,0.15);
}

//Function Number: 58
domeleevsdog(param_00,param_01,param_02)
{
	self endon("killanimscript");
	self endon("death");
	self endon("end_melee_all");
	if(!isdefined(self.syncedmeleetarget))
	{
		return;
	}

	self orientmode("face angle",param_01);
	self animmode("gravity");
	self.olddontattackme = self.dontattackme;
	self.dontattackme = 1;
	self.health = 1;
	self.battlechatter = 0;
	self.a.pose = "stand";
	self.a.special = "none";
	if(animscripts\utility::usingsidearm())
	{
		animscripts\shared::placeweaponon(self.primaryweapon,"right");
	}

	self.ragdoll_immediate = 1;
	self.meleeseq = 0;
	thread meleestrugglevsdog_interruptedcheck();
	self clearanim(param_00[0],0.1);
	self setflaggedanimrestart("aianim",param_00[1],1,0.1,1);
	thread animscripts\shared::donotetracks("aianim");
	wait(0.15);
	self.syncedmeleetarget linkto(self,"tag_sync",(0,0,0),(0,0,0));
	thread meleestrugglevsdog_collision(param_02);
	self waittillmatch("end","aianim");
	self.syncedmeleetarget notify("end_dog_interrupted_check");
	if(!isdefined(self.magic_bullet_shield))
	{
		self.forceragdollimmediate = 1;
		self.a.nodeath = 1;
		animscripts\shared::dropallaiweapons();
		self kill(self.dog_attacking_me.origin,self.dog_attacking_me);
	}

	meleestrugglevsdog_end();
}

//Function Number: 59
playerdrone_create(param_00)
{
	var_01 = spawn("script_model",param_00.origin);
	var_01 [[ param_00.last_modelfunc ]]();
	var_01 useanimtree(#animtree);
	return var_01;
}

//Function Number: 60
playerdrone_anim_knockdown(param_00)
{
	self endon("death");
	var_01 = getanimlength(%player_3rd_dog_knockdown);
	self setanim(%player_3rd_dog_knockdown,1,0,param_00);
}

//Function Number: 61
playerdone_anim_neck_snap()
{
	self setanimknobrestart(%player_3rd_dog_knockdown_neck_snap,1,0,1);
}

//Function Number: 62
playerdone_anim_saved()
{
	self setanimknobrestart(%player_3rd_dog_knockdown_saved,1,0,1);
}

//Function Number: 63
playerdone_anim_laststand()
{
	self setanimknobrestart(%player_3rd_dog_knockdown_laststand,1,0,1);
}

//Function Number: 64
playerview_spawn(param_00)
{
	var_01 = spawn("script_model",param_00.meleeingplayer.origin);
	var_01.angles = param_00.meleeingplayer.angles;
	var_01 setmodel(level.player_viewhand_model);
	var_01 useanimtree(#animtree);
	var_01 hide();
	return var_01;
}

//Function Number: 65
handleplayerknockdownnotetracks(param_00)
{
	switch(param_00)
	{
		case "allow_player_save":
			if(isdefined(self.dog))
			{
				wait(1);
				self.dog setcandamage(1);
			}
			break;

		case "blood_pool":
			if(!isdefined(self.dog.meleeingplayer))
			{
				break;
			}
	
			if(maps\_utility::killing_will_down(self.dog.meleeingplayer))
			{
				break;
			}
	
			var_01 = self gettagorigin("tag_torso");
			var_02 = self gettagangles("tag_torso");
			var_03 = anglestoforward(var_02);
			var_04 = anglestoup(var_02);
			var_05 = anglestoright(var_02);
			var_01 = var_01 + var_03 * -8.5 + var_04 * 5 + var_05 * 0;
			playfx(level._effect["deathfx_bloodpool"],var_01,var_03,var_04);
			break;
	}
}

//Function Number: 66
playerview_knockdownanim(param_00)
{
	self endon("pvd_melee_interrupted");
	var_01 = param_00.meleeingplayer;
	self.dog = param_00;
	thread playerview_checkinterrupted(var_01);
	self setflaggedanimrestart("viewanim",%player_view_dog_knockdown);
	self setflaggedanimrestart("viewanim",%player_view_dog_knockdown_late);
	self setanimlimited(%knockdown,1,0,1);
	self setanimlimited(%knockdown_late,0.01,0,1);
	animscripts\shared::donotetracks("viewanim",::handleplayerknockdownnotetracks);
	self dontinterpolate();
	self.dog = undefined;
	playerview_endsequence(var_01);
	self notify("pvd_melee_done");
}

//Function Number: 67
playerview_checkinterrupted(param_00)
{
	self endon("pvd_melee_done");
	self.dog common_scripts\utility::waittill_any("death","pain","melee_stop");
	if(!isdefined(param_00.specialdeath) && isalive(param_00))
	{
		self notify("pvd_melee_interrupted");
		self.dog notify("pvd_melee_interrupted");
		playerview_endsequence(param_00);
	}
}

//Function Number: 68
playerview_startsequence(param_00)
{
	if(isdefined(self.inseq))
	{
		return 0;
	}

	var_01 = param_00.meleeingplayer;
	if(isdefined(var_01) && isdefined(var_01.placingsentry))
	{
		var_01 notify("sentry_placement_canceled");
	}

	var_01 notify("dog_attacks_player");
	self.inseq = 1;
	if(isalive(var_01))
	{
		var_01 hidehud();
	}

	var_01 setstance("stand");
	var_01.syncedmeleetarget = param_00;
	var_01.player_view playerview_show(var_01);
	var_02 = param_00.origin - var_01.origin;
	self.angles = vectortoangles(var_02);
	self.angles = (0,self.angles[1],0);
	self.startangles = self.angles;
	var_03 = var_01.origin;
	var_04 = var_01 getdroptofloorposition(var_01.origin);
	if(isdefined(var_04))
	{
		self.origin = var_04;
	}
	else
	{
		self.origin = var_01.origin;
	}

	thread playerview_knockdownanim(param_00);
	self dontinterpolate();
	var_01 playerlinktoabsolute(self,"tag_player");
	param_00 linkto(self,"tag_sync",(0,0,0),(0,0,0));
	var_05 = self gettagangles("tag_sync");
	param_00 orientmode("face angle",var_05[1]);
	param_00 orientmode("face default");
	var_01 allowstand(1);
	var_01 allowlean(0);
	var_01 allowcrouch(0);
	var_01 allowprone(0);
	var_01 freezecontrols(1);
	var_01 setcandamage(0);
	return 1;
}

//Function Number: 69
savednotify(param_00)
{
	wait(0.5);
	param_00 playsound("saved_from_dog");
}

//Function Number: 70
player_gets_weapons_back()
{
	self endon("death");
	self showviewmodel();
	self enableweapons();
}

//Function Number: 71
playerview_endsequence(param_00)
{
	param_00 showhud();
	if(isalive(param_00))
	{
		self clearanim(%player_view_dog_knockdown,0.1);
		if(isdefined(self.necksnapped))
		{
			self setflaggedanimrestart("viewanim",%player_view_dog_knockdown_neck_snap,1,0.2,1);
			if(isdefined(self.playerdrone))
			{
				self.playerdrone playerdone_anim_neck_snap();
			}
		}
		else if(isdefined(param_00.dog_downed_player))
		{
			self setflaggedanimknobrestart("viewanim",%player_view_dog_knockdown_laststand,1,0.1,1);
			if(isdefined(self.playerdrone))
			{
				self.playerdrone playerdone_anim_laststand();
			}
		}
		else
		{
			thread savednotify(param_00);
			self setflaggedanimrestart("viewanim",%player_view_dog_knockdown_saved);
			if(isdefined(self.playerdrone))
			{
				self.playerdrone playerdone_anim_saved();
			}
		}

		if(!isdefined(param_00.dog_downed_player))
		{
			param_00 maps\_utility::delaythread(2.5,::player_gets_weapons_back);
			animscripts\shared::donotetracks("viewanim");
			param_00 notify("player_saved_from_dog");
		}
		else
		{
			animscripts\shared::donotetracks("viewanim");
			param_00 notify("deathshield",1000000,self.dog);
			param_00 showviewmodel();
		}

		playerview_unlinkplayeranddelete(param_00);
	}
	else
	{
		setsaveddvar("compass",0);
	}

	param_00.syncedmeleetarget = undefined;
	param_00.dog_downed_player = undefined;
	restoreplayercontrols(param_00);
}

//Function Number: 72
playerview_unlinkplayeranddelete(param_00)
{
	param_00 show();
	param_00 unlink();
	param_00 setorigin(self.origin);
	param_00 setplayerangles(self.startangles);
	param_00 setcandamage(1);
	var_01 = param_00.player_view;
	if(isdefined(var_01))
	{
		if(isdefined(var_01.playerdrone))
		{
			var_01.playerdrone delete();
		}

		var_01 delete();
		param_00.player_view = undefined;
	}
}

//Function Number: 73
restoreplayercontrols(param_00)
{
	param_00 allowlean(1);
	param_00 allowcrouch(1);
	param_00 allowprone(1);
	param_00 freezecontrols(0);
	param_00.attacked_by_dog = undefined;
}

//Function Number: 74
playerview_show(param_00)
{
	self showonclient(param_00);
	if(maps\_utility::is_coop())
	{
		var_01 = playerdrone_create(param_00);
		var_01 linkto(self,"tag_origin",(0,0,0),(0,0,0));
		var_01 thread playerdrone_anim_knockdown(1);
		self.playerdrone = var_01;
		if(level.player == param_00 && isdefined(level.player2))
		{
			param_00 hideonclient(level.player2);
			var_01 hideonclient(level.player);
		}
		else
		{
			param_00 hideonclient(level.player);
			var_01 hideonclient(level.player2);
		}
	}

	param_00 hideviewmodel();
	param_00 disableweapons();
}

//Function Number: 75
playerview_playknockdownanimlimited(param_00)
{
	self setflaggedanimlimited("viewanim",%player_view_dog_knockdown,1,0.2,param_00);
	self setflaggedanimlimited("viewanim",%player_view_dog_knockdown_late,1,0.2,param_00);
	if(isdefined(self.playerdrone))
	{
		self.playerdrone playerdrone_anim_knockdown(param_00);
	}
}

//Function Number: 76
playerview_playknockdownanim(param_00)
{
	self setflaggedanimlimited("viewanim",%player_view_dog_knockdown,1,0.2,param_00);
	self setflaggedanimlimited("viewanim",%player_view_dog_knockdown_late,1,0.2,param_00);
	if(isdefined(self.playerdrone))
	{
		self.playerdrone playerdrone_anim_knockdown(param_00);
	}
}

//Function Number: 77
playerview_playmissanim(param_00)
{
	self setflaggedanimknobrestart("viewanim",%player_view_dog_knockdown_neck_miss,1,0.2,param_00);
}

//Function Number: 78
playerview_knockdownlate()
{
	self setanimlimited(%knockdown,0.01,0.2,1);
	self setanimlimited(%knockdown_late,1,0.2,1);
}

//Function Number: 79
dog_vs_player_anim_rate()
{
	return 1;
}

//Function Number: 80
is_hyena()
{
	if(issubstr(self.classname,"hyena"))
	{
		return 1;
	}

	return 0;
}

//Function Number: 81
ragdoll_corpses()
{
	wait(0.1);
	var_00 = getcorpsearray();
	foreach(var_02 in var_00)
	{
		if(var_02 isragdoll() == 0)
		{
			var_02 startragdoll();
		}
	}
}

//Function Number: 82
handlevxnotetrack(param_00)
{
	if(common_scripts\utility::string_starts_with(param_00,"vfx"))
	{
		if(isdefined(level._effect[param_00]))
		{
			playfxontag(common_scripts\utility::getfx(param_00),self,"TAG_MOUTH_FX");
			return;
		}

		return;
	}

	if(common_scripts\utility::string_starts_with(param_00,"screen_blood"))
	{
		if(isdefined(self.controlling_dog))
		{
			var_01 = "bottom";
			if(issubstr(param_00,"right"))
			{
				var_01 = "right";
			}
			else if(issubstr(param_00,"left"))
			{
				var_01 = "left";
			}

			self notify("screen_blood",var_01);
			return;
		}
	}
}