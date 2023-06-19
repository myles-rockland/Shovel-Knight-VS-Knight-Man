/// @description Insert description here
// You can write your code in this editor
//Font stuff
x = 0;
y = 0;
shovelFont = font_add("shovel-knight-extended.ttf", 6, false, false, 32, 128);

//Dialogue lines
text[0] = "\\0knight man: halt! have you seen a \\wshort, blue man \\0pass through this area?";
text[1] = "\\0shovel knight: well met, but no, sorry.";
text[2] = "\\0knight man: very well, i shall be on my way, then.";

modifier = "0";

text_current = 0; //Current text array position
timer = 0;
cutoff = (string_pos(":", text[text_current]) != 0 ? string_pos(":", text[text_current]) : 0); //Start from either colon or very start

t = 0;
amplitude = 1;
freq = 3;