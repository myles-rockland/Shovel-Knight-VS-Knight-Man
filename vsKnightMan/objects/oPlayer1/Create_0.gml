/// @description Update on instance creation
// You can write your code in this editor
xspd = 0;
yspd = 0;
prevXSpd = xspd;
prevYSpd = yspd;
grav = 0.3;

currentHealth = 8;
maxHealth = currentHealth;
gold = 0;
magic = 30;
armourType = 0; //0 for normal, 1 for Knight Man armour

/*
states =
[
	"idle",
	"crouching",
	"running",
	"turning",
	"jumping",
	"attacking",
	"pogoing",
	"stunned",
	"dying",
	"dead"
]
*/
currentState = "idle";

grounded = false;
landed = false;
runningInitSpeed = 1;
runningInitCounter = 0; //Wait 5 frames before moving at full speed
runningSpeed = 1.75;
turningCounter = 0; //Turning lasts 8 frames, sliding for 4, then not moving for 4
jumpSpd = -6.5;
hasJumped = false;
attackBuffered = false; //If an attack is buffered, automatically attack again
attackCounter = 0; //Attack lasts 21 frames, though maybe I should use animation end event?
pogoDelay = 0; //After attacking by pogo, wait 5 frames before pogo can attack again
invulnerableCounter = 0; //Invulnerability lasts 120 frames after hitting ground while stunned

//Font stuff
shovelFont = font_add("shovel-knight-extended.ttf", 6, false, false, 32, 128);
draw_set_font(shovelFont);