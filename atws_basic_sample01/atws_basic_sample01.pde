//01-1　まずは簡単な図形を書いてみる
size(500, 500); //描画平面の大きさを設定する関数。単位はピクセル。
ellipse(100, 100, 100, 100);

fill(255, 0, 0);
rect(200, 100, 100, 100);

stroke(0, 255, 0);
line(300, 100, 400, 200);

//01-2 変数使ってみる
int x = 0;
int y = 250;
float w = 100;
float h = 100;

stroke(0);

fill(155, 0, 100);
ellipse(x, y, w, h);

x = x + 200;
w = w * 1.5;

fill(155, 100, 0);
ellipse(x, y, w, h);

y += 200;
h /= 0.5;

fill(50, 100, 100);
ellipse(x, y, w, h);