/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\traverse\shared.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 20
 * Decompile Time: 352 ms
 * Timestamp: 10/27/2023 1:54:03 AM
*******************************************************************/

//Function Number: 1
advancedtraverse(param_00,param_01)
{
	self.desired_anim_pose = "crouch";
	animscripts\utility::updateanimpose();
	self endon("killanimscript");
	self traversemode("nogravity");
	self traversemode("noclip");
	var_02 = self getnegotiationstartnode();
	self orientmode("face angle",var_02.angles[1]);
	var_02.traverse_height = var_02.origin[2] + var_02.traverse_height_delta;
	var_03 = var_02.traverse_height - var_02.origin[2];
	thread teleportthread(var_03 - param_01);
	var_04 = 0.15;
	self clearanim(%body,var_04);
	self setflaggedanimknoballrestart("traverse",param_00,%animscript_root,1,var_04,1);
	var_05 = 0.2;
	var_06 = 0.2;
	thread animscripts\notetracks::donotetracksforever("traverse","no clear");
	if(!animhasnotetrack(param_00,"gravity on"))
	{
		var_07 = 1.23;
		wait(var_07 - var_05);
		self traversemode("gravity");
		wait(var_05);
		return;
	}

	self waittillmatch("gravity on","traverse");
	self traversemode("gravity");
	if(!animhasnotetrack(param_00,"blend"))
	{
		wait(var_05);
		return;
	}

	self waittillmatch("blend","traverse");
}

//Function Number: 2
teleportthread(param_00)
{
	self endon("killanimscript");
	self notify("endTeleportThread");
	self endon("endTeleportThread");
	var_01 = 5;
	var_02 = (0,0,param_00 / var_01);
	for(var_03 = 0;var_03 < var_01;var_03++)
	{
		self forceteleport(self.origin + var_02);
		wait(0.05);
	}
}

//Function Number: 3
teleportthreadex(param_00,param_01,param_02,param_03)
{
	self endon("killanimscript");
	self notify("endTeleportThread");
	self endon("endTeleportThread");
	if(param_00 >= 0 || param_02 <= 0)
	{
		return;
	}

	if(param_01 > 0)
	{
		wait(param_01);
	}

	var_04 = (0,0,param_00 / param_02);
	if(isdefined(param_03) && param_03 < 1)
	{
		self setflaggedanimknoball("traverseAnim",self.traverseanim,self.traverseanimroot,1,0.2,param_03);
	}

	for(var_05 = 0;var_05 < param_02;var_05++)
	{
		self forceteleport(self.origin + var_04);
		wait(0.05);
	}

	if(isdefined(param_03) && param_03 < 1)
	{
		self setflaggedanimknoball("traverseAnim",self.traverseanim,self.traverseanimroot,1,0.2,1);
	}
}

//Function Number: 4
dotraverse(param_00)
{
	self endon("killanimscript");
	setdvarifuninitialized("scr_traverse_debug",0);
	self.istraversing = 1;
	self.desired_anim_pose = "stand";
	animscripts\utility::updateanimpose();
	var_01 = self getnegotiationstartnode();
	if(isdefined(var_01.traverse_height_delta))
	{
		var_01.traverse_height = var_01.origin[2] + var_01.traverse_height_delta;
	}
	else
	{
		var_01.traverse_height = var_01.origin[2];
	}

	var_02 = self getnegotiationendnode();
	self orientmode("face angle",var_01.angles[1]);
	self.traverseheight = param_00["traverseHeight"];
	self.traversestartnode = var_01;
	var_03 = param_00["traverseAnim"];
	var_04 = param_00["traverseToCoverAnim"];
	self traversemode("nogravity");
	self traversemode("noclip");
	self.traversestartz = self.origin[2];
	var_05 = 0;
	if(isdefined(var_04) && isdefined(self.node) && self.node.type == param_00["coverType"] && distancesquared(self.node.origin,var_02.origin) < 625)
	{
		if(animscripts\utility::absangleclamp180(self.node.angles[1] - var_02.angles[1]) > 160)
		{
			var_05 = 1;
			var_03 = var_04;
		}
	}

	if(var_05)
	{
		if(isdefined(param_00["traverseToCoverSound"]))
		{
			thread maps\_utility::play_sound_on_entity(param_00["traverseToCoverSound"]);
		}
	}
	else if(isdefined(param_00["traverseSound"]))
	{
		thread maps\_utility::play_sound_on_entity(param_00["traverseSound"]);
	}

	self.traverseanim = var_03;
	if(!animhasnotetrack(var_03,"traverse_align"))
	{
		handletraversealignment();
	}

	if(isdefined(param_00["traverseBodyNode"]))
	{
		self.traverseanimroot = param_00["traverseBodyNode"];
	}
	else
	{
		self.traverseanimroot = %body;
	}

	self setflaggedanimknoballrestart("traverseAnim",var_03,self.traverseanimroot,1,0.2,1);
	var_06 = ::handletraversenotetracks;
	if(isdefined(param_00["traverseNotetrackFunc"]))
	{
		var_06 = param_00["traverseNotetrackFunc"];
	}

	self.traversedeathindex = 0;
	self.traversedeathanim = param_00["interruptDeathAnim"];
	animscripts\shared::donotetracks("traverseAnim",var_06);
	self traversemode("gravity");
	if(self.delayeddeath)
	{
		return;
	}

	self.a.nodeath = 0;
	if(var_05 && isdefined(self.node) && distancesquared(self.origin,self.node.origin) < 256)
	{
		self.a.movement = "stop";
		self teleport(self.node.origin);
	}
	else if(isdefined(param_00["traverseStopsAtEnd"]))
	{
		self.a.movement = "stop";
	}
	else
	{
		self.a.movement = "run";
		self clearanim(var_03,0.2);
	}

	self notify("traverse_finish");
	self.traverseanimroot = undefined;
	self.traverseanim = undefined;
	self.deathanim = undefined;
	self.traversestartnode = undefined;
	self.istraversing = undefined;
}

//Function Number: 5
handletraversenotetracks(param_00)
{
	if(param_00 == "traverse_death")
	{
		return handletraversedeathnotetrack();
	}

	if(param_00 == "traverse_align")
	{
		return handletraversealignment();
	}

	if(param_00 == "traverse_drop")
	{
		return handletraversedrop();
	}
}

//Function Number: 6
handletraversedeathnotetrack()
{
	if(isdefined(self.traversedeathanim))
	{
		var_00 = self.traversedeathanim[self.traversedeathindex];
		self.deathanim = var_00[randomint(var_00.size)];
		self.traversedeathindex++;
	}
}

//Function Number: 7
handletraversealignment()
{
	self traversemode("nogravity");
	self traversemode("noclip");
	if(isdefined(self.traverseheight) && isdefined(self.traversestartnode.traverse_height))
	{
		var_00 = self.traversestartnode.traverse_height - self.traversestartz;
		thread teleportthread(var_00 - self.traverseheight);
	}
}

//Function Number: 8
handletraversedrop()
{
	var_00 = self.origin + (0,0,32);
	var_01 = self getanimtime(self.traverseanim);
	var_02 = getanimlength(self.traverseanim);
	var_03 = var_01 * var_02;
	var_04 = 0;
	var_05 = 0;
	var_06 = 0;
	var_07 = undefined;
	var_08 = 1;
	var_09 = getnotetracktimes(self.traverseanim,"land");
	if(var_09.size > 0)
	{
		var_0A = getnextlandingtime(var_01,var_09);
		var_08 = var_0A;
		var_0B = getmovedelta(self.traverseanim,var_01,var_0A);
		var_0C = (0,self.angles[1],0);
		var_0B = rotatevector(var_0B,var_0C);
		var_07 = self.origin + var_0B;
		var_04 = 0 - var_0B[2];
		var_0B = (var_0B[0],var_0B[1],0);
		var_00 = var_00 + var_0B;
		var_05 = var_0A - var_01 * var_02;
	}
	else
	{
		var_0D = getmovedelta(self.traverseanim,var_02,1);
		var_0C = (0,self.angles[1],0);
		var_0D = rotatevector(var_0D,var_0C);
		var_04 = 0 - var_0D[2];
		var_07 = self.origin + var_0D;
		var_0E = var_02 - var_03;
		var_05 = var_0E / 3;
	}

	var_0F = physicstrace(var_00,var_00 + (0,0,-768));
	var_10 = distance(var_00,var_0F);
	var_11 = var_10 - 32 - 0.5;
	var_12 = var_04 - var_11;
	if(var_04 < var_11)
	{
		var_13 = var_04 / var_11;
	}
	else
	{
		var_13 = 1;
	}

	var_06 = ceil(var_05 * 20);
	thread teleportthreadex(var_12,0,var_06,var_13);
	thread finishtraversedrop(var_0F[2],var_05,var_09.size,var_12);
}

//Function Number: 9
getnextlandingtime(param_00,param_01)
{
	for(var_02 = 0;var_02 < param_01.size - 1;var_02++)
	{
		for(var_03 = var_02 + 1;var_03 < param_01.size;var_03++)
		{
			if(param_01[var_03] < param_01[var_02])
			{
				var_04 = param_01[var_03];
				param_01[var_03] = param_01[var_02];
				param_01[var_02] = var_04;
			}
		}
	}

	for(var_02 = 0;var_02 < param_01.size;var_02++)
	{
		if(param_01[var_02] > param_00)
		{
			return param_01[var_02];
		}
	}

	return param_01[param_01.size - 1];
}

//Function Number: 10
finishtraversedrop(param_00,param_01,param_02,param_03)
{
	self endon("killanimscript");
	if(param_02 > 0)
	{
		var_04 = param_01;
		if(param_03 > 0)
		{
			var_04 = var_04 - 0.1;
		}

		if(var_04 < 0)
		{
			var_04 = 0;
		}

		wait(var_04);
		self traversemode("gravity");
		return;
	}

	param_00 = param_00 + 4;
	for(;;)
	{
		if(self.origin[2] < param_00)
		{
			self traversemode("gravity");
			break;
		}

		wait(0.05);
	}
}

//Function Number: 11
donothingfunc()
{
	self animmode("zonly_physics");
	self waittill("killanimscript");
}

//Function Number: 12
dovariablelengthtraverse(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	self endon("killanimscript");
	var_07 = 1;
	if(isdefined(self.moveplaybackrate))
	{
		var_07 = self.moveplaybackrate;
	}

	var_08 = self getnegotiationstartnode();
	var_09 = self.origin;
	if(isdefined(param_00))
	{
		var_0A = getmovedelta(param_00,0,1);
		var_09 = transformpoint(var_0A,var_08.origin,var_08.angles);
	}

	var_0B = self getnegotiationendnode();
	var_0C = var_0B.origin;
	if(isdefined(param_02))
	{
		var_0D = getmovedelta(param_02,0,1);
		var_0C = transformpoint(var_0D * -1,var_0B.origin,var_0B.angles);
		var_0C = var_0C + (0,0,1);
	}

	var_0E = getmovedelta(param_01,0,1);
	var_0F = length(var_0E) * var_07 / getanimlength(param_01);
	var_10 = length(var_0C - var_09) / var_0F;
	if(var_10 <= 0)
	{
		return;
	}

	self.istraversing = 1;
	self.desired_anim_pose = "crouch";
	animscripts\utility::updateanimpose();
	if(isdefined(param_03))
	{
		self traversemode(param_03);
	}
	else
	{
		self traversemode("noclip");
	}

	self.allowpain = 1;
	if(isdefined(param_06))
	{
		var_11 = param_06;
	}
	else
	{
		var_11 = %body;
	}

	self orientmode("face angle",var_08.angles[1]);
	if(isdefined(param_00))
	{
		self setflaggedanimknoballrestart("traversal",param_00,var_11,1,0.1,var_07);
		animscripts\shared::donotetracks("traversal");
	}

	self setflaggedanimknoballrestart("traversal",param_01,var_11,1,0.1,var_07);
	animscripts\notetracks::donotetracksfortime(var_10,"traversal");
	if(isdefined(param_02))
	{
		self setflaggedanimknoballrestart("traversal",param_02,var_11,1,0.1,var_07);
		animscripts\shared::donotetracks("traversal");
	}

	self traversemode("gravity");
	if(isdefined(param_04))
	{
		self.a.pose = param_04;
	}

	if(isdefined(param_05))
	{
		self.a.movement = param_05;
	}

	self.istraversing = undefined;
}

//Function Number: 13
transformpoint(param_00,param_01,param_02)
{
	var_03 = length(param_00);
	var_04 = vectortoangles(param_00);
	var_05 = combineangles(param_02,var_04);
	var_06 = anglestoforward(var_05);
	return param_01 + var_06 * var_03;
}

//Function Number: 14
dog_handle_traverse_notetracks(param_00)
{
	var_01 = undefined;
	var_02 = 0;
	var_03 = 0;
	if(param_00 == "traverse_jump_start")
	{
		var_02 = 1;
		var_04 = getnotetracktimes(self.traverseanim,"traverse_align");
		if(var_04.size > 0)
		{
			var_01 = var_04;
		}
		else
		{
			var_01 = getnotetracktimes(self.traverseanim,"traverse_jump_end");
			var_03 = 1;
		}
	}
	else if(param_00 == "gravity on")
	{
		var_02 = 1;
		var_01 = getnotetracktimes(self.traverseanim,"traverse_jump_end");
		var_03 = 1;
	}

	if(var_02)
	{
		var_05 = getnotetracktimes(self.traverseanim,param_00);
		var_06 = var_05[0];
		var_07 = getmovedelta(self.traverseanim,0,var_05[0]);
		var_08 = var_07[2];
		var_07 = getmovedelta(self.traverseanim,0,var_01[0]);
		var_09 = var_07[2];
		var_0A = var_01[0];
		var_0B = getanimlength(self.traverseanim);
		var_0C = int(var_0A - var_06 * var_0B * 30);
		var_0D = max(1,var_0C - 2);
		var_0E = var_09 - var_08;
		if(var_03)
		{
			var_07 = getmovedelta(self.traverseanim,0,1);
			var_0F = var_07[2] - var_09;
			var_10 = self.traverseendnode.origin[2] - self.origin[2] - var_0F;
		}
		else
		{
			var_11 = self.traversestartnode;
			var_10 = var_11.traverse_height_delta - self.origin[2] - var_11.origin[2];
		}

		thread teleportthreadex(var_10 - var_0E,0,var_0D);
		return 1;
	}
}

//Function Number: 15
dog_traverse_cleanup_on_end()
{
	self waittill("killanimscript");
	self.traversestartnode = undefined;
	self.traverseendnode = undefined;
}

//Function Number: 16
dog_wall_and_window_hop(param_00,param_01,param_02)
{
	self endon("killanimscript");
	self traversemode("nogravity");
	self traversemode("noclip");
	thread dog_traverse_cleanup_on_end();
	var_03 = self getnegotiationstartnode();
	self orientmode("face angle",var_03.angles[1]);
	if(!isdefined(param_02))
	{
		var_04 = var_03.traverse_height - var_03.origin[2];
		thread teleportthread(var_04 - param_01);
	}

	self.traverseanim = level.dogtraverseanims[param_00];
	self.traversestartnode = var_03;
	self.traverseendnode = self getnegotiationendnode();
	self clearanim(%body,0.2);
	self setflaggedanimrestart("dog_traverse",self.traverseanim,1,0.2,1);
	self.moveanimtype = "land";
	animscripts\notetracks::donotetracksintercept("dog_traverse",::dog_handle_traverse_notetracks);
	self.moveanimtype = undefined;
	self.traverseanim = undefined;
}

//Function Number: 17
dog_jump_down(param_00,param_01,param_02,param_03)
{
	self endon("killanimscript");
	self traversemode("noclip");
	thread dog_traverse_cleanup_on_end();
	var_04 = self getnegotiationstartnode();
	var_05 = self getnegotiationendnode();
	self orientmode("face angle",var_04.angles[1]);
	if(!isdefined(param_02))
	{
		param_02 = "jump_down_40";
	}

	self.traverseanim = level.dogtraverseanims[param_02];
	self.traverseanimroot = %body;
	self.traversestartnode = var_04;
	self.traverseendnode = var_05;
	if(!isdefined(param_03))
	{
		param_03 = 0;
	}

	if(!param_03)
	{
		var_06 = var_04.origin[2] - var_05.origin[2];
		thread teleportthreadex(40 - var_06,0.1,param_00,param_01);
	}

	self.moveanimtype = "land";
	self clearanim(%body,0.2);
	self setflaggedanimrestart("traverseAnim",self.traverseanim,1,0.2,1);
	if(!param_03)
	{
		animscripts\shared::donotetracks("traverseAnim");
	}
	else
	{
		animscripts\notetracks::donotetracksintercept("traverseAnim",::dog_handle_traverse_notetracks);
	}

	self.moveanimtype = undefined;
	self traversemode("gravity");
	self.traverseanimroot = undefined;
	self.traverseanim = undefined;
}

//Function Number: 18
dog_jump_up(param_00,param_01,param_02,param_03)
{
	self endon("killanimscript");
	self traversemode("noclip");
	thread dog_traverse_cleanup_on_end();
	var_04 = self getnegotiationstartnode();
	self orientmode("face angle",var_04.angles[1]);
	if(!isdefined(param_02))
	{
		param_02 = "jump_up_40";
	}

	self.traverseanim = level.dogtraverseanims[param_02];
	self.traverseanimroot = %body;
	self.traversestartnode = var_04;
	self.traverseendnode = self getnegotiationendnode();
	if(!isdefined(param_03))
	{
		param_03 = 0;
	}

	if(!param_03)
	{
		thread teleportthreadex(param_00 - 40,0.2,param_01);
	}

	self.moveanimtype = "land";
	self clearanim(%body,0.2);
	self setflaggedanimrestart("traverseAnim",self.traverseanim,1,0.2,1);
	if(!param_03)
	{
		animscripts\shared::donotetracks("traverseAnim");
	}
	else
	{
		animscripts\notetracks::donotetracksintercept("traverseAnim",::dog_handle_traverse_notetracks);
	}

	self.moveanimtype = undefined;
	self traversemode("gravity");
	self.traverseanim = undefined;
	self.traverseanimroot = undefined;
}

//Function Number: 19
dog_long_jump(param_00,param_01)
{
	self endon("killanimscript");
	self traversemode("nogravity");
	self traversemode("noclip");
	thread dog_traverse_cleanup_on_end();
	var_02 = self getnegotiationstartnode();
	self orientmode("face angle",var_02.angles[1]);
	if(!isdefined(var_02.traverse_height))
	{
		var_02.traverse_height = var_02.origin[2];
	}

	var_03 = var_02.traverse_height - var_02.origin[2];
	thread teleportthread(var_03 - param_01);
	self.moveanimtype = "land";
	self clearanim(%body,0.2);
	self setflaggedanimknoballrestart("dog_traverse",level.dogtraverseanims[param_00],1,0.2,1);
	animscripts\shared::donotetracks("dog_traverse");
	self.moveanimtype = undefined;
}

//Function Number: 20
getnextfootdown()
{
	var_00 = (0,0,0);
	var_01 = (0,0,0);
	if(isdefined(self.mech) && self.mech)
	{
		var_01 = self gettagorigin("j2_ball_ri");
		var_00 = self gettagorigin("j2_ball_le");
	}
	else
	{
		var_01 = self gettagorigin("j_ball_ri");
		var_00 = self gettagorigin("j_ball_le");
	}

	if(!isdefined(var_01) || !isdefined(var_00))
	{
		return "none";
	}

	if(var_00[2] > var_01[2])
	{
		return "Left";
	}

	return "Right";
}