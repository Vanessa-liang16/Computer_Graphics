public void CGLine(float x1, float y1, float x2, float y2) {
    // TODO HW1
    // You need to implement the "line algorithm" in this section.
    // You can use the function line(x1, y1, x2, y2); to verify the correct answer.
    // However, remember to comment out before you submit your homework.
    // Otherwise, you will receive a score of 0 for this part.
    // Utilize the function drawPoint(x, y, color) to apply color to the pixel at
    // coordinates (x, y).
    // For instance: drawPoint(114, 514, color(255, 0, 0)); signifies drawing a red
    // point at (114, 514).
    
    if (x1 == x2 && y1 == y2) {
        return; // No need to draw a line if both points are the same
    }

    // Convert coordinates to integers for pixel precision
    int xStart = (int)x1;
    int yStart = (int)y1;
    int xEnd = (int)x2;
    int yEnd = (int)y2;

    // Calculate differences
    int dx = xEnd - xStart;
    int dy = yEnd - yStart;

    // Determine step directions
    int xStep = (dx >= 0) ? 1 : -1;
    int yStep = (dy >= 0) ? 1 : -1;

    dx = Math.abs(dx);
    dy = Math.abs(dy);

    // Midpoint decision variable initialization
    if (dx > dy) {
        // Case 1: Gentle slope (|slope| <= 1)
        int d = 2 * dy - dx;  // Initial decision parameter
        int dE = 2 * dy;      // East increment
        int dNE = 2 * (dy - dx); // North-East increment

        // Start drawing from (xStart, yStart)
        int x = xStart;
        int y = yStart;
        drawPoint(x, y, color(0));  // Draw the starting point

        while (x != xEnd) {
            if (d <= 0) {
                // Choose East pixel
                d += dE;
            } else {
                // Choose North-East pixel
                d += dNE;
                y += yStep;
            }
            x += xStep;
            drawPoint(x, y, color(0));  // Draw the point
        }
    } else {
        // Case 2: Steep slope (|slope| > 1)
        int d = 2 * dx - dy;  // Initial decision parameter
        int dN = 2 * dx;      // North increment
        int dNE = 2 * (dx - dy); // North-East increment

        // Start drawing from (xStart, yStart)
        int x = xStart;
        int y = yStart;
        drawPoint(x, y, color(0));  // Draw the starting point

        while (y != yEnd) {
            if (d <= 0) {
                // Choose North pixel
                d += dN;
            } else {
                // Choose North-East pixel
                d += dNE;
                x += xStep;
            }
            y += yStep;
            drawPoint(x, y, color(0));  // Draw the point
        }
    }
    /*
     stroke(0);
     noFill();
     line(x1,y1,x2,y2);
    */
}

public void CGCircle(float x, float y, float r) {
    // TODO HW1
    // You need to implement the "circle algorithm" in this section.
    // You can use the function circle(x, y, r); to verify the correct answer.
    // However, remember to comment out before you submit your homework.
    // Otherwise, you will receive a score of 0 for this part.
    // Utilize the function drawPoint(x, y, color) to apply color to the pixel at
    // coordinates (x, y).
     int circleColor = color(0);  

    int xc = (int)x;
    int yc = (int)y;
    int radius = (int)r;

    int xPos = 0;
    int yPos = radius;
    int d = 1 - radius;  

    while (xPos <= yPos) {
        // eight point
        drawPoint(xc + xPos, yc + yPos, circleColor);
        drawPoint(xc - xPos, yc + yPos, circleColor);
        drawPoint(xc + xPos, yc - yPos, circleColor);
        drawPoint(xc - xPos, yc - yPos, circleColor);
        drawPoint(xc + yPos, yc + xPos, circleColor);
        drawPoint(xc - yPos, yc + xPos, circleColor);
        drawPoint(xc + yPos, yc - xPos, circleColor);
        drawPoint(xc - yPos, yc - xPos, circleColor);

        
        if (d < 0) {
            d += 2 * xPos + 3;  
        } else {
            d += 2 * (xPos - yPos) + 5;  
            yPos--;  // radius
        }
        xPos++; 
    }
    /*
    stroke(0);
    noFill();
    circle(x,y,r*2);
    */
}

public void CGEllipse(float x, float y, float r1, float r2) {
    // TODO HW1
    // You need to implement the "ellipse algorithm" in this section.
    // You can use the function ellipse(x, y, r1,r2); to verify the correct answer.
    // However, remember to comment out the function before you submit your homework.
    // Otherwise, you will receive a score of 0 for this part.
    // Utilize the function drawPoint(x, y, color) to apply color to the pixel at
    // coordinates (x, y).
    int a2 = (int) (r1 * r1); // r1^2
    int b2 = (int) (r2 * r2); // r2^2

    int x0 = 0; 
    float y0 = r2; 

    // initialize
    int p1 = (int) (b2 - (a2 * y0) + (0.25 * a2));
    
    //part1
    while ((a2 * y0) > (b2 * x0)) {
        drawPoint(x + x0, y + y0, color(0)); // 第一象限
        drawPoint(x - x0, y + y0, color(0)); // 第二象限
        drawPoint(x + x0, y - y0, color(0)); // 第三象限
        drawPoint(x - x0, y - y0, color(0)); // 第四象限
        
        if (p1 < 0) {
            p1 += (b2 * (2 * x0 + 3)); 
        } else {
            p1 += (b2 * (2 * x0 + 3)) - (a2 * (2 * y0 - 1));
            y0--; 
        }
        x0++; 
    }

    // initialize
    int p2 = (int) (b2 * (x0 + 0.5) * (x0 + 0.5) + a2 * (y0 - 1) * (y0 - 1) - a2 * b2);
    
    // part2
    while (y0 >= 0) {
        drawPoint(x + x0, y + y0, color(0)); // 第一象限
        drawPoint(x - x0, y + y0, color(0)); // 第二象限
        drawPoint(x + x0, y - y0, color(0)); // 第三象限
        drawPoint(x - x0, y - y0, color(0)); // 第四象限
        
        if (p2 > 0) {
            p2 -= (a2 * (2 * y0 - 3)); 
        } else {
            p2 += (b2 * (2 * x0 + 2)) - (a2 * (2 * y0 - 3)); 
            x0++; 
        }
        y0--; 
    }
    /*
    stroke(0);
    noFill();
    ellipse(x,y,r1*2,r2*2);
    */
  
}

public void CGCurve(Vector3 p1, Vector3 p2, Vector3 p3, Vector3 p4) {
    // TODO HW1
    // You need to implement the "bezier curve algorithm" in this section.
    // You can use the function bezier(p1.x, p1.y, p2.x, p2.y, p3.x, p3.y, p4.x,
    // p4.y); to verify the correct answer.
    // However, remember to comment out before you submit your homework.
    // Otherwise, you will receive a score of 0 for this part.
    // Utilize the function drawPoint(x, y, color) to apply color to the pixel at
    // coordinates (x, y).
   
    color curveColor = color(0); // black

    // increase segments
    int segments = 1000; 

    for (int i = 0; i <= segments; i++) {
        float t = (float) i / segments; 

        // count the coordinates
        float x = (float) (Math.pow(1 - t, 3) * p1.x +
                           3 * Math.pow(1 - t, 2) * t * p2.x +
                           3 * (1 - t) * Math.pow(t, 2) * p3.x +
                           Math.pow(t, 3) * p4.x);

        float y = (float) (Math.pow(1 - t, 3) * p1.y +
                           3 * Math.pow(1 - t, 2) * t * p2.y +
                           3 * (1 - t) * Math.pow(t, 2) * p3.y +
                           Math.pow(t, 3) * p4.y);

        // draw every point on the curve
        drawPoint(Math.round(x), Math.round(y), curveColor); // use round to ensure is integer
    }
    /*
    stroke(0);
    noFill();
    bezier(p1.x,p1.y,p2.x,p2.y,p3.x,p3.y,p4.x,p4.y);
    */
}

public void CGEraser(Vector3 p1, Vector3 p2) {
    // TODO HW1
    // You need to erase the scene in the area defined by points p1 and p2 in this
    // section.
    // p1 ------
    // |       |
    // |       |
    // ------ p2
    // The background color is color(250);
    // You can use the mouse wheel to change the eraser range.
    // Utilize the function drawPoint(x, y, color) to apply color to the pixel at
    // coordinates (x, y).
    
    // set color to backgroung color
    color backgroundColor = color(250);
    
    //erase the border
    int minX = (int) Math.min(p1.x, p2.x);
    int maxX = (int) Math.max(p1.x, p2.x);
    int minY = (int) Math.min(p1.y, p2.y);
    int maxY = (int) Math.max(p1.y, p2.y);

    // every pixel of erase area
    for (int x = minX; x <= maxX; x++) {
        for (int y = minY; y <= maxY; y++) {
            drawPoint(x, y, backgroundColor); // set pixel to background color
        }
    }
}

public void drawPoint(float x, float y, color c) {
    stroke(c);
    point(x, y);
}

public float distance(Vector3 a, Vector3 b) {
    Vector3 c = a.sub(b);
    return sqrt(Vector3.dot(c, c));
}
