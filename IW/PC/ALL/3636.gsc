/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3636.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 16
 * Decompile Time: 6 ms
 * Timestamp: 10/27/2023 12:30:58 AM
*******************************************************************/

//Function Number: 1
func_2A2D()
{
	func_2A30();
	level.player.var_2A23 = 100;
	level.player.var_2A2E = 0;
	level.player.var_4BDD = 0;
	var_00 = function_00C9("axis");
	scripts\sp\_utility::func_22C7(var_00,::func_2A32);
	level.player thread func_2A35();
}

//Function Number: 2
func_2A30()
{
	level._effect["beam_rifle_beam"] = loadfx("vfx/iw7/_requests/europa/vfx_beam_rifle_beam");
	level._effect["beam_rifle_decal"] = loadfx("vfx/old/_requests/future_weapons/vfx_beam_rifle_impact_decal");
	level._effect["beam_rifle_fire"] = loadfx("vfx/old/_requests/future_weapons/vfx_beam_rifle_fire");
	level._effect["beam_rifle_smoke"] = loadfx("vfx/old/_requests/future_weapons/vfx_beam_rifle_smoke");
	level._effect["beam_rifle_ammo"] = loadfx("vfx/iw7/_requests/europa/vfx_beam_rifle_ammo");
	level._effect["beam_rifle_robot_explosion"] = loadfx("vfx/iw7/_requests/europa/vfx_beam_rifle_robot_explode.vfx");
	precacheshader("alien_icon_craft_battery");
	precacheitem("iw7_steeldragon");
}

//Function Number: 3
func_2A35()
{
	self endon("death");
	var_00 = 0.35;
	for(;;)
	{
		scripts\common\utility::waittill_any_3("weapon_change","weapon_dropped");
		if(issubstr(level.player getcurrentweapon(),"iw7_steeldragon"))
		{
			scripts\common\utility::func_136F7();
			self method_800C(0);
			var_01 = func_2A2B();
			var_02 = gettime();
			var_03 = 0;
			while(gettime() - var_02 < var_00 * 1000)
			{
				if(!issubstr(level.player getcurrentweapon(),"iw7_steeldragon"))
				{
					var_03 = 1;
					break;
				}

				wait(0.05);
			}

			var_00 = 1.4;
			if(!var_03)
			{
				func_2A33(var_01);
			}

			func_2A2C(var_01);
			self method_800C(1);
		}
	}
}

//Function Number: 4
func_2A2B()
{
	setdvar("hideHudFast",1);
	setomnvar("ui_hide_weapon_info",1);
	var_00 = [];
	var_01 = scripts\sp\_hud_util::func_499B("alien_icon_craft_battery",15,15);
	var_01 scripts\sp\_hud_util::setpoint("CENTER","CENTER",290,194);
	var_00["battery"] = var_01;
	var_02 = scripts\sp\_hud_util::createfontstring("objective",1);
	var_02 scripts\sp\_hud_util::setpoint("CENTER","CENTER",310,194);
	var_00["ammo"] = var_02;
	var_03 = scripts\sp\_hud_util::func_4997("white","black",104,6);
	var_03 scripts\sp\_hud_util::setpoint("CENTER","CENTER",305,203);
	var_03.bar.alpha = 1;
	var_03.bar.color = (1,0,0);
	var_00["energyBar"] = var_03;
	self.var_2A2B = var_00;
	func_2A34(self.var_2A23);
	return var_00;
}

//Function Number: 5
func_2A2C(param_00)
{
	setdvar("hideHudFast",0);
	function_01C5("hud_showStance",1);
	setomnvar("ui_hide_weapon_info",0);
	foreach(var_02 in param_00)
	{
		if(isdefined(var_02.bar))
		{
			var_02.bar destroy();
		}

		var_02 destroy();
	}

	self.var_2A2B = undefined;
}

//Function Number: 6
func_2A33(param_00)
{
	self endon("weapon_change");
	self endon("weapon_dropped");
	self.var_2A29 = 6000;
	self.var_2A2F = 0;
	thread func_2A27(param_00);
	for(;;)
	{
		self method_800C(0);
		if(!self attackbuttonpressed())
		{
		}
		else if(self method_81BD())
		{
		}
		else if(self method_81BE())
		{
		}
		else if(self ismeleeing())
		{
		}
		else if(self method_81C6())
		{
		}
		else if(self.var_9F47)
		{
		}
		else if(self.var_2A2F)
		{
		}
		else
		{
			self playsound("weap_steeldragon_fire");
			wait(0.2);
			self notify("beam_rifle_fire");
			self.var_2A2A = 1;
			if(!self.var_2A2E)
			{
				thread func_FC1E();
				self method_80D8(0.18,0.18);
				thread scripts\sp\_utility::func_D2CD(25,0.05);
			}
			else
			{
				wait(0.3);
			}

			while(self attackbuttonpressed())
			{
				self method_800C(0);
				if(self method_81BD())
				{
					break;
				}

				if(self.var_9F47)
				{
					break;
				}

				if(self.var_2A2E)
				{
					break;
				}

				if(self.var_2A2F)
				{
					break;
				}

				func_28C6();
				earthquake(0.12,0.1,self geteye(),5000);
				self playrumbleonentity("heavygun_fire");
				wait(0.05);
			}

			self notify("beam_rifle_off");
			self.var_2A2A = 0;
			self method_80A6();
			thread scripts\sp\_utility::func_D2CA(0.05);
			scripts\common\utility::func_5127(0.1,::scripts\common\utility::func_11018,"weap_steeldragon_lp");
			if(self.var_2A2E)
			{
				scripts\sp\_utility::func_CE2F("weap_steeldragon_powerdown");
				var_01 = undefined;
				if(!isdefined(var_01))
				{
					var_02 = undefined;
					var_03 = undefined;
					var_04 = self getweaponslistall();
					foreach(var_06 in var_04)
					{
						if(!scripts\sp\_utility::func_9F0E(var_06))
						{
							continue;
						}

						if(var_06 == "iw7_steeldragon")
						{
							continue;
						}

						var_07 = self getweaponammoclip(var_06) + self getweaponammostock(var_06);
						if(var_07 <= 0)
						{
							continue;
						}

						if(!isdefined(var_03))
						{
							var_03 = var_06;
							var_02 = var_07;
							continue;
						}

						if(var_07 > var_02)
						{
							var_03 = var_06;
							var_02 = var_07;
						}
					}

					var_01 = var_03;
				}

				if(isdefined(var_01))
				{
					self switchtoweapon(var_01);
				}
			}
			else
			{
				thread scripts\sp\_utility::func_CE2F("weap_steeldragon_off");
			}

			while(self attackbuttonpressed())
			{
				wait(0.05);
			}
		}

		wait(0.05);
	}
}

//Function Number: 7
func_FC1E()
{
	self endon("beam_rifle_off");
	wait(0.35);
	if(self attackbuttonpressed())
	{
		thread scripts\common\utility::func_CD7F("weap_steeldragon_lp");
	}
}

//Function Number: 8
func_2A22()
{
	var_00 = 45;
	var_01 = 0.5;
	for(;;)
	{
		while(!self adsbuttonpressed())
		{
			wait(0.05);
		}

		self method_81DE(var_00,var_01);
		while(self adsbuttonpressed())
		{
			wait(0.05);
		}

		self method_81DE(65,var_01);
		wait(0.05);
	}
}

//Function Number: 9
func_28C6(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = anglestoforward(level.player getplayerangles());
	var_06 = anglestoright(level.player getplayerangles());
	var_07 = anglestoup(level.player getplayerangles());
	var_08 = undefined;
	if(isdefined(param_00))
	{
		var_08 = param_00;
	}
	else
	{
		var_08 = level.player geteye();
		var_08 = var_08 + var_06 * 5;
		var_08 = var_08 + var_07 * -5;
	}

	var_09 = undefined;
	if(isdefined(param_01))
	{
		var_09 = param_01;
	}
	else
	{
		var_09 = level.player geteye();
		var_09 = var_09 + var_07 * -1;
	}

	var_0A = undefined;
	if(isdefined(param_02))
	{
		var_0A = param_02;
	}
	else
	{
		var_0A = var_09 + var_05 * 99999;
	}

	var_0B = scripts\common\trace::func_DCED(var_09,var_0A,level.player);
	var_0C = var_0B;
	var_0A = var_0B["position"];
	var_0D = 20;
	var_0E = distance2d(var_09,var_0A);
	var_0F = int(var_0E / var_0D);
	if(var_0F > 100)
	{
		var_0F = 100;
	}

	var_10 = var_08;
	for(var_11 = 0;var_11 < var_0F;var_11++)
	{
		var_0B = bullettrace(var_09,var_0A,1,level.player);
		if(distance2d(var_10,var_0B["position"]) < var_0D)
		{
			break;
		}

		var_0A = var_0B["position"];
		var_12 = vectornormalize(var_0A - var_09);
		var_10 = var_10 + var_12 * var_0D;
		if(level.player.var_4BDD >= 500)
		{
			continue;
		}

		thread func_2A26();
		playfx(scripts\common\utility::getfx("beam_rifle_beam"),var_10);
	}

	if(distance2d(var_0A,level.player.origin) > 56)
	{
		if(isdefined(var_0B["entity"]) && isdefined(var_0B["entity"].var_9D77))
		{
			var_0B["entity"] notify("damage",96,level.player,undefined,undefined,undefined,undefined,undefined,"j_head",undefined,"iw7_steeldragon");
		}

		var_13 = 75;
		if(isdefined(param_04))
		{
			var_13 = param_04;
		}

		radiusdamage(var_0B["position"],56,var_13,var_13,level.player,"MOD_EXPLOSIVE","iw7_steeldragon");
	}

	if(isdefined(var_0B["surfacetype"]) && level.player.var_4BDD < 500)
	{
		var_14 = vectortoangles(var_0C["normal"]);
		playfx(scripts\common\utility::getfx("beam_rifle_decal"),var_0C["position"],anglestoforward(var_14),anglestoup(var_14));
		if(isdefined(var_0B["entity"]) || var_0B["surfacetype"] == "surftype_default")
		{
			if(!isdefined(param_03))
			{
				level.var_EFFE = 0.75;
			}

			if(isdefined(var_0B["entity"]))
			{
				return;
			}

			playfx(scripts\common\utility::getfx("beam_rifle_smoke"),var_0C["position"]);
			return;
		}

		if(!isdefined(param_03))
		{
			level.var_EFFE = 0.5625;
		}

		if(scripts\common\utility::func_4347())
		{
			playfx(scripts\common\utility::getfx("beam_rifle_smoke"),var_0C["position"]);
			return;
		}

		return;
	}

	if(!isdefined(param_03))
	{
		level.var_EFFE = 0.5625;
	}
}

//Function Number: 10
func_2A26()
{
	level.player.var_4BDD++;
	wait(0.25);
	level.player.var_4BDD--;
}

//Function Number: 11
func_2A27(param_00)
{
	self endon("weapon_change");
	self endon("weapon_dropped");
	level.var_EFFE = 0.75;
	for(;;)
	{
		self waittill("beam_rifle_fire");
		while(self.var_2A2A)
		{
			var_01 = self.var_2A23 - level.var_EFFE;
			func_2A34(var_01);
			wait(0.05);
		}

		thread func_2A31(param_00);
	}
}

//Function Number: 12
func_2A31(param_00)
{
	self endon("beam_rifle_fire");
	wait(1);
	for(;;)
	{
		var_01 = self.var_2A23 + 0.08;
		func_2A34(var_01);
		if(var_01 >= 100)
		{
			break;
		}

		wait(0.05);
	}

	thread scripts\sp\_utility::func_CE2F("weap_steeldragon_charged");
}

//Function Number: 13
func_2A24()
{
	var_00 = scripts\common\utility::getstructarray("steel_dragon_ammo","targetname");
	foreach(var_02 in var_00)
	{
		var_03 = var_02 scripts\common\utility::spawn_tag_origin();
		thread func_2A25(var_03);
	}
}

//Function Number: 14
func_2A25(param_00)
{
	playfxontag(scripts\common\utility::getfx("beam_rifle_ammo"),param_00,"tag_origin");
	var_01 = spawn("trigger_radius",param_00.origin,0,56,56);
	for(;;)
	{
		var_01 waittill("trigger");
		if(!scripts\common\utility::func_2286(level.player getweaponslistprimaries(),"steel_dragon"))
		{
			continue;
		}

		if(self.var_2A23 >= 100)
		{
			continue;
		}

		break;
	}

	var_02 = self.var_2A23 + 15;
	func_2A34(var_02);
	function_0178("weap_ammo_pickup",param_00.origin);
	var_01 delete();
	param_00 delete();
}

//Function Number: 15
func_2A34(param_00)
{
	if(param_00 > 100)
	{
		param_00 = 100;
	}
	else if(param_00 <= 0)
	{
		param_00 = 0;
	}

	if(param_00 == 0)
	{
		self.var_2A2E = 1;
	}
	else
	{
		self.var_2A2E = 0;
	}

	self.var_2A23 = param_00;
	var_01 = self.var_2A23 / 100;
	if(isdefined(self.var_2A2B))
	{
		self.var_2A2B["energyBar"] scripts\sp\_hud_util::updatebar(var_01);
		self.var_2A2B["ammo"] settext(int(self.var_2A23));
	}
}

//Function Number: 16
func_2A32()
{
	if(!isdefined(self.var_111A4))
	{
		return;
	}

	if(self.var_111A4 != "C6")
	{
		return;
	}

	self waittill("death",var_00,var_01,var_02);
	if(!isdefined(var_02) || var_02 != "iw7_steeldragon")
	{
		return;
	}

	function_0178("frag_grenade_explode",self.origin);
	playfx(scripts\common\utility::getfx("beam_rifle_robot_explosion"),self gettagorigin("j_SpineUpper"));
}