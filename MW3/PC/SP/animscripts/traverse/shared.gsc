/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\traverse\shared.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 14
 * Decompile Time: 262 ms
 * Timestamp: 10/27/2023 2:17:26 AM
*******************************************************************/

//Function Number: 1
func_3FE6(param_00,param_01)
{
	self.desired_anim_pose = "crouch";
	animscripts/utility::func_247B();
	self endon("killanimscript");
	self traversemode("nogravity");
	self traversemode("noclip");
	var_02 = self getnegotiationstartnode();
	self orientmode("face angle",var_02.angles[1]);
	var_03 = var_02.traverse_height - var_02.origin[2];
	thread func_3FE7(var_03 - param_01);
	var_04 = 0.15;
	self clearanim(%body,var_04);
	self setflaggedanimknoballrestart("traverse",param_00,%root,1,var_04,1);
	var_05 = 0.2;
	var_06 = 0.2;
	thread animscripts/notetracks::func_239E("traverse","no clear");
	if(!animhasnotetrack(param_00,"gravity on"))
	{
		var_07 = 1.23;
		wait var_07 - var_05;
		self traversemode("gravity");
		wait var_05;
		return;
	}

	self waittillmatch("gravity on","traverse");
	self traversemode("gravity");
	if(!animhasnotetrack(param_00,"blend"))
	{
		wait var_05;
		return;
	}

	self waittillmatch("blend","traverse");
}

//Function Number: 2
func_3FE7(param_00)
{
	self endon("killanimscript");
	self notify("endTeleportThread");
	self endon("endTeleportThread");
	var_01 = 5;
	var_02 = (0,0,param_00 / var_01);
	for(var_03 = 0;var_03 < var_01;var_03++)
	{
		self forceteleport(self.origin + var_02);
		wait 0.05;
	}
}

//Function Number: 3
func_3FE8(param_00,param_01,param_02,param_03)
{
	self endon("killanimscript");
	self notify("endTeleportThread");
	self endon("endTeleportThread");
	if(param_00 == 0 || param_02 <= 0)
	{
		return;
	}

	if(param_01 > 0)
	{
		wait param_01;
	}

	var_04 = (0,0,param_00 / param_02);
	if(isdefined(param_03) && param_03 < 1)
	{
		self setflaggedanimknoball("traverseAnim",self.var_3FEA,self.var_3FE9,1,0.2,param_03);
	}

	for(var_05 = 0;var_05 < param_02;var_05++)
	{
		self forceteleport(self.origin + var_04);
		wait 0.05;
	}

	if(isdefined(param_03) && param_03 < 1)
	{
		self setflaggedanimknoball("traverseAnim",self.var_3FEA,self.var_3FE9,1,0.2,1);
	}
}

//Function Number: 4
func_3FEB(param_00)
{
	self endon("killanimscript");
	self.desired_anim_pose = "stand";
	animscripts/utility::func_247B();
	var_01 = self getnegotiationstartnode();
	var_02 = self getnegotiationendnode();
	self orientmode("face angle",var_01.angles[1]);
	self.var_3FEC = param_00["traverseHeight"];
	self.var_3FED = var_01;
	var_03 = param_00["traverseAnim"];
	var_04 = param_00["traverseToCoverAnim"];
	self traversemode("nogravity");
	self traversemode("noclip");
	self.var_3FEE = self.origin[2];
	if(!animhasnotetrack(var_03,"traverse_align"))
	{
		func_3FF3();
	}

	var_05 = 0;
	if(isdefined(var_04) && isdefined(self.node) && self.node.type == param_00["coverType"] && distancesquared(self.node.origin,var_02.origin) < 625)
	{
		if(animscripts/utility::func_D61(self.node.angles[1] - var_02.angles[1]) > 160)
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

	self.var_3FEA = var_03;
	self.var_3FE9 = %body;
	self setflaggedanimknoballrestart("traverseAnim",var_03,%body,1,0.2,1);
	self.var_3FEF = 0;
	self.var_3FF0 = param_00["interruptDeathAnim"];
	animscripts/shared::donotetracks("traverseAnim",::func_3FF1);
	self traversemode("gravity");
	if(self.var_744)
	{
		return;
	}

	self.a.var_D55 = 0;
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

	self.var_3FE9 = undefined;
	self.var_3FEA = undefined;
	self.deathanim = undefined;
}

//Function Number: 5
func_3FF1(param_00)
{
	if(param_00 == "traverse_death")
	{
		return func_3FF2();
	}

	if(param_00 == "traverse_align")
	{
		return func_3FF3();
	}

	if(param_00 == "traverse_drop")
	{
		return func_3FF4();
	}
}

//Function Number: 6
func_3FF2()
{
	if(isdefined(self.var_3FF0))
	{
		var_00 = self.var_3FF0[self.var_3FEF];
		self.deathanim = var_00[randomint(var_00.size)];
		self.var_3FEF++;
	}
}

//Function Number: 7
func_3FF3()
{
	self traversemode("nogravity");
	self traversemode("noclip");
	if(isdefined(self.var_3FEC) && isdefined(self.var_3FED.traverse_height))
	{
		var_00 = self.var_3FED.traverse_height - self.var_3FEE;
		thread func_3FE7(var_00 - self.var_3FEC);
	}
}

//Function Number: 8
func_3FF4()
{
	var_00 = self.origin + (0,0,32);
	var_01 = bullettrace(var_00,self.origin + (0,0,-512),0,undefined);
	var_02 = var_01["position"];
	var_03 = distance(var_00,var_02);
	var_04 = var_03 - 32 - 0.5;
	var_05 = self getanimtime(self.var_3FEA);
	var_06 = getmovedelta(self.var_3FEA,var_05,1);
	var_07 = getanimlength(self.var_3FEA);
	var_08 = 0 - var_06[2];
	var_09 = var_08 - var_04;
	if(var_08 < var_04)
	{
		var_0A = var_08 / var_04;
	}
	else
	{
		var_0A = 1;
	}

	var_0B = var_07 - var_05 / 3;
	var_0C = ceil(var_0B * 20);
	thread func_3FE8(var_09,0,var_0C,var_0A);
	thread func_3FF5(var_02[2]);
}

//Function Number: 9
func_3FF5(param_00)
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

		wait 0.05;
	}
}

//Function Number: 10
func_3FF6()
{
	self animmode("zonly_physics");
	self waittill("killanimscript");
}

//Function Number: 11
func_3FF7(param_00,param_01)
{
	self endon("killanimscript");
	self traversemode("nogravity");
	self traversemode("noclip");
	var_02 = self getnegotiationstartnode();
	self orientmode("face angle",var_02.angles[1]);
	var_03 = var_02.traverse_height - var_02.origin[2];
	thread func_3FE7(var_03 - param_01);
	self clearanim(%root,0.2);
	self setflaggedanimrestart("dog_traverse",level.var_3AF6[param_00],1,0.2,1);
	animscripts/shared::donotetracks("dog_traverse");
	self.var_3B58 = 1;
}

//Function Number: 12
func_3FF8(param_00,param_01)
{
	self endon("killanimscript");
	self traversemode("noclip");
	var_02 = self getnegotiationstartnode();
	self orientmode("face angle",var_02.angles[1]);
	var_03 = self getnegotiationstartnode().origin[2] - self getnegotiationendnode().origin[2];
	self.var_3FEA = level.var_3AF6["jump_down_40"];
	self.var_3FE9 = %root;
	thread func_3FE8(40 - var_03,0.1,param_00,param_01);
	self clearanim(%root,0.2);
	self setflaggedanimrestart("traverseAnim",self.var_3FEA,1,0.2,1);
	animscripts/shared::donotetracks("traverseAnim");
	self clearanim(self.var_3FEA,0);
	self traversemode("gravity");
	self.var_3B58 = 1;
	self.var_3FE9 = undefined;
	self.var_3FEA = undefined;
}

//Function Number: 13
func_3FF9(param_00,param_01)
{
	self endon("killanimscript");
	self traversemode("noclip");
	var_02 = self getnegotiationstartnode();
	self orientmode("face angle",var_02.angles[1]);
	thread func_3FE8(param_00 - 40,0.2,param_01);
	self clearanim(%root,0.25);
	self setflaggedanimrestart("traverseAnim",level.var_3AF6["jump_up_40"],1,0.2,1);
	animscripts/shared::donotetracks("traverseAnim");
	self clearanim(level.var_3AF6["jump_up_40"],0);
	self traversemode("gravity");
	self.var_3B58 = 1;
}

//Function Number: 14
func_0176(param_00,param_01)
{
	self endon("killanimscript");
	self traversemode("nogravity");
	self traversemode("noclip");
	var_02 = self getnegotiationstartnode();
	self orientmode("face angle",var_02.angles[1]);
	if(!isdefined(var_02.traverse_height))
	{
		var_02.traverse_height = var_02.origin[2];
	}

	var_03 = var_02.traverse_height - var_02.origin[2];
	thread func_3FE7(var_03 - param_01);
	self clearanim(%root,0.2);
	self setflaggedanimrestart("dog_traverse",level.var_3AF6[param_00],1,0.2,1);
	animscripts/shared::donotetracks("dog_traverse");
	self.var_3B58 = 1;
}