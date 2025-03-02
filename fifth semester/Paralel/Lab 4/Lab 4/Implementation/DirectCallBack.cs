using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Sockets;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using Lab_4.Utils;
using Lab4.Model;

namespace Lab4.Implementation
{
    internal static class DirectCallBack
    {
        private static List<string> hostList;
        private static string responseContent = String.Empty;

        public static void Run(List<string> hostnames)
        {
            hostList = hostnames;

            for (var index = 0; index < hostList.Count; index++)
            {
                StartConnection(index);
            }
        }

        private static void StartConnection(object indexObject)
        {
            var index = (int)indexObject;
            ConnectToClient(hostList[index], index);

            Thread.Sleep(2000);
        }

        private static void ConnectToClient(string host, int clientId)
        {
            var hostDetails = Dns.GetHostEntry(host.Split('/')[0]);
            var ipAddress = hostDetails.AddressList[0];
            var endpoint = new IPEndPoint(ipAddress, 80);

            var clientSocket = new Socket(ipAddress.AddressFamily, SocketType.Stream, ProtocolType.Tcp);

            var connectionState = new StateObject
            {
                workSocket = clientSocket,
                hostname = host.Split('/')[0],
                endpointPath = host.Contains("/") ? host.Substring(host.IndexOf("/")) : "/",
                remoteEndpoint = endpoint,
                clientID = clientId
            };

            connectionState.workSocket.BeginConnect(connectionState.remoteEndpoint, OnConnectionEstablished, connectionState);
            connectionState.connectDone.WaitOne();

            var urlDetails = HttpUtils.parseURL(host);

            SendRequest(connectionState, string.Format("GET /{0} HTTP/1.1\r\nHOST: {1}\r\n\r\n", urlDetails.Item2, urlDetails.Item1));
            connectionState.sendDone.WaitOne();

            ReceiveResponse(connectionState);
            connectionState.receiveDone.WaitOne();

            Console.WriteLine("{0} - Response received : \n{1}", connectionState.clientID, responseContent);

            clientSocket.Shutdown(SocketShutdown.Both);
            clientSocket.Close();
        }

        private static void OnConnectionEstablished(IAsyncResult asyncResult)
        {
            var connectionState = (StateObject)asyncResult.AsyncState;
            var clientSocket = connectionState.workSocket;

            clientSocket.EndConnect(asyncResult);

            Console.WriteLine("Socket connected to {0}", clientSocket.RemoteEndPoint.ToString());

            connectionState.connectDone.Set();
        }

        private static void ReceiveResponse(StateObject connectionState)
        {
            try
            {
                connectionState.workSocket.BeginReceive(connectionState.receiveBuffer, 0, StateObject.BUFFER_SIZE, 0,
                    new AsyncCallback(ReceiveDataCallback), connectionState);
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.ToString());
            }
        }

        private static void ReceiveDataCallback(IAsyncResult asyncResult)
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
                            new AsyncCallback(ReceiveDataCallback), connectionState);
                    }
                    else
                    {
                        var bodyContent = HttpUtils.getResponseBody(connectionState.responseContent.ToString());

                        var contentLengthValue = HttpUtils.getContentLength(connectionState.responseContent.ToString());

                        if (contentLengthValue > bodyContent.Length)
                        {
                            clientSocket.BeginReceive(connectionState.receiveBuffer, 0, StateObject.BUFFER_SIZE, 0,
                                new AsyncCallback(ReceiveDataCallback), connectionState);
                        }
                        else
                        {
                            if (connectionState.responseContent.Length > 1)
                            {
                                responseContent = connectionState.responseContent.ToString();
                            }

                            connectionState.receiveDone.Set();
                        }
                    }
                }
                else
                {
                    if (connectionState.responseContent.Length > 1)
                    {
                        responseContent = connectionState.responseContent.ToString();
                    }

                    connectionState.receiveDone.Set();
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.ToString());
            }
        }

        private static void SendRequest(StateObject connectionState, string data)
        {
            byte[] byteData = Encoding.ASCII.GetBytes(data);

            connectionState.workSocket.BeginSend(byteData, 0, byteData.Length, 0,
                new AsyncCallback(SendDataCallback), connectionState);
        }

        private static void SendDataCallback(IAsyncResult asyncResult)
        {
            try
            {
                StateObject connectionState = (StateObject)asyncResult.AsyncState;

                int bytesSent = connectionState.workSocket.EndSend(asyncResult);
                Console.WriteLine("{0} - Sent {1} bytes to server.", connectionState.clientID, bytesSent);

                connectionState.sendDone.Set();
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.ToString());
            }
        }
    }
}
