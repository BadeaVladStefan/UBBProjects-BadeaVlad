using System;
using System.Collections.Generic;
using Lab_4.Implementation;
using Lab4.Implementation;

namespace Lab4
{
    class Program
    {
        static void Main()
        {
            var hosts = new List<string> {
                "www.glumite.ro",
                "www.cs.ubbcluj.ro/~rlupsa/edu/pdp/lab-4-futures-continuations.html",
                "www.emag.ro"
            };

            DirectCallBack.Run(hosts);
            //TaskMechanism.Run(hosts);
            //AsyncAwaitTasksMechanism.Run(hosts);
        }
    }
}
