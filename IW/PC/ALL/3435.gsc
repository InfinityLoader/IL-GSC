/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3435.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 18
 * Decompile Time: 25 ms
 * Timestamp: 10/27/2023 12:27:27 AM
*******************************************************************/

//Function Number: 1
func_20BB()
{
	func_6692();
}

//Function Number: 2
func_97D0()
{
}

//Function Number: 3
func_E0D0()
{
	self setclientomnvar("ui_dodge_charges",0);
	self notify("removeArchetype");
}

//Function Number: 4
func_6692()
{
}

//Function Number: 5
func_F6E6(param_00)
{
	thread func_13A1A(param_00);
}

//Function Number: 6
func_13A1A(param_00)
{
	self endon("death");
	self endon("disconnect");
	self endon("removeArchetype");
	for(;;)
	{
		self waittill("got_a_kill",var_01,var_02,var_03);
		if(param_00 == "equipment" && !scripts\common\utility::func_9D74(var_03))
		{
			continue;
		}
		else
		{
			func_49AD(self,var_01,param_00);
		}
	}
}

//Function Number: 7
func_49AD(param_00,param_01,param_02)
{
	var_03 = 20;
	var_04 = 20;
	var_05 = spawn("script_model",param_01.origin + (0,0,10));
	var_06 = func_7E95(param_02);
	var_05 method_8594();
	var_05 setmodel(var_06);
	var_05.var_222 = param_00;
	var_05.team = param_00.team;
	var_05.type = param_02;
	var_05 method_8429(param_00);
	var_07 = spawn("trigger_radius",param_01.origin,0,var_03,var_04);
	var_07 thread func_13A1C(var_05);
	var_07 thread func_13A19(var_05);
	if(param_02 != "equipment" && param_02 != "super")
	{
		var_05 thread func_90DE();
		var_05 rotateyaw(1000,30,0.2,0.2);
	}
	else
	{
		var_05 thread func_11A17(var_07);
	}

	var_05 thread func_13A1B(30,var_07);
	if(var_05.type == "equipment")
	{
		var_05 func_F6E8(param_00);
		foreach(var_09 in level.players)
		{
			if(var_09 != param_00)
			{
				var_05 method_8429(var_09);
			}
		}

		return;
	}

	foreach(var_09 in level.players)
	{
		if(!level.teambased)
		{
			if(var_09 == param_00)
			{
				var_05 func_F6E8(var_09);
			}
			else
			{
				var_05 method_8429(var_09);
			}

			continue;
		}

		if(var_09.team != param_00.team)
		{
			var_05 method_8429(var_09);
			continue;
		}

		var_05 func_F6E8(var_09);
	}
}

//Function Number: 8
func_7E95(param_00)
{
	switch(param_00)
	{
		case "battery":
			var_01 = "mp_battery_drop";
			break;

		case "scorestreak":
			var_01 = "mp_battery_drop";
			break;

		case "super":
			var_01 = "mp_battery_drop";
			break;

		case "equipment":
			var_01 = "equipment_resupply_bag";
			break;

		default:
			var_01 = "mp_battery_drop";
			break;
	}

	return var_01;
}

//Function Number: 9
func_13A18(param_00)
{
	self endon("death");
	self endon("disconnect");
	wait(param_00);
}

//Function Number: 10
func_F6E8(param_00)
{
	self showtoplayer(param_00);
}

//Function Number: 11
func_F6E7(param_00)
{
	param_00 endon("death");
	self endon("death");
	var_01 = scripts\mp\_utility::func_C794(self,"cyan",param_00,1,0,"equipment");
	scripts\mp\_hostmigration::func_13708(30);
	scripts\mp\_utility::func_C78F(var_01,self);
}

//Function Number: 12
func_90DE()
{
	self endon("death");
	var_00 = self.origin;
	for(;;)
	{
		self moveto(var_00 + (0,0,15),1,0.2,0.2);
		wait(1);
		self moveto(var_00,1,0.2,0.2);
		wait(1);
	}
}

//Function Number: 13
func_11A17(param_00)
{
	var_01 = scripts\common\utility::func_5D14(self.origin,32);
	self.origin = var_01;
	if(isdefined(param_00))
	{
		param_00.origin = var_01;
	}
}

//Function Number: 14
func_13A1C(param_00)
{
	self endon("death");
	for(;;)
	{
		self waittill("trigger",var_01);
		if(!isplayer(var_01))
		{
			continue;
		}

		if(level.teambased)
		{
			if(var_01.team != param_00.team)
			{
				continue;
			}
		}
		else if(var_01 != param_00.var_222)
		{
			continue;
		}

		if(param_00.type == "equipment" && var_01 != param_00.var_222)
		{
			continue;
		}

		if(param_00.type == "super" && var_01 scripts\mp\_supers::func_9F8A() || var_01 scripts\mp\_supers::func_9F88())
		{
			continue;
		}

		if(param_00.type == "equipment" && var_01.var_D782.size == 0)
		{
			continue;
		}

		var_01 func_8363(param_00);
		var_01 playlocalsound("scavenger_pack_pickup");
		if(var_01 scripts\mp\_utility::_hasperk("specialty_superpack"))
		{
			var_01 scripts\mp\_missions::func_D991("ch_trait_super_pack");
		}

		param_00 delete();
	}
}

//Function Number: 15
func_8363(param_00)
{
	if(param_00.type == "battery")
	{
		thread scripts\mp\_rank::func_EC2D("battery_pack");
		lib_0DD8::func_E83B(param_00.var_222);
		return;
	}

	if(param_00.type == "scorestreak")
	{
		thread scripts\mp\_rank::func_EC2D("scorestreak_pack");
		var_01 = scripts\mp\_rank::func_8104("scorestreak_pack");
		thread scripts\mp\_rank::func_EC42(var_01);
		scripts\mp\killstreaks\_killstreaks::func_83A7("scorestreak_pack",var_01);
		return;
	}

	if(param_00.type == "super")
	{
		thread scripts\mp\_rank::func_EC2D("super_pack");
		scripts\mp\_supers::func_83AA(125);
		return;
	}

	if(param_00.type == "equipment")
	{
		scripts\mp\_weapons::func_EBD3(self);
		scripts\mp\_hud_message::func_1013D("scavenger_eqp");
		return;
	}
}

//Function Number: 16
func_9DDC(param_00)
{
	switch(param_00)
	{
		case "super_pack":
		case "scorestreak_pack":
		case "battery_pack":
			return 1;

		default:
			return 0;
	}
}

//Function Number: 17
func_13A19(param_00)
{
	self endon("death");
	param_00 waittill("death");
	if(isdefined(self))
	{
		self delete();
	}
}

//Function Number: 18
func_13A1B(param_00,param_01)
{
	self endon("death");
	scripts\mp\_hostmigration::func_13708(param_00);
	param_01 delete();
	self delete();
}