/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\perks\_perk_rearguard_shield.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 5
 * Decompile Time: 214 ms
 * Timestamp: 10/27/2023 12:30:04 AM
*******************************************************************/

//Function Number: 1
func_E814()
{
	if(!isdefined(self.var_8C19))
	{
		var_00 = self gettagorigin("tag_shield_back");
		var_01 = spawn("script_origin",var_00);
		var_01 linkto(self,"tag_shield_back");
		self attachshieldmodel("weapon_rearguard_shield_wm_mp","tag_shield_back");
		self.var_8C19 = 1;
		self.rearguardattackers = [];
		self setclientomnvar("ui_dodge_charges",6);
		var_01 thread func_D415(self);
		var_01 thread func_D416(self);
		var_01 thread func_13A34(self);
		var_01 method_831F(self);
		var_01 setcandamage(1);
	}
}

//Function Number: 2
func_13A34(param_00)
{
	param_00 endon("death");
	param_00 endon("disconnect");
	param_00 endon("remove_rearguard");
	self endon("death");
	if(level.var_8B38)
	{
		var_01 = 10;
	}
	else
	{
		var_01 = 30;
	}

	while(param_00.var_FC96 < var_01)
	{
		wait(0.05);
	}

	func_E168("damaged",param_00);
}

//Function Number: 3
func_D416(param_00)
{
	self endon("disconnect");
	self endon("death");
	param_00 waittill("death");
	func_E168("died",param_00);
}

//Function Number: 4
func_D415(param_00)
{
	self endon("death");
	param_00 waittill("disconnect");
	func_E168("disconnect",param_00);
}

//Function Number: 5
func_E168(param_00,param_01)
{
	level endon("game_ended");
	self endon("death");
	if(isdefined(param_01) && scripts\mp\_utility::func_9FB3(param_01.var_8C19) && param_00 == "damaged")
	{
		param_01 detachshieldmodel("weapon_rearguard_shield_wm_mp","tag_shield_back");
	}

	if(param_00 != "disconnect")
	{
		param_01 setclientomnvar("ui_dodge_charges",0);
	}

	waittillframeend;
	self notify("death");
	self delete();
}