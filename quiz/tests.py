from django.test import SimpleTestCase, TestCase
from django.urls import reverse


class HealthTest(SimpleTestCase):
    def test_healthz(self):
        response = self.client.get(reverse('healthz'))
        self.assertEqual(response.status_code, 200)
        self.assertEqual(response.content, b'ok')


class HomeTest(TestCase):
    def test_home_renders(self):
        response = self.client.get(reverse('home'))
        self.assertEqual(response.status_code, 200)
        self.assertContains(response, 'TLOQ')
