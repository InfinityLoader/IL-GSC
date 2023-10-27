/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3359.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 22
 * Decompile Time: 7 ms
 * Timestamp: 10/27/2023 12:26:45 AM
*******************************************************************/

//Function Number: 1
func_127E3()
{
	level._effect["tripMineLaserFr"] = loadfx("vfx/iw7/_requests/mp/power/vfx_trip_mine_beam_friendly.vfx");
}

//Function Number: 2
func_127F2(param_00)
{
	param_00 endon("death");
	self endon("disconnect");
	thread func_127D3(self);
	param_00 waittill("missile_stuck",var_01);
	param_00 method_831F(self);
	param_00 method_8317(1);
	param_00.var_ABC7 = func_127EB(param_00);
	thread scripts\cp\_weapon::func_B76C(param_00.var_ABC7);
	param_00.var_ABC9 = func_127EC(param_00);
	thread scripts\cp\_weapon::func_B76C(param_00.var_ABC9);
	scripts\cp\_weapon::func_C54E(param_00,"power_tripMine");
	thread scripts\cp\_weapon::func_B9CA(self,param_00);
	param_00 thread func_127DC();
	param_00 setscriptablepartstate("plant","active",0);
	param_00 thread func_127D1();
}

//Function Number: 3
func_127EB(param_00)
{
	var_01 = param_00 gettagorigin("tag_laser");
	var_02 = param_00.angles;
	var_03 = spawn("trigger_rotatable_radius",var_01,0,3,1000);
	var_03.angles = var_02;
	var_03 enablelinkto();
	var_03 linkto(param_00);
	var_03 hide();
	return var_03;
}

//Function Number: 4
func_127EC(param_00)
{
	var_01 = spawn("trigger_rotatable_radius",param_00.origin,0,32,32);
	var_01.angles = param_00.angles;
	var_01 enablelinkto();
	var_01 linkto(param_00);
	var_01 hide();
	return var_01;
}

//Function Number: 5
func_127D1()
{
	self endon("mine_triggered");
	self endon("mine_destroyed");
	self endon("mine_selfdestruct");
	self endon("death");
	self.var_222 endon("disconnect");
	wait(1);
	var_00 = self gettagorigin("tag_laser");
	var_01 = var_00 + anglestoup(self.angles) * 1000;
	thread func_127E0(var_00,var_01);
	thread func_127F4();
}

//Function Number: 6
func_127DC()
{
	self endon("death");
	self.var_222 endon("disconnect");
	level endon("game_ended");
	var_00 = self.var_222;
	self waittill("detonateExplosive",var_01);
	if(isdefined(var_01))
	{
		thread func_127DB(var_01);
		return;
	}

	thread func_127DB(var_00);
}

//Function Number: 7
func_127D8()
{
	self endon("death");
	self.var_222 endon("disconnect");
	self waittill("emp_damage",var_00,var_01);
	if(isdefined(self.var_222) && var_00 != self.var_222)
	{
		var_00 notify("destroyed_equipment");
	}

	thread func_127D7();
}

//Function Number: 8
func_127DB(param_00)
{
	thread func_127D6(5);
	self method_82DD(param_00);
	self setscriptablepartstate("plant","neutral",0);
	self setscriptablepartstate("arm","neutral",0);
	self setscriptablepartstate("trigger","neutral",0);
	self setscriptablepartstate("launch","neutral",0);
	self setscriptablepartstate("explode","active_cp",0);
}

//Function Number: 9
func_127D7(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 0;
	}

	thread func_127D6(param_00 + 2);
	wait(param_00);
	self setscriptablepartstate("plant","neutral",0);
	self setscriptablepartstate("arm","neutral",0);
	self setscriptablepartstate("trigger","neutral",0);
	self setscriptablepartstate("launch","neutral",0);
	self setscriptablepartstate("destroy","active",0);
}

//Function Number: 10
func_127E7(param_00)
{
	var_01 = spawn("script_model",self gettagorigin("tag_laser"));
	var_01.angles = self.angles;
	var_01 method_831F(self.var_222);
	var_01 method_82DD(self.var_222);
	var_01 setmodel("trip_mine_wm_projectile");
	var_01.var_222 = self.var_222;
	var_01.team = self.team;
	var_01.var_13C2E = "trip_mine_mp";
	var_01.var_D719 = "power_tripMine";
	var_01.var_A63A = self;
	thread func_127D7(0.2);
	var_01 moveto(param_00,0.2,0.1);
	wait(0.2);
	var_02 = undefined;
	if(isdefined(var_01.var_222))
	{
		var_02 = 5;
		var_01 setscriptablepartstate("explode","active_cp",0);
	}
	else
	{
		var_02 = 2;
		var_01 setscriptablepartstate("destroy","active",0);
	}

	wait(var_02);
	var_01 delete();
}

//Function Number: 11
func_127F4()
{
	self endon("mine_triggered");
	self endon("mine_destroyed");
	self endon("mine_selfdestruct");
	self endon("death");
	self.var_6316 endon("death");
	self.var_222 endon("disconnect");
	var_00 = self.var_ABC7;
	var_01 = func_127D2();
	while(isdefined(var_00))
	{
		var_00 waittill("trigger",var_02);
		if(!func_127E4(var_02,1))
		{
			continue;
		}

		var_03 = scripts\common\utility::func_116D7(isplayer(var_02) || isagent(var_02),var_02 gettagorigin("j_helmet"),var_02.origin);
		var_04 = self gettagorigin("tag_laser");
		var_05 = self.var_6316.origin;
		var_06 = scripts\common\utility::func_42A2(var_02.origin,var_03,var_04,var_05);
		if(!isdefined(var_06))
		{
			continue;
		}

		var_07 = var_06[0];
		var_08 = var_06[1];
		var_09 = var_06[2];
		var_0A = var_08[2] > var_03[2];
		var_0B = var_08[2] < var_02.origin[2];
		if(var_0A || var_0B || var_09 > 16)
		{
			continue;
		}

		thread func_127E8(var_02,var_08);
		break;
	}
}

//Function Number: 12
func_127F7()
{
	self endon("mine_triggered");
	self endon("mine_destroyed");
	self endon("mine_selfdestruct");
	self endon("death");
	self.var_222 endon("disconnect");
	var_00 = self.var_ABC9;
	var_01 = func_127D2();
	while(isdefined(var_00))
	{
		var_00 waittill("trigger",var_02);
		if(!func_127E4(var_02,0))
		{
			continue;
		}

		var_03 = scripts\common\utility::func_116D7(isplayer(var_02) || isagent(var_02),var_02 geteye(),var_02.origin);
		var_04 = function_0287(self.origin,var_02 geteye(),var_01,self,0,"physicsquery_closest");
		if(isdefined(var_04) && var_04.size > 0)
		{
			continue;
		}

		var_05 = self.origin;
		var_06 = self.var_6316.origin;
		var_07 = var_05 + var_06 - var_05 * 0.2;
		thread func_127E8(var_02,var_07);
		break;
	}
}

//Function Number: 13
func_127E8(param_00,param_01)
{
	self endon("mine_destroyed");
	self endon("mine_selfdestruct");
	self endon("death");
	self.var_222 endon("disconnect");
	self notify("mine_triggered");
	self setscriptablepartstate("trigger","active",0);
	scripts\cp\_weapon::func_6A08(param_00,0.3,"tripMine");
	thread func_127E7(param_01);
}

//Function Number: 14
func_127E4(param_00,param_01)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	if(isplayer(param_00) || isagent(param_00))
	{
		if(lib_0D12::func_9DDF(param_00))
		{
			return 0;
		}

		if(!scripts\cp\_utility::func_9F19(param_00))
		{
			return 0;
		}

		if(self.team == param_00.team)
		{
			return 0;
		}

		if(!param_01 && lengthsquared(param_00 method_8123()) < 0.0001)
		{
			return 0;
		}

		return 1;
	}

	return 1;
}

//Function Number: 15
func_127E0(param_00,param_01)
{
	var_02 = spawn("script_model",param_00);
	var_02 setmodel("tag_origin");
	var_03 = spawn("script_model",param_01);
	var_03 setmodel("tag_origin");
	self.var_10D97 = var_02;
	self.var_6316 = var_03;
	self.var_10D97 linkto(self);
	self.var_6316 linkto(self.var_10D97);
	self.var_41F6 = [];
	self.var_41EF = [];
	scripts\common\utility::func_136F7();
	if(!isdefined(self))
	{
		var_02 delete();
		var_03 delete();
		return;
	}

	var_04 = self.var_222;
	var_05 = self.var_222.team;
	foreach(var_07 in level.players)
	{
		if(!isdefined(var_07))
		{
			continue;
		}

		var_08 = var_07 getentitynumber();
		self.var_41F6[var_08] = var_07;
		self.var_41EF[var_08] = function_02DF(scripts\common\utility::getfx("tripMineLaserFr"),self.var_10D97,"tag_origin",self.var_6316,"tag_origin",var_07);
	}

	thread func_127F0();
	thread func_127EF();
	thread func_127F1();
	func_127E1();
	self.var_10D97 delete();
	self.var_6316 delete();
	foreach(var_0B in self.var_41EF)
	{
		if(isdefined(var_0B))
		{
			var_0B delete();
		}
	}
}

//Function Number: 16
func_127E1()
{
	self endon("mine_destroyed");
	self endon("mine_selfdestruct");
	self endon("death");
	self.var_222 endon("disconnect");
	self waittill("forever");
}

//Function Number: 17
func_127F0()
{
	self endon("mine_destroyed");
	self endon("mine_selfdestruct");
	self endon("death");
	self.var_222 endon("disconnect");
	var_00 = self.var_222;
	var_01 = self.var_222.team;
	for(;;)
	{
		level waittill("joined_team",var_02);
		var_03 = var_02 getentitynumber();
		self.var_41F6[var_03] = var_02;
		if(isdefined(self.var_41EF[var_03]))
		{
			self.var_41EF[var_03] delete();
		}

		self.var_41EF[var_03] = function_02DF(scripts\common\utility::getfx("tripMineLaserFr"),self.var_10D97,"tag_origin",self.var_6316,"tag_origin",var_02);
	}
}

//Function Number: 18
func_127EF()
{
	self endon("mine_destroyed");
	self endon("mine_selfdestruct");
	self endon("death");
	self.var_222 endon("disconnect");
	for(;;)
	{
		foreach(var_02, var_01 in self.var_41F6)
		{
			if(!isdefined(var_01))
			{
				if(isdefined(self.var_41EF[var_02]))
				{
					self.var_41EF[var_02] delete();
				}

				self.var_41F6[var_02] = undefined;
				self.var_41EF[var_02] = undefined;
			}
		}

		wait(0.1);
	}
}

//Function Number: 19
func_127F1()
{
	self endon("mine_destroyed");
	self endon("mine_selfdestruct");
	self endon("death");
	self.var_222 endon("disconnect");
	var_00 = func_127D2();
	for(;;)
	{
		var_01 = self.var_10D97.origin;
		var_02 = var_01 + anglestoup(self.angles) * 1000;
		var_03 = function_0287(var_01,var_02,var_00,self,0,"physicsquery_closest");
		if(isdefined(var_03) && var_03.size > 0)
		{
			var_02 = var_03[0]["position"];
		}

		self.var_6316 unlink();
		self.var_6316.origin = var_02;
		self.var_6316 linkto(self.var_10D97);
		scripts\common\utility::func_136F7();
	}
}

//Function Number: 20
func_127D6(param_00)
{
	self notify("death");
	level.var_B779[self getentitynumber()] = undefined;
	self setcandamage(0);
	self method_80F7();
	self.var_69BA = 1;
	var_01 = self.var_222;
	if(isdefined(self.var_222))
	{
		var_01.var_CC4C = scripts\common\utility::func_22A9(var_01.var_CC4C,self);
		var_01 notify("c4_update",0);
	}

	wait(param_00);
	self delete();
}

//Function Number: 21
func_127D2()
{
	return physics_createcontents(["physicscontents_solid","physicscontents_water","physicscontents_sky","physicscontents_glass","physicscontents_vehicle","physicscontents_item","physicscontents_missileclip"]);
}

//Function Number: 22
func_127D3(param_00)
{
	self endon("death");
	self endon("missile_stuck");
	param_00 waittill("disconnect");
	if(isdefined(self))
	{
		self delete();
	}
}