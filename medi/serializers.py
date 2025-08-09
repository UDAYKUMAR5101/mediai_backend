from rest_framework import serializers
from django.contrib.auth.models import User
class RegisterSerializer(serializers.ModelSerializer):
    password = serializers.CharField(write_only=True)

    class Meta:
        model = User
        fields = ['username', 'email', 'password']

    def validate(self, data):
        errors = {}

        if User.objects.filter(username=data['username']).exists():
            errors['username'] = "Username already exists."

        if User.objects.filter(email=data['email']).exists():
            errors['email'] = "Email already exists."

        if errors:
            raise serializers.ValidationError(errors)  # Raise both errors 

        return data

    def create(self, validated_data):
        return User.objects.create_user(
            username=validated_data['username'],
            email=validated_data['email'],
            password=validated_data['password']
        )

from django.contrib.auth import get_user_model
from rest_framework import serializers

User = get_user_model()

class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ['id', 'username', 'email']
from rest_framework import serializers
from .models import UserData

class UserDataSerializer(serializers.ModelSerializer):
    class Meta:
        model = UserData
        fields = ['fullname', 'age', 'gender', 'date_of_birth', 'note', 'image', 'updated_at']




from rest_framework import serializers
from .models import Symptoms

class SymptomsSerializer(serializers.ModelSerializer):
    class Meta:
        model = Symptoms
        exclude = ['user', 'created_at']  # user is set automatically

    def validate(self, data):
        # Normalize inputs (like "yes", "Yes", "YES" → "Yes")
        for key, value in data.items():
            if isinstance(value, str):
                data[key] = value.strip().lower().capitalize()

        return data

# serializers.py
from rest_framework import serializers
from .models import MedicalImage

class MedicalImageSerializer(serializers.ModelSerializer):
    class Meta:
        model = MedicalImage
        fields = ['id', 'image', 'uploaded_at']
        read_only_fields = ['uploaded_at']

from rest_framework import serializers
from django.contrib.auth.models import User

class ChangePasswordSerializer(serializers.Serializer):
    old_password = serializers.CharField(required=True)
    new_password = serializers.CharField(required=True, min_length=8)

    def validate_new_password(self, value):
        if len(value) < 8:
            raise serializers.ValidationError("Password must be at least 8 characters long.")
        return value

from rest_framework import serializers
from .models import PredictionResult

class PredictionResultSerializer(serializers.ModelSerializer):
    class Meta:
        model = PredictionResult
        fields = '__all__'


from rest_framework import serializers
from .models import RiskAssessment

class RiskAssessmentSerializer(serializers.ModelSerializer):
    class Meta:
        model = RiskAssessment
        fields = '__all__'


from rest_framework import serializers
from .models import SymptomsRiskAssessment, ImageRiskAssessment

class UnifiedRiskSerializer(serializers.Serializer):
    id = serializers.IntegerField()
    risk_level = serializers.CharField()
    prediction_percentage = serializers.FloatField()
    mode = serializers.CharField()
    created_at = serializers.DateTimeField()
    image = serializers.SerializerMethodField()

    def get_image(self, obj):
        # Only ImageRiskAssessment has an image
        if hasattr(obj, 'image') and obj.image:
            request = self.context.get('request')
            return request.build_absolute_uri(obj.image.url)
        return None


from rest_framework import serializers
from .models import RiskAssessment

class RiskAssessmentSerializer(serializers.ModelSerializer):
    class Meta:
        model = RiskAssessment
        fields = ['id', 'risk_level', 'prediction_percentage', 'mode', 'symptoms', 'image', 'created_at']
        read_only_fields = ['id', 'created_at']
