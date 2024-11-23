### 1.which tasks I have completed
##### I think this assignment is simulating a small painting application, where I use the algorithms taught in class to implement the functionality of drawing lines and shapes.

### 2.some screenshots of this work
##### (1) Draw Line.
###### I try to use Midpoint Line Algorithm to draw a line. (by asking ChatGPT)
###### But I also learned that there are other common algorithm to draw line, like DDA algorithm.
![picture 1](./demo%20image/1-1.jpg)


##### (2) Draw Polygon.
###### At first, I am unable to close the polygon. When I return to the starting point, it still draws a line.
###### So I carefully checked the code and found that when returning to the starting point, you need to "right-click" the mouse, and then it works.
![picture 2](./demo%20image/2-1.jpg)

##### (3) Draw Circle.
###### I use Midpoint Circle Algorithm that teach in classes to draw a Circle.(by using ChatGPT as well)
![picture 3](./demo%20image/3-1.jpg)

##### (4) Draw Eclipse.
###### For this part, The HackMD for Assignment 1 includes some reference websites, so I visited the Geeksforgeeks.org website and used the Midpoint ellipse drawing algorithm to complete the ellipse drawing. 
###### I also asked ChatGPT for guidance on how to write the code.
![picture 4](./demo%20image/4-1.jpg)

##### (5) Draw Curve.
###### So same as drawing Eclipse, I visit the website present on HackMD, and with the help of ChatGPT.
###### But the code ChatGPT initially provided drew curves as many individual points rather than connected lines, so I added a "segment" variable. By increasing the number of segments, the drawn curve became continuous.
![picture 5](./demo%20image/5-1.jpg)

##### (6) Pencil Line.
###### Pencil line is actually based on Line drawing function, so this part is easier.
![picture 6](./demo%20image/6-1.jpg)

##### (7) Eraser.
###### I use the method  to determine the minimum and maximum x and y coordinates between the two points to define the rectangular erase area.
###### And changes all pixel color to the background color.
![picture 7](./demo%20image/7-1.jpg)

##### (8) Color Palette.
###### I add a color palette button to let user to choose color and draw. After clicking the button, the palette will show, and tou can pick a color.
###### But there's a problem, after I choose another color, the shape I draw before will also change to a new color too. I'm still can't figure it out due to the time limit.
![picture 8](./demo%20image/8-1.jpg)
![picture 9](./demo%20image/8-2.jpg)

### 3.how I completed these tasks
###### Since there are many pdf file and functions inside, so at first, I uploaded each .pde file to ChatGPT to let it explain the functions of these files. 
###### Then, I used screenshots to send the algorithms mentioned in class and asked it how to combine them with the structure of this assignment to write the code. I also provided links to ChatGPT to help it better understand what I was talking about. 
###### For the problem I encounter in this Homework, I usually give ChatGPT clear instructions, such as what kind of effect I want to achieve or which part I hope to change. This way, problems can be solved more quickly. 