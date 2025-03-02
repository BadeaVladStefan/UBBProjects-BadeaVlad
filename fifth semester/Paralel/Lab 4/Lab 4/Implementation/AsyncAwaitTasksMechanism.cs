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
    internal class AsyncAwaitTasksMechanism
    {
        private static List<string> hostnamesList;
        private static List<Task> taskList;
        private static string fullResponse = String.Empty;

        public static void Run(List<string> inputHostnames)
        {
            hostnamesList = inputHostnames;
            taskList = new List<Task>();

            for (var index = 0; index < hostnamesList.Count; index++)
            {
                taskList.Add(Task.Factory.StartNew(DoStart, index));
            }
            Task.WaitAll(taskList.ToArray());
        }

        private static void DoStart(object taskId)
        {
            var clientId = (int)taskId;
            StartClient(hostnamesList[clientId], clientId);
        }

        private static async void StartClient(string hostname, int clientId)
        {
            var dnsHostEntry = Dns.GetHostEntry(hostname.Split('/')[0]);
            var serverIPAddress = dnsHostEntry.AddressList[0];
            var serverEndpoint = new IPEndPoint(serverIPAddress, 80);

            var clientSocket = new Socket(serverIPAddress.AddressFamily, SocketType.Stream, ProtocolType.Tcp);

            var connectionState = new StateObject
            {
                workSocket = clientSocket,
                hostname = hostname.Split('/')[0],
                endpointPath = hostname.Contains("/") ? hostname.Substring(hostname.IndexOf("/")) : "/",
                remoteEndpoint = serverEndpoint,
                clientID = clientId
            };

            var parsedUrl = HttpUtils.parseURL(hostname);

            await Connect(connectionState);

            await Send(connectionState, string.Format("GET /{0} HTTP/1.1\r\nHOST: {1}\r\n\r\n", parsedUrl.Item2, parsedUrl.Item1));

            await Receive(connectionState);

            Console.WriteLine("{0} - Response received : \n{1}", connectionState.clientID, fullResponse);

            clientSocket.Shutdown(SocketShutdown.Both);
            clientSocket.Close();
        }

        private static async Task Connect(StateObject connectionState)
        {
            connectionState.workSocket.BeginConnect(connectionState.remoteEndpoint, OnConnect, connectionState);
            await Task.FromResult(connectionState.connectDone.WaitOne());
        }

        private static void OnConnect(IAsyncResult asyncResult)
        {
            var connectionState = (StateObject)asyncResult.AsyncState;
            var clientSocket = connectionState.workSocket;

            clientSocket.EndConnect(asyncResult);

            Console.WriteLine("Socket connected to {0}", clientSocket.RemoteEndPoint.ToString());

            connectionState.connectDone.Set();
        }

        private static async Task Receive(StateObject connectionState)
        {
            connectionState.workSocket.BeginReceive(connectionState.receiveBuffer, 0, StateObject.BUFFER_SIZE, 0,
                ReceiveCallback, connectionState);
            await Task.FromResult(connectionState.receiveDone.WaitOne());
        }

        private static void ReceiveCallback(IAsyncResult asyncResult)
        {
            try
            {
                StateObject connectionState = (StateObject)asyncResult.AsyncState;
                Socket clientSocket = connectionState.workSocket;

                int bytesRead = clientSocket.EndReceive(asyncResult);

                if (bytesRead > 0)
                {
                    connectionState.responseContent.Append(Encoding.ASCII.GetString(connectionState.receiveBuffer, 0, bytesRead));

                    if (!HttpUtils.responseHeaderFullyObtained(connectionState.responseContent.ToString()))
                    {
                        clientSocket.BeginReceive(connectionState.receiveBuffer, 0, StateObject.BUFFER_SIZE, 0,
                            ReceiveCallback, connectionState);
                    }
                    else
                    {
                        var responseBodyContent = HttpUtils.getResponseBody(connectionState.responseContent.ToString());

                        var contentLength = HttpUtils.getContentLength(connectionState.responseContent.ToString());

                        if (contentLength > responseBodyContent.Length)
                        {
                            clientSocket.BeginReceive(connectionState.receiveBuffer, 0, StateObject.BUFFER_SIZE, 0,
                                ReceiveCallback, connectionState);
                        }
                        else
                        {
                            if (connectionState.responseContent.Length > 1)
                            {
                                fullResponse = connectionState.responseContent.ToString();
                            }

                            connectionState.receiveDone.Set();
                        }
                    }
                }
                else
                {
                    if (connectionState.responseContent.Length > 1)
                    {
                        fullResponse = connectionState.responseContent.ToString();
                    }
                    connectionState.receiveDone.Set();
                }
            }
            catch (Exception exception)
            {
                Console.WriteLine(exception.ToString());
            }
        }

        private static async Task Send(StateObject connectionState, String requestData)
        {
            byte[] requestBytes = Encoding.ASCII.GetBytes(requestData);

            connectionState.workSocket.BeginSend(requestBytes, 0, requestBytes.Length, 0,
                SendCallback, connectionState);

            await Task.FromResult(connectionState.sendDone.WaitOne());
        }

        private static void SendCallback(IAsyncResult asyncResult)
        {
            try
            {
                StateObject connectionState = (StateObject)asyncResult.AsyncState;

                int bytesSent = connectionState.workSocket.EndSend(asyncResult);
                Console.WriteLine("{0} - Sent {1} bytes to server.", connectionState.clientID, bytesSent);

                connectionState.sendDone.Set();
            }
            catch (Exception exception)
            {
                Console.WriteLine(exception.ToString());
            }
        }
    }
}
