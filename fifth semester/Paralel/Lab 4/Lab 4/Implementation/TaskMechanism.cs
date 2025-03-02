using Lab_4.Utils;
using Lab4.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Sockets;
using System.Net;
using System.Text;
using System.Threading;
using System.Threading.Tasks;

namespace Lab_4.Implementation
{
    internal class TaskMechanism
    {
        private static List<string> HOSTS;
        private static string response = String.Empty;

        public static void Run(List<string> hostnames)
        {
            HOSTS = hostnames;

            for (var i = 0; i < HOSTS.Count; i++)
            {
                DoStart(i);
            }
        }

        private static void DoStart(object idObject)
        {
            var clientIndex = (int)idObject;
            StartClient(HOSTS[clientIndex], clientIndex);
            Thread.Sleep(2000);
        }

        private static void StartClient(string serverHost, int clientId)
        {
            var hostInfo = Dns.GetHostEntry(serverHost.Split('/')[0]);
            var ipAddress = hostInfo.AddressList[0];
            var remoteEndpoint = new IPEndPoint(ipAddress, 80);

            var clientSocket = new Socket(ipAddress.AddressFamily, SocketType.Stream, ProtocolType.Tcp);

            var connectionState = new StateObject
            {
                workSocket = clientSocket,
                hostname = serverHost.Split('/')[0],
                endpointPath = serverHost.Contains("/") ? serverHost.Substring(serverHost.IndexOf("/")) : "/",
                remoteEndpoint = remoteEndpoint,
                clientID = clientId
            };

            Task connectTask = Connect(connectionState);
            connectionState.connectDone.WaitOne();

            var url = HttpUtils.parseURL(serverHost);

            Task sendTask = Send(connectionState, string.Format("GET /{0} HTTP/1.1\r\nHOST: {1}\r\n\r\n", url.Item2, url.Item1));
            connectionState.sendDone.WaitOne();

            Task receiveTask = Receive(connectionState);
            connectionState.receiveDone.WaitOne();

            Task.WaitAll(connectTask, sendTask, receiveTask);

            Console.WriteLine("{0} - Response received : \n{1}", connectionState.clientID, response);

            clientSocket.Shutdown(SocketShutdown.Both);
            clientSocket.Close();
        }

        private static Task Connect(StateObject connectionState)
        {
            return Task.Factory.StartNew(() =>
            {
                connectionState.workSocket.BeginConnect(connectionState.remoteEndpoint, OnConnect, connectionState);
            });
        }

        private static void OnConnect(IAsyncResult ar)
        {
            var connectionState = (StateObject)ar.AsyncState;
            var clientSocket = connectionState.workSocket;

            clientSocket.EndConnect(ar);

            Console.WriteLine("Socket connected to {0}", clientSocket.RemoteEndPoint.ToString());

            connectionState.connectDone.Set();
        }

        private static Task Receive(StateObject connectionState)
        {
            return Task.Factory.StartNew(() =>
            {
                connectionState.workSocket.BeginReceive(connectionState.receiveBuffer, 0, StateObject.BUFFER_SIZE, 0,
                    ReceiveCallback, connectionState);
            });
        }

        private static void ReceiveCallback(IAsyncResult ar)
        {
            try
            {
                StateObject connectionState = (StateObject)ar.AsyncState;
                Socket clientSocket = connectionState.workSocket;

                int bytesReceived = clientSocket.EndReceive(ar);

                if (bytesReceived > 0)
                {
                    connectionState.responseContent.Append(Encoding.ASCII.GetString(connectionState.receiveBuffer, 0, bytesReceived));

                    if (!HttpUtils.responseHeaderFullyObtained(connectionState.responseContent.ToString()))
                    {
                        clientSocket.BeginReceive(connectionState.receiveBuffer, 0, StateObject.BUFFER_SIZE, 0,
                            new AsyncCallback(ReceiveCallback), connectionState);
                    }
                    else
                    {
                        var responseBody = HttpUtils.getResponseBody(connectionState.responseContent.ToString());
                        var contentLength = HttpUtils.getContentLength(connectionState.responseContent.ToString());

                        if (contentLength > responseBody.Length)
                        {
                            clientSocket.BeginReceive(connectionState.receiveBuffer, 0, StateObject.BUFFER_SIZE, 0,
                                new AsyncCallback(ReceiveCallback), connectionState);
                        }
                        else
                        {
                            if (connectionState.responseContent.Length > 1)
                            {
                                response = connectionState.responseContent.ToString();
                            }

                            connectionState.receiveDone.Set();
                        }
                    }
                }
                else
                {
                    if (connectionState.responseContent.Length > 1)
                    {
                        response = connectionState.responseContent.ToString();
                    }

                    connectionState.receiveDone.Set();
                }
            }
            catch (Exception e)
            {
                Console.WriteLine(e.ToString());
            }
        }

        private static Task Send(StateObject connectionState, String requestData)
        {
            return Task.Factory.StartNew(() =>
            {
                byte[] byteData = Encoding.ASCII.GetBytes(requestData);

                connectionState.workSocket.BeginSend(byteData, 0, byteData.Length, 0,
                    new AsyncCallback(SendCallback), connectionState);
            });
        }

        private static void SendCallback(IAsyncResult ar)
        {
            try
            {
                StateObject connectionState = (StateObject)ar.AsyncState;

                int bytesSent = connectionState.workSocket.EndSend(ar);
                Console.WriteLine("{0} - Sent {1} bytes to server.", connectionState.clientID, bytesSent);

                connectionState.sendDone.Set();
            }
            catch (Exception e)
            {
                Console.WriteLine(e.ToString());
            }
        }
    }
}
