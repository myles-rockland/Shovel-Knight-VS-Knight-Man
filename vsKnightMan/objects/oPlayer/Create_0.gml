/// @description Update on instance creation
// You can write your code in this editor
input = instance_nearest(oInput);

xspd = 0;
yspd = 0;
grav = 0.3;

currentHealth = 8;
maxHealth = currentHealth;
gold = 0;
magic = 30;
//There should be max health and max gold variables

// states = ["idle", "crouching", "running", "jumping", "turning", "attacking", "pogoing", "stunned", "dying", "dead", "victory", "paused"];
currentState = idleState;
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
	sprite_index = ((instance_nearest(x,y,oGame)).armourType == 0) ? sPlayerIdle : sPlayerIdleAlt;
	if (input.downHeld)
	{
		sprite_index = ((instance_nearest(x,y,oGame)).armourType == 0) ? sPlayerCrouch : sPlayerCrouchAlt;
	}
	if (!dialogueActive)
	{
		//Can run, jump, or attack out of idle
		if (input.jumpKeyPressed)
		{
			state = jumpState;
			image_index = 0;
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
}
runState = function()
{}
attackState = function()
{}