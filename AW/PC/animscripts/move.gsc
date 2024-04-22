/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: move.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 45
 * Decompile Time: 647 ms
 * Timestamp: 4/22/2024 2:00:39 AM
*******************************************************************/

//Function Number: 1
init_animset_default_move()
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
init_animset_smg_move()
{
	var_00 = [];
	var_00["fire"] = %smg_exposed_shoot_auto_v3;
	var_00["single"] = [%smg_exposed_shoot_semi1];
	var_00["single_shotgun"] = [%shotgun_stand_fire_1a,%shotgun_stand_fire_1b];
	var_00["burst2"] = %smg_exposed_shoot_burst3;
	var_00["burst3"] = %smg_exposed_shoot_burst3;
	var_00["burst4"] = %smg_exposed_shoot_burst4;
	var_00["burst5"] = %smg_exposed_shoot_burst5;
	var_00["burst6"] = %smg_exposed_shoot_burst6;
	var_00["semi2"] = %smg_exposed_shoot_semi2;
	var_00["semi3"] = %smg_exposed_shoot_semi3;
	var_00["semi4"] = %smg_exposed_shoot_semi4;
	var_00["semi5"] = %smg_exposed_shoot_semi5;
	level.archetypes["soldier"]["smg_shoot_while_moving"] = var_00;
}

//Function Number: 3
main()
{
	if(isdefined(self.custom_animscript))
	{
		if(isdefined(self.custom_animscript["move"]))
		{
			[[ self.custom_animscript["move"] ]]();
			return;
		}
	}

	self endon("killanimscript");
	[[ self.exception["move"] ]]();
	moveinit();
	getupifprone();
	animscripts\utility::initialize("move");
	var_00 = waspreviouslyincover();
	if(var_00 && isdefined(self.shufflemove))
	{
		movecovertocover();
		movecovertocoverfinish();
	}
	else if(isdefined(self.battlechatter) && self.battlechatter)
	{
		var_01 = var_00;
		movestartbattlechatter(var_01);
		animscripts\battlechatter::playbattlechatter();
		if(isdefined(self.team))
		{
			if(var_01)
			{
				thread maps\_dds::dds_notify("react_leave_cover",self.team != "allies");
				thread maps\_dds::dds_notify("thrt_breaking",self.team != "allies");
				thread maps\_dds::dds_notify("act_moving",self.team == "allies");
				thread maps\_dds::dds_notify("act_advancing",self.team == "allies");
			}
			else
			{
				thread maps\_dds::dds_notify("react_cover",self.team != "allies");
			}
		}
	}

	thread updatestairsstate();
	var_02 = ::pathchangelistener;
	if(isdefined(self.pathchangecheckoverridefunc))
	{
		var_02 = self.pathchangecheckoverridefunc;
	}

	self thread [[ var_02 ]]();
	thread animdodgeobstaclelistener();
	animscripts\exit_node::startmovetransition();
	self.doingreacquirestep = undefined;
	self.ignorepathchange = undefined;
	thread startthreadstorunwhilemoving();
	listenforcoverapproach();
	self.shoot_while_moving_thread = undefined;
	self.aim_while_moving_thread = undefined;
	self.runngun = undefined;
	movemainloop(1);
}

//Function Number: 4
end_script()
{
	if(isdefined(self.oldgrenadeweapon))
	{
		self.grenadeweapon = self.oldgrenadeweapon;
		self.oldgrenadeweapon = undefined;
	}

	self.teamflashbangimmunity = undefined;
	self.minindoortime = undefined;
	self.ignorepathchange = undefined;
	self.shufflemove = undefined;
	self.shufflenode = undefined;
	self.runngun = undefined;
	self.reactingtobullet = undefined;
	self.requestreacttobullet = undefined;
	self.currentdodgeanim = undefined;
	self.moveloopoverridefunc = undefined;
	animscripts\run::setshootwhilemoving(0);
	if(self.swimmer)
	{
		animscripts\swim::swim_moveend();
	}

	self clearanim(%head,0.2);
	self.facialidx = undefined;
}

//Function Number: 5
moveinit()
{
	self.reactingtobullet = undefined;
	self.requestreacttobullet = undefined;
	self.update_move_anim_type = undefined;
	self.update_move_front_bias = undefined;
	self.runngunweight = 0;
	self.arrivalstartdist = undefined;
}

//Function Number: 6
getupifprone()
{
	if(self.a.pose == "prone")
	{
		var_00 = animscripts\utility::choosepose("stand");
		if(var_00 != "prone")
		{
			self orientmode("face current");
			self animmode("zonly_physics",0);
			var_01 = 1;
			if(isdefined(self.grenade))
			{
				var_01 = 2;
			}

			animscripts\cover_prone::proneto(var_00,var_01);
			self animmode("none",0);
			self orientmode("face default");
		}
	}
}

//Function Number: 7
waspreviouslyincover()
{
	switch(self.prevscript)
	{
		case "cover_wide_right":
		case "cover_wide_left":
		case "concealment_stand":
		case "concealment_prone":
		case "concealment_crouch":
		case "cover_prone":
		case "cover_swim_right":
		case "cover_swim_left":
		case "cover_left":
		case "turret":
		case "hide":
		case "cover_multi":
		case "cover_right":
		case "cover_stand":
		case "cover_crouch":
			return 1;
	}

	return 0;
}

//Function Number: 8
movestartbattlechatter(param_00)
{
	if(self.movemode == "run")
	{
		animscripts\battlechatter_ai::evaluatemoveevent(param_00);
		maps\_dds::evaluatemoveevent(param_00);
	}
}

//Function Number: 9
movemainloop(param_00)
{
	movemainloopinternal(param_00);
	self notify("abort_reload");
}

//Function Number: 10
archetypechanged()
{
	if(isdefined(self.animarchetype) && self.animarchetype != self.prevmovearchetype)
	{
		return 1;
	}
	else if(!isdefined(self.animarchetype) && self.prevmovearchetype != "none")
	{
		return 1;
	}

	return 0;
}

//Function Number: 11
updatemovemode(param_00)
{
	if(param_00 != self.prevmovemode || archetypechanged())
	{
		if(isdefined(self.custommoveanimset) && isdefined(self.custommoveanimset[param_00]))
		{
			self.a.moveanimset = self.custommoveanimset[param_00];
		}
		else
		{
			self.a.moveanimset = animscripts\utility::lookupanimarray(param_00);
			if((self.combatmode == "ambush" || self.combatmode == "ambush_nodes_only") && isdefined(self.pathgoalpos) && distancesquared(self.origin,self.pathgoalpos) > squared(100))
			{
				self.sidesteprate = 1;
				animscripts\animset::set_ambush_sidestep_anims();
			}
			else
			{
				self.sidesteprate = 1.35;
			}
		}

		self.prevmovemode = param_00;
		if(isdefined(self.animarchetype))
		{
			self.prevmovearchetype = self.animarchetype;
		}
	}
}

//Function Number: 12
movemainloopinternal(param_00)
{
	self endon("killanimscript");
	self endon("move_interrupt");
	var_01 = self getanimtime(%walk_and_run_loops);
	self.a.runloopcount = randomint(10000);
	self.prevmovemode = "none";
	self.prevmovearchetype = "none";
	self.moveloopcleanupfunc = undefined;
	for(;;)
	{
		var_02 = self getanimtime(%walk_and_run_loops);
		if(var_02 < var_01)
		{
			self.a.runloopcount++;
		}

		var_01 = var_02;
		updatemovemode(self.movemode);
		if(isdefined(self.movemainloopprocessoverridefunc))
		{
			self [[ self.movemainloopprocessoverridefunc ]](self.movemode);
		}
		else
		{
			movemainloopprocess(self.movemode);
		}

		if(isdefined(self.moveloopcleanupfunc))
		{
			self [[ self.moveloopcleanupfunc ]]();
			self.moveloopcleanupfunc = undefined;
		}

		self notify("abort_reload");
	}
}

//Function Number: 13
register_pluggable_move_loop_override(param_00)
{
	self.pluggable_move_loop_override_function = param_00;
}

//Function Number: 14
clear_pluggable_move_loop_override()
{
	self.pluggable_move_loop_override_function = undefined;
}

//Function Number: 15
movemainloopprocess(param_00)
{
	self endon("move_loop_restart");
	animscripts\face::setidlefacedelayed(level.alertface);
	if(isdefined(self.moveloopoverridefunc))
	{
		self [[ self.moveloopoverridefunc ]]();
	}
	else if(isdefined(self.pluggable_move_loop_override_function))
	{
		self [[ self.pluggable_move_loop_override_function ]]();
	}
	else if(animscripts\utility::shouldcqb())
	{
		animscripts\cqb::movecqb();
	}
	else if(self.swimmer)
	{
		animscripts\swim::moveswim();
	}
	else if(param_00 == "run")
	{
		animscripts\run::moverun();
	}
	else
	{
		animscripts\walk::movewalk();
	}

	self.requestreacttobullet = undefined;
}

//Function Number: 16
mayshootwhilemoving()
{
	if(self.weapon == "none")
	{
		return 0;
	}

	if(isdefined(self.mech) && self.mech)
	{
		if(self.movemode == "run")
		{
			return 0;
		}
	}

	var_00 = weaponclass(self.weapon);
	if(!animscripts\utility::usingriflelikeweapon())
	{
		return 0;
	}

	if(animscripts\combat_utility::issniper())
	{
		if(!animscripts\utility::iscqbwalking() && self.facemotion)
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

//Function Number: 17
shootwhilemoving()
{
	self endon("killanimscript");
	self notify("doing_shootWhileMoving");
	self endon("doing_shootWhileMoving");
	var_00 = animscripts\utility::lookupanimarray("shoot_while_moving");
	if(animscripts\utility::usingsmg())
	{
		var_00 = animscripts\utility::lookupanimarray("smg_shoot_while_moving");
	}

	if(isdefined(var_00))
	{
		foreach(var_03, var_02 in var_00)
		{
			self.a.array[var_03] = var_02;
		}
	}

	if(isdefined(self.combatstandanims) && isdefined(self.combatstandanims["fire"]))
	{
		self.a.array["fire"] = self.combatstandanims["fire"];
	}

	if(isdefined(self.weapon) && animscripts\utility::weapon_pump_action_shotgun())
	{
		self.a.array["single"] = animscripts\utility::lookupanim("shotgun_stand","single");
	}

	for(;;)
	{
		if(!self.bulletsinclip)
		{
			if(animscripts\utility::iscqbwalkingorfacingenemy())
			{
				self.ammocheattime = 0;
				animscripts\combat_utility::cheatammoifnecessary();
			}

			if(!self.bulletsinclip)
			{
				wait(0.5);
				continue;
			}
		}

		animscripts\combat_utility::shootuntilshootbehaviorchange();
		self clearanim(%exposed_aiming,0.2);
	}
}

//Function Number: 18
startthreadstorunwhilemoving()
{
	self endon("killanimscript");
	wait(0.05);
	thread bulletwhizbycheck_whilemoving();
	thread meleeattackcheck_whilemoving();
	thread animscripts\door::indoorcqbtogglecheck();
	thread animscripts\door::doorenterexitcheck();
}

//Function Number: 19
updatestairsstate()
{
	self endon("killanimscript");
	self.prevstairsstate = self.stairsstate;
	for(;;)
	{
		wait(0.05);
		if(self.prevstairsstate != self.stairsstate)
		{
			if(!isdefined(self.ignorepathchange) || self.stairsstate != "none")
			{
				self notify("move_loop_restart");
			}
		}

		self.prevstairsstate = self.stairsstate;
	}
}

//Function Number: 20
restartmoveloop(param_00)
{
	self endon("killanimscript");
	if(!param_00)
	{
		animscripts\exit_node::startmovetransition();
	}

	self.ignorepathchange = undefined;
	self clearanim(%animscript_root,0.1);
	self orientmode("face default");
	self animmode("none",0);
	self.requestarrivalnotify = 1;
	movemainloop(!param_00);
}

//Function Number: 21
pathchangelistener()
{
	self endon("killanimscript");
	self endon("move_interrupt");
	for(;;)
	{
		self waittill("path_changed",var_00,var_01,var_02);
		if(isdefined(self.ignorepathchange) || isdefined(self.noturnanims))
		{
			continue;
		}

		if(isdefined(var_00) && var_00)
		{
			continue;
		}

		if(!self.facemotion)
		{
			if(!isdefined(self.mech))
			{
				continue;
			}
		}

		if(self.a.pose != "stand")
		{
			continue;
		}

		self notify("stop_move_anim_update");
		self.update_move_anim_type = undefined;
		var_03 = vectortoangles(var_01);
		var_04 = angleclamp180(self.angles[1] - var_03[1]);
		var_05 = angleclamp180(self.angles[0] - var_03[0]);
		var_06 = pathchange_getturnanim(var_04,var_05);
		if(isdefined(var_06))
		{
			self.turnanim = var_06;
			self.turntime = gettime();
			self.moveloopoverridefunc = ::pathchange_doturnanim;
			self notify("move_loop_restart");
			animscripts\run::endfaceenemyaimtracking();
		}
	}
}

//Function Number: 22
pathchange_getturnanim(param_00,param_01)
{
	if(isdefined(self.pathturnanimoverridefunc))
	{
		return [[ self.pathturnanimoverridefunc ]](param_00,param_01);
	}

	var_02 = undefined;
	var_03 = undefined;
	if(self.swimmer)
	{
		var_04 = animscripts\swim::getswimanim("turn");
	}
	else if(animscripts\utility::isunstableground())
	{
		var_04 = animscripts\utility::lookupanimarray("unstable_run_turn");
	}
	else if(self.movemode == "walk")
	{
		var_05 = "cqb_turn";
		if((isdefined(self.animarchetype) && isdefined(level.archetypes[self.animarchetype]["walk_turn"])) || isdefined(level.archetypes["soldier"]["walk_turn"]))
		{
			var_05 = "walk_turn";
		}

		var_04 = animscripts\utility::lookupanimarray(var_05);
	}
	else if(animscripts\utility::shouldcqb())
	{
		var_04 = animscripts\utility::lookupanimarray("cqb_run_turn");
	}
	else if(animscripts\utility::usingsmg())
	{
		var_04 = animscripts\utility::lookupanimarray("smg_run_turn");
	}
	else
	{
		var_04 = animscripts\utility::lookupanimarray("run_turn");
	}

	if(param_00 < 0)
	{
		if(param_00 > -45)
		{
			var_06 = 3;
		}
		else
		{
			var_06 = int(ceil(param_01 + 180 - 10 / 45));
		}
	}
	else if(param_01 < 45)
	{
		var_06 = 5;
	}
	else
	{
		var_06 = int(floor(param_01 + 180 + 10 / 45));
	}

	var_02 = var_04[var_06];
	if(isdefined(var_02))
	{
		if(isarray(var_02))
		{
			while(var_02.size > 0)
			{
				var_07 = randomint(var_02.size);
				if(pathchange_candoturnanim(var_02[var_07]))
				{
					return var_02[var_07];
				}

				var_02[var_07] = var_02[var_02.size - 1];
				var_02[var_02.size - 1] = undefined;
			}
		}
		else if(pathchange_candoturnanim(var_02))
		{
			return var_02;
		}
	}

	var_08 = -1;
	if(param_00 < -60)
	{
		var_08 = int(ceil(param_00 + 180 / 45));
		if(var_08 == var_06)
		{
			var_08 = var_06 - 1;
		}
	}
	else if(param_00 > 60)
	{
		var_08 = int(floor(param_00 + 180 / 45));
		if(var_08 == var_06)
		{
			var_08 = var_06 + 1;
		}
	}

	if(var_08 >= 0 && var_08 < 9)
	{
		var_03 = var_04[var_08];
	}

	if(isdefined(var_03))
	{
		if(isarray(var_03))
		{
			var_03 = var_03[0];
		}

		if(pathchange_candoturnanim(var_03))
		{
			return var_03;
		}
	}

	return undefined;
}

//Function Number: 23
pathchange_candoturnanim(param_00)
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
	var_07 = self maymovefrompointtopoint(var_04,var_05,var_06,1);
	return var_07;
}

//Function Number: 24
pathchange_doturnanim()
{
	self endon("killanimscript");
	self.moveloopoverridefunc = undefined;
	var_00 = self.turnanim;
	if(gettime() > self.turntime + 50)
	{
		return;
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
	if(isdefined(self.pathturnanimblendtime))
	{
		var_01 = self.pathturnanimblendtime;
	}

	self clearanim(%body,var_01);
	self.moveloopcleanupfunc = ::pathchange_cleanupturnanim;
	self.ignorepathchange = 1;
	var_01 = 0.05;
	if(isdefined(self.pathturnanimblendtime))
	{
		var_01 = self.pathturnanimblendtime;
	}

	self notify("turn_start");
	self setflaggedanimrestart("turnAnim",var_00,1,var_01,self.moveplaybackrate);
	if(animscripts\utility::isspaceai())
	{
		self orientmode("face angle 3d",self.angles);
	}
	else
	{
		self orientmode("face angle",self.angles[1]);
	}

	if(isdefined(self.dynamicturnscaling))
	{
		childthread manage_turn(var_00,1,"code_move");
	}

	animscripts\shared::donotetracks("turnAnim");
	self.ignorepathchange = undefined;
	self orientmode("face motion");
	self animmode("none",0);
	animscripts\shared::donotetracks("turnAnim");
	self notify("turn_end");
}

//Function Number: 25
getcurrentforwardmovementanimation()
{
	var_00 = self getactiveanimations();
	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		if(var_00[var_01]["animation"] == %combatrun_forward)
		{
			if(var_00[var_01 + 1].size > 2)
			{
				return var_00[var_01 + 1];
			}
			else
			{
				return undefined;
			}
		}
	}

	return undefined;
}

//Function Number: 26
manage_turn(param_00,param_01,param_02)
{
	self endon("death");
	var_03 = 45;
	var_04 = getnotetracktimes(param_00,param_02);
	var_05 = self.origin;
	var_06 = self.angles;
	var_05 = getstartorigin(var_05,var_06,param_00);
	var_06 = getstartangles(var_05,var_06,param_00);
	var_07 = getanimlength(param_00) * var_04[0];
	var_08 = int(maps\_utility::round_float(var_07 * 20,0,0));
	if(var_08 < 1)
	{
		return;
	}

	var_09 = 1 / var_08;
	var_0A = 0;
	var_0B = self.origin;
	for(;;)
	{
		var_0C = var_0A * var_09;
		var_0D = 1 - var_08 * var_09 - var_0C;
		var_0A++;
		if((!isdefined(self.ignorepathchange) && param_01) || var_0C > 1)
		{
			break;
		}

		var_0E = getmovedelta(param_00,0,var_0C);
		var_0F = getangledelta3d(param_00,0,var_0C);
		var_10 = transformmove(var_05,var_06,(0,0,0),(0,0,0),var_0E,var_0F);
		var_11 = var_10["origin"];
		var_12 = var_10["angles"];
		var_13 = self.lookaheaddir;
		var_14 = vectortoangles(self.lookaheaddir)[1];
		var_15 = var_12[1];
		var_16 = angleclamp180(var_14 - var_15);
		var_17 = var_16 * var_0D;
		var_17 = abs(clamp(var_17,-1 * var_03,var_03));
		var_13 = vectorlerp(anglestoforward(var_12),self.lookaheaddir,var_17 / var_03 * var_0D);
		self orientmode("face direction",var_13);
		wait 0.05;
	}
}

//Function Number: 27
pathchange_cleanupturnanim()
{
	self.ignorepathchange = undefined;
	self orientmode("face default");
	self clearanim(%animscript_root,0.1);
	self animmode("none",0);
	if(self.swimmer)
	{
		animscripts\swim::swim_cleanupturnanim();
	}
}

//Function Number: 28
dodgemoveloopoverride()
{
	self pushplayer(1);
	self animmode("zonly_physics",0);
	self clearanim(%body,0.2);
	self setflaggedanimrestart("dodgeAnim",self.currentdodgeanim,1,0.2,1);
	animscripts\shared::donotetracks("dodgeAnim");
	self animmode("none",0);
	self orientmode("face default");
	if(animhasnotetrack(self.currentdodgeanim,"code_move"))
	{
		animscripts\shared::donotetracks("dodgeAnim");
	}

	self clearanim(%civilian_dodge,0.2);
	self pushplayer(0);
	self.currentdodgeanim = undefined;
	self.moveloopoverridefunc = undefined;
	return 1;
}

//Function Number: 29
trydodgewithanim(param_00,param_01)
{
	var_02 = (self.lookaheaddir[1],-1 * self.lookaheaddir[0],0);
	var_03 = self.lookaheaddir * param_01[0];
	var_04 = var_02 * param_01[1];
	var_05 = self.origin + var_03 - var_04;
	self pushplayer(1);
	if(self maymovetopoint(var_05))
	{
		self.currentdodgeanim = param_00;
		self.moveloopoverridefunc = ::dodgemoveloopoverride;
		self notify("move_loop_restart");
		return 1;
	}

	self pushplayer(0);
	return 0;
}

//Function Number: 30
animdodgeobstaclelistener()
{
	if(!isdefined(self.dodgeleftanim) || !isdefined(self.dodgerightanim))
	{
		return;
	}

	self endon("killanimscript");
	self endon("move_interrupt");
	for(;;)
	{
		self waittill("path_need_dodge",var_00,var_01);
		animscripts\utility::updateisincombattimer();
		if(animscripts\utility::isincombat())
		{
			self.nododgemove = 0;
			return;
		}

		if(!issentient(var_00))
		{
			continue;
		}

		var_02 = vectornormalize(var_01 - self.origin);
		if(self.lookaheaddir[0] * var_02[1] - var_02[0] * self.lookaheaddir[1] > 0)
		{
			if(!trydodgewithanim(self.dodgerightanim,self.dodgerightanimoffset))
			{
				trydodgewithanim(self.dodgeleftanim,self.dodgeleftanimoffset);
			}
		}
		else if(!trydodgewithanim(self.dodgeleftanim,self.dodgeleftanimoffset))
		{
			trydodgewithanim(self.dodgerightanim,self.dodgerightanimoffset);
		}

		if(isdefined(self.currentdodgeanim))
		{
			wait(getanimlength(self.currentdodgeanim));
			continue;
		}

		wait(0.1);
	}
}

//Function Number: 31
setdodgeanims(param_00,param_01)
{
	self.nododgemove = 1;
	self.dodgeleftanim = param_00;
	self.dodgerightanim = param_01;
	var_02 = 1;
	if(animhasnotetrack(param_00,"code_move"))
	{
		var_02 = getnotetracktimes(param_00,"code_move")[0];
	}

	self.dodgeleftanimoffset = getmovedelta(param_00,0,var_02);
	var_02 = 1;
	if(animhasnotetrack(param_01,"code_move"))
	{
		var_02 = getnotetracktimes(param_01,"code_move")[0];
	}

	self.dodgerightanimoffset = getmovedelta(param_01,0,var_02);
	self.interval = 80;
}

//Function Number: 32
cleardodgeanims()
{
	self.nododgemove = 0;
	self.dodgeleftanim = undefined;
	self.dodgerightanim = undefined;
	self.dodgeleftanimoffset = undefined;
	self.dodgerightanimoffset = undefined;
}

//Function Number: 33
meleeattackcheck_whilemoving()
{
	self endon("killanimscript");
	for(;;)
	{
		if(isdefined(self.enemy) && isai(self.enemy) || isdefined(self.meleeplayerwhilemoving))
		{
			if(abs(self getmotionangle()) <= 135)
			{
				animscripts\melee::melee_tryexecuting();
			}
		}

		wait(0.1);
	}
}

//Function Number: 34
bulletwhizbycheck_whilemoving()
{
	self endon("killanimscript");
	if(isdefined(self.disablebulletwhizbyreaction))
	{
		return;
	}

	for(;;)
	{
		self waittill("bulletwhizby",var_00);
		if(self.movemode != "run" || !self.facemotion || self.a.pose != "stand" || isdefined(self.reactingtobullet))
		{
			continue;
		}

		if(self.stairsstate != "none")
		{
			continue;
		}

		if(!isdefined(self.enemy) && !self.ignoreall && isdefined(var_00.team) && isenemyteam(self.team,var_00.team))
		{
			self.whizbyenemy = var_00;
			self animcustom(::animscripts\reactions::bulletwhizbyreaction);
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

		self.requestreacttobullet = gettime();
		self notify("move_loop_restart");
		animscripts\run::endfaceenemyaimtracking();
	}
}

//Function Number: 35
get_shuffle_to_corner_start_anim(param_00,param_01)
{
	var_02 = param_01.type;
	if(var_02 == "Cover Multi")
	{
		var_02 = animscripts\utility::getcovermultipretendtype(param_01);
	}

	if(var_02 == "Cover Left")
	{
		return animscripts\utility::lookupanim("shuffle","shuffle_start_from_cover_left");
	}

	if(var_02 == "Cover Right")
	{
		return animscripts\utility::lookupanim("shuffle","shuffle_start_from_cover_right");
	}

	if(param_00)
	{
		return animscripts\utility::lookupanim("shuffle","shuffle_start_left");
	}

	return animscripts\utility::lookupanim("shuffle","shuffle_start_right");
}

//Function Number: 36
setup_shuffle_anim_array(param_00,param_01,param_02)
{
	var_03 = [];
	var_04 = param_02.type;
	if(var_04 == "Cover Multi")
	{
		var_04 = animscripts\utility::getcovermultipretendtype(param_02);
	}

	if(var_04 == "Cover Left")
	{
		var_03["shuffle_start"] = get_shuffle_to_corner_start_anim(param_00,param_01);
		var_03["shuffle"] = animscripts\utility::lookupanim("shuffle","shuffle_to_cover_left");
		var_03["shuffle_end"] = animscripts\utility::lookupanim("shuffle","shuffle_end_to_cover_left");
	}
	else if(var_04 == "Cover Right")
	{
		var_03["shuffle_start"] = get_shuffle_to_corner_start_anim(param_00,param_01);
		var_03["shuffle"] = animscripts\utility::lookupanim("shuffle","shuffle_to_cover_right");
		var_03["shuffle_end"] = animscripts\utility::lookupanim("shuffle","shuffle_end_to_cover_right");
	}
	else if(var_04 == "Cover Stand" && param_01.type == var_04)
	{
		if(param_00)
		{
			var_03["shuffle_start"] = animscripts\utility::lookupanim("shuffle","shuffle_start_left_stand_to_stand");
			var_03["shuffle"] = animscripts\utility::lookupanim("shuffle","shuffle_left_stand_to_stand");
			var_03["shuffle_end"] = animscripts\utility::lookupanim("shuffle","shuffle_end_left_stand_to_stand");
		}
		else
		{
			var_03["shuffle_start"] = animscripts\utility::lookupanim("shuffle","shuffle_start_right_stand_to_stand");
			var_03["shuffle"] = animscripts\utility::lookupanim("shuffle","shuffle_right_stand_to_stand");
			var_03["shuffle_end"] = animscripts\utility::lookupanim("shuffle","shuffle_end_right_stand_to_stand");
		}
	}
	else if(param_00)
	{
		var_03["shuffle_start"] = get_shuffle_to_corner_start_anim(param_00,param_01);
		var_03["shuffle"] = animscripts\utility::lookupanim("shuffle","shuffle_to_left_crouch");
		if(var_04 == "Cover Stand")
		{
			var_03["shuffle_end"] = animscripts\utility::lookupanim("shuffle","shuffle_end_to_left_stand");
		}
		else
		{
			var_03["shuffle_end"] = animscripts\utility::lookupanim("shuffle","shuffle_end_to_left_crouch");
		}
	}
	else
	{
		var_03["shuffle_start"] = get_shuffle_to_corner_start_anim(param_00,param_01);
		var_03["shuffle"] = animscripts\utility::lookupanim("shuffle","shuffle_to_right_crouch");
		if(var_04 == "Cover Stand")
		{
			var_03["shuffle_end"] = animscripts\utility::lookupanim("shuffle","shuffle_end_to_right_stand");
		}
		else
		{
			var_03["shuffle_end"] = animscripts\utility::lookupanim("shuffle","shuffle_end_to_right_crouch");
		}
	}

	self.a.array = var_03;
}

//Function Number: 37
movecovertocover_checkstartpose(param_00,param_01)
{
	if(self.a.pose == "stand" && param_01.type != "Cover Stand" || param_00.type != "Cover Stand")
	{
		self.a.pose = "crouch";
		return 0;
	}

	return 1;
}

//Function Number: 38
movecovertocover_checkendpose(param_00)
{
	if(self.a.pose == "crouch" && param_00.type == "Cover Stand")
	{
		self.a.pose = "stand";
		return 0;
	}

	return 1;
}

//Function Number: 39
movecovertocover()
{
	self endon("killanimscript");
	self endon("goal_changed");
	var_00 = self.shufflenode;
	self.shufflemove = undefined;
	self.shufflenode = undefined;
	self.shufflemoveinterrupted = 1;
	if(!isdefined(self.prevnode))
	{
		return;
	}

	if(!isdefined(self.node) || !isdefined(var_00) || self.node != var_00)
	{
		return;
	}

	var_01 = self.prevnode;
	var_02 = self.node;
	var_03 = var_02.origin - self.origin;
	if(lengthsquared(var_03) < 1)
	{
		return;
	}

	var_03 = vectornormalize(var_03);
	var_04 = anglestoforward(var_02.angles);
	var_05 = var_04[0] * var_03[1] - var_04[1] * var_03[0] > 0;
	if(movedoorsidetoside(var_05,var_01,var_02))
	{
		return;
	}

	if(movecovertocover_checkstartpose(var_01,var_02))
	{
		var_06 = 0.1;
	}
	else
	{
		var_06 = 0.4;
	}

	setup_shuffle_anim_array(var_05,var_01,var_02);
	self animmode("zonly_physics",0);
	self clearanim(%body,var_06);
	var_07 = animscripts\utility::animarray("shuffle_start");
	var_08 = animscripts\utility::animarray("shuffle");
	var_09 = animscripts\utility::animarray("shuffle_end");
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
		self orientmode("face angle",animscripts\utility::getnodeforwardyaw(var_01));
		self setflaggedanimrestart("shuffle_start",var_07,1,var_06);
		animscripts\shared::donotetracks("shuffle_start");
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
	animscripts\notetracks::donotetracksfortime(var_11,"shuffle");
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

		animscripts\notetracks::donotetracksfortime(var_11,"shuffle");
	}

	if(var_0F)
	{
		if(movecovertocover_checkendpose(var_02))
		{
			var_06 = 0.2;
		}
		else
		{
			var_06 = 0.4;
		}

		self clearanim(var_08,var_06);
		self setflaggedanim("shuffle_end",var_09,1,var_06);
		animscripts\shared::donotetracks("shuffle_end");
	}

	self safeteleport(var_02.origin);
	self animmode("normal");
	self.shufflemoveinterrupted = undefined;
}

//Function Number: 40
movecovertocoverfinish()
{
	if(isdefined(self.shufflemoveinterrupted))
	{
		self clearanim(%cover_shuffle,0.2);
		self.shufflemoveinterrupted = undefined;
		self animmode("none",0);
		self orientmode("face default");
		return;
	}

	wait(0.2);
	self clearanim(%cover_shuffle,0.2);
}

//Function Number: 41
movedoorsidetoside(param_00,param_01,param_02)
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
	animscripts\shared::donotetracks("sideToSide",::handlesidetosidenotetracks);
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
		thread slidefortime(var_0C,var_0B);
	}

	animscripts\shared::donotetracks("sideToSide");
	self safeteleport(param_02.origin);
	self animmode("none");
	self orientmode("face default");
	self.shufflemoveinterrupted = undefined;
	wait(0.2);
	return 1;
}

//Function Number: 42
handlesidetosidenotetracks(param_00)
{
	if(param_00 == "slide_start")
	{
		return 1;
	}
}

//Function Number: 43
slidefortime(param_00,param_01)
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

//Function Number: 44
movestand_moveoverride(param_00,param_01)
{
	self endon("movemode");
	self clearanim(%combatrun,0.6);
	self setanimknoball(%combatrun,%body,1,0.5,self.moveplaybackrate);
	if(isdefined(self.requestreacttobullet) && gettime() - self.requestreacttobullet < 100 && isdefined(self.run_overridebulletreact) && randomfloat(1) < self.a.reacttobulletchance)
	{
		animscripts\run::customrunningreacttobullets();
		return;
	}

	var_02 = undefined;
	if(isdefined(self.run_overrideanim_hasstairanimarray))
	{
		if(animscripts\run::move_checkstairstransition())
		{
			return;
		}

		self clearanim(%stair_transitions,0.1);
		if(self.stairsstate == "up")
		{
			var_02 = animscripts\utility::getmoveanim("stairs_up");
		}
		else if(self.stairsstate == "down")
		{
			var_02 = animscripts\utility::getmoveanim("stairs_down");
		}
	}

	if(!isdefined(var_02))
	{
		if(isarray(param_00))
		{
			if(isdefined(self.run_override_weights))
			{
				var_02 = common_scripts\utility::choose_from_weighted_array(param_00,param_01);
			}
			else
			{
				var_02 = param_00[randomint(param_00.size)];
			}
		}
		else
		{
			var_02 = param_00;
		}
	}

	self setflaggedanimknob("moveanim",var_02,1,0.2,self.moveplaybackrate);
	animscripts\shared::donotetracks("moveanim");
}

//Function Number: 45
listenforcoverapproach()
{
	thread animscripts\cover_arrival::setupapproachnode(1);
}