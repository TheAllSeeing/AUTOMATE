from math import pi
from math import e
from math import factorial as fact
import cmath

i = complex(0,1)

class Point:
        def __init__(self, x, y):
                self.x = x
                self.y = y

        def distance(self, p):
                if type(p) == Point:
                        return pythagoras((self.x - p.x), (self.y-p.y))
                elif type(p) == Line:
                        return p.distance(self)

class Line:
        @classmethod
        def points(cls, p1: Point, p2: Point, std: float=0):
                _slope = slope(p1, p2)
                offset = p2.y - _slope * p2.x
                return Line(_slope, offset)

        @classmethod
        def slope_point(cls, m: float, point: Point):
                return Line(m, m*point.x-point.y)
        @classmethod
        def standart(cls, A: float, B: float, C: float):
                return Line(-A/B, -C/B)


        def __init__(self, m, b):
                self.slope = m
                self.offset = b

        def std(self, mult: float=1):
                assert mult != 0
                A = mult * self.slope
                B = -mult
                _B, operator_B = _reduce_minus(B)
                C = mult * self.offset
                _C, operator_C = _reduce_minus(C)
                print(str(A) + 'x '  + operator_B + ' ' + str(_B) + 'y ' + operator_C + ' ' + str(_C) + ' = 0')
                return lambda x, y: A*x + B*y + C == 0

        def basic(self):
                _offset, operator = _reduce_minus(self.offset)
                print(str(self.slope) + 'x ' + operator + ' ' + str(_offset))
                return lambda x: self.slope*x + self.offset

        def perp(self):
                return Line(-self.slope**(-1), self.offset)
        
        def parallel(self, _offset: float):
                return Line(self.slope, self.offset + _offset)
        def distance(self, p: Point):
                A = -self.slope
                B = 1
                C = -self.offset
                return abs(A*p.x + B*p.y + C)/sqrt(A**2+B**2)

def _wrap_cmath_1(func):
        def res(arg):
                result = func(arg)
                if result.imag == 0:
                        return result.real
                return result

        return res

sin = _wrap_cmath_1(cmath.sin)
asin = _wrap_cmath_1(cmath.asin)
cos = _wrap_cmath_1(cmath.cos)
acos = _wrap_cmath_1(cmath.acos)
tan = _wrap_cmath_1(cmath.tan)
atan = _wrap_cmath_1(cmath.atan)
sqrt = _wrap_cmath_1(cmath.sqrt)


def log(value, base=e):
        res = cmath.log(value, base)
        if res.imag == 0:
                return res.real
        else:
                return res

ln = lambda x: log(x)

def slope(p1: Point, p2: Point):
        return (p2.y-p1.y)/(p2.x-p1.x)

def _reduce_minus(num: float):
        if num < 0:
                num = -num
                operator = '-'
        else:
                operator = '+'
        return num, operator


def solve(a, b, c):
        disc = b**2 - 4*a*c
        if disc < 0:
                print("No Solution Found")
                return None
        elif disc == 0:
                return -b/(2*a)
        else:
                return ((-b+disc**0.5)/(2*a), (-b-disc**0.5)/(2*a))

def csolve(a, b, c):
        disc = b**2 - 4*a*c
        return ((-b+disc**0.5)/(2*a), (-b-disc**0.5)/(2*a))


def pythagoras(a, b, hypotenous=True):
        if hypotenous:
                return sqrt(a**2 + b**2)
        else:
                return sqrt(a**2 - b**2)
        

def choose(n, k):
        return fact(n)/(fact(k)*fact(n-k))

def binom(n, k, p):
        return choose(n, k) * p**k * (1-p)**(n-k)

def deg(rad):
        return rad / pi * 180

def rad(deg):
        return deg / 180 *pi

def exp(x, detail=100, level=0):
        if level == detail:
                return x**level/fact(level)
        else:
                return x**level/fact(level) + exp(x, detail, level + 1)

def non_recursive_exp(x, detail=100):
        return sum([x**n/fact(n) for n in range(detail)])

def absqr(x, k):
        a = round(x**2, 4)
        b = round(2*x*k, 4)
        c = round(k**2, 4)
        print(str(a)+'*x^2 ' + str(b)+'*x ' + str(c))
        return lambda x: a*x**2 + b*x + c

class phys:
        g = 10
        G = 6.7e-11
        k = 9e9
        e = 1.6e-19


        def Ug(M, m, r):
                return - G * M * m / r
        def Fg(M, m, r):
                return G*M*m / r**2

        def Ek(m, v):
                return m * v**2 / 2

        def Usp(k, l):
                return k * l**2 / 2

        def aR(v, r):
                return v**2 / r

class mth:
        def test_trig(factor, formula, minval, maxval):
                print("x(k): " + formula('k'))
                valids = []
                for k in range(-3, 4):
                        print('\n\n')
                        print("k = " + k)
                        print("x(" + k + ") = " + formula('k'))
                        x = factor(k)
                        print("x = " + x)
                        if x < minval:
                                print(x + " < " + minval)
                                print('k = ' + k + ' is invalid.')
                        elif x > maxval:
                                print(x + " > " + maxval)
                                print('k = ' + k + ' is invalid.')
                        else:
                                print(minval + ' < ' + x + ' < '+ maxval)
                                print ('k = ' + k + ' is valid.')
                                valids.append(k)
                print('\n\nFinal ks: '  + str(valids))

        def derive(function: callable,accuracy: float=50000):
                dx = 1/accuracy
                return lambda x: ( function(x + dx) - function(x) ) / dx
