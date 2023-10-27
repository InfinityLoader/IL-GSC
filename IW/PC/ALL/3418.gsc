/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3418.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 29
 * Decompile Time: 5 ms
 * Timestamp: 10/27/2023 12:27:10 AM
*******************************************************************/

//Function Number: 1
func_97B7()
{
	func_95CA(["money_earned"]);
	func_95C7(["money_earned"]);
	func_F450();
	func_F44F();
}

//Function Number: 2
func_F450()
{
	level.var_4CC6 = 1;
}

//Function Number: 3
func_F44F()
{
	level.var_6326 = ::func_13FA1;
}

//Function Number: 4
func_95CA(param_00)
{
	foreach(var_02 in param_00)
	{
		switch(var_02)
		{
			case "damage":
				lib_0A54::func_DEB4("damage",29);
				break;

			case "money_earned":
				lib_0A54::func_DEB4("money_earned",30);
				break;

			case "tickets_earned":
				lib_0A54::func_DEB4("tickets_earned",31);
				break;

			case "consumables_earned":
				lib_0A54::func_DEB4("consumables_earned",32);
				break;

			default:
				break;
		}
	}
}

//Function Number: 5
func_95C7(param_00)
{
	level.var_6299 = [];
	foreach(var_02 in param_00)
	{
		switch(var_02)
		{
			case "damage":
				func_95A0();
				break;

			case "money_earned":
				func_9683();
				break;

			case "tickets_earned":
				func_9784();
				break;

			case "consumables_earned":
				func_958B();
				break;

			default:
				break;
		}
	}
}

//Function Number: 6
func_95A0()
{
	lib_0A54::func_DEB2("damage",::func_959F,::func_E22D,::func_E214,::func_36E5,29,"damage");
}

//Function Number: 7
func_9683()
{
	lib_0A54::func_DEB2("money_earned",::func_9682,::func_E230,::func_E218,::func_36F8,30,"money_earned");
}

//Function Number: 8
func_9784()
{
	lib_0A54::func_DEB2("tickets_earned",::func_9783,::func_E233,::func_E220,::func_3707,31,"tickets_earned");
}

//Function Number: 9
func_958B()
{
	lib_0A54::func_DEB2("consumables_earned",::func_958A,::func_E22C,::func_E213,::func_36E3,32,"consumables_earned");
}

//Function Number: 10
func_958A(param_00)
{
	return param_00;
}

//Function Number: 11
func_E22C(param_00)
{
	return param_00;
}

//Function Number: 12
func_E213(param_00)
{
	param_00.var_6296["total_consumables_earned"] = 0;
}

//Function Number: 13
func_36E3(param_00,param_01)
{
	var_02 = lib_0A54::func_7B8F(param_00,"total_consumables_earned");
	var_03 = min(-15536,var_02 * 10000);
	return int(var_03);
}

//Function Number: 14
func_9783(param_00)
{
	return param_00;
}

//Function Number: 15
func_E233(param_00)
{
	return param_00;
}

//Function Number: 16
func_E220(param_00)
{
	param_00.var_6296["total_tickets_earned"] = 0;
}

//Function Number: 17
func_3707(param_00,param_01)
{
	var_02 = lib_0A54::func_7B8F(param_00,"total_tickets_earned");
	var_03 = min(999999,var_02 * 1);
	return int(var_03);
}

//Function Number: 18
func_9682(param_00)
{
	return param_00;
}

//Function Number: 19
func_E230(param_00)
{
	return param_00;
}

//Function Number: 20
func_E218(param_00)
{
	param_00.var_6296["total_money_earned"] = 0;
}

//Function Number: 21
func_36F8(param_00,param_01)
{
	var_02 = lib_0A54::func_7B8F(param_00,"total_money_earned");
	var_03 = min(999999,var_02 * 1);
	return int(var_03);
}

//Function Number: 22
func_959F(param_00)
{
	return param_00;
}

//Function Number: 23
func_E22D(param_00)
{
	return param_00;
}

//Function Number: 24
func_E214(param_00)
{
	param_00.var_6296["damage_done_on_agent"] = 0;
}

//Function Number: 25
func_36E5(param_00,param_01)
{
	var_02 = lib_0A54::func_7B8F(param_00,"damage_done_on_agent");
	var_03 = min(999999,var_02 * 0.2);
	return int(var_03);
}

//Function Number: 26
func_12D84(param_00,param_01,param_02)
{
	if(param_02 == "MOD_TRIGGER_HURT")
	{
		return;
	}

	var_03 = scripts\cp\_utility::func_7844(param_00);
	if(!isdefined(var_03))
	{
		return;
	}

	var_03 lib_0A54::func_12E04("damage","damage_done_on_agent",param_01);
}

//Function Number: 27
func_12DEC(param_00,param_01)
{
	param_00 lib_0A54::func_12E04("money_earned","total_money_earned",param_01);
	scripts\cp\zombies\zombie_analytics::func_AF67(param_00,param_01);
}

//Function Number: 28
func_12E3B(param_00,param_01)
{
	param_00 lib_0A54::func_12E04("tickets_earned","total_tickets_earned",param_01);
}

//Function Number: 29
func_13FA1(param_00)
{
	lib_0A54::func_36EC(level.players,["money_earned"],param_00);
}