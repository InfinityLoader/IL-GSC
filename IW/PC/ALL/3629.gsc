/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3629.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 73
 * Decompile Time: 37 ms
 * Timestamp: 10/27/2023 12:30:58 AM
*******************************************************************/

//Function Number: 1
func_112B5()
{
	precachemodel("veh_mil_air_un_pocketdrone");
	precachemodel("veh_mil_air_un_pocketdrone_dyn");
	precachemodel("veh_mil_air_un_pocketdrone_shotdown_flight_body_dangle");
	precachemodel("veh_mil_air_un_pocketdrone_shotdown_crash_body_dangle");
	precachemodel("veh_mil_air_un_pocketdrone_timeout_crash_body_4fan");
	precacheitem("supportdrone_trophy_turret");
	precacheitem("supportdrone");
	precacheitem("supportdrone_up2");
	precacheshader("hud_icon_wireless");
	precacheshader("overlay_static");
	precacheshader("icon_ability_drone");
	precacheshader("cb_remotemissile_target_hostile");
	setdvarifuninitialized("support_drone_debug",0);
	setdvarifuninitialized("scan_ability",1);
	level._effect["drone_thruster"] = loadfx("vfx/iw7/core/equipment/drone/vfx_drone_down_thrust_child.vfx");
	level._effect["drone_damaged_loop"] = loadfx("vfx/iw7/core/equipment/drone/vfx_drone_damage_malfunction_loop.vfx");
	level._effect["drone_trophy_laser"] = loadfx("vfx/iw7/core/equipment/drone/vfx_drone_muzzle_flash_trophy_r.vfx");
	level._effect["drone_trophy_pop"] = loadfx("vfx/iw7/core/equipment/drone/vfx_drone_trophy_pop.vfx");
	level._effect["drone_shotdown_air_damage"] = loadfx("vfx/iw7/core/equipment/drone/vfx_drone_death_shotdown.vfx");
	level._effect["drone_death_hit_ground"] = loadfx("vfx/iw7/core/equipment/drone/vfx_drone_death.vfx");
	level.player scripts\sp\_utility::func_65E0("player_support_drone_active");
	level.player scripts\sp\_utility::func_65E0("support_drone_spawning");
	level.var_5C19 = [91,83,108,72];
	level.var_5C18 = 0;
	level.player.var_5CA6 = [];
	level.player.var_5C6E = 0;
	level.player.var_5C4F = 0;
	level.player.var_4C29 = [];
	level.player thread func_5BE1();
	scripts\sp\_utility::func_9189("default_supdrone",2,"default");
}

//Function Number: 2
func_5138()
{
	scripts\sp\_utility::func_228A(level.player.var_5CA6);
	level.player.var_5CA6 = scripts\common\utility::func_22BC(level.player.var_5CA6);
}

//Function Number: 3
func_5C9E()
{
	self endon("death");
	self endon("support_drone_think");
	var_00 = func_129A();
	for(;;)
	{
		self waittill("secondary_equipment_change");
		waittillframeend;
		if(!isdefined(scripts\sp\_utility::func_7C3D()) || scripts\sp\_utility::func_7C3D() != var_00)
		{
			break;
		}
	}

	scripts\common\utility::func_6E2A("secondary_equipment_in_use");
	self notify("drone_unequipped");
}

//Function Number: 4
func_112BB()
{
	self endon("death");
	self endon("drone_unequipped");
	self notify("support_drone_think");
	self endon("support_drone_think");
	thread func_5C9E();
	var_00 = func_112B8();
	for(;;)
	{
		level.var_112B9 = 0;
		for(;;)
		{
			self waittill("grenade_fire",var_01,var_02);
			if(var_02 == "supportdrone" || var_02 == "supportdrone_up2")
			{
				break;
			}
		}

		if(!func_385A())
		{
			wait(0.05);
			continue;
		}

		level.player scripts\sp\_utility::func_65E8("support_drone_spawning");
		level.player scripts\sp\_utility::func_65E1("support_drone_spawning");
		scripts\common\utility::flag_set("secondary_equipment_in_use");
		level.player scripts\common\utility::func_1C6E(0);
		level.player scripts\sp\_utility::func_65E1("player_support_drone_active");
		if(!getdvarint("player_sustainAmmo",0))
		{
			var_03 = self method_80FB(func_129A());
			self setweaponammoclip(func_129A(),var_03 - 1);
		}

		self notify("offhand_fired");
		var_04 = func_112BA(var_00);
		var_04.var_D384 = func_7B15();
		var_04.var_9180 = var_04.var_D384;
		self.var_4C29[var_04.var_D384] = spawnstruct();
		self.var_4C29[var_04.var_D384].var_5BD7 = var_04;
		self.var_4C29[var_04.var_D384].var_51BA = 0;
		self.var_4C29[var_04.var_D384].var_9A96 = 1;
		self.var_4C29[var_04.var_D384].var_C7B4 = 0;
		func_F377(var_04.var_9180,"active");
		func_5C32(var_04.var_9180,var_04.var_1E41);
		level.player scripts\common\utility::func_1C6E(1);
		scripts\common\utility::func_6E2A("secondary_equipment_in_use");
		level.player thread scripts\sp\_utility::func_65DE("support_drone_spawning",0.05);
	}
}

//Function Number: 5
func_5BE1()
{
	self endon("death");
	for(;;)
	{
		var_00 = 0;
		for(var_01 = 0;var_01 < 5;var_01++)
		{
			if(isdefined(self.var_4C29[var_01]) && self.var_4C29[var_01].var_51BA == 1)
			{
				self.var_4C29[var_01] = undefined;
				level notify("drone_max_cleanup");
				var_00 = 1;
			}
		}

		if(var_00)
		{
			var_02 = 0;
			for(var_01 = 0;var_01 < 5;var_01++)
			{
				if(isdefined(self.var_4C29[var_01]) && isdefined(self.var_4C29[var_01].var_5BD7))
				{
					self.var_4C29[var_01].var_5BD7.var_D384 = var_02;
					var_02++;
				}
			}
		}

		if(level.player.var_5C6E > 0)
		{
			level.player.var_5C6E = level.player.var_5C6E - 0.05;
		}

		if(level.player.var_5C4F > 0)
		{
			level.player.var_5C4F = level.player.var_5C4F - 0.05;
		}

		wait(0.05);
	}
}

//Function Number: 6
func_7AC7()
{
	if(isdefined(self.var_5CB3))
	{
		return 5;
	}

	return 3;
}

//Function Number: 7
func_7B32()
{
	var_00 = 0;
	for(var_01 = 0;var_01 < func_7AC7();var_01++)
	{
		if(isdefined(self.var_4C29[var_01]))
		{
			var_00++;
		}
	}

	return var_00;
}

//Function Number: 8
func_7B15()
{
	for(var_00 = 0;var_00 < func_7AC7();var_00++)
	{
		if(!isdefined(self.var_4C29[var_00]))
		{
			return var_00;
		}
	}

	return undefined;
}

//Function Number: 9
func_385A()
{
	if(!self method_843C() || self method_81B8() || !scripts\common\utility::func_9EC1() || !scripts\common\utility::func_9EBF())
	{
		return 0;
	}

	var_00 = self method_80FB(func_129A());
	if(var_00 <= 0)
	{
		return 0;
	}

	if(func_7B32() >= func_7AC7() - 1)
	{
		thread func_C808();
		while(func_7B32() > func_7AC7() - 1)
		{
			wait(0.05);
		}

		return 1;
	}

	return 1;
}

//Function Number: 10
func_C808()
{
	if(!isdefined(level.player.var_4C29))
	{
		return;
	}

	for(;;)
	{
		var_00 = undefined;
		var_01 = undefined;
		for(var_02 = 0;var_02 < 5;var_02++)
		{
			if(!isdefined(level.player.var_4C29[var_02]))
			{
				continue;
			}

			if(isdefined(level.player.var_4C29[var_02].var_E0EC) && level.player.var_4C29[var_02].var_E0EC)
			{
				continue;
			}

			if(isdefined(level.player.var_4C29[var_02].var_9A96) && level.player.var_4C29[var_02].var_9A96)
			{
				continue;
			}

			if(!isdefined(var_00) || level.player.var_4C29[var_02].var_5BD7.var_1E41 < var_00)
			{
				var_00 = level.player.var_4C29[var_02].var_5BD7.var_1E41;
				var_01 = var_02;
			}
		}

		if(isdefined(var_01))
		{
			level.player.var_4C29[var_01].var_5BD7 notify("timeout");
			level.player.var_4C29[var_01].var_E0EC = 1;
			break;
		}

		wait(0.1);
	}
}

//Function Number: 11
func_112BA(param_00)
{
	var_01 = getentarray("support_drone_spawner","targetname");
	var_02 = var_01[0];
	level.player thread scripts\sp\_utility::func_CE2F("support_drone_activate");
	self notify("drone_spawned");
	var_03 = level.player getplayerangles();
	var_04 = scripts\common\utility::func_6EE1(var_03);
	var_05 = level.player geteye();
	var_06 = anglestoup(var_03);
	var_07 = anglestoup(var_04);
	var_08 = anglestoforward(var_04);
	var_09 = 24;
	var_0A = 24;
	var_0B = var_05;
	var_0C = scripts\common\trace::func_DCED(var_05,var_05 + var_06 * var_0A + var_09,undefined,scripts\common\trace::func_4956(1));
	if(var_0C["fraction"] != 1)
	{
		var_0C = scripts\common\trace::func_DCED(var_05,var_05 + var_07 * var_0A + var_09,undefined,scripts\common\trace::func_4956(1));
		if(var_0C["fraction"] != 1)
		{
			var_0B = var_05 + var_07 * var_0A * var_0C["fraction"];
		}
		else
		{
			var_0B = var_05 + var_07 * var_0A;
		}
	}
	else
	{
		var_0B = var_05 + var_06 * var_0A;
	}

	var_02.origin = var_0B;
	var_02.angles = var_04;
	var_0D = var_02 scripts\sp\_utility::func_10808();
	var_0D method_83D0(#animtree);
	var_0D method_81F1("allies");
	var_0D method_81FA(1);
	var_0D method_834E("equipment");
	var_0D setcandamage(1);
	var_0D scripts\sp\_vehicle::func_8441();
	var_0D method_839E();
	var_0D.var_6DA5 = 0;
	var_0D.var_C181 = 0;
	level.player.var_112AB = var_0D;
	var_0D.var_50 = 0.5;
	var_0D.var_B00E = spawn("script_origin",(0,0,0));
	var_0D method_8305(var_0D.var_B00E);
	var_0D.var_D630 = undefined;
	scripts\common\utility::array_thread(param_00,::func_112B7,var_0D);
	var_0D notify("stop_kicking_up_dust");
	var_0D.var_2654 = 0;
	var_0D.var_1E41 = 20;
	var_0D makeunusable();
	var_0D thread func_5C1F();
	var_0D thread func_5C4B(1,1);
	if(!isdefined(var_0D.var_B435))
	{
		var_0D.var_B435 = 100;
	}

	var_0D.var_1280E = 0;
	var_0D thread func_112BC();
	var_0D thread func_5C30();
	var_0D thread func_5C55();
	var_0D thread func_5C59();
	var_0D thread func_5C5C();
	var_0D thread func_5C3F();
	var_0D thread func_5BED();
	var_0D thread func_5C37();
	var_0D thread func_5BF0();
	var_0D method_82A4(%equip_pocket_drone_hover_loop);
	return var_0D;
}

//Function Number: 12
func_11719(param_00)
{
	param_00 endon("death");
	iprintlnbold("Dpad Up: hover");
	iprintlnbold("Dpad Left: damaged");
	iprintlnbold("Dpad Right: death");
	level.player notifyonplayercommand("dpadup","+actionslot 1");
	level.player notifyonplayercommand("dpaddown","+actionslot 2");
	level.player notifyonplayercommand("dpadleft","+actionslot 3");
	for(;;)
	{
		var_01 = level.player scripts\common\utility::func_13734("dpadup","dpaddown","dpadleft");
		if(var_01 == "dpadup")
		{
			iprintlnbold("hover");
			param_00 method_82A4(%equip_pocket_drone_hover_loop);
		}
		else if(var_01 == "dpadleft")
		{
			iprintlnbold("damaged");
			param_00 method_82A4(%equip_pocket_drone_damaged_loop);
		}
		else if(var_01 == "dpaddown")
		{
			iprintlnbold("death");
			param_00 method_82A4(%equip_pocket_drone_death_loop);
		}

		wait(0.25);
	}
}

//Function Number: 13
func_5C30()
{
	if(isdefined(self.var_C93D))
	{
		return;
	}

	if(self.team == "allies")
	{
		scripts\sp\_utility::func_9196(3,0,0,"default_supdrone");
		self.var_5CDB scripts\sp\_utility::func_9196(3,0,0,"default_supdrone");
		return;
	}

	if(self.team == "axis")
	{
		scripts\sp\_utility::func_9196(1,0,0,"default_supdrone");
		self.var_5CDB scripts\sp\_utility::func_9196(1,0,0,"default_supdrone");
	}
}

//Function Number: 14
func_112BC()
{
	foreach(var_01 in self.var_B6BD)
	{
		var_01 method_835E("allies");
		var_01.var_5041 = "manual";
		var_01 method_830F("manual");
		var_01 method_83C7();
		var_01 method_82FB(90);
		var_01 method_8330(90);
		var_01 method_8353(90);
		var_01 method_82B6(90);
		var_01 method_82C9(0,"yaw");
		var_01 method_82C9(0,"pitch");
	}

	self.var_5CDB = self.var_B6BD[0];
	self.var_B6BD[0] show();
	self.var_5CAF = ::func_5C0F;
}

//Function Number: 15
func_5C37()
{
	self endon("death_anim");
	self endon("death");
	var_00 = 0;
	for(;;)
	{
		if(func_D2DD())
		{
			var_00 = 1;
		}
		else if(level.player.ignoreme)
		{
			var_00 = 1;
		}
		else
		{
			var_00 = 0;
		}

		self.ignoreme = var_00;
		wait(0.1);
	}
}

//Function Number: 16
func_5C4B(param_00,param_01)
{
	if(isdefined(param_00) && param_00)
	{
		thread func_5BD8();
	}

	if(isdefined(param_01) && param_01)
	{
		thread func_5BDD();
	}
}

//Function Number: 17
func_5C3F()
{
	self endon("death_anim");
	self endon("death");
	wait(100);
	self notify("timeout");
}

//Function Number: 18
func_5BF0()
{
	self endon("death_anim");
	self endon("death");
	var_00 = scripts\common\utility::func_13734("no_ammo","lethal_damage","timeout","vr_delete");
	if(isdefined(level.player.var_4C29[self.var_9180].var_9A96) && level.player.var_4C29[self.var_9180].var_9A96)
	{
		while(level.player.var_4C29[self.var_9180].var_9A96)
		{
			wait(0.05);
		}
	}

	thread func_F378(self.var_9180,"off");
	if(var_00 == "no_ammo")
	{
		wait(1);
		thread func_5BF5(1);
		return;
	}

	if(var_00 == "lethal_damage")
	{
		thread func_5BF6();
		return;
	}

	if(var_00 == "timeout")
	{
		thread func_5BF5();
		return;
	}

	if(var_00 == "vr_delete")
	{
		thread func_5BF7();
		return;
	}
}

//Function Number: 19
func_5BF5(param_00)
{
	self notify("death_anim");
	if(isdefined(param_00) && param_00 == 1)
	{
		func_F377(self.var_9180,"noammo");
	}
	else
	{
		func_F377(self.var_9180,"destroyed");
	}

	scripts\sp\_utility::func_9193("default_supdrone");
	self.var_5CDB scripts\sp\_utility::func_9193("default_supdrone");
	self playsound("support_drone_engine_mvmt_death");
	self method_82A4(%equip_pocket_drone_death_loop);
	thread func_5C0C("veh_mil_air_un_pocketdrone_timeout_crash_body_4fan");
}

//Function Number: 20
func_5BF7()
{
	self notify("death_anim");
	func_F377(self.var_9180,"destroyed");
	scripts\sp\_utility::func_9193("default_supdrone");
	self.var_5CDB scripts\sp\_utility::func_9193("default_supdrone");
	scripts\common\utility::func_136F7();
	if(isdefined(self.var_B00E))
	{
		self.var_B00E delete();
	}

	self delete();
}

//Function Number: 21
func_5BF6()
{
	self notify("death_anim");
	func_F377(self.var_9180,"destroyed");
	scripts\sp\_utility::func_9193("default_supdrone");
	self.var_5CDB scripts\sp\_utility::func_9193("default_supdrone");
	self playsound("support_drone_engine_mvmt_death");
	self method_82A4(%equip_pocket_drone_death_loop);
	if(isdefined(self.var_A964))
	{
		var_00 = self.var_A964;
	}
	else
	{
		var_00 = anglestoright(level.player getplayerangles());
	}

	if(var_00 == (0,0,0))
	{
		var_00 = (1,0,0);
	}

	var_01 = anglestoup(vectortoangles(var_00));
	playfx(level._effect["drone_shotdown_air_damage"],self.origin,var_00,var_01);
	self setmodel("veh_mil_air_un_pocketdrone_shotdown_flight_body_dangle");
	thread func_5C0C("veh_mil_air_un_pocketdrone_shotdown_crash_body_dangle");
}

//Function Number: 22
func_5C0C(param_00)
{
	var_01 = anglestoforward(self.angles + (45,0,0) + (0,randomfloat(360),0));
	var_02 = scripts\common\trace::func_DCED(self.origin,self.origin + var_01 * 999999,undefined,scripts\common\trace::func_4956(1));
	var_03 = distance(self.origin,var_02["position"]);
	var_04 = 0.43;
	var_05 = var_03 * var_04;
	self method_8316(var_05);
	thread func_5C0D();
	self method_830A(60,60);
	self.angles = (45,45,0);
	self method_8362(var_02["position"],0);
	self waittill("near_goal");
	if(!isdefined(self))
	{
		return;
	}

	var_06 = 0.05681818;
	var_07 = self vehicle_getvelocity();
	var_08 = var_07 * var_06;
	var_09 = 2.5;
	var_0A = spawn("script_model",self.origin + var_08);
	var_0A setmodel(param_00);
	var_0A hide();
	var_0A.angles = self gettagangles("j_body");
	wait(0.05);
	var_0A show();
	var_0A physicslaunchserver(var_0A.origin,var_07 * var_09);
	if(isdefined(self.var_B00E))
	{
		self.var_B00E delete();
	}

	self delete();
	var_0B = 0.1;
	var_0C = 64;
	var_0D = var_0B * var_05 / var_0C;
	wait(var_0D);
	var_0A playsound("support_drone_engine_mvmt_death_impact_hit");
	playfx(level._effect["drone_death_hit_ground"],var_0A.origin,anglestoforward(var_0A.angles),anglestoup(var_0A.angles));
	level.player.var_5CA6 = scripts\common\utility::func_22BC(level.player.var_5CA6);
	if(level.player.var_5CA6.size >= 5)
	{
		level.player.var_5CA6[0] delete();
		level.player.var_5CA6 = scripts\common\utility::func_22BC(level.player.var_5CA6);
	}

	level.player.var_5CA6[level.player.var_5CA6.size] = var_0A;
	var_0A thread func_5BE7();
}

//Function Number: 23
func_5BE7()
{
	level.player endon("death");
	self endon("death");
	self endon("entitydeleted");
	for(;;)
	{
		if(distance(level.player.origin,self.origin) > 2200)
		{
			break;
		}

		wait(1);
	}

	level.player.var_5CA6 = scripts\common\utility::func_22A9(level.player.var_5CA6,self);
	self delete();
}

//Function Number: 24
func_5C0D()
{
	self endon("death");
	self endon("near_goal");
	self method_83E5(30,8,8);
	wait(0.5);
	if(isdefined(self))
	{
		self method_83E5(30,25,25);
	}
}

//Function Number: 25
func_5C55()
{
	self endon("death_anim");
	self endon("death");
	thread func_5C44();
	self method_82F6(2,10,10);
	self method_8379("instant");
	self method_8316(64);
	self method_83E5(50,50,100);
	self.var_8435 = (0,0,level.var_5C19[level.var_5C18]);
	level.var_5C18++;
	if(level.var_5C18 >= level.var_5C19.size)
	{
		level.var_5C18 = 0;
	}

	var_00 = 1;
	var_01 = (-3000,-3000,-3000);
	var_02 = (-3000,-3000,-3000);
	func_5C57(var_02);
	for(;;)
	{
		wait(0.05);
		var_03 = undefined;
		self.var_6FFF = 0;
		var_04 = func_5C52();
		if(var_04 == "follow")
		{
			var_05 = scripts\common\utility::func_5D14(level.player.origin,8);
			if(func_5C56(var_05))
			{
				var_03 = func_5C54();
				var_02 = var_05;
				func_5C57(var_02);
			}
			else
			{
				var_03 = var_01;
				func_5C5A(var_02);
			}
		}
		else if(var_04 == "combat")
		{
			self.var_BE7A = scripts\sp\_utility::func_22BB(self.var_BE7A);
			if(isdefined(self.var_1155E) && isalive(self.var_1155E) && level.player.var_5C4F > 0)
			{
				var_03 = var_01;
			}
			else
			{
				var_03 = func_5C53(var_01);
			}
		}

		if(var_01 == var_03)
		{
			continue;
		}

		var_01 = var_03;
		thread func_5C61(var_03);
	}
}

//Function Number: 26
func_5C54()
{
	var_00 = anglestoforward(level.player.angles);
	var_01 = anglestoright(level.player.angles);
	var_02 = scripts\common\utility::func_5D14(level.player.origin,8);
	var_03 = self.var_8435[2];
	var_04 = var_02 + (0,0,var_03);
	var_05 = scripts\common\trace::func_DCED(var_02,var_04,undefined,scripts\common\trace::func_4956(1));
	if(var_05["fraction"] != 1)
	{
		var_04 = var_02 + (0,0,var_05["fraction"] * var_03 - 10);
	}

	if(getdvarint("support_drone_debug"))
	{
		thread scripts\common\utility::func_5B4B(var_02,var_04,0,1,1,0.1);
	}

	var_06 = 1;
	var_07 = 1;
	if(self.var_D384 == 1)
	{
		var_07 = -1;
	}
	else if(self.var_D384 == 2)
	{
		var_06 = -1;
	}
	else if(self.var_D384 >= 3)
	{
		var_06 = -1;
		var_07 = -1;
	}

	var_08 = 115 * var_06 + self.var_8435[0];
	var_09 = 45 * var_07 + self.var_8435[1];
	var_0A = var_04 + var_00 * var_08 + var_01 * var_09;
	var_05 = scripts\common\trace::func_DCED(var_04,var_0A,undefined,scripts\common\trace::func_4956(1));
	if(var_05["fraction"] != 1)
	{
		var_0B = vectornormalize(var_0A - var_04);
		var_0C = distance(var_0A,var_04);
		var_0A = var_04 + var_0B * var_05["fraction"] * var_0C - 10;
	}

	if(getdvarint("support_drone_debug"))
	{
		thread scripts\common\utility::func_5B4B(var_04,var_0A,0,1,1,0.1);
	}

	var_0D = var_0A;
	if(getdvarint("support_drone_debug"))
	{
		thread scripts\common\utility::func_5B4B(var_0D,var_0D + (0,0,16),0,0,1,0.1);
	}

	var_0E = scripts\common\trace::func_DCF1(self.origin,var_0D,undefined,scripts\common\trace::func_4956(1));
	if(var_0E)
	{
		self.var_6FFF = 1;
	}
	else if(getdvarint("support_drone_debug"))
	{
		thread scripts\common\utility::func_5B4B(self.origin,var_0D,1,0,0,0.1);
	}

	var_0F = scripts\common\utility::func_5D14(var_0D,0);
	var_10 = getclosestpointonnavmesh(var_0F);
	var_11 = 1;
	if(distance(var_0F,var_10) > 8)
	{
		if(getdvarint("support_drone_debug"))
		{
			thread scripts\common\utility::func_5B4B(var_0F,var_0F + (0,0,16),1,0,0,0.25);
			thread scripts\common\utility::func_5B4B(var_10,var_10 + (0,0,16),0,1,0,0.25);
		}

		if(!self.var_6FFF)
		{
			var_11 = 0;
		}
	}

	var_12 = var_0D;
	if(!var_11)
	{
		if(distance(var_02,var_10) > distance(var_02,var_0F))
		{
			var_12 = var_04;
		}
		else
		{
			var_12 = (var_10[0],var_10[1],var_04[2]);
		}
	}

	self.var_1D55 = var_03;
	return var_12;
}

//Function Number: 27
func_5C57(param_00)
{
	self.var_4B2E = 6;
	self.var_4B2F = param_00;
}

//Function Number: 28
func_5C5A(param_00)
{
	var_01 = 4.88;
	self.var_4B2E = min(self.var_4B2E + var_01,128);
	if(self.var_4B2E != 128)
	{
		var_02 = self.origin - param_00;
		var_02 = vectornormalize((var_02[0],var_02[1],0));
		self.var_4B2F = self.var_4B2F + var_02 * distance2d(self.origin,param_00) / 2 * 0.8 * 0.05;
	}
}

//Function Number: 29
func_5C56(param_00)
{
	if(getdvarint("support_drone_debug"))
	{
		thread scripts\sp\_utility::func_5B29(self.var_4B2F + (0,0,16),self.var_4B2E,(1,0,0),1,0,1);
	}

	if(distance(param_00,self.var_4B2F) >= self.var_4B2E)
	{
		return 1;
	}

	return 0;
}

//Function Number: 30
func_5C51()
{
	self.var_4B2E = 0;
}

//Function Number: 31
func_5C53(param_00)
{
	var_01 = self.var_8435[2];
	var_02 = scripts\common\utility::func_5D14(level.player.origin,5);
	var_02 = var_02 + (0,0,var_01);
	var_03 = [];
	var_04 = [];
	foreach(var_06 in self.var_BE7A)
	{
		var_03[var_03.size] = var_06.origin + (0,0,var_01);
		var_04[var_04.size] = var_06.origin + (0,0,var_01);
	}

	for(var_08 = 0;var_08 < int(self.var_BE7A.size * 1.5);var_08++)
	{
		var_03[var_03.size] = var_02;
	}

	var_09 = averagepoint(var_03);
	var_0A = averagepoint(var_04);
	var_0B = (0,0,0);
	if(var_0A == var_02)
	{
		var_0B = level.player.angles;
	}
	else
	{
		var_0B = vectortoangles(vectornormalize(var_0A - var_02));
	}

	var_0C = vectornormalize(var_0A - var_02);
	var_0D = distance(var_09,var_02);
	if(var_0D > 700)
	{
		var_09 = var_02 + var_0C * 700;
	}

	var_0E = anglestoright(var_0B);
	var_0F = 90;
	if(self.var_D384 == 0)
	{
		var_09 = var_09 + var_0E * var_0F / 2;
	}
	else if(self.var_D384 == 1)
	{
		var_09 = var_09 - var_0E * var_0F / 2;
	}
	else if(self.var_D384 == 2)
	{
		var_09 = var_09 + var_0E * var_0F * 1.5;
	}
	else if(self.var_D384 >= 3)
	{
		var_09 = var_09 - var_0E * var_0F * 1.5;
	}

	if(isdefined(self.var_1155E) && isalive(self.var_1155E))
	{
		var_10 = vectornormalize(self.var_1155E.origin + (0,0,var_01) - var_09);
		var_11 = distance(self.var_1155E.origin + (0,0,var_01),var_09) / 4;
		if(var_11 > 100)
		{
			var_11 = 100;
		}

		var_09 = var_09 + var_10 * var_11;
	}

	if(distancesquared(var_09,param_00) < 2500)
	{
		return param_00;
	}
	else
	{
		level.player.var_5C4F = randomfloatrange(0.2,2.5);
	}

	var_12 = scripts\common\trace::func_DCF1(self.origin,var_09,undefined,scripts\common\trace::func_4956(1));
	if(var_12)
	{
		self.var_6FFF = 1;
	}
	else if(getdvarint("support_drone_debug"))
	{
		thread scripts\common\utility::func_5B4B(self.origin,var_09,1,0,0,0.1);
	}

	var_13 = scripts\common\utility::func_5D14(var_09,0);
	var_14 = getclosestpointonnavmesh(var_13);
	var_15 = 1;
	if(distance(var_13,var_14) > 8)
	{
		if(getdvarint("support_drone_debug"))
		{
			thread scripts\common\utility::func_5B4B(var_13,var_13 + (0,0,16),1,0,0,0.25);
			thread scripts\common\utility::func_5B4B(var_14,var_14 + (0,0,16),0,1,0,0.25);
		}

		if(!self.var_6FFF)
		{
			var_15 = 0;
		}
	}

	var_16 = var_09;
	if(!var_15)
	{
		var_16 = (var_14[0],var_14[1],var_14[2] + var_01);
	}

	self.var_1D55 = var_01;
	return var_16;
}

//Function Number: 32
func_5C52()
{
	if(func_D2DD())
	{
		return "follow";
	}

	self.var_BE7A = scripts\sp\_utility::func_22BB(self.var_BE7A);
	if(self.var_BE7A.size > 0)
	{
		return "combat";
	}

	return "follow";
}

//Function Number: 33
func_5C61(param_00)
{
	self notify("new_path");
	self endon("new_path");
	self endon("death");
	if(self.var_6FFF == 1)
	{
		self method_8362(param_00,1);
		if(getdvarint("support_drone_debug"))
		{
			thread scripts\common\utility::func_5B4B(self.origin,param_00,0,1,0,0.25);
		}

		scripts\common\utility::waittill_any_3("near_goal","goal");
		return;
	}

	var_01 = scripts\common\utility::func_5D14(self.origin,0) + (0,0,8);
	var_02 = param_00 - (0,0,self.var_1D55);
	var_03 = level.player method_8428(var_01,var_02);
	var_04 = self.origin;
	if(getdvarint("support_drone_debug"))
	{
		foreach(var_06 in var_03)
		{
			thread scripts\common\utility::func_5B4B(var_04,var_06,0,1,0,0.25);
			var_04 = var_06;
		}
	}

	foreach(var_06 in var_03)
	{
		if(getdvarint("support_drone_debug"))
		{
		}

		if(isdefined(self.var_1D55))
		{
			var_06 = var_06 + (0,0,self.var_1D55);
		}

		if(getdvarint("support_drone_debug"))
		{
		}

		self method_8362(var_06,1);
		scripts\common\utility::waittill_any_3("near_goal","goal");
	}
}

//Function Number: 34
func_5C44()
{
	self endon("death_anim");
	self endon("death");
	for(;;)
	{
		if(isdefined(self.var_1155E) && isalive(self.var_1155E))
		{
			self.var_B00E.origin = self.var_1155E gettagorigin("j_Spine4");
			self.var_5CDB method_81D9();
		}
		else
		{
			var_00 = level.player geteye();
			var_01 = anglestoforward(level.player getplayerangles());
			var_02 = var_00 + var_01 * 5000;
			var_03 = scripts\common\trace::func_DCED(var_00,var_02,level.player);
			self.var_B00E.origin = var_03["position"];
			self.var_5CDB method_81D8();
		}

		if(getdvarint("support_drone_debug"))
		{
		}

		wait(0.1);
	}
}

//Function Number: 35
func_5C1F()
{
	self endon("death_anim");
	self endon("death");
	if(!isdefined(self.var_BE7A))
	{
		self.var_BE7A = [];
	}

	for(;;)
	{
		var_00 = [];
		foreach(var_02 in function_0072("axis"))
		{
			if(func_64EA(var_02) && !issubstr(var_02.classname,"c12"))
			{
				var_00[var_00.size] = var_02;
			}
		}

		if(self.var_BE7A.size == 0 && var_00.size > 0)
		{
			self notify("found_enemies");
		}
		else if(self.var_BE7A.size > 0 && var_00.size == 0)
		{
			self notify("no_enemies");
		}

		self.var_BE7A = var_00;
		wait(0.1);
	}
}

//Function Number: 36
func_64EA(param_00)
{
	if(!isalive(param_00) || param_00 scripts\sp\_utility::func_58DA())
	{
		return 0;
	}

	if(distance(param_00.origin,self.origin) > 1200)
	{
		return 0;
	}

	if(isdefined(param_00.var_1CAC))
	{
		return param_00.var_1CAC;
	}

	if(param_00.ignoreme)
	{
		return 0;
	}

	return 1;
}

//Function Number: 37
func_5C22()
{
	self endon("death_anim");
	self endon("death");
	for(;;)
	{
		var_00 = randomfloatrange(-10,10);
		var_01 = randomfloatrange(-10,10);
		var_02 = randomfloatrange(-10,10);
		self.var_8435 = (var_01,var_02,var_00);
		wait(randomfloatrange(2,4));
	}
}

//Function Number: 38
func_112B8()
{
	var_00 = getentarray("drone_point_of_interest","targetname");
	foreach(var_02 in var_00)
	{
		var_03 = scripts\common\utility::getstructarray(var_02.target,"targetname");
		foreach(var_05 in var_03)
		{
			var_06 = var_05.origin[2];
			var_05.var_8D12 = (0,0,var_06);
			var_05.origin = (var_05.origin[0],var_05.origin[1],0);
		}

		var_02.var_D62F = var_03;
	}

	return var_00;
}

//Function Number: 39
func_112B7(param_00)
{
	if(!func_1310A())
	{
		return;
	}

	param_00 endon("death");
	var_01 = 4000;
	for(;;)
	{
		scripts\common\utility::func_6E5A("stealth_spotted");
		self waittill("trigger");
		if(isdefined(param_00.var_D630))
		{
			continue;
		}

		var_02 = gettime();
		var_03 = randomintrange(2500,5000);
		param_00.var_D630 = scripts\common\utility::random(self.var_D62F);
		while(level.player istouching(self))
		{
			if(scripts\common\utility::flag("stealth_spotted"))
			{
				break;
			}

			if(gettime() - var_02 <= var_03)
			{
				param_00.var_D630 = scripts\common\utility::random(self.var_D62F);
				var_03 = randomintrange(2500,5000);
			}

			wait(0.1);
		}

		param_00.var_D630 = undefined;
	}
}

//Function Number: 40
func_5BED()
{
	self endon("death");
	var_00 = 0;
	var_01 = 0;
	for(;;)
	{
		self waittill("damage",var_02,var_03,var_04,var_05,var_06);
		var_00 = var_00 + var_02;
		self.var_A964 = var_04;
		if(var_00 > 600 && !var_01)
		{
			thread func_5C05();
			var_01 = 1;
		}

		if(var_00 > 1200)
		{
			self notify("lethal_damage");
		}
	}
}

//Function Number: 41
func_5C05()
{
	self method_82A4(%equip_pocket_drone_damaged_loop);
	scripts\sp\_utility::func_75C4("drone_damaged_loop","tag_origin");
	scripts\common\utility::waittill_any_3("death","death_anim");
	if(isdefined(self))
	{
		scripts\sp\_utility::func_75F8("drone_damaged_loop","tag_origin");
	}
}

//Function Number: 42
func_5BD8()
{
	self endon("death_anim");
	self endon("death");
	self endon("entitydeleted");
	if(!scripts\sp\_utility::func_65DF("target_timeout"))
	{
		scripts\sp\_utility::func_65E0("target_timeout");
	}

	if(!scripts\sp\_utility::func_65DF("target_killed_wait"))
	{
		scripts\sp\_utility::func_65E0("target_killed_wait");
	}

	self.var_2654 = 1;
	childthread func_5BE6();
	thread func_5BE5();
	wait(2);
	for(;;)
	{
		self waittill("new_target_enemy");
		self playsound("support_drone_engine_mvmt_fast");
		childthread func_5C98(self.var_1155E);
	}
}

//Function Number: 43
func_5BE5()
{
	scripts\common\utility::waittill_any_3("death_anim","death","entitydeleted");
	func_F378(self.var_9180,"off");
}

//Function Number: 44
func_5BE6()
{
	wait(2);
	for(;;)
	{
		wait(0.05);
		var_00 = 0;
		var_01 = 0;
		while(level.player.var_5C6E > 0)
		{
			scripts\common\utility::func_136F7();
		}

		while(func_D2DD())
		{
			wait(0.25);
		}

		if(self.var_BE7A.size == 0)
		{
			self waittill("found_enemies");
			continue;
		}

		if((isdefined(self.var_1155E) && !isalive(self.var_1155E) || self.var_1155E scripts\sp\_utility::func_58DA()) || scripts\sp\_utility::func_65DB("target_killed_wait"))
		{
			var_01 = 1;
		}

		if(!var_01 || scripts\sp\_utility::func_65DB("target_timeout"))
		{
			var_00 = 1;
		}

		if(var_00)
		{
			var_02 = func_5C1C(self.var_1155E);
			if(!isdefined(var_02))
			{
				continue;
			}

			level.player.var_5C6E = randomfloatrange(0.5,1.5);
			if(isdefined(self.var_1155E) && var_02 == self.var_1155E)
			{
				continue;
			}

			self notify("stop_hud");
			self.var_1155E = var_02;
			var_02 notify("drone_targeting");
			self notify("new_target_enemy");
			thread func_5BEB();
			scripts\sp\_utility::func_65DD("target_timeout");
			scripts\sp\_utility::func_65E1("target_killed_wait");
		}
	}
}

//Function Number: 45
func_5C1C(param_00)
{
	self.var_BE7A = scripts\sp\_utility::func_22BB(self.var_BE7A);
	if(self.var_BE7A.size == 0)
	{
		return undefined;
	}

	var_01 = [];
	foreach(var_03 in self.var_BE7A)
	{
		if(!isdefined(var_03))
		{
			continue;
		}

		if(isdefined(var_03.var_1CAC))
		{
			if(var_03.var_1CAC)
			{
				var_01[var_01.size] = var_03;
			}
			else
			{
				continue;
			}
		}

		if(isdefined(var_03.ignoreme) && var_03.ignoreme)
		{
			continue;
		}

		var_01[var_01.size] = var_03;
	}

	if(var_01.size == 0)
	{
		return undefined;
	}

	var_05 = [];
	foreach(var_03 in var_01)
	{
		if(func_5BE9(var_03))
		{
			var_05[var_05.size] = var_03;
		}
	}

	var_08 = var_05;
	if(var_08.size == 0)
	{
		return undefined;
	}

	if(isdefined(param_00) && scripts\common\utility::func_2286(var_08,param_00))
	{
		return param_00;
	}

	var_09 = var_08[randomint(var_08.size)];
	return var_09;
}

//Function Number: 46
func_5BE9(param_00)
{
	var_01 = 0;
	var_02 = scripts\common\trace::func_DCED(self.origin,param_00 gettagorigin("j_head"),undefined,scripts\common\trace::func_4956(1));
	if(var_02["fraction"] == 1)
	{
		var_01 = 1;
	}

	if(isalive(level.player) && var_01 == 0)
	{
		var_02 = scripts\common\trace::func_DCED(level.player geteye(),param_00 gettagorigin("j_head"),undefined,scripts\common\trace::func_4956(1));
		if(var_02["fraction"] == 1)
		{
			var_01 = 1;
		}
	}

	return var_01;
}

//Function Number: 47
func_5C98(param_00)
{
	self endon("death_anim");
	self endon("death");
	self endon("new_target_enemy");
	self endon("target_enemy_died");
	childthread func_5C60(param_00);
	thread func_5C01(param_00);
	wait(0.5);
	while(isdefined(param_00) && isalive(param_00))
	{
		if(self.var_1280E)
		{
			wait(0.05);
			continue;
		}

		var_01 = self.var_5CDB gettagorigin("tag_flash");
		var_02 = param_00 gettagorigin("j_Spine4");
		var_03 = cos(90);
		if(!scripts\common\utility::func_13D90(var_01,self.var_5CDB gettagangles("tag_flash"),var_02,var_03))
		{
			wait(0.05);
			continue;
		}

		var_04 = ["j_Head","j_Spine4","j_SpineLower"];
		if(param_00.var_238F == "seeker")
		{
			var_04 = scripts\common\utility::func_22A9(var_04,"j_SpineLower");
		}

		var_05 = undefined;
		foreach(var_07 in var_04)
		{
			if(getdvarint("support_drone_debug"))
			{
				thread scripts\common\utility::func_5B4B(var_01,param_00 gettagorigin(var_07),0.7,0,0,0.1);
			}

			var_08 = scripts\common\trace::func_DCEE(var_01,param_00 gettagorigin(var_07),self);
			if(!isdefined(var_08["entity"]))
			{
				continue;
			}

			if(var_08["entity"] == level.player)
			{
				return;
			}

			if(var_08["entity"] == param_00)
			{
				var_05 = param_00 gettagorigin(var_07);
				break;
			}
		}

		if(!isdefined(var_05))
		{
			wait(0.05);
			continue;
		}

		var_0A = var_05 - param_00.origin;
		self.var_5CDB method_8347(param_00,var_0A);
		self thread [[ self.var_5CAF ]]();
		wait(1.2);
		thread func_5C89();
	}

	self.var_1155E = undefined;
}

//Function Number: 48
func_5C89()
{
	self notify("new_target_timeout");
	self endon("new_target_timeout");
	self endon("death_anim");
	self endon("death");
	self endon("new_target_enemy");
	wait(3);
	scripts\sp\_utility::func_65E1("target_timeout");
}

//Function Number: 49
func_5C60(param_00)
{
	thread scripts\sp\_utility::func_CE2F("support_drone_lockon");
	func_F378(self.var_9180,"lockon",param_00);
}

//Function Number: 50
func_5C01(param_00)
{
	self endon("death_anim");
	self endon("death");
	self endon("new_target_enemy");
	param_00 scripts\common\utility::waittill_any_3("death","entitydeleted","death_anim");
	self notify("target_enemy_died");
	self.var_1155E = undefined;
	scripts\sp\_utility::func_65E8("target_killed_wait");
	func_F378(self.var_9180,"off");
}

//Function Number: 51
func_5BDD()
{
	self endon("death_anim");
	self endon("death");
	self.var_11AD3 = [];
	thread func_5C9C();
	for(;;)
	{
		self.var_11AD3 = scripts\common\utility::func_22BC(self.var_11AD3);
		if(self.var_11AD3.size <= 0)
		{
			level waittill("enemy_grenade_fire",var_00);
			wait(0.05);
			continue;
		}

		if(self.var_1280E)
		{
			wait(0.05);
			continue;
		}

		foreach(var_00 in self.var_11AD3)
		{
			var_02 = distance(var_00.origin,self.origin);
			if(var_02 <= 800)
			{
				thread func_5C9B(var_00);
				self.var_11AD3 = scripts\common\utility::func_22A9(self.var_11AD3,var_00);
				break;
			}
		}

		wait(0.05);
	}
}

//Function Number: 52
func_5C9C()
{
	self endon("death_anim");
	self endon("death");
	for(;;)
	{
		level waittill("enemy_grenade_fire",var_00);
		self.var_11AD3 = scripts\common\utility::array_add(self.var_11AD3,var_00);
	}
}

//Function Number: 53
func_5C9B(param_00)
{
	self.var_1280E = 1;
	thread scripts\common\utility::func_CD7F("support_drone_trophy_scan");
	wait(0.5);
	if(!isdefined(param_00))
	{
		self.var_1280E = 0;
		return;
	}

	self notify("trophy_system_engaged");
	thread scripts\common\utility::func_11018("support_drone_trophy_scan");
	self playsound("support_drone_trophy_fire");
	var_01 = vectornormalize(param_00.origin - self.var_5CDB gettagorigin("tag_flash"));
	function_02E0(level._effect["drone_trophy_laser"],self.var_5CDB gettagorigin("tag_flash"),vectortoangles(var_01),param_00.origin);
	playfx(level._effect["drone_trophy_pop"],param_00.origin);
	function_0178("support_drone_trophy_impact",param_00.origin);
	param_00 delete();
	self.var_1280E = 0;
}

//Function Number: 54
func_5C0F()
{
	self endon("death_anim");
	self endon("death");
	self endon("new_target_enemy");
	var_00 = self.var_1155E;
	func_F378(self.var_9180,"fire");
	self.var_1E41 = self.var_1E41 - 1;
	func_5C32(self.var_9180,self.var_1E41);
	if(self.var_1E41 <= 0)
	{
		self notify("no_ammo");
	}

	var_01 = var_00 gettagorigin("j_spine4");
	var_02 = var_01 - var_00.origin;
	var_03 = 4;
	for(var_04 = 0;var_04 < var_03;var_04++)
	{
		if(self.var_1E41 <= 0)
		{
			wait(0.1);
		}

		thread func_5C10();
		self.var_5CDB method_837E();
		wait(0.1);
	}

	wait(0.05);
	if(isdefined(var_00) && !isalive(var_00) || var_00 scripts\sp\_utility::func_58DA())
	{
		func_F378(self.var_9180,"kill");
	}
}

//Function Number: 55
func_5BEB()
{
	self endon("death_anim");
	self endon("death");
	self endon("new_target_enemy");
	for(;;)
	{
		wait(0.05);
		if(!isdefined(self.var_1155E) || !isalive(self.var_1155E) || self.var_1155E scripts\sp\_utility::func_58DA())
		{
			break;
		}
	}

	wait(1.6);
	scripts\sp\_utility::func_65DD("target_killed_wait");
}

//Function Number: 56
func_5C12()
{
	self endon("death_anim");
	self endon("death");
	thread scripts\sp\_utility::func_CD81("support_drone_windup","tag_origin");
	wait(0.5);
	scripts\common\utility::func_5127(0.15,::scripts\common\utility::func_11018,"support_drone_windup");
	self.var_1E41 = self.var_1E41 - 1;
	func_5C32(self.var_9180,self.var_1E41);
	if(self.var_1E41 <= 0)
	{
		self notify("no_ammo");
	}

	var_00 = 1;
	for(var_01 = 0;var_01 < var_00;var_01++)
	{
		if(self.var_1E41 <= 0)
		{
			wait(0.1);
		}

		self.var_5CDB method_837E();
		wait(0.1);
	}
}

//Function Number: 57
func_5C10()
{
	self endon("death_anim");
	self endon("death");
	self notify("firing");
	self endon("firing");
	if(!self.var_6DA5)
	{
		self.var_6DA5 = 1;
	}

	wait(1);
	self.var_6DA5 = 0;
}

//Function Number: 58
func_5C59()
{
	thread scripts\common\utility::func_CD7F("support_drone_engine");
	thread scripts\common\utility::func_CD7F("support_drone_close_lyr");
	scripts\common\utility::waittill_any_3("death","death_anim");
	if(isdefined(self))
	{
		func_5C58("support_drone_engine","support_drone_close_lyr");
	}
}

//Function Number: 59
func_5C58(param_00,param_01)
{
	self notify("stop sound" + param_00);
	self notify("stop sound" + param_01);
}

//Function Number: 60
func_5C5C()
{
	scripts\sp\_utility::func_75C4("drone_thruster","j_fan_front_le");
	scripts\sp\_utility::func_75C4("drone_thruster","j_fan_front_ri");
	scripts\sp\_utility::func_75C4("drone_thruster","j_fan_rear_le");
	scripts\sp\_utility::func_75C4("drone_thruster","j_fan_rear_ri");
	scripts\common\utility::waittill_any_3("death","death_anim");
	if(isdefined(self))
	{
		func_5C5B();
	}
}

//Function Number: 61
func_5C5B()
{
	scripts\sp\_utility::func_75F8("drone_thruster","j_fan_front_le");
	scripts\sp\_utility::func_75F8("drone_thruster","j_fan_front_ri");
	scripts\sp\_utility::func_75F8("drone_thruster","j_fan_rear_le");
	scripts\sp\_utility::func_75F8("drone_thruster","j_fan_rear_ri");
}

//Function Number: 62
func_9C6F()
{
	if(!isdefined(level.player.var_4C29))
	{
		return 0;
	}

	if(level.player.var_4C29.size <= 0)
	{
		return 0;
	}

	return 1;
}

//Function Number: 63
get_all_drones()
{
	var_00 = [];
	for(var_01 = 0;var_01 < 5;var_01++)
	{
		if(isdefined(level.player.var_4C29[var_01]) && isdefined(level.player.var_4C29[var_01].var_5BD7) && isalive(level.player.var_4C29[var_01].var_5BD7))
		{
			var_00 = scripts\common\utility::array_add(var_00,level.player.var_4C29[var_01].var_5BD7);
		}
	}

	return var_00;
}

//Function Number: 64
func_A5B9()
{
	if(!isdefined(level.player.var_4C29) || level.player.var_4C29.size == 0)
	{
		return;
	}

	foreach(var_01 in level.player.var_4C29)
	{
		var_01.var_5BD7 notify("lethal_damage");
	}
}

//Function Number: 65
func_5139()
{
	if(!isdefined(level.player.var_4C29) || level.player.var_4C29.size == 0)
	{
		return;
	}

	foreach(var_01 in level.player.var_4C29)
	{
		var_01.var_5BD7 notify("vr_delete");
	}
}

//Function Number: 66
func_1310A()
{
	return level.player scripts\sp\_utility::func_65DF("stealth_enabled") && level.player scripts\sp\_utility::func_65DB("stealth_enabled");
}

//Function Number: 67
func_D2DD()
{
	if(func_1310A())
	{
		return !scripts\common\utility::flag("stealth_spotted");
	}

	return 0;
}

//Function Number: 68
func_F378(param_00,param_01,param_02)
{
	if(param_01 == "lockon")
	{
		setomnvar("ui_supdrone_reticle_" + param_00 + "_target_ent",param_02);
		setomnvar("ui_supdrone_reticle_" + param_00 + "_lock_state",1);
		scripts\common\utility::func_C0A6(0.05,::setomnvar,"ui_supdrone_reticle_" + param_00 + "_lock_state",0);
		return;
	}

	if(param_01 == "fire")
	{
		setomnvar("ui_supdrone_reticle_" + param_00 + "_lock_state",2);
		scripts\common\utility::func_C0A6(0.05,::setomnvar,"ui_supdrone_reticle_" + param_00 + "_lock_state",0);
		return;
	}

	if(param_01 == "kill")
	{
		setomnvar("ui_supdrone_reticle_" + param_00 + "_lock_state",3);
		scripts\common\utility::func_C0A6(0.05,::setomnvar,"ui_supdrone_reticle_" + param_00 + "_lock_state",0);
		return;
	}

	if(param_01 == "off")
	{
		setomnvar("ui_supdrone_reticle_" + param_00 + "_target_ent",undefined);
		setomnvar("ui_supdrone_reticle_" + param_00 + "_lock_state",0);
		return;
	}
}

//Function Number: 69
func_F377(param_00,param_01)
{
	if(param_01 == "active")
	{
		setomnvarbit("ui_supdrone_bits",param_00,1);
		setomnvar("ui_supdrone_state_" + param_00,1);
		level.player.var_4C29[param_00].var_9A96 = 1;
		level.player scripts\common\utility::func_5127(1.5,::func_F424,param_00);
		return;
	}

	if(param_01 == "destroyed")
	{
		setomnvar("ui_supdrone_state_" + param_00,2);
		scripts\common\utility::func_C0A6(1.5,::setomnvarbit,"ui_supdrone_bits",param_00,0);
		level.player.var_4C29[param_00].var_C7B4 = 1;
		level.player scripts\common\utility::func_5127(1.5,::func_F4B1,param_00);
		return;
	}

	if(param_01 == "noammo")
	{
		setomnvar("ui_supdrone_state_" + param_00,3);
		scripts\common\utility::func_C0A6(1.5,::setomnvarbit,"ui_supdrone_bits",param_00,0);
		level.player.var_4C29[param_00].var_C7B4 = 1;
		level.player scripts\common\utility::func_5127(1.5,::func_F4B1,param_00);
		return;
	}
}

//Function Number: 70
func_5C32(param_00,param_01)
{
	param_01 = scripts\common\utility::func_116D7(param_01 < 0,0,param_01);
	setomnvar("ui_supdrone_ammo_" + param_00,param_01);
}

//Function Number: 71
func_F424(param_00)
{
	level.player.var_4C29[param_00].var_9A96 = 0;
}

//Function Number: 72
func_F4B1(param_00)
{
	level.player.var_4C29[param_00].var_C7B4 = 0;
	level.player.var_4C29[param_00].var_51BA = 1;
}

//Function Number: 73
func_129A()
{
	if(isdefined(level.player.var_5CB3) && level.player.var_5CB3 == 1)
	{
		return "supportdrone_up2";
	}

	return "supportdrone";
}