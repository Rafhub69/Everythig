class NPendulum {

  ArrayList<PVector> position;
  PVector origin = new PVector(width / 2, height/3); 
  float g = 0.4905, k = 0, N = 0;

  //FloatList  NLength = new FloatList();
  //FloatList  NMas = new FloatList();
  //FloatList  NVelocity = new FloatList();
  //FloatList  NAcceleration = new FloatList();
  //FloatList  NAngle = new FloatList();

  NPendulum(float k_, float N_)
  {
    k = k_;
    N = N_;
  }

  float calculations(int k, float N, float[] NLength, float[][] theta, float[] mas, float g)
  {

    float[] sum = {0, 0, 0, 0, 0};

    for (int n = k; n <= N; n ++) {
      sum[1] = 0;

      for (int i = 1; i <= n; i ++) {
        sum[1] += NLength[i] * ( theta[2][i]*cos(theta[0][i] )- sq(theta[1][i])*sin(theta[0][i]));
      }

      sum[0] += mas[n] * sum[1];
    }

    for (int n = k; n <= N; i ++) {
      sum[3] = 0;

      for (int i = k; i <= N; i ++) {
        sum[3] += NLength[i] * (theta[2][i]*sin(theta[0][i]) + sq(theta[1][i])*cos(theta[0][i]));
      }

      sum[2] += mas[n] * sum[3];
    }

    for (int n = k; n <= N; n ++) {
      sum[4] += mas[n];
    }

    return NLength[k] * ( cos(theta[0][k]) * sum[0] + sin(theta[0][k])*(sum[2]+g*sum[4]));
  }

  void drawing()
  {
  }
}
