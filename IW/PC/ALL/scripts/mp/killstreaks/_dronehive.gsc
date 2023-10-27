/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\killstreaks\_dronehive.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 30
 * Decompile Time: 1409 ms
 * Timestamp: 10/27/2023 12:28:27 AM
*******************************************************************/

//Function Number: 1
init()
{
	scripts\mp\killstreaks\_killstreaks::func_DEFB("drone_hive",::func_128E3,undefined,undefined,undefined,::func_13C8C);
	level.var_5CB9 = getentarray("remoteMissileSpawn","targetname");
	foreach(var_01 in level.var_5CB9)
	{
		var_01.var_1155F = getent(var_01.target,"targetname");
	}

	var_03 = ["passive_predator","passive_no_missiles","passive_implosion","passive_rapid_missiles"];
	scripts\mp\_killstreak_loot::func_DF07("drone_hive",var_03);
}

//Function Number: 2
func_13C8C(param_00)
{
	self setclientomnvar("ui_remote_control_sequence",1);
}

//Function Number: 3
func_128E3(param_00)
{
	return func_1307F(self,param_00.var_AC68,param_00);
}

//Function Number: 4
func_1307F(param_00,param_01,param_02)
{
	if(isdefined(self.var_12B90) && self.var_12B90)
	{
		return 0;
	}

	var_03 = scripts\mp\killstreaks\_killstreaks::func_D507(param_02);
	if(!var_03)
	{
		return 0;
	}

	param_00 scripts\common\utility::func_1C76(0);
	level thread func_B9CB(param_00);
	level thread func_B9DD(param_00);
	level thread func_B9FD(param_00);
	level thread func_E846(param_00,param_01,param_02.var_110EA,param_02);
	return 1;
}

//Function Number: 5
func_13AA4(param_00)
{
	param_00 endon("killstreak_disowned");
	param_00 endon("disconnect");
	level endon("game_ended");
	self endon("death");
	for(;;)
	{
		level waittill("host_migration_begin");
		if(isdefined(self))
		{
			param_00 thermalvisionon();
			param_00 thermalvisionfofoverlayon();
			continue;
		}

		param_00 setclientomnvar("ui_predator_missile",2);
	}
}

//Function Number: 6
func_13AA2(param_00)
{
	param_00 endon("killstreak_disowned");
	param_00 endon("disconnect");
	level endon("game_ended");
	self endon("death");
	for(;;)
	{
		level waittill("host_migration_end");
		if(isdefined(self))
		{
			param_00 setclientomnvar("ui_predator_missile",1);
			param_00 setclientomnvar("ui_predator_missiles_left",self.var_B8AF);
			continue;
		}

		param_00 setclientomnvar("ui_predator_missile",2);
	}
}

//Function Number: 7
watchclosetogoal(param_00)
{
	param_00 endon("killstreak_disowned");
	param_00 endon("disconnect");
	level endon("game_ended");
	var_01 = scripts\common\trace::func_48BC(1,1,1,1,1,1,1);
	while(isdefined(self))
	{
		var_02 = scripts\common\trace::func_DCED(self.origin,self.origin - (0,0,1000),level.var_3CB5,var_01);
		if(isdefined(var_02["position"]) && distancesquared(self.origin,var_02["position"]) < 5000)
		{
			break;
		}

		scripts\common\utility::func_136F7();
	}

	param_00 thread scripts\mp\killstreaks\_killstreaks::func_11086();
}

//Function Number: 8
func_E846(param_00,param_01,param_02,param_03)
{
	param_00 endon("killstreak_disowned");
	level endon("game_ended");
	var_04 = "used_drone_hive";
	var_05 = "drone_hive_projectile_mp";
	var_06 = "switch_blade_child_mp";
	var_07 = scripts\mp\_killstreak_loot::getrarityforlootitem(param_03.var_1318B);
	if(var_07 != "")
	{
		var_04 = var_04 + "_" + var_07;
	}

	if(scripts\mp\killstreaks\_utility::func_A69F(param_03,"passive_implosion"))
	{
		var_05 = "drone_hive_impulse_mp";
		var_06 = "switch_blade_impulse_mp";
	}

	level thread scripts\mp\_utility::func_115DE(var_04,param_00);
	param_00 notifyonplayercommand("missileTargetSet","+attack");
	param_00 notifyonplayercommand("missileTargetSet","+attack_akimbo_accessible");
	var_08 = func_7DFE(param_00,level.var_5CB9);
	var_09 = var_08.origin * (1,1,0) + (0,0,level.var_B32E[2] + 10000);
	var_0A = var_08.var_1155F.origin;
	var_0B = scripts\mp\_utility::func_1309(var_05,var_09,var_0A,param_00);
	var_0B setcandamage(1);
	var_0B method_80A2();
	var_0B method_830B(1);
	var_0B.team = param_00.team;
	var_0B.var_AC68 = param_01;
	var_0B.type = "remote";
	var_0B.var_222 = param_00;
	var_0B.var_6649 = var_0B getentitynumber();
	var_0B.var_110E8 = param_03;
	var_0B.var_13C2E = "drone_hive_projectile_mp";
	var_0B thread watchmissileextraeffect(param_03,1);
	level.var_E5DE[var_0B.var_6649] = var_0B;
	level.var_DF80 = 1;
	level thread func_B9C8(var_0B,1);
	level thread func_B9C1(var_0B);
	if(isdefined(param_00.var_A685))
	{
		param_00.var_A685["drone_hive_projectile_mp"] = 0;
		param_00.var_A685["switch_blade_child_mp"] = 0;
	}

	func_B889(param_00,var_0B);
	param_00 setclientomnvar("ui_predator_missile",1);
	var_0B thread func_13AA4(param_00);
	var_0B thread func_13AA2(param_00);
	var_0B thread scripts\mp\killstreaks\_utility::watchsupertrophynotify(param_00);
	param_00 scripts\mp\_matchdata::func_AFC9(param_02,var_0B.origin);
	var_0C = 0;
	var_0B.var_B8AF = 2;
	if(scripts\mp\killstreaks\_utility::func_A69F(param_03,"passive_predator"))
	{
		var_0B.var_B8AF = -1;
		var_0B.singlefire = 1;
		var_0B method_80D3();
	}

	if(scripts\mp\killstreaks\_utility::func_A69F(param_03,"passive_rapid_missiles"))
	{
		var_0B.var_12BA7 = 1;
	}

	var_0D = 2;
	param_00 setclientomnvar("ui_predator_missiles_left",var_0B.var_B8AF);
	for(;;)
	{
		var_0E = var_0B scripts\common\utility::func_13734("death","missileTargetSet");
		scripts\mp\_hostmigration::func_13834();
		if(var_0E == "death")
		{
			break;
		}

		if(!isdefined(var_0B))
		{
			break;
		}

		if(scripts\mp\_utility::func_9FB3(var_0B.var_12BA7))
		{
			if(scripts\mp\_utility::func_9FB3(var_0B.lasttimefired))
			{
				if(gettime() < var_0B.lasttimefired + var_0D * 1000 && var_0C == 0)
				{
					continue;
				}
			}

			level thread firerapidmissiles(var_0B,var_0C,param_03,var_06);
			var_0C++;
			var_0B.lasttimefired = gettime();
			var_0B.var_B8AF = 2 - var_0C;
			var_0F = var_0B.var_B8AF;
			if(var_0B.var_B8AF == 0)
			{
				var_0F = -1;
			}

			param_00 setclientomnvar("ui_predator_missiles_left",var_0F);
			if(var_0C == 2)
			{
				var_0C = 0;
				var_0B.var_B8AF = 2;
				param_00 thread resetmissiles(var_0B,var_0D);
			}

			continue;
		}

		if(var_0C < 2)
		{
			if(!scripts\mp\_utility::func_9FB3(var_0B.singlefire))
			{
				level thread func_10914(var_0B,var_0C,param_03,var_06);
				var_0C++;
				var_0B.var_B8AF = 2 - var_0C;
				param_00 setclientomnvar("ui_predator_missiles_left",var_0B.var_B8AF);
				if(var_0C == 2)
				{
					var_0B method_80D3();
				}
			}
		}
	}

	level thread func_E474(param_00);
	scripts\mp\_utility::func_D915("killstreak ended - drone_hive",param_00);
}

//Function Number: 9
firerapidmissiles(param_00,param_01,param_02,param_03)
{
	var_04 = param_01;
	for(var_05 = 0;var_05 < 2;var_05++)
	{
		level thread func_10914(param_00,var_04,param_02,param_03);
		var_04++;
		if(var_04 > 1)
		{
			var_04 = 0;
		}

		wait(0.1);
	}
}

//Function Number: 10
resetmissiles(param_00,param_01)
{
	param_00 endon("death");
	self endon("disconnect");
	wait(param_01);
	self setclientomnvar("ui_predator_missiles_left",param_00.var_B8AF);
}

//Function Number: 11
func_B9EE()
{
	level endon("game_ended");
	self endon("death");
	var_00 = [];
	var_01 = [];
	for(;;)
	{
		var_02 = [];
		var_00 = scripts\mp\killstreaks\_utility::func_7E92();
		foreach(var_04 in var_00)
		{
			var_05 = self.var_222 method_8409(var_04.origin,65,90);
			if(var_05)
			{
				self.var_222 thread scripts\mp\_utility::drawline(self.origin,var_04.origin,10,(0,0,1));
				var_02[var_02.size] = var_04;
			}
		}

		if(var_02.size)
		{
			var_01 = sortbydistance(var_02,self.origin);
			self.var_AA25 = var_01[0];
			scripts\mp\_hostmigration::func_13708(0.25);
		}

		wait(0.05);
		scripts\mp\_hostmigration::func_13834();
	}
}

//Function Number: 12
func_10914(param_00,param_01,param_02,param_03)
{
	param_00.var_222 playlocalsound("ammo_crate_use");
	var_04 = param_00 gettagangles("tag_origin");
	var_05 = anglestoforward(var_04);
	var_06 = anglestoright(var_04);
	var_07 = (100,100,100);
	var_08 = (15000,15000,15000);
	if(param_01)
	{
		var_07 = var_07 * -1;
	}

	var_09 = bullettrace(param_00.origin,param_00.origin + var_05 * var_08,0,param_00);
	var_08 = var_08 * var_09["fraction"];
	var_0A = param_00.origin + var_06 * var_07;
	var_0B = param_00.origin + var_05 * var_08;
	var_0C = scripts\mp\_utility::func_1309(param_03,var_0A,var_0B,param_00.var_222);
	var_0D = param_00 getclosesttargetinview(param_00.var_222,var_0B);
	if(isdefined(var_0D) && !scripts\mp\killstreaks\_utility::func_A69F(param_02,"passive_rapid_missiles"))
	{
		var_0C missile_settargetent(var_0D);
	}

	var_0C setcandamage(1);
	var_0C method_830B(1);
	var_0C.team = param_00.team;
	var_0C.var_AC68 = param_00.var_AC68;
	var_0C.type = param_00.type;
	var_0C.var_222 = param_00.var_222;
	var_0C.var_6649 = var_0C getentitynumber();
	var_0C.var_110E8 = param_02;
	var_0C.var_13C2E = "switch_blade_child_mp";
	var_0C thread watchmissileextraeffect(param_02,0);
	level.var_E5DE[var_0C.var_6649] = var_0C;
	level thread func_B9C8(var_0C,0);
}

//Function Number: 13
getclosesttargetinview(param_00,param_01)
{
	var_02 = scripts\mp\killstreaks\_utility::func_7E92(param_00);
	var_03 = undefined;
	var_04 = undefined;
	foreach(var_06 in var_02)
	{
		if(!scripts\mp\killstreaks\_utility::manualmissilecantracktarget(var_06))
		{
			continue;
		}

		if(scripts\mp\_utility::func_9FB3(var_06.trinityrocketlocked))
		{
			continue;
		}

		var_07 = distance2dsquared(var_06.origin,param_01);
		if(var_07 < 262144 && scripts\mp\_utility::func_9FB3(func_390B(var_06)))
		{
			if(!isdefined(var_04) || var_07 < var_04)
			{
				var_03 = var_06;
				var_04 = var_07;
			}
		}
	}

	if(isdefined(var_03))
	{
		var_03.trinityrocketlocked = 1;
		var_03 thread watchtarget(self);
	}

	return var_03;
}

//Function Number: 14
func_390B(param_00)
{
	var_01 = 0;
	var_02 = scripts\common\trace::func_48BC(0,1,1,1,1,1,0);
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
watchtarget(param_00)
{
	self endon("disconnect");
	for(;;)
	{
		if(!scripts\mp\killstreaks\_utility::manualmissilecantracktarget(self))
		{
			break;
		}

		if(!isdefined(param_00))
		{
			break;
		}

		scripts\common\utility::func_136F7();
	}

	self.trinityrocketlocked = undefined;
	if(isdefined(param_00))
	{
		param_00 missile_cleartarget();
	}
}

//Function Number: 16
func_B06C(param_00,param_01)
{
	param_01 endon("death");
	level endon("game_ended");
	self endon("death");
	for(;;)
	{
		triggerfx(param_00);
		wait(0.25);
	}
}

//Function Number: 17
func_7FE7(param_00)
{
	var_01 = param_00 + 1;
	if(var_01 == level.var_5CB9.size)
	{
		var_01 = 0;
	}

	return var_01;
}

//Function Number: 18
func_B9C1(param_00)
{
	param_00 endon("death");
	for(;;)
	{
		param_00.var_222 waittill("missileTargetSet");
		param_00 notify("missileTargetSet");
	}
}

//Function Number: 19
func_7DFE(param_00,param_01)
{
	var_02 = [];
	foreach(var_04 in level.players)
	{
		if(!scripts\mp\_utility::func_9F19(var_04))
		{
			continue;
		}

		if(var_04.team == param_00.team)
		{
			continue;
		}

		if(var_04.team == "spectator")
		{
			continue;
		}

		var_02[var_02.size] = var_04;
	}

	if(!var_02.size)
	{
		return param_01[randomint(param_01.size)];
	}

	var_06 = scripts\common\utility::array_randomize(param_01);
	var_07 = var_06[0];
	foreach(var_09 in var_06)
	{
		var_09.var_101E4 = 0;
		for(var_0A = 0;var_0A < var_02.size;var_0A++)
		{
			var_0B = var_02[var_0A];
			if(!scripts\mp\_utility::func_9F19(var_0B))
			{
				var_02[var_0A] = var_02[var_02.size - 1];
				var_02[var_02.size - 1] = undefined;
				var_0A--;
				continue;
			}

			if(bullettracepassed(var_0B.origin + (0,0,32),var_09.origin,0,var_0B))
			{
				var_09.var_101E4 = var_09.var_101E4 + 1;
				return var_09;
			}

			wait(0.05);
			scripts\mp\_hostmigration::func_13834();
		}

		if(var_09.var_101E4 == var_02.size)
		{
			return var_09;
		}

		if(var_09.var_101E4 > var_07.var_101E4)
		{
			var_07 = var_09;
		}
	}

	return var_07;
}

//Function Number: 20
func_B889(param_00,param_01)
{
	var_02 = 0.5;
	param_00 scripts\mp\_utility::func_7385(1);
	param_00 cameralinkto(param_01,"tag_origin");
	param_00 controlslinkto(param_01);
	param_00 thermalvisionon();
	param_00 thermalvisionfofoverlayon();
	param_00 playlocalsound("trinity_rocket_plr");
	param_00 setclientomnvar("ui_killstreak_health",1);
	param_00 setclientomnvar("ui_killstreak_countdown",gettime() + int(15000));
	level thread func_12B9B(param_00,var_02);
}

//Function Number: 21
func_12B9B(param_00,param_01,param_02)
{
	param_00 endon("disconnect");
	scripts\mp\_hostmigration::func_13708(param_01 - 0.35);
	param_00 scripts\mp\_utility::func_7385(0);
}

//Function Number: 22
func_B9CB(param_00)
{
	param_00 endon("disconnect");
	param_00 endon("end_kill_streak");
	param_00 waittill("killstreak_disowned");
	level thread func_E474(param_00);
}

//Function Number: 23
func_B9DD(param_00)
{
	param_00 endon("disconnect");
	param_00 endon("end_kill_streak");
	level waittill("game_ended");
	var_01 = 1;
	level thread func_E474(param_00,0,var_01);
}

//Function Number: 24
func_B9FD(param_00)
{
	param_00 endon("end_kill_streak");
	param_00 endon("disconnect");
	level waittill("objective_cam");
	level thread func_E474(param_00,1);
}

//Function Number: 25
func_B9C8(param_00,param_01)
{
	var_02 = param_00.var_222;
	param_00 waittill("death");
	scripts\mp\_hostmigration::func_13834();
	if(isdefined(param_00.var_114F1))
	{
		param_00.var_114F1 delete();
	}

	if(isdefined(param_00.var_6649))
	{
		level.var_E5DE[param_00.var_6649] = undefined;
	}

	if(param_01)
	{
		level.var_DF80 = undefined;
	}

	if(isdefined(var_02) && !scripts\mp\_utility::func_9F19(var_02) && scripts\mp\_utility::func_9FB3(param_01))
	{
		var_02 thread stopmissilesoundonspawn();
	}
}

//Function Number: 26
stopmissilesoundonspawn()
{
	self endon("disconnect");
	self waittill("spawned_player");
	self stoplocalsound("trinity_rocket_plr");
	self stoplocalsound("trinity_rocket_plr_lsrs");
	self stoplocalsound("trinity_rocket_plr_lfe");
}

//Function Number: 27
func_E474(param_00,param_01,param_02)
{
	if(!isdefined(param_00))
	{
		return;
	}

	param_00 playlocalsound("trinity_rocket_exp_plr");
	if(!scripts\mp\_utility::func_9FB3(param_02))
	{
		param_00 thread scripts\mp\killstreaks\_killstreaks::func_11086();
	}

	param_00 setclientomnvar("ui_predator_missile",2);
	param_00 notify("end_kill_streak");
	param_00 stoplocalsound("trinity_rocket_plr");
	param_00 stoplocalsound("trinity_rocket_plr_lsrs");
	param_00 stoplocalsound("trinity_rocket_plr_lfe");
	param_00 thermalvisionoff();
	param_00 thermalvisionfofoverlayoff();
	param_00 controlsunlink();
	param_00 cameraunlink();
	param_00 setclientomnvar("ui_predator_missile",0);
	param_00 scripts\common\utility::func_1C76(1);
}

//Function Number: 28
watchmissileextraeffect(param_00,param_01)
{
	level endon("game_ended");
	var_02 = scripts\mp\killstreaks\_utility::func_A69F(param_00,"passive_predator");
	var_03 = scripts\mp\killstreaks\_utility::func_A69F(param_00,"passive_implosion");
	if(!var_02 && !var_03)
	{
		return;
	}

	if(var_02 && !scripts\mp\_utility::func_9FB3(param_01))
	{
		return;
	}

	var_04 = self.var_222;
	var_05 = self.var_13C2E;
	var_06 = scripts\common\utility::spawn_tag_origin();
	var_06 linkto(self);
	var_04.extraeffectkillcam = var_06;
	self.explosiontarget = spawn("script_model",self.origin);
	self.explosiontarget setmodel("ks_drone_hive_target_mp");
	self.explosiontarget method_82DD(var_04);
	self.explosiontarget method_831F(var_04);
	self.explosiontarget linkto(self,"tag_origin");
	self.explosiontarget.var_13C2E = var_05;
	self.explosiontarget.var_110E8 = param_00;
	var_07 = self.explosiontarget;
	self waittill("death");
	if(!isdefined(var_07))
	{
		return;
	}

	if(var_02)
	{
		wait(0.27);
		var_07 setscriptablepartstate("chain_explode_1","active",0);
		wait(0.27);
		var_07 setscriptablepartstate("chain_explode_2","active",0);
		wait(1);
	}
	else if(var_03)
	{
		var_07 setscriptablepartstate("impulse_explode","active",0);
		wait(0.5);
		var_08 = function_02AF(var_04,"drone_hive_implosion_mp",var_07.origin);
		wait(0.1);
		var_08 delete();
		var_07 radiusdamage(var_07.origin,325,1000,1000,var_04,"MOD_EXPLOSIVE",var_05);
		scripts\mp\_shellshock::func_858B(var_07.origin);
		physicsexplosionsphere(var_07.origin,300,0,200);
		wait(1);
	}

	if(isdefined(var_07))
	{
		var_07 delete();
	}

	if(isdefined(var_06))
	{
		var_06 delete();
	}
}

//Function Number: 29
watchgastrigger(param_00,param_01)
{
	self endon("death");
	for(;;)
	{
		self waittill("trigger",var_02);
		if(!isplayer(var_02))
		{
			continue;
		}

		if(level.teambased && var_02.team == param_00.team && var_02 != param_00)
		{
			continue;
		}

		if(scripts\mp\_utility::func_9FB3(var_02.gettinggassed))
		{
			continue;
		}

		thread applygasdamageovertime(param_00,param_01,var_02);
	}
}

//Function Number: 30
applygasdamageovertime(param_00,param_01,param_02)
{
	param_02 endon("disconnect");
	param_02.gettinggassed = 1;
	while(param_02 istouching(self))
	{
		param_02 dodamage(20,self.origin,param_00,self,"MOD_EXPLOSIVE",param_01);
		var_03 = scripts\common\utility::waittill_any_timeout_1(0.5,"death");
		if(var_03 == "death")
		{
			break;
		}
	}

	if(scripts\mp\_utility::func_9FB3(param_02.gettinggassed))
	{
		param_02.gettinggassed = undefined;
	}
}