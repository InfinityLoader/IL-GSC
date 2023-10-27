/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\zombies\weapons\_zombie_de_lisle_carbine.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 5
 * Decompile Time: 95 ms
 * Timestamp: 10/27/2023 3:12:56 AM
*******************************************************************/

//Function Number: 1
func_00D5()
{
	level.var_611["trap_ready_red"] = loadfx("vfx/zombie/zmb_trap_light_red");
	level.var_611["trap_ready_blue"] = loadfx("vfx/zombie/zmb_trap_light_blue");
	level thread maps\mp\_utility::func_6F74(::player_fire_tracking);
}

//Function Number: 2
player_fire_tracking()
{
	var_00 = self;
	var_00 endon("disconnect");
	var_01 = spawn("script_model",(0,0,0));
	var_01 setmodel("tag_origin");
	var_01 method_805C();
	var_00 maps\mp\gametypes\_playerlogic::deleteentonplayerdisconnect(var_01);
	var_02 = maps/mp/gametypes/zombies::func_1E59(lib_0547::func_A51("zombie_generic"),35);
	for(;;)
	{
		var_00 waittill("weapon_fired",var_03);
		var_03 = lib_0547::func_AAF9(var_03,1);
		if(!lib_0547::func_5565(var_03,"delisle_pap_zm") && !lib_0547::func_5565(var_03,"wz35_pap_zm"))
		{
			continue;
		}

		var_04 = var_00 geteye();
		var_05 = var_04 + 10000 * vectornormalize(anglestoforward(var_00 geteyeangles()));
		var_06 = bullettrace(var_04,var_05,1,var_00);
		var_07 = bullettrace(var_04,var_05,0,var_00,0,0,0,0,1,0,0);
		var_08 = distance(var_06["position"],var_07["position"]);
		if(var_08 < 4)
		{
			var_01 method_805B();
			var_01.var_116 = vectorlerp(var_04,var_07["position"],0.99);
			var_01 set_fx("trap_ready");
			if(lib_0547::func_5565(var_03,"delisle_pap_zm"))
			{
				wait(2);
			}
			else
			{
				wait(1);
			}

			if(lib_0547::func_5565(var_03,"delisle_pap_zm"))
			{
				var_01 set_fx("trap_ready_red");
			}
			else
			{
				var_01 set_fx("trap_ready_blue");
			}

			wait(1);
			var_09 = 10;
			while(var_09 > 0)
			{
				var_0A = [];
				var_0A = var_01 get_close_zombies(var_00,lib_0547::func_5565(var_03,"delisle_pap_zm"));
				if(var_0A.size > 0)
				{
					break;
				}

				var_09 = var_09 - 0.1;
				wait(0.1);
			}

			wait(0.5);
			var_0A = var_01 get_close_zombies(var_00,lib_0547::func_5565(var_03,"delisle_pap_zm"));
			var_01 clear_betty();
			if(lib_0547::func_5565(var_03,"delisle_pap_zm"))
			{
				for(var_0B = 0;var_0B < var_0A.size;var_0B++)
				{
					if(var_0B == 5)
					{
						break;
					}

					var_0C = magicbullet("delisle_pap_zm",var_01.var_116,var_0A[var_0B] geteye(),var_00);
					var_0A[var_0B] dodamage(var_02,var_01.var_116,var_00,var_0C,"MOD_RIFLE_BULLET","delisle_pap_zm","head");
				}
			}
			else
			{
				var_00 maps/mp/zombies/weapons/_zombie_type_38::spawn_electro_blast(var_01.var_116,1);
			}
		}
	}
}

//Function Number: 3
get_close_zombies(param_00,param_01)
{
	var_02 = [];
	var_03 = self;
	if(param_01)
	{
		var_04 = 375;
	}
	else
	{
		var_04 = 160;
	}

	foreach(var_06 in lib_0547::func_408F())
	{
		if(distance(var_03.var_116,var_06.var_116) > var_04)
		{
			continue;
		}

		var_02 = common_scripts\utility::func_F6F(var_02,var_06);
	}

	return var_02;
}

//Function Number: 4
clear_betty()
{
	if(isdefined(self.var_3F2F))
	{
		self.var_3F2F delete();
	}
}

//Function Number: 5
set_fx(param_00)
{
	var_01 = self;
	if(isdefined(var_01.var_3F2F))
	{
		var_01.var_3F2F delete();
	}

	var_02 = spawnlinkedfx(level.var_611[param_00],var_01,"tag_origin");
	triggerfx(var_02);
	var_01.var_3F2F = var_02;
}