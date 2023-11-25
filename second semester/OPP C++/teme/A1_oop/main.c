/*
Problem 4
a.Compute the approximated value of square root of a positive real number. The precision is provided by the user.
b. Given a vector of numbers, find the longest contiguous subsequence such that the difference of any two consecutive
elements is a prime number.
*/

#include <stdio.h>

#include <stdbool.h>

void print_menu()
{
    printf("What should the program do? \n");
    printf("1.Read a vector \n");
    printf("2.Generate the first n prime numbers (n is a given natural number). \n");
    printf("3.Given a vector of numbers, find the longest contiguous subsequence such that any two consecutive elements are relatively prime. \n");
    printf("4.Quit \n");
}

void read_array(int array[256],int *number_of_elements)
{
/*
* intput: an empty array and the number of elements of that array which is equal to 0
* output: an array with an number of elements non zero
* Does not return anything, just modifies the given parameters
*/
printf("Please enter the number of elements of the array \n");
scanf_s("%d", &*number_of_elements);
printf("Please enter the elements of the array\n");
for (int i = 0; i < *number_of_elements; i++)
scanf_s("%d", &array[i]);
}
bool is_prime(int number)
{
    /*
    * input: int number - the number we check if it is prime
    * output/return: bool type - true if prime, false otherwise
    */
    if (number <= 1)
        return false;
    for (int i = 2; i < number; i++)
        if (number % i == 0)
            return false;
    return true;
}
bool gcd(int number_a, int number_b)
{
    /*
     * input: 2 ints
     * output: true or false; T - if the gcd(n_1,n_2) = 1, F - otherwise
     */
    while (number_a != number_b)
        if (number_a < number_b)
            number_b = number_b - number_a;
        else
            number_a = number_a - number_b;
    if (number_a == 1)
        return true;
    return false;
}


void max_sub_array(int array[256], int size)
{
    /*
     * Input: an array and it's size
     * Output: prints the searched elements
     */
    int max=0,start=0,end=0,current=0,current_start=0;
    for (int i =0;i<size-1;i++)
    {
        if (gcd(array[i],array[i+1])==true)
        {
            current++;
            if(current>max)
            {
                max=current;
                start=current_start;
                end=i+1;
            }

        }
        else{
            current=0;
            current_start=i+1;
        }
    }
    for(int i=start;i<=end;i++)
        printf("%d",array[i]);
    printf("\n");
}
int main()
{

    int menu_flag = 1,option,array[256],number_elements_array = 0;
    int number_p1;
    while (menu_flag == 1)
    {
        print_menu();
        scanf_s("%d", &option);
        if (option == 1)
        {
            read_array(array, &number_elements_array);
            for (int i = 0; i < number_elements_array; i++)
            {
                printf("%d", array[i]);
                printf(" ");
            }
            printf("\n");

        }
        else if (option == 2)
        {
            printf("How many prime numbers do you want to generate?");
            scanf_s("%d", &number_p1);
            int counter = 0,number=2;
            while (counter < number_p1)
            {
                if (is_prime(number) == true)
                {
                    printf("%d ", number);
                    counter++;
                }
                number++;
            }
        }
        else if (option == 3)
        {
            if (number_elements_array == 0)
                printf("Your vector is empty!\n");
            else
            {
                max_sub_array(array, number_elements_array);
            }
        }
        else if (option == 4)
        {
            printf("Goodbye!");
            menu_flag = 0;
        }
        else
            while (option < 1 || option>4)
        scanf_s("%d", &option);

    }
}

