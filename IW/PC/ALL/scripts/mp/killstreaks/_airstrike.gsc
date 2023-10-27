/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\killstreaks\_airstrike.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 45
 * Decompile Time: 2182 ms
 * Timestamp: 10/27/2023 12:28:08 AM
*******************************************************************/

//Function Number: 1
init()
{
	level.var_1AF7 = loadfx("vfx/iw7/_requests/mp/vfx_debug_warning.vfx");
	level.var_1AFD = loadfx("vfx/iw7/_requests/mp/vfx_debug_warning.vfx");
	level.var_1AF6 = loadfx("vfx/iw7/_requests/mp/vfx_debug_warning.vfx");
	level.var_A87D = loadfx("vfx/iw7/_requests/mp/vfx_debug_warning.vfx");
	level.var_BB68 = loadfx("vfx/iw7/_requests/mp/vfx_debug_warning.vfx");
	level.var_2C6B = loadfx("vfx/iw7/_requests/mp/vfx_debug_warning.vfx");
	level.var_1A8D = loadfx("vfx/iw7/_requests/mp/vfx_debug_warning.vfx");
	level.var_A3BA = loadfx("vfx/iw7/core/vehicle/jackal/vfx_jackal_death_01_cheap.vfx");
	level._effect["jackal_explosion"] = loadfx("vfx/iw7/core/mp/killstreaks/vfx_veh_exp_warden.vfx");
	level.var_A412 = [];
	level.var_4D82["precision_airstrike"] = 550;
	level.var_4D83["precision_airstrike"] = 300;
	level.var_4D81["precision_airstrike"] = 2;
	level.var_4D84["precision_airstrike"] = 6;
	level.var_2300 = [];
	scripts\mp\killstreaks\_killstreaks::func_DEFB("precision_airstrike",::func_128D4,undefined,undefined,undefined,::func_13C8A);
	scripts\mp\killstreaks\_killstreaks::func_DEFB("jackal",::func_128D4,undefined,undefined,::triggerjackalweapon,::func_13C8A);
	var_00 = ["passive_precision_strike","passive_increased_speed","passive_decreased_damage","passive_split_strike","passive_increased_cost","passive_one_plane","passive_speed_cost"];
	scripts\mp\_killstreak_loot::func_DF07("precision_airstrike",var_00);
	var_01 = ["passive_extra_flare","passive_decreased_duration","passive_moving_fortress","passive_no_cannon","passive_slow_turret","passive_support_drop"];
	scripts\mp\_killstreak_loot::func_DF07("jackal",var_01);
	level.var_CC46 = [];
	level thread func_7DE9();
}

//Function Number: 2
func_7DE9()
{
	var_00 = scripts\mp\_spawnlogic::func_8140("mp_tdm_spawn_allies_start");
	var_01 = 0;
	var_02 = 0;
	foreach(var_04 in var_00)
	{
		var_01++;
		var_02 = var_02 + var_04.origin[2];
	}

	level.var_26A6 = var_02 / var_01;
}

//Function Number: 3
func_13C8A(param_00)
{
	var_01 = undefined;
	if(param_00.var_110EA == "precision_airstrike")
	{
		if(scripts\mp\_utility::func_9FB3(level.var_1AF9))
		{
			scripts\mp\_hud_message::func_10122("KILLSTREAKS_AIR_SPACE_TOO_CROWDED");
			return 0;
		}

		if(scripts\mp\killstreaks\_utility::func_A69F(param_00,"passive_precision_strike") || scripts\mp\killstreaks\_utility::func_A69F(param_00,"passive_split_strike"))
		{
			var_01 = 1;
		}

		scripts\mp\killstreaks\_mapselect::func_10DC2(0,1,var_01);
	}

	return 1;
}

//Function Number: 4
func_128D4(param_00)
{
	if(param_00.var_110EA == "jackal" && isdefined(level.var_A22D) || level.var_A412.size > 0)
	{
		scripts\mp\_hud_message::func_10122("KILLSTREAKS_AIR_SPACE_TOO_CROWDED");
		if(scripts\mp\killstreaks\_utility::func_A69F(param_00,"passive_support_drop"))
		{
			if(isdefined(param_00.var_394) && param_00.var_394 != "none")
			{
				self notify("killstreak_finished_with_weapon_" + param_00.var_394);
			}
		}

		return 0;
	}

	var_01 = func_F1AA(param_00.var_AC68,param_00.var_110EA,param_00);
	if(!isdefined(var_01) || !var_01)
	{
		return 0;
	}

	return 1;
}

//Function Number: 5
func_57DD(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	if(param_05 == "precision_airstrike")
	{
		level.var_1AF9 = 1;
		thread func_1399E();
	}

	var_08 = scripts\common\trace::func_DCED(param_01,param_01 + (0,0,-1000000));
	var_09 = var_08["position"];
	var_0A = spawnstruct();
	var_0A.origin = var_09;
	var_0A.var_143 = anglestoforward((0,param_02,0));
	var_0A.var_110EA = param_05;
	var_0A.team = param_04;
	func_3785(param_00,param_03,var_09,param_02,param_05,param_06,param_07);
	scripts\mp\_hostmigration::func_13708(7.5);
	var_0B = 0;
	var_0C = [];
	if(param_05 == "precision_airstrike")
	{
		level.var_1AF9 = undefined;
	}

	self notify("airstrike_finished");
	if(param_05 == "precision_airstrike")
	{
		scripts\mp\_utility::func_D915("killstreak ended - precision_airstrike",param_03);
	}
}

//Function Number: 6
func_1399E()
{
	self endon("airstrike_finished");
	level endon("game_ended");
	scripts\common\utility::waittill_any_3("disconnect","joined_team");
	if(scripts\mp\_utility::func_9FB3(level.var_1AF9))
	{
		level.var_1AF9 = undefined;
	}
}

//Function Number: 7
func_41D3(param_00)
{
	wait(2);
	level.var_1AF9 = undefined;
}

//Function Number: 8
func_7DAA(param_00)
{
	var_01 = 0;
	for(var_02 = 0;var_02 < level.var_2300.size;var_02++)
	{
		var_03 = level.var_2300[var_02].origin;
		var_04 = level.var_2300[var_02].var_143;
		var_05 = level.var_2300[var_02].var_110EA;
		var_01 = var_01 + func_8124(param_00,var_03,var_04,var_05);
	}

	return var_01;
}

//Function Number: 9
func_8124(param_00,param_01,param_02,param_03)
{
	if(scripts\mp\_utility::func_9F0F(param_03))
	{
		if(distancesquared(param_00,param_01) < level.var_4D82[param_03])
		{
			return 1;
		}
		else
		{
			return 0;
		}
	}

	var_04 = param_01 + level.var_4D81[param_03] * level.var_4D82[param_03] * param_02;
	var_05 = param_00 - var_04;
	var_05 = (var_05[0],var_05[1],0);
	var_06 = vectordot(var_05,param_02) * param_02;
	var_07 = var_05 - var_06;
	var_08 = var_07 + var_06 / level.var_4D84[param_03];
	var_09 = lengthsquared(var_08);
	if(var_09 > level.var_4D82[param_03] * level.var_4D82[param_03])
	{
		return 0;
	}

	if(var_09 < level.var_4D83[param_03] * level.var_4D83[param_03])
	{
		return 1;
	}

	var_0A = sqrt(var_09);
	var_0B = var_0A - level.var_4D83[param_03] / level.var_4D82[param_03] - level.var_4D83[param_03];
	return 1 - var_0B;
}

//Function Number: 10
func_D644(param_00,param_01,param_02,param_03)
{
	return distance2d(param_00,param_01) <= level.var_4D82[param_03] * 1.25;
}

//Function Number: 11
func_B09E(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	var_07 = scripts\mp\_weapons::func_7E58(param_00,param_01,1);
	function_00F3(param_00,param_01,param_02,param_03);
	for(var_08 = 0;var_08 < var_07.size;var_08++)
	{
		if(var_07[var_08].var_114 == self)
		{
			continue;
		}

		var_09 = distance(param_00,var_07[var_08].var_4D2F);
		if(var_07[var_08].var_9EE7 || isdefined(var_07[var_08].var_9F44) && var_07[var_08].var_9F44)
		{
			var_0A = !bullettracepassed(var_07[var_08].var_114.origin,var_07[var_08].var_114.origin + (0,0,130),0,undefined);
			if(var_0A)
			{
				var_0A = !bullettracepassed(var_07[var_08].var_114.origin + (0,0,130),param_00 + (0,0,114),0,undefined);
				if(var_0A)
				{
					var_09 = var_09 * 4;
					if(var_09 > param_01)
					{
						continue;
					}
				}
			}
		}

		var_07[var_08].var_DA = int(param_02 + param_03 - param_02 * var_09 / param_01);
		var_07[var_08].var_D699 = param_00;
		var_07[var_08].var_4D5C = param_04;
		var_07[var_08].var_6000 = param_05;
		level.var_1AF2[level.var_1AF3] = var_07[var_08];
		level.var_1AF3++;
	}

	thread func_1AF5(param_06);
}

//Function Number: 12
func_1AF5(param_00)
{
	self notify("airstrikeDamageEntsThread");
	self endon("airstrikeDamageEntsThread");
	while(level.var_1AF4 < level.var_1AF3)
	{
		if(!isdefined(level.var_1AF2[level.var_1AF4]))
		{
			continue;
		}

		var_01 = level.var_1AF2[level.var_1AF4];
		if(!isdefined(var_01.var_114))
		{
			continue;
		}

		if(!var_01.var_9EE7 || isalive(var_01.var_114))
		{
			var_01 scripts\mp\_weapons::func_4D47(var_01.var_6000,var_01.var_4D5C,var_01.var_DA,"MOD_PROJECTILE_SPLASH",param_00,var_01.var_D699,vectornormalize(var_01.var_4D2F - var_01.var_D699));
			level.var_1AF2[level.var_1AF4] = undefined;
			if(var_01.var_9EE7)
			{
				wait(0.05);
			}

			continue;
		}

		level.var_1AF2[level.var_1AF4] = undefined;
		level.var_1AF4++;
	}
}

//Function Number: 13
func_DC09(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = level.players;
	foreach(var_07 in level.players)
	{
		if(!isalive(var_07))
		{
			continue;
		}

		if(var_07.team == param_04 || var_07.team == "spectator")
		{
			continue;
		}

		var_08 = var_07.origin + (0,0,32);
		var_09 = distance(param_00,var_08);
		if(var_09 > param_01)
		{
			continue;
		}

		var_0A = int(param_02 + param_03 - param_02 * var_09 / param_01);
		var_07 thread func_2301("default",var_0A);
	}
}

//Function Number: 14
func_2301(param_00,param_01)
{
	self endon("disconnect");
	if(isdefined(self.var_2A87) && self.var_2A87)
	{
		return;
	}

	self.var_2A87 = 1;
	self shellshock(param_00,param_01);
	wait(param_01 + 1);
	self.var_2A87 = 0;
}

//Function Number: 15
func_3786(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_01) || param_01 scripts\mp\_utility::func_9E68())
	{
		self notify("stop_bombing");
		return;
	}

	var_04 = 512;
	var_05 = (0,randomint(360),0);
	var_06 = param_00 + anglestoforward(var_05) * randomfloat(var_04);
	var_07 = bullettrace(var_06,var_06 + (0,0,-10000),0,undefined);
	var_06 = var_07["position"];
	var_08 = distance(param_00,var_06);
	if(var_08 > 5000)
	{
		return;
	}

	wait(0.85 * var_08 / 2000);
	if(!isdefined(param_01) || param_01 scripts\mp\_utility::func_9E68())
	{
		self notify("stop_bombing");
		return;
	}

	if(param_03)
	{
		playfx(level.var_BB68,var_06);
		level thread scripts\mp\_shellshock::func_10F44(var_06);
	}

	thread scripts\mp\_utility::func_D52A("exp_airstrike_bomb",var_06);
	func_DC09(var_06,512,8,4,param_01.team);
	func_B09E(var_06 + (0,0,16),896,300,50,param_01,self,"stealth_bomb_mp");
}

//Function Number: 16
func_5A60(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B)
{
	if(!isdefined(param_01))
	{
		return;
	}

	var_0C = 100;
	var_0D = 150;
	var_0E = param_04;
	var_0F = param_05;
	var_10 = "veh_mil_air_ca_jackal_drone_atmos_periph_mp";
	var_11 = scripts\mp\_killstreak_loot::getrarityforlootitem(param_0B.var_1318B);
	if(var_11 != "")
	{
		var_10 = var_10 + "_" + var_11;
	}

	var_12 = spawn("script_model",var_0E);
	var_12 setmodel(var_10);
	var_12.var_222 = param_01;
	var_12.origin = var_0E;
	var_12.angles = param_08;
	var_12.team = param_01.team;
	var_12.var_AC68 = param_00;
	var_12.var_110E8 = param_0B;
	var_12 method_831F(param_01);
	var_12 method_8549();
	var_12 method_8594();
	var_12 method_8548();
	var_12 scripts\mp\killstreaks\_utility::func_1843(param_09,"Killstreak_Air",param_01,1,"kill_outline");
	var_12 thread func_8998(param_01);
	if(param_09 == "precision_airstrike")
	{
		var_13 = "jackal_airstrike_turret_mp";
		var_14 = "vehicle_battle_hind_mg_mp";
		var_15 = "tag_bottom_light";
		var_16 = "icon_minimap_scorcher_friendly";
		if(scripts\mp\killstreaks\_utility::func_A69F(param_0B,"passive_speed_cost"))
		{
			param_07 = param_07 - 1;
		}

		var_12.minimapid = var_12 scripts\mp\killstreaks\_airdrop::func_49F7(var_16,undefined,undefined,1,1);
		var_12.var_129B9 = spawnturret("misc_turret",var_12 gettagorigin(var_15),var_13);
		var_12.var_129B9 setmodel(var_14);
		var_12.var_129B9.var_222 = param_01;
		var_12.var_129B9.angles = var_12.angles;
		var_12.var_129B9 linkto(var_12,var_15,(0,0,30),(0,0,0));
		var_12.var_129B9 method_835B(0);
		var_12.var_129B9 method_830F("manual_target");
		var_12.var_129B9 method_8336(param_01);
		var_12.var_12A95 = spawn("script_model",var_12.origin + anglestoforward(var_12.angles) * 1000 - (0,0,10000));
		var_12.var_12A95 linkto(var_12);
		var_12.var_A87B = spawn("script_model",var_12.var_12A95.origin);
		var_12.var_A87B setmodel("ks_scorchers_target_mp");
		var_12.var_A87B method_82DD(param_01);
		var_12.var_A87B.var_13C2E = "artillery_mp";
		var_12.var_A87B.var_110E8 = param_0B;
		var_12.var_129B9 method_8347(var_12.var_12A95);
	}

	var_12 moveto(var_0F,param_07,0,0);
	if(param_09 == "precision_airstrike")
	{
		var_12 setscriptablepartstate("thrusters","idle",0);
		thread func_3788(var_12,var_0F,param_07,param_06 - 1.5,param_01);
		wait(param_06 + 1);
	}
	else
	{
		var_12 setscriptablepartstate("thrusters","idle",0);
		thread func_3787(var_12,var_0F,param_07,param_06 - 1,param_01,param_02,param_09,param_0A);
		wait(param_06 - 0.75);
	}

	if(param_09 != "jackal")
	{
		var_12 scriptmodelplayanimdeltamotion("airstrike_mp_roll",1);
	}

	var_12 thread func_5115(2.5,"kill_outline");
	var_12 endon("death");
	wait(param_07 - param_06);
	var_12 setscriptablepartstate("thrusters","neutral",0);
	if(isdefined(var_12.minimapid))
	{
		scripts\mp\objidpoolmanager::returnminimapid(var_12.minimapid);
	}

	var_12 notify("delete");
	if(isdefined(var_12.var_129B9))
	{
		var_12.var_129B9 delete();
	}

	if(isdefined(var_12.var_12A95))
	{
		var_12.var_12A95 delete();
	}

	if(isdefined(var_12.var_A87B))
	{
		var_12.var_A87B delete();
		if(isdefined(var_12.var_A87B.var_A63A))
		{
			var_12.var_A87B.var_A63A delete();
		}
	}

	if(isdefined(var_12))
	{
		var_12 delete();
	}
}

//Function Number: 17
func_5115(param_00,param_01)
{
	self endon("death");
	wait(param_00);
	self notify(param_01);
}

//Function Number: 18
func_898E()
{
	level endon("game_ended");
	self endon("delete");
	self waittill("death");
	var_00 = anglestoforward(self.angles) * 200;
	playfx(level.var_8B57,self.origin,var_00);
	self delete();
}

//Function Number: 19
func_180E(param_00)
{
	level.var_CC46[level.var_CC46.size] = param_00;
}

//Function Number: 20
func_E157(param_00)
{
	for(var_01 = 0;var_01 < level.var_CC46.size;var_01++)
	{
		if(isdefined(level.var_CC46[var_01]) && level.var_CC46[var_01] == param_00)
		{
			level.var_CC46[var_01] = undefined;
		}
	}
}

//Function Number: 21
func_3787(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	param_00 endon("death");
	wait(param_03);
	if(!isdefined(param_04) || param_04 scripts\mp\_utility::func_9E68())
	{
		return;
	}

	var_08 = anglestoforward(param_00.angles);
	var_09 = func_10836(param_00.origin,param_00.angles);
	var_09 movegravity(anglestoforward(param_00.angles) * 4666.667,3);
	var_09.var_AC68 = param_05;
	var_0A = spawn("script_model",param_00.origin + (0,0,100) - var_08 * 200);
	var_09.var_A63A = var_0A;
	var_09.var_A63A setscriptmoverkillcam("airstrike");
	var_09.var_1AFE = param_06;
	var_0A.var_10DFF = gettime();
	var_0A thread func_51A6(15);
	var_0A.angles = var_08;
	var_0A moveto(param_01 + (0,0,100),param_02,0,0);
	wait(0.4);
	var_0A moveto(var_0A.origin + var_08 * 4000,1,0,0);
	wait(0.45);
	var_0A moveto(var_0A.origin + var_08 + (0,0,-0.2) * 3500,2,0,0);
	wait(0.15);
	var_0B = spawn("script_model",var_09.origin);
	var_0B setmodel("tag_origin");
	var_0B.origin = var_09.origin;
	var_0B.angles = var_09.angles;
	var_09 setmodel("tag_origin");
	wait(0.1);
	var_0C = var_0B.origin;
	var_0D = var_0B.angles;
	if(level.splitscreen)
	{
		playfxontag(level.var_1AFD,var_0B,"tag_origin");
	}
	else
	{
		playfxontag(level.var_1AF7,var_0B,"tag_origin");
	}

	wait(0.05);
	var_0A moveto(var_0A.origin + var_08 + (0,0,-0.25) * 2500,2,0,0);
	wait(0.25);
	var_0A moveto(var_0A.origin + var_08 + (0,0,-0.35) * 2000,2,0,0);
	wait(0.2);
	var_0A moveto(var_0A.origin + var_08 + (0,0,-0.45) * 1500,2,0,0);
	wait(0.5);
	if(isdefined(param_07))
	{
		param_07 delete();
	}

	var_0E = 12;
	var_0F = 5;
	var_10 = 55;
	var_11 = var_10 - var_0F / var_0E;
	var_12 = (0,0,0);
	for(var_13 = 0;var_13 < var_0E;var_13++)
	{
		var_14 = anglestoforward(var_0D + (var_10 - var_11 * var_13,randomint(10) - 5,0));
		var_15 = var_0C + var_14 * 10000;
		var_16 = bullettrace(var_0C,var_15,0,undefined);
		var_17 = var_16["position"];
		var_12 = var_12 + var_17;
		playfx(level.var_1AF6,var_17);
		thread func_B09E(var_17 + (0,0,16),512,200,30,param_04,var_09,"artillery_mp");
		if(var_13 % 3 == 0)
		{
			thread scripts\mp\_utility::func_D52A("jackal_missile_impact",var_17);
			level thread scripts\mp\_shellshock::func_1AF0(var_17);
		}

		wait(0.05);
	}

	var_12 = var_12 / var_0E + (0,0,128);
	var_0A moveto(var_09.var_A63A.origin * 0.35 + var_12 * 0.65,1.5,0,0.5);
	wait(5);
	var_0B delete();
	var_09 delete();
}

//Function Number: 22
func_10836(param_00,param_01)
{
	var_02 = spawn("script_model",param_00);
	var_02.angles = param_01;
	var_02 setmodel("projectile_cbu97_clusterbomb");
	return var_02;
}

//Function Number: 23
func_3788(param_00,param_01,param_02,param_03,param_04)
{
	param_00 endon("death");
	wait(param_03);
	if(!isdefined(param_04) || param_04 scripts\mp\_utility::func_9E68())
	{
		return;
	}

	var_05 = anglestoforward(param_00.angles);
	var_06 = spawn("script_model",param_00.origin - (0,0,100) - var_05 * 200);
	var_06 linkto(param_00);
	param_00.var_A87B.var_A63A = var_06;
	wait(0.5);
	var_07 = 50;
	var_08 = (0,0,0);
	var_09 = var_08;
	param_00.var_129B9 setscriptablepartstate("fire","start",0);
	param_00.var_A87B setscriptablepartstate("beam impact","active",0);
	var_0A = ["explode1","explode2","explode3","explode4","explode5"];
	var_0B = 0;
	for(var_0C = 0;var_0C < var_07;var_0C++)
	{
		if(!isdefined(param_04))
		{
			break;
		}

		var_0D = scripts\common\trace::func_DCED(param_00.var_129B9 gettagorigin("tag_flash"),param_00.var_12A95.origin,level.var_3CB5,scripts\common\trace::func_48BC(0,1,0,1,0,1,0));
		var_0E = var_0D["position"];
		var_08 = var_0E + (0,0,2);
		param_00.var_A87B thread func_BCA4(var_0B,var_08,var_0A);
		param_00.var_129B9 method_837E();
		var_09 = var_08;
		if(var_0B < 4)
		{
			var_0B++;
		}
		else
		{
			var_0B = 0;
		}

		wait(0.05);
	}

	param_00.var_129B9 setscriptablepartstate("fire","stop",0);
}

//Function Number: 24
func_BCA4(param_00,param_01,param_02)
{
	self endon("death");
	self.origin = param_01;
	self setscriptablepartstate(param_02[param_00],"active",0);
	wait(0.1);
	self setscriptablepartstate(param_02[param_00],"neutral",0);
}

//Function Number: 25
func_511D(param_00,param_01)
{
	wait(param_00);
	self playloopsound(param_01);
}

//Function Number: 26
func_D4BD(param_00,param_01,param_02)
{
	var_03 = 100;
	if(param_02 != (0,0,0))
	{
		for(var_04 = 0;var_04 < 3;var_04++)
		{
			var_05 = vectornormalize(param_01 - param_02);
			var_05 = var_05 * var_03;
			playfx(param_00,param_02 + var_05);
			var_03 = var_03 + 100;
		}

		playfx(param_00,param_01);
	}
}

//Function Number: 27
func_51A6(param_00)
{
	self endon("death");
	wait(10);
	self delete();
}

//Function Number: 28
func_D4FA()
{
	self endon("death");
	wait(0.5);
	playfxontag(level.var_7545,self,"tag_engine_right");
	wait(0.5);
	playfxontag(level.var_7545,self,"tag_engine_left");
	wait(0.5);
	playfxontag(level.var_7546,self,"tag_right_wingtip");
	wait(0.5);
	playfxontag(level.var_7546,self,"tag_left_wingtip");
}

//Function Number: 29
callstrike_explosivebullets(param_00,param_01,param_02,param_03,param_04)
{
	param_00 endon("death");
	wait(param_03);
	if(!isdefined(param_04) || param_04 scripts\mp\_utility::func_9E68())
	{
		return;
	}

	var_05 = anglestoforward(param_00.angles);
	var_06 = spawn("script_model",param_00.origin - (0,0,100) - var_05 * 200);
	var_06 linkto(param_00);
	param_00.var_A87B.var_A63A = var_06;
	wait(0.5);
	var_07 = 50;
	var_08 = (0,0,0);
	var_09 = var_08;
	var_0A = ["explode1","explode2","explode3","explode4","explode5"];
	var_0B = 0;
	for(var_0C = 0;var_0C < var_07;var_0C++)
	{
		if(!isdefined(param_04))
		{
			break;
		}

		var_0D = scripts\common\trace::func_DCED(param_00.var_129B9 gettagorigin("tag_flash"),param_00.var_12A95.origin,level.var_3CB5,scripts\common\trace::func_48BC(0,1,0,1,0,1,0));
		var_0E = var_0D["position"];
		var_08 = var_0E + (0,0,2);
		param_00.var_A87B thread func_BCA4(var_0B,var_08,var_0A);
		param_00.var_129B9 method_837E();
		var_09 = var_08;
		if(var_0B < 4)
		{
			var_0B++;
		}
		else
		{
			var_0B = 0;
		}

		wait(0.1);
	}
}

//Function Number: 30
func_3785(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	var_07 = undefined;
	var_08 = 0;
	var_09 = (0,param_03,0);
	var_07 = getent("airstrikeheight","targetname");
	if(param_04 == "stealth_airstrike")
	{
		var_0A = 12000;
		var_0B = 4000;
		if(!isdefined(var_07))
		{
			var_0C = 950;
			var_08 = 1500;
			if(isdefined(level.var_1AF8))
			{
				var_0C = var_0C * level.var_1AF8;
			}
		}
		else
		{
			var_0C = var_08.origin[2];
			if(getdvar("mapname") == "mp_exchange")
			{
				var_0C = var_0C + 1024;
			}

			if(getdvar("mapname") == "mp_rally")
			{
				var_0C = var_0C + 2500;
			}

			var_08 = func_7EA5(var_0C);
		}
	}
	else
	{
		var_0A = 24000;
		var_0B = 6500;
		if(!isdefined(var_08))
		{
			var_0C = 850;
			var_08 = 1500;
			if(isdefined(level.var_1AF8))
			{
				var_0C = var_0C * level.var_1AF8;
			}
		}
		else
		{
			var_0C = var_08.origin[2];
			if(getdvar("mapname") == "mp_rally")
			{
				var_0C = var_0C + 2500;
			}

			var_08 = func_7EA5(var_0C);
		}
	}

	param_01 endon("disconnect");
	var_0D = param_00;
	level.var_1AF2 = [];
	level.var_1AF3 = 0;
	level.var_1AF4 = 0;
	if(param_04 == "jackal")
	{
		param_02 = param_01.origin;
		var_0E = func_7EBE(param_02,var_09,var_0A,var_07,var_0C,var_0B,var_08,param_04);
		param_01 scripts\mp\killstreaks\_jackal::func_2A6B(param_00,var_0E["startPoint"],param_02,param_06);
		return;
	}

	if(param_05 == "precision_airstrike")
	{
		var_0E = func_7EBE(param_03,var_0A,var_0B,var_08,var_0D,var_0C,var_09,param_05);
		var_0F = anglestoright(var_09);
		if(scripts\mp\killstreaks\_utility::func_A69F(param_06,"passive_precision_strike"))
		{
			level thread func_5A60(param_00,param_01,var_0D,param_02,var_0E["startPoint"],var_0E["endPoint"],var_0E["bombTime"],var_0E["flyTime"],var_09,param_04,param_05,param_06);
			playsoundatpos(var_0E["startPoint"],"ks_scorchers_init");
			wait(randomfloatrange(0.8,1));
			scripts\mp\_hostmigration::func_13834();
			level thread func_5A60(param_00,param_01,var_0D,param_02,var_0E["startPoint"],var_0E["endPoint"],var_0E["bombTime"],var_0E["flyTime"],var_09,param_04,param_05,param_06);
			wait(randomfloatrange(0.8,1));
			scripts\mp\_hostmigration::func_13834();
			level thread func_5A60(param_00,param_01,var_0D,param_02,var_0E["startPoint"],var_0E["endPoint"],var_0E["bombTime"],var_0E["flyTime"],var_09,param_04,param_05,param_06);
			return;
		}

		if(scripts\mp\killstreaks\_utility::func_A69F(param_06,"passive_split_strike"))
		{
			level thread func_5A60(param_00,param_01,var_0D,param_02,var_0E["startPoint"],var_0E["endPoint"],var_0E["bombTime"],var_0E["flyTime"],var_09,param_04,param_05,param_06);
			playsoundatpos(var_0E["startPoint"],"ks_scorchers_init");
			return;
		}

		level thread func_5A60(param_00,param_01,var_0D,param_02,var_0E["startPoint"],var_0E["endPoint"],var_0E["bombTime"],var_0E["flyTime"],var_09,param_04,param_05,param_06);
		playsoundatpos(var_0E["startPoint"],"ks_scorchers_init");
		wait(randomfloatrange(0.5,0.7));
		scripts\mp\_hostmigration::func_13834();
		level thread func_5A60(param_00,param_01,var_0D,param_02,var_0E["startPoint"] + var_0F * 175,var_0E["endPoint"] + var_0F * 175,var_0E["bombTime"],var_0E["flyTime"],var_09,param_04,param_05,param_06);
		wait(randomfloatrange(0.5,0.7));
		scripts\mp\_hostmigration::func_13834();
		level thread func_5A60(param_00,param_01,var_0D,param_02,var_0E["startPoint"] - var_0F * 175,var_0E["endPoint"] - var_0F * 175,var_0E["bombTime"],var_0E["flyTime"],var_09,param_04,param_05,param_06);
		return;
	}

	var_0E = func_7EBE(param_03,var_0A,var_0B,var_08,var_0D,var_0C,var_09,param_05);
	level thread func_5A60(param_00,param_01,var_0D,param_02,var_0E["startPoint"] + (0,0,randomint(500)),var_0E["endPoint"] + (0,0,randomint(500)),var_0E["bombTime"],var_0E["flyTime"],var_09,param_04,param_05,param_06);
	wait(randomfloatrange(1.5,2.5));
	scripts\mp\_hostmigration::func_13834();
	level thread func_5A60(param_00,param_01,var_0D,param_02,var_0E["startPoint"] + (0,0,randomint(200)),var_0E["endPoint"] + (0,0,randomint(200)),var_0E["bombTime"],var_0E["flyTime"],var_09,param_04,param_05,param_06);
	wait(randomfloatrange(1.5,2.5));
	scripts\mp\_hostmigration::func_13834();
	level thread func_5A60(param_00,param_01,var_0D,param_02,var_0E["startPoint"] + (0,0,randomint(200)),var_0E["endPoint"] + (0,0,randomint(200)),var_0E["bombTime"],var_0E["flyTime"],var_09,param_04,param_05,param_06);
	if(param_04 == "super_airstrike")
	{
		wait(randomfloatrange(2.5,3.5));
		scripts\mp\_hostmigration::func_13834();
		level thread func_5A60(param_00,param_01,var_0D,param_02,var_0E["startPoint"] + (0,0,randomint(200)),var_0E["endPoint"] + (0,0,randomint(200)),var_0E["bombTime"],var_0E["flyTime"],var_09,param_04,param_05,param_06);
		return;
	}
}

//Function Number: 31
func_7EBE(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	var_08 = param_00 + anglestoforward(param_01) * -1 * param_02;
	if(isdefined(param_03))
	{
		var_08 = var_08 * (1,1,0);
	}

	var_08 = var_08 + (0,0,param_04);
	var_09 = param_00 + anglestoforward(param_01) * param_02;
	if(isdefined(param_03))
	{
		var_09 = var_09 * (1,1,0);
	}

	var_09 = var_09 + (0,0,param_04);
	var_0A = length(var_08 - var_09);
	var_0B = var_0A / param_05;
	var_0A = abs(var_0A / 2 + param_06);
	var_0C = var_0A / param_05;
	var_0D["startPoint"] = var_08;
	var_0D["endPoint"] = var_09;
	var_0D["bombTime"] = var_0C;
	var_0D["flyTime"] = var_0B;
	return var_0D;
}

//Function Number: 32
func_7EA5(param_00)
{
	var_01 = 850;
	var_02 = 1500;
	var_03 = var_01 / param_00;
	var_04 = var_03 * var_02;
	return var_04;
}

//Function Number: 33
func_11561(param_00,param_01)
{
	var_02 = func_1156E(param_00,param_01);
	if(var_02)
	{
		var_03 = 1;
	}
	else
	{
		var_03 = -1;
	}

	var_04 = scripts\common\utility::func_6EE3(param_00.origin);
	var_05 = var_04 + anglestoforward(scripts\common\utility::func_6EE1(param_00.angles)) * var_03 * 100000;
	var_06 = pointonsegmentnearesttopoint(var_04,var_05,param_01);
	var_07 = distance(var_04,var_06);
	return var_07;
}

//Function Number: 34
func_1156D(param_00,param_01,param_02)
{
	if(!isdefined(param_02))
	{
		param_02 = 3000;
	}

	var_03 = func_1156E(param_00,param_01);
	if(var_03)
	{
		var_04 = 1;
	}
	else
	{
		var_04 = -1;
	}

	var_05 = scripts\common\utility::func_6EE3(param_00.origin);
	var_06 = var_05 + anglestoforward(scripts\common\utility::func_6EE1(param_00.angles)) * var_04 * 100000;
	var_07 = pointonsegmentnearesttopoint(var_05,var_06,param_01);
	var_08 = distance(var_05,var_07);
	if(var_08 < param_02)
	{
		return 1;
	}

	return 0;
}

//Function Number: 35
func_1156E(param_00,param_01)
{
	var_02 = anglestoforward(scripts\common\utility::func_6EE1(param_00.angles));
	var_03 = vectornormalize(scripts\common\utility::func_6EE3(param_01) - param_00.origin);
	var_04 = vectordot(var_02,var_03);
	if(var_04 > 0)
	{
		return 1;
	}

	return 0;
}

//Function Number: 36
func_136A8()
{
	self waittill("cancel_location");
	self setblurforplayer(0,0.3);
}

//Function Number: 37
func_F1AA(param_00,param_01,param_02)
{
	var_03 = (0,0,0);
	var_04 = undefined;
	var_05 = self.angles[1];
	var_06 = undefined;
	var_07 = undefined;
	if(!isdefined(level.var_B339))
	{
		return;
	}

	var_08 = level.var_B339 / 6.46875;
	if(level.splitscreen)
	{
		var_08 = var_08 * 1.5;
	}

	var_09 = spawn("script_origin",self.origin);
	var_0A = "used_" + param_01;
	var_0B = scripts\mp\_killstreak_loot::getrarityforlootitem(param_02.var_1318B);
	if(var_0B != "")
	{
		var_0A = var_0A + "_" + var_0B;
	}

	if(param_01 == "precision_airstrike")
	{
		var_0C = 1;
		var_07 = 1;
		if(scripts\mp\killstreaks\_utility::func_A69F(param_02,"passive_split_strike"))
		{
			var_0C = 3;
		}

		scripts\common\utility::func_1C76(0);
		if(self.team == "allies")
		{
			var_0D = "UN_";
		}
		else
		{
			var_0D = "PD_";
		}

		self playlocalsound("bombardment_killstreak_bootup");
		var_09 playloopsound("bombardment_killstreak_hud_loop");
		self setsoundsubmix("mp_killstreak_overlay");
		var_04 = scripts\mp\killstreaks\_mapselect::func_8112(param_01,var_0C,1);
		scripts\common\utility::func_1C76(1);
	}
	else if(param_01 == "jackal" && isdefined(level.var_A056) || level.var_A412.size > 1)
	{
		self notify("cancel_location");
		scripts\mp\_hud_message::func_10122("KILLSTREAKS_AIR_SPACE_TOO_CROWDED");
		if(isdefined(var_09))
		{
			var_09 stoploopsound("");
			var_09 delete();
		}

		self method_84D6();
		return 0;
	}

	if(isdefined(var_04))
	{
		if(scripts\mp\_utility::func_9FB3(level.var_1AF9))
		{
			scripts\mp\_hud_message::func_10122("KILLSTREAKS_AIR_SPACE_TOO_CROWDED");
			return 0;
		}

		thread func_6CDD(var_04,var_07,param_00,var_03,var_05,param_01,var_06,param_02);
		self playlocalsound("bombardment_killstreak_shutdown");
		self method_84D6();
	}
	else if(!isdefined(var_04) && scripts\mp\_utility::func_9E90(param_01))
	{
		if(isdefined(var_09))
		{
			var_09 stoploopsound("");
			var_09 delete();
		}

		self playlocalsound("bombardment_killstreak_shutdown");
		self method_84D6();
		return 0;
	}
	else
	{
		if(param_01 == "jackal")
		{
			if(scripts\mp\killstreaks\_jackal::func_8013(self) >= 1)
			{
				scripts\mp\_hud_message::func_10122("KILLSTREAKS_AIR_SPACE_TOO_CROWDED");
				if(isdefined(var_09))
				{
					var_09 stoploopsound("");
					var_09 delete();
				}

				self method_84D6();
				return 0;
			}
		}

		func_6CD3(param_00,var_03,var_05,param_01,var_06,param_02);
		if(param_01 == "jackal" && scripts\mp\killstreaks\_utility::func_A69F(param_02,"passive_support_drop"))
		{
			var_0E = scripts\common\utility::func_13734("called_in_jackal","cancel_jackal");
			if(!isdefined(var_0E) || var_0E == "cancel_jackal")
			{
				return 0;
			}
		}
	}

	if(isdefined(var_09))
	{
		var_09 stoploopsound("");
		var_09 delete();
	}

	thread scripts\mp\_utility::func_115DE(var_0A,self);
	scripts\mp\_matchdata::func_AFC9(param_01,var_03);
	return 1;
}

//Function Number: 38
func_6CDD(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	self endon("disconnect");
	foreach(var_0A, var_09 in param_00)
	{
		param_03 = var_09.var_AEC4;
		if(scripts\mp\_utility::func_9FB3(param_01))
		{
			param_04 = var_09.angles;
		}

		func_6CD3(param_02,param_03,param_04,param_05,param_06,param_07);
		if(param_00.size > 1 && var_0A < param_00.size - 1)
		{
			wait(randomfloatrange(0.8,1));
		}
	}
}

//Function Number: 39
func_6CD3(param_00,param_01,param_02,param_03,param_04,param_05)
{
	self notify("used");
	var_06 = bullettrace(level.var_B32E + (0,0,1000000),level.var_B32E,0,undefined);
	param_01 = (param_01[0],param_01[1],var_06["position"][2] - 514);
	thread func_57DD(param_00,param_01,param_02,self,self.pers["team"],param_03,param_04,param_05);
}

//Function Number: 40
func_1303E(param_00,param_01,param_02)
{
}

//Function Number: 41
func_8998(param_00)
{
	self endon("death");
	if(param_00 scripts\mp\killstreaks\_emp_common::isemped())
	{
		self notify("death");
		return;
	}

	for(;;)
	{
		level waittill("emp_update");
		if(!param_00 scripts\mp\killstreaks\_emp_common::isemped())
		{
			continue;
		}

		self notify("death");
	}
}

//Function Number: 42
func_1AFB(param_00)
{
	self endon("death");
	self endon("disconnect");
	switch(param_00)
	{
		case "precision_airstrike":
			self playlocalsound(game["voice"][self.team] + "KS_ast_inbound");
			break;
	}
}

//Function Number: 43
func_1AFA(param_00,param_01,param_02,param_03)
{
	var_04 = param_03 * 20;
	for(var_05 = 0;var_05 < var_04;var_05++)
	{
		wait(0.05);
	}
}

//Function Number: 44
func_11A82()
{
	self endon("death");
	var_00 = self.origin;
	for(;;)
	{
		thread func_1AFA(var_00,self.origin,(0.5,1,0),40);
		var_00 = self.origin;
		wait(0.2);
	}
}

//Function Number: 45
triggerjackalweapon(param_00)
{
	if(scripts\mp\killstreaks\_utility::func_A69F(param_00,"passive_support_drop"))
	{
		param_00.var_EF88 = "no_fire_weapon";
		param_00.var_394 = "deploy_warden_mp";
	}

	return 1;
}