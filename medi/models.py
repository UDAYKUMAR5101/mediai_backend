from django.db import models
from django.contrib.auth.models import User

class Profile(models.Model):
    GENDER_CHOICES = [
        ('F', 'Female'),
    ]

    user = models.OneToOneField(User, on_delete=models.CASCADE)
    age = models.PositiveIntegerField(null=True, blank=True)
    image = models.ImageField(upload_to='profile_images/', null=True, blank=True)
    gender = models.CharField(max_length=1, choices=GENDER_CHOICES, null=True, blank=True)
    date_of_birth = models.DateField(null=True, blank=True)
    notes = models.TextField(null=True, blank=True)

    def __str__(self):
        return self.user.username


class Symptoms(models.Model):
    PHYSICAL_ACTIVITY_CHOICES = [
        ('low', 'Low'),
        ('moderate', 'Moderate'),
        ('high', 'High')
    ]

    user = models.ForeignKey(User, on_delete=models.CASCADE)

    age = models.PositiveIntegerField(null=True, blank=True)
    menopausal_status = models.CharField(max_length=10, null=True, blank=True)
    family_history = models.CharField(max_length=3, null=True, blank=True)
    bmi = models.FloatField(null=True, blank=True)
    menarche_age = models.PositiveIntegerField(null=True, blank=True)
    breastfeeding_history = models.CharField(max_length=3, null=True, blank=True)
    alcohol_consumption = models.CharField(max_length=3, null=True, blank=True)
    hormonal_treatment_history = models.CharField(max_length=3, null=True, blank=True)
    physical_activity = models.CharField(max_length=10, choices=PHYSICAL_ACTIVITY_CHOICES, null=True, blank=True)
    breast_pain = models.CharField(max_length=3, null=True, blank=True)
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"Symptoms of {self.user.username}"

class MedicalImage(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    image = models.ImageField(upload_to='medical_images/')
    uploaded_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"{self.user.username} - {self.image.name}"