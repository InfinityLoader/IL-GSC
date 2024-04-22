/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: traverse\boost_jump_railing.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 41 ms
 * Timestamp: 4/22/2024 1:59:12 AM
*******************************************************************/

//Function Number: 1
main()
{
	if(self.canjumppath)
	{
		var_00 = self getnegotiationstartnode();
		switch(var_00.script_noteworthy)
		{
			case "boost_jump_128_across_128_down_32_railing":
				rocket_jump_human_railing(%boost_jump_128_across_128_down_32_railing,1);
				break;

			case "boost_jump_128_across_140_down_32_railing":
				rocket_jump_human_railing(%boost_jump_128_across_140_down_32_railing,1);
				break;

			case "boost_jump_128_across_196_down_32_railing":
				rocket_jump_human_railing(%boost_jump_128_across_196_down_32_railing,1);
				break;

			case "boost_jump_128_across_256_down_32_railing":
				rocket_jump_human_railing(%boost_jump_128_across_256_down_32_railing,1);
				break;

			case "boost_jump_256_across_128_down_32_railing":
				rocket_jump_human_railing(%boost_jump_256_across_128_down_32_railing,1);
				break;

			case "boost_jump_256_across_140_down_32_railing":
				rocket_jump_human_railing(%boost_jump_256_across_140_down_32_railing,1);
				break;

			case "boost_jump_256_across_196_down_32_railing":
				rocket_jump_human_railing(%boost_jump_256_across_196_down_32_railing,1);
				break;

			case "boost_jump_256_across_256_down_32_railing":
				rocket_jump_human_railing(%boost_jump_256_across_256_down_32_railing,1);
				break;

			case "boost_jump_128_across_128_up_32_railing":
				animscripts\traverse\boost::rocket_jump_human(%boost_jump_128_across_128_up_32_railing,1);
				break;

			case "boost_jump_128_across_140_up_32_railing":
				animscripts\traverse\boost::rocket_jump_human(%boost_jump_128_across_140_up_32_railing,1);
				break;

			case "boost_jump_128_across_196_up_32_railing":
				animscripts\traverse\boost::rocket_jump_human(%boost_jump_128_across_196_up_32_railing,1);
				break;

			case "boost_jump_128_across_256_up_32_railing":
				animscripts\traverse\boost::rocket_jump_human(%boost_jump_128_across_256_up_32_railing,1);
				break;

			case "boost_jump_256_across_128_up_32_railing":
				animscripts\traverse\boost::rocket_jump_human(%boost_jump_256_across_128_up_32_railing,1);
				break;

			case "boost_jump_256_across_140_up_32_railing":
				animscripts\traverse\boost::rocket_jump_human(%boost_jump_256_across_140_up_32_railing,1);
				break;

			case "boost_jump_256_across_196_up_32_railing":
				animscripts\traverse\boost::rocket_jump_human(%boost_jump_256_across_196_up_32_railing,1);
				break;

			case "boost_jump_256_across_256_up_32_railing":
				animscripts\traverse\boost::rocket_jump_human(%boost_jump_256_across_256_up_32_railing,1);
				break;

			default:
				break;
		}
	}
}

//Function Number: 2
rocket_jump_human_railing(param_00,param_01,param_02)
{
	if(!isdefined(param_02))
	{
		param_02 = 32;
	}

	var_03 = [];
	var_03["traverseAnim"] = param_00;
	var_03["traverseNotetrackFunc"] = ::animscripts\traverse\boost::newhandletraversenotetracks;
	var_03["traverseHeight"] = 32;
	animscripts\traverse\shared::dotraverse(var_03);
	if(isdefined(self) && isalive(self) && isdefined(param_01) && param_01)
	{
		soundscripts\_snd::snd_message("boost_land_npc");
		self setflaggedanimknoballrestart("boostJumpLand",%boost_jump_land_2_run_b,%body,1,0.2,1);
		animscripts\shared::donotetracks("boostJumpLand",::animscripts\traverse\boost::newhandletraversenotetracks);
	}
}