/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\zombies\_zm_magicbox_lock.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: PC
 * Function Count: 6
 * Decompile Time: 0 ms
 * Timestamp: 10/28/2023 12:11:50 AM
*******************************************************************/

#include common_scripts/utility;
#include maps/mp/_utility;
#include maps/mp/zombies/_zm_magicbox;
#include maps/mp/zombies/_zm_magicbox_lock;
#include maps/mp/zombies/_zm_unitrigger;
#include maps/mp/zombies/_zm_utility;

//Function Number: 1
init()
{
	precachemodel("p6_anim_zm_al_magic_box_lock_red");
	level.locked_magic_box_cost = 2000;
	level.custom_magicbox_state_handler = maps/mp/zombies/_zm_magicbox_lock::set_locked_magicbox_state;
	add_zombie_hint("locked_magic_box_cost",&"ZOMBIE_LOCKED_COST_2000");
}

//Function Number: 2
watch_for_lock()
{
	self endon("user_grabbed_weapon");
	self endon("chest_accessed");
	self waittill("box_locked");
	self notify("kill_chest_think");
	self.grab_weapon_hint = 0;
	self.chest_user = undefined;
	wait(0.1);
	self thread maps/mp/zombies/_zm_unitrigger::register_static_unitrigger(self.unitrigger_stub,::magicbox_unitrigger_think);
	self.unitrigger_stub run_visibility_function_for_all_triggers();
	self thread treasure_chest_think();
}

//Function Number: 3
clean_up_locked_box()
{
	self endon("box_spin_done");
	self.owner waittill("box_locked");
	if(IsDefined(self.weapon_model))
	{
		self.weapon_model delete();
		self.weapon_model = undefined;
	}

	if(IsDefined(self.weapon_model_dw))
	{
		self.weapon_model_dw delete();
		self.weapon_model_dw = undefined;
	}

	self hidezbarrierpiece(3);
	self hidezbarrierpiece(4);
	self setzbarrierpiecestate(3,"closed");
	self setzbarrierpiecestate(4,"closed");
}

//Function Number: 4
magic_box_locks()
{
	self.owner.is_locked = 1;
	self.owner notify("box_locked");
	self playsound("zmb_hellbox_lock");
	self setclientfield("magicbox_open_fx",0);
	self setclientfield("magicbox_amb_fx",2);
	self setzbarrierpiecestate(5,"closing");
	while(self getzbarrierpiecestate(5) == "closing")
	{
		wait(0.5);
	}

	self notify("locked");
}

//Function Number: 5
magic_box_unlocks()
{
	maps/mp/zombies/_zm_unitrigger::unregister_unitrigger(self.owner.unitrigger_stub);
	self playsound("zmb_hellbox_unlock");
	self setzbarrierpiecestate(5,"opening");
	while(self getzbarrierpiecestate(5) == "opening")
	{
		wait(0.5);
	}

	self setzbarrierpiecestate(2,"closed");
	self showzbarrierpiece(2);
	self hidezbarrierpiece(5);
	self notify("unlocked");
	self.owner.is_locked = 0;
	maps/mp/zombies/_zm_unitrigger::register_unitrigger(self.owner.unitrigger_stub);
	self setclientfield("magicbox_amb_fx",1);
}

//Function Number: 6
set_locked_magicbox_state(state)
{
	switch(state)
	{
		case "locking":
			self showzbarrierpiece(5);
			self thread magic_box_locks();
			self.state = "locking";
			break;

		case "unlocking":
			self showzbarrierpiece(5);
			self magic_box_unlocks();
			self.state = "close";
			break;
	}
}