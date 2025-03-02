using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Lab_4.Utils
{
    internal class HttpUtils
    {
        public static readonly int HTTP_PORT = 80;

        public static Tuple<string, string> parseURL(string url)
        {
            var hostname = url.Split('/')[0];
            var endpointPath = string.Join("/", url.Split('/').Skip(1).ToArray());

            return new Tuple<string, string>(hostname, endpointPath);
        }

        public static string createGetRequestString(string url)
        {
            Tuple<string, string> parsedUrl = parseURL(url);
            return string.Format("GET /{0} HTTP/1.1\r\nHOST: {1}\r\n\r\n", parsedUrl.Item2, parsedUrl.Item1);
        }

        public static string getResponseBody(string httpResponseContent)
        {
            var httpResponseSections = httpResponseContent.Split(new[] { "\r\n\r\n" }, StringSplitOptions.RemoveEmptyEntries);

            return httpResponseSections.Length > 1 ? httpResponseSections[1] : "";
        }

        public static bool responseHeaderFullyObtained(string httpResponseContent)
        {
            return httpResponseContent.Contains("\r\n\r\n");
        }

        public static int getContentLength(string httpResponseContent)
        {
            var httpResponseLines = httpResponseContent.Split('\r', '\n');

            foreach (var httpResponseLine in httpResponseLines)
            {
                var headerKeyValue = httpResponseLine.Split(':');

                if (headerKeyValue[0].CompareTo("Content-Length") == 0)
                {
                    return int.Parse(headerKeyValue[1]);
                }
            }

            return 0;
        }
    }
}
