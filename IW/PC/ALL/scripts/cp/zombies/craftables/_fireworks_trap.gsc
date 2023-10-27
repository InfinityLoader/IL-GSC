/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\cp\zombies\craftables\_fireworks_trap.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 20
 * Decompile Time: 750 ms
 * Timestamp: 10/27/2023 12:23:38 AM
*******************************************************************/

//Function Number: 1
init()
{
	level.var_6DA3 = [];
	var_00 = spawnstruct();
	var_00.var_39B = "zmb_fireworksprojectile_mp";
	var_00.var_B91A = "park_fireworks_trap";
	var_00.var_B924 = "park_fireworks_trap_good";
	var_00.var_B925 = "park_fireworks_trap_bad";
	var_00.var_17B = &"COOP_CRAFTABLES_PICKUP";
	var_00.var_CC28 = &"COOP_CRAFTABLES_PLACE";
	var_00.var_38E3 = &"COOP_CRAFTABLES_CANNOT_PLACE";
	var_00.var_CC0A = &"COOP_CRAFTABLES_PLACE_CANCELABLE";
	var_00.var_AC71 = 120;
	var_00.var_DDAC = 2;
	var_00.var_8487 = 0.4;
	var_00.var_C228 = 12;
	var_00.var_6A03 = "park_fireworks_trap_rocket";
	var_00.var_CC22 = 30;
	var_00.var_CC25 = 16;
	var_00.var_3AA7 = (0,0,35);
	var_00.var_3AA6 = (0,0,0);
	level.var_6DA3["crafted_ims"] = var_00;
}

//Function Number: 2
func_82B5(param_00,param_01)
{
	param_01 thread func_13932();
	param_01 notify("new_power","crafted_ims");
	param_01 setclientomnvar("zom_crafted_weapon",2);
	param_01 thread scripts\cp\_utility::func_1308C(param_01,"iw7_pickup_zm");
	scripts\cp\_utility::func_F313("crafted_ims",::func_82B5,param_01);
}

//Function Number: 3
func_13932()
{
	self endon("death");
	self endon("disconnect");
	self notify("craft_dpad_watcher");
	self endon("craft_dpad_watcher");
	self notifyonplayercommand("pullout_ims","+actionslot 3");
	for(;;)
	{
		self waittill("pullout_ims");
		if(scripts\common\utility::istrue(self.var_9D81))
		{
			continue;
		}

		if(scripts\common\utility::istrue(self.var_AD2C))
		{
			continue;
		}

		if(isdefined(self.allow_carry) && self.allow_carry == 0)
		{
			continue;
		}

		if(scripts\cp\_utility::is_valid_player())
		{
			break;
		}
	}

	thread func_82CA("crafted_ims");
}

//Function Number: 4
func_82CA(param_00)
{
	self endon("disconnect");
	scripts\cp\_utility::clearlowermessage("msg_power_hint");
	var_01 = func_48EB(param_00,self);
	self.var_A039 = var_01.name;
	scripts\cp\_utility::func_E077();
	self.var_3A9A = var_01;
	var_01.var_6DEC = 1;
	var_02 = func_F684(var_01,1);
	self.var_3A9A = undefined;
	thread scripts\cp\_utility::func_E2CC();
	return var_02;
}

//Function Number: 5
func_F684(param_00,param_01,param_02)
{
	self endon("disconnect");
	param_00 thread func_6DA0(self);
	scripts\common\utility::allow_weapon(0);
	self notifyonplayercommand("place_ims","+attack");
	self notifyonplayercommand("place_ims","+attack_akimbo_accessible");
	self notifyonplayercommand("cancel_ims","+actionslot 3");
	if(!level.console)
	{
		self notifyonplayercommand("cancel_ims","+actionslot 5");
		self notifyonplayercommand("cancel_ims","+actionslot 6");
		self notifyonplayercommand("cancel_ims","+actionslot 7");
	}

	for(;;)
	{
		var_03 = scripts\common\utility::func_13734("place_ims","cancel_ims","force_cancel_placement","player_action_slot_restart");
		if(!isdefined(var_03))
		{
			var_03 = "force_cancel_placement";
		}

		if(var_03 == "cancel_ims" || var_03 == "force_cancel_placement" || var_03 == "player_action_slot_restart")
		{
			if(!param_01 && var_03 == "cancel_ims")
			{
				continue;
			}

			param_00 func_6D9F(var_03 == "force_cancel_placement" && !isdefined(param_00.var_6DEC));
			if(var_03 != "force_cancel_placement")
			{
				thread func_13932();
			}
			else if(param_01)
			{
				scripts\cp\_utility::func_DFE0(self);
			}

			return 0;
		}

		if(!param_00.var_3872)
		{
			continue;
		}

		if(param_01)
		{
			scripts\cp\_utility::func_DFE0(self);
		}

		param_00 thread func_6DA2(param_02);
		self notify("IMS_placed");
		scripts\common\utility::allow_weapon(1);
		return 1;
	}
}

//Function Number: 6
func_48EB(param_00,param_01)
{
	if(isdefined(param_01.var_9D81) && param_01.var_9D81)
	{
		return;
	}

	var_02 = spawnturret("misc_turret",param_01.origin + (0,0,25),"sentry_minigun_mp");
	var_02.angles = param_01.angles;
	var_02.var_6DA4 = param_00;
	var_02.var_222 = param_01;
	var_02.name = "crafted_ims";
	var_02.var_3A9A = spawn("script_model",var_02.origin);
	var_02.var_3A9A.angles = param_01.angles;
	var_02 method_81F5();
	var_02 method_835B(1);
	var_02 method_830F("sentry_offline");
	var_02 makeunusable();
	var_02 method_8336(param_01);
	return var_02;
}

//Function Number: 7
func_48EA(param_00,param_01)
{
	var_02 = param_00.var_222;
	var_03 = param_00.var_6DA4;
	var_04 = spawn("script_model",param_00.origin + (0,0,1));
	var_04 setmodel(level.var_6DA3[var_03].var_B91A);
	var_04.var_EB9C = 3;
	var_04.angles = param_00.angles;
	var_04.var_6DA4 = var_03;
	var_04.var_222 = var_02;
	var_04 method_831F(var_02);
	var_04.team = var_02.team;
	var_04.name = "crafted_ims";
	var_04.var_10085 = 0;
	var_04.hidden = 0;
	var_04.var_252E = 1;
	var_04.var_8BF0 = [];
	var_04.var_451C = level.var_6DA3[var_03];
	var_04 thread func_6D9D();
	if(isdefined(param_01))
	{
		var_04 thread scripts\cp\_utility::func_A030(param_01);
	}
	else
	{
		var_04 thread scripts\cp\_utility::func_A030(undefined,level.var_6DA3[self.var_6DA4].var_AC71);
	}

	return var_04;
}

//Function Number: 8
func_936D(param_00)
{
	self.var_933C = 1;
	self notify("death");
}

//Function Number: 9
func_9367(param_00)
{
	self endon("carried");
	self waittill("death");
	if(!isdefined(self))
	{
		return;
	}

	func_6DA1();
	if(isdefined(self.var_9B05))
	{
		self.var_9B05 scripts\cp\_utility::func_E2CC();
		self notify("deleting");
		wait(1);
	}

	func_66A7();
	self delete();
}

//Function Number: 10
func_66A7()
{
	self setscriptablepartstate("base","explode");
	wait(0.5);
	radiusdamage(self.origin + (0,0,40),200,500,250,self,"MOD_EXPLOSIVE","zmb_imsprojectile_mp");
	wait(0.65);
}

//Function Number: 11
func_6D9D()
{
	self endon("death");
	level endon("game_ended");
	for(;;)
	{
		self waittill("trigger",var_00);
		if(!var_00 scripts\cp\_utility::is_valid_player())
		{
			continue;
		}

		if(scripts\common\utility::istrue(var_00.var_9D81))
		{
			continue;
		}

		var_01 = func_48EB(self.var_6DA4,var_00);
		if(!isdefined(var_01))
		{
			continue;
		}

		func_6DA1();
		if(isdefined(self getlinkedparent()))
		{
			self unlink();
		}

		var_00 thread func_F684(var_01,0,self.var_AC71);
		self delete();
		break;
	}
}

//Function Number: 12
func_6DA2(param_00)
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
	var_01 = func_48EA(self,param_00);
	var_01.var_9EE4 = 1;
	var_01 thread func_9367(self.var_222);
	self playsound("ims_plant");
	self notify("placed");
	var_01 thread func_6D9E();
	var_02 = spawnstruct();
	if(isdefined(self.var_BD3B))
	{
		var_02.var_AD39 = self.var_BD3B;
	}

	var_02.var_6371 = "carried";
	var_02.var_4E53 = ::func_936D;
	var_01 thread scripts\cp\_movers::func_892F(var_02);
	self.var_3A9A delete();
	self delete();
}

//Function Number: 13
func_6D9F(param_00)
{
	if(isdefined(self.var_3A9D))
	{
		var_01 = self.var_3A9D;
		var_01 method_80F3();
		var_01.var_9D81 = undefined;
		var_01.var_3AA0 = undefined;
		var_01 scripts\common\utility::allow_weapon(1);
	}

	if(isdefined(param_00) && param_00)
	{
		func_66A7();
	}

	self.var_3A9A delete();
	self delete();
}

//Function Number: 14
func_6DA0(param_00)
{
	self method_8335(param_00);
	self method_82C7(0);
	self setcandamage(0);
	self.var_3A9D = param_00;
	param_00.var_9D81 = 1;
	param_00 thread scripts\cp\_utility::func_12E3F(self,self.var_3A9A,level.var_6DA3["crafted_ims"]);
	thread scripts\cp\_utility::func_A025(param_00);
	thread func_936F(param_00);
	thread func_9371(param_00);
	if(isdefined(level.var_5CF2))
	{
		self thread [[ level.var_5CF2 ]](param_00);
	}

	self notify("carried");
}

//Function Number: 15
func_936F(param_00)
{
	self endon("placed");
	self endon("death");
	param_00 endon("last_stand");
	param_00 waittill("disconnect");
	func_6D9F();
}

//Function Number: 16
func_9371(param_00)
{
	self endon("placed");
	self endon("death");
	param_00 endon("last_stand");
	level waittill("game_ended");
	func_6D9F();
}

//Function Number: 17
func_6D9E()
{
	self endon("death");
	self setcursorhint("HINT_NOICON");
	self sethintstring(level.var_6DA3[self.var_6DA4].var_17B);
	scripts\cp\_utility::func_1861();
	var_00 = self.var_222;
	var_00 method_80F3();
	self makeusable();
	self method_84A5(120);
	self method_84A2(96);
	wait(0.05);
	var_01 = (0,0,27);
	var_02 = (0,0,500) - var_01;
	var_03 = self.origin;
	var_04 = self.origin + var_01;
	var_05 = bullettrace(var_04,var_04 + var_02,0,self);
	var_06 = var_05;
	self.var_2514 = var_06["position"] - (0,0,20) - self.origin;
	if(self.var_2514[2] < 250)
	{
		self.var_AA7B = "launch_low";
	}
	else if(self.var_2514[2] < 450)
	{
		self.var_AA7B = "launch_med";
	}
	else
	{
		self.var_AA7B = "launch_high";
	}

	var_07 = spawn("trigger_radius",self.origin,0,256,100);
	self.var_2536 = var_07;
	self.var_2536 enablelinkto();
	self.var_2536 linkto(self);
	self.var_2528 = length(self.var_2514) / 400;
	wait(0.75);
	self setscriptablepartstate("base","on");
	thread func_6D9C();
	thread scripts\cp\_utility::func_A021("fireworks_disconnect");
}

//Function Number: 18
func_6DA1()
{
	self makeunusable();
	if(isdefined(self.var_2536))
	{
		self.var_2536 delete();
	}

	if(isdefined(self.var_69F6))
	{
		self.var_69F6 delete();
		self.var_69F6 = undefined;
	}

	scripts\cp\_utility::func_E11E();
}

//Function Number: 19
func_6D9C()
{
	self endon("death");
	level endon("game_ended");
	for(;;)
	{
		if(!isdefined(self.var_2536))
		{
			break;
		}

		self.var_2536 waittill("trigger",var_00);
		if(isplayer(var_00) || isdefined(var_00.var_CA80) || isdefined(var_00.agent_type) && var_00.agent_type == "the_hoff")
		{
			continue;
		}

		var_01 = var_00.origin + (0,0,50);
		if(!sighttracepassed(self.var_2514 + self.origin,var_01,0,self))
		{
			continue;
		}

		if(!isdefined(self.var_2536))
		{
			break;
		}

		if(!isdefined(self.var_8BF0[self.var_252E]))
		{
			self.var_8BF0[self.var_252E] = 1;
			thread func_AA75(var_00,self.var_252E);
			self.var_252E++;
		}

		if(self.var_252E > self.var_451C.var_C228)
		{
			self setscriptablepartstate("firework","off");
			break;
		}

		self waittill("firework_exploded");
		self setscriptablepartstate("firework","off");
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

//Function Number: 20
func_AA75(param_00,param_01)
{
	self setscriptablepartstate("firework",self.var_AA7B);
	var_02 = spawn("script_model",self.origin);
	var_02 setmodel(self.var_451C.var_6A03);
	var_02.angles = self.angles;
	var_02 setscriptablepartstate("rocket","launch");
	var_03 = self.var_451C.var_39B;
	var_04 = self.var_222;
	var_02 moveto(self.var_2514 + self.origin,self.var_2528,self.var_2528 * 0.5,0);
	var_02 waittill("movedone");
	var_02 setscriptablepartstate("rocket","explode");
	wait(0.1);
	if(isdefined(var_04))
	{
		magicbullet(var_03,var_02.origin,param_00.origin,var_04);
	}
	else
	{
		magicbullet(var_03,var_02.origin,param_00.origin,level.players[0]);
	}

	var_02 delete();
	self notify("firework_exploded");
}