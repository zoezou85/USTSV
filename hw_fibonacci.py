#python homework to creat a function to calculate Fibonacci number
def Fibonacci(n):   #the nth Fibonacci number
 Fibo_list=[0,0,1]
 if n==0:
    print('invalid input')
 elif n==1:
     return 0
 elif n==2:
     return 1
 elif n>3:
    for i in range(2,n):
        Fibo=Fibo_list[i-1]+Fibo_list[i]
        Fibo_list.append(Fibo)
    return Fibo_list[n]
