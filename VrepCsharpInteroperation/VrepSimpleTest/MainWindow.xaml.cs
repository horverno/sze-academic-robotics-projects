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

namespace VrepSimpleTest
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        bool _connected = false;
        int _clientID = 0;
        public MainWindow()
        {
            InitializeComponent();
            stackControls.Visibility = Visibility.Hidden;
        }

        private void buttonConnect_Click(object sender, RoutedEventArgs e)
        {
            if (!_connected)
            {
                _clientID = remoteApiNETWrapper.VREPWrapper.simxStart("127.0.0.1", 19997, true, true, 5000, 5);
                if (_clientID != -1)
                {
                    System.Diagnostics.Debug.WriteLine("Connected to V-REP");
                    buttonConnect.Background = Brushes.LightGreen;
                    _connected = true;
                    stackControls.Visibility = Visibility.Visible;
                    buttonConnect.Content = "Disconnect";
                }
                else
                {
                    System.Diagnostics.Debug.WriteLine("Error connecting to V-REP");
                    MessageBox.Show("Error connecting to V-REP :(");
                    buttonConnect.Background = Brushes.OrangeRed;
                    _connected = false;
                    stackControls.Visibility = Visibility.Hidden;
                }
            }
            else
            {
                remoteApiNETWrapper.VREPWrapper.simxFinish(_clientID);
                buttonConnect.Background = Brushes.OrangeRed;
                buttonConnect.Content = "Reconnect";
                _connected = false;
                stackControls.Visibility = Visibility.Hidden;
                System.Diagnostics.Debug.WriteLine("Disconnected from V-REP");
            }
        }
        private void buttonGetPos_Click(object sender, RoutedEventArgs e)
        {
            int handleNeo0, handleNeo1;
            float[] pos = new float[3];
            remoteApiNETWrapper.VREPWrapper.simxGetObjectHandle(_clientID, "neobotix#0", out handleNeo0, remoteApiNETWrapper.simx_opmode.oneshot_wait);
            System.Diagnostics.Debug.WriteLine("Handle neobotix#0: " + handleNeo0);
            remoteApiNETWrapper.VREPWrapper.simxGetObjectHandle(_clientID, "neobotix#1", out handleNeo1, remoteApiNETWrapper.simx_opmode.oneshot_wait);
            System.Diagnostics.Debug.WriteLine("Handle neobotix#1: " + handleNeo1);
            remoteApiNETWrapper.VREPWrapper.simxGetObjectPosition(_clientID, handleNeo0, handleNeo1, pos, remoteApiNETWrapper.simx_opmode.oneshot_wait);
            System.Diagnostics.Debug.WriteLine("Position: x: " + pos[2] + " y: " + pos[1] + " z: " + pos[0]);
            txtInfo.Text = "x: " + pos[2] + " y: " + pos[1] + " z: " + pos[0];
        }
        private void buttonScan_Click(object sender, RoutedEventArgs e)
        {

        }


    }
}
