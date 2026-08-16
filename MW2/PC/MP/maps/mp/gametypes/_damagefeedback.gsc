/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_damagefeedback.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: PC
*******************************************************************/

init()
{
	precacheshader("damage_feedback");
	precacheshader("damage_feedback_j");
	precacheshader("damage_feedback_endgame");
	precacheshader("scavenger_pickup");
	level thread onplayerconnect();
}

onplayerconnect()
{
	for(;;)
	{
		level waittill("connected", player);
		player.hud_damagefeedback = newclienthudelem(player);
		player.hud_damagefeedback.horzalign = "center";
		player.hud_damagefeedback.vertalign = "middle";
		player.hud_damagefeedback.x = -12;
		player.hud_damagefeedback.y = -12;
		player.hud_damagefeedback.alpha = 0;
		player.hud_damagefeedback.archived = 1;
		player.hud_damagefeedback setshader("damage_feedback", 24, 48);
	}
}

updatedamagefeedback(typehit)
{
	if(!isplayer(self))
	{
		return;
	}

	x = -12;
	y = -12;
	if(getdvarint("camera_thirdPerson"))
	{
		yoffset = self getthirdpersoncrosshairoffset() * 240;
	}
	else
	{
		yoffset = getdvarfloat("cg_crosshairVerticalOffset") * 240;
	}

	if(level.splitscreen)
	{
		yoffset = yoffset * 0.5;
	}

	feedbackdurationoverride = 0;
	startalpha = 1;
	if(typehit == "hitBodyArmor")
	{
		self.hud_damagefeedback setshader("damage_feedback_j", 24, 48);
		self playlocalsound("MP_hit_alert");
	}
	else if(typehit == "hitEndGame")
	{
		self.hud_damagefeedback setshader("damage_feedback_endgame", 24, 48);
		self playlocalsound("MP_hit_alert");
	}
	else
	{
		if(typehit == "stun")
		{
			return;
		}

		if(typehit == "none")
		{
			return;
		}

		if(typehit == "scavenger" && !level.hardcoremode)
		{
			x = -36;
			y = 32;
			self.hud_damagefeedback setshader("scavenger_pickup", 64, 32);
			feedbackdurationoverride = 2.5;
		}
		else
		{
			self.hud_damagefeedback setshader("damage_feedback", 24, 48);
			self playlocalsound("MP_hit_alert");
		}
	}

	self.hud_damagefeedback.alpha = startalpha;
	if(feedbackdurationoverride != 0)
	{
		self.hud_damagefeedback fadeovertime(feedbackdurationoverride);
	}
	else
	{
		self.hud_damagefeedback fadeovertime(1);
	}

	self.hud_damagefeedback.alpha = 0;
	if(self.hud_damagefeedback.x != x)
	{
		self.hud_damagefeedback.x = x;
	}

	y = y - int(yoffset);
	if(self.hud_damagefeedback.y != y)
	{
		self.hud_damagefeedback.y = y;
		return;
	}
}