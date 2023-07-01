/// @description Update on instance creation
// You can write your code in this editor
input = instance_nearest(x, y, oInput);

xspd = 0;
yspd = 0;
grav = 0.3;

currentHealth = 8;
maxHealth = currentHealth;
gold = 0;
magic = 30;
//There should be max health and max gold variables

// states = ["idle", "crouching", "running", "jumping", "turning", "attacking", "pogoing", "stunned", "dying", "dead", "victory", "paused"];
dialogueActive = false; //if true, take away player movement. player can only crouch and idle

grounded = false;
landed = false; //Check during collision, before grounded
runLerpInc = 0; //Increment this by 0.2 for every frame the player is moving. Reset to 0 when not moving.
maxRunSpeed = 1.75; //running speed should be clamped between 0 and this value
turningCounter = 0; //Turning lasts 8 frames, sliding for 4, then not moving for 4
deathTransCounter = 0; //Death transition starts 60 frames after death
victoryCounter = 0; //Transition to main menu starts after 600 frames
jumpSpd = -6.5;
hasJumped = false;
bashed = false;
enemyHitFromAttack = false;
attackBuffered = false; //If an attack is buffered, automatically attack again
pogoDelay = 0; //After attacking by pogo, wait 5 frames before pogo can attack again
invulnerableCounter = 0; //Invulnerability lasts 120 frames after hitting ground while stunned
paused = false;

//Font stuff
shovelFont = font_add("shovel-knight-extended.ttf", 6, false, false, 32, 128);
draw_set_font(shovelFont);

//State functions
idleState = function()
{
	xspd = 0;
	yspd = 0;
	sprite_index = sPlayerIdle;
	if (input.downHeld)
	{
		sprite_index = sPlayerCrouch;
	}
	if (!dialogueActive)
	{
		//Can run, jump, or attack out of idle
		if (input.jumpPressed)
		{
			yspd = -6.5;
			state = jumpState;
			image_index = 0;
			audio_play_sound(sfxSkJump, 0, false);
		}
		else if (input.rightHeld || input.leftHeld)
		{
			state = runState;
			image_index = 0;
		}
		else if (input.attackPressed)
		{
			state = attackState;
			image_index = 0;
		}
	}
	
}
jumpState = function()
{
	var moveDir = (input.rightHeld - input.leftHeld);
	if (input.rightHeld && input.leftHeld)
	{
		moveDir = -1;
	}
	xspd = moveDir * maxRunSpeed;
	if (yspd <= 2)
	{
		sprite_index = sPlayerJump;
	}
	else
	{
		sprite_index = sPlayerFall;
	}
	if (yspd < 0 && !input.jumpHeld)
	{
		yspd = max(yspd, yspd * (3/4));
	}
	if (landed)
	{
		audio_play_sound(sfxSkLand, 0, false);
		state = idleState;
		if (moveDir == 0)
		{
			state = idleState;
		}
		image_index = 0;
	}
	else if (input.downHeld)
	{
		state = pogoState;
		image_index = 0;
	}
	else if (input.attackPressed)
	{
		state = attackState;
		image_index = 0;
	}
}
pogoState = function()
{
	var moveDir = (input.rightHeld - input.leftHeld);
	if (input.rightHeld && input.leftHeld)
	{
		moveDir = -1;
	}
	xspd = moveDir * maxRunSpeed;
	sprite_index = sPlayerPogo;
	if (yspd < 0 && !input.jumpHeld)
	{
		yspd = max(yspd, yspd * (3/4));
	}
	if (landed)
	{
		audio_play_sound(sfxSkLand, 0, false);
		state = runState;
		if (moveDir == 0)
		{
			state = idleState;
		}
		image_index = 0;
	}
	else if (input.attackPressed)
	{
		state = attackState;
		image_index = 0;
	}
}
runState = function()
{
	runLerpInc += 0.125;
	var moveDir = (input.rightHeld - input.leftHeld);
	if (input.rightHeld && input.leftHeld)
	{
		moveDir = -1;
	}
	if (sign(moveDir) != 0 && sign(xspd) != 0 && sign(moveDir) != sign(xspd))
	{
		runLerpInc = 0;
		state = turnState;
	}
	elsek
	{
		xspd = moveDir * lerp(0, maxRunSpeed, clamp(runLerpInc, 0, 1));
		sprite_index = (abs(xspd) == maxRunSpeed) ? sPlayerRun : sPlayerRunStart;
		if (!input.rightHeld && !input.leftHeld)
		{
			runLerpInc = 0;
			state = idleState;
			image_index = 0;
		}
		else if (input.jumpPressed)
		{
			yspd = -6.5;
			state = jumpState;
			image_index = 0;
			audio_play_sound(sfxSkJump, 0, false);
		}
		else if (input.attackPressed)
		{
			runLerpInc = 0;
			state = attackState;
			image_index = 0;
		}
	}
}
turnState = function()
{
	sprite_index = sPlayerTurn;
	runLerpInc += 0.125;
	xspd = lerp(xspd, 0, clamp(runLerpInc, 0, 1));
	if (xspd == 0)
	{
		if (input.rightHeld || input.leftHeld)
		{
			state = runState;
		}
		else
		{
			runLerpInc = 0;
			state = idleState;
		}
	}
	else if (input.jumpPressed)
	{
		yspd = -6.5;
		state = jumpState;
		image_index = 0;
		audio_play_sound(sfxSkJump, 0, false);
	}
}
attackState = function() //Deal with exit in animation end
{
	sprite_index = sPlayerAttack;
	if (image_index >= 0 && image_index < 1 && (input.leftHeld || input.rightHeld))
	{
		image_xscale = (input.rightHeld - input.leftHeld);
		if (image_xscale == 0)
		{
			image_xscale = -1;
		}
	}
	else if (image_index >= 1 && image_index < 2 && !instance_exists(oPlayerAttackHitbox) && !enemyHitFromAttack)
	{
		instance_create_layer(x + (image_xscale * 25), y - 16, "Instances", oPlayerAttackHitbox);
		audio_play_sound(sfxSkAttack, 0, false);
	}
	else if (image_index >= 2 && input.attackPressed)
	{
		attackBuffered = true;
	}
	if (landed)
	{
		enemyHitFromAttack = false;
		attackBuffered = false;
		state = idleState;
		if (input.rightHeld || input.leftHeld)
		{
			state = runState;
		}
		image_index = 0;
		audio_play_sound(sfxSkLand, 0, false);
	}
	else if (grounded)
	{
		if (input.jumpPressed)
		{
			enemyHitFromAttack = false;
			attackBuffered = false;
			state = jumpState;
			yspd = -6.5;
			image_index = 0;
			audio_play_sound(sfxSkJump, 0, false);
		}
		else
		{
			xspd = 0;
		}
	}
	else
	{
		var moveDir = (input.rightHeld - input.leftHeld)
		if (input.rightHeld && input.leftHeld)
		{
			moveDir = -1;
		}
		xspd = moveDir * maxRunSpeed;
	}
}
stunState = function()
{
	sprite_index = sPlayerStunned;
	xspd = -image_xscale * 2;
	if (landed)
	{
		if (currentHealth != 0)
		{
			state = idleState;
			if (input.rightHeld || input.leftHeld)
			{
				state = runState;
			}
			image_index = 0;
			invulnerableCounter++;
		}
		else
		{
			state = dyingState;
			image_index = 0;
			audio_play_sound(sfxSkDying, 0, false);
		}
	}
}
dyingState = function()
{
	xspd = 0;
	yspd = 0;
	if (deathTransCounter > 0 && deathTransCounter < 60)
	{
		deathTransCounter++;
	}
	else if (deathTransCounter == 60)
	{
		instance_create_layer(0, 0, "Instances", oDeathTransition);
	}
}
state = idleState;