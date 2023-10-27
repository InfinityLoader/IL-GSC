/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\swim.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 63
 * Decompile Time: 1081 ms
 * Timestamp: 10/27/2023 2:44:54 AM
*******************************************************************/

//Function Number: 1
moveswim()
{
	self endon("movemode");
	self orientmode("face enemy or motion");
	if(animscripts\utility::isspaceai())
	{
		self.turnrate = 0.16;
	}
	else
	{
		self.turnrate = 0.03;
	}

	animscripts\utility::updateisincombattimer();
	if(animscripts\utility::isincombat(0))
	{
		moveswim_combat();
		return;
	}

	moveswim_noncombat();
}

//Function Number: 2
swim_begin()
{
	self.swim = spawnstruct();
	self.swim.combatstate = "nostate";
	self.swim.movestate = "combat_stationary";
	self.swim.trackstate = "track_none";
	self.swim.statefns = [];
	self.swim.statefns["nostate"] = [::swim_null,::swim_null];
	self.swim.statefns["noncombat"] = [::moveswim_noncombat_enter,::moveswim_noncombat_exit];
	self.swim.statefns["combat"] = [::moveswim_combat_enter,::moveswim_combat_exit];
	self.swim.statefns["combat_stationary"] = [::swim_null,::swim_null];
	self.swim.statefns["combat_forward"] = [::moveswim_combat_forward_enter,::moveswim_combat_forward_exit];
	self.swim.statefns["combat_strafe"] = [::moveswim_combat_strafe_enter,::moveswim_combat_strafe_exit];
	self.swim.statefns["track_none"] = [::swim_null,::swim_null];
	self.swim.statefns["track_forward"] = [::swim_track_forward_enter,::swim_track_forward_exit];
	self.swim.statefns["track_strafe"] = [::swim_track_strafe_enter,::swim_track_strafe_exit];
	self setanimlimited(getswimanim("aim_stand_D"));
	self setanimlimited(getswimanim("aim_stand_U"));
	self setanimlimited(getswimanim("aim_stand_L"));
	self setanimlimited(getswimanim("aim_stand_R"));
	self.custommovetransition = ::swim_movebegin;
	self.permanentcustommovetransition = 1;
	self.pathturnanimoverridefunc = ::swim_pathchange_getturnanim;
	self.pathturnanimblendtime = 0.2;
}

//Function Number: 3
swim_end()
{
	self.swim = undefined;
	if(animscripts\utility::isspaceai())
	{
		self.turnrate = 0.16;
		return;
	}

	self.turnrate = 0.3;
}

//Function Number: 4
swim_null()
{
}

//Function Number: 5
swim_moveend()
{
	moveswim_set("nostate");
	swim_clearleananims();
	if(isdefined(self.prevturnrate))
	{
		self.turnrate = self.prevturnrate;
		self.prevturnrate = undefined;
	}
}

//Function Number: 6
moveswim_noncombat()
{
	if(self.swim.combatstate != "noncombat")
	{
		moveswim_set("noncombat");
	}

	var_00 = self.swim.move_noncombat_anim;
	var_01 = 0.4;
	if(animscripts\utility::isspaceai())
	{
		var_01 = 0.2;
	}

	self setflaggedanimknob("swimanim",var_00,1,var_01,self.moveplaybackrate);
	swim_updateleananim();
	animscripts\notetracks::donotetracksfortime(0.2,"swimanim");
}

//Function Number: 7
moveswim_combat()
{
	if(self.swim.combatstate != "combat")
	{
		moveswim_set("combat");
	}

	if(isdefined(self.enemy))
	{
		animscripts\run::setshootwhilemoving(1);
		if(!self.facemotion)
		{
			swim_dostrafe();
			return;
		}
		else
		{
			if(self.swim.movestate != "combat_forward")
			{
				moveswim_combat_move_set("combat_forward");
			}

			if(isdefined(self.bclearstrafeturnrate) && self.bclearstrafeturnrate && lengthsquared(self.velocity))
			{
				var_00 = vectortoangles(self.velocity);
				if(abs(angleclamp180(var_00[1] - self.angles[1])) > 35)
				{
					self.turnrate = 0.18;
					if(animscripts\utility::isspaceai())
					{
						self.turnrate = 0.2;
					}
				}
				else
				{
					if(animscripts\utility::isspaceai())
					{
						self.turnrate = 0.16;
					}
					else
					{
						self.turnrate = 0.03;
					}

					self.bclearstrafeturnrate = undefined;
				}
			}
			else
			{
				self.bclearstrafeturnrate = undefined;
			}

			var_01 = getswimanim("forward_aim");
		}
	}
	else
	{
		if(self.swim.movestate != "combat_forward")
		{
			moveswim_combat_move_set("combat_forward");
		}

		animscripts\run::setshootwhilemoving(0);
		var_01 = getswimanim("forward_aim");
	}

	var_02 = 0.4;
	if(animscripts\utility::isspaceai())
	{
		var_02 = 0.2;
	}

	swim_updateleananim();
	self setflaggedanimknob("swimanim",var_01,1,var_02,self.moveplaybackrate);
	animscripts\notetracks::donotetracksfortime(0.2,"swimanim");
}

//Function Number: 8
moveswim_set(param_00)
{
	if(param_00 == self.swim.combatstate)
	{
		return;
	}

	[[ self.swim.statefns[self.swim.combatstate][1] ]]();
	[[ self.swim.statefns[param_00][0] ]]();
	self.swim.combatstate = param_00;
}

//Function Number: 9
moveswim_noncombat_enter()
{
	if(self.swim.trackstate != "track_none")
	{
		swim_track_set("track_none");
	}

	swim_setleananims();
	thread moveswim_noncombat_twitchupdate();
}

//Function Number: 10
moveswim_noncombat_exit()
{
	self notify("end_MoveSwim_NonCombat_TwitchUpdate");
}

//Function Number: 11
moveswim_combat_enter()
{
	self setanimknob(%combatrun,1,0.5,self.moveplaybackrate);
	if(self.swim.movestate != "combat_forward")
	{
		moveswim_combat_move_set("combat_forward");
	}
}

//Function Number: 12
moveswim_combat_exit()
{
	moveswim_combat_move_set("combat_stationary");
}

//Function Number: 13
moveswim_combat_move_set(param_00)
{
	if(param_00 == self.swim.movestate)
	{
		return;
	}

	[[ self.swim.statefns[self.swim.movestate][1] ]]();
	[[ self.swim.statefns[param_00][0] ]]();
	self.swim.movestate = param_00;
}

//Function Number: 14
moveswim_combat_forward_enter()
{
	if(self.swim.trackstate != "track_forward")
	{
		swim_track_set("track_forward");
	}

	swim_setleananims();
}

//Function Number: 15
moveswim_combat_forward_exit()
{
}

//Function Number: 16
moveswim_combat_strafe_enter()
{
	self setanimknoblimited(getswimanim("strafe_B"),1,0.1,self.sidesteprate,1);
	self setanimknoblimited(getswimanim("strafe_L"),1,0.1,self.sidesteprate,1);
	self setanimknoblimited(getswimanim("strafe_R"),1,0.1,self.sidesteprate,1);
	if(self.swim.trackstate != "track_strafe")
	{
		swim_track_set("track_strafe");
	}

	swim_clearleananims();
	if(animscripts\utility::isspaceai())
	{
		self.turnrate = 0.25;
		return;
	}

	self.turnrate = 0.18;
	self.jumping = 1;
}

//Function Number: 17
moveswim_combat_strafe_exit()
{
	self clearanim(%combatrun_forward,0.2);
	self clearanim(%combatrun_backward,0.2);
	self clearanim(%combatrun_left,0.2);
	self clearanim(%combatrun_right,0.2);
	if(animscripts\utility::isspaceai())
	{
		self.turnrate = 0.16;
	}
	else
	{
		self.turnrate = 0.03;
		self.jumping = 0;
	}

	self.bclearstrafeturnrate = 1;
}

//Function Number: 18
swim_track_set(param_00)
{
	if(self.swim.trackstate == param_00)
	{
		return;
	}

	[[ self.swim.statefns[self.swim.trackstate][1] ]]();
	[[ self.swim.statefns[param_00][0] ]]();
	self.swim.trackstate = param_00;
}

//Function Number: 19
swim_track_forward_enter()
{
	self setanimlimited(getswimanim("aim_move_D"));
	self setanimlimited(getswimanim("aim_move_L"));
	self setanimlimited(getswimanim("aim_move_R"));
	self setanimlimited(getswimanim("aim_move_U"));
	thread moveswim_track_combat();
}

//Function Number: 20
swim_track_forward_exit()
{
	self clearanim(%aim_2,0.2);
	self clearanim(%aim_4,0.2);
	self clearanim(%aim_6,0.2);
	self clearanim(%aim_8,0.2);
}

//Function Number: 21
swim_track_strafe_enter()
{
}

//Function Number: 22
swim_track_strafe_exit()
{
	self clearanim(%w_aim_4,0.2);
	self clearanim(%w_aim_6,0.2);
	self clearanim(%w_aim_8,0.2);
	self clearanim(%w_aim_2,0.2);
}

//Function Number: 23
moveswim_track_combat()
{
	self endon("killanimscript");
	self endon("end_face_enemy_tracking");
	if(!isdefined(self.aim_while_moving_thread))
	{
		self.aim_while_moving_thread = 1;
		animscripts\combat::set_default_aim_limits();
		if(animscripts\utility::isspaceai())
		{
			self.rightaimlimit = 90;
			self.leftaimlimit = -90;
		}

		animscripts\track::trackloop(%w_aim_2,%w_aim_4,%w_aim_6,%w_aim_8);
	}
}

//Function Number: 24
getswimanim(param_00,param_01)
{
	var_02 = animscripts\utility::lookupanim("swim",param_00);
	if(isdefined(param_01))
	{
		return var_02[param_01];
	}

	return var_02;
}

//Function Number: 25
moveswim_noncombat_twitchupdate()
{
	var_00 = getswimanim("forward");
	self.swim.move_noncombat_anim = var_00;
}

//Function Number: 26
swim_shoulddonodeexit()
{
	if(isdefined(self.disableexits))
	{
		return 0;
	}

	if(!isdefined(self.pathgoalpos))
	{
		return 0;
	}

	var_00 = self.maxfaceenemydist;
	self.maxfaceenemydist = 128;
	if(!self shouldfacemotion())
	{
		self.maxfaceenemydist = var_00;
		return 0;
	}

	self.maxfaceenemydist = var_00;
	var_01 = 10000;
	if(animscripts\utility::isspaceai())
	{
		var_01 = 32400;
	}

	if(distancesquared(self.origin,self.pathgoalpos) < var_01)
	{
		return 0;
	}

	if(self.a.movement != "stop")
	{
		return 0;
	}

	if(lengthsquared(self.prevanimdelta) > 1)
	{
		var_02 = vectortoangles(self.prevanimdelta);
		if(abs(angleclamp180(var_02[1] - self.angles[1])) < 90)
		{
			var_03 = vectortoangles(self.lookaheaddir);
			if(abs(angleclamp180(var_03[1] - self.angles[1])) < 90)
			{
				return 0;
			}
		}
	}

	return 1;
}

//Function Number: 27
swim_movebegin()
{
	self.a.pose = "stand";
	if(!swim_shoulddonodeexit())
	{
		return;
	}

	var_00 = swim_choosestart();
	if(!isdefined(var_00))
	{
		return;
	}

	var_01 = var_00.m_turnanim;
	var_02 = var_00.m_anim;
	var_03 = var_00.m_angledelta;
	var_04 = vectortoangles(self.lookaheaddir);
	var_05 = var_04 - var_03;
	var_06 = anglestoforward(var_05);
	var_07 = animscripts\exit_node::getexitnode();
	if(animscripts\utility::isspaceai() && isdefined(var_07))
	{
		var_08 = swim_getapproachtype(var_07);
		if(var_08 != "exposed")
		{
			var_09 = getnodeforwardangles(var_07);
			var_06 = anglestoforward(var_09);
		}
		else
		{
			var_06 = anglestoforward(self.angles);
		}
	}

	self animmode("nogravity",0);
	var_0A = randomfloatrange(0.9,1.1);
	var_0B = 0.3;
	self orientmode("face angle 3d",self.angles);
	if(isdefined(var_01) && !animscripts\utility::isspaceai())
	{
		self setflaggedanimknoballrestart("startturn",var_01,%body,1,0.3,var_0A * self.moveplaybackrate);
		animscripts\shared::donotetracks("startturn");
		var_0B = 0.5;
	}
	else if(isdefined(var_01) && animscripts\utility::isspaceai())
	{
		if(isdefined(var_07))
		{
			self orientmode("face direction",var_06);
		}

		self.prevturnrate = 0.16;
		self.turnrate = 5;
		var_0B = 0.1;
		self setflaggedanimknoballrestart("startturn",var_01,%body,1,var_0B,var_0A * self.moveplaybackrate);
		animscripts\shared::donotetracks("startturn");
		var_0B = 0.5;
		self.turnrate = 0.16;
		self.prevturnrate = undefined;
		var_0C = getangledelta(var_01);
		var_07 = animscripts\exit_node::getexitnode();
		var_06 = anglestoforward(self.angles);
		if(isdefined(var_07))
		{
			var_08 = swim_getapproachtype(var_07);
			if(var_08 != "exposed")
			{
				var_09 = getnodeforwardangles(var_07);
				var_09 = (var_09[0],var_09[1] - var_0C,var_09[2]);
				var_06 = anglestoforward(var_09);
			}
		}
	}

	var_0D = var_04 - self.angles;
	var_0E = getanimlength(var_02);
	var_0F = 0.001 * abs(angleclamp180(var_0D[1] - var_03[1])) / var_0E;
	var_10 = 0.001 * abs(angleclamp180(var_0D[0] - var_03[0])) / var_0E;
	var_11 = max(var_0F,var_10);
	if(var_11 < 0.01)
	{
		var_11 = 0.01;
	}

	if(animscripts\utility::isspaceai())
	{
		var_0B = 0.05;
		self.turnrate = 0.16;
		var_11 = 5;
	}

	self.prevturnrate = self.turnrate;
	self.turnrate = var_11;
	self orientmode("face direction",var_06);
	self setflaggedanimknoballrestart("startmove",var_02,%body,1,var_0B,var_0A * self.moveplaybackrate);
	animscripts\shared::donotetracks("startmove");
	self.turnrate = self.prevturnrate;
	self.prevturnrate = undefined;
	self orientmode("face default");
	self animmode("none",0);
	if(animscripts\utility::isspaceai())
	{
		if(animhasnotetrack(var_02,"finish"))
		{
			animscripts\shared::donotetracks("startmove");
		}

		var_12 = 65536;
		var_13 = self.goalpos;
		if(isdefined(self.node))
		{
			var_13 = self.node.origin;
		}

		if(distance2dsquared(self.origin,var_13) > var_12)
		{
			self notify("force_space_rotation_update",0,0,undefined,1);
		}
	}

	if(animscripts\utility::isspaceai())
	{
		return 0.2;
	}

	return 0.4;
}

//Function Number: 28
swim_setleananims()
{
	self setanimlimited(getswimanim("turn_add_l"));
	self setanimlimited(getswimanim("turn_add_r"));
	self setanimlimited(getswimanim("turn_add_u"));
	self setanimlimited(getswimanim("turn_add_d"));
	self.prevleanfracyaw = 0;
	self.prevleanfracpitch = 0;
}

//Function Number: 29
swim_clearleananims()
{
	self clearanim(%add_turn_l,0.2);
	self clearanim(%add_turn_r,0.2);
	self clearanim(%add_turn_u,0.2);
	self clearanim(%add_turn_d,0.2);
	self.prevleanfracyaw = undefined;
	self.prevleanfracpitch = undefined;
}

//Function Number: 30
swim_choosestart()
{
	var_00 = animscripts\utility::isincombat();
	var_01 = animscripts\exit_node::getexitnode();
	var_02 = self.angles;
	var_03 = 0;
	var_04 = 0;
	var_05 = 0;
	var_06 = vectortoangles(self.lookaheaddir);
	var_07 = animscripts\utility::gettruenodeangles(var_01);
	if(animscripts\utility::isspaceai() && var_07[2])
	{
		if(var_07[2] != 0)
		{
			var_08 = anglestoforward(var_07);
			var_09 = self.goalpos;
			if(isdefined(self.node))
			{
				var_09 = self.node.origin;
			}

			var_0A = rotatepointaroundvector(var_08,var_09 - self.origin,var_07[2] * -1);
			var_0B = var_0A + self.origin;
			var_0C = var_0B - self.origin;
			var_0C = vectornormalize(var_0C);
			var_06 = vectortoangles(var_0C);
			var_05 = 1;
		}
	}

	var_0D = undefined;
	var_0E = undefined;
	if(isdefined(var_01) && isdefined(var_01.type))
	{
		var_0E = swim_getapproachtype(var_01);
		if(var_0E != "exposed")
		{
			var_0D = "exit_" + var_0E;
			var_02 = var_01.angles;
			if(animscripts\utility::isspaceai())
			{
				var_02 = animscripts\utility::gettruenodeangles(var_01);
				if(var_05 == 1)
				{
					var_02 = (var_02[0],var_02[1],0);
				}
			}
			else
			{
				var_02 = var_01.angles;
			}

			var_03 = 1;
		}
	}

	if(!isdefined(var_0D))
	{
		if(var_00)
		{
			var_0D = "idle_ready_to_forward";
		}
		else
		{
			var_0D = "idle_to_forward";
			var_04 = 1;
			var_03 = 1;
		}
	}

	var_0F = getswimanim(var_0D);
	var_10 = angleclamp180(var_06[1] - var_02[1]);
	var_11 = angleclamp180(var_06[0] - var_02[0]);
	var_12 = undefined;
	if(animscripts\utility::isspaceai())
	{
		var_12 = 3;
	}

	var_13 = swim_getangleindex(var_10,var_12);
	var_14 = swim_getangleindex(var_11,var_12);
	var_15 = var_0E;
	if(!isdefined(var_15) && isdefined(self.prevnode) && distance2dsquared(self.prevnode.origin,self.origin) < 36)
	{
		var_15 = swim_getapproachtype(self.prevnode);
	}

	if(var_13 == 4 && isdefined(var_15))
	{
		var_16 = isdefined(var_0E);
		if(var_15 == "cover_corner_l" && var_10 < -10 && !var_16 || isdefined(var_0F[2]))
		{
			var_13 = 2;
		}
		else if(var_15 == "cover_corner_r" && var_10 > 10 && !var_16 || isdefined(var_0F[6]))
		{
			var_13 = 6;
		}
	}

	if(!isdefined(var_0F[var_13]))
	{
		var_0D = "idle_to_forward";
		var_0F = getswimanim(var_0D);
		var_04 = 1;
	}

	var_17 = spawnstruct();
	if(var_04)
	{
		var_18 = getswimanim("idle_turn");
		if(!isdefined(var_18[var_13]))
		{
			var_19 = 0;
			var_1A = 8;
			while(!isdefined(var_0F[var_19]) && var_19 < 8)
			{
				var_19++;
			}

			while(!isdefined(var_0F[var_1A]) && var_1A > 0)
			{
				var_1A--;
			}

			if(var_13 < var_19)
			{
				var_13 = var_19;
			}
			else if(var_13 > var_1A)
			{
				var_13 = var_1A;
			}
		}

		var_17.m_turnanim = var_18[var_13];
		var_13 = 4;
	}

	if(isdefined(var_0F[var_13]) && isdefined(var_0F[var_13][var_14]))
	{
		var_17.m_anim = var_0F[var_13][var_14];
		if(var_03)
		{
			var_0F = getswimanim(var_0D + "_angleDelta");
			var_17.m_angledelta = var_0F[var_13][var_14];
		}
		else
		{
			var_17.m_angledelta = (0,0,0);
		}

		return var_17;
	}

	var_17 = undefined;
	return undefined;
}

//Function Number: 31
swim_setupapproach()
{
	self endon("killanimscript");
	self endon("swim_cancelapproach");
	thread swim_restartapproachlistener();
	if(isdefined(self.disablearrivals) && self.disablearrivals)
	{
		return;
	}

	self.swim.arrivalpathgoalpos = self.pathgoalpos;
	if(isdefined(self getnegotiationstartnode()))
	{
		return;
	}

	var_00 = animscripts\cover_arrival::getapproachent();
	if(isdefined(var_00) && swim_isapproachablenode(var_00))
	{
		thread swim_approachnode();
		return;
	}

	thread swim_approachpos();
}

//Function Number: 32
swim_restartapproachlistener()
{
	self endon("killanimscript");
	self endon("swim_killrestartlistener");
	self waittill("path_set");
	var_00 = isdefined(self.pathgoalpos) && isdefined(self.swim.arrivalpathgoalpos) && distancesquared(self.pathgoalpos,self.swim.arrivalpathgoalpos) < 4;
	if(var_00)
	{
		thread swim_restartapproachlistener();
		return;
	}

	swim_cancelcurrentapproach();
	swim_setupapproach();
}

//Function Number: 33
swim_cancelcurrentapproach()
{
	self notify("swim_cancelapproach");
	self.stopanimdistsq = 0;
}

//Function Number: 34
swim_waitforapproachpos(param_00,param_01)
{
	self endon("swim_cancelwaitforapproachpos");
	var_02 = param_01 + 60 * param_01 + 60;
	var_03 = distancesquared(param_00,self.origin);
	if(var_03 <= var_02)
	{
		return;
	}

	self.stopanimdistsq = var_02;
	self waittill("stop_soon");
	self.stopanimdistsq = 0;
}

//Function Number: 35
swim_approachpos()
{
	self endon("killanimscript");
	self endon("swim_cancelapproach");
	self endon("move_interrupt");
	self endon("swim_killrestartlistener");
	if(!isdefined(self.pathgoalpos))
	{
		return;
	}

	var_00 = swim_getmaxanimdist("arrival_exposed");
	swim_waitforapproachpos(self.pathgoalpos,var_00);
	swim_doposarrival();
}

//Function Number: 36
swim_approachnode()
{
	self endon("killanimscript");
	self endon("swim_cancelapproach");
	self endon("swim_killrestartlistener");
	var_00 = animscripts\cover_arrival::getapproachent();
	self.approachtype = swim_getapproachtype(var_00);
	self.requestarrivalnotify = 1;
	self waittill("cover_approach",var_01);
	var_00 = animscripts\cover_arrival::getapproachent();
	var_02 = swim_getapproachtype(var_00);
	if(var_02 == "exposed")
	{
		if(isdefined(var_00))
		{
			var_03 = var_00.origin;
		}
		else
		{
			var_03 = self.pathgoalpos;
		}

		var_04 = var_03 - self.origin;
		var_05 = vectortoangles(var_04);
		var_06 = (0,var_05[1],0);
		var_07 = (0,var_05[1],0);
	}
	else
	{
		var_03 = var_03.origin;
		var_06 = getnodeforwardangles(var_02);
		if(animscripts\utility::isspaceai())
		{
			var_07 = animscripts\utility::gettruenodeangles(var_01);
		}
		else
		{
			var_07 = var_01.angles;
		}
	}

	thread swim_dofinalarrival(var_02,var_03,var_01,var_07,var_06);
}

//Function Number: 37
swim_doposarrival()
{
	var_00 = animscripts\cover_arrival::getapproachent();
	var_01 = self.pathgoalpos;
	var_02 = (0,self.angles[1],self.angles[2]);
	if(isdefined(var_00) && var_00.type != "Path" && var_00.type != "Path 3D")
	{
		var_02 = getnodeforwardangles(var_00);
	}
	else if(animscripts\cover_arrival::faceenemyatendofapproach())
	{
		var_02 = vectortoangles(self.enemy.origin - var_01);
	}

	var_03 = vectornormalize(var_01 - self.origin);
	if(isdefined(var_00) && swim_isapproachablenode(var_00))
	{
		var_04 = swim_getapproachtype(var_00);
		var_05 = getnodeforwardangles(var_00);
		var_02 = var_00.angles;
		if(animscripts\utility::isspaceai())
		{
			var_02 = animscripts\utility::gettruenodeangles(var_00);
		}

		thread swim_dofinalarrival(var_04,var_00.origin,var_03,var_02,var_05);
		return;
	}

	thread swim_dofinalarrival("exposed",var_03,var_05,var_04,var_04);
}

//Function Number: 38
swim_determineapproachanim3d(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(animscripts\utility::isspaceai())
	{
		var_06 = (0,0,0);
		var_07 = (0,0,0);
		var_08 = combineangles(invertangles(param_04),param_05);
		var_09 = rotatevectorinverted(vectornormalize(self.origin - param_02),param_04) * -1;
		var_0A = swim_determineapproachanim(param_00,param_01,var_06,var_09,var_07,var_08,1,param_02,param_04);
		if(var_0A)
		{
			param_00.m_worldstartpos = rotatevector(param_00.m_worldstartpos,param_04) + param_02;
		}

		return var_0A;
	}

	return swim_determineapproachanim(param_05,var_06,var_07,var_08,var_09,var_0A,0);
}

//Function Number: 39
swim_dofinalarrival(param_00,param_01,param_02,param_03,param_04)
{
	self endon("killanimscript");
	self endon("swim_cancelapproach");
	self.approachtype = param_00;
	var_05 = spawnstruct();
	if(!swim_determineapproachanim3d(var_05,param_00,param_01,param_02,param_03,param_04))
	{
		return;
	}

	var_06 = anglestoforward(self.angles);
	var_07 = var_05.m_worldstartpos - self.origin;
	var_08 = length(var_07);
	var_07 = var_07 / var_08;
	if(animscripts\utility::isspaceai())
	{
		var_09 = param_01 - var_05.m_worldstartpos;
		var_0A = length(var_09);
		var_0B = vectordot(var_07,var_06);
		if(var_08 > var_0A * 0.4 && vectordot(var_07,var_06) < 0.5)
		{
			self notify("force_space_rotation_update",0,0);
			return;
		}
	}
	else if(var_08 < 100 && vectordot(var_07,var_06) < 0.5)
	{
		return;
	}

	if(var_08 > 4)
	{
		if(var_08 < 12 || self.fixednode || !isdefined(self.node) || !animscripts\cover_arrival::isthreatenedbyenemy())
		{
			self.swim.arrivalpathgoalpos = var_05.m_worldstartpos;
			self setruntopos(var_05.m_worldstartpos);
			if(animscripts\utility::isspaceai())
			{
				var_0C = 16384;
				for(;;)
				{
					if(distancesquared(self.origin,var_05.m_worldstartpos) < var_0C)
					{
						self.prevturnrate = self.turnrate;
						self.turnrate = 0.1;
						var_0D = calculatestartorientation(var_05.m_delta,var_05.m_angledelta,param_01,param_04);
						self notify("force_space_rotation_update",0,0,var_0D[1]);
						break;
					}

					wait(0.1);
				}
			}

			self waittill("runto_arrived");
		}
	}

	self notify("swim_killrestartlistener");
	var_0E = vectornormalize(param_01 - self.origin);
	if(!swim_determineapproachanim3d(var_05,param_00,param_01,var_0E,param_03,param_04))
	{
		return;
	}

	self.swim.arrivalanim = var_05.m_anim;
	if(animscripts\utility::isspaceai())
	{
		var_0F = self startcoverarrival(var_05.m_worldstartpos,param_04[1] - var_05.m_angledelta[1],param_04[0] - var_05.m_angledelta[0],param_04,var_05.m_angledelta);
		return;
	}

	self startcoverarrival(var_05.m_worldstartpos,param_04[1] - var_05.m_angledelta[1],param_04[0] - var_05.m_angledelta[0]);
}

//Function Number: 40
swim_coverarrival_main()
{
	self endon("killanimscript");
	self endon("abort_approach");
	var_00 = "arrival_" + self.approachtype;
	var_01 = self.swim.arrivalanim;
	if(!self.fixednode)
	{
		thread animscripts\cover_arrival::abortapproachifthreatened();
	}

	var_02 = 0.4;
	if(animscripts\utility::isspaceai())
	{
		var_02 = 0.2;
		thread space_arrival_turnrate_delay();
	}

	self clearanim(%body,0.2);
	self setflaggedanimrestart("coverArrival",var_01,1,var_02,self.movetransitionrate);
	animscripts\shared::donotetracks("coverArrival",::swim_handlestartcoveraim);
	if(!animhasnotetrack(var_01,"start_aim"))
	{
		swim_startcoveraim();
	}

	self.a.pose = "stand";
	self.a.movement = "stop";
	self.a.arrivaltype = self.approachtype;
	if(animscripts\utility::isspaceai())
	{
		self.turnrate = 0.16;
		self.prevturnrate = undefined;
	}

	self clearanim(%animscript_root,0.3);
	self.lastapproachaborttime = undefined;
	self.swim.arrivalanim = undefined;
	if(animscripts\utility::isspaceai() && self.approachtype == "exposed")
	{
		self notify("force_space_rotation_update",0,0,undefined,1);
	}
}

//Function Number: 41
space_arrival_turnrate_delay()
{
	self endon("killanimscript");
	self endon("abort_approach");
	wait(0.22);
	self.prevturnrate = 0.16;
	self.turnrate = 5;
}

//Function Number: 42
swim_getanimstartpos(param_00,param_01,param_02,param_03,param_04)
{
	if(param_04)
	{
		var_05 = calculatestartorientation(param_02,param_03,param_00,param_01);
		return var_05[0];
	}

	var_06 = param_02 - param_04;
	var_07 = anglestoforward(var_06);
	var_08 = anglestoright(var_06);
	var_09 = anglestoup(var_06);
	var_0A = var_07 * param_03[0];
	var_0B = var_08 * param_03[1];
	var_0C = var_09 * param_03[2];
	return param_01 - var_0A + var_0B - var_0C;
}

//Function Number: 43
swim_maymovefrompointtopoint(param_00,param_01,param_02,param_03,param_04)
{
	if(param_02)
	{
		param_01 = rotatevector(param_01,param_04) + param_03;
		return self maymovefrompointtopoint(param_03,param_01,0,1);
	}

	return self maymovefrompointtopoint(param_00,param_01,0,1);
}

//Function Number: 44
swim_determineapproachanim(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	if(lengthsquared(param_03) < 0.003)
	{
		return 0;
	}

	var_09 = vectortoangles(param_03);
	if(param_01 == "exposed")
	{
		var_0A = 4;
		var_0B = 4;
	}
	else
	{
		var_0C = angleclamp180(param_06[1] - var_0B[1]);
		var_0A = swim_getangleindex(var_0C);
		var_0B = swim_getangleindex(var_0C,25);
	}

	var_0D = angleclamp180(param_04[0] - var_09[0]);
	var_0E = swim_getangleindex(var_0D);
	var_0F = swim_getangleindex(var_0D,25);
	var_10 = "arrival_" + param_01;
	if(param_01 == "exposed" && !animscripts\utility::isincombat(0))
	{
		var_10 = var_10 + "_noncombat";
	}

	var_11 = getswimanim(var_10);
	if(!isdefined(var_11[var_0A]) || !isdefined(var_11[var_0A][var_0E]))
	{
		return 0;
	}

	var_12 = (var_0A != var_0B || var_0E != var_0F) && isdefined(var_11[var_0B]) && isdefined(var_11[var_0B][var_0F]);
	var_13 = 0;
	var_14 = 0;
	var_15 = undefined;
	var_16 = var_11[var_0A][var_0E];
	if(var_12)
	{
		var_15 = var_11[var_0B][var_0F];
	}

	var_17 = var_10 + "_delta";
	var_11 = getswimanim(var_17);
	var_18 = var_11[var_0A][var_0E];
	if(var_12)
	{
		var_13 = var_11[var_0B][var_0F];
	}

	var_19 = var_10 + "_angleDelta";
	var_11 = getswimanim(var_19);
	var_1A = var_11[var_0A][var_0E];
	if(var_12)
	{
		var_14 = var_11[var_0B][var_0F];
	}

	var_1B = swim_getanimstartpos(param_02,param_05,var_18,var_1A,param_06);
	if(!swim_maymovefrompointtopoint(param_02,var_1B,param_06,param_07,param_08) && var_12 && !animscripts\utility::isspaceai())
	{
		var_16 = var_15;
		var_18 = var_13;
		var_1A = var_14;
		var_1B = swim_getanimstartpos(param_02,param_05,var_18,var_1A,param_06);
		if(!swim_maymovefrompointtopoint(param_02,var_1B,param_06,param_07,param_08))
		{
			return 0;
		}
	}

	param_00.m_anim = var_16;
	param_00.m_delta = var_18;
	param_00.m_angledelta = var_1A;
	param_00.m_worldstartpos = var_1B;
	return 1;
}

//Function Number: 45
swim_getangleindex(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = 10;
	}

	if(param_00 < 0)
	{
		return int(ceil(180 + param_00 - param_01 / 45));
	}

	return int(floor(180 + param_00 + param_01 / 45));
}

//Function Number: 46
swim_getmaxanimdist(param_00)
{
	var_01 = level.archetypes["soldier"]["swim"][param_00]["maxDelta"];
	if(isdefined(self.animarchetype) && self.animarchetype != "soldier")
	{
		if(isdefined(level.archetypes[self.animarchetype]["swim"]) && isdefined(level.archetypes[self.animarchetype]["swim"][param_00]))
		{
			var_02 = level.archetypes[self.animarchetype]["swim"][param_00]["maxDelta"];
			if(var_02 > var_01)
			{
				var_01 = var_02;
			}
		}
	}

	return var_01;
}

//Function Number: 47
swim_startcoveraim()
{
	animscripts\animset::set_animarray_standing();
	animscripts\combat::set_aim_and_turn_limits();
	self.previouspitchdelta = 0;
	animscripts\combat_utility::setupaim(0);
	thread animscripts\track::trackshootentorpos();
}

//Function Number: 48
swim_handlestartcoveraim(param_00)
{
	if(param_00 != "start_aim")
	{
		return;
	}

	swim_startcoveraim();
}

//Function Number: 49
swim_getapproachtype(param_00)
{
	if(!isdefined(param_00))
	{
		return "exposed";
	}

	var_01 = param_00.type;
	if(!isdefined(var_01))
	{
		return "exposed";
	}

	switch(var_01)
	{
		case "Cover Right 3D":
			break;

		case "Cover Left 3D":
			break;

		case "Cover Up 3D":
			break;

		case "Path 3D":
		case "Exposed 3D":
			break;

		default:
			break;
	}
}

//Function Number: 50
getnodeforwardangles(param_00)
{
	if(getdvarint("player_spaceEnabled") == 1)
	{
		var_01 = animscripts\utility::gettruenodeangles(param_00);
		if(animscripts\utility::isnodecoverleft(param_00))
		{
			var_02 = getswimanim("arrival_cover_corner_l_angleDelta");
			var_03 = var_02[4][4][1];
		}
		else if(animscripts\utility::isnodecoverright(var_01))
		{
			var_02 = getswimanim("arrival_cover_corner_r_angleDelta");
			var_03 = var_02[4][4][1];
		}
		else
		{
			var_03 = 0;
		}

		var_01 = combineangles(var_01,(0,var_03,0));
		return var_01;
	}
	else
	{
		var_01 = var_03.angles;
	}

	var_04 = var_03[1];
	if(animscripts\utility::isnodecoverleft(var_01))
	{
		var_02 = getswimanim("arrival_cover_corner_l_angleDelta");
		var_04 = var_04 + var_02[4][4][1];
	}
	else if(animscripts\utility::isnodecoverright(var_01))
	{
		var_02 = getswimanim("arrival_cover_corner_r_angleDelta");
		var_04 = var_04 + var_02[4][4][1];
	}

	var_03 = (var_03[0],var_04,var_03[2]);
	return var_03;
}

//Function Number: 51
swim_dostrafe()
{
	if(self.swim.movestate != "combat_strafe")
	{
		moveswim_combat_move_set("combat_strafe");
	}

	var_00 = getswimanim("forward_aim");
	self setflaggedanimknoblimited("swimanim",var_00,1,0.1,1,1);
	thread swim_updatestrafeanim();
	animscripts\notetracks::donotetracksfortime(0.2,"swimanim");
	self notify("end_swim_updatestrafeanim");
}

//Function Number: 52
swim_updatestrafeanim()
{
	self endon("killanimscript");
	self endon("move_interrupt");
	self endon("move_mode");
	self endon("move_loop_restart");
	self endon("end_swim_updatestrafeanim");
	var_00 = 0;
	for(;;)
	{
		if(self.facemotion)
		{
			if(!var_00)
			{
				swim_setstrafeweights(1,0,0,0);
				swim_setstrafeaimweights(0,0,0,0);
			}
		}
		else
		{
			if(self.relativedir == 1)
			{
				var_01 = [];
				var_01["front"] = 1;
				var_01["back"] = 0;
				var_01["left"] = 0;
				var_01["right"] = 0;
			}
			else
			{
				var_01 = animscripts\utility::quadrantanimweights(self getmotionangle());
			}

			if(isdefined(self.update_move_front_bias))
			{
				var_01["back"] = 0;
				if(var_01["front"] < 0.2)
				{
					var_01["front"] = 0.2;
				}
			}

			var_02 = swim_setstrafeweights(var_01["front"],var_01["back"],var_01["left"],var_01["right"]);
			swim_setstrafeaimset(var_02);
			swim_updatestrafeaimanim();
		}

		var_00 = self.facemotion;
		wait(0.05);
		waittillframeend;
	}
}

//Function Number: 53
swim_getstrafeblendtime()
{
	if(animscripts\utility::isspaceai())
	{
		return 0.5;
	}

	return 0.5;
}

//Function Number: 54
swim_setstrafeweights(param_00,param_01,param_02,param_03)
{
	var_04 = swim_getstrafeblendtime();
	self setanim(%combatrun_forward,param_00,var_04,1,1);
	self setanim(%combatrun_backward,param_01,var_04,1,1);
	self setanim(%combatrun_left,param_02,var_04,1,1);
	self setanim(%combatrun_right,param_03,var_04,1,1);
	if(param_00 > 0)
	{
		return "front";
	}

	if(param_01 > 0)
	{
		return "back";
	}

	if(param_02 > 0)
	{
		return "left";
	}

	if(param_03 > 0)
	{
		return "right";
	}
}

//Function Number: 55
swim_setstrafeaimset(param_00)
{
	switch(param_00)
	{
		case "front":
			break;

		case "back":
			break;

		case "left":
			break;

		case "right":
			break;

		default:
			break;
	}
}

//Function Number: 56
swim_updatestrafeaimanim()
{
	var_00 = self.angles[1];
	var_01 = self.angles[0];
	var_02 = 0;
	var_03 = 0;
	var_04 = 0;
	var_05 = 0;
	var_06 = 45;
	var_07 = 60;
	if(isdefined(self.enemy))
	{
		var_08 = self.enemy.origin - self.origin;
		var_09 = vectortoangles(var_08);
		var_0A = angleclamp180(var_09[1] - var_00);
		var_0B = angleclamp180(var_09[0] - var_01);
		if(var_0A > 0)
		{
			var_04 = clamp(1 - var_06 - var_0A / var_06,0,1);
		}
		else
		{
			var_05 = clamp(1 - var_06 + var_0A / var_06,0,1);
		}

		if(var_0B > 0)
		{
			var_03 = clamp(1 - var_07 - var_0B / var_07,0,1);
		}
		else
		{
			var_02 = clamp(1 - var_07 + var_0B / var_07,0,1);
		}
	}

	swim_setstrafeaimweights(var_02,var_03,var_04,var_05);
}

//Function Number: 57
swim_setstrafeaimweights(param_00,param_01,param_02,param_03)
{
	self setanim(%w_aim_4,param_02,0.2,1,1);
	self setanim(%w_aim_6,param_03,0.2,1,1);
	self setanim(%w_aim_8,param_00,0.2,1,1);
	self setanim(%w_aim_2,param_01,0.2,1,1);
}

//Function Number: 58
swim_pathchange_getturnanim(param_00,param_01)
{
	var_02 = undefined;
	var_03 = undefined;
	var_04 = getswimanim("turn");
	var_05 = swim_getangleindex(param_00);
	var_06 = swim_getangleindex(param_01);
	if(isdefined(var_04[var_05]))
	{
		var_02 = var_04[var_05][var_06];
	}

	if(var_05 == 4)
	{
		if(var_06 > 4 && isdefined(var_04[4][var_06 + 1]))
		{
			var_02 = var_04[4][var_06 + 1];
		}
		else if(var_06 < 4 && var_06 > 0 && isdefined(var_04[4][var_06 - 1]))
		{
			var_02 = var_04[4][var_06 - 1];
		}
	}

	if(!isdefined(var_02))
	{
		var_02 = var_04[var_05][4];
	}

	if(isdefined(var_02))
	{
		if(animscripts\move::pathchange_candoturnanim(var_02))
		{
			return var_02;
		}
	}

	return undefined;
}

//Function Number: 59
swim_cleanupturnanim()
{
	moveswim_set("nostate");
}

//Function Number: 60
swim_updateleananim()
{
	var_00 = clamp(self.leanamount / 20,-1,1);
	if(var_00 > 0)
	{
		if(self.prevleanfracyaw <= 0 && var_00 < 0.075)
		{
			var_00 = 0;
		}

		self setanim(%add_turn_l,var_00,0.2,1,1);
		self setanim(%add_turn_r,0,0.2,1,1);
	}
	else
	{
		if(self.prevleanfracyaw >= 0 && var_00 > -0.075)
		{
			var_00 = 0;
		}

		self setanim(%add_turn_l,0,0.2,1,1);
		self setanim(%add_turn_r,0 - var_00,0.2,1,1);
	}

	self.prevleanfracyaw = var_00;
	var_00 = clamp(self.pitchamount / 25,-1,1);
	if(var_00 > 0)
	{
		if(self.prevleanfracpitch <= 0 && var_00 < 0.075)
		{
			var_00 = 0;
		}

		self setanim(%add_turn_d,var_00,0.2,1,1);
		self setanim(%add_turn_u,0,0.2,1,1);
	}
	else
	{
		if(self.prevleanfracpitch >= 0 && var_00 > -0.075)
		{
			var_00 = 0;
		}

		self setanim(%add_turn_d,0,0.2,1,1);
		self setanim(%add_turn_u,0 - var_00,0.2,1,1);
	}

	self.prevleanfracpitch = var_00;
}

//Function Number: 61
swim_isapproachablenode(param_00)
{
	switch(param_00.type)
	{
		case "Exposed 3D":
		case "Cover Right 3D":
		case "Cover Left 3D":
		case "Cover Up 3D":
			break;
	}
}

//Function Number: 62
space_getdefaultturnrate()
{
	return 0.16;
}

//Function Number: 63
space_getorientturnrate()
{
	return 0.1;
}