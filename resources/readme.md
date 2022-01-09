=> csv_matter.csv contains 8000 samples of data. In the given csv file you will have the data for three different axes i.e. x, y and z but you only need to use the first 1000 samples of data to complete the task (more than 1000 samples may lead to plot unjustified graphs) (sampling time of the data is 0.01 second). The file contains raw output data received from MPU 6050. You need to refer to the datasheet for MPU6050 to know how the data is oriented in MPU6050.

csv_matter.csv file contains column-wise data for different registers as described below:
Colum no. in CSV file | Register name of mpu 6050 | Decimal address of the register
-- | -- | --
1 | ACCEL_XOUT_H | 59
2 | ACCEL_XOUT_L | 60
3 | ACCEL_YOUT_H | 61
4 | ACCEL_YOUT_L | 62
5 | ACCEL_ZOUT_H | 63
6 | ACCEL_ZOUT_L | 64
7 | GYRO_XOUT_H | 67
8 | GYRO_XOUT_L | 68
9 | GYRO_YOUT_H | 69
10 | GYRO_YOUT_L | 70
11 | GYRO_ZOUT_H | 71
12 | GYRO_ZOUT_L | 72

</div></b>
