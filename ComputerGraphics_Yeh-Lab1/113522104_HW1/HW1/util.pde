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
    
    int colorValue = currentColor.getRGB();  // 獲取當前顏色的RGB值
    // If the start and end points are the same, do not draw
    if (x1 == x2 && y1 == y2) {
        return; // Exit the method early to avoid drawing a line
    }

    // Calculate the differences
    int dx = (int)(x2 - x1);
    int dy = (int)(y2 - y1);

    // Determine the absolute values of dx and dy
    int absDx = Math.abs(dx);
    int absDy = Math.abs(dy);

    // Initialize variables
    int d; // Decision parameter
    int x = (int)x1;
    int y = (int)y1;

    // Determine the direction of the steps
    int xStep = (dx >= 0) ? 1 : -1;
    int yStep = (dy >= 0) ? 1 : -1;

    // Draw the initial point
    drawPoint(x, y, colorValue); // Assuming color(0) is black

    // Initialize the decision variable
    if (absDx >= absDy) {
        // Case 1: The slope is less than or equal to 1
        d = absDy - (absDx / 2);

        while (x != x2) {
            x += xStep; // Increment x

            // Update the decision variable
            if (d >= 0) {
                y += yStep; // Increment y if necessary
                d -= absDx; // Adjust decision parameter
            }
            d += absDy; // Always adjust decision parameter
            drawPoint(x, y, colorValue); // Draw the pixel
        }
    } else {
        // Case 2: The slope is greater than 1
        d = absDx - (absDy / 2);

        while (y != y2) {
            y += yStep; // Increment y

            // Update the decision variable
            if (d >= 0) {
                x += xStep; // Increment x if necessary
                d -= absDy; // Adjust decision parameter
            }
            d += absDx; // Always adjust decision parameter
            drawPoint(x, y, colorValue); // Draw the pixel
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
    int colorValue = currentColor.getRGB();  // 獲取當前顏色的RGB值

    // mid-point algorithm
    int xc = (int)x;
    int yc = (int)y;
    int radius = (int)r;

    int xPos = 0;
    int yPos = radius;
    int d = 1 - radius;  

    while (xPos <= yPos) {
        // eight points
        drawPoint(xc + xPos, yc + yPos,  colorValue);
        drawPoint(xc - xPos, yc + yPos,  colorValue);
        drawPoint(xc + xPos, yc - yPos,  colorValue);
        drawPoint(xc - xPos, yc - yPos,  colorValue);
        drawPoint(xc + yPos, yc + xPos,  colorValue);
        drawPoint(xc - yPos, yc + xPos,  colorValue);
        drawPoint(xc + yPos, yc - xPos,  colorValue);
        drawPoint(xc - yPos, yc - xPos,  colorValue);

        
        if (d < 0) {
            d += 2 * xPos + 3;  
        } else {
            d += 2 * (xPos - yPos) + 5;  
            yPos--; 
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
    
    int colorValue = currentColor.getRGB();
    int a2 = (int) (r1 * r1); // r1^2
    int b2 = (int) (r2 * r2); // r2^2

    int x0 = 0; 
    float y0 = r2; 

   
    int p1 = (int) (b2 - (a2 * y0) + (0.25 * a2));
    
    // part1
    while ((a2 * y0) > (b2 * x0)) {
        drawPoint(x + x0, y + y0, colorValue); // 第一象限
        drawPoint(x - x0, y + y0, colorValue); // 第二象限
        drawPoint(x + x0, y - y0, colorValue); // 第三象限
        drawPoint(x - x0, y - y0, colorValue); // 第四象限
        
        
        if (p1 < 0) {
            p1 += (b2 * (2 * x0 + 3)); 
        } else {
            p1 += (b2 * (2 * x0 + 3)) - (a2 * (2 * y0 - 1)); 
            y0--;
        }
        x0++;
    }

   
    int p2 = (int) (b2 * (x0 + 0.5) * (x0 + 0.5) + a2 * (y0 - 1) * (y0 - 1) - a2 * b2);
    
    // part2
    while (y0 >= 0) {
        drawPoint(x + x0, y + y0, colorValue); // 第一象限
        drawPoint(x - x0, y + y0, colorValue); // 第二象限
        drawPoint(x + x0, y - y0, colorValue); // 第三象限
        drawPoint(x - x0, y - y0, colorValue); // 第四象限
        
        
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
    
    int colorValue = currentColor.getRGB();
    // segment update
    int segments = 1000; 

    for (int i = 0; i <= segments; i++) {
        float t = (float) i / segments; // count t

        float x = (float) (Math.pow(1 - t, 3) * p1.x +
                           3 * Math.pow(1 - t, 2) * t * p2.x +
                           3 * (1 - t) * Math.pow(t, 2) * p3.x +
                           Math.pow(t, 3) * p4.x);

        float y = (float) (Math.pow(1 - t, 3) * p1.y +
                           3 * Math.pow(1 - t, 2) * t * p2.y +
                           3 * (1 - t) * Math.pow(t, 2) * p3.y +
                           Math.pow(t, 3) * p4.y);

       
        drawPoint(Math.round(x), Math.round(y), colorValue); // 使用round以確保坐標為整數
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
    // 背景颜色
    color backgroundColor = color(250);
    
    // 确定擦除区域的边界
    int minX = (int) Math.min(p1.x, p2.x);
    int maxX = (int) Math.max(p1.x, p2.x);
    int minY = (int) Math.min(p1.y, p2.y);
    int maxY = (int) Math.max(p1.y, p2.y);

    // 遍历擦除区域的每个像素
    for (int x = minX; x <= maxX; x++) {
        for (int y = minY; y <= maxY; y++) {
            drawPoint(x, y, backgroundColor); // 将像素设置为背景颜色
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
