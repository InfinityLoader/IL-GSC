/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\killstreaks\_ims.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 49
 * Decompile Time: 2890 ms
 * Timestamp: 10/27/2023 12:28:50 AM
*******************************************************************/

//Function Number: 1
init()
{
	scripts\mp\killstreaks\_killstreaks::func_DEFB("ims",::func_128EA);
	level.var_9385 = [];
	var_00 = spawnstruct();
	var_00.var_39B = "ims_projectile_mp";
	var_00.var_B91A = "ims_scorpion_body_iw6";
	var_00.var_B924 = "ims_scorpion_body_iw6_placement";
	var_00.var_B925 = "ims_scorpion_body_iw6_placement_failed";
	var_00.var_B91D = "ims_scorpion_body_iw6";
	var_00.var_B91C = "ims_scorpion_body_iw6_bombsquad";
	var_00.var_17B = &"KILLSTREAKS_HINTS_IMS_PICKUP_TO_MOVE";
	var_00.var_CC28 = &"KILLSTREAKS_HINTS_IMS_PLACE";
	var_00.var_38E3 = &"KILLSTREAKS_HINTS_IMS_CANNOT_PLACE";
	var_00.var_110EA = "ims";
	var_00.var_10A38 = "used_ims";
	var_00.maxhealth = 670;
	var_00.var_AC71 = 90;
	var_00.var_DDAC = 0.5;
	var_00.var_8487 = 0.4;
	var_00.var_C228 = 4;
	var_00.var_6A03 = "ims_scorpion_explosive_iw6";
	var_00.var_CC22 = 30;
	var_00.var_CC25 = 24;
	var_00.var_AC49 = "tag_lid";
	var_00.var_AC47 = [];
	var_00.var_AC47[1] = "IMS_Scorpion_door_1";
	var_00.var_AC47[2] = "IMS_Scorpion_door_2";
	var_00.var_AC47[3] = "IMS_Scorpion_door_3";
	var_00.var_AC47[4] = "IMS_Scorpion_door_4";
	var_00.var_AC48 = [];
	var_00.var_AC48[1] = "IMS_Scorpion_1_opened";
	var_00.var_AC48[2] = "IMS_Scorpion_2_opened";
	var_00.var_AC48[3] = "IMS_Scorpion_3_opened";
	var_00.var_6A09 = "tag_explosive";
	var_00.var_A640 = (0,0,12);
	level.var_9385["ims"] = var_00;
	level._effect["ims_explode_mp"] = loadfx("vfx/iw7/_requests/mp/vfx_generic_equipment_exp_lg.vfx");
	level._effect["ims_smoke_mp"] = loadfx("vfx/core/mp/killstreaks/vfx_sg_damage_blacksmoke");
	level._effect["ims_sensor_explode"] = loadfx("vfx/core/mp/killstreaks/vfx_ims_sparks");
	level._effect["ims_antenna_light_mp"] = loadfx("vfx/core/mp/killstreaks/vfx_light_detonator_blink");
	level.var_CC11 = [];
}

//Function Number: 2
func_128EA(param_00)
{
	var_01 = [];
	if(isdefined(self.var_9382))
	{
		var_01 = self.var_9382;
	}

	var_02 = func_836E("ims",param_00);
	if(!isdefined(var_02))
	{
		var_02 = 0;
		if(isdefined(self.var_9382))
		{
			if(!var_01.size && self.var_9382.size)
			{
				var_02 = 1;
			}

			if(var_01.size && var_01[0] != self.var_9382[0])
			{
				var_02 = 1;
			}
		}
	}

	if(var_02)
	{
		scripts\mp\_matchdata::func_AFC9(param_00.var_110EA,self.origin);
	}

	self.var_9D81 = 0;
	return var_02;
}

//Function Number: 3
func_836E(param_00,param_01)
{
	var_02 = func_49DC(param_00,self);
	param_01.var_9380 = var_02;
	func_E152();
	self.var_3A9F = var_02;
	var_02.var_6DEC = 1;
	var_03 = func_F684(var_02,1);
	self.var_3A9F = undefined;
	thread func_E2E0();
	return var_03;
}

//Function Number: 4
func_F684(param_00,param_01)
{
	self endon("death");
	self endon("disconnect");
	param_00 thread func_9377(self);
	scripts\common\utility::allow_weapon(0);
	if(!isai(self))
	{
		self notifyonplayercommand("place_ims","+attack");
		self notifyonplayercommand("place_ims","+attack_akimbo_accessible");
		if(!level.console)
		{
			self notifyonplayercommand("cancel_ims","+actionslot 5");
			self notifyonplayercommand("cancel_ims","+actionslot 6");
			self notifyonplayercommand("cancel_ims","+actionslot 7");
		}
	}

	for(;;)
	{
		var_02 = scripts\common\utility::func_13734("place_ims","cancel_ims","force_cancel_placement","killstreak_trigger_blocked");
		if(var_02 == "cancel_ims" || var_02 == "force_cancel_placement" || var_02 == "killstreak_trigger_blocked")
		{
			if(!param_01 && var_02 == "cancel_ims" || var_02 == "killstreak_trigger_blocked")
			{
				continue;
			}

			param_00 func_9376(var_02 == "force_cancel_placement" && !isdefined(param_00.var_6DEC));
			return 0;
		}

		if(!param_00.var_3872)
		{
			continue;
		}

		param_00 thread func_9379();
		self notify("IMS_placed");
		scripts\common\utility::allow_weapon(1);
		return 1;
	}
}

//Function Number: 5
func_E18E()
{
	if(self hasweapon("iw6_riotshield_mp"))
	{
		self.var_E2E6 = "iw6_riotshield_mp";
		scripts\mp\_utility::func_141E("iw6_riotshield_mp");
	}
}

//Function Number: 6
func_E152()
{
	if(scripts\mp\_utility::_hasperk("specialty_explosivebullets"))
	{
		self.var_E2DF = "specialty_explosivebullets";
		scripts\mp\_utility::func_E150("specialty_explosivebullets");
	}
}

//Function Number: 7
func_E2E8()
{
	if(isdefined(self.var_E2E6))
	{
		scripts\mp\_utility::func_12C6(self.var_E2E6);
		self.var_E2E6 = undefined;
	}
}

//Function Number: 8
func_E2E0()
{
	if(isdefined(self.var_E2DF))
	{
		scripts\mp\_utility::func_8387(self.var_E2DF);
		self.var_E2DF = undefined;
	}
}

//Function Number: 9
func_1370F()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	wait(0.05);
	func_E2E0();
}

//Function Number: 10
func_49DC(param_00,param_01)
{
	if(isdefined(param_01.var_9D81) && param_01.var_9D81)
	{
		return;
	}

	var_02 = spawnturret("misc_turret",param_01.origin + (0,0,25),"sentry_minigun_mp");
	var_02.angles = param_01.angles;
	var_02.var_9386 = param_00;
	var_02.var_222 = param_01;
	var_02 setmodel(level.var_9385[param_00].var_B91A);
	var_02 method_81F5();
	var_02 method_835B(1);
	var_02 method_830F("sentry_offline");
	var_02 makeunusable();
	var_02 method_8336(param_01);
	return var_02;
}

//Function Number: 11
func_49DB(param_00)
{
	var_01 = param_00.var_222;
	var_02 = param_00.var_9386;
	var_03 = spawn("script_model",param_00.origin);
	var_03 setmodel(level.var_9385[var_02].var_B91A);
	var_03.var_EB9C = 3;
	var_03.angles = param_00.angles;
	var_03.var_9386 = var_02;
	var_03.var_222 = var_01;
	var_03 method_831F(var_01);
	var_03.team = var_01.team;
	var_03.var_10085 = 0;
	var_03.hidden = 0;
	var_03.var_252E = 1;
	var_03 method_80A3();
	var_03.var_8BF0 = [];
	var_03.var_451C = level.var_9385[var_02];
	var_03 thread func_9369();
	var_03 thread func_937C();
	var_03 thread func_9363();
	var_03 thread func_9372();
	return var_03;
}

//Function Number: 12
func_9363()
{
	var_00 = spawn("script_model",self.origin);
	var_00.angles = self.angles;
	var_00 hide();
	var_00 thread scripts\mp\_weapons::func_2C69(self.var_222);
	var_00 setmodel(level.var_9385[self.var_9386].var_B91C);
	var_00 linkto(self);
	var_00 method_82C7(0);
	self.var_2C68 = var_00;
	self waittill("death");
	if(isdefined(var_00))
	{
		var_00 delete();
	}
}

//Function Number: 13
func_936D(param_00)
{
	self.var_933C = 1;
	self notify("death");
}

//Function Number: 14
func_9366()
{
	self endon("carried");
	scripts\mp\_damage::func_B9C6(self.var_451C.maxhealth,"ims",::func_9368,::func_936C,1);
}

//Function Number: 15
func_936C(param_00,param_01,param_02,param_03,param_04)
{
	if(self.hidden || param_01 == "ims_projectile_mp")
	{
		return -1;
	}

	var_05 = param_03;
	if(param_02 == "MOD_MELEE")
	{
		var_05 = self.maxhealth * 0.25;
	}

	if(function_0107(param_02))
	{
		var_05 = param_03 * 1.5;
	}

	var_05 = scripts\mp\_damage::func_89C6(param_01,param_02,var_05);
	var_05 = scripts\mp\_damage::func_8975(param_01,param_02,var_05);
	return var_05;
}

//Function Number: 16
func_9368(param_00,param_01,param_02,param_03)
{
	var_04 = scripts\mp\_damage::func_C548("ims",param_00,param_01,param_02,param_03,"destroyed_ims","ims_destroyed");
	if(var_04)
	{
		param_00 notify("destroyed_equipment");
	}
}

//Function Number: 17
func_9367()
{
	self endon("carried");
	self waittill("death");
	func_E10B();
	if(!isdefined(self))
	{
		return;
	}

	func_9378();
	self playsound("ims_destroyed");
	if(isdefined(self.var_9B05))
	{
		playfx(scripts\common\utility::getfx("ims_explode_mp"),self.origin + (0,0,10));
		playfx(scripts\common\utility::getfx("ims_smoke_mp"),self.origin);
		self.var_9B05 func_E2E0();
		self.var_9B05 func_E2E8();
		self notify("deleting");
		wait(1);
	}
	else if(isdefined(self.var_933C))
	{
		playfx(scripts\common\utility::getfx("ims_explode_mp"),self.origin + (0,0,10));
		self notify("deleting");
	}
	else
	{
		playfx(scripts\common\utility::getfx("ims_explode_mp"),self.origin + (0,0,10));
		playfx(scripts\common\utility::getfx("ims_smoke_mp"),self.origin);
		wait(3);
		self playsound("ims_fire");
		self notify("deleting");
	}

	if(isdefined(self.var_C2BB))
	{
		scripts\mp\objidpoolmanager::returnminimapid(self.var_C2BB);
	}

	if(isdefined(self.var_C2BA))
	{
		scripts\mp\objidpoolmanager::returnminimapid(self.var_C2BA);
	}

	scripts\mp\_weapons::func_66A8();
	self method_80D4();
	self delete();
}

//Function Number: 18
func_13A10()
{
	self endon("carried");
	self endon("death");
	level endon("game_ended");
	for(;;)
	{
		self waittill("emp_damage",var_00,var_01);
		scripts\mp\_weapons::func_11061();
		playfx(scripts\common\utility::getfx("emp_stun"),self.origin);
		playfx(scripts\common\utility::getfx("ims_smoke_mp"),self.origin);
		wait(var_01);
		func_937B();
	}
}

//Function Number: 19
func_9369()
{
	self endon("death");
	level endon("game_ended");
	for(;;)
	{
		self waittill("trigger",var_00);
		if(!scripts\mp\_utility::func_9F19(var_00))
		{
			continue;
		}

		if(self.var_E1 >= self.maxhealth)
		{
			continue;
		}

		var_01 = func_49DC(self.var_9386,var_00);
		if(!isdefined(var_01))
		{
			continue;
		}

		var_01.var_935F = self;
		func_9378();
		func_936A();
		if(isdefined(self getlinkedparent()))
		{
			self unlink();
		}

		var_00 func_F684(var_01,0);
	}
}

//Function Number: 20
func_9379()
{
	self endon("death");
	level endon("game_ended");
	if(isdefined(self.var_3A9D))
	{
		self.var_3A9D method_80F3();
	}

	self.var_3A9D = undefined;
	if(isdefined(self.var_222))
	{
		self.var_222.var_9D81 = 0;
	}

	self.var_6DEC = undefined;
	var_00 = undefined;
	if(isdefined(self.var_935F))
	{
		var_00 = self.var_935F;
		var_00 endon("death");
		var_00.origin = self.origin;
		var_00.angles = self.angles;
		var_00.var_3A9D = undefined;
		var_00 func_937A();
		if(isdefined(var_00.var_2C68))
		{
			var_00.var_2C68 show();
			var_00 func_9383(var_00.var_2C68,1);
			level notify("update_bombsquad");
		}
	}
	else
	{
		var_00 = func_49DB(self);
	}

	var_00 func_184F();
	var_00.var_9EE4 = 1;
	var_00 thread func_9366();
	var_00 thread func_13A10();
	var_00 thread func_9367();
	var_00 setcandamage(1);
	self playsound("ims_plant");
	self notify("placed");
	var_00 thread func_9375();
	var_01 = spawnstruct();
	if(isdefined(self.var_BD3B))
	{
		var_01.var_AD39 = self.var_BD3B;
	}

	var_01.var_6371 = "carried";
	var_01.var_4E53 = ::func_936D;
	var_00 thread scripts\mp\_movers::func_892F(var_01);
	self delete();
}

//Function Number: 21
func_9376(param_00)
{
	if(isdefined(self.var_3A9D))
	{
		var_01 = self.var_3A9D;
		var_01 method_80F3();
		var_01.var_9D81 = undefined;
		var_01.var_3AA0 = undefined;
		var_01 scripts\common\utility::allow_weapon(1);
		if(isdefined(var_01.var_9382))
		{
			foreach(var_03 in var_01.var_9382)
			{
				if(isdefined(var_03.var_2C68))
				{
					var_03.var_2C68 delete();
				}
			}
		}
	}

	if(isdefined(param_00) && param_00)
	{
		scripts\mp\_weapons::func_66A8();
	}

	self delete();
}

//Function Number: 22
func_9377(param_00)
{
	func_E10B();
	self setmodel(level.var_9385[self.var_9386].var_B924);
	self method_8335(param_00);
	self method_82C7(0);
	self setcandamage(0);
	self.var_3A9D = param_00;
	param_00.var_9D81 = 1;
	param_00 thread func_12EB0(self);
	thread func_936E(param_00);
	thread func_936F(param_00);
	thread func_9371();
	thread func_9370(param_00);
	self notify("carried");
	if(isdefined(self.var_935F))
	{
		self.var_935F notify("carried");
		self.var_935F.var_3A9D = param_00;
		self.var_935F.var_9EE4 = 0;
		if(isdefined(self.var_935F.var_2C68))
		{
			self.var_935F.var_2C68 hide();
		}
	}
}

//Function Number: 23
func_12EB0(param_00)
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	param_00 endon("placed");
	param_00 endon("death");
	param_00.var_3872 = 1;
	var_01 = -1;
	var_02 = level.var_9385[param_00.var_9386];
	for(;;)
	{
		var_03 = self canplayerplacesentry(1,var_02.var_CC25);
		param_00.origin = var_03["origin"];
		param_00.angles = var_03["angles"];
		param_00.var_3872 = self isonground() && var_03["result"] && abs(param_00.origin[2] - self.origin[2]) < var_02.var_CC22;
		if(isdefined(var_03["entity"]))
		{
			param_00.var_BD3B = var_03["entity"];
		}
		else
		{
			param_00.var_BD3B = undefined;
		}

		if(param_00.var_3872 != var_01)
		{
			if(param_00.var_3872)
			{
				param_00 setmodel(level.var_9385[param_00.var_9386].var_B924);
				self method_80F4(level.var_9385[param_00.var_9386].var_CC28);
			}
			else
			{
				param_00 setmodel(level.var_9385[param_00.var_9386].var_B925);
				self method_80F4(level.var_9385[param_00.var_9386].var_38E3);
			}
		}

		var_01 = param_00.var_3872;
		wait(0.05);
	}
}

//Function Number: 24
func_936E(param_00)
{
	self endon("placed");
	self endon("death");
	param_00 endon("disconnect");
	param_00 waittill("death");
	if(self.var_3872 && param_00.team != "spectator")
	{
		thread func_9379();
		return;
	}

	func_9376();
}

//Function Number: 25
func_936F(param_00)
{
	self endon("placed");
	self endon("death");
	param_00 waittill("disconnect");
	func_9376();
}

//Function Number: 26
func_9370(param_00)
{
	self endon("placed");
	self endon("death");
	for(;;)
	{
		if(isdefined(self.var_3A9D.var_C53B) && self.var_3A9D.var_C53B)
		{
			self notify("death");
		}

		wait(0.1);
	}
}

//Function Number: 27
func_9371(param_00)
{
	self endon("placed");
	self endon("death");
	level waittill("game_ended");
	func_9376();
}

//Function Number: 28
func_9375()
{
	self setcursorhint("HINT_NOICON");
	self sethintstring(level.var_9385[self.var_9386].var_17B);
	var_00 = self.var_222;
	var_00 method_80F3();
	if(level.teambased)
	{
		scripts\mp\_entityheadicons::func_F877(self.team,(0,0,60));
	}
	else
	{
		scripts\mp\_entityheadicons::func_F7F2(var_00,(0,0,60));
	}

	self makeusable();
	self setcandamage(1);
	if(isdefined(var_00.var_9382))
	{
		foreach(var_02 in var_00.var_9382)
		{
			if(var_02 == self)
			{
				continue;
			}

			var_02 notify("death");
		}
	}

	var_00.var_9382 = [];
	var_00.var_9382[0] = self;
	foreach(var_05 in level.players)
	{
		if(var_05 == var_00)
		{
			self enableplayeruse(var_05);
			continue;
		}

		self disableplayeruse(var_05);
	}

	if(self.var_10085)
	{
		level thread scripts\mp\_utility::func_115DE(level.var_9385[self.var_9386].var_10A38,var_00);
		self.var_10085 = 0;
	}

	var_07 = (0,0,20);
	var_08 = (0,0,256) - var_07;
	var_09 = [];
	self.var_A637 = [];
	for(var_0A = 0;var_0A < self.var_451C.var_C228;var_0A++)
	{
		if(func_C229())
		{
			var_0B = func_FCA8(var_0A + 1,self.var_451C.var_C228 - 4);
		}
		else
		{
			var_0B = var_0A + 1;
		}

		var_0C = self gettagorigin(self.var_451C.var_6A09 + var_0B + "_attach");
		var_0D = self gettagorigin(self.var_451C.var_6A09 + var_0B + "_attach") + var_07;
		var_09[var_0A] = bullettrace(var_0D,var_0D + var_08,0,self);
		if(var_0A < 4)
		{
			var_0E = spawn("script_model",var_0C + self.var_451C.var_A640);
			var_0E setscriptmoverkillcam("explosive");
			self.var_A637[self.var_A637.size] = var_0E;
		}
	}

	var_0F = var_09[0];
	for(var_0A = 0;var_0A < var_09.size;var_0A++)
	{
		if(var_09[var_0A]["position"][2] < var_0F["position"][2])
		{
			var_0F = var_09[var_0A];
		}
	}

	self.var_2514 = var_0F["position"] - (0,0,20) - self.origin;
	var_10 = spawn("trigger_radius",self.origin,0,256,100);
	self.var_2536 = var_10;
	self.var_2536 enablelinkto();
	self.var_2536 linkto(self);
	self.var_2528 = length(self.var_2514) / 200;
	func_937F();
	func_937B();
	thread func_937D();
	foreach(var_05 in level.players)
	{
		thread func_9374(var_05);
	}
}

//Function Number: 29
func_937D()
{
	self endon("death");
	for(;;)
	{
		level waittill("connected",var_00);
		func_9373(var_00);
	}
}

//Function Number: 30
func_9373(param_00)
{
	self endon("death");
	param_00 endon("disconnect");
	param_00 waittill("spawned_player");
	self disableplayeruse(param_00);
}

//Function Number: 31
func_9374(param_00)
{
	self endon("death");
	param_00 endon("disconnect");
	for(;;)
	{
		param_00 waittill("joined_team");
		self disableplayeruse(param_00);
	}
}

//Function Number: 32
func_9372()
{
	self endon("death");
	level endon("game_ended");
	self.var_222 waittill("killstreak_disowned");
	if(isdefined(self.var_9EE4))
	{
		self notify("death");
		return;
	}

	func_9376(0);
}

//Function Number: 33
func_937B()
{
	thread scripts\mp\_weapons::func_57EB("tag_fx");
	thread func_9362();
}

//Function Number: 34
func_9378()
{
	self makeunusable();
	if(level.teambased)
	{
		scripts\mp\_entityheadicons::func_F877("none",(0,0,0));
	}
	else if(isdefined(self.var_222))
	{
		scripts\mp\_entityheadicons::func_F7F2(undefined,(0,0,0));
	}

	if(isdefined(self.var_2536))
	{
		self.var_2536 delete();
	}

	if(isdefined(self.var_A637))
	{
		foreach(var_01 in self.var_A637)
		{
			if(isdefined(var_01))
			{
				if(isdefined(self.var_222) && isdefined(self.var_222.var_9381) && var_01 == self.var_222.var_9381)
				{
					continue;
				}
				else
				{
					var_01 delete();
				}
			}
		}
	}

	if(isdefined(self.var_69F6))
	{
		self.var_69F6 delete();
		self.var_69F6 = undefined;
	}

	scripts\mp\_weapons::func_11061();
}

//Function Number: 35
func_9E09(param_00)
{
	if(level.teambased && self.team == param_00.team)
	{
		return 1;
	}

	return 0;
}

//Function Number: 36
func_9362()
{
	self endon("death");
	self endon("emp_damage");
	level endon("game_ended");
	for(;;)
	{
		if(!isdefined(self.var_2536))
		{
			break;
		}

		self.var_2536 waittill("trigger",var_00);
		if(isplayer(var_00))
		{
			if(isdefined(self.var_222) && var_00 == self.var_222)
			{
				continue;
			}

			if(level.teambased && var_00.pers["team"] == self.team)
			{
				continue;
			}

			if(!scripts\mp\_utility::func_9F19(var_00))
			{
				continue;
			}
		}
		else if(isdefined(var_00.var_222))
		{
			if(isdefined(self.var_222) && var_00.var_222 == self.var_222)
			{
				continue;
			}

			if(level.teambased && var_00.var_222.pers["team"] == self.team)
			{
				continue;
			}
		}

		var_01 = var_00.origin + (0,0,50);
		if(!sighttracepassed(self.var_2514 + self.origin,var_01,0,self))
		{
			continue;
		}

		var_02 = 0;
		for(var_03 = 1;var_03 <= self.var_451C.var_C228;var_03++)
		{
			if(var_03 > 4)
			{
				break;
			}

			if(sighttracepassed(self gettagorigin(self.var_451C.var_AC49 + var_03),var_01,0,self))
			{
				var_02 = 1;
				break;
			}
		}

		if(!var_02)
		{
			continue;
		}

		self playsound("ims_trigger");
		scripts\mp\_weapons::func_6A08(var_00,level.var_9385[self.var_9386].var_8487,"ims");
		if(!isdefined(self.var_2536))
		{
			break;
		}

		if(!isdefined(self.var_8BF0[self.var_252E]))
		{
			self.var_8BF0[self.var_252E] = 1;
			thread func_6D2C(var_00,self.var_252E);
			self.var_252E++;
		}

		if(self.var_252E > self.var_451C.var_C228)
		{
			break;
		}

		func_937F();
		self waittill("sensor_exploded");
		wait(self.var_451C.var_DDAC);
		if(!isdefined(self.var_222))
		{
			break;
		}
	}

	if(isdefined(self.var_3A9D) && isdefined(self.var_222) && self.var_3A9D == self.var_222)
	{
		return;
	}

	self notify("death");
}

//Function Number: 37
func_6D2C(param_00,param_01)
{
	if(func_C229())
	{
		param_01 = func_FCA8(param_01,self.var_451C.var_C228 - 4);
	}

	var_02 = self.var_69F6;
	self.var_69F6 = undefined;
	var_03 = self.var_451C.var_AC49 + param_01;
	playfxontag(level._effect["ims_sensor_explode"],self,var_03);
	func_9384(param_01,self.var_451C);
	var_04 = self.var_451C.var_39B;
	var_05 = self.var_222;
	var_02 unlink();
	var_02 rotateyaw(3600,self.var_2528);
	var_02 moveto(self.var_2514 + self.origin,self.var_2528,self.var_2528 * 0.25,self.var_2528 * 0.25);
	if(isdefined(var_02.var_A63A))
	{
		var_06 = var_02.var_A63A;
		var_06 unlink();
		if(isdefined(self.var_222))
		{
			self.var_222.var_9381 = var_06;
		}

		var_06 moveto(self.var_2514 + self.origin + self.var_451C.var_A640,self.var_2528,self.var_2528 * 0.25,self.var_2528 * 0.25);
		if(!func_C229())
		{
			var_06 thread func_51A6(5);
		}
	}

	var_02 playsound("ims_launch");
	var_02 waittill("movedone");
	playfx(level._effect["ims_sensor_explode"],var_02.origin);
	var_07 = [];
	var_07[0] = param_00.origin;
	for(var_08 = 0;var_08 < var_07.size;var_08++)
	{
		if(isdefined(var_05))
		{
			scripts\mp\_utility::func_1309(var_04,var_02.origin,var_07[var_08],var_05);
			continue;
		}

		scripts\mp\_utility::func_1309(var_04,var_02.origin,var_07[var_08]);
	}

	var_02 delete();
	self notify("sensor_exploded");
}

//Function Number: 38
func_51A6(param_00)
{
	self endon("death");
	level scripts\mp\_hostmigration::func_13708(param_00);
	if(isdefined(self))
	{
		self delete();
	}
}

//Function Number: 39
func_937C()
{
	self endon("death");
	level endon("game_ended");
	var_00 = level.var_9385[self.var_9386].var_AC71;
	while(var_00)
	{
		wait(1);
		scripts\mp\_hostmigration::func_13834();
		if(!isdefined(self.var_3A9D))
		{
			var_00 = max(0,var_00 - 1);
		}
	}

	self notify("death");
}

//Function Number: 40
func_184F()
{
	var_00 = self getentitynumber();
	level.var_CC11[var_00] = self;
}

//Function Number: 41
func_E10B()
{
	var_00 = self getentitynumber();
	level.var_CC11[var_00] = undefined;
}

//Function Number: 42
func_936A()
{
	self hide();
	self.hidden = 1;
}

//Function Number: 43
func_937A()
{
	self show();
	self.hidden = 0;
	func_9383(self,1);
}

//Function Number: 44
func_937E(param_00)
{
	var_01 = spawn("script_model",self gettagorigin(self.var_451C.var_6A09 + param_00 + "_attach"));
	var_01 setmodel(self.var_451C.var_6A03);
	var_01.angles = self.angles;
	var_01.var_A63A = self.var_A637[param_00 - 1];
	var_01.var_A63A linkto(self);
	return var_01;
}

//Function Number: 45
func_937F()
{
	for(var_00 = 1;var_00 <= self.var_451C.var_C228 && isdefined(self.var_8BF0[var_00]);var_00++)
	{
	}

	if(var_00 <= self.var_451C.var_C228)
	{
		if(func_C229())
		{
			var_00 = func_FCA8(var_00,self.var_451C.var_C228 - 4);
		}

		var_01 = func_937E(var_00);
		var_01 linkto(self);
		self.var_69F6 = var_01;
	}
}

//Function Number: 46
func_9384(param_00,param_01,param_02)
{
	var_03 = param_01.var_AC49 + param_00 + "_attach";
	var_04 = undefined;
	if(isdefined(param_02))
	{
		var_04 = param_01.var_AC48[param_00];
	}
	else
	{
		var_04 = param_01.var_AC47[param_00];
	}

	self scriptmodelplayanim(var_04);
	var_05 = param_01.var_6A09 + param_00 + "_attach";
	self method_8187(var_05);
}

//Function Number: 47
func_9383(param_00,param_01)
{
	var_02 = self.var_8BF0.size;
	if(var_02 > 0)
	{
		if(func_C229())
		{
			var_02 = func_FCA8(var_02,self.var_451C.var_C228 - 4);
		}

		param_00 func_9384(var_02,self.var_451C,param_01);
	}
}

//Function Number: 48
func_C229()
{
	return self.var_451C.var_C228 > 4;
}

//Function Number: 49
func_FCA8(param_00,param_01)
{
	var_02 = param_00 - param_01;
	var_02 = max(1,var_02);
	return int(var_02);
}