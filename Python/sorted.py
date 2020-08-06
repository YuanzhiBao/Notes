#!/bin/python3

'''
sorted(iterable: Iterable, key: Optional[Callable[]])
As in sorted, fist param is a Iterable type, second is a key
The value of the key parameter should be a function that takes a single argument and returns a key to use for sorting purposes. 
This technique is fast because the key function is called exactly once for each input record. 
'''


''' 
 LargerNumber is inhertance from str, which take a single argument as it mentioned above
 AS sort In python3, sort uses the lt by default, if you don't override it, it will use the defaulted __lt__
 So modify __gt__ only does not change the default sort at all.
'''

# https://leetcode.com/problems/largest-number/solution/ is a good example for this
# https://docs.python.org/3/howto/sorting.html is docs from community to using sort
class LargerNumber(str):
    def __lt__(x, y):
        return x + y > y + x

if __name__ == '__main__':
    a = [3,30,34,5,9]
    print(tuple.__dict__)
    print(str.__dict__)
    b = map(str, a)
    print(b)
    str.lower('A')
    c = sorted(b, key = LargerNumber)
    print(c)

    def build(x, y):
        return lambda z: x*x + y*y + z
    x = build(5, 10) 
    print(x)
    x(20)
    c = sorted(b.items(), key = lambda x: x)
    a = [4,1,3]
    a = [(3,1), (1,4)]
    a.sort(key = lambda x: x[0])
