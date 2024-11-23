public void CGLine(float x1, float y1, float x2, float y2) {
    // TODO HW1
    // Please paste your code from HW1 CGLine.
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
    drawPoint(x, y,color(0)); // Assuming color(0) is black

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
            drawPoint(x, y, color(0)); // Draw the pixel
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
            drawPoint(x, y, color(0)); // Draw the pixel
        }
    }
}

public boolean outOfBoundary(float x, float y) {
    if (x < 0 || x >= width || y < 0 || y >= height)
        return true;
    return false;
}

public void drawPoint(float x, float y, color c) {
    int index = (int) y * width + (int) x;
    if (outOfBoundary(x, y))
        return;
    pixels[index] = c;
}

public float distance(Vector3 a, Vector3 b) {
    Vector3 c = a.sub(b);
    return sqrt(Vector3.dot(c, c));
}

boolean pnpoly(float x, float y, Vector3[] vertexes) {
    // TODO HW2 
    // You need to check the coordinate p(x,v) if inside the vertices. 
    // If yes return true, vice versa.
    
    // Confirm that the endpoint is not empty and contains at least 3 endpoints
    if (vertexes == null || vertexes.length < 3) {
        return false; 
    }

     // Use ray method to determine whether a point is within a polygon
    int n = vertexes.length;
    boolean inside = false;
   
    for (int i = 0, j = n - 1; i < n; j = i++) {
        float xi = vertexes[i].x;
        float yi = vertexes[i].y;
        float xj = vertexes[j].x;
        float yj = vertexes[j].y;

        if ((yi > y) != (yj > y) && 
            (x < (xj - xi) * (y - yi) / (yj - yi) + xi)) {
            inside = !inside;
        }
    }

    // Returns true if the point is inside the polygon
    if (inside) {
        return true;
    }
    return false;
}

public Vector3[] findBoundBox(Vector3[] v) {
     // Check if there is a valid vertex array
    if (v == null || v.length == 0) {
        Vector3 recordminV = new Vector3(0);
        Vector3 recordmaxV = new Vector3(999);
        Vector3[] result = { recordminV, recordmaxV };
        return result;
    }

    // TODO HW2 
    // You need to find the bounding box of the vertices v.
    // r1 -------
    //   |   /\  |
    //   |  /  \ |
    //   | /____\|
    //    ------- r2
    
    // Initialize the minimum and maximum values ​​to the coordinates of the first vertex
    Vector3 recordminV = new Vector3(v[0].x, v[0].y, v[0].z);
    Vector3 recordmaxV = new Vector3(v[0].x, v[0].y, v[0].z);
    
    // Traverse all vertices and find the minimum and maximum x, y, z values
    for (int i = 1; i < v.length; i++) {
        
        if (v[i].x < recordminV.x) recordminV.x = v[i].x;
        if (v[i].x > recordmaxV.x) recordmaxV.x = v[i].x;
        
        if (v[i].y < recordminV.y) recordminV.y = v[i].y;
        if (v[i].y > recordmaxV.y) recordmaxV.y = v[i].y;
     
        if (v[i].z < recordminV.z) recordminV.z = v[i].z;
        if (v[i].z > recordmaxV.z) recordmaxV.z = v[i].z;
    }
    
    Vector3[] result = { recordminV, recordmaxV };
    return result;

}

public Vector3[] Sutherland_Hodgman_algorithm(Vector3[] points, Vector3[] boundary) {
    ArrayList<Vector3> input = new ArrayList<Vector3>();
    ArrayList<Vector3> output = new ArrayList<Vector3>();
    for (int i = 0; i < points.length; i += 1) {
        input.add(points[i]);
    }

    // TODO HW2
    // You need to implement the Sutherland Hodgman Algorithm in this section.
    // The function you pass 2 parameter. One is the vertexes of the shape "points".
    // And the other is the vertices of the "boundary".
    // The output is the vertices of the polygon.

    // Crop each boundary line
    for (int i = 0; i < boundary.length; i++) {
        // Clear the output to store the results of this cropping
        output.clear();
        
        // Get the two endpoints of the boundary line
        Vector3 clipEdgeStart = boundary[i];
        Vector3 clipEdgeEnd = boundary[(i + 1) % boundary.length];
        
        // Process the vertices of each polygon
        for (int j = 0; j < input.size(); j++) {
            // Get current point and previous point
            Vector3 currentPoint = input.get(j);
            Vector3 prevPoint = input.get((j + input.size() - 1) % input.size());
            
            // Calculate whether the current point and the previous point are inside the boundary
            float currentSide = (clipEdgeEnd.x - clipEdgeStart.x) * (currentPoint.y - clipEdgeStart.y) - 
                              (clipEdgeEnd.y - clipEdgeStart.y) * (currentPoint.x - clipEdgeStart.x);
            float prevSide = (clipEdgeEnd.x - clipEdgeStart.x) * (prevPoint.y - clipEdgeStart.y) - 
                           (clipEdgeEnd.y - clipEdgeStart.y) * (prevPoint.x - clipEdgeStart.x);
            
            // If the current point is inside
            if (currentSide <= 0) {
                // If the previous point is outside, calculate and add the intersection point
                if (prevSide > 0) {
                    // Calculate intersection point
                    float A1 = currentPoint.y - prevPoint.y;
                    float B1 = prevPoint.x - currentPoint.x;
                    float C1 = A1 * prevPoint.x + B1 * prevPoint.y;
                    
                    float A2 = clipEdgeEnd.y - clipEdgeStart.y;
                    float B2 = clipEdgeStart.x - clipEdgeEnd.x;
                    float C2 = A2 * clipEdgeStart.x + B2 * clipEdgeStart.y;
                    
                    float det = A1 * B2 - A2 * B1;
                    if (Math.abs(det) > 1e-7) {         // Avoid dividing by 0
                        float intersectX = (B2 * C1 - B1 * C2) / det;
                        float intersectY = (A1 * C2 - A2 * C1) / det;
                        output.add(new Vector3(intersectX, intersectY, 0));
                    }
                }
                // Add current point
                output.add(currentPoint);
            }
            // If the current point is outside but the previous point is inside
            else if (prevSide <= 0) {
                // Calculate intersection point
                float A1 = currentPoint.y - prevPoint.y;
                float B1 = prevPoint.x - currentPoint.x;
                float C1 = A1 * prevPoint.x + B1 * prevPoint.y;
                
                float A2 = clipEdgeEnd.y - clipEdgeStart.y;
                float B2 = clipEdgeStart.x - clipEdgeEnd.x;
                float C2 = A2 * clipEdgeStart.x + B2 * clipEdgeStart.y;
                
                float det = A1 * B2 - A2 * B1;
                if (Math.abs(det) > 1e-7) {     // Avoid dividing by 0
                    float intersectX = (B2 * C1 - B1 * C2) / det;
                    float intersectY = (A1 * C2 - A2 * C1) / det;
                    output.add(new Vector3(intersectX, intersectY, 0));
                }
            }
        }
        
        // Use output as input for next cropping
        input = new ArrayList<Vector3>(output);
    }

    Vector3[] result = new Vector3[output.size()];
    for (int i = 0; i < result.length; i += 1) {
        result[i] = output.get(i);
    }
    return result;
}
