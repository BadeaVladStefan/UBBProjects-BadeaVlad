using System;
using System.Text.RegularExpressions;

namespace DataValidationModule
{
    public class DataValidator
    {

        public bool IsValidEmail(string email)
        {
            string pattern = @"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"; // (at least one valid char)@(at least one valid chars).(at least two valid chars)
            return Regex.IsMatch(email, pattern);
        }
        public bool IsValidPhoneNumber(string phoneNumber)
        {
            string[] patterns = {
                @"^\d{3}-\d{3}-\d{4}$",                            // ###-###-####
                @"^\(\d{3}\) \d{3}-\d{4}$",                         // (###) ###-####
                @"^\d{3} \d{3} \d{4}$",                             // ### ### ####
                @"^\d{3}\.\d{3}\.\d{4}$",                           // ###.###.####
                @"^\d{10}$",                                         //#########
                @"^\+\d{1,2}\s?\d{3}-\d{3}-\d{4}$",                 // +## ###-###-####
                @"^\+\d{1,2}\s?\(\d{3}\)\s?\d{3}-\d{4}$",           // +## (###) ###-####
                @"^\+\d{1,2}\s?\d{3}\s?\d{3}\s?\d{4}$",             // +## ### ### ####
                @"^\+\d{1,2}\s?\d{3}\.\d{3}\.\d{4}$",               // +## ###.###.####
                @"^\+\d{1,2}\s?\d{10}$"                             // +## #########
            };
            foreach (string pattern in patterns)
            {
                if (Regex.IsMatch(phoneNumber, pattern))
                {
                    return true;
                }
            }

            return false;
        }
        public bool IsValidDate(string date)
        {
            string[] patterns = {
                @"^\d{2} \d{2} \d{4}$",            // dd mm yyyy
                @"^\d{2}-\d{2}-\d{4}$",            // dd-mm-yyyy
                @"^\d{2}/\d{2}/\d{4}$",            // dd/mm/yyyy
                @"^\d{2}\.\d{2}\.\d{4}$",           // dd.mm.yyyy
                @"^\d{2}\:\d{2}\:\d{4}$"            //dd:mm:yyyy
            };
            foreach (string pattern in patterns)
            {
                if (Regex.IsMatch(date, pattern))
                {
                    string[] components = date.Split(new char[] { '-', '/', '.', ' ', ':' });
                    int day = int.Parse(components[0]);
                    int month = int.Parse(components[1]);
                    int year = int.Parse(components[2]);

                    if (day < 1 || day > 31 || month < 1 || month > 12 || year < 1900 || year > 2500)
                    {
                        return false;
                    }
                    if(month == 2)
                    {
                        if(year % 4 == 0)
                        {
                            if(day > 29)
                            {
                                return false;
                            }
                        }
                        else
                        {
                            if(day > 28)
                            {
                                return false;
                            }
                        }
                    }
                    if(month%2 == 0 && day > 30)
                    {
                        return false;
                    }
                    return true; 
                }
            }

            return false; 
        }
        public string SanitizeInput(string input)
        {
            string pattern = @"[^a-zA-Z0-9.\-_\/\:@\+ ]";
            return Regex.Replace(input, pattern, "");
        }
    }
}
