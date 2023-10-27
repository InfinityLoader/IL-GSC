/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\traverse\iw6_jumpup_72.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 4
 * Decompile Time: 79 ms
 * Timestamp: 10/27/2023 1:22:57 AM
*******************************************************************/

//Function Number: 1
func_4FDD()
{
	if(self.type == "dog")
	{
		animscripts/traverse/shared::func_28F2(72,5);
		return;
	}

	func_4F99();
}

//Function Number: 2
func_4F99()
{
	var_00 = [];
	var_00["traverseAnim"] = %traverse_72_up_run;
	var_00["traverseHeight"] = 72;
	func_2A21(var_00);
}

//Function Number: 3
func_2A21(param_00)
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
	self traversemode("gravity");
	self.var_82DC = self.origin[2];
	if(!animhasnotetrack(var_03,"traverse_align"))
	{
		animscripts/traverse/shared::func_3F9F();
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
	animscripts/shared::func_2986("traverseAnim",::func_3FA3);
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
}

//Function Number: 4
func_3FA3(param_00)
{
	if(param_00 == "traverse_death")
	{
		return animscripts/traverse/shared::handletraversedeathnotetrack();
	}

	if(param_00 == "traverse_align")
	{
		self.var_82DC = self.origin[2];
		return animscripts/traverse/shared::func_3F9F();
	}

	if(param_00 == "traverse_drop")
	{
		return animscripts/traverse/shared::func_3FA1();
	}
}