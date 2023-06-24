/// @description Insert description here
// You can write your code in this editor

var enemy = instance_nearest(x, y, oEnemy);
var player = instance_nearest(x, y, oPlayer1);
enemy.image_speed = 1;
player.paused = false;
player.image_speed = 1;
player.grav = 0.3;
enemy.grav = 0.3;
player.xspd = playerPrevXSpd;
player.yspd = playerPrevYSpd;
enemy.xspd = enemyPrevXSpd;
enemy.yspd = enemyPrevYSpd;
audio_resume_sound(musFight);
instance_destroy();