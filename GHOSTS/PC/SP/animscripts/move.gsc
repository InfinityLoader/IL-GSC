/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\move.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 40
 * Decompile Time: 721 ms
 * Timestamp: 10/27/2023 1:24:09 AM
*******************************************************************/

//Function Number: 1
func_450A()
{
	var_00 = [];
	var_00["fire"] = %exposed_shoot_auto_v3;
	var_00["single"] = [%exposed_shoot_semi1];
	var_00["single_shotgun"] = [%shotgun_stand_fire_1a,%shotgun_stand_fire_1b];
	var_00["burst2"] = %exposed_shoot_burst3;
	var_00["burst3"] = %exposed_shoot_burst3;
	var_00["burst4"] = %exposed_shoot_burst4;
	var_00["burst5"] = %exposed_shoot_burst5;
	var_00["burst6"] = %exposed_shoot_burst6;
	var_00["semi2"] = %exposed_shoot_semi2;
	var_00["semi3"] = %exposed_shoot_semi3;
	var_00["semi4"] = %exposed_shoot_semi4;
	var_00["semi5"] = %exposed_shoot_semi5;
	level.archetypes["soldier"]["shoot_while_moving"] = var_00;
	var_00 = [];
	var_00["shuffle_start_from_cover_left"] = %cornercrl_alert_2_shuffle;
	var_00["shuffle_start_from_cover_right"] = %cornercrr_alert_2_shuffle;
	var_00["shuffle_start_left"] = %covercrouch_hide_2_shufflel;
	var_00["shuffle_start_right"] = %covercrouch_hide_2_shuffler;
	var_00["shuffle_to_cover_left"] = %covercrouch_shufflel;
	var_00["shuffle_end_to_cover_left"] = %cornercrl_shuffle_2_alert;
	var_00["shuffle_to_cover_right"] = %covercrouch_shuffler;
	var_00["shuffle_end_to_cover_right"] = %cornercrr_shuffle_2_alert;
	var_00["shuffle_start_left_stand_to_stand"] = %coverstand_hide_2_shufflel;
	var_00["shuffle_left_stand_to_stand"] = %coverstand_shufflel;
	var_00["shuffle_end_left_stand_to_stand"] = %coverstand_shufflel_2_hide;
	var_00["shuffle_start_right_stand_to_stand"] = %coverstand_hide_2_shuffler;
	var_00["shuffle_right_stand_to_stand"] = %coverstand_shuffler;
	var_00["shuffle_end_right_stand_to_stand"] = %coverstand_shuffler_2_hide;
	var_00["shuffle_to_left_crouch"] = %covercrouch_shufflel;
	var_00["shuffle_end_to_left_stand"] = %coverstand_shufflel_2_hide;
	var_00["shuffle_end_to_left_crouch"] = %covercrouch_shufflel_2_hide;
	var_00["shuffle_to_right_crouch"] = %covercrouch_shuffler;
	var_00["shuffle_end_to_right_stand"] = %coverstand_shuffler_2_hide;
	var_00["shuffle_end_to_right_crouch"] = %covercrouch_shuffler_2_hide;
	level.archetypes["soldier"]["shuffle"] = var_00;
}

//Function Number: 2
func_4FDD()
{
	if(isdefined(self.var_2214))
	{
		if(isdefined(self.var_2214["move"]))
		{
			[[ self.var_2214["move"] ]]();
		}
	}

	self endon("killanimscript");
	[[ self.exception["move"] ]]();
	func_547D();
	func_3C60();
	animscripts/utility::func_4622("move");
	var_00 = func_8C4B();
	if(var_00 && isdefined(self.var_752E))
	{
		func_5475();
		func_5478();
	}
	else if(isdefined(self.battlechatter) && self.battlechatter)
	{
		movestartbattlechatter(var_00);
		animscripts/battlechatter::func_5D4E();
	}

	thread func_8736();
	var_01 = ::func_5B30;
	if(isdefined(self.var_5B2F))
	{
		var_01 = self.var_5B2F;
	}

	self thread [[ var_01 ]]();
	thread func_0DF6();
	animscripts/exit_node::func_7AE5();
	self.doingreacquirestep = undefined;
	self.var_4410 = undefined;
	thread func_7AF7();
	func_4E66();
	self.var_742D = undefined;
	self.aim_while_moving_thread = undefined;
	self.var_6995 = undefined;
	func_5482(1);
}

//Function Number: 3
end_script()
{
	if(isdefined(self.var_58C1))
	{
		self.grenadeweapon = self.var_58C1;
		self.var_58C1 = undefined;
	}

	self.teamflashbangimmunity = undefined;
	self.var_5282 = undefined;
	self.var_4410 = undefined;
	self.var_752E = undefined;
	self.var_7530 = undefined;
	self.var_6995 = undefined;
	self.var_63B5 = undefined;
	self.var_65CD = undefined;
	self.currentdodgeanim = undefined;
	self.var_5480 = undefined;
	animscripts/run::func_70C6(0);
	if(self.swimmer)
	{
		animscripts/swim::swim_moveend();
	}

	self clearanim(%head,0.2);
	self.facialidx = undefined;
}

//Function Number: 4
func_547D()
{
	self.var_63B5 = undefined;
	self.var_65CD = undefined;
	self.var_868B = undefined;
	self.var_868C = undefined;
	self.var_6999 = 0;
	self.arrivalstartdist = undefined;
}

//Function Number: 5
func_3C60()
{
	if(self.a.var_60B1 == "prone")
	{
		var_00 = animscripts/utility::choosepose("stand");
		if(var_00 != "prone")
		{
			self orientmode("face current");
			self animmode("zonly_physics",0);
			var_01 = 1;
			if(isdefined(self.grenade))
			{
				var_01 = 2;
			}

			animscripts/cover_prone::func_6204(var_00,var_01);
			self animmode("none",0);
			self orientmode("face default");
		}
	}
}

//Function Number: 6
func_8C4B()
{
	switch(self.prevscript)
	{
		case "concealment_stand":
		case "concealment_prone":
		case "concealment_crouch":
		case "cover_wide_right":
		case "cover_wide_left":
		case "cover_swim_right":
		case "cover_swim_left":
		case "cover_prone":
		case "cover_left":
		case "cover_stand":
		case "turret":
		case "cover_crouch":
		case "hide":
		case "cover_multi":
		case "cover_right":
			return 1;
	}

	return 0;
}

//Function Number: 7
movestartbattlechatter(param_00)
{
	if(self.movemode == "run")
	{
		animscripts/battlechatter_ai::func_2FE6(param_00);
	}
}

//Function Number: 8
func_5482(param_00)
{
	func_5483(param_00);
	self notify("abort_reload");
}

//Function Number: 9
archetypechanged()
{
	if(isdefined(self.var_DC4) && self.var_DC4 != self.var_6171)
	{
		return 1;
	}
	else if(!isdefined(self.var_DC4) && self.var_6171 != "none")
	{
		return 1;
	}

	return 0;
}

//Function Number: 10
func_8706(param_00)
{
	if(param_00 != self.var_6172 || archetypechanged())
	{
		if(isdefined(self.custommoveanimset) && isdefined(self.custommoveanimset[param_00]))
		{
			self.a.var_5473 = self.custommoveanimset[param_00];
		}
		else
		{
			self.a.var_5473 = animscripts/utility::func_4F5D(param_00);
			if((self.combatmode == "ambush" || self.combatmode == "ambush_nodes_only") && isdefined(self.pathgoalpos) && distancesquared(self.origin,self.pathgoalpos) > squared(100))
			{
				self.sidesteprate = 1;
				animscripts/animset::func_6E2E();
			}
			else
			{
				self.sidesteprate = 1.35;
			}
		}

		self.var_6172 = param_00;
		if(isdefined(self.var_DC4))
		{
			self.var_6171 = self.var_DC4;
		}
	}
}

//Function Number: 11
func_5483(param_00)
{
	self endon("killanimscript");
	self endon("move_interrupt");
	var_01 = self getanimtime(%walk_and_run_loops);
	self.a.var_698E = randomint(10000);
	self.var_6172 = "none";
	self.var_6171 = "none";
	self.var_547F = undefined;
	for(;;)
	{
		var_02 = self getanimtime(%walk_and_run_loops);
		if(var_02 < var_01)
		{
			self.a.var_698E++;
		}

		var_01 = var_02;
		func_8706(self.movemode);
		if(isdefined(self.var_5485))
		{
			self [[ self.var_5485 ]](self.movemode);
		}
		else
		{
			func_5484(self.movemode);
		}

		if(isdefined(self.var_547F))
		{
			self [[ self.var_547F ]]();
			self.var_547F = undefined;
		}

		self notify("abort_reload");
	}
}

//Function Number: 12
func_5484(param_00)
{
	self endon("move_loop_restart");
	animscripts/face::func_7053(level.alertface);
	if(isdefined(self.var_5480))
	{
		self [[ self.var_5480 ]]();
	}
	else if(animscripts/utility::func_74A5())
	{
		animscripts/cqb::func_5479();
	}
	else if(self.swimmer)
	{
		animscripts/swim::moveswim();
	}
	else if(param_00 == "run")
	{
		animscripts/run::moverun();
	}
	else
	{
		animscripts/walk::func_54C5();
	}

	self.var_65CD = undefined;
}

//Function Number: 13
func_5127()
{
	if(self.weapon == "none")
	{
		return 0;
	}

	var_00 = weaponclass(self.weapon);
	if(!animscripts/utility::usingriflelikeweapon())
	{
		return 0;
	}

	if(animscripts/combat_utility::issniper())
	{
		if(!animscripts/utility::func_48A0() && self.facemotion)
		{
			return 0;
		}
	}

	if(isdefined(self.dontshootwhilemoving))
	{
		return 0;
	}

	return 1;
}

//Function Number: 14
func_7451()
{
	self endon("killanimscript");
	self notify("doing_shootWhileMoving");
	self endon("doing_shootWhileMoving");
	var_00 = animscripts/utility::func_4F5D("shoot_while_moving");
	foreach(var_03, var_02 in var_00)
	{
		self.a.var_ED8[var_03] = var_02;
	}

	if(isdefined(self.var_1E61) && isdefined(self.var_1E61["fire"]))
	{
		self.a.var_ED8["fire"] = self.var_1E61["fire"];
	}

	if(isdefined(self.weapon) && animscripts/utility::func_8D9B())
	{
		self.a.var_ED8["single"] = animscripts/utility::lookupanim("shotgun_stand","single");
	}

	for(;;)
	{
		if(!self.bulletsinclip)
		{
			if(animscripts/utility::iscqbwalkingorfacingenemy())
			{
				self.ammocheattime = 0;
				animscripts/combat_utility::cheatammoifnecessary();
			}

			if(!self.bulletsinclip)
			{
				wait(0.5);
				continue;
			}
		}

		animscripts/combat_utility::func_744D();
		self clearanim(%exposed_aiming,0.2);
	}
}

//Function Number: 15
func_7AF7()
{
	self endon("killanimscript");
	wait(0.05);
	thread bulletwhizbycheck_whilemoving();
	thread func_519A();
	thread animscripts/door::indoorcqbtogglecheck();
	thread animscripts/door::func_29F0();
}

//Function Number: 16
func_8736()
{
	self endon("killanimscript");
	self.prevstairsstate = self.stairsstate;
	for(;;)
	{
		wait(0.05);
		if(self.prevstairsstate != self.stairsstate)
		{
			if(!isdefined(self.var_4410) || self.stairsstate != "none")
			{
				self notify("move_loop_restart");
			}
		}

		self.prevstairsstate = self.stairsstate;
	}
}

//Function Number: 17
func_6645(param_00)
{
	self endon("killanimscript");
	if(!param_00)
	{
		animscripts/exit_node::func_7AE5();
	}

	self.var_4410 = undefined;
	self clearanim(%root,0.1);
	self orientmode("face default");
	self animmode("none",0);
	self.requestarrivalnotify = 1;
	func_5482(!param_00);
}

//Function Number: 18
func_5B30()
{
	self endon("killanimscript");
	self endon("move_interrupt");
	self.var_4410 = 1;
	for(;;)
	{
		self waittill("path_changed",var_00,var_01);
		if(isdefined(self.var_4410) || isdefined(self.var_5739))
		{
			continue;
		}

		if(!self.facemotion || abs(self getmotionangle()) > 15)
		{
			continue;
		}

		if(self.a.var_60B1 != "stand")
		{
			continue;
		}

		self notify("stop_move_anim_update");
		self.var_868B = undefined;
		var_02 = vectortoangles(var_01);
		var_03 = angleclamp180(self.angles[1] - var_02[1]);
		var_04 = angleclamp180(self.angles[0] - var_02[0]);
		var_05 = func_5B2E(var_03,var_04);
		if(isdefined(var_05))
		{
			self.var_84B4 = var_05;
			self.var_84BD = gettime();
			self.var_5480 = ::func_5B2D;
			self notify("move_loop_restart");
			animscripts/run::func_2D51();
		}
	}
}

//Function Number: 19
func_5B2E(param_00,param_01)
{
	if(isdefined(self.var_5B39))
	{
		return [[ self.var_5B39 ]](param_00,param_01);
	}

	var_02 = undefined;
	var_03 = undefined;
	if(self.swimmer)
	{
		var_04 = animscripts/swim::func_3C1D("turn");
	}
	else if(self.movemode == "walk")
	{
		var_04 = animscripts/utility::func_4F5D("cqb_turn");
	}
	else if(animscripts/utility::func_74A5())
	{
		var_04 = animscripts/utility::func_4F5D("cqb_run_turn");
	}
	else
	{
		var_04 = animscripts/utility::func_4F5D("run_turn");
	}

	if(param_00 < 0)
	{
		if(param_00 > -45)
		{
			var_05 = 3;
		}
		else
		{
			var_05 = int(ceil(param_01 + 180 - 10 / 45));
		}
	}
	else if(param_01 < 45)
	{
		var_05 = 5;
	}
	else
	{
		var_05 = int(floor(param_01 + 180 + 10 / 45));
	}

	var_02 = var_04[var_05];
	if(isdefined(var_02))
	{
		if(isarray(var_02))
		{
			while(var_02.size > 0)
			{
				var_06 = randomint(var_02.size);
				if(func_5B2B(var_02[var_06]))
				{
					return var_02[var_06];
				}

				var_02[var_06] = var_02[var_02.size - 1];
				var_02[var_02.size - 1] = undefined;
			}
		}
		else if(func_5B2B(var_02))
		{
			return var_02;
		}
	}

	var_07 = -1;
	if(param_00 < -60)
	{
		var_07 = int(ceil(param_00 + 180 / 45));
		if(var_07 == var_05)
		{
			var_07 = var_05 - 1;
		}
	}
	else if(param_00 > 60)
	{
		var_07 = int(floor(param_00 + 180 / 45));
		if(var_07 == var_05)
		{
			var_07 = var_05 + 1;
		}
	}

	if(var_07 >= 0 && var_07 < 9)
	{
		var_03 = var_04[var_07];
	}

	if(isdefined(var_03))
	{
		if(isarray(var_03))
		{
			var_03 = var_03[0];
		}

		if(func_5B2B(var_03))
		{
			return var_03;
		}
	}

	return undefined;
}

//Function Number: 20
func_5B2B(param_00)
{
	if(!isdefined(self.pathgoalpos))
	{
		return 0;
	}

	var_01 = getnotetracktimes(param_00,"code_move");
	var_02 = var_01[0];
	var_03 = getmovedelta(param_00,0,var_02);
	var_04 = self localtoworldcoords(var_03);
	if(isdefined(self.arrivalstartdist) && squared(self.arrivalstartdist) > distancesquared(self.pathgoalpos,var_04))
	{
		return 0;
	}

	var_03 = getmovedelta(param_00,0,1);
	var_05 = self localtoworldcoords(var_03);
	var_05 = var_04 + vectornormalize(var_05 - var_04) * 20;
	var_06 = !self.swimmer;
	return self maymovefrompointtopoint(var_04,var_05,var_06,1);
}

//Function Number: 21
func_5B2D()
{
	self endon("killanimscript");
	self.var_5480 = undefined;
	var_00 = self.var_84B4;
	if(gettime() > self.var_84BD + 50)
	{
	}

	if(self.swimmer)
	{
		self animmode("nogravity",0);
	}
	else
	{
		self animmode("zonly_physics",0);
	}

	var_01 = 0.1;
	if(isdefined(self.var_5B38))
	{
		var_01 = self.var_5B38;
	}

	self clearanim(%body,var_01);
	self.var_547F = ::func_5B2C;
	self.var_4410 = 1;
	var_01 = 0.05;
	if(isdefined(self.var_5B38))
	{
		var_01 = self.var_5B38;
	}

	self setflaggedanimrestart("turnAnim",var_00,1,var_01,self.moveplaybackrate);
	if(animscripts/utility::func_4965())
	{
		self orientmode("face angle 3d",self.angles);
	}
	else
	{
		self orientmode("face angle",self.angles[1]);
	}

	animscripts/shared::func_2986("turnAnim");
	self.var_4410 = undefined;
	self orientmode("face motion");
	self animmode("none",0);
	animscripts/shared::func_2986("turnAnim");
}

//Function Number: 22
func_5B2C()
{
	self.var_4410 = undefined;
	self orientmode("face default");
	self clearanim(%root,0.1);
	self animmode("none",0);
	if(self.swimmer)
	{
		animscripts/swim::func_7DCE();
	}
}

//Function Number: 23
dodgemoveloopoverride()
{
	self pushplayer(1);
	self animmode("zonly_physics",0);
	self clearanim(%body,0.2);
	self setflaggedanimrestart("dodgeAnim",self.currentdodgeanim,1,0.2,1);
	animscripts/shared::func_2986("dodgeAnim");
	self animmode("none",0);
	self orientmode("face default");
	if(animhasnotetrack(self.currentdodgeanim,"code_move"))
	{
		animscripts/shared::func_2986("dodgeAnim");
	}

	self clearanim(%civilian_dodge,0.2);
	self pushplayer(0);
	self.currentdodgeanim = undefined;
	self.var_5480 = undefined;
	return 1;
}

//Function Number: 24
func_83FC(param_00,param_01)
{
	var_02 = (self.lookaheaddir[1],-1 * self.lookaheaddir[0],0);
	var_03 = self.lookaheaddir * param_01[0];
	var_04 = var_02 * param_01[1];
	var_05 = self.origin + var_03 - var_04;
	self pushplayer(1);
	if(self maymovetopoint(var_05))
	{
		self.currentdodgeanim = param_00;
		self.var_5480 = ::dodgemoveloopoverride;
		self notify("move_loop_restart");
		return 1;
	}

	self pushplayer(0);
	return 0;
}

//Function Number: 25
func_0DF6()
{
	if(!isdefined(self.var_2866) || !isdefined(self.var_286A))
	{
	}

	self endon("killanimscript");
	self endon("move_interrupt");
	for(;;)
	{
		self waittill("path_need_dodge",var_00,var_01);
		animscripts/utility::func_86F6();
		if(animscripts/utility::func_48DE())
		{
			self.nododgemove = 0;
		}

		if(!issentient(var_00))
		{
			continue;
		}

		var_02 = vectornormalize(var_01 - self.origin);
		if(self.lookaheaddir[0] * var_02[1] - var_02[0] * self.lookaheaddir[1] > 0)
		{
			if(!func_83FC(self.var_286A,self.dodgerightanimoffset))
			{
				func_83FC(self.var_2866,self.var_2867);
			}
		}
		else if(!func_83FC(self.var_2866,self.var_2867))
		{
			func_83FC(self.var_286A,self.dodgerightanimoffset);
		}

		if(isdefined(self.currentdodgeanim))
		{
			wait(getanimlength(self.currentdodgeanim));
			continue;
		}

		wait(0.1);
	}
}

//Function Number: 26
func_701E(param_00,param_01)
{
	self.nododgemove = 1;
	self.var_2866 = param_00;
	self.var_286A = param_01;
	var_02 = 1;
	if(animhasnotetrack(param_00,"code_move"))
	{
		var_02 = getnotetracktimes(param_00,"code_move")[0];
	}

	self.var_2867 = getmovedelta(param_00,0,var_02);
	var_02 = 1;
	if(animhasnotetrack(param_01,"code_move"))
	{
		var_02 = getnotetracktimes(param_01,"code_move")[0];
	}

	self.dodgerightanimoffset = getmovedelta(param_01,0,var_02);
	self.interval = 80;
}

//Function Number: 27
cleardodgeanims()
{
	self.nododgemove = 0;
	self.var_2866 = undefined;
	self.var_286A = undefined;
	self.var_2867 = undefined;
	self.dodgerightanimoffset = undefined;
}

//Function Number: 28
func_519A()
{
	self endon("killanimscript");
	for(;;)
	{
		if(isdefined(self.enemy) && isai(self.enemy) || isdefined(self.meleeplayerwhilemoving))
		{
			if(abs(self getmotionangle()) <= 135)
			{
				animscripts/melee::func_5192();
			}
		}

		wait(0.1);
	}
}

//Function Number: 29
bulletwhizbycheck_whilemoving()
{
	self endon("killanimscript");
	if(isdefined(self.var_279D))
	{
	}

	for(;;)
	{
		self waittill("bulletwhizby",var_00);
		if(self.movemode != "run" || !self.facemotion || self.a.var_60B1 != "stand" || isdefined(self.var_63B5))
		{
			continue;
		}

		if(self.stairsstate != "none")
		{
			continue;
		}

		if(!isdefined(self.enemy) && !self.ignoreall && isdefined(var_00.team) && isenemyteam(self.team,var_00.team))
		{
			self.var_8DE9 = var_00;
			self animcustom(::animscripts/reactions::bulletwhizbyreaction);
			continue;
		}

		if(self.lookaheadhitsstairs || self.lookaheaddist < 100)
		{
			continue;
		}

		if(isdefined(self.pathgoalpos) && distancesquared(self.origin,self.pathgoalpos) < 10000)
		{
			wait(0.2);
			continue;
		}

		self.var_65CD = gettime();
		self notify("move_loop_restart");
		animscripts/run::func_2D51();
	}
}

//Function Number: 30
get_shuffle_to_corner_start_anim(param_00,param_01)
{
	var_02 = param_01.type;
	if(var_02 == "Cover Multi")
	{
		var_02 = animscripts/utility::getcovermultipretendtype(param_01);
	}

	if(var_02 == "Cover Left")
	{
		return animscripts/utility::lookupanim("shuffle","shuffle_start_from_cover_left");
	}

	if(var_02 == "Cover Right")
	{
		return animscripts/utility::lookupanim("shuffle","shuffle_start_from_cover_right");
	}

	if(param_00)
	{
		return animscripts/utility::lookupanim("shuffle","shuffle_start_left");
	}

	return animscripts/utility::lookupanim("shuffle","shuffle_start_right");
}

//Function Number: 31
func_71C6(param_00,param_01,param_02)
{
	var_03 = [];
	var_04 = param_02.type;
	if(var_04 == "Cover Multi")
	{
		var_04 = animscripts/utility::getcovermultipretendtype(param_02);
	}

	if(var_04 == "Cover Left")
	{
		var_03["shuffle_start"] = get_shuffle_to_corner_start_anim(param_00,param_01);
		var_03["shuffle"] = animscripts/utility::lookupanim("shuffle","shuffle_to_cover_left");
		var_03["shuffle_end"] = animscripts/utility::lookupanim("shuffle","shuffle_end_to_cover_left");
	}
	else if(var_04 == "Cover Right")
	{
		var_03["shuffle_start"] = get_shuffle_to_corner_start_anim(param_00,param_01);
		var_03["shuffle"] = animscripts/utility::lookupanim("shuffle","shuffle_to_cover_right");
		var_03["shuffle_end"] = animscripts/utility::lookupanim("shuffle","shuffle_end_to_cover_right");
	}
	else if(var_04 == "Cover Stand" && param_01.type == var_04)
	{
		if(param_00)
		{
			var_03["shuffle_start"] = animscripts/utility::lookupanim("shuffle","shuffle_start_left_stand_to_stand");
			var_03["shuffle"] = animscripts/utility::lookupanim("shuffle","shuffle_left_stand_to_stand");
			var_03["shuffle_end"] = animscripts/utility::lookupanim("shuffle","shuffle_end_left_stand_to_stand");
		}
		else
		{
			var_03["shuffle_start"] = animscripts/utility::lookupanim("shuffle","shuffle_start_right_stand_to_stand");
			var_03["shuffle"] = animscripts/utility::lookupanim("shuffle","shuffle_right_stand_to_stand");
			var_03["shuffle_end"] = animscripts/utility::lookupanim("shuffle","shuffle_end_right_stand_to_stand");
		}
	}
	else if(param_00)
	{
		var_03["shuffle_start"] = get_shuffle_to_corner_start_anim(param_00,param_01);
		var_03["shuffle"] = animscripts/utility::lookupanim("shuffle","shuffle_to_left_crouch");
		if(var_04 == "Cover Stand")
		{
			var_03["shuffle_end"] = animscripts/utility::lookupanim("shuffle","shuffle_end_to_left_stand");
		}
		else
		{
			var_03["shuffle_end"] = animscripts/utility::lookupanim("shuffle","shuffle_end_to_left_crouch");
		}
	}
	else
	{
		var_03["shuffle_start"] = get_shuffle_to_corner_start_anim(param_00,param_01);
		var_03["shuffle"] = animscripts/utility::lookupanim("shuffle","shuffle_to_right_crouch");
		if(var_04 == "Cover Stand")
		{
			var_03["shuffle_end"] = animscripts/utility::lookupanim("shuffle","shuffle_end_to_right_stand");
		}
		else
		{
			var_03["shuffle_end"] = animscripts/utility::lookupanim("shuffle","shuffle_end_to_right_crouch");
		}
	}

	self.a.var_ED8 = var_03;
}

//Function Number: 32
movecovertocover_checkstartpose(param_00,param_01)
{
	if(self.a.var_60B1 == "stand" && param_01.type != "Cover Stand" || param_00.type != "Cover Stand")
	{
		self.a.var_60B1 = "crouch";
		return 0;
	}

	return 1;
}

//Function Number: 33
func_5476(param_00)
{
	if(self.a.var_60B1 == "crouch" && param_00.type == "Cover Stand")
	{
		self.a.var_60B1 = "stand";
		return 0;
	}

	return 1;
}

//Function Number: 34
func_5475()
{
	self endon("killanimscript");
	self endon("goal_changed");
	var_00 = self.var_7530;
	self.var_752E = undefined;
	self.var_7530 = undefined;
	self.var_752F = 1;
	if(!isdefined(self.prevnode))
	{
	}

	if(!isdefined(self.node) || !isdefined(var_00) || self.node != var_00)
	{
	}

	var_01 = self.prevnode;
	var_02 = self.node;
	var_03 = var_02.origin - self.origin;
	if(lengthsquared(var_03) < 1)
	{
	}

	var_03 = vectornormalize(var_03);
	var_04 = anglestoforward(var_02.angles);
	var_05 = var_04[0] * var_03[1] - var_04[1] * var_03[0] > 0;
	if(func_547B(var_05,var_01,var_02))
	{
	}

	if(movecovertocover_checkstartpose(var_01,var_02))
	{
		var_06 = 0.1;
	}
	else
	{
		var_06 = 0.4;
	}

	func_71C6(var_05,var_01,var_02);
	self animmode("zonly_physics",0);
	self clearanim(%body,var_06);
	var_07 = animscripts/utility::animarray("shuffle_start");
	var_08 = animscripts/utility::animarray("shuffle");
	var_09 = animscripts/utility::animarray("shuffle_end");
	if(animhasnotetrack(var_07,"finish"))
	{
		var_0A = getnotetracktimes(var_07,"finish")[0];
	}
	else
	{
		var_0A = 1;
	}

	var_0B = length(getmovedelta(var_07,0,var_0A));
	var_0C = length(getmovedelta(var_08,0,1));
	var_0D = length(getmovedelta(var_09,0,1));
	var_0E = distance(self.origin,var_02.origin);
	if(var_0E > var_0B)
	{
		self orientmode("face angle",animscripts/utility::getnodeforwardyaw(var_01));
		self setflaggedanimrestart("shuffle_start",var_07,1,var_06);
		animscripts/shared::func_2986("shuffle_start");
		self clearanim(var_07,0.2);
		var_0E = var_0E - var_0B;
		var_06 = 0.2;
	}
	else
	{
		self orientmode("face angle",var_02.angles[1]);
	}

	var_0F = 0;
	if(var_0E > var_0D)
	{
		var_0F = 1;
		var_0E = var_0E - var_0D;
	}

	var_10 = getanimlength(var_08);
	var_11 = var_10 * var_0E / var_0C * 0.9;
	var_11 = floor(var_11 * 20) * 0.05;
	self setflaggedanim("shuffle",var_08,1,var_06);
	animscripts/notetracks::donotetracksfortime(var_11,"shuffle");
	for(var_12 = 0;var_12 < 2;var_12++)
	{
		var_0E = distance(self.origin,var_02.origin);
		if(var_0F)
		{
			var_0E = var_0E - var_0D;
		}

		if(var_0E < 4)
		{
			break;
		}

		var_11 = var_10 * var_0E / var_0C * 0.9;
		var_11 = floor(var_11 * 20) * 0.05;
		if(var_11 < 0.05)
		{
			break;
		}

		animscripts/notetracks::donotetracksfortime(var_11,"shuffle");
	}

	if(var_0F)
	{
		if(func_5476(var_02))
		{
			var_06 = 0.2;
		}
		else
		{
			var_06 = 0.4;
		}

		self clearanim(var_08,var_06);
		self setflaggedanim("shuffle_end",var_09,1,var_06);
		animscripts/shared::func_2986("shuffle_end");
	}

	self safeteleport(var_02.origin);
	self animmode("normal");
	self.var_752F = undefined;
}

//Function Number: 35
func_5478()
{
	if(isdefined(self.var_752F))
	{
		self clearanim(%cover_shuffle,0.2);
		self.var_752F = undefined;
		self animmode("none",0);
		self orientmode("face default");
	}

	wait(0.2);
	self clearanim(%cover_shuffle,0.2);
}

//Function Number: 36
func_547B(param_00,param_01,param_02)
{
	var_03 = undefined;
	if(param_01.type == "Cover Right" && param_02.type == "Cover Left" && !param_00)
	{
		var_03 = %corner_standr_door_r2l;
	}
	else if(param_01.type == "Cover Left" && param_02.type == "Cover Right" && param_00)
	{
		var_03 = %corner_standl_door_l2r;
	}

	if(!isdefined(var_03))
	{
		return 0;
	}

	self animmode("zonly_physics",0);
	self orientmode("face current");
	self setflaggedanimrestart("sideToSide",var_03,1,0.2);
	animscripts/shared::func_2986("sideToSide",::handlesidetosidenotetracks);
	var_04 = self getanimtime(var_03);
	var_05 = param_02.origin - param_01.origin;
	var_05 = vectornormalize((var_05[0],var_05[1],0));
	var_06 = getmovedelta(var_03,var_04,1);
	var_07 = param_02.origin - self.origin;
	var_07 = (var_07[0],var_07[1],0);
	var_08 = vectordot(var_07,var_05) - abs(var_06[1]);
	if(var_08 > 2)
	{
		var_09 = getnotetracktimes(var_03,"slide_end")[0];
		var_0A = var_09 - var_04 * getanimlength(var_03);
		var_0B = int(ceil(var_0A / 0.05));
		var_0C = var_05 * var_08 / var_0B;
		thread func_75E7(var_0C,var_0B);
	}

	animscripts/shared::func_2986("sideToSide");
	self safeteleport(param_02.origin);
	self animmode("none");
	self orientmode("face default");
	self.var_752F = undefined;
	wait(0.2);
	return 1;
}

//Function Number: 37
handlesidetosidenotetracks(param_00)
{
	if(param_00 == "slide_start")
	{
		return 1;
	}
}

//Function Number: 38
func_75E7(param_00,param_01)
{
	self endon("killanimscript");
	self endon("goal_changed");
	while(param_01 > 0)
	{
		self safeteleport(self.origin + param_00);
		param_01--;
		wait(0.05);
	}
}

//Function Number: 39
func_54A4(param_00,param_01)
{
	self endon("movemode");
	self clearanim(%combatrun,0.6);
	self setanimknoball(%combatrun,%body,1,0.5,self.moveplaybackrate);
	if(isdefined(self.var_65CD) && gettime() - self.var_65CD < 100 && isdefined(self.run_overridebulletreact) && randomfloat(1) < self.a.var_63C9)
	{
		animscripts/run::customrunningreacttobullets();
	}

	if(isarray(param_00))
	{
		if(isdefined(self.var_6969))
		{
			var_02 = common_scripts\utility::choose_from_weighted_array(param_00,param_01);
		}
		else
		{
			var_02 = param_01[randomint(param_01.size)];
		}
	}
	else
	{
		var_02 = param_01;
	}

	self setflaggedanimknob("moveanim",var_02,1,0.2,self.moveplaybackrate);
	animscripts/shared::func_2986("moveanim");
}

//Function Number: 40
func_4E66()
{
	thread animscripts/cover_arrival::setupapproachnode(1);
}