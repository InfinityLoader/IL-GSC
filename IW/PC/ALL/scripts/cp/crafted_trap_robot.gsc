/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\cp\crafted_trap_robot.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 26
 * Decompile Time: 1263 ms
 * Timestamp: 10/27/2023 12:10:28 AM
*******************************************************************/

//Function Number: 1
init()
{
	level.robot_trap_settings = [];
	var_00 = spawnstruct();
	var_00.var_39B = "zmb_robotprojectile_mp";
	var_00.var_B91A = "cp_disco_rocket_robot";
	var_00.var_B924 = "cp_disco_rocket_robot";
	var_00.var_B925 = "cp_disco_rocket_robot_bad";
	var_00.var_17B = &"COOP_CRAFTABLES_PICKUP";
	var_00.var_CC28 = &"COOP_CRAFTABLES_PLACE";
	var_00.var_38E3 = &"COOP_CRAFTABLES_CANNOT_PLACE";
	var_00.var_CC0A = &"COOP_CRAFTABLES_PLACE_CANCELABLE";
	var_00.var_AC71 = 120;
	var_00.var_DDAC = 2;
	var_00.var_C228 = 12;
	var_00.var_6A03 = "cp_disco_rocket_ammo_tag";
	var_00.var_CC22 = 30;
	var_00.var_CC25 = 16;
	var_00.var_3AA7 = (0,0,15);
	var_00.var_3AA6 = (0,90,0);
	level.robot_trap_settings["crafted_ims"] = var_00;
}

//Function Number: 2
give_crafted_robot_trap(param_00,param_01)
{
	param_01 thread func_13932();
	param_01 notify("new_power","crafted_robot");
	param_01 setclientomnvar("zom_crafted_weapon",12);
	param_01 thread scripts\cp\_utility::func_1308C(param_01,"iw7_pickup_zm");
	scripts\cp\_utility::func_F313("crafted_ims",::give_crafted_robot_trap,param_01);
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

	thread give_robot_trap("crafted_ims");
}

//Function Number: 4
give_robot_trap(param_00)
{
	self endon("disconnect");
	scripts\cp\_utility::clearlowermessage("msg_power_hint");
	var_01 = create_robot_trap_for_player(param_00,self);
	self.var_A039 = var_01.name;
	scripts\cp\_utility::func_E077();
	self.carried_robot_trap = var_01;
	var_01.var_6DEC = 1;
	var_02 = func_F684(var_01,1);
	self.carried_robot_trap = undefined;
	thread scripts\cp\_utility::func_E2CC();
	return var_02;
}

//Function Number: 5
func_F684(param_00,param_01,param_02)
{
	self endon("disconnect");
	param_00 thread robot_trap_setcarried(self);
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

			param_00 robot_trap_setcancelled(var_03 == "force_cancel_placement" && !isdefined(param_00.var_6DEC));
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

		param_00 thread robot_trap_setplaced(param_02);
		self notify("IMS_placed");
		scripts\common\utility::func_5127(0.5,::scripts\common\utility::allow_weapon,1);
		return 1;
	}
}

//Function Number: 6
create_robot_trap_for_player(param_00,param_01)
{
	if(isdefined(param_01.var_9D81) && param_01.var_9D81)
	{
		return;
	}

	var_02 = spawnturret("misc_turret",param_01.origin + (0,0,25),"sentry_minigun_mp");
	var_02.angles = param_01.angles;
	var_02.robot_trap_type = param_00;
	var_02.var_222 = param_01;
	var_02.name = "crafted_ims";
	var_02.carried_robot_trap = spawn("script_model",var_02.origin);
	var_02.carried_robot_trap.angles = param_01.angles;
	var_02 method_81F5();
	var_02 method_835B(1);
	var_02 method_830F("sentry_offline");
	var_02 makeunusable();
	var_02 method_8336(param_01);
	return var_02;
}

//Function Number: 7
create_robot_trap(param_00,param_01)
{
	var_02 = param_00.var_222;
	var_03 = param_00.robot_trap_type;
	var_04 = spawn("script_model",param_00.origin + (0,0,2));
	var_04 setmodel(level.robot_trap_settings[var_03].var_B91A);
	var_04.var_EB9C = 3;
	var_04.angles = (0,param_00.carried_robot_trap.angles[1],0);
	var_04.robot_trap_type = var_03;
	var_04.var_222 = var_02;
	var_04 method_831F(var_02);
	var_04.team = var_02.team;
	var_04.name = "crafted_ims";
	var_04.var_10085 = 0;
	var_04.hidden = 0;
	var_04.var_252E = 1;
	var_04.var_8BF0 = [];
	var_04.var_451C = level.robot_trap_settings[var_03];
	var_04 thread robot_trap_handleuse();
	if(isdefined(param_01))
	{
		var_04 thread scripts\cp\_utility::func_A030(param_01);
	}
	else
	{
		var_04 thread scripts\cp\_utility::func_A030(undefined,level.robot_trap_settings[self.robot_trap_type].var_AC71);
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

	robot_trap_setinactive();
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
	self setscriptablepartstate("main","anim_death");
	wait(3);
	playsoundatpos(self.origin + (0,0,60),"disco_toy_robot_explo");
	wait(0.1);
	radiusdamage(self.origin + (0,0,40),200,500,250,self,"MOD_EXPLOSIVE","zmb_imsprojectile_mp");
	self hide();
	wait(0.65);
	physicsexplosionsphere(self.origin,256,256,2);
}

//Function Number: 11
robot_trap_handleuse()
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

		if(scripts\common\utility::istrue(var_00.kung_fu_mode))
		{
			continue;
		}

		var_01 = create_robot_trap_for_player(self.robot_trap_type,var_00);
		if(!isdefined(var_01))
		{
			continue;
		}

		robot_trap_setinactive();
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
robot_trap_setplaced(param_00)
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
	var_01 = create_robot_trap(self,param_00);
	var_01.var_9EE4 = 1;
	var_01 thread func_9367(self.var_222);
	self playsound("trap_boom_box_drop");
	self notify("placed");
	var_01 thread robot_trap_setactive();
	var_02 = spawnstruct();
	if(isdefined(self.var_BD3B))
	{
		var_02.var_AD39 = self.var_BD3B;
	}

	var_02.var_6371 = "carried";
	var_02.var_4E53 = ::func_936D;
	var_01 thread scripts\cp\_movers::func_892F(var_02);
	self.carried_robot_trap delete();
	self delete();
}

//Function Number: 13
robot_trap_setcancelled(param_00)
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

	self.carried_robot_trap delete();
	self delete();
}

//Function Number: 14
robot_trap_setcarried(param_00)
{
	self method_8335(param_00);
	self method_82C7(0);
	self setcandamage(0);
	self.var_3A9D = param_00;
	param_00.var_9D81 = 1;
	param_00 thread scripts\cp\_utility::func_12E3F(self,self.carried_robot_trap,level.robot_trap_settings["crafted_ims"]);
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
	robot_trap_setcancelled();
}

//Function Number: 16
func_9371(param_00)
{
	self endon("placed");
	self endon("death");
	param_00 endon("last_stand");
	level waittill("game_ended");
	robot_trap_setcancelled();
}

//Function Number: 17
robot_trap_setactive()
{
	self endon("death");
	self setcursorhint("HINT_NOICON");
	self sethintstring(level.robot_trap_settings[self.robot_trap_type].var_17B);
	scripts\cp\_utility::func_1861();
	var_00 = self.var_222;
	var_00 method_80F3();
	self method_84A5(120);
	self method_84A2(96);
	wait(0.05);
	self.var_2514 = self gettagorigin("tag_rocket_tube_01") + (0,0,72);
	self.alt_attackheightpos = self.var_2514;
	var_01 = bullettrace(self.var_2514,self.var_2514 + (0,0,500),0,self);
	var_02 = var_01["position"] - (0,0,20) - self.origin;
	if(var_02[2] > 250)
	{
		self.var_2514 = self gettagorigin("tag_rocket_tube_01") + (0,0,250);
	}

	self.attacklaunchpos = [];
	self.attacklaunchpos[0] = self gettagorigin("tag_rocket_tube_01") + (0,0,-10);
	self.attacklaunchpos[1] = self gettagorigin("tag_rocket_tube_02") + (0,0,-10);
	var_03 = spawn("trigger_radius",self.origin,0,300,100);
	self.var_2536 = var_03;
	self.var_2536 enablelinkto();
	self.var_2536 linkto(self);
	self.var_2528 = 0.72;
	wait(0.75);
	self setscriptablepartstate("main","anim_idle");
	self setscriptablepartstate("head_coils","on");
	self setscriptablepartstate("LED_Panel","Idle");
	thread rotate_robot();
	if(isdefined(self.var_222))
	{
		thread robot_usability_monitor(self.var_222);
	}

	thread robot_trap_attackzombies();
	thread scripts\cp\_utility::func_A021("robot_disconnect");
}

//Function Number: 18
rotate_robot()
{
	self endon("death");
	self playloopsound("disco_toy_robot_mvmt_lp");
	for(;;)
	{
		self rotateyaw(15,2);
		wait(2);
	}
}

//Function Number: 19
robot_trap_setinactive()
{
	self makeunusable();
	self stoploopsound();
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

//Function Number: 20
robot_usability_monitor(param_00)
{
	self endon("death");
	param_00 endon("disconnect");
	for(;;)
	{
		foreach(var_02 in level.players)
		{
			if(var_02 == param_00)
			{
				if(scripts\common\utility::istrue(param_00.kung_fu_mode))
				{
					self makeunusable();
					self disableplayeruse(param_00);
				}
				else
				{
					self sethintstring(level.robot_trap_settings[self.robot_trap_type].var_17B);
					self method_84A5(120);
					self method_84A2(112);
					self makeusable();
					self enableplayeruse(param_00);
				}

				continue;
			}

			self disableplayeruse(var_02);
		}

		wait(1);
	}
}

//Function Number: 21
robot_trap_attackzombies()
{
	self endon("death");
	level endon("game_ended");
	self setscriptablepartstate("LED_Face","Smile");
	for(;;)
	{
		if(!isdefined(self.var_2536))
		{
			break;
		}

		self.var_2536 waittill("trigger",var_00);
		if(isplayer(var_00))
		{
			continue;
		}

		if(!scripts\cp\_utility::func_FF18(var_00,0,1))
		{
			continue;
		}

		if(var_00.agent_type == "ratking")
		{
			continue;
		}

		if(isdefined(var_00.robot_target))
		{
			continue;
		}

		if(distancesquared(var_00.origin,self.origin) < 9216)
		{
			var_00.robot_target = 1;
			self setscriptablepartstate("LED_Face","Sad");
			self setscriptablepartstate("LED_Panel","ZAP");
			thread robot_zap(var_00);
			wait(0.5);
			self setscriptablepartstate("LED_Face","Smile");
			self setscriptablepartstate("LED_Panel","Idle");
			continue;
		}

		var_01 = var_00.origin + (0,0,50);
		var_02 = 0;
		if(!sighttracepassed(self.var_2514,var_01,0,self))
		{
			if(!sighttracepassed(self.alt_attackheightpos,var_01,0,self))
			{
				continue;
			}

			var_02 = 1;
		}

		if(!isdefined(self.var_2536))
		{
			break;
		}

		if(!isdefined(self.var_8BF0[self.var_252E]))
		{
			var_00.robot_target = 1;
			self.var_8BF0[self.var_252E] = 1;
			self.var_252E++;
			thread launch_rocket(var_00,self.var_252E,var_02);
		}

		if(self.var_252E % 2)
		{
			self waittill("firework_exploded");
		}

		wait(self.var_451C.var_DDAC);
		if(!isdefined(self.var_222))
		{
			break;
		}

		if(self.var_252E >= level.robot_trap_settings["crafted_ims"].var_C228)
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

//Function Number: 22
robot_zap(param_00)
{
	param_00.dontmutilate = 1;
	param_00.electrocuted = 1;
	thread func_601A(param_00);
	param_00 setscriptablepartstate("electrocuted","on");
	if(isdefined(self.var_222))
	{
		var_01 = self.var_222;
	}
	else
	{
		var_01 = undefined;
	}

	param_00 dodamage(param_00.health + 100,self.origin,var_01,self,"MOD_UNKNOWN","iw7_robotzap_zm");
}

//Function Number: 23
func_601A(param_00)
{
	param_00 endon("death");
	var_01 = ["J_SpineLower","J_Chest","J_Head","J_Neck","J_Crotch"];
	var_02 = self gettagorigin("tag_fx_laser_dish");
	var_03 = scripts\common\utility::random(var_01);
	var_04 = param_00 gettagorigin(var_03);
	playsoundatpos(self.origin,"trap_electric_shock");
	function_02E0(level._effect["robot_zap"],var_02,vectortoangles(var_04 - var_02),var_04);
}

//Function Number: 24
launch_rocket(param_00,param_01,param_02)
{
	if(!isdefined(self.last_launch_tube))
	{
		self.last_launch_tube = 0;
	}

	if(self.last_launch_tube == 0)
	{
		var_03 = self.attacklaunchpos[1];
		self setscriptablepartstate("right_launch","launch");
	}
	else
	{
		self setscriptablepartstate("left_launch","launch");
		var_03 = self.attacklaunchpos[0];
	}

	thread launch_anim();
	if(self.last_launch_tube == 0)
	{
		self.last_launch_tube = 1;
	}
	else
	{
		self.last_launch_tube = 0;
	}

	var_04 = spawn("script_model",var_03);
	var_04 setmodel(self.var_451C.var_6A03);
	var_04.angles = self.angles;
	var_05 = self.var_451C.var_39B;
	var_06 = self.var_222;
	var_07 = self.var_2514;
	if(param_02)
	{
		var_07 = self.alt_attackheightpos;
	}

	var_04 moveto(var_07,self.var_2528,self.var_2528 * 0.5,0);
	wait(self.var_2528);
	var_04 setscriptablepartstate("rocket","explode");
	if(isdefined(var_06))
	{
		var_08 = magicbullet(var_05,var_04.origin,(param_00.origin[0],param_00.origin[1],var_04.origin[2] - 5),var_06);
	}
	else
	{
		var_08 = magicbullet(var_06,var_05.origin,param_01.origin,level.players[0]);
	}

	var_08 thread watch_for_death();
	wait(0.1);
	var_04 delete();
	var_08 missile_settargetent(param_00);
	wait(1.5);
	self notify("firework_exploded");
}

//Function Number: 25
launch_anim()
{
	self endon("death");
	self setscriptablepartstate("main","anim_launch");
	self setscriptablepartstate("LED_Panel","Boom");
	self setscriptablepartstate("LED_Face","Sad");
	wait(1);
	if(self.var_252E % 2)
	{
		self setscriptablepartstate("main","anim_headspin");
		wait(1);
	}

	self setscriptablepartstate("LED_Panel","Idle");
	self setscriptablepartstate("LED_Face","Smile");
	self setscriptablepartstate("main","anim_idle");
}

//Function Number: 26
watch_for_death()
{
	self waittill("death");
	earthquake(0.35,1,self.origin,196);
	playrumbleonposition("artillery_rumble",self.origin);
}