int num = 300; //配列の要素数

//位置に関する配列
float[] pos_x = new float[num];
float[] pos_y = new float[num];

//速度に関する配列
float[] vel_x = new float[num];
float[] vel_y = new float[num];

void setup() {
    size(1080, 720);
    
    //初期値をランダムに設定します    
    for(int i = 0; i < num; i ++)
    {
        pos_x[i] = random(width);
        pos_y[i] = random(height);

        vel_x[i] = random(-2, 2);
        vel_y[i] = random(-2, 2);
    }

}

void draw() {
    background(0);
    for(int i = 0; i < num; i ++)
    {
       pos_x[i] += vel_x[i];
       pos_y[i] += vel_y[i];

       //画面外に出そうになったら逆向きの速度にします。
       if(pos_x[i] < 0 || pos_x[i] > width) vel_x[i] *= -1;
       if(pos_y[i] < 0 || pos_y[i] > height) vel_y[i] *= -1; 

       fill(100, 255, 100);
       ellipse(pos_x[i], pos_y[i], 20, 20);
    }
}
