/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\killstreaks\_jackal.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 63
 * Decompile Time: 3142 ms
 * Timestamp: 10/27/2023 12:28:54 AM
*******************************************************************/

//Function Number: 1
func_2A6B(param_00,param_01,param_02,param_03)
{
	var_04 = undefined;
	if(scripts\mp\killstreaks\_utility::func_A69F(param_03,"passive_support_drop"))
	{
		var_04 = scripts\mp\killstreaks\_target_marker::func_819B(param_03);
		if(!isdefined(var_04.var_AEC4))
		{
			self notify("cancel_jackal");
			return 0;
		}
		else if(isdefined(level.var_A22D) || level.var_A412.size > 0)
		{
			if(isdefined(var_04.var_1349C))
			{
				var_04.var_1349C delete();
			}

			scripts\mp\_hud_message::func_10122("KILLSTREAKS_AIR_SPACE_TOO_CROWDED");
			if(isdefined(param_03.var_394) && param_03.var_394 != "none")
			{
				self notify("killstreak_finished_with_weapon_" + param_03.var_394);
			}

			self notify("cancel_jackal");
			return 0;
		}
	}

	self notify("called_in_jackal");
	level.var_A22D = 1;
	var_05 = getent("airstrikeheight","targetname");
	if(isdefined(var_05))
	{
		var_06 = var_05.origin[2] + 100;
	}
	else if(isdefined(level.var_1AF8))
	{
		var_06 = 850 * level.var_1AF8;
	}
	else
	{
		var_06 = 850;
	}

	if(isdefined(var_04) && isdefined(var_04.var_AEC4))
	{
		param_02 = var_04.var_AEC4;
	}

	param_02 = param_02 * (1,1,0);
	var_07 = param_02 + (0,0,var_06);
	var_08 = func_108DE(param_00,self,param_01,var_07,param_03);
	var_09 = var_07;
	var_0A = var_07 + anglestoright(self.angles) * 2000;
	var_0B = var_07 - anglestoright(self.angles) * 2000;
	var_0C = [var_09,var_0A,var_0B];
	foreach(var_0E in var_0C)
	{
		if(!jackalcanseelocation(var_08,var_0E))
		{
			continue;
		}

		var_07 = var_0E;
		break;
	}

	var_08.var_C96C = var_07;
	thread func_5088(var_08,var_04);
	self.pers["wardenKSCount"]++;
	if(self.pers["wardenKSCount"] % 2 == 0)
	{
		scripts\mp\_missions::func_D991("ch_warden_double");
	}
}

//Function Number: 2
func_108DE(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = vectortoangles(param_03 - param_02);
	var_06 = "veh_mil_air_ca_dropship_mp";
	var_07 = 1;
	var_08 = "jackal_turret_mp";
	var_09 = "veh_mil_air_ca_dropship_mp_turret";
	var_0A = 1;
	var_0B = "jackal_cannon_mp";
	var_0C = "veh_mil_air_ca_dropship_turret_missile";
	var_0D = 1;
	var_0E = 250;
	var_0F = 175;
	var_10 = 3000;
	var_11 = &"KILLSTREAKS_HINTS_JACKAL_GUARD";
	var_12 = "follow_player";
	var_13 = scripts\mp\_killstreak_loot::getrarityforlootitem(param_04.var_1318B);
	if(var_13 != "")
	{
		var_06 = var_06 + "_" + var_13;
	}

	if(scripts\mp\killstreaks\_utility::func_A69F(param_04,"passive_extra_flare"))
	{
		var_07 = var_07 + 1;
	}

	if(scripts\mp\killstreaks\_utility::func_A69F(param_04,"passive_moving_fortress"))
	{
		var_0B = "jackal_turret_mp";
		var_0C = "veh_mil_air_ca_dropship_mp_turret";
	}

	if(scripts\mp\killstreaks\_utility::func_A69F(param_04,"passive_support_drop"))
	{
		var_12 = "guard_location";
	}

	var_14 = spawnhelicopter(param_01,param_02,var_05,"veh_jackal_mp",var_06);
	if(!isdefined(var_14))
	{
		return;
	}

	var_14 thread func_8992();
	var_14.var_4D2E = ::func_3758;
	var_14.var_2B3 = var_0E;
	var_14.var_1545 = var_0F;
	var_14.health = var_10;
	var_14.maxhealth = var_14.health;
	var_14.team = param_01.team;
	var_14.var_222 = param_01;
	var_14 setcandamage(1);
	var_14.var_5087 = param_03;
	var_14.var_AC68 = param_00;
	var_14.var_A056 = 1;
	var_14.var_110E8 = param_04;
	var_14.var_110EA = param_04.var_110EA;
	var_14.var_67E3 = 0;
	var_14.var_BC = var_12;
	var_14.var_4C08 = var_11;
	var_14.var_110E8 = param_04;
	var_14.var_6EB4 = var_07;
	var_14.turreton = var_0A;
	var_14.turretweapon = var_08;
	var_14.cannonweapon = var_0B;
	var_14.cannonon = var_0D;
	var_14 scripts\mp\killstreaks\_utility::func_1843(param_04.var_110EA,"Killstreak_Air",param_01,1);
	var_14 method_830A(0,90);
	var_14 method_83E5(var_14.var_2B3,var_14.var_1545);
	var_14 method_82F6(50,100,50);
	var_14 method_8354(0.05);
	var_14 method_8378(45,25,25,0.5);
	var_14 method_831F(param_01);
	var_15 = anglestoforward(var_14.angles);
	var_14.var_129B9 = spawnturret("misc_turret",var_14 gettagorigin("tag_turret"),var_08);
	var_14.var_129B9 setmodel(var_09);
	var_14.var_129B9.var_222 = param_01;
	var_14.var_129B9.team = param_01.team;
	var_14.var_129B9.angles = var_14.angles;
	var_14.var_129B9.type = "Machine_Gun";
	var_14.var_129B9.var_110E8 = param_04;
	var_14.var_129B9 linkto(var_14,"tag_turret");
	var_14.var_129B9 method_835B(0);
	var_14.var_129B9 method_830F("manual_target");
	var_14.var_129B9 method_8336(param_01);
	var_14.var_38D3 = spawnturret("misc_turret",var_14 gettagorigin("tag_origin"),var_0B);
	var_14.var_38D3 setmodel(var_0C);
	var_14.var_38D3.var_222 = param_01;
	var_14.var_38D3.team = param_01.team;
	var_14.var_38D3.angles = var_14.angles;
	var_14.var_38D3.type = "Cannon";
	var_14.var_38D3.var_110E8 = param_04;
	var_14.var_38D3 linkto(var_14,"tag_origin",(-300,0,30),(0,0,0));
	var_14.var_38D3 method_835B(0);
	var_14.var_38D3 method_830F("manual_target");
	var_14.var_38D3 method_8336(param_01);
	var_14.var_130AC = spawn("script_model",var_14 gettagorigin("tag_origin"));
	var_14.var_130AC linkto(var_14,"tag_origin");
	level.var_A412[level.var_A412.size] = var_14;
	level.var_A412 = scripts\common\utility::func_22BC(level.var_A412);
	level.var_A22D = undefined;
	var_14 method_84BE("killstreak_jackal_mp");
	var_14 thread scripts\mp\killstreaks\_flares::func_6EAB(undefined,"j_body");
	var_14 thread func_A3BD();
	var_14 thread func_510C(0.05,"dropship_enemy_hover_world_grnd");
	var_14 thread func_50BE();
	var_14 thread scripts\mp\killstreaks\_flares::func_6EAD(var_14.var_6EB4);
	var_14.var_129B9.var_131D8 = var_14;
	var_14.var_38D3.var_131D8 = var_14;
	var_16 = anglestoforward(var_14.angles);
	var_14.var_129B9.var_131D8.var_A63A = spawn("script_model",var_14 gettagorigin("tag_turret_front"));
	var_14.var_129B9.var_131D8.var_A63A linkto(var_14,"tag_turret_front");
	var_14.var_38D3.var_131D8.var_A63A = var_14.var_129B9.var_131D8.var_A63A;
	if(scripts\mp\killstreaks\_utility::func_A69F(param_04,"passive_moving_fortress"))
	{
		var_14.var_38D3.var_131D8.var_A63A linkto(var_14,"tag_turret_rear");
	}

	if(scripts\mp\killstreaks\_utility::func_A69F(param_04,"passive_support_drop"))
	{
		var_17 = -120;
		var_18 = "jackaldrop";
		var_14.dropcrates = [];
		for(var_19 = 0;var_19 < 3;var_19++)
		{
			var_1A = scripts\mp\killstreaks\_airdrop::func_7E43(var_18);
			var_1B = var_14 scripts\mp\killstreaks\_airdrop::func_4982(param_01,var_18,var_1A,var_14.origin);
			var_1B linkto(var_14,"tag_origin",(var_17,0,0),(0,0,0));
			var_14.dropcrates[var_14.dropcrates.size] = var_1B;
			var_17 = var_17 + 60;
		}
	}

	var_14 setscriptablepartstate("thrusters","fly",0);
	return var_14;
}

//Function Number: 3
func_8013(param_00)
{
	var_01 = 0;
	if(level.teambased)
	{
		foreach(var_03 in level.var_A412)
		{
			if(var_03.team != param_00.team)
			{
				continue;
			}

			var_01++;
		}
	}
	else
	{
		foreach(var_03 in level.var_A412)
		{
			if(var_03.var_222 != param_00)
			{
				continue;
			}

			var_01++;
		}
	}

	return var_01;
}

//Function Number: 4
func_50BE()
{
	self endon("death");
	scripts\mp\_hostmigration::func_13708(6);
	self playsoundonmovingent("dropship_killstreak_flyby");
}

//Function Number: 5
func_510C(param_00,param_01)
{
	self endon("death");
	scripts\mp\_hostmigration::func_13708(param_00);
	self playloopsound(param_01);
}

//Function Number: 6
func_5088(param_00,param_01)
{
	param_00 endon("death");
	param_00 endon("leaving");
	param_00 method_8362(param_00.var_C96C,1);
	param_00 playsoundonmovingent("dropship_killstreak_thrust_change");
	param_00 thread func_42AB(param_00.var_C96C);
	param_00 thread func_B9FF();
	if(isdefined(param_00.dropcrates))
	{
		param_00 thread watchdropcratesearly(param_01);
	}

	param_00 waittill("goal");
	if(isdefined(param_01) && isdefined(param_00.dropcrates))
	{
		param_00 thread func_A426();
		param_00 thread func_13A86();
		param_00 thread func_658F();
		param_00 thread func_6590();
		param_00 setscriptablepartstate("thrusters","slow",0);
		param_00 method_83E5(param_00.var_2B3 - 215,param_00.var_1545 - 160);
		param_00 jackalmovetolocation(param_01.var_AEC4);
		param_00 thread dropcrates(param_00.dropcrates,param_01);
		param_00 thread watchjackalcratepickup();
		param_00 scripts\common\utility::waittill_any_timeout_1(10,"all_crates_gone");
		param_00.var_BC = "follow_player";
	}
	else
	{
		param_00 thread func_A426();
		param_00 thread func_13A86();
		param_00 thread func_658F();
		param_00 thread func_6590();
	}

	param_00.var_130AC scripts\mp\killstreaks\_utility::func_F774(param_00.var_222,param_00.var_4C08,360,360,30000,30000,2);
	param_00 thread patrolfield();
	param_00 thread func_13AD6(func_8026(param_00.var_BC),param_00.var_4C08);
}

//Function Number: 7
func_658F()
{
	self notify("engagePrimary");
	self endon("engagePrimary");
	self endon("leaving");
	self endon("death");
	self.var_A930 = undefined;
	if(scripts\mp\_utility::func_9FB3(self.turreton))
	{
		for(;;)
		{
			var_00 = func_A3F3();
			if(isdefined(var_00) && var_00.size > 0)
			{
				func_1573(var_00);
				self.var_129B9 waittill("stop_firing");
				if(self.var_BC == "follow_player")
				{
					thread patrolfield();
				}

				continue;
			}

			self.var_A930 = "noTargetsFound";
			wait(0.05);
		}
	}
}

//Function Number: 8
func_6590()
{
	self notify("engageSecondary");
	self endon("engageSecondary");
	self endon("leaving");
	self endon("death");
	var_00 = function_0240(self.cannonweapon);
	if(scripts\mp\_utility::func_9FB3(self.cannonon))
	{
		for(;;)
		{
			var_01 = func_A3F3();
			if(scripts\mp\killstreaks\_utility::func_A69F(self.var_110E8,"passive_moving_fortress"))
			{
				if(isdefined(var_01) && var_01.size > 0)
				{
					func_156F(var_01);
					if(isdefined(self.var_38DD))
					{
						self.var_38D3 waittill("stop_firing");
					}
				}

				wait(0.05);
				continue;
			}

			if(!isdefined(var_01) || var_01.size < 2)
			{
				wait(0.05);
				continue;
			}

			func_156F(var_01);
			scripts\mp\_hostmigration::func_13708(var_00);
		}
	}
}

//Function Number: 9
func_7246()
{
	self endon("death");
	self endon("leaving");
	self endon("guard_location");
	self endon("priority_target");
	self endon("jackal_crashing");
	self.var_222 endon("disconnect");
	self notify("following_player");
	self method_83E5(self.var_2B3 - 215,self.var_1545 - 160);
	self setscriptablepartstate("thrusters","slow",0);
	for(;;)
	{
		var_00 = undefined;
		if(scripts\mp\_utility::func_9FB3(self.var_67E3))
		{
			var_01 = self.var_222.origin[0];
			var_02 = self.var_222.origin[1];
			var_03 = var_01 + randomintrange(-500,500);
			var_04 = var_02 + randomintrange(-500,500);
			var_05 = func_7E3E(var_03,var_04,350);
			var_00 = (var_03,var_04,var_05);
		}
		else
		{
			var_01 = self.var_222.origin[0];
			var_02 = self.var_222.origin[1];
			var_05 = func_7E3E(var_01,var_02,20);
			var_00 = (var_01,var_02,var_05);
		}

		self method_8305(self.var_222);
		self method_8362(var_00,1);
		self.var_A930 = "following_player";
		scripts\common\utility::waittill_any_3("goal","begin_evasive_maneuvers");
		self method_8076();
		scripts\mp\_hostmigration::func_13708(0.1);
	}
}

//Function Number: 10
guardposition(param_00)
{
	self endon("death");
	self endon("leaving");
	self endon("follow_player");
	self endon("jackal_crashing");
	self.var_222 endon("disconnect");
	self method_83E5(self.var_2B3 - 215,self.var_1545 - 160);
	self setscriptablepartstate("thrusters","slow",0);
	var_01 = undefined;
	if(scripts\mp\_utility::func_9FB3(self.var_67E3))
	{
		var_02 = self.var_222.origin[0];
		var_03 = self.var_222.origin[1];
		var_04 = var_02 + randomintrange(-500,500);
		var_05 = var_03 + randomintrange(-500,500);
		var_06 = func_7E3E(var_04,var_05,350);
		var_01 = (var_04,var_05,var_06);
	}
	else
	{
		var_02 = self.var_222.origin[0];
		var_03 = self.var_222.origin[1];
		var_06 = func_7E3E(var_03,var_06,20);
		var_01 = (var_02,var_03,var_06);
	}

	self method_8305(self.var_222);
	self method_8362(var_01,1);
	self.var_A930 = "following_player";
	scripts\common\utility::waittill_any_3("goal","begin_evasive_maneuvers");
	self method_8076();
}

//Function Number: 11
patrolfield()
{
	self endon("death");
	self endon("leaving");
	self endon("guard_location");
	self endon("priority_target");
	self endon("jackal_crashing");
	self.var_222 endon("disconnect");
	self method_83E5(self.var_2B3 - 215,self.var_1545 - 160);
	self setscriptablepartstate("thrusters","slow",0);
	for(;;)
	{
		var_00 = undefined;
		if(isdefined(self.patroltarget) && isalive(self.patroltarget) && isplayer(self.patroltarget) && !self.patroltarget method_8181("specialty_blindeye"))
		{
			if(!jackalcanseeenemy(self.patroltarget) || distance2dsquared(self.origin,self.patroltarget.origin) > 4194304)
			{
				jackalmovetoenemy(self.patroltarget);
			}
		}
		else
		{
			var_01 = jackalfindclosestenemy();
			if(isdefined(var_01))
			{
				self.patroltarget = var_01;
				thread watchpatroltarget();
				jackalmovetoenemy(var_01);
			}
			else
			{
				self.patroltarget = undefined;
				var_02 = jackalfindfirstopenpoint();
				if(isdefined(var_02))
				{
					jackalmovetolocation(var_02.origin);
				}
			}
		}

		scripts\mp\_hostmigration::func_13708(0.1);
	}
}

//Function Number: 12
jackalfindfirstopenpoint()
{
	var_00 = undefined;
	if(isdefined(level.var_3A58) && level.var_3A58.size > 0)
	{
		foreach(var_02 in level.var_3A58)
		{
			if(isdefined(var_02.var_14A) && !var_02.var_14A)
			{
				continue;
			}

			if(!jackalcanseelocation(self,var_02.origin))
			{
				continue;
			}

			var_02.var_14A = 0;
			var_00 = var_02;
			if(!isdefined(self.initialpatrolpoint))
			{
				self.initialpatrolpoint = var_00;
			}

			break;
		}

		if(!isdefined(var_00))
		{
			if(isdefined(self.initialpatrolpoint))
			{
				foreach(var_02 in level.var_3A58)
				{
					if(var_02 != self.initialpatrolpoint)
					{
						var_02.var_14A = undefined;
					}
				}

				var_00 = self.initialpatrolpoint;
			}
		}
	}

	return var_00;
}

//Function Number: 13
jackalcanseelocation(param_00,param_01)
{
	var_02 = 0;
	var_03 = scripts\common\trace::func_48BC(0,1,1,1,1,1,0);
	if(scripts\common\trace::func_DCF1(param_00.origin,param_01,param_00,var_03))
	{
		var_02 = 1;
	}

	return var_02;
}

//Function Number: 14
jackalcanseeenemy(param_00)
{
	var_01 = 0;
	var_02 = scripts\common\trace::func_48BC(0,1,0,1,1,0);
	var_03 = [param_00 gettagorigin("j_head"),param_00 gettagorigin("j_mainroot"),param_00 gettagorigin("tag_origin")];
	for(var_04 = 0;var_04 < var_03.size;var_04++)
	{
		if(!scripts\common\trace::func_DCF1(self.origin,var_03[var_04],self,var_02))
		{
			continue;
		}

		var_01 = 1;
		break;
	}

	return var_01;
}

//Function Number: 15
jackalmovetoenemy(param_00)
{
	if(isdefined(self.patroltarget))
	{
		param_00 = self.patroltarget;
	}

	if(jackalcanseeenemy(param_00))
	{
		self method_8305(param_00);
	}

	var_01 = undefined;
	if(scripts\mp\_utility::func_9FB3(self.var_67E3))
	{
		var_02 = param_00.origin[0];
		var_03 = param_00.origin[1];
		var_04 = var_02 + randomintrange(-500,500);
		var_05 = var_03 + randomintrange(-500,500);
		var_06 = func_7E3E(var_04,var_05,350);
		var_01 = (var_04,var_05,var_06);
	}
	else
	{
		var_02 = var_03.origin[0];
		var_03 = var_02.origin[1];
		var_06 = func_7E3E(var_03,var_06,20);
		var_01 = (var_02,var_03,var_06);
	}

	var_07 = scripts\common\trace::func_48BC(0,1,1,1,1,1,0);
	var_08 = scripts\common\trace::func_DCED(self.origin,var_01,level.var_3CB5,var_07);
	if(var_08["hittype"] != "hittype_none")
	{
		var_09 = func_7E3E(var_08["position"][0],var_08["position"][1],20);
		var_01 = (var_08["position"][0],var_08["position"][1],var_09);
	}

	self method_8362(var_01,2);
	self.var_A930 = "patrol";
	scripts\common\utility::waittill_any_3("goal","begin_evasive_maneuvers");
	self method_8076();
}

//Function Number: 16
jackalfindclosestenemy()
{
	var_00 = [];
	foreach(var_02 in level.players)
	{
		if(var_02.ignoreme || isdefined(var_02.var_222) && var_02.var_222.ignoreme)
		{
			continue;
		}

		if(!isalive(var_02))
		{
			continue;
		}

		if(isdefined(level.teambased) && isdefined(var_02.team) && self.team == var_02.team)
		{
			continue;
		}

		if(var_02 method_8181("specialty_blindeye"))
		{
			continue;
		}

		if(var_02 isjackalenemyindoors())
		{
			continue;
		}

		var_00[var_00.size] = var_02;
		scripts\common\utility::func_136F7();
	}

	var_04 = undefined;
	if(var_00.size > 0)
	{
		var_04 = sortbydistance(var_00,self.origin);
	}

	if(isdefined(var_04) && var_04.size > 0)
	{
		return var_04[0];
	}

	return undefined;
}

//Function Number: 17
isjackalenemyindoors()
{
	var_00 = 0;
	var_01 = scripts\common\trace::func_48BC(0,1,0,1,1,0);
	if(!scripts\common\trace::func_DCF1(self.origin,self.origin + (0,0,10000),self,var_01))
	{
		var_00 = 1;
	}

	return var_00;
}

//Function Number: 18
watchpatroltarget()
{
	self endon("death");
	self endon("leaving");
	self endon("jackal_crashing");
	self.var_222 endon("disconnect");
	var_00 = self.patroltarget scripts\common\utility::waittill_any_timeout_1(5,"death","disconnect");
	self.patroltarget = undefined;
}

//Function Number: 19
jackalmovetolocation(param_00)
{
	var_01 = undefined;
	if(scripts\mp\_utility::func_9FB3(self.var_67E3))
	{
		var_02 = param_00[0];
		var_03 = param_00[1];
		var_04 = var_02 + randomintrange(-500,500);
		var_05 = var_03 + randomintrange(-500,500);
		var_06 = func_7E3E(var_04,var_05,350);
		var_01 = (var_04,var_05,var_06);
	}
	else
	{
		var_02 = var_03[0];
		var_03 = var_02[1];
		var_06 = func_7E3E(var_03,var_06,20);
		var_01 = (var_02,var_03,var_06);
	}

	self method_8076();
	self method_8362(var_01,10);
	scripts\common\utility::waittill_any_3("goal","begin_evasive_maneuvers");
}

//Function Number: 20
func_A406()
{
	self endon("death");
	self method_830A(0,0);
	self notify("leaving");
	self method_8076();
	self.var_129B9 method_8336(undefined);
	if(isdefined(self.var_12A95) && isdefined(self.var_11576))
	{
		scripts\mp\_utility::func_C78F(self.var_11576,self.var_12A95);
	}

	self method_83E5(self.var_2B3 - 215,self.var_1545 - 150);
	var_00 = self.origin + anglestoforward((0,randomint(360),0)) * 500;
	var_00 = var_00 + (0,0,1000);
	self setscriptablepartstate("thrusters","fast",0);
	if(!scripts\mp\_utility::func_9FB3(level.var_7669))
	{
		self playsoundonmovingent("dropship_killstreak_flyby");
	}

	self method_8362(var_00,1);
	if(isdefined(self.var_130AC))
	{
		self.var_130AC delete();
	}

	self waittill("goal");
	self setscriptablepartstate("thrusters","fly",0);
	var_01 = func_8051();
	self method_83E5(250,75);
	self method_8362(var_01,1);
	if(!scripts\mp\_utility::func_9FB3(level.var_7669))
	{
		self playsoundonmovingent("dropship_killstreak_flyby");
	}

	self waittill("goal");
	self stoploopsound();
	level.var_A412[level.var_A412.size - 1] = undefined;
	self notify("jackal_gone");
	thread func_A3BC();
}

//Function Number: 21
func_A3BC()
{
	scripts\mp\_utility::func_D915("killstreak ended - jackal",self.var_222);
	if(isdefined(self.var_129B9))
	{
		self.var_129B9 delete();
	}

	if(isdefined(self.var_38D3))
	{
		self.var_38D3 delete();
	}

	if(isdefined(self.var_130AC))
	{
		self.var_130AC delete();
	}

	foreach(var_01 in level.var_3A58)
	{
		var_01.var_14A = undefined;
	}

	self delete();
}

//Function Number: 22
func_A426()
{
	self endon("death");
	level endon("game_ended");
	var_00 = 60;
	if(scripts\mp\killstreaks\_utility::func_A69F(self.var_110E8,"passive_extra_flare"))
	{
		var_00 = var_00 - 10;
	}

	scripts\mp\_hostmigration::func_13708(var_00);
	if(isdefined(self.var_222))
	{
		self.var_222 scripts\mp\_utility::func_D4B6("jackal_end",undefined,undefined,self.var_222.origin);
	}

	thread func_A406();
}

//Function Number: 23
func_13A86()
{
	self endon("death");
	self endon("leaving");
	level waittill("game_ended");
	thread func_A406();
}

//Function Number: 24
func_DCBB()
{
	self notify("randomJackalMovement");
	self endon("randomJackalMovement");
	self endon("death");
	self endon("acquiringTarget");
	self endon("leaving");
	self.var_A930 = "randomMovement";
	var_00 = self.var_5087;
	var_01 = func_80C0(self.origin);
	self method_8362(var_01,1);
	thread scripts\mp\_utility::drawline(self.origin,var_01,5,(1,0,1));
	self waittill("goal");
}

//Function Number: 25
func_80C0(param_00)
{
	self method_8076();
	if(distance2dsquared(self.origin,self.var_222.origin) > 4194304)
	{
		var_01 = self.var_222.origin[0];
		var_02 = self.var_222.origin[1];
		var_03 = func_7E3E(var_01,var_02,20);
		var_04 = (var_01,var_02,var_03);
		self method_8305(self.var_222);
		return var_04;
	}

	var_05 = self.angles[1];
	var_06 = int(var_05 - 60);
	var_07 = int(var_05 + 60);
	var_08 = randomintrange(var_06,var_07);
	var_09 = (0,var_08,0);
	var_0A = self.origin + anglestoforward(var_09) * randomintrange(400,800);
	var_0B = var_0A[0];
	var_0C = var_0A[1];
	var_0D = func_7E3E(var_0B,var_0C,20);
	var_0E = func_11A8A(var_0B,var_0C,var_0D);
	if(var_0E != 0)
	{
		return var_0E;
	}

	var_0B = randomfloatrange(var_04[0] - 1200,var_04[0] + 1200);
	var_0C = randomfloatrange(var_04[1] - 1200,var_04[1] + 1200);
	var_0F = (var_0B,var_0C,var_0D);
	return var_0F;
}

//Function Number: 26
func_7FE2(param_00,param_01)
{
	self endon("death");
	self endon("acquiringTarget");
	self endon("leaving");
	if(!isdefined(param_01))
	{
		return;
	}

	var_02 = [];
	foreach(var_04 in level.players)
	{
		if(var_04 == self)
		{
			continue;
		}

		if(!level.teambased || var_04.team != self.team)
		{
			var_02[var_02.size] = var_04.origin;
		}
	}

	if(var_02.size > 0)
	{
		var_06 = averagepoint(var_02);
		var_07 = var_06[0];
		var_08 = var_06[1];
	}
	else
	{
		var_09 = level.var_B32E;
		var_0A = level.var_B339 / 4;
		var_07 = randomfloatrange(var_09[0] - var_0A,var_09[0] + var_0A);
		var_08 = randomfloatrange(var_09[1] - var_0A,var_09[1] + var_0A);
	}

	var_0B = func_7E3E(var_07,var_08,20);
	var_0C = func_11A8A(var_07,var_08,var_0B);
	if(var_0C != 0)
	{
		return var_0C;
	}

	var_07 = randomfloatrange(param_00[0] - 1200,param_00[0] + 1200);
	var_08 = randomfloatrange(param_00[1] - 1200,param_00[1] + 1200);
	var_0B = func_7E3E(var_07,var_08,20);
	var_0D = (var_07,var_08,var_0B);
	return var_0D;
}

//Function Number: 27
func_8054(param_00)
{
	var_01 = 100;
	var_02 = 15000;
	var_03 = randomfloat(360);
	var_04 = (0,var_03,0);
	var_05 = param_00 + anglestoforward(var_04) * -1 * var_02;
	var_05 = var_05 + (randomfloat(2) - 1 * var_01,randomfloat(2) - 1 * var_01,0);
	return var_05;
}

//Function Number: 28
func_8051()
{
	var_00 = 150;
	var_01 = 15000;
	var_02 = self.angles[1];
	var_03 = (0,var_02,0);
	var_04 = self.origin + anglestoforward(var_03) * var_01;
	return var_04;
}

//Function Number: 29
func_6D7B(param_00)
{
	self endon("leaving");
	self endon("explode");
	self endon("death");
	self endon("target_timeout");
	if(scripts\mp\_utility::func_9FB3(param_00) && scripts\mp\_utility::func_9F19(self.var_222) && !isdefined(self.var_A987) || self.var_A987 + 10000 <= gettime())
	{
		self.var_222 scripts\mp\_utility::func_C638("jackal_fire");
		self.var_A987 = gettime();
	}

	var_01 = scripts\mp\_utility::func_C794(self.var_12A95,"orange",self.var_222,1,0,"killstreak_personal");
	self.var_11576 = var_01;
	var_02 = 3;
	thread func_13A4B(self.var_129B9,self.var_12A95,"target_timeout",var_02);
	self.var_129B9 waittill("turret_on_target");
	level thread scripts\mp\_battlechatter_mp::func_EB87(self.var_12A95,"plr_killstreak_target");
	self.var_129B9 notify("start_firing");
	var_03 = function_0240(self.turretweapon);
	if(scripts\mp\killstreaks\_utility::func_A69F(self.var_110E8,"passive_moving_fortress"))
	{
		var_03 = var_03 + 0.13;
	}

	while(isdefined(self.var_12A95) && scripts\mp\_utility::func_9F19(self.var_12A95) && isdefined(self.var_129B9 method_8166(1)) && self.var_129B9 method_8166(1) == self.var_12A95)
	{
		self.var_129B9 method_837E();
		scripts\mp\_hostmigration::func_13708(var_03);
	}
}

//Function Number: 30
func_6D79(param_00)
{
	self endon("leaving");
	self endon("explode");
	self endon("death");
	self endon("target_cannon_timeout");
	var_01 = 3;
	thread func_13A4B(self.var_38D3,self.var_38DD,"target_cannon_timeout",var_01);
	self.var_38D3 waittill("turret_on_target");
	level thread scripts\mp\_battlechatter_mp::func_EB87(self.var_38DD,"plr_killstreak_target");
	if(!scripts\mp\killstreaks\_utility::func_A69F(self.var_110E8,"passive_moving_fortress"))
	{
		thread setmissilekillcament();
	}

	self.var_38D3 notify("start_firing");
	var_02 = function_0240(self.cannonweapon);
	if(scripts\mp\killstreaks\_utility::func_A69F(self.var_110E8,"passive_moving_fortress"))
	{
		var_02 = var_02 + 0.13;
		while(isdefined(self.var_38DD) && scripts\mp\_utility::func_9F19(self.var_38DD) && isdefined(self.var_38D3 method_8166(1)) && self.var_38D3 method_8166(1) == self.var_38DD)
		{
			self.var_38D3 method_837E();
			scripts\mp\_hostmigration::func_13708(var_02);
		}

		return;
	}

	if(isdefined(self.var_38DD) && scripts\mp\_utility::func_9F19(self.var_38DD) && isdefined(self.var_38D3 method_8166(1)) && self.var_38D3 method_8166(1) == self.var_38DD)
	{
		self.var_38D3 thread watchmissilelaunch();
		self.var_38D3 method_837E();
	}
}

//Function Number: 31
watchmissilelaunch()
{
	self endon("death");
	self waittill("missile_fire",var_00);
	var_00.var_110E8 = self.var_110E8;
}

//Function Number: 32
setmissilekillcament()
{
	self endon("leaving");
	self endon("explode");
	self endon("death");
	self endon("target_cannon_timeout");
	self.var_38D3 waittill("missile_fire",var_00);
	var_00.var_131D8 = self;
	var_00.var_131D8.var_A63A = self.var_38D3.var_131D8.var_A63A;
}

//Function Number: 33
func_13A4B(param_00,param_01,param_02,param_03)
{
	self endon("death");
	self endon("leaving");
	param_00 endon("stop_firing");
	var_04 = self.var_11576;
	var_05 = param_01 scripts\common\utility::waittill_any_timeout_1(param_03,"death","disconnect");
	if(var_05 == "timeout")
	{
		self notify(param_02);
	}

	if(param_00.type == "Machine_Gun")
	{
		if(isdefined(var_04) && isdefined(param_01))
		{
			scripts\mp\_utility::func_C78F(var_04,param_01);
		}

		self method_8076();
	}

	param_00 method_807E();
	param_00 notify("stop_firing");
}

//Function Number: 34
func_9F16(param_00)
{
	self endon("death");
	self endon("leaving");
	if(!isdefined(param_00))
	{
		param_00 = 10;
	}

	var_01 = anglestoforward(self.angles);
	var_02 = self.var_12A95.origin - self.origin;
	var_01 = var_01 * (1,1,0);
	var_02 = var_02 * (1,1,0);
	var_02 = vectornormalize(var_02);
	var_01 = vectornormalize(var_01);
	var_03 = vectordot(var_02,var_01);
	var_04 = cos(param_00);
	if(var_03 >= var_04)
	{
		return 1;
	}

	return 0;
}

//Function Number: 35
func_1573(param_00)
{
	self endon("death");
	self endon("leaving");
	self notify("priority_target");
	if(isdefined(self.var_C78D) && isdefined(self.var_12A95))
	{
		scripts\mp\_utility::func_C78F(self.var_C78D,self.var_12A95);
	}

	if(param_00.size == 1)
	{
		self.var_12A95 = param_00[0];
	}
	else
	{
		self.var_12A95 = func_7E05(param_00);
	}

	if(isdefined(self.var_12A95))
	{
		self method_8076();
		self method_8305(self.var_12A95);
		self.var_129B9 method_8347(self.var_12A95);
		self.var_A930 = "attackTarget";
		thread func_6D7B(1);
	}
}

//Function Number: 36
func_156F(param_00)
{
	self endon("death");
	self endon("leaving");
	self.var_38DD = func_7E05(param_00);
	if(isdefined(self.var_38DD))
	{
		self.var_38D3 method_8347(self.var_38DD);
		thread func_6D79(0);
	}
}

//Function Number: 37
func_A3F3()
{
	self endon("death");
	self endon("leaving");
	var_00 = [];
	var_01 = level.players;
	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		var_03 = var_01[var_02];
		if(func_9F97(var_03))
		{
			if(isdefined(var_01[var_02]))
			{
				var_00[var_00.size] = var_01[var_02];
			}
		}
		else
		{
			continue;
		}

		wait(0.05);
	}

	return var_00;
}

//Function Number: 38
func_9F97(param_00)
{
	self endon("death");
	if(!isalive(param_00) || param_00.sessionstate != "playing")
	{
		return 0;
	}

	if(isdefined(self.var_222) && param_00 == self.var_222)
	{
		return 0;
	}

	if(!isdefined(param_00.pers["team"]))
	{
		return 0;
	}

	if(level.teambased && param_00.pers["team"] == self.team)
	{
		return 0;
	}

	if(param_00.pers["team"] == "spectator")
	{
		return 0;
	}

	if(isdefined(param_00.var_10916) && gettime() - param_00.var_10916 / 1000 <= 5)
	{
		return 0;
	}

	if(param_00 scripts\mp\_utility::_hasperk("specialty_blindeye"))
	{
		return 0;
	}

	if(distance2dsquared(self.origin,param_00.origin) > 4194304)
	{
		return 0;
	}

	var_01 = (0,0,35);
	var_02 = param_00.origin + rotatevector(var_01,param_00 getworldupreferenceangles());
	var_03 = [self];
	var_04 = scripts\common\trace::func_DCED(self.origin,var_02,var_03,undefined,1);
	if(!isdefined(var_04["entity"]))
	{
		return 0;
	}

	return 1;
}

//Function Number: 39
func_7E05(param_00)
{
	self endon("death");
	var_01 = undefined;
	var_02 = undefined;
	foreach(var_04 in param_00)
	{
		if(isdefined(self.var_12A95) && self.var_12A95 == var_04)
		{
			continue;
		}

		var_05 = abs(vectortoangles(var_04.origin - self.origin)[1]);
		var_06 = abs(self gettagangles("tag_origin")[1]);
		var_05 = abs(var_05 - var_06);
		var_07 = var_04 getweaponslistitems();
		foreach(var_09 in var_07)
		{
			if(issubstr(var_09,"chargeshot") || issubstr(var_09,"lockon"))
			{
				var_05 = var_05 - 40;
			}
		}

		if(distance(self.origin,var_04.origin) > 4000)
		{
			var_05 = var_05 + 40;
		}

		if(!isdefined(var_01))
		{
			var_01 = var_05;
			var_02 = var_04;
			continue;
		}

		if(var_01 > var_05)
		{
			var_01 = var_05;
			var_02 = var_04;
		}
	}

	if(scripts\mp\killstreaks\_utility::func_A69F(self.var_110E8,"passive_moving_fortress"))
	{
		if(!isdefined(var_02) && isdefined(self.var_12A95))
		{
			var_02 = self.var_12A95;
		}
	}

	return var_02;
}

//Function Number: 40
func_8992()
{
	self endon("death");
	for(;;)
	{
		self waittill("damage",var_00,var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09,var_0A,var_0B,var_0C,var_0D);
		var_09 = scripts\mp\_utility::func_13CA1(var_09,var_0D);
		if((var_09 == "aamissile_projectile_mp" || var_09 == "nuke_mp") && var_04 == "MOD_EXPLOSIVE" && var_00 >= self.health)
		{
			func_3758(var_01,var_01,9001,0,var_04,var_09,var_03,var_02,var_03,0,0,var_07);
		}
	}
}

//Function Number: 41
func_3758(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B)
{
	if(isdefined(param_01))
	{
		if(isdefined(param_01.var_222))
		{
			param_01 = param_01.var_222;
		}
	}

	if((param_01 == self || isdefined(param_01.pers) && param_01.pers["team"] == self.team && !level.var_740A && level.teambased) && param_01 != self.var_222)
	{
		return;
	}

	if(lib_0DF8::func_9DDF(param_01))
	{
		return;
	}

	if(self.health <= 0)
	{
		return;
	}

	param_02 = scripts\mp\killstreaks\_utility::func_7FBD(param_01,param_05,param_04,param_02,self.maxhealth,3,4,5);
	scripts\mp\killstreaks\_killstreaks::func_A6A0(param_01,param_05,self,param_04);
	param_01 scripts\mp\_damagefeedback::func_12E84("");
	scripts\mp\_damage::func_AF96(self,param_02,param_01,param_07,param_06,param_04,param_0A,undefined,param_0B,param_03,param_05);
	if(self.health <= param_02)
	{
		if(isplayer(param_01) && !isdefined(self.var_222) || param_01 != self.var_222)
		{
			var_0C = scripts\mp\_killstreak_loot::getrarityforlootitem(self.var_110E8.var_1318B);
			var_0D = "callout_destroyed_harrier";
			if(var_0C != "")
			{
				var_0D = var_0D + "_" + var_0C;
			}

			scripts\mp\_damage::func_C548("jackal",param_01,param_05,param_04,param_02,"destroyed_jackal","jackal_destroyed",var_0D);
		}
	}

	if(self.health - param_02 <= 900 && !isdefined(self.var_1037E) || !self.var_1037E)
	{
		self.var_1037E = 1;
	}

	self method_83DB(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B);
}

//Function Number: 42
func_7E3E(param_00,param_01,param_02)
{
	var_03 = 600;
	var_04 = func_11A87(param_00,param_01);
	var_05 = var_04 + var_03;
	var_05 = var_05 + randomint(param_02);
	return var_05;
}

//Function Number: 43
func_CF0B()
{
	self endon("death");
	stopfxontag(level.var_8B56,self,"tag_engine_left");
	playfxontag(level.var_8B59,self,"tag_engine_left");
	stopfxontag(level.var_8B56,self,"tag_engine_right");
	playfxontag(level.var_8B59,self,"tag_engine_right");
	scripts\mp\_hostmigration::func_13708(0.15);
	stopfxontag(level.var_8B56,self,"tag_engine_left2");
	playfxontag(level.var_8B59,self,"tag_engine_left2");
	stopfxontag(level.var_8B56,self,"tag_engine_right2");
	playfxontag(level.var_8B59,self,"tag_engine_right2");
	playfxontag(level.var_3F19["damage"]["heavy_smoke"],self,"tag_engine_left");
}

//Function Number: 44
func_A3BD()
{
	self endon("jackal_gone");
	var_00 = self.var_222;
	self waittill("death");
	if(isdefined(self.var_12A95) && isdefined(self.var_11576))
	{
		scripts\mp\_utility::func_C78F(self.var_11576,self.var_12A95);
	}

	if(!isdefined(self))
	{
		return;
	}

	self.var_222 scripts\mp\_utility::clearlowermessage(func_8026(self.var_BC));
	if(!isdefined(self.var_A859))
	{
		self method_83E5(25,5);
		thread func_A3B8(75);
		scripts\mp\_hostmigration::func_13708(2.7);
	}

	func_A3BF();
}

//Function Number: 45
func_A3BF()
{
	self playsound("dropship_explode_mp");
	level.var_A412[level.var_A412.size - 1] = undefined;
	self notify("explode");
	playfxontag(scripts\common\utility::getfx("jackal_explosion"),self,"j_body");
	wait(0.35);
	thread func_A3BC();
}

//Function Number: 46
func_A3B8(param_00)
{
	self endon("explode");
	self method_8076();
	self notify("jackal_crashing");
	self method_8362(self.origin + (0,0,100),1);
	self setscriptablepartstate("engine","explode",0);
	scripts\mp\_hostmigration::func_13708(1.5);
	self method_8378(param_00,param_00,param_00);
	self method_8348(self.angles[1] + param_00 * 2.5);
}

//Function Number: 47
func_11A8A(param_00,param_01,param_02)
{
	self endon("death");
	self endon("acquiringTarget");
	self endon("leaving");
	self endon("randMove");
	var_03 = scripts\common\trace::func_109DD(self.origin,(param_00,param_01,param_02),256,self,undefined,1);
	if(var_03["surfacetype"] != "surftype_none")
	{
		return 0;
	}

	var_04 = (param_00,param_01,param_02);
	return var_04;
}

//Function Number: 48
func_11A87(param_00,param_01)
{
	self endon("death");
	self endon("acquiringTarget");
	self endon("leaving");
	var_02 = -99999;
	var_03 = self.origin[2] + 2000;
	var_04 = level.var_26A6;
	var_05 = [self];
	if(isdefined(self.dropcrates))
	{
		foreach(var_07 in self.dropcrates)
		{
			var_05[var_05.size] = var_07;
		}
	}

	var_09 = scripts\common\trace::func_109DD((param_00,param_01,var_03),(param_00,param_01,var_02),256,var_05,undefined,1);
	if(var_09["position"][2] < var_04)
	{
		var_0A = var_04;
	}
	else
	{
		var_0A = var_0A["position"][2];
	}

	return var_0A;
}

//Function Number: 49
func_42AB(param_00)
{
	self endon("goal");
	self endon("death");
	for(;;)
	{
		if(distance2d(self.origin,param_00) < 768)
		{
			self method_830A(10,25);
			break;
		}

		wait(0.05);
	}
}

//Function Number: 50
func_B9FF()
{
	self endon("death");
	self endon("leaving");
	if(!isdefined(self.var_222) || self.var_222.team != self.team)
	{
		thread func_A3BF();
		return;
	}

	self.var_222 scripts\common\utility::waittill_any_3("joined_team","disconnect");
	func_A3BF();
}

//Function Number: 51
func_13AD6(param_00,param_01)
{
	self.var_222 endon("disconnect");
	self endon("death");
	self endon("leaving");
	level endon("game_ended");
	for(;;)
	{
		self.var_130AC waittill("trigger",var_02);
		if(var_02 != self.var_222)
		{
			continue;
		}

		if(self.var_222 scripts\mp\_utility::func_9FC6())
		{
			continue;
		}

		if(isdefined(self.var_222.var_55E4) && self.var_222.var_55E4 > 0)
		{
			continue;
		}

		if(scripts\mp\_utility::func_9FAE(self.var_222))
		{
			continue;
		}

		var_03 = 0;
		while(self.var_222 usebuttonpressed())
		{
			var_03 = var_03 + 0.05;
			if(var_03 > 0.1)
			{
				var_04 = func_8026(self.var_BC);
				if(var_04 == "guard_location")
				{
					var_05 = self.var_222.origin[0];
					var_06 = self.var_222.origin[1];
					var_07 = self.origin[2];
					var_08 = (var_05,var_06,var_07);
					var_09 = scripts\common\trace::func_48BC(0,1,1,1,1,1,0);
					if(!scripts\common\trace::func_DCF1(self.origin,var_08,self,var_09))
					{
						self.var_222 scripts\mp\_hud_message::func_10122("KILLSTREAKS_CANNOT_BE_CALLED");
						break;
					}
				}

				self.var_BC = var_04;
				self notify(self.var_BC);
				if(self.var_BC == "guard_location")
				{
					param_00 = "follow_player";
					param_01 = &"KILLSTREAKS_HINTS_JACKAL_FOLLOW";
					self.var_222 scripts\mp\_utility::func_C638("jackal_guard");
					self.var_222 playlocalsound("mp_killstreak_warden_switch_mode");
					thread func_5D8F();
					thread guardposition(self.var_222.origin);
				}
				else
				{
					param_00 = "guard_location";
					param_01 = &"KILLSTREAKS_HINTS_JACKAL_GUARD";
					self.var_222 playlocalsound("mp_killstreak_warden_switch_mode");
					thread patrolfield();
					thread func_5D8F();
				}

				self.var_130AC makeunusable();
				scripts\mp\_hostmigration::func_13708(1);
				self.var_4C08 = param_01;
				self.var_130AC scripts\mp\killstreaks\_utility::func_F774(self.var_222,self.var_4C08,360,360,30000,30000,2);
				break;
			}

			wait(0.05);
		}

		wait(0.05);
	}
}

//Function Number: 52
func_5D8F()
{
	scripts\mp\_hostmigration::func_13708(0.3);
	self playsoundonmovingent("dropship_killstreak_thrust_change");
}

//Function Number: 53
func_8026(param_00)
{
	if(param_00 == "follow_player")
	{
		param_00 = "guard_location";
	}
	else
	{
		param_00 = "follow_player";
	}

	return param_00;
}

//Function Number: 54
func_B06C(param_00,param_01)
{
	level endon("game_ended");
	for(;;)
	{
		triggerfx(param_00);
		wait(0.05);
		if(!isdefined(param_01) || !isdefined(param_00))
		{
			break;
		}
	}

	if(isdefined(param_00))
	{
		param_00 delete();
	}
}

//Function Number: 55
func_2526(param_00,param_01)
{
	var_02 = undefined;
	var_03 = undefined;
	var_04 = 6000;
	var_05 = (0,0,var_04);
	var_06 = 3000;
	var_07 = anglestoforward(self.angles);
	var_08 = self.origin;
	var_09 = var_08 + var_05 + var_07 * var_06 * -1;
	var_0A = [self];
	var_0B = 0;
	var_0C = scripts\common\trace::func_DCED(param_00 + (0,0,var_04),param_00);
	if(var_0C["fraction"] > 0.99)
	{
		var_0B = 1;
		var_09 = param_00 + (0,0,var_04);
	}

	if(!var_0B)
	{
		var_0C = scripts\common\trace::func_DCED(param_00 + (300,0,var_04),param_00);
		if(var_0C["fraction"] > 0.99)
		{
			var_0B = 1;
			var_09 = param_00 + (300,0,var_04);
		}
	}

	if(!var_0B)
	{
		var_0C = scripts\common\trace::func_DCED(param_00 + (0,300,var_04),param_00);
		if(var_0C["fraction"] > 0.99)
		{
			var_0B = 1;
			var_09 = param_00 + (0,300,var_04);
		}
	}

	if(!var_0B)
	{
		var_0C = scripts\common\trace::func_DCED(param_00 + (0,-300,var_04),param_00);
		if(var_0C["fraction"] > 0.99)
		{
			var_0B = 1;
			var_09 = param_00 + (0,-300,var_04);
		}
	}

	if(!var_0B)
	{
		var_0C = scripts\common\trace::func_DCED(param_00 + (300,300,var_04),param_00);
		if(var_0C["fraction"] > 0.99)
		{
			var_0B = 1;
			var_09 = param_00 + (300,300,var_04);
		}
	}

	if(!var_0B)
	{
		var_0C = scripts\common\trace::func_DCED(param_00 + (-300,0,var_04),param_00);
		if(var_0C["fraction"] > 0.99)
		{
			var_0B = 1;
			var_09 = param_00 + (-300,0,var_04);
		}
	}

	if(!var_0B)
	{
		var_0C = scripts\common\trace::func_DCED(param_00 + (-300,-300,var_04),param_00);
		if(var_0C["fraction"] > 0.99)
		{
			var_0B = 1;
			var_09 = param_00 + (-300,-300,var_04);
		}
	}

	if(!var_0B)
	{
		var_0C = scripts\common\trace::func_DCED(param_00 + (300,-300,var_04),param_00);
		if(var_0C["fraction"] > 0.99)
		{
			var_0B = 1;
			var_09 = param_00 + (300,-300,var_04);
		}
	}

	if(!var_0B)
	{
		for(var_0D = 0;var_0D < 5;var_0D++)
		{
			var_04 = var_04 / 2;
			var_05 = (0,0,var_04);
			var_09 = var_08 + var_05 + var_07 * var_06 * -1;
			var_0E = scripts\common\trace::func_DCED(param_00,var_09,var_0A);
			if(var_0E["fraction"] > 0.99)
			{
				var_0B = 1;
				break;
			}

			wait(0.05);
		}
	}

	if(!var_0B)
	{
		for(var_0D = 0;var_0D < 5;var_0D++)
		{
			var_04 = var_04 * 2.5;
			var_05 = (0,0,var_04);
			var_09 = var_08 + var_05 + var_07 * var_06 * -1;
			var_0E = scripts\common\trace::func_DCED(param_00,var_09,var_0A);
			if(var_0E["fraction"] > 0.99)
			{
				var_0B = 1;
				break;
			}

			wait(0.05);
		}
	}
}

//Function Number: 56
func_D4C1()
{
	if(isdefined(self.var_D4AD) && self.var_D4AD)
	{
		return;
	}

	scripts\common\utility::play_loopsound_in_space("javelin_clu_lock",self.origin);
	self.var_D4AD = 1;
	scripts\mp\_hostmigration::func_13708(0.75);
	self stoploopsound("javelin_clu_lock");
	self.var_D4AD = 0;
}

//Function Number: 57
func_D4C0()
{
	if(isdefined(self.var_D4AD) && self.var_D4AD)
	{
		return;
	}

	self playlocalsound("javelin_clu_aquiring_lock");
	self.var_D4AD = 1;
	scripts\mp\_hostmigration::func_13708(0.75);
	self stoplocalsound("javelin_clu_aquiring_lock");
	self.var_D4AD = 0;
}

//Function Number: 58
func_2A65()
{
	self endon("death");
	self notify("begin_evasive_maneuvers");
	self endon("begin_evasive_maneuvers");
	self.var_67E3 = 1;
	var_00 = scripts\common\utility::waittill_any_timeout_1(3,"death");
	if(var_00 == "timeout")
	{
		self.var_67E3 = 0;
	}
}

//Function Number: 59
func_13A9C()
{
	self endon("death");
	self endon("leaving");
	self endon("following_player");
	for(;;)
	{
		var_00 = undefined;
		if(scripts\mp\_utility::func_9FB3(self.var_67E3))
		{
			var_01 = self.var_222.origin[0];
			var_02 = self.var_222.origin[1];
			var_03 = var_01 + randomintrange(-500,500);
			var_04 = var_02 + randomintrange(-500,500);
			var_05 = func_7E3E(var_03,var_04,350);
			var_00 = (var_03,var_04,var_05);
		}

		if(isdefined(var_00))
		{
			self method_8362(var_00,1);
		}

		scripts\mp\_hostmigration::func_13708(0.1);
	}
}

//Function Number: 60
watchdropcratesearly(param_00)
{
	self endon("dropped_crates");
	var_01 = self.dropcrates;
	self waittill("death");
	thread dropcrates(var_01,param_00);
}

//Function Number: 61
dropcrates(param_00,param_01)
{
	var_02 = (0,0,0);
	var_03 = 1200;
	foreach(var_06, var_05 in param_00)
	{
		var_05 unlink();
		var_05 physicslaunchserver((0,0,0),var_02,var_03);
		var_05 thread scripts\mp\killstreaks\_airdrop::func_CB14(var_05.var_5EF1,var_05.var_485F,var_02,var_03);
		var_05 thread scripts\mp\killstreaks\_airdrop::func_A66E();
		var_05.var_12BE7 = ::scripts\mp\killstreaks\_airdrop::func_A66D;
		var_05 thread scripts\mp\killstreaks\_airdrop::handlenavobstacle();
		var_05 thread watchforcapture(self,var_06);
		wait(0.1);
	}

	if(isdefined(param_01.var_1349C))
	{
		param_01.var_1349C delete();
	}

	self notify("dropped_crates");
}

//Function Number: 62
watchforcapture(param_00,param_01)
{
	scripts\common\utility::waittill_any_3("captured","death");
	param_00 notify("crate_captured_" + param_01);
}

//Function Number: 63
watchjackalcratepickup()
{
	self endon("death");
	self endon("leaving");
	var_00 = 0;
	for(;;)
	{
		scripts\common\utility::waittill_any_3("crate_captured_0","crate_captured_1","crate_captured_2");
		var_00++;
		if(var_00 == self.dropcrates.size)
		{
			self notify("all_crates_gone");
			break;
		}
	}
}