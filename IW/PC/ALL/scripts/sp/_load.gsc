/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\sp\_load.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 45 ms
 * Timestamp: 10/27/2023 12:24:41 AM
*******************************************************************/

//Function Number: 1
main()
{
	lib_0A2F::func_9789();
	scripts\sp\_utility::func_965C();
	lib_0B33::func_95F3();
	lib_0B2F::func_9752();
	scripts\sp\_gameskill::func_95F9();
	lib_0F18::func_956A();
	scripts\sp\_introscreen::func_9631();
	lib_0B79::func_9766();
	if(scripts\sp\_utility::func_93A6())
	{
		lib_0B78::init();
	}

	lib_0B49::func_83DD();
	lib_0B49::func_83DB();
	lib_0B49::func_83D5();
	scripts\common\utility::func_978C();
	scripts\common\utility::func_1115B();
	scripts\sp\_colors::func_957F();
	lib_0B5F::func_96D7();
	scripts\sp\_mgturret::main();
	scripts\common\exploder::func_FAAA();
	lib_0B5D::main();
	scripts\sp\_art::main();
	lib_0B06::init();
	scripts\common\fx::func_980A();
	scripts\sp\_createfx::func_49B4();
	scripts\sp\_global_fx::main();
	scripts\sp\_detonategrenades::init();
	scripts\sp\_stinger::init();
	scripts\sp\_lights::init();
	scripts\common\utility::func_D959();
	scripts\sp\_names::func_F9E6();
	scripts\sp\_audio::func_9539();
	scripts\sp\_trigger::func_9726();
	function_01C5("ufoHitsTriggers","0");
	scripts\sp\_hud::init();
	lib_0B9B::func_979C();
	scripts\sp\_endmission::main();
	lib_0E2B::func_C32F();
	lib_0E2D::func_112B5();
	lib_0E26::func_972B();
	lib_0E25::func_95C4();
	scripts\sp\_vehicle::func_979A();
	lib_0B29::init();
	lib_0E21::func_9527();
	lib_0E29::func_8829();
	lib_0B2A::func_66A1();
	scripts\sp\_coverwall::func_4761();
	precacheitem("frag_up1");
	precacheitem("frag_c6hug");
	lib_0E4B::func_D5E3();
	lib_0B79::func_57C6();
	scripts\common\utility::func_C953();
	scripts\sp\_autosave::main();
	anim.var_13086 = 0;
	lib_0B49::func_F7C2();
	scripts\sp\_introscreen::main();
	scripts\sp\_damagefeedback::init();
	scripts\sp\_friendlyfire::main();
	if(getdvarint("ai_iw7",0) == 1)
	{
		lib_0A1A::func_2343();
		lib_0A02::init();
	}

	lib_0B2D::func_F97C();
	lib_0B49::func_51C4();
	scripts\anim\traverse\shared::func_F9C6();
	lib_0B04::func_94F9();
	scripts\sp\_intelligence::main();
	lib_0E44::func_952C();
	scripts\sp\_dooruse::func_95B6();
	lib_0E20::func_DE0F();
	lib_0E1F::func_6137();
	lib_0E1C::func_200A();
	lib_0E1E::func_5374();
	scripts\sp\_armoury::func_952F();
	scripts\sp\_utility::func_9674();
	if(isdefined(level.var_83DF))
	{
		[[ level.var_83DF ]]();
	}

	lib_0B49::func_B3CD();
	lib_0B77::main();
	scripts\sp\_utility::func_48C1();
	lib_0B34::func_95F7();
	lib_0B44::func_9A2F();
	thread lib_0B36::func_409C();
	if(scripts\sp\_utility::func_93A6())
	{
		if(lib_0B78::func_2C8F())
		{
			lib_0B78::func_F2D2(1);
		}
		else
		{
			level.var_10964 thread lib_0B78::main();
		}
	}

	lib_0B49::func_E810();
	function_0305(scripts\sp\_utility::func_7F6E(level.script));
	var_00 = scripts\sp\_utility::func_7E2C(level.script);
	setomnvar("ui_client_settle_time",var_00);
	var_01 = scripts\sp\_utility::func_7F70(level.script);
	if(isdefined(var_01) && var_01 != "")
	{
		setomnvar("ui_transition_movie",var_01);
	}
	else
	{
		setomnvar("ui_transition_movie","none");
	}

	lib_0B05::main();
}