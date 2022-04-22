//三角関数の可視化

void setup() {
    size(600, 600);

}

void draw() {
    background(0);

    for(int x = 0; x < width; x ++)
    {
        float theta = map(x, 0, width, 0, TWO_PI);
        float y_sin =  height * 0.5 + height * 0.2 *sin(theta - frameCount * 0.01);

        float y_cos =  height * 0.5 + height * 0.2 *cos(theta - frameCount * 0.01);

        stroke(255, 200, 100, 128);
        line(x, height/2, x, y_sin);

        stroke(100, 200, 255, 128);
        line(x, height/2, x, y_cos);

        stroke(200, 100, 255, 128);
        line(x, height/2, x, (y_sin + y_cos) - height * 0.5);
    }
}
