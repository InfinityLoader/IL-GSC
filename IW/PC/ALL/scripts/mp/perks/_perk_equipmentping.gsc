/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\perks\_perk_equipmentping.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 4
 * Decompile Time: 205 ms
 * Timestamp: 10/27/2023 12:30:03 AM
*******************************************************************/

//Function Number: 1
func_E84B(param_00,param_01)
{
	self endon("death");
	self.var_222 endon("disconnect");
	var_02 = self.var_222;
	var_03 = level.var_12AF7["uav_3dping"];
	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	self.equipping_lastpingtime = param_01;
	if(var_02 scripts\mp\_utility::_hasperk("specialty_equipment_ping"))
	{
		for(;;)
		{
			var_04 = 0;
			if(gettime() >= self.equipping_lastpingtime + 3000)
			{
				foreach(var_06 in level.players)
				{
					if(!scripts\mp\_utility::func_9F19(var_06))
					{
						continue;
					}

					if(!var_02 scripts\mp\_utility::func_9DD6(var_06))
					{
						continue;
					}

					if(var_06 scripts\mp\_utility::_hasperk("specialty_engineer"))
					{
						continue;
					}

					if(isdefined(var_06.var_C78B))
					{
						continue;
					}

					var_07 = scripts\common\utility::array_add(level.players,self);
					if(isdefined(param_00))
					{
						var_07 = scripts\common\utility::array_add(var_07,param_00);
					}

					var_08 = self.origin + anglestoup(self.angles) * 10;
					if(distance2d(var_06.origin,self.origin) < 300 && scripts\common\trace::func_DCF1(var_08,var_06 gettagorigin("j_head"),var_07))
					{
						if(!var_06 scripts\mp\_utility::_hasperk("specialty_gpsjammer"))
						{
							var_02 thread markasrelaysource(var_06);
						}

						var_04 = 1;
					}
				}

				if(var_04)
				{
					if(!scripts\mp\_utility::func_9FB3(self.eyespyalerted))
					{
						var_02 scripts\mp\_missions::func_D991("ch_trait_eye_spy");
						self.eyespyalerted = 1;
					}

					playfxontagforclients(var_03.var_7636,self,"tag_origin",var_02);
					self playsoundtoplayer("ghost_senses_ping",var_02);
					function_0222(self.origin,var_02,400,800);
					wait(3);
				}
			}

			scripts\common\utility::func_136F7();
		}
	}
}

//Function Number: 2
func_B369(param_00,param_01)
{
	param_00 endon("death");
	param_00 endon("disconnect");
	if(!isdefined(param_00) || !scripts\mp\_utility::func_9F19(param_00))
	{
		return;
	}

	thread markasrelaysource(param_00);
	var_02 = scripts\mp\objidpoolmanager::requestminimapid(10);
	if(var_02 == -1)
	{
		return;
	}

	scripts\mp\objidpoolmanager::minimap_objective_add(var_02,"active",param_01.origin,"cb_compassping_eqp_ping","icon_large");
	scripts\mp\objidpoolmanager::minimap_objective_player(var_02,self getentitynumber());
	param_00 thread func_13A35(var_02);
	wait(3);
	scripts\mp\objidpoolmanager::returnminimapid(var_02);
}

//Function Number: 3
func_13A35(param_00)
{
	scripts\common\utility::waittill_any_3("death","disconnect");
	scripts\mp\objidpoolmanager::returnminimapid(param_00);
}

//Function Number: 4
markasrelaysource(param_00)
{
	level endon("game_ended");
	self endon("disconnect");
	var_01 = param_00 getentitynumber();
	if(!isdefined(self.relaysource))
	{
		self.relaysource = [];
	}
	else if(isdefined(self.relaysource[var_01]))
	{
		self notify("markAsRelaySource");
		self endon("markAsRelaySource");
	}

	self.relaysource[var_01] = 1;
	param_00 scripts\common\utility::waittill_any_timeout_1(10,"death","disconnect");
	self.relaysource[var_01] = 0;
}