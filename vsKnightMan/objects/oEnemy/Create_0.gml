/// @description Insert description here
// You can write your code in this editor
currentHealth = 20;
maxHealth = currentHealth;

xspd = 0;
yspd = 0;

grounded = false;

states =
[
	"idle",
	"running",
	"jumping",
	"swinging",
	"throwing",
	"bashing",
	"blockingUp",
	"blockingSide",
	"replenishing",
	"dying",
	"crouching",
	"teleporting"
]

currentState = "idle";
nextState = "random"; //random state comes afer jumping

idleCounter = 0; //Wait about 40 frames between actions
runningCounter = 0; //Run for 60 frames towards player
jumpCounter = 0; //Jump three times before next action