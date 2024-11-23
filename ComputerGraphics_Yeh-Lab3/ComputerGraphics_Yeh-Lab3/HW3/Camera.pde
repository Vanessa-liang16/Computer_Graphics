public class Camera {
    Matrix4 projection = new Matrix4();
    Matrix4 worldView = new Matrix4();
    int wid;
    int hei;
    float near;
    float far;
    Transform transform;

    Camera() {
        wid = 256;
        hei = 256;
        worldView.makeIdentity();
        projection.makeIdentity();
        transform = new Transform();
    }

    Matrix4 inverseProjection() {
        Matrix4 invProjection = Matrix4.Zero();
        float a = projection.m[0];
        float b = projection.m[5];
        float c = projection.m[10];
        float d = projection.m[11];
        float e = projection.m[14];
        invProjection.m[0] = 1.0f / a;
        invProjection.m[5] = 1.0f / b;
        invProjection.m[11] = 1.0f / e;
        invProjection.m[14] = 1.0f / d;
        invProjection.m[15] = -c / (d * e);
        return invProjection;
    }

    Matrix4 Matrix() {
        return projection.mult(worldView);
    }

    void setSize(int w, int h, float n, float f) {
        wid = w;
        hei = h;
        near = n;
        far = f;
        
        // TODO HW3
        // This function takes four parameters, which are 
        // the width of the screen, the height of the screen
        // the near plane and the far plane of the camera.
        // Where GH_FOV has been declared as a global variable.
        // Finally, pass the result into projection matrix.

        float aspect = (float)w / h;
        float fovY = radians(GH_FOV);  // 將 GH_FOV(45度) 轉換為弧度
        float f_n = far - near;
        
        Matrix4 proj = Matrix4.Identity();
        // 建立透視投影矩陣
        proj.m[0] = (1.0f / (aspect * tan(fovY/2))); // scale x
        proj.m[5] = 1.0f / tan(fovY/2);              // scale y
        proj.m[10] = -(far + near) / f_n;            // scale z
        proj.m[11] = -2.0f * far * near / f_n;       // translation z
        proj.m[14] = -1.0f;                          // perspective
        proj.m[15] = 0.0f;                           // w
        
        projection = proj;

    }

    void setPositionOrientation(Vector3 pos, float rotX, float rotY) {

    }

    void setPositionOrientation(Vector3 pos, Vector3 lookat) {
        // TODO HW3
        // This function takes two parameters, which are the position of the camera and
        // the point the camera is looking at.
        // We uses topVector = (0,1,0) to calculate the eye matrix.
        // Finally, pass the result into worldView matrix.

        // 1. 計算相機座標系的三個基向量
        Vector3 forward = Vector3.sub(lookat, pos);   // 計算前方向量
        forward = forward.unit_vector();              // 正規化
        
        Vector3 up = new Vector3(0, 1, 0);           // 世界座標的上方向
        Vector3 right = Vector3.cross(forward, up);   // 計算右方向量
        right = right.unit_vector();                 // 正規化
        
        up = Vector3.cross(right, forward);          // 重新計算上方向量使其垂直
        
        // 2. 建立視圖矩陣
        Matrix4 view = Matrix4.Identity();
        
        // 2.1 旋轉部分 (基向量作為矩陣的行)
        view.m[0] = right.x;
        view.m[1] = up.x;
        view.m[2] = -forward.x;
        view.m[3] = 0;
        
        view.m[4] = right.y;
        view.m[5] = up.y;
        view.m[6] = -forward.y;
        view.m[7] = 0;
        
        view.m[8] = right.z;
        view.m[9] = up.z;
        view.m[10] = -forward.z;
        view.m[11] = 0;
        
        // 2.2 平移部分
        view.m[3] = -Vector3.dot(right, pos);
        view.m[7] = -Vector3.dot(up, pos);
        view.m[11] = Vector3.dot(forward, pos);
        
        worldView = view;
    }
}
