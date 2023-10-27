/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\killstreaks\_flares.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 20
 * Decompile Time: 316 ms
 * Timestamp: 10/27/2023 1:32:30 AM
*******************************************************************/

//Function Number: 1
func_33DA(param_00)
{
	self.flaresreservecount = param_00;
	self.flareslive = [];
	thread func_4B64();
}

//Function Number: 2
flares_playfx()
{
	for(var_00 = 0;var_00 < 10;var_00++)
	{
		if(!isdefined(self))
		{
		}

		playfxontag(level._effect["vehicle_flares"],self,"TAG_FLARE");
		wait(0.15);
	}
}

//Function Number: 3
func_33D1()
{
	var_00 = spawn("script_origin",self.origin + (0,0,-256));
	var_00.angles = self.angles;
	var_00 gravitymove((0,0,-1),5);
	self.flareslive[self.flareslive.size] = var_00;
	var_00 thread func_33D0(5,2,self);
	playsoundatpos(var_00.origin,"veh_helo_flares_npc");
	return var_00;
}

//Function Number: 4
func_33D0(param_00,param_01,param_02)
{
	if(isdefined(param_01) && isdefined(param_02))
	{
		param_00 = param_00 - param_01;
		wait(param_01);
		if(isdefined(param_02))
		{
			param_02.flareslive = common_scripts\utility::array_remove(param_02.flareslive,self);
		}
	}

	wait(param_00);
	self delete();
}

//Function Number: 5
func_33D7(param_00)
{
	return param_00.flaresreservecount;
}

//Function Number: 6
func_33CD(param_00)
{
	func_33CF(param_00);
	return param_00.flaresreservecount > 0 || param_00.flareslive.size > 0;
}

//Function Number: 7
func_33D6(param_00)
{
	param_00.flaresreservecount--;
	param_00 thread flares_playfx();
	var_01 = param_00 func_33D1();
	return var_01;
}

//Function Number: 8
func_33CF(param_00)
{
	param_00.flareslive = common_scripts\utility::array_removeundefined(param_00.flareslive);
}

//Function Number: 9
func_33D5(param_00)
{
	func_33CF(param_00);
	var_01 = undefined;
	if(param_00.flareslive.size > 0)
	{
		var_01 = param_00.flareslive[param_00.flareslive.size - 1];
	}

	return var_01;
}

//Function Number: 10
func_4B64()
{
	level endon("game_ended");
	self endon("death");
	self endon("crashing");
	self endon("leaving");
	self endon("helicopter_done");
	while(func_33CD(self))
	{
		level waittill("laserGuidedMissiles_incoming",var_00,var_01,var_02);
		if(!isdefined(var_02) || var_02 != self)
		{
			continue;
		}

		foreach(var_04 in var_01)
		{
			if(isvalidmissile(var_04))
			{
				level thread func_4B65(var_04,var_00,var_00.team,var_02);
			}
		}
	}
}

//Function Number: 11
func_4B65(param_00,param_01,param_02,param_03)
{
	param_03 endon("death");
	param_00 endon("death");
	param_00 endon("missile_targetChanged");
	while(func_33CD(param_03))
	{
		if(!isdefined(param_03) || !isvalidmissile(param_00))
		{
			break;
		}

		var_04 = param_03 getpointinbounds(0,0,0);
		if(distancesquared(param_00.origin,var_04) < 4000000)
		{
			var_05 = func_33D5(param_03);
			if(!isdefined(var_05))
			{
				var_05 = func_33D6(param_03);
			}

			param_00 missilesettargetent(var_05);
			param_00 notify("missile_pairedWithFlare");
			break;
		}

		common_scripts\utility::func_8AFE();
	}
}

//Function Number: 12
func_33D8(param_00)
{
	level endon("game_ended");
	self endon("death");
	self endon("crashing");
	self endon("leaving");
	self endon("helicopter_done");
	for(;;)
	{
		level waittill("sam_fired",var_01,var_02,var_03);
		if(!isdefined(var_03) || var_03 != self)
		{
			continue;
		}

		if(isdefined(param_00))
		{
			level thread [[ param_00 ]](var_01,var_01.team,var_03,var_02);
			continue;
		}

		level thread flares_watchsamproximity(var_01,var_01.team,var_03,var_02);
	}
}

//Function Number: 13
flares_watchsamproximity(param_00,param_01,param_02,param_03)
{
	level endon("game_ended");
	param_02 endon("death");
	for(;;)
	{
		var_04 = param_02 getpointinbounds(0,0,0);
		var_05 = [];
		for(var_06 = 0;var_06 < param_03.size;var_06++)
		{
			if(isdefined(param_03[var_06]))
			{
				var_05[var_06] = distance(param_03[var_06].origin,var_04);
			}
		}

		var_06 = 0;
		while(var_06 < var_05.size)
		{
			if(isdefined(var_05[var_06]))
			{
				if(var_05[var_06] < 4000 && param_02.flaresreservecount > 0)
				{
					param_02.flaresreservecount--;
					param_02 thread flares_playfx();
					var_07 = param_02 func_33D1();
					for(var_08 = 0;var_08 < param_03.size;var_08++)
					{
						if(isdefined(param_03[var_08]))
						{
							param_03[var_08] missilesettargetent(var_07);
							param_03[var_08] notify("missile_pairedWithFlare");
						}
					}
				}
			}

			var_08++;
		}

		wait(0.05);
	}
}

//Function Number: 14
func_33D9(param_00)
{
	level endon("game_ended");
	self endon("death");
	self endon("crashing");
	self endon("leaving");
	self endon("helicopter_done");
	for(;;)
	{
		level waittill("stinger_fired",var_01,var_02,var_03);
		if(!isdefined(var_03) || var_03 != self)
		{
			continue;
		}

		if(isdefined(param_00))
		{
			var_02 thread [[ param_00 ]](var_01,var_01.team,var_03);
			continue;
		}

		var_02 thread func_33DF(var_01,var_01.team,var_03);
	}
}

//Function Number: 15
func_33DF(param_00,param_01,param_02)
{
	self endon("death");
	for(;;)
	{
		if(!isdefined(param_02))
		{
			break;
		}

		var_03 = param_02 getpointinbounds(0,0,0);
		var_04 = distance(self.origin,var_03);
		if(var_04 < 4000 && param_02.flaresreservecount > 0)
		{
			param_02.flaresreservecount--;
			param_02 thread flares_playfx();
			var_05 = param_02 func_33D1();
			self missilesettargetent(var_05);
			self notify("missile_pairedWithFlare");
		}

		wait(0.05);
	}
}

//Function Number: 16
ks_setup_manual_flares(param_00,param_01,param_02,param_03)
{
	self.flaresreservecount = param_00;
	self.flareslive = [];
	if(isdefined(param_02))
	{
		self.owner setclientomnvar(param_02,param_00);
	}

	thread ks_manualflares_watchuse(param_01,param_02);
	thread func_4B66(param_03);
}

//Function Number: 17
ks_manualflares_watchuse(param_00,param_01)
{
	level endon("game_ended");
	self endon("death");
	self endon("crashing");
	self endon("leaving");
	self endon("helicopter_done");
	if(!isai(self.owner))
	{
		self.owner notifyonplayercommand("manual_flare_popped",param_00);
	}

	while(func_33D7(self))
	{
		self.owner waittill("manual_flare_popped");
		var_02 = func_33D6(self);
		if(isdefined(var_02) && isdefined(self.owner) && !isai(self.owner))
		{
			self.owner playlocalsound("veh_helo_flares_plr");
			if(isdefined(param_01))
			{
				self.owner setclientomnvar(param_01,func_33D7(self));
			}
		}
	}
}

//Function Number: 18
func_4B66(param_00)
{
	level endon("game_ended");
	self endon("death");
	self endon("crashing");
	self endon("leaving");
	self endon("helicopter_done");
	while(func_33CD(self))
	{
		self waittill("targeted_by_incoming_missile",var_01);
		if(!isdefined(var_01))
		{
			continue;
		}

		self.owner playlocalsound("missile_incoming");
		self.owner thread func_4B6A(self,"missile_incoming");
		if(isdefined(param_00))
		{
			var_02 = vectornormalize(var_01[0].origin - self.origin);
			var_03 = vectornormalize(anglestoright(self.angles));
			var_04 = vectordot(var_02,var_03);
			var_05 = 1;
			if(var_04 > 0)
			{
				var_05 = 2;
			}
			else if(var_04 < 0)
			{
				var_05 = 3;
			}

			self.owner setclientomnvar(param_00,var_05);
		}

		foreach(var_07 in var_01)
		{
			if(isvalidmissile(var_07))
			{
				thread func_4B67(var_07);
			}
		}
	}
}

//Function Number: 19
func_4B67(param_00)
{
	self endon("death");
	param_00 endon("death");
	for(;;)
	{
		if(!isdefined(self) || !isvalidmissile(param_00))
		{
			break;
		}

		var_01 = self getpointinbounds(0,0,0);
		if(distancesquared(param_00.origin,var_01) < 4000000)
		{
			var_02 = func_33D5(self);
			if(isdefined(var_02))
			{
				param_00 missilesettargetent(var_02);
				param_00 notify("missile_pairedWithFlare");
				self.owner stoplocalsound("missile_incoming");
				break;
			}
		}

		common_scripts\utility::func_8AFE();
	}
}

//Function Number: 20
func_4B6A(param_00,param_01)
{
	self endon("disconnect");
	param_00 waittill("death");
	self stoplocalsound(param_01);
}