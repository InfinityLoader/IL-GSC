/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3663.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 20
 * Decompile Time: 6 ms
 * Timestamp: 10/27/2023 12:31:02 AM
*******************************************************************/

//Function Number: 1
func_9755(param_00)
{
	if(!level.player scripts\sp\_utility::func_65DF("pressurized"))
	{
		level.player scripts\sp\_utility::func_65E0("pressurized");
	}

	if(!level.player scripts\sp\_utility::func_65DF("player_gravity_off"))
	{
		level.player scripts\sp\_utility::func_65E0("player_gravity_off");
	}

	if(!level.player scripts\sp\_utility::func_65DF("player_space_override_off"))
	{
		level.player scripts\sp\_utility::func_65E0("player_space_override_off");
	}

	if(!isdefined(param_00) || !param_00)
	{
		function_01C5("player_spaceViewHeight",60);
		function_01C5("player_spaceCapsuleHeight",70);
	}

	if(!isdefined(level.player.var_2A6))
	{
		level.player.var_2A6 = spawnstruct();
	}

	level.player.var_2A6.var_6F43 = 0;
}

//Function Number: 2
func_9756()
{
	lib_0E4A::func_84BB();
}

//Function Number: 3
func_5570(param_00)
{
	func_9755(1);
	if(param_00 == 1)
	{
		level.player scripts\sp\_utility::func_65E1("player_space_override_off");
		return;
	}

	level.player scripts\sp\_utility::func_65DD("player_space_override_off");
}

//Function Number: 4
func_9C7B()
{
	func_9755(1);
	if(level.player scripts\sp\_utility::func_65DB("player_space_override_off"))
	{
		return 0;
	}

	if(!level.player scripts\sp\_utility::func_65DB("player_gravity_off"))
	{
		return 0;
	}

	return 1;
}

//Function Number: 5
func_622C(param_00,param_01)
{
	func_9755();
	if(level.player scripts\sp\_utility::func_65DB("player_space_override_off"))
	{
		return;
	}

	level.player.var_2A6.var_6F43 = 1;
	level.player scripts\sp\_utility::func_65E1("player_gravity_off");
	level.var_7684 = ::lib_0E50::func_225;
	if(!isdefined(param_00) || param_00)
	{
		level.player thread lib_0E47::func_4D8A();
	}

	if(!isdefined(param_01) || param_01)
	{
		level.player thread lib_0E4A::func_84BA();
	}

	level.player thread lib_0E50::func_CF84();
	level.player thread func_853A();
}

//Function Number: 6
func_556F()
{
	level.player scripts\sp\_utility::func_65DD("player_gravity_off");
}

//Function Number: 7
func_40A6()
{
	level notify("disable_space");
	level.player notify("disable_space");
	level.player func_552C();
	level.var_7684 = undefined;
}

//Function Number: 8
func_6251()
{
	function_01C5("bg_viewBobAmplitudeDucked",0);
	function_01C5("bg_viewBobAmplitudeDuckedAds",0);
	function_01C5("bg_viewBobAmplitudeSprinting",0);
	function_01C5("bg_viewBobAmplitudeStanding",0);
	function_01C5("bg_viewBobAmplitudeStandingAds",0);
	function_01C5("bg_viewBobMax",0);
	function_01C5("bg_weaponBobAmplitudeBase",0);
	function_01C5("bg_weaponBobAmplitudeDucked","0.0 0.0");
	function_01C5("bg_weaponBobAmplitudeSprinting","0.0 0.0");
	function_01C5("bg_weaponBobAmplitudeStanding","0.0 0.0");
	function_01C5("bg_sprintLoopTimeScale",4);
	self method_82B5(5);
}

//Function Number: 9
func_559D()
{
	function_01C5("bg_viewBobAmplitudeDucked",0.0075);
	function_01C5("bg_viewBobAmplitudeDuckedAds",0.0075);
	function_01C5("bg_viewBobAmplitudeSprinting",0.014);
	function_01C5("bg_viewBobAmplitudeStanding",0.007);
	function_01C5("bg_viewBobAmplitudeStandingAds",0.0075);
	function_01C5("bg_viewBobMax",8);
	function_01C5("bg_weaponBobAmplitudeBase",0.16);
	function_01C5("bg_weaponBobAmplitudeDucked","0.045 0.025");
	function_01C5("bg_weaponBobAmplitudeSprinting","0.02 0.014");
	function_01C5("bg_weaponBobAmplitudeStanding","0.055 0.025");
	function_01C5("bg_sprintLoopTimeScale",1);
	self method_82B5(1);
}

//Function Number: 10
func_621C(param_00)
{
	function_01C5("cg_footsteps",0);
	function_01C5("cg_equipmentSounds",0);
	function_01C5("cg_landingSounds",0);
	function_01C5("player_spaceEnabled","1");
	level.player scripts\common\utility::func_1C42(0);
	level.var_104DA = 500;
	level.var_104D9 = 500;
	level.var_1050D = 125;
	level.var_1050E = 125;
	level.var_104AE = 750;
	level.var_104AF = 750;
	level.var_10514 = 500;
	level.var_10515 = 125;
	level.var_10516 = 125;
	level.var_10513 = 750;
	level.var_10510 = 1.6;
	function_01C5("player_swimFriction",level.var_104DA);
	function_01C5("player_swimAcceleration",level.var_104AE);
	function_01C5("player_swimVerticalFriction",level.var_10514);
	function_01C5("player_swimVerticalSpeed",level.var_10515);
	function_01C5("player_swimVerticalAcceleration",level.var_10513);
	function_01C5("player_swimSpeed",level.var_1050D);
	function_01C5("player_sprintSpeedScale",level.var_10510);
	self method_800E(0);
	self method_8014(1);
	self setviewkickscale(0.6);
	thread func_8B3A();
	thread func_93E9();
	thread func_13E97();
}

//Function Number: 11
func_5558()
{
	level notify("disable_space");
	self notify("disable_space");
	function_01C5("cg_footsteps",1);
	function_01C5("cg_equipmentSounds",1);
	function_01C5("cg_landingSounds",1);
	function_01C5("player_spaceEnabled","0");
	function_01C5("player_sprintSpeedScale",1.4);
	function_01C5("player_swimFriction",30);
	function_01C5("player_swimAcceleration",100);
	function_01C5("player_swimVerticalFriction",40);
	function_01C5("player_swimVerticalSpeed",120);
	function_01C5("player_swimVerticalAcceleration",160);
	function_01C5("player_swimSpeed",80);
	function_01C5("player_sprintUnlimited","1");
	function_01C5("player_swimWaterCurrent",(0,0,0));
	self method_800E(1);
	self method_8014(0);
	scripts\common\utility::func_1C42(1);
	if(isdefined(self.var_286F))
	{
		self.var_50 = self.var_286F;
	}

	if(isdefined(self.var_13E97))
	{
		self.var_13E97 delete();
	}
}

//Function Number: 12
func_853A()
{
	self.var_2A6.var_6F43 = 0;
	self.var_2A6.var_6F43 = 1;
	func_61FA();
	while(func_9C7B())
	{
		wait(0.05);
	}

	func_40A6();
	if(isdefined(level.player.var_9BF5))
	{
		while(level.player.var_9BF5 == 1)
		{
			scripts\common\utility::func_136F7();
		}
	}

	if(isdefined(self.var_849A))
	{
		level.player thread lib_0E4A::func_84B9();
	}
}

//Function Number: 13
func_61FA()
{
	self method_80D8(0.8,0.8);
	func_6251();
	func_621C();
	lib_0E50::func_6247();
}

//Function Number: 14
func_552C()
{
	self method_80A6();
	func_559D();
	func_5558();
	lib_0E50::func_5593();
}

//Function Number: 15
func_37FE()
{
	if(self isonground())
	{
		return 1;
	}

	return 0;
}

//Function Number: 16
func_9399()
{
	return level.player scripts\sp\_utility::func_65DB("in_gravity");
}

//Function Number: 17
func_8B3A()
{
	self endon("death");
	self endon("disable_space");
	self.var_286F = self.var_50;
	for(;;)
	{
		var_00 = getdvarfloat("player_sprintSpeedScale",1.4);
		var_01 = getdvarfloat("player_swimSpeed",level.var_1050D);
		var_02 = length(self getvelocity());
		self.var_50 = self.var_286F;
		if(var_02 >= var_01 * 0.99)
		{
			self.var_50 = 0.4 * self.var_286F;
			if(var_02 >= var_01 * var_00)
			{
				self.var_50 = 0.15 * self.var_286F;
			}
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 18
func_93E9()
{
	self endon("death");
	self endon("disable_space");
	for(;;)
	{
		var_00 = level.player.origin + (0,0,25);
		var_01 = !scripts\common\trace::func_109DF(level.player.origin,level.player.origin,60,level.player);
		if(var_01)
		{
			thread scripts\sp\_utility::func_AB9A("player_swimFriction",level.var_104D9,0.1);
			thread scripts\sp\_utility::func_AB9A("player_swimSpeed",level.var_1050D,1);
			thread scripts\sp\_utility::func_AB9A("player_swimAcceleration",level.var_104AE,0.1);
			thread scripts\sp\_utility::func_AB9A("player_swimVerticalSpeed",level.var_10515,0.1);
		}
		else
		{
			thread scripts\sp\_utility::func_AB9A("player_swimFriction",level.var_104DA,0.1);
			thread scripts\sp\_utility::func_AB9A("player_swimSpeed",level.var_1050E,1);
			thread scripts\sp\_utility::func_AB9A("player_swimAcceleration",level.var_104AF,0.1);
			thread scripts\sp\_utility::func_AB9A("player_swimVerticalSpeed",level.var_10516,0.1);
		}

		wait(0.25);
	}
}

//Function Number: 19
func_13E97()
{
	self endon("disable_space");
	if(!isdefined(level.var_EC8C["player_body"]))
	{
		return;
	}

	self.var_13E97 = lib_0B62::func_7B88();
	self.var_13E97 method_81E4(self,"tag_origin",(-12,0,-58),(-4,0,0),1,0,0,0);
	for(;;)
	{
		var_00 = self getnormalizedmovement();
		var_01 = 0.75;
		var_02 = 0.5;
		if(var_00[0] >= 0)
		{
			var_03 = var_00[0];
			var_03 = var_03 * var_03;
			self.var_13E97 method_806F(%space_playerbody_idle_b,var_01);
			self.var_13E97 method_82A2(%space_playerbody_idle_f,var_03,var_01);
			self.var_13E97 method_82A2(%space_playerbody_idle,1 - var_03,var_01);
		}
		else
		{
			var_03 = abs(var_00[0]);
			var_03 = var_03 * var_03;
			var_04 = func_EBAB();
			var_05 = max(var_02,var_04);
			var_03 = var_04 * var_03;
			self.var_13E97 method_806F(%space_playerbody_idle_f,var_01 * var_05);
			self.var_13E97 method_82A2(%space_playerbody_idle_b,var_03,var_01 * var_05);
			self.var_13E97 method_82A2(%space_playerbody_idle,1 - var_03,var_01 * var_05);
		}

		if(var_00[1] >= 0)
		{
			var_03 = var_00[1];
			var_03 = var_03 * var_03;
			var_04 = func_EBAB();
			var_05 = max(var_02,var_04);
			var_03 = var_04 * var_03;
			self.var_13E97 method_806F(%space_playerbody_idle_r,var_01 * var_05);
			self.var_13E97 method_82A2(%space_playerbody_idle_l,var_03,var_01 * var_05);
		}
		else
		{
			var_03 = abs(var_00[1]);
			var_03 = var_03 * var_03;
			var_04 = func_EBAB();
			var_05 = max(var_02,var_04);
			var_03 = var_04 * var_03;
			self.var_13E97 method_806F(%space_playerbody_idle_l,var_01 * var_05);
			self.var_13E97 method_82A2(%space_playerbody_idle_r,var_03,var_01 * var_05);
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 20
func_EBAB(param_00)
{
	var_01 = self getplayerangles();
	var_02 = var_01[0];
	if(var_02 > 0)
	{
		if(!isdefined(param_00))
		{
			param_00 = 75;
		}

		var_03 = 1 - min(param_00,var_02) / param_00;
		return max(var_03,0.1);
	}

	return 1;
}