/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3395.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 8
 * Decompile Time: 3 ms
 * Timestamp: 10/27/2023 12:26:55 AM
*******************************************************************/

//Function Number: 1
func_DAFF(param_00,param_01)
{
	param_01.var_8B8B = 1;
	param_01.var_A8D3 = undefined;
	param_01 thread func_13932();
	param_01 notify("new_power","crafted_windowtrap");
	param_01 setclientomnvar("zom_crafted_weapon",8);
	param_01 thread scripts\cp\_utility::func_1308C(param_01,"iw7_pickup_zm");
	scripts\cp\_utility::func_F313("crafted_windowtrap",::func_DAFF,param_01);
}

//Function Number: 2
func_13932()
{
	self endon("disconnect");
	self notify("craft_dpad_watcher");
	self endon("craft_dpad_watcher");
	self endon("death");
	self notifyonplayercommand("pullout_windowtrap","+actionslot 3");
	for(;;)
	{
		self waittill("pullout_windowtrap");
		if(scripts\common\utility::istrue(self.var_9D81))
		{
			continue;
		}

		if(scripts\common\utility::istrue(self.var_AD2C))
		{
			continue;
		}

		if(!scripts\cp\_utility::is_valid_player())
		{
			continue;
		}

		var_00 = func_9B93();
		if(var_00 == "has_trap")
		{
			scripts\cp\_utility::setlowermessage("window",&"ZOMBIE_CRAFTING_SOUVENIRS_WINDOW_HAS_TRAP",4);
			continue;
		}
		else if(var_00 == "not_window")
		{
			scripts\cp\_utility::setlowermessage("not_window",&"ZOMBIE_CRAFTING_SOUVENIRS_NEAR_WINDOW",4);
			continue;
		}
		else
		{
			break;
		}
	}

	var_01 = undefined;
	if(isdefined(self.var_A8D3))
	{
		var_01 = self.var_A8D3;
	}

	if(isdefined(self.var_DDB0))
	{
		var_01 = self.var_DDB0;
	}

	if(!isdefined(var_01))
	{
		return;
	}

	level thread func_CC08(var_01,self);
}

//Function Number: 3
func_9B93()
{
	if(isdefined(self.var_DDB0))
	{
		return "valid";
	}

	if(!isdefined(self.var_A8D3) && !isdefined(self.var_DDB0))
	{
		return "not_window";
	}

	if(!scripts\cp\_interaction::func_9A2B(self.var_A8D3))
	{
		return "not_window";
	}

	if(scripts\common\utility::istrue(self.var_A8D3.var_8BB7))
	{
		return "has_trap";
	}

	return "valid";
}

//Function Number: 4
func_CC08(param_00,param_01)
{
	var_02 = scripts\common\utility::getstruct(param_00.target,"targetname");
	var_03 = var_02.angles;
	level thread func_A86F(param_00,var_02,param_01);
	param_01 notify("window_trap_placed");
	if(!isdefined(param_01.var_1193D["crafted_windowtrap"]))
	{
		param_01.var_1193D["crafted_windowtrap"] = gettime();
	}
	else
	{
		param_01.var_1193D["crafted_windowtrap"] = param_01.var_1193D["crafted_windowtrap"] + gettime() - param_01.var_1193D["crafted_windowtrap"];
	}

	param_01.var_A039 = "crafted_windowtrap";
	param_01.var_A6C6["crafted_windowtrap"] = 0;
	param_00.var_8BB7 = 1;
	param_01.var_A8D3 = undefined;
	scripts\cp\_utility::func_DFE0(param_01);
}

//Function Number: 5
func_A86F(param_00,param_01,param_02)
{
	var_03 = spawn("trigger_radius",param_01.origin,1,8,72);
	var_03 endon("death");
	playsoundatpos(param_01.origin,"trap_laser_activate");
	var_04 = param_01.angles;
	var_03.var_13D73 = spawnfx(level._effect["laser_window_trap"],param_01.origin + (0,0,-10),anglestoforward(var_04),anglestoup(var_04));
	triggerfx(var_03.var_13D73);
	var_03.var_A86A = scripts\common\utility::play_loopsound_in_space("trap_laser_lp",param_01.origin);
	var_03 thread func_A870(param_01,param_02,1,param_00);
	for(;;)
	{
		var_03 waittill("trigger",var_05);
		if(isplayer(var_05))
		{
			continue;
		}

		if(isalive(var_05) && !scripts\common\utility::istrue(var_05.var_B36E))
		{
			var_05.var_B36E = 1;
			var_05.var_126A3 = param_02;
			var_05.var_9B81 = 1;
			var_05 playsound("trap_laser_damage");
			var_05 thread func_4CDE(param_02,undefined,undefined,var_03);
			var_05 thread scripts\cp\zombies\zombie_scriptable_states::applyzombiescriptablestate(var_05);
		}
	}
}

//Function Number: 6
func_A870(param_00,param_01,param_02,param_03)
{
	self endon("death");
	self.var_222 = param_01;
	var_04 = gettime() + 300000;
	while(gettime() < var_04)
	{
		wait(1);
	}

	thread func_138EB(param_00,param_01,param_02,param_03);
}

//Function Number: 7
func_138EB(param_00,param_01,param_02,param_03)
{
	self playsound("trap_laser_warning");
	wait(1.45);
	self playsound("trap_laser_explode");
	param_03.var_8BB7 = undefined;
	self.var_13D73 delete();
	self.var_A86A delete();
	self stoploopsound();
	self delete();
	var_04 = spawnfx(level.var_B761,param_00.origin);
	triggerfx(var_04);
	var_04 thread scripts\cp\_utility::func_5106(1);
	if(param_01 scripts\cp\_utility::is_valid_player(1))
	{
		radiusdamage(param_00.origin,512,100000,100000,param_01,"MOD_EXPLOSIVE","zmb_imsprojectile_mp");
	}
	else
	{
		radiusdamage(param_00.origin,512,100000,100000,level.players[0],"MOD_EXPLOSIVE","zmb_imsprojectile_mp");
	}

	param_00 thread scripts\cp\_weapon::func_858A();
}

//Function Number: 8
func_4CDE(param_00,param_01,param_02,param_03)
{
	self endon("death");
	param_03 endon("death");
	if(!isdefined(param_02))
	{
		param_02 = min(self.health + 100,10000);
	}

	if(!isdefined(param_01))
	{
		param_01 = 2;
	}

	var_04 = 0;
	var_05 = 6;
	var_06 = param_01 / var_05;
	var_07 = param_02 / var_05;
	param_00.var_A039 = "crafted_windowtrap";
	for(var_08 = 0;var_08 < var_05;var_08++)
	{
		wait(var_06);
		if(isalive(self))
		{
			if(isdefined(param_03.var_222) && param_03.var_222 scripts\cp\_utility::is_valid_player(1))
			{
				self dodamage(var_07,self.origin,level.players[0],level.players[0],"MOD_UNKNOWN","zmb_imsprojectile_mp");
				continue;
			}

			self dodamage(var_07,self.origin,level.players[0],level.players[0],"MOD_UNKNOWN","zmb_imsprojectile_mp");
		}
	}

	wait(2);
	self.var_9B81 = undefined;
}