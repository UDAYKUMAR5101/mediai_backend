from django.db import models
from django.contrib.auth.models import User

class UserData(models.Model):
    GENDER_CHOICES = [
        ('M', 'Male'),
        ('F', 'Female'),
        ('O', 'Other'),
    ]

    user = models.OneToOneField(User, on_delete=models.CASCADE, related_name="userdata")
    fullname = models.CharField(max_length=255, blank=True, null=True)
    age = models.PositiveIntegerField(blank=True, null=True)
    gender = models.CharField(max_length=1, choices=GENDER_CHOICES, blank=True, null=True)
    date_of_birth = models.DateField(blank=True, null=True)
    note = models.TextField(blank=True, null=True)
    image = models.ImageField(upload_to='user_images/', blank=True, null=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return f"Data for {self.user.username}"


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
    breast_cancer = models.CharField(max_length=3, null=True, blank=True)
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"Symptoms of {self.user.username}"

class MedicalImage(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    image = models.ImageField(upload_to='medical_images/')
    uploaded_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"{self.user.username} - {self.image.name}"

# password_reset/models.py
from django.db import models
from django.utils import timezone
from datetime import timedelta

class PasswordResetOTP(models.Model):
    email = models.EmailField()
    otp = models.CharField(max_length=6)
    created_at = models.DateTimeField(auto_now_add=True)

    def is_expired(self):
        return timezone.now() > self.created_at + timedelta(minutes=10)  # OTP valid for 10 minutes

    def __str__(self):
        return f"{self.email} - {self.otp}"
     
from django.db import models
from django.contrib.auth.models import User

class PredictionResult(models.Model):
    RISK_CHOICES = [
        ('low', 'Low'),
        ('moderate', 'Moderate'),
        ('high', 'High')
    ]

    MODE_CHOICES = [
        ('symptoms', 'Symptoms'),
        ('image', 'Image')
    ]

    user = models.ForeignKey(User, on_delete=models.CASCADE)
    risk_level = models.CharField(max_length=20, choices=RISK_CHOICES)
    prediction_percentage = models.FloatField()
    mode = models.CharField(max_length=20, choices=MODE_CHOICES)
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"{self.user.username} - {self.risk_level} - {self.mode}"
from django.db import models
from django.contrib.auth import get_user_model

User = get_user_model()

class RiskAssessment(models.Model):
    RISK_CHOICES = [
        ('Low', 'Low'),
        ('Moderate', 'Moderate'),
        ('High', 'High'),  # fallback
    ]

    user = models.ForeignKey(User, on_delete=models.CASCADE)
    risk_level = models.CharField(max_length=20, choices=RISK_CHOICES)
    prediction_percentage = models.FloatField()
    mode = models.CharField(max_length=20)  # 'symptoms' or 'image'
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"{self.user.email} - {self.risk_level} ({self.mode})"


from django.db import models
from django.contrib.auth.models import User

class SymptomsRiskAssessment(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    risk_level = models.CharField(max_length=20)
    prediction_percentage = models.FloatField()
    mode = models.CharField(default='symptoms', max_length=20)
    created_at = models.DateTimeField(auto_now_add=True)

class ImageRiskAssessment(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    risk_level = models.CharField(max_length=20)
    prediction_percentage = models.FloatField()
    image = models.ImageField(upload_to='risk_images/')
    mode = models.CharField(default='image', max_length=20)
    created_at = models.DateTimeField(auto_now_add=True)

from django.db import models
from django.contrib.auth.models import User

class RiskAssessment(models.Model):
    MODE_CHOICES = [
        ('symptoms', 'Symptoms'),
        ('image', 'Image'),
    ]

    user = models.ForeignKey(User, on_delete=models.CASCADE, related_name="risk_assessments")
    risk_level = models.CharField(max_length=50)
    prediction_percentage = models.DecimalField(max_digits=5, decimal_places=2)
    mode = models.CharField(max_length=20, choices=MODE_CHOICES)
    symptoms = models.TextField(blank=True, null=True)  # for symptoms-based
    image = models.ImageField(upload_to="history_images/", blank=True, null=True)  # for image-based
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"{self.user.username} - {self.mode} - {self.risk_level}"

