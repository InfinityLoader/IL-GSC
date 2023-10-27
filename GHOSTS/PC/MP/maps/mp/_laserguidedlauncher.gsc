/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\_laserguidedlauncher.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 23
 * Decompile Time: 398 ms
 * Timestamp: 10/27/2023 1:22:21 AM
*******************************************************************/

//Function Number: 1
func_4DC6(param_00,param_01)
{
	level._effect["laser_guided_launcher_missile_split"] = loadfx(param_00);
	level._effect["laser_guided_launcher_missile_spawn_homing"] = loadfx(param_01);
}

//Function Number: 2
lgm_update_launcherusage(param_00,param_01)
{
	self endon("death");
	self endon("disconnect");
	self endon("faux_spawn");
	thread func_4DCE();
	var_02 = self getcurrentweapon();
	for(;;)
	{
		while(var_02 != param_00)
		{
			self waittill("weapon_change",var_02);
		}

		childthread lgm_firing_monitormissilefire(var_02,param_01);
		self waittill("weapon_change",var_02);
		func_4DC2();
	}
}

//Function Number: 3
func_4DCE()
{
	self endon("LGM_player_endMonitorFire");
	common_scripts\utility::func_8B2A("death","disconnect");
	if(isdefined(self))
	{
		func_4DBF();
	}
}

//Function Number: 4
func_4DC2()
{
	func_4DBF();
	self notify("LGM_player_endMonitorFire");
}

//Function Number: 5
lgm_firing_monitormissilefire(param_00,param_01,param_02)
{
	self endon("LGM_player_endMonitorFire");
	func_4DC0();
	var_03 = undefined;
	for(;;)
	{
		var_04 = undefined;
		self waittill("missile_fire",var_04,var_05);
		if(isdefined(var_04.ismagicbullet) && var_04.ismagicbullet)
		{
			continue;
		}

		if(var_05 != param_00)
		{
			continue;
		}

		if(!isdefined(var_03))
		{
			var_03 = func_4DD2(self);
		}

		thread func_4DC1(param_00,param_01,param_02,0.35,0.1,var_04,var_03);
	}
}

//Function Number: 6
func_4DC1(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	self notify("monitor_laserGuidedMissile_delaySpawnChildren");
	self endon("monitor_laserGuidedMissile_delaySpawnChildren");
	self endon("death");
	self endon("LGM_player_endMonitorFire");
	lgm_missilesnotifyandrelease(param_06);
	wait(param_03);
	if(!isvalidmissile(param_05))
	{
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
		var_10 = magicbullet(param_01,var_07,var_07 + var_0F * 180,self);
		var_10.ismagicbullet = 1;
		var_0B[var_0B.size] = var_10;
		common_scripts\utility::func_8AFE();
	}

	wait(param_04);
	var_0B = func_4DD1(var_0B);
	if(var_0B.size > 0)
	{
		foreach(var_12 in var_0B)
		{
			param_06.missileschasing[param_06.missileschasing.size] = var_12;
			var_12 missile_settargetent(param_06);
			thread lgm_onmissilenotifies(param_06,var_12);
		}

		thread func_4DC4(param_06,param_02);
	}
}

//Function Number: 7
lgm_onmissilenotifies(param_00,param_01)
{
	param_01 common_scripts\utility::func_8B2A("death","missile_pairedWithFlare","LGM_missile_abandoned");
	if(isdefined(param_00.missileschasing) && param_00.missileschasing.size > 0)
	{
		param_00.missileschasing = common_scripts\utility::array_remove(param_00.missileschasing,param_01);
		param_00.missileschasing = func_4DD1(param_00.missileschasing);
	}

	if(!isdefined(param_00.missileschasing) || param_00.missileschasing.size == 0)
	{
		self notify("LGM_player_allMissilesDestroyed");
	}
}

//Function Number: 8
func_4DC4(param_00,param_01)
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
	while(isdefined(param_00.missileschasing) && param_00.missileschasing.size > 0)
	{
		var_07 = func_4DD3();
		if(!isdefined(var_07))
		{
			if(isdefined(var_03))
			{
				self notify("LGM_player_targetLost");
				var_03 = undefined;
				foreach(var_09 in param_00.missileschasing)
				{
					var_09 notify("missile_targetChanged");
				}
			}

			var_04 = undefined;
			var_05 = 0;
			var_0B = common_scripts\utility::func_803F(gettime() > var_06,8000,800);
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
				level thread lgm_locking_think(var_03,self);
			}
			else if(gettime() >= var_04)
			{
				var_05 = 1;
				self notify("LGM_player_lockedOn");
			}

			if(var_05)
			{
				waittillframeend;
				if(param_00.missileschasing.size > 0)
				{
					var_10 = [];
					foreach(var_09 in param_00.missileschasing)
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
						level thread func_4DC9(var_03,self,param_01,var_10);
					}

					param_00.missileschasing = [];
				}
				else
				{
					break;
				}
			}
			else if(var_0F)
			{
				func_4DD4(var_03,self,param_00.missileschasing);
			}
		}

		param_00.origin = var_02;
		common_scripts\utility::func_8AFE();
	}
}

//Function Number: 9
func_4DD2(param_00)
{
	if(!isdefined(level.laserguidedmissileents_inuse))
	{
		level.laserguidedmissileents_inuse = [];
	}

	if(!isdefined(level.laserguidedmissileents_ready))
	{
		level.laserguidedmissileents_ready = [];
	}

	var_01 = undefined;
	if(level.laserguidedmissileents_ready.size)
	{
		var_01 = level.laserguidedmissileents_ready[0];
		level.laserguidedmissileents_ready = common_scripts\utility::array_remove(level.laserguidedmissileents_ready,var_01);
	}
	else
	{
		var_01 = spawn("script_origin",param_00.origin);
	}

	level.laserguidedmissileents_inuse[level.laserguidedmissileents_inuse.size] = var_01;
	level thread func_4DCF(var_01,param_00);
	var_01.missileschasing = [];
	return var_01;
}

//Function Number: 10
func_4DCF(param_00,param_01)
{
	param_01 common_scripts\utility::func_8B2A("death","disconnect","LGM_player_endMonitorFire");
	foreach(var_03 in param_00.missileschasing)
	{
		if(isvalidmissile(var_03))
		{
			var_03 missile_cleartarget();
		}
	}

	param_00.missileschasing = undefined;
	level.laserguidedmissileents_inuse = common_scripts\utility::array_remove(level.laserguidedmissileents_inuse,param_00);
	if(level.laserguidedmissileents_ready.size + level.laserguidedmissileents_inuse.size < 4)
	{
		level.laserguidedmissileents_ready[level.laserguidedmissileents_ready.size] = param_00;
	}

	param_00 delete();
}

//Function Number: 11
lgm_locking_think(param_00,param_01)
{
	var_02 = maps\mp\_utility::func_5A44(param_00,"orange",param_01,1,"killstreak_personal");
	level thread lgm_locking_loopsound(param_01,"maaws_reticle_tracking",1.5,"LGM_player_lockingDone");
	level thread func_4DCB(param_00,param_01);
	param_01 common_scripts\utility::func_8B2A("death","disconnect","LGM_player_endMonitorFire","LGM_player_newMissilesFired","LGM_player_targetLost","LGM_player_lockedOn","LGM_player_allMissilesDestroyed","LGM_player_targetDied");
	if(isdefined(param_00))
	{
		maps\mp\_utility::func_5A40(var_02,param_00);
	}

	if(isdefined(param_01))
	{
		param_01 notify("LGM_player_lockingDone");
		param_01 stoplocalsound("maaws_reticle_tracking");
	}
}

//Function Number: 12
lgm_locked_missileondeath(param_00,param_01,param_02)
{
	param_01 endon("death");
	param_00 waittill("death");
	param_01.lg_missileslocked[param_02] = common_scripts\utility::array_remove(param_01.lg_missileslocked[param_02],param_00);
	if(param_01.lg_missileslocked[param_02].size == 0)
	{
		param_01.lg_missileslocked[param_02] = undefined;
		param_01 notify("LGM_target_lockedMissilesDestroyed");
	}
}

//Function Number: 13
func_4DCB(param_00,param_01)
{
	param_01 endon("death");
	param_01 endon("disconnect");
	param_01 endon("LGM_player_lockingDone");
	param_00 waittill("death");
	param_01 notify("LGM_player_targetDied");
}

//Function Number: 14
lgm_locking_loopsound(param_00,param_01,param_02,param_03)
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
lgm_locked_spawnmissiles(param_00,param_01,param_02,param_03)
{
	param_00 endon("death");
	param_01 endon("death");
	param_01 endon("disconnect");
	var_04 = [];
	for(var_05 = 0;var_05 < param_03.size;var_05++)
	{
		var_06 = magicbullet(param_02,param_03[var_05],param_00.origin,param_01);
		var_06.ismagicbullet = 1;
		var_04[var_04.size] = var_06;
		playfx(level._effect["laser_guided_launcher_missile_spawn_homing"],var_06.origin,anglestoforward(var_06.angles),anglestoup(var_06.angles));
		common_scripts\utility::func_8AFE();
	}

	return var_04;
}

//Function Number: 16
func_4DC9(param_00,param_01,param_02,param_03)
{
	if(param_03.size == 0)
	{
	}

	var_04 = lgm_locked_spawnmissiles(param_00,param_01,param_02,param_03);
	if(!isdefined(var_04))
	{
	}

	var_04 = func_4DD1(var_04);
	if(var_04.size == 0)
	{
	}

	param_01 playlocalsound("maaws_reticle_locked");
	var_05 = maps\mp\_utility::func_5A44(param_00,"red",param_01,0,"killstreak_personal");
	var_06 = func_4DC5(param_00);
	foreach(var_08 in var_04)
	{
		var_08 common_scripts\utility::func_52B2(param_00,"direct",var_06);
		func_4DD4(param_00,param_01,var_04);
	}

	if(!isdefined(param_00.lg_missileslocked))
	{
		param_00.lg_missileslocked = [];
	}

	param_00.lg_missileslocked[var_05] = var_04;
	foreach(var_0B in var_04)
	{
		level thread lgm_locked_missileondeath(var_0B,param_00,var_05);
	}

	var_0D = 1;
	while(var_0D)
	{
		var_0E = param_00 common_scripts\utility::func_8B33("death","LGM_target_lockedMissilesDestroyed");
		if(var_0E == "death")
		{
			var_0D = 0;
			if(isdefined(param_00))
			{
				param_00.lg_missileslocked[var_05] = undefined;
			}

			continue;
		}

		if(var_0E == "LGM_target_lockedMissilesDestroyed")
		{
			waittillframeend;
			if(!isdefined(param_00.lg_missileslocked[var_05]) || param_00.lg_missileslocked[var_05].size == 0)
			{
				var_0D = 0;
			}
		}
	}

	if(isdefined(param_00))
	{
		maps\mp\_utility::func_5A40(var_05,param_00);
	}
}

//Function Number: 17
func_4DD3()
{
	var_00 = maps\mp\gametypes\_weapons::func_4EE2();
	var_00 = sortbydistance(var_00,self.origin);
	var_01 = undefined;
	foreach(var_03 in var_00)
	{
		if(self worldpointinreticle_circle(var_03.origin,65,75))
		{
			var_01 = var_03;
			break;
		}
	}

	return var_01;
}

//Function Number: 18
func_4DC0()
{
	if(!isdefined(self.laserguidedlauncher_laseron) || self.laserguidedlauncher_laseron == 0)
	{
		self.laserguidedlauncher_laseron = 1;
		maps\mp\_utility::enableweaponlaser();
	}
}

//Function Number: 19
func_4DBF()
{
	if(isdefined(self.laserguidedlauncher_laseron) && self.laserguidedlauncher_laseron == 1)
	{
		maps\mp\_utility::func_27C1();
	}

	self.laserguidedlauncher_laseron = undefined;
}

//Function Number: 20
func_4DD1(param_00)
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
func_4DD4(param_00,param_01,param_02)
{
	level notify("laserGuidedMissiles_incoming",param_01,param_02,param_00);
	param_00 notify("targeted_by_incoming_missile",param_02);
}

//Function Number: 22
func_4DC5(param_00)
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
		var_01 = param_00 getpointinbounds(0,0,0);
	}

	return var_01 - param_00.origin;
}

//Function Number: 23
lgm_missilesnotifyandrelease(param_00)
{
	if(isdefined(param_00.missileschasing) && param_00.missileschasing.size > 0)
	{
		foreach(var_02 in param_00.missileschasing)
		{
			if(isvalidmissile(var_02))
			{
				var_02 notify("missile_targetChanged");
				var_02 notify("LGM_missile_abandoned");
				var_02 missile_cleartarget();
			}
		}
	}

	param_00.missileschasing = [];
}