/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\engine\_trace.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 40
 * Decompile Time: 1986 ms
 * Timestamp: 10/27/2023 12:10:51 AM
*******************************************************************/

//Function Number: 1
func_DCED(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = scripts\common\utility::func_116D7(isdefined(param_03),param_03,func_48CC());
	var_07 = scripts\common\utility::func_116D7(isdefined(param_05),param_05,0);
	var_08 = function_0287(param_00,param_01,var_06,param_02,0,"physicsquery_closest",var_07);
	if(var_08.size)
	{
		var_08 = var_08[0];
	}
	else
	{
		var_08 = func_9A81(param_01);
	}

	if(isdefined(param_04) && param_04)
	{
		var_08 = func_45F5(var_08);
	}

	return var_08;
}

//Function Number: 2
func_DCEE(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = scripts\common\utility::func_116D7(isdefined(param_03),param_03,func_48CC());
	var_07 = scripts\common\utility::func_116D7(isdefined(param_05),param_05,0);
	var_08 = function_0287(param_00,param_01,var_06,param_02,1,"physicsquery_closest",var_07);
	if(var_08.size)
	{
		var_08 = var_08[0];
	}
	else
	{
		var_08 = func_9A81(param_01);
	}

	if(isdefined(param_04) && param_04)
	{
		var_08 = func_45F5(var_08);
	}

	return var_08;
}

//Function Number: 3
func_DCF0(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = scripts\common\utility::func_116D7(isdefined(param_03),param_03,func_48CC());
	var_06 = function_0287(param_00,param_01,var_05,param_02,0,"physicsquery_all");
	if(isdefined(param_04) && param_04)
	{
		foreach(var_08 in var_06)
		{
			var_08 = func_45F5(var_08);
		}
	}

	return var_06;
}

//Function Number: 4
func_DCF1(param_00,param_01,param_02,param_03)
{
	var_04 = scripts\common\utility::func_116D7(isdefined(param_03),param_03,func_48CC());
	return !function_0287(param_00,param_01,var_04,param_02,0,"physicsquery_any");
}

//Function Number: 5
func_DCEF(param_00,param_01,param_02,param_03)
{
	var_04 = scripts\common\utility::func_116D7(isdefined(param_03),param_03,func_48CC());
	return !function_0287(param_00,param_01,var_04,param_02,1,"physicsquery_any");
}

//Function Number: 6
func_109DD(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = scripts\common\utility::func_116D7(isdefined(param_04),param_04,func_48CC());
	var_07 = function_0288(param_00,param_01,param_02,var_06,param_03,"physicsquery_closest");
	if(var_07.size)
	{
		var_07 = var_07[0];
	}
	else
	{
		var_07 = func_9A81(param_01);
	}

	if(isdefined(param_05) && param_05)
	{
		var_07 = func_45F5(var_07);
	}

	return var_07;
}

//Function Number: 7
func_109DE(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = scripts\common\utility::func_116D7(isdefined(param_04),param_04,func_48CC());
	var_07 = function_0288(param_00,param_01,param_02,var_06,param_03,"physicsquery_all");
	if(isdefined(param_05) && param_05)
	{
		foreach(var_09 in var_07)
		{
			var_09 = func_45F5(var_09);
		}
	}

	return var_07;
}

//Function Number: 8
func_109DF(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = scripts\common\utility::func_116D7(isdefined(param_04),param_04,func_48CC());
	return !function_0288(param_00,param_01,param_02,var_05,param_03,"physicsquery_any");
}

//Function Number: 9
func_109DC(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = scripts\common\utility::func_116D7(isdefined(param_04),param_04,func_48CC());
	var_07 = function_028C(param_00,param_01,param_02,var_06,param_03,"physicsquery_closest");
	if(var_07.size)
	{
		var_07 = var_07[0];
	}
	else
	{
		var_07 = func_9A81(param_00);
	}

	if(isdefined(param_05) && param_05)
	{
		var_07 = func_45F5(var_07);
	}

	return var_07;
}

//Function Number: 10
func_3A09(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	if(!isdefined(param_04))
	{
		param_04 = (0,0,0);
	}

	var_08 = scripts\common\utility::func_116D7(isdefined(param_06),param_06,func_48CC());
	var_09 = func_45EC(param_00,param_01,param_02,param_03,param_04);
	var_0A = function_0289(var_09["trace_start"],var_09["trace_end"],param_02,var_09["half_height"],param_04,var_08,param_05,"physicsquery_closest");
	if(var_0A.size)
	{
		var_0A = var_0A[0];
	}
	else
	{
		var_0A = func_9A81(param_01);
	}

	if(isdefined(param_07) && param_07)
	{
		var_0A = func_45F5(var_0A);
	}

	return var_0A;
}

//Function Number: 11
func_3A0A(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	if(!isdefined(param_04))
	{
		param_04 = (0,0,0);
	}

	var_08 = scripts\common\utility::func_116D7(isdefined(param_06),param_06,func_48CC());
	var_09 = func_45EC(param_00,param_01,param_02,param_03,param_04);
	var_0A = function_0289(var_09["trace_start"],var_09["trace_end"],param_02,var_09["half_height"],param_04,var_08,param_05,"physicsquery_all");
	if(isdefined(param_07) && param_07)
	{
		foreach(var_0C in var_0A)
		{
			var_0C = func_45F5(var_0C);
		}
	}

	return var_0A;
}

//Function Number: 12
func_3A0B(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	if(!isdefined(param_04))
	{
		param_04 = (0,0,0);
	}

	var_07 = scripts\common\utility::func_116D7(isdefined(param_06),param_06,func_48CC());
	var_08 = func_45EC(param_00,param_01,param_02,param_03,param_04);
	return !function_0289(var_08["trace_start"],var_08["trace_end"],param_02,var_08["half_height"],param_04,var_07,param_05,"physicsquery_any");
}

//Function Number: 13
func_3A08(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	if(!isdefined(param_03))
	{
		param_03 = (0,0,0);
	}

	var_08 = scripts\common\utility::func_116D7(isdefined(param_06),param_06,func_48CC());
	var_09 = func_45EC(param_00,undefined,param_01,param_02,param_03);
	var_0A = function_028D(var_09["trace_start"],param_01,var_09["half_height"],param_03,param_04,var_08,param_05,"physicsquery_closest");
	if(var_0A.size)
	{
		var_0A = var_0A[0];
	}
	else
	{
		var_0A = func_9A81(param_00);
	}

	if(isdefined(param_07) && param_07)
	{
		var_0A = func_45F5(var_0A);
	}

	return var_0A;
}

//Function Number: 14
func_D305(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	if(!isplayer(self))
	{
		return;
	}

	if(!isdefined(param_02))
	{
		param_02 = self getplayerangles();
	}

	var_07 = scripts\common\utility::func_116D7(isdefined(param_04),param_04,func_48CC());
	if(!isdefined(param_06))
	{
		param_06 = 0;
	}

	var_08 = function_0298(param_00,param_01,self,param_06,param_02,var_07,param_03,"physicsquery_closest");
	if(var_08.size)
	{
		var_08 = var_08[0];
	}
	else
	{
		var_08 = func_9A81(param_01);
	}

	if(isdefined(param_05) && param_05)
	{
		var_08 = func_45F5(var_08);
	}

	return var_08;
}

//Function Number: 15
func_D306(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	if(!isplayer(self))
	{
		return;
	}

	if(!isdefined(param_02))
	{
		param_02 = self getplayerangles();
	}

	var_07 = scripts\common\utility::func_116D7(isdefined(param_04),param_04,func_48CC());
	if(!isdefined(param_06))
	{
		param_06 = 0;
	}

	var_08 = function_0298(param_00,param_01,self,param_06,param_02,var_07,param_03,"physicsquery_all");
	if(isdefined(param_05) && param_05)
	{
		foreach(var_0A in var_08)
		{
			var_0A = func_45F5(var_0A);
		}
	}

	return var_08;
}

//Function Number: 16
func_D307(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(!isplayer(self))
	{
		return;
	}

	if(!isdefined(param_02))
	{
		param_02 = self getplayerangles();
	}

	var_06 = scripts\common\utility::func_116D7(isdefined(param_04),param_04,func_48CC());
	if(!isdefined(param_05))
	{
		param_05 = 0;
	}

	return !function_0298(param_00,param_01,self,param_05,param_02,var_06,param_03,"physicsquery_any");
}

//Function Number: 17
func_D096(param_00,param_01,param_02,param_03)
{
	return func_D095(self.origin,self.angles,param_00,param_01,param_02,param_03);
}

//Function Number: 18
func_D095(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(!isplayer(self))
	{
		return;
	}

	if(!isdefined(param_01))
	{
		param_01 = self getplayerangles();
	}

	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	if(isarray(param_03))
	{
		param_03 = scripts\common\utility::array_add(param_03,self);
	}
	else
	{
		param_03 = self;
	}

	var_06 = scripts\common\utility::func_116D7(isdefined(param_04),param_04,func_48CC());
	var_07 = function_0299(param_00,self,0,param_01,param_02,var_06,param_03,"physicsquery_closest");
	if(var_07.size)
	{
		var_07 = var_07[0];
	}
	else
	{
		var_07 = func_9A81(param_00);
	}

	if(isdefined(param_05) && param_05)
	{
		var_07 = func_45F5(var_07);
	}

	return var_07;
}

//Function Number: 19
func_19F2(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	if(!isai(self))
	{
		return;
	}

	if(!isdefined(param_02))
	{
		param_02 = self.angles;
	}

	var_07 = scripts\common\utility::func_116D7(isdefined(param_04),param_04,func_48CC());
	if(!isdefined(param_06))
	{
		param_06 = 0;
	}

	var_08 = function_0298(param_00,param_01,self,param_06,param_02,var_07,param_03,"physicsquery_closest");
	if(var_08.size)
	{
		var_08 = var_08[0];
	}
	else
	{
		var_08 = func_9A81(param_01);
	}

	if(isdefined(param_05) && param_05)
	{
		var_08 = func_45F5(var_08);
	}

	return var_08;
}

//Function Number: 20
func_19F3(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	if(!isai(self))
	{
		return;
	}

	if(!isdefined(param_02))
	{
		param_02 = self.angles;
	}

	var_07 = scripts\common\utility::func_116D7(isdefined(param_04),param_04,func_48CC());
	if(!isdefined(param_06))
	{
		param_06 = 0;
	}

	var_08 = function_0298(param_00,param_01,self,param_06,param_02,var_07,param_03,"physicsquery_all");
	if(isdefined(param_05) && param_05)
	{
		foreach(var_0A in var_08)
		{
			var_0A = func_45F5(var_0A);
		}
	}

	return var_08;
}

//Function Number: 21
func_19F4(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(!isai(self))
	{
		return;
	}

	if(!isdefined(param_02))
	{
		param_02 = self.angles;
	}

	var_06 = scripts\common\utility::func_116D7(isdefined(param_04),param_04,func_48CC());
	if(!isdefined(param_05))
	{
		param_05 = 0;
	}

	return !function_0298(param_00,param_01,self,param_05,param_02,var_06,param_03,"physicsquery_any");
}

//Function Number: 22
func_196D(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(!isai(self))
	{
		return;
	}

	if(!isdefined(param_01))
	{
		param_01 = self.angles;
	}

	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	var_06 = scripts\common\utility::func_116D7(isdefined(param_04),param_04,func_48CC());
	var_07 = function_0299(param_00,self,param_01,param_02,var_06,param_03,"physicsquery_closest");
	if(var_07.size)
	{
		var_07 = var_07[0];
	}
	else
	{
		var_07 = func_9A81(param_00);
	}

	if(isdefined(param_05) && param_05)
	{
		var_07 = func_45F5(var_07);
	}

	return var_07;
}

//Function Number: 23
func_4956(param_00)
{
	var_01 = ["physicscontents_solid","physicscontents_monsterclip","physicscontents_aiavoid","physicscontents_glass","physicscontents_vehicle"];
	if(!isdefined(param_00) || !param_00)
	{
		var_01 = scripts\common\utility::array_add(var_01,"physicscontents_player");
	}

	return physics_createcontents(var_01);
}

//Function Number: 24
func_497D()
{
	var_00 = ["physicscontents_solid","physicscontents_water","physicscontents_sky"];
	return physics_createcontents(var_00);
}

//Function Number: 25
func_48F5()
{
	var_00 = ["physicscontents_glass"];
	return physics_createcontents(var_00);
}

//Function Number: 26
func_4909()
{
	var_00 = ["physicscontents_item"];
	return physics_createcontents(var_00);
}

//Function Number: 27
func_4972()
{
	var_00 = ["physicscontents_vehicle"];
	return physics_createcontents(var_00);
}

//Function Number: 28
func_4950()
{
	var_00 = ["physicscontents_clipshot","physicscontents_corpseclipshot","physicscontents_missileclip"];
	return physics_createcontents(var_00);
}

//Function Number: 29
func_493E()
{
	var_00 = ["physicscontents_playerclip"];
	return physics_createcontents(var_00);
}

//Function Number: 30
func_48B1()
{
	var_00 = ["physicscontents_player","physicscontents_actor"];
	return physics_createcontents(var_00);
}

//Function Number: 31
func_48CC(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 0;
	}

	return func_48BC(!param_00,1,1,1,0,1);
}

//Function Number: 32
func_48BC(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	var_07 = 0;
	if(isdefined(param_00) && param_00)
	{
		var_07 = var_07 + func_48B1();
	}

	if(isdefined(param_01) && param_01)
	{
		var_07 = var_07 + func_497D();
	}

	if(isdefined(param_02) && param_02)
	{
		var_07 = var_07 + func_48F5();
	}

	if(isdefined(param_03) && param_03)
	{
		var_07 = var_07 + func_4950();
	}

	if(isdefined(param_04) && param_04)
	{
		var_07 = var_07 + func_4909();
	}

	if(isdefined(param_05) && param_05)
	{
		var_07 = var_07 + func_4972();
	}

	if(isdefined(param_06) && param_06)
	{
		var_07 = var_07 + func_493E();
	}

	return var_07;
}

//Function Number: 33
func_489A()
{
	var_00 = ["physicscontents_solid","physicscontents_foliage","physicscontents_aiavoid","physicscontents_vehicletrigger","physicscontents_glass","physicscontents_water","physicscontents_canshootclip","physicscontents_missileclip","physicscontents_item","physicscontents_vehicleclip","physicscontents_itemclip","physicscontents_sky","physicscontents_ainosight","physicscontents_clipshot","physicscontents_actor","physicscontents_corpseclipshot","physicscontents_playerclip","physicscontents_monsterclip","physicscontents_sentienttrigger","physicscontents_teamtrigger","physicscontents_use","physicscontents_nonsentienttrigger","physicscontents_vehicle","physicscontents_mantle","physicscontents_player","physicscontents_corpse","physicscontents_detail","physicscontents_structural","physicscontents_translucent","physicscontents_playertrigger","physicscontents_nodrop"];
	return physics_createcontents(var_00);
}

//Function Number: 34
func_45F5(param_00)
{
	var_01 = physics_getsurfacetypefromflags(param_00["surfaceflags"]);
	param_00["surfaceindex"] = var_01["index"];
	param_00["surfacetype"] = var_01["name"];
	return param_00;
}

//Function Number: 35
func_45EC(param_00,param_01,param_02,param_03,param_04)
{
	if(!isdefined(param_04))
	{
		param_04 = (0,0,0);
	}

	var_05 = param_03 * 0.5;
	var_06 = anglestoforward(param_04);
	var_07 = anglestoup(param_04);
	var_08 = [];
	var_08["trace_start"] = param_00 + var_07 * var_05;
	if(isdefined(param_01))
	{
		var_08["trace_end"] = param_01 + var_07 * var_05;
	}

	var_08["radius"] = param_02;
	var_08["angles"] = param_04;
	var_08["half_height"] = var_05;
	return var_08;
}

//Function Number: 36
func_5B66(param_00,param_01,param_02,param_03)
{
}

//Function Number: 37
func_5B67(param_00,param_01,param_02,param_03,param_04)
{
}

//Function Number: 38
func_5B68(param_00,param_01,param_02)
{
}

//Function Number: 39
func_9A81(param_00)
{
	var_01 = [];
	var_01["fraction"] = 1;
	var_01["surfaceflags"] = 0;
	var_01["distance"] = 0;
	var_01["position"] = param_00;
	var_01["shape_position"] = param_00;
	var_01["normal"] = (0,0,0);
	var_01["contact_normal"] = (0,0,0);
	var_01["hittype"] = "hittype_none";
	return var_01;
}

//Function Number: 40
func_9A80(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
}