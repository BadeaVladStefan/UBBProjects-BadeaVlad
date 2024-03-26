using System;
using System.Diagnostics;

namespace DataValidationModule.Tests
{
    public class DataValidatorTests
    {
        public static void Main(string[] args)
        {
            DataValidatorTests validatorTests = new DataValidatorTests();
            DataValidator validator = new DataValidator();

            while (true)
            {
                Console.WriteLine("Select an option:");
                Console.WriteLine("1. Check if email is valid");
                Console.WriteLine("2. Check if phone number is valid");
                Console.WriteLine("3. Check if date is valid");
                Console.WriteLine("4. Sanitize string");
                Console.WriteLine("5. Run tests");
                Console.WriteLine("6. Exit");

                int option;
                if (!int.TryParse(Console.ReadLine(), out option))
                {
                    Console.WriteLine("Invalid option. Please enter a number.");
                    continue;
                }

                switch (option)
                {
                    case 1:
                        Console.Write("Enter an email address: ");
                        string email = Console.ReadLine();
                        Console.WriteLine($"Is the email '{email}' valid? {validator.IsValidEmail(email)}");
                        break;
                    case 2:
                        Console.Write("Enter a phone number: ");
                        string phoneNumber = Console.ReadLine();
                        Console.WriteLine($"Is the phone number '{phoneNumber}' valid? {validator.IsValidPhoneNumber(phoneNumber)}");
                        break;
                    case 3:
                        Console.Write("Enter a date (dd mm yyyy): ");
                        string date = Console.ReadLine();
                        Console.WriteLine($"Is the date '{date}' valid? {validator.IsValidDate(date)}");
                        break;
                    case 4:
                        Console.Write("Enter a string to sanitize: ");
                        string input = Console.ReadLine();
                        string sanitizedString = validator.SanitizeInput(input);
                        Console.WriteLine($"Sanitized string: {sanitizedString}");
                        break;
                    case 5:
                        TestDataValidator();
                        break;
                    case 6:
                        Console.WriteLine("Exiting program.");
                        return;
                    default:
                        Console.WriteLine("Invalid option. Please select a valid option.");
                        break;
                }
            }
        }

        public static void TestDataValidator()
        {
            DataValidator validator = new DataValidator();

            Console.WriteLine("Testing IsValidEmail method:");
            Debug.Assert(validator.IsValidEmail("test@example.com") == true);
            Debug.Assert(validator.IsValidEmail("test.test@example.com") == true);
            Debug.Assert(validator.IsValidEmail(".t.@e.co") == true);
            Debug.Assert(validator.IsValidEmail("test@example") == false);
            Debug.Assert(validator.IsValidEmail("test.example@") == false);
            Debug.Assert(validator.IsValidEmail("test.example@com") == false);
            Debug.Assert(validator.IsValidEmail("invalidemail@") == false);
            Debug.Assert(validator.IsValidEmail("invalidemail@.com") == false);
            Debug.Assert(validator.IsValidEmail("invalidemail.com") == false);
            Debug.Assert(validator.IsValidEmail("invalidemail@com") == false);
            Debug.Assert(validator.IsValidEmail("") == false);
            Debug.Assert(validator.IsValidEmail("test!@exa%m*p$le.com()+") == false);
            Console.WriteLine("Passed");

            Console.WriteLine("Testing IsValidPhoneNumber method:");
            Debug.Assert(validator.IsValidPhoneNumber("1234567890") == true);
            Debug.Assert(validator.IsValidPhoneNumber("123-456-7890") == true);
            Debug.Assert(validator.IsValidPhoneNumber("(123) 456-7890") == true);
            Debug.Assert(validator.IsValidPhoneNumber("123.456.7890") == true);
            Debug.Assert(validator.IsValidPhoneNumber("+1 123-456-7890") == true);
            Debug.Assert(validator.IsValidPhoneNumber("+12 (123) 456-7890") == true);
            Debug.Assert(validator.IsValidPhoneNumber("+12 123.456.7890") == true);
            Debug.Assert(validator.IsValidPhoneNumber("+12 1234567890") == true);
            Debug.Assert(validator.IsValidPhoneNumber("") == false); 
            Debug.Assert(validator.IsValidPhoneNumber("1234") == false); 
            Debug.Assert(validator.IsValidPhoneNumber("12345678901") == false); 
            Debug.Assert(validator.IsValidPhoneNumber("123-45-67890") == false); 
            Debug.Assert(validator.IsValidPhoneNumber("(123 456-7890") == false);
            Debug.Assert(validator.IsValidPhoneNumber("123-456-78a0") == false); 
            Console.WriteLine("Passed");


            Console.WriteLine("Testing IsValidDate method:");
            Debug.Assert(validator.IsValidDate("20 02 2022") == true);
            Debug.Assert(validator.IsValidDate("20-02-2022") == true); 
            Debug.Assert(validator.IsValidDate("20/02/2022") == true); 
            Debug.Assert(validator.IsValidDate("20.02.2022") == true); 
            Debug.Assert(validator.IsValidDate("20:02:2022") == true); 
            Debug.Assert(validator.IsValidDate("00 02 2022") == false); 
            Debug.Assert(validator.IsValidDate("32 02 2022") == false); 
            Debug.Assert(validator.IsValidDate("20 00 2022") == false); 
            Debug.Assert(validator.IsValidDate("20 13 2022") == false); 
            Debug.Assert(validator.IsValidDate("20 02 1899") == false);
            Debug.Assert(validator.IsValidDate("20 02 2501") == false); 
            Debug.Assert(validator.IsValidDate("31 04 2022") == false); 
            Debug.Assert(validator.IsValidDate("29 02 2021") == false); 
            Console.WriteLine("Passed");


            Console.WriteLine("Testing SanitizeInput method:");
            Debug.Assert(validator.SanitizeInput("") == "");
            Debug.Assert(validator.SanitizeInput("abc") == "abc");
            Debug.Assert(validator.SanitizeInput("abc123") == "abc123");
            Debug.Assert(validator.SanitizeInput("abc!@#") == "abc@");
            Debug.Assert(validator.SanitizeInput("abc!@#123") == "abc@123");
            Debug.Assert(validator.SanitizeInput("abc!@#123$%^") == "abc@123");
            Debug.Assert(validator.SanitizeInput("¡Hola!") == "Hola");
            Debug.Assert(validator.SanitizeInput("你好بالعالمदुनिया👋") == "");
            Console.WriteLine("Passed");

        }
    }
}
