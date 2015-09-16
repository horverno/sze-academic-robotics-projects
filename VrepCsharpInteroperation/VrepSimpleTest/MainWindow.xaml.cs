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
using remoteApiNETWrapper;

namespace VrepSimpleTest
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        /// <summary>
        /// True - connected to V-REP; False - not connected
        /// </summary>
        bool _connected = false;
        /// <summary>
        /// V-REP connection ID
        /// </summary>
        int _clientID = -1; 
        public MainWindow()
        {
            InitializeComponent();
            stackControls.Visibility = Visibility.Hidden;
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
                    System.Diagnostics.Debug.WriteLine("Connected to V-REP");
                    buttonConnect.Background = Brushes.LightGreen;
                    _connected = true;
                    stackControls.Visibility = Visibility.Visible;
                    buttonConnect.Content = "Disconnect";
                }
                else // Connection trial failed
                {
                    System.Diagnostics.Debug.WriteLine("Error connecting to V-REP");
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
                System.Diagnostics.Debug.WriteLine("Disconnected from V-REP");
            }
        }
        private void buttonGetPos_Click(object sender, RoutedEventArgs e)
        {
            int handleNeo0, handleNeo1; // The handles for the robots
            float[] pos = new float[3]; // The position of the #0 robot relative to the #1 robot
            VREPWrapper.simxGetObjectHandle(_clientID, "neobotix#0", out handleNeo0, simx_opmode.oneshot_wait);
            System.Diagnostics.Debug.WriteLine("Handle neobotix#0: " + handleNeo0);
            VREPWrapper.simxGetObjectHandle(_clientID, "neobotix#1", out handleNeo1, simx_opmode.oneshot_wait);
            System.Diagnostics.Debug.WriteLine("Handle neobotix#1: " + handleNeo1);
            VREPWrapper.simxGetObjectPosition(_clientID, handleNeo0, handleNeo1, pos, simx_opmode.oneshot_wait);
            System.Diagnostics.Debug.WriteLine("x:{0:F4} y:{1:F4} z:{2:F4}", pos[2], pos[1], pos[0]);
            txtInfo.Text = String.Format("x:{0:F4} y:{1:F4} z:{2:F4}", pos[2], pos[1], pos[0]);
        }
        private void buttonScan_Click(object sender, RoutedEventArgs e)
        {

        }


    }
}
