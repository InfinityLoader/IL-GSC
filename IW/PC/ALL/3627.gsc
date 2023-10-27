/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3627.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 24
 * Decompile Time: 8 ms
 * Timestamp: 10/27/2023 12:30:57 AM
*******************************************************************/

//Function Number: 1
func_C32F()
{
	precacheitem("offhandshield");
	precacheitem("offhandshield_up1");
	precachestring(&"EQUIPMENT_SHIELD_MELEE_HINT");
	level.player scripts\sp\_utility::func_65E0("player_retract_shield_active");
	level.player.var_C337 = spawnstruct();
	level.player.var_C337.var_260E = 0;
	level.player.var_C337.var_19 = 0;
	level.player.var_C337.var_9936 = 0;
	level.player.var_C337.var_B620 = 0;
	level.var_7649["shield_ping"] = loadfx("vfx/iw7/core/equipment/offhandshield/vfx_shield_ping.vfx");
	scripts\sp\_utility::func_9187("shield",200,::func_FC8B);
	level.player.var_C337.var_CB8F = spawnstruct();
	level.player.var_C337.var_CB8F.var_190 = 5;
	level.player.var_C337.var_CB8F.var_56E8 = getdvarint("offhandshield_sweepRange");
	level.player.var_C337.var_CB8F.time = getdvarint("offhandshield_sweepTime");
	level.player.var_C337.var_CB8F.var_2B3 = level.player.var_C337.var_CB8F.var_56E8 / level.player.var_C337.var_CB8F.time;
	level.var_6DD1 = 1;
	scripts\sp\_utility::func_16EB("shield_recharge",&"WEAPON_HELP_SHIELD_RECHARGE");
	scripts\sp\_utility::func_16EB("shield_recharge_remind",&"WEAPON_HELP_SHIELD_RECHARGE");
}

//Function Number: 2
func_C334()
{
	self endon("death");
	self endon("secondary_equipment_change");
	childthread func_C330();
	childthread func_DDD3();
	childthread func_DDD4();
	thread offhand_shield_unequip_think();
	for(;;)
	{
		self waittill("offhandshield_deploy");
		if(scripts\common\utility::istrue(self.var_9DD2) || scripts\common\utility::istrue(self.var_939E))
		{
			wait(0.05);
			continue;
		}

		thread on_deploy();
		self waittill("offhandshield_retract");
		if(scripts\sp\_utility::func_65DB("player_retract_shield_active"))
		{
			thread on_retract();
		}
	}
}

//Function Number: 3
offhand_shield_unequip_think()
{
	self endon("death");
	self waittill("secondary_equipment_change");
	if(scripts\sp\_utility::func_65DB("player_retract_shield_active"))
	{
		thread on_retract();
	}
}

//Function Number: 4
on_deploy()
{
	self endon("offhandshield_on_retract");
	self notify("offhandshield_on_deploy");
	scripts\common\utility::func_1C6E(0);
	thread func_DBE4();
	scripts\sp\_utility::func_65E1("player_retract_shield_active");
	scripts\common\utility::flag_set("secondary_equipment_in_use");
	level.player.var_C337.var_19 = 1;
	setomnvar("ui_offhandshield_in_use",1);
	setomnvar("ui_wrist_pc",6);
	if(!level.player.var_C337.var_9936)
	{
		function_01C5("offhandShield_outlineMode",2);
		thread func_CB92();
	}
	else
	{
		function_01C5("offhandShield_outlineMode",1);
	}

	thread func_C32D(1);
	scripts\sp\_utility::func_1C49(0);
	level.player thread scripts\anim\battlechatter_ai::func_67CF("offhandshield");
	wait(0.2);
	thread scripts\sp\_utility::func_9199("shield",1);
	wait(0.4);
	thread func_B594();
}

//Function Number: 5
on_retract()
{
	self endon("offhandshield_on_deploy");
	self notify("offhandshield_on_retract");
	level.player.var_C337.var_19 = 0;
	thread func_C32D(0);
	scripts\sp\_utility::func_65DD("player_retract_shield_active");
	scripts\common\utility::func_6E2A("secondary_equipment_in_use");
	scripts\sp\_utility::func_1C49(1);
	setomnvar("ui_offhandshield_in_use",0);
	setomnvar("ui_wrist_pc",1);
	scripts\common\utility::func_1C6E(1);
	wait(0.15);
	scripts\sp\_utility::func_9199("shield",0);
}

//Function Number: 6
func_DBE4()
{
	self endon("offhandshield_on_retract");
	for(;;)
	{
		self waittill("melee");
		thread scripts\sp\_detonategrenades::func_DBDB(self geteye() + anglestoforward(self getplayerangles()) * 25,0.098);
	}
}

//Function Number: 7
func_DDD3()
{
	if(isdefined(level.player.var_C337.var_54C2))
	{
		return;
	}

	while(level.player method_84D0() > getdvarfloat("offhandshield_minenergyfordeploy"))
	{
		wait(0.15);
	}

	scripts\sp\_utility::func_56BE("shield_recharge",3);
	level.player.var_C337.var_54C2 = 1;
}

//Function Number: 8
func_DDD4()
{
	for(;;)
	{
		level.player waittill("secondary_equipment_pressed");
		if(level.player method_84D0() < getdvarfloat("offhandshield_minenergyfordeploy"))
		{
			scripts\sp\_utility::func_56BE("shield_recharge_remind",3);
			wait(3);
		}
	}
}

//Function Number: 9
func_B594()
{
	if(!level.player.var_C337.var_19)
	{
		return;
	}

	if(isdefined(level.player.var_C337.var_28B5))
	{
		return;
	}

	if(level.player.var_C337.var_B620 > 5)
	{
		return;
	}

	level.player.var_C337.var_B620++;
	level.player.var_C337.var_28B5 = 1;
	var_00 = scripts\sp\_hud_util::createfontstring("objective",1.25);
	var_00 scripts\sp\_hud_util::setpoint("CENTER",undefined,0,116);
	var_00.alpha = 1;
	var_00 settext(&"EQUIPMENT_SHIELD_MELEE_HINT");
	func_13746(1);
	var_01 = 0.25;
	var_00 fadeovertime(var_01);
	var_00.alpha = 0;
	wait(var_01);
	var_00 destroy();
	level.player.var_C337.var_28B5 = undefined;
}

//Function Number: 10
func_13746(param_00)
{
	self endon("offhandshield_retract");
	wait(param_00);
}

//Function Number: 11
func_C330()
{
	var_00 = level.player method_84CF() * 0.25;
	for(;;)
	{
		var_01 = level.player method_84D0();
		if(var_01 <= var_00 && self.var_C337.var_19)
		{
			thread scripts\common\utility::func_CD7F("retract_shield_energy_alarm");
			childthread func_C339(var_00);
			while(self method_84D0() < var_00 && self.var_C337.var_19)
			{
				wait(0.05);
			}

			self notify("stop soundretract_shield_energy_alarm");
		}

		wait(0.05);
	}
}

//Function Number: 12
func_C339(param_00)
{
	if(isdefined(self.var_C337.var_FC8E))
	{
		return;
	}

	self.var_C337.var_FC8E = 1;
	while(self method_84D0() < param_00)
	{
		wait(0.05);
	}

	scripts\sp\_utility::func_CE2F("retract_shield_ready");
	self.var_C337.var_FC8E = undefined;
}

//Function Number: 13
func_C32D(param_00)
{
	if(param_00 && !level.player.var_C337.var_260E)
	{
		level.player.var_C337.var_260E = 1;
		level.player thread scripts\common\utility::func_CD7F("retract_shield_energy_hum");
		return;
	}

	if(!param_00 && level.player.var_C337.var_260E)
	{
		level.player.var_C337.var_260E = 0;
		level.player notify("stop soundretract_shield_energy_hum");
	}
}

//Function Number: 14
func_CB92(param_00)
{
	self endon("offhandshield_retract");
	var_01 = 1;
	var_02 = [];
	wait(0.15);
	for(;;)
	{
		level.player.var_C337.var_CB8F.var_190 = 5;
		var_02 = scripts\common\utility::func_22AC(var_02,var_02);
		var_03 = function_0072();
		if(isdefined(level.player.var_C337.var_6A48))
		{
			var_03 = scripts\common\utility::array_combine(var_03,level.var_C337.var_6A48);
		}

		foreach(var_05 in var_03)
		{
			var_06 = distance(var_05.origin,self.origin);
			if(var_06 > level.player.var_C337.var_CB8F.var_56E8)
			{
				var_03 = scripts\common\utility::func_22A9(var_03,var_05);
				continue;
			}

			if(var_05.ignoreme)
			{
				var_03 = scripts\common\utility::func_22A9(var_03,var_05);
				continue;
			}

			var_05.var_D028 = var_06;
		}

		if(!var_03.size)
		{
			wait(level.player.var_C337.var_CB8F.var_190);
			continue;
		}

		var_08 = scripts\sp\_utility::func_78BB(self.origin,var_03,level.player.var_C337.var_CB8F.var_56E8);
		var_09 = scripts\sp\_utility::func_79B3(self.origin,var_03);
		var_0A = distance2d(level.player.origin,var_08.origin) / level.player.var_C337.var_CB8F.var_2B3;
		if(!isdefined(var_08))
		{
			wait(level.player.var_C337.var_CB8F.var_190);
			continue;
		}

		if(var_08.var_D028 <= level.player.var_C337.var_CB8F.var_56E8)
		{
			if(var_08.var_D028 <= level.player.var_C337.var_CB8F.time * 0.5)
			{
				level.player.var_C337.var_CB8F.var_190 = level.player.var_C337.var_CB8F.var_190 * 0.5;
			}
			else if(var_08.var_D028 <= level.player.var_C337.var_CB8F.time * 0.75)
			{
				level.player.var_C337.var_CB8F.var_190 = level.player.var_C337.var_CB8F.var_190 * 0.75;
			}
		}

		if(level.player.var_C337.var_CB8F.var_190 < var_01)
		{
			level.player.var_C337.var_CB8F.var_190 = var_01;
		}

		if(var_03.size && level.var_6DD1)
		{
			level.var_6DD1 = 0;
			level notify("first_pinged_ents");
		}

		func_5A5F();
		scripts\common\utility::array_thread([var_08,var_09],::func_CB94,level.player.var_C337.var_CB8F.var_2B3);
		var_0B = 1;
		var_0C = level.player.var_C337.var_CB8F.var_190 - var_0B;
		if(var_0C > var_0B)
		{
			wait(var_0C);
			continue;
		}

		wait(var_0B);
	}
}

//Function Number: 15
func_5A5F()
{
	thread scripts\sp\_utility::func_CE2F("retract_shield_tracker_pulse");
	self method_854F();
}

//Function Number: 16
func_CB94(param_00)
{
	self endon("death");
	var_01 = distance2d(level.player.origin,self.origin) / param_00;
	var_01 = var_01 / 1000;
	wait(var_01);
	thread func_CB95(var_01);
}

//Function Number: 17
func_CB95(param_00)
{
	if(!isalive(self))
	{
		return;
	}

	var_01 = lib_0B4D::func_C097(0.1,1,param_00);
	var_02 = lib_0B4D::func_6A8E(1.1,0.8,var_01);
	if(issentient(self))
	{
		var_03 = self geteye();
	}
	else
	{
		var_03 = self.origin;
	}

	var_04 = spawn("script_origin",var_03);
	var_04 playsound("retract_shield_tracker_3d_target","sounddone");
	var_04 method_8277(var_02);
	var_04 waittill("sounddone");
	var_04 delete();
}

//Function Number: 18
func_C76C(param_00,param_01)
{
	self endon("death");
	if(isdefined(param_01))
	{
		wait(param_01);
	}

	var_02 = function_0072();
	var_03 = function_00C8();
	if(param_00)
	{
		scripts\common\utility::array_thread(var_02,::func_C76A);
		if(var_03.size)
		{
			scripts\sp\_utility::func_22C7(var_03,::func_C76A);
			return;
		}

		return;
	}

	scripts\common\utility::array_thread(var_02,::func_C769);
	if(var_03.size)
	{
		scripts\common\utility::array_thread(var_03,::scripts\sp\_utility::func_E08B,::func_C76A);
	}
}

//Function Number: 19
func_C76A()
{
	if(isdefined(self.var_FC9D))
	{
		return;
	}

	self.var_FC9D = 1;
	if(isdefined(self.team) && self.team == "allies")
	{
		scripts\sp\_utility::func_9196(3,0,1,"shield");
		return;
	}

	scripts\sp\_utility::func_9196(1,0,1,"shield");
}

//Function Number: 20
func_C769()
{
	self.var_FC9D = undefined;
	scripts\sp\_utility::func_9193("shield");
	self notify("shield_hudoutline_off");
}

//Function Number: 21
func_C77F()
{
	function_01C5("r_hudoutlineWidth","1");
	function_01C5("r_hudoutlineFillColor0","0.8 0.8 0.8 1");
	function_01C5("r_hudoutlineOccludedOutlineColor","0.8 0.8 0.8 1");
	function_01C5("r_hudoutlineOccludedInteriorColor","0.5 0.5 0.5 1");
	function_01C5("r_hudoutlineOccludedInlineColor","0.5 0.5 0.5 1");
	function_01C5("r_hudoutlineFillColor1","0.8 0.8 0.8 .2");
	function_01C5("r_hudOutlineOccludedColorFromFill","1");
}

//Function Number: 22
func_FC8B()
{
	var_00 = [];
	var_00["r_hudoutlineWidth"] = 1;
	var_00["r_hudoutlineFillColor1"] = "0 0 0 1";
	var_00["r_hudoutlineFillColor0"] = "0.8 0.8 0.8 1";
	var_00["r_hudoutlineOccludedOutlineColor"] = "0.8 0.8 0.8 1";
	var_00["r_hudoutlineOccludedInteriorColor"] = "0.5 0.5 0.5 .2";
	var_00["r_hudoutlineOccludedInlineColor"] = "0.5 0.5 0.5 .5";
	var_00["r_hudoutlineFillColor1"] = "0.8 0.8 0.8 .2";
	var_00["r_hudOutlineOccludedColorFromFill"] = 1;
	return var_00;
}

//Function Number: 23
func_C780(param_00)
{
	func_AB81(1);
	if(isdefined(param_00))
	{
		wait(param_00);
	}

	func_AB81(0);
}

//Function Number: 24
func_AB81(param_00)
{
	var_01 = scripts\common\utility::func_116D7(param_00,0.1,1);
	var_02 = 0.05;
	var_03 = "0.8 0.8 0.8 ";
	var_04 = "0.5 0.5 0.5 ";
	for(var_05 = 1;var_05 < 11;var_05++)
	{
		function_01C5("r_hudoutlineFillColor0",var_03 + var_01 + "");
		function_01C5("r_hudoutlineOccludedOutlineColor",var_03 + var_01 + "");
		function_01C5("r_hudoutlineOccludedInteriorColor",var_04 + var_01 + "");
		if(param_00 && var_05 < 2)
		{
			function_01C5("r_hudoutlineFillColor1",var_03 + var_01 + "");
		}
		else if(!param_00 && var_05 > 2)
		{
			function_01C5("r_hudoutlineFillColor1",var_03 + var_01 + "");
		}

		function_01C5("r_hudoutlineOccludedInlineColor",var_04 + var_01 + "");
		if(param_00)
		{
			var_01 = scripts\common\utility::func_116D7(var_05 == 9,1,var_01 + 0.1);
		}
		else
		{
			var_01 = scripts\common\utility::func_116D7(var_05 == 9,0,var_01 - 0.1);
		}

		wait(var_02);
	}

	wait(var_02);
}