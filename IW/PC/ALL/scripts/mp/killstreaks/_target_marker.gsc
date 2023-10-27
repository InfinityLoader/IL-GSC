/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\killstreaks\_target_marker.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 8
 * Decompile Time: 376 ms
 * Timestamp: 10/27/2023 12:29:46 AM
*******************************************************************/

//Function Number: 1
init()
{
}

//Function Number: 2
func_819B(param_00,param_01)
{
	scripts\common\utility::func_1C6E(0);
	self setscriptablepartstate("killstreak","visor_active",0);
	scripts\mp\_utility::func_1254();
	scripts\mp\_utility::func_1C47(0);
	var_02 = undefined;
	if(param_00.var_110EA == "dronedrop")
	{
		var_02 = "deploy_dronepackage_mp";
	}
	else if(param_00.var_110EA == "remote_c8")
	{
		var_02 = "deploy_rc8_mp";
	}
	else
	{
		var_02 = "deploy_warden_mp";
	}

	var_03 = undefined;
	thread func_13A47(var_02);
	thread func_13A2F(var_02);
	thread watchforphaseshiftuse(var_02);
	thread watchforempapply(var_02);
	if(!isai(self))
	{
		self notifyonplayercommand("equip_deploy_end","+actionslot 4");
		if(!level.console)
		{
			self notifyonplayercommand("equip_deploy_end","+actionslot 5");
			self notifyonplayercommand("equip_deploy_end","+actionslot 6");
			self notifyonplayercommand("equip_deploy_end","+actionslot 7");
		}
	}

	for(;;)
	{
		var_03 = func_13808("equip_deploy_succeeded","equip_deploy_failed","equip_deploy_end");
		if(var_03.var_11145 == "equip_deploy_failed")
		{
			continue;
		}
		else
		{
			if(var_03.var_11145 == "equip_deploy_succeeded")
			{
				if(isdefined(param_01))
				{
					if(!self [[ param_01 ]]())
					{
						continue;
					}
					else
					{
						break;
					}
				}
				else
				{
					break;
				}

				continue;
			}

			break;
		}
	}

	if(isdefined(var_03.var_AEC4) && isdefined(var_03.angles))
	{
		var_03.var_1349C = spawn("script_model",var_03.var_AEC4);
		var_03.var_1349C setmodel("ks_marker_mp");
		var_03.var_1349C method_831F(self);
		var_03.var_1349C setscriptablepartstate("target","placed",0);
		var_03.var_1349C method_85C8(1);
	}

	if(scripts\mp\_utility::func_9F19(self))
	{
		self notify("killstreak_finished_with_weapon_" + var_02);
	}

	self setscriptablepartstate("killstreak","neutral",0);
	scripts\mp\_utility::func_11DB();
	scripts\mp\_utility::func_1C47(1);
	thread scripts\common\utility::func_5127(0.05,::scripts\common\utility::func_1C6E,1);
	return var_03;
}

//Function Number: 3
func_13A47(param_00)
{
	self endon("disconnect");
	self endon("killstreak_finished_with_weapon_" + param_00);
	for(;;)
	{
		if(self getcurrentweapon() != param_00)
		{
			self notify("equip_deploy_end");
			break;
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 4
func_13A2F(param_00)
{
	self endon("disconnect");
	self endon("killstreak_finished_with_weapon_" + param_00);
	var_01 = self getweaponammoclip(param_00);
	for(;;)
	{
		self waittill("weapon_fired",var_02);
		if(var_02 == param_00)
		{
			self setweaponammoclip(var_02,var_01);
		}
	}
}

//Function Number: 5
watchforphaseshiftuse(param_00)
{
	self endon("disconnect");
	self endon("killstreak_finished_with_weapon_" + param_00);
	for(;;)
	{
		if(self method_84D9())
		{
			self notify("equip_deploy_end");
			break;
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 6
watchforempapply(param_00)
{
	self endon("disconnect");
	self endon("killstreak_finished_with_weapon_" + param_00);
	self waittill("apply_player_emp");
	self notify("equip_deploy_end");
}

//Function Number: 7
func_13808(param_00,param_01,param_02)
{
	var_03 = spawnstruct();
	if(isdefined(param_00))
	{
		childthread func_137F9(param_00,var_03);
	}

	if(isdefined(param_01))
	{
		childthread func_137F9(param_01,var_03);
	}

	if(isdefined(param_02))
	{
		childthread func_137F9(param_02,var_03);
	}

	childthread func_137F9("death",var_03);
	var_03 waittill("returned",var_04,var_05,var_06,var_07);
	var_03 notify("die");
	var_08 = spawnstruct();
	var_08.var_394 = var_04;
	var_08.var_AEC4 = var_05;
	var_08.angles = var_06;
	var_08.var_11145 = var_07;
	return var_08;
}

//Function Number: 8
func_137F9(param_00,param_01)
{
	if(param_00 != "death")
	{
		self endon("death");
	}

	param_01 endon("die");
	self waittill(param_00,var_02,var_03,var_04);
	param_01 notify("returned",var_02,var_03,var_04,param_00);
}