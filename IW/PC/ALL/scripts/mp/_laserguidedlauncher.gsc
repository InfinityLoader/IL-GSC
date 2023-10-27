/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\_laserguidedlauncher.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 23
 * Decompile Time: 895 ms
 * Timestamp: 10/27/2023 12:20:45 AM
*******************************************************************/

//Function Number: 1
func_AC0B(param_00,param_01)
{
}

//Function Number: 2
func_AC1A(param_00,param_01)
{
	self endon("death");
	self endon("disconnect");
	self endon("faux_spawn");
	thread func_AC13();
	var_02 = self getcurrentweapon();
	for(;;)
	{
		while(var_02 != param_00)
		{
			self waittill("weapon_change",var_02);
		}

		childthread func_AC08(var_02,param_01);
		self waittill("weapon_change",var_02);
		func_AC07();
	}
}

//Function Number: 3
func_AC13()
{
	self endon("LGM_player_endMonitorFire");
	scripts\common\utility::waittill_any_3("death","disconnect");
	if(isdefined(self))
	{
		func_AC04();
	}
}

//Function Number: 4
func_AC07()
{
	func_AC04();
	self notify("LGM_player_endMonitorFire");
}

//Function Number: 5
func_AC08(param_00,param_01,param_02)
{
	self endon("LGM_player_endMonitorFire");
	func_AC05();
	var_03 = undefined;
	for(;;)
	{
		var_04 = undefined;
		self waittill("missile_fire",var_04,var_05);
		if(isdefined(var_04.var_9E8F) && var_04.var_9E8F)
		{
			continue;
		}

		if(var_05 != param_00)
		{
			continue;
		}

		if(!isdefined(var_03))
		{
			var_03 = func_AC17(self);
		}

		thread func_AC06(param_00,param_01,param_02,0.35,0.1,var_04,var_03);
	}
}

//Function Number: 6
func_AC06(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	self notify("monitor_laserGuidedMissile_delaySpawnChildren");
	self endon("monitor_laserGuidedMissile_delaySpawnChildren");
	self endon("death");
	self endon("LGM_player_endMonitorFire");
	func_AC12(param_06);
	wait(param_03);
	if(!isvalidmissile(param_05))
	{
		return;
	}

	var_07 = param_05.origin;
	var_08 = anglestoforward(param_05.angles);
	var_09 = anglestoup(param_05.angles);
	var_0A = anglestoright(param_05.angles);
	param_05 delete();
	playfx(level._effect["laser_guided_launcher_missile_split"],var_07,var_08,var_09);
	var_0B = [];
	for(var_0C = 0;var_0C < 2;var_0C++)
	{
		var_0D = 20;
		var_0E = 0;
		if(var_0C == 0)
		{
			var_0E = 20;
		}
		else if(var_0C == 1)
		{
			var_0E = -20;
		}
		else if(var_0C == 2)
		{
		}

		var_0F = rotatepointaroundvector(var_0A,var_08,var_0D);
		var_0F = rotatepointaroundvector(var_09,var_0F,var_0E);
		var_10 = scripts\mp\_utility::func_1309(param_01,var_07,var_07 + var_0F * 180,self);
		var_10.var_9E8F = 1;
		var_0B[var_0B.size] = var_10;
		scripts\common\utility::func_136F7();
	}

	wait(param_04);
	var_0B = func_AC16(var_0B);
	if(var_0B.size > 0)
	{
		foreach(var_12 in var_0B)
		{
			param_06.var_B8AC[param_06.var_B8AC.size] = var_12;
			var_12 missile_settargetent(param_06);
			thread func_AC15(param_06,var_12);
		}

		thread func_AC09(param_06,param_02);
	}
}

//Function Number: 7
func_AC15(param_00,param_01)
{
	param_01 scripts\common\utility::waittill_any_3("death","missile_pairedWithFlare","LGM_missile_abandoned");
	if(isdefined(param_00.var_B8AC) && param_00.var_B8AC.size > 0)
	{
		param_00.var_B8AC = scripts\common\utility::func_22A9(param_00.var_B8AC,param_01);
		param_00.var_B8AC = func_AC16(param_00.var_B8AC);
	}

	if(!isdefined(param_00.var_B8AC) || param_00.var_B8AC.size == 0)
	{
		self notify("LGM_player_allMissilesDestroyed");
	}
}

//Function Number: 8
func_AC09(param_00,param_01)
{
	self notify("LGM_player_newMissilesFired");
	self endon("LGM_player_newMissilesFired");
	self endon("LGM_player_allMissilesDestroyed");
	self endon("LGM_player_endMonitorFire");
	self endon("death");
	self endon("disconnect");
	var_02 = undefined;
	var_03 = undefined;
	var_04 = undefined;
	var_05 = 0;
	var_06 = gettime() + 400;
	while(isdefined(param_00.var_B8AC) && param_00.var_B8AC.size > 0)
	{
		var_07 = func_AC18();
		if(!isdefined(var_07))
		{
			if(isdefined(var_03))
			{
				self notify("LGM_player_targetLost");
				var_03 = undefined;
				foreach(var_09 in param_00.var_B8AC)
				{
					var_09 notify("missile_targetChanged");
				}
			}

			var_04 = undefined;
			var_05 = 0;
			var_0B = scripts\common\utility::func_116D7(gettime() > var_06,8000,800);
			var_0C = anglestoforward(self getplayerangles());
			var_0D = self geteye() + var_0C * 12;
			var_0E = bullettrace(var_0D,var_0D + var_0C * var_0B,1,self,0,0,0);
			var_02 = var_0E["position"];
		}
		else
		{
			var_02 = var_07.origin;
			var_0F = !isdefined(var_03) || var_07 != var_03;
			var_03 = var_07;
			if(var_0F || !isdefined(var_04))
			{
				var_04 = gettime() + 1500;
				level thread func_AC11(var_03,self);
			}
			else if(gettime() >= var_04)
			{
				var_05 = 1;
				self notify("LGM_player_lockedOn");
			}

			if(var_05)
			{
				waittillframeend;
				if(param_00.var_B8AC.size > 0)
				{
					var_10 = [];
					foreach(var_09 in param_00.var_B8AC)
					{
						if(!isvalidmissile(var_09))
						{
							continue;
						}

						var_10[var_10.size] = var_09.origin;
						var_09 notify("missile_targetChanged");
						var_09 notify("LGM_missile_abandoned");
						var_09 delete();
					}

					if(var_10.size > 0)
					{
						level thread func_AC0E(var_03,self,param_01,var_10);
					}

					param_00.var_B8AC = [];
				}
				else
				{
					break;
				}
			}
			else if(var_0F)
			{
				func_AC19(var_03,self,param_00.var_B8AC);
			}
		}

		param_00.origin = var_02;
		scripts\common\utility::func_136F7();
	}
}

//Function Number: 9
func_AC17(param_00)
{
	if(!isdefined(level.var_A875))
	{
		level.var_A875 = [];
	}

	if(!isdefined(level.var_A876))
	{
		level.var_A876 = [];
	}

	var_01 = undefined;
	if(level.var_A876.size)
	{
		var_01 = level.var_A876[0];
		level.var_A876 = scripts\common\utility::func_22A9(level.var_A876,var_01);
	}
	else
	{
		var_01 = spawn("script_origin",param_00.origin);
	}

	level.var_A875[level.var_A875.size] = var_01;
	level thread func_AC14(var_01,param_00);
	var_01.var_B8AC = [];
	return var_01;
}

//Function Number: 10
func_AC14(param_00,param_01)
{
	param_01 scripts\common\utility::waittill_any_3("death","disconnect","LGM_player_endMonitorFire");
	foreach(var_03 in param_00.var_B8AC)
	{
		if(isvalidmissile(var_03))
		{
			var_03 missile_cleartarget();
		}
	}

	param_00.var_B8AC = undefined;
	level.var_A875 = scripts\common\utility::func_22A9(level.var_A875,param_00);
	if(level.var_A876.size + level.var_A875.size < 4)
	{
		level.var_A876[level.var_A876.size] = param_00;
		return;
	}

	param_00 delete();
}

//Function Number: 11
func_AC11(param_00,param_01)
{
	var_02 = scripts\mp\_utility::func_C794(param_00,"orange",param_01,1,0,"killstreak_personal");
	level thread func_AC0F(param_01,"maaws_reticle_tracking",1.5,"LGM_player_lockingDone");
	level thread func_AC10(param_00,param_01);
	param_01 scripts\common\utility::waittill_any_3("death","disconnect","LGM_player_endMonitorFire","LGM_player_newMissilesFired","LGM_player_targetLost","LGM_player_lockedOn","LGM_player_allMissilesDestroyed","LGM_player_targetDied");
	if(isdefined(param_00))
	{
		scripts\mp\_utility::func_C78F(var_02,param_00);
	}

	if(isdefined(param_01))
	{
		param_01 notify("LGM_player_lockingDone");
		param_01 stoplocalsound("maaws_reticle_tracking");
	}
}

//Function Number: 12
func_AC0C(param_00,param_01,param_02)
{
	param_01 endon("death");
	param_00 waittill("death");
	param_01.var_AC03[param_02] = scripts\common\utility::func_22A9(param_01.var_AC03[param_02],param_00);
	if(param_01.var_AC03[param_02].size == 0)
	{
		param_01.var_AC03[param_02] = undefined;
		param_01 notify("LGM_target_lockedMissilesDestroyed");
	}
}

//Function Number: 13
func_AC10(param_00,param_01)
{
	param_01 endon("death");
	param_01 endon("disconnect");
	param_01 endon("LGM_player_lockingDone");
	param_00 waittill("death");
	param_01 notify("LGM_player_targetDied");
}

//Function Number: 14
func_AC0F(param_00,param_01,param_02,param_03)
{
	param_00 endon("death");
	param_00 endon("disconnect");
	param_00 endon(param_03);
	for(;;)
	{
		param_00 playlocalsound(param_01);
		wait(param_02);
	}
}

//Function Number: 15
func_AC0D(param_00,param_01,param_02,param_03)
{
	param_00 endon("death");
	param_01 endon("death");
	param_01 endon("disconnect");
	var_04 = [];
	for(var_05 = 0;var_05 < param_03.size;var_05++)
	{
		var_06 = scripts\mp\_utility::func_1309(param_02,param_03[var_05],param_00.origin,param_01);
		var_06.var_9E8F = 1;
		var_04[var_04.size] = var_06;
		playfx(level._effect["laser_guided_launcher_missile_spawn_homing"],var_06.origin,anglestoforward(var_06.angles),anglestoup(var_06.angles));
		scripts\common\utility::func_136F7();
	}

	return var_04;
}

//Function Number: 16
func_AC0E(param_00,param_01,param_02,param_03)
{
	if(param_03.size == 0)
	{
		return;
	}

	var_04 = func_AC0D(param_00,param_01,param_02,param_03);
	if(!isdefined(var_04))
	{
		return;
	}

	var_04 = func_AC16(var_04);
	if(var_04.size == 0)
	{
		return;
	}

	param_01 playlocalsound("maaws_reticle_locked");
	var_05 = scripts\mp\_utility::func_C794(param_00,"red",param_01,0,0,"killstreak_personal");
	var_06 = func_AC0A(param_00);
	foreach(var_08 in var_04)
	{
		var_08 scripts\common\utility::func_B82F(param_00,"direct",var_06);
		func_AC19(param_00,param_01,var_04);
	}

	if(!isdefined(param_00.var_AC03))
	{
		param_00.var_AC03 = [];
	}

	param_00.var_AC03[var_05] = var_04;
	foreach(var_0B in var_04)
	{
		level thread func_AC0C(var_0B,param_00,var_05);
	}

	var_0D = 1;
	while(var_0D)
	{
		var_0E = param_00 scripts\common\utility::func_13734("death","LGM_target_lockedMissilesDestroyed");
		if(var_0E == "death")
		{
			var_0D = 0;
			if(isdefined(param_00))
			{
				param_00.var_AC03[var_05] = undefined;
			}

			continue;
		}

		if(var_0E == "LGM_target_lockedMissilesDestroyed")
		{
			waittillframeend;
			if(!isdefined(param_00.var_AC03[var_05]) || param_00.var_AC03[var_05].size == 0)
			{
				var_0D = 0;
			}
		}
	}

	if(isdefined(param_00))
	{
		scripts\mp\_utility::func_C78F(var_05,param_00);
	}
}

//Function Number: 17
func_AC18()
{
	var_00 = scripts\mp\_weapons::func_AF2B();
	var_00 = sortbydistance(var_00,self.origin);
	var_01 = undefined;
	foreach(var_03 in var_00)
	{
		if(self method_8409(var_03.origin,65,75))
		{
			var_01 = var_03;
			break;
		}
	}

	return var_01;
}

//Function Number: 18
func_AC05()
{
	if(!isdefined(self.var_A874) || self.var_A874 == 0)
	{
		self.var_A874 = 1;
		scripts\mp\_utility::func_6282();
	}
}

//Function Number: 19
func_AC04()
{
	if(isdefined(self.var_A874) && self.var_A874 == 1)
	{
		scripts\mp\_utility::func_561C();
	}

	self.var_A874 = undefined;
}

//Function Number: 20
func_AC16(param_00)
{
	var_01 = [];
	foreach(var_03 in param_00)
	{
		if(isvalidmissile(var_03))
		{
			var_01[var_01.size] = var_03;
		}
	}

	return var_01;
}

//Function Number: 21
func_AC19(param_00,param_01,param_02)
{
	level notify("laserGuidedMissiles_incoming",param_01,param_02,param_00);
	param_00 notify("targeted_by_incoming_missile",param_02);
}

//Function Number: 22
func_AC0A(param_00)
{
	var_01 = undefined;
	if(param_00.model != "vehicle_av8b_harrier_jet_mp")
	{
		var_01 = param_00 gettagorigin("tag_missile_target");
	}
	else
	{
		var_01 = param_00 gettagorigin("tag_body");
	}

	if(!isdefined(var_01))
	{
		var_01 = param_00 method_8159(0,0,0);
	}

	return var_01 - param_00.origin;
}

//Function Number: 23
func_AC12(param_00)
{
	if(isdefined(param_00.var_B8AC) && param_00.var_B8AC.size > 0)
	{
		foreach(var_02 in param_00.var_B8AC)
		{
			if(isvalidmissile(var_02))
			{
				var_02 notify("missile_targetChanged");
				var_02 notify("LGM_missile_abandoned");
				var_02 missile_cleartarget();
			}
		}
	}

	param_00.var_B8AC = [];
}