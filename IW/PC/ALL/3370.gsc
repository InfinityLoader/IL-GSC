/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3370.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 15
 * Decompile Time: 6 ms
 * Timestamp: 10/27/2023 12:26:45 AM
*******************************************************************/

//Function Number: 1
func_96D8(param_00)
{
	level.var_93CC = 1;
	level.var_477B = 24;
	if(isdefined(level.script))
	{
		switch(level.script)
		{
			case "cp_zmb":
				param_00.var_1566 = ["STICKER_COLLECTOR","SOUL_KEY","THE_BIGGER_THEY_ARE","HOFF_THE_CHARTS","ROCK_ON","GET_PACKED","BATTERIES_NOT_INCLUDED","I_LOVE_THE_80_S","INSERT_COIN","BRAIN_DEAD"];
				break;

			case "cp_rave":
				param_00.var_1566 = ["LOCKSMITH","SUPER_SLACKER","STICK_EM","HALLUCINATION_NATION","TABLES_TURNED","RAVE_ON","RIDE_FOR_YOUR_LIFE","SCRAPBOOKING","PUMP_IT_UP","TOP_CAMPER"];
				break;

			case "cp_disco":
				param_00.var_1566 = ["BOOK_WORM","COIN_OP","BEAT_OF_THE_DRUM","SLICED_AND_DICED","PEST_CONTROL","EXTERMINATOR","SHAOLIN_SKILLS","MESSAGE_RECEIVED","SOUL_BROTHER","SOME_ASSEMBLY_REQUIRED"];
				break;

			case "cp_town":
				param_00.var_1566 = ["SOUL_LESS","UNPLEASANT_DREAMS","MISTRESS_OF_DARK","QUARTER_MUNCHER","BAIT_AND_SWITCH","BELLY_OF_BEAST","MAD_PROTO","DEAR_DIARY"];
				break;

			case "cp_final":
				param_00.var_1566 = ["BROKEN_RECORD","CRACKING_SKULLS","DOUBLE_FEATURE","EGG_SLAYER","ENCRYPT_DECRYPT","FAILED_MAINTENANCE","FRIENDS_FOREVER","MESSAGE_SENT","SUPER_DUPER_COMBO","THE_END"];
				break;

			default:
				param_00.var_1566 = ["STICKER_COLLECTOR","SOUL_KEY","THE_BIGGER_THEY_ARE","HOFF_THE_CHARTS","ROCK_ON","GET_PACKED","BATTERIES_NOT_INCLUDED","I_LOVE_THE_80_S","INSERT_COIN","BRAIN_DEAD","LOCKSMITH","SUPER_SLACKER","STICK_EM","HALLUCINATION_NATION","TABLES_TURNED","RAVE_ON","RIDE_FOR_YOUR_LIFE","SCRAPBOOKING","PUMP_IT_UP","TOP_CAMPER","BOOK_WORM","COIN_OP","BEAT_OF_THE_DRUM","SLICED_AND_DICED","PEST_CONTROL","EXTERMINATOR","SHAOLIN_SKILLS","MESSAGE_RECEIVED","SOUL_BROTHER","SOME_ASSEMBLY_REQUIRED","SOUL_LESS","UNPLEASANT_DREAMS","MISTRESS_OF_DARK","QUARTER_MUNCHER","BAIT_AND_SWITCH","BELLY_OF_BEAST","MAD_PROTO","DEAR_DIARY","BROKEN_RECORD","CRACKING_SKULLS","DOUBLE_FEATURE","EGG_SLAYER","ENCRYPT_DECRYPT","FAILED_MAINTENANCE","FRIENDS_FOREVER","MESSAGE_SENT","SUPER_DUPER_COMBO","THE_END"];
				break;
		}
	}

	if(isdefined(param_00.var_1567))
	{
		[[ param_00.var_1567 ]]();
	}
}

//Function Number: 2
func_DEAA()
{
	func_DE90("STICKER_COLLECTOR",24,::func_4FF9,::func_5015,::func_668B);
	func_DE90("SOUL_KEY",1,::func_4FF9,::func_5015,::func_668B);
	func_DE90("THE_BIGGER_THEY_ARE",5,::func_4FF9,::func_5015,::func_668B);
	func_DE90("HOFF_THE_CHARTS",1,::func_4FF9,::func_5015,::func_668B);
	func_DE90("ROCK_ON",1,::func_4FF9,::func_5015,::func_240B);
	func_DE90("GET_PACKED",1,::func_4FF9,::func_5015,::func_240B);
	func_DE90("BATTERIES_NOT_INCLUDED",1,::func_4FF9,::func_5015,::func_240B);
	func_DE90("I_LOVE_THE_80_S",2,::func_4FF9,::func_5015,::func_668B);
	func_DE90("INSERT_COIN",20,::func_4FF9,::func_5015,::func_668B);
	func_DE90("BRAIN_DEAD",30,::func_4FF9,::func_5015,::func_668B);
	func_DE90("LOCKSMITH",1,::func_4FF9,::func_5015,::func_668B);
	func_DE90("SUPER_SLACKER",1,::func_4FF9,::func_5015,::func_668B);
	func_DE90("STICK_EM",100,::func_4FF9,::func_5015,::func_240B);
	func_DE90("HALLUCINATION_NATION",1,::func_4FF9,::func_5015,::func_668B);
	func_DE90("TABLES_TURNED",1,::func_4FF9,::func_5015,::func_668B);
	func_DE90("RAVE_ON",1,::func_4FF9,::func_5015,::func_668B);
	func_DE90("RIDE_FOR_YOUR_LIFE",4,::func_4FF9,::func_5015,::func_668B);
	func_DE90("SCRAPBOOKING",1,::func_4FF9,::func_5015,::func_668B);
	func_DE90("PUMP_IT_UP",1,::func_4FF9,::func_5015,::func_668B);
	func_DE90("TOP_CAMPER",1,::func_4FF9,::func_5015,::func_668B);
	func_DE90("BOOK_WORM",1,::func_4FF9,::func_5015,::func_668B);
	func_DE90("COIN_OP",1,::func_4FF9,::func_5015,::func_668B);
	func_DE90("BEAT_OF_THE_DRUM",1,::func_4FF9,::func_5015,::func_668B);
	func_DE90("SLICED_AND_DICED",1,::func_4FF9,::func_5015,::func_668B);
	func_DE90("PEST_CONTROL",1,::func_4FF9,::func_5015,::func_668B);
	func_DE90("EXTERMINATOR",1,::func_4FF9,::func_5015,::func_668B);
	func_DE90("SHAOLIN_SKILLS",1,::func_4FF9,::func_5015,::func_668B);
	func_DE90("MESSAGE_RECEIVED",1,::func_4FF9,::func_5015,::func_668B);
	func_DE90("SOUL_BROTHER",1,::func_4FF9,::func_5015,::func_668B);
	func_DE90("SOME_ASSEMBLY_REQUIRED",1,::func_4FF9,::func_5015,::func_668B);
	func_DE90("SOUL_LESS",1,::func_4FF9,::func_5015,::func_668B);
	func_DE90("UNPLEASANT_DREAMS",1,::func_4FF9,::func_5015,::func_668B);
	func_DE90("MISTRESS_OF_DARK",1,::func_4FF9,::func_5015,::func_668B);
	func_DE90("QUARTER_MUNCHER",1,::func_4FF9,::func_5015,::func_668B);
	func_DE90("BAIT_AND_SWITCH",1,::func_4FF9,::func_5015,::func_668B);
	func_DE90("BELLY_OF_BEAST",1,::func_4FF9,::func_5015,::func_668B);
	func_DE90("MAD_PROTO",1,::func_4FF9,::func_5015,::func_668B);
	func_DE90("DEAR_DIARY",1,::func_4FF9,::func_5015,::func_668B);
	func_DE90("BROKEN_RECORD",1,::func_4FF9,::func_5015,::func_668B);
	func_DE90("CRACKING_SKULLS",1,::func_4FF9,::func_5015,::func_668B);
	func_DE90("DOUBLE_FEATURE",1,::func_4FF9,::func_5015,::func_668B);
	func_DE90("EGG_SLAYER",1,::func_4FF9,::func_5015,::func_668B);
	func_DE90("ENCRYPT_DECRYPT",1,::func_4FF9,::func_5015,::func_668B);
	func_DE90("FAILED_MAINTENANCE",1,::func_4FF9,::func_5015,::func_668B);
	func_DE90("FRIENDS_FOREVER",1,::func_4FF9,::func_5015,::func_668B);
	func_DE90("MESSAGE_SENT",1,::func_4FF9,::func_5015,::func_668B);
	func_DE90("SUPER_DUPER_COMBO",1,::func_4FF9,::func_5015,::func_668B);
	func_DE90("THE_END",1,::func_4FF9,::func_5015,::func_668B);
}

//Function Number: 3
func_DE90(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = spawnstruct();
	var_05 [[ param_02 ]](param_01,param_03,param_04);
	self.var_1566[param_00] = var_05;
}

//Function Number: 4
func_4FF9(param_00,param_01,param_02)
{
	self.var_D9D9 = 0;
	self.var_155 = param_00;
	self.var_FFAD = param_01;
	self.var_9BF1 = param_02;
	self.var_1565 = 0;
}

//Function Number: 5
func_12D7E(param_00,param_01,param_02)
{
	if(level.var_2115.size <= 0 || !scripts\common\utility::func_2286(level.var_2115,param_01))
	{
		param_00 func_12D7F(param_00,1,param_02);
		return;
	}

	level.var_2115 = scripts\common\utility::func_22A9(level.var_2115,param_01);
	foreach(param_00 in level.players)
	{
		param_00 func_12D7C("INSERT_COIN",1);
	}

	param_00 func_12D7F(param_00,1,param_02);
}

//Function Number: 6
func_12D7F(param_00,param_01,param_02)
{
	if(!isdefined(param_00.var_C213))
	{
		param_00.var_C213 = 1;
	}
	else
	{
		param_00.var_C213++;
	}

	if(param_00.var_C213 >= 30 && param_02 >= 10)
	{
		param_00 func_12D7C("BRAIN_DEAD",30);
	}
}

//Function Number: 7
func_5015(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	return 1;
}

//Function Number: 8
func_12E17(param_00)
{
	self.var_D9D9 = self.var_D9D9 + param_00;
}

//Function Number: 9
func_240B()
{
	return self.var_D9D9 >= self.var_155;
}

//Function Number: 10
func_668B()
{
	return self.var_D9D9 == self.var_155;
}

//Function Number: 11
func_9B9E()
{
	return self.var_1565;
}

//Function Number: 12
func_B35D()
{
	self.var_1565 = 1;
}

//Function Number: 13
func_9CFF(param_00)
{
	return isdefined(param_00);
}

//Function Number: 14
func_12D7C(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B)
{
	if(scripts\cp\_utility::is_codxp())
	{
		return;
	}

	if(scripts\cp\zombies\direct_boss_fight::should_directly_go_to_boss_fight())
	{
		return;
	}

	var_0C = self.var_1566[param_00];
	if(!func_9CFF(var_0C))
	{
		return;
	}

	if(var_0C func_9B9E())
	{
		return;
	}

	if(scripts\common\utility::istrue(level.entered_thru_card))
	{
		return;
	}

	if(var_0C [[ var_0C.var_FFAD ]](param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B))
	{
		var_0C func_12E17(param_01);
		if(var_0C [[ var_0C.var_9BF1 ]]())
		{
			self giveachievement(param_00);
			var_0C func_B35D();
		}
	}
}

//Function Number: 15
update_achievement_all_players(param_00,param_01)
{
	foreach(var_03 in level.players)
	{
		var_03 func_12D7C(param_00,param_01);
	}
}