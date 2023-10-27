/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\grenade_return_throw.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 4
 * Decompile Time: 83 ms
 * Timestamp: 10/27/2023 2:18:21 AM
*******************************************************************/

//Function Number: 1
main()
{
	self orientmode("face default");
	self endon("killanimscript");
	animscripts/utility::func_D15("grenade_return_throw");
	self animmode("zonly_physics");
	var_00 = undefined;
	var_01 = 1000;
	if(isdefined(self.enemy))
	{
		var_01 = distance(self.origin,self.enemy.origin);
	}

	var_02 = [];
	if(var_01 < 600 && func_3FE1())
	{
		if(var_01 < 300)
		{
		}
		else
		{
		}
	}

	if(var_7B.size == 0)
	{
	}

	var_01 = var_7B[randomint(var_7B.size)];
	self setflaggedanimknoballrestart("throwanim",var_01,%body,1,0.3);
	var_04 = animhasnotetrack(var_01,"grenade_left") || animhasnotetrack(var_01,"grenade_right");
	if(var_04)
	{
		animscripts/shared::func_C9B(self.weapon,"left");
		thread func_3FE2();
		thread func_3FE3("throwanim","grenade_left");
		thread func_3FE3("throwanim","grenade_right");
		self waittill(%grenade_return_running_throw_forward,var_7B[0],%grenade_return_standing_throw_forward_1,var_7B[1],%grenade_return_running_throw_forward,var_7B[0],%grenade_return_standing_throw_overhand_forward,var_7B[1],%grenade_return_standing_throw_overhand_forward,var_7B[0],"grenade_pickup");
		self pickupgrenade();
		animscripts/battlechatter_ai::func_B3A("grenade");
		self waittillmatch("grenade_throw","throwanim");
	}
	else
	{
		self waittillmatch("grenade_throw","throwanim");
		self pickupgrenade();
		animscripts/battlechatter_ai::func_B3A("grenade");
	}

	if(isdefined(self.var_73C))
	{
		self throwgrenade();
	}

	wait 1;
	if(var_04)
	{
		self notify("put_weapon_back_in_right_hand");
		animscripts/shared::func_C9B(self.weapon,"right");
	}
}

//Function Number: 2
func_3FE1()
{
	var_00 = (self.origin[0],self.origin[1],self.origin[2] + 20);
	var_01 = var_00 + anglestoforward(self.angles) * 50;
	return sighttracepassed(var_00,var_01,0,undefined);
}

//Function Number: 3
func_3FE2()
{
	self endon("death");
	self endon("put_weapon_back_in_right_hand");
	self waittill("killanimscript");
	animscripts/shared::func_C9B(self.weapon,"right");
}

//Function Number: 4
func_3FE3(param_00,param_01)
{
	self endon("killanimscript");
	self endon("grenade_pickup");
	self waittillmatch(param_01,param_00);
	self notify("grenade_pickup");
}