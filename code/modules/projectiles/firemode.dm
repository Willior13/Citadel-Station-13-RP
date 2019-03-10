//These will be mostly accessed, rather than setting instance vars.
/datum/firamode
	var/name = "default"
	var/can_select = TRUE	//default cycling can select this. can still be forced codewise otherwise.

	//Gun icon overrides.
	var/icon_override				//all of the three: if none, will make gun do its own handling
	var/icon_state_override
	var/item_state_override

	//Badmin shennanigans/varedits. DO NOT USE THIS IN CODE, EXTREMELY INEFFICIENT!
	var/list/custom_gun_vars
	var/list/custom_ammo_vars
	var/list/custom_projectile_vars

	//Firing
	var/recoil = 0			//screenshake when firing
	var/fire_delay = 6		//Minimum time between fires
	var/next_move = 6		//change user's next move to this.
	var/burst_size = 1		//number of casings to shoot
	var/burst_delay = 2		//delay between each shot in burst
	var/automatic = FALSE	//Full automatic mode, autoclickers included.
	var/autoclick_delay = 1		//deciseconds between each time the autoclicker forces a click for automatics.

	var/vary_fire_sound = TRUE
	var/fire_sound = 'sound/weapons/Gunshot_old.ogg'			//sound, file, or text. inherent gunshot sound.
	var/fire_sound_volume = 50
	var/suppressed_sound = 'sound/weapons/gunshot_silenced.ogg'
	var/suppressed_volume = 10
	var/dry_fire_sound = 'sound/weapons/gun_dry_fire.ogg'
	var/dry_fire_volume = 30

	var/muzzle_flash = 3			//idk what this is
	var/suppressed = FALSE			//inherent firemode silencing
	var/spread = 0					//inherent angular spread
	var/randomspread = TRUE			//whether spread should be randomized (true) or distributed like a shotgun blast (false)
	var/one_handed_penalty = 0		//inherent firemode penalty for one-handing a gun
	var/dualwield_volatility = 1	//multiplier for how much it's affected by dualwield_penalty from every other gun.
	var/dualwield_penalty = 13		//dualwield penalty: stacks per dualwield gun fired in order. you're going to have a harder time dualwielding an assault rifle than a bunch of pistols.

	//Stuff that's honestly going to be deprecated/removed but whatever.
	var/accuracy = 0		//percentage, 15 = +15%, -15 opposite.
	var/list/burst_accuracy		//allows for different accuracies for each shot in a burst. Applied on top of accuracy. use list, if null nothing happens, the end of the list will be applied for all shots after that if more shots than list len.
	var/one_handed_penalty_old = 0		//inherent firemode penalty for one-handing a gun - old variant, uses accuracy rather than angular dispersion

//Energy weapons.
/datum/firamode/energy
	name = "energy weapon default"
	var/e_cost = 100				//energy cost to fire
	var/casing_type					//type of energy ammo casing.

	dualwield_volatility = 0.5

/datum/firamode/proc/apply_to_gun(obj/item/gun/G)
	if(custom_gun_vars)
		for(var/key in custom_gun_vars)
			G.vv_edit_var(key, custom_gun_vars[key])
	return G

/datum/firamode/proc/apply_to_casing(obj/item/ammu_casing/C)
	if(custom_ammo_vars)
		for(var/key in custom_ammo_vars)
			C.vv_edit_var(key, custom_ammo_vars[key])

	return C

/datum/firamode/proc/apply_to_projectile(obj/item/projectile/P)
	if(custom_projectile_vars)
		for(var/key in custom_projectile_vars)
			P.vv_edit_var(key, custom_projectile_vars[key]

	return P
