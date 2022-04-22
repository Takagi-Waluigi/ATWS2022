//02　値によって色を変える
size(200, 200);
float num = random(100);
println("random number: " + num);

if(num <= 33)
{
    fill(255, 0, 0);
}
else if(num <= 66)
{
    fill(0, 255, 0);
}
else
{
    fill(0, 0, 255);
}

ellipse(100, 100, 100, 100);