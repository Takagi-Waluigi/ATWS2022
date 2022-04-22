//3. ループさせて大量の図形を描く
size(1000, 100);

float shapeSize = 1.0;

for(int i = 0; i < 100; i ++)
{
    ellipse(i * 10, height/2, shapeSize, shapeSize);
    shapeSize ++;
}