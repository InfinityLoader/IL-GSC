/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\killstreaks\_designator_grenade.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 7
 * Decompile Time: 137 ms
 * Timestamp: 10/27/2023 1:20:38 AM
*******************************************************************/

//Function Number: 1
designator_start(param_00,param_01,param_02)
{
	self endon("death");
	self.marker = undefined;
	if(self getcurrentweapon() == param_01)
	{
		thread designator_disableusabilityduringgrenadepullback(param_01);
		thread designator_waitforgrenadefire(param_00,param_01,param_02);
		func_2613(param_01);
		return !self getammocount(param_01) && self hasweapon(param_01);
	}

	return 0;
}

//Function Number: 2
designator_disableusabilityduringgrenadepullback(param_00)
{
	self endon("death");
	self endon("disconnect");
	var_01 = "";
	while(var_01 != param_00)
	{
		self waittill("grenade_pullback",var_01);
	}

	common_scripts\utility::_disableusability();
	designator_enableusabilitywhendesignatorfinishes();
}

//Function Number: 3
designator_enableusabilitywhendesignatorfinishes()
{
	self endon("death");
	self endon("disconnect");
	common_scripts\utility::func_8B2A("grenade_fire","weapon_change");
	common_scripts\utility::_enableusability();
}

//Function Number: 4
designator_waitforgrenadefire(param_00,param_01,param_02)
{
	self endon("designator_finished");
	self endon("spawned_player");
	self endon("disconnect");
	var_03 = undefined;
	var_04 = "";
	while(var_04 != param_01)
	{
		self waittill("grenade_fire",var_03,var_04);
	}

	if(isalive(self))
	{
		var_03.owner = self;
		var_03.weaponname = param_01;
		self.marker = var_03;
		thread designator_ontargetacquired(param_00,var_03,param_02);
	}
	else
	{
		var_03 delete();
	}

	self notify("designator_finished");
}

//Function Number: 5
func_2613(param_00)
{
	self endon("spawned_player");
	self endon("disconnect");
	var_01 = self getcurrentweapon();
	while(var_01 == param_00)
	{
		self waittill("weapon_change",var_01);
	}

	if(self getammocount(param_00) == 0)
	{
		func_2610(param_00);
	}

	self notify("designator_finished");
}

//Function Number: 6
func_2610(param_00)
{
	if(self hasweapon(param_00))
	{
		self takeweapon(param_00);
	}
}

//Function Number: 7
designator_ontargetacquired(param_00,param_01,param_02)
{
	param_01 waittill("missile_stuck",var_03);
	if(isdefined(param_01.owner))
	{
		self thread [[ param_02 ]](param_00,param_01);
	}

	if(isdefined(param_01))
	{
		param_01 delete();
	}
}