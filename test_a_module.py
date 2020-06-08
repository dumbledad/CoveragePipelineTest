import unittest
import a_module as am


class TestAModule(unittest.TestCase):

    def test_is_this_1(self): #pragma: no cover
        self.assertTrue(am.is_this_1(2)) # Will fail

if __name__ == '__main__':
    unittest.main()
