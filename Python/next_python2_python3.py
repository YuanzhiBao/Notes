

'''
python2 has builtin function called next()
python3 OTOH change next() to __next__()
Which means as a generator next() works in
python2 __next__ works in python3
but next(iterator) will automatically try to 
find the right function, so it will work 
as long as the function implemented.
'''
class Nextest(object):
    def __init__(self, x):
        self.x = x
        self.n = 0
        self.l = len(self.x)

    def __iter__(self):
        return self

    # In python3 
    # def __next__(self)
    def next(self):
        if self.n < self.l - 1:
            self.n += 1
            return self.x[self.n]
        else:
            raise StopIteration

if __name__ == '__main__':
    a = [3,30,34,5,9]
    net = Nextest(a)
    # python2 
    net.next()
    x = iter(net)
    next(x)
    for i in net:
        print(i)

    # python3
    net.__next__()
