/*
A string of numbers is given. Show the values in base 16 and base 2.
*/
#include <stdio.h>

int subprogramC(int a);

void DecimalToBinary(int num)
{
    if(num == 0)
    {
        printf("0");
        return;
    }
    int binaryNum[32];
    int i=0;
    
    while(num>0)
    {
        binaryNum[i++] = num%2;
        num = subprogramC(num);
    }
    
    for(int j = i-1;j>=0;j--)
        printf("%d",binaryNum[j]);
}

int main()
{
    int n=0;
    int a[50];
    int num;
    
    printf("how many numbers do you want to read \n");
    printf("n=");
    scanf("%d",&n);
    for(int i=0;i<n;i++)
        scanf("%d",&a[i]);
    for(int i=0;i<n;i++)
    {
        printf("the value of %d in hexa is: %X\n",a[i],a[i]);
        printf("the value of %d in binary is:",a[i]);
        num = a[i];
        DecimalToBinary(num);
        printf("\n");
         
    }
    return 0;
}