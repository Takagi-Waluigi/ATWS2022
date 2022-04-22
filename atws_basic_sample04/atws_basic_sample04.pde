//ここまでのことを応用してできることー

size(600, 600);

int diameter = 50;
for(int x = 0; x <= width; x += diameter)
{
    for(int y = 0; y <= height; y += diameter)
    {
        int x_count = x / diameter;
        int y_count = y / diameter;

        if((x_count + y_count) % 2 == 0)
        {
            fill(200, 100, 100);
        }
        else
        {
            fill(100, 100, 200);
        }
        ellipse(x, y, diameter, diameter);
    }
}