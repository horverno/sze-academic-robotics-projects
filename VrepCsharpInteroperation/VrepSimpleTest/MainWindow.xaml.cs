using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;
using System.Diagnostics;
using System.ComponentModel;
using System.Threading;
using remoteApiNETWrapper;

namespace VrepSimpleTest
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window, INotifyPropertyChanged
    {
        /// <summary>
        /// True - connected to V-REP; False - not connected
        /// </summary>
        bool _connected = false;
        /// <summary>
        /// V-REP connection ID
        /// </summary>
        int _clientID = -1;
        bool _updatePos = false;
        float[] _pos = new float[3];
        Thread _up;
        private string _posString = "position";
        private string _wheelString = "wheel";
        private double _wheelX = 150;
        private double _wheelY = 100;
        public string _test = "";
        /// <summary>
        /// The handles for the robots
        /// </summary>
        int _handleNeo0, _handleNeo1;
        /// <summary>
        /// The handles for the sensors 
        /// </summary>
        int _handleSick0;
        /// <summary>
        /// The handles for the motors
        /// </summary>
        IntPtr _signalValuePtr;
        int _signalLength;
        int _handleLeftMotor0, _handleRightMotor0;
        float _posLeftMotor0;
        float[,] _laserScannerData;


        public MainWindow()
        {
            InitializeComponent();
            stackControls.Visibility = Visibility.Hidden;
        }


        public string PositionString
        {
            get { return _posString; }
            set
            {
                _posString = value;
                OnPropertyChanged("PositionString");
            }
        }

        public string WheelString
        {
            get { return _wheelString; }
            set
            {
                _wheelString = value;
                OnPropertyChanged("WheelString");
            }
        }

        public double WheelX
        {
            get { return _wheelX; }
            set
            {
                _wheelX = value;
                OnPropertyChanged("WheelX");
            }
        }

        public double WheelY
        {
            get { return _wheelY; }
            set
            {
                _wheelY = value;
                OnPropertyChanged("WheelY");
            }
        }

        /// <summary>
        /// Connect or disconnect from V-REP
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void buttonConnect_Click(object sender, RoutedEventArgs e)
        {
            if (!_connected) // If not connected - try to connect
            {
                try
                {
                    _clientID = VREPWrapper.simxStart("127.0.0.1", 19997, true, true, 5000, 5);
                }
                catch (DllNotFoundException ex)
                {
                    MessageBox.Show("remoteApi.dll missing");
                }

                if (_clientID != -1) // Successfully connected to V-REP
                {
                    Debug.WriteLine("Connected to V-REP");
                    buttonConnect.Background = Brushes.LightSeaGreen;
                    _connected = true;
                    stackControls.Visibility = Visibility.Visible;
                    buttonConnect.Content = "Disconnect";
                    VREPWrapper.simxGetObjectHandle(_clientID, "neobotix#0", out _handleNeo0, simx_opmode.oneshot_wait);
                    Debug.WriteLine("Handle neobotix#0: " + _handleNeo0);
                    VREPWrapper.simxGetObjectHandle(_clientID, "neobotix#1", out _handleNeo1, simx_opmode.oneshot_wait);
                    Debug.WriteLine("Handle neobotix#1: " + _handleNeo1);
                    VREPWrapper.simxGetObjectHandle(_clientID, "wheel_left#0", out _handleLeftMotor0, simx_opmode.oneshot_wait);
                    Debug.WriteLine("Handle left motor #0: " + _handleLeftMotor0);
                    VREPWrapper.simxGetObjectHandle(_clientID, "wheel_right#0", out _handleRightMotor0, simx_opmode.oneshot_wait);
                    Debug.WriteLine("Handle right motor #0: " + _handleRightMotor0);
                    VREPWrapper.simxGetObjectHandle(_clientID, "SICK_S300_fast#0", out _handleSick0, simx_opmode.oneshot_wait);
                    if (_handleNeo0 == 0 && _handleNeo1 == 0)
                        MessageBox.Show("Connected, but no neobotix robot found");

                }
                else // Connection trial failed
                {
                    Debug.WriteLine("Error connecting to V-REP");
                    MessageBox.Show("Error connecting to V-REP :(");
                    buttonConnect.Background = Brushes.IndianRed;
                    _connected = false;
                    stackControls.Visibility = Visibility.Hidden;
                }
            }
            else // If connected - try to disconnect 
            {
                VREPWrapper.simxFinish(_clientID);
                buttonConnect.Background = Brushes.IndianRed;
                buttonConnect.Content = "Reconnect";
                _connected = false;
                stackControls.Visibility = Visibility.Hidden;
                Debug.WriteLine("Disconnected from V-REP");
                _updatePos = false;
            }
        }
        private void buttonGetPos_Click(object sender, RoutedEventArgs e)
        {
            if (!_updatePos)
            {
                _up = new Thread(new ThreadStart(upd));
                _up.Start();
                buttonGetPos.Content = "Getting position...";
            }
            else
            {
                buttonGetPos.Content = "Get position";
            }
            _updatePos = !_updatePos;
        }
        private void buttonScan_Click(object sender, RoutedEventArgs e)
        {
            int i;
            // reading the laser scanner stream 
            VREPWrapper.simxReadStringStream(_clientID, "measuredDataAtThisTime0", ref _signalValuePtr, ref _signalLength, simx_opmode.streaming);
            //Debug.WriteLine(String.Format("test: {0:X8} {1:D} {2:X8}", _signalValuePtr, _signalLength, _signalValuePtr+_signalLength));
            float[] f = new float[685 * 3];
            if (_signalLength >= f.GetLength(0))
            {
                _laserScannerData = new float[3, f.GetLength(0) / 3];
                PointCollection laserPointCollection = new PointCollection();
                Polyline laserScannerLine = new Polyline(); // polyline for laser scanner data display
                laserScannerLine = new Polyline();
                laserScannerLine.Stroke = System.Windows.Media.Brushes.DarkMagenta;
                laserScannerLine.StrokeThickness = 2;                

                // todo read the latest stream (this is not the latest)
                unsafe
                {
                    float* pp = (float*)(_signalValuePtr).ToPointer();
                    //Debug.WriteLine("pp: " + *pp);
                    for (i = 0; i < f.GetLength(0); i++)
                            f[i] = (float)*pp++; // pointer to float array 
                }
                i = 0;
                // reshaping the 1D [3*685] data to 2D [3, 685] > x, y, z coordinates
                for (i = 0; i < f.GetLength(0); i++)
                    if (!(Math.Abs((float)f[i]) < 0.000001))
                        _laserScannerData[i % 3, i / 3] = (float)f[i];
                for (i = 0; i < _laserScannerData.GetLength(1); i++)
                {
                    //Debug.WriteLine(_laserScannerData[0, i] + ";\t" + _laserScannerData[1, i] + ";\t" + _laserScannerData[2, i]);
                    if (!(Math.Abs((float)_laserScannerData[0, 1]) < 0.001))
                        laserPointCollection.Add(new Point(_laserScannerData[0, i] * 40 + 50, _laserScannerData[1, i] * 40 + 150));
                }
                //Debug.WriteLine("laserPointCollection count: " + laserPointCollection.Count);
                laserScannerLine.Points = laserPointCollection; // adds the data to the polyline
                canvScan.Children.Add(laserScannerLine); // displays the polyline on the cansvas
                //Debug.Write("--end scanner--");
            }
        }

        public void upd()
        {
            float[] pos = new float[3]; // The position of the #0 robot relative to the #1 robot
            while (_updatePos) // todo
            {
                VREPWrapper.simxGetObjectPosition(_clientID, _handleNeo0, _handleNeo1, _pos, simx_opmode.oneshot_wait);
                VREPWrapper.simxGetJointPosition(_clientID, _handleLeftMotor0, ref _posLeftMotor0, simx_opmode.oneshot_wait);
                PositionString = String.Format("x:{0:F4} y:{1:F4} z:{2:F4}", _pos[2], _pos[1], _pos[0]);
                WheelString = String.Format("wheel:{0:F3}", _posLeftMotor0);
                WheelX = (Math.Cos(_posLeftMotor0) * 100) + 150;
                WheelY = (Math.Sin(_posLeftMotor0) * 100) + 150;
                //Debug.WriteLine("x:{0:F4} y:{1:F4}", WheelX, WheelY);
                Thread.Sleep(400);
            }
        }

        private void buttonFwd_Click(object sender, RoutedEventArgs e)
        {
            VREPWrapper.simxSetJointTargetVelocity(_clientID, _handleLeftMotor0, 2, simx_opmode.oneshot_wait);
            VREPWrapper.simxSetJointTargetVelocity(_clientID, _handleRightMotor0, 2, simx_opmode.oneshot_wait);
        }

        private void buttonBck_Click(object sender, RoutedEventArgs e)
        {
            VREPWrapper.simxSetJointTargetVelocity(_clientID, _handleLeftMotor0, -2, simx_opmode.oneshot_wait);
            VREPWrapper.simxSetJointTargetVelocity(_clientID, _handleRightMotor0, -2, simx_opmode.oneshot_wait);
        }

        private void buttonStop_Click(object sender, RoutedEventArgs e)
        {
            VREPWrapper.simxSetJointTargetVelocity(_clientID, _handleLeftMotor0, 0, simx_opmode.oneshot_wait);
            VREPWrapper.simxSetJointTargetVelocity(_clientID, _handleRightMotor0, 0, simx_opmode.oneshot_wait);
        }

        private void buttonRight_Click(object sender, RoutedEventArgs e)
        {
            VREPWrapper.simxSetJointTargetVelocity(_clientID, _handleLeftMotor0, 10, simx_opmode.oneshot_wait);
            VREPWrapper.simxSetJointTargetVelocity(_clientID, _handleRightMotor0, -10, simx_opmode.oneshot_wait);
        }

        private void buttonLeft_Click(object sender, RoutedEventArgs e)
        {
            VREPWrapper.simxSetJointTargetVelocity(_clientID, _handleLeftMotor0, -10, simx_opmode.oneshot_wait);
            VREPWrapper.simxSetJointTargetVelocity(_clientID, _handleRightMotor0, 10, simx_opmode.oneshot_wait);
        }

        private void Window_Closed(object sender, EventArgs e)
        {
            // todo
            _updatePos = false;
            try
            {
                if (_up.IsAlive)
                    _up.Abort();
            }
            catch (Exception ex)
            {
                //todo
                //MessageBox.Show("Exception occured");
            }

            if (_connected)
                VREPWrapper.simxFinish(_clientID);
        }

        protected virtual void OnPropertyChanged(string property)
        {
            if (PropertyChanged != null)
                PropertyChanged(this, new PropertyChangedEventArgs(property));
        }

        #region INotifyPropertyChanged Members

        public event PropertyChangedEventHandler PropertyChanged;

        #endregion

        private void buttonResetSim_Click(object sender, RoutedEventArgs e)
        {
            VREPWrapper.simxStopSimulation(_clientID, simx_opmode.oneshot_wait);
            Thread.Sleep(400);
            VREPWrapper.simxStartSimulation(_clientID, simx_opmode.oneshot_wait);
        }

        private void buttonClearCanvas_Click(object sender, RoutedEventArgs e)
        {
            canvScan.Children.Clear();
        }
    }
}
