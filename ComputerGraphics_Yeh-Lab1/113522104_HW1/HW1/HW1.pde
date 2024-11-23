import java.util.List;
import java.awt.Color;
import javax.swing.JColorChooser;

ShapeButton lineButton;
ShapeButton circleButton;
ShapeButton polygonButton;
ShapeButton ellipseButton;
ShapeButton curveButton;
ShapeButton pencilButton;
ShapeButton eraserButton;

Button clearButton;
//add color pallete
Button colorButton;

ShapeRenderer shapeRenderer;
ArrayList<ShapeButton> shapeButton;
float eraserSize = 20;
Color currentColor = Color.BLACK; // 默認顏色

Color[] paletteColors = {
    Color.BLACK, Color.GRAY, Color.RED, Color.ORANGE, Color.YELLOW, 
    Color.GREEN, Color.CYAN, Color.BLUE, Color.MAGENTA, Color.PINK
   
};

boolean paletteVisible = false;
int paletteX = 305, paletteY = -5;  // 調色盤的位置
int colorSize = 30;  // 每個顏色選項的大小

void mousePressed() {
    // 檢查是否點擊在調色盤的範圍內
    if (paletteVisible) {
        for (int i = 0; i < paletteColors.length; i++) {
            int x = paletteX + (i % 5) * colorSize;
            int y = paletteY + (i / 5) * colorSize;
            // 檢查滑鼠是否點擊在顏色選項內
            if (mouseX >= x && mouseX <= x + colorSize && mouseY >= y && mouseY <= y + colorSize) {
                currentColor = paletteColors[i];  // 更新選中的顏色
                println("Selected color: " + currentColor);
                paletteVisible = false;  // 隱藏調色盤
                break;
            }
        }
    }
}

// 繪製調色盤
void drawPalette() {
    if (paletteVisible) {
        //println("Drawing Palette...");
        
        // 調色盤背景顏色（添加背景以便於區分）
        fill(240);  // 淺灰背景
        noStroke();
        rect(paletteX - 10, paletteY - 10, 5 * colorSize + 20, 3 * colorSize + 20);  // 調整調色盤的背景大小
        
        // 繪製顏色選項
        for (int i = 0; i < paletteColors.length; i++) {
            fill(paletteColors[i].getRGB());
            stroke(0);  // 為每個顏色添加邊框
            rect(paletteX + (i % 5) * colorSize, paletteY + (i / 5) * colorSize, colorSize, colorSize);
        }
    } else {
        //println("Palette is not visible");
    }
}

public void setup() {
    size(1000, 800);
    background(255);
    shapeRenderer = new ShapeRenderer();
    initButton();
    
    // 初始化顏色按鈕
    colorButton = new Button(255, 10, 30, 30);
    colorButton.setBoxAndClickColor(color(250), color(150));
    colorButton.setImage(loadImage("color.png"));
}

public void draw() {
    background(255);
   
   // draw all icon button
    for (ShapeButton sb : shapeButton) {
        sb.run(() -> {
            sb.beSelect();
            shapeRenderer.setRenderer(sb.getRendererType());
        });
    }
    
    // clear 
    clearButton.run(() -> {
        shapeRenderer.clear();
    });
    
    //color
    colorButton.run(() -> {
        println("click");  // 顯示點擊訊息
        paletteVisible = !paletteVisible;  // 切換調色盤顯示狀態
        println("Palette visibility toggled: " + paletteVisible);
    });
    drawPalette();
   
    shapeRenderer.box.show();
    shapeRenderer.run();

}

void resetButton() {
    for (ShapeButton sb : shapeButton) {
        sb.setSelected(false);
    }
}

public void initButton() {
    shapeButton = new ArrayList<ShapeButton>();
    lineButton = new ShapeButton(10, 10, 30, 30) {
        @Override
        public void show() {
            super.show();
            stroke(0);
            line(pos.x + 2, pos.y + 2, pos.x + size.x - 2, pos.y + size.y - 2);
        }

        @Override
        public Renderer getRendererType() {
            return new LineRenderer();
        }
        
    };

    lineButton.setBoxAndClickColor(color(250), color(150));
    shapeButton.add(lineButton);

    circleButton = new ShapeButton(45, 10, 30, 30) {
        @Override
        public void show() {
            super.show();
            stroke(0);
            circle(pos.x + size.x / 2, pos.y + size.y / 2, size.x - 2);
        }

        @Override
        public Renderer getRendererType() {
            return new CircleRenderer();
        }
    };
    circleButton.setBoxAndClickColor(color(250), color(150));
    shapeButton.add(circleButton);

    polygonButton = new ShapeButton(80, 10, 30, 30) {
        @Override
        public void show() {
            super.show();
            stroke(0);
            line(pos.x + 2, pos.y + 2, pos.x + size.x - 2, pos.y + 2);
            line(pos.x + 2, pos.y + size.y - 2, pos.x + size.x - 2, pos.y + size.y - 2);
            line(pos.x + size.x - 2, pos.y + 2, pos.x + size.x - 2, pos.y + size.y - 2);
            line(pos.x + 2, pos.y + 2, pos.x + 2, pos.y + size.y - 2);
        }

        @Override
        public Renderer getRendererType() {
            return new PolygonRenderer();
        }

    };

    polygonButton.setBoxAndClickColor(color(250), color(150));
    shapeButton.add(polygonButton);

    ellipseButton = new ShapeButton(115, 10, 30, 30) {
        @Override
        public void show() {
            super.show();
            stroke(0);
            ellipse(pos.x + size.x / 2, pos.y + size.y / 2, size.x - 2, size.y * 2 / 3);
        }

        @Override
        public Renderer getRendererType() {
            return new EllipseRenderer();
        }

    };

    ellipseButton.setBoxAndClickColor(color(250), color(150));
    shapeButton.add(ellipseButton);

    curveButton = new ShapeButton(150, 10, 30, 30) {
        @Override
        public void show() {
            super.show();
            stroke(0);
            bezier(pos.x, pos.y, pos.x, pos.y + size.y, pos.x + size.x, pos.y, pos.x + size.x, pos.y + size.y);
        }

        @Override
        public Renderer getRendererType() {
            return new CurveRenderer();
        }

    };

    curveButton.setBoxAndClickColor(color(250), color(150));
    shapeButton.add(curveButton);

    clearButton = new Button(width - 50, 10, 30, 30);
    clearButton.setBoxAndClickColor(color(250), color(150));
    clearButton.setImage(loadImage("clear.png"));

    pencilButton = new ShapeButton(185, 10, 30, 30) {
        @Override
        public Renderer getRendererType() {
            return new PencilRenderer();
        }
    };
    pencilButton.setImage(loadImage("pencil.png"));

    pencilButton.setBoxAndClickColor(color(250), color(150));
    shapeButton.add(pencilButton);

    eraserButton = new ShapeButton(220, 10, 30, 30) {
        @Override
        public Renderer getRendererType() {
            return new EraserRenderer();
        }
    };
    eraserButton.setImage(loadImage("eraser.png"));

    eraserButton.setBoxAndClickColor(color(250), color(150));
    shapeButton.add(eraserButton);
    
}

public void keyPressed() {
    if (key == 'z' || key == 'Z') {
        shapeRenderer.popShape();
    }

}

void mouseWheel(MouseEvent event) {
    float e = event.getCount();
    if (e < 0)
        eraserSize += 1;
    else if (e > 0)
        eraserSize -= 1;
    eraserSize = max(min(eraserSize, 30), 4);
}
