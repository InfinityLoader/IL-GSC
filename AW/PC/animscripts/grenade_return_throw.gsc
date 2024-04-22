/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: grenade_return_throw.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 4
 * Decompile Time: 65 ms
 * Timestamp: 4/22/2024 2:00:32 AM
*******************************************************************/

//Function Number: 1
main()
{
	self orientmode("face default");
	self endon("killanimscript");
	animscripts\utility::initialize("grenade_return_throw");
	self animmode("zonly_physics");
	var_00 = undefined;
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

	var_00 = var_02[randomint(var_02.size)];
	self setflaggedanimknoballrestart("throwanim",var_00,%body,1,0.3);
	var_04 = animhasnotetrack(var_00,"grenade_left") || animhasnotetrack(var_00,"grenade_right");
	if(var_04)
	{
		animscripts\shared::placeweaponon(self.weapon,"left");
		thread putweaponbackinrighthand();
		thread notifygrenadepickup("throwanim","grenade_left");
		thread notifygrenadepickup("throwanim","grenade_right");
		self waittill("grenade_pickup");
		self pickupgrenade();
		animscripts\battlechatter_ai::evaluateattackevent("grenade");
		if(isdefined(self.team))
		{
			maps\_dds::dds_notify_grenade(self.grenadeweapon,self.team == "allies",1);
		}

		self waittillmatch("grenade_throw","throwanim");
	}
	else
	{
		self waittillmatch("grenade_throw","throwanim");
		self pickupgrenade();
		animscripts\battlechatter_ai::evaluateattackevent("grenade");
		if(isdefined(self.team))
		{
			maps\_dds::dds_notify_grenade(self.grenadeweapon,self.team == "allies",1);
		}
	}

	if(isdefined(self.grenade))
	{
		self throwgrenade();
	}

	wait(1);
	if(var_04)
	{
		self notify("put_weapon_back_in_right_hand");
		animscripts\shared::placeweaponon(self.weapon,"right");
	}
}

//Function Number: 2
islowthrowsafe()
{
	var_00 = (self.origin[0],self.origin[1],self.origin[2] + 20);
	var_01 = var_00 + anglestoforward(self.angles) * 50;
	return sighttracepassed(var_00,var_01,0,undefined);
}

//Function Number: 3
putweaponbackinrighthand()
{
	self endon("death");
	self endon("put_weapon_back_in_right_hand");
	self waittill("killanimscript");
	animscripts\shared::placeweaponon(self.weapon,"right");
}

//Function Number: 4
notifygrenadepickup(param_00,param_01)
{
	self endon("killanimscript");
	self endon("grenade_pickup");
	self waittillmatch(param_01,param_00);
	self notify("grenade_pickup");
}