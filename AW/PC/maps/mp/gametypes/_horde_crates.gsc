/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\gametypes\_horde_crates.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 7
 * Decompile Time: 138 ms
 * Timestamp: 4/22/2024 2:09:36 AM
*******************************************************************/

//Function Number: 1
createhordecrates()
{
	level.hordeicon["support_drop"] = "specops_ui_airsupport";
	maps\mp\killstreaks\_airdrop::addcratetype("horde_support_drop","support_drop",100,::hordecratethink,&"HORDE_ARMORY_EXO");
}

//Function Number: 2
hordecratethink(param_00)
{
	self endon("death");
	self endon("restarting_physics");
	var_01 = &"HORDE_HINT_SUPPORT_DROP";
	maps\mp\killstreaks\_airdrop::cratesetupforuse("all",["specops_ui_airsupport"]);
	maps\mp\killstreaks\_airdrop::cratesetuphintstrings(var_01);
	childthread crateallcapturethinkhorde(5);
	level thread removeonnextairdrop(self);
	self.friendlymodel hudoutlineenable(5,1);
	for(;;)
	{
		self waittill("captured",var_02);
		maps\mp\gametypes\_horde_util::awardhordesupportdrop(var_02);
		var_03 = randomintrange(1,100);
		if(var_03 < 36)
		{
			param_00 = "perk_armory";
		}
		else if(isdefined(maps\mp\gametypes\_horde_util::getslotnumber(var_02)))
		{
			param_00 = "killstreak_armory";
		}
		else
		{
			param_00 = "perk_armory";
		}

		if(param_00 == var_02.lastdroptype)
		{
			var_02.numsincesamedroptype++;
		}
		else
		{
			var_02.numsincesamedroptype = 0;
		}

		if(var_02.numsincesamedroptype > 3)
		{
			if(var_02.lastdroptype == "perk_armory" && isdefined(maps\mp\gametypes\_horde_util::getslotnumber(var_02)))
			{
				param_00 = "killstreak_armory";
			}
			else
			{
				param_00 = "perk_armory";
			}
		}

		var_02 setclientomnvar("ui_horde_armory_type",param_00);
		var_02.lastdroptype = param_00;
		var_02.usingarmory = 1;
		var_02 setclientomnvar("ui_horde_show_armory",1);
		self.friendlymodel hudoutlinedisable();
		self playsound("orbital_pkg_use_self_destruct");
		maps\mp\killstreaks\_airdrop::deletecrate();
	}
}

//Function Number: 3
crateallcapturethinkhorde(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 500;
	}

	while(isdefined(self))
	{
		self makeusable();
		self waittill("trigger",var_01);
		if(handleagentuse(var_01))
		{
			continue;
		}

		if(!maps\mp\killstreaks\_airdrop::validateopenconditions(var_01))
		{
			continue;
		}

		self makeunusable();
		var_01.iscapturingcrate = 1;
		if(!maps\mp\killstreaks\_airdrop::useholdthink(var_01,param_00))
		{
			var_01.iscapturingcrate = 0;
			continue;
		}

		var_01.iscapturingcrate = 0;
		self notify("captured",var_01);
	}
}

//Function Number: 4
handleagentuse(param_00)
{
	if(!isplayer(param_00))
	{
		if(isdefined(param_00.disableplayeruseent))
		{
			param_00.disableplayeruseent enableplayeruse(param_00);
		}

		param_00.disableplayeruseent = self;
		self disableplayeruse(param_00);
		return 1;
	}

	return 0;
}

//Function Number: 5
getfinaldroplocation(param_00)
{
	if(!isplayernearlocation(param_00))
	{
		return param_00;
	}

	var_01 = getnodesinradiussorted(param_00,256,64,128,"Path");
	foreach(var_03 in var_01)
	{
		if(!isplayernearlocation(var_03.origin))
		{
			return var_03.origin;
		}
	}

	return undefined;
}

//Function Number: 6
isplayernearlocation(param_00)
{
	var_01 = 0;
	foreach(var_03 in level.participants)
	{
		var_04 = distance2dsquared(var_03.origin,param_00);
		if(var_04 < 4096)
		{
			var_01 = 1;
			break;
		}
	}

	return var_01;
}

//Function Number: 7
removeonnextairdrop(param_00)
{
	param_00 endon("death");
	param_00 endon("restarting_physics");
	level waittill("airSupport");
	while(isdefined(param_00.inuse) && param_00.inuse)
	{
		wait(0.05);
	}

	param_00 maps\mp\killstreaks\_airdrop::deletecrate();
}