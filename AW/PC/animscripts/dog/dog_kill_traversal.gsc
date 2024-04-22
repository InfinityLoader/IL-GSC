/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: dog\dog_kill_traversal.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 6
 * Decompile Time: 94 ms
 * Timestamp: 4/22/2024 1:58:46 AM
*******************************************************************/

//Function Number: 1
check_kill_traversal(param_00)
{
	if(self.team != "allies")
	{
		return 0;
	}

	self endon("killanimscript");
	var_01 = self getnegotiationstartnode();
	var_02 = self getnegotiationendnode();
	var_03 = getaiarray("axis");
	var_04 = undefined;
	var_05 = dog_get_within_range(var_02.origin,var_03,90);
	if(var_05.size > 0)
	{
		var_06 = var_05[0];
		var_07 = lengthsquared(var_01.origin - var_02.origin);
		var_08 = lengthsquared(var_01.origin - var_06.origin);
		if(var_08 < var_07)
		{
			self.syncedmeleetarget2 = var_06;
			var_06.syncedmeleetarget2 = self;
			var_06.traversedata = param_00;
			var_09 = [];
			var_09[0][0] = 400;
			var_09[0][1] = "blood_small";
			var_09[0][2] = "J_Neck";
			var_09[1][0] = 2300;
			var_09[1][1] = "blood_medium";
			var_09[1][2] = "J_Neck";
			var_09[2][0] = 2600;
			var_09[2][1] = "blood_medium";
			var_09[2][2] = "J_Neck";
			var_09[3][0] = 3300;
			var_09[3][1] = "blood_heavy";
			var_09[3][2] = "J_Neck";
			var_06 thread monitorfx(var_09);
			var_06 animcustom(::human_traverse_kill);
			self orientmode("face angle",var_01.angles[1]);
			dog_traverse_kill(param_00);
			return 1;
		}
	}

	return 0;
}

//Function Number: 2
dog_get_within_range(param_00,param_01,param_02)
{
	var_03 = [];
	for(var_04 = 0;var_04 < param_01.size;var_04++)
	{
		if(distance(param_01[var_04].origin,param_00) <= param_02)
		{
			var_03[var_03.size] = param_01[var_04];
		}
	}

	return var_03;
}

//Function Number: 3
dog_traverse_kill(param_00)
{
	self.safetochangescript = 0;
	self.orig_flashbangimmunity = self.flashbangimmunity;
	self.flashbangimmunity = 1;
	self.pushable = 0;
	self traversemode("nogravity");
	self traversemode("noclip");
	self clearpitchorient();
	self setcandamage(0);
	self clearanim(%body,0.1);
	self setflaggedanimrestart("dog_traverse",level.scr_anim["generic"][param_00["traverseAnim"]][0],1,0.2,1);
	animscripts\shared::donotetracks("dog_traverse");
	self unlink();
	self setcandamage(1);
	self traversemode("gravity");
	self.pushable = 1;
	self.safetochangescript = 1;
	self.flashbangimmunity = self.orig_flashbangimmunity;
}

//Function Number: 4
human_traverse_kill()
{
	self endon("killanimscript");
	self endon("death");
	self orientmode("face point",self.syncedmeleetarget2.origin,1);
	self animmode("nogravity");
	self.a.pose = "stand";
	self.a.special = "none";
	if(animscripts\utility::usingsidearm())
	{
		animscripts\shared::placeweaponon(self.primaryweapon,"right");
	}

	self clearanim(%body,0.1);
	self setflaggedanimrestart("aianim",level.scr_anim["generic"][self.traversedata["traverseAnim"]][1],1,0.1,1);
	if(isdefined(self.traversedata["linkMe"]))
	{
		thread dog_link();
	}

	animscripts\shared::donotetracks("aianim");
	self waittillmatch("end","aianim");
	if(isalive(self) && !isdefined(self.magic_bullet_shield))
	{
		self.a.nodeath = 1;
		animscripts\shared::dropallaiweapons();
		self kill();
	}
}

//Function Number: 5
monitorfx(param_00)
{
	self endon("death");
	var_01 = 0;
	var_02 = gettime();
	while(var_01 < param_00.size)
	{
		var_03 = gettime() - var_02;
		if(var_03 >= param_00[var_01][0])
		{
			playfxontag(level._effect[param_00[var_01][1]],self,param_00[var_01][2]);
			var_01++;
		}

		wait(0.05);
	}
}

//Function Number: 6
dog_link()
{
	wait(0.15);
	self.syncedmeleetarget2 linkto(self,"tag_sync",(0,0,0),(0,0,0));
}