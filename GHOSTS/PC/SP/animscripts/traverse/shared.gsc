/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\traverse\shared.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 16
 * Decompile Time: 268 ms
 * Timestamp: 10/27/2023 1:23:03 AM
*******************************************************************/

//Function Number: 1
advancedtraverse(param_00,param_01)
{
	self.desired_anim_pose = "crouch";
	animscripts/utility::func_86CA();
	self endon("killanimscript");
	self traversemode("nogravity");
	self traversemode("noclip");
	var_02 = self getnegotiationstartnode();
	self orientmode("face angle",var_02.angles[1]);
	var_02.var_82CB = var_02.origin[2] + var_02.var_82CC;
	var_03 = var_02.var_82CB - var_02.origin[2];
	thread func_8022(var_03 - param_01);
	var_04 = 0.15;
	self clearanim(%body,var_04);
	self setflaggedanimknoballrestart("traverse",param_00,%root,1,var_04,1);
	var_05 = 0.2;
	var_06 = 0.2;
	thread animscripts/notetracks::donotetracksforever("traverse","no clear");
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
func_8022(param_00)
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
func_8023(param_00,param_01,param_02,param_03)
{
	self endon("killanimscript");
	self notify("endTeleportThread");
	self endon("endTeleportThread");
	if(param_00 == 0 || param_02 <= 0)
	{
	}

	if(param_01 > 0)
	{
		wait(param_01);
	}

	var_04 = (0,0,param_00 / param_02);
	if(isdefined(param_03) && param_03 < 1)
	{
		self setflaggedanimknoball("traverseAnim",self.var_82CE,self.var_82D0,1,0.2,param_03);
	}

	for(var_05 = 0;var_05 < param_02;var_05++)
	{
		self forceteleport(self.origin + var_04);
		wait(0.05);
	}

	if(isdefined(param_03) && param_03 < 1)
	{
		self setflaggedanimknoball("traverseAnim",self.var_82CE,self.var_82D0,1,0.2,1);
	}
}

//Function Number: 4
func_2A1F(param_00)
{
	self endon("killanimscript");
	self.desired_anim_pose = "stand";
	animscripts/utility::func_86CA();
	var_01 = self getnegotiationstartnode();
	var_01.var_82CB = var_01.origin[2] + var_01.var_82CC;
	var_02 = self getnegotiationendnode();
	self orientmode("face angle",var_01.angles[1]);
	self.var_82D9 = param_00["traverseHeight"];
	self.var_82DB = var_01;
	var_03 = param_00["traverseAnim"];
	var_04 = param_00["traverseToCoverAnim"];
	self traversemode("nogravity");
	self traversemode("noclip");
	self.var_82DC = self.origin[2];
	if(!animhasnotetrack(var_03,"traverse_align"))
	{
		func_3F9F();
	}

	var_05 = 0;
	if(isdefined(var_04) && isdefined(self.node) && self.node.type == param_00["coverType"] && distancesquared(self.node.origin,var_02.origin) < 625)
	{
		if(animscripts/utility::absangleclamp180(self.node.angles[1] - var_02.angles[1]) > 160)
		{
			var_05 = 1;
			var_03 = var_04;
		}
	}

	if(var_05)
	{
		if(isdefined(param_00["traverseToCoverSound"]))
		{
			thread maps\_utility::func_5D23(param_00["traverseToCoverSound"]);
		}
	}
	else if(isdefined(param_00["traverseSound"]))
	{
		thread maps\_utility::func_5D23(param_00["traverseSound"]);
	}

	self.var_82CE = var_03;
	self.var_82D0 = %body;
	self setflaggedanimknoballrestart("traverseAnim",var_03,%body,1,0.2,1);
	self.var_82D7 = 0;
	self.var_82D6 = param_00["interruptDeathAnim"];
	animscripts/shared::func_2986("traverseAnim",::func_3FA2);
	self traversemode("gravity");
	if(self.delayeddeath)
	{
	}

	self.a.var_564F = 0;
	if(var_05 && isdefined(self.node) && distancesquared(self.origin,self.node.origin) < 256)
	{
		self.a.var_5486 = "stop";
		self teleport(self.node.origin);
	}
	else if(isdefined(param_00["traverseStopsAtEnd"]))
	{
		self.a.var_5486 = "stop";
	}
	else
	{
		self.a.var_5486 = "run";
		self clearanim(var_03,0.2);
	}

	self.var_82D0 = undefined;
	self.var_82CE = undefined;
	self.deathanim = undefined;
	self.var_82DB = undefined;
}

//Function Number: 5
func_3FA2(param_00)
{
	if(param_00 == "traverse_death")
	{
		return handletraversedeathnotetrack();
	}

	if(param_00 == "traverse_align")
	{
		return func_3F9F();
	}

	if(param_00 == "traverse_drop")
	{
		return func_3FA1();
	}
}

//Function Number: 6
handletraversedeathnotetrack()
{
	if(isdefined(self.var_82D6))
	{
		var_00 = self.var_82D6[self.var_82D7];
		self.deathanim = var_00[randomint(var_00.size)];
		self.var_82D7++;
	}
}

//Function Number: 7
func_3F9F()
{
	self traversemode("nogravity");
	self traversemode("noclip");
	if(isdefined(self.var_82D9) && isdefined(self.var_82DB.var_82CB))
	{
		var_00 = self.var_82DB.var_82CB - self.var_82DC;
		thread func_8022(var_00 - self.var_82D9);
	}
}

//Function Number: 8
func_3FA1()
{
	var_00 = self.origin + (0,0,32);
	var_01 = physicstrace(var_00,self.origin + (0,0,-512));
	var_02 = distance(var_00,var_01);
	var_03 = var_02 - 32 - 0.5;
	var_04 = self getanimtime(self.var_82CE);
	var_05 = getmovedelta(self.var_82CE,var_04,1);
	var_06 = getanimlength(self.var_82CE);
	var_07 = 0 - var_05[2];
	var_08 = var_07 - var_03;
	if(var_07 < var_03)
	{
		var_09 = var_07 / var_03;
	}
	else
	{
		var_09 = 1;
	}

	var_0A = var_06 - var_04 / 3;
	var_0B = ceil(var_0A * 20);
	thread func_8023(var_08,0,var_0B,var_09);
	thread func_32A2(var_01[2]);
}

//Function Number: 9
func_32A2(param_00)
{
	self endon("killanimscript");
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

//Function Number: 10
donothingfunc()
{
	self animmode("zonly_physics");
	self waittill("killanimscript");
}

//Function Number: 11
func_28E2(param_00)
{
	var_01 = undefined;
	var_02 = 0;
	var_03 = 0;
	if(param_00 == "traverse_jump_start")
	{
		var_02 = 1;
		var_04 = getnotetracktimes(self.var_82CE,"traverse_align");
		if(var_04.size > 0)
		{
			var_01 = var_04;
		}
		else
		{
			var_01 = getnotetracktimes(self.var_82CE,"traverse_jump_end");
			var_03 = 1;
		}
	}
	else if(param_00 == "gravity on")
	{
		var_02 = 1;
		var_01 = getnotetracktimes(self.var_82CE,"traverse_jump_end");
		var_03 = 1;
	}

	if(var_02)
	{
		var_05 = getnotetracktimes(self.var_82CE,param_00);
		var_06 = var_05[0];
		var_07 = getmovedelta(self.var_82CE,0,var_05[0]);
		var_08 = var_07[2];
		var_07 = getmovedelta(self.var_82CE,0,var_01[0]);
		var_09 = var_07[2];
		var_0A = var_01[0];
		var_0B = getanimlength(self.var_82CE);
		var_0C = int(var_0A - var_06 * var_0B * 30);
		var_0D = max(1,var_0C - 2);
		var_0E = var_09 - var_08;
		if(var_03)
		{
			var_07 = getmovedelta(self.var_82CE,0,1);
			var_0F = var_07[2] - var_09;
			var_10 = self.traverseendnode.origin[2] - self.origin[2] - var_0F;
		}
		else
		{
			var_11 = self.var_82DB;
			var_10 = var_11.var_82CC - self.origin[2] - var_11.origin[2];
		}

		thread func_8023(var_10 - var_0E,0,var_0D);
		return 1;
	}
}

//Function Number: 12
dog_traverse_cleanup_on_end()
{
	self waittill("killanimscript");
	self.var_82DB = undefined;
	self.traverseendnode = undefined;
}

//Function Number: 13
func_2933(param_00,param_01,param_02)
{
	self endon("killanimscript");
	self traversemode("nogravity");
	self traversemode("noclip");
	thread dog_traverse_cleanup_on_end();
	var_03 = self getnegotiationstartnode();
	self orientmode("face angle",var_03.angles[1]);
	if(!isdefined(param_02))
	{
		var_04 = var_03.var_82CB - var_03.origin[2];
		thread func_8022(var_04 - param_01);
	}

	self.var_82CE = level.dogtraverseanims[param_00];
	self.var_82DB = var_03;
	self.traverseendnode = self getnegotiationendnode();
	self clearanim(%body,0.2);
	self setflaggedanimrestart("dog_traverse",self.var_82CE,1,0.2,1);
	self.var_5474 = "land";
	animscripts/notetracks::func_2990("dog_traverse",::func_28E2);
	self.var_5474 = undefined;
	self.var_82CE = undefined;
}

//Function Number: 14
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

	self.var_82CE = level.dogtraverseanims[param_02];
	self.var_82D0 = %body;
	self.var_82DB = var_04;
	self.traverseendnode = var_05;
	if(!isdefined(param_03))
	{
		param_03 = 0;
	}

	if(!param_03)
	{
		var_06 = var_04.origin[2] - var_05.origin[2];
		thread func_8023(40 - var_06,0.1,param_00,param_01);
	}

	self.var_5474 = "land";
	self clearanim(%body,0.2);
	self setflaggedanimrestart("traverseAnim",self.var_82CE,1,0.2,1);
	if(!param_03)
	{
		animscripts/shared::func_2986("traverseAnim");
	}
	else
	{
		animscripts/notetracks::func_2990("traverseAnim",::func_28E2);
	}

	self.var_5474 = undefined;
	self traversemode("gravity");
	self.var_82D0 = undefined;
	self.var_82CE = undefined;
}

//Function Number: 15
func_28F2(param_00,param_01,param_02,param_03)
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

	self.var_82CE = level.dogtraverseanims[param_02];
	self.var_82D0 = %body;
	self.var_82DB = var_04;
	self.traverseendnode = self getnegotiationendnode();
	if(!isdefined(param_03))
	{
		param_03 = 0;
	}

	if(!param_03)
	{
		thread func_8023(param_00 - 40,0.2,param_01);
	}

	self.var_5474 = "land";
	self clearanim(%body,0.2);
	self setflaggedanimrestart("traverseAnim",self.var_82CE,1,0.2,1);
	if(!param_03)
	{
		animscripts/shared::func_2986("traverseAnim");
	}
	else
	{
		animscripts/notetracks::func_2990("traverseAnim",::func_28E2);
	}

	self.var_5474 = undefined;
	self traversemode("gravity");
	self.var_82CE = undefined;
	self.var_82D0 = undefined;
}

//Function Number: 16
dog_long_jump(param_00,param_01)
{
	self endon("killanimscript");
	self traversemode("nogravity");
	self traversemode("noclip");
	thread dog_traverse_cleanup_on_end();
	var_02 = self getnegotiationstartnode();
	self orientmode("face angle",var_02.angles[1]);
	if(!isdefined(var_02.var_82CB))
	{
		var_02.var_82CB = var_02.origin[2];
	}

	var_03 = var_02.var_82CB - var_02.origin[2];
	thread func_8022(var_03 - param_01);
	self.var_5474 = "land";
	self clearanim(%body,0.2);
	self setflaggedanimknoballrestart("dog_traverse",level.dogtraverseanims[param_00],1,0.2,1);
	animscripts/shared::func_2986("dog_traverse");
	self.var_5474 = undefined;
}