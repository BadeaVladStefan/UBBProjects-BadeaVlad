cmake_minimum_required(VERSION 3.22)
project(A23_OOP C)

set(CMAKE_C_STANDARD 11)

add_executable(A23_OOP main.c Country.c Country.h DynamicArray.c DynamicArray.h Repository.c Repository.h Service.c Service.h Test.c Test.h Ui.c Ui.h)
