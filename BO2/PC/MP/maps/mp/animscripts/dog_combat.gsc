/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\animscripts\dog_combat.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: PC
 * Function Count: 5
 * Decompile Time: 0 ms
 * Timestamp: 10/28/2023 12:10:23 AM
*******************************************************************/

#include common_scripts/utility;
#include maps/mp/animscripts/shared;
#include maps/mp/animscripts/utility;

//Function Number: 1
main()
{
	debug_anim_print("dog_combat::main() ");
	self endon("killanimscript");
	self setaimanimweights(0,0);
/#
	if(!(debug_allow_combat()))
	{
		combatidle();
		return;
	}
#/
	if(IsDefined(level.hostmigrationtimer))
	{
		combatidle();
		return;
	}

/#
	assert(IsDefined(self.enemy));
#/
	if(!(isalive(self.enemy)))
	{
		combatidle();
		return;
	}

	if(isplayer(self.enemy))
	{
		self meleebiteattackplayer(self.enemy);
	}
}

//Function Number: 2
combatidle()
{
	self set_orient_mode("face enemy");
	self animmode("zonly_physics",0);
	idleanims = [];
	idleanims[0] = "combat_attackidle";
	idleanims[1] = "combat_attackidle_bark";
	idleanims[2] = "combat_attackidle_growl";
	idleanim = random(idleanims);
	debug_anim_print("dog_combat::combatIdle() - Setting " + idleanim);
	self setanimstate(idleanim);
	self maps/mp/animscripts/shared::donotetracks("done");
	debug_anim_print("dog_combat::combatIdle() - " + idleanim + " notify done.");
}

//Function Number: 3
meleebiteattackplayer(player)
{
	self set_orient_mode("face enemy");
	self animmode("gravity",0);
	self.safetochangescript = 0;
	if(use_low_attack())
	{
		self animmode("angle deltas",0);
		self setanimstate("combat_attack_player_close_range");
		self maps/mp/animscripts/shared::donotetracksfortime(1.4,"done");
		self animmode("gravity",0);
	}
	else
	{
		attack_time = 1.2 + randomfloat(0.4);
		debug_anim_print("dog_combat::meleeBiteAttackPlayer() - Setting  combat_run_attack");
		self setanimstate("combat_attack_run");
		self maps/mp/animscripts/shared::donotetracksfortime(attack_time,"done",::handlemeleebiteattacknotetracks,player);
		debug_anim_print("dog_combat::meleeBiteAttackPlayer() - combat_attack_run notify done.");
	}

	self.safetochangescript = 1;
	self animmode("none",0);
}

//Function Number: 4
handlemeleebiteattacknotetracks(note,player)
{
	if(note == "dog_melee")
	{
		self melee(AnglesToForward(self.angles));
	}
}

//Function Number: 5
use_low_attack(player)
{
	return 0;
}