/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3005.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 15
 * Decompile Time: 13 ms
 * Timestamp: 10/27/2023 12:26:02 AM
*******************************************************************/

//Function Number: 1
main(param_00,param_01,param_02)
{
	lib_0B95::func_31C5("dropship",param_00,param_01,param_02);
	lib_0B95::func_31A6(::func_966B);
	lib_0B95::func_31A3(3000,2800,3100);
	lib_0B95::func_31C4("axis");
	if(issubstr(param_02,"_space"))
	{
		lib_0B95::func_3175(::func_F8A2,::func_F5FC);
	}
	else
	{
		lib_0B95::func_3175(::func_F8A1,::func_F5FC);
	}

	lib_0B95::func_31CC(::func_12BBD);
	lib_0B95::func_3184("vfx/iw7/core/vehicle/dropship/vfx_dropship_death_01.vfx",undefined,"dropship_helicopter_crash",undefined,undefined,undefined,-1,undefined,"stop_crash_loop_sound",10,5);
	lib_0B95::func_31B7("vfx/iw7/core/vehicle/dropship/vfx_dropship_death_01.vfx","tag_body","dropship_helicopter_crash",undefined,undefined,undefined,undefined,1,undefined,0);
	var_03 = "vfx/code/tread/heli_dust_default.vfx";
	lib_0B95::func_31C6(param_02,"default",var_03,0);
	lib_0B95::func_31B8("light_1s",0.12,0.15,3000,0.05,0.05);
	if(issubstr(param_02,"plane"))
	{
		lib_0B95::func_319F();
	}
	else
	{
		lib_0B95::func_31A0();
	}

	if(!issubstr(param_02,"cheap"))
	{
		lib_0B95::func_31C8("sdf_dropship_turret_energy","tag_chin_turret","veh_mil_air_ca_dropship_turret",undefined,"auto_nonai",0,20,-14,undefined);
		lib_0B95::func_31C8("sdf_mg_turret","tag_turret_attach_back","weapon_railgun_turret",undefined,"auto_nonai",0,0,0,undefined,"back");
		lib_0B95::func_31C8("sdf_mg_turret","tag_turret_attach_le","weapon_railgun_turret",undefined,"auto_nonai",0,0,0,undefined,"left");
		lib_0B95::func_31C8("sdf_mg_turret","tag_turret_attach_ri","weapon_railgun_turret",undefined,"auto_nonai",0,0,0,undefined,"right");
		precachemodel("veh_mil_air_ca_dropship_dst_rr");
		precachemodel("veh_mil_air_ca_dropship_dst_fr");
		precachemodel("veh_mil_air_ca_dropship_personnel");
		precachemodel("veh_mil_air_ca_dropship_mount");
		precacheturret("sdf_mg_turret");
	}

	lib_0BBE::func_774E(param_02);
	level.var_7649["engine_damage_feedback"] = loadfx("vfx/iw7/levels/pearl_harbor/dropship_down/vfx_ph_dropship_shoot_engine_impact_amped.vfx");
	level.var_7649["enemy_dropship_engine_death"] = loadfx("vfx/iw7/levels/pearl_harbor/dropship_down/vfx_ph_dropship_shoot_engine_explode.vfx");
	level.var_7649["enemy_dropship_engine_damaged"] = loadfx("vfx/iw7/levels/pearl_harbor/dropship_down/vfx_ph_dropship_shoot_engine_flaming.vfx");
}

//Function Number: 2
func_966B()
{
	self.var_12BBF = 150;
	self.var_12BC1 = 450 + self.var_12BBF;
	self.var_5F80 = 1;
	if(issubstr(self.classname,"cheap"))
	{
		var_00 = ["tag_front_thruster_1_le","tag_front_thruster_2_le","tag_front_thruster_1_ri","tag_front_thruster_2_ri"];
		var_01 = ["tag_back_thruster_1_le","tag_back_thruster_2_le","tag_back_thruster_1_ri","tag_back_thruster_2_ri"];
		var_02 = ["tag_back_thruster_3_le","tag_back_thruster_4_le","tag_back_thruster_3_ri","tag_back_thruster_4_ri"];
		var_03 = scripts\common\utility::array_combine(var_00,var_01);
		var_03 = scripts\common\utility::array_combine(var_03,var_02);
		thread lib_0BBE::func_774B(var_03);
		return;
	}

	var_00 = ["tag_front_thruster_1_le","tag_front_thruster_2_le","tag_front_thruster_1_ri","tag_front_thruster_2_ri"];
	lib_0BBE::func_FA5F("side_front",var_03);
	var_01 = ["tag_back_thruster_1_le","tag_back_thruster_2_le","tag_back_thruster_1_ri","tag_back_thruster_2_ri"];
	lib_0BBE::func_FA5F("side_back",var_03);
	var_02 = ["tag_back_thruster_3_le","tag_back_thruster_4_le","tag_back_thruster_3_ri","tag_back_thruster_4_ri"];
	lib_0BBE::func_FA5F("back",var_03,10);
	thread lib_0BBE::func_774D();
	var_04 = self.var_EEDE;
	if(var_04 == "axis")
	{
		thread lib_0BBE::func_774C();
	}

	thread lib_0BBE::func_5EC8(%vh_dropship_sdf_thrusters_up,%vh_dropship_sdf_thrusters_down);
	if(!issubstr(self.classname,"c6"))
	{
		self attach("veh_mil_air_ca_dropship_personnel","tag_connect");
	}

	thread func_3E7A();
	thread func_101B3();
}

//Function Number: 3
func_3E7A()
{
	self endon("death");
	if(!isdefined(self.var_EEF8))
	{
		self.var_EEF8 = 0;
	}

	wait(0.05);
	self.var_B6BD[0] method_82FB(65);
	self.var_B6BD[0] method_8330(65);
	self.var_B6BD[0] method_8353(65);
	self.var_B6BD[0] method_82B6(65);
	self.var_B6BD[0].var_ED26 = 0.75;
	self.var_B6BD[0].var_ED25 = 1.5;
	self.var_B6BD[0].var_ED50 = 0.25;
	self.var_B6BD[0].var_ED4F = 0.75;
	self.var_B6BD[0].var_ED24 = 0.12;
	self.var_B6BD[0] notify("stop_burst_fire_unmanned");
	self.var_B6BD[0] thread scripts\sp\_mgturret::func_32B7();
}

//Function Number: 4
func_101B3()
{
	wait(0.05);
	foreach(var_01 in self.var_B6BD)
	{
		if(!isdefined(var_01.var_DE46))
		{
			continue;
		}

		var_02 = undefined;
		switch(var_01.var_DE46)
		{
			case "back":
				var_02 = "back";
				break;

			case "left":
				var_02 = "le";
				break;

			case "right":
				var_02 = "ri";
				break;
		}

		var_02 = "tag_turret_mount_" + var_02;
		var_03 = spawn("script_model",self gettagorigin(var_02));
		var_03 linkto(self,var_02,(0,0,0),(0,0,0));
		var_03 setmodel("veh_mil_air_ca_dropship_mount");
	}
}

//Function Number: 5
func_5DB9(param_00)
{
	var_01 = undefined;
	switch(param_00)
	{
		case "right":
			var_01 = %vh_ca_dropship_side_door_r_open;
			break;

		case "left":
			var_01 = %vh_ca_dropship_side_door_l_open;
			break;

		case "back":
			var_01 = %vh_dropship_sdf_rear_doors_open;
			break;
	}

	self method_82A2(var_01);
}

//Function Number: 6
func_5DB7(param_00)
{
	var_01 = undefined;
	var_02 = undefined;
	switch(param_00)
	{
		case "right":
			var_01 = %vh_ca_dropship_side_door_r_open;
			var_02 = %vh_ca_dropship_side_door_r_close;
			break;

		case "left":
			var_01 = %vh_ca_dropship_side_door_l_open;
			var_02 = %vh_ca_dropship_side_door_l_close;
			break;

		case "back":
			var_01 = %vh_dropship_sdf_rear_doors_open;
			var_02 = %vh_dropship_sdf_rear_doors_close;
			break;
	}

	self method_806F(var_01,0.05);
	self method_82A2(var_02);
}

//Function Number: 7
func_F8A1()
{
	var_00 = [];
	for(var_01 = 0;var_01 < 17;var_01++)
	{
		var_00[var_01] = spawnstruct();
		var_00[var_01].var_10220 = "tag_detach";
		var_00[var_01].var_803A = "stand";
		var_00[var_01].var_DC19 = 1;
	}

	var_00[0].var_92CC = %vh_org_dropship_sdf_idle_pilot;
	var_00[1].var_92CC = %vh_org_dropship_sdf_idle_copilot;
	var_00[2].var_92CC = %vh_org_dropship_sdf_unload_guy1_idle;
	var_00[3].var_92CC = %vh_org_dropship_sdf_unload_guy2_idle;
	var_00[4].var_92CC = %vh_org_dropship_sdf_unload_guy3_idle;
	var_00[5].var_92CC = %vh_org_dropship_sdf_unload_guy4_idle;
	var_00[6].var_92CC = %vh_org_dropship_sdf_unload_guy5_idle;
	var_00[7].var_92CC = %vh_org_dropship_sdf_unload_guy6_idle;
	var_00[8].var_92CC = %vh_org_dropship_sdf_unload_guy7_idle;
	var_00[9].var_92CC = %vh_org_dropship_sdf_unload_guy8_idle;
	var_00[10].var_92CC = %vh_org_dropship_sdf_unload_guy9_idle;
	var_00[11].var_92CC = %vh_org_dropship_sdf_unload_guy10_idle;
	var_00[12].var_92CC = %vh_org_dropship_sdf_unload_guy11_idle;
	var_00[13].var_92CC = %vh_org_dropship_sdf_unload_guy12_idle;
	var_00[2].var_8028 = %vh_org_dropship_sdf_unload_jump_guy1;
	var_00[3].var_8028 = %vh_org_dropship_sdf_unload_jump_guy2;
	var_00[4].var_8028 = %vh_org_dropship_sdf_unload_jump_guy3;
	var_00[5].var_8028 = %vh_org_dropship_sdf_unload_jump_guy4;
	var_00[6].var_8028 = %vh_org_dropship_sdf_unload_jump_guy5;
	var_00[7].var_8028 = %vh_org_dropship_sdf_unload_jump_guy6;
	var_00[8].var_8028 = %vh_org_dropship_sdf_unload_jump_guy7;
	var_00[9].var_8028 = %vh_org_dropship_sdf_unload_jump_guy8;
	var_00[2].var_802D = %vh_org_dropship_sdf_unload_jump_loop_guy1;
	var_00[3].var_802D = %vh_org_dropship_sdf_unload_jump_loop_guy2;
	var_00[4].var_802D = %vh_org_dropship_sdf_unload_jump_loop_guy3;
	var_00[5].var_802D = %vh_org_dropship_sdf_unload_jump_loop_guy4;
	var_00[6].var_802D = %vh_org_dropship_sdf_unload_jump_loop_guy5;
	var_00[7].var_802D = %vh_org_dropship_sdf_unload_jump_loop_guy6;
	var_00[8].var_802D = %vh_org_dropship_sdf_unload_jump_loop_guy7;
	var_00[9].var_802D = %vh_org_dropship_sdf_unload_jump_loop_guy8;
	var_00[2].var_802C = %vh_org_dropship_sdf_unload_land_guy1;
	var_00[3].var_802C = %vh_org_dropship_sdf_unload_land_guy2;
	var_00[4].var_802C = %vh_org_dropship_sdf_unload_land_guy3;
	var_00[5].var_802C = %vh_org_dropship_sdf_unload_land_guy4;
	var_00[6].var_802C = %vh_org_dropship_sdf_unload_land_guy5;
	var_00[7].var_802C = %vh_org_dropship_sdf_unload_land_guy6;
	var_00[8].var_802C = %vh_org_dropship_sdf_unload_land_guy7;
	var_00[9].var_802C = %vh_org_dropship_sdf_unload_land_guy8;
	var_00[14].var_B6BD = 1;
	var_00[15].var_B6BD = 2;
	var_00[16].var_B6BD = 3;
	return var_00;
}

//Function Number: 8
func_F8A2()
{
	var_00 = [];
	for(var_01 = 0;var_01 < 15;var_01++)
	{
		var_00[var_01] = spawnstruct();
		var_00[var_01].var_10220 = "tag_detach";
		var_00[var_01].var_803A = "stand";
		var_00[var_01].var_DC19 = 1;
	}

	var_00[0].var_92CC = %vh_org_dropship_sdf_idle_pilot;
	var_00[1].var_92CC = %vh_org_dropship_sdf_idle_copilot;
	var_00[2].var_92CC = %vh_zg_org_dropship_sdf_unload_guy1_idle;
	var_00[3].var_92CC = %vh_zg_org_dropship_sdf_unload_guy2_idle;
	var_00[4].var_92CC = %vh_zg_org_dropship_sdf_unload_guy3_idle;
	var_00[5].var_92CC = %vh_zg_org_dropship_sdf_unload_guy4_idle;
	var_00[6].var_92CC = %vh_zg_org_dropship_sdf_unload_guy5_idle;
	var_00[7].var_92CC = %vh_zg_org_dropship_sdf_unload_guy6_idle;
	var_00[8].var_92CC = %vh_zg_org_dropship_sdf_unload_guy7_idle;
	var_00[9].var_92CC = %vh_zg_org_dropship_sdf_unload_guy8_idle;
	var_00[10].var_92CC = %vh_zg_org_dropship_sdf_unload_guy9_idle;
	var_00[11].var_92CC = %vh_zg_org_dropship_sdf_unload_guy10_idle;
	var_00[12].var_92CC = %vh_zg_org_dropship_sdf_unload_guy11_idle;
	var_00[13].var_92CC = %vh_zg_org_dropship_sdf_unload_guy12_idle;
	var_00[2].var_8028 = %vh_zg_org_dropship_sdf_unload_guy1;
	var_00[3].var_8028 = %vh_zg_org_dropship_sdf_unload_guy2;
	var_00[4].var_8028 = %vh_zg_org_dropship_sdf_unload_guy3;
	var_00[5].var_8028 = %vh_zg_org_dropship_sdf_unload_guy4;
	var_00[6].var_8028 = %vh_zg_org_dropship_sdf_unload_guy5;
	var_00[7].var_8028 = %vh_zg_org_dropship_sdf_unload_guy6;
	var_00[8].var_8028 = %vh_zg_org_dropship_sdf_unload_guy7;
	var_00[9].var_8028 = %vh_zg_org_dropship_sdf_unload_guy8;
	var_00[10].var_8028 = %vh_zg_org_dropship_sdf_unload_guy9;
	var_00[11].var_8028 = %vh_zg_org_dropship_sdf_unload_guy10;
	var_00[12].var_8028 = %vh_zg_org_dropship_sdf_unload_guy11;
	var_00[13].var_8028 = %vh_zg_org_dropship_sdf_unload_guy12;
	return var_00;
}

//Function Number: 9
func_F5FC(param_00)
{
	param_00[2].var_131E6 = %vh_ca_dropship_side_door_l_open;
	param_00[2].var_131E7 = 0;
	param_00[6].var_131E6 = %vh_ca_dropship_side_door_r_open;
	param_00[6].var_131E7 = 0;
	param_00[10].var_131E6 = %vh_dropship_sdf_rear_doors_open;
	param_00[10].var_131E7 = 0;
	return param_00;
}

//Function Number: 10
func_12BBD()
{
	var_00 = [];
	var_01 = "left";
	var_00[var_01] = [];
	var_00[var_01][var_00[var_01].size] = 2;
	var_00[var_01][var_00[var_01].size] = 3;
	var_00[var_01][var_00[var_01].size] = 4;
	var_00[var_01][var_00[var_01].size] = 5;
	var_01 = "right";
	var_00[var_01] = [];
	var_00[var_01][var_00[var_01].size] = 6;
	var_00[var_01][var_00[var_01].size] = 7;
	var_00[var_01][var_00[var_01].size] = 8;
	var_00[var_01][var_00[var_01].size] = 9;
	var_01 = "back";
	var_00[var_01] = [];
	var_00[var_01][var_00[var_01].size] = 10;
	var_00[var_01][var_00[var_01].size] = 11;
	var_00[var_01][var_00[var_01].size] = 12;
	var_00[var_01][var_00[var_01].size] = 13;
	var_01 = "all";
	var_00[var_01] = [];
	var_00[var_01][var_00[var_01].size] = 2;
	var_00[var_01][var_00[var_01].size] = 3;
	var_00[var_01][var_00[var_01].size] = 4;
	var_00[var_01][var_00[var_01].size] = 5;
	var_00[var_01][var_00[var_01].size] = 6;
	var_00[var_01][var_00[var_01].size] = 7;
	var_00[var_01][var_00[var_01].size] = 8;
	var_00[var_01][var_00[var_01].size] = 9;
	var_00[var_01][var_00[var_01].size] = 10;
	var_00[var_01][var_00[var_01].size] = 11;
	var_00[var_01][var_00[var_01].size] = 12;
	var_00[var_01][var_00[var_01].size] = 13;
	var_00["default"] = var_00["all"];
	return var_00;
}

//Function Number: 11
func_5DCE(param_00)
{
	self endon("death");
	self endon("stop_engine_damage_manager");
	scripts\sp\_utility::func_65E0("thruster_near_death");
	scripts\sp\_vehicle::func_8441();
	var_01 = ["j_wing_front_le","j_wing_mid_le","j_wing_front_ri","j_wing_mid_ri"];
	self.var_65CD = [];
	foreach(var_03 in var_01)
	{
		self.var_65CD[var_03] = spawnstruct();
		self.var_65CD[var_03].maxhealth = 1500;
		self.var_65CD[var_03].health = self.var_65CD[var_03].maxhealth;
		self.var_65CD[var_03].var_9BB8 = 0;
		self.var_65CD[var_03].var_5762 = level.var_7649["enemy_dropship_engine_damaged"];
		self.var_65CD[var_03].var_4E26 = level.var_7649["enemy_dropship_engine_death"];
		self.var_65CD[var_03].var_5290 = "frag_grenade_explode";
		if(isdefined(param_00))
		{
			self.var_65CD[var_03].var_4E40 = param_00;
		}

		switch(var_03)
		{
			case "j_wing_mid_ri":
				self.var_65CD[var_03].var_2C40 = "veh_mil_air_ca_dropship_dst_rr";
				self.var_65CD[var_03].var_2C41 = "j_wing_mid_RI";
				self.var_65CD[var_03].var_11867 = ["tag_back_thruster_1_ri","tag_back_thruster_2_ri"];
				break;

			case "j_wing_front_ri":
				self.var_65CD[var_03].var_2C40 = "veh_mil_air_ca_dropship_dst_fr";
				self.var_65CD[var_03].var_2C41 = "j_wing_front_RI";
				self.var_65CD[var_03].var_11867 = ["tag_front_thruster_1_ri","tag_front_thruster_2_ri"];
				break;

			default:
				break;
		}
	}

	for(;;)
	{
		self waittill("damage",var_05,var_06,var_07,var_08,var_07,var_07,var_07,var_09,var_07,var_0A);
		if((isdefined(var_06) && isplayer(var_06)) || isdefined(var_06) && isdefined(level.var_A351) && var_06 == level.var_A351)
		{
			func_D973(var_09,var_05,var_08);
		}
	}
}

//Function Number: 12
func_D973(param_00,param_01,param_02)
{
	if(isdefined(level.var_5D81) && isdefined(level.var_5D81.var_24C0))
	{
		level.var_5D81.var_24C0 = level.var_5D81.var_24C0 - 0.15;
	}

	if(isdefined(param_00) && !isdefined(self.var_65CD[param_00]))
	{
		return;
	}

	if(!isdefined(param_00) && !isdefined(param_01))
	{
		return;
	}

	thread scripts\sp\_damagefeedback::func_B9C6();
	if(isdefined(param_02))
	{
		playfx(level.var_7649["engine_damage_feedback"],param_02);
	}

	self.var_65CD[param_00].health = self.var_65CD[param_00].health - param_01;
	if(getdvarint("debug_engine_dmg"))
	{
	}

	if(self.var_65CD[param_00].health < 1)
	{
		if(getdvarint("debug_engine_dmg"))
		{
		}

		func_A5DA(param_00);
		return;
	}

	if(self.var_65CD[param_00].health <= self.var_65CD[param_00].maxhealth * 0.75 && !isdefined(self.var_65CD[param_00].var_9DA7))
	{
		if(getdvarint("debug_engine_dmg"))
		{
		}

		self.var_65CD[param_00].var_9DA7 = 1;
		playfxontag(level.var_7649["enemy_dropship_engine_damaged"],self,param_00);
		if(isdefined(self.var_65CD[param_00].var_11867))
		{
			lib_0BBE::func_A61E(self.var_65CD[param_00].var_11867);
			return;
		}

		return;
	}

	if(self.var_65CD[param_00].health <= self.var_65CD[param_00].maxhealth * 0.25 && !scripts\sp\_utility::func_65DB("thruster_near_death"))
	{
		scripts\sp\_utility::func_65E1("thruster_near_death");
		return;
	}
}

//Function Number: 13
func_A5DA(param_00)
{
	if(self.var_65CD[param_00].var_9BB8)
	{
		return;
	}

	self.var_65CD[param_00].var_9BB8 = 1;
	if(isdefined(self.var_65CD[param_00].var_2C40) && isdefined(self.var_65CD[param_00].var_2C41))
	{
		self.var_65CD[param_00].var_9BB8 = 1;
		var_01 = spawn("script_model",self gettagorigin(self.var_65CD[param_00].var_2C41));
		var_01 linkto(self,self.var_65CD[param_00].var_2C41,(0,0,0),(0,0,0));
		var_01 setmodel(self.var_65CD[param_00].var_2C40);
		thread scripts\common\utility::func_5179(var_01);
	}

	playfxontag(level.var_7649["enemy_dropship_engine_death"],self,param_00);
	if(isdefined(self.var_65CD[param_00].var_5290))
	{
		function_0178(self.var_65CD[param_00].var_5290,self gettagorigin(param_00));
	}

	if(!isdefined(self.var_65CD[param_00].var_4E40))
	{
		return;
	}

	var_02 = 0;
	if(isdefined(self.var_B73F))
	{
		var_03 = 0;
		foreach(var_05 in self.var_65CD)
		{
			if(var_05.var_9BB8)
			{
				var_03++;
			}
		}

		if(var_03 >= self.var_B73F)
		{
			var_02 = 1;
		}
		else
		{
			thread func_101AF();
		}
	}
	else
	{
		var_02 = 1;
	}

	if(var_02)
	{
		self thread [[ self.var_65CD[param_00].var_4E40 ]]();
	}
}

//Function Number: 14
func_CD70(param_00,param_01,param_02)
{
	self notify("custom_death_begin");
	self.var_1FEB = scripts\common\utility::spawn_tag_origin();
	self linkto(self.var_1FEB);
	var_03 = undefined;
	if(isstring(param_01))
	{
		var_03 = getanimlength(level.var_EC85[self.var_1FBB][param_01]);
		self.var_1FEB thread lib_0B06::func_1F35(self,param_01);
	}
	else
	{
		var_03 = getanimlength(param_01);
		self method_8018("single anim",self.origin,self.angles,param_01);
	}

	if(!isdefined(param_02))
	{
		param_02 = var_03;
	}

	if(getdvarint("debug_engine_dmg"))
	{
		thread scripts\sp\_utility::func_5B51(param_00.origin,self,1,0,0,var_03);
	}

	self.var_1FEB moveto(param_00.origin,param_02);
	self.var_1FEB rotateto(param_00.angles,param_02);
	wait(var_03);
	self.var_1FEB delete();
	self notify("custom_death_end");
}

//Function Number: 15
func_101AF()
{
	if(isdefined(self.var_9BC0))
	{
		return;
	}

	self.var_9BC0 = 1;
	var_00 = 200;
	var_01 = self.angles;
	var_01 = (0,var_01[1],0);
	var_02 = anglestoright(var_01);
	var_03 = var_02 * var_00;
	var_04 = self.origin + var_03;
	var_05 = undefined;
	if(!isdefined(self.var_A8AC))
	{
		if(randomint(100) < 50)
		{
			self.var_A8AC = "left";
		}
		else
		{
			self.var_A8AC = "right";
		}
	}

	if(bullettracepassed(self.origin,var_04,0,self) && self.var_A8AC == "left")
	{
		self.var_A8AC = "right";
		var_05 = var_04;
	}
	else
	{
		var_03 = var_03 * -1;
		var_04 = self.origin + var_03;
		if(bullettracepassed(self.origin,var_04,0,self))
		{
			self.var_A8AC = "left";
			var_05 = var_04;
		}
	}

	if(!isdefined(var_05))
	{
		self.var_9BC0 = undefined;
		return;
	}

	var_06 = self.origin;
	self method_8362(var_05 + (0,0,100));
	self method_83E5(60,50,10);
	wait(3);
	self method_8362(var_06,1);
	self method_83E5(50,25,25);
	self.var_9BC0 = undefined;
}