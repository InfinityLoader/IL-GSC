/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\grenade_return_throw.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 6
 * Decompile Time: 106 ms
 * Timestamp: 10/27/2023 2:44:13 AM
*******************************************************************/

//Function Number: 1
main()
{
	self orientmode("face default");
	self endon("killanimscript");
	animscripts\utility::initialize("grenade_return_throw");
	self animmode("zonly_physics");
	var_00 = undefined;
	if(level.h1_improved_grenade_returns)
	{
		var_00 = getgrenadereturnanim_h1();
	}
	else
	{
		var_00 = getgrenadereturnanim();
	}

	self setflaggedanimknoballrestart("throwanim",var_00,%body,1,0.3);
	var_01 = animhasnotetrack(var_00,"grenade_left") || animhasnotetrack(var_00,"grenade_right");
	if(var_01)
	{
		animscripts\shared::placeweaponon(self.weapon,"left");
		thread putweaponbackinrighthand();
		thread notifygrenadepickup("throwanim","grenade_left");
		thread notifygrenadepickup("throwanim","grenade_right");
		self waittill("grenade_pickup");
		self pickupgrenade();
		animscripts\battlechatter_ai::evaluateattackevent("grenade");
		self waittillmatch("grenade_throw","throwanim");
	}
	else
	{
		self waittillmatch("grenade_throw","throwanim");
		self pickupgrenade();
		animscripts\battlechatter_ai::evaluateattackevent("grenade");
	}

	if(isdefined(self.grenade))
	{
		self throwgrenade();
	}

	self waittillmatch("finish","throwanim");
	if(var_01)
	{
		self notify("put_weapon_back_in_right_hand");
		animscripts\shared::placeweaponon(self.weapon,"right");
	}
}

//Function Number: 2
getgrenadereturnanim()
{
	var_01 = 1000;
	if(isdefined(self.enemy))
	{
		var_01 = distance(self.origin,self.enemy.origin);
	}

	var_02 = [];
	if(var_01 < 600 && islowthrowsafe())
	{
		if(var_01 < 300)
		{
			if(animscripts\utility::usingsmg())
			{
				var_02 = animscripts\utility::lookupanim("grenade","return_throw_short_smg");
			}
			else
			{
				var_02 = animscripts\utility::lookupanim("grenade","return_throw_short");
			}
		}
		else if(animscripts\utility::usingsmg())
		{
			var_02 = animscripts\utility::lookupanim("grenade","return_throw_long_smg");
		}
		else
		{
			var_02 = animscripts\utility::lookupanim("grenade","return_throw_long");
		}
	}

	if(var_02.size == 0)
	{
		if(animscripts\utility::usingsmg())
		{
			var_02 = animscripts\utility::lookupanim("grenade","return_throw_default_smg");
		}
		else
		{
			var_02 = animscripts\utility::lookupanim("grenade","return_throw_default");
		}
	}

	return var_02[randomint(var_02.size)];
}

//Function Number: 3
getgrenadereturnanim_h1()
{
	var_00 = [];
	var_01 = self.grenadedanger;
	if(self.var_1D4)
	{
		var_01 = self.var_1D3 - self.grenade.origin;
	}

	var_02 = length2d(var_01);
	if(var_02 > 0)
	{
		var_01 = (var_01[0] / var_02,var_01[1] / var_02,0);
	}

	var_03 = length2dsquared(self.velocity);
	var_04 = anglestoforward(self.angles);
	if(var_03 > 1)
	{
		if(var_02 < 300 && islowthrowsafe())
		{
			var_00 = animscripts\utility::lookupanim("grenade","return_running_throw_short");
		}

		if(var_00.size == 0)
		{
			var_00 = animscripts\utility::lookupanim("grenade","return_running_throw_long");
		}
	}

	if(self.a.pose == "crouch")
	{
		if(self.prevscript == "cover_left")
		{
			if(animscripts\corner::hasonekneeup())
			{
				var_00 = animscripts\utility::lookupanim("grenade","return_cornercrl_1knee_throw");
			}
			else
			{
				var_00 = animscripts\utility::lookupanim("grenade","return_cornercrl_2knee_throw");
			}
		}
		else if(self.prevscript == "cover_right")
		{
			if(animscripts\corner::hasonekneeup())
			{
				var_00 = animscripts\utility::lookupanim("grenade","return_cornercrr_1knee_throw");
			}
			else
			{
				var_00 = animscripts\utility::lookupanim("grenade","return_cornercrr_2knee_throw");
			}
		}
		else if(self.prevscript == "cover_crouch")
		{
			var_00 = animscripts\utility::lookupanim("grenade","return_covercrouch_throw");
		}

		if(var_00.size == 0)
		{
			var_00 = animscripts\utility::lookupanim("grenade","return_crouching_throw");
		}
	}

	if(var_00.size == 0)
	{
		var_00 = animscripts\utility::lookupanim("grenade","return_standing_throw");
	}

	var_05 = vectordot(var_01,var_04);
	var_06 = var_01[0] * var_04[1] - var_04[0] * var_01[1];
	var_07 = atan2(var_06,var_05);
	var_08 = int(exp(var_07 + 180 / 90));
	var_08 = var_08 % var_00.size;
	return var_00[var_08];
}

//Function Number: 4
islowthrowsafe()
{
	var_00 = (self.origin[0],self.origin[1],self.origin[2] + 20);
	var_01 = var_00 + anglestoforward(self.angles) * 50;
	return sighttracepassed(var_00,var_01,0,undefined);
}

//Function Number: 5
putweaponbackinrighthand()
{
	self endon("death");
	self endon("put_weapon_back_in_right_hand");
	self waittill("killanimscript");
	animscripts\shared::placeweaponon(self.weapon,"right");
}

//Function Number: 6
notifygrenadepickup(param_00,param_01)
{
	self endon("killanimscript");
	self endon("grenade_pickup");
	self waittillmatch(param_01,param_00);
	self notify("grenade_pickup");
}