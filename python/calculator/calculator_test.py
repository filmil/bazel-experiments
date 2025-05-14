import unittest

# Take note: the library target is //calculator:calculator, so import needs to
# refer to both.
from calculator.calculator import Calculator

class TestSum(unittest.TestCase):

  def test_sum(self):
    calc = Calculator()
    self.assertEqual(calc.add(1, 2), 3)

if __name__ =="__main__":
  unittest.main()

