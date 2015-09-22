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
        /// <summary>
        /// The handles for the robots
        /// </summary>
        int _handleNeo0, _handleNeo1;
        /// <summary>
        /// The handles for the motors
        /// </summary>
        int _handleLeftMotor0, _handleRightMotor0;

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
                    buttonConnect.Background = Brushes.LightGreen;
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
                    if (_handleNeo0 == 0 && _handleNeo1 == 0)
                        MessageBox.Show("Connected, but no neobotix robot found");

                }
                else // Connection trial failed
                {
                    Debug.WriteLine("Error connecting to V-REP");
                    MessageBox.Show("Error connecting to V-REP :(");
                    buttonConnect.Background = Brushes.OrangeRed;
                    _connected = false;
                    stackControls.Visibility = Visibility.Hidden;
                }
            }
            else // If connected - try to disconnect 
            {
                VREPWrapper.simxFinish(_clientID);
                buttonConnect.Background = Brushes.OrangeRed;
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
            //VREPWrapper.simxGetObjectPosition(_clientID, _handleNeo0, _handleNeo1, _pos, simx_opmode.oneshot_wait);
            //Debug.WriteLine("x:{0:F4} y:{1:F4} z:{2:F4}", _pos[2], _pos[1], _pos[0]);
            //txtInfo.Text = String.Format("x:{0:F4} y:{1:F4} z:{2:F4}", _pos[2], _pos[1], _pos[0]);
        }

        public void upd()
        {
            int handleNeo0, handleNeo1; // The handles for the robots
            float[] pos = new float[3]; // The position of the #0 robot relative to the #1 robot
            while (_updatePos) // todo
            {
                VREPWrapper.simxGetObjectPosition(_clientID, _handleNeo0, _handleNeo1, _pos, simx_opmode.oneshot_wait);
                PositionString = String.Format("x:{0:F4} y:{1:F4} z:{2:F4}", _pos[2], _pos[1], _pos[0]);
                DrawSomething(); // todo
                Thread.Sleep(400);
            }
        }

        private void buttonFwd_Click(object sender, RoutedEventArgs e)
        {
            VREPWrapper.simxSetJointTargetVelocity(_clientID, _handleLeftMotor0, 10, simx_opmode.oneshot_wait);
            VREPWrapper.simxSetJointTargetVelocity(_clientID, _handleRightMotor0, 10, simx_opmode.oneshot_wait);
        }

        private void buttonBck_Click(object sender, RoutedEventArgs e)
        {
            VREPWrapper.simxSetJointTargetVelocity(_clientID, _handleLeftMotor0, -10, simx_opmode.oneshot_wait);
            VREPWrapper.simxSetJointTargetVelocity(_clientID, _handleRightMotor0, -10, simx_opmode.oneshot_wait);
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
                MessageBox.Show("Exception occured");
            }

            if (_connected)
                VREPWrapper.simxFinish(_clientID);
        }

        void DrawSomething()
        {
            //todo
            //canvScan.Children.Add(new Line
            //{
            //    Stroke = System.Windows.Media.Brushes.DarkGray,
            //    StrokeThickness = 2,
            //    X1 = 150,
            //    Y1 = 150,
            //    X2 = (int)(160),
            //    Y2 = (int)(160)
            //});
        }

        protected virtual void OnPropertyChanged(string property)
        {
            if (PropertyChanged != null)
                PropertyChanged(this, new PropertyChangedEventArgs(property));
        }

        #region INotifyPropertyChanged Members

        public event PropertyChangedEventHandler PropertyChanged;

        #endregion
    }
}
