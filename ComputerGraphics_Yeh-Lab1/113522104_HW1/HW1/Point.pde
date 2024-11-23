public interface Shape {
    public void drawShape();
    public void setColor(Color shapeColor);  // 為形狀設置顏色
}

public class Point implements Shape {
    private Color shapeColor = Color.BLACK; 
    ArrayList<Vector3> points = new ArrayList<Vector3>();

    public Point(ArrayList<Vector3> p) {
        points = p;
    }

    @Override
    public void drawShape() {
        if (points.size() <= 1)
            return;
        for (int i = 0; i < points.size() - 1; i++) {
            Vector3 p1 = points.get(i);
            Vector3 p2 = points.get(i + 1);
            stroke(shapeColor.getRGB()); 
            CGLine(p1.x, p1.y, p2.x, p2.y);
        }
    }
    @Override
    public void setColor(Color shapeColor) {
        this.shapeColor = shapeColor; // 設置顏色
    }
}

public class Line implements Shape {
    Vector3 point1;
    Vector3 point2;
    private Color shapeColor = Color.BLACK;
    public Line() {
    };

    public Line(Vector3 v1, Vector3 v2) {
        point1 = v1;
        point2 = v2;
    }

    @Override
    public void drawShape() {
        stroke(shapeColor.getRGB()); // 使用當前顏色
        CGLine(point1.x, point1.y, point2.x, point2.y);
    }
    @Override
    public void setColor(Color shapeColor) {
        this.shapeColor = shapeColor; // 設置顏色
    }
}

public class Circle implements Shape {
    Vector3 center;
    float radius;
    private Color shapeColor = Color.BLACK;
    
    public Circle() {
    }

    public Circle(Vector3 v1, float r) {
        center = v1;
        radius = r;
    }

    @Override
    public void drawShape() {
        stroke(shapeColor.getRGB()); // 使用當前顏色
        CGCircle(center.x, center.y, radius);
    }
    @Override
    public void setColor(Color shapeColor) {
        this.shapeColor = shapeColor; // 設置顏色
    }
}

public class Polygon implements Shape {
    private Color shapeColor = Color.BLACK;
    ArrayList<Vector3> verties = new ArrayList<Vector3>();

    public Polygon(ArrayList<Vector3> v) {
        verties = v;
    }

    @Override
    public void drawShape() {
        if (verties.size() <= 0)
            return;
        for (int i = 0; i <= verties.size(); i++) {
            Vector3 p1 = verties.get(i % verties.size());
            Vector3 p2 = verties.get((i + 1) % verties.size());
            stroke(shapeColor.getRGB());
            CGLine(p1.x, p1.y, p2.x, p2.y);
        } 
        for (int i = 0; i < verties.size(); i++) { // Change from <= to <
          Vector3 p1 = verties.get(i);
          Vector3 p2 = verties.get((i + 1) % verties.size()); // Correctly wraps around to the first point
          stroke(shapeColor.getRGB());
          CGLine(p1.x, p1.y, p2.x, p2.y);
        }
    }
     @Override
    public void setColor(Color shapeColor) {
        this.shapeColor = shapeColor; // 設置顏色
    }
}

public class Ellipse implements Shape {
    Vector3 center;
    float radius1, radius2;
    private Color shapeColor = Color.BLACK;
    public Ellipse() {
    }

    public Ellipse(Vector3 cen, float r1, float r2) {
        center = cen;
        radius1 = r1;
        radius2 = r2;
    }

    @Override
    public void drawShape() {
        stroke(shapeColor.getRGB());
        CGEllipse(center.x, center.y, radius1, radius2);
    }
    @Override
    public void setColor(Color shapeColor) {
        this.shapeColor = shapeColor; // 設置顏色
    }
}

public class Curve implements Shape {
    Vector3 cpoint1, cpoint2, cpoint3, cpoint4;
    float radius1, radius2;
    private Color shapeColor = Color.BLACK;

    public Curve() {
    }

    public Curve(Vector3 p1, Vector3 p2, Vector3 p3, Vector3 p4) {
        cpoint1 = p1;
        cpoint2 = p2;
        cpoint3 = p3;
        cpoint4 = p4;
    }

    @Override
    public void drawShape() {
        stroke(shapeColor.getRGB());
        CGCurve(cpoint1, cpoint2, cpoint3, cpoint4);
    }
    @Override
    public void setColor(Color shapeColor) {
        this.shapeColor = shapeColor; // 設置顏色
    }
}

public class EraseArea implements Shape {
    Vector3 point1, point2;
    private Color shapeColor = Color.BLACK;

    public EraseArea() {
    }

    public EraseArea(Vector3 p1, Vector3 p2) {
        point1 = p1;
        point2 = p2;
    }

    @Override
    public void drawShape() {
        stroke(shapeColor.getRGB());
        CGEraser(point1, point2);
    }
    @Override
    public void setColor(Color shapeColor) {
        this.shapeColor = shapeColor; // 設置顏色
    }
}
