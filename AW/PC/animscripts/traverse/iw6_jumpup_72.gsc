/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: traverse\iw6_jumpup_72.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 4
 * Decompile Time: 72 ms
 * Timestamp: 4/22/2024 1:59:24 AM
*******************************************************************/

//Function Number: 1
main()
{
	if(self.type == "dog")
	{
		animscripts\traverse\shared::dog_jump_up(72,5);
		return;
	}

	low_wall_human();
}

//Function Number: 2
low_wall_human()
{
	var_00 = [];
	var_00["traverseAnim"] = %traverse_72_up_run;
	var_00["traverseHeight"] = 72;
	dotraversegravity(var_00);
}

//Function Number: 3
dotraversegravity(param_00)
{
	self endon("killanimscript");
	self.desired_anim_pose = "stand";
	animscripts\utility::updateanimpose();
	var_01 = self getnegotiationstartnode();
	var_01.traverse_height = var_01.origin[2] + var_01.traverse_height_delta;
	var_02 = self getnegotiationendnode();
	self orientmode("face angle",var_01.angles[1]);
	self.traverseheight = param_00["traverseHeight"];
	self.traversestartnode = var_01;
	var_03 = param_00["traverseAnim"];
	var_04 = param_00["traverseToCoverAnim"];
	self traversemode("gravity");
	self.traversestartz = self.origin[2];
	if(!animhasnotetrack(var_03,"traverse_align"))
	{
		animscripts\traverse\shared::handletraversealignment();
	}

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
	self.traverseanimroot = %body;
	self setflaggedanimknoballrestart("traverseAnim",var_03,%body,1,0.2,1);
	self.traversedeathindex = 0;
	self.traversedeathanim = param_00["interruptDeathAnim"];
	animscripts\shared::donotetracks("traverseAnim",::handletraversenotetracksgravity);
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

	self.traverseanimroot = undefined;
	self.traverseanim = undefined;
	self.deathanim = undefined;
}

//Function Number: 4
handletraversenotetracksgravity(param_00)
{
	if(param_00 == "traverse_death")
	{
		return animscripts\traverse\shared::handletraversedeathnotetrack();
	}

	if(param_00 == "traverse_align")
	{
		self.traversestartz = self.origin[2];
		return animscripts\traverse\shared::handletraversealignment();
	}

	if(param_00 == "traverse_drop")
	{
		return animscripts\traverse\shared::handletraversedrop();
	}
}